client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

dependencies {
	"vrp",
	"GHMattiMySQL"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"init.lua"
}              