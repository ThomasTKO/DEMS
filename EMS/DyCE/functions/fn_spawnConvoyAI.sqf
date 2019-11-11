/**
 * DyCE_fnc_spawnAI.sqf
 * © 2019 TheOneWhoKnocks
 *
 */

private["_vehicle","_newGroup","_convoyType","_aiCount","_aiClass","_vehPos","_aiRanks"];


_vehicle = _this;//POLISHED
_debug = missionNamespace getVariable "DyCE_debug"; //POLISHED

if (_debug) then
{
	diag_log format["[DyCE] (fnc_spawnConvoyAI) Vehicle being populated: %1",_vehicle];//POLISHED
};
_newGroup = grpNull;//POLISHED


if !(_vehicle isEqualTo objNull) then//POLISHED
{
	_convoyType = _vehicle getVariable ["DyCE_ConvoyType",""];//POLISHED
	if (_debug) then
	{
		diag_log format["[DyCE] (fnc_spawnConvoyAI) _convoyType: %1",_convoyType];//POLISHED
	};
	_convoyConfigs = missionNamespace getVariable ["DyCE_ConvoyConfigs",""];//POLISHED
	//diag_log format ["[DyCE] spawnAI _convoyConfigs:%1",_convoyConfigs];//POLISHED
	_convoyIndex = [_convoyConfigs,_convoyType] call BIS_fnc_findNestedElement;//POLISHED
	//diag_log format ["[DyCE] spawnAI _convoyIndex:%1",_convoyIndex];//POLISHED
	_convoyData = (_convoyConfigs select (_convoyIndex select 0)) select 1;//POLISHED
	//diag_log format ["[DyCE] spawnAI temp :%2 | _convoyData:%1",_convoyData,_temp];//POLISHED
	
	_aiCount = _vehicle getVariable ["DyCE_AICount",0];//POLISHED
	_aiClass = missionNamespace getVariable "DyCE_aiModel";//SHINY
	_vehPos = getPos _vehicle;//POLISHED
	//diag_log format["[DyCE] Number of AI being spawned %1",_aiCount];//POLISHED
	_aiRanks =  missionNamespace getVariable "DyCE_aiRanks";//POLISHED
	_aiSkill = missionNamespace getVariable "DyCE_aiSkill";//POLISHED
	_aiUniforms = missionNamespace getVariable "DyCE_Loot_aiUniform";//POLISHED
	_aiBackpacks = missionNamespace getVariable "DyCE_Loot_aiBackpack";//POLISHED
	_aiVests = missionNamespace getVariable "DyCE_Loot_aiVest";//POLISHED
	_aiWeaponsP = missionNamespace getVariable "DyCE_Loot_aiWeapon";//SHINY
	_aiOptics = missionNamespace getVariable "DyCE_Loot_aiOptics";//POLISHED
	_aiLauncher = missionNamespace getVariable "DyCE_Loot_aiLauncher";//POLISHED
	_aiHeadgear = missionNamespace getVariable "DyCE_Loot_aiHeadgear";//POLISHED
	_aiItemCount = missionNamespace getVariable "DyCE_aiItemCount";//POLISHED
	_aiItems = missionNamespace getVariable "DyCE_Loot_aiItems";//POLISHED

	_aiMoneyMin = _convoyData select 8;//POLISHED
	_aiMoneyMax = _convoyData select 9;//POLISHED
	_aiMoneyMid = _aiMoneyMin + ((_aiMoneyMax - _aiMoneyMin) / 2);//POLISHED
	_aiMoney = ceil(random[_aiMoneyMin,ceil(_aiMoneyMid),_aiMoneyMax]);//POLISHED
	_thisvehicle = _vehicle;//SHINY
	
	//_nextUnit = 0;//????????????????????????????????
	_aiCrew = [];//POLISHED
	
	_newGroup = createGroup [EAST, true];//SHINY
	
	if !(isNull _newGroup) then //POLISHED
	{
		_newGroup setVariable ["timeOutHold",time];//???????????????????????
		//diag_log format["DEBUG: [DyCE] fn_spawnAI.sqf | New AI Group %1",_newGroup];//POLISHED
		for "_i" from 1 to _aiCount do//POLISHED
		{				   
			_newUnit = _newGroup createUnit [_aiClass, _vehPos, [], 0, "CAN_COLLIDE"];//POLISHED
			removeAllWeapons _newUnit;//POLISHED
			removeAllItems _newUnit;//POLISHED
			removeUniform _newUnit;//POLISHED
			removeVest _newUnit;//POLISHED
			removeBackpack _newUnit;//POLISHED
			_newUnit setPos _vehPos;//POLISHED
			// NEED BETTER AI GENERATOR FOR SKILLS, NAME, ETC
			if(count(_aiRanks) > 0)then//POLISHED
			{
				_rankBot = selectRandom _aiRanks;//POLISHED
				_newUnit setUnitRank _rankBot;//POLISHED
			};//POLISHED
			if (count(_aiSkill) > 0) then//POLISHED
			{//POLISHED
				_skillLevel = selectRandom _aiSkill;//POLISHED
				_newUnit setSkill _skillLevel;//POLISHED
			};//POLISHED
			if (count(_aiUniforms) > 0) then//POLISHED
			{//POLISHED
				_uniform = selectRandom _aiUniforms;//POLISHED
				_newUnit forceAddUniform _uniform;//POLISHED
			};//POLISHED
			if (count(_aiBackpacks) > 0) then//POLISHED
			{//POLISHED
				_backpack = selectRandom _aiBackpacks;//POLISHED
				_newUnit addBackpack _backpack;//POLISHED
			};//POLISHED
			if (count(_aiVests) > 0) then//POLISHED
			{//POLISHED
				_vst = selectRandom _aiVests;//POLISHED
				_newUnit addVest _vst;//POLISHED
			};//POLISHED
			if (count(_aiWeaponsP) > 0) then//POLISHED
			{//POLISHED
				_wpn = selectRandom _aiWeaponsP;//POLISHED
				_newUnit addMagazines [(_wpn select 1),(_wpn select 2)];//POLISHED
				if (count(_wpn) == 5) then//POLISHED
				{//POLISHED
					_newUnit addMagazines [(_wpn select 3),(_wpn select 4)];//POLISHED
				};//POLISHED
				_newUnit addWeapon (_wpn select 0);//POLISHED
				_optics = selectRandom _aiOptics;//POLISHED
				_newUnit addWeaponItem [(_wpn select 0),_optics];//POLISHED
			};//POLISHED
			if (count(_aiLauncher) > 0) then//POLISHED
			{//POLISHED
				_aiRocket = selectRandom _aiLauncher;//POLISHED
				if (count (_aiRocket select 0) > 0) then//POLISHED
				{//POLISHED
					if (count (_aiRocket select 1) > 0) then//POLISHED
					{//POLISHED
						_newUnit addMagazines [(_aiRocket select 1),(_aiRocket select 2)];//POLISHED
					};//POLISHED
					_newUnit addWeapon (_aiRocket select 0);//POLISHED
				};//POLISHED
			};//POLISHED
			if (count (_aiHeadgear) > 0) then //POLISHED
			{//POLISHED
				_headgear = selectRandom _aiHeadgear;//POLISHED
				_newUnit addHeadgear _headgear;//POLISHED
			};//POLISHED
			
			_counterItemAI = (_aiItemCount select 0) + round random ((_aiItemCount select 1) - (_aiItemCount select 0));//POLISHED

			for "_i" from 1 to _counterItemAI do//POLISHED
			{//POLISHED
				_itemAI = selectRandom _aiItems;//POLISHED
				_newUnit addItem _itemAI;//POLISHED
			};//POLISHED
			
			_newUnit setVariable ["ExileMoney", _aiMoney, true];//POLISHED					
			//_newUnit addMPEventHandler ["MPKilled", {[_this select 0, _this select 1, _this select 2] call FrSB_fnc_MPKilledEH;}];//SHINY
			_newUnit addMPEventHandler ["MPKilled", {[_this select 0, _this select 1, _this select 2] call FrSB_fnc_unitKilledSFX;}];//SHINY
			_newUnit addMPEventHandler ["MPHit", {[_this select 0, _this select 1, _this select 2, _this select 3] call FrSB_fnc_unitHitSFX;}];//SHINY

			[_newUnit] joinSilent _newGroup;//POLISHED	
			
			_newUnit moveInAny _thisVehicle;//EEEEehhhhhhhhhhhhhhhhhhhhhhhhhh
			
			//_nextUnit = _nextUnit + 1;//?????????????????????????????
			if !(isNull _newUnit) then//POLISHED
			{//POLISHED
				_aiCrew pushBack _newUnit;//POLISHED
			};//POLISHED
			
			{//POLISHED
				deleteWaypoint _x;//POLISHED
			}forEach (waypoints _newUnit);//POLISHED
	
			_newUnit setVariable ["DyCE_UnitsVehicle",_thisVehicle];//POLISHED
			_newUnit disableAI "ALL";//POLISHED
			sleep 0.5;//POLISHED
		};//POLISHED
		_thisVehicle setVariable ["DyCE_AICrew",_aiCrew];//POLISHED
		_thisVehicle setVariable ["DyCE_AIGroup",_newGroup];//POLISHED
	};
};
_newGroup