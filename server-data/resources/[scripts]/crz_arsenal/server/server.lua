local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookarsenal = "https://discord.com/api/webhooks/808411223833182218/IVVL1jdarDhdXkULG9VEPcs_o5FeshCU7g7nNsmLvZ3wT6YDyb43769D-iZtGOW9VWL4"
local webhookarsenalpcesp = "https://discord.com/api/webhooks/809892497487560724/NFn3r_xSySCodHZPcrMTEIEAFN1e6z_F8_4V9QiEVilwV5OQqwspSdS8CbtbqdhYa3OP"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

local armas = {
}

RegisterServerEvent('crz_arsenal:permissao')
AddEventHandler('crz_arsenal:permissao', function()
	local src = source
	local user_id = vRP.getUserId(src)
	if vRP.hasPermission(user_id,"policia.permissao") then
		TriggerClientEvent('crz_arsenal:permissao', src)
	end
end)

RegisterServerEvent('crz_arsenal:colete')
AddEventHandler('crz_arsenal:colete', function()
	local src = source
	local user_id = vRP.getUserId(src)
	if vRP.hasPermission(user_id,"policia.permissao") then
		local colete = 100
		vRPclient.setArmour(src,100)
		vRP.setUData(user_id,"vRP:colete", json.encode(colete))
	end
end)

RegisterServerEvent('crz_arsenal:logs')
AddEventHandler('crz_arsenal:logs', function(arma)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	SendWebhookMessage(webhookarsenal,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..arma.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
end)

RegisterServerEvent('crz_arsenal:logspcesp')
AddEventHandler('crz_arsenal:logspcesp', function(arma)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	SendWebhookMessage(webhookarsenalpcesp,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..arma.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
end)