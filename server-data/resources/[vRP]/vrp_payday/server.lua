local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_salar")

salarii = {
  -- VIPS
  {"boost.permissao", 2500, "Nitro Boost 1"},
  {"boostii.permissao", 5000, "Nitro Boost 2"},
  {"ouro.permissao", 8000, "VIP Ouro"},
  {"platina.permissao", 8000, "VIP Platina"},
  {"esmeralda.permissao", 8000, "VIP Esmeralda"},
  {"diamante.permissao", 8000, "VIP Diamante"},
  -- STAFF
  {"kick.permissao", 8000, "STAFF"},
  -- Policia Militar
  {"pmfci.permissao", 6000, "PMFC I"},
  {"pmfcii.permissao", 7000, "PMFC II"},
  {"pmfciii.permissao", 8000, "PMFC III"},
  {"pmfciv.permissao", 8000, "PMFC Comando"},
  -- SAMU
  {"samui.permissao", 6000, "SAMU I"},
  {"samuii.permissao", 7000, "SAMU II"},
  {"samuiii.permissao", 8000, "SAMU III"},
  {"samuiv.permissao", 8000, "SAMU Diretor(a)"},
  -- Mecanico
  {"mecanico.permissao", 2000, "Mecanico"},
  -- Judiciário
  {"advogado.permissao", 6000, "Advogado"},
  {"promotor.permissao", 7000, "Promotor"},
  {"juiz.permissao", 8000, "Juíz"},
  -- Promotores de Eventos
  {"lojinha.permissao", 1000, "Promotor de Eventos"},
  -- Apoiador Vaquinha
  {"apoiador.permissao", 3000, "Apoiador Fênix City"},
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
