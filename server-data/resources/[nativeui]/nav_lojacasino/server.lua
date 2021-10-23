local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("nav_casino",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "casino_token", quantidade = 1000, compra = 1000, venda = 1000 },
	{ item = "casino_ticket", quantidade = 1, compra = 10000, venda = 1 },
	{ item = "raspadinha", quantidade = 1, compra = 5000, venda = 1 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("casino-comprar")
AddEventHandler("casino-comprar",function(item)
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
-- COMPRAR FICHAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("casino-comprar-fichas")
AddEventHandler("casino-comprar-fichas",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local fichas = vRP.prompt(source, "Informe a quantidade de fichas:", "")
		if fichas ~= "" then
			if vRP.tryFullPayment(user_id,parseInt(fichas)) then
				vRP.giveInventoryItem(user_id,"casino_token",parseInt(fichas))
				TriggerClientEvent("Notify",source,"sucesso","Você comprou <b>"..vRP.format(fichas).."</b> fichas por <b>R$ "..vRP.format(fichas).."</b></b>")
			else
				TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDER FICHAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("casino-vender-fichas")
AddEventHandler("casino-vender-fichas",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local fichas = vRP.prompt(source, "Informe a quantidade de fichas:", "")
		if fichas ~= "" then
			if vRP.tryGetInventoryItem(user_id,"casino_token",parseInt(fichas)) then
				vRP.giveBankMoney(user_id,parseInt(fichas))
				TriggerClientEvent("Notify",source,"sucesso","Vendeu <b>"..vRP.format(fichas).."</b> fichas por <b>R$ "..vRP.format(fichas).."</b>")
			else
				TriggerClientEvent("Notify",source,"aviso","Não possui "..vRP.format(fichas).." fichas em sua mochila.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("casino-vender")
AddEventHandler("casino-vender",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.tryGetInventoryItem(user_id,v.item,parseInt(v.quantidade)) then
					vRP.giveBankMoney(user_id,parseInt(v.venda))
					TriggerClientEvent("Notify",source,"sucesso","Vendeu <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.venda)).." reais</b>.")
				else
					TriggerClientEvent("Notify",source,"aviso","Não possui <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> em sua mochila.")
				end
			end
		end
	end
end)