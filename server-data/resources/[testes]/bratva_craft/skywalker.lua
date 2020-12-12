local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("bratva_craft",oC)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local armas = {
	{ item = "ak47" },
	{ item = "uzi" },
	{ item = "assaultsmg" },
	{ item = "famas" },
	{ item = "magnum" },
	{ item = "fiveseven" },
	{ item = "molas" },
	{ item = "gatilho" },
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
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_ASSAULTRIFLE") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"placademetal") >= 5 then
                                if vRP.getInventoryItemAmount(user_id,"mola") >= 15 then
                                    if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
                                        if vRP.tryGetInventoryItem(user_id,"pecadearma",30) and vRP.tryGetInventoryItem(user_id,"placademetal",5) and vRP.tryGetInventoryItem(user_id,"mola",15) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
                                            TriggerClientEvent("fechar-nui",source)

                                            TriggerClientEvent("progress",source,10000,"Montando AK47")
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"wbody|WEAPON_ASSAULTRIFLE",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>AK47</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você não tem <b>gatilho</b> na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>15x pacotes de mola</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>5x placas de metal</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>30 Peça De Arma</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

                elseif item == "uzi" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_MICROSMG") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 18 then
                            if vRP.getInventoryItemAmount(user_id,"placademetal") >= 3 then
                                if vRP.getInventoryItemAmount(user_id,"mola") >= 8 then
                                    if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
                                        if vRP.tryGetInventoryItem(user_id,"pecadearma",18) and vRP.tryGetInventoryItem(user_id,"placademetal",3) and vRP.tryGetInventoryItem(user_id,"mola",8) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
                                            TriggerClientEvent("fechar-nui",source)

                                            TriggerClientEvent("progress",source,10000,"Montando UZI")
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
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>8x pacotes de mola</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>3x placas de metal</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>18 Peça De Arma</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

                elseif item == "assaultsmg" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_ASSAULTSMG") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 25 then
                            if vRP.getInventoryItemAmount(user_id,"placademetal") >= 5 then
                                if vRP.getInventoryItemAmount(user_id,"mola") >= 12 then
									if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
										if vRP.tryGetInventoryItem(user_id,"pecadearma",25) and vRP.tryGetInventoryItem(user_id,"placademetal",5) and vRP.tryGetInventoryItem(user_id,"mola",12) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
											TriggerClientEvent("fechar-nui",source)

											TriggerClientEvent("progress",source,10000,"Montando MTAR-21")
											vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

											SetTimeout(10000,function()
												vRPclient._stopAnim(source,false)
												vRP.giveInventoryItem(user_id,"wbody|WEAPON_ASSAULTSMG",1)
												TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>ASSAULT SMG</b>.")
											end)
										end
									else
										TriggerClientEvent("Notify",source,"negado","Você não tem <b>gatilho</b> na mochila.")
									end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você não tem <b>12x pacotes de molas</b> na mochila.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você não tem <b>5x placas de metal</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>25x Peças De Arma</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

                elseif item == "famas" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_BULLPUPRIFLE_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"placademetal") >= 5 then
                                if vRP.getInventoryItemAmount(user_id,"mola") >= 15 then
                                    if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
                                        if vRP.tryGetInventoryItem(user_id,"pecadearma",30) and vRP.tryGetInventoryItem(user_id,"placademetal",5) and vRP.tryGetInventoryItem(user_id,"mola",15) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
											TriggerClientEvent("fechar-nui",source)

											TriggerClientEvent("progress",source,10000,"Montando FAMAS")
											vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

											SetTimeout(10000,function()
												vRPclient._stopAnim(source,false)
												vRP.giveInventoryItem(user_id,"wbody|WEAPON_BULLPUPRIFLE_MK2",1)
												TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>FAMAS</b>.")
											end)
										end
									else
										TriggerClientEvent("Notify",source,"negado","Você não tem <b>gatilho</b> na mochila.")
									end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você não tem <b>12x pacotes de molas</b> na mochila.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você não tem <b>5x placas de metal</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>25x Peças De Arma</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

                elseif item == "magnum" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_REVOLVER_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"placademetal") >= 5 then
								if vRP.getInventoryItemAmount(user_id,"mola") >= 15 then
									if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
										if vRP.tryGetInventoryItem(user_id,"pecadearma",13) and vRP.tryGetInventoryItem(user_id,"placademetal",3) and vRP.tryGetInventoryItem(user_id,"mola",5) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
											TriggerClientEvent("fechar-nui",source)

											TriggerClientEvent("progress",source,10000,"Montando MAGNUM")
											vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

											SetTimeout(10000,function()
												vRPclient._stopAnim(source,false)
												vRP.giveInventoryItem(user_id,"wbody|WEAPON_REVOLVER_MK2",1)
												TriggerClientEvent("Notify",source,"sucesso","Você montou um <b>MAGNUM</b>.")
											end)
										end
									else
										TriggerClientEvent("Notify",source,"negado","Você não tem <b>gatilho</b> na mochila.")
									end
								else
									TriggerClientEvent("Notify",source,"negado","Você não tem <b>5x molas</b> na mochila.")
								end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você não tem <b>3x placas de metal</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>13 Peça De Armas</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

                elseif item == "fiveseven" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_PISTOL_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"pecadearma") >= 13 then
                            if vRP.getInventoryItemAmount(user_id,"placademetal") >= 3 then
								if vRP.getInventoryItemAmount(user_id,"mola") >= 5 then
									if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
										if vRP.tryGetInventoryItem(user_id,"pecadearma",13) and vRP.tryGetInventoryItem(user_id,"placademetal",3) and vRP.tryGetInventoryItem(user_id,"mola",5) and vRP.tryGetInventoryItem(user_id,"gatilho",1) then
											TriggerClientEvent("fechar-nui",source)

											TriggerClientEvent("progress",source,10000,"Montando Five Seven")
											vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

											SetTimeout(10000,function()
												vRPclient._stopAnim(source,false)
												vRP.giveInventoryItem(user_id,"wbody|WEAPON_PISTOL_MK2",1)
												TriggerClientEvent("Notify",source,"sucesso","Você montou uma <b>Five Seven</b>.")
											end)
										end
									else
										TriggerClientEvent("Notify",source,"negado","Você não tem <b>gatilho</b> na mochila.")
									end
								else
									TriggerClientEvent("Notify",source,"negado","Você não tem <b>5x molas</b> na mochila.")
								end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você não tem <b>3x placas de metal</b> na mochila.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>13 Peça De Armas</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

                elseif item == "molas" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("mola") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"dinheirosujo") >= 1500 then
							if vRP.tryGetInventoryItem(user_id,"dinheirosujo",1500) then
								TriggerClientEvent("fechar-nui",source)

								TriggerClientEvent("progress",source,10000,"Comprando Molas")
								vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

								SetTimeout(10000,function()
									vRPclient._stopAnim(source,false)
									vRP.giveInventoryItem(user_id,"mola",5)
									TriggerClientEvent("Notify",source,"sucesso","Você comprou <b>5x Molas</b>.")
								end)
							end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não possui <b>R$1500</b> de DinheiroSujo.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
					
                elseif item == "gatilho" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("gatilho") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"dinheirosujo") >= 1500 then
							if vRP.tryGetInventoryItem(user_id,"dinheirosujo",1500) then
								TriggerClientEvent("fechar-nui",source)

								TriggerClientEvent("progress",source,10000,"Comprando Gatilho")
								vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

								SetTimeout(10000,function()
									vRPclient._stopAnim(source,false)
									vRP.giveInventoryItem(user_id,"gatilho",1)
									TriggerClientEvent("Notify",source,"sucesso","Você comprou <b>1x Gatilho</b>.")
								end)
							end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não possui <b>R$1500</b> de DinheiroSujo.")
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
    if vRP.hasPermission(user_id,"bratva.permissao") then
        return true
    end
end