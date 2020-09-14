-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_mercadolivre",src)
vCLIENT = Tunnel.getInterface("vrp_mercadolivre")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("creative/get_mercadolivrelist","SELECT id,user_id,item_id,quantidade,price,anony FROM vrp_mercadolivre")
vRP._prepare("creative/get_mercadolivrelist2","SELECT id,user_id,item_id,quantidade,price,anony FROM vrp_mercadolivre WHERE id = @id")
vRP._prepare("creative/get_mercadolivrelist3","SELECT id,user_id,item_id,quantidade,price,anony FROM vrp_mercadolivre WHERE user_id = @user_id AND item_id = @item_id AND quantidade = @quantidade AND price = @price")
vRP._prepare("creative/rem_mercadolivrelist","DELETE FROM vrp_mercadolivre WHERE id = @id")
vRP._prepare("creative/add_mercadolivreitem","INSERT IGNORE INTO vrp_mercadolivre(user_id,item_id,quantidade,price,anony) VALUES(@user_id,@item_id,@quantidade,@price,@anony)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local mercadolivre = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTOmercadolivre
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		mercadolivre = {}
		local mercadolivrelist = vRP.query("creative/get_mercadolivrelist")
		for k,v in pairs(mercadolivrelist) do
			if v.anony == "true" then
				name = "Anônimo"
			else
				local identity = vRP.getUserIdentity(v.user_id)
				name = identity.name
			end
			table.insert(mercadolivre,{ id = v.id, userid = v.user_id, nome = name, itemid = v.item_id, itemname = vRP.itemNameList(v.item_id), quantidade = v.quantidade, price = v.price })
			Citizen.Wait(10)
		end
		Citizen.Wait(60*60000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTOmercadolivre
-----------------------------------------------------------------------------------------------------------------------------------------
function src.automercadolivre(tipo,id,userid,itemid,qtd,price,anonimo)
	if tipo == "comprar" then
		for k,v in pairs(mercadolivre) do
			if parseInt(v.id) == parseInt(id) then
				table.remove(mercadolivre,k)
			end
		end
	elseif tipo == "vender" then
		local mercadolivrelist = vRP.query("creative/get_mercadolivrelist3",{ user_id = parseInt(userid), item_id = itemid, quantidade = qtd, price = price })
		if mercadolivrelist[1] then
			if anonimo == "true" then
				name = "Anônimo"
			else
				local identity = vRP.getUserIdentity(parseInt(userid))
				name = identity.name
			end
			table.insert(mercadolivre,{ id = mercadolivrelist[1].id, userid = parseInt(userid), nome = name, itemid = itemid, itemname = vRP.itemNameList(itemid), quantidade = qtd, price = price })
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- mercadolivreLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function src.mercadolivreList()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return mercadolivre
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function src.invList()
	local source = source
	local user_id = vRP.getUserId(source)
	local data = vRP.getInventory(user_id)
	if data then
		local inventario = {}
		for k,v in pairs(data) do
			if k ~= "bandagem" and k ~= "greencard" and k ~= "bluecard" and k ~= "yellowcard" and k ~= "dinheirosujo" and k ~= "algemas" and k ~= "cordas" and k ~= "capuz" and k ~= "lockpick" and k ~= "masterpick" and k ~= "notebook" and k ~= "maconha" and k ~= "cocaina" and k ~= "placa" and k ~= "rebite" and k ~= "orgao" and k ~= "etiqueta" and k ~= "pendrive" and k ~= "relogioroubado" and k ~= "pulseiraroubada" and k ~= "anelroubado" and k ~= "colarroubado" and k ~= "brincoroubado" and k ~= "carteiraroubada" and k ~= "carregadorroubado" and k ~= "tabletroubado" and k ~= "sapatosroubado" and k ~= "vibradorroubado" and k ~= "perfumeroubado" and k ~= "maquiagemroubada" and k ~= "wbody|WEAPON_DAGGER" and k ~= "wbody|WEAPON_BAT" and k ~= "wbody|WEAPON_BOTTLE" and k ~= "wbody|WEAPON_CROWBAR" and k ~= "wbody|WEAPON_FLASHLIGHT" and k ~= "wbody|WEAPON_GOLFCLUB" and k ~= "wbody|WEAPON_HAMMER" and k ~= "wbody|WEAPON_HATCHET" and k ~= "wbody|WEAPON_KNUCKLE" and k ~= "wbody|WEAPON_KNIFE" and k ~= "wbody|WEAPON_MACHETE" and k ~= "wbody|WEAPON_SWITCHBLADE" and k ~= "wbody|WEAPON_NIGHTSTICK" and k ~= "wbody|WEAPON_WRENCH" and k ~= "wbody|WEAPON_BATTLEAXE" and k ~= "wbody|WEAPON_POOLCUE" and k ~= "wbody|WEAPON_STONE_HATCHET" and k ~= "wbody|WEAPON_PISTOL" and k ~= "wbody|WEAPON_PISTOL_MK2" and k ~= "wbody|WEAPON_COMBATPISTOL" and k ~= "wbody|WEAPON_APPISTOL" and k ~= "wbody|WEAPON_STUNGUN" and k ~= "wbody|WEAPON_SNSPISTOL" and k ~= "wbody|WEAPON_VINTAGEPISTOL" and k ~= "wbody|WEAPON_REVOLVER" and k ~= "wbody|WEAPON_MUSKET" and k ~= "wbody|WEAPON_FLARE" and k ~= "wbody|GADGET_PARACHUTE" and k ~= "wbody|WEAPON_FIREEXTINGUISHER" and k ~= "wbody|WEAPON_MICROSMG" and k ~= "wbody|WEAPON_SMG" and k ~= "wbody|WEAPON_ASSAULTSMG" and k ~= "wbody|WEAPON_COMBATPDW" and k ~= "wbody|WEAPON_PUMPSHOTGUN" and k ~= "wbody|WEAPON_SAWNOFFSHOTGUN" and k ~= "wbody|WEAPON_CARBINERIFLE" and k ~= "wbody|WEAPON_ASSAULTRIFLE" and k ~= "wbody|WEAPON_GUSENBERG" and k ~= "wbody|WEAPON_MACHINEPISTOL" and k ~= "wbody|WEAPON_MINISMG" and k ~= "wbody|WEAPON_STICKYBOMB" and k ~= "wbody|WEAPON_ASSAULTRIFLE_MK2" and k ~= "wbody|WEAPON_PISTOL50" and k ~= "wbody|WEAPON_HEAVYPISTOL" and k ~= "wbody|WEAPON_SNSPISTOL_MK2" and k ~= "wbody|WEAPON_SMG_MK2" and k ~= "wbody|WEAPON_BULLPUPRIFLE" and k ~= "wbody|WEAPON_BULLPUPRIFLE_MK2" and k ~= "wbody|WEAPON_SPECIALCARBINE" and k ~= "wbody|WEAPON_SPECIALCARBINE_MK2" and k ~= "wammo|WEAPON_DAGGER" and k ~= "wammo|WEAPON_BAT" and k ~= "wammo|WEAPON_BOTTLE" and k ~= "wammo|WEAPON_CROWBAR" and k ~= "wammo|WEAPON_FLASHLIGHT" and k ~= "wammo|WEAPON_GOLFCLUB" and k ~= "wammo|WEAPON_HAMMER" and k ~= "wammo|WEAPON_HATCHET" and k ~= "wammo|WEAPON_KNUCKLE" and k ~= "wammo|WEAPON_KNIFE" and k ~= "wammo|WEAPON_MACHETE" and k ~= "wammo|WEAPON_SWITCHBLADE" and k ~= "wammo|WEAPON_NIGHTSTICK" and k ~= "wammo|WEAPON_WRENCH" and k ~= "wammo|WEAPON_BATTLEAXE" and k ~= "wammo|WEAPON_POOLCUE" and k ~= "wammo|WEAPON_STONE_HATCHET" and k ~= "wammo|WEAPON_PISTOL" and k ~= "wammo|WEAPON_PISTOL_MK2" and k ~= "wammo|WEAPON_COMBATPISTOL" and k ~= "wammo|WEAPON_APPISTOL" and k ~= "wammo|WEAPON_STUNGUN" and k ~= "wammo|WEAPON_SNSPISTOL" and k ~= "wammo|WEAPON_VINTAGEPISTOL" and k ~= "wammo|WEAPON_REVOLVER" and k ~= "wammo|WEAPON_MUSKET" and k ~= "wammo|WEAPON_FLARE" and k ~= "wammo|GADGET_PARACHUTE" and k ~= "wammo|WEAPON_FIREEXTINGUISHER" and k ~= "wammo|WEAPON_MICROSMG" and k ~= "wammo|WEAPON_SMG" and k ~= "wammo|WEAPON_ASSAULTSMG" and k ~= "wammo|WEAPON_COMBATPDW" and k ~= "wammo|WEAPON_PUMPSHOTGUN" and k ~= "wammo|WEAPON_SAWNOFFSHOTGUN" and k ~= "wammo|WEAPON_CARBINERIFLE" and k ~= "wammo|WEAPON_ASSAULTRIFLE" and k ~= "wammo|WEAPON_GUSENBERG" and k ~= "wammo|WEAPON_MACHINEPISTOL" and k ~= "wammo|WEAPON_MINISMG" and k ~= "wammo|WEAPON_STICKYBOMB" and k ~= "wammo|WEAPON_ASSAULTRIFLE_MK2" and k ~= "wammo|WEAPON_PISTOL50" and k ~= "wammo|WEAPON_HEAVYPISTOL" and k ~= "wammo|WEAPON_SNSPISTOL_MK2" and k ~= "wammo|WEAPON_SMG_MK2" and k ~= "wammo|WEAPON_BULLPUPRIFLE" and k ~= "wammo|WEAPON_BULLPUPRIFLE_MK2" and k ~= "wammo|WEAPON_SPECIALCARBINE" and k ~= "wammo|WEAPON_SPECIALCARBINE_MK2" then
				table.insert(inventario,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), itemid = k })
			end
			Citizen.Wait(10)
		end
		return inventario
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- mercadolivreBUY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.mercadolivreBuy(userid,price,qtd,itemid)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
	 vRP.giveInventoryItem(user_id,"itemid",qtd)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- mercadolivreSELL
-----------------------------------------------------------------------------------------------------------------------------------------
function src.mercadolivreSell(qtd,itemid,price,anonimo)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryFullPayment(user_id,parseInt(100*qtd)) then
			if vRP.tryGetInventoryItem(user_id,itemid,parseInt(qtd)) then
				TriggerClientEvent('mercadolivre:Update',source,'updateinvList')
				vRP.execute("creative/add_mercadolivreitem",{ user_id = parseInt(user_id), item_id = itemid, quantidade = parseInt(qtd), price = parseInt(price), anony = tostring(anonimo) })
				TriggerClientEvent("Notify",source,"sucesso","Adicionou <b>"..vRP.format(parseInt(qtd)).."x "..vRP.itemNameList(itemid).."</b> a venda por <b>$"..vRP.format(parseInt(price)).." dólares</b>.",10000)
				src.automercadolivre("vender",nil,user_id,itemid,parseInt(qtd),parseInt(price),tostring(anonimo))
			end
		else
			TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",8000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- mercadolivreEXTRACT
-----------------------------------------------------------------------------------------------------------------------------------------
function src.mercadolivreExtract(id,userid,qtd,itemid)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local mercadolivrelist = vRP.query("creative/get_mercadolivrelist2",{ id = id })
		if mercadolivrelist[1] then
			if user_id == parseInt(userid) then
				vRP.giveInventoryItem(user_id,itemid,parseInt(qtd))
				vRP.execute("creative/rem_mercadolivrelist",{ id = id })
				TriggerClientEvent("Notify",source,"sucesso","Retirou <b>"..vRP.format(parseInt(qtd)).."x "..vRP.itemNameList(itemid).."</b> do <b>mercadolivre</b>.",10000)
				src.automercadolivre("comprar",id)
				TriggerClientEvent('mercadolivre:Update',source,'updatemercadolivreList')
			end
		else
			TriggerClientEvent('mercadolivre:Update',source,'updatemercadolivreList')
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSEARCH
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkSearch()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.searchReturn(source,user_id) then
			return true
		end
		return false
	end
end