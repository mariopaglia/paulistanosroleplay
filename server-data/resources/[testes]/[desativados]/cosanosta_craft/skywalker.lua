local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("cosanosta_craft",oC)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local armas = {
	{ item = "m-ak47" },
	{ item = "m-uzi" },
	{ item = "m-assaultsmg" },
	{ item = "m-famas" },
	{ item = "m-magnum" },
	{ item = "m-fiveseven" },
	{ item = "colete" },
	{ item = "capsula" },
	{ item = "linha" },
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-muni-cosanostra")
AddEventHandler("produzir-muni-cosanostra",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(armas) do
			if item == v.item then
				if item == "m-ak47" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_ASSAULTRIFLE")*30 <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"polvora") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"capsula") >= 30 then
								if vRP.tryGetInventoryItem(user_id,"polvora",30) and vRP.tryGetInventoryItem(user_id,"capsula",30) then
									TriggerClientEvent("fechar-nui-cosanostra",source)

									TriggerClientEvent("progress",source,10000,"Fabricando Munições de AK47")
									vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

									SetTimeout(10000,function()
										vRPclient._stopAnim(source,false)
										vRP.giveInventoryItem(user_id,"wammo|WEAPON_ASSAULTRIFLE",30)
										TriggerClientEvent("Notify",source,"sucesso","Você fabricou munições de <b>AK47</b>.")
									end)
								end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>capsulas</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Polvora</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

				elseif item == "colete" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("colete") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"linha") >= 60 then
                            if vRP.getInventoryItemAmount(user_id,"tecido") >= 50 then
								if vRP.tryGetInventoryItem(user_id,"linha",60) and vRP.tryGetInventoryItem(user_id,"tecido",50) then
									TriggerClientEvent("fechar-nui-cosanostra",source)

									TriggerClientEvent("progress",source,10000,"Fabricando Colete")
									vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

									SetTimeout(10000,function()
										vRPclient._stopAnim(source,false)
										vRP.giveInventoryItem(user_id,"colete",1)
										TriggerClientEvent("Notify",source,"sucesso","Você fabricou um <b>Colete</b>.")
									end)
								end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>tecido</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>linha</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

				elseif item == "m-uzi" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_MICROSMG")*30 <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"polvora") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"capsula") >= 30 then
								if vRP.tryGetInventoryItem(user_id,"polvora",30) and vRP.tryGetInventoryItem(user_id,"capsula",30) then
									TriggerClientEvent("fechar-nui-cosanostra",source)

									TriggerClientEvent("progress",source,10000,"Fabricando Munições de AK47")
									vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

									SetTimeout(10000,function()
										vRPclient._stopAnim(source,false)
										vRP.giveInventoryItem(user_id,"wammo|WEAPON_MICROSMG",30)
										TriggerClientEvent("Notify",source,"sucesso","Você fabricou munições de <b>UZI</b>.")
									end)
								end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>capsulas</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Polvora</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

				elseif item == "m-assaultsmg" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_ASSAULTSMG")*30 <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"polvora") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"capsula") >= 30 then
								if vRP.tryGetInventoryItem(user_id,"polvora",30) and vRP.tryGetInventoryItem(user_id,"capsula",30) then
									TriggerClientEvent("fechar-nui-cosanostra",source)

									TriggerClientEvent("progress",source,10000,"Fabricando Munições de MTAR")
									vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

									SetTimeout(10000,function()
										vRPclient._stopAnim(source,false)
										vRP.giveInventoryItem(user_id,"wammo|WEAPON_ASSAULTSMG",30)
										TriggerClientEvent("Notify",source,"sucesso","Você fabricou munições de <b>MTAR</b>.")
									end)
								end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>capsulas</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Polvora</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

				elseif item == "m-famas" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_BULLPUPRIFLE_MK2")*30 <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"polvora") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"capsula") >= 30 then
								if vRP.tryGetInventoryItem(user_id,"polvora",30) and vRP.tryGetInventoryItem(user_id,"capsula",30) then
									TriggerClientEvent("fechar-nui-cosanostra",source)

									TriggerClientEvent("progress",source,10000,"Fabricando Munições de FAMAS")
									vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

									SetTimeout(10000,function()
										vRPclient._stopAnim(source,false)
										vRP.giveInventoryItem(user_id,"wammo|WEAPON_BULLPUPRIFLE_MK2",30)
										TriggerClientEvent("Notify",source,"sucesso","Você fabricou munições de <b>FAMAS</b>.")
									end)
								end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>capsulas</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Polvora</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

				elseif item == "m-magnum" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_REVOLVER_MK2")*30 <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"polvora") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"capsula") >= 30 then
								if vRP.tryGetInventoryItem(user_id,"polvora",30) and vRP.tryGetInventoryItem(user_id,"capsula",30) then
									TriggerClientEvent("fechar-nui-cosanostra",source)

									TriggerClientEvent("progress",source,10000,"Fabricando Munições de MAGNUM")
									vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

									SetTimeout(10000,function()
										vRPclient._stopAnim(source,false)
										vRP.giveInventoryItem(user_id,"wammo|WEAPON_REVOLVER_MK2",30)
										TriggerClientEvent("Notify",source,"sucesso","Você fabricou munições de <b>MAGNUM</b>.")
									end)
								end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>capsulas</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Polvora</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

				elseif item == "m-fiveseven" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_PISTOL_MK2")*30 <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"polvora") >= 30 then
                            if vRP.getInventoryItemAmount(user_id,"capsula") >= 30 then
								if vRP.tryGetInventoryItem(user_id,"polvora",30) and vRP.tryGetInventoryItem(user_id,"capsula",30) then
									TriggerClientEvent("fechar-nui-cosanostra",source)

									TriggerClientEvent("progress",source,10000,"Fabricando Munições de FiveSeven")
									vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

									SetTimeout(10000,function()
										vRPclient._stopAnim(source,false)
										vRP.giveInventoryItem(user_id,"wammo|WEAPON_PISTOL_MK2",30)
										TriggerClientEvent("Notify",source,"sucesso","Você fabricou munições de <b>FiveSeven</b>.")
									end)
								end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>capsulas</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Polvora</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

                elseif item == "capsula" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("capsula")*30 <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"dinheirosujo") >= 1500 then
							if vRP.tryGetInventoryItem(user_id,"dinheirosujo",1500) then
								TriggerClientEvent("fechar-nui-cosanostra",source)

								TriggerClientEvent("progress",source,10000,"Comprando Capsula")
								vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

								SetTimeout(10000,function()
									vRPclient._stopAnim(source,false)
									vRP.giveInventoryItem(user_id,"capsula",30)
									TriggerClientEvent("Notify",source,"sucesso","Você comprou <b>30x Capsulas</b>.")
								end)
							end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não possui <b>R$1500</b> de DinheiroSujo.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
					
                elseif item == "linha" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("linha")*50 <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"dinheirosujo") >= 1500 then
							if vRP.tryGetInventoryItem(user_id,"dinheirosujo",1500) then
								TriggerClientEvent("fechar-nui-cosanostra",source)

								TriggerClientEvent("progress",source,10000,"Comprando Linha")
								vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

								SetTimeout(10000,function()
									vRPclient._stopAnim(source,false)
									vRP.giveInventoryItem(user_id,"linha",50)
									TriggerClientEvent("Notify",source,"sucesso","Você comprou <b>50x Linha</b>.")
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
    if vRP.hasPermission(user_id,"cn.permissao") then
        return true
    end
end