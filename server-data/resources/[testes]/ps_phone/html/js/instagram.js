// Determines button clicked via id
$(document).on("click", ".back-insta-home", function(e) {
    $("#insta-home").tab('show');
    e.preventDefault();
});

var ExtraButtonsOpen = false;

$(document).on('click', '#direct-openedchat-message-extras', function(e) {
    e.preventDefault();

    if (!ExtraButtonsOpen) {
        $(".direct-extra-buttons").css({
            "display": "block"
        }).animate({
            left: 0 + "vh"
        }, 250);
        ExtraButtonsOpen = true;
    } else {
        $(".direct-extra-buttons").animate({
            left: -10 + "vh"
        }, 250, function() {
            $(".direct-extra-buttons").css({
                "display": "block"
            });
            ExtraButtonsOpen = false;
        });
    }
});

$(document).on('click', '#direct-openedchat-back', function(e) {
    e.preventDefault();
    $.post('http://ps_phone/GetDirectChats', JSON.stringify({}), function(chats) {
        PS.Phone.Functions.LoadDirectChats(chats);
    });
    OpenedChatData.number = null;
    $(".direct-chats").css({
        "display": "block"
    });
    $(".direct-chats").animate({
        left: 0 + "vh"
    }, 200);
    $(".direct-openedchat").animate({
        left: -30 + "vh"
    }, 200, function() {
        $(".direct-openedchat").css({
            "display": "none"
        });
    });
    OpenedChatPicture = null;
});

$(document).on('click', '.changefilter', function(e) {
    var classe = $(this).attr('class');
    classe = classe.replace("changefilter ", "");

    $(".image-preview figure").removeClass();
    $(".image-preview figure").addClass(classe);

    if (classe != "sem-filtro") {
        $(".image-preview figure img").height("100%");
    } else {
        $(".image-preview figure img").height("93%");
    }
});

$(document).on('click', '.tab-position', function(e) {
    var checkBoxes = $(".sendposition-box");
    PS.Phone.Data.SendLocation = !checkBoxes.prop("checked");
    checkBoxes.prop("checked", PS.Phone.Data.SendLocation);

    if (!PS.Phone.Data.SendLocation) {
        $("#sendposition > p").html('Desativado');
    } else {
        $.post('http://ps_phone/GetLocation', JSON.stringify({}), function(street) {
            $("#sendposition > p").html(street);
        });
    }
});

$(document).on('click', '#back-post-photo-filter', function(e) {
    e.preventDefault();
    $(".post-photo-filter").animate({
        left: -35 + "vh"
    }, 200, function() {
        $(".post-photo-filter").css({
            "display": "none"
        });
    });
});

$(document).on('click', '#back-post-preview', function(e) {
    e.preventDefault();
    $(".post-preview").animate({
        left: -35 + "vh"
    }, 200, function() {
        $(".post-preview").css({
            "display": "none"
        });
    });
});

$(document).on('click', '#back-user-profile', function(e) {
    e.preventDefault();
    $(".user-profile").animate({
        left: -35 + "vh"
    }, 200, function() {
        $(".user-profile").css({
            "display": "none"
        });
    });
});

$(document).on('click', '#back-user-edit-profile', function(e) {
    e.preventDefault();
    $(".user-edit-profile").animate({
        left: -35 + "vh"
    }, 200, function() {
        $(".user-edit-profile").css({
            "display": "none"
        });
    });
});

$(document).on('keyup', '.add-comment input', function(e) {
    e.preventDefault();

    var val = $(this).val();

    if (val.length > 0) {
        $(this).parent().find('span').fadeIn(150);
    } else {
        $(this).parent().find('span').fadeOut(150);
    }
});

$(document).on('click', '.instagram-stories .img img', function(e) {
    e.preventDefault();

    var image = $(this).attr("src")
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

$(document).on('blur', '#search-profile', function(e) {
    console.log('teste');

    var search = $(this).val();

    $.post('http://ps_phone/GetProfilesInstagramLike', JSON.stringify({
        search: search
    }), function(profiles) {
        if (profiles) {

            var nprofiles = JSON.parse(profiles);

            $.each(nprofiles, function(i, profile) {

                if (profile.avatar == 'default.png') {
                    var avatar = "img/default.png";
                } else {
                    var avatar = profile.avatar;
                }

                var newhtml = '<img src="' + avatar + '" alt="' + profile.username + '" class="viewprofile" data-id="' + profile.id + '">';
                $("#insta-search #grid").append(newhtml);
            });
        }
    });
});


PS.Phone.Functions.ReceiveAccount = function(account) {
    if (account) {
        PS.Phone.Data.InstagramAccount = account;
        $(".instagram-app .not-logged").hide();
        $(".instagram-app .logged").show();

        $(".preload-stories-insta").show();
        $.post('http://ps_phone/GetStoriesInstagram', JSON.stringify({}), function(stories) {
            PS.Phone.Functions.ReceiveStories(stories);
        });

        $(".preload-posts-insta").show();
        $.post('http://ps_phone/GetPostsInstagram', JSON.stringify({}), function(posts) {
            PS.Phone.Functions.ReceivePosts(posts);
        });
    } else {
        $(".instagram-app .not-logged").show();
        $(".instagram-app .logged").hide();
    }
}


PS.Phone.Functions.ReceiveStories = function(data) {
    $(".instagram-stories").html('');

    var html = '<div class="storie new"></div>';

    $(".instagram-stories").append(html);

    $.post('http://ps_phone/GetMyStorieInstagram', JSON.stringify({}), function(storie) {
        if (storie) {

            var nstorie = JSON.parse(storie);

            if (nstorie.image && nstorie.username) {
                var html = '<div class="img">' +
                    '<img src="' + nstorie.image + '" alt="default">' +
                    '<i class="fas fa-plus-circle"></i>' +
                    '</div>' +
                    '<div class="name">' + nstorie.username + '</div>';
                $(".instagram-stories .new").html(html);
            } else {

                if (PS.Phone.Data.InstagramAccount.avatar == 'default.png') {
                    var avatar = "img/default.png";
                } else {
                    var avatar = PS.Phone.Data.InstagramAccount.avatar;
                }

                var html = '<div class="img">' +
                    '<img src="' + avatar + '" alt="default">' +
                    '<i class="fas fa-plus-circle"></i>' +
                    '</div>' +
                    '<div class="name">' + PS.Phone.Data.InstagramAccount.username + '</div>';
                $(".instagram-stories .new").html(html);
            }
        } else {

            if (PS.Phone.Data.InstagramAccount.avatar == 'default.png') {
                var avatar = "img/default.png";
            } else {
                var avatar = PS.Phone.Data.InstagramAccount.avatar;
            }

            var html = '<div class="img">' +
                '<img src="' + avatar + '" alt="default">' +
                '<i class="fas fa-plus-circle"></i>' +
                '</div>' +
                '<div class="name">' + PS.Phone.Data.InstagramAccount.username + '</div>';
            $(".instagram-stories .new").html(html);
        }
    });

    var stories = JSON.parse(data);

    if (stories.length > 0) {
        $.each(stories, function(i, storie) {
            var newhtml = '<div class="storie">' +
                '<div class="img">' +
                '<img src="' + storie.image + '" alt="default">' +
                '</div>' +
                '<div class="name">' + storie.username + '</div>' +
                '</div>';

            $(".instagram-stories").append(newhtml);
        });
    }

    $(".preload-stories-insta").hide();
}

PS.Phone.Functions.ReceiveMyStorie = function(data) {
    var storie = JSON.parse(data);

    var html = '<div class="img">' +
        '<img src="' + storie.image + '" alt="default">' +
        '<i class="fas fa-plus-circle"></i>' +
        '</div>' +
        '<div class="name">' + storie.username + '</div>';
    $(".instagram-stories .new").html(html);
}

PS.Phone.Functions.ReceivePosts = function(data) {
    $(".insta-posts").html('');

    var posts = JSON.parse(data);

    if (posts.length > 0) {
        $.each(posts, function(i, post) {

            if (post.avatar == 'default.png') {
                var avatar = "img/default.png";
            } else {
                var avatar = post.avatar;
            }

            var time = printdate(post.created);
            time = time.replace("-", "");

            // var html = `<div class="card">
            //     <div class="card-header">
            //         <div class="profile-img">
            //             <img class="profile-img viewprofiletwo" src="${avatar}" data-username="${post.username}"/>
            //         </div>
            //         <div class="profile-info">
            //             <div class="name viewprofiletwo" data-username="${post.username}">${post.username}</div>
            //             <div class="location">${post.location}</div>
            //         </div>
            //         <div class="time">${time}</div>
            //     </div>
            //     <div class="content">
            //         <figure class="${post.filter}">
            //             <img src="${post.image}" class="content" />
            //         </figure>
            //     </div>
            //     <div class="card-footer">
            //         <div class="footer-content">
            //             <span class="likes">2 curtidas</span>
            //             <p><span>${post.username}</span> ${post.description}</p>
            //             <form class="form">
            //                 <span class="heart">
            //                     <i class="fas fa-heart" aria-hidden="true"></i>
            //                 </span>
            //                 <span class="add-comment">
            //                     <input type="text" placeholder="Adicionar um comentário..." />
            //                     <span>Publicar</span>
            //                 </span>
            //             </form>
            //         </div>
            //     </div>
            // </div>`;

            var html = `<div class="card">
                <div class="card-header">
                    <div class="profile-img">
                        <img class="profile-img viewprofiletwo" src="${avatar}" data-username="${post.username}"/>
                    </div>
                    <div class="profile-info">
                        <div class="name viewprofiletwo" data-username="${post.username}">${post.username}</div>
                        <div class="location">${post.location}</div>
                    </div>
                    <div class="time">${time}</div>
                </div>
                <div class="content">
                    <figure class="${post.filter}">
                        <img src="${post.image}" class="content" />
                    </figure>
                </div>
                <div class="card-footer">
                    <div class="footer-content">
                        <p><span>${post.username}</span> ${post.description}</p>
                    </div>
                </div>
            </div>`;

            $(".insta-posts").append(html);
        });
    }

    $(".preload-posts-insta").hide();
}

$(document).on('submit', '.addaccountinsta', function(e) {
    var name = $(".addaccountinsta #name").val();
    var username = $(".addaccountinsta #username").val();
    var password = $(".addaccountinsta #password").val();

    if (name.length <= 0 || username.length <= 0 || password.length <= 0) {
        $(".instagram-app .not-logged .error p").html("Preencha todos os campos");
        $(".instagram-app .not-logged .error").show();
        return false;
    }

    if (name.length < 6) {
        $(".instagram-app .not-logged .error p").html("O nome deve no minino 6 digitos");
        $(".instagram-app .not-logged .error").show();
        return false;
    }

    if (username.length < 6) {
        $(".instagram-app .not-logged .error p").html("O nome de usuário deve no minino 6 digitos");
        $(".instagram-app .not-logged .error").show();
        return false;
    }

    if (password.length < 6) {
        $(".instagram-app .not-logged .error p").html("A senha deve no minino 6 digitos");
        $(".instagram-app .not-logged .error").show();
        return false;
    }

    $(".instagram-app .not-logged .error p").html();
    $(".instagram-app .not-logged .error").hide();

    $.post('http://ps_phone/AddAccountInsta', JSON.stringify({
        name: name,
        username: username,
        password: password
    }), function(account) {
        PS.Phone.Data.InstagramAccount = account;
        $(".instagram-app .not-logged").hide();
        $(".instagram-app .logged").show();

        PS.Phone.Notifications.Add("fas fa-check", "Cria conta", "Conta criada com sucesso! Finalize e abra novamente o aplicativo", "green");

        $(".preload-stories-insta").show();
        $.post('http://ps_phone/GetStoriesInstagram', JSON.stringify({}), function(stories) {
            PS.Phone.Functions.ReceiveStories(stories);
        });

        $(".preload-posts-insta").show();
        $.post('http://ps_phone/GetPostsInstagram', JSON.stringify({}), function(posts) {
            PS.Phone.Functions.ReceivePosts(posts);
        });
    });

    return false;
});

$(document).on('click', '.instagram-stories .new', function(e) {
    e.preventDefault();

    $.post('http://ps_phone/PostNewImage', JSON.stringify({}),
        function(url) {
            if (url.length > 0) {
                var image = url;
                $.post('http://ps_phone/AddStorieInsta', JSON.stringify({
                    image: image
                }), function(check) {
                    if (check) {
                        $(".instagram-stories .new img").attr("src", url);
                    }
                });
            }
        },
    );

    PS.Phone.Functions.Close();

});

$(document).on('click', '.addpost', function(e) {
    e.preventDefault();

    $.post('http://ps_phone/PostNewImage', JSON.stringify({}),
        function(url) {
            if (url.length > 0) {
                var image = url;
                $(".post-photo-filter img").attr("src", image)
                $(".post-photo-filter").animate({
                    left: 0 + "vh"
                }, 200, function() {
                    $(".post-photo-filter").css({
                        "display": "block"
                    });
                });
            }
        },
    );

    PS.Phone.Functions.Close();
});

$(document).on('click', '.post-photo-filter .next', function(e) {
    var image = $(".post-photo-filter .image-preview img").attr('src');
    var filter = $(".post-photo-filter .image-preview figure").attr('class');

    $(".post-preview .image-preview img").attr("src", image)
    $(".post-preview .image-preview figure").removeClass().addClass(filter);

    $(".post-preview").animate({
        left: 0 + "vh"
    }, 200, function() {
        $(".post-preview").css({
            "display": "block"
        });
    });

});

$(document).on('click', '.post-preview .next', function(e) {
    var image = $(".post-preview .image-preview img").attr('src');
    var filter = $(".post-preview .image-preview figure").attr('class');
    var description = $(".post-preview .text textarea").val();
    var position = $(".post-preview #sendposition p").html();

    $.post('http://ps_phone/AddPostInsta', JSON.stringify({
        image: image,
        filter: filter,
        description: description,
        location: position
    }), function(check) {
        if (check) {
            $(".post-photo-filter").animate({
                left: -35 + "vh"
            }, 200, function() {
                $(".post-photo-filter").css({
                    "display": "none"
                });
            });

            $(".post-preview").animate({
                left: -35 + "vh"
            }, 200, function() {
                $(".post-preview").css({
                    "display": "none"
                });
            });
        }
    });

});

$(document).on('click', '.getposts', function(e) {
    verifyopenstories();
    verifyopenposts();
    e.preventDefault();
});

$(document).on('click', '.searchprofiles', function(e) {
    $("#insta-search #grid").html('');
    $.post('http://ps_phone/GetProfilesInstagram', JSON.stringify({}), function(profiles) {
        if (profiles) {

            var nprofiles = JSON.parse(profiles);

            $.each(nprofiles, function(i, profile) {

                if (profile.avatar == 'default.png') {
                    var avatar = "img/default.png";
                } else {
                    var avatar = profile.avatar;
                }

                var newhtml = '<img src="' + avatar + '" alt="' + profile.username + '" class="viewprofile" data-id="' + profile.id + '">';
                $("#insta-search #grid").append(newhtml);
            });
        }
    });
});

$(document).on('click', '.viewprofile', function(e) {
    var id = $(this).attr('data-id');
    $.post('http://ps_phone/GetProfileInstagram', JSON.stringify({
        id: id
    }), function(profile) {
        if (profile) {

            var nprofile = JSON.parse(profile);

            if (nprofile.account.avatar == 'default.png') {
                var avatar = "img/default.png";
            } else {
                var avatar = nprofile.account.avatar;
            }

            var htmldata = `<table>
                <tr class="topsub">
                    <td>${nprofile.total_posts}</td>
                    <td>${nprofile.total_follows}</td>
                    <td>${nprofile.total_followeds}</td>
                </tr>
                <tr class="bottomsub">
                    <td>Posts</td>
                    <td>Seguidores</td>
                    <td>Seguindo</td>
                </tr>
            </table>
            <a href="javascript:void(0)" class="followuser" data-username="${nprofile.account.username}">Começar Seguir</a>`;

            $(".user-profile #user-name").text(nprofile.account.username);
            $(".user-profile .profileDetail .name").text(nprofile.account.name);
            $(".user-profile .profileDetail .description").text(nprofile.account.description);
            $(".user-profile .profileImg img").attr("src", avatar);
            $(".user-profile .next").hide();
            $(".user-profile .profileFollow").html(htmldata);

            $(".user-profile .ImgTab").html('');

            $.each(nprofile.posts, function(i, post) {

                var html = `<div class="ImgPro">
                    <figure class="${post.filter}">
                        <img src="${post.image}"/>
                    </figure>
                </div>`;

                $(".user-profile .ImgTab").append(html);
            });

            $(".user-profile").animate({
                left: 0 + "vh"
            }, 200, function() {
                $(".user-profile").css({
                    "display": "block"
                });
            });

        }
    });
});

$(document).on('click', '.viewprofiletwo', function(e) {
    var username = $(this).attr('data-username');

    if (username == PS.Phone.Data.InstagramAccount.username) {
        return false;
    }

    $.post('http://ps_phone/GetProfileInstagramUsername', JSON.stringify({
        username: username
    }), function(profile) {
        if (profile) {

            var nprofile = JSON.parse(profile);

            if (nprofile.account.avatar == 'default.png') {
                var avatar = "img/default.png";
            } else {
                var avatar = nprofile.account.avatar;
            }

            var htmldata = `<table>
                <tr class="topsub">
                    <td>${nprofile.total_posts}</td>
                    <td>${nprofile.total_follows}</td>
                    <td>${nprofile.total_followeds}</td>
                </tr>
                <tr class="bottomsub">
                    <td>Posts</td>
                    <td>Seguidores</td>
                    <td>Seguindo</td>
                </tr>
            </table>
            <a href="javascript:void(0)" class="sendmessage" data-username="${nprofile.account.username}">Enviar Mensagem</a>`;

            $(".user-profile #user-name").text(nprofile.account.username);
            $(".user-profile .profileDetail .name").text(nprofile.account.name);
            $(".user-profile .profileDetail .description").text(nprofile.account.description);
            $(".user-profile .profileImg img").attr("src", avatar);
            $(".user-profile .profileFollow").html(htmldata);
            $(".user-profile #insta-unfollow").attr("data-username", nprofile.account.username);

            $(".user-profile .ImgTab").html('');

            $.each(nprofile.posts, function(i, post) {

                var html = `<div class="ImgPro">
                    <figure class="${post.filter}">
                        <img src="${post.image}"/>
                    </figure>
                </div>`;

                $(".user-profile .ImgTab").append(html);
            });

            $(".user-profile").animate({
                left: 0 + "vh"
            }, 200, function() {
                $(".user-profile").css({
                    "display": "block"
                });
            });

        }
    });
});

$(document).on('click', '.followuser', function(e) {
    var username = $(this).attr('data-username');
    $.post('http://ps_phone/FollowUserInsta', JSON.stringify({
        username: username
    }), function(check) {
        if (check) {

            $('#insta-home').tab('show');

            $(".user-profile").animate({
                left: -35 + "vh"
            }, 200, function() {
                $(".user-profile").css({
                    "display": "none"
                });
            });
        }
    });
});

$(document).on('click', '#insta-unfollow', function(e) {
    var username = $(this).attr('data-username');
    $.post('http://ps_phone/UnfollowUserInsta', JSON.stringify({
        username: username
    }), function(check) {
        if (check) {

            $('#insta-home').tab('show');

            $(".user-profile").animate({
                left: -35 + "vh"
            }, 200, function() {
                $(".user-profile").css({
                    "display": "none"
                });
            });
        }
    });
});

$(document).on('click', '.myprofile', function(e) {
    var id = PS.Phone.Data.InstagramAccount.id;
    $.post('http://ps_phone/GetProfileInstagram', JSON.stringify({
        id: id
    }), function(profile) {
        if (profile) {

            var nprofile = JSON.parse(profile);

            if (nprofile.account.avatar == 'default.png') {
                var avatar = "img/default.png";
            } else {
                var avatar = nprofile.account.avatar;
            }

            var htmldata = `<table>
                <tr class="topsub">
                    <td>${nprofile.total_posts}</td>
                    <td>${nprofile.total_follows}</td>
                    <td>${nprofile.total_followeds}</td>
                </tr>
                <tr class="bottomsub">
                    <td>Posts</td>
                    <td>Seguidores</td>
                    <td>Seguindo</td>
                </tr>
            </table>
            <a href="javascript:void(0)" class="editprofile" data-id="${nprofile.account.id}">Editar Perfil</a>`;

            $(".myprofiletab .profileDetail .name").text(nprofile.account.name);
            $(".myprofiletab .profileDetail .description").text(nprofile.account.description);
            $(".myprofiletab .profileImg img").attr("src", avatar);
            $(".myprofiletab .profileFollow").html(htmldata);

            $(".myprofiletab .ImgTab").html('');

            $.each(nprofile.posts, function(i, post) {

                var html = `<div class="ImgPro">
                    <figure class="${post.filter}">
                        <img src="${post.image}"/>
                    </figure>
                </div>`;

                $(".myprofiletab .ImgTab").append(html);
            });

        }
    });
});

$(document).on('click', '.editprofile', function(e) {
    console.log("teste");
    var id = PS.Phone.Data.InstagramAccount.id;
    var name = PS.Phone.Data.InstagramAccount.name;
    var username = PS.Phone.Data.InstagramAccount.username;
    var password = PS.Phone.Data.InstagramAccount.password;
    var avatar = PS.Phone.Data.InstagramAccount.avatar;
    var description = PS.Phone.Data.InstagramAccount.description;

    $("#edit-profile #avatar").val(avatar);
    $("#edit-profile #name").val(name);
    $("#edit-profile #username").val(username);
    $("#edit-profile #description").val(description);

    $(".user-edit-profile").animate({
        left: 0 + "vh"
    }, 200, function() {
        $(".user-edit-profile").css({
            "display": "block"
        });
    });
});

$(document).on('click', '.sendpictureprofile', function(e) {
    e.preventDefault();

    $.post('http://ps_phone/PostNewImage', JSON.stringify({}),
        function(url) {
            $('#edit-profile #avatar').val(url)
        },
    );

    PS.Phone.Functions.Close();

});

$(document).on('click', '.saveprofileinsta', function(e) {
    e.preventDefault();

    var avatar = $("#edit-profile #avatar").val();
    var name = $("#edit-profile #name").val();
    var username = $("#edit-profile #username").val();
    var description = $("#edit-profile #description").val();

    if (avatar != "" && name != "" && username != "") {

        $.post('http://ps_phone/EditProfileInsta', JSON.stringify({
                avatar: avatar,
                name: name,
                username: username,
                description: description,
            }),
            function(check) {
                if (check) {
                    $(".user-edit-profile").animate({
                        left: -35 + "vh"
                    }, 200, function() {
                        $(".user-edit-profile").css({
                            "display": "none"
                        });
                    });
                }
            },
        );

    } else {
        PS.Phone.Notifications.Add("fas fa-exclamation-circle", "Editar perfil", "Preencha todos os campos!");
    }

});

function printdate(date2) {
    var date1 = new Date().getTime();
    var returno = "";
    var msec = date2 - date1;
    var mins = Math.floor(msec / 60000);
    var hrs = Math.floor(mins / 60);
    var days = Math.floor(hrs / 24);
    var yrs = Math.floor(days / 365);

    if (mins > -60) {
        returno = mins + "m";
        return returno;
    }

    mins = mins % 60;

    if (hrs > -24) {
        returno = hrs + "h";
        return returno;
    }

    hrs = hrs % 24;

    if (days > -365) {
        returno = days + "d";
        return returno;
    }

    days = days % 365;

    returno = yrs + "a";
    return returno;
}

setInterval(function() {
    verifyopenposts();
    verifyopenstories();
}, 5000);

function verifyopenposts() {
    var openposts = $('.insta-posts').is(':visible');

    if (openposts) {
        $.post('http://ps_phone/GetPostsInstagram', JSON.stringify({}), function(posts) {
            PS.Phone.Functions.ReceivePosts(posts);
        });
    }
}

function verifyopenstories() {
    var openstories = $('.instagram-stories').is(':visible');

    if (openstories) {
        $.post('http://ps_phone/GetStoriesInstagram', JSON.stringify({}), function(stories) {
            PS.Phone.Functions.ReceiveStories(stories);
        });
    }
}