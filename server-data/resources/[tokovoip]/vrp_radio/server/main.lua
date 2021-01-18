local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_radio")

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

TriggerEvent('esx:getSharedObject69696969', function(obj) ESX = obj end)


RegisterNetEvent("vrp_radio:startActionB")
AddEventHandler("vrp_radio:startActionB", function()
	local xPlayers = vRP.getUsers({})

	for i=1, #xPlayers, 1 do

	local xPlayer = vRP.getUserId({xPlayers[i]})
	print("Line 17")
	print(xPlayer)
			if vRP.hasGroup({xPlayer, "cop"}) then
				TriggerClientEvent("vrp_radio:startAnim", vRP.getUserSource({xPlayer})) -- Client Event auf Animatonen start
				TriggerClientEvent("vrp_radio:startActionB", vRP.getUserSource({xPlayer})) -- Client Event auf Aktionen start
				TriggerClientEvent("vrp_radio:checkActionNearbyB", vRP.getUserSource({xPlayer})) -- Client Event auf Nearby Check
			end
		end
end)

RegisterNetEvent("vrp_radio:stopActionB")
AddEventHandler("vrp_radio:stopActionB", function()
		local xPlayers = vRP.getUsers({})

		for i=1, #xPlayers, 1 do

			local xPlayer = vRP.getUserId({xPlayers[i]})
		print("Line 33")
		print(xPlayer)

			if vRP.hasGroup({xPlayer, "cop"}) then
				TriggerClientEvent("vrp_radio:stopAnim", vRP.getUserSource({xPlayer})) -- Client Event auf Animatonen start
				TriggerClientEvent("vrp_radio:stopActionB", vRP.getUserSource({xPlayer})) -- Client Event auf Aktionen start
				TriggerClientEvent("vrp_radio:dontCheckActionNearbyB", vRP.getUserSource({xPlayer})) -- Client Event auf Nearby Check
			end
		end
end)

RegisterServerEvent('vrp_radio:playSoundWithinDistanceServer')
AddEventHandler('vrp_radio:playSoundWithinDistanceServer', function(maxDistance, soundFile, soundVolume)
	local xPlayers = vRP.getUsers({})

		for i=1, #xPlayers, 1 do

		local xPlayer = vRP.getUserId({xPlayers[i]})
		print("Line 52")
		print(xPlayer)

			if vRP.hasGroup({xPlayer, "cop"}) then
				TriggerClientEvent('vrp_radio:playSoundWithinDistanceClient', -1, vRP.getUserSource({xPlayer}), maxDistance, soundFile, soundVolume)
			end
		end
end)

RegisterServerEvent('vrp_radio:isCop')
AddEventHandler('vrp_radio:isCop', function(user)
	local user_id = vRP.getUserId({source})
	if vRP.hasGroup({user_id,"cop"}) then
		print("User is Cop")
		TriggerClientEvent("vrp_radio:doActions", vRP.getUserSource({user_id}))
	end
end)