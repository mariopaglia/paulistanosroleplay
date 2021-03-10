local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local Tools = module("vrp","lib/Tools")
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookpmesp = "https://discord.com/api/webhooks/809191725490110465/p7pfd4VTGWwP9d-oIHJvMGw6kzviuLJcESLYe2u3kr3_pwGFw-jiRk2OOz9uMW_4Tbcr"
local webhookpcesp = "https://discord.com/api/webhooks/809892713758851092/wMGCoBzvyLhAJM2k2_gTKfIMWGNgLoGtqhEp3oJEgCd7ChsAdr67zsGSaDBo4p-Gy9Ig"
local webhookapreender = "https://discord.com/api/webhooks/809195069248372756/RHFtPdKE1vNSUSAeYA7sF1qMJHSE8XRU0-Z6fStQ9c1Yhv7I5Ud8bkxMyjIXFfTkKzAK"
local webhookmultas = "https://discord.com/api/webhooks/809195388212478053/muZa0KZ_0MPzOSHdf9DQTWG3CE-i4hovfs1e3MlwP78CUbH6IuYNWBu93KRTEdL6eYJN"
local webhookparamedico = "https://discord.com/api/webhooks/793597683155599380/ql-y4081JzoLAv-KwjKVFmDZLMvfVmFNSFnig6NKSyxCvsfzN51lJuui9S0rsrm8doKk"
local webhookbennys = "https://discord.com/api/webhooks/793597828386521108/UsgyanaAIxAXtNuDuP8Cbf67cauDpARltO9RxIAsGioYKolylf3TWyJl_CtTRyK5sA3O"
local webhooksportrace = "https://discord.com/api/webhooks/809191208429158421/aeVf8HgBwbKprnhaz4Za3HSirDrp6U1-ANqZUtvVlo4L_BFYvx-Jih6vPT3kSkOcJBpg"
local webhookprender = "https://discord.com/api/webhooks/809192611272720444/2fNnIhLub2cFHqmbqKr5K8tLSVx4EQZXZcKjHqmbR-EitNlHjVdvpe4zcR_eflXf7Nup"
local webhookdetido = "https://discord.com/api/webhooks/809192685256704010/m7ZhD49uRRXQv29tITj8i0kigzoCJHLKaUY-R9xkQF45X5MERx2XBfjH-qCvHMyr_AdE"
local webhookre = "https://discord.com/api/webhooks/801625540917723156/GObuH96poB7LSHB-wtzjaVH8dgOf-adONt1EaBKtHs215eaQgLIult4XGimjQBxKefKX"
local webhookconce = "https://discord.com/api/webhooks/809187305267920968/wOE6E6i2qerRtu8P5rn2dIGgiFy9dDzdGzZ1DGORizXtZJEkZngwaKPcstQ6ARKpXJcZ"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARSENAL
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand('arsenal',function(source,args,rawCommand)
-- 	local user_id = vRP.getUserId(source)
-- 	if vRP.hasPermission(user_id,"policia.permissao") then
-- 		TriggerClientEvent('arsenal',source)
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLACA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('placa',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"placa.permissao") or vRP.hasPermission(user_id,"policia.permissao") then
		if args[1] then
			local user_id = vRP.getUserByRegistration(args[1])
			if user_id then
				local identity = vRP.getUserIdentity(user_id)
				if identity then
					vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
					TriggerClientEvent('chatMessage',source,"190",{64,64,255},"^1Passaporte: ^0"..identity.user_id.."   ^2|   ^1Placa: ^0"..identity.registration.."   ^2|   ^1Proprietário: ^0"..identity.name.." "..identity.firstname.."   ^2|   ^1Idade: ^0"..identity.age.." anos   ^2|   ^1Telefone: ^0"..identity.phone)
				end
			else
				TriggerClientEvent("Notify",source,"importante","Placa inválida ou veículo de americano.")
			end
		else
			local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,7)
			local placa_user = vRP.getUserByRegistration(placa)
			if placa then
				if placa_user then
					local identity = vRP.getUserIdentity(placa_user)
					if identity then
						local vehicleName = vRP.vehicleName(vname)
						vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
						TriggerClientEvent('chatMessage',source,"190",{64,64,255},"^1Passaporte: ^0"..identity.user_id.."   ^2|   ^1Placa: ^0"..identity.registration.."   ^2|   ^1Placa: ^0"..identity.registration.."   ^2|   ^1Proprietário: ^0"..identity.name.." "..identity.firstname.."   ^2|   ^1Modelo: ^0"..vehicleName.."   ^2|   ^1Idade: ^0"..identity.age.." anos   ^2|   ^1Telefone: ^0"..identity.phone)
					end
				else
					TriggerClientEvent("Notify",source,"importante","Placa inválida ou veículo de americano.")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYTOW
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand('paytow',function(source,args,rawCommand)
-- 	local user_id = vRP.getUserId(source)
-- 	if vRP.hasPermission(user_id,"policia.permissao") then
-- 		local nplayer = vRPclient.getNearestPlayer(source,2)
-- 		if nplayer then
-- 			local nuser_id = vRP.getUserId(nplayer)
-- 			if nuser_id then
-- 				vRP.giveMoney(nuser_id,500)
-- 				vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
-- 				TriggerClientEvent("Notify",source,"sucesso","Efetuou o pagamento pelo serviço do mecânico.")
-- 				TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>$500 dólares</b> pelo serviço de mecânico.")
-- 				vRP.logs("savedata/paytow.txt","[ID]: "..user_id.." / [NID]: "..nuser_id.." / [FUNÇÃO]: Paytow")
-- 			end
-- 		end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOOGLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('toogle',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICIA MILITAR (PMESP)
-----------------------------------------------------------------------------------------------------------------------------------------

	if vRP.hasPermission(user_id,"recruta.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"RecrutaP")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"tooglerec.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		vRP.addUserGroup(user_id,"Recruta")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
---------------------
-- SOLDADO PMESP
---------------------
	elseif vRP.hasPermission(user_id,"soldado.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"SoldadoP")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"tooglesol.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		vRP.addUserGroup(user_id,"Soldado")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
---------------------
-- CABO PMESP
---------------------
	elseif vRP.hasPermission(user_id,"cabo.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"CaboP")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"tooglecabo.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		vRP.addUserGroup(user_id,"Cabo")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
---------------------
-- SARGENTO I PMESP
---------------------
	elseif vRP.hasPermission(user_id,"sargentoi.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"Sargento1P")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"tooglesargentoi.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		vRP.addUserGroup(user_id,"Sargento1")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
---------------------
-- SARGENTO II PMESP
---------------------
	elseif vRP.hasPermission(user_id,"sargentoii.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"Sargento2P")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"tooglesargentoii.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		vRP.addUserGroup(user_id,"Sargento2")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
---------------------
-- SARGENTO III PMESP
---------------------
	elseif vRP.hasPermission(user_id,"sargentoiii.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"Sargento3P")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"tooglesargentoiii.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		vRP.addUserGroup(user_id,"Sargento3")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
---------------------
-- TENENTE´I PMESP
---------------------
	elseif vRP.hasPermission(user_id,"tenentei.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"Tenente1P")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"toogletenentei.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		vRP.addUserGroup(user_id,"Tenente1")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
---------------------
-- TENENTE´II PMESP
---------------------
	elseif vRP.hasPermission(user_id,"tenenteii.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"Tenente2P")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"toogletenenteii.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		vRP.addUserGroup(user_id,"Tenente2")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
---------------------
-- TENENTE´III PMESP
---------------------
	elseif vRP.hasPermission(user_id,"tenenteiii.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"Tenente3P")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"toogletenenteiii.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		vRP.addUserGroup(user_id,"Tenente3")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
---------------------
-- CAPITÃO PMESP
---------------------
	elseif vRP.hasPermission(user_id,"capitao.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"CapitaoP")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"tooglecap.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		vRP.addUserGroup(user_id,"Capitao")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
---------------------
-- CORONEL PMESP
---------------------
	elseif vRP.hasPermission(user_id,"coronel.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"CoronelP")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"tooglecor.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		vRP.addUserGroup(user_id,"Coronel")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
---------------------
-- GENERAL PMESP
---------------------
	elseif vRP.hasPermission(user_id,"general.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"GeneralP")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"tooglegeneral.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		vRP.addUserGroup(user_id,"General")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
---------------------
-- INSTRUTOR PMESP
---------------------
	elseif vRP.hasPermission(user_id,"instrutor.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"InstrutorP")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"toogleinstrutor.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		vRP.addUserGroup(user_id,"Instrutor")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
---------------------
-- SUPLENTE PMESP
---------------------
	elseif vRP.hasPermission(user_id,"suplente.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"SuplenteP")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"tooglesuplente.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		vRP.addUserGroup(user_id,"Suplente")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
---------------------
-- SUB-COMANDO PMESP
---------------------
	elseif vRP.hasPermission(user_id,"subcomando.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"SubcomandoP")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"tooglesubcomando.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		vRP.addUserGroup(user_id,"Subcomando")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
---------------------
-- COMANDANTE PMESP
---------------------
	elseif vRP.hasPermission(user_id,"comandante.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"ComandanteP")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"tooglecmd.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
		vRP.addUserGroup(user_id,"Comandante")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICIA CIVIL
-----------------------------------------------------------------------------------------------------------------------------------------

---------------------
-- AGENTE POLICIA CÍVIL
---------------------
	elseif vRP.hasPermission(user_id,"agente.permissao") then
		-- TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"AgenteP")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookpcesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"toogleagente.permissao") then
		-- TriggerEvent('eblips:add',{ name = "Policial Civil", src = source, color = 37 })
		vRP.addUserGroup(user_id,"Agente")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou de serviço.")
		SendWebhookMessage(webhookpcesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
---------------------
-- INSPETOR POLICIA CÍVIL
---------------------
	elseif vRP.hasPermission(user_id,"inspetor.permissao") then
		-- TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"InspetorP")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookpcesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"toogleins.permissao") then
		-- TriggerEvent('eblips:add',{ name = "Policial Civil", src = source, color = 37 })
		vRP.addUserGroup(user_id,"Inspetor")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou de serviço.")
		SendWebhookMessage(webhookpcesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
---------------------
-- INVESTIGADOR POLICIA CÍVIL
---------------------
	elseif vRP.hasPermission(user_id,"investigador.permissao") then
		-- TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"InvestigadorP")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookpcesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"toogleinv.permissao") then
		-- TriggerEvent('eblips:add',{ name = "Policial Civil", src = source, color = 37 })
		vRP.addUserGroup(user_id,"Investigador")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou de serviço.")
		SendWebhookMessage(webhookpcesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
---------------------
-- DELEGADO POLICIA CÍVIL
---------------------
	elseif vRP.hasPermission(user_id,"delegado.permissao") then
		-- TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"DelegadoP")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookpcesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"toogledel.permissao") then
		-- TriggerEvent('eblips:add',{ name = "Policial Civil", src = source, color = 37 })
		vRP.addUserGroup(user_id,"Delegado")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou de serviço.")
		SendWebhookMessage(webhookpcesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICIA RODOVIÁRIA FEDERAL
-----------------------------------------------------------------------------------------------------------------------------------------

---------------------
-- POLICIAL PRF
---------------------
	elseif vRP.hasPermission(user_id,"prf.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PRFP")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"toogleprf.permissao") then
		TriggerEvent('eblips:add',{ name = "Policial Civil", src = source, color = 47 })
		vRP.addUserGroup(user_id,"PRF")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou de serviço.")
		SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

-----------------------------------------------------------------------------------------------------------------------------------------
-- HOSPITAL
-----------------------------------------------------------------------------------------------------------------------------------------

---------------------
-- AUXILIAR ENFERMAGEM
---------------------
	elseif vRP.hasPermission(user_id,"auxenf.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"AuxEnfermeiroP")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookparamedico,"```prolog\n[SAMU]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"toogleauxenf.permissao") then
		TriggerEvent('eblips:add',{ name = "SAMU", src = source, color = 49 })
		vRP.addUserGroup(user_id,"AuxEnfermeiro")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhookparamedico,"```prolog\n[SAMU]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
---------------------
-- ENFERMEIRO
---------------------
	elseif vRP.hasPermission(user_id,"enfermeiro.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaEnfermeiro")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookparamedico,"```prolog\n[SAMU]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"toogleenf.permissao") then
		TriggerEvent('eblips:add',{ name = "SAMU", src = source, color = 49 })
		vRP.addUserGroup(user_id,"Enfermeiro")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhookparamedico,"```prolog\n[SAMU]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
---------------------
-- MÉDICO/PARAMÉDICO
---------------------
	elseif vRP.hasPermission(user_id,"medico.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaMedico")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookparamedico,"```prolog\n[SAMU]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"tooglemed.permissao") then
		TriggerEvent('eblips:add',{ name = "SAMU", src = source, color = 49 })
		vRP.addUserGroup(user_id,"Medico")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhookparamedico,"```prolog\n[SAMU]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
---------------------
-- CIRURGIÃO
---------------------
	elseif vRP.hasPermission(user_id,"cirurgiao.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"CirurgiaoP")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookparamedico,"```prolog\n[SAMU]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"tooglecirurgiao.permissao") then
		TriggerEvent('eblips:add',{ name = "SAMU", src = source, color = 49 })
		vRP.addUserGroup(user_id,"Cirurgiao")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhookparamedico,"```prolog\n[SAMU]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
---------------------
-- DIRETOR HOSPITAL
---------------------
	elseif vRP.hasPermission(user_id,"diretor.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaDiretor")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookparamedico,"```prolog\n[SAMU]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"tooglediretor.permissao") then
		TriggerEvent('eblips:add',{ name = "SAMU", src = source, color = 49 })
		vRP.addUserGroup(user_id,"Diretor")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhookparamedico,"```prolog\n[SAMU]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONCESSIONÁRIA
-----------------------------------------------------------------------------------------------------------------------------------------
---------------------
-- VENDEDOR CONCESSIONÁRIA
---------------------
	elseif vRP.hasPermission(user_id,"concessionaria.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"CONCEP")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookconce,"```prolog\n[VENDEDOR]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"vendedorpaisana.permissao") then
		vRP.addUserGroup(user_id,"CONCE")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhookconce,"```prolog\n[VENDEDOR]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

-----------------------------------------------------------------------------------------------------------------------------------------
-- BENNYS
-----------------------------------------------------------------------------------------------------------------------------------------
---------------------
-- MECANICO
---------------------
	elseif vRP.hasPermission(user_id,"bennys.permissao") then
		-- TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"BennysP")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhookbennys,"```prolog\n[MECANICO]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"paisanabennys.permissao") then
		vRP.addUserGroup(user_id,"Bennys")
		-- TriggerEvent('eblips:add',{ name = "Mecanico", src = source, color = 48 })
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhookbennys,"```prolog\n[MECANICO]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

-----------------------------------------------------------------------------------------------------------------------------------------
-- SPORTRACE
-----------------------------------------------------------------------------------------------------------------------------------------
---------------------
-- MECANICO
---------------------
	elseif vRP.hasPermission(user_id,"sportrace.permissao") then
		-- TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"SportRaceP")
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		SendWebhookMessage(webhooksportrace,"```prolog\n[MECANICO]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent('desligarRadios',source)
	elseif vRP.hasPermission(user_id,"paisanasportrace.permissao") then
		vRP.addUserGroup(user_id,"SportRace")
		-- TriggerEvent('eblips:add',{ name = "Mecanico", src = source, color = 48 })
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhooksportrace,"```prolog\n[MECANICO]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- MULTAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('multar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		local id = vRP.prompt(source,"Passaporte:","")
		local valor = vRP.prompt(source,"Valor:","")
		local motivo = vRP.prompt(source,"Motivo:","")
		if id == "" or valor == "" or motivo == "" then
			return
		end
		local value = vRP.getUData(parseInt(id),"vRP:multas")
		local multas = json.decode(value) or 0
		vRP.setUData(parseInt(id),"vRP:multas",json.encode(parseInt(multas)+parseInt(valor)))
		local oficialid = vRP.getUserIdentity(user_id)
		local identity = vRP.getUserIdentity(parseInt(id))
		local nplayer = vRP.getUserSource(parseInt(id))
		SendWebhookMessage(webhookmultas,"```prolog\n[OFICIAL]: "..user_id.." "..oficialid.name.." "..oficialid.firstname.." \n[==============MULTOU==============] \n[PASSAPORTE]: "..id.." "..identity.name.." "..identity.firstname.." \n[VALOR]: R$ "..vRP.format(parseInt(valor)).." \n[MOTIVO]: "..motivo.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

		randmoney = math.random(100,500)
		vRP.giveMoney(user_id,parseInt(randmoney))
		TriggerClientEvent("Notify",source,"sucesso","Multa aplicada com sucesso.")
		TriggerClientEvent("Notify",source,"importante","Você recebeu <b>R$ "..vRP.format(parseInt(randmoney)).."</b> de bonificação.")
		TriggerClientEvent("Notify",nplayer,"importante","Você foi multado em <b>R$ "..vRP.format(parseInt(valor)).."</b>.<br><b>Motivo:</b> "..motivo..".")
		vRPclient.playSound(source,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- REANIMAR
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand('reanimar',function(source,args,rawCommand)
-- 	local user_id = vRP.getUserId(source)
-- 	if vRP.hasPermission(user_id,"paramedico.permissao") then
-- 		TriggerClientEvent('reanimar',source)
-- 	end
-- end)

-- RegisterServerEvent("reanimar:pagamento")
-- AddEventHandler("reanimar:pagamento",function()
-- 	local user_id = vRP.getUserId(source)
-- 	if user_id then
-- 		pagamento = math.random(50,80)
-- 		vRP.giveMoney(user_id,pagamento)
-- 		TriggerClientEvent("Notify",source,"sucesso","Recebeu <b>$"..pagamento.." dólares</b> de gorjeta do americano.")
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DETIDO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('detido',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"policia.permissao") then
        local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,5)
        local motivo = vRP.prompt(source,"Motivo:","")
        if motivo == "" then
			return
		end
		local oficialid = vRP.getUserIdentity(user_id)
        if vehicle then
            local puser_id = vRP.getUserByRegistration(placa)
            local rows = vRP.query("creative/get_vehicles",{ user_id = parseInt(puser_id), vehicle = vname })
            if rows[1] then
                if parseInt(rows[1].detido) == 1 then
                    TriggerClientEvent("Notify",source,"importante","Este veículo já se encontra detido.",8000)
                else
                	local identity = vRP.getUserIdentity(puser_id)
					local nplayer = vRP.getUserSource(parseInt(puser_id))
					local crds = GetEntityCoords(GetPlayerPed(source))
                	SendWebhookMessage(webhookdetido,"```prolog\n[OFICIAL]: "..user_id.." "..oficialid.name.." "..oficialid.firstname.." \n[==============PRENDEU==============] \n[CARRO]: "..vname.." \n[PASSAPORTE]: "..puser_id.." "..identity.name.." "..identity.firstname.." \n[MOTIVO]: "..motivo.."\n[COORDENADA]: "..crds.x..","..crds.y..","..crds.z..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                    vRP.execute("creative/set_detido",{ user_id = parseInt(puser_id), vehicle = vname, detido = 1, time = parseInt(os.time()) })

					randmoney = math.random(100,500)
					vRP.giveMoney(user_id,parseInt(randmoney))
					TriggerClientEvent("Notify",source,"sucesso","Veículo apreendido com sucesso.")
					TriggerClientEvent("Notify",source,"importante","Você recebeu <b>R$ "..vRP.format(parseInt(randmoney)).."</b> de bonificação.")
					TriggerClientEvent("Notify",nplayer,"importante","Seu Veículo foi <b>Detido</b>.<br><b>Motivo:</b> "..motivo..".")
					vRPclient.playSound(source,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
                end
            end
        end
    end
end) 

-----------------------------------------------------------------------------------------------------------------------------------------
-- PRENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('prender',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		local player = vRP.getUserSource(parseInt(args[1]))
		vRP.setUData(parseInt(args[1]),"vRP:prisao",json.encode(parseInt(args[2])))
		vRPclient.setHandcuffed(player,false)
		local crimes = vRP.prompt(source,"Crimes:","")
		if crimes == "" then
			return
		end
		TriggerClientEvent('prisioneiro',player,true)
		vRPclient._playSound(source,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
		TriggerClientEvent("vrp_sound:source",player,'jaildoor',1)
		vRPclient.teleport(player,1680.1,2513.0,45.5)

		local oficialid = vRP.getUserIdentity(user_id)
		local identity = vRP.getUserIdentity(parseInt(args[1]))
		local nplayer = vRP.getUserSource(parseInt(args[1]))
		SendWebhookMessage(webhookprender,"```prolog\n[OFICIAL]: "..user_id.." "..oficialid.name.." "..oficialid.firstname.." \n[==============PRENDEU==============] \n[PASSAPORTE]: "..(args[1]).." "..identity.name.." "..identity.firstname.." \n[TEMPO]: "..vRP.format(parseInt(args[2])).." Meses \n[CRIMES]: "..crimes.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

		randmoney = math.random(500,2000)
		vRP.giveMoney(user_id,parseInt(randmoney))
		TriggerClientEvent("Notify",source,"sucesso","Prisão efetuada com sucesso, você recebeu <b>R$ "..vRP.format(parseInt(randmoney)).."</b> de bonificação")
		TriggerClientEvent("Notify",player,"importante","Você foi preso pelos seguintes crimes: <b>"..crimes.."</b>")
		prison_lock(parseInt(args[1]))
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PRENDER POR ADV (SOMENTE ADM)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('prenderadv',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local player = vRP.getUserSource(parseInt(args[1]))
		vRP.setUData(parseInt(args[1]),"vRP:prisao",json.encode(parseInt(args[2])))
		vRPclient.setHandcuffed(player,false)
		local crimes = vRP.prompt(source,"Crimes:","")
		if crimes == "" then
			return
		end
		TriggerClientEvent('prisioneiro',player,true)
		vRPclient._playSound(source,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
		TriggerClientEvent("vrp_sound:source",player,'jaildoor',1)
		vRPclient.teleport(player,1680.1,2513.0,45.5)

		TriggerClientEvent("Notify",source,"sucesso","Prisão efetuada com sucesso!")
		TriggerClientEvent("Notify",player,"importante","Você foi preso pelos seguintes crimes: <b>"..crimes.."</b>")
		prison_lock(parseInt(args[1]))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rg',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer == nil then
				TriggerClientEvent("Notify",source,"aviso","Passaporte <b>"..vRP.format(args[1]).."</b> indisponível no momento.")
				return
			end
			nuser_id = vRP.getUserId(nplayer)
			if nuser_id then
				local value = vRP.getUData(nuser_id,"vRP:multas")
				local valormultas = json.decode(value) or 0
				local identity = vRP.getUserIdentity(nuser_id)
				local carteira = vRP.getMoney(nuser_id)
				local banco = vRP.getBankMoney(nuser_id)
				vRPclient.setDiv(source,"completerg",".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 13px; font-family: arial; color: #fff; width: 420px; padding: 20px 20px 5px; bottom: 25%; right: 20px; position: absolute; border: 1px solid rgba(255,255,255,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local2 { width: 200px; padding-bottom: 15px; float: left; } .local b, .local2 b { color: #00BFFF; }","<div class=\"local\"><b>Nome:</b> "..identity.name.." "..identity.firstname.." ( "..vRP.format(identity.user_id).." )</div><div class=\"local2\"><b>Identidade:</b> "..identity.registration.."</div><div class=\"local\"><b>Idade:</b> "..identity.age.." Anos</div><div class=\"local2\"><b>Telefone:</b> "..identity.phone.."</div><div class=\"local\"><b>Multas pendentes:</b> "..vRP.format(parseInt(valormultas)).."</div><div class=\"local2\"><b>Carteira:</b> "..vRP.format(parseInt(carteira)).."</div>")
				vRP.request(source,"Você deseja fechar o registro geral?",1000)
				vRPclient.removeDiv(source,"completerg")
			end
		else
			local nplayer = vRPclient.getNearestPlayer(source,2)
			local nuser_id = vRP.getUserId(nplayer)
			if nuser_id then
				local value = vRP.getUData(nuser_id,"vRP:multas")
				local valormultas = json.decode(value) or 0
				local identityv = vRP.getUserIdentity(user_id)
				local identity = vRP.getUserIdentity(nuser_id)
				local carteira = vRP.getMoney(nuser_id)
				local banco = vRP.getBankMoney(nuser_id)
				TriggerClientEvent("Notify",nplayer,"importante","Seu documento está sendo verificado por <b>"..identityv.name.." "..identityv.firstname.."</b>.")
				vRPclient.setDiv(source,"completerg",".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 13px; font-family: arial; color: #fff; width: 420px; padding: 20px 20px 5px; bottom: 25%; right: 20px; position: absolute; border: 1px solid rgba(255,255,255,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local2 { width: 200px; padding-bottom: 15px; float: left; } .local b, .local2 b { color: #00BFFF; }","<div class=\"local\"><b>Nome:</b> "..identity.name.." "..identity.firstname.." ( "..vRP.format(identity.user_id).." )</div><div class=\"local2\"><b>Identidade:</b> "..identity.registration.."</div><div class=\"local\"><b>Idade:</b> "..identity.age.." Anos</div><div class=\"local2\"><b>Telefone:</b> "..identity.phone.."</div><div class=\"local\"><b>Multas pendentes:</b> "..vRP.format(parseInt(valormultas)).."</div><div class=\"local2\"><b>Carteira:</b> "..vRP.format(parseInt(carteira)).."</div>")
				vRP.request(source,"Você deseja fechar o registro geral?",1000)
				vRPclient.removeDiv(source,"completerg")
			end
		end
	end
end)

RegisterCommand('algemar',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if vRPclient.isHandcuffed(nplayer) then
				vRPclient.toggleHandcuff(nplayer)
			else
				vRPclient.toggleHandcuff(nplayer)
			end
		else
			local nplayer = source
			if vRPclient.isHandcuffed(nplayer) then
				vRPclient.toggleHandcuff(nplayer)
			else
				vRPclient.toggleHandcuff(nplayer)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALGEMAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vrp_policia:algemar")
AddEventHandler("vrp_policia:algemar",function()
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if nplayer then
		if vRP.getInventoryItemAmount(user_id,"algemas") >= 1 then
			if vRPclient.isHandcuffed(nplayer) then
				vRPclient.toggleHandcuff(nplayer)
				TriggerClientEvent("vrp_sound:source",source,'uncuff',0.1)
				TriggerClientEvent("vrp_sound:source",nplayer,'uncuff',0.1)
			else
				TriggerClientEvent('cancelando',source,true)
				TriggerClientEvent('cancelando',nplayer,true)
				TriggerClientEvent('carregar',nplayer,source)
				vRPclient._playAnim(source,false,{{"mp_arrest_paired","cop_p2_back_left"}},false)
				vRPclient._playAnim(nplayer,false,{{"mp_arrest_paired","crook_p2_back_left"}},false)
				SetTimeout(3500,function()
					vRPclient._stopAnim(source,false)
					vRPclient.toggleHandcuff(nplayer)
					TriggerClientEvent('carregar',nplayer,source)
					TriggerClientEvent('cancelando',source,false)
					TriggerClientEvent('cancelando',nplayer,false)
					TriggerClientEvent("vrp_sound:source",source,'cuff',0.1)
					TriggerClientEvent("vrp_sound:source",nplayer,'cuff',0.1)
				end)
			end
		else
			if vRP.hasPermission(user_id,"policia.permissao") then
				if vRPclient.isHandcuffed(nplayer) then
					vRPclient.toggleHandcuff(nplayer)
					TriggerClientEvent("vrp_sound:source",source,'uncuff',0.1)
					TriggerClientEvent("vrp_sound:source",nplayer,'uncuff',0.1)
				else
					TriggerClientEvent('cancelando',source,true)
					TriggerClientEvent('cancelando',nplayer,true)
					TriggerClientEvent('carregar',nplayer,source)
					vRPclient._playAnim(source,false,{{"mp_arrest_paired","cop_p2_back_left"}},false)
					vRPclient._playAnim(nplayer,false,{{"mp_arrest_paired","crook_p2_back_left"}},false)
					SetTimeout(3500,function()
						vRPclient._stopAnim(source,false)
						vRPclient.toggleHandcuff(nplayer)
						TriggerClientEvent('carregar',nplayer,source)
						TriggerClientEvent('cancelando',source,false)
						TriggerClientEvent('cancelando',nplayer,false)
						TriggerClientEvent("vrp_sound:source",source,'cuff',0.1)
						TriggerClientEvent("vrp_sound:source",nplayer,'cuff',0.1)
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARREGAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vrp_policia:carregar")
AddEventHandler("vrp_policia:carregar",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,10)
		if nplayer then
			TriggerClientEvent('carregar',nplayer,source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RMASCARA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rmascara',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			TriggerClientEvent('rmascara',nplayer)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RCHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rchapeu',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			TriggerClientEvent('rchapeu',nplayer)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RCAPUZ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rcapuz',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			if vRPclient.isCapuz(nplayer) then
				vRPclient.setCapuz(nplayer)
				TriggerClientEvent("Notify",source,"sucesso","Capuz colocado com sucesso.")
			else
				TriggerClientEvent("Notify",source,"importante","A pessoa não está com o capuz na cabeça.")
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CARD
-----------------------------------------------------------------------------------------------------------------------------------------
local pulso = nil
local upulso = nil
RegisterCommand('vida',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	if vRP.hasPermission(user_id,"paramedico.permissao") then
		if nuser_id and vRPclient.isInComa(nplayer) then
			if upulso ~= nuser_id then
				upulso = nuser_id
				pulso = math.random(1,100)
				if pulso >= 30 then
					TriggerClientEvent("Notify",source,"importante","Essa pessoa ainda tem pulso.")
					TriggerClientEvent("Notify",nplayer,"importante","Você está pulsando.")
				elseif pulso <= 29 then
					TriggerClientEvent("Notify",source,"importante","Essa infelizmente não tem mais pulso.")
					TriggerClientEvent("Notify",nplayer,"importante","Você não tem mais pulso.")
				end
			else
				TriggerClientEvent("Notify",source,"importante","Você ja mediu o pulso dessa pessoa.")
			end
		else
			TriggerClientEvent("Notify",source,"importante","A pessoa deve estar em coma para prosseguir")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('re',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"paramedico.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		local nuser_id = vRP.getUserId(nplayer)
		if nplayer then
			local identity = vRP.getUserIdentity(user_id)
			local identityu = vRP.getUserIdentity(nuser_id)
			local crds = GetEntityCoords(GetPlayerPed(source))
			if vRPclient.isInComa(nplayer) and pulso >= 30 then
				TriggerClientEvent('cancelando',source,true)
				vRPclient._playAnim(source,false,{{"amb@medic@standing@tendtodead@base","base"},{"mini@cpr@char_a@cpr_str","cpr_pumpchest"}},true)
				TriggerClientEvent("progress",source,30000,"reanimando")
				SetTimeout(30000,function()
					vRPclient.killGod(nplayer)
					vRPclient._stopAnim(source,false)
					vRPclient._stopAnim(nplayer,false)
					vRP.giveMoney(user_id,500)
					TriggerClientEvent('cancelando',source,false)
					pulso = nil
					upulso = 0
					SendWebhookMessage(webhookre,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[REVIVEU]: "..nuser_id.." "..identityu.name.." "..identityu.firstname.."\n[COORDENADA]: "..crds.x..","..crds.y..","..crds.z..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end)
			elseif pulso == nil then
				TriggerClientEvent("Notify",source,"importante","Utilize /vida para medir o pulso.")
			elseif pulso <= 29 then
				TriggerClientEvent("Notify",source,"importante","A pessoa nao tem mais pulso.")
			else
				TriggerClientEvent("Notify",source,"importante","A pessoa precisa estar em coma para prosseguir.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cv',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,10)
		if nplayer then
			vRPclient.putInNearestVehicleAsPassenger(nplayer,7)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rv',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,10)
		if nplayer then
			vRPclient.ejectVehicle(nplayer)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APREENDER
-----------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {
	"dinheirosujo",
	"algemas",
	"capuz",
	"lockpick",
	"masterpick",
	"maconha",
	"cocaina",
	"metanfetamina",
	"placa",
	"pendrive",
	"radio",
	"c4",
	"cartaoinvasao",
	"pendrivedeep",
	"placacircuito",
	"chipset",
	"pastadecoca",
	"pino",
	"anfetamina",
	"embalagem",
	"frasco",
	"adubo",
	"ferramenta",
	"serra",
	"macarico",
	"placademetal",
	"mola",
	"capsula",
	"polvora",
	"corpodeak",
	"corpodefiveseven",
	"corpodeg36",
	"corpodemp5",
	"gatilho",
	"tecido",
	"malha",
	"linha",
	"gps",
	"colete",
	"wbody|WEAPON_DAGGER",
	"wbody|WEAPON_BAT",
	"wbody|WEAPON_BOTTLE",
	"wbody|WEAPON_CROWBAR",
	"wbody|WEAPON_FLASHLIGHT",
	"wbody|WEAPON_GOLFCLUB",
	"wbody|WEAPON_HAMMER",
	"wbody|WEAPON_HATCHET",
	"wbody|WEAPON_KNUCKLE",
	"wbody|WEAPON_KNIFE",
	"wbody|WEAPON_MACHETE",
	"wbody|WEAPON_SWITCHBLADE",
	"wbody|WEAPON_NIGHTSTICK",
	"wbody|WEAPON_WRENCH",
	"wbody|WEAPON_BATTLEAXE",
	"wbody|WEAPON_POOLCUE",
	"wbody|WEAPON_STONE_HATCHET",
	"wbody|WEAPON_PISTOL",
	"wbody|WEAPON_STUNGUN",
	"wbody|WEAPON_SNSPISTOL",
	"wbody|WEAPON_VINTAGEPISTOL",
	"wbody|WEAPON_REVOLVER",
	"wbody|WEAPON_REVOLVER_MK2",
	"wbody|WEAPON_MUSKET",
	"wbody|GADGET_PARACHUTE",
	"wbody|WEAPON_FIREEXTINGUISHER",
	"wbody|WEAPON_MICROSMG",
	"wbody|WEAPON_ASSAULTSMG",
	"wbody|WEAPON_PUMPSHOTGUN_MK2",
	"wbody|WEAPON_SPECIALCARBINE",
	"wbody|WEAPON_ASSAULTRIFLE",
	"wbody|WEAPON_BULLPUPRIFLE_MK2",
	"wbody|WEAPON_PETROLCAN",
	"wbody|WEAPON_GUSENBERG",
	"wbody|WEAPON_MACHINEPISTOL",
	"wbody|WEAPON_COMPACTRIFLE",
	"wbody|WEAPON_BULLPUPRIFLE_MK2",
	"wbody|WEAPON_RAYPISTOL",
	"wammo|WEAPON_BULLPUPRIFLE_MK2",
	"wammo|WEAPON_PISTOL",
	"wammo|WEAPON_STUNGUN",
	"wammo|WEAPON_SNSPISTOL",
	"wammo|WEAPON_VINTAGEPISTOL",
	"wammo|WEAPON_MUSKET",
	"wammo|WEAPON_FLARE",
	"wammo|GADGET_PARACHUTE",
	"wammo|WEAPON_FIREEXTINGUISHER",
	"wammo|WEAPON_PUMPSHOTGUN",
	"wammo|WEAPON_PUMPSHOTGUN_MK2",
	"wammo|WEAPON_SPECIALCARBINE",
	"wammo|WEAPON_ASSAULTRIFLE",
	"wammo|WEAPON_GUSENBERG",
	"wammo|WEAPON_MACHINEPISTOL",
	"wammo|WEAPON_COMPACTRIFLE",
	"wammo|WEAPON_PETROLCAN",
	"wammo|WEAPON_REVOLVER",
	"wammo|WEAPON_MICROSMG",
	"wammo|WEAPON_REVOLVER_MK2",
	"wammo|WEAPON_ASSAULTSMG",
	"wammo|WEAPON_BULLPUPRIFLE_MK2",
	"wbody|WEAPON_CARBINERIFLE_MK2",
	"wbody|WEAPON_CARBINERIFLE",
	"wbody|WEAPON_COMBATPDW",
	"wbody|WEAPON_COMBATPISTOL",
	"wammo|WEAPON_CARBINERIFLE_MK2",
	"wammo|WEAPON_CARBINERIFLE",
	"wammo|WEAPON_COMBATPDW",
	"wammo|WEAPON_COMBATPISTOL",
	"wbody|WEAPON_ASSAULTRIFLE_MK2",
	"wbody|WEAPON_SPECIALCARBINE_MK2",
	"wbody|WEAPON_SMG_MK2",
	"wbody|WEAPON_PISTOL_MK2",
	"wammo|WEAPON_ASSAULTRIFLE_MK2",
	"wammo|WEAPON_SPECIALCARBINE_MK2",
	"wammo|WEAPON_SMG_MK2",
	"wammo|WEAPON_PISTOL_MK2",
}

RegisterCommand('apreender',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
		local user_id = vRP.getUserId(source)
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			local identity = vRP.getUserIdentity(user_id)
			local nuser_id = vRP.getUserId(nplayer)
			if nuser_id then
				local nidentity = vRP.getUserIdentity(nuser_id)
				local itens_apreendidos = {}
				local weapons = vRPclient.replaceWeapons(nplayer,{})
				for k,v in pairs(weapons) do
					vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
					if v.ammo > 0 then
						vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
					end
				end

				local inv = vRP.getInventory(nuser_id)
				for k,v in pairs(itemlist) do
					local sub_items = { v }
					if string.sub(v,1,1) == "*" then
						local idname = string.sub(v,2)
						sub_items = {}
						for fidname,_ in pairs(inv) do
							if splitString(fidname,"|")[1] == idname then
								table.insert(sub_items,fidname)
							end
						end
					end

					for _,idname in pairs(sub_items) do
						local amount = vRP.getInventoryItemAmount(nuser_id,idname)
						if amount > 0 then
							local item_name,item_weight = vRP.getItemDefinition(idname)
							if item_name then
								if vRP.tryGetInventoryItem(nuser_id,idname,amount,true) then
									vRP.giveInventoryItem(user_id,idname,amount)
									table.insert(itens_apreendidos, "[ITEM]: "..vRP.itemNameList(idname).." [QUANTIDADE]: "..amount)
								end
							end
						end
					end
				end
				local apreendidos = table.concat(itens_apreendidos, "\n")
				SendWebhookMessage(webhookapreender,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[APREENDEU DE]:  "..nuser_id.." "..nidentity.name.." "..nidentity.firstname.."\n" .. apreendidos ..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				TriggerClientEvent("Notify",nplayer,"importante","Todos os seus pertences foram apreendidos.")
				TriggerClientEvent("Notify",source,"importante","Apreendeu todos os pertences da pessoa.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXTRAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('extras',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		if vRPclient.isInVehicle(source) then
			TriggerClientEvent('extras',source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYEXTRAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryextras")
AddEventHandler("tryextras",function(index,extra)
	TriggerClientEvent("syncextras",-1,index,parseInt(extra))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cone',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") then
		TriggerClientEvent('cone',source,args[1])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARREIRA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('barreira',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") then
		TriggerClientEvent('barreira',source,args[1])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPIKE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('spike',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		TriggerClientEvent('spike',source,args[1])
	end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------
-- DISPAROS
--------------------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('atirando')
AddEventHandler('atirando',function(x,y,z)
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.hasPermission(user_id,"policia.permissao") then
			local policiais = vRP.getUsersByPermission("policia.permissao")
			for l,w in pairs(policiais) do
				local player = vRP.getUserSource(w)
				if player then
					TriggerClientEvent('notificacao',player,x,y,z,user_id)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANUNCIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('anuncio',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") then
		local identity = vRP.getUserIdentity(user_id)
		local mensagem = vRP.prompt(source,"Mensagem:","")
		if mensagem == "" then
			return
		end
		vRPclient.setDiv(-1,"anuncio",".div_anuncio { background: rgba(0,128,192,0.8); font-size: 11px; font-family: arial; color: #fff; padding: 20px; bottom: 50%; right: 20px; max-width: 600px; position: absolute; -webkit-border-radius: 5px; } bold { font-size: 15px; }","<bold>"..mensagem.."</bold><br><br>Mensagem enviada por: "..identity.name.." "..identity.firstname)
		SetTimeout(30000,function()
			vRPclient.removeDiv(-1,"anuncio")
		end)
	end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------
-- PRISÃO
--------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local player = vRP.getUserSource(parseInt(user_id))
	if player then
		SetTimeout(30000,function()
			local value = vRP.getUData(parseInt(user_id),"vRP:prisao")
			local tempo = json.decode(value) or 0

			if tempo == -1 then
				return
			end

			if tempo > 0 then
				TriggerClientEvent('prisioneiro',player,true)
				vRPclient.teleport(player,1680.1,2513.0,46.5)
				TriggerClientEvent("Notify",player,"importante","Você está preso e ainda vai passar <b>"..parseInt(tempo).." meses</b> na cadeia")
				prison_lock(parseInt(user_id))
			end
		end)
	end
end)

function prison_lock(target_id)
	local player = vRP.getUserSource(parseInt(target_id))
	if player then
		SetTimeout(60000,function()
			local value = vRP.getUData(parseInt(target_id),"vRP:prisao")
			local tempo = json.decode(value) or 0
			if parseInt(tempo) >= 1 then
				TriggerClientEvent("Notify",player,"importante","Ainda vai passar <b>"..parseInt(tempo).." meses</b> preso")
				vRP.setUData(parseInt(target_id),"vRP:prisao",json.encode(parseInt(tempo)-1))
				prison_lock(parseInt(target_id))
			elseif parseInt(tempo) == 0 then
				TriggerClientEvent('prisioneiro',player,false)
				vRPclient.teleport(player,1850.5,2604.0,45.5)
				vRP.setUData(parseInt(target_id),"vRP:prisao",json.encode(-1))
				TriggerClientEvent("Notify",player,"importante","Sua sentença terminou, esperamos não ve-lo novamente")
			end
			if vRPclient.getHealth(player) <= 100 then
				vRPclient.killGod(player)
			end
		end)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DIMINUIR PENA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("diminuirpena1372391")
AddEventHandler("diminuirpena1372391",function()
	local source = source
	local user_id = vRP.getUserId(source)
	local value = vRP.getUData(parseInt(user_id),"vRP:prisao")
	local tempo = json.decode(value) or 0
	if tempo >= 10 then
		vRP.setUData(parseInt(user_id),"vRP:prisao",json.encode(parseInt(tempo)-2))
		TriggerClientEvent("Notify",source,"importante","Sua pena foi reduzida em <b>2 meses</b>, continue o trabalho")
	else
		TriggerClientEvent("Notify",source,"importante","Atingiu o limite da redução de pena, não precisa mais trabalhar")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- P
-----------------------------------------------------------------------------------------------------------------------------------------
local policia = {}
RegisterCommand('p',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local uplayer = vRP.getUserSource(user_id)
	local identity = vRP.getUserIdentity(user_id)
	local x,y,z = vRPclient.getPosition(source)
	if vRPclient.getHealth(source) > 100 then
		if vRP.hasPermission(user_id,"policia.permissao") then
			local soldado = vRP.getUsersByPermission("policia.permissao")
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player and player ~= uplayer then
					async(function()
						local id = idgens:gen()
						policia[id] = vRPclient.addBlip(player,x,y,z,161,84,"Localização de "..identity.name.." "..identity.firstname,0.5,false)
						TriggerClientEvent("Notify",player,"importante","Localização recebida de <b>"..identity.name.." "..identity.firstname.."</b>.")
						vRPclient._playSound(player,"Out_Of_Bounds_Timer","DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
						SetTimeout(60000,function() vRPclient.removeBlip(player,policia[id]) idgens:free(id) end)
					end)
				end
			end
			TriggerClientEvent("Notify",source,"sucesso","Localização enviada com sucesso.")
			vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
		end
	else
		TriggerClientEvent("Notify",source,"negado","Você não pode enviar sua localização desmaiado/morto")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pd',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "policia.permissao"
		if vRP.hasPermission(user_id,permission) then
			local soldado = vRP.getUsersByPermission(permission)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,identity.name.." "..identity.firstname.. " [" ..user_id.. "]: ",{64,179,255},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PTR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ptr', function(source,args,rawCommand)
 	local user_id = vRP.getUserId(source)
 	local player = vRP.getUserSource(user_id)
 	local oficiais = vRP.getUsersByPermission("pmesp.permissao")
 	local paramedicos = 0
 	local oficiais_nomes = ""
 	if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
 		for k,v in ipairs(oficiais) do
 			local identity = vRP.getUserIdentity(parseInt(v))
 			oficiais_nomes = oficiais_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
 			paramedicos = paramedicos + 1
 		end
 		TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..paramedicos.." Oficiais</b> em serviço.")
 		if parseInt(paramedicos) > 0 then
 			TriggerClientEvent("Notify",source,"importante", oficiais_nomes)
 		end
 	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- HOSPITAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('medicos', function(source,args,rawCommand)
     local user_id = vRP.getUserId(source)
     local player = vRP.getUserSource(user_id)
     local oficiais = vRP.getUsersByPermission("paramedico.permissao")
     local paramedicos = 0
     local paramedicos_nomes = ""
     if vRP.hasPermission(user_id,"paramedico.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
         for k,v in ipairs(oficiais) do
             local identity = vRP.getUserIdentity(parseInt(v))
             paramedicos_nomes = paramedicos_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
             paramedicos = paramedicos + 1
         end
         TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..paramedicos.." Paramédicos</b> em serviço.")
         if parseInt(paramedicos) > 0 then
             TriggerClientEvent("Notify",source,"importante", paramedicos_nomes)
         end
     end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /STAFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('staff', function(source,args,rawCommand)
     local user_id = vRP.getUserId(source)
     local player = vRP.getUserSource(user_id)
     local oficiais = vRP.getUsersByPermission("kick.permissao")
     local staffs = 0
     local staff_nomes = ""
     if vRP.hasPermission(user_id,"admin.permissao") then
         for k,v in ipairs(oficiais) do
             local identity = vRP.getUserIdentity(parseInt(v))
             staff_nomes = staff_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
             staffs = staffs + 1
         end
         TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..staffs.." Staff</b> em serviço.")
         if parseInt(staffs) > 0 then
             TriggerClientEvent("Notify",source,"importante", staff_nomes)
         end
     end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /MECANICOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mecanicos', function(source,args,rawCommand)
     local user_id = vRP.getUserId(source)
     local player = vRP.getUserSource(user_id)
     local oficiais = vRP.getUsersByPermission("mecanico.permissao")
     local mecanicos = 0
     local mecanicos_nomes = ""
     if vRP.hasPermission(user_id,"admin.permissao") then
         for k,v in ipairs(oficiais) do
             local identity = vRP.getUserIdentity(parseInt(v))
             mecanicos_nomes = mecanicos_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
             mecanicos = mecanicos + 1
         end
         TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..mecanicos.." Mecanicos</b> em serviço.")
         if parseInt(mecanicos) > 0 then
             TriggerClientEvent("Notify",source,"importante", mecanicos_nomes)
         end
     end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /CIVIL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('civil', function(source,args,rawCommand)
     local user_id = vRP.getUserId(source)
     local player = vRP.getUserSource(user_id)
     local oficiais = vRP.getUsersByPermission("pcivil.permissao")
     local pcivil = 0
     local pcivil_nomes = ""
     if vRP.hasPermission(user_id,"admin.permissao") then
         for k,v in ipairs(oficiais) do
             local identity = vRP.getUserIdentity(parseInt(v))
             pcivil_nomes = pcivil_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
             pcivil = pcivil + 1
         end
         TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..pcivil.." Pol. Civil</b> em serviço.")
         if parseInt(pcivil) > 0 then
             TriggerClientEvent("Notify",source,"importante", pcivil_nomes)
         end
     end
end)