local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("nav_producao-municao-colete",oC)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local armas = {
	{ item = "ak47" },
	{ item = "ak74u" },
	{ item = "uzi" },
	{ item = "magnum44" },
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
				if item == "ak47" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_ASSAULTRIFLE_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"corpodeak") >= 1 then
                            if vRP.getInventoryItemAmount(user_id,"placademetal") >= 160 then
                                if vRP.getInventoryItemAmount(user_id,"mola") >= 10 then
                                    if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
                                        if vRP.tryGetInventoryItem(user_id,"corpodeak",1) and vRP.tryGetInventoryItem(user_id,"placademetal",160) and vRP.tryGetInventoryItem(user_id,"mola",10) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
                                            TriggerClientEvent("fechar-nui",source)

                                            TriggerClientEvent("progress",source,10000,"Montando AK47")
                                            TriggerClientEvent("bancada-armas:posicao",source)
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"wbody|WEAPON_ASSAULTRIFLE_MK2",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>AK47</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você não tem <b>gatilho</b> na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>10x mola</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>160x placas de metal</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>corpo de AK-47</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "uzi" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_MICROSMG") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"corpodeuzi") >= 1 then
                            if vRP.getInventoryItemAmount(user_id,"placademetal") >= 150 then
                                if vRP.getInventoryItemAmount(user_id,"mola") >= 8 then
                                    if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
                                        if vRP.tryGetInventoryItem(user_id,"corpodeuzi",1) and vRP.tryGetInventoryItem(user_id,"placademetal",150) and vRP.tryGetInventoryItem(user_id,"mola",8) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
                                            TriggerClientEvent("fechar-nui",source)

                                            TriggerClientEvent("progress",source,10000,"Montando MICRO-UZI")
                                            -- TriggerClientEvent("bancada-armas:posicao",source)
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"wbody|WEAPON_MICROSMG",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>UZI</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você não tem <b>gatilho</b> na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>8x molas</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>150x placas de metal</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>corpo de UZI</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "magnum44" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_REVOLVER_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"corpodemagnum") >= 1 then
                            if vRP.getInventoryItemAmount(user_id,"placademetal") >= 140 then
                                if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
                                    if vRP.tryGetInventoryItem(user_id,"corpodemagnum",1) and vRP.tryGetInventoryItem(user_id,"placademetal",140) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
                                        TriggerClientEvent("fechar-nui",source)

                                        TriggerClientEvent("progress",source,10000,"Montando Revolver Magnum 44")
                                        vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                        SetTimeout(10000,function()
                                            vRPclient._stopAnim(source,false)
                                            vRP.giveInventoryItem(user_id,"wbody|WEAPON_REVOLVER_MK2",1)
                                            TriggerClientEvent("Notify",source,"sucesso","Você montou um <b>Revolver Magnum 44</b>.")
                                        end)
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você não tem <b>gatilho</b> na mochila.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>140x placas de metal</b>")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>corpo de Magnum 44</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "fiveseven" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_PISTOL_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"corpodefiveseven") >= 1 then
                            if vRP.getInventoryItemAmount(user_id,"placademetal") >= 120 then
                                if vRP.getInventoryItemAmount(user_id,"mola") >= 1 then
                                    if vRP.tryGetInventoryItem(user_id,"corpodefiveseven",1) and vRP.tryGetInventoryItem(user_id,"placademetal",120) and vRP.tryGetInventoryItem(user_id,"mola",1) then
                                        TriggerClientEvent("fechar-nui",source)

                                        TriggerClientEvent("progress",source,10000,"Montando Five Seven")
                                        -- TriggerClientEvent("bancada-armas:posicao",source)
                                        vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                        SetTimeout(10000,function()
                                            vRPclient._stopAnim(source,false)
                                            vRP.giveInventoryItem(user_id,"wbody|WEAPON_PISTOL_MK2",1)
                                            TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>Five Seven</b>.")
                                        end)
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você não tem <b>pacote de mola</b> na mochila.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>120x placas de metal</b>")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>corpo de Five Seven</b> na mochila.")
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
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"bratva.permissao") or vRP.hasPermission(user_id,"cn.permissao") then
        return true
    end
end