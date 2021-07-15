local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_residencia",src)
vSERVER = Tunnel.getInterface("vrp_residencia")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local check = {}
local locker = nil
local robberys = false
local houseName = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOUSES
-----------------------------------------------------------------------------------------------------------------------------------------
local houses = {
	["Mirrorpark01"] = {
		["invasion"] = { 1295.92,-590.14,71.74 },
		["evasion"] = { 1296.05,-596.52,67.84 },
		["creative01"] = { 1300.2,-586.28,67.84 },
		["creative02"] = { 1293.27,-585.08,67.84 },
		["creative03"] = { 1294.97,-578.58,67.84 },
		["creative04"] = { 1301.94,-580.59,67.84 },
		["creative05"] = { 1306.75,-585.92,67.84 },
		["creative06"] = { 1305.81,-581.25,67.84 },
		["creative07"] = { 1304.29,-579.84,67.84 },
		["creative08"] = { 1308.24,-580.87,67.84 },
		["creative09"] = { 1298.54,-585.02,67.84 },
		["creative10"] = { 1296.39,-586.22,67.84 },
		["locker"] = { 1308.93,-582.23,67.84 }
	},
	["Mirrorpark02"] = {
		["invasion"] = { 1309.09,-511.7,71.47 },
		["evasion"] = { 1306.62,-529.66,67.84 },
		["creative01"] = { 1310.14,-518.94,67.84 },
		["creative02"] = { 1303.07,-518.29,67.84 },
		["creative03"] = { 1304.35,-511.63,67.84 },
		["creative04"] = { 1311.32,-513.26,67.84 },
		["creative05"] = { 1316.56,-518.31,67.84 },
		["creative06"] = { 1315.31,-513.68,67.84 },
		["creative07"] = { 1317.65,-513.16,67.84 },
		["creative08"] = { 1313.73,-512.26,67.84 },
		["creative09"] = { 1308.32,-517.88,67.84 },
		["creative10"] = { 1306.29,-519.25,67.84 },
		["locker"] = { 1318.73,-514.0,67.84 }
	},
	["Mirrorpark03"] = {
		["invasion"] = { 1316.11,-598.29,73.25 },
		["evasion"] = { 1314.53,-601.39,67.84 },
		["creative01"] = { 1318.78,-591.14,67.84 },
		["creative02"] = { 1311.78,-589.89,67.84 },
		["creative03"] = { 1313.56,-583.26,67.84 },
		["creative04"] = { 1320.46,-585.41,67.84 },
		["creative05"] = { 1325.18,-590.81,67.84 },
		["creative06"] = { 1324.38,-586.16,67.84 },
		["creative07"] = { 1326.72,-585.77,67.84 },
		["creative08"] = { 1322.82,-584.62,67.84 },
		["creative09"] = { 1316.96,-589.88,67.84 },
		["creative10"] = { 1314.95,-591.07,67.84 },
		["locker"] = { 1327.56,-586.99,67.84 }
	},
	["Mirrorpark04"] = {
		["invasion"] = { 1335.55,-522.49,72.25 },
		["evasion"] = { 1329.15,-541.61,67.84 },
		["creative01"] = { 1332.55,-530.85,67.84 },
		["creative02"] = { 1325.5,-530.16,67.84 },
		["creative03"] = { 1326.7,-523.5,67.84 },
		["creative04"] = { 1333.71,-524.96,67.84 },
		["creative05"] = { 1338.89,-530.1,67.84 },
		["creative06"] = { 1337.68,-525.41,67.84 },
		["creative07"] = { 1340.02,-524.9,67.85 },
		["creative08"] = { 1336.08,-524.08,67.84 },
		["creative09"] = { 1330.67,-529.68,67.84 },
		["creative10"] = { 1328.71,-531.2,67.84 },
		["locker"] = { 1341.09,-525.92,67.84 }
	},
	["Mirrorpark05"] = {
		["invasion"] = { 1330.81,-608.26,74.51 },
		["evasion"] = { 1330.71,-615.82,67.84 },
		["creative01"] = { 1337.12,-606.65,67.84 },
		["creative02"] = { 1330.53,-603.95,67.84 },
		["creative03"] = { 1333.69,-597.89,67.84 },
		["creative04"] = { 1339.98,-601.45,67.84 },
		["creative05"] = { 1343.42,-607.75,67.84 },
		["creative06"] = { 1343.59,-602.95,67.84 },
		["creative07"] = { 1346.12,-603.15,67.84 },
		["creative08"] = { 1342.45,-601.22,67.84 },
		["creative09"] = { 1335.7,-605.03,67.84 },
		["creative10"] = { 1333.24,-605.81,67.84 },
		["locker"] = { 1346.78,-604.27,67.84 }
	},
	["Mirrorpark06"] = {
		["invasion"] = { 1355.09,-531.46,73.9 },
		["evasion"] = { 1351.19,-548.67,67.84 },
		["creative01"] = { 1355.06,-538.28,67.84 },
		["creative02"] = { 1348.1,-537.26,67.84 },
		["creative03"] = { 1349.71,-530.64,67.84 },
		["creative04"] = { 1356.68,-532.55,67.84 },
		["creative05"] = { 1361.52,-537.88,67.84 },
		["creative06"] = { 1360.64,-533.17,67.84 },
		["creative07"] = { 1362.98,-532.77,67.84 },
		["creative08"] = { 1359.01,-531.76,67.84 },
		["creative09"] = { 1353.35,-536.99,67.84 },
		["creative10"] = { 1351.32,-538.38,67.84 },
		["locker"] = { 1363.96,-533.67,67.84 }
	},
	["Mirrorpark07"] = {
		["invasion"] = { 1366.94,-623.35,74.72 },
		["evasion"] = { 1367.13,-626.49,67.84 },
		["creative01"] = { 1366.75,-615.33,67.84 },
		["creative02"] = { 1359.89,-616.99,67.84 },
		["creative03"] = { 1358.83,-610.36,67.84 },
		["creative04"] = { 1365.96,-609.38,67.84 },
		["creative05"] = { 1372.52,-612.39,67.84 },
		["creative06"] = { 1369.8,-608.44,67.84 },
		["creative07"] = { 1371.93,-607.11,67.84 },
		["creative08"] = { 1367.85,-607.73,67.84 },
		["creative09"] = { 1364.62,-614.87,67.84 },
		["creative10"] = { 1363.23,-616.89,67.84 },
		["locker"] = { 1373.2,-607.6,67.84 }
	},
	["Mirrorpark08"] = {
		["invasion"] = { 1380.75,-542.51,74.5 },
		["evasion"] = { 1370.81,-561.37,67.84 },
		["creative01"] = { 1374.79,-550.91,67.84 },
		["creative02"] = { 1367.82,-549.72,67.84 },
		["creative03"] = { 1369.36,-543.2,67.84 },
		["creative04"] = { 1376.25,-545.1,67.84 },
		["creative05"] = { 1381.18,-550.41,67.84 },
		["creative06"] = { 1380.22,-545.65,67.84 },
		["creative07"] = { 1382.63,-545.34,67.84 },
		["creative08"] = { 1378.69,-544.25,67.84 },
		["creative09"] = { 1373.02,-549.47,67.84 },
		["creative10"] = { 1370.95,-550.89,67.84 },
		["locker"] = { 1383.62,-546.2,67.84 }
	},
	["Mirrorpark09"] = {
		["invasion"] = { 1399.4,-603.89,74.49 },
		["evasion"] = { 1381.64,-593.69,67.84 },
		["creative01"] = { 1390.77,-600.24,67.84 },
		["creative02"] = { 1393.58,-593.73,67.84 },
		["creative03"] = { 1399.55,-597.05,67.84 },
		["creative04"] = { 1395.85,-603.26,67.84 },
		["creative05"] = { 1389.52,-606.6,67.84 },
		["creative06"] = { 1394.22,-606.93,67.84 },
		["creative07"] = { 1394.02,-609.23,67.84 },
		["creative08"] = { 1396.05,-605.76,67.84 },
		["creative09"] = { 1392.43,-598.93,67.84 },
		["creative10"] = { 1391.68,-596.55,67.84 },
		["locker"] = { 1392.89,-609.98,67.84 }
	},
	["Mirrorpark10"] = {
		["invasion"] = { 1404.53,-563.13,74.5 },
		["evasion"] = { 1386.84,-573.81,67.84 },
		["creative01"] = { 1396.7,-568.89,67.84 },
		["creative02"] = { 1392.31,-563.32,67.84 },
		["creative03"] = { 1397.81,-559.6,67.84 },
		["creative04"] = { 1401.73,-565.7,67.84 },
		["creative05"] = { 1401.76,-572.86,67.84 },
		["creative06"] = { 1404.24,-568.82,67.84 },
		["creative07"] = { 1406.19,-570.04,67.84 },
		["creative08"] = { 1404.0,-566.68,67.84 },
		["creative09"] = { 1396.3,-566.76,67.84 },
		["creative10"] = { 1393.8,-566.28,67.84 },
		["locker"] = { 1406.36,-571.43,67.84 }
	},
	["Roselia"] = {
		["enter"] = { -3016.99,746.71,27.79 },
		["invasion"] = { -3003.66,743.23,27.78 },
		["evasion"] = { -3006.01,755.81,-2.79 },
		["creative01"] = { -3008.5,744.2,-2.79 },
		["creative02"] = { -3027.82,748.49,-4.19 },
		["creative03"] = { -3022.9,752.59,-4.19 },
		["creative04"] = { -3029.9,735.14,-4.19 },
		["creative05"] = { -3026.3,746.03,-8.99 },
		["creative06"] = { -3028.37,747.19,-8.99 },
		["creative07"] = { -3029.08,749.88,-8.99 },
		["creative08"] = { -3025.08,740.73,-8.99 },
		["creative09"] = { -3025.71,743.54,-8.99 },
		["creative10"] = { -3018.13,745.78,-8.99 }
		--["locker"] = { -3028.75,745.63,-8.99,104.27 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- robberys
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if not robberys then
			local ped = PlayerPedId()
			if not IsPedInAnyVehicle(ped) then
				local x,y,z = table.unpack(GetEntityCoords(ped))
				for k,v in pairs(houses) do
					local distance = Vdist(x,y,z,v["invasion"][1],v["invasion"][2],v["invasion"][3])
					if distance <= 2.0 then
						drawText3D(v["invasion"][1],v["invasion"][2],v["invasion"][3],"~g~G ~w~  INVADIR")
						if distance <= 1.1 and IsControlJustPressed(1,47) then
							houseName = tostring(k)
							vSERVER.checkLockpick(k,v["evasion"][1],v["evasion"][2],v["evasion"][3],v["locker"][1],v["locker"][2],v["locker"][3],v["locker"][4])
						end
					end
				end
			end
		end
		Citizen.Wait(1)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- robberys
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if robberys then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = Vdist(x,y,z,houses[houseName]["evasion"][1],houses[houseName]["evasion"][2],houses[houseName]["evasion"][3])
			if distance <= 2.5 then
				drawText3D(houses[houseName]["evasion"][1],houses[houseName]["evasion"][2],houses[houseName]["evasion"][3],"~g~G ~w~  EVADIR")
				if distance <= 1.1 and IsControlJustPressed(1,47) then
					if DoesEntityExist(locker) then
						TriggerServerEvent("tryDeleteEntity",ObjToNet(locker))
						locker = nil
					end
					check = {}
					robberys = false
					vRP._teleport(houses[houseName]["invasion"][1],houses[houseName]["invasion"][2],houses[houseName]["invasion"][3])
					TriggerEvent("blockFunctions",false)
				end
			end
			for k,v in pairs(houses[houseName]) do
				if k ~= "invasion" and k ~= "evasion" then
					local distance = Vdist(v[1],v[2],v[3],x,y,z)
					if distance <= 2.5 and not check[k] then
						drawText3D(v[1],v[2],v[3],"~g~G ~w~ PROCURAR")
						if distance <= 1.1 and IsControlJustPressed(1,47) then
							check[k] = true
							TriggerEvent('cancelando',true)
							if k == "locker" and DoesEntityExist(locker) then
								TriggerEvent("mhacking:show")
								TriggerEvent("mhacking:start",2,18,hackLocker)
							else
								FreezeEntityPosition(ped,true)
								TriggerEvent('cancelando',false)
								vSERVER.checkPayment(houseName,k,houses[houseName]["invasion"][1],houses[houseName]["invasion"][2],houses[houseName]["invasion"][3])
								FreezeEntityPosition(ped,false)
							end
						end
					end
				end
			end
		end
		Citizen.Wait(1)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HACKLOCKER
-----------------------------------------------------------------------------------------------------------------------------------------
function hackLocker(success,time)
	TriggerEvent('cancelando',false)
	if success then
		TriggerEvent("mhacking:hide")
		vSERVER.checkPayment(houseName,"locker",houses[houseName]["invasion"][1],houses[houseName]["invasion"][2],houses[houseName]["invasion"][3])
	else
		TriggerEvent("mhacking:hide")
		vSERVER.resetTimer()
	end
	if DoesEntityExist(locker) then
		TriggerServerEvent("tryDeleteEntity",ObjToNet(locker))
		locker = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function drawText3D(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/370
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSTATUS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkStatus(status)
	robberys = status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATELOCKER
-----------------------------------------------------------------------------------------------------------------------------------------
function src.createLocker(status,x,y,z,h,home)
	SetPedComponentVariation(GetPlayerPed(-1),9,0,0,2)
	SetPedComponentVariation(GetPlayerPed(-1),5,45,0,2)
	if DoesEntityExist(locker) then
		TriggerServerEvent("tryDeleteEntity",ObjToNet(locker))
		locker = nil
	end
	if status then
		locker = CreateObject(GetHashKey("prop_ld_int_safe_01"),x,y,z-1,true,false,false)
		FreezeEntityPosition(locker,true)
		SetEntityCollision(locker,false,false)
		SetEntityHeading(locker,h)
	else
		locker = nil
		check["locker"] = true
	end
	TriggerEvent("blockFunctions",true)
end