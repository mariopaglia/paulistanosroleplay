local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_salar")

salarii = {
  -- VIPS
  {"boost.permissao", 2500, "Nitro Boost"},
  {"bronze.permissao", 5000, "VIP Bronze"},
  {"prata.permissao", 10000, "VIP Prata"},
  {"ouro.permissao", 5000, "VIP Ouro"},
  {"platina.permissao", 8000, "VIP Platina"},
  {"esmeralda.permissao", 8000, "VIP Esmeralda"},
  {"diamante.permissao", 8000, "VIP Diamante"},
  -- STAFF
  {"kick.permissao", 8000, "STAFF"},
  -- Policia Militar
  {"pmespi.permissao", 6000, "PMESP I"},
  {"pmespii.permissao", 7000, "PMESP II"},
  {"pmespiii.permissao", 8000, "PMESP III"},
  {"pmespiv.permissao", 8000, "PMESP Comando"},
  -- ROTA
  {"rotai.permissao", 6000, "ROTA I"},
  {"rotaii.permissao", 7000, "ROTA II"},
  {"rotaiii.permissao", 8000, "ROTA III"},
  {"rotaiv.permissao", 8000, "ROTA Comando"},
  -- Policia Civil
  {"pcivili.permissao", 6000, "Polícia Civil I"},
  {"pcivilii.permissao", 7000, "Polícia Civil II"},
  {"pciviliii.permissao", 8000, "Polícia Civil III"},
  {"pciviliv.permissao", 8000, "Polícia Civil Comando"},
  -- PRF
  {"prfi.permissao", 6000, "PRF I"},
  {"prfii.permissao", 7000, "PRF II"},
  {"prfiii.permissao", 8000, "PRF III"},
  {"prfiv.permissao", 8000, "PRF Comando"},
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
