local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local Tools = module("vrp", "lib/Tools")
emP = {}
Tunnel.bindInterface("boletim2", emP)

-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
function SendWebhookMessage(webhook, message)
    if webhook ~= nil and webhook ~= "" then
        PerformHttpRequest(webhook, function(err, text, headers)
        end, 'POST', json.encode({content = message}), {['Content-Type'] = 'application/json'})
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.BoletimFenix()
    local source = source
    local user_id = vRP.getUserId(source)
    local boletim = vRP.prompt(source, "Ocorrencia:", "")
    if boletim == "" then
        return
    end
    local identity = vRP.getUserIdentity(user_id)

    if FenixConf.Notificacao == "notify" then
        TriggerClientEvent("Notify", source, "sucesso", "Sua ocorrência foi registrada com sucesso!")
    elseif FenixConf.Notificacao == "chat" then
        TriggerClientEvent('chatMessage', source, "AVISO:", {29,185,84}, "Sua ocorrência foi registrada com sucesso!")
    end

    SendWebhookMessage(""..FenixConf.Webhook.."","Novo boletim registrado:```prolog\n[RG + NOME]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. "\n[TELEFONE]: " .. identity.phone .. "\n[OCORRENCIA]: '" .. boletim .. "'" .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```")
    
    local policia = vRP.getUsersByPermission(FenixConf.Permissao)
    for l, w in pairs(policia) do
        local player = vRP.getUserSource(parseInt(w))
        if player then
            async(function()
                vRPclient.playSound(player, "Oneshot_Final", "MP_MISSION_COUNTDOWN_SOUNDSET")
                TriggerClientEvent('chatMessage', player, "190", {65, 130, 255}, "Atenção: Novo Boletim de Ocorrência registrado na DP. Verifique no aplicativo na polícia.")
            end)
        end
    end

    return true
end
