local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
vTASKBAR = Tunnel.getInterface("vrp_taskbar")
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_residencia", src)
vCLIENT = Tunnel.getInterface("vrp_residencia")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
local timehouses = {}
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        for k, v in pairs(timehouses) do
            if v > 0 then
                timehouses[k] = v - 1
                if v == 0 then
                    timehouses[k] = nil
                end
            end
            Citizen.Wait(10)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKLOCKPICK
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkLockpick(id, x, y, z, x2, y2, z2, h)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.getInventoryItemAmount(user_id, "lockpick") >= 1 then
            local policia = vRP.getUsersByPermission("policia.permissao")
            if #policia <= 2 then
                TriggerClientEvent("Notify", source, "aviso", "Número insuficientes de policiais para realizar roubo à residencia", 8000)
            elseif parseInt(timehouses[id]) > 0 then
                TriggerClientEvent("Notify", source, "importante", "Só poderá tentar roubar em <b>" .. parseInt(timehouses[id]) .. "</b> segundos", 8000)
            else
                timehouses[id] = 3600
                vCLIENT.checkStatus(source, true)

                -- FUNÇÃO PARA FAZER A LOCKPICK QUEBRAR
                if math.random(100) >= 80 then
                    vRP.tryGetInventoryItem(user_id, "lockpick", 1)
                    TriggerClientEvent("Notify", source, "aviso", "Sua lockpick quebrou!", 8000)
                end
                if math.random(100) >= 80 then
                    timehouses[id] = 0
                    vCLIENT.checkStatus(source, false)
                    TriggerClientEvent("Notify", source, "aviso", "Fechadura emperrada.", 8000)
                else
                    if math.random(100) >= 80 then
                        vCLIENT.createLocker(source, true, x2, y2, z2, h)
                    else
                        vCLIENT.createLocker(source, false, x2, y2, z2, h)
                    end
                    vRPclient.teleport(source, x, y, z)
                end
            end
        else
            TriggerClientEvent("Notify", source, "negado", "<b>Lockpick</b> não encontrada.", 8000)
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {
    ["creative01"] = {
        [1] = {"dinheirosujo", math.random(1200)},
        [2] = {"dinheirosujo", math.random(1800)},
        [3] = {"sapatosroubado", math.random(3)},
        [4] = {"relogioroubado", math.random(4)},
        [5] = {"anelroubado", math.random(2)},
        [6] = {"colarroubado", math.random(3)},
        [7] = {"notebookroubado", math.random(4)},
        [8] = {"tabletroubado", math.random(5)},
        [9] = {"vibradorroubado", math.random(2)},
        [10] = {"carteiraroubada", math.random(3)},
        [11] = {"perfumeroubado", math.random(2)},
    },
    ["creative02"] = {
        [1] = {"dinheirosujo", math.random(1200)},
        [2] = {"dinheirosujo", math.random(1800)},
        [3] = {"sapatosroubado", math.random(3)},
        [4] = {"relogioroubado", math.random(4)},
        [5] = {"anelroubado", math.random(2)},
        [6] = {"colarroubado", math.random(3)},
        [7] = {"notebookroubado", math.random(4)},
        [8] = {"tabletroubado", math.random(5)},
        [9] = {"vibradorroubado", math.random(2)},
        [10] = {"carteiraroubada", math.random(3)},
        [11] = {"perfumeroubado", math.random(2)},
    },
    ["creative03"] = {
        [1] = {"dinheirosujo", math.random(1200)},
        [2] = {"dinheirosujo", math.random(1800)},
        [3] = {"sapatosroubado", math.random(3)},
        [4] = {"relogioroubado", math.random(4)},
        [5] = {"anelroubado", math.random(2)},
        [6] = {"colarroubado", math.random(3)},
        [7] = {"notebookroubado", math.random(4)},
        [8] = {"tabletroubado", math.random(5)},
        [9] = {"vibradorroubado", math.random(2)},
        [10] = {"carteiraroubada", math.random(3)},
        [11] = {"perfumeroubado", math.random(2)},
    },
    ["creative04"] = {
        [1] = {"dinheirosujo", math.random(1200)},
        [2] = {"dinheirosujo", math.random(1800)},
        [3] = {"sapatosroubado", math.random(3)},
        [4] = {"relogioroubado", math.random(4)},
        [5] = {"anelroubado", math.random(2)},
        [6] = {"colarroubado", math.random(3)},
        [7] = {"notebookroubado", math.random(4)},
        [8] = {"tabletroubado", math.random(5)},
        [9] = {"vibradorroubado", math.random(2)},
        [10] = {"carteiraroubada", math.random(3)},
        [11] = {"perfumeroubado", math.random(2)},
    },
    ["creative05"] = {
        [1] = {"dinheirosujo", math.random(1200)},
        [2] = {"dinheirosujo", math.random(1800)},
        [3] = {"sapatosroubado", math.random(3)},
        [4] = {"relogioroubado", math.random(4)},
        [5] = {"anelroubado", math.random(2)},
        [6] = {"colarroubado", math.random(3)},
        [7] = {"notebookroubado", math.random(4)},
        [8] = {"tabletroubado", math.random(5)},
        [9] = {"vibradorroubado", math.random(2)},
        [10] = {"carteiraroubada", math.random(3)},
        [11] = {"perfumeroubado", math.random(2)},
    },
    ["creative06"] = {
        [1] = {"dinheirosujo", math.random(1200)},
        [2] = {"dinheirosujo", math.random(1800)},
        [3] = {"sapatosroubado", math.random(3)},
        [4] = {"relogioroubado", math.random(4)},
        [5] = {"anelroubado", math.random(2)},
        [6] = {"colarroubado", math.random(3)},
        [7] = {"notebookroubado", math.random(4)},
        [8] = {"tabletroubado", math.random(5)},
        [9] = {"vibradorroubado", math.random(2)},
        [10] = {"carteiraroubada", math.random(3)},
        [11] = {"perfumeroubado", math.random(2)},
    },
    ["creative07"] = {
        [1] = {"dinheirosujo", math.random(1200)},
        [2] = {"dinheirosujo", math.random(1800)},
        [3] = {"sapatosroubado", math.random(3)},
        [4] = {"relogioroubado", math.random(4)},
        [5] = {"anelroubado", math.random(2)},
        [6] = {"colarroubado", math.random(3)},
        [7] = {"notebookroubado", math.random(4)},
        [8] = {"tabletroubado", math.random(5)},
        [9] = {"vibradorroubado", math.random(2)},
        [10] = {"carteiraroubada", math.random(3)},
        [11] = {"perfumeroubado", math.random(2)},
    },
    ["creative08"] = {
        [1] = {"dinheirosujo", math.random(1200)},
        [2] = {"dinheirosujo", math.random(1800)},
        [3] = {"sapatosroubado", math.random(3)},
        [4] = {"relogioroubado", math.random(4)},
        [5] = {"anelroubado", math.random(2)},
        [6] = {"colarroubado", math.random(3)},
        [7] = {"notebookroubado", math.random(4)},
        [8] = {"tabletroubado", math.random(5)},
        [9] = {"vibradorroubado", math.random(2)},
        [10] = {"carteiraroubada", math.random(3)},
        [11] = {"perfumeroubado", math.random(2)},
    },
    ["creative09"] = {
        [1] = {"dinheirosujo", math.random(1200)},
        [2] = {"dinheirosujo", math.random(1800)},
        [3] = {"sapatosroubado", math.random(3)},
        [4] = {"relogioroubado", math.random(4)},
        [5] = {"anelroubado", math.random(2)},
        [6] = {"colarroubado", math.random(3)},
        [7] = {"notebookroubado", math.random(4)},
        [8] = {"tabletroubado", math.random(5)},
        [9] = {"vibradorroubado", math.random(2)},
        [10] = {"carteiraroubada", math.random(3)},
        [11] = {"perfumeroubado", math.random(2)},
    },
    ["creative10"] = {
        [1] = {"dinheirosujo", math.random(1200)},
        [2] = {"dinheirosujo", math.random(1800)},
        [3] = {"sapatosroubado", math.random(3)},
        [4] = {"relogioroubado", math.random(4)},
        [5] = {"anelroubado", math.random(2)},
        [6] = {"colarroubado", math.random(3)},
        [7] = {"notebookroubado", math.random(4)},
        [8] = {"tabletroubado", math.random(5)},
        [9] = {"vibradorroubado", math.random(2)},
        [10] = {"carteiraroubada", math.random(3)},
        [11] = {"perfumeroubado", math.random(2)},
    },
    ["locker"] = {
        [1] = {"dinheirosujo", math.random(1200)},
        [2] = {"dinheirosujo", math.random(1800)},
        [3] = {"sapatosroubado", math.random(3)},
        [4] = {"relogioroubado", math.random(4)},
        [5] = {"anelroubado", math.random(2)},
        [6] = {"colarroubado", math.random(3)},
        [7] = {"notebookroubado", math.random(4)},
        [8] = {"tabletroubado", math.random(5)},
        [9] = {"vibradorroubado", math.random(2)},
        [10] = {"carteiraroubada", math.random(3)},
        [11] = {"perfumeroubado", math.random(2)},
    },
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkPayment(house, mod, x, y, z)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local randlist = math.random(100)
        if randlist <= 74 then
            local randbox = math.random(200)
            if parseInt(randbox) <= 196 then
                local randitem = math.random(#itemlist[mod])
                vRP.giveInventoryItem(user_id, itemlist[mod][randitem][1], itemlist[mod][randitem][2])
                TriggerClientEvent("Notify", source, "sucesso", "Você encontrou <b>" .. itemlist[mod][randitem][2] .. "x " .. vRP.itemNameList(itemlist[mod][randitem][1]) .. "</b>.", 8000)
            end
        elseif randlist >= 75 and randlist <= 90 then
            TriggerClientEvent("Notify", source, "importante", "Compartimento vazio.", 8000)
        elseif randlist >= 91 then
            vRP.searchTimer(user_id, 600)
            TriggerClientEvent("vrp_sound:source", source, "alarm", 0.4)
            TriggerClientEvent("Notify", source, "aviso", "A polícia foi acionada", 8000)
            local policia = vRP.getUsersByPermission("policia.permissao")
            for k, v in pairs(policia) do
                local player = vRP.getUserSource(parseInt(v))
                if player then
                    async(function()
                        local ids = idgens:gen()
                        vRPclient.playSound(player, "Oneshot_Final", "MP_MISSION_COUNTDOWN_SOUNDSET")
                        blips[ids] = vRPclient.addBlip(player, x, y, z, 1, 59, "Roubo em andamento", 0.5, true)
                        TriggerClientEvent('chatMessage', player, "190", {65, 130, 255}, "O alarme da residência ^1" .. tostring(house) .. "^0 disparou, verifique o ocorrido.")
                        SetTimeout(30000, function()
                            idgens:free(ids)
                            vRPclient.removeBlip(player, blips[ids])
                            blips[ids] = nil
                        end)
                    end)
                end
            end

            local homeResult = vRP.query("homes/get_homepermissions", {home = tostring(house)})
            if homeResult[1] then
                for k, v in pairs(homeResult) do
                    local player = vRP.getUserSource(parseInt(v.user_id))
                    if player then
                        async(function()
                            TriggerClientEvent('chatMessage', player, "Dispatch", {65, 130, 255}, "O alarme da residência ^1" .. tostring(house) .. "^0 disparou, notifique as autoridades.")
                        end)
                    end
                end
            end
        end
    end
end
