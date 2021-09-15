local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_desmanche",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkVehicle()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vnetid,placa,vname,lock,banned,work = vRPclient.vehList(source,7)
		local mPrice = vRPclient.ModelName2(source)
		if vehicle and placa then
			local puser_id = vRP.getUserByRegistration(placa)
			if puser_id == nil then
				TriggerClientEvent("Notify",source,"negado","Veículo encontra-se clonado e não pode ser desmanchado",8000)
				return
			end
			if puser_id then
				local vehicle = vRP.query("creative/get_vehicles",{ user_id = parseInt(puser_id), vehicle = vname })
				if #vehicle <= 0 then
					TriggerClientEvent("Notify",source,"importante","Veículo não encontrado na lista do proprietário",8000)
						return
					end
					if parseInt(vehicle[1].detido) == 1 then
						TriggerClientEvent("Notify",source,"aviso","Veículo encontra-se apreendido na seguradora",8000)
						return
					end
					if banned then
						TriggerClientEvent("Notify",source,"negado","Veículos de serviço ou alugados não podem ser desmanchados",8000)
						return
					end
				end
			return true
		end
	end
end

function emP.addGroup()
	local source = source
	local user_id = vRP.getUserId(source)
	vRP.addUserGroup(user_id,"Desmanche")
end

function emP.removeGroup()
	local source = source
	local user_id = vRP.getUserId(source)
	vRP.removeUserGroup(user_id,"Desmanche")
end

function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"desmanche.permissao")
end

function emP.checkItem()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"listadesmanche") >= 1 then
		vRP.tryGetInventoryItem(user_id,"listadesmanche",1)
		return true
	else
		TriggerClientEvent("Notify",source,"negado","Você necessita de <b>1 x Maçarico</b> para realizar o desmanche",5000)
	end
end