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
		"unban.permissao",
		"money.permissao",
		"noclip.permissao",
		"ticket.permissao",
		"tp.permissao",
		"spawncar.permissao",
		"msg.permissao"
	},
	["mod"] = {
		"admin.permissao",
		"fix.permissao",
		"dv.permissao",
		"god.permissao",
		"ticket.permissao",
		"wl.permissao",
		"kick.permissao",
		"ban.permissao",
		"unban.permissao",
		"noclip.permissao",
		"tp.permissao",
		"spawncar.permissao",
		"msg.permissao"
	},
	["sup"] = {
		"admin.permissao",
		"ticket.permissao",
		"fix.permissao",
		"dv.permissao",
		"wl.permissao",
		"kick.permissao"
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
		"carrosvip.permissao"
	},
	["Prata"] = {
		_config = {
			title = "Prata",
			gtype = "vip"
		},
		"prata.permissao",
		"carrosvip.permissao"
	},
	["Ouro"] = {
		_config = {
			title = "Ouro",
			gtype = "vip"
		},
		"ouro.permissao",
		"mochila.permissao",
		"carrosvip.permissao"
	},
	["Diamante"] = {
		_config = {
			title = "Platina",
			gtype = "vip"
		},
		"platina.permissao",
		"mochila.permissao",
		"carrosvip.permissao"
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
		"polpar.permissao"
	},
	["RecrutaRP"] = {
		_config = {
			title = "ROTA Paisana",
			gtype = "job"
		},
		"tooglerecr.permissao"
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
		"polpar.permissao"
	},
	["SoldadoRP"] = {
		_config = {
			title = "ROTA Paisana",
			gtype = "job"
		},
		"tooglesolr.permissao"
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
		"polpar.permissao"
	},
	["TenenteRP"] = {
		_config = {
			title = "ROTA Paisana",
			gtype = "job"
		},
		"toogletenr.permissao"
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
		"polpar.permissao"
	},
	["CapitaoRP"] = {
		_config = {
			title = "ROTA Paisana",
			gtype = "job"
		},
		"tooglecapr.permissao"
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
		"polpar.permissao"
	},
	["CoronelRP"] = {
		_config = {
			title = "ROTA Paisana",
			gtype = "job"
		},
		"tooglecorr.permissao"
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
		"polpar.permissao"
	},
	["ComandanteRP"] = {
		_config = {
			title = "ROTA Paisana",
			gtype = "job"
		},
		"tooglecmdr.permissao"
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
		"polpar.permissao"
	},
	["RecrutaP"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"tooglerec.permissao"
	},

	["Soldado"] = {
		_config = {
			title = "PMESP Soldado",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"soldado.permissao",
		"polpar.permissao"
	},
	["SoldadoP"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"tooglesol.permissao"
	},

	["Tenente"] = {
		_config = {
			title = "PMESP Tenente",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"tenente.permissao",
		"polpar.permissao"
	},
	["TenenteP"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"toogleten.permissao"
	},

	["Capitao"] = {
		_config = {
			title = "PMESP Capitao",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"capitao.permissao",
		"polpar.permissao"
	},
	["CapitaoP"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"tooglecap.permissao"
	},

	["Coronel"] = {
		_config = {
			title = "PMESP Coronel",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"coronel.permissao",
		"polpar.permissao"
	},
	["CoronelP"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"tooglecor.permissao"
	},

	["Comandante"] = {
		_config = {
			title = "PMESP Comandante",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"comandante.permissao",
		"polpar.permissao"
	},
	["ComandanteP"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"tooglecmd.permissao"
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
		"polpar.permissao"
	},
	["AgenteP"] = {
		_config = {
			title = "Policia Civil Paisana",
			gtype = "job"
		},
		"toogleagente.permissao"
	},

	["Inspetor"] = {
		_config = {
			title = "Policia Civil Inspetor",
			gtype = "job"
		},
		"policia.permissao",
		"pcivil.permissao",
		"inspetor.permissao",
		"polpar.permissao"
	},
	["InspetorP"] = {
		_config = {
			title = "Policia Civil Paisana",
			gtype = "job"
		},
		"toogleins.permissao"
	},

	["Investigador"] = {
		_config = {
			title = "Policia Civil Investigador",
			gtype = "job"
		},
		"policia.permissao",
		"pcivil.permissao",
		"investigador.permissao",
		"polpar.permissao"
	},
	["InvestigadorP"] = {
		_config = {
			title = "Policia Civil Paisana",
			gtype = "job"
		},
		"toogleinv.permissao"
	},

	["Delegado"] = {
		_config = {
			title = "Policia Civil Delegado",
			gtype = "job"
		},
		"policia.permissao",
		"pcivil.permissao",
		"delegado.permissao",
		"polpar.permissao"
	},
	["DelegadoP"] = {
		_config = {
			title = "Policia Civil Paisana",
			gtype = "job"
		},
		"toogledel.permissao"
	},

	---------------------------------------------------
	--					EMS
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
		"polpar.permissao"
	},
	["PaisanaEnfermeiro"] = {
		_config = {
			title = "SAMU Paisana",
			gtype = "job"
		},
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
		"polpar.permissao"
	},
	["PaisanaMedico"] = {
		_config = {
			title = "SAMU Paisana",
			gtype = "job"
		},
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
		"polpar.permissao"
	},
	["PaisanaDiretor"] = {
		_config = {
			title = "SAMU Paisana",
			gtype = "job"
		},
		"tooglemed.permissao"
	},

	---------------------------------------------------
	--------           OFM                   ----------
	---------------------------------------------------
	["LIDERMecanico"] = {
		_config = {
			title = "Lider Mecânico",
			gtype = "job"
		},
		"mecanico.permissao",
		"lidermecanico.permissao"
	},
	["PaisanaLiderMecanico"] = {
		_config = {
			title = "Mecanico Paisana",
			gtype = "job"
		},
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
		"salariomecanico.permissao",
		"roubonpc.permissao",
	},
	["PaisanaMecanico"] = {
		_config = {
			title = "Paisana Mecanico",
			gtype = "job"
		},
		"paisanamecanico.permissao"
	},
	---------------------------------------------------
	---------------------------------------------------
	["Advogado"] = {
		_config = {
			title = "Advogado",
			gtype = "job"
		},
		"advogado.permissao"
	},
	["Juiz"] = {
		_config = {
			title = "Juiz",
			gtype = "job"
		},
		"juiz.permissao"
	},

	["Civil"] = {
		_config = {
			title = "Civil",
			gtype = "job"
		},
		"roubonpc.permissao"
	},
	---------------------------------------------------
	---------------------------------------------------
	["Taxista"] = {
		_config = {
			title = "Taxista",
			gtype = "job2"
		},
		"paisanataxista.permissao",
		"roubonpc.permissao",
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
		"roubonpc.permissao",
		"entrada.permissao"
	},
	----------------------------------------
	["PCC"] = {
		_config = {
			title = "P.C.C",
			gtype = "job"
		},
		"pcc.permissao",
		"roubonpc.permissao",
		"entrada.permissao"
	},
	----------------------------------------
	["CV"] = {
		_config = {
			title = "Comando Vermelho",
			gtype = "job"
		},
		"cv.permissao",
		"roubonpc.permissao",
		"entrada.permissao"
	},
	-------------------------------------------
	["TCP"] = {
		_config = {
			title = "T.C.P",
			gtype = "job"
		},
		"roubonpc.permissao",
		"tcp.permissao",
		"entrada.permissao"
	},
	----------------------------------------
	["CN"] = {
		_config = {
			title = "CosaNostra",
			gtype = "job"
		},
		"cn.permissao",
		"roubonpc.permissao",
		"entrada.permissao"
	},
	---------------------------------------
	["Bratva"] = {
		_config = {
			title = "Bratva",
			gtype = "job"
		},
		"bratva.permissao",
		"roubonpc.permissao",
		"entrada.permissao"
	},
	["Yakuza"] = {
		_config = {
			title = "Yakuza",
			gtype = "job"
		},
		"lavar.dinheiro",
		"vanilla.permissao",
		"yakuza.permissao",
		"roubonpc.permissao",
		"entrada.permissao"
	},
}

cfg.users = {
	[1] = { "admin" },
}

cfg.selectors = {}

return cfg