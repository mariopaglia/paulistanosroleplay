local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("tcp_craft",oC)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local armas = {
	{ item = "componentes" }
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-tcp")
AddEventHandler("produzir-tcp",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(armas) do
			if item == v.item then
                if item == "componentes" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("pseudoefedrina")*5 and vRP.getInventoryWeight(user_id)+vRP.getItemWeight("ritalina")*5 <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"dinheirosujo") >= 1500 then
							if vRP.tryGetInventoryItem(user_id,"dinheirosujo",1500) then
								TriggerClientEvent("fechar-nui-tcp",source)

								TriggerClientEvent("progress",source,10000,"Comprando Componentes")
								vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

								SetTimeout(10000,function()
									vRPclient._stopAnim(source,false)
									vRP.giveInventoryItem(user_id,"pseudoefedrina",5)
									vRP.giveInventoryItem(user_id,"ritalina",5)
									TriggerClientEvent("Notify",source,"sucesso","Você comprou <b>5x Unidades de cada Componente</b>.")
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
    if vRP.hasPermission(user_id,"tcp.permissao") then
        return true
    end
end