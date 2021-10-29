local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("nav_armas")

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		TransitionToBlurred(1000)
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		TransitionFromBlurred(1000)
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "armas-comprar-corpodeak" then
		TriggerServerEvent("armas-comprar","corpodeak")
	elseif data == "armas-comprar-corpodeshotgun" then
		TriggerServerEvent("armas-comprar","corpodeshotgun")
	elseif data == "armas-comprar-corpodeg36" then
		TriggerServerEvent("armas-comprar","corpodeg36")
	elseif data == "armas-comprar-corpodemp5" then
		TriggerServerEvent("armas-comprar","corpodemp5")
	elseif data == "armas-comprar-corpodescorpion" then
		TriggerServerEvent("armas-comprar","corpodescorpion")
	elseif data == "armas-comprar-corpodefiveseven" then
		TriggerServerEvent("armas-comprar","corpodefiveseven")
	elseif data == "armas-comprar-corpodehkp7m10" then
		TriggerServerEvent("armas-comprar","corpodehkp7m10")
	elseif data == "armas-comprar-mola" then
		TriggerServerEvent("armas-comprar","mola")
	elseif data == "armas-comprar-gatilho" then
		TriggerServerEvent("armas-comprar","gatilho")	
	elseif data == "municao-comprar-capsula" then
		TriggerServerEvent("armas-comprar","capsula")

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local marcacoes = {
	{ 3822.29,4439.65,2.81 }
}

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local TaylinSleep = 750
		for _,mark in pairs(marcacoes) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(mark)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),x,y,z,true)
			if distance <= 5.0 then
				TaylinSleep = 5
				if distance <= 2.0 then
					if not menuactive then
						DrawText3Ds(x,y,z+0.20,"~r~[E] ~w~Para Acessar a Loja")
					end
					if IsControlJustPressed(0,38) then
						if emP.checkPermission1() then
							ToggleActionMenu()
						elseif emP.checkPermission2() then
							ToggleActionMenu()
						end
					end
				end
			end
		end
		Citizen.Wait(TaylinSleep)
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

function DrawText3Ds(x,y,z,text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.34, 0.34)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.001+ factor, 0.028, 0, 0, 0, 78)
end