local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local reward = {2,5}

local pode_coletar = "tcp.permissao"
local item_farm = "anfetamina"

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
			TriggerClientEvent("Notify",source,"sucesso","Recebeu "..rndResult.." unidades de anfetamina.")	
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
	if vRP.tryGetInventoryItem(user_id,"anfetamina",10) then
		vRP.giveInventoryItem(user_id, "metanfetamina", 1)
		TriggerEvent("DMN:regLog", ""..GetPlayerName(source).." [user_id "..user_id.."] empacotou um tablete de metanfetamina.")
	else
		TriggerClientEvent("Notify",source,"importante","Você precisa de 10 matérias prima.")	
	end 
end)