local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_salar")

salarii = {
  -- VIPS
  {"bronze.permissao", 2000, "VIP Bronze"},
  {"prata.permissao", 4000, "VIP Prata"},
  {"ouro.permissao", 6000, "VIP Ouro"},
  {"diamante.permissao", 8000, "VIP Diamante"},
  {"boost.permissao", 1000, "Nitro Boost"},
  -- Policia Militar (PMESP)
  {"recruta.permissao", 1000, "Recruta PMESP"},
  {"soldado.permissao", 2000, "Soldado PMESP"},
  {"tenente.permissao", 3000, "Tenente PMESP"},
  {"capitao.permissao", 4000, "Capitão PMESP"},
  {"coronel.permissao", 5000, "Coronel PMESP"},
  {"comandante.permissao", 10000, "Comandante PMESP"},
   -- ROTA
  {"recrutar.permissao", 2000, "Recruta ROTA"},
  {"soldador.permissao", 3000, "Soldado ROTA"},
  {"tenenter.permissao", 4000, "Tenente ROTA"},
  {"capitaor.permissao", 5000, "Capitão ROTA"},
  {"coronelr.permissao", 6000, "Coronel ROTA"},
  {"comandanter.permissao", 10000, "Comandante ROTA"},
  -- Policia Civil
  {"agente.permissao", 4000, "Agente Policia Civil"},
  {"inspetor.permissao", 5000, "Inspetor Policia Civil"},
  {"investigador.permissao", 6000, "Investigador Policia Civil"},
  {"delegado.permissao", 10000, "Delegado Policia Civil"},
  -- SAMU
  {"enfermeiro.permissao", 4000, "Enfermeiro SAMU"},
  {"medico.permissao", 6000, "Médico SAMU"},
  {"diretor.permissao", 10000, "Diretor SAMU"},
  -- Mecanico
  {"funcmecanico.permissao", 2000, "Mecanico"},
  {"lidermecanico.permissao", 4000, "Lider Mecanico"},
  -- Concessionária
  {"concessionaria.permissao", 4000, "Vendedor Concessionária"},


}

RegisterServerEvent('offred:salar')
AddEventHandler('offred:salar', function(salar)
	local user_id = vRP.getUserId(source)
	for i,v in pairs(salarii) do
		permisiune = v[1]
		if vRP.hasPermission(user_id, permisiune)then
			salar = v[2]
      titulo = v[3]
      vRP.giveBankMoney(user_id,salar)
      TriggerClientEvent("vrp_sound:source",source,'coins',1)
      TriggerClientEvent("Notify",source,"importante","Seu salario de <b>"..titulo.."</b> de <b>R$ "..salar.."</b> foi depositado.")
      -- TriggerClientEvent('chatMessage',source,"Obrigado por colaborar com a cidade! Seu salário de ^2R$"..salar.." ^0 foi depositado.")
		end
	end
end)
