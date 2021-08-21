local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

L1s = {}
Tunnel.bindInterface("stopzera_tattoos",L1s)
L1c = Tunnel.getInterface("stopzera_tattoos")

tattooListPrice = {
	["mpairraces_overlays"] = 1700,
	["mpbiker_overlays"] = 1600,
	["mpchristmas2_overlays"] = 1450,
	["mpgunrunning_overlays"] = 1650,
	["mphipster_overlays"] = 1400,
	["mpimportexport_overlays"] = 1750,
	["mplowrider_overlays"] = 2500,
	["mplowrider2_overlays"] = 1950,
	["mpluxe_overlays"] = 1500,
	["mpluxe2_overlays"] = 1550,
	["mpsmuggler_overlays"] = 1800,
	["mpstunt_overlays"] = 1850,
	["multiplayer_overlays"] = 1900
}
function L1s.buyTattoos(data)
	local _source = source
	local user_id = vRP.getUserId(_source)
	if user_id then
		if data.tattooIndex then
		--	if vRP.paymentBank(user_id,tattooListPrice[data.tattooType]) then
			if vRP.tryFullPayment(user_id,tattooListPrice[data.tattooType]) then
				L1c.setSpecifiedTattoo(_source,data.tattooIndex,data.tattooType)
				TriggerClientEvent("Notify",_source,"sucesso","Pagou <b>R$ "..tattooListPrice[data.tattooType].."</b>.",8000)
				L1c.refreshNUITattoos(_source)
			else
				TriggerClientEvent("Notify",_source,"negado","Dinheiro insuficiente.",8000)
			end
		end
	end
end

function L1s.saveTattoos(data)
	local _source = source
	local user_id = vRP.getUserId(_source)
	if user_id then
		vRP.setUData(parseInt(user_id),"vRP:tattoos",json.encode(data))
	end
end

function L1s.getUserTattooDataAndPrices(data)
	local _source = source
	local user_id = vRP.getUserId(_source)
	if user_id then
		local resultTable = {}
		local myTattoos,cfg = L1c.getTattoosAndCFG(_source)
		for k,v in pairs(cfg.tattoos[data.tattooType]._list) do
			local owned = false
			if myTattoos then
				if myTattoos[k] then owned = true; end
			end
			table.insert(resultTable,{
				_index = k,
				_name = v,
				_owned = tostring(owned),
				_price = parseInt(tattooListPrice[data.tattooType])
			})
		end
		return resultTable
	end
end

AddEventHandler("vRP:playerSpawn", function(user_id, source)
	-- print(user_id)
	local value = vRP.getUData(parseInt(user_id),"vRP:tattoos")
	local custom = json.decode(value) or {}
	if value then
		for i=100,1,-1
		do
			L1c.setTattoos(source,custom)
		end
	end
end)