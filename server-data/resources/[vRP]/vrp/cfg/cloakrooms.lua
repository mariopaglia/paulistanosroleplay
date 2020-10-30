local cfg = {}

local surgery_male = {model = "mp_m_freemode_01"}
local surgery_female = {model = "mp_f_freemode_01"}
local husky = {model = "a_c_husky"}
local chop = {model = "a_c_chop"}
local uniforme_ft01 = {model = "s_m_m_armoured_01"}
local uniforme_rocam = {model = "s_m_y_blackops_03"}
local uniforme_rota = {model = "s_m_y_ranger_01"}
local uniforme_rp01 = {model = "s_m_y_blackops_02"}

for i = 0, 19 do
	surgery_female[i] = {0, 0}
	surgery_male[i] = {0, 0}
end

cfg.cloakroom_types = {
	["Fardamento PMESP"] = {
		_config = {permissions = {"pmesp.permissao"}},
		["PMESP [1] | Masculino"] = {
			[1] = {-1, 0}, -- Mascara / Textura
			[3] = {0, 0}, -- Luvas / Textura
			[4] = {35, 0}, -- Calça / Textura
			[5] = {-1, 0}, -- Paraquedas / Textura
			[6] = {51, 0}, -- Sapatos / Textura
			[7] = {8, 0}, -- Gravatas / Textura
			[8] = {15, 0}, -- Camisa / Textura
			[9] = {16, 0}, -- Colete / Textura
			[10] = {-1, 0}, -- Emblema / Textura
			[11] = {97, 0}, -- Jaqueta / Textura
			["p0"] = {-1, 0} -- Acessorio / Textura
		},
		["PMESP [2] | Masculino"] = {
			[1] = {0, 0}, -- Mascara / Textura
			[3] = {0, 0}, -- Luvas / Textura
			[4] = {35, 0}, -- Calça / Textura
			[6] = {51, 0}, -- Sapatos / Textura
			[7] = {8, 0}, -- Gravatas / Textura
			[8] = {15, 0}, -- Camisa / Textura
			[9] = {16, 0}, -- Colete / Textura
			[10] = {1, 0}, -- Emblema / Textura
			[11] = {190, 0}, -- Jaqueta / Textura
			["p0"] = {3, 0} -- Acessorio / Textura
		}
	},
	["Fardamento ROTA"] = {
		_config = {permissions = {"rota.permissao"}},
		["ROTA [1] | Masculino"] = {
			[1] = {58, 1}, -- Mascara / Textura
			[3] = {1, 0}, -- Luvas / Textura
			[4] = {25, 0}, -- Calça / Textura
			[5] = {33, 0}, -- Paraquedas / Textura
			[6] = {51, 0}, -- Sapatos / Textura
			[7] = {0, 0}, -- Gravatas / Textura
			[8] = {44, 0}, -- Camisa / Textura
			[9] = {0, 0}, -- Colete / Textura
			[10] = {8, 0}, -- Emblema / Textura
			[11] = {103, 0}, -- Jaqueta / Textura
			["p0"] = {-1, 0} -- Acessorio / Textura
		},
		["ROTA [2] | Masculino"] = {
			[1] = {58, 1}, -- Mascara / Textura
			[3] = {0, 0}, -- Luvas / Textura
			[4] = {35, 0}, -- Calça / Textura
			[5] = {33, 0}, -- Paraquedas / Textura
			[6] = {51, 0}, -- Sapatos / Textura
			[7] = {8, 0}, -- Gravatas / Textura
			[8] = {15, 0}, -- Camisa / Textura
			[9] = {11, 0}, -- Colete / Textura
			[10] = {0, 0}, -- Emblema / Textura
			[11] = {190, 0}, -- Jaqueta / Textura
			["p0"] = {-1, 0} -- Acessorio / Textura
		}
	},
	["Fardamento SAMU"] = {
		_config = {permissions = {"paramedico.permissao"}},
		["SAMU [1] | Masculino"] = {
			[1] = {36, 0}, -- Mascara / Textura
			[3] = {134, 0}, -- Luvas / Textura
			[4] = {53, 0}, -- Calça / Textura
			[5] = {-1, 0}, -- Paraquedas / Textura
			[6] = {51, 0}, -- Sapatos / Textura
			[7] = {-1, 0}, -- Gravatas / Textura
			[8] = {15, 0}, -- Camisa / Textura
			[9] = {-1, 0}, -- Colete / Textura
			[10] = {-1, 0}, -- Emblema / Textura
			[11] = {102}, -- Jaqueta / Textura
			["p0"] = {-1, 0} -- Acessorio / Textura
		}
	},
	["Fardamento PCESP"] = {
		_config = {permissions = {"pcivil.permissao"}},
		["GARRA [1] | Masculino"] = {
			[1] = {-1, 1}, -- Mascara / Textura
			[3] = {0, 0}, -- Luvas / Textura
			[4] = {4, 0}, -- Calça / Textura
			[5] = {-1, 0}, -- Paraquedas / Textura
			[6] = {51, 0}, -- Sapatos / Textura
			[7] = {-1, 0}, -- Gravatas / Textura
			[8] = {15, 0}, -- Camisa / Textura
			[9] = {7, 0}, -- Colete / Textura
			[10] = {-1, 0}, -- Emblema / Textura
			[11] = {1, 0}, -- Jaqueta / Textura
			["p0"] = {-1, 0} -- Acessorio / Textura
		},
		["GARRA [2] | Masculino"] = {
			[1] = {52, 0}, -- Mascara / Textura
			[3] = {22, 0}, -- Luvas / Textura
			[4] = {33, 0}, -- Calça / Textura
			[5] = {-1, 0}, -- Paraquedas / Textura
			[6] = {24, 0}, -- Sapatos / Textura
			[7] = {-1, 0}, -- Gravatas / Textura
			[8] = {15, 0}, -- Camisa / Textura
			[9] = {7, 0}, -- Colete / Textura
			[10] = {-1, 0}, -- Emblema / Textura
			[11] = {49, 0}, -- Jaqueta / Textura
			["p0"] = {-1, 0} -- Acessorio / Textura
		},
		["PCESP [3] | Masculino"] = {
			[7] = {8, 0}, -- Gravatas / Textura
			[9] = {7, 0} -- Colete / Textura
		}
	},
	["Fardamento PRF"] = {
		_config = {permissions = {"prf.permissao"}},
		["PRF [1] | Masculino"] = {
			[1] = {-1, 0}, -- Mascara / Textura
			[3] = {4, 0}, -- Luvas / Textura
			[4] = {9, 1}, -- Calça / Textura
			[5] = {-1, 0}, -- Paraquedas / Textura
			[6] = {63, 0}, -- Sapatos / Textura
			[7] = {1, 0}, -- Gravatas / Textura
			[8] = {55, 0}, -- Camisa / Textura
			[9] = {-1, 0}, -- Colete / Textura
			[10] = {-1, 0}, -- Emblema / Textura
			[11] = {111}, -- Jaqueta / Textura
			["p0"] = {-1, 0} -- Acessorio / Textura
		},
		["PRF [2] | Masculino"] = {
			[1] = {-1, 0}, -- Mascara / Textura
			[3] = {4, 0}, -- Luvas / Textura
			[4] = {9, 1}, -- Calça / Textura
			[5] = {-1, 0}, -- Paraquedas / Textura
			[6] = {63, 0}, -- Sapatos / Textura
			[7] = {1, 0}, -- Gravatas / Textura
			[8] = {55, 0}, -- Camisa / Textura
			[9] = {-1, 0}, -- Colete / Textura
			[10] = {-1, 0}, -- Emblema / Textura
			[11] = {111}, -- Jaqueta / Textura
			["p0"] = {4, 1} -- Acessorio / Textura
		},
		["PRF [3] | Masculino"] = {
			[1] = {-1, 0}, -- Mascara / Textura
			[3] = {4, 0}, -- Luvas / Textura
			[4] = {9, 1}, -- Calça / Textura
			[5] = {-1, 0}, -- Paraquedas / Textura
			[6] = {63, 0}, -- Sapatos / Textura
			[7] = {1, 0}, -- Gravatas / Textura
			[8] = {55, 0}, -- Camisa / Textura
			[9] = {-1, 0}, -- Colete / Textura
			[10] = {-1, 0}, -- Emblema / Textura
			[11] = {111}, -- Jaqueta / Textura
			["p0"] = {5, 1} -- Acessorio / Textura
		},
		["PRF [4] | Masculino"] = {
			[1] = {-1, 0}, -- Mascara / Textura
			[3] = {4, 0}, -- Luvas / Textura
			[4] = {9, 1}, -- Calça / Textura
			[5] = {-1, 0}, -- Paraquedas / Textura
			[6] = {63, 0}, -- Sapatos / Textura
			[7] = {1, 0}, -- Gravatas / Textura
			[8] = {55, 0}, -- Camisa / Textura
			[9] = {5, 0}, -- Colete / Textura
			[10] = {-1, 0}, -- Emblema / Textura
			[11] = {98}, -- Jaqueta / Textura
			["p0"] = {-1, 0} -- Acessorio / Textura
		},
		["PRF [5] | Masculino"] = {
			[1] = {-1, 0}, -- Mascara / Textura
			[3] = {4, 0}, -- Luvas / Textura
			[4] = {9, 1}, -- Calça / Textura
			[5] = {-1, 0}, -- Paraquedas / Textura
			[6] = {63, 0}, -- Sapatos / Textura
			[7] = {1, 0}, -- Gravatas / Textura
			[8] = {55, 0}, -- Camisa / Textura
			[9] = {5, 0}, -- Colete / Textura
			[10] = {-1, 0}, -- Emblema / Textura
			[11] = {98}, -- Jaqueta / Textura
			["p0"] = {4, 1} -- Acessorio / Textura
		},
		["PRF MOTO [1] | Masculino"] = {
			[1] = {-1, 0}, -- Mascara / Textura
			[3] = {4, 0}, -- Luvas / Textura
			[4] = {9, 1}, -- Calça / Textura
			[5] = {-1, 0}, -- Paraquedas / Textura
			[6] = {63, 0}, -- Sapatos / Textura
			[7] = {1, 0}, -- Gravatas / Textura
			[8] = {55, 0}, -- Camisa / Textura
			[9] = {-1, 0}, -- Colete / Textura
			[10] = {-1, 0}, -- Emblema / Textura
			[11] = {98}, -- Jaqueta / Textura
			["p0"] = {17, 0} -- Acessorio / Textura
		}
	}
}

cfg.cloakrooms = {
	{"Fardamento PMESP", -1098.7556152344, -830.91094970703, 14.302787322998},
	{"Fardamento ROTA", -1095.0867919922, -829.58959960938, 14.282787322998},
	{"Fardamento PCESP", 458.6598815918, -992.93743896484, 30.689655303955},
	{"Fardamento PRF", 2900.6137695313, 3819.74609375, 54.609714508057},
	{"Fardamento SAMU", 301.32916259766, -599.16723632813, 43.283996582031}
}

return cfg
