/**
 * DyCE_fnc_AddWaypointGetIn
 * © 2019 TheOneWhoKnocks
 *
 */
params["_waypointPosition","_waypointGroups","_vehicle"];
/*
_waypointPosition = _this select 0;
_waypointGroups = _this select 1;
_vehicle = _this select 2;
*/
_waypointGroups call DyCE_fnc_clearWaypoints;
_vehiclePosEnd = _vehicle getVariable ["DyCE_EndPosition",[]];

//diag_log format["DEBUG WAYPOINT GETIN position %1, GROUP %2",_waypointPosition,_waypointGroups];
/* Update the point where to go */

_vehicle setVariable ["DyCE_AIonFootTime",(time + 30)];
//_vehicle setVariable ["DyCE_AIonFoot",false];

_waypoint = _waypointGroups addWaypoint [_vehiclePosEnd, 50];
_waypoint setWaypointType "GETIN";
_waypoint setWaypointCombatMode "YELLOW";
_waypoint setWaypointSpeed "FULL";
_waypoint setWaypointBehaviour "SAFE";
_waypoint setWaypointFormation "STAG COLUMN";

_waypoint = _waypointGroups addWaypoint [_vehiclePosEnd, 50];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointCombatMode "YELLOW";
_waypoint setWaypointSpeed "NORMAL";
_waypoint setWaypointBehaviour "SAFE";
_waypoint setWaypointFormation "STAG COLUMN";

_waypoint = _waypointGroups addWaypoint [_vehiclePosEnd, 50];
_waypoint setWaypointType "CYCLE";
_waypoint setWaypointCombatMode "YELLOW";
_waypoint setWaypointSpeed "NORMAL";
_waypoint setWaypointBehaviour "SAFE";
_waypoint setWaypointFormation "STAG COLUMN";