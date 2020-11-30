$(function () {
	init();

	var actionContainer = $(".actionmenu");

	window.addEventListener("message", function (event) {
		var item = event.data;

		if (item.showmenu) {
			ResetMenu();
			$('body').css('background-color', 'rgba(0, 0, 0, 0.15)')
			actionContainer.fadeIn();
		}

		if (item.hidemenu) {
			$('body').css('background-color', 'transparent')
			actionContainer.fadeOut();
		}
	});

	document.onkeyup = function (data) {
		if (data.which == 27) {
			if (actionContainer.is(":visible")) {
				sendData("ButtonClick", "fechar");
			}
		}
	};
});

function ResetMenu() {
	$("div").each(function (i, obj) {
		var element = $(this);

		if (element.attr("data-parent")) {
			element.hide();
		} else {
			element.show();
		}
	});
}

function init() {
	$(".menuoption2").each(function (i, obj) {
		if ($(this).attr("data-action")) {
			$(this).click(function () {
				var data = $(this).data("action");
				sendData("ButtonClick", data);
			});
		}

		if ($(this).attr("data-sub")) {
			var menu = $(this).data("sub");
			var element = $("#" + menu);

			$(this).click(function () {
				element.show();
				$("#mainmenu").hide();
			});

			$(".subtop button, .back").click(function () {
				element.hide();
				$("#mainmenu").show();
			});
		}
	});
}

function sendData(name, data) {
	$.post("http://nav_producao-municao-colete/" + name, JSON.stringify(data), function (
		datab
	) {
		if (datab != "ok") {
			console.log(datab);
		}
	});
}

$('.category_item').click(function () {
	let pegMuni = $(this).attr('category');
	$('.item-item2').css('transform', 'scale(0)');

	function hideArma() {
		$('.item-item2').hide();
	}
	setTimeout(hideArma, 100);

	function showArma() {
		$('.item-item2[category="' + pegMuni + '"]').show();
		$('.item-item2[category="' + pegMuni + '"]').css('transform', 'scale(1)');
	}
	setTimeout(showArma, 100);
});

$('.category_item[category="all"]').click(function () {
	function showAll() {
		$('.item-item2').show();
		$('.item-item2').css('transform', 'scale(1)');
	}
	setTimeout(showAll, 100);
});