local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("emp_cacador")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local pedlist = {}
local progress = false
local segundos = 0
local selectnpc = nil

local functions = {
	[1] = { hash = 1457690978, item = "corda", nome = "Corda" },
	[2] = { hash = 402729631, item = "corda", nome = "Corda" },
	[3] = { hash = -1430839454, item = "corda", nome = "Corda" },
	[4] = { hash = -664053099, item = "corda", nome = "Corda" },
	[5] = { hash = -541762431, item = "corda", nome = "Corda" },
	[6] = { hash = 1682622302, item = "corda", nome = "Corda" },
	[7] = { hash = 1318032802, item = "corda", nome = "Corda" },
	[8] = { hash = 307287994, item = "corda", nome = "Corda" },
	[9] = { hash = -832573324, item = "corda", nome = "Corda" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROCESSO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		local random,npc = FindFirstPed()
		repeat
			local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped),GetEntityCoords(npc),true)
			if IsPedDeadOrDying(npc) and not IsPedAPlayer(npc) and distancia <= 1.5 and not IsPedInAnyVehicle(ped) and not IsPedInAnyVehicle(npc) and not selectnpc and not pedlist[npc] then
				for k,v in pairs(functions) do
					if GetEntityModel(npc) == v.hash then
						drawTxt("PRESSIONE  ~r~E~w~  PARA RETIRAR CARNE ANIMAL",4,0.5,0.93,0.50,255,255,255,180)
						if IsControlJustPressed(0,38) then
							if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_KNIFE") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_DAGGER") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MACHETE") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SWITCHBLADE") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_HATCHET") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_BATTLEAXE") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_STONE_HATCHET") then
								quantidade = math.random(1,3)
								if emP.checkPayment(v.item,quantidade) then
									selectnpc = npc
									pedlist[npc] = true
									segundos = 6
									--vRP._playAnim(false,{{"amb@medic@standing@kneel@idle_a","idle_a"}},true)
									vRP._playAnim(false,{{"anim@gangops@facility@servers@bodysearch@","player_search"}},true)
									
									SetEntityHeading(ped,GetEntityHeading(npc))
									TriggerServerEvent("trydeleteped",PedToNet(npc))
									TriggerEvent('cancelando',true)

									repeat
										Citizen.Wait(10)
									until not selectnpc

									vRP._stopAnim(false)
									vRP._DeletarObjeto()
									concluido = true
								end
							else
								TriggerEvent("Notify","aviso","Voce precisa de uma <b>faca</b>!")
							end
						end
					end
				end
			end
			concluido,npc = FindNextPed(random)
		until not concluido
		EndFindPed(random)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TEXTO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if segundos > 0 then
			drawTxt("AGUARDE ~r~"..segundos.."~w~ SEGUNDOS ATÉ FINALIZAR A RETIRADA DA CARNE",4,0.5,0.93,0.50,255,255,255,180)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIMINUINDO O TEMPO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if segundos > 0 then
			segundos = segundos - 1
			if segundos == 0 then
				selectnpc = nil
				TriggerEvent('cancelando',false)
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