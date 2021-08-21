local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("nav_contrabando", oC)
local nomesnui = "fechar-nui-contrabando"

-----------------------------------------------------------------------------------------------------------------------------------------
-- [ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local armas = {{item = "c4"}, {item = "gps"}, {item = "corda"}, {item = "placa"}, {item = "algemas"}, {item = "capuz"}, {item = "lockpick"}, {item = "cartaoinvasao"}, {item = "ticketpvp"}}
-----------------------------------------------------------------------------------------------------------------------------------
-- [ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-contrabando")
AddEventHandler("produzir-contrabando", function(item)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        for k, v in pairs(armas) do
            if item == v.item then
                local itemupper = string.upper(item)

                ---------------------------
                -- PRODUÇÃO C4
                ---------------------------
                if item == "c4" then
                    if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("c4") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id, "componentemetal") >= 12 and vRP.getInventoryItemAmount(user_id, "componenteplastico") >= 16 and vRP.getInventoryItemAmount(user_id, "componenteeletronico") >= 20 and vRP.getInventoryItemAmount(user_id, "dinheirosujo") >= 44000 then
                            if vRP.tryGetInventoryItem(user_id, "componentemetal", 12) and vRP.tryGetInventoryItem(user_id, "componenteplastico", 16) and vRP.tryGetInventoryItem(user_id, "componenteeletronico", 20) and vRP.tryGetInventoryItem(user_id, "dinheirosujo", 44000) then
                                TriggerClientEvent(nomesnui, source) --------- trocar quando duplicar
                                TriggerClientEvent("progress", source, 10000, "Montando " .. itemupper .. "")
                                vRPclient._playAnim(source, false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true)
                                SetTimeout(10000, function()
                                    vRPclient._stopAnim(source, false)
                                    vRP.giveInventoryItem(user_id, "c4", 1)
                                    TriggerClientEvent("Notify", source, "sucesso", "Você produziu <b>" .. itemupper .. "</b>.")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify", source, "negado", "Materiais insuficientes!")
                        end
                    else
                        TriggerClientEvent("Notify", source, "negado", "Espaço insuficiente na mochila.")
                    end

                ---------------------------
                -- PRODUÇÃO GPS
                ---------------------------
                elseif item == "gps" then
                    if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("gps") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id, "dinheirosujo") >= 10000 then
                            if vRP.tryGetInventoryItem(user_id, "dinheirosujo", 10000) then
                                TriggerClientEvent(nomesnui, source) --------- trocar quando duplicar
                                TriggerClientEvent("progress", source, 10000, "Montando " .. itemupper .. "")
                                vRPclient._playAnim(source, false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true)
                                SetTimeout(10000, function()
                                    vRPclient._stopAnim(source, false)
                                    vRP.giveInventoryItem(user_id, "gps", 1)
                                    TriggerClientEvent("Notify", source, "sucesso", "Você produziu <b>" .. itemupper .. "</b>.")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify", source, "negado", "Materiais insuficientes!")
                        end
                    else
                        TriggerClientEvent("Notify", source, "negado", "Espaço insuficiente na mochila.")
                    end

                ---------------------------
                -- PRODUÇÃO TICKET PVP
                ---------------------------
                elseif item == "ticketpvp" then
                    if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("ticketpvp") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id, "dinheirosujo") >= 20000 then
                            if vRP.tryGetInventoryItem(user_id, "dinheirosujo", 20000) then
                                TriggerClientEvent(nomesnui, source) --------- trocar quando duplicar
                                TriggerClientEvent("progress", source, 10000, "Montando " .. itemupper .. "")
                                vRPclient._playAnim(source, false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true)
                                SetTimeout(10000, function()
                                    vRPclient._stopAnim(source, false)
                                    vRP.giveInventoryItem(user_id, "ticketpvp", 1)
                                    TriggerClientEvent("Notify", source, "sucesso", "Você produziu <b>" .. itemupper .. "</b>.")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify", source, "negado", "Materiais insuficientes!")
                        end
                    else
                        TriggerClientEvent("Notify", source, "negado", "Espaço insuficiente na mochila.")
                    end

                ---------------------------
                -- PRODUÇÃO CORDA
                ---------------------------
                elseif item == "corda" then
                    if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("gps") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id, "dinheirosujo") >= 50000 then
                            if vRP.tryGetInventoryItem(user_id, "dinheirosujo", 50000) then
                                TriggerClientEvent(nomesnui, source) --------- trocar quando duplicar
                                TriggerClientEvent("progress", source, 10000, "Montando " .. itemupper .. "")
                                vRPclient._playAnim(source, false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true)
                                SetTimeout(10000, function()
                                    vRPclient._stopAnim(source, false)
                                    vRP.giveInventoryItem(user_id, "corda", 1)
                                    TriggerClientEvent("Notify", source, "sucesso", "Você produziu <b>" .. itemupper .. "</b>.")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify", source, "negado", "Materiais insuficientes!")
                        end
                    else
                        TriggerClientEvent("Notify", source, "negado", "Espaço insuficiente na mochila.")
                    end

                ---------------------------
                -- PRODUÇÃO PLACA
                ---------------------------
                elseif item == "placa" then
                    if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("placa") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id, "componentemetal") >= 2 and vRP.getInventoryItemAmount(user_id, "componenteplastico") >= 8 and vRP.getInventoryItemAmount(user_id, "dinheirosujo") >= 10000 then
                            if vRP.tryGetInventoryItem(user_id, "componentemetal", 2) and vRP.tryGetInventoryItem(user_id, "componenteplastico", 8) and vRP.tryGetInventoryItem(user_id, "dinheirosujo", 10000) then
                                TriggerClientEvent(nomesnui, source) --------- trocar quando duplicar
                                TriggerClientEvent("progress", source, 10000, "Montando " .. itemupper .. "")
                                vRPclient._playAnim(source, false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true)
                                SetTimeout(10000, function()
                                    vRPclient._stopAnim(source, false)
                                    vRP.giveInventoryItem(user_id, "placa", 1)
                                    TriggerClientEvent("Notify", source, "sucesso", "Você produziu <b>" .. itemupper .. "</b>.")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify", source, "negado", "Materiais insuficientes!")
                        end
                    else
                        TriggerClientEvent("Notify", source, "negado", "Espaço insuficiente na mochila.")
                    end

                ---------------------------
                -- PRODUÇÃO ALGEMAS
                ---------------------------
                elseif item == "algemas" then
                    if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("algemas") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id, "componentemetal") >= 18 and vRP.getInventoryItemAmount(user_id, "dinheirosujo") >= 25000 then
                            if vRP.tryGetInventoryItem(user_id, "componentemetal", 18) and vRP.tryGetInventoryItem(user_id, "dinheirosujo", 25000) then
                                TriggerClientEvent(nomesnui, source) --------- trocar quando duplicar
                                TriggerClientEvent("progress", source, 10000, "Montando " .. itemupper .. "")
                                vRPclient._playAnim(source, false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true)
                                SetTimeout(10000, function()
                                    vRPclient._stopAnim(source, false)
                                    vRP.giveInventoryItem(user_id, "algemas", 1)
                                    TriggerClientEvent("Notify", source, "sucesso", "Você produziu <b>" .. itemupper .. "</b>.")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify", source, "negado", "Materiais insuficientes!")
                        end
                    else
                        TriggerClientEvent("Notify", source, "negado", "Espaço insuficiente na mochila.")
                    end

                ---------------------------
                -- PRODUÇÃO CAPUZ
                ---------------------------
                elseif item == "capuz" then
                    if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("capuz") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id, "componenteplastico") >= 18 and vRP.getInventoryItemAmount(user_id, "dinheirosujo") >= 25000 then
                            if vRP.tryGetInventoryItem(user_id, "componenteplastico", 18) and vRP.tryGetInventoryItem(user_id, "dinheirosujo", 25000) then
                                TriggerClientEvent(nomesnui, source) --------- trocar quando duplicar
                                TriggerClientEvent("progress", source, 10000, "Montando " .. itemupper .. "")
                                vRPclient._playAnim(source, false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true)
                                SetTimeout(10000, function()
                                    vRPclient._stopAnim(source, false)
                                    vRP.giveInventoryItem(user_id, "capuz", 1)
                                    TriggerClientEvent("Notify", source, "sucesso", "Você produziu <b>" .. itemupper .. "</b>.")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify", source, "negado", "Materiais insuficientes!")
                        end
                    else
                        TriggerClientEvent("Notify", source, "negado", "Espaço insuficiente na mochila.")
                    end

                ---------------------------
                -- PRODUÇÃO LOCKPICK
                ---------------------------
                elseif item == "lockpick" then
                    if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("lockpick") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id, "componentemetal") >= 10 and vRP.getInventoryItemAmount(user_id, "dinheirosujo") >= 15000 then
                            if vRP.tryGetInventoryItem(user_id, "componentemetal", 10) and vRP.tryGetInventoryItem(user_id, "dinheirosujo", 15000) then
                                TriggerClientEvent(nomesnui, source) --------- trocar quando duplicar
                                TriggerClientEvent("progress", source, 10000, "Montando " .. itemupper .. "")
                                vRPclient._playAnim(source, false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true)
                                SetTimeout(10000, function()
                                    vRPclient._stopAnim(source, false)
                                    vRP.giveInventoryItem(user_id, "lockpick", 1)
                                    TriggerClientEvent("Notify", source, "sucesso", "Você produziu <b>" .. itemupper .. "</b>.")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify", source, "negado", "Materiais insuficientes!")
                        end
                    else
                        TriggerClientEvent("Notify", source, "negado", "Espaço insuficiente na mochila.")
                    end

                ---------------------------
                -- PRODUÇÃO CARTÃO INVASÃO
                ---------------------------
                elseif item == "cartaoinvasao" then
                    if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("cartaoinvasao") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id, "componenteplastico") >= 8 and vRP.getInventoryItemAmount(user_id, "componenteeletronico") >= 14 and vRP.getInventoryItemAmount(user_id, "dinheirosujo") >= 35000 then
                            if vRP.tryGetInventoryItem(user_id, "componenteplastico", 8) and vRP.tryGetInventoryItem(user_id, "componenteeletronico", 14) and vRP.tryGetInventoryItem(user_id, "dinheirosujo", 35000) then
                                TriggerClientEvent(nomesnui, source) --------- trocar quando duplicar
                                TriggerClientEvent("progress", source, 10000, "Montando " .. itemupper .. "")
                                vRPclient._playAnim(source, false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true)
                                SetTimeout(10000, function()
                                    vRPclient._stopAnim(source, false)
                                    vRP.giveInventoryItem(user_id, "cartaoinvasao", 1)
                                    TriggerClientEvent("Notify", source, "sucesso", "Você produziu <b>" .. itemupper .. "</b>.")
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
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "bratva.permissao") then
        return true
    end
end
