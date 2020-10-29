local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local reward = {2,5}

local pode_coletar = "cv.permissao"
local item_farm = "pastadecoca"

RegisterServerEvent('cocaina:getcokeOnPalet')
AddEventHandler('cocaina:getcokeOnPalet', function()
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,pode_coletar) then
		TriggerClientEvent('cocaina:getcokeOnPalet', source)
	else
		TriggerClientEvent('Notify',source,"negado","Você não tem permissão para isso.")
    end
end)

RegisterServerEvent('cocaina:getcokeItem')
AddEventHandler('cocaina:getcokeItem', function()
	local user_id = vRP.getUserId(source)
	local rndMin,rndMax = table.unpack(reward)
	local rndResult = math.random(rndMin, rndMax)
	if vRP.hasPermission(user_id,pode_coletar) then
		local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight(item_farm)
		if new_weight <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id,item_farm,rndResult,false)
			TriggerClientEvent('Notify',source,"sucesso","Recebeu "..rndResult.." unidades de cocaina.")
		else
			TriggerClientEvent('Notify',source,"importante","Seu <b>inventario</b> está cheio.")
		end
	else
		TriggerClientEvent('Notify',source,"negado","Você não tem permissão para isso.")
    end
end)

RegisterServerEvent('cocaina:packDrug')
AddEventHandler('cocaina:packDrug', function()
	local user_id = vRP.getUserId(source)
	if vRP.tryGetInventoryItem(user_id,"pastadecoca",10) then
		vRP.giveInventoryItem(user_id, "cocaina", 1)
		TriggerEvent("DMN:regLog", ""..GetPlayerName(source).." [user_id "..user_id.."] empacotou um tablete de cocaina.")
	else
		TriggerClientEvent('Notify',source,"importante","Você precisa de 10 matérias prima.")
	end 
end)