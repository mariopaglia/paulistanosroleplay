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
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookroubos = "https://discord.com/api/webhooks/802605744967909387/usEM4UEaaZAfUxfUnW2w9q3RYsRWfXkaICVnDWktOcSjdjGT-q0wt0KWuCvyd_VCbjTa"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
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
	local identity = vRP.getUserIdentity(user_id)
	local crds = GetEntityCoords(GetPlayerPed(source))
	if user_id then
		local policia = vRP.getUsersByPermission("pmesp.permissao")
		if #policia >= 2 then
			if timers[id] == 0 or not timers[id] then
				timers[id] = 1800				
				TriggerClientEvent('iniciandoregistradora',source,head,x,y,z)
				vRPclient._playAnim(source,false,{{"oddjobs@shop_robbery@rob_till","loop"}},true)
				local random = math.random(100)
				if random >= 10 then
					vRPclient.playSound(source,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
					TriggerClientEvent("Notify",source,"aviso","Corra, a polícia foi acionada!")
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
				SetTimeout(20000,function()
					vRP.antiflood(source,"registradora",3)
					local qntdinheiro = math.random(5000,8000)
					vRP.giveInventoryItem(user_id,"dinheirosujo",qntdinheiro) -- Ajuste do pagamento em dinheiro sujo
					TriggerClientEvent("Notify",source,"importante","Você recebeu <b>R$ "..vRP.format(parseInt(qntdinheiro)).."</b> de <b>dinheiro sujo</b>",8000)
					SendWebhookMessage(webhookroubos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[ROUBOU]: Caixa Registradora\n[RECOMPENSA]: R$ "..vRP.format(parseInt(qntdinheiro)).."\n[COORDENADA]: "..crds.x..","..crds.y..","..crds.z..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end)
			else
				TriggerClientEvent("Notify",source,"importante","A registradora está vazia, aguarde <b>"..timers[id].." segundos</b> até que tenha dinheiro novamente.")
			end
		else
			TriggerClientEvent("Notify",source,"importante","Número insuficiente de policiais no momento.")
		end
	end
end