local logsitens = "https://discord.com/api/webhooks/793599139048980510/TgicubBv4Dhi21Gk8p6jLQLC5kT5y8Cje6qK8VLUpHd3lyufdiDDL229cQpp4JCTDfSS"
local logsenviar = "https://discord.com/api/webhooks/793600149590769685/-PHSTM2RRZkVfb1PIZcitPEByn0rd5ZeEyhs6IX3AJ1O1MPssKnZlhHMot6VTFbH6w_d"
local logscobrar = "https://discord.com/api/webhooks/793600242192220200/xChABlHgz09Kmro84R5i7773NydbQ504C8-5w8RX63mPKdVxxxXvp5wbNwiaQ-8DbWg4"
local logsroubar = "https://discord.com/api/webhooks/793600303437971546/Mq-CbSWOOD7CYQo48zM_Ie8M0-KUIdfLLdqjQiG2WJsXAbqiLN1ZSfWqY_bxbxtf4XUr"
local webhooklinkinout = "https://discord.com/api/webhooks/794791807891669013/DOY3kVr1QmuN_0RBz3D_ZyFF1H6Wx-smJnLRByOXgT7EWHPigPr5xK11YXmohAtMZzdi"
local webhookpaypal = "https://discord.com/api/webhooks/800804690471813162/Q7nryy87L97UxJnsnEODRV4bx4s6aVqmlzxVYf91Hfgf_XXTUvlI-Rud_PRuJ9BCClR_"
local logcmdcall = "https://discord.com/api/webhooks/801616526405795881/MuVEYTGa-R2gQy_nO_9t7vH4wgtvS3ixcmZt5-O9aZqOcM5of15x2AJtcEE56YEJrbKM"
local discord_webhook4 = ""
local discord_webhook5 = ""
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local idgens = Tools.newIDGenerator()

emP = {}
Tunnel.bindInterface("vrp_player",emP)

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end


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
	["alianca"] = { index = "alianca", nome = "Aliança" },
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
	["embalagem"] = { index = "embalagem", nome = "Embalagem" },
	["frasco"] = { index = "frasco", nome = "Frasco" },
	["anfetamina"] = { index = "anfetamina", nome = "Anfetamina" },
	["metanfetamina"] = { index = "metanfetamina", nome = "Metanfetamina" },
	["cocaina"] = { index = "cocaina", nome = "Cocaína" },
	["pastadecoca"] = { index = "pastadecoca", nome = "Pasta de Cocaina" },
	["pino"] = { index = "pino", nome = "Pino" },
	
	-- Farm Desmanche
	["ferramenta"] = { index = "ferramenta", nome = "Ferramenta" },
	["macarico"] = { index = "macarico", nome = "Maçarico" },
	["serra"] = { index = "serra", nome = "Serra" },
	
	-- Farm de Armas
	["placademetal"] = { index = "placademetal", nome = "Placa de Metal" },
	["corpodeak"] = { index = "corpodeak", nome = "Corpo de AK-47" },
	["corpodefiveseven"] = { index = "corpodefiveseven", nome = "Corpo de Five Seven" },
	["corpodeg36"] = { index = "corpodeg36", nome = "Corpo de G36" },
	["corpodemp5"] = { index = "corpodemp5", nome = "Corpo de MP5" },
	["gatilho"] = { index = "gatilho", nome = "Gatilho" },
	["mola"] = { index = "mola", nome = "Mola" },
	
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
	["wbody|WEAPON_SPECIALCARBINE"] = { index = "parafall", nome = "Parafall" },
	["wbody|WEAPON_WRENCH"] = { index = "grifo", nome = "Chave de Grifo" },
	["wbody|WEAPON_BATTLEAXE"] = { index = "batalha", nome = "Machado de Batalha" },
	["wbody|WEAPON_POOLCUE"] = { index = "sinuca", nome = "Taco de Sinuca" },
	["wbody|WEAPON_STONE_HATCHET"] = { index = "pedra", nome = "Machado de Pedra" },
	["wbody|WEAPON_PISTOL"] = { index = "m1911", nome = "M1911" },
	["wbody|WEAPON_APPISTOL"] = { index = "vp9", nome = "Koch VP9" },
	["wbody|WEAPON_STUNGUN"] = { index = "tazer", nome = "Tazer" },
	["wbody|WEAPON_SNSPISTOL"] = { index = "hkp7m10", nome = "HK P7M10" },
	["wbody|WEAPON_BULLPUPRIFLE_MK2"] = { index = "famas", nome = "FAMAS" },
	["wbody|WEAPON_VINTAGEPISTOL"] = { index = "m1922", nome = "M1922" },
	["wbody|WEAPON_REVOLVER"] = { index = "magnum44", nome = "Magnum 44" },
	["wbody|WEAPON_REVOLVER_MK2"] = { index = "magnum357", nome = "Magnum 357" },
	["wbody|WEAPON_MUSKET"] = { index = "winchester22", nome = "Winchester 22" },
	["wbody|GADGET_PARACHUTE"] = { index = "paraquedas", nome = "Paraquedas" },
	["wbody|WEAPON_FIREEXTINGUISHER"] = { index = "extintor", nome = "Extintor" },
	["wbody|WEAPON_MICROSMG"] = { index = "uzi", nome = "Uzi" },
	-- ["wbody|WEAPON_SMG"] = { index = "mp5", nome = "MP5" },
	["wbody|WEAPON_ASSAULTSMG"] = { index = "mtar21", nome = "MTAR-21" },
	["wbody|WEAPON_PUMPSHOTGUN_MK2"] = { index = "remington", nome = "Remington 870" },
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
	["wammo|WEAPON_SNSPISTOL"] = { index = "m-hkp7m10", nome = "Munição de HK P7M10" },
	["wammo|WEAPON_VINTAGEPISTOL"] = { index = "m-m1922", nome = "Munição de M1922" },
	["wammo|WEAPON_SPECIALCARBINE"] = { index = "m-parafall", nome = "Munição de Parafall" },
	["wammo|WEAPON_MUSKET"] = { index = "m-winchester22", nome = "Munição de Winchester 22" },
	["wammo|GADGET_PARACHUTE"] = { index = "m-paraquedas", nome = "Munição de Paraquedas" },
	["wammo|WEAPON_FIREEXTINGUISHER"] = { index = "m-extintor", nome = "Munição de Extintor" },
	-- ["wammo|WEAPON_SMG"] = { index = "m-mp5", nome = "Munição de MP5" },
	["wammo|WEAPON_PUMPSHOTGUN_MK2"] = { index = "m-remington", nome = "Munição de Remington 870" },
	["wammo|WEAPON_ASSAULTRIFLE"] = { index = "m-ak103", nome = "Munição de AK-103" },
	["wammo|WEAPON_GUSENBERG"] = { index = "m-thompson", nome = "Munição de Thompson" },
	["wammo|WEAPON_PETROLCAN"] = { index = "combustivel", nome = "Combustível" },
	["wbody|WEAPON_PETROLCAN"] = { index = "gasolina", nome = "Galão de Gasolina" },
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
	-- Munição Policia
	["wammo|WEAPON_CARBINERIFLE_MK2"] = { index = "m-m4a1", nome = "Munição de M4A1" },
	["wammo|WEAPON_CARBINERIFLE"] = { index = "m-ar15", nome = "Munição de AR-15" },
	["wammo|WEAPON_COMBATPDW"] = { index = "m-sigsauer", nome = "Munição de Sig Sauer" },
	["wammo|WEAPON_COMBATPISTOL"] = { index = "m-glock", nome = "Munição de Glock" },
	
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

--------------------------------------------------------------------------------------------------
-------------------------- /cavalinho ------------------------------------------------------------
--------------------------------------------------------------------------------------------------
RegisterServerEvent('cmg2_animations:sync')
AddEventHandler('cmg2_animations:sync', function(target, animationLib, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget)
	print("got to srv cmg2_animations:sync")
	TriggerClientEvent('cmg2_animations:syncTarget', targetSrc, source, animationLib, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget)
	print("triggering to target: " .. tostring(targetSrc))
	TriggerClientEvent('cmg2_animations:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
end)

RegisterServerEvent('cmg2_animations:stop')
AddEventHandler('cmg2_animations:stop', function(targetSrc)
	TriggerClientEvent('cmg2_animations:cl_stop', targetSrc)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Carregar
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('cmg2_animations:sync')
AddEventHandler('cmg2_animations:sync', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget)
	print("got to srv cmg2_animations:sync")
	TriggerClientEvent('cmg2_animations:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget)
	print("triggering to target: " .. tostring(targetSrc))
	TriggerClientEvent('cmg2_animations:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
end)

RegisterServerEvent('cmg2_animations:stop')
AddEventHandler('cmg2_animations:stop', function(targetSrc)
	TriggerClientEvent('cmg2_animations:cl_stop', targetSrc)
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('item',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] and args[2] and itemlist[args[1]] ~= nil then
			vRP.giveInventoryItem(user_id,args[1],parseInt(args[2]))
			SendWebhookMessage(logsitens, "```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[CRIOU]: "..args[1].."\n[QNT]: "..args[2]..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."```")
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
-- CHECAR PERMISSÃO DO COMANDO /SILENCIADOR
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermissionSilenciador()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,'corarma.permissao')
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
    
    if descricao == "sim" or descricao == "Sim" or descricao == "SIM" then
        if vRPclient.getHealth(source) > 101 then
            if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("colete") <= vRP.getInventoryMaxWeight(user_id) then        
                if armourlevel > 89 then
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
                elseif armourlevel > 0 then
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
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUG CRIAÇÃO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Instanced then
			for i=0, 255 do --altere para 32 caso não use onesync
				local otherPlayerPed = GetPlayerPed(i)
				
				if otherPlayerPed ~= PlayerPedId() then
					SetEntityLocallyInvisible(otherPlayerPed)
					SetEntityNoCollisionEntity(PlayerPedId(),  otherPlayerPed,  true)
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
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id,'roupavip.permissao') then
		TriggerClientEvent('setsapatos',source,args[1],args[2])
	else
		TriggerClientEvent("Notify",source,"negado","Você precisa de <b>Roupas</b> para mudar de sapatos")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MASCARA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mascara',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id,'roupavip.permissao') then
		TriggerClientEvent('mascara',source,args[1],args[2])
	else
		TriggerClientEvent("Notify",source,"negado","Você precisa de <b>Roupas</b> para mudar de mascara")
		-- TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Você precisa de ^1Roupas ^0para mudar de máscara.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLUSA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('blusa',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id,'roupavip.permissao') then
		TriggerClientEvent('blusa',source,args[1],args[2])
	else
		TriggerClientEvent("Notify",source,"negado","Você precisa de <b>Roupas</b> para mudar de blusa")
		-- TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Você precisa de ^1Roupas ^0para mudar de blusa.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- JAQUETA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('jaqueta',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id,'roupavip.permissao') then
		TriggerClientEvent('jaqueta',source,args[1],args[2])
	else
		TriggerClientEvent("Notify",source,"negado","Você precisa de <b>Roupas</b> para mudar de jaqueta")
	end
end)
-------------------------------------------------------------------------------------------------------------------------------------------
---- CALCA
-------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('calca',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id,'roupavip.permissao') then
		TriggerClientEvent('calca',source,args[1],args[2])
	else
		TriggerClientEvent("Notify",source,"negado","Você precisa de <b>Roupas</b> para mudar de calça")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('maos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id,'roupavip.permissao') then
		TriggerClientEvent('maos',source,args[1],args[2])
	else
		TriggerClientEvent("Notify",source,"negado","Você precisa de <b>Roupas</b> para mudar de mãos")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACESSORIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('acessorios',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id,'roupavip.permissao') then
		TriggerClientEvent('acessorios',source,args[1],args[2])
	else
		TriggerClientEvent("Notify",source,"negado","Você precisa de <b>Roupas</b> para mudar de acessórios")
	end
end)
-------------------------------------------------------------------------------------------------------------------------------------------
---- COLETE
-------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('colete',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id,'roupavip.permissao') then
		TriggerClientEvent('colete',source,args[1],args[2])
	else
		TriggerClientEvent("Notify",source,"negado","Você precisa de <b>Roupas</b> para mudar de colete")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('chapeu',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id,'roupavip.permissao') then
		TriggerClientEvent('chapeu',source,args[1],args[2])
	else
		TriggerClientEvent("Notify",source,"negado","Você precisa de <b>Roupas</b> para mudar de chapéu")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OCULOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('oculos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id,'roupavip.permissao') then
		TriggerClientEvent('oculos',source,args[1],args[2])
	else
		TriggerClientEvent("Notify",source,"negado","Você precisa de <b>Roupas</b> para mudar de oculos")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAPATOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('sapatos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id,'roupavip.permissao') then
		TriggerClientEvent('sapatos',source,args[1],args[2])
	else
		TriggerClientEvent("Notify",source,"negado","Você precisa de <b>Roupas</b> para mudar de sapatos")
	end
end)
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
		TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5M O C H I L A^4  - - - - - - - - - - - - - - - - - - - - - - - - - - -  [  ^3"..string.format("%.2f",vRP.getInventoryWeight(nuser_id)).."kg^4  /  ^3"..string.format("%.2f",vRP.getInventoryMaxWeight(nuser_id)).."kg^4  ]  - -")
		if data and data.inventory then
			for k,v in pairs(data.inventory) do
				TriggerClientEvent('chatMessage',source,"",{},"     "..vRP.format(parseInt(v.amount)).."x "..itemlist[k].nome)
			end
		end
		TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5E Q U I P A D O^4  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
		for k,v in pairs(weapons) do
			if v.ammo < 1 then
				TriggerClientEvent('chatMessage',source,"",{},"     1x "..itemlist["wbody|"..k].nome)
			else
				TriggerClientEvent('chatMessage',source,"",{},"     1x "..itemlist["wbody|"..k].nome.." | "..vRP.format(parseInt(v.ammo)).."x Munições")
			end
		end
		TriggerClientEvent('chatMessage',source,"",{},"     R$"..vRP.format(parseInt(money)).." reais")
		TriggerClientEvent("Notify",nplayer,"importante","Você está sendo revistado por <b>"..identity.name.." "..identity.firstname.."</b>.")
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
RegisterServerEvent("kickAFK")
AddEventHandler("kickAFK",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if not vRP.hasPermission(user_id,"admin.permissao") then
		DropPlayer(source,"Voce foi desconectado por ficar ausente.")
	end
end)
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
	if vRP.hasPermission(user_id,"paramedico.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,3)
		if nplayer then
			TriggerClientEvent('tratamento',nplayer)
			TriggerClientEvent("Notify",nplayer,"sucesso","Tratamento iniciado, aguarde a liberação do paramédico.")
			TriggerClientEvent("Notify",source,"sucesso","Tratamento no paciente iniciado com sucesso.")
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
						SendWebhookMessage(logsenviar, "```Player "..user_id.." enviou(por comando) o item: "..k.. " para o ID "..nuser_id.." [QTD]: "..args[2].."\n[COORDENADA]: "..crds.x..","..crds.y..","..crds.z.."```")
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
			SendWebhookMessage(logsenviar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ENVIOU]: R$ "..vRP.format(parseInt(args[1])).." \n[PARA O ID]: "..nuser_id.." "..identityu.name.." "..identityu.firstname.."\n[COORDENADA]: "..crds.x..","..crds.y..","..crds.z..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		else
			TriggerClientEvent("Notify",source,"negado","Não tem a quantia que deseja enviar.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COBRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cobrar',function(source,args,rawCommand)
    vRP.antiflood(source,"/cobrar",2)
    local user_id = vRP.getUserId(source)
    local consulta = vRPclient.getNearestPlayer(source,2)
    local nuser_id = vRP.getUserId(consulta)
    local resultado = json.decode(consulta) or 0
    local identity =  vRP.getUserIdentity(user_id)
	local identityu = vRP.getUserIdentity(nuser_id)
	local crds = GetEntityCoords(GetPlayerPed(source))
    if vRP.request(consulta,"Deseja pagar <b>R$ "..vRP.format(parseInt(args[1])).."</b> para <b>"..identity.name.." "..identity.firstname.."</b>?",30) then    
        if parseInt(args[1]) > 0 then                
            local banco = vRP.getBankMoney(nuser_id)
        
            if banco >= parseInt(args[1]) then
                vRP.setBankMoney(nuser_id,parseInt(banco-args[1]))
                vRP.giveBankMoney(user_id,parseInt(args[1]))
            
                TriggerClientEvent("Notify",source,"sucesso","Recebeu <b>R$ "..vRP.format(parseInt(args[1])).."</b> de <b>"..identityu.name.. " "..identityu.firstname.."</b>.")
                local player = vRP.getUserSource(parseInt(args[2]))
                if player == nil then
                    return
                else
                    local identity = vRP.getUserIdentity(user_id)
					TriggerClientEvent("Notify",player,"importante","<b>"..identity.name.." "..identity.firstname.."</b> transferiu <b>R$ "..vRP.format(parseInt(args[1])).."</b> para sua conta.")
					SendWebhookMessage(logscobrar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COBROU]: R$ "..vRP.format(parseInt(args[1])).." \n[DO ID]: "..nuser_id.." "..identityu.name.." "..identityu.firstname.."\n[COORDENADA]: "..crds.x..","..crds.y..","..crds.z..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                end            
            else    
                TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
            end    
        end
    end
end) 
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARMAS
-----------------------------------------------------------------------------------------------------------------------------------------
local garmas={} 
RegisterCommand('garmas',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    TriggerClientEvent("Notify",source,"aviso","<b>Aguarde</b><br>Suas armas estão sendo desequipadas.",9500)
    table.insert(garmas,user_id)
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
        table.remove(garmas,user_id)
    end)    
end)

AddEventHandler('playerDropped', function (reason)
    local user_id = vRP.getUserId(source)
    -- print('Player ' .. GetPlayerName(source) ..' ['..vRP.getUserId(source).. '] dropped (Reason: ' .. reason .. ')')
    if reason == "Exiting" or "Disconnect"  then 
		if checkId(user_id) then
			local identity = vRP.getUserIdentity(user_id)
			local webhookbanimento = "https://discord.com/api/webhooks/800148956649750558/BYP4AcXNkOfOosRVVW7NUhPiM8WNDiKAoMn2g4-SUYFayTm-mHrrya4ppsF89aB8jUxS"
			vRP.setBanned(user_id,true)
			SendWebhookMessage(webhookbanimento, "```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[MOTIVO]: Bugando /garmas"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."```")
        end
    end
end)
function checkId(user_id)
    local status = false
    for k,v in pairs(garmas) do
        if v == user_id then
            table.remove(garmas,v)
            status = true
            break
        else
            status = false
        end    
    end
    return status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUBAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('roubar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if nplayer then
		local nuser_id = vRP.getUserId(nplayer)
		local policia = vRP.getUsersByPermission("policia.permissao")
		if #policia >= 0 then
			if vRP.request(nplayer,"Você está sendo roubado, deseja passar tudo?",30) then
				local vida = vRPclient.getHealth(nplayer)
				if vida <= 100 then
					TriggerClientEvent('cancelando',source,true)
					vRPclient._playAnim(source,false,{{"amb@medic@standing@kneel@idle_a","idle_a"}},true)
					TriggerClientEvent("progress",source,30000,"roubando")
					SetTimeout(30000,function()
						local ndata = vRP.getUserDataTable(nuser_id)
						if ndata ~= nil then
							if ndata.inventory ~= nil then
								for k,v in pairs(ndata.inventory) do
									if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
										if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
											vRP.giveInventoryItem(user_id,k,v.amount)
										end
									else
										TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..itemlist[k].nome.."</b> por causa do peso.")
									end
								end
							end
						end
						local weapons = vRPclient.replaceWeapons(nplayer,{})
						for k,v in pairs(weapons) do
							vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|"..k) <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
									vRP.giveInventoryItem(user_id,"wbody|"..k,1)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..itemlist["wbody"..k].nome.."</b> por causa do peso.")
							end
							if v.ammo > 0 then
								vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
									if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
										vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.ammo)).."x "..itemlist["wammo|"..k].nome.."</b> por causa do peso.")
								end
							end
						end
						local nmoney = vRP.getMoney(nuser_id)
						if vRP.tryPayment(nuser_id,nmoney) then
							vRP.giveMoney(user_id,nmoney)
						end
						vRPclient.setStandBY(source,parseInt(600))
						vRPclient._stopAnim(source,false)
						TriggerClientEvent('cancelando',source,false)
						TriggerClientEvent("Notify",source,"importante","Roubo concluido com sucesso.")
						-- SendWebhookMessage(logsroubar, "```Player "..user_id.." roubou o ID: "..nuser_id.."```")
						-- SendWebhookMessage(logsroubar, "```prolog\n[ID]: "..user_id.." "..identitys.name.." "..identitys.firstname.." \n[CHAMOU]: "..args[1].."\n[MENSAGEM]: '"..descricao.."'\n[COORDENADA]: "..crds.x..","..crds.y..","..crds.z..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."```")
					end)
				else
					local ndata = vRP.getUserDataTable(nuser_id)
					local weapons = vRPclient.replaceWeapons(nplayer,{})
					local data = vRP.getUserDataTable(vRP.getUserId(nplayer))
					if data then
						data.weapons = {}
					end
					if ndata ~= nil then
						if ndata.inventory ~= nil then
							for k,v in pairs(ndata.inventory) do
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
									if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
										vRP.giveInventoryItem(user_id,k,v.amount)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..itemlist[k].nome.."</b> por causa do peso.")
								end
							end
						end
					end
					for k,v in pairs(weapons) do
						vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|"..k) <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
								vRP.giveInventoryItem(user_id,"wbody|"..k,1)
							end
						else
							TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..itemlist["wbody|"..k].nome.."</b> por causa do peso.")
						end
						if v.ammo > 0 then
							vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
									vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.ammo)).."x "..itemlist["wammo|"..k].nome.."</b> por causa do peso.")
							end
						end
					end
					local nmoney = vRP.getMoney(nuser_id)
					if vRP.tryPayment(nuser_id,nmoney) then
						vRP.giveMoney(user_id,nmoney)
					end
					vRPclient.setStandBY(source,parseInt(600))
					TriggerClientEvent("Notify",source,"importante","Roubo concluido com sucesso.")
					TriggerEvent('logs:ToDiscord', discord_webhook1 , "ROUBO", "```Player "..user_id.." roubou o ID: "..nuser_id.."```", "https://www.tumarcafacil.com/wp-content/uploads/2017/06/RegistroDeMarca-01-1.png", false, false)
				end
			else
				TriggerClientEvent("Notify",source,"importante","A pessoa está resistindo ao roubo.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Número insuficiente de policiais no momento.")
		end
	end
end)
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALL
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
RegisterCommand('call',function(source,args,rawCommand)
	local source = source
	local answered = false
	local user_id = vRP.getUserId(source)
	if user_id then
		local players = {}
		-- if args[1] == "190" then
		-- 	players = vRP.getUsersByPermission("policia.permissao")
		-- elseif args[1] == "192" then
		-- 	players = vRP.getUsersByPermission("paramedico.permissao")
		-- elseif args[1] == "mec" then
		-- 	players = vRP.getUsersByPermission("mecanico.permissao")
		-- elseif args[1] == "taxi" then
		-- 	players = vRP.getUsersByPermission("taxista.permissao")
		if args[1] == "adm" then
			players = vRP.getUsersByPermission("admin.permissao")
		else
			TriggerClientEvent("Notify",source,"negado","Serviço inexistente ou disponível somente pelo <b>celular</b>")
			return
		end

		local descricao = vRP.prompt(source,"Descrição:","")
		if descricao == "" then
			return
		end

		local identitys = vRP.getUserIdentity(user_id)
		TriggerClientEvent("Notify",source,"sucesso","Chamado enviado com sucesso.")
		SendWebhookMessage(discordwebhook, "```prolog\n[====CHAMADOS====]\n[ID]: "..user_id.." \n[CHAMADO PARA]: "..args[1].."\n[MENSAGEM]: '"..descricao.."'```")
		for l,w in pairs(players) do
			local player = vRP.getUserSource(parseInt(w))
			local nuser_id = vRP.getUserId(player)
			local x,y,z = vRPclient.getPosition(source)
			local uplayer = vRP.getUserSource(user_id)
			local crds = GetEntityCoords(GetPlayerPed(source))

			if player and player ~= uplayer then
				async(function()
					vRPclient.playSound(player,"Out_Of_Area","DLC_Lowrider_Relay_Race_Sounds")
					TriggerClientEvent('chatMessage',player,"CHAMADO",{19,197,43},"Enviado por ^1"..identitys.name.." "..identitys.firstname.."^0 ["..user_id.."]: "..descricao)
					SendWebhookMessage(logcmdcall, "```prolog\n[ID]: "..user_id.." "..identitys.name.." "..identitys.firstname.." \n[CHAMOU]: "..args[1].."\n[MENSAGEM]: '"..descricao.."'\n[COORDENADA]: "..crds.x..","..crds.y..","..crds.z..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."```")
					local ok = vRP.request(player,"Aceitar o chamado de <b>"..identitys.name.." "..identitys.firstname.."</b>?",30)
					if ok then
						if not answered then
							answered = true
							local identity = vRP.getUserIdentity(nuser_id)
							TriggerClientEvent("Notify",source,"importante","Chamado atendido por <b>"..identity.name.." "..identity.firstname.."</b>, aguarde no local.")
							vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
							vRPclient._setGPS(player,x,y)
						else
							TriggerClientEvent("Notify",player,"negado","Chamado ja foi atendido por outra pessoa.")
							vRPclient.playSound(player,"CHECKPOINT_MISSED","HUD_MINI_GAME_SOUNDSET")
						end
					end
					local id = idgens:gen()
					blips[id] = vRPclient.addBlip(player,x,y,z,358,71,"Chamado",0.6,false)
					SetTimeout(300000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
				end)
			end
		end
	end
end)
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
-- ROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
local roupas = {
-- [1] = { -1,0 }, -- máscara
-- [3] = { 20,0 }, -- maos
-- [4] = { 75,0 }, -- calça
-- [5] = { 34,0 }, -- mochila
-- [6] = { 24,0 }, -- sapato
-- [7] = { -1,0 }, -- acessorios
-- [8] = { -1,0 }, -- blusa
-- [9] = { -1,0 }, -- colete
-- [10] = { -1,0 }, -- adesivo
-- [11] = { 86,1 }, -- jaqueta
	["minerador"] = {
		[1885233650] = {                                      
			[1] = { -1,0 },
			[3] = { 99,1 },
			[4] = { 89,20 },
			[5] = { -1,0 },
			[6] = { 82,2 },
			[7] = { -1,0 },
			[8] = { 90,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 273,0 },
			["p1"] = { 23,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 114,1 },
			[4] = { 92,20 },
			[5] = { -1,0 },
			[6] = { 86,2 },
			[7] = { -1,0 },
			[8] = { 54,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 286,0 },
			["p1"] = { 25,0 }
		}
	},
    ["lixeiro"] = {
		[1885233650] = {                                      
			[1] = { -1,0 },
			[3] = { 17,0 },
			[4] = { 36,0 },
			[5] = { -1,0 },
			[6] = { 27,0 },
			[7] = { -1,0 },
			[8] = { 59,0 },
			[10] = { -1,0 },
			[11] = { 57,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 18,0 },
			[4] = { 35,0 },
			[5] = { -1,0 },
			[6] = { 26,0 },
			[7] = { -1,0 },
			[8] = { 36,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 50,0 }
		}
	},
	["taxista"] = {
		[1885233650] = {                                      
			[1] = { -1,0 },
			[3] = { 11,0 },
			[4] = { 35,0 },
			[5] = { -1,0 },
			[6] = { 10,0 },
			[7] = { -1,0 },
			[8] = { 15,0 },
			[10] = { -1,0 },
			[11] = { 13,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 0,0 },
			[4] = { 112,0 },
			[5] = { -1,0 },
			[6] = { 6,0 },
			[7] = { -1,0 },
			[8] = { 6,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 27,0 }
		}
	},
	["caminhoneiro"] = {
		[1885233650] = {                                      
			[1] = { -1,0 },
			[3] = { 0,0 },
			[4] = { 63,0 },
			[5] = { -1,0 },
			[6] = { 27,0 },
			[7] = { -1,0 },
			[8] = { 81,0 },
			[10] = { -1,0 },
			[11] = { 173,3 },
			["p1"] = { 8,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 14,0 },
			[4] = { 74,5 },
			[5] = { -1,0 },
			[6] = { 9,0 },
			[7] = { -1,0 },
			[8] = { 92,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 175,3 },
			["p1"] = { 11,0 }
		}
	},
	["pelado"] = {
		[1885233650] = {                                      
			[1] = {-1,0,2},
			[2] = {21,0,03},
			[3] = {1,0,1},
			[4] = {29,0,1},
			[5] = {-1,0,2},
			[6] = {34,0,2},
			[7] = {-1,0,2},
			[8] = {15,0,2},
			[9] = {0,5,1},
			[10] = {-1,0,2},
			[11] = {15,0,2},
			[12] = {0,0,0},
			[13] = {0,2,0},
			[14] = {0,0,255},
			[15] = {0,2,100},
			[16] = {0,1,255},
			[17] = {1280,2,255},
			[18] = {33554944,2,255},
			[19] = {33686017,2,255},
			[20] = {33685762,2,255},
			["p0"] = {-1,0},
			["p1"] = {-1,0},
			["p2"] = {-1,0},
			["p3"] = {-1,0},
			["p7"] = {-1,0},
			["p6"] = {-1,0},
			["p8"] = {-1,0},
			["p9"] = {-1,0},
			["p5"] = {-1,0},
			[0] = {0,0,0},
			["p10"] = {-1,0}
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 15,0 },
			[4] = { 21,0 },
			[5] = { -1,0 },
			[6] = { 35,0 },
			[7] = { -1,0 },
			[8] = { 6,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 82,0 }
		}
	},
	["paciente"] = {
		[1885233650] = {
			[1] = { -1,0 },
			[3] = { 15,0 },
			[4] = { 61,0 },
			[5] = { -1,0 },
			[6] = { 16,0 },
			[7] = { -1,0 },			
			[8] = { 15,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 104,0 },			
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 0,0 },
			[4] = { 57,0 },
			[5] = { -1,0 },
			[6] = { 16,0 },
			[7] = { -1,0 },		
			[8] = { 7,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 105,0 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
}

RegisterCommand('roupas',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 0 then
		if args[1] then
			local custom = roupas[tostring(args[1])]
			if custom then
				local old_custom = vRPclient.getCustomization(source)
				local idle_copy = {}

				idle_copy = vRP.save_idle_custom(source,old_custom)
				idle_copy.modelhash = nil

				for l,w in pairs(custom[old_custom.modelhash]) do
					idle_copy[l] = w
				end
				vRPclient._setCustomization(source,idle_copy)
			end
		else
			vRP.removeCloak(source)
		end
		else
		TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Você precisa de ^1Roupas ^0para mudar de roupa.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /PAYPAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('paypal',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		if args[1] == "sacar" and parseInt(args[2]) > 0 then
			vRP.antiflood(source,"/paypal sacar",3)
			local consulta = vRP.getUData(user_id,"vRP:paypal")
			local resultado = json.decode(consulta) or 0
			local fixbug = vRP.prompt(source,"Confirmaçao(Digite Sim):","")
			if fixbug == "sim" then
			if resultado >= parseInt(args[2]) then
				vRP.giveBankMoney(user_id,parseInt(args[2]))
				vRP.setUData(user_id,"vRP:paypal",json.encode(parseInt(resultado-args[2])))
				TriggerClientEvent("Notify",source,"sucesso","Efetuou o saque de <b>R$"..vRP.format(parseInt(args[2])).." reais</b> da sua conta paypal.")
				SendWebhookMessage(webhookpaypal,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SACOU]: R$ "..vRP.format(parseInt(args[2]))..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			else
				TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente em sua conta paypal.")
				end
			end
		end
	end
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
	if args[1] == "trans" and parseInt(args[2]) > 0 and parseInt(args[3]) > 0 then
	vRP.antiflood(source,"/paypal trans",3)
	local consulta = vRP.getUData(parseInt(args[2]),"vRP:paypal")
	local resultado = json.decode(consulta) or 0
	local banco = vRP.getBankMoney(user_id)
	local identityu = vRP.getUserIdentity(parseInt(args[2]))
	if vRP.request(source,"Deseja transferir <b>R$"..vRP.format(parseInt(args[3])).."</b> reais para <b>"..identityu.name.." "..identityu.firstname.."</b>?",30) then
		if banco >= parseInt(args[3]) then
			vRP.setBankMoney(user_id,parseInt(banco-args[3]))
			vRP.setUData(parseInt(args[2]),"vRP:paypal",json.encode(parseInt(resultado+args[3])))
			TriggerClientEvent("Notify",source,"sucesso","Enviou <b>R$ "..vRP.format(parseInt(args[3])).." reais</b> ao passaporte <b>"..vRP.format(parseInt(args[2])).."</b>.")
			SendWebhookMessage(webhookpaypal,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ENVIOU]: R$ "..vRP.format(parseInt(args[3])).." \n[PARA O ID]: "..parseInt(args[2]).." "..identityu.name.." "..identityu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			local player = vRP.getUserSource(parseInt(args[2]))
			if player == nil then
				return
			else
				local identity = vRP.getUserIdentity(user_id)
				TriggerClientEvent("Notify",player,"importante","<b>"..identity.name.." "..identity.firstname.."</b> transferiu <b>R$"..vRP.format(parseInt(args[3])).." reais</b> para sua conta do paypal.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
				end
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /STATUS (PESSOAS ONLINE POR PROFISSÃO)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('status',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)        
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"sup.permissao") then
		local onlinePlayers2 = GetNumPlayerIndices()
    	local policia2 = vRP.getUsersByPermission("policia.permissao")
    	local paramedico2 = vRP.getUsersByPermission("paramedico.permissao")
    	local mec2 = vRP.getUsersByPermission("mecanico.permissao")
    	local staff2 = vRP.getUsersByPermission("admin.permissao")
		local taxista2 = vRP.getUsersByPermission("taxista.permissao")
		local conce2 = vRP.getUsersByPermission("concessionaria.permissao")
		TriggerClientEvent("Notify",source,"importante","<bold><b>Jogadores</b>: <b>"..onlinePlayers2.."<br>Staff</b>: <b>"..#staff2.."<br>Policiais</b>: <b>"..#policia2.."<br>Taxistas</b>: <b>"..#taxista2.."<br>Paramédicos</b>: <b>"..#paramedico2.."<br>Concessionária</b>: <b>"..#conce2.."<br>Mecânicos</b>: <b>"..#mec2.."</b></bold>",9000)
	else
    	local onlinePlayers = GetNumPlayerIndices()
    	local paramedico = vRP.getUsersByPermission("paramedico.permissao")
    	local mec = vRP.getUsersByPermission("mecanico.permissao")
    	local taxista = vRP.getUsersByPermission("taxista.permissao")
    	local conce = vRP.getUsersByPermission("concessionaria.permissao")
		TriggerClientEvent("Notify",source,"importante","<bold><b>Jogadores</b>: <b>"..onlinePlayers.."<br>Taxistas</b>: <b>"..#taxista.."<br>Paramédicos</b>: <b>"..#paramedico.."<br>Concessionária</b>: <b>"..#conce.."<br>Mecânicos</b>: <b>"..#mec.."</b></bold>",9000)
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
		SendWebhookMessage(webhooklinkinout, "```"..os.date("[%d/%m/%Y %H:%M:%S]").." "..identity.name.." "..identity.firstname.." [".. user_id .."] entrou```")
	end
end)

AddEventHandler("vRP:playerLeave",function(user_id, source)
	local crds = GetEntityCoords(GetPlayerPed(source))
	local identity = vRP.getUserIdentity(user_id)
	SendWebhookMessage(webhooklinkinout, "```"..os.date("[%d/%m/%Y %H:%M:%S]").." "..identity.name.." "..identity.firstname.." [".. user_id .."] saiu na coordenada: "..crds.x..","..crds.y..","..crds.z.."```")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- BANIR CASO UTILIZE O COMANDO _CRASH
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('playerDropped', function (reason)
    local user_id = vRP.getUserId(source)
    -- print('Player ' .. GetPlayerName(source) ..' ['..vRP.getUserId(source).. '] dropped (Reason: ' .. reason .. ')')
    if reason == "Game crashed: gta-core-five.dll!CrashCommand (0x0)" then
        vRP.setBanned(user_id,true)
    end
end)

