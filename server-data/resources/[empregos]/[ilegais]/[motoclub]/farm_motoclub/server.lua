local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("farm_motoclub",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUANTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}
function emP.Quantidade()
	local source = source
	if quantidade[source] == nil then
		quantidade[source] = 1
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"motoclub.permissao")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	vRP.antiflood(source,"farm_motoclub",3)
	emP.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.antiflood(source,"motoclub",4)
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("serra")*quantidade[source] <= vRP.getInventoryMaxWeight(user_id) then
		TriggerClientEvent("Notify",source,"sucesso","Você coletou <b> "..quantidade[source].."x Serra</b>.")
		vRP.giveInventoryItem(user_id,"serra",quantidade[source])
		quantidade[source] = nil
		return true
		end
	end
end
