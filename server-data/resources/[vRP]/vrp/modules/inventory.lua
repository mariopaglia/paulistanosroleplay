local cfg = module("cfg/inventory")

local itemlist = {
	-- Gerais
	["sacodelixo"] = { index = "sacodelixo", nome = "Saco de Lixo", type = "usar" },
	["garrafavazia"] = { index = "garrafavazia", nome = "Garrafa Vazia", type = "usar" },
	["garrafadeleite"] = { index = "garrafadeleite", nome = "Garrafa de Leite", type = "usar" },
	["alianca"] = { index = "alianca", nome = "Aliança de Casamento", type = "usar" },
	["alianca2"] = { index = "alianca2", nome = "Aliança de Namoro", type = "usar" },
	["celular"] = { index = "celular", nome = "Celular", type = "usar" },
	["bandagem"] = { index = "bandagem", nome = "Bandagem", type = "usar" },
	["dinheirosujo"] = { index = "dinheirosujo", nome = "Dinheiro Sujo", type = "usar" },
	["repairkit"] = { index = "repairkit", nome = "Kit de Reparos", type = "usar" },
	["algemas"] = { index = "algemas", nome = "Algemas", type = "usar" },
	["capuz"] = { index = "capuz", nome = "Capuz", type = "usar" },
	["lockpick"] = { index = "lockpick", nome = "Lockpick", type = "usar" },
	["masterpick"] = { index = "masterpick", nome = "Masterpick", type = "usar" },
	["militec"] = { index = "militec", nome = "Militec", type = "usar" },
	["roupas"] = { index = "roupas", nome = "Roupas", type = "usar" },
	["energetico"] = { index = "energetico", nome = "Energético", type = "usar" },
	["mochila"] = { index = "mochila", nome = "Mochila", type = "usar" },
	["carbono"] = { index = "carbono", nome = "Carbono", type = "usar" },
	["radio"] = { index = "radio", nome = "Radio", type = "usar" },
	["c4"] = { index = "c4", nome = "C4", type = "usar" },
	["placa"] = { index = "placa", nome = "Placa", type = "usar" },
	["pneu"] = { index = "pneu", nome = "Pneu", type = "usar" },
	["cartaoinvasao"] = { index = "cartaoinvasao", nome = "Cartão de Invasão", type = "usar" },
	["gps"] = { index = "gps", nome = "GPS", type = "usar" },
	["rosa"] = { index = "rosa", nome = "Rosa", type = "usar" },
	["morango"] = { index = "morango", nome = "Morango", type = "usar" },
	["tequila"] = { index = "tequila", nome = "Tequila", type = "usar" },
	["vodka"] = { index = "vodka", nome = "Vodka", type = "usar" },
	["cerveja"] = { index = "cerveja", nome = "Cerveja", type = "usar" },
	["whisky"] = { index = "whisky", nome = "Whisky", type = "usar" },
	["conhaque"] = { index = "conhaque", nome = "Conhaque", type = "usar" },
	["absinto"] = { index = "absinto", nome = "Absinto", type = "usar" },
	["corda"] = { index = "corda", nome = "Corda", type = "usar" },
	["adrenalina"] = { index = "adrenalina", nome = "Adrenalina", type = "usar" },
	["gopro"] = { index = "gopro", nome = "GoPro Hero 9", type = "usar" },
	["gravadordevoz"] = { index = "gravadordevoz", nome = "Gravador de Voz", type = "usar" },
	["ticketpvp"] = { index = "ticketpvp", nome = "Ticket PVP", type = "usar" },
	["raspadinha"] = { index = "raspadinha", nome = "Raspadinha", type = "usar" },
	["casino_token"] = { index = "casino_token", nome = "Ficha Casino", type = "usar" },
	["casino_ticket"] = { index = "casino_ticket", nome = "Ticket Roleta", type = "usar" },
	
	-- Sistema de PETS
	["wammo|WEAPON_BALL"] = { index = "bolinha", nome = "Bolinha de PET", type = "recarregar" },
	["comidapet"] = { index = "comidapet", nome = "Comida de PET", type = "usar" },
	
	-- Evento
	["roupaevento"] = { index = "roupaevento", nome = "Roupa Evento", type = "usar" },

	-- Fome e Sede
	["hamburguer"] = { index = "hamburguer", nome = "Hamburguer", type = "usar" },
	["sanduiche"] = { index = "sanduiche", nome = "Sanduiche", type = "usar" },
	["frangofrito"] = { index = "frangofrito", nome = "Frango Frito", type = "usar" },
	["batatafrita"] = { index = "batatafrita", nome = "Batata Frita", type = "usar" },
	["cachorroquente"] = { index = "cachorroquente", nome = "Cachorro Quente", type = "usar" },
	["pizza"] = { index = "pizza", nome = "Pizza", type = "usar" },
	["rosquinha"] = { index = "rosquinha", nome = "Rosquinha", type = "usar" },
	--Bebidas
	["agua"] = { index = "agua", nome = "Água", type = "usar" },
	["mamadeira"] = { index = "mamadeira", nome = "Mamadeira", type = "usar" },
	["cafe"] = { index = "cafe", nome = "Café", type = "usar" },
	["cappuccino"] = { index = "cappuccino", nome = "Cappuccino", type = "usar" },
	["leite"] = { index = "leite", nome = "Leite", type = "usar" },
	["suco"] = { index = "suco", nome = "Suco", type = "usar" },
	["cocacola"] = { index = "cocacola", nome = "Cocacola", type = "usar" },
	["sprite"] = { index = "sprite", nome = "Sprite", type = "usar" },

	-- Farm Contrabandop
	["componentemetal"] = { index = "componentemetal", nome = "Componentes de Metais", type = "usar" },
	["componenteeletronico"] = { index = "componenteeletronico", nome = "Componentes Eletrônicos", type = "usar" },
	["componenteplastico"] = { index = "componenteplastico", nome = "Componentes de Plásticos", type = "usar" },
	
	-- Itens do roubo a residencia
	["sapatosroubado"] = { index = "sapatosroubado", nome = "Sapatos Roubado", type = "usar" },
	["relogioroubado"] = { index = "relogioroubado", nome = "Relógio Roubado", type = "usar" },
	["anelroubado"] = { index = "anelroubado", nome = "Anel Roubado", type = "usar" },
	["colarroubado"] = { index = "colarroubado", nome = "Colar Roubado", type = "usar" },
	["notebookroubado"] = { index = "notebookroubado", nome = "Notebook Roubado", type = "usar" },
	["tabletroubado"] = { index = "tabletroubado", nome = "Tablet Roubado", type = "usar" },
	["vibradorroubado"] = { index = "vibradorroubado", nome = "Vibrador Roubado", type = "usar" },
	["carteiraroubada"] = { index = "carteiraroubada", nome = "Carteira Roubada", type = "usar" },
	["perfumeroubado"] = { index = "perfumeroubado", nome = "Perfume Roubado", type = "usar" },

	-- Pesca
	["isca"] = { index = "isca", nome = "Isca", type = "usar" },
	["dourado"] = { index = "dourado", nome = "Dourado", type = "usar" },
	["corvina"] = { index = "corvina", nome = "Corvina", type = "usar" },
	["salmao"] = { index = "salmao", nome = "Salmão", type = "usar" },
	["pacu"] = { index = "pacu", nome = "Pacu", type = "usar" },
	["pintado"] = { index = "pintado", nome = "Pintado", type = "usar" },
	["pirarucu"] = { index = "pirarucu", nome = "Pirarucu", type = "usar" },
	["tilapia"] = { index = "tilapia", nome = "Tilápia", type = "usar" },
	["tucunare"] = { index = "tucunare", nome = "Tucunaré", type = "usar" },
	["lambari"] = { index = "lambari", nome = "Lambari", type = "usar" },
	
	-- Farm de Lavagem
	["pendrivedeep"] = { index = "pendrivedeep", nome = "Pendrive Deepweb", type = "usar" },
	["placacircuito"] = { index = "placacircuito", nome = "Placa de Circuito", type = "usar" },
	["chipset"] = { index = "chipset", nome = "Chipset", type = "usar" },
	
	-- Farm Drogas
	["pastadecoca"] = { index = "pastadecoca", nome = "Pasta de Coca", type = "usar" },
	["cocaina"] = { index = "cocaina", nome = "Cocaína", type = "usar" },
	["pino"] = { index = "pino", nome = "Pino", type = "usar" },
	["anfetamina"] = { index = "anfetamina", nome = "Anfetamina", type = "usar" },
	["metanfetamina"] = { index = "metanfetamina", nome = "Metanfetamina", type = "usar" },
	["maconha"] = { index = "maconha", nome = "Maconha", type = "usar" },
	["heroina"] = { index = "heroina", nome = "Heroína", type = "usar" },
	["papouladeopio"] = { index = "papouladeopio", nome = "Papoula de Ópio", type = "usar" },
	["embalagem"] = { index = "embalagem", nome = "Embalagem", type = "usar" },
	["frascodeplastico"] = { index = "frascodeplastico", nome = "Frasco de Plástico", type = "usar" },
	["frasco"] = { index = "frasco", nome = "Frasco", type = "usar" },
	["adubo"] = { index = "adubo", nome = "Adubo", type = "usar" },
	["lolo"] = { index = "lolo", nome = "Loló", type = "usar" },
	
	-- Farm Desmanche
	["ferramenta"] = { index = "ferramenta", nome = "Ferramenta", type = "usar" },
	["serra"] = { index = "serra", nome = "Serra", type = "usar" },
	["macarico"] = { index = "macarico", nome = "Maçarico", type = "usar" },
	["listadesmanche"] = { index = "listadesmanche", nome = "Lista Desmanche", type = "usar" },
	
	-- Farm de Armas
	["placademetal"] = { index = "placademetal", nome = "Placa de Metal", type = "usar" },
	["mola"] = { index = "mola", nome = "Mola", type = "usar" },
	["capsula"] = { index = "capsula", nome = "Cápsula", type = "usar" },
	["polvora"] = { index = "polvora", nome = "Pólvora", type = "usar" },
	["corpodeak"] = { index = "corpodeak", nome = "Corpo de AK-47", type = "usar" },
	["corpodefiveseven"] = { index = "corpodefiveseven", nome = "Corpo de Five Seven", type = "usar" },
	["corpodehkp7m10"] = { index = "corpodehkp7m10", nome = "Corpo de HK P7M10", type = "usar" },
	["corpodeg36"] = { index = "corpodeg36", nome = "Corpo de G36", type = "usar" },
	["corpodemp5"] = { index = "corpodemp5", nome = "Corpo de MP5", type = "usar" },
	["corpodescorpion"] = { index = "corpodescorpion", nome = "Corpo de Scorpion", type = "usar" },
	["corpodeshotgun"] = { index = "corpodeshotgun", nome = "Corpo de Shotgun", type = "usar" },
	["gatilho"] = { index = "gatilho", nome = "Gatilho", type = "usar" },
	["metaldealta"] = { index = "metaldealta", nome = "Metal de Alta", type = "usar" },

	-- Farm de Colete
	["tecido"] = { index = "tecido", nome = "Tecido", type = "usar" },
	["malha"] = { index = "malha", nome = "Malha", type = "usar" },
	["colete"] = { index = "colete", nome = "Colete Balístico", type = "usar" },
	["linha"] = { index = "linha", nome = "Linha", type = "usar" },

	-- Mineração (Não refinados)
	["ametista2"] = { index = "ametista2", nome = "Min. Ametista", type = "usar" },
	["bronze2"] = { index = "bronze2", nome = "Min. Bronze", type = "usar" },
	["diamante2"] = { index = "diamante2", nome = "Min. Diamante", type = "usar" },
	["esmeralda2"] = { index = "esmeralda2", nome = "Min. Esmeralda", type = "usar" },
	["ferro2"] = { index = "ferro2", nome = "Min. Ferro", type = "usar" },
	["ouro2"] = { index = "ouro2", nome = "Min. Ouro", type = "usar" },
	["rubi2"] = { index = "rubi2", nome = "Min. Rubi", type = "usar" },
	["safira2"] = { index = "safira2", nome = "Min. Safira", type = "usar" },
	["topazio2"] = { index = "topazio2", nome = "Min. Topazio", type = "usar" },

	-- Mineração (Refinados)
	["ametista"] = { index = "ametista", nome = "Ametista", type = "usar" },
	["bronze"] = { index = "bronze", nome = "Bronze", type = "usar" },
	["diamante"] = { index = "diamante", nome = "Diamante", type = "usar" },
	["esmeralda"] = { index = "esmeralda", nome = "Esmeralda", type = "usar" },
	["ferro"] = { index = "ferro", nome = "Ferro", type = "usar" },
	["ouro"] = { index = "ouro", nome = "Ouro", type = "usar" },
	["rubi"] = { index = "rubi", nome = "Rubi", type = "usar" },
	["safira"] = { index = "safira", nome = "Safira", type = "usar" },
	["topazio"] = { index = "topazio", nome = "Topazio", type = "usar" },

	-- Armas
	["wbody|WEAPON_DAGGER"] = { index = "adaga", nome = "Adaga", type = "equipar" },
	["wbody|WEAPON_BAT"] = { index = "beisebol", nome = "Taco de Beisebol", type = "equipar" },
	["wbody|WEAPON_BOTTLE"] = { index = "garrafa", nome = "Garrafa", type = "equipar" },
	["wbody|WEAPON_CROWBAR"] = { index = "cabra", nome = "Pé de Cabra", type = "equipar" },
	["wbody|WEAPON_FLASHLIGHT"] = { index = "lanterna", nome = "Lanterna", type = "equipar" },
	["wbody|WEAPON_GOLFCLUB"] = { index = "golf", nome = "Taco de Golf", type = "equipar" },
	["wbody|WEAPON_HAMMER"] = { index = "martelo", nome = "Martelo", type = "equipar" },
	["wbody|WEAPON_HATCHET"] = { index = "machado", nome = "Machado", type = "equipar" },
	["wbody|WEAPON_KNUCKLE"] = { index = "ingles", nome = "Soco-Inglês", type = "equipar" },
	["wbody|WEAPON_KNIFE"] = { index = "faca", nome = "Faca", type = "equipar" },
	["wbody|WEAPON_MACHETE"] = { index = "machete", nome = "Machete", type = "equipar" },
	["wbody|WEAPON_SWITCHBLADE"] = { index = "canivete", nome = "Canivete", type = "equipar" },
	["wbody|WEAPON_NIGHTSTICK"] = { index = "cassetete", nome = "Cassetete", type = "equipar" },
	["wbody|WEAPON_WRENCH"] = { index = "grifo", nome = "Chave de Grifo", type = "equipar" },
	["wbody|WEAPON_BATTLEAXE"] = { index = "batalha", nome = "Machado de Batalha", type = "equipar" },
	["wbody|WEAPON_POOLCUE"] = { index = "sinuca", nome = "Taco de Sinuca", type = "equipar" },
	["wbody|WEAPON_STONE_HATCHET"] = { index = "pedra", nome = "Machado de Pedra", type = "equipar" },
	["wbody|WEAPON_PISTOL"] = { index = "m1911", nome = "M1911", type = "equipar" },
	["wbody|WEAPON_STUNGUN"] = { index = "taser", nome = "Taser", type = "equipar" },
	["wbody|WEAPON_VINTAGEPISTOL"] = { index = "m1922", nome = "M1922", type = "equipar" },
	["wbody|WEAPON_REVOLVER"] = { index = "magnum44", nome = "Magnum 44", type = "equipar" },
	["wbody|WEAPON_REVOLVER_MK2"] = { index = "magnum357", nome = "Magnum 357", type = "equipar" },
	["wbody|GADGET_PARACHUTE"] = { index = "paraquedas", nome = "Paraquedas", type = "equipar" },
	["wbody|WEAPON_FIREEXTINGUISHER"] = { index = "extintor", nome = "Extintor", type = "equipar" },
	["wbody|WEAPON_MICROSMG"] = { index = "uzi", nome = "Uzi", type = "equipar" },
	["wbody|WEAPON_ASSAULTSMG"] = { index = "mtar21", nome = "MTAR-21", type = "equipar" },
	["wbody|WEAPON_ASSAULTRIFLE"] = { index = "ak103", nome = "AK-103", type = "equipar" },
	["wbody|WEAPON_BULLPUPRIFLE_MK2"] = { index = "famas", nome = "Famas", type = "equipar" },
	["wbody|WEAPON_PETROLCAN"] = { index = "gasolina", nome = "Galão de Gasolina", type = "equipar" },	
	["wammo|WEAPON_PETROLCAN"] = { index = "m-gasolina", nome = "Combustível", type = "recarregar" },	
	["wbody|WEAPON_GUSENBERG"] = { index = "thompson", nome = "Thompson", type = "equipar" },		
	["wbody|WEAPON_MACHINEPISTOL"] = { index = "tec9", nome = "Tec-9", type = "equipar" },
	["wbody|WEAPON_COMPACTRIFLE"] = { index = "aks", nome = "AKS", type = "equipar" },
	["wbody|WEAPON_BULLPUPRIFLE_MK2"] = { index = "famas", nome = "FAMAS", type = "equipar" },
	["wbody|WEAPON_RAYPISTOL"] = { index = "raypistol", nome = "Raypistol", type = "equipar" },
	["wammo|WEAPON_BULLPUPRIFLE_MK2"] = { index = "m-famas", nome = "M.FAMAS", type = "recarregar" },
	["wammo|WEAPON_PISTOL"] = { index = "m-m1911", nome = "M.M1911", type = "recarregar" },
	["wammo|WEAPON_STUNGUN"] = { index = "m-taser", nome = "M.Taser", type = "recarregar" },
	["wammo|WEAPON_VINTAGEPISTOL"] = { index = "m-m1922", nome = "M.M1922", type = "recarregar" },
	["wammo|WEAPON_FLARE"] = { index = "m-sinalizador", nome = "M.Sinalizador", type = "recarregar" },
	["wammo|GADGET_PARACHUTE"] = { index = "m-paraquedas", nome = "M.Paraquedas", type = "recarregar" },
	["wammo|WEAPON_FIREEXTINGUISHER"] = { index = "m-extintor", nome = "M.Extintor", type = "recarregar" },
	["wammo|WEAPON_PUMPSHOTGUN"] = { index = "m-shotgun", nome = "M.Shotgun", type = "recarregar" },
	["wammo|WEAPON_ASSAULTRIFLE"] = { index = "m-ak103", nome = "M.AK-103", type = "recarregar" },
	["wammo|WEAPON_GUSENBERG"] = { index = "m-thompson", nome = "M.Thompson", type = "recarregar" },
	["wammo|WEAPON_MACHINEPISTOL"] = { index = "m-tec9", nome = "M.Tec-9", type = "recarregar" },
	["wammo|WEAPON_COMPACTRIFLE"] = { index = "m-aks", nome = "M.AKS", type = "recarregar" },
	["wammo|WEAPON_PETROLCAN"] = { index = "combustivel", nome = "Combustível", type = "recarregar" },
	["wammo|WEAPON_REVOLVER"] = { index = "m-magnum44", nome = "M.MAGNUM-44", type = "recarregar" },
	["wammo|WEAPON_MICROSMG"] = { index = "m-uzi", nome = "M.UZI", type = "recarregar" },
	["wammo|WEAPON_REVOLVER_MK2"] = { index = "m-magnum357", nome = "M.MAGNUM-357", type = "recarregar" },
	["wammo|WEAPON_ASSAULTSMG"] = { index = "m-mtar21", nome = "M.MTAR-21", type = "recarregar" },
	["wammo|WEAPON_BULLPUPRIFLE_MK2"] = { index = "m-famas", nome = "M.FAMAS", type = "recarregar" },
	
	-- Armas Policia
	["wbody|WEAPON_CARBINERIFLE_MK2"] = { index = "m4a1", nome = "M4A1", type = "equipar" },
	["wbody|WEAPON_CARBINERIFLE"] = { index = "ar15", nome = "AR-15", type = "equipar" },
	["wbody|WEAPON_COMBATPDW"] = { index = "sigsauer", nome = "Sig Sauer", type = "equipar" },
	["wbody|WEAPON_COMBATPISTOL"] = { index = "glock", nome = "Glock", type = "equipar" },
	["wbody|WEAPON_SPECIALCARBINE"] = { index = "g36x", nome = "G36x", type = "equipar" },
	["wbody|WEAPON_PUMPSHOTGUN_MK2"] = { index = "remington", nome = "Remington 870", type = "equipar" },
	-- Munição Policia
	["wammo|WEAPON_CARBINERIFLE_MK2"] = { index = "m-m4a1", nome = "M. M4A1", type = "recarregar" },
	["wammo|WEAPON_CARBINERIFLE"] = { index = "m-ar15", nome = "M. AR-15", type = "recarregar" },
	["wammo|WEAPON_COMBATPDW"] = { index = "m-sigsauer", nome = "M. Sig Sauer", type = "recarregar" },
	["wammo|WEAPON_COMBATPISTOL"] = { index = "m-glock", nome = "M. Glock", type = "recarregar" },
	["wammo|WEAPON_SPECIALCARBINE"] = { index = "m-g36x", nome = "M. G36x", type = "recarregar" },
	["wammo|WEAPON_PUMPSHOTGUN_MK2"] = { index = "m-remington", nome = "M.Remington 870", type = "recarregar" },
	
	-- Pistol do porte
	["wbody|WEAPON_PISTOL"] = { index = "m1911", nome = "M1911", type = "equipar" },
	["wammo|WEAPON_PISTOL"] = { index = "m-m1911", nome = "M. M1911", type = "recarregar" },

	-- Armas novas 
	["wbody|WEAPON_MUSKET"] = { index = "mosinnagant", nome = "Mosin Nagant", type = "equipar" },
	["wbody|WEAPON_SAWNOFFSHOTGUN"] = { index = "mossberg500", nome = "Mossberg 500", type = "equipar" },
	["wbody|WEAPON_MINISMG"] = { index = "czscorpion", nome = "CZ Scorpion", type = "equipar" },
	["wbody|WEAPON_SNSPISTOL"] = { index = "hkp7m10", nome = "HK P7M10", type = "equipar" },

	-- Municoes novas
	["wammo|WEAPON_MUSKET"] = { index = "m-mosinnagant", nome = "M.Mosin Nagant", type = "recarregar" },
	["wammo|WEAPON_SAWNOFFSHOTGUN"] = { index = "m-mossberg500", nome = "M.Mossberg 500", type = "recarregar" },
	["wammo|WEAPON_MINISMG"] = { index = "m-czscorpion", nome = "M.CZ Scorpion", type = "recarregar" },
	["wammo|WEAPON_SNSPISTOL"] = { index = "m-hkp7m10", nome = "M.HK P7M10", type = "recarregar" },

	-- Armas Ilegal
	["wbody|WEAPON_ASSAULTRIFLE_MK2"] = { index = "ak47", nome = "AK-47", type = "equipar" },
	["wbody|WEAPON_SPECIALCARBINE_MK2"] = { index = "g36", nome = "G36", type = "equipar" },
	["wbody|WEAPON_SMG_MK2"] = { index = "mp5", nome = "MP5", type = "equipar" },
	["wbody|WEAPON_PISTOL_MK2"] = { index = "fiveseven", nome = "Five Seven", type = "equipar" },
	-- Munição Ilegal
	["wammo|WEAPON_ASSAULTRIFLE_MK2"] = { index = "m-ak47", nome = "M. AK-47", type = "recarregar" },
	["wammo|WEAPON_SPECIALCARBINE_MK2"] = { index = "m-g36", nome = "M. G36", type = "recarregar" },
	["wammo|WEAPON_SMG_MK2"] = { index = "m-mp5", nome = "M.MP5", type = "recarregar" },
	["wammo|WEAPON_PISTOL_MK2"] = { index = "m-fiveseven", nome = "M. Five Seven", type = "recarregar" }
}

function vRP.itemNameList(item)
	if itemlist[item] ~= nil then
		return itemlist[item].nome
	end
end

function vRP.itemIndexList(item)
	if itemlist[item] ~= nil then
		return itemlist[item].index
	end
end

function vRP.itemTypeList(item)
	if itemlist[item] ~= nil then
		return itemlist[item].type
	end
end

function vRP.itemBodyList(item)
	if itemlist[item] ~= nil then
		return itemlist[item]
	end
end

vRP.items = {}
function vRP.defInventoryItem(idname,name,weight)
	if weight == nil then
		weight = 0
	end
	local item = { name = name, weight = weight }
	vRP.items[idname] = item
end

function vRP.computeItemName(item,args)
	if type(item.name) == "string" then
		return item.name
	else
		return item.name(args)
	end
end

function vRP.computeItemWeight(item,args)
	if type(item.weight) == "number" then
		return item.weight
	else
		return item.weight(args)
	end
end

function vRP.parseItem(idname)
	return splitString(idname,"|")
end

function vRP.getItemDefinition(idname)
	local args = vRP.parseItem(idname)
	local item = vRP.items[args[1]]
	if item then
		return vRP.computeItemName(item,args),vRP.computeItemWeight(item,args)
	end
	return nil,nil
end

function vRP.getItemWeight(idname)
	local args = vRP.parseItem(idname)
	local item = vRP.items[args[1]]
	if item then
		return vRP.computeItemWeight(item,args)
	end
	return 0
end

function vRP.computeItemsWeight(items)
	local weight = 0
	for k,v in pairs(items) do
		local iweight = vRP.getItemWeight(k)
		weight = weight+iweight*v.amount
	end
	return weight
end

-- function vRP.giveInventoryItem(user_id,idname,amount)
-- 	local amount = parseInt(amount)
-- 	local data = vRP.getUserDataTable(user_id)
-- 	if data and amount > 0 then
-- 		local entry = data.inventory[idname]
-- 		if entry then
-- 			entry.amount = entry.amount + amount
-- 		else
-- 			data.inventory[idname] = { amount = amount }
-- 		end
-- 	end
-- end

-- function vRP.tryGetInventoryItem(user_id,idname,amount)
-- 	local amount = parseInt(amount)
-- 	local data = vRP.getUserDataTable(user_id)
-- 	if data and amount > 0 then
-- 		local entry = data.inventory[idname]
-- 		if entry and entry.amount >= amount then
-- 			entry.amount = entry.amount - amount

-- 			if entry.amount <= 0 then
-- 				data.inventory[idname] = nil
-- 			end
-- 			return true
-- 		end
-- 	end
-- 	return false
-- end

function vRP.giveInventoryItem(user_id,idname,amount)
    local source = vRP.getUserSource(parseInt(user_id))
    local amount = parseInt(amount)
    local data = vRP.getUserDataTable(user_id)
    if data and amount > 0 then
        local entry = data.inventory[idname]
        if entry then
            entry.amount = entry.amount + amount
        else
            data.inventory[idname] = { amount = amount }
        end
    end 
    TriggerClientEvent("itensNotify",source,"sucesso",""..vRP.format(parseInt(amount)).."x "..vRP.itemNameList(idname).."",""..vRP.itemIndexList(idname).."") 
end

function vRP.tryGetInventoryItem(user_id,idname,amount)
    local source = vRP.getUserSource(parseInt(user_id))
    local amount = parseInt(amount)
    local data = vRP.getUserDataTable(user_id)
    if data and amount > 0 then
        TriggerClientEvent("itensNotify",source,"negado",""..vRP.format(parseInt(amount)).."x "..vRP.itemNameList(idname).."",""..vRP.itemIndexList(idname).."") 
        local entry = data.inventory[idname]
        if entry and entry.amount >= amount then
            entry.amount = entry.amount - amount

            if entry.amount <= 0 then
                data.inventory[idname] = nil
            end
            return true
        end
    end
    return false
end

function vRP.getInventoryItemAmount(user_id,idname)
	local data = vRP.getUserDataTable(user_id)
	if data and data.inventory then
		local entry = data.inventory[idname]
		if entry then
			return entry.amount
		end
	end
	return 0
end

function vRP.getInventory(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data then
		return data.inventory
	end
end

function vRP.getInventoryWeight(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data and data.inventory then
		return vRP.computeItemsWeight(data.inventory)
	end
	return 0
end

function vRP.getInventoryMaxWeight(user_id)
	return math.floor(vRP.expToLevel(vRP.getExp(user_id,"physical","strength")))*3
end

RegisterServerEvent("clearInventory")
AddEventHandler("clearInventory",function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local data = vRP.getUserDataTable(user_id)
        if data then
            data.inventory = {}
        end

        vRP.setMoney(user_id,0)
        vRPclient._clearWeapons(source)
        vRPclient._setHandcuffed(source,false)
		vRP.varyHunger(user_id,-100)
        vRP.varyThirst(user_id,-100)

        if not vRP.hasPermission(user_id,"mochila.permissao") then
            vRP.setExp(user_id,"physical","strength",20)
        end
		vRP.setMoney(user_id, 0)
    end
end)

AddEventHandler("vRP:playerJoin", function(user_id,source,name)
	local data = vRP.getUserDataTable(user_id)
	if not data.inventory then
		data.inventory = {}
	end
end)

local chests = {}
local function build_itemlist_menu(name,items,cb)
	local menu = { name = name }
	local kitems = {}

	local choose = function(player,choice)
		local idname = kitems[choice]
		if idname then
			cb(idname)
		end
	end

	for k,v in pairs(items) do 
		local name,weight = vRP.getItemDefinition(k)
		if name then
			kitems[name] = k
			menu[name] = { choose,"<text01>Quantidade:</text01> <text02>"..v.amount.."</text02><text01>Peso:</text01> <text02>"..string.format("%.2f",weight).."kg</text02>" }
		end
	end

	return menu
end

function vRP.openChest(source,name,max_weight,cb_close,cb_in,cb_out)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		local identity = vRP.getUserIdentity(user_id)
		if data.inventory then
			if not chests[name] then
				local close_count = 0
				local chest = { max_weight = max_weight }
				chests[name] = chest 
				local cdata = vRP.getSData("chest:"..name)
				chest.items = json.decode(cdata) or {}

				local menu = { name = "Baú" }
				local cb_take = function(idname)
					local citem = chest.items[idname]
					local amount = vRP.prompt(source,"Quantidade:","")
					if parseInt(amount) > 0 and parseInt(amount) <= citem.amount then
						local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight(idname)*parseInt(amount)
						if new_weight <= vRP.getInventoryMaxWeight(user_id) then
							vRP.giveInventoryItem(user_id,idname,parseInt(amount))
							citem.amount = citem.amount - parseInt(amount)

							if citem.amount <= 0 then
								chest.items[idname] = nil
							end

							if cb_out then
								cb_out(idname,parseInt(amount))
							end
							vRP.closeMenu(source)
						else
							TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
						end
					else
						TriggerClientEvent("Notify",source,"negado","Valor inválido.",8000)
					end
				end

				local ch_take = function(player,choice)
					local weight = vRP.computeItemsWeight(chest.items)
					local submenu = build_itemlist_menu(string.format("%.2f",weight).." / "..max_weight.."kg",chest.items,cb_take)

					submenu.onclose = function()
						close_count = close_count - 1
						vRP.openMenu(player,menu)
					end
					close_count = close_count + 1
					vRP.openMenu(player,submenu)
				end

				local cb_put = function(idname)
					if string.match(idname,"identidade") then
						TriggerClientEvent("Notify",source,"importante","Não pode guardar a <b>Identidade</b> em veículos.",8000)
						return
					end

					local amount = vRP.prompt(source,"Quantidade:","")
					local new_weight = vRP.computeItemsWeight(chest.items)+vRP.getItemWeight(idname)*parseInt(amount)
					if new_weight <= max_weight then
						if parseInt(amount) > 0 and vRP.tryGetInventoryItem(user_id,idname,parseInt(amount)) then

							local citem = chest.items[idname]

							if citem ~= nil then
								citem.amount = citem.amount + parseInt(amount)
							else
								chest.items[idname] = { amount = parseInt(amount) }
							end

							if cb_in then
								cb_in(idname,parseInt(amount))
							end
							vRP.closeMenu(source)
						end
					else
						TriggerClientEvent("Notify",source,"negado","Baú cheio.",8000)
					end
				end

				local ch_put = function(player,choice)
					local weight = vRP.computeItemsWeight(data.inventory)
					local submenu = build_itemlist_menu(string.format("%.2f",weight).." / "..max_weight.."kg",data.inventory,cb_put)

					submenu.onclose = function()
						close_count = close_count-1
						vRP.openMenu(player,menu)
					end

					close_count = close_count + 1
					vRP.openMenu(player,submenu)
				end

				menu["Retirar"] = { ch_take }
				menu["Colocar"] = { ch_put }

				menu.onclose = function()
					if close_count == 0 then
						vRP.setSData("chest:"..name,json.encode(chest.items))
						chests[name] = nil
						if cb_close then
							cb_close()
						end
					end
				end
				vRP.openMenu(source,menu)
			else
				TriggerClientEvent("Notify",source,"importante","Está sendo utilizado no momento.",8000)
			end
		end
	end
end

local function build_client_static_chests(source)
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(cfg.static_chests) do
			local mtype,x,y,z = table.unpack(v)
			local schest = cfg.static_chest_types[mtype]
			
			if schest then
				local function schest_enter(source)
					local user_id = vRP.getUserId(source)
					if user_id and vRP.hasPermissions(user_id,schest.permissions or {}) then
						vRP.openChest(source,"static:"..k,schest.weight or 0)
					end
				end
				
				local function schest_leave(source)
					vRP.closeMenu(source)
				end
				
				vRP.setArea(source,"vRP:static_chest:"..k,x,y,z,1,1,schest_enter,schest_leave)
			end
		end
	end
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		build_client_static_chests(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHGLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
local vehglobal = {
	-- CARROS CONCE
	["panto"] = { ['name'] = "Panto", ['price'] = 10000, ['tipo'] = "carros" },
	["asea"] = { ['name'] = "Asea", ['price'] = 30000, ['tipo'] = "carros" },
	["rhapsody"] = { ['name'] = "Rhapsody", ['price'] = 12000, ['tipo'] = "carros" },
	["prairie"] = { ['name'] = "Prairie", ['price'] = 15000, ['tipo'] = "carros" },
	["brioso"] = { ['name'] = "Brioso", ['price'] = 40000, ['tipo'] = "carros" },
	["issi2"] = { ['name'] = "Issi2", ['price'] = 80000, ['tipo'] = "carros" },
	["cogcabrio"] = { ['name'] = "Cogcabrio", ['price'] = 210000, ['tipo'] = "carros" },
	["f620"] = { ['name'] = "F620", ['price'] = 25000, ['tipo'] = "carros" },
	["faction2"] = { ['name'] = "Faction2", ['price'] = 180000, ['tipo'] = "carros" },
	["zion"] = { ['name'] = "Zion", ['price'] = 30000, ['tipo'] = "carros" },
	["dukes"] = { ['name'] = "Dukes", ['price'] = 240000, ['tipo'] = "carros" },
	["oracle2"] = { ['name'] = "Oracle2", ['price'] = 74000, ['tipo'] = "carros" },
	["dominator"] = { ['name'] = "Dominator", ['price'] = 125000, ['tipo'] = "carros" },
	["buccaneer2"] = { ['name'] = "Buccaneer2", ['price'] = 180000, ['tipo'] = "carros" },
	["ellie"] = { ['name'] = "Ellie", ['price'] = 180000, ['tipo'] = "carros" },
	["tampa"] = { ['name'] = "Tampa", ['price'] = 210000, ['tipo'] = "carros" },
	["tulip"] = { ['name'] = "Tulip", ['price'] = 260000, ['tipo'] = "carros" },
	["jackal"] = { ['name'] = "Jackal", ['price'] = 62000, ['tipo'] = "carros" },
	["gauntlet"] = { ['name'] = "Gauntlet", ['price'] = 110000, ['tipo'] = "carros" },
	["buccaneer"] = { ['name'] = "Buccaneer", ['price'] = 180000, ['tipo'] = "carros" },
	["exemplar"] = { ['name'] = "Exemplar", ['price'] = 68000, ['tipo'] = "carros" },
	["blade"] = { ['name'] = "Blade", ['price'] = 180000, ['tipo'] = "carros" },
	["hustler"] = { ['name'] = "hustler", ['price'] = 290000, ['tipo'] = "carros" },
	["vigero"] = { ['name'] = "Vigero", ['price'] = 45000, ['tipo'] = "carros" },
	["asterope"] = { ['name'] = "asterope", ['price'] = 55000, ['tipo'] = "carros" },
	["ruston"] = { ['name'] = "Ruston", ['price'] = 102000, ['tipo'] = "carros" },
	["chino2"] = { ['name'] = "Chino2", ['price'] = 180000, ['tipo'] = "carros" },
	["picador"] = { ['name'] = "Picador", ['price'] = 55000, ['tipo'] = "carros" },
	["coquette3"] = { ['name'] = "Coquette3", ['price'] = 350000, ['tipo'] = "carros" },
	["ratloader2"] = { ['name'] = "Ratloader2", ['price'] = 100, ['tipo'] = "carros" },
	["slamvan3"] = { ['name'] = "Slamvan3", ['price'] = 100, ['tipo'] = "carros" },
	["dominator3"] = { ['name'] = "Dominator3", ['price'] = 138000, ['tipo'] = "carros" },
	["futo"] = { ['name'] = "Futo", ['price'] = 115000, ['tipo'] = "carros" },
	["stafford"] = { ['name'] = "Stafford", ['price'] = 320000, ['tipo'] = "carros" },
	["sentinel3"] = { ['name'] = "Sentinel3", ['price'] = 195000, ['tipo'] = "carros" },
	["alpha"] = { ['name'] = "Alpha", ['price'] = 58000, ['tipo'] = "carros" },
	["cognoscenti"] = { ['name'] = "Cognoscenti", ['price'] = 85000, ['tipo'] = "carros" },
	["revolter"] = { ['name'] = "revolter", ['price'] = 92000, ['tipo'] = "carros" },
	["khamelion"] = { ['name'] = "Khamelion", ['price'] = 202000, ['tipo'] = "carros" },
	["buffalo2"] = { ['name'] = "Buffalo2", ['price'] = 80000, ['tipo'] = "carros" },
	["rapidgt"] = { ['name'] = "Rapidgt", ['price'] = 220000, ['tipo'] = "carros" },
	["furoregt"] = { ['name'] = "Furoregt", ['price'] = 235000, ['tipo'] = "carros" },
	["kuruma"] = { ['name'] = "Kuruma", ['price'] = 150000, ['tipo'] = "carros" },
	["elegy"] = { ['name'] = "Elegy", ['price'] = 260000, ['tipo'] = "carros" },
	["bullet"] = { ['name'] = "Bullet", ['price'] = 200000, ['tipo'] = "carros" },
	["carbonizzare"] = { ['name'] = "Carbonizzare", ['price'] = 260000, ['tipo'] = "carros" },
	["lynx"] = { ['name'] = "Lynx", ['price'] = 355000, ['tipo'] = "carros" },
	["banshee"] = { ['name'] = "Banshee", ['price'] = 390000, ['tipo'] = "carros" },
	["rocoto"] = { ['name'] = "Rocoto", ['price'] = 370000, ['tipo'] = "carros" },
	["huntley"] = { ['name'] = "Huntley", ['price'] = 430000, ['tipo'] = "carros" },
	["xls"] = { ['name'] = "Xls", ['price'] = 490000, ['tipo'] = "carros" },
	["bestiagts"] = { ['name'] = "Bestiagts", ['price'] = 380000, ['tipo'] = "carros" },
	["raiden"] = { ['name'] = "Raiden", ['price'] = 170000, ['tipo'] = "carros" },
	["surano"] = { ['name'] = "Surano", ['price'] = 255000, ['tipo'] = "carros" },
	["ninef"] = { ['name'] = "Ninef", ['price'] = 175000, ['tipo'] = "carros" },
	["cyclone"] = { ['name'] = "Cyclone", ['price'] = 460000, ['tipo'] = "carros" },
	["seven70"] = { ['name'] = "Seven70", ['price'] = 412000, ['tipo'] = "carros" },
	["flashgt"] = { ['name'] = "Flashgt", ['price'] = 280000, ['tipo'] = "carros" },
	["coquette"] = { ['name'] = "Coquette", ['price'] = 245000, ['tipo'] = "carros" },
	["elegy2"] = { ['name'] = "Elegy2", ['price'] = 240000, ['tipo'] = "carros" },
	["italigtb"] = { ['name'] = "Italigtb", ['price'] = 295000, ['tipo'] = "carros" },
	["mesa3"] = { ['name'] = "Mesa3", ['price'] = 640000, ['tipo'] = "carros" },
	["baller4"] = { ['name'] = "Baller4", ['price'] = 520000, ['tipo'] = "carros" },
	["dubsta2"] = { ['name'] = "Dubsta2", ['price'] = 470000, ['tipo'] = "carros" },
	["banshee2"] = { ['name'] = "Banshee2", ['price'] = 440000, ['tipo'] = "carros" },
	["vacca"] = { ['name'] = "Vacca", ['price'] = 410000, ['tipo'] = "carros" },
	["visione"] = { ['name'] = "Visione", ['price'] = 480000, ['tipo'] = "carros" },
	["massacro"] = { ['name'] = "Massacro", ['price'] = 115000, ['tipo'] = "carros" },
	["jester"] = { ['name'] = "Jester", ['price'] = 130000, ['tipo'] = "carros" },
	["sultanrs"] = { ['name'] = "Sultan RS", ['price'] = 198000, ['tipo'] = "carros" },
	["comet2"] = { ['name'] = "Comet2", ['price'] = 295000, ['tipo'] = "carros" },
	["neon"] = { ['name'] = "Neon", ['price'] = 180000, ['tipo'] = "carros" },
	["taipan"] = { ['name'] = "Taipan", ['price'] = 395000, ['tipo'] = "carros" },
	["tempesta"] = { ['name'] = "Tempesta", ['price'] = 450000, ['tipo'] = "carros" },
	["patriot"] = { ['name'] = "Patriot", ['price'] = 400000, ['tipo'] = "carros" },
	["toros"] = { ['name'] = "Toros", ['price'] = 600000, ['tipo'] = "carros" },
	["reaper"] = { ['name'] = "Reaper", ['price'] = 300000, ['tipo'] = "carros" },
	["turismor"] = { ['name'] = "Turismor", ['price'] = 312000, ['tipo'] = "carros" },
	["specter"] = { ['name'] = "Specter", ['price'] = 235000, ['tipo'] = "carros" },
	["tyrant"] = { ['name'] = "Tyrant", ['price'] = 315000, ['tipo'] = "carros" },
	["pariah"] = { ['name'] = "Pariah", ['price'] = 410000, ['tipo'] = "carros" },
	["deveste"] = { ['name'] = "Deveste", ['price'] = 490000, ['tipo'] = "carros" },
	["cheetah"] = { ['name'] = "Cheetah", ['price'] = 340000, ['tipo'] = "carros" },
	["sheava"] = { ['name'] = "Sheava", ['price'] = 350000, ['tipo'] = "carros" },
	["xa21"] = { ['name'] = "Xa21", ['price'] = 455000, ['tipo'] = "carros" },
	["entityxf"] = { ['name'] = "Entityxf", ['price'] = 345000, ['tipo'] = "carros" },
	["gp1"] = { ['name'] = "Gp1", ['price'] = 305000, ['tipo'] = "carros" },
	["entity2"] = { ['name'] = "Entity2", ['price'] = 400000, ['tipo'] = "carros" },
	["nero"] = { ['name'] = "Nero", ['price'] = 475000, ['tipo'] = "carros" },
	["prototipo"] = { ['name'] = "Prototipo", ['price'] = 500000, ['tipo'] = "carros" },
	["vagner"] = { ['name'] = "Vagner", ['price'] = 448000, ['tipo'] = "carros" },
	["t20"] = { ['name'] = "T20", ['price'] = 420000, ['tipo'] = "carros" },
	["adder"] = { ['name'] = "Adder", ['price'] = 530000, ['tipo'] = "carros" },
	["pfister811"] = { ['name'] = "Pfister811", ['price'] = 438000, ['tipo'] = "carros" },
	["italigto"] = { ['name'] = "Italigto", ['price'] = 590000, ['tipo'] = "carros" },
	["zentorno"] = { ['name'] = "Zentorno", ['price'] = 590000, ['tipo'] = "carros" },
	["osiris"] = { ['name'] = "Osiris", ['price'] = 440000, ['tipo'] = "carros" },
	
	-- DIAMOND
	["asbo"] = { ['name'] = "asbo", ['price'] = 180000, ['tipo'] = "carros" },
	["kanjo"] = { ['name'] = "kanjo", ['price'] = 220000, ['tipo'] = "carros" },
	["retinue2"] = { ['name'] = "retinue2", ['price'] = 250000, ['tipo'] = "carros" },
	["nebula"] = { ['name'] = "nebula", ['price'] = 275000, ['tipo'] = "carros" },
	["zion3"] = { ['name'] = "zion3", ['price'] = 290000, ['tipo'] = "carros" },
	["hellion"] = { ['name'] = "hellion", ['price'] = 300000, ['tipo'] = "carros" },
	["yosemite2"] = { ['name'] = "yosemite2", ['price'] = 300000, ['tipo'] = "carros" },
	["issi7"] = { ['name'] = "issi7", ['price'] = 300000, ['tipo'] = "carros" },
	["gauntlet4"] = { ['name'] = "gauntlet4", ['price'] = 400000, ['tipo'] = "carros" },
	["novak"] = { ['name'] = "novak", ['price'] = 460000, ['tipo'] = "carros" },
	["dynasty"] = { ['name'] = "dynasty", ['price'] = 460000, ['tipo'] = "carros" },
	["rebla"] = { ['name'] = "rebla", ['price'] = 500000, ['tipo'] = "carros" },
	["imorgon"] = { ['name'] = "imorgon", ['price'] = 500000, ['tipo'] = "carros" },
	["paragon"] = { ['name'] = "paragon", ['price'] = 550000, ['tipo'] = "carros" },
	["peyote"] = { ['name'] = "peyote", ['price'] = 560000, ['tipo'] = "carros" },
	["drafter"] = { ['name'] = "drafter", ['price'] = 600000, ['tipo'] = "carros" },
	["s80"] = { ['name'] = "s80", ['price'] = 600000, ['tipo'] = "carros" },
	["gauntlet5"] = { ['name'] = "gauntlet5", ['price'] = 640000, ['tipo'] = "carros" },
	["caracara2"] = { ['name'] = "caracara2", ['price'] = 650000, ['tipo'] = "carros" },
	["locust"] = { ['name'] = "locust", ['price'] = 650000, ['tipo'] = "carros" },
	["komoda"] = { ['name'] = "komoda", ['price'] = 100, ['tipo'] = "work" },
	["sultan2"] = { ['name'] = "sultan2", ['price'] = 700000, ['tipo'] = "carros" },
	["everon"] = { ['name'] = "everon", ['price'] = 700000, ['tipo'] = "carros" },
	["neo"] = { ['name'] = "neo", ['price'] = 780000, ['tipo'] = "carros" },
	["sugoi"] = { ['name'] = "sugoi", ['price'] = 800000, ['tipo'] = "carros" },
	["emerus"] = { ['name'] = "emerus", ['price'] = 800000, ['tipo'] = "carros" },
	["zorrusso"] = { ['name'] = "zorrusso", ['price'] = 800000, ['tipo'] = "carros" },
	["thrax"] = { ['name'] = "thrax", ['price'] = 900000, ['tipo'] = "carros" },
	["vstr"] = { ['name'] = "vstr", ['price'] = 900000, ['tipo'] = "carros" },
	["furia"] = { ['name'] = "furia", ['price'] = 900000, ['tipo'] = "carros" },
	["jugular"] = { ['name'] = "jugular", ['price'] = 900000, ['tipo'] = "carros" },

	-- RMOD EDIÇÃO LIMITADA
	["rmodbolide"] = { ['name'] = "Bugatti Bolide", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmodcharger69"] = { ['name'] = "Dodge Charger R/T 69", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmodescort"] = { ['name'] = "Ford Escort RS Cosworth ", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmodf40"] = { ['name'] = "Ferrari F40 Competizione", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmodgtr50"] = { ['name'] = "Nissan GT-R50", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmodlego1"] = { ['name'] = "Lego Bugatti Chiron", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmodlego2"] = { ['name'] = "Lego Ferrari F40 ", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmodlego3"] = { ['name'] = "Lego Mini Cooper", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmodlegosenna"] = { ['name'] = "Lego McLaren Senna", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmodmonster"] = { ['name'] = "Quartz Regalia Type-D", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmodmonstergt"] = { ['name'] = "Mercedes-Benz GT63S MonsterTruck ", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmodquadra"] = { ['name'] = "Quadra Turbo-R V-TECH ", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmodtracktor"] = { ['name'] = "Top Gear Track-Tor", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmodm8gte"] = { ['name'] = "BMW M8 GTE", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmodskyline34"] = { ['name'] = "Nissan Skyline BNR34 C-WEST", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmod240sx"] = { ['name'] = "Nissan 240SX", ['price'] = 1000000, ['tipo'] = "vip" },
	
	-- EDICAO ESPECIAL
	["evo9"] = { ['name'] = "Lancer Evolution IX Fast and Furios", ['price'] = 1000000, ['tipo'] = "vip" },
	["skyline"] = { ['name'] = "Nissan Skyline R34 Japan", ['price'] = 1000000, ['tipo'] = "vip" },
	-- CARRO VAKINHA
	["subaruimpreza"] = { ['name'] = "Subaru Impreza WRX STI", ['price'] = 1000000, ['tipo'] = "vip" },
	["ninjah2"] = { ['name'] = "Kawasaki Ninja H2/H2R", ['price'] = 1000000, ['tipo'] = "vip" },

	["fenixdrift"] = { ['name'] = "BMW Fenix Drift", ['price'] = 1000, ['tipo'] = "vip" },
	["amaroktuning"] = { ['name'] = "Amarok Rebaixada", ['price'] = 1000000, ['tipo'] = "vip" },

	-- RMOD VIP
	["rmodi8ks"] = { ['name'] = "BMW i8 Coupe K.S Edition", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmoddarki8"] = { ['name'] = "BMW EVO i8 Dark Knight", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmodg65"] = { ['name'] = "Mercedes-Benz G65 AMG ", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmodlp670"] = { ['name'] = "Lamborghini LP670 LB", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmodrs6"] = { ['name'] = "Audi RS6 C8 2020", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmodsianr"] = { ['name'] = "Lamborghini Sian Roadster", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmodsuprapandem"] = { ['name'] = "Toyota GR Supra Pandem Rocket Bunny", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmodc63amg"] = { ['name'] = "Mercedes-AMG C63 S Coupe", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmodjesko"] = { ['name'] = "Koenigsegg Jesko", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmodgt63"] = { ['name'] = "BRABUS 800 Mercedes-AMG GT 63S", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmodbmwm8"] = { ['name'] = "BMW M8 Competition", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmodbugatti"] = { ['name'] = "Bugatti La Voiture Noire", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmodchiron300"] = { ['name'] = "Bugatti Chiron Super Sport 300+", ['price'] = 1000000, ['tipo'] = "vip" },
	["rmodf12tdf"] = { ['name'] = "Ferrari F12 TDF", ['price'] = 1000000, ['tipo'] = "vip" },

	-- RMOD CONCESSIONARIA
	["rmodzl1"] = { ['name'] = "Chevrolet Camaro ZL1 Widebody", ['price'] = 2500000, ['tipo'] = "carros" },
	["rmodcamaro"] = { ['name'] = "Chevrolet Camaro ZL1", ['price'] = 2300000, ['tipo'] = "carros" },
	["rmodz350pandem"] = { ['name'] = "Nissan 350Z RB", ['price'] = 1500000, ['tipo'] = "carros" },
	["rmode63s"] = { ['name'] = "BRABUS 800 - Mercedes-AMG E63 S", ['price'] = 2000000, ['tipo'] = "carros" },
	["rmodbentleygt"] = { ['name'] = "Bentley Continental GT", ['price'] = 1100000, ['tipo'] = "carros" },
	["rmodmk7"] = { ['name'] = "VW Golf MK7 Pandem", ['price'] = 1400000, ['tipo'] = "carros" },
	["rmodspeed"] = { ['name'] = "McLaren Speedtail", ['price'] = 1100000, ['tipo'] = "carros" },
	["rmodmartin"] = { ['name'] = "Aston Martin DBS Superleggera", ['price'] = 2200000, ['tipo'] = "carros" },
	["rmodbentley1"] = { ['name'] = "Bentley Continental GT Convertible Number 1", ['price'] = 1250000, ['tipo'] = "carros" },
	["rmodm5e34"] = { ['name'] = "BMW M5 E34", ['price'] = 1500000, ['tipo'] = "carros" },
	["rmodlfa"] = { ['name'] = "LEXUS LFA", ['price'] = 1100000, ['tipo'] = "carros" },
	["rmodjeep"] = { ['name'] = "Jeep Grand Cherokee Trackhawk ", ['price'] = 2500000, ['tipo'] = "carros" },
	["rmodbacalar"] = { ['name'] = "Bentley Mulliner Bacalar", ['price'] = 1250000, ['tipo'] = "carros" },
	
	-- MOTOS CONCE
	["faggio"] = { ['name'] = "Faggio", ['price'] = 100, ['tipo'] = "motos" },
	["biz25"] = { ['name'] = "Biz", ['price'] = 30000, ['tipo'] = "motos" },
	["pcj"] = { ['name'] = "Pcj", ['price'] = 100, ['tipo'] = "motos" },
	["150"] = { ['name'] = "Honda 150", ['price'] = 50000, ['tipo'] = "motos" },
	["ruffian"] = { ['name'] = "Ruffian", ['price'] = 100, ['tipo'] = "motos" },
	["vader"] = { ['name'] = "Vader", ['price'] = 100, ['tipo'] = "motos" },
	["nemesis"] = { ['name'] = "Nemesis", ['price'] = 100, ['tipo'] = "motos" },
	["lectro"] = { ['name'] = "Lectro", ['price'] = 100, ['tipo'] = "motos" },
	["bros60"] = { ['name'] = "Bros 160", ['price'] = 150000, ['tipo'] = "motos" },
	["defiler"] = { ['name'] = "Defiler", ['price'] = 100, ['tipo'] = "motos" },
	["vortex"] = { ['name'] = "Vortex", ['price'] = 100, ['tipo'] = "motos" },
	["ratbike"] = { ['name'] = "Ratbike", ['price'] = 100, ['tipo'] = "motos" },
	["diablous"] = { ['name'] = "Diablous", ['price'] = 100, ['tipo'] = "motos" },
	["enduro"] = { ['name'] = "Enduro", ['price'] = 200000, ['tipo'] = "motos" },
	["esskey"] = { ['name'] = "Esskey", ['price'] = 100, ['tipo'] = "motos" },
	["cliffhanger"] = { ['name'] = "Cliffhanger", ['price'] = 100, ['tipo'] = "motos" },
	["zombiea"] = { ['name'] = "Zombiea", ['price'] = 200000, ['tipo'] = "motos" },
	["nightblade"] = { ['name'] = "Nightblade", ['price'] = 100, ['tipo'] = "motos" },
	["diablous2"] = { ['name'] = "Diablous2", ['price'] = 100, ['tipo'] = "motos" },
	["hakuchou"] = { ['name'] = "Hakuchou", ['price'] = 340000, ['tipo'] = "motos" },
	["carbonrs"] = { ['name'] = "Carbonrs", ['price'] = 250000, ['tipo'] = "motos" },
	["manchez"] = { ['name'] = "Manchez", ['price'] = 200000, ['tipo'] = "motos" },
	["double"] = { ['name'] = "Double", ['price'] = 250000, ['tipo'] = "motos" },
	["gargoyle"] = { ['name'] = "Gargoyle", ['price'] = 200000, ['tipo'] = "motos" },
	["xt66"] = { ['name'] = "XT66", ['price'] = 500000, ['tipo'] = "motos" },
	["daemon"] = { ['name'] = "Daemon", ['price'] = 200000, ['tipo'] = "motos" },
	["sanchez2"] = { ['name'] = "Sanchez2", ['price'] = 250000, ['tipo'] = "motos" },
	["sanchez"] = { ['name'] = "Sanchez", ['price'] = 250000, ['tipo'] = "motos" },
	["chimera"] = { ['name'] = "Chimera", ['price'] = 200000, ['tipo'] = "motos" },
	["bf400"] = { ['name'] = "Bf400", ['price'] = 300000, ['tipo'] = "motos" },
	["bati"] = { ['name'] = "Bati", ['price'] = 320000, ['tipo'] = "motos" },
	["bati2"] = { ['name'] = "Bati2", ['price'] = 320000, ['tipo'] = "motos" },
	["akuma"] = { ['name'] = "Akuma", ['price'] = 330000, ['tipo'] = "motos" },
	["hakuchou2"] = { ['name'] = "Hakuchou2", ['price'] = 350000, ['tipo'] = "motos" },
	["sanctus"] = { ['name'] = "Sanctus", ['price'] = 100, ['tipo'] = "motos" },
	["cbrr"] = { ['name'] = "CBR 1000RR", ['price'] = 1150000, ['tipo'] = "motos" },
	["hornet"] = { ['name'] = "Hornet", ['price'] = 1000000, ['tipo'] = "motos" },
	["r6"] = { ['name'] = "Yamaha R6", ['price'] = 1250000, ['tipo'] = "motos" },
	["z1000"] = { ['name'] = "Z1000", ['price'] = 1300000, ['tipo'] = "motos" },
	["dm1200"] = { ['name'] = "Ducati 1200", ['price'] = 1500000, ['tipo'] = "motos" },

	--MOTOS
	["deathbike"] = { ['name'] = "deathbike", ['price'] = 500000, ['tipo'] = "motos" },
	["deathbike3"] = { ['name'] = "deathbike3", ['price'] = 500000, ['tipo'] = "motos" },
	["stryder"] = { ['name'] = "stryder", ['price'] = 500000, ['tipo'] = "motos" },
	["avarus"] = { ['name'] = "Avarus", ['price'] = 440000, ['tipo'] = "motos" },
	["bagger"] = { ['name'] = "Bagger", ['price'] = 300000, ['tipo'] = "motos" },
	["faggio2"] = { ['name'] = "Faggio2", ['price'] = 5000, ['tipo'] = "motos" },
	["fcr"] = { ['name'] = "Fcr", ['price'] = 390000, ['tipo'] = "motos" },
	["fcr2"] = { ['name'] = "Fcr2", ['price'] = 390000, ['tipo'] = "motos" },
	["hexer"] = { ['name'] = "Hexer", ['price'] = 250000, ['tipo'] = "motos" },
	["innovation"] = { ['name'] = "Innovation", ['price'] = 250000, ['tipo'] = "motos" },
	["sovereign"] = { ['name'] = "Sovereign", ['price'] = 285000, ['tipo'] = "motos" },
	["thrust"] = { ['name'] = "Thrust", ['price'] = 375000, ['tipo'] = "motos" },
	["vindicator"] = { ['name'] = "Vindicator", ['price'] = 340000, ['tipo'] = "motos" },
	["wolfsbane"] = { ['name'] = "Wolfsbane", ['price'] = 290000, ['tipo'] = "motos" },
	["zombieb"] = { ['name'] = "Zombieb", ['price'] = 300000, ['tipo'] = "motos" },
	["shotaro"] = { ['name'] = "Shotaro", ['price'] = 1000000, ['tipo'] = "motos" },
	["blazer"] = { ['name'] = "Blazer", ['price'] = 230000, ['tipo'] = "motos" },
	["blazer4"] = { ['name'] = "Blazer4", ['price'] = 370000, ['tipo'] = "motos" },
	["daemon2"]  = { ['name'] = "Daemon2", ['price'] = 310000, ['tipo'] = "motos" },
	
	-- VEÍCULOS VIP novos
	["africat"] = { ['name'] = "Honda Africa Twin", ['price'] = 1000000, ['tipo'] = "vip" },
	["m4lb"] = { ['name'] = "BMW M4 Libert Walk", ['price'] = 1000000, ['tipo'] = "vip" },
	["c7"] = { ['name'] = "Corvette C7", ['price'] = 1000000, ['tipo'] = "vip" },
	["r35"] = { ['name'] = "Nissan GT-R 35 Japan", ['price'] = 1000000, ['tipo'] = "vip" },
	["lwgtr"] = { ['name'] = "Nissan GT-R 35 Libert Walk", ['price'] = 1000000, ['tipo'] = "vip" },
	["golf75r"] = { ['name'] = "VW Golf R", ['price'] = 1000000, ['tipo'] = "vip" },
	["718b"] = { ['name'] = "Porsche 718 Boxster", ['price'] = 1000000, ['tipo'] = "vip" },
	["vwstance"] = { ['name'] = "VW Passati", ['price'] = 1000000, ['tipo'] = "vip" },
	["r820"] = { ['name'] = "Audi R8 2020", ['price'] = 1000000, ['tipo'] = "vip" },
	["urus2018"] = { ['name'] = "Lamborghini Urus", ['price'] = 1000000, ['tipo'] = "vip" },
	["ram2500"] = { ['name'] = "Dodge Ram 2500", ['price'] = 1000000, ['tipo'] = "vip" },

	-- VEÍCULOS VIP
	["q820"] = { ['name'] = "Audi Q8 50TDI 2020", ['price'] = 1000000, ['tipo'] = "vip" },
	["bmci"] = { ['name'] = "BMW M5", ['price'] = 1000000, ['tipo'] = "vip" },
	["f824slw"] = { ['name'] = "BMW M4 SLW", ['price'] = 1000000, ['tipo'] = "vip" },
	["lamborghinihuracan"] = { ['name'] = "Lamborghini Huracan", ['price'] = 1000000, ['tipo'] = "vip" },
	["corvette"] = { ['name'] = "Corvette", ['price'] = 1000000, ['tipo'] = "vip" },
	["nissangtrnismo"] = { ['name'] = "Nissan GTR Nismo", ['price'] = 1000000, ['tipo'] = "vip" },
	["nissanskyliner34"] = { ['name'] = "Nissan Skyline R34", ['price'] = 1000000, ['tipo'] = "vip" },
	["nissantitan17"] = { ['name'] = "Nissan Titan", ['price'] = 1000000, ['tipo'] = "vip" },
	["porsche992"] = { ['name'] = "Porsche 992", ['price'] = 1000000, ['tipo'] = "vip" },
	["msohs"] = { ['name'] = "McLaren MSOHS", ['price'] = 1000000, ['tipo'] = "vip" },
	["amggtr"] = { ['name'] = "Mercedes AMG GTR", ['price'] = 1000000, ['tipo'] = "vip" },
	["fxxkevo"] = { ['name'] = "Ferrari FXX-K Evo", ['price'] = 1000000, ['tipo'] = "vip" },
	["aperta"] = { ['name'] = "LaFerrari", ['price'] = 1000000, ['tipo'] = "vip" },
	["lp700r"] = { ['name'] = "Lamborghini Aventador", ['price'] = 1000000, ['tipo'] = "vip" },
	["i8"] = { ['name'] = "BMW I8", ['price'] = 1000000, ['tipo'] = "vip" },
	["bc"] = { ['name'] = "Pagani Zonda", ['price'] = 1000000, ['tipo'] = "vip" },
	["slsamg"] = { ['name'] = "Mercedes AMG SLS", ['price'] = 1000000, ['tipo'] = "vip" },
	["veneno"] = { ['name'] = "Lamborghini Veneno", ['price'] = 1000000, ['tipo'] = "vip" },
	["bugatti"] = { ['name'] = "Bugatti", ['price'] = 1000000, ['tipo'] = "vip" },
	["lancerevolutionx"] = { ['name'] = "Lancer Evolution 10", ['price'] = 1000000, ['tipo'] = "vip" },
	["r1"] = { ['name'] = "Yamaha R1", ['price'] = 1000000, ['tipo'] = "vip" },
	["bmws"] = { ['name'] = "BMW S1000", ['price'] = 1000000, ['tipo'] = "vip" },
	["r1250"] = { ['name'] = "BMW R1250", ['price'] = 1000000, ['tipo'] = "vip" },
	["ferrariitalia"] = { ['name'] = "Ferrari Italia 478", ['price'] = 1000000, ['tipo'] = "vip" },

	-- VEICULOS ALUGADOS
	["faggio3"] = { ['name'] = "Faggio3", ['price'] = 5000, ['tipo'] = "alugado" },
	
	-- ADDONS CARROS
	["audirs6"] = { ['name'] = "Audi RS6", ['price'] = 2550000, ['tipo'] = "import" },
	["bmwm3f80"] = { ['name'] = "BMW M3 F80", ['price'] = 100, ['tipo'] = "import" },
	["bmwm4gts"] = { ['name'] = "BMW M4 GTS", ['price'] = 100, ['tipo'] = "import" },
	["dodgechargersrt"] = { ['name'] = "Dodge Charger SRT", ['price'] = 100, ['tipo'] = "import" },
	["fordmustang"] = { ['name'] = "Ford Mustang", ['price'] = 2300000, ['tipo'] = "import" },
	["mazdarx7"] = { ['name'] = "Mazda RX7", ['price'] = 1300000, ['tipo'] = "import" },
	["nissan370z"] = { ['name'] = "Nissan 370Z", ['price'] = 1600000, ['tipo'] = "import" },
	["nissangtr"] = { ['name'] = "Nissan GTR", ['price'] = 1700000, ['tipo'] = "import" },
	["71gtx"] = { ['name'] = "Plymouth GTX", ['price'] = 750000, ['tipo'] = "import" },
	["180sx"] = { ['name'] = "Nissan 180SX", ['price'] = 600000, ['tipo'] = "import" },
	["911r"] = { ['name'] = "Porsche 911R", ['price'] = 2950000, ['tipo'] = "import" },
	["2018zl1"] = { ['name'] = "Camaro ZL1", ['price'] = 2300000, ['tipo'] = "import" },
	["19ftype"] = { ['name'] = "Jaguar F-type", ['price'] = 2650000, ['tipo'] = "import" },
	["db11"] = { ['name'] = "Aston Martin DB11", ['price'] = 2150000, ['tipo'] = "import" },
	["defiant"] = { ['name'] = "Dodge Charger", ['price'] = 650000, ['tipo'] = "import" },
	["fc15"] = { ['name'] = "Ferrari California", ['price'] = 3000000, ['tipo'] = "import" },
	["eclipse"] = { ['name'] = "Mitsubishi Eclipse", ['price'] = 1150000, ['tipo'] = "import" },
	["gt17"] = { ['name'] = "Ford GT", ['price'] = 2750000, ['tipo'] = "import" },
	["palameila"] = { ['name'] = "Porsche Panamera", ['price'] = 2450000, ['tipo'] = "import" },
	["rmodamgc63"] = { ['name'] = "Mercedes AMG C63-S", ['price'] = 2250000, ['tipo'] = "import" },
	["audirs7"] = { ['name'] = "AUDI RS7", ['price'] = 2550000, ['tipo'] = "import" },
	["hondafk8"] = { ['name'] = "Honda Civic Type R", ['price'] = 1200000, ['tipo'] = "import" },
	["lancerevolution9"] = { ['name'] = "Lancer Evolution 9", ['price'] = 1400000, ['tipo'] = "import" },
	["mercedesa45"] = { ['name'] = "Mercedes AMG A45", ['price'] = 2350000, ['tipo'] = "import" },
	["mustangmach1"] = { ['name'] = "Mustang Mach 1", ['price'] = 850000, ['tipo'] = "import" },
	["porsche930"] = { ['name'] = "Porsche 930", ['price'] = 950000, ['tipo'] = "import" },
	["raptor2017"] = { ['name'] = "Ford Raptor 2017", ['price'] = 2000000, ['tipo'] = "import" },
	["teslaprior"] = { ['name'] = "Tesla Prior", ['price'] = 1900000, ['tipo'] = "import" },
	["toyotasupra"] = { ['name'] = "Toyota Supra", ['price'] = 1500000, ['tipo'] = "import" },
	["italirsx"] = { ['name'] = "Itali RSX", ['price'] = 700000, ['tipo'] = "import" },

	-- CARROS QUE CARREGAM O PAREDÃO DE SOM
	["paredao"] = { ['name'] = "Paredão Pequeno", ['price'] = 100, ['tipo'] = "vip" },
	["SomMarqCULuz"] = { ['name'] = "Paredão Grande", ['price'] = 100, ['tipo'] = "vip" },
	["amarok"] = { ['name'] = "Amarok", ['price'] = 2100000, ['tipo'] = "vip" },
	["s10"] = { ['name'] = "S10", ['price'] = 1000000, ['tipo'] = "vip" },
	["19ram"] = { ['name'] = "Dodge RAM", ['price'] = 1000000, ['tipo'] = "vip" },
	["F250Deboxe"] = { ['name'] = "F250 Deboxe", ['price'] = 1000000, ['tipo'] = "vip" },

	-- BRASILEIROS
	["blista"] = { ['name'] = "GOL S 86", ['price'] = 130000, ['tipo'] = "carros" },
	["blista3"] = { ['name'] = "Voyage 86", ['price'] = 160000, ['tipo'] = "carros" },
	["fugitive"] = { ['name'] = "FIAT Palio", ['price'] = 100000, ['tipo'] = "carros" },
	["celta"] = { ['name'] = "Celta", ['price'] = 180000, ['tipo'] = "carros" },
	["civic2010"] = { ['name'] = "Civic 2010", ['price'] = 210000, ['tipo'] = "carros" },
	["civic2016"] = { ['name'] = "Civic 2016", ['price'] = 300000, ['tipo'] = "carros" },
	["focusrs"] = { ['name'] = "Ford Focus RS", ['price'] = 1800000, ['tipo'] = "carros" },
	["fusca"] = { ['name'] = "Fusca", ['price'] = 100, ['tipo'] = "carros" },
	["vwgolf"] = { ['name'] = "Golf", ['price'] = 240000, ['tipo'] = "carros" },
	["vwsava"] = { ['name'] = "Saveiro", ['price'] = 270000, ['tipo'] = "carros" },
	["brioso2"] = { ['name'] = "Fiat 500", ['price'] = 70000, ['tipo'] = "carros" },
	["weevil"] = { ['name'] = "Fusca", ['price'] = 70000, ['tipo'] = "vip" },
	["chevette"] = { ['name'] = "Chevette", ['price'] = 85000, ['tipo'] = "carros" },
	
	-- POLICIA
	["r820p"] = { ['name'] = "Audi R8", ['price'] = 1000, ['tipo'] = "work" },
	["VRa3"] = { ['name'] = "Audi A3", ['price'] = 1000, ['tipo'] = "work" },
	["VRa4"] = { ['name'] = "Audi A4", ['price'] = 1000, ['tipo'] = "work" },
	["VRq8"] = { ['name'] = "Audi Q8", ['price'] = 1000, ['tipo'] = "work" },
	["VRrs5"] = { ['name'] = "Audi RS5", ['price'] = 1000, ['tipo'] = "work" },
	["VRrs6"] = { ['name'] = "Audi RS6", ['price'] = 1000, ['tipo'] = "work" },
	["VRrs6av"] = { ['name'] = "Audi RS6 C8", ['price'] = 1000, ['tipo'] = "work" },
	["VRraptor"] = { ['name'] = "Ford Raptor", ['price'] = 1000, ['tipo'] = "work" },
	["VRtahoe"] = { ['name'] = "Chevrolet Tahoe", ['price'] = 1000, ['tipo'] = "work" },
	["VRdm1200"] = { ['name'] = "Ducati 1200", ['price'] = 1000, ['tipo'] = "work" },
	["corleo"] = { ['name'] = "Corvette PMFC", ['price'] = 1000, ['tipo'] = "work" },
	["pmfcevo9"] = { ['name'] = "Lancer Evo 10 Policia", ['price'] = 1000, ['tipo'] = "work" },
	["a45policia"] = { ['name'] = "Mercedes A45 Policia", ['price'] = 1000, ['tipo'] = "work" },
	["cls63s"] = { ['name'] = "Mercedes CLS 63 S", ['price'] = 1000, ['tipo'] = "work" },
	["sahpexplorer2"] = { ['name'] = "Explorer SAMU", ['price'] = 1, ['tipo'] = "work" },
	["dicgt63"] = { ['name'] = "Mercedes GT63s Desc.", ['price'] = 1000, ['tipo'] = "work" },
	["porschespeed"] = { ['name'] = "Porsche 718 Cayman S", ['price'] = 1000, ['tipo'] = "work" },
	["chevypolicia"] = { ['name'] = "Chevy PMFC", ['price'] = 1000, ['tipo'] = "work" },
	["bmwm5policia"] = { ['name'] = "BMW M5 PMFC", ['price'] = 1000, ['tipo'] = "work" },
	["av-gt63"] = { ['name'] = "Mercedes GT63 PMFC", ['price'] = 1000, ['tipo'] = "work" },
	["av-m8"] = { ['name'] = "BMW M8 PMFC", ['price'] = 1000, ['tipo'] = "work" },
	["paliopmrp1"] = { ['name'] = "Palio PMFC", ['price'] = 1000, ['tipo'] = "work" },
	["spin18rp"] = { ['name'] = "Spin PMFC", ['price'] = 1000, ['tipo'] = "work" },
	["spacerp"] = { ['name'] = "Space PMFC", ['price'] = 1000, ['tipo'] = "work" },
	["spin19rp"] = { ['name'] = "Spin PMFC", ['price'] = 1000, ['tipo'] = "work" },
	["trail19cfp"] = { ['name'] = "Trailblazer PMFC", ['price'] = 1000, ['tipo'] = "work" },
	["xtrocam"] = { ['name'] = "XTR Rocam PMFC", ['price'] = 1000, ['tipo'] = "work" },
	["xrerpm"] = { ['name'] = "XRE Rocam PMFC", ['price'] = 1000, ['tipo'] = "work" },
	["hilux15ft"] = { ['name'] = "Hilux Força PMFC", ['price'] = 1000, ['tipo'] = "work" },
	["as350"] = { ['name'] = "Heli AS350 PMFC", ['price'] = 1000, ['tipo'] = "work" },
	["trailnovarota"] = { ['name'] = "Trailblazer ROTA", ['price'] = 1000, ['tipo'] = "work" },
	["trailgarra1"] = { ['name'] = "Trailblazer GARRA", ['price'] = 1000, ['tipo'] = "work" },
	["sw4revrota1"] = { ['name'] = "SW4 ROTA", ['price'] = 1000, ['tipo'] = "work" },
	["trailrota2"] = { ['name'] = "Trailblazer ROTA", ['price'] = 1000, ['tipo'] = "work" },
	["trailcivileie"] = { ['name'] = "Trailblazer P.C.", ['price'] = 1000, ['tipo'] = "work" },
	["cruzeprf2"] = { ['name'] = "Cruze PRF 2020", ['price'] = 1000, ['tipo'] = "work" },
	["l200prf"] = { ['name'] = "L200 PRF", ['price'] = 1000, ['tipo'] = "work" },
	["trailprf"] = { ['name'] = "Trailblazer PRF", ['price'] = 1000, ['tipo'] = "work" },
	["ec130PRF"] = { ['name'] = "Helicoptero PRF", ['price'] = 1000, ['tipo'] = "work" },
	["sw4pc1"] = { ['name'] = "SW4 P.C.", ['price'] = 1000, ['tipo'] = "work" },
	["traildesc"] = { ['name'] = "Trail Desc. P.C.", ['price'] = 1000, ['tipo'] = "work" },
	["frogger2"] = { ['name'] = "Fogger Heli P.C.", ['price'] = 1000, ['tipo'] = "work" },
	["pbus"] = { ['name'] = "Onibus PMFC", ['price'] = 1000, ['tipo'] = "work" },
	["pbus2"] = { ['name'] = "Carro de SOM", ['price'] = 1000, ['tipo'] = "work" },
	["riot"] = { ['name'] = "Blindado PMFC", ['price'] = 1000, ['tipo'] = "work" },
	["polmav"] = { ['name'] = "Heli Polmav PMFC", ['price'] = 1000, ['tipo'] = "work" },
	["samumav"] = { ['name'] = "Helicoptero SAMU", ['price'] = 1000, ['tipo'] = "work" },
	["ambulance"] = { ['name'] = "Ambulância SAMU", ['price'] = 1000, ['tipo'] = "work" },
	["policeb"] = { ['name'] = "R1250 PMFC", ['price'] = 1000, ['tipo'] = "work" },
	-- Novas viaturas
	["20blazer2"] = { ['name'] = "Blazer F.T.", ['price'] = 1000, ['tipo'] = "work" },
	["police3"] = { ['name'] = "Spin PMFC", ['price'] = 1000, ['tipo'] = "work" },
	["spacepm1"] = { ['name'] = "Spacefox PMFC", ['price'] = 1000, ['tipo'] = "work" },
	["trailcfp"] = { ['name'] = "Trail PMFC", ['price'] = 1000, ['tipo'] = "work" },
	["trailpm1"] = { ['name'] = "Trail F.T.", ['price'] = 1000, ['tipo'] = "work" },
	-- VIATURAS TEMA PRÓPRIO
	["av-amarok"] = { ['name'] = "Amarok PMFC", ['price'] = 1000, ['tipo'] = "work" },
	["sbearcat"] = { ['name'] = "Blindado PMFC", ['price'] = 1000, ['tipo'] = "work" },
	["bmwg20"] = { ['name'] = "BMW G20 PMFC", ['price'] = 1000, ['tipo'] = "work" },
	["pdfocus"] = { ['name'] = "Ford Focus PMFC", ['price'] = 1000, ['tipo'] = "work" },
	["av-nc7"] = { ['name'] = "Honda 750X PMFC", ['price'] = 1000, ['tipo'] = "work" },
	["av-levante"] = { ['name'] = "Maserati Levante PMFC", ['price'] = 1000, ['tipo'] = "work" },
	["ghispo2"] = { ['name'] = "Maserati Ghibli PMFC", ['price'] = 1000, ['tipo'] = "work" },

	--TRABALHO
	["youga2"] = { ['name'] = "Youga2", ['price'] = 220000, ['tipo'] = "carros" },
	["felon2"] = { ['name'] = "Felon2", ['price'] = 1000, ['tipo'] = "work" },
	["slamtruck"] = { ['name'] = "Slam Truck", ['price'] = 1000, ['tipo'] = "work" },
	["seasparrow"] = { ['name'] = "Paramédico Helicóptero Água", ['price'] = 1000, ['tipo'] = "work" },
	["coach"] = { ['name'] = "Ônibus", ['price'] = 1000, ['tipo'] = "work" },
	["bus"] = { ['name'] = "Bus", ['price'] = 1000, ['tipo'] = "work" },
	["flatbed"] = { ['name'] = "Reboque SportRace", ['price'] = 1000, ['tipo'] = "work" },
	["flatbed3"] = { ['name'] = "Reboque Bennys", ['price'] = 1000, ['tipo'] = "work" },
	["towtruck"] = { ['name'] = "Reboque Guincho", ['price'] = 1000, ['tipo'] = "work" },
	["towtruck2"] = { ['name'] = "Towtruck2", ['price'] = 1000, ['tipo'] = "work" },
	["ratloader"] = { ['name'] = "Caminhão", ['price'] = 1000, ['tipo'] = "work" },
	["rubble"] = { ['name'] = "Caminhão", ['price'] = 1000, ['tipo'] = "work" },
	["taxi"] = { ['name'] = "Taxi", ['price'] = 10000, ['tipo'] = "carros" },
	["boxville4"] = { ['name'] = "Caminhão", ['price'] = 1000, ['tipo'] = "work" },
	["trash"] = { ['name'] = "Caminhão", ['price'] = 1000, ['tipo'] = "work" },
	["trash2"] = { ['name'] = "Caminhão", ['price'] = 1000, ['tipo'] = "work" },
	["tiptruck"] = { ['name'] = "Tiptruck", ['price'] = 1000, ['tipo'] = "work" },
	["scorcher"] = { ['name'] = "Scorcher", ['price'] = 1000, ['tipo'] = "work" },
	["tribike"] = { ['name'] = "Tribike", ['price'] = 1000, ['tipo'] = "work" },
	["tribike2"] = { ['name'] = "Tribike2", ['price'] = 1000, ['tipo'] = "work" },
	["tribike3"] = { ['name'] = "Tribike3", ['price'] = 1000, ['tipo'] = "work" },
	["fixter"] = { ['name'] = "Fixter", ['price'] = 1000, ['tipo'] = "work" },
	["cruiser"] = { ['name'] = "Cruiser", ['price'] = 1000, ['tipo'] = "work" },
	["bmx"] = { ['name'] = "Bmx", ['price'] = 1000, ['tipo'] = "work" },
	["dinghy"] = { ['name'] = "Dinghy", ['price'] = 1000, ['tipo'] = "work" },
	["jetmax"] = { ['name'] = "Jetmax", ['price'] = 1000, ['tipo'] = "work" },
	["marquis"] = { ['name'] = "Marquis", ['price'] = 1000, ['tipo'] = "work" },
	["seashark3"] = { ['name'] = "Seashark3", ['price'] = 1000, ['tipo'] = "work" },
	["speeder"] = { ['name'] = "Speeder", ['price'] = 1000, ['tipo'] = "work" },
	["speeder2"] = { ['name'] = "Speeder2", ['price'] = 1000, ['tipo'] = "work" },
	["surfboard"] = { ['name'] = "Prancha de Surf", ['price'] = 2000, ['tipo'] = "work" },
	["squalo"] = { ['name'] = "Squalo", ['price'] = 1000, ['tipo'] = "work" },
	["suntrap"] = { ['name'] = "Suntrap", ['price'] = 1000, ['tipo'] = "work" },
	["toro"] = { ['name'] = "Toro", ['price'] = 1000, ['tipo'] = "work" },
	["toro2"] = { ['name'] = "Toro2", ['price'] = 1000, ['tipo'] = "work" },
	["tropic"] = { ['name'] = "Tropic", ['price'] = 1000, ['tipo'] = "work" },
	["tropic2"] = { ['name'] = "Tropic2", ['price'] = 1000, ['tipo'] = "work" },
	["phantom"] = { ['name'] = "Phantom", ['price'] = 1000, ['tipo'] = "work" },
	["packer"] = { ['name'] = "Packer", ['price'] = 1000, ['tipo'] = "work" },
	["supervolito"] = { ['name'] = "Supervolito", ['price'] = 1000, ['tipo'] = "work" },
	["supervolito2"] = { ['name'] = "Supervolito2", ['price'] = 1000, ['tipo'] = "work" },
	["cuban800"] = { ['name'] = "Cuban800", ['price'] = 1000, ['tipo'] = "work" },
	["mammatus"] = { ['name'] = "Mammatus", ['price'] = 1000, ['tipo'] = "work" },
	["vestra"] = { ['name'] = "Vestra", ['price'] = 1000, ['tipo'] = "work" },
	["velum2"] = { ['name'] = "Velum2", ['price'] = 1000, ['tipo'] = "work" },
	["buzzard2"] = { ['name'] = "Buzzard2", ['price'] = 1000, ['tipo'] = "work" },
	["frogger"] = { ['name'] = "Heli Weazel", ['price'] = 1000, ['tipo'] = "work" },
	["tanker2"] = { ['name'] = "Gas", ['price'] = 1000, ['tipo'] = "work" },
	["armytanker"] = { ['name'] = "Diesel", ['price'] = 1000, ['tipo'] = "work" },
	["tvtrailer"] = { ['name'] = "Show", ['price'] = 1000, ['tipo'] = "work" },
	["trailerlogs"] = { ['name'] = "Woods", ['price'] = 1000, ['tipo'] = "work" },
	["tr4"] = { ['name'] = "Cars", ['price'] = 1000, ['tipo'] = "work" },
	["speedo"] = { ['name'] = "Speedo", ['price'] = 280000, ['tipo'] = "carros" },
	["primo2"] = { ['name'] = "Primo2", ['price'] = 200000, ['tipo'] = "work" },
	["tornado5"] = { ['name'] = "Tornado5", ['price'] = 200000, ['tipo'] = "work" },
	["gburrito"] = { ['name'] = "GBurrito", ['price'] = 200000, ['tipo'] = "work" },
	["gburrito2"] = { ['name'] = "GBurrito2", ['price'] = 320000, ['tipo'] = "work" },
	["slamvan2"] = { ['name'] = "Slamvan2", ['price'] = 200000, ['tipo'] = "work" },
	["cog55"] = { ['name'] = "Cog55", ['price'] = 200000, ['tipo'] = "work" },
	["superd"] = { ['name'] = "Superd", ['price'] = 200000, ['tipo'] = "work" },
	["btype"] = { ['name'] = "Btype", ['price'] = 200000, ['tipo'] = "work" },
	["tractor2"] = { ['name'] = "Tractor2", ['price'] = 1000, ['tipo'] = "work" },
	["rebel"] = { ['name'] = "Rebel", ['price'] = 1000, ['tipo'] = "work" },
	["volatus"] = { ['name'] = "Volatus", ['price'] = 100, ['tipo'] = "work" },
	["swift2"] = { ['name'] = "Swift2", ['price'] = 100, ['tipo'] = "work" },
	["luxor2"] = { ['name'] = "Luxor2", ['price'] = 100, ['tipo'] = "work" },
	["cargobob2"] = { ['name'] = "Cargo Bob", ['price'] = 1000000, ['tipo'] = "work" },		
	["hauler"] = { ['name'] = "Caminhão", ['price'] = 1000, ['tipo'] = "work" },	
	["hauler2"] = { ['name'] = "Caminhão", ['price'] = 1000, ['tipo'] = "work" },	
	["phantom"] = { ['name'] = "Caminhão", ['price'] = 1000, ['tipo'] = "work" },
	["benson"] = { ['name'] = "Benson", ['price'] = 2000000, ['tipo'] = "caminhoes" },
    ["mule"] = { ['name'] = "Mule", ['price'] = 800000, ['tipo'] = "caminhoes" },
    ["mule2"] = { ['name'] = "Mule2", ['price'] = 1500000, ['tipo'] = "caminhoes" },
    ["mule3"] = { ['name'] = "Mule 3", ['price'] = 850000, ['tipo'] = "caminhoes" },
    ["pounder"] = { ['name'] = "Pounder", ['price'] = 2500000, ['tipo'] = "caminhoes" },
	["terbyte"] = { ['name'] = "Terbyte", ['price'] = 1500000, ['tipo'] = "caminhoes" },

	-- NÃO USADOS
	["xj"] = { ['name'] = "XJ", ['price'] = 270000, ['tipo'] = "motos" },
	["verus"] = { ['name'] = "Triciclo", ['price'] = 100, ['tipo'] = "motos" },
	["sultan2"] = { ['name'] = "Sultan2", ['price'] = 5000, ['tipo'] = "carros" },
	["sugoi"] = { ['name'] = "Sugoi", ['price'] = 5000, ['tipo'] = "carros" },
	["furia"] = { ['name'] = "Furia", ['price'] = 5000, ['tipo'] = "carros" },
	["emperor"] = { ['name'] = "Emperor", ['price'] = 50000, ['tipo'] = "carros" },
	["emperor2"] = { ['name'] = "Emperor 2", ['price'] = 50000, ['tipo'] = "carros" },
	["dilettante"] = { ['name'] = "Dilettante", ['price'] = 60000, ['tipo'] = "carros" },
	["felon"] = { ['name'] = "Felon", ['price'] = 70000, ['tipo'] = "carros" },
	["ingot"] = { ['name'] = "Ingot", ['price'] = 160000, ['tipo'] = "carros" },
	["oracle"] = { ['name'] = "Oracle", ['price'] = 60000, ['tipo'] = "carros" },
	["sentinel"] = { ['name'] = "Sentinel", ['price'] = 50000, ['tipo'] = "carros" },
	["sentinel2"] = { ['name'] = "Sentinel2", ['price'] = 190000, ['tipo'] = "carros" },
	["windsor"] = { ['name'] = "Windsor", ['price'] = 150000, ['tipo'] = "carros" },
	["windsor2"] = { ['name'] = "Windsor2", ['price'] = 275000, ['tipo'] = "carros" },
	["zion2"] = { ['name'] = "Zion2", ['price'] = 60000, ['tipo'] = "carros" },
	["primo"] = { ['name'] = "Primo", ['price'] = 130000, ['tipo'] = "carros" },
	["chino"] = { ['name'] = "Chino", ['price'] = 130000, ['tipo'] = "carros" },
	["faction"] = { ['name'] = "Faction", ['price'] = 150000, ['tipo'] = "carros" },
	["faction3"] = { ['name'] = "Faction3", ['price'] = 350000, ['tipo'] = "carros" },
	["gauntlet2"] = { ['name'] = "Gauntlet2", ['price'] = 165000, ['tipo'] = "carros" },
	["hermes"] = { ['name'] = "Hermes", ['price'] = 280000, ['tipo'] = "carros" },
	["hotknife"] = { ['name'] = "Hotknife", ['price'] = 180000, ['tipo'] = "carros" },
	["moonbeam"] = { ['name'] = "Moonbeam", ['price'] = 220000, ['tipo'] = "carros" },
	["moonbeam2"] = { ['name'] = "Moonbeam2", ['price'] = 250000, ['tipo'] = "carros" },
	["nightshade"] = { ['name'] = "Nightshade", ['price'] = 270000, ['tipo'] = "carros" },
	["ruiner"] = { ['name'] = "Ruiner", ['price'] = 150000, ['tipo'] = "carros" },
	["sabregt"] = { ['name'] = "Sabregt", ['price'] = 260000, ['tipo'] = "carros" },
	["sabregt2"] = { ['name'] = "Sabregt2", ['price'] = 150000, ['tipo'] = "carros" },
	["slamvan"] = { ['name'] = "Slamvan", ['price'] = 180000, ['tipo'] = "carros" },
	["stalion"] = { ['name'] = "Stalion", ['price'] = 150000, ['tipo'] = "carros" },
	["stalion2"] = { ['name'] = "Stalion2", ['price'] = 150000, ['tipo'] = "carros" },
	["virgo"] = { ['name'] = "Virgo", ['price'] = 150000, ['tipo'] = "carros" },
	["virgo2"] = { ['name'] = "Virgo2", ['price'] = 250000, ['tipo'] = "carros" },
	["virgo3"] = { ['name'] = "Virgo3", ['price'] = 180000, ['tipo'] = "carros" },
	["voodoo"] = { ['name'] = "Voodoo", ['price'] = 220000, ['tipo'] = "carros" },
	["voodoo2"] = { ['name'] = "Voodoo2", ['price'] = 220000, ['tipo'] = "carros" },
	["yosemite"] = { ['name'] = "Yosemite", ['price'] = 350000, ['tipo'] = "carros" },
	["bfinjection"] = { ['name'] = "Bfinjection", ['price'] = 80000, ['tipo'] = "carros" },
	["bifta"] = { ['name'] = "Bifta", ['price'] = 190000, ['tipo'] = "carros" },
	["bodhi2"] = { ['name'] = "Bodhi2", ['price'] = 170000, ['tipo'] = "carros" },
	["brawler"] = { ['name'] = "Brawler", ['price'] = 250000, ['tipo'] = "carros" },
	["trophytruck"] = { ['name'] = "Trophytruck", ['price'] = 400000, ['tipo'] = "carros" },
	["trophytruck2"] = { ['name'] = "Trophytruck2", ['price'] = 400000, ['tipo'] = "carros" },
	["dubsta3"] = { ['name'] = "Dubsta3", ['price'] = 690000, ['tipo'] = "carros" },
	["rancherxl"] = { ['name'] = "Rancherxl", ['price'] = 220000, ['tipo'] = "carros" },
	["rebel2"] = { ['name'] = "Rebel2", ['price'] = 250000, ['tipo'] = "carros" },
	["riata"] = { ['name'] = "Riata", ['price'] = 250000, ['tipo'] = "carros" },
	["dloader"] = { ['name'] = "Dloader", ['price'] = 150000, ['tipo'] = "carros" },
	["sandking"] = { ['name'] = "Sandking", ['price'] = 400000, ['tipo'] = "carros" },
	["sandking2"] = { ['name'] = "Sandking2", ['price'] = 370000, ['tipo'] = "carros" },
	["baller"] = { ['name'] = "Baller", ['price'] = 150000, ['tipo'] = "carros" },
	["baller2"] = { ['name'] = "Baller2", ['price'] = 160000, ['tipo'] = "carros" },
	["baller3"] = { ['name'] = "Baller3", ['price'] = 175000, ['tipo'] = "carros" },
	["baller5"] = { ['name'] = "Baller5", ['price'] = 270000, ['tipo'] = "carros" },
	["baller6"] = { ['name'] = "Baller6", ['price'] = 900000, ['tipo'] = "carros" },
	["bjxl"] = { ['name'] = "Bjxl", ['price'] = 110000, ['tipo'] = "carros" },
	["cavalcade"] = { ['name'] = "Cavalcade", ['price'] = 110000, ['tipo'] = "carros" },
	["cavalcade2"] = { ['name'] = "Cavalcade2", ['price'] = 130000, ['tipo'] = "carros" },
	["contender"] = { ['name'] = "Contender", ['price'] = 670000, ['tipo'] = "carros" },
	["dubsta"] = { ['name'] = "Dubsta", ['price'] = 210000, ['tipo'] = "carros" },
	["fq2"] = { ['name'] = "Fq2", ['price'] = 110000, ['tipo'] = "carros" },
	["granger"] = { ['name'] = "Granger", ['price'] = 400000, ['tipo'] = "carros" },
	["gresley"] = { ['name'] = "Gresley", ['price'] = 150000, ['tipo'] = "carros" },
	["habanero"] = { ['name'] = "Habanero", ['price'] = 110000, ['tipo'] = "carros" },
	["seminole"] = { ['name'] = "Seminole", ['price'] = 110000, ['tipo'] = "carros" },
	["serrano"] = { ['name'] = "Serrano", ['price'] = 150000, ['tipo'] = "carros" },
	["xls2"] = { ['name'] = "Xls2", ['price'] = 900000, ['tipo'] = "carros" },
	["cog552"] = { ['name'] = "Cog552", ['price'] = 850000, ['tipo'] = "carros" },
	["cognoscenti2"] = { ['name'] = "Cognoscenti2", ['price'] = 850000, ['tipo'] = "carros" },
	["stanier"] = { ['name'] = "Stanier", ['price'] = 60000, ['tipo'] = "carros" },
	["stratum"] = { ['name'] = "Stratum", ['price'] = 90000, ['tipo'] = "carros" },
	["surge"] = { ['name'] = "Surge", ['price'] = 110000, ['tipo'] = "carros" },
	["tailgater"] = { ['name'] = "Tailgater", ['price'] = 110000, ['tipo'] = "carros" },
	["warrener"] = { ['name'] = "Warrener", ['price'] = 90000, ['tipo'] = "carros" },
	["washington"] = { ['name'] = "Washington", ['price'] = 130000, ['tipo'] = "carros" },
	["schafter6"] = { ['name'] = "Schafter6", ['price'] = 850000, ['tipo'] = "carros" },
	["blista2"] = { ['name'] = "Blista2", ['price'] = 55000, ['tipo'] = "carros" },
	["buffalo"] = { ['name'] = "Buffalo", ['price'] = 300000, ['tipo'] = "carros" },
	["buffalo3"] = { ['name'] = "Buffalo3", ['price'] = 300000, ['tipo'] = "carros" },
	["comet3"] = { ['name'] = "Comet3", ['price'] = 340000, ['tipo'] = "carros" },
	["comet4"] = { ['name'] = "Comet4", ['price'] = 320000, ['tipo'] = "carros" },
	["comet5"] = { ['name'] = "Comet5", ['price'] = 390000, ['tipo'] = "carros" },
	["feltzer2"] = { ['name'] = "Feltzer2", ['price'] = 255000, ['tipo'] = "carros" },
	["fusilade"] = { ['name'] = "Fusilade", ['price'] = 210000, ['tipo'] = "carros" },
	["massacro2"] = { ['name'] = "Massacro2", ['price'] = 330000, ['tipo'] = "carros" },
	["ninef2"] = { ['name'] = "Ninef2", ['price'] = 185000, ['tipo'] = "carros" },
	["omnis"] = { ['name'] = "Omnis", ['price'] = 240000, ['tipo'] = "carros" },
	["penumbra"] = { ['name'] = "Penumbra", ['price'] = 150000, ['tipo'] = "carros" },
	["rapidgt2"] = { ['name'] = "Rapidgt2", ['price'] = 240000, ['tipo'] = "carros" },
	["schafter3"] = { ['name'] = "Schafter3", ['price'] = 275000, ['tipo'] = "carros" },
	["schafter4"] = { ['name'] = "Schafter4", ['price'] = 275000, ['tipo'] = "carros" },
	["schafter5"] = { ['name'] = "Schafter5", ['price'] = 275000, ['tipo'] = "carros" },
	["schwarzer"] = { ['name'] = "Schwarzer", ['price'] = 170000, ['tipo'] = "carros" },
	["specter2"] = { ['name'] = "Specter2", ['price'] = 355000, ['tipo'] = "carros" },
	["streiter"] = { ['name'] = "Streiter", ['price'] = 250000, ['tipo'] = "carros" },
	["sultan"] = { ['name'] = "Sultan", ['price'] = 210000, ['tipo'] = "carros" },
	["tampa2"] = { ['name'] = "Tampa2", ['price'] = 200000, ['tipo'] = "carros" },
	["tropos"] = { ['name'] = "Tropos", ['price'] = 170000, ['tipo'] = "carros" },
	["verlierer2"] = { ['name'] = "Verlierer2", ['price'] = 380000, ['tipo'] = "carros" },
	["btype2"] = { ['name'] = "Btype2", ['price'] = 460000, ['tipo'] = "carros" },
	["btype3"] = { ['name'] = "Btype3", ['price'] = 390000, ['tipo'] = "carros" },
	["casco"] = { ['name'] = "Casco", ['price'] = 355000, ['tipo'] = "carros" },
	["coquette2"] = { ['name'] = "Coquette2", ['price'] = 285000, ['tipo'] = "carros" },
	["feltzer3"] = { ['name'] = "Feltzer3", ['price'] = 220000, ['tipo'] = "carros" },
	["gt500"] = { ['name'] = "Gt500", ['price'] = 250000, ['tipo'] = "carros" },
	["infernus2"] = { ['name'] = "Infernus2", ['price'] = 250000, ['tipo'] = "carros" },
	["jb700"] = { ['name'] = "Jb700", ['price'] = 220000, ['tipo'] = "carros" },
	["mamba"] = { ['name'] = "Mamba", ['price'] = 300000, ['tipo'] = "carros" },
	["manana"] = { ['name'] = "Manana", ['price'] = 130000, ['tipo'] = "carros" },
	["monroe"] = { ['name'] = "Monroe", ['price'] = 260000, ['tipo'] = "carros" },
	["peyote"] = { ['name'] = "Peyote", ['price'] = 150000, ['tipo'] = "carros" },
	["pigalle"] = { ['name'] = "Pigalle", ['price'] = 250000, ['tipo'] = "carros" },
	["rapidgt3"] = { ['name'] = "Rapidgt3", ['price'] = 220000, ['tipo'] = "carros" },
	["retinue"] = { ['name'] = "Retinue", ['price'] = 150000, ['tipo'] = "carros" },
	["stinger"] = { ['name'] = "Stinger", ['price'] = 220000, ['tipo'] = "carros" },
	["stingergt"] = { ['name'] = "Stingergt", ['price'] = 230000, ['tipo'] = "carros" },
	["torero"] = { ['name'] = "Torero", ['price'] = 160000, ['tipo'] = "carros" },
	["tornado"] = { ['name'] = "Tornado", ['price'] = 150000, ['tipo'] = "carros" },
	["tornado2"] = { ['name'] = "Tornado2", ['price'] = 160000, ['tipo'] = "carros" },
	["tornado6"] = { ['name'] = "Tornado6", ['price'] = 250000, ['tipo'] = "carros" },
	["turismo2"] = { ['name'] = "Turismo2", ['price'] = 250000, ['tipo'] = "carros" },
	["ztype"] = { ['name'] = "Ztype", ['price'] = 400000, ['tipo'] = "carros" },
	["autarch"] = { ['name'] = "Autarch", ['price'] = 760000, ['tipo'] = "carros" },
	["cheetah2"] = { ['name'] = "Cheetah2", ['price'] = 240000, ['tipo'] = "carros" },
	["fmj"] = { ['name'] = "Fmj", ['price'] = 520000, ['tipo'] = "carros" },
	["infernus"] = { ['name'] = "Infernus", ['price'] = 470000, ['tipo'] = "carros" },
	["nero2"] = { ['name'] = "Nero2", ['price'] = 480000, ['tipo'] = "carros" },
	["penetrator"] = { ['name'] = "Penetrator", ['price'] = 480000, ['tipo'] = "carros" },
	["sc1"] = { ['name'] = "Sc1", ['price'] = 495000, ['tipo'] = "carros" },
	["tyrus"] = { ['name'] = "Tyrus", ['price'] = 620000, ['tipo'] = "carros" },
	["voltic"] = { ['name'] = "Voltic", ['price'] = 440000, ['tipo'] = "carros" },
	["sadler"] = { ['name'] = "Sadler", ['price'] = 180000, ['tipo'] = "carros" },
	["bison"] = { ['name'] = "Bison", ['price'] = 220000, ['tipo'] = "carros" },
	["bison2"] = { ['name'] = "Bison2", ['price'] = 180000, ['tipo'] = "carros" },
	["bobcatxl"] = { ['name'] = "Bobcatxl", ['price'] = 260000, ['tipo'] = "carros" },
	["burrito"] = { ['name'] = "Burrito", ['price'] = 260000, ['tipo'] = "carros" },
	["burrito2"] = { ['name'] = "Burrito2", ['price'] = 260000, ['tipo'] = "carros" },
	["burrito3"] = { ['name'] = "Burrito3", ['price'] = 1000, ['tipo'] = "carros" },
	["burrito4"] = { ['name'] = "Burrito4", ['price'] = 260000, ['tipo'] = "carros" },
	["mule4"] = { ['name'] = "Burrito4", ['price'] = 260000, ['tipo'] = "carros" },
	["rallytruck"] = { ['name'] = "Burrito4", ['price'] = 260000, ['tipo'] = "carros" },
	["minivan"] = { ['name'] = "Minivan", ['price'] = 110000, ['tipo'] = "carros" },
	["minivan2"] = { ['name'] = "Minivan2", ['price'] = 220000, ['tipo'] = "carros" },
	["paradise"] = { ['name'] = "Paradise", ['price'] = 260000, ['tipo'] = "carros" },
	["pony"] = { ['name'] = "Pony", ['price'] = 260000, ['tipo'] = "carros" },
	["pony2"] = { ['name'] = "Pony2", ['price'] = 260000, ['tipo'] = "carros" },
	["rumpo"] = { ['name'] = "Van Weazel", ['price'] = 260000, ['tipo'] = "carros" },
	["rumpo2"] = { ['name'] = "Rumpo2", ['price'] = 260000, ['tipo'] = "carros" },
	["rumpo3"] = { ['name'] = "Rumpo3", ['price'] = 1000000, ['tipo'] = "carros" },
	["surfer"] = { ['name'] = "Surfer", ['price'] = 150000, ['tipo'] = "carros" },
	["surfer2"] = { ['name'] = "Surfer2", ['price'] = 100000, ['tipo'] = "carros" },
	["youga"] = { ['name'] = "Youga", ['price'] = 260000, ['tipo'] = "carros" },
	["landstalker"] = { ['name'] = "Landstalker", ['price'] = 130000, ['tipo'] = "carros" },
	["mesa"] = { ['name'] = "Mesa", ['price'] = 90000, ['tipo'] = "carros" },
	["radi"] = { ['name'] = "Radi", ['price'] = 110000, ['tipo'] = "carros" },
	["cheburek"] = { ['name'] = "Cheburek", ['price'] = 170000, ['tipo'] = "carros" },
	["hotring"] = { ['name'] = "Hotring", ['price'] = 300000, ['tipo'] = "carros" },
	["jester3"] = { ['name'] = "Jester3", ['price'] = 345000, ['tipo'] = "carros" },
	["michelli"] = { ['name'] = "Michelli", ['price'] = 160000, ['tipo'] = "carros" },
	["fagaloa"] = { ['name'] = "Fagaloa", ['price'] = 320000, ['tipo'] = "carros" },
	["dominator2"] = { ['name'] = "Dominator2", ['price'] = 230000, ['tipo'] = "carros" },
	["issi3"] = { ['name'] = "Issi3", ['price'] = 190000, ['tipo'] = "carros" },
	["gb200"] = { ['name'] = "Gb200", ['price'] = 195000, ['tipo'] = "carros" },
	["stretch"] = { ['name'] = "Stretch", ['price'] = 450000, ['tipo'] = "carros" },
	["guardian"] = { ['name'] = "Guardian", ['price'] = 750000, ['tipo'] = "carros" },
	["kamacho"] = { ['name'] = "Kamacho", ['price'] = 720000, ['tipo'] = "carros" },
	["italigtb2"] = { ['name'] = "Italigtb2", ['price'] = 610000, ['tipo'] = "carros" },
	["tezeract"] = { ['name'] = "Tezeract", ['price'] = 920000, ['tipo'] = "carros" },
	["patriot2"] = { ['name'] = "Patriot2", ['price'] = 500000, ['tipo'] = "carros" },
	["swinger"] = { ['name'] = "Swinger", ['price'] = 250000, ['tipo'] = "carros" },
	["clique"] = { ['name'] = "Clique", ['price'] = 360000, ['tipo'] = "carros" },
	["deviant"] = { ['name'] = "Deviant", ['price'] = 370000, ['tipo'] = "carros" },
	["impaler"] = { ['name'] = "Impaler", ['price'] = 320000, ['tipo'] = "carros" },
	["schlagen"] = { ['name'] = "Schlagen", ['price'] = 690000, ['tipo'] = "carros" },
	["vamos"] = { ['name'] = "Vamos", ['price'] = 320000, ['tipo'] = "carros" },
	["freecrawler"] = { ['name'] = "Freecrawler", ['price'] = 350000, ['tipo'] = "carros" },
	["glendale"] = { ['name'] = "Glendale", ['price'] = 70000, ['tipo'] = "carros" },
	["intruder"] = { ['name'] = "Intruder", ['price'] = 60000, ['tipo'] = "carros" },
	["le7b"] = { ['name'] = "Le7b", ['price'] = 700000, ['tipo'] = "carros" },
	["lurcher"] = { ['name'] = "Lurcher", ['price'] = 150000, ['tipo'] = "carros" },
	["phoenix"] = { ['name'] = "Phoenix", ['price'] = 250000, ['tipo'] = "carros" },
	["premier"] = { ['name'] = "Premier", ['price'] = 35000, ['tipo'] = "carros" },
	["raptor"] = { ['name'] = "Raptor", ['price'] = 300000, ['tipo'] = "carros" },
	["z190"] = { ['name'] = "Z190", ['price'] = 350000, ['tipo'] = "carros" },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEGLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.vehicleGlobal()
	return vehglobal
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLENAME
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.vehicleName(vname)
	return vehglobal[vname].name
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEPRICE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.vehiclePrice(vname)
	return vehglobal[vname].price
end


function vRP.clearInventory(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data then
		data.inventory = {}
	end
end

function tvRP.clearInventory()
	vRP.clearInventory(vRP.getUserId(source))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLETYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.vehicleType(vname)
	return vehglobal[vname].tipo
end

function vRP.openChest2(source,name,max_weight,cb_close,cb_in,cb_out)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		local identity = vRP.getUserIdentity(user_id)
		if data.inventory then
			if not chests[name] then
				local close_count = 0
				local chest = { max_weight = max_weight }
				chests[name] = chest 
				local cdata = vRP.getSData("chest:"..name)
				chest.items = json.decode(cdata) or {}

				local menu = { name = "Baú" }
				local cb_take = function(idname)
					local citem = chest.items[idname]
					local amount = vRP.prompt(source,"Quantidade:","")
					amount = parseInt(amount)
					if amount > 0 and amount <= citem.amount then
						local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight(idname)*amount
						if new_weight <= vRP.getInventoryMaxWeight(user_id) then
							vRP.giveInventoryItem(user_id,idname,amount)
							citem.amount = citem.amount - amount

							if citem.amount <= 0 then
								chest.items[idname] = nil
							end

							if cb_out then
								cb_out(idname,amount)
							end
							vRP.closeMenu(source)
						else
							TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.")
						end
					else
						TriggerClientEvent("Notify",source,"negado","Valor inválido.")
					end
				end

				local ch_take = function(player,choice)
					local weight = vRP.computeItemsWeight(chest.items)
					local submenu = build_itemlist_menu(string.format("%.2f",weight).." / "..max_weight.."kg",chest.items,cb_take)

					submenu.onclose = function()
						close_count = close_count - 1
						vRP.openMenu(player,menu)
					end
					close_count = close_count + 1
					vRP.openMenu(player,submenu)
				end

				local cb_put = function(idname)
					local amount = vRP.prompt(source,"Quantidade:","")
					amount = parseInt(amount)
					local new_weight = vRP.computeItemsWeight(chest.items)+vRP.getItemWeight(idname)*amount
					if new_weight <= max_weight then
						if amount > 0 and vRP.tryGetInventoryItem(user_id,idname,amount) then
							local citem = chest.items[idname]

							if citem ~= nil then
								citem.amount = citem.amount + amount
							else
								chest.items[idname] = { amount = amount }
							end

							if cb_in then
								cb_in(idname,amount)
							end
							vRP.closeMenu(source)
						end
					else
						TriggerClientEvent("Notify",source,"negado","Baú cheio.")
					end
				end

				local ch_put = function(player,choice)
					local weight = vRP.computeItemsWeight(data.inventory)
					local submenu = build_itemlist_menu(string.format("%.2f",weight).." / "..max_weight.."kg",data.inventory,cb_put)

					submenu.onclose = function()
						close_count = close_count-1
						vRP.openMenu(player,menu)
					end

					close_count = close_count+1
					vRP.openMenu(player,submenu)
				end

				menu["Retirar"] = { ch_take }
				menu["Colocar"] = { ch_put }

				menu.onclose = function()
					if close_count == 0 then
						vRP.setSData("chest:"..name,json.encode(chest.items))
						chests[name] = nil
						if cb_close then
							cb_close()
						end
					end
				end
				vRP.openMenu(source,menu)
			else
				TriggerClientEvent("Notify",source,"importante","O baú está sendo utilizado no momento.")
			end
		end
	end
end