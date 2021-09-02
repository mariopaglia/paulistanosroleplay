local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = Tunnel.getInterface("farm_cosanostra")
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
	{ ['x'] = 1395.53, ['y'] = 1159.86, ['z'] = 114.34 }, -- 1394.99,1159.01,114.33 (Cosanostra)
	{ ['x'] = -1881.27, ['y'] = 2061.03, ['z'] = 140.99 }, -- -1881.27,2061.03,140.99 (Camorra)
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = 245.07, ['y'] = -41.35, ['z'] = 69.89 },
	[2] = { ['x'] = 2558.87, ['y'] = 288.69, ['z'] = 108.60 },
	[3] = { ['x'] = 835.25, ['y'] = -1036.80, ['z'] = 27.64 },
	[4] = { ['x'] = 798.10, ['y'] = -2136.10, ['z'] = 29.51 },
	[5] = { ['x'] = -6.52, ['y'] = -1107.20, ['z'] = 29.00 },
	[6] = { ['x'] = -655.96, ['y'] = -941.24, ['z'] = 22.25 },
	[7] = { ['x'] = -1298.44, ['y'] = -393.04, ['z'] = 36.70 },
	[8] = { ['x'] = -3179.29, ['y'] = 1093.23, ['z'] = 20.84 },
	[9] = { ['x'] = -1127.73,['y'] = 2707.98, ['z'] = 18.80 },
	[10] = { ['x'] = -342.49, ['y'] = 6097.68, ['z'] = 31.31 },
	[11] = { ['x'] = 1687.70, ['y'] = 3755.69, ['z'] = 34.56 },
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
					drawTxt("PRESSIONE  ~r~E~w~  PARA COLETAR AS ~g~POLVORAS~w~ E ~g~TECIDOS~w~",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and emP.checkPermission() and not IsPedInAnyVehicle(ped) then

						TriggerEvent('cancelando',true)
						RemoveBlip(blips)
						backentrega = selecionado
						processo = true
						segundos = 5
						
						TriggerEvent("progress",5000,"Coletando")
						vRP._playAnim(false,{{"anim@heists@ornate_bank@grab_cash_heels","grab"}},true)
									 
						if selecionado == 11 then
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


RegisterKeyMapping('emp:farmcosanostra_fenix', 'Cancelar Rota CosaNostra', 'keyboard', 'F7')

RegisterCommand('emp:farmcosanostra_fenix', function()
	if servico then
			servico = false
			RemoveBlip(blips)
			TriggerEvent("Notify","importante","Você saiu de serviço")
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
	AddTextComponentString("Polvoras")
	EndTextCommandSetBlipName(blips)
end