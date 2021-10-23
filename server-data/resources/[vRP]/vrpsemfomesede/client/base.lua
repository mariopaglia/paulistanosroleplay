local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")

tvRP = {}
local players = {}
Tunnel.bindInterface("vRP",tvRP)
vRPserver = Tunnel.getInterface("vRP")
Proxy.addInterface("vRP",tvRP)

local user_id
function tvRP.setUserId(_user_id)
	user_id = _user_id
end

function tvRP.getUserId()
	return user_id
end

function tvRP.teleport(x,y,z)
	SetEntityCoords(PlayerPedId(),x+0.0001,y+0.0001,z+0.0001,1,0,0,1)
	vRPserver._updatePos(x,y,z)
end

function tvRP.getPosition()
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
	return x,y,z
end

function tvRP.getSpeed()
  local vx,vy,vz = table.unpack(GetEntityVelocity(GetPlayerPed(-1)))
  return math.sqrt(vx*vx+vy*vy+vz*vz)
end

function tvRP.isInside()
	local x,y,z = tvRP.getPosition()
	return not (GetInteriorAtCoords(x,y,z) == 0)
end

function tvRP.getCamDirection()
	local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
	local pitch = GetGameplayCamRelativePitch()
	local x = -math.sin(heading*math.pi/180.0)
	local y = math.cos(heading*math.pi/180.0)
	local z = math.sin(pitch*math.pi/180.0)
	local len = math.sqrt(x*x+y*y+z*z)
	if len ~= 0 then
		x = x/len
		y = y/len
		z = z/len
	end
	return x,y,z
end

function tvRP.addPlayer(player)
	players[player] = true
end

function tvRP.removePlayer(player)
	players[player] = nil
end

function tvRP.getNearestPlayers(radius)
	local r = {}
	local ped = GetPlayerPed(i)
	local pid = PlayerId()
	local px,py,pz = tvRP.getPosition()

	for k,v in pairs(players) do
		local player = GetPlayerFromServerId(k)
		if player ~= pid and NetworkIsPlayerConnected(player) then
			local oped = GetPlayerPed(player)
			local x,y,z = table.unpack(GetEntityCoords(oped,true))
			local distance = GetDistanceBetweenCoords(x,y,z,px,py,pz,true)
			if distance <= radius then
				r[GetPlayerServerId(player)] = distance
			end
		end
	end
	return r
end

function tvRP.getNearestPlayer(radius)
	local p = nil
	local players = tvRP.getNearestPlayers(radius)
	local min = radius+0.0001
	for k,v in pairs(players) do
		if v < min then
			min = v
			p = k
		end
	end
	return p
end

local anims = {}
local anim_ids = Tools.newIDGenerator()

function tvRP.playAnim(upper,seq,looping)
	if seq.task then
		tvRP.stopAnim(true)

		local ped = PlayerPedId()
		if seq.task == "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" then
			local x,y,z = tvRP.getPosition()
			TaskStartScenarioAtPosition(ped,seq.task,x,y,z-1,GetEntityHeading(ped),0,0,false)
		else
			TaskStartScenarioInPlace(ped,seq.task,0,not seq.play_exit)
		end
	else
		tvRP.stopAnim(upper)

		local flags = 0
		if upper then flags = flags+48 end
		if looping then flags = flags+1 end

		Citizen.CreateThread(function()
			local id = anim_ids:gen()
			anims[id] = true

			for k,v in pairs(seq) do
				local dict = v[1]
				local name = v[2]
				local loops = v[3] or 1

				for i=1,loops do
					if anims[id] then
						local first = (k == 1 and i == 1)
						local last = (k == #seq and i == loops)

						RequestAnimDict(dict)
						local i = 0
						while not HasAnimDictLoaded(dict) and i < 1000 do
						Citizen.Wait(10)
						RequestAnimDict(dict)
						i = i + 1
					end

					if HasAnimDictLoaded(dict) and anims[id] then
						local inspeed = 3.0
						local outspeed = -3.0
						if not first then inspeed = 2.0 end
						if not last then outspeed = 2.0 end

						TaskPlayAnim(PlayerPedId(),dict,name,inspeed,outspeed,-1,flags,0,0,0,0)
					end
						Citizen.Wait(1)
						while GetEntityAnimCurrentTime(PlayerPedId(),dict,name) <= 0.95 and IsEntityPlayingAnim(PlayerPedId(),dict,name,3) and anims[id] do
							Citizen.Wait(1)
						end
					end
				end
			end
			anim_ids:free(id)
			anims[id] = nil
		end)
	end
end

function tvRP.stopAnim(upper)
	anims = {}
	if upper then
		ClearPedSecondaryTask(PlayerPedId())
	else
		ClearPedTasks(PlayerPedId())
	end
end

function tvRP.playSound(dict,name)
	PlaySoundFrontend(-1,dict,name,false)
end

function tvRP.playScreenEffect(name,duration)
	if duration < 0 then
		StartScreenEffect(name,0,true)
	else
		StartScreenEffect(name,0,true)

		Citizen.CreateThread(function()
			Citizen.Wait(math.floor((duration+1)*1000))
			StopScreenEffect(name)
		end)
	end
end

AddEventHandler("playerSpawned",function()
	TriggerServerEvent("vRPcli:playerSpawned")
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if NetworkIsSessionStarted() then
			TriggerServerEvent("Queue:playerActivated")
			return
		end
	end
end)

Citizen.CreateThread(function()
	RequestIpl("h4_islandairstrip")
	RequestIpl("h4_islandairstrip_props")
	RequestIpl("h4_islandx_mansion")
	RequestIpl("h4_islandx_mansion_props")
	RequestIpl("h4_islandx_props")
	RequestIpl("h4_islandxdock")
	RequestIpl("h4_islandxdock_props")
	RequestIpl("h4_islandxdock_props_2")
	RequestIpl("h4_islandxtower")
	RequestIpl("h4_islandx_maindock")
	RequestIpl("h4_islandx_maindock_props")
	RequestIpl("h4_islandx_maindock_props_2")
	RequestIpl("h4_IslandX_Mansion_Vault")
	RequestIpl("h4_islandairstrip_propsb")
	RequestIpl("h4_beach")
	RequestIpl("h4_beach_props")
	RequestIpl("h4_beach_bar_props")
	RequestIpl("h4_islandx_barrack_props")
	RequestIpl("h4_islandx_checkpoint")
	RequestIpl("h4_islandx_checkpoint_props")
	RequestIpl("h4_islandx_Mansion_Office")
	RequestIpl("h4_islandx_Mansion_LockUp_01")
	RequestIpl("h4_islandx_Mansion_LockUp_02")
	RequestIpl("h4_islandx_Mansion_LockUp_03")
	RequestIpl("h4_islandairstrip_hangar_props")
	RequestIpl("h4_IslandX_Mansion_B")
	RequestIpl("h4_islandairstrip_doorsclosed")
	RequestIpl("h4_Underwater_Gate_Closed")
	RequestIpl("h4_mansion_gate_closed")
	RequestIpl("h4_aa_guns")
	RequestIpl("h4_IslandX_Mansion_GuardFence")
	RequestIpl("h4_IslandX_Mansion_Entrance_Fence")
	RequestIpl("h4_IslandX_Mansion_B_Side_Fence")
	RequestIpl("h4_IslandX_Mansion_Lights")
	RequestIpl("h4_islandxcanal_props")
	RequestIpl("h4_beach_props_party")
	RequestIpl("h4_islandX_Terrain_props_06_a")
	RequestIpl("h4_islandX_Terrain_props_06_b")
	RequestIpl("h4_islandX_Terrain_props_06_c")
	RequestIpl("h4_islandX_Terrain_props_05_a")
	RequestIpl("h4_islandX_Terrain_props_05_b")
	RequestIpl("h4_islandX_Terrain_props_05_c")
	RequestIpl("h4_islandX_Terrain_props_05_d")
	RequestIpl("h4_islandX_Terrain_props_05_e")
	RequestIpl("h4_islandX_Terrain_props_05_f")
	RequestIpl("H4_islandx_terrain_01")
	RequestIpl("H4_islandx_terrain_02")
	RequestIpl("H4_islandx_terrain_03")
	RequestIpl("H4_islandx_terrain_04")
	RequestIpl("H4_islandx_terrain_05")
	RequestIpl("H4_islandx_terrain_06")
	RequestIpl("h4_ne_ipl_00")
	RequestIpl("h4_ne_ipl_01")
	RequestIpl("h4_ne_ipl_02")
	RequestIpl("h4_ne_ipl_03")
	RequestIpl("h4_ne_ipl_04")
	RequestIpl("h4_ne_ipl_05")
	RequestIpl("h4_ne_ipl_06")
	RequestIpl("h4_ne_ipl_07")
	RequestIpl("h4_ne_ipl_08")
	RequestIpl("h4_ne_ipl_09")
	RequestIpl("h4_nw_ipl_00")
	RequestIpl("h4_nw_ipl_01")
	RequestIpl("h4_nw_ipl_02")
	RequestIpl("h4_nw_ipl_03")
	RequestIpl("h4_nw_ipl_04")
	RequestIpl("h4_nw_ipl_05")
	RequestIpl("h4_nw_ipl_06")
	RequestIpl("h4_nw_ipl_07")
	RequestIpl("h4_nw_ipl_08")
	RequestIpl("h4_nw_ipl_09")
	RequestIpl("h4_se_ipl_00")
	RequestIpl("h4_se_ipl_01")
	RequestIpl("h4_se_ipl_02")
	RequestIpl("h4_se_ipl_03")
	RequestIpl("h4_se_ipl_04")
	RequestIpl("h4_se_ipl_05")
	RequestIpl("h4_se_ipl_06")
	RequestIpl("h4_se_ipl_07")
	RequestIpl("h4_se_ipl_08")
	RequestIpl("h4_se_ipl_09")
	RequestIpl("h4_sw_ipl_00")
	RequestIpl("h4_sw_ipl_01")
	RequestIpl("h4_sw_ipl_02")
	RequestIpl("h4_sw_ipl_03")
	RequestIpl("h4_sw_ipl_04")
	RequestIpl("h4_sw_ipl_05")
	RequestIpl("h4_sw_ipl_06")
	RequestIpl("h4_sw_ipl_07")
	RequestIpl("h4_sw_ipl_08")
	RequestIpl("h4_sw_ipl_09")
	RequestIpl("h4_islandx_mansion")
	RequestIpl("h4_islandxtower_veg")
	RequestIpl("h4_islandx_sea_mines")
	RequestIpl("h4_islandx")
	RequestIpl("h4_islandx_barrack_hatch")
	RequestIpl("h4_islandxdock_water_hatch")
	RequestIpl("h4_beach_party")
	-- CASINO
	RequestIpl("vw_casino_main")
    RequestIpl("vw_casino_garage")
    RequestIpl("vw_casino_carpark")
    RequestIpl("vw_casino_penthouse")
    RequestIpl("vw_dlc_casino_door")
    RequestIpl("hei_dlc_casino_door")
    RequestIpl("hei_dlc_windows_casino")
	SetDeepOceanScaler(0.0)
end)