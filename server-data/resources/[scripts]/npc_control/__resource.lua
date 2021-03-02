client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"


description "npc_control"

client_scripts{ 
  "lib/enum.lua",
  "cfg/npcs.lua",
  "client.lua"
}              