local cfg = {}

cfg.groups = {
	["founder"] = {
		"founder.permissao",
		"admin.permissao",
		"item.permissao",
		"group.permissao",
		"fix.permissao",
		"dv.permissao",
		"god.permissao",
		"wl.permissao",
		"kick.permissao",
		"ban.permissao",
		"noclip.permissao",
		"tp.permissao",
		"polpar.permissao",
		"placa.permissao",
		"player.blips",
		"player.noclip",
		"player.teleport",
		"player.secret",
		"player.spec", -- Comando /spec
		"player.wall", -- Comando /wall
		"mqcu.permissao", -- Acesso ao menu MQCU
		"anuncio.permissao"
	},
	["admin"] = {
		"admin.permissao",
		"fix.permissao",
		"item.permissao",
		"group.permissao",
		"dv.permissao",
		"god.permissao",
		"wl.permissao",
		"kick.permissao",
		"ban.permissao",
		"noclip.permissao",
		"tp.permissao",
		"polpar.permissao",
		"placa.permissao",
		"player.blips",
		"player.noclip",
		"player.teleport",
		"player.secret",
		"player.spec", -- Comando /spec
		"player.wall", -- Comando /wall
		"mqcu.permissao", -- Acesso ao menu MQCU
		"anuncio.permissao"
	},
	["mod"] = {
		"mod.permissao",
		"dv.permissao",
		"wl.permissao",
		"kick.permissao",
		"ban.permissao",
		"noclip.permissao",
		"tp.permissao",
		"polpar.permissao",
		"placa.permissao",
		"player.blips",
		"player.noclip",
		"player.teleport",
		"player.secret",
		"anuncio.permissao"
	},
	["sup"] = {
		"sup.permissao",
		"wl.permissao",
		"kick.permissao",
		"noclip.permissao",
		"tp.permissao",
		"polpar.permissao",
		"player.blips",
		"player.noclip",
		"player.teleport",
		"player.secret",
	},
	["aprovadorwl"] = {
		"wl.permissao"
	},

	---------------------------------------------------
	-- PLANOS VIPS
	---------------------------------------------------
	["Bronze"] = {
		_config = {
			title = "Bronze",
			gtype = "vip"
		},
		"bronze.permissao",
		"carrosvip.permissao",
		"mochila.permissao"
	},
	["Prata"] = {
		_config = {
			title = "Prata",
			gtype = "vip"
		},
		"prata.permissao",
		"carrosvip.permissao",
		"corarma.permissao",
		"mochila.permissao"
	},
	["Ouro"] = {
		_config = {
			title = "Ouro",
			gtype = "vip"
		},
		"ouro.permissao",
		"carrosvip.permissao",
		"corarma.permissao",
		"roupavip.permissao",
		"mochila.permissao"
	},
	["Platina"] = {
		_config = {
			title = "Platina",
			gtype = "vip"
		},
		"platina.permissao",
		"carrosvip.permissao",
		"corarma.permissao",
		"roupavip.permissao",
		"mochila.permissao"
	},
	["Esmeralda"] = {
		_config = {
			title = "Esmeralda",
			gtype = "vip"
		},
		"esmeralda.permissao",
		"carrosvip.permissao",
		"corarma.permissao",
		"roupavip.permissao",
		"mochila.permissao"
	},
	["Diamante"] = {
		_config = {
			title = "Diamante",
			gtype = "vip"
		},
		"diamante.permissao",
		"carrosvip.permissao",
		"corarma.permissao",
		"roupavip.permissao",
		"mochila.permissao"
	},
	["Boost"] = {
		_config = {
			title = "Nitro Boost",
			gtype = "vip2"
		},
		"boost.permissao",
		"corarma.permissao"
	},

	---------------------------------------------------
	-- POLÍCIA MILITAR
	---------------------------------------------------
	["Recruta"] = {
		_config = {
			title = "PMESP Recruta",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"recruta.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["RecrutaP"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"tooglerec.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	["Soldado"] = {
		_config = {
			title = "PMESP Soldado",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"soldado.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["SoldadoP"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"tooglesol.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	["Cabo"] = {
		_config = {
			title = "PMESP Cabo",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"cabo.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["CaboP"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"tooglecabo.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	["Sargento1"] = {
		_config = {
			title = "PMESP Sargento I",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"sargentoi.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["Sargento1P"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"tooglesargentoi.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	["Sargento2"] = {
		_config = {
			title = "PMESP Sargento II",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"sargentoii.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["Sargento2P"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"tooglesargentoii.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	["Sargento3"] = {
		_config = {
			title = "PMESP Sargento III",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"sargentoiii.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["Sargento3P"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"tooglesargentoiii.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	["Tenente1"] = {
		_config = {
			title = "PMESP Tenente I",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"tenentei.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["Tenente1P"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"toogletenentei.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	["Tenente2"] = {
		_config = {
			title = "PMESP Tenente II",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"tenenteii.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["Tenente2P"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"toogletenenteii.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	["Tenente3"] = {
		_config = {
			title = "PMESP Tenente III",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"tenenteiii.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["Tenente3P"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"toogletenenteiii.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	["Capitao"] = {
		_config = {
			title = "PMESP Capitao",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"capitao.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["CapitaoP"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"tooglecap.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	["Coronel"] = {
		_config = {
			title = "PMESP Coronel",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"coronel.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["CoronelP"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"tooglecor.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	["General"] = {
		_config = {
			title = "PMESP General",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"general.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["GeneralP"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"tooglegeneral.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	["Instrutor"] = {
		_config = {
			title = "PMESP Instrutor",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"instrutor.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["InstrutorP"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"toogleinstrutor.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	["Suplente"] = {
		_config = {
			title = "PMESP Suplente",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"suplente.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["SuplenteP"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"tooglesuplente.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	["Subcomando"] = {
		_config = {
			title = "PMESP Sub-Comando",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"subcomando.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["SubcomandoP"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"tooglesubcomando.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	["Comandante"] = {
		_config = {
			title = "PMESP Comandante",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"comandante.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["ComandanteP"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"tooglecmd.permissao",
		"player.blips",
		"nogarmas.permissao"
	},

	---------------------------------------------------
	-- POLÍCIA CÍVIL
	---------------------------------------------------
	["Agente"] = {
		_config = {
			title = "Policia Civil Agente",
			gtype = "job"
		},
		"policia.permissao",
		"pcivil.permissao",
		"agente.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["AgenteP"] = {
		_config = {
			title = "Policia Civil Paisana",
			gtype = "job"
		},
		"toogleagente.permissao",
		"player.blips",
		"nogarmas.permissao"
	},

	["Inspetor"] = {
		_config = {
			title = "Policia Civil Inspetor",
			gtype = "job"
		},
		"policia.permissao",
		"pcivil.permissao",
		"inspetor.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["InspetorP"] = {
		_config = {
			title = "Policia Civil Paisana",
			gtype = "job"
		},
		"toogleins.permissao",
		"player.blips",
		"nogarmas.permissao"
	},

	["Investigador"] = {
		_config = {
			title = "Policia Civil Investigador",
			gtype = "job"
		},
		"policia.permissao",
		"pcivil.permissao",
		"investigador.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["InvestigadorP"] = {
		_config = {
			title = "Policia Civil Paisana",
			gtype = "job"
		},
		"toogleinv.permissao",
		"player.blips",
		"nogarmas.permissao"
	},

	["Delegado"] = {
		_config = {
			title = "Policia Civil Delegado",
			gtype = "job"
		},
		"policia.permissao",
		"pcivil.permissao",
		"delegado.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["DelegadoP"] = {
		_config = {
			title = "Policia Civil Paisana",
			gtype = "job"
		},
		"toogledel.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	
	---------------------------------------------------
	-- POLÍCIA RODOVIÁRIA FEDERAL
	---------------------------------------------------
	["PRF"] = {
		_config = {
			title = "Policial PRF",
			gtype = "job"
		},
		"policia.permissao",
		"prf.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["PRFP"] = {
		_config = {
			title = "PRF Paisana",
			gtype = "job"
		},
		"toogleprf.permissao",
		"player.blips",
		"nogarmas.permissao"
	},

	---------------------------------------------------
	-- SAMU
	---------------------------------------------------
	["AuxEnfermeiro"] = {
		_config = {
			title = "Aux. Enfermagem SAMU",
			gtype = "job"
		},
		"paramedico.permissao",
		"auxenf.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["AuxEnfermeiroP"] = {
		_config = {
			title = "SAMU Paisana",
			gtype = "job"
		},
		"player.blips",
		"toogleauxenf.permissao"
	},

	["Enfermeiro"] = {
		_config = {
			title = "Enfermeiro(a) SAMU",
			gtype = "job"
		},
		"paramedico.permissao",
		"enfermeiro.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["PaisanaEnfermeiro"] = {
		_config = {
			title = "SAMU Paisana",
			gtype = "job"
		},
		"player.blips",
		"toogleenf.permissao"
	},

	["Medico"] = {
		_config = {
			title = "Medico(a) SAMU",
			gtype = "job"
		},
		"paramedico.permissao",
		"medico.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["PaisanaMedico"] = {
		_config = {
			title = "SAMU Paisana",
			gtype = "job"
		},
		"player.blips",
		"tooglemed.permissao"
	},
	
	["Cirurgiao"] = {
		_config = {
			title = "Cirugiã(o) SAMU",
			gtype = "job"
		},
		"paramedico.permissao",
		"cirurgiao.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["CirurgiaoP"] = {
		_config = {
			title = "SAMU Paisana",
			gtype = "job"
		},
		"player.blips",
		"tooglecirurgiao.permissao"
	},

	["Diretor"] = {
		_config = {
			title = "Diretor SAMU",
			gtype = "job"
		},
		"paramedico.permissao",
		"reviver.permissao",
		"diretor.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["PaisanaDiretor"] = {
		_config = {
			title = "SAMU Paisana",
			gtype = "job"
		},
		"player.blips",
		"tooglediretor.permissao"
	},

	---------------------------------------------------
	-- BENNYS
	---------------------------------------------------
	["Bennys"] = {
		_config = {
			title = "Mecânico(a) Bennys",
			gtype = "job"
		},
		"mecanico.permissao",
		"bennys.permissao",
		"player.blips",
	},
	["BennysP"] = {
		_config = {
			title = "Paisana Mecanico",
			gtype = "job"
		},
		"player.blips",
		"paisanabennys.permissao"
	},

	---------------------------------------------------
	-- SPORTRACE
	---------------------------------------------------
	["SportRace"] = {
		_config = {
			title = "Mecânico(a) SportRace",
			gtype = "job"
		},
		"mecanico.permissao",
		"sportrace.permissao",
		"player.blips",
	},
	["SportRaceP"] = {
		_config = {
			title = "Paisana Mecanico",
			gtype = "job"
		},
		"player.blips",
		"paisanasportrace.permissao"
	},
	
	---------------------------------------------------
	-- CÍVIL
	---------------------------------------------------
	["Civil"] = {
		_config = {
			title = "Civil",
			gtype = "job"
		},
		"civil.permissao"
	},

	---------------------------------------------------
	-- TAXISTA
	---------------------------------------------------
	["Taxista"] = {
		_config = {
			title = "Taxista",
			gtype = "job2"
		},
		"paisanataxista.permissao",
		"taxista.permissao"
	},

	---------------------------------------------------
	-- CONCESSIONÁRIA
	---------------------------------------------------
	["CONCE"] = {
		_config = {
			title = "Vendedor Concessionária",
			gtype = "job"
		},
		"concessionaria.permissao"
	},
	["CONCEP"] = {
		_config = {
			title = "Vendedor Paisana",
			gtype = "job"
		},
		"vendedorpaisana.permissao"
	},
	
	---------------------------------------------------
	-- MOTOCLUB
	---------------------------------------------------
	["MotoclubL"] = {
		_config = {
			title = "Líder Motoclub",
			gtype = "job"
		},
		"lidermotoclub.permissao",
		"motoclub.permissao",
	},
	["Motoclub"] = {
		_config = {
			title = "Motoclub",
			gtype = "job"
		},
		"motoclub.permissao",
	},
	
	---------------------------------------------------
	-- VERDES
	---------------------------------------------------
	["VerdesL"] = {
		_config = {
			title = "Líder Verdes",
			gtype = "job"
		},
		"liderverdes.permissao",
		"verdes.permissao",
	},
	["Verdes"] = {
		_config = {
			title = "Verdes",
			gtype = "job"
		},
		"verdes.permissao",
	},

	---------------------------------------------------
	-- VERMELHOS
	---------------------------------------------------
	["VermelhosL"] = {
		_config = {
			title = "Líder Vermelhos",
			gtype = "job"
		},
		"lidervermelhos.permissao",
		"vermelhos.permissao",
	},
	["Vermelhos"] = {
		_config = {
			title = "Vermelhos",
			gtype = "job"
		},
		"vermelhos.permissao",
	},

	---------------------------------------------------
	-- ROXOS
	---------------------------------------------------
	["RoxosL"] = {
		_config = {
			title = "Líder Roxos",
			gtype = "job"
		},
		"liderroxos.permissao",
		"roxos.permissao",
	},
	["Roxos"] = {
		_config = {
			title = "Roxos",
			gtype = "job"
		},
		"roxos.permissao",
	},

	---------------------------------------------------
	-- COSANOSTRA
	---------------------------------------------------
	["CNL"] = {
		_config = {
			title = "Líder CosaNostra",
			gtype = "job"
		},
		"lidercn.permissao",
		"cn.permissao",
	},
	["CN"] = {
		_config = {
			title = "CosaNostra",
			gtype = "job"
		},
		"cn.permissao",
	},

	---------------------------------------------------
	-- BRATVA
	---------------------------------------------------
	["BratvaL"] = {
		_config = {
			title = "Líder Bratva",
			gtype = "job"
		},
		"liderbratva.permissao",
		"bratva.permissao",
	},
	["Bratva"] = {
		_config = {
			title = "Bratva",
			gtype = "job"
		},
		"bratva.permissao",
	},

	---------------------------------------------------
	-- YAKUZA
	---------------------------------------------------
	["YakuzaL"] = {
		_config = {
			title = "Líder Yakuza",
			gtype = "job"
		},
		"lideryakuza.permissao",
		"yakuza.permissao",
	},
	["Yakuza"] = {
		_config = {
			title = "Yakuza",
			gtype = "job"
		},
		"yakuza.permissao",
	},
}

cfg.users = {
	[1] = { "admin" },
}

cfg.selectors = {}

return cfg