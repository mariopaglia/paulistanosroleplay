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
	---------------------------------------------------
	--					PMESP
	---------------------------------------------------
	["PMESP1"] = {
		_config = {
			title = "PMESP Recruta",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"pmerj.recruta",
		"salariopmesp.recruta",
		"policiaheli.permissao",
		"tooglepmesp.recruta",
		"polpar.permissao"
	},
	["PaisanaPMESP1"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"tooglesp.recruta"
	},
	---------------------------------------------------
	["PMESP2"] = {
		_config = {
			title = "PMESP Soldado",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"pmerj.soldado",
		"salariopmesp.soldado",
		"policiaheli.permissao",
		"tooglepmesp.soldado",
		"polpar.permissao"
	},
	["PaisanaPMESP2"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"tooglesp.soldado"
	},
	---------------------------------------------------
	["PMESP3"] = {
		_config = {
			title = "PMESP Cabo",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"pmerj.cabo",
		"salariopmesp.cabo",
		"policiaheli.permissao",
		"tooglepmesp.cabo",
		"polpar.permissao"
	},
	["PaisanaPMESP3"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"tooglesp.cabo"
	},
	---------------------------------------------------
	["PMESP4"] = {
		_config = {
			title = "PMESP Sargento",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"pmerj.sargento",
		"salariopmesp.sargento",
		"policiaheli.permissao",
		"tooglepmesp.sargento",
		"polpar.permissao"
	},
	["PaisanaPMESP4"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"tooglesp.sargento"
	},
	---------------------------------------------------
	["PMESP5"] = {
		_config = {
			title = "PMESP Tenente",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"pmerj.subtenente",
		"salariopmesp.subtenente",
		"policiaheli.permissao",
		"tooglepmesp.tenente",
		"polpar.permissao"
	},
	["PaisanaPMESP5"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"tooglesp.tenente"
	},
	---------------------------------------------------
	["PMESP6"] = {
		_config = {
			title = "PMESP Coronel",
			gtype = "job"
		},
		"policia.permissao",
		"pmesp.permissao",
		"salariopmesp.coronel",
		"policiaheli.permissao",
		"tooglepmesp.coronel",
		"polpar.permissao"
	},
	["PaisanaPMESP6"] = {
		_config = {
			title = "PMESP Paisana",
			gtype = "job"
		},
		"tooglesp.coronel"
	},
	---------------------------------------------------
	--					ROTA
	---------------------------------------------------
	["ROTA1"] = {
		_config = {
			title = "ROTA Soldado",
			gtype = "job"
		},
		"policia.permissao",
		"rota.permissao",
		"salariopmesp.coronel",
		"policiaheli.permissao",
		"tooglerota.soldado",
		"polpar.permissao"
	},
	["PaisanaROTA1"] = {
		_config = {
			title = "ROTA Paisana",
			gtype = "job"
		},
		"tooglert.soldado"
	},
	["ROTA2"] = {
		_config = {
			title = "ROTA Cabo",
			gtype = "job"
		},
		"policia.permissao",
		"rota.permissao",
		"salariopmesp.coronel",
		"policiaheli.permissao",
		"tooglerota.cabo",
		"polpar.permissao"
	},
	["PaisanaROTA2"] = {
		_config = {
			title = "ROTA Paisana",
			gtype = "job"
		},
		"tooglert.cabo"
	},
	["ROTA3"] = {
		_config = {
			title = "ROTA Sargento",
			gtype = "job"
		},
		"policia.permissao",
		"rota.permissao",
		"salariopmesp.coronel",
		"policiaheli.permissao",
		"tooglerota.sargento",
		"polpar.permissao"
	},
	["PaisanaROTA3"] = {
		_config = {
			title = "ROTA Paisana",
			gtype = "job"
		},
		"tooglert.sargento"
	},
	["ROTA4"] = {
		_config = {
			title = "ROTA Tenente",
			gtype = "job"
		},
		"policia.permissao",
		"rota.permissao",
		"salariopmesp.coronel",
		"policiaheli.permissao",
		"tooglerota.tenente",
		"polpar.permissao"
	},
	["PaisanaROTA4"] = {
		_config = {
			title = "ROTA Paisana",
			gtype = "job"
		},
		"tooglert.tenente"
	},
	["ROTA5"] = {
		_config = {
			title = "ROTA Major",
			gtype = "job"
		},
		"policia.permissao",
		"rota.permissao",
		"salariopmesp.coronel",
		"policiaheli.permissao",
		"tooglerota.major",
		"polpar.permissao"
	},
	["PaisanaROTA5"] = {
		_config = {
			title = "ROTA Paisana",
			gtype = "job"
		},
		"tooglert.major"
	},
	["ROTA6"] = {
		_config = {
			title = "ROTA Coronel",
			gtype = "job"
		},
		"policia.permissao",
		"rota.permissao",
		"salariopmesp.coronel",
		"policiaheli.permissao",
		"tooglerota.coronel",
		"polpar.permissao"
	},
	["PaisanaROTA6"] = {
		_config = {
			title = "ROTA Paisana",
			gtype = "job"
		},
		"tooglert.coronel"
	},
	---------------------------------------------------
	--					Policia Civil
	---------------------------------------------------
	["PC1"] = {
		_config = {
			title = "Policia Civil Agente",
			gtype = "job"
		},
		"policia.permissao",
		"pcivil.permissao",
		"pcivil.investigador",
		"salariopcivil.investigador",
		"tooglepcesp.agente",
		"polpar.permissao"
	},
	["PaisanaPC1"] = {
		_config = {
			title = "Policia Civil Paisana",
			gtype = "job"
		},
		"tooglepc.agente"
	},
	---------------------------------------------------
	["PC2"] = {
		_config = {
			title = "Policia Civil Investigador",
			gtype = "job"
		},
		"policia.permissao",
		"pcivil.permissao",
		"pcivil.investigador",
		"salariopcivil.investigador",
		"tooglepcesp.investigador",
		"polpar.permissao"
	},
	["PaisanaPC2"] = {
		_config = {
			title = "Policia Civil Paisana",
			gtype = "job"
		},
		"tooglepc.investigador"
	},
	---------------------------------------------------
	["PC3"] = {
		_config = {
			title = "Policia Civil Perito Criminal",
			gtype = "job"
		},
		"policia.permissao",
		"pcivil.permissao",
		"pcivil.investigador",
		"salariopcivil.investigador",
		"tooglepcesp.pc",
		"polpar.permissao"
	},
	["PaisanaPC3"] = {
		_config = {
			title = "Policia Civil Paisana",
			gtype = "job"
		},
		"tooglepc.pc"
	},
	---------------------------------------------------
	["PC4"] = {
		_config = {
			title = "Policia Civil Escrivao",
			gtype = "job"
		},
		"policia.permissao",
		"pcivil.permissao",
		"pcivil.investigador",
		"salariopcivil.investigador",
		"tooglepcesp.escrivao",
		"polpar.permissao"
	},
	["PaisanaPC4"] = {
		_config = {
			title = "Policia Civil Paisana",
			gtype = "job"
		},
		"tooglepc.escrivao"
	},
	---------------------------------------------------
	["PC5"] = {
		_config = {
			title = "Policia Civil Delegado",
			gtype = "job"
		},
		"policia.permissao",
		"pcivil.permissao",
		"pcivil.investigador",
		"salariopcivil.investigador",
		"tooglepcesp.delegado",
		"polpar.permissao"
	},
	["PaisanaPC5"] = {
		_config = {
			title = "Policia Civil Paisana",
			gtype = "job"
		},
		"tooglepc.delegado"
	},
	---------------------------------------------------
	--					PRF
	---------------------------------------------------
	["PRF1"] = {
		_config = {
			title = "PRF Classe C",
			gtype = "job"
		},
		"policia.permissao",
		"prf.permissao",
		"prf.terceira",
		"salarioprf.terceira",
		"policiaheli.permissao",
		"toogleprfederal.classec",
		"polpar.permissao"
	},
	["PaisanaPRF1"] = {
		_config = {
			title = "PRF Paisana",
			gtype = "job"
		},
		"toogleprf.classec"
	},
	---------------------------------------------------
	["PRF2"] = {
		_config = {
			title = "PRF Classe B",
			gtype = "job"
		},
		"policia.permissao",
		"prf.permissao",
		"prf.terceira",
		"salarioprf.terceira",
		"policiaheli.permissao",
		"toogleprfederal.classeb",
		"polpar.permissao"
	},
	["PaisanaPRF2"] = {
		_config = {
			title = "PRF Paisana",
			gtype = "job"
		},
		"toogleprf.classeb"
	},
	---------------------------------------------------
	["PRF3"] = {
		_config = {
			title = "PRF Classe A",
			gtype = "job"
		},
		"policia.permissao",
		"prf.permissao",
		"prf.terceira",
		"salarioprf.terceira",
		"policiaheli.permissao",
		"toogleprfederal.classea",
		"polpar.permissao"
	},
	["PaisanaPRF3"] = {
		_config = {
			title = "PRF Paisana",
			gtype = "job"
		},
		"toogleprf.classea"
	},
	---------------------------------------------------
	["PRF4"] = {
		_config = {
			title = "PRF Classe Especial",
			gtype = "job"
		},
		"policia.permissao",
		"prf.permissao",
		"prf.terceira",
		"salarioprf.terceira",
		"policiaheli.permissao",
		"toogleprfederal.classee",
		"polpar.permissao"
	},
	["PaisanaPRF4"] = {
		_config = {
			title = "PRF Paisana",
			gtype = "job"
		},
		"toogleprf.classee"
	},
	---------------------------------------------------
	["Enfermeiro"] = {
		_config = {
		},
		"paramedico.permissao",
		"portahospital.permissao",
		"reviver.permissao",
		"enfermeiro.permissao",
		"roubonpc.permissao",
		"tooglesamu.enfermeiro",
		"polpar.permissao"
	},
	["PaisanaEnfermeiro"] = {
		_config = {
			title = "Enfermeiro SAMU",
			gtype = "job"
		},
			"tooglesm.enfermeiro",
			"portahospital.permissao"
	},
	---------------------------------------------------
	["Paramedico"] = {
		_config = {
		},
		"paramedico.permissao",
		"reviver.permissao",
		"roubonpc.permissao",
		"portahospital.permissao",
		"paramedicosamu.permissao",
		"tooglesamu.paramedico",
		"polpar.permissao"
	},
	["PaisanaParamedico"] = {
		_config = {
			title = "Paramédico SAMU",
			gtype = "job"
		},
		"tooglesm.paramedico",
		"portahospital.permissao"
	},
	---------------------------------------------------
	["Diretor"] = {
		_config = {
		},
		"paramedico.permissao",
		"roubonpc.permissao",
		"reviver.permissao",
		"portahospital.permissao",
		"diretorgeral.permissao",
		"tooglesamu.diretor",
		"polpar.permissao"
	},
	["PaisanaDiretor"] = {
		_config = {
			title = "Diretor Geral SAMU",
			gtype = "job"
		},
		"tooglesm.diretor",
		"portahospital.permissao"
	},
	---------------------------------------------------
	---------------------------------------------------
	["LIDERMecanicoPaycheck"] = {
		_config = {
		},
		"mecanico.permissao",
		"lidermecanico.permissao",
		"bennys.permissao",
		"furios.permissao",
		"furios.portas",
		"lidermecanico.permissao",
		"lsc.use"
	},
	["LIDERMecanico"] = {
		_config = {
			title = "Chefe Mecanico",
			gtype = "job"
		},
		"paisanamecanicolider.permissao"
	},
	---------------------------------------------------
	["MecanicoPaycheck"] = {
		_config = {
		},
		"mecanico.permissao",
		"salariomecanico.permissao",
		"bennys.permissao",
		"furios.permissao",
		"furios.portas",
		"roubonpc.permissao",
		"lsc.use"
	},
	["Mecanico"] = {
		_config = {
			title = "Mecanico",
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
	["TaxistaPaycheck"] = {
		_config = {
		},
		"taxista.permissao"
	},
	["Taxista"] = {
		_config = {
			title = "Taxista",
			gtype = "job"
		},
		"paisanataxista.permissao",
		"roubonpc.permissao"
	},
	----------------------------------------------------------------------------------------------
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
	["Platina"] = {
		_config = {
			title = "Platina",
			gtype = "vip"
		},
		"platina.permissao",
		"mochila.permissao",
		"carrosvip.permissao"
	},
	["Mochila"] = { --Grupo adicional para vips quando morrer não perderem a mochila (JÁ TEM NO OURO E PLATINA)
		_config = {
			title = "Mochila"
		},
		"mochila.permissao"
	},
	["VipArmas"] = { --Grupo adicional para vips poderem usar os comandos para acessorio da arma
		_config = {
			title = "VipArmas"
		},
		"armas.permissao"
	},
	----------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------
	["LIDERMotoclub"] = {
		_config = {
			title = "Líder Motoclub",
			gtype = "job"
		},
		"motoclub.permissao",
		"lidermc.permissao",
		"roubonpc.permissao",
		"entrada.permissao"
	},
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
	["Vanilla"] = {
		_config = {
			title = "Vanilla",
			gtype = "job"
		},
		"lavar.dinheiro",
		"vanilla.permissao",
		"roubonpc.permissao",
		"entrada.permissao"
	},
}

cfg.users = {
	[1] = { "admin" },
}

cfg.selectors = {}

return cfg