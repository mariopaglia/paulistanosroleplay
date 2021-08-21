local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("farm_contrabando",emP)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	vRP.antiflood(source,"farm_contrabando",3)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then

		item1 = nil
		item2 = nil
		item3 = nil
		item4 = nil

		item1 = math.random(1,100)
		item2 = math.random(1,100)
		item3 = math.random(1,100)
		item4 = math.random(1,100)

		if item1 >= 50 then
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("componentemetal")*1 <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id,"componentemetal",1)
			item1 = nil
			end
		end

		if item2 >= 50 then
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("componenteeletronico")*1 <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id,"componenteeletronico",1)
			item2 = nil
			end
		end

		if item3 >= 50 then
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("componenteplastico")*1 <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id,"componenteplastico",1)
			item3 = nil
			end
		end

		if item4 >= 50 then
			dinheirosujo = nil
			dinheirosujo = math.random(500,1000)
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("dinheirosujo")*dinheirosujo <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id,"dinheirosujo",dinheirosujo)
			item4 = nil
			dinheirosujo = nil
			end
		end

		return true
		
	end
end
