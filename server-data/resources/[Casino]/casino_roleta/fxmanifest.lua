client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'adamant'
game 'gta5'


client_scripts {
    '@vrp/lib/utils.lua',
    'config.lua',
    'translations.lua',
    'shared/shared_utils.lua',
    'client/cl_main.lua'
}

server_scripts {
    '@vrp/lib/utils.lua',
    'config.lua',
    'translations.lua',
    'shared/shared_utils.lua',
    'server/sv_main.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/js/*.js',
    'html/DEP/*.js',
    'html/img/**',
    'html/ProximaNova.woff'
}              