local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("nav_barzinho",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "tequila", quantidade = 1, compra = 200, venda = 0 },
	{ item = "vodka", quantidade = 1, compra = 200, venda = 0 },
	{ item = "cerveja", quantidade = 1, compra = 200, venda = 0 },
	{ item = "whisky", quantidade = 1, compra = 200, venda = 0 },
	{ item = "conhaque", quantidade = 1, compra = 200, venda = 0 },
	{ item = "absinto", quantidade = 1, compra = 200, venda = 0 },
	{ item = "agua", quantidade = 1, compra = 80, venda = 0 },
	{ item = "hamburguer", quantidade = 1, compra = 100, venda = 0 },
	{ item = "pizza", quantidade = 1, compra = 100, venda = 0 },
	{ item = "rosquinha", quantidade = 1, compra = 100, venda = 0 },
	{ item = "sanduiche", quantidade = 1, compra = 100, venda = 0 },
	{ item = "frangofrito", quantidade = 1, compra = 100, venda = 0 },
	{ item = "batatafrita", quantidade = 1, compra = 100, venda = 0 },
	{ item = "cachorroquente", quantidade = 1, compra = 100, venda = 0 },
	{ item = "sprite", quantidade = 1, compra = 80, venda = 0 },
	{ item = "leite", quantidade = 1, compra = 80, venda = 0 },
	{ item = "mamadeira", quantidade = 1, compra = 80, venda = 0 },
	{ item = "cafe", quantidade = 1, compra = 80, venda = 0 },
	{ item = "cappuccino", quantidade = 1, compra = 80, venda = 0 },
	{ item = "suco", quantidade = 1, compra = 80, venda = 0 },
	{ item = "cocacola", quantidade = 1, compra = 80, venda = 0 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("barzinho-comprar")
AddEventHandler("barzinho-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.tryFullPayment(user_id,parseInt(v.compra)) then
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
RegisterServerEvent("barzinho-vender")
AddEventHandler("barzinho-vender",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.tryGetInventoryItem(user_id,v.item,parseInt(v.quantidade)) then
					vRP.giveMoney(user_id,parseInt(v.venda))
					TriggerClientEvent("Notify",source,"sucesso","Vendeu <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.venda)).." reais</b>.")
				else
					TriggerClientEvent("Notify",source,"aviso","Não possui <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> em sua mochila.")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECAR PERMISSÃO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission1()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"beanmachine.permissao") or vRP.hasPermission(user_id,"kick.permissao")
end