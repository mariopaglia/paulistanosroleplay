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
	if data == "utilidades-comprar-nitro" then
		TriggerServerEvent("mecanicos-comprar","nitro")
	elseif data == "utilidades-vender-nitro" then
		TriggerServerEvent("mecanicos-vender","nitro")
	elseif data == "utilidades-comprar-reparo" then
		TriggerServerEvent("mecanicos-comprar","repairkit")
	elseif data == "utilidades-vender-nitro" then
		TriggerServerEvent("mecanicos-reparo","repairkit")


	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local marcacoes = {
	{ 953.53387451172,-976.97546386719,39.753002166748 }
}

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		for _,mark in pairs(marcacoes) do
			local x,y,z = table.unpack(mark)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),953.53387451172,-976.97546386719,39.75,true)
			if distance <= 1.2 then
			DrawMarker(20,953.53387451172,-976.97546386719,40.753002166748-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,50,1,1,0,0)
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
				end
			end
		end
	end
end)