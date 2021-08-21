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
	if data == "utilidades-comprar-sapatosroubado" then
		TriggerServerEvent("vendaresidencia-comprar","sapatosroubado")	
	elseif data == "utilidades-comprar-relogioroubado" then
		TriggerServerEvent("vendaresidencia-comprar","relogioroubado")
	elseif data == "utilidades-comprar-anelroubado" then
		TriggerServerEvent("vendaresidencia-comprar","anelroubado")	
	elseif data == "bebidas-comprar-colarroubado" then
		TriggerServerEvent("vendaresidencia-comprar","colarroubado")
	elseif data == "utilidades-comprar-notebookroubado" then
		TriggerServerEvent("vendaresidencia-comprar","notebookroubado")
	elseif data == "utilidades-comprar-tabletroubado" then
		TriggerServerEvent("vendaresidencia-comprar","tabletroubado")
	elseif data == "utilidades-comprar-vibradorroubado" then
		TriggerServerEvent("vendaresidencia-comprar","vibradorroubado")
	elseif data == "utilidades-comprar-carteiraroubada" then
		TriggerServerEvent("vendaresidencia-comprar","carteiraroubada")
	elseif data == "utilidades-comprar-perfumeroubado" then
		TriggerServerEvent("vendaresidencia-comprar","perfumeroubado")

	elseif data == "utilidades-vender-sapatosroubado" then
		TriggerServerEvent("vendaresidencia-vender","sapatosroubado")	
	elseif data == "utilidades-vender-relogioroubado" then
		TriggerServerEvent("vendaresidencia-vender","relogioroubado")
	elseif data == "utilidades-vender-anelroubado" then
		TriggerServerEvent("vendaresidencia-vender","anelroubado")	
	elseif data == "bebidas-vender-colarroubado" then
		TriggerServerEvent("vendaresidencia-vender","colarroubado")
	elseif data == "utilidades-vender-notebookroubado" then
		TriggerServerEvent("vendaresidencia-vender","notebookroubado")
	elseif data == "utilidades-vender-tabletroubado" then
		TriggerServerEvent("vendaresidencia-vender","tabletroubado")
	elseif data == "utilidades-vender-vibradorroubado" then
		TriggerServerEvent("vendaresidencia-vender","vibradorroubado")
	elseif data == "utilidades-vender-carteiraroubada" then
		TriggerServerEvent("vendaresidencia-vender","carteiraroubada")
	elseif data == "utilidades-vender-perfumeroubado" then
		TriggerServerEvent("vendaresidencia-vender","perfumeroubado")
	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local marcacoes = {
	{ 708.59,-963.45,30.4 },
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
						DrawText3Ds(x,y,z+0.20,"~r~[E] ~w~Para vender itens roubados")
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