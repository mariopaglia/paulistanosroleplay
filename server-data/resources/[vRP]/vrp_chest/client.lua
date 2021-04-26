-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_chest", src)
vSERVER = Tunnel.getInterface("vrp_chest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local chestTimer = 0
local chestOpen = ""
local cbb = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(
	function()
		SetNuiFocus(false, false)
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("chestClose",function(data)
	SetNuiFocus(false, false)
	SendNUIMessage({action = "hideMenu"})
	vSERVER._closeChest(chestOpen)
	chestOpen = ""
	cbb = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("takeItem",function(data)
	if not cbb then
		cbb = true
		vSERVER.takeItem(tostring(chestOpen), data.item, data.amount)
		cbb = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("storeItem",function(data)
	if not cbb then
		cbb = true
		vSERVER.storeItem(tostring(chestOpen), data.item, data.amount)
		cbb = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTO-UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Creative:UpdateChest")
AddEventHandler("Creative:UpdateChest", function(action)
	SendNUIMessage({action = action})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestChest", function(data, cb)
	local res = vSERVER.openChest(tostring(chestOpen))
	if res then
		local inventario = res[1]
		local inventario2 = res[2]
		local peso = res[3]
		local maxpeso = res[4]
		local peso2 = res[5]
		local maxpeso2 = res[6]
		cb({
			inventario = inventario,
			inventario2 = inventario2,
			peso = peso,
			maxpeso = maxpeso,
			peso2 = peso2,
			maxpeso2 = maxpeso2
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local chest = {
	{"policiamilitar", -1077.83,-815.49,11.04},
	{"policiacivil", 476.79,-984.35,24.92},
	{"cosanostra", 1403.79,1144.68,114.34},
	{"bratva", -57.94,981.87,234.58},
	{"verdes", 1227.1,-171.77,79.89},
	{"vermelhos", -1680.74,-157.94,62.44},
	{"roxos", 1451.31,-2001.84,75.66},
	{"motoclub", 891.0,-2097.49,35.6},
	{"yakuza", -867.31,-1458.1,7.53},
	{"camorra", -1886.41,2062.37,140.99},
	{"triade", -601.91,-1618.8,33.02},
	{"farc", 563.52,-3126.63,18.77},
	{"serpentes", 29.46,3669.71,40.45},
	{"rota", -2043.14,-469.68,16.43},
	{"prf", 2901.04,3826.9,54.61},
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(3000)
			if chestTimer > 0 then
				chestTimer = chestTimer - 3
			end
		end
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("chest", function(source, args)
		local ped = PlayerPedId()
		local x, y, z = table.unpack(GetEntityCoords(ped))
		for k, v in pairs(chest) do
			local distance = Vdist(x, y, z, v[2], v[3], v[4])
			if distance <= 2.0 and chestTimer <= 0 then
				chestTimer = 3
				if vSERVER.checkIntPermissions(v[1]) then
					SetNuiFocus(true, true)
					SendNUIMessage({action = "showMenu"})
					chestOpen = v[1]
				end
			end
		end
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MARKER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(
	function()
		--SetNuiFocus(false,false)
		while true do
			local idle = 1000
			local ped = PlayerPedId()
			local x, y, z = table.unpack(GetEntityCoords(ped))
			for k, v in pairs(chest) do
				if Vdist(x, y, z, v[2], v[3], v[4]) <= 2.0 then
					idle = 5
					-- DrawMarker(21, v[2], v[3], v[4] - 0.6, 0, 0, 0, 0.0, 0, 0, 0.4, 0.4, 0.3, 50, 200, 50, 100, 0, 0, 0, 1)
					DrawText3D(v[2], v[3], v[4], "[~r~E~r~]~w~ Para acessar o baú")
					if IsControlJustPressed(0, 38) then
						if Vdist(x, y, z, v[2], v[3], v[4]) <= 1.5 then
							if vSERVER.checkIntPermissions(v[1]) then
								SetNuiFocus(true, true)
								SendNUIMessage({action = "showMenu"})
								chestOpen = v[1]
							end
							print("c")
						end
						print("b")
					end
				end
			end
			Citizen.Wait(idle)
		end
	end
)

function DrawText3D(x, y, z, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local px, py, pz = table.unpack(GetGameplayCamCoords())

	SetTextScale(0.40, 0.40)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 0, 0, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x, _y)
	-- local factor = (string.len(text)) / 370
	-- DrawRect(_x, _y + 0.0125, 0.005 + factor, 0.03, 0, 0, 0, 80)
end
