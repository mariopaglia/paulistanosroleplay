local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- REANIMAR
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterNetEvent('reanimar')
-- AddEventHandler('reanimar',function()
-- 	local handle,ped = FindFirstPed()
-- 	local finished = false
-- 	local reviver = nil
-- 	repeat
-- 		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),GetEntityCoords(ped),true)
-- 		if IsPedDeadOrDying(ped) and not IsPedAPlayer(ped) and distance <= 1.5 and reviver == nil then
-- 			reviver = ped
-- 			TriggerEvent("cancelando",true)
-- 			vRP._playAnim(false,{{"amb@medic@standing@tendtodead@base","base"},{"mini@cpr@char_a@cpr_str","cpr_pumpchest"}},true)
-- 			TriggerEvent("progress",15000,"reanimando")
-- 			SetTimeout(15000,function()
-- 				SetEntityHealth(reviver,400)
-- 				local newped = ClonePed(reviver,GetEntityHeading(reviver),true,true)
-- 				TaskWanderStandard(newped,10.0,10)
-- 				local model = GetEntityModel(reviver)
-- 				SetModelAsNoLongerNeeded(model)
-- 				TriggerServerEvent("trydeleteped",PedToNet(reviver))
-- 				vRP._stopAnim(false)
-- 				TriggerServerEvent("reanimar:pagamento")
-- 				TriggerEvent("cancelando",false)
-- 			end)
-- 			finished = true
-- 		end
-- 		finished,ped = FindNextPed(handle)
-- 	until not finished
-- 	EndFindPed(handle)
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAIR DE TODOS OS RADIOS (TOKOVOIP)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('desligarRadios')
AddEventHandler('desligarRadios',function()
	local i = 0
    while i < 1036 do
      if exports.tokovoip_script:isPlayerInChannel(i) == true then
		exports.tokovoip_script:removePlayerFromRadio(i)
	  end	
      i = i + 1
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Codigo pra remover a hud e deixar c o "X" qnd mata
-----------------------------------------------------------------------------------------------------------------------------------------
-- -- Configuration array for all HUD elements
-- local HUD_ELEMENTS = {
--     HUD = {id = 0, hidden = false},
--     HUD_WANTED_STARS = {id = 1, hidden = true},
--     HUD_WEAPON_ICON = {id = 2, hidden = true},
--     HUD_CASH = {id = 3, hidden = true},
--     HUD_MP_CASH = {id = 4, hidden = true},
--     HUD_MP_MESSAGE = {id = 5, hidden = true},
--     HUD_VEHICLE_NAME = {id = 6, hidden = true},
--     HUD_AREA_NAME = {id = 7, hidden = true},
--     HUD_VEHICLE_CLASS = {id = 8, hidden = true},
--     HUD_STREET_NAME = {id = 9, hidden = true},
--     HUD_HELP_TEXT = {id = 10, hidden = false},
--     HUD_FLOATING_HELP_TEXT_1 = {id = 11, hidden = false},
--     HUD_FLOATING_HELP_TEXT_2 = {id = 12, hidden = false},
--     HUD_CASH_CHANGE = {id = 13, hidden = true},
--     HUD_RETICLE = {id = 14, hidden = false},
--     HUD_SUBTITLE_TEXT = {id = 15, hidden = false},
--     HUD_RADIO_STATIONS = {id = 16, hidden = false},
--     HUD_SAVING_GAME = {id = 17, hidden = false},
--     HUD_GAME_STREAM = {id = 18, hidden = false},
--     HUD_WEAPON_WHEEL = {id = 19, hidden = false},
--     HUD_WEAPON_WHEEL_STATS = {id = 20, hidden = false},
--     MAX_HUD_COMPONENTS = {id = 21, hidden = false},
--     MAX_HUD_WEAPONS = {id = 22, hidden = false},
--     MAX_SCRIPTED_HUD_COMPONENTS = {id = 141, hidden = false},
-- }

-- local HUD_HIDE_RADAR_ON_FOOT = true

-- -- Main thread
-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(0)

--         if HUD_HIDE_RADAR_ON_FOOT then
--             local player = GetPlayerPed(-1)
--             DisplayRadar(IsPedInAnyVehicle(player, false))
--             SetRadarZoomLevelThisFrame(200.0)
--         end

--         for key, val in pairs(HUD_ELEMENTS) do
--             if val.hidden then
--                 HideHudComponentThisFrame(val.id)
--             else
--                 ShowHudComponentThisFrame(val.id)
--             end
--         end
--     end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /RMASCARA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("rmascara")
AddEventHandler("rmascara",function()
	SetPedComponentVariation(PlayerPedId(),1,0,0,2)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /RCHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("rchapeu")
AddEventHandler("rchapeu",function()
	ClearPedProp(PlayerPedId(),0)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SET & REMOVE ALGEMAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("setalgemas")
AddEventHandler("setalgemas",function()
	local ped = PlayerPedId()
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		SetPedComponentVariation(ped,7,41,0,2)
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		SetPedComponentVariation(ped,7,25,0,2)
	end
end)
RegisterNetEvent("removealgemas")
AddEventHandler("removealgemas",function()
	SetPedComponentVariation(PlayerPedId(),7,0,0,2)
end)

--[ CARREGAR ]---------------------------------------------------------------------------------------------------------------------------

other = nil
drag = false
carregado = false
RegisterNetEvent("carregar")
AddEventHandler("carregar",function(p1)
    other = p1
    drag = not drag
end)

Citizen.CreateThread(function()
    while true do
    	local idle = 300
		if drag and other then
			idle = 5
			local ped = GetPlayerPed(GetPlayerFromServerId(other))
			Citizen.InvokeNative(0x6B9BBD38AB0796DF,PlayerPedId(),ped,4103,11816,0.48,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
			carregado = true
		else
			idle = 5
        	if carregado then
				DetachEntity(PlayerPedId(),true,false)
				carregado = false
			end
		end
		Citizen.Wait(idle)
	end
end)

--------------------------------------------------------------------------------------------------------------------------------------------------
-- DISPAROS CLIENT.LUA
--------------------------------------------------------------------------------------------------------------------------------------------------
local blacklistedWeapons = {
	"WEAPON_DAGGER",
	"WEAPON_BAT",
	"WEAPON_BOTTLE",
	"WEAPON_CROWBAR",
	"WEAPON_FLASHLIGHT",
	"WEAPON_GOLFCLUB",
	"WEAPON_HAMMER",
	"WEAPON_HATCHET",
	"WEAPON_KNUCKLE",
	"WEAPON_KNIFE",
	"WEAPON_MACHETE",
	"WEAPON_SWITCHBLADE",
	"WEAPON_NIGHTSTICK",
	"WEAPON_WRENCH",
	"WEAPON_BATTLEAXE",
	"WEAPON_POOLCUE",
	"WEAPON_STONE_HATCHET",
	"WEAPON_STUNGUN",
	"WEAPON_FLARE",
	"GADGET_PARACHUTE",
	"WEAPON_FIREEXTINGUISHER",
	"WEAPON_RAYPISTOL",
	"WEAPON_PETROLCAN",
	"WEAPON_MUSKET",
}

local delay = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		local blacklistweapon = false
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))

		for k,v in ipairs(blacklistedWeapons) do
			if GetSelectedPedWeapon(ped) == GetHashKey(v) then
				blacklistweapon = true
			end
		end

		if IsPedShooting(ped) and not blacklistweapon then
			TriggerServerEvent('atirando',x,y,z)
			if not delay[ped] then
				delay[ped] = true
				TriggerServerEvent('atirandolog',x,y,z)
				SetTimeout(40000,function()
					delay[ped] = nil
				end)
			end
		end

		blacklistweapon = false
	end
end)

local blips = {}
RegisterNetEvent('notificacao')
AddEventHandler('notificacao',function(x,y,z,user_id)
	local distance = GetDistanceBetweenCoords(x,y,z,-186.1,-893.5,29.3,true)
	if distance <= 210000 then
		if not DoesBlipExist(blips[user_id]) then
			PlaySoundFrontend(-1,"Enter_1st","GTAO_FM_Events_Soundset",false)
			TriggerEvent("Notify", "policia", "Disparos de <b>Arma de Fogo</b> aconteceram, verifique o ocorrido.", 20000)
			TriggerEvent('chatMessage',"CENTRAL:",{65,130,255},"Disparos de arma de fogo aconteceram, verifique o ocorrido.")
			blips[user_id] = AddBlipForCoord(x,y,z)
			SetBlipScale(blips[user_id],0.5)
			SetBlipSprite(blips[user_id],10)
			SetBlipColour(blips[user_id],1)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Disparos de arma de fogo")
			EndTextCommandSetBlipName(blips[user_id])
			SetBlipAsShortRange(blips[user_id],false)
			SetTimeout(30000,function()
				if DoesBlipExist(blips[user_id]) then
					RemoveBlip(blips[user_id])
				end
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONE
-----------------------------------------------------------------------------------------------------------------------------------------
local cone = nil
RegisterNetEvent('cone')
AddEventHandler('cone',function(nome)
	local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,1.0,-0.94)
	local prop = "prop_mp_cone_02"
	local h = GetEntityHeading(PlayerPedId())
	if nome ~= "d" then
		cone = CreateObject(GetHashKey(prop),coord.x,coord.y-0.5,coord.z,true,true,true)
		PlaceObjectOnGroundProperly(cone)
		SetModelAsNoLongerNeeded(cone)
		SetEntityAsMissionEntity(cone,true,true)
		SetEntityHeading(cone,h)
		FreezeEntityPosition(cone,true)
		SetEntityAsNoLongerNeeded(cone)
	else
		if DoesObjectOfTypeExistAtCoords(coord.x,coord.y,coord.z,0.9,GetHashKey(prop),true) then
			cone = GetClosestObjectOfType(coord.x,coord.y,coord.z,0.9,GetHashKey(prop),false,false,false)
			TriggerServerEvent("trydeleteobj",ObjToNet(cone))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARREIRA
-----------------------------------------------------------------------------------------------------------------------------------------
local barreira = nil
RegisterNetEvent('barreira')
AddEventHandler('barreira',function(nome)
	local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,1.5,-0.94)
	local prop = "prop_mp_barrier_02b"
	local h = GetEntityHeading(PlayerPedId())
	if nome ~= "d" then
		barreira = CreateObject(GetHashKey(prop),coord.x,coord.y-0.95,coord.z,true,true,true)
		PlaceObjectOnGroundProperly(barreira)
		SetModelAsNoLongerNeeded(barreira)
		SetEntityAsMissionEntity(barreira,true,true)
		SetEntityHeading(barreira,h-180)
		FreezeEntityPosition(barreira,true)
		SetEntityAsNoLongerNeeded(barreira)
	else
		if DoesObjectOfTypeExistAtCoords(coord.x,coord.y,coord.z,0.9,GetHashKey(prop),true) then
			barreira = GetClosestObjectOfType(coord.x,coord.y,coord.z,0.9,GetHashKey(prop),false,false,false)
			TriggerServerEvent("trydeleteobj",ObjToNet(barreira))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPIKE
-----------------------------------------------------------------------------------------------------------------------------------------
local spike = nil
RegisterNetEvent('spike')
AddEventHandler('spike',function(nome)
	local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,2.5,0.0)
	local prop = "p_ld_stinger_s"
	local h = GetEntityHeading(PlayerPedId())
	if nome ~= "d" then
		spike = CreateObject(GetHashKey(prop),coord.x,coord.y,coord.z,true,true,true)
		PlaceObjectOnGroundProperly(spike)
		SetModelAsNoLongerNeeded(spike)
		SetEntityAsMissionEntity(spike,true,true)
		SetEntityHeading(spike,h-180)
		FreezeEntityPosition(spike,true)
		SetEntityAsNoLongerNeeded(spike)
	else
		if DoesObjectOfTypeExistAtCoords(coord.x,coord.y,coord.z,0.9,GetHashKey(prop),true) then
			spike = GetClosestObjectOfType(coord.x,coord.y,coord.z,0.9,GetHashKey(prop),false,false,false)
			TriggerServerEvent("trydeleteobj",ObjToNet(spike))
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local veh = GetVehiclePedIsIn(PlayerPedId(),false)
		local vcoord = GetEntityCoords(veh)
		local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,1.0,-0.94)
		if IsPedInAnyVehicle(PlayerPedId()) then
			idle = 5
			if DoesObjectOfTypeExistAtCoords(vcoord.x,vcoord.y,vcoord.z,0.9,GetHashKey("p_ld_stinger_s"),true) then
				SetVehicleTyreBurst(veh,0,true,1000.0)
				SetVehicleTyreBurst(veh,1,true,1000.0)
				SetVehicleTyreBurst(veh,2,true,1000.0)
				SetVehicleTyreBurst(veh,3,true,1000.0)
				SetVehicleTyreBurst(veh,4,true,1000.0)
				SetVehicleTyreBurst(veh,5,true,1000.0)
				SetVehicleTyreBurst(veh,6,true,1000.0)
				SetVehicleTyreBurst(veh,7,true,1000.0)
				if DoesObjectOfTypeExistAtCoords(coord.x,coord.y,coord.z,0.9,GetHashKey("p_ld_stinger_s"),true) then
					spike = GetClosestObjectOfType(coord.x,coord.y,coord.z,0.9,GetHashKey("p_ld_stinger_s"),false,false,false)
					TriggerServerEvent("trydeleteobj",ObjToNet(spike))
				end
			end
		end
		Citizen.Wait(idle)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISÃO
-----------------------------------------------------------------------------------------------------------------------------------------
local prisioneiro = false
local reducaopenal = false

RegisterNetEvent('prisioneiro')
AddEventHandler('prisioneiro',function(status)
	prisioneiro = status
	reducaopenal = false
	local ped = PlayerPedId()
	if prisioneiro then
		SetEntityInvincible(ped,false) -- MQCU
		FreezeEntityPosition(ped,true)
		SetEntityVisible(ped,false,false)
		SetTimeout(10000,function()
			SetEntityInvincible(ped,false)
			FreezeEntityPosition(ped,false)
			SetEntityVisible(ped,true,false)
		end)
	end
end)

-- COLOCAR ROUPA DE PRISIONEIRO
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		if prisioneiro then
			local ped = PlayerPedId()
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				SetPedComponentVariation(ped,1,-1,0,0)
				SetPedComponentVariation(ped,2,21,0,0)
				SetPedComponentVariation(ped,3,2,0,1)
				SetPedComponentVariation(ped,4,64,6,1)
				SetPedComponentVariation(ped,5,-1,0,0)
				SetPedComponentVariation(ped,6,5,2,1)
				SetPedComponentVariation(ped,7,-1,0,0)
				SetPedComponentVariation(ped,8,15,0,2)
				SetPedComponentVariation(ped,9,-1,0,0)
				SetPedComponentVariation(ped,10,-1,0,0)
				SetPedComponentVariation(ped,11,238,0,1)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				SetPedComponentVariation(ped,1,-1,0,0)
				SetPedComponentVariation(ped,2,74,0,0)
				SetPedComponentVariation(ped,3,11,0,1)
				SetPedComponentVariation(ped,4,66,6,1)
				SetPedComponentVariation(ped,5,-1,0,0)
				SetPedComponentVariation(ped,6,5,0,1)
				SetPedComponentVariation(ped,7,-1,0,0)
				SetPedComponentVariation(ped,8,6,0,2)
				SetPedComponentVariation(ped,9,-1,0,0)
				SetPedComponentVariation(ped,10,-1,0,0)
				SetPedComponentVariation(ped,11,117,0,1)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		if prisioneiro then
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),694.99,121.25,80.76,true)
			if distance >= 60 then
				SetEntityCoords(PlayerPedId(),712.08,111.49,80.76)
				TriggerEvent("Notify","aviso","O agente penitenciário encontrou você tentando escapar.")
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if prisioneiro then
			idle = 5
			local distance01 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),670.02,101.05,80.76,true)
			local distance02 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),699.67,144.17,80.76,true)

			if GetEntityHealth(PlayerPedId()) <= 100 then
				reducaopenal = false
				vRP._DeletarObjeto()
			end

			if distance01 <= 100 and not reducaopenal then
				DrawMarker(21,670.02,101.05,80.76,0,0,0,0,180.0,130.0,1.0,1.0,0.5,255,255,255,100,1,0,0,1)
				if distance01 <= 1.2 then
					drawTxt("PRESSIONE  ~r~E~w~  PARA PEGAR A CAIXA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						reducaopenal = true
						ResetPedMovementClipset(PlayerPedId(),0)
						SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
						vRP._CarregarObjeto("anim@heists@box_carry@","idle","hei_prop_heist_box",50,28422)
					end
				end
			end

			if distance02 <= 100 and reducaopenal then
				DrawMarker(21,699.67,144.17,80.76,0,0,0,0,180.0,130.0,1.0,1.0,0.5,255,255,255,100,1,0,0,1)
				if distance02 <= 1.2 then
					drawTxt("PRESSIONE  ~r~E~w~  PARA ENTREGAR A CAIXA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						reducaopenal = false
						TriggerServerEvent("diminuirpena1372391")
						vRP._DeletarObjeto()
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if reducaopenal then
			idle = 5
			BlockWeaponWheelThisFrame()
			DisableControlAction(0,21,true)
			DisableControlAction(0,24,true)
			DisableControlAction(0,25,true)
			DisableControlAction(0,58,true)
			DisableControlAction(0,263,true)
			DisableControlAction(0,264,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,141,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,143,true)
			DisableControlAction(0,75,true)
			DisableControlAction(0,22,true)
			DisableControlAction(0,32,true)
			DisableControlAction(0,268,true)
			DisableControlAction(0,33,true)
			DisableControlAction(0,269,true)
			DisableControlAction(0,34,true)
			DisableControlAction(0,270,true)
			DisableControlAction(0,35,true)
			DisableControlAction(0,271,true)
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,166,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,167,true)
			DisableControlAction(0,177,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,344,true)
			DisableControlAction(0,29,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,245,true)
			DisableControlAction(0,246,true)
			DisableControlAction(0,303,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,188,true)
		end
		Citizen.Wait(idle)
	end
end)

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


RegisterKeyMapping('vrp:algema_fenix', 'Algemar', 'keyboard', 'G')

RegisterCommand('vrp:algema_fenix', function()
	if not IsPedInAnyVehicle(PlayerPedId()) then
		TriggerServerEvent("vrp_policia:algemar")
	end
end, false)

RegisterKeyMapping('vrp:carregar_fenix', 'Carregar', 'keyboard', 'H')

RegisterCommand('vrp:carregar_fenix', function()
	if not IsPedInAnyVehicle(PlayerPedId()) then
		TriggerServerEvent("vrp_policia:carregar")
	end
end, false)


-----------------------------------------------------------------------------------------------------------------------------------------
-- ANDAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("homem",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_m@confident")
	end
end)

RegisterCommand("mulher",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_f@heels@c")
	end
end)

RegisterCommand("depressivo",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_m@depressed@a")
	end
end)

RegisterCommand("depressiva",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_f@depressed@a")
	end
end)

RegisterCommand("empresario",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_m@business@a")
	end
end)

RegisterCommand("determinado",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_m@brave@a")
	end
end)

RegisterCommand("descontraido",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_m@casual@a")
	end
end)

RegisterCommand("farto",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_m@fat@a")
	end
end)

RegisterCommand("estiloso",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_m@hipster@a")
	end
end)

RegisterCommand("ferido",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_m@injured")
	end
end)

RegisterCommand("nervoso",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_m@hurry@a")
	end
end)

RegisterCommand("desleixado",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_m@hobo@a")
	end
end)

RegisterCommand("infeliz",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_m@sad@a")
	end
end)

RegisterCommand("musculoso",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_m@muscle@a")
	end
end)

RegisterCommand("desligado",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_m@shadyped@a")
	end
end)

RegisterCommand("fadiga",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_m@buzzed")
	end
end)

RegisterCommand("apressado",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_m@hurry_butch@a")
	end
end)

RegisterCommand("descolado",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_m@money")
	end
end)

RegisterCommand("corridinha",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_m@quick")
	end
end)

RegisterCommand("piriguete",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_f@maneater")
	end
end)

RegisterCommand("petulante",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_f@sassy")
	end
end)

RegisterCommand("arrogante",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_f@arrogant@a")
	end
end)

RegisterCommand("bebado",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_m@drunk@slightlydrunk")
	end
end)

RegisterCommand("bebado2",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_m@drunk@verydrunk")
	end
end)

RegisterCommand("bebado3",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_m@drunk@moderatedrunk")
	end
end)

RegisterCommand("irritado",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_m@fire")
	end
end)

RegisterCommand("intimidado",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_m@intimidation@cop@unarmed")
	end
end)

RegisterCommand("poderosa",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_f@handbag")
	end
end)

RegisterCommand("chateado",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_f@injured")
	end
end)

RegisterCommand("estilosa",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_f@posh@")
	end
end)

RegisterCommand("sensual",function(source,args)
	if not prisioneiro then
		vRP.loadAnimSet("move_f@sexy@a")
	end
end)