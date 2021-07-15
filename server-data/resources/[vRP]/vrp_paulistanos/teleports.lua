local Teleport = {
	 ["HOSPITAL"] = {
		positionFrom = { ['x'] = 332.26, ['y'] = -595.56, ['z'] = 43.28 },
	 	positionTo = { ['x'] = 338.55, ['y'] = -583.83, ['z'] = 74.17 }
	},
	["HOSPITAL1"] = {
		positionFrom = { ['x'] = 359.51, ['y'] = -584.91, ['z'] = 28.82 },
		positionTo = { ['x'] = 330.39, ['y'] = -601.16, ['z'] = 43.29 }
	},
	["HOSPITAL2"] = {
		positionFrom = { ['x'] = 355.42, ['y'] = -596.26, ['z'] = 28.78 },
		positionTo = { ['x'] = 327.25, ['y'] = -603.84, ['z'] = 43.29 }
	},
	["TELEFERICO"] = {
		positionFrom = { ['x'] = -741.06, ['y'] = 5593.12, ['z'] = 41.65 },
		positionTo = { ['x'] = 446.15, ['y'] = 5571.72, ['z'] = 781.18 }
	},
	["TRIBUNAL"] = {
		positionFrom = { ['x'] = 232.34, ['y'] = -1095.12, ['z'] = 29.3 },
		positionTo = { ['x'] = 244.17, ['y'] = -344.3, ['z'] = -118.79 }
	},
	["VANILLA"] = {
		positionFrom = { ['x'] = 133.13, ['y'] = -1293.63, ['z'] = 29.27 },
		positionTo = { ['x'] = 132.43, ['y'] = -1287.46, ['z'] = 29.28 }
	},
	["CASSINO"] = {
		positionFrom = { ['x'] = 935.9, ['y'] = 47.03, ['z'] = 81.1 },
		positionTo = { ['x'] = 965.15, ['y'] = 58.66, ['z'] = 112.56 }
	},
	["BAHAMAS"] = {
		positionFrom = { ['x'] = -1386.28, ['y'] = -627.48, ['z'] = 30.82 },
		positionTo = { ['x'] = -1371.52, ['y'] = -626.05, ['z'] = 30.82 }
	},
	["DPNOVA"] = { -- HELIPONTO DP NOVA
		positionFrom = { ['x'] = -582.99, ['y'] = -146.34, ['z'] = 38.24 },
		positionTo = { ['x'] = -554.7, ['y'] = -187.23, ['z'] = 52.21 } 
	},
	["ACDBOXE"] = { -- ACADEMIA BOXE
        positionFrom = { ['x'] = -47.45, ['y'] = -1289.97, ['z'] = 29.59 },
        positionTo = { ['x'] = -45.39, ['y'] = -1289.97, ['z'] = 29.20 }
    },
}

Citizen.CreateThread(function()
	while true do
		local esperar = 1000
		for k,j in pairs(Teleport) do
			local px,py,pz = table.unpack(GetEntityCoords(PlayerPedId(),true))
			local unusedBool,coordz = GetGroundZFor_3dCoord(j.positionFrom.x,j.positionFrom.y,j.positionFrom.z,1)
			local unusedBool,coordz2 = GetGroundZFor_3dCoord(j.positionTo.x,j.positionTo.y,j.positionTo.z,1)
			local distance = GetDistanceBetweenCoords(j.positionFrom.x,j.positionFrom.y,coordz,px,py,pz,true)
			local distance2 = GetDistanceBetweenCoords(j.positionTo.x,j.positionTo.y,coordz2,px,py,pz,true)

			if distance <= 15 then
				esperar = 4
				-- DrawMarker(40,j.positionFrom.x,j.positionFrom.y,j.positionFrom.z-0.5,0,0,0,0,0,0,1.0,1.0,1.0,255,255,255,100,0,0,0,0)
				DrawMarker(1,j.positionFrom.x,j.positionFrom.y,j.positionFrom.z-1,0,0,0,0,0,0,1.0,1.0,1.0,255,255,255,50,0,0,0,0)
				-- DrawMarker(1,j.positionTo.x,j.positionTo.y,j.positionTo.z-1,0,0,0,0,0,0,1.0,1.0,1.0,255,255,255,50,0,0,0,0)
				if distance <= 1.5 then
					if IsControlJustPressed(0,38) then
						SetEntityCoords(PlayerPedId(),j.positionTo.x,j.positionTo.y,j.positionTo.z-0.50)
					end
				end
			end

			if distance2 <= 15 then
				esperar = 4
			DrawMarker(1,j.positionTo.x,j.positionTo.y,j.positionTo.z-1,0,0,0,0,0,0,1.0,1.0,1.0,255,255,255,50,0,0,0,0)
				if distance2 <= 1.5 then
			 		if IsControlJustPressed(0,38) then
						SetEntityCoords(PlayerPedId(),j.positionFrom.x,j.positionFrom.y,j.positionFrom.z-0.50)
			 		end
			 	end
			 end
		end
		Citizen.Wait(esperar)
	end
end)