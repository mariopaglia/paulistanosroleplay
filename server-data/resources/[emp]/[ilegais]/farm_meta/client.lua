local tempoEmSegundos = 10

local MetaPalet = {
	{1493.2894287109,6390.2705078125,21.257806777954}
}

local alreadyCut = {}

local packMeta = {
	{1503.13,6393.59,20.79}
}

local processMeta = {
	{1494.72,6395.48,20.79}
}

local tempoEmMilssegundos = tempoEmSegundos*1000

local isProcessing = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		local pCoords = GetEntityCoords(GetPlayerPed(-1), false)
        for k,v in pairs(packMeta) do
            local x,y,z = table.unpack(v)
            local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, x, y, z, true)
			if distance < 1.0 then
				DisplayHelpText("Pressione ~INPUT_CONTEXT~ para empacotar a droga~w~")
				if (IsControlJustPressed(1, 38)) then
					TriggerServerEvent('damn_methfarm:packDrug')
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		local pCoords = GetEntityCoords(GetPlayerPed(-1), false)
        for k,v in pairs(processMeta) do
            local x,y,z = table.unpack(v)
            local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, x, y, z, true)
			if distance < 1.0 then
				DisplayHelpText("Pressione ~INPUT_CONTEXT~ para processar a droga~w~")
				if (IsControlJustPressed(1, 38)) then
					TriggerServerEvent('damn_methfarm:processDrug')
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        for k,v in pairs(MetaPalet) do
            local x,y,z = table.unpack(v)
            z = z-1
            local pCoords = GetEntityCoords(GetPlayerPed(-1))
            local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, x, y, z, true)
            local alpha = math.floor(255 - (distance * 30))
            if alreadyCut[k] ~= nil then
            	local timeDiff = GetTimeDifference(GetGameTimer(), alreadyCut[k])
            	if timeDiff < tempoEmMilssegundos then
            		if distance < 5.0 then
		                local seconds = math.ceil(tempoEmSegundos - timeDiff/1000)
		                DrawText3d(x, y, z+1.5, "~w~AGUARDE ~r~"..tostring(seconds).."~w~ SEGUNDOS.", alpha)
		            end
            	else
            		alreadyCut[k] = nil
            	end
            else
	            if distance < 1.5 then
	                DrawText3d(x, y, z+1.5, "~w~PRESSIONE ~r~[E]~w~ PARA RECOLHER META.", alpha)
	            	if (IsControlJustPressed(1, 38)) then
	            		if alreadyCut[k] ~= nil then
	            			if GetTimeDifference(GetGameTimer(), alreadyCut[k]) > 60000 then
	            				alreadyCut[k] = GetGameTimer()
	                    		TriggerServerEvent('damn_methfarm:getMetaOnPalet')
	            			end
	            		else
	            			alreadyCut[k] = GetGameTimer()
	                    	TriggerServerEvent('damn_methfarm:getMetaOnPalet')
	            		end
	                end
	            elseif distance < 5.0 then
	                DrawText3d(x, y, z+1.5, "~w~FIQUE MAIS PRÓXIMO DA MÁQUINA.", alpha)
	            end
            end
        end
    end
end)

RegisterNetEvent("damn_methfarm:getMetaOnPalet")
AddEventHandler("damn_methfarm:getMetaOnPalet", function(tree)
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
	while (not HasAnimDictLoaded("mp_common")) do 
		RequestAnimDict("mp_common")
		Citizen.Wait(5)
	end
	TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_PARKING_METER", 0, true)
	FreezeEntityPosition(GetPlayerPed(-1),true)
    Citizen.Wait(10000)
    FreezeEntityPosition(GetPlayerPed(-1),false)
    ClearPedTasksImmediately(GetPlayerPed(-1))
    TriggerServerEvent('damn_methfarm:getMetaItem')
end)

function DrawText3d(x,y,z, text, alpha)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    if onScreen then
        SetTextScale(0.5, 0.5)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, alpha)
        SetTextDropshadow(0, 0, 0, 0, alpha)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
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