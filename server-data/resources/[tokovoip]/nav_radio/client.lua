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
		if emP.checkPermission2("policia.permissao","Polícia Militar - C1") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(190)
		end
	elseif data == "policia2" then
		if emP.checkPermission2("policia.permissao","Polícia Militar - C2") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(189)
		end
	elseif data == "rota" then
		if emP.checkPermission2("policia.permissao","ROTA") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(188)
		end
	elseif data == "pcsp" then
		if emP.checkPermission2("policia.permissao","Polícia Civil") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(187)
		end	
	elseif data == "prf" then
		if emP.checkPermission2("policia.permissao","Polícia Rodoviária Federal") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(186)
		end
	elseif data == "samu" then
		if emP.checkPermission2("paramedico.permissao","Hospital (SAMU)") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(192)
		end
	elseif data == "bennys" then
		if emP.checkPermission2("mecanico.permissao","Bennys (Mecânicos)") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(185)
		end	
	elseif data == "sportrace" then
		if emP.checkPermission2("mecanico.permissao","SportRace (Mêcanicos)") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(184)
		end		
	elseif data == "pcc" then
		if emP.checkPermission2("pcc.permissao","PCC") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(110)
		end	
	elseif data == "cv" then
		if emP.checkPermission2("cv.permissao","CV") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(120)
		end	
	elseif data == "tcp" then
		if emP.checkPermission2("tcp.permissao","TCP") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(130)
		end
	elseif data == "motoclub" then
		if emP.checkPermission2("motoclub.permissao","Motoclub") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(140)
		end		
	elseif data == "cosanostra" then
		if emP.checkPermission2("cn.permissao","Cosanostra") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(150)
		end		
	elseif data == "yakuza" then
		if emP.checkPermission2("yakuza.permissao","Yakuza") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(160)
		end
	elseif data == "bratva" then
		if emP.checkPermission2("bratva.permissao","Bratva") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(170)
		end			
	elseif data == "taxista" then
		if emP.checkPermission2("taxista.permissao","Taxistas") then
			outServers()
			exports.tokovoip_script:addPlayerToRadio(191)
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

local blacklist = {
  [188] = { ['perm'] = "permisao" },
  [189] = { ['perm'] = "permisao" },
  [190] = { ['perm'] = "policia.permissao" }
}

RegisterCommand("radiof",function(source,args)
    if args[1] then
        local radio = parseInt(args[1])
        if radio < 1017 then
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