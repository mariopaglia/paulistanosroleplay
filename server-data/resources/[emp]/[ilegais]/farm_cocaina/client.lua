local tempoEmSegundos = 10

local cokePalet = {
	{1391.8718261719,3605.8720703125,38.941921234131},
	{1389.3576660156,3604.77734375,38.941921234131},
}

local alreadyCut = {}

local packCoke = {
	{1389.68,3608.77,38.95}
}

local processarCoke = {
	{1394.57,3601.76,38.95}
}

local tempoEmMilssegundos = tempoEmSegundos*1000

local isProcessing = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		local pCoords = GetEntityCoords(GetPlayerPed(-1), false)
        for k,v in pairs(packCoke) do
            local x,y,z = table.unpack(v)
            local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, x, y, z, true)
			if distance < 1.0 then
				DisplayHelpText("Pressione ~INPUT_CONTEXT~ para Empacotar a Droga~w~")
				if (IsControlJustPressed(1, 38)) then
					TriggerServerEvent('cocaina:packDrug')
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		local pCoords = GetEntityCoords(GetPlayerPed(-1), false)
        for k,v in pairs(processarCoke) do
            local x,y,z = table.unpack(v)
            local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, x, y, z, true)
			if distance < 1.0 then
				DisplayHelpText("Pressione ~INPUT_CONTEXT~ para Processar a Droga~w~")
				if (IsControlJustPressed(1, 38)) then
					TriggerServerEvent('cocaina:processDrug')
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        for k,v in pairs(cokePalet) do
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
	                DrawText3d(x, y, z+1.5, "~w~PRESSIONE ~r~[E]~w~ PARA REFINAR COCAÍNA.", alpha)
	            	if (IsControlJustPressed(1, 38)) then 
	            		if alreadyCut[k] ~= nil then
	            			if GetTimeDifference(GetGameTimer(), alreadyCut[k]) > 60000 then
	            				alreadyCut[k] = GetGameTimer()
	                    		TriggerServerEvent('cocaina:getcokeOnPalet')
	            			end
	            		else
	            			alreadyCut[k] = GetGameTimer()
	                    	TriggerServerEvent('cocaina:getcokeOnPalet')
	            		end
	                end
	            elseif distance < 5.0 then
	                DrawText3d(x, y, z+1.5, "~w~FIQUE MAIS PRÓXIMO DA BANCADA.", alpha)
	            end
            end
        end
    end
end)

RegisterNetEvent("cocaina:getcokeOnPalet")
AddEventHandler("cocaina:getcokeOnPalet", function(tree)
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
	while (not HasAnimDictLoaded("anim@amb@business@coc@coc_unpack_cut_left@")) do 
		RequestAnimDict("anim@amb@business@coc@coc_unpack_cut_left@")
		Citizen.Wait(5)
	end
	TaskPlayAnim(GetPlayerPed(-1), "anim@amb@business@coc@coc_unpack_cut_left@", "coke_cut_coccutter", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
	FreezeEntityPosition(GetPlayerPed(-1),true)
    Citizen.Wait(10000)
    FreezeEntityPosition(GetPlayerPed(-1),false)
    ClearPedTasksImmediately(GetPlayerPed(-1))
    TriggerServerEvent('cocaina:getcokeItem')
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