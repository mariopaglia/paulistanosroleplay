local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("lixeiro_coletar",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("sacodelixo") <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id,"sacodelixo",1)
			
			local sorte = math.random(1,100)
		
			if sorte >= 70 then
				local item = math.random(1,3)
				if item == 1 then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("componentemetal") <= vRP.getInventoryMaxWeight(user_id) then
						vRP.giveInventoryItem(user_id,"componentemetal",1)
					end
				elseif item == 2 then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("componenteeletronico") <= vRP.getInventoryMaxWeight(user_id) then
						vRP.giveInventoryItem(user_id,"componenteeletronico",1)
					end
				elseif item == 3 then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("componenteplastico") <= vRP.getInventoryMaxWeight(user_id) then
						vRP.giveInventoryItem(user_id,"componenteplastico",1)
					end
				end
			end
		end
		return true
	end
end