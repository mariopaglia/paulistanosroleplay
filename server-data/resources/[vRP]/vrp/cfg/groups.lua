local cfg = {}

cfg.groups = {
	["admin"] = {
		"admin.permissao",
		"fix.permissao",
		"dv.permissao",
		"god.permissao",
		"wl.permissao",
		"kick.permissao",
		"ban.permissao",
		"noclip.permissao",
		"tp.permissao",
		"polpar.permissao",
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
		"fix.permissao",
		"dv.permissao",
		"god.permissao",
		"wl.permissao",
		"kick.permissao",
		"ban.permissao",
		"noclip.permissao",
		"tp.permissao",
		"polpar.permissao",
		"player.blips",
		"player.noclip",
		"player.teleport",
		"player.secret",
		"player.spec", -- Comando /spec
		"player.wall", -- Comando /wall
		"mqcu.permissao", -- Acesso ao menu MQCU
		"anuncio.permissao"
	},
	["helper"] = {
		"helper.permissao",
		"dv.permissao",
		"wl.permissao",
		"kick.permissao",
		"noclip.permissao",
		"polpar.permissao",
		"player.blips",
		"player.noclip",
		"player.teleport",
		"player.secret",
		"player.spec", -- Comando /spec
		"player.wall", -- Comando /wall
		"mqcu.permissao", -- Acesso ao menu MQCU
		"anuncio.permissao"
	},
	["aprovadorwl"] = {
		"wl.permissao"
	},

	----------------------------------------------------------------------------------------------
	--------------------		VIPS							---------------------------
	----------------------------------------------------------------------------------------------
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
	--					ROTA
	---------------------------------------------------
	["RecrutaR"] = {
		_config = {
			title = "ROTA Recruta",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"rota.permissao",
		"recrutar.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["RecrutaRP"] = {
		_config = {
			title = "ROTA Paisana",
			gtype = "job"
		},
		"tooglerecr.permissao",
		"player.blips",
		"nogarmas.permissao"
	},

	["SoldadoR"] = {
		_config = {
			title = "ROTA Soldado",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"rota.permissao",
		"soldador.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["SoldadoRP"] = {
		_config = {
			title = "ROTA Paisana",
			gtype = "job"
		},
		"tooglesolr.permissao",
		"player.blips",
		"nogarmas.permissao"
	},

	["TenenteR"] = {
		_config = {
			title = "ROTA Tenente",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"rota.permissao",
		"tenenter.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["TenenteRP"] = {
		_config = {
			title = "ROTA Paisana",
			gtype = "job"
		},
		"toogletenr.permissao",
		"player.blips",
		"nogarmas.permissao"
	},

	["CapitaoR"] = {
		_config = {
			title = "ROTA Capitao",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"rota.permissao",
		"capitaor.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["CapitaoRP"] = {
		_config = {
			title = "ROTA Paisana",
			gtype = "job"
		},
		"tooglecapr.permissao",
		"player.blips",
		"nogarmas.permissao"
	},

	["CoronelR"] = {
		_config = {
			title = "ROTA Coronel",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"rota.permissao",
		"coronelr.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["CoronelRP"] = {
		_config = {
			title = "ROTA Paisana",
			gtype = "job"
		},
		"tooglecorr.permissao",
		"player.blips",
		"nogarmas.permissao"
	},

	["ComandanteR"] = {
		_config = {
			title = "ROTA Comandante",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"rota.permissao",
		"comandanter.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["ComandanteRP"] = {
		_config = {
			title = "ROTA Paisana",
			gtype = "job"
		},
		"tooglecmdr.permissao",
		"player.blips",
		"nogarmas.permissao"
	},

	---------------------------------------------------
	--					PMESP
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

	["Tenente"] = {
		_config = {
			title = "PMESP Tenente",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"tenente.permissao",
		"player.blips",
		"polpar.permissao"
	},
	["TenenteP"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"toogleten.permissao",
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
	--					Policia Civil
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
	--					PRF
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
	--					SAMU
	---------------------------------------------------
	["Enfermeiro"] = {
		_config = {
			title = "Enfermeiro SAMU",
			gtype = "job"
		},
		"paramedico.permissao",
		"portahospital.permissao",
		"reviver.permissao",
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
			title = "Medico SAMU",
			gtype = "job"
		},
		"paramedico.permissao",
		"portahospital.permissao",
		"reviver.permissao",
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

	["Diretor"] = {
		_config = {
			title = "Diretor SAMU",
			gtype = "job"
		},
		"paramedico.permissao",
		"portahospital.permissao",
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
		"tooglemed.permissao"
	},

	---------------------------------------------------
	--------           MECANICA                   ----------
	---------------------------------------------------
	["LIDERMecanico"] = {
		_config = {
			title = "Lider Mecânico",
			gtype = "job"
		},
		"mecanico.permissao",
		"player.blips",
		"lidermecanico.permissao"
	},
	["PaisanaLiderMecanico"] = {
		_config = {
			title = "Mecanico Paisana",
			gtype = "job"
		},
		"player.blips",
		"paisanamecanicolider.permissao"
	},

	---------------------------------------------------
	["Mecanico"] = {
		_config = {
			title = "Mecânico(a)",
			gtype = "job"
		},
		"mecanico.permissao",
		"funcmecanico.permissao",
		"player.blips",
		"salariomecanico.permissao",
	},
	["PaisanaMecanico"] = {
		_config = {
			title = "Paisana Mecanico",
			gtype = "job"
		},
		"player.blips",
		"paisanamecanico.permissao"
	},
	---------------------------------------------------
	---------------------------------------------------
	["Civil"] = {
		_config = {
			title = "Civil",
			gtype = "job"
		},
		"civil.permissao"
	},
	---------------------------------------------------
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
	--					Concessionária
	---------------------------------------------------
	["CONCE"] = {
		_config = {
			title = "Vendedor Concessionária",
			gtype = "job"
		},
		"concessionaria.permissao"
	},
	----------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------
	["Motoclub"] = {
		_config = {
			title = "Motoclub",
			gtype = "job"
		},
		"motoclub.permissao",
	},
	----------------------------------------
	["Verdes"] = {
		_config = {
			title = "Verdes",
			gtype = "job"
		},
		"verdes.permissao",
	},
	----------------------------------------
	["Vermelhos"] = {
		_config = {
			title = "Vermelhos",
			gtype = "job"
		},
		"vermelhos.permissao",
	},
	-------------------------------------------
	["Roxos"] = {
		_config = {
			title = "Roxos",
			gtype = "job"
		},
		"roxos.permissao",
	},
	----------------------------------------
	["CN"] = {
		_config = {
			title = "CosaNostra",
			gtype = "job"
		},
		"cn.permissao",
	},
	---------------------------------------
	["Bratva"] = {
		_config = {
			title = "Bratva",
			gtype = "job"
		},
		"bratva.permissao",
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