/*

DyCE Convoy Configuration file
Defines all aspects of possible convoys 

Author: TheOneWhoKnocks
9/1/19
Updated comments to clarify configuration


*/


_convoyConfigs = 
[
	[
		"ArmedTroopConvoy",
		[
			true, 			// 0 - Player Can Get In = TRUE - Allow players to board vehicles. FALSE- Players will be kicked out of AI vehicles
			true, 			// 1 - Convoy Marker - Vehicle = TRUE - Display the convoy marker on the map. FALSE - do not display on the map.  
			"ColorBlack", 	// 2 - Vehicle Marker Color = The color of the marker on the map. Available colors ColorGrey, ColorBlack, ColorRed, ColorBrown, ColorOrange, ColorYellow, ColorKhaki, ColorGreen, ColorBlue, ColorPink, ColorWhite 
			"Convoy", 		// 3 - Vehicle Marker Text = The name displayed next to the marker. You can just leave blank if you want
			true, 			// 4 - Convoy Alert = TRUE - Display a message that a convoy appeared. FALSE - do not display. 
							// 5 - Convoy Alert Title = Alert title
			"Troop Convoy Reported", 
							// 6 -  Convoy Alert Body = Alert message text
			"Armed Troop Convoy operations have been reported in the region.", 
			50, 			//  7 - Convoy Speed Limit = The speed limit of the entire convoy. If you have a different vehicle classes, this will ensure they all go the same speed
			50, 			//  8 - Exile Vehicle Money Min = The minimum amount of poptabs in the vehicle 
			100, 			//  9 - Exile Vehicle Money Max = The maximum amount of poptabs in the vehicle 
			0, 				//  10 - Exile Bot Money Min = We set the minimum value of poptabs for AI 
			10, 			//  11 - Exile Bot Money Max = We set the max value of poptabs for AI 
			true,			//  12 - Vehicle Dynamic Loot = Add dynamic loot from defined loot arrays. true/false
			[				// 	13 - _allConvoyVehicles = Vehicle List for convoy
				[			// Vehicle 0 
					"O_MRAP_02_hmg_F", // 0 - Vehicle class 
					4, 	// 1 - The number of bots in the car
					[	// 2 - static loot [classname, quantity, type] type: weapon = 1, ammo = 2, backpack = 3, any other loot = 4 //POLISHED
						["srifle_DMR_03_F",1,1],	// The first parameter is a class, the second parameter is a quantity. The third parameter is type. 
						["20Rnd_762x51_Mag",3,2]	//
					],
					0	// 3 - object height. If this is a helicopter, it will appear in the air at the height indicated in this parameter. Write in meters.
				],
				[			// Vehicle 1
					"O_MRAP_02_gmg_F", // Vehicle class        
					4, // The number of bots in the car
					[],
					0 //object height. If this is a helicopter, it will appear in the air at the height indicated in this parameter. Write in meters.
				],
				[			// Vehicle 2
					"O_Truck_03_transport_F", // Vehicle class  	
					10, // The number of bots in the car
					[], 
					0 // object height. If this is a helicopter, it will appear in the air at the height indicated in this parameter. Write in meters.
				]
			]
		]
	],
	[
		"LightArmedConvoy",
		[
			true, 			// 0 - Player Can Get In = TRUE - Allow players to board vehicles. FALSE- Players will be kicked out of AI vehicles
			true, 			// 1 - Convoy Marker - Vehicle = TRUE - Display the convoy marker on the map. FALSE - do not display on the map.  
			"ColorBlack", 	// 2 - Vehicle Marker Color = The color of the marker on the map. Available colors ColorGrey, ColorBlack, ColorRed, ColorBrown, ColorOrange, ColorYellow, ColorKhaki, ColorGreen, ColorBlue, ColorPink, ColorWhite 
			"Convoy", 		// 3 - Vehicle Marker Text = The name displayed next to the marker. You can just leave blank if you want
			true, 			// 4 - Convoy Alert = TRUE - Display a message that a convoy appeared. FALSE - do not display. 
							// 5 - Convoy Alert Title = Alert title
			"Armed Patrol Reported", 
							// 6 -  Convoy Alert Body = Alert message text
			"An Armed Patrol has been spotted moving through the area.", 
			50, 			//  7 - Convoy Speed Limit = The speed limit of the entire convoy. If you have a different vehicle classes, this will ensure they all go the same speed
			50, 			//  8 - Exile Vehicle Money Min = The minimum amount of poptabs in the vehicle 
			100, 			//  9 - Exile Vehicle Money Max = The maximum amount of poptabs in the vehicle 
			0, 				//  10 - Exile Bot Money Min = We set the minimum value of poptabs for AI 
			10, 			//  11 - Exile Bot Money Max = We set the max value of poptabs for AI 
			true,			//  12 - Vehicle Dynamic Loot = Add dynamic loot from defined loot arrays. true/false
			[				// 	13 - _allConvoyVehicles = Vehicle List for convoy
				[			// Vehicle 0 
					"O_G_Offroad_01_armed_F", // 0 - Vehicle class 
					3, 		// The number of bots in the car
					[],		// See first entry of convoy script to see how to use this field
					0		// Object height. If this is a helicopter, it will appear in the air at the height indicated in this parameter. Write in meters.
				],
				[			// Vehicle 1
					"O_G_Offroad_01_armed_F", // Vehicle class        
					3, 		// The number of bots in the car
					[],		// See first entry of convoy script to see how to use this field
					0 		// Object height. If this is a helicopter, it will appear in the air at the height indicated in this parameter. Write in meters.
				],
				[			// Vehicle 2
					"O_G_Offroad_01_armed_F", // Vehicle class  	
					3, 		// The number of bots in the car
					[], 	// See first entry of convoy script to see how to use this field
					0 		// object height. If this is a helicopter, it will appear in the air at the height indicated in this parameter. Write in meters.
				]
			]
		]
	],
	[
		"HeloPatrol",
		[
			true, 			// 0 - Player Can Get In = TRUE - Allow players to board vehicles. FALSE- Players will be kicked out of AI vehicles
			true, 			// 1 - Convoy Marker - Vehicle = TRUE - Display the convoy marker on the map. FALSE - do not display on the map.  
			"ColorBlack", 	// 2 - Vehicle Marker Color = The color of the marker on the map. Available colors ColorGrey, ColorBlack, ColorRed, ColorBrown, ColorOrange, ColorYellow, ColorKhaki, ColorGreen, ColorBlue, ColorPink, ColorWhite 
			"Convoy", 		// 3 - Vehicle Marker Text = The name displayed next to the marker. You can just leave blank if you want
			true, 			// 4 - Convoy Alert = TRUE - Display a message that a convoy appeared. FALSE - do not display. 
							// 5 - Convoy Alert Title = Alert title
			"Helo Patrol Reported", 
							// 6 -  Convoy Alert Body = Alert message text
			"A helo patrol been reported in the region.", 
			100, 			//  7 - Convoy Speed Limit = The speed limit of the entire convoy. If you have a different vehicle classes, this will ensure they all go the same speed
			50, 			//  8 - Exile Vehicle Money Min = The minimum amount of poptabs in the vehicle 
			100, 			//  9 - Exile Vehicle Money Max = The maximum amount of poptabs in the vehicle 
			0, 				//  10 - Exile Bot Money Min = We set the minimum value of poptabs for AI 
			10, 			//  11 - Exile Bot Money Max = We set the max value of poptabs for AI 
			true,			//  12 - Vehicle Dynamic Loot = Add dynamic loot from defined loot arrays. true/false
			[				// 	13 - _allConvoyVehicles = Vehicle List for convoy
				[			// Vehicle 0 
					"B_Heli_Light_01_armed_F", // 0 - Vehicle class 
					4, 		// The number of bots in the vehicle
					[],		// See first entry of convoy script to see how to use this field
					200		// object height. If this is a helicopter, it will appear in the air at the height indicated in this parameter. Write in meters.
				],
				[			// Vehicle 1
					"B_Heli_Light_01_armed_F", // Vehicle class        
					4, 		// The number of bots in the car
					[],		// See first entry of convoy script to see how to use this field
					200 	// Object height. If this is a helicopter, it will appear in the air at the height indicated in this parameter. Write in meters.
				]
			]
		]
	]
];

missionNamespace setVariable ["DyCE_ConvoyConfigs",_convoyConfigs];
diag_log format ["[DyCE] (convoyConfig) complete: %1",_convoyConfigs];