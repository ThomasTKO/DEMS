// ImmersionFX.sqf
// TheOneWhoKnocks
// Overwrites the global variables used by FrSB to integrate crstom content into system

// Global variables in this file are available to the AI creation and Loot creation portions of FuMS
// Any where you would normally place an item class name, one of these variables may be substituted in its place.
// When FuMS encounters one of these defined arrays, it will select one of the items from the array at random to use
// in the particular application (ie AI Uniform, loot in a box, etc).

private ["_immersionData","_cartName","_debugCart"];


///////////////////////////////////////////////////
// CART config ////////////////////////////////////
///////////////////////////////////////////////////
_cartName = "vanilla";
_debugCart = false;



_immersionData = 
[
	/////////////////////////////////////// AI Models to use
	[
		"ImFX_AiModel_E",1,true,
		[
			"O_G_Soldier_F"
		]
	],
	
	////////////////////////////////////// Air Assets
	[
		"ImFX_Air_Patrol",1,true,
		[
			// A-164 Wipeout
			"B_Plane_CAS_01_dynamicLoadout_F",
			
			// MQ-4A Greyhawk (UAV)
			"B_UAV_02_dynamicLoadout_F",
			"O_UAV_02_dynamicLoadout_F",
			"I_UAV_02_dynamicLoadout_F"
		]
	],
	[
		"ImFX_Air_Interceptor",1,true,
		[
			// A-143 Buzzard
			"I_Plane_Fighter_03_dynamicLoadout_F",
			//To-199 Neophron
			"O_Plane_CAS_02_dynamicLoadout_F"
		]
	],
	[
		"ImFX_Air_Airdrop",0,true,
		[
			"CAMS_Heli_Unarmed_W","CAMS_Heli_Transport_W"
		]
	],

	/////////////////////////////////////// Heli Assets
	[
		"ImFX_Heli_Escort",0,true,
		[
			"CAMS_Heli_Armed_E"
		]
	],
	[
		"ImFX_Heli_Transport",0,true,
		[
			"CAMS_Heli_Transport_W"
		]
	],
	[
		"ImFX_Heli_Troops",0,true,
		[
			"CAMS_Heli_Unarmed_E"
		]
	],
	[
		"ImFX_Air_Rescue_Heli",1,true,
		[
			// UH-80 Ghosthawk
			"B_Heli_Transport_01_F",
			"B_Heli_Transport_01_camo_F",
			
			// CH-67 Huron
			"B_Heli_Transport_03_unarmed_F",
			
			// MH-9 Hummingbird
			"B_Heli_Light_01_F",
			
			// UH1H
			"UH1H_Closed_TK"
		]
	],

	
	/////////////////////////////////////// Land Assets

	[
		"ImFX_Land_Armed_Guard",0,true,
		[
			"CAMS_Mil_ArmedOffroad_E"
		]
	],	
	[
		"ImFX_Land_Armed_Transport",0,true,
		[
			"CAMS_Mil_ArmedTransport_E"
		]
	],	
	[
		"ImFX_Land_Unarmed_Transport",0,true,
		[
			"CAMS_Mil_OpenTransport_E","CAMS_Mil_CoveredTransport_E","CAMS_Mil_CoveredUral"
		]
	],	
	[
		"ImFX_Land_Civ_Truck",0,true,
		[
			"CAMS_Civ_SUVs"
		]
	],	
	[
		"ImFX_Land_Civ_Car",0,true,
		[
			"CAMS_Civ_ALL"
		]
	]
	/////////////////////////////////////// Misc Assets
	
	
	
	
	
];

/////////////////////////////
// Cart processing //////////
/////////////////////////////
_hold = [_cartName,_immersionData,_debugCart] spawn CAMS_fnc_loadCart;
if (isNil "_hold") exitWith { diag_log format ["[CAMS:%1] Cart(%2): ImmersionFX.sqf: ERROR in cart loading function",CAMS_Version,_cartName];CAMS_isStable=false;};
waitUntil { ScriptDone _hold};