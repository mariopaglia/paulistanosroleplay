$(function () {
    window.addEventListener('message', function (event) {
        if (event.data.type === "openGeneral") {
            $('#concessionaria').fadeIn();
            $(".menu").empty();
            $(".packages-content").empty();
            $(".packages-content").append("<div class='row'><div class='col-lg-12'><center><strong>Carregando veículos...<strong></center></div></div>");

            $("#carros").height($('#concessionaria').height() - $(".top-area").height() - 100);
            getData();
        } else if (event.data.type === "closeAll") {
            $("#concessionaria").hide();
        } else if (event.data.type === "loadData") {
            var veiculos = JSON.parse(event.data.veiculos);
            $(".packages-content").empty();
            criarCatalogo(veiculos, event.data.totalTipo, event.data.aberto, event.data.isVendedor);
            criarMeus(veiculos, event.data.meusVeiculos, event.data.aberto, event.data.isVendedor);
        }

        if (event.data.type === "alert") {
            Swal.fire(
                event.data.title,
                event.data.msg,
                event.data.typeMsg
            )
        }
    });

    document.onkeyup = function (data) {
        if (data.which == 27) {
            sendData("ButtonClick", {
                action: "close"
            });
        }
    }
});

function getData() {
    $.post("http://vrp_concessionaria/CarregarDados", null, function (event) {});
}

function criarCatalogo(veiculos, totalTipo, aberto, isVendedor) {
    $(veiculos).each(function (i, data) {
        if (data.categoria.title != "Importados") {
            $(".menu").append("<li class=\"smooth-menu\" id='aba_" + data.categoria.id + "' onclick=\"setAba('" + data.categoria.id + "')\">" + data.categoria.title + "</li>");

            $(".packages-content").append("<div class='row' id='div_" + data.categoria.id + "'></div>");
            $(data.veiculos).each(function (i2, dataV) {

                var total = dataV.estoque
                $(totalTipo).each(function (iTotal, Total) {
                    if (Total.vehicle == dataV.model) {
                        total = total - Total.total;
                        return false;
                    }
                });
                // var preco = "Consulte"
                var preco = "R$ " + addCommas(parseInt(dataV.preco))
                if (aberto || isVendedor) {
                    preco = "R$ " + addCommas(parseInt(dataV.preco))
                    if (isVendedor) {
                        // preco = "R$ " + addCommas(parseInt(dataV.preco * 0.9))
                        preco = "R$ " + addCommas(parseInt(dataV.preco))
                    }
                }
				
				function visualize(iv){
					if(iv){
						return `<button class="about-view packages-btn" onclick="visualizar(\'${i}\',\'${i2}\')">VISUALIZAR</button>`;
					}
					return "";
				}
                // <p><span><B> DISPONÍVEL</B></span><B>${total}</B></p>
                var htmlCarro = `
					<div class="col-md-3 col-sm-4">
						<div class="single-package-item">
							<img src="img/carros/${dataV.model}.png" alt="package-place">
							<img src="img/testdrive.png" class="testdrive" onclick="testdrive(\'${i}\',\'${i2}\')">
							<div class="single-package-item-txt">
								<h3>${dataV.title}<span class="pull-right">${preco}</span></h3>
								<div class="packages-para">
									<p><span> <B> PORTA MALAS </B> </span><B>${dataV.mala}Kg</B></p>
								</div>
								<div class="about-btn">
									<button class="about-view packages-btn" onclick="comprar(\'${i}\',\'${i2}\')">COMPRAR</button>
									${visualize(isVendedor)}
								</div>
							</div>
						</div>
					</div>`;

                $(".packages-content #div_" + data.categoria.id).append(htmlCarro);
            });
        }
    });
    $(".menu").append("<li id='aba_meus' class=\"right\" onclick=\"setAba('meus')\">Meus Veículos</li>");
    $(".packages-content").append("<div class='row' id='div_meus'></div>");

    $(".menu li:first").addClass("selected");
    $(".packages-content .row").hide();
    $(".packages-content .row:first").show();
}

function criarMeus(veiculos, meusVeiculos, aberto, isVendedor) {
    $(veiculos).each(function (i, data) {
        $(data.veiculos).each(function (i2, dataV) {
            $(meusVeiculos).each(function (i3, data3) {
                if (data3.vehicle == dataV.model) {

                    // var preco = "$ " + addCommas(dataV.preco * 0.7)
                    var preco = "";
                    if (aberto || isVendedor) {
                        preco = "R$ " + addCommas(parseInt(dataV.preco * 0.7));
                    }

                    var htmlCarro = '<div class="col-md-4 col-sm-6">';
                    htmlCarro += '<div class="single-package-item">';
                    htmlCarro += '<img src="img/carros/' + dataV.model + '.png" alt="package-place">';
                    htmlCarro += '<div class="single-package-item-txt">';
                    htmlCarro += '<h3>' + dataV.title + ' <span class="pull-right">' + preco + '</span></h3>';
                    htmlCarro += '<div class="packages-para">';
                    htmlCarro += '<p>';
                    htmlCarro += '<span> <B> PORTA MALAS </B> </span>';
                    htmlCarro += '<B>' + dataV.mala + 'Kg</B>';
                    htmlCarro += '</p>';
                    htmlCarro += '</div>';
                    htmlCarro += '<div class="about-btn">';
                    htmlCarro += '<button class="about-view packages-btn" onclick="vender(\'' + i + '\',\'' + i2 + '\')">';
                    htmlCarro += 'VENDER';
                    htmlCarro += '</button>';
                    htmlCarro += '</div>';
                    htmlCarro += '</div>';
                    htmlCarro += '</div>';
                    htmlCarro += '</div>';

                    // var htmlCarro = '<div class="carro vender"><img src="img/carros/' + dataV.model + '.png" /><h1>' + dataV.title + ' - ' + preco + '</h1><h2>P. Malas: ' + dataV.mala + 'kg</h2><button type="button" onclick="vender(\'' + i + '\',\'' + i2 + '\')">VENDER</button></div>';

                    $(".packages-content #div_meus").append(htmlCarro);
                    return false;
                }
            });
        });
    });

}

function setAba(nome) {
    $(".menu li").removeClass("selected");
    $(".menu li#aba_" + nome).addClass("selected");

    $(".packages-content .row").hide();
    $(".packages-content #div_" + nome).show();

}

function comprar(categoria, model) {

    Swal.fire({
        title: 'Atenção!',
        text: "Confirme a compra deste veículo!",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'COMPRAR'
    }).then((result) => {
        if (result.value) {
            sendData("ButtonClick", {
                action: "confirmarCompra",
                categoria: categoria,
                model: model
            });
        }
    })
}

function testdrive(categoria, model) {

    Swal.fire({
        title: 'Atenção!',
        text: "Deseja fazer o test drive deste veiculo?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'TEST DRIVE'
    }).then((result) => {
        if (result.value) {
            sendData("ButtonClick", {
                action: "testdrive",
                categoria: categoria,
                model: model
            });
        }
    })
}




function vender(categoria, model) {
    Swal.fire({
        title: 'Atenção!',
        text: "Confirme a venda deste veículo!",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'VENDER'
    }).then((result) => {
        if (result.value) {
            sendData("ButtonClick", {
                action: "confirmarVenda",
                categoria: categoria,
                model: model
            });
        }
    })
}

function visualizar(cat, m){
	sendData("ButtonClick", {
		action: "visualizarCarro",
		categoria: cat,
		model: m
	});
}

function addCommas(nStr) {
    nStr += '';
    x = nStr.split('.');
    x1 = x[0];
    x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + ',' + '$2');
    }
    return x1 + x2;
}

function sendData(name, data) {
    $.post("http://vrp_concessionaria/" + name, JSON.stringify(data), function (datab) {});
}