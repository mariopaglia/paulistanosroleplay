--[[ FEITO POR UtinhaSz#3339 CASO QUEIRA SUPORTE , COMPRE ]]

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
tvsRP = {}
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vrp_academia","vRP")

local malhando = false
local exerciseon = {
     {-1200.0500488281,-1571.0577392578,4.6096024513245,h=211.15209960938},
     {-1204.7548828125,-1564.3947753906,4.6095118522644,h=31.65938949585},
	 
}

Citizen.CreateThread(function()
while true do 
    Citizen.Wait(1)
     for _,mark in pairs(exerciseon) do
        local x,y,z = table.unpack(mark)
            local aparelhos = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
        if not malhando and aparelhos < 1.0 then 
		    DrawText3D(x,y,z,"APERTE ~y~[E] ~w~ PARA MALHAR")
        if IsControlJustPressed(0, 46) then
                SetEntityHeading(PlayerPedId(),mark.h)
                SetEntityCoords(PlayerPedId(),x,y,z-1,false,false,false,false)
                vRP._playAnim(false,{"amb@prop_human_muscle_chin_ups@male@base","base"},true)
                TriggerEvent("Progress",15000)
                TriggerEvent("Notify","importante","Faça o exercicio por <b>15 segundos</b>",5000)
				malhando = true
                Wait(15000)
				malhando = false
                vRP._stopAnim(false)
                TriggerServerEvent('vrp_academia:exerciseGym2')
				end
			end 
		end
    end 
end)

Citizen.CreateThread(function()
while true do 
    Citizen.Wait(1)
	if not malhando then
       if (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -1198.6065673828,-1563.1163330078,4.6217041015625,true) <= 1.0) or (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -1196.6557617188,-1565.8605957031,4.6217637062073,true) <= 1.0) then 
                DrawText3D(-1198.6065673828,-1563.1163330078,4.6217041015625+0.9,"APERTE ~y~[E] ~w~ PARA MALHAR")
                DrawText3D(-1196.6557617188,-1565.8605957031,4.6217637062073+0.9,"APERTE ~y~[E] ~w~ PARA MALHAR")
            if IsControlJustPressed(0, 46) then 
                vRP.createObjects("amb@world_human_muscle_free_weights@male@barbell@base","base","prop_curl_bar_01",50,28422)
                TriggerEvent("Progress",15000)
                TriggerEvent("Notify","importante","Faça o exercicio por <b>15 segundos</b>",5000)
				malhando = true
                Wait(15000)
                vRP.removeObjects("two")
				malhando = false
                TriggerServerEvent('vrp_academia:exerciseGym2')
            end 
        end
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -1207.09,-1560.8,5.02,true) <= 1.0 then 
                DrawText3D(-1207.09,-1560.8,5.02+1,"APERTE ~y~[E] ~w~ PARA MALHAR")
            if IsControlJustPressed(0, 46) then 
                SetEntityHeading(PlayerPedId(),40.83)
                SetEntityCoords(PlayerPedId(),-1207.09,-1560.8,5.02-1,false,false,false,false)
                vRP._playAnim(false,{"amb@world_human_sit_ups@male@base","base"},true)
                TriggerEvent("Progress",15000)
                TriggerEvent("Notify","importante","Faça o exercicio por <b>15 segundos</b>",5000)
				malhando = true
                Wait(15000)
                vRP._stopAnim(false)
				malhando = false
                TriggerServerEvent('vrp_academia:exerciseGym2') 
			end
		end 
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),-1205.62,-1567.84,4.61,true) <= 1.0 then 
                DrawText3D(-1205.62,-1567.84,4.61-0.3,"APERTE ~y~[E] ~w~ PARA MALHAR")
            if IsControlJustPressed(0, 46) then 
                SetEntityHeading(PlayerPedId(),308.15)
                SetEntityCoords(PlayerPedId(),-1205.62,-1567.84,4.61-1,false,false,false,false)
                vRP._playAnim(false,{"amb@world_human_push_ups@male@base","base"},true)
                TriggerEvent("Progress",15000)
                TriggerEvent("Notify","importante","Faça o exercicio por <b>15 segundos</b>",5000)
				malhando = true
                Wait(15000)
                vRP._stopAnim(false)
				malhando = false
                TriggerServerEvent('vrp_academia:exerciseGym2') 
			end
		end 
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),-1207.32,-1565.84,4.61,true) <= 2.0 then 
                DrawText3D(-1207.32,-1565.84,4.61-0.3,"APERTE ~y~[E] ~w~ PARA MALHAR")
            if IsControlJustPressed(0, 46) then 
                SetEntityHeading(PlayerPedId(),306.57)
                SetEntityCoords(PlayerPedId(),-1207.32,-1565.84,4.61-1,false,false,false,false)
                vRP._playAnim(false,{"amb@world_human_jog_standing@male@fitidle_a","idle_a"},true)
                TriggerEvent("Progress",15000)
                TriggerEvent("Notify","importante","Faça o exercicio por <b>15 segundos</b>",5000)
				malhando = true
                Wait(15000)
                vRP._stopAnim(false)
				malhando = false
                TriggerServerEvent('vrp_academia:exerciseGym2') 
				end
			end
		end 
    end 
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end