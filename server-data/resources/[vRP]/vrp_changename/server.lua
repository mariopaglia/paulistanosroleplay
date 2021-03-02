local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPNclient = Tunnel.getInterface("vrp_changename","vrp_changename")

vRPN = {}
Tunnel.bindInterface("vrp_changename",vRPN)
Proxy.addInterface("vrp_changename",vRPN)

vRP.prepare("vRP/update_user_first_spawn","UPDATE vrp_user_identities SET firstname = @firstname, name = @name, age = @age WHERE user_id = @user_id")



RegisterServerEvent("hoppe:changename")
AddEventHandler("hoppe:changename",function(characterNome,characterSobrenome,characterAge)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.request(source,"Deseja mesmo trocar seus dados por um valor de R$ 100.000?",30) then
			if characterNome and characterSobrenome and characterAge then
				if vRP.tryFullPayment(user_id,100000) then
					vRP.execute("vRP/update_user_first_spawn",{ user_id = user_id, firstname = characterSobrenome, name = characterNome, age = characterAge })
					TriggerClientEvent("Notify",source, "sucesso", "Nome alterado para <b>"..characterNome.." "..characterSobrenome.."</b>, <b>"..characterAge.."</b> anos")
				else
					TriggerClientEvent("Notify",source, "negado", "Você não possui dinheiro.")
				end
			else
				TriggerClientEvent("Notify",source, "negado", "Formato inválido, use o exemplo: <b>/identidade Roberto Nascimento 28</b>")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETAR O PERSONAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('resetplayer',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	if user_id then
		if vRPNclient.isNearCds(source, vector3(-552.88,-192.14,38.23), 13) then
			if vRP.request(source,"Deseja mesmo resetar sua aparência por um valor de R$ 200.000?",30) then
				if vRP.tryFullPayment(user_id,200000) then
					local nplayer = vRP.getUserSource(parseInt(user_id))
                	local id = vRP.getUserId(nplayer)
        	    	vRP.kick(nplayer,"Aparência resetada, entre novamente!")
        	    	vRP.setUData(id,"vRP:spawnController",json.encode(1))
        	    	vRP.setUData(id,"vRP:currentCharacterMode",json.encode(1))
					vRP.setUData(id,"vRP:tattoos",json.encode(1))
				else
					TriggerClientEvent("Notify",source, "negado", "Dinheiro insuficiente!")
				end
			end
		else
			TriggerClientEvent("Notify",source, "negado", "Vá até a prefeitura para resetar sua aparência")
		end
    end
end)

function checkregister()
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if identity.name == "" and identity.firstname == "" then
		return true
	elseif identity.name == "Individuo" and identity.firstname == "Indigente" then
		return true
	else
		return false
	end		
end	