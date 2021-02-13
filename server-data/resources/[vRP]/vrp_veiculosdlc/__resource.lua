resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

files { 
    --Vehicls
'vehicles.meta', 
'carvariations.meta', 
'carcols.meta', 
'handling.meta', 
'vehiclelayouts.meta',
'clip_sets.xml',
} 

data_file 'HANDLING_FILE' 'handling.meta' 
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta' 
data_file 'CARCOLS_FILE' 'carcols.meta' 
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta' 
data_file 'VEHICLE_LAYOUTS_FILE' 'vehiclelayouts.meta' 
data_file 'CLIP_SETS_FILE' 'clip_sets.xml'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_hei4'
-- data_file 'AUDIO_GAMEDATA' 'dlchei4_game.dat'
-- data_file 'AUDIO_SOUNDDATA' 'dlchei4_sounds.dat'

