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
	if data == "utilidades-comprar-gopro" then
		TriggerServerEvent("lojaeletronico-comprar","gopro")	
	elseif data == "utilidades-comprar-celular" then
		TriggerServerEvent("lojaeletronico-comprar","celular")
	elseif data == "utilidades-comprar-gravadordevoz" then
		TriggerServerEvent("lojaeletronico-comprar","gravadordevoz")	
	elseif data == "utilidades-comprar-radio" then
		TriggerServerEvent("lojaeletronico-comprar","radio")

	elseif data == "utilidades-vender-gopro" then
		TriggerServerEvent("lojaeletronico-vender","gopro")	
	elseif data == "utilidades-vender-celular" then
		TriggerServerEvent("lojaeletronico-vender","celular")
	elseif data == "utilidades-vender-gravadordevoz" then
		TriggerServerEvent("lojaeletronico-vender","gravadordevoz")	
	elseif data == "utilidades-vender-radio" then
		TriggerServerEvent("lojaeletronico-vender","radio")
		
	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local marcacoes = {
	{ -657.05,-857.38,24.5 }, -- Digital Den
	{ -925.93,-158.54,46.25 }, -- Fenix Plaza
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
						DrawText3Ds(x,y,z+0.20,"~p~[E] ~w~Para Acessar a Loja de Eletrônicos")
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