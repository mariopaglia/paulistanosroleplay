local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_policia", emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.hasPermission(user_id, "policia.permissao")
end

function emP.checkPayment()
    local source = source
    local user_id = vRP.getUserId(source)
	local buffado = true -- true (emprego buffado) / false (emprego normal)

	-- BUFFAR AUTOMATICAMENTE EMPREGOS AOS FINAIS DE SEMANA
    local diaSemana = os.date("%w")
    if diaSemana == "6" or diaSemana == "0" then
        buffado = true
    end
	
    if user_id then
		if buffado then
			local pagamento = math.random(120, 240) -- VALOR BUFFADO (+20%)
			vRP.giveMoney(user_id, pagamento)
			TriggerClientEvent("Notify", source, "sucesso", "Você recebeu <b>R$ " .. vRP.format(parseInt(pagamento)) .. "</b> (Emprego Buffado).")
		else
			local pagamento = math.random(100, 200) -- VALOR NORMAL
			vRP.giveMoney(user_id, pagamento)
			TriggerClientEvent("Notify", source, "sucesso", "Você recebeu <b>R$ " .. vRP.format(parseInt(pagamento)) .. "</b>.")
		end
    end
end
