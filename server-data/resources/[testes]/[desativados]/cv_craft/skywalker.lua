local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("cv_craft",oC)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local armas = {
	{ item = "pino" },
	{ item = "componentes" }
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-muni-cv")
AddEventHandler("produzir-muni-cv",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(armas) do
			if item == v.item then
                if item == "pino" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("pino")*10 <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"dinheirosujo") >= 500 then
							if vRP.tryGetInventoryItem(user_id,"dinheirosujo",500) then
								TriggerClientEvent("fechar-nui-cv",source)

								TriggerClientEvent("progress",source,10000,"Comprando Pinos")
								vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

								SetTimeout(10000,function()
									vRPclient._stopAnim(source,false)
									vRP.giveInventoryItem(user_id,"pino",10)
									TriggerClientEvent("Notify",source,"sucesso","Você comprou <b>10x Pinos</b>.")
								end)
							end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não possui <b>R$500</b> de DinheiroSujo.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente na mochila.")
                    end

                elseif item == "componentes" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("acetofenetidina")*5 and vRP.getInventoryWeight(user_id)+vRP.getItemWeight("benzoilecgonina")*5 and vRP.getInventoryWeight(user_id)+vRP.getItemWeight("cloridratoecgonina")*5 <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"dinheirosujo") >= 2500 then
							if vRP.tryGetInventoryItem(user_id,"dinheirosujo",2500) then
								TriggerClientEvent("fechar-nui-cv",source)

								TriggerClientEvent("progress",source,10000,"Comprando Componentes")
								vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

								SetTimeout(10000,function()
									vRPclient._stopAnim(source,false)
									vRP.giveInventoryItem(user_id,"acetofenetidina",5)
									vRP.giveInventoryItem(user_id,"benzoilecgonina",5)
									vRP.giveInventoryItem(user_id,"cloridratoecgonina",5)
									TriggerClientEvent("Notify",source,"sucesso","Você comprou <b>5x Unidades de cada Componente</b>.")
								end)
							end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não possui <b>R$2500</b> de DinheiroSujo.")
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
    if vRP.hasPermission(user_id,"vermelhos.permissao") then
        return true
    end
end