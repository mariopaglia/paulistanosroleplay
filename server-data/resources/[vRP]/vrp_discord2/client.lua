------------------------CREDITS------------------------
--------- Script made by H3cker | DevHUB#7723   -------
--      Script made for StreamForce Romania RP       --
--          Site: https://devstudios.store           --
--        Forum: http://forum.devstudios.store       --
--   Copyright 2019 ©DevStudios. All rights served   --
-------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        TriggerServerEvent("vRP:Discord")
		Citizen.Wait(10000000000000000)
	end
end)

RegisterNetEvent('vRP:Discord-rich')
AddEventHandler('vRP:Discord-rich', function(user_id, faction, name)
SetDiscordAppId(748524311228448837)-- Discord app ID
SetDiscordRichPresenceAsset('logo') -- PNG file
SetDiscordRichPresenceAssetText('Paulistanos Roleplay') -- PNG text desc
SetDiscordRichPresenceAssetSmall('logo') -- PNG small
SetDiscordRichPresenceAssetSmallText('https://discord.gg/F3Jp5J2') -- PNG text desc2
SetRichPresence("[ID:"..user_id.."][Profissão:"..faction.."][Nome:"..name.. "] - | "..GetNumberOfPlayers().. "/24 |")
end)
