client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"


description "vrp_payday"

dependency "vrp"

client_scripts{ 
  "client.lua",
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}
              