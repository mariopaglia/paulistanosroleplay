client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

client_script "client.lua"

files {
	"ui/js/app.js",
	"ui/js/iziToast.min.js",
	"ui/js/iziToast.js",
	"ui/index.html",
	"ui/css/iziToast.css"
}

ui_page {
	"ui/index.html"
}              