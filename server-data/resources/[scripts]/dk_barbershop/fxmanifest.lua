fx_version 'adamant'
game 'gta5'

author 'potter#2002'
dependencies 'vrp'

ui_page 'html/ui.html'
files {
    'html/ui.html',
    'html/ui.css',
    'html/ui.js',
    'html/fonts/*',
    'html/imgs/*'
}

client_script {
    "@vrp/lib/utils.lua",
    "config.lua",
    "client.lua"
}

server_scripts{
    "@vrp/lib/utils.lua",
    "config.lua",
    "server.lua"
}

-- 0008
