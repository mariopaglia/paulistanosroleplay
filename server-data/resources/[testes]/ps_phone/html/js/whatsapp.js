var WhatsappSearchActive = false;
var WhatsappMenuActive = false;
var OpenedChatPicture = null;
var audiochat, audiogroup = false;
var audiotimechat = 0;
var audiotimegroup = 0;
var recorder, gumStream;

$(document).ready(function() {
    $("#whatsapp-search-input").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $("#messages .whatsapp-chat").filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
        });
    });
});

$(document).on('click', '#whatsapp-search-chats', function(e) {
    e.preventDefault();

    if ($("#whatsapp-search-input").css('display') == "none") {
        $("#whatsapp-search-input").fadeIn(150);
        $(".whatsapp-header-footer").animate({
            height: 7.5 + "vh"
        }, 200);
        $(".whatsapp-tabs").animate({
            "margin-top": 12 + "vh"
        }, 200);
        WhatsappSearchActive = true;
    } else {
        $("#whatsapp-search-input").fadeOut(150);
        $(".whatsapp-header-footer").animate({
            height: 4.5 + "vh"
        }, 200);
        $(".whatsapp-tabs").animate({
            "margin-top": 9 + "vh"
        }, 200);
        WhatsappSearchActive = false;
    }
});


$(document).on('click', '#whatsapp-options-menus', function(e) {
    if ($(".whatsapp-menu").css('display') == "none") {
        $(".whatsapp-menu").fadeIn(150);
        WhatsappMenuActive = true;
    } else {
        $(".whatsapp-menu").fadeOut(150);
        WhatsappMenuActive = false;
    }
});

$(document).on('click', '.whatsapp-chat', function(e) {
    e.preventDefault();

    var ChatId = $(this).attr('id');
    var ChatData = $("#" + ChatId).data('chatdata');

    $.post('http://ps_phone/GetWhatsappChat', JSON.stringify({
        phone: ChatData.contact_phone
    }), function(chat) {

        ChatData.messages = JSON.parse(chat);

        SetupChatMessages(ChatData);
    });

    if (WhatsappSearchActive) {
        $("#whatsapp-search-input").fadeOut(150);
    }

    $(".whatsapp-openedchat").css({
        "display": "block"
    });
    $(".whatsapp-openedchat").animate({
        left: 0 + "vh"
    }, 200);

    $('.whatsapp-openedchat-messages').animate({
        scrollTop: 9999
    }, 150);

    if (OpenedChatPicture == null) {
        OpenedChatPicture = "./img/default.png";
        if (ChatData.avatar != null || ChatData.avatar != undefined || ChatData.avatar != "default.png") {
            OpenedChatPicture = ChatData.avatar
        }
        $(".whatsapp-openedchat-picture").css({
            "background-image": "url(" + OpenedChatPicture + ")"
        });
    }
});

$(document).on('click', '.whatsapp-group', function(e) {
    e.preventDefault();

    var ChatId = $(this).attr('id');
    var ChatData = $("#" + ChatId).data('groupdata');

    $.post('http://ps_phone/GetWhatsappGroupMessages', JSON.stringify({
        number: ChatData.number
    }), function(chat) {

        ChatData.messages = JSON.parse(chat);

        SetupGroupMessages(ChatData);
    });

    // $.post('http://ps_phone/ClearAlerts', JSON.stringify({
    //     number: ChatData.number
    // }));

    if (WhatsappSearchActive) {
        $("#whatsapp-search-input").fadeOut(150);
    }

    $(".whatsapp-openedgroup").css({
        "display": "block"
    });
    $(".whatsapp-openedgroup").animate({
        left: 0 + "vh"
    }, 200);

    $('.whatsapp-openedgroup-messages').animate({
        scrollTop: 9999
    }, 150);

    if (OpenedChatPicture == null) {
        OpenedChatPicture = "./img/default.png";
        if (ChatData.image != null || ChatData.image != undefined || ChatData.image != "default.png") {
            OpenedChatPicture = ChatData.image
        }
        $(".whatsapp-openedgroup-picture").css({
            "background-image": "url(" + OpenedChatPicture + ")"
        });
    }
});

$(document).on('click', '#whatsapp-openedchat-back', function(e) {
    e.preventDefault();
    $(".preload-messages-wpp").show();
    $.post('http://ps_phone/GetWhatsappChats', JSON.stringify({}), function(chats) {
        LoadWhatsappChats(chats);
    });
    OpenedChatData.phone = null;
    $(".whatsapp-openedchat").animate({
        left: -35 + "vh"
    }, 200, function() {
        $(".whatsapp-openedchat").css({
            "display": "none"
        });
    });
    OpenedChatPicture = null;
});

$(document).on('click', '#whatsapp-openedgroup-back', function(e) {
    e.preventDefault();
    $(".preload-groups-wpp").show();
    $.post('http://ps_phone/GetWhatsappGroups', JSON.stringify({}), function(groups) {
        LoadWhatsappGroups(groups);
    });
    OpenedChatData.group = null;
    $(".whatsapp-openedgroup").animate({
        left: -35 + "vh"
    }, 200, function() {
        $(".whatsapp-openedgroup").css({
            "display": "none"
        });
    });
    OpenedChatPicture = null;
});

$(document).on('click', '#whatsapp-openedgroup-edit', function(e) {
    e.preventDefault();

    var number = OpenedChatData.group;

    $.post('http://ps_phone/GetWhatsappGroup', JSON.stringify({
        number: number
    }), function(group) {
        if (group) {
            group = JSON.parse(group);

            $(".whatsapp-edit-group #image").val(group.data.image);
            $(".whatsapp-edit-group #name").val(group.data.name);

            $(".whatsapp-edit-group .users").html("");

            $.each(group.users, function(i, user) {

                if (user.avatar == "default.png") {
                    var avatar = "img/default.png";
                } else {
                    var avatar = user.avatar;
                }

                var html = `<li class="person" data-chat="person1">
                    <div class="user"> <img src="${avatar}">
                    </div>
                    <p class="name-time"> <span class="name">${user.name}</span> </p>
                </li>`;

                $(".whatsapp-edit-group .users").append(html);
            });
        }
    });

    $(".whatsapp-edit-group").css({
        "display": "block"
    });
    $(".whatsapp-edit-group").animate({
        left: 0 + "vh"
    }, 200);
});

$(document).on('click', '.create-group', function(e) {
    e.preventDefault();
    $(".whatsapp-menu").fadeOut(150);
    WhatsappMenuActive = false;
    $(".whatsapp-create-group").css({
        "display": "block"
    });
    $(".whatsapp-create-group").animate({
        left: 0 + "vh"
    }, 200);
});

$(document).on('click', '#whatsapp-create-group-back', function(e) {
    e.preventDefault();
    $(".whatsapp-create-group").animate({
        left: -35 + "vh"
    }, 200, function() {
        $(".whatsapp-create-group").css({
            "display": "none"
        });
    });
});

$(document).on('click', '#whatsapp-edit-group-back', function(e) {
    e.preventDefault();
    $(".whatsapp-edit-group").animate({
        left: -35 + "vh"
    }, 200, function() {
        $(".whatsapp-edit-group").css({
            "display": "none"
        });
    });
});

$(document).on('click', '.edit-profile', function(e) {
    e.preventDefault();

    $.post('http://ps_phone/GetUserProfileWhatsApp', JSON.stringify({}), function(account) {
        if (account) {
            $(".editeprofilewpp #avatar").val(account.avatar);
            $(".editeprofilewpp #name").val(account.name);
            $(".editeprofilewpp #phone").val(account.phone);

            $(".whatsapp-menu").fadeOut(150);
            WhatsappMenuActive = false;
            $(".whatsapp-edit-profile").css({
                "display": "block"
            });
            $(".whatsapp-edit-profile").animate({
                left: 0 + "vh"
            }, 200);
        }
    });
});

$(document).on('click', '#whatsapp-edit-profile-back', function(e) {
    e.preventDefault();
    $(".whatsapp-edit-profile").animate({
        left: -35 + "vh"
    }, 200, function() {
        $(".whatsapp-edit-profile").css({
            "display": "none"
        });
    });
});

$(document).on('click', '.addmemberwpp', function(e) {
    e.preventDefault();

    var phone = $(".whatsapp-edit-group #number-member").val();
    var number = OpenedChatData.group;

    if (phone.length > 9) {
        PS.Phone.Notifications.Add("fas fa-exclamation-circle", "Editar grupo", "O número deve ser no máxino 9 digitos");
        return false;
    }

    if (phone.length < 7) {
        PS.Phone.Notifications.Add("fas fa-exclamation-circle", "Editar grupo", "O número deve ser no mínimo 7 digitos");
        return false;
    }

    $.post('http://ps_phone/AddMemberGroupWhatsapp', JSON.stringify({
        number: number,
        phone: phone
    }), function(check) {
        if (check) {
            PS.Phone.Notifications.Add("fas fa-exclamation-circle", "Adicionar Membro", "Membro adionado com sucesso", "green");
            $(".whatsapp-edit-group").animate({
                left: -35 + "vh"
            }, 200, function() {
                $(".whatsapp-edit-group").css({
                    "display": "none"
                });
            });
        }
    });
});

function GetLastMessage(messages) {
    var CurrentDate = new Date();
    var CurrentMonth = CurrentDate.getMonth();
    var CurrentDOM = CurrentDate.getDate();
    var CurrentYear = CurrentDate.getFullYear();
    var LastMessageData = {
        time: "00:00",
        message: "nikss"
    }

    $.each(messages[messages.length - 1], function(i, msg) {
        var msgData = msg[msg.length - 1];
        LastMessageData.time = msgData.time
        LastMessageData.message = msgData.message
    });

    return LastMessageData
}

GetCurrentDateKey = function() {
    var CurrentDate = new Date();
    var CurrentMonth = CurrentDate.getMonth();
    var CurrentDOM = CurrentDate.getDate();
    var CurrentYear = CurrentDate.getFullYear();
    var CurDate = "" + CurrentDOM + "-" + CurrentMonth + "-" + CurrentYear + "";

    return CurDate;
}

function LoadWhatsappChats(chats) {
    $("#messages").html("");

    var nchats = JSON.parse(chats);

    $.each(nchats, function(i, chat) {
        var profilepicture = "./img/default.png";
        if (chat.avatar !== "default.png") {
            profilepicture = chat.avatar
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

        var ChatElement = '<div class="whatsapp-chat" id="whatsapp-chat-' + i + '"><div class="whatsapp-chat-picture" style="background-image: url(' + profilepicture + ');"></div><div class="whatsapp-chat-name"><p>' + chat.contact_name + '</p></div><div class="whatsapp-chat-lastmessage"><p>' + chat.message + '</p></div> <div class="whatsapp-chat-lastmessagetime"><p>' + time + '</p></div><div class="whatsapp-chat-unreadmessages unread-chat-id-' + i + '">1</div></div>';

        $("#messages").append(ChatElement);
        $("#whatsapp-chat-" + i).data('chatdata', chat);

        if (chat.read > 0 && chat.read !== undefined && chat.read !== null) {
            $(".unread-chat-id-" + i).html(chat.read);
            $(".unread-chat-id-" + i).css({
                "display": "block"
            });
        } else {
            $(".unread-chat-id-" + i).css({
                "display": "none"
            });
        }
    });

    $(".preload-messages-wpp").hide();
}

function LoadWhatsappGroups(groups) {
    $("#groups").html("");

    var ngroups = JSON.parse(groups);

    $.each(ngroups, function(i, group) {
        var groupImage = "./img/default.png";
        if (group.image !== "default.png") {
            groupImage = group.image
        }

        var time = new Date(group.created);

        var hours = time.getHours();
        var minutes = time.getMinutes();

        if (hours < 10) {
            hours = "0" + hours
        }

        if (minutes < 10) {
            minutes = "0" + minutes
        }

        time = hours + ":" + minutes;

        var ChatElement = '<div class="whatsapp-group" id="whatsapp-group-' + i + '"><div class="whatsapp-chat-picture" style="background-image: url(' + groupImage + ');"></div><div class="whatsapp-chat-name"><p>' + group.name + '</p></div><div class="whatsapp-chat-lastmessage"><p>' + group.message + '</p></div> <div class="whatsapp-chat-lastmessagetime"><p>' + time + '</p></div><div class="whatsapp-chat-unreadmessages unread-chat-id-' + i + '">1</div></div>';

        $("#groups").append(ChatElement);
        $("#whatsapp-group-" + i).data('groupdata', group);

        if (group.read != 0 && group.read !== undefined && group.read !== null) {
            $(".unread-chat-id-" + i).html(chat.read);
            $(".unread-chat-id-" + i).css({
                "display": "block"
            });
        } else {
            $(".unread-chat-id-" + i).css({
                "display": "none"
            });
        }
    });
    $(".preload-groups-wpp").hide();
}

function ReloadWhatsappAlerts(chats) {
    $.each(chats, function(i, chat) {
        if (chat.Unread > 0 && chat.Unread !== undefined && chat.Unread !== null) {
            $(".unread-chat-id-" + i).html(chat.Unread);
            $(".unread-chat-id-" + i).css({
                "display": "block"
            });
        } else {
            $(".unread-chat-id-" + i).css({
                "display": "none"
            });
        }
    });
}

const monthNames = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"];

FormatChatDate = function(date) {
    var TestDate = date.split("-");
    var NewDate = new Date((parseInt(TestDate[1]) + 1) + "-" + TestDate[0] + "-" + TestDate[2]);

    var CurrentMonth = monthNames[NewDate.getMonth()];
    var CurrentDOM = NewDate.getDate();
    var CurrentYear = NewDate.getFullYear();
    var CurDateee = CurrentDOM + "-" + NewDate.getMonth() + "-" + CurrentYear;
    var ChatDate = CurrentDOM + " " + CurrentMonth + " " + CurrentYear;
    var CurrentDate = GetCurrentDateKey();

    var ReturnedValue = ChatDate;
    if (CurrentDate == CurDateee) {
        ReturnedValue = "Vandaag";
    }

    return ReturnedValue;
}

FormatMessageTime = function() {
    var NewDate = new Date();
    var NewHour = NewDate.getHours();
    var NewMinute = NewDate.getMinutes();
    var Minutessss = NewMinute;
    var Hourssssss = NewHour;
    if (NewMinute < 10) {
        Minutessss = "0" + NewMinute;
    }
    if (NewHour < 10) {
        Hourssssss = "0" + NewHour;
    }
    var MessageTime = Hourssssss + ":" + Minutessss
    return MessageTime;
}

$(document).on('click', '#whatsapp-openedchat-send', function(e) {
    e.preventDefault();

    var Message = $("#whatsapp-openedchat-message").val();

    if (Message !== null && Message !== undefined && Message !== "") {
        $.post('http://ps_phone/SendMessage', JSON.stringify({
            phone: OpenedChatData.phone,
            message: Message,
            type: "message",
        }), function(messages) {
            if (messages) {
                LoadMessages(messages);
            }
        });
        $("#whatsapp-openedchat-message").val("");
    } else {
        PS.Phone.Notifications.Add("fab fa-whatsapp", "Whatsapp", "Você não pode enviar uma mensagem em branco!", "#25D366", 1750);
    }
});

$(document).on('click', '#whatsapp-openedchat-sendaudio', function(e) {
    e.preventDefault();

    $(this).addClass('active');

    toggleRecordingChat();
});

$(document).on('click', '#whatsapp-openedgroup-sendaudio', function(e) {
    e.preventDefault();

    $(this).addClass('active');

    toggleRecordingGroup();
});

$(document).on('click', '#whatsapp-openedgroup-send', function(e) {
    e.preventDefault();

    var Message = $("#whatsapp-openedgroup-message").val();

    if (Message !== null && Message !== undefined && Message !== "") {
        $.post('http://ps_phone/SendMessageGroup', JSON.stringify({
            number: OpenedChatData.group,
            message: Message,
            type: "message",
        }), function(messages) {
            if (messages) {
                LoadMessagesGroup(messages);
            }
        });
        $("#whatsapp-openedgroup-message").val("");
    } else {
        PS.Phone.Notifications.Add("fab fa-whatsapp", "Whatsapp", "Você não pode enviar uma mensagem em branco!", "#25D366", 1750);
    }
});

$(document).on('keypress', function(e) {
    if (OpenedChatData.phone !== null) {
        if (e.which === 13) {
            var Message = $("#whatsapp-openedchat-message").val();

            if (Message !== null && Message !== undefined && Message !== "") {
                $.post('http://ps_phone/SendMessage', JSON.stringify({
                    phone: OpenedChatData.phone,
                    message: Message,
                    type: "message",
                }), function(messages) {
                    if (messages) {
                        LoadMessages(messages);
                    }
                });
                $("#whatsapp-openedchat-message").val("");
            } else {
                PS.Phone.Notifications.Add("fab fa-whatsapp", "Whatsapp", "Você não pode enviar uma mensagem em branco!", "#25D366", 1750);
            }
        }
    }

    if (OpenedChatData.group !== null) {
        if (e.which === 13) {
            var Message = $("#whatsapp-openedgroup-message").val();

            if (Message !== null && Message !== undefined && Message !== "") {
                $.post('http://ps_phone/SendMessageGroup', JSON.stringify({
                    number: OpenedChatData.group,
                    message: Message,
                    type: "message",
                }), function(messages) {
                    if (messages) {
                        LoadMessagesGroup(messages);
                    }
                });
                $("#whatsapp-openedgroup-message").val("");
            } else {
                // PS.Phone.Notifications.Add("fab fa-whatsapp", "Whatsapp", "YVocê não pode enviar uma mensagem em branco!", "#25D366", 1750);
            }
        }
    }
});

$(document).on('click', '#send-location', function(e) {
    e.preventDefault();

    $.post('http://ps_phone/SendMessage', JSON.stringify({
        phone: OpenedChatData.phone,
        message: "location",
        type: "location",
    }), function(messages) {
        if (messages) {
            LoadMessages(messages);
        }
    });
});

$(document).on('click', '#send-location-group', function(e) {
    e.preventDefault();

    $.post('http://ps_phone/SendMessageGroup', JSON.stringify({
        number: OpenedChatData.group,
        message: "location",
        type: "location",
    }), function(messages) {
        if (messages) {
            LoadMessagesGroup(messages);
        }
    });
});

$(document).on('click', '#send-image', function(e) {
    e.preventDefault();

    var phone = OpenedChatData.phone;

    if (phone.length <= 0) {
        return false;
    }

    $.post('http://ps_phone/PostNewImage', JSON.stringify({}),
        function(url) {
            if (url.length > 0) {
                $.post('http://ps_phone/SendMessage', JSON.stringify({
                    phone: phone,
                    message: url,
                    type: "message",
                }), function(messages) {
                    if (messages) {
                        LoadMessages(messages);
                    }
                });
            }
        },
    );

    PS.Phone.Functions.Close();
});

$(document).on('click', '#send-image-group', function(e) {
    e.preventDefault();

    $.post('http://ps_phone/PostNewImage', JSON.stringify({}),
        function(url) {
            if (url.length > 0) {
                $.post('http://ps_phone/SendMessageGroup', JSON.stringify({
                    number: OpenedChatData.group,
                    message: url,
                    type: "message",
                }), function(messages) {
                    if (messages) {
                        LoadMessagesGroup(messages);
                    }
                });
            }
        },
    );

    PS.Phone.Functions.Close();
});

function SetupChatMessages(cData, NewChatData) {
    if (cData) {
        OpenedChatData.phone = cData.contact_phone;

        if (OpenedChatPicture == null) {
            $.post('http://ps_phone/GetProfilePicture', JSON.stringify({
                number: OpenedChatData.phone,
            }), function(picture) {
                var npicture = JSON.parse(picture);
                OpenedChatPicture = "./img/default.png";
                if (npicture != "default.png" && npicture != null) {
                    OpenedChatPicture = npicture
                }
                $(".whatsapp-openedchat-picture").css({
                    "background-image": "url(" + OpenedChatPicture + ")"
                });
            });
        } else {
            $(".whatsapp-openedchat-picture").css({
                "background-image": "url(" + OpenedChatPicture + ")"
            });
        }

        $(".whatsapp-openedchat-name").html("<p>" + cData.contact_name + "</p>");
        $(".whatsapp-openedchat-messages").html("");

        $.each(cData.messages, function(i, chat) {

            var ChatDate = chat.created;
            var ChatDiv = '<div class="whatsapp-openedchat-messages-' + i + ' unique-chat"><div class="whatsapp-openedchat-date">' + ChatDate + '</div></div>';


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

            var Sender = "me";
            if (chat.owner !== PS.Phone.Data.WhatsAppAccount.phone) {
                Sender = "other";
            }
            var MessageElement = '';
            if (chat.type == "message") {
                var message = chat.message;
                if (chat.message.indexOf(".jpg") != -1) {
                    message = "<img src='" + chat.message + "' />"
                }

                if (chat.message.indexOf(".png") != -1) {
                    message = "<img src='" + chat.message + "' />"
                }

                if (chat.message.indexOf(".gif") != -1) {
                    message = "<img src='" + chat.message + "' />"
                }

                MessageElement = '<div class="whatsapp-openedchat-message whatsapp-openedchat-message-' + Sender + '">' + message + '<div class="whatsapp-openedchat-message-time">' + time + '</div></div><div class="clearfix"></div>'
            } else if (chat.type == "location") {
                var pos = JSON.parse(chat.message);
                MessageElement = '<div class="whatsapp-openedchat-message whatsapp-openedchat-message-' + Sender + ' whatsapp-shared-location" data-x="' + pos.x + '" data-y="' + pos.y + '"><span style="font-size: 1.2vh;"><i class="fas fa-thumbtack" style="font-size: 1vh;"></i> Localização</span><div class="whatsapp-openedchat-message-time">' + time + '</div></div><div class="clearfix"></div>'
            } else if (chat.type == "audio") {
                MessageElement = '<div class="whatsapp-openedchat-message whatsapp-openedchat-message-' + Sender + '"><audio controls><source src="' + chat.message + '" type="audio/wav"></audio><div class="whatsapp-openedchat-message-time">' + time + '</div></div><div class="clearfix"></div>';
            }

            $(".whatsapp-openedchat-messages").append(MessageElement);
        });
        $('.whatsapp-openedchat-messages').animate({
            scrollTop: 9999
        }, 1);
    } else {

        console.log(NewChatData);

        OpenedChatData.phone = NewChatData.phone;
        if (OpenedChatPicture == null) {
            $.post('http://ps_phone/GetProfilePicture', JSON.stringify({
                number: OpenedChatData.phone,
            }), function(picture) {
                var npicture = JSON.parse(picture);
                OpenedChatPicture = "./img/default.png";
                if (npicture != "default.png" && npicture != null) {
                    OpenedChatPicture = npicture
                }
                $(".whatsapp-openedchat-picture").css({
                    "background-image": "url(" + OpenedChatPicture + ")"
                });
            });
        }

        var chatname = "";

        if (NewChatData.name) {
            chatname = NewChatData.name;
        }

        if (NewChatData.contact_name) {
            chatname = NewChatData.contact_name;
        }

        $(".whatsapp-openedchat-name").html("<p>" + chatname + "</p>");
        $(".whatsapp-openedchat-messages").html("");
        var NewDate = new Date();
        var NewDateMonth = NewDate.getMonth();
        var NewDateDOM = NewDate.getDate();
        var NewDateYear = NewDate.getFullYear();
        var DateString = "" + NewDateDOM + "-" + (NewDateMonth + 1) + "-" + NewDateYear;
        var ChatDiv = '<div class="whatsapp-openedchat-messages-' + DateString + ' unique-chat"><div class="whatsapp-openedchat-date">HOJE</div></div>';

        $(".whatsapp-openedchat-messages").append(ChatDiv);
    }

    $('.whatsapp-openedchat-messages').animate({
        scrollTop: 9999
    }, 1);
}

function SetupGroupMessages(cData) {
    if (cData) {
        OpenedChatData.group = cData.number;

        if (OpenedChatPicture == null) {
            $.post('http://ps_phone/GetGroupImage', JSON.stringify({
                number: OpenedChatData.group,
            }), function(picture) {
                var npicture = JSON.parse(picture);
                OpenedChatPicture = "./img/default.png";
                if (npicture != "default.png" && npicture != null) {
                    OpenedChatPicture = npicture
                }
                $(".whatsapp-openedgroup-picture").css({
                    "background-image": "url(" + OpenedChatPicture + ")"
                });
            });
        } else {
            $(".whatsapp-openedgroup-picture").css({
                "background-image": "url(" + OpenedChatPicture + ")"
            });
        }

        $(".whatsapp-openedgroup-name").html("<p>" + cData.name + "</p>");
        $(".whatsapp-openedgroup-messages").html("");

        $.each(cData.messages, function(i, chat) {

            var ChatDate = chat.created;
            var ChatDiv = '<div class="whatsapp-openedgroup-messages-' + i + ' unique-chat"><div class="whatsapp-openedgroup-date">' + ChatDate + '</div></div>';


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

            var Sender = "me";
            if (chat.owner !== PS.Phone.Data.WhatsAppAccount.phone) {
                Sender = "other";
            }
            var MessageElement = '';
            if (chat.type == "message") {
                var message = chat.message;
                if (chat.message.indexOf(".jpg") != -1) {
                    message = "<img src='" + chat.message + "' />"
                }

                if (chat.message.indexOf(".png") != -1) {
                    message = "<img src='" + chat.message + "' />"
                }

                if (chat.message.indexOf(".gif") != -1) {
                    message = "<img src='" + chat.message + "' />"
                }

                MessageElement = '<div class="whatsapp-openedgroup-message whatsapp-openedgroup-message-' + Sender + '"><b>' + chat.name + '</b><br>' + message + '<div class="whatsapp-openedgroup-message-time">' + time + '</div></div><div class="clearfix"></div>'
            } else if (chat.type == "location") {
                var pos = JSON.parse(chat.message);
                MessageElement = '<div class="whatsapp-openedgroup-message whatsapp-openedgroup-message-' + Sender + ' whatsapp-shared-location" data-x="' + pos.x + '" data-y="' + pos.y + '"><b>' + chat.name + '</b><br><span style="font-size: 1.2vh;"><i class="fas fa-thumbtack" style="font-size: 1vh;"></i> Localização</span><div class="whatsapp-openedgroup-message-time">' + time + '</div></div><div class="clearfix"></div>'
            } else if (chat.type == "audio") {
                MessageElement = '<div class="whatsapp-openedgroup-message whatsapp-openedgroup-message-' + Sender + '"><audio controls><source src="' + chat.message + '" type="audio/wav"></audio><div class="whatsapp-openedgroup-message-time">' + time + '</div></div><div class="clearfix"></div>';
            }

            $(".whatsapp-openedgroup-messages").append(MessageElement);
        });
        $('.whatsapp-openedgroup-messages').animate({
            scrollTop: 9999
        }, 1);
    }

    $('.whatsapp-openedgroup-messages').animate({
        scrollTop: 9999
    }, 1);
}

function LoadMessages(messages) {
    $(".whatsapp-openedchat-messages").html("");

    var nmessages = JSON.parse(messages);

    $.each(nmessages, function(i, chat) {

        var ChatDate = chat.created;
        var ChatDiv = '<div class="whatsapp-openedchat-messages-' + i + ' unique-chat"><div class="whatsapp-openedchat-date">' + ChatDate + '</div></div>';


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

        var Sender = "me";
        if (chat.owner !== PS.Phone.Data.WhatsAppAccount.phone) {
            Sender = "other";
        }
        var MessageElement = '';
        if (chat.type == "message") {
            var message = chat.message;
            if (chat.message.indexOf(".jpg") != -1) {
                message = "<img src='" + chat.message + "' />"
            }

            if (chat.message.indexOf(".png") != -1) {
                message = "<img src='" + chat.message + "' />"
            }

            if (chat.message.indexOf(".gif") != -1) {
                message = "<img src='" + chat.message + "' />"
            }

            MessageElement = '<div class="whatsapp-openedchat-message whatsapp-openedchat-message-' + Sender + '">' + message + '<div class="whatsapp-openedchat-message-time">' + time + '</div></div><div class="clearfix"></div>';
        } else if (chat.type == "location") {
            var pos = JSON.parse(chat.message);
            MessageElement = '<div class="whatsapp-openedchat-message whatsapp-openedchat-message-' + Sender + ' whatsapp-shared-location" data-x="' + pos.x + '" data-y="' + pos.y + '"><span style="font-size: 1.2vh;"><i class="fas fa-thumbtack" style="font-size: 1vh;"></i> Localização</span><div class="whatsapp-openedchat-message-time">' + time + '</div></div><div class="clearfix"></div>';
        } else if (chat.type == "audio") {
            MessageElement = '<div class="whatsapp-openedchat-message whatsapp-openedchat-message-' + Sender + '"><audio controls><source src="' + chat.message + '" type="audio/wav"></audio><div class="whatsapp-openedchat-message-time">' + time + '</div></div><div class="clearfix"></div>';
        }

        $(".whatsapp-openedchat-messages").append(MessageElement);
    });
    // $('.whatsapp-openedchat-messages').animate({ scrollTop: 9999 }, 1);
}

function LoadMessagesGroup(messages) {
    $(".whatsapp-openedgroup-messages").html("");

    var nmessages = JSON.parse(messages);

    $.each(nmessages, function(i, chat) {

        var ChatDate = chat.created;
        var ChatDiv = '<div class="whatsapp-openedgroup-messages-' + i + ' unique-chat"><div class="whatsapp-openedgroup-date">' + ChatDate + '</div></div>';


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

        var Sender = "me";
        if (chat.owner !== PS.Phone.Data.WhatsAppAccount.phone) {
            Sender = "other";
        }
        var MessageElement = '';
        if (chat.type == "message") {
            var message = chat.message;
            if (chat.message.indexOf(".jpg") != -1) {
                message = "<img src='" + chat.message + "' />"
            }

            if (chat.message.indexOf(".png") != -1) {
                message = "<img src='" + chat.message + "' />"
            }

            if (chat.message.indexOf(".gif") != -1) {
                message = "<img src='" + chat.message + "' />"
            }

            MessageElement = '<div class="whatsapp-openedgroup-message whatsapp-openedgroup-message-' + Sender + '"><b>' + chat.name + '</b><br>' + message + '<div class="whatsapp-openedgroup-message-time">' + time + '</div></div><div class="clearfix"></div>'
        } else if (chat.type == "location") {
            var pos = JSON.parse(chat.message);
            MessageElement = '<div class="whatsapp-openedgroup-message whatsapp-openedgroup-message-' + Sender + ' whatsapp-shared-location" data-x="' + pos.x + '" data-y="' + pos.y + '"><b>' + chat.name + '</b><br><span style="font-size: 1.2vh;"><i class="fas fa-thumbtack" style="font-size: 1vh;"></i> Localização</span><div class="whatsapp-openedgroup-message-time">' + time + '</div></div><div class="clearfix"></div>'
        } else if (chat.type == "audio") {
            MessageElement = '<div class="whatsapp-openedgroup-message whatsapp-openedgroup-message-' + Sender + '"><audio controls><source src="' + chat.message + '" type="audio/wav"></audio><div class="whatsapp-openedgroup-message-time">' + time + '</div></div><div class="clearfix"></div>';
        }

        $(".whatsapp-openedgroup-messages").append(MessageElement);
    });
    // $('.whatsapp-openedgroup-messages').animate({ scrollTop: 9999 }, 1);
}

$(document).on('click', '.whatsapp-shared-location', function(e) {
    e.preventDefault();
    var messageCoords = {}
    messageCoords.x = $(this).data('x');
    messageCoords.y = $(this).data('y');

    $.post('http://ps_phone/SharedLocation', JSON.stringify({
        coords: messageCoords,
    }))
});

var ExtraButtonsOpen = false;

$(document).on('click', '#whatsapp-openedchat-message-extras', function(e) {
    e.preventDefault();

    if (!ExtraButtonsOpen) {
        $(".whatsapp-extra-buttons").css({
            "display": "block"
        }).animate({
            left: 0 + "vh"
        }, 250);
        ExtraButtonsOpen = true;
    } else {
        $(".whatsapp-extra-buttons").animate({
            left: -10 + "vh"
        }, 250, function() {
            $(".whatsapp-extra-buttons").css({
                "display": "block"
            });
            ExtraButtonsOpen = false;
        });
    }
});

$(document).on('click', '#whatsapp-openedgroup-message-extras', function(e) {
    e.preventDefault();

    if (!ExtraButtonsOpen) {
        $(".whatsapp-extra-buttons").css({
            "display": "block"
        }).animate({
            left: 0 + "vh"
        }, 250);
        ExtraButtonsOpen = true;
    } else {
        $(".whatsapp-extra-buttons").animate({
            left: -10 + "vh"
        }, 250, function() {
            $(".whatsapp-extra-buttons").css({
                "display": "block"
            });
            ExtraButtonsOpen = false;
        });
    }
});


$(document).on('submit', '.addaccountwpp', function(e) {
    var name = $(".addaccountwpp #name").val();
    var phone = $(".addaccountwpp #phone").val();
    var password = $(".addaccountwpp #password").val();

    if (name.length <= 0 || username.length <= 0 || password.length <= 0) {
        $(".whatsapp-app .not-logged .error p").html("Preencha todos os campos");
        $(".whatsapp-app .not-logged .error").show();
        return false;
    }

    if (name.length < 6) {
        $(".whatsapp-app .not-logged .error p").html("O nome deve no minino 6 digitos");
        $(".whatsapp-app .not-logged .error").show();
        return false;
    }

    if (phone.length < 7) {
        $(".whatsapp-app .not-logged .error p").html("O número deve no minino 7 digitos");
        $(".whatsapp-app .not-logged .error").show();
        return false;
    }

    if (phone.length > 9) {
        $(".whatsapp-app .not-logged .error p").html("O número deve no máxino 9 digitos");
        $(".whatsapp-app .not-logged .error").show();
        return false;
    }

    if (password.length < 6) {
        $(".whatsapp-app .not-logged .error p").html("A senha deve no minino 6 digitos");
        $(".whatsapp-app .not-logged .error").show();
        return false;
    }

    $(".whatsapp-app .not-logged .error p").html();
    $(".whatsapp-app .not-logged .error").hide();

    $.post('http://ps_phone/AddAccountWhatsApp', JSON.stringify({
        name: name,
        phone: phone,
        password: password
    }), function(account) {
        PS.Phone.Data.WhatsAppAccount = account;
        $(".whatsapp-app .not-logged").hide();
        $(".whatsapp-app .logged").show();

        PS.Phone.Notifications.Add("fas fa-check", "Cria conta", "Conta criada com sucesso! Finalize e abra novamente o aplicativo", "green");

        $(".preload-messages-wpp").show();
        $.post('http://ps_phone/GetWhatsappChats', JSON.stringify({}), function(chats) {
            LoadWhatsappChats(chats);
        });
    });

    return false;
});

$(document).on('click', '.whatsapp-status-new .whatsapp-chat-picture', function(e) {
    e.preventDefault();

    $.post('http://ps_phone/PostNewImage', JSON.stringify({}),
        function(url) {
            if (url.length > 0) {
                var image = url;
                $.post('http://ps_phone/AddStorieWhatsApp', JSON.stringify({
                    image: image
                }), function(check) {
                    if (check) {
                        $(".whatsapp-status-new .whatsapp-chat-picture").css("background-image", url);
                    }
                });
            }
        },
    );

    PS.Phone.Functions.Close();

});

$(document).on('click', '.getchats', function(e) {
    e.preventDefault();

    $(".preload-messages-wpp").show();
    $.post('http://ps_phone/GetWhatsappChats', JSON.stringify({}), function(chats) {
        LoadWhatsappChats(chats);
    });
});

$(document).on('click', '.getgroups', function(e) {
    e.preventDefault();

    $(".preload-groups-wpp").show();
    $.post('http://ps_phone/GetWhatsappGroups', JSON.stringify({}), function(groups) {
        LoadWhatsappGroups(groups);
    });
});

$(document).on('click', '.getstatus', function(e) {
    e.preventDefault();

    $(".preload-status-wpp").show();
    $.post('http://ps_phone/GetStoriesWhatsApp', JSON.stringify({}), function(stories) {
        PS.Phone.Functions.ReceiveStoriesWhatsApp(stories);
    });
});

$(document).on('click', '.sendpictureprofilewpp', function(e) {
    e.preventDefault();

    $.post('http://ps_phone/PostNewImage', JSON.stringify({}),
        function(url) {
            $(".editeprofilewpp #avatar").val(url);
        },
    );

    PS.Phone.Functions.Close();

});

$(document).on('submit', '.editeprofilewpp', function(e) {
    e.preventDefault();

    var avatar = $(".editeprofilewpp #avatar").val();
    var name = $(".editeprofilewpp #name").val();

    if (avatar != "" && name != "") {

        $.post('http://ps_phone/EditProfileWhatsApp', JSON.stringify({
                avatar: avatar,
                name: name
            }),
            function(check) {
                if (check) {
                    $(".whatsapp-edit-profile").animate({
                        left: -35 + "vh"
                    }, 200, function() {
                        $(".whatsapp-edit-profile").css({
                            "display": "none"
                        });
                    });

                    PS.Phone.Notifications.Add("fas fa-check", "Editar perfil", "Perfil editado com sucesso!", "green");
                }
            },
        );

    } else {
        PS.Phone.Notifications.Add("fas fa-exclamation-circle", "Editar perfil", "Preencha todos os campos!");
    }

});

$(document).on('click', '.sendpicturegroup', function(e) {
    e.preventDefault();

    $.post('http://ps_phone/PostNewImage', JSON.stringify({}),
        function(url) {
            $(".addgroupwpp #image").val(url);
        },
    );

    PS.Phone.Functions.Close();

});

$(document).on('click', '.sendpicturegroupedit', function(e) {
    // e.preventDefault();

    $.post('http://ps_phone/PostNewImage', JSON.stringify({}),
        function(url) {
            $(".editgroupwpp #image").val(url);
        },
    );

    PS.Phone.Functions.Close();

});

$(document).on('submit', '.addgroupwpp', function(e) {
    e.preventDefault();

    var image = $(".addgroupwpp #image").val();
    var name = $(".addgroupwpp #name").val();

    if (image != "" && name != "") {

        $.post('http://ps_phone/CreateGroupWhatsApp', JSON.stringify({
                image: image,
                name: name
            }),
            function(check) {
                if (check) {
                    $(".whatsapp-create-group").animate({
                        left: -35 + "vh"
                    }, 200, function() {
                        $(".whatsapp-create-group").css({
                            "display": "none"
                        });
                    });

                    PS.Phone.Notifications.Add("fas fa-check", "Criar grupo", "Grupo criado com sucesso!", "green");
                }
            },
        );

    } else {
        PS.Phone.Notifications.Add("fas fa-exclamation-circle", "Criar grupo", "Preencha todos os campos!");
    }

});

$(document).on('submit', '.editgroupwpp', function(e) {
    e.preventDefault();

    var image = $(".editgroupwpp #image").val();
    var name = $(".editgroupwpp #name").val();
    var number = OpenedChatData.group;

    if (image != "" && name != "") {

        $.post('http://ps_phone/EditGroupWhatsApp', JSON.stringify({
                image: image,
                name: name,
                number: number
            }),
            function(check) {
                if (check) {
                    $(".whatsapp-edit-group").animate({
                        left: -35 + "vh"
                    }, 200, function() {
                        $(".whatsapp-edit-group").css({
                            "display": "none"
                        });
                    });

                    PS.Phone.Notifications.Add("fas fa-check", "Editar grupo", "Grupo editado com sucesso!", "green");
                }
            },
        );

    } else {
        PS.Phone.Notifications.Add("fas fa-exclamation-circle", "Editar grupo", "Preencha todos os campos!");
    }

});

$(document).on('click', '.whatsapp-chat-picture', function(e) {
    e.preventDefault();

    var image = $(this).css("background-image");
    image = image.split(/"/)[1];

    const mystorie = [{
            user: {
                name: 'Nome do Usuario',
                imageURL: 'https://www.rockstargames.com/br/img/global/downloads/buddyiconsconavatars/v_afterhours_taleofus2_256x256.jpg',
            },
            images: [
                image,
            ],
        },

    ];

    renderInFace(0, createStorie(mystorie[0]));

});

PS.Phone.Functions.ReceiveAccountWhatsApp = function(account) {
    if (account) {
        PS.Phone.Data.WhatsAppAccount = account;
        $(".whatsapp-app .not-logged").hide();
        $(".whatsapp-app .logged").show();

        $(".preload-messages-wpp").show();
        $.post('http://ps_phone/GetWhatsappChats', JSON.stringify({}), function(chats) {
            LoadWhatsappChats(chats);
        });

        $.post('http://ps_phone/GetStoriesWhatsApp', JSON.stringify({}), function(stories) {
            PS.Phone.Functions.ReceiveStoriesWhatsApp(stories);
        });

        $.post('http://ps_phone/GetMyStorieWhatsApp', JSON.stringify({}), function(stories) {
            PS.Phone.Functions.ReceiveMyStorieWhatsApp(stories);
        });
    } else {
        $(".whatsapp-app .not-logged").show();
        $(".whatsapp-app .logged").hide();
    }
}

PS.Phone.Functions.ReceiveStoriesWhatsApp = function(data) {
    $(".whatsapp-stories").html('');

    var stories = JSON.parse(data);

    if (stories.length > 0) {
        $.each(stories, function(i, storie) {

            var time = printdate(storie.created);
            time = time.replace("-", "");

            var newhtml = `<div class="whatsapp-status">
                <div class="whatsapp-chat-picture" style="background-image: url('${storie.image}');"></div>
                <div class="whatsapp-chat-name">
                    <p>${storie.contact_name}</p>
                </div>
                <div class="whatsapp-chat-lastmessage">
                    <p>${time}</p>
                </div>
            </div>`;

            $(".whatsapp-stories").append(newhtml);
        });
    }

    $(".preload-status-wpp").hide();
}

PS.Phone.Functions.ReceiveMyStorieWhatsApp = function(data) {
    if (data) {

        var storie = JSON.parse(data);

        if (storie.image && storie.phone) {

            var time = printdate(storie.created);
            time = time.replace("-", "");

            var html = `<div class="whatsapp-chat-picture" style="background-image: url('${storie.image}');">
                <i class="fas fa-plus-circle"></i>
            </div>
            <div class="whatsapp-chat-name">
                <p>Meu Status</p>
            </div>
            <div class="whatsapp-chat-lastmessage">
                <p>há ${time}</p>
            </div>`;
            $(".whatsapp-status-new").html(html);
        } else {

            if (PS.Phone.Data.WhatsAppAccount.avatar == 'default.png') {
                var avatar = "img/default.png";
            } else {
                var avatar = PS.Phone.Data.WhatsAppAccount.avatar;
            }

            var html = `<div class="whatsapp-chat-picture" style="background-image: url('${avatar}');">
                <i class="fas fa-plus-circle"></i>
            </div>
            <div class="whatsapp-chat-name">
                <p>Meu Status</p>
            </div>
            <div class="whatsapp-chat-lastmessage">
                <p>Adicionar ao meu status</p>
            </div>`;

            $(".whatsapp-status-new").html(html);
        }
    } else {

        if (PS.Phone.Data.WhatsAppAccount.avatar == 'default.png') {
            var avatar = "img/default.png";
        } else {
            var avatar = PS.Phone.Data.WhatsAppAccount.avatar;
        }

        var html = `<div class="whatsapp-chat-picture" style="background-image: url('${avatar}');">
                <i class="fas fa-plus-circle"></i>
            </div>
            <div class="whatsapp-chat-name">
                <p>Meu Status</p>
            </div>
            <div class="whatsapp-chat-lastmessage">
                <p>Adicionar ao meu status</p>
            </div>`;

        $(".whatsapp-status-new").html(html);
    }
}


setInterval(function() {
    verifyopentabmessages();
    verifyopentabgroups();
    verifyopentabstatus();

    var audiochatcheck = $('.whatsapp-openedchat-message audio');
    var audiogroupcheck = $('.whatsapp-openedgroup-message audio');

    if (audiochatcheck.paused) {
        verifyopenchat();
    }

    if (audiogroupcheck.paused) {
        verifyopengroup();
    }

}, 5000);

function verifyopentabmessages() {
    var opentabmessages = $('.whatsapp-tabs #messages').is(':visible');

    if (opentabmessages) {
        $.post('http://ps_phone/GetWhatsappChats', JSON.stringify({}), function(chats) {
            LoadWhatsappChats(chats);
        });
    }
}

function verifyopentabgroups() {
    var opentabgroups = $('.whatsapp-tabs #groups').is(':visible');

    if (opentabgroups) {
        $.post('http://ps_phone/GetWhatsappGroups', JSON.stringify({}), function(groups) {
            LoadWhatsappGroups(groups);
        });
    }
}

function verifyopentabstatus() {
    var opentabstatus = $('.whatsapp-tabs #status').is(':visible');

    if (opentabstatus) {
        $.post('http://ps_phone/GetStoriesWhatsApp', JSON.stringify({}), function(stories) {
            PS.Phone.Functions.ReceiveStoriesWhatsApp(stories);
        });
    }
}

function verifyopenchat() {
    var openedchat = $('.whatsapp-openedchat-messages').is(':visible');

    if (openedchat) {
        $.post('http://ps_phone/GetWhatsappChat', JSON.stringify({
            phone: OpenedChatData.phone
        }), function(messages) {
            if (messages) {
                LoadMessages(messages);
            }
        });
    }
}

function verifyopengroup() {
    var openedgroup = $('.whatsapp-openedgroup-messages').is(':visible');

    if (openedgroup) {
        $.post('http://ps_phone/GetWhatsappGroupMessages', JSON.stringify({
            number: OpenedChatData.group
        }), function(messages) {
            if (messages) {
                LoadMessagesGroup(messages);
            }
        });
    }
}

function timeaudiochat() {

    var timeaudiointerval = null;

    if (audiochat) {
        var timeaudiointerval = setInterval(function() {

            if (!audiochat) {
                audiotimechat = 0;
                clearInterval(timeaudiointerval);
                $("#whatsapp-openedchat-message").val('');
            } else {

                audiotimechat = audiotimechat + 1;

                var gravando = "Gravando: " + audiotimechat + "s";

                $("#whatsapp-openedchat-message").val(gravando);

            }
        }, 1000);
    } else {
        $("#whatsapp-openedchat-message").val('');
    }
}

function toggleRecordingChat() {
    if (recorder && recorder.state == "recording") {
        $("#whatsapp-openedchat-sendaudio").removeClass('active');
        audiochat = false;
        timeaudiochat();
        recorder.stop();
        gumStream.getAudioTracks()[0].stop();
    } else {
        navigator.mediaDevices.getUserMedia({
            audio: true
        }).then(function(stream) {
            audiochat = true;
            timeaudiochat();
            gumStream = stream;
            recorder = new MediaRecorder(stream);
            recorder.ondataavailable = function(e) {
                // var url = URL.createObjectURL(e.data);
                var filename = new Date().toISOString();

                var xhr = new XMLHttpRequest();
                xhr.onload = function(e) {
                    if (this.readyState === 4) {
                        var response = JSON.parse(e.target.responseText);

                        if (response.success) {
                            var url = iphost + "ps_phone/audios/" + response.file;

                            if (url !== null && url !== undefined && url !== "") {
                                $.post('http://ps_phone/SendMessage', JSON.stringify({
                                    phone: OpenedChatData.phone,
                                    message: url,
                                    type: "audio",
                                }), function(messages) {
                                    if (messages) {
                                        LoadMessages(messages);
                                    }
                                });
                            }
                        }
                    }
                };
                var fd = new FormData();
                fd.append("audio", e.data, filename);
                xhr.open("POST", "" + iphost + "ps_phone/index.php", true);
                xhr.send(fd);
            }
            recorder.start();
        });
    }
}

function timeaudiogroup() {

    var timeaudiointerval = null;

    if (audiogroup) {
        var timeaudiointerval = setInterval(function() {

            if (!audiogroup) {
                audiotimegroup = 0;
                clearInterval(timeaudiointerval);
                $("#whatsapp-openedgroup-message").val('');
            } else {

                audiotimegroup = audiotimegroup + 1;

                var gravando = "Gravando: " + audiotimegroup + "s";

                $("#whatsapp-openedgroup-message").val(gravando);

            }
        }, 1000);
    } else {
        $("#whatsapp-openedgroup-message").val('');
    }
}

function toggleRecordingGroup() {
    if (recorder && recorder.state == "recording") {
        $("#whatsapp-openedgroup-sendaudio").removeClass('active');
        audiogroup = false;
        timeaudiogroup();
        recorder.stop();
        gumStream.getAudioTracks()[0].stop();
    } else {
        navigator.mediaDevices.getUserMedia({
            audio: true
        }).then(function(stream) {
            audiogroup = true;
            timeaudiogroup();
            gumStream = stream;
            recorder = new MediaRecorder(stream);
            recorder.ondataavailable = function(e) {
                var filename = new Date().toISOString();

                var xhr = new XMLHttpRequest();
                xhr.onload = function(e) {
                    if (this.readyState === 4) {
                        var response = JSON.parse(e.target.responseText);

                        if (response.success) {
                            var url = iphost + "ps_phone/audios/" + response.file;

                            if (url !== null && url !== undefined && url !== "") {
                                $.post('http://ps_phone/SendMessageGroup', JSON.stringify({
                                    number: OpenedChatData.group,
                                    message: url,
                                    type: "audio",
                                }), function(messages) {
                                    if (messages) {
                                        LoadMessagesGroup(messages);
                                    }
                                });
                            }
                        }
                    }
                };
                var fd = new FormData();
                fd.append("audio", e.data, filename);
                xhr.open("POST", "" + iphost + "ps_phone/index.php", true);
                xhr.send(fd);
            }
            recorder.start();
        });
    }
}