local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

func = {}
Tunnel.bindInterface("vrp_caixaeletronico",func)

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
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local timers = 0
local recompensa = 0
local andamento = false
local dinheirosujo = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALIDADES
-----------------------------------------------------------------------------------------------------------------------------------------
local caixas = {
	[1] = { ['seconds'] = 22 },
	[2] = { ['seconds'] = 34 },
	[3] = { ['seconds'] = 34 },
	[4] = { ['seconds'] = 30 },
	[5] = { ['seconds'] = 28 },
	[6] = { ['seconds'] = 28 },
	[7] = { ['seconds'] = 30 },
	[8] = { ['seconds'] = 34 },
	[9] = { ['seconds'] = 30 },
	[10] = { ['seconds'] = 36 },
	[11] = { ['seconds'] = 28 },
	[12] = { ['seconds'] = 22 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkRobbery(id,x,y,z,head)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local crds = GetEntityCoords(GetPlayerPed(source))
	local policia = vRP.getUsersByPermission("policia.permissao")
	if user_id then
		if #policia < 2 then
			TriggerClientEvent("Notify",source,"importante","Número insuficiente de policiais no momento.")
		elseif (os.time()-timers) <= 300 then
			TriggerClientEvent("Notify",source,"importante","Os caixas estão vazios, aguarde <b>"..vRP.format(parseInt((300-(os.time()-timers)))).." segundos</b> até que os civis depositem dinheiro.")
		else
			andamento = true
			timers = os.time()
			dinheirosujo = {}
			dinheirosujo[user_id] = caixas[id].seconds
			vRPclient.setStandBY(source,parseInt(700))
			recompensa = parseInt(math.random(10000,14000)/caixas[id].seconds)
			TriggerClientEvent('iniciandocaixaeletronico',source,x,y,z,caixas[id].seconds,head)

			SendWebhookMessage(webhookroubos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[ROUBOU]: Caixa Eletronico (ATM)\n[COORDENADA]: "..crds.x..","..crds.y..","..crds.z..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			
			vRPclient._playAnim(source,false,{{"anim@heists@ornate_bank@grab_cash_heels","grab"}},true)
			for l,w in pairs(policia) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('blip:criar:caixaeletronico',player,x,y,z)
						vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
						TriggerClientEvent('chatMessage',player,"190",{65,130,255},"O roubo começou no ^1Caixa Eletrônico^0, dirija-se até o local e intercepte os assaltantes.")
					end)
				end
			end
			SetTimeout(caixas[id].seconds*1000,function()
				if andamento then
					andamento = false
					for l,w in pairs(policia) do
						local player = vRP.getUserSource(parseInt(w))
						if player then
							async(function()
								TriggerClientEvent('blip:remover:caixaeletronico',player)
								TriggerClientEvent('chatMessage',player,"190",{65,130,255},"O roubo terminou, os assaltantes estão correndo antes que vocês cheguem.")
							end)
						end
					end
				end
			end)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function func.cancelRobbery()
	if andamento then
		andamento = false
		local policia = vRP.getUsersByPermission("policia.permissao")
		for l,w in pairs(policia) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					TriggerClientEvent('blip:remover:caixaeletronico',player)
					TriggerClientEvent('chatMessage',player,"190",{65,130,255},"O assaltante saiu correndo e deixou tudo para trás.")
				end)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if andamento then
			for k,v in pairs(dinheirosujo) do
				if v > 0 then
					dinheirosujo[k] = v - 1
					vRP._giveInventoryItem(k,"dinheirosujo",recompensa)
				end
			end
		end
	end
end)