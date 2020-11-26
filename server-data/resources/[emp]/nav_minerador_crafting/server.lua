local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	["bronze"] = { venda = 130 }, --185  --520
	["ferro"] = { venda = 80 }, --200  --460
	["ouro"] = { venda = 240 }, --170   --480
	["rubi"] = { venda = 245 }, --175   --500
	["esmeralda"] = { venda = 280 }, --190   --530
	["safira"] = { venda = 210 }, --150   --440
	["diamante"] = { venda = 290 }, --200  --5800
	["topazio"] = { venda = 270 }, --170   --480
	["ametista"] = { venda = 230 }  --190  --530
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("minerador-crafting")
AddEventHandler("minerador-crafting",function(item)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.tryGetInventoryItem(user_id,item.."2",3) then
            vRP.giveInventoryItem(user_id,item,1)
            TriggerClientEvent("Notify",source,"sucesso","Forjou <b>3x "..vRP.itemNameList(item.."2").."</b> em <b>1x "..vRP.itemNameList(item).."</b>.")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("minerador-vender")
AddEventHandler("minerador-vender",function(item)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.tryGetInventoryItem(user_id,item,1) then
            TriggerClientEvent("Notify",source,"sucesso","Vendeu <b>1x "..vRP.itemNameList(item).."</b> por <b>$"..parseInt(valores[item].venda).." dólares</b>.")
            vRP.giveMoney(user_id,valores[item].venda)
        end
    end
end)