// Simple event system monitor

diag_log format ["[DyCE] ConvoyMonitor online: Start time: %1", time];

_delay = missionNamespace getVariable ["DyCE_monitorDelay", 5];
_playerConnected = false;

while {!_playerConnected} do 
{
	sleep 60;
	_allHCs = entities "HeadlessClient_F";
	_allHPs = allPlayers - _allHCs;
	diag_log format["[DyCE] Waiting... HC's : %1 | Players = %2",_allHCs,_allHPs];
	if ((count _allHPs) > 0) then
	{
		_playerConnected = true;
	};
};

while {true} do
{
	call DyCE_fnc_convoyController;
	sleep _delay;
};
