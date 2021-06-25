local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("nav_barzinho")

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
	if data == "barzinho-comprar-tequila" then
		TriggerServerEvent("barzinho-comprar","tequila")
	
	elseif data == "barzinho-comprar-vodka" then
		TriggerServerEvent("barzinho-comprar","vodka")

	elseif data == "barzinho-comprar-cerveja" then
		TriggerServerEvent("barzinho-comprar","cerveja")

	elseif data == "barzinho-comprar-whisky" then
		TriggerServerEvent("barzinho-comprar","whisky")

	elseif data == "barzinho-comprar-conhaque" then
		TriggerServerEvent("barzinho-comprar","conhaque")

	elseif data == "barzinho-comprar-absinto" then
		TriggerServerEvent("barzinho-comprar","absinto")

	elseif data == "barzinho-comprar-agua" then
		TriggerServerEvent("barzinho-comprar","agua")

	elseif data == "barzinho-vender-tequila" then
		TriggerServerEvent("barzinho-vender","tequila")

	elseif data == "barzinho-vender-vodka" then
		TriggerServerEvent("barzinho-vender","vodka")

	elseif data == "barzinho-vender-cerveja" then
		TriggerServerEvent("barzinho-vender","cerveja")

	elseif data == "barzinho-vender-whisky" then
		TriggerServerEvent("barzinho-vender","whisky")

	elseif data == "barzinho-vender-conhaque" then
		TriggerServerEvent("barzinho-vender","conhaque")

	elseif data == "barzinho-vender-absinto" then
		TriggerServerEvent("barzinho-vender","absinto")

	elseif data == "barzinho-vender-agua" then
		TriggerServerEvent("barzinho-vender","agua")

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local marcacoes = {
	{ -778.74,332.21,196.09 }, -- casa wally 
	{ -782.18,325.59,187.32 }, -- casa porcao
	{ -561.86,289.34,82.18 }, -- Tequila
	{ -433.32,274.1,83.43 }, -- Split
	{ 351.54,288.26,91.2 }, -- Galaxy em baixo
	{ 356.7,282.63,94.2 }, -- Galaxy em cima
	{ 131.1,-1284.17,29.28 }, -- Vanilla
	{ -296.16,6262.69,31.49 }, -- Hen House
	{ -1375.82,-628.93,30.82 }, -- Bahamas
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
						DrawText3Ds(x,y,z+0.20,"~p~[E] ~w~Para Acessar o bar")
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