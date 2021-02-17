local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("farm_yakuza",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUANTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}
function emP.Quantidade()
	local source = source
	if quantidade[source] == nil then
		quantidade[source] = math.random(1,3)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"yakuza.permissao")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	emP.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.antiflood(source,"yakuza",4)
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("placacircuito")*quantidade[source] <= vRP.getInventoryMaxWeight(user_id) then
		TriggerClientEvent("Notify",source,"sucesso","Você coletou <b> "..quantidade[source].."x Placa de Circuito</b>.")
		vRP.giveInventoryItem(user_id,"placacircuito",quantidade[source])
		quantidade[source] = nil
		return true
		end
	end
end
