local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_colheita",emP)

-----------------------------------------------------------------------------------------------------------------------------------------
-- AÇÃO DE TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.trabalhando()
    local source = source
    local user_id = vRP.getUserId(source)

    if user_id then
        vRPclient._playAnim(source,false,{{"amb@world_human_gardener_plant@female@base","base_female"}},true)
        Citizen.Wait(3000)
        vRPclient._stopAnim(source,false,{{"amb@world_human_gardener_plant@female@base","base_female"}},true)
        return
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO (RECEBIMENTO DE ITENS)
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        randgraos = 1
        if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("morango") <= vRP.getInventoryMaxWeight(user_id) then
            vRP.giveInventoryItem(user_id,"morango",parseInt(randgraos))
            TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>"..randgraos.."</b> Morango.")
        else
            TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.")
        end
    end
end