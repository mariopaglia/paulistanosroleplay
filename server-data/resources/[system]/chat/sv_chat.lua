-- DEFAULT --
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")
BMclient = Tunnel.getInterface("vRP_basic_menu","vRP_basic_menu")

RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

Citizen.CreateThread(function()
	ac_webhook_joins = GetConvar("ac_webhook_joins", "none")
	ac_webhook_gameplay = GetConvar("ac_webhook_gameplay", "none")
	ac_webhook_bans = GetConvar("ac_webhook_bans", "none")
	ac_webhook_wl = GetConvar("ac_webhook_wl", "none")
	ac_webhook_arsenal = GetConvar("ac_webhook_arsenal", "none")

	function SendWebhookMessage(webhook,message)
		if webhook ~= "none" then
			PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
		end
	end
end)


AddEventHandler('_chat:messageEntered', function(author, color, message)
    if not message or not author then
        return
    end

    --TriggerEvent('chatMessage', source, author, message)
	--TriggerClientEvent('chatMessage', source, author, message)

    if not WasEventCanceled() then
        --TriggerClientEvent('chatMessage', -1, author, color, message)
		TriggerClientEvent('sendProximityMessage', -1, source, author, message, color)
    end

    print(author .. ': ' .. message)
end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    --TriggerEvent('chatMessage', source, name, '/' .. command)

    if not WasEventCanceled() then
        --TriggerClientEvent('chatMessage', -1, name, { 255, 255, 255 }, '/' .. command) 
    end
	--print(name .. ': ' .. command)
    CancelEvent()
end)

--[[ player join messages
AddEventHandler('vRP:playerSpawn', function(user_id, source, first_spawn)
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then
		local player = vRP.getUserSource({user_id})
		vRP.getUserIdentity({user_id, function(identity)
			TriggerClientEvent('chatMessage', -1, '', { 254, 158, 16 }, '^3[SERVIDOR]: ^1'.. identity.name .. ' ' .. identity.firstname ..' entrou na cidade.')
			--TriggerClientEvent('chatMessage', -1, "[@Fora do RP] ".. GetPlayerName(source) .." ("..user_id..") ", {16, 255, 0}, rawCommand:sub(7))
		end})
	end
end)

AddEventHandler('playerDropped', function(reason)
	TriggerClientEvent('chatMessage', -1, '', { 254, 158, 16 }, '^3[SERVIDOR]: ^1' .. GetPlayerName(source) ..' saiu da cidade (' .. reason .. ')')
end)]]

RegisterCommand('say', function(source, args, rawCommand)
    TriggerClientEvent('chatMessage', -1, (source == 0) and 'console' or GetPlayerName(source), { 255, 255, 255 }, rawCommand:sub(4))
end)

-- Reporter
RegisterCommand('cam', function(source, args, rawCommand)
	TriggerClientEvent("Cam:ToggleCam", source)
end)

RegisterCommand('mic', function(source, args, rawCommand)
	TriggerClientEvent("Mic:ToggleMic", source)
end)

RegisterCommand('twt', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		local identity = vRP.getUserIdentity(user_id)
		TriggerClientEvent('chatMessage', -1, "[@Twitter] ".. identity.name .. " " .. identity.firstname .." ", {0, 170, 255}, rawCommand:sub(4))
		print("[Twitter] " ..GetPlayerName(player).. " - " ..user_id .. ':' .. rawCommand:sub(4))
	end
end)

RegisterCommand('ilegal', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		local identity = vRP.getUserIdentity(user_id)
		TriggerClientEvent('chatMessage', -1, "[@Anonimo]", {255, 255, 255}, rawCommand:sub(7))
		print("[Anonimo] " ..GetPlayerName(player).. " - " ..user_id .. ':' .. rawCommand:sub(7))
	end
end)

RegisterCommand('190', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		local identity = vRP.getUserIdentity(user_id)
		TriggerClientEvent('chatMessage', -1, "[@190] ".. identity.name .. " " .. identity.firstname .." ", {0, 0, 255}, rawCommand:sub(4))
		print("[190] " ..GetPlayerName(player).. " - " ..user_id .. ':' .. rawCommand:sub(4))
	end
end)

RegisterCommand('192', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		local identity = vRP.getUserIdentity(user_id)
		TriggerClientEvent('chatMessage', -1, "[@192] ".. identity.name .. " " .. identity.firstname .." ", {255, 120, 120}, rawCommand:sub(4))
		print("[192] " ..GetPlayerName(player).. " - " ..user_id .. ':' .. rawCommand:sub(4))
	end
end)

RegisterCommand('frp', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		local identity = vRP.getUserIdentity(user_id)
		TriggerClientEvent('chatMessage', -1, "[@OOC] ".. GetPlayerName(source) .." ("..user_id..") ", {25, 102, 25}, rawCommand:sub(4))
		CancelEvent()
		print("[@OOC] " ..GetPlayerName(player).. " - " ..user_id .. ':' .. rawCommand:sub(4))
	end
end)

--[[RegisterCommand('rg', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		local job = vRP.getUserGroupByType(user_id,"job")
		if identity then
			local address = vRP.getUserAddress(user_id)
			local home = "Não possui"
			local number = ""
			if address then
				home = address.home
				number = address.number
			end
			TriggerClientEvent('chatMessage', source, '', {255, 255, 255}, "^3Nome: ^7"..identity.name.." "..identity.firstname.." ^3Emprego: ^7"..job.." ^3Idade: ^7"..identity.age.." ^3RG: ^7" ..identity.registration.." ^3Telefone: ^7"..identity.phone.." ^3Propriedade: ^7" ..home.." "..number)
		end
	end
end)]]

-- command suggestions for clients
local function refreshCommands(player)
    if GetRegisteredCommands then
        local registeredCommands = GetRegisteredCommands()

        local suggestions = {}

        for _, command in ipairs(registeredCommands) do
            if IsPlayerAceAllowed(player, ('command.%s'):format(command.name)) then
                table.insert(suggestions, {
                    name = '/' .. command.name,
                    help = ''
                })
            end
        end

        TriggerClientEvent('chat:addSuggestions', player, suggestions)
    end
end

AddEventHandler('chat:init', function()
    refreshCommands(source)
end)

AddEventHandler('onServerResourceStart', function(resName)
    Wait(500)

    for _, player in ipairs(GetPlayers()) do
        refreshCommands(player)
    end
end)