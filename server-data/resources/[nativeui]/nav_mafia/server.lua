local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("nav_mafia",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "wbody|WEAPON_PISTOL_MK2", quantidade = 1, compra = 3000, venda = 1500 },
	{ item = "wbody|WEAPON_MICROSMG", quantidade = 1, compra = 20000, venda = 10000 },
	{ item = "wbody|WEAPON_ASSAULTSMG", quantidade = 1, compra = 12000, venda = 6000 },
	{ item = "wbody|WEAPON_ASSAULTRIFLE", quantidade = 1, compra = 21000, venda = 10500 },
	{ item = "wbody|WEAPON_REVOLVER", quantidade = 1, compra = 10000, venda = 5000 },
	{ item = "wbody|WEAPON_GUSENBERG", quantidade = 1, compra = 15000, venda = 7500 },

	{ item = "wammo|WEAPON_SNSPISTOL", quantidade = 50, compra = 250, venda = 125 },
	{ item = "wammo|WEAPON_MICROSMG", quantidade = 50, compra = 300, venda = 150 },
	{ item = "wammo|WEAPON_ASSAULTSMG", quantidade = 50, compra = 300, venda = 150 },
	{ item = "wammo|WEAPON_ASSAULTRIFLE", quantidade = 50, compra = 300, venda = 150 },
	{ item = "wammo|WEAPON_PISTOL_MK2", quantidade = 50, compra = 250, venda = 125 },
	{ item = "wammo|WEAPON_REVOLVER", quantidade = 50, compra = 250, venda = 125 },
	{ item = "wammo|WEAPON_GUSENBERG", quantidade = 50, compra = 300, venda = 150 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("mafia-comprar")
AddEventHandler("mafia-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.tryGetInventoryItem(user_id,"aco",v.compra) then
						vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
						TriggerClientEvent("Notify",source,"sucesso","Compra efetuada com sucesso.")
					else
						TriggerClientEvent("Notify",source,"negado","Aço insuficiente.")
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
RegisterServerEvent("mafia-vender")
AddEventHandler("mafia-vender",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.tryGetInventoryItem(user_id,v.item,parseInt(v.quantidade)) then
					vRP.giveInventoryItem(user_id,"aco",parseInt(v.venda))
					TriggerClientEvent("Notify",source,"sucesso","Venda efetuada com sucesso!")
				else
					TriggerClientEvent("Notify",source,"negado","Não possui este item em sua mochila.")
				end
			end
		end
	end
end)

function emP.checkPermission1()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"mafia.permissao")
end

function emP.checkPermission2()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"motoclub.permissao")
end