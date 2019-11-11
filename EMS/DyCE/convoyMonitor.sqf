// Simple event system monitor

diag_log format ["[DyCE] ConvoyMonitor online: Start time: %1", time];

_delay = missionNamespace getVariable ["DyCE_monitorDelay", 5];


while {true} do
{
	call DyCE_fnc_convoyController;
	sleep _delay;
};
