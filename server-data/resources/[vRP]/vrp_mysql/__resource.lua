client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"


description "vRP MySQL async"

dependency "vrp"

-- server scripts
server_scripts{ 
  "@vrp/lib/utils.lua",
  "mysql.net.dll",
  "init.lua"
}

server_exports{
  "createConnection",
  "createCommand",
  "query",
  "checkTask"
}
              