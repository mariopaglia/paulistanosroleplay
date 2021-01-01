local cfg = {}  

cfg.groups = {
	["adminy"] = {
		"admin.permissao",
		"verids.permissao",
		"dv.permissao",
		"vip.permissao",
		"policia.permissao",
	},
	["admin"] = {
		"admin.permissao",
		"verids.permissao",
		"dv.permissao",
		"ticket.permissao",
		"vip.permissao",
		"policia.permissao",
	},
	["moderador"] = {
		"moderador.permissao",
		"verids.permissao",
		"dv.permissao",
		"vip.permissao",
		"policia.permissao",
	},
	["suporte"] = {
		"suporte.permissao",
		"verids.permissao",
		"dv.permissao",
		"vip.permissao",
	},
	["conselho"] = {
		"dv.permissao",
		"verids.permissao",
	},
	["Morador"] = {
		"morador.favela",
	},
	["Concessionaria"] = {
		_config = { title = "Concessionaria", gtype = "job"	},
		"addgrupo.permissao",
		"addgrupo.vendedor",
		"dv.permissao",
		"concessionaria.permissao"
	},
	["Vendedor"] = {
		_config = { title = "Vendedor", code = "vendedor"},
		"dv.permissao",
		"concessionaria.permissao"
	},


	["Juiz"] = {
		_config = { title = "Juiz", gtype = "job"	},
		"juiz.permissao"
	},
	["anticrime"] = {
		_config = { title = "anticrime", gtype = "job"	},
		"-crime.permissao"
	},
	["verilegal"] = {
		_config = { title = "verilegal"},
		"verilegal.permissao"
	},
	["ChefeJornal"] = {
		_config = { title = "ChefeJornal"},
		"addgrupo.permissao",
		"addgrupo.jornal",
		"dv.permissao",
		"chefediario.paycheck",
		"diario.permissao"
	},
	["Jornalista"] = {
		_config = { title = "Jornalista", code = "jornal"},
		"jornalistadiario.paycheck",
		"diario.permissao"
	},
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
-- POLICIA
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
["Recruta"] = {
	_config = { title = "Recruta PMESP", gtype = "job", code = "recruta"},
	"ratreio.permissao",
	"polpar.permissao"
},
["RecrutaPaycheck"] = {
	_config = { value="3000"},
	"ratreio.permissao",
	"CadetePaycheck",
	"policia.permissao",
	"notset.permissao",
	"dv.permissao",
	"polpar.permissao"
},
["Soldado"] = {
	_config = { title = "Soldado PMESP", gtype = "job", code = "soldado" },
	"ratreio.permissao",
	"polpar.permissao"
},
["SoldadoPaycheck"] = {
	_config = { value="5000"},
	"PolicialPaycheck",
	"ratreio.permissao",
	"policia.permissao",
	"dv.permissao",
	"notset.permissao",
	"polpar.permissao"
},

["Cabo"] = {
	_config = { title = "Cabo PMESP", gtype = "job", code = "cabo" },
	"ratreio.permissao",
	"polpar.permissao"
},
["CaboPaycheck"] = {
	_config = { value="7000"},
	"PolicialPaycheck",
	"ratreio.permissao",
	"policia.permissao",
	"dv.permissao",
	"notset.permissao",
	"polpar.permissao"
},
["Sargento"] = {
	_config = { title = "Sargento PMESP", gtype = "job", code = "sargento" },
	"ratreio.permissao",
	"polpar.permissao"
},
["SargentoPaycheck"] = {
	_config = { value="10000"},
	"SargentoPaycheck",
	"notset.permissao",
	"policia.permissao",
	"dv.permissao",
	"ratreio.permissao",
	"polpar.permissao"
},
["Tenente"] = {
	_config = { title = "Tenente PMESP", gtype = "job", code = "tenente" },
	"ratreio.permissao",
	"polpar.permissao"
},
["TenentePaycheck"] = {
	_config = { value="15000"},
	"TenentePaycheck",
	"policia.permissao",
	"notset.permissao",
	"dv.permissao",
	"ratreio.permissao",
	"polpar.permissao"
},
["Capitao"] = {
	_config = { title = "Capitao PMESP", gtype = "job", code = "capitao" },
	"ratreio.permissao",
	"polpar.permissao"
},
["CapitaoPaycheck"] = {
	_config = { value="17000"},
	"CapitaoPaycheck",
	"policia.permissao",
	"dv.permissao",
	"ratreio.permissao",
	"notset.permissao",
	"polpar.permissao"
},
["Major"] = {
	_config = { title = "Major PMESP", gtype = "job", code = "major" },
	"ratreio.permissao",
	"polpar.permissao"
},
["MajorPaycheck"] = {
	_config = { value="19000"},
	"InspetorPaycheck",
	"policia.permissao",
	"ratreio.permissao",
	"dv.permissao",
	"notset.permissao",
	"polpar.permissao"
},
["Ten.Coronel"] = {
	_config = { title = "Ten.Coronel PMESP", gtype = "job", code = "ten.coronel" },
	"ratreio.permissao",
	"polpar.permissao"
},
["Ten.CoronelPaycheck"] = {
	_config = { value="21000"},
	"Ten.CoronelPaycheck",
	"ratreio.permissao",
	"dv.permissao",
	"policia.permissao",
	"notset.permissao",
	"polpar.permissao"
},
["Coronel"] = {
	_config = { title = "Coronel PMESP", gtype = "job" },
	"dv.permissao",
	"addgrupo.permissao",
	"addgrupo.ten.coronel",
	"addgrupo.major",
	"addgrupo.capitao",
	"addgrupo.tenente",
	"addgrupo.sargento",
	"addgrupo.cabo",
	"addgrupo.soldado",
	"addgrupo.recruta",
	"baufull.permissao",
	"ratreio.permissao",
	"polpar.permissao"
},
["CoronelPaycheck"] = {
	_config = { value="24000"},
	"CoronelPaycheck",
	"policia.permissao",
	"ratreio.permissao",
	"notset.permissao",
	"polpar.permissao"
},
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
-- POLICIA CIVIL
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
["Agente"] = {
	_config = { title = "Agente PCESP", gtype = "job", code = "agente.pc" },
	"ratreio.permissao",
	"polpar.permissao"
},

["AgentePaycheck"] = {
	_config = { value="5000"},
	"Ten.CoronelPaycheck",
	"ratreio.permissao",
	"dv.permissao",
	"policia.permissao",
	"notset.permissao",
	"polpar.permissao"
},

["Escrivao"] = {
	_config = { title = "Escrivão PCESP", gtype = "job", code = "escrivao.pc" },
	"ratreio.permissao",
	"polpar.permissao"
},

["EscrivaoPaycheck"] = {
	_config = { value="8000"},
	"Ten.CoronelPaycheck",
	"ratreio.permissao",
	"dv.permissao",
	"policia.permissao",
	"notset.permissao",
	"polpar.permissao"
},
["Investigador"] = {
	_config = { title = "Investigador PCESP", gtype = "job", code = "investigador.pc" },
	"ratreio.permissao",
	"polpar.permissao"
},

["InvestigadorPaycheck"] = {
	_config = { value="7000"},
	"Ten.CoronelPaycheck",
	"ratreio.permissao",
	"dv.permissao",
	"policia.permissao",
	"notset.permissao",
	"polpar.permissao"
},
["Delegado"] = {
	_config = { title = "Delegado PCESP", gtype = "job"},
	"addgrupo.permissao",
	"addgrupo.agente.pc",
	"addgrupo.investigador.pc",
	"addgrupo.escrivao.pc",
	"ratreio.permissao",
	"polpar.permissao"
},

["DelegadoPaycheck"] = {
	_config = { value="10000"},
	"ratreio.permissao",
	"dv.permissao",
	"policia.permissao",
	"notset.permissao",
	"polpar.permissao"
},

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
-- SAMU
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
["Paramedico"] = {
	_config = { title = "Paramedico", gtype = "job", code = "paramedico"},
	"polpar.permissao"
},
["ParamedicoPaycheck"] = {
	_config = { value = "9000"},
	"ParamedicoPaycheck",
	"dv.permissao",
	"notset.permissao",
	"paramedico.permissao",
},

["Medico"] = {
	_config = { title = "Médico", gtype = "job", code = "medico"},
	"polpar.permissao"
},
["MedicoPaycheck"] = {
	_config = { value = "11000"},
	"MedicoPaycheck",
	"dv.permissao",
	"notset.permissao",
	"paramedico.permissao"
},

["Diretor"] = {
	_config = { title = "Diretor", gtype = "job"},
	"addgrupo.permissao",
	"addgrupo.medico",
	"addgrupo.enfermeiro",
	"polpar.permissao"
},

["DiretorPaycheck"] = {
	_config = { value = "15000"},
	"DiretorPaycheck",
	"dv.permissao",
	"notset.permissao",
	"paramedico.permissao",
},

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
-- Gangues
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
["LiderCV"] = {
	_config = { title = "Lider C.V", gtype = "job"},
	"addgrupo.permissao",
	"addgrupo.cv",
	"baufull.permissao",
	"anticrime.permissao",
	"cv.permissao"

},

["CV"] = {
	_config = { title = "C.V", gtype = "job", code = "cv"},
	"cv.permissao",
	"anticrime.permissao",
	"drogas.permissao",
},

["LiderPCC"] = {
	_config = { title = "Lider P.C.C", gtype = "job"},
	"addgrupo.permissao",
	"addgrupo.pcc",
	"baufull.permissao",
	"anticrime.permissao",
	"pcc.permissao"

},

["PCC"] = {
	_config = { title = "P.C.C", gtype = "job", code = "pcc"},
	"pcc.permissao",
	"anticrime.permissao",
	"drogas.permissao",
},

["LiderADA"] = {
	_config = { title = "Lider A.D.A", gtype = "job"},
	"addgrupo.permissao",
	"addgrupo.ada",
	"baufull.permissao",
	"anticrime.permissao",
	"ada.permissao"

},

["ADA"] = {
	_config = { title = "A.D.A", gtype = "job", code = "ada"},
	"ada.permissao",	"drogas.permissao",	"anticrime.permissao"
},

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
-- Vips
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
["vipPrata"] = {
	_config = {gtype="vip", title = "Prata",valueVIP="4000"},
	"prata.permissao","mochila.permissao"
},
["vipOuro"] = {
	_config = {gtype = "vip",	title = "Ouro",valueVIP="5000"},
	"ouro.permissao","mochila.permissao"
},
["vipPlatina"] = {
	_config = {gtype="vip", title = "Platina", valueVIP="7000" },
	"platina.permissao","mochila.permissao"
},
["vipNitro"] = {
	_config = { gtype= "nitro", title = "Nitro Boosting" },
	"nitro.permissao","mochila.permissao"
},

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
-- TAXISTA
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	["Taxista"] = {
		_config = {	title = "Taxista", gtype = "job" },
		"paisanataxista.permissao"		
	},
	["TaxistaPaycheck"] = {
		_config = {	title = "PaisanaTaxista"},
		"taxista.permissao"
	},
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
-- Mecânico
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
["Bennys"] = {
	_config = {title = "Bennys", code = "bennys"},
	"bennys.permissao",
},
["LiderMecanicoPaycheck"] = {
	_config = {value="7000"},
	"mecanico.permissao"
},
["LiderMecanico"] = {
	_config = {title = "Lider Mecanico", gtype = "job"},
	"addgrupo.permissao",
	"addgrupo.mec",
	"addgrupo.bennys",
},
["Mecanico"] = {
	_config = {title = "Mecanico",	gtype = "job", code = "mec"},
	"paisanamecanico.permissao"
	
},
["MecanicoPaycheck"] = {
	_config = {	value="5000" },
	"mecanico.permissao"
},

["LiderMC"] = {
	_config = {gtype="job",title="Lider MC"},
	"addgrupo.permissao",
	"addgrupo.mc",
	"baufull.permissao",
	"mc.permissao"
},
["MC"] = {
	_config = { code = "mc", title="MotoClube",gtype="job"},
	"mc.permissao"
},

["LiderMafia"] = {
	_config = {gtype="job",title="Lider Mafia"},
	"addgrupo.permissao",
	"addgrupo.mafia",
	"baufull.permissao",
	"mafia.permissao"
},
["Mafia"] = {
	_config = { code = "mafia", title="Máfia",gtype="job"},
	"mafia.permissao"
},
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
-- 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
	["Alertas"] = {
		_config = { title = "Alertas" },
		"alertas.permissao"
	},
}

cfg.users = {
	[1] = { "admin" }
}

cfg.selectors = {}

return cfg