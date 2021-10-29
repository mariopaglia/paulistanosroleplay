let roupaID = null;
let colorID = null;
let dataPart = null;
let change = {}
var dataOld = "mascara"

$(document).ready(function() {
    document.onkeydown = function(data) {
        if (data.keyCode == 27) {
            $('footer').html('');
            $(".loja-de-roupa").fadeOut();
            $('#total').html('0'); 
            change = {};
            $.post('http://xd_barbershop/reset', JSON.stringify({}))
            $.post('http://ph-hud/fechar', JSON.stringify({ id: false }))
        }
    }
    document.onkeyup = function(data){
        if(data.which == 65){ //a
            $.post('http://xd_barbershop/leftHeading', JSON.stringify({ value: 10 }));
        }
        if(data.which == 68) { //d
            $.post('http://xd_barbershop/rightHeading', JSON.stringify({ value: 10 }));
        }
        if(data.which == 88) { //levantar
            $.post('http://xd_barbershop/handsUp', JSON.stringify({}));
        }
        if(data.which == 39) { //right
            $.post('http://xd_barbershop/changeColor', JSON.stringify({ type: dataPart, id: roupaID, action: "mais" }));
        }
        if(data.which == 37) { //left
            $.post('http://xd_barbershop/changeColor', JSON.stringify({ type: dataPart, id: roupaID, action: "menos" }));
        }
    }


    $("#payament").click(function() {
        $(".loja-de-roupa").fadeOut()
        $.post('http://ph-hud/fechar', JSON.stringify({ id: false }));
        $.post('http://xd_barbershop/payament', JSON.stringify({ price: $('#total').text() }));
        $('#total').html('0');
        change = {};
    })

    window.addEventListener('message', function(event) {
        let item = event.data;

        if (item.action == 'setPrice') {
            if (item.typeaction == "add") {
                $('#total').html(item.price)
            }
            if (item.typeaction == "remove") {
                $('#total').html(item.price)
            }
        }
        $(".left-colum").html('');
        if (item.options){
            for (var i = 0; i <= (item.options.length - 1); i++) {
                $(".left-colum").append(`
                    <div class="submenu-item mascara subActive" onclick="selectPart(this)" data-idpart="${item.options[i]}">
                        <div class="icon-submenu">
                            <img style="" src="imgs/${item.options[i]}.png">
                        </div>
                    </div>
                `);
            };
        }
        if (item.opacity){
            $('.slider-wrapper').show()
        }else{
            $('.slider-wrapper').hide()
        }
        if (item.openBarbershop) {
            $("footer").html('');
            change = {};
            $(".loja-de-roupa").fadeIn()
            $('.color-colum').html('')
            $('.seccolor-colum').html('')
            dataPart = item.category
            for (var i = -1; i <= (item.drawa - 1); i++) {
                if (!item.toRemove[item.prefix][dataPart][i]) {
                    $("footer").append(`
                    <div class="item-clothe" data-id="${i}" data-def="${item.def}" onclick="select(this)">
                    <div class="img-clothe" style="background-image: url('http://189.127.164.170:8080/barbershop/${item.category}/${item.sexo}/${item.prefix}/${i}.png')">  
                    <div class="overlay">
                                <span>${i}</span>
                            </div>
                        </div>
                    </div>
                `);
                }
            };
        }
        if (item.changeCategory) {
            dataPart = item.category
            $('footer').html('')
            $('.color-colum').html('')
            $('.seccolor-colum').html('')
            for (var i = -1; i <= (item.drawa - 1); i++) {
                if (!item.toRemove[item.prefix][dataPart][i]) {
                    $("footer").append(`
                    <div class="item-clothe ${item.category}${i}" data-id="${i}" data-def="${item.def}" onclick="select(this)">
                        <div class="img-clothe" style="background-image: url('http://189.127.164.170:8080/barbershop/${item.category}/${item.sexo}/${item.prefix}/${i}.png')">  
                            <div class="overlay">
                                <span>${i}</span>
                            </div>
                        </div>
                    </div>
                    `);
                }
            };
            if(dataPart == 5 || dataPart == 8) {
                if (item.hasColor) {
                    for (var i = 0; i <= (63); i++) {
                        $(".color-colum").append(`
                        <div class="blushcolor-option" data-id="${i}" onclick="changeColor(this)"></div>
                    `);
                    }
                };
            } else {
                if (item.hasColor) {
                    for (var i = 0; i <= (65); i++) {
                        $(".color-colum").append(`
                        <div class="color-option" data-id="${i}" onclick="changeColor(this)"></div>
                    `);
                    }
                };
                if (item.hasSecColor) {
                    for (var i = 0; i <= (65); i++) {
                        $(".seccolor-colum").append(`
                        <div class="color-option" data-id="${i}" onclick="changeSecColor(this)"></div>
                    `);
                    }
                };
            }
        }
    })
});

function update_valor() {
    const formatter = new Intl.NumberFormat('pt-BR', { minimumFractionDigits: 2 })
    let total = 0
    for (let key in change) { if (!change[key] == 0) { total += 40 } }
    $('#total').html(formatter.format(total))
}


function selectPart(element) {
    let dataPart = element.dataset.idpart
    $('header h1').html(dataPart)
    $(`.${dataPart}`).find('img').css('filter', 'invert(100%)')
    $('.submenu-item').removeClass('subActive')
    $(element).addClass('subActive')
    $.post('http://xd_barbershop/changePart', JSON.stringify({ part: dataPart }))
    $(`.${dataOld}`).find('img').css('filter', 'invert(0%)')
    dataOld = dataPart
}

function changeColor(element) {
    colorID = element.dataset.id;
    $.post('http://xd_barbershop/changeColor', JSON.stringify({ type: dataPart, id: roupaID, color: colorID}));
}
function changeSecColor(element) {
    colorID = element.dataset.id;
    $.post('http://xd_barbershop/changeSecColor', JSON.stringify({ type: dataPart, id: roupaID, color: colorID}));
}
function select(element) {
    $("footer div").find('.overlay').css("background-color", "transparent");
    $("footer div").css("border", "1px solid #ff7b00");
    roupaID = element.dataset.id;
    definition = element.dataset.def;
    $("footer div").css("border", "0");
    
    $(element).css("border", "1px solid #ff7b00");
    $(element).find('.overlay').css("background-color", "#ff7b00");
    $.post('http://xd_barbershop/changeCustom', JSON.stringify({ type: dataPart, id: roupaID, def: definition }));
}

function sendOpacity() {
    let amount = Number($(".slider").val())
    $.post('http://xd_barbershop/changeOpacity', JSON.stringify({ opacity: amount.toFixed(2) }));
}



