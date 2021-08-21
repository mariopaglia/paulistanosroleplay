Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP")

-------LOG BANIMENTOS--------
ac_webhook_anthack = "https://discord.com/api/webhooks/800148956649750558/BYP4AcXNkOfOosRVVW7NUhPiM8WNDiKAoMn2g4-SUYFayTm-mHrrya4ppsF89aB8jUxS"
-----------------------------

-------LOG SUSPEITOS---------
ac_webhook_suspeitos = "https://discord.com/api/webhooks/800148997599789087/23_7W_qlPDszannE5ugMw_K-g8PjvL3d7DWgy8XITzag7SSr_htMuzIllcj39lTyu8_v"
-----------------------------

-------LOG COMANDOS----------
ac_webhook_logstaff = "https://discord.com/api/webhooks/800149038112440370/Ajh4RmH1paDI8ySaGLrRt2ae39pudz1b0UZv1Fj1krpU4ovHQki79IBQxC13uUYjQr9Z"
-----------------------------

-------------------------------
-------GETHACK PARAMETROS------
local banir_blacklisted = false
local minimo_bans = 2
local excecao = {}
excecao[1] = true
excecao[2] = true
excecao[3] = true
excecao[4] = true
excecao[5] = true
excecao[6] = true
excecao[7] = true
excecao[8] = true
-- oque fica entre os [] é o id de quem não deve ser banido por mais q tenha ultrapassado o limite de bans
------------------------------
Citizen.CreateThread(function()
    function SendWebhookMessage(webhook, message)
        if webhook ~= "none" then
            PerformHttpRequest(webhook, function(err, text, headers)
            end, 'POST', json.encode({content = message}), {['Content-Type'] = 'application/json'})
        end
    end
end)

local sistemas = {}
sistemas["[COLETE_HACK]"] = true
sistemas["[OUTROS-CLIENT]"] = true
sistemas["[SPECTADOR]"] = true
sistemas["[WALL]"] = true
sistemas["[Outros]"] = true
sistemas["[EXPLOSAO]"] = true
sistemas["[EXPLOSAO2]"] = true
sistemas["[Monster_Injetado]"] = false -- IGNORA, ISSO JA FUNCIONOU E NO MOMENTO SÓ DA ALARME FALSO
sistemas["[Monster_Injetado2]"] = false -- IGNORA, ISSO JA FUNCIONOU E NO MOMENTO SÓ DA ALARME FALSO
sistemas["[Monster_Injetado3]"] = false -- IGNORA, ISSO JA FUNCIONOU E NO MOMENTO SÓ DA ALARME FALSO
sistemas["[Monster_Diretor]"] = true
sistemas["[PROP]"] = true
sistemas["[NOCLIP]"] = true
sistemas["[GODMOD]"] = true
sistemas["[MODMENU]"] = true
sistemas["[OUTROS2]"] = true
sistemas["[REMOVE_GIVE_WEAPON]"] = true
sistemas["[Multiplicador_Dano]"] = true
sistemas["[SPAWN_DINHEIRO]"] = true
sistemas["[SPAWN_DINHEIRO2]"] = true
sistemas["[OUTROS4]"] = true
sistemas["[TELEPORT]"] = true
sistemas["[STOPCLIENT]"] = false
sistemas["[STOPCLIENT2]"] = false
sistemas["[STOPCLIENT3]"] = true

sistemas["[WALL2]"] = true
sistemas["[EXPLOSAO3]"] = true
sistemas["[Modo_Spawner]"] = true
sistemas["[SPAWN_VEICULOS]"] = true
sistemas["[SPAWN_PROP]"] = true
sistemas["[SPAWN_NPC]"] = true
sistemas["[SPAWN_VEICULO]"] = false -- Estava dando muito falso positivo (30/07)
sistemas["[EXPLOSAO4]"] = true

-- Adicionados manualmente
sistemas["[MODMENU2]"] = false -- Estava dando muito falso positivo (30/07)
sistemas["[MODMENU3]"] = true
sistemas["[MODMENU4]"] = true
sistemas["[MODMENU5]"] = true
sistemas["[SPAWN_PROP2]"] = false -- Estava dando muito falso positivo (06/08)
sistemas["[EXPLOSAO7]"] = true
sistemas["[PROP_BLACKLIST]"] = true
sistemas["[MULTIPLICADOR_DANO2]"] = false
sistemas["[Monster_Injetado4]"] = true
sistemas["[Monster_Injetado5]"] = false -- Em fase de testes
sistemas["[SPAWN_PARTICLES]"] = true
sistemas["[NUI_DEVTOOLS]"] = false
sistemas["[GOD1]"] = false
sistemas["[GOD2]"] = false
sistemas["[GODMOD2]"] = false

local banidos = {}
AddEventHandler("MQCU:LixoDetectado", function(user_id, msg, cb)
    if (sistemas[msg] ~= nil) then
        if (sistemas[msg] == true) then
            if (banidos[user_id] == nil) then
                banidos[user_id] = true
                local id = user_id
                local source = vRP.getUserSource(user_id)
                local ped = GetPlayerPed(source)
                local loc = GetEntityCoords(ped)
                local reason = "ANTI HACK:     localização:    " .. loc.x .. "," .. loc.y .. "," .. loc.z
                vRP.setBanned(id, true)
                local temp = os.date("%x  %X")
                -- vRP.logs("savedata/BANIMENTOS.txt","ANTI HACK	[ID]: "..id.."		"..temp.."[BAN]		[MOTIVO:"..msg.."]	"..reason)
                SendWebhookMessage(ac_webhook_anthack, "ANTI HACK	[ID]: " .. id .. "		" .. temp .. "[BAN]		[MOTIVO:" .. msg .. "]	" .. reason)

                local source = vRP.getUserSource(id)
                if source ~= nil then
                    -- TriggerClientEvent("vrp_sound:source",source,"ban",1.0)
                    -- Citizen.Wait(1000)
                    vRP.kick(source, "Você foi banido da cidade!")
                end
                cb()
                banidos[user_id] = nil
            end
        else
            local temp = os.date("%x  %X")
            SendWebhookMessage(ac_webhook_suspeitos, "ANTI HACK     Suspeito	[ID]: " .. user_id .. "		" .. temp .. "[BAN]		[MOTIVO:" .. msg .. "]	")
            alertarADM(user_id, msg)
        end
    else
        SendWebhookMessage(ac_webhook_suspeitos, "Função não mapeada => " .. msg .. "          [" .. user_id .. "]")
        alertarADM(user_id, msg)
    end
end)

--[[ -- ADICIONAR NO ARQUIVO -> vrp\base.lua
function vRP.getUserIdByIdentifier(ids)
	local rows = vRP.query("vRP/userid_byidentifier",{ identifier = ids})
	if #rows > 0 then
		return rows[1].user_id
	else
		return -1
	end
end
]]

--[[ -- SUBSTITUIR NO ARQUIVO	->	vrp\modules\player_state.lua
local colete = data.colete
SetTimeout(10000,function()
	if data.colete then
		source = vRP.getUserSource(user_id)
		if(source~=nil)then
			vRPclient.setArmour(source,colete)
		end
	end
end)






CODIGO A SUBSTITUIR:
if data.colete then			
	vRPclient.setArmour(source,data.colete)
end
]]

RegisterServerEvent("MCU:Load")
AddEventHandler("MCU:Load", function(cb)
    local vrpobj = {
        Entity = function(ent, key, value)
            Entity(ent).state[key] = value;
            return Entity(ent).state[key]
        end,
        MQCU = GetCurrentResourceName(),
        getUserId = vRP.getUserId,
        getUserIdByIdentifier = vRP.getUserIdByIdentifier,
        isBanned = vRP.isBanned,
        getUserSource = vRP.getUserSource,
        setSData = vRP.setSData,
        getSData = vRP.getSData,
        hasPermission = vRP.hasPermission,
        tryPayment = vRP.tryPayment,
        tryFullPayment = vRP.tryFullPayment,
        getUData = vRP.getUData,
        setUData = vRP.setUData,
        giveMoney = vRP.giveMoney,
        giveBankMoney = vRP.giveBankMoney,
        getUserIdentity = vRP.getUserIdentity,
        Log = RegistraLog,
        placas = {"SHOWROOM", "STAFFMOD", "CORREDOR", "CAMINHAO", "412WFA12", "545AGT57", "245ZSG98", "572SFM24", "195XSM51", "607AAS08", "569VOP45", "056PLX55", "661ZSA34", "056FSX40", "952XMM05", "106FJA42"},
        getPlacas = getAllPlacas,
        cfg_MQCUSOM = MQCUSOM,
    }
    cb(vrpobj)
end)
vRP._prepare("mqcu/get_AllPlacas", "SELECT plate FROM vrp_user_vehicles WHERE user_id = @user_id")
function getAllPlacas(user_id)
    return vRP.query("mqcu/get_AllPlacas", {user_id = user_id})
end

function RegistraLog(a, arquivo)
    if (a ~= nil) then
        a = "\n" .. a
        archive = io.open(arquivo .. ".txt", "a")
        if archive then
            archive:write(a)
        end
        archive:close()
    end
end

local logprop = false
AddEventHandler("MQCU:LogProp", function(msg, flag)
    if (flag or logprop) then
        SendWebhookMessage(ac_webhook_suspeitos, msg)
        alertarADM(user_id, msg)
    end
end)

AddEventHandler('MQCU:BlackList', function(user_id, qtd)
    if (banir_blacklisted and parseInt(qtd) >= minimo_bans and excecao[user_id] == nil) then
        vRP.setBanned(user_id, true)
        local temp = os.date("%x  %X")
        GravaLog("[ID]: " .. user_id .. "        " .. temp .. "[BAN]        [MOTIVO:BLACKLIST (QTD BANIMENTOS:" .. qtd .. ")]")
    end
end)

local wallstatus = {}
AddEventHandler('MarqCU#4374:wall', function(user_id)
    if (wallstatus[user_id] == nil) then
        wallstatus[user_id] = false
    end
    wallstatus[user_id] = not wallstatus[user_id]
    local source = vRP.getUserSource(user_id)
    local x, y, z = vRPclient.getPosition(source)
    local temp = os.date("%x  %X")
    local loc = "localização: " .. x .. "," .. y .. "," .. z
    local estado = ""
    if (wallstatus[user_id]) then
        estado = "True"
    else
        estado = "False"
    end
    SendWebhookMessage(ac_webhook_logstaff, "[ID]: " .. user_id .. "/wall \t[" .. estado .. "]\t" .. loc .. "\t[" .. temp .. "]")
    -- GravaLog("[ID]: " .. user_id .. "/wall \t[" .. estado .. "]\t" .. loc .. "\t[" .. temp .. "]")
end)

function alertarADM(user_id, msg)
    local adms = vRP.getUsersByPermission("ban.permissao")
    for k, v in pairs(adms) do
        admin_source = vRP.getUserSource(parseInt(v))
        TriggerClientEvent("Notify", admin_source, "aviso", "Jogador Suspeito: <b>" .. user_id .. "</b> - Motivo: " .. msg .. "", 15000)
    end
end

function GravaLog(a)
    if (a ~= nil) then
        a = "\n" .. a
        archive = io.open("MarqCU.txt", "a")
        if archive then
            archive:write(a)
        end
        archive:close()
    end
end

AddEventHandler("MCU:getUserId", function(source, cb)
    cb(vRP.getUserId(source))
end)
AddEventHandler("MCU:getUserIdByIdentifier", function(ids, cb)
    cb(vRP.getUserIdByIdentifier(ids))
end)
AddEventHandler("MCU:isBanned", function(user_id, cb)
    cb(vRP.isBanned(user_id))
end)
AddEventHandler("MCU:getUserSource", function(user_id, cb)
    cb(vRP.getUserSource(user_id))
end)
AddEventHandler("MCU:getSData", function(key, cb)
    cb(vRP.getSData(key))
end)
AddEventHandler("MCU:setSData", function(key, data)
    vRP.setSData(key, data)
end)
AddEventHandler("MCU:getGen", function(source, cb)
    cb(vRPclient.getGen(source))
end)
AddEventHandler("MCU:isHandcuffed", function(source, cb)
    cb(vRPclient.isHandcuffed(source))
end)
AddEventHandler("MCU:getCustomization", function(source, cb)
    local customization = vRPclient.getCustomization(source)
    cb(customization)
end)
AddEventHandler("MCU:hasPermission", function(user_id, permissao, cb)
    cb(vRP.hasPermission(user_id, permissao))
end)
AddEventHandler("MCU:tryPayment", function(user_id, valor, cb)
    cb(vRP.tryPayment(user_id, valor))
end)
AddEventHandler("MCU:tryFullPayment", function(user_id, valor, cb)
    cb(vRP.tryFullPayment(user_id, valor))
end)
AddEventHandler("MCU:getUData", function(user_id, key, cb)
    cb(vRP.getUData(user_id, key))
end)
AddEventHandler("MCU:setUData", function(user_id, key, data)
    vRP.setUData(user_id, key, data)
end)
AddEventHandler("MCU:giveMoney", function(user_id, value)
    vRP.giveMoney(user_id, value, "[MQCU]")
end)
AddEventHandler("MCU:giveBankMoney", function(user_id, value)
    vRP.giveBankMoney(user_id, value, "[MQCU]")
end)
AddEventHandler("MCU:setCustomization", function(source, index, p1, p2, p3)
    local customization = vRPclient.getCustomization(source)
    customization[index] = {p1, p2, p3}
    vRPclient.setCustomization(source, customization)
end)
AddEventHandler("MCU:toggleHandcuff", function(source)
    vRPclient.toggleHandcuff(source)
end)
AddEventHandler("MCU:playAnim", function(source, v1, v2, v3, v4, v5)
    vRPclient.playAnim(source, v1, {{v2, v3, v4}}, v5)
end)
AddEventHandler("MCU:notify", function(source, msg)
    TriggerClientEvent("Notify", source, "importante", msg)
end)

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    if (wallstatus[user_id] ~= nil) then
        if (wallstatus[user_id]) then
            wallstatus[user_id] = false
        end
    end
end)
