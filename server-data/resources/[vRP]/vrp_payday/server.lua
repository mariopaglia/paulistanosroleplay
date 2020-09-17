local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_salar")

salarii = {
  {"salariopmesp.recruta", 1700}, 
  {"salariopmesp.soldado", 1900},
  {"salariopmesp.cabo", 2100},
  {"salariopmesp.sargento", 2300},
  {"salariopmesp.tenente", 2600},
  {"salariopmerj.coronel", 3500},

  {"salariogam.permissao", 2500},

  {"salariorecom.soldado", 2800},
  {"salariorecom.cabo", 3000},
  {"salariorecom.sargento", 3200},
  {"salariorecom.tenente", 3500},
  {"salariorecom.capitao", 3700},
  {"salariorecom.major", 3900},
  {"salariorecom.coronel", 4000},

  {"salariobope.soldado", 3000},
  {"salariobope.cabo", 3200},
  {"salariobope.sargento", 3400},
  {"salariobope.tenente", 3600},
  {"salariobope.capitao", 4000},
  {"salariobope.major", 4200},
  {"salariobope.coronel", 4500},

  {"salariopfederal.agente", 3000},
  {"salariopfederal.perito", 4000},
  {"salariopfederal.delegado", 5000},

  {"pcivil.investigador", 3100},
  {"pcivil.perito", 4000},
  {"pcivil.delegado", 5000},

  {"salarioprf.terceira", 3000},
  {"salarioprf.segunda", 3750},
  {"salarioprf.primeira", 4200},
  {"salarioprf.especial", 5000},
  
  {"salariobpchq.permissao", 2800},
  {"cmdgeral.permissao", 5000},
  {"juiz.permissao", 2000},
  {"advogado.permissao", 2000}, 

  {"salariomecanico.permissao", 2500},
  {"lidermecanico.permissao", 3000},
  
  {"enfermeiro.permissao", 2000},
  {"paramedicosamu.permissao", 2500},   
  {"diretorgeral.permissao", 3200}, 
  {"weazel.permissao", 1800}, 

  {"salarioconce.permissao", 2700}, 
  {"salarioconcedono.permissao", 3700}, 
  
  {"bronze.permissao", 5000},
  {"prata.permissao", 10000},
  {"ouro.permissao", 15000},
  {"platina.permissao", 20000},
}

RegisterServerEvent('offred:salar')
AddEventHandler('offred:salar', function(salar)
	local user_id = vRP.getUserId(source)
	for i,v in pairs(salarii) do
		permisiune = v[1]
		if vRP.hasPermission(user_id, permisiune)then
			salar = v[2]
      vRP.giveBankMoney(user_id,salar)
      TriggerClientEvent("vrp_sound:source",source,'coins',1)
      TriggerClientEvent("Notify",source,"importante","Obrigado por colaborar com a cidade, seu salario de <b>R$ "..salar.."</b> foi depositado.")
      TriggerClientEvent('chatMessage',source,"Obrigado por colaborar com a cidade! Seu salário de ^2R$"..salar.." ^0 foi depositado.")
		end
	end
end)
