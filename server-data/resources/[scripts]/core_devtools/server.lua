local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")
vRP = Proxy.getInterface("vRP")

func = {}
Tunnel.bindInterface("core_devtools", func)

-- local webhook = "https://discord.com/api/webhooks/800148997599789087/23_7W_qlPDszannE5ugMw_K-g8PjvL3d7DWgy8XITzag7SSr_htMuzIllcj39lTyu8_v"
-- function SendWebhookMessage(webhook,message)
-- 	if webhook ~= nil and webhook ~= "" then
-- 		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
-- 	end
-- end

function func.Punicao()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        vRP.kick(source,'Você foi expulso por estar utilizando o Dev Tools, não mecha nisso!')
        vRP.Log("ANTI DEVTOOLS     [ID]: "..user_id.."  [KICKADO]		[MOTIVO: ACESSANDO O DEVTOOLS]", "AC_SUSPEITOS")
    end
end