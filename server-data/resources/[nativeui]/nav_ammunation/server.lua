local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
    {item = "wbody|WEAPON_KNUCKLE", quantidade = 1, compra = 5000, venda = 2500}, -- Soco ingles
    {item = "wbody|WEAPON_KNIFE", quantidade = 1, compra = 4000, venda = 2000}, -- Faca
    {item = "wbody|WEAPON_SWITCHBLADE", quantidade = 1, compra = 4000, venda = 2000}, -- Canivete
    {item = "wbody|WEAPON_MACHETE", quantidade = 1, compra = 3000, venda = 1500}, -- Machete
    {item = "wbody|WEAPON_WRENCH", quantidade = 1, compra = 3000, venda = 1500}, -- Chave de grifo
    {item = "wbody|WEAPON_HAMMER", quantidade = 1, compra = 3000, venda = 1500}, -- Martelo
    {item = "wbody|WEAPON_CROWBAR", quantidade = 1, compra = 3000, venda = 1500}, -- Pé-de-cabra
    {item = "wbody|WEAPON_BAT", quantidade = 1, compra = 3000, venda = 1500}, -- Taco de beisebol
    {item = "wbody|WEAPON_POOLCUE", quantidade = 1, compra = 3000, venda = 1500}, -- Taco de sinuca
    {item = "wbody|GADGET_PARACHUTE", quantidade = 1, compra = 3000, venda = 1500}, -- Paraquedas
    {item = "colete", quantidade = 1, compra = 40000, venda = 10}, -- Colete
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("armamentos-comprar")
AddEventHandler("armamentos-comprar", function(item)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        for k, v in pairs(valores) do
            if item == v.item then
                if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(v.item) * v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
                    if vRP.tryFullPayment(user_id, parseInt(v.compra)) then
                        vRP.giveInventoryItem(user_id, v.item, parseInt(v.quantidade))
                        TriggerClientEvent("Notify", source, "sucesso", "Comprou <b>" .. parseInt(v.quantidade) .. "x " .. vRP.itemNameList(v.item) .. "</b> por <b>R$ " .. vRP.format(parseInt(v.compra)) .. " reais</b>.")
                    else
                        TriggerClientEvent("Notify", source, "aviso", "Dinheiro insuficiente.")
                    end
                else
                    TriggerClientEvent("Notify", source, "aviso", "Espaço insuficiente.")
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("armamentos-vender")
AddEventHandler("armamentos-vender", function(item)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        for k, v in pairs(valores) do
            if item == v.item then
                if vRP.tryGetInventoryItem(user_id, v.item, parseInt(v.quantidade)) then
                    vRP.giveMoney(user_id, parseInt(v.venda))
                    TriggerClientEvent("Notify", source, "sucesso", "Vendeu <b>" .. parseInt(v.quantidade) .. "x " .. vRP.itemNameList(v.item) .. "</b> por <b>R$ " .. vRP.format(parseInt(v.venda)) .. " reais</b>.")
                else
                    TriggerClientEvent("Notify", source, "aviso", "Não possui <b>" .. parseInt(v.quantidade) .. "x " .. vRP.itemNameList(v.item) .. "</b> em sua mochila.")
                end
            end
        end
    end
end)
