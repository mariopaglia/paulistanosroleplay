PS = {}
PS.Phone = {}
PS.Screen = {}
PS.Phone.Functions = {}
PS.Phone.Animations = {}
PS.Phone.Notifications = {}
PS.Phone.ContactColors = {
    0: "#9b59b6",
    1: "#3498db",
    2: "#e67e22",
    3: "#e74c3c",
    4: "#1abc9c",
    5: "#9c88ff",
}

PS.Phone.Data = {
    currentApplication: null,
    UserData: {},
    Applications: {},
    IsOpen: false,
    CallActive: false,
    MetaData: {},
    AnonymousCall: false,
    NoturnMode: false,
    SendLocation: false,
    InstagramAccount: null,
    WhatsAppAccount: null,
    TwiiterAccount: null,
}

OpenedChatData = {
    phone: null,
    group: null,
    messages: null,
    messagesdata: null,
}

var iphost = "http://127.0.0.1/";

PS.Phone.Audio = null;

var CanOpenApp = true;

PS.Phone.Functions.SetupAppWarnings = function(AppData) {
    $.each(AppData, function(i, app) {
        var AppObject = $(".phone-applications").find("[data-appslot='" + app.slot + "']").find('.app-unread-alerts');

        if (app.Alerts > 0) {
            $(AppObject).html(app.Alerts);
            $(AppObject).css({
                "display": "block"
            });
        } else {
            $(AppObject).css({
                "display": "none"
            });
        }
    });
}

PS.Phone.Functions.IsAppHeaderAllowed = function(app) {
    var retval = true;
    $.each(Config.HeaderDisabledApps, function(i, blocked) {
        if (app == blocked) {
            retval = false;
        }
    });
    return retval;
}

$(document).on('click', '.phone-application', function(e) {
    e.preventDefault();
    var PressedApplication = $(this).data('app');
    var AppObject = $("." + PressedApplication + "-app");

    if (AppObject.length !== 0) {
        if (CanOpenApp) {
            if (PS.Phone.Data.currentApplication == null) {
                PS.Phone.Animations.TopSlideDown('.phone-application-container', 300, 0);
                PS.Phone.Functions.ToggleApp(PressedApplication, "block");

                if (PS.Phone.Functions.IsAppHeaderAllowed(PressedApplication)) {
                    PS.Phone.Functions.HeaderTextColor("black", 300);
                }

                PS.Phone.Data.currentApplication = PressedApplication;

                if (PressedApplication != "bank") {
                    $(".phone-navigation .navigation-center").addClass("black");
                } else {
                    $(".phone-navigation .navigation-center").removeClass("black");
                }

                if (PressedApplication == "settings") {
                    $("#myPhoneNumber").text(PS.Phone.Data.UserData.identity.phone);
                } else if (PressedApplication == "twitter") {
                    $.post('http://ps_phone/GetUserProfileTwitter', JSON.stringify({}), function(account) {
                        PS.Phone.Functions.ReceiveAccountTwitter(account);
                    });
                } else if (PressedApplication == "bank") {
                    PS.Phone.Functions.DoBankOpen();
                    $.post('http://ps_phone/GetBankContacts', JSON.stringify({}), function(contacts) {
                        PS.Phone.Functions.LoadContactsWithNumber(contacts);
                    });
                    $.post('http://ps_phone/GetInvoices', JSON.stringify({}), function(invoices) {
                        PS.Phone.Functions.LoadBankInvoices(invoices);
                    });
                } else if (PressedApplication == "whatsapp") {
                    $.post('http://ps_phone/GetUserProfileWhatsApp', JSON.stringify({}), function(account) {
                        PS.Phone.Functions.ReceiveAccountWhatsApp(account);
                    });

                } else if (PressedApplication == "phone") {
                    $.post('http://ps_phone/GetMissedCalls', JSON.stringify({}), function(recent) {
                        PS.Phone.Functions.SetupRecentCalls(recent);
                    });
                    $.post('http://ps_phone/GetContacts', JSON.stringify({}));
                } else if (PressedApplication == "instagram") {
                    $.post('http://ps_phone/GetUserProfileInsta', JSON.stringify({}), function(account) {
                        PS.Phone.Functions.ReceiveAccount(account);
                    });
                } else if (PressedApplication == "messages") {
                    $.post('http://ps_phone/GetMessages', JSON.stringify({}), function(messages) {
                        PS.Phone.Functions.LoadMessages(messages)
                    });
                }
            }
        }
    } else {
        // PS.Phone.Notifications.Add("fas fa-exclamation-circle", "Systeem", PS.Phone.Data.Applications[PressedApplication].tooltipText + " is niet beschikbaar!")
    }
});

$(document).on('click', '.navigation-center', function(event) {
    event.preventDefault();

    $(this).removeClass('black');

    if (PS.Phone.Data.currentApplication === null) {
        PS.Phone.Functions.Close();
    } else {
        PS.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
        PS.Phone.Animations.TopSlideUp('.' + PS.Phone.Data.currentApplication + "-app", 400, -160);
        CanOpenApp = false;
        setTimeout(function() {
            PS.Phone.Functions.ToggleApp(PS.Phone.Data.currentApplication, "none");
            CanOpenApp = true;
        }, 400)
        PS.Phone.Functions.HeaderTextColor("white", 300);

        if (PS.Phone.Data.currentApplication == "whatsapp") {
            if (OpenedChatData.phone !== null) {
                setTimeout(function() {
                    $(".whatsapp-chats").css({
                        "display": "block"
                    });
                    $(".whatsapp-chats").animate({
                        left: 0 + "vh"
                    }, 1);
                    $(".whatsapp-openedchat").animate({
                        left: -30 + "vh"
                    }, 1, function() {
                        $(".whatsapp-openedchat").css({
                            "display": "none"
                        });
                    });
                    OpenedChatPicture = null;
                    OpenedChatData.phone = null;
                }, 450);
            }
        } else if (PS.Phone.Data.currentApplication == "bank") {
            if (CurrentTab == "invoices") {
                setTimeout(function() {
                    $(".bank-app-invoices").animate({
                        "left": "30vh"
                    });
                    $(".bank-app-invoices").css({
                        "display": "none"
                    })
                    $(".bank-app-accounts").css({
                        "display": "block"
                    })
                    $(".bank-app-accounts").css({
                        "left": "0vh"
                    });

                    var InvoicesObjectBank = $(".bank-app-header").find('[data-headertype="invoices"]');
                    var HomeObjectBank = $(".bank-app-header").find('[data-headertype="accounts"]');

                    $(InvoicesObjectBank).removeClass('bank-app-header-button-selected');
                    $(HomeObjectBank).addClass('bank-app-header-button-selected');

                    CurrentTab = "accounts";
                }, 400)
            }
        } else if (PS.Phone.Data.currentApplication == "meos") {
            $(".meos-alert-new").remove();
            setTimeout(function() {
                $(".meos-recent-alert").removeClass("noodknop");
                $(".meos-recent-alert").css({
                    "background-color": "#004682"
                });
            }, 400)
        }

        PS.Phone.Data.currentApplication = null;
    }
});

PS.Phone.Functions.Open = function(data) {
    PS.Phone.Animations.BottomSlideUp('.container', 300, 0);
    PS.Phone.Data.IsOpen = true;
}

PS.Phone.Functions.ToggleApp = function(app, show) {
    $("." + app + "-app").css({
        "display": show
    });
}

PS.Phone.Functions.Close = function() {

    if (PS.Phone.Data.currentApplication == "whatsapp") {
        setTimeout(function() {
            PS.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
            PS.Phone.Animations.TopSlideUp('.' + PS.Phone.Data.currentApplication + "-app", 400, -160);
            $(".whatsapp-app").css({
                "display": "none"
            });
            PS.Phone.Functions.HeaderTextColor("white", 300);

            if (OpenedChatData.phone !== null) {
                setTimeout(function() {
                    $(".whatsapp-chats").css({
                        "display": "block"
                    });
                    $(".whatsapp-chats").animate({
                        left: 0 + "vh"
                    }, 1);
                    $(".whatsapp-openedchat").animate({
                        left: -30 + "vh"
                    }, 1, function() {
                        $(".whatsapp-openedchat").css({
                            "display": "none"
                        });
                    });
                    OpenedChatData.phone = null;
                }, 450);
            }
            OpenedChatPicture = null;
            PS.Phone.Data.currentApplication = null;
        }, 500)
    } else if (PS.Phone.Data.currentApplication == "meos") {
        $(".meos-alert-new").remove();
        $(".meos-recent-alert").removeClass("noodknop");
        $(".meos-recent-alert").css({
            "background-color": "#004682"
        });
    }

    PS.Phone.Animations.BottomSlideDown('.container', 300, -85);
    $.post('http://ps_phone/Close');
    PS.Phone.Data.IsOpen = false;
}

PS.Phone.Functions.HeaderTextColor = function(newColor, Timeout) {
    $(".phone-header").animate({
        color: newColor
    }, Timeout);
}

PS.Phone.Animations.BottomSlideUp = function(Object, Timeout, Percentage) {
    $(Object).css({
        'display': 'block'
    }).animate({
        bottom: Percentage + "%",
    }, Timeout);
}

PS.Phone.Animations.BottomSlideDown = function(Object, Timeout, Percentage) {
    $(Object).css({
        'display': 'block'
    }).animate({
        bottom: Percentage + "%",
    }, Timeout, function() {
        $(Object).css({
            'display': 'none'
        });
    });
}

PS.Phone.Animations.TopSlideDown = function(Object, Timeout, Percentage) {
    $(Object).css({
        'display': 'block'
    }).animate({
        top: Percentage + "%",
    }, Timeout);
}

PS.Phone.Animations.TopSlideUp = function(Object, Timeout, Percentage, cb) {
    $(Object).css({
        'display': 'block'
    }).animate({
        top: Percentage + "%",
    }, Timeout, function() {
        $(Object).css({
            'display': 'none'
        });
    });
}

PS.Phone.Notifications.Add = function(icon, title, text, color, timeout) {
    $.post('http://ps_phone/HasPhone', JSON.stringify({}), function(HasPhone) {
        if (HasPhone) {
            if (timeout == null && timeout == undefined) {
                timeout = 1500;
            }
            if (PS.Phone.Notifications.Timeout == undefined || PS.Phone.Notifications.Timeout == null) {
                if (color != null || color != undefined) {
                    $(".notification-icon").css({
                        "color": color
                    });
                    $(".notification-title").css({
                        "color": color
                    });
                } else if (color == "default" || color == null || color == undefined) {
                    $(".notification-icon").css({
                        "color": "#e74c3c"
                    });
                    $(".notification-title").css({
                        "color": "#e74c3c"
                    });
                }
                PS.Phone.Animations.TopSlideDown(".phone-notification-container", 200, 8);
                if (icon !== "politie") {
                    $(".notification-icon").html('<i class="' + icon + '"></i>');
                } else {
                    $(".notification-icon").html('<img src="./img/politie.png" class="police-icon-notify">');
                }
                $(".notification-title").html(title);
                $(".notification-text").html(text);
                if (PS.Phone.Notifications.Timeout !== undefined || PS.Phone.Notifications.Timeout !== null) {
                    clearTimeout(PS.Phone.Notifications.Timeout);
                }
                PS.Phone.Notifications.Timeout = setTimeout(function() {
                    PS.Phone.Animations.TopSlideUp(".phone-notification-container", 200, -8);
                    PS.Phone.Notifications.Timeout = null;
                }, timeout);
            } else {
                if (color != null || color != undefined) {
                    $(".notification-icon").css({
                        "color": color
                    });
                    $(".notification-title").css({
                        "color": color
                    });
                } else {
                    $(".notification-icon").css({
                        "color": "#e74c3c"
                    });
                    $(".notification-title").css({
                        "color": "#e74c3c"
                    });
                }
                $(".notification-icon").html('<i class="' + icon + '"></i>');
                $(".notification-title").html(title);
                $(".notification-text").html(text);
                if (PS.Phone.Notifications.Timeout !== undefined || PS.Phone.Notifications.Timeout !== null) {
                    clearTimeout(PS.Phone.Notifications.Timeout);
                }
                PS.Phone.Notifications.Timeout = setTimeout(function() {
                    PS.Phone.Animations.TopSlideUp(".phone-notification-container", 200, -8);
                    PS.Phone.Notifications.Timeout = null;
                }, timeout);
            }
        }
    });
}

PS.Phone.Functions.LoadPhoneData = function(data) {
    PS.Phone.Data.UserData = data.UserData;
    PS.Phone.Functions.LoadBackground(data.PhoneData.background);
    if (PS.Phone.Functions.LoadContacts() != undefined) {
        PS.Phone.Functions.LoadContacts(data.PhoneData.Contacts);

    }
}

PS.Phone.Functions.UpdateTime = function(data) {
    var NewDate = new Date();
    var NewHour = NewDate.getHours();
    var NewMinute = NewDate.getMinutes();
    var Minutessss = NewMinute;
    var Hourssssss = NewHour;
    if (NewHour < 10) {
        Hourssssss = "0" + Hourssssss;
    }
    if (NewMinute < 10) {
        Minutessss = "0" + NewMinute;
    }
    var MessageTime = Hourssssss + ":" + Minutessss

}

var NotificationTimeout = null;

PS.Screen.Notification = function(title, content, icon, timeout, color) {
    $.post('http://ps_phone/HasPhone', JSON.stringify({}), function(HasPhone) {
        if (HasPhone) {
            if (color != null && color != undefined) {
                $(".screen-notifications-container").css({
                    "background-color": color
                });
            }
            $(".screen-notification-icon").html('<i class="' + icon + '"></i>');
            $(".screen-notification-title").text(title);
            $(".screen-notification-content").text(content);
            $(".screen-notifications-container").css({
                'display': 'block'
            }).animate({
                right: 5 + "vh",
            }, 200);

            if (NotificationTimeout != null) {
                clearTimeout(NotificationTimeout);
            }

            NotificationTimeout = setTimeout(function() {
                $(".screen-notifications-container").animate({
                    right: -35 + "vh",
                }, 200, function() {
                    $(".screen-notifications-container").css({
                        'display': 'none'
                    });
                });
                NotificationTimeout = null;
            }, timeout);
        }
    });
}

// PS.Screen.Notification("Nieuwe Tweet", "Dit is een test tweet like #YOLO", "fab fa-twitter", 4000);

$(document).ready(function() {
    moment.locale('pt-br');
    var deviceTime = document.querySelector('#phone-time');
    deviceTime.innerHTML = moment().format('LT');

    setInterval(function() {
        deviceTime.innerHTML = moment().format('LT');
    }, 1000);

    var deviceTimeHour = document.querySelector('#phone-time-hour');
    var deviceTimeWeeked = document.querySelector('#phone-time-weeked');
    deviceTimeHour.innerHTML = moment().format('LT');
    deviceTimeWeeked.innerHTML = moment().format('LL');

    setInterval(function() {
        deviceTimeHour.innerHTML = moment().format('LT');
        deviceTimeWeeked.innerHTML = moment().format('LL');
    }, 1000);


    window.addEventListener('message', function(event) {
        switch (event.data.action) {
            case "open":
                PS.Phone.Functions.Open(event.data);
                PS.Phone.Functions.SetupAppWarnings(event.data.AppData);
                PS.Phone.Functions.SetupCurrentCall(event.data.CallData);
                PS.Phone.Data.IsOpen = true;
                PS.Phone.Data.UserData = event.data.UserData;
                break;
                // case "LoadPhoneApplications":
                //     PS.Phone.Functions.SetupApplications(event.data);
                //     break;
            case "LoadPhoneData":
                PS.Phone.Functions.LoadPhoneData(event.data);
                break;
            case "UpdateTime":
                PS.Phone.Functions.UpdateTime(event.data);
                break;
            case "Notification":
                PS.Screen.Notification(event.data.NotifyData.title, event.data.NotifyData.content, event.data.NotifyData.icon, event.data.NotifyData.timeout, event.data.NotifyData.color);
                break;
            case "PhoneNotification":
                PS.Phone.Notifications.Add(event.data.PhoneNotify.icon, event.data.PhoneNotify.title, event.data.PhoneNotify.text, event.data.PhoneNotify.color, event.data.PhoneNotify.timeout);
                break;
            case "RefreshAppAlerts":
                PS.Phone.Functions.SetupAppWarnings(event.data.AppData);
                break;
            case "UpdateMentionedTweets":
                PS.Phone.Notifications.LoadMentionedTweets(event.data.Tweets);
                break;
            case "UpdateBank":
                $(".bank-app-account-balance").html("&#36; " + event.data.NewBalance);
                $(".bank-app-account-balance").data('balance', event.data.NewBalance);
                break;
            case "UpdateChat":
                if (PS.Phone.Data.currentApplication == "whatsapp") {
                    if (OpenedChatData.phone !== null && OpenedChatData.phone == event.data.chatNumber) {
                        PS.Phone.Functions.SetupChatMessages(event.data.chatData);
                    } else {
                        PS.Phone.Functions.LoadWhatsappChats(event.data.Chats);
                    }
                }
                break;
            case "UpdateHashtags":
                PS.Phone.Notifications.LoadHashtags(event.data.Hashtags);
                break;
            case "RefreshWhatsappAlerts":
                PS.Phone.Functions.ReloadWhatsappAlerts(event.data.Chats);
                break;
            case "CancelOutgoingCall":
                $.post('http://ps_phone/HasPhone', JSON.stringify({}), function(HasPhone) {
                    if (HasPhone) {
                        CancelOutgoingCall();
                    }
                });

                if (PS.Phone.Audio) {
                    PS.Phone.Audio.pause();
                }
                break;
            case "IncomingCallAlert":
                $.post('http://ps_phone/HasPhone', JSON.stringify({}), function(HasPhone) {
                    if (HasPhone) {
                        IncomingCallAlert(event.data.CallData, event.data.Canceled, event.data.AnonymousCall);
                    }
                });

                if (PS.Phone.Audio) {
                    PS.Phone.Audio.pause();
                }
                break;
            case "SetupHomeCall":
                PS.Phone.Functions.SetupCurrentCall(event.data.CallData);
                break;
            case "AnswerCall":
                PS.Phone.Functions.AnswerCall(event.data.CallData);
                break;
            case "UpdateCallTime":
                var CallTime = event.data.Time;
                var date = new Date(null);
                date.setSeconds(CallTime);
                var timeString = date.toISOString().substr(11, 8);

                if (PS.Phone.Audio) {
                    PS.Phone.Audio.pause();
                }

                if (!PS.Phone.Data.IsOpen) {
                    if ($(".call-notifications").css("right") !== "52.1px") {
                        $(".call-notifications").css({
                            "display": "block"
                        });
                        $(".call-notifications").animate({
                            right: 5 + "vh"
                        });
                    }
                    $(".call-notifications-title").html("Em ligação (" + timeString + ")");
                    $(".call-notifications-content").html("No telefone com " + event.data.Name);
                    $(".call-notifications").removeClass('call-notifications-shake');
                } else {
                    $(".call-notifications").animate({
                        right: -35 + "vh"
                    }, 400, function() {
                        $(".call-notifications").css({
                            "display": "none"
                        });
                    });
                }

                $(".phone-call-ongoing-time").html(timeString);
                $(".phone-currentcall-title").html("Em ligação (" + timeString + ")");
                break;
            case "CancelOngoingCall":

                if (PS.Phone.Audio) {
                    PS.Phone.Audio.pause();
                }

                $(".call-notifications").animate({
                    right: -35 + "vh"
                }, function() {
                    $(".call-notifications").css({
                        "display": "none"
                    });
                });
                PS.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
                setTimeout(function() {
                    PS.Phone.Functions.ToggleApp("phone-call", "none");
                    $(".phone-application-container").css({
                        "display": "none"
                    });
                }, 400)
                PS.Phone.Functions.HeaderTextColor("white", 300);

                PS.Phone.Data.CallActive = false;
                PS.Phone.Data.currentApplication = null;
                break;
            case "RefreshContacts":
                PS.Phone.Functions.LoadContacts(event.data.Contacts);
                break;
            case "UpdateMails":
                PS.Phone.Functions.SetupMails(event.data.Mails);
                break;
            case "RefreshAdverts":
                if (PS.Phone.Data.currentApplication == "advert") {
                    PS.Phone.Functions.RefreshAdverts(event.data.Adverts);
                }
                break;
            case "RefreshStoriesInsta":
                PS.Phone.Functions.ReceiveStories(event.data.stories);
                break;
            case "RefreshMyStorieInsta":
                PS.Phone.Functions.ReceiveMyStorie(event.data.storie);
                break;
            case "RefreshPostsInsta":
                PS.Phone.Functions.ReceivePosts(event.data.posts);
                break;
            case "UpdateIPAddress":
                iphost = event.data.ipaddress;
                break;
        }
    })
});

$(document).on('keydown', function() {
    switch (event.keyCode) {
        case 27: // ESCAPE
            PS.Phone.Functions.Close();
            break;
    }
});