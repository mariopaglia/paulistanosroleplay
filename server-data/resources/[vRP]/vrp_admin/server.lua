local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

crz = {}
Tunnel.bindInterface("vrp_admin", crz)

vADMC = Tunnel.getInterface("vrp_admin", "vrp_admin")
local Tools = module("vrp","lib/Tools")
local idgens = Tools.newIDGenerator()
local blips = {}

-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("admin/resetarpersonagem", "DELETE FROM vrp_user_data WHERE user_id = @user_id AND dkey ='currentCharacterMode'")
vRP._prepare("admin/removertatuagens", "DELETE FROM vrp_user_data WHERE user_id = @user_id AND dkey ='vRP:tattoos'")

-----------------------------------------------------------------------------------------------------------------------------------------
-- LOG DE ECONOMIA ENVIADA PARA O DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------

vRP._prepare("vRP/money_rank", "SELECT SUM(wallet+bank) AS total,user_id FROM vrp.vrp_user_moneys GROUP BY user_id ORDER BY total DESC LIMIT 50")

vRP._prepare("vRP/total_economia", "SELECT SUM(wallet+bank) AS economia FROM vrp.vrp_user_moneys")

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60 * 60000)
        local source = source
        local carteira = vRP.query("vRP/money_rank")
        local economia = vRP.query("vRP/total_economia")
        local msg = ""
        for k, v in pairs(carteira) do
            msg = msg .. "ID: " .. v.user_id .. " => Total: R$ " .. vRP.format(parseInt(v.total)) .. "\n"
        end
        vRP.Log("```prolog\nRELATORIO DE ECONOMIA: " .. os.date("%d/%m/%Y - %H:%M:%S") .. "``` ```prolog\n" .. msg .. "```", "ECONOMIA")
        economiatotal = ""
        for k, v in pairs(economia) do
            economiatotal = economiatotal .. "Economia atual: R$ " .. vRP.format(parseInt(v.economia)) .. "\n"
        end
        vRP.Log("```prolog\n" .. economiatotal .. "```", "ECONOMIA")
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /DV POR ÁREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('dvall', function(a, b)
    user_id = vRP.getUserId(a)
    if vRP.hasPermission(user_id, 'dv.permissao') then
        if tonumber(b[1]) then
            local vehicles = vRPclient.getNearestVehicles(a, tonumber(b[1]))
            for k, v in pairs(vehicles) do
                TriggerClientEvent('deleteVeh', a, k)
            end
            TriggerClientEvent('Notify', a, 'sucesso', '<b>Você deletou ' .. tablelen(vehicles) .. 'x veículos')
        else
            TriggerClientEvent('Notify', a, 'negado', 'Comando dado de forma incorreta, use a estrutura /dvall [raio]')
        end
    else
        TriggerClientEvent('Notify', a, 'negado', 'Sem permissão!')
    end
end)

function tablelen(table)
    num = 0
    for k, v in pairs(table) do
        num = num + 1
    end
    return num
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pon', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "kick.permissao") then
        local users = vRP.getUsers()
        local players = ""
        local quantidade = 20
        for k, v in pairs(users) do
            if k ~= #users then
                players = players .. ", "
            end
            players = players .. k
            quantidade = quantidade + 1
        end
        -- TriggerClientEvent('chatMessage',source,"TOTAL ONLINE",{0,191,255},quantidade)
        TriggerClientEvent('chatMessage', source, "ID's ONLINE", {0, 191, 255}, players)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /KILL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('kill', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "kick.permissao") then
        if args[1] == "1" then
            TriggerClientEvent("Notify", source, "negado", "Você não pode matar o mais gostoso de todos!!!")
            return
        end
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                vRPclient.killGod(nplayer)
                vRPclient.setHealth(nplayer, 0)
            end
        else
            vRPclient.killGod(source)
            vRPclient.setHealth(source, 0)
            vRPclient.setArmour(source, 0)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DM (MENSAGEM PRIVADA)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('dm', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRP.getUserSource(parseInt(args[1]))
    if vRP.hasPermission(user_id, "kick.permissao") then
        if args[1] == nil then
            TriggerClientEvent("Notify", source, "negado", "Necessário passar o ID após o comando, exemplo: <b>/dm 1</b>")
            return
        elseif nplayer == nil then
            TriggerClientEvent("Notify", source, "negado", "O jogador não está online!")
            return
        end
        local mensagem = vRP.prompt(source, "Digite a mensagem:", "")
        if mensagem == "" then
            return
        end
        TriggerClientEvent("Notify", source, "sucesso", "Mensagem enviada com sucesso!")
        TriggerClientEvent('chatMessage', nplayer, "MENSAGEM DA ADMINISTRAÇÃO:", {50, 205, 50}, mensagem)
        TriggerClientEvent("Notify", nplayer, "aviso", "<b>Mensagem da Administração:</b> " .. mensagem .. "", 30000)
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('debug', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local player = vRP.getUserSource(user_id)
        if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "founder.permissao") then
            TriggerClientEvent("ToggleDebug", player)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEVEH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteveh541654654")
AddEventHandler("trydeleteveh541654654", function(index)
    TriggerClientEvent("syncdeleteveh", -1, index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEPED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteped")
AddEventHandler("trydeleteped", function(index)
    TriggerClientEvent("syncdeleteped", -1, index)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAR INVENTARIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('limparinv', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "mod.permissao") or vRP.hasPermission(user_id, "founder.permissao") then
        vRP.clearInventory(user_id)
        TriggerClientEvent("Notify", source, "importante", "Seu <b>inventario</b> foi limpo.")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVIVER TODOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteped")
RegisterCommand('reviveall', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "founder.permissao") then
        local rusers = vRP.getUsers()
        for k, v in pairs(rusers) do
            local rsource = vRP.getUserSource(k)
            vRPclient.setHealth(rsource, 400)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUXAR TODOS
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand('tpall', function(source, args, rawCommand)
--     local user_id = vRP.getUserId(source)
--     local x,y,z = vRPclient.getPosition(source)
--     if vRP.hasPermission(user_id,"founder.permissao") then
--         local rusers = vRP.getUsers()
--         for k,v in pairs(rusers) do
--             local rsource = vRP.getUserSource(k)
--             if rsource ~= source then
--                 vRPclient.teleport(rsource,x,y,z)
--             end
--         end
--     end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEOBJ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteobj")
AddEventHandler("trydeleteobj", function(index)
    TriggerClientEvent("syncdeleteobj", -1, index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('fix', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "fix.permissao") then
        local vehicle = vRPclient.getNearestVehicle(source, 7)
        if vehicle then
            TriggerClientEvent('reparar2', source, vehicle)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('limparea', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local x, y, z = vRPclient.getPosition(source)
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "mod.permissao") or vRP.hasPermission(user_id, "founder.permissao") then
        TriggerClientEvent("syncarea", -1, x, y, z)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('god', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRP.getUserSource(parseInt(args[1]))
    local identity = vRP.getUserIdentity(user_id)
    local crds = GetEntityCoords(GetPlayerPed(source))
    if vRP.hasPermission(user_id, "god.permissao") then
        if args[1] then
            if nplayer then
                local raio = vRPclient.getNearestPlayers(nplayer, 50)
                for k, v in pairs(raio) do
                    vADMC._showGodHeart(k, nplayer)
                end
                vADMC._showGodHeart(nplayer, nplayer)
                local nuser_id = vRP.getUserId(nplayer)
                local identitynu = vRP.getUserIdentity(nuser_id)

                vRPclient.killGod(nplayer)
                vRPclient._stopAnim(nplayer, false)
                vRPclient.setHealth(nplayer, 400)
                TriggerEvent("srkfive:killregisterclear", nuser_id)
                vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[GOD EM]: " .. nuser_id .. " " .. identitynu.name .. " " .. identitynu.firstname .. "\n[COORDENADA]: " .. crds.x .. "," .. crds.y .. "," .. crds.z .. "" .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "CMD_GOD")
            end
        else
            local raio = vRPclient.getNearestPlayers(source, 30)
            for k, v in pairs(raio) do
                vADMC._showGodHeart(k, source)
            end
            vADMC._showGodHeart(source, source)
            vRPclient._stopAnim(source, false)
            vRPclient.killGod(source)
            vRPclient.setHealth(source, 400) -- Vida
            -- vRPclient.setArmour(source,100) -- Colete
            TriggerEvent("srkfive:killregisterclear", user_id)
            vRP.Log("```prolog\n[GOD PROPRIO]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. "\n[COORDENADA]: " .. crds.x .. "," .. crds.y .. "," .. crds.z .. "" .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "CMD_GOD")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD ALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('godall', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "founder.permissao") then
        local users = vRP.getUsers()
        for k, v in pairs(users) do
            local id = vRP.getUserSource(parseInt(k))
            if id then
                vRPclient.killGod(nplayer)
                vRPclient._stopAnim(nplayer, false)
                vRPclient.setHealth(nplayer, 400)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ESTOQUE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('estoque', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "founder.permissao") then
        if args[1] and args[2] then
            vRP.execute("creative/set_estoque", {vehicle = args[1], quantidade = args[2]})
            TriggerClientEvent("Notify", source, "sucesso", "Voce colocou mais <b>" .. args[2] .. "</b> no estoque, para o carro <b>" .. args[1] .. "</b>.")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addcar', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRP.getUserSource(parseInt(args[2]))
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "founder.permissao") then
        if args[1] and args[2] then
            if vRPclient.vehicleExist(source, args[1]) then
                local nuser_id = vRP.getUserId(nplayer)
                local identity = vRP.getUserIdentity(user_id)
                local identitynu = vRP.getUserIdentity(nuser_id)
                vRP.execute("creative/add_vehicle", {user_id = parseInt(args[2]), vehicle = args[1], ipva = parseInt(os.time())})
                vRP.execute("creative/set_ipva", {user_id = parseInt(args[2]), vehicle = args[1], ipva = parseInt(os.time())})
                TriggerClientEvent("Notify", source, "sucesso", "Voce adicionou o veículo <b>" .. args[1] .. "</b> para o Passaporte: <b>" .. parseInt(args[2]) .. "</b>.")
                vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[ADICIONOU]: " .. args[1] .. " \n[PARA O ID]: " .. nuser_id .. " " .. identitynu.name .. " " .. identitynu.firstname .. " " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "CMD_ADDCAR")
            else
                TriggerClientEvent("Notify", source, "negado", "Nome incorreto para o veículo.")
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REM CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('remcar', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRP.getUserSource(parseInt(args[2]))
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "founder.permissao") then
        if args[1] and args[2] then
            local nuser_id = vRP.getUserId(nplayer)
            local identity = vRP.getUserIdentity(user_id)
            local identitynu = vRP.getUserIdentity(nuser_id)
            vRP.execute("creative/rem_vehicle", {user_id = parseInt(args[2]), vehicle = args[1], ipva = parseInt(os.time())})
            TriggerClientEvent("Notify", source, "sucesso", "Voce removeu o veículo <b>" .. args[1] .. "</b> do Passaporte: <b>" .. parseInt(args[2]) .. "</b>.")
            vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[REMOVEU]: " .. args[1] .. " \n[PARA O ID]: " .. nuser_id .. " " .. identitynu.name .. " " .. identitynu.firstname .. " " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "CMD_ADDCAR")
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand('hash',function(source,args,rawCommand)
--	local user_id = vRP.getUserId(source)
--	if vRP.hasPermission(user_id,"admin.permissao") then
--		local vehicle = vRPclient.getNearestVehicle(source,7)
--		if vehicle then
--			TriggerClientEvent('vehash',source,vehicle)
--		end
--	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tuning', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "founder.permissao") then
        local vehicle = vRPclient.getNearestVehicle(source, 7)
        if vehicle then
            TriggerClientEvent('vehtuning', source, vehicle)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('wl', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "wl.permissao") then
        if args[1] then
            vRP.setWhitelisted(parseInt(args[1]), true)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNWL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('unwl', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "wl.permissao") then
        if args[1] then
            vRP.setWhitelisted(parseInt(args[1]), false)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('kick', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "kick.permissao") then
        if args[1] then
            local id = vRP.getUserSource(parseInt(args[1]))
            if id then
                vRP.kick(id, "Você foi kickado da cidade.")
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ban', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "ban.permissao") then
        if args[1] then
            local id = vRP.getUserSource(parseInt(args[1]))
            vRP.setBanned(parseInt(args[1]), true)
            vRP.setWhitelisted(parseInt(args[1]), false)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('unban', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "ban.permissao") then
        if args[1] then
            vRP.setBanned(parseInt(args[1]), false)
            vRP.setWhitelisted(parseInt(args[1]), true)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETAR O PERSONAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('reset', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "kick.permissao") then
            if args[1] then
                local nplayer = vRP.getUserSource(parseInt(args[1]))
                local id = vRP.getUserId(nplayer)
                if id then
                    vRP.kick(nplayer, "Aparência resetada, entre novamente!")
                end
                vRP.setUData(args[1], "vRP:spawnController", json.encode(1))
                -- vRP.setUData(args[1],"vRP:currentCharacterMode",json.encode(1))
                -- vRP.setUData(args[1],"vRP:tattoos",json.encode(1))
                vRP.execute("admin/resetarpersonagem", {user_id = parseInt(args[1])})
                vRP.execute("admin/removertatuagens", {user_id = parseInt(args[1])})
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETAR O PERSONAGEM (MÉDICOS)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('plastica', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "samuiv.permissao") or vRP.hasPermission(user_id, "samuiii.permissao") then
            if args[1] then
                local nplayer = vRP.getUserSource(parseInt(args[1]))
                local id = vRP.getUserId(nplayer)
                if id then
                    if vRP.request(source, "Deseja pagar <b>R$ 400.000</b> pelo tratamento?", 15) then
                        if vRP.tryFullPayment(user_id, parseInt(400000)) then
                            vRP.kick(nplayer, "Aparência resetada, entre novamente!")
                            vRP.setUData(id, "vRP:spawnController", json.encode(1))
                            -- vRP.setUData(id,"vRP:currentCharacterMode",json.encode(1))
                            -- vRP.setUData(id,"vRP:tattoos",json.encode(1))
                            vRP.execute("admin/resetarpersonagem", {user_id = parseInt(args[1])})
                            vRP.execute("admin/removertatuagens", {user_id = parseInt(args[1])})
                            return true
                        else
                            TriggerClientEvent("Notify", source, "negado", "Voce não possui dinheiro suficiente")
                        end
                    end
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MONEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('money', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, "founder.permissao") then
        if args[1] then
            vRP.giveMoney(user_id, parseInt(args[1]))
            vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[FEZ]: R$ " .. vRP.format(parseInt(args[1])) .. " " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "CMD_MONEY")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RETIRAR DINHEIRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('getmoney', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, "founder.permissao") then
        if args[1] then
            -- local bankMoney = vRP.getBankMoney(user_id)
            vRP.tryPayment(user_id, parseInt(args[1]))
            -- vRP.setBankMoney(user_id, bankMoney-parseInt(args[1]))
            vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[DESTRUIU]: R$ " .. vRP.format(parseInt(args[1])) .. " " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "CMD_MONEY")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('nc', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "noclip.permissao") then
        vRPclient.toggleNoclip(source)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpcds', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "tp.permissao") then
        local fcoords = vRP.prompt(source, "Cordenadas:", "")
        if fcoords == "" then
            return
        end
        local coords = {}
        for coord in string.gmatch(fcoords or "0,0,0", "[^,]+") do
            table.insert(coords, parseInt(coord))
        end
        vRPclient.teleport(source, coords[1] or 0, coords[2] or 0, coords[3] or 0)
    end
end)

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- --[ COORDENADAS ]------------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand('cds',function(source,args,rawCommand)
--     local user_id = vRP.getUserId(source)
--     if vRP.hasPermission(user_id,"admin.permissao") then
--         local x,y,z = vRPclient.getPosition(source)
--         heading = GetEntityHeading(GetPlayerPed(-1))
--         vRP.prompt(source,"Cordenadas:","['x'] = "..tD(x)..", ['y'] = "..tD(y)..", ['z'] = "..tD(z))
--     end
-- end)

-- RegisterCommand('cds2',function(source,args,rawCommand)
--     local user_id = vRP.getUserId(source)
--     if vRP.hasPermission(user_id,"admin.permissao")  then
--         local x,y,z = vRPclient.getPosition(source)
--         vRP.prompt(source,"Cordenadas:",tD(x)..","..tD(y)..","..tD(z))
--     end
-- end)

-- RegisterCommand('cds3',function(source,args,rawCommand)
--     local user_id = vRP.getUserId(source)
--     if vRP.hasPermission(user_id,"admin.permissao")  then
--         local x,y,z = vRPclient.getPosition(source)
--         vRP.prompt(source,"Cordenadas:","{x="..tD(x)..", y="..tD(y)..", z="..tD(z).."},")
--     end
-- end)

-- function tD(n)
--     n = math.ceil(n * 100) / 100
--     return n
-- end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('group', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, "group.permissao") then
        if args[1] and args[2] then
            if user_id > 1 and args[2] == "founder" then
                TriggerClientEvent("Notify", source, "negado", "Voce não pode setar no grupo <b>" .. args[2] .. "</b>")
            else
                vRP.addUserGroup(parseInt(args[1]), args[2])
                TriggerClientEvent("Notify", source, "sucesso", "Voce setou o passaporte <b>" .. parseInt(args[1]) .. "</b> no grupo <b>" .. args[2] .. "</b>")
                vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[SETOU]: " .. args[1] .. " \n[GRUPO]: " .. args[2] .. " " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "CMD_GROUP")
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ungroup', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, "group.permissao") then
        if args[1] and args[2] then
            vRP.removeUserGroup(parseInt(args[1]), args[2])
            TriggerClientEvent("Notify", source, "sucesso", "Voce removeu o passaporte <b>" .. parseInt(args[1]) .. "</b> do grupo <b>" .. args[2] .. "</b>.")
            vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[REMOVEU]: " .. args[1] .. " \n[GRUPO]: " .. args[2] .. " " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "CMD_GROUP")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tptome', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "tp.permissao") then
        if args[1] then
            local tplayer = vRP.getUserSource(parseInt(args[1]))
            local x, y, z = vRPclient.getPosition(source)
            if tplayer then
                vRPclient.teleport(tplayer, x, y, z)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpto', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "tp.permissao") then
        if args[1] then
            local tplayer = vRP.getUserSource(parseInt(args[1]))
            if tplayer then
                vRPclient.teleport(source, vRPclient.getPosition(tplayer))
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpway', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "tp.permissao") then
        TriggerClientEvent('tptoway', source)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('car', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local crds = GetEntityCoords(GetPlayerPed(source))
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "founder.permissao") then
        if args[1] then
            TriggerClientEvent('spawnarveiculo654687687', source, args[1])
            vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[SPAWNOU]: " .. (args[1]) .. "\n[COORDENADA]: " .. crds.x .. "," .. crds.y .. "," .. crds.z .. "" .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "CMD_CAR")
        end
    end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TROCAR SEXO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('skin', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "founder.permissao") or vRP.hasPermission(user_id, "admin.permissao") then
        if parseInt(args[1]) then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                TriggerClientEvent("skinmenu", nplayer, args[2])
                TriggerClientEvent("Notify", source, "sucesso", "Voce setou a skin <b>" .. args[2] .. "</b> no passaporte <b>" .. parseInt(args[1]) .. "</b>.")
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELNPCS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('delnpcs', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "kick.permissao") then
        TriggerClientEvent('delnpcs', source)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('adm', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "anuncio.permissao") or vRP.hasPermission(user_id, "founder.permissao") then
        local identity = vRP.getUserIdentity(user_id)
        local mensagem = vRP.prompt(source, "Mensagem:", "")
        if mensagem == "" then
            return
        end
        vRPclient.setDiv(-1, "anuncio", ".div_anuncio { background: rgba(255,0,0,0.8); font-size: 11px; font-family: arial; color: #fff; padding: 20px; bottom: 50%; right: 20px; max-width: 600px; position: absolute; -webkit-border-radius: 5px; } bold { font-size: 15px; }", "<bold>" .. mensagem .. "</bold><br><br>Mensagem enviada por: Prefeitura")
        SetTimeout(60000, function()
            vRPclient.removeDiv(-1, "anuncio")
        end)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- Ver roupas
-----------------------------------------------------------------------------------------------------------------------------------------
-- local player_customs = {}

-- RegisterCommand('vroupas',function(source,args,rawCommand)
--     local custom = vRPclient.getCustomization(source)
--     if player_customs[source] then -- hide
--       player_customs[source] = nil
--       vRPclient._removeDiv(source,"customization")
--     else -- show
--       local content = ""
--     for k,v in pairs(custom) do
-- 		content = content..k.." = "..json.encode(v)
--       end
--         player_customs[source] = true
-- 	--   vRPclient._setDiv(source,"customization",".div_customization{ margin: auto; padding: 8px; width: 500px; margin-top: 80px; background: black; color: white; font-weight: bold; ", content)
-- 	vRP.prompt(source, "Montagem de Preset", content)
--  end
-- end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /VROUPAS (JÁ NO FORMATO CORRETO)
-----------------------------------------------------------------------------------------------------------------------------------------
local player_customs = {}
function IsNumber(numero)
    return tonumber(numero) ~= nil
end

RegisterCommand('vroupas', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local custom = vRPclient.getCustomization(source)
    -- if vRP.hasPermission(user_id,"admin.permissao") then
    if player_customs[source] then
        player_customs[source] = nil
        vRPclient._removeDiv(source, "customization")
    else
        local content = ""
        for k, v in pairs(custom) do
            if (IsNumber(k) and k <= 11) or k == "p0" or k == "p1" or k == "p2" or k == "p6" or k == "p7" then
                if IsNumber(k) then
                    content = content .. '[' .. k .. '] = {'
                else
                    content = content .. '["' .. k .. '"] = {'
                end
                local contador = 1
                for y, x in pairs(v) do
                    if contador < #v then
                        content = content .. x .. ','
                    else
                        content = content .. x
                    end
                    contador = contador + 1
                end
                content = content .. "},\n"
            end
        end
        player_customs[source] = true
        vRPclient.prompt(source, 'vRoupas: ', content)
    end
    -- end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PEGAR IP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pegarip', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local tplayer = vRP.getUserSource(parseInt(args[1]))
    if vRP.hasPermission(user_id, "founder.permissao") then
        if args[1] and tplayer then
            TriggerClientEvent('chatMessage', source, "^1IP do Usuário: " .. GetPlayerEndpoint(tplayer))
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT INTERNO DA STAFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('s', function(source, args, rawCommand)
    if args[1] then
        local user_id = vRP.getUserId(source)
        local identity = vRP.getUserIdentity(user_id)
        local permission = "staff.permissao"
        if vRP.hasPermission(user_id, "staff.permissao") then
            local staff = vRP.getUsersByPermission(permission)
            for l, w in pairs(staff) do
                local player = vRP.getUserSource(parseInt(w))
                if player then
                    async(function()
                        TriggerClientEvent('chatMessage', player, identity.name .. " " .. identity.firstname .. " [" .. user_id .. "]: ", {255, 215, 0}, rawCommand:sub(3))
                    end)
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT INTERNO DO HOSPITAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('hp', function(source, args, rawCommand)
    if args[1] then
        local user_id = vRP.getUserId(source)
        local identity = vRP.getUserIdentity(user_id)
        local permission = "paramedico.permissao"
        if vRP.hasPermission(user_id, "paramedico.permissao") then
            local hospital = vRP.getUsersByPermission(permission)
            for l, w in pairs(hospital) do
                local player = vRP.getUserSource(parseInt(w))
                if player then
                    async(function()
                        TriggerClientEvent('chatMessage', player, identity.name .. " " .. identity.firstname .. " [" .. user_id .. "]: ", {255, 0, 0}, rawCommand:sub(3))
                    end)
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RETIRAR ALGEMA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('algema', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "admin.permissao") or vRP.hasPermission(user_id, "founder.permissao") or vRP.hasPermission(user_id, "mod.permissao") or vRP.hasPermission(user_id, "helper.permissao") then
            TriggerClientEvent("admcuff", source)
            TriggerClientEvent("Notify", source, "sucesso", "Você foi <b>desalgemado</b> com sucesso.")
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CORREÇÃO DE SPAWNAR ARMA
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookspawnarma = "https://discord.com/api/webhooks/800186893186236416/xi0jk6NfSDR3lWLBF2FfgX6VVxkNWELBcXKEClJv3HvHPa0ziMlrsn2ehvAHi31iiWoQ"

RegisterServerEvent('LOG:ARMAS654654684')
AddEventHandler('LOG:ARMAS654654684', function()
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        vRP.setBanned(parseInt(user_id), true)
        vRP.setWhitelisted(parseInt(user_id), false)
        vRP.kick(user_id, "Você foi banido da cidade.")
        local adms = vRP.getUsersByPermission("ban.permissao")
        for k, v in pairs(adms) do
            admin_source = vRP.getUserSource(parseInt(v))
            TriggerClientEvent("Notify", admin_source, "aviso", "Jogador Suspeito: <b>" .. user_id .. "</b> - Motivo: SPAWN DE ARMAS", 15000)
        end
        PerformHttpRequest(webhookspawnarma, function(err, text, headers)
        end, 'POST', json.encode({content = "[BANIDO] SPAWN DE ARMAS " .. user_id}), {['Content-Type'] = 'application/json'})
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKAR PLAYERS SEM ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('kickbugados', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "kick.permissao") then
        TriggerClientEvent('MQCU:bugado', -1)
    end
end)

RegisterServerEvent("MQCU:bugado")
AddEventHandler("MQCU:bugado", function()
    local user_id = vRP.getUserId(source)
    if user_id == nil then
        local identifiers = GetPlayerIdentifiers(source)
        DropPlayer(source, "Você foi kikado da cidade!")
        identifiers = json.decode(identifiers)
        print("Player bugado encontrado: " .. identifiers)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
local presets = {
    ["staff"] = {
        [1885233650] = {
            [3] = {0, 0, 1},
            [4] = {87, 11, 1},
            [5] = {0,0,1},
            [6] = {9, 12, 1},
            [8] = {15, 0, 2},
            [11] = {208, 18, 1},
            ["p0"] = {-1, 0}
        },
        [-1667301416] = {
            [3] = {14, 0, 1}, 
            [4] = {90, 15, 1}, 
            [5] = {0,0,1},
            [6] = {74, 0, 1}, 
            [8] = {15, 0, 2}, 
            [11] = {224, 0, 1}, 
            ["p0"] = {-1, 0}
        }
    },
    ["porcao"] = {
        [1885233650] = {
        [1] = {5, 0, 2},
        [3] = {0, 0, 1},
        [4] = {87, 11, 1},
        [5] = {0,0,1},
        [6] = {9, 12, 1},
        [8] = {15, 0, 2},
        [11] = {208, 18, 1},
        ["p0"] = {-1, 0}
        }
    },
    ["mike"] = {
        [1885233650] = {
        [1] = {3,0,2},
        [2] = {16,0,0},
        [3] = {146,0,2},
        [4] = {87,11,1},
        [5] = {0,0,1},
        [6] = {9,12,1},
        [7] = {112,2,2},
        [8] = {10,2,2},
        [9] = {0,0,1},
        [10] = {-1,0,0},
        [11] = {208,18,1},
        [0] = {0,0,0},
        ["p7"] = {-1,0},
        ["p6"] = {2,0},
        ["p2"] = {7,0},
        ["p1"] = {-1,0},
        ["p0"] = {-1,0},
        }
    },
    ["coruja"] = {
        [1885233650] = {
        [1] = {19,1,2},
        [2] = {57,0,0},
        [3] = {146,0,2},
        [4] = {87,11,1},
        [5] = {-1,0,2},
        [6] = {9,12,2},
        [7] = {112,2,1},
        [8] = {14,5,2},
        [9] = {0,0,1},
        [10] = {-1,0,2},
        [11] = {208,18,1},
        ["p7"] = {-1,0},
        ["p6"] = {-1,0},
        ["p1"] = {-1,0},
        ["p0"] = {-1,0},
        [0] = {0,0,0},
        ["p2"] = {4,0},
        }
    },
    ["casamento"] = {
        [1885233650] = {
        [1] = {0,0,1},
        [2] = {21,0,0},
        [3] = {4,0,1},
        [4] = {28,0,1},
        [5] = {34,0,1},
        [6] = {9,12,1},
        [7] = {0,0,1},
        [8] = {33,0,1},
        [9] = {0,0,1},
        [10] = {-1,0,2},
        [11] = {294,0,1},
        ["p2"] = {-1,0},
        ["p1"] = {7,0},
        ["p7"] = {-1,0},
        ["p6"] = {22,0},
        [0] = {0,0,0},
        ["p0"] = {8,0},
        }
    },
    ["day"] = {
        [-1667301416] = {
        [1] = {21,0,1},
        [2] = {75,0,0},
        [3] = {14,0,1},
        [4] = {90,15,1},
        [5] = {0,0,1},
        [6] = {74,0,1},
        [7] = {5,6,1},
        [8] = {15,0,2},
        [9] = {-1,0,0},
        [10] = {-1,0,0},
        [11] = {224,0,1},
        [0] = {0,0,0},
        ["p2"] = {15,0},
        ["p1"] = {12,0},
        ["p0"] = {-1,0},
        ["p6"] = {-1,0},
        ["p7"] = {-1,0},
        }
    },
    ["dudu"] = {[1885233650] = {[1] = {20, 0, 1}, [2] = {14, 0, 0}, [3] = {138, 1, 1}, [4] = {87, 11, 1}, [5] = {0, 0, 1}, [6] = {9, 3, 1}, [7] = {149, 1, 1}, [8] = {14, 0, 1}, [9] = {-1, 0, 0}, [10] = {-1, 0, 0}, [11] = {208, 18, 1}, ["p7"] = {8, 1}, ["p6"] = {40, 1}, ["p2"] = {-1, 0}, ["p1"] = {-1, 0}, [0] = {0, 0, 0}, ["p0"] = {-1, 0}}},
    ["wally"] = {[1885233650] = {[1] = {26, 1, 2}, [3] = {52, 0, 2}, [4] = {87, 11, 1}, [6] = {6, 6, 2}, [8] = {15, 0, 2}, [11] = {208, 18, 1}, ["p0"] = {-1, 0}}},
    ["berti"] = {[1885233650] = {[1] = {100, 1, 2}, [2] = {57, 0, 0}, [3] = {138, 1, 2}, [4] = {87, 11, 1}, [5] = {0, 0, 1}, [6] = {9, 12, 1}, [7] = {2, 0, 2}, [8] = {15, 0, 2}, [9] = {0, 0, 1}, [10] = {-1, 0, 2}, [11] = {208, 18, 1}, [0] = {0, 0, 0}, ["p1"] = {-1, 0}, ["p2"] = {-1, 0}, ["p7"] = {-1, 0}, ["p6"] = {-1, 0}, ["p0"] = {-1, 0}}},
    ["inguica"] = {[1885233650] = {[1] = {169, 14, 2}, [2] = {21, 0, 0}, [3] = {146, 1, 2}, [4] = {78, 6, 2}, [5] = {29, 12, 1}, [6] = {9, 3, 1}, [7] = {0, 0, 2}, [8] = {15, 0, 2}, [9] = {0, 0, 1}, [10] = {-1, 0, 2}, [11] = {10, 4, 2}, ["p1"] = {11, 3}, ["p2"] = {-1, 0}, [0] = {0, 0, 0}, ["p0"] = {130, 0}, ["p6"] = {-1, 0}, ["p7"] = {-1, 0}}},
    ["kappa"] = {[1885233650] = {[1] = {87, 0, 1}, [2] = {21, 0, 0}, [3] = {138, 1, 1}, [4] = {87, 11, 1}, [5] = {0, 0, 0}, [6] = {7, 5, 1}, [7] = {1, 0, 1}, [8] = {15, 0, 1}, [9] = {0, 0, 1}, [10] = {0, 0, 0}, [11] = {208, 18, 1}, [0] = {0, 0, 0}, ["p2"] = {-1, 0}, ["p0"] = {-1, 0}, ["p6"] = {-1, 0}, ["p7"] = {-1, 0}, ["p1"] = {15, 1}}},
    ["jhon"] = {
        [1885233650] = {
            [1] = {9,0,2},
            [2] = {21,0,0},
            [3] = {146,1,2},
            [4] = {87,11,1},
            [5] = {-1,0,2},
            [6] = {9,12,2},
            [7] = {30,0,2},
            [8] = {14,4,2},
            [9] = {0,0,1},
            [10] = {-1,0,2},
            [11] = {208,18,1},
            ["p2"] = {4,0},
            ["p1"] = {-1,0},
            ["p0"] = {-1,0},
            ["p6"] = {-1,0},
            ["p7"] = {-1,0},
            [0] = {0,0,0},
        }
    },
    ["chloe"] = {[-1667301416] = {[1] = {18, 0, 2}, [2] = {15, 0, 0}, [3] = {14, 0, 2}, [4] = {90, 15, 2}, [5] = {0, 0, 0}, [6] = {74, 0, 1}, [7] = {15, 5, 2}, [8] = {6, 0, 2}, [9] = {0, 0, 0}, [10] = {0, 0, 0}, [11] = {224, 0, 2}, [0] = {0, 0, 0}, ["p0"] = {-1, 0}, ["p2"] = {-1, 0}, ["p1"] = {-1, 0}, ["p7"] = {-1, 0}, ["p6"] = {-1, 0}}},
    ["seitaf"] = { -- Seita Feminino
        [-1667301416] = {[1] = {37, 0, 1}, [2] = {74, 0, 0}, [3] = {5, 0, 1}, [4] = {112, 0, 2}, [5] = {-1, 0, 2}, [6] = {25, 0, 1}, [7] = {-1, 0, 2}, [8] = {6, 0, 2}, [9] = {-1, 0, 2}, [10] = {-1, 0, 2}, [11] = {206, 0, 1}, [0] = {0, 0, 0}, ["p2"] = {-1, 0}, ["p1"] = {-1, 0}, ["p6"] = {-1, 0}, ["p7"] = {-1, 0}, ["p0"] = {-1, 0}},
    },
    ["seita"] = { -- Seita Masculino
        [1885233650] = {[1] = {11, 2, 1}, [2] = {57, 0, 0}, [3] = {35, 0, 1}, [4] = {33, 0, 1}, [5] = {-1, 0, 2}, [6] = {50, 0, 1}, [7] = {-1, 0, 2}, [8] = {15, 0, 2}, [9] = {0, 0, 0}, [10] = {-1, 0, 2}, [11] = {204, 0, 1}, [0] = {0, 0, 0}, ["p1"] = {-1, 0}, ["p6"] = {-1, 0}, ["p0"] = {2, 0}, ["p7"] = {-1, 0}, ["p2"] = {-1, 0}},
    },
}

RegisterCommand('preset', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "staff.permissao") then
        if args[1] then
            local custom = presets[tostring(args[1])]
            if custom then
                local old_custom = vRPclient.getCustomization(source)
                local idle_copy = {}

                idle_copy = vRP.save_idle_custom(source, old_custom)
                idle_copy.modelhash = nil

                for l, w in pairs(custom[old_custom.modelhash]) do
                    idle_copy[l] = w
                end
                vRPclient._setCustomization(source, idle_copy)
                Citizen.Wait(1000)
                TriggerClientEvent("reloadtattos", source)
            end
        else
            vRP.removeCloak(source)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- REVISTAR DE LONGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rev', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer
    if args[1] then
        nplayer = vRP.getUserSource(tonumber(args[1]))
    else
        nplayer = vRPclient.getNearestPlayer(source, 2)
    end
    local nuser_id = vRP.getUserId(nplayer)
    if nuser_id then
        local identity = vRP.getUserIdentity(user_id)
        local weapons = vRPclient.getWeapons(nplayer)
        local money = vRP.getMoney(nuser_id)
        local data = vRP.getUserDataTable(nuser_id)
        local banco = vRP.getBankMoney(nuser_id)

        if vRP.hasPermission(user_id, "kick.permissao") then
            TriggerClientEvent('chatMessage', source, "", {}, "^4- -  ^5M O C H I L A^4  - - - - - - - - - - - - - - - - - - - - - - - - - - -  [  ^3" .. string.format("%.2f", vRP.getInventoryWeight(nuser_id)) .. "kg^4  /  ^3" .. string.format("%.2f", vRP.getInventoryMaxWeight(nuser_id)) .. "kg^4  ]  - -")
            if data and data.inventory then
                for k, v in pairs(data.inventory) do
                    TriggerClientEvent('chatMessage', source, "", {}, "     " .. vRP.format(parseInt(v.amount)) .. "x " .. vRP.itemNameList(k))
                end
            end
            TriggerClientEvent('chatMessage', source, "", {}, "^4- -  ^5E Q U I P A D O^4  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
            for k, v in pairs(weapons) do
                if v.ammo < 1 then
                    TriggerClientEvent('chatMessage', source, "", {}, "     1x " .. vRP.itemNameList("wbody|" .. k))
                else
                    TriggerClientEvent('chatMessage', source, "", {}, "     1x " .. vRP.itemNameList("wbody|" .. k) .. " | " .. vRP.format(parseInt(v.ammo)) .. "x Munições")
                end
            end
            TriggerClientEvent('chatMessage', source, "", {}, "    Carteira: R$ " .. vRP.format(parseInt(money)) .. "")
            TriggerClientEvent('chatMessage', source, "", {}, "    Banco: R$ " .. vRP.format(parseInt(banco)) .. "")
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ANUNCIO PROMOTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('evento', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "promoter.permissao") then
        local identity = vRP.getUserIdentity(user_id)
        local mensagem = vRP.prompt(source, "Mensagem:", "")
        if mensagem == "" then
            return
        end
        vRPclient.setDiv(-1, "anuncio", ".div_anuncio { background: rgba(255,128,169,0.8); font-size: 11px; font-family: arial; color: #fff; padding: 20px; bottom: 50%; right: 20px; max-width: 600px; position: absolute; -webkit-border-radius: 5px; } bold { font-size: 15px; }", "<bold>" .. mensagem .. "</bold><br><br>Mensagem enviada por: Promotor(a) de Eventos")
        SetTimeout(60000, function()
            vRPclient.removeDiv(-1, "anuncio")
        end)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKAR JOGADORES QUE USAM A VERSÃO CANARY E NASCEM BUGADOS (BUG DO FIVEM)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('Bugado')
AddEventHandler('Bugado', function()
    DropPlayer(source, "[MQCU]  VOCÊ ESTÁ BUGADO, DESATIVE A OPÇÃO CANARY PARA DESBUGAR")
end)

--------------------------------------------------------------------------------------------------------------
-- /me 
--------------------------------------------------------------------------------------------------------------
RegisterServerEvent('ChatMe')
AddEventHandler('ChatMe', function(text)
    local user_id = vRP.getUserId(source)
    if user_id then
        TriggerClientEvent('DisplayMe', -1, text, source)
    end
end)

--------------------------------------------------------------------------------------------------------------
-- FIX DE SAIR ARMADO DA ARENA PVP DE FUZIL
--------------------------------------------------------------------------------------------------------------
function crz.WhatDimension()
    return GetPlayerRoutingBucket(source)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- Saquear
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('saquear', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRPclient.getNearestPlayer(source, 2)
    if GetPlayerRoutingBucket(source) == 0 then
        if nplayer then
            if vRPclient.isInComa(nplayer) then
                local identity_user = vRP.getUserIdentity(user_id)
                local nuser_id = vRP.getUserId(nplayer)
                local nidentity = vRP.getUserIdentity(nuser_id)
                local policia = vRP.getUsersByPermission("pmesp.permissao")
                local itens_saque = {}
                if #policia >= 0 then
                    local vida = vRPclient.getHealth(nplayer)
                    TriggerClientEvent('cancelando', source, true)
                    vRPclient._playAnim(source, false, {{"amb@medic@standing@kneel@idle_a", "idle_a"}}, true)
                    TriggerClientEvent("progress", source, 20000, "saqueando")
                    SetTimeout(20000, function()
                        local ndata = vRP.getUserDataTable(nuser_id)
                        if ndata ~= nil then
                            if ndata.inventory ~= nil then
                                for k, v in pairs(ndata.inventory) do
                                    if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(k) * v.amount <= vRP.getInventoryMaxWeight(user_id) then
                                        if vRP.tryGetInventoryItem(nuser_id, k, v.amount) then
                                            vRP.giveInventoryItem(user_id, k, v.amount)
                                            table.insert(itens_saque, "[ITEM]: " .. vRP.itemNameList(k) .. " [QUANTIDADE]: " .. v.amount)
                                        end
                                    else
                                        TriggerClientEvent("Notify", source, "negado", "Mochila não suporta <b>" .. vRP.format(parseInt(v.amount)) .. "x " .. vRP.itemNameList(k) .. "</b> por causa do peso.")
                                    end
                                end
                            end
                        end
                        local weapons = vRPclient.replaceWeapons(nplayer, {})
                        for k, v in pairs(weapons) do
                            vRP.giveInventoryItem(nuser_id, "wbody|" .. k, 1)
                            if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("wbody|" .. k) <= vRP.getInventoryMaxWeight(user_id) then
                                if vRP.tryGetInventoryItem(nuser_id, "wbody|" .. k, 1) then
                                    vRP.giveInventoryItem(user_id, "wbody|" .. k, 1)
                                    table.insert(itens_saque, "[ITEM]: " .. vRP.itemNameList("wbody|" .. k) .. " [QUANTIDADE]: " .. 1)
                                end
                            else
                                TriggerClientEvent("Notify", source, "negado", "Mochila não suporta <b>1x " .. vRP.itemNameList("wbody|" .. k) .. "</b> por causa do peso.")
                            end
                            if v.ammo > 0 then
                                vRP.giveInventoryItem(nuser_id, "wammo|" .. k, v.ammo)
                                if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("wammo|" .. k) * v.ammo <= vRP.getInventoryMaxWeight(user_id) then
                                    if vRP.tryGetInventoryItem(nuser_id, "wammo|" .. k, v.ammo) then
                                        vRP.giveInventoryItem(user_id, "wammo|" .. k, v.ammo)
                                        table.insert(itens_saque, "[ITEM]: " .. vRP.itemNameList("wammo|" .. k) .. " [QTD]: " .. v.ammo)
                                    end
                                else
                                    TriggerClientEvent("Notify", source, "negado", "Mochila não suporta <b>" .. vRP.format(parseInt(v.ammo)) .. "x " .. vRP.itemNameList("wammo|" .. k) .. "</b> por causa do peso.")
                                end
                            end
                        end
                        local nmoney = vRP.getMoney(nuser_id)
                        if vRP.tryPayment(nuser_id, nmoney) then
                            vRP.giveMoney(user_id, nmoney)
                        end
                        vRPclient.setStandBY(source, parseInt(600))
                        vRPclient._stopAnim(source, false)
                        TriggerClientEvent('cancelando', source, false)
                        local apreendidos = table.concat(itens_saque, "\n")
                        TriggerClientEvent("Notify", source, "importante", "Saque concluido com sucesso.")
                        vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity_user.name .. " " .. identity_user.firstname .. "\n[SAQUEOU]: " .. nuser_id .. " " .. nidentity.name .. " " .. nidentity.firstname .. "\n" .. apreendidos .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "CMD_SAQUEAR")
                    end)
                else
                    TriggerClientEvent("Notify", source, "aviso", "Número insuficiente de policiais no momento.")
                end
            else
                TriggerClientEvent("Notify", source, "negado", "Você só pode saquear quem está em coma.")
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TRENA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('trena', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "kick.permissao") then -- ALTERAR A PERMISSÃO!!!!
            local medir = vRP.prompt(source, "Coordenada:", "")
            if medir == "" then
                return
            end
            local coords = {}
            for coord in string.gmatch(medir or "0,0,0", "[^,]+") do
                table.insert(coords, parseInt(coord))
            end
            local ped = GetPlayerPed(source)
            local loc = GetEntityCoords(ped)
            local cds = vector3(coords[1], coords[2], coords[3])
            local dist = #(loc - cds)
            print(dist) -- Print no console
            TriggerClientEvent("Notify", source, "sucesso", "Distância: <b>" .. dist .. " metros</b>!") -- Alterar caso preferir
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- RG ADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('r', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "kick.permissao") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer == nil then
                TriggerClientEvent("Notify", source, "aviso", "Passaporte <b>" .. vRP.format(args[1]) .. "</b> indisponível no momento.")
                return
            end
            nuser_id = vRP.getUserId(nplayer)
            if nuser_id then
                local value = vRP.getUData(nuser_id, "vRP:multas")
                local valormultas = json.decode(value) or 0
                local identity = vRP.getUserIdentity(nuser_id)
                local carteira = vRP.getMoney(nuser_id)
                local banco = vRP.getBankMoney(nuser_id)
                local job = vRP.getUserGroupByType(nuser_id, "job")
                local boost = vRP.getUserGroupByType(nuser_id, "boost1")
                local promoter = vRP.getUserGroupByType(nuser_id, "promoter")
                local value2 = vRP.getUData(nuser_id, "vRP:prisao")
                local tempoPreso = json.decode(value2) or 0
                local banco = vRP.getBankMoney(nuser_id)
                local seminfo = "-"

                if tempoPreso == -1 or tempoPreso == nil or tempoPreso == 0 then
                    tempoPreso = "-"
                end

                if boost == "Boost" then
                    boost = "Nitro Boost 1"
                elseif boost == "Boost2" then
                    boost = "Nitro Boost 2"
                else
                    boost = "-"
                end

                if promoter == "" or promoter == nil then
                    promoter = "-"
                end

                if vRP.getUserGroupByType(nuser_id, "vip6") == "Diamante" then
                    vip = vRP.getUserGroupByType(nuser_id, "vip6")
                elseif vRP.getUserGroupByType(nuser_id, "vip5") == "Esmeralda" then
                    vip = vRP.getUserGroupByType(nuser_id, "vip5")
                elseif vRP.getUserGroupByType(nuser_id, "vip4") == "Platina" then
                    vip = vRP.getUserGroupByType(nuser_id, "vip4")
                elseif vRP.getUserGroupByType(nuser_id, "vip3") == "Ouro" then
                    vip = vRP.getUserGroupByType(nuser_id, "vip3")
                elseif vRP.getUserGroupByType(nuser_id, "vip2") == "Prata" then
                    vip = vRP.getUserGroupByType(nuser_id, "vip2")
                elseif vRP.getUserGroupByType(nuser_id, "vip1") == "Bronze" then
                    vip = vRP.getUserGroupByType(nuser_id, "vip1")
                else
                    vip = "-"
                end

                vRPclient.setDiv(source, "completerg",
                    ".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 13px; font-family: arial; color: #fff; width: 420px; padding: 20px 20px 5px; bottom: 25%; right: 20px; position: absolute; border: 1px solid rgba(255,255,255,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local2 { width: 200px; padding-bottom: 15px; float: left; } .local b, .local2 b { color: #00BFFF; }",
                    "<div class=\"local\"><b>Nome:</b> " .. identity.name .. " " .. identity.firstname .. " ( " .. vRP.format(identity.user_id) .. " )</div><div class=\"local2\"><b>Identidade:</b> " .. identity.registration .. "</div><div class=\"local\"><b>Idade:</b> " .. identity.age .. " Anos</div><div class=\"local2\"><b>Telefone:</b> " .. identity.phone ..
                        "</div><div class=\"local\"><b>Multas pendentes:</b> R$ " .. vRP.format(parseInt(valormultas)) .. "</div><div class=\"local2\"><b>Carteira:</b> R$ " .. vRP.format(parseInt(carteira)) .. "</div> <div class=\"local\"><b>Promoter: </b> " .. promoter .. "</div> <div class=\"local2\"><b>Banco:</b> R$ " .. vRP.format(parseInt(banco)) ..
                        "</div> <div class=\"local\"><b>Setagem:</b> " .. job .. "</div></div><div class=\"local2\"><b>Prisão:</b> " .. tempoPreso .. "</div></div> <div class=\"local\"><b>VIP:</b> " .. vip .. "</div> <div class=\"local2\"><b>Boost:</b> " .. boost .. "</div>")
                vRP.request(source, "Você deseja fechar o registro geral?", 1000)
                vRPclient.removeDiv(source, "completerg")
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- LIBERAR "START/STOP/ENSURE POR PERMISSÃO"
-----------------------------------------------------------------------------------------------------------------------------------------

local permensure = "founder.permissao"

RegisterCommand('start', function(source, args)
    if source ~= 0 then
        local user_id = vRP.getUserId(source)
        if not vRP.hasPermission(user_id, permensure) then
            TriggerClientEvent("Notify", source, "negado", "Sem permissão!")
            return
        end
    end
    if #args > 0 then
        StartResource(args[1])
    elseif source ~= 0 then
        TriggerClientEvent("Notify", source, "negado", "Sem argumentos para o seu comando!")
    else
        print("Seu comando não possui argumentos!")
    end
end)

RegisterCommand('stop', function(source, args)
    if source ~= 0 then
        local user_id = vRP.getUserId(source)
        if not vRP.hasPermission(user_id, permensure) then
            TriggerClientEvent("Notify", source, "negado", "Sem permissão!")
            return
        end
    end
    if #args > 0 then
        StopResource(args[1])
    elseif source ~= 0 then
        TriggerClientEvent("Notify", source, "negado", "Sem argumentos para o seu comando!")
    else
        print("Seu comando não possui argumentos!")
    end
end)

RegisterCommand('ensure', function(source, args)
    if source ~= 0 then
        local user_id = vRP.getUserId(source)
        if not vRP.hasPermission(user_id, permensure) then
            TriggerClientEvent("Notify", source, "negado", "Sem permissão!")
            return
        end
    end
    if #args > 0 then
        StopResource(args[1])
        StartResource(args[1])
    elseif source ~= 0 then
        TriggerClientEvent("Notify", source, "negado", "Sem argumentos para o seu comando!")
    else
        print("Seu comando não possui argumentos!")
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKAR JOGADORES PELA SOURCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kicksrc", function(source, args, command)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "kick.permissao") then
            DropPlayer(args[1], "VOCE FOI KIKADO!")
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /STATUS (PESSOAS ONLINE POR PROFISSÃO)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('status',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)        
	if vRP.hasPermission(user_id,"staff.permissao") then
		local onlinePlayers2 = GetNumPlayerIndices()
		local advogados2 = vRP.getUsersByPermission("judiciario.permissao")
    	local policia2 = vRP.getUsersByPermission("policia.permissao")
    	local paramedico2 = vRP.getUsersByPermission("paramedico.permissao")
    	local mec2 = vRP.getUsersByPermission("mecanico.permissao")
    	local staff2 = vRP.getUsersByPermission("staff.permissao")
		local taxista2 = vRP.getUsersByPermission("taxista.permissao")
		TriggerClientEvent("Notify",source,"importante","<b>Jogadores:</b> "..onlinePlayers2.."<br><b>Staff:</b> "..#staff2.."<br><b>Policiais:</b> "..#policia2.."<br><b>Advogados:</b> "..#advogados2.."<br><b>Taxistas:</b> "..#taxista2.."<br><b>Paramédicos:</b> "..#paramedico2.."<br><b>Mecânicos:</b> "..#mec2.."",9000)
	else
    	local advogados = vRP.getUsersByPermission("judiciario.permissao")
    	local paramedico = vRP.getUsersByPermission("paramedico.permissao")
    	local mec = vRP.getUsersByPermission("mecanico.permissao")
    	local taxista = vRP.getUsersByPermission("taxista.permissao")
		TriggerClientEvent("Notify",source,"importante","<b>Advogados:</b> "..#advogados.."<br><b>Taxistas:</b> "..#taxista.."<br><b>Paramédicos:</b> "..#paramedico.."<br><b>Mecânicos:</b> "..#mec.."",9000)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUBAR
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand('roubar', function(source, args, rawCommand)
--     local user_id = vRP.getUserId(source)
--     -- BLOQUEAR PARA NÃO PODER ROUBAR EM OUTRAS DIMENSÕES (ARENA PVP)
--     if GetPlayerRoutingBucket(source) ~= 0 then
--         return TriggerClientEvent("Notify", source, "negado", "Não é possível roubar em outras dimensões")
--     end
--     -- BLOQUEAR PARA POLICIAIS NÃO PODEREM USAR O COMANDO
--     if vRP.hasPermission(user_id, "nogarmas.permissao") or vRP.hasPermission(user_id, "policia.permissao") then
--         return TriggerClientEvent("Notify", source, "negado", "Policiais não podem utilizar o comando /roubar")
--     end
--     local nplayer = vRPclient.getNearestPlayer(source, 2)
--     if nplayer then
--         local nuser_id = vRP.getUserId(nplayer)
--         local policia = vRP.getUsersByPermission("policia.permissao")
--         local identity = vRP.getUserIdentity(user_id)
--         local identityu = vRP.getUserIdentity(nuser_id)
--         local crds = GetEntityCoords(GetPlayerPed(source))
--         local itens_roubo = {}
--         if #policia >= 2 then
--             if vRP.request(nplayer, "Você está sendo roubado, deseja passar tudo?", 30) then
--                 local ndata = vRP.getUserDataTable(nuser_id)
--                 local weapons = vRPclient.replaceWeapons(nplayer, {})
--                 local data = vRP.getUserDataTable(vRP.getUserId(nplayer))
--                 if data then
--                     data.weapons = {}
--                 end
--                 if ndata ~= nil then
--                     if ndata.inventory ~= nil then
--                         -- for qnt, item in pairs(whitelistRoubo) do
--                         --     -- print(item)
--                         -- end
--                         for k, v in pairs(ndata.inventory) do
--                             if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(k) * v.amount <= vRP.getInventoryMaxWeight(user_id) then
--                                 if k ~= 'sacodelixo' and k ~= 'garrafavazia' and k ~= 'garrafadeleite' and k ~= 'celular' and k ~= 'roupas' and k ~= 'mochila' and k ~= 'radio' and k ~= 'isca' and k ~= 'dourado' and k ~= 'corvina' and k ~= 'salmao' and k ~= 'pacu' and k ~= 'pintado' and k ~= 'pirarucu' and k ~= 'tilapia' and k ~= 'tucunare' and k ~= 'lambari' and k ~= 'ametista2' and k ~= 'bronze2' and k ~= 'diamante2' and k ~= 'esmeralda2' and k ~= 'ferro2' and k ~= 'ouro2' and k ~= 'rubi2' and k ~= 'safira2' and k ~= 'topazio2' and k ~= 'ametista' and k ~= 'bronze' and k ~= 'diamante' and k ~= 'esmeralda' and k ~= 'ferro' and k ~= 'ouro' and k ~= 'rubi' and k ~= 'safira' and k ~= 'topazio' and k ~= 'alianca' then
--                                     if vRP.tryGetInventoryItem(nuser_id, k, v.amount) then
--                                         vRP.giveInventoryItem(user_id, k, v.amount)
--                                         table.insert(itens_roubo, "[ITEM]: " .. vRP.itemNameList(k) .. " [QUANTIDADE]: " .. v.amount)
--                                     end
--                                 else
--                                     TriggerClientEvent("Notify", source, "aviso", "<b>" .. vRP.format(parseInt(v.amount)) .. "x " .. vRP.itemNameList(k) .. "</b> são proíbidos de serem roubados.")
--                                 end
--                             else
--                                 TriggerClientEvent("Notify", source, "negado", "Mochila não suporta <b>" .. vRP.format(parseInt(v.amount)) .. "x " .. vRP.itemNameList(k) .. "</b> por causa do peso.")
--                             end
--                         end
--                     end
--                 end
--                 for k, v in pairs(weapons) do
--                     vRP.giveInventoryItem(nuser_id, "wbody|" .. k, 1)
--                     if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("wbody|" .. k) <= vRP.getInventoryMaxWeight(user_id) then
--                         if vRP.tryGetInventoryItem(nuser_id, "wbody|" .. k, 1) then
--                             vRP.giveInventoryItem(user_id, "wbody|" .. k, 1)
--                             table.insert(itens_roubo, "[ITEM]: " .. vRP.itemNameList("wbody|" .. k) .. " [QUANTIDADE]: " .. 1)
--                         end
--                     else
--                         TriggerClientEvent("Notify", source, "negado", "Mochila não suporta <b>1x " .. vRP.itemNameList(k) .. "</b> por causa do peso.")
--                     end
--                     if v.ammo > 0 then
--                         vRP.giveInventoryItem(nuser_id, "wammo|" .. k, v.ammo)
--                         if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("wammo|" .. k) * v.ammo <= vRP.getInventoryMaxWeight(user_id) then
--                             if vRP.tryGetInventoryItem(nuser_id, "wammo|" .. k, v.ammo) then
--                                 vRP.giveInventoryItem(user_id, "wammo|" .. k, v.ammo)
--                                 table.insert(itens_roubo, "[ITEM]: " .. vRP.itemNameList("wammo|" .. k) .. " [QTD]: " .. v.ammo)
--                             end
--                         else
--                             TriggerClientEvent("Notify", source, "negado", "Mochila não suporta <b>" .. vRP.format(parseInt(v.ammo)) .. "x " .. vRP.itemNameList(k) .. "</b> por causa do peso.")
--                         end
--                     end
--                 end
--                 local nmoney = vRP.getMoney(nuser_id)
--                 if vRP.tryPayment(nuser_id, nmoney) then
--                     vRP.giveMoney(user_id, nmoney)
--                 end
--                 -- ACIONAR A POLICIA
--                 for l, w in pairs(policia) do
--                     local player = vRP.getUserSource(parseInt(w))
--                     if player then
--                         async(function()
--                             TriggerClientEvent('blipassalto:criar:assalto', player, crds.x, crds.y, crds.z)
--                             vRPclient.playSound(player, "Oneshot_Final", "MP_MISSION_COUNTDOWN_SOUNDSET")
--                             TriggerClientEvent('chatMessage', player, "190", {65, 130, 255}, "Assalto de Rua em andamento, dirija-se até o local e intercepte o assaltante.")
--                             SetTimeout(20000, function()
--                                 TriggerClientEvent('blipassalto:remover:assalto', player)
--                             end)
--                         end)
--                     end
--                 end
--                 vRPclient.setStandBY(source, parseInt(600))
--                 local itensroubados = table.concat(itens_roubo, "\n")
--                 TriggerClientEvent("Notify", source, "importante", "Roubo concluido com sucesso, corra, a polícia foi acionada")
--                 vRP.Log("```prolog\n[ASSALTANTE]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[ASSALTADO]: " .. nuser_id .. " " .. identityu.name .. " " .. identityu.firstname .. "\n"..itensroubados.."\n[COORDENADA]: " .. crds.x .. "," .. crds.y .. "," .. crds.z .. "" .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "CMD_ROUBAR")
--             else
--                 TriggerClientEvent("Notify", source, "importante", "A pessoa está resistindo ao roubo.")
--                 vRP.Log("```prolog\n[ASSALTANTE]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[ASSALTADO]: " .. nuser_id .. " " .. identityu.name .. " " .. identityu.firstname .. "\n[A PESSOA RESISTIU AO ROUBO]\n[COORDENADA]: " .. crds.x .. "," .. crds.y .. "," .. crds.z .. "" .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "CMD_ROUBAR")
--             end
--         else
--             TriggerClientEvent("Notify", source, "negado", "Número insuficiente de policiais no momento.")
--         end
--     end
-- end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- JOB
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('job2', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local membros = 0
    local membros_nomes = ""
    if vRP.hasPermission(user_id, "founder.permissao") then
        if args[1] == nil then
            return TriggerClientEvent("Notify", source, "importante", "<b>Comandos disponíveis:</b><br>/job Verdes<br>/job Vermelhos<br>/job Roxos<br>/job Laranjas<br>/job Sinaloa<br>/job Cosanostra<br>/job Yakuza<br>/job Irmandade<br>/job Salieris<br>/job Triade")
        elseif args[1] == "Verdes" then
            listaMembros = vRP.getUsersByPermission("verdes.permissao")
        elseif args[1] == "Vermelhos" then
            listaMembros = vRP.getUsersByPermission("vermelhos.permissao")
        elseif args[1] == "Roxos" then
            listaMembros = vRP.getUsersByPermission("roxos.permissao")
        elseif args[1] == "Laranjas" then
            listaMembros = vRP.getUsersByPermission("laranjas.permissao")
        elseif args[1] == "Sinaloa" then
            listaMembros = vRP.getUsersByPermission("sinaloa.permissao")
        elseif args[1] == "Cosanostra" then
            listaMembros = vRP.getUsersByPermission("cn.permissao")
        elseif args[1] == "Yakuza" then
            listaMembros = vRP.getUsersByPermission("yakuza.permissao")
        elseif args[1] == "Irmandade" then
            listaMembros = vRP.getUsersByPermission("irmandade.permissao")
        elseif args[1] == "Salieris" then
            listaMembros = vRP.getUsersByPermission("salieris.permissao")
        elseif args[1] == "Triade" then
            listaMembros = vRP.getUsersByPermission("triade.permissao")
        else
            return TriggerClientEvent("Notify", source, "importante", "<b>Comandos disponíveis:</b><br>/job Verdes<br>/job Vermelhos<br>/job Roxos<br>/job Laranjas<br>/job Sinaloa<br>/job Cosanostra<br>/job Yakuza<br>/job Irmandade<br>/job Salieris<br>/job Triade")
        end
        for k, v in ipairs(listaMembros) do
            local identity = vRP.getUserIdentity(parseInt(v))
            membros_nomes = membros_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
            membros = membros + 1
        end
        TriggerClientEvent("Notify", source, "importante", "Atualmente <b>" .. membros .. " membros</b> ativos.")
        if parseInt(membros) > 0 then
            TriggerClientEvent("Notify", source, "importante", membros_nomes)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- JOB - PARA PLAYERS VEREM OS MEMBROS ONLINE DE SUAS FACÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('MostrarMembrosJob')
AddEventHandler('MostrarMembrosJob', function(source, listaMembros, membros_nomes, membros, nomeJob)
    for k, v in ipairs(listaMembros) do
        local identity = vRP.getUserIdentity(parseInt(v))
        membros_nomes = membros_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
        membros = membros + 1
    end
    TriggerClientEvent("Notify", source, "importante", "Atualmente <b>" .. membros .. " "..nomeJob.."</b> ativos.")
    if parseInt(membros) > 0 then
        TriggerClientEvent("Notify", source, "importante", membros_nomes)
    end
end)

RegisterCommand('job', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local membros = 0
    local membros_nomes = ""

    if vRP.hasPermission(user_id, "verdes.permissao") then
        listaMembros = vRP.getUsersByPermission("verdes.permissao")
        TriggerEvent('MostrarMembrosJob', source, listaMembros, membros_nomes, membros, "Verdes")
    elseif vRP.hasPermission(user_id, "vermelhos.permissao") then
        listaMembros = vRP.getUsersByPermission("vermelhos.permissao")
        TriggerEvent('MostrarMembrosJob', source, listaMembros, membros_nomes, membros, "Vermelhos")
    elseif vRP.hasPermission(user_id, "roxos.permissao") then
        listaMembros = vRP.getUsersByPermission("roxos.permissao")
        TriggerEvent('MostrarMembrosJob', source, listaMembros, membros_nomes, membros, "Roxos")
    elseif vRP.hasPermission(user_id, "laranjas.permissao") then
        listaMembros = vRP.getUsersByPermission("laranjas.permissao")
        TriggerEvent('MostrarMembrosJob', source, listaMembros, membros_nomes, membros, "Laranjas")
    elseif vRP.hasPermission(user_id, "sinaloa.permissao") then
        listaMembros = vRP.getUsersByPermission("sinaloa.permissao")
        TriggerEvent('MostrarMembrosJob', source, listaMembros, membros_nomes, membros, "Sinaloa")
    elseif vRP.hasPermission(user_id, "cn.permissao") then
        listaMembros = vRP.getUsersByPermission("cn.permissao")
        TriggerEvent('MostrarMembrosJob', source, listaMembros, membros_nomes, membros, "Cosanostra")
    elseif vRP.hasPermission(user_id, "yakuza.permissao") then
        listaMembros = vRP.getUsersByPermission("yakuza.permissao")
        TriggerEvent('MostrarMembrosJob', source, listaMembros, membros_nomes, membros, "Yakuza")
    elseif vRP.hasPermission(user_id, "irmandade.permissao") then
        listaMembros = vRP.getUsersByPermission("irmandade.permissao")
        TriggerEvent('MostrarMembrosJob', source, listaMembros, membros_nomes, membros, "Irmandade")
    elseif vRP.hasPermission(user_id, "salieris.permissao") then
        listaMembros = vRP.getUsersByPermission("salieris.permissao")
        TriggerEvent('MostrarMembrosJob', source, listaMembros, membros_nomes, membros, "Salieris")
    elseif vRP.hasPermission(user_id, "triade.permissao") then
        listaMembros = vRP.getUsersByPermission("triade.permissao")
        TriggerEvent('MostrarMembrosJob', source, listaMembros, membros_nomes, membros, "Triade")
    elseif vRP.hasPermission(user_id, "policia.permissao") then
        listaMembros = vRP.getUsersByPermission("policia.permissao")
        TriggerEvent('MostrarMembrosJob', source, listaMembros, membros_nomes, membros, "Policiais")
    elseif vRP.hasPermission(user_id, "paramedico.permissao") then
        listaMembros = vRP.getUsersByPermission("paramedico.permissao")
        TriggerEvent('MostrarMembrosJob', source, listaMembros, membros_nomes, membros, "Médicos")
    elseif vRP.hasPermission(user_id, "mecanico.permissao") then
        listaMembros = vRP.getUsersByPermission("mecanico.permissao")
        TriggerEvent('MostrarMembrosJob', source, listaMembros, membros_nomes, membros, "Mecânicos")
    else
        return TriggerClientEvent("Notify", source, "negado", "Você não tem permissão para utilizar este comando")
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CALL ADM
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
RegisterCommand('call',function(source,args,rawCommand)
	local source = source
	local answered = false
	local user_id = vRP.getUserId(source)
    local identificador = math.random(100000,999999)
	if user_id then
		local players = {}
		if args[1] == "adm" then
			players = vRP.getUsersByPermission("staff.permissao")
		-- else args[1] == "190" then
		-- 	players = vRP.getUsersByPermission("policia.permissao")
		-- elseif args[1] == "192" then
		-- 	players = vRP.getUsersByPermission("paramedico.permissao")
		-- elseif args[1] == "mec" then
		-- 	players = vRP.getUsersByPermission("mecanico.permissao")
		-- elseif args[1] == "taxi" then
		-- 	players = vRP.getUsersByPermission("taxista.permissao")
		-- elseif args[1] == "adv" then
		-- 	players = vRP.getUsersByPermission("judiciario.permissao")
		else
			TriggerClientEvent("Notify",source,"negado","Serviço inexistente ou disponível somente pelo <b>Celular</b>")
			return
		end

		local descricao = vRP.prompt(source,"Descrição:","")
		if descricao == "" then
			return
		end

		local identitys = vRP.getUserIdentity(user_id)
		local crds = GetEntityCoords(GetPlayerPed(source))
		TriggerClientEvent("Notify",source,"sucesso","Chamado enviado com sucesso.")
		vRP.Log("```prolog\n[IDENTIFICADOR]: #"..identificador.."\n[FEITO POR]: "..user_id.." "..identitys.name.." "..identitys.firstname.." \n[MENSAGEM]: '"..descricao.."'\n[COORDENADA]: "..crds.x..","..crds.y..","..crds.z..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."```", "CMD_CALL")
		for l,w in pairs(players) do
			local player = vRP.getUserSource(parseInt(w))
			local nuser_id = vRP.getUserId(player)
			local x,y,z = vRPclient.getPosition(source)
			local uplayer = vRP.getUserSource(user_id)
			

			if player and player ~= uplayer then
				async(function()
					vRPclient.playSound(player,"Out_Of_Area","DLC_Lowrider_Relay_Race_Sounds")
					TriggerClientEvent('chatMessage',player,"CHAMADO",{255,0,0},"Enviado por ^1"..identitys.name.." "..identitys.firstname.."^0 ["..user_id.."]: "..descricao)
					local ok = vRP.request(player,"Aceitar o chamado de <b>"..identitys.name.." "..identitys.firstname.."</b>?",60)
					if ok then
						if not answered then
							answered = true
							local identity = vRP.getUserIdentity(nuser_id)
							vRP.Log("```prolog\n[IDENTIFICADOR]: #"..identificador.."\n[QUEM ACEITOU]: "..nuser_id.." "..identity.name.." "..identity.firstname.."\n[FEITO POR]: "..user_id.." "..identitys.name.." "..identitys.firstname.."\n[MENSAGEM]: '"..descricao.."'\n[COORDENADA]: "..crds.x..","..crds.y..","..crds.z..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."```", "CMD_CALL")
							-- TriggerClientEvent("Notify",source,"importante","Chamado atendido por <b>"..identity.name.." "..identity.firstname.."</b>, aguarde no local.")
							TriggerClientEvent("Notify",source,"importante","Chamado atendido, aguarde no local.")
							vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
							vRPclient._setGPS(player,x,y)
						else
							TriggerClientEvent("Notify",player,"negado","Chamado ja foi atendido por outra pessoa.")
							vRPclient.playSound(player,"CHECKPOINT_MISSED","HUD_MINI_GAME_SOUNDSET")
						end
					end
					local id = idgens:gen()
					blips[id] = vRPclient.addBlip(player,x,y,z,358,71,"Chamado",0.6,false)
					SetTimeout(300000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
				end)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /PAINEL
-----------------------------------------------------------------------------------------------------------------------------------------
local table = {
    {["Lider"] = "PMFCIV", ["Nome"] = "Policia", ["Grupos"] = {"PMFCIP", "PMFCIIP", "PMFCIIIP", "Retirar Set"}},
    {["Lider"] = "SAMUIV", ["Nome"] = "Hospital", ["Grupos"] = {"SAMUIP", "SAMUIIP", "SAMUIIP", "SAMUIIIP", "Retirar Set"}},
    {["Lider"] = "MidnightL", ["Nome"] = "Midnight", ["Grupos"] = {"Midnight", "Retirar Set"}},
    {["Lider"] = "DriftkingL", ["Nome"] = "Driftking", ["Grupos"] = {"Driftking", "Retirar Set"}},
    {["Lider"] = "MotoclubL", ["Nome"] = "Motoclub", ["Grupos"] = {"Motoclub", "Retirar Set"}},
    {["Lider"] = "VerdesL", ["Nome"] = "Verdes", ["Grupos"] = {"Verdes", "Retirar Set"}},
    {["Lider"] = "VermelhosL", ["Nome"] = "Vermelhos", ["Grupos"] = {"Vermelhos", "Retirar Set"}},
    {["Lider"] = "RoxosL", ["Nome"] = "Roxos", ["Grupos"] = {"Roxos", "Retirar Set"}},
    {["Lider"] = "LaranjasL", ["Nome"] = "Laranjas", ["Grupos"] = {"Laranjas", "Retirar Set"}},
    {["Lider"] = "SinaloaL", ["Nome"] = "Sinaloa", ["Grupos"] = {"Sinaloa", "Retirar Set"}},
    {["Lider"] = "CNL", ["Nome"] = "CN", ["Grupos"] = {"CN", "Retirar Set"}},
    {["Lider"] = "YakuzaL", ["Nome"] = "Yakuza", ["Grupos"] = {"Yakuza", "Retirar Set"}},
    {["Lider"] = "IrmandadeL", ["Nome"] = "Irmandade", ["Grupos"] = {"Irmandade", "Retirar Set"}},
    {["Lider"] = "SalierisL", ["Nome"] = "Salieris", ["Grupos"] = {"Salieris", "Retirar Set"}},
    {["Lider"] = "CamorraL", ["Nome"] = "Camorra", ["Grupos"] = {"Camorra", "Retirar Set"}},
    {["Lider"] = "TriadeL", ["Nome"] = "Triade", ["Grupos"] = {"Triade", "Retirar Set"}},
    {["Lider"] = "FARCL", ["Nome"] = "FARC", ["Grupos"] = {"FARC", "Retirar Set"}},
    {["Lider"] = "SerpentesL", ["Nome"] = "Serpentes", ["Grupos"] = {"Serpentes", "Retirar Set"}},
    {["Lider"] = "SportRaceL", ["Nome"] = "Fenix Customs", ["Grupos"] = {"SportRace", "Retirar Set"}},
    {["Lider"] = "VanillaL", ["Nome"] = "Vanilla Unicorn", ["Grupos"] = {"Vanilla", "Retirar Set"}},
}

RegisterCommand('painel', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserId(user_id)
    local identity = vRP.getUserIdentity(user_id)
    for k, v in pairs(table) do
        if vRP.hasGroup(user_id, v.Lider) then
            local menu = {name = v.Nome, css = {top = "75px", header_color = "rgba(42, 112, 190, 0.8)"}}
            for t, v in pairs(v.Grupos) do
                menu[v] = {
                    function(player, choice)
                        local console = vRP.prompt(source, "ID do usuário", "")
                        local sourcec = vRP.getUserSource(parseInt(console))
                        local idc = vRP.getUserId(sourcec)
                        if console ~= "" then
                            if idc then
                                if v == "Retirar Set" then
                                    vRP.addUserGroup(idc, "Civil")
                                    TriggerClientEvent('desligarRadios', source)
                                    vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[RETIROU O SET]: " .. idc .. " \n[PARA O GRUPO]: Civil " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "CMD_PAINEL")
                                    TriggerClientEvent("Notify", source, "sucesso", "Você retirou o set do ID <b>" .. idc .. "</b> com sucesso!")
                                    TriggerClientEvent("Notify", sourcec, "sucesso", "Você teve seu set removido pelo ID <b>"..user_id.."</b>")
                                    vRP.closeMenu(source)
                                    return true
                                end
                                if vRP.request(sourcec, "Você deseja se ingressar ao grupo " .. v .. " ?", 60) then
                                    TriggerClientEvent("Notify", source, "sucesso", "Você adicionou o ID <b>" .. idc .. "</b> no grupo <b>" .. v)
                                    TriggerClientEvent("Notify", sourcec, "sucesso", "Você entrou para o grupo <b>".. v.."</b> setado pelo ID <b>"..user_id.."</b>")
                                    vRP.addUserGroup(idc, v)
                                    vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[SETOU]: " .. idc .. " \n[PARA O GRUPO]: " .. v .. " " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "CMD_PAINEL")
                                else
                                    TriggerClientEvent("Notify", source, "O convite foi recusado")
                                end
                            else
                                TriggerClientEvent("Notify", source, "negado", "Usuário não está online")
                            end
                        end
                        vRP.closeMenu(source)
                    end,
                    "",
                }
            end
            vRP.openMenu(source, menu)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
local roupas = {
-- [1] = { -1,0 }, -- máscara
-- [3] = { 20,0 }, -- maos
-- [4] = { 75,0 }, -- calça
-- [5] = { 34,0 }, -- mochila
-- [6] = { 24,0 }, -- sapato
-- [7] = { -1,0 }, -- acessorios
-- [8] = { -1,0 }, -- blusa
-- [9] = { -1,0 }, -- colete
-- [10] = { -1,0 }, -- adesivo
-- [11] = { 86,1 }, -- jaqueta
	["minerador"] = {
		[1885233650] = {                                      
			[1] = { -1,0 },
			[3] = { 99,1 },
			[4] = { 89,20 },
			[5] = { -1,0 },
			[6] = { 82,2 },
			[7] = { -1,0 },
			[8] = { 90,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 273,0 },
			["p1"] = { 23,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 114,1 },
			[4] = { 92,20 },
			[5] = { -1,0 },
			[6] = { 86,2 },
			[7] = { -1,0 },
			[8] = { 54,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 286,0 },
			["p1"] = { 25,0 }
		}
	},
	["picuinha"] = {
		[1885233650] = { -- Masculino                          
			[1] = {169,14,2},
			[2] = {21,0,0},
			[3] = {146,1,2},
			[4] = {78,6,2},
			[5] = {29,12,1},
			[6] = {9,3,1},
			[7] = {0,0,2},
			[8] = {15,0,2},
			[9] = {0,0,1},
			[10] = {-1,0,2},
			[11] = {10,4,2},
			[0] = {0,0,0},
			["p1"] = {11,3},
			["p2"] = {-1,0},
			["p7"] = {-1,0},
			["p6"] = {-1,0},
			["p0"] = {130,0},
		},
		[-1667301416] = { -- Feminino
			[1] = {169,14,1},
			[2] = {75,0,0},
			[3] = {179,1,1},
			[4] = {80,6,1},
			[5] = {26,12,1},
			[6] = {32,0,1},
			[7] = {5,6,1},
			[8] = {6,0,1},
			[9] = {-1,0,0},
			[10] = {-1,0,0},
			[11] = {74,0,1},
			[0] = {0,0,0},
			["p7"] = {-1,0},
			["p6"] = {-1,0},
		}
	},
	["cn1"] = {
		[1885233650] = { -- Masculino                          
			[1] = {169,1,2},
            [2] = {21,0,0},
            [3] = {4,0,2},
            [4] = {24,1,2},
            [5] = {0,0,0},
            [6] = {69,1,2},
            [7] = {0,0,0},
            [8] = {72,1,2},
            [9] = {0,0,1},
            [10] = {0,0,0},
            [11] = {29,1,2},
            [0] = {0,0,0},
            ["p6"] = {-1,0},
            ["p7"] = {-1,0},
            ["p2"] = {-1,0},
            ["p0"] = {64,1},
		},
		[-1667301416] = { -- Feminino
			[1] = {169,1,1},
            [2] = {75,0,0},
            [3] = {3,0,1},
            [4] = {31,0,1},
            [5] = {0,0,1},
            [6] = {72,1,1},
            [7] = {2,0,2},
            [8] = {77,1,1},
            [9] = {-1,0,0},
            [10] = {-1,0,0},
            [11] = {64,2,1},
            ["p7"] = {-1,0},
            ["p2"] = {12,0},
            ["p6"] = {-1,0},
            [0] = {0,0,0},
		}
	},
	["cn2"] = {
		[1885233650] = { -- Masculino                          
			[1] = {169,1,2},
            [2] = {21,0,0},
            [3] = {4,0,2},
            [4] = {24,1,2},
            [5] = {0,0,0},
            [6] = {69,1,2},
            [7] = {0,0,0},
            [8] = {72,1,2},
            [9] = {0,0,1},
            [10] = {0,0,0},
            [11] = {29,1,2},
            [0] = {0,0,0},
            ["p6"] = {-1,0},
            ["p7"] = {-1,0},
            ["p1"] = {-1,0},
            ["p2"] = {-1,0},
            ["p0"] = {64,1},
		},
		[-1667301416] = { -- Feminino
			[1] = {169,1,1},
            [2] = {75,0,0},
            [3] = {3,0,1},
            [4] = {8,1,1},
            [5] = {34,0,1},
            [6] = {72,1,1},
            [7] = {0,0,2},
            [8] = {6,0,2},
            [9] = {-1,0,0},
            [10] = {-1,0,0},
            [11] = {136,1,1},
            [0] = {0,0,0},
            ["p6"] = {-1,0},
            ["p7"] = {-1,0},
            ["p2"] = {12,0},
		}
	},
	["cn3"] = {
		[1885233650] = { -- Masculino                          
			[1] = {169,1,2},
            [2] = {21,0,0},
            [3] = {4,0,2},
            [4] = {24,1,2},
            [5] = {0,0,0},
            [6] = {69,1,2},
            [7] = {0,0,0},
            [8] = {72,1,2},
            [9] = {0,0,1},
            [10] = {0,0,0},
            [11] = {29,1,2},
            [0] = {0,0,0},
            ["p6"] = {-1,0},
            ["p7"] = {-1,0},
            ["p1"] = {-1,0},
            ["p2"] = {-1,0},
            ["p0"] = {64,1},
		},
		[-1667301416] = { -- Feminino
			[1] = {169,1,1},
            [2] = {75,0,0},
            [3] = {3,0,1},
            [4] = {31,0,2},
            [5] = {34,0,1},
            [6] = {72,1,1},
            [7] = {2,0,2},
            [8] = {6,0,2},
            [9] = {-1,0,0},
            [10] = {-1,0,0},
            [11] = {136,1,1},
            ["p2"] = {12,0},
            ["p7"] = {-1,0},
            ["p6"] = {-1,0},
            [0] = {0,0,0},
		}
	},
    ["lixeiro"] = {
		[1885233650] = {                                      
			[1] = { -1,0 },
			[3] = { 17,0 },
			[4] = { 36,0 },
			[5] = { -1,0 },
			[6] = { 27,0 },
			[7] = { -1,0 },
			[8] = { 59,0 },
			[10] = { -1,0 },
			[11] = { 57,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 18,0 },
			[4] = { 35,0 },
			[5] = { -1,0 },
			[6] = { 26,0 },
			[7] = { -1,0 },
			[8] = { 36,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 50,0 }
		}
	},
	["taxista"] = {
		[1885233650] = {                                      
			[1] = { -1,0 },
			[3] = { 11,0 },
			[4] = { 35,0 },
			[5] = { -1,0 },
			[6] = { 10,0 },
			[7] = { -1,0 },
			[8] = { 15,0 },
			[10] = { -1,0 },
			[11] = { 13,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 0,0 },
			[4] = { 112,0 },
			[5] = { -1,0 },
			[6] = { 6,0 },
			[7] = { -1,0 },
			[8] = { 6,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 27,0 }
		}
	},
	["caminhoneiro"] = {
		[1885233650] = {                                      
			[1] = { -1,0 },
			[3] = { 0,0 },
			[4] = { 63,0 },
			[5] = { -1,0 },
			[6] = { 27,0 },
			[7] = { -1,0 },
			[8] = { 81,0 },
			[10] = { -1,0 },
			[11] = { 173,3 },
			["p1"] = { 8,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 14,0 },
			[4] = { 74,5 },
			[5] = { -1,0 },
			[6] = { 9,0 },
			[7] = { -1,0 },
			[8] = { 92,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 175,3 },
			["p1"] = { 11,0 }
		}
	},
	["pelado"] = {
		[1885233650] = {                                      
			[1] = {-1,0,2},
			[2] = {21,0,0},
			[3] = {126,0,2},
			[4] = {72,0,2},
			[5] = {-1,0,2},
			[6] = {34,0,2},
			[7] = {-1,0,2},
			[8] = {83,2,2},
			[9] = {0,5,1},
			[10] = {-1,0,2},
			[11] = {15,0,2},
			["p6"] = {-1,0},
			["p7"] = {-1,0},
			["p1"] = {-1,0},
			["p0"] = {-1,0},
			["p2"] = {-1,0},
			[0] = {0,0,0}			
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 15,0 },
			[4] = { 21,0 },
			[5] = { -1,0 },
			[6] = { 35,0 },
			[7] = { -1,0 },
			[8] = { 6,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 82,0 }
		}
	},
	["paciente"] = {
		[1885233650] = {
			[1] = { -1,0 },
			[3] = { 15,0 },
			[4] = { 61,0 },
			[5] = { -1,0 },
			[6] = { 16,0 },
			[7] = { -1,0 },			
			[8] = { 15,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 104,0 },			
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 0,0 },
			[4] = { 57,0 },
			[5] = { -1,0 },
			[6] = { 16,0 },
			[7] = { -1,0 },		
			[8] = { 7,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 105,0 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
	},
	["gesso"] = {
		[1885233650] = {
			[1] = {-1,0,2},
			[2] = {57,0,0},
			[3] = {4,0,1},
			[4] = {84,9,2},
			[5] = {-1,0,2},
			[6] = {13,0,2},
			[7] = {-1,0,2},
			[8] = {-1,0,2},
			[9] = {-1,0,2},
			[10] = {-1,0,2},
			[11] = {186,9,2},
			["p1"] = {-1,0},
			["p0"] = {-1,0},
			["p2"] = {-1,0},
			[0] = {0,0,0},
			["p7"] = {-1,0},
			["p6"] = {-1,0}		
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 3,0 },
			[4] = { 86,9 },
			[5] = { -1,0 },
			[6] = { 12,0 },
			[7] = { -1,0 },		
			[8] = { -1,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 188,9 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["mergulho"] = {
		[1885233650] = {
			[1] = {-1,0,2},
			[2] = {21,0,0},
			[3] = {17,0,2},
			[4] = {94,24,2},
			[5] = {-1,0,2},
			[6] = {67,24,2},
			[7] = {-1,0,2},
			[8] = {123,0,2},
			[9] = {0,5,1},
			[10] = {-1,0,2},
			[11] = {243,24,2},
			["p2"] = {-1,0},
			["p0"] = {-1,0},
			["p7"] = {-1,0},
			["p6"] = {-1,0},
			[0] = {0,0,0},
			["p1"] = {26,24},
		},
		[-1667301416] = {
			[1] = {-1,0,2},
			[2] = {15,0,0},
			[3] = {18,0,2},
			[4] = {97,24,2},
			[5] = {-1,0,2},
			[6] = {70,24,2},
			[7] = {-1,0,2},
			[8] = {153,0,2},
			[9] = {-1,0,2},
			[10] = {-1,0,2},
			[11] = {251,24,2},
			[0] = {0,0,0},
			["p2"] = {-1,0},
			["p1"] = {28,24},
			["p7"] = {-1,0},
			["p6"] = {-1,0},
			["p0"] = {-1,0},
		},
	},
}

RegisterCommand('roupas',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"roupas") >= 0 then
		if args[1] then
			local custom = roupas[tostring(args[1])]
			if custom then
				local old_custom = vRPclient.getCustomization(source)
				local idle_copy = {}

				idle_copy = vRP.save_idle_custom(source,old_custom)
				idle_copy.modelhash = nil

				for l,w in pairs(custom[old_custom.modelhash]) do
					idle_copy[l] = w
				end
				vRPclient._setCustomization(source,idle_copy)
				Citizen.Wait(1000)
				TriggerClientEvent("reloadtattos",source)
			end
		else
			vRP.removeCloak(source)
		end
		else
		TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Você precisa de ^1Roupas ^0para mudar de roupa.")
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE CABEÇADA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('Tackle:Server:TacklePlayer')
AddEventHandler('Tackle:Server:TacklePlayer', function(Tackled, ForwardVector, Tackler)
	TriggerClientEvent("Tackle:Client:TacklePlayer", Tackled, ForwardVector, Tackler)
end)
