local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","cs_acoes")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
vRPN = {}
Tunnel.bindInterface("cs_acoes",vRPN)
Proxy.addInterface("cs_acoes",vRPN)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE
-----------------------------------------------------------------------------------------------------------------------------------------   
vRP._prepare("sRP/add_ammunation","INSERT INTO vrp_acoes(id,valor,alta,baixa,fecha) VALUES(@id,@valor,@alta,@baixa,@fecha)")
vRP._prepare("sRP/compra_acao","INSERT INTO bolsa_jogador(user_id,valor) VALUES(@user_id,@valor)")
vRP._prepare("sRP/vende_acao","DELETE FROM bolsa_jogador WHERE user_id = @user_id")
vRP._prepare("vRP/ver_moedas", "SELECT valor FROM bolsa_jogador WHERE user_id = @user_id")
-----------------------------------------------------------------------------------------------------------------------------------------  


function random(srcIdentifier)
	local valortotal = math.random(-100,100)
	if ammunation == undefined then
		ammunation = 10000
	else
	ammunation = valortotal + ammunation
	end
end


RegisterServerEvent('bolsa:upd')
AddEventHandler('bolsa:upd', function()
		local user_id = vRP.getUserId(source)
		local id = 0
		local idteste = 1
		random(srcIdentifier)
		local valor = ammunation
		local alta = valor + math.random(0,20)
		local baixa = valor + math.random(-20,0)
		fecha = ammunation + math.random(-100,100)
			vRP.execute("sRP/add_ammunation",{ id = parseInt(id), valor = valor, alta = alta, baixa = baixa, fecha = fecha})
end)


RegisterServerEvent('bolsa:comprar')
AddEventHandler('bolsa:comprar', function()
	local source = source
	local user_id 	 = vRP.getUserId(source)
	user_id = parseInt(user_id)
	getbankmoney 	 = vRP.getBankMoney(user_id)
	if user_id then
		local rows = vRP.query("vRP/ver_moedas", {user_id = user_id})
		local valor = ammunation
		if #rows == 0 then
			if vRP.tryFullPayment(user_id,parseInt(valor)) then
				vRP.execute("sRP/compra_acao",{ user_id = user_id, valor = valor})
				TriggerClientEvent('Notify',source,'sucesso','Ação comprada com sucesso!')
			else 
				TriggerClientEvent('Notify',source,'negado','Dinheiro insuficiente!')
			end
		else
			local txt = rows[1].valor
			TriggerClientEvent('Notify',source,'negado','Você já possui uma ação!')
		end
	end
end)

RegisterServerEvent('bolsa:saldo')
AddEventHandler('bolsa:saldo', function()
	local source = source
	local user_id 	 = vRP.getUserId(source)
	user_id = parseInt(user_id)
	getbankmoney 	 = vRP.getBankMoney(user_id)
	if user_id then
		local rows = vRP.query("vRP/ver_moedas", {user_id = user_id})
		if #rows == 0 then
			saldo = 0
		else
		local valor = ammunation
		valoratual = parseFloat(rows[1].valor)
		saldo =  valoratual - ammunation
		end
	end
end)

RegisterServerEvent('bolsa:vender')
AddEventHandler('bolsa:vender', function()
	local source = source
	local user_id 	 = vRP.getUserId(source)
	getbankmoney 	 = vRP.getBankMoney(user_id)
	if user_id then
		local rows = vRP.query("vRP/ver_moedas", {user_id = user_id})
		local valor = ammunation
		if #rows > 0 then
			vRP.giveMoney(user_id,parseInt(valor))
			vRP.execute("sRP/vende_acao",{ user_id = user_id})
			TriggerClientEvent('Notify', source, 'sucesso', 'Ação vendida com sucesso por <b>R$ '..vRP.format(parseInt(valor))..'</b>')
			saldo = 0
		else
			TriggerClientEvent('Notify',source,'negado','Você não tem uma ação!')
		end
	end
end)

function vRPN.cs_acoes()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local saldo = saldo
		local valor = ammunation
			return vRP.format(parseInt(saldo)),vRP.format(parseInt(valor))
	end
end



