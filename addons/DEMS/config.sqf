/////////////////////////////////////////////////////////////////////////////////
//	Dynamic Event Management System		/////////////////////////////////////////////
// 	Created 6/1/19						/////////////////////////////////////////////
// 	Developed by TheOneWhoKnocks		/////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/*
Version 0.92

*/

// Set this to true if running with Exile.  Future development will seperate Exile dependencies
DEMS_exileLoaded = true;	
// Leave this alone
FrSB_general_ExileLoaded = DEMS_exileLoaded;


//////////////////////////////////////////////////////////////////////////////////
// Common Asset Manager System	//////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

DEMS_CAMS_useVanilla	= true;	// True - Loads Arma 3 Vanilla Content  False - Does not load vanilla assets
DEMS_CAMS_cartList = 	[		// Name of CART directory , Description of Cart Contents
							//"CUP", "CUP Assets",
							//"RHS", "RHS Assets"
							"vanilla","Arma 3 Default Assets",
							"exile","Exile Server Assets"
						];
						

//////////////////////////////////////////////////////////////////////////////////
// Dynamic Air Patrol Event Config	//////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

// Basic cofiguration
DEMS_DAPE_patrolHeight = 150;			// Fly in height for patrol and rescue operations
DEMS_DAPE_delayQRF = 30;				// Time before QRF rescue heli launches after the crash
DEMS_DAPE_interceptorPresent = true;	// TRUE - Interceptor launches and shoots down patrol | FALSE - Only patrol plane flies (Either way, land crash will generate rescure craft)
DEMS_DAPE_AIMoney = 500;				// Max amount of money in AI pockets
DEMS_DAPE_lootHeliPersist = false;		// TRUE - Vehicle is persistant and uses code defined below | FALSE - vehicle is not persistant
DEMS_DAPE_lootHeliProtected = true;		// TRUE - Loot heli cannot be shot down in transit     FALSE - Loot heli is vulnerable while it flies in


// Loot amounts (if you want more loot than the heli itself)
DEMS_DAPE_amountOfWeapons = 5+floor(random 5);
DEMS_DAPE_amountOfItems = 7+floor(random 5);

// Navigation system.  This allows you to define your own waypoints based on your map, or allow the system to select its own
// NOTE: The waypopint finding system is pretty good and should be allowed to work, but if you want to mess with it....
DEMS_DAPE_useMarkerWaypoints = false;	// FALSE - System generates it's own waypoints.  TRUE - You must define them in x,y
DEMS_DAPE_wp1 = [8407,10285];			//These work for Tanoa and make the craft fly in a large X across the island
DEMS_DAPE_wp2 = [2970,3416];			//The patrol aircraft will fly to waypoint 1, then cycle through 4, then back to 1
DEMS_DAPE_wp3 = [11652,3123];			//The attack aircraft will fly a reverse route
DEMS_DAPE_wp4 = [3064,11047];			//This will ensure the event plays out the way you want

// This next section defines the models that are used to populate the rescue helicopter. NOTE: You have to use the model of the soldier, as noted
// Some add on packs (ex. Unsung Vietnam) have models that include custom gear.  If you use those and want the custom gear, just plug in their model names
// and change the override variable (DEMS_DAPE_overrideDefaultGear) to false

DEMS_DAPE_AImodel1 = "O_G_Soldier_TL_F";// These are the actual models of AI soldiers that will man the rescue mission.  This will 
DEMS_DAPE_AImodel2 = "O_G_medic_F";		// allow you to incorporate your custom content into the system.  However, remember these
DEMS_DAPE_AImodel3 = "O_G_Soldier_F";	// are the models, not the clothing, so pay attention to what you put here and look these ones
DEMS_DAPE_AImodel4 = "O_G_Soldier_AR_F";// up online first.  They will come with default gear which gets stripped except for clothing
DEMS_DAPE_overrideDefaultGear = true;	// UNLESS you set this to false.  In that case, it will leave the default gear

//////////////////////////////////////////////////////////////////////////////////
// Dynamic Convoy Event Config	//////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////


publicVariableServer "FrSB_general_ExileLoaded";

DyCE_startDelay = 30;
DyCE_nextConvoyStartTime = time + DyCE_startDelay;
DyCE_masterConvoyArray = [];
DyCE_nextVehicleNumber = 0;

DyCE_debug = false;
DyCE_aiModel = "O_Soldier_unarmed_F"; // The base model used for all AI//POLISHED
DyCE_aiItemCount = [3,6]; // The amount [min,max] of items that the AI will carry
DyCE_aiRanks = ["CORPORAL","SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"]; // List of potential AI ranks
DyCE_aiSkill = [0.5,0.6,0.7,0.8,0.9]; // Random skill levels, will apply to overall "skill" 

DyCE_monitorDelay = 5; 				// Script heartbeat delay. 
DyCE_convoyDelay = 30; 				// Delay between convoys 
DyCE_startDelay = 30; 				// Delay before launching first convoy

DyCE_countBackpackVehicle = [1,3]; 	// The amount [min,max] of backpacks that the vehicle will spawn in with
DyCE_countItemVehicle = [3,6]; 		// The amount [min,max] of items that the the vehicle will spawn in with
DyCE_countWeaponVehicle = [2,4]; 	// The amount [min,max] of weapons that the vehicle will spawn in with

DyCE_maxConvoys = 2; 				// Maximum number of convoys that canspawn at once
DyCE_minPlayerOnline = 0; 			// Minimum number of players needed to be online for a convoy to spawn

DyCE_exileLoaded = FrSB_general_ExileLoaded; // True if using with Exile
DyCE_exileRespect = 100; 			// Exile respect given for AI kill
DyCE_maxConvoyIdleTime = 60; 		// The maximum number of seconds of the convoy. If it is idle on the card, it is simply removed.. */
DyCE_maxConvoyStoppedTime = 80; 	// If the convoy is in place from the beginning of the appearance, then we check whether it has moved or not. It happens on the map of the island and the point of the final path can become on the island and so that they do not stand in vain, we will clean them. */

DyCE_radiusSpawnVehicle = 100; 		// The search radius of the pavement in a given random area. Value in meters. Decreasing the value may cause an explosion */
DyCE_radiusNoPlayer = 1000; 		// The radius in meters, checking for the presence of players, if there are no players, then after the finishing point, the convoy will disappear */
DyCE_radiusHuntPlayer = 200; 		// The radius in meters, if during a shootout the player hid in what radius the convoy will look for him and will not leave until the player runs away or until he is killed :) */