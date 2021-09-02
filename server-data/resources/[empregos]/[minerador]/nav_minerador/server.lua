local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
    {item = "ferro", quantidade = 3, compra = 0, venda = 125},
    {item = "bronze", quantidade = 3, compra = 0, venda = 160},
    {item = "safira", quantidade = 3, compra = 0, venda = 200},
    {item = "ametista", quantidade = 3, compra = 0, venda = 230},
    {item = "ouro", quantidade = 3, compra = 0, venda = 270},
    {item = "rubi", quantidade = 3, compra = 0, venda = 310},
    {item = "topazio", quantidade = 3, compra = 0, venda = 350},
    {item = "esmeralda", quantidade = 3, compra = 0, venda = 410},
    {item = "diamante", quantidade = 3, compra = 0, venda = 450},
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("minerador-comprar")
AddEventHandler("minerador-comprar", function(item)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        for k, v in pairs(valores) do
            if item == v.item then
                if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(v.item) * v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
                    if vRP.tryPayment(user_id, parseInt(v.compra)) then
                        vRP.giveInventoryItem(user_id, v.item, parseInt(v.quantidade))
                        TriggerClientEvent("Notify", source, "sucesso", "Compra efetuada com sucesso!</b>")
                    else
                        TriggerClientEvent("Notify", source, "negado", "Dinheiro insuficiente.")
                    end
                else
                    TriggerClientEvent("Notify", source, "negado", "Espaço insuficiente.")
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("minerador-vender")
AddEventHandler("minerador-vender", function(item)
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
            for k, v in pairs(valores) do -- VALOR BUFFADO (+20%)
                if item == v.item then
                    if vRP.tryGetInventoryItem(user_id, v.item, parseInt(v.quantidade)) then
                        vRP.injectMoneyLimpo(user_id, parseInt((v.venda * 1.2) * v.quantidade))
                        TriggerClientEvent("Notify", source, "sucesso", "Vendeu <b>" .. parseInt(v.quantidade) .. "x " .. vRP.itemNameList(v.item) .. "</b> por <b>R$ " .. vRP.format(parseInt((v.venda * 1.2) * v.quantidade)) .. "</b> (Emprego Buffado).")
                    end
                end
            end
        else
            for k, v in pairs(valores) do -- VALOR NORMAL
                if item == v.item then
                    if vRP.tryGetInventoryItem(user_id, v.item, parseInt(v.quantidade)) then
                        vRP.injectMoneyLimpo(user_id, parseInt(v.venda * v.quantidade))
                        TriggerClientEvent("Notify", source, "sucesso", "Vendeu <b>" .. parseInt(v.quantidade) .. "x " .. vRP.itemNameList(v.item) .. "</b> por <b>R$ " .. vRP.format(parseInt(v.venda * v.quantidade)) .. "</b>.")
                    end
                end
            end
        end
    end
end)
