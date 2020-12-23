local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("farm_cosanostra",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUANTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}
local quantidadetecido = {}
function emP.Quantidade()
	local source = source
	if quantidade[source] == nil and quantidadetecido[source] == nil then
		quantidade[source] = math.random(6,8)
		quantidadetecido[source] = math.random(5,15)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"cn.permissao")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	emP.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("polvora")*quantidade[source] and vRP.getInventoryWeight(user_id)+vRP.getItemWeight("tecido")*quantidadetecido[source] <= vRP.getInventoryMaxWeight(user_id) then
		vRP.giveInventoryItem(user_id,"polvora",quantidade[source])
		vRP.giveInventoryItem(user_id,"tecido",quantidadetecido[source])
		TriggerClientEvent("Notify",source,"sucesso","Você coletou <b> "..quantidade[source].."x Polvoras</b>.")
		TriggerClientEvent("Notify",source,"sucesso","Você coletou <b> "..quantidadetecido[source].."x Tecidos</b>.")
		quantidade[source] = nil
		quantidadetecido[source] = nil
		return true
		end
	end
end
