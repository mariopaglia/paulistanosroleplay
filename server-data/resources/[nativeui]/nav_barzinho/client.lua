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
		
	elseif data == "barzinho-comprar-hamburguer" then
		TriggerServerEvent("barzinho-comprar","hamburguer")
		
	elseif data == "barzinho-comprar-pizza" then
		TriggerServerEvent("barzinho-comprar","pizza")
		
	elseif data == "barzinho-comprar-rosquinha" then
		TriggerServerEvent("barzinho-comprar","rosquinha")
		
	elseif data == "barzinho-comprar-sanduiche" then
		TriggerServerEvent("barzinho-comprar","sanduiche")
		
	elseif data == "barzinho-comprar-frangofrito" then
		TriggerServerEvent("barzinho-comprar","frangofrito")
		
	elseif data == "barzinho-comprar-batatafrita" then
		TriggerServerEvent("barzinho-comprar","batatafrita")
		
	elseif data == "barzinho-comprar-cachorroquente" then
		TriggerServerEvent("barzinho-comprar","cachorroquente")
		
	elseif data == "barzinho-comprar-sprite" then
		TriggerServerEvent("barzinho-comprar","sprite")
		
	elseif data == "barzinho-comprar-leite" then
		TriggerServerEvent("barzinho-comprar","leite")
		
	elseif data == "barzinho-comprar-mamadeira" then
		TriggerServerEvent("barzinho-comprar","mamadeira")
		
	elseif data == "barzinho-comprar-cafe" then
		TriggerServerEvent("barzinho-comprar","cafe")
		
	elseif data == "barzinho-comprar-cappuccino" then
		TriggerServerEvent("barzinho-comprar","cappuccino")
		
	elseif data == "barzinho-comprar-suco" then
		TriggerServerEvent("barzinho-comprar","suco")
		
	elseif data == "barzinho-comprar-cocacola" then
		TriggerServerEvent("barzinho-comprar","cocacola")
--

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
	{ -635.23,235.58,81.89 }, -- Cafeteria
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
						DrawText3Ds(x,y,z+0.10,"~p~[E] ~w~Para Acessar o bar")
					end
					if IsControlJustPressed(0,38) then
						if emP.checkPermission1() then
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