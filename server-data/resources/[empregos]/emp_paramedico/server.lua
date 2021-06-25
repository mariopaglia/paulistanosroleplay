local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_paramedico",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"paramedico.permissao")
end

function emP.checkPayment(payment)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local randmoney = math.random(500,1000) -- 500,1000
		vRP.giveMoney(user_id,parseInt(randmoney))
		TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
        TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>R$ "..vRP.format(parseInt(randmoney)).."</b>.")
	end
end