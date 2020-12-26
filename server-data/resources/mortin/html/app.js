// MADE BY KALU AND KASHNAR
// [ALL CITY]
// version : 1.00
// update : 16/06/2018
// info: 
function hex2rgba(hex, opacity) {
    //extract the two hexadecimal digits for each color
    var patt = /^#([\da-fA-F]{2})([\da-fA-F]{2})([\da-fA-F]{2})$/;
    var matches = patt.exec(hex);

    //convert them to decimal
    var r = parseInt(matches[1], 16);
    var g = parseInt(matches[2], 16);
    var b = parseInt(matches[3], 16);

    //create rgba string
    var rgba = "rgba(" + r + "," + g + "," + b + "," + opacity + ")";

    //return rgba colour
    return rgba;
}
window.onData = function (data) {
    if (data.setDisplay == true) {
        $("body").css('background', hex2rgba("#000000", 0.97));
        //$("body").css('background', '#131313bd');
        $("#container").css('display', 'flex');
    } else {
        $('*').css('background', 'transparent');
        $("#container").css('display', 'none');
    }

}


window.onload = function (e) {
    window.addEventListener('message', function (event) {
        onData(event.data)
    });
}