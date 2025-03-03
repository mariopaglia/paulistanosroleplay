-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
vRP = Proxy.getInterface("vRP")
vRPNserver = Tunnel.getInterface("vrp_identidade")
-----------------------------------------------------------------------------------------------------------------------------------------
-- IDENTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
local identity = false

RegisterKeyMapping('vrp_identidade:open_fenix', 'Abrir Identidade', 'keyboard', 'F11')

RegisterCommand('vrp_identidade:open_fenix', function()
    if GetEntityHealth(PlayerPedId()) > 101 then
        if identity then
            identity = false
            SendNUIMessage({type = 'close'})
        else
            local carteira, banco, paypal, nome, sobrenome, idade, user_id, identidade, telefone, job, cargo, vip, multas, faturas, telefone, avatar = vRPNserver.Identidade()
            SendNUIMessage({type = 'open', nome = nome, sobrenome = sobrenome, carteira = carteira, banco = banco, vip = vip, emprego = job, cargo = cargo, id = user_id, documento = identidade, idade = idade, paypal = paypal, telefone = telefone, multas = multas, avatar = avatar})
            identity = true
        end
    end
end, false)
