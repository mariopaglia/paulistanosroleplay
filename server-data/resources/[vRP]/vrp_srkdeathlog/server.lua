local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPclient = Tunnel.getInterface("vRP")

vRP = Proxy.getInterface("vRP")

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

local weaponhash =  {
	[-1074790547] = { ['name'] = "AssaultRifle"},
	[961495388] = { ['name'] = "AssaultRifleMk2"},
	[-2084633992] = { ['name'] = "CarbineRifle"},
	[4208062921] = { ['name'] = "CarbineRifleMk2"},
	[-1357824103] = { ['name'] = "AdvancedRifle"},
	[-1063057011] = { ['name'] = "SpecialCarbine"},
	[2132975508] = { ['name'] = "BullpupRifle"},
	[1649403952] = { ['name'] = "CompactRifle"},
	[100416529] = { ['name'] = "SniperRifle"},
	[205991906] = { ['name'] = "HeavySniper"},
	[177293209] = { ['name'] = "HeavySniperMk2"},
	[-952879014] = { ['name'] = "MarksmanRifle"},
	[487013001] = { ['name'] = "PumpShotgun"},
	[2017895192] = { ['name'] = "SawnoffShotgun"},
	[-1654528753] = { ['name'] = "BullpupShotgun"},
	[-494615257] = { ['name'] = "AssaultShotgun"},
	[-1466123874] = { ['name'] = "Musket"},
	[984333226] = { ['name'] = "HeavyShotgun"},
	[-275439685] = { ['name'] = "DoubleBarrelShotgun"},
	[317205821] = { ['name'] = "Autoshotgun"},
	[-1568386805] = { ['name'] = "GrenadeLauncher"},
	[-1312131151] = { ['name'] = " RPG"},
	[1119849093] = { ['name'] = " Minigun"},
	[ 2138347493] = { ['name'] = " Firework"},
	[1834241177] = { ['name'] = " Railgun"},
	[1672152130] = { ['name'] = " HomingLauncher"},
	[1305664598] = { ['name'] = " GrenadeLauncherSmoke"},
	[125959754] = { ['name'] = " CompactLauncher"},
	[961495388] = { ['name'] = "Assault Rifle Mk2"},
    [453432689] = { ['name'] = "Pistol"},
    [-1075685676] ={ ['name']= "PistolMk2"},
    [1593441988] = { ['name'] = "CombatPistol"},
    [-1716589765] = { ['name'] = "Pistol50"},
    [-1076751822] = { ['name'] = "SNSPistol"},
    [-771403250] = { ['name'] = "HeavyPistol"},
    [137902532] = { ['name'] = "VintagePistol"},
    [-598887786] = { ['name'] = "MarksmanPistol"},
    [-1045183535] = { ['name'] = "Revolver"},
    [584646201] = { ['name'] = "APPistol"},
    [911657153] = { ['name'] = "StunGun"},
	[1198879012] = { ['name'] = "FlareGun"},
	[324215364] = { ['name'] = "MicroSMG"},
	[-619010992] = { ['name'] = "MachinePistol"},
	[736523883] = { ['name'] = "SMG"},
	[2024373456] = { ['name'] = "SMGMk2"},
	[-270015777] = { ['name'] = "AssaultSMG"},
	[171789620] = { ['name'] = "CombatPDW"},
	[-1660422300] = { ['name'] = "MG"},
	[2144741730] = { ['name'] = "CombatMG"},
	[3686625920] = { ['name'] = "CombatMGMk2"},
	[1627465347] = { ['name'] = "Gusenberg"},
	[-1121678507] = { ['name'] = "MiniSMG"},
	[-1569615261] = { ['name'] = "Unarmed"},
    [-1716189206] = { ['name'] = "Knife"},
    [1317494643] = { ['name'] = " Hammer"},
    [-1786099057] = { ['name'] = "Bat"},
    [-2067956739] = { ['name'] = "Crowbar"},
    [1141786504] = { ['name'] = "Golfclub"},
    [-102323637] = { ['name'] = "Bottle"},
    [-1834847097] = { ['name'] = "Dagger"},
    [-102973651] = { ['name'] = "Hatchet"},
    [-656458692] = { ['name'] = " KnuckleDuster"},
    [-581044007] = { ['name'] = "Machete"},
    [-1951375401] = { ['name'] = "Flashlight"},
    [-538741184] = { ['name'] = "SwitchBlade"},
    [-1810795771] = { ['name'] = "Poolcue"},
    [419712736] = { ['name'] = "Wrench"},
	[-853065399] = { ['name'] = "Battleaxe"},
	[-1813897027] = { ['name'] = "Grenade"},
	[741814745] = { ['name'] = " StickyBomb"},
	[-1420407917] = { ['name'] = " ProximityMine"},
	[-1600701090] = { ['name'] = " BZGas"},
	[615608432] = { ['name'] = "Molotov"},
	[101631238] = { ['name'] = " FireExtinguisher"},
	[883325847] = { ['name'] = " PetrolCan"},
	[1233104067] = { ['name'] = " Flare"},
	[600439132] = { ['name'] = " Ball"},
	[126349499] = { ['name'] = " Snowball"},
	[-37975472] = { ['name'] = " SmokeGrenade"},
	[-1169823560] = { ['name'] = " Pipebomb"}
}

srkkillregister = {}

RegisterServerEvent('srkfive:onPlayerKilled')
AddEventHandler('srkfive:onPlayerKilled', function(killedBy, data)
	local source1 = source
	local deadPlayerId = vRP.getUserId(source)
	local killedId = vRP.getUserId(killedBy)

	local weaponname = data.weaponhash

	if weaponhash[data.weaponhash] then 
		weaponname = weaponhash[data.weaponhash].name
	end


	if data.killerinveh then
		SendWebhookMessage(config.webhook,"```prolog\n[MORREU]: "..deadPlayerId.."\n[MATOU]: "..killedId.." \n[VEICULO]: "..data.killervehname.." \n[LOCAL]: "..tD(data.killerposx)..","..tD(data.killerposy)..","..tD(data.killerposz)..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		if config.diag then
			table.insert(srkkillregister, {vitimaid = deadPlayerId, motivo = 'Atropelamento'})
		end
		if config.vdmchatreport then
			local admin = vRP.getUsersByPermission(config.staffperm)
			for k,v in pairs(admin) do
				local player = vRP.getUserSource(parseInt(v))
				TriggerClientEvent('chatMessage',player,"[VDM] O [ID]: "..killedId.." matou o [ID]: "..deadPlayerId.." com o carro: "..data.killervehname,{config.vdmchatmessagecolor['red'],config.vdmchatmessagecolor['green'],config.vdmchatmessagecolor['blue']})
			end
		end
	else
		SendWebhookMessage(config.webhook,"```prolog\n[MORREU]: "..deadPlayerId.."\n[MATOU]: "..killedId.." \n[ARMA]: "..weaponname.." \n[LOCAL]: "..tD(data.killerposx)..","..tD(data.killerposy)..","..tD(data.killerposz)..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		if config.diag then
			table.insert(srkkillregister, {vitimaid = deadPlayerId, motivo = 'Baleado com: '..weaponname})
		end
		if config.gunchatreport then
			local admin = vRP.getUsersByPermission(config.staffperm)
			for k,v in pairs(admin) do
				local player = vRP.getUserSource(parseInt(v))
				TriggerClientEvent('chatMessage',player,"O [ID]: "..killedId.." matou o [ID]: "..deadPlayerId.." com a arma: "..weaponname,{config.gunchatmessagecolor['red'],config.gunchatmessagecolor['green'],config.gunchatmessagecolor['blue']})
			end
		end
	end
end)

RegisterServerEvent('srkfive:onPlayerDied')
AddEventHandler('srkfive:onPlayerDied', function(x,y,z)
	local source = source
	local user_id = vRP.getUserId(source)
	--[[table.insert(srkkillregister, {vitimaid = user_id, motivo = 'Desconhecido'})
	SendWebhookMessage(config.webhook,"```prolog\n[MORREU]: "..user_id.." \n[MOTIVO]: DESCONHECIDO \n[LOCAL]: "..tD(x)..","..tD(y)..","..tD(z)..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	if config.randomdeathreport then
		local admin = vRP.getUsersByPermission(config.staffperm)
		for k,v in pairs(admin) do
			local player = vRP.getUserSource(parseInt(v))
			TriggerClientEvent('chatMessage',player,"O [ID]: "..user_id.." morreu por um motivo desconhecido! ",{config.randomchatmessagecolor['red'],config.randomchatmessagecolor['green'],config.randomchatmessagecolor['blue']})
		end
	end]]
end)

function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end

if config.diag then
	RegisterCommand('diag',function(source,args,rawCommand)
		local source = source
		local user_id = vRP.getUserId(source)
		local search = false
		local nplayer = vRPclient.getNearestPlayer(source,2)
		local nuser_id = vRP.getUserId(nplayer)
		if vRP.hasPermission(user_id, config.diagpermission) or vRP.hasPermission(user_id, config.diagpermission2) then
			if user_id and nuser_id then
				for k,v in pairs(srkkillregister) do
					if v.vitimaid == nuser_id then
						search = true
						local motivo = v.motivo
						if motivo == 'Atropelamento' then
							TriggerClientEvent("Notify",source,"importante","Essa pessoa foi atropelada!") 
						elseif motivo == 'Desconhecido' then
							TriggerClientEvent("Notify",source,"importante","O motivo da morte é desconhecido!") 
						else
							TriggerClientEvent("Notify",source,"importante","Essa pessoa foi morta a tiros de: "..motivo.."!") 
						end
					end
				end
			end
		end
	end)
end

function removekey(target, key)
	local element = target[key]
	target[key] = nil
	return element
end

RegisterServerEvent('srkfive:killregisterclear')
AddEventHandler('srkfive:killregisterclear', function(id)
	if id then
		for k,v in pairs(srkkillregister) do
			if v.vitimaid == id then
				local select = k
				removekey(srkkillregister, select)
			end
		end
	end
end)