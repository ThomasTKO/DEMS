/**
 * DyCE_spawnConvoy
 * © 2019 TheOneWhoKnocks
 * Use IsEqualTo and IsEqualType
 *
 */
 
//private["_playerCanEnter","_vehicleAlertContent","_vehicleAlertTitle","_convoyAlertVehicle","_convoyMarkerVehicle","_DyCE_maxConvoyIdleTime","_newConvou","_speedLimitedVehicle","_groupVehicle","_vehLMGs","_countWeaponVehicle","_vehBackpack_bots","_countBackpackVehicle","_vehItemmy","_countItemVehicle","_allRoads","_radiusSpawnListConvoy","_roads","_roadses","_convoyConfigs","_bildings","_exileMoneyMin","_exileMoneyMid","_randomMoney","_exileMoneyMax","_maxConvoyStoppedTime"];
private["_debug", "_convoyConfigs","_allRoads","_spawnConvoyLocation","_spawnRadius","_vehicleSpawnPoints",
		"_vehicleItemCount","_vehicleItems","_vehicleBackpackCount","_vehicleBackpacks","_vehicleWeaponCount","_vehicleWeapons",
		"_newConvoy","_chosenConvoy", "_convoyType", "_playerCanGetIn", "_vehicleShowMarker", "_vehicleMarkerColor",
			"_vehicleMarkerText", "_convoyAnnounce", "_convoyAnnounceTitle", "_convoyAnnounceText", 
			"_convoySpeedLimit", "_vehicleMoneyMin", "_vehicleMoneyMax","_vehicleDynamicLoot", "_allConvoyVehicles", 
			"_vehicleMoneyMid", "_vehicleMoney","_vehicle", "_vehClassname", "_vehAI", "_vehStaticLoot", "_vehHeight",
			"_spawnVehicleLoc","_indexVehSpawn","_spawnVehiclePos", "_vehicleNum", "_nextVehicleNum", "_vehName",
			"_vehMarker", "_special","_endWaypoint","_begMarker","_destMarker"];

// missionNamespace getVariable "";
_convoyConfigs = missionNamespace getVariable "DyCE_ConvoyConfigs"; //POLISHED
_maxConvoyIdleTime = missionNamespace getVariable "DyCE_maxConvoyIdleTime";//POLISHED
_maxConvoyStoppedTime = missionNamespace getVariable "DyCE_maxConvoyStoppedTime";//POLISHED

_allRoads = [0,0,0] nearRoads 50000;//POLISHED
_spawnConvoyLocation = getPos (selectRandom _allRoads);//POLISHED
_spawnRadius = missionNamespace getVariable ["DyCE_radiusSpawnVehicle",100];//POLISHED
_vehicleSpawnPoints = _spawnConvoyLocation nearRoads _spawnRadius;//POLISHED

_vehicleItemCount = missionNamespace getVariable ["DyCE_countItemVehicle",0];//POLISHED
_vehicleItems = missionNamespace getVariable ["DyCE_Loot_VehicleItems",[]];//POLISHED
_vehicleBackpackCount = missionNamespace getVariable ["DyCE_countBackpackVehicle",0];//POLISHED
_vehicleBackpacks = missionNamespace getVariable ["DyCE_Loot_VehicleBackpacks",[]];//POLISHED
_vehicleWeaponCount = missionNamespace getVariable ["DyCE_countWeaponVehicle",0];//POLISHED
_vehicleWeapons = missionNamespace getVariable ["DyCE_Loot_VehicleWeapons",[]];//POLISHED

_newConvoy = [];//POLISHED


///////////////////////////////////////
// DEBUG MODE /////////////////////////
///////////////////////////////////////

_debug = missionNamespace getVariable "DyCE_debug"; //POLISHED


if (_debug) then//POLISHED
{//POLISHED
	diag_log format ["[DyCE] _debug: %1",_debug];//POLISHED
};//POLISHED

if((count _convoyConfigs) > 0)then//POLISHED
{
    _chosenConvoy = selectRandom _convoyConfigs;//POLISHED
	_convoyType = _chosenConvoy select 0;//POLISHED
	_convoyData = _chosenConvoy select 1;//POLISHED
	
	if (_debug) then//POLISHED
	{
		diag_log format ["[DyCE] (fn_SpawnConvoy) _convoyData: %1",_convoyData];//POLISHED
	};
	

	_playerCanGetIn = _convoyData select 0;//POLISHED
	_vehicleShowMarker = _convoyData select 1;//POLISHED
	_vehicleMarkerColor = _convoyData select 2;//POLISHED
	_vehicleMarkerText = _convoyData select 3;//POLISHED
	_convoyAnnounce = _convoyData select 4;//POLISHED
	_convoyAnnounceTitle   = _convoyData select 5;//POLISHED
	_convoyAnnounceText = _convoyData select 6;//POLISHED
	_convoySpeedLimit = _convoyData select 7;//POLISHED
	_vehicleMoneyMin = _convoyData select 8;//POLISHED
	_vehicleMoneyMax = _convoyData select 9;//POLISHED
	_vehicleDynamicLoot = _convoyData select 12;//POLISHED
	_allConvoyVehicles = _convoyData select 13;//POLISHED

	_vehicleMoneyMid = _vehicleMoneyMin + ((_vehicleMoneyMax - _vehicleMoneyMin) / 2);//POLISHED
	_vehicleMoney = ceil(random[_vehicleMoneyMin,ceil(_vehicleMoneyMid),_vehicleMoneyMax]);//POLISHED
	
	if !(_allConvoyVehicles isEqualTo []) then//POLISHED
	{
	    if !(_vehicleSpawnPoints isEqualTo []) then//POLISHED
		{
		    if ((count _vehicleSpawnPoints) > (count _allConvoyVehicles)) then//POLISHED
			{
				
				if (_debug) then//POLISHED
				{
					diag_log format["[DyCE] fn_spawnConvoy spawning new convoy type: %1",_convoyType];//POLISHED
					diag_log format["[DyCE] fn_spawnConvoy spawning new convoy all: %1",_allConvoyVehicles];//POLISHED		
				};
				
				
				{	// Beginning of forEach _allConvoyVehicles
					_vehClassname = _x select 0;//POLISHED
					_vehAI = _x select 1;//POLISHED
					_vehStaticLoot = _x select 2;//POLISHED
					_vehHeight = _x select 3;//POLISHED

					_spawnVehicleLoc = selectRandom _vehicleSpawnPoints;//POLISHED
					_indexVehSpawn = _vehicleSpawnPoints find _spawnVehicleLoc;//POLISHED
					_spawnVehiclePos = getPos _spawnVehicleLoc;//POLISHED
					_vehicleSpawnPoints deleteAt _indexVehSpawn;//POLISHED

					_vehicleNum = missionNamespace getVariable "DyCE_nextVehicleNumber";//POLISHED
					_nextVehicleNum = _vehicleNum + 1;//POLISHED
					missionNamespace setVariable ["DyCE_nextVehicleNumber",_nextVehicleNum];//POLISHED
					_vehName = format["vehicle-%1",_nextVehicleNum];//POLISHED
					
					if (_debug) then//POLISHED
						{//POLISHED
							diag_log format["[DyCE] fn_spawnConvoy spawning vehicle (%3) classname: %2 | Convoy type %1",_convoyType,_vehClassname,_vehName];//POLISHED
							_begMarker = createMarker [format ["SP-%1",_nextVehicleNum],_spawnVehiclePos];//POLISHED
							_begMarker setMarkerType "mil_dot";//POLISHED
							_begMarker setMarkerText "Convoy-SP";//POLISHED
							_begMarker setMarkerColor "ColorRed";//POLISHED
							_begMarker setMarkerBrush "Solid";//POLISHED
							_begMarker setMarkerPos _spawnVehiclePos;//POLISHED
							
						};


					
					_special = "NONE";//POLISHED
					if (_vehHeight > 0) then//POLISHED
					{
						_special = "FLY";//POLISHED
					};
					_vehicle = createVehicle [_vehClassname, _spawnVehiclePos, [], _vehHeight, _special];//POLISHED
					_thisvehicle = _vehicle;//?????
					_vehicle setPos _spawnVehiclePos;//POLISHED
					_vehicle setVehicleVarName _vehName;//POLISHED
					clearItemCargoGlobal _vehicle;//POLISHED
					clearWeaponCargoGlobal _vehicle;//POLISHED
					clearMagazineCargoGlobal _vehicle;//POLISHED
					clearBackPackCargoGlobal _vehicle;//POLISHED
					
					if (_vehicleShowMarker) then //POLISHED
					{
						
						_vehMarker = createMarker [_vehName, _spawnVehiclePos];//POLISHED
						_vehMarker setMarkerType "mil_circle";//POLISHED
						_vehMarker setMarkerColor _vehicleMarkerColor;//POLISHED
						_vehMarker setMarkerText _vehicleMarkerText;//POLISHED
						_vehMarker setMarkerBrush "Solid";//POLISHED
						
						/*
						[_vehicle,_vehName,_vehicleMarkerText,_vehicleMarkerColor] spawn
							{
								_target = _this select 0;
								_targetName = _this select 1;
								_targetText = _this select 2;
								_targetMarkerColor = _this select 3;
								_currPos = position _target;
								_vehMarker = createMarker [_targetName,_currPos];
								while {alive _target} do
								{    
									_currPos = position _target;
									_vehMarker setMarkerType "mil_circle";
									_vehMarker setMarkerText _targetText;
									_vehMarker setMarkerColor _targetMarkerColor;//POLISHED
									_vehMarker setMarkerBrush "Solid";//POLISHED
									_vehMarker setMarkerPos _currPos;
									uiSleep 1;
								};
							}; 
							*/
					};

					
					
					
					if !(_vehStaticLoot isEqualTo []) then//POLISHED
					{
						{
							_classStatic = _x select 0;//POLISHED
							_countStatic = _x select 1;//POLISHED
							_typeStatic = _x select 2;//POLISHED
							
							switch (_typeStatic) do//POLISHED
							{
								case 1: {_vehicle addWeaponCargoGlobal [_classStatic, _countStatic];};//POLISHED
								case 2: {_vehicle addMagazineCargoGlobal [_classStatic, _countStatic];};//POLISHED
								case 3: {_vehicle addBackpackCargoGlobal [_classStatic, _countStatic];};//POLISHED
								case 4: {_vehicle addItemCargoGlobal [_classStatic, _countStatic];};//POLISHED
								default {diag_log format ["[DyCE] fn_spawnConvoy wrong type for item %1 in static loot for %2 in convoy type %3",_classStatic,_vehName,_convoyType]};//POLISHED
							};
							
							if (_debug) then//POLISHED
							{
								diag_log format ["[DyCE] fn_spawnConvoy adding item %1 in static loot to %2 in convoy type %3",_classStatic,_vehName,_convoyType];//POLISHED
							};
						}forEach _vehStaticLoot;//POLISHED
					};
					
					if (_vehicleDynamicLoot) then//POLISHED
					{
						_countIV = (_vehicleItemCount select 0) + round random ((_vehicleItemCount select 1) - (_vehicleItemCount select 0));//POLISHED
						for "_i" from 1 to _countIV do//POLISHED
						{
							if (count(_vehicleItems) > 0) then//POLISHED
							{
								_itemVeh =  selectRandom _vehicleItems;//POLISHED
								_vehicle addItemCargoGlobal [_itemVeh,1];//POLISHED
							};
						};
						
						_countBV = (_vehicleBackpackCount select 0) + round random ((_vehicleBackpackCount select 1) - (_vehicleBackpackCount select 0));//POLISHED
						for "_i" from 1 to _countBV do//POLISHED
						{
							if (count(_vehicleBackpacks) > 0) then//POLISHED
								{
									_bpVeh = selectRandom _vehicleBackpacks;//POLISHED
									_vehicle addBackpackCargoGlobal [_bpVeh,1];//POLISHED
								};
						};
						
						_countWV = (_vehicleWeaponCount select 0) + round random ((_vehicleWeaponCount select 1) - (_vehicleWeaponCount select 0));//POLISHED
						for "_i" from 1 to _countWV do//POLISHED
						{
							if (count(_vehicleWeapons) > 0) then//POLISHED
							{
								_wpn = selectRandom _vehicleWeapons;//POLISHED
								_vehicle addMagazineCargoGlobal [(_wpn select 1),(_wpn select 2)];//POLISHED
								_vehicle addWeaponCargoGlobal [(_wpn select 0),1];//POLISHED
							};
						};
					};
					
					_vehicle setVariable ["ExileMoney", _vehicleMoney, true];//POLISHED
					_vehicle setVariable ["DyCE_AICount",_vehAI];//POLISHED
					_vehicle setVariable ["DyCE_StartPosition",_spawnVehiclePos];//POLISHED
					_vehicle setVariable ["DyCE_VehicleName",_vehName];//POLISHED
					_vehicle setVariable ["DyCE_ConvoyType",_convoyType];//POLISHED
					_vehicle setVariable ["DyCE_MarkerEnabled",_vehicleShowMarker];//POLISHED
					_vehicle setVariable ["DyCE_maxConvoyIdleTime",(time + _maxConvoyIdleTime)];//POLISHED
					_vehicle setVariable ["DyCE_maxConvoyStoppedTime",(time + _maxConvoyStoppedTime)];//POLISHED
					_vehicle setVariable ["DyCE_AIonFootTime",(time + 100)];//POLISHED
					_vehicle setVariable ["DyCE_AIonFoot",false];//POLISHED
					_vehicle setVariable ["DyCE_ConvoySlowPartner",false];//POLISHED
					_vehicle setVariable ["DyCE_ConvoyPartners",[]];//POLISHED
					
					if (_debug) then//POLISHED
					{//POLISHED
						_vehicle setVariable ["DyCE_DebugMarkers",[_begMarker]];
					};
					
					if (_newConvoy isEqualTo []) then//POLISHED
					{
						_vehicle setVariable ["DyCE_LeadVehicle",true];//POLISHED
						_vehicle setVariable ["DyCE_StartMove",1];//POLISHED
					}else//POLISHED
					{
						_vehicle setVariable ["DyCE_LeadVehicle",false];//POLISHED
						_vehicle setVariable ["DyCE_StartMove",0];//POLISHED
					};
					
					if (_playerCanGetIn) then//POLISHED
					{
						_vehicle setVariable ["DyCE_PlayerAllowedToTake",true];//POLISHED
					}else//POLISHED
					{
						_vehicle setVariable ["DyCE_PlayerAllowedToTake",false];//POLISHED
					};
					
					_vehicle addEventHandler ["GetIn", "[_this select 0, _this select 2] call DyCE_fnc_PlayerGetIn"];//SHINY
					
					_newConvoy pushBack _vehicle;//POLISHED
					_AIgroup = _vehicle call DyCE_fnc_spawnConvoyAI;//POLISHED
					_AIgroup addVehicle _vehicle;//POLISHED
					_AIgroup setVariable ["timeOutHold",(time + 40)];//SHINY
					
					_vehicle setVariable ["DyCE_AIGroup",_AIgroup];//POLISHED
					_vehicle setVariable ["statusWaypoint","GETIN"];//SHINY
					sleep 1;//POLISHED
				} forEach _allConvoyVehicles;  //POLISHED
				
				// If new convoy creation was successful, add to the main ConvoyArray
				
				if !(_newConvoy isEqualTo []) then//POLISHED
				{//POLISHED
					_masterConvoyList = missionNamespace getVariable "DyCE_masterConvoyArray";//POLISHED
					_masterConvoyList pushBack _newConvoy;//POLISHED
					missionNamespace setVariable ["DyCE_masterConvoyArray",_masterConvoyList,true];//POLISHED
					if (_convoyAnnounce) then//POLISHED
					{//POLISHED\
						["toastRequest", ["InfoTitleAndText", [_convoyAnnounceTitle, _convoyAnnounceText]]] call ExileServer_system_network_send_broadcast;
						//["popUp",_convoyAnnounceTitle, _convoyAnnounceText] call FrSB_fnc_announce;//POLISHED
					}; //POLISHED
				};//POLISHED
				sleep 5;//POLISHED
				
				// Find a good position over 2K away
				_goodPos = false;//POLISHED
			
				while {!_goodPos} do//POLISHED
				{//POLISHED
					_goodPosDist = 0;//POLISHED
					while {_goodPosDist < 2000} do//POLISHED
					{
						_endWaypoint = getPos (selectRandom _allRoads);//POLISHED
						_goodPosDist = _spawnConvoyLocation distance2D _endWaypoint;//POLISHED
						if (_debug) then//POLISHED
						{//POLISHED
							diag_log format ["[DyCE] spawnConvoy secondWP: %1 | dist: %2",_endWaypoint,_goodPosDist];//POLISHED
						};//POLISHED
						
					};
					_goodPos = true;//POLISHED
					
				};

				if !(_endWaypoint isEqualTo []) then//POLISHED
				{//POLISHED
					{//POLISHED
					    if (typeName _x == "OBJECT")then//POLISHED
						{//POLISHED
						    _AIgroup = _x getVariable ["DyCE_AIGroup",grpNull];//POLISHED
							if !(_AIgroup isEqualTo grpNull) then//POLISHED
							{//POLISHED
							    //[getPos _x,_groupVehicle, _x] call DyCE_fnc_addWaypointGetIn;//POLISHED
								[_endWaypoint,_AIgroup] call DyCE_fnc_addWaypoint;//POLISHED
								
								{//POLISHED
									_x enableAI "ALL";//POLISHED
								}forEach units _AIgroup;//POLISHED
								
								if (_debug) then//POLISHED
								{//POLISHED
									_destMarker = createMarker ["Convoy-EP",_endWaypoint];//POLISHED
									_destMarker setMarkerType "mil_dot";//POLISHED
									_destMarker setMarkerText "Convoy-EP";//POLISHED
									_destMarker setMarkerColor "ColorRed";//POLISHED
									_destMarker setMarkerBrush "Solid";//POLISHED
									_destMarker setMarkerPos _endWaypoint;
								};
							};//POLISHED
						    _x setVariable ["DyCE_EndPosition",_endWaypoint];//POLISHED
							
							if (_debug) then//POLISHED
							{//POLISHED
								_x setVariable ["DyCE_DebugMarkers",[_begMarker,_destMarker]];
							};
							_x limitSpeed _convoySpeedLimit;//POLISHED
							
						};//POLISHED
					} forEach _newConvoy;//POLISHED
				};
			};
		};
	};
};
true