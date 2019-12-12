/**
 * DyCE_fnc_addWaypoint
 * © 2019 TheOneWhoKnocks
 *
 */
params ["_wp","_group"];//POLISHED

_vehicle = (units _group select 0) getVariable ["DyCE_UnitsVehicle",objNull];//POLISHED
_group call DyCE_fnc_clearWaypoints;//POLISHED
//diag_log format["[DyCE] fnc_addWaypoint launch position: %1 | group:%2 | vehicle: %3",_wp,_group,_vehicle];//POLISHED

/* Have the group get into the vehicle? *///POLISHED
/*_waypoint = _group addWaypoint [getPos _vehicle, 50];//POLISHED
_waypoint setWaypointType "GETIN";
_waypoint setWaypointCombatMode "YELLOW";
_waypoint setWaypointSpeed "FULL";
_waypoint setWaypointBehaviour "SAFE";
_waypoint waypointAttachVehicle _vehicle;
_waypoint setWaypointFormation "STAG COLUMN";*/

_waypoint = _group addWaypoint [_wp, 50];//POLISHED
_waypoint setWaypointType "MOVE";//POLISHED
_waypoint setWaypointCombatMode "YELLOW";//POLISHED
_waypoint setWaypointSpeed "NORMAL";//POLISHED
_waypoint setWaypointBehaviour "SAFE";//POLISHED
_waypoint setWaypointFormation "STAG COLUMN";//POLISHED

_waypoint = _group addWaypoint [_wp, 50];//POLISHED
_waypoint setWaypointType "CYCLE";//POLISHED
_waypoint setWaypointCombatMode "YELLOW";//POLISHED
_waypoint setWaypointSpeed "NORMAL";//POLISHED
_waypoint setWaypointBehaviour "SAFE";//POLISHED
_waypoint setWaypointFormation "STAG COLUMN";//POLISHED

_vehicle setVariable ["statusWaypoint","SAD"];//SHINY
_vehicle setVariable ["DyCE_StartMove",1];//POLISHED