local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
func = Tunnel.getInterface("vrp_teleport")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
local Teleport = {
	["DICI"] = { -- 1 AO 3 - DIC
		positionFrom = { ['x'] = 2498.61, ['y'] = -347.83, ['z'] = 94.1, ['perm'] = "dic.permissao" }, -- 1 to 3 -- 2498.61, -347.83, 94.1
		positionTo = { ['x'] = 2498.49, ['y'] = -347.98, ['z'] = 101.9, ['perm'] = "dic.permissao" },
	},
	["DICII"] = { -- 3 AO 4 DIC
	positionFrom = { ['x'] = 2496.15, ['y'] = -345.67, ['z'] = 101.9, ['perm'] = "dic.permissao" }, -- 3 to 4
	positionTo = { ['x'] = 2496.16, ['y'] = -345.61, ['z'] = 105.7, ['perm'] = "dic.permissao" },
	},
	["DICHELI"] = { -- HELIPONTO DIC
	positionFrom = { ['x'] = 2500.81, ['y'] = -341.18, ['z'] = 94.1, ['perm'] = "dic.permissao" }, -- 
	positionTo = { ['x'] = 2516.42, ['y'] = -342.6, ['z'] = 109.69, ['perm'] = "dic.permissao" },
	},
	["DICSUB"] = { -- SUBSOLO DIC
	positionFrom = { ['x'] = 2496.23, ['y'] = -345.63, ['z'] = 94.1, ['perm'] = "dic.permissao" }, -- 
	positionTo = { ['x'] = 2474.29, ['y'] = -371.92, ['z'] = 82.7, ['perm'] = "dic.permissao" },
	},
	["DICPREDIOUM"] = { -- 1 TO 4
	positionFrom = { ['x'] = 2505.71, ['y'] = -431.73, ['z'] = 99.12, ['perm'] = "dic.permissao" }, -- 
	positionTo = { ['x'] = 2505.64, ['y'] = -431.79, ['z'] = 106.92, ['perm'] = "dic.permissao" },
	},
	["PMHELI"] = { -- DP VINEWOOD
	positionFrom = { ['x'] = 616.38, ['y'] = -1.62, ['z'] = 82.79, ['perm'] = "policia.permissao" }, -- 
	positionTo = { ['x'] = 565.68, ['y'] = 4.89, ['z'] = 103.24, ['perm'] = "policia.permissao" },
	},
	["VANILLA"] = {
	positionFrom = { ['x'] = 133.16, ['y'] = -1293.63, ['z'] = 29.27, ['perm'] = "vanilla.permissao" }, -- 
	positionTo = { ['x'] = 132.65, ['y'] = -1287.28, ['z'] = 29.28, ['perm'] = "vanilla.permissao" },
	},
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

			if distance <= 3 then
				DrawText3Ds(v.positionTo.x,v.positionTo.y,v.positionTo.z+0.10,"~w~[~o~E~w~] ~w~Para Acessar o Elevador")
				DrawText3Ds(v.positionFrom.x,v.positionFrom.y,v.positionFrom.z+0.10,"~w~[~o~E~w~] ~w~Para Acessar o Elevador")
				DrawMarker(20,v.positionFrom.x,v.positionFrom.y,v.positionFrom.z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,104,0,100,0,0,0,1)
				if distance <= 1.5 then
					if IsControlJustPressed(0,38) and func.checkPermission(v.positionTo.perm) then
						SetEntityCoords(PlayerPedId(),v.positionTo.x,v.positionTo.y,v.positionTo.z-0.50)
					end
				end
			end

			if distance2 <= 3 then
				DrawText3Ds(v.positionTo.x,v.positionTo.y,v.positionTo.z+0.10,"~w~[~o~E~w~] ~w~Para Acessar o Elevador")
				DrawText3Ds(v.positionFrom.x,v.positionFrom.y,v.positionFrom.z+0.10,"~w~[~o~E~w~] ~w~Para Acessar o Elevador")
				DrawMarker(20,v.positionTo.x,v.positionTo.y,v.positionTo.z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,104,0,100,0,0,0,1)
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

function DrawText3Ds(x,y,z,text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.34, 0.34)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.001+ factor, 0.028, 0, 0, 0, 78)
end