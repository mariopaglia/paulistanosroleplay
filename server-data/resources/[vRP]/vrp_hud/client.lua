local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP")
HUDserver = Tunnel.getInterface("vrp_client", "vrp_client")
vRPhud = {}

Tunnel.bindInterface("vrp_client",vRPhud)
Proxy.addInterface("vrp_client",vRPhud)


-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local hour = 0
local minute = 0
local segundos = 0
local month = ""
local dayOfMonth = 0
local voice = 2
-- local voiceDisplay = "<span style='color:white'><img class='microfone' src='img/mic.png'> Normal</span>"
local proximity = 3.0
local CintoSeguranca = false
local ExNoCarro = false
local sBuffer = {}
local vBuffer = {}
local displayValue = false
local gasolina = 0
local started = true


local menu_celular = false
RegisterNetEvent("status:celular")
AddEventHandler("status:celular",function(status)
	menu_celular = status
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- DATA E HORA
-----------------------------------------------------------------------------------------------------------------------------------------
function CalculateTimeToDisplay()
	hour = GetClockHours()
	minute = GetClockMinutes()
	if hour <= 9 then
		hour = "0" .. hour
	end
	if minute <= 9 then
		minute = "0" .. minute
	end
end
function CalculateDateToDisplay()
	month = GetClockMonth()
	dayOfMonth = GetClockDayOfMonth()
	if month == 0 then
		month = "Janeiro"
	elseif month == 1 then
		month = "Fevereiro"
	elseif month == 2 then
		month = "Março"
	elseif month == 3 then
		month = "Abril"
	elseif month == 4 then
		month = "Maio"
	elseif month == 5 then
		month = "Junho"
	elseif month == 6 then
		month = "Julho"
	elseif month == 7 then
		month = "Agosto"
	elseif month == 8 then
		month = "Setembro"
	elseif month == 9 then
		month = "Outubro"
	elseif month == 10 then
		month = "Novembro"
	elseif month == 11 then
		month = "Dezembro"
	end
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)	
		CalculateTimeToDisplay()
		CalculateDateToDisplay()
	end
end)

AddEventHandler("playerSpawned",function()
	NetworkSetTalkerProximity(proximity)
	started = true
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		setVoice()
	end
end)
function setVoice()
	NetworkSetTalkerProximity(proximity)
	NetworkClearVoiceChannel()
end

-- RegisterKeyMapping('voice:change', '[V] voice change', 'keyboard', 'HOME')

-- RegisterCommand('voice:change',function(source, args, rawCommand)
-- 	if proximity == 3.0 then
-- 		-- voiceDisplay = "<span style='color:white'><img class='microfone' src='img/mic2.png'> Sussurro</span>"
-- 		proximity = 30.0
-- 	elseif proximity == 30.0 then
-- 		-- voiceDisplay = "<span style='color:white'><img class='microfone' src='img/mic3.png'>Gritando</span>"
-- 		proximity = 10.0
-- 	elseif proximity == 10.0 then
-- 		-- voiceDisplay = "<span style='color:white'><img class='microfone' src='img/mic.png'> Normal</span>"
-- 		proximity = 3.0
-- 	end
-- 	setVoice()
-- end)

Citizen.CreateThread(function()
    local currSpeed = 0.0
    local cruiseSpeed = 999.0
    local cruiseIsOn = false
    local seatbeltIsOn = false
	while true do
		Citizen.Wait(100)
		ped = PlayerPedId()
		health = (GetEntityHealth(ped)-100)/300*100
		armor = GetPedArmour(ped)
		local x,y,z = table.unpack(GetEntityCoords(ped,false))
		local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z))

		-- print(NetworkGetTalkerProximity())
		HideHudComponentThisFrame( 1 ) -- Wanted Stars
		HideHudComponentThisFrame( 2 ) -- Weapon Icon
		HideHudComponentThisFrame( 3 ) -- Cash
		HideHudComponentThisFrame( 4 ) -- MP Cash
		HideHudComponentThisFrame( 6 ) -- Vehicle Name
		HideHudComponentThisFrame( 7 ) -- Area Name
		HideHudComponentThisFrame( 8 ) -- Vehicle Class
		HideHudComponentThisFrame( 9 ) -- Street Name
		HideHudComponentThisFrame( 13 ) -- Cash Change
		HideHudComponentThisFrame( 17 ) -- Save Game
		HideHudComponentThisFrame( 20 ) -- Weapon Stats

		HideHudComponentThisFrame( 5 ) -- Weapon Stats-- P
		

		if IsPedInAnyVehicle(ped) then
			DisplayRadar(true)
			inCar  = true
			PedCar = GetVehiclePedIsIn(ped)
			speed = math.ceil(GetEntitySpeed(PedCar) * 3.6)
			rpm = GetVehicleCurrentRpm(PedCar)
			nsei,baixo,alto = GetVehicleLightsState(PedCar)
			if baixo == 1 and alto == 0 then
				farol = 1
			elseif  alto == 1 then
				farol = 2
			else
				farol = 0
			end
			-- print(farol)
			if GetEntitySpeed(PedCar) == 0 and GetVehicleCurrentGear(PedCar) == 0  then
				marcha = "P"
			elseif GetEntitySpeed(PedCar) ~= 0 and GetVehicleCurrentGear(PedCar) == 0  then
				marcha = "R"
			else
				marcha = GetVehicleCurrentGear(PedCar)
			end
		 	gasolina = GetVehicleFuelLevel(PedCar)
			VehIndicatorLight = GetVehicleIndicatorLights(PedCar)
			if(VehIndicatorLight == 0) then
				piscaEsquerdo = false
				piscaDireito = false
			elseif(VehIndicatorLight == 1) then
				piscaEsquerdo = true
				piscaDireito = false
			elseif(VehIndicatorLight == 2) then
				piscaEsquerdo = false
				piscaDireito = true
			elseif(VehIndicatorLight == 3) then
				piscaEsquerdo = true
				piscaDireito = true
			end	
		else	
			inCar  = false
			PedCar = 0
			speed = 0
			rpm = 0
			marcha = 0
			cruiseIsOn = false
			VehIndicatorLight = 0
			if menu_celular then
				DisplayRadar(true)
			else
				DisplayRadar(false)
			end
		end
		SendNUIMessage({
			show = show,
			incar = inCar,
			speed = speed,
			rpm = rpm,
			gear = marcha,
			heal = health,
			armor = armor,
			dia = dayOfMonth,
			mes = month,
			hora = hour,
			minuto = minute,
			-- voz = voiceDisplay,
			piscaEsquerdo = piscaEsquerdo,
			piscaDireito = piscaDireito,
			gas = gasolina,
			cinto = CintoSeguranca,
			farol = farol,
			cruise = cruiseIsOn,
		 	display = displayValue,
		 	rua = street
		});
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CINTO DE SEGURANÇA
-----------------------------------------------------------------------------------------------------------------------------------------
IsCar = function(veh)
	local vc = GetVehicleClass(veh)
	return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
  end
  
  Fwv = function (entity)
	local hr = GetEntityHeading(entity) + 90.0
	if hr < 0.0 then
	  hr = 360.0 + hr
	end
	hr = hr * 0.0174533
	return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
  end
  
  local segundos = 0
  
  Citizen.CreateThread(function()
	while true do
	local idle = 1000
  
	  if inCar then
		idle = 5
		local ped = PlayerPedId()
		local car = GetVehiclePedIsIn(ped)
  
		if car ~= 0 and (ExNoCarro or IsCar(car)) then
		  ExNoCarro = true
  
		  if CintoSeguranca then
			DisableControlAction(0,75)
		  end
  
		  sBuffer[2] = sBuffer[1]
		  sBuffer[1] = GetEntitySpeed(car)
  
		  if sBuffer[2] ~= nil and not CintoSeguranca and GetEntitySpeedVector(car,true).y > 1.0 and sBuffer[1] > 10.25 and (sBuffer[2] - sBuffer[1]) > (sBuffer[1] * 0.255) then
			local co = GetEntityCoords(ped)
			local fw = Fwv(ped)
			SetEntityHealth(ped,GetEntityHealth(ped)-150)
			SetEntityCoords(ped,co.x+fw.x,co.y+fw.y,co.z-0.47,true,true,true)
			SetEntityVelocity(ped,vBuffer[2].x,vBuffer[2].y,vBuffer[2].z)
			segundos = 20
		  end
  
		  vBuffer[2] = vBuffer[1]
		  vBuffer[1] = GetEntityVelocity(car)
  
		  if IsControlJustReleased(1,47) then
			TriggerEvent("cancelando",true)
			if CintoSeguranca then
			  TriggerEvent("vrp_sound:source",'unbelt',0.5)
			  SetTimeout(500,function()
				CintoSeguranca = false
				TriggerEvent("cancelando",false)
			  end)
			else
			  TriggerEvent("vrp_sound:source",'belt',0.5)
				SetTimeout(500,function()
				  CintoSeguranca = true
				  TriggerEvent("cancelando",false)
				end)
			  end
  
			end
		elseif ExNoCarro then
		  ExNoCarro = false
		  CintoSeguranca = false
		  sBuffer[1],sBuffer[2] = 0.0,0.0
		end
	  end
	  Citizen.Wait(idle)
	end
  end)


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- setas Sound
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300)
		if VehIndicatorLight == 1 or VehIndicatorLight == 2 or VehIndicatorLight == 3 then
			TriggerEvent('vrp_sound:source','setas1', 0.9)
			Citizen.Wait(300)
			TriggerEvent('vrp_sound:source','setas2', 0.9)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Oculta o hud quando pausa
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
  while true do
      Citizen.Wait(100)
      	if started then 
	      if IsPauseMenuActive() or menu_celular then
	         displayValue = false
	      else
	         displayValue = true
	      end
	  	end
  end
end)

