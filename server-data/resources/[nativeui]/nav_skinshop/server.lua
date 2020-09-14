-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("nav_skinshop",src)
vCLIENT = Tunnel.getInterface("nav_skinshop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPBUY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.shopBuy(old_custom)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local custom = vRPclient.getCustomization(source)
		local price = 0
		custom.modelhash = nil
		for k,v in pairs(custom) do				
			local old = old_custom[k]

			if v[1] ~= old[1] and k ~= 12 then
				price = price + 20
			end
			if v[2] ~= old[2] and k ~= 12 then
				price = price + 5
			end
		end

		if vRP.tryFullPayment(user_id,price) then
			if price > 0 then
				TriggerClientEvent("Notify",source,"sucesso","Comprou <b>$"..vRP.format(parseInt(price)).."</b> em roupas e acessórios.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
			vRPclient._setCustomization(source,old_custom)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSEARCH
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkSearch()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.searchReturn(source,user_id) then
			return true
		end
		return false
	end
end