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
		if vRP.tryGetInventoryItem(user_id,"sacodelixo",1) then
			local pagamento = math.random(200,300)
			vRP.giveMoney(user_id,pagamento)
			TriggerClientEvent("Notify",source,"importante","Você despejou <b>1x Saco de Lixo</b> e ganhou <b>R$ " ..pagamento.."</b>",8000)
			return true
		end
	end
end