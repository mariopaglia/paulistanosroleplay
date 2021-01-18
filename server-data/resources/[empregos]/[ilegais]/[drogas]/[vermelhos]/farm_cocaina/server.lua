local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("farm_cocaina",emP)

function emP.checkItem()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"pastadecoca") >= 5 then -- IF 1: Tem 5 ou mais itens no inventário?
		if vRP.getInventoryItemAmount(user_id,"pino") >= 5 then -- IF 2: Tem 5 ou mais itens no inventário?
			local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight("cocaina")
			if new_weight <= vRP.getInventoryMaxWeight(user_id) then -- IF 3: Inventário cheio?
				if vRP.tryGetInventoryItem(user_id,"pastadecoca",5) and vRP.tryGetInventoryItem(user_id,"pino",5) then -- IF 4: Retirar itens do inventário
					TriggerClientEvent("progress",source,10000,"Produzindo Droga")
					emP.giveItem()
					return true
				end -- IF 4: FIM
			else
				TriggerClientEvent("Notify",source,"importante","Inventário cheio")
				return false
			end -- IF 3: FIM
		else
			TriggerClientEvent("Notify",source,"negado","Você precisa de 5x Pino")
			return false
		end -- IF 2: FIM
	else
		TriggerClientEvent("Notify",source,"negado","Você precisa de 5x Pasta de Coca")
		return false
	end -- IF 1: FIM
end

function emP.giveItem()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
		SetTimeout(10000,function()
			vRP.giveInventoryItem(user_id,"cocaina",5)
			TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>5x Cocaina</b>")
			vRPclient._stopAnim(source,false)
		end)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"vermelhos.permissao")
end