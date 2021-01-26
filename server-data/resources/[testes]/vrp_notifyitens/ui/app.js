$(document).ready(function () {
	window.addEventListener("message", function (event) {
		var html = ""

		if (event.data.mode == 'sucesso') {
			html = "<div id='showitem' class='showItemS' style=\"background-image: url('http://177.54.158.241:8080/imagens/" + event.data.item + ".png'); background-size: 100px;\"><b><sucesso>Recebido</sucesso><br>" + event.data.mensagem + "</b></div>"
		}

		if (event.data.mode == 'negado') {
			html = "<div id='showitem'  class='showItemN' style=\"background-image: url('http://177.54.158.241:8080/imagens/" + event.data.item + ".png'); background-size: 100px;\"><b><negado>Removido</negado><br>" + event.data.mensagem + "</b></div>"
		}

		$(html).fadeIn(500).appendTo("#notifyitens").delay(3000).fadeOut(500);
	})
});