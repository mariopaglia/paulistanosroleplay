local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
emP = Tunnel.getInterface("emp_desmanche")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local segundos = 0
local roubando = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
    -- DESMANCHES MIDNIGHT
    {['x'] = 2140.73, ['y'] = 4782.53, ['z'] = 40.98, ['perm'] = "midnight.permissao"}, -- 2140.73, 4782.53, 40.98
    {['x'] = -1173.9, ['y'] = -2062.62, ['z'] = 14.35, ['perm'] = "midnight.permissao"}, -- -1173.9, -2062.62, 14.35
    {['x'] = -441.55, ['y'] = 6342.22, ['z'] = 12.73, ['perm'] = "midnight.permissao"}, -- -441.55,6342.22,12.73
    --
    {['x'] = 1540.21, ['y'] = 6336.91, ['z'] = 24.08, ['perm'] = "driftking.permissao"}, -- 1540.21,6336.91,24.08
    {['x'] = 870.75, ['y'] = 2871.6, ['z'] = 56.91, ['perm'] = "driftking.permissao"}, -- 870.75,2871.6,56.91
    {['x'] = 132.41, ['y'] = -3210.44, ['z'] = 5.86, ['perm'] = "driftking.permissao"}, -- 132.41,-3210.44,5.86
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESMANCHE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local idle = 1000
        if not roubando then
            for _, v in pairs(locais) do
                local ped = PlayerPedId()
                local x, y, z = table.unpack(v)
                local distance = GetDistanceBetweenCoords(GetEntityCoords(ped), v.x, v.y, v.z)
                if distance <= 30 and GetPedInVehicleSeat(GetVehiclePedIsUsing(ped), -1) == ped then
                    idle = 5
                    DrawMarker(23, v.x, v.y, v.z - 0.96, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 0.5, 255, 0, 0, 50, 0, 0, 0, 0)
                    if distance <= 3.1 and IsControlJustPressed(0, 38) then
                        if emP.checkVehicle() and emP.checkPermission(v.perm) and emP.checkItem() then
                            roubando = true
                            segundos = 60
                            FreezeEntityPosition(GetVehiclePedIsUsing(ped), true)

                            repeat
                                Citizen.Wait(60)
                            until segundos == 0

                            TriggerServerEvent("desmancheVehicles")
                            roubando = false
                        end
                    end
                end
            end
        end
        Citizen.Wait(idle)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEXTO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local idle = 1000
        if roubando then
            idle = 5
            if segundos > 0 then
                DisableControlAction(0, 75)
                drawTxt("AGUARDE ~g~" .. segundos .. " SEGUNDOS~w~, ESTAMOS DESATIVANDO O ~y~RASTREADOR ~w~DO VEÍCULO", 4, 0.5, 0.93, 0.50, 255, 255, 255, 180)
            end
        end
        Citizen.Wait(idle)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIMINUINDO O TEMPO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if roubando then
            if segundos > 0 then
                segundos = segundos - 1
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text, font, x, y, scale, r, g, b, a)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end
