local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
rob = {}
Tunnel.bindInterface("vrp_roubos",rob)

-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
-- local webhookroubos = "https://discord.com/api/webhooks/802605744967909387/usEM4UEaaZAfUxfUnW2w9q3RYsRWfXkaICVnDWktOcSjdjGT-q0wt0KWuCvyd_VCbjTa"

-- function SendWebhookMessage(webhook,message)
-- 	if webhook ~= nil and webhook ~= "" then
-- 		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
-- 	end
-- end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local variavel1 = 0
local variavel2 = 0
local variavel3 = 0
local variavel4 = 0

local assaltante1 = false
local assaltante2 = false
local assaltante3 = false
local assaltante4 = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO RECOMPENSA
-----------------------------------------------------------------------------------------------------------------------------------------
local bancos = {
	{ id = 1 , nome = "Banco Paleto" , segundos = 120 , cops = 9 , recompensa = math.random(700000,800000) },
	-- { id = 2 , nome = "Banco" , segundos = 120 , cops = 4, recompensa = math.random(10000,200000) },
	-- { id = 3 , nome = "Banco" , segundos = 120 , cops = 4 , recompensa = math.random(10000,200000) },
	-- { id = 4 , nome = "Banco" , segundos = 120 , cops = 4 , recompensa = math.random(10000,200000) },
	-- { id = 5 , nome = "Banco" , segundos = 120 , cops = 4 , recompensa = math.random(10000,200000) },
	-- { id = 6 , nome = "Banco" , segundos = 120 , cops = 4 , recompensa = math.random(10000,200000) },
	-- { id = 7 , nome = "Banco" , segundos = 120 , cops = 4 , recompensa = math.random(10000,200000) },
}

local lojas = {
	{ id = 13 , nome = "Loja de Departamento" , segundos = 120 , cops = 4 , recompensa = math.random(200000,250000) },
	{ id = 14 , nome = "Loja de Departamento" , segundos = 120 , cops = 4 , recompensa = math.random(200000,250000) },
	{ id = 15 , nome = "Loja de Departamento" , segundos = 120 , cops = 4 , recompensa = math.random(200000,250000) },
	{ id = 16 , nome = "Loja de Departamento" , segundos = 120 , cops = 4 , recompensa = math.random(200000,250000) },
	{ id = 17 , nome = "Loja de Departamento" , segundos = 120 , cops = 4 , recompensa = math.random(200000,250000) },
	{ id = 18 , nome = "Loja de Departamento" , segundos = 120 , cops = 4 , recompensa = math.random(200000,250000) },
	{ id = 19 , nome = "Loja de Departamento" , segundos = 120 , cops = 4 , recompensa = math.random(200000,250000) },
	{ id = 20 , nome = "Loja de Departamento" , segundos = 120 , cops = 4 , recompensa = math.random(200000,250000) },
	{ id = 21 , nome = "Loja de Departamento" , segundos = 120 , cops = 4 , recompensa = math.random(200000,250000) },
	{ id = 22 , nome = "Loja de Departamento" , segundos = 120 , cops = 4 , recompensa = math.random(200000,250000) },
	{ id = 23 , nome = "Loja de Departamento" , segundos = 120 , cops = 4 , recompensa = math.random(200000,250000) },
	{ id = 24 , nome = "Loja de Departamento" , segundos = 120 , cops = 4 , recompensa = math.random(200000,250000) },
	{ id = 25 , nome = "Loja de Departamento" , segundos = 120 , cops = 4 , recompensa = math.random(200000,250000) },
	{ id = 38 , nome = "Loja de Bebidas" , segundos = 60 , cops = 3 , recompensa = math.random(150000,200000) },
	{ id = 39 , nome = "Loja de Bebidas" , segundos = 60 , cops = 3 , recompensa = math.random(150000,200000) },
	{ id = 40 , nome = "Loja de Bebidas" , segundos = 60 , cops = 3 , recompensa = math.random(150000,200000) },
	{ id = 41 , nome = "Loja de Bebidas" , segundos = 60 , cops = 3 , recompensa = math.random(150000,200000) },
}

local outros = {
	{ id = 26 , nome = "Açougue" , segundos = 120 , cops = 8 , recompensa = math.random(400000,500000) },
	{ id = 27 , nome = "Yellow Jack" , segundos = 120 , cops = 5 , recompensa = math.random(300000,350000) },
	{ id = 28 , nome = "Galinheiro" , segundos = 120 , cops = 8 , recompensa = math.random(400000,500000) },
	{ id = 29 , nome = "Teatro" , segundos = 60 , cops = 8 , recompensa = math.random(400000,500000) },
	{ id = 35 , nome = "Pier" , segundos = 60 , cops = 6 , recompensa = math.random(400000,500000) },
	{ id = 36 , nome = "Porto" , segundos = 60 , cops = 6 , recompensa = math.random(400000,500000) },
	{ id = 37 , nome = "Loja de Bebidas" , segundos = 60 , cops = 3 , recompensa = math.random(150000,200000) },
	{ id = 42 , nome = "Aeroporto Norte (Trevor)" , segundos = 60 , cops = 5 , recompensa = math.random(200000,250000) },
}

local barbearia = {
	{ id = 30 , nome = "Barbearia" , segundos = 60 , cops = 2 , recompensa = math.random(30000,40000) },
	{ id = 31 , nome = "Barbearia" , segundos = 60 , cops = 2 , recompensa = math.random(30000,40000) },
	{ id = 32 , nome = "Barbearia" , segundos = 60 , cops = 2 , recompensa = math.random(30000,40000) },
	{ id = 33 , nome = "Barbearia" , segundos = 60 , cops = 2 , recompensa = math.random(30000,40000) },
	{ id = 34 , nome = "Barbearia" , segundos = 60 , cops = 2 , recompensa = math.random(30000,40000) },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------

---------------------
-- BANCOS
---------------------
function rob.IniciandoRoubo1(id,x,y,z,head)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local crds = GetEntityCoords(GetPlayerPed(source))
	local soldado = vRP.getUsersByPermission("pmesp.permissao")
	for _,item in pairs(bancos) do
		if item.id == id then
			if #soldado < item.cops then
				TriggerClientEvent('Notify',source,"negado","Número insuficiente de policiais no momento para iniciar um roubo.")
			elseif (os.time() - variavel1) < 1800 then
				TriggerClientEvent('Notify',source,"negado","Os cofres estão vazios, aguarde "..(1800 - (os.time() - variavel1)).." segundos!")
			else
				assaltante1 = true
				variavel1 = os.time()

				vRP.Log("```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[ROUBOU]: "..item.nome.."\n[RECOMPENSA]: R$ "..vRP.format(parseInt(item.recompensa)).."\n[COORDENADA]: "..crds.x..","..crds.y..","..crds.z..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```", "ROUBOS")

				TriggerClientEvent('iniciarroubo',source,item.segundos,head)
				vRPclient.playAnim(source,false,{{"anim@heists@ornate_bank@grab_cash_heels","grab",1}},true)
				for l,w in pairs(soldado) do
					local player = vRP.getUserSource(parseInt(w))
					if player then
						async(function()
							TriggerClientEvent('criarblip',player,x,y,z)
							vRPclient.playSound(player,"HUD_MINI_GAME_SOUNDSET","CHECKPOINT_AHEAD")
							vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
							TriggerClientEvent("Notify", player, "policia", "O roubo começou no(a) <b>"..item.nome.."</b>, dirija-se até o local e intercepte os assaltantes.", 20000)
							TriggerClientEvent('chatMessage',player,"CENTRAL:",{65,130,255},"O roubo começou no(a) ^1"..item.nome.."^0, dirija-se até o local e intercepte os assaltantes.")
						end)
					end
				end
				SetTimeout(item.segundos*1000,function()
					if assaltante1 then
						for l,w in pairs(soldado) do
							local player = vRP.getUserSource(parseInt(w))
							if player then
								async(function()
									TriggerClientEvent("Notify", player, "policia", "O roubo terminou, os assaltantes estão correndo antes que vocês cheguem.", 20000)
									TriggerClientEvent('chatMessage',player,"CENTRAL:",{65,130,255},"O roubo terminou, os assaltantes estão correndo antes que vocês cheguem.")
								end)
							end
						end
						TriggerClientEvent('removerblip',-1)
						vRP.antiflood(source,"roubos",3)
						vRP.giveInventoryItem(user_id,"dinheirosujo",item.recompensa,false)
						vRP.giveInventoryItem(user_id,"ticketpvp",2)
						assaltante1 = false
					end
				end)
			end
		end
	end
end

---------------------
-- LOJAS
---------------------
function rob.IniciandoRoubo2(id,x,y,z,head)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local crds = GetEntityCoords(GetPlayerPed(source))
	local soldado = vRP.getUsersByPermission("pmesp.permissao")
	for _,item in pairs(lojas) do
		if item.id == id then
			if #soldado < item.cops then
				TriggerClientEvent('Notify',source,"negado","Número insuficiente de policiais no momento para iniciar um roubo.")
			elseif (os.time() - variavel2) < 1800 then
				TriggerClientEvent('Notify',source,"negado","Os cofres estão vazios, aguarde "..(1800 - (os.time() - variavel2)).." segundos!")
			else
				assaltante2 = true
				variavel2 = os.time()

				vRP.Log("```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[ROUBOU]: "..item.nome.."\n[RECOMPENSA]: R$ "..vRP.format(parseInt(item.recompensa)).."\n[COORDENADA]: "..crds.x..","..crds.y..","..crds.z..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```", "ROUBOS")
				
				TriggerClientEvent('iniciarroubo',source,item.segundos,head)
				vRPclient.playAnim(source,false,{{"anim@heists@ornate_bank@grab_cash_heels","grab",1}},true)
				for l,w in pairs(soldado) do
					local player = vRP.getUserSource(parseInt(w))
					if player then
						async(function()
							TriggerClientEvent('criarblip',player,x,y,z)
							vRPclient.playSound(player,"HUD_MINI_GAME_SOUNDSET","CHECKPOINT_AHEAD")
							vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
							TriggerClientEvent("Notify", player, "policia", "O roubo começou no(a) <b>"..item.nome.."</b>, dirija-se até o local e intercepte os assaltantes.", 20000)
							TriggerClientEvent('chatMessage',player,"CENTRAL:",{65,130,255},"O roubo começou no(a) ^1"..item.nome.."^0, dirija-se até o local e intercepte os assaltantes.")
						end)
					end
				end
				SetTimeout(item.segundos*1000,function()
					if assaltante2 then
						for l,w in pairs(soldado) do
							local player = vRP.getUserSource(parseInt(w))
							if player then
								async(function()
									TriggerClientEvent("Notify", player, "policia", "O roubo terminou, os assaltantes estão correndo antes que vocês cheguem.", 20000)
									TriggerClientEvent('chatMessage',player,"CENTRAL:",{65,130,255},"O roubo terminou, os assaltantes estão correndo antes que vocês cheguem.")
								end)
							end
						end
						TriggerClientEvent('removerblip',-1)
						vRP.antiflood(source,"roubos",3)
						vRP.giveInventoryItem(user_id,"dinheirosujo",item.recompensa,false)
						vRP.giveInventoryItem(user_id,"ticketpvp",2)
						assaltante2 = false
					end
				end)
			end
		end
	end
end

---------------------
-- OUTROS
---------------------
function rob.IniciandoRoubo3(id,x,y,z,head)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local crds = GetEntityCoords(GetPlayerPed(source))
	local soldado = vRP.getUsersByPermission("pmesp.permissao")
	for _,item in pairs(outros) do
		if item.id == id then
			if #soldado < item.cops then
				TriggerClientEvent('Notify',source,"negado","Número insuficiente de policiais no momento para iniciar um roubo.")
			elseif (os.time() - variavel3) < 3600 then
				TriggerClientEvent('Notify',source,"negado","Os cofres estão vazios, aguarde "..(1800 - (os.time() - variavel3)).." segundos!")
			else
				assaltante3 = true
				variavel3 = os.time()

				vRP.Log("```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[ROUBOU]: "..item.nome.."\n[RECOMPENSA]: R$ "..vRP.format(parseInt(item.recompensa)).."\n[COORDENADA]: "..crds.x..","..crds.y..","..crds.z..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```", "ROUBOS")
				
				TriggerClientEvent('iniciarroubo',source,item.segundos,head)
				vRPclient.playAnim(source,false,{{"anim@heists@ornate_bank@grab_cash_heels","grab",1}},true)
				for l,w in pairs(soldado) do
					local player = vRP.getUserSource(parseInt(w))
					if player then
						async(function()
							TriggerClientEvent('criarblip',player,x,y,z)
							vRPclient.playSound(player,"HUD_MINI_GAME_SOUNDSET","CHECKPOINT_AHEAD")
							vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
							TriggerClientEvent("Notify", player, "policia", "O roubo começou no(a) <b>"..item.nome.."</b>, dirija-se até o local e intercepte os assaltantes.", 20000)
							TriggerClientEvent('chatMessage',player,"CENTRAL:",{65,130,255},"O roubo começou no(a) ^1"..item.nome.."^0, dirija-se até o local e intercepte os assaltantes.")
						end)
					end
				end
				SetTimeout(item.segundos*1000,function()
					if assaltante3 then
						for l,w in pairs(soldado) do
							local player = vRP.getUserSource(parseInt(w))
							if player then
								async(function()
									TriggerClientEvent("Notify", player, "policia", "O roubo terminou, os assaltantes estão correndo antes que vocês cheguem.", 20000)
									TriggerClientEvent('chatMessage',player,"CENTRAL:",{65,130,255},"O roubo terminou, os assaltantes estão correndo antes que vocês cheguem.")
								end)
							end
						end
						TriggerClientEvent('removerblip',-1)
						vRP.antiflood(source,"roubos",3)
						vRP.giveInventoryItem(user_id,"dinheirosujo",item.recompensa,false)
						vRP.giveInventoryItem(user_id,"ticketpvp",2)
						assaltante3 = false
					end
				end)
			end
		end
	end
end

---------------------
-- BARBEARIA
---------------------
function rob.IniciandoRoubo4(id,x,y,z,head)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local crds = GetEntityCoords(GetPlayerPed(source))
	local soldado = vRP.getUsersByPermission("pmesp.permissao")
	for _,item in pairs(barbearia) do
		if item.id == id then
			if #soldado < item.cops then
				TriggerClientEvent('Notify',source,"negado","Número insuficiente de policiais no momento para iniciar um roubo.")
			elseif (os.time() - variavel4) < 3600 then
				TriggerClientEvent('Notify',source,"negado","Os cofres estão vazios, aguarde "..(1800 - (os.time() - variavel4)).." segundos!")
			else
				assaltante4 = true
				variavel4 = os.time()

				vRP.Log("```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[ROUBOU]: "..item.nome.."\n[RECOMPENSA]: R$ "..vRP.format(parseInt(item.recompensa)).."\n[COORDENADA]: "..crds.x..","..crds.y..","..crds.z..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```", "ROUBOS")
				
				TriggerClientEvent('iniciarroubo',source,item.segundos,head)
				vRPclient.playAnim(source,false,{{"anim@heists@ornate_bank@grab_cash_heels","grab",1}},true)
				for l,w in pairs(soldado) do
					local player = vRP.getUserSource(parseInt(w))
					if player then
						async(function()
							TriggerClientEvent('criarblip',player,x,y,z)
							vRPclient.playSound(player,"HUD_MINI_GAME_SOUNDSET","CHECKPOINT_AHEAD")
							vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
							TriggerClientEvent("Notify", player, "policia", "O roubo começou no(a) <b>"..item.nome.."</b>, dirija-se até o local e intercepte os assaltantes.", 20000)
							TriggerClientEvent('chatMessage',player,"CENTRAL:",{65,130,255},"O roubo começou na ^1"..item.nome.."^0, dirija-se até o local e intercepte os assaltantes.")
						end)
					end
				end
				SetTimeout(item.segundos*1000,function()
					if assaltante4 then
						for l,w in pairs(soldado) do
							local player = vRP.getUserSource(parseInt(w))
							if player then
								async(function()
									TriggerClientEvent("Notify", player, "policia", "O roubo terminou, os assaltantes estão correndo antes que vocês cheguem.", 20000)
									TriggerClientEvent('chatMessage',player,"CENTRAL:",{65,130,255},"O roubo terminou, os assaltantes estão correndo antes que vocês cheguem.")
								end)
							end
						end
						TriggerClientEvent('removerblip',-1)
						vRP.antiflood(source,"roubos",3)
						vRP.giveInventoryItem(user_id,"dinheirosujo",item.recompensa,false)
						vRP.giveInventoryItem(user_id,"ticketpvp",2)
						vRP.giveInventoryItem(user_id,"adrenalina",1)
						assaltante4 = false
					end
				end)
			end
		end
	end
end

function rob.CancelandoRoubo1()
	if assaltante1 then
		local soldado = vRP.getUsersByPermission("policia.permissao")
		for l,w in pairs(soldado) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					TriggerClientEvent("Notify", player, "policia", "O assaltante saiu correndo e deixou tudo para trás.", 20000)
					TriggerClientEvent('chatMessage',player,"CENTRAL:",{65,130,255},"O assaltante saiu correndo e deixou tudo para trás.")
				end)
			end
		end
		TriggerClientEvent('removerblip',-1)
		assaltante1 = false
	end
end

function rob.CancelandoRoubo2()
	if assaltante2 then
		local soldado = vRP.getUsersByPermission("policia.permissao")
		for l,w in pairs(soldado) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					TriggerClientEvent("Notify", player, "policia", "O assaltante saiu correndo e deixou tudo para trás.", 20000)
					TriggerClientEvent('chatMessage',player,"CENTRAL:",{65,130,255},"O assaltante saiu correndo e deixou tudo para trás.")
				end)
			end
		end
		TriggerClientEvent('removerblip',-1)
		assaltante2 = false
	end
end

function rob.CancelandoRoubo3()
	if assaltante3 then
		local soldado = vRP.getUsersByPermission("policia.permissao")
		for l,w in pairs(soldado) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					TriggerClientEvent("Notify", player, "policia", "O assaltante saiu correndo e deixou tudo para trás.", 20000)
					TriggerClientEvent('chatMessage',player,"CENTRAL:",{65,130,255},"O assaltante saiu correndo e deixou tudo para trás.")
				end)
			end
		end
		TriggerClientEvent('removerblip',-1)
		assaltante3 = false
	end
end

function rob.CancelandoRoubo4()
	if assaltante4 then
		local soldado = vRP.getUsersByPermission("policia.permissao")
		for l,w in pairs(soldado) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					TriggerClientEvent("Notify", player, "policia", "O assaltante saiu correndo e deixou tudo para trás.", 20000)
					TriggerClientEvent('chatMessage',player,"CENTRAL:",{65,130,255},"O assaltante saiu correndo e deixou tudo para trás.")
				end)
			end
		end
		TriggerClientEvent('removerblip',-1)
		assaltante4 = false
	end
end