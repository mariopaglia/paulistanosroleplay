local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local gangzones = {
    -- {X, Y, Z, distancia, permissao para dominar, nome da zona} -- Do centro da gangzone 
    {1672.67, -25.84, 173.77, 15, "dominar.permissao", "Gangzone Teste"}
}

local tempoDominar = 30 -- Tempo para dominar regiao

local faccoes = {
    --{{"verdesL","verdes"}, "verdes"}
}

function GetPlayerFactionColor(user_id)
    if vRP.hasGroup(user_id, "Verdes") then
        return 52
    elseif  vRP.hasGroup(user_id, "Roxos") then
        return 50
    end
end




local playerDominando = {}
local time = {}
local tempoContando = {}
local blips = {}

RegisterCommand("do", function (source)
    local gangZone = GetPlayerGangzone(source)
    local user_id = vRP.getUserId(source)
    if gangZone == nil or not vRP.hasPermission(user_id, gangzones[gangZone][5]) then
        return
    end

    time[gangZone] = tempoDominar
    playerDominando[gangZone] = user_id

    DrawMarker(2, gangzones[gangZone][1], gangzones[gangZone][2], gangzones[gangZone][3] + 2, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1 * v[4], 1 * v[4], 15, 255, 255, 255, 255, false, true, 2, nil, nil, false)

    AvisarDominio(gangZone)
end, false)

function GetFactionFromId(user_id)
    local group = vRP.getGroupByType(user_id, "job")
    for _,v in ipairs(faccoes) do
        for _,z in ipairs(v[1]) do
            if z == group then
                return v[2]
            end
        end
    end
    return "os Civis"
end

function AvisarDominio(zoneId)
    SendNotificationToAll("Uma guerra foi iniciada em " .. gangzones[zoneId][6], true);
end

function AvisarDominado(zoneId, fac)
    SendNotificationToAll("A guerra em " .. gangzones[zoneId][6] .. " foi encerrada. Os vencedores foram " .. fac, true);
end

function GetPlayerGangzone(source)
    for i,v in ipairs(gangzones) do
        if (GetDistanceBetweenCoords(v[1], v[2], v[3], GetEntityCoords(source)) < v[4]) then
            return i
        end
    end
    return nil
end

Citizen.CreateThread(function()

    AddTextEntry('MYBLIPNAME', 'Favala')
    for i,v in pairs(gangzones) do
        blip[i] = AddBlipForCoord(v[1], v[2], v[3])

        BeginTextCommandSetBlipName('MYBLIPNAME')
        EndTextCommandSetBlipName(blip[i])

        SetBlipColour(blip[i], 0)
    end

    while Citizen.Wait(1000) do
        for i,_ in ipairs(gangzones) do
            if time[i] then
                if time[i] > 0 then
                    time[i] = time[i] - 1
                    tempoContando[i] = true
                elseif time[i] <= 0 and tempoContando[i] then
                    tempoContando[i] = false

                    -- TODO bonificar vencedor

                    SetBlipColour(blip[i], GetPlayerFactionColor(playerDominando[i]))

                    AvisarDominado(i, GetFactionFromId(playerDominando[i]))

                    playerDominando[i] = nil
                end
            end
        end
    end
end)