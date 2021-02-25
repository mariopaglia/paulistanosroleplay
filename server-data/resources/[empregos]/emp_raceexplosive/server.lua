local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

emP = {}
Tunnel.bindInterface("emp_raceexplosive",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookcorrida = "https://discord.com/api/webhooks/811974130471665675/LlKFKfPdmypLrxP8gXBAq9lzb9B5EsVes6gbnh2CkZHOc_JwKYvBLldnHixokqdCrnqR"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
local pay = {
	[1] = { ['min'] = 25000, ['max'] = 35000 },
	[2] = { ['min'] = 25000, ['max'] = 35000 },
	[3] = { ['min'] = 25000, ['max'] = 35000 },
	[4] = { ['min'] = 25000, ['max'] = 35000 },
	[5] = { ['min'] = 25000, ['max'] = 35000 },
	[6] = { ['min'] = 25000, ['max'] = 35000 },
	[7] = { ['min'] = 25000, ['max'] = 35000 },
	[8] = { ['min'] = 25000, ['max'] = 35000 },
	[9] = { ['min'] = 25000, ['max'] = 35000 },
	[10] = { ['min'] = 25000, ['max'] = 35000 }
}

function emP.paymentCheck(check,status)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.antiflood(source,"raceexplosive",2)
		local random = math.random(pay[check].min,pay[check].max)
		local policia = vRP.getUsersByPermission("policia.permissao")
		vRP.giveInventoryItem(user_id,"dinheirosujo",parseInt(random))
		TriggerClientEvent("Notify",source,"sucesso","Você recebeu "..vRP.format(parseInt(random)).."x em <b>Dinheiro Sujo</b>")
	end
end

local racepoint = 1
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(180000)
		racepoint = math.random(#pay)
	end
end)

function emP.getRacepoint()
	return parseInt(racepoint)
end

function emP.startBombRace()
	local source = source
	local policia = vRP.getUsersByPermission("policia.permissao")
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	TriggerEvent('eblips:add',{ name = "Corredor", src = source, color = 83 })
	for l,w in pairs(policia) do
		local player = vRP.getUserSource(parseInt(w))
		if player then
			async(function()
				vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
				TriggerClientEvent('chatMessage',player,"190",{64,64,255},"Encontramos um corredor ilegal na cidade, intercepte-o.")
			end)
		end
	end
	SendWebhookMessage(webhookcorrida,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
end

function emP.setSearchTimer()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.searchTimer(user_id,parseInt(600))
	end
end

function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return not (vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"paramedico.permissao") or vRP.searchReturn(source,user_id))
end

RegisterCommand('unbomb',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,5)
		if nplayer then
			TriggerClientEvent('emp_race:unbomb',nplayer)
			TriggerClientEvent("Notify",source,"sucesso","Você desarmou a <b>Bomba</b> com sucesso.")
		end
	end
end)

function emP.removeBombRace()
	local source = source
	TriggerEvent('eblips:remove',source)
end

function emP.checkPolice()
	local source = source
	local policia = vRP.getUsersByPermission("policia.permissao")

	if parseInt(#policia) >= 4 then
		return true
	else
		TriggerClientEvent("Notify",source,"negado","Policiais insuficientes para iniciar <b>corrida explosiva</b>")
		return false
	end
end

function emP.checkItem()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"gps") >= 1 then
		vRP.tryGetInventoryItem(user_id,"gps",1)
		return true
	else
		TriggerClientEvent("Notify",source,"negado","Você precisa de <b>GPS</b> para iniciar uma corrida explosiva</b>")
	end
end