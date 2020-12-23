local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local reward = {2,5}

local pode_coletar = "tcp.permissao"
local item_farm = "metasuja"

RegisterServerEvent('damn_methfarm:getMetaOnPalet')
AddEventHandler('damn_methfarm:getMetaOnPalet', function()
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,pode_coletar) then
		TriggerClientEvent('damn_methfarm:getMetaOnPalet', source)
	else
		TriggerClientEvent("Notify",source,"negado","Você não tem permissão para isso.")
    end
end)

RegisterServerEvent('damn_methfarm:getMetaItem')
AddEventHandler('damn_methfarm:getMetaItem', function()
	local user_id = vRP.getUserId(source)
	local rndMin,rndMax = table.unpack(reward)
	local rndResult = math.random(rndMin, rndMax)
	if vRP.hasPermission(user_id,pode_coletar) then
		local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight(item_farm)
		if new_weight <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id,item_farm,rndResult,false)
			TriggerClientEvent("Notify",source,"sucesso","Recebeu "..rndResult.." unidades de Meta Suja.")	
		else
			TriggerClientEvent("Notify",source,"importante","Inventário cheio.")	
		end
	else
		TriggerClientEvent("Notify",source,"negado","Você não tem permissão para isso.")	
    end
end)

RegisterServerEvent('damn_methfarm:packDrug')
AddEventHandler('damn_methfarm:packDrug', function()
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"anfetamina") >= 5 then
		if vRP.tryGetInventoryItem(user_id,"anfetamina",5) then
			vRP.giveInventoryItem(user_id, "metanfetamina", 5)
			TriggerEvent("DMN:regLog", ""..GetPlayerName(source).." [user_id "..user_id.."] empacotou 5x Metanfetamina.")
		end
	else
		TriggerClientEvent('Notify',source,"importante","Você precisa de 5x <b>Anfetaminas</b>.")
	end
end)

RegisterServerEvent('damn_methfarm:processDrug')
AddEventHandler('damn_methfarm:processDrug', function()
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"pseudoefedrina") >= 5 then
		if vRP.getInventoryItemAmount(user_id,"ritalina") >= 5 then
			if vRP.getInventoryItemAmount(user_id,"metasuja") >= 5 then
				if vRP.tryGetInventoryItem(user_id,"metasuja",5) and vRP.tryGetInventoryItem(user_id,"ritalina",5) and vRP.tryGetInventoryItem(user_id,"pseudoefedrina",5) then
					vRP.giveInventoryItem(user_id, "anfetamina", 10)
					TriggerEvent("DMN:regLog", ""..GetPlayerName(source).." [user_id "..user_id.."] Você processou 10x Anfetaminas.")
				end
			else
				TriggerClientEvent('Notify',source,"importante","Você precisa de 5x Meta Suja.")
			end
		else
			TriggerClientEvent('Notify',source,"importante","Você precisa do componente químico 5x <b>Ritalina</b>.")
		end
	else
		TriggerClientEvent('Notify',source,"importante","Você precisa do componente químico 5x <b>Pseudoefedrina</b>.")
	end
end)