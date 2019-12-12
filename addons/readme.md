/////////////////////////////////////////////////////////////////////////////
//	DEMS - Dynamic Event Mission System			/////////////////////////////
//	Created by TheOneWhoKnocks					/////////////////////////////
//												/////////////////////////////
/////////////////////////////////////////////////////////////////////////////

DEMS is random mission generator designed to be easy to install into any 
mission for Arma 3.  It allows for dynamic missions to be easily installed
that can be configured to use your custom content.

NOTE: This system has been developed from two other scripts that were abandoned and built into this one system.
This means there are still some weird bits of code that I am working out.  Please be patient as I work through this system


////////////////////////////////////////////////////////////
// Releases ////////////////////////////////////////////////
////////////////////////////////////////////////////////////

0.92 - Removed last of custom announcement code
12/11/19

0.91 - Major rewrite of launch code, install instructions and repairs to system
12/11/19
Corrected some major issues and added comments to files for customizations
I have a lon way to go and I'm adding in content when I have time

0.9 - Beta release
11/11/19

This is the beta release of the DEMS system which inlcudes DyCE (Dynamic Convoy
Event) and DAPE (Dynamic Air Patrol Event).  It also includes the base CAMS system
(Common Asset Management System) which allows for easy integration of your custom 
content add-ons.  This version is being released for expanded testing and while 
functional, still has some issues to be addressed.

///////////////////////////////////////////////////////////
// CAMS system ////////////////////////////////////////////
///////////////////////////////////////////////////////////

The CAMS (Common Asset Management System) allows the customization of all of my releases
by adding your own CART (Common Asset Resource Template) files that include all classnames
needed for your content and modifying the ImFX (Immersion FX) files to include these classnames.

This system still needs full documentation but here is a rough outline.

CART File - These files are located in the addons\DEMS\CAMS\carts\(content name) directories and 
pre-load the global variables used throughout my add-ons.  You can use the existing files
or the included template files to add your own CART file.  See installation and configuration 
section on how to include your assets in the system.

ImFX File - These files are located in the addons\DEMS\CAMS\carts\(content name) directories and 
the ImmersionFX system uses the global variables from the CART system to populate
additional global variables that are used in the actual code for the dynamic events and other
add-ons.  While the CAMS system loads all content into the system, the ImFX system loads specific
content to be used by the game code.  For example, CAMS loads all content from Apex, Jets, etc, while
the ImFX system loads specific content into each variable like which patrol craft fly and which
interceptors respond, as well as loot tables for all add ons. 

//////////////////////////////////////////////////////
// Installation (EXILE) //////////////////////////////
//////////////////////////////////////////////////////
To install the system, you must modify the following files with the content in this download.  

1. Extract the files into your mission file \addon directory.  (Create this directory if it does not exist)
The full path will be Exile.(missionMapName)\addons\DEMS and all folders and files will be located here

2. DESCRIPTION.EXT - Modify this file as follows:
A) Near the top of your file you will see a sction like this:

#define true 1
#define false 0
// Required for the XM8, do not remove!
#include "RscDefines.hpp"

Add this to the next line and save your file

#include "addons\DEMS\DEMS.hpp"


3. INITSERVER.SQF - Modify this file by adding the contents of SetupFiles\InitServer.sqf to the end of your file.


//////////////////////////////////////////////////////
// Configuration (EXILE) //////////////////////////////
//////////////////////////////////////////////////////

Most of the DEMS and DAPE configuration can be found in the /addons/DEMS/config.sqf file
This allows you to tweak most of the settings for both the main system as well as the DAPE mission generator


The DyCE system can be configured in three files.  Use the exising files as templates until I fully comment them

/addons/DEMS/EMS/DyCE/convoyConfig.sqf - This lets you define the actual vehicles and configuration of the convoys
/addons/DEMS/EMS/DyCE/lootConfig.sqf - This defines the type of loot that is being given to the AI in the convoy and the contents of the trucks

NOTE: This will be moved to the main DEMS config file in future versions
