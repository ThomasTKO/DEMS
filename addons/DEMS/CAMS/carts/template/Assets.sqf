// Assets.sqf
// TEMPLATE FILE
// TheOneWhoKnocks
// Overwrites the global variables used by FrSB to generate various elements of the system

// Global variables in this file are available to the AI creation and Loot creation portions of FuMS
// Any where you would normally place an item class name, one of these variables may be substituted in its place.
// When FuMS encounters one of these defined arrays, it will select one of the items from the array at random to use
// in the particular application (ie AI Uniform, loot in a box, etc).

private ["_cartContents","_cartName","_debugCart"];


///////////////////////////////////////////////////
// CART config ////////////////////////////////////
///////////////////////////////////////////////////
_cartName = "template"; 	// Change this to match the directory name of the content you are adding
_debugCart = false;		// Setting this to true adds additional info to log for troubleshooting purposes


// Some items are repeated to add a "chance" element.  The more duplicates, the higher chance of spawning, and conversely the lower for others

_cartContents = 
[	
	// Uniforms
	[	
		"CAMS_U_Civ",		// Global variable being adjusted
		4,					// Side this is assigned to 
							// 0 - Code used to combine other global variables (See below)
							// 1 - Everyone can use
							// 2 - Players
							// 3 - AI
							// 4 - Civilian
							// 5 - Military
							// FOR NOW ALL CODES ABOVE DON'T MATTER EXCEPT FOR 0 
							// 0 is used when you are combining other global groups together (See below)
							// The next option determines if this global variable REPLACES (overwrites) existing global variable
							// Onlt one of your CART files should do this ato serve as the base global, for example if you do not
							// remove the vanilla items and instead do a complete replacement (Ex. Unsung, IFA, Star Wars opposition, etc)
							// This allows you to set a base set of resources and then add to them with other cart files
							
		true,				// TRUE - Replaces existing global variable      FALSE - Appends to existing variable
							// NOTE: Everything in this template files is set to true as an example of how to create a base
							// custom content CART.  If this is an add on, set this to FALSE
		[
				// Civilian clothing classnames (CIV)
		]
	],
	[
		"CAMS_U_Soldier",5,true,
		[
			// Soldier uniforms (EAST)
		]	
	],
	[
		"CAMS_U_Guerilla",3,true,
		[
			// Guerilla Uniforms (RESISTANCE)
		]
	],
	[
		"CAMS_U_Ghillie",5,true,
		[
			// Gillie type uniforms
		]
	],
	[
		"CAMS_U_Aviation",5,true,
		[
			// Aviator uniforms
		]
	],
	[
		"CAMS_U_Wetsuit",5,true,
		[
			// Frogman uniforms
		]
	],
	[	
		"CAMS_U_All",0,true,
		[
			// NOTE: By using the 0 code, it tells the system that these are not individual classnames, but actually
			// other global variables that are being appended to each other.  Any time you are creating a global 
			// grouping made up of other global groupings, you need to use this code.
			// This should be left in all files to give you an overarching global group for all types
			"CAMS_U_Civ", "CAMS_U_Soldier", "CAMS_U_Guerilla", "CAMS_U_Ghillie", "CAMS_U_Wetsuit", "CAMS_U_Aviation"
		]
	],
	
	
	
	// Vest / Chest container items
	[
		"CAMS_V_Bandolliers",5,true,
		[
			// Bandollier type vests
		]
	],
	[
		"CAMS_V_Chestrig",5,true,
		[
			// Chest rig type vests
		]
	],
	[
		"CAMS_V_Vests",5,true,
		[
			// Regular Vests
		]
	],
	[
		"CAMS_V_Harness",5,true,
		[
			// Harness type vests
		]
	],
	[
		"CAMS_V_Plate",5,true,
		[
			// Armored plate type vests
		]
	],
	[
		"CAMS_V_Rebreather",5,true,
		[
			// Underwater breathing appratus classnames
		]
	],
	[
		"CAMS_V_All",0,true,
		[
			// NOTE: See the 0 code.  Again, this combines the global variables into a single variable
			"CAMS_V_Bandolliers", "CAMS_V_Chestrig", "CAMS_V_Vests", "CAMS_V_Harness", "CAMS_V_Plate"
		]
	],
	
	
	
		// Head/Hat items
	[
		"CAMS_H_Caps",4,true,
		[
			"H_Cap_blk","H_Cap_blk_Raven","H_Cap_blu","H_Cap_brn_SPECOPS","H_Cap_grn",
			"H_Cap_headphones","H_Cap_khaki_specops_UK","H_Cap_oli","H_Cap_press","H_Cap_red",
			"H_Cap_tan","H_Cap_tan_specops_US"
		]
	],
	[
		"CAMS_H_MilitaryCaps",5,true,
		[
			"H_MilCap_blue","H_MilCap_dgtl","H_MilCap_mcamo","H_MilCap_ocamo","H_MilCap_oucamo","H_MilCap_rucamo"
		]
	],
	[
		"CAMS_H_Beanies",4,true,
		[
			"H_Watchcap_blk","H_Watchcap_camo","H_Watchcap_khk","H_Watchcap_sgg"
		]
	],
	[
		"CAMS_H_Bandannas",3,true,
		[
			"H_Bandanna_camo","H_Bandanna_cbr","H_Bandanna_gry","H_Bandanna_khk",
			"H_Bandanna_khk_hs","H_Bandanna_mcamo","H_Bandanna_sgg","H_Bandanna_surfer"
		]
	],
	[
		"CAMS_H_Boonie",3,true,
		[
			"H_Booniehat_dgtl","H_Booniehat_dirty","H_Booniehat_grn","H_Booniehat_indp",
			"H_Booniehat_khk","H_Booniehat_khk_hs","H_Booniehat_mcamo","H_Booniehat_tan"
		]
	],
	[
		"CAMS_H_Hats",4,true,
		[
			"H_Hat_blue","H_Hat_brown","H_Hat_camo","H_Hat_checker","H_Hat_grey","H_Hat_tan","H_StrawHat",
			"H_StrawHat_dark"
		]
	],
	[
		"CAMS_H_Berets",5,true,
		[
			"H_Beret_02","H_Beret_blk","H_Beret_blk_POLICE","H_Beret_brn_SF","H_Beret_Colonel",
			"H_Beret_grn","H_Beret_grn_SF","H_Beret_ocamo","H_Beret_red"
		]
	],
	[
		"CAMS_H_Shemags",3,true,
		[
			"H_Shemag_khk","H_Shemag_olive","H_Shemag_olive_hs","H_Shemag_tan","H_ShemagOpen_khk",
			"H_ShemagOpen_tan","H_TurbanO_blk"
		]
	],
	[
		"CAMS_H_LightHelmet",5,true,
		[
			"H_HelmetB_light","H_HelmetB_light_black","H_HelmetB_light_desert","H_HelmetB_light_grass",
			"H_HelmetB_light_sand","H_HelmetB_light_snakeskin"
		]
	],
	[
		"CAMS_H_RegHelmet",5,true,
		[
			"H_HelmetIA","H_HelmetIA_camo","H_HelmetIA_net","H_HelmetB","H_HelmetB_black","H_HelmetB_camo",
			"H_HelmetB_desert","H_HelmetB_grass","H_HelmetB_paint","H_HelmetB_plain_blk","H_HelmetB_sand",
			"H_HelmetB_snakeskin"
		]
	],
	[
		"CAMS_H_SuperHelmet",5,true,
		[
			"H_HelmetO_ocamo","H_HelmetO_oucamo","H_HelmetSpecO_blk","H_HelmetSpecO_ocamo",
			"H_HelmetLeaderO_ocamo","H_HelmetLeaderO_oucamo"
		]
	],
	[
		"CAMS_H_SpecOps",5,true,
		[
			"H_HelmetSpecB","H_HelmetSpecB_blk","H_HelmetSpecB_paint1","H_HelmetSpecB_paint2"
		]
	],
	[
		"CAMS_H_Aviation",5,true,
		[
			"H_CrewHelmetHeli_B", "H_CrewHelmetHeli_I", "H_CrewHelmetHeli_O", "H_HelmetCrew_I", "H_HelmetCrew_B",
			"H_HelmetCrew_O", "H_PilotHelmetHeli_B", "H_PilotHelmetHeli_I", "H_PilotHelmetHeli_O",
			"H_PilotHelmetFighter_B", "H_PilotHelmetFighter_I", "H_PilotHelmetFighter_O"
		]
	],
	
	[
		"CAMS_H_Civ",0,true,
		[
			"CAMS_H_Caps", "CAMS_H_Beanies", "CAMS_H_Bandannas", "CAMS_H_Hats"
		]
	],
	[
		"CAMS_H_Hunter",0,true,
		[
			"CAMS_H_Caps", "CAMS_H_Boonie", "CAMS_H_Shemags", "CAMS_H_MilitaryCaps"
		]
	],
	[	
		"CAMS_H_Military",0,true,
		[
			"CAMS_H_MilitaryCaps", "CAMS_H_Berets", "CAMS_H_LightHelmet", "CAMS_H_RegHelmet", "CAMS_H_SuperHelmet", 
			"CAMS_H_SpecOps"
		]
	],
	[
		"CAMS_H_ALL",0,true,
		[
			"CAMS_H_Military", "CAMS_H_Civ", "CAMS_H_Boonie", "CAMS_H_Shemags", "CAMS_H_Aviation"
		]
	],
	
	
	
	// Glasses
	[
		"CAMS_G_Regular",5,true,
		[
			"G_Spectacles","G_Spectacles_Tinted","G_Squares","G_Squares_Tinted"
		]
	],	
	[
		"CAMS_G_Tactical",5,true,
		[
			"G_Aviator","G_B_Diving","G_Combat","G_Combat_Goggles_tna_F",
			"G_Diving","G_Goggles_VR","G_I_Diving","G_Lowprofile","G_O_Diving",
			"G_Tactical_Black","G_Tactical_Clear"
		]
	],
	[
		"CAMS_G_Sport",4,true,
		[
			"G_Sport_BlackWhite","G_Sport_Blackred","G_Sport_Blackyellow",
			"G_Sport_Checkered","G_Sport_Greenblack","G_Sport_Red"
		]
	],
	[
		"CAMS_G_Shades",4,true,
		[
			"G_Shades_Black","G_Shades_Blue","G_Shades_Green","G_Shades_Red"
		]
	],
	[
		"CAMS_G_Lady",4,true,
		[
			"G_Lady_Blue","G_Lady_Dark","G_Lady_Mirror","G_Lady_Red"
		]
	],	
	[
		"CAMS_G_Bandana",3,true,
		[
			"G_Bandanna_aviator","G_Bandanna_beast","G_Bandanna_blk","G_Bandanna_khk","G_Bandanna_oli",
			"G_Bandanna_shades","G_Bandanna_sport","G_Bandanna_tan"
		]
	],
	[
		"CAMS_G_Balaclava",3,true,
		[
			"G_Balaclava_TI_G_blk_F","G_Balaclava_TI_G_tna_F","G_Balaclava_TI_blk_F","G_Balaclava_TI_tna_F",
			"G_Balaclava_blk","G_Balaclava_combat","G_Balaclava_lowprofile","G_Balaclava_oli"
		]
	],

	[
		"CAMS_G_Guer_ALL",0,true,
		[
			"CAMS_G_Regular","CAMS_G_Tactical","CAMS_G_Sport","CAMS_G_Shades", "CAMS_G_Bandana", "CAMS_G_Balaclava"
		]
	],
	[
		"CAMS_G_CIV_ALL",0,true,
		[
			"CAMS_G_Regular","CAMS_G_Sport","CAMS_G_Shades", "CAMS_G_Lady"
		]
	],	
	[
		"CAMS_G_Military_ALL",0,true,
		[
			"CAMS_G_Tactical","CAMS_G_Sport","CAMS_G_Shades"
		]
	],
	[
		"CAMS_G_ALL",0,true,
		[
			"CAMS_G_Regular","CAMS_G_Tactical","CAMS_G_Sport","CAMS_G_Shades", "CAMS_G_Lady", "CAMS_G_Bandana", 
			"CAMS_G_Balaclava"
		]
	],
	
	
	// Weapon attachments
	[
		"CAMS_W_Pointer",1,true,
		[
			"acc_flashlight","acc_pointer_IR"
		]
	],
	[
		"CAMS_W_Bipod",5,true,
		[
			"bipod_01_F_blk","bipod_01_F_mtp","bipod_01_F_snd","bipod_02_F_blk","bipod_02_F_hex",
			"bipod_02_F_tan","bipod_03_F_blk","bipod_03_F_oli"
		]
	],
	[
		"CAMS_W_Muzzle",5,true,
		[
			"muzzle_snds_338_black","muzzle_snds_338_green","muzzle_snds_338_sand",
			"muzzle_snds_93mmg","muzzle_snds_93mmg_tan","muzzle_snds_acp","muzzle_snds_B","muzzle_snds_H",
			"muzzle_snds_H_MG","muzzle_snds_H_SW","muzzle_snds_L","muzzle_snds_M"
		]
	],
	[
		"CAMS_W_OpticsLv1",5,true,
		[
			"optic_Aco","optic_ACO_grn","optic_ACO_grn_smg","optic_Aco_smg","optic_Arco","optic_Holosight",
			"optic_Holosight_smg","optic_Yorris","optic_MRD","optic_MRCO"
		]
	],
	[
		"CAMS_W_OpticsLv2",5,true,
		[
			"optic_LRPS","optic_NVS","optic_SOS"
		]
	],
	[
		"CAMS_W_OpticsLv3",5,true,
		[
			"optic_AMS","optic_AMS_khk","optic_AMS_snd","optic_DMS","optic_Hamr","optic_KHS_blk",
			"optic_KHS_hex","optic_KHS_old","optic_KHS_tan","optic_Nightstalker","optic_tws","optic_tws_mg"
		]
	],
	[
		"CAMS_W_Optics_ALL",0,true,
		[
			"CAMS_W_OpticsLv1", "CAMS_W_OpticsLv2", "CAMS_W_OpticsLv3"
		]
	],
	[
		"CAMS_W_Attachments_ALL",0,true,
		[
			"CAMS_W_Pointer", "CAMS_W_Bipod", "CAMS_W_Muzzle", "CAMS_W_Optics_ALL"
		]
	],
	

	// Navigation and Belt Items
	[
		"CAMS_B_Navigation",5,true,
		[
			"ItemWatch","ItemGPS","ItemMap","ItemCompass","ItemRadio","Binocular",
			"Rangefinder","Laserdesignator","Laserdesignator_02","Laserdesignator_03","NVGoggles",
			"NVGoggles_INDEP","NVGoggles_OPFOR"
		]
	],
	
	// Other Items
	[
		"CAMS_I_Meds",5,true,
		[
			"FirstAidKit"
		]
	],

	// Backpacks
	[
		"CAMS_Packs_Lv1",4,true,
		[
			"B_AssaultPack_blk","B_AssaultPack_cbr","B_AssaultPack_dgtl","B_AssaultPack_khk",
			"B_AssaultPack_mcamo","B_AssaultPack_rgr","B_AssaultPack_sgg","B_OutdoorPack_blk","B_OutdoorPack_blu",
			"B_OutdoorPack_tan"
		]
	],
	[
		"CAMS_Packs_Lv2",5,true,
		[
			"B_FieldPack_blk","B_FieldPack_cbr","B_FieldPack_ocamo","B_FieldPack_oucamo",
			"B_TacticalPack_blk","B_TacticalPack_rgr","B_TacticalPack_ocamo","B_TacticalPack_mcamo",
			"B_TacticalPack_oli","B_Bergen_blk","B_Bergen_mcamo","B_Bergen_rgr","B_Bergen_sgg"
		]
	],
	[
		"CAMS_Packs_Lv3",5,true,
		[
			"B_Kitbag_cbr","B_Kitbag_mcamo","B_Kitbag_sgg","B_Carryall_cbr","B_Carryall_khk",
			"B_Carryall_mcamo","B_Carryall_ocamo","B_Carryall_oli","B_Carryall_oucamo","B_HuntingBackpack"
		]
	],
	[
		"CAMS_Packs_ALL",0,true,
		[
			"CAMS_Packs_Lv1", "CAMS_Packs_Lv2", "CAMS_Packs_Lv3"
		]
	],
	
	// Ammo
	// Setting this in the 'magazine' section of loot configuration (LootData.sqf) will ensure ammo for each weapon specified in the weapon section is also part
	//  of the loot definition.
	/*  MAY REMOVE SINCE THIS IS CORE FUNCTION
		"FuMS_AmmoForEach",1,true,
	[
		"FuMS_AmmoForEach"];
	*/

	// Flares
	[
		"CAMS_Flares_Chemical",4,true,
		[
			"Chemlight_blue","Chemlight_green","Chemlight_red"
		]
	],
	[
		"CAMS_Flares_Normal",4,true,
		[
			"FlareGreen_F","FlareRed_F","FlareWhite_F","FlareYellow_F"
		]
	],
	[
		"CAMS_Flares_1Rnd",5,true,
		[
			"UGL_FlareGreen_F","UGL_FlareRed_F","UGL_FlareWhite_F","UGL_FlareYellow_F"
		]
	],
	[
		"CAMS_Flares_3Rnd",5,true,
		[
			"3Rnd_UGL_FlareGreen_F","3Rnd_UGL_FlareRed_F","3Rnd_UGL_FlareWhite_F","3Rnd_UGL_FlareYellow_F"
		]
	],
	[
		"CAMS_Flares_ALL",0,true,
		[
			"CAMS_Flares_Chemical", "CAMS_Flares_Normal", "CAMS_Flares_1Rnd", "CAMS_Flares_3rnd"
		]
	],

	//Smokes
	[
		"CAMS_Smoke_Shell",5,true,
		[
			"SmokeShell","SmokeShellBlue","SmokeShellGreen","SmokeShellOrange",
			"SmokeShellPurple","SmokeShellRed","SmokeShellYellow"
		]
	],
	[
		"CAMS_Smoke_1Rnd",5,true,
		[
			"1Rnd_Smoke_Grenade_shell","1Rnd_SmokeBlue_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell",
			"1Rnd_SmokeOrange_Grenade_shell","1Rnd_SmokePurple_Grenade_shell","1Rnd_SmokeRed_Grenade_shell",
			"1Rnd_SmokeYellow_Grenade_shell"
		]
	],
	[
		"CAMS_Smoke_3Rnd",5,true,
		[
			"3Rnd_Smoke_Grenade_shell","3Rnd_SmokeBlue_Grenade_shell",
			"3Rnd_SmokeGreen_Grenade_shell","3Rnd_SmokeOrange_Grenade_shell","3Rnd_SmokePurple_Grenade_shell",
			"3Rnd_SmokeRed_Grenade_shell","3Rnd_SmokeYellow_Grenade_shell"
		]
	],
	[
		"CAMS_Smoke_ALL",0,true,
		[
			"CAMS_Smoke_Shell", "CAMS_Smoke_1Rnd", "CAMS_Smoke_3rnd"
		]
	],

	// Explosives
	[
		"CAMS_E_Grenade",5,true,
		[
			"HandGrenade","MiniGrenade"
		]
	],
	[
		"CAMS_E_GrenadeIR",5,true,
		[
			"B_IR_Grenade","O_IR_Grenade","I_IR_Grenade"
		]
	],
	[
		"CAMS_E_1Rnd",5,true,
		[
			"1Rnd_HE_Grenade_shell"
		]
	],
	[
		"CAMS_E_3Rnd",5,true,
		[
			"3Rnd_HE_Grenade_shell"
		]
	],
	[
		"CAMS_E_Mine",5,true,
		[
			"APERSBoundingMine_Range_Mag","APERSMine_Range_Mag","APERSTripMine_Wire_Mag",
			"ClaymoreDirectionalMine_Remote_Mag","SLAMDirectionalMine_Wire_Mag"
		]
	],
	[
		"CAMS_E_IED",5,true,
		[
			"DemoCharge_Remote_Mag","IEDLandBig_Remote_Mag","IEDLandSmall_Remote_Mag","IEDUrbanBig_Remote_Mag",
			"IEDUrbanSmall_Remote_Mag","SatchelCharge_Remote_Mag"
		]
	],
	
	//CAMS_E_Grenade_ALL = CAMS_E_Grenade + CAMS_E_GrenadeIR + CAMS_E_GrenadeStun;
	//CAMS_E_Shell_ALL = CAMS_E_1Rnd + CAMS_E_3Rnd;
	
	[
		"CAMS_E_ALL",0,true,
		[
			"CAMS_E_Grenade", "CAMS_E_GrenadeIR", "CAMS_E_1Rnd", "CAMS_E_3Rnd", "CAMS_E_Mine", "CAMS_E_IED"
		]
	],
	
	// ******* WEAPONS ********************	
	[
		"CAMS_Pistols",4,true,
		[
			"hgun_ACPC2_F","hgun_P07_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F","hgun_Pistol_Signal_F","hgun_Rook40_F"
		]
	],

	[
		"CAMS_SubMGs",3,true,
		[
			"hgun_PDW2000_F","SMG_01_F","SMG_02_F"
		]
	],
	[
		"CAMS_LightMGs",5,true,
		[
			"arifle_MX_SW_Black_F","arifle_MX_SW_F","LMG_Mk200_F","LMG_Zafir_F",
			"MMG_01_hex_F","MMG_01_tan_F","MMG_02_black_F","MMG_02_camo_F","MMG_02_sand_F"
		]
	],
	[
		"CAMS_AssaultRifles",5,true,
		[
			"arifle_Katiba_C_F", "arifle_Katiba_F", "arifle_Katiba_GL_F", "arifle_Mk20_F", "arifle_Mk20_GL_F",
			"arifle_Mk20_GL_plain_F", "arifle_Mk20_plain_F", "arifle_Mk20C_F", "arifle_Mk20C_plain_F",
			"arifle_MX_Black_F", "arifle_MX_F", "arifle_MX_GL_Black_F", "arifle_MX_GL_F", "arifle_MXC_Black_F",
			"arifle_MXC_F", "arifle_SDAR_F", "arifle_TRG20_F", "arifle_TRG21_F", "arifle_TRG21_GL_F"
		]
	],
	[
		"CAMS_SniperRifles",5,true,
		[
			"srifle_DMR_01_F", "srifle_DMR_02_camo_F", "srifle_DMR_02_F", "srifle_DMR_02_sniper_F", 
			"srifle_DMR_03_F", "srifle_DMR_03_khaki_F", "srifle_DMR_03_multicam_F", "srifle_DMR_03_tan_F", 
			"srifle_DMR_03_woodland_F", "srifle_DMR_04_F", "srifle_DMR_04_Tan_F", "srifle_DMR_05_blk_F", 
			"srifle_DMR_05_hex_F", "srifle_DMR_05_tan_f", "srifle_DMR_06_camo_F", "srifle_DMR_06_olive_F", 
			"srifle_EBR_F", "srifle_GM6_camo_F", "srifle_GM6_F", "srifle_LRR_camo_F", "srifle_LRR_F", 
			"arifle_MXM_Black_F", "arifle_MXM_F"
		]
	],
	[
		"CAMS_Rifles_ALL",0,true,
		[
			"CAMS_LightMGs", "CAMS_AssaultRifles", "CAMS_SniperRifles"
		]
	],
	
	[
		"CAMS_Guns_ALL",0,true,
		[
			"CAMS_Rifles_ALL", "CAMS_SubMGs", "CAMS_Pistols"
		]
	],

	// ******* VEHICLES ********************
	//  Water vehicles - Civ / General
	[
		"CAMS_H20_Boats_C",1,true,
		[
			"C_Boat_Civil_01_F ","C_Boat_Civil_01_rescue_F","C_Boat_Civil_01_police_F","C_Boat_Transport_02_F"
		]
	],
	[
		"CAMS_H20_RubberDucks_C",1,true,
		[
			"C_Rubberboat"
		]
	],
	[
		"CAMS_H20_Jetski_C",1,true,
		[
			"C_Scooter_Transport_01_F "
		]
	],
	[
		"CAMS_H20_All_C",0,true,
		[
			"CAMS_H20_Boats_C", "CAMS_H20_RubberDucks_C", "CAMS_H20_SDVs_C", "CAMS_H20_Jetski_C"
		]
	],
	

	// Water Vehicles - West
	[
		"CAMS_H20_Boats_W",1,true,
		[
			"B_Boat_Armed_01_minigun_F"
		]
	],
	[
		"CAMS_H20_RubberDucks_W",1,true,
		[
			"B_Boat_Transport_01_F","B_Lifeboat","B_G_Boat_Transport_01_F"
		]
	],
	[
		"CAMS_H20_SDVs_W",1,true,
		[
			"B_SDV_01_F "
		]
	],

	[
		"CAMS_H20_ALL_W",0,true,
		[
			"CAMS_H20_Boats_W", "CAMS_H20_RubberDucks_W", "CAMS_H20_SDVs_W"
		]
	],	
	
	// Water Vehicles - East
	[
		"CAMS_H20_Boats_E",1,true,
		[
			"O_Boat_Armed_01_hmg_F"
		]
	],
	[
		"CAMS_H20_RubberDucks_E",1,true,
		[
			"O_Boat_Transport_01_F","O_Lifeboat","O_G_Boat_Transport_01_F"
		]
	],
	[
		"CAMS_H20_SDVs_E",1,true,
		[
			"O_SDV_01_F"
		]
	],

	[
		"CAMS_H20_ALL_E",0,true,
		[
			"CAMS_H20_Boats_E", "CAMS_H20_RubberDucks_E", "CAMS_H20_SDVs_E"
		]
	],	
	
	// Water Vehicles - Guer
	[
		"CAMS_H20_Boats_G",1,true,
		[
			"I_Boat_Armed_01_minigun_F "
		]
	],
	[
		"CAMS_H20_RubberDucks_G",1,true,
		[
			"I_Boat_Transport_01_F","I_Boat_Transport_01_F"
		]
	],
	[
		"CAMS_H20_SDVs_G",1,true,
		[
			"I_SDV_01_F"
		]
	],

	[
		"CAMS_H20_ALL_G",0,true,
		[
			"CAMS_H20_Boats_G", "CAMS_H20_RubberDucks_G", "CAMS_H20_SDVs_G"
		]
	],	

	
	[
		"CAMS_Mil_H20_ALL",0,true,
		[
			"CAMS_H20_ALL_W","CAMS_H20_ALL_E","CAMS_H20_ALL_G", "CAMS_H20_ALL_C"
		]
	],
	
	// Helicopters

	[
		"CAMS_Heli_Unarmed_C",1,true,
		[
			"C_Heli_Light_01_civil_F", "C_Heli_light_01_blueLine_F", "C_Heli_light_01_blue_F", "C_Heli_light_01_digital_F", "C_Heli_light_01_elliptical_F", 
			"C_Heli_light_01_furious_F", "C_Heli_light_01_graywatcher_F", "C_Heli_light_01_ion_F", "C_Heli_light_01_jeans_F", "C_Heli_light_01_light_F", 
			"C_Heli_light_01_luxe_F", "C_Heli_light_01_red_F", "C_Heli_light_01_shadow_F", "C_Heli_light_01_sheriff_F", "C_Heli_light_01_speedy_F",
			"C_Heli_light_01_stripped_F", "C_Heli_light_01_sunset_F", "C_Heli_light_01_vrana_F", "C_Heli_light_01_wasp_F", "C_Heli_light_01_wave_F"
		]
	],	
	
	[
		"CAMS_Heli_Unarmed_W",1,true,
		[
			"B_Heli_Light_01_F","B_Heli_Light_01_stripped_F"
		]
	],
	[
		"CAMS_Heli_Armed_W",1,true,
		[
			"B_Heli_Light_01_armed_F","B_Heli_Light_01_dynamicLoadout_F","B_Heli_Attack_01_F","B_Heli_Attack_01_dynamicLoadout_F"
		]
	],
	[
		"CAMS_Heli_Transport_W",1,true,
		[
			"B_Heli_Transport_01_F","B_Heli_Transport_01_camo_F"
		]
	],

	[
		"CAMS_Heli_Unarmed_E",1,true,
		[
			 "O_Heli_Light_02_unarmed_F", "O_Heli_Light_02_dynamicLoadout_F"
		]
	],
	[
		"CAMS_Heli_Armed_E",1,true,
		[
			"O_Heli_Light_02_F", "O_Heli_Light_02_v2_F", "O_Heli_Attack_02_F", "O_Heli_Attack_02_black_F", "O_Heli_Attack_02_dynamicLoadout_F", "O_Heli_Attack_02_dynamicLoadout_black_F"
		]
	],

	[
		"CAMS_Heli_Unarmed_G",1,true,
		[
			"I_Heli_light_03_unarmed_F"
		]
	],
	[
		"CAMS_Heli_Armed_G",1,true,
		[
			"I_Heli_light_03_F","I_Heli_light_03_dynamicLoadout_F"
		]
	],	
	[
		"CAMS_Heli_Transport_G",1,true,
		[
			"I_Heli_Transport_02_F"
		]
	],
	
	
	// Aircraft
	[
		"CAMS_Plane_CAS_W",1,true,
		[
			"B_Plane_CAS_01_F","B_Plane_CAS_01_dynamicLoadout_F","B_UAV_02_dynamicLoadout_F"
		]
	],
	[
		"CAMS_Plane_UAV_W",1,true,
		[
			"B_UAV_02_F","B_UAV_02_CAS_F"
		]
	],

	[
		"CAMS_Plane_CAS_E",1,true,
		[
			"O_Plane_CAS_02_F", "O_Plane_CAS_02_dynamicLoadout_F", "O_UAV_02_CAS_F"
		]
	],
	[
		"CAMS_Plane_UAV_E",1,true,
		[
			"O_UAV_AI", "O_UAV_AI_F", 	//Not sure which works right
			"O_UAV_01_F", "O_UAV_02_F"
		]
	],

	[
		"CAMS_Plane_CAS_G",1,true,
		[
			"I_Plane_Fighter_03_AA_F", "I_Plane_Fighter_03_CAS_F", "I_Plane_Fighter_03_dynamicLoadout_F", "I_UAV_02_CAS_F", "I_UAV_02_dynamicLoadout_F"
		]
	],
	[
		"CAMS_Plane_UAV_G",1,true,
		[
			"I_UAV_01_F", "I_UAV_02_F", "I_UAV_AI", "I_UAV_AI_F"
		]
	],
	
	
	
	
	// Civilian Vehicles
	[
		"CAMS_Civ_Car",1,true,
		[
			"C_Hatchback_01_F", "C_Hatchback_01_beigecustom_F", "C_Hatchback_01_black_F", "C_Hatchback_01_blue_F", "C_Hatchback_01_bluecustom_F", 
			"C_Hatchback_01_dark_F", "C_Hatchback_01_green_F", "C_Hatchback_01_grey_F", "C_Hatchback_01_sport_F", "C_Hatchback_01_sport_blue_F",
			"C_Hatchback_01_sport_green_F", "C_Hatchback_01_sport_grey_F", "C_Hatchback_01_sport_orange_F", "C_Hatchback_01_sport_red_F",
			"C_Hatchback_01_sport_white_F", "C_Hatchback_01_white_F", "C_Hatchback_01_yellow_F"
		]
	],
	[
		"CAMS_Civ_Offroad",1,true,
		[
			"C_Offroad_01_F", "C_Offroad_01_blue_F", "C_Offroad_01_bluecustom_F", "C_Offroad_01_darkred_F", "C_Offroad_01_red_F", 
			"C_Offroad_01_sand_F", "C_Offroad_01_white_F", "C_Offroad_02_unarmed_F", "C_Offroad_02_unarmed_black_F",
			"C_Offroad_02_unarmed_blue_F", "C_Offroad_02_unarmed_green_F", "C_Offroad_02_unarmed_orange_F", "C_Offroad_02_unarmed_red_F",
			"C_Offroad_02_unarmed_white_F", "C_Offroad_default_F", "C_Offroad_luxe_F", "C_Offroad_stripped_F"
		]
	],
	[
		"CAMS_Civ_Transport",1,true,
		[
			"C_Truck_02_covered_F", "C_Truck_02_transport_F"
		]
	],
	[
		"CAMS_Civ_SUV",1,true,
		[
			"C_SUV_01_F"
		]
	],
	[
		"CAMS_Civ_Van",1,true,
		[
			"C_Van_01_box_F", "C_Van_01_box_red_F", "C_Van_01_box_white_F", "C_Van_01_transport_F", "C_Van_01_transport_red_F", "C_Van_01_transport_white_F"
		]
	],
	[
		"CAMS_Civ_Utility",1,true,
		[
			"C_Offroad_01_repair_F", "C_Truck_02_fuel_F", "C_Van_01_fuel_F", "C_Van_01_fuel_red_F", "C_Van_01_fuel_red_v2_F", 
			"C_Truck_02_box_F", "C_Van_01_fuel_white_F", "C_Van_01_fuel_white_v2_F"
		]
	],
	[
		"CAMS_Civ_Toy",1,true,
		[
			"C_Quadbike_01_F", "C_Quadbike_01_black_F", "C_Quadbike_01_blue_F", "C_Quadbike_01_red_F", "C_Quadbike_01_white_F"
		]
	],

	[
		"CAMS_Civ_Work",0,true,
		[
			"CAMS_Civ_Car", "CAMS_Civ_Offroad", "CAMS_Civ_Van"
		]
	],	
	[
		"CAMS_Civ_Truck",0,true,
		[
			"CAMS_Civ_Offroad", "CAMS_Civ_Transport", "CAMS_Civ_SUV", "CAMS_Civ_Van"
		]
	],
	[
		"CAMS_Civ_ALL",0,true,
		[
			"CAMS_Civ_Work", "CAMS_Civ_Truck"
		]
	],	




	//////////////////// West Vehicles


	[
		"CAMS_Mil_ArmedOffroad_W",1,true,
		[
			"B_MRAP_01_gmg_F","B_MRAP_01_hmg_F","B_G_Offroad_01_armed_F","B_G_Offroad_01_AT_F"
		]
	],
	[
		"CAMS_Mil_UnarmedOffroad_W",1,true,
		[
			"B_MRAP_01_F","B_G_Offroad_01_F"
		]
	],
	[
		"CAMS_Mil_UGV_Armed_W",1,true,
		[
			"B_UGV_01_rcws_F"
		]
	],
	[
		"CAMS_Mil_UGV_Unarmed_W",1,true,
		[
			"B_UGV_01_F"
		]
	],
	[
		"CAMS_Mil_Toy_Quad_W",1,true,
		[
			"B_Quadbike_01_F","B_G_Quadbike_01_F"
		]
	],

	[
		"CAMS_Mil_OpenTransport_W",1,true,
		[
			"B_Truck_01_transport_F","B_G_Van_01_transport_F"
		]
	],
	[
		"CAMS_Mil_CoveredTransport_W",1,true,
		[
			"B_Truck_01_covered_F"
		]
	],
	[
		"CAMS_Mil_UtilityVehicle_W",1,true,
		[
			"B_G_Offroad_01_repair_F","B_Truck_01_Repair_F","B_Truck_01_ammo_F","B_Truck_01_fuel_F","B_Truck_01_medical_F",
			"B_Truck_01_mover_F","B_Truck_01_box_F","B_G_Van_01_fuel_F"
		]
	],
	[
		"CAMS_Mil_ArmedTransport_W",1,true,
		[
			"B_APC_Tracked_01_AA_F","B_APC_Tracked_01_CRV_F","B_APC_Tracked_01_rcws_F","B_APC_Wheeled_01_cannon_F","B_APC_Wheeled_03_cannon_F"
		]
	],

	[
		"CAMS_Mil_Tank_W",1,true,
		[
			"B_MBT_01_TUSK_F","B_MBT_01_cannon_F"
		]
	],
	[
		"CAMS_Mil_Artillery_W",1,true,
		[
			"B_MBT_01_arty_F","B_MBT_01_mlrs_F"
		]
	],

	[
		"CAMS_Mil_Transport_ALL_W",0,true,
		[
			"CAMS_Mil_OpenTransport_W", "CAMS_Mil_CoveredTransport_W", "CAMS_Mil_ArmedTransport_W"
		]
	],

	[
		"CAMS_Mil_Unarmed_W",0,true,
		[
			"CAMS_Mil_UnarmedOffroad_W" + "CAMS_Mil_OpenTransport_W" + "CAMS_Mil_CoveredTransport_W"
		]
	],
	[
		"CAMS_Mil_Armed_W",0,true,
		[
			"CAMS_Mil_ArmedOffroads_W" + "CAMS_Mil_ArmedTransport_W"
		]
	],
	[
		"CAMS_Mil_ALL_W",0,true,
		[
			"CAMS_Mil_Unarmed_W" + "CAMS_Mil_Armed_W"
		]
	],

	//////////////////// EAST Vehicles


	[
		"CAMS_Mil_ArmedOffroad_E",1,true,
		[
			"O_MRAP_02_gmg_F", "O_MRAP_02_hmg_F", "O_G_Offroad_01_armed_F", "O_G_Offroad_01_AT_F"
		]
	],
	[
		"CAMS_Mil_UnarmedOffroad_E",1,true,
		[
			"O_MRAP_02_F", "O_G_Offroad_01_F"
		]
	],

	[
		"CAMS_Mil_UGV_Armed_E",1,true,
		[
			"O_UGV_01_rcws_F"
		]
	],
	[
		"CAMS_Mil_UGV_Unarmed_E",1,true,
		[
			"O_UGV_01_F"
		]
	],
	[
		"CAMS_Mil_Toy_Quad_E",1,true,
		[
			"O_Quadbike_01_F", "O_G_Quadbike_01_F"
		]
	],

	[
		"CAMS_Mil_OpenTransport_E",1,true,
		[
			"O_Truck_02_transport_F", "O_G_Van_01_transport_F", "O_T_Truck_03_transport_ghex_F"
		]
	],
	[
		"CAMS_Mil_CoveredTransport_E",1,true,
		[
			"O_Truck_02_covered_F", "O_T_Truck_03_covered_ghex_F"
		]
	],
	[
		"CAMS_Mil_UtilityVehicle_E",1,true,
		[
			"O_G_Offroad_01_repair_F", "O_Truck_02_Ammo_F", "O_Truck_02_box_F", "O_Truck_02_fuel_F", "O_Truck_02_medical_F", "O_G_Van_01_fuel_F",
									"O_T_Truck_03_ammo_ghex_F",
									"O_T_Truck_03_device_ghex_F",
									"O_T_Truck_03_fuel_ghex_F",
									"O_T_Truck_03_medical_ghex_F",
									"O_T_Truck_03_repair_ghex_F"
		]
	],
	[
		"CAMS_Mil_ArmedTransport_E",1,true,
		[
			"O_APC_Tracked_02_cannon_F", "O_APC_Tracked_02_AA_F", "O_APC_Wheeled_02_rcws_v2_F", "O_APC_Wheeled_02_rcws_F"
		]
	],

	[
		"CAMS_Mil_Tank_E",1,true,
		[
			"O_MBT_02_cannon_F"
		]
	],
	[
		"CAMS_Mil_Artillery_E",1,true,
		[
			"O_MBT_02_arty_F"
		]
	],

	[
		"CAMS_Mil_Transport_ALL_E",0,true,
		[
			"CAMS_Mil_OpenTransport_E","CAMS_Mil_CoveredTransport_E", "CAMS_Mil_ArmedTransport_E"
		]
	],
	[
		"CAMS_Mil_Unarmed_E",0,true,
		[
			"CAMS_Mil_UnarmedOffroad_E", "CAMS_Mil_OpenTransport_E", "CAMS_Mil_CoveredTransport_E"
		]
	],	
	[
		"CAMS_Mil_Armed_E",0,true,
		[
			"CAMS_Mil_ArmedOffroad_E", "CAMS_Mil_ArmedTransport_E"
		]
	],	
	[
		"CAMS_Mil_ALL_E",0,true,
		[
			"CAMS_Mil_Unarmed_E", "CAMS_Mil_Armed_E"
		]
	],

	//////////////////// Guerilla Vehicles
	[
		"CAMS_Mil_ArmedOffroad_G",1,true,
		[
			"I_MRAP_03_gmg_F", "I_MRAP_03_hmg_F"
		]
	],
	[
		"CAMS_Mil_UnarmedOffroad_G",1,true,
		[
			"I_MRAP_03_F"
		]
	],

	[
		"CAMS_Mil_UGV_Armed_G",1,true,
		[
			"I_UGV_01_rcws_F"
		]
	],
	[
		"CAMS_Mil_UGV_Unarmed_G",1,true,
		[
			"I_UGV_01_F"
		]
	],
	[
		"CAMS_Mil_Toy_Quad_E",1,true,
		[
			"I_G_Quadbike_01_F", "I_Quadbike_01_F"
		]
	],
	
	[
		"CAMS_Mil_OpenTransport_G",1,true,
		[
			"I_G_Offroad_01_F", "I_Truck_02_transport_F", "I_G_Van_01_transport_F"
		]
	],
	[
		"CAMS_Mil_CoveredTransport_G",1,true,
		[
			"I_Truck_02_covered_F"
		]
	],
	[
		"CAMS_Mil_UtilityVehicle_G",1,true,
		[
			"I_G_Offroad_01_repair_F", "I_Truck_02_ammo_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_medical_F", "I_G_Van_01_fuel_F"
		]
	],
	[
		"CAMS_Mil_ArmedTransport_G",1,true,
		[
			"I_G_Offroad_01_armed_F", "I_G_Offroad_01_AT_F", "I_APC_Wheeled_03_cannon_F", "I_APC_tracked_03_cannon_F"
		]
	],

	[
		"CAMS_Mil_Tank_G",1,true,
		[
			"I_MBT_03_cannon_F"
		]
	],

	[
		"CAMS_Mil_Transport_ALL_G",0,true,
		[
			"CAMS_Mil_OpenTransport_G", "CAMS_Mil_CoveredTransport_G", "CAMS_Mil_ArmedTransport_G"
		]
	],
	[
		"CAMS_Mil_Unarmed_G",0,true,
		[
			"CAMS_Mil_UnarmedOffroads_G", "CAMS_Mil_OpenTransport_G", "CAMS_Mil_CoveredTransport_G"
		]
	],	
	[
		"CAMS_Mil_Armed_G",0,true,
		[
			"CAMS_Mil_ArmedOffroads_G", "CAMS_Mil_ArmedTransport_G"
		]
	],	
	[
		"CAMS_Mil_ALL_G",0,true,
		[
			"CAMS_Mil_Unarmed_G", "CAMS_Mil_Armed_G"
		]
	],

	

	//////////////////////////// Misc

		
	// Static Guns
	[
		"CAMS_Mil_StaticGuns_W",1,true,
		[
			"B_HMG_01_A_F", "B_HMG_01_F", "B_HMG_01_high_F"
		]
	],
	[
		"CAMS_Mil_StaticGL_W",1,true,
		[
			"B_GMG_01_A_F", "B_GMG_01_F", "B_GMG_01_high_F"
		]
	],
	[
		"CAMS_Mil_StaticAA_W",1,true,
		[
			"B_static_AA_F"
		]
	],
	[
		"CAMS_Mil_StaticAT_W",1,true,
		[
			"B_static_AT_F"
		]
	],
	[
		"CAMS_Mil_Mortar_W",1,true,
		[
			"B_G_Mortar_01_F","B_Mortar_01_F"
		]
	],


	[
		"CAMS_Mil_StaticGuns_E",1,true,
		[
			"O_HMG_01_F", "O_HMG_01_high_F", "O_HMG_01_A_F"
		]
	],
	[
		"CAMS_Mil_StaticGL_E",1,true,
		[
			"O_GMG_01_F", "O_GMG_01_high_F", "O_GMG_01_A_F"
		]
	],
	[
		"CAMS_Mil_StaticAA_E",1,true,
		[
			"O_static_AA_F"
		]
	],
	[
		"CAMS_Mil_StaticAT_E",1,true,
		[
			"O_static_AT_F"
		]
	],
	[
		"CAMS_Mil_Mortar_E",1,true,
		[
			"O_Mortar_01_F", "O_G_Mortar_01_F"
		]
	],

	[
		"CAMS_Mil_StaticGuns_G",1,true,
		[
			"I_HMG_01_A_F", "I_HMG_01_F", "I_HMG_01_high_F"
		]
	],
	[
		"CAMS_Mil_StaticGL_G",1,true,
		[
			"I_GMG_01_A_F", "I_GMG_01_F", "I_GMG_01_high_F"
		]
	],
			
	[
		"CAMS_Mil_StaticAA_G",1,true,
		[
			"I_static_AA_F"
		]
	],
	[
		"CAMS_Mil_StaticAT_G",1,true,
		[
			"I_static_AT_F"
		]
	],
	[
		"CAMS_Mil_Mortar_G",1,true,
		[
			"I_Mortar_01_F", "I_G_Mortar_01_F"
		]
	],








	[
		"CAMS_Hist_Wreck",1,true,
		[
			"Land_HistoricalPlaneWreck_01_F","Land_HistoricalPlaneWreck_02_front_F","Land_HistoricalPlaneWreck_03_F"
		]
	],
	[
		"CAMS_Car_Wreck",1,true,
		[
			"Land_Wreck_Car_F","Land_Wreck_Car2_F","Land_Wreck_Car3_F","Land_Wreck_CarDismantled_F",
			"Land_Wreck_Skodovka_F"
		]
	],
	[
		"CAMS_Truck_Wreck",1,true,
		[
			"Land_Wreck_Offroad_F","Land_Wreck_Offroad2_F"
		]
	],
	[
		"CAMS_Vehicle_Wreck",1,true,
		[
			"Land_Wreck_BMP2_F","Land_Wreck_HMMWV_F","Land_Wreck_BRDM2_F","Land_Wreck_Ural_F","Land_Wreck_Hunter_F"
		]
	],
	[
		"CAMS_Tank_Wreck",1,true,
		[
			"Land_Wreck_Slammer_F","Land_Wreck_Slammer_hull_F","Land_Wreck_T72_hull_F"
		]
	],
	[
		"CAMS_Heli_Wreck",1,true,
		[
			"Land_Wreck_Heli_Attack_02_F","Land_UWreck_Heli_Attack_02_F","Land_Wreck_Heli_Attack_01_F"
		]
	],
	[
		"CAMS_Plane_Wreck",1,true,
		[
			"Land_UWreck_MV22_F","Plane_Fighter_03_wreck_F","Land_Wreck_Plane_Transport_01_F"
		]
	],
	[
		"CAMS_Boat_Wreck",1,true,
		[
			"Land_UWreck_FishingBoat_F","Land_Wreck_Traw_F","Land_Wreck_Traw2_F"
		]
	],
	[
		"CAMS_Wreck_Land",0,true,
		[
			"CAMS_Car_Wreck", "CAMS_Truck_Wreck", "CAMS_Vehicle_Wreck", "CAMS_Heli_Wreck", "CAMS_Plane_Wreck", 
			"CAMS_Hist_Wreck"
		]
	]
];

// Global Collections

// Admin ATTENTION!
// Any new global arrays you want to have available on the headless client need to be defined in this file.
// Define the array below, then place the name of the array in the 'FuMS_ListofCustomGlobalItems' variable below.
// At initialization your global variable will be passed onto the HC prior to it attempting to initialize any missions.
CAMS_MyExampleGlobalVariable = ["Chemlight_blue","Chemlight_green","Chemlight_red"];

CAMS_ListofCustomGlobalItems =
[
	"CAMS_MyExampleGlobalVariable"
];

//FuMS_Veh_Land = FuMS_Civ_All + FuMS_Work_All + FuMS_Mil_Unarmed;
//FuMS_Loot_Items = FuMS_BaseBuilding_ALL + FuMS_Food_ALL + FuMS_Drink + FuMS_Medical_Supplies + FuMS_W_Optics_ALL + FuMS_W_Attachments;



/*
FuMS_ListofFuMSGlobalItems =
[
"FuMS_Crafting_Wood","FuMS_Crafting_Metal","FuMS_Crafting_Other","FuMS_Crafting_Tools","FuMS_Crafting_Raw","FuMS_Crafting_ALL",
"FuMS_Food_Cooked","FuMS_Food_Raw","FuMS_Food_ALL","FuMS_Drink",

"FuMS_U_Civ","FuMS_U_Soldier","FuMS_U_Guerilla","FuMS_U_Ghillie","FuMS_U_Aviation","FuMS_U_Wetsuit","FuMS_U_All",

"FuMS_V_Bandolliers","FuMS_V_Chestrig","FuMS_V_Vests","FuMS_V_Harness","FuMS_V_Plate","FuMS_V_Rebreather","FuMS_V_All",

"FuMS_H_Caps","FuMS_H_MilitaryCaps","FuMS_H_Beanies","FuMS_H_Bandannas","FuMS_H_Boonie","FuMS_H_Hats","FuMS_H_Berets",
"FuMS_H_Shemags","FuMS_H_LightHelmet","FuMS_H_RegHelmet","FuMS_H_SuperHelmet","FuMS_H_SpecOps","FuMS_H_Aviation",
"FuMS_H_Civ","FuMS_H_Hunter","FuMS_H_Military","FuMS_H_ALL",

"FuMS_W_Pointer","FuMS_W_Bipod","FuMS_W_Muzzle",
"FuMS_W_OpticsLv1","FuMS_W_OpticsLv2","FuMS_W_OpticsLv3","FuMS_W_Optics_ALL","FuMS_W_Attachments",

"FuMS_B_Navigation","FuMS_Packs_Lv1","FuMS_Packs_Lv2","FuMS_Packs_Lv3","FuMS_Packs_ALL",

"FuMS_Ammo_All","FuMS_Ammo_762","FuMS_Ammo_93","FuMS_Ammo_45","FuMS_Ammo_65","FuMS_Ammo_338","FuMS_Ammo_556",
"FuMS_Ammo_water","FuMS_Ammo_9mm","FuMS_Ammo_127","FuMS_Ammo_408",

"FuMS_Flares_Chemical","FuMS_Flares_Normal","FuMS_Flares_1Rnd","FuMS_Flares_3Rnd","FuMS_Flares_ALL",
"FuMS_Smoke_Shell","FuMS_Smoke_1Rnd","FuMS_Smoke_3Rnd","FuMS_Smoke_All",

"FuMS_E_Grenade","FuMS_E_GrenadeIR","FuMS_E_1Rnd","FuMS_E_3Rnd","FuMS_E_Mine","FuMS_E_IED","FuMS_E_All",

"FuMS_Pistols","FuMS_SubMGs","FuMS_LightMGs","FuMS_AssaultRifles","FuMS_SniperRifles","FuMS_Rifles_ALL","FuMS_Guns_ALL",

"FuMS_AmmoForEach",

  //Vehicle
"FuMS_Toy_All","FuMS_Toy_Bikes","FuMS_Toy_Quads","FuMS_Toy_Karts",
"FuMS_H20_All","FuMS_H20_Boats","FuMS_H20_RubberDucks","FuMS_H20_SDVs",
"FuMS_Heli_ALL","FuMS_Heli_Hellcats","FuMS_Heli_Hummingbirds","FuMS_Heli_Hurons","FuMS_Heli_Mohawks","FuMS_Heli_Orcas","FuMS_Heli_Tarus",
"FuMS_Plane_All","FuMS_Plane_Cessnas",
"FuMS_Civ_All","FuMS_Civ_Hatchbacks","FuMS_Civ_SportHatchbacks","FuMS_Civ_Offroads","FumS_Civ_SUVs","FuMS_Civ_Vans",
"FuMS_Work_All","FuMS_Work_RepairOffroads","FuMS_Work_BoxVans","FuMS_Work_FuelVans",
"FuMS_Mil_Unarmed","FuMS_Mil_Hemmts","FuMS_Mil_Hunters","FuMS_Mil_Ifrits","FuMS_Mil_Striders","FuMS_Mil_Tempests","FuMS_Mil_Zamaks",
"FuMS_Mil_Armed","FuMS_Mil_ArmedOffroads",
"FuMS_Mil_All","FuMS_Veh_Land"

];
*/




/////////////////////////////
// Cart processing //////////
/////////////////////////////

_hold = [_cartName,_cartContents,_debugCart] spawn CAMS_fnc_loadCart;
if (isNil "_hold") exitWith { diag_log format ["[CAMS:%1] Cart(%2): assets.sqf: ERROR in cart loading function",CAMS_Version,_cartName];CAMS_isStable=false;};
waitUntil { ScriptDone _hold};

//diag_log format ["[CAMS] CART System: %1 assets loaded",_cartName];
