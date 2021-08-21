fx_version "adamant"
 game "gta5" 

author 'cruzz#5071'
description 'Script de PvP para o Fenix. Desenvolvido por cruzz#5071'

server_scripts {
   "@vrp/lib/utils.lua",
   "sv_.lua"
}
client_scripts {
   "@vrp/lib/utils.lua",
   "cl_.lua"
}

shared_script 'config.lua'