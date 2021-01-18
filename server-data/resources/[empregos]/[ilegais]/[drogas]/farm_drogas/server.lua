local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("farm_drogas",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUANTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}
function emP.Quantidade()
	local source = source
	if quantidade[source] == nil then
		quantidade[source] = math.random(3,6)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECAR PERMISSÃO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"verdes.permissao") or vRP.hasPermission(user_id,"vermelhos.permissao") or vRP.hasPermission(user_id,"roxos.permissao") then
        return true
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	emP.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"verdes.permissao") then
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("adubo")*quantidade[source] <= vRP.getInventoryMaxWeight(user_id) then
				TriggerClientEvent("Notify",source,"sucesso","Você coletou <b> "..quantidade[source].."x Adubo</b>")
				vRP.giveInventoryItem(user_id,"adubo",quantidade[source])
				quantidade[source] = nil
				return true
			end
		elseif vRP.hasPermission(user_id,"vermelhos.permissao") then
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("pastadecoca")*quantidade[source] <= vRP.getInventoryMaxWeight(user_id) then
				TriggerClientEvent("Notify",source,"sucesso","Você coletou <b> "..quantidade[source].."x Pasta de Coca</b>")
				vRP.giveInventoryItem(user_id,"pastadecoca",quantidade[source])
				quantidade[source] = nil
				return true
			end
		elseif vRP.hasPermission(user_id,"roxos.permissao") then
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("anfetamina")*quantidade[source] <= vRP.getInventoryMaxWeight(user_id) then
				TriggerClientEvent("Notify",source,"sucesso","Você coletou <b> "..quantidade[source].."x Anfetamina</b>")
				vRP.giveInventoryItem(user_id,"anfetamina",quantidade[source])
				quantidade[source] = nil
				return true
			end
		end
	end
end
