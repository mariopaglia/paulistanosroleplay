
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPrp = {}
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP")
Tunnel.bindInterface("vrp_skinshop", vRPrp)
Proxy.addInterface("vrp_skinshop", vRPrp)

local lojaderoupa = {
    { x = 428.47, y = -800.0, z = 29.5, provador = { x = 428.47, y = -800.0, z = 29.5, heading = 94.31 } },
    { x = 72.68, y = -1399.14, z = 29.38, provador = { x = 72.68, y = -1399.14, z = 29.38, heading = 271.47 } },
    { x = -829.11, y = -1074.34, z = 11.33, provador = { x = -829.11, y = -1074.34, z = 11.33, heading = 221.63 } },
    { x = -1188.31, y = -765.26, z = 17.32, provador = { x = -1188.31, y = -765.26, z = 17.32, heading = 138.23 } },
    { x = -158.81, y = -296.32, z = 39.74, provador = { x = -158.81, y = -296.32, z = 39.74, heading = 159.87 } },
    { x = 123.22, y = -228.6, z = 54.56, provador = { x = 123.22, y = -228.6, z = 54.56, heading = 340.62 } },
    { x = -708.15, y = -160.96, z = 37.42, provador = { x = -708.15, y = -160.96, z = 37.42, heading = 31.71 } },
    { x = -1457.34, y = -241.74, z = 49.81, provador = { x = -1457.34, y = -241.74, z = 49.81, heading = 317.52 } },
    { x = -3173.37, y = 1038.94, z = 20.87, provador = { x = -3173.37, y = 1038.94, z = 20.87, heading = 338.00 } },
    { x = -1107.87, y = 2708.42, z = 19.11, provador = { x = -1107.87, y = 2708.42, z = 19.11, heading = 229.84 } },
    { x = 614.55, y = 2768.46, z = 42.09, provador = { x = 614.55, y = 2768.46, z = 42.09, heading = 177.90 } },
    { x = 1190.47, y = 2712.88, z = 38.23, provador = { x = 1190.47, y = 2712.88, z = 38.23, heading = 182.06 } },
    { x = 1695.82, y = 4829.31, z = 42.07, provador = { x = 1695.82, y = 4829.31, z = 42.07, heading = 99.29 } },
    { x = 11.13, y = 6514.7, z = 31.88, provador = { x = 11.13, y = 6514.7, z = 31.88, heading = 48.03 } },
    { x=-1096.5, y=-834.64, z=14.29, provador = { x=-1096.5, y=-834.64, z=14.29, heading = 302.45 } },
    { x=297.53, y=-594.33, z=43.29, provador = { x=297.53, y=-594.33, z=43.29, heading = 156.37 } },
    { x=450.96, y=-992.0, z=30.69, provador = { x=450.96, y=-992.0, z=30.69, heading = 275.29 } },
    { x=1395.34, y=1148.85, z=114.34, provador = { x=1395.34, y=1148.85, z=114.34, heading = 266.09 } }, -- Cosanostra
    { x=-100.45, y=990.95, z=235.78, provador = { x=-100.45, y=990.95, z=235.78, heading = 26.46 } }, -- Bratva
    { x=1214.91, y=-165.34, z=75.26, provador = { x=1214.91, y=-165.34, z=75.26, heading = 323.92 } }, -- Verdes
    { x=-1636.56, y=-165.45, z=57.48, provador = { x=-1636.56, y=-165.45, z=57.48, heading = 301.6 } }, -- Vermelhos
    { x=1432.63, y=-2125.38, z=57.69, provador = { x=1432.63, y=-2125.38, z=57.69, heading = 21.55 } }, -- Roxos
    { x=-2619.59, y=1711.64, z=146.33, provador = { x=-2619.59, y=1711.64, z=146.33, heading = 209.35 } }, -- MidNight
    { x=419.52, y=-1482.34, z=33.81, provador = { x=419.52, y=-1482.34, z=33.81, heading = 210.69 } }, -- Salieri's
    { x=-620.1, y=-1618.3, z=33.02, provador = { x=-620.1, y=-1618.3, z=33.02, heading = 176.91 } }, -- Triade
    { x=575.56, y=-3126.25, z=18.77, provador = { x=575.56, y=-3126.25, z=18.77, heading = 92.72 } }, -- Irmandade
    { x=-1887.27, y=2070.12, z=145.58, provador = { x=-1887.27, y=2070.12, z=145.58, heading = 317.95 } }, -- Sinaloa
    { x=815.54, y=-2357.27, z=30.33, provador = { x=815.54, y=-2357.27, z=30.33, heading = 355.98 } }, -- DriftKing
    { x=105.65, y=-1302.94, z=28.77, provador = { x=105.65, y=-1302.94, z=28.77, heading = 299.78 } }, -- Vanilla
    { x=393.57, y=278.96, z=95.0, provador = { x=393.57, y=278.96, z=95.0, heading = 169.65 } }, -- Galaxy
    { x=-572.94, y=293.04, z=79.18, provador = { x=-572.94, y=293.04, z=79.18, heading = 223.19 } }, -- Tequila
    { x=-763.19, y=330.79, z=199.49, provador = { x=-763.19, y=330.79, z=199.49, heading = 181.19 } }, -- casa wally
    { x=-797.71, y=326.82, z=190.72, provador = { x=-797.71, y=326.82, z=190.72, heading = 4.0 } }, -- casa porcao
    { x=-163.97, y=905.69, z=220.22, provador = { x=-163.97, y=905.69, z=220.22, heading = 225.23 } }, -- casa porcao
    { x=-568.48, y=-115.12, z=33.88, provador = { x=-568.48, y=-115.12, z=33.88, heading = 24.78 } }, -- DP NOVA
    { x=-1535.56, y=123.37, z=50.06, provador = { x=-1535.56, y=123.37, z=50.06, heading = 276.93 } }, -- MANSAO PLAYBOY
    { x=4489.09, y=-4452.21, z=4.37, provador = { x=4489.09, y=-4452.21, z=4.37, heading = 198.51 } }, -- LOJA ILHA
    { x=-2584.42, y=1885.9, z=140.87, provador = { x=-2584.42, y=1885.9, z=140.87, heading = 189.69 } }, -- MANSAO MONTANHA
    { x=-56.41, y=-1289.5, z=30.91, provador = { x=-56.41, y=-1289.5, z=30.91, heading = 183.18 } }, -- ACADEMIA ['x'] = -56.41, ['y'] = -1289.5, ['z'] = 30.91, ['h'] = 183.18
    { x=-932.49, y=-177.13, z=46.29, provador = { x=-932.49, y=-177.13, z=46.29, heading = 28.19 } }, -- Fenix Plaza
    { x=2512.9, y=-344.37, z=101.9, provador = { x=2512.9, y=-344.37, z=101.9, heading = 318.13 } }, -- DIC 
    { x=835.7, y=-981.18, z=32.08, provador = { x=835.7, y=-981.18, z=32.08, heading = 181.46 } }, -- ROUPAS FÊNIX CUSTOMS 
    { x=-826.26, y=-1233.11, z=7.34, provador = { x=-826.26, y=-1233.11, z=7.34, heading = 140.44 } }, -- HOSPITAL NOVO (VICEROY)
    { x=-1105.71, y=-1640.51, z=4.65, provador = { x=-1105.71, y=-1640.51, z=4.65, heading = 64.08 } }, -- Laranjas
    { x=619.68, y=14.38, z=82.78, provador = { x=619.68, y=14.38, z=82.78, heading = 159.91 } }, -- DP Vinewood
}

local parts = {
    mascara = 1,
    mao = 3,
    calca = 4,
    mochila = 5,
    sapato = 6,
    gravata = 7,
    camisa = 8,
    colete = 9,
    jaqueta = 11,
    bone = "p0",
    oculos = "p1",
    brinco = "p2",
    relogio = "p6",
    bracelete = "p7"
}

local carroCompras = {
    mascara = false,
    mao = false,
    calca = false,
    mochila = false,
    sapato = false,
    gravata = false,
    camisa = false,
    colete = false,
    jaqueta = false,
    bone = false,
    oculos = false,
    brinco = false,
    relogio = false,
    bracelete = false
}

local old_custom = {}

local valor = 0
local precoTotal = 0

local in_loja = false
local atLoja = false

local chegou = false
local noProvador = false

local pos = nil
local camPos = nil
local cam = -1
local dataPart = 1
local texturaSelected = 0
local handsup = false

function SetCameraCoords()
    local ped = PlayerPedId()
	RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    
	if not DoesCamExist(cam) then
        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
		SetCamActive(cam, true)
        RenderScriptCams(true, true, 500, true, true)

        pos = GetEntityCoords(PlayerPedId())
        camPos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, 0.0)
        SetCamCoord(cam, camPos.x, camPos.y, camPos.z+0.75)
        PointCamAtCoord(cam, pos.x, pos.y, pos.z+0.15)
    end

end

function DeleteCam()
	SetCamActive(cam, false)
	RenderScriptCams(false, true, 0, true, true)
	cam = nil
end

RegisterNUICallback("changePart", function(data, cb)
    dataPart = parts[data.part]
    local ped = PlayerPedId()
    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        SendNUIMessage({
            changeCategory = true, 
            sexo = "Male", prefix = "M", 
            drawa = vRP.getDrawables(dataPart), category = dataPart 
        })
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then 
        SendNUIMessage({ 
            changeCategory = true, 
            sexo = "Female", prefix = "F", 
            drawa = vRP.getDrawables(dataPart), category = dataPart 
        })
    end
end)

Citizen.CreateThread(function()
    while true do
        local idle = 1000
        local ped = PlayerPedId()
        local playerCoords = GetEntityCoords(ped, true)
        
        for k, v in pairs(lojaderoupa) do
            local provador = lojaderoupa[k].provador

            if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, lojaderoupa[k].x, lojaderoupa[k].y, lojaderoupa[k].z, true ) <= 10 then
                idle = 5
                DrawMarker( 23, lojaderoupa[k].x, lojaderoupa[k].y, lojaderoupa[k].z-0.99, 0, 0, 0, 0, 0, 0, 1.7, 1.7, 0.5, 255, 0, 0, 50, 0, 0, 0, 0)
            end

            if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, lojaderoupa[k].x, lojaderoupa[k].y, lojaderoupa[k].z, true ) <= 2 and not noProvador then
                DrawText3D(lojaderoupa[k].x, lojaderoupa[k].y, lojaderoupa[k].z, "Pressione [~r~E~w~] para acessar a ~r~LOJA DE ROUPAS~w~")    
            end

            if GetDistanceBetweenCoords(GetEntityCoords(ped), lojaderoupa[k].x, lojaderoupa[k].y, lojaderoupa[k].z, true ) < 1 then
                if IsControlJustPressed(0, 38) then
                    valor = 0
                    precoTotal = 0
                    noProvador = true
                    old_custom = vRP.getCustomization()
                    old = {}
                    cor = 0
		            dados, tipo = nil
					if GetDistanceBetweenCoords(GetEntityCoords(ped), provador.x, provador.y, provador.z, true ) > 1 then
						TaskGoToCoordAnyMeans(ped, provador.x, provador.y, provador.z, 1.0, 0, 0, 786603, 0xbf800000)
					end
                end
            end

            if noProvador then
                if GetDistanceBetweenCoords(GetEntityCoords(ped), provador.x, provador.y, provador.z, true ) < 1.0 and not chegou then
                    chegou = true
                    valor = 0
                    precoTotal = 0
                    SetEntityHeading(PlayerPedId(), provador.heading)
                    FreezeEntityPosition(ped, true)
                    SetEntityInvincible(ped, false) -- MQCU
                    openGuiLojaRoupa()
                end
            end
        end
        Citizen.Wait(idle)
    end
end)

function openGuiLojaRoupa()
    local ped = PlayerPedId()
    SetNuiFocus(true, true)
    SetCameraCoords()
    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        SendNUIMessage({ 
            openLojaRoupa = true, 
            sexo = "Male", prefix = "M", 
            drawa = vRP.getDrawables(dataPart), category = dataPart 
        })
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then 
        SendNUIMessage({ 
            openLojaRoupa = true, 
            sexo = "Female", prefix = "F", 
            drawa = vRP.getDrawables(dataPart), category = dataPart 
        })
    end
    in_loja = true
end

RegisterNUICallback("leftHeading", function(data, cb)
    local currentHeading = GetEntityHeading(PlayerPedId())
    heading = currentHeading-tonumber(data.value)
    SetEntityHeading(PlayerPedId(), heading)
end)

RegisterNUICallback("handsUp", function(data, cb)
    local dict = "missminuteman_1ig_2"
    
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
    end
    
    if not handsup then
        TaskPlayAnim(PlayerPedId(), dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
        handsup = true
    else
        handsup = false
        ClearPedTasks(PlayerPedId())
    end
end)

RegisterNUICallback("rightHeading", function(data, cb)
    local currentHeading = GetEntityHeading(PlayerPedId())
    heading = currentHeading+tonumber(data.value)
    SetEntityHeading(PlayerPedId(), heading)
end)

function updateCarroCompras()
    valor = 0
    for k, v in pairs(carroCompras) do
        if carroCompras[k] == true then
            valor = valor + 100
        end
    end
    precoTotal = valor
    return valor
end

RegisterNUICallback("changeColor", function(data, cb)
    if type(dados) == "number" then
        max = GetNumberOfPedTextureVariations(PlayerPedId(), dados, tipo)
    elseif type(dados) == "string" then
        max = GetNumberOfPedPropTextureVariations(PlayerPedId(), parse_part(dados), tipo)
    end

    if data.action == "menos" then
        if cor > 0 then cor = cor - 1 else cor = max end
    elseif data.action == "mais" then
        if cor < max then cor = cor + 1 else cor = 0 end
    end
    if dados and tipo then setRoupa(dados, tipo, cor) end
end)

function changeClothe(type, id)
    dados = type
    tipo = tonumber(parseInt(id))
	cor = 0
    setRoupa(dados, tipo, cor)
end

function setRoupa(dados, tipo, cor)
    local ped = PlayerPedId()

	if type(dados) == "number" then
		SetPedComponentVariation(ped, dados, tipo, cor, 1)
    elseif type(dados) == "string" then
        SetPedPropIndex(ped, parse_part(dados), tipo, cor, 1)
        dados = "p" .. (parse_part(dados))
	end
	  
  	custom = vRP.getCustomization()
  	custom.modelhash = nil

	aux = old_custom[dados]
	v = custom[dados]

    if v[1] ~= aux[1] and old[dados] ~= "custom" then
        carroCompras[dados] = true
        price = updateCarroCompras()
        SendNUIMessage({ action = "setPrice", price = price, typeaction = "add" })
    	old[dados] = "custom"
    end
    if v[1] == aux[1] and old[dados] == "custom" then
        carroCompras[dados] = false
        price = updateCarroCompras()
        SendNUIMessage({ action = "setPrice", price = price, typeaction = "remove" })
    	old[dados] = "0"
	end

	SendNUIMessage({ value = price })
end

RegisterNUICallback("changeCustom", function(data, cb)
    changeClothe(data.type, data.id)
end)

RegisterNUICallback("payament", function(data, cb)
    carroCompras = {
        mascara = false,
        mao = false,
        calca = false,
        mochila = false,
        sapato = false,
        gravata = false,
        camisa = false,
        colete = false,
        jaqueta = false,
        bone = false,
        oculos = false,
        brinco = false,
        relogio = false,
        bracelete = false
    }
    TriggerServerEvent("vrp_skinshop:Comprar", tonumber(data.price)) 
end)

RegisterNUICallback("reset", function(data, cb)
    vRP.setCustomization(old_custom)
    async(function()
        Citizen.Wait(500)
	    TriggerEvent("reloadtattos")
    end)
    closeGuiLojaRoupa()
    ClearPedTasks(PlayerPedId())
end)

function closeGuiLojaRoupa()
    local ped = PlayerPedId()
    DeleteCam()
    SetNuiFocus(false, false)
    SendNUIMessage({ openLojaRoupa = false })
    FreezeEntityPosition(ped, false)
    SetEntityInvincible(ped, false)
    PlayerReturnInstancia()
    SendNUIMessage({ action = "setPrice", price = 0, typeaction = "remove" })
    
    in_loja = false
    noProvador = false
    chegou = false
    old_custom = {}
end

RegisterNetEvent('vrp_skinshop:ReceberCompra')
AddEventHandler('vrp_skinshop:ReceberCompra', function(comprar)
    if comprar then
        in_loja = false
        closeGuiLojaRoupa()
    else
        in_loja = false
        vRP.setCustomization(old_custom)
        async(function()
            Citizen.Wait(500)
            TriggerEvent("reloadtattos")
        end)
        closeGuiLojaRoupa()
    end
end)

function parse_part(key)
    if type(key) == "string" and string.sub(key, 1, 1) == "p" then
        return tonumber(string.sub(key, 2))
    else
        return false, tonumber(key)
    end
end

function PlayerInstancia()
    for _, player in ipairs(GetActivePlayers()) do
        local ped = PlayerPedId()
        local otherPlayer = GetPlayerPed(player)
        if ped ~= otherPlayer then
            SetEntityVisible(otherPlayer, false)
            SetEntityNoCollisionEntity(ped, otherPlayer, true)
        end
    end
end

function PlayerReturnInstancia()
    for _, player in ipairs(GetActivePlayers()) do
        local ped = PlayerPedId()
        local otherPlayer = GetPlayerPed(player)
        if ped ~= otherPlayer then
            SetEntityVisible(otherPlayer, true)
            SetEntityCollision(ped, true)
        end
    end
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end

Citizen.CreateThread(function()
    while true do
        local idle = 1000
        if noProvador then
            idle = 5
            PlayerInstancia()
            DisableControlAction(1, 1, true)
            DisableControlAction(1, 2, true)
            DisableControlAction(1, 24, true)
            DisablePlayerFiring(PlayerPedId(), true)
            DisableControlAction(1, 142, true)
            DisableControlAction(1, 106, true)
            DisableControlAction(1, 37, true)
        end
        Citizen.Wait(idle)
    end
end)

Citizen.CreateThread(function()
    while true do
        N_0xf4f2c0d4ee209e20()
        Citizen.Wait(1000)
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        closeGuiLojaRoupa()
    end
end)