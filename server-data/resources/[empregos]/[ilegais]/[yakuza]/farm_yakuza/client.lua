local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = Tunnel.getInterface("farm_yakuza")
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
	{ ['x'] = 412.04, ['y'] = -1503.97, ['z'] = 33.81 }, -- 412.0,-1503.94,33.81 (Yakuza)
	{ ['x'] = -591.0, ['y'] = -1617.87, ['z'] = 33.02 }, -- -591.0,-1617.87,33.02 (Triade)
	{ ['x'] = 570.96, ['y'] = -3123.47, ['z'] = 18.77 }, -- 570.95,-3123.47,18.77 (Irmandade)
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = -1646.83, ['y'] = -984.76, ['z'] = 7.34 }, 
	[2] = { ['x'] = -2949.53, ['y'] = 58.41, ['z'] = 11.61 }, 
	[3] = { ['x'] = -1394.17, ['y'] = -443.87, ['z'] = 34.48 }, 
	[4] = { ['x'] = -924.45, ['y'] = 376.49, ['z'] = 79.2 },
	[5] = { ['x'] = -1502.32, ['y'] = 1527.82, ['z'] = 115.25 }, 
	[6] = { ['x'] = -478.18, ['y'] = 763.23, ['z'] = 169.91 }, 
	[7] = { ['x'] = 208.45, ['y'] = -163.21, ['z'] = 56.58 }, 
	[8] = { ['x'] = -327.92, ['y'] = -1318.04, ['z'] = 31.41 }, 
	[9] = { ['x'] = 1210.62, ['y'] = -1247.03, ['z'] = 35.23 }, 
	[10] = { ['x'] = 228.39, ['y'] = -1769.32, ['z'] = 28.71 }, 
	[11] = { ['x'] = 1082.08, ['y'] = -2388.72, ['z'] = 30.45 },
	[12] = { ['x'] = 2542.95, ['y'] = 341.93, ['z'] = 108.47 },
	[13] = { ['x'] = 2531.29, ['y'] = 2638.29, ['z'] = 38.03 },
	[14] = { ['x'] = 2116.38, ['y'] = 4765.61, ['z'] = 41.12 },
	[15] = { ['x'] = 1925.67, ['y'] = 3744.65, ['z'] = 32.51 },
	[16] = { ['x'] = 252.97, ['y'] = 2588.13, ['z'] = 45.01 },
	[17] = { ['x'] = 70.4, ['y'] = 3729.42, ['z'] = 39.69 },
	[18] = { ['x'] = 720.99, ['y'] = 4198.11, ['z'] = 40.71 },
	[19] = { ['x'] = 2946.38, ['y'] = 4634.18, ['z'] = 48.55 },
	[20] = { ['x'] = 1540.06, ['y'] = 1722.28, ['z'] = 109.82 },
	[21] = { ['x'] = 492.4, ['y'] = -633.6, ['z'] = 24.86 },
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
					local vehicle = GetPlayersLastVehicle()
					drawTxt("PRESSIONE  ~r~E~w~  PARA COLETAR ~g~PLACA DE CIRCUITO~w~",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and emP.checkPermission() and not IsPedInAnyVehicle(ped) then --and GetEntityModel(vehicle) == 1475773103 then
						TriggerEvent('cancelando',true)
						RemoveBlip(blips)
						backentrega = selecionado
						processo = true
						segundos = 5
						
						TriggerEvent("progress",5000,"Coletando")
						vRP._playAnim(false,{{"anim@heists@ornate_bank@grab_cash_heels","grab"}},true)
									 
						if selecionado == 21 then
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
RegisterKeyMapping('emp:farmyakuza_fenix', 'Cancelar Farm Yakuza', 'keyboard', 'F7')

RegisterCommand('emp:farmyakuza_fenix', function()
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
	AddTextComponentString("Coletar Componentes")
	EndTextCommandSetBlipName(blips)
end