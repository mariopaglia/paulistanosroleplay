local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("colheita_entregar", emP)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
    vRP.antiflood(source, "colheita_entregar", 3)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
		qnt = math.random(2,4)
		valor = math.random(800,1000)
        if vRP.tryGetInventoryItem(user_id, "morango", parseInt(qnt)) then
            vRP.giveMoney(user_id, parseInt(valor*qnt))
            TriggerClientEvent("Notify", source, "sucesso", "Vendeu <b>" .. parseInt(qnt) .. "x " .. vRP.itemNameList("morango") .. "</b> por <b>R$ " .. vRP.format(parseInt(valor*qnt)) .. "</b>.")
			return true
        else
            TriggerClientEvent("Notify", source, "aviso", "Não possui <b>" .. parseInt(qnt) .. "x " .. vRP.itemNameList("morango") .. "</b> em sua mochila.")
        end
    end
end
