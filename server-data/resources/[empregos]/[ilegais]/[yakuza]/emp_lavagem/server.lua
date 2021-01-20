local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
lav = {}
Tunnel.bindInterface("emp_lavagem",lav)
local idgens = Tools.newIDGenerator()
local blips = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookmafia = "https://discord.com/api/webhooks/800596157775872001/skIZvZegSayBpWSG4myKwcH8FYJV8m8PiorEH9SN4hdj_nbKsn0NtwbxUh_xbSExOuZJ"


function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECAR DINHEIRO SUJO
-----------------------------------------------------------------------------------------------------------------------------------------
function lav.checkDinheiro()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"dinheirosujo") >= 10000 and vRP.getInventoryItemAmount(user_id,"pendrivedeep") >= 1 then
			return true 
		else
			TriggerClientEvent("Notify",source,"negado","Sem <b>Dinheiro Sujo</b> ou <b>Pendrive Deepweb</b>") 
			return false
		end
	end
end
function lav.checkPayment()
    local source = source
    local user_id = vRP.getUserId(source)
    local policia = vRP.getUsersByPermission("policia.permissao")
    if user_id then
        if vRP.tryGetInventoryItem(user_id,"dinheirosujo",10000) and vRP.tryGetInventoryItem(user_id,"pendrivedeep",1) then
           vRP.giveMoney(user_id,parseInt(10000))
      end
   end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAMANDO POLICIA
-----------------------------------------------------------------------------------------------------------------------------------------
function lav.lavagemPolicia(id,x,y,z,head)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local policia = vRP.getUsersByPermission("policia.permissao")
		TriggerClientEvent('iniciandolavagem1',source,head,x,y,z)
		vRPclient._playAnim(source,false,{{"anim@heists@prison_heistig1_p1_guard_checks_bus","loop"}},true)
		local random = math.random(100)
		if random > 100 then
			vRPclient.setStandBY(source,parseInt(60))
			for l,w in pairs(policia) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						local ids = idgens:gen()
						blips[ids] = vRPclient.addBlip(player,x,y,z,1,59,"Ocorrencia",0.5,true)
						TriggerClientEvent('chatMessage',player,"911",{64,64,255},"^1Lavagem^0 de dinheiro em andamento.")
						SetTimeout(5000,function() vRPclient.removeBlip(player,blips[ids]) idgens:free(ids) end)
					end)
				end
			end
		end	
	end
end

function lav.checkpermission()
	local source = source
	local user_id = vRP.getUserId(source)
	if not vRP.hasPermission(user_id,"yakuza.permissao") then
		TriggerClientEvent("Notify",source,"negado","Você não tem permissão para isso.") 
		return false
	else
		return true
	end
end

function lav.webhookmafia ()
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	return SendWebhookMessage(webhookmafia,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
end