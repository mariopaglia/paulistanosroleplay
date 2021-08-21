local cfg = {}

cfg.items = {
	-- Gerais
	["sacodelixo"] = { "Saco de Lixo",0.5 },
	["garrafavazia"] = { "Garrafa Vazia",0.2 },
	["garrafadeleite"] = { "Garrafa de Leite",0.5 },
	["alianca"] = { "Aliança",0.5 },
	["bandagem"] = { "Bandagem",0.7 },
	["roupas"] = { "Roupas",8.0 },
	["dinheirosujo"] = { "Dinheiro Sujo",0.0 },
	["repairkit"] = { "Kit de Reparos",10.0 },
	["algemas"] = { "Algemas",1.0 },
	["celular"] = { "Celular",0.5 },
	["capuz"] = { "Capuz",0.5 },
	["lockpick"] = { "Lockpick",10 },
	["masterpick"] = { "Masterpick",10 },
	["militec"] = { "Militec",5.0 },
	["c4"] = { "C4",5.0 },
	["energetico"] = { "Energético",0.3 },
	["mochila"] = { "Mochila",1 },
	["carbono"] = { "Carbono",0.0038 },
	["radio"] = { "Radio",1.0 },
	["placa"] = { "Placa",5.0 },
	["pneu"] = { "Pneu",5.0 },
	["cartaoinvasao"] = { "Cartão de Invasão",0.5 },
	["gps"] = { "GPS",0.5 },
	["rosa"] = { "rosa",0.5 },
	["morango"] = { "morango",0.5 },
	["tequila"] = { "tequila",0.2 },
	["vodka"] = { "vodka",0.2 },
	["cerveja"] = { "cerveja",0.2 },
	["whisky"] = { "whisky",0.2 },
	["conhaque"] = { "conhaque",0.2 },
	["absinto"] = { "absinto",0.2 },
	["agua"] = { "agua",0.2 },
	["corda"] = { "corda",1.0 },
	["adrenalina"] = { "adrenalina",1.0 },
	["gopro"] = { "gopro",1.0 },
	["gravadordevoz"] = { "gravadordevoz",1.0 },
	["ticketpvp"] = { "ticketpvp",0.5 },

	-- Farm Contrabando
	["componentemetal"] = { "Componentes de Metais",0.5 },
	["componenteeletronico"] = { "Componentes Eletrônicos",0.5 },
	["componenteplastico"] = { "Componentes de Plásticos",0.5 },

	--Itens do roubo a residencia
	["sapatosroubado"] = { "sapatosroubado",0.2 },
	["relogioroubado"] = { "relogioroubado",0.2 },
	["anelroubado"] = { "anelroubado",0.2 },
	["colarroubado"] = { "colarroubado",0.2 },
	["notebookroubado"] = { "notebookroubado",0.2 },
	["tabletroubado"] = { "tabletroubado",0.2 },
	["vibradorroubado"] = { "vibradorroubado",0.2 },
	["carteiraroubada"] = { "carteiraroubada",0.2 },
	["perfumeroubado"] = { "perfumeroubado",0.2 },
	
	-- Pesca
	["isca"] = { "Isca",0.6 },
	["dourado"] = { "Dourado",0.6 },
	["corvina"] = { "Corvina",0.6 },
	["salmao"] = { "Salmão",0.6 },
	["pacu"] = { "Pacu",0.6 },
	["pintado"] = { "Pintado",0.6 },
	["pirarucu"] = { "Pirarucu",0.6 },
	["tilapia"] = { "Tilápia",0.6 },
	["tucunare"] = { "Tucunaré",0.6 },
	["lambari"] = { "Lambari",0.6 },
	
	-- Farm de Lavagem
	["pendrivedeep"] = { "Pendrive Deepweb",0.5 },
	["placacircuito"] = { "Placa de Circuito",0.3 },
	["chipset"] = { "Chipset",0.3 },
	
	-- Farm de Armas
	["placademetal"] = { "Placa de Metal",0.5 },
	["corpodeak"] = { "Corpo de AK-47",0.5 },
	["corpodefiveseven"] = { "Corpo de Five Seven",0.5 },
	["corpodehkp7m10"] = { "Corpo de HK P7M10",0.5 },
	["corpodeg36"] = { "Corpo de G36",0.5 },
	["corpodemp5"] = { "Corpo de MP5",0.5 },
	["gatilho"] = { "Gatilho",0.5 },
	["mola"] = { "Mola",0.2 },
	["mola"] = { "Mola",0.2 },
	--====== dominas
	["metaldealta"] = { "Metal de alta",0.5 },
	
	
	-- Farm de Munição
	["capsula"] = { "Cápsula",0.15 },
	["polvora"] = { "Pólvora",0.08 },
	
	-- Farm de Desmanche
	["ferramenta"] = { "Ferramenta",0.5 },
	["serra"] = { "Serra",0.5 },
	["macarico"] = { "Maçarico",5.0 },
	
	-- Farm de Drogas
	["adubo"] = { "Adubo",0.3 },
	["embalagem"] = { "Embalagem",0.3 },
	["maconha"] = { "Maconha",1.0 },
	["heroina"] = { "Heroína",1.0 },
	["papouladeopio"] = { "Papoula de Ópio",0.3 },
	["anfetamina"] = { "Anfetamina",0.3 },
	["frascodeplastico"] = { "Frasco de Plástico",0.3 },
	["frasco"] = { "Frasco",0.3 },
	["metanfetamina"] = { "Metanfetamina",1.0 },
	["pino"] = { "Pino",0.3 },
	["pastadecoca"] = { "Pasta de Cocaina",0.3 },
	["cocaina"] = { "Cocaína",1.0 },
	["lolo"] = { "Loló",1.0 },
	
	-- Farm de colete
	["tecido"] = { "Tecido",0.3 },
	["colete"] = { "Colete Balístico",50.0 },
	["malha"] = { "malha",0.3 },
	["linha"] = { "linha",0.3 },

	-- Mineração (Sem refinar)
	["ametista2"] = { "Ametista2",0.3 },
	["bronze2"] = { "Bronze2",0.3 },
	["diamante2"] = { "Diamante2",0.3 },
	["esmeralda2"] = { "Esmeralda2",0.3 },
	["ferro2"] = { "Ferro2",0.3 },
	["ouro2"] = { "Ouro2",0.3 },
	["rubi2"] = { "Rubi2",0.3 },
	["safira2"] = { "Safira2",0.3 },
	["topazio2"] = { "Topazio2",0.3 },

	-- Mineração (Refinados)
	["ametista"] = { "Ametista",0.3 },
	["bronze"] = { "Bronze",0.3 },
	["diamante"] = { "Diamante",0.3 },
	["esmeralda"] = { "Esmeralda",0.3 },
	["ferro"] = { "Ferro",0.3 },
	["ouro"] = { "Ouro",0.3 },
	["rubi"] = { "Rubi",0.3 },
	["safira"] = { "Safira",0.3 },
	["topazio"] = { "Topazio",0.3 },
	
}

local function load_item_pack(name)
	local items = module("cfg/item/"..name)
	if items then
		for k,v in pairs(items) do
			cfg.items[k] = v
		end
	end
end

load_item_pack("armamentos")

return cfg