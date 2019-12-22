/*
////////////////////////////////////////////////////////
//	fn_FrSB_Killfeed.sqf                              //
//  by TheOneWhoKnocks                                //
//                                                    //
//  Heavily influenced by killfeed scripts from:      //
//  George Floros, Gr8, kuplion and the Exile Team    //
////////////////////////////////////////////////////////

 06/21/19
 v. 1.0
 
 Include anywhere in the boot process of the mission or server
 If used in tandem with FrSB this must be called AFTER the FrSB_Announce function is defined

*/
diag_log "[FrSB] Killfeed initializing";

// CONFIG


/*
FrSB_killfeed_LogKills = true; // Log kills into the server.rpt file
publicVariableServer "FrSB_killfeed_LogKills";

FrSB_killfeed_ShowHintText = false; // show Kill Message on the Top Mid Of the Screen
publicVariableServer "FrSB_killfeed_ShowHintText";

FrSB_killfeed_MessageDuration = 30; // Time in seconds the message stays on the screen
publicVariableServer "FrSB_killfeed_MessageDuration";

// The color codes you see here are called Hex Codes - If you wish to pick another color see here :
//  http://www.color-hex.com/
// Then Copy the color code including '#' and must be 6 characters.

FrSB_killfeed_KillerNameColor	= "#5882FA"; // Text Color of the Killer's Name.
FrSB_killfeed_VictimNameColor	= "#C70000"; // Text Color of the Victim's Name.
FrSB_killfeed_WeaponNameColor	= "#FFCC00"; // Text Color of the Weapon's Name.
FrSB_killfeed_DistanceColor		= "#FFCC00"; // Text Color of the kill Distance number.
*/
addMissionEventHandler ["EntityKilled", 
{
	params ["_victim", "_killer", "_instigator"];
	
	_killfeed_WeaponNameColor = missionNamespace getVariable "FrSB_killfeed_WeaponNameColor";
	_killfeed_DistanceColor = missionNamespace getVariable "FrSB_killfeed_DistanceColor";
	_killfeed_MessageDuration = missionNamespace getVariable "FrSB_killfeed_MessageDuration";
	_killfeed_ShowHintText = missionNamespace getVariable "FrSB_killfeed_ShowHintText";
	_killfeed_LogKills = missionNamespace getVariable "FrSB_killfeed_LogKills";


	
	if (isNull _instigator) then {_instigator = UAVControl vehicle _killer select 0}; // UAV/UGV player operated road kill
	if (isNull _instigator) then {_instigator = _killer}; // player driven vehicle road kill
		
	//diag_log format ["[FrB] Killfeed launch values: victim:%1 | killer: %2 | instigator: %3",_victim,_killer,_instigator];
	//diag_log format ["[FrB] Killfeed launch values: _killfeed_WeaponNameColor:%1 | _killfeed_DistanceColor: %2 | _killfeed_MessageDuration: %3",_killfeed_WeaponNameColor,_killfeed_DistanceColor,_killfeed_MessageDuration];
	//diag_log format ["[FrB] Killfeed launch values: _killfeed_ShowHintText:%1 | _killfeed_LogKills: %2",_killfeed_ShowHintText,_killfeed_LogKills];

			
	if (isPlayer _killer) then 
	{ 
		if (_victim isKindOf "CAManBase") then
		{
			_victimName = "";
			_kill_HUD = "";
			_victim_Color = "#99D5FF";
			_killerName = name _killer;
			
			if !(isplayer _victim) then 
			{
				_victimName = getText (configFile >> "CfgVehicles" >> format["%1",typeOf _victim] >> "displayname");
			}else
			{
				_victimName = name _victim
			};
	
			_distance = _killer distance2D _victim; 	
			_victim_Color = (side group _victim call BIS_fnc_sideColor) call BIS_fnc_colorRGBtoHTML;
			_killer_Color = (side group _killer call BIS_fnc_sideColor) call BIS_fnc_colorRGBtoHTML;

	
			_weapon = currentWeapon _killer;
			_pictureweapon = gettext (configFile >> "cfgWeapons" >> _weapon >> "picture");
			_nameWeapon = gettext (configFile >> "cfgWeapons" >> _weapon >> "displayname");
			if (_pictureweapon == "") then 
			{
				_weapon = typeOf (vehicle _killer);
				_pictureweapon = (getText (configFile >> "cfgVehicles" >> _weapon >> "picture"));
			};
			
			
						
			// systemChat Notification
			// runs on every PC showing kills on global , * You can disable the default arma
			//[format["%1  Killed  %2  from  %3m  with  %4", name player,_victimName,floor _distance,_nameWeapon],"systemChat"] call BIS_fnc_MP;



			
			//	Dynamic Text in upper left corner
			//_kill_info = format["<img size='1' shadow='1' image='%1'/> <t color='%7'> %2 <t color='%#FFD700'>killed <t color='%3'> %4 <t color='#FFD700'> from  %5 m  with  <t color='#FF0000'> %6 </t>",_pictureweapon,name _killer,_victim_Color,_victimName,floor _distance,_nameWeapon,_killer_Color];	
			//_Spawn_kill_info=[["<t size='0.6' align='left'>" + _kill_info + "</t>",safeZoneX,safeZoneY,10,0,0,7016] remoteExec ["BIS_fnc_dynamicText"]];
			
			
			// 3. FrSB (Gr8 Based) notifications

			//_killMessage = format ["%1 was killed by %2", (name _victim), (name _killer)];



			_dyntxt = format
				[
					"
					<t size='0.6'align='left'shadow='1'color='%6'>%1</t>
					<t size='0.55'align='left'shadow='1'>  killed  </t>
					<t size='0.6'align='left'shadow='1'color='%7'>%2</t>
					<t size='0.55'align='left'shadow='1'> with: </t>
					<t size='0.6'align='left'shadow='1'color='%8'>%3</t>
					<t size='0.55'align='left'shadow='1'> - Distance: </t>
					<t size='0.5'align='left'shadow='1'color='%9'>%4m</t><br/>
					<img size='2.5'align='left'shadow='1'image='%5'/>
					",
					_killerName,
					_victimName,
					_nameWeapon,
					_distance,
					_pictureweapon,
					//FrSB_killfeed_KillerNameColor,
					_killer_Color,
					//FrSB_killfeed_VictimNameColor,
					_victim_Color,
					_killfeed_WeaponNameColor,
					_killfeed_DistanceColor
				];
				
				[_dyntxt,[safezoneX + 0.01 * safezoneW,2.0],[safezoneY + 0.01 * safezoneH,0.3],_killfeed_MessageDuration,0.5] spawn BIS_fnc_dynamicText;




			// Broadcast hint if configured
				if (_killfeed_ShowHintText) then 
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
						//FrSB_killfeed_KillerNameColor,
						_killer_Color,
						//FrSB_killfeed_VictimNameColor,
						_victim_Color,
						_killfeed_WeaponNameColor,
						_killfeed_DistanceColor
					];
					hintSilent _message;
	};







/*
			FrSB_killfeed = [(name _killer), _pictureweapon, (name _victim), floor(_victim distance _killer), _txt, nil, nil];
			publicVariable "FrSB_killfeed";
*/

			if (_killfeed_LogKills) then {diag_log format ["[-=FrSB_Kill_Log=-]: Killer: %1 | KillerID: %2 | Victim: %3 | VictimID: %4 | Weapon: %5 | Distance: %6",(name _killer), getPlayerUID _killer, (name _victim), getPlayerUID _victim, _nameWeapon, floor(_victim distance _killer)];};



			//________________	playSound notification 	________________ 
			playSound "3DEN_notificationDefault";	
		};
	};				
}];