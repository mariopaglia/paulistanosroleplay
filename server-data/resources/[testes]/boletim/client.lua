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
	{ ['x'] = -563.69, ['y'] = -126.71, ['z'] = 37.9 }, -- -97.22,1013.48,235.79 (Bratva)
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

				if distance <= 3 then
					idle = 5
					DrawMarker(21,pegarBlips.x, pegarBlips.y, pegarBlips.z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
					if distance <= 1.2 then
						drawTxt("PRESSIONE  ~r~E~w~  PARA FAZER UM BOLETIM DE OCORRENCIA",4,0.5,0.93,0.50,255,255,255,180)
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