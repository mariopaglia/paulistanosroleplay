local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("emp_desmanche")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local segundos = 0
local roubando = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ ['x'] = 1261.5, ['y'] = -2565.61, ['z'] = 42.75, ['perm'] = "serpentes.permissao" }, -- 1261.5, -2565.61, 42.75
	{ ['x'] = 1548.73, ['y'] = 3517.11, ['z'] = 36.10, ['perm'] = "motoclub.permissao" }, -- 1548.73, 3517.11, 36.10
	-- { ['x'] = 2340.87, ['y'] = 3050.18, ['z'] = 48.16, ['perm'] = "serpentes.permissao" } -- 2340.87, 3050.18, 48.16
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESMANCHE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if not roubando then
			for _,v in pairs(locais) do
				local ped = PlayerPedId()
				local x,y,z = table.unpack(v)
				local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),v.x,v.y,v.z)
				if distance <= 30 and GetPedInVehicleSeat(GetVehiclePedIsUsing(ped),-1) == ped then
					idle = 5
					DrawMarker(23,v.x,v.y,v.z-0.96,0,0,0,0,0,0,5.0,5.0,0.5,255,0,0,50,0,0,0,0)
					if distance <= 3.1 and IsControlJustPressed(0,38) then
						if emP.checkVehicle() and emP.checkPermission(v.perm) and emP.checkItem() then
							roubando = true
							segundos = 60
							FreezeEntityPosition(GetVehiclePedIsUsing(ped),true)

							repeat
								Citizen.Wait(60)
							until segundos == 0

							TriggerServerEvent("desmancheVehicles")
							roubando = false
						end
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEXTO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if roubando then
			idle = 5
			if segundos > 0 then
				DisableControlAction(0,75)
				drawTxt("AGUARDE ~g~"..segundos.." SEGUNDOS~w~, ESTAMOS DESATIVANDO O ~y~RASTREADOR ~w~DO VEÍCULO",4,0.5,0.93,0.50,255,255,255,180)
			end
		end
		Citizen.Wait(idle)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIMINUINDO O TEMPO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if roubando then
			if segundos > 0 then
				segundos = segundos - 1
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
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