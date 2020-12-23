-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
	    local ped = PlayerPedId()
        if GetEntityHealth(ped) <= 101 then
                SendNUIMessage({
					setDisplay = true
				})
				DisableControlAction(1, 244, true)
        else 
        if GetEntityHealth(ped) >= 101 then
                SendNUIMessage({
					setDisplay = false
				})
				DisableControlAction(1, 244, false)
            end
        end
        Citizen.Wait(500)
    end
end)