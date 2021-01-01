local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = Tunnel.getInterface("farm_drogas")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS 
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local CoordenadaX = 978.13 -- 978.13, -1488.3, 31.51
local CoordenadaY = -1488.3
local CoordenadaZ = 31.51
-- local CoordenadaX = 1690.28 -- Teste (primeiro blip) 1690.28, 3753.29, 34.30
-- local CoordenadaY = 3753.29 -- Teste (primeiro blip)
-- local CoordenadaZ = 34.30 -- Teste (primeiro blip)
local selecionado = 0
local processo = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = 466.39, ['y'] = -735.74, ['z'] = 27.37 }, 
	[2] = { ['x'] = -326.48, ['y'] = -1300.47, ['z'] = 31.35 }, 
	[3] = { ['x'] = 504.73, ['y'] = -2125.97, ['z'] = 5.92 }, 
	[4] = { ['x'] = -517.97, ['y'] = -2903.48, ['z'] = 6.01 },
	[5] = { ['x'] = 2460.03, ['y'] = -384.06, ['z'] = 93.33 }, 
	[6] = { ['x'] = 2748.06, ['y'] = 1453.39, ['z'] = 24.5 }, 
	[7] = { ['x'] = 2527.73, ['y'] = 2617.33, ['z'] = 37.96 }, 
	[8] = { ['x'] = 2064.3, ['y'] = 3188.27, ['z'] = 45.19 }, 
	[9] = { ['x'] = 895.85, ['y'] = 3612.95, ['z'] = 32.83 }, 
	[10] = { ['x'] = 763.37, ['y'] = 4174.86, ['z'] = 40.61 }, 
	[11] = { ['x'] = 1961.07, ['y'] = 5185.04, ['z'] = 47.95 },
	[12] = { ['x'] = 2193.88, ['y'] = 5594.08, ['z'] = 53.76 },
	[13] = { ['x'] = 2576.6, ['y'] = 3165.5, ['z'] = 50.78 },
	[14] = { ['x'] = 2570.79, ['y'] = 4667.99, ['z'] = 34.08 },
	[15] = { ['x'] = 1469.75, ['y'] = 6550.1, ['z'] = 14.91 },
	[16] = { ['x'] = -841.66, ['y'] = 5400.96, ['z'] = 34.62 },
	[17] = { ['x'] = 57.47, ['y'] = 3691.07, ['z'] = 39.93 },
	[18] = { ['x'] = 1243.26, ['y'] = 1869.5, ['z'] = 78.97 },
	[19] = { ['x'] = 239.85, ['y'] = -122.08, ['z'] = 70.11}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if not servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
			local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)

			if distance <= 3 then
				DrawMarker(21,CoordenadaX,CoordenadaY,CoordenadaZ-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
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
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTREGAS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)
			
			if distance <= 3 then
				DrawMarker(25,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-0.99,0,0,0,0.0,0,0,3.0,3.0,0.4,0,180,0,80,0,0,0,1)
				if distance <= 2.0 then
					local vehicle = GetPlayersLastVehicle()
					drawTxt("PRESSIONE  ~r~E~w~  PARA COLETAR OS ~g~MATERIAIS~w~",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and emP.checkPermission() and not IsPedInAnyVehicle(ped) then --and GetEntityModel(vehicle) == 1475773103 then
						TriggerEvent('cancelando',true)
						RemoveBlip(blips)
						backentrega = selecionado
						processo = true
						segundos = 5
						
						TriggerEvent("progress",5000,"Coletando")
						vRP._playAnim(false,{{"anim@heists@ornate_bank@grab_cash_heels","grab"}},true)
									 
						if selecionado == 19 then
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
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if servico then
			if IsControlJustPressed(0,168) then
				servico = false
				RemoveBlip(blips)
				TriggerEvent("Notify","importante","Você saiu de serviço")
			end
		end
	end
end)
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
	AddTextComponentString("Coleta")
	EndTextCommandSetBlipName(blips)
end