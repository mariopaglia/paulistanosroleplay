local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("lixeiro_despejar",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"sacodelixo") > 0 then
			vRP.tryGetInventoryItem(user_id,"sacodelixo",1)
			local pagamento = math.random(200,250)
			vRP.giveMoney(user_id,pagamento)
			TriggerClientEvent("Notify",source,"importante","Você despejou <b>1x Saco de Lixo</b> e ganhou <b>R$ " ..pagamento.."</b>",8000)
			return true
		end
	end
end