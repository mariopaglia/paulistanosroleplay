local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("emp_colheita")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local CoordenadaX = 289.77 -- 289.77,6592.36,29.99
local CoordenadaY = 6592.36
local CoordenadaZ = 29.99
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = 292.01, ['y'] = 6600.45, ['z'] = 30.07, ['h'] = 100.66 },
	[2] = { ['x'] = 292.16, ['y'] = 6622.0, ['z'] = 29.41, ['h'] = 91.65 },
	[3] = { ['x'] = 287.88, ['y'] = 6600.63, ['z'] = 30.05, ['h'] = 93.7 },
	[4] = { ['x'] = 287.93, ['y'] = 6622.83, ['z'] = 29.51, ['h'] = 89.87 },
	[5] = { ['x'] = 283.59, ['y'] = 6600.6, ['z'] = 30.07, ['h'] = 88.92 },
	[6] = { ['x'] = 283.69, ['y'] = 6622.52, ['z'] = 29.64, ['h'] = 92.35 },
	[7] = { ['x'] = 279.51, ['y'] = 6600.16, ['z'] = 30.04, ['h'] = 87.03 },
	[8] = { ['x'] = 279.48, ['y'] = 6623.11, ['z'] = 29.65, ['h'] = 93.67 },
	[9] = { ['x'] = 275.27, ['y'] = 6602.04, ['z'] = 30.01, ['h'] = 89.87 },
	[10] = { ['x'] = 275.3, ['y'] = 6619.95, ['z'] = 29.73, ['h'] = 96.77 },
	[11] = { ['x'] = 271.02, ['y'] = 6601.16, ['z'] = 30.02, ['h'] = 91.53 },
	[12] = { ['x'] = 271.09, ['y'] = 6621.45, ['z'] = 29.66, ['h'] = 95.79 },
	[13] = { ['x'] = 266.79, ['y'] = 6600.81, ['z'] = 30.05, ['h'] = 87.56 },
	[14] = { ['x'] = 266.82, ['y'] = 6622.94, ['z'] = 29.68, ['h'] = 95.43 },
	[15] = { ['x'] = 262.56, ['y'] = 6601.06, ['z'] = 29.98, ['h'] = 88.38 },
	[16] = { ['x'] = 262.64, ['y'] = 6622.17, ['z'] = 29.62, ['h'] = 95.46 },
	[17] = { ['x'] = 258.41, ['y'] = 6601.43, ['z'] = 29.95, ['h'] = 91.16 },
	[18] = { ['x'] = 258.41, ['y'] = 6622.24, ['z'] = 29.63, ['h'] = 94.79 },
	[19] = { ['x'] = 254.23, ['y'] = 6600.81, ['z'] = 29.91, ['h'] = 92.18 },
	[20] = { ['x'] = 254.28, ['y'] = 6622.47, ['z'] = 29.56, ['h'] = 95.54 },
	[21] = { ['x'] = 249.99, ['y'] = 6601.45, ['z'] = 29.89, ['h'] = 92.55 },
	[22] = { ['x'] = 250.06, ['y'] = 6621.71, ['z'] = 29.62, ['h'] = 91.08 },
	[23] = { ['x'] = 245.76, ['y'] = 6601.95, ['z'] = 29.82, ['h'] = 84.63 },
	[24] = { ['x'] = 245.83, ['y'] = 6622.19, ['z'] = 29.6, ['h'] = 91.6 },
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
			if distance <= 20 then
				DrawMarker(21,CoordenadaX,CoordenadaY,CoordenadaZ-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,200,0,0,0,1)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~r~E~w~  PARA INICIAR A COLHEITA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						servico = true
						selecionado = 1
						CriandoBlip(locs,selecionado)
						TriggerEvent("Notify","sucesso","Você entrou em serviço.")
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVIÇO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function(head,x,y,z)
	while true do
		Citizen.Wait(5)
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)
			local veh = GetVehiclePedIsIn(PlayerPedId(),false)

			if distance <= 45.0 then
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,200,0,0,0,1)
				if distance <= 2.5 then
					if IsControlJustPressed(0,38) then
						SetEntityHeading(PlayerPedId(),locs[selecionado].h)
						SetEntityCoords(PlayerPedId(),locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-1,false,false,false,false)
						TriggerEvent("progress",3000,"Colhendo")
						emP.trabalhando()

						RemoveBlip(blips)
						if selecionado == 24 then
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
end)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if servico then
			if IsControlJustPressed(0,168) then
				servico = false
				RemoveBlip(blips)
				TriggerEvent("Notify","importante","Você saiu de serviço.")
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
	AddTextComponentString("Colheita")
	EndTextCommandSetBlipName(blips)
end

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