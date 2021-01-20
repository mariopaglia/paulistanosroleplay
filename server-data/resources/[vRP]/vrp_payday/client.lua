local minute = 5

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000) 
		minute = minute - 1
		if minute == 0  then
			minute = 5
			TriggerServerEvent('offred:salar464651684')
		end
	end
end)