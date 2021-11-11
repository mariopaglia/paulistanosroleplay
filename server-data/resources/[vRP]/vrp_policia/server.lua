local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local Tools = module("vrp", "lib/Tools")
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
-- local webhookpmesp = "https://discord.com/api/webhooks/809191725490110465/p7pfd4VTGWwP9d-oIHJvMGw6kzviuLJcESLYe2u3kr3_pwGFw-jiRk2OOz9uMW_4Tbcr"
-- local webhookpcesp = "https://discord.com/api/webhooks/809892713758851092/wMGCoBzvyLhAJM2k2_gTKfIMWGNgLoGtqhEp3oJEgCd7ChsAdr67zsGSaDBo4p-Gy9Ig"
-- local webhookapreender = "https://discord.com/api/webhooks/809195069248372756/RHFtPdKE1vNSUSAeYA7sF1qMJHSE8XRU0-Z6fStQ9c1Yhv7I5Ud8bkxMyjIXFfTkKzAK"
-- local webhookmultas = "https://discord.com/api/webhooks/809195388212478053/muZa0KZ_0MPzOSHdf9DQTWG3CE-i4hovfs1e3MlwP78CUbH6IuYNWBu93KRTEdL6eYJN"
-- local webhookparamedico = "https://discord.com/api/webhooks/793597683155599380/ql-y4081JzoLAv-KwjKVFmDZLMvfVmFNSFnig6NKSyxCvsfzN51lJuui9S0rsrm8doKk"
-- local webhookbennys = "https://discord.com/api/webhooks/793597828386521108/UsgyanaAIxAXtNuDuP8Cbf67cauDpARltO9RxIAsGioYKolylf3TWyJl_CtTRyK5sA3O"
-- local webhooksportrace = "https://discord.com/api/webhooks/809191208429158421/aeVf8HgBwbKprnhaz4Za3HSirDrp6U1-ANqZUtvVlo4L_BFYvx-Jih6vPT3kSkOcJBpg"
-- local webhookprender = "https://discord.com/api/webhooks/809192611272720444/2fNnIhLub2cFHqmbqKr5K8tLSVx4EQZXZcKjHqmbR-EitNlHjVdvpe4zcR_eflXf7Nup"
-- local webhookdetido = "https://discord.com/api/webhooks/809192685256704010/m7ZhD49uRRXQv29tITj8i0kigzoCJHLKaUY-R9xkQF45X5MERx2XBfjH-qCvHMyr_AdE"
-- local webhookre = "https://discord.com/api/webhooks/801625540917723156/GObuH96poB7LSHB-wtzjaVH8dgOf-adONt1EaBKtHs215eaQgLIult4XGimjQBxKefKX"
-- local webhookconce = "https://discord.com/api/webhooks/809187305267920968/wOE6E6i2qerRtu8P5rn2dIGgiFy9dDzdGzZ1DGORizXtZJEkZngwaKPcstQ6ARKpXJcZ"
-- local webhookprf = "https://discord.com/api/webhooks/820696422675906560/elQ-WS7J7VEEVHXSMTIGNBUGdab-yYORqIxsooqhdj4ynwTYPK4AIwkPeT1VdAyOauB6"
-- local webhookrota = "https://discord.com/api/webhooks/820698946245492766/kdCmczOoX3DVNvGsAhwxtrY5OR9wkTa3gSZFoib6HsGuXF7Oy8shcKc7UkEPsOIeApFK"
-- local webhookdic = "https://discord.com/api/webhooks/867470805986574346/c-nsvapMVxjSaPC4_6JmsnVGsX6TNjNcV7MbZROdK6fxh4KFotTvkBp_i4zfwyJGFhr5"
-- local webhooktentativaapreender = "https://discord.com/api/webhooks/876149024305053746/GaPJCPzdBsIz_BfnOW3wZ3bMHWb9KRIB96BBaSEFrAK_y9YE4LfNAW54WqYZfuZDvQqy"
-- local webhooktooglestaff = "https://discord.com/api/webhooks/877567284598693908/uqbZqlB7CDwJ-o9eSR23naEQgE0WF378AUPqtqZctZZw_-Uf1zwOgD6X3G3EswohOfs9"

-- function SendWebhookMessage(webhook,message)
-- 	if webhook ~= nil and webhook ~= "" then
-- 		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
-- 	end
-- end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARSENAL
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand('arsenal',function(source,args,rawCommand)
-- 	local user_id = vRP.getUserId(source)
-- 	if vRP.hasPermission(user_id,"policia.permissao") then
-- 		TriggerClientEvent('arsenal',source)
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLACA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('placa', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "placa.permissao") or vRP.hasPermission(user_id, "policia.permissao") then
        if args[1] then
            local user_id = vRP.getUserByRegistration(args[1])
            if user_id then
                local identity = vRP.getUserIdentity(user_id)
                if identity then
                    vRPclient.playSound(source, "Event_Message_Purple", "GTAO_FM_Events_Soundset")
                    TriggerClientEvent("Notify", source, "policia", "<b>INFORMAÇÕES DO VEÍCULO</b><br>Passaporte: <b>" .. identity.user_id .. "</b> <br> Placa: <b>" .. identity.registration .. "</b> <br> Proprietário: <b>" .. identity.name .. " " .. identity.firstname .. "</b> <br> Idade: <b>" .. identity.age .. "</b> <br> Telefone: <b>" .. identity.phone.."</b>", 20000)
                    TriggerClientEvent('chatMessage', source, "CENTRAL:",{65,130,255}, "^1Passaporte: ^0" .. identity.user_id .. "   ^2|   ^1Placa: ^0" .. identity.registration .. "   ^2|   ^1Proprietário: ^0" .. identity.name .. " " .. identity.firstname .. "   ^2|   ^1Idade: ^0" .. identity.age .. " anos   ^2|   ^1Telefone: ^0" .. identity.phone)
                end
            else
                TriggerClientEvent("Notify", source, "importante", "Placa inválida ou veículo de americano.")
            end
        else
            local vehicle, vnetid, placa, vname, lock, banned = vRPclient.vehList(source, 7)
            local placa_user = vRP.getUserByRegistration(placa)
            if placa then
                if placa_user then
                    local identity = vRP.getUserIdentity(placa_user)
                    if identity then
                        local vehicleName = vRP.vehicleName(vname)
                        vRPclient.playSound(source, "Event_Message_Purple", "GTAO_FM_Events_Soundset")
                        TriggerClientEvent("Notify", source, "policia", "<b>INFORMAÇÕES DO VEÍCULO</b><br>Passaporte: <b>" .. identity.user_id .. "</b> <br> Placa: <b>" .. identity.registration .. "</b> <br> Proprietário: <b>" .. identity.name .. " " .. identity.firstname .. "</b> <br> Idade: <b>" .. identity.age .. "</b> <br> Telefone: <b>" .. identity.phone.."</b>", 20000)
                        TriggerClientEvent('chatMessage', source, "CENTRAL:",{65,130,255}, "^1Passaporte: ^0" .. identity.user_id .. "   ^2|   ^1Placa: ^0" .. identity.registration .. "   ^2|   ^1Placa: ^0" .. identity.registration .. "   ^2|   ^1Proprietário: ^0" .. identity.name .. " " .. identity.firstname .. "   ^2|   ^1Modelo: ^0" .. vehicleName ..
                            "   ^2|   ^1Idade: ^0" .. identity.age .. " anos   ^2|   ^1Telefone: ^0" .. identity.phone)
                    end
                else
                    TriggerClientEvent("Notify", source, "importante", "Placa inválida ou veículo de americano.")
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYTOW
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand('paytow',function(source,args,rawCommand)
-- 	local user_id = vRP.getUserId(source)
-- 	if vRP.hasPermission(user_id,"policia.permissao") then
-- 		local nplayer = vRPclient.getNearestPlayer(source,2)
-- 		if nplayer then
-- 			local nuser_id = vRP.getUserId(nplayer)
-- 			if nuser_id then
-- 				vRP.giveMoney(nuser_id,500)
-- 				vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
-- 				TriggerClientEvent("Notify",source,"sucesso","Efetuou o pagamento pelo serviço do mecânico.")
-- 				TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>$500 dólares</b> pelo serviço de mecânico.")
-- 				vRP.logs("savedata/paytow.txt","[ID]: "..user_id.." / [NID]: "..nuser_id.." / [FUNÇÃO]: Paytow")
-- 			end
-- 		end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOOGLE
-----------------------------------------------------------------------------------------------------------------------------------------
local toogleTimer = {}

RegisterCommand('toogle', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
	TriggerEvent("toogleWork",user_id,true)
end)

local permissions = {
	---------------------
    -- PMFC I
    ---------------------
	{
		['workOn'] = {
			['hasPermission'] = "pmfci.permissao",
			['toAdd'] = "PMFCIP",
		},
		['workOff'] = {
			['hasPermission'] = "pmfcip.permissao",
			['toAdd'] = "PMFCI",
		},
		['replaceWeapons'] = true,
		['eblips'] = {['color'] = 47,['name'] = "Policial"},
		['webhook'] = "TOOGLE_POLICIA",
	},
	---------------------
    -- PMFC II
    ---------------------
	{
		['workOn'] = {
			['hasPermission'] = "pmfcii.permissao",
			['toAdd'] = "PMFCIIP",
		},
		['workOff'] = {
			['hasPermission'] = "pmfciip.permissao",
			['toAdd'] = "PMFCII",
		},
		['replaceWeapons'] = true,
		['eblips'] = {['color'] = 47,['name'] = "Policial"},
		['webhook'] = "TOOGLE_POLICIA",
	},
	---------------------
    -- PMFC III
    ---------------------
	{
		['workOn'] = {
			['hasPermission'] = "pmfciii.permissao",
			['toAdd'] = "PMFCIIIP",
		},
		['workOff'] = {
			['hasPermission'] = "pmfciiip.permissao",
			['toAdd'] = "PMFCIII",
		},
		['replaceWeapons'] = true,
		['eblips'] = {['color'] = 47,['name'] = "Policial"},
		['webhook'] = "TOOGLE_POLICIA",
	},
	---------------------
    -- PMFC IV
    ---------------------
	{
		['workOn'] = {
			['hasPermission'] = "pmfciv.permissao",
			['toAdd'] = "PMFCIVP",
		},
		['workOff'] = {
			['hasPermission'] = "pmfcivp.permissao",
			['toAdd'] = "PMFCIV",
		},
		['replaceWeapons'] = true,
		['eblips'] = {['color'] = 47,['name'] = "Policial"},
		['webhook'] = "TOOGLE_POLICIA",
	},
	---------------------
    -- DIC I
    ---------------------
	{
		['workOn'] = {
			['hasPermission'] = "dici.permissao",
			['toAdd'] = "DICIP",
		},
		['workOff'] = {
			['hasPermission'] = "dicip.permissao",
			['toAdd'] = "DICI",
		},
		['replaceWeapons'] = true,
		['eblips'] = {['color'] = 47,['name'] = "Policial"},
		['webhook'] = "TOOGLE_DIC",
	},
	---------------------
    -- DIC II
    ---------------------
	{
		['workOn'] = {
			['hasPermission'] = "dicii.permissao",
			['toAdd'] = "DICIIP",
		},
		['workOff'] = {
			['hasPermission'] = "diciip.permissao",
			['toAdd'] = "DICII",
		},
		['replaceWeapons'] = true,
		['eblips'] = {['color'] = 47,['name'] = "Policial"},
		['webhook'] = "TOOGLE_DIC",
	},
	---------------------
    -- DIC III
    ---------------------
	{
		['workOn'] = {
			['hasPermission'] = "diciii.permissao",
			['toAdd'] = "DICIIIP",
		},
		['workOff'] = {
			['hasPermission'] = "diciiip.permissao",
			['toAdd'] = "DICIII",
		},
		['replaceWeapons'] = true,
		['eblips'] = {['color'] = 47,['name'] = "Policial"},
		['webhook'] = "TOOGLE_DIC",
	},
	---------------------
    -- DIC IV
    ---------------------
	{
		['workOn'] = {
			['hasPermission'] = "diciv.permissao",
			['toAdd'] = "DICIVP",
		},
		['workOff'] = {
			['hasPermission'] = "dicivp.permissao",
			['toAdd'] = "DICIV",
		},
		['replaceWeapons'] = true,
		['eblips'] = {['color'] = 47,['name'] = "Policial"},
		['webhook'] = "TOOGLE_DIC",
	},
	---------------------
    -- SAMU I
    ---------------------
	{
		['workOn'] = {
			['hasPermission'] = "samui.permissao",
			['toAdd'] = "SAMUIP",
		},
		['workOff'] = {
			['hasPermission'] = "samuip.permissao",
			['toAdd'] = "SAMUI",
		},
		['eblips'] = {['color'] = 48,['name'] = "SAMU"},
		['webhook'] = "TOOGLE_HOSPITAL",
	},
	---------------------
    -- SAMU II
    ---------------------
	{
		['workOn'] = {
			['hasPermission'] = "samuii.permissao",
			['toAdd'] = "SAMUIIP",
		},
		['workOff'] = {
			['hasPermission'] = "samuiip.permissao",
			['toAdd'] = "SAMUII",
		},
		['eblips'] = {['color'] = 48,['name'] = "SAMU"},
		['webhook'] = "TOOGLE_HOSPITAL",
	},
	---------------------
    -- SAMU III
    ---------------------
	{
		['workOn'] = {
			['hasPermission'] = "samuiii.permissao",
			['toAdd'] = "SAMUIIIP",
		},
		['workOff'] = {
			['hasPermission'] = "samuiiip.permissao",
			['toAdd'] = "SAMUIII",
		},
		['eblips'] = {['color'] = 48,['name'] = "SAMU"},
		['webhook'] = "TOOGLE_HOSPITAL",
	},
	---------------------
    -- SAMU IV
    ---------------------
	{
		['workOn'] = {
			['hasPermission'] = "samuiv.permissao",
			['toAdd'] = "SAMUIVP",
		},
		['workOff'] = {
			['hasPermission'] = "samuivp.permissao",
			['toAdd'] = "SAMUIV",
		},
		['eblips'] = {['color'] = 48,['name'] = "SAMU"},
		['webhook'] = "TOOGLE_HOSPITAL",
	},
	---------------------
    -- VENDEDOR CONCESSIONÁRIA
    ---------------------
	{
		['workOn'] = {
			['hasPermission'] = "concessionaria.permissao",
			['toAdd'] = "CONCEP",
		},
		['workOff'] = {
			['hasPermission'] = "vendedorpaisana.permissao",
			['toAdd'] = "CONCE",
		},
		['webhook'] = "TOOGLE_CONCE",
	},
	---------------------
    -- MECANICO
    ---------------------
	{
		['workOn'] = {
			['hasPermission'] = "bennys.permissao",
			['toAdd'] = "BennysP",
		},
		['workOff'] = {
			['hasPermission'] = "paisanabennys.permissao",
			['toAdd'] = "Bennys",
		},
		['webhook'] = "TOOGLE_BENNYS",
	},
	---------------------
    -- SPORTRACEL
    ---------------------
	{
		['workOn'] = {
			['hasPermission'] = "sportracel.permissao",
			['toAdd'] = "SportRaceLP",
		},
		['workOff'] = {
			['hasPermission'] = "sportracelp.permissao",
			['toAdd'] = "SportRaceL",
		},
		['webhook'] = "TOOGLE_SPORTRACE",
	},
	---------------------
    -- SPORTRACE
    ---------------------
	{
		['workOn'] = {
			['hasPermission'] = "sportrace.permissao",
			['toAdd'] = "SportRaceP",
		},
		['workOff'] = {
			['hasPermission'] = "paisanasportrace.permissao",
			['toAdd'] = "SportRace",
		},
		['webhook'] = "TOOGLE_SPORTRACE",
	},
	---------------------
    -- BEANMACHINE
    ---------------------
	{
		['workOn'] = {
			['hasPermission'] = "beanmachine.permissao",
			['toAdd'] = "BeanmachineP",
		},
		['workOff'] = {
			['hasPermission'] = "beanmachinetoogle.permissao",
			['toAdd'] = "Beanmachine",
		},
	},
    {
		['workOn'] = {
			['hasPermission'] = "taxista.permissao",
			['toRemove'] = "Taxista",
		},
	},
    {
		['workOn'] = {
			['hasPermission'] = "pvp.permissao",
			['toAdd'] = "Civil",
		},
	},
    {
		['workOn'] = {
			['hasPermission'] = "founder.permissao",
			['toAdd'] = "foundertoogle",
		},
        ['webhook'] = "TOOGLE_STAFF",
	},
    {
		['workOn'] = {
			['hasPermission'] = "admin.permissao",
			['toAdd'] = "admintoogle",
		},
        ['webhook'] = "TOOGLE_STAFF",
	},
    {
		['workOn'] = {
			['hasPermission'] = "mod.permissao",
			['toAdd'] = "modtoogle",
		},
        ['webhook'] = "TOOGLE_STAFF",
	},
    {
		['workOn'] = {
			['hasPermission'] = "sup.permissao",
			['toAdd'] = "suptoogle",
		},
        ['webhook'] = "TOOGLE_STAFF",
	},
    {
		['workOn'] = {
			['hasPermission'] = "conce.permissao",
			['toAdd'] = "CONCEP",
		},
        ['webhook'] = "TOOGLE_CONCE",
	},
}
RegisterServerEvent("toogleWork")
AddEventHandler("toogleWork",function(user_id,status)
	local source = vRP.getUserSource(user_id)
	local identity = vRP.getUserIdentity(user_id)
	if status then
		for k,v in pairs(permissions) do
            if v['workOn'] and v['workOff'] then
                if vRP.hasPermission(user_id,v['workOn']['hasPermission']) then
                    if not toogleTimer[user_id] then
                        toogleTimer[user_id] = os.time()
                    end
                    local totalTime = (convertTime(os.time() - toogleTimer[user_id]) or "00:00:00")

                    if v['eblips'] then TriggerEvent('eblips:remove', source) end
                    if v['replaceWeapons'] then vRPclient.replaceWeapons(source,{}) end
                    if v['workOn']['toAdd'] then vRP.addUserGroup(user_id,v['workOn']['toAdd']) end

                    TriggerClientEvent("Notify", source, "sucesso", "Você saiu de serviço.")
                    if v['webhook'] then
                        vRP.Log("```prolog\n[FUNCIONARIO]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[===========SAIU DE SERVICO==========] \n[TEMPO TOTAL EM SERVICO]: "..totalTime..""..os.date("\n[ENTRADA]: %H:%M:%S %d/%m/%Y",toogleTimer[user_id]).." "..os.date("\n[SAIDA]: %H:%M:%S %d/%m/%Y").." \r```", v['webhook'])
                    end
                    toogleTimer[user_id] = nil
                    TriggerClientEvent('desligarRadios', source)
                    return
                elseif vRP.hasPermission(user_id,v['workOff']['hasPermission']) then
                    if v['eblips'] then
                        TriggerEvent('eblips:add', {name = v['eblips']['name'], src = source, color = v['eblips']['color']})
                    end
                    if v['webhook'] then
                        vRP.Log("```prolog\n[FUNCIONARIO]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[===========ENTROU EM SERVICO==========]  "..os.date("\n[ENTRADA]: %H:%M:%S %d/%m/%Y").." \r```", v['webhook'])
                    end
                    TriggerClientEvent("Notify", source, "sucesso", "Você entrou em serviço.")
                    vRP.addUserGroup(user_id,v['workOff']['toAdd'])
                    toogleTimer[user_id] = os.time()
                    return
                end
            end
		end
	else
		for k,v in pairs(permissions) do
			if vRP.hasPermission(user_id,v['workOn']['hasPermission']) then
                if not toogleTimer[user_id] then
                    toogleTimer[user_id] = os.time()
                end
				local totalTime = (convertTime(os.time() - toogleTimer[user_id]) or "00:00:00")
                if v['workOn']['toAdd'] then vRP.addUserGroup(user_id,v['workOn']['toAdd']) end
                if v['workOn']['toRemove'] then vRP.removeUserGroup(user_id,v['workOn']['toRemove']) end
				if v['webhook'] then
					vRP.Log("```prolog\n[FUNCIONARIO]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[===========SAIU DE SERVICO==========] \n[TEMPO TOTAL EM SERVICO]: "..totalTime..""..os.date("\n[ENTRADA]: %H:%M:%S %d/%m/%Y",toogleTimer[user_id]).." "..os.date("\n[SAIDA]: %H:%M:%S %d/%m/%Y").." \r```", v['webhook'])
				end
				toogleTimer[user_id] = nil
			end
		end
        TriggerEvent("setNil",user_id)
	end
end)

function convertTime(seconds)
    local hours = math.floor(seconds/3600)
    seconds = seconds - hours * 3600
    local minutes = math.floor(seconds/60)
    seconds = seconds - minutes * 60

	if hours < 10 then
		hours = "0"..hours
	end
	if minutes < 10 then
		minutes = "0"..minutes
	end
	if seconds < 10 then
		seconds = "0"..seconds
	end

    if parseInt(hours) > 0 then
        return ""..hours..":"..minutes..":"..seconds..""
    elseif parseInt(minutes) > 0 then
        return "00:"..minutes..":"..seconds..""
    elseif parseInt(seconds) > 0 then
        return "00:00:"..seconds..""
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOOGLE PROMOTERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('promoter', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    ---------------------
    -- BEANMACHINE
    ---------------------
    if vRP.hasPermission(user_id, "beanmachine.permissao") then
        vRP.addUserGroup(user_id, "BeanmachineP")
        TriggerClientEvent("Notify", source, "sucesso", "Você saiu de serviço.")

    elseif vRP.hasPermission(user_id, "beanmachinetoogle.permissao") then
        vRP.addUserGroup(user_id, "Beanmachine")
        TriggerClientEvent("Notify", source, "sucesso", "Você entrou em serviço.")

    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOOGLE STAFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rp', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    ---------------------
    -- FOUNDER
    ---------------------
    if vRP.hasPermission(user_id, "founder.permissao") then
        vRP.addUserGroup(user_id, "foundertoogle")
        TriggerClientEvent("Notify", source, "sucesso", "Você saiu de serviço de Staff.")
        vRP.Log("```prolog\n[STAFF]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[===========SAIU DE SERVICO==========] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "TOOGLE_STAFF")
    elseif vRP.hasPermission(user_id, "founder.toogle") then
        vRP.addUserGroup(user_id, "founder")
        TriggerClientEvent("Notify", source, "sucesso", "Você entrou de serviço de Staff.")
        vRP.Log("```prolog\n[STAFF]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[==========ENTROU EM SERVICO=========] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "TOOGLE_STAFF")
        ---------------------
        -- ADMINISTRADOR
        ---------------------
    elseif vRP.hasPermission(user_id, "admin.permissao") then
        vRP.addUserGroup(user_id, "admintoogle")
        TriggerClientEvent("Notify", source, "sucesso", "Você saiu de serviço de Staff.")
        vRP.Log("```prolog\n[STAFF]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[===========SAIU DE SERVICO==========] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "TOOGLE_STAFF")
    elseif vRP.hasPermission(user_id, "admin.toogle") then
        vRP.addUserGroup(user_id, "admin")
        TriggerClientEvent("Notify", source, "sucesso", "Você entrou de serviço de Staff.")
        vRP.Log("```prolog\n[STAFF]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[==========ENTROU EM SERVICO=========] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "TOOGLE_STAFF")
        ---------------------
        -- MODERADOR
        ---------------------
    elseif vRP.hasPermission(user_id, "mod.permissao") then
        vRP.addUserGroup(user_id, "modtoogle")
        TriggerClientEvent("Notify", source, "sucesso", "Você saiu de serviço de Staff.")
        vRP.Log("```prolog\n[STAFF]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[===========SAIU DE SERVICO==========] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "TOOGLE_STAFF")
    elseif vRP.hasPermission(user_id, "mod.toogle") then
        vRP.addUserGroup(user_id, "mod")
        TriggerClientEvent("Notify", source, "sucesso", "Você entrou de serviço de Staff.")
        vRP.Log("```prolog\n[STAFF]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[==========ENTROU EM SERVICO=========] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "TOOGLE_STAFF")
        ---------------------
        -- SUPORTE
        ---------------------
    elseif vRP.hasPermission(user_id, "sup.permissao") then
        vRP.addUserGroup(user_id, "suptoogle")
        TriggerClientEvent("Notify", source, "sucesso", "Você saiu de serviço de Staff.")
        vRP.Log("```prolog\n[STAFF]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[===========SAIU DE SERVICO==========] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "TOOGLE_STAFF")
    elseif vRP.hasPermission(user_id, "sup.toogle") then
        vRP.addUserGroup(user_id, "sup")
        TriggerClientEvent("Notify", source, "sucesso", "Você entrou de serviço de Staff.")
        vRP.Log("```prolog\n[STAFF]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[==========ENTROU EM SERVICO=========] " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "TOOGLE_STAFF")
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- MULTAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('multar', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "policia.permissao") then
        local id = vRP.prompt(source, "Passaporte:", "")
        local valor = vRP.prompt(source, "Valor:", "")
        local motivo = vRP.prompt(source, "Motivo:", "")
        if id == "" or valor == "" or motivo == "" then
            return
        end
        local value = vRP.getUData(parseInt(id), "vRP:multas")
        local multas = json.decode(value) or 0
        vRP.setUData(parseInt(id), "vRP:multas", json.encode(parseInt(multas) + parseInt(valor)))
        local oficialid = vRP.getUserIdentity(user_id)
        local identity = vRP.getUserIdentity(parseInt(id))
        local nplayer = vRP.getUserSource(parseInt(id))
        vRP.Log("```prolog\n[OFICIAL]: " .. user_id .. " " .. oficialid.name .. " " .. oficialid.firstname .. " \n[==============MULTOU==============] \n[PASSAPORTE]: " .. id .. " " .. identity.name .. " " .. identity.firstname .. " \n[VALOR]: R$ " .. vRP.format(parseInt(valor)) .. " \n[MOTIVO]: " .. motivo .. " " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "CMD_MULTAR")

        randmoney = math.random(100, 500)
        vRP.giveMoney(user_id, parseInt(randmoney))
        TriggerClientEvent("Notify", source, "sucesso", "Multa aplicada com sucesso.")
        TriggerClientEvent("Notify", source, "importante", "Você recebeu <b>R$ " .. vRP.format(parseInt(randmoney)) .. "</b> de bonificação.")
        TriggerClientEvent("Notify", nplayer, "importante", "Você foi multado em <b>R$ " .. vRP.format(parseInt(valor)) .. "</b>.<br><b>Motivo:</b> " .. motivo .. ".")
        vRPclient.playSound(source, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- REANIMAR
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand('reanimar',function(source,args,rawCommand)
-- 	local user_id = vRP.getUserId(source)
-- 	if vRP.hasPermission(user_id,"paramedico.permissao") then
-- 		TriggerClientEvent('reanimar',source)
-- 	end
-- end)

-- RegisterServerEvent("reanimar:pagamento")
-- AddEventHandler("reanimar:pagamento",function()
-- 	local user_id = vRP.getUserId(source)
-- 	if user_id then
-- 		pagamento = math.random(50,80)
-- 		vRP.giveMoney(user_id,pagamento)
-- 		TriggerClientEvent("Notify",source,"sucesso","Recebeu <b>$"..pagamento.." dólares</b> de gorjeta do americano.")
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DETIDO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('detido', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "policia.permissao") then
        local vehicle, vnetid, placa, vname, lock, banned = vRPclient.vehList(source, 5)
        local motivo = vRP.prompt(source, "Motivo:", "")
        if motivo == "" then
            return
        end
        local oficialid = vRP.getUserIdentity(user_id)
        if vehicle then
            local puser_id = vRP.getUserByRegistration(placa)
            local rows = vRP.query("creative/get_vehicles", {user_id = parseInt(puser_id), vehicle = vname})
            if rows[1] then
                if parseInt(rows[1].detido) == 1 then
                    TriggerClientEvent("Notify", source, "importante", "Este veículo já se encontra detido.", 8000)
                else
                    local identity = vRP.getUserIdentity(puser_id)
                    local nplayer = vRP.getUserSource(parseInt(puser_id))
                    local crds = GetEntityCoords(GetPlayerPed(source))
                    vRP.Log("```prolog\n[OFICIAL]: " .. user_id .. " " .. oficialid.name .. " " .. oficialid.firstname .. " \n[==============PRENDEU==============] \n[CARRO]: " .. vname .. " \n[PASSAPORTE]: " .. puser_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[MOTIVO]: " .. motivo .. "\n[COORDENADA]: " .. crds.x .. "," .. crds.y .. "," .. crds.z .. "" ..
                                os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "CMD_DETIDO")
                    vRP.execute("creative/set_detido", {user_id = parseInt(puser_id), vehicle = vname, detido = 1, time = parseInt(os.time())})

                    randmoney = math.random(100, 500)
                    vRP.giveMoney(user_id, parseInt(randmoney))
                    TriggerClientEvent("Notify", source, "sucesso", "Veículo apreendido com sucesso.")
                    TriggerClientEvent("Notify", source, "importante", "Você recebeu <b>R$ " .. vRP.format(parseInt(randmoney)) .. "</b> de bonificação.")
                    TriggerClientEvent("Notify", nplayer, "importante", "Seu Veículo foi <b>Detido</b>.<br><b>Motivo:</b> " .. motivo .. ".")
                    vRPclient.playSound(source, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
                end
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PRENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('prender', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "policia.permissao") then
        local player = vRP.getUserSource(parseInt(args[1]))
        vRP.setUData(parseInt(args[1]), "vRP:prisao", json.encode(parseInt(args[2])))
        vRPclient.setHandcuffed(player, false)
        local crimes = vRP.prompt(source, "Crimes:", "")
        if crimes == "" then
            return
        end
        TriggerClientEvent('prisioneiro', player, true)
        vRPclient._playSound(source, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
        TriggerClientEvent("vrp_sound:source", player, 'jaildoor', 1)
        vRPclient.teleport(player, 712.08, 111.49, 80.76)

        local oficialid = vRP.getUserIdentity(user_id)
        local identity = vRP.getUserIdentity(parseInt(args[1]))
        local nplayer = vRP.getUserSource(parseInt(args[1]))
        vRP.Log("```prolog\n[OFICIAL]: " .. user_id .. " " .. oficialid.name .. " " .. oficialid.firstname .. " \n[==============PRENDEU==============] \n[PASSAPORTE]: " .. (args[1]) .. " " .. identity.name .. " " .. identity.firstname .. " \n[TEMPO]: " .. vRP.format(parseInt(args[2])) .. " Meses \n[CRIMES]: " .. crimes .. " " .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```",
            "CMD_PRENDER")

        randmoney = math.random(500, 2000)
        vRP.giveMoney(user_id, parseInt(randmoney))
        TriggerClientEvent("Notify", source, "sucesso", "Prisão efetuada com sucesso, você recebeu <b>R$ " .. vRP.format(parseInt(randmoney)) .. "</b> de bonificação")
        TriggerClientEvent("Notify", player, "importante", "Você foi preso pelos seguintes crimes: <b>" .. crimes .. "</b>")
        prison_lock(parseInt(args[1]))
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PRENDER POR ADV (SOMENTE ADM)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('prenderadv', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "kick.permissao") then
        local player = vRP.getUserSource(parseInt(args[1]))
        if player then
            vRP.setUData(parseInt(args[1]), "vRP:prisao", json.encode(parseInt(args[2])))
            vRPclient.setHandcuffed(player, false)
            local crimes = vRP.prompt(source, "Crimes:", "")
            if crimes == "" then
                return
            end
            TriggerClientEvent('prisioneiro', player, true)
            vRPclient._playSound(source, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
            TriggerClientEvent("vrp_sound:source", player, 'jaildoor', 1)
            vRPclient.teleport(player, 712.08, 111.49, 80.76)
            TriggerClientEvent("Notify", source, "sucesso", "Prisão efetuada com sucesso!")
            TriggerClientEvent("Notify", player, "importante", "Você foi preso pelos seguintes crimes: <b>" .. crimes .. "</b>")
            prison_lock(parseInt(args[1]))
        else
            vRP.setUData(parseInt(args[1]), "vRP:prisao", json.encode(parseInt(args[2])))
            TriggerClientEvent("Notify", source, "sucesso", "O player <b>não está online</b> porém foi <b>preso com sucesso</b>!")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /RG (DESABILITADO - PODIA VER TANTO DE PERTO COMO VIA PARAMETRO, SUBSTITUIDO PELO /RG2 PARA STAFF)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand('rg',function(source,args,rawCommand)
-- 	local user_id = vRP.getUserId(source)
-- 	if vRP.hasPermission(user_id,"polpar.permissao") then
-- 		if args[1] then
-- 			local nplayer = vRP.getUserSource(parseInt(args[1]))
-- 			if nplayer == nil then
-- 				TriggerClientEvent("Notify",source,"aviso","Passaporte <b>"..vRP.format(args[1]).."</b> indisponível no momento.")
-- 				return
-- 			end
-- 			nuser_id = vRP.getUserId(nplayer)
-- 			if nuser_id then
-- 				local value = vRP.getUData(nuser_id,"vRP:multas")
-- 				local valormultas = json.decode(value) or 0
-- 				local identity = vRP.getUserIdentity(nuser_id)
-- 				local carteira = vRP.getMoney(nuser_id)
-- 				local banco = vRP.getBankMoney(nuser_id)
-- 				vRPclient.setDiv(source,"completerg",".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 13px; font-family: arial; color: #fff; width: 420px; padding: 20px 20px 5px; bottom: 25%; right: 20px; position: absolute; border: 1px solid rgba(255,255,255,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local2 { width: 200px; padding-bottom: 15px; float: left; } .local b, .local2 b { color: #00BFFF; }","<div class=\"local\"><b>Nome:</b> "..identity.name.." "..identity.firstname.." ( "..vRP.format(identity.user_id).." )</div><div class=\"local2\"><b>Identidade:</b> "..identity.registration.."</div><div class=\"local\"><b>Idade:</b> "..identity.age.." Anos</div><div class=\"local2\"><b>Telefone:</b> "..identity.phone.."</div><div class=\"local\"><b>Multas pendentes:</b> "..vRP.format(parseInt(valormultas)).."</div><div class=\"local2\"><b>Carteira:</b> "..vRP.format(parseInt(carteira)).."</div>")
-- 				vRP.request(source,"Você deseja fechar o registro geral?",1000)
-- 				vRPclient.removeDiv(source,"completerg")
-- 			end
-- 		else
-- 			local nplayer = vRPclient.getNearestPlayer(source,2)
-- 			local nuser_id = vRP.getUserId(nplayer)
-- 			if nuser_id then
-- 				local value = vRP.getUData(nuser_id,"vRP:multas")
-- 				local valormultas = json.decode(value) or 0
-- 				local identityv = vRP.getUserIdentity(user_id)
-- 				local identity = vRP.getUserIdentity(nuser_id)
-- 				local carteira = vRP.getMoney(nuser_id)
-- 				local banco = vRP.getBankMoney(nuser_id)
-- 				TriggerClientEvent("Notify",nplayer,"importante","Seu documento está sendo verificado por <b>"..identityv.name.." "..identityv.firstname.."</b>.")
-- 				vRPclient.setDiv(source,"completerg",".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 13px; font-family: arial; color: #fff; width: 420px; padding: 20px 20px 5px; bottom: 25%; right: 20px; position: absolute; border: 1px solid rgba(255,255,255,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local2 { width: 200px; padding-bottom: 15px; float: left; } .local b, .local2 b { color: #00BFFF; }","<div class=\"local\"><b>Nome:</b> "..identity.name.." "..identity.firstname.." ( "..vRP.format(identity.user_id).." )</div><div class=\"local2\"><b>Identidade:</b> "..identity.registration.."</div><div class=\"local\"><b>Idade:</b> "..identity.age.." Anos</div><div class=\"local2\"><b>Telefone:</b> "..identity.phone.."</div><div class=\"local\"><b>Multas pendentes:</b> "..vRP.format(parseInt(valormultas)).."</div><div class=\"local2\"><b>Carteira:</b> "..vRP.format(parseInt(carteira)).."</div>")
-- 				vRP.request(source,"Você deseja fechar o registro geral?",1000)
-- 				vRPclient.removeDiv(source,"completerg")
-- 			end
-- 		end
-- 	end
-- end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /RG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rg', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "polpar.permissao") then
        local nplayer = vRPclient.getNearestPlayer(source, 2)
        local nuser_id = vRP.getUserId(nplayer)
		if nuser_id == nil then
			TriggerClientEvent("Notify", source, "aviso", "Você precisa estar próximo da pessoa para pegar o RG")
			return
		end
        if nuser_id then
            local value = vRP.getUData(nuser_id, "vRP:multas")
            local valormultas = json.decode(value) or 0
            local value2 = vRP.getUData(nuser_id, "vRP:prisao")
            local reuPrimario = json.decode(value2) or 0
            local identityv = vRP.getUserIdentity(user_id)
            local identity = vRP.getUserIdentity(nuser_id)
            local carteira = vRP.getMoney(nuser_id)
            local banco = vRP.getBankMoney(nuser_id)


			if reuPrimario == "" or reuPrimario == nil or reuPrimario == 0 then
				reuPrimario = "Sim (30% Redução)"
			else
				reuPrimario = "Não (0% Redução)"
			end
			
            TriggerClientEvent("Notify", nplayer, "importante", "Seu documento está sendo verificado por <b>" .. identityv.name .. " " .. identityv.firstname .. "</b>.")
            vRPclient.setDiv(source, "completerg",
                ".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 13px; font-family: arial; color: #fff; width: 420px; padding: 20px 20px 5px; bottom: 25%; right: 20px; position: absolute; border: 1px solid rgba(255,255,255,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local2 { width: 200px; padding-bottom: 15px; float: left; } .local b, .local2 b { color: #00BFFF; }",
                "<div class=\"local\"><b>Nome:</b> " .. identity.name .. " " .. identity.firstname .. " ( " .. vRP.format(identity.user_id) .. " )</div><div class=\"local2\"><b>Identidade:</b> " .. identity.registration .. "</div><div class=\"local\"><b>Idade:</b> " .. identity.age .. " Anos</div><div class=\"local2\"><b>Telefone:</b> " .. identity.phone ..
                    "</div><div class=\"local\"><b>Multas pendentes:</b> R$ " .. vRP.format(parseInt(valormultas)) .. "</div><div class=\"local2\"><b>Réu Primário:</b> " .. reuPrimario .. "</div>")
            vRP.request(source, "Você deseja fechar o registro geral?", 1000)
            vRPclient.removeDiv(source, "completerg")
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ALGEMAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('algemar', function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "founder.permissao") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if vRPclient.isHandcuffed(nplayer) then
                vRPclient.toggleHandcuff(nplayer)
            else
                vRPclient.toggleHandcuff(nplayer)
            end
        else
            local nplayer = source
            if vRPclient.isHandcuffed(nplayer) then
                vRPclient.toggleHandcuff(nplayer)
            else
                vRPclient.toggleHandcuff(nplayer)
            end
        end
    end
end)

RegisterServerEvent("vrp_policia:algemar")
AddEventHandler("vrp_policia:algemar", function()
    local source = source
    local user_id = vRP.getUserId(source)
    local nplayer = vRPclient.getNearestPlayer(source, 2)
    if nplayer then
        if not vRPclient.isHandcuffed(source) then
            if vRP.getInventoryItemAmount(user_id, "algemas") >= 1 then
                if vRPclient.isHandcuffed(nplayer) then
                    TriggerClientEvent('carregar', nplayer, source)
                    vRPclient._playAnim(source, false, {{"mp_arresting", "a_uncuff"}}, false)
                    SetTimeout(5000, function()
                        vRPclient.toggleHandcuff(nplayer)
                        TriggerClientEvent('carregar', nplayer, source)
                        TriggerClientEvent("vrp_sound:source", source, 'uncuff', 0.1)
                        TriggerClientEvent("vrp_sound:source", nplayer, 'uncuff', 0.1)
                        TriggerClientEvent('removealgemas', nplayer)
                    end)
                else
                    TriggerClientEvent('cancelando', source, true)
                    TriggerClientEvent('cancelando', nplayer, true)
                    TriggerClientEvent('carregar', nplayer, source)
                    vRPclient._playAnim(source, false, {{"mp_arrest_paired", "cop_p2_back_left"}}, false)
                    vRPclient._playAnim(nplayer, false, {{"mp_arrest_paired", "crook_p2_back_left"}}, false)
                    SetTimeout(3500, function()
                        vRPclient._stopAnim(source, false)
                        vRPclient.toggleHandcuff(nplayer)
                        TriggerClientEvent('carregar', nplayer, source)
                        TriggerClientEvent('cancelando', source, false)
                        TriggerClientEvent('cancelando', nplayer, false)
                        TriggerClientEvent("vrp_sound:source", source, 'cuff', 0.1)
                        TriggerClientEvent("vrp_sound:source", nplayer, 'cuff', 0.1)
                        TriggerClientEvent('setalgemas', nplayer)
                    end)
                end
            else
                if vRP.hasPermission(user_id, "policia.permissao") then
                    if vRPclient.isHandcuffed(nplayer) then
                        TriggerClientEvent('carregar', nplayer, source)
                        vRPclient._playAnim(source, false, {{"mp_arresting", "a_uncuff"}}, false)
                        SetTimeout(5000, function()
                            vRPclient.toggleHandcuff(nplayer)
                            TriggerClientEvent('carregar', nplayer, source)
                            TriggerClientEvent("vrp_sound:source", source, 'uncuff', 0.1)
                            TriggerClientEvent("vrp_sound:source", nplayer, 'uncuff', 0.1)
                            TriggerClientEvent('removealgemas', nplayer)
                        end)
                    else
                        TriggerClientEvent('cancelando', source, true)
                        TriggerClientEvent('cancelando', nplayer, true)
                        TriggerClientEvent('carregar', nplayer, source)
                        vRPclient._playAnim(source, false, {{"mp_arrest_paired", "cop_p2_back_left"}}, false)
                        vRPclient._playAnim(nplayer, false, {{"mp_arrest_paired", "crook_p2_back_left"}}, false)
                        SetTimeout(3500, function()
                            vRPclient._stopAnim(source, false)
                            vRPclient.toggleHandcuff(nplayer)
                            TriggerClientEvent('carregar', nplayer, source)
                            TriggerClientEvent('cancelando', source, false)
                            TriggerClientEvent('cancelando', nplayer, false)
                            TriggerClientEvent("vrp_sound:source", source, 'cuff', 0.1)
                            TriggerClientEvent("vrp_sound:source", nplayer, 'cuff', 0.1)
                            TriggerClientEvent('setalgemas', nplayer)
                        end)
                    end
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARREGAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vrp_policia:carregar")
AddEventHandler("vrp_policia:carregar", function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "polpar.permissao") then
        local nplayer = vRPclient.getNearestPlayer(source, 10)
        if nplayer then
            TriggerClientEvent('carregar', nplayer, source)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RMASCARA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rmascara', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "polpar.permissao") then
        local nplayer = vRPclient.getNearestPlayer(source, 2)
        if nplayer then
            TriggerClientEvent('rmascara', nplayer)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RCHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rchapeu', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "polpar.permissao") then
        local nplayer = vRPclient.getNearestPlayer(source, 2)
        if nplayer then
            TriggerClientEvent('rchapeu', nplayer)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RCAPUZ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rcapuz', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "polpar.permissao") then
        local nplayer = vRPclient.getNearestPlayer(source, 2)
        if nplayer then
            if vRPclient.isCapuz(nplayer) then
                vRPclient.setCapuz(nplayer)
                TriggerClientEvent("Notify", source, "sucesso", "Capuz colocado com sucesso.")
            else
                TriggerClientEvent("Notify", source, "importante", "A pessoa não está com o capuz na cabeça.")
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CARD
-----------------------------------------------------------------------------------------------------------------------------------------
-- local pulso = nil
-- local upulso = nil
-- RegisterCommand('vida',function(source,args,rawCommand)
--	local user_id = vRP.getUserId(source)
--	local nplayer = vRPclient.getNearestPlayer(source,2)
--	local nuser_id = vRP.getUserId(nplayer)
--	if vRP.hasPermission(user_id,"paramedico.permissao") then
--		if nuser_id and vRPclient.isInComa(nplayer) then
--			if upulso ~= nuser_id then
--				upulso = nuser_id
--				pulso = math.random(1,100)
--				if pulso >= 30 then
--					TriggerClientEvent("Notify",source,"importante","Essa pessoa ainda tem pulso.")
--					TriggerClientEvent("Notify",nplayer,"importante","Você está pulsando.")
--				elseif pulso <= 29 then
--					TriggerClientEvent("Notify",source,"importante","Essa infelizmente não tem mais pulso.")
--					TriggerClientEvent("Notify",nplayer,"importante","Você não tem mais pulso.")
--				end
--			else
--				TriggerClientEvent("Notify",source,"importante","Você ja mediu o pulso dessa pessoa.")
--			end
--		else
--			TriggerClientEvent("Notify",source,"importante","A pessoa deve estar em coma para prosseguir")
--		end
--	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RE wally teste
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('re', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "paramedico.permissao") then
        local nplayer = vRPclient.getNearestPlayer(source, 2)
        local nuser_id = vRP.getUserId(nplayer)
        if nplayer then
            local identity = vRP.getUserIdentity(user_id)
            local identityu = vRP.getUserIdentity(nuser_id)
            local crds = GetEntityCoords(GetPlayerPed(source))
            if vRPclient.isInComa(nplayer) then
                TriggerClientEvent('cancelando', source, true)
                vRPclient._playAnim(source, false, {{"amb@medic@standing@tendtodead@base", "base"}, {"mini@cpr@char_a@cpr_str", "cpr_pumpchest"}}, true)
                TriggerClientEvent("progress", source, 30000, "reanimando")
                SetTimeout(30000, function()
                    vRPclient.killGod(nplayer)
                    vRPclient.setHealth(nplayer, 150)
                    if vRP.getHunger(nuser_id) > 80 then
                    vRP.varyHunger(nuser_id,-20)
                    end
                    if vRP.getThirst(nuser_id) > 80 then
                        vRP.varyThirst(nuser_id,-20)
                    end
                    vRPclient._stopAnim(source, false)
                    vRPclient._stopAnim(nplayer, false)
                    TriggerClientEvent('cancelando', source, false)
                    vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[REVIVEU]: " .. nuser_id .. " " .. identityu.name .. " " .. identityu.firstname .. "\n[COORDENADA]: " .. crds.x .. "," .. crds.y .. "," .. crds.z .. "" .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```", "CMD_REANIMAR")
                end)
            else
                TriggerClientEvent("Notify", source, "importante", "A pessoa precisa estar em coma para prosseguir.")
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RE
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand('re',function(source,args,rawCommand)
--	local user_id = vRP.getUserId(source)
--	if vRP.hasPermission(user_id,"paramedico.permissao") then
--		local nplayer = vRPclient.getNearestPlayer(source,2)
--		local nuser_id = vRP.getUserId(nplayer)
--		if nplayer then
--			local identity = vRP.getUserIdentity(user_id)
--			local identityu = vRP.getUserIdentity(nuser_id)
--			local crds = GetEntityCoords(GetPlayerPed(source))
--			if vRPclient.isInComa(nplayer) and pulso >= 30 then
--				TriggerClientEvent('cancelando',source,true)
--				vRPclient._playAnim(source,false,{{"amb@medic@standing@tendtodead@base","base"},{"mini@cpr@char_a@cpr_str","cpr_pumpchest"}},true)
--				TriggerClientEvent("progress",source,30000,"reanimando")
--				SetTimeout(30000,function()
--					vRPclient.killGod(nplayer)
--					vRPclient.setHealth(nplayer,150)
--					vRPclient._stopAnim(source,false)
--					vRPclient._stopAnim(nplayer,false)
--					vRP.giveMoney(user_id,500)
--					TriggerClientEvent('cancelando',source,false)
--					pulso = nil
--					upulso = 0
--					SendWebhookMessage(webhookre,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[REVIVEU]: "..nuser_id.." "..identityu.name.." "..identityu.firstname.."\n[COORDENADA]: "..crds.x..","..crds.y..","..crds.z..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
--				end)
--			elseif pulso == nil then
--				TriggerClientEvent("Notify",source,"importante","Utilize /vida para medir o pulso.")
--			elseif pulso <= 29 then
--				TriggerClientEvent("Notify",source,"importante","A pessoa nao tem mais pulso.")
--			else
--				TriggerClientEvent("Notify",source,"importante","A pessoa precisa estar em coma para prosseguir.")
--			end
--		end
--	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cv', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "polpar.permissao") then
        local nplayer = vRPclient.getNearestPlayer(source, 10)
        if nplayer then
            vRPclient.putInNearestVehicleAsPassenger(nplayer, 7)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rv', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "polpar.permissao") then
        local nplayer = vRPclient.getNearestPlayer(source, 10)
        if nplayer then
            vRPclient.ejectVehicle(nplayer)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXTRAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('extras', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "policia.permissao") then
        if vRPclient.isInVehicle(source) then
            TriggerClientEvent('extras', source)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYEXTRAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryextras")
AddEventHandler("tryextras", function(index, extra)
    TriggerClientEvent("syncextras", -1, index, parseInt(extra))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cone', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "polpar.permissao") then
        TriggerClientEvent('cone', source, args[1])
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARREIRA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('barreira', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "polpar.permissao") then
        TriggerClientEvent('barreira', source, args[1])
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPIKE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('spike', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "policia.permissao") then
        TriggerClientEvent('spike', source, args[1])
    end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------
-- DISPAROS SERVER.LUA
--------------------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('atirando')
AddEventHandler('atirando', function(x, y, z)
    local user_id = vRP.getUserId(source)
    if GetPlayerRoutingBucket(source) == 0 then
        if user_id then
            if not vRP.hasPermission(user_id, "policia.permissao") then
                local policiais = vRP.getUsersByPermission("policia.permissao")
                for l, w in pairs(policiais) do
                    local player = vRP.getUserSource(w)
                    if player then
                        TriggerClientEvent('notificacao', player, x, y, z, user_id)
                    end
                end
            end
        end
    end
end)

RegisterServerEvent('atirandolog')
AddEventHandler('atirandolog', function(x, y, z)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if user_id then
        if not vRP.hasPermission(user_id, "policia.permissao") then
            vRP.Log("```prolog\n[ID]: " .. user_id .. " " .. identity.name .. " " .. identity.firstname .. " \n[EFETUOU DISPAROS DE ARMA DE FOGO] \n[LOCAL]: " .. x .. "," .. y .. "," .. z .. " " .. os.date("\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S") .. " \r```", "DISPAROS")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANUNCIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('anuncio', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "polpar.permissao") then
        local identity = vRP.getUserIdentity(user_id)
        local mensagem = vRP.prompt(source, "Mensagem:", "")
        if mensagem == "" then
            return
        end
        vRPclient.setDiv(-1, "anuncio", ".div_anuncio { background: rgba(0,128,192,0.8); font-size: 11px; font-family: arial; color: #fff; padding: 20px; bottom: 50%; right: 20px; max-width: 600px; position: absolute; -webkit-border-radius: 5px; } bold { font-size: 15px; }", "<bold>" .. mensagem .. "</bold><br><br>Mensagem enviada por: " .. identity.name .. " " .. identity.firstname)
        SetTimeout(30000, function()
            vRPclient.removeDiv(-1, "anuncio")
        end)
    end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------
-- PRISÃO
--------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    local player = vRP.getUserSource(parseInt(user_id))
    if player then
        SetTimeout(30000, function()
            local value = vRP.getUData(parseInt(user_id), "vRP:prisao")
            local tempo = json.decode(value) or 0

            if tempo == -1 then
                return
            end

            if tempo > 0 then
                TriggerClientEvent('prisioneiro', player, true)
                vRPclient.teleport(player, 712.08, 111.49, 80.76)
                TriggerClientEvent("Notify", player, "importante", "Você está preso e ainda vai passar <b>" .. parseInt(tempo) .. " meses</b> na cadeia")
                prison_lock(parseInt(user_id))
            end
        end)
    end
end)

function prison_lock(target_id)
    local player = vRP.getUserSource(parseInt(target_id))
    if player then
        SetTimeout(60000, function()
            local value = vRP.getUData(parseInt(target_id), "vRP:prisao")
            local tempo = json.decode(value) or 0
            if parseInt(tempo) >= 1 then
                TriggerClientEvent("Notify", player, "importante", "Ainda vai passar <b>" .. parseInt(tempo) .. " meses</b> preso")
                vRP.setUData(parseInt(target_id), "vRP:prisao", json.encode(parseInt(tempo) - 1))
                prison_lock(parseInt(target_id))
            elseif parseInt(tempo) == 0 then
                TriggerClientEvent('prisioneiro', player, false)
                vRPclient.teleport(player, 741.67, 134.32, 80.41)
                vRP.setUData(parseInt(target_id), "vRP:prisao", json.encode(-1))
                TriggerClientEvent("Notify", player, "importante", "Sua sentença terminou, esperamos não ve-lo novamente")
            end
            if vRPclient.getHealth(player) <= 100 then
                vRPclient.killGod(player)
            end
        end)
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DIMINUIR PENA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("diminuirpena1372391")
AddEventHandler("diminuirpena1372391", function()
    local source = source
    local user_id = vRP.getUserId(source)
    local value = vRP.getUData(parseInt(user_id), "vRP:prisao")
    local tempo = json.decode(value) or 0
    if tempo >= 10 then
        vRP.setUData(parseInt(user_id), "vRP:prisao", json.encode(parseInt(tempo) - 2))
        TriggerClientEvent("Notify", source, "importante", "Sua pena foi reduzida em <b>2 meses</b>, continue o trabalho")
    else
        TriggerClientEvent("Notify", source, "importante", "Atingiu o limite da redução de pena, não precisa mais trabalhar")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- P
-----------------------------------------------------------------------------------------------------------------------------------------
local policia = {}
RegisterCommand('p', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local uplayer = vRP.getUserSource(user_id)
    local identity = vRP.getUserIdentity(user_id)
    local x, y, z = vRPclient.getPosition(source)
    if vRPclient.getHealth(source) > 100 then
        if vRP.hasPermission(user_id, "policia.permissao") then
            local soldado = vRP.getUsersByPermission("policia.permissao")
            for l, w in pairs(soldado) do
                local player = vRP.getUserSource(parseInt(w))
                if player and player ~= uplayer then
                    async(function()
                        local id = idgens:gen()
                        policia[id] = vRPclient.addBlip(player, x, y, z, 161, 84, "Localização de " .. identity.name .. " " .. identity.firstname, 0.5, false)
                        TriggerClientEvent("Notify", player, "importante", "Localização recebida de <b>" .. identity.name .. " " .. identity.firstname .. "</b>.")
                        vRPclient._playSound(player, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
                        SetTimeout(60000, function()
                            vRPclient.removeBlip(player, policia[id])
                            idgens:free(id)
                        end)
                    end)
                end
            end
            TriggerClientEvent("Notify", source, "sucesso", "Localização enviada com sucesso.")
            vRPclient.playSound(source, "Event_Message_Purple", "GTAO_FM_Events_Soundset")
        end
    else
        TriggerClientEvent("Notify", source, "negado", "Você não pode enviar sua localização desmaiado/morto")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pd', function(source, args, rawCommand)
    if args[1] then
        local user_id = vRP.getUserId(source)
        local identity = vRP.getUserIdentity(user_id)
        local permission = "policia.permissao"
        if vRP.hasPermission(user_id, permission) then
            local soldado = vRP.getUsersByPermission(permission)
            for l, w in pairs(soldado) do
                local player = vRP.getUserSource(parseInt(w))
                if player then
                    async(function()
                        TriggerClientEvent('chatMessage', player, identity.name .. " " .. identity.firstname .. " [" .. user_id .. "]: ", {64, 179, 255}, rawCommand:sub(3))
                    end)
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PTR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ptr', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    local oficiais = vRP.getUsersByPermission("pmesp.permissao")
    local paramedicos = 0
    local oficiais_nomes = ""
    if vRP.hasPermission(user_id, "policia.permissao") or vRP.hasPermission(user_id, "kick.permissao") then
        for k, v in ipairs(oficiais) do
            local identity = vRP.getUserIdentity(parseInt(v))
            oficiais_nomes = oficiais_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
            paramedicos = paramedicos + 1
        end
        TriggerClientEvent("Notify", source, "importante", "Atualmente <b>" .. paramedicos .. " Oficiais</b> em serviço.")
        if parseInt(paramedicos) > 0 then
            TriggerClientEvent("Notify", source, "importante", oficiais_nomes)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- HOSPITAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('medicos', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    local oficiais = vRP.getUsersByPermission("paramedico.permissao")
    local paramedicos = 0
    local paramedicos_nomes = ""
    if vRP.hasPermission(user_id, "paramedico.permissao") or vRP.hasPermission(user_id, "kick.permissao") then
        for k, v in ipairs(oficiais) do
            local identity = vRP.getUserIdentity(parseInt(v))
            paramedicos_nomes = paramedicos_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
            paramedicos = paramedicos + 1
        end
        TriggerClientEvent("Notify", source, "importante", "Atualmente <b>" .. paramedicos .. " Paramédicos</b> em serviço.")
        if parseInt(paramedicos) > 0 then
            TriggerClientEvent("Notify", source, "importante", paramedicos_nomes)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /STAFF - VERIFICA APENAS STAFFS EM SERVIÇO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('staff', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    local oficiais = vRP.getUsersByPermission("kick.permissao")
    local staffs = 0
    local staff_nomes = ""
    if vRP.hasPermission(user_id, "staff.permissao") then
        for k, v in ipairs(oficiais) do
            local identity = vRP.getUserIdentity(parseInt(v))
            staff_nomes = staff_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
            staffs = staffs + 1
        end
        TriggerClientEvent("Notify", source, "importante", "Atualmente <b>" .. staffs .. " Staff</b> em serviço.")
        if parseInt(staffs) > 0 then
            TriggerClientEvent("Notify", source, "importante", staff_nomes)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /STAFF2 - VERIFICA TODOS OS STAFFS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('staff2', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    local oficiais = vRP.getUsersByPermission("staff.permissao")
    local staffs = 0
    local staff_nomes = ""
    if vRP.hasPermission(user_id, "staff.permissao") then
        for k, v in ipairs(oficiais) do
            local identity = vRP.getUserIdentity(parseInt(v))
            staff_nomes = staff_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
            staffs = staffs + 1
        end
        TriggerClientEvent("Notify", source, "importante", "Atualmente <b>" .. staffs .. " Staff</b> em serviço.")
        if parseInt(staffs) > 0 then
            TriggerClientEvent("Notify", source, "importante", staff_nomes)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /MECANICOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mecanicos', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    local oficiais = vRP.getUsersByPermission("mecanico.permissao")
    local mecanicos = 0
    local mecanicos_nomes = ""
    if vRP.hasPermission(user_id, "kick.permissao") then
        for k, v in ipairs(oficiais) do
            local identity = vRP.getUserIdentity(parseInt(v))
            mecanicos_nomes = mecanicos_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
            mecanicos = mecanicos + 1
        end
        TriggerClientEvent("Notify", source, "importante", "Atualmente <b>" .. mecanicos .. " Mecanicos</b> em serviço.")
        if parseInt(mecanicos) > 0 then
            TriggerClientEvent("Notify", source, "importante", mecanicos_nomes)
        end
    end
end)
