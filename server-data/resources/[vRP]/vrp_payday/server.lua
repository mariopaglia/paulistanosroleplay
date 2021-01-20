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
  -- Policia
  {"policia.permissao", 5000, "Policial"},
  {"comandante.permissao", 3000, "Comandante PMESP"},
  {"delegado.permissao", 3000, "Delegado Policia Civil"},
  -- SAMU
  {"paramedico.permissao", 5000, "Médico/Paramédico"},
  {"diretor.permissao", 3000, "Diretor SAMU"},
  -- Mecanico
  -- {"funcmecanico.permissao", 2000, "Mecanico"},
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
