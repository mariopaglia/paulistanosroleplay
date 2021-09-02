local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("lixeiro_despejar", emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
    vRP.antiflood(source, "lixeiro_despejar", 10)
    local source = source
    local user_id = vRP.getUserId(source)
	local buffado = false -- true (emprego buffado) / false (emprego normal)

	-- BUFFAR AUTOMATICAMENTE EMPREGOS AOS FINAIS DE SEMANA
    local diaSemana = os.date("%w")
    if diaSemana == "6" or diaSemana == "0" then
        buffado = true
    end
	
    if user_id then
		if buffado then
			if vRP.getInventoryItemAmount(user_id, "sacodelixo") > 0 then
				vRP.tryGetInventoryItem(user_id, "sacodelixo", 1)
				local pagamento = math.random(240, 300) -- VALOR BUFFADO (+20%)
				vRP.injectMoneyLimpo(user_id, pagamento)
				TriggerClientEvent("Notify", source, "importante", "Você despejou <b>1x Saco de Lixo</b> e ganhou <b>R$ " .. pagamento .. "</b>(Emprego Buffado)", 8000)
				return true
			end
		else
			if vRP.getInventoryItemAmount(user_id, "sacodelixo") > 0 then
				vRP.tryGetInventoryItem(user_id, "sacodelixo", 1)
				local pagamento = math.random(200, 250) -- VALOR NORMAL
				vRP.injectMoneyLimpo(user_id, pagamento)
				TriggerClientEvent("Notify", source, "importante", "Você despejou <b>1x Saco de Lixo</b> e ganhou <b>R$ " .. pagamento .. "</b>", 8000)
				return true
			end
		end
    end
end
