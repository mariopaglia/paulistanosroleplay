local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

RegisterServerEvent("vrp_legacyfuel:pagamento1731910")
AddEventHandler("vrp_legacyfuel:pagamento1731910",function(price,galao)
	local user_id = vRP.getUserId(source)

	vRP.antiflood(source,"vrp_legacyfuel:pagamento",10)
    if(price<0)then
        local source = vRP.getUserSource(user_id)
        local x,y,z = vRPclient.getPosition(source)
        local reason = "HACK:     localização:    "..x..","..y..","..z
        vRP.setBanned(user_id,true)                    
        local temp = os.date("%x  %X")        
        local msg = "ANTI HACK    [ID]: "..user_id.."        "..temp.."[BAN]        [MOTIVO: SPAWN DINHEIRO]    "..reason
        --vRP.Log(msg)   --SOMENTE HABILITE ISSO SE TIVER AS LOGS INTEGRADAS DO MEU DISCORD NO SEU VRP
        local source = vRP.getUserSource(user_id)
        if source ~= nil then
            vRP.kick(source,"Vai usar Hack na Casa do Caralho!")                        
        end
    end
	
	if user_id and price > 0 then
		if vRP.tryFullPayment(user_id,price) then
			if galao then
				TriggerClientEvent('vrp_legacyfuel:galao1731910',source)
				TriggerClientEvent("Notify",source,"sucesso","Pagou <b>R$ "..vRP.format(price).." </b> pelo <b>Galão</b>")
			else
				TriggerClientEvent("Notify",source,"sucesso","Pagou <b>R$ "..vRP.format(price).." </b> em combustível")
			end
		else
			TriggerClientEvent('vrp_legacyfuel:insuficiente1731910',source)
			TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
		end
	end
end)