local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_motorista",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	vRP.antiflood(source,"motorista",3)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local randmoney = math.random(250,300)
		vRP.injectMoneyLimpo(user_id,randmoney)
		TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
        TriggerClientEvent("Notify",source,"sucesso","Você deixou um passageiro e ganhou <b>R$ "..vRP.format(parseInt(randmoney)).."</b>.")
	end
end