CONF = {}

-------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-------------------------------------------------------------------------------------------------------------------------
CONF.webhook = "https://discord.com/api/webhooks/885643958481457193/a1VX1spw9d0VxbqtWYZOtAoX0TpmMxJ_5fWyPPKTYoOao8cdDhSovcGCeV4OC1Y7j1kH"

-------------------------------------------------------------------------------------------------------------------------
-- FEED DE MORTES IN GAME
-------------------------------------------------------------------------------------------------------------------------
CONF.notify = "notify" -- **false** desativa, **chat** receberá via chat, **notify** via notify em cima do mini-mapa e **notifykill** via notify com imagem
CONF.feedOnOff = "admin.permissao" -- permissão para ativar ou desativar as notificações in-game, exemplo abaixo:
-- utilizando o comando in-game "/feedmortes chat" altera para modo chat
-- utilizando o comando in-game "/feedmortes notify" altera para modo notificação em cima do mini-mapa
-- utilizando o comando in-game "/feedmortes notifykill" altera para modo notificação com imagem
-- utilizando o comando in-game "/feedmortes" desativa o feed
CONF.permissao = "kick.permissao" -- permissão para receber as notificações in-game

-------------------------------------------------------------------------------------------------------------------------
-- NATION PAINTBALL
-------------------------------------------------------------------------------------------------------------------------
CONF.nationpaintball = false -- **true** desativa as logs de mortes que ocorrerem dentro do nation_paintball, **false** receberá todas as logs

-------------------------------------------------------------------------------------------------------------------------
-- SAFEZONES
-------------------------------------------------------------------------------------------------------------------------
CONF.safezone = true  -- Para habilitar a detecção de morte em safezone alterar para TRUE

CONF.safes = {
	{ ['x'] = -45.71, ['y'] = -1097.62, ['z'] = 26.27, ['range'] = 50, ['nome'] = "Concessionária" },
	{ ['x'] = 315.88, ['y'] = -592.47, ['z'] = 43.18, ['range'] = 100, ['nome'] = "Hospital" },
}
-------------------------------------------------------------------------------------------------------------------------
-- CONFIGURAÇÃO SOBRENOME DOS PERSONAGENS
-------------------------------------------------------------------------------------------------------------------------
-- Caso o sobrenome do personagem no banco de dados da sua base esteja salvo no campo **name2** deixar true
CONF.name2 = false

-------------------------------------------------------------------------------------------------------------------------
-- PERSONALIZAÇÃO DA WEBHOOK
-------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS DAS LOGS:
-- {idVitima}			-- ID da vitima
-- {vitimaNome}			-- Nome da vitima
-- {vitimaSobrenome}	-- Sobrenome da vitima
-- {cdsVitima}			-- Coordenada da vitima
--
-- {idAssasino}			-- ID do assasino
-- {assasinoNome}		-- Nome do assasino
-- {assasinoSobrenome}  -- Sobrenome do assasino
-- {cdsAssasino}        -- Coordenada do assasino
--
-- {tipoMorte}          -- Descrição do tipo da morte
-- {arma}               -- Arma utilizada
-- {safezone}           -- Se ocorreu em safezone ou não
-- {veiculo}            -- Veiculo utilizado
-- {horaMorte}          -- Hora da morte (in-game)


CONF.LogMorreu = "[ID]: {idVitima} {vitimaNome} {vitimaSobrenome} \n[{tipoMorte}] \n[CAUSA DA MORTE]: {arma} \n[VEICULO]: {veiculo} \n[SAFEZONE]: {safezone} \n[HORARIO NA CIDADE]: {horaMorte} horas \n[LOCAL]: {cdsVitima}"
CONF.LogMatou = "[ID]: {idVitima} {vitimaNome} {vitimaSobrenome} \n[{tipoMorte}] \n[ID]: {idAssasino} {assasinoNome} {assasinoSobrenome} \n[UTILIZANDO]: {arma} \n[VEICULO]: {veiculo} \n[SAFEZONE]: {safezone} \n[HORARIO NA CIDADE]: {horaMorte} horas \n[LOCAL ASSASINO]: {cdsAssasino} \n[LOCAL VITIMA]: {cdsVitima}"
CONF.LogSuicidou = "[ID]: {idVitima} {vitimaNome} {vitimaSobrenome} [SE SUICIDOU] \n[CAUSA DA MORTE]: {arma} \n[VEICULO]: {veiculo} \n[SAFEZONE]: {safezone} \n[HORARIO NA CIDADE]: {horaMorte} horas \n[LOCAL]: {cdsVitima}"

-------------------------------------------------------------------------------------------------------------------------
-- LISTA DE ARMAS
-------------------------------------------------------------------------------------------------------------------------
CONF.Weapons = {
	[tostring(GetHashKey('WEAPON_UNARMED'))] = 'Desarmado',
	[tostring(GetHashKey('GADGET_PARACHUTE'))] = 'Paraquedas',
	[tostring(GetHashKey('WEAPON_KNIFE'))] = 'Faca',
	[tostring(GetHashKey('WEAPON_NIGHTSTICK'))] = 'Machete',
	[tostring(GetHashKey('WEAPON_HAMMER'))] = 'Martelo',
	[tostring(GetHashKey('WEAPON_BAT'))] = 'Taco de Beisebol',
	[tostring(GetHashKey('WEAPON_CROWBAR'))] = 'Pé de Cabra',
	[tostring(GetHashKey('WEAPON_GOLFCLUB'))] = 'Taco de Golf',
	[tostring(GetHashKey('WEAPON_BOTTLE'))] = 'Garrafa',
	[tostring(GetHashKey('WEAPON_DAGGER'))] = 'Adaga',
	[tostring(GetHashKey('WEAPON_HATCHET'))] = 'Machado',
	[tostring(GetHashKey('WEAPON_KNUCKLE'))] = 'Soco-Inglês',
	[tostring(GetHashKey('WEAPON_MACHETE'))] = 'Machete',
	[tostring(GetHashKey('WEAPON_FLASHLIGHT'))] = 'Lanterna',
	[tostring(GetHashKey('WEAPON_SWITCHBLADE'))] = 'Canivete',
	[tostring(GetHashKey('WEAPON_BATTLEAXE'))] = 'Machado de Batalha',
	[tostring(GetHashKey('WEAPON_POOLCUE'))] = 'Taco de Sinuca',
	[tostring(GetHashKey('WEAPON_PIPEWRENCH'))] = 'Chave Grifo',
	[tostring(GetHashKey('WEAPON_STONE_HATCHET'))] = 'Machado de Pedra',
	[tostring(GetHashKey('WEAPON_PISTOL'))] = 'M1911',
	[tostring(GetHashKey('WEAPON_PISTOL_MK2'))] = 'FN Five Seven',
	[tostring(GetHashKey('WEAPON_COMBATPISTOL'))] = 'Glock G19',
	[tostring(GetHashKey('WEAPON_PISTOL50'))] = 'Pistol .50	',
	[tostring(GetHashKey('WEAPON_SNSPISTOL'))] = 'HK P7M10',
	[tostring(GetHashKey('WEAPON_SNSPISTOL_MK2'))] = 'SNS Pistol Mk2',
	[tostring(GetHashKey('WEAPON_HEAVYPISTOL'))] = 'Heavy Pistol',
	[tostring(GetHashKey('WEAPON_VINTAGEPISTOL'))] = 'M1922',
	[tostring(GetHashKey('WEAPON_MARKSMANPISTOL'))] = 'Marksman Pistol',
	[tostring(GetHashKey('WEAPON_REVOLVER'))] = 'Magnum 44',
	[tostring(GetHashKey('WEAPON_REVOLVER_MK2'))] = 'Magnum 357',
	[tostring(GetHashKey('WEAPON_DOUBLEACTION'))] = 'Double-Action Revolver',
	[tostring(GetHashKey('WEAPON_APPISTOL'))] = 'Koch VP9',
	[tostring(GetHashKey('WEAPON_STUNGUN'))] = 'Tazer',
	[tostring(GetHashKey('WEAPON_FLAREGUN'))] = 'Flare Gun',
	[tostring(GetHashKey('WEAPON_RAYPISTOL'))] = 'Up-n-Atomizer',
	[tostring(GetHashKey('WEAPON_MICROSMG'))] = 'Uzi',
	[tostring(GetHashKey('WEAPON_MACHINEPISTOL'))] = 'Tec-9',
	[tostring(GetHashKey('WEAPON_MINISMG'))] = 'Mini SMG',
	[tostring(GetHashKey('WEAPON_SMG'))] = 'MP5',
	[tostring(GetHashKey('WEAPON_SMG_MK2'))] = 'SMG Mk2	',
	[tostring(GetHashKey('WEAPON_ASSAULTSMG'))] = 'Munição de MTAR-21',
	[tostring(GetHashKey('WEAPON_COMBATPDW'))] = 'Sig Sauer MPX',
	[tostring(GetHashKey('WEAPON_MG'))] = 'MG',
	[tostring(GetHashKey('WEAPON_COMBATMG'))] = 'Combat MG',
	[tostring(GetHashKey('WEAPON_COMBATMG_MK2'))] = 'Combat MG Mk2',
	[tostring(GetHashKey('WEAPON_GUSENBERG'))] = 'Thompson',
	[tostring(GetHashKey('WEAPON_RAYCARBINE'))] = 'Unholy Deathbringer',
	[tostring(GetHashKey('WEAPON_ASSAULTRIFLE'))] = 'AK-103',
	[tostring(GetHashKey('WEAPON_ASSAULTRIFLE_MK2'))] = 'Assault Rifle Mk2',
	[tostring(GetHashKey('WEAPON_CARBINERIFLE'))] = 'M4A1',
	[tostring(GetHashKey('WEAPON_CARBINERIFLE_MK2'))] = 'Carbine Rifle Mk2',
	[tostring(GetHashKey('WEAPON_ADVANCEDRIFLE'))] = 'Advanced Rifle',
	[tostring(GetHashKey('WEAPON_SPECIALCARBINE'))] = 'Parafall',
	[tostring(GetHashKey('WEAPON_SPECIALCARBINE_MK2'))] = 'Special Carbine Mk2',
	[tostring(GetHashKey('WEAPON_BULLPUPRIFLE'))] = 'Bullpup',
	[tostring(GetHashKey('WEAPON_BULLPUPRIFLE_MK2'))] = 'Bullpup Rifle Mk2',
	[tostring(GetHashKey('WEAPON_COMPACTRIFLE'))] = 'AKS',
	[tostring(GetHashKey('WEAPON_SNIPERRIFLE'))] = 'Sniper Rifle',
	[tostring(GetHashKey('WEAPON_HEAVYSNIPER'))] = 'Heavy Sniper',
	[tostring(GetHashKey('WEAPON_HEAVYSNIPER_MK2'))] = 'Heavy Sniper Mk2',
	[tostring(GetHashKey('WEAPON_MARKSMANRIFLE'))] = 'Marksman Rifle',
	[tostring(GetHashKey('WEAPON_MARKSMANRIFLE_MK2'))] = 'Marksman Rifle Mk2',
	[tostring(GetHashKey('WEAPON_GRENADE'))] = 'Grenade',
	[tostring(GetHashKey('WEAPON_STICKYBOMB'))] = 'Sticky Bomb',
	[tostring(GetHashKey('WEAPON_PROXMINE'))] = 'Proximity Mine',
	[tostring(GetHashKey('WEAPON_PIPEBOMB'))] = 'Pipe Bomb',
	[tostring(GetHashKey('WEAPON_SMOKEGRENADE'))] = 'Tear Gas',
	[tostring(GetHashKey('WEAPON_BZGAS'))] = 'BZ Gas',
	[tostring(GetHashKey('WEAPON_MOLOTOV'))] = 'Molotov',
	[tostring(GetHashKey('WEAPON_FIREEXTINGUISHER'))] = 'Extintor de Incêndio',
	[tostring(GetHashKey('WEAPON_PETROLCAN'))] = 'Galão de Gasolina',
	[tostring(GetHashKey('WEAPON_BALL'))] = 'Ball',
	[tostring(GetHashKey('WEAPON_SNOWBALL'))] = 'Snowball',
	[tostring(GetHashKey('WEAPON_FLARE'))] = 'Flare',
	[tostring(GetHashKey('WEAPON_GRENADELAUNCHER'))] = 'Grenade Launcher',
	[tostring(GetHashKey('WEAPON_RPG'))] = 'RPG',
	[tostring(GetHashKey('WEAPON_MINIGUN'))] = 'Minigun',
	[tostring(GetHashKey('WEAPON_FIREWORK'))] = 'Firework Launcher',
	[tostring(GetHashKey('WEAPON_RAILGUN'))] = 'Railgun',
	[tostring(GetHashKey('WEAPON_HOMINGLAUNCHER'))] = 'Homing Launcher',
	[tostring(GetHashKey('WEAPON_COMPACTLAUNCHER'))] = 'Compact Grenade Launcher',
	[tostring(GetHashKey('WEAPON_RAYMINIGUN'))] = 'Widowmaker',
	[tostring(GetHashKey('WEAPON_PUMPSHOTGUN'))] = 'Remington 870',
	[tostring(GetHashKey('WEAPON_PUMPSHOTGUN_MK2'))] = 'Remington MK2',
	[tostring(GetHashKey('WEAPON_SAWNOFFSHOTGUN'))] = 'Shotgun',
	[tostring(GetHashKey('WEAPON_BULLPUPSHOTGUN'))] = 'Bullpup Shotgun',
	[tostring(GetHashKey('WEAPON_ASSAULTSHOTGUN'))] = 'Assault Shotgun',
	[tostring(GetHashKey('WEAPON_MUSKET'))] = 'Musket',
	[tostring(GetHashKey('WEAPON_HEAVYSHOTGUN'))] = 'Heavy Shotgun',
	[tostring(GetHashKey('WEAPON_DBSHOTGUN'))] = 'Double Barrel Shotgun',
	[tostring(GetHashKey('WEAPON_SWEEPERSHOTGUN'))] = 'Sweeper Shotgun',
	[tostring(GetHashKey('WEAPON_REMOTESNIPER'))] = 'Remote Sniper',
	[tostring(GetHashKey('WEAPON_GRENADELAUNCHER_SMOKE'))] = 'Smoke Grenade Launcher',
	[tostring(GetHashKey('WEAPON_PASSENGER_ROCKET'))] = 'Passenger Rocket',
	[tostring(GetHashKey('WEAPON_AIRSTRIKE_ROCKET'))] = 'Airstrike Rocket',
	[tostring(GetHashKey('WEAPON_STINGER'))] = 'Stinger [Veiculo]',
	[tostring(GetHashKey('OBJECT'))] = 'Objeto',
	[tostring(GetHashKey('VEHICLE_WEAPON_TANK'))] = 'Tank Cannon',
	[tostring(GetHashKey('VEHICLE_WEAPON_SPACE_ROCKET'))] = 'Rockets',
	[tostring(GetHashKey('VEHICLE_WEAPON_PLAYER_LASER'))] = 'Laser',
	[tostring(GetHashKey('AMMO_RPG'))] = 'Rocket',
	[tostring(GetHashKey('AMMO_TANK'))] = 'Tank',
	[tostring(GetHashKey('AMMO_SPACE_ROCKET'))] = 'Rocket',
	[tostring(GetHashKey('AMMO_PLAYER_LASER'))] = 'Laser',
	[tostring(GetHashKey('AMMO_ENEMY_LASER'))] = 'Laser',
	[tostring(GetHashKey('WEAPON_RAMMED_BY_CAR'))] = 'Atropelado por veiculo',
	[tostring(GetHashKey('WEAPON_FIRE'))] = 'Fogo',
	[tostring(GetHashKey('WEAPON_HELI_CRASH'))] = 'Acidente de Helicoptero',
	[tostring(GetHashKey('WEAPON_RUN_OVER_BY_CAR'))] = 'Atropelado por veiculo',
	[tostring(GetHashKey('WEAPON_HIT_BY_WATER_CANNON'))] = 'Canhão de Água',
	[tostring(GetHashKey('WEAPON_EXHAUSTION'))] = 'Exaustão',
	[tostring(GetHashKey('WEAPON_EXPLOSION'))] = 'Explosão',
	[tostring(GetHashKey('WEAPON_ELECTRIC_FENCE'))] = 'Cerca elétrica',
	[tostring(GetHashKey('WEAPON_BLEEDING'))] = 'Sangrando',
	[tostring(GetHashKey('WEAPON_DROWNING_IN_VEHICLE'))] = 'Afogamento em veiculo',
	[tostring(GetHashKey('WEAPON_DROWNING'))] = 'Afogamento',
	[tostring(GetHashKey('WEAPON_BARBED_WIRE'))] = 'Arame farpado',
	[tostring(GetHashKey('WEAPON_VEHICLE_ROCKET'))] = 'Vehicle Rocket',
	[tostring(GetHashKey('VEHICLE_WEAPON_ROTORS'))] = 'Rotores',
	[tostring(GetHashKey('WEAPON_AIR_DEFENCE_GUN'))] = 'Arma de defesa aérea',
	[tostring(GetHashKey('WEAPON_ANIMAL'))] = 'Animal',
	[tostring(GetHashKey('WEAPON_COUGAR'))] = 'Onça'
}

return CONFIG_