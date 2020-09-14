local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_fazenda",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}
local porcentagem = 0
local itemname = ""
function emP.Quantidade()
	local source = source
	if quantidade[source] == nil then
		quantidade[source] = math.random(1,2)
	end
end

function emP.checkWeight()
	emP.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		porcentagem = math.random(100)
		if porcentagem <= 10 then
			itemname = "cereja"
		elseif porcentagem >= 10 and porcentagem <= 100 then
			itemname = "amora"
		end
		return vRP.getInventoryWeight(user_id)+vRP.getItemWeight(itemname)*quantidade[source] <= vRP.getInventoryMaxWeight(user_id)
	end
end

function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.giveInventoryItem(user_id,itemname,quantidade[source])
		TriggerClientEvent("Notify",source,"sucesso","Encontrou <b>"..quantidade[source].."x "..vRP.itemNameList(itemname).."</b>.",8000)
		quantidade[source] = nil
	end
end