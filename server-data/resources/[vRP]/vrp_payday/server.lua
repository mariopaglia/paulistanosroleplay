local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_salar")

salarii = {
  -- VIPS
  {"boost.permissao", 800, "Nitro Boost"},
  {"bronze.permissao", 2000, "VIP Bronze"},
  {"prata.permissao", 3000, "VIP Prata"},
  {"ouro.permissao", 5000, "VIP Ouro"},
  {"platina.permissao", 7000, "VIP Platina"},
  {"esmeralda.permissao", 8000, "VIP Esmeralda"},
  {"diamante.permissao", 10000, "VIP Diamante"},
  -- Policia Militar
  {"recruta.permissao", 500, "PMESP Recruta"},
  {"soldado.permissao", 1000, "PMESP Soldado"},
  {"cabo.permissao", 1500, "PMESP Cabo"},
  {"sargentoi.permissao", 2000, "PMESP Sargento I"},
  {"sargentoii.permissao", 2500, "PMESP Sargento II"},
  {"sargentoiii.permissao", 3000, "PMESP Sargento III"},
  {"tenentei.permissao", 3500, "PMESP Tentente I"},
  {"tenenteii.permissao", 4000, "PMESP Tenente II"},
  {"tenenteiii.permissao", 4500, "PMESP Tenente III"},
  {"capitao.permissao", 5000, "PMESP Capitão"},
  {"coronel.permissao", 5500, "PMESP Coronel"},
  {"general.permissao", 6000, "PMESP General"},
  {"instrutor.permissao", 6500, "PMESP Instrutor"},
  {"suplente.permissao", 7000, "PMESP Suplente"},
  {"subcomando.permissao", 7500, "PMESP Sub-Comando"},
  {"comandante.permissao", 8000, "PMESP Comandante"},
  -- Policia Civil
  {"agente.permissao", 4000, "Agente Policia Civil"},
  {"inspetor.permissao", 5000, "Inspetor Policia Civil"},
  {"investigador.permissao", 6000, "Investigador Policia Civil"},
  {"delegado.permissao", 8000, "Delegado Policia Civil"},
  -- SAMU
  {"auxenf.permissao", 3000, "Aux. Enfermagem"},
  {"enfermeiro.permissao", 4000, "Enfermeiro(a)"},
  {"medico.permissao", 5000, "Médico(a)"},
  {"cirurgiao.permissao", 6000, "Cirurgiã(o)"},
  {"diretor.permissao", 8000, "Diretor SAMU"},
  -- Mecanico
  {"mecanico.permissao", 2000, "Mecanico"},
  -- {"lidermecanico.permissao", 3000, "Lider Mecanico"},
}

RegisterServerEvent('offred:salar464651684')
AddEventHandler('offred:salar464651684', function(salar)
  vRP.antiflood(source,"Pagamento Salario",2)
	local user_id = vRP.getUserId(source)
	for i,v in pairs(salarii) do
		permisiune = v[1]
		if vRP.hasPermission(user_id, permisiune)then
			salar = v[2]
      titulo = v[3]
      vRP.giveBankMoney(user_id,salar)
      TriggerClientEvent("vrp_sound:source",source,'coins',1)
      TriggerClientEvent("Notify",source,"importante","Seu salario de <b>"..titulo.."</b> de <b>R$ "..vRP.format(parseInt(salar)).."</b> foi depositado")
      -- TriggerClientEvent('chatMessage',source,"Obrigado por colaborar com a cidade! Seu salário de ^2R$"..salar.." ^0 foi depositado.")
		end
	end
end)
