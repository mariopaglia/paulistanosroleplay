var CurrentTwitterTab = "twitter-home"
var HashtagOpen = false;
var MinimumTrending = 100;
let url;

$(document).on('click', '.twitter-header-tab', function(e) {
    e.preventDefault();

    var PressedTwitterTab = $(this).data('twittertab');
    var PreviousTwitterTabObject = $('.twitter-header').find('[data-twittertab="' + CurrentTwitterTab + '"]');

    if (PressedTwitterTab !== CurrentTwitterTab) {
        $(this).addClass('selected-twitter-header-tab');
        $(PreviousTwitterTabObject).removeClass('selected-twitter-header-tab');

        $("." + CurrentTwitterTab + "-tab").css({
            "display": "none"
        });
        $("." + PressedTwitterTab + "-tab").css({
            "display": "block"
        });

        if (PressedTwitterTab === "twitter-mentions") {
            $.post('http://ps_phone/ClearMentions');
        }

        if (PressedTwitterTab == "twitter-home") {

            $.post('http://ps_phone/GetTweets', JSON.stringify({}), function(Tweets) {
                PS.Phone.Notifications.LoadTweets(Tweets);

            });

        }
        if (PressedTwitterTab == "twitter-self") {
            $.post('http://ps_phone/GetSelfTweets', JSON.stringify({}), function(selfdata) {
                PS.Phone.Notifications.LoadSelfTweets(selfdata)
            })

        }



        CurrentTwitterTab = PressedTwitterTab;

        if (HashtagOpen) {
            event.preventDefault();

            $(".twitter-hashtag-tweets").css({
                "left": "30vh"
            });
            $(".twitter-hashtags").css({
                "left": "0vh"
            });
            $(".twitter-new-tweet").css({
                "display": "block"
            });
            $(".twitter-hashtags").css({
                "display": "block"
            });
            HashtagOpen = false;
        }
    } else if (CurrentTwitterTab == "twitter-hashtags" && PressedTwitterTab == "twitter-hashtags") {
        if (HashtagOpen) {
            event.preventDefault();

            $(".twitter-hashtags").css({
                "display": "block"
            });
            $(".twitter-hashtag-tweets").animate({
                left: 30 + "vh"
            }, 150);
            $(".twitter-hashtags").animate({
                left: 0 + "vh"
            }, 150);
            HashtagOpen = false;
        }
    } else if (CurrentTwitterTab == "twitter-home" && PressedTwitterTab == "twitter-home") {
        event.preventDefault();

        $.post('http://ps_phone/GetTweets', JSON.stringify({}), function(Tweets) {
            PS.Phone.Notifications.LoadTweets(Tweets);
        });
    } else if (CurrentTwitterTab == "twitter-mentions" && PressedTwitterTab == "twitter-mentions") {
        event.preventDefault();

        $.post('http://ps_phone/GetMentionedTweets', JSON.stringify({}), function(MentionedTweets) {
            PS.Phone.Notifications.LoadMentionedTweets(MentionedTweets)
        })
    } else if (CurrentTwitterTab == "twitter-self" && PressedTwitterTab == "twitter-self") {
        event.preventDefault();

        $.post('http://ps_phone/GetSelfTweets', JSON.stringify({}), function(selfTweets) {
            PS.Phone.Notifications.LoadSelfTweets(selfTweets)
        })
    }


});


$(document).on('click', '.twitter-new-tweet', function(e) {
    e.preventDefault();
    PS.Phone.Animations.TopSlideDown(".twitter-new-tweet-tab", 450, 0);
});

PS.Phone.Notifications.LoadTweets = function(Tweets) {

    Tweets = JSON.parse(Tweets)

    if (Tweets !== null && Tweets !== undefined && Tweets !== "" && Tweets.length > 0) {
        $(".twitter-home-tab").html("");
        $.each(Tweets, function(i, Tweet) {
            let TwtMessage = Tweet.message;
            let today = new Date();
            let TweetTime = new Date(Tweet.created);
            let diffMs = (today - TweetTime);
            let diffDays = Math.floor(diffMs / 86400000);
            let diffHrs = Math.floor((diffMs % 86400000) / 3600000);
            let diffMins = Math.round(((diffMs % 86400000) % 3600000) / 60000);
            let diffSeconds = Math.round(diffMs / 1000);
            let TimeAgo = diffSeconds + ' s';
            if (diffMins > 0) {
                TimeAgo = diffMins + ' m';
            } else if (diffHrs > 0) {
                TimeAgo = diffHrs + ' h';
            } else if (diffDays > 0) {
                TimeAgo = diffDays + ' d';
            }
            let PictureUrl = "./img/default.png"
            if (Tweet.avatar !== "default.png") {
                PictureUrl = Tweet.avatar
            }

            if (Tweet.image == "" && Tweet.message != "") {
                let TweetElement = '<div class="twitter-tweet" data-twtid = "' + Tweet.id + '" data-twthandler="@' + Tweet.username + '">' +
                    '<div class="tweet-tweeter">' + Tweet.name + ' &nbsp;<span>@' + Tweet.username + ' &middot; ' + TimeAgo + '</span></div>';
                if (Tweet.mentions) {
                    TweetElement = TweetElement + '<div class="tweet-message">Menções: ' + Tweet.mentions + '</div>';
                }
                if (Tweet.hashtags) {
                    TweetElement = TweetElement + '<div class="tweet-message">Hashtags: ' + Tweet.hashtags + '</div>';
                }
                TweetElement = TweetElement + '<div class="tweet-message">' + Tweet.message + '</div>' +
                    '<div class="twt-img" style="top: 1vh;"><img src="' + PictureUrl + '" class="tweeter-image"></div>' +
                    '<div class="tweet-reply"><i class="fas fa-reply"></i></div>'
                '</div>';
                $(".twitter-home-tab").append(TweetElement);
            } else if (Tweet.image != "" && Tweet.message == "") {
                let TweetElement = '<div class="twitter-tweet" data-twtid = "' + Tweet.id + '" data-twthandler="@' + Tweet.username + '">' +
                    '<div class="tweet-tweeter">' + Tweet.name + ' &nbsp;<span>@' + Tweet.username + ' &middot; ' + TimeAgo + '</span></div>';
                if (Tweet.mentions) {
                    TweetElement = TweetElement + '<div class="tweet-message">Menções: ' + Tweet.mentions + '</div>';
                }
                if (Tweet.hashtags) {
                    TweetElement = TweetElement + '<div class="tweet-message">Hashtags: ' + Tweet.hashtags + '</div>';
                }
                TweetElement = TweetElement + '<div class="tweet-message">' + Tweet.message + '</div>' +
                    '<img class="image" src= "' + Tweet.image + '" style = " border-radius:2px; width: 70%; position:relative; z-index: 1; left:52px; margin:.6rem .5rem .6rem 1rem;height: auto;">' +
                    '<div class="twt-img" style="top: 1vh;"><img src="' + PictureUrl + '" class="tweeter-image"></div>' +
                    '<div class="tweet-reply"><i class="fas fa-reply"></i></div>'
                '</div>';
                $(".twitter-home-tab").append(TweetElement);
            }

        });
    } else {
        let html = `<div class="twitter-no-tweets"><p>Sem tweets!</p></div>`
        $(".twitter-home-tab").html(html);

    }

}


PS.Phone.Notifications.LoadSelfTweets = function(Tweets) {
    Tweets = JSON.parse(Tweets)

    if (Tweets !== null && Tweets !== undefined && Tweets !== "" && Tweets.length > 0) {
        $(".twitter-self-tab").html("");
        $.each(Tweets, function(i, Tweet) {
            let today = new Date();

            let TweetTime = new Date(Tweet.created);
            let diffMs = (today - TweetTime);
            let diffDays = Math.floor(diffMs / 86400000);
            let diffHrs = Math.floor((diffMs % 86400000) / 3600000);
            let diffMins = Math.round(((diffMs % 86400000) % 3600000) / 60000);
            let diffSeconds = Math.round(diffMs / 1000);
            let TimeAgo = diffSeconds + ' s';
            if (diffMins > 0) {
                TimeAgo = diffMins + ' m';
            } else if (diffHrs > 0) {
                TimeAgo = diffHrs + ' h';
            } else if (diffDays > 0) {
                TimeAgo = diffDays + ' d';
            }

            let PictureUrl = "./img/default.png"
            if (Tweet.avatar !== "default.png") {
                PictureUrl = Tweet.avatar
            }

            if (Tweet.image == "" && Tweet.message != "") {
                let TweetElement = '<div class="twitter-tweet" data-twtid = "' + Tweet.id + '" data-twthandler="@' + Tweet.username + '">' +
                    '<div class="tweet-tweeter">' + Tweet.name + ' &nbsp;<span>@' + Tweet.username + ' &middot; ' + TimeAgo + '</span></div>' +
                    '<div class="tweet-message">Menções: ' + Tweet.mentions + '</div>' +
                    '<div class="tweet-message">Hashtags: ' + Tweet.hashtags + '</div>' +
                    '<div class="tweet-message">' + Tweet.message + '</div>' +
                    '<div class="twt-img" style="top: 1vh;"><img src="' + PictureUrl + '" class="tweeter-image"></div>' +
                    '<div class="tweet-delete"><i class="fas fa-trash-alt"></i></div>'
                '</div>';
                $(".twitter-home-tab").append(TweetElement);
            } else if (Tweet.image != "" && Tweet.message == "") {
                let TweetElement = '<div class="twitter-tweet" data-twtid = "' + Tweet.id + '" data-twthandler="@' + Tweet.username + '">' +
                    '<div class="tweet-tweeter">' + Tweet.name + ' &nbsp;<span>@' + Tweet.username + ' &middot; ' + TimeAgo + '</span></div>' +
                    '<div class="tweet-message">Menções: ' + Tweet.mentions + '</div>' +
                    '<div class="tweet-message">Hashtags: ' + Tweet.hashtags + '</div>' +
                    '<div class="tweet-message">' + Tweet.message + '</div>' +
                    '<img class="image" src= "' + Tweet.image + '" style = " border-radius:2px; width: 70%; position:relative; z-index: 1; left:52px; margin:.6rem .5rem .6rem 1rem;height: auto;">' +
                    '<div class="twt-img" style="top: 1vh;"><img src="' + PictureUrl + '" class="tweeter-image"></div>' +
                    '<div class="tweet-delete"><i class="fas fa-trash-alt"></i></div>'
                '</div>';
                $(".twitter-home-tab").append(TweetElement);
            }

        });
    } else {
        let html = `<div class="twitter-no-tweets"><p>Você não enviou tweets!</p></div>`
        $(".twitter-self-tab").html(html);

    }

}

$(document).on('click', '.tweet-reply', function(e) {
    e.preventDefault();
    var TwtName = $(this).parent().data('twthandler');
    var text = $(this).parent().data();
    $("#tweet-new-message").val(TwtName + " @" + text + "");
    PS.Phone.Animations.TopSlideDown(".twitter-new-tweet-tab", 450, 0);
});

$(document).on('click', '.tweet-delete', function(e) {
    e.preventDefault();
    var id = $(this).parent().data('twtid');
    console.log(id)
    $.post('http://ps_phone/DeleteTweet', JSON.stringify({
        id: id,
    }));

    $.post('http://ps_phone/GetSelfTweets', JSON.stringify({}), function(tweets) {
        PS.Phone.Notifications.LoadSelfTweets(tweets);
    });
    $.post('http://ps_phone/GetTweets', JSON.stringify({}), function(tweets) {
        PS.Phone.Notifications.LoadTweets(tweets);
    });


});



let clicked = false;
let photos = [];
$(document).on('click', '.image', function(e) {
    if (!clicked) {
        let n = $(this).clone()

        $(n).appendTo('.tt')
        $(n).css({
            "position": "absolute",
            "width": "500px",
            "height": "auto",
            "left": "-520px",
            "top": "-10px",

            "border-radius": "1rem"
        })
        clicked = true;
        photos.push(n)
    } else {
        for (let i = 0; i < photos.length; i++) {
            photos[i].remove()
        }
        clicked = false;
    }
});


PS.Phone.Notifications.LoadMentionedTweets = function(Tweets) {
    Tweets = JSON.parse(Tweets);
    if (Tweets.length > 0) {
        $(".twitter-mentions-tab").html("");
        $.each(Tweets, function(i, Tweet) {
            var TwtMessage = Tweet.message;
            var today = new Date();
            var TweetTime = new Date(Tweet.created);
            var diffMs = (today - TweetTime);
            var diffDays = Math.floor(diffMs / 86400000);
            var diffHrs = Math.floor((diffMs % 86400000) / 3600000);
            var diffMins = Math.round(((diffMs % 86400000) % 3600000) / 60000);
            var diffSeconds = Math.round(diffMs / 1000);
            var TimeAgo = diffSeconds + ' sn';

            if (diffSeconds > 60) {
                TimeAgo = diffMins + ' dk';
            } else if (diffMins > 60) {
                TimeAgo = diffHrs + ' s';
            } else if (diffHrs > 24) {
                TimeAgo = diffDays + ' d';
            }

            var PictureUrl = "./img/default.png";
            if (Tweet.avatar !== "default.png") {
                PictureUrl = Tweet.avatar
            }

            var TweetElement =
                '<div class="twitter-tweet">' +
                '<div class="tweet-tweeter">' + Tweet.name + ' &nbsp;<span>@' + Tweet.username + ' &middot; ' + TimeAgo + '</span></div>' +
                '<div class="tweet-message">' + TwtMessage + '</div>' +
                '<div class="twt-img" style="top: 1vh;"><img src="' + PictureUrl + '" class="tweeter-image"></div></div>';

            $(".twitter-mentioned-tweet").css({
                "background-color": "#F5F8FA"
            });
            $(".twitter-mentions-tab").append(TweetElement);
        });
    }
}

PS.Phone.Functions.FormatTwitterMessage = function(TwitterMessage) {
    var TwtMessage = TwitterMessage;
    var res = TwtMessage.split("@");
    var tags = TwtMessage.split("#");
    var InvalidSymbols = [
        "[",
        "?",
        "!",
        "@",
        "#",
        "]",
    ]

    for (i = 1; i < res.length; i++) {
        var MentionTag = res[i].split(" ")[0];
        if (MentionTag !== null && MentionTag !== undefined && MentionTag !== "") {
            TwtMessage = TwtMessage.replace("@" + MentionTag, "<span class='mentioned-tag' data-mentiontag='@" + MentionTag + "' style='color: rgb(27, 149, 224);'>@" + MentionTag + "</span>");
        }
    }

    for (i = 1; i < tags.length; i++) {
        var Hashtag = tags[i].split(" ")[0];

        for (i = 1; i < InvalidSymbols.length; i++) {
            var symbol = InvalidSymbols[i];
            var res = Hashtag.indexOf(symbol);

            if (res > -1) {
                Hashtag = Hashtag.replace(symbol, "");
            }
        }

        if (Hashtag !== null && Hashtag !== undefined && Hashtag !== "") {
            TwtMessage = TwtMessage.replace("#" + Hashtag, "<span class='hashtag-tag-text' data-hashtag='" + Hashtag + "' style='color: rgb(27, 149, 224);'>#" + Hashtag + "</span>");
        }
    }

    return TwtMessage
}

$(document).on('click', '#send-tweet', function(e) {
    e.preventDefault();

    var TweetMessage = $("#tweet-new-message").val();
    var TweetUrl = $("#tweet-new-url").val();
    var TweetMentions = $('#tweet-new-mentions').val();
    var TweetHashtags = $('#tweet-new-hashtags').val();

    if (TweetMessage != "") {
        $.post('http://ps_phone/PostNewTweet', JSON.stringify({
            message: TweetMessage,
            mentions: TweetMentions,
            hashtags: TweetHashtags,
            image: TweetUrl
        }), function(Tweets) {
            PS.Phone.Notifications.LoadTweets(Tweets)

        });

        PS.Phone.Animations.TopSlideUp(".twitter-new-tweet-tab", 450, -120);
        $('#tweet-new-url').val("")
        $("#tweet-new-message").val("");
    } else {
        PS.Phone.Notifications.Add("fab fa-twitter", "Error", "Envie uma mensagem", "#1DA1F2");
    }
});


$(document).on('click', '#send-photo', function(e) {
    e.preventDefault();

    $.post('http://ps_phone/PostNewImage', JSON.stringify({}),
        function(url) {
            $('#tweet-new-url').val(url)

        },
    );

    PS.Phone.Functions.Close();

});

$(document).on('click', '#cancel-tweet', function(e) {
    e.preventDefault();
    $('#tweet-new-url').val("");
    $('#tweet-new-mentions').val("");
    $('#tweet-new-hashtags').val("");
    $("#tweet-new-message").val("");
    PS.Phone.Animations.TopSlideUp(".twitter-new-tweet-tab", 450, -120);
});

$(document).on('click', '.mentioned-tag', function(e) {
    e.preventDefault();
    CopyMentionTag(this);
});

$(document).on('click', '.hashtag-tag-text', function(e) {
    e.preventDefault();
    if (!HashtagOpen) {
        var Hashtag = $(this).data('hashtag');
        var PreviousTwitterTabObject = $('.twitter-header').find('[data-twittertab="' + CurrentTwitterTab + '"]');

        $("#twitter-hashtags").addClass('selected-twitter-header-tab');
        $(PreviousTwitterTabObject).removeClass('selected-twitter-header-tab');

        $("." + CurrentTwitterTab + "-tab").css({
            "display": "none"
        });
        $(".twitter-hashtags-tab").css({
            "display": "block"
        });

        $.post('http://ps_phone/GetHashtagMessages', JSON.stringify({
            hashtag: Hashtag
        }), function(HashtagData) {
            PS.Phone.Notifications.LoadHashtagMessages(HashtagData.messages);
        });

        $(".twitter-hashtag-tweets").css({
            "display": "block",
            "left": "30vh"
        });
        $(".twitter-hashtag-tweets").css({
            "left": "0vh"
        });
        $(".twitter-hashtags").css({
            "left": "-30vh"
        });
        $(".twitter-hashtags").css({
            "display": "none"
        });
        HashtagOpen = true;

        CurrentTwitterTab = "twitter-hashtags";
    }
});

function CopyMentionTag(elem) {
    var $temp = $("<input>");
    $("body").append($temp);
    $temp.val($(elem).data('mentiontag')).select();
    PS.Phone.Notifications.Add("fab fa-twitter", PS.Phone.Functions.Lang("TWITTER_TITLE"), $(elem).data('mentiontag') + " Kopyalandı!", "rgb(27, 149, 224)", 1250);
    document.execCommand("copy");
    $temp.remove();
}

PS.Phone.Notifications.LoadHashtags = function(hashtags) {
    hashtags = JSON.parse(hashtags)
    if (hashtags !== null) {
        $(".twitter-hashtags").html("");
        $.each(hashtags, function(i, hashtag) {
            var Elem = '';
            var TweetHandle = "Tweet";
            if (hashtag.count > 1) {
                TweetHandle = "Tweets";
            }
            if (hashtag.count >= MinimumTrending) {
                Elem = '<div class="twitter-hashtag" id="tag-' + hashtag.name + '"><div class="twitter-hashtag-status">Trending</div> <div class="twitter-hashtag-tag">#' + hashtag.name + '</div> <div class="twitter-hashtag-messages">' + hashtag.count + ' ' + TweetHandle + '</div> </div>';
            } else {
                Elem = '<div class="twitter-hashtag" id="tag-' + hashtag.name + '"><div class="twitter-hashtag-status">Not Trending</div> <div class="twitter-hashtag-tag">#' + hashtag.name + '</div> <div class="twitter-hashtag-messages">' + hashtag.count + ' ' + TweetHandle + '</div> </div>';
            }

            $(".twitter-hashtags").append(Elem);
            $("#tag-" + hashtag.hashtag).data('tagData', hashtag);
        });
    }
}

PS.Phone.Notifications.LoadHashtagMessages = function(Tweets) {
    Tweets = JSON.parse(Tweets)
    if (Tweets !== null && Tweets !== undefined && Tweets !== "" && Tweets.length > 0) {
        $(".twitter-hashtag-tweets").html("");
        $.each(Tweets, function(i, Tweet) {
            var today = new Date();
            var TweetTime = new Date(Tweet.created);
            var diffMs = (today - TweetTime);
            var diffDays = Math.floor(diffMs / 86400000);
            var diffHrs = Math.floor((diffMs % 86400000) / 3600000);
            var diffMins = Math.round(((diffMs % 86400000) % 3600000) / 60000);
            var diffSeconds = Math.round(diffMs / 1000);
            var TimeAgo = diffSeconds + ' sn';

            if (diffSeconds > 60) {
                TimeAgo = diffMins + ' dk';
            } else if (diffMins > 60) {
                TimeAgo = diffHrs + ' s';
            } else if (diffHrs > 24) {
                TimeAgo = diffDays + ' d';
            }

            var TweetElement =
                '<div class="twitter-tweet">' +
                '<div class="tweet-tweeter"><span>@' + Tweet.name + ' &middot; ' + TimeAgo + '</span></div>' +
                '</div>';

            $(".twitter-hashtag-tweets").append(TweetElement);
        });
    }
}

$(document).on('click', '.twitter-hashtag', function(event) {
    event.preventDefault();

    var TweetId = $(this).attr('id');
    var TweetData = $("#" + TweetId).data('tagData');

    PS.Phone.Notifications.LoadHashtagMessages(TweetData.messages);

    $(".twitter-hashtag-tweets").css({
        "display": "block",
        "left": "30vh"
    });
    $(".twitter-hashtag-tweets").animate({
        left: 0 + "vh"
    }, 150);
    $(".twitter-hashtags").animate({
        left: -30 + "vh"
    }, 150, function() {
        $(".twitter-hashtags").css({
            "display": "none"
        });
    });
    HashtagOpen = true;
});

$(document).on('submit', '.addaccounttwitter', function(e) {
    var name = $(".addaccounttwitter #name").val();
    var username = $(".addaccounttwitter #username").val();
    var password = $(".addaccounttwitter #password").val();

    if (name.length <= 0 || username.length <= 0 || password.length <= 0) {
        $(".twitter-app .not-logged .error p").html("Preencha todos os campos");
        $(".twitter-app .not-logged .error").show();
        return false;
    }

    if (name.length < 6) {
        $(".twitter-app .not-logged .error p").html("O nome deve no minino 6 digitos");
        $(".twitter-app .not-logged .error").show();
        return false;
    }

    if (username.length < 6) {
        $(".twitter-app .not-logged .error p").html("O nome de usuário deve no minino 6 digitos");
        $(".twitter-app .not-logged .error").show();
        return false;
    }

    if (password.length < 6) {
        $(".twitter-app .not-logged .error p").html("A senha deve no minino 6 digitos");
        $(".twitter-app .not-logged .error").show();
        return false;
    }

    $(".twitter-app .not-logged .error p").html();
    $(".twitter-app .not-logged .error").hide();

    $.post('http://ps_phone/AddAccountTwitter', JSON.stringify({
        name: name,
        username: username,
        password: password
    }), function(account) {
        PS.Phone.Data.TwiiterAccount = account;
        $(".twitter-app .not-logged").hide();
        $(".twitter-app .logged").show();

        PS.Phone.Notifications.Add("fas fa-check", "Cria conta", "Conta criada com sucesso! Finalize e abra novamente o aplicativo", "green");

        $.post('http://ps_phone/GetMentionedTweets', JSON.stringify({}), function(MentionedTweets) {
            PS.Phone.Notifications.LoadMentionedTweets(MentionedTweets)
        })
        $.post('http://ps_phone/GetHashtags', JSON.stringify({}), function(Hashtags) {
            PS.Phone.Notifications.LoadHashtags(Hashtags)
        })
        $.post('http://ps_phone/GetTweets', JSON.stringify({}), function(Tweets) {
            PS.Phone.Notifications.LoadTweets(Tweets);
        });
    });

    return false;
});

PS.Phone.Functions.ReceiveAccountTwitter = function(account) {
    if (account) {
        PS.Phone.Data.InstagramAccount = account;
        $(".twitter-app .not-logged").hide();
        $(".twitter-app .logged").show();

        $.post('http://ps_phone/GetMentionedTweets', JSON.stringify({}), function(MentionedTweets) {
            PS.Phone.Notifications.LoadMentionedTweets(MentionedTweets)
        })
        $.post('http://ps_phone/GetHashtags', JSON.stringify({}), function(Hashtags) {
            PS.Phone.Notifications.LoadHashtags(Hashtags)
        })
        $.post('http://ps_phone/GetTweets', JSON.stringify({}), function(Tweets) {
            PS.Phone.Notifications.LoadTweets(Tweets);
        });
    } else {
        $(".twitter-app .not-logged").show();
        $(".twitter-app .logged").hide();
    }
}