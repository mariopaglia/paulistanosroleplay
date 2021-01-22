local minute = 30

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000) 
		minute = minute - 1
		if minute == 0  then
			minute = 30
			TriggerServerEvent('offred:salar464651684')
		end
	end
end)