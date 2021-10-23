local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_lifeguard",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
end

function emP.checkPayment()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        randmoney = math.random(150,180)
        vRP.giveMoney(user_id,parseInt(randmoney))
        TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..parseInt(randmoney).." reais</b>.")
    end
end