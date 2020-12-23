local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("nav_producao-municao-colete",oC)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local municoes = {
	{ item = "m-ak47" },
	{ item = "m-uzi" },
	{ item = "m-mtar21" },
	{ item = "m-famas" },
	{ item = "m-magnum44" },
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
		for k,v in pairs(municoes) do
            if item == v.item then
                
				if item == "m-ak47" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_ASSAULTRIFLE_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsula") >= 1 then
                            if vRP.tryGetInventoryItem(user_id,"capsula",50) then
                                TriggerClientEvent("fechar-nui",source)
                                TriggerClientEvent("progress",source,10000,"Fabricando Munição")
                                vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                SetTimeout(10000,function()
                                    vRPclient._stopAnim(source,false)
                                    vRP.giveInventoryItem(user_id,"wammo|WEAPON_ASSAULTRIFLE_MK2",50)
                                    TriggerClientEvent("Notify",source,"sucesso","Você fabricou munição de <b>AK47</b>.")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Capsula</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                
				elseif item == "m-uzi" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_MICROSMG") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsula") >= 1 then
                            if vRP.tryGetInventoryItem(user_id,"capsula",50) then
                                TriggerClientEvent("fechar-nui",source)
                                TriggerClientEvent("progress",source,10000,"Fabricando Munição")
                                vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                SetTimeout(10000,function()
                                    vRPclient._stopAnim(source,false)
                                    vRP.giveInventoryItem(user_id,"wammo|WEAPON_MICROSMG",50)
                                    TriggerClientEvent("Notify",source,"sucesso","Você fabricou munição de <b>UZI</b>.")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Capsula</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                
				elseif item == "m-magnum357" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_REVOLVER_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsula") >= 1 then
                            if vRP.tryGetInventoryItem(user_id,"capsula",50) then
                                TriggerClientEvent("fechar-nui",source)
                                TriggerClientEvent("progress",source,10000,"Fabricando Munição")
                                vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                SetTimeout(10000,function()
                                    vRPclient._stopAnim(source,false)
                                    vRP.giveInventoryItem(user_id,"wammo|WEAPON_REVOLVER_MK2",50)
                                    TriggerClientEvent("Notify",source,"sucesso","Você fabricou munição de <b>MAGNUM 357</b>.")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Capsula</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                
				elseif item == "m-mtar21" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_ASSAULTSMG") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsula") >= 1 then
                            if vRP.tryGetInventoryItem(user_id,"capsula",50) then
                                TriggerClientEvent("fechar-nui",source)
                                TriggerClientEvent("progress",source,10000,"Fabricando Munição")
                                vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                SetTimeout(10000,function()
                                    vRPclient._stopAnim(source,false)
                                    vRP.giveInventoryItem(user_id,"wammo|WEAPON_ASSAULTSMG",50)
                                    TriggerClientEvent("Notify",source,"sucesso","Você fabricou munição de <b>MTAR-21</b>.")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Capsula</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
                
				elseif item == "m-famas" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_BULLPUPRIFLE_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsula") >= 1 then
                            if vRP.tryGetInventoryItem(user_id,"capsula",50) then
                                TriggerClientEvent("fechar-nui",source)
                                TriggerClientEvent("progress",source,10000,"Fabricando Munição")
                                vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                SetTimeout(10000,function()
                                    vRPclient._stopAnim(source,false)
                                    vRP.giveInventoryItem(user_id,"wammo|WEAPON_BULLPUPRIFLE_MK2",50)
                                    TriggerClientEvent("Notify",source,"sucesso","Você fabricou munição de <b>FAMAS</b>.")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Capsula</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end
     
				elseif item == "m-fiveseven" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_PISTOL_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"capsula") >= 1 then
                            if vRP.tryGetInventoryItem(user_id,"capsula",50) then
                                TriggerClientEvent("fechar-nui",source)
                                TriggerClientEvent("progress",source,10000,"Fabricando Munição")
                                vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                SetTimeout(10000,function()
                                    vRPclient._stopAnim(source,false)
                                    vRP.giveInventoryItem(user_id,"wammo|WEAPON_PISTOL_MK2",50)
                                    TriggerClientEvent("Notify",source,"sucesso","Você fabricou munição de <b>AK47</b>.")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>Capsula</b> na mochila.")
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
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"cn.permissao") then
        return true
    end
end