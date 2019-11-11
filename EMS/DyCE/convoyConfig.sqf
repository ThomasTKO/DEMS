/*

DyCE Convoy Configuration file
Defines all aspects of possible convoys 

Author: TheOneWhoKnocks
9/1/19


*/


_convoyConfigs = 
[
	[
		"ArmedTroopConvoy",
		[
			true, 			// 0 - _playerCanGetIn = true - Allow players to board vehicles. 0 - Players will be kicked out of AI vehicles
			true, 			// 1 - convoyMarkerVehicle = 1 - Display the convoy on the map. 0 - do not display on the map.  */
			"ColorBlack", 	// 2 - _vehicleMarkerColor = The color of the marker on the map. Available colors ColorGrey, ColorBlack, ColorRed, ColorBrown, ColorOrange, ColorYellow, ColorKhaki, ColorGreen, ColorBlue, ColorPink, ColorWhite 
			"Convoy", 		// 3 - _vehicleMarkerText = The name of the marker. You can just leave blank
			true, 			// 4 -  convoyAlertVehicle = 1 - Display a message that a convoy appeared. 0 - do not display. */
							// 5 - vehicleAlertTitle = Alert header
			"Troop Convoy Reported", 
							// 6 -  vehicleAlertContent = Opposition text
			"Armed Troop Convoy operations have been reported in the region.", 
			50, 			//  7 - _convoySpeedLimit = The speed limit technology. If you have a different technique, then so that it goes at the same speed */
			50, 			//  8 - exileMoneyMin = Put the minimum value of play money in the car.. */
			100, 			//  9 - exileMoneyMax = Put the max value of play money in the car... */
			0, 				//  10 - exileBotMoneyMin = We set the minimum value of game money for bots. */
			10, 			//  11 - exileBotMoneyMax = We set the max value of game money for bots. */
			true,			//  12 - _vehicleDynamicLoot = Add dynamic loot from defined loot arrays. true/false
			[				// 13 - _allConvoyVehicles = Vehicle List for convoy
				[			// 0 
					"O_MRAP_02_hmg_F", // 0 - Vehicle class 
					4, 	// 1 - The number of bots in the car
					[	// 2 - static loot [classname, quantity, type] type: weapon = 1, ammo = 2, backpack = 3, any other loot = 4 //POLISHED
						["srifle_DMR_03_F",1,1],	// The first parameter is a class, the second parameter is a quantity. The third parameter is type. 
						["20Rnd_762x51_Mag",3,2]	//
					],
					0	// 3 - object height. If this is a helicopter, it will appear in the air at the height indicated in this parameter. Write in meters.
				],
				[			// 1
					"O_MRAP_02_gmg_F", // Vehicle class        
					4, // The number of bots in the car
					[],
					0 //object height. If this is a helicopter, it will appear in the air at the height indicated in this parameter. Write in meters.
				],
				[			// 2
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
			true, 			// 0 - _playerCanGetIn = true - Allow players to board vehicles. 0 - Players will be kicked out of AI vehicles
			true, 			// 1 - convoyMarkerVehicle = 1 - Display the convoy on the map. 0 - do not display on the map.  */
			"ColorBlack", 	// 2 - _vehicleMarkerColor = The color of the marker on the map. Available colors ColorGrey, ColorBlack, ColorRed, ColorBrown, ColorOrange, ColorYellow, ColorKhaki, ColorGreen, ColorBlue, ColorPink, ColorWhite 
			"Convoy", 		// 3 - _vehicleMarkerText = The name of the marker. You can just leave blank
			true, 			// 4 -  convoyAlertVehicle = 1 - Display a message that a convoy appeared. 0 - do not display. */
							// 5 - vehicleAlertTitle = Alert header
			"Armed Patrol Reported",
							// 6 -  vehicleAlertContent = Opposition text
			"An Armed Patrol has been spotted moving through the area.", 
			50, 			//  7 - _convoySpeedLimit = The speed limit technology. If you have a different technique, then so that it goes at the same speed */
			50, 			//  8 - exileMoneyMin = Put the minimum value of play money in the car.. */
			100, 			//  9 - exileMoneyMax = Put the max value of play money in the car... */
			0, 				//  10 - exileBotMoneyMin = We set the minimum value of game money for bots. */
			10, 			//  11 - exileBotMoneyMax = We set the max value of game money for bots. */
			true,			//  12 - _vehicleDynamicLoot = Add dynamic loot from defined loot arrays. true/false
			[				// 13 - _allConvoyVehicles = Vehicle List for convoy
				[			// 0 
					"O_G_Offroad_01_armed_F", // 0 - Vehicle class 
					3, 	// 1 - The number of bots in the car
					[],//2 - static loot
					0	// 3 - object height. If this is a helicopter, it will appear in the air at the height indicated in this parameter. Write in meters.
				],
				[			// 1
					"O_G_Offroad_01_armed_F", // Vehicle class        
					3, // The number of bots in the car
					[],
					0 //object height. If this is a helicopter, it will appear in the air at the height indicated in this parameter. Write in meters.
				],
				[			// 2
					"O_G_Offroad_01_armed_F", // Vehicle class  	
					3, // The number of bots in the car
					[], 
					0 // object height. If this is a helicopter, it will appear in the air at the height indicated in this parameter. Write in meters.
				]
			]
		]
	]
	/*
	,
	[
		"HeliPatrol",
		[
			true, 			// 0 - _playerCanGetIn = true - Allow players to board vehicles. 0 - Players will be kicked out of AI vehicles
			true, 			// 1 - convoyMarkerVehicle = 1 - Display the convoy on the map. 0 - do not display on the map.  
			"ColorBlack", 	// 2 - _vehicleMarkerColor = The color of the marker on the map. Available colors ColorGrey, ColorBlack, ColorRed, ColorBrown, ColorOrange, ColorYellow, ColorKhaki, ColorGreen, ColorBlue, ColorPink, ColorWhite 
			"Convoy", 		// 3 - _vehicleMarkerText = The name of the marker. You can just leave blank
			true, 			// 4 -  convoyAlertVehicle = 1 - Display a message that a convoy appeared. 0 - do not display. 
			"Heli Parol Reported", // 5 - vehicleAlertTitle = Alert header
			"A helo patrol been reported in the region", // 6 -  vehicleAlertContent = Opposition text
			10, 			//  7 - _convoySpeedLimit = The speed limit technology. If you have a different technique, then so that it goes at the same speed 
			50, 			//  8 - exileMoneyMin = Put the minimum value of play money in the car.. 
			100, 			//  9 - exileMoneyMax = Put the max value of play money in the car... 
			0, 				//  10 - exileBotMoneyMin = We set the minimum value of game money for bots. 
			10, 			//  11 - exileBotMoneyMax = We set the max value of game money for bots. 
			true,			//  12 - _vehicleDynamicLoot = Add dynamic loot from defined loot arrays. true/false
			[				// 13 - _allConvoyVehicles = Vehicle List for convoy
				[			// 1
					"B_Heli_Light_01_armed_F", // Vehicle class        
					2, // The number of bots in the car
					[],
					300 //object height. If this is a helicopter, it will appear in the air at the height indicated in this parameter. Write in meters.
				],
				[			// 2
					"B_Heli_Light_01_armed_F", // Vehicle class  	
					2, // The number of bots in the car
					[], 
					300 // object height. If this is a helicopter, it will appear in the air at the height indicated in this parameter. Write in meters.
				]
			]
		]
	]*/
];

missionNamespace setVariable ["DyCE_ConvoyConfigs",_convoyConfigs];
diag_log format ["[DyCE] (convoyConfig) complete: %1",_convoyConfigs];