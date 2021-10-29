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
-- CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
local chest = {
	["policiamilitar"] = { 100000,"policia.permissao", ['webhook'] = "BAU_POLICIA" },
	["policiacivil"] = { 100000,"policia.permissao", ['webhook'] = "" },
	["cosanostra"] = { 10000,"cn.permissao", ['webhook'] = "BAU_COSANOSTRA" },
	["yakuza"] = { 10000,"yakuza.permissao", ['webhook'] = "BAU_YAKUZA" },
	["verdes"] = { 10000,"verdes.permissao", ['webhook'] = "BAU_VERDES" },
	["vermelhos"] = { 10000,"vermelhos.permissao", ['webhook'] = "BAU_VERMELHOS" },
	["roxos"] = { 10000,"roxos.permissao", ['webhook'] = "BAU_ROXOS" },
	--["motoclub"] = { 10000,"motoclub.permissao" },
	["salieris"] = { 10000,"salieris.permissao", ['webhook'] = "BAU_SALIERIS" },
	["sinaloa"] = { 10000,"sinaloa.permissao", ['webhook'] = "BAU_SINALOA" },
	["sinaloalider"] = { 5000,"lidersinaloa.permissao", ['webhook'] = "BAU_SINALOAL" },
	["triade"] = { 10000,"triade.permissao", ['webhook'] = "BAU_TRIADE" },
	["farc"] = { 10000,"farc.permissao", ['webhook'] = "" },
	--["serpentes"] = { 10000,"serpentes.permissao" },
	["rota"] = { 100000,"rota.permissao", ['webhook'] = "" },
	["prf"] = { 100000,"policia.permissao", ['webhook'] = "" },
	["verdeslider"] = { 5000,"liderverdes.permissao", ['webhook'] = "BAU_VERDESL" },
	["vermelhoslider"] = { 5000,"lidervermelhos.permissao", ['webhook'] = "BAU_VERMELHOSL" },
	["roxoslider"] = { 5000,"liderroxos.permissao", ['webhook'] = "BAU_ROXOSL" },
	["cnlider"] = { 5000,"lidercn.permissao", ['webhook'] = "BAU_COSANOSTRAL" },
	["yakuzalider"] = { 5000,"lideryakuza.permissao", ['webhook'] = "BAU_YAKUZAL" },
	["salierislider"] = { 5000,"lidersalieris.permissao", ['webhook'] = "BAU_SALIERISL" },
	["triadelider"] = { 5000,"lidertriade.permissao", ['webhook'] = "BAU_TRIADEL" },
	--["motoclublider"] = { 5000,"lidermotoclub.permissao" },
	--["serpenteslider"] = { 5000,"liderserpentes.permissao" },
	["irmandade"] = {10000,"irmandade.permissao", ['webhook'] = "BAU_IRMANDADE"},
	["irmandadelider"] = {5000,"liderirmandade.permissao", ['webhook'] = "BAU_IRMANDADEL"},
	["laranjas"] = {10000,"laranjas.permissao", ['webhook'] = "BAU_LARANJAS"},
	["laranjaslider"] = {5000,"liderlaranjas.permissao", ['webhook'] = "BAU_LARANJASL"},
	["midnight"] = {10000,"midnight.permissao", ['webhook'] = "BAU_MIDNIGHT"},
	["midnightlider"] = {5000,"lidermidnight.permissao", ['webhook'] = "BAU_MIDNIGHTL"},
	["driftking"] = {10000,"driftking.permissao", ['webhook'] = "BAU_DRIFTKING"},
	["driftkinglider"] = {5000,"liderdriftking.permissao", ['webhook'] = "BAU_DRIFTKINGL"},
	["dici"] = { 10000,"dic.permissao", ['webhook'] = "BAU_DICI" },
	["dicii"] = { 10000,"diciii.permissao", ['webhook'] = "BAU_DICII" },
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
				if vRP.hasPermission(user_id,chest[chestName][2]) or vRP.hasPermission(user_id,"founder.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
					return true
				else
					TriggerClientEvent("Notify",source,"negado","Sem permissão",8000)
					uinv[oinv[chestName]] = nil
					oinv[chestName] = nil
					return false
				end
			end
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
							
							if chest[tostring(chestName)]['webhook'] then 
								vRP.Log("```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```", chest[tostring(chestName)]['webhook'])
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

									if chest[tostring(chestName)]['webhook'] then 
										vRP.Log("```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(parseInt(v.amount))).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```", chest[tostring(chestName)]['webhook'])
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

local itemlist = {
    "dinheirosujo",
    "algemas",
    "capuz",
    "lockpick",
    "papouladeopio",
    "frascodeplastico",
    "masterpick",
    "maconha",
    "cocaina",
    "heroina",
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
	"listadesmanche",
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
    "ticketpvp",
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
    "wbody|WEAPON_MUSKET",
    "wbody|WEAPON_SAWNOFFSHOTGUN",
    "wbody|WEAPON_MINISMG",
    "wbody|WEAPON_SNSPISTOL",
    "wbody|WEAPON_PUMPSHOTGUN_MK2",
    "wammo|WEAPON_MUSKET",
    "wammo|WEAPON_SAWNOFFSHOTGUN",
    "wammo|WEAPON_MINISMG",
    "wammo|WEAPON_SNSPISTOL",
    "wammo|WEAPON_PUMPSHOTGUN_MK2",
}

RegisterCommand('apreender', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "policia.permissao") or vRP.hasPermission(user_id, "kick.permissao") then
        local user_id = vRP.getUserId(source)
        local nplayer = vRPclient.getNearestPlayer(source, 2)
        if nplayer then
            local identity = vRP.getUserIdentity(user_id)
            local nuser_id = vRP.getUserId(nplayer)
            local nidentity = vRP.getUserIdentity(nuser_id)
            if vRP.hasPermission(nuser_id, "policia.permissao") or vRP.hasPermission(nuser_id, "nogarmas.permissao") then
                vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[TENTOU APREENDER DE]: " .. nuser_id .. " " .. nidentity.name .. " " .. nidentity.firstname .. "" .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "CMD_APREENDER")
                return TriggerClientEvent("Notify", source, "negado", "Policiais não podem apreender itens/armamentos de outros policiais")
            end
            if nuser_id then
                local nidentity = vRP.getUserIdentity(nuser_id)
                local itens_apreendidos = {}
                local weapons = vRPclient.replaceWeapons(nplayer, {})
                for k, v in pairs(weapons) do
                    vRP.giveInventoryItem(nuser_id, "wbody|" .. k, 1)
                    if v.ammo > 0 then
                        vRP.giveInventoryItem(nuser_id, "wammo|" .. k, v.ammo)
                    end
                end

                local inv = vRP.getInventory(nuser_id)
                TriggerClientEvent('chatMessage', source, "", {}, "===== ITENS APREENDIDOS DE [" .. nuser_id .. " " .. nidentity.name .. " " .. nidentity.firstname .. "]: =====")
                for k, v in pairs(itemlist) do
                    local sub_items = {v}
                    if string.sub(v, 1, 1) == "*" then
                        local idname = string.sub(v, 2)
                        sub_items = {}
                        for fidname, _ in pairs(inv) do
                            if splitString(fidname, "|")[1] == idname then
                                table.insert(sub_items, fidname)
                            end
                        end
                    end
                    
                    for _, idname in pairs(sub_items) do
                        local amount = vRP.getInventoryItemAmount(nuser_id, idname)
                        if amount > 0 then
                            local item_name, item_weight = vRP.getItemDefinition(idname)
                            if item_name then
                                if vRP.tryGetInventoryItem(nuser_id, idname, amount, true) then
                                    -- vRP.giveInventoryItem(user_id, idname, amount)
									local chestData = vRP.getSData("chest:policiamilitar")
									chestData = json.decode(chestData) or {}
									if chestData then
										if chestData[idname] then
											chestData[idname].amount = parseInt(chestData[idname].amount) + parseInt(amount)
										else
											chestData[idname] = { amount = parseInt(amount) }
										end
										
									end
                                    TriggerClientEvent('chatMessage', source, "", {}, "     [ITEM]: " .. vRP.itemNameList(idname) .. " [QNT]: " .. amount)
                                    table.insert(itens_apreendidos, "[ITEM]: " .. vRP.itemNameList(idname) .. " [QUANTIDADE]: " .. amount)
									vRP.setSData("chest:policiamilitar",json.encode(chestData))
                                end
                            end
                        end
                    end
                end
                local apreendidos = table.concat(itens_apreendidos, "\n")
                vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[APREENDEU DE]:  " .. nuser_id .. " " .. nidentity.name .. " " .. nidentity.firstname .. "\n" .. apreendidos .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "CMD_APREENDER")
                TriggerClientEvent("Notify", nplayer, "importante", "Todos os seus pertences foram apreendidos.")
                TriggerClientEvent("Notify", source, "importante", "Todos os pertences apreendidos foram enviados para o baú")
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function src.takeItem(chestName,itemName,amount)
	vRP.antiflood(source,"dumpbaufac",3)
	local source = source
	local user_id = vRP.getUserId(source)

	if chestName == "policiamilitar" or chestName == "policiacivil" then
		if not vRP.hasPermission(user_id,"pmfciv.permissao") then
			TriggerClientEvent("Notify",source,"negado","Apenas o <b>Alto Comando</b> pode retirar itens do baú",8000)
				return
		end
	end
	
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

							if chest[tostring(chestName)]['webhook'] then 
								vRP.Log("```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```", chest[tostring(chestName)]['webhook'])
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

							if chest[tostring(chestName)]['webhook'] then 
								vRP.Log("```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```", chest[tostring(chestName)]['webhook'])
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
