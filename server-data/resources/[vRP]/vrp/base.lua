local Proxy = module("lib/Proxy")
local Tunnel = module("lib/Tunnel")

local config = module("cfg/base")

vRP = {}
Proxy.addInterface("vRP",vRP)

tvRP = {}
Tunnel.bindInterface("vRP",tvRP)
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
local prepared_queries = {}
local db_initialized = false

-- WEBHOOK

local webhookpmesp = "https://discord.com/api/webhooks/809191725490110465/p7pfd4VTGWwP9d-oIHJvMGw6kzviuLJcESLYe2u3kr3_pwGFw-jiRk2OOz9uMW_4Tbcr"
local webhookpcesp = "https://discord.com/api/webhooks/809191389471571969/oITfjNkmG3YhfCxr8iPMqEOsRqgK6vsf-Rq2JKuP0SiFku2EAZ1qU_FeWFOa7lON4tOZ"
local webhookhospitalbase = "https://discord.com/api/webhooks/793597683155599380/ql-y4081JzoLAv-KwjKVFmDZLMvfVmFNSFnig6NKSyxCvsfzN51lJuui9S0rsrm8doKk"
local webhookbennys = "https://discord.com/api/webhooks/793597828386521108/UsgyanaAIxAXtNuDuP8Cbf67cauDpARltO9RxIAsGioYKolylf3TWyJl_CtTRyK5sA3O"
local webhooksportrace = "https://discord.com/api/webhooks/809191208429158421/aeVf8HgBwbKprnhaz4Za3HSirDrp6U1-ANqZUtvVlo4L_BFYvx-Jih6vPT3kSkOcJBpg"
local webhookconce = "https://discord.com/api/webhooks/809187305267920968/wOE6E6i2qerRtu8P5rn2dIGgiFy9dDzdGzZ1DGORizXtZJEkZngwaKPcstQ6ARKpXJcZ"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

function vRP.registerDBDriver(name,on_init,on_prepare,on_query)
	if not db_drivers[name] then
		db_drivers[name] = { on_init,on_prepare,on_query }

		if name == config.db.driver then
			db_driver = db_drivers[name]

			local ok = on_init(config.db)
			if ok then
				db_initialized = true
				for _,prepare in pairs(cached_prepares) do
					on_prepare(table.unpack(prepare,1,table.maxn(prepare)))
				end

				for _,query in pairs(cached_queries) do
					query[2](on_query(table.unpack(query[1],1,table.maxn(query[1]))))
				end

				cached_prepares = nil
				cached_queries = nil
			end
		end
	end
end

function vRP.format(n)
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end

function vRP.logs(archive,text)
	archive = io.open(archive,"a")
	if archive then
		archive:write(text.."\n")
	end
	archive:close()
end

function vRP.prepare(name,query)
	prepared_queries[name] = true

	if db_initialized then
		db_driver[2](name,query)
	else
		table.insert(cached_prepares,{ name,query })
	end
end

function vRP.query(name,params,mode)
	if not mode then mode = "query" end

	if db_initialized then
		return db_driver[3](name,params or {},mode)
	else
		local r = async()
		table.insert(cached_queries,{{ name,params or {},mode },r })
		return r:wait()
	end
end

function vRP.execute(name,params)
	return vRP.query(name,params,"execute")
end

vRP.prepare("vRP/create_user","INSERT INTO vrp_users(whitelisted,banned) VALUES(false,false); SELECT LAST_INSERT_ID() AS id")
vRP.prepare("vRP/add_identifier","INSERT INTO vrp_user_ids(identifier,user_id) VALUES(@identifier,@user_id)")
vRP.prepare("vRP/userid_byidentifier","SELECT user_id FROM vrp_user_ids WHERE identifier = @identifier")
vRP.prepare("vRP/set_userdata","REPLACE INTO vrp_user_data(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)")
vRP.prepare("vRP/get_userdata","SELECT dvalue FROM vrp_user_data WHERE user_id = @user_id AND dkey = @key")
vRP.prepare("vRP/set_srvdata","REPLACE INTO vrp_srv_data(dkey,dvalue) VALUES(@key,@value)")
vRP.prepare("vRP/get_srvdata","SELECT dvalue FROM vrp_srv_data WHERE dkey = @key")
vRP.prepare("vRP/get_banned","SELECT banned FROM vrp_users WHERE id = @user_id")
vRP.prepare("vRP/set_banned","UPDATE vrp_users SET banned = @banned WHERE id = @user_id")
vRP.prepare("vRP/get_whitelisted","SELECT whitelisted FROM vrp_users WHERE id = @user_id")
vRP.prepare("vRP/set_whitelisted","UPDATE vrp_users SET whitelisted = @whitelisted WHERE id = @user_id")
vRP.prepare("vRP/set_last_login","UPDATE vrp_users SET last_login = @last_login, ip = @ip WHERE id = @user_id")

function vRP.getUserIdByIdentifier(ids)
	local rows = vRP.query("vRP/userid_byidentifier",{ identifier = ids})
	if #rows > 0 then
		return rows[1].user_id
	else
		return -1
	end
end

function vRP.getUserIdByIdentifiers(ids)
	if ids and #ids then
		for i=1,#ids do
			if (string.find(ids[i],"ip:") == nil) then
				local rows = vRP.query("vRP/userid_byidentifier",{ identifier = ids[i] })
				if #rows > 0 then
					return rows[1].user_id
				end
			end
		end

		local rows,affected = vRP.query("vRP/create_user",{})

		if #rows > 0 then
			local user_id = rows[1].id
			for l,w in pairs(ids) do
				if (string.find(w,"ip:") == nil) then
					vRP.execute("vRP/add_identifier",{ user_id = user_id, identifier = w })
				end
			end
			return user_id
		end
	end
end

function vRP.isBanned(user_id)
	local rows = vRP.query("vRP/get_banned",{ user_id = user_id })
	if #rows > 0 then
		return rows[1].banned
	else
		return false
	end
end

function vRP.setBanned(user_id,banned)
	vRP.execute("vRP/set_banned",{ user_id = user_id, banned = banned })
end

function vRP.isWhitelisted(user_id)
	local rows = vRP.query("vRP/get_whitelisted",{ user_id = user_id })
	if #rows > 0 then
		return rows[1].whitelisted
	else
		return false
	end
end

function vRP.setWhitelisted(user_id,whitelisted)
	vRP.execute("vRP/set_whitelisted",{ user_id = user_id, whitelisted = whitelisted })
end

function vRP.setUData(user_id,key,value)
	vRP.execute("vRP/set_userdata",{ user_id = user_id, key = key, value = value })
end

function vRP.getUData(user_id,key)
	local rows = vRP.query("vRP/get_userdata",{ user_id = user_id, key = key })
	if #rows > 0 then
		return rows[1].dvalue
	else
		return ""
	end
end

function vRP.setSData(key,value)
	vRP.execute("vRP/set_srvdata",{ key = key, value = value })
end

function vRP.getSData(key)
	local rows = vRP.query("vRP/get_srvdata",{ key = key })
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
	for k,v in pairs(vRP.user_sources) do
		users[k] = v
	end
	return users
end

function vRP.getUserSource(user_id)
	return vRP.user_sources[user_id]
end

function vRP.kick(source,reason)
	DropPlayer(source,reason)
end

function vRP.dropPlayer(source)
	local source = source
	local user_id = vRP.getUserId(source)
	vRPclient._removePlayer(-1,source)
	if user_id then
		if user_id and source then
			TriggerEvent("vRP:playerLeave",user_id,source)
			-- Forçar para ficar à paisana quando sair
			local identity = vRP.getUserIdentity(user_id)

			---------------------------------------------------
			-- TAXISTA
			---------------------------------------------------
			if vRP.hasGroup(user_id,"Taxista") then
				vRP.removeUserGroup(user_id,"Taxista")

			---------------------------------------------------
			-- POLICIA MILITAR
			---------------------------------------------------
			elseif vRP.hasGroup(user_id,"Recruta") then
				vRP.addUserGroup(user_id,"RecrutaP")
				SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

			elseif vRP.hasGroup(user_id,"Soldado") then
				vRP.addUserGroup(user_id,"SoldadoP")
				SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

			elseif vRP.hasGroup(user_id,"Cabo") then
				vRP.addUserGroup(user_id,"CaboP")
				SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

			elseif vRP.hasGroup(user_id,"Sargento1") then
				vRP.addUserGroup(user_id,"Sargento1P")
				SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

			elseif vRP.hasGroup(user_id,"Sargento2") then
				vRP.addUserGroup(user_id,"Sargento2P")
				SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

			elseif vRP.hasGroup(user_id,"Sargento3") then
				vRP.addUserGroup(user_id,"Sargento3P")
				SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

			elseif vRP.hasGroup(user_id,"Tenente1") then
				vRP.addUserGroup(user_id,"Tenente1P")
				SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

			elseif vRP.hasGroup(user_id,"Tenente2") then
				vRP.addUserGroup(user_id,"Tenente2P")
				SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

			elseif vRP.hasGroup(user_id,"Tenente3") then
				vRP.addUserGroup(user_id,"Tenente3P")
				SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

			elseif vRP.hasGroup(user_id,"Capitao") then
				vRP.addUserGroup(user_id,"CapitaoP")
				SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

			elseif vRP.hasGroup(user_id,"Coronel") then
				vRP.addUserGroup(user_id,"CoronelP")
				SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

			elseif vRP.hasGroup(user_id,"General") then
				vRP.addUserGroup(user_id,"GeneralP")
				SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

			elseif vRP.hasGroup(user_id,"Instrutor") then
				vRP.addUserGroup(user_id,"InstrutorP")
				SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

			elseif vRP.hasGroup(user_id,"Suplente") then
				vRP.addUserGroup(user_id,"SuplenteP")
				SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

			elseif vRP.hasGroup(user_id,"Subcomando") then
				vRP.addUserGroup(user_id,"SubcomandoP")
				SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

			elseif vRP.hasGroup(user_id,"Recruta") then
				vRP.addUserGroup(user_id,"RecrutaP")
				SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

			elseif vRP.hasGroup(user_id,"Comandante") then
				vRP.addUserGroup(user_id,"ComandanteP")
				SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

			elseif vRP.hasGroup(user_id,"PRF") then
				vRP.addUserGroup(user_id,"PRFP")
				SendWebhookMessage(webhookpmesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

			---------------------------------------------------
			-- POLICIA CIVIL
			---------------------------------------------------
			elseif vRP.hasGroup(user_id,"Agente") then
				vRP.addUserGroup(user_id,"AgenteP")
				SendWebhookMessage(webhookpcesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			
			elseif vRP.hasGroup(user_id,"Inspetor") then
				vRP.addUserGroup(user_id,"InspetorP")
				SendWebhookMessage(webhookpcesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			
			elseif vRP.hasGroup(user_id,"Investigador") then
				vRP.addUserGroup(user_id,"InvestigadorP")
				SendWebhookMessage(webhookpcesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			
			elseif vRP.hasGroup(user_id,"Delegado") then
				vRP.addUserGroup(user_id,"DelegadoP")
				SendWebhookMessage(webhookpcesp,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			
			---------------------------------------------------
			-- HOSPITAL
			---------------------------------------------------
			elseif vRP.hasGroup(user_id,"Enfermeiro") then
				vRP.addUserGroup(user_id,"PaisanaEnfermeiro")
				SendWebhookMessage(webhookhospitalbase,"```prolog\n[PARAMEDICO]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			
			elseif vRP.hasGroup(user_id,"Medico") then
				vRP.addUserGroup(user_id,"PaisanaMedico")
				SendWebhookMessage(webhookhospitalbase,"```prolog\n[PARAMEDICO]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")	
			
			elseif vRP.hasGroup(user_id,"Diretor") then
				vRP.addUserGroup(user_id,"PaisanaDiretor")
				SendWebhookMessage(webhookhospitalbase,"```prolog\n[PARAMEDICO]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")	

			---------------------------------------------------
			-- MECANICAS
			---------------------------------------------------			
			elseif vRP.hasGroup(user_id,"Bennys") then
				vRP.addUserGroup(user_id,"BennysP")
				SendWebhookMessage(webhookbennys,"```prolog\n[MECANICO]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

			elseif vRP.hasGroup(user_id,"SportRace") then
				vRP.addUserGroup(user_id,"SportRaceP")
				SendWebhookMessage(webhooksportrace,"```prolog\n[MECANICO]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

			---------------------------------------------------
			-- CONCESSIONÁRIA
			---------------------------------------------------
			elseif vRP.hasGroup(user_id,"CONCE") then
				vRP.addUserGroup(user_id,"CONCEP")
				SendWebhookMessage(webhookconce,"```prolog\n[VENDEDOR]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			
			end
		end

		vRP.setUData(user_id,"vRP:datatable",json.encode(vRP.getUserDataTable(user_id)))
		vRP.users[vRP.rusers[user_id]] = nil
		vRP.rusers[user_id] = nil
		vRP.user_tables[user_id] = nil
		vRP.user_tmp_tables[user_id] = nil
		vRP.user_sources[user_id] = nil
	end
end

function task_save_datatables()
	SetTimeout(10000,task_save_datatables)
	TriggerEvent("vRP:save")
	for k,v in pairs(vRP.user_tables) do
		vRP.setUData(k,"vRP:datatable",json.encode(v))
	end
end

async(function()
	task_save_datatables()
end)

AddEventHandler("queue:playerConnecting",function(source,ids,name,setKickReason,deferrals)
	deferrals.defer()
	local source = source
	local ids = ids

	if ids ~= nil and #ids > 0 then
		deferrals.update("Carregando identidades.")
		local user_id = vRP.getUserIdByIdentifiers(ids)

		local nsource = vRP.getUserSource(user_id)
		local nuser_id = vRP.getUserId(nsource)
		if(nsource~=nil and nuser_id~=nil)then
		  deferrals.done("Bug corrigido by MQCU")
		  TriggerEvent("queue:playerConnectingRemoveQueues",ids)
		  return
		end
		
		if user_id then
			-- Adiciona novos identifies na tabela
			for l,w in pairs(ids) do
			   if not (string.find(w,"ip:")) then
			      local row = vRP.query("vRP/userid_byidentifier"
			             ,{ identifier = w })            
			      if not row[1] then
			        vRP.execute("vRP/add_identifier"
			             ,{ user_id = user_id, identifier = w })
			      end    
			   end
			end

			deferrals.update("Carregando banimentos.")
			if not vRP.isBanned(user_id) then
				 deferrals.update("Carregando whitelist.")
				 if vRP.isWhitelisted(user_id) then
					if vRP.rusers[user_id] == nil then
						deferrals.update("Carregando banco de dados.")
						local sdata = vRP.getUData(user_id,"vRP:datatable")

						vRP.users[ids[1]] = user_id
						vRP.rusers[user_id] = ids[1]
						vRP.user_tables[user_id] = {}
						vRP.user_tmp_tables[user_id] = {}
						vRP.user_sources[user_id] = source

						local data = json.decode(sdata)
						if type(data) == "table" then vRP.user_tables[user_id] = data end

						local tmpdata = vRP.getUserTmpTable(user_id)

						tmpdata.spawns = 0

						vRP.execute("vRP/set_last_login",{ user_id = user_id, last_login = os.date("%d.%m.%Y"), ip = GetPlayerEndpoint(source) })

						TriggerEvent("vRP:playerJoin",user_id,source,name)
						deferrals.done()
					else
						local tmpdata = vRP.getUserTmpTable(user_id)
						tmpdata.spawns = 0

						TriggerEvent("vRP:playerRejoin",user_id,source,name)
						deferrals.done()
					end
				else
					-- deferrals.done("Acesse nosso Discord (https://discord.gg/F3Jp5J2) para realizar a liberação. Seu ID: "..user_id)
					deferrals.done("Inauguração em 19/02/2021 - Acesse nosso Discord (https://discord.gg/F3Jp5J2) e fique por dentro das novidades!")
					TriggerEvent("queue:playerConnectingRemoveQueues",ids)
				end
			else
				deferrals.done("Você foi banido da cidade.")
				TriggerEvent("queue:playerConnectingRemoveQueues",ids)
			end
		else
			deferrals.done("Ocorreu um problema de identificação.")
			TriggerEvent("queue:playerConnectingRemoveQueues",ids)
		end
	else
		deferrals.done("Ocorreu um problema de identidade.")
		TriggerEvent("queue:playerConnectingRemoveQueues",ids)
	end
end)

AddEventHandler("playerDropped",function(reason)
	local source = source
	vRP.dropPlayer(source)
end)

RegisterServerEvent("vRPcli:playerSpawned")
AddEventHandler("vRPcli:playerSpawned",function()
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.user_sources[user_id] = source
		local tmp = vRP.getUserTmpTable(user_id)
		tmp.spawns = tmp.spawns+1
		local first_spawn = (tmp.spawns == 1)

		if first_spawn then
			for k,v in pairs(vRP.user_sources) do
				vRPclient._addPlayer(source,v)
			end
			vRPclient._addPlayer(-1,source)
			Tunnel.setDestDelay(source,0)
		end
		TriggerEvent("vRP:playerSpawn",user_id,source,first_spawn)
	end
end)