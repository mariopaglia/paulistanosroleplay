local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emp = Tunnel.getInterface("emp_frete")
vRP = Proxy.getInterface("vRP")
local cfg = module("emp_frete", "config/config")

local onDelivery = false
local blip = nil
local startMission = false
local endMission = false
local itemOnHands = false
local itemOnVeh = false
local veh = nil

RegisterCommand("frete", function(source, args)
    onDelivery = not onDelivery

    if onDelivery then
        createItems()
    else
        removeItems()
    end
end)

function removeItems()
    if blip~=nil then
        RemoveBlip(blip)
    end

    if PackageObject~=nil then
        ClearPedTasksImmediately(GetPlayerPed(-1))
        DeleteEntity(PackageObject)
    end

    onDelivery = false
    blip = nil
    startMission = false
    endMission = false
    itemOnHands = false
    itemOnVeh = false
    veh = nil
end

function createItems() 
    if onDelivery then
        if startMission==false and endMission==false then
            locGetItem = math.random(1, #cfg.locations)
            local pos = cfg.locations[locGetItem]
            CriandoBlip(pos)
            Alert("importante", cfg.messages.initialize)
        end
    end
end

RegisterNetEvent("esc_carreto:Entregue")
AddEventHandler("esc_carreto:Entregue",function() 
    removeItems()
end)

function putInVeh()
    local player = GetPlayerPed(-1)
    local vehCoords = GetEntityCoords(veh)
    local closestObject = GetClosestObjectOfType(vehCoords, 3.0, GetHashKey(cfg.items[item][1]), false)        
    AttachEntityToEntity(closestObject, veh, 0.0, 0.0, cfg.items[item][3], 0.4, 0.0, 0.0, 0.0, false, false, true, false, 2, true)
    FreezeEntityPosition(closestObject, true)
    ClearPedTasksImmediately(GetPlayerPed(-1))
    itemOnHands = false
    itemOnVeh = true
end

function getFromVeh()
    local player = GetPlayerPed(-1)
    RequestAnimDict("anim@heists@box_carry@")
    TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)

    local pedCoords = GetEntityCoords(player)
    local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey(cfg.items[item][1]), false)        
    AttachEntityToEntity(PackageObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, cfg.items[item][2], -0.1, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
    FreezeEntityPosition(closestObject, true)
    itemOnHands = true
    itemOnVeh = false
end

function pegarItem() 
    local player = GetPlayerPed(-1)

    item = math.random(1, #cfg.items)
    Alert("sucesso",cfg.messages.initialize)

    RequestAnimDict("anim@heists@box_carry@")
    TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)

    local x, y, z = table.unpack(GetEntityCoords(player))
    PackageObject = CreateObject(GetHashKey(cfg.items[item][1]), x,y,z+0.3, false)

    local closestObject = GetClosestObjectOfType(GetEntityCoords(player), 3.0, GetHashKey(cfg.items[item][1]), false)
    AttachEntityToEntity(PackageObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, cfg.items[item][2], -0.1, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
    Citizen.Wait(1000) 
    locPutItem = math.random(1, #cfg.locations)
    local pos = cfg.locations[locPutItem]
    CriandoBlip(pos)
    Alert("sucesso", cfg.messages.delivery)        

    itemOnHands = true
    endMission = true
    startMission = false

end

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0) 
        if itemOnHands then
            if(IsControlJustReleased(0, 167)) then
                ClearPedTasksImmediately(GetPlayerPed(-1))
                DeleteEntity(PackageObject)
                removeItems()
            end
        end
     end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if onDelivery then
            if startMission==false and endMission==false then
                DrawMarker(cfg.blip,cfg.locations[locGetItem],0,0,0,0,0,0,1.0,1.0,0.5,cfg.blipColor.r,cfg.blipColor.g,cfg.blipColor.b,50,0,0,0,0)

                local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),cfg.locations[locGetItem],true)
                if distance <=1.5 then
                    Draw3DText(cfg.locations[locGetItem], cfg.messages.getItem)
                    if IsControlJustPressed(0,38) then
                        pegarItem()
                    end
                end
            end

            veh = GetVehiclePedIsIn(GetPlayerPed(-1),true)
            if veh > 0 and itemOnHands and not itemOnVeh then
                local vehHash = GetEntityModel(veh)
                local hash = cfg.vehicle
                local testeDist = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),GetEntityCoords(veh),true)
                if tostring(hash) == tostring(vehHash) then
                    if testeDist <=3 then
                        Draw3DText(GetEntityCoords(veh), cfg.messages.putVeh)
                        if IsControlJustPressed(0,38) then
                            putInVeh()
                        end
                    end
                end
            end

            if veh > 0 and not itemOnHands and itemOnVeh then
                local vehHash = GetEntityModel(veh)
                local hash = cfg.vehicle
                local testeDist = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),GetEntityCoords(veh),true)
                if tostring(hash) == tostring(vehHash) then
                    if testeDist <=3 then
                        Draw3DText(GetEntityCoords(veh), cfg.messages.getVeh)
                        if IsControlJustPressed(0,52) then
                            getFromVeh()
                        end
                    end
                end
            end

            if startMission==false and endMission==true and itemOnHands then
                DrawMarker(cfg.blip,cfg.locations[locPutItem],0,0,0,0,0,0,1.0,1.0,0.5,cfg.blipColor.r,cfg.blipColor.g,cfg.blipColor.b,50,0,0,0,0)

                local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),cfg.locations[locPutItem],true)
                if distance <=1.5 then
                    Draw3DText(cfg.locations[locPutItem], cfg.messages.deliveryItem)
                    if IsControlJustPressed(0,38) then
                        TriggerServerEvent("esc_carreto:Entregar")
                    end
                end
            end
        end
    end
end)

function VehicleInFront()
    local player = PlayerPedId()
    local pos = GetEntityCoords(player)
    local entityWorld = GetOffsetFromEntityInWorldCoords(player, 0.0, 2.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 30, player, 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)
    return result
end
  
function Draw3DText(posicao, text)
    local onScreen,_x,_y=World3dToScreen2d(posicao[1],posicao[2],posicao[3])
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.5, 0.5)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 0)
end

function CriandoBlip(pos)
    if (blip~=nil) then
        RemoveBlip(blip)
    end
  
	blip = AddBlipForCoord(pos[1], pos[2], pos[3])
	SetBlipSprite(blip,1)
	SetBlipColour(blip,5)
	SetBlipScale(blip,0.7)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	EndTextCommandSetBlipName(blip)
end

function Alert(type, msg)
    TriggerEvent("Notify",type, msg)
    --vRPclient.notify(msg)
end
