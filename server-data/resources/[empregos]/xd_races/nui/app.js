$(document).ready(function(){

	window.addEventListener("message",function(event){
		if (event.data.racing == true){
		    $("#race").fadeIn(1000);
			$("#race2").fadeIn(1500);
			$("#corrida").fadeIn(1700);
			$("#namerace").fadeIn(1900);
			$("#namerace2").fadeIn(2100);
			$("#namerace3").fadeIn(2300);
			$("#namerace4").fadeIn(2500);
			$("#namerace5").fadeIn(2700);
		    $(".pos2").html(event.data.pos);
		    $(".time").html(event.data.time + "s");
		    $(".total").html(event.data.race);
			$(".cname").html(event.data.corrida);
			$(".namer1").html(event.data.name1);
			$(".namer2").html(event.data.name2);
			$(".namer3").html(event.data.name3);
			$(".namer4").html(event.data.name4);
			$(".namer5").html(event.data.name5);
			$(".recordtime1").html(event.data.tempo1);
			$(".recordtime2").html(event.data.tempo2);
			$(".recordtime3").html(event.data.tempo3);
			$(".recordtime4").html(event.data.tempo4);
			$(".recordtime5").html(event.data.tempo5);
			
	    } else {
		    $("#race").fadeOut(700);
		    $("#race2").fadeOut(700);
			$("#corrida").fadeOut(700);
			$("#namerace").fadeOut(700);
			$("#namerace2").fadeOut(700);
			$("#namerace3").fadeOut(700);
			$("#namerace4").fadeOut(700);
			$("#namerace5").fadeOut(700);
		}
	});

});