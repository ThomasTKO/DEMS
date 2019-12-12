//////////////////////////////////////////////////////////////////////////////
// fnc_findPlayers.sqf
// TheOneWhoKnocks
// 7/4/2019
// 
// Input: none
// Output: array of human players
//
// Automatically looks for all player entities and then removes HC entities
private ["_allHCs","_allHPs"];

_allHCs = entities "HeadlessClient_F";
_allHPs = allPlayers - _allHCs;
diag_log format["[FrSB] (findPlayers) HC's : %1 | Players = %2",_allHCs,_allHPs];

_allHPs