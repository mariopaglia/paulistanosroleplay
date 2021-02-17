local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPNserver = Tunnel.getInterface("vrp_inventory")
vRPNclient = {}
Tunnel.bindInterface("vrp_inventory",vRPNclient)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local invOpen = false
local cbb = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function(data)
	StopScreenEffect("MenuMGSelectionIn")
	SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	invOpen = false
	cbb = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR INVENTARIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping('vrp_inventory:openInv', 'Inventário', 'keyboard', 'OEM_3')

RegisterCommand('vrp_inventory:openInv', function()
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and not vRP.isHandcuffed() and not IsPedBeingStunned(ped) and not IsPlayerFreeAiming(ped) then
		if not invOpen then
			StartScreenEffect("MenuMGSelectionIn", 0, true)
			invOpen = true
			SetNuiFocus(true,true)
			SendNUIMessage({ action = "showMenu" })
		else
			StopScreenEffect("MenuMGSelectionIn")
			SetNuiFocus(false,false)
			SendNUIMessage({ action = "hideMenu" })
			invOpen = false
		end
	end
end, false)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CLONEPLATES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('cloneplates')
AddEventHandler('cloneplates',function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)
    local clonada = GetVehicleNumberPlateText(vehicle)
    if IsEntityAVehicle(vehicle) then
        PlateIndex = GetVehicleNumberPlateText(vehicle)
        SetVehicleNumberPlateText(vehicle,"CLONADO")
        FreezeEntityPosition(vehicle,false)
        if clonada == CLONADA then 
            SetVehicleNumberPlateText(vehicle,PlateIndex)
            PlateIndex = nil
        end
    end
end)

function vRPNclient.ityrerepair(car)
	local wl = {"wheel_lf","wheel_rf","wheel_lm1","wheel_rm1","wheel_lr","wheel_rr"}
	local bone
	local d = 5
	for k, v in pairs(wl) do
		local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetWorldPositionOfEntityBone(car, GetEntityBoneIndexByName(car, v)))
		if dist < d then
			bone = k-1
			d = dist
		end
	end
	if d ~= 5 then
		return bone, VehToNet(car)
	else
		return -1
	end
end

function vRPNclient.syncTyreRepair(car, tyre)
	SetVehicleTyreFixed(NetToVeh(car), tyre)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEANCHOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('vehicleanchor')
AddEventHandler('vehicleanchor',function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)
    FreezeEntityPosition(vehicle,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR INVENTARIO
-----------------------------------------------------------------------------------------------------------------------------------------
--[[RegisterCommand("inv",function(source,args)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and not vRP.isHandcuffed() then
		SetCursorLocation(0.5,0.5)
		if not invOpen then
			SetNuiFocus(true,true)
			SendNUIMessage({ action = "showMenu" })
			invOpen = true
		else
			SetNuiFocus(false,false)
			SendNUIMessage({ action = "hideMenu" })
			invOpen = false
		end
	end
end)]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dropItem",function(data)
	if not cbb then
		cbb = true
		vRPNserver.dropItem(data.item,data.amount)
		cbb = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sendItem",function(data)
	if not cbb then
		cbb = true
		vRPNserver.sendItem(data.item,data.amount)
		cbb = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("useItem",function(data)
	if not cbb then
		cbb = true
		vRPNserver.useItem(data.item,data.type,data.amount)
		cbb = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestMochila",function(data,cb)
	local inventario,peso,maxpeso = vRPNserver.Mochila()
	if inventario then
		cb({ inventario = inventario, peso = peso, maxpeso = maxpeso })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTO-UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Creative:Update")
AddEventHandler("Creative:Update",function(action)
	SendNUIMessage({ action = action })
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÃO PARA CHECAR DISTANCIA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPNclient.isNearCds(cds, dist)
	return GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), cds) <= dist
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANDAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("bandagem")
AddEventHandler(
	"bandagem",
	function()
		-- local bandagem = 0
		repeat
			-- bandagem = bandagem + 1
			SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 1)
			Citizen.Wait(1000)
		until GetEntityHealth(PlayerPedId()) >= 250 or GetEntityHealth(PlayerPedId()) <= 100
		TriggerEvent("Notify", "sucesso", "Tratamento concluido, procure um médico para receber <b>tratamento completo</b>")
	end
)