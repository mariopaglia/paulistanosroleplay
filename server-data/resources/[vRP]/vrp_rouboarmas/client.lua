local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
func = Tunnel.getInterface("vrp_rouboarmas")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local andamento = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO LOCAL DO ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ ['id'] = 1, ['x'] = 1693.2, ['y'] = 3761.95, ['z'] = 34.71, ['h'] = 222.92 },
	{ ['id'] = 2, ['x'] = 253.35, ['y'] = -51.75, ['z'] = 69.95, ['h'] = 65.11 },
	{ ['id'] = 3, ['x'] = 841.07, ['y'] = -1035.25, ['z'] = 28.2, ['h'] = 354.03 },
	{ ['id'] = 4, ['x'] = -330.67, ['y'] = 6085.86, ['z'] = 31.46, ['h'] = 220.35 },
	{ ['id'] = 5, ['x'] = -660.89, ['y'] = -933.55, ['z'] = 21.83, ['h'] = 174.29 },
	{ ['id'] = 6, ['x'] = -1304.46, ['y'] = -395.84, ['z'] = 36.7, ['h'] = 72.15 },
	{ ['id'] = 7, ['x'] = -1117.98, ['y'] = 2700.6, ['z'] = 18.56, ['h'] = 214.98 },
	{ ['id'] = 8, ['x'] = 2566.61, ['y'] = 292.54, ['z'] = 108.74, ['h'] = 358.6 },
	{ ['id'] = 9, ['x'] = -3172.95, ['y'] = 1089.63, ['z'] = 20.84, ['h'] = 241.1 },
	{ ['id'] = 10, ['x'] = 23.76, ['y'] = -1105.97, ['z'] = 29.8, ['h'] = 158.8 },
	{ ['id'] = 11, ['x'] = 808.89, ['y'] = -2159.06, ['z'] = 29.62, ['h'] = 352.33 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTEIRO DO ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local ped = PlayerPedId()
		local x,y,z = GetEntityCoords(ped)
		if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") and not IsPedInAnyVehicle(ped) then
			for k,v in pairs(locais) do
				if Vdist(v.x,v.y,v.z,x,y,z) <= 1 and not andamento then
				 drawTxt("PRESSIONE  ~r~G~w~  PARA INICIAR O ROUBO",4,0.5,0.93,0.50,255,255,255,180)
				 DrawMarker(21,v.x,v.y,v.z-0.3,0,0,0,0,180.0,130.0,0.6,0.8,0.5,255,0,0,50,1,0,0,1)
				 if IsControlJustPressed(0,47) and func.checkPermission() then
					func.checkRobbery(v.id,v.x,v.y,v.z,v.h)
				end
			end
		end
	end
end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIANDO O ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("iniciandolojadearmas")
AddEventHandler("iniciandolojadearmas",function(head,x,y,z)
	segundos = 10
	andamento = true
	TriggerEvent("progress",10000,"roubando")
	SetEntityHeading(PlayerPedId(),head)
	SetEntityCoords(PlayerPedId(),x,y,z-1,false,false,false,false)
	TriggerEvent('cancelando',true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if andamento then
			segundos = segundos - 1
			if segundos <= 0 then
				andamento = false
				ClearPedTasks(PlayerPedId())
				TriggerEvent('cancelando',false)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
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