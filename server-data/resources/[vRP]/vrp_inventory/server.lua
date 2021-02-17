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
local webhookinventario = "https://discord.com/api/webhooks/795672460493193266/swXw7bzSoJNVsjGoyfigHFUkNq5-du7u-mIDjqIAqvg6fFuB3B4UDkelCxKiA2ub-Mle" 

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
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
						SendWebhookMessage(webhookinventario,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ENVIOU]: "..vRP.format(amount).." "..vRP.itemNameList(itemName).." \n[PARA O ID]: "..nuser_id.." "..identitynu.name.." "..identitynu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
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
								SendWebhookMessage(webhookinventario,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ENVIOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[PARA O ID]: "..nuser_id.." "..identitynu.name.." "..identitynu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
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
			SendWebhookMessage(webhookinventario,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[DROPOU]: "..vRP.itemNameList(itemName).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			TriggerClientEvent('Creative:Update',source,'updateMochila')
			return true
		else
			local data = vRP.getUserDataTable(user_id)
			for k,v in pairs(data.inventory) do
				if itemName == k then
					if vRP.tryGetInventoryItem(user_id,itemName,parseInt(v.amount)) then
						TriggerEvent("DropSystem:create",itemName,parseInt(v.amount),x,y,z,3600)
						vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
						SendWebhookMessage(webhookinventario,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[DROPOU]: "..vRP.itemNameList(itemName).." \n[QUANTIDADE]: "..vRP.format(parseInt(v.amount)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
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
			elseif itemName == "maconha" then
				if vRP.tryGetInventoryItem(user_id,"maconha",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._playAnim(source,true,{{"mp_player_int_uppersmoke","mp_player_int_smoke"}},true)
					TriggerClientEvent("progress",source,10000,"fumando")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent("Notify",source,"sucesso","Maconha utilizada com sucesso.",8000)
					end)
				end
			elseif itemName == "cocaina" then
				if vRP.tryGetInventoryItem(user_id,"cocaina",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._playAnim(source,true,{{"mp_player_int_uppersmoke","mp_player_int_smoke"}},true)
					TriggerClientEvent('cancelando',source,true)
					TriggerClientEvent("progress",source,10000,"cheirando")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						--TriggerClientEvent('energeticos',source,true)
						TriggerClientEvent('cancelando',source,false)
						vRPclient.playScreenEffect(source,"RaceTurbo",120)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",120)
						TriggerClientEvent("Notify",source,"sucesso","Cocaína utilizada com sucesso.",8000)
					end)
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
						vRP.closeMenu(nplayer)
						TriggerClientEvent("Notify",source,"sucesso","Capuz utilizado com sucesso.",8000)
					end
				end
			elseif itemName == "energetico" then
				if vRP.tryGetInventoryItem(user_id,"energetico",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
					TriggerClientEvent("progress",source,20000,"bebendo")
					SetTimeout(20000,function()
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
				local policia = vRP.getUsersByPermission("policia.permissao")
				if #policia < 2 then
					TriggerClientEvent("Notify",source,"importante","Número insuficiente de policiais no momento para iniciar o roubo.")
					return true
				end
				-- if vRP.hasPermission(user_id,"policia.permissao") then
				-- 	TriggerEvent("setPlateEveryone",placa)
				-- 	vGARAGE.vehicleClientLock(-1,vnetid,lock)
				-- 	TriggerClientEvent("vrp_sound:source",source,'lock',0.5)
				-- 	return
				-- end
				if vRP.getInventoryItemAmount(user_id,"lockpick") >= 1 and vRP.tryGetInventoryItem(user_id,"lockpick",1) and vehicle then
					actived[user_id] = true
					-- if vRP.hasPermission(user_id,"polpar.permissao") then
					-- 	actived[user_id] = nil
					-- 	TriggerEvent("setPlateEveryone",placa)
					-- 	vGARAGE.vehicleClientLock(-1,vnetid,lock)
					-- 	return
					-- end

					TriggerClientEvent('cancelando',source,true)
					vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
					TriggerClientEvent("progress",source,30000,"roubando")
					SetTimeout(30000,function()
						actived[user_id] = nil
						TriggerClientEvent('cancelando',source,false)
						vRPclient._stopAnim(source,false)

						if math.random(100) >= 50 then
							TriggerEvent("setPlateEveryone",placa)
							vGARAGE.vehicleClientLock(-1,vnetid,lock)
							TriggerClientEvent("vrp_sound:source",source,'lock',0.5)

							TriggerClientEvent("Notify",source,"sucesso","Roubo concluído, as autoridades foram acionadas.",8000)
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
						else
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
						end
					end)
				end
			elseif itemName == "masterpick" then
				local vehicle,vnetid,placa,vname,lock,banned,trunk,model,street = vRPclient.vehList(source,7)
				local policia = vRP.getUsersByPermission("policia.permissao")
				if #policia > 1 then
					TriggerClientEvent("Notify",source,"importante","Número insuficiente de policiais no momento para iniciar o roubo.")
					return true
				end
				if vRP.hasPermission(user_id,"policia.permissao") then
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
						if #mec > 0 then
							if vRP.hasPermission(user_id,"mecanico.permissao") then
								if vRP.tryGetInventoryItem(user_id,"militec",1) then
									actived[user_id] = true
									TriggerClientEvent('cancelando',source,true)
									vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
									TriggerClientEvent("progress",source,15000,"reparando motor")
									SetTimeout(15000,function()
										actived[user_id] = nil
										TriggerClientEvent('cancelando',source,false)
										TriggerClientEvent('repararmotor',source,vehicle, true)
										vRPclient._stopAnim(source,false)
									end)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Existe mecânico(a) em serviço, chame através do seu <b>celular</b>")
							end
						else
							if vRP.tryGetInventoryItem(user_id,"militec",1) then
								actived[user_id] = true
								TriggerClientEvent('Creative:Update',source,'updateMochila')
								TriggerClientEvent('cancelando',source,true)
								vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
								TriggerClientEvent("progress",source,30000,"reparando motor")
								SetTimeout(30000,function()
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
							if vRPNclient.isNearCds(source, vector3(-211.1,-1324.73,30.9), 25) or vRPNclient.isNearCds(source, vector3(934.52,-951.64,39.76), 40) then
								if vRP.tryGetInventoryItem(user_id,"repairkit",1) then
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
								end
							else
								TriggerClientEvent("Notify",source,"negado","<b>Kit de Reparo</b> só pode ser utilizado na mecânica")
							end
						else
							TriggerClientEvent("Notify",source,"negado","Somente mecanicos podem utilizar <b>Kit de Reparo</b>, chame um através do <b>celular</b>")
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
								TriggerClientEvent("progress",source,10000,"trocando pneu")
								SetTimeout(10000,function()
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
								TriggerClientEvent("progress",source,30000,"trocando pneu")
								SetTimeout(30000,function()
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
                        TriggerClientEvent('Creative:Update',source,'updateMochila')
                        TriggerClientEvent('cancelando',source,true)
                        TriggerClientEvent("vehicleanchor",source)
                        TriggerClientEvent("progress",source,59500,"clonando")
                        SetTimeout(60000,function()
                            TriggerClientEvent('cancelando',source,false)
                            TriggerClientEvent("cloneplates",source,placa)
                            --TriggerEvent("setPlateEveryone",placa)
                            TriggerClientEvent("Notify",source,"sucesso","Placa clonada com sucesso.",8000)
                        end)
                    end
                end
			elseif itemName == "colete" then
				if vRP.tryGetInventoryItem(user_id,"colete",1) then
					vRPclient.setArmour(source,100)
					TriggerClientEvent('Creative:Update',source,'updateMochila')
				end
		end
		elseif type == "equipar" then
			if vRP.tryGetInventoryItem(user_id,itemName,1) then
				local weapons = {}
				local identity = vRP.getUserIdentity(user_id)
				weapons[string.gsub(itemName,"wbody|","")] = { ammo = 0 }
				vRPclient._giveWeapons(source,weapons)
				SendWebhookMessage(webhookinventario,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[EQUIPOU]: "..vRP.itemNameList(itemName).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
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
              vRPclient._giveWeapons(source,weapons,false)
              SendWebhookMessage(webhookinventario,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RECARREGOU]: "..vRP.itemNameList(itemName).." \n[MUNICAO]: "..parseInt(v.amount).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
              TriggerClientEvent('Creative:Update',source,'updateMochila')
            end
          end
        end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERLEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
	actived[user_id] = nil
end)