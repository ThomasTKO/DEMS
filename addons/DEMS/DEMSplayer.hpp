
if (missionNamespace getVariable "FrSB_killfeed_Enabled") then
{
	diag_log "FrSB KillFeed enabled";
	[] call FrSB_fnc_FrSBKillfeed;
};
/*
class CfgFunctions
{
	// Added for notification system
	#include "functions\notificationSystem\cfgFunctions.hpp"
};



//Added for notification system

class RscTitles
{
	#include "functions\notificationSystem\rsc\rsc_notifications.hpp"
};



class notificationSystem
{
	#include "functions\notificationSystem\config\config_master.hpp"
};

*/