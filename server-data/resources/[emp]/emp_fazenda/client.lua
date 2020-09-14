local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("emp_fazenda")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local servico = false
local selecionado = 1
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = 285.1, ['y'] = 6480.97, ['z'] = 29.93 }, 
	[2] = { ['x'] = 285.45, ['y'] = 6477.04, ['z'] = 30.04 }, 
	[3] = { ['x'] = 285.65, ['y'] = 6474.83, ['z'] = 30.13 }, 
	[4] = { ['x'] = 285.0, ['y'] = 6469.01, ['z'] = 30.45 }, 
	[5] = { ['x'] = 282.36, ['y'] = 6466.75, ['z'] = 30.61 }, 
	[6] = { ['x'] = 273.92, ['y'] = 6462.07, ['z'] = 31.07 }, 
	[7] = { ['x'] = 267.04, ['y'] = 6455.45, ['z'] = 31.42 }, 
	[8] = { ['x'] = 258.86, ['y'] = 6448.83, ['z'] = 31.57 },
}
local plantas = {
	[1] = { ['x'] = 285.17, ['y'] = 6480.2, ['z'] = 30.12 }, 
	[2] = { ['x'] = 285.56, ['y'] = 6475.88, ['z'] = 30.33 }, 
	[3] = { ['x'] = 285.73, ['y'] = 6473.94, ['z'] = 30.33 }, 
	[4] = { ['x'] = 284.93, ['y'] = 6467.98, ['z'] = 30.7 }, 
	[5] = { ['x'] = 282.57, ['y'] = 6465.82, ['z'] = 30.88 }, 
	[6] = { ['x'] = 274.1, ['y'] = 6461.06, ['z'] = 31.29 }, 
	[7] = { ['x'] = 267.25, ['y'] = 6454.56, ['z'] = 31.59 },
	[8] = { ['x'] = 258.93, ['y'] = 6447.87, ['z'] = 31.73 }, 
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if not servico then
			local ped = PlayerPedId()
			local vehicle = GetPlayersLastVehicle()
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z,GetEntityCoords(ped),true)

			if distance <= 100.0 then
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-0.3,0,0,0,0,180.0,130.0,0.6,0.8,0.5,255,0,0,50,1,0,0,1)
				if distance <= 1.2 and IsControlJustPressed(0,38) and not IsPedInAnyVehicle(ped) and emP.checkWeight()  then
					TriggerEvent("progress",13000,"colhendo")
					servico = true
					TriggerEvent("cancelando",true)
					SetEntityCoords(ped,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
					vRP._CarregarObjeto("amb@world_human_gardener_plant@female@base","base_female","prop_cs_trowel",15,28422)
					planta = CreateObject(GetHashKey("prop_sapling_break_02"),plantas[selecionado].x,plantas[selecionado].y,plantas[selecionado].z-1.5,true,true,true)
					SetTimeout(13000,function()
						servico = false
						vRP._DeletarObjeto()
						vRP._stopAnim(false)
						TriggerEvent("cancelando",false)
						backentrega = selecionado
						DeleteObject(planta)
						while true do
							if backentrega == selecionado then
								selecionado = math.random(#locs)
							else
								break
							end
							Citizen.Wait(10)
						end
						emP.checkPayment()
					end)
				end
			end
		end
	end
	
end)