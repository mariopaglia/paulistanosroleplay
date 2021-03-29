local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")

vRP = Proxy.getInterface("vRP")
func = Tunnel.getInterface("vrp_concessionaria")

local open = false
local categoriaSelecionada = nil
local carroSelecionado = nil

local spawncds = {
    {['x'] = -47.52, ['y'] = -1093.53, ['z'] = 25.89, ['h'] = 70.36},
    {['x'] = -49.11, ['y'] = -1097.83, ['z'] = 25.89, ['h'] = 69.35},
    {['x'] = -40.91, ['y'] = -1098.43, ['z'] = 25.89, ['h'] = 69.24},
}

Citizen.CreateThread(function()
    SetNuiFocus(false, false)
    while true do

        local idle = 1000
        local distance = GetDistanceBetweenCoords(
                             GetEntityCoords(GetPlayerPed(-1)),
                            -55.36,-1093.73,26.43 - 0.97, true)

        if distance <= 20 then
            idle = 5
            --DrawMarker(21,v.x,v.y,v.z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
            DrawMarker(21, -55.36,-1093.73,26.43-0.5, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.4, 255, 0, 0, 100, 0, 0, 0, 1)
            -- DrawMarker(25,-55.36,-1093.73,26.43-0.99,0,0,0,0.0,0,0,3.0,3.0,0.4,255,0,0,80,0,0,0,1)
            if distance <= 3 then
                if not open then
                    if IsControlJustPressed(1, 38) then
                        open = true
                        SetNuiFocus(true, true)
                        SendNUIMessage({type = 'openGeneral'})
                    end
                end
            end
        end
        Citizen.Wait(5)
    end
end)
--[[
-- TIRAR CARRO
carros = {}
Citizen.CreateThread(function()
    SetNuiFocus(false, false)
    while true do
        Wait(5)
        local ped = PlayerPedId()
        local distance = GetDistanceBetweenCoords(GetEntityCoords(ped), -33.118488311768,-1090.1767578125,26.422292709351 - 0.97, true)

        if distance <= 100 then

            DrawMarker(23, -33.118488311768,-1090.1767578125,26.422292709351 - 0.97, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 0.5,
                       0, 95, 140, 80, 0, 0, 0, 0)

            if distance <= 2 then
                if not open then
                    if IsControlJustPressed(1, 38) and func.getPermissao() then
                        local name = func.getNomeVeiculo()
                        if name ~= "" then
                            if not carros[name] or carros[name] == nil then
                                local mhash = GetHashKey(name)

                                TriggerEvent("Notify", "aviso",
                                             "Buscando veículo!")

                                local tentativas = 0
                                while tentativas < 350 and
                                    not HasModelLoaded(mhash) do
                                    RequestModel(mhash)
                                    Citizen.Wait(10)
                                    tentativas = tentativas + 1
                                end
                                if not HasModelLoaded(mhash) then
                                    TriggerEvent("Notify", "negado",
                                                 "Veículo inválido!")

                                else
                                    local nveh =
                                        CreateVehicle(mhash,
                                                      GetEntityCoords(ped),
                                                      GetEntityHeading(ped),
                                                      true, false)

                                    local placa = vRP.getRegistrationNumber()
                                    SetVehicleOnGroundProperly(nveh)
                                    SetVehicleNumberPlateText(nveh, placa)
                                    SetEntityAsMissionEntity(nveh, true, false) -- Torna a entidade especificada (ped, veículo ou objeto) persistente. Entidades persistentes não serão removidas automaticamente pelo mecanismo.
                                    TaskWarpPedIntoVehicle(ped, nveh, -1)

                                    SetModelAsNoLongerNeeded(mhash)
                                    carros[name] = placa
                                end

                            else
                                TriggerEvent("Notify", "negado",
                                             "Veículo já foi retirado!")
                            end
                        end
                    end
                end
            end
        end

    end
end)
]]

RegisterNUICallback("CarregarDados", function(data, cb)
    SendNUIMessage({
        type = 'loadData',
        veiculos = json.encode(Config.Veiculos),
        meusVeiculos = func.getVeiculos(),
        totalTipo = func.getTotalVeiculorTipo(),
        aberto = func.abertoTodos(),
        isVendedor = func.getPermissao()
    })
end)

RegisterNUICallback("ButtonClick", function(data, cb)
    if data.action == "close" then
        open = false
        SetNuiFocus(false, false)
        SendNUIMessage({type = 'closeAll'})
    end

    if data.action == "confirmarCompra" then
        if func.comprarVeiculo(data.categoria, data.model) then
            SendNUIMessage({
                type = 'openGeneral',
                veiculos = json.encode(Config.Veiculos),
                meusVeiculos = func.getVeiculos(),
                totalTipo = func.getTotalVeiculorTipo(),
                aberto = Config.AbertoAll,
                isVendedor = func.getPermissao()
            })
        end
    end

    if data.action == "confirmarVenda" then
        if func.venderVeiculo(data.categoria, data.model) then
            SendNUIMessage({
                type = 'openGeneral',
                veiculos = json.encode(Config.Veiculos),
                meusVeiculos = func.getVeiculos(),
                totalTipo = func.getTotalVeiculorTipo(),
                aberto = Config.AbertoAll,
                isVendedor = func.getPermissao()
            })
        end
    end
	
	if data.action == "testdrive" then
		open = false
		SetNuiFocus(false, false)
		SendNUIMessage({type = 'closeAll'})
		SetFocusPosAndVel(-855.66, -3226.67, 13.53,0.0,0.0,0.0)
		if GetClosestVehicle(-855.66, -3226.67, 13.53,5.001,0,71) == 0 then
			ClearFocus()
			local pcoords = GetEntityCoords(PlayerPedId())
			vRP.blockSpawnSave()
			SetEntityCoords(PlayerPedId(), -855.66, -3226.67, 13.53)
			local veh = Config.Veiculos[data.categoria+1].veiculos[data.model+1]
			local mhash = GetHashKey(veh.model)
			while not HasModelLoaded(mhash) do
				RequestModel(mhash)
				Citizen.Wait(1)
			end

			local nveh = CreateVehicle(mhash,-855.66, -3226.67, 13.53+0.5,60.84,true,false)
			SetVehicleOnGroundProperly(nveh)
			SetVehicleEngineOn(nveh, 1, 1, 1)
			SetVehicleNumberPlateText(nveh,"SHOWROOM")
			SetEntityAsMissionEntity(nveh,true,true)
			SetVehRadioStation(nveh,"OFF")

			SetVehicleEngineHealth(nveh,1000.0)
			SetVehicleBodyHealth(nveh,100.0)
			SetVehicleFuelLevel(nveh,1000.0)
			SetVehicleDirtLevel(nveh,0.0)
			
			SetEntityInvincible(nveh, true)
			SetEntityLights(nveh, true)
			SetVehicleDoorsLockedForAllPlayers(nveh, false)
			TaskWarpPedIntoVehicle(PlayerPedId(),nveh,-1)
			SetModelAsNoLongerNeeded(mhash)
			Citizen.Wait(60000)
			Citizen.InvokeNative(0xAD738C3085FE7E11,nveh,true,true)
			SetEntityAsMissionEntity(nveh,true,true)
			SetVehicleHasBeenOwnedByPlayer(nveh,true)
			NetworkRequestControlOfEntity(nveh)
			Citizen.InvokeNative(0xEA386986E786A54F,Citizen.PointerValueIntInitialized(nveh))
			DeleteEntity(nveh)
			DeleteVehicle(nveh)
			SetEntityAsNoLongerNeeded(nveh)
			SetEntityCoords(PlayerPedId(), pcoords.x,pcoords.y,pcoords.z)
			vRP.blockSpawnSave()
		else
			TriggerEvent("Notify","importante","Pista Ocupada",3000)
		end
		ClearFocus()
	end
	
	if data.action == "visualizarCarro" then
		local sp = false;
		for k, v in pairs(spawncds) do
			if not sp then
				local checkPos = GetClosestVehicle(v.x,v.y,v.z,2.001,0,71)
				if checkPos == 0 then
					sp = k
				end
			end
		end
		if not sp then
			TriggerEvent("Notify","importante","Todas as vagas estão ocupadas no momento.",10000)
		else
			local car = Config.Veiculos[data.categoria+1].veiculos[data.model+1]
			local mhash = GetHashKey(car.model)
			while not HasModelLoaded(mhash) do
				RequestModel(mhash)
				Citizen.Wait(1)
			end

			local nveh = CreateVehicle(mhash,spawncds[sp].x,spawncds[sp].y,spawncds[sp].z+0.5,spawncds[sp].h,true,false)
			SetVehicleOnGroundProperly(nveh)
			SetVehicleEngineOn(nveh, 1, 1, 1)
			SetVehicleNumberPlateText(nveh,"SHOWROOM")
			SetEntityAsMissionEntity(nveh,true,true)
			SetVehRadioStation(nveh,"OFF")

			SetVehicleEngineHealth(nveh,1000.0)
			SetVehicleBodyHealth(nveh,100.0)
            SetVehicleFuelLevel(nveh,1000.0)
            SetVehicleDirtLevel(nveh,0.0)
            
			SetEntityInvincible(nveh, true)
			SetEntityLights(nveh, true)
			FreezeEntityPosition(nveh, true)
			SetVehicleDoorsLockedForAllPlayers(nveh, false)

			SetModelAsNoLongerNeeded(mhash)
		end
	end
end)

RegisterCommand("lm",function(source,args)
	local cars = func.registerCars("",1)
	for k, vs in pairs(cars) do
		local v = NetToVeh(vs)
		Citizen.InvokeNative(0xAD738C3085FE7E11,v,true,true)
		SetEntityAsMissionEntity(v,true,true)
		SetVehicleHasBeenOwnedByPlayer(v,true)
		NetworkRequestControlOfEntity(v)
		Citizen.InvokeNative(0xEA386986E786A54F,Citizen.PointerValueIntInitialized(v))
		DeleteEntity(v)
		DeleteVehicle(v)
		SetEntityAsNoLongerNeeded(v)
	end
end)

RegisterNetEvent('vrp_concessionaria:closeAll')
AddEventHandler('vrp_concessionaria:closeAll', function()
    open = false
    SetNuiFocus(false, false)
    SendNUIMessage({type = 'closeAll'})
end)

RegisterNetEvent("vrp_concessionaria:notify")
AddEventHandler('vrp_concessionaria:notify', function(title, msg, type)
    SendNUIMessage({type = 'alert', title = title, msg = msg, typeMsg = type})
end)
