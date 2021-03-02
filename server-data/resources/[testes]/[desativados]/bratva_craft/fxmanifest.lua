client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'adamant'
game 'gta5'

author 'Ziraflix Dev Group'
contact 'E-mail: contato@ziraflix.com - Discord: discord.gg/6p3M3Cz'
version '1.0.4'

ui_page 'nui/darkside.html'

client_scripts {
	'@vrp/lib/utils.lua',
	'hansolo/*.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'skywalker.lua'
}

files {
	'nui/*.html',
	'nui/*.js',
	'nui/*.css',
	'nui/**/*'
}              