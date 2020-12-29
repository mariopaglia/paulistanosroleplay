
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")


local webhook = "https://discord.com/api/webhooks/792968112148185108/-0k7BwFinFhHw4IQ72w9HffDGSyyTD2ph2MzrfIKP79OiCj_Q8MQG-yNw0loAOHqIzVf"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

--[[AddEventHandler('_chat:messageEntered', function(author, color, message)
    if not message or not author then
        return
    end

    TriggerEvent('chatMessage', source, author, message)

    if not WasEventCanceled() then
        local user_id = vRP.getUserId(source)
        local identity = vRP.getUserIdentity(user_id)
        fal = identity.name.. " " .. identity.firstname
        TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-image: linear-gradient(to right, rgba(36, 211, 242,1) 3%, rgba(36, 211, 242,0) 95%); border-radius: 15px 50px 30px 5px;"><i class="fab fa-twitter"></i> @{0}:<br>{1}</div>',
        args = { fal, message }
        })

    end
 end)]]

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    TriggerEvent('chatMessage', source, name, '/' .. command)

   -- if not WasEventCanceled() then
      --  TriggerClientEvent('chatMessage', -1, name, { 255, 255, 255 }, '/' .. command) 
    --end

    CancelEvent()
    end)

-- player join messages


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
	
    ---------------------------------------------------------
    

     RegisterCommand('taxi', function(source, args, rawCommand)
        local message = rawCommand:sub(5)
        local user_id = vRP.getUserId(source)
        local identity = vRP.getUserIdentity(user_id)
        fal = identity.name.. " " .. identity.firstname
        if vRP.hasPermission(user_id, "taxista.permissao") then
            TriggerClientEvent('chat:addMessage', -1, {
                template = '<div style="padding: 0.2vw; margin: 0.1vw; background-image: linear-gradient(to right, rgba(255, 255, 0,0.9) 3%, rgba(0, 0, 0,0) 95%); border-radius: 15px 50px 30px 5px;"><img style="width: 20px" src="https://www.flaticon.com/svg/static/icons/svg/3485/3485591.svg"> Taxista - '..fal..' ['..user_id..']: {1}</div>',
                args = { fal, message }
            })
            SendWebhookMessage(webhook,"```prolog\n[JOGADOR]: "..user_id.." "..identity.name.." "..identity.firstname..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."\n[Chat]: Taxista\n[Mensagem]:'"..message.."'\r```")
    end
    end, false)
	
	    RegisterCommand('conce', function(source, args, rawCommand)
        local message = rawCommand:sub(6)
        local user_id = vRP.getUserId(source)
        local identity = vRP.getUserIdentity(user_id)
        fal = identity.name.. " " .. identity.firstname
        if vRP.hasPermission(user_id, "concessionaria.permissao") then
            TriggerClientEvent('chat:addMessage', -1, {
                template = '<div style="padding: 0.2vw; margin: 0.1vw; background-image: linear-gradient(to right, rgba(255, 0, 255,0.9) 3%, rgba(0, 0, 0,0) 95%); border-radius: 15px 50px 30px 5px;"><img style="width: 20px" src="https://www.flaticon.com/svg/static/icons/svg/741/741407.svg"> Concessionária - '..fal..' ['..user_id..']: {1}</div>',
                args = { fal, message }
            })
            SendWebhookMessage(webhook,"```prolog\n[JOGADOR]: "..user_id.." "..identity.name.." "..identity.firstname..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."\n[Chat]: Concessionária\n[Mensagem]:'"..message.."'\r```")
    end
    end, false)
    
    RegisterCommand('mec', function(source, args, rawCommand)
        local message = rawCommand:sub(4)
        local user_id = vRP.getUserId(source)
        local identity = vRP.getUserIdentity(user_id)
        fal = identity.name.. " " .. identity.firstname
        if vRP.hasPermission(user_id, "mecanico.permissao") then
            TriggerClientEvent('chat:addMessage', -1, {
                template = '<div style="padding: 0.2vw; margin: 0.1vw; background-image: linear-gradient(to right, rgba(255, 20, 147,0.9) 3%, rgba(0, 0, 0,0) 95%); border-radius: 15px 50px 30px 5px;"><img style="width: 20px" src="https://www.flaticon.com/svg/static/icons/svg/748/748847.svg"> Mecânica - '..fal..' ['..user_id..']: {1}</div>',
                args = { fal, message }
            })
            SendWebhookMessage(webhook,"```prolog\n[JOGADOR]: "..user_id.." "..identity.name.." "..identity.firstname..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."\n[Chat]: Mecanica\n[Mensagem]:'"..message.."'\r```")
        end
    end, false)
    
    
    RegisterCommand('190', function(source, args, rawCommand)
        local message = rawCommand:sub(4)
        local user_id = vRP.getUserId(source)
        local identity = vRP.getUserIdentity(user_id)
        fal = identity.name.. " " .. identity.firstname
        if vRP.hasPermission(user_id, "policia.permissao") then
            TriggerClientEvent('chat:addMessage', -1, {
                template = "<div style='padding: 0.2vw; margin: 0.1vw; background-image: linear-gradient(to right, rgba(0, 0, 255,0.9) 3%, rgba(0, 0, 0,0) 95%); border-radius: 15px 50px 30px 5px;'><img style='width: 18px' src='https://image.flaticon.com/icons/svg/1022/1022484.svg'> 190 - "..fal.." ["..user_id.."]: {1}</div>",
                args = { fal, message }
            })
            SendWebhookMessage(webhook,"```prolog\n[JOGADOR]: "..user_id.." "..identity.name.." "..identity.firstname..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."\n[Chat]: Policia (190)\n[Mensagem]:'"..message.."'\r```")
        end
    end, false)
    
    RegisterCommand('192', function(source, args, rawCommand)
        local message = rawCommand:sub(4)
        local user_id = vRP.getUserId(source)
        local identity = vRP.getUserIdentity(user_id)
        if vRP.hasPermission(user_id, "paramedico.permissao") then
            fal = identity.name.. " " .. identity.firstname
            TriggerClientEvent('chat:addMessage', -1, {
                template = '<div style="padding: 0.2vw; margin: 0.1vw; background-image: linear-gradient(to right, rgba(255, 0, 0,0.7) 3%, rgba(0, 0, 0,0) 95%); border-radius: 15px 50px 30px 5px;"><img style="width: 18px" src="https://image.flaticon.com/icons/svg/1142/1142131.svg"> 192 - '..fal..' ['..user_id..']: {1}</div>',
                args = { fal, message }
            })
            SendWebhookMessage(webhook,"```prolog\n[JOGADOR]: "..user_id.." "..identity.name.." "..identity.firstname..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."\n[Chat]: SAMU (192)\n[Mensagem]:'"..message.."'\r```")
        end
    end, false)
    
    RegisterCommand('admin', function(source, args, rawCommand)
        local message = rawCommand:sub(6)
        local user_id = vRP.getUserId(source)
        local identity = vRP.getUserIdentity(user_id)
        fal = identity.name.. " " .. identity.firstname
        if vRP.hasPermission(user_id, "owner.permissao") or vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "moderador.permissao") or vRP.hasPermission(user_id, "wl.permissao") then
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.2vw; margin: 0.1vw; background-image: linear-gradient(to right, rgba(0, 255, 255,0.7) 3%, rgba(0, 0, 0,0) 95%); border-radius: 15px 50px 30px 5px;"><img style="width: 17px" src="https://image.flaticon.com/icons/svg/138/138304.svg"> PREFEITURA - '..fal..' ['..user_id..']: {1}</div>',
            args = { fal, message }
        })
        SendWebhookMessage(webhook,"```prolog\n[JOGADOR]: "..user_id.." "..identity.name.." "..identity.firstname..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."\n[Chat]: Admin\n[Mensagem]:'"..message.."'\r```")
        end
    end, false)
    
    RegisterCommand('clear', function(source)
        local user_id = vRP.getUserId(source);
        if user_id ~= nil then
            if vRP.hasPermission(user_id, "admin.permissao") then
                TriggerClientEvent("chat:clear", -1);
            --  TriggerClientEvent("chatMessage", source, " ");
            else
                TriggerClientEvent("chat:clear", source);
                --TriggerClientEvent("chatMessage", source, "Você não tem permissão");
            end
        end
    end)