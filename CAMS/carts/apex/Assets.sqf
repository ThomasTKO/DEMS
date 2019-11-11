// Assets.sqf
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
_cartName = "apex";
_debugCart = false;




// Some items are repeated to add a "chance" element.  The more duplicates, the higher chance of spawning, and conversely the lower for others

_cartContents = 
[	
	// Water Vehicles - West
	[
		"CAMS_APEX_H20_Boats",1,true,
		[
			"B_T_Boat_Armed_01_minigun_F"
		]
	],
	[
		"CAMS_APEX_H20_RubberDucks",1,true,
		[
			"B_T_Boat_Transport_01_F","B_T_Lifeboat","B_G_Boat_Transport_01_F"
		]
	],
	[
		"CAMS_APEX_H20_RHIB",1,true,
		[
			"B_G_Boat_Transport_02_F"
		]
	],	
	[
		"CAMS_Mil_H20_All",0,false,
		[
			"CAMS_APEX_H20_Boats", "CAMS_APEX_H20_RubberDucks", "CAMS_APEX_H20_RHIB"
		]
	]	
];




/////////////////////////////
// Cart processing //////////
/////////////////////////////
////////////////////////  NEW for today

_hold = [_cartName,_cartContents,_debugCart] spawn CAMS_fnc_loadCart;
if (isNil "_hold") exitWith { diag_log format ["[CAMS:%1] Cart(%2): assets.sqf: ERROR in cart loading function",CAMS_Version,_cartName];CAMS_isStable=false;};
waitUntil { ScriptDone _hold};
//["CAMS System",format ["Cart:%1 assets loaded",_cartName]] spawn Haz_fnc_createNotification;
