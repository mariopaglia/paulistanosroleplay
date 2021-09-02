local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_hospital",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkServices()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then		
		local paramedicos = vRP.getUsersByPermission("paramedico.permissao")

		if parseInt(#paramedicos) >= 1 then
			TriggerClientEvent("Notify",source,"negado","Existem médicos em serviço, caso não tenha um médico no local faça um chamado pelo <b>celular</b>",5000)
			return false
		else
			if vRP.request(source,"Deseja pagar <b>R$ 2.000</b> pelo tratamento?",15) then
				if vRP.tryFullPayment(user_id,parseInt(2000)) then
					return true
				end
			end
		end
	end
end