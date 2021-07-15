local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "ferro", quantidade = 3, compra = 0, venda = 250 }, -- 125
	{ item = "bronze", quantidade = 3, compra = 0, venda = 320 }, -- 160
	{ item = "safira", quantidade = 3, compra = 0, venda = 400 }, -- 200
	{ item = "ametista", quantidade = 3, compra = 0, venda = 460 }, -- 230
	{ item = "ouro", quantidade = 3, compra = 0, venda = 540 }, -- 270
	{ item = "rubi", quantidade = 3, compra = 0, venda = 620 }, -- 310
	{ item = "topazio", quantidade = 3, compra = 0, venda = 700 }, -- 350
	{ item = "esmeralda", quantidade = 3, compra = 0, venda = 820 }, -- 410
	{ item = "diamante", quantidade = 3, compra = 0, venda = 900 }, -- 450
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("minerador-comprar")
AddEventHandler("minerador-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.tryPayment(user_id,parseInt(v.compra)) then
						vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
						TriggerClientEvent("Notify",source,"sucesso","Compra efetuada com sucesso!</b>")
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
					end
				else
					TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
				end
			end
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
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.tryGetInventoryItem(user_id,v.item,parseInt(v.quantidade)) then
					vRP.injectMoneyLimpo(user_id,parseInt(v.venda*v.quantidade))
					TriggerClientEvent("Notify",source,"sucesso","Vendeu <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> por <b>R$ "..vRP.format(parseInt(v.venda*v.quantidade)).." reais</b>.")
				end
			end
		end
	end
end)