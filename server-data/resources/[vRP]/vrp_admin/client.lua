local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

vADMC = {}
Tunnel.bindInterface("vrp_admin", vADMC)
crz = Tunnel.getInterface("vrp_admin")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ECONOMIA
-----------------------------------------------------------------------------------------------------------------------------------------
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(1000)
-- 		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
-- 		if x == px and y == py then
-- 			if tempo > 0 then
-- 				tempo = tempo - 1
-- 			else
-- 				TriggerServerEvent("Economia")
-- 				tempo = 3600
-- 			end
-- 		else
-- 			tempo = 3600
-- 		end
-- 		px = x
-- 		py = y
-- 	end
-- end)
-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(30000)
--         TriggerEvent('Economia')
--     end
-- end)

-- RegisterNetEvent("Economia")
-- AddEventHandler("SyncDoorsEveryone",function()

-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Blips
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
local showblips = false
RegisterNetEvent("blips:updateBlips")
AddEventHandler("blips:updateBlips", function(update)
    blips = update
end)
RegisterNetEvent("blips:adminStart")
AddEventHandler("blips:adminStart", function()
    showblips = true
end)

Citizen.CreateThread(function()
    while true do
        if showblips then
            for k, v in pairs(blips) do
                local id = GetPlayerFromServerId(v[1])
                local ped = GetPlayerPed(id)
                if GetBlipFromEntity(ped) == 0 then
                    local blip = AddBlipForEntity(ped)
                    SetBlipSprite(blip, 1)
                    SetBlipColour(blip, 24)
                    SetBlipAsShortRange(blip, true)
                    SetBlipScale(blip, 0.3)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("Conectados")
                    EndTextCommandSetBlipName(blip)
                end
            end
        end
        Citizen.Wait(100)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMPURRAR CARRO COM "M"
-----------------------------------------------------------------------------------------------------------------------------------------
local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
        enum.destructor = nil
        enum.handle = nil
    end,
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end

        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, entityEnumerator)

        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next

        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function GetVeh()
    local vehicles = {}
    for vehicle in EnumerateVehicles() do
        table.insert(vehicles, vehicle)
    end
    return vehicles
end

function GetClosestVeh(coords)
    local vehicles = GetVeh()
    local closestDistance = -1
    local closestVehicle = -1
    local coords = coords

    if coords == nil then
        local ped = PlayerPedId()
        coords = GetEntityCoords(ped)
    end

    for i = 1, #vehicles, 1 do
        local vehicleCoords = GetEntityCoords(vehicles[i])
        local distance = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)
        if closestDistance == -1 or closestDistance > distance then
            closestVehicle = vehicles[i]
            closestDistance = distance
        end
    end
    return closestVehicle, closestDistance
end

local First = vector3(0.0, 0.0, 0.0)
local Second = vector3(5.0, 5.0, 5.0)
local Vehicle = {Coords = nil, Vehicle = nil, Dimension = nil, IsInFront = false, Distance = nil}

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local closestVehicle, Distance = GetClosestVeh()
        if Distance < 6.1 and not IsPedInAnyVehicle(ped) then
            Vehicle.Coords = GetEntityCoords(closestVehicle)
            Vehicle.Dimensions = GetModelDimensions(GetEntityModel(closestVehicle), First, Second)
            Vehicle.Vehicle = closestVehicle
            Vehicle.Distance = Distance
            if GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle), GetEntityCoords(ped), true) > GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle) * -1, GetEntityCoords(ped), true) then
                Vehicle.IsInFront = false
            else
                Vehicle.IsInFront = true
            end
        else
            Vehicle = {Coords = nil, Vehicle = nil, Dimensions = nil, IsInFront = false, Distance = nil}
        end
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if Vehicle.Vehicle ~= nil then
            local ped = PlayerPedId()
            if IsControlPressed(0, 244) and GetEntityHealth(ped) > 100 and IsVehicleSeatFree(Vehicle.Vehicle, -1) and not IsEntityAttachedToEntity(ped, Vehicle.Vehicle) and not (GetEntityRoll(Vehicle.Vehicle) > 75.0 or GetEntityRoll(Vehicle.Vehicle) < -75.0) then
                RequestAnimDict("missfinale_c2ig_11")
                TaskPlayAnim(ped, "missfinale_c2ig_11", "pushcar_offcliff_m", 2.0, -8.0, -1, 35, 0, 0, 0, 0)
                NetworkRequestControlOfEntity(Vehicle.Vehicle)

                if Vehicle.IsInFront then
                    AttachEntityToEntity(ped, Vehicle.Vehicle, GetPedBoneIndex(6286), 0.0, Vehicle.Dimensions.y * -1 + 0.1, Vehicle.Dimensions.z + 1.0, 0.0, 0.0, 180.0, 0.0, false, false, true, false, true)
                else
                    AttachEntityToEntity(ped, Vehicle.Vehicle, GetPedBoneIndex(6286), 0.0, Vehicle.Dimensions.y - 0.3, Vehicle.Dimensions.z + 1.0, 0.0, 0.0, 0.0, 0.0, false, false, true, false, true)
                end

                while true do
                    Citizen.Wait(5)
                    if IsDisabledControlPressed(0, 34) then
                        TaskVehicleTempAction(ped, Vehicle.Vehicle, 11, 100)
                    end

                    if IsDisabledControlPressed(0, 9) then
                        TaskVehicleTempAction(ped, Vehicle.Vehicle, 10, 100)
                    end

                    if Vehicle.IsInFront then
                        SetVehicleForwardSpeed(Vehicle.Vehicle, -1.0)
                    else
                        SetVehicleForwardSpeed(Vehicle.Vehicle, 1.0)
                    end

                    if not IsDisabledControlPressed(0, 244) then
                        DetachEntity(ped, false, false)
                        StopAnimTask(ped, "missfinale_c2ig_11", "pushcar_offcliff_m", 2.0)
                        break
                    end
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TROCAR SEXO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinmenu")
AddEventHandler("skinmenu", function(mhash)
    while not HasModelLoaded(mhash) do
        RequestModel(mhash)
        Citizen.Wait(10)
    end

    if HasModelLoaded(mhash) then
        SetPlayerModel(PlayerId(), mhash)
        SetModelAsNoLongerNeeded(mhash)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDELETEVEH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("syncdeleteveh")
AddEventHandler("syncdeleteveh", function(index)
    Citizen.CreateThread(function()
        if NetworkDoesNetworkIdExist(index) then
            SetVehicleAsNoLongerNeeded(index)
            SetEntityAsMissionEntity(index, true, true)
            local v = NetToVeh(index)
            if DoesEntityExist(v) then
                SetVehicleHasBeenOwnedByPlayer(v, false)
                PlaceObjectOnGroundProperly(v)
                SetEntityAsNoLongerNeeded(v)
                SetEntityAsMissionEntity(v, true, true)
                DeleteVehicle(v)
            end
        end
    end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDELETEPED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("syncdeleteped")
AddEventHandler("syncdeleteped", function(index)
    Citizen.CreateThread(function()
        if NetworkDoesNetworkIdExist(index) then
            SetPedAsNoLongerNeeded(index)
            SetEntityAsMissionEntity(index, true, true)
            local v = NetToPed(index)
            if DoesEntityExist(v) then
                PlaceObjectOnGroundProperly(v)
                SetEntityAsNoLongerNeeded(v)
                SetEntityAsMissionEntity(v, true, true)
                DeletePed(v)
            end
        end
    end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDELETEOBJ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("syncdeleteobj")
AddEventHandler("syncdeleteobj", function(index)
    Citizen.CreateThread(function()
        if NetworkDoesNetworkIdExist(index) then
            SetEntityAsMissionEntity(index, true, true)
            SetObjectAsNoLongerNeeded(index)
            local v = NetToObj(index)
            if DoesEntityExist(v) then
                DetachEntity(v, false, false)
                PlaceObjectOnGroundProperly(v)
                SetEntityAsNoLongerNeeded(v)
                SetEntityAsMissionEntity(v, true, true)
                DeleteObject(v)
            end
        end
    end)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("syncarea")
AddEventHandler("syncarea", function(x, y, z)
    Citizen.CreateThread(function()
        ClearAreaOfVehicles(x, y, z, 100.0, false, false, false, false, false)
        ClearAreaOfEverything(x, y, z, 100.0, false, false, false, false)
    end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterNetEvent("vehash")
-- AddEventHandler("vehash",function(vehicle)
--	TriggerEvent('chatMessage',"ALERTA",{255,70,50},GetEntityModel(vehicle))
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNAR VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('spawnarveiculo654687687')
AddEventHandler('spawnarveiculo654687687', function(name)
    local mhash = GetHashKey(name)
    while not HasModelLoaded(mhash) do
        RequestModel(mhash)
        Citizen.Wait(10)
    end

    if HasModelLoaded(mhash) then
        local ped = PlayerPedId()
        local nveh = CreateVehicle(mhash, GetEntityCoords(ped), GetEntityHeading(ped), true, false)

        SetVehicleOnGroundProperly(nveh)
        SetVehicleNumberPlateText(nveh, vRP.getRegistrationNumber())
        SetEntityAsMissionEntity(nveh, true, true)
        SetVehicleDirtLevel(nveh, 0.0)
        TaskWarpPedIntoVehicle(ped, nveh, -1)

        SetModelAsNoLongerNeeded(mhash)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORTAR PARA O LOCAL MARCADO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('tptoway')
AddEventHandler('tptoway', function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsUsing(ped)
    if IsPedInAnyVehicle(ped) then
        ped = veh
    end

    local waypointBlip = GetFirstBlipInfoId(8)
    local x, y, z = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, waypointBlip, Citizen.ResultAsVector()))

    local ground
    local groundFound = false
    local groundCheckHeights = {0.0, 50.0, 100.0, 150.0, 200.0, 250.0, 300.0, 350.0, 400.0, 450.0, 500.0, 550.0, 600.0, 650.0, 700.0, 750.0, 800.0, 850.0, 900.0, 950.0, 1000.0, 1050.0, 1100.0}

    for i, height in ipairs(groundCheckHeights) do
        SetEntityCoordsNoOffset(ped, x, y, height, 0, 0, 1)

        RequestCollisionAtCoord(x, y, z)
        while not HasCollisionLoadedAroundEntity(ped) do
            RequestCollisionAtCoord(x, y, z)
            Citizen.Wait(1)
        end
        Citizen.Wait(20)

        ground, z = GetGroundZFor_3dCoord(x, y, height)
        if ground then
            z = z + 1.0
            groundFound = true
            break
        end
    end

    if not groundFound then
        z = 1200
        GiveDelayedWeaponToPed(PlayerPedId(), 0xFBAB5776, 1, 0)
    end

    RequestCollisionAtCoord(x, y, z)
    while not HasCollisionLoadedAroundEntity(ped) do
        RequestCollisionAtCoord(x, y, z)
        Citizen.Wait(1)
    end

    SetEntityCoordsNoOffset(ped, x, y, z, 0, 0, 1)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETAR NPCS MORTOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('delnpcs')
AddEventHandler('delnpcs', function()
    local handle, ped = FindFirstPed()
    local finished = false
    repeat
        local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(ped), true)
        if IsPedDeadOrDying(ped) and not IsPedAPlayer(ped) and distance < 3 then
            TriggerServerEvent("trydeleteped", PedToNet(ped))
            finished = true
        end
        finished, ped = FindNextPed(handle)
    until not finished
    EndFindPed(handle)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COORDENADAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("h1", function(source, args)
    h = GetEntityHeading(PlayerPedId())
    vRP.prompt("Heading", rCDS(h))
end)

RegisterCommand("h2", function(source, args)
    h = GetEntityHeading(PlayerPedId())
    vRP.prompt("Heading", "['h'] = " .. rCDS(h))
end)

RegisterCommand("cds", function(source, args)
    local ped = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(ped))
    vRP.prompt("Cordenadas:", "['x'] = " .. rCDS(x) .. ", ['y'] = " .. rCDS(y) .. ", ['z'] = " .. rCDS(z))
end)

RegisterCommand("cds2", function(source, args)
    local ped = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(ped))
    vRP.prompt("Cordenadas:", rCDS(x) .. "," .. rCDS(y) .. "," .. rCDS(z))
end)

RegisterCommand("cds3", function(source, args)
    local ped = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(ped))
    vRP.prompt("Cordenadas:", "{x=" .. rCDS(x) .. ", y=" .. rCDS(y) .. ", z=" .. rCDS(z) .. "},")
end)

RegisterCommand("cds4", function(source, args)
    local ped = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local h = GetEntityHeading(PlayerPedId())
    vRP.prompt("Cordenadas:", "['x'] = " .. rCDS(x) .. ", ['y'] = " .. rCDS(y) .. ", ['z'] = " .. rCDS(z) .. ", ['h'] = " .. rCDS(h))
end)

function rCDS(n)
    n = math.ceil(n * 100) / 100
    return n
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vehtuning")
AddEventHandler("vehtuning", function(vehicle)
    local ped = PlayerPedId()
    if IsEntityAVehicle(vehicle) then
        SetVehicleModKit(vehicle, 0)
        -- SetVehicleWheelType(vehicle,7)
        SetVehicleMod(vehicle, 0, GetNumVehicleMods(vehicle, 0) - 1, false)
        SetVehicleMod(vehicle, 1, GetNumVehicleMods(vehicle, 1) - 1, false)
        SetVehicleMod(vehicle, 2, GetNumVehicleMods(vehicle, 2) - 1, false)
        SetVehicleMod(vehicle, 3, GetNumVehicleMods(vehicle, 3) - 1, false)
        SetVehicleMod(vehicle, 4, GetNumVehicleMods(vehicle, 4) - 1, false)
        SetVehicleMod(vehicle, 5, GetNumVehicleMods(vehicle, 5) - 1, false)
        SetVehicleMod(vehicle, 6, GetNumVehicleMods(vehicle, 6) - 1, false)
        SetVehicleMod(vehicle, 7, GetNumVehicleMods(vehicle, 7) - 1, false)
        SetVehicleMod(vehicle, 8, GetNumVehicleMods(vehicle, 8) - 1, false)
        SetVehicleMod(vehicle, 9, GetNumVehicleMods(vehicle, 9) - 1, false)
        SetVehicleMod(vehicle, 10, GetNumVehicleMods(vehicle, 10) - 1, false)
        SetVehicleMod(vehicle, 11, GetNumVehicleMods(vehicle, 11) - 1, false)
        SetVehicleMod(vehicle, 12, GetNumVehicleMods(vehicle, 12) - 1, false)
        SetVehicleMod(vehicle, 13, GetNumVehicleMods(vehicle, 13) - 1, false)
        SetVehicleMod(vehicle, 14, 16, false)
        SetVehicleMod(vehicle, 15, GetNumVehicleMods(vehicle, 15) - 2, false)
        SetVehicleMod(vehicle, 16, GetNumVehicleMods(vehicle, 16) - 1, false)
        ToggleVehicleMod(vehicle, 17, true)
        ToggleVehicleMod(vehicle, 18, true)
        ToggleVehicleMod(vehicle, 19, true)
        ToggleVehicleMod(vehicle, 20, true)
        ToggleVehicleMod(vehicle, 21, true)
        ToggleVehicleMod(vehicle, 22, true)
        SetVehicleMod(vehicle, 23, 1, false)
        SetVehicleMod(vehicle, 24, 1, false)
        SetVehicleMod(vehicle, 25, GetNumVehicleMods(vehicle, 25) - 1, false)
        SetVehicleMod(vehicle, 27, GetNumVehicleMods(vehicle, 27) - 1, false)
        SetVehicleMod(vehicle, 28, GetNumVehicleMods(vehicle, 28) - 1, false)
        SetVehicleMod(vehicle, 30, GetNumVehicleMods(vehicle, 30) - 1, false)
        SetVehicleMod(vehicle, 33, GetNumVehicleMods(vehicle, 33) - 1, false)
        SetVehicleMod(vehicle, 34, GetNumVehicleMods(vehicle, 34) - 1, false)
        SetVehicleMod(vehicle, 35, GetNumVehicleMods(vehicle, 35) - 1, false)
        SetVehicleMod(vehicle, 38, GetNumVehicleMods(vehicle, 38) - 1, true)
        -- SetVehicleTyreSmokeColor(vehicle,0,0,127)
        SetVehicleWindowTint(vehicle, 1)
        SetVehicleTyresCanBurst(vehicle, false)
        SetVehicleNumberPlateText(vehicle, "STAFFMOD")
        SetVehicleNumberPlateTextIndex(vehicle, 1)
        -- SetVehicleModColor_1(vehicle,3,0,0)
        -- SetVehicleModColor_2(vehicle,0,0)
        -- SetVehicleColours(vehicle,0,0)
        -- SetVehicleExtraColours(vehicle,0,0)
    end
end)
------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
------------------------------------------------------------------------------------------------------------------------------
local dickheaddebug = false

local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118,
}

RegisterNetEvent("ToggleDebug")
AddEventHandler("ToggleDebug", function()
    dickheaddebug = not dickheaddebug
    if dickheaddebug then
        TriggerEvent('chatMessage', "DEBUG", {255, 70, 50}, "ON")
    else
        TriggerEvent('chatMessage', "DEBUG", {255, 70, 50}, "OFF")
    end
end)

local inFreeze = false

function GetVehicle()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstVehicle()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if canPedBeUsed(ped) and distance < 30.0 and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped
            -- FreezeEntityPosition(ped, inFreeze)
            if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
                DrawText3Ds(pos["x"], pos["y"], pos["z"] + 1, "Veh: " .. ped .. " Model: " .. GetEntityModel(ped) .. " IN CONTACT")
            else
                DrawText3Ds(pos["x"], pos["y"], pos["z"] + 1, "Veh: " .. ped .. " Model: " .. GetEntityModel(ped) .. "")
            end
        end
        success, ped = FindNextVehicle(handle)
    until not success
    EndFindVehicle(handle)
    return rped
end

function GetObject()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstObject()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if distance < 10.0 then
            distanceFrom = distance
            rped = ped
            -- FreezeEntityPosition(ped, inFreeze)
            if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
                DrawText3Ds(pos["x"], pos["y"], pos["z"] + 1, "Obj: " .. ped .. " Model: " .. GetEntityModel(ped) .. " IN CONTACT")
            else
                DrawText3Ds(pos["x"], pos["y"], pos["z"] + 1, "Obj: " .. ped .. " Model: " .. GetEntityModel(ped) .. "")
            end
        end
        success, ped = FindNextObject(handle)
    until not success
    EndFindObject(handle)
    return rped
end

function getNPC()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if canPedBeUsed(ped) and distance < 30.0 and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped

            if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
                DrawText3Ds(pos["x"], pos["y"], pos["z"], "Ped: " .. ped .. " Model: " .. GetEntityModel(ped) .. " Relationship HASH: " .. GetPedRelationshipGroupHash(ped) .. " IN CONTACT")
            else
                DrawText3Ds(pos["x"], pos["y"], pos["z"], "Ped: " .. ped .. " Model: " .. GetEntityModel(ped) .. " Relationship HASH: " .. GetPedRelationshipGroupHash(ped))
            end

            FreezeEntityPosition(ped, inFreeze)
        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return rped
end

function canPedBeUsed(ped)
    if ped == nil then
        return false
    end
    if ped == GetPlayerPed(-1) then
        return false
    end
    if not DoesEntityExist(ped) then
        return false
    end
    return true
end

Citizen.CreateThread(function()

    while true do

        Citizen.Wait(1)

        if dickheaddebug then
            local pos = GetEntityCoords(GetPlayerPed(-1))

            local forPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 1.0, 0.0)
            local backPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -1.0, 0.0)
            local LPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 1.0, 0.0, 0.0)
            local RPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), -1.0, 0.0, 0.0)

            local forPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 2.0, 0.0)
            local backPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -2.0, 0.0)
            local LPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 2.0, 0.0, 0.0)
            local RPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), -2.0, 0.0, 0.0)

            local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
            local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash, intersectStreetHash)
            currentStreetName = GetStreetNameFromHashKey(currentStreetHash)

            drawTxtS(0.8, 0.50, 0.4, 0.4, 0.30, "Heading: " .. GetEntityHeading(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.52, 0.4, 0.4, 0.30, "Coords: " .. pos, 55, 155, 55, 255)
            drawTxtS(0.8, 0.54, 0.4, 0.4, 0.30, "Attached Ent: " .. GetEntityAttachedTo(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.56, 0.4, 0.4, 0.30, "Health: " .. GetEntityHealth(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.58, 0.4, 0.4, 0.30, "H a G: " .. GetEntityHeightAboveGround(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.60, 0.4, 0.4, 0.30, "Model: " .. GetEntityModel(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.62, 0.4, 0.4, 0.30, "Speed: " .. GetEntitySpeed(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.64, 0.4, 0.4, 0.30, "Frame Time: " .. GetFrameTime(), 55, 155, 55, 255)
            drawTxtS(0.8, 0.66, 0.4, 0.4, 0.30, "Street: " .. currentStreetName, 55, 155, 55, 255)

            DrawLine(pos, forPos, 255, 0, 0, 115)
            DrawLine(pos, backPos, 255, 0, 0, 115)

            DrawLine(pos, LPos, 255, 255, 0, 115)
            DrawLine(pos, RPos, 255, 255, 0, 115)

            DrawLine(forPos, forPos2, 255, 0, 255, 115)
            DrawLine(backPos, backPos2, 255, 0, 255, 115)

            DrawLine(LPos, LPos2, 255, 255, 255, 115)
            DrawLine(RPos, RPos2, 255, 255, 255, 115)

            local nearped = getNPC()

            local veh = GetVehicle()

            local nearobj = GetObject()

            if IsControlJustReleased(0, 38) then
                if inFreeze then
                    inFreeze = false
                    -- TriggerEvent("DoShortHudText",'Freeze Disabled',3)
                    vRP.notify("Freeze Disabled")
                else
                    inFreeze = true
                    -- TriggerEvent("DoShortHudText",'Freeze Enabled',3)
                    vRP.notify("Freeze Enabled")
                end
            end
        else
            Citizen.Wait(5000)
        end
    end
end)

function drawTxtS(x, y, width, height, scale, text, r, g, b, a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(0.25, 0.25)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width / 2, y - height / 2 + 0.005)
end

function DrawText3Ds(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CORAÇÃO EM CIMA DA CABEÇA
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(coords, text)
    local x, y, z = table.unpack(coords)
    local camCoords = GetGameplayCamCoord()
    SetTextScale(0.0, 0.2)
    SetTextFont(0)
    SetTextCentre(true)
    SetTextProportional(1)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    SetDrawOrigin(x, y, z + 1, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RETIRAR ALGEMA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('admcuff')
AddEventHandler('admcuff', function()
    local ped = PlayerPedId()
    if vRP.isHandcuffed() then
        vRP._setHandcuffed(source, false)
        SetPedComponentVariation(PlayerPedId(), 7, 0, 0, 2)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CORAÇÃO NA CABEÇA AO DAR GOD
-----------------------------------------------------------------------------------------------------------------------------------------
function vADMC.showGodHeart(player)
    local timer = 200
    while timer > 0 do
        DrawText3D(GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(player))), "❤")
        Citizen.Wait(10)
        timer = timer - 1
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKAR PLAYERS SEM ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("MQCU:bugado")
AddEventHandler("MQCU:bugado", function()
    TriggerServerEvent('MQCU:bugado')
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /DV POR ÁREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('deleteVeh')
AddEventHandler('deleteVeh', function(k)
    DeleteVehicle(k)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKAR JOGADORES QUE USAM A VERSÃO CANARY E NASCEM BUGADOS (BUG DO FIVEM)
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    Citizen.Wait(10000)
    if GetResourceState('vrp') == 'stopped' then
        TriggerServerEvent("Bugado")
    end
end)

--------------------------------------------------------------------------------------------------------------
-- /me 
--------------------------------------------------------------------------------------------------------------
RegisterCommand('me', function(source, args, rawCommand)
    local text = '*' .. rawCommand:sub(4) .. '*'
    local ped = PlayerPedId()
    if GetEntityHealth(ped) > 101 then
        TriggerServerEvent('ChatMe', text)
    end
end)

local DisplayMe = false
RegisterNetEvent('DisplayMe')
AddEventHandler('DisplayMe', function(text, source)
    local DisplayMe = true
    local id = GetPlayerFromServerId(source)
    if id == -1 then
        return
    end
    Citizen.CreateThread(function()
        while DisplayMe do
            local ped = PlayerPedId()
            Wait(1)
            local coordsMe = GetEntityCoords(GetPlayerPed(id), false)
            local coords = GetEntityCoords(ped, false)
            local distance = Vdist2(coordsMe, coords)
            if distance <= 30 then
                DrawText3Ds(coordsMe['x'], coordsMe['y'], coordsMe['z'] + 0.90, text)
            end
        end
    end)
    Wait(7000)
    DisplayMe = false
end)

--------------------------------------------------------------------------------------------------------------
-- FIX DE SAIR ARMADO DA ARENA PVP DE FUZIL
--------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local ped = GetPlayerPed(-1)
        if crz.WhatDimension() == 0 then
            if GetAmmoInPedWeapon(ped, 'WEAPON_PISTOL_MK2') < 0 or GetAmmoInPedWeapon(ped, 'WEAPON_CARBINERIFLE_MK2') < 0 then
                RemoveAllPedWeapons(GetPlayerPed(-1), true)
            end
            Wait(1200)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- MARCAÇÃO PARA POLICIA NO ASSALTO DE RUA
-----------------------------------------------------------------------------------------------------------------------------------------
local blipassalto = nil
RegisterNetEvent('blipassalto:criar:assalto')
AddEventHandler('blipassalto:criar:assalto',function(x,y,z)
	if not DoesBlipExist(blipassalto) then
		blipassalto = AddBlipForCoord(x,y,z)
		SetBlipScale(blipassalto,0.5)
		SetBlipSprite(blipassalto,1)
		SetBlipColour(blipassalto,59)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Roubo: Assalto de Rua")
		EndTextCommandSetBlipName(blipassalto)
		SetBlipAsShortRange(blipassalto,false)
		SetBlipRoute(blipassalto,true)
	end
end)

RegisterNetEvent('blipassalto:remover:assalto')
AddEventHandler('blipassalto:remover:assalto',function()
	if DoesBlipExist(blipassalto) then
		RemoveBlip(blipassalto)
		blipassalto = nil
	end
end)

-- function CalculateTimeToDisplay()
-- 	horario = GetClockHours()
-- 	if horario <= 9 then
-- 		horario = "0" .. horario
-- 	end
-- end

-- RegisterCommand('roubar', function(source, args, RawCommand)
-- 	CalculateTimeToDisplay()
-- 	if parseInt(horario) >= 14 or parseInt(horario) <= 06 then
-- 		TriggerServerEvent('roubar')
-- 	else
-- 		TriggerEvent("Notify","aviso","Roubos só são permitidos entre <b>22h e 06h</b> (horário local da cidade)")
-- 	end
-- end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE CABEÇADA
-----------------------------------------------------------------------------------------------------------------------------------------
-- Default key is E if you wish to change the key then go here: https://docs.fivem.net/game-references/controls/
--This does not have any permissions in it at all, you'll have to add that yourself.

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedSprinting(PlayerPedId()) and IsControlJustReleased(0, 38) then --Change the key for tackling here.
			if IsPedInAnyVehicle(PlayerPedId()) then
			else
				local ForwardVector = GetEntityForwardVector(PlayerPedId())
				local Tackled = {}

				SetPedToRagdollWithFall(PlayerPedId(), 1000, 1500, 0, ForwardVector, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0) --how long the tackler will remain down.

				while IsPedRagdoll(PlayerPedId()) do
					Citizen.Wait(0)
					for Key, Value in ipairs(getTouchedPlayers()) do
						if not Tackled[Value] then
							Tackled[Value] = true
							TriggerServerEvent('Tackle:Server:TacklePlayer', GetPlayerServerId(Value), ForwardVector, GetPlayerName(PlayerId()))
						end
					end
				end
			end
		end
	end
end)

RegisterNetEvent('Tackle:Client:TacklePlayer')
AddEventHandler('Tackle:Client:TacklePlayer',function(ForwardVector)
	SetPedToRagdollWithFall(PlayerPedId(), 3000, 3000, 0, ForwardVector, 10.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0) --how long the person being tackled will remain down.
end)

function getPlayers()
    local players = {}

    for i = 0, 255 do
       if NetworkIsPlayerActive(i) then
            table.insert(players, i)
       end
    end

    return players
end

function getTouchedPlayers()
    local touchedPlayer = {}
    for Key, Value in ipairs(getPlayers()) do
		if IsEntityTouchingEntity(PlayerPedId(), GetPlayerPed(Value)) then
			table.insert(touchedPlayer, Value)
		end
    end
    return touchedPlayer
end