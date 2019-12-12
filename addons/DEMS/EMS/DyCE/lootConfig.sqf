
DyCE_Loot_aiUniform = 
[
	"U_O_Wetsuit",
	"U_O_GhillieSuit",
	"U_O_CombatUniform_oucamo",
	"U_I_OfficerUniform",
	"U_I_CombatUniform_tshirt",
	"U_O_PilotCoveralls",
	"U_OG_Guerilla3_2",
	"U_O_CombatUniform_ocamo"
];

DyCE_Loot_aiBackpack = 
[
	"B_Carryall_ocamo"
];

DyCE_Loot_aiVest = 
[
	"V_PlateCarrier1_rgr",
	"V_PlateCarrier2_blk",
	"V_PlateCarrierL_CTRG",
	"V_PlateCarrierH_CTRG",
	"V_PlateCarrierIA1_dgtl",
	"V_PlateCarrierGL_mtp",
	"V_PlateCarrierGL_blk",
	"V_PlateCarrierGL_rgr",
	"V_PlateCarrier3_rgr"
];

DyCE_Loot_aiHeadgear =
[
	"H_PilotHelmetFighter_I",
	"H_PilotHelmetHeli_I",
	"H_CrewHelmetHeli_I",
	"H_HelmetO_ocamo",
	"H_HelmetSpecO_blk"
];

DyCE_Loot_aiItems = 
[
	"HandGrenade",
	"HandGrenade",
	"HandGrenade",
	"HandGrenade",
	"HandGrenade",
	"HandGrenade",
	"APERSBoundingMine_Range_Mag",
	"APERSMine_Range_Mag",
	"RPG32_HE_F",
	"Rangefinder",
	"optic_Nightstalker",
	"Rangefinder"
];

/* List of primary weapons for AI
        
	1 - weapon classname
    2 - magazine classname
    3 - number of magazines
    4 - under-barrel grenade round classname if wanted (optional)
    5 - number of under-barrel rounds
	["weapon classname","magazine classname", number of clips, "under-barrel grenade type" (optional), number of under-barrel rounds (optional)]	
*/

DyCE_Loot_aiWeapon = 
[
	["srifle_DMR_03_F","20Rnd_762x51_Mag",7],
	["LMG_Zafir_F","150Rnd_762x54_Box",3],
	["srifle_DMR_05_blk_F","10Rnd_93x64_DMR_05_Mag",7],
	["MMG_01_hex_F","150Rnd_93x64_Mag",3],
	["srifle_GM6_F","5Rnd_127x108_Mag",7],
	["srifle_LRR_F","7Rnd_408_Mag",7],
	["srifle_EBR_F","20Rnd_762x51_Mag",7],
	["srifle_EBR_F","20Rnd_762x51_Mag",7],
	["srifle_EBR_F","20Rnd_762x51_Mag",7],
	["LMG_Mk200_F","200Rnd_65x39_cased_Box",3],
	["LMG_Mk200_F","200Rnd_65x39_cased_Box",3],
	["LMG_Mk200_F","200Rnd_65x39_cased_Box",3],
	["LMG_Mk200_F","200Rnd_65x39_cased_Box",3],
	["LMG_Mk200_F","200Rnd_65x39_cased_Box",3],
	["LMG_Mk200_F","200Rnd_65x39_cased_Box",3],
	["arifle_Katiba_GL_F","30Rnd_65x39_caseless_green",5,"1Rnd_HE_Grenade_shell",3],
	["arifle_MX_GL_F","30Rnd_65x39_caseless_mag",5,"3Rnd_HE_Grenade_shell",3],
	["arifle_MX_GL_F","30Rnd_65x39_caseless_mag",5,"3Rnd_HE_Grenade_shell",3],
	["arifle_MX_GL_F","30Rnd_65x39_caseless_mag",5,"3Rnd_HE_Grenade_shell",3],
	["arifle_MXC_Black_F","30Rnd_65x39_caseless_mag",5]
];

DyCE_Loot_aiOptics = 
[
	"optic_ERCO_khk_F",
	"optic_MRCO",
	"optic_Hamr",
	"optic_ERCO_khk_F",
	"optic_MRCO",
	"optic_Hamr",
	"optic_Nightstalker",
	"optic_DMS"
];

/* List of launchers AI can use
1st value weapon class
2nd value class of clips
3rd value number of clips

{"", "", 0} - means nothing to give
{"launch_RPG7_F", "", 0} - if the second parameter is empty then there will be no charges 
weaponSecondaryBots[] =  */
DyCE_Loot_aiLauncher = 
[
	["","",0],
	["","",0],
	["","",0],
//	["CUP_launch_RPG18","CUP_RPG18_M",1],
	["launch_RPG7_F","RPG7_F",2]
];


/* List of main weapons for bots.
1st value weapon class
2nd value class of clips
3rd value number of clips */
DyCE_Loot_VehicleWeapons =          
[
	["srifle_DMR_03_F","20Rnd_762x51_Mag",7],
	["LMG_Zafir_F","150Rnd_762x54_Box",3],
	["srifle_DMR_05_blk_F","10Rnd_93x64_DMR_05_Mag",7],
	["MMG_01_hex_F","150Rnd_93x64_Mag",3],
	["srifle_GM6_F","5Rnd_127x108_Mag",7],
	["srifle_LRR_F","7Rnd_408_Mag",7],
	["srifle_EBR_F","20Rnd_762x51_Mag",7],
	["srifle_EBR_F","20Rnd_762x51_Mag",7],
	["srifle_EBR_F","20Rnd_762x51_Mag",7],
	["LMG_Mk200_F","200Rnd_65x39_cased_Box",3],
	["LMG_Mk200_F","200Rnd_65x39_cased_Box",3],
	["LMG_Mk200_F","200Rnd_65x39_cased_Box",3],
	["LMG_Mk200_F","200Rnd_65x39_cased_Box",3],
	["LMG_Mk200_F","200Rnd_65x39_cased_Box",3],
	["LMG_Mk200_F","200Rnd_65x39_cased_Box",3],
	["arifle_Katiba_GL_F","30Rnd_65x39_caseless_green",5],
	["arifle_MX_GL_F","30Rnd_65x39_caseless_mag",5],
	["arifle_MX_GL_F","30Rnd_65x39_caseless_mag",5],
	["arifle_MX_GL_F","30Rnd_65x39_caseless_mag",5],
	["arifle_MXC_Black_F","30Rnd_65x39_caseless_mag",5]
];

DyCE_Loot_VehicleItems = ["HandGrenade","HandGrenade","APERSBoundingMine_Range_Mag","Rangefinder","optic_Nightstalker"];
DyCE_Loot_VehicleBackpacks = ["B_Carryall_ocamo"];