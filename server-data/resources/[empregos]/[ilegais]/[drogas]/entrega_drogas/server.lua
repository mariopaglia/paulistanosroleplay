local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

emP = {}
Tunnel.bindInterface("entrega_drogas",emP)
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookdrugs = "https://discord.com/api/webhooks/809579295349145610/30Zfxmd1nI3dUyyzOZjfelizGlBi8lYqLtWJ_TlZxEIt--rKPMUimmFeglKwtXnG9bHi"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"verdes.permissao") or vRP.hasPermission(user_id,"vermelhos.permissao") or vRP.hasPermission(user_id,"roxos.permissao")
end

-- function emP.checkPermission2()
-- 	local source = source
-- 	local user_id = vRP.getUserId(source)
-- 	return vRP.hasPermission(user_id,"vermelhos.permissao")
-- end

-- function emP.checkPermission3()
-- 	local source = source
-- 	local user_id = vRP.getUserId(source)
-- 	return vRP.hasPermission(user_id,"roxos.permissao")
-- end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO CIVIL
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	vRP.antiflood(source,"entrega_drogas",3)
	local source = source
	local user_id = vRP.getUserId(source)
	local policia = vRP.getUsersByPermission("pmesp.permissao")
	local bonus = 0

	if #policia >= 0 and #policia <= 2 then
        bonus = 1600
    elseif #policia >= 3 and #policia <= 6 then
        bonus = 2000
    elseif #policia >= 7 then
        bonus = 2400
    end

	if user_id then
		if vRP.getInventoryItemAmount(user_id,"maconha") >= 1 then
			vRP.tryGetInventoryItem(user_id,"maconha",1)
			vRP.giveInventoryItem(user_id,"dinheirosujo", (parseInt(0) + bonus) * 1)
		end
		if vRP.getInventoryItemAmount(user_id,"cocaina") >= 1 then
			vRP.tryGetInventoryItem(user_id,"cocaina",1)
			vRP.giveInventoryItem(user_id,"dinheirosujo", (parseInt(0) + bonus) * 1)
		end
		if vRP.getInventoryItemAmount(user_id,"metanfetamina") >= 1 then
			vRP.tryGetInventoryItem(user_id,"metanfetamina",1)
			vRP.giveInventoryItem(user_id,"dinheirosujo", (parseInt(0) + bonus) * 1)
		end
		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO FACÇÃO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment2()
	vRP.antiflood(source,"entrega_drogas",3)
	local source = source
	local user_id = vRP.getUserId(source)
	local policia = vRP.getUsersByPermission("pmesp.permissao")
	local bonus = 0

	if #policia >= 0 and #policia <= 2 then
        bonus = 1400
    elseif #policia >= 3 and #policia <= 6 then
        bonus = 1600
    elseif #policia >= 7 then
        bonus = 1800
    end

	if user_id then
		if vRP.getInventoryItemAmount(user_id,"maconha") >= 1 then
			vRP.tryGetInventoryItem(user_id,"maconha",1)
			vRP.giveInventoryItem(user_id,"dinheirosujo", (parseInt(0) + bonus) * 1)
		end
		if vRP.getInventoryItemAmount(user_id,"cocaina") >= 1 then
			vRP.tryGetInventoryItem(user_id,"cocaina",1)
			vRP.giveInventoryItem(user_id,"dinheirosujo", (parseInt(0) + bonus) * 1)
		end
		if vRP.getInventoryItemAmount(user_id,"metanfetamina") >= 1 then
			vRP.tryGetInventoryItem(user_id,"metanfetamina",1)
			vRP.giveInventoryItem(user_id,"dinheirosujo", (parseInt(0) + bonus) * 1)
		end
		return true
	end

	-- if user_id then
	-- 	if vRP.hasPermission(user_id,"verdes.permissao") then
	-- 		if vRP.getInventoryItemAmount(user_id,"maconha") >= 1 then
	-- 			vRP.tryGetInventoryItem(user_id,"maconha",1)
	-- 			vRP.giveInventoryItem(user_id,"dinheirosujo", (parseInt(0) + bonus) * 1)
	-- 		end
	-- 	elseif vRP.hasPermission(user_id,"vermelhos.permissao") then
	-- 		if vRP.getInventoryItemAmount(user_id,"cocaina") >= 1 then
	-- 			vRP.tryGetInventoryItem(user_id,"cocaina",1)
	-- 			vRP.giveInventoryItem(user_id,"dinheirosujo", (parseInt(0) + bonus) * 1)
	-- 		end
	-- 	elseif vRP.hasPermission(user_id,"roxos.permissao") then
	-- 		if vRP.getInventoryItemAmount(user_id,"metanfetamina") >= 1 then
	-- 			vRP.tryGetInventoryItem(user_id,"metanfetamina",1)
	-- 			vRP.giveInventoryItem(user_id,"dinheirosujo", (parseInt(0) + bonus) * 1)
	-- 		end
	-- 	end
	-- 	return true
	-- end

end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICIA
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
function emP.MarcarOcorrencia()
	local source = source
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPosition(source)
	local identity = vRP.getUserIdentity(user_id)
	local crds = GetEntityCoords(GetPlayerPed(source))

	local chance = 0
	local chance = math.random(1,100)

	if chance >= 70 then
		return
	end
	
	if user_id then
		local soldado = vRP.getUsersByPermission("policia.permissao")
		for l,w in pairs(soldado) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					local id = idgens:gen()
					blips[id] = vRPclient.addBlip(player,x,y,z,10,84,"Ocorrência",0.5,false)
					vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
					TriggerClientEvent('chatMessage',player,"190",{64,64,255},"Recebemos uma denuncia de tráfico, verifique o ocorrido.")
					SetTimeout(20000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
				end)
			end
		end
		TriggerClientEvent("Notify",source,"aviso","Corra, a polícia foi acionada!")
		SendWebhookMessage(webhookdrugs,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[FOI DENUNCIADO]\n[COORDENADA]: "..crds.x..","..crds.y..","..crds.z..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	end
end