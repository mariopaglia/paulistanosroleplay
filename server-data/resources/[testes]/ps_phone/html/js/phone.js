var ContactSearchActive = false;
var CurrentFooterTab = "contacts";
var CallData = {};
var ClearNumberTimer = null;
var SelectedSuggestion = null;
var AmountOfSuggestions = 0;

$(document).on('click', '.phone-app-footer-button', function(e) {
    e.preventDefault();

    var PressedFooterTab = $(this).data('phonefootertab');

    if (PressedFooterTab !== CurrentFooterTab) {
        var PreviousTab = $(this).parent().find('[data-phonefootertab="' + CurrentFooterTab + '"');

        $('.phone-app-footer').find('[data-phonefootertab="' + CurrentFooterTab + '"').removeClass('phone-selected-footer-tab');
        $(this).addClass('phone-selected-footer-tab');

        $(".phone-" + CurrentFooterTab).hide();
        $(".phone-" + PressedFooterTab).show();

        if (PressedFooterTab == "recent") {
            $.post('http://ps_phone/ClearRecentAlerts');
        } else if (PressedFooterTab == "suggestedcontacts") {
            $.post('http://ps_phone/ClearRecentAlerts');
        }

        CurrentFooterTab = PressedFooterTab;
    }
});

$(document).on("click", "#phone-search-icon", function(e) {
    e.preventDefault();

    if (!ContactSearchActive) {
        $("#phone-plus-icon").animate({
            opacity: "0.0",
            "display": "none"
        }, 150, function() {
            $("#contact-search").css({
                "display": "block"
            }).animate({
                opacity: "1.0",
            }, 150);
        });
    } else {
        $("#contact-search").animate({
            opacity: "0.0"
        }, 150, function() {
            $("#contact-search").css({
                "display": "none"
            });
            $("#phone-plus-icon").animate({
                opacity: "1.0",
                display: "block",
            }, 150);
        });
    }

    ContactSearchActive = !ContactSearchActive;
});

PS.Phone.Functions.SetupRecentCalls = function(recentcalls) {
    $(".phone-recent-calls").html("");

    if (recentcalls) {
        recentcalls = JSON.parse(recentcalls);
    }

    recentcalls = recentcalls.reverse();

    $.each(recentcalls, function(i, recentCall) {
        var FirstLetter = (recentCall.display).charAt(0);
        var TypeIcon = 'fas fa-phone-slash';
        var IconStyle = "color: #e74c3c;";
        if (recentCall.type === "outgoing") {
            TypeIcon = 'fas fa-phone-volume';
            var IconStyle = "color: #2ecc71; font-size: 1.4vh;";
        }

        var time = new Date(recentCall.created);

        var ano = time.getYear();
        var mes = time.getMonth();
        var dia = time.getDay();
        var hours = time.getHours();
        var minutes = time.getMinutes();

        if (hours < 10) {
            hours = "0" + hours
        }

        if (minutes < 10) {
            minutes = "0" + minutes
        }

        if (dia < 10) {
            dia = "0" + dia
        }

        if (mes < 10) {
            mes = "0" + mes
        }

        time = dia + "/" + mes + " " + hours + ":" + minutes;

        var elem = '<div class="phone-recent-call" id="recent-' + i + '"><div class="phone-recent-call-image">' + FirstLetter + '</div> <div class="phone-recent-call-name">' + recentCall.display + '</div> <div class="phone-recent-call-type"><i class="' + TypeIcon + '" style="' + IconStyle + '"></i></div> <div class="phone-recent-call-time">' + time + '</div> </div>'

        $(".phone-recent-calls").append(elem);
        $("#recent-" + i).data('recentData', recentCall);
    });
}

$(document).on('click', '.phone-recent-call', function(e) {
    e.preventDefault();

    var RecendId = $(this).attr('id');
    var RecentData = $("#" + RecendId).data('recentData');

    cData = {
        number: RecentData.number,
        name: RecentData.name
    }

    var name = cData.name;

    $.post('http://ps_phone/CallContact', JSON.stringify({
        ContactData: cData,
        Anonymous: PS.Phone.Data.AnonymousCall,
    }), function(status) {
        if (cData.number !== PS.Phone.Data.UserData.identity.phone) {
            if (status.IsOnline) {
                if (status.CanCall) {
                    if (!status.InCall) {

                        PS.Phone.Audio = new Audio("/html/sound/Phone_Call_Sound_Effect.ogg");
                        PS.Phone.Audio.volume = 1;
                        PS.Phone.Audio.loop = !0;
                        PS.Phone.Audio.play();

                        if (PS.Phone.Data.AnonymousCall) {
                            PS.Phone.Notifications.Add("fas fa-phone", "Telefone", "Você iniciou uma chamada anônima! ");
                        }
                        $(".phone-call-outgoing").css({
                            "display": "block"
                        });
                        $(".phone-call-incoming").css({
                            "display": "none"
                        });
                        $(".phone-call-ongoing").css({
                            "display": "none"
                        });
                        $(".phone-call-outgoing-caller").html(name);
                        PS.Phone.Functions.HeaderTextColor("white", 400);
                        PS.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
                        setTimeout(function() {
                            $(".phone-app").css({
                                "display": "none"
                            });
                            PS.Phone.Animations.TopSlideDown('.phone-application-container', 400, 0);
                            PS.Phone.Functions.ToggleApp("phone-call", "block");
                        }, 450);

                        CallData.name = cData.name;
                        CallData.number = cData.number;

                        PS.Phone.Data.currentApplication = "phone-call";
                    } else {
                        PS.Phone.Notifications.Add("fas fa-phone", "Telefone", "Você já está ocupado!");
                    }
                } else {
                    PS.Phone.Notifications.Add("fas fa-phone", "Telefone", "Essa pessoa está em outra ligação!");
                }
            } else {
                PS.Phone.Notifications.Add("fas fa-phone", "Telefone", "Esta pessoa não está disponível!");
            }
        } else {
            PS.Phone.Notifications.Add("fas fa-phone", "Telefone", "Você não pode ligar para o seu próprio número!");
        }
    });
});

$(document).on('click', ".phone-keypad-key-call", function(e) {
    e.preventDefault();

    var InputNum = $("#phone-keypad-input").text();

    cData = {
        number: InputNum,
        name: InputNum,
    }

    var name = cData.name;

    $.post('http://ps_phone/CallContact', JSON.stringify({
        ContactData: cData,
        Anonymous: PS.Phone.Data.AnonymousCall,
    }), function(status) {
        if (cData.number !== PS.Phone.Data.UserData.identity.phone) {
            if (status.IsOnline) {
                if (status.CanCall) {
                    if (!status.InCall) {

                        PS.Phone.Audio = new Audio("/html/sound/Phone_Call_Sound_Effect.ogg");
                        PS.Phone.Audio.volume = 1;
                        PS.Phone.Audio.loop = !0;
                        PS.Phone.Audio.play();
                        $(".phone-call-outgoing").css({
                            "display": "block"
                        });
                        $(".phone-call-incoming").css({
                            "display": "none"
                        });
                        $(".phone-call-ongoing").css({
                            "display": "none"
                        });
                        $(".phone-call-outgoing-caller").html(name);
                        PS.Phone.Functions.HeaderTextColor("white", 400);
                        PS.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
                        setTimeout(function() {
                            $(".phone-app").css({
                                "display": "none"
                            });
                            PS.Phone.Animations.TopSlideDown('.phone-application-container', 400, 0);
                            PS.Phone.Functions.ToggleApp("phone-call", "block");
                        }, 450);

                        CallData.name = cData.name;
                        CallData.number = cData.number;

                        PS.Phone.Data.currentApplication = "phone-call";
                    } else {
                        PS.Phone.Notifications.Add("fas fa-phone", "Telefone", "Você já está ocupado!");
                    }
                } else {
                    PS.Phone.Notifications.Add("fas fa-phone", "Telefone", "Essa pessoa está em outra ligação!");
                }
            } else {
                PS.Phone.Notifications.Add("fas fa-phone", "Telefone", "Esta pessoa não está disponível!");
            }
        } else {
            PS.Phone.Notifications.Add("fas fa-phone", "Telefone", "Você não pode ligar para o seu próprio número!");
        }
    });
});

$(document).on('click', ".phone-keypad-key-clear", function(e) {
    e.preventDefault();

    $("#phone-keypad-input").text("Limpo")
    ClearNumberTimer = setTimeout(function() {
        $("#phone-keypad-input").text("");
        ClearNumberTimer = null;
    }, 750);
});

PS.Phone.Functions.LoadContacts = function(myContacts) {
    var ContactsObject = $(".phone-contact-list");
    $(ContactsObject).html("");
    var TotalContacts = 0;

    $(".phone-contacts").hide();
    $(".phone-recent").hide();
    $(".phone-keypad").hide();

    $(".phone-" + CurrentFooterTab).show();

    $("#contact-search").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $(".phone-contact-list .phone-contact").filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
        });
    });

    if (myContacts !== null) {
        $.each(myContacts, function(i, contact) {
            var ContactElement = '<div class="phone-contact" data-contactid="' + i + '"><div class="phone-contact-firstletter" style="background-color: #e74c3c;">' + contact.display.charAt(0).toUpperCase() + '</div><div class="phone-contact-name">' + contact.display + '</div><div class="phone-contact-actions"><i class="fas fa-sort-down"></i></div><div class="phone-contact-action-buttons"> <i class="fas fa-phone-volume" id="phone-start-call"></i> <i class="fas fa-comment" id="new-chat-message"></i> <i class="fab fa-whatsapp" id="new-chat-phone" style="font-size: 2.5vh;"></i> <i class="fas fa-user-edit" id="edit-contact"></i> </div></div>'
                // var ContactElement = '<div class="phone-contact" data-contactid="' + i + '"><div class="phone-contact-firstletter" style="background-color: #e74c3c;">' + contact.display.charAt(0).toUpperCase() + '</div><div class="phone-contact-name">' + contact.display + '</div><div class="phone-contact-actions"><i class="fas fa-sort-down"></i></div><div class="phone-contact-action-buttons"> <i class="fas fa-phone-volume" id="phone-start-call"></i> <i class="fab fa-whatsapp" id="new-chat-phone" style="font-size: 2.5vh;"></i> <i class="fas fa-user-edit" id="edit-contact"></i> </div></div>'
            if (contact.status) {
                ContactElement = '<div class="phone-contact" data-contactid="' + i + '"><div class="phone-contact-firstletter" style="background-color: #2ecc71;">' + contact.display.charAt(0).toUpperCase() + '</div><div class="phone-contact-name">' + contact.display + '</div><div class="phone-contact-actions"><i class="fas fa-sort-down"></i></div><div class="phone-contact-action-buttons"> <i class="fas fa-phone-volume" id="phone-start-call"></i> <i class="fas fa-comment" id="new-chat-message"></i> <i class="fab fa-whatsapp" id="new-chat-phone" style="font-size: 2.5vh;"></i> <i class="fas fa-user-edit" id="edit-contact"></i> </div></div>'
                    // ContactElement = '<div class="phone-contact" data-contactid="' + i + '"><div class="phone-contact-firstletter" style="background-color: #2ecc71;">' + contact.display.charAt(0).toUpperCase() + '</div><div class="phone-contact-name">' + contact.display + '</div><div class="phone-contact-actions"><i class="fas fa-sort-down"></i></div><div class="phone-contact-action-buttons"> <i class="fas fa-phone-volume" id="phone-start-call"></i> <i class="fab fa-whatsapp" id="new-chat-phone" style="font-size: 2.5vh;"></i> <i class="fas fa-user-edit" id="edit-contact"></i> </div></div>'
            }
            TotalContacts = TotalContacts + 1
            $(ContactsObject).append(ContactElement);
            $("[data-contactid='" + i + "']").data('contactData', contact);
        });
        $("#total-contacts").text(TotalContacts + " contatos");
    } else {
        $("#total-contacts").text("0 contatos");
    }
};

$(document).on('click', '#new-chat-phone', function(e) {
    var ContactId = $(this).parent().parent().data('contactid');
    var ContactData = $("[data-contactid='" + ContactId + "']").data('contactData');

    if (ContactData.number !== PS.Phone.Data.UserData.identity.phone) {

        $(".preload-messages-wpp").show();
        $.post('http://ps_phone/GetWhatsappChats', JSON.stringify({}), function(chats) {
            LoadWhatsappChats(chats);
        });

        $('.phone-application-container').animate({
            top: -160 + "%"
        });
        PS.Phone.Functions.HeaderTextColor("white", 400);
        setTimeout(function() {
            $('.phone-application-container').animate({
                top: 0 + "%"
            });

            PS.Phone.Functions.ToggleApp("phone", "none");
            PS.Phone.Functions.ToggleApp("whatsapp", "block");
            PS.Phone.Data.currentApplication = "whatsapp";

            $.post('http://ps_phone/GetWhatsappChat', JSON.stringify({
                phone: ContactData.number
            }), function(chat) {

                var data = {
                    contact_phone: ContactData.number,
                    contact_name: ContactData.display,
                    messages: JSON.parse(chat)
                }

                SetupChatMessages(data, {
                    name: ContactData.display,
                    phone: ContactData.number
                });
            });

            $('.whatsapp-openedchat-messages').animate({
                scrollTop: 9999
            }, 150);
            $(".whatsapp-openedchat").css({
                "display": "block"
            });
            $(".whatsapp-openedchat").css({
                left: 0 + "vh"
            });
            $(".whatsapp-chats").animate({
                left: 30 + "vh"
            }, 100, function() {
                $(".whatsapp-chats").css({
                    "display": "none"
                });
            });
        }, 400)
    } else {
        PS.Phone.Notifications.Add("fa fa-phone-alt", "Telefone", "Você não pode mandar mensagens para você mesmo", "default", 3500);
    }
});

$(document).on('click', '#new-chat-message', function(e) {
    var ContactId = $(this).parent().parent().data('contactid');
    var ContactData = $("[data-contactid='" + ContactId + "']").data('contactData');

    if (ContactData.number !== PS.Phone.Data.UserData.identity.phone) {

        $(".preload-messages-imessage").show();
        $.post('http://ps_phone/GetMessages', JSON.stringify({}), function(messages) {
            PS.Phone.Functions.LoadMessages(messages);
        });

        $('.phone-application-container').animate({
            top: -160 + "%"
        });
        PS.Phone.Functions.HeaderTextColor("white", 400);
        setTimeout(function() {
            $('.phone-application-container').animate({
                top: 0 + "%"
            });

            PS.Phone.Functions.ToggleApp("phone", "none");
            PS.Phone.Functions.ToggleApp("messages", "block");
            PS.Phone.Data.currentApplication = "messages";

            if (ContactData.number == PS.Phone.Data.UserData.identity.phone) {
                var type = 'phone';
                var phone = ContactData.number;
            } else {
                var type = 'number';
                var phone = ContactData.number;
            }

            var data = {
                phone: PS.Phone.Data.UserData.identity.phone,
                number: ContactData.number
            }

            OpenedChatData.messagesdata = data;

            $.post('http://ps_phone/GetMessagesChat', JSON.stringify({
                type: type,
                phone: phone
            }), function(chat) {

                var messages = JSON.parse(chat);

                SetupMessages(messages);
            });

            $('.phone-containter .phone').animate({ scrollTop: 9999 }, 150);

            $(".messages-openedchat header h1").text(ContactData.display);

            $(".messages-openedchat").css({ "display": "block" });
            $(".messages-openedchat").animate({
                left: 0 + "vh"
            }, 200);
        }, 400);
    } else {
        PS.Phone.Notifications.Add("fa fa-phone-alt", "Telefone", "Você não pode mandar mensagens para você mesmo", "default", 3500);
    }
});

var CurrentEditContactData = {}

$(document).on('click', '#edit-contact', function(e) {
    e.preventDefault();
    var ContactId = $(this).parent().parent().data('contactid');
    var ContactData = $("[data-contactid='" + ContactId + "']").data('contactData');

    console.log(ContactData);

    CurrentEditContactData.name = ContactData.display
    CurrentEditContactData.number = ContactData.number

    $(".phone-edit-contact-header").text(ContactData.display + " Editar")
    $(".phone-edit-contact-name").val(ContactData.display);
    $(".phone-edit-contact-number").val(ContactData.number);
    if (ContactData.bank != null && ContactData.bank != undefined) {
        $(".phone-edit-contact-iban").val(ContactData.bank);
        CurrentEditContactData.bank = ContactData.bank
    } else {
        $(".phone-edit-contact-iban").val("");
        CurrentEditContactData.bank = "";
    }

    PS.Phone.Animations.TopSlideDown(".phone-edit-contact", 200, 0);
});

$(document).on('click', '#edit-contact-save', function(e) {
    e.preventDefault();

    var ContactName = $(".phone-edit-contact-name").val();
    var ContactNumber = $(".phone-edit-contact-number").val();
    var ContactIban = $(".phone-edit-contact-iban").val();

    if (ContactName != "" && ContactNumber != "") {
        $.post('http://ps_phone/EditContact', JSON.stringify({
            name: ContactName,
            number: ContactNumber,
            bank: ContactIban,
            oldname: CurrentEditContactData.name,
            oldnumber: CurrentEditContactData.number,
            oldbank: CurrentEditContactData.bank,
        }), function(PhoneContacts) {
            PS.Phone.Functions.LoadContacts(PhoneContacts);
        });
        PS.Phone.Animations.TopSlideUp(".phone-edit-contact", 250, -100);
        setTimeout(function() {
            $(".phone-edit-contact-number").val("");
            $(".phone-edit-contact-name").val("");
        }, 250)
    } else {
        PS.Phone.Notifications.Add("fas fa-exclamation-circle", "Editar contato", "Preencha todos os campos!");
    }
});

$(document).on('click', '#edit-contact-delete', function(e) {
    e.preventDefault();

    var ContactName = $(".phone-edit-contact-name").val();
    var ContactNumber = $(".phone-edit-contact-number").val();
    var ContactIban = $(".phone-edit-contact-iban").val();

    $.post('http://ps_phone/DeleteContact', JSON.stringify({
        name: ContactName,
        number: ContactNumber,
        bank: ContactIban,
    }), function(PhoneContacts) {
        PS.Phone.Functions.LoadContacts(PhoneContacts);
    });
    PS.Phone.Animations.TopSlideUp(".phone-edit-contact", 250, -100);
    setTimeout(function() {
        $(".phone-edit-contact-number").val("");
        $(".phone-edit-contact-name").val("");
    }, 250);
});

$(document).on('click', '#edit-contact-cancel', function(e) {
    e.preventDefault();

    PS.Phone.Animations.TopSlideUp(".phone-edit-contact", 250, -100);
    setTimeout(function() {
        $(".phone-edit-contact-number").val("");
        $(".phone-edit-contact-name").val("");
    }, 250)
});

$(document).on('click', '.phone-keypad-key', function(e) {
    e.preventDefault();

    var PressedButton = $(this).data('keypadvalue');

    if (!isNaN(PressedButton)) {
        var keyPadHTML = $("#phone-keypad-input").text();
        $("#phone-keypad-input").text(keyPadHTML + PressedButton)
    } else if (PressedButton == "#") {
        var keyPadHTML = $("#phone-keypad-input").text();
        $("#phone-keypad-input").text(keyPadHTML + PressedButton)
    } else if (PressedButton == "-") {
        var keyPadHTML = $("#phone-keypad-input").text();
        $("#phone-keypad-input").text(keyPadHTML + PressedButton)
    } else if (PressedButton == "*") {
        if (ClearNumberTimer == null) {
            $("#phone-keypad-input").text("Limpo")
            ClearNumberTimer = setTimeout(function() {
                $("#phone-keypad-input").text("");
                ClearNumberTimer = null;
            }, 750);
        }
    }
})

var OpenedContact = null;

$(document).on('click', '.phone-contact-actions', function(e) {
    e.preventDefault();

    var FocussedContact = $(this).parent();
    var ContactId = $(FocussedContact).data('contactid');

    if (OpenedContact === null) {
        $(FocussedContact).animate({
            "height": "12vh"
        }, 150, function() {
            $(FocussedContact).find('.phone-contact-action-buttons').fadeIn(100);
        });
        OpenedContact = ContactId;
    } else if (OpenedContact == ContactId) {
        $(FocussedContact).find('.phone-contact-action-buttons').fadeOut(100, function() {
            $(FocussedContact).animate({
                "height": "4.5vh"
            }, 150);
        });
        OpenedContact = null;
    } else if (OpenedContact != ContactId) {
        var PreviousContact = $(".phone-contact-list").find('[data-contactid="' + OpenedContact + '"]');
        $(PreviousContact).find('.phone-contact-action-buttons').fadeOut(100, function() {
            $(PreviousContact).animate({
                "height": "4.5vh"
            }, 150);
            OpenedContact = ContactId;
        });
        $(FocussedContact).animate({
            "height": "12vh"
        }, 150, function() {
            $(FocussedContact).find('.phone-contact-action-buttons').fadeIn(100);
        });
    }
});


$(document).on('click', '#phone-plus-icon', function(e) {
    e.preventDefault();

    PS.Phone.Animations.TopSlideDown(".phone-add-contact", 200, 0);
});

$(document).on('click', '#add-contact-save', function(e) {
    e.preventDefault();

    var ContactName = $(".phone-add-contact-name").val();
    var ContactNumber = $(".phone-add-contact-number").val();
    var ContactIban = $(".phone-add-contact-iban").val();

    if (ContactName != "" && ContactNumber != "") {
        $.post('http://ps_phone/AddNewContact', JSON.stringify({
            ContactName: ContactName,
            ContactNumber: ContactNumber,
            ContactIban: ContactIban,
        }), function(PhoneContacts) {
            PS.Phone.Functions.LoadContacts(PhoneContacts);
        });
        PS.Phone.Animations.TopSlideUp(".phone-add-contact", 250, -100);
        setTimeout(function() {
            $(".phone-add-contact-number").val("");
            $(".phone-add-contact-name").val("");
        }, 250)

        if (SelectedSuggestion !== null) {
            $.post('http://ps_phone/RemoveSuggestion', JSON.stringify({
                data: $(SelectedSuggestion).data('SuggestionData')
            }));
            $(SelectedSuggestion).remove();
            SelectedSuggestion = null;
            var amount = parseInt(AmountOfSuggestions);
            if ((amount - 1) === 0) {
                amount = 0
            }
            $(".amount-of-suggested-contacts").html(amount + " contatos");
        }
    } else {
        PS.Phone.Notifications.Add("fas fa-exclamation-circle", "Adicionar contato", "Preencha todos os campos!");
    }
});

$(document).on('click', '#add-contact-cancel', function(e) {
    e.preventDefault();

    PS.Phone.Animations.TopSlideUp(".phone-add-contact", 250, -100);
    setTimeout(function() {
        $(".phone-add-contact-number").val("");
        $(".phone-add-contact-name").val("");
    }, 250)
});

$(document).on('click', '#phone-start-call', function(e) {
    e.preventDefault();

    var ContactId = $(this).parent().parent().data('contactid');
    var ContactData = $("[data-contactid='" + ContactId + "']").data('contactData');

    SetupCall(ContactData);
});

SetupCall = function(cData) {
    var retval = false;
    var name = cData.display;
    $.post('http://ps_phone/CallContact', JSON.stringify({
        ContactData: cData,
        Anonymous: PS.Phone.Data.AnonymousCall,
    }), function(status) {
        if (cData.number !== PS.Phone.Data.UserData.identity.phone) {
            if (status.IsOnline) {
                if (status.CanCall) {
                    if (!status.InCall) {

                        PS.Phone.Audio = new Audio("/html/sound/Phone_Call_Sound_Effect.ogg");
                        PS.Phone.Audio.volume = 1;
                        PS.Phone.Audio.loop = !0;
                        PS.Phone.Audio.play();

                        $(".phone-call-outgoing").css({
                            "display": "block"
                        });
                        $(".phone-call-incoming").css({
                            "display": "none"
                        });
                        $(".phone-call-ongoing").css({
                            "display": "none"
                        });
                        $(".phone-call-outgoing-caller").html(name);
                        PS.Phone.Functions.HeaderTextColor("white", 400);
                        PS.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
                        setTimeout(function() {
                            $(".phone-app").css({
                                "display": "none"
                            });
                            PS.Phone.Animations.TopSlideDown('.phone-application-container', 400, 0);
                            PS.Phone.Functions.ToggleApp("phone-call", "block");
                        }, 450);

                        CallData.name = cData.name;
                        CallData.number = cData.number;

                        PS.Phone.Data.currentApplication = "phone-call";
                    } else {
                        PS.Phone.Notifications.Add("fas fa-phone", "Telefone", "Você já está ocupado!");
                    }
                } else {
                    PS.Phone.Notifications.Add("fas fa-phone", "Telefone", "Essa pessoa está em outra ligação!");
                }
            } else {
                PS.Phone.Notifications.Add("fas fa-phone", "Telefone", "Esta pessoa não está disponível!");
            }
        } else {
            PS.Phone.Notifications.Add("fas fa-phone", "Telefone", "Você não pode ligar para o seu próprio número! ");
        }
    });
}

CancelOutgoingCall = function() {
    if (PS.Phone.Data.currentApplication == "phone-call") {
        PS.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
        PS.Phone.Animations.TopSlideUp('.' + PS.Phone.Data.currentApplication + "-app", 400, -160);
        setTimeout(function() {
            PS.Phone.Functions.ToggleApp(PS.Phone.Data.currentApplication, "none");
        }, 400)
        PS.Phone.Functions.HeaderTextColor("white", 300);

        PS.Phone.Data.CallActive = false;
        PS.Phone.Data.currentApplication = null;
    }
}

$(document).on('click', '#outgoing-cancel', function(e) {
    e.preventDefault();

    if (PS.Phone.Audio) {
        PS.Phone.Audio.pause();
    }

    $.post('http://ps_phone/CancelOutgoingCall');
});

$(document).on('click', '#incoming-deny', function(e) {
    e.preventDefault();

    if (PS.Phone.Audio) {
        PS.Phone.Audio.pause();
    }

    $.post('http://ps_phone/DenyIncomingCall');
});

$(document).on('click', '#ongoing-cancel', function(e) {
    e.preventDefault();

    if (PS.Phone.Audio) {
        PS.Phone.Audio.pause();
    }

    $.post('http://ps_phone/CancelOngoingCall');
});

IncomingCallAlert = function(CallData, Canceled, AnonymousCall) {
    if (!Canceled) {
        if (!PS.Phone.Data.CallActive) {
            PS.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
            PS.Phone.Animations.TopSlideUp('.' + PS.Phone.Data.currentApplication + "-app", 400, -160);
            setTimeout(function() {

                var name = "";

                if (CallData.name) {
                    var name = CallData.name;
                }

                if (CallData.display) {
                    var name = CallData.display;
                }

                var Label = "Você tem uma chamada recebida de " + name

                if (AnonymousCall) {
                    Label = "Você tem uma chamada recebida de um número ânonimo"
                }

                PS.Phone.Audio = new Audio("/html/sound/ring.ogg");
                PS.Phone.Audio.volume = 1;
                PS.Phone.Audio.loop = !0;
                PS.Phone.Audio.play();

                $(".call-notifications-title").html("Chamada recebida ");
                $(".call-notifications-content").html(Label);
                $(".call-notifications").css({
                    "display": "block"
                });
                $(".call-notifications").animate({
                    right: 5 + "vh"
                }, 400);
                $(".phone-call-outgoing").css({
                    "display": "none"
                });
                $(".phone-call-incoming").css({
                    "display": "block"
                });
                $(".phone-call-ongoing").css({
                    "display": "none"
                });
                $(".phone-call-incoming-caller").html(name);
                $(".phone-app").css({
                    "display": "none"
                });
                PS.Phone.Functions.HeaderTextColor("white", 400);
                $("." + PS.Phone.Data.currentApplication + "-app").css({
                    "display": "none"
                });
                $(".phone-call-app").css({
                    "display": "block"
                });
                setTimeout(function() {
                    PS.Phone.Animations.TopSlideDown('.phone-application-container', 400, 0);
                }, 400);
            }, 400);

            PS.Phone.Data.currentApplication = "phone-call";
            PS.Phone.Data.CallActive = true;
        }
        setTimeout(function() {
            $(".call-notifications").addClass('call-notifications-shake');
            setTimeout(function() {
                $(".call-notifications").removeClass('call-notifications-shake');
            }, 1000);
        }, 400);
    } else {
        $(".call-notifications").animate({
            right: -35 + "vh"
        }, 400);
        PS.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
        PS.Phone.Animations.TopSlideUp('.' + PS.Phone.Data.currentApplication + "-app", 400, -160);
        setTimeout(function() {
            $("." + PS.Phone.Data.currentApplication + "-app").css({
                "display": "none"
            });
            $(".phone-call-outgoing").css({
                "display": "none"
            });
            $(".phone-call-incoming").css({
                "display": "none"
            });
            $(".phone-call-ongoing").css({
                "display": "none"
            });
        }, 400)
        PS.Phone.Functions.HeaderTextColor("white", 300);
        PS.Phone.Data.CallActive = false;
        PS.Phone.Data.currentApplication = null;
    }
}

PS.Phone.Functions.SetupCurrentCall = function(cData) {
    if (cData.InCall) {
        CallData = cData;
        $(".phone-currentcall-container").css({
            "display": "block"
        });

        if (cData.CallType == "incoming") {
            $(".phone-currentcall-title").html("Chamada recebida");
        } else if (cData.CallType == "outgoing") {
            $(".phone-currentcall-title").html("Ligação em andamento");
        } else if (cData.CallType == "ongoing") {
            $(".phone-currentcall-title").html("Ligação (" + cData.CallTime + ")");
        }

        var name = "";

        if (cData.TargetData.name) {
            name = cData.TargetData.name;
        }

        if (cData.TargetData.display) {
            name = cData.TargetData.display;
        }

        $(".phone-currentcall-contact").html("com: " + name);
    } else {
        $(".phone-currentcall-container").css({
            "display": "none"
        });
    }
}

$(document).on('click', '.phone-currentcall-container', function(e) {
    e.preventDefault();

    if (CallData.CallType == "incoming") {
        $(".phone-call-incoming").css({
            "display": "block"
        });
        $(".phone-call-outgoing").css({
            "display": "none"
        });
        $(".phone-call-ongoing").css({
            "display": "none"
        });
    } else if (CallData.CallType == "outgoing") {
        $(".phone-call-incoming").css({
            "display": "none"
        });
        $(".phone-call-outgoing").css({
            "display": "block"
        });
        $(".phone-call-ongoing").css({
            "display": "none"
        });
    } else if (CallData.CallType == "ongoing") {
        $(".phone-call-incoming").css({
            "display": "none"
        });
        $(".phone-call-outgoing").css({
            "display": "none"
        });
        $(".phone-call-ongoing").css({
            "display": "block"
        });
    }

    var name = "";

    if (CallData.name) {
        name = CallData.name;
    }

    if (CallData.display) {
        name = CallData.display;
    }

    $(".phone-call-ongoing-caller").html(name);

    PS.Phone.Functions.HeaderTextColor("white", 500);
    PS.Phone.Animations.TopSlideDown('.phone-application-container', 500, 0);
    PS.Phone.Animations.TopSlideDown('.phone-call-app', 500, 0);
    PS.Phone.Functions.ToggleApp("phone-call", "block");

    PS.Phone.Data.currentApplication = "phone-call";
});

$(document).on('click', '#incoming-answer', function(e) {
    e.preventDefault();

    if (PS.Phone.Audio) {
        PS.Phone.Audio.pause();
    }

    $.post('http://ps_phone/AnswerCall');
});

PS.Phone.Functions.AnswerCall = function(CallData) {
    $(".phone-call-incoming").css({
        "display": "none"
    });
    $(".phone-call-outgoing").css({
        "display": "none"
    });
    $(".phone-call-ongoing").css({
        "display": "block"
    });

    var name = "";

    if (CallData.TargetData.name) {
        name = CallData.TargetData.name;
    }

    if (CallData.TargetData.display) {
        name = CallData.TargetData.display;
    }

    $(".phone-call-ongoing-caller").html(name);

    PS.Phone.Functions.Close();
}

PS.Phone.Functions.SetupSuggestedContacts = function(Suggested) {
    $(".suggested-contacts").html("");
    AmountOfSuggestions = Suggested.length;
    if (AmountOfSuggestions > 0) {
        $(".amount-of-suggested-contacts").html(AmountOfSuggestions + " contacten");
        Suggested = Suggested.reverse();
        $.each(Suggested, function(index, suggest) {
            var elem = '<div class="suggested-contact" id="suggest-' + index + '"> <i class="fas fa-exclamation-circle"></i> <span class="suggested-name">' + suggest.name[0] + ' ' + suggest.name[1] + ' &middot; <span class="suggested-number">' + suggest.number + '</span></span> </div>';
            $(".suggested-contacts").append(elem);
            $("#suggest-" + index).data('SuggestionData', suggest);
        });
    } else {
        $(".amount-of-suggested-contacts").html("0 contacten");
    }
}

$(document).on('click', '.suggested-contact', function(e) {
    e.preventDefault();

    var SuggestionData = $(this).data('SuggestionData');
    SelectedSuggestion = this;

    PS.Phone.Animations.TopSlideDown(".phone-add-contact", 200, 0);

    $(".phone-add-contact-name").val(SuggestionData.name[0] + " " + SuggestionData.name[1]);
    $(".phone-add-contact-number").val(SuggestionData.number);
    $(".phone-add-contact-iban").val(SuggestionData.bank);
});