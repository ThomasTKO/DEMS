
_hold = [] execVM "addons\DEMS\init.sqf";
if (isNil "_hold") exitWith { diag_log "[FrSB] initServer.sqf (init.sqf): ERROR "};
waitUntil { ScriptDone _hold};

_hold = [] execVM "addons\DEMS\config.sqf";
if (isNil "_hold") exitWith { diag_log "[FrSB] initServer.sqf (config.sqf): ERROR "};
waitUntil { ScriptDone _hold};

_hold = [] execVM "addons\DEMS\EMS\DyCE\convoyConfig.sqf";
if (isNil "_hold") exitWith { diag_log "[DyCE] initServer.sqf (convoyConfig.sqf): ERROR "};
waitUntil { ScriptDone _hold};


_hold = [] execVM "addons\DEMS\EMS\DyCE\lootConfig.sqf";
if (isNil "_hold") exitWith { diag_log "[DyCE] initServer.sqf (lootConfig.sqf): ERROR "};
waitUntil { ScriptDone _hold};

sleep 10;
private _handle = execVM "addons\DEMS\EMS\DyCE\convoyMonitor.sqf";