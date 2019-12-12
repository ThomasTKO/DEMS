/**
 * DyCE_fnc_repairVehicle
 * © 2019 TheOneWhoKnocks
 *
 */
params["_unitRepair","_vehiclePos","_vehicle","_vehicleWayPosition","_groups"];
/*
_unitRepair = _this select 0;
_vehiclePos = _this select 1;
_vehicle = _this select 2;
_vehicleWayPosition = _this select 3;
_groups = _this select 4;
*/

_debug = missionNamespace getVariable "DyCE_debug"; //POLISHED

if !(_unitRepair isEqualTo objNull) then//POLISHED
{	//If there is a driver who was passed as part of the function call...//POLISHED
	diag_log "[FrSB-RC] *1";
	if !(_vehicle isEqualTo objNull) then//POLISHED
	{	// ...and if the vehicle exists//POLISHED
		diag_log "[FrSB-RC] *2";
		if ((damage _vehicle) < 1) then//POLISHED
		{// ...and the vehicle has not been completely destroyed//POLISHED
			diag_log "[FrSB-RC] *3";

			if (vehicle _unitRepair != _unitRepair) then//POLISHED
			{	//...and the driver (repairer) is still in the vehicle//POLISHED
				diag_log "[FrSB-RC] *4";

				// Driver = GTFO//POLISHED
				moveOut _unitRepair;//POLISHED
			};  //POLISHED
			_unitRepair doMove _vehiclePos;//POLISHED
				diag_log "[FrSB-RC] *6";

			waitUntil { ((_unitRepair distance _vehiclePos) < 5) || (not alive _unitRepair)};//POLISHED
			
			if !(_unitRepair isEqualTo objNull) then//POLISHED
			{//POLISHED
				diag_log "[FrSB-RC] *7";

				if !(_vehicle isEqualTo objNull) then//POLISHED
				{//POLISHED
					diag_log "[FrSB-RC] *8";

					_unitRepair playMove "Acts_carFixingWheel";//POLISHED
					_unitRepair disableAI "ANIM";//POLISHED
					sleep 10;//POLISHED
					if ((damage _unitRepair) < 1)then//POLISHED
					{//POLISHED
						diag_log "[FrSB-RC] *9";

						if((damage _vehicle) < 1)then//POLISHED
						{//POLISHED
							diag_log "[FrSB-RC] *10";

							_unitRepair enableAI "ANIM";//POLISHED
							_vehicle setDamage 0;//POLISHED
							
							if (_debug) then
							{
								diag_log format["[DyCE] (repairVehicle) Vehicle (%1) repair complete",_vehicle];//POLISHED
							};
							
							

						};//POLISHED
					};
				};//POLISHED
			};//POLISHED
		};//POLISHED
	};//POLISHED
};//POLISHED
true