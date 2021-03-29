local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_taxista",emP)
local taxiMeter = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.addGroup()
	local source = source
	local user_id = vRP.getUserId(source)
	vRP.addUserGroup(user_id,"Taxista")
end

function emP.removeGroup()
	local source = source
	local user_id = vRP.getUserId(source)
	vRP.removeUserGroup(user_id,"Taxista")
	TriggerClientEvent('desligarRadios',source)
end

function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"taxista.permissao")
end

function emP.checkPayment(payment)
  vRP.antiflood(source,"taxista",3)  
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        randmoney = (math.random(1800,2300)*payment)
        vRP.injectMoneyLimpo(user_id,parseInt(randmoney))
        TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
        TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>R$ "..vRP.format(parseInt(randmoney)).."</b>.")
      end
    end
    
function emP.cobrarTaxa()
    local source = source
    local user_id = vRP.getUserId(source)

    if vRP.request(source,"Deseja pagar <b>R$ 1.000</b> pela licença <b>temporária</b> de taxista?",30) then
        if vRP.tryFullPayment(user_id, 1000) then
            return true
        else
            TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente")
            return false
        end
    else
        return false
    end  
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES DO TAXIMETRO
-----------------------------------------------------------------------------------------------------------------------------------------
function round(num, numDecimalPlaces)
  local mult = 5^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.3) / mult
end

function splitString(str, sep)
  if sep == nil then sep = "%s" end

  local t={}
  local i=1

  for str in string.gmatch(str, "([^"..sep.."]+)") do
    t[i] = str
    i = i + 1
  end

  return t
end