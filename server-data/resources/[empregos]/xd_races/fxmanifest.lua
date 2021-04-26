fx_version 'adamant'
game 'gta5'

author 'potter from xD Group'
contact 'discord.gg/fcKp6Tub74 / potter#0961'

ui_page "nui/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"server.lua"
}


files {
	"nui/style.css",
	"nui/app.js",
	"nui/index.html"
}

--[[ CREATE TABLE IF NOT EXISTS `xd_races` (
  `user_id` int(11) NOT NULL,
  `tempo` int(11) DEFAULT 0,
  `race_id` int(11) DEFAULT 0,
  `order` MEDIUMINT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`order`)  
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4; ]]