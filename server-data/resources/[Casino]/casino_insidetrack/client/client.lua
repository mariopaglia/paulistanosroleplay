local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = Tunnel.getInterface("insidetrack")

local cooldown = 60
local tick = 0
local checkRaceStatus = false
local insideTrackActive = false
local gameOpen = false
local insideTrackLocation = vector3(1096.55, 260.75, -51.24)

local function OpenInsideTrack()
    if insideTrackActive then
        return
    end

    insideTrackActive = true

    -- Scaleform
    Utils.Scaleform = RequestScaleformMovie('HORSE_RACING_CONSOLE')

    while not HasScaleformMovieLoaded(Utils.Scaleform) do
        Wait(0)
    end

    DisplayHud(false)
    --SetPlayerControl(PlayerId(), false, 0)
	SetNuiFocus(true,false)
    ReleaseNamedRendertarget("casinoscreen_02")

    while not RequestScriptAudioBank('DLC_VINEWOOD/CASINO_GENERAL') do
        Wait(0)
    end

    Utils:ShowMainScreen()
    Utils:SetMainScreenCooldown(cooldown)

    -- Add horses
    Utils.AddHorses(Utils.Scaleform)

    Utils:DrawInsideTrack()
    Utils:HandleControls()
end

local function LeaveInsideTrack()
    insideTrackActive = false

    DisplayHud(true)
    --SetPlayerControl(PlayerId(), true, 0)
	SetNuiFocus(false,false)
    SetScaleformMovieAsNoLongerNeeded(Utils.Scaleform)

    Utils.Scaleform = -1
end

function Utils:DrawInsideTrack()
    Citizen.CreateThread(function()
        while insideTrackActive do
            Wait(0)

            local xMouse, yMouse = GetDisabledControlNormal(2, 239), GetDisabledControlNormal(2, 240)

            -- Fake cooldown
            tick = (tick + 10)

            if (tick == 1000) then
                if (cooldown == 1) then
                    cooldown = 60
                end
                
                cooldown = (cooldown - 1)
                tick = 0

                Utils:SetMainScreenCooldown(cooldown)
            end
            
            -- Mouse control
            BeginScaleformMovieMethod(Utils.Scaleform, 'SET_MOUSE_INPUT')
            ScaleformMovieMethodAddParamFloat(xMouse)
            ScaleformMovieMethodAddParamFloat(yMouse)
            EndScaleformMovieMethod()

            -- Draw
            DrawScaleformMovieFullscreen(Utils.Scaleform, 255, 255, 255, 255)
        end
    end)
end

function Utils:HandleControls()
    Citizen.CreateThread(function()
        while insideTrackActive do
            Wait(0)

            if IsControlJustPressed(2, 194) then
                LeaveInsideTrack()

                Utils:HandleBigScreen()
            end

            -- Left click
            if IsControlJustPressed(2, 237) then
                local clickedButton = Utils:GetMouseClickedButton()

                if Utils.ChooseHorseVisible then
                    if (clickedButton ~= 12) and (clickedButton ~= -1) then
                        Utils.CurrentHorse = (clickedButton - 1)
                        Utils:ShowBetScreen(Utils.CurrentHorse)
                        Utils.ChooseHorseVisible = false
                    end
                end

                -- Rules button
                if (clickedButton == 15) then
                    Utils:ShowRules()
                end

                -- Close buttons
                if (clickedButton == 12) then
                    if Utils.ChooseHorseVisible then
                        Utils.ChooseHorseVisible = false
                    end
                    
                    if Utils.BetVisible then
                        Utils:ShowHorseSelection()
                        Utils.BetVisible = false
                        Utils.CurrentHorse = -1
                    else
                        Utils:ShowMainScreen()
                    end
                end

                -- Start bet
                if (clickedButton == 1) then
                    Utils:ShowHorseSelection()
                end

                -- Start race
                if (clickedButton == 10) then
                    PlaySoundFrontend(-1, 'race_loop', 'dlc_vw_casino_inside_track_betting_single_event_sounds')
                    TriggerServerEvent("insidetrack:server:placebet", Utils.CurrentBet)
                    Utils:StartRace()
                    checkRaceStatus = true
                end

                -- Change bet
                if (clickedButton == 8) then
                    if (Utils.CurrentBet < Utils.PlayerBalance) then
                        Utils.CurrentBet = (Utils.CurrentBet + 100)
                        Utils.CurrentGain = (Utils.CurrentBet * 2)
                        Utils:UpdateBetValues(Utils.CurrentHorse, Utils.CurrentBet, Utils.PlayerBalance, Utils.CurrentGain)
                    end
                end

                if (clickedButton == 9) then
                    if (Utils.CurrentBet > 100) then
                        Utils.CurrentBet = (Utils.CurrentBet - 100)
                        Utils.CurrentGain = (Utils.CurrentBet * 2)
                        Utils:UpdateBetValues(Utils.CurrentHorse, Utils.CurrentBet, Utils.PlayerBalance, Utils.CurrentGain)
                    end
                end

                if (clickedButton == 13) then
                    Utils:ShowMainScreen()
                end

                -- Check race
                while checkRaceStatus do
                    Wait(0)

                    local raceFinished = Utils:IsRaceFinished()

                    if (raceFinished) then
                        StopSound(0)

                        if (Utils.CurrentHorse == Utils.CurrentWinner) then
                            TriggerServerEvent("insidetrack:server:winnings", Utils.CurrentGain)
                        end
						
						Utils:UpdateBetValues(Utils.CurrentHorse, Utils.CurrentBet, Utils.PlayerBalance, Utils.CurrentGain)

                        Utils:ShowResults()

                        Utils.CurrentHorse = -1
                        Utils.CurrentWinner = -1
                        Utils.HorsesPositions = {}

                        checkRaceStatus = false
                    end
                end
            end
        end
    end)
end

local insideMarker = false
local tabletObject = nil

Citizen.CreateThread(function()
    while true do
	local sleep = 1000
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local dist = #(insideTrackLocation - coords)

        if dist <= 5.0 then
		    sleep = 4
			DrawMarker(27, insideTrackLocation.x, insideTrackLocation.y, insideTrackLocation.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.00, 1.00, 255, 0, 0, 0, false, true, 2, true, false, false, false)
            if dist <= 100.0 and not insideTrackActive then
				drawNativeNotification("Pressione ~INPUT_PICKUP~ para abrir e ~INPUT_CELLPHONE_CANCEL~ para fechar")
                insideMarker = true
				
            end
        else
            insideMarker = false
        end
		Citizen.Wait(sleep)
    end
end)

RegisterCommand("+InsideTrack", function()
    local playerPed = PlayerPedId()
    if insideMarker then
	local dict = "amb@world_human_seat_wall_tablet@female@base"
        RequestAnimDict(dict)
        if tabletObject == nil then
            tabletObject = CreateObject(GetHashKey('prop_cs_tablet'), GetEntityCoords(playerPed), 1, 1, 1)
            AttachEntityToEntity(tabletObject, playerPed, GetPedBoneIndex(playerPed, 28422), 0.0, 0.0, 0.03, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
        end
        while not HasAnimDictLoaded(dict) do Citizen.Wait(100) end
        if not IsEntityPlayingAnim(playerPed, dict, 'base', 3) then
            TaskPlayAnim(playerPed, dict, "base", 8.0, 1.0, -1, 49, 1.0, 0, 0, 0)
			OpenInsideTrack()
        end
    end
end, false)

RegisterCommand("-InsideTrack", function()
   local playerPed = PlayerPedId()
    Wait(1500)
    DeleteEntity(tabletObject)
    tabletObject = nil
end,false)
TriggerEvent("chat:removeSuggestion", "/+InsideTrack")
TriggerEvent("chat:removeSuggestion", "/-InsideTrack")

RegisterKeyMapping("+InsideTrack", "Interact with inside track at the casino", "keyboard" ,"E")

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function drawNativeNotification(text)
    SetTextComponentFormat('STRING')
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end