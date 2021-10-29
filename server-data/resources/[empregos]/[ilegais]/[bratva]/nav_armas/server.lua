local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("nav_armas",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "corpodeg36", quantidade = 1, compra = 40000, venda = 10 },
	{ item = "corpodeak", quantidade = 1, compra = 30000, venda = 10 },
	{ item = "corpodeshotgun", quantidade = 1, compra = 20000, venda = 10 },
	{ item = "corpodemp5", quantidade = 1, compra = 25000, venda = 10 },
	{ item = "corpodescorpion", quantidade = 1, compra = 15000, venda = 10 },
	{ item = "corpodefiveseven", quantidade = 1, compra = 10000, venda = 10 }, -- Antigo valor R$ 83000
	{ item = "corpodehkp7m10", quantidade = 1, compra = 8000, venda = 10 },
	{ item = "mola", quantidade = 10, compra = 10000, venda = 10 },
	{ item = "gatilho", quantidade = 1, compra = 5000, venda = 10 },
	{ item = "capsula", quantidade = 25, compra = 2500, venda = 10 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("armas-comprar")
AddEventHandler("armas-comprar",function(item)
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
RegisterServerEvent("armas-vender")
AddEventHandler("armas-vender",function(item)
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
	return vRP.hasPermission(user_id,"yakuza.permissao") or vRP.hasPermission(user_id,"cn.permissao") or vRP.hasPermission(user_id,"sinaloa.permissao")
end

function emP.checkPermission2()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"")
end