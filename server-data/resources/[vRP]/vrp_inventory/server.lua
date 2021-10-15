local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPN = {}
Tunnel.bindInterface("vrp_inventory",vRPN)
Proxy.addInterface("vrp_inventory",vRPN)
vRPNclient = Tunnel.getInterface("vrp_inventory","vrp_inventory")

local idgens = Tools.newIDGenerator()

vGARAGE = Tunnel.getInterface("vrp_garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
-- local webhookinventario = "https://discord.com/api/webhooks/795672460493193266/swXw7bzSoJNVsjGoyfigHFUkNq5-du7u-mIDjqIAqvg6fFuB3B4UDkelCxKiA2ub-Mle" 
-- local webhooklockpick = "https://discord.com/api/webhooks/827575258256113694/wJBb6Un4lupwPzNETxSMYfyF6gheCGGGs-hEBBZ2zhHY4ESzNCe2jRQAeah43JsGRgSb"
-- local webhookadrenalina = "https://discord.com/api/webhooks/862419286136061992/44ZOdWMYN9c2doZCnGDCpBF6dZ3zQ3nSMEWdzPnU5wipGNnpSswA-Co2OV3attDGP33k"

-- function SendWebhookMessage(webhook,message)
-- 	if webhook ~= nil and webhook ~= "" then
-- 		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
-- 	end
-- end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.Mochila()
	local source = source
	local user_id = vRP.getUserId(source)
	local data = vRP.getUserDataTable(user_id)
	local inventario = {}
	if data and data.inventory then
		for k,v in pairs(data.inventory) do
			if vRP.itemBodyList(k) then
				table.insert(inventario,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, type = vRP.itemTypeList(k), peso = vRP.getItemWeight(k) })
			end
		end
		return inventario,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.sendItem(itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer == nil then
			return
		end
		local nuser_id = vRP.getUserId(nplayer)
		local identity = vRP.getUserIdentity(user_id)
		local identitynu = vRP.getUserIdentity(nuser_id)
		if nuser_id and vRP.itemIndexList(itemName) then
			if parseInt(amount) > 0 then
				if vRP.getInventoryWeight(nuser_id) + vRP.getItemWeight(itemName) * amount <= vRP.getInventoryMaxWeight(nuser_id) then
					if vRP.tryGetInventoryItem(user_id,itemName,amount) then
						vRP.giveInventoryItem(nuser_id,itemName,amount)
						vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
						TriggerClientEvent("Notify",source,"sucesso","Enviou <b>"..vRP.format(amount).."x "..vRP.itemNameList(itemName).."</b>.",8000)
						vRP.Log("```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ENVIOU]: "..vRP.format(amount).." "..vRP.itemNameList(itemName).." \n[PARA O ID]: "..nuser_id.." "..identitynu.name.." "..identitynu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```", "INVENTARIO")
						-- TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>"..vRP.format(amount).."x "..vRP.itemNameList(itemName).."</b>.",8000)
						vRPclient._playAnim(nplayer,true,{{"mp_common","givetake1_a"}},false)
						TriggerClientEvent('Creative:Update',source,'updateMochila')
						TriggerClientEvent('Creative:Update',nplayer,'updateMochila')
						return true
					end
				end
			else
				local data = vRP.getUserDataTable(user_id)
				for k,v in pairs(data.inventory) do
					if itemName == k then
						if vRP.getInventoryWeight(nuser_id) + vRP.getItemWeight(itemName) * parseInt(v.amount) <= vRP.getInventoryMaxWeight(nuser_id) then
							if vRP.tryGetInventoryItem(user_id,itemName,parseInt(v.amount)) then
								vRP.giveInventoryItem(nuser_id,itemName,parseInt(v.amount))
								vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
								TriggerClientEvent("Notify",source,"sucesso","Enviou <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(itemName).."</b>.",8000)
								vRP.Log("```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ENVIOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[PARA O ID]: "..nuser_id.." "..identitynu.name.." "..identitynu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```", "INVENTARIO")
								-- TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(itemName).."</b>.",8000)
								vRPclient._playAnim(nplayer,true,{{"mp_common","givetake1_a"}},false)
								TriggerClientEvent('Creative:Update',source,'updateMochila')
								TriggerClientEvent('Creative:Update',nplayer,'updateMochila')
								return true
							end
						end
					end
				end
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.dropItem(itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local x,y,z = vRPclient.getPosition(source)
		if parseInt(amount) > 0 and vRP.tryGetInventoryItem(user_id,itemName,amount) then
			TriggerEvent("DropSystem:create",itemName,amount,x,y,z,3600)
			vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
			vRP.Log("```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[DROPOU]: "..vRP.itemNameList(itemName).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```", "INVENTARIO")
			TriggerClientEvent('Creative:Update',source,'updateMochila')
			return true
		else
			local data = vRP.getUserDataTable(user_id)
			for k,v in pairs(data.inventory) do
				if itemName == k then
					if vRP.tryGetInventoryItem(user_id,itemName,parseInt(v.amount)) then
						TriggerEvent("DropSystem:create",itemName,parseInt(v.amount),x,y,z,3600)
						vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
						vRP.Log("```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[DROPOU]: "..vRP.itemNameList(itemName).." \n[QUANTIDADE]: "..vRP.format(parseInt(v.amount)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```", "INVENTARIO")
						TriggerClientEvent('Creative:Update',source,'updateMochila')
						return true
					end
				end
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANDAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
local bandagem = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(bandagem) do
			if v > 0 then
				bandagem[k] = v - 1
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
local pick = {}
local blips = {}
function vRPN.useItem(itemName,type,ramount)
local source = source
local user_id = vRP.getUserId(source)

	if user_id and ramount ~= nil and parseInt(ramount) >= 0 and not actived[user_id] and actived[user_id] == nil then
		if type == "usar" then
				if itemName == "bandagem" then
					if vRPclient.getHealth(source) > 101 and vRPclient.getHealth(source) < 250 then		
						if bandagem[user_id] == 0 or not bandagem[user_id] then
							if vRP.tryGetInventoryItem(user_id,"bandagem",1) then
								bandagem[user_id] = 300
								actived[user_id] = true
								vRPclient._CarregarObjeto(source,"amb@world_human_clipboard@male@idle_a","idle_c","v_ret_ta_firstaid",49,60309)
								TriggerClientEvent('Creative:Update',source,'updateMochila')
								TriggerClientEvent('cancelando',source,true)
								TriggerClientEvent("progress",source,20000,"bandagem")
								SetTimeout(20000,function()
									actived[user_id] = nil
									TriggerClientEvent('bandagem',source)
									TriggerClientEvent('cancelando',source,false)
									vRPclient._DeletarObjeto(source)
									TriggerClientEvent("Notify",source,"sucesso","Bandagem utilizada com sucesso.",8000)
									Citizen.Wait(10000)
									--TriggerClientEvent("resetBleeding",source)
								end)
							end
						else
							TriggerClientEvent("Notify",source,"negado","Só pode utilizar outra bandagem em <b>"..bandagem[user_id].." segundos</b>",8000)
						end
					else
					TriggerClientEvent("Notify",source,"importante","Você não pode utilizar de vida cheia ou nocauteado.",8000)
				end
			elseif itemName == "mochila" then
				if vRP.tryGetInventoryItem(user_id,"mochila",1) then
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRP.varyExp(user_id,"physical","strength",650)
					TriggerClientEvent("Notify",source,"sucesso","Mochila utilizada com sucesso.",8000)
				end
			elseif itemName == "listadesmanche" then
				if vRP.getInventoryItemAmount(user_id,"listadesmanche") >= 1 then
					TriggerClientEvent('rotadesmanche',source)
				end
			elseif itemName == "maconha" then
				if vRP.tryGetInventoryItem(user_id,"maconha",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._playAnim(source,true,{{"mp_player_int_uppersmoke","mp_player_int_smoke"}},true)
					TriggerClientEvent("progress",source,10000,"fumando")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRPclient.playScreenEffect(source,"RaceTurbo",120)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",120)
						TriggerClientEvent("Notify",source,"sucesso","Maconha utilizada com sucesso.",10000)
					end)
				end
			elseif itemName == "tequila" then
				if vRP.tryGetInventoryItem(user_id,"tequila",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
					TriggerClientEvent("progress",source,15000,"bebendo")
					SetTimeout(15000,function()
						actived[user_id] = nil
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent('cancelando',source,false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,"sucesso","Tequila utilizada com sucesso.",8000)
					end)
				end
			elseif itemName == "vodka" then
				if vRP.tryGetInventoryItem(user_id,"vodka",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
					TriggerClientEvent("progress",source,15000,"bebendo")
					SetTimeout(15000,function()
						actived[user_id] = nil
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent('cancelando',source,false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,"sucesso","Vodka utilizada com sucesso.",8000)
					end)
				end
			elseif itemName == "cerveja" then
				if vRP.tryGetInventoryItem(user_id,"cerveja",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
					TriggerClientEvent("progress",source,15000,"bebendo")
					SetTimeout(15000,function()
						actived[user_id] = nil
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent('cancelando',source,false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,"sucesso","Cerveja utilizada com sucesso.",8000)
					end)
				end
			elseif itemName == "whisky" then
				if vRP.tryGetInventoryItem(user_id,"whisky",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","p_whiskey_notop",49,28422)
					TriggerClientEvent("progress",source,15000,"bebendo")
					SetTimeout(15000,function()
						actived[user_id] = nil
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent('cancelando',source,false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,"sucesso","Whisky utilizado com sucesso.",8000)
					end)
				end
			elseif itemName == "conhaque" then
				if vRP.tryGetInventoryItem(user_id,"conhaque",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_beer_logopen",49,28422)
					TriggerClientEvent("progress",source,15000,"bebendo")
					SetTimeout(15000,function()
						actived[user_id] = nil
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent('cancelando',source,false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,"sucesso","Conhaque utilizado com sucesso.",8000)
					end)
				end
			elseif itemName == "absinto" then
				if vRP.tryGetInventoryItem(user_id,"absinto",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_beer_blr",49,28422)
					TriggerClientEvent("progress",source,15000,"bebendo")
					SetTimeout(15000,function()
						actived[user_id] = nil
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent('cancelando',source,false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,"sucesso","Absinto utilizado com sucesso.",8000)
					end)
				end
			elseif itemName == "agua" then
				if vRP.tryGetInventoryItem(user_id,"agua",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"mp_player_intdrink","loop_bottle","prop_ld_flow_bottle",49,60309)
					TriggerClientEvent("progress",source,10000,"bebendo")
					SetTimeout(10000,function()
						actived[user_id] = nil
						TriggerClientEvent('cancelando',source,false)
						vRP.varyThirst(user_id,-100)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,"sucesso","Água utilizada com sucesso.",8000)
					end)
				end
			elseif itemName == "hamburguer" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"hamburguer",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent("emotes",source,"comer")
					TriggerClientEvent("progress",source,10000,"comendo")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-100)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>Sanduíche</b>.")
					end)

				end
			elseif itemName == "heroina" then
				if vRP.tryGetInventoryItem(user_id,"heroina",1) then
					local efeito = 0
					local efeito = math.random(1,10)
					if efeito >= 5 then
						actived[user_id] = true
						TriggerClientEvent('Creative:Update',source,'updateMochila')
						vRPclient._playAnim(source,true,{{"mp_player_int_uppersmoke","mp_player_int_smoke"}},true)
						TriggerClientEvent('cancelando',source,true)
						TriggerClientEvent("progress",source,10000,"injetando")
							SetTimeout(10000,function()
							actived[user_id] = nil
							vRPclient._stopAnim(source,false)
							TriggerClientEvent('energeticos',source,true)
							TriggerClientEvent('cancelando',source,false)
							vRPclient.playScreenEffect(source,"RaceTurbo",60)
							vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",60)
							TriggerClientEvent("Notify",source,"sucesso","Heroína utilizada, seu coração esta acelerado!.",8000)
						end)
						SetTimeout(15000,function()
							TriggerClientEvent('energeticos',source,false)
							TriggerClientEvent("Notify",source,"importante","Seu coração voltou a bater normalmente.",8000)
						end)
					else
						actived[user_id] = true
						TriggerClientEvent('Creative:Update',source,'updateMochila')
						vRPclient._playAnim(source,true,{{"mp_player_int_uppersmoke","mp_player_int_smoke"}},true)
						TriggerClientEvent('cancelando',source,true)
						TriggerClientEvent("progress",source,10000,"injetando")
						SetTimeout(10000,function()
							actived[user_id] = nil
							vRPclient._stopAnim(source,false)
							TriggerClientEvent('cancelando',source,false)
							TriggerClientEvent("Notify",source,"importante","sem efeito.",8000)
						end)
					end
				end
			elseif itemName == "cocaina" then
				if vRP.tryGetInventoryItem(user_id,"cocaina",1) then
					local efeito = 0
					local efeito = math.random(1,10)
					if efeito >= 5 then
						actived[user_id] = true
						TriggerClientEvent('Creative:Update',source,'updateMochila')
						vRPclient._playAnim(source,true,{{"mp_player_int_uppersmoke","mp_player_int_smoke"}},true)
						TriggerClientEvent('cancelando',source,true)
						TriggerClientEvent("progress",source,10000,"cheirando")
							SetTimeout(10000,function()
							actived[user_id] = nil
							vRPclient._stopAnim(source,false)
							TriggerClientEvent('energeticos',source,true)
							TriggerClientEvent('cancelando',source,false)
							vRPclient.playScreenEffect(source,"RaceTurbo",60)
							vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",60)
							TriggerClientEvent("Notify",source,"sucesso","Cocaína utilizada, seu coração esta acelerado!.",8000)
						end)
						SetTimeout(15000,function()
							TriggerClientEvent('energeticos',source,false)
							TriggerClientEvent("Notify",source,"importante","Seu coração voltou a bater normalmente.",8000)
						end)
					else
						actived[user_id] = true
						TriggerClientEvent('Creative:Update',source,'updateMochila')
						vRPclient._playAnim(source,true,{{"mp_player_int_uppersmoke","mp_player_int_smoke"}},true)
						TriggerClientEvent('cancelando',source,true)
						TriggerClientEvent("progress",source,10000,"cheirando")
						SetTimeout(10000,function()
							actived[user_id] = nil
							vRPclient._stopAnim(source,false)
							TriggerClientEvent('cancelando',source,false)
							TriggerClientEvent("Notify",source,"importante","sem efeito.",8000)
						end)
					end
				end
			elseif itemName == "lolo" then
				if vRP.tryGetInventoryItem(user_id,"lolo",1) then
					local efeito = 0
					local efeito = math.random(1,10)
					if efeito >= 5 then
						actived[user_id] = true
						TriggerClientEvent('Creative:Update',source,'updateMochila')
						vRPclient._playAnim(source,true,{{"mp_player_int_uppersmoke","mp_player_int_smoke"}},true)
						TriggerClientEvent('cancelando',source,true)
						TriggerClientEvent("progress",source,10000,"cheirando")
							SetTimeout(10000,function()
							actived[user_id] = nil
							vRPclient._stopAnim(source,false)
							TriggerClientEvent('energeticos',source,true)
							TriggerClientEvent('cancelando',source,false)
							vRPclient.playScreenEffect(source,"RaceTurbo",60)
							vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",60)
							TriggerClientEvent("Notify",source,"sucesso","Loló utilizada, seu coração esta acelerado!.",8000)
						end)
						SetTimeout(15000,function()
							TriggerClientEvent('energeticos',source,false)
							TriggerClientEvent("Notify",source,"importante","Seu coração voltou a bater normalmente.",8000)
						end)
					else
						actived[user_id] = true
						TriggerClientEvent('Creative:Update',source,'updateMochila')
						vRPclient._playAnim(source,true,{{"mp_player_int_uppersmoke","mp_player_int_smoke"}},true)
						TriggerClientEvent('cancelando',source,true)
						TriggerClientEvent("progress",source,10000,"cheirando")
						SetTimeout(10000,function()
							actived[user_id] = nil
							vRPclient._stopAnim(source,false)
							TriggerClientEvent('cancelando',source,false)
							TriggerClientEvent("Notify",source,"importante","sem efeito.",8000)
						end)
					end
				end
			elseif itemName == "metanfetamina" then
				if vRP.tryGetInventoryItem(user_id,"metanfetamina",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._playAnim(source,true,{{"mp_player_int_uppersmoke","mp_player_int_smoke"}},true)
					TriggerClientEvent("progress",source,10000,"fumando")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent("Notify",source,"sucesso","Metanfetamina utilizada com sucesso.",8000)
					end)
				end	
			elseif itemName == "capuz" then
				if vRP.getInventoryItemAmount(user_id,"capuz") >= 1 then
					local nplayer = vRPclient.getNearestPlayer(source,2)
					if nplayer then
						vRPclient.setCapuz(nplayer)

						if vRPclient.isCapuz(nplayer) then	
							TriggerClientEvent('setcapuz',nplayer)
						else
							TriggerClientEvent('removecapuz',nplayer)
						end

						vRP.closeMenu(nplayer)
						TriggerClientEvent("Notify",source,"sucesso","Capuz utilizado com sucesso.",8000)
					end
				end
			elseif itemName == "corda" then
				if vRP.getInventoryItemAmount(user_id,"corda") >= 1 then
					local nplayer = vRPclient.getNearestPlayer(source,2)
					if nplayer and not vRPclient.inVehicle(source) then
						TriggerClientEvent('carregar',nplayer,source)
						TriggerClientEvent("Notify",source,"sucesso","Corda utilizada com sucesso.",5000)
					end
				end		
			elseif itemName == "adrenalina" then
				local nplayer = vRPclient.getNearestPlayer(source,2)
				local nuser_id = vRP.getUserId(nplayer)
				if nplayer then
					local identity = vRP.getUserIdentity(user_id)
					local identityu = vRP.getUserIdentity(nuser_id)
					local crds = GetEntityCoords(GetPlayerPed(source))
					local medicos = vRP.getUsersByPermission("paramedico.permissao")

					if #medicos >= 1 then
						TriggerClientEvent("Notify",source,"negado","Existem médicos em serviço, faça um chamado pelo <b>celular</b>",5000)
						return
					else
						if vRPclient.isInComa(nplayer) then
							vRP.tryGetInventoryItem(user_id,"adrenalina",1)
							TriggerClientEvent('cancelando',source,true)
							vRPclient._playAnim(source,false,{{"amb@medic@standing@tendtodead@base","base"},{"mini@cpr@char_a@cpr_str","cpr_pumpchest"}},true)
							TriggerClientEvent("progress",source,30000,"reanimando")
							SetTimeout(30000,function()
								vRPclient.killGod(nplayer)
								vRPclient.setHealth(nplayer,150)
								vRPclient._stopAnim(source,false)
								vRPclient._stopAnim(nplayer,false)
								vRP.giveMoney(user_id,500)
								TriggerClientEvent('cancelando',source,false)
								TriggerEvent("srkfive:killregisterclear",nuser_id)
								vRP.Log("```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[REVIVEU]: "..nuser_id.." "..identityu.name.." "..identityu.firstname.."\n[COORDENADA]: "..crds.x..","..crds.y..","..crds.z..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```", "ADRENALINA")
							end)
						else
						TriggerClientEvent("Notify",source,"importante","A pessoa precisa estar em coma para prosseguir.")
						end
					end
				end
			elseif itemName == "energetico" then
				if vRP.tryGetInventoryItem(user_id,"energetico",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"mp_player_intdrink","loop_bottle","prop_energy_drink",49,60309)
					TriggerClientEvent("progress",source,12000,"bebendo")
					SetTimeout(12000,function()
						actived[user_id] = nil
						TriggerClientEvent('energeticos',source,true)
						TriggerClientEvent('cancelando',source,false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,"sucesso","Energético utilizado com sucesso.",8000)
					end)
					SetTimeout(60000,function()
						TriggerClientEvent('energeticos',source,false)
						TriggerClientEvent("Notify",source,"importante","O efeito do energético passou e o coração voltou a bater normalmente.",8000)
					end)
				end
			elseif itemName == "lockpick" then
				local vehicle,vnetid,placa,vname,lock,banned,trunk,model,street = vRPclient.vehList(source,7)
				local policia = vRP.getUsersByPermission("pmesp.permissao")
				if vRP.hasPermission(user_id,"policia.permissao") then
					TriggerEvent("setPlateEveryone",placa)
					vGARAGE.vehicleClientLock(-1,vnetid,lock)
					TriggerClientEvent("vrp_sound:source",source,'lock',0.5)
					return
				end
				-- if #policia < 2 then
				-- 	TriggerClientEvent("Notify",source,"importante","Número insuficiente de policiais no momento para iniciar o roubo.")
				-- 	return true
				-- end

				-- FAZER A VERIFICAÇÃO SE O VEÍCULO ESTÁ TRANCADO
				if lock == 1 then
					TriggerClientEvent("Notify",source,"negado","Lockpick só pode ser usada em veículos que estão trancados!")
					return true
				end

				if vRP.getInventoryItemAmount(user_id,"lockpick") >= 1 and vRP.tryGetInventoryItem(user_id,"lockpick",1) and vehicle then
					actived[user_id] = true
					-- if vRP.hasPermission(user_id,"polpar.permissao") then
					-- 	actived[user_id] = nil
					-- 	TriggerEvent("setPlateEveryone",placa)
					-- 	vGARAGE.vehicleClientLock(-1,vnetid,lock)
					-- 	return
					-- end

					TriggerClientEvent('cancelando',source,true)
					-- vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true) -- Antiga
					-- vRPclient._playAnim(source,false,{{"oddjobs@shop_robbery@rob_till","loop"}},true) -- Registradora
					-- vRPclient.playAnim(source,false,{{"missheistfbi3b_ig7","lift_fibagent_loop"}},false) -- Toctoc
					vRPclient._playAnim(source,false,{{"missfbi_s4mop","clean_mop_back_player"}},true)
					TriggerClientEvent("progress",source,15000,"roubando")
					SetTimeout(15000,function()
						actived[user_id] = nil
						TriggerClientEvent('cancelando',source,false)
						vRPclient._stopAnim(source,false)

						roubo1 = math.random(10)
						roubo2 = math.random(10)

						if roubo1 >= 5 then
							TriggerEvent("setPlateEveryone",placa)
							vGARAGE.vehicleClientLock(-1,vnetid,lock)
							TriggerClientEvent("vrp_sound:source",source,'lock',0.5)

							TriggerClientEvent("Notify",source,"sucesso","Roubo concluído, as autoridades foram acionadas.",8000)
							local policia = vRP.getUsersByPermission("policia.permissao")
							local x,y,z = vRPclient.getPosition(source)
							local identitys = vRP.getUserIdentity(user_id)
							local crds = GetEntityCoords(GetPlayerPed(source))
							for k,v in pairs(policia) do
								local player = vRP.getUserSource(parseInt(v))
								if player then
									async(function()
										local id = idgens:gen()
										vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
										TriggerClientEvent('chatMessage',player,"190",{64,64,255},"Roubo na ^1"..street.."^0 do veículo ^1"..model.."^0 de placa ^1"..placa.."^0 verifique o ocorrido.")
										pick[id] = vRPclient.addBlip(player,x,y,z,10,5,"Ocorrência",0.5,false)
										SetTimeout(20000,function() vRPclient.removeBlip(player,pick[id]) idgens:free(id) end)
									end)
								end
							end
							vRP.Log("```prolog\n[ID]: "..user_id.." "..identitys.name.." "..identitys.firstname.." \n[MODELO]: "..model.."\n[PLACA]: "..placa.."\n[COORDENADA]: "..crds.x..","..crds.y..","..crds.z..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."```", "LOCKPICK")
						elseif roubo2 >= 6 then
							TriggerClientEvent("Notify",source,"negado","Roubo do veículo falhou e as autoridades foram acionadas.",8000)
							local policia = vRP.getUsersByPermission("policia.permissao")
							local x,y,z = vRPclient.getPosition(source)
							for k,v in pairs(policia) do
								local player = vRP.getUserSource(parseInt(v))
								if player then
									async(function()
										local id = idgens:gen()
										vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
										TriggerClientEvent('chatMessage',player,"190",{64,64,255},"Tentativa de Roubo na ^1"..street.."^0 do veículo ^1"..model.."^0 de placa ^1"..placa.."^0 verifique o ocorrido.")
										pick[id] = vRPclient.addBlip(player,x,y,z,10,5,"Ocorrência",0.5,false)
										SetTimeout(20000,function() vRPclient.removeBlip(player,pick[id]) idgens:free(id) end)
									end)
								end
							end
						else
							TriggerClientEvent("Notify",source,"aviso","O roubo falhou porém as autoridades não foram acionadas!",8000)
						end
					end)
				end
			elseif itemName == "masterpick" then
				local vehicle,vnetid,placa,vname,lock,banned,trunk,model,street = vRPclient.vehList(source,7)
				local policia = vRP.getUsersByPermission("pmesp.permissao")

				if not vRP.hasPermission(user_id,"kick.permissao") then
					TriggerClientEvent("Notify",source,"negado","Apenas administradores podem utilizar a Masterpick.")
					return true
				end
				
				if #policia < 0 then
					TriggerClientEvent("Notify",source,"importante","Número insuficiente de policiais no momento para iniciar o roubo.")
					return true
				end
				if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id, "founder.permissao") then
					TriggerEvent("setPlateEveryone",placa)
					vGARAGE.vehicleClientLock(-1,vnetid,lock)
					TriggerClientEvent("vrp_sound:source",source,'lock',0.5)
					return
				end
				if vRP.getInventoryItemAmount(user_id,"masterpick") >= 1 and vRP.tryGetInventoryItem(user_id,"masterpick",1) and vehicle then
					actived[user_id] = true
					if vRP.hasPermission(user_id,"polpar.permissao") then
						actived[user_id] = nil
						TriggerEvent("setPlateEveryone",placa)
						vGARAGE.vehicleClientLock(-1,vnetid,lock)
						return
					end

					TriggerClientEvent('cancelando',source,true)
					vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
					TriggerClientEvent("progress",source,60000,"roubando")
					SetTimeout(60000,function()
						actived[user_id] = nil
						TriggerClientEvent('cancelando',source,false)
						vRPclient._stopAnim(source,false)
						TriggerEvent("setPlateEveryone",placa)
						vGARAGE.vehicleClientLock(-1,vnetid,lock)
						TriggerClientEvent("vrp_sound:source",source,'lock',0.5)
						TriggerClientEvent("Notify",source,"importante","Roubo do veículo concluído e as autoridades foram acionadas.",8000)
						local policia = vRP.getUsersByPermission("policia.permissao")
						local x,y,z = vRPclient.getPosition(source)
						for k,v in pairs(policia) do
							local player = vRP.getUserSource(parseInt(v))
							if player then
								async(function()
									local id = idgens:gen()
									vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
									TriggerClientEvent('chatMessage',player,"190",{64,64,255},"Roubo na ^1"..street.."^0 do veículo ^1"..model.."^0 de placa ^1"..placa.."^0 verifique o ocorrido.")
									pick[id] = vRPclient.addBlip(player,x,y,z,10,5,"Ocorrência",0.5,false)
									SetTimeout(20000,function() vRPclient.removeBlip(player,pick[id]) idgens:free(id) end)
								end)
							end
						end
					end)
				end
			elseif itemName == "militec" then
				if not vRPclient.isInVehicle(source) then
					local vehicle = vRPclient.getNearestVehicle(source,3.5)
					if vehicle then
						local mec = vRP.getUsersByPermission("mecanico.permissao")
						if vRP.hasPermission(user_id,"mecanico.permissao") then
							if vRP.tryGetInventoryItem(user_id,"militec",1) then
								actived[user_id] = true
								TriggerClientEvent('cancelando',source,true)
								vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
								TriggerClientEvent("progress",source,10000,"reparando motor")
								SetTimeout(10000,function()
									actived[user_id] = nil
									TriggerClientEvent('cancelando',source,false)
									TriggerClientEvent('repararmotor',source,vehicle, true)
									vRPclient._stopAnim(source,false)
								end)
							end
						else
							if vRP.tryGetInventoryItem(user_id,"militec",1) then
								actived[user_id] = true
								TriggerClientEvent('Creative:Update',source,'updateMochila')
								TriggerClientEvent('cancelando',source,true)
								vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
								TriggerClientEvent("progress",source,20000,"reparando motor")
								SetTimeout(20000,function()
									actived[user_id] = nil
									TriggerClientEvent('cancelando',source,false)
									TriggerClientEvent('repararmotor',source,vehicle, false)
									vRPclient._stopAnim(source,false)
								end)
							end
						end
					end
				end	
			elseif itemName == "repairkit" then
				if not vRPclient.isInVehicle(source) then
					local vehicle = vRPclient.getNearestVehicle(source,3.5)
					if vehicle then

						if vRP.hasPermission(user_id,"mecanico.permissao") then
							actived[user_id] = true
							TriggerClientEvent('cancelando',source,true)
							vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
							TriggerClientEvent("progress",source,15000,"reparando veículo")
							SetTimeout(15000,function()
								actived[user_id] = nil
								TriggerClientEvent('cancelando',source,false)
								TriggerClientEvent('reparar',source)
								vRPclient._stopAnim(source,false)
							end)
						else
							if vRP.tryGetInventoryItem(user_id,"repairkit",1) then -- Tirar o item do inventario
								actived[user_id] = true
								TriggerClientEvent('cancelando',source,true)
								vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
								TriggerClientEvent("progress",source,30000,"reparando veículo")
								SetTimeout(30000,function()
									actived[user_id] = nil
									TriggerClientEvent('cancelando',source,false)
									TriggerClientEvent('reparar',source)
									vRPclient._stopAnim(source,false)
								end)
							end -- Tirar o item do inventário	
						end
						
					end
				end	
			elseif itemName == "pneu" then
				if not vRPclient.isInVehicle(source) then
					local vehicle = vRPclient.getNearestVehicle(source,4)
					if vehicle then
						if vRP.tryGetInventoryItem(user_id,"pneu",1) then
							if vRP.hasPermission(user_id,"mecanico.permissao") then
								actived[user_id] = true
								TriggerClientEvent('cancelando',source,true)
								vRPclient._playAnim(source,false,{{"amb@medic@standing@tendtodead@idle_a","idle_a"}},true)
								TriggerClientEvent("progress",source,5000,"trocando pneu")
								SetTimeout(5000,function()
									actived[user_id] = nil
									TriggerClientEvent('cancelando',source,false)
									local tyre, car = vRPNclient.ityrerepair(source, vehicle)
									if tyre ~= -1 then
										vRPNclient._syncTyreRepair(-1, car, tyre)
									end
									vRPclient._stopAnim(source,false)
								end)
							else
								actived[user_id] = true
								TriggerClientEvent('Creative:Update',source,'updateMochila')
								TriggerClientEvent('cancelando',source,true)
								vRPclient._playAnim(source,false,{{"amb@medic@standing@tendtodead@idle_a","idle_a"}},true)
								TriggerClientEvent("progress",source,10000,"trocando pneu")
								SetTimeout(10000,function()
									actived[user_id] = nil
									TriggerClientEvent('cancelando',source,false)
									local tyre, car = vRPNclient.ityrerepair(source, vehicle)
									if tyre ~= -1 then
										vRPNclient._syncTyreRepair(-1, car, tyre)
									end
									vRPclient._stopAnim(source,false)
									vRPclient._stopAnim(source,true)
								end)
							end
						end
					end
				end	
			elseif itemName == "placa" then
                if vRPclient.GetVehicleSeat(source) then
                    if vRP.tryGetInventoryItem(user_id,"placa",1) then
                        local placa = vRP.generatePlate()
						local vehicle,vnetid,placa,vname,lock,banned,trunk,model,street = vRPclient.vehList(source,7)
                        TriggerClientEvent('Creative:Update',source,'updateMochila')
                        TriggerClientEvent('cancelando',source,true)
                        TriggerClientEvent("vehicleanchor",source)
                        TriggerClientEvent("progress",source,30000,"clonando")
                        SetTimeout(30000,function()
                            TriggerClientEvent('cancelando',source,false)
                            TriggerClientEvent("cloneplates",source,placa)
                            TriggerEvent("setPlateEveryone",placa)
							if lock == 2 then
								TriggerEvent("setPlateEveryone",placa)
								vGARAGE.vehicleClientLock(-1,vnetid,lock)
							end
                            TriggerClientEvent("Notify",source,"sucesso","Placa clonada com sucesso.",8000)
                        end)
                    end
                end
			elseif itemName == "colete" then
				if vRP.tryGetInventoryItem(user_id,"colete",1) then
					vRPclient.setArmour(source,100)
					TriggerClientEvent('Creative:Update',source,'updateMochila')
				end
			elseif itemName == "rosa" then
				if vRP.tryGetInventoryItem(user_id,"rosa",1) then
					local e = { nome = "rosa" , prop = "prop_single_rose" , flag = 50 , hand = 60309 , pos1 = 0.055 , pos2 = 0.05 , pos3 = 0.0 , pos4 = 240.0 , pos5 = 0.0 , pos6 = 0.0 }
					vRPclient._CarregarObjeto(source,"","",e.prop,e.flag,e.hand,e.pos1,e.pos2,e.pos3,e.pos4,e.pos5,e.pos6)
					Citizen.Wait(20000)
					vRPclient._DeletarObjeto(source)
				end
		end
		elseif type == "equipar" then
			if vRP.tryGetInventoryItem(user_id,itemName,1) then
				local weapons = {}
				local identity = vRP.getUserIdentity(user_id)
				weapons[string.gsub(itemName,"wbody|","")] = { ammo = 0 }
				vRPclient._giveWeapons635168747(source,weapons)
				vRP.Log("```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[EQUIPOU]: "..vRP.itemNameList(itemName).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```", "INVENTARIO")
				TriggerClientEvent('Creative:Update',source,'updateMochila')
			end
		elseif type == "recarregar" then
			local uweapons = vRPclient.getWeapons(source)
      local weaponuse = string.gsub(itemName,"wammo|","")
      local weaponusename = "wammo|"..weaponuse
			local identity = vRP.getUserIdentity(user_id)
      if uweapons[weaponuse] then
        local itemAmount = 0
        local data = vRP.getUserDataTable(user_id)
        for k,v in pairs(data.inventory) do
          if weaponusename == k then
            if v.amount > 250 then
              v.amount = 250
            end

            itemAmount = v.amount

            if vRP.tryGetInventoryItem(user_id, weaponusename, parseInt(v.amount)) then
              local weapons = {}
              weapons[weaponuse] = { ammo = v.amount }
              itemAmount = v.amount
              vRPclient._giveWeapons635168747(source,weapons,false)
              vRP.Log("```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RECARREGOU]: "..vRP.itemNameList(itemName).." \n[MUNICAO]: "..parseInt(v.amount).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```", "INVENTARIO")
              TriggerClientEvent('Creative:Update',source,'updateMochila')
            end
          end
        end
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- USE
-----------------------------------------------------------------------------------------------------------------------------------------
local bandagem = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(bandagem) do
			if v > 0 then
				bandagem[k] = v - 1
			end
		end
	end
end)

RegisterCommand('use',function(source,args,rawCommand)
	if args[1] == nil then
		return
	end
	local user_id = vRP.getUserId(source)
	if args[1] == "energetico" then
		if vRP.tryGetInventoryItem(user_id,"energetico",1) then
			actived[user_id] = true
			TriggerClientEvent('Creative:Update',source,'updateMochila')
			TriggerClientEvent('cancelando',source,true)
			vRPclient._CarregarObjeto(source,"mp_player_intdrink","loop_bottle","prop_energy_drink",49,60309)
			TriggerClientEvent("progress",source,12000,"bebendo")
			SetTimeout(12000,function()
				actived[user_id] = nil
				TriggerClientEvent('energeticos',source,true)
				TriggerClientEvent('cancelando',source,false)
				vRPclient._DeletarObjeto(source)
				TriggerClientEvent("Notify",source,"sucesso","Energético utilizado com sucesso.",8000)
			end)
			SetTimeout(60000,function()
				TriggerClientEvent('energeticos',source,false)
				TriggerClientEvent("Notify",source,"importante","O efeito do energético passou e o coração voltou a bater normalmente.",8000)
			end)
		else
			TriggerClientEvent("Notify",source,"negado","Energético não encontrado na mochila.")
		end
	end
	TriggerEvent('logs:ToDiscord', discord_webhook5 , "USOU", "```Player "..user_id.." usou(por comando) o item: "..args[1].."```", "https://www.tumarcafacil.com/wp-content/uploads/2017/06/RegistroDeMarca-01-1.png", false, false)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERLEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
	actived[user_id] = nil
end)