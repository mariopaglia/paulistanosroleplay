PS.Phone.Settings = {};
PS.Phone.Settings.Background = "background";
PS.Phone.Settings.OpenedTab = null;
PS.Phone.Settings.Backgrounds = {
    'background': {
        label: "Papel de parede padrão definido!"
    }
};

var PressedBackground = null;
var PressedBackgroundObject = null;
var OldBackground = null;
var IsChecked = null;

$(document).on('click', '.settings-app-tab', function(e) {
    e.preventDefault();
    var PressedTab = $(this).data("settingstab");

    if (PressedTab == "background") {
        PS.Phone.Animations.TopSlideDown(".settings-" + PressedTab + "-tab", 200, 0);
        PS.Phone.Settings.OpenedTab = PressedTab;
    } else if (PressedTab == "profilepicture") {
        PS.Phone.Animations.TopSlideDown(".settings-" + PressedTab + "-tab", 200, 0);
        PS.Phone.Settings.OpenedTab = PressedTab;
    } else if (PressedTab == "numberrecognition") {
        var checkBoxes = $(".numberrec-box");
        PS.Phone.Data.AnonymousCall = !checkBoxes.prop("checked");
        checkBoxes.prop("checked", PS.Phone.Data.AnonymousCall);

        if (!PS.Phone.Data.AnonymousCall) {
            $("#numberrecognition > p").html('Desativado');
        } else {
            $("#numberrecognition > p").html('Ativado');
        }
    } else if (PressedTab == "noturnmode") {
        var checkBoxes = $(".noturnmode-box");
        PS.Phone.Data.NoturnMode = !checkBoxes.prop("checked");
        checkBoxes.prop("checked", PS.Phone.Data.NoturnMode);

        if (!PS.Phone.Data.NoturnMode) {
            $("#noturnmode > p").html('Desativado');
            $("body").removeClass("noturnmode");
        } else {
            $("#noturnmode > p").html('Ativado');
            $("body").addClass("noturnmode");
        }
    }
});

$(document).on('click', '#accept-background', function(e) {
    e.preventDefault();
    var hasCustomBackground = PS.Phone.Functions.IsBackgroundCustom();

    if (hasCustomBackground === false) {
        PS.Phone.Notifications.Add("fas fa-paint-brush", "Configurações", PS.Phone.Settings.Backgrounds[PS.Phone.Settings.Background].label + "!")
        PS.Phone.Animations.TopSlideUp(".settings-" + PS.Phone.Settings.OpenedTab + "-tab", 200, -100);
        $(".phone-background").css({ "background-image": "url('/html/img/backgrounds/" + PS.Phone.Settings.Background + ".jpg')" })
    } else {
        PS.Phone.Notifications.Add("fas fa-paint-brush", "Configurações", "Papel de parede definido")
        PS.Phone.Animations.TopSlideUp(".settings-" + PS.Phone.Settings.OpenedTab + "-tab", 200, -100);
        $(".phone-background").css({ "background-image": "url('" + PS.Phone.Settings.Background + "')" });
    }

    $.post('http://ps_phone/SetBackground', JSON.stringify({
        background: PS.Phone.Settings.Background,
    }))
});

PS.Phone.Functions.LoadBackground = function(background) {
    if (background !== null && background !== undefined) {
        PS.Phone.Settings.Background = background;
    } else {
        PS.Phone.Settings.Background = "background";
    }

    var hasCustomBackground = PS.Phone.Functions.IsBackgroundCustom();

    if (!hasCustomBackground) {
        $(".phone-background").css({ "background-image": "url('/html/img/backgrounds/" + PS.Phone.Settings.Background + ".jpg')" })
    } else {
        $(".phone-background").css({ "background-image": "url('" + PS.Phone.Settings.Background + "')" });
    }

    // if (MetaData.profilepicture == "default") {
    //     $("[data-settingstab='profilepicture']").find('.settings-tab-icon').html('<img src="./img/default.png">');
    // } else {
    //     $("[data-settingstab='profilepicture']").find('.settings-tab-icon').html('<img src="' + MetaData.profilepicture + '">');
    // }
}

$(document).on('click', '#cancel-background', function(e) {
    e.preventDefault();
    PS.Phone.Animations.TopSlideUp(".settings-" + PS.Phone.Settings.OpenedTab + "-tab", 200, -100);
});

PS.Phone.Functions.IsBackgroundCustom = function() {
    var retval = true;
    $.each(PS.Phone.Settings.Backgrounds, function(i, background) {
        if (PS.Phone.Settings.Background == i) {
            retval = false;
        }
    });
    return retval
}

$(document).on('click', '.background-option', function(e) {
    e.preventDefault();
    PressedBackground = $(this).data('background');
    PressedBackgroundObject = this;
    OldBackground = $(this).parent().find('.background-option-current');
    IsChecked = $(this).find('.background-option-current');

    if (IsChecked.length === 0) {
        if (PressedBackground != "custom-background") {
            PS.Phone.Settings.Background = PressedBackground;
            $(OldBackground).fadeOut(50, function() {
                $(OldBackground).remove();
            });
            $(PressedBackgroundObject).append('<div class="background-option-current"><i class="fas fa-check-circle"></i></div>');
        } else {
            PS.Phone.Animations.TopSlideDown(".background-custom", 200, 13);
        }
    }
});

$(document).on('click', '#accept-custom-background', function(e) {
    e.preventDefault();

    PS.Phone.Settings.Background = $(".custom-background-input").val();
    $(OldBackground).fadeOut(50, function() {
        $(OldBackground).remove();
    });
    $(PressedBackgroundObject).append('<div class="background-option-current"><i class="fas fa-check-circle"></i></div>');
    PS.Phone.Animations.TopSlideUp(".background-custom", 200, -23);
});

$(document).on('click', '#cancel-custom-background', function(e) {
    e.preventDefault();

    PS.Phone.Animations.TopSlideUp(".background-custom", 200, -23);
});

// Profile Picture

var PressedProfilePicture = null;
var PressedProfilePictureObject = null;
var OldProfilePicture = null;
var ProfilePictureIsChecked = null;

$(document).on('click', '#accept-profilepicture', function(e) {
    e.preventDefault();
    var ProfilePicture = PS.Phone.Data.MetaData.profilepicture;
    if (ProfilePicture === "default") {
        PS.Phone.Notifications.Add("fas fa-paint-brush", "Configurações ", "Foto do perfil padrão está definida! ")
        PS.Phone.Animations.TopSlideUp(".settings-" + PS.Phone.Settings.OpenedTab + "-tab", 200, -100);
        $("[data-settingstab='profilepicture']").find('.settings-tab-icon').html('<img src="./img/default.png">');
    } else {
        PS.Phone.Notifications.Add("fas fa-paint-brush", "Configurações ", "Foto de perfil customizada definida!")
        PS.Phone.Animations.TopSlideUp(".settings-" + PS.Phone.Settings.OpenedTab + "-tab", 200, -100);
        console.log(ProfilePicture)
        $("[data-settingstab='profilepicture']").find('.settings-tab-icon').html('<img src="' + ProfilePicture + '">');
    }
    $.post('http://ps_phone/UpdateProfilePicture', JSON.stringify({
        profilepicture: ProfilePicture,
    }));
});

$(document).on('click', '#accept-custom-profilepicture', function(e) {
    e.preventDefault();
    PS.Phone.Data.MetaData.profilepicture = $(".custom-profilepicture-input").val();
    $(OldProfilePicture).fadeOut(50, function() {
        $(OldProfilePicture).remove();
    });
    $(PressedProfilePictureObject).append('<div class="profilepicture-option-current"><i class="fas fa-check-circle"></i></div>');
    PS.Phone.Animations.TopSlideUp(".profilepicture-custom", 200, -23);
});

$(document).on('click', '.profilepicture-option', function(e) {
    e.preventDefault();
    PressedProfilePicture = $(this).data('profilepicture');
    PressedProfilePictureObject = this;
    OldProfilePicture = $(this).parent().find('.profilepicture-option-current');
    ProfilePictureIsChecked = $(this).find('.profilepicture-option-current');
    if (ProfilePictureIsChecked.length === 0) {
        if (PressedProfilePicture != "custom-profilepicture") {
            PS.Phone.Data.MetaData.profilepicture = PressedProfilePicture
            $(OldProfilePicture).fadeOut(50, function() {
                $(OldProfilePicture).remove();
            });
            $(PressedProfilePictureObject).append('<div class="profilepicture-option-current"><i class="fas fa-check-circle"></i></div>');
        } else {
            PS.Phone.Animations.TopSlideDown(".profilepicture-custom", 200, 13);
        }
    }
});

$(document).on('click', '#cancel-profilepicture', function(e) {
    e.preventDefault();
    PS.Phone.Animations.TopSlideUp(".settings-" + PS.Phone.Settings.OpenedTab + "-tab", 200, -100);
});


$(document).on('click', '#cancel-custom-profilepicture', function(e) {
    e.preventDefault();
    PS.Phone.Animations.TopSlideUp(".profilepicture-custom", 200, -23);
});