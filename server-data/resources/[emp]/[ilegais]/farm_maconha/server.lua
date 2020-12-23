local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

local reward = {2,5}

local pode_coletar = "pcc.permissao"
local item_farm = "cannabis"

RegisterServerEvent('damn_weedfarm:getWeedOnPalet')
AddEventHandler('damn_weedfarm:getWeedOnPalet', function()
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,pode_coletar) then
		TriggerClientEvent('damn_weedfarm:getWeedOnPalet', source)
	else
		TriggerClientEvent('Notify',source,"negado","Você não tem permissão para isso.")
    end
end)

RegisterServerEvent('damn_weedfarm:getWeedItem')
AddEventHandler('damn_weedfarm:getWeedItem', function()
	local user_id = vRP.getUserId(source)
	local rndMin,rndMax = table.unpack(reward)
	local rndResult = math.random(rndMin, rndMax)
	if vRP.hasPermission(user_id,pode_coletar) then
		local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight(item_farm)
		if vRP.getInventoryItemAmount(user_id,"adubo") >= 2 then
			if new_weight <= vRP.getInventoryMaxWeight(user_id) then
				if vRP.tryGetInventoryItem(user_id,"adubo",2) then
					vRP.giveInventoryItem(user_id,item_farm,rndResult,false)
					TriggerClientEvent('Notify',source,"sucesso","Recebeu "..rndResult.." unidades de Cannabis.")
				end
			else
				TriggerClientEvent('Notify',source,"importante","Inventário cheio.")
			end
		else
			TriggerClientEvent('Notify',source,"negado","Você precisa de <b>Adubo</b>.")
		end
	else
		TriggerClientEvent('Notify',source,"negado","Você não tem permissão para isso.")
    end
end)

RegisterServerEvent('damn_weedfarm:packDrug')
AddEventHandler('damn_weedfarm:packDrug', function()
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"cannabis") >= 5 then
		if vRP.getInventoryItemAmount(user_id,"embalagem") >= 5 then
			if vRP.tryGetInventoryItem(user_id,"cannabis",5) and vRP.tryGetInventoryItem(user_id,"embalagem",5) then
				vRP.giveInventoryItem(user_id, "maconha", 5)
				TriggerEvent("DMN:regLog", ""..GetPlayerName(source).." [user_id "..user_id.."] empacotou um tablete de maconha.")
			end
		else
			TriggerClientEvent('Notify',source,"importante","Você precisa de 5x Embalagens.")
		end
	else
		TriggerClientEvent('Notify',source,"importante","Você precisa de 5x cannabis.")
	end
end)