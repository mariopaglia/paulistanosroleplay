local SeatsTaken = {}

RegisterServerEvent('SitScript:TakeChair')
AddEventHandler('SitScript:TakeChair', function(object)
	table.insert(SeatsTaken, object)
end)

RegisterServerEvent('SitScript:LeaveChair')
AddEventHandler('SitScript:LeaveChair', function(object)
	local _SeatsTaken = {}
	for i=1, #SeatsTaken, 1 do
		if object ~= SeatsTaken[i] then
			table.insert(_SeatsTaken, SeatsTaken[i])
		end
	end

	SeatsTaken = _SeatsTaken
end)

RegisterServerEvent('SitScript:CheckChair')
AddEventHandler('SitScript:CheckChair', function(id)
    local found = false
	for i=1, #SeatsTaken, 1 do
		if SeatsTaken[i] == id then
			found = true
		end
    end

    TriggerClientEvent('SitScript:GetChair', source, found)
end)