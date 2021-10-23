local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

RegisterCommand("raspa", function(source)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.tryGetInventoryItem(user_id, 'raspadinha', 1) then
		TriggerClientEvent('raspa:usar', source)
	else
		TriggerClientEvent('Notify',source,'negado','Você não possui uma raspadinha')
	end
end)

RegisterServerEvent('raspa:win')
AddEventHandler('raspa:win', function()
	local source = source
	local user_id = vRP.getUserId(source)
	-- local array = {750, 640, 510, 0, 50, 300, 600, 1, 2, 10, 25, 90, 60, 65, 3, 290, 345, 691, 81, 329, 70, 20, 4, 5, 465, 470}
	-- local money = array[math.random(26)]
	local money = math.random(10000,50000)
	vRP.giveBankMoney(user_id,money)
	TriggerClientEvent('Notify',source,'sucesso',"Você ganhou R$ <b>"..vRP.format(money).."</b>")
end)