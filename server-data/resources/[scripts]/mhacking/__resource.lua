client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page 'hack.html'

client_scripts {
  'mhacking.lua',
  'sequentialhack.lua'
}

files {
  'phone.png',
  'snd/beep.ogg',
  'snd/correct.ogg',
  'snd/fail.ogg', 
  'snd/start.ogg',
  'snd/finish.ogg',
  'snd/wrong.ogg',
  'hack.html'
}              