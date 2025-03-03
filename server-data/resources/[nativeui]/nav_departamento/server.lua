local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "mochila", quantidade = 1, compra = 10000, venda = 0 },
	{ item = "alianca", quantidade = 1, compra = 1000, venda = 0 },
	{ item = "alianca2", quantidade = 1, compra = 1000, venda = 0 },
	{ item = "roupas", quantidade = 1, compra = 10000, venda = 0 },
	{ item = "celular", quantidade = 1, compra = 3000, venda = 0 },
	{ item = "radio", quantidade = 1, compra = 1000, venda = 0 },
	{ item = "energetico", quantidade = 3, compra = 5000, venda = 0 },
	{ item = "militec", quantidade = 1, compra = 5000, venda = 0 },
	{ item = "repairkit", quantidade = 1, compra = 8000, venda = 0 },
	{ item = "pneu", quantidade = 1, compra = 1000, venda = 0 },
	{ item = "hamburguer", quantidade = 1, compra = 350, venda = 0 },
	{ item = "pizza", quantidade = 1, compra = 350, venda = 0 },
	{ item = "rosquinha", quantidade = 1, compra = 350, venda = 0 },
	{ item = "agua", quantidade = 1, compra = 350, venda = 0 },
	{ item = "sprite", quantidade = 1, compra = 350, venda = 0 },
	{ item = "leite", quantidade = 1, compra = 350, venda = 0 },
	{ item = "mamadeira", quantidade = 1, compra = 400, venda = 0 },
	{ item = "rosa", quantidade = 1, compra = 1000, venda = 0 },
	{ item = "comidapet", quantidade = 1, compra = 100, venda = 0 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("departamento-comprar")
AddEventHandler("departamento-comprar",function(item)
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
RegisterServerEvent("departamento-vender")
AddEventHandler("departamento-vender",function(item)
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