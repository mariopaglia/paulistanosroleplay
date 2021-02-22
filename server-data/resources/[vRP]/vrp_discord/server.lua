-- local Tunnel = module("vrp","lib/Tunnel")
-- local Proxy = module("vrp","lib/Proxy")
-- vRP = Proxy.getInterface("vRP")
-- vRPclient = Tunnel.getInterface("vRP")

local logs = "https://discordapp.com/api/webhooks/756009434710409388/D6FFuDiqhkjGcscrCve30W9_5fzbdf2O7NNvW73FJjS4361c7S2P7AGyMcHtfuDLjCAD"
local communityname = "Paulistanos Roleplay"
local communtiylogo = "https://i.imgur.com/lSLWJ65.png"

AddEventHandler('playerConnecting', function()
local name = GetPlayerName(source)
local ip = GetPlayerEndpoint(source)
local ping = GetPlayerPing(source)
local connect = {
        {
            ["color"] = "65280",
            ["title"] = "Conectado no servidor",
            ["description"] = "Player: **"..name.."**\nIP: **"..(ip or '0.0.0.0').."**",
	        ["footer"] = {
                ["text"] = communityname,
                ["icon_url"] = communtiylogo,
            },
        }
    }

PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "Log de Entrada", embeds = connect}), { ['Content-Type'] = 'application/json' })
end)

AddEventHandler('playerDropped', function(reason)
local name = GetPlayerName(source)
local ip = GetPlayerEndpoint(source)
local ping = GetPlayerPing(source)
local disconnect = {
        {
            ["color"] = "16711680",
            ["title"] = "Desconectado do servidor",
            ["description"] = "Player: **"..name.."** \nReason: **"..reason.."**\nIP: **"..ip.."**",
	        ["footer"] = {
                ["text"] = communityname,
                ["icon_url"] = communtiylogo,
            },
        }
    }

    PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "Log de Saída", embeds = disconnect}), { ['Content-Type'] = 'application/json' })
end)