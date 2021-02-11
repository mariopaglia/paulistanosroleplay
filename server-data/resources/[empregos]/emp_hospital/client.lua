local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("emp_hospital")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local macas = {
	{ ['x'] = 308.85, ['y'] = -581.63, ['z'] = 43.28, ['x2'] = 307.65, ['y2'] = -581.80, ['z2'] = 44.20, ['h'] = 165.0 },
	{ ['x'] = 312.19, ['y'] = -582.86, ['z'] = 43.28, ['x2'] = 310.91, ['y2'] = -583.00, ['z2'] = 44.20, ['h'] = 165.0 },
	{ ['x'] = 315.56, ['y'] = -584.12, ['z'] = 43.28, ['x2'] = 314.27, ['y2'] = -584.39, ['z2'] = 44.20, ['h'] = 165.0 },
	{ ['x'] = 318.67, ['y'] = -585.39, ['z'] = 43.28, ['x2'] = 317.62, ['y2'] = -585.63, ['z2'] = 44.20, ['h'] = 165.0 },
	{ ['x'] = 321.98, ['y'] = -586.34, ['z'] = 43.28, ['x2'] = 322.57, ['y2'] = -587.52, ['z2'] = 44.21, ['h'] = 165.0 },

	{ ['x'] = 322.95, ['y'] = -582.87, ['z'] = 43.28, ['x2'] = 324.18, ['y2'] = -582.53, ['z2'] = 44.20, ['h'] = 330.0 },
	{ ['x'] = 318.44, ['y'] = -580.72, ['z'] = 43.28, ['x2'] = 319.43, ['y2'] = -580.70, ['z2'] = 44.20, ['h'] = 330.0 },
	{ ['x'] = 314.77, ['y'] = -579.44, ['z'] = 43.28, ['x2'] = 313.94, ['y2'] = -578.66, ['z2'] = 44.20, ['h'] = 330.0 },
	{ ['x'] = 310.25, ['y'] = -577.99, ['z'] = 43.28, ['x2'] = 309.27, ['y2'] = -577.04, ['z2'] = 44.20, ['h'] = 330.0 },
	{ ['x'] = 336.3, ['y'] = -575.02, ['z'] = 43.29, ['x2'] = 336.96, ['y2'] = -575.41, ['z2'] = 44.19, ['h'] = 338.84 },
	{ ['x'] = 347.95, ['y'] = -579.34, ['z'] = 43.29, ['x2'] = 348.83, ['y2'] = -579.38, ['z2'] = 44.19, ['h'] = 329.66 },
	{ ['x'] = 359.89, ['y'] = -585.33, ['z'] = 43.29, ['x2'] = 359.62, ['y2'] = -586.22, ['z2'] = 44.21, ['h'] = 243.97 },
	{ ['x'] = 361.06, ['y'] = -582.07, ['z'] = 43.29, ['x2'] = 361.28, ['y2'] = -581.34, ['z2'] = 44.2, ['h'] = 243.42 },
	{ ['x'] = 354.21, ['y'] = -600.99, ['z'] = 43.29, ['x2'] = 354.38, ['y2'] = -600.29, ['z2'] = 44.22, ['h'] = 251.19 },
	{ ['x'] = 346.2, ['y'] = -591.18, ['z'] = 43.29, ['x2'] = 346.57, ['y2'] = -590.45, ['z2'] = 43.99, ['h'] = 254.14 },
	{ ['x'] = 358.44, ['y'] = -598.45, ['z'] = 43.29, ['x2'] = 357.68, ['y2'] = -597.92, ['z2'] = 43.99, ['h'] = 337.11 },
	{ ['x'] = 316.11, ['y'] = -566.63, ['z'] = 43.29, ['x2'] = 315.52, ['y2'] = -566.37, ['z2'] = 44.28, ['h'] = 327.24 },
	{ ['x'] = 320.37, ['y'] = -568.07, ['z'] = 43.29, ['x2'] = 321.11, ['y2'] = -568.57, ['z2'] = 44.26, ['h'] = 339.35 },
	{ ['x'] = 326.13, ['y'] = -570.67, ['z'] = 43.29, ['x2'] = 326.93, ['y2'] = -570.81, ['z2'] = 44.26, ['h'] = 340.87 },
	{ ['x'] = 366.1, ['y'] = -582.43, ['z'] = 43.29, ['x2'] = 366.45, ['y2'] = -581.62, ['z2'] = 44.22, ['h'] = 249.36 },
	{ ['x'] = 365.05, ['y'] = -584.86, ['z'] = 43.29, ['x2'] = 365.01, ['y2'] = -586.01, ['z2'] = 44.22, ['h'] = 249.29 },
	{ ['x'] = 363.98, ['y'] = -588.08, ['z'] = 43.29, ['x2'] = 363.73, ['y2'] = -589.14, ['z2'] = 44.22, ['h'] = 249.81 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEITANDO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		for k,v in pairs(macas) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			if distance <= 3.1 then
				idle = 5
				if distance <= 1.1 then
					drawTxt("~r~E~w~  DEITAR    ~r~G~w~  TRATAMENTO",4,0.5,0.88,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						SetEntityCoords(ped,v.x2,v.y2,v.z2)
						SetEntityHeading(ped,v.h)
						vRP._playAnim(false,{{"amb@world_human_sunbathe@female@back@idle_a","idle_a"}},true)
					end
					if IsControlJustPressed(0,47) then
						if emP.checkServices() then
							TriggerEvent('tratamento-macas')
							SetEntityCoords(ped,v.x2,v.y2,v.z2)
							SetEntityHeading(ped,v.h)
							vRP._playAnim(false,{{"amb@world_human_sunbathe@female@back@idle_a","idle_a"}},true)
						else
							TriggerEvent("Notify","importante","Existem paramédicos em serviço.")
						end
					end
				end
			end
		end
		Citizen.Wait(idle)
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

RegisterNetEvent('tratamento-macas')
AddEventHandler('tratamento-macas',function()
	TriggerEvent("cancelando",true)
	repeat
		SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId())+1)
		Citizen.Wait(2000)
	until GetEntityHealth(PlayerPedId()) >= 400 or GetEntityHealth(PlayerPedId()) <= 100
		TriggerEvent("Notify","importante","Tratamento concluido.")
		TriggerEvent("cancelando",false)
end)