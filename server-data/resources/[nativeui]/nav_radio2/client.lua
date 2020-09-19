local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("nav_radio")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end

RegisterNetEvent("radio:outServers")
AddEventHandler("radio:outServers",function()
    outServers()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		if emP.checkRadio2() then
		outServers()
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "PMESP" then
		if emP.checkPermission2("policia.permissao","PMESP") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1020)
		end
	elseif data == "PCESP" then
		if emP.checkPermission2("policia.permissao","PCESP") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1021)
		end
	elseif data == "Federal" then
		if emP.checkPermission2("policia.permissao","Federal") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1022)
		end
	elseif data == "paramedico" then
		if emP.checkPermission2("paramedico.permissao","Paramédicos") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1024)
		end
	elseif data == "mecanico" then
		if emP.checkPermission2("mecanico.permissao","Mecânicos") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1025)
		end
	elseif data == "pcc" then
		if emP.checkPermission2("pcc.permissao","PCC") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1026)
		end	
	elseif data == "vagos" then
		if emP.checkPermission2("cv.permissao","Vagos") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1027)
		end		
	elseif data == "families" then
		if emP.checkPermission2("tcp.permissao","Families") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1028)
		end	
	elseif data == "marabunta" then
		if emP.checkPermission2("marabunta.permissao","Marabunta") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1029)
		end	
	elseif data == "vanila" then
		if emP.checkPermission2("vanilla.permissao","Vanilla") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1030)
		end
	elseif data == "corleone" then
		if emP.checkPermission2("corleone.permissao","Corleone") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1031)
		end		
	elseif data == "mafia" then
		if emP.checkPermission2("mafia.permissao","Máfia") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1032)
		end		
	elseif data == "serpentes" then
		if emP.checkPermission2("serpentes.permissao","Serpentes") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1033)
		end
	elseif data == "motoclub" then
		if emP.checkPermission2("motoclub.permissao","Motoclub") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1034)
		end			
	elseif data == "cosanostra" then
		if emP.checkPermission2("cosanostra.permissao","Cosanostra") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1035)
		end	
	elseif data == "desconectar" then
		outServers()
		TriggerEvent("Notify","sucesso","Desconectou de todos os canais.")
	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("radio",function(source,args)
    if emP.checkRadio() then
        ToggleActionMenu()
	end
end)

RegisterCommand("radiof",function(source,args)
	if args[1] then
		if parseInt(args[1]) < 1017 then
        	if emP.checkRadio() then
				if emP.checkPermission() then
                	outServers()
                	exports.tokovoip_script:addPlayerToRadio(parseInt(args[1]))
					TriggerEvent("Notify","sucesso","Você entrou na Frequência <b>"..args[1].."</b> do rádio.",8000)
				end
			end
		else
			TriggerEvent("Notify","negado","Você não tem permissão.")
		end
    end
end)

RegisterCommand("radiod",function(source,args)
    if emP.checkRadio() then
		if emP.checkPermission() then
			outServers()
		    TriggerEvent("Notify","sucesso","Você desconectou de todos os canais.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTSERVERS
-----------------------------------------------------------------------------------------------------------------------------------------
function outServers()
	local i = 0
    while i < 1036 do
      if exports.tokovoip_script:isPlayerInChannel(i) == true then
		exports.tokovoip_script:removePlayerFromRadio(i)
	  end	
      i = i + 1
    end
end