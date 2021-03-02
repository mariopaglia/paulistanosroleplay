client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
dependency 'vrp'

server_scripts{
'@vrp/lib/utils.lua',
 "vRPServer.lua"
}


--client_scripts {
--	"col.lua"
--}              