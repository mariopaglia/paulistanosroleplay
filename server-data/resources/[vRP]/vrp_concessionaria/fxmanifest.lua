client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'adamant'
game 'gta5'

ui_page "nui/ui.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"client.lua",
}

server_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"server.lua",
}

files {
	"nui/assets/css/bootstrap.min.css",
	"nui/assets/css/style.css",
	"nui/ui.html",
	"nui/ui.js",
	"nui/img/carros/*",
	"nui/img/*",
}              