local sitting = false
local pos, lastPos = nil, nil
local currentSitObj, currentScenario = nil, nil
local data, object, distance = nil, nil, 0

RegisterCommand('sentar', function(source)
    if not sitting and not IsPedInAnyVehicle(PlayerPedId(), true) then
        TriggerEvent('SitScript:StartSit')
    else
        Standup()
    end
    
end)


RegisterNetEvent('SitScript:StartSit')
AddEventHandler('SitScript:StartSit', function()
    local closestObject = GetClosestObject()
    object = closestObject.object
    distance = closestObject.distance

    if distance < 1.5 then
        local hash = GetEntityModel(object)
        data = nil
        
        local modelName = nil
        local found = false

        for k,v in pairs(Config.Sitable) do
            if GetHashKey(k) == hash then
                data = v
                modelName = k
                found = true
                break
            end
        end

        if found then
            Sit(object, modelName, data)
        end
    end
end)

RegisterNetEvent('SitScript:GetChair')
AddEventHandler('SitScript:GetChair', function(occupied)
    if not occupied then
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(object)

        lastPos = GetEntityCoords(playerPed)
        currentSitObj = id
        currentScenario = data.scenario

        TriggerServerEvent('SitScript:TakeChair', id)
        FreezeEntityPosition(object, true)
        TaskStartScenarioAtPosition(playerPed, currentScenario, coords.x, coords.y, coords.z - data.verticalOffset, GetEntityHeading(object) + 180.0, 0, true, true)
        sitting = true
    end
end)

function GetClosestObject()
    local playerPed = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(playerPed))

    local list = {}
    for _,v in pairs(Config.Props) do
        local obj = GetClosestObjectOfType(x, y, z, 2.0, GetHashKey(v), false, true, true)
        local dist = GetDistanceBetweenCoords(GetEntityCoords(playerPed), GetEntityCoords(obj), true)
        table.insert(list, {object = obj, distance = dist})
    end

    local closestObject = list[1]
    for _,v in pairs(list) do
        if v.distance < closestObject.distance then
            closestObject = v
        end
    end

    return closestObject
end

function Sit(object, modelName, data)
	local coords = GetEntityCoords(object)
	local id = coords.x .. coords.y .. coords.z
    TriggerServerEvent('SitScript:CheckChair', id)
end

function Standup()
    local playerPed = PlayerPedId()

    ClearPedTasks(playerPed)
    sitting = false
    SetEntityCoords(playerPed, lastPos)
    FreezeEntityPosition(playerPed, false)
    FreezeEntityPosition(currentSitObj, false)
    TriggerServerEvent('SitScript:LeaveChair', currentSitObj)
    currentSitObj = nil
    currentScenario = nil
end