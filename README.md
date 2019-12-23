# DEMS - Dynamic Event Mission System
###### Created by TheOneWhoKnocks

DEMS is random mission generator designed to be easy to install into any 
mission for Arma 3.  It allows for dynamic missions to be easily installed
that can be configured to use your custom content.

**NOTE**: This system has been developed from several other scripts that were abandoned and built into this one system.
This means there are still some weird bits of code that I am working out.  Please be patient as I work through this system


### Releases

*0.93* - Added debug code, corrected error in AI poptbas code, moved more configu items to the main config file
Added in custom killfeed system for future fucntinality to add in respect code
12/20/19

*0.92* - Removed last of custom announcement code
12/11/19

*0.91* - Major rewrite of launch code, install instructions and repairs to system
12/11/19
Corrected some major issues and added comments to files for customizations
I have a lon way to go and I'm adding in content when I have time

*0.9* - Beta release
11/11/19

This is the beta release of the DEMS system which inlcudes DyCE (Dynamic Convoy
Event) and DAPE (Dynamic Air Patrol Event).  It also includes the base CAMS system
(Common Asset Management System) which allows for easy integration of your custom 
content add-ons.  This version is being released for expanded testing and while 
functional, still has some issues to be addressed.

#### CAMS system 

The CAMS (Common Asset Management System) allows the customization of all of my releases
by adding your own CART (Common Asset Resource Template) files that include all classnames
needed for your content and modifying the ImFX (Immersion FX) files to include these classnames.

This system still needs full documentation but here is a rough outline.

**CART File** - These files are located in the **addons\DEMS\CAMS\carts\(content name)** directories and 
pre-load the global variables used throughout my add-ons.  You can use the existing files
or the included template files to add your own CART file.  See installation and configuration 
section on how to include your assets in the system.

**ImFX File** - These files are located in the addons\DEMS\CAMS\carts\(content name) directories and 
the ImmersionFX system uses the global variables from the CART system to populate
additional global variables that are used in the actual code for the dynamic events and other
add-ons.  While the CAMS system loads all content into the system, the ImFX system loads specific
content to be used by the game code.  For example, CAMS loads all content from Apex, Jets, etc, while
the ImFX system loads specific content into each variable like which patrol craft fly and which
interceptors respond, as well as loot tables for all add ons. 

#### Installation (EXILE)

To install the system, you must modify the following files with the content in this download.  

1. Extract the files into your mission file \addon directory.  (Create this directory if it does not exist)
The full path will be _Exile.(missionMapName)\addons\DEMS_ and all folders and files will be located here


2. *DESCRIPTION.EXT* - Check to see if you already have a section in your file that looks like this:

```
class CfgFunctions
{
	(SOME CODE)
};
```

Check any files that are added using an "#include" statement
If you do please follow instrucutions labeled EXSITING CFG SECTION
otherwise follow the instruitons labeled CLEAN INSTALL


**EXSITING CFG SECTION**
Modify your section as follows:

```
class CfgFunctions
{
	(SOME EXISTING CODE, ADD THIS AFTER...)
	
	// Core FrSB Functions
	#include "functions\cfgFunctions.hpp"
	
	// Core CAMS Functions
	#include "CAMS\cfgFunctions.hpp"
	
	// Add functions for DycE
	#include "EMS\DyCE\cfgFunctions.hpp"
	
	
};	(BUT BEFORE THIS ENDING BRACKET)
```
END SECTION, GO TO STEP 3

**CLEAN INSTALL**

Modify this file as follows:
A) Near the top of your file you will see a sction like this:

```
#define true 1
#define false 0
// Required for the XM8, do not remove!
#include "RscDefines.hpp"

Add this to the next line and save your file

#include "addons\DEMS\DEMS.hpp"
```

3. *INITSERVER.SQF* - Modify this file by adding the contents of SetupFiles\InitServer.sqf to the end of your file.

4. *INITPLAYERLOCAL.SQF* - Modify this file by adding this code somewhere near the top of your file on its own line:

```
#include "addons\DEMS\DEMSplayer.hpp"
```
 
#### Configuration (EXILE)

Most of the DEMS and DAPE configuration can be found in the /addons/DEMS/config.sqf file
This allows you to tweak most of the settings for both the main system as well as the DAPE system and some of the DyCE options


***IMPORTANT OPTIONS:

> (Line 28) FrSB_killfeed_Enabled = true;		// True - Enables custom kill feed messages
> (Line 30) FrSB_killfeed_LogKills = true; 		// True - Log kills into the players.rpt file
> (Line 45) DEMS_CAMS_useVanilla	= true;		// True - Loads Arma 3 Vanilla Content | False - Does not load vanilla assets | NOTE: If set to false, you need to be sure you have a VERY clean cart file that fills all minimum needs for system to run
> (Line 46) DEMS_CAMS_useExile = true;			// True - Loads Exile Content | False - Does not load exile assets
> (Line 59) DEMS_DAPE_debug = true;				// True - Turns on debug info for DAPE system and shortens timers | FALSE - System runs normal with no markers
> (Line 101) DyCE_debug = false;				// True - Enabled enhanced logging for DyCE system to troubleshoot issues


The DyCE system can be configured in two files.  Use the exising files as templates until I fully comment them

_/addons/DEMS/EMS/DyCE/convoyConfig.sqf_ - This lets you define the actual vehicles and configuration of the convoys
_/addons/DEMS/EMS/DyCE/lootConfig.sqf_ - This defines the type of loot that is being given to the AI in the convoy and the contents of the trucks

NOTE: This will be moved to the main DEMS config file in future versions

#### Adding your custom content

The CAMS system requires a new directory to be created from the template files.  There are two files:
Assets.sqf - Used mainly for the FuMS Mission Generator (Future integration, this has not been released
ImmersionFX.sqf - Used for the Event Management System which includes the DAPE and DyCE Dynamic Missions

If you only want to add custom content to the DAPE and DyCE missions, you only need to update ImmersionFX.sqf.
However, future releases will include the FuMS system which uses the Assets.sqf file.  Additionally, you can 
use global variables you define in Assets.sqf in ImmersionFX.sqf, so it would be very helpful to create both
and submit them to me for future inclusion in the system.

Example:
Say you are adding in assault rifle content for the RHS USAF add-on.  

1. Copy the folder called "template" to it's own directory called "rhsusaf"
2. Open the folder and edit the file "Assets.sqf"
3. You will see multiple groups that the CAMS system uses to integrate into Arma. Add the various classnames for your content into the appropriate section
Example weapons section:

```
[
		"CAMS_Pistols",4,true,
		[
			// Pistol type weapons
		]
	],

	[
		"CAMS_SubMGs",3,true,
		[
			//Sub-machine guns
		]
	],
	[
		"CAMS_LightMGs",5,true,
		[
			// Light machine guns
		]
	],
	[
		"CAMS_AssaultRifles",5,true,
		[
			"rhs_weap_m14ebrri","rhs_weap_m16a4","rhs_weap_m16a4_carryhandle","rhs_weap_m16a4_carryhandle_M203",
			"rhs_weap_m16a4_carryhandle_grip","rhs_weap_m16a4_carryhandle_grip_pmag","rhs_weap_m16a4_carryhandle_pmag",
			"rhs_weap_m16a4_grip","rhs_weap_m27iar","rhs_weap_m4","rhs_weap_m4_carryhandle","rhs_weap_m4_carryhandle_pmag",
			"rhs_weap_m4_grip","rhs_weap_m4_grip2","rhs_weap_m4_m203","rhs_weap_m4_m203S","rhs_weap_m4_m320","rhs_weap_m4a1",
			"rhs_weap_m4a1_carryhandle","rhs_weap_m4a1_carryhandle_grip","rhs_weap_m4a1_carryhandle_grip2","rhs_weap_m4a1_carryhandle_m203",
			"rhs_weap_m4a1_carryhandle_m203S","rhs_weap_m4a1_carryhandle_pmag","rhs_weap_m4a1_grip","rhs_weap_m4a1_grip2",
			"rhs_weap_m4a1_m203","rhs_weap_m4a1_m203s","rhs_weap_m4a1_m320","rhs_weap_sr25","rhs_weap_sr25_ec"
		]
	],
	[
		"CAMS_SniperRifles",5,true,
		[
			// Sniper rifles
		]
	],
	[
		"CAMS_Rifles_ALL",0,true, // LEAVE THIS SECTION! This creates global variables that include all sections above
		[
			"CAMS_LightMGs", "CAMS_AssaultRifles", "CAMS_SniperRifles"
		]
	],
	
	[
		"CAMS_Guns_ALL",0,true,	// LEAVE THIS SECTION! This creates global variables that include all sections above
		[
			"CAMS_Rifles_ALL", "CAMS_SubMGs", "CAMS_Pistols"
		]
	],
	(REST OF FILE)
```
	
4. Open the ImmersionFX.sqf file and add your custom content to the various sections.  DAPE and DyCE will use these 
classnames for their mission variables

For example, to customize the aircraft used in the DAPE mission for the RHS USAF content, you would modify the file like this:

```
	[
		"ImFX_Air_Patrol",1,true,
		// Aircrat that should be used in air patrol roles (Used specificaly by DAPE)
		// NOTE: These MUST have a default crew assigned to them, otherwise the vehicle will just crash.  Not all content
		// providers crew all vehicles, be sure to test in the editor first toensure they have a deafult crew in the model
		[
			"RHS_C130J"
		]
	],
	[
		"ImFX_Air_Interceptor",1,true,
		
		// Aircraft that should be used as interceptors (Used specificaly by DAPE)
		// NOTE: These MUST have a default crew assigned to them, otherwise the vehicle will just crash.  Not all content
		// providers crew all vehicles, be sure to test in the editor first toensure they have a deafult crew in the model
		[
			"RHS_A10","rhsusf_f22"
		]
	],
	[
		"ImFX_Air_Rescue_Heli",1,true,
		// NOTE: These MUST have a default crew assigned to them, otherwise the vehicle will just crash.  Not all content
		// providers crew all vehicles, be sure to test in the editor first toensure they have a deafult crew in the model
		[
			"RHS_CH_47F","RHS_UH1Y","RHS_UH60M","RHS_UH60M_MEV","rhsusf_CH53E_USMC"
		]
	],
```	
	
5. Edit the _/addons/DEMS/config.sqf_ file, line 48 and add in the name of the DIRECTORY you created

BEFORE:

```
DEMS_CAMS_cartList = 	[	// Name of CART directory 
							"jets",
							"apex"
						];
```
AFTER:
```
DEMS_CAMS_cartList = 	[	// Name of CART directory 
							"jets",
							"apex",
							"rhsusaf"
						];
```

Save your file, re-PBO your missionfile, and enjoy.

#### Troubleshoting

Most likely, you missed a comma, or addede an extra one at the end of the lists.  Check carefully.

If you are having problems with any of the missions, turn on the debug mode for the problem
module and we'll see if we can figure it out.

#### Known issues

- [ ] Sometimes convoys crash - Yeah, Arma logic is tricky.  I'll keep playing with it but things are far from perfect

- [ ] Players don't get respect for kills - Yeah, this is a lot of programming for little payoff.  I'll work on it over time

- [ ] Killfeed message doesn't record to the server.rpt - Thatll be in a future release, right now its on the players log

- [ ] Killfeed sizing looks a little weird - Still working on it

