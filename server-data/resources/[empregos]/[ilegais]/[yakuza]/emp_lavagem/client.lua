local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
lav = Tunnel.getInterface("emp_lavagem",lav)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS --
-----------------------------------------------------------------------------------------------------------------------------------------
local andamento = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALIZAÇÃO DAS LAVAGENS DE DINHEIRO --
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ ['id'] = 1 , ['x'] = 16.47, ['y'] = -1399.62, ['z'] = 28.75, ['h'] = 95.45 },
	--{ ['id'] = 2 , ['x'] = -80.72, ['y'] = -801.65, ['z'] = 243.40, ['h'] = 250.23 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROCESSO
---------------------------------------------wd--------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for _,v in pairs(locais) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			if distance <= 1.2 and not andamento then
				drawTxt("PRESSIONE  ~r~E~w~  PARA INICIAR A INVASÃO AO SISTEMA DO BANCO",4,0.5,0.93,0.50,255,255,255,180)
				if IsControlJustPressed(0,38) and lav.checkpermission() and lav.checkDinheiro() and not IsPedInAnyVehicle(ped) then
					lav.lavagemPolicia(v.id,v.x,v.y,v.z,v.h)
					lav.webhookmafia ()
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIANDO LAVAGEM DE DINHEIRO --
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("iniciandolavagem1")
AddEventHandler("iniciandolavagem1",function(head,x,y,z)
	segundos = 10
	andamento = true
	SetEntityHeading(PlayerPedId(),head)
	SetEntityCoords(PlayerPedId(),x,y,z-1,false,false,false,false)
	SetCurrentPedWeapon(PlayerPedId(),GetHashKey("WEAPON_UNARMED"),true)
	TriggerEvent("progress",10000,"Lavando Dinheiro")
	TriggerEvent('cancelandolavagem',true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTAGEM --
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if andamento then
			segundos = segundos - 1
			if segundos <= 0 then
				andamento = false
				ClearPedTasks(PlayerPedId())
				TriggerEvent('cancelandolavagem',false)
				lav.checkPayment()
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES --
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end