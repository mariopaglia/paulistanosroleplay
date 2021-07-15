local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = Tunnel.getInterface("farm_contrabando")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS 
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local processo = false
local segundos = 0

-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS DOS BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
local pegarBlips = {
	{ ['x'] = 705.69, ['y'] = -963.8, ['z'] = 30.4 }, -- 705.69,-963.8,30.4
	-- { ['x'] = 1395.63, ['y'] = 1159.91, ['z'] = 114.34 }, -- 1395.63,1159.91,114.34 (Cosanostra)
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	-- [1] = { ['x'] = 708.42, ['y'] = -963.48, ['z'] = 30.41 }, 
	-- [2] = { ['x'] = 709.23, ['y'] = -965.6, ['z'] = 30.4 }, 
	-- [3] = { ['x'] = 705.63, ['y'] = -966.5, ['z'] = 30.4 }, 
	[1] = { ['x'] = 298.23, ['y'] = -1236.01, ['z'] = 29.44 }, 
	[2] = { ['x'] = 378.0, ['y'] = -1266.0, ['z'] = 32.49 }, 
	[3] = { ['x'] = 487.82, ['y'] = -1505.94, ['z'] = 29.29 }, 
	[4] = { ['x'] = 231.0, ['y'] = -1508.0, ['z'] = 29.29 }, 
	[5] = { ['x'] = 56.0, ['y'] = -1625.0, ['z'] = 29.41 }, 
	[6] = { ['x'] = 553.85, ['y'] = -186.93, ['z'] = 54.49 }, 
	[7] = { ['x'] = -232.01, ['y'] = 294.01, ['z'] = 92.19 }, 
	[8] = { ['x'] = 366.22, ['y'] = 256.01, ['z'] = 103.44 }, 
	[9] = { ['x'] = 23.0, ['y'] = -364.99, ['z'] = 39.3 }, 
	[10] = { ['x'] = 313.97, ['y'] = -180.92, ['z'] = 57.38 }, 
	[11] = { ['x'] = 254.01, ['y'] = -18.0, ['z'] = 73.65 }, 
	[12] = { ['x'] = 1124.04, ['y'] = 2115.95, ['z'] = 55.48 }, 
	[13] = { ['x'] = 1539.0, ['y'] = 1704.01, ['z'] = 109.66 }, 
	[14] = { ['x'] = 1209.96, ['y'] = 1858.17, ['z'] = 78.92 }, 
	[15] = { ['x'] = 842.05, ['y'] = 2117.25, ['z'] = 52.37 }, 
	[16] = { ['x'] = 374.95, ['y'] = 3572.19, ['z'] = 33.3 }, 
	[17] = { ['x'] = 981.96, ['y'] = 3581.16, ['z'] = 33.6 }, 
	[18] = { ['x'] = 1973.85, ['y'] = 3786.07, ['z'] = 31.75 }, 
	[19] = { ['x'] = 2482.0, ['y'] = 3715.01, ['z'] = 43.47 }, 
	[20] = { ['x'] = 94.28, ['y'] = -1.4, ['z'] = 68.26 }, 
	[21] = { ['x'] = 3686.09, ['y'] = 4558.18, ['z'] = 25.09 }, 
	[22] = { ['x'] = 1742.05, ['y'] = 6407.5, ['z'] = 35.08 }, 
	[23] = { ['x'] = -145.0, ['y'] = 6487.0, ['z'] = 29.73 }, 
	[24] = { ['x'] = -384.92, ['y'] = 6041.16, ['z'] = 31.51 }, 
	[25] = { ['x'] = -2178.93, ['y'] = 4258.09, ['z'] = 49.43 }, 
	[26] = { ['x'] = -2523.91, ['y'] = 2302.18, ['z'] = 33.28 }, 
	[27] = { ['x'] = -3245.67, ['y'] = 995.2, ['z'] = 11.78 }, 
	[28] = { ['x'] = -3088.44, ['y'] = 226.85, ['z'] = 14.0 }, 
	[29] = { ['x'] = -2953.0, ['y'] = 59.01, ['z'] = 11.61 }, 
	[30] = { ['x'] = -2134.91, ['y'] = -393.82, ['z'] = 13.2 }, 
	[31] = { ['x'] = -1802.94, ['y'] = -352.23, ['z'] = 48.29 }, 
	[32] = { ['x'] = -1630.99, ['y'] = -358.99, ['z'] = 48.26 }, 
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		for k,v in pairs(pegarBlips) do
			if not servico then
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
				local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
				local pegarBlips = pegarBlips[k]

				if distance <= 3 then
					idle = 5
					DrawMarker(21,pegarBlips.x, pegarBlips.y, pegarBlips.z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
					if distance <= 1.2 then
						drawTxt("PRESSIONE  ~r~E~w~  PARA INICIAR A COLETA",4,0.5,0.93,0.50,255,255,255,180)
						if IsControlJustPressed(0,38) then
							servico = true
							selecionado = 1
							CriandoBlip(locs,selecionado)
							TriggerEvent("Notify","sucesso","Você entrou em serviço")
						end
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTREGAS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)
			
			if distance <= 3 then
				idle = 5
				DrawMarker(25,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-0.99,0,0,0,0.0,0,0,3.0,3.0,0.4,0,180,0,80,0,0,0,1)
				if distance <= 2.0 then
					local vehicle = GetPlayersLastVehicle()
					drawTxt("PRESSIONE  ~r~E~w~  PARA COLETAR OS ~g~MATERIAIS~w~",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and not IsPedInAnyVehicle(ped) then --and GetEntityModel(vehicle) == 1475773103 then
						TriggerEvent('cancelando',true)
						RemoveBlip(blips)
						backentrega = selecionado
						processo = true
						segundos = 5
						
						TriggerEvent("progress",5000,"Coletando")
						vRP._playAnim(false,{{"anim@heists@ornate_bank@grab_cash_heels","grab"}},true)
									 
						if selecionado == 32 then
							selecionado = 1
						else
							selecionado = selecionado + 1
						end
						Citizen.Wait(5000)
						emP.checkPayment()
						CriandoBlip(locs,selecionado)
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping('emp:rotacancelar', 'CancelarRota', 'keyboard', 'F7')

RegisterCommand('emp:rotacancelar', function()
	if servico then
			servico = false
			RemoveBlip(blips)
			TriggerEvent("Notify","importante","Você saiu de serviço.")
	end
end, false)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if segundos > 0 then
			segundos = segundos - 1
			if segundos == 0 then
				processo = false
				TriggerEvent('cancelando',false)
				ClearPedTasks(PlayerPedId())
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Coletar Materiais")
	EndTextCommandSetBlipName(blips)
end