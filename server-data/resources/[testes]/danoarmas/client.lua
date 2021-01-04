----------------------------------------------------------------------------
--DANO ARMAS (E SOCO) MELEE ///// MELEE AND WEAPONS DAMAGE 
----------------------------------------------------------------------------
--------------------------
-- FUZIS = 3.5 DE DANO  --
-- SMGS = 2.5 DE DANO   --
-- PISTOLAS 3.0 DE DANO --
--------------------------
Citizen.CreateThread(function()
    while true do
	    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.2) 
    	Wait(0)
    	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"), 0.2) 
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PUMPSHOTGUN_MK2"), 0.0) 
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_HEAVYSHOTGUN"), 0.0) 
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ASSAULTRIFLE"), 0.0)
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BULLPUPRIFLE"), 0.0)
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SPECIALCARBINE"), 0.0)
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ASSAULTRIFLE_MK2"), 3.5) -- AK-47
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_CARBINERIFLE_MK2"), 3.5) -- M4A1
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SPECIAlCARBINE_MK2"), 3.5) -- G36
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_CARBINERIFLE"), 3.5) -- AR-15
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_COMBATPISTOL"), 3.0) -- GLOCK
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MACHINEPISTOL"), 0.0)
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_COMBATPDW"), 2.5) -- SIGSAUER
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SMOKEGRENADE"), 0.0)
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_APPISTOL"), 0.0)
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL"), 0.0)
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_REVOLVER"), 0.0)
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_VINTAGEPISTOL"), 0.0)
		Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SMG_MK2"), 2.5) -- MP5-MK2
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SMG"), 0.0)
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ASSAULTSMG"), 0.0)
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MICROSMG"), 0.0)
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MG"), 3.0)
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_HEAVYSNIPER"), 0.0)
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SNIPERRIFLE"), 0.0)
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SAWNOFFSHOTGUN"), 0.0)
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_DBSHOTGUN"), 0.0)
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL_MK2"), 3.0) -- FIVE-SEVEN
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL50"), 0.0)
    	Wait(0)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_RAYPISTOL"), 0.0)
    	Wait(0)
    end
end)
----------------------------------------------------------------------------
--DANO CORONHADA //// PISTOL WHIPPING
----------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
	local ped = PlayerPedId()
        if IsPedArmed(ped, 6) then
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
        end
    end
end)
