local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_paramedico", emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.hasPermission(user_id, "paramedico.permissao")
end

function emP.checkPayment(payment)
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
			local randmoney = math.random(1440, 1800) -- VALOR BUFFADO (+20%)
			vRP.giveMoney(user_id, parseInt(randmoney))
			TriggerClientEvent("vrp_sound:source", source, 'coins', 0.5)
			TriggerClientEvent("Notify", source, "sucesso", "Você recebeu <b>R$ " .. vRP.format(parseInt(randmoney)) .. "</b> (Emprego Buffado).")
		else
			local randmoney = math.random(1200, 1500) -- VALOR NORMAL
			vRP.giveMoney(user_id, parseInt(randmoney))
			TriggerClientEvent("vrp_sound:source", source, 'coins', 0.5)
			TriggerClientEvent("Notify", source, "sucesso", "Você recebeu <b>R$ " .. vRP.format(parseInt(randmoney)) .. "</b>.")
		end
    end
end
