$(document).ready(function() {
    window.addEventListener("message", function(event) {


        $(document).ready(function() {
            window.addEventListener("message", function(event) {
                let icone;
                if (event.data.css === "importante") {
                    icone = "info"
                }
                if (event.data.css === "sucesso") {
                    icone = "success"
                }
                if (event.data.css === "negado") {
                    icone = "error"
                }

                Swal.fire({
                    position: 'top-end',
                    icon: icone,
                    title: '<span style="color:#FFFFFF">' + "" + event.data.mensagem + '<span>',
                    showConfirmButton: false,
                    timer: 3000,
                    backdrop: false,

                    customClass: 'swal-wide',
                    customClass: {

                        popup: 'swal-wide',
                        header: 'swal-wide2',
                        title: 'title-class',

                        content: 'swal-wide2',


                    }
                })

            })
        });

    })
});