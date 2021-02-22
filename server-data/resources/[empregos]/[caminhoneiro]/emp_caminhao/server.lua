local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_caminhao",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local gasolina = 1
local carros = 1
local show = 1
local madeira = 1
local diesel = 1
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local paylist = {
	-- 40 segundos para andar 1km
	["diesel"] = {
		[1] = { pay = math.random(5000,6000) }, -- (7.53km) x 2 = 15,06km = 10m
		[2] = { pay = math.random(4400,5400) }, -- (7.20km) x 2 = 14,4km = 9m
		[3] = { pay = math.random(4400,5400) }, -- (7.15km) x 2 = 14,3km = 9m
		[4] = { pay = math.random(5600,6600) }, -- (8.29km) x 2 = 16,58km = 11m
		[5] = { pay = math.random(8000,9000) }, -- (11.46km) x 2 = 22,92km = 15m
		[6] = { pay = math.random(4400,5400) } -- (6.90km) x 2 = 13,8km = 9m
	},
	["gasolina"] = {
		[1] = { pay = math.random(6200,7200) }, -- (9.11km) x 2 = 18,22km = 12m
		[2] = { pay = math.random(3200,4200) }, -- (5.68km) x 2 = 11,36km = 7m
		[3] = { pay = math.random(2600,3600) }, -- (4.88km) x 2 = 9,76km = 6m
		[4] = { pay = math.random(1400,2400) }, -- (2.92km) x 2 = 5,84km = 4m
		[5] = { pay = math.random(1400,2400) }, -- (2.75km) x 2 = 5,50km = 4m
		[6] = { pay = math.random(2000,3000) }, -- (3.75km) x 2 = 7,50km = 5m
		[7] = { pay = math.random(3200,4200) } -- (5.01km) x 2 = 10,02km = 7m
	},
	["carros"] = {
		[1] = { pay = math.random(2600,3600) }, -- (4.51km) x 2 = 9,02km = 6m
		[2] = { pay = math.random(1400,2400) }, -- (3.34km) x 2 = 6,68km = 4m
		[3] = { pay = math.random(2000,3000) }, -- (4.08km) x 2 = 8,16km = 5m
		[4] = { pay = math.random(2000,3000) }, -- (3.51km) x 2 = 7,02km = 5m
		[5] = { pay = math.random(4400,5400) }, -- (7.05km) x 2 = 14,1km = 9m
		[6] = { pay = math.random(1400,2400) } -- (3.28km) x 2 = 6,56km = 4m
	},
	["madeira"] = {
		[1] = { pay = math.random(8000,9000) }, -- (11.05km) x 2 = 22,10km = 15m
		[2] = { pay = math.random(5600,6600) }, -- (8.02km) x 2 = 16,04km = 11m
		[3] = { pay = math.random(1400,2400) }, -- (2.84km) x 2 = 5,68km = 4m
		[4] = { pay = math.random(2000,3000) } -- (4.08km) x 2 = 8,16km = 5m
	},
	["show"] = {
		[1] = { pay = math.random(5000,6000) }, -- (7.80km) x 2 = 15,60km = 10m
		[2] = { pay = math.random(2600,3600) }, -- (4.72km) x 2 = 9,44km = 6m
		[3] = { pay = math.random(2600,3600) }, -- (4.94km) x 2 = 9,88km = 6m
		[4] = { pay = math.random(1400,2400) } -- (2.69km) x 2 = 5,38km = 4m
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment(id,mod,health)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.antiflood(source,"caminhoneiro",3)
		vRP.giveMoney(user_id,parseInt(paylist[mod][id].pay+(health-700)))
		TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
		TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>R$ "..vRP.format(parseInt(paylist[mod][id].pay+(health-700))).."</b>.")
		if mod == "carros" then
			local value = vRP.getSData("meta:concessionaria")
			local metas = json.decode(value) or 0
			if metas then
				vRP.setSData("meta:concessionaria",json.encode(parseInt(metas+1)))
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300000)
		diesel = math.random(#paylist["diesel"])
		gasolina = math.random(#paylist["gasolina"])
		carros = math.random(#paylist["carros"])
		madeira = math.random(#paylist["madeira"])
		show = math.random(#paylist["show"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETTRUCKPOINT
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.getTruckpoint(point)
	if point == "diesel" then
		return parseInt(diesel)
	elseif point == "gasolina" then
		return parseInt(gasolina)
	elseif point == "carros" then
		return parseInt(carros)
	elseif point == "madeira" then
		return parseInt(madeira)
	elseif point == "show" then
		return parseInt(show)
	end
end