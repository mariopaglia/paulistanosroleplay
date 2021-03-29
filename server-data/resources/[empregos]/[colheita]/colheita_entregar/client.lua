local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = Tunnel.getInterface("colheita_entregar")
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
	{ ['x'] = 280.3, ['y'] = 6591.96, ['z'] = 30.17 }, -- 296.43,6587.4,29.84
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = -2508.01, ['y'] = 3614.52, ['z'] = 13.8 },
	[2] = { ['x'] = -3241.19, ['y'] = 1002.16, ['z'] = 12.84 },
	[3] = { ['x'] = -1490.24, ['y'] = -379.16, ['z'] = 40.17 },
	[4] = { ['x'] = -715.24, ['y'] = -915.41, ['z'] = 19.22 },
	[5] = { ['x'] = -55.0, ['y'] = -1753.56, ['z'] = 29.43 },
	[6] = { ['x'] = 1138.06, ['y'] = -983.95, ['z'] = 46.42 },
	[7] = { ['x'] = 374.5, ['y'] = 324.86, ['z'] = 103.57 },
	[8] = { ['x'] = 148.38, ['y'] = 1667.53, ['z'] = 228.82 },
	[9] = { ['x'] = 546.65, ['y'] = 2672.01, ['z'] = 42.16 },
	[10] = { ['x'] = 1476.05, ['y'] = 2724.85, ['z'] = 37.66 },
	[11] = { ['x'] = 1962.77, ['y'] = 3740.39, ['z'] = 32.35 },
	[12] = { ['x'] = 2476.35, ['y'] = 4445.03, ['z'] = 35.38 },
	[13] = { ['x'] = 1701.78, ['y'] = 4931.35, ['z'] = 42.07 },
	[14] = { ['x'] = 1729.49, ['y'] = 6413.23, ['z'] = 35.04 },
	[15] = { ['x'] = 1088.03, ['y'] = 6508.14, ['z'] = 21.06 },
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

				if distance <= 20 then
					idle = 5
					-- DrawMarker(21,pegarBlips.x, pegarBlips.y, pegarBlips.z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,200,0,0,0,1)
					DrawMarker(24,pegarBlips.x,pegarBlips.y,pegarBlips.z-0.6,0,0,0,0.0,0,0,0.7,0.7,1.0,255,0,0,200,0,0,0,1)
					
					if distance <= 1.2 then
						drawTxt("PRESSIONE  ~r~E~w~  PARA INICIAR A ENTREGA",4,0.5,0.93,0.50,255,255,255,180)
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
					drawTxt("PRESSIONE  ~r~G~w~  PARA REALIZAR AS ~g~ENTREGAS~w~",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,47) and not IsPedInAnyVehicle(ped) then --and GetEntityModel(vehicle) == 1475773103 then
						TriggerEvent('cancelando',true)
						RemoveBlip(blips)
						backentrega = selecionado
						processo = true
						segundos = 2
						
						TriggerEvent("progress",2000,"Entregando")
						vRP._playAnim(true,{{"pickup_object","pickup_low"}},false)
									 
						if selecionado == 15 then
							selecionado = 1
						else
							selecionado = selecionado + 1
						end
						Citizen.Wait(2000)
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
	AddTextComponentString("Coletar Placas de Metal")
	EndTextCommandSetBlipName(blips)
end