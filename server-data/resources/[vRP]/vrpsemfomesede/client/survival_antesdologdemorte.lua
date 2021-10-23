function tvRP.varyHealth(variation)
	local ped = PlayerPedId()
	local n = math.floor(GetEntityHealth(ped)+variation)
	SetEntityHealth(ped,n)
end

function tvRP.getHealth()
	return GetEntityHealth(PlayerPedId())
end

function tvRP.setHealth(health)
	local n = math.floor(health)
	SetEntityHealth(PlayerPedId(),n)
end

function tvRP.setFriendlyFire(flag)
	NetworkSetFriendlyFireOption(flag)
	SetCanAttackFriendly(PlayerPedId(),flag,flag)
end

------------stamina recarge
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(18000)
		RestorePlayerStamina(PlayerId(), 1.0)
	end
end)

local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		TransitionToBlurred(1000)
	else
		TransitionFromBlurred(1000)
	end
end
local morto = 0
Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        if GetEntityHealth(ped) <= 101 then
            if morto == 0 then
                ToggleActionMenu()
                morto = 1
				TriggerEvent("tokovoip:toggleMute", true)
				TriggerEvent("radio:outServers")
            end
			-- DisableControlAction(1, 244, true)
        else 
        if GetEntityHealth(ped) >= 101 then
            if morto == 1 then
                ToggleActionMenu()
				TriggerEvent("tokovoip:toggleMute", false)
                morto = 0
            end
				-- DisableControlAction(1, 244, false)
            end
        end
        Citizen.Wait(500)
    end
end)



local nocauteado = false
local timedeath = 600

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		local health = GetEntityHealth(ped)
		if health <= 100 and timedeath > 0 then
			if not nocauteado then
				if IsEntityDead(ped) then
					local x,y,z = tvRP.getPosition()
					NetworkResurrectLocalPlayer(x,y,z,true,true,false)
					Citizen.Wait(1)
				end
				nocauteado = true
				FreezeEntityPosition(ped,true)
				vRPserver._updateHealth(100)
				SetEntityHealth(ped,100)
				SetEntityInvincible(ped,true)
				if IsPedInAnyVehicle(ped) then
					tvRP.ejectVehicle()
				end
				NetworkSetVoiceActive(false)
				AnimpostfxPlay('ChopVision',30,true)
				AnimpostfxPlay('HeistCelebEnd',30,true)
				AnimpostfxPlay('Rampage',30,true)
				AnimpostfxPlay('DeathFailOut',30,true)
				TriggerEvent("emotes","morrer")
			else
				if health < 100 then
					SetEntityHealth(ped,100)
				end
			end
		end
	end
end)

function tvRP.isInComa()
	return nocauteado
end

function tvRP.killComa()
	if nocauteado then
		timedeath = 600
	end
end

function tvRP.killGod()
	NetworkSetVoiceActive(true)
	SetEntityInvincible(PlayerPedId(),false)
	SetEntityHealth(PlayerPedId(),400)
	vRPserver._updateHealth(400)
	TriggerEvent("tokovoip:toggleMute", false)
	Citizen.Wait(1000)
	nocauteado = false
	FreezeEntityPosition(PlayerPedId(),false)
	timedeath = 600
	AnimpostfxStopAll()
	tvRP.stopAnim(true)
	tvRP.stopAnim(false)
	ClearPedBloodDamage(PlayerPedId())
	ClearPedEnvDirt(PlayerPedId())
	while IsEntityPlayingAnim(PlayerPedId(),"misslamar1dead_body","dead_idle",3) do
		AnimpostfxStopAll()
		tvRP.stopAnim(true)
		tvRP.stopAnim(false)
		Citizen.Wait(500)
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if nocauteado then
			timedeath = timedeath - 1
		end
	end
end)

Citizen.CreateThread(function()
	Citizen.Wait(5000)
	exports.spawnmanager:setAutoSpawn(false)
	while true do
		Citizen.Wait(100)
		SetPlayerHealthRechargeMultiplier(PlayerId(),0)
	end
end)

-- COORDENADAS DE SPAWN DA ARENA PVP
local random = {
    [1] = { ['x'] = 2360.43, ['y'] = 3126.18, ['z'] = 48.21 },
    [2] = { ['x'] = 2366.56, ['y'] = 3157.83, ['z'] = 48.21 },
    [3] = { ['x'] = 2402.39, ['y'] = 3136.97, ['z'] = 48.16 },
    [4] = { ['x'] = 2432.1, ['y'] = 3095.41, ['z'] = 48.35 },
    [5] = { ['x'] = 2398.97, ['y'] = 3052.36, ['z'] = 48.16 },
    [6] = { ['x'] = 2353.12, ['y'] = 3055.89, ['z'] = 48.16 },
    [7] = { ['x'] = 2335.32, ['y'] = 3120.24, ['z'] = 48.21 },
}

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if nocauteado then
			idle = 5
			if vRPserver.getDimension() ~= 0 then 
				SetEntityHealth(PlayerPedId(),400)
				vRPserver._updateHealth(400)
				tvRP.killGod()
				FreezeEntityPosition(PlayerPedId(),false)
				AnimpostfxStopAll()
				tvRP.stopAnim(true)
				tvRP.stopAnim(false)
				ClearPedBloodDamage(PlayerPedId())
				ClearPedEnvDirt(PlayerPedId())
				selecionado = math.random(7)
				SetEntityCoords(
					PlayerPedId(),
					random[selecionado].x,
					random[selecionado].y,
					random[selecionado].z
				)
				while IsEntityPlayingAnim(PlayerPedId(),"misslamar1dead_body","dead_idle",3) do
					AnimpostfxStopAll()
					tvRP.stopAnim(true)
					tvRP.stopAnim(false)
					Citizen.Wait(500)
					
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if nocauteado then
			idle = 5
			if timedeath <= 0 and IsControlJustPressed(0,38) then
				if vRPserver.getDimension() == 0 then 
				idle = 1000
				SetEntityHealth(PlayerPedId(),400)
				vRPserver._updateHealth(400)
				TriggerServerEvent("clearInventory")
				tvRP.killGod()
				SetEntityCoords(PlayerPedId(),-204.37,-1009.45,29.55)
				tvRP.replaceWeapons({})
				vRPserver._updatePos(-204.37,-1009.45,29.55)
				FreezeEntityPosition(PlayerPedId(),false)
				AnimpostfxStopAll()
				tvRP.stopAnim(true)
				tvRP.stopAnim(false)
				ClearPedBloodDamage(PlayerPedId())
				ClearPedEnvDirt(PlayerPedId())
				while IsEntityPlayingAnim(PlayerPedId(),"misslamar1dead_body","dead_idle",3) do
					AnimpostfxStopAll()
					tvRP.stopAnim(true)
					tvRP.stopAnim(false)
					Citizen.Wait(500)
				end
			end
		end
	end
		Citizen.Wait(idle)
	end
end)

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if nocauteado then
			idle = 5
			if timedeath > 0 then
				drawTxt("VOCE TEM ~r~"..timedeath.." ~w~SEGUNDOS DE VIDA, AGUARDE POR SOCORRO MÉDICO",4,0.5,0.93,0.50,255,255,255,255)
			else
				drawTxt("PRESSIONE ~g~E ~w~PARA VOLTAR AO AEROPORTO OU AGUARDE POR SOCORRO MÉDICO",4,0.5,0.93,0.50,255,255,255,255)
			end
			BlockWeaponWheelThisFrame()
			DisableControlAction(0,21,true)
			DisableControlAction(0,23,true)
			DisableControlAction(0,24,true)
			DisableControlAction(0,25,true)
			DisableControlAction(0,47,true)
			DisableControlAction(0,58,true)
			DisableControlAction(0,263,true)
			DisableControlAction(0,264,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,141,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,245,true)
			DisableControlAction(0,143,true)
			DisableControlAction(0,75,true)
			DisableControlAction(0,22,true)
			DisableControlAction(0,32,true)
			DisableControlAction(0,268,true)
			DisableControlAction(0,33,true)
			DisableControlAction(0,269,true)
			DisableControlAction(0,34,true)
			DisableControlAction(0,270,true)
			DisableControlAction(0,35,true)
			DisableControlAction(0,271,true)
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,166,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,167,true)
			DisableControlAction(0,177,true)
			DisableControlAction(0,344,true)
			DisableControlAction(0,29,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,168,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,188,true)
			DisableControlAction(0,311,true)
			if not IsEntityPlayingAnim(PlayerPedId(),"misslamar1dead_body","dead_idle",3) then
				TriggerEvent("emotes","morrer")
			end
		end
		Citizen.Wait(idle)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTXT
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end
