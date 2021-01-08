local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

local webhookaddremcar = "https://discord.com/api/webhooks/795671123299663893/-CZgy7czgUO7BeEHlYJpdCm00mxjG11oSrEHkhUC1r2mmXgGm93p9vq4VWp6gTzyi9vK"
local webhookmoney = "https://discord.com/api/webhooks/795667756493963304/4Azax194qMKWm6y1KfADk8ernA8YpUF1CKWvHdlaG2tNSd_NHhy3-fycr9RvpTAp41qa"
local webhookcarros = "https://discord.com/api/webhooks/793197093690671134/CVTPwlTgBR2CVOKsyTEXCXau6KX4L8eZFijtmOY06S6wnCs2BRh3urrUUut3NzHPWQi2"
local webhookgrupos = "https://discord.com/api/webhooks/795669087896338462/QeH-0wMplpMq8pfvuxIlA_XmQKyWcERkOzy0c5yBjLidBa7W6EkndzS-ul4s4hq3t33-"
local webhookcmdgod = "https://discord.com/api/webhooks/797212560821977100/0gudVRGoejjBJrrKGrYRREhIbnMpD5Ts1s4MqPivDoGLS4vXIuqci9n6jinY5pXv40VG"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

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
    if vRP.hasPermission(user_id,"god.permissao") then
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
RegisterCommand('tpall', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local x,y,z = vRPclient.getPosition(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        local rusers = vRP.getUsers()
        for k,v in pairs(rusers) do
            local rsource = vRP.getUserSource(k)
            if rsource ~= source then
                vRPclient.teleport(rsource,x,y,z)
            end
        end
    end
end)
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
			TriggerClientEvent('reparar',source,vehicle)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('limparea',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPosition(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
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
	if vRP.hasPermission(user_id,"god.permissao") then
		if args[1] then
			if nplayer then
				local nuser_id = vRP.getUserId(nplayer)
				local identitynu = vRP.getUserIdentity(nuser_id)
				vRPclient.killGod(nplayer)
				vRPclient._stopAnim(nplayer,false)
				vRPclient.setHealth(nplayer,400)
				SendWebhookMessage(webhookcmdgod,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GOD EM]: "..nuser_id.." "..identitynu.name.." "..identitynu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```") 
			end
		else
			vRPclient._stopAnim(source,false)
			vRPclient.killGod(source)
			vRPclient.setHealth(source,400) -- Vida
			vRPclient.setArmour(source,100) -- Colete
			SendWebhookMessage(webhookcmdgod,"```prolog\n[GOD PROPRIO]: "..user_id.." "..identity.name.." "..identity.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD ALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('godall',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
    	local users = vRP.getUsers()
        for k,v in pairs(users) do
            local id = vRP.getUserSource(parseInt(k))
            if id then
            	vRPclient.killGod(id)
				vRPclient.setHealth(id,400)
				vRPclient.setArmour(source,100)
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
				vRP.kick(id,"Você foi expulso da cidade.")
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
            vRP.kick(id,"Você foi expulso da cidade.")
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
		end
	end
end)


RegisterCommand('reset',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"admin.permissao") then
            if args[1] then
                local nplayer = vRP.getUserSource(parseInt(args[1]))
                local id = vRP.getUserId(nplayer)
                if id then
                    vRP.kick(nplayer,"Transplante Iniciado.")
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
	if vRP.hasPermission(user_id,"admin.permissao") then
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
	if vRP.hasPermission(user_id,"admin.permissao") then
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
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
		if args[1] and args[2] then
			vRP.addUserGroup(parseInt(args[1]),args[2])
			TriggerClientEvent("Notify",source,"sucesso","Voce setou o passaporte <b>"..parseInt(args[1]).."</b> no grupo <b>"..args[2].."</b>")
			SendWebhookMessage(webhookgrupos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU]: "..args[1].." \n[GRUPO]: "..args[2].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ungroup',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
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
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] then
			TriggerClientEvent('spawnarveiculo',source,args[1])
			SendWebhookMessage(webhookcarros,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SPAWNOU]: "..(args[1]).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
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
-- Ver roupas
-----------------------------------------------------------------------------------------------------------------------------------------
local player_customs = {}

RegisterCommand('vroupas',function(source,args,rawCommand)
    local custom = vRPclient.getCustomization(source)
    if player_customs[source] then -- hide
      player_customs[source] = nil
      vRPclient._removeDiv(source,"customization")
    else -- show
      local content = ""
    for k,v in pairs(custom) do
		content = content..k.." = "..json.encode(v)
      end
        player_customs[source] = true
	--   vRPclient._setDiv(source,"customization",".div_customization{ margin: auto; padding: 8px; width: 500px; margin-top: 80px; background: black; color: white; font-weight: bold; ", content)
	vRP.prompt(source, "Montagem de Preset", content)
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