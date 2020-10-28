local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = Tunnel.getInterface("farm_bratva")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS 
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local CoordenadaX = -77.33
local CoordenadaY = 1000.96
local CoordenadaZ = 230.60
local selecionado = 0
local processo = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = 1687.70, ['y'] = 3755.69, ['z'] = 34.56 }, 
	[2] = { ['x'] = -342.49, ['y'] = 6097.68, ['z'] = 31.31 }, 
	[3] = { ['x'] = -1127.73,['y'] = 2707.98, ['z'] = 18.80 }, 
	[4] = { ['x'] = -3179.29, ['y'] = 1093.23, ['z'] = 20.84 },
	[5] = { ['x'] = -1298.44, ['y'] = -393.04, ['z'] = 36.70 }, 
	[6] = { ['x'] = -655.96, ['y'] = -941.24, ['z'] = 22.25 }, 
	[7] = { ['x'] = -6.52, ['y'] = -1107.20, ['z'] = 29.00 }, 
	[8] = { ['x'] = 798.10, ['y'] = -2136.10, ['z'] = 29.51 }, 
	[9] = { ['x'] = 835.25, ['y'] = -1036.80, ['z'] = 27.64 }, 
	[10] = { ['x'] = 2558.87, ['y'] = 288.69, ['z'] = 108.60 }, 
	[11] = { ['x'] = 245.07, ['y'] = -41.35, ['z'] = 69.89 }
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
					drawTxt("PRESSIONE  ~r~E~w~  PARA INCIAR A COLETA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and emP.checkPermission() then
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
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~r~E~w~  PARA COLETAR AS ~g~PLACAS DE METAL~w~",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and emP.checkPermission() and not IsPedInAnyVehicle(ped) then
						if emP.checkPayment() then
							TriggerEvent('cancelando',true)
							RemoveBlip(blips)
							backentrega = selecionado
							processo = true
							segundos = 10
							
							TriggerEvent("progress",10000,"Coletando")
                            vRP._playAnim(false,{{"anim@heists@ornate_bank@grab_cash_heels","grab"}},true)

                            SetTimeout(10000,function()
                            	vRP._stopAnim(source,false)
							end)
										 
							if selecionado == 11 then
								selecionado = 1
							else
								selecionado = selecionado + 1
							end
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