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
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = 1739.96, ['y'] = -1692.09, ['z'] = 112.72 }, 
	[2] = { ['x'] = 867.92, ['y'] = -1068.93, ['z'] = 28.87 }, 
	[3] = { ['x'] = -1221.77, ['y'] = -354.83, ['z'] = 37.29 }, 
	[4] = { ['x'] = -1183.56, ['y'] = -1774.1, ['z'] = 4.19 },
	[5] = { ['x'] = -440.98, ['y'] = 1599.03, ['z'] = 358.47 }, 
	[6] = { ['x'] = -2175.49, ['y'] = 4294.91, ['z'] = 49.07 }, 
	[7] = { ['x'] = 387.53, ['y'] = 3584.8, ['z'] = 33.3 }, 
	[8] = { ['x'] = -567.43, ['y'] = 5253.01, ['z'] = 70.49 }, 
	[9] = { ['x'] = 125.37, ['y'] = 6644.38, ['z'] = 31.79 }, 
	[10] = { ['x'] = 3800.79, ['y'] = 4440.08, ['z'] = 4.26 }, 
	[11] = { ['x'] = 2167.71, ['y'] = 3331.46, ['z'] = 46.47 },
	[12] = { ['x'] = 137.98, ['y'] = 2295.25, ['z'] = 94.1 },
	[13] = { ['x'] = 1690.96, ['y'] = 3589.0, ['z'] = 35.63 },
	[14] = { ['x'] = 2251.79, ['y'] = 5155.4, ['z'] = 57.89 },
	[15] = { ['x'] = -2551.06, ['y'] = 2301.2, ['z'] = 33.22 },
	[16] = { ['x'] = -2953.04, ['y'] = 49.26, ['z'] = 11.61 },
	[17] = { ['x'] = -313.64, ['y'] = 83.65, ['z'] = 67.62 },
	[18] = { ['x'] = 741.05, ['y'] = 1312.55, ['z'] = 360.14 },
	[19] = { ['x'] = -313.8, ['y'] = -1339.99, ['z'] = 31.35 },
	[20] = { ['x'] = 1227.02, ['y'] = -3107.88, ['z'] = 6.03 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if not servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
			local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)

			if distance <= 3 then
				idle = 5
				DrawMarker(21,CoordenadaX,CoordenadaY,CoordenadaZ-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~r~E~w~  PARA INICIAR A COLETA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and emP.checkPermission() then
						servico = true
						selecionado = 1
						CriandoBlip(locs,selecionado)
						TriggerEvent("Notify","sucesso","Você entrou em serviço.")
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

RegisterKeyMapping('emp:rotacancelar41', 'cancelarrota41', 'keyboard', 'F7')

RegisterCommand('emp:rotacancelar41', function()
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