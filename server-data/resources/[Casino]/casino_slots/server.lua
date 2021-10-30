local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

math.randomseed(os.clock() * 100000000000)
math.randomseed(os.clock() * math.random())
math.randomseed(os.clock() * math.random())

local activeSlot = {}

function r_showNotification(source, msg)
    TriggerClientEvent('slots:showNotification', source, msg)
end

RegisterNetEvent('casino:slots:isSeatUsed')
AddEventHandler('casino:slots:isSeatUsed', function(index)
    local source = source
    if activeSlot[index] ~= nil then
        if activeSlot[index].used then
        else
            activeSlot[index].used = true
        end
    else
        activeSlot[index] = {}
        activeSlot[index].used = true
        updatePlayerChips(source)
    end
end)

RegisterNetEvent('casino:slots:notUsing')
AddEventHandler('casino:slots:notUsing', function(index)
    local source = source
    if activeSlot[index] ~= nil then
        activeSlot[index].used = false
    end
end)

RegisterNetEvent('casino:taskStartSlots')
AddEventHandler('casino:taskStartSlots', function(index, data)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if user_id ~= nil then
        if vRP.getInventoryItemAmount(user_id, "casino_token") < data.bet then
            r_showNotification(source, 'insuficient_token não tem fichas suficientes!')
        else
            if activeSlot[index] then
                vRP.tryGetInventoryItem(user_id, "casino_token", data.bet, false)
                PerformHttpRequest(Config.slotsLoss, function(err, text, headers)
                end, 'POST', json.encode({
                    embeds = {
                        {
                            title = "DIAMOND CASINO REGISTRO DE PERDA:",
                            thumbnail = {url = "https://i.imgur.com/2beKQ7n.jpg"},
                            fields = {{name = "**IDENTIFICAÇÃO DO PLAYER:**", value = "**" .. identity.name .. " " .. identity.firstname .. "** [**" .. user_id .. "**] \n⠀"}, {name = "**PERDA DO PLAYER:**", value = "**" .. data.bet .. " fichas**\n⠀"}},
                            footer = {text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/2beKQ7n.jpg"},
                            color = 15906321,
                        },
                    },
                }), {['Content-Type'] = 'application/json'})
                local w = {a = math.random(1, 16), b = math.random(1, 16), c = math.random(1, 16)}

                local rnd1 = math.random(1, 100)
                local rnd2 = math.random(1, 100)
                local rnd3 = math.random(1, 100)

                if Config.Offset then
                    if rnd1 > Config.OffsetNum then
                        w.a = w.a + 0.5
                    end
                    if rnd2 > Config.OffsetNum then
                        w.b = w.b + 1.0
                    end
                    if rnd3 > Config.OffsetNum then
                        w.c = w.c + 0.5
                    end
                end

                TriggerClientEvent('casino:slots:startSpin', source, index, w)
                activeSlot[index].win = w
            end
        end
    end
end)

RegisterNetEvent('casino:slotsCheckWin')
AddEventHandler('casino:slotsCheckWin', function(index, data, dt)
    if activeSlot[index] then
        if activeSlot[index].win then
            if activeSlot[index].win.a == data.a and activeSlot[index].win.b == data.b and activeSlot[index].win.c == data.c then
                CheckForWin(activeSlot[index].win, dt)
            end
        end
    end
end)

function CheckForWin(w, data)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if user_id ~= nil then
        local a = Config.Wins[w.a]
        local b = Config.Wins[w.b]
        local c = Config.Wins[w.c]
        local total = 0
        if a == b and b == c and a == c then
            if Config.Mult[a] then
                total = data.bet * Config.Mult[a]
            end
        elseif a == '6' and b == '6' then
            total = data.bet * 5
        elseif a == '6' and c == '6' then
            total = data.bet * 5
        elseif b == '6' and c == '6' then
            total = data.bet * 5

        elseif a == '6' then
            total = data.bet * 2
        elseif b == '6' then
            total = data.bet * 2
        elseif c == '6' then
            total = data.bet * 2
        end
        if total > 0 then
            r_showNotification(source, 'Você ganhou' .. ' ' .. total .. ' ' .. 'fichas')
            TriggerClientEvent('InteractSound_CL:PlayOnOne', source, 'TD_BIG_WIN_01', 0.1)
            vRP.giveInventoryItem(user_id, "casino_token", total, false)
            updatePlayerChips(source)
            if total > 12500 then
                PerformHttpRequest(Config.slotsGain, function(err, text, headers)
                end, 'POST', json.encode({
                    embeds = {
                        {
                            title = "DIAMOND CASINO REGISTRO DE GANHO:",
                            thumbnail = {url = "https://i.imgur.com/2beKQ7n.jpg"},
                            fields = {{name = "**IDENTIFICAÇÃO DO PLAYER:**", value = "**" .. identity.name .. " " .. identity.firstname .. "** [**" .. user_id .. "**] \n⠀"}, {name = "**GANHO DO PLAYER:**", value = "**" .. total .. " fichas**\n⠀"}},
                            footer = {text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://i.imgur.com/2beKQ7n.jpg"},
                            color = 15906321,
                        },
                    },
                }), {['Content-Type'] = 'application/json'})
            end
        else
            r_showNotification(source, 'Infelizmente você perdeu')
            TriggerClientEvent('InteractSound_CL:PlayOnOne', source, 'TD_NO_WIN_01', 0.1)
            updatePlayerChips(source)
        end
    end
end

function getPlayerChips(source)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return vRP.getInventoryItemAmount(user_id, "casino_token")
    else
        return 0
    end
end

function updatePlayerChips(source)
    TriggerClientEvent('slots:updatePlayerChips', source, getPlayerChips(source))
end
