// init.sqf
// TheOneWhoKnocks
// 12/9/19
// Server side functions
diag_log format ["###CAMS preInit.sqf executed."];
//if (!isServer) exitWith {};
[] execVM "addons\DEMS\CAMS\Init.sqf"; 

