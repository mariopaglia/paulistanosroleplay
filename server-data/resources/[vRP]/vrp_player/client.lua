local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

emP = Tunnel.getInterface("vrp_player")
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALÁRIO
-----------------------------------------------------------------------------------------------------------------------------------------
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
-- /CARREGARN
-----------------------------------------------------------------------------------------------------------------------------------------

carryingBackInProgress = false

RegisterCommand("carregar",function(source, args)
	print("carrying")
	if not carryingBackInProgress then
		carryingBackInProgress = true
		local player = PlayerPedId()	
		lib = 'missfinale_c2mcs_1'
		anim1 = 'fin_c2_mcs_1_camman'
		lib2 = 'nm'
		anim2 = 'firemans_carry'
		distans = 0.15
		distans2 = 0.27
		height = 0.63
		spin = 0.0		
		length = 100000
		controlFlagMe = 49
		controlFlagTarget = 33
		animFlagTarget = 1
		local closestPlayer = GetClosestPlayer(3)
		target = GetPlayerServerId(closestPlayer)
		if closestPlayer ~= nil then
			print("triggering cmg2_animations:sync")
			TriggerServerEvent('cmg2_animations:sync', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget)
		else
			print("[CMG Anim] No player nearby")
		end
	else
		carryingBackInProgress = false
		ClearPedSecondaryTask(GetPlayerPed(-1))
		DetachEntity(GetPlayerPed(-1), true, false)
		local closestPlayer = GetClosestPlayer(3)
		target = GetPlayerServerId(closestPlayer)
		TriggerServerEvent("cmg2_animations:stop",target)
	end
end,false)

RegisterNetEvent('cmg2_animations:syncTarget')
AddEventHandler('cmg2_animations:syncTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	carryingBackInProgress = true
	print("triggered cmg2_animations:syncTarget")
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	if spin == nil then spin = 180.0 end
	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
end)

RegisterNetEvent('cmg2_animations:syncMe')
AddEventHandler('cmg2_animations:syncMe', function(animationLib, animation,length,controlFlag,animFlag)
	local playerPed = GetPlayerPed(-1)
	print("triggered cmg2_animations:syncMe")
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	Wait(500)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)

	Citizen.Wait(length)
end)

RegisterNetEvent('cmg2_animations:cl_stop')
AddEventHandler('cmg2_animations:cl_stop', function()
	carryingBackInProgress = false
	ClearPedSecondaryTask(GetPlayerPed(-1))
	DetachEntity(GetPlayerPed(-1), true, false)
end)

function GetPlayers()
    local players = {}

	for _, player in ipairs(GetActivePlayers()) do
        table.insert(players, player)
	end
	
	--[[for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end]]

    return players
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- EMPURRAR
-----------------------------------------------------------------------------------------------------------------------------------------
local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc,moveFunc,disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = { handle = iter, destructor = disposeFunc }
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next,id = moveFunc(iter)
		until not next

		enum.destructor,enum.handle = nil,nil
		disposeFunc(iter)
	end)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle,FindNextVehicle,EndFindVehicle)
end

function GetVeh()
    local vehicles = {}
    for vehicle in EnumerateVehicles() do
        table.insert(vehicles,vehicle)
    end
    return vehicles
end

function GetClosestVeh(coords)
	local vehicles = GetVeh()
	local closestDistance = -1
	local closestVehicle = -1
	local coords = coords

	if coords == nil then
		local ped = PlayerPedId()
		coords = GetEntityCoords(ped)
	end

	for i=1,#vehicles,1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance = GetDistanceBetweenCoords(vehicleCoords,coords.x,coords.y,coords.z,true)
		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = vehicles[i]
			closestDistance = distance
		end
	end
	return closestVehicle,closestDistance
end

local First = vector3(0.0,0.0,0.0)
local Second = vector3(5.0,5.0,5.0)
local Vehicle = { Coords = nil, Vehicle = nil, Dimension = nil, IsInFront = false, Distance = nil }

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local closestVehicle,Distance = GetClosestVeh()
		if Distance < 6.1 and not IsPedInAnyVehicle(ped) then
			Vehicle.Coords = GetEntityCoords(closestVehicle)
			Vehicle.Dimensions = GetModelDimensions(GetEntityModel(closestVehicle),First,Second)
			Vehicle.Vehicle = closestVehicle
			Vehicle.Distance = Distance
			if GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle), GetEntityCoords(ped), true) > GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle) * -1, GetEntityCoords(ped), true) then
				Vehicle.IsInFront = false
			else
				Vehicle.IsInFront = true
			end
		else
			Vehicle = { Coords = nil, Vehicle = nil, Dimensions = nil, IsInFront = false, Distance = nil }
		end
		Citizen.Wait(500)
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(500)
		if Vehicle.Vehicle ~= nil then
			local ped = PlayerPedId()
			if IsControlPressed(0,244) and GetEntityHealth(ped) > 100 and IsVehicleSeatFree(Vehicle.Vehicle,-1) and not IsEntityInAir(ped) and not IsPedBeingStunned(ped) and not IsEntityAttachedToEntity(ped,Vehicle.Vehicle) and not (GetEntityRoll(Vehicle.Vehicle) > 75.0 or GetEntityRoll(Vehicle.Vehicle) < -75.0) then
				RequestAnimDict('missfinale_c2ig_11')
				TaskPlayAnim(ped,'missfinale_c2ig_11','pushcar_offcliff_m',2.0,-8.0,-1,35,0,0,0,0)
				NetworkRequestControlOfEntity(Vehicle.Vehicle)

				if Vehicle.IsInFront then
					AttachEntityToEntity(ped,Vehicle.Vehicle,GetPedBoneIndex(6286),0.0,Vehicle.Dimensions.y*-1+0.1,Vehicle.Dimensions.z+1.0,0.0,0.0,180.0,0.0,false,false,true,false,true)
				else
					AttachEntityToEntity(ped,Vehicle.Vehicle,GetPedBoneIndex(6286),0.0,Vehicle.Dimensions.y-0.3,Vehicle.Dimensions.z+1.0,0.0,0.0,0.0,0.0,false,false,true,false,true)
				end

				while true do
					Citizen.Wait(5)
					if IsDisabledControlPressed(0,34) then
						TaskVehicleTempAction(ped,Vehicle.Vehicle,11,100)
					end

					if IsDisabledControlPressed(0,9) then
						TaskVehicleTempAction(ped,Vehicle.Vehicle,10,100)
					end

					if Vehicle.IsInFront then
						SetVehicleForwardSpeed(Vehicle.Vehicle,-1.0)
					else
						SetVehicleForwardSpeed(Vehicle.Vehicle,1.0)
					end

					if not IsDisabledControlPressed(0,244) then
						DetachEntity(ped,false,false)
						StopAnimTask(ped,'missfinale_c2ig_11','pushcar_offcliff_m',2.0)
						break
					end
				end
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CORONHADA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			local ped = PlayerPedId()
			if IsPedArmed(ped, 6) then
				DisableControlAction(1, 140, true)
				DisableControlAction(1, 141, true)
				DisableControlAction(1, 142, true)
			end
		end
	end
)

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
-- QTH
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1)
			if IsControlJustReleased(1, 118) then
				TriggerServerEvent("offred:qthPolice")
			end
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
                if (roll > 30.0 or roll < -30.0) and GetEntitySpeed(vehicle) < 2 then
                      if IsVehicleTyreBurst(vehicle, wheel_rm1, 0) == false then
                      --SetVehiclePetrolTankHealth(vehicle, -4000, 1)
                     --  SetVehicleEngineTemperature(vehicle, 5000, 1)
                    --  SetVehicleEngineHealth(vehicle, -4000, 1)
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
----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE DANO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(
	function()
		local ped = PlayerPedId()
		local pedId = PlayerId()
		while true do
			Citizen.Wait(1)
			N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SNOWBALL"), 0.00)
			N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SMOKEGRENADE"), 0.01)
			N_0x4757f00bc6323cfe(GetHashKey("WEAPON_RAYPISTOL"), 0.01)
			--N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"), 0.01)
			--N_0x4757f00bc6323cfe(GetHashKey("weapon_knuckle"), 0.01)
			--N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BAT"), 0.01)
			--N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.40)
			N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MOLOTOV"), 0.01)
			N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BZGAS"), 0.20)
		end
	end
)

----------------------------------------------------------------------------------------------------------------------------------------
-- CONTROLE DE VELOCIDADE
------------------------
-- RegisterCommand("cr",function(source,args)
-- 	local veh = GetVehiclePedIsIn(PlayerPedId(),false)
-- 	local maxspeed = GetVehicleMaxSpeed(GetEntityModel(veh))
-- 	local vehspeed = GetEntitySpeed(veh)*2.236936
-- 	if GetPedInVehicleSeat(veh,-1) == PlayerPedId() and math.ceil(vehspeed) >= 1 then
-- 		if args[1] == nil then
-- 			SetEntityMaxSpeed(veh,maxspeed)
-- 		else
-- 			SetEntityMaxSpeed(veh,0.45*args[1]-0.45)
-- 			TriggerEvent("Notify","sucesso","Velocidade máxima travada em <b>"..args[1].." mp/h</b>.")
-- 		end
-- 	end
-- end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /ATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("attachs",function(source,args)
	local ped = PlayerPedId()
	if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SPECIALCARBINE_MK2") then -- G36C
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2")) -- MIRA GRANDE
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_AT_MUZZLE_02")) -- FREIO DE BOCA TATICO
        GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE_MK2"),GetHashKey("COMPONENT_AT_AR_AFGRIP_02")) -- EMPUNHADURA
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
RegisterCommand("silenciador",function(source,args)
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
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE_MK2") then -- M4A1
    	    GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_SUPP"))
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE") then -- AR-15
    	    GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_SUPP"))
		elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPISTOL") then -- GLOCK
    	    GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_AT_PI_SUPP"))	
		end
	else
		TriggerEvent("Notify", "negado", "Necessário <b>VIP Ouro ou superior</b> para utilizar <b>/silenciador</b>")
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
-- INVENTÁRIO
-----------------------------------------------------------------------------------------------------------------------------------------

--Citizen.CreateThread(function()
--  while true do
--    Citizen.Wait(0)
--  if IsControlJustReleased(0, 289) then
--    TriggerServerEvent("aztec:inventory")
--end
--end
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELANDO O F6
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("cloneplates")
AddEventHandler(
	"cloneplates",
	function()
		local vehicle = GetVehiclePedIsUsing(PlayerPedId())
		if IsEntityAVehicle(vehicle) then
			SetVehicleNumberPlateText(vehicle, "CLONADOS")
		end
	end
)
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
--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		if x == px and y == py then
			if tempo > 0 then
				tempo = tempo - 1
			else
				TriggerServerEvent("kickAFK")
			end
		else
			tempo = 1200
		end
		px = x
		py = y
	end
end)]]
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
-- /acess
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
-- /acess
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
-- /ME
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterNetEvent('chatME')
-- AddEventHandler('chatME',function(id,name,message)
-- 	local myId = PlayerId()
-- 	local pid = GetPlayerFromServerId(id)
-- 	if pid == myId then
-- 		TriggerEvent('chatMessage',"",{},"* "..name.." "..message)
-- 	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)),GetEntityCoords(GetPlayerPed(pid))) < 3.999 then
-- 		TriggerEvent('chatMessage',"",{},"* "..name.." "..message)
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /TOW
-----------------------------------------------------------------------------------------------------------------------------------------
local reboque = nil
local rebocado = nil
RegisterCommand(
	"tow",
	function(source, args)
		local vehicle = GetPlayersLastVehicle()
		local vehicletow = IsVehicleModel(vehicle, GetHashKey("flatbed"))

		if vehicletow and not IsPedInAnyVehicle(PlayerPedId()) then
			rebocado =
				getVehicleInDirection(
				GetEntityCoords(PlayerPedId()),
				GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 5.0, 0.0)
			)
			if IsEntityAVehicle(vehicle) and IsEntityAVehicle(rebocado) then
				TriggerServerEvent("trytow", VehToNet(vehicle), VehToNet(rebocado))
			end
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

RegisterNetEvent("syncreparar")
AddEventHandler(
	"syncreparar",
	function(index)
		if NetworkDoesNetworkIdExist(index) then
			local v = NetToVeh(index)
			local fuel = GetVehicleFuelLevel(v)
			if DoesEntityExist(v) then
				if IsEntityAVehicle(v) then
					SetVehicleFixed(v)
					SetVehicleDirtLevel(v, 0.0)
					SetVehicleUndriveable(v, false)
					SetEntityAsMissionEntity(v, true, true)
					SetVehicleOnGroundProperly(v)
					SetVehicleFuelLevel(v, fuel)
				end
			end
		end
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
-- BANDAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("bandagem")
AddEventHandler(
	"bandagem",
	function()
		local bandagem = 0
		repeat
			bandagem = bandagem + 1
			SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 1)
			Citizen.Wait(600)
		until GetEntityHealth(PlayerPedId()) >= 400 or GetEntityHealth(PlayerPedId()) <= 100 or bandagem == 100
		TriggerEvent("Notify", "sucesso", "Tratamento concluido.")
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANDAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tratamento")
AddEventHandler(
	"tratamento",
	function()
		repeat
			SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 1)
			Citizen.Wait(600)
		until GetEntityHealth(PlayerPedId()) >= 400 or GetEntityHealth(PlayerPedId()) <= 100
		TriggerEvent("Notify", "sucesso", "Tratamento concluido.")
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /CARTAS
-----------------------------------------------------------------------------------------------------------------------------------------
local card = {
	[1] = "A",
	[2] = "2",
	[3] = "3",
	[4] = "4",
	[5] = "5",
	[6] = "6",
	[7] = "7",
	[8] = "8",
	[9] = "9",
	[10] = "10",
	[11] = "J",
	[12] = "Q",
	[13] = "K"
}

local tipos = {
	[1] = "^8♣",
	[2] = "^8♠",
	[3] = "^9♦",
	[4] = "^9♥"
}

RegisterNetEvent("CartasMe")
AddEventHandler(
	"CartasMe",
	function(id, name, cd, naipe)
		local monid = PlayerId()
		local sonid = GetPlayerFromServerId(id)
		if sonid == monid then
			TriggerEvent(
				"chatMessage",
				"",
				{},
				"^3* " .. name .. " tirou do baralho a carta: " .. card[cd] .. "" .. tipos[naipe]
			)
		elseif
			GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)), GetEntityCoords(GetPlayerPed(sonid)), true) < 5.999
		 then
			TriggerEvent(
				"chatMessage",
				"",
				{},
				"^3* " .. name .. " tirou do baralho a carta: " .. card[cd] .. "" .. tipos[naipe]
			)
		end
	end
)---------------------------------------------------------------------------------------------------------------------------------
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
-- EMPURRAR
-----------------------------------------------------------------------------------------------------------------------------------------
local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(
		function()
			local iter, id = initFunc()
			if not id or id == 0 then
				disposeFunc(iter)
				return
			end

			local enum = {handle = iter, destructor = disposeFunc}
			setmetatable(enum, entityEnumerator)

			local next = true
			repeat
				coroutine.yield(id)
				next, id = moveFunc(iter)
			until not next

			enum.destructor, enum.handle = nil, nil
			disposeFunc(iter)
		end
	)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function GetVeh()
	local vehicles = {}
	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end
	return vehicles
end

function GetClosestVeh(coords)
	local vehicles = GetVeh()
	local closestDistance = -1
	local closestVehicle = -1
	local coords = coords

	if coords == nil then
		local ped = PlayerPedId()
		coords = GetEntityCoords(ped)
	end

	for i = 1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)
		if closestDistance == -1 or closestDistance > distance then
			closestVehicle = vehicles[i]
			closestDistance = distance
		end
	end
	return closestVehicle, closestDistance
end

local First = vector3(0.0, 0.0, 0.0)
local Second = vector3(5.0, 5.0, 5.0)
local Vehicle = {Coords = nil, Vehicle = nil, Dimension = nil, IsInFront = false, Distance = nil}

Citizen.CreateThread(
	function()
		while true do
			local ped = PlayerPedId()
			local closestVehicle, Distance = GetClosestVeh()
			if Distance < 6.1 and not IsPedInAnyVehicle(ped) then
				Vehicle.Coords = GetEntityCoords(closestVehicle)
				Vehicle.Dimensions = GetModelDimensions(GetEntityModel(closestVehicle), First, Second)
				Vehicle.Vehicle = closestVehicle
				Vehicle.Distance = Distance
				if
					GetDistanceBetweenCoords(
						GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle),
						GetEntityCoords(ped),
						true
					) >
						GetDistanceBetweenCoords(
							GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle) * -1,
							GetEntityCoords(ped),
							true
						)
				 then
					Vehicle.IsInFront = false
				else
					Vehicle.IsInFront = true
				end
			else
				Vehicle = {Coords = nil, Vehicle = nil, Dimensions = nil, IsInFront = false, Distance = nil}
			end
			Citizen.Wait(500)
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(500)
			if Vehicle.Vehicle ~= nil then
				local ped = PlayerPedId()
				if
					IsControlPressed(0, 244) and GetEntityHealth(ped) > 100 and IsVehicleSeatFree(Vehicle.Vehicle, -1) and
						not IsEntityAttachedToEntity(ped, Vehicle.Vehicle) and
						not (GetEntityRoll(Vehicle.Vehicle) > 75.0 or GetEntityRoll(Vehicle.Vehicle) < -75.0)
				 then
					RequestAnimDict("missfinale_c2ig_11")
					TaskPlayAnim(ped, "missfinale_c2ig_11", "pushcar_offcliff_m", 2.0, -8.0, -1, 35, 0, 0, 0, 0)
					NetworkRequestControlOfEntity(Vehicle.Vehicle)

					if Vehicle.IsInFront then
						AttachEntityToEntity(
							ped,
							Vehicle.Vehicle,
							GetPedBoneIndex(6286),
							0.0,
							Vehicle.Dimensions.y * -1 + 0.1,
							Vehicle.Dimensions.z + 1.0,
							0.0,
							0.0,
							180.0,
							0.0,
							false,
							false,
							true,
							false,
							true
						)
					else
						AttachEntityToEntity(
							ped,
							Vehicle.Vehicle,
							GetPedBoneIndex(6286),
							0.0,
							Vehicle.Dimensions.y - 0.3,
							Vehicle.Dimensions.z + 1.0,
							0.0,
							0.0,
							0.0,
							0.0,
							false,
							false,
							true,
							false,
							true
						)
					end

					while true do
						Citizen.Wait(5)
						if IsDisabledControlPressed(0, 34) then
							TaskVehicleTempAction(ped, Vehicle.Vehicle, 11, 100)
						end

						if IsDisabledControlPressed(0, 9) then
							TaskVehicleTempAction(ped, Vehicle.Vehicle, 10, 100)
						end

						if Vehicle.IsInFront then
							SetVehicleForwardSpeed(Vehicle.Vehicle, -1.0)
						else
							SetVehicleForwardSpeed(Vehicle.Vehicle, 1.0)
						end

						if not IsDisabledControlPressed(0, 244) then
							DetachEntity(ped, false, false)
							StopAnimTask(ped, "missfinale_c2ig_11", "pushcar_offcliff_m", 2.0)
							break
						end
					end
				end
			end
		end
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
-- DEIXAR A PORTA ABERTA AO SAIR DO CARRO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(8)

			local ped = GetPlayerPed(-1)

			if
				DoesEntityExist(ped) and IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) and
					not IsPauseMenuActive()
			 then
				Citizen.Wait(150)
				if
					DoesEntityExist(ped) and IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) and
						not IsPauseMenuActive()
				 then
					local veh = GetVehiclePedIsIn(ped, false)
					TaskLeaveVehicle(ped, veh, 256)
				end
			end
		end
	end
)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ESTOURAR PNEU AO CAPOTAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(5)
			local ped = PlayerPedId()
			if IsPedInAnyVehicle(ped) then
				local vehicle = GetVehiclePedIsIn(ped)
				if GetPedInVehicleSeat(vehicle, -1) == ped then
					local roll = GetEntityRoll(vehicle)
					if (roll > 75.0 or roll < -75.0) and GetEntitySpeed(vehicle) < 2 then
						if IsVehicleTyreBurst(vehicle, wheel_rm1, 0) == false then
							-- SetVehiclePetrolTankHealth(vehicle, -4000, 1)
							SetVehicleEngineTemperature(vehicle, 5000, 1)
							SetVehicleEngineHealth(vehicle, 300.0)
							SetVehicleTyreBurst(vehicle, 0, true, 1000.0)
							Citizen.Wait(1000)
							SetVehicleTyreBurst(vehicle, 1, true, 1000.0)
							Citizen.Wait(1000)
							SetVehicleTyreBurst(vehicle, 2, true, 1000.0)
							Citizen.Wait(1000)
							SetVehicleTyreBurst(vehicle, 3, true, 1000.0)
							Citizen.Wait(1000)
							SetVehicleTyreBurst(vehicle, 4, true, 1000.0)
							Citizen.Wait(1000)
							SetVehicleTyreBurst(vehicle, 5, true, 1000.0)
							Citizen.Wait(1000)
							SetVehicleTyreBurst(vehicle, 6, true, 1000.0)
							Citizen.Wait(1000)
							SetVehicleTyreBurst(vehicle, 7, true, 1000.0)
						end
					end
				end
			end
		end
	end
)

-- ALTERAR O DANO DAS ARMAS
--------------------------------------------------------------------------------------------------
-- Citizen.CreateThread(
-- 	function()
-- 		while true do
-- 			N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 3.0)
-- 			Wait(0)
-- 			N_0x4757f00bc6323cfe(GetHashKey("weapon_assaultrifle"), 3.0)

-- 		end
-- 	end
-- )

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
        if GetEntityHealth(GetPlayerPed(-1)) <= 200 then
            setHurt()
        elseif hurt and GetEntityHealth(GetPlayerPed(-1)) > 200 then
            setNotHurt()
        end
    end
end)

function setHurt()
    hurt = true
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(GetPlayerPed(-1), "move_m@injured", true)
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
-- /CARREGARN
-----------------------------------------------------------------------------------------------------------------------------------------

carryingBackInProgress = false

RegisterCommand("carregar",function(source, args)
	print("carrying")
	if not carryingBackInProgress then
		carryingBackInProgress = true
		local player = PlayerPedId()	
		lib = 'missfinale_c2mcs_1'
		anim1 = 'fin_c2_mcs_1_camman'
		lib2 = 'nm'
		anim2 = 'firemans_carry'
		distans = 0.15
		distans2 = 0.27
		height = 0.63
		spin = 0.0		
		length = 100000
		controlFlagMe = 49
		controlFlagTarget = 33
		animFlagTarget = 1
		local closestPlayer = GetClosestPlayer(3)
		target = GetPlayerServerId(closestPlayer)
		if closestPlayer ~= nil then
			print("triggering cmg2_animations:sync")
			TriggerServerEvent('cmg2_animations:sync', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget)
		else
			print("[CMG Anim] No player nearby")
		end
	else
		carryingBackInProgress = false
		ClearPedSecondaryTask(GetPlayerPed(-1))
		DetachEntity(GetPlayerPed(-1), true, false)
		local closestPlayer = GetClosestPlayer(3)
		target = GetPlayerServerId(closestPlayer)
		TriggerServerEvent("cmg2_animations:stop",target)
	end
end,false)

RegisterNetEvent('cmg2_animations:syncTarget')
AddEventHandler('cmg2_animations:syncTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	carryingBackInProgress = true
	print("triggered cmg2_animations:syncTarget")
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	if spin == nil then spin = 180.0 end
	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
end)

RegisterNetEvent('cmg2_animations:syncMe')
AddEventHandler('cmg2_animations:syncMe', function(animationLib, animation,length,controlFlag,animFlag)
	local playerPed = GetPlayerPed(-1)
	print("triggered cmg2_animations:syncMe")
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	Wait(500)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)

	Citizen.Wait(length)
end)

RegisterNetEvent('cmg2_animations:cl_stop')
AddEventHandler('cmg2_animations:cl_stop', function()
	carryingBackInProgress = false
	ClearPedSecondaryTask(GetPlayerPed(-1))
	DetachEntity(GetPlayerPed(-1), true, false)
end)

function GetPlayers()
    local players = {}

	for _, player in ipairs(GetActivePlayers()) do
        table.insert(players, player)
	end
	
	--[[for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end]]

    return players
end

-------------------------------------
---------  Cavalinho ----------------
-------------------------------------
local piggyBackInProgress = false

RegisterCommand("cavalinho",function(source, args)
	if not piggyBackInProgress then
		piggyBackInProgress = true
		local player = PlayerPedId()	
		lib = 'anim@arena@celeb@flat@paired@no_props@'
		anim1 = 'piggyback_c_player_a'
		anim2 = 'piggyback_c_player_b'
		distans = -0.07
		distans2 = 0.0
		height = 0.45
		spin = 0.0		
		length = 100000
		controlFlagMe = 49
		controlFlagTarget = 33
		animFlagTarget = 1
		local closestPlayer = GetClosestPlayer(3)
		target = GetPlayerServerId(closestPlayer)
		if closestPlayer ~= nil then
			print("triggering cmg2_animations:sync")
			TriggerServerEvent('cmg2_animations:sync', closestPlayer, lib, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget)
		else
			print("[CMG Anim] No player nearby")
		end
	else
		piggyBackInProgress = false
		ClearPedSecondaryTask(GetPlayerPed(-1))
		DetachEntity(GetPlayerPed(-1), true, false)
		local closestPlayer = GetClosestPlayer(3)
		target = GetPlayerServerId(closestPlayer)
		TriggerServerEvent("cmg2_animations:stop",target)
	end
end,false)

RegisterNetEvent('cmg2_animations:syncTarget')
AddEventHandler('cmg2_animations:syncTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	piggyBackInProgress = true
	print("triggered cmg2_animations:syncTarget")
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	if spin == nil then spin = 180.0 end
	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
end)

RegisterNetEvent('cmg2_animations:syncMe')
AddEventHandler('cmg2_animations:syncMe', function(animationLib, animation,length,controlFlag,animFlag)
	local playerPed = GetPlayerPed(-1)
	print("triggered cmg2_animations:syncMe")
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	Wait(500)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)

	Citizen.Wait(length)
end)

RegisterNetEvent('cmg2_animations:cl_stop')
AddEventHandler('cmg2_animations:cl_stop', function()
	piggyBackInProgress = false
	ClearPedSecondaryTask(GetPlayerPed(-1))
	DetachEntity(GetPlayerPed(-1), true, false)
end)

function GetPlayers()
    local players = {}

    for _, player in ipairs(GetActivePlayers()) do
        table.insert(players, player)
	end
	
	--[[for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end]]

    return players
end

function GetClosestPlayer(radius)
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
	print("closest player is dist: " .. tostring(closestDistance))
	if closestDistance <= radius then
		return closestPlayer
	else
		return nil
	end
end

function GetClosestPlayer(radius)
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
	print("closest player is dist: " .. tostring(closestDistance))
	if closestDistance <= radius then
		return closestPlayer
	else
		return nil
	end
end
