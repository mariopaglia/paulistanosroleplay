local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local reward = {1,1}

local pode_coletar = "vanilla.permissao"
local item_farm2 = "kevlar"

RegisterServerEvent('farm_colete:getKevlarOnPalet')
AddEventHandler('farm_colete:getKevlarOnPalet', function()
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,pode_coletar) then
		TriggerClientEvent('farm_colete:getKevlarOnPalet', source)
	else
		TriggerClientEvent("Notify",source,"negado","Você não tem permissão para isso.")
    end
end)

RegisterServerEvent('farm_colete:getKevlarItem')
AddEventHandler('farm_colete:getKevlarItem', function()
	local user_id = vRP.getUserId(source)
	local rndMin,rndMax = table.unpack(reward)
	local rndResult = math.random(rndMin, rndMax)
	if vRP.hasPermission(user_id,pode_coletar) then
		local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight(item_farm2)
		if new_weight <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id,item_farm2,rndResult,false)
			TriggerClientEvent("Notify",source,"sucesso","Recebeu "..rndResult.." unidades de kevlar.")
		else
			TriggerClientEvent("Notify",source,"importante","Inventário cheio.")
		end
	else
		TriggerClientEvent("Notify",source,"negado","Você não tem permissão para isso.")
    end
end)

RegisterServerEvent('farm_colete:createArmor')
AddEventHandler('farm_colete:createArmor', function()
	local user_id = vRP.getUserId(source)
	if vRP.tryGetInventoryItem(user_id,"kevlar",10) then
		vRP.giveInventoryItem(user_id, "colete", 1)
		TriggerEvent("DMN:regLog", ""..GetPlayerName(source).." [user_id "..user_id.."] fabricou um Colete.")
	else
		TriggerClientEvent("Notify",source,"negado","Você precisa de 10 matérias prima.")
	end 
end)
