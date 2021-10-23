local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("emp_policia")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS 441.15,-975.72,30.69
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local CoordenadaX = -565.24 -- -565.24,-112.97,33.88
local CoordenadaY = -112.97
local CoordenadaZ = 33.88
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = -299.58, ['y'] = -374.3, ['z'] = 29.62 },
	[2] = { ['x'] = 198.0, ['y'] = -1031.32, ['z'] = 28.91 },
	[3] = { ['x'] = 280.19, ['y'] = -879.81, ['z'] = 28.57 },
	[4] = { ['x'] = 57.15, ['y'] = -776.16, ['z'] = 31.15 },
	[5] = { ['x'] = -111.33, ['y'] = -1120.81, ['z'] = 24.96 },
	[6] = { ['x'] = -511.82, ['y'] = -1073.71, ['z'] = 22.06 },
	[7] = { ['x'] = -502.69, ['y'] = -859.98, ['z'] = 29.62 },
	[8] = { ['x'] = -836.8, ['y'] = -833.37, ['z'] = 18.74 },
	[9] = { ['x'] = -1161.79, ['y'] = -659.49, ['z'] = 22.21 },
	[10] = { ['x'] = -1485.81, ['y'] = -270.52, ['z'] = 49.25 },
	[11] = { ['x'] = -1698.49, ['y'] = -512.44, ['z'] = 36.83 },
	[12] = { ['x'] = -2044.61, ['y'] = -379.69, ['z'] = 10.32 },
	[13] = { ['x'] = -1962.93, ['y'] = -178.54, ['z'] = 31.51 },
	[14] = { ['x'] = -1623.24, ['y'] = -311.85, ['z'] = 50.63 },
	[15] = { ['x'] = -1425.23, ['y'] = -75.6, ['z'] = 52.09 },
	[16] = { ['x'] = -1105.29, ['y'] = 262.13, ['z'] = 63.6 },
	[17] = { ['x'] = -671.45, ['y'] = 251.1, ['z'] = 80.77 },
	[18] = { ['x'] = 12.99, ['y'] = 255.81, ['z'] = 108.91 },
	[19] = { ['x'] = 183.11, ['y'] = 202.59, ['z'] = 105.06 },
	[20] = { ['x'] = 256.37, ['y'] = 324.06, ['z'] = 104.86 },
	[21] = { ['x'] = 776.16, ['y'] = 161.31, ['z'] = 80.48 },
	[22] = { ['x'] = 1078.41, ['y'] = 436.7, ['z'] = 90.96 },
	[23] = { ['x'] = 809.53, ['y'] = -33.27, ['z'] = 79.97 },
	[24] = { ['x'] = 897.2, ['y'] = -225.42, ['z'] = 68.78 },
	[25] = { ['x'] = 1012.28, ['y'] = -217.09, ['z'] = 69.46 },
	[26] = { ['x'] = 1205.72, ['y'] = -353.91, ['z'] = 68.38 },
	[27] = { ['x'] = 894.59, ['y'] = -511.48, ['z'] = 56.82 },
	[28] = { ['x'] = 1044.72, ['y'] = -755.6, ['z'] = 57.09 },
	[29] = { ['x'] = 1176.93, ['y'] = -825.63, ['z'] = 54.63 },
	[30] = { ['x'] = 1242.9, ['y'] = -1418.63, ['z'] = 34.38 },
	[31] = { ['x'] = 1272.94, ['y'] = -2035.27, ['z'] = 43.87 },
	[32] = { ['x'] = 807.05, ['y'] = -2062.38, ['z'] = 28.91 },
	[33] = { ['x'] = 473.86, ['y'] = -2031.49, ['z'] = 23.73 },
	[34] = { ['x'] = 197.63, ['y'] = -1784.09, ['z'] = 28.4 },
	[35] = { ['x'] = 72.99, ['y'] = -1885.54, ['z'] = 21.7 },
	[36] = { ['x'] = -164.46, ['y'] = -1702.88, ['z'] = 30.77 },
	[37] = { ['x'] = -85.82, ['y'] = -1491.87, ['z'] = 32.2 },
	[38] = { ['x'] = 92.15, ['y'] = -1483.84, ['z'] = 28.62 },
	[39] = { ['x'] = 260.5, ['y'] = -1316.42, ['z'] = 28.82 },
	[40] = { ['x'] = 483.46, ['y'] = -1260.71, ['z'] = 28.7 },
	[41] = { ['x'] = 503.58, ['y'] = -965.98, ['z'] = 26.65 },
	[42] = { ['x'] = 482.3, ['y'] = -674.28, ['z'] = 25.45 },
	[43] = { ['x'] = 397.21, ['y'] = -977.95, ['z'] = 28.67 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local esperar = 1000
		-- Citizen.Wait(1)
		if not servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
			local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)

			if distance <= 10.0 then
				esperar = 4
				DrawMarker(23,CoordenadaX,CoordenadaY,CoordenadaZ-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,100,0,0,0,0)
				if distance <= 1.5 then
					if IsControlJustPressed(0,38) and emP.checkPermission() then
						servico = true
						selecionado = 1
						CriandoBlip(locs,selecionado)
						TriggerEvent("Notify","importante","Voce iniciou sua <b>rota de patrulha</b>.")
					end
				end
			end
		end
		Citizen.Wait(esperar)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTREGAS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)

			if distance <= 30.0 then
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z+0.30,0,0,0,0,180.0,130.0,2.0,2.0,1.0,240,200,80,100,1,0,0,1)
				if distance <= 6.0 then
					if emP.checkPermission() then
						if IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("ghispo2")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("av-amarok")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("a45policia")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("av-gt63")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("av-levante")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("av-nc7")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("bmwg20")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("pdfocus")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("bmwm5policia")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("chevypolicia")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("porschespeed")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("av-m8")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("VRa3")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("VRa4")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("VRdm1200")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("VRq8")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("VRraptor")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("VRrs5")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("VRrs6")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("VRrs6av")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("VRtahoe")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("cls63s")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("dicgt63")) then
							RemoveBlip(blips)
							if selecionado == 42 then
								selecionado = 1
							else
								selecionado = selecionado + 1
							end
							emP.checkPayment()
							CriandoBlip(locs,selecionado)
						end
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
		Citizen.Wait(1)
		if servico then
			if IsControlJustPressed(0,168) then
				servico = false
				RemoveBlip(blips)
				TriggerEvent("Notify","negado","Voce cancelou sua <b>rota de patrulha</b>.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Rota de Patrulha")
	EndTextCommandSetBlipName(blips)
end