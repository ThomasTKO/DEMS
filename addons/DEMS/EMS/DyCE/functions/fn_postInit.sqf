/**
 * Post-Initialization
 *
 * TheOneWhoKnocks
 */
 
 

 
 
private ["_startDelay","_betweenTimeConvoyScript"];

EAST setFriend [EAST, 1];  //  This looks like an attempt to address the "Shooting at each other" thing

//_betweenTimeConvoyScript = getVariable "DyCE_monitorDelay";//Moved to convoy monitor

//Added for notification system
//"layer_notifications" cutRsc ["rsc_notifications", "PLAIN"];
/*
addMissionEventHandler ["Loaded",
{
	[] spawn
	{
		sleep 2;
		"layer_notifications" cutRsc ["rsc_notifications", "PLAIN"];
	};
}];


*/
true