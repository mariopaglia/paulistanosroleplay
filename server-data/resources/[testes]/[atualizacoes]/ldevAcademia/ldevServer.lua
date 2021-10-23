-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ( Tunnel )-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')
scriptAcademia = {}
Tunnel.bindInterface('ldevAcademia', scriptAcademia)
academiaCL = Tunnel.getInterface('ldevAcademia')
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ( Funções )------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function scriptAcademia.returnXP()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return vRP.getExp(user_id, 'physical', 'strength')
    end
end

function scriptAcademia.setXP()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local xpAtual = vRP.getExp(user_id, 'physical', 'strength')
        -- print(xpAtual)
        TriggerClientEvent('Creative:Update', user_id, 'updateMochila')
        print(vRP.getExp(user_id, "physical", "strength"))
        vRP.setExp(user_id, "physical", "strength", (vRP.getExp(user_id, "physical", "strength") + 30))
    end
end
