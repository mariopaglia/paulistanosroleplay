 fx_version 'bodacious'
game 'gta5'

autor 'HERO STAR - Parceiro SnaKe Resources - Realizada conversão com sucesso'

files {
	'data/handling.meta',          -- DIRECIONAL DO VEÍCULO E ADAPTAÇÃO PARA NÃO CAPOTAR EM CURVAS
	'data/vehiclelayouts.meta',    -- DESENHO ESTRUTURAL DO VEÍCULO
	'data/vehicles.meta',          -- CONFIGURAÇÃO DE INTERIOR E FUNÇÕES COMO PORTAS
	'data/carcols.meta',           -- CONFIGURAÇÃO DO MOD
	'data/carvariations.meta',      -- CONFIGURAÇÃO DE FUNÇÃO DE DESEMPENHO
	'data/tuning.meta'             -- ADICIONADO TUNING PARA BENNY´S
}

client_script 'data/tuning.lua'

data_file 'HANDLING_FILE' 'data/handling.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'data/vehiclelayouts'
data_file 'VEHICLE_METADATA_FILE' 'data/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/carvariations.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/tuning.meta'

-- SUPORTE DE 7 DIAS PARA CONFIGURAÇÃO ORIGINAL APÓS CONVERSÃO
