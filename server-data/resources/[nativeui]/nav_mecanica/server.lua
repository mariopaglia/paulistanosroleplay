local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("nav_mecanica",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "militec", quantidade = 1, compra = 5000, venda = 1 },
	{ item = "repairkit", quantidade = 1, compra = 8000, venda = 1 },
	{ item = "pneu", quantidade = 1, compra = 1000, venda = 1 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("mecanica-comprar")
AddEventHandler("mecanica-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
					
					-- COMPRA DE MECANICO COM DESCONTO
					if item == "militec" and vRP.hasPermission(user_id, "mecanico.permissao") then
						if vRP.tryFullPayment(user_id,parseInt(500)) then
							vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
							TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..vRP.itemNameList(item).."</b> e pagou <b>R$ 500</b>")
							return true
						else
							TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
							return false
						end
					end
					if item == "repairkit" and vRP.hasPermission(user_id, "mecanico.permissao") then
						if vRP.tryFullPayment(user_id,parseInt(1000)) then
							vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
							TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..vRP.itemNameList(item).."</b> e pagou <b>R$ 1.000</b>")
							return true
						else
							TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
							return false
						end
					end
					if item == "pneu" and vRP.hasPermission(user_id, "mecanico.permissao") then
						if vRP.tryFullPayment(user_id,parseInt(100)) then
							vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
							TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..vRP.itemNameList(item).."</b> e pagou <b>R$ 100</b>")
							return true
						else
							TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
							return false
						end
					end
					
					-- COMPRA DE CÍVIL
					if vRP.tryFullPayment(user_id,parseInt(v.compra)) then
						vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
						TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..vRP.itemNameList(item).."</b> e pagou <b>R$ "..vRP.format(parseInt(v.compra)).."</b>")
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
RegisterServerEvent("mecanica-vender")
AddEventHandler("mecanica-vender",function(item)
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
	return vRP.hasPermission(user_id,"mecanico.permissao")
end

function emP.checkPermission2()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"")
end