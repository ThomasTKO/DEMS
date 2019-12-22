/*
////////////////////////////////////////////////////////
//	fn_MPKilledEH.sqf                                 //
//  by TheOneWhoKnocks                                //
//                                                    //
//  Heavily influenced by killfeed scripts from:      //
//  George Floros, Gr8, Kuplion and the Exile Team    //
////////////////////////////////////////////////////////

 06/24/19
 v. 1.0
 
 Is designed to be attached to the MPKilled EH for all FrSB AI for killfeed
 ["_victim", "_killer", "_instigator"] call FrSB_fnc_MPKilledEH;

*/
params ["_victim", "_killer", "_instigator"];

//_killerNameColor = missionnamespace getVariable ["FrSB_killfeed_KillerNameColor","#5882FA"];(DEPRACATED: Using team colors for now)
//_victimNameColor = missionnamespace getVariable ["FrSB_killfeed_VictimNameColor","#C70000"];(DEPRACATED: Using team colors for now)
_weaponNameColor = missionnamespace getVariable ["FrSB_killfeed_WeaponNameColor","#FFCC00"];
_distanceColor = missionnamespace getVariable ["FrSB_killfeed_DistanceColor","#FFCC00"];

_isExile = missionnamespace getVariable ["FrSB_general_ExileLoaded",false];
_logKills = missionnamespace getVariable ["FrSB_killfeed_LogKills",false];
_killStyle = missionnamespace getVariable ["FrSB_killfeed_KillStyle",0];
_messageDuration = missionnamespace getVariable ["FrSB_killfeed_MessageDuration",20];
_showHint = missionnamespace getVariable ["FrSB_killfeed_ShowHintText",false];


diag_log format ["[FrSB] killfeed EH launch values: victim:%1 | killer: %2 | instigator: %3",_victim,_killer,_instigator];
diag_log format ["[FrSB] killfeed EH launch values: _isExile:%1 | _killStyle: %2 | _showHint: %3",_isExile,_killStyle,_showHint];


if (isNull _instigator) then 
{
	_instigator = _killer
}; // Compensates for player driven vehicle road kill

//diag_log format ["[FrSB] killfeed EH launch values: victim:%1 | killer: %2 | instigator: %3",_victim,_killer,_instigator];
		
if (isPlayer _killer) then 
{ 
	if (_victim isKindOf "CAManBase") then
	{
		_victimName = "";
		_victimTeamColor = "#99D5FF";
		_killerName = name _killer;
		_victimTeamColor = (side group _victim call BIS_fnc_sideColor) call BIS_fnc_colorRGBtoHTML;
		_killerTeamColor = (side group _killer call BIS_fnc_sideColor) call BIS_fnc_colorRGBtoHTML;
		_distance = _killer distance2D _victim; 	
		_weapon = currentWeapon _killer;
		_pictureweapon = gettext (configFile >> "cfgWeapons" >> _weapon >> "picture");
		_nameWeapon = gettext (configFile >> "cfgWeapons" >> _weapon >> "displayname");

		
		if !(isplayer _victim) then 
		{
			_victimName = getText (configFile >> "CfgVehicles" >> format["%1",typeOf _victim] >> "displayname");
		}else
		{
			_victimName = name _victim
		};

		if (_pictureweapon == "") then 
		{
			_weapon = typeOf (vehicle _killer);
			_pictureweapon = (getText (configFile >> "cfgVehicles" >> _weapon >> "picture"));
		};
		
		switch (_killStyle) do
		{
			case 0: 
			{
				// systemChat Notification
				// runs on every PC showing kills on global , * You can disable the default arma
				[format["%1  Killed  %2  from  %3m  with  %4", name player,_victimName,floor _distance,_nameWeapon],"systemChat"] call BIS_fnc_MP;
				diag_log "FrSB MPKilled: Style 0";
			};
			case 1: 
			{
				//	Dynamic Text in upper left corner
				_killData = format ["<img size='1' shadow='1' image='%1'/> <t color='%7'> %2 <t color='%#FFD700'>killed <t color='%3'> %4 <t color='#FFD700'> from  %5 m  with  <t color='#FF0000'> %6 </t>",_pictureweapon,name _killer,_victimTeamColor,_victimName,floor _distance,_nameWeapon,_killerTeamColor];	
				_killFeed = ["<t size='0.6' align='left'>" + _killData + "</t>",safeZoneX,safeZoneY,10,0,0,7016] call BIS_fnc_dynamicText;
				diag_log "FrSB MPKilled: Style 1";

			};
			case 2: 
			{
			_dyntxt = format
			[
				"
				<t size='0.6'align='left'shadow='1'color='%6'>%1</t>
				<t size='0.5'align='left'shadow='1'>  killed  </t>
				<t size='0.6'align='left'shadow='1'color='%7'>%2</t><br/>
				<t size='0.45'align='left'shadow='1'> with: </t>
				<t size='0.5'align='left'shadow='1'color='%8'>%3</t>
				<t size='0.45'align='left'shadow='1'> - Distance: </t>
				<t size='0.5'align='left'shadow='1'color='%9'>%4m</t><br/>
				<img size='2.5'align='left'shadow='1'image='%5'/>
				",
				_killerName,
				_victimName,
				_nameWeapon,
				_distance,
				_pictureweapon,
				_killerTeamColor,
				_victimTeamColor,
				_weaponNameColor,
				_distanceColor
			];
			
			[_dyntxt,[safezoneX + 0.01 * safezoneW,2.0],[safezoneY + 0.01 * safezoneH,0.3],FrSB_killfeed_MessageDuration,0.5] spawn BIS_fnc_dynamicText;
			diag_log "FrSB MPKilled: Style 2";


			};
			default
			{
				// systemChat Notification
				// runs on every PC showing kills on global , * You can disable the default arma
				[format["(OOPS) %1  Killed  %2  from  %3m  with  %4", name player,_victimName,floor _distance,_nameWeapon],"systemChat"] call BIS_fnc_MP;
			};
		};
		

		// Broadcast hint if configured
		if (_showHint) then 
		{
			_message = parseText format 
			[
				"
				<t color='%5'>%1</t>
				<t>killed </t>
				<t color='%6'>%2</t>
				<t>with </t>
				<t color='%7'>%3</t>
				<t>from </t>
				<t color='%8'>%4m</t>
				",
				_killerName,
				_victimName,
				_nameWeapon,
				_distance,
				_killerTeamColor,
				_victimTeamColor,
				_weaponNameColor,
				_distanceColor
			];
			hintSilent _message;
		};


		if (_logKills) then {diag_log format ["[-=FrSB_Kill_Log=-]: Killer: %1 | KillerID: %2 | Victim: %3 | VictimID: %4 | Weapon: %5 | Distance: %6",(name _killer), getPlayerUID _killer, (name _victim), getPlayerUID _victim, _nameWeapon, floor(_victim distance _killer)];};


		// ADD EXILE CODE FOR CREDIT FROM FuMS, possibly DMS, etc
		/*
		private["_pl","_respect","_minrespect","_maxrespect","_groups","_unit"]; 
		_unit = _this select 0;
		_groups = group _unit;
		_pl = vehicle (_this select 1);
		_minrespect = getNumber (configFile >> "ejikConvou" >> "ejikConvouConfig" >> "minrespectKilledBoat");
		_maxrespect = getNumber (configFile >> "ejikConvou" >> "ejikConvouConfig" >> "maxrespectKilledBoat");
		if(_minrespect == _maxrespect)then{
		   _respect = _minrespect;
		}else{
		   _respect = round(random [_minrespect,_maxrespect,_minrespect]);
		};
		if(isPlayer _pl)then{
			if(_maxrespect > 0)then{
				_playerUid = getPlayerUID _pl;
				_response = format ["getAccountScore:%1", _playerUid] call ExileServer_system_database_query_selectSingle;
				_newScore = _response select 0;
				_newScore = _newScore + _respect;
				_pl setVariable ["ExileScore", _newScore];
				ExileClientPlayerScore = _newScore;
				(owner _pl) publicVariableClient "ExileClientPlayerScore";
				ExileClientPlayerScore = nil;
				format["setAccountScore:%1:%2", _newScore, getPlayerUID _pl] call ExileServer_system_database_query_fireAndForget;
				_newKillerFrags = _pl getVariable ["ExileKills", 0];
				_newKillerFrags = _newKillerFrags + 1;
				_killerStatsNeedUpdate = true;
				_pl setVariable ["ExileKills", _newKillerFrags];
				format["addAccountKill:%1", getPlayerUID _pl] call ExileServer_system_database_query_fireAndForget;
				[_pl, "freeResponse", [str _respect]] call ExileServer_system_network_send_to;
				_indexFind = (units _groups) find _unit;
				(units _groups) deleteAt _indexFind;
				_unit setVariable ["ExileDiedAt",time];
				if (vehicle _unit != _unit) then { 
					moveOut _unit;
				};
			};
		};
		true
		*/



		//________________	playSound notification 	________________ 
		//playSound "Killfeed_notification";	
	};
};				
