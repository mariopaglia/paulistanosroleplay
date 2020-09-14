local tempoEmSegundos = 40
local tempoEmSegundos2 = 25

local KevlarPalet = {
	{-1109.8768310547,4948.9194335938,218.64979553223},
	{-1108.7319335938,4952.212890625,218.64979553223},
}

local alreadyCut2 = {}

local packKevlar = {
	{104.83568572998,-1302.4976806641,28.768793106079}
}

local tempoEmMilssegundos2= tempoEmSegundos2*1000

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
		local pCoords = GetEntityCoords(GetPlayerPed(-1), false)
        for k,v in pairs(packKevlar) do
            local x,y,z = table.unpack(v)
            local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, x, y, z, true)
			if distance < 0.5 then
				DisplayHelpText("Pressione ~INPUT_CONTEXT~ para fabricar colete~w~")
				if (IsControlJustPressed(1, 38)) then
					TriggerServerEvent('farm_colete:createArmor')
				end
			end
		end
        for k,v in pairs(KevlarPalet) do
            local x,y,z = table.unpack(v)
            z = z-1
            local pCoords = GetEntityCoords(GetPlayerPed(-1))
            local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, x, y, z, true)
            local alpha = math.floor(255 - (distance * 30))
            if alreadyCut2[k] ~= nil then
            	local timeDiff = GetTimeDifference(GetGameTimer(), alreadyCut2[k])
            	if timeDiff < tempoEmMilssegundos2 then
            		if distance < 5.0 then
		                local seconds = math.ceil(tempoEmSegundos2 - timeDiff/1000)
		                DrawText3d(x, y, z+1.5, "~w~AGUARDE ~r~"..tostring(seconds).."~w~ SEGUNDOS\nA MÁQUINA ESTÁ PROCESSANDO.", alpha)
		            end
            	else
            		alreadyCut2[k] = nil
            	end
            else
	            if distance <= 1.1 then
	                DrawText3d(x, y, z+1.5, "~c~PRESSIONE ~r~[E]~c~ PARA RECOLHER KEVLAR.", alpha)
	            	if (IsControlJustPressed(1, 38)) then
	            		if alreadyCut2[k] ~= nil then
	            			if GetTimeDifference(GetGameTimer(), alreadyCut2[k]) > 60000 then
	            				alreadyCut2[k] = GetGameTimer()
	                    		TriggerServerEvent('farm_colete:getKevlarOnPalet')
	            			end
	            		else
	            			alreadyCut2[k] = GetGameTimer()
	                    	TriggerServerEvent('farm_colete:getKevlarOnPalet')
	            		end
	                end
	            elseif distance < 5.0 then
	                DrawText3d(x, y, z+1.5, "~c~FIQUE MAIS PRÓXIMO DA MÁQUINA.", alpha)
	            end
            end
        end
    end
end)

RegisterNetEvent("farm_colete:getKevlarOnPalet")
AddEventHandler("farm_colete:getKevlarOnPalet", function(tree2)
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
	while (not HasAnimDictLoaded("mp_common")) do 
		RequestAnimDict("mp_common")
		Citizen.Wait(5)
	end
	TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_PARKING_METER", 0, true)
	FreezeEntityPosition(GetPlayerPed(-1),true)
    Citizen.Wait(3000)
    FreezeEntityPosition(GetPlayerPed(-1),false)
    ClearPedTasksImmediately(GetPlayerPed(-1))
    TriggerServerEvent('farm_colete:getKevlarItem')
end)

function DrawText3d(x,y,z, text, alpha)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    if onScreen then
        SetTextScale(0.5, 0.5)
        SetTextFont(6)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, alpha)
        SetTextDropshadow(0, 0, 0, 0, alpha)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        SetDrawOrigin(x,y,z, 0)
        DrawText(0.0, 0.0)
        ClearDrawOrigin()
    end
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end