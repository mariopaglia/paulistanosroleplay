local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

RegisterServerEvent("vrp_legacyfuel:pagamento1731910")
AddEventHandler("vrp_legacyfuel:pagamento1731910",function(price,galao)
	local user_id = vRP.getUserId(source)
	if user_id and price > 0 then
		if vRP.tryPayment(user_id,price) then
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