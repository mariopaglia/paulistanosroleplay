local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

local reward = {77,160}
local rndResult = math.random(1,1)

RegisterServerEvent('damn_lixeiro:rewardTrash')
AddEventHandler('damn_lixeiro:rewardTrash', function(farm)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)

	local x,y = table.unpack(reward)
	local rewardValue = math.random(x, y)
	vRP.giveMoney(user_id,rewardValue)
	wait(5000)
	TriggerClientEvent("Notify",source,"sucesso","Você recebeu R$"..rewardValue.."")
end)