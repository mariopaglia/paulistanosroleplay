local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

oC = Tunnel.getInterface("bratva_craft")
-------------------------------------------------------------------------------------------------
--[ LOCAL ]--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local prodMachine = {
	--{ ['x'] = -101.75, ['y'] = 1053.75, ['z'] = 226.82 }
	{ ['x'] = -100.33, ['y'] = 1012.59, ['z'] = 235.8 }
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

	elseif data == "produzir-uzi" then
		TriggerServerEvent("produzir-arma","uzi")

	elseif data == "produzir-assaultsmg" then
		TriggerServerEvent("produzir-arma","assaultsmg")

	elseif data == "produzir-famas" then
		TriggerServerEvent("produzir-arma","famas")

	elseif data == "produzir-magnum" then
		TriggerServerEvent("produzir-arma","magnum")

	elseif data == "produzir-fiveseven" then
		TriggerServerEvent("produzir-arma","fiveseven")
		
	elseif data == "produzir-molas" then
		TriggerServerEvent("produzir-arma","molas")

	elseif data == "produzir-gatilho" then
		TriggerServerEvent("produzir-arma","gatilho")

	elseif data == "fechar" then
		ToggleActionMenu()
		onmenu = false
	end
end)


RegisterNetEvent("fechar-nui")
AddEventHandler("fechar-nui", function()
	ToggleActionMenu()
	onmenu = false

	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local bowz,cdz = GetGroundZFor_3dCoord(-100.33,1012.59,235.8)
	local distance = GetDistanceBetweenCoords(-100.33,1012.59, cdz, x, y, z, true)

	if distance < 3.2 then
		TriggerEvent("armas:posicao1")	
	else
		TriggerEvent("armas:posicao2")
	end
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

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), prodMachine.x, prodMachine.y, prodMachine.z, true ) < 1.2 and not onmenu then
				DrawText3D(prodMachine.x, prodMachine.y, prodMachine.z, "Pressione [~b~E~w~] para utilizar a ~b~BANCADA~w~.")
			end
			if distance <= 5 then
				DrawMarker(23, prodMachine.x, prodMachine.y, prodMachine.z-0.97,0,0,0,0,0,0,0.7,0.7,0.5,214,29,0,100,0,0,0,0)
				idle = 5
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
end