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
			TriggerClientEvent('Notify',source,"sucesso","Recebeu "..rndResult.." unidades de Pasta de Coca.")
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
	if vRP.getInventoryItemAmount(user_id,"po") >= 5 then
		if vRP.getInventoryItemAmount(user_id,"pino") >= 5 then
			if vRP.tryGetInventoryItem(user_id,"po",5) and vRP.tryGetInventoryItem(user_id,"pino",5) then
				vRP.giveInventoryItem(user_id, "cocaina", 5)
				TriggerEvent("DMN:regLog", ""..GetPlayerName(source).." [user_id "..user_id.."] empacotou 5x pinos de cocaina.")
			end
		else
			TriggerClientEvent('Notify',source,"importante","Você precisa de 5x <b>Pinos</b>.")
		end
	else
		TriggerClientEvent('Notify',source,"importante","Você precisa de 5x <b>Pós de Coca</b>.")
	end
end)

RegisterServerEvent('cocaina:processDrug')
AddEventHandler('cocaina:processDrug', function()
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"acetofenetidina") >= 5 then
		if vRP.getInventoryItemAmount(user_id,"benzoilecgonina") >= 5 then
			if vRP.getInventoryItemAmount(user_id,"cloridratoecgonina") >= 5 then
				if vRP.tryGetInventoryItem(user_id,"pastadecoca",5) and vRP.tryGetInventoryItem(user_id,"cloridratoecgonina",5) and vRP.tryGetInventoryItem(user_id,"acetofenetidina",5) and vRP.tryGetInventoryItem(user_id,"benzoilecgonina",5) then
					vRP.giveInventoryItem(user_id, "po", 10)
					TriggerEvent("DMN:regLog", ""..GetPlayerName(source).." [user_id "..user_id.."] Você processou 10x Pós da Cocaína.")
				else
					TriggerClientEvent('Notify',source,"importante","Você precisa de 10x pastas de coca.")
				end
			else
				TriggerClientEvent('Notify',source,"importante","Você precisa do componente químico <b>Cloridratoecgonina</b>.")
			end
		else
			TriggerClientEvent('Notify',source,"importante","Você precisa do componente químico <b>Benzoilecgonina</b>.")
		end
	else
		TriggerClientEvent('Notify',source,"importante","Você precisa do componente químico <b>Acetofenetidina</b>.")
	end
end)