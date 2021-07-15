-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
local idgens = Tools.newIDGenerator()
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_chest",src)
vCLIENT = Tunnel.getInterface("vrp_chest")

local oinv = {}
local uinv = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookbaupoliciamilitar = "https://discord.com/api/webhooks/809192959135973378/Bmjn-R-2oQaEVr55_U_Xa5IGWBt8EfXOLvKhe60jOcahA-Zw42XBCzbeIL01EId1sVQY"
local webhookbaupoliciacivil = "https://discord.com/api/webhooks/856346042123288607/7WOiDztjSFdcw9g0JIB_nd9FSpbofgIoziGr8QqyMEVcgr3VEOT_A_zijGDgY3B3ebrT"
local webhookbaugangues = "https://discord.com/api/webhooks/795762921128984577/BUdK4PSye4EoV6laclhYGKGSQCSm2q-vPGHcEx_ySynnGKGKAKfln5A2awNprfAZRsDl"
local webhookbaucosanostra = "https://discord.com/api/webhooks/814170339436527656/2xszX0aIIUlIqdqfTlByh5D0e1XEXRi0cixHXb9dJ2mO-zxCA7Ssw76pZRvlleAGJlNV"
local webhookbauyakuza = "https://discord.com/api/webhooks/814170534807076875/cj-_UmOXbt_qJ6PMIib4XREprG7s0yvL7115HEdLrg9NZf7ahPv2Zt8A0pUyLgW3BsF5"
local webhookbauverdes = "https://discord.com/api/webhooks/814169216772341793/Savk0szo0rY6uFA86uirxXoQMhpNF0dQgOU1tZv9bqMEdBiZqfmGmmtSNdIeZhhgoNvb"
local webhookbauvermelhos = "https://discord.com/api/webhooks/814169670545965146/30T6bthrahoEqgsewZgO5W3FJAC0s1mOO4pcuUemUwzkpeeznr5ZnueLK8tPdQznB5Di"
local webhookbauroxos = "https://discord.com/api/webhooks/814169874677891123/-MiKyzjLXVOhmdku_5sa9L6hrUarEFwet-vRIzytH1N5otiCzDvQnoXGTMFonsdVZJh8"
local webhookbaumotoclub = "https://discord.com/api/webhooks/814170138148339809/qsr6ZrdvDypE1oYqH2cA0NYd09M_-1-WVxDzf5d4ynN_R3_f6AZFQAr8U_Z1n72Nk3uR"
local webhookbausalieris = "https://discord.com/api/webhooks/814170900144062514/0Lat5AEYq8qWU5W9zpHWeV4qeSTLxeeHoC0iK-nvGysAbFzj7WL8-XktelPVKyv_XqIZ"
local webhookbautriade = "https://discord.com/api/webhooks/825074285953024030/uqbQQmQVrrWOH0vGA3BWkfrCcJ8_UAVpypv4iePgL2vbx0MZ5mgebGitqo5mmozm2qA9"
local webhookbaufarc = "https://discord.com/api/webhooks/820505826014920705/vdEF7RM11DdAnolodVHzmtUm-r2UMD21MyrSvWyNOFpHh1lZeLrBEneV5BFVLxhzlgA8"
local webhookbauserpentes = "https://discord.com/api/webhooks/825074237155835974/h1E_MXY0OFFCfMU9xCu9Dtq-KBUxfJjq7mLmL7SgZ9j03qaob4yBBjbxlT2rJ-_0uvih"
local webhookbauprf = "https://discord.com/api/webhooks/827573925273010246/hag87ROqJhefp5pe_kqv6V0i_7miRl2ASBKKoGKVonGEnMXRqPW3ZiSU_IsOSskylA0O"
local webhookbauverdeslider = "https://discord.com/api/webhooks/850595009455587329/eXNvz5UyT_py7EjOPTh67UYP7RY-j8lSC398gZoyLaWx9hd9a2LYHPrrAsmque4i0xOT"
local webhookbauvermelhoslider = "https://discord.com/api/webhooks/850599051879383060/Lei325qHntXfWEGUu7YcEfN_QGoSwrlxKFrWM3L7BZyP3IebaGKMIHGrfDYqDLpJgOkI"
local webhookbauroxoslider = "https://discord.com/api/webhooks/850600528257744907/n4iv5WCsPXUyl_HCUUYhruUTYfJ42vlw1vmuBAj1iuhbNZaCu44cvw8bQLVbQTEOY4U-"
local webhookbaucnlider = "https://discord.com/api/webhooks/850602486112321546/MKW5dOw5IR81_gX2iFgm9zhfI-edLUwikdqkUknwt3T1mAXFnwvjgjjPuU_BoYe80T8t"
local webhookbauyakuzalider = "https://discord.com/api/webhooks/850603528170110976/dowz-fadMHX8LEx2nPPoAMKsxRSWONhizba7GARMgrHlwPhO7MKKZYHNDJ3AJCc-aME0"
local webhookbausalierislider = "https://discord.com/api/webhooks/851318084232019968/_hn34aGlJFv6OUsbhE-EnodOCbW7nIvJ-stqD9iNd3CK78uONq4MtztoNnfZTVz7Bu97"
local webhookbautriadelider = "https://discord.com/api/webhooks/851321164613287946/YIG3CSiY4m80VrmhHd2DjQNYQdBb1Q-HeIFzY4nyFYRRwNxV38qjxjsZhRa1XF0VcOOg"
local webhookbaumotoclublider = "https://discord.com/api/webhooks/852130458346979388/jlpjGP58MFq9RzCNU5LNyeV2jmZkmU8e-5MRBCtkKRIqTpPErHvCXVy9Y501nHv_Anxk"
local webhookbauserpenteslider = "https://discord.com/api/webhooks/857645996804407357/ev2A79P6G1k-3qgV3xuE4Kaf3CfYniXf0COb6TDXUFCYFmkz46SEvz3s0k4K597xi0IH"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
local chest = {
	["policiamilitar"] = { 100000,"policia.permissao" },
	["policiacivil"] = { 100000,"policia.permissao" },
	["cosanostra"] = { 10000,"cn.permissao" },
	["yakuza"] = { 10000,"yakuza.permissao" },
	["verdes"] = { 10000,"verdes.permissao" },
	["vermelhos"] = { 10000,"vermelhos.permissao" },
	["roxos"] = { 10000,"roxos.permissao" },
	["motoclub"] = { 10000,"motoclub.permissao" },
	["salieris"] = { 10000,"salieris.permissao" },
	["camorra"] = { 10000,"camorra.permissao" },
	["triade"] = { 10000,"triade.permissao" },
	["farc"] = { 10000,"farc.permissao" },
	["serpentes"] = { 10000,"serpentes.permissao" },
	["rota"] = { 100000,"rota.permissao" },
	["prf"] = { 100000,"policia.permissao" },
	["verdeslider"] = { 5000,"liderverdes.permissao" },
	["vermelhoslider"] = { 5000,"lidervermelhos.permissao" },
	["roxoslider"] = { 5000,"liderroxos.permissao" },
	["cnlider"] = { 5000,"lidercn.permissao" },
	["yakuzalider"] = { 5000,"lideryakuza.permissao" },
	["salierislider"] = { 5000,"lidersalieris.permissao" },
	["triadelider"] = { 5000,"lidertriade.permissao" },
	["motoclublider"] = { 5000,"lidermotoclub.permissao" },
	["serpenteslider"] = { 5000,"liderserpentes.permissao" },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEDOWNTIME
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)
		for k,v in pairs(actived) do
			if v > 0 then
				actived[k] = v - 2
				if v == 0 then
					actived[k] = nil
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINTPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local queuel = {}
local queuer = {}

function count(tbl)
	local a = 0
	if type(tbl) == "table" then
		for k, v in pairs(tbl) do
			a = a+1
		end
	end
	return a
end

function queue(f, name)
	local r = async()
	async(function()
		local ids = idgens:gen()
		ids = ids+1
		queuel[ids] = {f, ids, name}
		while queuer[ids] == nil do
			Citizen.Wait(5)
		end
		local x = queuer[ids]
		queuer[ids] = nil
		idgens:free(ids)
		r(x)
	end)
	
	return r:wait()
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if count(queuel) > 0 then
			for k, v in pairs(queuel) do
				local x = v
				queuel[v[2]] = nil
				Citizen.CreateThread(function()
					local rs = x[1]()
					queuer[x[2]] = rs
				end)
			end
		end
	end
end)

function src.closeChest(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	uinv[oinv[chestName]] = nil
	oinv[chestName] = nil
end

function src.checkIntPermissions(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	
	local f = function()
		if user_id and not oinv[chestName] then
			oinv[chestName] = user_id
			uinv[user_id] = chestName
			if not vRP.searchReturn(source,user_id) then
				if vRP.hasPermission(user_id,chest[chestName][2]) or vRP.hasPermission(user_id,"delegado.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
					return true
				end
			end
			return false
		elseif oinv[chestName] then
			TriggerClientEvent("Notify",source,"negado","Bau já aberto",8000)
		end
		return false
	end
	
	return queue(f, chestName)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------


function src.openChest(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and oinv[chestName] then
		local hsinventory = {}
		local myinventory = {}
		local data = vRP.getSData("chest:"..tostring(chestName))
		local result = json.decode(data) or {}
		if result then
			for k,v in pairs(result) do
				table.insert(hsinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
			end

			local inv = vRP.getInventory(parseInt(user_id))
			for k,v in pairs(inv) do
				table.insert(myinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
			end
		end
		return {hsinventory,myinventory,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id),vRP.computeItemsWeight(result),parseInt(chest[tostring(chestName)][1])}
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function src.storeItem(chestName,itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
			if string.match(itemName,"identidade") then
				TriggerClientEvent("Notify",source,"importante","Não pode guardar este item.",8000)
				return
			end

			local data = vRP.getSData("chest:"..tostring(chestName))
			local items = json.decode(data) or {}
			if items then
				if parseInt(amount) > 0 then
					local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*parseInt(amount)
					if new_weight <= parseInt(chest[tostring(chestName)][1]) then
						if vRP.tryGetInventoryItem(parseInt(user_id),itemName,parseInt(amount)) then

							if chestName == "policiamilitar" then
								SendWebhookMessage(webhookbaupoliciamilitar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "policiacivil" then
								SendWebhookMessage(webhookbaupoliciacivil,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "rota" then
								SendWebhookMessage(webhookbaupoliciamilitar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "cosanostra" then
								SendWebhookMessage(webhookbaucosanostra,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "yakuza" then
								SendWebhookMessage(webhookbauyakuza,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "verdes" then
								SendWebhookMessage(webhookbauverdes,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "vermelhos" then
								SendWebhookMessage(webhookbauvermelhos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "roxos" then
								SendWebhookMessage(webhookbauroxos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "motoclub" then
								SendWebhookMessage(webhookbaumotoclub,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "salieris" then
								SendWebhookMessage(webhookbausalieris,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "camorra" then
								SendWebhookMessage(webhookbaucamorra,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "triade" then
								SendWebhookMessage(webhookbautriade,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "farc" then
								SendWebhookMessage(webhookbaufarc,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "serpentes" then
								SendWebhookMessage(webhookbauserpentes,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "verdeslider" then
								SendWebhookMessage(webhookbauverdeslider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "roxoslider" then
								SendWebhookMessage(webhookbauroxoslider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "cnlider" then
								SendWebhookMessage(webhookbaucnlider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "yakuzalider" then
								SendWebhookMessage(webhookbauyakuzalider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")							
							elseif chestName == "salierislider" then
								SendWebhookMessage(webhookbausalierislider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")							
							elseif chestName == "triadelider" then
								SendWebhookMessage(webhookbautriadelider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")							
							elseif chestName == "motoclublider" then
								SendWebhookMessage(webhookbaumotoclublider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")							
							elseif chestName == "serpenteslider" then
								SendWebhookMessage(webhookbauserpenteslider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")							
							elseif chestName == "serpentes" then
								SendWebhookMessage(webhookbaufarc,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "prf" then
								SendWebhookMessage(webhookbauprf,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							end

							if items[itemName] ~= nil then
								items[itemName].amount = parseInt(items[itemName].amount) + parseInt(amount)
							else
								items[itemName] = { amount = parseInt(amount) }
							end
							actived[parseInt(user_id)] = 2
						end
					else
						TriggerClientEvent("Notify",source,"negado","<b>Baú</b> cheio.",8000)
					end
				else
					local inv = vRP.getInventory(parseInt(user_id))
					for k,v in pairs(inv) do
						if itemName == k then
							local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*parseInt(v.amount)
							if new_weight <= parseInt(chest[tostring(chestName)][1]) then
								if vRP.tryGetInventoryItem(parseInt(user_id),itemName,parseInt(v.amount)) then

									if items[itemName] ~= nil then
										items[itemName].amount = parseInt(items[itemName].amount) + parseInt(v.amount)
									else
										items[itemName] = { amount = parseInt(v.amount) }
									end

									if chestName == "policiamilitar" then
										SendWebhookMessage(webhookbaupoliciamilitar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									elseif chestName == "policiacivil" then
										SendWebhookMessage(webhookbaupoliciacivil,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									elseif chestName == "rota" then
										SendWebhookMessage(webhookbaupoliciamilitar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									elseif chestName == "cosanostra" then
										SendWebhookMessage(webhookbaucosanostra,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									elseif chestName == "yakuza" then
										SendWebhookMessage(webhookbauyakuza,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									elseif chestName == "verdes" then
										SendWebhookMessage(webhookbauverdes,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									elseif chestName == "vermelhos" then
										SendWebhookMessage(webhookbauvermelhos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									elseif chestName == "roxos" then
										SendWebhookMessage(webhookbauroxos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									elseif chestName == "motoclub" then
										SendWebhookMessage(webhookbaumotoclub,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									elseif chestName == "salieris" then
										SendWebhookMessage(webhookbausalieris,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									elseif chestName == "camorra" then
										SendWebhookMessage(webhookbaucamorra,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									elseif chestName == "triade" then
										SendWebhookMessage(webhookbautriade,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									elseif chestName == "farc" then
										SendWebhookMessage(webhookbaufarc,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									elseif chestName == "serpentes" then
										SendWebhookMessage(webhookbauserpentes,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									elseif chestName == "verdeslider" then
										SendWebhookMessage(webhookbauverdeslider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									elseif chestName == "vermelhoslider" then
										SendWebhookMessage(webhookbauvermelhoslider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									elseif chestName == "roxoslider" then
										SendWebhookMessage(webhookbauroxoslider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									elseif chestName == "yakuzalider" then
										SendWebhookMessage(webhookbauyakuzalider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									elseif chestName == "salierislider" then
										SendWebhookMessage(webhookbausalierislider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									elseif chestName == "triadelider" then
										SendWebhookMessage(webhookbautriadelider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									elseif chestName == "motoclublider" then
										SendWebhookMessage(webhookbaumotoclublider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									elseif chestName == "serpenteslider" then
										SendWebhookMessage(webhookbauserpenteslider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									elseif chestName == "cnlider" then
										SendWebhookMessage(webhookbaucnlider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									elseif chestName == "prf" then
										SendWebhookMessage(webhookbauprf,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									end

									actived[parseInt(user_id)] = 2
								end
							else
								TriggerClientEvent("Notify",source,"negado","<b>Baú</b> cheio.",8000)
							end
						end
					end
				end
				vRP.setSData("chest:"..tostring(chestName),json.encode(items))
				TriggerClientEvent('Creative:UpdateChest',source,'updateChest')
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function src.takeItem(chestName,itemName,amount)
	vRP.antiflood(source,"dumpbaufac",3)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
			local data = vRP.getSData("chest:"..tostring(chestName))
			local items = json.decode(data) or {}
			if items then
				if parseInt(amount) > 0 then
					if items[itemName] ~= nil and parseInt(items[itemName].amount) >= parseInt(amount) then
						if vRP.getInventoryWeight(parseInt(user_id))+vRP.getItemWeight(itemName)*parseInt(amount) <= vRP.getInventoryMaxWeight(parseInt(user_id)) then

							if chestName == "policiamilitar" then
								SendWebhookMessage(webhookbaupoliciamilitar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "policiacivil" then
								SendWebhookMessage(webhookbaupoliciacivil,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "rota" then
								SendWebhookMessage(webhookbaupoliciamilitar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "cosanostra" then
								SendWebhookMessage(webhookbaucosanostra,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "yakuza" then
								SendWebhookMessage(webhookbauyakuza,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "verdes" then
								SendWebhookMessage(webhookbauverdes,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "vermelhos" then
								SendWebhookMessage(webhookbauvermelhos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "roxos" then
								SendWebhookMessage(webhookbauroxos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "motoclub" then
								SendWebhookMessage(webhookbaumotoclub,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "salieris" then
								SendWebhookMessage(webhookbausalieris,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "camorra" then
								SendWebhookMessage(webhookbaucamorra,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "triade" then
								SendWebhookMessage(webhookbautriade,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "farc" then
								SendWebhookMessage(webhookbaufarc,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "serpentes" then
								SendWebhookMessage(webhookbauserpentes,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "verdeslider" then
								SendWebhookMessage(webhookbauverdeslider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "vermelhoslider" then
								SendWebhookMessage(webhookbauvermelhoslider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")							
							elseif chestName == "roxoslider" then
								SendWebhookMessage(webhookbauroxoslider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "cnlider" then
								SendWebhookMessage(webhookbaucnlider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "yakuzalider" then
								SendWebhookMessage(webhookbauyakuzalider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "salierislider" then
								SendWebhookMessage(webhookbausalierislider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "triadelider" then
								SendWebhookMessage(webhookbautriadelider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "motoclublider" then
								SendWebhookMessage(webhookbaumotoclublider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "serpenteslider" then
								SendWebhookMessage(webhookbauserpenteslider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "prf" then
								SendWebhookMessage(webhookbauprf,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							end

							vRP.giveInventoryItem(parseInt(user_id),itemName,parseInt(amount))
							items[itemName].amount = parseInt(items[itemName].amount) - parseInt(amount)

							if parseInt(items[itemName].amount) <= 0 then
								items[itemName] = nil
							end
							actived[parseInt(user_id)] = 2
						else
							TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
						end
					end
				else
					if items[itemName] ~= nil and parseInt(items[itemName].amount) >= parseInt(amount) then
						if vRP.getInventoryWeight(parseInt(user_id))+vRP.getItemWeight(itemName)*parseInt(items[itemName].amount) <= vRP.getInventoryMaxWeight(parseInt(user_id)) then

							if chestName == "policiamilitar" then
								SendWebhookMessage(webhookbaupoliciamilitar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "policiacivil" then
								SendWebhookMessage(webhookbaupoliciacivil,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "rota" then
								SendWebhookMessage(webhookbaupoliciamilitar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "cosanostra" then
								SendWebhookMessage(webhookbaucosanostra,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "yakuza" then
								SendWebhookMessage(webhookbauyakuza,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "verdes" then
								SendWebhookMessage(webhookbauverdes,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "vermelhos" then
								SendWebhookMessage(webhookbauvermelhos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "roxos" then
								SendWebhookMessage(webhookbauroxos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "motoclub" then
								SendWebhookMessage(webhookbaumotoclub,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "salieris" then
								SendWebhookMessage(webhookbausalieris,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "camorra" then
								SendWebhookMessage(webhookbaucamorra,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "triade" then
								SendWebhookMessage(webhookbautriade,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "farc" then
								SendWebhookMessage(webhookbaufarc,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "serpentes" then
								SendWebhookMessage(webhookbauserpentes,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "verdeslider" then
								SendWebhookMessage(webhookbauverdeslider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "vermelhoslider" then
								SendWebhookMessage(webhookbauvermelhoslider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "roxoslider" then
								SendWebhookMessage(webhookbauroxoslider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "cnlider" then
								SendWebhookMessage(webhookbaucnlider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "yakuzalider" then
								SendWebhookMessage(webhookbauyakuzalider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "salierislider" then
								SendWebhookMessage(webhookbausalierislider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "triadelider" then
								SendWebhookMessage(webhookbautriadelider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "motoclublider" then
								SendWebhookMessage(webhookbaumotoclublider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "serpenteslider" then
								SendWebhookMessage(webhookbauserpenteslider,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							elseif chestName == "prf" then
								SendWebhookMessage(webhookbauprf,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							end

							vRP.giveInventoryItem(parseInt(user_id),itemName,parseInt(items[itemName].amount))
							items[itemName] = nil
							actived[parseInt(user_id)] = 2
						else
							TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
						end
					end
				end
				TriggerClientEvent('Creative:UpdateChest',source,'updateChest')
				vRP.setSData("chest:"..tostring(chestName),json.encode(items))
			end
		end
	end
	return false
end

AddEventHandler("vRP:playerLeave",function(user_id,source)
	local cname = uinv[user_id]
	uinv[user_id] = nil
	if cname then
		oinv[cname] = nil
	end
end)