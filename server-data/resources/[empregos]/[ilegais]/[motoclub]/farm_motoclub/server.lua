local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("farm_motoclub",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUANTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
-- local quantidade = {}
-- function emP.Quantidade()
-- 	local source = source
-- 	if quantidade[source] == nil then
-- 		quantidade[source] = math.random(2,3)
-- 	end
-- end

-- vRP.giveInventoryItem(user_id,"componentemetal",1)
-- vRP.giveInventoryItem(user_id,"componenteeletronico",1)
-- vRP.giveInventoryItem(user_id,"componenteplastico",1)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"midnight.permissao") or vRP.hasPermission(user_id,"driftking.permissao")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	vRP.antiflood(source,"farm_motoclub",3)
	--emP.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local quantidade = math.random(2,3)
		vRP.antiflood(source,"motoclub",4)
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("serra")*quantidade <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id,"serra",quantidade)
			-- quantidade = nil
		else
			return TriggerClientEvent("Notify",source,"negado","Inventario cheio!")
		end
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("componentemetal")*1 <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id,"componentemetal",1)
		else
			return TriggerClientEvent("Notify",source,"negado","Inventario cheio!")
		end
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("componenteeletronico")*1 <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id,"componenteeletronico",1)
		else
			return TriggerClientEvent("Notify",source,"negado","Inventario cheio!")
		end
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("componenteplastico")*1 <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id,"componenteplastico",1)
		else
			return TriggerClientEvent("Notify",source,"negado","Inventario cheio!")
		end
		return true
	end
end
