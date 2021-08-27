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
	if data == "utilidades-comprar-adrenalina" then
		TriggerServerEvent("farmacia-comprar","adrenalina")	
	elseif data == "utilidades-comprar-bandagem" then
		TriggerServerEvent("farmacia-comprar","bandagem")

	elseif data == "utilidades-vender-adrenalina" then
		TriggerServerEvent("farmacia-vender","adrenalina")	
	elseif data == "utilidades-vender-celular" then
		TriggerServerEvent("farmacia-vender","bandagem")
		
	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local marcacoes = {
	{ 326.03,-1074.38,29.48 },
	{ 98.39,-225.76,54.64 },
	{ 591.32,2744.79,42.05 },
	{ -57.03,6521.46,31.5 },
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
						DrawText3Ds(x,y,z+0.20,"~r~[E] ~w~Para Acessar a Farmácia")
					end
					if IsControlJustPressed(0,38) then
						ToggleActionMenu()
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