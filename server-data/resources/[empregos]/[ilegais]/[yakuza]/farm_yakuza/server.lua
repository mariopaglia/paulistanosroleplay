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
local quantidadetecido = {}
function emP.Quantidade()
	local source = source
	if quantidade[source] == nil and quantidadetecido[source] == nil then
		quantidade[source] = math.random(3,5)
		quantidadetecido[source] = math.random(2,3)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"yakuza.permissao") or vRP.hasPermission(user_id,"triade.permissao")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	vRP.antiflood(source,"farm_yakuza",3)
	emP.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.antiflood(source,"yakuza",4)
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("placacircuito")*quantidade[source] and vRP.getInventoryWeight(user_id)+vRP.getItemWeight("tecido")*quantidadetecido[source] <= vRP.getInventoryMaxWeight(user_id) then
		-- TriggerClientEvent("Notify",source,"sucesso","Você coletou <b> "..quantidade[source].."x Placa de Circuito</b>.")
		vRP.giveInventoryItem(user_id,"placacircuito",quantidade[source])
		vRP.giveInventoryItem(user_id,"tecido",quantidadetecido[source])
		quantidade[source] = nil
		quantidadetecido[source] = nil
		return true
		end
	end
end
