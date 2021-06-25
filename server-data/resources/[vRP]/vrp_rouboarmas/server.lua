local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
func = {}
Tunnel.bindInterface("vrp_rouboarmas", func)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local idgens = Tools.newIDGenerator()
local blips = {}
local variavel1 = 0 
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookrouboarmas = "https://discordapp.com/api/webhooks/802605744967909387/usEM4UEaaZAfUxfUnW2w9q3RYsRWfXkaICVnDWktOcSjdjGT-q0wt0KWuCvyd_VCbjTa"

function SendWebhookMessage(webhook, message)
    if webhook ~= nil and webhook ~= "" then
        PerformHttpRequest(webhook, function(err, text, headers)
        end, 'POST', json.encode({content = message}), {['Content-Type'] = 'application/json'})
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ARMASLIST
-----------------------------------------------------------------------------------------------------------------------------------------

local armalist = {[1] = {['index'] = "wbody|WEAPON_PISTOL_MK2", ['qtd'] = 1, ['name'] = "FIVE SEVEN"}}

-----------------------------------------------------------------------------------------------------------------------------------------
-- TEMPO
-----------------------------------------------------------------------------------------------------------------------------------------
local timers = {}
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        for k, v in pairs(timers) do
            if v > 0 then
                timers[k] = v - 1
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkRobbery(id, x, y, z, head)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local crds = GetEntityCoords(GetPlayerPed(source))
    if user_id then
        local policia = vRP.getUsersByPermission("pmesp.permissao")
        if #policia >= 2 then
            if (os.time() - variavel1) < 2400 then
                TriggerClientEvent('Notify',source,"negado","Os cofres estão vazios, aguarde "..(2400 - (os.time() - variavel1)).." segundos!")
            else
                variavel1 = os.time()
                TriggerClientEvent('iniciandolojadearmas', source, head, x, y, z)
                vRPclient._playAnim(source, false, {{"oddjobs@shop_robbery@rob_till", "loop"}}, true)
                vRPclient.playSound(source, "Oneshot_Final", "MP_MISSION_COUNTDOWN_SOUNDSET")
                TriggerClientEvent("Notify", source, "aviso", "Corra, a polícia foi acionada!")
                vRPclient.setStandBY(source, parseInt(60))
                for l, w in pairs(policia) do
                    local player = vRP.getUserSource(parseInt(w))
                    if player then
                        async(function()
                            TriggerClientEvent('blip:criar:ammunation', player, x, y, z)
                            vRPclient.playSound(player, "Oneshot_Final", "MP_MISSION_COUNTDOWN_SOUNDSET")
                            TriggerClientEvent('chatMessage', player, "190", {65, 130, 255}, "O roubo começou na ^1Ammunation^0, dirija-se até o local e intercepte o assaltante.")
                            SetTimeout(20000, function()
                                TriggerClientEvent('blip:remover:ammunation', player)
                            end)
                        end)
                    end
                end
                SetTimeout(10000, function()
                    local qntdinheiro = math.random(100000, 150000)
                    vRP.antiflood(source, "roubos", 3)
                    vRP.giveInventoryItem(user_id, "dinheirosujo", qntdinheiro) -- Ajuste do pagamento em dinheiro sujo
                    TriggerClientEvent("Notify", source, "importante", "Você recebeu <b>" .. qntdinheiro .. "x</b> de dinheiro sujo", 8000)
                    SendWebhookMessage(webhookrouboarmas, "```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. "\n[ROUBOU]: Ammunation\n[RECOMPENSA]: R$ " .. vRP.format(parseInt(qntdinheiro)) .. "\n[COORDENADA]: " .. crds.x .. "," .. crds.y .. "," .. crds.z .. "" .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```")

                    local randlist = math.random(100)
                    if randlist >= 90 then
                        local randitem = math.random(#armalist)
                        vRP.giveInventoryItem(user_id, armalist[randitem].index, armalist[randitem].qtd)
                        TriggerClientEvent("Notify", source, "sucesso", "Você recebeu " .. armalist[randitem].qtd .. "x <b>" .. armalist[randitem].name .. "</b>.", 8000)
                    end
                end)
            end
        else
            TriggerClientEvent("Notify", source, "importante", "Número insuficiente de policiais no momento.", 8000)
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK PERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkPermission()
    local source = source
    local user_id = vRP.getUserId(source)
    return not (vRP.hasPermission(user_id, "policia.permissao") or vRP.hasPermission(user_id, "paramedico.permissao") or vRP.hasPermission(user_id, "paisanapolicia.permissao") or vRP.hasPermission(user_id, "paisanaparamedico.permissao"))
end
