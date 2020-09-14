-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("nav_skinshop",src)
vSERVER = Tunnel.getInterface("nav_skinshop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALIDADES
-----------------------------------------------------------------------------------------------------------------------------------------
local localidades = {
	{ ['x'] = 75.40, ['y'] = -1392.92, ['z'] = 29.37 },
	{ ['x'] = -709.40, ['y'] = -153.66, ['z'] = 37.41 },
	{ ['x'] = -163.20, ['y'] = -302.03, ['z'] = 39.73 },
	{ ['x'] = 425.58, ['y'] = -806.23, ['z'] = 29.49 },
	{ ['x'] = -822.34, ['y'] = -1073.49, ['z'] = 11.32 },
	{ ['x'] = -1193.81, ['y'] = -768.49, ['z'] = 17.31 },
	{ ['x'] = -1450.85, ['y'] = -238.15, ['z'] = 49.81 },
	{ ['x'] = 4.90, ['y'] = 6512.47, ['z'] = 31.87 },
	{ ['x'] = 1693.95, ['y'] = 4822.67, ['z'] = 42.06 },
	{ ['x'] = 126.05, ['y'] = -223.10, ['z'] = 54.55 },
	{ ['x'] = 614.26, ['y'] = 2761.91, ['z'] = 42.08 },
	{ ['x'] = 1196.74, ['y'] = 2710.21, ['z'] = 38.22 },
	{ ['x'] = -3170.18, ['y'] = 1044.54, ['z'] = 20.86 },
	{ ['x'] = -1101.46, ['y'] = 2710.57, ['z'] = 19.10 },
	{ ['x'] = 452.57, ['y'] = -990.80, ['z'] = 30.68 },
	{ ['x'] = -439.89, ['y'] = 5991.72, ['z'] = 31.72 },
	{ ['x'] = -1096.45, ['y'] = -834.78, ['z'] = 14.28 },
	{ ['x'] = 314.37, ['y'] = -603.42, ['z'] = 43.30 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(5)
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local x,y,z = table.unpack(GetEntityCoords(ped))
			for k,v in pairs(localidades) do
				local distance = Vdist(x,y,z,v.x,v.y,v.z)
				if distance <= 50 then
					DrawMarker(21,v.x,v.y,v.z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
					if distance <= 1 and IsControlJustPressed(0,38) and not vRP.isHandcuffed() and vSERVER.checkSearch() then
						TriggerEvent("skinshop:toggleMenu")
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN NUI
-----------------------------------------------------------------------------------------------------------------------------------------
local cor = 0
local menuactive = false
local old_custom = {}
RegisterNetEvent("skinshop:toggleMenu")
AddEventHandler("skinshop:toggleMenu",function()
	menuactive = not menuactive
	if menuactive then
		old_custom = vRP.getCustomization(source)
		SetNuiFocus(true,true)
		local ped = PlayerPedId()
		if IsPedModel(ped,0x705E61F2) then
			SendNUIMessage({ showMenu = true, masc = true })
		else
			SendNUIMessage({ showMenu = true, masc = false })
		end
	else
		cor = 0
		dados,tipo = nil
		SetNuiFocus(false)
		SendNUIMessage({ showMenu = false, masc = true })
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if menuactive then InvalidateIdleCam() end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REGISTER NUI
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotate",function(data,cb)
	local ped = PlayerPedId()
	local heading = GetEntityHeading(ped)
	if data == "left" then
		SetEntityHeading(ped,heading+15)
	elseif data == "right" then
		SetEntityHeading(ped,heading-15)
	elseif data == "handsup" then
		if not IsEntityPlayingAnim(ped,"random@mugging3","handsup_standing_base",3) then
			TaskPlayAnim(ped,"random@mugging3","handsup_standing_base",8.0,8.0,-1,49,10,0,0,0)
		else
			ClearPedTasks(ped)
		end
	end
end)

RegisterNUICallback("color",function(data,cb)
	if data == "left" then
		if cor ~= 0 then cor = cor - 1 else cor = 25 end
	elseif data == "right" then
		if cor ~= 25 then cor = cor + 1 else cor = 0 end
	end
	if dados and tipo then setClothes(dados,tipo,cor) end
end)

RegisterNUICallback("update",function(data,cb)
	dados = tonumber(json.encode(data[1]))
	tipo = tonumber(json.encode(data[2]))
	cor = 0
	setClothes(dados,tipo,cor)
end)

RegisterNUICallback("exit",function()
	vSERVER.shopBuy(old_custom)
	TriggerEvent("skinshop:toggleMenu")	
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
function setClothes(dados,tipo,cor)
	local ped = PlayerPedId()
	if dados < 100 then		
		SetPedComponentVariation(ped,dados,tipo,cor,1)
	else
		SetPedPropIndex(ped,dados-100,tipo,cor,1)
	end
end