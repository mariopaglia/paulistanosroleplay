local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","nav_nubank")

vRPbanking = {}

Tunnel.bindInterface("nav_nubank",vRPbanking)
Proxy.addInterface("nav_nubank",vRPbanking)

RegisterServerEvent('bank:deposit128317')
AddEventHandler('bank:deposit128317', function(amount)
	local thePlayer = source
	
	local user_id = vRP.getUserId(thePlayer)
	local walletMoney = vRP.getMoney(user_id)
	local bankMoney = vRP.getBankMoney(user_id)
	if(tonumber(amount))then
		if(vRP.tryPayment(user_id, amount))then
			vRP.setBankMoney(user_id, bankMoney+amount)
			vRP.setMoney(user_id, walletMoney-amount)
			TriggerClientEvent("Notify",thePlayer,"sucesso","Depositou <b>$"..vRP.format(parseInt(amount)).." dólares</b> na sua conta bancária.")
		else
			TriggerClientEvent("Notify",thePlayer,"negado","Você não tem dinheiro suficiente.")
		end
	else
		TriggerClientEvent("Notify",thePlayer,"negado","Número inválido.")
	end
end)


RegisterServerEvent('bank:withdraw128317')
AddEventHandler('bank:withdraw128317', function(amount)
	local thePlayer = source
	
	local user_id = vRP.getUserId(thePlayer)
	local walletMoney = vRP.getMoney(user_id)
	local bankMoney = vRP.getBankMoney(user_id)
	if(tonumber(amount))then	
		amount = tonumber(amount)
		if(amount > 0 and amount <= bankMoney)then
			vRP.setBankMoney(user_id, bankMoney-amount)
			vRP.setMoney(user_id, walletMoney+amount)
			TriggerClientEvent("Notify",thePlayer,"sucesso","Sacou <b>$"..vRP.format(parseInt(amount)).." dólares</b> da sua conta bancária.")
		else
			TriggerClientEvent("Notify",thePlayer,"negado","Não possui <b>$"..vRP.format(parseInt(amount)).." dólares</b> em sua conta bancária.")
		end
	else
		TriggerClientEvent("Notify",thePlayer,"negado","Número inválido.")
	end
end)

RegisterServerEvent('bank:balance128317')
AddEventHandler('bank:balance128317', function()
	local thePlayer = source
	
	local user_id = vRP.getUserId(thePlayer)
	local bankMoney = vRP.getBankMoney(user_id)
	TriggerClientEvent('currentbalance1', thePlayer, bankMoney)
end)

RegisterServerEvent('bank:transfer128317')
AddEventHandler('bank:transfer128317', function(to, amount)
	local thePlayer = source
	local user_id = vRP.getUserId(thePlayer)
	if(tonumber(to)  and to ~= "" and to ~= nil)then
		to = tonumber(to)
		theTarget = vRP.getUserSource(to)
		if(theTarget)then
			if(thePlayer == theTarget)then
				TriggerClientEvent("Notify",thePlayer,"negado","Não pode transferir para você mesmo.")
			else
				if(tonumber(amount) and tonumber(amount) > 0 and amount ~= "" and amount ~= nil)then
					amount = tonumber(amount)
					bankMoney = vRP.getBankMoney(user_id)
					if(bankMoney >= amount)then
						newBankMoney = tonumber(bankMoney - amount)
						vRP.setBankMoney(user_id, newBankMoney)
						vRP.giveBankMoney(to, amount)
						TriggerClientEvent("Notify",thePlayer,"sucesso","Você transferiu <b>$"..vRP.format(parseInt(amount)).." dólares</b> para" ..GetPlayerName(theTarget))
						TriggerClientEvent("Notify",theTarget,"sucesso","Transferencia Efetuada <b>$"..vRP.format(parseInt(amount)).." dólares</b> para" ..GetPlayerName(thePlayer))
					else
						TriggerClientEvent("Notify",thePlayer,"negado","Você não tem dinheiro suficiente.")
					end
				else
					TriggerClientEvent("Notify",thePlayer,"negado","Passaporte inválido.")
				end
			end
		else
			TriggerClientEvent("Notify",thePlayer,"importante","Passaporte não encontrado ou indisponível no momento.")
		end
	else
		TriggerClientEvent("Notify",thePlayer,"negado","Número inválido.")
	end
end)