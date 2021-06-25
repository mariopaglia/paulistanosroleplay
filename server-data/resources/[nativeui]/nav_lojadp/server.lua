local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("nav_lojadp",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
    {item = "wbody|WEAPON_PISTOL", quantidade = 1, compra = 100000, venda = 0}, -- M1911
    {item = "wammo|WEAPON_PISTOL", quantidade = 50, compra = 45000, venda = 0}, -- MUNICAO M1911
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("lojadp-comprar")
AddEventHandler("lojadp-comprar",function(item)
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
RegisterServerEvent("lojadp-vender")
AddEventHandler("lojadp-vender",function(item)
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
	return vRP.hasPermission(user_id,"pmfciv.permissao")
end

function emP.checkPermission2()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"")
end