local cfg = {}

cfg.groups = {
	["founder"] = {
		_config = {
			title = "Founder",
			gtype = "staff"
		},
		"founder.permissao",
		"staff.permissao",
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
		"verificado.instagram",
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
		_config = {
			title = "Administrador",
			gtype = "staff"
		},
		"admin.permissao",
		"staff.permissao",
		"fix.permissao",
		"item.permissao",
		"group.permissao",
		"dv.permissao",
		"god.permissao",
		"verificado.instagram",
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
		_config = {
			title = "Moderador",
			gtype = "staff"
		},
		"mod.permissao",
		"staff.permissao",
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
		_config = {
			title = "Suporte",
			gtype = "staff"
		},
		"sup.permissao",
		"staff.permissao",
		"wl.permissao",
		"kick.permissao",
		"ban.permissao",
		"dv.permissao",
		"noclip.permissao",
		"tp.permissao",
		"polpar.permissao",
		"player.spec", -- Comando /spec
		"player.wall", -- Comando /wall
		"player.blips",
		"player.noclip",
		"player.teleport",
		"player.secret",
	},

	["foundertoogle"] = {
		_config = {
			title = "Founder Toogle",
			gtype = "staff"
		},
		"founder.toogle",
		"staff.permissao",
	},
	["admintoogle"] = {
		_config = {
			title = "Administrador Toogle",
			gtype = "staff"
		},
		"admin.toogle",
		"staff.permissao",
	},
	["modtoogle"] = {
		_config = {
			title = "Moderador Toogle",
			gtype = "staff"
		},
		"mod.toogle",
		"staff.permissao",
	},
	["suptoogle"] = {
		_config = {
			title = "Suporte Toogle",
			gtype = "staff"
		},
		"sup.toogle",
		"staff.permissao",
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
		"vip.permissao",
		"player.som"
	},
	["Prata"] = {
		_config = {
			title = "Prata",
			gtype = "vip2"
		},
		"prata.permissao",
		"carrosvip.permissao",
		"vip.permissao",
	},
	["Ouro"] = {
		_config = {
			title = "Ouro",
			gtype = "vip3"
		},
		"ouro.permissao",
		"mochila.permissao",
		"carrosvip.permissao",
		"vip.permissao",
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
		"silenciador.permissao",
		"vip.permissao",
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
		"silenciador.permissao",
		"vip.permissao",
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
		"silenciador.permissao",
		"vip.permissao",
		"player.som"
	},
	["Boost"] = {
		_config = {
			title = "Nitro Boost 1",
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
	["Apoiador"] = {
		_config = {
			title = "Apoiador",
			gtype = "apoiador"
		},
		"apoiador.permissao",
		"verificado.instagram"
	},
	["Verificado"] = {
		_config = {
			title = "Verificado",
			gtype = "verificado"
		},
		"verificado.instagram"
	},

	---------------------------------------------------
	-- DIC - POLICIA INVESTIGATIVA
	---------------------------------------------------
	["DICI"] = {
		_config = {
			title = "DIC I",
			gtype = "job"
		},
		"policia.permissao",
		"dic.permissao",
		"dici.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["DICIP"] = {
		_config = {
			title = "DIC Paisana",
			gtype = "job"
		},
		"dicip.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	["DICII"] = {
		_config = {
			title = "DIC II",
			gtype = "job"
		},
		"policia.permissao",
		"dic.permissao",
		"dicii.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["DICIIP"] = {
		_config = {
			title = "DIC Paisana",
			gtype = "job"
		},
		"diciip.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	["DICIII"] = {
		_config = {
			title = "DIC III",
			gtype = "job"
		},
		"policia.permissao",
		"dic.permissao",
		"diciii.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["DICIIIP"] = {
		_config = {
			title = "DIC Paisana",
			gtype = "job"
		},
		"diciiip.permissao",
		"player.blips",
		"nogarmas.permissao"
	},
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	["DICIV"] = {
		_config = {
			title = "DIC Diretor",
			gtype = "job"
		},
		"policia.permissao",
		"dic.permissao",
		"diciv.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["DICIVP"] = {
		_config = {
			title = "DIC Paisana",
			gtype = "job"
		},
		"dicivp.permissao",
		"player.blips",
		"nogarmas.permissao"
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
	-- SPORTRACE \\ FENIX CUSTOMS
	---------------------------------------------------
	["SportRaceL"] = {
		_config = {
			title = "Líder Fenix Customs",
			gtype = "job"
		},
		"mecanico.permissao",
		"sportracel.permissao",
		"player.blips",
	},
	["SportRaceLP"] = {
		_config = {
			title = "Paisana Mecanico",
			gtype = "job"
		},
		"player.blips",
		"sportracelp.permissao",
	},
	["SportRace"] = {
		_config = {
			title = "Mecânico(a) Fenix Customs",
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
	-- PVP
	---------------------------------------------------
	["PVP"] = {
		_config = {
			title = "Líder PvP",
			gtype = "job"
		},
		"pvp.permissao",
		"noclip.permissao",
		"tp.permissao",
		"god.permissao",
		"polpar.permissao",
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
	["VanillaL"] = {
		_config = {
			title = "Líder Vanilla",
			gtype = "promoter"
		},
		"vanilla.permissao",
		"lojinha.permissao",
	},
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
	-- Bean Machine
	---------------------------------------------------
	["Beanmachine"] = {
		_config = {
			title = "Bean Machine",
			gtype = "promoter"
		},
		"beanmachine.permissao",
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
	-- MIDNIGHT
	---------------------------------------------------
	["MidnightL"] = {
		_config = {
			title = "Líder MidNight",
			gtype = "job"
		},
		"lidermidnight.permissao",
		"midnight.permissao",
	},
	["Midnight"] = {
		_config = {
			title = "Midnight",
			gtype = "job"
		},
		"midnight.permissao",
	},

	---------------------------------------------------
	-- DRIFTKING
	---------------------------------------------------
	["DriftkingL"] = {
		_config = {
			title = "Líder DriftKing",
			gtype = "job"
		},
		"liderdriftking.permissao",
		"driftking.permissao",
	},
	["Driftking"] = {
		_config = {
			title = "DriftKing",
			gtype = "job"
		},
		"driftking.permissao",
	},

	["Desmanche"] = {
		_config = {
			title = "Desmanche",
			gtype = "desmanche"
		},
		"desmanche.permissao",
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
	-- LARANJAS	
	---------------------------------------------------
	["LaranjasL"] = {
		_config = {
			title = "Líder Laranjas",
			gtype = "job"
		},
		"liderlaranjas.permissao",
		"laranjas.permissao",
	},
	["Laranjas"] = {
		_config = {
			title = "Laranjas",
			gtype = "job"
		},
		"laranjas.permissao",
	},

	---------------------------------------------------
	-- SINALOA
	---------------------------------------------------
	["SinaloaL"] = {
		_config = {
			title = "Líder Sinaloa",
			gtype = "job"
		},
		"lidersinaloa.permissao",
		"sinaloa.permissao",
	},
	["Sinaloa"] = {
		_config = {
			title = "Sinaloa",
			gtype = "job"
		},
		"sinaloa.permissao",
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
	-- YAKUZA ||| BRATVA A
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
	-- IRMANDADE
	---------------------------------------------------
	["IrmandadeL"] = {
		_config = {
			title = "Líder Irmandade",
			gtype = "job"
		},
		"liderirmandade.permissao",
		"irmandade.permissao",
	},
	["Irmandade"] = {
		_config = {
			title = "Irmandade",
			gtype = "job"
		},
		"irmandade.permissao",
	},

	---------------------------------------------------
	-- SALIERI'S |||YAKUZA
	---------------------------------------------------
	["SalierisL"] = {
		_config = {
			title = "Líder Salieri's",
			gtype = "job"
		},
		"lidersalieris.permissao",
		"salieris.permissao",
	},
	["Salieris"] = {
		_config = {
			title = "Salieri's",
			gtype = "job"
		},
		"salieris.permissao",
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