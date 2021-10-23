-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
vRP = Proxy.getInterface("vRP")
vRPNserver = Tunnel.getInterface("cs_acoes")
-----------------------------------------------------------------------------------------------------------------------------------------


local onNui = false

function ToggleActionMenu()
    TriggerServerEvent('bolsa:saldo')
    TriggerServerEvent('banco:balance')
    local saldo, valor = vRPNserver.cs_acoes()
    SendNUIMessage({
		type = 'open',
        saldo = saldo,
        valor = valor,
	})
    onNui = not onNui
    if onNui then
        SetNuiFocus(true, true)
        SendNUIMessage({
            teste = true
        })
    else
        SetNuiFocus(false)
        SendNUIMessage({
            teste = false
        })
    end
end

RegisterNUICallback("fechar", function(data)
	 onNui = not onNui
    if onNui then
        SetNuiFocus(true, true)
        SendNUIMessage({
            teste = true
        })
    else
        SetNuiFocus(false)
        SendNUIMessage({
            teste = false
        })
    end
end)
------------------------------------------------------------------------------------------------
Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(10000)
        TriggerServerEvent('bolsa:upd')
        TriggerServerEvent('bolsa:saldo')
        local saldo, valor = vRPNserver.cs_acoes()
        SendNUIMessage({
            type = 'open',
            saldo = saldo,
            valor = valor,
        })
	end
end)

---------------------------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("comprar", function(data)
    TriggerServerEvent('bolsa:comprar')
end)

RegisterNUICallback("vender", function(data)
    TriggerServerEvent('bolsa:vender')
end)

RegisterNUICallback('balance', function()
	TriggerServerEvent('banco:balance')
end)

----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local marcacoes = {
    { -1055.4410400391,-242.73344421387,44.021068572998 },
    { -1057.6273193359,-244.26225280762,44.021064758301 },
    { -1058.2937011719,-243.11502075195,44.021018981934 },
    { -1059.6798095703,-248.22200012207,44.021068572998 },
    { -1056.1740722656,-245.43243408203,44.021068572998 },  
    { -1051.3543701172,-240.80767822266,44.112758636475 } 
}

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(5)
		for _,mark in pairs(marcacoes) do
			local x,y,z = table.unpack(mark)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
			if distance <= 4.0 then
				DrawMarker(21,x,y,z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,0,0,255,50,0,0,0,1)
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
				end
			end
		end
	end
end)