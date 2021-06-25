local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("entrega_drogas")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS 
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local CoordenadaX = 499.24 -- 499.24, -550.37, 24.75
local CoordenadaY = -550.37
local CoordenadaZ = 24.75
local processo = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = 650.21, ['y'] = 246.14, ['z'] = 103.43 },
    [2] = { ['x'] = 331.95, ['y'] = 434.52, ['z'] = 145.21 },
	[3] = { ['x'] = -747.93, ['y'] = 684.29, ['z'] = 144.75 },
	[4] = { ['x'] = -932.15, ['y'] = 400.62, ['z'] = 82.04 },
	[5] = { ['x'] = -1337.91, ['y'] = 308.56, ['z'] = 65.51 },
	[6] = { ['x'] = -1308.58, ['y'] = -258.29, ['z'] = 46.52 },
	[7] = { ['x'] = -1778.04, ['y'] = -390.14, ['z'] = 46.48 },
	[8] = { ['x'] = -1816.53, ['y'] = -1193.62, ['z'] = 14.31 },
	[9] = { ['x'] = -1306.75, ['y'] = -1226.61, ['z'] = 8.99 },
	[10] = { ['x'] = -1071.69, ['y'] = -1636.53, ['z'] = 8.2 },
	[11] = { ['x'] = -602.01, ['y'] = -1115.72, ['z'] = 25.86 },
	[12] = { ['x'] = -2.85, ['y'] = -1496.52, ['z'] = 31.86 },
	[13] = { ['x'] = 215.34, ['y'] = -1861.76, ['z'] = 30.87 },
	[14] = { ['x'] = 559.48, ['y'] = -1776.57, ['z'] = 33.45 },
	[15] = { ['x'] = 1258.84, ['y'] = -1761.35, ['z'] = 49.66 },
	[16] = { ['x'] = 858.26, ['y'] = -1038.34, ['z'] = 33.08 },
	[17] = { ['x'] = 1113.84, ['y'] = -649.13, ['z'] = 57.75 },
	[18] = { ['x'] = 820.89, ['y'] = -156.47, ['z'] = 80.76 },
	[19] = { ['x'] = 115.38, ['y'] = 170.38, ['z'] = 112.46 },
	[20] = { ['x'] = -357.31, ['y'] = 16.36, ['z'] = 47.86 },
	[21] = { ['x'] = -124.43, ['y'] = -980.02, ['z'] = 27.28 },
	[22] = { ['x'] = 57.02, ['y'] = -444.84, ['z'] = 37.56 },
	[23] = { ['x'] = 240.69, ['y'] = -1379.39, ['z'] = 33.75 },
	[24] = { ['x'] = 267.85, ['y'] = -643.95, ['z'] = 42.02 },
	[25] = { ['x'] = 64.14, ['y'] = -1040.3, ['z'] = 33.46 },
	[26] = { ['x'] = 281.17, ['y'] = -992.79, ['z'] = 33.45 },
	[27] = { ['x'] = 486.39, ['y'] = -591.45, ['z'] = 26.22 },
	[28] = { ['x'] = 396.4, ['y'] = -355.2, ['z'] = 46.82 }, --
	[29] = { ['x'] = 135.33, ['y'] = 323.24, ['z'] = 116.64 },
	[30] = { ['x'] = -818.82, ['y'] = -575.35, ['z'] = 30.28 },
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
					drawTxt("PRESSIONE  ~r~E~w~  PARA INICIAR AS ENTREGAS DE ~g~DROGAS~w~",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						servico = true
						selecionado = math.random(30)
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
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~r~E~w~  PARA ENTREGAR AS DROGAS",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and not IsPedInAnyVehicle(ped) then
						if emP.checkPermission() then
							if emP.checkPayment2() then
								droga = CreateObject(GetHashKey("prop_meth_bag_01"),locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-1,true,true,true)
	
								emP.MarcarOcorrencia() -- Acionar a policia
	
								TriggerEvent('cancelando',true)
								RemoveBlip(blips)
								backentrega = selecionado
								processo = true
								segundos = 5
	
								vRP._playAnim(true,{{"pickup_object","pickup_low"}},false)
								vRP._CarregarObjeto("pickup_object","pickup_low","hei_prop_heist_cash_pile",49,28422)
	
								SetTimeout(9000,function()
									DeleteObject(droga)
								end)
	
								while true do
									if backentrega == selecionado then
										selecionado = math.random(30)
									else
										break
									end
									Citizen.Wait(1)
								end
								CriandoBlip(locs,selecionado)
							end
						else
							if emP.checkPayment() then
								droga = CreateObject(GetHashKey("prop_meth_bag_01"),locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-1,true,true,true)
	
								emP.MarcarOcorrencia() -- Acionar a policia
	
								TriggerEvent('cancelando',true)
								RemoveBlip(blips)
								backentrega = selecionado
								processo = true
								segundos = 5
	
								vRP._playAnim(true,{{"pickup_object","pickup_low"}},false)
								vRP._CarregarObjeto("pickup_object","pickup_low","hei_prop_heist_cash_pile",49,28422)
	
								SetTimeout(9000,function()
									DeleteObject(droga)
								end)
	
								while true do
									if backentrega == selecionado then
										selecionado = math.random(30)
									else
										break
									end
									Citizen.Wait(1)
								end
								CriandoBlip(locs,selecionado)
							end
						end
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

RegisterKeyMapping('emp:rotacancelar4', 'cancelarrota4', 'keyboard', 'F7')

RegisterCommand('emp:rotacancelar4', function()
	if servico then
			servico = false
			RemoveBlip(blips)
			TriggerEvent("Notify","aviso","Você saiu de serviço.")
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
				vRP._DeletarObjeto()
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
	AddTextComponentString("Entregar Drogas")
	EndTextCommandSetBlipName(blips)
end