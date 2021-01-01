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
	if data == "celular" then
		TriggerServerEvent("comprar-nav","celular")
	elseif data == "mochila" then
		TriggerServerEvent("comprar-nav","radio")
	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local marcacoes = {
	{ 392.92,-831.87,29.29 },
	{ 1137.80,-470.92,66.65 },
	{ -1523.22,-408.09,35.59 },
	{ -850.62,-132.39,28.18 }
}


Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		for _,mark in pairs(marcacoes) do
			local x,y,z = table.unpack(mark)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
			if distance <= 1.2 then
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
				end
			end
			if distance <= 10.0 then
				DrawMarker(21, x, y, z-0.77, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 0, 255, 15, 255, 0, 0, 0, 1)
			end
		end
	end
end)