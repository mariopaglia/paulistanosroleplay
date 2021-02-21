local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("nav_producao-municao",oC)
local nomesnui = "fechar-nui-municao"

-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local listaitens = {
	{ item = "m-ak47" },
	{ item = "m-g36" },
	{ item = "m-mp5" },
	{ item = "m-fiveseven" },
	{ item = "colete" }
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-municao")
AddEventHandler("produzir-municao",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(listaitens) do
            if item == v.item then
            local itemupper = string.upper(item)

                ---------------------------
                -- PRODUÇÃO MUNIÇÃO G36
                ---------------------------
                if item == "m-g36" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_SPECIALCARBINE_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsula") >= 250 and vRP.getInventoryItemAmount(user_id,"polvora") >= 500 then
                            if vRP.tryGetInventoryItem(user_id,"capsula",250) and vRP.tryGetInventoryItem(user_id,"polvora",500) then
                                TriggerClientEvent(nomesnui,source) --------- trocar quando duplicar
                                TriggerClientEvent("progress",source,10000,"Montando "..itemupper.."")
                                vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                SetTimeout(10000,function()
                                    vRPclient._stopAnim(source,false)
                                    vRP.giveInventoryItem(user_id,"wammo|WEAPON_SPECIALCARBINE_MK2",250)
                                    TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>"..itemupper.."</b>")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Materiais insuficientes!")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                
                ---------------------------
                -- PRODUÇÃO MUNIÇÃO AK-47
                ---------------------------
                elseif item == "m-ak47" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_ASSAULTRIFLE_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsula") >= 250 and vRP.getInventoryItemAmount(user_id,"polvora") >= 375 then
                            if vRP.tryGetInventoryItem(user_id,"capsula",250) and vRP.tryGetInventoryItem(user_id,"polvora",375) then
                                TriggerClientEvent(nomesnui,source) --------- trocar quando duplicar
                                TriggerClientEvent("progress",source,10000,"Montando "..itemupper.."")
                                vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                SetTimeout(10000,function()
                                    vRPclient._stopAnim(source,false)
                                    vRP.giveInventoryItem(user_id,"wammo|WEAPON_ASSAULTRIFLE_MK2",250)
                                    TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>"..itemupper.."</b>")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Materiais insuficientes!")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end


                ---------------------------
                -- PRODUÇÃO MUNIÇÃO MP5
                ---------------------------
                elseif item == "m-mp5" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_SMG_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsula") >= 250 and vRP.getInventoryItemAmount(user_id,"polvora") >= 250 then
                            if vRP.tryGetInventoryItem(user_id,"capsula",250) and vRP.tryGetInventoryItem(user_id,"polvora",250) then
                                TriggerClientEvent(nomesnui,source) --------- trocar quando duplicar
                                TriggerClientEvent("progress",source,10000,"Montando "..itemupper.."")
                                vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                SetTimeout(10000,function()
                                    vRPclient._stopAnim(source,false)
                                    vRP.giveInventoryItem(user_id,"wammo|WEAPON_SMG_MK2",250)
                                    local itemupper = string.upper(item)
                                    TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>"..itemupper.."</b>")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Materiais insuficientes!")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

                ---------------------------
                -- PRODUÇÃO MUNIÇÃO FIVE SEVEN
                ---------------------------
                elseif item == "m-fiveseven" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_PISTOL_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsula") >= 50 and vRP.getInventoryItemAmount(user_id,"polvora") >= 125 then
                            if vRP.tryGetInventoryItem(user_id,"capsula",50) and vRP.tryGetInventoryItem(user_id,"polvora",125) then
                                TriggerClientEvent(nomesnui,source) --------- trocar quando duplicar
                                TriggerClientEvent("progress",source,10000,"Montando "..itemupper.."")
                                vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                SetTimeout(10000,function()
                                    vRPclient._stopAnim(source,false)
                                    vRP.giveInventoryItem(user_id,"wammo|WEAPON_PISTOL_MK2",50)
                                    local itemupper = string.upper(item)
                                    TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>"..itemupper.."</b>")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Materiais insuficientes!")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

                ---------------------------
                -- PRODUÇÃO COLETE
                ---------------------------
                elseif item == "colete" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("colete") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"tecido") >= 20 and vRP.getInventoryItemAmount(user_id,"linha") >= 20 then
                            if vRP.tryGetInventoryItem(user_id,"tecido",20) and vRP.tryGetInventoryItem(user_id,"linha",20) then
                                TriggerClientEvent(nomesnui,source) --------- trocar quando duplicar
                                TriggerClientEvent("progress",source,10000,"Montando "..itemupper.."")
                                vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                SetTimeout(10000,function()
                                    vRPclient._stopAnim(source,false)
                                    vRP.giveInventoryItem(user_id,"colete",1)
                                    local itemupper = string.upper(item)
                                    TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>"..itemupper.."</b>")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Materiais insuficientes!")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

                end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO DE PERMISSÃO ]----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
function oC.checkPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"cn.permissao") then
        return true
    end
end