local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
func = Tunnel.getInterface("vrp_trafico")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
local Teleport = {
	["PF"] = {
		positionFrom = { ['x'] = 456.02, ['y'] = -1103.85, ['z'] = 29.39, ['perm'] = "pfederal.permissao" },
		positionTo = { ['x'] = 478.31, ['y'] = -1100.96, ['z'] = 38.70, ['perm'] = "pfederal.permissao" },
	},
	
	["PF2"] = {
		positionFrom = { ['x'] = 416.81, ['y'] = -1084.26, ['z'] = 30.05, ['perm'] = "pfederal.permissao" },
		positionTo = { ['x'] = 466.73, ['y'] = -1097.81, ['z'] = 38.70, ['perm'] = "pfederal.permissao" },
	}
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for k,v in pairs(Teleport) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.positionFrom.x,v.positionFrom.y,v.positionFrom.z)
			local distance = GetDistanceBetweenCoords(v.positionFrom.x,v.positionFrom.y,cdz,x,y,z,true)
			local bowz,cdz2 = GetGroundZFor_3dCoord(v.positionTo.x,v.positionTo.y,v.positionTo.z)
			local distance2 = GetDistanceBetweenCoords(v.positionTo.x,v.positionTo.y,cdz2,x,y,z,true)

			if distance <= 10 then
				DrawMarker(1,v.positionFrom.x,v.positionFrom.y,v.positionFrom.z-1,0,0,0,0,0,0,1.0,1.0,1.0,255,255,255,50,0,0,0,0)
				if distance <= 1.5 then
					if IsControlJustPressed(0,38) and func.checkPermission(v.positionTo.perm) then
						SetEntityCoords(PlayerPedId(),v.positionTo.x,v.positionTo.y,v.positionTo.z-0.50)
					end
				end
			end

			if distance2 <= 10 then
				DrawMarker(1,v.positionTo.x,v.positionTo.y,v.positionTo.z-1,0,0,0,0,0,0,1.0,1.0,1.0,255,255,255,50,0,0,0,0)
				if distance2 <= 1.5 then
					if IsControlJustPressed(0,38) and func.checkPermission(v.positionFrom.perm) then
						SetEntityCoords(PlayerPedId(),v.positionFrom.x,v.positionFrom.y,v.positionFrom.z-0.50)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local processo = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ ['id'] = 1, ['x'] = -1859.01, ['y'] = 2056.83, ['z'] = 135.45, ['text'] = "JUNTAR AS PEÇAS", ['perm'] = "cn.permissao" }, -- CN Juntar
	{ ['id'] = 2, ['x'] = -1868.43, ['y'] = 2057.58, ['z'] = 135.43, ['text'] = "MONTAR MTAR-21 (5x)", ['perm'] = "cn.permissao" }, -- CN Montar MTAR-21
	{ ['id'] = 3, ['x'] = -1870.56, ['y'] = 2062.91, ['z'] = 135.52, ['text'] = "MONTAR AK-103 (7x)", ['perm'] = "cn.permissao" }, -- CN Montar AK-103
	{ ['id'] = 4, ['x'] = -1870.48, ['y'] = 2061.12, ['z'] = 135.43, ['text'] = "MONTAR THOMPSON (3x)", ['perm'] = "cn.permissao" }, -- CN Montar AK-103
	{ ['id'] = 5, ['x'] = -1870.28, ['y'] = 2058.53, ['z'] = 135.44, ['text'] = "MONTAR FN FIVE SEVEN (1x)", ['perm'] = "cn.permissao" }, -- CN Montar AK-103

	{ ['id'] = 6, ['x'] = -84.45, ['y'] = 996.16, ['z'] = 230.60, ['text'] = "JUNTAR AS PEÇAS", ['perm'] = "bratva.permissao" }, -- bratva Juntar
	{ ['id'] = 7, ['x'] = -84.45, ['y'] = 998.98, ['z'] = 230.60, ['text'] = "MONTAR MTAR-21 (5x)", ['perm'] = "bratva.permissao" }, -- bratva Montar MTAR-21
	{ ['id'] = 8, ['x'] = -85.80, ['y'] = 997.73, ['z'] = 230.60, ['text'] = "MONTAR AK-103 (7x)", ['perm'] = "bratva.permissao" }, -- bratva Montar AK-103
	{ ['id'] = 9, ['x'] = -78.00, ['y'] = 1003.09, ['z'] = 230.60, ['text'] = "MONTAR THOMPSON (3x)", ['perm'] = "bratva.permissao" }, -- bratva Montar AK-103
	{ ['id'] = 10, ['x'] = -80.27, ['y'] = 1003.41, ['z'] = 230.60, ['text'] = "MONTAR FN FIVE SEVEN (1x)", ['perm'] = "bratva.permissao" }, -- bratva Montar AK-103
--	{ ['id'] = , ['x'] = , ['y'] = , [	'z'] = , ['text'] = "TEXTO", ['perm'] = "SUAPERMISSAO" },

}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for k,v in pairs(locais) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			if distance <= 1.25 and not processo then
				drawTxt("PRESSIONE  ~r~E~w~  PARA "..v.text,4,0.5,0.93,0.50,255,255,255,180)
				DrawMarker(23, 865.92126464844,2168.958984375,52.286632537842-0.9701, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 3.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
				DrawMarker(23, 851.53741455078,2167.9020996094,52.280456542969-0.9701, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 3.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
				DrawMarker(23, 840.32495117188,2161.5939941406,52.306324005127-0.9701, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 3.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)

				DrawMarker(23, 1073.5093994141,-1988.2614746094,30.90592956543-0.9701, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 3.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
				DrawMarker(23, 1088.0223388672,-2001.6083984375,30.879922866821-0.9701, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 3.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
				DrawMarker(23, 1109.5931396484,-2008.220703125,31.050106048584-0.9701, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 3.0, 13, 232, 255, 155, 0, 0, 2, 0, 0, 0, 0)
				
				if IsControlJustPressed(0,38) and func.checkPermission(v.perm) then
					TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
					Citizen.Wait(10000)
					ClearPedTasksImmediately(PlayerPedId())

					if func.checkPayment(v.id) then
						processo = true
						TriggerEvent('cancelando',true)
						TriggerEvent("progress",0,"produzindo")
						SetTimeout(0,function()
							processo = false
							TriggerEvent('cancelando',false)
						end)
					end
				end
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