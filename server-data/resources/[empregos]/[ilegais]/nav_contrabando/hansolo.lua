local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

oC = Tunnel.getInterface("nav_contrabando")
local nomesnui = "fechar-nui-contrabando"
-------------------------------------------------------------------------------------------------
--[ LOCAL ]--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local prodMachine = {
	{ ['x'] = 707.32, ['y'] = -966.99, ['z'] = 30.42 } -- 707.32,-966.99,30.42
}
-------------------------------------------------------------------------------------------------
--[ MENU ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local menuactive = false
local onmenu = false

function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
	end
end
-------------------------------------------------------------------------------------------------
--[ BOTÕES ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "produzir-c4" then
		TriggerServerEvent("produzir-contrabando","c4")

	elseif data == "produzir-gps" then
		TriggerServerEvent("produzir-contrabando","gps")
		
	elseif data == "produzir-corda" then
		TriggerServerEvent("produzir-contrabando","corda")

	elseif data == "produzir-placa" then
		TriggerServerEvent("produzir-contrabando","placa")

	elseif data == "produzir-algemas" then
		TriggerServerEvent("produzir-contrabando","algemas")

	elseif data == "produzir-capuz" then
		TriggerServerEvent("produzir-contrabando","capuz")
	
	elseif data == "produzir-lockpick" then
		TriggerServerEvent("produzir-contrabando","lockpick")
	
	elseif data == "produzir-cartaoinvasao" then
		TriggerServerEvent("produzir-contrabando","cartaoinvasao")

	elseif data == "produzir-ticketpvp" then
		TriggerServerEvent("produzir-contrabando","ticketpvp")

	elseif data == "fechar" then
		ToggleActionMenu()
		onmenu = false
	end
end)

-- RegisterNetEvent("bancada-armas:posicao")
-- AddEventHandler("bancada-armas:posicao", function()
-- 	local ped = PlayerPedId()
-- 	SetEntityHeading(ped,270.89)
-- 	SetEntityCoords(ped,1405.96,1137.86,109.75-1,false,false,false,false)
-- end)

RegisterNetEvent(nomesnui)
AddEventHandler(nomesnui, function()
	ToggleActionMenu()
	onmenu = false
end)
-------------------------------------------------------------------------------------------------
--[ AÇÃO ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do

		local idle = 1000
		for k,v in pairs(prodMachine) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local prodMachine = prodMachine[k]
			local idBancada = prodMachine[id]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), prodMachine.x, prodMachine.y, prodMachine.z, true ) <= 1 and not onmenu then
				DrawText3D(prodMachine.x, prodMachine.y, prodMachine.z, "[~r~E~w~] Para acessar a ~r~BANCADA~w~")
			end
			if distance <= 15 then
				idle = 5
				DrawMarker(23, prodMachine.x, prodMachine.y, prodMachine.z-0.97,0,0,0,0,0,0,0.7,0.7,0.5,214,29,0,100,0,0,0,0)
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) then
						ToggleActionMenu()
						onmenu = true
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)
-------------------------------------------------------------------------------------------------
--[ FUNÇÃO ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end