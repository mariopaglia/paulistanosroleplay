window.addEventListener('message', (event) => {
	let data = event.data
	if (data.type == 'open') {
		const nome = data.nome + ' ' + data.sobrenome;
		const emprego = data.emprego;
		const cargo = data.cargo;
		const carteira = data.carteira;
		const paypal = data.paypal;
		const vip = data.vip;
		const id = data.id;
		const documento = data.documento;
		const idade = data.idade;
		const banco = data.banco;
		const telefone = data.telefone;
		const multas = data.multas;
		const avatar = data.avatar;

		// if (avatar != null) {
		// 	const avatarURL = JSON.stringify(avatar[0]['avatarURL']).replace('"', ' ').replace('"', ' ');
		// 	if (avatarURL.length > 5) {
		// 		$('.avatar-holder img').attr('src', "" + avatarURL + "");
		// 	}
		// }

		$('.name p').text(nome);
		$('.name h6 span').text(emprego);
		$('.cargo').hide();
		$('.carteira p').text('R$' + carteira);
		$('.coins p').text(cargo);
		$('.vip p').text(vip);
		$('.identidade p').text(id);
		$('.documento p').text(documento);
		$('.idade p').text(idade);
		$('.banco p').text('R$' + banco);
		$('.multas p').text('R$' + multas);
		$('.telefone p').text(telefone);

		$('#roxId').fadeIn('fast');
	}

	if (data.type == 'close') {
		$('#roxId').fadeOut('slow');
	}
});