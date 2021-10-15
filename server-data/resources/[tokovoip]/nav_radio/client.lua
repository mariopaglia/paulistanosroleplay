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
	if data == "policia1" then
		if emP.checkPermission2("policia.permissao","Polícia 01") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1000)
		end
	elseif data == "staff" then
		if emP.checkPermission2("staff.permissao","STAFF") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1001)
		end
	elseif data == "policia2" then
		if emP.checkPermission2("policia.permissao","Polícia 02") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1002)
		end
	elseif data == "triade" then
		if emP.checkPermission2("triade.permissao","Triade") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1004)
		end
	elseif data == "samu" then
		if emP.checkPermission2("paramedico.permissao","Hospital") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1005)
		end
	elseif data == "policia3" then
		if emP.checkPermission2("policia.permissao","Polícia 03") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1006)
		end	
	elseif data == "fenixcustoms" then
		if emP.checkPermission2("mecanico.permissao","Fenix Customs") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1007)
		end		
	elseif data == "verdes" then
		if emP.checkPermission2("verdes.permissao","Verdes") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1008)
		end	
	elseif data == "vermelhos" then
		if emP.checkPermission2("vermelhos.permissao","Vermelhos") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1009)
		end	
	elseif data == "roxos" then
		if emP.checkPermission2("roxos.permissao","Roxos") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1010)
		end	
	elseif data == "cosanostra" then
		if emP.checkPermission2("cn.permissao","Cosanostra") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1012)
		end		
	elseif data == "yakuza" then
		if emP.checkPermission2("yakuza.permissao","Yakuza") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1013)
		end
	elseif data == "salieris" then
		if emP.checkPermission2("salieris.permissao","Salieri's") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1014)
		end			
	elseif data == "laranjas" then
		if emP.checkPermission2("laranjas.permissao","Laranjas") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1016)
		end			
	elseif data == "sinaloa" then
		if emP.checkPermission2("sinaloa.permissao","Sinaloa") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1017)
		end			
	elseif data == "irmandade" then
		if emP.checkPermission2("irmandade.permissao","Irmandade") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1018)
		end			
	elseif data == "taxista" then
		if emP.checkPermission2("taxista.permissao","Taxistas") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1015)
		end	
	elseif data == "judiciario" then
		if emP.checkPermission2("judiciario.permissao","Judiciario") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(1019)
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
        local radio = parseInt(args[1])
        if radio <= 999 then
            if emP.checkRadio() then
                outServers()
                    exports.tokovoip_script:addPlayerToRadio(radio)
                    TriggerEvent("Notify","sucesso","Você entrou na Frequência <b>"..radio.."</b> do rádio.",8000)
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