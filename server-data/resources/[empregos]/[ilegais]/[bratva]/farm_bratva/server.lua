local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("farm_bratva",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUANTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}
local quantidadepolvora = {}
function emP.Quantidade()
	local source = source
	if quantidade[source] == nil and quantidadepolvora[source] == nil then
		quantidade[source] = math.random(4,6)
		quantidadepolvora[source] = math.random(7,10)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"yakuza.permissao") or vRP.hasPermission(user_id,"cn.permissao") or vRP.hasPermission(user_id,"sinaloa.permissao")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	vRP.antiflood(source,"farm_bratva",3)
	emP.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("placademetal")*quantidade[source] and vRP.getInventoryWeight(user_id)+vRP.getItemWeight("polvora")*quantidadepolvora[source] <= vRP.getInventoryMaxWeight(user_id) then
		vRP.giveInventoryItem(user_id,"placademetal",quantidade[source])
		vRP.giveInventoryItem(user_id,"polvora",quantidadepolvora[source])
		quantidade[source] = nil
		quantidadepolvora[source] = nil
		return true
		end
	end
end
