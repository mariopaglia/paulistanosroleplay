local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
func = {}
Tunnel.bindInterface("vrp_trafico",func)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkPermission(perm)
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,perm)
end

local src = {
	[1] = { ['re'] = "pecadearma", ['reqtd'] = 5, ['item'] = "armacaodearma", ['itemqtd'] = 1 },
	[2] = { ['re'] = "armacaodearma", ['reqtd'] = 5, ['item'] = "wbody|WEAPON_ASSAULTSMG", ['itemqtd'] = 1 },
	[3] = { ['re'] = "armacaodearma", ['reqtd'] = 7, ['item'] = "wbody|WEAPON_ASSAULTRIFLE", ['itemqtd'] = 1 },
	[4] = { ['re'] = "armacaodearma", ['reqtd'] = 3, ['item'] = "wbody|WEAPON_GUSENBERG", ['itemqtd'] = 1 },
	[5] = { ['re'] = "armacaodearma", ['reqtd'] = 1, ['item'] = "wbody|WEAPON_PISTOL_MK2", ['itemqtd'] = 1 },

	[6] = { ['re'] = "pecadearma", ['reqtd'] = 5, ['item'] = "armacaodearma", ['itemqtd'] = 1 },
	[7] = { ['re'] = "armacaodearma", ['reqtd'] = 5, ['item'] = "wammo|WEAPON_ASSAULTSMG", ['itemqtd'] = 1 },
	[8] = { ['re'] = "armacaodearma", ['reqtd'] = 7, ['item'] = "wammo|WEAPON_ASSAULTRIFLE", ['itemqtd'] = 1 },
	[9] = { ['re'] = "armacaodearma", ['reqtd'] = 3, ['item'] = "wammo|WEAPON_GUSENBERG", ['itemqtd'] = 1 },
	[10] = { ['re'] = "armacaodearma", ['reqtd'] = 1, ['item'] = "wammo|WEAPON_PISTOL_MK2", ['itemqtd'] = 1 },
--	[] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "ITEM", ['itemqtd'] =  },

}

function func.checkPayment(id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if src[id].re ~= nil then
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(src[id].item)*src[id].itemqtd <= vRP.getInventoryMaxWeight(user_id) then
				if vRP.tryGetInventoryItem(user_id,src[id].re,src[id].reqtd,false) then
					vRP.giveInventoryItem(user_id,src[id].item,src[id].itemqtd,false)
					return true
				end
			end
		else
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(src[id].item)*src[id].itemqtd <= vRP.getInventoryMaxWeight(user_id) then
				vRP.giveInventoryItem(user_id,src[id].item,src[id].itemqtd,false)
				return true
			end
		end
	end
end