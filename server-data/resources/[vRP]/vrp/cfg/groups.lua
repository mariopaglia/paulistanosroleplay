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
		"mochila.permissao"
	},
	["Prata"] = {
		_config = {
			title = "Prata",
			gtype = "vip2"
		},
		"prata.permissao",
		"carrosvip.permissao",
		"corarma.permissao",
		"mochila.permissao"
	},
	["Ouro"] = {
		_config = {
			title = "Ouro",
			gtype = "vip3"
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
			gtype = "vip4"
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
			gtype = "vip5"
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
			gtype = "vip6"
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
			gtype = "boost1"
		},
		"boost.permissao",
		"corarma.permissao"
	},

	---------------------------------------------------
	-- POLÍCIA MILITAR
	---------------------------------------------------
	["PMESPI"] = {
		_config = {
			title = "PMESP I",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"pmespi.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["PMESPIP"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"pmespip.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	["PMESPII"] = {
		_config = {
			title = "PMESP II",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"pmespii.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["PMESPIIP"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"pmespiip.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	["PMESPIII"] = {
		_config = {
			title = "PMESP III",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"pmespiii.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["PMESPIIIP"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"pmespiiip.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	["PMESPIV"] = {
		_config = {
			title = "PMESP Comando",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"pmespiv.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["PMESPIVP"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"pmespivp.permissao",
		"player.blips",
		"nogarmas.permissao"
	},

	---------------------------------------------------
	-- ROTA
	---------------------------------------------------
	["ROTAI"] = {
		_config = {
			title = "ROTA I",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"rota.permissao",
		"rotai.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["ROTAIP"] = {
		_config = {
			title = "ROTA Paisana",
			gtype = "job"
		},
		"rotaip.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	["ROTAII"] = {
		_config = {
			title = "ROTA II",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"rota.permissao",
		"rotaii.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["ROTAIIP"] = {
		_config = {
			title = "ROTA Paisana",
			gtype = "job"
		},
		"rotaiip.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	["ROTAIII"] = {
		_config = {
			title = "ROTA III",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"rota.permissao",
		"rotaiii.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["ROTAIIIP"] = {
		_config = {
			title = "ROTA Paisana",
			gtype = "job"
		},
		"rotaiiip.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	["ROTAIV"] = {
		_config = {
			title = "ROTA Comando",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"rota.permissao",
		"rotaiv.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["ROTAIVP"] = {
		_config = {
			title = "ROTA Paisana",
			gtype = "job"
		},
		"rotaivp.permissao",
		"player.blips",
		"nogarmas.permissao"
	},

	---------------------------------------------------
	-- POLÍCIA CÍVIL
	---------------------------------------------------
	["PCIVILI"] = {
		_config = {
			title = "Policia Civil I",
			gtype = "job"
		},
		"policia.permissao",
		"pcivil.permissao",
		"pcivili.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["PCIVILIP"] = {
		_config = {
			title = "Policia Civil Paisana",
			gtype = "job"
		},
		"pcivilip.permissao",
		"player.blips",
		"nogarmas.permissao"
	},

	["PCIVILII"] = {
		_config = {
			title = "Policia Civil II",
			gtype = "job"
		},
		"policia.permissao",
		"pcivil.permissao",
		"pcivilii.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["PCIVILIIP"] = {
		_config = {
			title = "Policia Civil Paisana",
			gtype = "job"
		},
		"pciviliip.permissao",
		"player.blips",
		"nogarmas.permissao"
	},

	["PCIVILIII"] = {
		_config = {
			title = "Policia Civil III",
			gtype = "job"
		},
		"policia.permissao",
		"pcivil.permissao",
		"pciviliii.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["PCIVILIIIP"] = {
		_config = {
			title = "Policia Civil Paisana",
			gtype = "job"
		},
		"pciviliiip.permissao",
		"player.blips",
		"nogarmas.permissao"
	},

	["PCIVILIV"] = {
		_config = {
			title = "Policia Civil IV",
			gtype = "job"
		},
		"policia.permissao",
		"pcivil.permissao",
		"pciviliv.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["PCIVILIVP"] = {
		_config = {
			title = "Policia Civil Paisana",
			gtype = "job"
		},
		"pcivilivp.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	
	---------------------------------------------------
	-- POLÍCIA RODOVIÁRIA FEDERAL
	---------------------------------------------------
	["PRFI"] = {
		_config = {
			title = "PRF I",
			gtype = "job"
		},
		"policia.permissao",
		"prf.permissao",
		"pmesp.permissao",
		"prfi.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["PRFIP"] = {
		_config = {
			title = "PRF Paisana",
			gtype = "job"
		},
		"prfip.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	["PRFII"] = {
		_config = {
			title = "PRF II",
			gtype = "job"
		},
		"policia.permissao",
		"prf.permissao",
		"pmesp.permissao",
		"prfii.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["PRFIIP"] = {
		_config = {
			title = "PRF Paisana",
			gtype = "job"
		},
		"prfiip.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	["PRFIII"] = {
		_config = {
			title = "PRF III",
			gtype = "job"
		},
		"policia.permissao",
		"prf.permissao",
		"pmesp.permissao",
		"prfiiii.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["PRFIIIP"] = {
		_config = {
			title = "PRF Paisana",
			gtype = "job"
		},
		"prfiiip.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
	["PRFIV"] = {
		_config = {
			title = "PRF Comando",
			gtype = "job"
		},
		"policia.permissao",
		"prf.permissao",
		"pmesp.permissao",
		"prfiv.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["PRFIVP"] = {
		_config = {
			title = "PRF Paisana",
			gtype = "job"
		},
		"prfivp.permissao",
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