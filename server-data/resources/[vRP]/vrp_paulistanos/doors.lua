Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local veh = GetVehiclePedIsUsing(PlayerPedId())
		if veh and not GetVehiclePedIsIn(PlayerPedId(), false) then
			for i = 1, i < GetNumberOfVehicleDoors(veh) do
				local coord = GetEntryPositionOfDoor(veh, i);
				if (Vdist2(pco[0],pco[1],pco[2],coord[0],coord[1],coord[2]) < 0.75 and not DoesEntityExist(GetPedInVehicleSeat(veh,i-1)) and GetVehicleDoorLockStatus(veh) ~= 2) then
					if (IsControlJustPressed(1,23)) then
						TaskEnterVehicle(ped,veh,10000,i-1,1.0,1,0);
					end
				end
			end
		end
	end
end)