-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDS
-------------------------------------------------
Citizen.CreateThread(function()
	AddTextEntry("FE_THDR_GTAO","Paulistanos Roleplay")
	while true do
		Citizen.Wait(4)
		N_0xf4f2c0d4ee209e20()
		HideHudComponentThisFrame(1)
		HideHudComponentThisFrame(2)
		HideHudComponentThisFrame(3)
		HideHudComponentThisFrame(4)
		HideHudComponentThisFrame(5)
		HideHudComponentThisFrame(6)
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(8)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(11)
		HideHudComponentThisFrame(12)
		HideHudComponentThisFrame(13)
		HideHudComponentThisFrame(15)
		HideHudComponentThisFrame(17)
		HideHudComponentThisFrame(18)
		HideHudComponentThisFrame(20)
		HideHudComponentThisFrame(21)
		HideHudComponentThisFrame(22)
		RemoveAllPickupsOfType(0x6C5B941A)
		RemoveAllPickupsOfType(0xF33C83B0)
		RemoveAllPickupsOfType(0xDF711959)
		RemoveAllPickupsOfType(0xB2B5325E)
		RemoveAllPickupsOfType(0x85CAA9B1)
		RemoveAllPickupsOfType(0xB2930A14)
		RemoveAllPickupsOfType(0xFE2A352C)
		RemoveAllPickupsOfType(0x693583AD)
		RemoveAllPickupsOfType(0x1D9588D3)
		RemoveAllPickupsOfType(0x3A4C2AD2)
		RemoveAllPickupsOfType(0x4D36C349)
		RemoveAllPickupsOfType(0x2F36B434)
		RemoveAllPickupsOfType(0xA9355DCD)
		RemoveAllPickupsOfType(0x96B412A3)
		RemoveAllPickupsOfType(0x9299C95B)
		RemoveAllPickupsOfType(0xF9AFB48F)
		RemoveAllPickupsOfType(0x8967B4F3)
		RemoveAllPickupsOfType(0x3B662889)
		RemoveAllPickupsOfType(0xFD16169E)
		RemoveAllPickupsOfType(0xCB13D282)
		RemoveAllPickupsOfType(0xC69DE3FF)
		RemoveAllPickupsOfType(0x278D8734)
		RemoveAllPickupsOfType(0x5EA16D74)
		RemoveAllPickupsOfType(0x295691A9)
		RemoveAllPickupsOfType(0x81EE601E)
		RemoveAllPickupsOfType(0x88EAACA7)
		RemoveAllPickupsOfType(0x872DC888)
		RemoveAllPickupsOfType(0xC5B72713)
		RemoveAllPickupsOfType(0x9CF13918)
		RemoveAllPickupsOfType(0x0968339D)
		RemoveAllPickupsOfType(0xBFEE6C3B)
		RemoveAllPickupsOfType(0xBED46EC5)
		RemoveAllPickupsOfType(0x079284A9)
		RemoveAllPickupsOfType(0x8ADDEC75)
		DisablePlayerVehicleRewards(PlayerId())
		local r, wh = GetCurrentPedWeapon(PlayerPedId(),1)
		if r and wh == GetHashKey("WEAPON_FIREEXTINGUISHER") then
			SetPedInfiniteAmmo(PlayerPedId(),true,GetHashKey("WEAPON_FIREEXTINGUISHER"))
		end
		
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		SetVehicleDensityMultiplierThisFrame(0.0) -- set traffic density to 0 
		SetPedDensityMultiplierThisFrame(0.0) -- set npc/ai peds density to 0
		SetRandomVehicleDensityMultiplierThisFrame(0.0) -- set random vehicles (car scenarios / cars driving off from a parking spot etc.) to 0
		SetParkedVehicleDensityMultiplierThisFrame(0.0) -- set random parked vehicles (parked car scenarios) to 0
		SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0) -- set random npc/ai peds or scenario peds to 0
		SetGarbageTrucks(false) -- Stop garbage trucks from randomly spawning
		SetRandomBoats(false) -- Stop random boats from spawning in the water.
		SetCreateRandomCops(false) -- disable random cops walking/driving around.
		SetCreateRandomCopsNotOnScenarios(false) -- stop random cops (not in a scenario) from spawning.
		SetCreateRandomCopsOnScenarios(false) -- stop random cops (in a scenario) from spawning.
		
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
		RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);
	end
end)