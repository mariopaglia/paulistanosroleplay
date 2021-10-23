RegisterNetEvent('raspa:usar')
AddEventHandler('raspa:usar', function()
	SetNuiFocus( true, true )
	SendNUIMessage({
		showPlayerMenu = true
	})
end)

RegisterNetEvent('raspa:showprice')
AddEventHandler('raspa:showprice', function(money)
	SetNuiFocus( true, true )
	SendNUIMessage({
		showPlayerMenu = nil,
		prize = money
	})
end)

RegisterCommand("helpnui", function(source, args, rawCommand)
	SetNuiFocus( false, false )
	SendNUIMessage({
		showPlayerMenu = false
	})
end)