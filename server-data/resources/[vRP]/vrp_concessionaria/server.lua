local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")

vRPclient = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")

func = {}
Tunnel.bindInterface("vrp_concessionaria", func)
Proxy.addInterface("vrp_concessionaria", func)

-- WEBHOOK DISCORD

-- local webhookconce = "https://discord.com/api/webhooks/816685442522546216/0mkSXwKwXId-1VY7zUYspGoTW7KuIcvhH27xQ18RN_kJCe6LoqXVBL3sI23ZaDVxnyhh"

-- function SendWebhookMessage(webhook, message)
--     if webhook ~= nil and webhook ~= "" then
--         PerformHttpRequest(webhook, function(err, text, headers)
--         end, 'POST', json.encode({content = message}), {['Content-Type'] = 'application/json'})
--     end
-- end

vRP._prepare("vRP/add_vehicle", "INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,ipva) VALUES(@user_id,@vehicle,@ipva)")
vRP._prepare("vRP/remove_vehicle", "DELETE FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("vRP/remove_vrp_srv_data", "DELETE FROM vrp_srv_data WHERE dkey = @dkey")
vRP._prepare("vRP/get_vehicles", "SELECT vehicle, time FROM vrp_user_vehicles WHERE user_id = @user_id")
vRP._prepare("vRP/get_vehicle", "SELECT vehicle FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("vRP/count_vehicle", "SELECT COUNT(*) as qtd FROM vrp_user_vehicles WHERE vehicle = @vehicle")
vRP._prepare("vRP/get_maxcars", "SELECT COUNT(vehicle) as quantidade FROM vrp_user_vehicles WHERE user_id = @user_id")
vRP._prepare("vRP/get_total_carros_tipo", "SELECT vehicle, count(1) total FROM vrp_user_vehicles GROUP BY vehicle")

-- function func.init() 
--     vRPclient._addMarker(source,23,-31.81,-1113.83,25.45,2,2,0.5,0,95,140,80,100)
-- end

function func.getTotalVeiculorTipo()
    return vRP.query("vRP/get_total_carros_tipo")
end

function func.abertoTodos()
    local totalConcessionaria = vRP.getUsersByPermission("concessionaria.permissao")
    if #totalConcessionaria == 0 then
        return true
    end
    return Config.AbertoAll
end

function func.getPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.hasPermission(user_id, "concessionaria.permissao")
end

function func.getVeiculos()
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.query("vRP/get_vehicles", {user_id = user_id})
end

function func.getTotalVeiculos(user_id)
    local vehs = vRP.query("vRP/get_vehicles", {user_id = user_id})
    local c = 0
    for k, v in pairs(vehs) do
        local cat = vRP.vehicleType(v.vehicle)
        if cat ~= "vip" and parseInt(v.time) == 0 then
            c = c+1
        end
    end
    return c
end

function func.comprarVeiculo(categoria, modelo)
    vRP.antiflood(source, "comprarcarro", 2)
    local source = source
    local user_id = vRP.getUserId(source)
    local isVendedor = func.getPermissao()
    if Config.AbertoAll or vRP.hasPermission(user_id, "concessionaria.permissao") then

        categoria = categoria + 1
        modelo = modelo + 1

        local veiculo = Config.Veiculos[categoria].veiculos[modelo]

        if veiculo then
            local getVeiculo = vRP.query("vRP/get_vehicle", {user_id = user_id, vehicle = veiculo.model})

            if #getVeiculo == 0 then
                local rows = vRP.query("vRP/count_vehicle", {vehicle = veiculo.model})
                if parseInt(rows[1].qtd) >= veiculo.estoque then
                    TriggerClientEvent("vrp_concessionaria:notify", source, "Ops!", "Estoque indisponivel.", "error")
                    return
                else
                    local totalGaragens = Config.TotalGaragem

                    if vRP.hasPermission(user_id, "diamante.permissao") then
                        totalGaragens = Config.TotalGaragem + 9
                    elseif vRP.hasPermission(user_id, "esmeralda.permissao") then
                        totalGaragens = Config.TotalGaragem + 6
                    elseif vRP.hasPermission(user_id, "platina.permissao") then
                        totalGaragens = Config.TotalGaragem + 4
                    elseif vRP.hasPermission(user_id, "ouro.permissao") then
                        totalGaragens = Config.TotalGaragem + 2
                    elseif vRP.hasPermission(user_id, "prata.permissao") then
                        totalGaragens = Config.TotalGaragem + 2
                    elseif vRP.hasPermission(user_id, "apoiador.permissao") then
                        totalGaragens = Config.TotalGaragem + 1
                    end

                    if func.getTotalVeiculos(user_id) >= totalGaragens then
                        TriggerClientEvent("vrp_concessionaria:notify", source, "Ops!", "Atingiu o número máximo de veículos em sua garagem.", "error")
                        return
                    end

                    local valor = veiculo.preco
                    if isVendedor then
                        valor = valor * 0.9
                    end

                    if vRP.tryFullPayment(user_id, valor) then
                        local identity = vRP.getUserIdentity(user_id)
                        vRP.execute("vRP/add_vehicle", {user_id = user_id, vehicle = veiculo.model, ipva = parseInt(os.time())})
                        TriggerClientEvent("vrp_concessionaria:notify", source, "Oba!", "Pagou <b>R$" .. vRP.format(parseInt(valor)) .. "</b>.", "success")
                        vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[COMRPROU]: " .. veiculo.model .. "\n[VALOR]: R$ " .. vRP.format(parseInt(valor)) .. "" .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. "```", "CONCE")
                        return true
                    else
                        TriggerClientEvent("vrp_concessionaria:notify", source, "Ops!", "Dinheiro insuficiente.", "error")
                        return
                    end
                end
            else
                TriggerClientEvent("vrp_concessionaria:notify", source, "Ops!", "Você já possui este veículo!", "error")
                return
            end
        else
            TriggerClientEvent("vrp_concessionaria:notify", source, "Ops!", "Veículo inválido!", "error")
            return
        end
    else
        TriggerClientEvent("vrp_concessionaria:notify", source, "Ops!", "Somente o dono da concessionária pode executar está ação!", "error")
        return
    end

end

local carsv = {}
function func.registerCars(car, rt)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "concessionaria.permissao") then
        if not rt then
            table.insert(carsv, car)
        else
            local v = carsv
            carsv = {}
            return v
        end
    end
    return {}
end

function func.venderVeiculo(categoria, modelo)
    vRP.antiflood(source, "vendercarro", 3)
    local source = source
    local user_id = vRP.getUserId(source)

    if Config.AbertoAll or (Config.AbertoAll == false and vRP.hasPermission(user_id, "concessionaria.permissao")) then
        categoria = parseInt(categoria + 1)
        modelo = parseInt(modelo + 1)

        local veiculo = Config.Veiculos[categoria].veiculos[modelo]

        if veiculo then
            local price = math.ceil(veiculo.preco * 0.7)

            if Config.AbertoAll == false then
                price = math.ceil(veiculo.preco * 0.7)
            end
            local rows = vRP.query("vRP/get_vehicle", {user_id = user_id, vehicle = veiculo.model})
            if #rows <= 0 then
                TriggerClientEvent("vrp_concessionaria:notify", source, "Ops!", "Não encontrado", "error")
                return false
            end
            if parseInt(rows[1].detido) >= 1 then
                TriggerClientEvent("vrp_concessionaria:notify", source, "Ops!", "Acione a seguradora antes de vender.", "error")

                return false
            end

            vRP.execute("vRP/remove_vehicle", {user_id = user_id, vehicle = veiculo.model})

            vRP.execute("vRP/remove_vrp_srv_data", {dkey = "custom:u" .. user_id .. "veh_" .. veiculo.model})
            -- vRP.setSData("custom:u" .. user_id .. "veh_" .. veiculo.model,
            --              json.encode())
            vRP.giveMoney(user_id, parseInt(price))
            if parseInt(price) > 0 then
                local identity = vRP.getUserIdentity(user_id)
                TriggerClientEvent("vrp_concessionaria:notify", source, "Oba!", "Recebeu <b>R$" .. vRP.format(parseInt(price)) .. "</b>.", "success")
                vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[VENDEU]: " .. veiculo.model .. "\n[VALOR]: R$ " .. vRP.format(parseInt(price)) .. "" .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. "```", "CONCE")
            end
            vRP.closeMenu(source)

            return true
        else
            TriggerClientEvent("vrp_concessionaria:notify", source, "Ops!", "Veículo inválido!", "error")

            return false
        end
    else
        TriggerClientEvent("Notify", source, "negado", "Somente o dono da concessionária pode executar está ação!")
    end
end

function func.getNomeVeiculo()
    return vRP.prompt(source, "Nome do veículo:", "")
end