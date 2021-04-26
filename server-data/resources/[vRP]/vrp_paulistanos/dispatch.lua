-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPATCH
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for i = 1,120 do
		EnableDispatchService(i,false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVER ARMA ABAIXO DE 40MPH DENTRO DO CARRO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetPlayerCanDoDriveBy(PlayerId(),false)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TREM NO MAPA
-----------------------------------------------------------------------------------------------------------------------------------------
-- Citizen.CreateThread(function()
-- 	SwitchTrainTrack(0, true)
-- 	SwitchTrainTrack(3, true)
-- 	N_0x21973bbf8d17edfa(0, 120000)
-- 	SetRandomTrains(true)
--   end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUS DO DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30000)
		players = {}
		for _, i in pairs(GetActivePlayers()) do
            if NetworkIsPlayerActive(i) then
                table.insert(players,i)
            end
        end
		SetDiscordAppId(756846972077342781)
		SetDiscordRichPresenceAsset('logo')
        SetRichPresence("discord.gg/F3Jp5J2")
        -- SetRichPresence("Jogadores Online: "..#players)

        SetDiscordRichPresenceAssetText('discord.gg/F3Jp5J2')
		SetDiscordRichPresenceAction(0, "Entrar na Cidade", "fivem://connect/paulistanosrp.com") -- Botão 1
		SetDiscordRichPresenceAction(1, "Discord", "https://discord.gg/F3Jp5J2") -- Botão 2
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLACKOUT
-----------------------------------------------------------------------------------------------------------------------------------------
local isBlackout = false
local oldSpeed = 0

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local vehicle = GetVehiclePedIsIn(PlayerPedId())
		if IsEntityAVehicle(vehicle) and GetPedInVehicleSeat(vehicle,-1) == PlayerPedId() then
			idle = 100
			local currentSpeed = GetEntitySpeed(vehicle)*2.236936
			if currentSpeed ~= oldSpeed then
				if not isBlackout and (currentSpeed < oldSpeed) and ((oldSpeed - currentSpeed) >= 50) then
					blackout()
				end
				oldSpeed = currentSpeed
			end
		else
			if oldSpeed ~= 0 then
				oldSpeed = 0
			end
		end

		if isBlackout then
			DisableControlAction(0,63,true)
			DisableControlAction(0,64,true)
			DisableControlAction(0,71,true)
			DisableControlAction(0,72,true)
			DisableControlAction(0,75,true)
		end
		Citizen.Wait(idle)
	end
end)

function blackout()
	TriggerEvent("vrp_sound:source",'heartbeat',0.5)
	if not isBlackout then
		isBlackout = true
		SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId())-50)
		Citizen.CreateThread(function()
			DoScreenFadeOut(500)
			while not IsScreenFadedOut() do
				Citizen.Wait(10)
			end
			Citizen.Wait(5000)
			DoScreenFadeIn(5000)
			isBlackout = false
		end)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {
	{ ['x'] = 265.64, ['y'] = -1261.30, ['z'] = 29.29, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 819.65, ['y'] = -1028.84, ['z'] = 26.40, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 1208.95, ['y'] = -1402.56, ['z'] = 35.22, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 1181.38, ['y'] = -330.84, ['z'] = 69.31, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 620.84, ['y'] = 269.10, ['z'] = 103.08, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 2581.32, ['y'] = 362.03, ['z'] = 108.46, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 176.63, ['y'] = -1562.02, ['z'] = 29.26, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 176.63, ['y'] = -1562.02, ['z'] = 29.26, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = -319.29, ['y'] = -1471.71, ['z'] = 30.54, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 1784.32, ['y'] = 3330.55, ['z'] = 41.25, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 49.418, ['y'] = 2778.79, ['z'] = 58.04, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 263.89, ['y'] = 2606.46, ['z'] = 44.98, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 1039.95, ['y'] = 2671.13, ['z'] = 39.55, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 1207.26, ['y'] = 2660.17, ['z'] = 37.89, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 2539.68, ['y'] = 2594.19, ['z'] = 37.94, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 2679.85, ['y'] = 3263.94, ['z'] = 55.24, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 2005.05, ['y'] = 3773.88, ['z'] = 32.40, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 1687.15, ['y'] = 4929.39, ['z'] = 42.07, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 1701.31, ['y'] = 6416.02, ['z'] = 32.76, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 179.85, ['y'] = 6602.83, ['z'] = 31.86, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = -94.46, ['y'] = 6419.59, ['z'] = 31.48, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = -2554.99, ['y'] = 2334.40, ['z'] = 33.07, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = -1800.37, ['y'] = 803.66, ['z'] = 138.65, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = -1437.62, ['y'] = -276.74, ['z'] = 46.20, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = -2096.24, ['y'] = -320.28, ['z'] = 13.16, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = -724.61, ['y'] = -935.16, ['z'] = 19.21, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = -526.01, ['y'] = -1211.00, ['z'] = 18.18, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = -70.21, ['y'] = -1761.79, ['z'] = 29.53, ['sprite'] = 361, ['color'] = 41, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 }
}

Citizen.CreateThread(function()
	for _,v in pairs(blips) do
		local blip = AddBlipForCoord(v.x,v.y,v.z)
		SetBlipSprite(blip,v.sprite)
		SetBlipAsShortRange(blip,true)
		SetBlipColour(blip,v.color)
		SetBlipScale(blip,v.scale)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(v.nome)
		EndTextCommandSetBlipName(blip)
	end
end)



-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDS
-------------------------------------------------

-- local pedlist = {
-- 	{ ['x'] = 426.10, ['y'] = 6463.47, ['z'] = 28.77, ['h'] = 315.75, ['hash'] = 0xFCFA9E1E, ['hash2'] = "A_C_Cow" },
-- 	{ ['x'] = 431.42, ['y'] = 6459.22, ['z'] = 28.75, ['h'] = 318.05, ['hash'] = 0xFCFA9E1E, ['hash2'] = "A_C_Cow" },
-- 	{ ['x'] = 436.70, ['y'] = 6454.85, ['z'] = 28.74, ['h'] = 321.40, ['hash'] = 0xFCFA9E1E, ['hash2'] = "A_C_Cow" },
-- 	{ ['x'] = 428.42, ['y'] = 6477.27, ['z'] = 28.78, ['h'] = 134.37, ['hash'] = 0xFCFA9E1E, ['hash2'] = "A_C_Cow" },
-- 	{ ['x'] = 1151.77, ['y'] = -3248.77, ['z'] = 5.90, ['h'] = 181.03, ['hash'] = 0x6C9B2849, ['hash2'] = "a_m_m_hillbilly_01" },
-- 	{ ['x'] = 1152.27, ['y'] = -3248.77, ['z'] = 5.90, ['h'] = 181.03, ['hash'] = 0x349F33E1, ['hash2'] = "a_c_retriever" },
-- 	{ ['x'] = 1151.26, ['y'] = -3248.77, ['z'] = 5.90, ['h'] = 181.03, ['hash'] = 0x9563221D, ['hash2'] = "a_c_rottweiler" },
-- 	{ ['x'] = 1122.94, ['y'] = -1304.64, ['z'] = 5.90, ['h'] = 34.71, ['hash'] = 0x9563221D, ['hash2'] = "a_c_rottweiler" }
-- }

-- Citizen.CreateThread(function()
-- 	for k,v in pairs(pedlist) do
-- 		RequestModel(GetHashKey(v.hash2))
-- 		while not HasModelLoaded(GetHashKey(v.hash2)) do
-- 			Citizen.Wait(10)
-- 		end

-- 		local ped = CreatePed(4,v.hash,v.x,v.y,v.z-1,v.h,false,true)
-- 		FreezeEntityPosition(ped,true)
-- 		SetEntityInvincible(ped,true)
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAZERTIME
-----------------------------------------------------------------------------------------------------------------------------------------
local isTaz = false
Citizen.CreateThread(function()
	while true do
		local esperar = 1000
        if IsPedBeingStunned(GetPlayerPed(-1)) and not isTaz then
            esperar = 4
			isTaz = true
			SetTimecycleModifier("REDMIST_blend")
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 1.0)
            SetPedToRagdoll(GetPlayerPed(-1), 5000, 5000, 0, 0, 0, 0)
		elseif not IsPedBeingStunned(GetPlayerPed(-1)) and isTaz then
			isTaz = false
			Wait(5000)
			SetTimecycleModifier("hud_def_desat_Trevor")
			Wait(10000)
            ClearTimecycleModifier()
			SetTransitionTimecycleModifier("")
			StopGameplayCamShaking()
        end
        Citizen.Wait(esperar)
	end
end)