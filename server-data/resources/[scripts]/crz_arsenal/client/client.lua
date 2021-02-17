local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

inMenu = true
local Menu = true
local player = PlayerPedId()

local arsenal = {
	{ -1105.15,-823.82,14.29 }, -- PMESP/ROTA
	{ 459.99,-981.08,30.69 }, -- PCESP
	{ 2901.48,3830.69,54.61 } -- PRF
}

if Menu then
	Citizen.CreateThread(function()
	while true do
		local idle = 1000
		for _,lugares in pairs(arsenal) do
			local x,y,z = table.unpack(lugares)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),x,y,z,true)
			
			if distance <= 3 then
				DrawMarker(25,x,y+0.33,z-0.90,0,0,0,0,180.0,130.0,2.0,2.0,1.0,25,25,122,50,0,0,0,0)
				idle = 5
			end
		end
	Citizen.Wait(idle)
	end

	end)
end

RegisterKeyMapping('vrp_arsenal:open', 'Arsenal', 'keyboard', 'E')

RegisterCommand('vrp_arsenal:open', function()
	for _,lugares in pairs(arsenal) do
		local x,y,z = table.unpack(lugares)
		local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),x,y,z,true)
	if distance <= 1 then
		TriggerServerEvent('crz_arsenal:permissao')
		if x == 459.99 then
			dp = "PCESP"
		end
	end
end
end, false)


RegisterNetEvent('crz_arsenal:permissao')
AddEventHandler('crz_arsenal:permissao',function()
	inMenu = true
	SetNuiFocus(true, true)
	SendNUIMessage({type = 'openGeneral'})
end)


RegisterNUICallback('NUIFocusOff', function()
  inMenu = false
  SetNuiFocus(false)
  SendNUIMessage({type = 'closeAll'})
end)

-- RegisterNUICallback('Agua', function()
-- 	local ped = PlayerPedId()
-- 	GiveWeaponToPed(ped,GetHashKey("WEAPON_KNIFE"),0,0,1)
-- end)
RegisterNUICallback('Cerveja', function()
	local ped = PlayerPedId()
	-- GiveWeaponToPed(ped,GetHashKey("WEAPON_STUNGUN"),0,0,0)
	vRP.giveWeapons({["WEAPON_STUNGUN"] = { ammo = 0 }})
	if dp == "PCESP" then
		TriggerServerEvent('crz_arsenal:logspcesp',"Taser")
	elseif dp == nil then
		TriggerServerEvent('crz_arsenal:logs',"Taser")
	end
end)
RegisterNUICallback('Vodka', function()
	local ped = PlayerPedId()
	-- GiveWeaponToPed(ped,GetHashKey("WEAPON_NIGHTSTICK"),0,0,0)
	vRP.giveWeapons({["WEAPON_NIGHTSTICK"] = { ammo = 0 }})
	if dp == "PCESP" then
		TriggerServerEvent('crz_arsenal:logspcesp',"Cassetete")
	elseif dp == nil then
		TriggerServerEvent('crz_arsenal:logs',"Cassetete")
	end
end)
RegisterNUICallback('Conhaque', function()
	TriggerServerEvent('crz_arsenal:colete')
	if dp == "PCESP" then
		TriggerServerEvent('crz_arsenal:logspcesp',"Colete")
	elseif dp == nil then
		TriggerServerEvent('crz_arsenal:logs',"Colete")
	end
end)
RegisterNUICallback('Whisky', function()
	local ped = PlayerPedId()
	-- GiveWeaponToPed(ped,GetHashKey("WEAPON_FIREEXTINGUISHER"),25000,0,1)
	vRP.giveWeapons({["WEAPON_FIREEXTINGUISHER"] = { ammo = 25000 }})
	if dp == "PCESP" then
		TriggerServerEvent('crz_arsenal:logspcesp',"Extintor")
	elseif dp == nil then
		TriggerServerEvent('crz_arsenal:logs',"Extintor")
	end
end)
RegisterNUICallback('Tequila', function()
	local ped = PlayerPedId()
	-- GiveWeaponToPed(ped,GetHashKey("WEAPON_FLASHLIGHT"),0,0,0)
	vRP.giveWeapons({["WEAPON_FLASHLIGHT"] = { ammo = 0 }})
	if dp == "PCESP" then
		TriggerServerEvent('crz_arsenal:logspcesp',"Lanterna")
	elseif dp == nil then
		TriggerServerEvent('crz_arsenal:logs',"Lanterna")
	end
end)
RegisterNUICallback('Leite', function()
	local ped = PlayerPedId()
	RemoveAllPedWeapons(ped,true)
end)
RegisterNUICallback('Dourado', function() -- OK: GLOCK
	local ped = PlayerPedId()
		SetPedAmmo(ped,GetHashKey("WEAPON_COMBATPISTOL"),0)
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_COMBATPISTOL"))
		-- GiveWeaponToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),200,0,1)
		vRP.giveWeapons({["WEAPON_COMBATPISTOL"] = { ammo = 200 }})
		if dp == "PCESP" then
			TriggerServerEvent('crz_arsenal:logspcesp',"Glock")
		elseif dp == nil then
			TriggerServerEvent('crz_arsenal:logs',"Glock")
		end
end)
RegisterNUICallback('Taco', function() -- OK: M4A1
	local ped = PlayerPedId()
		SetPedAmmo(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),0)
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"))
		-- GiveWeaponToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),200,0,1)
		vRP.giveWeapons({["WEAPON_CARBINERIFLE_MK2"] = { ammo = 200 }})
		if dp == "PCESP" then
			TriggerServerEvent('crz_arsenal:logspcesp',"M4A1")
		elseif dp == nil then
			TriggerServerEvent('crz_arsenal:logs',"M4A1")
		end
end)
RegisterNUICallback('Donut', function() -- OK: SIG-SAUER
	local ped = PlayerPedId()
		SetPedAmmo(ped,GetHashKey("WEAPON_COMBATPDW"),0)
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_COMBATPDW"))
		-- GiveWeaponToPed(ped,GetHashKey("WEAPON_COMBATPDW"),200,0,1)
		vRP.giveWeapons({["WEAPON_COMBATPDW"] = { ammo = 200 }})
		if dp == "PCESP" then
			TriggerServerEvent('crz_arsenal:logspcesp',"Sigsauer")
		elseif dp == nil then
			TriggerServerEvent('crz_arsenal:logs',"Sigsauer")
		end
end)
-- RegisterNUICallback('DonutX', function()
-- 	local ped = PlayerPedId()
-- 		SetPedAmmo(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),0)
-- 		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"))
-- 		GiveWeaponToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),30,0,1)
-- end)
RegisterNUICallback('Hamburguer', function() -- OK: AR-15
	local ped = PlayerPedId()
		SetPedAmmo(ped,GetHashKey("WEAPON_CARBINERIFLE"),0)
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_CARBINERIFLE"))
		-- GiveWeaponToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),200,0,1)
		vRP.giveWeapons({["WEAPON_CARBINERIFLE"] = { ammo = 200 }})
		if dp == "PCESP" then
			TriggerServerEvent('crz_arsenal:logspcesp',"AR-15")
		elseif dp == nil then
			TriggerServerEvent('crz_arsenal:logs',"AR-15")
	end
end)
-- RegisterNUICallback('HotDog', function()
-- 	local ped = PlayerPedId()
-- 	SetPedAmmo(ped,GetHashKey("WEAPON_SPECIALCARBINE"),0)
-- 		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"))
-- 		GiveWeaponToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),200,0,1)
-- end)
RegisterNUICallback('Salmao', function()
	local ped = PlayerPedId()
	RemoveAllPedWeapons(ped,true)
end)