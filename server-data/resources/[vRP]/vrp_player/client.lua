local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPNclient = {}
Tunnel.bindInterface("vrp_player",vRPNclient)

emP = Tunnel.getInterface("vrp_player")



-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCARJACK
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1)
			if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId())) then
				local veh = GetVehiclePedIsTryingToEnter(PlayerPedId())
				if GetVehicleDoorLockStatus(veh) >= 2 or GetPedInVehicleSeat(veh, -1) then
					TriggerServerEvent("TryDoorsEveryone", veh, 2, GetVehicleNumberPlateText(veh))
					Citizen.Wait(2000)
				end
			end
		end
	end
)

RegisterNetEvent("SyncDoorsEveryone")
AddEventHandler(
	"SyncDoorsEveryone",
	function(veh, doors)
		SetVehicleDoorsLocked(veh, doors)
	end
)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DESABILITAR A CORONHADA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local ped = PlayerPedId()
        if IsPedArmed(ped,6) then
            DisableControlAction(0,140,true)
            DisableControlAction(0,141,true)
            DisableControlAction(0,142,true)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- RESOLVER ERRO DE VAZAMENTO DE AUDIO NA CITY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        NetworkSetTalkerProximity(8.0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /COR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cor",function(source,args)
    local tinta = tonumber(args[1])
    local ped = PlayerPedId()
	local arma = GetSelectedPedWeapon(ped)
		if tinta >= 0 and emP.checkPermission() then
			SetPedWeaponTintIndex(ped,arma,tinta)
		else
			TriggerEvent("Notify", "negado", "Necessário <b>Nitro Boost, VIP Prata ou superior</b> para utilizar <b>/cor</b>")
        end
end,false)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /VTUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand(
	"vtuning",
	function(source, args)
		local vehicle = GetVehiclePedIsUsing(PlayerPedId())
		if IsEntityAVehicle(vehicle) then
			local motor = GetVehicleMod(vehicle, 11)
			local freio = GetVehicleMod(vehicle, 12)
			local transmissao = GetVehicleMod(vehicle, 13)
			local suspensao = GetVehicleMod(vehicle, 15)
			local blindagem = GetVehicleMod(vehicle, 16)
			local body = GetVehicleBodyHealth(vehicle)
			local engine = GetVehicleEngineHealth(vehicle)
			local fuel = GetVehicleFuelLevel(vehicle)

			if motor == -1 then
				motor = "Desativado"
			elseif motor == 0 then
				motor = "Nível 1 / " .. GetNumVehicleMods(vehicle, 11)
			elseif motor == 1 then
				motor = "Nível 2 / " .. GetNumVehicleMods(vehicle, 11)
			elseif motor == 2 then
				motor = "Nível 3 / " .. GetNumVehicleMods(vehicle, 11)
			elseif motor == 3 then
				motor = "Nível 4 / " .. GetNumVehicleMods(vehicle, 11)
			elseif motor == 4 then
				motor = "Nível 5 / " .. GetNumVehicleMods(vehicle, 11)
			end

			if freio == -1 then
				freio = "Desativado"
			elseif freio == 0 then
				freio = "Nível 1 / " .. GetNumVehicleMods(vehicle, 12)
			elseif freio == 1 then
				freio = "Nível 2 / " .. GetNumVehicleMods(vehicle, 12)
			elseif freio == 2 then
				freio = "Nível 3 / " .. GetNumVehicleMods(vehicle, 12)
			end

			if transmissao == -1 then
				transmissao = "Desativado"
			elseif transmissao == 0 then
				transmissao = "Nível 1 / " .. GetNumVehicleMods(vehicle, 13)
			elseif transmissao == 1 then
				transmissao = "Nível 2 / " .. GetNumVehicleMods(vehicle, 13)
			elseif transmissao == 2 then
				transmissao = "Nível 3 / " .. GetNumVehicleMods(vehicle, 13)
			elseif transmissao == 3 then
				transmissao = "Nível 4 / " .. GetNumVehicleMods(vehicle, 13)
			end

			if suspensao == -1 then
				suspensao = "Desativado"
			elseif suspensao == 0 then
				suspensao = "Nível 1 / " .. GetNumVehicleMods(vehicle, 15)
			elseif suspensao == 1 then
				suspensao = "Nível 2 / " .. GetNumVehicleMods(vehicle, 15)
			elseif suspensao == 2 then
				suspensao = "Nível 3 / " .. GetNumVehicleMods(vehicle, 15)
			elseif suspensao == 3 then
				suspensao = "Nível 4 / " .. GetNumVehicleMods(vehicle, 15)
			end

			if blindagem == -1 then
				blindagem = "Desativado"
			elseif blindagem == 0 then
				blindagem = "Nível 1 / " .. GetNumVehicleMods(vehicle, 16)
			elseif blindagem == 1 then
				blindagem = "Nível 2 / " .. GetNumVehicleMods(vehicle, 16)
			elseif blindagem == 2 then
				blindagem = "Nível 3 / " .. GetNumVehicleMods(vehicle, 16)
			elseif blindagem == 3 then
				blindagem = "Nível 4 / " .. GetNumVehicleMods(vehicle, 16)
			elseif blindagem == 4 then
				blindagem = "Nível 5 / " .. GetNumVehicleMods(vehicle, 16)
			end

			TriggerEvent(
				"Notify",
				"importante",
				"<b>Motor:</b> " ..
					motor ..
						"<br><b>Freio:</b> " ..
							freio ..
								"<br><b>Transmissão:</b> " ..
									transmissao ..
										"<br><b>Suspensão:</b> " ..
											suspensao ..
												"<br><b>Blindagem:</b> " ..
													blindagem ..
														"<br><b>Chassi:</b> " ..
															parseInt(body / 10) ..
																"%<br><b>Engine:</b> " .. parseInt(engine / 10) .. "%<br><b>Gasolina:</b> " .. parseInt(fuel) .. "%",
				15000
			)
		end
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
--  ESTOURAR OS PNEUS QUANDO CAPOTA + FOGO NO TANQUE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
		local TaylinSleep = 500
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then
			TaylinSleep = 1
            local vehicle = GetVehiclePedIsIn(ped)
            if GetPedInVehicleSeat(vehicle,-1) == ped then
				local roll = GetEntityRoll(vehicle)
				local altura = GetEntityHeightAboveGround(vehicle)
				if roll > 150.0 then
					-- print("Eixo: ",roll)
					-- print("Altura: ",altura)
                    if IsVehicleTyreBurst(vehicle, wheel_rm1, 0) == false then
                    	-- SetVehiclePetrolTankHealth(vehicle, -4000, 1)
                    	-- SetVehicleEngineTemperature(vehicle, 5000, 1)
                    	-- SetVehicleEngineHealth(vehicle, -4000, 1)
                    	SetVehicleTyreBurst(vehicle, 0, 1)
                    	Citizen.Wait(100)
                    	SetVehicleTyreBurst(vehicle, 1, 1)
                    	Citizen.Wait(100)
                    	SetVehicleTyreBurst(vehicle, 2, 1)
                    	Citizen.Wait(100)
                    	SetVehicleTyreBurst(vehicle, 3, 1)
                    	Citizen.Wait(100)
                    	SetVehicleTyreBurst(vehicle, 4, 1)
                    	Citizen.Wait(100)
                    	SetVehicleTyreBurst(vehicle, 5, 1)
                    	Citizen.Wait(100)
                    	SetVehicleTyreBurst(vehicle, 45, 1)
                    	Citizen.Wait(100)
                    	SetVehicleTyreBurst(vehicle, 47, 1)
                    end
                end
            end
        end
		Citizen.Wait(TaylinSleep)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AGACHAR
-----------------------------------------------------------------------------------------------------------------------------------------
local agachar = false
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(10)
			local ped = PlayerPedId()
			DisableControlAction(0, 36, true)
			if not IsPedInAnyVehicle(ped) then
				RequestAnimSet("move_ped_crouched")
				RequestAnimSet("move_ped_crouched_strafing")
				if IsDisabledControlJustPressed(0, 36) then
					if agachar then
						ResetPedMovementClipset(ped, 0.25)
						ResetPedStrafeClipset(ped)
						agachar = false
					else
						SetPedMovementClipset(ped, "move_ped_crouched", 0.25)
						SetPedStrafeClipset(ped, "move_ped_crouched_strafing")
						agachar = true
					end
				end
			end
		end
	end
)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = PlayerPedId()
        local player = PlayerId()
        if agachar then 
            DisablePlayerFiring(player, true)
        end
    end
end)

----------------------------------------------------------------------------
-- AUMENTAR E REMOVER DANO DE ARMAS
----------------------------------------------------------------------------
--------------------------
-- FUZIS = 3.5 DE DANO  --
-- SMGS = 2.5 DE DANO   --
-- PISTOLAS 3.0 DE DANO --
--------------------------
--  Citizen.CreateThread(function()
--  	while true do
-- 		N_0x4757f00bc6323cfe(GetHashKey("weapon_knuckle"), 0.1)
--  		Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SNOWBALL"), 0.00)
--  		Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SMOKEGRENADE"), 0.00)
--  		Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_RAYPISTOL"), 0.00)
--  		Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MOLOTOV"), 0.00)
--  		Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BZGAS"), 0.20)
--  		Wait(0)
--  	    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 1.0) 
--      	Wait(0)
--      	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"), 0.0) -- Cassetete
--      	Wait(0)
--      	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_FLASHLIGHT"), 0.0) -- Lanterna
--      	Wait(0)
--      	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_STUNGUN"), 0.0) -- Tazer
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PUMPSHOTGUN_MK2"), 0.7) -- SHOTGUN DA POLICIA
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_HEAVYSHOTGUN"), 0.0) 
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ASSAULTRIFLE"), 0.0)
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BULLPUPRIFLE"), 0.0)
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SPECIALCARBINE"), 1.5) -- G36x
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ASSAULTRIFLE_MK2"), 1.5) -- AK-47
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_CARBINERIFLE_MK2"), 1.5) -- M4A1
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SPECIAlCARBINE_MK2"), 1.5) -- G36
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_CARBINERIFLE"), 1.5) -- AR-15
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_COMBATPISTOL"), 1.2) -- GLOCK
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MACHINEPISTOL"), 0.0)
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_COMBATPDW"), 1.2) -- SIGSAUER
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SMOKEGRENADE"), 0.0)
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_APPISTOL"), 0.0)
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL"), 1.2) -- M1911
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_REVOLVER"), 0.0)
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_VINTAGEPISTOL"), 0.0)
--  		Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SMG_MK2"), 1.2) -- MP5-MK2
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SMG"), 0.0)
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ASSAULTSMG"), 0.0)
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MICROSMG"), 0.0)
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MG"), 3.0)
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_HEAVYSNIPER"), 0.0)
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SNIPERRIFLE"), 0.0)
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SAWNOFFSHOTGUN"), 0.7) -- SHOTGUN ILEGAL
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_DBSHOTGUN"), 0.0)
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL_MK2"), 1.2) -- FIVE-SEVEN
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MINISMG"), 1.5) -- SCORPION
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SNSPISTOL"), 1.0) -- SNS PISTOL
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL50"), 0.0)
--      	Wait(0)
--  		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_RAYPISTOL"), 0.0)
--      	Wait(0)
--      end
--  end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /ATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("attachs",function(source,args)
	local ped = PlayerPedId()
	if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SPECIALCARBINE_MK2") then -- G36C
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2")) -- MIRA GRANDE
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_AT_MUZZLE_02")) -- FREIO DE BOCA TATICO
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_AT_AR_AFGRIP_02")) -- EMPUNHADURA
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SPECIALCARBINE") then -- G36x
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM")) -- MIRA GRANDE
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_AT_AR_FLSH")) -- LANTERNA
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_AT_AR_AFGRIP")) -- EMPUNHADURA
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then -- AK-47
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2")) -- MIRA GRANDE
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),GetHashKey("COMPONENT_AT_MUZZLE_02")) -- FREIO DE BOCA TATICO
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_AFGRIP_02")) -- EMPUNHADURA
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG_MK2") then -- MP5-MK2
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG_MK2"),GetHashKey("COMPONENT_AT_SCOPE_SMALL_SMG_MK2")) -- MIRA MEDIA
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG_MK2"),GetHashKey("COMPONENT_AT_MUZZLE_02")) -- FREIO DE BOCA TATICO
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG_MK2"),GetHashKey("COMPONENT_AT_SB_BARREL_01")) -- CANO PESADO
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL_MK2") then -- FIVE-SEVEN
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_COMP")) -- COMPENSADOR
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_RAIL")) -- MIRA
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_FLSH_02")) -- LANTERNA
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_PISTOL_MK2_CLIP_02")) -- CARREGADOR ESTENDIDO
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL") then -- M1911
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH")) -- LANTERNA
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL"),GetHashKey("COMPONENT_PISTOL_CLIP_02")) -- CARREGADOR ESTENDIDO
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE_MK2") then -- M4A1
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2")) -- MIRA GRANDE
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_MUZZLE_02")) -- FREIO DE BOCA TATICO
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_AFGRIP_02")) -- EMPUNHADURA
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE") then -- AR-15
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM")) -- MIRA GRANDE
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_AFGRIP")) -- EMPUNHADURA
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPDW") then -- SIG SAUER
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_SCOPE_SMALL")) -- MIRA
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_AR_AFGRIP")) -- EMPUNHADURA
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_AR_FLSH")) -- LANTERNA
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPISTOL") then -- GLOCK
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH")) -- LANTERNA
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_COMBATPISTOL_CLIP_02")) -- CARREGADOR ESTENDIDO	
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /SILENCIADOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("sil",function(source,args)
	if emP.checkPermissionSilenciador() then
		local ped = PlayerPedId()
		if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SPECIALCARBINE_MK2") then -- G36C
    	    GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_AT_AR_SUPP_02"))
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then -- AK-47
    	    GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_SUPP_02"))
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG_MK2") then -- MP5-MK2
    	    GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG_MK2"),GetHashKey("COMPONENT_AT_PI_SUPP"))
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL_MK2") then -- FIVE-SEVEN
    	    GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_SUPP_02"))
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL") then -- M1911
    	    GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL"),GetHashKey("COMPONENT_AT_PI_SUPP_02"))
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SPECIALCARBINE") then -- G36X
    	    GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),GetHashKey("COMPONENT_AT_AR_SUPP_02"))
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE_MK2") then -- M4A1
    	    GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_SUPP"))
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE") then -- AR-15
    	    GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_SUPP"))
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPISTOL") then -- GLOCK
    	    GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_AT_PI_SUPP"))	
		end
	else
		TriggerEvent("Notify", "negado", "Necessário <b>VIP Platina ou superior</b> para utilizar <b>/sil</b>")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEBIDAS ENERGETICAS
-----------------------------------------------------------------------------------------------------------------------------------------
local energetico = false
RegisterNetEvent("energeticos")
AddEventHandler(
	"energeticos",
	function(status)
		energetico = status
		if energetico then
			SetRunSprintMultiplierForPlayer(PlayerId(), 1.15)
		else
			SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1)
			if energetico then
				RestorePlayerStamina(PlayerId(), 1.0)
			end
		end
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLONAR PLACAS
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterNetEvent("cloneplates")
-- AddEventHandler(
-- 	"cloneplates",
-- 	function()
-- 		local vehicle = GetVehiclePedIsUsing(PlayerPedId())
-- 		if IsEntityAVehicle(vehicle) then
-- 			SetVehicleNumberPlateText(vehicle, "CLONADOS")
-- 		end
-- 	end
-- )
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELANDO O F6
-----------------------------------------------------------------------------------------------------------------------------------------
local cancelando = false
RegisterNetEvent("cancelando")
AddEventHandler(
	"cancelando",
	function(status)
		cancelando = status
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1)
			if cancelando then
				BlockWeaponWheelThisFrame()
				DisableControlAction(0, 29, true)
				DisableControlAction(0, 38, true)
				DisableControlAction(0, 47, true)
				DisableControlAction(0, 56, true)
				DisableControlAction(0, 57, true)
				DisableControlAction(0, 73, true)
				DisableControlAction(0, 137, true)
				DisableControlAction(0, 166, true)
				DisableControlAction(0, 167, true)
				DisableControlAction(0, 169, true)
				DisableControlAction(0, 170, true)
				DisableControlAction(0, 182, true)
				DisableControlAction(0, 187, true)
				DisableControlAction(0, 188, true)
				DisableControlAction(0, 189, true)
				DisableControlAction(0, 190, true)
				DisableControlAction(0, 243, true)
				DisableControlAction(0, 245, true)
				DisableControlAction(0, 257, true)
				DisableControlAction(0, 288, true)
				DisableControlAction(0, 289, true)
				DisableControlAction(0, 311, true)
				DisableControlAction(0, 344, true)
			end
		end
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AFKSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		if x == px and y == py then
			if tempo > 0 then
				tempo = tempo - 1
				if tempo == 600 then
					TriggerEvent("Notify", "aviso", "Mexa-se ou será desconectado(a) em <b>10 minutos</b>")
				elseif tempo == 300 then
					TriggerEvent("Notify", "aviso", "Mexa-se ou será desconectado(a) em <b>5 minutos</b>")
				end
			else
				TriggerServerEvent("kickAFK")
			end
		else
			tempo = 1800
		end
		px = x
		py = y
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR PORTA-MALAS DO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand(
	"malas",
	function(source, args)
		local vehicle = vRP.getNearestVehicle(7)
		if IsEntityAVehicle(vehicle) then
			TriggerServerEvent("trytrunk", VehToNet(vehicle))
		end
	end
)

RegisterNetEvent("synctrunk")
AddEventHandler(
	"synctrunk",
	function(index)
		if NetworkDoesNetworkIdExist(index) then
			local v = NetToVeh(index)
			local isopen = GetVehicleDoorAngleRatio(v, 5)
			if DoesEntityExist(v) then
				if IsEntityAVehicle(v) then
					if isopen == 0 then
						SetVehicleDoorOpen(v, 5, 0, 0)
					else
						SetVehicleDoorShut(v, 5, 0)
					end
				end
			end
		end
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR CAPO DO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand(
	"capo",
	function(source, args)
		local vehicle = vRP.getNearestVehicle(7)
		if IsEntityAVehicle(vehicle) then
			TriggerServerEvent("tryhood", VehToNet(vehicle))
		end
	end
)

RegisterNetEvent("synchood")
AddEventHandler(
	"synchood",
	function(index)
		if NetworkDoesNetworkIdExist(index) then
			local v = NetToVeh(index)
			local isopen = GetVehicleDoorAngleRatio(v, 4)
			if DoesEntityExist(v) then
				if IsEntityAVehicle(v) then
					if isopen == 0 then
						SetVehicleDoorOpen(v, 4, 0, 0)
					else
						SetVehicleDoorShut(v, 4, 0)
					end
				end
			end
		end
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRE E FECHA OS VIDROS
-----------------------------------------------------------------------------------------------------------------------------------------
local vidros = false
RegisterCommand(
	"vidros",
	function(source, args)
		local vehicle = vRP.getNearestVehicle(7)
		if IsEntityAVehicle(vehicle) then
			TriggerServerEvent("trywins", VehToNet(vehicle))
		end
	end
)

RegisterNetEvent("syncwins")
AddEventHandler(
	"syncwins",
	function(index)
		if NetworkDoesNetworkIdExist(index) then
			local v = NetToVeh(index)
			if DoesEntityExist(v) then
				if IsEntityAVehicle(v) then
					if vidros then
						vidros = false
						RollUpWindow(v, 0)
						RollUpWindow(v, 1)
						RollUpWindow(v, 2)
						RollUpWindow(v, 3)
					else
						vidros = true
						RollDownWindow(v, 0)
						RollDownWindow(v, 1)
						RollDownWindow(v, 2)
						RollDownWindow(v, 3)
					end
				end
			end
		end
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR PORTAS DO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand(
	"portas",
	function(source, args)
		local vehicle = vRP.getNearestVehicle(7)
		if IsEntityAVehicle(vehicle) then
			TriggerServerEvent("trydoors", VehToNet(vehicle), args[1])
		end
	end
)

RegisterNetEvent("syncdoors")
AddEventHandler(
	"syncdoors",
	function(index, door)
		if NetworkDoesNetworkIdExist(index) then
			local v = NetToVeh(index)
			local isopen = GetVehicleDoorAngleRatio(v, 0) and GetVehicleDoorAngleRatio(v, 1)
			if DoesEntityExist(v) then
				if IsEntityAVehicle(v) then
					if door == "1" then
						if GetVehicleDoorAngleRatio(v, 0) == 0 then
							SetVehicleDoorOpen(v, 0, 0, 0)
						else
							SetVehicleDoorShut(v, 0, 0)
						end
					elseif door == "2" then
						if GetVehicleDoorAngleRatio(v, 1) == 0 then
							SetVehicleDoorOpen(v, 1, 0, 0)
						else
							SetVehicleDoorShut(v, 1, 0)
						end
					elseif door == "3" then
						if GetVehicleDoorAngleRatio(v, 2) == 0 then
							SetVehicleDoorOpen(v, 2, 0, 0)
						else
							SetVehicleDoorShut(v, 2, 0)
						end
					elseif door == "4" then
						if GetVehicleDoorAngleRatio(v, 3) == 0 then
							SetVehicleDoorOpen(v, 3, 0, 0)
						else
							SetVehicleDoorShut(v, 3, 0)
						end
					elseif door == nil then
						if isopen == 0 then
							SetVehicleDoorOpen(v, 0, 0, 0)
							SetVehicleDoorOpen(v, 1, 0, 0)
							SetVehicleDoorOpen(v, 2, 0, 0)
							SetVehicleDoorOpen(v, 3, 0, 0)
						else
							SetVehicleDoorShut(v, 0, 0)
							SetVehicleDoorShut(v, 1, 0)
							SetVehicleDoorShut(v, 2, 0)
							SetVehicleDoorShut(v, 3, 0)
						end
					end
				end
			end
		end
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /MASCARA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("mascara")
AddEventHandler(
	"mascara",
	function(index, color)
		local ped = GetPlayerPed(-1)
		if index == nil then
			vRP.playAnim(true, {{"misscommon@std_take_off_masks", "take_off_mask_ps", 1}}, false)
			Wait(700)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped, 1, 0, 0, 2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") or GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP.playAnim(true, {{"misscommon@van_put_on_masks", "put_on_mask_ps", 1}}, false)
			Wait(1500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped, 1, parseInt(index), parseInt(color), 2)
		end
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /blusa
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("blusa")
AddEventHandler(
	"blusa",
	function(index, color)
		local ped = GetPlayerPed(-1)
		if index == nil then
			SetPedComponentVariation(ped, 8, 15, 0, 2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			SetPedComponentVariation(ped, 8, parseInt(index), parseInt(color), 2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(ped, 8, parseInt(index), parseInt(color), 2)
		end
	end
)


-----------------------------------------------------------------------------------------------------------------------------------------
-- SETSAPATOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setsapatos')
AddEventHandler('setsapatos',function(modelo,cor)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and src.checkRoupas() and not IsPedInAnyVehicle(ped) then
		if not modelo then
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				vRP._playAnim(false,{{"clothingshoes","try_shoes_positive_d"}},false)
				Wait(2200)
				SetPedComponentVariation(ped,6,34,0,2)
				Wait(500)
				ClearPedTasks(ped)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				vRP._playAnim(false,{{"clothingshoes","try_shoes_positive_d"}},false)
				Wait(2200)
				SetPedComponentVariation(ped,6,35,0,2)
				Wait(500)
				ClearPedTasks(ped)
			end
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(false,{{"clothingshoes","try_shoes_positive_d"}},false)
			Wait(2200)
			SetPedComponentVariation(ped,6,parseInt(modelo),parseInt(cor),2)
			Wait(500)
			ClearPedTasks(ped)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(false,{{"clothingshoes","try_shoes_positive_d"}},false)
			Wait(2200)
			SetPedComponentVariation(ped,6,parseInt(modelo),parseInt(cor),2)
			Wait(500)
			ClearPedTasks(ped)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /jaqueta
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("jaqueta")
AddEventHandler(
	"jaqueta",
	function(index, color)
		local ped = GetPlayerPed(-1)
		if index == nil then
			SetPedComponentVariation(ped, 11, 15, 0, 2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			SetPedComponentVariation(ped, 11, parseInt(index), parseInt(color), 2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(ped, 11, parseInt(index), parseInt(color), 2)
		end
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /calca
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("calca")
AddEventHandler(
	"calca",
	function(index, color)
		local ped = GetPlayerPed(-1)
		if index == nil then
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				SetPedComponentVariation(ped, 4, 18, 0, 2)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				SetPedComponentVariation(ped, 4, 15, 0, 2)
			end
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			SetPedComponentVariation(ped, 4, parseInt(index), parseInt(color), 2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(ped, 4, parseInt(index), parseInt(color), 2)
		end
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /maos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("maos")
AddEventHandler(
	"maos",
	function(index, color)
		local ped = GetPlayerPed(-1)
		if index == nil then
			SetPedComponentVariation(ped, 3, 15, 0, 2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			SetPedComponentVariation(ped, 3, parseInt(index), parseInt(color), 2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(ped, 3, parseInt(index), parseInt(color), 2)
		end
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /acessorios
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("acessorios")
AddEventHandler(
	"acessorios",
	function(index, color)
		local ped = GetPlayerPed(-1)
		if index == nil then
			SetPedComponentVariation(ped, 7, 0, 0, 2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			SetPedComponentVariation(ped, 7, parseInt(index), parseInt(color), 2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(ped, 7, parseInt(index), parseInt(color), 2)
		end
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /sapatos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("sapatos")
AddEventHandler(
	"sapatos",
	function(index, color)
		local ped = GetPlayerPed(-1)
		if index == nil then
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				SetPedComponentVariation(ped, 6, 34, 0, 2)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				SetPedComponentVariation(ped, 6, 35, 0, 2)
			end
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			SetPedComponentVariation(ped, 6, parseInt(index), parseInt(color), 2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(ped, 6, parseInt(index), parseInt(color), 2)
		end
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /CHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chapeu")
AddEventHandler(
	"chapeu",
	function(index, color)
		local ped = GetPlayerPed(-1)
		if index == nil then
			vRP.playAnim(true, {{"veh@common@fp_helmet@", "take_off_helmet_stand", 1}}, false)
			Wait(700)
			ClearPedProp(ped, 0)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP.playAnim(true, {{"veh@common@fp_helmet@", "put_on_helmet", 1}}, false)
			Wait(1700)
			SetPedPropIndex(ped, 0, parseInt(index), parseInt(color), 2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP.playAnim(true, {{"veh@common@fp_helmet@", "put_on_helmet", 1}}, false)
			Wait(1700)
			SetPedPropIndex(ped, 0, parseInt(index), parseInt(color), 2)
		end
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /OCULOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("oculos")
AddEventHandler(
	"oculos",
	function(index, color)
		local ped = GetPlayerPed(-1)
		if index == nil then
			vRP.playAnim(true, {{"misscommon@std_take_off_masks", "take_off_mask_ps", 1}}, false)
			Wait(400)
			ClearPedTasks(ped)
			ClearPedProp(ped, 1)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP.playAnim(true, {{"misscommon@van_put_on_masks", "put_on_mask_ps", 1}}, false)
			Wait(800)
			ClearPedTasks(ped)
			SetPedPropIndex(ped, 1, parseInt(index), parseInt(color), 2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP.playAnim(true, {{"misscommon@van_put_on_masks", "put_on_mask_ps", 1}}, false)
			Wait(800)
			ClearPedTasks(ped)
			SetPedPropIndex(ped, 1, parseInt(index), parseInt(color), 2)
		end
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /TOW
-----------------------------------------------------------------------------------------------------------------------------------------
local reboque = nil
local rebocado = nil
RegisterCommand(
	"tow",
	function(source, args)
		local vehicle = GetPlayersLastVehicle()
		vehicletow = IsVehicleModel(vehicle, GetHashKey("flatbed"))

		if vehicletow and not IsPedInAnyVehicle(PlayerPedId()) then
			rebocado =
				getVehicleInDirection(
				GetEntityCoords(PlayerPedId()),
				GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 5.0, 0.0)
			)
			if IsEntityAVehicle(vehicle) and IsEntityAVehicle(rebocado) then
				TriggerServerEvent("trytow", VehToNet(vehicle), VehToNet(rebocado))
			end
		else
			TriggerEvent("Notify", "negado", "Entre e saia do seu gincho e tente novamente")
		end
	end
)

RegisterNetEvent("synctow")
AddEventHandler(
	"synctow",
	function(vehid, rebid)
		if NetworkDoesNetworkIdExist(vehid) and NetworkDoesNetworkIdExist(rebid) then
			local vehicle = NetToVeh(vehid)
			local rebocado = NetToVeh(rebid)
			if DoesEntityExist(vehicle) and DoesEntityExist(rebocado) then
				if reboque == nil then
					if vehicle ~= rebocado then
						local min, max = GetModelDimensions(GetEntityModel(rebocado))
						AttachEntityToEntity(
							rebocado,
							vehicle,
							GetEntityBoneIndexByName(vehicle, "bodyshell"),
							0,
							-2.2,
							0.4 - min.z,
							0,
							0,
							0,
							1,
							1,
							0,
							1,
							0,
							1
						)
						reboque = rebocado
					end
				else
					AttachEntityToEntity(reboque, vehicle, 20, -0.5, -15.0, -0.3, 0.0, 0.0, 0.0, false, false, true, false, 20, true)
					DetachEntity(reboque, false, false)
					PlaceObjectOnGroundProperly(reboque)
					reboque = nil
					rebocado = nil
				end
			end
		end
	end
)

function getVehicleInDirection(coordsfrom, coordsto)
	local handle =
		CastRayPointToPoint(
		coordsfrom.x,
		coordsfrom.y,
		coordsfrom.z,
		coordsto.x,
		coordsto.y,
		coordsto.z,
		10,
		PlayerPedId(),
		false
	)
	local a, b, c, d, vehicle = GetRaycastResult(handle)
	return vehicle
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("reparar")
AddEventHandler(
	"reparar",
	function(vehicle)
		TriggerServerEvent("tryreparar", VehToNet(vehicle))
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR MOTOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("repararmotor")
AddEventHandler(
	"repararmotor",
	function(vehicle)
		TriggerServerEvent("trymotor", VehToNet(vehicle))
	end
)

RegisterNetEvent("syncmotor")
AddEventHandler(
	"syncmotor",
	function(index)
		if NetworkDoesNetworkIdExist(index) then
			local v = NetToVeh(index)
			if DoesEntityExist(v) then
				if IsEntityAVehicle(v) then
					SetVehicleEngineHealth(v, 1000.0)
				end
			end
		end
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRATAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tratamento")
AddEventHandler(
	"tratamento",
	function()
		repeat
			SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 1)
			Citizen.Wait(500)
		until GetEntityHealth(PlayerPedId()) >= 400 or GetEntityHealth(PlayerPedId()) <= 100
		TriggerEvent("Notify", "sucesso", "Tratamento concluido.")
	end
)
---------------------------------------------------------------------------------------------------------------------------------
-- /sequestro2
-----------------------------------------------------------------------------------------------------------------------------------------
local sequestrado = nil
RegisterCommand(
	"sequestro2",
	function(source, args)
		local ped = PlayerPedId()
		local random, npc = FindFirstPed()
		repeat
			local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(npc), true)
			if not IsPedAPlayer(npc) and distancia <= 3 and not IsPedInAnyVehicle(npc) then
				vehicle = vRP.getNearestVehicle(7)
				if IsEntityAVehicle(vehicle) then
					if vRP.getCarroClass(vehicle) then
						if sequestrado then
							AttachEntityToEntity(
								sequestrado,
								vehicle,
								GetEntityBoneIndexByName(vehicle, "bumper_r"),
								0.6,
								-1.2,
								-0.6,
								60.0,
								-90.0,
								180.0,
								false,
								false,
								false,
								true,
								2,
								true
							)
							DetachEntity(sequestrado, true, true)
							SetEntityVisible(sequestrado, true)
							SetEntityInvincible(sequestrado, false)
							SetEntityAsMissionEntity(sequestrado, false, true)
							ClearPedTasksImmediately(sequestrado)
							sequestrado = nil
						elseif not sequestrado then
							SetEntityAsMissionEntity(npc, true, true)
							AttachEntityToEntity(
								npc,
								vehicle,
								GetEntityBoneIndexByName(vehicle, "bumper_r"),
								0.6,
								-0.4,
								-0.1,
								60.0,
								-90.0,
								180.0,
								false,
								false,
								false,
								true,
								2,
								true
							)
							SetEntityVisible(npc, false)
							SetEntityInvincible(npc, true)
							sequestrado = npc
							complet = true
						end
						TriggerServerEvent("trymala", VehToNet(vehicle))
					end
				end
			end
			complet, npc = FindNextPed(random)
		until not complet
		EndFindPed(random)
	end
)

-----------------------------------------------------------------------------------------------------------------------------------------
-- NÃO IR PARA O P1 AUTOMATICAMENTE
-----------------------------------------------------------------------------------------------------------------------------------------
local disableShuffle = true
function disableSeatShuffle(flag)
	disableShuffle = flag
end

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then
				if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
					if GetIsTaskActive(GetPlayerPed(-1), 165) then
						SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
					end
				end
			end
		end
	end
)

RegisterNetEvent("SeatShuffle")
AddEventHandler(
	"SeatShuffle",
	function()
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
			disableSeatShuffle(false)
			Citizen.Wait(5000)
			disableSeatShuffle(true)
		else
			CancelEvent()
		end
	end
)

RegisterCommand(
	"p1",
	function(source, args, raw) --escolha o comando aqui
		TriggerEvent("SeatShuffle")
	end,
	false
) --False, permite que todos execute

-----------------------------------------------------------------------------------------------------------------------------------------
-- TIRAR SONS DO MAPA
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(
	function()
		StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
		SetAudioFlag("PoliceScannerDisabled", true)
	end
)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DESABILITAR O USO DO "Q" PARA ESCORAR EM OBJETOS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		local health = GetEntityHealth(ped)
		if health >= 101 then
			DisableControlAction(0, 44, true)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SCRIPT DE HS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
   while true do
        Wait(5)
        SetPedSuffersCriticalHits(PlayerPedId(-1), true)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SISTEMA DE MANCAR
-----------------------------------------------------------------------------------------------------------------------------------------
local hurt = false
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if GetEntityHealth(GetPlayerPed(-1)) <= 199 then
            setHurt()
        elseif hurt and GetEntityHealth(GetPlayerPed(-1)) >= 200 then
            setNotHurt()
        end
    end
end)

function setHurt()
    hurt = true
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(GetPlayerPed(-1), "move_m@injured", true)
	-- DisableControlAction(1, 21, true) -- Desabilita o SHIFT (Correr)
	DisableControlAction(1, 22, true) -- Desabilita o Spacebar (Pular)
end

function setNotHurt()
    hurt = false
    ResetPedMovementClipset(GetPlayerPed(-1))
    ResetPedWeaponMovementClipset(GetPlayerPed(-1))
    ResetPedStrafeClipset(GetPlayerPed(-1))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BOOST DE FPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('fps',function(source,args)
    if args[1] == 'on' then
        SetTimecycleModifier('cinema')
        TriggerEvent('Notify','sucesso','Boost de FPS ligado!')
    elseif args[1] == 'off' then
        SetTimecycleModifier('default')
        TriggerEvent('Notify','sucesso','Boost de FPS desligado!')
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- RECUO DAS ARMAS
-----------------------------------------------------------------------------------------------------------------------------------------
-- local recoils = {
-- 	-------------- PISTOLAS --------------
-- 	[-1075685676] = 0.3, -- PISTOL MK2 | FIVE-SEVEN
-- 	[1593441988] = 0.3, -- COMBAT PISTOL | GLOCK
-- 	[453432689] = 0.3, -- PISTOL | M1911
-- 	[-1076751822] = 0.3, -- SNSPISTOL | HK
-- 	-------------- SMGS --------------
-- 	[2024373456] = 0.4, -- SMG MK2 | MP5-MK2
-- 	[171789620] = 0.4, -- COMBAT PDW | SIGSAUER
-- 	[-1121678507] = 0.4, -- MINISMG | SCORPION
-- 	-------------- FUZIS --------------
-- 	[961495388] = 0.5, -- ASSAULT RIFLE MK2 | AK-47
-- 	[-1768145561] = 0.5, -- SPECIAL CARBINE MK2 | G36
-- 	[-2084633992] = 0.4, -- CARBINE RIFLE | AR-15
-- 	[-86904375] = 0.5, -- CARBINE RIFLE MK2 | M4A1
-- 	[-1063057011] = 0.5, -- SPECIAL CARBINE | G36x
--	----------------SHOTGUN-------------------
-- 	[-86904375] = 0.5, -- CARBINE RIFLE MK2 | SHOTGUN
-- 	[-1063057011] = 0.5, -- SPECIAL CARBINE | G36x
-- 	-----------------------------------
-- }
--
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(0)
-- 		if IsPedShooting(PlayerPedId()) and not IsPedDoingDriveby(PlayerPedId()) then
-- 			local _,wep = GetCurrentPedWeapon(PlayerPedId())
-- 			_,cAmmo = GetAmmoInClip(PlayerPedId(), wep)
-- 			if recoils[wep] and recoils[wep] ~= 0 then
--				tv = 0
--				if GetFollowPedCamViewMode() ~= 4 then
--					repeat 
--						Wait(0)
--						p = GetGameplayCamRelativePitch()
-- 						SetGameplayCamRelativePitch(p+0.1, 0.2)
--						tv = tv+0.1
-- 					until tv >= recoils[wep]
-- 				else
--					repeat 
-- 						Wait(0)
-- 						p = GetGameplayCamRelativePitch()
-- 						if recoils[wep] > 0.1 then
--							SetGameplayCamRelativePitch(p+0.6, 1.2)
-- 							tv = tv+0.6
--						else
-- 							SetGameplayCamRelativePitch(p+0.016, 0.333)
-- 							tv = tv+0.1
--						end
-- 					until tv >= recoils[wep]
-- 				end
-- 			end
-- 		end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /BVIDA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('bvida', function(source, args, rawCommand)
    local ped = PlayerPedId()
    if not IsEntityPlayingAnim(ped, "anim@heists@ornate_bank@grab_cash_heels","grab", 3)  then
        if not IsEntityPlayingAnim(ped, "oddjobs@shop_robbery@rob_till","loop", 3) then
            if not IsEntityPlayingAnim(ped, "amb@world_human_sunbathe@female@back@idle_a","idle_a", 3) then
                TriggerServerEvent('bvida')
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÃO PARA CHECAR DISTANCIA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPNclient.isNearCds(cds, dist)
	return GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), cds) <= dist
end

------------------------------------------------------------------------------
-- CARREGAR NO OMBRO
--------------------------------------------------------------------------------
-- local carryingBackInProgress = false

-- RegisterCommand("carregar",function(source, args)
-- 	if not carryingBackInProgress then
-- 		carryingBackInProgress = true
-- 		local player = PlayerPedId()	
-- 		lib = 'missfinale_c2mcs_1'
-- 		anim1 = 'fin_c2_mcs_1_camman'
-- 		lib2 = 'nm'
-- 		anim2 = 'firemans_carry'
-- 		distans = 0.15
-- 		distans2 = 0.27
-- 		height = 0.63
-- 		spin = 0.0		
-- 		length = 100000
-- 		controlFlagMe = 49
-- 		controlFlagTarget = 33
-- 		animFlagTarget = 1
-- 		local closestPlayer = GetClosestPlayer(3)
-- 		target = GetPlayerServerId(closestPlayer)
-- 		if closestPlayer ~= nil then
-- 			--print("triggering cmg2_animations:sync654654654")
-- 			TriggerServerEvent('cmg2_animations:sync654654654', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget)
-- 		else
-- 			print("[CMG Anim] Nenhum jogador por perto")
-- 		end
-- 	else
-- 		carryingBackInProgress = false
-- 		ClearPedSecondaryTask(GetPlayerPed(-1))
-- 		DetachEntity(GetPlayerPed(-1), true, false)
-- 		local closestPlayer = vRP.getNearestPlayer(2)
-- 		if closestPlayer then
-- 			TriggerServerEvent("cmg2_animations:stop654654654",closestPlayer)
-- 		end
-- 	end
-- end,false)

-- RegisterNetEvent('cmg2_animations:syncTarget654654654')
-- AddEventHandler('cmg2_animations:syncTarget654654654', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag)
-- 	local playerPed = GetPlayerPed(-1)
-- 	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
-- 	carryingBackInProgress = true
-- 	--print("triggered cmg2_animations:syncTarget654654654")
-- 	RequestAnimDict(animationLib)

-- 	while not HasAnimDictLoaded(animationLib) do
-- 		Citizen.Wait(10)
-- 	end
-- 	if spin == nil then spin = 180.0 end
-- 	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
-- 	if controlFlag == nil then controlFlag = 0 end
-- 	TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
-- end)

-- RegisterNetEvent('cmg2_animations:syncMe654654654')
-- AddEventHandler('cmg2_animations:syncMe654654654', function(animationLib, animation,length,controlFlag,animFlag)
-- 	local playerPed = GetPlayerPed(-1)
-- 	RequestAnimDict(animationLib)

-- 	while not HasAnimDictLoaded(animationLib) do
-- 		Citizen.Wait(10)
-- 	end
-- 	Wait(500)
-- 	if controlFlag == nil then controlFlag = 0 end
-- 	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)

-- 	Citizen.Wait(length)
-- end)

-- RegisterNetEvent('cmg2_animations:cl_stop654654654')
-- AddEventHandler('cmg2_animations:cl_stop654654654', function()
-- 	carryingBackInProgress = false
-- 	piggyBackInProgress = false
-- 	ClearPedSecondaryTask(GetPlayerPed(-1))
-- 	DetachEntity(GetPlayerPed(-1), true, false)
-- end)

-- function GetPlayers()
--     local players = {}

--     for i = 0, 255 do
--         if NetworkIsPlayerActive(i) then
--             table.insert(players, i)
--         end
--     end

--     return players
-- end

-- function GetClosestPlayer(radius)
--     local players = GetPlayers()
--     local closestDistance = -1
--     local closestPlayer = -1
--     local ply = GetPlayerPed(-1)
--     local plyCoords = GetEntityCoords(ply, 0)

--     for index,value in ipairs(players) do
--         local target = GetPlayerPed(value)
--         if(target ~= ply) then
--             local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
--             local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
--             if(closestDistance == -1 or closestDistance > distance) then
--                 closestPlayer = value
--                 closestDistance = distance
--             end
--         end
--     end
-- 	--print("jogador mais próximo é dist: " .. tostring(closestDistance))
-- 	if closestDistance <= radius then
-- 		return closestPlayer
-- 	else
-- 		return nil
-- 	end
-- end

------------------------------------------------------------------------------
-- CAVALINHO
--------------------------------------------------------------------------------
-- local piggyBackInProgress = false

-- RegisterCommand("cavalinho",function(source, args)
-- 	if not piggyBackInProgress then
-- 		piggyBackInProgress = true
-- 		local player = PlayerPedId()	
-- 		lib = 'anim@arena@celeb@flat@paired@no_props@'
-- 		anim1 = 'piggyback_c_player_a'
-- 		anim2 = 'piggyback_c_player_b'
-- 		distans = -0.07
-- 		distans2 = 0.0
-- 		height = 0.45
-- 		spin = 0.0		
-- 		length = 100000
-- 		controlFlagMe = 49
-- 		controlFlagTarget = 33
-- 		animFlagTarget = 1
-- 		local closestPlayer = GetClosestPlayer(3)
-- 		target = GetPlayerServerId(closestPlayer)
-- 		if closestPlayer ~= nil then
-- 			--print("triggering cmg2_animations:sync654654654")
-- 			TriggerServerEvent('cmg2_animations:sync654654654_2', closestPlayer, lib, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget)
-- 		else
-- 			print("[CMG Anim] No player nearby")
-- 		end
-- 	else
-- 		piggyBackInProgress = false
-- 		ClearPedSecondaryTask(GetPlayerPed(-1))
-- 		DetachEntity(GetPlayerPed(-1), true, false)
-- 		local closestPlayer = vRP.getNearestPlayer(2)
-- 		if closestPlayer then
-- 			TriggerServerEvent("cmg2_animations:stop654654654",closestPlayer)
-- 		end
-- 	end
-- end,false)

-- RegisterNetEvent('cmg2_animations:syncTarget654654654')
-- AddEventHandler('cmg2_animations:syncTarget654654654', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag)
-- 	local playerPed = GetPlayerPed(-1)
-- 	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
-- 	piggyBackInProgress = true
-- 	RequestAnimDict(animationLib)

-- 	while not HasAnimDictLoaded(animationLib) do
-- 		Citizen.Wait(10)
-- 	end
-- 	if spin == nil then spin = 180.0 end
-- 	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
-- 	if controlFlag == nil then controlFlag = 0 end
-- 	TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
-- end)

-----------------------------------------------------------------
-- PEGAR DE REFEM
------------------------------------------------------------------

local hostageAllowedWeapons = {
	"WEAPON_COMBATPISTOL",
	"WEAPON_REVOLVER_MK2",
	"WEAPON_REVOLVER",
	"WEAPON_PISTOL_MK2",
	"WEAPON_PISTOL50",
	"WEAPON_PISTOL",
	"WEAPON_SNSPISTOL",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_HEAVYPISTOL"
}

local holdingHostageInProgress = false

RegisterCommand("prefem",function()
	takeHostage()
end)

RegisterCommand("srefem",function()
	takeHostage()
end)

function takeHostage()
	ClearPedSecondaryTask(GetPlayerPed(-1))
	DetachEntity(GetPlayerPed(-1), true, false)
	for i=1, #hostageAllowedWeapons do
		if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(hostageAllowedWeapons[i]), false) then
			if GetAmmoInPedWeapon(GetPlayerPed(-1), GetHashKey(hostageAllowedWeapons[i])) > 0 then
				canTakeHostage = true 
				foundWeapon = GetHashKey(hostageAllowedWeapons[i])
				break
			end 					
		end
	end

	if not canTakeHostage then 
		drawNativeNotification("Você precisa de uma pistola com munição para fazer um refém à mão armada!")
	end

	if not holdingHostageInProgress and canTakeHostage then		
		local player = PlayerPedId()	
		--lib = 'misssagrab_inoffice'
		--anim1 = 'hostage_loop'
		--lib2 = 'misssagrab_inoffice'
		--anim2 = 'hostage_loop_mrk'
		lib = 'anim@gangops@hostage@'
		anim1 = 'perp_idle'
		lib2 = 'anim@gangops@hostage@'
		anim2 = 'victim_idle'
		distans = 0.11 --Higher = closer to camera
		distans2 = -0.24 --higher = left
		height = 0.0
		spin = 0.0		
		length = 100000
		controlFlagMe = 49
		controlFlagTarget = 49
		animFlagTarget = 50
		attachFlag = true 
		local closestPlayer = GetClosestPlayer(2)
		target = GetPlayerServerId(closestPlayer)
		if closestPlayer ~= nil then
			SetCurrentPedWeapon(GetPlayerPed(-1), foundWeapon, true)
			holdingHostageInProgress = true
			holdingHostage = true 
			--print("triggering cmg3_animations:sync")
			TriggerServerEvent('cmg3_animations:sync', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget,attachFlag)
		else
			--print("[CMG Anim] No player nearby")
			drawNativeNotification("No one nearby to take as hostage!")
		end 
	end
	canTakeHostage = false 
end 

RegisterNetEvent('cmg3_animations:syncTarget')
AddEventHandler('cmg3_animations:syncTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag,animFlagTarget,attach)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	if holdingHostageInProgress then 
		holdingHostageInProgress = false 
	else 
		holdingHostageInProgress = true
	end
	beingHeldHostage = true 
	--print("triggered cmg3_animations:syncTarget")
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	if spin == nil then spin = 180.0 end
	if attach then 
		--print("attaching entity")
		AttachEntityToEntity(GetPlayerPed(-1), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
	else 
		--print("not attaching entity")
	end
	
	if controlFlag == nil then controlFlag = 0 end
	
	if animation2 == "victim_fail" then 
		SetEntityHealth(GetPlayerPed(-1),0)
		DetachEntity(GetPlayerPed(-1), true, false)
		TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
		beingHeldHostage = false 
		holdingHostageInProgress = false 
	elseif animation2 == "shoved_back" then 
		holdingHostageInProgress = false 
		DetachEntity(GetPlayerPed(-1), true, false)
		TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
		beingHeldHostage = false 
	else
		TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)	
	end
end)

RegisterNetEvent('cmg3_animations:syncMe')
AddEventHandler('cmg3_animations:syncMe', function(animationLib, animation,length,controlFlag,animFlag)
	local playerPed = GetPlayerPed(-1)
	--print("triggered cmg3_animations:syncMe")
	ClearPedSecondaryTask(GetPlayerPed(-1))
	RequestAnimDict(animationLib)
	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)
	if animation == "perp_fail" then 
		SetPedShootsAtCoord(GetPlayerPed(-1), 0.0, 0.0, 0.0, 0)
		holdingHostageInProgress = false 
	end
	if animation == "shove_var_a" then 
		Wait(900)
		ClearPedSecondaryTask(GetPlayerPed(-1))
		holdingHostageInProgress = false 
	end
end)

RegisterNetEvent('cmg3_animations:cl_stop')
AddEventHandler('cmg3_animations:cl_stop', function()
	holdingHostageInProgress = false
	beingHeldHostage = false 
	holdingHostage = false 
	ClearPedSecondaryTask(GetPlayerPed(-1))
	DetachEntity(GetPlayerPed(-1), true, false)
end)

function GetPlayers()
    local players = {}

	for _, i in ipairs(GetActivePlayers()) do
        table.insert(players, i)
    end

    return players
end

Citizen.CreateThread(function()
	while true do 
		if holdingHostage then
			if IsEntityDead(GetPlayerPed(-1)) then
				--print("release this mofo")			
				holdingHostage = false
				holdingHostageInProgress = false 
				local closestPlayer = GetClosestPlayer(2)
				target = GetPlayerServerId(closestPlayer)
				TriggerServerEvent("cmg3_animations:stop",target)
				Wait(100)
				releaseHostage()
			end 
			DisableControlAction(0,24,true) -- disable attack
			DisableControlAction(0,25,true) -- disable aim
			DisableControlAction(0,47,true) -- disable weapon
			DisableControlAction(0,58,true) -- disable weapon
			DisablePlayerFiring(GetPlayerPed(-1),true)
			local playerCoords = GetEntityCoords(GetPlayerPed(-1))
			DrawText3D(playerCoords.x,playerCoords.y,playerCoords.z,"Pressione [Q] para soltar, [E] para matar")
			if IsDisabledControlJustPressed(0,44) then --release
				--print("release this mofo")			
				holdingHostage = false
				holdingHostageInProgress = false 
				local closestPlayer = GetClosestPlayer(2)
				target = GetPlayerServerId(closestPlayer)
				TriggerServerEvent("cmg3_animations:stop",target)
				Wait(100)
				releaseHostage()
			elseif IsDisabledControlJustPressed(0,51) then --kill 
				--print("kill this mofo")				
				holdingHostage = false
				holdingHostageInProgress = false 		
				local closestPlayer = GetClosestPlayer(2)
				target = GetPlayerServerId(closestPlayer)
				TriggerServerEvent("cmg3_animations:stop",target)				
				killHostage()
			end
		end
		if beingHeldHostage then 
			DisableControlAction(0,21,true) -- disable sprint
			DisableControlAction(0,24,true) -- disable attack
			DisableControlAction(0,25,true) -- disable aim
			DisableControlAction(0,47,true) -- disable weapon
			DisableControlAction(0,58,true) -- disable weapon
			DisableControlAction(0,263,true) -- disable melee
			DisableControlAction(0,264,true) -- disable melee
			DisableControlAction(0,257,true) -- disable melee
			DisableControlAction(0,140,true) -- disable melee
			DisableControlAction(0,141,true) -- disable melee
			DisableControlAction(0,142,true) -- disable melee
			DisableControlAction(0,143,true) -- disable melee
			DisableControlAction(0,75,true) -- disable exit vehicle
			DisableControlAction(27,75,true) -- disable exit vehicle  
			DisableControlAction(0,22,true) -- disable jump
			DisableControlAction(0,32,true) -- disable move up
			DisableControlAction(0,268,true)
			DisableControlAction(0,33,true) -- disable move down
			DisableControlAction(0,269,true)
			DisableControlAction(0,34,true) -- disable move left
			DisableControlAction(0,270,true)
			DisableControlAction(0,35,true) -- disable move right
			DisableControlAction(0,271,true)
		end
		Wait(0)
	end
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    if onScreen then
        SetTextScale(0.19, 0.19)
        SetTextFont(0)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function releaseHostage()
	local player = PlayerPedId()	
	lib = 'reaction@shove'
	anim1 = 'shove_var_a'
	lib2 = 'reaction@shove'
	anim2 = 'shoved_back'
	distans = 0.11 --Higher = closer to camera
	distans2 = -0.24 --higher = left
	height = 0.0
	spin = 0.0		
	length = 100000
	controlFlagMe = 120
	controlFlagTarget = 0
	animFlagTarget = 1
	attachFlag = false
	local closestPlayer = GetClosestPlayer(2)
	target = GetPlayerServerId(closestPlayer)
	if closestPlayer ~= nil then
		--print("triggering cmg3_animations:sync")
		TriggerServerEvent('cmg3_animations:sync', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget,attachFlag)
	else
		print("[CMG Anim] No player nearby")
	end
end 

function killHostage()
	local player = PlayerPedId()	
	lib = 'anim@gangops@hostage@'
	anim1 = 'perp_fail'
	lib2 = 'anim@gangops@hostage@'
	anim2 = 'victim_fail'
	distans = 0.11 --Higher = closer to camera
	distans2 = -0.24 --higher = left
	height = 0.0
	spin = 0.0		
	length = 0.2
	controlFlagMe = 168
	controlFlagTarget = 0
	animFlagTarget = 1
	attachFlag = false
	local closestPlayer = GetClosestPlayer(2)
	target = GetPlayerServerId(closestPlayer)
	if closestPlayer ~= nil then
		--print("triggering cmg3_animations:sync")
		TriggerServerEvent('cmg3_animations:sync', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget,attachFlag)
	else
		print("[CMG Anim] No player nearby")
	end	
end 

function drawNativeNotification(text)
    SetTextComponentFormat('STRING')
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

----------------------------------------------------------------------------------------------------------------------------------------------------
--Limitador de Velocidade de Veiculos
----------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread( function()
    while true do 
        Citizen.Wait( 0 )
        local ped = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(ped, false)
        local speed = GetEntitySpeed(vehicle)
            if ( ped ) then
                if math.floor(speed*3.6) == 280 then --Velocidade limitada em 250
                    cruise = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), true))
                    SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), true), cruise)
                end
            end
        end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESABILITAR A CORONHADA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
    local ped = PlayerPedId()
        if IsPedArmed(ped, 6) then
               DisableControlAction(0, 140, true)
            DisableControlAction(1, 141, true)
               DisableControlAction(1, 142, true)
        end
    end
end)
Citizen.CreateThread(function()
    while true do
        local sleep = 100
        if IsPedArmed(PlayerPedId(),6) then
        sleep = 4
            DisableControlAction(1,140,true)
            DisableControlAction(1,141,true)
            DisableControlAction(1,142,true)
        end
        Citizen.Wait(sleep)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESABILITAR O Q
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = PlayerPedId()
        local health = GetEntityHealth(ped)
        if health >= 101 then
            DisableControlAction(0,44,true)
        end
    end
end)