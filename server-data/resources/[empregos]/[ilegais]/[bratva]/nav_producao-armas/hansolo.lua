local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

oC = Tunnel.getInterface("nav_producao-armas")
-------------------------------------------------------------------------------------------------
--[ LOCAL ]--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local prodMachine = {
	{ ['x'] = -85.7, ['y'] = 997.66, ['z'] = 230.61 }, -- -85.7,997.66,230.61
	{ ['x'] = 1405.88, ['y'] = 1137.74, ['z'] = 109.75 }, -- 1405.88,1137.74,109.75
	{ ['x'] = -1870.58, ['y'] = 2061.41, ['z'] = 135.44 }, -- -1870.58,2061.41,135.44
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
	if data == "produzir-ak47" then
		TriggerServerEvent("produzir-arma","ak47")

	elseif data == "produzir-g36" then
		TriggerServerEvent("produzir-arma","g36")

	elseif data == "produzir-mp5" then
		TriggerServerEvent("produzir-arma","mp5")

	elseif data == "produzir-fiveseven" then
		TriggerServerEvent("produzir-arma","fiveseven")

	elseif data == "produzir-hkp7m10" then
		TriggerServerEvent("produzir-arma","hkp7m10")

	elseif data == "produzir-m-ak47" then
		TriggerServerEvent("produzir-arma","m-ak47")

	elseif data == "produzir-m-g36" then
		TriggerServerEvent("produzir-arma","m-g36")

	elseif data == "produzir-m-mp5" then
		TriggerServerEvent("produzir-arma","m-mp5")

	elseif data == "produzir-m-fiveseven" then
		TriggerServerEvent("produzir-arma","m-fiveseven")

	elseif data == "produzir-m-hkp7m10" then
		TriggerServerEvent("produzir-arma","m-hkp7m10")

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

RegisterNetEvent("fechar-nui")
AddEventHandler("fechar-nui", function()
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
					if IsControlJustPressed(0,38) and oC.checkPermissao() then
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