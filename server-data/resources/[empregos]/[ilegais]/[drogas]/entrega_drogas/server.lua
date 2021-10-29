local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

emP = {}
Tunnel.bindInterface("entrega_drogas", emP)
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
-- local webhookdrugs = "https://discord.com/api/webhooks/809579295349145610/30Zfxmd1nI3dUyyzOZjfelizGlBi8lYqLtWJ_TlZxEIt--rKPMUimmFeglKwtXnG9bHi"

-- function SendWebhookMessage(webhook, message)
--     if webhook ~= nil and webhook ~= "" then
--         PerformHttpRequest(webhook, function(err, text, headers)
--         end, 'POST', json.encode({content = message}), {['Content-Type'] = 'application/json'})
--     end
-- end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.hasPermission(user_id, "verdes.permissao") or vRP.hasPermission(user_id, "vermelhos.permissao") or vRP.hasPermission(user_id, "roxos.permissao") or vRP.hasPermission(user_id, "laranjas.permissao")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO CIVIL
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
    vRP.antiflood(source, "entrega_drogas", 5)
    local source = source
    local user_id = vRP.getUserId(source)
    local policia = vRP.getUsersByPermission("policia.permissao")
    local bonus = 0

    if #policia == 0 then
        bonus = 1600 -- R$ 4.800 Total
    elseif #policia >= 1 and #policia <= 3 then
        bonus = 2000 -- R$ 6.000 Total
    elseif #policia >= 4 and #policia <= 7 then
        bonus = 3000 -- R$ 9.000 Total
    elseif #policia >= 8 then
        bonus = 4000 -- R$ 12.000 Total
    end

    if user_id then
        maconha = false
        cocaina = false
        metanfetamina = false
        heroina = false

        if vRP.getInventoryItemAmount(user_id, "maconha") >= 1 then
            maconha = true
        end
        if vRP.getInventoryItemAmount(user_id, "cocaina") >= 1 then
            cocaina = true
        end
        if vRP.getInventoryItemAmount(user_id, "metanfetamina") >= 1 then
            metanfetamina = true
        end
        if vRP.getInventoryItemAmount(user_id, "heroina") >= 1 then
            heroina = true
        end

        if maconha and cocaina and metanfetamina and heroina then
            vRP.tryGetInventoryItem(user_id, "maconha", 1)
            vRP.giveInventoryItem(user_id, "dinheirosujo", (parseInt(0) + bonus) * 1)

            vRP.tryGetInventoryItem(user_id, "cocaina", 1)
            vRP.giveInventoryItem(user_id, "dinheirosujo", (parseInt(0) + bonus) * 1)

            vRP.tryGetInventoryItem(user_id, "heroina", 1)
            vRP.giveInventoryItem(user_id, "dinheirosujo", (parseInt(0) + bonus) * 1)

            vRP.tryGetInventoryItem(user_id, "metanfetamina", 1)
            vRP.giveInventoryItem(user_id, "dinheirosujo", (parseInt(0) + bonus) * 1)
            return true
        end

        if maconha then
            if vRP.getInventoryItemAmount(user_id, "maconha") >= 3 then
                vRP.tryGetInventoryItem(user_id, "maconha", 3)
                vRP.giveInventoryItem(user_id, "dinheirosujo", (parseInt(0) + bonus) * 3)
                return true
            end
        end
        if heroina then
            if vRP.getInventoryItemAmount(user_id, "heroina") >= 3 then
                vRP.tryGetInventoryItem(user_id, "heroina", 3)
                vRP.giveInventoryItem(user_id, "dinheirosujo", (parseInt(0) + bonus) * 3)
                return true
            end
        end
        if cocaina then
            if vRP.getInventoryItemAmount(user_id, "cocaina") >= 3 then
                vRP.tryGetInventoryItem(user_id, "cocaina", 3)
                vRP.giveInventoryItem(user_id, "dinheirosujo", (parseInt(0) + bonus) * 3)
                return true
            end
        end
        if metanfetamina then
            if vRP.getInventoryItemAmount(user_id, "metanfetamina") >= 3 then
                vRP.tryGetInventoryItem(user_id, "metanfetamina", 3)
                vRP.giveInventoryItem(user_id, "dinheirosujo", (parseInt(0) + bonus) * 3)
                return true
            end
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICIA
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
function emP.MarcarOcorrencia(id,x,y,z)
    local source = source
    local user_id = vRP.getUserId(source)
    local x, y, z = vRPclient.getPosition(source)
    local identity = vRP.getUserIdentity(user_id)
    local crds = GetEntityCoords(GetPlayerPed(source))

    -- local chance = 0
    -- local chance = math.random(1,10)

    -- if chance > 7 then
    --     return
    -- end

    if user_id then
        local policia = vRP.getUsersByPermission("policia.permissao")
        for l, w in pairs(policia) do
            local player = vRP.getUserSource(parseInt(w))
            if player then
                async(function()
                    TriggerClientEvent('blip:criar:traficodrogas', player, x, y, z)
                    vRPclient.playSound(player, "Oneshot_Final", "MP_MISSION_COUNTDOWN_SOUNDSET")
                    TriggerClientEvent("Notify", player, "policia", "Recebemos uma <b>denuncia de tráfico</b>, verifique o ocorrido.", 20000)
                    TriggerClientEvent('chatMessage', player, "CENTRAL:",{65,130,255}, "Recebemos uma denuncia de tráfico, verifique o ocorrido.")
                    SetTimeout(20000, function()
                        TriggerClientEvent('blip:remover:traficodrogas', player)
                    end)
                end)
            end
        end
        -- for l, w in pairs(soldado) do
        --     local player = vRP.getUserSource(parseInt(w))
        --     if player then
        --         async(function()
        --             local id = idgens:gen()
        --             blips[id] = vRPclient.addBlip(player, x, y, z, 10, 84, "Ocorrência", 0.5, false)
        --             vRPclient._playSound(player, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET")
        --             TriggerClientEvent("Notify", player, "policia", "Recebemos uma <b>denuncia de tráfico</b>, verifique o ocorrido.", 20000)
        --             TriggerClientEvent('chatMessage', player, "CENTRAL:",{65,130,255}, "Recebemos uma denuncia de tráfico, verifique o ocorrido.")
        --             SetTimeout(20000, function()
        --                 vRPclient.removeBlip(player, blips[id])
        --                 idgens:free(id)
        --             end)
        --         end)
        --     end
        -- end
        TriggerClientEvent("Notify", source, "aviso", "Corra, a polícia foi acionada!")
        vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[FOI DENUNCIADO]\n[COORDENADA]: " .. crds.x .. "," .. crds.y .. "," .. crds.z .. "" .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "ENTREGA_DROGAS")
    end
end
