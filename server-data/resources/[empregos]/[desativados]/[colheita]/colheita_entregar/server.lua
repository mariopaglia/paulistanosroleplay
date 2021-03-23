local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("colheita_entregar", emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUANTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}
local quantidadepolvora = {}
function emP.Quantidade()
    local source = source
    if quantidade[source] == nil and quantidadepolvora[source] == nil then
        quantidade[source] = math.random(4, 6)
        quantidadepolvora[source] = math.random(7, 10)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.hasPermission(user_id, "bratva.permissao") or vRP.hasPermission(user_id, "cn.permissao")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
    vRP.antiflood(source, "colheita_entregar", 3)
    emP.Quantidade()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
		qnt = math.random(2,4)
		valor = math.random(800,1200)
        if vRP.tryGetInventoryItem(user_id, "rosa", parseInt(qnt)) then
            vRP.giveMoney(user_id, parseInt(valor*qnt))
            TriggerClientEvent("Notify", source, "sucesso", "Vendeu <b>" .. parseInt(qnt) .. "x " .. vRP.itemNameList("rosa") .. "</b> por <b>R$ " .. vRP.format(parseInt(valor*qnt)) .. "</b>.")
			return true
        else
            TriggerClientEvent("Notify", source, "aviso", "Não possui <b>" .. parseInt(qnt) .. "x " .. vRP.itemNameList("rosa") .. "</b> em sua mochila.")
        end
    end
end
