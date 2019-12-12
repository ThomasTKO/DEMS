/**
 * DyCE_fnc_playerGetIn
 * This runs on all spawned vehicles and prevents players from stealing vehicles if you configue the convoy that way
 * 
 * © 2019 TheOneWhoKnocks
 *
 */
private["_vehicle","_unit","_playerAllowedInVehicle"];//POLISHED
_vehicle = _this select 0;//POLISHED
_unit = _this select 1;//POLISHED
_convoyPartners = _vehicle getVariable ["DyCE_ConvoyPartners",[]];

_playerAllowedInVehicle = _vehicle getVariable ["DyCE_PlayerAllowedToTake",false];//POLISHED
//_allVehicle = missionNamespace getVariable "ejikConvouArray";
if (isPlayer _unit) then//POLISHED
{//POLISHED
	["systemChatRequest", "DyCE: This vehicle will despawn when the server reboots."] call ExileServer_system_network_send_broadcast;
	//["system","DyCE: This vehicle will despawn when the server reboots."] spawn FrSB_fnc_announce; //Insert generic temp vehicle message//POLISHED

    if !(_playerAllowedInVehicle) then//POLISHED
	{//POLISHED
		["systemChatRequest", "Sorry, this is a stick-shift and you are a loser"] call ExileServer_system_network_send_broadcast;
		//["system","Sorry","This is a stick-shift and you are a loser"] spawn FrSB_fnc_announce; //Insert kick out message here//POLISHED
	    moveOut _unit;//POLISHED
	};
}else
{
	{

		_x setVariable ["DyCE_ConvoySlowPartner",false];//POLISHED

	}forEach _convoyPartners;
	
	_unit setDamage ((damage _unit)*.5); //Assume AI heals themselves a litle when they get in
	
	
};