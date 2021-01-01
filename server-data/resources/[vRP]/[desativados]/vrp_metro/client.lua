local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false

function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("ButtonClick",function(data,cb)
	local ped = PlayerPedId()
	if data == "praca" then
		ToggleActionMenu()
		DoScreenFadeOut(1000)
		TriggerEvent("Notify","sucesso","Você está viajando... aguarde o trem chegar no local.")
		Citizen.Wait(1000)
		TriggerEvent("vrp_sound:source",'train',0.4)
		SetEntityVisible(ped,false,false)
		Citizen.Wait(65000)
		DoScreenFadeIn(1000)
		vRP.teleport(-207.25,-1016.38,30.13)
		SetEntityVisible(ped,true,true)
	elseif data == "kenedy" then
		ToggleActionMenu()
		DoScreenFadeOut(1000)
		TriggerEvent("Notify","sucesso","Você está viajando... aguarde o trem chegar no local.")
		Citizen.Wait(1000)
		TriggerEvent("vrp_sound:source",'train',0.4)
		SetEntityVisible(ped,false,false)
		Citizen.Wait(65000)
		DoScreenFadeIn(1000)
		SetEntityVisible(ped,true,true)
		vRP.teleport(-1015.03,-2752.46,0.80)
	elseif data == "fechar" then
		ToggleActionMenu()
	end
	TriggerEvent("ToogleBackCharacter")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TOOGLE LOGIN
-----------------------------------------------------------------------------------------------------------------------------------------
local marcacoes = {
	{ -208.18,-1019.04,30.13 },
	{ 103.64,-1715.84,30.11 },
	{ -472.79,-709.83,20.03 },
	{ -1352.17,-507.31,23.26 },
	{ -96.64,6148.02,31.80 },
	{ 2267.44,3766.12,37.78 },
	{ -1023.98,-2755.87,0.80 },
	{ 135.81,-592.28,17.77 },
	{-844.53,-123.72,28.18}
}

local locked = false
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		for _,mark in pairs(marcacoes) do
			local x,y,z = table.unpack(mark)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
			if distance <= 25 then
			DrawMarker(21, x, y, z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
			end
			if distance <= 1.2 then
				
				if IsControlJustPressed(0,38) and not locked then
					locked = true
					ToggleActionMenu()
					SetTimeout(5000, function()
						locked = false
					end)
				end

			end
		end
	end
end)


