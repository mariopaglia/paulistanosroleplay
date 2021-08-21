local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("farm_heroina")

local processo = false
local segundos = 0

local packWeed = {
	{-1077.68,-1675.67,4.58},
	{-1075.4,-1678.92,4.58},
	{-1079.76,-1679.64,4.58},
}

Citizen.CreateThread(function()
    while true do
		local idle = 1000
		local pCoords = GetEntityCoords(GetPlayerPed(-1), false)
        for k,v in pairs(packWeed) do
            local x,y,z = table.unpack(v)
            local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, x, y, z, true)
			if distance < 1.0 then
				idle = 5
				drawTxt("PRESSIONE  ~r~E~w~  PARA PROCESSAR A DROGA",4,0.5,0.93,0.50,255,255,255,180)
				if not processo then
					if IsControlJustPressed(1, 38) and emP.checkPermission() then
						if emP.checkItem() then
							processo = true
							segundos = 10
							--Citizen.Wait(10000)
						end
					end
				end
			end
		end
        Citizen.Wait(idle)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if segundos > 0 then
			segundos = segundos - 1
			if segundos == 0 then
				processo = false
				TriggerEvent('cancelando',false)
				--ClearPedTasks(PlayerPedId())
			end
		end
	end
end)

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