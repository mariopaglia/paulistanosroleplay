$(document).on('click', '#messages-openedchat-back', function(e) {
    $(".preload-messages-imessage").show();
    $.post('http://ps_phone/GetMessages', JSON.stringify({}), function(messages) {
        PS.Phone.Functions.LoadMessages(messages);
    });
    OpenedChatData.messages = null;
    $(".messages-openedchat").animate({
        left: -35 + "vh"
    }, 200, function() {
        $(".messages-openedchat").css({ "display": "none" });
    });
});

$(document).on('click', '.messages-openedchat .text-info', function(e) {
    e.preventDefault();

    var message = $(".messages-openedchat .publisher-input").val();

    var phone = OpenedChatData.messagesdata.phone;
    var number = OpenedChatData.messagesdata.number;

    if (message !== null && message !== undefined && message !== "") {

        $.post('http://ps_phone/SendNewMessage', JSON.stringify({
            phone: phone,
            number: number,
            message: message,
            type: "message",
        }), function(messages) {
            verifyopenchatmessage();
            $(".messages-openedchat .publisher-input").val('');
        });

        $('.phone-containter .phone').animate({ scrollTop: 9999 }, 1);

    } else {
        PS.Phone.Notifications.Add("fas fa-comment", "iMessage", "Você não pode enviar uma mensagem em branco!", "#25D366", 1750);
    }
});

$(document).on('click', '.message-shared-location', function(e) {
    e.preventDefault();
    var messageCoords = {}
    messageCoords.x = $(this).data('x');
    messageCoords.y = $(this).data('y');

    $.post('http://ps_phone/SharedLocationMessage', JSON.stringify({
        coords: messageCoords,
    }))
});

// $(document).on('keypress', function(e) {
//     if (OpenedChatData.message !== null) {
//         if (e.which === 13) {

//             var message = $(".messages-openedchat .publisher-input").val();

//             var phone = OpenedChatData.messagesdata.phone;
//             var number = OpenedChatData.messagesdata.number;

//             if (message !== null && message !== undefined && message !== "") {
//                 $.post('http://ps_phone/SendNewMessage', JSON.stringify({
//                     phone: phone,
//                     number: number,
//                     message: message,
//                     type: "message",
//                 }), function(messages) {
//                     verifyopenchatmessage();
//                     $(".messages-openedchat .publisher-input").val('');
//                 });

//                 $('.phone-containter .phone').animate({ scrollTop: 9999 }, 1);
//             } else {
//                 PS.Phone.Notifications.Add("fas fa-comment", "iMessage", "Você não pode enviar uma mensagem em branco!", "#25D366", 1750);
//             }
//         }
//     }
// });

$(document).on('click', '.messages-openedchat .send-location', function(e) {
    e.preventDefault();

    var phone = OpenedChatData.messagesdata.phone;
    var number = OpenedChatData.messagesdata.number;

    $.post('http://ps_phone/SendNewMessage', JSON.stringify({
        phone: phone,
        number: number,
        message: "location",
        type: "location",
    }), function(messages) {
        if (messages) {
            verifyopenchatmessage();
        }
    });

    $('.phone-containter .phone').animate({ scrollTop: 9999 }, 1);
});


$(document).on('click', '.messages-openedchat .file-group', function(e) {
    e.preventDefault();


    var phone = OpenedChatData.messagesdata.phone;
    var number = OpenedChatData.messagesdata.number;

    if (phone.length <= 0) {
        return false;
    }

    $.post('http://ps_phone/PostNewImage', JSON.stringify({}),
        function(url) {
            if (url.length > 0) {
                $.post('http://ps_phone/SendNewMessage', JSON.stringify({
                    phone: phone,
                    number: number,
                    message: url,
                    type: "message",
                }), function(messages) {
                    if (messages) {
                        verifyopenchatmessage();
                    }
                });

                $('.phone-containter .phone').animate({ scrollTop: 9999 }, 1);
            }
        },
    );

    PS.Phone.Functions.Close();
});

PS.Phone.Functions.LoadMessages = function(chats) {
    $(".messages-list").html("");

    var nchats = JSON.parse(chats);

    $.each(nchats, function(i, chat) {
        if (chat.contact) {
            var contact = chat.contact.charAt(0).toUpperCase();
            var name = chat.contact;
        } else {
            var contact = 'D';
            if (chat.phone != PS.Phone.Data.UserData.identity.phone) {
                var name = chat.number;
            } else {
                var name = chat.phone;
            }
        }

        if (chat.type == 'location') {
            var message = "Localização";
        } else if (chat.type == 'image') {
            var message = "Imagem";
        } else {
            var message = chat.message;
        }

        var time = new Date(chat.created);

        var hours = time.getHours();
        var minutes = time.getMinutes();

        if (hours < 10) {
            hours = "0" + hours
        }

        if (minutes < 10) {
            minutes = "0" + minutes
        }

        time = hours + ":" + minutes;

        var ChatElement = `<div class="messages-recent" id="messages-chat-${i}">
            <div class="messages-recent-image">${contact}</div>
            <div class="messages-recent-name">${name}</div>
            <div class="messages-recent-text">${message}</div>
            <div class="messages-recent-time">${time}</div>
        </div>`;

        $(".messages-list").append(ChatElement);
        $("#messages-chat-" + i).data('chatdata', chat);
    });

    $(".preload-messages-imessage").hide();
}

$(document).on('click', '.messages-recent', function(e) {
    e.preventDefault();

    var ChatId = $(this).attr('id');
    var ChatData = $("#" + ChatId).data('chatdata');
    var title = $("#" + ChatId + " .messages-recent-name").text();

    OpenedChatData.messagesdata = ChatData;

    if (ChatData.phone == PS.Phone.Data.UserData.identity.phone) {
        var type = 'phone';
        OpenedChatData.messages = ChatData.number;
    } else if (ChatData.number == PS.Phone.Data.UserData.identity.phone) {
        var type = 'number';
        OpenedChatData.messages = ChatData.phone;
    } else {
        var type = null;
        OpenedChatData.messages = null;
    }

    $.post('http://ps_phone/GetMessagesChat', JSON.stringify({
        type: type,
        phone: OpenedChatData.messages
    }), function(chat) {

        var messages = JSON.parse(chat);

        SetupMessages(messages);
    });

    $(".messages-openedchat").css({ "display": "block" });
    $(".messages-openedchat").animate({
        left: 0 + "vh"
    }, 200);

    $('.phone-containter .phone').animate({ scrollTop: 9999 }, 1);

    $(".messages-openedchat header h1").text(title);
});

function SetupMessages(cData) {
    if (cData) {

        $(".phone-containter .phone").html("");

        $.each(cData, function(i, chat) {
            var time = new Date(chat.created);

            var hours = time.getHours();
            var minutes = time.getMinutes();

            if (hours < 10) {
                hours = "0" + hours
            }

            if (minutes < 10) {
                minutes = "0" + minutes
            }

            time = hours + ":" + minutes;

            var Sender = "right";

            // console.log(PS.Phone.Data.UserData);
            if (chat.owner !== PS.Phone.Data.UserData.identity.phone) { Sender = "left"; }
            var MessageElement = '';
            if (chat.type == "message") {
                var message = chat.message;
                if (chat.message.indexOf(".jpg") != -1) {
                    MessageElement = "<div class='img'><img src='" + chat.message + "' class='" + Sender + "'/></div>"
                } else if (chat.message.indexOf(".png") != -1) {
                    MessageElement = "<div class='img'><img src='" + chat.message + "' class='" + Sender + "'/></div>"
                } else if (chat.message.indexOf(".gif") != -1) {
                    MessageElement = "<div class='img'><img src='" + chat.message + "' class='" + Sender + "'/></div>"
                } else {
                    MessageElement = `<div class="message ${Sender}">
                        <div class="message-text">${message}</div>
                    </div>`;

                }

            } else if (chat.type == "location") {
                var pos = JSON.parse(chat.message);
                MessageElement = `<div class="message ${Sender}">
                    <div class="message-text message-shared-location" data-x="${pos.x}" data-y="${pos.y}">
                    <span style="font-size: 1.2vh;"><i class="fas fa-thumbtack" style="font-size: 1vh;"></i> Localização</span>
                    </div>
                </div>`;
            }

            $(".phone-containter .phone").append(MessageElement);
        });
    }
}

setInterval(function() {
    verifyopenchatmessage();
}, 5000);

function verifyopenchatmessage() {
    var openedchat = $('.messages-openedchat').is(':visible');

    if (openedchat) {
        if (OpenedChatData.messagesdata.phone == PS.Phone.Data.UserData.identity.phone) {
            var type = 'phone';
            OpenedChatData.messages = OpenedChatData.messagesdata.number;
        } else if (OpenedChatData.messagesdata.number == PS.Phone.Data.UserData.identity.phone) {
            var type = 'number';
            OpenedChatData.messages = OpenedChatData.messagesdata.phone;
        } else {
            var type = null;
            OpenedChatData.messages = null;
        }

        $.post('http://ps_phone/GetMessagesChat', JSON.stringify({
            type: type,
            phone: OpenedChatData.messages
        }), function(chat) {

            var messages = JSON.parse(chat);

            SetupMessages(messages);
        });
    }
}