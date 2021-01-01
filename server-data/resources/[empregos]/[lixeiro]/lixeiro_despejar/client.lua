local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("lixeiro_despejar")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local processo = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROCESSO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if not processo then
			local ped = PlayerPedId()
			local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped),-329.38,-1567.74,25.24)
			if distancia <= 2.1 then
				drawTxt("PRESSIONE  ~r~E~w~  PARA DESPEJAR LIXO",4,0.5,0.93,0.50,255,255,255,180)
				if IsControlJustPressed(0,38) then
					if emP.checkPayment() then
						vRP._CarregarObjeto("anim@heists@narcotics@trash","throw_ranged_a","prop_cs_rub_binbag_01",50,28422)
						processo = true
						segundos = 3
						SetTimeout(2000,function()
							vRP._DeletarObjeto()
							vRP._stopAnim(false)
							TriggerServerEvent("trydeleteobj",ObjToNet("prop_cs_rub_binbag_01"))
						end)
					end
				end
			end
		end
		if processo then
			drawTxt("AGUARDE ~r~"..segundos.."~w~ SEGUNDOS ATÉ FINALIZAR O DESPEJO DO LIXO",4,0.5,0.93,0.50,255,255,255,180)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if processo then
			if segundos > 0 then
				segundos = segundos - 1
				if segundos == 0 then
					processo = false
					TriggerEvent('cancelando',false)
				end
			end
		end
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