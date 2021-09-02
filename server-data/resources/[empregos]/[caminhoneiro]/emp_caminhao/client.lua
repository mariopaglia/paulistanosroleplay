local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("emp_caminhao")

vSERVER = Tunnel.getInterface("vrp_garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local random = 0
local modules = ""
local servico = false
local servehicle = nil
local CoordenadaX = 1194.46
local CoordenadaY = -3248.87
local CoordenadaZ = 7.09
local CoordenadaX2 = 0.0
local CoordenadaY2 = 0.0
local CoordenadaZ2 = 0.0
-- 1194.46, -3248.87, 7.09
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIESEL
-----------------------------------------------------------------------------------------------------------------------------------------
local diesel = {
	[1] = { ['x'] = 43.06, ['y'] = 2803.80, ['z'] = 57.87 }, -- 43.06, 2803.80, 57.87 (7.53km)
	[2] = { ['x'] = 243.15, ['y'] = 2602.41, ['z'] = 45.11 }, -- 243.15, 2602.41, 45.11 (7.20km)
	[3] = { ['x'] = 1059.15, ['y'] = 2660.69, ['z'] = 39.55 }, -- 1059.15, 2660.69, 39.55 (7.15km)
	[4] = { ['x'] = 1990.22, ['y'] = 3763.54, ['z'] = 32.18 }, -- 1990.22, 3763.54, 32.18 (8.29km)
	[5] = { ['x'] = 81.23, ['y'] = 6334.27, ['z'] = 31.22 }, -- 81.23, 6334.27, 31.22 (11.46km)
	[6] = { ['x'] = 2770.81, ['y'] = 1439.26, ['z'] = 24.51 } -- 2770.81, 1439.26, 24.51 (6.90km)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- gasolina
-----------------------------------------------------------------------------------------------------------------------------------------
local gasolina = {
	[1] = { ['x'] = -2530.05, ['y'] = 2325.91, ['z'] = 33.05 }, -- -2530.05, 2325.91, 33.05 (9.11km)
	[2] = { ['x'] = -2082.05, ['y'] = -319.80, ['z'] = 13.05 }, -- -2082.05, -319.80, 13.05 (5.68km)
	[3] = { ['x'] = -1413.47, ['y'] = -279.95, ['z'] = 46.33 }, -- -1413.47, -279.95, 46.33 (4.88km)
	[4] = { ['x'] = 280.64, ['y'] = -1259.95, ['z'] = 29.21 }, -- 280.64, -1259.95, 29.21 (2.92km)
	[5] = { ['x'] = 1208.38, ['y'] = -1402.58, ['z'] = 35.22 }, -- 1208.38, -1402.58, 35.22 (2.75km)
	[6] = { ['x'] = 1181.46, ['y'] = -334.74, ['z'] = 69.17 }, -- 1181.46, -334.74, 69.17 (3.75km)
	[7] = { ['x'] = 2567.72, ['y'] = 362.65, ['z'] = 108.45 } -- 2567.72, 362.65, 108.45 (5.01km)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- carros
-----------------------------------------------------------------------------------------------------------------------------------------
local carros = {
	[1] = { ['x'] = -774.19, ['y'] = -254.45, ['z'] = 37.10 }, -- -774.19, -254.45, 37.10 (4.51km)
	[2] = { ['x'] = -231.64, ['y'] = -1170.94, ['z'] = 22.83 }, -- -231.64, -1170.94, 22.83 (3.34km)
	[3] = { ['x'] = 925.59, ['y'] = -8.79, ['z'] = 78.76 }, -- 925.59, -8.79, 78.76 (4.08km)
	[4] = { ['x'] = -506.18, ['y'] = -2191.37, ['z'] = 6.53 }, -- -506.18, -2191.37, 6.53 (3.51km)
	[5] = { ['x'] = 1209.15, ['y'] = 2712.03, ['z'] = 38.00 }, -- 1209.15, 2712.03, 38.00 (7.05km)
	[6] = { ['x'] = -72.97, ['y'] = -1090.45, ['z'] = 25.95 } -- -72.97, -1090.45, 25.95 (3.28km)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- madeira
-----------------------------------------------------------------------------------------------------------------------------------------
local madeira = {
	[1] = { ['x'] = -581.20, ['y'] = 5317.28, ['z'] = 70.24 }, -- -581.20, 5317.28, 70.24 (11.05km)
	[2] = { ['x'] = 2701.74, ['y'] = 3450.62, ['z'] = 55.79 }, -- 2701.74, 3450.62, 55.79 (8.02km)
	[3] = { ['x'] = 1203.52, ['y'] = -1309.33, ['z'] = 35.22 }, -- 1203.52, -1309.33, 35.22 (2.84km)
	[4] = { ['x'] = 16.99, ['y'] = -386.11, ['z'] = 39.32 } -- 16.99, -386.11, 39.32 (4.08km)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOWS
-----------------------------------------------------------------------------------------------------------------------------------------
local show = {
	[1] = { ['x'] = 1994.91, ['y'] = 3061.17, ['z'] = 47.04 }, -- 1994.91, 3061.17, 47.04 (7.80km)
	[2] = { ['x'] = -1397.32, ['y'] = -581.99, ['z'] = 30.28 }, -- -1397.32, -581.99, 30.28 (4.72km)
	[3] = { ['x'] = -552.43, ['y'] = 303.34, ['z'] = 83.21 }, -- -552.43, 303.34, 83.21 (4.94km)
	[4] = { ['x'] = -227.52, ['y'] = -2051.27, ['z'] = 27.62 } -- -227.52, -2051.27, 27.62 (2.69km)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- /PACK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("entregar",function(source,args) --RegisterCommand("pack",function(source,args)
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
	local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)

	if distance <= 50.1 and not servico then
		if args[1] == "diesel" then
			servico = true
			modules = args[1]
			servehicle = -1207431159
			random = emP.getTruckpoint(modules)
			CoordenadaX2 = diesel[random].x
			CoordenadaY2 = diesel[random].y
			CoordenadaZ2 = diesel[random].z
			CriandoBlip(CoordenadaX2,CoordenadaY2,CoordenadaZ2)
			TriggerEvent("Notify","importante","Entrega de <b>Diesel</b> iniciada, pegue o caminhão, a carga e vá até o destino marcado.")
		elseif args[1] == "gasolina" then --elseif args[1] == "gasolina" then
			servico = true
			modules = args[1]
			servehicle = 1956216962
			random = emP.getTruckpoint(modules)
			CoordenadaX2 = gasolina[random].x
			CoordenadaY2 = gasolina[random].y
			CoordenadaZ2 = gasolina[random].z
			CriandoBlip(CoordenadaX2,CoordenadaY2,CoordenadaZ2)
			TriggerEvent("Notify","importante","Entrega de <b>gasolina</b> iniciada, pegue o caminhão, a carga e vá até o destino marcado.")
		elseif args[1] == "carros" then --elseif args[1] == "carros" then
			servico = true
			modules = args[1]
			servehicle = 2091594960
			random = emP.getTruckpoint(modules)
			CoordenadaX2 = carros[random].x
			CoordenadaY2 = carros[random].y
			CoordenadaZ2 = carros[random].z
			CriandoBlip(CoordenadaX2,CoordenadaY2,CoordenadaZ2)
			TriggerEvent("Notify","importante","Entrega de <b>Veículos</b> iniciada, pegue o caminhão, a carga e vá até o destino marcado.")
		elseif args[1] == "madeira" then --elseif args[1] == "madeira" then
			servico = true
			modules = args[1]
			servehicle = 2016027501
			random = emP.getTruckpoint(modules)
			CoordenadaX2 = madeira[random].x
			CoordenadaY2 = madeira[random].y
			CoordenadaZ2 = madeira[random].z
			CriandoBlip(CoordenadaX2,CoordenadaY2,CoordenadaZ2)
			TriggerEvent("Notify","importante","Entrega de <b>Madeiras</b> iniciada, pegue o caminhão, a carga e vá até o destino marcado.")
		elseif args[1] == "show" then
			servico = true
			modules = args[1]
			servehicle = -1770643266
			random = emP.getTruckpoint(modules)
			CoordenadaX2 = show[random].x
			CoordenadaY2 = show[random].y
			CoordenadaZ2 = show[random].z
			CriandoBlip(CoordenadaX2,CoordenadaY2,CoordenadaZ2)
			TriggerEvent("Notify","importante","Entrega de <b>Shows</b> iniciada, pegue o caminhão, a carga e vá até o destino marcado.")
		else
			TriggerEvent("Notify","aviso","<b>Disponíveis:</b> diesel, carros, show, madeira e gasolina")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTREGAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX2,CoordenadaY2,CoordenadaZ2)
			local distance = GetDistanceBetweenCoords(CoordenadaX2,CoordenadaY2,cdz,x,y,z,true)

			if distance <= 20.0 then
				idle = 5
				--DrawMarker(21,1197.25,-3253.47,7.09-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,230,100,100,0,0,0,1)
				DrawMarker(21,CoordenadaX2,CoordenadaY2,CoordenadaZ2,0,0,0,0,0,0,3.0,3.0,2.0,255,230,100,100,1,0,0,1)
				if distance <= 5.9 then
					if IsControlJustPressed(0,38) then
						local vehicle = getVehicleInDirection(GetEntityCoords(PlayerPedId()),GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,5.0,0.0))
						if GetEntityModel(vehicle) == servehicle then
							emP.checkPayment(random,modules)
							vSERVER.deleteVehicles(vehicle)
							RemoveBlip(blips)
							servico = false
						end
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function getVehicleInDirection(coordsfrom,coordsto)
	local handle = CastRayPointToPoint(coordsfrom.x,coordsfrom.y,coordsfrom.z,coordsto.x,coordsto.y,coordsto.z,10,PlayerPedId(),false)
	local a,b,c,d,vehicle = GetRaycastResult(handle)
	return vehicle
end

function CriandoBlip(x,y,z)
	blips = AddBlipForCoord(x,y,z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega de Carga")
	EndTextCommandSetBlipName(blips)
end