local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("nav_producao-armas",oC)
local nomesnui = "fechar-nui"

-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local armas = {
	{ item = "ak47" },
	{ item = "g36" },
	{ item = "mp5" },
	{ item = "fiveseven" }
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-arma")
AddEventHandler("produzir-arma",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(armas) do
            if item == v.item then
            local itemupper = string.upper(item)
                
                ---------------------------
                -- PRODUÇÃO DA G36
                ---------------------------
                if item == "g36" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_SPECIALCARBINE_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"corpodeg36") >= 1 and vRP.getInventoryItemAmount(user_id,"placademetal") >= 160 and vRP.getInventoryItemAmount(user_id,"mola") >= 25 and vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
                            if vRP.tryGetInventoryItem(user_id,"corpodeg36",1) and vRP.tryGetInventoryItem(user_id,"placademetal",160) and vRP.tryGetInventoryItem(user_id,"mola",25) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
                                TriggerClientEvent(nomesnui,source) --------- trocar quando duplicar
                                TriggerClientEvent("progress",source,10000,"Montando "..itemupper.."")
                                vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                SetTimeout(10000,function()
                                    vRPclient._stopAnim(source,false)
                                    vRP.giveInventoryItem(user_id,"wbody|WEAPON_SPECIALCARBINE_MK2",1)
                                    TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>"..itemupper.."</b>.")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Materiais insuficientes!")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

                ---------------------------
                -- PRODUÇÃO DA AK-47
                ---------------------------
				elseif item == "ak47" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_ASSAULTRIFLE_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"corpodeak") >= 1 and vRP.getInventoryItemAmount(user_id,"placademetal") >= 140 and vRP.getInventoryItemAmount(user_id,"mola") >= 20 and vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
                            if vRP.tryGetInventoryItem(user_id,"corpodeak",1) and vRP.tryGetInventoryItem(user_id,"placademetal",140) and vRP.tryGetInventoryItem(user_id,"mola",20) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
                                TriggerClientEvent(nomesnui,source) --------- trocar quando duplicar
                                TriggerClientEvent("progress",source,10000,"Montando "..itemupper.."")
                                vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                SetTimeout(10000,function()
                                    vRPclient._stopAnim(source,false)
                                    vRP.giveInventoryItem(user_id,"wbody|WEAPON_ASSAULTRIFLE_MK2",1)
                                    TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>"..itemupper.."</b>.")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Materiais insuficientes!")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

                ---------------------------
                -- PRODUÇÃO DA MP5
                ---------------------------
                elseif item == "mp5" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_SMG_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"corpodemp5") >= 1 and vRP.getInventoryItemAmount(user_id,"placademetal") >= 120 and vRP.getInventoryItemAmount(user_id,"mola") >= 16 and vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
                            if vRP.tryGetInventoryItem(user_id,"corpodemp5",1) and vRP.tryGetInventoryItem(user_id,"placademetal",120) and vRP.tryGetInventoryItem(user_id,"mola",16) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
                                TriggerClientEvent(nomesnui,source) --------- trocar quando duplicar
                                TriggerClientEvent("progress",source,10000,"Montando "..itemupper.."")
                                vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                SetTimeout(10000,function()
                                    vRPclient._stopAnim(source,false)
                                    vRP.giveInventoryItem(user_id,"wbody|WEAPON_SMG_MK2",1)
                                    local itemupper = string.upper(item)
                                    TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>"..itemupper.."</b>.")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Materiais insuficientes!")
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

                ---------------------------
                -- PRODUÇÃO DA FIVE SEVEN
                ---------------------------
                elseif item == "fiveseven" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_PISTOL_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"corpodefiveseven") >= 1 and vRP.getInventoryItemAmount(user_id,"placademetal") >= 100 and vRP.getInventoryItemAmount(user_id,"mola") >= 6 and vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
                            if vRP.tryGetInventoryItem(user_id,"corpodefiveseven",1) and vRP.tryGetInventoryItem(user_id,"placademetal",100) and vRP.tryGetInventoryItem(user_id,"mola",6) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
                                TriggerClientEvent(nomesnui,source) --------- trocar quando duplicar
                                TriggerClientEvent("progress",source,10000,"Montando "..itemupper.."")
                                vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                SetTimeout(10000,function()
                                    vRPclient._stopAnim(source,false)
                                    vRP.giveInventoryItem(user_id,"wbody|WEAPON_PISTOL_MK2",1)
                                    local itemupper = string.upper(item)
                                    TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>"..itemupper.."</b>.")
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
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"bratva.permissao") then
        return true
    end
end