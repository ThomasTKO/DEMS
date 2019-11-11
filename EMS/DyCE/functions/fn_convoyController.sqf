 /**
 * DyCE_fnc_ConvoyEventManager
 * © 2019 TheOneWhoKnocks
 *
 */
//private["_startMove","_statusWaypoint","_timeOutHold","_markerEnable","_minPlayers","_convoyDelay","_maxNumConvoys","_nextConvoyStartTime","_stop","_maxConvoyLifeTime","_maxConvoyIdleTime","_positionNewWaypoint","_minus","_newTempConvoy","_convoySpeedLimit","_convoyType","_vehicleMarkerColor","_vehicleMarkerText","_firstVehicle","_indexVehicle","_vehicleEndPos","_thisVehicle","_waypoint1Type","_allConvoys","_vehicleName","_AIgroup","_unitVehicle","_newAllConvoys","_vehicleWayPosition","_radiusNoPlayer","_newgroup","_vehicleStartPos","_DyCE_AIonFoot","_DyCE_AIonFootTime","_maxConvoyStopTime","_excludeVehicle","_AIcrew"];

private["_convoyConfigs","_allConvoys","_nextConvoyStartTime","_radiusNoPlayer","_maxConvoyIdleTime","_maxConvoyStoppedTime","_minPlayers",
		"_maxNumConvoys","_convoyDelay","_newAllConvoys","_newgroup"];

_debug = missionNamespace getVariable "DyCE_debug"; //POLISHED
_convoyConfigs = missionNamespace getVariable "DyCE_ConvoyConfigs"; //POLISHED
_allConvoys = missionNamespace getVariable "DyCE_masterConvoyArray";//POLISHED
_nextConvoyStartTime = missionNamespace getVariable "DyCE_nextConvoyStartTime";//POLISHED
_radiusNoPlayer = missionNamespace getVariable "DyCE_radiusNoPlayer";//POLISHED
_maxConvoyIdleTime = missionNamespace getVariable "DyCE_maxConvoyIdleTime ";//POLISHED
_maxConvoyStoppedTime = missionNamespace getVariable "DyCE_maxConvoyStoppedTime";
_minPlayers = missionNamespace getVariable "DyCE_minPlayerOnline";//POLISHED
_maxNumConvoys = missionNamespace getVariable "DyCE_maxConvoys";//POLISHED
_convoyDelay = missionNamespace getVariable "DyCE_convoyDelay";//POLISHED

_newAllConvoys = [];//POLISHED
_newgroup = objNull;

if (_debug) then
{
	diag_log format["[DyCE] (convoyController start) AllConvoys: %1 | time:%2",_allConvoys,time];//POLISHED
};

if !(_allConvoys isEqualTo []) then//POLISHED
{	// _allConvoys is blank, skip to end to create first vehicle	//POLISHED
    {	//Starts: forEach _allConvoys (Convoy as a whole) //POLISHED
	    _firstVehicle = objNull;//POLISHED
		_indexVehicle = 0;//?????
		_newTempConvoy = [];//POLISHED
		_positionNewWaypoint = [];//?????
		//_stop = 0;//?????Not needed
		{	//Starts: forEach _x (each vehicle in convoy) //POLISHED 
		    if !(_x isEqualTo objNull) then //If vehicle exists (EC)
			{
				_excludeVehicle = false;//???? (Signals vehicle is no longer to be monitored?)
				_vehicleName = _x getVariable ["DyCE_VehicleName",""];//POLISHED
				_AIgroup = _x getVariable ["DyCE_AIGroup",grpNull];//SHINY CONSIDER NEW GV NAME
				_timeOutHold = _AIgroup getVariable ["timeOutHold",0];//?????

				_vehicleStartPos = _x getVariable ["DyCE_StartPosition",[]];//POLISHED
				_vehicleEndPos = _x getVariable ["DyCE_EndPosition",[]];//POLISHED
				_maxConvoyIdleTime = _x getVariable ["DyCE_maxConvoyIdleTime",0];//?????
				_maxConvoyStopTime = _x getVariable ["DyCE_maxConvoyStoppedTime",0];//?????

				_AIonFootTime = _x getVariable ["DyCE_AIonFootTime",false];//POLISHED - 
				_AIonFoot = _x getVariable ["DyCE_AIonFoot",false];//?????
				_markerEnable = _x getVariable ["DyCE_MarkerEnabled",false];//POLISHED
				_statusWaypoint = _x getVariable ["statusWaypoint",""];//?????
				_startMove = _x getVariable ["DyCE_StartMove",0];//?????
				_vehiclePos = getPos _x;//POLISHED
				_thisVehicle = _x;//POLISHED
				
				_convoyType = _x getVariable ["DyCE_ConvoyType",""];//POLISHED
				_convoyPartners = _x getVariable ["DyCE_ConvoyPartners",[]];
				_convoySlowPartner = _x getVariable ["DyCE_ConvoySlowPartner",false];
				_convoyDebugMarkers = _x getVariable ["DyCE_DebugMarkers",[]];
				
				_convoyIndex = [_convoyConfigs,_convoyType] call BIS_fnc_findNestedElement;
				//diag_log format ["[DyCE] spawnAI _convoyIndex:%1",_convoyIndex];
				_convoyData = (_convoyConfigs select (_convoyIndex select 0)) select 1;//POLISHED
				//diag_log format ["[DyCE] spawnAI temp :%2 | _convoyData:%1",_convoyData,_temp];
				
				_vehicleMarkerText = _convoyData select 3;//POLISHED
				_vehicleMarkerColor = _convoyData select 2;//POLISHED
				_convoySpeedLimit = _convoyData select 7;//POLISHED

				_minus = 20;//?????
				_AIcrew = crew _x;//POLISHED NOTE: DEAD AND ALIVE!
				_playerInVehicle = false;//POLISHED
				
				{//POLISHED
				    if (isPlayer _x) then //POLISHED
					{//POLISHED
					    _playerInVehicle = true;//POLISHED
					};//POLISHED
				}forEach _AIcrew;//POLISHED
				
				if (_playerInVehicle) then//POLISHED
				{//POLISHED
					// This should clear all programming from the vehicle, make is ownable, etc
				    if (_vehicleName in allMapMarkers) then//POLISHED
					{//POLISHED
						deleteMarker _vehicleName;//POLISHED
					};//Jumps to end bypassing adding to convoy and will drop out of monitoring next round
				}else//POLISHED
				{	//Convoy exists, vehicle exists, player has not entered vehicle yet
					if !(_AIgroup isEqualTo grpNull) then//POLISHED
					{	//Convoy exists, vehicle exists, player has not entered vehicle yet, AI group exists				
						_waypoint2Type = "";//?????
						if (count (waypoints _AIgroup) > 0) then//POLISHED
						{	//Convoy exists, vehicle exists, player has not entered vehicle yet, AI group exists, one or more waypoint exists				
							_waypoint1Type = waypointType ((waypoints _AIgroup) select 0);
							//diag_log format["[DyCE] (convoyController) waypoint1 type: %1, waypoint1 pos(ATL):%2, position %3",_waypoint1Type,(getPosATL _waypoint1Type),(getPos _waypoint1Type)];//POLISHED
							
							if !(waypointType ((waypoints _AIgroup) select 1) isEqualTo "") then//POLISHED
							{	//Second waypoint exists and is labeled//POLISHED
								_waypoint2Type = waypointType ((waypoints _AIgroup) select 1)//POLISHED
								//diag_log format["[DyCE] (convoyController) _waypoint2Type type: %1, _waypoint2Type pos(ATL):%2, position %3",_waypoint2Type,(getPosATL _waypoint2Type),(getPos _waypoint2Type)];//POLISHED
							
							};//POLISHED
							
							//Convoy exists, vehicle exists, player has not entered vehicle yet, AI group exists, one or more waypoint exists//POLISHED
							if ((damage _x) == 1) then
							{	//...but this vehicle has been destroyed
								_list = {isPlayer _x} count (_vehiclePos nearEntities ["CAManBase",_radiusNoPlayer]);//POLISHED
								if(_list == 0)then//POLISHED
								{	//...and there are no players around, remove vehicle from monitor//POLISHED
								
									if (_debug) then
									{
										diag_log format["[DyCE] (convoyController) Vehicle (%2) has been destroyed, convoy type:%1. No players found in the vicinity, deleting vehicle",_convoyType,_vehicleName];//POLISHED
									};
									
									{//POLISHED
										if(alive _x)then{//POLISHED
											deleteVehicle _x;//POLISHED
										};//POLISHED
									}forEach units _AIgroup;//POLISHED
									deleteVehicle _x;//POLISHED
								}else//POLISHED
								{//POLISHED
									
									if (_debug) then
									{
										diag_log format["[DyCE] (convoyController) Vehicle (%2) has been destroyed, convoy type:%1. Players found in the vicinity, removing marker, leaving AI",_convoyType,_vehicleName];//POLISHED
									};
									_AIgroup call DyCE_fnc_clearWaypoints;//SHINY (USE CBA FUNCTION?)
									_waypoint = _AIgroup addWaypoint [(getPos _x), 50];//POLISHED
									_waypoint setWaypointType "SAD";//POLISHED
									_waypoint setWaypointCombatMode "RED";//POLISHED
									_waypoint setWaypointSpeed "NORMAL";//POLISHED
									_waypoint setWaypointBehaviour "AWARE";//POLISHED
									_thisVehicle setVariable ["statusWaypoint","SAD"];//POLISHED
								};	//POLISHED
								_excludeVehicle = true;//POLISHED - 1
								
								_currVehicle = _x;
								{	// Releasing convoy partners if destroyed
									if !(_x == _currVehicle) then
									{
										_x setVariable ["DyCE_ConvoySlowPartner",false];//POLISHED
									};
								}forEach _convoyPartners;

								{
									if (_x in allMapMarkers) then//POLISHED
									{//POLISHED
										deleteMarker _x;//POLISHED
									};//POLISHED
								} forEach _convoyDebugMarkers;
								
								
								if (_vehicleName in allMapMarkers) then//POLISHED
								{//POLISHED
									deleteMarker _vehicleName;//POLISHED
								};//POLISHED
								
							}else//POLISHED
								// Convoy exists, vehicle exists, player has not entered vehicle yet, AI group exists, one or more waypoint exists//POLISHED
							{	//...and vehicle has not been destroyed
								if ((_vehicleEndPos distance2D (getPos _x)) < 150) then
								{	//...but the vehicle is less than 150m from the end point, so close enough
									_list = {isPlayer _x} count (_vehiclePos nearEntities ["CAManBase",_radiusNoPlayer]);//POLISHED
									if(_list == 0)then//POLISHED
									{	//...and there are no players in the area
										
										if (_debug) then
										{
											diag_log format["[DyCE] (convoyController) Vehicle (%2) has arrived at destination, convoy type:%1. No players found in the vicinity, removing vehicle",_convoyType,_vehicleName];//POLISHED
										};

										_currVehicle = _x;
										{	// Releasing convoy partners if destroyed
											if !(_x == _currVehicle) then
											{
												_x setVariable ["DyCE_ConvoySlowPartner",false];//POLISHED
											};
										}forEach _convoyPartners;

										{
											if (_x in allMapMarkers) then//POLISHED
											{//POLISHED
												deleteMarker _x;//POLISHED
											};//POLISHED
										} forEach _convoyDebugMarkers;

										
										
										{//POLISHED
											if(alive _x)then//POLISHED
											{//POLISHED
												deleteVehicle _x;//POLISHED
											};//POLISHED
										}forEach units _AIgroup;//POLISHED
										
										if (_debug) then
										{
											diag_log format["[DyCE] (convoyController) allMapMarkers: %1 | _vehicleName:%2",allMapMarkers,_vehicleName];//POLISHED
										};
										
										if (_vehicleName in allMapMarkers) then//POLISHED
										{//POLISHED
											deleteMarker _vehicleName;//POLISHED
										};//POLISHED
										deleteVehicle _x;//POLISHED
										_excludeVehicle = true;//POLISHED - 2
									};//POLISHED
								}else//POLISHED
								{	//...and the vehicle is more than 150m from the endpoint//POLISHED
									_limitSpeed = false;  // Do not limit unless..//POLISHED
									_currVehicle = _x;
									{	// Checks to see if any of the AI are not in the vehicle//POLISHED

										if (!(_x in _currVehicle)) then//POLISHED
										{	// ...this AI is out of the vehicle//POLISHED
											_AIonFoot = true;//POLISHED
											_limitSpeed = true; //...then limit the speed until the AI gets back in//POLISHED

											{
												_x setVariable ["DyCE_ConvoySlowPartner",true];//POLISHED
												if (_debug) then
												{	// Notify rest of convoy
													diag_log format["[DyCE] (convoyController-AIcheck) Vehicle (%1) notifying convoy partner (%2) of AI on foot",_currVehicle,_x];//POLISHED
												};
											}forEach _convoyPartners;
											
											if (_debug) then
											{
												diag_log format["[DyCE] (convoyController-AIcheck) Vehicle (%1) AI(%2) damage (%4) distance from vehicle:%3",_thisVehicle,_x,_x distance2D _thisVehicle,damage _x];//POLISHED
											};
										};//POLISHED
										

									}forEach units _AIgroup;//POLISHED
									
						
									if (_debug) then
									{	// Notify rest of convoy
										diag_log format["[DyCE] (convoyController) Vehicle (%1) AI on foot:%2",_x,_AIonFoot];//POLISHED
									};
									
									
									
									if (_AIonFoot) then//POLISHED
									{	// Set vehicle flag
										_x setVariable ["DyCE_AIonFoot",true];
									};/*else
									{
										_x setVariable ["DyCE_AIonFoot",false];
										{
											_x setVariable ["DyCE_ConvoySlowPartner",false];//POLISHED
											if (_debug) then
											{	// Notify rest of convoy
												diag_log format["[DyCE] (convoyController) Vehicle (%1) has been notified that we have no AI on foot",_x];//POLISHED
											};
										}forEach _convoyPartners;
									};*/
									
									
									
									
									
									///////////////////////////////////////////////////////////////////
									
									
									
									
									
									
									if (_convoySlowPartner) then//POLISHED
									{	// ...but some other convoy member is slow//POLISHED
										_limitSpeed = true; //...then limit the speed until the AI gets back in//POLISHED
										
										if (_debug) then
										{
											diag_log format["[DyCE] (convoyController) Vehicle (%1) has a slow convoy partner",_thisVehicle];//POLISHED
										};
									};//POLISHED
									
									if (_limitSpeed) then//POLISHED
									{	//AI are out of vehicle, maybe fighting, so slow vehicle down (SET VARIABLE FOR FUTURE COMMUNICATIONS)
										
										if (_debug) then
										{	// Slow driver down but keep moving
											diag_log format["[DyCE] (convoyController) Vehicle (%1) has been speed limited",_thisVehicle];//POLISHED
										};
										
										_x limitSpeed 5;//POLISHED

										
										if (_debug) then
										{
											diag_log format["[DyCE] (convoyController) Vehicle (%1) AI timer:%2 | time:%3",_thisVehicle,_AIonFootTime,time];//POLISHED
										};
										
										if (_AIonFootTime < time) then//POLISHED
										{	// Checks to see if AI has been out longer than _AIonFootTime variable//POLISHED
											
											if (_debug) then
											{
												diag_log format["[DyCE] (convoyController) Vehicle: %1 AI out long enough",_x];//POLISHED
											};
											
											if (_AIonFoot) then//POLISHED
											{
												if (_debug) then
												{
													diag_log format["[DyCE] (convoyController) Issuing get in order for %1 into vehicle: %2 and slowing vehicle to crawl",_AIgroup,_x];//POLISHED
												};
												[_vehicleEndPos,_AIgroup,_thisVehicle] call DyCE_fnc_addWaypointGetIn;//POLISHED
											};
										};
									}else//POLISHED
									{	// All AI back in vehicle, let's roll!
										
										if (_debug) then
										{
											diag_log format["[DyCE] (convoyController) Vehicle (%1) has all AI on board, moving at full speed",_x];//POLISHED
											diag_log format["[DyCE] (convoyController) Vehicle (%1) _limitSpeed:%2 | Current Waypoint: %3 | Damage: %4",_x,_limitSpeed,currentWaypoint (_x getVariable "DyCE_AIGroup"),damage _x];//POLISHED

										};
										
										//[format ["This is %1, area clear.  Proceeding to target.",group _x]] call FrSB_RC_fnc_RCChatter;
										_x setVariable ["DyCE_AIonFoot",false]; //Tells vehicle that all AI are in//POLISHED
										_x setVariable ["DyCE_AIonFootTime",(time + 100)];//POLISHED
										_x limitSpeed _convoySpeedLimit;//POLISHED
										
										_currVehicle = _x;
										/* moved to getin EH
										{
											if !(_x == _currVehicle) then
											{
												_x setVariable ["DyCE_ConvoySlowPartner",false];//POLISHED
											};
										}forEach _convoyPartners;
										*/
									};
									/*
									if (_indexVehicle == 0) then//POLISHED
									{
										_indexVehicle = 1;
										
										if(!isEngineOn _x)then
										{
											if((damage _x) < 1)then
											{
												if(time > _maxConvoyIdleTime)then
												{
													//_AIgroup call ExileServer_ejik_convou_waypointDelete;
													_stop = 1;
												};
											};
										};
									}else
									{
										if(_stop > 0)then
										{
											//_AIgroup call ExileServer_ejik_convou_waypointDelete;
										};
									};
									*/
									// Convoy exists, vehicle exists, player has not entered vehicle yet, AI group exists, one or more waypoint exists//POLISHED
									// and it is further than 150m from the endpoint, 
									if (((_x getHitPointDamage "HitEngine") > 0.8) || ((_x getHitPointDamage "HitLFWheel") > 0.8) || ((_x getHitPointDamage "HitLF2Wheel") > 0.8) || ((_x getHitPointDamage "HitRFWheel") > 0.8) || ((_x getHitPointDamage "HitRF2Wheel") > 0.8)) then//POLISHED
									{	// ...and it is heavily damaged, jump out and repair
										_unitRepair = units _AIgroup select 0;//POLISHED
										//_AIgroup call ExileServer_ejik_convou_waypointDelete;
										
										if (_debug) then
										{
											diag_log format["[DyCE] (convoyController) Vehicle (%1) has major damage, intiating repairs",_thisVehicle];//POLISHED
										};
										[_unitRepair,_vehiclePos,_x,_vehicleEndPos,_AIgroup] call DyCE_fnc_repairVehicle;//POLISHED
									};
									
									
									
									{
										if (damage _x > 0.25) then
											{
												[_x] call DyCE_fnc_aiHeal;
											};
									}forEach units _AIgroup;
									
																
									// Convoy exists, vehicle exists, player has not entered vehicle yet, AI group exists, one or more waypoint exists//POLISHED
									// and it is further than 150m from the endpoint, so basically move along.  Nothing to do 
									
									if (isEngineOn _x) then//POLISHED
									{//POLISHED
										_x setVariable ["DyCE_maxConvoyIdleTime",(time + _maxConvoyIdleTime)];//POLISHED
										_x setVariable ["DyCE_maxConvoyStoppedTime",(time + _maxConvoyStoppedTime)];//POLISHED
									};//POLISHED
								};//POLISHED
								
								// Convoy exists, vehicle exists, player has not entered vehicle yet, AI group exists, one or more waypoint exists//POLISHED
								if (_markerEnable) then//POLISHED
								{	// ...and markers are enabled//POLISHED
									if (_vehicleName in allMapMarkers) then//POLISHED
									{	//..and a marker exists already, update its position.//POLISHED
										_vehicleName setMarkerPos _vehiclePos;//POLISHED
									};//POLISHED
								};//POLISHED
							};//POLISHED
							
							//Convoy exists, vehicle exists, player has not entered vehicle yet, AI group exists, idler timers updated, markers updated	//POLISHED
							if ((_vehicleStartPos distance2D (getPos _x)) < 200) then//POLISHED
							{	// ... but vehicle has not moved more than 200 m from start point//POLISHED
								if (_maxConvoyStopTime < time) then//POLISHED
								{	// .. and the max timer for idle has passed (this will help give a time buffer during start up)//POLISHED
									_list = {isPlayer _x} count (_vehiclePos nearEntities ["CAManBase",_radiusNoPlayer]);//POLISHED
									if (_list == 0) then//POLISHED
									{	// ... and there are no players around, delete it//POLISHED
										diag_log format["[DyCE] (convoyController) Vehicle (%2) has not moved much from intial position | convoy type:%1. No players found in the vicinity, removing vehicle",_convoyType,_vehicleName];//POLISHED
										
										_currVehicle = _x;
										{	// Releasing convoy partners if destroyed
											if !(_x == _currVehicle) then
											{
												_x setVariable ["DyCE_ConvoySlowPartner",false];//POLISHED
											};
										}forEach _convoyPartners;

										{
											if (_x in allMapMarkers) then//POLISHED
											{//POLISHED
												deleteMarker _x;//POLISHED
											};//POLISHED
										} forEach _convoyDebugMarkers;
										
										{//POLISHED
											if (alive _x) then//POLISHED
											{//POLISHED
												deleteVehicle _x;//POLISHED
											};//POLISHED
										}forEach units _AIgroup;//POLISHED
										deleteVehicle _x;//POLISHED
										_excludeVehicle = true;//POLISHED - 3
										
										if (_vehicleName in allMapMarkers) then//POLISHED
										{//POLISHED
											deleteMarker _vehicleName;//POLISHED
										};//POLISHED
									};//POLISHED
								};//POLISHED
							}else
								//Convoy exists, vehicle exists, player has not entered vehicle yet, AI group exists, idler timers updated, markers updated	//POLISHED
							{	//...and the vehicle has moved more than 200m from start point
								if (time > _maxConvoyIdleTime) then
								{	//...but the idletimer(?? or max life time timer???) has expired
									_list = {isPlayer _x} count (_vehiclePos nearEntities ["CAManBase",_radiusNoPlayer]);
									if(_list == 0)then{
										diag_log format["The equipment ended the waiting time of the convoy. The convoy is not moving. class: %2, The name of the convoy class %1. There are no players around. The technique is removed.",_convoyType,(typeOf _x)];

										_currVehicle = _x;
										{	// Releasing convoy partners if destroyed
											if !(_x == _currVehicle) then
											{
												_x setVariable ["DyCE_ConvoySlowPartner",false];//POLISHED
											};
										}forEach _convoyPartners;

										{
											if (_x in allMapMarkers) then//POLISHED
											{//POLISHED
												deleteMarker _x;//POLISHED
											};//POLISHED
										} forEach _convoyDebugMarkers;

										{
											if(alive _x)then{
												deleteVehicle _x;
											};
										}forEach units _AIgroup;
										deleteVehicle _x;
										_excludeVehicle = true;//4
										if(_vehicleName in allMapMarkers)then{
											deleteMarker _vehicleName;
										};
									};
								};
							};
						}else
						{	//Convoy exists, vehicle exists, player has not entered vehicle yet, AI group exists, waypoint NOT exist
							// ex. Vehicle out of waypoints, probably at end of path? (Maybe cancelled by ???)
							if ((_vehicleEndPos distance2D (getPos _x)) < 150) then//POLISHED
							{	//... and vehicle is less than 150 meters from end waypoint, so close enough to try and end mission
							
								_list = {isPlayer _x} count (_vehiclePos nearEntities ["CAManBase",_radiusNoPlayer]);//POLISHED
								if(_list == 0)then//POLISHED
								{	// No players within 150 meters//POLISHED
									diag_log format["[DyCE] (convoyController) Vehicle: %3 arrived at the destination | Vehicle Type: %2 | Convoy Type %1",_convoyType,(typeOf _x),_vehicleName];//POLISHED
									diag_log "[DyCE] (convoyController) There are no players around. The vehicle will be removed";//POLISHED

									_currVehicle = _x;
									{	// Releasing convoy partners if destroyed
										if !(_x == _currVehicle) then
										{
											_x setVariable ["DyCE_ConvoySlowPartner",false];//POLISHED
										};
									}forEach _convoyPartners;

									{
										if (_x in allMapMarkers) then//POLISHED
										{//POLISHED
											deleteMarker _x;//POLISHED
										};//POLISHED
									} forEach _convoyDebugMarkers;

									{	// Delete all AI units//POLISHED
										if (alive _x) then//POLISHED
										{//POLISHED
											deleteVehicle _x;//POLISHED
										};//POLISHED
									}forEach units _AIgroup;//POLISHED
									
									deleteVehicle _x;//POLISHED
									_excludeVehicle = true;//POLISHED - 5
									if (_vehicleName in allMapMarkers) then//POLISHED
									{//POLISHED
										deleteMarker _vehicleName;//POLISHED
									};//POLISHED
								};//POLISHED
							};//POLISHED
							
							// Update marker if the marker still exists (ex. not deleted by previous step)
							if (_markerEnable) then//POLISHED
							{//POLISHED
								if (_vehicleName in allMapMarkers) then//POLISHED
								{//POLISHED
									_vehicleName setMarkerPos _vehiclePos; //POLISHED
								};//POLISHED
							};//POLISHED
							
							
							// VEHICLE STILL EXISTS, NO WAYPOINTS, AI is alive, its more then 150M away, marker is updated
							// Check if past max idle time
							if (time > _maxConvoyIdleTime) then
							{	// If so, check to see if there are players around
								_list = {isPlayer _x} count (_vehiclePos nearEntities ["CAManBase",_radiusNoPlayer]);
								if(_list == 0)then
								{	//If no players around, delete vehicle
									diag_log format["[DyCE] (convoyController) Vehicle: %3 idling too long | Vehicle Type: %2 | Convoy Type %1",_convoyType,(typeOf _x),_vehicleName];//POLISHED
									diag_log "[DyCE] (convoyController) There are no players around. The vehicle will be removed";//POLISHED

									_currVehicle = _x;
									{	// Releasing convoy partners if destroyed
										if !(_x == _currVehicle) then
										{
											_x setVariable ["DyCE_ConvoySlowPartner",false];//POLISHED
										};
									}forEach _convoyPartners;

									{
										if (_x in allMapMarkers) then//POLISHED
										{//POLISHED
											deleteMarker _x;//POLISHED
										};//POLISHED
									} forEach _convoyDebugMarkers;

									{
										if (alive _x) then//POLISHED
										{//POLISHED
											deleteVehicle _x;//POLISHED
										};//POLISHED
									}forEach units _AIgroup;//POLISHED
									
									_excludeVehicle = true;//POLISHED - 6
									deleteVehicle _x;//POLISHED
									if (_vehicleName in allMapMarkers) then
									{
										deleteMarker _vehicleName;
									};
								}else
								{	// Players are around, so check to see if we should intiate some action
										if ((damage _x) == 1) then
										{	//Vehicle has been destroyed so put remaining AI into a SAD patrol
											if !(_AIgroup isEqualTo grpNull) then
											{
												_AIgroup call DyCE_fnc_deleteWaypoints;
												_waypoint = _AIgroup addWaypoint [(getPos _x), 50];
												_waypoint setWaypointType "SAD";
												_waypoint setWaypointCombatMode "RED";
												_waypoint setWaypointSpeed "NORMAL";
												_waypoint setWaypointBehaviour "AWARE";
												_vehicle setVariable ["statusWaypoint","SAD"];
												diag_log format["[DyCE] (convoyController) Vehicle: %1 destroyed but AI alive, find the player",_x];//POLISHED

											}; 										
										};
										
										// Vehicle has not been destroyed and is just sitting there, check if  immobilized
										if !(_AIgroup isEqualTo grpNull) then
										{	// Check if AI is still alive
											if (((_x getHitPointDamage "HitEngine") > 0.8) || ((_x getHitPointDamage "HitLFWheel") > 0.8) || ((_x getHitPointDamage "HitLF2Wheel") > 0.8) || ((_x getHitPointDamage "HitRFWheel") > 0.8) || ((_x getHitPointDamage "HitRF2Wheel") > 0.8))then
											{	// Engine or front wheels are damaged, so pick the driver (stops vehicle)
												_unitRepair = units _AIgroup select 0;
												//_AIgroup call ExileServer_ejik_convou_waypointDelete;
												diag_log format["[DyCE] (convoyController) initiating repair on vehicle %1 by unit:%2",_x,_unitRepair];
												[_unitRepair,_vehiclePos,_x,_vehicleEndPos,_AIgroup] call DyCE_fnc_repairVehicle;		
											};									
										};								
								};
							}else 
							{
								if(_startMove == 0)then
								{
									_x setVariable ["DyCE_maxConvoyIdleTime",(time + _maxConvoyIdleTime)];
								};
								_firstVehicle = _x;
							};
						};
						//Convoy exists, vehicle exists, player has not entered vehicle yet, AI group exists
						// Vehicle is excluded if: 
						//		vehicle is destroyed (regardless of AI status) - 1
						//		vehicle has waypoints but is close to arrival (<150m) and no players around - 2
						//		vehicle alive but didnt move more than 200 m from its starting point, and idle timer expired - 3
						// 		vehicle alive and has moved, but is older than the max life of the convoy(???) or idletimer(???) - 4
						//		vehicle has no waypoints, but is close to arrival (<150m) and no players around - 5
						//		vehicle has no waypoints is NOT close to arrival, older than maxlife, and no players around - 6
						// 
						//		Otherwise, vehicle is added to the _newTempConvoy which will eventually be written back to masterConvyArray
						if !(_excludeVehicle) then//POLISHED
						{//POLISHED
							_newTempConvoy pushBack _x;//POLISHED
						};//POLISHED 
						//This then dumps out of the loop for this vehicle and moves on to the next
					}else//POLISHED
					{	//Convoy exists, vehicle exists, player has not entered vehicle yet, AI group DEAD!//POLISHED
						if(_vehicleName in allMapMarkers)then//POLISHED
						{//POLISHED
							deleteMarker _vehicleName;//POLISHED
						};//POLISHED
					}; //Vehicle marker is gone, vehicle is not monitored, this should ALSO perform clean up of code
				}; //Player in vehicle, vehicle is not inlcuded in convoy and marker has been erased
			}; //If _x is NULL (Vehicle must have been destroyed??)//POLISHED
		}forEach _x;//POLISHED
		if !(_newTempConvoy isEqualTo []) then//POLISHED
		{//POLISHED
			{	//Updates the list of convoy partners on each vehicle for radio communications
				_newPartners = _newTempConvoy - [_x];
				//diag_log format ["[DyCE] (convoyController) _newTempConvoy: %1 | _newPartners: %2",_newTempConvoy,_newPartners];
				_x setVariable ["DyCE_ConvoyPartners",_newPartners];
				if (_debug) then
				{
					diag_log format ["[DyCE] (convoyController) Setting vehicle(%1) convoy partners to %2",_x,_newPartners];
				};
			}forEach _x;
		
		
		    if((_newAllConvoys find _newTempConvoy) < 0) then //POLISHED
			{//POLISHED
			    _newAllConvoys pushBack _newTempConvoy;	//POLISHED
			};//POLISHED
		};//POLISHED
		missionNamespace setVariable ["DyCE_masterConvoyArray",_newAllConvoys];	
		
		sleep 0.5;
	}forEach _allConvoys;
};
// All convoys have been processed and the master array has been updated
// This section of the code runs if there are no defined convoys already, or at the end of the normal heartbeat check
//diag_log format["[DyCE] (convoyController start) nextConvoyStartTime: %1 | time:%2",_nextConvoyStartTime,time];//POLISHED

if (time > _nextConvoyStartTime) then//POLISHED
{
	//diag_log format["[DyCE] (convoyController start) nextConvoyStartTime hit at: %1, _count _allConvoys:%2",time,count _allConvoys];//POLISHED

    if (count _allConvoys < _maxNumConvoys) then//POLISHED
	{
		diag_log format["[DyCE] (convoyController start) _count _allConvoys hit at:%1",time];//POLISHED
		_allHCs = entities "HeadlessClient_F";//POLISHED
		_allHPs = allPlayers - _allHCs;//POLISHED
		diag_log format["[DyCE] (convoyController start) players online:%1",_allHPs];//POLISHED

		if ((count _allHPs) >= _minPlayers) then//POLISHED
		{
            call DyCE_fnc_spawnConvoy;//POLISHED
			diag_log format["[DyCE] (convoyController start) Convoy Starting at: %1",time];//POLISHED
		    missionNamespace setVariable ["DyCE_nextConvoyStartTime",(time + _convoyDelay)];//POLISHED
		};
	};
};

