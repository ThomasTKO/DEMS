/**
 * DyCE_fnc_aiHeal
 * © 2019 TheOneWhoKnocks
 *
 */
params["_unitHeal"];
_cover = [];
/*
_unitHeal = _this select 0;
_vehiclePos = _this select 1;
_vehicle = _this select 2;
_vehicleWayPosition = _this select 3;
_groups = _this select 4;
*/

_debug = missionNamespace getVariable "DyCE_debug"; //POLISHED

if !(_unitHeal isEqualTo objNull) then//POLISHED
{	//If there is an AI who was passed as part of the function call...//POLISHED
	//_closeCoverObjects = nearestTerrainObjects [_unitHeal, ["HIDE"], 20];
	diag_log format["[DyCE] (aiHeal) Unit: %1 is starting healing",_unitHeal];//POLISHED
	/*if !(_closeCoverObjects isEqualTo []) then
	{
		_cover = selectRandom _closeCoverObjects;
		diag_log format ["[DyCE] (aiHeal) Moving to cover:%1",_cover];
		_unitHeal moveTo (position _cover);//POLISHED
		sleep 5;
		//waitUntil { (_unitHeal distance (position _cover) < 5) || (not alive _unitHeal)};//POLISHED
		diag_log format ["[DyCE] (aiHeal) I made it to cover:%1",_cover];

	};
	*/
	_unitHeal disableAI "ANIM";//POLISHED

	_unitHeal playMove "AinvPknlMstpSnonWnonDnon_medic";//POLISHED
	sleep 20;//POLISHED
	if ((damage _unitHeal) < 1)then//POLISHED
	{//POLISHED
		_unitHeal enableAI "ANIM";//POLISHED
		_unitHeal setDamage 0;//POLISHED
			
		if (_debug) then
		{
			diag_log format["[DyCE] (aiHeal) AI (%1) heal complete",_unitHeal];//POLISHED
		};
	};//POLISHED
};//POLISHED
true