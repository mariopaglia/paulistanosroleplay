local logs = ""
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
            ["description"] = "Player: **"..name.."**\nIP: **"..ip.."**",
	        ["footer"] = {
                ["text"] = communityname,
                ["icon_url"] = communtiylogo,
            },
        }
    }

PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "ENTROU", embeds = connect}), { ['Content-Type'] = 'application/json' })
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

    PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "SAIU", embeds = disconnect}), { ['Content-Type'] = 'application/json' })
end)
