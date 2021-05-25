client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

files {
	"data/handling.meta",
	"data/vehicles.meta",
	"data/carcols.meta",
	"data/carvariations.meta"
}

client_script "data/tuning.lua"

data_file "HANDLING_FILE" "data/handling.meta"
data_file "VEHICLE_METADATA_FILE" "data/vehicles.meta"
data_file "CARCOLS_FILE" "data/carcols.meta"
data_file "VEHICLE_VARIATION_FILE" "data/carvariations.meta"

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

files {
	"data/av-amarok/handling.meta",
	"data/av-amarok/vehicles.meta",
	"data/av-amarok/carcols.meta",
	"data/av-amarok/carvariations.meta"
}

client_script "data/tuning.lua"

data_file "HANDLING_FILE" "data/av-amarok/handling.meta"
data_file "VEHICLE_METADATA_FILE" "data/av-amarok/vehicles.meta"
data_file "CARCOLS_FILE" "data/av-amarok/carcols.meta"
data_file "VEHICLE_VARIATION_FILE" "data/av-amarok/carvariations.meta"

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

data_file 'VEHICLE_LAYOUTS_FILE' 'data/av-blindado/vehiclelayouts.meta'
data_file 'CARCOLS_FILE' 'data/av-blindado/carcols.meta'
data_file 'HANDLING_FILE' 'data/av-blindado/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/av-blindado/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/av-blindado/carvariations.meta'


files {
	'data/av-blindado/vehiclelayouts.meta',
	'data/av-blindado/carcols.meta',
	'data/av-blindado/handling.meta',
	'data/av-blindado/vehicles.meta',
	'data/av-blindado/carvariations.meta',
}

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

files {
	"data/av-bmwg20/handling.meta",
	"data/av-bmwg20/vehicles.meta",
	"data/av-bmwg20/carcols.meta",
	"data/av-bmwg20/carvariations.meta"
}

client_script "data/av-bmwg20/tuning.lua"

data_file "HANDLING_FILE" "data/av-bmwg20/handling.meta"
data_file "VEHICLE_METADATA_FILE" "data/av-bmwg20/vehicles.meta"
data_file "CARCOLS_FILE" "data/av-bmwg20/carcols.meta"
data_file "VEHICLE_VARIATION_FILE" "data/av-bmwg20/carvariations.meta"

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

files {
	"data/av-gt63/handling.meta",
	"data/av-gt63/vehicles.meta",
	"data/av-gt63/carcols.meta",
	"data/av-gt63/carvariations.meta"
}

client_script "data/av-gt63/tuning.lua"

data_file "HANDLING_FILE" "data/av-gt63/handling.meta"
data_file "VEHICLE_METADATA_FILE" "data/av-gt63/vehicles.meta"
data_file "CARCOLS_FILE" "data/av-gt63/carcols.meta"
data_file "VEHICLE_VARIATION_FILE" "data/av-gt63/carvariations.meta"

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

files {
	"data/av-m8/handling.meta",
	"data/av-m8/vehicles.meta",
	"data/av-m8/carcols.meta",
	"data/av-m8/carvariations.meta"
}

client_script "data/av-m8/tuning.lua"

data_file "HANDLING_FILE" "data/av-m8/handling.meta"
data_file "VEHICLE_METADATA_FILE" "data/av-m8/vehicles.meta"
data_file "CARCOLS_FILE" "data/av-m8/carcols.meta"
data_file "VEHICLE_VARIATION_FILE" "data/av-m8/carvariations.meta"

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

files {
	"data/ghispo2/handling.meta",
	"data/ghispo2/vehicles.meta",
	"data/ghispo2/carcols.meta",
	"data/ghispo2/carvariations.meta"
}

client_script "data/ghispo2/tuning.lua"

data_file "HANDLING_FILE" "data/ghispo2/handling.meta"
data_file "VEHICLE_METADATA_FILE" "data/ghispo2/vehicles.meta"
data_file "CARCOLS_FILE" "data/ghispo2/carcols.meta"
data_file "VEHICLE_VARIATION_FILE" "data/ghispo2/carvariations.meta"

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

files {
	'data/av-nc7/vehicles.meta',
	'data/av-nc7/carvariations.meta',
	'data/av-nc7/carcols.meta',
	'data/av-nc7/handling.meta',
	'data/av-nc7/vehiclelayouts.meta'
}

data_file 'HANDLING_FILE' 'data/av-nc7/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/av-nc7/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/av-nc7/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/av-nc7/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'data/av-nc7/vehiclelayouts.META'

client_script 'data/av-nc7/vehicle_names.lua'

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

files {
	'data/levante/vehicles.meta',
	'data/levante/carvariations.meta',
	'data/levante/carcols.meta',
	'data/levante/handling.meta',
	'data/levante/vehiclelayouts.meta'
}

data_file 'HANDLING_FILE' 'data/levante/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/levante/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/levante/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/levante/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'data/levante/vehiclelayouts.META'

client_script 'data/levante/vehicle_names.lua'

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

files {
	'data/pdfocus/vehicles.meta',
	'data/pdfocus/carvariations.meta',
	'data/pdfocus/carcols.meta',
	'data/pdfocus/handling.meta',
	'data/pdfocus/vehiclelayouts.meta'
}

data_file 'HANDLING_FILE' 'data/pdfocus/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/pdfocus/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/pdfocus/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/pdfocus/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'data/pdfocus/vehiclelayouts.META'

client_script 'data/pdfocus/vehicle_names.lua'

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\