local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
emP = Tunnel.getInterface("emp_desmanche")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local segundos = 0
local roubando = false
local emrota = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
    -- DESMANCHES MIDNIGHT
    [1] = { 2140.73,4782.53,40.98 }, -- 2140.73, 4782.53, 40.98
    [2] = { -1173.9,-2062.62,14.35 }, -- -1173.9, -2062.62, 14.35
    [3] = { -441.55,6342.22,12.73 }, -- -441.55,6342.22,12.73
    [4] = { 1540.21,6336.91,24.08 }, -- 1540.21,6336.91,24.08
    [5] = { 870.75,2871.6,56.91 }, -- 870.75,2871.6,56.91
    [6] = { 132.41,-3210.44,5.86 }, -- 132.41,-3210.44,5.86
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIAR ROTA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("rotadesmanche")
AddEventHandler('rotadesmanche', function()
	if not emrota and not roubando then
		if emP.checkItem() then
			selecionada = math.random(#locais)
			CreateBlip(selecionada)
			emP.addGroup()
			TriggerEvent("Notify","importante","Rota iniciada com sucesso!", 5000)
		end
	else
		TriggerEvent("Notify","importante","Algo deu errado!", 5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRIAR BLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function CreateBlip(rota)
	emrota = true
	blip = AddBlipForCoord(locais[rota][1],locais[rota][2],locais[rota][3])
	SetBlipSprite(blip,162)
	SetBlipColour(blip,5)
	SetBlipScale(blip,0.4)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Desmanche")
	EndTextCommandSetBlipName(blip)
end
---------------------------------------------------------------------
-- CANCELAR A ROTA
---------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
    	local sleep = 1000
    	local ped = PlayerPedId()
        if emrota and not roubando then
            sleep = 5
    		if IsControlJustPressed(0,168) then
				TriggerEvent("Notify","importante","Você cancelou a rota!",5000)
				RemoveBlip(blip)
				emP.removeGroup()
				emrota = false
    		end	
    	end
        Citizen.Wait(sleep)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESMANCHE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		local ped = PlayerPedId()
		local coords = vector3(GetEntityCoords(ped))
		if emrota and not roubando then
			local distance = #(coords - vector3(locais[selecionada][1],locais[selecionada][2],locais[selecionada][3]))
			if distance <= 30 and GetPedInVehicleSeat(GetVehiclePedIsUsing(ped), -1) == ped then
				sleep = 5
				DrawMarker(23, locais[selecionada][1],locais[selecionada][2],locais[selecionada][3] - 0.96, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 0.5, 255, 0, 0, 50, 0, 0, 0, 0)
				if distance <= 3.1 and IsControlJustPressed(0,38) then
					if emP.checkVehicle() and emP.checkPermission() then
						RemoveBlip(blip)
						roubando = true
						segundos = 60
						FreezeEntityPosition(GetVehiclePedIsUsing(ped), true)
						repeat
							Citizen.Wait(60)
						until segundos == 0
						TriggerServerEvent("desmancheVehicles")
						roubando = false
						emrota = false
						SetTimeout(3000, function()
							emP.removeGroup()
						end)
					end
				end
			end
		end
		Citizen.Wait(sleep)
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