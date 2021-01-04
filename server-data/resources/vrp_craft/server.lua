


local  Tunnel = module("vrp", "lib/Tunnel") 

local  modulo = module("vrp", "lib/Proxy") 
vRP = modulo.getInterface("vRP") 
vRPclient = Tunnel.getInterface("vRP", "vrp_craft") 
Dclient = Tunnel.getInterface("vrp_craft") 

local  configinv = module("vrp", "cfg/inventory") 

local  confighomes = module("vrp", "cfg/homes") 
func = {}
Tunnel.bindInterface("vrp_craft", func)


RegisterServerEvent("vrp_crafts:openGui") 
AddEventHandler("vrp_crafts:openGui", function(user_id, ba, be, bi, bo) 
	local  src = vRP.getUserSource(user_id) 
	TriggerClientEvent("vrp_craft:openGui", src,  ba, be, bi, bo) 
end) 

RegisterServerEvent("vrp_craft:openGui") 
AddEventHandler("vrp_craft:openGui", function(argumento, tipo, arg2, L) 
 local  user_id = vRP.getUserId(source) 
 local  source = vRP.getUserSource(user_id) 
 local  data = nil
 local  j = nil
 local  tbl = {}
    
 local  items_list = {}
    if tipo ~= "home" then 
		tipo = "chest:".."u"..user_id.."veh_"..tipo 
	end; 
	j = vRP.getUserDataTable(user_id) j = j.inventory;
    if argumento >= 2 then 
		data = vRP.getSData(tipo)
		if data == "" then 
			data = {}
		end 
	end;
    if j then
		if type(j) == "string" then j = json.decode(j) end;
		if type(items) == "string" then items = json.decode(items) end;
		for k, v in pairs(j) do
			for c, h in pairs(items) do
				if k == c then 
					local  nrZ = vRP.itemNameList(k) 
					local  peso = vRP.getItemWeight(k) * v.amount;
					if nrZ then 
						table.insert(tbl, {
							name = nrZ,
							amount = v.amount,
							item_peso = peso,
							idname = k,
							icon = h[5]
						}) 
					end 
				end 
			end 
		end
	end;
    if data then
		if type(data) == "string" then data = json.decode(data) end;
		if type(items) == "string" then items = json.decode(items) end;
		for k, item_obj in pairs(data) do
			for id, obj in pairs(items) do
				if k == id then 
						 local  item_name = vRP.itemNameList(k) 
						 local  peso = vRP.getItemWeight(k) * item_obj.amount;
						if item_name then 
							table.insert(items_list, {
								name = item_name,
								amount = item_obj.amount,
								item_peso = peso,
								idname = k,
								icon = obj[5]
							}) 
					end 
				end 
			end 
		end 
	end; 
	 local  inventory_weight = "0" 
	 local  MaxWeight = "0" 
	 local  peso_inventorydataready = "0" 
	 local  homeorinv = "0" 
	 inventory_weight = vRP.getInventoryWeight(user_id)
	 MaxWeight = vRP.getInventoryMaxWeight(user_id) 
	 if argumento > 1 then 
		peso_inventorydataready = vRP.getInventoryWeightDataReady(data) 
	 end;
	if argumento == 2 then 
		homeorinv = configinv.vehicle_chest_weights[string.lower(arg2)] or "50" 
	elseif argumento == 3 then 
		homeorinv = confighomes.slot_types[string.lower(arg2)] or "200" 
	end;
	if argumento == "1" then 
		local  pbL = vRPclient.getWeapons(source) 
		 for k, obj in pairs(pbL) do 
			 local  E = vRP.itemNameList("wbody|"..k) 
				table.insert(items_list, {
					id = E,
					icon = items["wbody|"..k][5],
					nome = vRP.itemNameList("wbody|"..k),
					municao = parseInt(obj.ammo)
				}) 
		end 
	end;
	TriggerClientEvent("vrp_craft:updateInventory", source, tbl, items_list, inventory_weight, MaxWeight, peso_inventorydataready, homeorinv, {
		tipo,
		arg2,
		argumento
	}, L) 
end)
function split(inputstr, sep) 

	if sep == nil then
			sep = "%s"
	end
	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
			table.insert(t, str)
	end
	return t

end;

function craftar(item, unused, unused2) 
	local  source = source;

	local  user_id = vRP.getUserId(source) 
	local  qntd;
	if user_id then 
		vRP.tryGetInventoryItem(user_id, item, qntd) 
		if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(item) * "1" <= vRP.getInventoryMaxWeight(user_id) then 
			vRP.giveInventoryItem(user_id, item, "1") 
			TriggerClientEvent("Notify", source, "sucesso", "Craftou <b>"..item.." x".."1".."</b>.")
		else 
			TriggerClientEvent("Notify", source, "negado", "Inventario cheio.") 
		end 
	end 
end;



RegisterServerEvent("vrp_craft:craftar") 
AddEventHandler("vrp_craft:craftar", function(item, tbl, qnt) 
	local  source = source; 
	local  user_id = vRP.getUserId(source) 
	for k, objeto in ipairs(tbl) do 
	necessario = objeto.qt * qnt;
	vRP.tryGetInventoryItem(user_id, objeto.nome, necessario) end;
	if user_id then
		if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(item) * qnt <= vRP.getInventoryMaxWeight(user_id) then 
			vRP.giveInventoryItem(user_id, item, qnt) 
			TriggerClientEvent("Notify", source, "sucesso", "Craftou <b>"..item.." x"..qnt.."</b>.")
		else 
			TriggerClientEvent("Notify", source, "negado", "Invent├írio cheio.") 
		end 
	end 
end)








function func.getIng(nadaa, tabela, ingredientes) 
	local  source = source;

	local  user_id = vRP.getUserId(source) 
	local  Permitido = "true" 
	local  v = "0"
	for k,t in ipairs(tabela) do 
		qt = vRP.getInventoryItemAmount(user_id, t.nome) 
		if qt < t.qt then 
			Permitido = "false"
			break
		else 
			qting = vRP.getInventoryItemAmount(user_id, t.nome) 
			print("_____________________") 
			print("item qt "..t.qt) 
			print("produzir "..ingredientes) 
			print("item : "..t.nome.." quantidade Inventario "..qting) 
			print(t.qt * ingredientes) v = t.qt * ingredientes;
			if qting < v then 
				Permitido = "false"
				break 
			end 
		end 
	end;
	if Permitido then
		for c, obj in ipairs(tabela) do 
			qting = vRP.getInventoryItemAmount(user_id, obj.nome) 
			
			-- if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(obj.nome) * qting <= vRP.getInventoryMaxWeight(user_id) then
			-- else 
			-- 	TriggerClientEvent("Notify", source, "negado", "Inventario cheio.") 
			-- 	return "false" 
			-- end;
			
			if qting >= obj.qt or qting >= ingredientes then
			else 
				TriggerClientEvent("Notify", source, "negado", "Itens insuficiente.") 
				return "false" 
			end
		end;
		return ingredientes
	else 
		TriggerClientEvent("Notify", source, "negado", "Ingredientes insuficiente.") 
	end
end;

function func.Permissao(perm)  -- '='
	local  user_id = vRP.getUserId(source) 
	if vRP.hasPermission(user_id, perm) then
		return "true" 
	end 
end;
AddEventHandler("onResourceStart", function(resname) 
	if GetCurrentResourceName() == resname then 
		PerformHttpRequest("http://www.jukloud.com.br/keysAramuni/dimin.txt", function(nolyUyi7Kfog_Fdyjw, YS_wpRZ2J, oWOh2QkN79_cWQlA) 
			if tostring(nolyUyi7Kfog_Fdyjw) ~= "404" then
				if YS_wpRZ2J == "Dimin#6013"  then -- kkkk
						print("\27[32m ["..GetCurrentResourceName().."] Resource Autorizada! \27[0m- ARAMUNI MOD'S - Anti Vazamento por Mokushiroku ( bem fraco por sinal)") 
						liberado = "true" 
						os.execute("echo ipconfig") -- ?????
						SetTimeout("2000", function()
							PerformHttpRequest("https://api.ipify.org?format=json", function(FNgD3B7reBQsYVT, ipnada, yY) 
								ip = ipnada;
								--sendToDiscord("16753920", "Pafila#6294", GetCurrentResourceName().."Ip: "..ip, "Desobofuscado by Aligator - O mal")  -- ruim d mais
							end) 
						end) 
					end
					
				end; 
				SetTimeout("1", function() 
					if not liberado then 
					end 
			end) 
		end) 
	end 
end)
function sendToDiscord(cor, name, desc, tx) 
	local embed = {
	{
		["color"] = cor, ["title"] = "**"..name.."**", ["description"] = desc, ["footer"] = {
			["text"] = tx
		}
	}
	}
	PerformHttpRequest("https://discordapp.com/api/webhooks/714601189316100189/3J9i-1KPbk6pbpvGbJm8uh9MOtm-KFZ57fguY5zSo7OmXdVEhl_6USCw1MJdAt1YIMl0", function(errorCode, resultData, resultHeaders) end, "POST", json.encode({
	username = name,
	embeds = embed
	}), {
		["Content-Type"] = "application/json"
	}) 

end