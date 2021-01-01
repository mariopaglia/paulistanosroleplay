local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("farm_cocaina")

local processo = false
local segundos = 0

local packWeed = {
	{-1106.52,4951.04,218.65},
	{-1106.44,4945.89,218.65},
	{-1107.37,4941.75,218.65},
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		local pCoords = GetEntityCoords(GetPlayerPed(-1), false)
        for k,v in pairs(packWeed) do
            local x,y,z = table.unpack(v)
            local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, x, y, z, true)
			if distance < 1.0 then
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