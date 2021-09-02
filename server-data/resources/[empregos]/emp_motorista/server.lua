local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_motorista", emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
    vRP.antiflood(source, "motorista", 3)
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
            local randmoney = math.random(300, 360) -- VALOR BUFFADO (+20%)
            vRP.injectMoneyLimpo(user_id, randmoney)
            TriggerClientEvent("vrp_sound:source", source, 'coins', 0.5)
            TriggerClientEvent("Notify", source, "sucesso", "Você deixou um passageiro e ganhou <b>R$ " .. vRP.format(parseInt(randmoney)) .. "</b> (Emprego Buffado).")
        else
            local randmoney = math.random(250, 300) -- VALOR NORMAL
            vRP.injectMoneyLimpo(user_id, randmoney)
            TriggerClientEvent("vrp_sound:source", source, 'coins', 0.5)
            TriggerClientEvent("Notify", source, "sucesso", "Você deixou um passageiro e ganhou <b>R$ " .. vRP.format(parseInt(randmoney)) .. "</b>.")
        end
    end
end
