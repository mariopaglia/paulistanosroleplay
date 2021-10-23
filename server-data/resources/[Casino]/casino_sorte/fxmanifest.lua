fx_version 'adamant'
game "gta5"

client_scripts {
    '@vrp/lib/utils.lua',
	'shared/shared_utils.lua',
	'client/client.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@vrp/lib/utils.lua',
	'shared/shared_utils.lua',
	'server/server.lua'
}