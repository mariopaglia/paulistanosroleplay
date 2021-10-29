local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

function r_showNotification(source, msg)
    TriggerClientEvent('sorte:showNotification', source, msg)
end

isRoll = false
amount = 1

RegisterServerEvent('casino_luckywheel:getLucky')
AddEventHandler('casino_luckywheel:getLucky', function()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local player = vRP.getUserSource(user_id)
    local ticket = vRP.getInventoryItemAmount(user_id, "casino_ticket")
    TriggerClientEvent("invarte", player)
    if not isRoll then
        if user_id ~= nil then
            if ticket >= amount then
                vRP.tryGetInventoryItem(user_id, "casino_ticket", amount)
                -- spin the wheel
                isRoll = true
                local _randomPrice = math.random(1, 100)

                -- 1% de chance
                if _randomPrice == 1 then
                    local _subRan = math.random(1, 2)
                    if _subRan == 1 then
                        _priceIndex = 1 -- win car
                    else
                        _priceIndex = 11 -- loose
                    end
                -- 4% de chance
                elseif _randomPrice > 1 and _randomPrice <= 6 then
                    local _subRan = math.random(1, 2)
                    if _subRan == 1 then
                        _priceIndex = 2 -- win
                    else
                        _priceIndex = 11 -- loose
                    end
                -- 8% de chance
                elseif _randomPrice > 6 and _randomPrice <= 15 then
                    local _subRan = math.random(1, 3)
                    if _subRan == 1 then
                        _priceIndex = 3 -- win
                    else
                        _priceIndex = 11 -- loose
                    end
                -- 9% de chance
                elseif _randomPrice > 15 and _randomPrice <= 25 then
                    local _subRan = math.random(1, 3)
                    if _subRan == 1 then
                        _priceIndex = 4 -- win
                    else
                        _priceIndex = 11 -- loose
                    end
                -- 14% de chance
                elseif _randomPrice > 25 and _randomPrice <= 40 then
                    local _subRan = math.random(1, 3)
                    if _subRan == 1 then
                        _priceIndex = 5 -- win
                    else
                        _priceIndex = 11 -- loose
                    end
                -- 19% de chance
                elseif _randomPrice > 40 and _randomPrice <= 60 then
                    local _subRan = math.random(1, 3)
                    if _subRan == 1 then
                        _priceIndex = 6 -- win
                    else
                        _priceIndex = 11 -- loose
                    end
                -- 39% de chance
                elseif _randomPrice > 60 and _randomPrice <= 100 then
                    local _subRan = math.random(1, 3)
                    if _subRan == 1 then
                        _priceIndex = 7 -- win
                    else
                        _priceIndex = 11 -- loose
                    end
                -- 39% de chance
                elseif _randomPrice > 60 and _randomPrice <= 100 then
                    local _subRan = math.random(1, 3)
                    if _subRan == 1 then
                        _priceIndex = 8 -- win
                    else
                        _priceIndex = 11 -- loose
                    end
                -- 39% de chance
                elseif _randomPrice > 60 and _randomPrice <= 100 then
                    local _subRan = math.random(1, 3)
                    if _subRan == 1 then
                        _priceIndex = 9 -- win
                    else
                        _priceIndex = 11 -- loose
                    end
                -- 39% de chance
                elseif _randomPrice > 60 and _randomPrice <= 100 then
                    local _subRan = math.random(1, 3)
                    if _subRan == 1 then
                        _priceIndex = 10 -- win
                    else
                        _priceIndex = 11 -- loose
                    end
                end

                -- prize index
                SetTimeout(4000, function()
                    isRoll = false
                    if _priceIndex == 1 then
                        local source = source
                        local user_id = vRP.getUserId(source)
                        vRP.execute("creative/add_vehicle", {user_id = parseInt(user_id), vehicle = "ferrariitalia", ipva = parseInt(os.time())})
                        vRP.execute("creative/set_ipva", {user_id = parseInt(user_id), vehicle = "ferrariitalia", ipva = parseInt(os.time())})
                        r_showNotification(source, 'Você ganhou: Parabéns você ganhou um CARRO!')
                        vRP.Log("```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[GANHOU]: ferrariitalia\n[MAQUINA]: Roleta da Sorte\n"..os.date("[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."\r```",CASINO)
                        TriggerClientEvent('InteractSound_CL:PlayOnOne', source, 'LUCKY_WHEEL_WIN_WIN_CAR', 0.1)
                    elseif _priceIndex == 2 then
                        vRP.giveInventoryItem(user_id, "casino_token", 70000)
                        r_showNotification(source, 'Você ganhou: Parabéns você ganhou 70.000 Fichas!')
                        TriggerClientEvent('InteractSound_CL:PlayOnOne', source, 'LUCKY_WHEEL_WIN_WIN_CHIPS', 0.1)
                    elseif _priceIndex == 3 then
                        vRP.giveInventoryItem(user_id, "casino_token", 50000)
                        r_showNotification(source, 'Você ganhou: Parabéns você ganhou 50.000 Fichas!')
                        TriggerClientEvent('InteractSound_CL:PlayOnOne', source, 'LUCKY_WHEEL_WIN_WIN_CHIPS', 0.1)
                    elseif _priceIndex == 4 then
                        vRP.giveInventoryItem(user_id, "casino_token", 30000)
                        r_showNotification(source, 'Você ganhou: Parabéns você ganhou 30.000 Fichas!')
                        TriggerClientEvent('InteractSound_CL:PlayOnOne', source, 'LUCKY_WHEEL_WIN_WIN_CHIPS', 0.1)
                    elseif _priceIndex == 5 then
                        vRP.giveInventoryItem(user_id, "casino_token", 20000)
                        r_showNotification(source, 'Você ganhou: Parabéns você ganhou 20.000 Fichas!')
                        TriggerClientEvent('InteractSound_CL:PlayOnOne', source, 'LUCKY_WHEEL_WIN_WIN_CHIPS', 0.1)
                    elseif _priceIndex == 6 then
                        vRP.giveInventoryItem(user_id, "raspadinha", 3)
                        r_showNotification(source, 'Você ganhou: Parabéns você ganhou 3 Raspadinhas!')
                        TriggerClientEvent('InteractSound_CL:PlayOnOne', source, 'LUCKY_WHEEL_WIN_WIN_CHIPS', 0.1)
                    elseif _priceIndex == 7 then
                        vRP.giveInventoryItem(user_id, "raspadinha", 2)
                        r_showNotification(source, 'Você ganhou: Parabéns você ganhou 2 Raspadinhas!')
                        TriggerClientEvent('InteractSound_CL:PlayOnOne', source, 'LUCKY_WHEEL_WIN_WIN_CASH', 0.1)
                    elseif _priceIndex == 8 then
                        vRP.giveInventoryItem(user_id, "casino_token", 15000)
                        r_showNotification(source, 'Você ganhou: Parabéns você ganhou 15.000 Fichas!')
                        TriggerClientEvent('InteractSound_CL:PlayOnOne', source, 'LUCKY_WHEEL_WIN_WIN_CASH', 0.1)
                    elseif _priceIndex == 9 then
                        vRP.giveInventoryItem(user_id, "casino_ticket", 2)
                        r_showNotification(source, 'Você ganhou: Parabéns você ganhou 2 Ticket de Roleta!')
                        TriggerClientEvent('InteractSound_CL:PlayOnOne', source, 'LUCKY_WHEEL_WIN_WIN_CASH', 0.1)
                    elseif _priceIndex == 10 then
                        vRP.giveInventoryItem(user_id, "casino_token", 10000)
                        r_showNotification(source, 'Você ganhou: Parabéns você ganhou 10.000 Fichas!')
                        TriggerClientEvent('InteractSound_CL:PlayOnOne', source, 'LUCKY_WHEEL_WIN_STEREO_WIN_STINGER_GENERAL', 0.1)
                    elseif _priceIndex == 11 then
                        r_showNotification(source, 'Você perdeu: Por favor, tente novamente!')
                        TriggerClientEvent('InteractSound_CL:PlayOnOne', source, 'TD_NO_WIN_03', 0.1)
                    end
                    TriggerClientEvent("casino_luckywheel:rollFinished", -1)
                end)
                TriggerClientEvent("casino_luckywheel:doRoll", -1, _priceIndex)
            else
                TriggerClientEvent("casino_luckywheel:rollFinished", -1)
                r_showNotification(source, 'Infelizmente você não tem mais Ticket!')
            end
        end
    end
end)
