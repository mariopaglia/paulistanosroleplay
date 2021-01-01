local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "emp_frete")

local cfg = module("emp_frete", "config/config")

RegisterServerEvent("esc_carreto:Entregar")
AddEventHandler("esc_carreto:Entregar", function()
    local player = source
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then 
        vRP.giveMoney(user_id, cfg.amount)

        TriggerClientEvent("Notify", player, "sucesso", cfg.messages.succefully)
        TriggerClientEvent("Notify", player, "importante", cfg.messages.continuar)
        --vRPclient.notify(player, {cfg.succefully}) 

        TriggerClientEvent("esc_carreto:Entregue", player)
    end
end)