local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_salar")

salarii = {
  -- VIPS
  {"boost.permissao", 2500, "Nitro Boost"},
  {"bronze.permissao", 5000, "VIP Bronze"},
  {"prata.permissao", 10000, "VIP Prata"},
  {"ouro.permissao", 15000, "VIP Ouro"},
  {"platina.permissao", 20000, "VIP Platina"},
  {"esmeralda.permissao", 25000, "VIP Esmeralda"},
  {"diamante.permissao", 30000, "VIP Diamante"},
  -- Policia Militar
  {"recruta.permissao", 4000, "PMESP Recruta"},
  {"soldado.permissao", 4500, "PMESP Soldado"},
  {"cabo.permissao", 5000, "PMESP Cabo"},
  {"sargentoiii.permissao", 5500, "PMESP Sargento III"},
  {"sargentoii.permissao", 5500, "PMESP Sargento II"},
  {"sargentoi.permissao", 5500, "PMESP Sargento I"},
  {"tenenteiii.permissao", 6000, "PMESP Tenente III"},
  {"tenenteii.permissao", 6000, "PMESP Tenente II"},
  {"tenentei.permissao", 6000, "PMESP Tentente I"},
  {"capitao.permissao", 6500, "PMESP Capitão"},
  {"coronel.permissao", 7000, "PMESP Coronel"},
  {"general.permissao", 7000, "PMESP General"},
  {"instrutor.permissao", 7500, "PMESP Instrutor"},
  {"suplente.permissao", 7500, "PMESP Suplente"},
  {"subcomando.permissao", 8000, "PMESP Sub-Comando"},
  {"comandante.permissao", 8000, "PMESP Comandante"},
  -- ROTA
  {"sargentorota.permissao", 5500, "Sargento ROTA"},
  {"subtenenterota.permissao", 6300, "Sub-Tenente ROTA"},
  {"tenenterotaii.permissao", 6600, "2º Tenente ROTA"},
  {"tenenterotai.permissao", 7000, "1º Tenente ROTA"},
  {"capitaorota.permissao", 7200, "Capitão ROTA"},
  {"majorrota.permissao", 7400, "Major ROTA"},
  {"tenentecoronelrota.permissao", 7500, "Tenente-Coronel ROTA"},
  {"coronelrota.permissao", 8000, "Coronel ROTA"},
  -- Policia Civil
  {"agente.permissao", 4000, "Agente Policia Civil"},
  {"inspetor.permissao", 5000, "Inspetor Policia Civil"},
  {"investigador.permissao", 6000, "Investigador Policia Civil"},
  {"delegado.permissao", 8000, "Delegado Policia Civil"},
  -- PRF
  {"agenteiprf.permissao", 2000, "Agente PRF"},
  {"agenteiiprf.permissao", 3000, "Agente Operacional PRF"},
  {"agenteiiiprf.permissao", 5000, "Agente Especial PRF"},
  {"diretorprf.permissao", 8000, "Diretor PRF"},
  {"delegadoprf.permissao", 8000, "Delegado PRF"},
  -- SAMU
  {"auxenf.permissao", 3000, "Aux. Enfermagem"},
  {"enfermeiro.permissao", 4000, "Enfermeiro(a)"},
  {"medico.permissao", 5000, "Médico(a)"},
  {"cirurgiao.permissao", 6000, "Cirurgiã(o)"},
  {"diretor.permissao", 8000, "Diretor SAMU"},
  -- Mecanico
  -- {"mecanico.permissao", 2000, "Mecanico"},
  -- Judiciário
  {"juiz.permissao", 8000, "Juiz"},
  {"promotor.permissao", 8000, "Promotor"},
  {"advogado.permissao", 6000, "Advogado"},
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
