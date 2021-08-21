local menuEnabled = false
function ToggleActionMenu()
	menuEnabled = not menuEnabled
	if menuEnabled then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false,false)
		SendNUIMessage({ hidemenu = true })
	end
end

RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "exit" then
		ToggleActionMenu()
	end
end)



RegisterKeyMapping('vrp_tablet:open', 'Tablet', 'keyboard', 'F9')

RegisterCommand('vrp_tablet:open', function()
	ToggleActionMenu()
end, false)