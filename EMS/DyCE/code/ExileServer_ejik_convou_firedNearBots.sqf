/**
 * ExileServer_ejik_convou_firedNearBots
 * © 2018 ejik designer
 *
 */
private["_vehicle","_WType","_unit","_group","_groupWaypoints","_timeOutHold","_DyCE_maxConvoyIdleTime"];
_DyCE_maxConvoyIdleTime = getNumber(configFile >> "ejikConvou" >> "ejikConvouConfig" >> "DyCE_maxConvoyIdleTime");
_unit = _this select 0;
_group = group _unit;
_groupWaypoints = waypoints _group;
_vehicle = _unit getVariable ["vehicleItsUnit",objNull];
_timeOutHold = _group getVariable ["timeOutHold",(time + 40)];