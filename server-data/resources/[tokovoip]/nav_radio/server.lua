local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("nav_radio",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return true
	else
		TriggerClientEvent("Notify",source,"negado","Você não tem permissão.",8000)
		return false
	end
end

function emP.checkPermission2(perm,grupo)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,perm) or vRP.hasPermission(user_id, "founder.permissao") then
		TriggerClientEvent("Notify",source,"sucesso","Entrou no rádio <b>"..grupo.."</b>.",8000)
		return true
	else
		TriggerClientEvent("Notify",source,"negado","Você não tem permissão.",8000)
		return false
	end
end

--[[function emP.checkgroup()
	local source = source
	local user_id = vRP.getUserId(source)
	local policia = vRP.getUsersByPermission("policia.permissao")
	if user_id and policia then
		return true
	else
		TriggerClientEvent("Notify",source,"negado","Você não tem permissão.",8000)
		return false
	end
end]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKRADIO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkRadio()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"radio") >= 1 then
		return true
	else
		TriggerClientEvent("Notify",source,"importante","Você precisa comprar o <b>Rádio</b> em uma <b>Loja de Eletrônicos</b>.",8000)
		return false
	end
end

function emP.checkRadio2()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"radio") < 1 then
		return true
	end
end