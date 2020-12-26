local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

func = {}
Tunnel.bindInterface("vrp_registradora",func)
local idgens = Tools.newIDGenerator()
local blips = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEMPO
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
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkRobbery(id,x,y,z,head)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local policia = vRP.getUsersByPermission("policia.permissao")
		if #policia >= 2 then
			if timers[id] == 0 or not timers[id] then
				timers[id] = 900
				TriggerClientEvent('iniciandoregistradora',source,head,x,y,z)
				vRPclient._playAnim(source,false,{{"oddjobs@shop_robbery@rob_till","loop"}},true)
				local random = math.random(100)
				if random >= 10 then
					vRPclient.setStandBY(source,parseInt(60))
					for l,w in pairs(policia) do
						local player = vRP.getUserSource(parseInt(w))
						if player then
							async(function()
								TriggerClientEvent('blip:criar:registradora',player,x,y,z)
								vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
								TriggerClientEvent('chatMessage',player,"190",{65,130,255},"O roubo começou na ^1Caixa Registradora^0, dirija-se até o local e intercepte o assaltante.")
								SetTimeout(20000,function() TriggerClientEvent('blip:remover:registradora',player) end)
							end)
						end
					end
				end
				SetTimeout(10000,function()
					local qntdinheiro = math.random(5000,8000)
					vRP.giveInventoryItem(user_id,"dinheirosujo",qntdinheiro) -- Ajuste do pagamento em dinheiro sujo
					TriggerClientEvent("Notify",source,"importante","Você recebeu <b>"..qntdinheiro.."x</b> de dinheiro sujo",8000)
				end)
			else
				TriggerClientEvent("Notify",source,"importante","A registradora está vazia, aguarde <b>"..timers[id].." segundos</b> até que tenha dinheiro novamente.")
			end
		else
			TriggerClientEvent("Notify",source,"importante","Número insuficiente de policiais no momento.")
		end
	end
end