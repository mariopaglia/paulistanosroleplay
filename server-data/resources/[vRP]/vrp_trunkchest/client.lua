local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPNserver = Tunnel.getInterface("vrp_trunkchest")
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
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	invOpen = false
	cbb = false
	vRPNserver.chestClose()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN TRUNK CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("trunkchest:Open")
AddEventHandler("trunkchest:Open",function()
	if not invOpen then
		StartScreenEffect("MenuMGSelectionIn", 0, true)
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "showMenu" })
		invOpen = true
	else
		invOpen = false
		TriggerEvent("Notify","negado","Tente novamente.",4000)
	end
end)
RegisterKeyMapping('vrp_trunkchest:open', 'Abrir Portamalas', 'keyboard', 'PAGEUP')

RegisterCommand('vrp_trunkchest:open', function()
	if not IsPedBeingStunned(ped) and not IsPlayerFreeAiming(PlayerId()) and GetEntityHealth(PlayerPedId()) > 101 then
		local r = vRPNserver.chestOpen()
		if not r then
			TriggerEvent("Notify","negado","Falha ao abrir inventário.",4000)
		end
	end
end, false)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("takeItem",function(data)
	if not cbb then
		cbb = true
		vRPNserver.takeItem(data.item,data.amount)
		cbb = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("storeItem",function(data)
	if not cbb then
		cbb = true
		vRPNserver.storeItem(data.item,data.amount)
		cbb = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTMOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestMochila",function(data,cb)
	local inventario,inventario2,peso,maxpeso,peso2,maxpeso2 = vRPNserver.Mochila()
	if inventario then
		cb({ inventario = inventario, inventario2 = inventario2, peso = peso, maxpeso = maxpeso, peso2 = peso2, maxpeso2 = maxpeso2 })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTO-UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Creative:UpdateTrunk")
AddEventHandler("Creative:UpdateTrunk",function(action)
	SendNUIMessage({ action = action })
end)