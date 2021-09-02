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
    local buffado = false -- true (emprego buffado) / false (emprego normal)

    -- BUFFAR AUTOMATICAMENTE EMPREGOS AOS FINAIS DE SEMANA
    local diaSemana = os.date("%w")
    if diaSemana == "6" or diaSemana == "0" then
        buffado = true
    end
    
    if user_id then
        if buffado then
            local qnt = 1
            local valor = 1320 -- VALOR BUFFADO (+20%)
            if vRP.tryGetInventoryItem(user_id, "morango", parseInt(qnt)) then
                vRP.giveMoney(user_id, parseInt(valor * qnt))
                TriggerClientEvent("Notify", source, "sucesso", "Vendeu <b>" .. parseInt(qnt) .. "x " .. vRP.itemNameList("morango") .. "</b> por <b>R$ " .. vRP.format(parseInt(valor * qnt)) .. "</b> (Emprego Buffado).")
                return true
            else
                TriggerClientEvent("Notify", source, "aviso", "Não possui <b>" .. parseInt(qnt) .. "x " .. vRP.itemNameList("morango") .. "</b> em sua mochila.")
            end
        else
            local qnt = 1
            local valor = 1100 -- VALOR NORMAL
            if vRP.tryGetInventoryItem(user_id, "morango", parseInt(qnt)) then
                vRP.giveMoney(user_id, parseInt(valor * qnt))
                TriggerClientEvent("Notify", source, "sucesso", "Vendeu <b>" .. parseInt(qnt) .. "x " .. vRP.itemNameList("morango") .. "</b> por <b>R$ " .. vRP.format(parseInt(valor * qnt)) .. "</b>.")
                return true
            else
                TriggerClientEvent("Notify", source, "aviso", "Não possui <b>" .. parseInt(qnt) .. "x " .. vRP.itemNameList("morango") .. "</b> em sua mochila.")
            end
        end
    end
end
