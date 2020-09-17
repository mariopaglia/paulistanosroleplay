local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("entrega_maconha")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local CoordenadaX = 446.12
local CoordenadaY = -1235.64
local CoordenadaZ = 29.96
local processo = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = 1360.62, ['y'] = -1556.22, ['z'] = 56.34 },
    [2] = { ['x'] = 727.42, ['y'] = -777.83, ['z'] = 25.31 },
	[3] = { ['x'] = -579.66, ['y'] = 240.97, ['z'] = 82.63 },
	[4] = { ['x'] = -582.35, ['y'] = -331.49, ['z'] = 35.15 },
	[5] = { ['x'] = -1113.98, ['y'] = -1579.54, ['z'] = 8.67 },
	[6] = { ['x'] = -1698.28, ['y'] = -460.37, ['z'] = 41.64 },
	[7] = { ['x'] = -319.91, ['y'] = -1389.59, ['z'] = 36.50 },
	[8] = { ['x'] = -845.48, ['y'] = -1088.30, ['z'] = 11.63 },
	[9] = { ['x'] = -458.23, ['y'] = 66.52, ['z'] = 58.55 },
	[10] = { ['x'] = -813.53, ['y'] = -586.09, ['z'] = 30.66 },
	[11] = { ['x'] = -99.48, ['y'] = 9.48, ['z'] = 74.43 },
	[12] = { ['x'] = 140.28, ['y'] = -286.77, ['z'] = 50.44 },
	[13] = { ['x'] = -15.91, ['y'] = -612.54, ['z'] = 35.86 },
	[14] = { ['x'] = -1583.35, ['y'] = -921.59, ['z'] = 9.54 },
	[15] = { ['x'] = -758.18, ['y'] = -423.07, ['z'] = 35.69 },
	[16] = { ['x'] = -1087.20, ['y'] = 479.49, ['z'] = 81.52 },
	[17] = { ['x'] = 485.81, ['y'] = -1477.06, ['z'] = 29.28 },
	[18] = { ['x'] = -60.85, ['y'] = 360.46, ['z'] = 113.05 },
	[19] = { ['x'] = -861.15, ['y'] = -355.91, ['z'] = 38.67 },
	[20] = { ['x'] = -437.61, ['y'] = -429.09, ['z'] = 32.93 }
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
					drawTxt("PRESSIONE  ~r~E~w~  PARA INICIAR AS ENTREGAS DE ~g~MACONHA~w~",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38)then
						servico = true
						selecionado = math.random(20)
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

			if distance <= 10 then
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~r~E~w~  PARA ENTREGAR AS DROGAS",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and emP.checkItens() and not IsPedInAnyVehicle(ped) then
						droga = CreateObject(GetHashKey("prop_weed_block_01"),locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-1,true,true,true)
						if emP.checkPayment() then
							local random = math.random(100)
							if random >= 80 then
								emP.MarcarOcorrencia()
							end

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
									selecionado = math.random(20)
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
				TriggerEvent("Notify","aviso","Você saiu de serviço.")
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