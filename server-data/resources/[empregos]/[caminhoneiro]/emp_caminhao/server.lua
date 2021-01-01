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
	["diesel"] = {
		[1] = { pay = math.random(6250,6750) },
		[2] = { pay = math.random(6250,6750) },
		[3] = { pay = math.random(6250,6750) },
		[4] = { pay = math.random(6350,7000) },
		[5] = { pay = math.random(9500,9700) },
		[6] = { pay = math.random(5560,5850) }
	},
	["gasolina"] = {
		[1] = { pay = math.random(7500,7800) },
		[2] = { pay = math.random(4800,5200) },
		[3] = { pay = math.random(2900,3300) },
		[4] = { pay = math.random(2550,2800) },
		[5] = { pay = math.random(1900,2100) },
		[6] = { pay = math.random(2500,2650) },
		[7] = { pay = math.random(4800,4950) }
		--[8] = { pay = math.random(360,460) },  -- Sem Valor Alterado
		--[9] = { pay = math.random(430,500) },
		--[10] = { pay = math.random(1040,1150) },
		--[11] = { pay = math.random(1090,1190) },
		--[12] = { pay = math.random(870,970) }
	},
	["carros"] = {
		[1] = { pay = math.random(3600,3800) },
		[2] = { pay = math.random(2600,2700) },
		[3] = { pay = math.random(3300,3350) },
		[4] = { pay = math.random(2800,2950) },
		[5] = { pay = math.random(5750,5950) },
		[6] = { pay = math.random(2600,2750) }
	},
	["madeira"] = {
		[1] = { pay = math.random(9250,9800) },
		[2] = { pay = math.random(4320,4520) },
		[3] = { pay = math.random(2250,2650) },
		[4] = { pay = math.random(3300,3500) }
	},
	["show"] = {
		[1] = { pay = math.random(6400,6600) },
		[2] = { pay = math.random(3700,3950) },
		[3] = { pay = math.random(4000,4300) },
		[4] = { pay = math.random(2300,2350) }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment(id,mod,health)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.giveMoney(user_id,parseInt(paylist[mod][id].pay+(health-700)))
		TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
		TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(parseInt(paylist[mod][id].pay+(health-700))).." dólares</b>.")
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