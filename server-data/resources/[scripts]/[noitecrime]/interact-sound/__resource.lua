client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

-- Manifest Version
resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

-- Client Scripts
client_script 'client/main.lua'

-- Server Scripts
server_script 'server/main.lua'

-- NUI Default Page
ui_page('client/html/index.html')

-- Files needed for NUI
-- DON'T FORGET TO ADD THE SOUND FILES TO THIS!
files {
    'client/html/index.html',
    -- Begin Sound Files Here...
    -- client/html/sounds/ ... .ogg
    'client/html/sounds/demo.ogg',
    'client/html/sounds/buckle.ogg',
    'client/html/sounds/unbuckle.ogg',
    'client/html/sounds/noitecrimemulher.ogg',
    'client/html/sounds/seatbelt.ogg',
    'client/html/sounds/cut.ogg',
	'client/html/sounds/sirene.ogg'
}
              