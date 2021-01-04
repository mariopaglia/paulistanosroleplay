local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
rob = {}
Tunnel.bindInterface("vrp_roubos",rob)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local variavel1 = 0
local variavel2 = 0
local variavel3 = 0

local assaltante1 = false
local assaltante2 = false
local assaltante3 = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO RECOMPENSA
-----------------------------------------------------------------------------------------------------------------------------------------
local bancos = {
	{ id = 1 , nome = "Banco" , segundos = 120 , cops = 4, recompensa = math.random(10000,200000) },
	{ id = 2 , nome = "Banco" , segundos = 120 , cops = 4 , recompensa = math.random(10000,200000) },
	{ id = 3 , nome = "Banco" , segundos = 120 , cops = 4 , recompensa = math.random(10000,200000) },
	{ id = 4 , nome = "Banco Paleto" , segundos = 120 , cops = 4 , recompensa = math.random(500000,700000) },
	{ id = 5 , nome = "Banco" , segundos = 120 , cops = 4 , recompensa = math.random(10000,200000) },
	{ id = 6 , nome = "Banco" , segundos = 120 , cops = 4 , recompensa = math.random(10000,200000) },
	{ id = 7 , nome = "Banco" , segundos = 120 , cops = 4 , recompensa = math.random(10000,200000) },
}

local lojas = {
	{ id = 13 , nome = "Loja de Departamento" , segundos = 120 , cops = 0 , recompensa = math.random(70000,140000) },
	{ id = 14 , nome = "Loja de Departamento" , segundos = 120 , cops = 4 , recompensa = math.random(70000,140000) },
	{ id = 15 , nome = "Loja de Departamento" , segundos = 120 , cops = 4 , recompensa = math.random(70000,140000) },
	{ id = 16 , nome = "Loja de Departamento" , segundos = 120 , cops = 4 , recompensa = math.random(70000,140000) },
	{ id = 17 , nome = "Loja de Departamento" , segundos = 120 , cops = 4 , recompensa = math.random(70000,140000) },
	{ id = 18 , nome = "Loja de Departamento" , segundos = 120 , cops = 4 , recompensa = math.random(70000,140000) },
	{ id = 19 , nome = "Loja de Departamento" , segundos = 120 , cops = 4 , recompensa = math.random(70000,140000) },
	{ id = 20 , nome = "Loja de Departamento" , segundos = 120 , cops = 4 , recompensa = math.random(70000,140000) },
	{ id = 21 , nome = "Loja de Departamento" , segundos = 120 , cops = 4 , recompensa = math.random(70000,140000) },
	{ id = 22 , nome = "Loja de Departamento" , segundos = 120 , cops = 4 , recompensa = math.random(70000,140000) },
	{ id = 23 , nome = "Loja de Departamento" , segundos = 120 , cops = 4 , recompensa = math.random(70000,140000) },
	{ id = 24 , nome = "Loja de Departamento" , segundos = 120 , cops = 4 , recompensa = math.random(70000,140000) },
	{ id = 25 , nome = "Loja de Departamento" , segundos = 120 , cops = 4 , recompensa = math.random(70000,140000) },
}

local outros = {
	{ id = 26 , nome = "Vanilla" , segundos = 120 , cops = 4 , recompensa = math.random(90000,150000) },
	{ id = 27 , nome = "Yellow Jack" , segundos = 120 , cops = 4 , recompensa = math.random(90000,150000) },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function rob.IniciandoRoubo1(id,x,y,z,head)
	local source = source
	local user_id = vRP.getUserId(source)
	local soldado = vRP.getUsersByPermission("policia.permissao")
	for _,item in pairs(bancos) do
		if item.id == id then
			if #soldado < item.cops then
				TriggerClientEvent('Notify',source,"negado","Número insuficiente de policiais no momento para iniciar um roubo.")
			elseif (os.time() - variavel1) < 1800 then
				TriggerClientEvent('Notify',source,"negado","Os cofres estão vazios, aguarde "..(1800 - (os.time() - variavel1)).." segundos!")
			else
				assaltante1 = true
				variavel1 = os.time()
				TriggerClientEvent('iniciarroubo',source,item.segundos,head)
				vRPclient.playAnim(source,false,{{"anim@heists@ornate_bank@grab_cash_heels","grab",1}},true)
				for l,w in pairs(soldado) do
					local player = vRP.getUserSource(parseInt(w))
					if player then
						async(function()
							TriggerClientEvent('criarblip',player,x,y,z)
							vRPclient.playSound(player,"HUD_MINI_GAME_SOUNDSET","CHECKPOINT_AHEAD")
							vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
							TriggerClientEvent('chatMessage',player,"190",{65,130,255},"O roubo começou no(a) ^1"..item.nome.."^0, dirija-se até o local e intercepte os assaltantes.")
						end)
					end
				end
				SetTimeout(item.segundos*1000,function()
					if assaltante1 then
						for l,w in pairs(soldado) do
							local player = vRP.getUserSource(parseInt(w))
							if player then
								async(function()
									TriggerClientEvent('chatMessage',player,"190",{65,130,255},"O roubo terminou, os assaltantes estão correndo antes que vocês cheguem.")
								end)
							end
						end
						TriggerClientEvent('removerblip',-1)
						vRP.giveInventoryItem(user_id,"dinheirosujo",item.recompensa,false)
						assaltante1 = false
					end
				end)
			end
		end
	end
end

function rob.IniciandoRoubo2(id,x,y,z,head)
	local source = source
	local user_id = vRP.getUserId(source)
	local soldado = vRP.getUsersByPermission("policia.permissao")
	for _,item in pairs(lojas) do
		if item.id == id then
			if #soldado > item.cops then
				TriggerClientEvent('Notify',source,"negado","Número insuficiente de policiais no momento para iniciar um roubo.")
			elseif (os.time() - variavel2) < 1800 then
				TriggerClientEvent('Notify',source,"negado","Os cofres estão vazios, aguarde "..(1800 - (os.time() - variavel2)).." segundos!")
			else
				assaltante2 = true
				variavel2 = os.time()
				TriggerClientEvent('iniciarroubo',source,item.segundos,head)
				vRPclient.playAnim(source,false,{{"anim@heists@ornate_bank@grab_cash_heels","grab",1}},true)
				for l,w in pairs(soldado) do
					local player = vRP.getUserSource(parseInt(w))
					if player then
						async(function()
							TriggerClientEvent('criarblip',player,x,y,z)
							vRPclient.playSound(player,"HUD_MINI_GAME_SOUNDSET","CHECKPOINT_AHEAD")
							vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
							TriggerClientEvent('chatMessage',player,"190",{65,130,255},"O roubo começou no(a) ^1"..item.nome.."^0, dirija-se até o local e intercepte os assaltantes.")
						end)
					end
				end
				SetTimeout(item.segundos*1000,function()
					if assaltante2 then
						for l,w in pairs(soldado) do
							local player = vRP.getUserSource(parseInt(w))
							if player then
								async(function()
									TriggerClientEvent('chatMessage',player,"190",{65,130,255},"O roubo terminou, os assaltantes estão correndo antes que vocês cheguem.")
								end)
							end
						end
						TriggerClientEvent('removerblip',-1)
						vRP.giveInventoryItem(user_id,"dinheirosujo",item.recompensa,false)
						assaltante2 = false
					end
				end)
			end
		end
	end
end

function rob.IniciandoRoubo3(id,x,y,z,head)
	local source = source
	local user_id = vRP.getUserId(source)
	local soldado = vRP.getUsersByPermission("policia.permissao")
	for _,item in pairs(outros) do
		if item.id == id then
			if #soldado < item.cops then
				TriggerClientEvent('Notify',source,"negado","Número insuficiente de policiais no momento para iniciar um roubo.")
			elseif (os.time() - variavel3) < 3600 then
				TriggerClientEvent('Notify',source,"negado","Os cofres estão vazios, aguarde "..(1800 - (os.time() - variavel3)).." segundos!")
			else
				assaltante3 = true
				variavel3 = os.time()
				TriggerClientEvent('iniciarroubo',source,item.segundos,head)
				vRPclient.playAnim(source,false,{{"anim@heists@ornate_bank@grab_cash_heels","grab",1}},true)
				for l,w in pairs(soldado) do
					local player = vRP.getUserSource(parseInt(w))
					if player then
						async(function()
							TriggerClientEvent('criarblip',player,x,y,z)
							vRPclient.playSound(player,"HUD_MINI_GAME_SOUNDSET","CHECKPOINT_AHEAD")
							vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
							TriggerClientEvent('chatMessage',player,"190",{65,130,255},"O roubo começou no(a) ^1"..item.nome.."^0, dirija-se até o local e intercepte os assaltantes.")
						end)
					end
				end
				SetTimeout(item.segundos*1000,function()
					if assaltante3 then
						for l,w in pairs(soldado) do
							local player = vRP.getUserSource(parseInt(w))
							if player then
								async(function()
									TriggerClientEvent('chatMessage',player,"190",{65,130,255},"O roubo terminou, os assaltantes estão correndo antes que vocês cheguem.")
								end)
							end
						end
						TriggerClientEvent('removerblip',-1)
						vRP.giveInventoryItem(user_id,"dinheirosujo",item.recompensa,false)
						assaltante3 = false
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
					TriggerClientEvent('chatMessage',player,"190",{65,130,255},"O assaltante saiu correndo e deixou tudo para trás.")
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
					TriggerClientEvent('chatMessage',player,"190",{65,130,255},"O assaltante saiu correndo e deixou tudo para trás.")
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
					TriggerClientEvent('chatMessage',player,"190",{65,130,255},"O assaltante saiu correndo e deixou tudo para trás.")
				end)
			end
		end
		TriggerClientEvent('removerblip',-1)
		assaltante3 = false
	end
end