client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

data_file 'HANDLING_FILE' 'data/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/carcols.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'data/vehiclelayouts.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/carvariations.meta'

files {
  'data/handling.meta',
  'data/vehicles.meta',
  'data/carcols.meta',
  'data/carvariations.meta',
  'data/vehiclelayouts.meta',
}

client_script 'vehicle_names.lua'
              