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
		"player.som", -- Acesso ao /som do MQCU
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
		"god.permissao",
		"fix.permissao",
		"wl.permissao",
		"kick.permissao",
		"ban.permissao",
		"noclip.permissao",
		"tp.permissao",
		"polpar.permissao",
		"placa.permissao",
		"player.blips",
		"player.noclip",
		"player.spec", -- Comando /spec
		"player.wall", -- Comando /wall
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
			gtype = "vip1"
		},
		"bronze.permissao",
		"carrosvip.permissao",
		"mochila.permissao",
		"player.som"
	},
	["Prata"] = {
		_config = {
			title = "Prata",
			gtype = "vip2"
		},
		"prata.permissao",
		"carrosvip.permissao",
		"corarma.permissao",
		"mochila.permissao",
		"player.som"
	},
	["Ouro"] = {
		_config = {
			title = "Ouro",
			gtype = "vip3"
		},
		"ouro.permissao",
		"carrosvip.permissao",
		"player.som"
	},
	["Platina"] = {
		_config = {
			title = "Platina",
			gtype = "vip4"
		},
		"platina.permissao",
		"carrosvip.permissao",
		"corarma.permissao",
		"roupavip.permissao",
		"mochila.permissao",
		"player.som"
	},
	["Esmeralda"] = {
		_config = {
			title = "Esmeralda",
			gtype = "vip5"
		},
		"esmeralda.permissao",
		"carrosvip.permissao",
		"corarma.permissao",
		"roupavip.permissao",
		"mochila.permissao",
		"player.som"
	},
	["Diamante"] = {
		_config = {
			title = "Diamante",
			gtype = "vip6"
		},
		"diamante.permissao",
		"carrosvip.permissao",
		"corarma.permissao",
		"roupavip.permissao",
		"mochila.permissao",
		"player.som"
	},
	["Boost"] = {
		_config = {
			title = "Nitro Boost",
			gtype = "boost1"
		},
		"boost.permissao",
		"corarma.permissao"
	},
	["Boost2"] = {
		_config = {
			title = "Nitro Boost 2",
			gtype = "boost1"
		},
		"boostii.permissao",
		"corarma.permissao"
	},
	["JBL"] = {
		_config = {
			title = "JBL",
			gtype = "jbl"
		},
		"player.som"
	},

	---------------------------------------------------
	-- POLÍCIA MILITAR
	---------------------------------------------------
	["PMFCI"] = {
		_config = {
			title = "PMFC I",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"pmfci.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["PMFCIP"] = {
		_config = {
			title = "PMFC Paisana",
			gtype = "job"
		},
		"pmfcip.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	["PMFCII"] = {
		_config = {
			title = "PMFC II",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"pmfcii.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["PMFCIIP"] = {
		_config = {
			title = "PMFC Paisana",
			gtype = "job"
		},
		"pmfciip.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	["PMFCIII"] = {
		_config = {
			title = "PMFC III",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"pmfciii.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["PMFCIIIP"] = {
		_config = {
			title = "PMFC Paisana",
			gtype = "job"
		},
		"pmfciiip.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	["PMFCIV"] = {
		_config = {
			title = "PMFC Comando",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"pmfciv.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["PMFCIVP"] = {
		_config = {
			title = "PMFC Paisana",
			gtype = "job"
		},
		"pmfcivp.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	
	---------------------------------------------------
	-- SAMU
	---------------------------------------------------
	["SAMUI"] = {
		_config = {
			title = "SAMU I",
			gtype = "job"
		},
		"paramedico.permissao",
		"samui.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["SAMUIP"] = {
		_config = {
			title = "SAMU Paisana",
			gtype = "job"
		},
		"player.blips",
		"samuip.permissao"
	},

	["SAMUII"] = {
		_config = {
			title = "SAMU II",
			gtype = "job"
		},
		"paramedico.permissao",
		"samuii.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["SAMUIIP"] = {
		_config = {
			title = "SAMU Paisana",
			gtype = "job"
		},
		"player.blips",
		"samuiip.permissao"
	},

	["SAMUIII"] = {
		_config = {
			title = "SAMU III",
			gtype = "job"
		},
		"paramedico.permissao",
		"samuiii.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["SAMUIIIP"] = {
		_config = {
			title = "SAMU Paisana",
			gtype = "job"
		},
		"player.blips",
		"samuiiip.permissao"
	},
	
	["SAMUIV"] = {
		_config = {
			title = "SAMU Diretor(a)",
			gtype = "job"
		},
		"paramedico.permissao",
		"samuiv.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["SAMUIVP"] = {
		_config = {
			title = "SAMU Paisana",
			gtype = "job"
		},
		"player.blips",
		"samuivp.permissao"
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
	-- PROMOTER
	---------------------------------------------------
	["Promoter"] = {
		_config = {
			title = "Promoter",
			gtype = "promoter"
		},
		"promoter.permissao"
	},

	---------------------------------------------------
	-- VANILLA
	---------------------------------------------------
	["Vanilla"] = {
		_config = {
			title = "Vanilla",
			gtype = "promoter"
		},
		"vanilla.permissao",
		"lojinha.permissao",
	},

	---------------------------------------------------
	-- GALAXY
	---------------------------------------------------
	["Galaxy"] = {
		_config = {
			title = "Galaxy",
			gtype = "promoter"
		},
		"galaxy.permissao",
		"lojinha.permissao",
	},

	---------------------------------------------------
	-- TEQUILA
	---------------------------------------------------
	["Tequila"] = {
		_config = {
			title = "Tequila",
			gtype = "promoter"
		},
		"tequila.permissao",
		"lojinha.permissao",
	},

	---------------------------------------------------
	-- SPLIT
	---------------------------------------------------
	["Split"] = {
		_config = {
			title = "Split",
			gtype = "promoter"
		},
		"split.permissao",
		"lojinha.permissao",
	},

	---------------------------------------------------
	-- BAHAMAS
	---------------------------------------------------
	["Bahamas"] = {
		_config = {
			title = "Bahamas",
			gtype = "promoter"
		},
		"bahamas.permissao",
		"lojinha.permissao",
	},

	---------------------------------------------------
	-- HENHOUSE
	---------------------------------------------------
	["Henhouse"] = {
		_config = {
			title = "Hen House",
			gtype = "promoter"
		},
		"henhouse.permissao",
		"lojinha.permissao",
	},

	---------------------------------------------------
	-- JUIZ
	---------------------------------------------------
	["Juiz"] = {
		_config = {
			title = "Juiz",
			gtype = "job"
		},
		"juiz.permissao",
		"judiciario.permissao",
	},

	---------------------------------------------------
	-- PROMOTOR
	---------------------------------------------------
	["Promotor"] = {
		_config = {
			title = "Promotor",
			gtype = "job"
		},
		"promotor.permissao",
		"judiciario.permissao",
	},

	---------------------------------------------------
	-- ADVOGADO
	---------------------------------------------------
	["Advogado"] = {
		_config = {
			title = "Advogado",
			gtype = "job"
		},
		"advogado.permissao",
		"judiciario.permissao",
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
	
	---------------------------------------------------
	-- CAMORRA
	---------------------------------------------------
	["CamorraL"] = {
		_config = {
			title = "Líder Camorra",
			gtype = "job"
		},
		"lidercamorra.permissao",
		"camorra.permissao",
	},
	["Camorra"] = {
		_config = {
			title = "Camorra",
			gtype = "job"
		},
		"camorra.permissao",
	},
	---------------------------------------------------
	-- TRIADE
	---------------------------------------------------
	["TriadeL"] = {
		_config = {
			title = "Líder Triade",
			gtype = "job"
		},
		"lidertriade.permissao",
		"triade.permissao",
	},
	["Triade"] = {
		_config = {
			title = "Triade",
			gtype = "job"
		},
		"triade.permissao",
	},
	---------------------------------------------------
	-- FARC
	---------------------------------------------------
	["FARCL"] = {
		_config = {
			title = "Líder FARC",
			gtype = "job"
		},
		"liderfarc.permissao",
		"farc.permissao",
	},
	["FARC"] = {
		_config = {
			title = "FARC",
			gtype = "job"
		},
		"farc.permissao",
	},
	---------------------------------------------------
	-- SERPENTES
	---------------------------------------------------
	["SerpentesL"] = {
		_config = {
			title = "Líder Serpentes",
			gtype = "job"
		},
		"liderserpentes.permissao",
		"serpentes.permissao",
	},
	["Serpentes"] = {
		_config = {
			title = "Serpentes",
			gtype = "job"
		},
		"serpentes.permissao",
	},

}

cfg.users = {
	[1] = { "admin" },
}

cfg.selectors = {}

return cfg