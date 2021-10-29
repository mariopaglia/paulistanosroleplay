-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(1) 
		
--         for ped in EnumeratePeds() do
--             if DoesEntityExist(ped) then
-- 				for i,model in pairs(cfg.peds) do
-- 					if (GetEntityModel(ped) == GetHashKey(model)) then
-- 						veh = GetVehiclePedIsIn(ped, false)
-- 						SetEntityAsNoLongerNeeded(ped)
-- 						SetEntityCoords(ped,10000,10000,10000,1,0,0,1)
-- 						if veh ~= nil then
-- 							SetEntityAsNoLongerNeeded(veh)
-- 							SetEntityCoords(veh,10000,10000,10000,1,0,0,1)
-- 						end
-- 					end
-- 				end
-- 				for i,model in pairs(cfg.noguns) do
-- 					if (GetEntityModel(ped) == GetHashKey(model)) then
-- 						RemoveAllPedWeapons(ped, true)
-- 					end
-- 				end
-- 				for i,model in pairs(cfg.nodrops) do
-- 					if (GetEntityModel(ped) == GetHashKey(model)) then
-- 						SetPedDropsWeaponsWhenDead(ped,false) 
-- 					end
-- 				end
-- 			end
-- 		end
-- 		--[[ WORK IN PROGESS // DOES NOT WORK
--         for veh in EnumerateVehicles() do
--             if DoesEntityExist(veh) then
-- 				for i,model in pairs(cfg.vehs) do
-- 					if (GetEntityModel(veh) == GetHashKey(model)) then
-- 						SetEntityAsNoLongerNeeded(veh)
-- 						SetEntityCoords(veh,10000,10000,10000,1,0,0,1)
-- 					end
-- 				end
-- 			end
-- 		end
-- 		]]
--     end
-- end)

-- FAZER OS NPCS PARAREM DE ATACAR
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        SetEveryoneIgnorePlayer(PlayerId(), true)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVER PEDS DE UMA DETERMINADA REGIÃO
-----------------------------------------------------------------------------------------------------------------------------------------
local area = {
    { x=548.14, y=-3191.73, z=6.07, radius = 150.0}, -- Base da Irmandade
}
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        for k,v in pairs(area) do
            ClearAreaOfPeds(v.x,v.y,v.z,v.radius,1)
        end
    end
end)

Citizen.CreateThread(function()
    while true 
        do
         -- These natives has to be called every frame.
        SetPedDensityMultiplierThisFrame(cfg.density.peds)
        SetScenarioPedDensityMultiplierThisFrame(cfg.density.peds, cfg.density.peds)
        SetVehicleDensityMultiplierThisFrame(cfg.density.vehicles)
        SetRandomVehicleDensityMultiplierThisFrame(0.3)
        SetParkedVehicleDensityMultiplierThisFrame(0.0)
        Citizen.Wait(0)
    end
end)
