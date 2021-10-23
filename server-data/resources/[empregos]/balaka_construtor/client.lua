--FEITO POR Balaka#9918
--FEITO POR Balaka#9918
--FEITO POR Balaka#9918

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("balaka_construtor")
job = Tunnel.getInterface("balaka_construtor")

local servico = false
local locais = 0
local processo = false
local tempo = 0
local animacao = false
local parte = 0 
----------------------------------------------------------------------------------
-- LOCS 
----------------------------------------------------------------------------------
local construtor = {
	[1] = { ['x'] = 83.5, ['y'] = -374.11, ['z'] = 41.54 },
	[2] = { ['x'] = 125.28, ['y'] = -350.97, ['z'] = 42.91 },
	[3] = { ['x'] = 58.46, ['y'] = -351.64, ['z'] = 42.53 },
	[4] = { ['x'] = 56.35, ['y'] = -401.68, ['z'] = 39.93 }, 
	[5] = { ['x'] = 64.1, ['y'] = -427.65, ['z'] = 37.4 },
	[6] = { ['x'] = 93.33, ['y'] = -422.4, ['z'] = 37.56 },
	[7] = { ['x'] = 49.94, ['y'] = -457.43, ['z'] = 40.18 },
	[8] = { ['x'] = 65.87, ['y'] = -416.7, ['z'] = 37.4 },
	[9] = { ['x'] = 63.93, ['y'] = -383.72, ['z'] = 39.93 },
	[10] = { ['x'] = 33.65, ['y'] = -409.04, ['z'] = 39.93 },
	[11] = { ['x'] = 22.9, ['y'] = -356.16, ['z'] = 39.39 },
	[12] = { ['x'] = 41.57, ['y'] = -358.1, ['z'] = 42.53 },
	[13] = { ['x'] = 79.75, ['y'] = -340.68, ['z'] = 42.7 },
	[14] = { ['x'] = 132.18, ['y'] = -349.81, ['z'] = 43.07 },
	[15] = { ['x'] = 139.57, ['y'] = -385.86, ['z'] = 43.26 },
	[16] = { ['x'] = 137.73, ['y'] = -404.57, ['z'] = 40.96 },
	[17] = { ['x'] = 79.63, ['y'] = -422.42, ['z'] = 37.56 },
	[18] = { ['x'] = 70.55, ['y'] = -406.66, ['z'] = 37.56 },
	[19] = { ['x'] = 66.59, ['y'] = -407.65, ['z'] = 39.92 }

}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEGAR TRABALHO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local balaka = 1000
		local x2,y2,z2 = 141.64,-379.77,43.26
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x2,y2,z2,true)
		if distance < 5 then
			balaka = 5
			DrawText3D(x2,y2,z2 + 0.5,"~w~PRESSIONE ~r~E ~w~PARA INICIAR O SERVIÇO")
			if not servico then
				if distance < 1 then
					if IsControlJustPressed(0, 38) then
						TriggerEvent("Notify","aviso","Você entrou em serviço")
						ColocarRoupa()
					    TriggerEvent("Notify","importante","Pegue todos os materias para começar a trabalhar!")
						servico = true
						locais = 1
						parte = 1
						CriandoBlip(construtor,locais)
					end
				end
			end
		end
	Citizen.Wait(balaka)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLETAR MATERIAL 
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local balaka = 1000
		if servico and parte == 1 then
			local x,y,z = 104.53,-403.25,41.26
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
			if distance <= 5 then 
				balaka = 5
                  DrawText3D(x,y,z + 0.5,"PRESSIONE ~r~E ~w~PARA PEGAR OS EQUIPAMENTOS")
		        if IsControlJustPressed(0, 38) then
		        	animacao = true
		        	if animacao then
		        		SetEntityHeading(ped,152.54)
		        		vRP._playAnim(false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
		        		Desabilitar()
		            	TriggerEvent("progress",10000,"Coletando Equipamento")
					 	Citizen.Wait(10000)
						vRP.stopAnim(false)
						animacao = false
						if emP.giveFerramenta() then
					 		--print('recebido')		
						end
					end	    
                end
		    end                   
		end
	Citizen.Wait(balaka)
	end
end)	
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSERTAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local balaka = 1000
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))  
			local bowz,cdz = GetGroundZFor_3dCoord(construtor[locais].x,construtor[locais].y,construtor[locais].z)
			local distance = GetDistanceBetweenCoords(construtor[locais].x,construtor[locais].y,cdz,x,y,z,true)
			if distance < 200 then
				DrawText3D(construtor[locais].x,construtor[locais].y,construtor[locais].z + 0.5,"~r~E ~w~   CONSERTAR")
				balaka = 1
				if distance < 5 then
					balaka = 5
					if IsControlJustPressed(0, 38) then
						TriggerEvent("progress",10000,"Consertando")
						RemoveBlip(blips)
						animacao = true
						if animacao then
							vRP._playAnim(false,{{"amb@world_human_hammering@male@base","base"}},true)
							Desabilitar()
							Citizen.Wait(10000)
							vRP.stopAnim(false)
							emP.checkPayment()
							animacao = false
							if locais == #construtor then
								locais = 1
							else
								locais = math.random(1,19)
							end
						  		CriandoBlip(construtor,locais)
							--end
						end	
					end	
				end
			end
		end
	Citizen.Wait(balaka)
	end
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- FINALIZAR SERVIÇO
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand("finalizar",function(source,args)
-- 	local x2,y2,z2 = 141.16,-380.02,43.26
-- 	local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x2,y2,z2,true)
-- 	if distance <= 5 then 
-- 		TriggerEvent("Notify","aviso","Você saiu de serviço")
-- 		servico = false
-- 		TriggerEvent('cancelando',false)
-- 		RemoveBlip(blips)
-- 		MainRoupa()
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINALIZAR SERVIÇO 2
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if IsControlJustPressed(0,168) and servico then
			TriggerEvent("Notify","aviso","Você saiu de serviço")
			servico = false
			TriggerEvent('cancelando',false)
			RemoveBlip(blips)
			MainRoupa()
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function CriandoBlip(construtor,locais)
	blips = AddBlipForCoord(construtor[locais].x,construtor[locais].y,construtor[locais].z)
	SetBlipSprite(blips,402)
	SetBlipColour(blips,0)
	SetBlipScale(blips,0.5)
	SetBlipAsShortRange(blips,false)
	BeginTextCommandSetBlipName("STRING")
	EndTextCommandSetBlipName(blips)
end

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end

function Fade(time)
	DoScreenFadeOut(800)
	Wait(time)
	DoScreenFadeIn(800)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUPA 
-----------------------------------------------------------------------------------------------------------------------------------------
function FadeRoupa(time,tipo,idle_copy)
	DoScreenFadeOut(800)
	Wait(time)
	if tipo == 1 then 
		vRP.setCustomization(idle_copy)
	else
		TriggerServerEvent("balaka_construtor:roupa")
	end
	DoScreenFadeIn(800)
end

local RoupaConstrutor = {
	["Construtor"] = { --homem
		[1885233650] = {                                    
			[1] = {0,0,2},
			[2] = {21,0,0},
			[3] = {63,0,1},
			[4] = {122,0,1},
			[5] = {-1,0,2},
			[6] = {25,0,1},
			[7] = {0,0,2},
			[8] = {59,0,2},
			[9] = {44,0,2},
			[10] = {-1,0,2},
			[11] = {56,0,1},
			["p0"] = {145,0},
			["p2"] = {-1,0},
			["p1"] = {2,0},
			["p6"] = {-1,0},
			[0] = {0,0,0},
			["p7"] = {-1,0},						
        },
        [-1667301416] = {  --mulher
			[1] = {0,0,2},
			[2] = {74,0,0},
			[3] = {83,0,1},
			[4] = {128,0,1},
			[5] = {0,0,2},
			[6] = {25,0,1},
			[7] = {0,0,2},
			[8] = {36,0,2},
			[9] = {0,0,2},
			[10] = {0,0,2},
			[11] = {49,0,2},
			[0] = {0,0,0},
			["p2"] = {-1,0},
			["p1"] = {-1,0},
			["p7"] = {-1,0},
			["p0"] = {144,0},
			["p6"] = {-1,0},
        }
	}
}

function ColocarRoupa() 
	if vRP.getHealth() > 101 then --não colocar roupa morto
		if not vRP.isHandcuffed() then
			local custom = RoupaConstrutor["Construtor"]
			if custom then
				local old_custom = vRP.getCustomization()
				local idle_copy = {}

				idle_copy = job.SaveIdleCustom(old_custom)
				idle_copy.modelhash = nil

				for l,w in pairs(custom[old_custom.modelhash]) do
						idle_copy[l] = w
				end
				FadeRoupa(1200,1,idle_copy)
			end
		end
	end
end

function MainRoupa() --não tirar a roupa morto
	if vRP.getHealth() > 101 then
		if not vRP.isHandcuffed() then
	        FadeRoupa(1200,2)
	    end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESABILITAR F6 NAS ANIMAÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function Desabilitar()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1)
			if animacao then
				BlockWeaponWheelThisFrame()
				DisableControlAction(0,16,true)
				DisableControlAction(0,17,true)
				DisableControlAction(0,24,true)
				DisableControlAction(0,25,true)
				DisableControlAction(0,38,true)
				DisableControlAction(0,29,true)
				DisableControlAction(0,56,true)
				DisableControlAction(0,57,true)
				DisableControlAction(0,73,true)
				DisableControlAction(0,166,true)
				DisableControlAction(0,167,true)
				DisableControlAction(0,170,true)				
				DisableControlAction(0,182,true)	
				DisableControlAction(0,187,true)
				DisableControlAction(0,188,true)
				DisableControlAction(0,189,true)
				DisableControlAction(0,190,true)
				DisableControlAction(0,243,true)
				DisableControlAction(0,245,true)
				DisableControlAction(0,257,true)
				DisableControlAction(0,288,true)
				DisableControlAction(0,289,true)
				DisableControlAction(0,344,true)		
			end	
		end
	end)
end


