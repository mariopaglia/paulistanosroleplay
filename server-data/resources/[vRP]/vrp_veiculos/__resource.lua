client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

files {
	"data/handling.meta",
	"data/vehiclelayouts.meta",
	"data/vehicles.meta",
	"data/carcols.meta",
	"data/carvariations.meta",
	"audio/*",
	"audio/**/*"
}

client_script "data/tuning.lua"

data_file "HANDLING_FILE" "data/handling.meta"
data_file "VEHICLE_LAYOUTS_FILE" "data/vehiclelayouts"
data_file "VEHICLE_METADATA_FILE" "data/vehicles.meta"
data_file "CARCOLS_FILE" "data/carcols.meta"
data_file "VEHICLE_VARIATION_FILE" "data/carvariations.meta"

data_file "AUDIO_WAVEPACK" "audio/elegyx/dlc_elegyx"
data_file "AUDIO_GAMEDATA" "audio/elegyx/elegyx_game.dat"
data_file "AUDIO_SOUNDDATA" "audio/elegyx/elegyx_sounds.dat"

data_file "AUDIO_WAVEPACK" "audio/rb26dett/dlc_rb26dett"
data_file "AUDIO_GAMEDATA" "audio/rb26dett/rb26dett_game.dat"
data_file "AUDIO_SOUNDDATA" "audio/rb26dett/rb26dett_sounds.dat"

data_file "AUDIO_WAVEPACK" "audio/rotary7/dlc_rotary7"
data_file "AUDIO_GAMEDATA" "audio/rotary7/rotary7_game.dat"
data_file "AUDIO_SOUNDDATA" "audio/rotary7/rotary7_sounds.dat"

data_file "AUDIO_WAVEPACK" "audio/toysupmk4/dlc_toysupmk4"
data_file "AUDIO_GAMEDATA" "audio/toysupmk4/toysupmk4_game.dat"
data_file "AUDIO_SOUNDDATA" "audio/toysupmk4/toysupmk4_sounds.dat"