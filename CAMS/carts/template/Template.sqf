// Template.sqf
// TheOneWhoKnocks
// 6/6/19
//
// Global variables in this file are available to the AI creation and Loot creation portions of CAMS
// Any where you would normally place an item class name, one of these variables may be substituted in its place.
// When FrSB encounters one of these defined arrays, it will select one of the items from the array at random to use
// in the particular application (ie AI Uniform, loot in a box, etc).


// Some items are repeated to add a "chance" element.  The more duplicates, the higher chance of spawning, and conversely the lower for others

// Uniforms

CAMS_U_Civ = [];
CAMS_U_Soldier = [];	
CAMS_U_Guerilla = [];
CAMS_U_Ghillie = [];
CAMS_U_Aviation = [];
CAMS_U_Wetsuit = [];	
CAMS_U_All = CAMS_U_Civ + CAMS_U_Soldier + CAMS_U_Guerilla + CAMS_U_Ghillie + CAMS_U_Wetsuit + CAMS_U_Aviation;

// Vest / Chest container items
CAMS_V_Bandolliers = [];
CAMS_V_Chestrig = [];
CAMS_V_Vests = [];
CAMS_V_Harness = [];
CAMS_V_Plate = [];

CAMS_V_Rebreather = [];
CAMS_V_All = CAMS_V_Bandolliers + CAMS_V_Chestrig + CAMS_V_Vests + CAMS_V_Harness + CAMS_V_Plate;

// Head/Hat items
CAMS_H_Caps = [];
CAMS_H_MilitaryCaps = [];
CAMS_H_Beanies = [];
CAMS_H_Bandannas = [];
CAMS_H_Boonie = [];
CAMS_H_Hats = [];
CAMS_H_Berets = [];
CAMS_H_Shemags = [];
CAMS_H_LightHelmet = [];
CAMS_H_RegHelmet = [];
CAMS_H_SuperHelmet = [];
CAMS_H_SpecOps = [];
CAMS_H_Aviation = [];

CAMS_H_Civ = CAMS_H_Caps + CAMS_H_Beanies + CAMS_H_Bandannas + CAMS_H_Hats;
CAMS_H_Hunter = CAMS_H_Caps + CAMS_H_Boonie + CAMS_H_Shemags + CAMS_H_MilitaryCaps;
CAMS_H_Military = CAMS_H_MilitaryCaps + CAMS_H_Berets + CAMS_H_LightHelmet + CAMS_H_RegHelmet + CAMS_H_SuperHelmet + CAMS_H_SpecOps;
CAMS_H_ALL = CAMS_H_Military + CAMS_H_Civ + CAMS_H_Boonie + CAMS_H_Shemags + CAMS_H_Aviation;

// Weapon attachments
CAMS_W_Pointer = [];
CAMS_W_Bipod = [];
CAMS_W_Muzzle = [];
CAMS_W_OpticsLv1 = [];
CAMS_W_OpticsLv2 = [];
CAMS_W_OpticsLv3 = [];

CAMS_W_Optics_ALL = CAMS_W_OpticsLv1 + CAMS_W_OpticsLv2 + CAMS_W_OpticsLv3;
CAMS_W_Attachments = CAMS_W_Pointer + CAMS_W_Bipod + CAMS_W_Muzzle + CAMS_W_Optics_ALL;	

// Navigation and Belt Items
CAMS_B_Navigation = [];
	
// Backpacks
CAMS_Packs_Lv1 = [];
CAMS_Packs_Lv2 = [];
CAMS_Packs_Lv3 = [];

CAMS_Packs_ALL = CAMS_Packs_Lv1 + CAMS_Packs_Lv2 + CAMS_Packs_Lv3;

// Ammo
CAMS_Ammo_All = [];
CAMS_Ammo_762 = [];
CAMS_Ammo_93 = [];
CAMS_Ammo_45 = [];
CAMS_Ammo_65 = [];
CAMS_Ammo_338 = [];
CAMS_Ammo_556 = [];
CAMS_Ammo_water = [];
CAMS_Ammo_9mm = [];
CAMS_Ammo_127 = [];
CAMS_Ammo_408 = [];
// Setting this in the 'magazine' section of loot configuration (LootData.sqf) will ensure ammo for each weapon specified in the weapon section is also part
//  of the loot definition.
CAMS_AmmoForEach = ["CAMS_AmmoForEach"];

// Flares
CAMS_Flares_Chemical =[];
CAMS_Flares_Normal =[];
CAMS_Flares_1Rnd = [];
CAMS_Flares_3Rnd = [];

CAMS_Flares_ALL = CAMS_Flares_Chemical + CAMS_Flares_Normal + CAMS_Flares_1Rnd + CAMS_Flares_3rnd;

//Smokes
CAMS_Smoke_Shell = [];
CAMS_Smoke_1Rnd = [];
CAMS_Smoke_3Rnd = [];

CAMS_Smoke_All = CAMS_Smoke_Shell + CAMS_Smoke_1Rnd + CAMS_Smoke_3rnd;

// Explosives
CAMS_E_Grenade = [];
CAMS_E_GrenadeIR =[];
CAMS_E_GrenadeStun =[];
CAMS_E_1Rnd = [];
CAMS_E_3Rnd = [];
CAMS_E_Mine =[];
CAMS_E_IED = [];

CAMS_E_Grenade_ALL = CAMS_E_Grenade + CAMS_E_GrenadeIR + CAMS_E_GrenadeStun;
CAMS_E_Shell_ALL = CAMS_E_1Rnd + CAMS_E_3Rnd;
CAMS_E_All = CAMS_E_Grenade_ALL + CAMS_E_Shell_ALL + CAMS_E_Mine + CAMS_E_IED;

//Guns
CAMS_Pistols_E = [];
CAMS_Shotguns_E = [];
CAMS_SubMGs_E = [];
CAMS_LightMGs_E = [];
CAMS_AssaultRifles_E = [];
CAMS_SniperRifles_E = [];

CAMS_Rifles_E_ALL = CAMS_LightMGs_E + CAMS_AssaultRifles_E + CAMS_SniperRifles_E;
CAMS_Guns_E_ALL = CAMS_Rifles_E_ALL + CAMS_SubMGs_E + CAMS_Pistols_E + CAMS_Shotguns_E;


CAMS_Pistols_W = [];
CAMS_Shotguns_W = [];
CAMS_SubMGs_W = [];
CAMS_LightMGs_W = [];
CAMS_AssaultRifles_W = [];
CAMS_SniperRifles_W = [];

CAMS_Rifles_W_ALL = CAMS_LightMGs_W + CAMS_AssaultRifles_W + CAMS_SniperRifles_W;
CAMS_Guns_W_ALL = CAMS_Rifles_W_ALL + CAMS_SubMGs_W + CAMS_Pistols_W + CAMS_Shotguns_W;


// *******VEHICLES********************
//  Toy / small / man powered type vehicles
CAMS_Toy_Bikes = [];
CAMS_Toy_Quads = [];
CAMS_Toy_Transport = [];
CAMS_Toy_All = CAMS_Toy_Bikes + CAMS_Toy_Quads + CAMS_Toy_Transport;

//  Water vehicles
CAMS_H20_Boats = [];
CAMS_H20_Assault = [];
CAMS_H20_Armed = [];
CAMS_H20_Sub = [];
CAMS_H20_Jetski = [];

CAMS_H20_All = CAMS_H20_Boats + CAMS_H20_Assault + CAMS_H20_Armed + CAMS_H20_Sub + CAMS_H20_Jetski;

// Helicopters
CAMS_Heli_Unarmed_W = [];
CAMS_Heli_Unarmed_E = [];
CAMS_Heli_Unarmed_G = [];
CAMS_Heli_Unarmed_C = [];

CAMS_Heli_Armed_W = [];
CAMS_Heli_Armed_E = [];
CAMS_Heli_Armed_G = [];



CAMS_Heli_Armed_ALL = CAMS_Heli_Armed_W + CAMS_Heli_Armed_E + CAMS_Heli_Armed_G;
CAMS_Heli_Unarmed_ALL = CAMS_Heli_Unarmed_W + CAMS_Heli_Unarmed_E + CAMS_Heli_Unarmed_G + CAMS_Heli_Unarmed_C;


// UAV
CAMS_UAV_Devices = [];

// Aircraft
CAMS_Plane_Escort = [];
CAMS_Plane_Bomber = [];
CAMS_Plane_CAS = [];
CAMS_Plane_Civ = [];


CAMS_Plane_All = CAMS_Plane_Escort + CAMS_Plane_Bomber + CAMS_Plane_CAS + CAMS_Plane_Civ;


// Civilian Vehicles
CAMS_Civ_Cars = [];
CAMS_Civ_Offroads = [];
CAMS_Civ_Transport = [];
CAMS_Civ_SUVs = [];
CAMS_Civ_Vans = [];
CAMS_Civ_Other = [];

CAMS_Civ_Work = CAMS_Civ_Cars + CAMS_Civ_Offroads + CAMS_Civ_Vans; 
CAMS_Civ_Trucks = CAMS_Civ_Offroads + CAMS_Civ_Transport + CAMS_Civ_SUVs + CAMS_Civ_Vans;

CAMS_Civ_ALL = CAMS_Civ_Work + CAMS_Civ_Trucks;


// Military Vehicles
CAMS_Mil_ArmedOffroads = [];
CAMS_Mil_UnarmedOffroads = [];
CAMS_Mil_SUV_Armed = [];

CAMS_Mil_OpenTransport = [];
CAMS_Mil_CoveredTransport = [];
CAMS_Mil_ArmedTransport = [];

CAMS_Mil_Transport_ALL = CAMS_Mil_OpenTransport + CAMS_Mil_CoveredTransport + CAMS_Mil_ArmedTransport;

CAMS_Mil_Unarmed =CAMS_Mil_UnarmedOffroads + CAMS_Mil_OpenTransport + CAMS_Mil_CoveredTransport;
CAMS_Mil_Armed = CAMS_Mil_ArmedOffroads + CAMS_Mil_ArmedTransport;
CAMS_Mil_ALL = CAMS_Mil_Unarmed + CAMS_Mil_Armed;


//////////////////////////// Misc

// Static Guns
CAMS_Mil_StaticGuns_W = [];
CAMS_Mil_StaticGuns_E = [];
CAMS_Mil_StaticGuns_G = [];

CAMS_Hist_Wreck = [];
CAMS_Car_Wreck = [];
CAMS_Truck_Wreck = [];
CAMS_Vehicle_Wreck = [];
CAMS_Tank_Wreck = [];
CAMS_Heli_Wreck = [];
CAMS_Plane_Wreck = [];
CAMS_Boat_Wreck = [];

CAMS_Wreck_Land = CAMS_Car_Wreck + CAMS_Truck_Wreck + CAMS_Vehicle_Wreck + CAMS_Heli_Wreck + CAMS_Plane_Wreck + CAMS_Hist_Wreck;


// Global Collections
CAMS_Veh_Land = CAMS_Civ_All + CAMS_Work_All + CAMS_Mil_Unarmed;
CAMS_Loot_Items = CAMS_BaseBuilding_ALL + CAMS_Food_ALL + CAMS_Drink + CAMS_Medical_Supplies + CAMS_W_Optics_ALL + CAMS_W_Attachments;




CAMS_ListofCAMSGlobalItems =
[


"CAMS_AmmoForEach",

  //Vehicle
"CAMS_Toy_All"

];

//Admin ATTENTION!
// Any new global arrays you want to have available on the headless client need to be defined in this file.
// Define the array below, then place the name of the array in the 'CAMS_ListofCustomGlobalItems' variable below.
// At initialization your global variable will be passed onto the HC prior to it attempting to initialize any missions.
CAMS_MyExampleGlobalVariable = ["Chemlight_blue","Chemlight_green","Chemlight_red"];

CAMS_ListofCustomGlobalItems =
[
	"CAMS_MyExampleGlobalVariable"
];

    
	
	
	

