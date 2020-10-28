local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("farm_mafia",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUANTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}
function emP.Quantidade()
	local source = source
	if quantidade[source] == nil then
		quantidade[source] = math.random(10,12)
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
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("polvora")*quantidade[source] <= vRP.getInventoryMaxWeight(user_id) then
		TriggerClientEvent("Notify",source,"sucesso","Você coletou <b> "..quantidade[source].."x Polvoras</b>.")
		local quantidade2 = math.random(6,8)	
		TriggerClientEvent("Notify",source,"sucesso","Você coletou <b> "..quantidade2.."x Placas de Metal</b>.")
		vRP.giveInventoryItem(user_id,"polvora",quantidade[source])
		vRP.giveInventoryItem(user_id,"placademetal",quantidade2)
		quantidade[source] = nil
		return true
		end
	end
end
