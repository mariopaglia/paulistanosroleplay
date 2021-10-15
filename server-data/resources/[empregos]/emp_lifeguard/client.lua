local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("emp_lifeguard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local maxlocs = 23
local coordenadas = {
	{ ['id'] = 1, ['x'] = -1483.05, ['y'] = -1029.66, ['z'] = 6.13 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PONTOS DE OBSERVAÇÃO
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = -1451.54, ['y'] = -1031.71, ['z'] = 4.41 },
	[2] = { ['x'] = -1500.15, ['y'] = -1074.12, ['z'] = 3.65 },
	[3] = { ['x'] = -1572.13, ['y'] = -1026.33, ['z'] = 7.18 },
	[4] = { ['x'] = -1711.7, ['y'] = -949.89, ['z'] = 7.17 },
	[5] = { ['x'] = -1787.81, ['y'] = -853.15, ['z'] = 7.35 },
	[6] = { ['x'] = -1895.87, ['y'] = -707.14, ['z'] = 7.13 },
	[7] = { ['x'] = -2000.17, ['y'] = -553.82, ['z'] = 11.08 },
	[8] = { ['x'] = -2124.49, ['y'] = -481.74, ['z'] = 3.16 },
	[9] = { ['x'] = -2032.95, ['y'] = -615.57, ['z'] = 2.8 },
	[10] = { ['x'] = -1920.81, ['y'] = -758.91, ['z'] = 2.6 },
	[11] = { ['x'] = -1824.65, ['y'] = -898.7, ['z'] = 2.02 },
	[12] = { ['x'] = -1707.66, ['y'] = -1027.76, ['z'] = 3.52 },
	[13] = { ['x'] = -1607.22, ['y'] = -1110.59, ['z'] = 2.9 },
	[14] = { ['x'] = -1510.97, ['y'] = -1271.42, ['z'] = 1.59 },
	[15] = { ['x'] = -1459.59, ['y'] = -1386.6, ['z'] = 2.19 },
	[16] = { ['x'] = -1423.13, ['y'] = -1507.2, ['z'] = 1.95 },
	[17] = { ['x'] = -1365.65, ['y'] = -1621.35, ['z'] = 1.94 },
	[18] = { ['x'] = -1283.69, ['y'] = -1749.05, ['z'] = 1.73 },
	[19] = { ['x'] = -1176.1, ['y'] = -1733.94, ['z'] = 3.76 },
	[20] = { ['x'] = -1119.91, ['y'] = -1687.39, ['z'] = 3.93 },
	[21] = { ['x'] = -1254.95, ['y'] = -1702.38, ['z'] = 3.97 },
	[22] = { ['x'] = -1393.86, ['y'] = -1415.7, ['z'] = 3.21 },
	[23] = { ['x'] = -1421.56, ['y'] = -1121.64, ['z'] = 2.97 },
	[24] = { ['x'] = -1463.47, ['y'] = -1047.41, ['z'] = 4.17 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if not servico then
			for _,v in pairs(coordenadas) do
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
				local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)

				if distance <= 3 then
					DrawMarker(21,v.x,v.y,v.z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,251,109,0,50,0,0,0,1)
					if distance <= 1.2 then
						DrawText3Ds(v.x,v.y,v.z+0.10, "Pressione [~o~E~w~] para iniciar a patrulha de ~o~Salva-Vidas~w~.")
						--drawTxt("PRESSIONE  ~r~E~w~  PARA COMEÇAR A TRABALHAR",4,0.5,0.93,0.50,255,255,255,180)
						if IsControlJustPressed(0,38) then
							servico = true
							if v.id == 2 then
								selecionado = 43
							else
								selecionado = 1
							end
							ExecuteCommand("roupas salvavidas")
							CriandoBlip(locs,selecionado)
							TriggerEvent("Notify","sucesso","Você entrou em serviço.")
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVIÇO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if servico then
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
				local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)

			if distance <= 30.0 then
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z+0.20,0,0,0,0,180.0,130.0,2.0,2.0,1.0,255,0,0,50,1,0,0,1)
				if distance <= 4.5 then
					--if emP.checkPermission() then
						if IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("blazer")) then
							RemoveBlip(blips)
							if selecionado == 24 then
								selecionado = 1
							elseif selecionado == 82 then
								selecionado = 43
							else
								selecionado = selecionado + 1
							end							
							emP.checkPayment()
							CriandoBlip(locs,selecionado)
						end
					--end
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
		local ped = PlayerPedId()
		if servico then
			if IsControlJustPressed(0,168) and not IsPedInAnyVehicle(ped) then
				servico = false
				ExecuteCommand("roupas")
				RemoveBlip(blips)
				ExecuteCommand("roupas")
				TriggerEvent("Notify","aviso","Você saiu de serviço.")
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
	SetBlipColour(blips,64)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Rota de Salva-Vidas")
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

function DrawText3Ds(x,y,z,text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.34, 0.34)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.001+ factor, 0.028, 0, 0, 0, 0)
end