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
	if data == "utilidades-comprar-roupas" then
		TriggerServerEvent("departamento-comprar","roupas")	
	elseif data == "utilidades-comprar-mochila" then
		TriggerServerEvent("departamento-comprar","mochila")
	elseif data == "utilidades-comprar-alianca" then
		TriggerServerEvent("departamento-comprar","alianca")	
	elseif data == "utilidades-comprar-alianca2" then
		TriggerServerEvent("departamento-comprar","alianca2")	
	elseif data == "bebidas-comprar-energetico" then
		TriggerServerEvent("departamento-comprar","energetico")
	elseif data == "utilidades-comprar-celular" then
		TriggerServerEvent("departamento-comprar","celular")
	elseif data == "utilidades-comprar-radio" then
		TriggerServerEvent("departamento-comprar","radio")
	elseif data == "utilidades-comprar-militec" then
		TriggerServerEvent("departamento-comprar","militec")
	elseif data == "utilidades-comprar-repairkit" then
		TriggerServerEvent("departamento-comprar","repairkit")
	elseif data == "utilidades-comprar-pneu" then
		TriggerServerEvent("departamento-comprar","pneu")
	elseif data == "utilidades-comprar-hamburguer" then
		TriggerServerEvent("departamento-comprar","hamburguer")
	elseif data == "utilidades-comprar-pizza" then
		TriggerServerEvent("departamento-comprar","pizza")
	elseif data == "utilidades-comprar-rosquinha" then
		TriggerServerEvent("departamento-comprar","rosquinha")
	elseif data == "utilidades-comprar-agua" then
		TriggerServerEvent("departamento-comprar","agua")
	elseif data == "utilidades-comprar-sprite" then
		TriggerServerEvent("departamento-comprar","sprite")
	elseif data == "utilidades-comprar-leite" then
		TriggerServerEvent("departamento-comprar","leite")
	elseif data == "utilidades-comprar-mamadeira" then
		TriggerServerEvent("departamento-comprar","mamadeira")
	elseif data == "utilidades-comprar-rosa" then
		TriggerServerEvent("departamento-comprar","rosa")
	elseif data == "utilidades-comprar-comidapet" then
		TriggerServerEvent("departamento-comprar","comidapet")

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local marcacoes = {
	{ 25.65,-1346.58,29.49 },
	{ 2556.75,382.01,108.62 },
	{ 1163.54,-323.04,69.20 },
	{ -707.37,-913.68,19.21 },
	{ -47.73,-1757.25,29.42 },
	{ 373.90,326.91,103.56 },
	{ -3243.10,1001.23,12.83 },
	{ 1729.38,6415.54,35.03 },
	{ 547.90,2670.36,42.15 },
	{ 1960.75,3741.33,32.34 },
	{ 2677.90,3280.88,55.24 },
	{ 1698.45,4924.15,42.06 },
	{ -1820.93,793.18,138.11 },
	{ 1392.46,3604.95,34.98 },
	{ -2967.82,390.93,15.04 },
	{ -3040.10,585.44,7.90 },
	{ 1135.56,-982.20,46.41 },
	{ 1165.91,2709.41,38.15 },
	{ -1487.18,-379.02,40.16 },
	--{ -816.12249755859,-194.64167785645,37.590026855469 },
	--{ -1095.4796142578,-2594.6533203125,13.925128936768 },
	{ -1222.78,-907.22,12.32 },
	{ 4467.48,-4464.91,4.25 }, -- LOJINHA ILHA
	{ 1108.63,209.5,-49.44 }, -- Casino
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
				if not menuactive then
					DrawText3Ds(x,y,z+0.20,"~r~[E] ~w~Para Acessar a Loja de Departamento")
				end
				TaylinSleep = 5
				if distance <= 2.0 then
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