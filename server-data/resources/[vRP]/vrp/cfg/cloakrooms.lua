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
		["PMESP [M] - [Recruta]"] = {
			[1] = {0,0,2},	-- Mascara / Textura
			[3] = {0,0,1},	-- Luvas / Textura
			[4] = {35,0,1},	-- Calça / Textura
			[5] = {-1,0,2},	-- Paraquedas / Textura
			[6] = {25,0,2},	-- Sapatos / Textura
			[7] = {0,0,1},	-- Gravatas / Textura
			[8] = {122,0,1},	-- Camisa / Textura
			[9] = {0,0,1},	-- Colete / Textura
			[10] = {0,0,1},	-- Emblema / Textura
			[11] = {190,1,1},	-- Jaqueta / Textura
			["p0"] = {10,0}	-- Acessorio / Textura
		},
		["PMESP [M] - [1]"] = {
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
		["PMESP [M] - [2]"] = {
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
		},
		["PMESP [M] - Força Tática"] = {
			[1] = {58, 0, 2}, -- Mascara / Textura
			[3] = {0, 0}, -- Luvas / Textura
			[4] = {35, 0}, -- Calça / Textura
			[5] = {52, 0}, -- Paraquedas / Textura
			[6] = {51, 0}, -- Sapatos / Textura
			[7] = {8, 0}, -- Gravatas / Textura
			[8] = {58, 0, 1}, -- Camisa / Textura
			[9] = {11, 0, 1}, -- Colete / Textura
			[10] = {-1, 0}, -- Emblema / Textura
			[11] = {97, 0}, -- Jaqueta / Textura
			["p0"] = {-1, 0} -- Acessorio / Textura
		},
		["PMESP [M] - ROCAM"] = {
			[1] = {0, 0, 2}, -- Mascara / Textura
			[3] = {19, 0, 1}, -- Luvas / Textura
			[4] = {35, 0}, -- Calça / Textura
			[5] = {32, 0}, -- Paraquedas / Textura
			[6] = {51, 0}, -- Sapatos / Textura
			[7] = {8, 0}, -- Gravatas / Textura
			[8] = {58, 0, 1}, -- Camisa / Textura
			[9] = {11, 0, 1}, -- Colete / Textura
			[10] = {-1, 0}, -- Emblema / Textura
			[11] = {97, 0}, -- Jaqueta / Textura
			["p0"] = {48, 0} -- Acessorio / Textura
		}
	},
	["Fardamento ROTA"] = {
		_config = {permissions = {"rota.permissao"}},
		["ROTA [1] | Masculino"] = {
			[1] = {58, 1}, -- Mascara / Textura
			[3] = {6, 0}, -- Luvas / Textura
			[4] = {35, 0, 1}, -- Calça / Textura
			[5] = {33, 0}, -- Paraquedas / Textura
			[6] = {54, 0}, -- Sapatos / Textura
			[7] = {0, 0}, -- Gravatas / Textura
			[8] = {44, 0}, -- Camisa / Textura
			[9] = {0, 0}, -- Colete / Textura
			[10] = {0, 0}, -- Emblema / Textura
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
			[8] = {56, 0}, -- Camisa / Textura
			[9] = {11, 0}, -- Colete / Textura
			[10] = {0, 0}, -- Emblema / Textura
			[11] = {190, 0}, -- Jaqueta / Textura
			["p0"] = {-1, 0} -- Acessorio / Textura
		}
	},
	["Fardamento SAMU"] = {
		_config = {permissions = {"paramedico.permissao"}},
			["Diretor"] = {
				[1] = { -1,0 },
				[3] = { 4,0 },
				[4] = { 25,5 },
				[5] = { -1,0 },
				[6] = { 21,9 },
				[7] = { 126,0 },			
				[8] = { 31,0 },
				[9] = { -1,0 },
				[10] = { -1,0 },
				[11] = { 31,7 },
				["p0"] = { -1,0 },
				["p1"] = { -1,0 },
				["p2"] = { -1,0 },
				["p6"] = { -1,0 },
				["p7"] = { -1,0 }
			},
			["Medico"] = {
				[1] = { -1,0 },
				[3] = { 81,0 },
				[4] = { 25,5 },
				[5] = { -1,0 },
				[6] = { 21,9 },
				[7] = { 126,0 },			
				[8] = { 57,1 },
				[9] = { -1,0 },
				[10] = { -1,0 },
				[11] = { 13,0 },
				["p0"] = { -1,0 },
				["p1"] = { -1,0 },
				["p2"] = { -1,0 },
				["p6"] = { -1,0 },
				["p7"] = { -1,0 }
			},
			["Medica"] = {
				[1] = {-1,0,1},
				[3] = {7,0,1},
				[4] = {23,0,2},
				[5] = {-1,0,1},
				[6] = {19,8,0},
				[7] = {96,0,1},
				[8] = {38,7,0},
				[9] = {-1,1,2},
				[10] = {-1,0,0},
				[11] = {57,7,1},
				["p0"] = {57,0,0},
				["p6"] = {3,0},
			},
			["PARAMEDICO Masculino"] = {
			[1] = {121,0,0},
			[2] = {18,0,0},
			[3] = {127,0,0},
			[4] = {38,1,0},
			[5] = {0,0,0},
			[6] = {24,0,0},
			[7] = {126,0,2},
			[8] = {15,0,0},
			[9] = {-1,0,0},
			[10] = {-1,0,0},
			[11] = {65,1,0},
			["p0"] = {-1,0,0},
			["p1"] = {7,0,0},
			["p6"] = {-1,0},
		},
		["PARAMEDICO Feminino"] = {
			[2] = {8,0,0},
			[3] = {167,0,0},
			[4] = {38,1,2},
			[5] = {0,0,0},
			[6] = {24,0,0},
			[7] = {96,0,0},
			[8] = {14,0,0},
			[9] = {-1,0,0},
			[10] = {0,0,0},
			[11] = {59,1,0},
			["p0"] = {-1,1,0},
			["p6"] = {-1,0},
		},
	},
	["Fardamento PCESP"] = {
		_config = {permissions = {"pcivil.permissao"}},
		["PC [M] - [Paisana]"] = {
			[1] = {0,0,2},
			[2] = {21,0,0},
			[3] = {38,0,1},
			[4] = {26,0,1},
			[5] = {-1,0,2},
			[6] = {12,6,1},
			[7] = {125,0,1},
			[8] = {130,0,1},
			[9] = {0,0,1},
			[10] = {0,0,1},
			[11] = {50,0,1},
			["p0"] = {9,0}
		},
		["PC [M] - [Ação]"] = {
			[1] = {52,0,1},
			[2] = {21,0,0},
			[3] = {38,0,1},
			[4] = {87,6,1},
			[5] = {-1,0,2},
			[6] = {25,0,1},
			[7] = {1,1,1},
			[8] = {57,0,1},
			[9] = {7,0,1},
			[10] = {0,0,1},
			[11] = {50,0,1},
			["p0"] = {8,0}
		},
		["PC [M] - [Colete]"] = {
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
