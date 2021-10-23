
$(() => {

	$("body").hide()
	window.addEventListener("message", function(event){
		if (event.data.teste != undefined) {
			let status = event.data.teste
			if (status) {
				$("body").show()
			} else {
				$("body").hide()
				
			}
		}
	})

	$(".fechar").click(function(){
		$.post("http://cs_acoes/fechar", JSON.stringify({ teste: true }))
	})
})
document.onkeyup = function(data) {
	if (data.which == 27) {
		$.post("http://cs_acoes/fechar", JSON.stringify({ teste: true }))
	}}

	$(".button").click(function(){
		$.post("http://cs_acoes/comprar", JSON.stringify({ teste: true }))
	})

	$(".button2").click(function(){
		$.post("http://cs_acoes/vender", JSON.stringify({ vender: true }))
	})
	
	window.addEventListener('message', (event) => {
		let data = event.data
		if(data.type == 'open') {
			const saldo = data.saldo;
			const valor = data.valor;
			$('.saldo p').text('R$ '+saldo);
			$('.valor p').text('R$ '+valor);
		}
	});
	
	
