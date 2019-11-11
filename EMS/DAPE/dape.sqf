/** DYNAMIC AIR PATROL EVENT by TheOneWhoKnocks **/
// Version 1.5
// Originally inspired by johno's Dynamic Air Patrol script
// Modified to include make event run until a chopper event runs, fixed several issues, and enhance overall script
// 4/20/18
//
// 5/10/2019 - Significant changes and complete overhaul  First release
// 5/18/2019 - Added marker cleanup and made it so script repeats after heli is cleared.  Code optimizations
// 5/21/2019 - Added option to disable interceptor, added money to AI pockets, added more clean up code
// 5/22/2019 - Added option to make heli persistent
// 5/29/2019 - Moved code to make heli persistent only after it's been captured
// 6/6/2019  - Added logic to clean up mission if rescue craft gets destroyed
// 6/6/2019  - Added ability to protect heli until it lands
// 6/6/2019  - Added ability to run without Exile server
// 6/9/2019  - Added integration into CAMS system
sleep 10;
diag_log "[DAPE] Ambient air patrol engaged";
 
//if (!isServer) exitWith{};
 
private ["_playerConnected","_cleanupObjects","_rescueChopperRun","_waypoint1","_waypoint2","_waypoint3","_waypoint4","_patrolAirplanes","_crashType","_chosenTarget","_chosenTargetName","_interceptorPlanes","_markerWaypointOne","_markerWaypointTwo","_markerWaypointThree","_markerWayPointFour","_wayPointOne","_wayPointTwo","_wayPointThree","_wayPointFour","_mk","_pos","_interceptor","_interceptorAircraft"];

/************************************************************************************************/
/** Script Config parameters ********************************************************************/
/************************************************************************************************/

_eastSide = createCenter east;
_westSide = createCenter west;
_guerSide = createCenter resistance;
_playerConnected = false;

_usingExile = false;


_patrolHeight = 150;			// Fly in height for patrol and rescue operations
_delayQRF = 30;					// Time before QRF rescue heli launches after the crash
_interceptorPresent = true;		// TRUE - Interceptor launches and shoots down patrol | FALSE - Only patrol plane flies (Either way, land crash will generate rescure craft)
_AIMoney = 500;					// Max amount of money in AI pockets
_lootHeliPersist = false;		// TRUE - Vehicle is persistant and uses code defined below | FALSE - vehicle is not persistant
_lootHeliProtected = true;		// TRUE - Loot heli cannot be shot down in transit     FALSE - Loot heli is vulnerable while it flies in
_pincode = floor (random 9999);



switch (true) do
		{
			case (_pinCode<10):
			{
				_pinCode = format ["000%1",_pinCode];
			};

			case (_pinCode<100):
			{
				_pinCode = format ["00%1",_pinCode];
			};

			case (_pinCode<1000):
			{
				_pinCode = format ["0%1",_pinCode];
			};

			default
			{
				_pinCode = str _pinCode;
			};
		};

_cleanupObjects = [];



// This code is NECESSARY for spawning persistent vehicles. DO NOT REMOVE THIS CODE UNLESS YOU KNOW WHAT YOU ARE DOING
// This will also cause AI to now recognize the vehicle and possibly jump in.

if (_usingExile) then
{
	if !("isKnownAccount:DAPE_PersistentVehicle" call ExileServer_system_database_query_selectSingleField) then
	{
		"createAccount:DAPE_PersistentVehicle:DAPE_PersistentVehicle" call ExileServer_system_database_query_fireAndForget;
	};
};


/************************************************************************************************/
/** DEBUG MARKER ********************************************************************************/
/** Turns on markers that show event activity ***************************************************/
/** Also shortens mission for testing ***********************************************************/
/************************************************************************************************/
 
_debug = false; // Will create a marker that will follow the aircraft and show other event information 
 
 
/************************************************************************************************/
/** Random location settings ********************************************************************/
/************************************************************************************************/
 
_spawnCenter = [worldSize / 2, worldsize / 2, 1000]; 

_min = 10; // minimum distance from the center position (Number) in meters
_max = worldSize * 0.4; // maximum distance from the center position (Number) in meters
_mindist = 0; // minimum distance from the nearest object (Number) in meters, ie. create waypoint this distance away from anything within x meters..
_water = 0; // water mode 0: cannot be in water , 1: can either be in water or not , 2: must be in water
_shoremode = 0; // 0: does not have to be at a shore , 1: must be at a shore

 
/************************************************************************************************/
/** GENERATE WAYPOINTS **************************************************************************/
/************************************************************************************************/

_useMarkerWaypoints = false; 
// If true, will use fixed locations instead of random positions.  
// If false, you system will generate four waypoints around the map



if (_debug) then
{
	private _centerPoint = createMarker ["centerpoint", _spawnCenter	];  //Shows map center

	_centerPoint setMarkerType "mil_destroy";
};
 
/************************************************************************************************/
/** If using fixed locations or waypoints *******************************************************/
/************************************************************************************************/
if (_useMarkerWaypoints) then 
{
 
	private _waypoint1 = createMarker ["waypoint1", [8407,10285]	];  //These work for Tanoa and make the craft fly in a large X across the island
	private _waypoint2 = createMarker ["waypoint2", [2970,3416]		];	//The patrol aircraft will fly to waypoint 1, then cycle through 4, then back to 1
	private _waypoint3 = createMarker ["waypoint3", [11652,3123]	];	//The attack aircraft will fly a reverse route
	private _waypoint4 = createMarker ["waypoint4", [3064,11047]	];	//This is the best way to ensure the event works the way you want
	
	if (_debug) then
	{
		_waypoint1 setMarkerType "mil_pickup";
		_waypoint2 setMarkerType "mil_pickup";
		_waypoint3 setMarkerType "mil_pickup";
		_waypoint4 setMarkerType "mil_pickup";
	};
 
    _wayPointOne = getMarkerPos "waypoint1";
    _wayPointTwo = getMarkerPos "waypoint2";
    _wayPointThree = getMarkerPos "waypoint3";
    _wayPointFour = getMarkerPos "waypoint4";
	
}else
/************************************************************************************************/
/** Generate random waypoints *******************************************************************/
/** Note: This makes a very sporadic flight path ************************************************/
/************************************************************************************************/
{
    _wayPointOne = [_spawnCenter,_min,_max,_mindist,_water,5,_shoremode] call BIS_fnc_findSafePos;
    _wayPointTwo = [_spawnCenter,_min,_max,_mindist,_water,5,_shoremode] call BIS_fnc_findSafePos;
    _wayPointThree = [_spawnCenter,_min,_max,_mindist,_water,5,_shoremode] call BIS_fnc_findSafePos;
    _wayPointFour = [_spawnCenter,_min,_max,_mindist,_water,5,_shoremode] call BIS_fnc_findSafePos;
	
	if (_debug) then
	{
		private _waypoint1 = createMarker ["waypoint1", _wayPointOne	];  //These will be randomly placed waypoints
		private _waypoint2 = createMarker ["waypoint2", _wayPointTwo	];	//The patrol aircraft will fly to waypoint 1, then cycle through 4, then back to 1
		private _waypoint3 = createMarker ["waypoint3", _wayPointThree	];	//The attack aircraft will fly a reverse route
		private _waypoint4 = createMarker ["waypoint4", _wayPointFour	];	//This will be a very sporadic flight path

		_waypoint1 setMarkerType "mil_pickup";	
		_waypoint2 setMarkerType "mil_pickup";
		_waypoint3 setMarkerType "mil_pickup";
		_waypoint4 setMarkerType "mil_pickup";
		
		_waypoint1 setMarkerText "WP1";	
		_waypoint2 setMarkerText "WP2";
		_waypoint3 setMarkerText "WP3";
		_waypoint4 setMarkerText "WP4";

	};
};

// Starting position for the interceptor and rescue chopper.
 
_startPos = [_spawnCenter, (worldSize * 0.5), -1, 5, 2] call BIS_fnc_findSafePos ;	// Tries to find a location over the water so they don't just appear out of nowhere

//diag_log format ["[DAPE] Startpos : %1",_startPos];

if (_debug) then
{
	private _startPoint = createMarker ["startpos", _startPos	];  //Shows map center

	_startPoint setMarkerType "mil_start";
	_startPoint setMarkerText "SP-Patrol";

};

_interceptorStartPos = [_spawnCenter, (worldSize * 0.5), -1, 5, 2] call BIS_fnc_findSafePos ;	// Tries to find a location over the water so they don't just appear out of nowhere

if (_debug) then
{
	private _inStartPoint = createMarker ["intstartpos", _interceptorStartPos	];  //Shows map center

	_inStartPoint setMarkerType "hd_start";
	_inStartPoint setMarkerText "SP-Int";

};

//diag_log format ["[DAPE] IntStartpos : %1",_interceptorStartPos];

_interceptorExitPos = [_spawnCenter, (worldSize * 0.75), -1, 5, 2] call BIS_fnc_findSafePos ;	// Tries to find a location over the water so they don't just appear out of nowhere

if (_debug) then
{
	private _inExitPoint = createMarker ["intexitpos", _interceptorExitPos	];  

	_inExitPoint setMarkerType "hd_end";
	_inExitPoint setMarkerText "EP-Int";

};

//diag_log format ["[DAPE] IntExitpos : %1",_interceptorExitPos];


// LOOT
// The loot is the chopper itself, but you can choose to add weapons and items if you want 
 
_amountOfWeapons = 5+floor(random 5);
_amountOfItems = 7+floor(random 5);
 
_lootWeapons =
	[
		"arifle_MXM_Black_F",
		"arifle_MXM_F",
		"srifle_DMR_01_F",
		"srifle_DMR_02_camo_F",
		"srifle_DMR_02_F",
		"srifle_DMR_02_sniper_F",
		"srifle_DMR_03_F",
		"srifle_DMR_03_khaki_F",
		"srifle_DMR_03_multicam_F",
		"srifle_DMR_03_tan_F",
		"srifle_DMR_03_woodland_F",
		"srifle_DMR_04_F",
		"srifle_DMR_04_Tan_F",
		"srifle_DMR_05_blk_F",
		"srifle_DMR_05_hex_F",
		"srifle_DMR_05_tan_f",
		"srifle_DMR_06_camo_F",
		"srifle_DMR_06_olive_F",
		"srifle_EBR_F",
		"srifle_GM6_camo_F",
		"srifle_GM6_F",
		"srifle_LRR_camo_F",
		"srifle_LRR_F",
		 
		"arifle_MX_SW_Black_F",
		"arifle_MX_SW_F",
		"LMG_Mk200_F",
		"MMG_01_hex_F",
		"MMG_01_tan_F",
		"MMG_02_camo_F",
		"MMG_02_black_F",
		"MMG_02_sand_F",
		"LMG_Zafir_F",
		 
		"arifle_Katiba_C_F",
		"arifle_Katiba_F",
		"arifle_Katiba_GL_F",
		"arifle_Mk20_F",
		"arifle_Mk20_GL_F",
		"arifle_Mk20_GL_plain_F",
		"arifle_Mk20_plain_F",
		"arifle_Mk20C_F",
		"arifle_Mk20C_plain_F",
		"arifle_MX_Black_F",
		"arifle_MX_F",
		"arifle_MX_GL_Black_F",
		"arifle_MX_GL_F",
		"arifle_MXC_Black_F",
		"arifle_MXC_F",
		"arifle_SDAR_F",
		"arifle_TRG20_F",
		"arifle_TRG21_F",
		"arifle_TRG21_GL_F"
	];
 
_lootItems =
	[
		"HandGrenade",
		"MiniGrenade",
		"B_IR_Grenade",
		"O_IR_Grenade",
		"I_IR_Grenade",
		"1Rnd_HE_Grenade_shell",
		"3Rnd_HE_Grenade_shell",
		"APERSBoundingMine_Range_Mag",
		"APERSMine_Range_Mag",
		"APERSTripMine_Wire_Mag",
		"ClaymoreDirectionalMine_Remote_Mag",
		"DemoCharge_Remote_Mag",
		"IEDLandBig_Remote_Mag",
		"IEDLandSmall_Remote_Mag",
		"IEDUrbanBig_Remote_Mag",
		"IEDUrbanSmall_Remote_Mag",
		"SatchelCharge_Remote_Mag",
		"SLAMDirectionalMine_Wire_Mag",
		 
		"B_AssaultPack_blk",
		"B_AssaultPack_cbr",
		"B_AssaultPack_dgtl",
		"B_AssaultPack_khk",
		"B_AssaultPack_mcamo",
		"B_AssaultPack_rgr",
		"B_AssaultPack_sgg",
		"B_FieldPack_blk",
		"B_FieldPack_cbr",
		"B_FieldPack_ocamo",
		"B_FieldPack_oucamo",
		"B_TacticalPack_blk",
		"B_TacticalPack_rgr",
		"B_TacticalPack_ocamo",
		"B_TacticalPack_mcamo",
		"B_TacticalPack_oli",
		"B_Kitbag_cbr",
		"B_Kitbag_mcamo",
		"B_Kitbag_sgg",
		"B_Carryall_cbr",
		"B_Carryall_khk",
		"B_Carryall_mcamo",
		"B_Carryall_ocamo",
		"B_Carryall_oli",
		"B_Carryall_oucamo",
		"B_Bergen_blk",
		"B_Bergen_mcamo",
		"B_Bergen_rgr",
		"B_Bergen_sgg",
		"B_HuntingBackpack",
		"B_OutdoorPack_blk",
		"B_OutdoorPack_blu",
		 
		"Rangefinder",
		"NVGoggles",
		"NVGoggles_INDEP",
		"NVGoggles_OPFOR"
	];
	
	
_exileLootItems = 
	[
		"Exile_Item_InstaDoc",
		"Exile_Item_Vishpirin",
		"Exile_Item_Bandage"
	];	
	
// Airplane options
	
_patrolAirplanes = missionNamespace getVariable "ImFX_Air_Patrol";	
_interceptorPlanes = missionNamespace getVariable "ImFX_Air_Interceptor";
_rescueHelis = missionNamespace getVariable "ImFX_Air_Rescue_Heli";

diag_log format["[DAPE] Waiting for players to connect"];
while {!_playerConnected} do 
{
	sleep 60;
	_allHCs = entities "HeadlessClient_F";
	_allHPs = allPlayers - _allHCs;
	diag_log format["[DAPE] Waiting... HC's : %1 | Players = %2",_allHCs,_allHPs];
	if ((count _allHPs) > 0) then
	{
		_playerConnected = true;
	};
};

diag_log "[DAPE] Player connected, starting patrol";

//Setup Loop logic so it runs forever (Accounts for crashes at sea and runs again if no rescue chopper flies
while {true} do 
{
	//diag_log "[DAPE} Loop starting";
	// Randomize the start time of the script
	 
	if (_debug) then
	{
		uiSleep 120;
	}
	else
	{    
		uiSleep 300; // Wait for 5 minutes from beginning of script minutes.
	 
		_randomStartTime = floor (random 600); // Continue the delayed start for a random time between 0 and 10 minutes
		uiSleep _randomStartTime;
	};
	 
	
	_chosenTarget = _patrolAirplanes call BIS_fnc_selectRandom;
	_chosenTargetName = getText (configfile >> "CfgVehicles" >> _chosenTarget >> "displayName");
	
	_patrolGroup = createGroup [EAST,true];
	_spawnedPatrol = [_startPos, 0,_chosenTarget, _patrolGroup] call BIS_fnc_spawnVehicle;
	_airCraftLead = _spawnedPatrol select 0;
		
	[driver _airCraftLead ] joinSilent _patrolGroup;

	//diag_log format ["[DAPE] Patrol Pos: %1", getPosASL _airCraftLead];
	
	_titlePatrol = "ALERT";
	_messagePatrol = format ["A %1 patrol aircraft has been spotted",_chosenTargetName];

	if (_usingExile) then
	{
		["systemChatRequest", [format ["%1: %2",_titlePatrol,_messagePatrol]]] call ExileServer_system_network_send_broadcast;

		["toastRequest", ["InfoTitleAndText", [_titlePatrol, format ["A %1 patrol aircraft has been spotted",_chosenTargetName]]]] call ExileServer_system_network_send_broadcast;
	}else
	{
		["popUp", _titlePatrol, _messagePatrol,[RGBA_WHITE,RGBA_ORANGE]] call FrSB_fnc_announce;
		["system", _titlePatrol, _messagePatrol] call FrSB_fnc_announce;
	};
	
	if (_debug) then
	{
		[_airCraftLead] spawn
		{
			_planes = _this select 0;
			_pos = position _planes;
			_mk = createMarker ["PatrolMarker",_pos];
			while {alive _planes} do
			{
				_pos = position _planes;
				"PatrolMarker" setMarkerType "mil_warning";
				"PatrolMarker" setMarkerText "Patrol";
				_mk setMarkerPos _pos;
				uiSleep 1;
			};  
		};  
	};
	 
	//diag_log "[DAPE] Patrol aircraft created";
	 
	_patrolGroup setCombatMode "BLUE";
	 
	_airCraftLead disableAI "AUTOTARGET";
	_airCraftLead disableAI "TARGET";
	_airCraftLead disableAI "SUPPRESSION";
	_airCraftLead flyinHeight _patrolHeight;

	 
	_wp1 = _patrolGroup addWaypoint [_wayPointOne, 500];
	_wp1 setWaypointType "MOVE";
	_wp1 setWaypointBehaviour "CARELESS";
	_wp1 setWaypointspeed "NORMAL";
	 
	_wp2 = _patrolGroup addWaypoint [_wayPointTwo, 500];
	_wp2 setWaypointType "MOVE";
	_wp2 setWaypointBehaviour "CARELESS";
	_wp2 setWaypointspeed "LIMITED";
	 
	_wp3 = _patrolGroup addWaypoint [_wayPointThree, 500];
	_wp3 setWaypointType "MOVE";
	_wp3 setWaypointBehaviour "CARELESS";
	_wp3 setWaypointspeed "NORMAL";
	 
	_wp4 = _patrolGroup addWaypoint [_wayPointFour, 500];
	_wp4 setWaypointType "MOVE";
	_wp4 setWaypointBehaviour "CARELESS";
	_wp4 setWaypointspeed "LIMITED";
	 
	_wp5 = _patrolGroup addWaypoint [_wayPointOne, 500];
	_wp5 setWaypointType "CYCLE";
	_wp5 setWaypointBehaviour "CARELESS";
	_wp5 setWaypointspeed "NORMAL";
	 
	if (_debug) then
	{
		uiSleep 120;
	}
	else
	{    
	 
		uiSleep 600;
	};
	
	/////////////////////////////////////////////////////////
	/// Interceptor Code  ///////////////////////////////////
	/////////////////////////////////////////////////////////

	if (_interceptorPresent) then
	{
		diag_log "[DAPE] Intercept aircraft dispatched";
		_interceptor = createGroup [resistance,true];
		_interceptorChoice = _interceptorPlanes call BIS_fnc_selectRandom;
		_interceptorName = getText (configfile >> "CfgVehicles" >> _interceptorChoice >> "displayName");
	   
		_spawnedInterceptor = [_interceptorStartPos, 180,_interceptorChoice, _interceptor] call BIS_fnc_spawnVehicle;
		_interceptorAircraft = _spawnedInterceptor select 0;
		
		
		[driver _interceptorAircraft ] joinSilent _interceptor;
		//diag_log format ["[DAPE] Interceptor Pos: %1", getPosASL _interceptorAircraft];

	   
		_interceptor setCombatMode "RED";
		_interceptorAircraft allowDamage false;
		_interceptorAircraft setCaptive true;
		_interceptorAircraft forceSpeed 400;
		_interceptorAircraft reveal _airCraftLead;
	   
		_waypoints = [_wayPointFour,_wayPointThree,_wayPointTwo,_wayPointOne];
		{
		_intWP = _interceptor addWaypoint [_x, 500];
		_intWP setWaypointType "MOVE";
		_intWP setWaypointBehaviour "SAFE";
		_intWP setWaypointspeed "NORMAL";
		} forEach _waypoints;
		
		_intWP = _interceptor addWaypoint [_wayPointFour, 500];
		_intWP setWaypointType "CYCLE";
		_intWP setWaypointBehaviour "SAFE";
		_intWP setWaypointspeed "NORMAL";
	 
		if (_debug) then
		{    
			[_interceptorAircraft] spawn
			{
				_plane2 = _this select 0;
				_pos2 = position _plane2;
				_mk1 = createMarker ["InterceptorMarker",_pos2];
				while {alive _plane2} do
				{    
					_pos2 = position _plane2;
					"InterceptorMarker" setMarkerType "mil_warning";
					"InterceptorMarker" setMarkerText "Intercept";
					_mk1 setMarkerPos _pos2;
					uiSleep 1;
				};
			};  
		};
	
		_counter = 0;

		// Patrol will fly around for 10 minutes, then blow up by itself unless the interceptor shoots it down first
		// Adjust the counter for number of minutes for interceptor to destroy it
		while {(_counter < 20) && (alive _airCraftLead)} do
		{
			sleep 30;
			_counter = _counter + 1;
		};
	};
	
	_titlePatrol = "MAYDAY";
	_messagePatrol = format ["%1 is going down!",_chosenTargetName];

	if (_usingExile) then
	{
		for "_i" from 1 to 3 do
		{
			["systemChatRequest", [format ["%1: %2",_titlePatrol,_messagePatrol]]] call ExileServer_system_network_send_broadcast;
		};
	}else
	{
		for "_i" from 1 to 3 do
		{
			["system", _titlePatrol, _messagePatrol] call FrSB_fnc_announce;
		};
	};

	if (alive _airCraftLead) then
	{  
		diag_log "[DAPE] Times up. Blowing lead aircraft";
		_airCraftLead setDamage 1;
	}; 			
 
	//diag_log "[DAPE] Waiting for crash"; 
	while {(getPos _airCraftLead select 2) > 5} do { sleep 15};
	//diag_log "[DAPE] Crash detected"; 

	if (_interceptorPresent) then
	{
		while {(count (waypoints _interceptor)) > 0} do
		{
			deleteWaypoint ((waypoints _interceptor) select 0);
		};

		//diag_log "[DAPE] Interceptor -- Remaining offensive waypoints deleted";

		_intExitWP = _interceptor addWaypoint [_interceptorExitPos, 0];
		_intExitWP setWaypointType "MOVE";
		_intExitWP setWaypointBehaviour "CARELESS";
		_intExitWP setWaypointspeed "NORMAL";
	   
		_interceptor setCombatMode "BLUE";
	   
		{
		_x disableAI "AUTOTARGET";
		_x disableAI "TARGET";
		_x disableAI "SUPPRESSION";
	   
		} forEach units _interceptor;
	   
		//diag_log "[DAPE] Interceptor Aircraft dismiss order initiated";
	};
	
	if (_debug) then
	{
		private _crashPoint = createMarker ["CrashMarker", (position _airCraftLead)	];  

		_crashPoint setMarkerType "hd_join";
		_crashPoint setMarkerText "Crash";

	};
	 
	_isWater = surfaceIsWater position _airCraftLead;
	 
	diag_log format ["[DAPE] Crash in water?: %1",_isWater];
	 
	 
	if (!_isWater) then
	{
		//diag_log "[DAPE] Aircraft Patrol -- Crash recovey sequence initiated";
		sleep _delayQRF;
	 
		_titleQRF = "WARNING";
		_messageQRF = "A Quick Reaction Force has been dispatched to secure the crash site.  Do not approach or you will be fired on.";
		
		if (_usingExile) then
		{
		
			["toastRequest", ["InfoTitleAndText", [_titleQRF, _messageQRF]]] call ExileServer_system_network_send_broadcast;
		 
			["systemChatRequest", [format ["%1: %2",_titleQRF,_messageQRF]]] call ExileServer_system_network_send_broadcast;
		}else
		{
			["popUp", _titleQRF, _messageQRF] call FrSB_fnc_announce;
			["system", _titleQRF, _messageQRF] call FrSB_fnc_announce;
		};
		
		_landPos = _airCraftLead getPos [50, (random 360)];

		{ _x hideObjectGlobal true } foreach (nearestTerrainObjects [_landPos,["TREE", "SMALL TREE", "BUSH"],40]);
	 
		_helipad = "Land_HelipadEmpty_F" createVehicle _landPos;
		sleep 10;
	 
		_crash = createVehicle ["test_EmptyObjectForFireBig",_airCraftLead,[], 0, "can_collide"];
		_crash setPos [position _airCraftLead select 0,position _airCraftLead select 1, 0.1];
		_crash setVectorUp surfaceNormal position _crash;
		_smoke = createVehicle ["test_EmptyObjectForSmoke",position _airCraftLead,[], 0, "can_collide"];
		_smoke attachTo [_crash, [0.5, -2, 1] ];
		
		_cleanupObjects = [_helipad,_crash,_smoke];
		
	 	_rescueCrew = createGroup [EAST,true];
	 		
		_lootHeli = _rescueHelis call BIS_fnc_selectRandom;

		_spawnRescue = [_startPos, 180, _lootHeli, _rescueCrew] call BIS_fnc_spawnVehicle;
		_chopper = _spawnRescue select 0;
		
		[driver _chopper ] joinSilent _rescueCrew;
		
		_chopper setFuel (0.75+(random 0.25));
		_chopper setVariable ["GONE",false];
		_chopper setVariable ["DESTROYED",false];
		_chopper setVariable ["ExileMoney",0,true];
		_chopper setVariable ["ExileIsPersistent", false];
		_chopper enableRopeAttach false;
		_chopper flyinHeight _patrolHeight;
		
		_chopper addEventHandler ["GetIn",{	params ["_vehicle", "_role", "_unit", "_turret"];if (isPlayer _unit) then {_vehicle setVariable ["GONE",true];};}];
		_chopper addMPEventHandler ["MPKilled",{params ["_vehicle", "_unit"];diag_log "[DAPE] Rescue Chopper Destroyed"; _vehicle setVariable ["DESTROYED",true];}];
		
		if (_lootHeliProtected) then
		{
			_chopper allowDamage false;
		};
		
		
	 	//diag_log format ["[DAPE] Chopper Pos: %1", getPosASL _chopper];

	 
		if (_debug) then
		{    
			[_chopper] spawn
			{
				_chopper1 = _this select 0;
				_pos3 = position _chopper1;
				_mk2 = createMarker ["HeliMarker",_pos3];
				while {alive _chopper1} do
				{    
					_pos3 = position _chopper1;
					"HeliMarker" setMarkerType "mil_warning";
					"HeliMarker" setMarkerText "Rescue";
					_mk2 setMarkerPos _pos3;
					sleep 1;
				};
			};  
		};
	 
		diag_log "[DAPE] Rescue HELO Dispatched";
	 
		_rescueCrew setCombatMode "BLUE";
	 
		_rescueWP1 = _rescueCrew addWaypoint [_landPos, 0];
		_rescueWP1 setWaypointType "GETOUT";
		_rescueWP1 setWaypointBehaviour "CARELESS";
		_rescueWP1 setWaypointspeed "FULL";
	 
		// The loot is the chopper itself, but this adds loot from tables above 

		clearMagazineCargoGlobal _chopper;
		clearWeaponCargoGlobal _chopper;
		clearItemCargoGlobal _chopper;
		clearBackpackCargoGlobal _chopper;
	 
		// Add weapons to the chopper
	 
		for "_i" from 1 to _amountOfWeapons do
		{
			_weapon = _lootWeapons call BIS_fnc_selectRandom;
			_chopper addWeaponCargoGlobal [_weapon,1];
		   
			_magazines = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
			_chopper addMagazineCargoGlobal [(_magazines select 0),round random 8];
		};
	 
		for "_i" from 1 to _amountOfItems do
		{
			_items = _lootItems call BIS_fnc_selectRandom;
			_chopper addMagazineCargoGlobal [_items,1];
		   
		};
		
		
		while {(getPos _chopper select 2) >1} do {sleep 10};
		
		if (_lootHeliProtected) then
		{
			_chopper allowDamage true;
		};
		
		if !(_chopper getVariable "DESTROYED") then
		{
			{
				removeBackpackGlobal _x;
				removeAllWeapons _x;
				_curWeapon = _lootWeapons call BIS_fnc_selectRandom;
				[_x,_curWeapon, 5] call BIS_fnc_addWeapon;
				_x setVariable ["ExileMoney",(floor random _AIMoney),true];
			} forEach units _rescueCrew;
			
			_rescueCrew setCombatMode "RED";
			_rescueCrew allowFleeing 0;
			_rescueWP2 = _rescueCrew addWaypoint [_landPos, 10];
			_rescueWP2 setWaypointType "GETOUT";
			_rescueWP2 setWaypointBehaviour "SAFE";
			_rescueWP2 setWaypointspeed "NORMAL";
		 
			[_rescueCrew, (getPos _chopper), 50] call bis_fnc_taskPatrol;
		 
			// These units come with gear.  If you want custom loot, see next note
			_aiUnits = ["O_G_Soldier_TL_F", "O_G_medic_F","O_G_Soldier_F","O_G_Soldier_AR_F"];
		 
			_HeliAiUnits = [(getPos _chopper), EAST, _aiUnits,[],[],[0.5,0.9],[],[],(random 360)] call BIS_fnc_spawnGroup;
			_HeliAiUnits deleteGroupWhenEmpty true;
			//Add waypoint for the AI
			_HeliCrashGroupLeader = leader _HeliAiUnits;
			_HeliCrashUnitsGroup = group _HeliCrashGroupLeader;
			
		 
			//  This will remove the gear of the units above and add weapons from the defined loot table above
			{
				removeBackpackGlobal _x;
				removeAllWeapons _x;
				_curWeapon = _lootWeapons call BIS_fnc_selectRandom;
				[_x,_curWeapon, 5] call BIS_fnc_addWeapon;
				_x setVariable ["ExileMoney",(floor random _AIMoney),true];
			} forEach units _HeliAiUnits;
		 
			_HeliAIUnits allowFleeing 0;
		 
			_HeliCrashUnitsGroup addWaypoint [position _crash, 0];
			[_HeliCrashUnitsGroup, 0] setWaypointType "GUARD";
			[_HeliCrashUnitsGroup, 0] setWaypointBehaviour "AWARE";
			
			_heli_marker = createMarker ["DAPE_Marker", _crash];
			_heli_marker setMarkerColor "ColorOrange";
			_heli_marker setMarkerAlpha 1;
			_heli_marker setMarkerText "Rescue Mission";
			_heli_marker setMarkerType "o_air";
			_heli_marker setMarkerBrush "Vertical";
			_heli_marker setMarkerSize [(1.25), (1.25)];
			
			sleep 60;
			
			private _objects = 	[
									["Land_Bodybag_01_black_F",_crash,[0,0,1],[true,false]], 
									["Land_Bodybag_01_black_F",_crash,[0,0,1],[true,false]]
								];
			{
				_object = (_x select 0) createVehicle ((_x select 1) getPos [5, (random 360)]);
				_object enableSimulationGlobal ((_x select 3) select 0);
				_object allowDamage ((_x select 3) select 1);
				_object setDir (random 360);
				_object setVectorUp (surfaceNormal (position _object));
				_cleanupObjects pushBack _object;
			} forEach _objects;
		};
		
		while {(!(_chopper getVariable "GONE") && !(_chopper getVariable "DESTROYED"))} do {sleep 10};

		_titleEnd = "CONGRATS!";
		_messageEnd = "The rescue heli has been stolen!";

		if (_usingExile) then
		{
			if (_lootHeliPersist) then
			{
				_chopper setVariable ["ExileIsPersistent", true];
				_chopper setVariable ["ExileAccessCode", _pinCode];
				_chopper setVariable ["ExileOwnerUID", "FuMS_PersistentVehicle"];
				_chopper setVariable ["ExileIsLocked",-1];
				_chopper lock 0;
				_chopper call ExileServer_object_vehicle_database_insert;
				_chopper call ExileServer_object_vehicle_database_update;
				_messageEnd = ["The rescue heli has been stolen! The PIN is ",_pincode] joinString "";
			
			};	
		};
		
		if (_chopper getVariable "DESTROYED") then
		{
			_titleEnd = "Womp womp!";
			_messageEnd = "The rescue heli has been destroyed!";
		};
	
		diag_log format ["[DAPE] Heli gone, cleaning up mission| Persist:%1 | _messageEnd:%2, | _pincode:%3",_lootHeliPersist,_messageEnd,_pincode];
		
		if (_usingExile) then
		{
			["toastRequest", ["SuccessTitleAndText", [_titleEnd, _messageEnd]]] call ExileServer_system_network_send_broadcast;
		 
			["systemChatRequest", [format ["%1: %2",_titleEnd,_messageEnd]]] call ExileServer_system_network_send_broadcast;
		}else
		{
			["popUp", _titleEnd, _messageEnd,[RGBA_WHITE,RGB_RED]] call FrSB_fnc_announce;
			["system", _titleEnd, _messageEnd] call FrSB_fnc_announce;
		};	
		
		deleteMarker "DAPE_Marker";
		
		if (_debug) then
		{
			deleteMarker "HeliMarker";
			deleteMarker "InterceptorMarker";
			deleteMarker "PatrolMarker";
			deleteMarker "CrashMarker";
		};
		
		sleep 300; // Wait 5 minutes and then clean up remnants

		{
			deleteVehicle _x;
		} forEach _cleanupObjects;
		
		{
			deleteVehicle _x;
		} forEach units _rescueCrew;
		
		if !(_HeliAiUnits isEqualTo grpNull) then
		{
			{
				deleteVehicle _x;
			} forEach units _HeliAiUnits;
		};
		
		deleteVehicle _airCraftLead;
	}
	else
	{
		diag_log "[DAPE] AIRCRAFT crashed in water -- Terminating rescue sequence";
		deleteVehicle _airCraftLead;
	};
	 
	uiSleep 120;
	
	if (_interceptorPresent) then
	{
		deleteVehicle _interceptorAircraft;
	};
	
	if (_debug) then
	{

		deleteMarker "PatrolMarker";
		deleteMarker "CrashMarker";
		if (_interceptorPresent) then {deleteMarker "InterceptorMarker";};
	};
};