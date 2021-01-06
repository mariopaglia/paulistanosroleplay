local weaponstoadd = {
"WEAPON_RAYPISTOL",
"GADGET_PARACHUTE",
"WEAPON_ASSAULTRIFLE_MK2",
"WEAPON_SPECIALCARBINE_MK2",
"WEAPON_SMG_MK2",
"WEAPON_PISTOL_MK2",
"WEAPON_CARBINERIFLE_MK2",
"WEAPON_CARBINERIFLE",
"WEAPON_COMBATPDW",
"WEAPON_COMBATPISTOL",
}

RegisterCommand("arma", function(source, args)
     for _, weapons in pairs(weaponstoadd) do
          GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(weapons), 999, false, false)
     end
end)