local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = Tunnel.getInterface("farm_motoclub")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS 
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local CoordenadaX = 884.33	-- 884.33,-2107.17,30.78
local CoordenadaY = -2107.17
local CoordenadaZ = 30.78
local selecionado = 0
local processo = false
local segundos = 0

-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS DOS BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
local pegarBlips = {
	{ ['x'] = -2619.41, ['y'] = 1714.46, ['z'] = 142.38 }, -- -2619.41,1714.46,142.38 (Midnight)
	{ ['x'] = 811.45, ['y'] = -2322.38, ['z'] = 30.47 }, -- 811.45,-2322.38,30.47 (DriftKing)
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = -931.56, ['y'] = -178.96, ['z'] = 37.24 }, 
	[2] = { ['x'] = -1370.4, ['y'] = -503.02, ['z'] = 33.16 }, 
	[3] = { ['x'] = -1612.63, ['y'] = -1028.67, ['z'] = 13.16 }, 
	[4] = { ['x'] = -1459.89, ['y'] = -155.3, ['z'] = 48.83 },
	[5] = { ['x'] = -768.64, ['y'] = -355.26, ['z'] = 37.34 }, 
	[6] = { ['x'] = -152.2, ['y'] = -38.13, ['z'] = 54.4 }, 
	[7] = { ['x'] = 478.9, ['y'] = 56.6, ['z'] = 95.17 }, 
	[8] = { ['x'] = 387.17, ['y'] = 791.82, ['z'] = 187.7 }, 
	[9] = { ['x'] = -518.82, ['y'] = 577.73, ['z'] = 120.92 }, 
	[10] = { ['x'] = -430.11, ['y'] = 1205.07, ['z'] = 325.76 }, 
	[11] = { ['x'] = -112.92, ['y'] = 1881.92, ['z'] = 197.34 },
	[12] = { ['x'] = 733.47, ['y'] = 2523.41, ['z'] = 73.23 },
	[13] = { ['x'] = 61.38, ['y'] = 2793.55, ['z'] = 57.88 },
	[14] = { ['x'] = 911.05, ['y'] = 3644.49, ['z'] = 32.68 },
	[15] = { ['x'] = 2419.29, ['y'] = 4020.37, ['z'] = 36.84 },
	[16] = { ['x'] = 1776.78, ['y'] = 3327.66, ['z'] = 41.44 },
	[17] = { ['x'] = 1401.62, ['y'] = 2169.93, ['z'] = 97.77 },
	[18] = { ['x'] = 1044.47, ['y'] = 191.81, ['z'] = 81.0 },
	[19] = { ['x'] = -122.73, ['y'] = -889.07, ['z'] = 29.33 },
	[20] = { ['x'] = -1040.21, ['y'] = -1136.31, ['z'] = 2.16 },
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
						if IsControlJustPressed(0,38) and emP.checkPermission() then
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
					drawTxt("PRESSIONE  ~r~E~w~  PARA COLETAR ~g~SERRA~w~",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and emP.checkPermission() and not IsPedInAnyVehicle(ped) then --and GetEntityModel(vehicle) == 1475773103 then
						TriggerEvent('cancelando',true)
						RemoveBlip(blips)
						backentrega = selecionado
						processo = true
						segundos = 5
						
						TriggerEvent("progress",5000,"Coletando")
						vRP._playAnim(false,{{"anim@heists@ornate_bank@grab_cash_heels","grab"}},true)
									 
						if selecionado == 20 then
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

RegisterKeyMapping('emp:farmmotoclub', 'Cancelar Farm Motoclub', 'keyboard', 'F7')

RegisterCommand('emp:farmmotoclub', function()
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
	AddTextComponentString("Coletar Placas de Metal")
	EndTextCommandSetBlipName(blips)
end