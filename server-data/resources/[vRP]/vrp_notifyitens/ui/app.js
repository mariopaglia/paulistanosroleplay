$(document).ready(function () {
	window.addEventListener("message", function (event) {
		var html = ""

		if (event.data.mode == 'sucesso') {
			html = '<div class="fundo"><div class="fundofalso"><img src="http://177.54.144.176:8080/imagens/' + event.data.item + '.png" alt=""></div><div class="fundoimg"></div><div class="texto"><span class="aviso" style="color: white;">ITEM RECEBIDO (+)</span><br><span id="add">' + event.data.mensagem + '</span></div></div><br><br><br><br>'
		}

		if (event.data.mode == 'negado') {
			html = '<div class="fundo"><div class="fundofalso"><img src="http://177.54.144.176:8080/imagens/' + event.data.item + '.png" alt=""></div><div class="fundoimg"></div><div class="texto"><span class="aviso" style="color: white;">ITEM REMOVIDO (-)</span><br><span id="add">' + event.data.mensagem + '</span></div></div><br><br><br><br>'

		}

		$(html).fadeIn(500).appendTo("#notifyitens").delay(5000).fadeOut(500);
	})
});