local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("nav_producao-armas", oC)
local nomesnui = "fechar-nui"

-----------------------------------------------------------------------------------------------------------------------------------
-- [ WEBHOOK DISCORD ]-------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
-- local webhookprodarmas = "https://discord.com/api/webhooks/881292316894191636/WabSDknEiN1iRSPljfbCj41pSUex4qFLFwe1_CZFFzdydeYlyy39Gdi3lz83ipQzN9PP"

-- function SendWebhookMessage(webhook, message)
--     if webhook ~= nil and webhook ~= "" then
--         PerformHttpRequest(webhook, function(err, text, headers)
--         end, 'POST', json.encode({content = message}), {['Content-Type'] = 'application/json'})
--     end
-- end

-----------------------------------------------------------------------------------------------------------------------------------
-- [ ARRAY ]-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
local armas = {{item = "ak47"}, {item = "g36"}, {item = "mp5"}, {item = "fiveseven"}, {item = "hkp7m10"}, {item = "m-ak47"}, {item = "m-g36"}, {item = "m-mp5"}, {item = "m-fiveseven"}, {item = "m-hkp7m10"}}
-----------------------------------------------------------------------------------------------------------------------------------
-- [ EVENTOS ]---------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-arma")
AddEventHandler("produzir-arma", function(item)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local crds = GetEntityCoords(GetPlayerPed(source))
    if user_id then
        for k, v in pairs(armas) do
            if item == v.item then
                local itemupper = string.upper(item)

                ---------------------------
                -- PRODUÇÃO DA G36
                ---------------------------
                if item == "g36" then
                    if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("wbody|WEAPON_SPECIALCARBINE_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id, "corpodeg36") >= 1 and vRP.getInventoryItemAmount(user_id, "placademetal") >= 150 and vRP.getInventoryItemAmount(user_id, "mola") >= 25 and vRP.getInventoryItemAmount(user_id, "gatilho") >= 1 then
                            if vRP.tryGetInventoryItem(user_id, "corpodeg36", 1) and vRP.tryGetInventoryItem(user_id, "placademetal", 150) and vRP.tryGetInventoryItem(user_id, "mola", 25) and vRP.tryGetInventoryItem(user_id, "gatilho", 1) then
                                TriggerClientEvent(nomesnui, source) --------- trocar quando duplicar
                                TriggerClientEvent("progress", source, 10000, "Montando " .. itemupper .. "")
                                vRPclient._playAnim(source, false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true)
                                SetTimeout(10000, function()
                                    vRPclient._stopAnim(source, false)
                                    vRP.giveInventoryItem(user_id, "wbody|WEAPON_SPECIALCARBINE_MK2", 1)
                                    TriggerClientEvent("Notify", source, "sucesso", "Você montou uma <b>" .. itemupper .. "</b>.")
                                    vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[PRODUZIU]: " .. itemupper .. "\n[COORDENADA]: " .. crds.x .. "," .. crds.y .. "," .. crds.z .. "" .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. "```", "PRODUCAO_ARMA")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify", source, "negado", "Materiais insuficientes!")
                        end
                    else
                        TriggerClientEvent("Notify", source, "negado", "Espaço insuficiente na mochila.")
                    end

                    ---------------------------
                    -- PRODUÇÃO DA AK-47
                    ---------------------------
                elseif item == "ak47" then
                    if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("wbody|WEAPON_ASSAULTRIFLE_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id, "corpodeak") >= 1 and vRP.getInventoryItemAmount(user_id, "placademetal") >= 140 and vRP.getInventoryItemAmount(user_id, "mola") >= 15 and vRP.getInventoryItemAmount(user_id, "gatilho") >= 1 then
                            if vRP.tryGetInventoryItem(user_id, "corpodeak", 1) and vRP.tryGetInventoryItem(user_id, "placademetal", 140) and vRP.tryGetInventoryItem(user_id, "mola", 15) and vRP.tryGetInventoryItem(user_id, "gatilho", 1) then
                                TriggerClientEvent(nomesnui, source) --------- trocar quando duplicar
                                TriggerClientEvent("progress", source, 10000, "Montando " .. itemupper .. "")
                                vRPclient._playAnim(source, false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true)
                                SetTimeout(10000, function()
                                    vRPclient._stopAnim(source, false)
                                    vRP.giveInventoryItem(user_id, "wbody|WEAPON_ASSAULTRIFLE_MK2", 1)
                                    TriggerClientEvent("Notify", source, "sucesso", "Você montou uma <b>" .. itemupper .. "</b>.")
                                    vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[PRODUZIU]: " .. itemupper .. "\n[COORDENADA]: " .. crds.x .. "," .. crds.y .. "," .. crds.z .. "" .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. "```", "PRODUCAO_ARMA")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify", source, "negado", "Materiais insuficientes!")
                        end
                    else
                        TriggerClientEvent("Notify", source, "negado", "Espaço insuficiente na mochila.")
                    end

                    ---------------------------
                    -- PRODUÇÃO DA MP5
                    ---------------------------
                elseif item == "mp5" then
                    if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("wbody|WEAPON_SMG_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id, "corpodemp5") >= 1 and vRP.getInventoryItemAmount(user_id, "placademetal") >= 80 and vRP.getInventoryItemAmount(user_id, "mola") >= 10 and vRP.getInventoryItemAmount(user_id, "gatilho") >= 1 then
                            if vRP.tryGetInventoryItem(user_id, "corpodemp5", 1) and vRP.tryGetInventoryItem(user_id, "placademetal", 80) and vRP.tryGetInventoryItem(user_id, "mola", 10) and vRP.tryGetInventoryItem(user_id, "gatilho", 1) then
                                TriggerClientEvent(nomesnui, source) --------- trocar quando duplicar
                                TriggerClientEvent("progress", source, 10000, "Montando " .. itemupper .. "")
                                vRPclient._playAnim(source, false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true)
                                SetTimeout(10000, function()
                                    vRPclient._stopAnim(source, false)
                                    vRP.giveInventoryItem(user_id, "wbody|WEAPON_SMG_MK2", 1)
                                    local itemupper = string.upper(item)
                                    TriggerClientEvent("Notify", source, "sucesso", "Você montou uma <b>" .. itemupper .. "</b>.")
                                    vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[PRODUZIU]: " .. itemupper .. "\n[COORDENADA]: " .. crds.x .. "," .. crds.y .. "," .. crds.z .. "" .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. "```", "PRODUCAO_ARMA")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify", source, "negado", "Materiais insuficientes!")
                        end
                    else
                        TriggerClientEvent("Notify", source, "negado", "Espaço insuficiente na mochila.")
                    end

                    ---------------------------
                    -- PRODUÇÃO DA FIVE SEVEN
                    ---------------------------
                elseif item == "fiveseven" then
                    if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("wbody|WEAPON_PISTOL_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id, "corpodefiveseven") >= 1 and vRP.getInventoryItemAmount(user_id, "placademetal") >= 40 and vRP.getInventoryItemAmount(user_id, "mola") >= 15 and vRP.getInventoryItemAmount(user_id, "gatilho") >= 1 then
                            if vRP.tryGetInventoryItem(user_id, "corpodefiveseven", 1) and vRP.tryGetInventoryItem(user_id, "placademetal", 40) and vRP.tryGetInventoryItem(user_id, "mola", 15) and vRP.tryGetInventoryItem(user_id, "gatilho", 1) then
                                TriggerClientEvent(nomesnui, source) --------- trocar quando duplicar
                                TriggerClientEvent("progress", source, 10000, "Montando " .. itemupper .. "")
                                vRPclient._playAnim(source, false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true)
                                SetTimeout(10000, function()
                                    vRPclient._stopAnim(source, false)
                                    vRP.giveInventoryItem(user_id, "wbody|WEAPON_PISTOL_MK2", 1)
                                    local itemupper = string.upper(item)
                                    TriggerClientEvent("Notify", source, "sucesso", "Você montou uma <b>" .. itemupper .. "</b>.")
                                    vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[PRODUZIU]: " .. itemupper .. "\n[COORDENADA]: " .. crds.x .. "," .. crds.y .. "," .. crds.z .. "" .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. "```", "PRODUCAO_ARMA")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify", source, "negado", "Materiais insuficientes!")
                        end
                    else
                        TriggerClientEvent("Notify", source, "negado", "Espaço insuficiente na mochila.")
                    end

                    ---------------------------
                    -- PRODUÇÃO DA HK P7M10
                    ---------------------------
                elseif item == "hkp7m10" then
                    if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("wbody|WEAPON_SNSPISTOL") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id, "corpodehkp7m10") >= 1 and vRP.getInventoryItemAmount(user_id, "placademetal") >= 25 and vRP.getInventoryItemAmount(user_id, "mola") >= 2 and vRP.getInventoryItemAmount(user_id, "gatilho") >= 1 then
                            if vRP.tryGetInventoryItem(user_id, "corpodehkp7m10", 1) and vRP.tryGetInventoryItem(user_id, "placademetal", 25) and vRP.tryGetInventoryItem(user_id, "mola", 2) and vRP.tryGetInventoryItem(user_id, "gatilho", 1) then
                                TriggerClientEvent(nomesnui, source) --------- trocar quando duplicar
                                TriggerClientEvent("progress", source, 10000, "Montando " .. itemupper .. "")
                                vRPclient._playAnim(source, false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true)
                                SetTimeout(10000, function()
                                    vRPclient._stopAnim(source, false)
                                    vRP.giveInventoryItem(user_id, "wbody|WEAPON_SNSPISTOL", 1)
                                    local itemupper = string.upper(item)
                                    TriggerClientEvent("Notify", source, "sucesso", "Você montou uma <b>" .. itemupper .. "</b>.")
                                    vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[PRODUZIU]: " .. itemupper .. "\n[COORDENADA]: " .. crds.x .. "," .. crds.y .. "," .. crds.z .. "" .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. "```", "PRODUCAO_ARMA")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify", source, "negado", "Materiais insuficientes!")
                        end
                    else
                        TriggerClientEvent("Notify", source, "negado", "Espaço insuficiente na mochila.")
                    end

                    ---------------------------
                    -- PRODUÇÃO MUNIÇÃO G36
                    ---------------------------
                elseif item == "m-g36" then
                    if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("wammo|WEAPON_SPECIALCARBINE_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id, "capsula") >= 50 and vRP.getInventoryItemAmount(user_id, "polvora") >= 50 then
                            if vRP.tryGetInventoryItem(user_id, "capsula", 50) and vRP.tryGetInventoryItem(user_id, "polvora", 50) then
                                TriggerClientEvent(nomesnui, source) --------- trocar quando duplicar
                                TriggerClientEvent("progress", source, 10000, "Montando " .. itemupper .. "")
                                vRPclient._playAnim(source, false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true)
                                SetTimeout(10000, function()
                                    vRPclient._stopAnim(source, false)
                                    vRP.giveInventoryItem(user_id, "wammo|WEAPON_SPECIALCARBINE_MK2", 50)
                                    TriggerClientEvent("Notify", source, "sucesso", "Você produziu <b>" .. itemupper .. "</b>")
                                    vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[PRODUZIU]: 50x " .. itemupper .. "\n[COORDENADA]: " .. crds.x .. "," .. crds.y .. "," .. crds.z .. "" .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. "```", "PRODUCAO_ARMA")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify", source, "negado", "Materiais insuficientes!")
                        end
                    else
                        TriggerClientEvent("Notify", source, "negado", "Espaço insuficiente na mochila.")
                    end

                    ---------------------------
                    -- PRODUÇÃO MUNIÇÃO AK-47
                    ---------------------------
                elseif item == "m-ak47" then
                    if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("wammo|WEAPON_ASSAULTRIFLE_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id, "capsula") >= 50 and vRP.getInventoryItemAmount(user_id, "polvora") >= 50 then
                            if vRP.tryGetInventoryItem(user_id, "capsula", 50) and vRP.tryGetInventoryItem(user_id, "polvora", 50) then
                                TriggerClientEvent(nomesnui, source) --------- trocar quando duplicar
                                TriggerClientEvent("progress", source, 10000, "Montando " .. itemupper .. "")
                                vRPclient._playAnim(source, false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true)
                                SetTimeout(10000, function()
                                    vRPclient._stopAnim(source, false)
                                    vRP.giveInventoryItem(user_id, "wammo|WEAPON_ASSAULTRIFLE_MK2", 50)
                                    TriggerClientEvent("Notify", source, "sucesso", "Você produziu <b>" .. itemupper .. "</b>")
                                    vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[PRODUZIU]: 50x " .. itemupper .. "\n[COORDENADA]: " .. crds.x .. "," .. crds.y .. "," .. crds.z .. "" .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. "```", "PRODUCAO_ARMA")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify", source, "negado", "Materiais insuficientes!")
                        end
                    else
                        TriggerClientEvent("Notify", source, "negado", "Espaço insuficiente na mochila.")
                    end

                    ---------------------------
                    -- PRODUÇÃO MUNIÇÃO MP5
                    ---------------------------
                elseif item == "m-mp5" then
                    if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("wammo|WEAPON_SMG_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id, "capsula") >= 50 and vRP.getInventoryItemAmount(user_id, "polvora") >= 50 then
                            if vRP.tryGetInventoryItem(user_id, "capsula", 50) and vRP.tryGetInventoryItem(user_id, "polvora", 50) then
                                TriggerClientEvent(nomesnui, source) --------- trocar quando duplicar
                                TriggerClientEvent("progress", source, 10000, "Montando " .. itemupper .. "")
                                vRPclient._playAnim(source, false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true)
                                SetTimeout(10000, function()
                                    vRPclient._stopAnim(source, false)
                                    vRP.giveInventoryItem(user_id, "wammo|WEAPON_SMG_MK2", 50)
                                    local itemupper = string.upper(item)
                                    TriggerClientEvent("Notify", source, "sucesso", "Você produziu <b>" .. itemupper .. "</b>")
                                    vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[PRODUZIU]: 50x " .. itemupper .. "\n[COORDENADA]: " .. crds.x .. "," .. crds.y .. "," .. crds.z .. "" .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. "```", "PRODUCAO_ARMA")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify", source, "negado", "Materiais insuficientes!")
                        end
                    else
                        TriggerClientEvent("Notify", source, "negado", "Espaço insuficiente na mochila.")
                    end

                    ---------------------------
                    -- PRODUÇÃO MUNIÇÃO HK P7M10
                    ---------------------------
                elseif item == "m-hkp7m10" then
                    if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("wammo|WEAPON_SNSPISTOL") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id, "capsula") >= 50 and vRP.getInventoryItemAmount(user_id, "polvora") >= 50 then
                            if vRP.tryGetInventoryItem(user_id, "capsula", 50) and vRP.tryGetInventoryItem(user_id, "polvora", 50) then
                                TriggerClientEvent(nomesnui, source) --------- trocar quando duplicar
                                TriggerClientEvent("progress", source, 10000, "Montando " .. itemupper .. "")
                                vRPclient._playAnim(source, false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true)
                                SetTimeout(10000, function()
                                    vRPclient._stopAnim(source, false)
                                    vRP.giveInventoryItem(user_id, "wammo|WEAPON_SNSPISTOL", 50)
                                    local itemupper = string.upper(item)
                                    TriggerClientEvent("Notify", source, "sucesso", "Você produziu <b>" .. itemupper .. "</b>")
                                    vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[PRODUZIU]: 50x " .. itemupper .. "\n[COORDENADA]: " .. crds.x .. "," .. crds.y .. "," .. crds.z .. "" .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. "```", "PRODUCAO_ARMA")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify", source, "negado", "Materiais insuficientes!")
                        end
                    else
                        TriggerClientEvent("Notify", source, "negado", "Espaço insuficiente na mochila.")
                    end

                    ---------------------------
                    -- PRODUÇÃO MUNIÇÃO FIVE SEVEN
                    ---------------------------
                elseif item == "m-fiveseven" then
                    if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("wammo|WEAPON_PISTOL_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id, "capsula") >= 50 and vRP.getInventoryItemAmount(user_id, "polvora") >= 50 then
                            if vRP.tryGetInventoryItem(user_id, "capsula", 50) and vRP.tryGetInventoryItem(user_id, "polvora", 50) then
                                TriggerClientEvent(nomesnui, source) --------- trocar quando duplicar
                                TriggerClientEvent("progress", source, 10000, "Montando " .. itemupper .. "")
                                vRPclient._playAnim(source, false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true)
                                SetTimeout(10000, function()
                                    vRPclient._stopAnim(source, false)
                                    vRP.giveInventoryItem(user_id, "wammo|WEAPON_PISTOL_MK2", 50)
                                    local itemupper = string.upper(item)
                                    TriggerClientEvent("Notify", source, "sucesso", "Você produziu <b>" .. itemupper .. "</b>")
                                    vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[PRODUZIU]: 50x " .. itemupper .. "\n[COORDENADA]: " .. crds.x .. "," .. crds.y .. "," .. crds.z .. "" .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. "```", "PRODUCAO_ARMA")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify", source, "negado", "Materiais insuficientes!")
                        end
                    else
                        TriggerClientEvent("Notify", source, "negado", "Espaço insuficiente na mochila.")
                    end

                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------
-- [ FUNÇÃO DE PERMISSÃO ]----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
function oC.checkPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "yakuza.permissao") or vRP.hasPermission(user_id, "cn.permissao") or vRP.hasPermission(user_id, "sinaloa.permissao") or vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "founder.permissao") then
        return true
    end
end
