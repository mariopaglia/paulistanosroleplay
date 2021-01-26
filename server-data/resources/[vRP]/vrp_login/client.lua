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
	if data == "garagem01" then
		vRP.teleport(56.75,-879.64,30.36)
	elseif data == "garagem02" then
		vRP.teleport(318.82,2622.06,44.47)
	elseif data == "garagem03" then
		vRP.teleport(-772.81,5596.25,33.48)
	elseif data == "hospital01" then
		vRP.teleport(299.89,-575.0,43.27)
	elseif data == "metro" then
		vRP.teleport(-845.76373291016,-131.1110534668,37.520294189453)
	elseif data == "aeroporto" then
		vRP.teleport(-1036.45,-2737.80,13.77)
	elseif data == "concessionaria" then
		vRP.teleport(-53.44,-1109.53,26.44)
	end
	ToggleActionMenu()
	TriggerEvent("ToogleBackCharacter")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOOGLE LOGIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('vrp:ToogleLoginMenu')
AddEventHandler('vrp:ToogleLoginMenu',function()
	ToggleActionMenu()
end)