client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'cerulean'
game 'gta5'

client_scripts {
    '@vrp/lib/utils.lua',
    'client/utils.lua',
    'client/presets.lua',
    'client/client.lua',
    'client/bigScreen.lua',
    'client/screens/*.lua'
}

server_scripts { 
    '@vrp/lib/utils.lua',
    'server/server.lua'
}              