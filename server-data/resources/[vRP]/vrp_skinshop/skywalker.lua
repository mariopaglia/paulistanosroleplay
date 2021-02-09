local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_skinshop")
vRPloja = Tunnel.getInterface("vrp_skinshop")

RegisterServerEvent("vrp_skinshop:Comprar")
AddEventHandler("vrp_skinshop:Comprar", function(preco)
    local source = source
    local user_id = vRP.getUserId(source)
    if preco then
        
        if vRP.hasPermission(user_id,"diamante.permissao") then
            off = 18
            desconto = math.floor(preco*off/100)
            pagamento = math.floor(preco-desconto)
        elseif vRP.hasPermission(user_id,"esmeralda.permissao") then
            off = 15
            desconto = math.floor(preco*off/100)
            pagamento = math.floor(preco-desconto)
        elseif vRP.hasPermission(user_id,"platina.permissao") then
            off = 12
            desconto = math.floor(preco*off/100)
            pagamento = math.floor(preco-desconto)
        elseif vRP.hasPermission(user_id,"ouro.permissao") then
            off = 9
            desconto = math.floor(preco*off/100)
            pagamento = math.floor(preco-desconto)
        elseif vRP.hasPermission(user_id,"prata.permissao") then
            off = 6
            desconto = math.floor(preco*off/100)
            pagamento = math.floor(preco-desconto)
        elseif vRP.hasPermission(user_id,"bronze.permissao") then
            off = 3
            desconto = math.floor(preco*off/100)
            pagamento = math.floor(preco-desconto)
        else
            pagamento = math.floor(preco)
        end

        local valortotal = vRP.format(parseInt(pagamento))

        if valortotal == 0 then
            valortotal = 0
        end
        if vRP.tryFullPayment(user_id,parseInt(pagamento)) then
            TriggerClientEvent("Notify",source,"sucesso","Você pagou <b>R$ "..valortotal.." </b> ("..off.."% OFF) em roupas e acessórios")
            TriggerClientEvent('vrp_skinshop:ReceberCompra', source, true)
        else
            TriggerClientEvent("Notify",source,"negado","Dinheiro & saldo insuficientes")
            TriggerClientEvent('vrp_skinshop:ReceberCompra', source, false)	
        end
    end
end)

