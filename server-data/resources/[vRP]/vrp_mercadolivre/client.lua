-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_mercadolivre",src)
vSERVER = Tunnel.getInterface("vrp_mercadolivre")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local mercadolivreOpen = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- mercadolivreLOCS
-----------------------------------------------------------------------------------------------------------------------------------------
local mercadolivrelocs = {
	{ 2747.5522460938,3472.9453125,55.671363830566 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN DEALER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(5)
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local x,y,z = table.unpack(GetEntityCoords(ped))
			for k,v in pairs(mercadolivrelocs) do
				local distance = Vdist(x,y,z,v[1],v[2],v[3])
				if distance <= 10.5 then
					DrawMarker(21,v[1],v[2],v[3]-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
					if distance <= 1.2 and IsControlJustPressed(0,38) and vSERVER.checkSearch() then
						SetNuiFocus(true,true)
						SendNUIMessage({ action = "showMenu" })
						mercadolivreOpen = true
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- mercadolivreCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("mercadolivreClose",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	mercadolivreOpen = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTmercadolivreLIST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestmercadolivreList",function(data,cb)
	local mercadolivrelist = vSERVER.mercadolivreList()
	if mercadolivrelist then
		cb({ mercadolivrelist = mercadolivrelist })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTINVLIST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestinvList",function(data,cb)
	local invlist = vSERVER.invList()
	if invlist then
		cb({ invlist = invlist })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- mercadolivreBUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("mercadolivreBuy",function(data)
	if data.id ~= nil then
		vSERVER.mercadolivreBuy(data.id,data.userid,data.price,data.qtd,data.itemid)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- mercadolivreSELL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("mercadolivreSell",function(data)
	if data.amount ~= nil then
		vSERVER.mercadolivreSell(data.amount,data.itemid,data.price,data.anony)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- mercadolivreEXTRACT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("mercadolivreExtract",function(data)
	if data.id ~= nil then
		vSERVER.mercadolivreExtract(data.id,data.userid,data.qtd,data.itemid)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTO-UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("mercadolivre:Update")
AddEventHandler("mercadolivre:Update",function(action)
	SendNUIMessage({ action = action })
end)