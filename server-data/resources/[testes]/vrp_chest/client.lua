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
RegisterNUICallback(
	"chestClose",
	function(data)
		SetNuiFocus(false, false)
		SendNUIMessage({action = "hideMenu"})
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback(
	"takeItem",
	function(data)
		vSERVER.takeItem(tostring(chestOpen), data.item, data.amount)
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback(
	"storeItem",
	function(data)
		vSERVER.storeItem(tostring(chestOpen), data.item, data.amount)
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTO-UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Creative:UpdateChest")
AddEventHandler(
	"Creative:UpdateChest",
	function(action)
		SendNUIMessage({action = action})
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback(
	"requestChest",
	function(data, cb)
		local inventario, inventario2, peso, maxpeso, peso2, maxpeso2 = vSERVER.openChest(tostring(chestOpen))
		if inventario then
			cb(
				{
					inventario = inventario,
					inventario2 = inventario2,
					peso = peso,
					maxpeso = maxpeso,
					peso2 = peso2,
					maxpeso2 = maxpeso2
				}
			)
		end
	end
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local chest = {
	{"Policia", -1078.10, -815.69, 11.03},
	{"TCP", 288.76, -1927.83, 33.66},
	{"ADA", 1663.59, -52.547, 168.31},
	{"Milícia", 1413.18, -701.13, 73.95},
	{"CV", 847.84, -286.97, 73.11},
	{"Motoclub", 977.11, -104.11, 74.84},
	{"lifeinvader", -1062.99, -250.19, 44.02},
	{"loszetas", 35.50, -2679.89, 12.03},
	{"bratva", -57.90, 981.91, 234.57},
	{"buscape", 2416.58, 4994.01, 46.22},
	{"speed", -206.62, -1341.62, 34.89},
	{"merryweather", -2361.75, 3243.43, 92.90},
	{"hotrod", 953.05, -973.41, 39.75},
	{"vanilla", 93.23, -1291.37, 29.26}
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
RegisterCommand(
	"chest",
	function(source, args)
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
			Citizen.Wait(5)
			local ped = PlayerPedId()
			local x, y, z = table.unpack(GetEntityCoords(ped))
			for k, v in pairs(chest) do
				if Vdist(x, y, z, v[2], v[3], v[4]) <= 5.5 then
					-- DrawMarker(21, v[2], v[3], v[4] - 0.6, 0, 0, 0, 0.0, 0, 0, 0.4, 0.4, 0.3, 50, 200, 50, 100, 0, 0, 0, 1)
					DrawText3D(v[2], v[3], v[4], "[~b~E~w~] Para acessar o baú")
					if IsControlJustPressed(0, 38) then
						if Vdist(x, y, z, v[2], v[3], v[4]) <= 1.5 then
							if vSERVER.checkIntPermissions(v[1]) then
								SetNuiFocus(true, true)
								SendNUIMessage({action = "showMenu"})
								chestOpen = v[1]
							end
						end
					end
				end
			end
		end
	end
)

function DrawText3D(x, y, z, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local px, py, pz = table.unpack(GetGameplayCamCoords())

	SetTextScale(0.40, 0.40)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x, _y)
	-- local factor = (string.len(text)) / 370
	-- DrawRect(_x, _y + 0.0125, 0.005 + factor, 0.03, 0, 0, 0, 80)
end
