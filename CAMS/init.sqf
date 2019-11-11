// CAMS Initilization

CAMS_Version = "1.0";
publicVariable "CAMS_Version";
CAMS_isStable = false;

/////////////////////////////////////////
// System Config ////////////////////////
/////////////////////////////////////////

_cartsLoaded = ["jets","apex"];
_loadVanilla = true;		// Load the vanilla content? NOTE: If set to false, you need to be sure you have a VERY clean cart file that fills all minimum needs for system to run



//////////////////////////////////////////
// Initialize system /////////////////////
//////////////////////////////////////////

_hold = [] execVM "CAMS\InitGlobalVars.sqf";
if (isNil "_hold") exitWith { diag_log format ["[CAMS:%1] init.sqf: ERROR in InitGlobalVars.sqf",CAMS_Version];CAMS_isStable=false;};
waitUntil { ScriptDone _hold};

_hold = [] execVM "CAMS\InitImFXVars.sqf";
if (isNil "_hold") exitWith { diag_log format ["[CAMS:%1] init.sqf: ERROR in InitFXVars.sqf",CAMS_Version];CAMS_isStable=false;};
waitUntil { ScriptDone _hold};

if (_loadVanilla) then
{
	_hold = [] execVM "CAMS\carts\vanilla\assets.sqf";
	if (isNil "_hold") exitWith { diag_log format ["[CAMS:%1] init.sqf: ERROR in assets.sqf",CAMS_Version];CAMS_isStable=false;};
	waitUntil { ScriptDone _hold};
	["[CAMS] System","Vanilla assets loaded"] spawn Haz_fnc_createNotification;
	
	_hold = [] execVM "CAMS\carts\vanilla\ImmersionFX.sqf";
	if (isNil "_hold") exitWith { diag_log format ["[CAMS:%1] init.sqf: ERROR in cart ImmersionFX.sqf : %2",CAMS_Version,_x];CAMS_isStable=false;};
	waitUntil { ScriptDone _hold};
	["[CAMS] System","Cart:Vanilla ImmersionFX loaded"] spawn Haz_fnc_createNotification;
};


//process carts
{
	_hold = [] execVM format ["CAMS\carts\%1\assets.sqf",_x];
	if (isNil "_hold") exitWith { diag_log format ["[CAMS:%1] init.sqf: ERROR in cart assets.sqf : %2",CAMS_Version,_x];CAMS_isStable=false;};
	waitUntil { ScriptDone _hold};
	["CAMS System",format ["Cart:%1 assets loaded",_x]] spawn Haz_fnc_createNotification;

} forEach _cartsLoaded;

//carts completed

// immersion FX
{
	_hold = [] execVM format ["CAMS\carts\%1\ImmersionFX.sqf",_x];
	if (isNil "_hold") exitWith { diag_log format ["[CAMS:%1] init.sqf: ERROR in cart assets.sqf : %2",CAMS_Version,_x];CAMS_isStable=false;};
	waitUntil { ScriptDone _hold};
	["CAMS System",format ["Cart:%1 immersionFX loaded",_x]] spawn Haz_fnc_createNotification;

} forEach _cartsLoaded;

// Complete ImmersionFX

CAMS_isStable = true;
publicVariable "CAMS_isStable";


hint format ["[CAMS] CAMS_isStable:%1",CAMS_isStable];

/*
sleep 20;

_messageTypes = ["side","hint","popUp","tiles","type","type2","dynamic","info","sitrep","system"];

hint "Starting message test";

{
	[format ["%1",_x],format ["Testing %1",_x],format ["This is a test of the %1 system",_x],["WEST"]] spawn FrSB_fnc_announce;
	sleep 10;
} forEach _messageTypes;
*/