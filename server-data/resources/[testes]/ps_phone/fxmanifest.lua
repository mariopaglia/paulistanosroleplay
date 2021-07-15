
--Creditos ! RC#0001
--o queridinho de todos kkkkkk fudase


fx_version 'bodacious'
games { 'gta5' }

author 'Pequi Shop'
description 'Script for phone'
version '1.0.8'

ui_page "html/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
    'client/main.lua',
    'client/animation.lua',
    'client/photo.lua',	
    'client/gui.lua',
}

server_scripts {
	"@vrp/lib/utils.lua",
	"@mysql-async/lib/MySQL.lua",
    'server/main.lua',
}

files {
    'html/*.html',
    'html/js/*.js',
    'html/img/*.png',
    'html/css/*.css',
    'html/fonts/*.ttf',
    'html/fonts/*.otf',
    'html/fonts/*.woff',
    'html/img/backgrounds/*.png',
    'html/img/backgrounds/*.jpg',
    'html/img/apps/*.png',
    'html/img/icons/*.png',
    'html/img/navigation/*.png',
    'html/sound/*.ogg',
    'config.lua'
}