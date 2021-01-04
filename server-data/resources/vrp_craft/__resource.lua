resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

ui_page "client/html/ui.html"
files {
	"client/html/ui.html",
	"client/html/styles.css",
	"client/html/scripts.js",
	"configNui.js",
	"client/html/debounce.min.js",
	"client/html/sweetalert2.all.min.js",
	"client/html/sweetalert2.all.min.js",
	"client/html/assets/icons/*.png"
}

client_scripts {
	"lib/Proxy.lua",
	"@vrp/lib/utils.lua",
	"lib/Tunnel.lua",
	"config.lua",
	"client.lua",
	"receitas.lua",
	"locais.lua",
	"funcoes.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"server.lua"
}
