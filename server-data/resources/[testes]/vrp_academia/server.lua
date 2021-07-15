--[[ FEITO POR UtinhaSz#3339 CASO QUEIRA SUPORTE , COMPRE ]]

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPs = {}

vRPsclient = Tunnel.getInterface("vrp_academia","vrp_academia")
Tunnel.bindInterface("vrp_academia",vRPs)
vRPclient = Tunnel.getInterface("vRP","vrp_academia")

local reward2 = math.random(3,4)
local maxXp = 90
local gastmoney = math.random(5,10)

RegisterNetEvent('vrp_academia:exerciseGym2')
AddEventHandler('vrp_academia:exerciseGym2', function()
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local xpAtual = vRP.getExperience(user_id,"backpack")
	if parseInt(xpAtual) <= parseInt(maxXp) then
		vRP.setExperience(user_id, "backpack", parseInt(xpAtual) + parseInt(reward2))
		vRP.fullPayment(user_id,gastmoney)
		TriggerClientEvent("Notify",source,"importante","<b>Você gastou <b>R$"..vRP.format(gastmoney).." reais</b> para utilizar a academia</b>",5000)
		return true 
	else 
		TriggerClientEvent("Notify",source,"negado","Você não tem <b>R$"..vRP.format(gastmoney).." reais</b>",5000)
		 return false 
     end 
end)