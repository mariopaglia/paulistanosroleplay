client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

client_script "client.lua"

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"
}


files {
	"app.js",
	"index.html",
	"style.css"
}

ui_page {
	"index.html"
}              