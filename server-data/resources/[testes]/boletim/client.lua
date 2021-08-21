local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = Tunnel.getInterface("boletim")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS 
-----------------------------------------------------------------------------------------------------------------------------------------
local servico = false
local processo = false

-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS DOS BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
local pegarBlips = {
	{ ['x'] = -563.69, ['y'] = -126.71, ['z'] = 37.9 }, -- -97.22,1013.48,235.79 (DP perto da Jojo)
	{ ['x'] = 441.21, ['y'] = -981.09, ['z'] = 30.69 }, -- 441.02,-981.13,30.69 (DP da Praça)
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		for k,v in pairs(pegarBlips) do
			if not servico then
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
				local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
				local pegarBlips = pegarBlips[k]

				if distance <= 5 then
					idle = 10
					DrawText3Ds(pegarBlips.x,pegarBlips.y,pegarBlips.z+0.10,"~w~[~o~E~w~] ~w~PARA REGISTRAR UM BOLETIM DE OCORRENCIA")
					-- DrawMarker(21,pegarBlips.x, pegarBlips.y, pegarBlips.z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
					if distance <= 1.2 then
						-- drawTxt("PRESSIONE  ~r~E~w~  PARA FAZER UM BOLETIM DE OCORRENCIA",4,0.5,0.93,0.50,255,255,255,180)
						if IsControlJustPressed(0,38) then
							if emP.Boletim() then
								print("1")
								TriggerEvent("Notify","sucesso","Sua ocorrência foi registrada com sucesso!")
							end
						end
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
-- function drawTxt(text,font,x,y,scale,r,g,b,a)
-- 	SetTextFont(font)
-- 	SetTextScale(scale,scale)
-- 	SetTextColour(r,g,b,a)
-- 	SetTextOutline()
-- 	SetTextCentre(1)
-- 	SetTextEntry("STRING")
-- 	AddTextComponentString(text)
-- 	DrawText(x,y)
-- end

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