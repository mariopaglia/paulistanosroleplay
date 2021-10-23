local discord_webhook4 = ""
local discord_webhook5 = ""
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local idgens = Tools.newIDGenerator()

vRPN = {}
Tunnel.bindInterface("vrp_inventory",vRPN)
Proxy.addInterface("vrp_inventory",vRPN)
vRPNclient = Tunnel.getInterface("vrp_player","vrp_player")

emP = {}
Tunnel.bindInterface("vrp_player",emP)

-- local logsitens = "https://discord.com/api/webhooks/793599139048980510/TgicubBv4Dhi21Gk8p6jLQLC5kT5y8Cje6qK8VLUpHd3lyufdiDDL229cQpp4JCTDfSS"
-- local logsenviar = "https://discord.com/api/webhooks/793600149590769685/-PHSTM2RRZkVfb1PIZcitPEByn0rd5ZeEyhs6IX3AJ1O1MPssKnZlhHMot6VTFbH6w_d"
-- local logscobrar = "https://discord.com/api/webhooks/793600242192220200/xChABlHgz09Kmro84R5i7773NydbQ504C8-5w8RX63mPKdVxxxXvp5wbNwiaQ-8DbWg4"
-- local webhooklinkinout = "https://discord.com/api/webhooks/794791807891669013/DOY3kVr1QmuN_0RBz3D_ZyFF1H6Wx-smJnLRByOXgT7EWHPigPr5xK11YXmohAtMZzdi"
-- local webhookpaypal = "https://discord.com/api/webhooks/800804690471813162/Q7nryy87L97UxJnsnEODRV4bx4s6aVqmlzxVYf91Hfgf_XXTUvlI-Rud_PRuJ9BCClR_"
-- local logcmdcall = "https://discord.com/api/webhooks/801616526405795881/MuVEYTGa-R2gQy_nO_9t7vH4wgtvS3ixcmZt5-O9aZqOcM5of15x2AJtcEE56YEJrbKM"
-- local ac_webhook = "https://discord.com/api/webhooks/800148956649750558/BYP4AcXNkOfOosRVVW7NUhPiM8WNDiKAoMn2g4-SUYFayTm-mHrrya4ppsF89aB8jUxS"
-- function SendWebhookMessage(webhook,message)
-- 	if webhook ~= nil and webhook ~= "" then
-- 		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
-- 	end
-- end


-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {
	-- Gerais
	["radio"] = { index = "radio", nome = "Radio" },
	["sacodelixo"] = { index = "sacodelixo", nome = "Saco de Lixo" },
	["garrafavazia"] = { index = "garrafavazia", nome = "Garrafa Vazia" },
	["garrafadeleite"] = { index = "garrafadeleite", nome = "Garrafa de Leite" },
	["roupas"] = { index = "roupas", nome = "Roupas" },
	["alianca"] = { index = "alianca", nome = "Aliança de Casamento" },
	["alianca2"] = { index = "alianca2", nome = "Aliança de Namoro" },
	["bandagem"] = { index = "bandagem", nome = "Bandagem" },
	["dinheirosujo"] = { index = "dinheirosujo", nome = "Dinheiro Sujo" },
	["repairkit"] = { index = "repairkit", nome = "Kit de Reparos" },
	["algemas"] = { index = "algemas", nome = "Algemas" },
	["capuz"] = { index = "capuz", nome = "Capuz" },
	["lockpick"] = { index = "lockpick", nome = "Lockpick" },
	["masterpick"] = { index = "masterpick", nome = "Masterpick" },
	["militec"] = { index = "militec", nome = "Militec" },
	["energetico"] = { index = "energetico", nome = "Energético" },
	["mochila"] = { index = "mochila", nome = "Mochila" },
	["c4"] = { index = "c4", nome = "C4" },
	["carbono"] = { index = "carbono", nome = "Carbono" },
	["celular"] = { index = "celular", nome = "Celular" },
	["placa"] = { index = "placa", nome = "Placa" },
	["pneu"] = { index = "pneu", nome = "Pneu" },
	["cartaoinvasao"] = { index = "cartaoinvasao", nome = "Cartão de Invasão" },
	["gps"] = { index = "gps", nome = "GPS" },
	["rosa"] = { index = "rosa", nome = "Rosa" },
	["morango"] = { index = "morango", nome = "Morango" },
	["tequila"] = { index = "tequila", nome = "Tequila" },
	["vodka"] = { index = "vodka", nome = "Vodka" },
	["cerveja"] = { index = "cerveja", nome = "Cerveja" },
	["whisky"] = { index = "whisky", nome = "Whisky" },
	["conhaque"] = { index = "conhaque", nome = "Conhaque" },
	["absinto"] = { index = "absinto", nome = "Absinto" },
	["corda"] = { index = "corda", nome = "Corda" },
	["adrenalina"] = { index = "adrenalina", nome = "Adrenalina" },
	["gopro"] = { index = "gopro", nome = "GoPro Hero 9" },
	["gravadordevoz"] = { index = "gravadordevoz", nome = "Gravador de Voz" },
	["ticketpvp"] = { index = "ticketpvp", nome = "Ticket PVP" },
	["raspadinha"] = { index = "raspadinha", nome = "Raspadinha" },
	["casino_token"] = { index = "casino_token", nome = "Ficha Casino" },
	["casino_ticket"] = { index = "casino_ticket", nome = "Ticket Roleta" },

	-- Sistema de PET
	["wammo|WEAPON_BALL"] = { index = "bolinha", nome = "Bolinha de PET" },
	["comidapet"] = { index = "comidapet", nome = "Comida de PET" },

	-- Fome e Sede
	["hamburguer"] = { index = "hamburguer", nome = "Hamburguer" },
	["sanduiche"] = { index = "sanduiche", nome = "Sanduiche" },
	["frangofrito"] = { index = "frangofrito", nome = "Frango Frito" },
	["batatafrita"] = { index = "batatafrita", nome = "Batata Frita" },
	["cachorroquente"] = { index = "cachorroquente", nome = "Cachorro Quente" },
	["pizza"] = { index = "pizza", nome = "Pizza" },
	["rosquinha"] = { index = "rosquinha", nome = "Rosquinha" },
	-- Bebidas
	["agua"] = { index = "agua", nome = "Água" },
	["mamadeira"] = { index = "mamadeira", nome = "Mamadeira" },
	["cafe"] = { index = "cafe", nome = "Café" },
	["cappuccino"] = { index = "cappuccino", nome = "Cappuccino" },
	["leite"] = { index = "leite", nome = "Leite" },
	["suco"] = { index = "suco", nome = "Suco" },
	["cocacola"] = { index = "cocacola", nome = "Cocacola" },
	["sprite"] = { index = "sprite", nome = "Sprite" },

	-- Farm Contrabando
	["componentemetal"] = { index = "componentemetal", nome = "Componentes de Metais" },
	["componenteeletronico"] = { index = "componenteeletronico", nome = "Componentes Eletrônicos" },
	["componenteplastico"] = { index = "componenteplastico", nome = "Componentes de Plásticos" },
	
	-- Itens do roubo a residencia
	["sapatosroubado"] = { index = "sapatosroubado", nome = "Sapatos Roubado" },
	["relogioroubado"] = { index = "relogioroubado", nome = "Relógio Roubado" },
	["anelroubado"] = { index = "anelroubado", nome = "Anel Roubado" },
	["colarroubado"] = { index = "colarroubado", nome = "Colar Roubado" },
	["notebookroubado"] = { index = "notebookroubado", nome = "Notebook Roubado" },
	["tabletroubado"] = { index = "tabletroubado", nome = "Tablet Roubado" },
	["vibradorroubado"] = { index = "vibradorroubado", nome = "Vibrador Roubado" },
	["carteiraroubada"] = { index = "carteiraroubada", nome = "Carteira Roubada" },
	["perfumeroubado"] = { index = "perfumeroubado", nome = "Perfume Roubado" },

	-- Pesca
	["isca"] = { index = "isca", nome = "Isca" },
	["dourado"] = { index = "dourado", nome = "Dourado" },
	["corvina"] = { index = "corvina", nome = "Corvina" },
	["salmao"] = { index = "salmao", nome = "Salmão" },
	["pacu"] = { index = "pacu", nome = "Pacu" },
	["pintado"] = { index = "pintado", nome = "Pintado" },
	["pirarucu"] = { index = "pirarucu", nome = "Pirarucu" },
	["tilapia"] = { index = "tilapia", nome = "Tilápia" },
	["tucunare"] = { index = "tucunare", nome = "Tucunaré" },
	["lambari"] = { index = "lambari", nome = "Lambari" },
	
	-- Farm de Lavagem
	["pendrivedeep"] = { index = "pendrivedeep", nome = "Pendrive Deepweb" },
	["placacircuito"] = { index = "placacircuito", nome = "Placa de Circuito" },
	["chipset"] = { index = "chipset", nome = "Chipset" },
	
	-- Farm de Drogas
	["adubo"] = { index = "adubo", nome = "Adubo" },
	["maconha"] = { index = "maconha", nome = "Maconha" },
	["heroina"] = { index = "heroina", nome = "Heroína" },
	["papouladeopio"] = { index = "papouladeopio", nome = "Papoula de Ópio" },
	["embalagem"] = { index = "embalagem", nome = "Embalagem" },
	["frasco"] = { index = "frasco", nome = "Frasco" },
	["frascodeplastico"] = { index = "frascodeplastico", nome = "Frasco de Plástico" },
	["anfetamina"] = { index = "anfetamina", nome = "Anfetamina" },
	["metanfetamina"] = { index = "metanfetamina", nome = "Metanfetamina" },
	["cocaina"] = { index = "cocaina", nome = "Cocaína" },
	["pastadecoca"] = { index = "pastadecoca", nome = "Pasta de Cocaina" },
	["pino"] = { index = "pino", nome = "Pino" },
	["lolo"] = { index = "lolo", nome = "Loló" },
	
	-- Farm Desmanche
	["ferramenta"] = { index = "ferramenta", nome = "Ferramenta" },
	["macarico"] = { index = "macarico", nome = "Maçarico" },
	["serra"] = { index = "serra", nome = "Serra" },
	["listadesmanche"] = { index = "listadesmanche", nome = "Lista Desmanche" },
	
	-- Farm de Armas
	["placademetal"] = { index = "placademetal", nome = "Placa de Metal" },
	["corpodeak"] = { index = "corpodeak", nome = "Corpo de AK-47" },
	["corpodefiveseven"] = { index = "corpodefiveseven", nome = "Corpo de Five Seven" },
	["corpodehkp7m10"] = { index = "corpodehkp7m10", nome = "Corpo de HK P7M10" },
	["corpodeg36"] = { index = "corpodeg36", nome = "Corpo de G36" },
	["corpodemp5"] = { index = "corpodemp5", nome = "Corpo de MP5" },
	["gatilho"] = { index = "gatilho", nome = "Gatilho" },
	["mola"] = { index = "mola", nome = "Mola" },
	-- metal de alta
	["metaldealta"] = { index = "metaldealta", nome = "Metal de Alta" },
	
	-- Farm de Munição
	["capsula"] = { index = "capsula", nome = "Cápsula" },
	["polvora"] = { index = "polvora", nome = "Pólvora" },
	
	-- Farm de Colete
	["tecido"] = { index = "tecido", nome = "Tecido" },
	["malha"] = { index = "malha", nome = "Malha" },
	["colete"] = { index = "colete", nome = "Colete Balístico" },
	["linha"] = { index = "linha", nome = "Linha" },
	
	-- Mineração (Não refinados)
	["ametista2"] = { index = "ametista2", nome = "Min. Ametista" },
	["bronze2"] = { index = "bronze2", nome = "Min. Bronze" },
	["diamante2"] = { index = "diamante2", nome = "Min. Diamante" },
	["esmeralda2"] = { index = "esmeralda2", nome = "Min. Esmeralda" },
	["ferro2"] = { index = "ferro2", nome = "Min. Ferro" },
	["ouro2"] = { index = "ouro2", nome = "Min. Ouro" },
	["rubi2"] = { index = "rubi2", nome = "Min. Rubi" },
	["safira2"] = { index = "safira2", nome = "Min. Safira" },
	["topazio2"] = { index = "topazio2", nome = "Min. Topazio" },

	-- Mineração (Refinados)
	["ametista"] = { index = "ametista", nome = "Ametista" },
	["bronze"] = { index = "bronze", nome = "Bronze" },
	["diamante"] = { index = "diamante", nome = "Diamante" },
	["esmeralda"] = { index = "esmeralda", nome = "Esmeralda" },
	["ferro"] = { index = "ferro", nome = "Ferro" },
	["ouro"] = { index = "ouro", nome = "Ouro" },
	["rubi"] = { index = "rubi", nome = "Rubi" },
	["safira"] = { index = "safira", nome = "Safira" },
	["topazio"] = { index = "topazio", nome = "Topazio" },
	
	-- Armas
	["wbody|WEAPON_DAGGER"] = { index = "adaga", nome = "Adaga" },
	["wbody|WEAPON_BAT"] = { index = "beisebol", nome = "Taco de Beisebol" },
	["wbody|WEAPON_BOTTLE"] = { index = "garrafa", nome = "Garrafa" },
	["wbody|WEAPON_CROWBAR"] = { index = "cabra", nome = "Pé de Cabra" },
	["wbody|WEAPON_FLASHLIGHT"] = { index = "lanterna", nome = "Lanterna" },
	["wbody|WEAPON_GOLFCLUB"] = { index = "golf", nome = "Taco de Golf" },
	["wbody|WEAPON_HAMMER"] = { index = "martelo", nome = "Martelo" },
	["wbody|WEAPON_HATCHET"] = { index = "machado", nome = "Machado" },
	["wbody|WEAPON_KNUCKLE"] = { index = "ingles", nome = "Soco-Inglês" },
	["wbody|WEAPON_KNIFE"] = { index = "faca", nome = "Faca" },
	["wbody|WEAPON_MACHETE"] = { index = "machete", nome = "Machete" },
	["wbody|WEAPON_SWITCHBLADE"] = { index = "canivete", nome = "Canivete" },
	["wbody|WEAPON_NIGHTSTICK"] = { index = "cassetete", nome = "Cassetete" },
	["wbody|WEAPON_WRENCH"] = { index = "grifo", nome = "Chave de Grifo" },
	["wbody|WEAPON_BATTLEAXE"] = { index = "batalha", nome = "Machado de Batalha" },
	["wbody|WEAPON_POOLCUE"] = { index = "sinuca", nome = "Taco de Sinuca" },
	["wbody|WEAPON_STONE_HATCHET"] = { index = "pedra", nome = "Machado de Pedra" },
	["wbody|WEAPON_PISTOL"] = { index = "m1911", nome = "M1911" },
	["wbody|WEAPON_APPISTOL"] = { index = "vp9", nome = "Koch VP9" },
	["wbody|WEAPON_STUNGUN"] = { index = "tazer", nome = "Tazer" },
	["wbody|WEAPON_BULLPUPRIFLE_MK2"] = { index = "famas", nome = "FAMAS" },
	["wbody|WEAPON_VINTAGEPISTOL"] = { index = "m1922", nome = "M1922" },
	["wbody|WEAPON_REVOLVER"] = { index = "magnum44", nome = "Magnum 44" },
	["wbody|WEAPON_REVOLVER_MK2"] = { index = "magnum357", nome = "Magnum 357" },
	["wbody|GADGET_PARACHUTE"] = { index = "paraquedas", nome = "Paraquedas" },
	["wbody|WEAPON_FIREEXTINGUISHER"] = { index = "extintor", nome = "Extintor" },
	["wbody|WEAPON_MICROSMG"] = { index = "uzi", nome = "Uzi" },
	-- ["wbody|WEAPON_SMG"] = { index = "mp5", nome = "MP5" },
	["wbody|WEAPON_ASSAULTSMG"] = { index = "mtar21", nome = "MTAR-21" },
	["wbody|WEAPON_SAWNOFFSHOTGUN"] = { index = "shotgun", nome = "Shotgun" },
	["wammo|WEAPON_SAWNOFFSHOTGUN"] = { index = "m-shotgun", nome = "Munição de Shotgun" },
	["wbody|WEAPON_MACHINEPISTOL"] = { index = "tec9", nome = "Tec-9" },
	["wammo|WEAPON_MACHINEPISTOL"] = { index = "m-tec9", nome = "Munição de Tec-9" },
	["wbody|WEAPON_ASSAULTRIFLE"] = { index = "ak103", nome = "AK-103" },
	["wbody|WEAPON_BULLPUPRIFLE_MK2"] = { index = "famas", nome = "FAMAS" },
	["wbody|WEAPON_GUSENBERG"] = { index = "thompson", nome = "Thompson" },
	["wammo|WEAPON_PISTOL"] = { index = "m-m1911", nome = "Munição de M1911" },
	["wammo|WEAPON_APPISTOL"] = { index = "m-vp9", nome = "Munição de Koch VP9" },
	["wammo|WEAPON_STUNGUN"] = { index = "m-tazer", nome = "Munição de Tazer" },
	["wammo|WEAPON_VINTAGEPISTOL"] = { index = "m-m1922", nome = "Munição de M1922" },
	["wammo|GADGET_PARACHUTE"] = { index = "m-paraquedas", nome = "Munição de Paraquedas" },
	["wammo|WEAPON_FIREEXTINGUISHER"] = { index = "m-extintor", nome = "Munição de Extintor" },
	-- ["wammo|WEAPON_SMG"] = { index = "m-mp5", nome = "Munição de MP5" },
	["wammo|WEAPON_ASSAULTRIFLE"] = { index = "m-ak103", nome = "Munição de AK-103" },
	["wammo|WEAPON_GUSENBERG"] = { index = "m-thompson", nome = "Munição de Thompson" },
	["wammo|WEAPON_PETROLCAN"] = { index = "combustivel", nome = "Combustível" },
	["wbody|WEAPON_PETROLCAN"] = { index = "gasolina", nome = "Galão de Gasolina" },
	["wammo|WEAPON_PETROLCAN"] = { index = "m-gasolina", nome = "Combustível" },
	["wbody|WEAPON_RAYPISTOL"] = { index = "raypistol", nome = "Raypistol" },
	["wammo|WEAPON_MICROSMG"] = { index = "m-uzi", nome = "Munição de UZI" },
	["wammo|WEAPON_ASSAULTSMG"] = { index = "m-mtar21", nome = "Munição de MTAR-21" },
	["wammo|WEAPON_BULLPUPRIFLE_MK2"] = { index = "m-famas", nome = "Munição de FAMAS" },
	["wammo|WEAPON_REVOLVER_MK2"] = { index = "m-magnum357", nome = "Munição de MAGNUM-357" },
	
	-- Armas Policia
	["wbody|WEAPON_CARBINERIFLE_MK2"] = { index = "m4a1", nome = "M4A1" },
	["wbody|WEAPON_CARBINERIFLE"] = { index = "ar15", nome = "AR-15" },
	["wbody|WEAPON_COMBATPDW"] = { index = "sigsauer", nome = "Sig Sauer MPX" },
	["wbody|WEAPON_COMBATPISTOL"] = { index = "glock", nome = "Glock" },
	["wbody|WEAPON_SPECIALCARBINE"] = { index = "g36x", nome = "G36x" },
	["wbody|WEAPON_PUMPSHOTGUN_MK2"] = { index = "remington", nome = "Remington 870" },
	-- Munição Policia
	["wammo|WEAPON_CARBINERIFLE_MK2"] = { index = "m-m4a1", nome = "Munição de M4A1" },
	["wammo|WEAPON_CARBINERIFLE"] = { index = "m-ar15", nome = "Munição de AR-15" },
	["wammo|WEAPON_COMBATPDW"] = { index = "m-sigsauer", nome = "Munição de Sig Sauer" },
	["wammo|WEAPON_COMBATPISTOL"] = { index = "m-glock", nome = "Munição de Glock" },
	["wammo|WEAPON_SPECIALCARBINE"] = { index = "m-g36x", nome = "Munição de G36x" },
	["wammo|WEAPON_PUMPSHOTGUN_MK2"] = { index = "m-remington", nome = "Munição de Remington 870" },
	
	-- armas novas
	["wbody|WEAPON_MUSKET"] = { index = "mosinnagant", nome = "Mosin Nagant" },
	["wbody|WEAPON_SAWNOFFSHOTGUN"] = { index = "mossberg500", nome = "Mossberg 500" },
	["wbody|WEAPON_MINISMG"] = { index = "czscorpion", nome = "CZ Scorpion" },
	["wbody|WEAPON_SNSPISTOL"] = { index = "hkp7m10", nome = "HK P7M10" },

	-- municoes novas
	["wammo|WEAPON_MUSKET"] = { index = "m-mosinnagant", nome = "Munição de Mosin Nagant" },
	["wammo|WEAPON_SAWNOFFSHOTGUN"] = { index = "m-mossberg500", nome = "Munição de Mossberg 500" },
	["wammo|WEAPON_MINISMG"] = { index = "m-czscorpion", nome = "Munição de CZ Scorpion" },
	["wammo|WEAPON_SNSPISTOL"] = { index = "m-hkp7m10", nome = "Munição de HK P7M10" },

	-- Pistol do porte
	["wbody|WEAPON_PISTOL"] = { index = "m1911", nome = "M1911" },
	["wammo|WEAPON_PISTOL"] = { index = "m-m1911", nome = "Munição de M1911" },

	-- Armas Ilegal
	["wbody|WEAPON_ASSAULTRIFLE_MK2"] = { index = "ak47", nome = "AK-47" },
	["wbody|WEAPON_SPECIALCARBINE_MK2"] = { index = "g36", nome = "G36" },
	["wbody|WEAPON_SMG_MK2"] = { index = "mp5", nome = "MP5" },
	["wbody|WEAPON_PISTOL_MK2"] = { index = "fiveseven", nome = "Five Seven" },
	-- Munição Ilegal
	["wammo|WEAPON_ASSAULTRIFLE_MK2"] = { index = "m-ak47", nome = "Munição de AK-47" },
	["wammo|WEAPON_SPECIALCARBINE_MK2"] = { index = "m-g36", nome = "Munição de G36" },
	["wammo|WEAPON_SMG_MK2"] = { index = "m-mp5", nome = "Munição de MP5" },
	["wammo|WEAPON_PISTOL_MK2"] = { index = "m-fiveseven", nome = "Munição de Five Seven" }
	
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('item',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"item.permissao") then
		if args[1] and args[2] and itemlist[args[1]] ~= nil then
			vRP.giveInventoryItem(user_id,args[1],parseInt(args[2]))
			vRP.Log("```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[CRIOU]: "..args[1].."\n[QNT]: "..args[2]..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."```", "CMD_ITEM")
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECAR PERMISSÃO DO COMANDO /COR
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,'corarma.permissao')
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- /mascara
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mascara',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setmascara",source,args[1],args[2])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /blusa
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('blusa',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setblusa",source,args[1],args[2])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /colete
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('colete',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setcolete",source,args[1],args[2])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /jaqueta
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('jaqueta',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setjaqueta",source,args[1],args[2])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /maos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('maos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setmaos",source,args[1],args[2])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /calca
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('calca',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setcalca",source,args[1],args[2])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /acessorios
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('acessorios',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setacessorios",source,args[1],args[2])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /sapatos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('sapatos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setsapatos",source,args[1],args[2])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /chapeu
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('chapeu',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setchapeu",source,args[1],args[2])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /oculos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('oculos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setoculos",source,args[1],args[2])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /mochila
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mochila',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setmochila",source,args[1],args[2])
				end
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECAR PERMISSÃO ANIMAÇÕES (CAVALINHO/CARREGAR)
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermAnimacao()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,'vip.permissao')
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- GUARDAR COLETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('gcolete',function(source,args,rawCommand)
	vRP.antiflood(source,"/gcolete",2)
    local source = source
    local user_id = vRP.getUserId(source)
	local armourlevel = vRPclient.getArmour(source)
	local descricao = vRP.prompt(source,"Deseja guardar seu colete?  DIGITE: sim","")
	
	if not vRP.hasPermission(user_id,"policia.permissao") and not vRP.hasPermission(user_id,"nogarmas.permissao") then 
		if descricao == "sim" or descricao == "Sim" or descricao == "SIM" then
			if vRPclient.getHealth(source) > 101 then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("colete") <= vRP.getInventoryMaxWeight(user_id) then        
					if armourlevel == 100 then
						if not vRPclient.isHandcuffed(source) then
							if not vRP.searchReturn(source,user_id) then
								if user_id then
									vRPclient.setArmour(source, 0)
									TriggerClientEvent("tirandocolete",source,args[10],args[20])
									vRP.giveInventoryItem(user_id,'colete',1)
								end
							end
						else
							TriggerClientEvent("Notify",source,"negado","Esta algemado!")
						end
					elseif armourlevel > 0 and armourlevel <= 99 then
						TriggerClientEvent("Notify",source,"negado","Seu colete esta danificado se deseja retirar execute o comando '/jcolete'") 
					else
						TriggerClientEvent("Notify",source,"negado","Colete não encontrado!") 
					end
				else
					TriggerClientEvent("Notify",source,"negado","Seu colete não cabe em sua mochila!") 
				end
			else
				TriggerClientEvent("Notify",source,"negado","Morto não se meche!")
			end    
		end
	else
		TriggerClientEvent("Notify",source,"negado","Policiais não podem guardar seus coletes")
	end
    
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- JOGAR FORA O COLETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('jcolete',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local armour = vRPclient.getArmour(player)
	if armour >= 1 and armour <= 99 then
       vRPclient.setArmour(source,0)
       TriggerClientEvent("tirandocolete",player)
       TriggerClientEvent("Notify",source,"sucesso","Você jogou fora o seu <b>Colete</b>.")
       vRPclient._playAnim(player,true,{{"pickup_object","pickup_low",1}},false)
    else
       TriggerClientEvent("Notify",source,"negado","Seu <b>colete</b> nao está <b>danificado</b> ou você <b>não possui</b> um colete")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUG CRIAÇÃO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Instanced then
			for _, player in ipairs(GetActivePlayers()) do
				local otherPlayerPed = GetPlayerPed(player)
				
				if otherPlayerPed ~= PlayerPedId() then
					SetEntityLocallyInvisible(otherPlayerPed)
					SetEntityNoCollisionEntity(PlayerPedId(),  otherPlayerPed,  true)
				end
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK ROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkRoupas()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id,"roupavip.permissao") then
			return true 
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui <b>Roupas</b> na mochila.") 
			return false
		end
	end
end

function emP.checkPermVip()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id,"roupavip.permissao") then
			return true 
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui o item <b>Roupas</b> ou então um <b>Plano VIP</b> compatível.") 
			return false
		end
	end
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- /REVISTAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('revistar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	if nuser_id then
		local identity = vRP.getUserIdentity(user_id)
		local weapons = vRPclient.getWeapons(nplayer)
		local money = vRP.getMoney(nuser_id)
		local data = vRP.getUserDataTable(nuser_id)

		if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"kick.permissao") then

			TriggerClientEvent('cancelando',source,true)
			TriggerClientEvent('cancelando',nplayer,true)
			TriggerClientEvent('carregar',nplayer,source)
			--vRPclient._playAnim(source,false,{{"misscarsteal4@director_grip","end_loop_grip"}},true)
			vRPclient._playAnim(nplayer,false,{{"random@mugging3","handsup_standing_base"}},true)
			TriggerClientEvent("progress",source,5000,"revistando")
			SetTimeout(5000,function()
			
				TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5M O C H I L A^4  - - - - - - - - - - - - - - - - - - - - - - - - - - -  [  ^3"..string.format("%.2f",vRP.getInventoryWeight(nuser_id)).."kg^4  /  ^3"..string.format("%.2f",vRP.getInventoryMaxWeight(nuser_id)).."kg^4  ]  - -")
				if data and data.inventory then
					for k,v in pairs(data.inventory) do
						TriggerClientEvent('chatMessage',source,"",{},"     "..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k))
					end
				end
				TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5E Q U I P A D O^4  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
				for k,v in pairs(weapons) do
					if v.ammo < 1 then
						TriggerClientEvent('chatMessage',source,"",{},"     1x "..vRP.itemNameList("wbody|"..k))
					else
						TriggerClientEvent('chatMessage',source,"",{},"     1x "..vRP.itemNameList("wbody|"..k).." | "..vRP.format(parseInt(v.ammo)).."x Munições")
					end
				end
			
				--vRPclient._stopAnim(source,false)
				vRPclient._stopAnim(nplayer,false)
				TriggerClientEvent('cancelando',source,false)
				TriggerClientEvent('cancelando',nplayer,false)
				-- TriggerClientEvent('carregar',nplayer,source)
				TriggerClientEvent('chatMessage',source,"",{},"    Carteira: R$ "..vRP.format(parseInt(money)).."")
			end)
			-- TriggerClientEvent("Notify",nplayer,"aviso","Você está sendo <b>Revistado</b>.")
			TriggerClientEvent("Notify",nplayer,"aviso","Revistado por <b>"..identity.name.." "..identity.firstname.."</b>.",8000)
		else
			if vRP.request(nplayer,"Você está sendo revistado, deseja aceitar?",30) then
				TriggerClientEvent('cancelando',source,true)
				TriggerClientEvent('cancelando',nplayer,true)
				-- TriggerClientEvent('carregar',nplayer,source)
				--vRPclient._playAnim(source,false,{{"misscarsteal4@director_grip","end_loop_grip"}},true)
				vRPclient._playAnim(nplayer,false,{{"random@mugging3","handsup_standing_base"}},true)
				TriggerClientEvent("progress",source,5000,"revistando")
				SetTimeout(5000,function()
				
					TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5M O C H I L A^4  - - - - - - - - - - - - - - - - - - - - - - - - - - -  [  ^3"..string.format("%.2f",vRP.getInventoryWeight(nuser_id)).."kg^4  /  ^3"..string.format("%.2f",vRP.getInventoryMaxWeight(nuser_id)).."kg^4  ]  - -")
					if data and data.inventory then
						for k,v in pairs(data.inventory) do
							TriggerClientEvent('chatMessage',source,"",{},"     "..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k))
						end
					end
					TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5E Q U I P A D O^4  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
					for k,v in pairs(weapons) do
						if v.ammo < 1 then
							TriggerClientEvent('chatMessage',source,"",{},"     1x "..vRP.itemNameList("wbody|"..k))
						else
							TriggerClientEvent('chatMessage',source,"",{},"     1x "..vRP.itemNameList("wbody|"..k).." | "..vRP.format(parseInt(v.ammo)).."x Munições")
						end
					end
				
					--vRPclient._stopAnim(source,false)
					vRPclient._stopAnim(nplayer,false)
					TriggerClientEvent('cancelando',source,false)
					TriggerClientEvent('cancelando',nplayer,false)
					-- TriggerClientEvent('carregar',nplayer,source)
					TriggerClientEvent('chatMessage',source,"",{},"    Carteira: R$ "..vRP.format(parseInt(money)).."")
				end)
				-- TriggerClientEvent("Notify",nplayer,"aviso","Você está sendo <b>Revistado</b>.")
				TriggerClientEvent("Notify",nplayer,"aviso","Revistado por <b>"..identity.name.." "..identity.firstname.."</b>.",8000)
			else
				TriggerClientEvent("Notify",source,"aviso","A pessoa está resistindo a revista",8000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCARJACK
-----------------------------------------------------------------------------------------------------------------------------------------
local veiculos = {}
veiculos["CLONADOS"] = true
RegisterServerEvent("TryDoorsEveryone")
AddEventHandler("TryDoorsEveryone",function(veh,doors,placa)
	if not veiculos[placa] then
		TriggerClientEvent("SyncDoorsEveryone",-1,veh,doors)
		veiculos[placa] = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AFKSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterServerEvent("kickAFK")
-- AddEventHandler("kickAFK",function()
-- 	local source = source
-- 	local user_id = vRP.getUserId(source)
-- 	if not vRP.hasPermission(user_id,"staff.permissao") then
-- 		DropPlayer(source,"Voce foi desconectado por ficar ausente.")
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /SEQUESTRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('sequestro',function(source,args,rawCommand)
	local nplayer = vRPclient.getNearestPlayer(source,5)
	if nplayer then
		if vRPclient.isHandcuffed(nplayer) then
			if not vRPclient.getNoCarro(source) then
				local vehicle = vRPclient.getNearestVehicle(source,7)
				if vehicle then
					if vRPclient.getCarroClass(source,vehicle) then
						vRPclient.setMalas(nplayer)
					end
				end
			elseif vRPclient.isMalas(nplayer) then
				vRPclient.setMalas(nplayer)
			end
		else
			TriggerClientEvent("Notify",source,"importante","A pessoa precisa estar algemada para colocar ou retirar do Porta-Malas.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRATAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tratamento',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"paramedico.permissao") or vRP.hasPermission(user_id,"founder.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,3)
		if nplayer then
			-- if vRPNclient.isNearCds(source, vector3(323.8,-593.75,43.29), 30) or vRPNclient.isNearCds(source, vector3(722.09,162.63,80.72), 30) then
				TriggerClientEvent('tratamento',nplayer)
				TriggerClientEvent("Notify",nplayer,"sucesso","Tratamento iniciado, aguarde a liberação do paramédico.")
				TriggerClientEvent("Notify",source,"sucesso","Tratamento no paciente iniciado com sucesso.")
			-- else
			-- 	TriggerClientEvent("Notify",source,"negado","Tratamento deve ser realizado somente no hospital")
			-- end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENVIAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('enviar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	local identity = vRP.getUserIdentity(user_id)
	local identityu = vRP.getUserIdentity(nuser_id)
	local crds = GetEntityCoords(GetPlayerPed(source))
	if nuser_id and args[1] and parseInt(args[2]) > 0 then
		for k,v in pairs(itemlist) do
			if args[1] == v.index then
				if vRP.getInventoryWeight(nuser_id)+vRP.getItemWeight(k)*parseInt(args[2]) <= vRP.getInventoryMaxWeight(nuser_id) then
					if vRP.tryGetInventoryItem(user_id,k,parseInt(args[2])) then
						vRP.giveInventoryItem(nuser_id,k,parseInt(args[2]))
						vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
						TriggerClientEvent("Notify",source,"sucesso","Enviou <b>"..parseInt(args[2]).."x "..v.nome.."</b>.")
						TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>"..parseInt(args[2]).."x "..v.nome.."</b>.")
						vRP.Log("```Player "..user_id.." enviou(por comando) o item: "..k.. " para o ID "..nuser_id.." [QTD]: "..args[2].."\n[COORDENADA]: "..crds.x..","..crds.y..","..crds.z.."```", "CMD_ENVIAR")
						vRP.logs("savedata/enviar.txt","[ID]: "..user_id.." / [NID]: "..nuser_id.." / [ITEM]: "..k)
						-- TriggerEvent('logs:ToDiscord', discord_webhook , "ENVIAR", "```Player "..user_id.." enviou(por comando) o item: "..k.. " para o ID "..nuser_id.." [QTD]: "..args[2].."```", "https://www.tumarcafacil.com/wp-content/uploads/2017/06/RegistroDeMarca-01-1.png", false, false)
					end
				end
			end
		end
	elseif nuser_id and parseInt(args[1]) > 0 then
		if vRP.tryPayment(user_id,parseInt(args[1])) then
			vRP.giveMoney(nuser_id,parseInt(args[1]))
			vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
			TriggerClientEvent("Notify",source,"sucesso","Enviou <b>R$"..vRP.format(parseInt(args[1])).." reais</b>.")
			TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>R$"..vRP.format(parseInt(args[1])).." reais</b>.")
			vRP.Log("```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ENVIOU]: R$ "..vRP.format(parseInt(args[1])).." \n[PARA O ID]: "..nuser_id.." "..identityu.name.." "..identityu.firstname.."\n[COORDENADA]: "..crds.x..","..crds.y..","..crds.z..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```", "CMD_ENVIAR")
		else
			TriggerClientEvent("Notify",source,"negado","Não tem a quantia que deseja enviar.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COBRAR
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand('cobrar',function(source,args,rawCommand)
--     vRP.antiflood(source,"cobrar",2)
--     local user_id = vRP.getUserId(source)
--     local consulta = vRPclient.getNearestPlayer(source,2)
--     local nuser_id = vRP.getUserId(consulta)
--     local resultado = json.decode(consulta) or 0
--     local identity =  vRP.getUserIdentity(user_id)
--     local identityu = vRP.getUserIdentity(nuser_id)
-- 	local crds = GetEntityCoords(GetPlayerPed(source))
--     if vRP.request(consulta,"Deseja pagar <b>R$ "..vRP.format(parseInt(args[1])).."</b> para <b>"..identity.name.." "..identity.firstname.."</b>?",30) then    
--         if parseInt(args[1]) > 0 then                
--             local banco = vRP.getBankMoney(nuser_id)
        
--             if banco >= parseInt(args[1]) then
--                 vRP.setBankMoney(nuser_id,parseInt(banco-args[1]))
--                 vRP.giveBankMoney(user_id,parseInt(args[1]))
            
--                 TriggerClientEvent("Notify",source,"sucesso","Recebeu <b>R$ "..vRP.format(parseInt(args[1])).."</b> de <b>"..identityu.name.. " "..identityu.firstname.."</b>.")
--                 local player = vRP.getUserSource(parseInt(args[2]))
--                 if player == nil then
--                     return
--                 else
--                     local identity = vRP.getUserIdentity(user_id)
--                     TriggerClientEvent("Notify",player,"importante","<b>"..identity.name.." "..identity.firstname.."</b> transferiu <b>R$ "..vRP.format(parseInt(args[1])).."</b> para sua conta.")
-- 					SendWebhookMessage(logscobrar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COBROU]: R$ "..vRP.format(parseInt(args[1])).." \n[DO ID]: "..nuser_id.." "..identityu.name.." "..identityu.firstname.."\n[COORDENADA]: "..crds.x..","..crds.y..","..crds.z..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
--                 end            
--             else    
--                 TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
--             end    
--         end
--     end
-- end) 
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARMAS
-----------------------------------------------------------------------------------------------------------------------------------------
local garmas={} 
RegisterCommand('garmas',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    if GetPlayerRoutingBucket(source) == 0 then

    TriggerClientEvent("Notify",source,"aviso","<b>Aguarde</b><br>Suas armas estão sendo desequipadas.",9500)
    garmas[user_id] = true
    SetTimeout(5000,function()
        if user_id then
            if not vRP.hasPermission(user_id,"policia.permissao") and not vRP.hasPermission(user_id,"nogarmas.permissao") then 
                local weapons = vRPclient.replaceWeapons(source,{})
                for k,v in pairs(weapons) do
                    vRP.giveInventoryItem(user_id,"wbody|"..k,1)
                    if v.ammo > 0 then
                        vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
                    end
                end
				TriggerClientEvent("Notify",source,"sucesso","Guardou seu armamento na mochila.")
			else
				TriggerClientEvent("Notify",source,"negado","Policiais não podem guardar armas, limpe suas armas no arsenal")
            end
        end
    end)
    SetTimeout(3000, function()
        garmas[user_id] = nil
    end)    
end
end)

AddEventHandler('playerDropped', function (reason)
    local user_id = vRP.getUserId(source)
    -- print('Player ' .. GetPlayerName(source) ..' ['..vRP.getUserId(source).. '] dropped (Reason: ' .. reason .. ')')
    if reason == "Exiting" or "Disconnect"  then 
		if checkId(user_id) then
			local identity = vRP.getUserIdentity(user_id)
			local webhookbanimento = "https://discord.com/api/webhooks/800148956649750558/BYP4AcXNkOfOosRVVW7NUhPiM8WNDiKAoMn2g4-SUYFayTm-mHrrya4ppsF89aB8jUxS"
			vRP.setBanned(parseInt(user_id),true)
    		vRP.setWhitelisted(parseInt(user_id),false)
			vRP.kick(user_id,"Você foi banido da cidade.")
			vRP.Log("```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[MOTIVO]: Bugando /garmas"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."```", "AC_BAN")
        end
    end
end)
function checkId(user_id)
    local status = false
    for k,v in pairs(garmas) do
        if v == user_id then
            garmas[v] = nil
            status = true
            break
        else
            status = false
        end    
    end
    return status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYTOW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trytow")
AddEventHandler("trytow",function(nveh,rveh)
	TriggerClientEvent("synctow",-1,nveh,rveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trytrunk")
AddEventHandler("trytrunk",function(nveh)
	TriggerClientEvent("synctrunk",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WINS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trywins")
AddEventHandler("trywins",function(nveh)
	TriggerClientEvent("syncwins",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryhood")
AddEventHandler("tryhood",function(nveh)
	TriggerClientEvent("synchood",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydoors")
AddEventHandler("trydoors",function(nveh,door)
	TriggerClientEvent("syncdoors",-1,nveh,door)
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- CALL
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- local blips = {}
-- RegisterCommand('call',function(source,args,rawCommand)
-- 	local source = source
-- 	local answered = false
-- 	local user_id = vRP.getUserId(source)
-- 	if user_id then
-- 		local players = {}
-- 		if args[1] == "adm" then
-- 			players = vRP.getUsersByPermission("staff.permissao")
-- 		-- else args[1] == "190" then
-- 		-- 	players = vRP.getUsersByPermission("policia.permissao")
-- 		-- elseif args[1] == "192" then
-- 		-- 	players = vRP.getUsersByPermission("paramedico.permissao")
-- 		-- elseif args[1] == "mec" then
-- 		-- 	players = vRP.getUsersByPermission("mecanico.permissao")
-- 		-- elseif args[1] == "taxi" then
-- 		-- 	players = vRP.getUsersByPermission("taxista.permissao")
-- 		-- elseif args[1] == "adv" then
-- 		-- 	players = vRP.getUsersByPermission("judiciario.permissao")
-- 		else
-- 			TriggerClientEvent("Notify",source,"negado","Serviço inexistente ou disponível somente pelo <b>Celular</b>")
-- 			return
-- 		end

-- 		local descricao = vRP.prompt(source,"Descrição:","")
-- 		if descricao == "" then
-- 			return
-- 		end

-- 		local identitys = vRP.getUserIdentity(user_id)
-- 		local crds = GetEntityCoords(GetPlayerPed(source))
-- 		TriggerClientEvent("Notify",source,"sucesso","Chamado enviado com sucesso.")
-- 		vRP.Log("```prolog\n[ID]: "..user_id.." "..identitys.name.." "..identitys.firstname.." \n[CHAMOU]: "..args[1].."\n[MENSAGEM]: '"..descricao.."'\n[COORDENADA]: "..crds.x..","..crds.y..","..crds.z..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."```", "CMD_CALL")
-- 		for l,w in pairs(players) do
-- 			local player = vRP.getUserSource(parseInt(w))
-- 			local nuser_id = vRP.getUserId(player)
-- 			local x,y,z = vRPclient.getPosition(source)
-- 			local uplayer = vRP.getUserSource(user_id)
			

-- 			if player and player ~= uplayer then
-- 				async(function()
-- 					vRPclient.playSound(player,"Out_Of_Area","DLC_Lowrider_Relay_Race_Sounds")
-- 					TriggerClientEvent('chatMessage',player,"CHAMADO",{255,0,0},"Enviado por ^1"..identitys.name.." "..identitys.firstname.."^0 ["..user_id.."]: "..descricao)
-- 					local ok = vRP.request(player,"Aceitar o chamado de <b>"..identitys.name.." "..identitys.firstname.."</b>?",30)
-- 					if ok then
-- 						if not answered then
-- 							answered = true
-- 							local identity = vRP.getUserIdentity(nuser_id)
-- 							vRP.Log("```prolog\n[QUEM ACEITOU]: "..nuser_id.." "..identity.name.." "..identity.firstname.." \n[CHAMADO]:"..descricao.."\n[FEITO POR]: "..user_id.." "..identitys.name.." "..identitys.firstname..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."```", "CALL_ADM_ATENDIDO")
-- 							-- TriggerClientEvent("Notify",source,"importante","Chamado atendido por <b>"..identity.name.." "..identity.firstname.."</b>, aguarde no local.")
-- 							TriggerClientEvent("Notify",source,"importante","Chamado atendido, aguarde no local.")
-- 							vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
-- 							vRPclient._setGPS(player,x,y)
-- 						else
-- 							TriggerClientEvent("Notify",player,"negado","Chamado ja foi atendido por outra pessoa.")
-- 							vRPclient.playSound(player,"CHECKPOINT_MISSED","HUD_MINI_GAME_SOUNDSET")
-- 						end
-- 					end
-- 					local id = idgens:gen()
-- 					blips[id] = vRPclient.addBlip(player,x,y,z,358,71,"Chamado",0.6,false)
-- 					SetTimeout(300000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
-- 				end)
-- 			end
-- 		end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- P
-----------------------------------------------------------------------------------------------------------------------------------------
local policia = {}
RegisterCommand('p',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local uplayer = vRP.getUserSource(user_id)
	local identity = vRP.getUserIdentity(user_id)
	local x,y,z = vRPclient.getPosition(source)
	if vRPclient.getHealth(source) > 100 then
		if vRP.hasPermission(user_id,"policia.permissao") then
			local soldado = vRP.getUsersByPermission("policia.permissao")
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player and player ~= uplayer then
					async(function()
						local id = idgens:gen()
						policia[id] = vRPclient.addBlip(player,x,y,z,161,3,"Localização de "..identity.name.." "..identity.firstname,0.5,false)
						TriggerClientEvent("Notify",player,"importante","Localização recebida de <b>"..identity.name.." "..identity.firstname.."</b>.")
						vRPclient._playSound(player,"Out_Of_Bounds_Timer","DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
						SetTimeout(60000,function() vRPclient.removeBlip(player,policia[id]) idgens:free(id) end)
					end)
				end
			end
			TriggerClientEvent("Notify",source,"sucesso","Localização enviada com sucesso.")
			vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /PAYPAL
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand('paypal',function(source,args,rawCommand)
-- 	local user_id = vRP.getUserId(source)
-- 	local identity = vRP.getUserIdentity(user_id)
-- 	if user_id then
-- 		if args[1] == "sacar" and parseInt(args[2]) > 0 then
-- 			vRP.antiflood(source,"/paypal sacar",2)
-- 			local consulta = vRP.getUData(user_id,"vRP:paypal")
-- 			local resultado = json.decode(consulta) or 0
-- 			local fixbug = vRP.prompt(source,"Confirmaçao(Digite Sim):","")
-- 			if fixbug == "sim" then
-- 			if resultado >= parseInt(args[2]) then
-- 				vRP.giveBankMoney(user_id,parseInt(args[2]))
-- 				vRP.setUData(user_id,"vRP:paypal",json.encode(parseInt(resultado-args[2])))
-- 				TriggerClientEvent("Notify",source,"sucesso","Efetuou o saque de <b>R$"..vRP.format(parseInt(args[2])).." reais</b> da sua conta paypal.")
-- 				SendWebhookMessage(webhookpaypal,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SACOU]: R$ "..vRP.format(parseInt(args[2]))..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
-- 			else
-- 				TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente em sua conta paypal.")
-- 				end
-- 			end
-- 		end
-- 	end
-- 	local user_id = vRP.getUserId(source)
-- 	local identity = vRP.getUserIdentity(user_id)
-- 	if user_id then
-- 	if args[1] == "trans" and parseInt(args[2]) > 0 and parseInt(args[3]) > 0 then
-- 	vRP.antiflood(source,"/paypal trans",3)
-- 	local consulta = vRP.getUData(parseInt(args[2]),"vRP:paypal")
-- 	local resultado = json.decode(consulta) or 0
-- 	local banco = vRP.getBankMoney(user_id)
-- 	local identityu = vRP.getUserIdentity(parseInt(args[2]))
-- 	if vRP.request(source,"Deseja transferir <b>R$"..vRP.format(parseInt(args[3])).."</b> reais para <b>"..identityu.name.." "..identityu.firstname.."</b>?",30) then
-- 		if banco >= parseInt(args[3]) then
-- 			vRP.setBankMoney(user_id,parseInt(banco-args[3]))
-- 			vRP.setUData(parseInt(args[2]),"vRP:paypal",json.encode(parseInt(resultado+args[3])))
-- 			TriggerClientEvent("Notify",source,"sucesso","Enviou <b>R$ "..vRP.format(parseInt(args[3])).." reais</b> ao passaporte <b>"..vRP.format(parseInt(args[2])).."</b>.")
-- 			SendWebhookMessage(webhookpaypal,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ENVIOU]: R$ "..vRP.format(parseInt(args[3])).." \n[PARA O ID]: "..parseInt(args[2]).." "..identityu.name.." "..identityu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
-- 			local player = vRP.getUserSource(parseInt(args[2]))
-- 			if player == nil then
-- 				return
-- 			else
-- 				local identity = vRP.getUserIdentity(user_id)
-- 				TriggerClientEvent("Notify",player,"importante","<b>"..identity.name.." "..identity.firstname.."</b> transferiu <b>R$"..vRP.format(parseInt(args[3])).." reais</b> para sua conta do paypal.")
-- 			end
-- 		else
-- 			TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
-- 				end
-- 			end
-- 		end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /FAC (MEMBROS ONLINE DE CADA ORGANIZAÇÃO)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('fac',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)        
	if vRP.hasPermission(user_id,"founder.permissao") then
		local onlinePlayers2 = GetNumPlayerIndices()
		-- Drogas
		local roxos = vRP.getUsersByPermission("roxos.permissao")
    	local verdes = vRP.getUsersByPermission("verdes.permissao")
    	local laranjas = vRP.getUsersByPermission("laranjas.permissao")
    	local vermelhos = vRP.getUsersByPermission("vermelhos.permissao")
		-- Armas
    	local sinaloa = vRP.getUsersByPermission("sinaloa.permissao")
		local yakuza = vRP.getUsersByPermission("yakuza.permissao")
		local cn = vRP.getUsersByPermission("cn.permissao")
		-- Lavagem
		local irmandade = vRP.getUsersByPermission("irmandade.permissao")
		local triade = vRP.getUsersByPermission("triade.permissao")
		local salieris = vRP.getUsersByPermission("salieris.permissao")
		TriggerClientEvent("Notify",source,"importante","<b>Jogadores:</b> "..onlinePlayers2.."<br><b>Roxos:</b> "..#roxos.."<br><b>Verdes:</b> "..#verdes.."<br><b>Laranjas:</b> "..#laranjas.."<br><b>Vermelhos:</b> "..#vermelhos.."<br><b>Sinaloa:</b> "..#sinaloa.."<br><b>Yakuza:</b> "..#yakuza.."<br><b>CN:</b> "..#cn.."<br><b>Irmandade:</b> "..#irmandade.."<br><b>Triade:</b> "..#triade.."<br><b>Salieri's:</b> "..#salieris.."",9000)
	end
end)	
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEIJO SINCRONIZADO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("beijar",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRPclient.getNearestPlayer(source,2)
    if nplayer then
        local pedido = vRP.request(nplayer,"Deseja iniciar o beijo ?",10)
        if pedido then
            vRPclient.playAnim(source,true,{{"mp_ped_interaction","kisses_guy_a"}},false)    
            vRPclient.playAnim(nplayer,true,{{"mp_ped_interaction","kisses_guy_b"}},false)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- IDP (ID DO JOGADOR PRÓXIMO)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('idp',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRPclient.getNearestPlayer(source,5)
    if nplayer then
        local nuser_id = vRP.getUserId(nplayer)
        TriggerClientEvent("Notify",source,"importante","Jogador próximo: "..nuser_id.."")
		TriggerClientEvent("Notify",nplayer,"importante","O <b>ID "..user_id.."</b> está pegando o seu ID")
    else
        TriggerClientEvent("Notify",source,"aviso","Nenhum Jogador Próximo")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOGS DE ENTRADA E SAÍDA COM COORDENADAS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerJoin",function(user_id,source,name,last_login)
	local identity = vRP.getUserIdentity(user_id)
	if identity ~= nil then
		vRP.Log("```"..os.date("[%d/%m/%Y %H:%M:%S]").." "..identity.name.." "..identity.firstname.." [".. user_id .."] entrou```", "ENTRADA_SAIDA")
	end
end)

AddEventHandler("vRP:playerLeave",function(user_id, source)
	local crds = GetEntityCoords(GetPlayerPed(source))
	local identity = vRP.getUserIdentity(user_id)
	vRP.Log("```"..os.date("[%d/%m/%Y %H:%M:%S]").." "..identity.name.." "..identity.firstname.." [".. user_id .."] saiu na coordenada: "..crds.x..","..crds.y..","..crds.z.."```", "ENTRADA_SAIDA")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- BANIR CASO UTILIZE O COMANDO _CRASH
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('playerDropped', function (reason)
    local user_id = vRP.getUserId(source)
    -- print('Player ' .. GetPlayerName(source) ..' ['..vRP.getUserId(source).. '] dropped (Reason: ' .. reason .. ')')
    if reason == "Game crashed: gta-core-five.dll!CrashCommand (0x0)" then
        vRP.setBanned(user_id,true)
		vRP.setWhitelisted(parseInt(user_id),false)
		vRP.kick(user_id,"Você foi banido da cidade.")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /BVIDA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("bvida")
AddEventHandler("bvida",function()
    local source = source
    local user_id = vRP.getUserId(source)
    local bvida = vRP.prompt(source,"Digite SIM para confirmar o bvida!(Digite: SIM)","")
    if bvida == "sim" or bvida == "SIM" or bvida == "Sim" then
        local identity = vRP.getUserIdentity(user_id)
        Wait(2)
        vRPclient._setCustomization(source,vRPclient.getCustomization(source))
		Citizen.Wait(1000)
		TriggerClientEvent("reloadtattos",source)
        vRP.removeCloak(source)
    end
end)

------------------------------------------------------------
--  CARREGAR NO OMBRO
----------------------------------------------------------------
RegisterServerEvent('cmg2_animations:sync654654654')
AddEventHandler('cmg2_animations:sync654654654', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget)
	vRP.antiflood(source,"cmg2_animations:sync654654654",3)
	function getDistance(coords, ncoords) return #(vector3(coords.x, coords.y, coords.z) - vector3(ncoords.x, ncoords.y, ncoords.z))end

	local ped = GetPlayerPed(source) 
	local loc = GetEntityCoords(ped) 
	local nped = GetPlayerPed(targetSrc) 
	local nloc = GetEntityCoords(nped)
	
	if(getDistance(nloc,loc)<8)then	
		TriggerClientEvent('cmg2_animations:syncTarget654654654', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget)
		TriggerClientEvent('cmg2_animations:syncMe654654654', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
	else
		local user_id = vRP.getUserId(source)
		source = vRP.getUserSource(user_id)
		if source ~= nil then
			local reason = "ANTI HACK: 	localização:	"..loc.x..","..loc.y..","..loc.z
			vRP.setBanned(user_id,true)					
			local temp = os.date("%x  %X")
			local msg = "Puxando todos players!"
			PerformHttpRequest(ac_webhook, function(err, text, headers) end, 'POST', json.encode({content = "ANTI HACK	[ID]: "..user_id.."		"..temp.."[BAN]		[MOTIVO:"..msg.."]	"..reason}), { ['Content-Type'] = 'application/json' }) 		
			TriggerClientEvent("vrp_sound:source",source,"ban",1.0)
			Citizen.Wait(4000)
			source = vRP.getUserSource(user_id)						
		end
	end
end)


RegisterServerEvent('cmg2_animations:stop654654654')
AddEventHandler('cmg2_animations:stop654654654', function(targetSrc)
	TriggerClientEvent('cmg2_animations:cl_stop654654654', targetSrc)
end)

------------------------------------------------------------
-- PEGAR DE REFEM
----------------------------------------------------------------

RegisterServerEvent('cmg3_animations:sync')
AddEventHandler('cmg3_animations:sync', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget,attachFlag)
	TriggerClientEvent('cmg3_animations:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget,attachFlag)
	TriggerClientEvent('cmg3_animations:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
end)

RegisterServerEvent('cmg3_animations:stop')
AddEventHandler('cmg3_animations:stop', function(targetSrc)
	TriggerClientEvent('cmg3_animations:cl_stop', targetSrc)
end)

------------------------------------------------------------
-- CAVALINHO
----------------------------------------------------------------
RegisterServerEvent('cmg2_animations:sync654654654_2')
AddEventHandler('cmg2_animations:sync654654654_2', function(target, animationLib, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget)	
	vRP.antiflood(source,"cmg2_animations:sync654654654",3)
	function getDistance(coords, ncoords) return #(vector3(coords.x, coords.y, coords.z) - vector3(ncoords.x, ncoords.y, ncoords.z))end

	local ped = GetPlayerPed(source) 
	local loc = GetEntityCoords(ped) 
	local nped = GetPlayerPed(targetSrc) 
	local nloc = GetEntityCoords(nped)
	
	if(getDistance(nloc,loc)<8)then	
		TriggerClientEvent('cmg2_animations:syncTarget654654654', targetSrc, source, animationLib, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget)
		TriggerClientEvent('cmg2_animations:syncMe654654654', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
	else
		local user_id = vRP.getUserId(source)
		source = vRP.getUserSource(user_id)
		if source ~= nil then
			local reason = "ANTI HACK: 	localização:	"..loc.x..","..loc.y..","..loc.z
			vRP.setBanned(user_id,true)					
			local temp = os.date("%x  %X")
			local msg = "Puxando todos players!"
			PerformHttpRequest(ac_webhook, function(err, text, headers) end, 'POST', json.encode({content = "ANTI HACK	[ID]: "..user_id.."		"..temp.."[BAN]		[MOTIVO:"..msg.."]	"..reason}), { ['Content-Type'] = 'application/json' }) 		
			TriggerClientEvent("vrp_sound:source",source,"ban",1.0)
			Citizen.Wait(4000)
			source = vRP.getUserSource(user_id)						
		end
	end	
end)

RegisterServerEvent('cmg2_animations:stop654654654')
AddEventHandler('cmg2_animations:stop654654654', function(targetSrc)
	if targetSrc then
		TriggerClientEvent('cmg2_animations:cl_stop654654654', targetSrc)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- AVISO DE SERVIDOR ONLINE
-----------------------------------------------------------------------------------------------------------------------------------------
-- Citizen.CreateThread(function()
--     PerformHttpRequest("https://discord.com/api/webhooks/881267755339350058/GXZaLxLl490YXq01HNCB1Sw-hlDHtcuwgng-2vI5Zizgz9TwrBUv4f3uU9_rUnBM7iXk", function(err, text, headers) end, 'POST', json.encode({
--         username = "Fênix City",
--         avatar_url = "https://cdn.discordapp.com/attachments/795675862350430288/844269660882862101/v2.gif",
--         content = '||<@&748524310939041808>||',
--         embeds = {
--             {
--                 title = "SERVIDOR ONLINE, BOM RP À TODOS!",
--                 color = 65280,
--                 description = "**Para entrar na cidade, utilize um dos métodos abaixo:**\n\n**Método 1:**\nAbra o FiveM > Aperte F8 > Cole: **connect cfx.re/join/mpmeq9**\n\n**Método 2:**\nAbra o FiveM > Pesquise por **Fenix City** > **Connect**\n\nLembrando que para jogar é necessário estar conectado em nosso <#756544512691667035>",
--                 image = {
--                     url = "https://cdn.discordapp.com/attachments/863117377558675516/893272997622865970/FiveM_b2189_GTAProcess_QZrMcghnb5.jpg"
--                 },
--                 thumbnail = {
--                     url = "https://cdn.discordapp.com/attachments/795675862350430288/844269660882862101/v2.gif"
--                 },
--                 footer = {
--                     text = "Equipe Fênix City",
--                     icon_url = "https://cdn.discordapp.com/attachments/795675862350430288/844269660882862101/v2.gif"
--                 },
--             }
--         },
--     }), { ['Content-Type'] = 'application/json' })
-- end)