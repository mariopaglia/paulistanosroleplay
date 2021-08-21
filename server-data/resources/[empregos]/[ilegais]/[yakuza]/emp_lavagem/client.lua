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
	{ ['x'] = -60.23, ['y'] = -2517.92, ['z'] = 7.41, ['h'] = 324.29 },
	{ ['x'] = -51.88, ['y'] = -2523.56, ['z'] = 7.41, ['h'] = 238.98 },
	{ ['x'] = -55.27, ['y'] = -2520.68, ['z'] = 7.41, ['h'] = 320.47 },
	{ ['x'] = 725.73, ['y'] = -1070.74, ['z'] = 28.32, ['h'] = 88.43 },
	{ ['x'] = 727.77, ['y'] = -1066.82, ['z'] = 28.32, ['h'] = 269.59 },
	{ ['x'] = 725.54, ['y'] = -1068.42, ['z'] = 28.32, ['h'] = 87.59 },
	{ ['x'] = 2328.25, ['y'] = 2570.01, ['z'] = 46.68, ['h'] = 337.04 },
	{ ['x'] = 2329.8, ['y'] = 2570.21, ['z'] = 46.72, ['h'] = 69.74 },
	{ ['x'] = 2329.04, ['y'] = 2571.81, ['z'] = 46.68, ['h'] = 170.18 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROCESSO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		for _,v in pairs(locais) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			if distance <= 1.2 and not andamento then
				idle = 5
				drawTxt("PRESSIONE  ~r~E~w~  PARA INICIAR A INVASÃO AO SISTEMA DO BANCO",4,0.5,0.93,0.50,255,255,255,180)
				if IsControlJustPressed(0,38) and lav.checkpermission() and lav.checkDinheiro() and not IsPedInAnyVehicle(ped) then
					lav.lavagemPolicia(v.id,v.x,v.y,v.z,v.h)
					lav.webhookmafia ()
				end
			end
		end
		Citizen.Wait(idle)
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