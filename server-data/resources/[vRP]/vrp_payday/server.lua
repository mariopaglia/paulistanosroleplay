local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_salar")

salarii = {
  {"bronze.permissao", 1000},
  {"prata.recruta", 1000},
  {"ouro.recruta", 1000},
  {"diamante.recruta", 1000},
  {"recruta.recruta", 1000},
  {"soldado.recruta", 1000},
  {"tenente.recruta", 1000},
  {"capitao.recruta", 1000},
  {"coronel.recruta", 1000},
  {"comandante.recruta", 1000},
  {"agente.recruta", 1000},
  {"inspetor.recruta", 1000},
  {"investigador.recruta", 1000},
  {"delegado.recruta", 1000},
  {"enfermeiro.recruta", 1000},
  {"medico.recruta", 1000},
  {"diretor.recruta", 1000},
  {"funcmecanico.recruta", 1000},
  {"lidermecanico.recruta", 1000},
  {"concessionaria.recruta", 1000},


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
      -- TriggerClientEvent('chatMessage',source,"Obrigado por colaborar com a cidade! Seu salário de ^2R$"..salar.." ^0 foi depositado.")
		end
	end
end)
