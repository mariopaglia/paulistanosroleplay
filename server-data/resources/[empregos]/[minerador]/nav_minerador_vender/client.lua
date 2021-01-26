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
	if data == "bronze" then
		TriggerServerEvent("minerador-vender","bronze")
	elseif data == "ferro" then
		TriggerServerEvent("minerador-vender","ferro")
	elseif data == "ouro" then
		TriggerServerEvent("minerador-vender","ouro")
	elseif data == "rubi" then
		TriggerServerEvent("minerador-vender","rubi")
	elseif data == "esmeralda" then
		TriggerServerEvent("minerador-vender","esmeralda")
	elseif data == "safira" then
		TriggerServerEvent("minerador-vender","safira")
	elseif data == "diamante" then
		TriggerServerEvent("minerador-vender","diamante")
	elseif data == "topazio" then
		TriggerServerEvent("minerador-vender","topazio")
	elseif data == "ametista" then
		TriggerServerEvent("minerador-vender","ametista")


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
		Citizen.Wait(5)
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),-622.34,-229.81,38.05,true)
		if distance <= 3 then
			DrawMarker(21,-622.34,-229.81,38.05-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,230,100,100,0,0,0,1)
			if distance <= 1.2 then
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
				end
			end
		end
	end
end)