local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

oC = Tunnel.getInterface("oc_producao-municoes")
-------------------------------------------------------------------------------------------------
--[ LOCAL ]--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local prodMachine = {
	{ ['x'] = 1403.61, ['y'] = 1136.5, ['z'] = 109.75 },
	{ ['x'] = 604.76, ['y'] = -3075.51, ['z'] = 6.07 }
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
	if data == "produzir-m-ak47" then
		TriggerServerEvent("produzir-municao","m-ak47")

	elseif data == "produzir-m-ak74u" then
		TriggerServerEvent("produzir-municao","m-ak74u")

	elseif data == "produzir-m-uzi" then
		TriggerServerEvent("produzir-municao","m-uzi")

	elseif data == "produzir-m-magnum44" then
		TriggerServerEvent("produzir-municao","m-magnum44")

	elseif data == "produzir-m-glock" then
		TriggerServerEvent("produzir-municao","m-glock")

	elseif data == "fechar" then
		ToggleActionMenu()
		onmenu = false
	end
end)

RegisterNetEvent("bancada-municoes:posicao")
AddEventHandler("bancada-municoes:posicao", function()
	local ped = PlayerPedId()
	SetEntityHeading(ped,182.94)
	SetEntityCoords(ped,1403.56,1136.47,109.75-1,false,false,false,false)
end)

RegisterNetEvent("fechar-nui-municoes")
AddEventHandler("fechar-nui-municoes", function()
	ToggleActionMenu()
	onmenu = false
end)
-------------------------------------------------------------------------------------------------
--[ AÇÃO ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		for k,v in pairs(prodMachine) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local prodMachine = prodMachine[k]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), prodMachine.x, prodMachine.y, prodMachine.z, true ) <= 1 and not onmenu then
				DrawText3D(prodMachine.x, prodMachine.y, prodMachine.z, "[~r~E~w~] Para acessar a ~r~BANCADA DE MUNIÇÕES~w~.")
			end
			if distance <= 15 then
				DrawMarker(23, prodMachine.x, prodMachine.y, prodMachine.z-0.97,0,0,0,0,0,0,0.7,0.7,0.5,214,29,0,100,0,0,0,0)
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) and oC.checkPermissao() then
						ToggleActionMenu()
						onmenu = true
					end
				end
			end
		end
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