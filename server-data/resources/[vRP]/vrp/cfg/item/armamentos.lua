local items = {}

local nomes = {
	Knife = "Faca",
	Dagger = "Adaga",
	Knuckle = "Soco-Inglês",
	Machete = "Machete",
	Switchblade = "Canivete",
	Wrench = "Chave de Grifo",
	Hammer = "Martelo",
	Golfclub = "Taco de Golf",
	Crowbar = "Pé de Cabra",
	Hatchet = "Machado",
	Flashlight = "Lanterna",
	Bat = "Taco de Beisebol",
	Bottle = "Garrafa",
	Battleaxe = "Machado de Batalha",
	Poolcue = "Taco de Sinuca",
	Stone_hatchet = "Machado de Pedra",
	Pistol = "M1911",
	Gadget_parachute = "Paraquedas",
	Combatpistol = "Glock 19",
	Appistol = "Koch VP9",
	Carbinerifle = "AR-15",
	SpecialCarbine = "G36x",
	Smg = "MP5",
	Pumpshotgun_mk2 = "Remington 870",
	Stungun = "Tazer",
	Nightstick = "Cassetete",
	Snspistol = "HK P7M10",
	Microsmg = "Uzi",
	Sawnoffshotgun = "Mossberg 500",
	Assaultrifle = "AK-103",
	Assaultrifle_mk2 = "AK-47",
	Bullpuprifle_mk2 = "Famas",
	Fireextinguisher = "Extintor",
	Flare = "Sinalizador",
	Machinepistol = "Tec-9",
	Revolver = "Magnum 44",
	Revolver_mk2 = "Magnum 357",
	Pistol_mk2 = "FN Five Seven",
	Vintagepistol = "M1922",
	Assaultsmg = "MTAR-21",
	Musket = "Mosin Nagant",
	Gusenberg = "Thompson",
	Combatpdw = "Sig Sauer MPX",
	Heavysniper = "M82",
	Bzgas = "Granada",
	Petrolcan = "Galão de Gasolina",
	Raypistol = "Pistola ADMIN",
	Specialcarbine_mk2 = "G36C",
	Smg_mk2 = "MP5-MK2",
	Minismg = "CZ Scorpion",
	Carbinerifle_mk2 = "M4A1",
	Ball = "Bolinha de PET"
}

local get_wname = function(weapon_id)
	local name = string.gsub(weapon_id,"WEAPON_","")
	name = string.upper(string.sub(name,1,1))..string.lower(string.sub(name,2))
	return nomes[name]
end

local wammo_name = function(args)
	if args[2] == "WEAPON_PETROLCAN" then
		return "Combustível"
	else
		return "Munição de "..get_wname(args[2])
	end
end

local wbody_name = function(args)
	return get_wname(args[2])
end

items["wbody"] = { wbody_name,5 }
items["wammo"] = { wammo_name,0.03 }

return items