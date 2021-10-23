
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
fclient = Tunnel.getInterface("nation_garages")

vRPclient = Tunnel.getInterface("vRP")

func = {}
Tunnel.bindInterface("nation_garages", func)

--------- MYSQL ----------.


if not config.customMYSQL then
    vRP._prepare("vRP/createVehicleData", [[
        IF EXISTS(SELECT table_name 
            FROM INFORMATION_SCHEMA.TABLES
            WHERE table_name LIKE 'vrp_user_vehicles')
        THEN
            ALTER TABLE vrp_user_vehicles ADD IF NOT EXISTS estado TEXT DEFAULT '[]';
        ELSE
            IF EXISTS(SELECT table_name 
                FROM INFORMATION_SCHEMA.TABLES
                WHERE table_name LIKE 'vrp_user_vehicles')
            THEN
                ALTER TABLE vrp_user_vehicles ADD IF NOT EXISTS estado TEXT DEFAULT '[]';
            END IF;
        END IF;
    ]])

    vRP._prepare("vRP/create_ipva", "ALTER TABLE vrp_user_vehicles ADD IF NOT EXISTS ipva varchar(255) DEFAULT '1930912803'")
    vRP._prepare("vRP/getVehicles", "SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id")
    vRP._prepare("vRP/getVehicle", "SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
    vRP._prepare("vRP/setDetido", "UPDATE vrp_user_vehicles SET detido = @detido, time = @time, ipva = @ipva WHERE user_id = @user_id AND vehicle = @vehicle")
    vRP._prepare("vRP/setIpva", "UPDATE vrp_user_vehicles SET ipva = @ipva WHERE user_id = @user_id AND vehicle = @vehicle")
    vRP._prepare("vRP/setVehicleData", "UPDATE vrp_user_vehicles SET engine = @engine, body = @body, fuel = @fuel, estado = @estado WHERE user_id = @user_id AND vehicle = @vehicle")
end




--------------------------.

local spawnedVehicles = {}
local sharedKeys = {}

vRP.prepare('Igor:Select','SELECT * FROM vrp_user_identities WHERE registration = @registration')

function func.getId(placa)
    local consulta = vRP.query('Igor:Select', {
        registration = placa
    })
    local source = source
    local user_id = vRP.getUserId(source)
    if placa then
        if consulta[1] then
            if consulta[1].id == user_id then
                return true
            else
                return false
            end
        end
    end
end

function func.checkOpenGarage()
    local source = source
    local user_id = vRP.getUserId(source)
    if config.checkOpenGarage then
        return config.checkOpenGarage(source,user_id)
    else
        return true
    end
end


--- RETORNA TRUE CASO O PLAYER SEJA DONO DA CASA DETERMINADA.
function func.hasHome(home)
    local source = source
    local user_id = vRP.getUserId(source)
    return config.hasHome(source,user_id,home)
end

function func.getTime()
    return os.time()
end


--- RETORNA UMA TABLE COM TODOS OS VEÍCULOS DO PLAYER.
function func.getVehicles()
    local source = source
    local user_id = vRP.getUserId(source)
    local vehicles = vRP.query("vRP/getVehicles", {user_id = user_id})
    for i in pairs(vehicles) do 
        vehicles[i].price = getVehiclePrice(vehicles[i].vehicle)
        vehicles[i].name = config.getVehicleModel(vehicles[i].vehicle)
        vehicles[i].ipva = parseInt(vehicles[i].ipva)
        if not vehicles[i].detido then
            vehicles[i].detido = vehicles[i].arrest
        end
    end
    return vehicles
end

--- RETORNA UMA TABLE CONTENDO A TUNAGEM DE UM DETERMINADO VEÍCULO.
function func.getVehicleTuning(vehicle)
    local source = source
    local user_id = vRP.getUserId(source)
    if config.getVehicleMods then
        return config.getVehicleMods(source,user_id,vehicle)
    end
    local data = vRP.getSData("custom:u"..user_id.."veh_"..vehicle)
    local custom = json.decode(data)
    if custom then
        return custom
    end
    return false
end

--- RETORNA INFORMAÇÕES DO PORTA-MALAS DE UM DETERMINADO VEÍCULO.
function func.getVehicleTrunkChest(vehicle)
    local source = source
    local user_id = vRP.getUserId(source)
    local data = vRP.getSData("chest:u"..user_id.."veh_"..vehicle)
    local custom = json.decode(data)
    local vehInfo = func.getVehicleInfo(vehicle)
    local peso = 0
    local capacidade = 0
    if vehInfo then
        capacidade = vehInfo.capacidade
        if custom then
            for i in pairs(custom) do
                peso = parseInt(peso + (vRP.getItemWeight(i) * custom[i].amount))
            end
        end
    end
    return peso, capacidade
end

--- RETORNA O PREÇO DE UM DETERMINADO VEÍCULO PELA CONFIG.
function getVehiclePrice(vehicle)
    return config.getVehiclePrice(vehicle)
end

--- RETORNA INFORMAÇÕES DE UM DETERMINADO VEÍCULO PELA CONFIG.
function func.getVehicleInfo(vehicle)
    return config.getVehicleInfo(vehicle)
end

--- VERIFICAÇÃO DO VEÍCULO (SABER SE O PLAYER REALMENTE TEM O VEÍCULO E SE NAO ESTÁ DETIDO).
function func.checkVehicle(vehicle, type, hash, home, garage)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return
    elseif config.server_side_check and spawnedVehicles[hash] and spawnedVehicles[hash][user_id] and spawnedVehicles[hash][user_id].inStreet then
        TriggerClientEvent("Notify",source,"negado","Você já tem um veículo deste modelo fora da garagem.",3000)
        fclient.toggleNui(source)
        return
    elseif config.checkPlayer and not config.checkPlayer(source, user_id, vehicle, garage) then
        fclient.toggleNui(source)
        return
    end
    if type and type == "service" then
        local vehicleInfo = { vehicle = vehicle, engine = 1000, body = 1000, fuel = 100 }
        fclient.checkSpot(source,vehicleInfo, vRP.getUserRegistration(user_id))
        return
    end
    local vehicleInfo = vRP.query("vRP/getVehicle", {user_id = user_id, vehicle = vehicle})
    if vehicleInfo and #vehicleInfo > 0 then
        if (vehicleInfo[1].detido and vehicleInfo[1].detido == 0) or (vehicleInfo[1].arrest and vehicleInfo[1].arrest == 0) then
            if config.payTax then
                if config.payTax(source,user_id,vehicle, home) then
                    fclient.checkSpot(source,vehicleInfo[1],vehicleInfo[1].plate)
                    return
                end
            else
                if not config.checkVehicleGarage or config.checkVehicleGarage(source,user_id,vehicle, garage) then
                    fclient.checkSpot(source,vehicleInfo[1],vehicleInfo[1].plate)
                    return
                end
            end
        else
            if parseInt(vehicleInfo[1].time) == 0 then
                TriggerClientEvent("Notify",source,"negado","Veículo apreendido.",3000)
            else
                TriggerClientEvent("Notify",source,"negado","Veículo detido.",3000)
            end
        end
        fclient.toggleNui(source)
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLELOCK
-----------------------------------------------------------------------------------------------------------------------------------------
function func.vehicleLock()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local vehicle, vnetid, placa, vname, lock, banned = vRPclient.vehList(source, 7)
        if vehicle and placa then
            local placa_user_id = vRP.getUserByRegistration(placa)
            if user_id == placa_user_id then
                if vRPclient.getHealth(source) <= 100 then
                    TriggerClientEvent("Notify", source, "negado", "Você está desmaiado, não pode destrancar veículos.", 8000)
                    return
                end
                fclient.vehicleClientLock(-1, vnetid, lock)
                TriggerClientEvent("vrp_sound:source", source, 'lock', 0.5)
                vRPclient.playAnim(source, true, {{"anim@mp_player_intmenu@key_fob@", "fob_click"}}, false)
                if lock == 1 then
                    TriggerClientEvent("Notify", source, "importante", "Veículo <b>trancado</b> com sucesso.", 8000)
                else
                    TriggerClientEvent("Notify", source, "importante", "Veículo <b>destrancado</b> com sucesso.", 8000)
                end
            end
        end
    end
end


--- RETORNA TRUE CASO O PLAYER PAGUE A TAXA DO VEÍCULO COM SUCESSO.
function func.tryPayTax(vehicle)
    local source = source
    local user_id = vRP.getUserId(source)
    local type = config.getVehicleType(vehicle)
    if config.checkTax then
        local bool = config.checkTax(source,user_id, vehicle, type)
        return bool
    end
    local vehicleInfo = vRP.query("vRP/getVehicle", {user_id = user_id, vehicle = vehicle})
    
    if vehicleInfo and #vehicleInfo > 0 then
        local price = getVehiclePrice(vehicle)
        if vehicleInfo[1].detido == 0 and parseInt(tonumber(vehicleInfo[1].ipva) + 24 * 15 * 60 * 60) > parseInt(os.time()) then
            return true
        end
        if vehicleInfo[1].detido == 1 then
            if parseInt(vehicleInfo[1].time) == 0 then
                price = parseInt(price * (config.seguradora / 100))
            else
                price = parseInt(price * (config.detido / 100))
            end
        elseif type and type == "exclusive" then
            vRP.execute("vRP.setIpva", { user_id = user_id, vehicle = vehicle, ipva = parseInt(os.time())})
            return true
        else
            price = parseInt(price * ((config.ipva or 1) / 100))
        end
        if config.use_tryFullPayment then
            if vRP.paymentBank(user_id, price) then
                vRP.execute("vRP/setDetido", { detido = 0, time = "0", user_id = user_id, vehicle = vehicle, ipva = parseInt(os.time())})
                return true
            end
        elseif vRP.paymentBank(user_id, price) then
            vRP.execute("vRP/setDetido", { detido = 0, time = "0", user_id = user_id, vehicle = vehicle, ipva = parseInt(os.time())})
            return true
        end
    end
    return false
end


--- GUARDA O VEÍCULO NA GARAGEM E SALVA SUAS INFORMAÇÕES NO BANCO DE DADOS.
function func.saveVehicle(vehicle,plate,engine,body,fuel,estado)
    if not vehicle or not plate or not engine or not body or not fuel then
        return
    end
    local user_id = vRP.getVehiclePlate(plate) or vRP.getUserByRegistration(plate)
    if user_id then
        vRP.execute("vRP/setVehicleData", { engine = engine, body = body, fuel = fuel, estado = json.encode(estado or {}), user_id = user_id, vehicle = vehicle })
    end
end



--- CHECA SE O PLAYER TEM A PERMISSÃO PARA ACESSAR A--https://discord.gg/sergin GARAGEM DE SERVIÇO ---
function func.hasPermission(perm)
    if not perm then
        return true
    end
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,perm) then
        return true
    end
    TriggerClientEvent("Notify",source,"negado","Você não tem permissao",3000)
    return false
end


function func.addGarage()
    local source = source
    local user_id = vRP.getUserId(source)
    if config.addGarage then
        config.addGarage(source,user_id)
    end
end

--- SPAWNA O VEÍCULO VIA SERVER-SIDE PARA NÃO OCORRER BUGS (VEÍCULO NÃO SER DELETADO) ---

function func.spawnVeh(mhash, coords, h, plate)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    -- print(user_id,'id server')
    -- print(json.encode(identity))
    local vehicle = CreateVehicle(mhash,coords.x,coords.y,coords.z+0.5,h,true,true)
    
    SetVehicleNumberPlateText(vehicle,identity.registration)
end

function func.getVehiclePlate(veh)
    if config.getVehiclePlate then
        local source = source
        return config.getVehiclePlate(source,veh)
    end
    return false
end

------------------------------------------------------------------------
-------------------- VEÍCULOS INATIVOS --------------.-----------------
------------------------------------------------------------------------

--- TABLE QUE ARMAZENA OS VEÍCULOS SPAWNADOS PELA GARAGEM ---
vehicles = {}


--- REGISTRA O VEÍCULO NA TABLE DOS VEÍCULOS SPAWNADOS PELA GARAGEM ---
function func.registerVehicle(netveh,hash)
    local source = source
    local user_id = vRP.getUserId(source)
    if spawnedVehicles[hash] then
        spawnedVehicles[hash][user_id] = { inStreet = true, netid = netveh }
    else
        spawnedVehicles[hash] = { [user_id] = { inStreet = true, netid = netveh } }
    end
    if config.reset then
        vehicles[#vehicles + 1] = { netveh = netveh, time =  config.tempoReset * 60 }
    end
end

--- REMOVE O VEÍCULO NA TABLE DOS VEÍCULOS SPAWNADOS PELA GARAGEM ---
function func.removeVehicle(netveh,hash,plate)
    local source = source
    local user_id = vRP.getVehiclePlate(plate) or vRP.getUserByRegistration(plate)
    if user_id and spawnedVehicles[hash] and spawnedVehicles[hash][user_id] then
        spawnedVehicles[hash][user_id] = false
    elseif spawnedVehicles[hash] then
        for i in pairs(spawnedVehicles[hash]) do 
            if spawnedVehicles[hash][i] and spawnedVehicles[hash][i].netid == netveh then
                spawnedVehicles[hash][i] = false
                break
            end
        end
    end
    if config.reset then
        for i in ipairs(vehicles) do 
            if vehicles[i].netveh == netveh then
                table.remove(vehicles,i)
                return
            end
        end
    end
end

RegisterServerEvent("nation:removeVehicle")
AddEventHandler("nation:removeVehicle", function(netveh,hash,plate)
    local source = source
    local user_id = vRP.getVehiclePlate(plate) or vRP.getUserByRegistration(plate)
    if user_id and spawnedVehicles[hash] and spawnedVehicles[hash][user_id] then
        spawnedVehicles[hash][user_id] = false
    elseif spawnedVehicles[hash] then
        for i in pairs(spawnedVehicles[hash]) do 
            if spawnedVehicles[hash][i] and spawnedVehicles[hash][i].netid == netveh then
                spawnedVehicles[hash][i] = false
                break
            end
        end
    end
end)

--- SE CONFIG.RESET FOR TRUE, FAZ UMA VERIFICAÇÃO DE 1 EM 1 MIN PARA SABER QUAIS VEÍCULOS ESTÃO INATIVOS.
Citizen.CreateThread(function()
    vRP.execute("vRP/create_ipva")
    if not config.customMYSQL then
        vRP.execute("vRP/createVehicleData")
    end
    while config.reset do
        if #vehicles > 0 then
            local users = vRP.getUsers()
            for i in ipairs(vehicles) do 
                local active = false
                for j in ipairs(users) do 
                    local src = users[j]
                    if fclient.isVehicleActive(src,vehicles[i].netveh) then
                        active = true
                        vehicles[i].time = config.tempoReset * 60
                        break
                    end
                end
                if not active then
                    vehicles[i].time = vehicles[i].time - 60
                    if vehicles[i].time <= 0 then
                        fclient.deleteVehicle(-1,vehicles[i].netveh)
                        table.remove(vehicles,i)
                    end
                end
            end
        end
        Citizen.Wait(60*1000)
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
--[ CAR ]--------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("car",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
 	if user_id then
		if vRP.hasPermission(user_id,"Owner") and args[1] then
      		local plate = "55DTA141"
			TriggerClientEvent("adminVehicle",source,args[1],plate)
     		TriggerEvent("setPlateEveryone",plate)
			TriggerEvent("setPlatePlayers",plate,user_id)
		end
	end
end)      

------------------------------------------------------------------------
----------------------.------------------------------------------------
------------------------------------------------------------------------


------------------------------------------------------------------------
------------------ TRANCAR . DESTRANCAR VEÍCULO ------------------------
------------------------------------------------------------------------

--- CASO O VEÍCULO MAIS PRÓXIMO DO PLAYER SEJA DELE, ACIONA O EVENTO DE TOGGLELOCK NO VEÍCULO ---



function canLockVehicle(user_id, vname, owner)
    if user_id and vname and owner then
        local index = "key-"..vname.."-"..owner
        if sharedKeys[index] then
            for _,id in ipairs(sharedKeys[index]) do
                if id == user_id then
                    return true
                end
            end
        end
    end
    return false
end

--- SYNC DO TOGGLELOCK ---
RegisterServerEvent("nation:tryLockVehicle")
AddEventHandler("nation:tryLockVehicle",function(nveh)
    TriggerClientEvent("nation:syncLock",-1,nveh)
end)


RegisterServerEvent("nation:deleteVehicleSync")
AddEventHandler("nation:deleteVehicleSync",function(nveh)
    fclient.deleteVehicle(-1,nveh)
end)

------------------------------------------------------------------------
--https://discord.gg/sergin
------------------------------------------------------------------------
----------------------- COMANDO DE DV ----------------------------------
------------------------------------------------------------------------

function sendWebhookMessage(webhook, user_id)
    if webhook then
        print("enviado")
        --PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "LOG_DV", content = "**[DV]**n```prologn[ID]: "..user_id.."n[DATA]: "..os.date("%d.%m.%Y [Hora]: %H:%M:%S").."nn```"}), { ['Content-Type'] = 'application.json' })
    end
end

RegisterCommand('dv',function(source)
    local user_id = vRP.getUserId(source) 
    if vRP.hasPermission(user_id,"staff.permissao") or vRP.hasPermission(user_id,"kick.permissao")  then -- Se for adicionar + de um coloca um or e vRP.hasPermission(user_id,"sua permissão") 
        local deletedVehicle = fclient.tryDeleteNearestVehicle(source)
        if deletedVehicle and config.webhook then
            sendWebhookMessage(config.webhook, user_id)
        end
    end
end)



-----------------------------------------------------------------------------------------------------------------------------------------
--[ REPARAR ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryreparar")
AddEventHandler("tryreparar",function(nveh)
    TriggerClientEvent("syncreparar",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("creative/get_vehicle","SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id")
vRP._prepare("creative/rem_vehicle","DELETE FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("creative/get_vehicles","SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("creative/set_update_vehicles","UPDATE vrp_user_vehicles SET engine = @engine, body = @body, fuel = @fuel WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("creative/set_detido","UPDATE vrp_user_vehicles SET detido = @detido, time = @time WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("creative/set_ipva","UPDATE vrp_user_vehicles SET ipva = @ipva WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("creative/move_vehicle","UPDATE vrp_user_vehicles SET user_id = @nuser_id WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("creative/add_vehicle","INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,ipva) VALUES(@user_id,@vehicle,@ipva)")
vRP._prepare("creative/con_maxvehs","SELECT COUNT(vehicle) as qtd FROM vrp_user_vehicles WHERE user_id = @user_id")
vRP._prepare("creative/rem_srv_data","DELETE FROM vrp_srv_data WHERE dkey = @dkey")
vRP._prepare("creative/get_users","SELECT * FROM vrp_users WHERE id = @id")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ MOTOR ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trymotor")
AddEventHandler("trymotor",function(nveh)
    TriggerClientEvent("syncmotor",-1,nveh)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ANCORAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ancorar',function(source,args,rawCommand)
local source = source
local user_id = vRP.getUserId(source)
    local vehPlate,_,_,_,vnet = fclient.getNearestVehicleInfo(source)
    if vehPlate then
        local vehUser = vRP.getVehiclePlate(vehPlate) or vRP.getUserByRegistration(vehPlate)
        if vehUser and user_id == vehUser then
            fclient.toggleAnchor(source,vnet)
        end
    end
end)


function func.checkAuth()
    return true
end
--https://discord.gg/sergin

-- vRP.prepare('Igor:Select','SELECT * FROM vrp_users WHERE registration = @registration')

-- RegisterServerEvent('nation:tryLockNearestVehicle')
-- AddEventHandler('nation:tryLockNearestVehicle',function(plate)
--     local consulta = vRP.query('Igor:Select', {
--         registration = plate
--     })
--     if consulta[1] then
--         if plate == 
--     end
-- end)