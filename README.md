/////////////////////////////////////////////////////////////////////////////
//	DEMS - Dynamic Event Mission System	/////////////////////////////
//	Created by TheOneWhoKnocks		/////////////////////////////
//						/////////////////////////////
/////////////////////////////////////////////////////////////////////////////

DEMS is random mission generator designed to be easy to install into any 
mission for Arma 3.  It allows for dyamic missions to be easily installed
that can be confirgured to use your custom content.

////////////////////////////////////////////////////////////
// Releases
0.9 - Beta release
11/11/19

This is the beta release of the DEMS system which inlcudes DyCE (Dynamic Convoy
Event) and DAPE (Dynamic Air Patrol Event).  It also includes the base CAMS system
(Common Asset Management System) which allows for easy integration of your custom 
content add-ons.  This version is being released for expanded testing and while 
functional, stil lhas some issues to be addressed.

///////////////////////////////////////////////////////////
// CAMS system
The CAMS (Command Asset Management System) allows the customization of all of my releases
by adding your own CART (Comman Asset Resource Template) files that include all classnames
needed for your content and modifying the ImFX (Immersion FX) files to include these classnames.

This system still needs full documentation but here is a rough outline.

CART File - These files are located in the CAMS\carts\(content name) directories and 
pre-load the global variables used throughout my add-ons.  You can use the existing files
or the included template files to add your own CART file.  See installation and configuration 
section on how to include your assets in the system.

ImFX File - The ImmersionFX system uses the global variables from the CART system to populate
additonal global variables that are used in the actual code for the dynamic events and other
add-ons.  While the CAMS system loads all content into the system, the ImFX system loads specific
content to be used by the game code.  For exmaple, CAMS loads all content from Apex, Jets, etc, while
the ImFX system loads specific content into each variable like which patrol craft fly and which
interceptors respond. 

//////////////////////////////////////////////////////
// Installation and Configuration

To install the system, you must modify the following files with the content in this download.  Each 
file is included and the entire system may be dropped into a blank mission template to get it running.
Otherwise, modify your files and add the content of each to enable the system.  

DESCRIPTION.EXT - If you already have one of these files, check to see if you have the following sections:

cfgFunctions
Either add this whole section or modify yours to include the text from this section in yours.

RscTitles
Either add this whole section or modify yours to include the text from this section in yours.

notificationSystem
You probably don't have one of these since this is specifically for the built in notification system.
This is needed for now until I add in the option to use the Exile system.


CONFIG.SQF - If you have one of these files, add the lines from this file to yours at the end. This 
includes three very important parts of the CAMS configuration, 1) Are you using thi system with EXILE,
2) whether to load vanilla assets and 3)the list of CART files that you want loaded.  This is 
actually the directory name of the folder that you chose when you created the file.  For example, 
if you create a carts for CUP, you should name the directory CUP, leave the files named Assets.sqf 
and ImmersionFX.sqf, and add in the line:
"CUP", "CUP Assets",
to the CAMS_CAMS_cartList variable.  There are included examples in the file.



INIT.SQF - Add the contents of this file to the end of your existing file if you have one.  There are a lot
of configuration options here for the DyCE system, and this file also starts the DAPE system.  Be sure to leave
FrSB_general_ExileLoaded = false;
alone for now, it is not fully compatible with EXILE just yet


INITSERVER.SQF - If you have this file, add the contents to the end of it, otherwise just use the file as is.


