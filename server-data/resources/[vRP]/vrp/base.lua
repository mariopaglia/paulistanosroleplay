local Proxy = module("lib/Proxy")
local Tunnel = module("lib/Tunnel")

local config = module("cfg/base")

vRP = {}
Proxy.addInterface("vRP", vRP)

tvRP = {}
Tunnel.bindInterface("vRP", tvRP)
vRPclient = Tunnel.getInterface("vRP")

vRP.users = {}
vRP.rusers = {}
vRP.user_tables = {}
vRP.user_tmp_tables = {}
vRP.user_sources = {}

local db_drivers = {}
local db_driver
local cached_prepares = {}
local cached_queries = {}
local pquery = {}
local db_initialized = false

-- WEBHOOK

-- local webhookpmesp = "https://discord.com/api/webhooks/809191725490110465/p7pfd4VTGWwP9d-oIHJvMGw6kzviuLJcESLYe2u3kr3_pwGFw-jiRk2OOz9uMW_4Tbcr"
-- local webhookpcesp = "https://discord.com/api/webhooks/809892713758851092/wMGCoBzvyLhAJM2k2_gTKfIMWGNgLoGtqhEp3oJEgCd7ChsAdr67zsGSaDBo4p-Gy9Ig"
-- local webhookhospitalbase = "https://discord.com/api/webhooks/793597683155599380/ql-y4081JzoLAv-KwjKVFmDZLMvfVmFNSFnig6NKSyxCvsfzN51lJuui9S0rsrm8doKk"
-- local webhookbennys = "https://discord.com/api/webhooks/793597828386521108/UsgyanaAIxAXtNuDuP8Cbf67cauDpARltO9RxIAsGioYKolylf3TWyJl_CtTRyK5sA3O"
-- local webhooksportrace = "https://discord.com/api/webhooks/809191208429158421/aeVf8HgBwbKprnhaz4Za3HSirDrp6U1-ANqZUtvVlo4L_BFYvx-Jih6vPT3kSkOcJBpg"
-- local webhookconce = "https://discord.com/api/webhooks/809187305267920968/wOE6E6i2qerRtu8P5rn2dIGgiFy9dDzdGzZ1DGORizXtZJEkZngwaKPcstQ6ARKpXJcZ"
-- local webhookprf = "https://discord.com/api/webhooks/820696422675906560/elQ-WS7J7VEEVHXSMTIGNBUGdab-yYORqIxsooqhdj4ynwTYPK4AIwkPeT1VdAyOauB6"
-- local webhookrota = "https://discord.com/api/webhooks/820698946245492766/kdCmczOoX3DVNvGsAhwxtrY5OR9wkTa3gSZFoib6HsGuXF7Oy8shcKc7UkEPsOIeApFK"
-- local webhookdic = "https://discord.com/api/webhooks/867470805986574346/c-nsvapMVxjSaPC4_6JmsnVGsX6TNjNcV7MbZROdK6fxh4KFotTvkBp_i4zfwyJGFhr5"
-- local webhooktooglestaff = "https://discord.com/api/webhooks/877567284598693908/uqbZqlB7CDwJ-o9eSR23naEQgE0WF378AUPqtqZctZZw_-Uf1zwOgD6X3G3EswohOfs9"

-- function SendWebhookMessage(webhook, message)
--     if webhook ~= nil and webhook ~= "" then
--         PerformHttpRequest(webhook, function(err, text, headers)
--         end, 'POST', json.encode({content = message}), {['Content-Type'] = 'application/json'})
--     end
-- end

function vRP.format(n)
    local left, num, right = string.match(n, '^([^%d]*%d)(%d*)(.-)$')
    return left .. (num:reverse():gsub('(%d%d%d)', '%1.'):reverse()) .. right
end

function vRP.logs(archive, text)
    archive = io.open(archive, "a")
    if archive then
        archive:write(text .. "\n")
    end
    archive:close()
end

function vRP.prepare(name, query)
    pquery[name] = query
end

function vRP.query(name, params)
    local r = async()
    exports.ghmattimysql:execute(pquery[name], params or {}, function(res)
        r(res)
    end)
    return r:wait()
end

function vRP.execute(name, params)
    exports.ghmattimysql:execute(pquery[name], params)
    return true
end

vRP.prepare("vRP/create_user", "INSERT INTO vrp_users(whitelisted,banned) VALUES(false,false)")
vRP.prepare("vRP/add_identifier", "INSERT INTO vrp_user_ids(identifier,user_id) VALUES(@identifier,@user_id)")
vRP.prepare("vRP/userid_byidentifier", "SELECT user_id FROM vrp_user_ids WHERE identifier = @identifier")
vRP.prepare("vRP/identifier_byuserid", "SELECT identifier FROM vrp_user_ids WHERE user_id = '@user_id' AND identifier LIKE 'discord:%'")
vRP.prepare("vRP/set_userdata", "REPLACE INTO vrp_user_data(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)")
vRP.prepare("vRP/get_userdata", "SELECT dvalue FROM vrp_user_data WHERE user_id = @user_id AND dkey = @key")
vRP.prepare("vRP/set_srvdata", "REPLACE INTO vrp_srv_data(dkey,dvalue) VALUES(@key,@value)")
vRP.prepare("vRP/get_srvdata", "SELECT dvalue FROM vrp_srv_data WHERE dkey = @key")
vRP.prepare("vRP/get_banned", "SELECT banned FROM vrp_users WHERE id = @user_id")
vRP.prepare("vRP/set_banned", "UPDATE vrp_users SET banned = @banned WHERE id = @user_id")
vRP.prepare("vRP/get_whitelisted", "SELECT whitelisted FROM vrp_users WHERE id = @user_id")
vRP.prepare("vRP/set_whitelisted", "UPDATE vrp_users SET whitelisted = @whitelisted WHERE id = @user_id")
vRP.prepare("vRP/set_last_login", "UPDATE vrp_users SET last_login = @last_login, ip = @ip WHERE id = @user_id")

function vRP.getUserIdByIdentifier(ids)
    local rows = vRP.query("vRP/userid_byidentifier", {identifier = ids})
    if #rows > 0 then
        return rows[1].user_id
    else
        return -1
    end
end

function vRP.getUserIdByIdentifiers(ids)
    if ids and #ids then
        for i = 1, #ids do
            if (string.find(ids[i], "ip:") == nil) then
                local rows = vRP.query("vRP/userid_byidentifier", {identifier = ids[i]})
                if #rows > 0 then
                    return rows[1].user_id
                end
            end
        end

        local rows = vRP.query("vRP/create_user", {})
        if rows.insertId then
            local user_id = rows.insertId
            for l, w in pairs(ids) do
                if (string.find(w, "ip:") == nil) then
                    vRP.execute("vRP/add_identifier", {user_id = user_id, identifier = w})
                end
            end
            return user_id
        else
            print("Erro ao recuperar identificadores: " .. json.encode(ids))
            return nil
        end
    end
end

function vRP.isBanned(user_id)
    local rows = vRP.query("vRP/get_banned", {user_id = user_id})
    if #rows > 0 then
        return rows[1].banned
    else
        return false
    end
end

function vRP.setBanned(user_id, banned)
    local wh = "https://discord.com/api/webhooks/812889505056423956/9W2wwQ5vf-R4Xv5tvAgm4ipk-J9L9Qbsh7mLIV95T25RmRAXn5yKAuK8kZZRGMDSynCe"
    local message = ""
    if vRP.getUserSource(user_id) then
        local ids = GetPlayerIdentifiers(vRP.getUserSource(user_id))
        local did
        for l, w in pairs(ids) do
            if string.find(w, "discord:") then
                local u, d = w:find("discord:")
                message = w:sub(d + 1)
            end
        end

        DropPlayer(vRP.getUserSource(user_id), "Você foi banido da cidade!")
    else
        local rows = vRP.query("vRP/identifier_byuserid", {user_id = user_id})
        print("Ban: " .. json.encode(rows))
        if #rows > 0 then
            local id = rows[1].identifier
            local u, d = id:find("discord:")
            message = id:sub(d + 1)
        end
    end

    if message ~= "" and banned == true then
        PerformHttpRequest(wh, function(err, text, headers)
        end, 'POST', json.encode({content = message}), {['Content-Type'] = 'application/json'})
    end
    vRP.execute("vRP/set_banned", {user_id = user_id, banned = banned})
end

function vRP.isWhitelisted(user_id)
    local rows = vRP.query("vRP/get_whitelisted", {user_id = user_id})
    if #rows > 0 then
        return rows[1].whitelisted
    else
        return false
    end
end

function vRP.setWhitelisted(user_id, whitelisted)
    vRP.execute("vRP/set_whitelisted", {user_id = user_id, whitelisted = whitelisted})
end

function vRP.setUData(user_id, key, value)
    vRP.execute("vRP/set_userdata", {user_id = user_id, key = key, value = value})
end

function vRP.getUData(user_id, key)
    local rows = vRP.query("vRP/get_userdata", {user_id = user_id, key = key})
    if #rows > 0 then
        return rows[1].dvalue
    else
        return ""
    end
end

function vRP.setSData(key, value)
    vRP.execute("vRP/set_srvdata", {key = key, value = value})
end

function vRP.getSData(key)
    local rows = vRP.query("vRP/get_srvdata", {key = key})
    if #rows > 0 then
        return rows[1].dvalue
    else
        return ""
    end
end

function vRP.getUserDataTable(user_id)
    return vRP.user_tables[user_id]
end

function vRP.getUserTmpTable(user_id)
    return vRP.user_tmp_tables[user_id]
end

function vRP.getUserId(source)
    if source ~= nil then
        local ids = GetPlayerIdentifiers(source)
        if ids ~= nil and #ids > 0 then
            return vRP.users[ids[1]]
        end
    end
    return nil
end

function vRP.getUsers()
    local users = {}
    for k, v in pairs(vRP.user_sources) do
        users[k] = v
    end
    return users
end

function vRP.getUserSource(user_id)
    return vRP.user_sources[user_id]
end

function vRP.kick(source, reason)
    DropPlayer(source, reason)
end

function vRP.dropPlayer(source)
    local source = source
    local user_id = vRP.getUserId(source)
    vRPclient._removePlayer(-1, source)
    if user_id then
        if user_id and source then
            TriggerEvent("vRP:playerLeave", user_id, source)
            -- Forçar para ficar à paisana quando sair
            local identity = vRP.getUserIdentity(user_id)

            ---------------------------------------------------
            -- TAXISTA
            ---------------------------------------------------
            if vRP.hasGroup(user_id, "Taxista") then
                vRP.removeUserGroup(user_id, "Taxista")

                ---------------------------------------------------
                -- POLICIA MILITAR
                ---------------------------------------------------
            elseif vRP.hasGroup(user_id, "PMFCI") then
                vRP.addUserGroup(user_id, "PMFCIP")
                vRP.Log("```prolog\n[POLICIAL]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[===========SAIU DE SERVICO==========] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "TOOGLE_POLICIA")

            elseif vRP.hasGroup(user_id, "PMFCII") then
                vRP.addUserGroup(user_id, "PMFCIIP")
                vRP.Log("```prolog\n[POLICIAL]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[===========SAIU DE SERVICO==========] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "TOOGLE_POLICIA")

            elseif vRP.hasGroup(user_id, "PMFCIII") then
                vRP.addUserGroup(user_id, "PMFCIIIP")
                vRP.Log("```prolog\n[POLICIAL]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[===========SAIU DE SERVICO==========] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "TOOGLE_POLICIA")

            elseif vRP.hasGroup(user_id, "PMFCIV") then
                vRP.addUserGroup(user_id, "PMFCIVP")
                vRP.Log("```prolog\n[POLICIAL]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[===========SAIU DE SERVICO==========] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "TOOGLE_POLICIA")

                ---------------------------------------------------
                -- DIC - POLICIA INVESTIGATIVA
                ---------------------------------------------------
            elseif vRP.hasGroup(user_id, "DICI") then
                vRP.addUserGroup(user_id, "DICIP")
                vRP.Log("```prolog\n[POLICIAL]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[===========SAIU DE SERVICO==========] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "TOOGLE_DIC")

            elseif vRP.hasGroup(user_id, "DICII") then
                vRP.addUserGroup(user_id, "DICIIP")
                vRP.Log("```prolog\n[POLICIAL]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[===========SAIU DE SERVICO==========] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "TOOGLE_DIC")

            elseif vRP.hasGroup(user_id, "DICIII") then
                vRP.addUserGroup(user_id, "DICIIIP")
                vRP.Log("```prolog\n[POLICIAL]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[===========SAIU DE SERVICO==========] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "TOOGLE_DIC")

            elseif vRP.hasGroup(user_id, "DICIV") then
                vRP.addUserGroup(user_id, "DICIVP")
                vRP.Log("```prolog\n[POLICIAL]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[===========SAIU DE SERVICO==========] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "TOOGLE_DIC")

                ---------------------------------------------------
                -- HOSPITAL
                ---------------------------------------------------
            elseif vRP.hasGroup(user_id, "SAMUI") then
                vRP.addUserGroup(user_id, "SAMUIP")
                vRP.Log("```prolog\n[PARAMEDICO]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[===========SAIU DE SERVICO==========] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "TOOGLE_HOSPITAL")

            elseif vRP.hasGroup(user_id, "SAMUII") then
                vRP.addUserGroup(user_id, "SAMUIIP")
                vRP.Log("```prolog\n[PARAMEDICO]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[===========SAIU DE SERVICO==========] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "TOOGLE_HOSPITAL")

            elseif vRP.hasGroup(user_id, "SAMUIII") then
                vRP.addUserGroup(user_id, "SAMUIIIP")
                vRP.Log("```prolog\n[PARAMEDICO]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[===========SAIU DE SERVICO==========] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "TOOGLE_HOSPITAL")

            elseif vRP.hasGroup(user_id, "SAMUIV") then
                vRP.addUserGroup(user_id, "SAMUIVP")
                vRP.Log("```prolog\n[PARAMEDICO]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[===========SAIU DE SERVICO==========] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "TOOGLE_HOSPITAL")

                ---------------------------------------------------
                -- MECANICAS
                ---------------------------------------------------			
            elseif vRP.hasGroup(user_id, "Bennys") then
                vRP.addUserGroup(user_id, "BennysP")
                vRP.Log("```prolog\n[MECANICO]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[===========SAIU DE SERVICO==========] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "TOOGLE_BENNYS")

            elseif vRP.hasGroup(user_id, "SportRace") then
                vRP.addUserGroup(user_id, "SportRaceP")
                vRP.Log("```prolog\n[MECANICO]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[===========SAIU DE SERVICO==========] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "TOOGLE_SPORTRACE")

                ---------------------------------------------------
                -- PVP
                ---------------------------------------------------			
            elseif vRP.hasGroup(user_id, "PVP") then
                vRP.addUserGroup(user_id, "Civil")

                ---------------------------------------------------
                -- FOUNDER
                ---------------------------------------------------			
            elseif vRP.hasGroup(user_id, "founder") then
                vRP.addUserGroup(user_id, "foundertoogle")
                vRP.Log("```prolog\n[STAFF]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[===========SAIU DE SERVICO==========] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "TOOGLE_STAFF")

                ---------------------------------------------------
                -- ADMINISTRADOR
                ---------------------------------------------------			
            elseif vRP.hasGroup(user_id, "admin") then
                vRP.addUserGroup(user_id, "admintoogle")
                vRP.Log("```prolog\n[STAFF]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[===========SAIU DE SERVICO==========] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "TOOGLE_STAFF")

                ---------------------------------------------------
                -- MODERADOR
                ---------------------------------------------------			
            elseif vRP.hasGroup(user_id, "mod") then
                vRP.addUserGroup(user_id, "modtoogle")
                vRP.Log("```prolog\n[STAFF]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[===========SAIU DE SERVICO==========] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "TOOGLE_STAFF")

                ---------------------------------------------------
                -- SUPORTE
                ---------------------------------------------------			
            elseif vRP.hasGroup(user_id, "sup") then
                vRP.addUserGroup(user_id, "suptoogle")
                vRP.Log("```prolog\n[STAFF]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[===========SAIU DE SERVICO==========] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "TOOGLE_STAFF")

                ---------------------------------------------------
                -- CONCESSIONÁRIA
                ---------------------------------------------------
            elseif vRP.hasGroup(user_id, "CONCE") then
                vRP.addUserGroup(user_id, "CONCEP")
                vRP.Log("```prolog\n[VENDEDOR]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[===========SAIU DE SERVICO==========] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "TOOGLE_CONCE")

            end
        end

        vRP.setUData(user_id, "vRP:datatable", json.encode(vRP.getUserDataTable(user_id)))
        vRP.users[vRP.rusers[user_id]] = nil
        vRP.rusers[user_id] = nil
        vRP.user_tables[user_id] = nil
        vRP.user_tmp_tables[user_id] = nil
        vRP.user_sources[user_id] = nil
    end
end

function task_save_datatables()
    SetTimeout(10000, task_save_datatables)
    TriggerEvent("vRP:save")
    Citizen.Wait(5000)
    for k, v in pairs(vRP.user_tables) do
        vRP.setUData(k, "vRP:datatable", json.encode(v))
    end
end

async(function()
    task_save_datatables()
end)

AddEventHandler("queue:playerConnecting", function(source, ids, name, setKickReason, deferrals)
    deferrals.defer()
    local source = source
    local ids = ids

    if ids ~= nil and #ids > 0 then
        deferrals.update("Carregando identidades.")
        local user_id = vRP.getUserIdByIdentifiers(ids)

        local nsource = vRP.getUserSource(user_id)
        if (nsource ~= nil) then
            if (GetPlayerName(nsource) ~= nil) then
                deferrals.done("Você está bugado, reinicie o fivem!")
                TriggerEvent("queue:playerConnectingRemoveQueues", ids)
                return
            end
        end

        if user_id then
            -- Adiciona novos identifies na tabela
            for l, w in pairs(ids) do
                if not (string.find(w, "ip:")) then
                    local row = vRP.query("vRP/userid_byidentifier", {identifier = w})
                    if not row[1] then
                        vRP.execute("vRP/add_identifier", {user_id = user_id, identifier = w})
                    end
                end
            end

            deferrals.update("Carregando banimentos.")
            if not vRP.isBanned(user_id) then
                deferrals.update("Carregando whitelist.")
                if vRP.isWhitelisted(user_id) then
                    if vRP.rusers[user_id] == nil then
                        deferrals.update("Carregando banco de dados.")
                        local sdata = vRP.getUData(user_id, "vRP:datatable")

                        vRP.users[ids[1]] = user_id
                        vRP.rusers[user_id] = ids[1]
                        vRP.user_tables[user_id] = {}
                        vRP.user_tmp_tables[user_id] = {}
                        vRP.user_sources[user_id] = source

                        local data = json.decode(sdata)
                        if type(data) == "table" then
                            vRP.user_tables[user_id] = data
                        end

                        local tmpdata = vRP.getUserTmpTable(user_id)

                        tmpdata.spawns = 0

                        vRP.execute("vRP/set_last_login", {['@user_id'] = user_id, ['@last_login'] = os.date("%d.%m.%Y"), ['@ip'] = GetPlayerEndpoint(source)})

                        TriggerEvent("vRP:playerJoin", user_id, source, name)
                        deferrals.done()
                    else
                        -- FIX PARA NÃO DEIXAR LOGAR COM ID BUGADO (MARQ)
                        if (vRP.user_sources[user_id] ~= nil) then
                            if (GetPlayerName(vRP.user_sources[user_id]) ~= nil) then
                                deferrals.done("Você está bugado, reinicie o fivem!")
                                TriggerEvent("queue:playerConnectingRemoveQueues", ids)
                                return
                            end
                        end
                        local tmpdata = vRP.getUserTmpTable(user_id)
                        tmpdata.spawns = 0

                        TriggerEvent("vRP:playerRejoin", user_id, source, name)
                        deferrals.done()
                    end
                else
                    deferrals.done("Acesse nosso Discord (https://discord.gg/fenixcity) e faça a Whitelist. Seu ID: " .. user_id)
                    -- deferrals.done("Inauguração em 19/02/2021 - Acesse nosso Discord (https://discord.gg/F3Jp5J2) e fique por dentro das novidades!  ID Temporário: "..user_id.."")
                    TriggerEvent("queue:playerConnectingRemoveQueues", ids)
                end
            else
                deferrals.done("Você foi banido da cidade.")
                TriggerEvent("queue:playerConnectingRemoveQueues", ids)
            end
        else
            deferrals.done("Ocorreu um problema de identificação.")
            TriggerEvent("queue:playerConnectingRemoveQueues", ids)
        end
    else
        deferrals.done("Ocorreu um problema de identidade.")
        TriggerEvent("queue:playerConnectingRemoveQueues", ids)
    end
end)

AddEventHandler("playerDropped", function(reason)
    local source = source
    vRP.dropPlayer(source)
end)

RegisterServerEvent("vRPcli:playerSpawned")
AddEventHandler("vRPcli:playerSpawned", function()
    local user_id = vRP.getUserId(source)
    if user_id then
        vRP.user_sources[user_id] = source
        local tmp = vRP.getUserTmpTable(user_id)
        tmp.spawns = tmp.spawns + 1
        local first_spawn = (tmp.spawns == 1)

        if first_spawn then
            for k, v in pairs(vRP.user_sources) do
                vRPclient._addPlayer(source, v)
            end
            vRPclient._addPlayer(-1, source)
            Tunnel.setDestDelay(source, 0)
        end
        TriggerEvent("vRP:playerSpawn", user_id, source, first_spawn)
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    TriggerEvent('onMySQLReady')
end)
