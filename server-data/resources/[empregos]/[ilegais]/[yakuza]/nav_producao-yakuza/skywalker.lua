local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("nav_producao-yakuza",oC)
local nomesnui = "fechar-nui-yakuza"

-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local listaitens = {
	{ item = "pendrivedeep" },
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-pendrivedeep")
AddEventHandler("produzir-pendrivedeep",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(listaitens) do
            if item == v.item then
            local itemupper = string.upper(item)
                
                ---------------------------
                -- PRODUÇÃO MAÇARICO
                ---------------------------
				if item == "pendrivedeep" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("pendrivedeep") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"placacircuito") >= 10 and vRP.getInventoryItemAmount(user_id,"chipset") >= 10 then
                            if vRP.tryGetInventoryItem(user_id,"placacircuito",10) and vRP.tryGetInventoryItem(user_id,"chipset",10) then
                                TriggerClientEvent(nomesnui,source) --------- trocar quando duplicar
                                TriggerClientEvent("progress",source,10000,"Montando Pendrive Deepweb")
                                vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
                                SetTimeout(10000,function()
                                    vRPclient._stopAnim(source,false)
                                    vRP.giveInventoryItem(user_id,"pendrivedeep",10)
                                    TriggerClientEvent("Notify",source,"sucesso","Você produziu <b>10x Pendrive Deepweb</b>")
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
    if vRP.hasPermission(user_id,"yakuza.permissao") or vRP.hasPermission(user_id,"triade.permissao") then
        return true
    end
end