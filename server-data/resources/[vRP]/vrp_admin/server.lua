local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vADMC = Tunnel.getInterface("vrp_admin","vrp_admin")

local webhookaddremcar = "https://discord.com/api/webhooks/795671123299663893/-CZgy7czgUO7BeEHlYJpdCm00mxjG11oSrEHkhUC1r2mmXgGm93p9vq4VWp6gTzyi9vK"
local webhookmoney = "https://discord.com/api/webhooks/795667756493963304/4Azax194qMKWm6y1KfADk8ernA8YpUF1CKWvHdlaG2tNSd_NHhy3-fycr9RvpTAp41qa"
local webhookcarros = "https://discord.com/api/webhooks/793197093690671134/CVTPwlTgBR2CVOKsyTEXCXau6KX4L8eZFijtmOY06S6wnCs2BRh3urrUUut3NzHPWQi2"
local webhookgrupos = "https://discord.com/api/webhooks/795669087896338462/QeH-0wMplpMq8pfvuxIlA_XmQKyWcERkOzy0c5yBjLidBa7W6EkndzS-ul4s4hq3t33-"
local webhookcmdgod = "https://discord.com/api/webhooks/797212560821977100/0gudVRGoejjBJrrKGrYRREhIbnMpD5Ts1s4MqPivDoGLS4vXIuqci9n6jinY5pXv40VG"
local webhookfac = "https://discord.com/api/webhooks/809981445413666827/bkCHxarpInZ3p8KccORt1PKVqjwUaeeGRHyLerogeOW0y486XXyxSfOl8Vlvc51KWVb6"
local webhookeconomia = "https://discord.com/api/webhooks/811814703176089672/h_NGmW7k60R5DyH23-Q958bk0NdTjelpmNupK5ekk4sLF0o6jxj4UAZKRGpVQN73TZry"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

vRP._prepare("vRP/money_rank",
             "SELECT SUM(wallet+bank) AS total,user_id FROM vrp.vrp_user_moneys GROUP BY user_id ORDER BY total DESC LIMIT 50")

vRP._prepare("vRP/total_economia","SELECT SUM(wallet+bank) AS economia FROM vrp.vrp_user_moneys")

-- RegisterServerEvent("Economia")
-- AddEventHandler("Economia",function()
-- 	local source = source
-- 	local carteira = vRP.query("vRP/money_rank")
-- 	local economia = vRP.query("vRP/total_economia")
--     local msg = ""
--     for k,v in pairs(carteira) do
--         msg=msg.."ID: "..v.user_id.." => Total: R$ "..vRP.format(parseInt(v.total)).."\n" 
--     end
-- 	SendWebhookMessage(webhookeconomia,"```prolog\nRELATORIO DE ECONOMIA: "..os.date("%d/%m/%Y - %H:%M:%S").."``` ```prolog\n"..msg.."```")
-- 	economiatotal = ""
-- 	for k,v in pairs(economia) do
-- 		economiatotal=economiatotal.."Economia atual: R$ "..vRP.format(parseInt(v.economia)).."\n"
-- 	end
-- 	SendWebhookMessage(webhookeconomia,"```prolog\n"..economiatotal.."```")
-- end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60*60000)
		local source = source
		local carteira = vRP.query("vRP/money_rank")
		local economia = vRP.query("vRP/total_economia")
    	local msg = ""
    	for k,v in pairs(carteira) do
    	    msg=msg.."ID: "..v.user_id.." => Total: R$ "..vRP.format(parseInt(v.total)).."\n" 
    	end
		SendWebhookMessage(webhookeconomia,"```prolog\nRELATORIO DE ECONOMIA: "..os.date("%d/%m/%Y - %H:%M:%S").."``` ```prolog\n"..msg.."```")
		economiatotal = ""
		for k,v in pairs(economia) do
			economiatotal=economiatotal.."Economia atual: R$ "..vRP.format(parseInt(v.economia)).."\n"
		end
		SendWebhookMessage(webhookeconomia,"```prolog\n"..economiatotal.."```")
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pon',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        local users = vRP.getUsers()
        local players = ""
        local quantidade = 0
        for k,v in pairs(users) do
            if k ~= #users then
                players = players..", "
            end
            players = players..k
            quantidade = quantidade + 1
        end
        TriggerClientEvent('chatMessage',source,"TOTAL ONLINE",{0,191,255},quantidade)
        TriggerClientEvent('chatMessage',source,"ID's ONLINE",{0,191,255},players)
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('debug',function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		if vRP.hasPermission(user_id,"admin.permissao") then
			TriggerClientEvent("ToggleDebug",player)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEVEH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteveh")
AddEventHandler("trydeleteveh",function(index)
	TriggerClientEvent("syncdeleteveh",-1,index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEPED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteped")
AddEventHandler("trydeleteped",function(index)
	TriggerClientEvent("syncdeleteped",-1,index)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAR INVENTARIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('limparinv',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
        vRP.clearInventory(user_id)
        TriggerClientEvent("Notify",source,"importante","Seu <b>inventario</b> foi limpo.")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVIVER TODOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteped")
RegisterCommand('reviveall', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        local rusers = vRP.getUsers()
        for k,v in pairs(rusers) do
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
AddEventHandler("trydeleteobj",function(index)
	TriggerClientEvent("syncdeleteobj",-1,index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('fix',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"fix.permissao") then
		local vehicle = vRPclient.getNearestVehicle(source,7)
		if vehicle then
			TriggerClientEvent('reparar2',source,vehicle)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('limparea',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPosition(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
		TriggerClientEvent("syncarea",-1,x,y,z)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('god',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRP.getUserSource(parseInt(args[1]))
	local identity = vRP.getUserIdentity(user_id)
	local crds = GetEntityCoords(GetPlayerPed(source))
	if vRP.hasPermission(user_id,"god.permissao") then
		if args[1] then
			if nplayer then
				local raio = vRPclient.getNearestPlayers(nplayer,50)
				for k, v in pairs(raio) do
					vADMC._showGodHeart(k, nplayer)
				end
				vADMC._showGodHeart(nplayer, nplayer)
				local nuser_id = vRP.getUserId(nplayer)
				local identitynu = vRP.getUserIdentity(nuser_id)
				
				vRPclient.killGod(nplayer)
				vRPclient._stopAnim(nplayer,false)
				vRPclient.setHealth(nplayer,400)
				SendWebhookMessage(webhookcmdgod,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GOD EM]: "..nuser_id.." "..identitynu.name.." "..identitynu.firstname.."\n[COORDENADA]: "..crds.x..","..crds.y..","..crds.z..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```") 
			end
		else
			local raio = vRPclient.getNearestPlayers(source,30)
			for k, v in pairs(raio) do
				vADMC._showGodHeart(k, source)
			end
			vADMC._showGodHeart(source, source)
			vRPclient._stopAnim(source,false)
			vRPclient.killGod(source)
			vRPclient.setHealth(source,400) -- Vida
			-- vRPclient.setArmour(source,100) -- Colete
			SendWebhookMessage(webhookcmdgod,"```prolog\n[GOD PROPRIO]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[COORDENADA]: "..crds.x..","..crds.y..","..crds.z..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD ALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('godall',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"founder.permissao") then
    	local users = vRP.getUsers()
        for k,v in pairs(users) do
            local id = vRP.getUserSource(parseInt(k))
            if id then
            	vRPclient.killGod(id)
				vRPclient.setHealth(id,400)
				-- vRPclient.setArmour(source,100)
				print(id)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ESTOQUE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('estoque',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        if args[1] and args[2] then
            vRP.execute("creative/set_estoque",{ vehicle = args[1], quantidade = args[2] })
            TriggerClientEvent("Notify",source,"sucesso","Voce colocou mais <b>"..args[2].."</b> no estoque, para o carro <b>"..args[1].."</b>.") 
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addcar',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRP.getUserId(parseInt(args[2]))
    if vRP.hasPermission(user_id,"admin.permissao") then
        if args[1] and args[2] then
            local nuser_id = vRP.getUserId(nplayer)
            local identity = vRP.getUserIdentity(user_id)
            local identitynu = vRP.getUserIdentity(nuser_id)
            vRP.execute("creative/add_vehicle",{ user_id = parseInt(args[2]), vehicle = args[1], ipva = parseInt(os.time()) }) 
            vRP.execute("creative/set_ipva",{ user_id = parseInt(args[2]), vehicle = args[1], ipva = parseInt(os.time()) })
            TriggerClientEvent("Notify",source,"sucesso","Voce adicionou o veículo <b>"..args[1].."</b> para o Passaporte: <b>"..parseInt(args[2]).."</b>.") 
            SendWebhookMessage(webhookaddremcar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ADICIONOU]: "..args[1].." \n[PARA O ID]: "..nuser_id.." "..identitynu.name.." "..identitynu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```") 
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REM CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('remcar',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRP.getUserId(parseInt(args[2]))
    if vRP.hasPermission(user_id,"admin.permissao") then
        if args[1] and args[2] then
            local nuser_id = vRP.getUserId(nplayer)
            local identity = vRP.getUserIdentity(user_id)
            local identitynu = vRP.getUserIdentity(nuser_id)
            vRP.execute("creative/rem_vehicle",{ user_id = parseInt(args[2]), vehicle = args[1], ipva = parseInt(os.time())  }) 
            TriggerClientEvent("Notify",source,"sucesso","Voce removeu o veículo <b>"..args[1].."</b> do Passaporte: <b>"..parseInt(args[2]).."</b>.") 
            SendWebhookMessage(webhookaddremcar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[REMOVEU]: "..args[1].." \n[PARA O ID]: "..nuser_id.." "..identitynu.name.." "..identitynu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
--RegisterCommand('hash',function(source,args,rawCommand)
--	local user_id = vRP.getUserId(source)
--	if vRP.hasPermission(user_id,"admin.permissao") then
--		local vehicle = vRPclient.getNearestVehicle(source,7)
--		if vehicle then
--			TriggerClientEvent('vehash',source,vehicle)
--		end
--	end
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tuning',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local vehicle = vRPclient.getNearestVehicle(source,7)
		if vehicle then
			TriggerClientEvent('vehtuning',source,vehicle)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('wl',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"wl.permissao") then
		if args[1] then
			vRP.setWhitelisted(parseInt(args[1]),true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNWL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('unwl',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"wl.permissao") then
		if args[1] then
			vRP.setWhitelisted(parseInt(args[1]),false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('kick',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"kick.permissao") then
		if args[1] then
			local id = vRP.getUserSource(parseInt(args[1]))
			if id then
				vRP.kick(id,"Você foi kickado da cidade.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ban',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"ban.permissao") then
        if args[1] then
            local id = vRP.getUserSource(parseInt(args[1]))
            vRP.setBanned(parseInt(args[1]),true)
            vRP.kick(id,"Você foi banido da cidade.")
            vRP.setWhitelisted(parseInt(args[1]),false)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('unban',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"ban.permissao") then
		if args[1] then
			vRP.setBanned(parseInt(args[1]),false)
			vRP.setWhitelisted(parseInt(args[1]),true)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETAR O PERSONAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('reset',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"admin.permissao") then
            if args[1] then
                local nplayer = vRP.getUserSource(parseInt(args[1]))
                local id = vRP.getUserId(nplayer)
                if id then
                    vRP.kick(nplayer,"Aparência resetada, entre novamente!")
                    vRP.setUData(id,"vRP:spawnController",json.encode(1))
                    vRP.setUData(id,"vRP:currentCharacterMode",json.encode(1))
                    vRP.setUData(id,"vRP:tattoos",json.encode(1))
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MONEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('money',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"founder.permissao") then
		if args[1] then
			vRP.giveMoney(user_id,parseInt(args[1]))
			SendWebhookMessage(webhookmoney,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[FEZ]: R$ "..vRP.format(parseInt(args[1])).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RETIRAR DINHEIRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('getmoney',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"founder.permissao") then
		if args[1] then
			-- local bankMoney = vRP.getBankMoney(user_id)
			vRP.tryPayment(user_id,parseInt(args[1]))
			-- vRP.setBankMoney(user_id, bankMoney-parseInt(args[1]))
			SendWebhookMessage(webhookmoney,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[DESTRUIU]: R$ "..vRP.format(parseInt(args[1])).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('nc',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"noclip.permissao") then
		vRPclient.toggleNoclip(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpcds',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"tp.permissao") then
		local fcoords = vRP.prompt(source,"Cordenadas:","")
		if fcoords == "" then
			return
		end
		local coords = {}
		for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
			table.insert(coords,parseInt(coord))
		end
		vRPclient.teleport(source,coords[1] or 0,coords[2] or 0,coords[3] or 0)
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
RegisterCommand('group',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"group.permissao") then
		if args[1] and args[2] then
			if user_id > 1 and args[2] == "founder" then
				TriggerClientEvent("Notify",source,"negado","Voce não pode setar no grupo <b>"..args[2].."</b>")
			else
				vRP.addUserGroup(parseInt(args[1]),args[2])
				TriggerClientEvent("Notify",source,"sucesso","Voce setou o passaporte <b>"..parseInt(args[1]).."</b> no grupo <b>"..args[2].."</b>")
				SendWebhookMessage(webhookgrupos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU]: "..args[1].." \n[GRUPO]: "..args[2].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ungroup',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"group.permissao") then
		if args[1] and args[2] then
			vRP.removeUserGroup(parseInt(args[1]),args[2])
			TriggerClientEvent("Notify",source,"sucesso","Voce removeu o passaporte <b>"..parseInt(args[1]).."</b> do grupo <b>"..args[2].."</b>.")
			SendWebhookMessage(webhookgrupos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[REMOVEU]: "..args[1].." \n[GRUPO]: "..args[2].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tptome',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"tp.permissao") then
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			local x,y,z = vRPclient.getPosition(source)
			if tplayer then
				vRPclient.teleport(tplayer,x,y,z)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpto',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"tp.permissao") then
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			if tplayer then
				vRPclient.teleport(source,vRPclient.getPosition(tplayer))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpway',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"tp.permissao") then
		TriggerClientEvent('tptoway',source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('car',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local crds = GetEntityCoords(GetPlayerPed(source))
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] then
			TriggerClientEvent('spawnarveiculo',source,args[1])
			SendWebhookMessage(webhookcarros,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SPAWNOU]: "..(args[1]).."\n[COORDENADA]: "..crds.x..","..crds.y..","..crds.z..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TROCAR SEXO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('skin',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"founder.permissao") then
        if parseInt(args[1]) then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                TriggerClientEvent("skinmenu",nplayer,args[2])
                TriggerClientEvent("Notify",source,"sucesso","Voce setou a skin <b>"..args[2].."</b> no passaporte <b>"..parseInt(args[1]).."</b>.")
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELNPCS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('delnpcs',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		TriggerClientEvent('delnpcs',source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('adm',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"anuncio.permissao") then
		local identity = vRP.getUserIdentity(user_id)
		local mensagem = vRP.prompt(source,"Mensagem:","")
		if mensagem == "" then
			return
		end
		vRPclient.setDiv(-1,"anuncio",".div_anuncio { background: rgba(255,0,0,0.8); font-size: 11px; font-family: arial; color: #fff; padding: 20px; bottom: 50%; right: 20px; max-width: 600px; position: absolute; -webkit-border-radius: 5px; } bold { font-size: 15px; }","<bold>"..mensagem.."</bold><br><br>Mensagem enviada pelo(a) Staff: "..identity.name.." "..identity.firstname)
		SetTimeout(60000,function()
			vRPclient.removeDiv(-1,"anuncio")
		end)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /VROUPAS(JÁ NO FORMATO CORRETO)
-----------------------------------------------------------------------------------------------------------------------------------------
function IsNumber( numero )
    return tonumber(numero) ~= nil
end

RegisterCommand('vroupas', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local custom = vRPclient.getCustomization(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
          if player_customs[source] then
            player_customs[source] = nil
            vRPclient._removeDiv(source,"customization")
        else 
            local content = ""
            for k, v in pairs(custom) do
                if (IsNumber(k) and k <= 11) or k == "p0" or k == "p1" or k == "p2" or k == "p6" or k == "p7" then
                    if IsNumber(k) then
                        content = content .. '[' .. k .. '] = {' 
                    else
                        content = content .. '["' ..k..'"] = {'
                    end
                    local contador = 1
                    for y, x in pairs(v) do
                        if contador < #v then
                            content  = content .. x .. ',' 
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
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PEGAR IP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pegarip',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local tplayer = vRP.getUserSource(parseInt(args[1]))
    if vRP.hasPermission(user_id,"admin.permissao") then
        if args[1] and tplayer then
        TriggerClientEvent('chatMessage',source,"^1IP do Usuário: "..GetPlayerEndpoint(tplayer))
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT INTERNO DA STAFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('s',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "admin.permissao"
		if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"helper.permissao") then
			local staff = vRP.getUsersByPermission(permission)
			for l,w in pairs(staff) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,identity.name.." "..identity.firstname.. " [" ..user_id.. "]: ",{255,215,0},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT INTERNO DO HOSPITAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('hp',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "paramedico.permissao"
		if vRP.hasPermission(user_id,"paramedico.permissao") then
			local hospital = vRP.getUsersByPermission(permission)
			for l,w in pairs(hospital) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,identity.name.." "..identity.firstname.. " [" ..user_id.. "]: ",{255,0,0},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RETIRAR ALGEMA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('algema',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"helper.permissao") then
            TriggerClientEvent("admcuff",source)
            TriggerClientEvent("Notify",source,"sucesso","Você foi <b>desalgemado</b> com sucesso.")
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CORREÇÃO DE SPAWNAR ARMA
-----------------------------------------------------------------------------------------------------------------------------------------
local webhooksuspeito= "https://discord.com/api/webhooks/800186893186236416/xi0jk6NfSDR3lWLBF2FfgX6VVxkNWELBcXKEClJv3HvHPa0ziMlrsn2ehvAHi31iiWoQ"

RegisterServerEvent('LOG:ARMAS654654684')
AddEventHandler('LOG:ARMAS654654684', function()
    local user_id = vRP.getUserId(source)
    if user_id~=nil then
      PerformHttpRequest(webhooksuspeito, function(err, text, headers) end, 'POST', json.encode({content = "[SUSPEITO] SPAWN DE ARMAS "..user_id}), { ['Content-Type'] = 'application/json' })
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKAR PLAYERS SEM ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('kickbugados',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao")then
        TriggerClientEvent('MQCU:bugado',-1)
    end
end)

RegisterServerEvent("MQCU:bugado")
AddEventHandler("MQCU:bugado",function()
    local user_id = vRP.getUserId(source)
    if user_id == nil then
        local identifiers = GetPlayerIdentifiers(source)
        DropPlayer(source,"Você foi kikado da cidade!")
        identifiers = json.decode(identifiers)
        print("Player bugado encontrado: "..identifiers)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
local presets = {
	["staff"] = {
		[1885233650] = {
			[3] = {0,0,1},
			[4] = {87,11,1},
			[6] = {9,12,1},
			[8] = {15,0,2},
			[11] = {208,18,1},
			["p0"] = {-1,0},
		},
		[-1667301416] = {
			[3] = {14,0,1},
			[4] = {90,15,1},
			[6] = {74,0,1},
			[8] = {15,0,2},
			[11] = {224,0,1},
			["p0"] = {-1,0},
		}
	},
	["porcao"] = {
		[1885233650] = {
			[1] = {5,0,2},
			[3] = {0,0,1},
			[4] = {87,11,1},
			[6] = {9,12,1},
			[8] = {15,0,2},
			[11] = {208,18,1},
			["p0"] = {-1,0},
		}
	},
	["wally"] = {
		[1885233650] = {
			[1] = {26,1,2},
			[3] = {52,0,2},
			[4] = {87,11,1},
			[6] = {6,6,2},
			[8] = {15,0,2},
			[11] = {208,18,1},
			["p0"] = {-1,0},
		}
	},
	["kappa"] = {
		[1885233650] = {
			[1] = {87,0,2},
			[2] = {57,0,0},
			[3] = {138,1,1},
			[4] = {87,11,1},
			[5] = {23,6,1},
			[6] = {7,14,1},
			[7] = {3,0,1},
			[8] = {15,0,2},
			[11] = {208,18,1},
			["p1"] = {15,1},
			["p0"] = {-1,0},
		}
	},
	["cortez"] = {
		[1885233650] = {
			[1] = {21,0,1},
			[3] = {99,3,1},
			[4] = {87,11,1},
			[5] = {23,12,1},
			[6] = {87,13,1},
			[7] = {1,1,1},
			[8] = {15,0,2},
			[11] = {208,18,1},
			["p1"] = {3,0},
			["p0"] = {-1,0},
		}
	},
	["dk"] = {
		[1885233650] = {
			[1] = {95,0,2},
			[3] = {138,1,1},
			[4] = {87,11,1},
			[5] = {0,0,1},
			[6] = {6,9,1},
			[7] = {1,1,1},
			[8] = {15,0,1},
			[9] = {0,0,1},
			[10] = {0,0,2},
			[11] = {208,18,1},
			[0] = {0,0,0},
			["p2"] = {-1,0},
			["p1"] = {-1,0},
			["p0"] = {8,0},
			["p6"] = {-1,0},
			["p7"] = {-1,0},
		}
	},
}

RegisterCommand('preset',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"kick.permissao") then
		if args[1] then
			local custom = presets[tostring(args[1])]
			if custom then
				local old_custom = vRPclient.getCustomization(source)
				local idle_copy = {}

				idle_copy = vRP.save_idle_custom(source,old_custom)
				idle_copy.modelhash = nil

				for l,w in pairs(custom[old_custom.modelhash]) do
					idle_copy[l] = w
				end
				vRPclient._setCustomization(source,idle_copy)
			end
		else
			vRP.removeCloak(source)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SETAGENS LIDERES
-----------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------
-- VERMELHOS
---------------------------------------------------
RegisterCommand('add-vermelhos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nplayer = vRP.getUserSource(parseInt(args[1]))
	if vRP.hasPermission(user_id,"lidervermelhos.permissao") then
		if args[1] then
			if nplayer then
				vRP.addUserGroup(parseInt(args[1]),"Vermelhos")
				TriggerClientEvent("Notify",source,"sucesso","Voce setou o <b>ID "..args[1].."</b> com sucesso!")
				SendWebhookMessage(webhookfac,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU]:"..parseInt(args[1]).." \n[GRUPO]: Vermelhos"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			else
				TriggerClientEvent("Notify",source,"negado","Negado, a pessoa precisa estar online")
			end
		end
	end
end)
RegisterCommand('rem-vermelhos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nplayer = vRP.getUserSource(parseInt(args[1]))
	if vRP.hasPermission(user_id,"lidervermelhos.permissao") then
		if args[1] then
			if nplayer then
				vRP.removeUserGroup(parseInt(args[1]),"Vermelhos")
				TriggerClientEvent("Notify",source,"sucesso","Voce retirou o set do <b>ID "..args[1].."</b> com sucesso!")
					SendWebhookMessage(webhookfac,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[REMOVEU]: "..parseInt(args[1]).." \n[GRUPO]: Vermelhos"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				else
					TriggerClientEvent("Notify",source,"negado","Negado, a pessoa precisa estar online")
			end
		end
	end
end)
---------------------------------------------------
-- VERDES
---------------------------------------------------
RegisterCommand('add-verdes',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nplayer = vRP.getUserSource(parseInt(args[1]))
	if vRP.hasPermission(user_id,"liderverdes.permissao") then
		if args[1] then
			if nplayer then
				vRP.addUserGroup(parseInt(args[1]),"Verdes")
				TriggerClientEvent("Notify",source,"sucesso","Voce setou o <b>ID "..args[1].."</b> com sucesso!")
				SendWebhookMessage(webhookfac,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU]:"..parseInt(args[1]).." \n[GRUPO]: Verdes"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			else
				TriggerClientEvent("Notify",source,"negado","Negado, a pessoa precisa estar online")
			end
		end
	end
end)
RegisterCommand('rem-verdes',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nplayer = vRP.getUserSource(parseInt(args[1]))
	if vRP.hasPermission(user_id,"liderverdes.permissao") then
		if args[1] then
			if nplayer then
				vRP.removeUserGroup(parseInt(args[1]),"Verdes")
				TriggerClientEvent("Notify",source,"sucesso","Voce retirou o set do <b>ID "..args[1].."</b> com sucesso!")
					SendWebhookMessage(webhookfac,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[REMOVEU]: "..parseInt(args[1]).." \n[GRUPO]: Verdes"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				else
					TriggerClientEvent("Notify",source,"negado","Negado, a pessoa precisa estar online")
			end
		end
	end
end)
---------------------------------------------------
-- ROXOS
---------------------------------------------------
RegisterCommand('add-roxos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nplayer = vRP.getUserSource(parseInt(args[1]))
	if vRP.hasPermission(user_id,"liderroxos.permissao") then
		if args[1] then
			if nplayer then
				vRP.addUserGroup(parseInt(args[1]),"Roxos")
				TriggerClientEvent("Notify",source,"sucesso","Voce setou o <b>ID "..args[1].."</b> com sucesso!")
				SendWebhookMessage(webhookfac,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU]:"..parseInt(args[1]).." \n[GRUPO]: Roxos"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			else
				TriggerClientEvent("Notify",source,"negado","Negado, a pessoa precisa estar online")
			end
		end
	end
end)
RegisterCommand('rem-roxos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nplayer = vRP.getUserSource(parseInt(args[1]))
	if vRP.hasPermission(user_id,"liderroxos.permissao") then
		if args[1] then
			if nplayer then
				vRP.removeUserGroup(parseInt(args[1]),"Roxos")
				TriggerClientEvent("Notify",source,"sucesso","Voce retirou o set do <b>ID "..args[1].."</b> com sucesso!")
					SendWebhookMessage(webhookfac,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[REMOVEU]: "..parseInt(args[1]).." \n[GRUPO]: Roxos"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				else
					TriggerClientEvent("Notify",source,"negado","Negado, a pessoa precisa estar online")
			end
		end
	end
end)
---------------------------------------------------
-- MOTOCLUB
---------------------------------------------------
RegisterCommand('add-motoclub',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nplayer = vRP.getUserSource(parseInt(args[1]))
	if vRP.hasPermission(user_id,"lidermotoclub.permissao") then
		if args[1] then
			if nplayer then
				vRP.addUserGroup(parseInt(args[1]),"Motoclub")
				TriggerClientEvent("Notify",source,"sucesso","Voce setou o <b>ID "..args[1].."</b> com sucesso!")
				SendWebhookMessage(webhookfac,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU]:"..parseInt(args[1]).." \n[GRUPO]: Motoclub"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			else
				TriggerClientEvent("Notify",source,"negado","Negado, a pessoa precisa estar online")
			end
		end
	end
end)
RegisterCommand('rem-motoclub',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nplayer = vRP.getUserSource(parseInt(args[1]))
	if vRP.hasPermission(user_id,"lidermotoclub.permissao") then
		if args[1] then
			if nplayer then
				vRP.removeUserGroup(parseInt(args[1]),"Motoclub")
				TriggerClientEvent("Notify",source,"sucesso","Voce retirou o set do <b>ID "..args[1].."</b> com sucesso!")
					SendWebhookMessage(webhookfac,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[REMOVEU]: "..parseInt(args[1]).." \n[GRUPO]: Motoclub"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				else
					TriggerClientEvent("Notify",source,"negado","Negado, a pessoa precisa estar online")
			end
		end
	end
end)
---------------------------------------------------
-- COSANOSTRA
---------------------------------------------------
RegisterCommand('add-cosanostra',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nplayer = vRP.getUserSource(parseInt(args[1]))
	if vRP.hasPermission(user_id,"lidercn.permissao") then
		if args[1] then
			if nplayer then
				vRP.addUserGroup(parseInt(args[1]),"CN")
				TriggerClientEvent("Notify",source,"sucesso","Voce setou o <b>ID "..args[1].."</b> com sucesso!")
				SendWebhookMessage(webhookfac,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU]:"..parseInt(args[1]).." \n[GRUPO]: CN"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			else
				TriggerClientEvent("Notify",source,"negado","Negado, a pessoa precisa estar online")
			end
		end
	end
end)
RegisterCommand('rem-cosanostra',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nplayer = vRP.getUserSource(parseInt(args[1]))
	if vRP.hasPermission(user_id,"lidercn.permissao") then
		if args[1] then
			if nplayer then
				vRP.removeUserGroup(parseInt(args[1]),"CN")
				TriggerClientEvent("Notify",source,"sucesso","Voce retirou o set do <b>ID "..args[1].."</b> com sucesso!")
					SendWebhookMessage(webhookfac,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[REMOVEU]: "..parseInt(args[1]).." \n[GRUPO]: CN"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				else
					TriggerClientEvent("Notify",source,"negado","Negado, a pessoa precisa estar online")
			end
		end
	end
end)
---------------------------------------------------
-- BRATVA
---------------------------------------------------
RegisterCommand('add-bratva',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nplayer = vRP.getUserSource(parseInt(args[1]))
	if vRP.hasPermission(user_id,"liderbratva.permissao") then
		if args[1] then
			if nplayer then
				vRP.addUserGroup(parseInt(args[1]),"Bratva")
				TriggerClientEvent("Notify",source,"sucesso","Voce setou o <b>ID "..args[1].."</b> com sucesso!")
				SendWebhookMessage(webhookfac,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU]:"..parseInt(args[1]).." \n[GRUPO]: Bratva"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			else
				TriggerClientEvent("Notify",source,"negado","Negado, a pessoa precisa estar online")
			end
		end
	end
end)
RegisterCommand('rem-bratva',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nplayer = vRP.getUserSource(parseInt(args[1]))
	if vRP.hasPermission(user_id,"liderbratva.permissao") then
		if args[1] then
			if nplayer then
				vRP.removeUserGroup(parseInt(args[1]),"Bratva")
				TriggerClientEvent("Notify",source,"sucesso","Voce retirou o set do <b>ID "..args[1].."</b> com sucesso!")
					SendWebhookMessage(webhookfac,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[REMOVEU]: "..parseInt(args[1]).." \n[GRUPO]: Bratva"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				else
					TriggerClientEvent("Notify",source,"negado","Negado, a pessoa precisa estar online")
			end
		end
	end
end)
---------------------------------------------------
-- YAKUZA
---------------------------------------------------
RegisterCommand('add-yakuza',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nplayer = vRP.getUserSource(parseInt(args[1]))
	if vRP.hasPermission(user_id,"lideryakuza.permissao") then
		if args[1] then
			if nplayer then
				vRP.addUserGroup(parseInt(args[1]),"Yakuza")
				TriggerClientEvent("Notify",source,"sucesso","Voce setou o <b>ID "..args[1].."</b> com sucesso!")
				SendWebhookMessage(webhookfac,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU]:"..parseInt(args[1]).." \n[GRUPO]: Yakuza"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			else
				TriggerClientEvent("Notify",source,"negado","Negado, a pessoa precisa estar online")
			end
		end
	end
end)
RegisterCommand('rem-yakuza',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local nplayer = vRP.getUserSource(parseInt(args[1]))
	if vRP.hasPermission(user_id,"lideryakuza.permissao") then
		if args[1] then
			if nplayer then
				vRP.removeUserGroup(parseInt(args[1]),"Yakuza")
				TriggerClientEvent("Notify",source,"sucesso","Voce retirou o set do <b>ID "..args[1].."</b> com sucesso!")
					SendWebhookMessage(webhookfac,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[REMOVEU]: "..parseInt(args[1]).." \n[GRUPO]: Yakuza"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				else
					TriggerClientEvent("Notify",source,"negado","Negado, a pessoa precisa estar online")
			end
		end
	end
end)