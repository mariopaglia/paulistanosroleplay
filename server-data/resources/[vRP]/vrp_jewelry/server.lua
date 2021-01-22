local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

func = {}
Tunnel.bindInterface("vrp_jewelry",func)
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
local timers = 0
local andamento = false
local roubando = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKJEWELRY
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkJewelry(x,y,z,h,sec,tipo)
	local source = source
	local user_id = vRP.getUserId(source)
	local policia = vRP.getUsersByPermission("policia.permissao")
	if user_id then
		if #policia < 7 then
			TriggerClientEvent("Notify",source,"importante","Número insuficiente de policiais no momento.")
		elseif (os.time()-timers) <= 3600 then
			TriggerClientEvent("Notify",source,"importante","A joalheria não se recuperou do ultimo roubo, aguarde <b>"..vRP.format(parseInt((3600-(os.time()-timers)))).." segundos</b> até que o sistema seja restaurado.")
		else
			if vRP.getInventoryItemAmount(user_id,"cartaoinvasao") >= 1 and not roubando then
				roubando = true
				vRPclient._playAnim(source,false,{{"anim@heists@prison_heistig1_p1_guard_checks_bus","loop"}},true)
				TriggerClientEvent('iniciandojewelry',source,x,y,z,h,sec,tipo,true)
				local firewall = math.random(100)
				SetTimeout(sec*1000,function()
					if firewall >= 10 then
						segundos = 600
						andamento = true
						timers = os.time()
						TriggerClientEvent('iniciandojewelry',source,x,y,z,h,sec,tipo,false)
						vRP.tryGetInventoryItem(user_id,"cartaoinvasao",1)
						TriggerClientEvent("Notify",source,"sucesso","A proteção do <b>Baidu Antivirus</b> foi comprometida e todos os balcões foram liberados.")
						SetTimeout(20000,function()
							vRPclient.setStandBY(source,parseInt(300))
							func.callPolice(x,y,z)
						end)
					else
						roubando = false
						func.callPolice(x,y,z)
						TriggerClientEvent('iniciandojewelry',source,x,y,z,h,sec,tipo,false)
						TriggerClientEvent("Notify",source,"importante","O computador é protegido pelo <b>Baidu Antivirus</b>, ele bloqueou sua conexão, tente novamente.")
					end
				end)
			else
				TriggerClientEvent("Notify",source,"importante","Precisa de um <b>Cartão de Invasão</b> para hackear as câmeras de segurança.")
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function func.callPolice(x,y,z)
	local source = source
	TriggerClientEvent("vrp_sound:fixed",-1,source,x,y,z,100,'alarm',0.7)
	local policia = vRP.getUsersByPermission("policia.permissao")
	for l,w in pairs(policia) do
		local player = vRP.getUserSource(parseInt(w))
		if player then
			async(function()
				local ids = idgens:gen()
				vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
				blips[ids] = vRPclient.addBlip(player,x,y,z,1,59,"Roubo em andamento",0.5,true)
				TriggerClientEvent('chatMessage',player,"190",{65,130,255},"O roubo começou na ^1Joalheria^0, dirija-se até o local e intercepte o assaltante.")
				SetTimeout(20000,function() vRPclient.removeBlip(player,blips[ids]) idgens:free(ids) end)
			end)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RETURNJEWELRY
-----------------------------------------------------------------------------------------------------------------------------------------
function func.returnJewelry()
	return andamento
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMEROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
local timers = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(timers) do
			if v > 0 then
				timers[k] = v - 1
			end
		end
		if andamento then
			segundos = segundos - 1
			if segundos <= 0 then
				timers = {}
				andamento = false
				roubando = false
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKJEWELS
-----------------------------------------------------------------------------------------------------------------------------------------
local jewels = {
	[1] = { item = "dinheirosujo" }
}

function func.checkJewels(id,x,y,z,h,tipo)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if timers[id] == 0 or not timers[id] then
			timers[id] = 600
			TriggerClientEvent('iniciandojewelry',source,x,y,z,h,10,tipo,true)
			vRPclient._playAnim(source,false,{{"oddjobs@shop_robbery@rob_till","loop"}},true)
			SetTimeout(10000,function()
				vRPclient.setStandBY(source,parseInt(60))
				vRP.giveInventoryItem(user_id,"dinheirosujo",math.random(15000,25000))
			end)
		else
			TriggerClientEvent("Notify",source,"importante","O balcão está vazio, aguarde <b>"..vRP.format(parseInt(timers[id])).." segundos</b> até que a loja se recupera do ultimo roubo.")
		end
	end
end