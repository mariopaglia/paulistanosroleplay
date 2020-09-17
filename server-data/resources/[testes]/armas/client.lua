local weaponstoadd = {
"WEAPON_PISTOL",
"WEAPON_ASSAULTRIFLE",
"WEAPON_ASSAULTSMG",
"WEAPON_PISTOL_MK2",
"WEAPON_MICROSMG",
"WEAPON_CARBINERIFLE",
"WEAPON_PUMPSHOTGUN_MK2",
"WEAPON_COMBATPDW",
"WEAPON_SMG",
"WEAPON_APPISTOL",
}

RegisterCommand("arma", function(source, args)
     for _, weapons in pairs(weaponstoadd) do
          GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(weapons), 999, false, false)
     end
end)