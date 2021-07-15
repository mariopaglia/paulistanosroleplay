var FoccusedBank = null;

$(document).on('click', '.bank-app-account', function(e) {
    var copyText = document.getElementById("iban-account");
    copyText.select();
    copyText.setSelectionRange(0, 99999);
    document.execCommand("copy");

    PS.Phone.Notifications.Add("fas fa-university", "PSBank", "Número da conta bancária copiado!", "#badc58", 1750);
});

var CurrentTab = "accounts";

$(document).on('click', '.bank-app-header-button', function(e) {
    e.preventDefault();

    var PressedObject = this;
    var PressedTab = $(PressedObject).data('headertype');

    if (CurrentTab != PressedTab) {
        var PreviousObject = $(".bank-app-header").find('[data-headertype="' + CurrentTab + '"]');

        if (PressedTab == "invoices") {
            $(".bank-app-" + CurrentTab).animate({
                left: -30 + "vh"
            }, 250, function() {
                $(".bank-app-" + CurrentTab).css({ "display": "none" })
            });
            $(".bank-app-" + PressedTab).css({ "display": "block" }).animate({
                left: 0 + "vh"
            }, 250);
        } else if (PressedTab == "accounts") {
            $(".bank-app-" + CurrentTab).animate({
                left: 30 + "vh"
            }, 250, function() {
                $(".bank-app-" + CurrentTab).css({ "display": "none" })
            });
            $(".bank-app-" + PressedTab).css({ "display": "block" }).animate({
                left: 0 + "vh"
            }, 250);
        }

        $(PreviousObject).removeClass('bank-app-header-button-selected');
        $(PressedObject).addClass('bank-app-header-button-selected');
        setTimeout(function() { CurrentTab = PressedTab; }, 300)
    }
})

PS.Phone.Functions.DoBankOpen = function() {
    PS.Phone.Data.UserData.banco = (PS.Phone.Data.UserData.banco).toFixed();
    $(".bank-app-account-number").val(PS.Phone.Data.UserData.identity.id);
    $(".bank-app-account-balance").html("&#36; " + PS.Phone.Data.UserData.banco);
    $(".bank-app-account-balance").data('balance', PS.Phone.Data.UserData.banco);

    $(".bank-app-loaded").css({ "display": "none", "padding-left": "30vh" });
    $(".bank-app-accounts").css({ "left": "30vh" });
    $(".qbank-logo").css({ "left": "0vh" });
    $("#qbank-text").css({ "opacity": "0.0", "left": "9vh" });
    $(".bank-app-loading").css({
        "display": "block",
        "left": "0vh",
    });
    setTimeout(function() {
        CurrentTab = "accounts";
        $(".qbank-logo").animate({
            left: -12 + "vh"
        }, 500);
        setTimeout(function() {
            $("#qbank-text").animate({
                opacity: 1.0,
                left: 14 + "vh"
            });
        }, 100);
        setTimeout(function() {
            $(".bank-app-loaded").css({ "display": "block" }).animate({ "padding-left": "0" }, 300);
            $(".bank-app-accounts").animate({ left: 0 + "vh" }, 300);
            $(".bank-app-loading").animate({
                left: -35 + "vh"
            }, 300, function() {
                $(".bank-app-loading").css({ "display": "none" });
            });
        }, 1500)
    }, 500)
}

$(document).on('click', '.bank-app-account-actions', function(e) {
    PS.Phone.Animations.TopSlideDown(".bank-app-transfer", 400, 0);
});

$(document).on('click', '#cancel-transfer', function(e) {
    e.preventDefault();

    PS.Phone.Animations.TopSlideUp(".bank-app-transfer", 400, -100);
});

function loadbank() {
    $(".bank-app-loaded").css({ "display": "none", "padding-left": "30vh" });
    $(".bank-app-accounts").css({ "left": "30vh" });
    $(".qbank-logo").css({ "left": "0vh" });
    $("#qbank-text").css({ "opacity": "0.0", "left": "9vh" });
    $(".bank-app-loading").css({
        "display": "block",
        "left": "0vh",
    });
    setTimeout(function() {
        CurrentTab = "accounts";
        $(".qbank-logo").animate({
            left: -12 + "vh"
        }, 500);
        setTimeout(function() {
            $("#qbank-text").animate({
                opacity: 1.0,
                left: 14 + "vh"
            });
        }, 100);
        setTimeout(function() {
            $(".bank-app-loaded").css({ "display": "block" }).animate({ "padding-left": "0" }, 300);
            $(".bank-app-accounts").animate({ left: 0 + "vh" }, 300);
            $(".bank-app-loading").animate({
                left: -35 + "vh"
            }, 300, function() {
                $(".bank-app-loading").css({ "display": "none" });
            });
        }, 1500)
    }, 500)
}

$(document).on('click', '#accept-transfer', function(e) {
    e.preventDefault();

    var iban = $("#bank-transfer-iban").val();
    var amount = $("#bank-transfer-amount").val();
    var amountData = $(".bank-app-account-balance").data('balance');

    if (iban != "" && amount != "") {
        if (amountData >= amount) {
            $.post('http://ps_phone/TransferMoney', JSON.stringify({
                iban: iban,
                amount: amount
            }), function(data) {
                if (data.CanTransfer) {
                    $("#bank-transfer-iban").val("");
                    $("#bank-transfer-amount").val("");
                    data.NewAmount = (data.NewAmount).toFixed();
                    $(".bank-app-account-balance").html("&#36; " + data.NewAmount);
                    $(".bank-app-account-balance").data('balance', data.NewAmount);
                    PS.Phone.Notifications.Add("fas fa-university", "PSBank", "&#36; " + amount + ",- transferido!", "#badc58", 1500);
                } else {
                    PS.Phone.Notifications.Add("fas fa-university", "PSBank", "Você não tem saldo suficiente!", "#badc58", 1500);
                }
            })
            PS.Phone.Animations.TopSlideUp(".bank-app-transfer", 400, -100);
        } else {
            PS.Phone.Notifications.Add("fas fa-university", "PSBank", "Você não tem saldo suficiente!", "#badc58", 1500);
        }
    } else {
        PS.Phone.Notifications.Add("fas fa-university", "PSBank", "Preencha todos os campos! ", "#badc58", 1750);
    }
});

GetInvoiceLabel = function(type) {
    retval = null;
    if (type == "request") {
        retval = "Pedido de Pagamento";
    }

    return retval
}

$(document).on('click', '.pay-invoice', function(event) {
    event.preventDefault();

    var InvoiceId = $(this).parent().parent().attr('id');
    var InvoiceData = $("#" + InvoiceId).data('invoicedata');
    var BankBalance = $(".bank-app-account-balance").data('balance');

    if (BankBalance >= InvoiceData.amount) {
        $.post('http://ps_phone/PayInvoice', JSON.stringify({
            sender: InvoiceData.sender,
            amount: InvoiceData.amount,
            invoiceId: InvoiceData.invoiceid,
        }), function(CanPay) {
            if (CanPay) {
                $("#" + InvoiceId).animate({
                    left: 30 + "vh",
                }, 300, function() {
                    setTimeout(function() {
                        $("#" + InvoiceId).remove();
                    }, 100);
                });
                PS.Phone.Notifications.Add("fas fa-university", "PSBank", "&#36;" + InvoiceData.amount + " paid!", "#badc58", 1500);
                var amountData = $(".bank-app-account-balance").data('balance');
                var NewAmount = (amountData - InvoiceData.amount).toFixed();
                $("#bank-transfer-amount").val(NewAmount);
                $(".bank-app-account-balance").data('balance', NewAmount);
            } else {
                PS.Phone.Notifications.Add("fas fa-university", "PSBank", "You do not have enough balance!", "#badc58", 1500);
            }
        });
    } else {
        PS.Phone.Notifications.Add("fas fa-university", "PSBank", "You do not have enough balance!", "#badc58", 1500);
    }
});

$(document).on('click', '.decline-invoice', function(event) {
    event.preventDefault();
    var InvoiceId = $(this).parent().parent().attr('id');
    var InvoiceData = $("#" + InvoiceId).data('invoicedata');

    $.post('http://ps_phone/DeclineInvoice', JSON.stringify({
        sender: InvoiceData.sender,
        amount: InvoiceData.amount,
        invoiceId: InvoiceData.invoiceid,
    }));
    $("#" + InvoiceId).animate({
        left: 30 + "vh",
    }, 300, function() {
        setTimeout(function() {
            $("#" + InvoiceId).remove();
        }, 100);
    });
    PS.Phone.Notifications.Add("fas fa-university", "PSBank", "&#36;" + InvoiceData.amount + " paid!", "#badc58", 1500);
});

PS.Phone.Functions.LoadBankInvoices = function(invoices) {
    if (invoices !== null) {
        $(".bank-app-invoices-list").html("");

        $.each(invoices, function(i, invoice) {
            var Elem = '<div class="bank-app-invoice" id="invoiceid-' + i + '"> <div class="bank-app-invoice-title">' + GetInvoiceLabel(invoice.type) + ' <span style="font-size: 1vh; color: gray;">(Remetente: ' + invoice.name + ')</span></div> <div class="bank-app-invoice-amount">&#36; ' + invoice.amount + '</div> <div class="bank-app-invoice-buttons"> <i class="fas fa-check-circle pay-invoice"></i> <i class="fas fa-times-circle decline-invoice"></i> </div> </div>';

            $(".bank-app-invoices-list").append(Elem);
            $("#invoiceid-" + i).data('invoicedata', invoice);
        });
    }
}

PS.Phone.Functions.LoadContactsWithNumber = function(myContacts) {
    var ContactsObject = $(".bank-app-my-contacts-list");
    $(ContactsObject).html("");
    var TotalContacts = 0;

    $("#bank-app-my-contact-search").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $(".bank-app-my-contacts-list .bank-app-my-contact").filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
        });
    });

    if (myContacts !== null) {
        $.each(myContacts, function(i, contact) {
            var RandomNumber = Math.floor(Math.random() * 6);
            var ContactColor = PS.Phone.ContactColors[RandomNumber];
            var ContactElement = '<div class="bank-app-my-contact" data-bankcontactid="' + i + '"> <div class="bank-app-my-contact-firstletter">' + ((contact.name).charAt(0)).toUpperCase() + '</div> <div class="bank-app-my-contact-name">' + contact.name + '</div> </div>'
            TotalContacts = TotalContacts + 1
            $(ContactsObject).append(ContactElement);
            $("[data-bankcontactid='" + i + "']").data('contactData', contact);
        });
    }
};

$(document).on('click', '.bank-app-my-contacts-list-back', function(e) {
    e.preventDefault();

    PS.Phone.Animations.TopSlideUp(".bank-app-my-contacts", 400, -100);
});

$(document).on('click', '.bank-transfer-mycontacts-icon', function(e) {
    e.preventDefault();

    PS.Phone.Animations.TopSlideDown(".bank-app-my-contacts", 400, 0);
});

$(document).on('click', '.bank-app-my-contact', function(e) {
    e.preventDefault();
    var PressedContactData = $(this).data('contactData');

    if (PressedContactData.iban !== "" && PressedContactData.iban !== undefined && PressedContactData.iban !== null) {
        $("#bank-transfer-iban").val(PressedContactData.iban);
    } else {
        PS.Phone.Notifications.Add("fas fa-university", "PSBank", "Não há IBAN vinculado a este contato!", "#badc58", 2500);
    }
    PS.Phone.Animations.TopSlideUp(".bank-app-my-contacts", 400, -100);
});