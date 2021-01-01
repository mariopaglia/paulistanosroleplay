local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("nav_mafia")
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
	if data == "armamentos-comprar-fiveseven" then
		TriggerServerEvent("mafia-comprar","wbody|WEAPON_PISTOL_MK2")
	elseif data == "armamentos-comprar-uzi" then
		TriggerServerEvent("mafia-comprar","wbody|WEAPON_MICROSMG")
	elseif data == "armamentos-comprar-mtar21" then
		TriggerServerEvent("mafia-comprar","wbody|WEAPON_ASSAULTSMG")
	elseif data == "armamentos-comprar-ak103" then
		TriggerServerEvent("mafia-comprar","wbody|WEAPON_ASSAULTRIFLE")
	elseif data == "armamentos-comprar-magnum44" then
		TriggerServerEvent("mafia-comprar","wbody|WEAPON_REVOLVER")
	elseif data == "armamentos-comprar-thompson" then
		TriggerServerEvent("mafia-comprar","wbody|WEAPON_GUSENBERG")

	elseif data == "armamentos-vender-fiveseven" then
		TriggerServerEvent("mafia-vender","wbody|WEAPON_PISTOL_MK2")
	elseif data == "armamentos-vender-uzi" then
		TriggerServerEvent("mafia-vender","wbody|WEAPON_MICROSMG")
	elseif data == "armamentos-vender-mtar21" then
		TriggerServerEvent("mafia-vender","wbody|WEAPON_ASSAULTSMG")
	elseif data == "armamentos-vender-ak103" then
		TriggerServerEvent("mafia-vender","wbody|WEAPON_ASSAULTRIFLE")
	elseif data == "armamentos-vender-magnum44" then
		TriggerServerEvent("mafia-vender","wbody|WEAPON_REVOLVER")
	elseif data == "armamentos-vender-thompson" then
		TriggerServerEvent("mafia-vender","wbody|WEAPON_GUSENBERG")

    elseif data == "municoes-comprar-mtar21" then
		TriggerServerEvent("mafia-comprar","wammo|WEAPON_ASSAULTSMG")
	elseif data == "municoes-comprar-fiveseven" then
		TriggerServerEvent("mafia-comprar","wammo|WEAPON_PISTOL_MK2")
	elseif data == "municoes-comprar-uzi" then
		TriggerServerEvent("mafia-comprar","wammo|WEAPON_MICROSMG")
	elseif data == "municoes-comprar-ak103" then
		TriggerServerEvent("mafia-comprar","wammo|WEAPON_ASSAULTRIFLE")	
	elseif data == "municoes-comprar-magnum44" then
		TriggerServerEvent("mafia-comprar","wammo|WEAPON_REVOLVER")
	elseif data == "municoes-comprar-thompson" then
		TriggerServerEvent("mafia-comprar","wammo|WEAPON_GUSENBERG")
     
	 elseif data == "municoes-vender-mtar21" then
		TriggerServerEvent("mafia-vender","wammo|WEAPON_ASSAULTSMG")
	elseif data == "municoes-vender-fiveseven" then
		TriggerServerEvent("mafia-vender","wammo|WEAPON_PISTOL_MK2")
	elseif data == "municoes-vender-uzi" then
		TriggerServerEvent("mafia-vender","wammo|WEAPON_MICROSMG")
	elseif data == "municoes-vender-ak103" then
		TriggerServerEvent("mafia-vender","wammo|WEAPON_ASSAULTRIFLE")
	elseif data == "municoes-vender-magnum44" then
		TriggerServerEvent("mafia-vender","wammo|WEAPON_REVOLVER")
	elseif data == "municoes-vender-thompson" then
		TriggerServerEvent("mafia-vender","wammo|WEAPON_GUSENBERG")

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),-2679.6013183594,1332.8948974609,140.8816986084,true)
		if distance <= 30 then
			DrawMarker(21,-2679.6013183594,1332.8948974609,141.8816986084-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,50,1,1,0,0)
			if distance <= 1.1 then
				if IsControlJustPressed(0,38) and emP.checkPermission1() then
					ToggleActionMenu()
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),896.09741210938,-2115.1293945313,30.763412475586,true)
		if distance <= 30 then
			DrawMarker(21,896.09741210938,-2115.1293945313,31.763412475586-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,50,1,1,0,0)
			if distance <= 1.1 then
				if IsControlJustPressed(0,38) and emP.checkPermission2() then
					ToggleActionMenu()
				end
			end
		end
	end
end)