permissao = false
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

inMenu = true
local Menu = true
local player = PlayerPedId()

local arsenal = {
	--{ 452.18,-980.18,30.69 }, -- Policia Praça
	--{ 621.42,-18.76,82.78 }, -- Policia Vinewood
	--{ 452.38,-980.32,30.69 }, -- Policia Vinewood
	{ -580.2,-109.89,33.89 }, -- Policia Vinewood
	--{ -580.35,-110.17,33.89 }, -- Policia nova
	-- { 2525.65,-342.43,101.9 }, -- DIC
}

if Menu then
	Citizen.CreateThread(function()
	while true do
		local idle = 1000
		for _,lugares in pairs(arsenal) do
			local x,y,z = table.unpack(lugares)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),x,y,z,true)
			
			if distance <= 3 then
				DrawMarker(27,x,y+0,z-0.97,0,0,0,0,0,0,0.7,0.7,0.5,214,29,0,100,0,0,0,0)
				--DrawMarker(23,x,y+0.33,z-0.90,0,0,0,0,180.0,130.0,2.0,2.0,1.0,25,25,122,50,0,0,0,0)
				DrawText3Ds(x,y,z+0.10,"~r~[E] ~w~Para Acessar o ~r~arsenal")
				idle = 5
			end
		end
	Citizen.Wait(idle)
	end

	end)
end

RegisterKeyMapping('vrp_arsenal:open_fenix', 'Arsenal', 'keyboard', 'E')

RegisterCommand('vrp_arsenal:open_fenix', function()
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
	permissao = true
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
RegisterNUICallback('Agua', function()
	local ped = PlayerPedId()
	-- GiveWeaponToPed(ped,GetHashKey("WEAPON_STUNGUN"),0,0,0)
	if(not permissao) then TriggerServerEvent("TOMA") return end
	vRP.giveWeapons635168747({["GADGET_PARACHUTE"] = { ammo = 0 }})
	if dp == "PCESP" then
		TriggerServerEvent('crz_arsenal:logspcesp',"Paraquedas")
	elseif dp == nil then
		TriggerServerEvent('crz_arsenal:logs',"Paraquedas")
	end
end)
RegisterNUICallback('Cerveja', function()
	local ped = PlayerPedId()
	-- GiveWeaponToPed(ped,GetHashKey("WEAPON_STUNGUN"),0,0,0)
	if(not permissao) then TriggerServerEvent("TOMA") return end
	vRP.giveWeapons635168747({["WEAPON_STUNGUN"] = { ammo = 0 }})
	if dp == "PCESP" then
		TriggerServerEvent('crz_arsenal:logspcesp',"Taser")
	elseif dp == nil then
		TriggerServerEvent('crz_arsenal:logs',"Taser")
	end
end)
RegisterNUICallback('Vodka', function()
	local ped = PlayerPedId()
	-- GiveWeaponToPed(ped,GetHashKey("WEAPON_NIGHTSTICK"),0,0,0)
	if(not permissao) then TriggerServerEvent("TOMA") return end
	vRP.giveWeapons635168747({["WEAPON_NIGHTSTICK"] = { ammo = 0 }})
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
	if(not permissao) then TriggerServerEvent("TOMA") return end
	vRP.giveWeapons635168747({["WEAPON_KNIFE"] = { ammo = 0 }})
	if dp == "PCESP" then
		TriggerServerEvent('crz_arsenal:logspcesp',"Faca")
	elseif dp == nil then
		TriggerServerEvent('crz_arsenal:logs',"Faca")
	end
end)
RegisterNUICallback('Tequila', function()
	local ped = PlayerPedId()
	-- GiveWeaponToPed(ped,GetHashKey("WEAPON_FLASHLIGHT"),0,0,0)
	if(not permissao) then TriggerServerEvent("TOMA") return end
	vRP.giveWeapons635168747({["WEAPON_FLASHLIGHT"] = { ammo = 0 }})
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
		if(not permissao) then TriggerServerEvent("TOMA") return end
		vRP.giveWeapons635168747({["WEAPON_COMBATPISTOL"] = { ammo = 120 }})
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
		if(not permissao) then TriggerServerEvent("TOMA") return end
		vRP.giveWeapons635168747({["WEAPON_CARBINERIFLE_MK2"] = { ammo = 250 }})
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
		if(not permissao) then TriggerServerEvent("TOMA") return end
		vRP.giveWeapons635168747({["WEAPON_COMBATPDW"] = { ammo = 250 }})
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
RegisterNUICallback('DonutX', function() -- OK: G36x
	local ped = PlayerPedId()
		SetPedAmmo(ped,GetHashKey("WEAPON_SPECIALCARBINE"),0)
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"))
		-- GiveWeaponToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),200,0,1)
		if(not permissao) then TriggerServerEvent("TOMA") return end
		vRP.giveWeapons635168747({["WEAPON_SPECIALCARBINE"] = { ammo = 250 }})
		if dp == "PCESP" then
			TriggerServerEvent('crz_arsenal:logspcesp',"G36x")
		elseif dp == nil then
			TriggerServerEvent('crz_arsenal:logs',"G36x")
	end
end)
RegisterNUICallback('Hamburguer', function() -- OK: AR-15
	local ped = PlayerPedId()
		SetPedAmmo(ped,GetHashKey("WEAPON_CARBINERIFLE"),0)
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_CARBINERIFLE"))
		-- GiveWeaponToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),200,0,1)
		if(not permissao) then TriggerServerEvent("TOMA") return end
		vRP.giveWeapons635168747({["WEAPON_CARBINERIFLE"] = { ammo = 250 }})
		if dp == "PCESP" then
			TriggerServerEvent('crz_arsenal:logspcesp',"AR-15")
		elseif dp == nil then
			TriggerServerEvent('crz_arsenal:logs',"AR-15")
	end
end)
RegisterNUICallback('HotDog', function() -- OK: AR-15
	local ped = PlayerPedId()
		SetPedAmmo(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),0)
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"))
		-- GiveWeaponToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),200,0,1)
		if(not permissao) then TriggerServerEvent("TOMA") return end
		vRP.giveWeapons635168747({["WEAPON_PUMPSHOTGUN_MK2"] = { ammo = 80 }})
		if dp == "PCESP" then
			TriggerServerEvent('crz_arsenal:logspcesp',"Remington 870")
		elseif dp == nil then
			TriggerServerEvent('crz_arsenal:logs',"Remington 870")
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
    DrawRect(_x,_y+0.0125, 0.001+ factor, 0.028, 0, 0, 0, 78)
end