local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local userlogin = {}
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		local data = vRP.getUData(user_id,"vRP:spawnController")
		local sdata = json.decode(data) or 0
		if sdata then
			Citizen.Wait(1000)
			processSpawnController(source,sdata,user_id)
		end
	end
end)

function processSpawnController(source,statusSent,user_id)
	local source = source
	if statusSent == 2 then
		if not userlogin[user_id] then
			userlogin[user_id] = true
			doSpawnPlayer(source,user_id,false)
		else
			doSpawnPlayer(source,user_id,true)
		end
	elseif statusSent == 1 or statusSent == 0 then
		userlogin[user_id] = true
		TriggerClientEvent("b2k-character:characterCreate",source)
	end
end

RegisterServerEvent("b2k-character:finishedCharacter")
AddEventHandler("b2k-character:finishedCharacter",function(characterNome,characterSobrenome,characterAge,currentCharacterMode)

	-- APLICAÇÃO DE FIX PARA PESSOAS QUE ESTÃO BUGANDO NUI E FORÇANDO COMANDOS NO CHAT (WL, BAN, ETC)
	if(string.find(characterNome, "onload") or string.find(characterSobrenome,"onload"))then        
		local user_id = vRP.getUserId(source)    
		vRP.setBanned(user_id, true)        
		DropPlayer(source, "Você foi banido da cidade, bugador safado!")
		local webhook = "https://discord.com/api/webhooks/800148956649750558/BYP4AcXNkOfOosRVVW7NUhPiM8WNDiKAoMn2g4-SUYFayTm-mHrrya4ppsF89aB8jUxS"
		local message = "BUGANDO NUI: "..user_id
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
		return
	end
	
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.setUData(user_id,"currentCharacterMode",json.encode(currentCharacterMode))
		vRP.setUData(user_id,"vRP:spawnController",json.encode(2))
		vRP.execute("vRP/update_user_first_spawn",{ user_id = user_id, firstname = characterSobrenome, name = characterNome, age = characterAge })
		doSpawnPlayer(source,user_id,true)
	end
end)

function doSpawnPlayer(source,user_id,firstspawn)
	TriggerClientEvent("b2k-character:normalSpawn",source,firstspawn)
	TriggerEvent("creative-barbershop:init",user_id)
end