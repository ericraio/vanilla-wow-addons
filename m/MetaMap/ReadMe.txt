DESCRIPTION:
============
MetaMap adds features to the WoW world map, keeping all mapping type features in a single place.
Some features are:

Adjust the map window size.
Move the map anywhere on the screen.
Adjust the opacity of the window & maps.
Saved sets for toggling between 2 map modes.
Allows full player movement, messaging, etc. with map open.
Adds coords to the main map and the Minimap
Adds Instance maps which open to the correct instance you enter.
Default data included for all bosses & locations etc.
User editable notes for all maps, including instance maps.
NPC/Mob database collectable by mouseover or keypress.
Toggling on/off display of unexplored areas of the map.
Boss Loot Tables displays all the loot dropped by bosses, and more.
Waypoint system to guide you to any set point.
Inbuilt Import and export facilities for various data formats.
Inbuilt Backup and Restore facilities.
Button on Minimap to open or close the World Map or display MetaMap options.
Key bindings for various MetaMap functions.
Full support for Titan Bar.

INSTALLATION:
=============
Extract ALL folders in the archive to the Interface\AddOns\ location.
If you wish the Instance maps to be populated with default information,
then on first installation you will need to select 'Extended Options' from the MetaMap menu.
Select the 'Imports' tab, then click 'Load Imports'. This will enable the two default
import buttons, 'Import Instance Notes' and 'Import BLT data'. Click on the import button
for each to import the data. Future updates to these files will require the same procedure.

ISSUES/COMPATIBILITIES:
=======================
Some addons may reset the map to gather location data.
If your map continuously jumps back to your current location when selecting another map,
it will be due to another addon resetting it. In most cases the authors have made changes
to correct this so, download the latest version of any conflicting addon.

CREDITS:
========
Author: Urshurak - aka MetaHawk - Realm: Aggramar
Maps created by Niflheim.
Original MapNotes code by Sir.Bender.
Original WoWKB code by ciphersimian.
Original FullWorldMap code by Mozz.
Original MetaMapBLT code by Daviesh.
Original MetaMapBWP code by Noraj.
French localisation by Sparrows.
German localisation by oneofamillion.
Spanish localisation by Fili.

*****NOTE*****
MapNotes, WoWKB, MozzFullWorldMap, and BetterWaypoints have been INTEGRATED into MetaMap.
This means the original addons are no longer required. Remove them to avoid conflicts!

	
*******************************************************************************
                             ADDITIONAL MODULES
*******************************************************************************
The following modules come as standard with MetaMap. All are Load-on-Demand, which
means they will not be loaded into memory when MetaMap runs, until you actually
select any to be loaded from various options within MetaMap.

MetaMapBKP: Backup & Restore module - backs up all your data and allows a restore
						at any time, with ease. Available from Extended Options.
MetaMapBLT: Boss Loot Tables - Displays loot tables when CTRL-Clicking on any map
						note, or any item in the map SideList.
MetaMapBWP: Adds a Waypoint system. Shows direction to selected point, and distance
						remaining. Selected from the MetaMap menu. Option to always load on startup.
MetaMapCVT: Main Import/Conversion module. Will import many different data files.
						ANY data file for import MUST be placed in the MetaMapCVT folder for import.
MetaMapEXP: Export module for exporting User notes, or KB data for others to import.
						Both Import and Export functions are available from Extended Options.
MetaMapFWM: FullWorldMap module. Shows unexplored areas of the map with custom colours.
						Option to load always on startup.
MetaMapWKB: WoW Knowledge Base. Stores NPC/MoB data on mouseover or keypress.
						Full integration with the Notes system. Option to load always on startup.
MetaMapZSM: ZoneShift module for German and French clients.

*******************************************************************************
                                  MAIN MAP
*******************************************************************************
The additions to the main WoW WorldMap were intended to fit in as smoothly as
possible, keeping the overall format the same. It adds not only Instance maps,
but also extends user editable notes to the Instance maps.

Options Menu: (also available in context from the Minimap button and TitanBar)
Menu on Click: Menu is displayed by clicking the button or on mouse-over.
Wrap ToolTip: Will wrap tooltip displays to WoW defined limit.
Show Main Coords: Toggles the display of the WorldMap coords.
Show MiniMap Coords: Toggles the display of coords on the MiniMap.
Notes Filter: Shows a Submenu which allows you to filter out notes on the map.
Allow clicks through map: Sets map to a passive mode to allow all
					mouse action through the map. Setting stored for each Saveset.
Map Mode: Switches between 2 saved map modes. Each set stores its own settings
					for Opacity, Scale and Action Mode.
Instance Backdrop Shade: Toggles between 4 different backdrops.
Extended Options: Displays an additional options menu for further options.
FlightMap Options: Displays FlightMap options (Requires FlightMap Addon).
Gatherer Options: Displaye Gatherer options (Requires Gatherer Addon).
Set as Waypoint: Toggles the BWP options (Requires MetaMapBWP module).
Create notes with MapMod: New note creation is done with CT_MapMod rather than
					MetaMap's internal note creation. Both live quite happily with each
					other so, you can toggle between them at any time.
Knowledge Base: Displays the KB database window.
Show Unexplored Areas: Toggles the display of unexplored areas on the map.

Shift+LeftClick on Main map coords will insert location details into open message box.
Shift+LeftClick on Minimap coords will insert location details into open message box.
CTRL+LeftClick on Minimap coords will cycle through setable text colours.
Left button down to drag Minimap coords display to anywhere on the screen.

Map List:
Left Clicking an item in the list will ping the location on the map.
Right Clicking an item in the list will show the notes edit box.
CTRL+Click an item in the list on an instance map will show the bossloot table.

Keybindings set in the system keybindings section allow quick key toggles for:
Toggling the WorldMap.
Switching between the 2 Map modes.
Toggling Fullscreen setting.
Toggling Knowledge Base display.
Targetting a unit for inclusion in the Knowledge Base.
Toggling the QuickNote display.
Removing a Waypoint.


*******************************************************************************
                                KNOWLEDGE BASE
*******************************************************************************
This database stores the name, description and location of all the NPCs/mobs you
mouse over.  The location is stored as a range to allow for movement or various
spawn points.  The range is updated every time you find the NPC in a different
location.  The database is global - all your characters on the same
computer and account can access it.

The Auto tracking on mouse-over will only add information from NPC/MOB targets.
Would get pretty cluttered otherwise. However, there is also a 'manual' mode
via a Keybinding set in the system keybinding section. This method will also
allow a targeted Player unit to be added to the database.

You can create Notes when you need them (i.e. hunting a particular mob
or looking for a particular NPC) and then when things start to get cluttered
you can remove the notes for a particular NPC/mob or all from the QuickMenu.

LeftClicking on an item in the main KB window will pop up the QuickMenu with various
options. RightClick gives the option to set the item as a Waypoint.


*******************************************************************************
                              MAP NOTES
*******************************************************************************
Adds a note system to the WorldMap helping you keep track of interesting
locations.  This offers two main functions:

1. Marking notes on the WorldMap.
2. Showing one of these notes on the MiniMap as a MiniNote.

Map functions:
CTRL+LeftClick: On the WorldMap opens the note creator menu.
LeftClick: On a note opens the note editor menu.
RightClick on a note gives the option to set the note as a Waypoint.
Shift+LeftClick on a note will insert details into open message box.
CTRL+LeftClick brings up the Boss Loot Table (MetaMapBLT)
Mouse-over: On a Note to see the tooltip with the information you entered.

[Edit Menu]
With this menu you can create new notes and edit existing notes.

	1. Select the icon style you want to use for your note.
	2. Title: Enter it in the editbox and select a color in which it will be
			displayed in the tooltip.
			NOTE: The title field is mandatory, you cannot create a note without
			a title - to prevent this the "Save" button is disabled when
			the title field is empty.
	3. Infoline 1 and 2: Here you can insert additional information for your
			note and color it in one of the colors below the editbox.
	4. Creator: Enter the name of the player or AddOn that created the note

[The MiniNote]
A MiniNote is a note placed on the MiniMap.  Moving the mouse over the
MiniNote shows the details of the note.
To show one of your notes on the MiniMap go to the Worldmap, left click on
a note and choose "Set As MiniNote".
To hide the note on the MiniMap, you can go to the WorldMap, left click and
choose "Turn MiniNote Off".

The MiniNote is turned off if the MapNote corresponding to it is deleted.

[Send Notes To Other Players]
After clicking "Send Note" in the notes Menu the Send Menu will show up.

	1. Enter the name of the player you want to send a note to
			NOTE: Targeting the player before opening the WorldMap will auto
			insert the name.

	2. Send To Player
			Choose this option to send the note to the player entered above.

	3. Send To Party (requires Sky)
			This will send the note to the entire party. (No player name needs to
			be filled in.)

	4. Change Mode
			This toggles between Send To Player/Send To Party and Get Slash Command

	5. Get Slash Command
			Inserts a slash command in the editbox which can be highlighted and then
			copied to the clipboard.  After this you can post it on a forum or in chat
			and other MetaMap or MapNotes users can insert this note by copying the
			slash command to the chatline.

[Slash Commands]

/nextmininote [on|off], /nmn [on|off]
    Shows the next note created (using any method) as a MiniNote and also puts
    it on the WorldMap.  If invoked with no parameters, it will toggle the
    current state.

/nextmininoteonly [on|off], /nmno [on|off]
    Like the previous command, but doesn't put the note on the WorldMap.

/mininoteoff, /mno
    Turns the MiniNote off.

/quicknote [m] [xx,yy] [name], /qnote [m] [xx,yy] [name]
		Sets a note on the map in your current zone.
		The optional [m] parameter will set a mode for the note.
		1 = Set as Note + Mininote
		2 = Set as Mininote only
		3 = Set as a vNote (Virtual Note)
		No parameter or any other number for [m] will set as map note only.
		Coords and name are also optional.
		If no coords are entered, note is set at your current location.
 

*******************************************************************************
                             WAYPOINTS SYSTEM
*******************************************************************************
MetaMapBWP module adds a Waypoint system to MetaMap. A Waypoint arrow is displayed,
showing the direction of the point set.

USAGE:
A waypoint can be set by a number of methods:

1. Select a preset map note from the dropdown list displayed when clicking 'Set a Waypoint'
on the main MetaMap menu.
2. RightClick on any map note on the map.
3. RightClick on any entry in the MetaMap KB display.
4. By typing '/bwp xx,yy name' on the command line.

Both commandline parameters are optional. Results are as follows:
Coords only: Sets a Waypoint at specified location with default name of "QuickLoc".
Coords + Name: Sets a Waypoint at specified location with specified name.
No parameters: Sets a Waypoint at current location with default name of "QuickLoc".
Name only: Sets a Waypoint at current location with specified name.

The last two are useful if you need to mark your current location so you can easily
return to it at a later time. Note that you will need to turn off the
'Clear Waypoint on arrival' option for this to prevent it from being cleared.

The dropdown options menu can be accessed either by selecting 'Options' from the
preset Waypoints list, or by clicking on the main Waypoint display.

The Waypoints display can also be moved to any location on the screen by using the
RightButton down to drag it.


*******************************************************************************
                             DATA IMPORTS/EXPORTS
*******************************************************************************
MetaMap will import data for MapNotes, WoWKB, User saved notes, default Instance data,
and BLT/AtlasLoot data from a provided file placed in the MetaMapCVT folder.

NOTE: Files for import MUST be placed in the MetaMapCVT folder before starting WoW!

Files:
MapNotes: SavedVariables\MapNotes.lua (If you were previously running the MapNotes addon)
MapMod: SavedVariables\MapMod.lua (If you were previously running the MapMod addon)
User File: MetaMapEXP.lua Provided by another user, from download, or created by User export.
InstanceData: Included as standard in the MetaMapCVT folder.
BLT: Default data included for import as standard. This will additionally import
			AtlasLoot data should the need ever arise. Place the 'localization.en.lua'
			and 'localization.bg.en.lua' from AtlasLoot into the MetaMapCVT folder to import.

To import any data, click the 'Load Import Module' button after selecting the 'Import'
tab on the Extended Options Menu. This will load the required routines and data
files. Then select the import option required. 

For those wishing to export data to other users, simply click on the 'Export User File'
option in the Imports section. Either KB data or Notes data, or both can be exported.
This will create a file in the SavedVariables folder called 'MetaMapEXP.lua'.
Any MetaMap user can then place this file in their MetaMapCVT folder, ready for import.
They too, will have the option to import either set of data, or both.


===============================================================================
                           FUNCTION HOOKS
===============================================================================
Of interest to other Addon authors:

nearNote, nearName = MetaMapNotes_AddNewNote(<parameters>)

This will add a new note to the notes data. A check is made for near notes.
	Note accepted: nearNote is returned as true, nearName as nil.
	Note rejected: nearNote is returned as false, nearName returns the near note index number.

Standard note parameters in order:
	continent, zone, xPos, yPos, name, [inf1], [inf2], [creator], [icon], [ncol], [in1c], [in2c], [mininote]

continent, zone, xPos, yPos, name - are required parameters. Will return nil if not set.

The optional [mininote] parameter sets a Mininote as follows:
	0 - Sets Mapnote only
	1 - Sets Mapnote + Mininote
	2 - Sets Mininote only
	Nil or any other value defaults to value 0

continent, zone = MetaMap_NameToZoneID(zoneText)
Returns continent and zone IDs.

continent, zone, currentZone, mapName = MetaMap_GetCurrentMapInfo();
Returns current map information.
continent and zone IDs and Map name.
currentZone returns 'MetaMapNotes_Data[continent][zone]'

MetaKBMenu_CRBSelect()
This function is called when CTRL+RightClicking on any KB display item.
Usage: MetaKBMenu_CRBSelect = MyFunction

MetaKBMenu_SRBSelect()
This function is called when Shift+RightClicking on any KB display item.
Usage: MetaKBMenu_SRBSelect = MyFunction

MetaMapNotes_CRBSelect()
This function is called when CTRL+RightClicking on any map note.
Usage: MetaMapNotes_CRBSelect = MyFunction

MetaMapNotes_SRBSelect()
This function is called when Shift+RightClicking on any map note.
Usage: MetaMapNotes_SRBSelect = MyFunction

There is also a 'Container' frame available for displaying data etc, within the WorldMap,
in the same format as the MetaMapKB and MetaMapBLT displays.
Referenced and parented as 'MetaMapContainerFrame'.


===============================================================================
                           VERSION HISTORY
===============================================================================
26 Nov 2005 - v1.0
	Initial Release

27 Nov 2005 - v1.1
	Added checks for existance of Titan Bar
	Added ReadMe to MetaMap folder
	Moved a few variables to the localisation
	Version number is now shown on the Options header
	
28 Nov 2005 - v1.2
	MozzFullWorldMap now fully supported
	French localisation added ( with thanks to Halrik for the translation)
	
29 Nov 2005 - v1.3
	Fixed error return in CT_MapMod when in Auto Gather mode by adjusting event handling.
	Tidied up a few other bits of code
	
30 Nov 2005 - v1.4
	MetaMap keybinding will now correctly toggle map on/off
	Fixed lockout of CT_MasterMod button when running MetaMapOptions from CT control panel
	Player location arrow no longer shows in instance maps
	Fixed incorrect filename in xml for French localisation
	German localisation added (with thanks to oneofamillion)
	Changed scaling routine to hopefully fix an issue on fullscreen for some - need feedback on this one
	
01 Dec 2005 - v1.5
	NEW: 	Map is now completely resizeable
	Removed full screen feature as this is now redundant
	NEW: Option sets now allow you to select between 2 saved mode settings
	Saved modes for Map opacity & Map size (set from options panel)
	Replaced the map 'Zoom' button with Option set toggle
	New keybinding for toggling between option set modes
	Escape key added for closing map. Even though the key binding works fine now.
	Added new menu options to TitanBar menu
	
07 Dec 2005 - v1.6
	Changed routines so features work correctly regardless how map is opened.
	Will now work fully with original map binding or icon.
	NEW: Map can now be moved around the screen with position saved between sessions.
	Each SaveSet will also store the respective position of the map.
	NEW: All keybindings are now useable, as well as messaging while map is open.
	This includes ability to open other windows while map is open.
	Added option to show/hide Gatherer Minimap icon.
	
08 Dec 2005 - v1.7
	Due to popular demand, a quick fix to keep the map on top of everything.
	Not a bad thing, as it does actually solve a few layering problems. :)

16 Dec 2005 - v1.8
	Completely recoded the options section.
	Options are now available from context pop-up menus.
	Optimised all other sections of code.
	I shall now be looking at starting version 2, adding user notes to all maps.

18 Dec 2005 - v1.81
	Oops. Removed the Gatherer button option but missed removing the actual routine.
	This meant that the Gatherer button would hide if you previously had it set off.
	Just a quick little fix for this. Was removed as the option for that is in Gatherer anyway.

26 Dec 2005 - v2.0
	NEW: MapNotes now integrated into MetaMap.
	...(All MapNotes features also extended to Instance maps).
	Fixed problem where a MiniNote set would cause main map to jump back to player location.
	Fixed Mininote not showing when entering a zone where it was set.
	Fixed occasional error in WorldMapFrame when updating the map for notes changes.
	Reworked notes menus for faster and easier access.
	CTRL + Left click on the map now opens the new note dialogue directly.
	Left click on a note now opens the edit note dialogue directly.
	...(More logical - doesn't change maps if slightly off target or forget to press alt).
	Options for notes are now enabled/disabled in the correct context.
	Added option to hide the author field in notes.
	Auto select option removed from MetaMap options.
	...(Will now always auto display correct instance map if you are in an instance) 
	Added option to set auto sizing of Tooltips.
	MozzFull re-instated to original location due to freeing up more space.
	Default POI option changed to 'Show Notes' option. Will show/hide all notes.
	Added display to show total notes and lines used per zone.
	Automatic conversion of default Instance POIs to user editable notes.
	...(MetaMapData.lua can be removed after first run)
	Automatic conversion of saved MapNotes data to MetaMap data.
	...(Requires MapNotes to be run once only alongside MetaMap)
	
26 Dec 2005 - v2.01
	Small correction for German and French users only. No need for others to download.
	...(Missed applying a data format change to the German and French localisations).

27 Dec 2005 - v2.1
	Additional compatibility checks added for CT_MapMod.
	New menu option to toggle between MapMod and MetaMap for note creation.
	...(Note creation for instances is still handled by MetaMap).
	Adjusted Minimap routines to handle left and right clicks correctly.
	Fixed the ThottBott/mntloc note conversions.
	
29 Dec 2005 - v2.2b1
	NEW: Integrated WoWKB code into MetaMap.
	Removed redundant code as well as adding option to turn off auto tracking.
	Automatice conversion of saved WoWKB data into MetaMap.
	...(Requires WoWKB to be run once alongside MetaMap to import).
	Added missing init routine to map mode keybinding toggle.
	
30 Dec 2005 - v2.2b2
	Added keybinding to manually target units for KB creation.
	...(This method also allows Player targeting. Active with AutoTrack on or off).
	Added highlighter to KB display for easier selection.
	Added solid background to KB options menu.
	Removed the Gatherer icon function which crept back in. :p
	Updated the Readme file to include description of all features and options.
	
03 Jan 2006 - v2.2b3
	Notes send menu now displayed on top.
	Fixed longstanding & infrequent Minimap error (old MapNotes bug).
	Changed format of KB from string parsing to a more solid and reliable format.
	...(Will auto update to new format on first run).
	Format of KB display is now in columns with better colour coding.
	KB notes are now created with a more logical colour coding.
	NEW option 'Add to Database' toggles on/off the database capture.
	NEW option 'Add new target note' toggles on/off auto adding of map notes.
	...(Can be over-ridden by <CTRL>+<Keybinding> combination).
	Tightened code and removed excess functions.
	Updated TOC to 1900 interface.
	
04 Jan 2006 - v2.2b4
	Emergency release to fix the scaling problems created by the patch changes.
	New notes are now created in the correct location.
	There is still a slight problem when switching between map modes but, that will
	take a little longer to sort out. More important to get this out quick to fix
	the notes placements.
	
07 Jan 2006 - v2.3
	NEW option to show a list on the side of all notes on the map.
	Clicking on an item in the list will ping its location on the map.
	Added additional entry to ping your own location on the map.
	Changed level display of high level mobs from '-1' to '??'.
	Cleaned up a few unwanted bits from the rushed out Beta 4.
	Corrected the TOC interface entry from 1900 to the correct 10900.
	
08 Jan 2006 - v2.4
	Added Zoneshift data for German clients. Read Zoneshift info below for usage.
	Tracked down occasional startup errors to missing init routine.
	...(Was introduced in init reformat back in v1.7)
	Removed map position saved variables & routines.
	...(Sorry, but the last patch totally changed the scaling behaviours and the
			saving of scaled positions is no longer possible. The Savesets will however
			still switch between different Alpha and Scaled modes.

11 Jan 2006 - v2.5
	NEW menu option 'Map Action Mode' places the map in a passive mode.
	...(All mouse actions pass directly through map for movement etc.).
	Added Action mode to Savesets so setting will be saved for each Saveset).
	Changed coords display routine to return accurate results.
	Changed map ping routine to place it more accurately on the icon.
	Notes editor now displays full alpha, regardless of alpha settings.
	...(Was a bit hard to see the options when transparent).
	Main coords display on the map now also display full alpha.
	Parts of the KB sorting are in place but not active as yet.
	...(Will be in next version. Thought it best to get these fixes out first).

17 Jan 2006 - v2.6
	NEW - Sorting of columns in KB database now implemented.
	...(Clicking the headers will change the sort order for the selected column).
	KB Search will now include all other columns when searching.
	Adjusted alpha of notes icons to always be slightly higher than map alpha.
	...(Makes them easier to see when alpha is way down).
	Added target distance checking to maintain location accuracy.
	...(Only adds targets within a 5yd distance. Suggested by Lindia).
	NEW - Keybinding pops up menu for setting a Quicknote or Virtual note(mntloc).
	NEW - Manual import facility added for MapNotes, WoWKB, and MetaMap data.
	...(This can then over-ride the auto import facilty if required for any reason).
	...(See reference notes for usage).
	MetaMap now correctly resets to the current zone when map is closed.
	...(Will set Minimap coords to the correct location instead of 0,0 for one).
	Fixed bug that would sometimes not load an instance map when auto selected.
	...(Only happened when the map was already set from a previous selection).
	Added sort routine to Instance dropdown to cover future additions or changes.
	NEW - Map of Temple of Ahn'Qiraj added. (Courtesy of WoWGuru.com).
	
28 Jan 2006 - v2.7
	Fixed error when capturing NPC/Mob with no tooltip information.
	No longer shows cursor coordinates when cursor is off the map.
	NEW - Target range now user definable in the KB options.
	NEW - Notes created on the Instance maps can now be sent to other players.
	...(Means you can now show other players your position in the instance).
	Added check for empty note fields in the KB database.
	..(Will add any missing info when you capture that target again).
	Reworked range calculations to give more accurate range colour code display.
	...(Will display green in the KB display if within 3 map units, otherwise yellow).
	Changed map coords display colours to be more user friendly.
	
28 Jan 2006 - v2.71
	Fixed Zoneshift error in the Notes List for German clients.
	
30 Jan 2006 - v2.72
	Fixed error with coloured text when sending notes to other players.
	...(Seems the WoW message system is a bit flaky when sending coloured text).
	Reworked the status print routines to minimalise output to the Chatframe.
	...(Turning off 'Show Updates' in the KB options results in virtually no output).
	
31 Jan 2006 - v2.73
	Hopefully fixes the BG issues some were having. Need feedback on this. :)
	NEW - Option to set the scale of Tooltips.
	...(Different Tooltip scales can be saved for each Saveset).
	
03 Feb 2006 - v2.74
	Battlegrounds well and truly fixed. Map notes and listings for there working.
	...(Was hard work - damn Horde kept creeping up on me and killing me).
	KB database now remembers sort order for the session.
	Added a debug mode. Toggle via  slash command ( /mmdebug ).
	...(Should be useful for checking zone names etc.).
	
26 Feb 2006 - v2.8
	NEW Option on Quicknote menu to include a MiniNote.
	NEW Option on QuickNote menu to set as MiniNote only.
	NEW Keybinding added for true fullscreen toggle mode.
	NEW A sample Tooltip is now displayed when adjusting Tooltip scale.
	NEW Search edit box is now dynamic. Display updates as you type.
	
27 Feb 2006 - v2.81
	NEW Map 'Ruins of Ahn'Qiraj' added.
	Side notelist now shows related Tooltips on MouseOver.
	RightClick on side notelist will now toggle the edit box for that entry.
	...(LeftClick will still ping the location for that entry).
	Mininote Tooltip now shows full note information.
	...(Just the start. I shall be optimising and enhancing Mininote stuff next).
	
28 Feb 2006 - v2.82
	Corrected the names for Ahn'Qiraj maps. Both will now display correctly.
	...(Managed to get into both tonight and discovered names were not quite right).
	
02 Mar 2006 - v2.83
	Fixed problem with instance map not selecting from dropdown.
	...(was setting incorrect value on newly added variable).
	Removed the double entry of real zone in debug display.
	NEW LeftClick on Minimap Mininote will now open edit options dialogue.
	...(Had already started to add some MiniNote changes so this bit not fully tested).
	
29 Mar 2006 - v3.0
	Corrected display of 'BlackOutWorld' added by Blizzard in latest patch.
	Toggling Fullscreen mode now retains currently viewed map.
	MetaMap menu no longer affected by alpha settings in Fullscreen mode.
	NEW KB data import facility.
	...(Imports data from a modified SavedVariables file).
	...(READ the import notes in the Readme for usage!).
	NEW MozzFullWorld has now been integrated into MetaMap as a Load on Demand.
	...(This means it will take up no memory unless called by selecting the option).
	...(Now referred to as MetaMapFWM - REMOVE MozzFullWorld to avoid clashes!!).
	Fixed overlay errors in FWM and added code to reflect changes in WoW's map routines.
	Removed FWM tickbox from map and added the option to MetaMap pop-up menu.
	Renamed 'round' function to something more unique to prevent future 'hi-jacking'.
	Updated French localisation. With thanks to 'Sparrows' for the translation.

30 Mar 2006 - v3.01
	Quick update to fix FWM not displaying explored areas under certain conditions.

07 Apr 2006 - v3.10
	Minimap coords can now be user placed. Simply drag to position required.
	Updated German zoneshift. See Readme for usage.
	NEW extended options menu added with tabbed window. Select from main menu.
	Unified extended options for Notes, KB, and FWM onto the Extended Options Menu.
	Added option to have FWM persist between sessions.
	Added option to toggle dynamic search for Knowledge Base.
	Added colour options for the FWM unexplored layers.
	Added search stats to Knowledge Base display.
	Updated the changed instance information for Scholo, Strat, BRD & Spire instances.

12 Apr 2006 - v3.20
	Minimap coords will now always show true location, regardless of WorldMap selection.
	Shift+LeftClick on Minimap coords will now insert location into open message box.
	Shift+LeftClick on any map note will now insert details into open message box.
	Shift+RightClick on any sidelist entry will now insert details into open message box.
	QuickNote menu will now accept a change to coords in the edit box.
	...(The current position in the box can be changed to place the icon anywhere on the map).
	...(Has same effect as the /quicktloc slash command).
	Fixed the occasional error message popping up when clicking on Minimap icon.
	...(Only happened when Mininote was set without relating map icon).
	...(Effect is that the notes edit box will not pop up if there is no relating map note).
	Moved the 'Show Only Local NPCs' checkbox to the main KB display from extended options.

14 Apr 2006 - v3.30
	Fixed memory rate increase for Minimap Coords display.
	Shift+LeftClick on Minimap icon will now correctly insert details into open message box.
	Removed the inclusion of coords within the Mininote name field when set as QuickNote.
	LeftClick on MiniNote without relating map note will now pop up a delete dialogue.
	...(MiniNote with relating map note will still pop up the notes edit box).
	Changed Minimap routine to correctly detect which city a Mininote is set for.
	...(Seems Orgrimmar and Ironforge now have the same Zone ID. Possibly a bug in recent patch).
	Replaced key selection for KB items with a popup QuickMenu, shown by LeftClick.
	Various new options added to QuickMenu, including set as Mininote only option.
	The 'Set as map note' will now only set the note on the main map.
	...(To set for both map and Minimap, click on both options).
	NEW option to selectively delete items from the KB database via the QuickMenu.
	...(Items are deleted according to criteria set in the search box).
	Changed some routines in MetaFWM to allow global access for other addons.
	...(Requested by Telic so, how could I refuse? :p).

20 Apr 2006 - v3.40
	Reworked Minimap coords routines to correctly update when in flight.
	...(Seems the last patch also made some changes to map updates when on a bird).
	NEW Import options added to Extended Menu Options.
	...(Auto import has been removed. No need to run any other addon to import).
	...(See the Import section in the Readme for filenames etc).
	Added new folder 'Extras' to the MetaMap folder, currently containing MetaMapData.lua.
	...(MetaMapData.lua contains all the default instance notes).
	...(Copy MetaMapData.lua to main MetaMap folder anytime you need to import it).
	Removed search update routines when capturing targets with 'Show Updates' turned on.
	...(Removes all the long delays when you have an extremely large database).
	Changed the 'ShowOnlyLocalNPC' function to 'Show All Zones'.
	...(KB display will now default to your local zone each time you open it).
	...(Removes the long search delays if you have a very large database).

15 May 2006 - v4.00
	Major changes to many routines to unify/optimise them, including a number of fixes
	to some older MapNotes/WoWKB routines.
	More reliable zone handling implemented. Will now determine correct zone locations
	for unknown areas. Has added benefit of handling new areas correctly as well.
	Major change to the KB routines, which will now handle zones from the common MetaMap
	routines, instead of the unreliable fixed list found in the localisation files.
	...(Makes the KB compatible with any localisation).
	...(Fixed lists have been moved to the import section for backward compatible imports).
	...(Note, that this has required a change in data structure!).
	Dropdown list table for instances replaced by a proper sort routine.
	...(Has the advantage of correctly sorting, regardless of language).
	Import routines and data are now loaded 'On Demand'.
	...(A new folder 'MetaMapCVT' is now dedicated to this - see revised import notes).
	...(A big memory save as the routines and data are now only loaded when importing).
	Changes to the MapNotes import routines means you can now import user MetaMap notes
	in a similar manner to KB user notes. See revised import notes).
	NEW Function added for new note creation. Mainly of interest to other mod authors.
	...(Using 'MetaMapNotes_AddNewNote(<parameters>)' will directly add a note to the map and/or Minimap).
	...(Will return a true or false value).
	NEW Option on note edit box 'Move Note' allows relocating any mapnote with a click.
	...(Will automatically adjust any connected lines and related Mininote).
	NEW MetaMapPOI feature adds all Points of Interest to the map on first visit to a zone.
	...(Basically a remake of Magellan. Options for this are on the Extended Options Menu).
	NEW Dynamic note creation removes note and line limits and hard-coded objects.
	...(Notes and lines are only created as and when needed, up to an unlimited amount).
	Adjusted the scaling of the Instance map display to show the map in correct proportion.
	...(Maps are no longer stretched along the x axis, or partly covered by the SideList).
	...(NOTE: This has required an update to the Instance data file!).
	...(Import the new Instance data file in Extended Options Menu on first run).
	Replaced map for Ruins of Ahn'Qiraj with new HQ map created by Niflheim.
	...(Will give you some idea of how things will look when he releases his HQ pack).
	Added Spanish localisation with thanks to Fili.
	Updated this Readme.

15 May 2006 - v4.01
	Fixed Minimap button call to open map. Missed updating that to new function.
	Fixed KB updating error. Somehow the correct function went walkies after testing.
	Apologies all round on that one :(

16 May 2006 - v4.02
	Fixed BWP error by inserting a link routine until the author takes advantage of the new function
	Fixed BG errors. All functioning correctly there now.
	Really not sure what happened on v4.00 release but, going over the code it would appear
	a previous file somehow crept back in with some incomplete routines. :(

17 May 2006 - v4.03
	Fixed the elusive '469' error some were having.
	...(Was finally able to replicate this myself by logging in and out on alternate characters.
	...(Would seem that under certain conditions the Worldmap isn't quite initialised on startup).
	Fixed NotesUNeed compatibility. The 'MetaMapNotes_NotesPerZone' var was removed as it was obsolete.
	...(No longer needed as there is now no limit on the number of notes per zone).
	...(Temporarily re-instated it as a dummy variable with an arbitrarily high figure).
	Fixed escape key by changing call to frame to a call to UIPanel.
	...(Never noticed this as escape has never worked for me on anything anyway).
	...(And would not have been noticed by anyone who still had the 'M' key bound to the original call).
	SideList scrollbar scrolls correctly and now displays correct Tooltips when scrolled.
	Added updated French localisation by Sparrows.

21 May 2006 - v4.10
	Updated a few routines with checks & vars that went missing from the v4.00 post-tests.
	...(This version should now be how v4.00 was originally intended to be released).
	Added additional Zoneshift checks to see if that resolves problems on German clients.
	WorldMapPOI no longer disables notes created by MetaMapPOI. Notes will now function correctly.
	MetaMapPOI no longer spams 'Note too near' messages when attempting to recreate existing notes.
	Removed the KB data stats routine as this was causing massive delays to the display.
	...(Stats are now generated on the fly, resulting in virtually no delay at all).
	Due to the data change, KB will now correctly place a note to the correct instance map.
	...(Sadly no coords in instances so, note is placed bottom right on the map, ready for moving).
	Removed the keybinding to toggle MetaMap. Not required and seems it caused problems to some.
	...(Rebind the M key to the worldmap again for full functionality).
	Boss Loot hooks are now in if the author of AtlasLoot wants to take advantage of them. :)
	Further update to the Spanish localisation. With thanks to Fili.

22 May 2006 - v4.11
	Corrected BG error. Was trying to Zoneshift before actually checking for BG.
	NEW HQ maps added. Created and provided by Niflheim.
	Updated the Instance data for the new map layouts.
	...(*NOTE!!* - You MUST import the new Instance data file to position the notes correctly).

22 May 2006 - v4.12
	Due to popular demand, MetaMapPOI now places its note center of POI again.
	...(Bit close to last update but, I guess many would like that change asap).
	New Map of upcoming Naxxrama instance added. With thanks to Niflheim.

25 May 2006 - v4.13
	Fixed old MapNotes bug where a frame under the Minimap was preventing mouse action in that area.
	...(Removed frame and related Thott coords display. MetaMap has it's own movable coords display).
	Tweaked some of the zoning routines to give added reliability.
	Removed old MapNotes ToggleWorldMap hooks. Replaced by new checking routines.
	Reinstated the MetaMap WorldMap toggle in keybindings.
	...(Any who have delay problems with one, can switch to the other).
	NEW MetaMapPOI will now set a note whenever you ask a Guard for directions.
	Included updated Naxxramas map by Niflheim.
	...(*NOTE!!* - Updated map requires install BEFORE running WoW).
	Updated the Loot keys in the Instance data file in preparation for Boss Loot Tables.
	Added default note information for the Naxxramas map.
	...(*NOTE!!* - You MUST import the updated Instance data file to see the new information).

25 May 2006 - v4.20
	NEW MetaMapBLT is now fully functional. With thanks to Daviesh for providing the core code.
	...(*NOTE!!* - You MUST import the updated Instance data file to ensure Boss keys are loaded).

27 May 2006 - v4.30
	NEW Option on Extended Options menu to set coloured Sidelist entries.
	NEW option on Extended Options menu to show Zone information in WorldMap header.
	Tooltips now show a 'BLT' indicator if a Loot Table is available for that item.
	Removed all Zoneshift routines. Based on feedback, this should work correctly for German clients.
	...(Retained default non-shifting table for other addons which may access this).
	Updated MetaMapBLT Loot Tables with the latest information.
	...(*NOTE!!* - You MUST import the updated Instance data file to see the new information).

29 May 2006 - v4.31
	NEW Dressing room added for MetaMapBLT. CTRL+Click on loot item to show.
	...(Window is moveable while displayed so, can drag it wherever you like).
	Fixed error when mousing over a Mini PartyNote. Old MapNotes bug.
	...(Added additional delete box when clicking on Mini PartyNote).
	Fixed truncation of name when adding QuickNote from command line.
	...(This also fixed error message for nil value).
	...(And why are peeps still using that? Try the hotkey QuickNote. MUCH better. :p )
	Updated Spanish localisation. With thanks to Fili.
	Updated MetaMapBLT Loot Tables And Instance data.
	...(*NOTE!!* - You MUST import the updated Instance data file to see the new information).

03 June 2006 - v4.40
	Added further checking routines for presence of MetaMap modules.
	All old MapNotes routines now fully converted to the optimised MetaMap routines.
	...(That gets rid of over 800 lines of code).
	Removed redundant variables in the localisations and added a few new ones.
	Removed the /qtloc command and merged it into /qnote. See updated parameters in Readme.
	Removed all dependency on Sky for PartyNotes, and added new PartyNote routines.
	...(PartyNote can now be sent anytime to all Party/Raid members without Sky).
	Clicking on a pre-set PartyNote will now bring up the Send/Delete options.
	Party note can now be created on instance maps as well.
	Note edit and Send displays shown normal size and no longer scaled to WorldMap.
	QuickNote display now detects when Escape and Enter keys are pressed.
	...(Just for you speed freaks. Escape closes window, Enter sets QuickNote).
	Escape now correctly closes Note edit box instead of toggling WorldMap.
	...(Something that was in the original MapNotes code for some reason).
	Included German and French localisations for MetaMapBLT.
	Updated MetaMapBLT Loot Tables with the latest information.
	...(*NOTE!!* - You MUST import the updated Instance data file to see the new information).

06 June 2006 - v4.50
	MiniNotes now include author name on mouseover.
	...(Is also subject to the author on/off toggle).
	Setting a map note now includes a check for a related MiniNote, and links it as related.
	...(Also works in reverse. Setting a solo MiniNote will check for related map note).
	Slight change to MetaKB display's visual appearance.
	Added check for incorrect data entry when selecting 'Show All Zones' in KB display.
	MetaKB reporting now correctly disables all targeting messages when 'Show Updates' is disabled.
	MetaKB display will now show zone name when in an instance or unknown zone, instead of 0,0.
	NEW option on MetaKB popup menu, 'Show on WorldMap' will open the map to the selected item's location.
	...(will additionally ping the related note on the map if it is set as a note).
	NEW option in MetaKB section in Extended Options, 'Set map note on map query'.
	...(This will automatically set a note on the map when 'Show on WorldMap is selected).
	...(Note, that this will not be set for an Instance map, as there are no coords to work on).
	NEW Option to sort Map SideList. Header button on top of list will sort/unsort list.
	Updated MetaMapBLT Loot Tables with the latest information.
	...(*NOTE!!* - You MUST import the updated Instance data file to see the new information).

10 June 2006 - v4.60
	Corrected KB nil value error when auto adding notes on targeting.
	Added additionals checks for 'dead' zones. Will now show correct zone instead of instance map.
	Corrected typo for The Stockade. Map should show now when visiting the instance.
	Added Shift+Click to Map Sidelist for inserting details into open message box.
	Updated LootIDs for Naxxramas bosses. Import default Instance data to activate.
	NEW import routine for MetaMapBLT data. Will import default data, or convert AtlasLoot data.
	...(To import AtlasLoot data, simply place the AtlasLoot localisation file(s) into the MetaMapCVT folder).
	...(Updated AtlasLoot data file takes priority over the MetaMapBLTdata.lua default data file).
	NEW option in MetaKB section in Extended Options, 'Embed into WorldMap', shows KB display in WorldMap.
	...(Has the added advantage of having the KB display set in relation to the map viewed).

13 June 2006 - v4.61
	Corrected the German localisation name for The Sunken Temple.
	Corrected string parsing that returned nil error on some Critters when KB targeting.
	Added check for nil value return on Type or Class that are missing on the odd few creatures.
	Added class colour coding to KB captured targets. Is now reflected in KB display.
	...(Name column will now show class colour. The location column still shows proximity colour).
	Added greater flexibility to the /qnote command. See updated parameters in Readme.
	..(Additionally added whitespace/period check as suggested by Gorramit. :p);
	Changed import routine for Instance data. Now adds/updates default data only.
	...(Previously reset ALL instance data - will now keep any additional user added notes intact).
	Added a 'Function Hooks' reference section to the readme for authors of other addons.
	Included Niflheim's new HQ map of Shadowfang Keep and updated the note locations.
	Updated Instance data Loot IDs to match latest AtlasLoot release.
	Added default World Boss locations and Loot IDs to the World maps.
	...(Import updated Instance file from Extended Options to apply the changes).

15 June 2006 - v4.62
	Corrected note sending routine to look at current map, not zone, when sending.
	CTR+Click on any mapnote will now query MetaMapBLT, in the same way as the Sidelist does.
	Added and updated LootIDs for Naxxramas. Updated MetaMapBLT default data.
	...(Import the default BLT data, or the latest AtlasLoot localisation).
	Included Niflheim's new HQ map for Scholomance and updated the note locations.
	...(Import updated Instance file from Extended Options to apply the changes).

20 June 2006 - v4.63
	Keybinding for MetaKB display correctly toggles WorldMap now when embedded.
	Fixed incorrect Tooltips showing when sorting the Sidelist.
	Reworked deletion routines to now retain order of entry.
	NEW Batch delete option for MetaNotes in Extended Options.
	...(Allows note deletion by selected creator at Zone, Continent, and World levels).
	NEW LootLink compatibility. Will automatically use LootLink if it is installed.
	BLT import now gives option to import Default data or AtlasLoot data when selected.
	Added default Battleground locations and Loot IDs to the World maps.
	...(Import updated Instance file from Extended Options to apply the changes).
	Updated MetaMapBLT with the latest database procedures from Daviesh.
	Created a new localisations file to handle the new BLT database format.
	...(*NOTE!!* - You MUST import the updated BLT default data file to upgrade).

22 June 2006 - v4.64
	Updated all text element names in XML to the new 'font' names, as they were not as
	backwardly compatible as Blizzard might have thought.
	Fixed nil error when targeting same critter twice in succession.
	...(Something strange with caching that seems to have crept in with the latest patch).
	Made some changes to a few routines which should eliminate any nil returns on startup.
	Merged MapMod import routine into MetaMapCVT. MapNotes import now gives MapNotes or MapMod option.
	NEW ItemSync compatibility. Will automatically use ItemSync if it is installed.
	Updated MetaMapBLT German and French localisations.
	MetaMapBLT default data updated to match latest AtlasLoot data.
	...(Import Default BLT data to apply the changes).

23 June 2006 - v4.65
	Replaced the checking routine for Instance location that got missed when sorting the startup routines.
	...(Will again auto select the Instance you're currently in).
	Completed the KB routine for level checks when targeting.
	...(Got missed off ages ago and no-one noticed. Thanks to Noja for spotting that at last).
	Removed the routine to add the instance text to the dropdown display on startup.
	...(Still can't figure out why some were getting the nil error so, make do with a blank display on startup :p).
	NEW ZoneShift section added to Extended Options for German and French clients.
	...(MetaMapZSM load-on-demand module currently available as a Beta from http://ui.worldofwar.net).

27 June 2006 - v4.70
	ZoneShift check added when importing default World bosses and Battlegrounds.
	...(Notes should now appear in correct locations, assuming the ZoneShift info is correct).
	NEW MetaMapZSM load-on-demand ZoneShift module added for German and French clients.
	...(Tracker routines will keep track of which ZoneShift was last implemented).
	NEW MetaMapBKP load-on-demand Backup/Restore module added for easy backing up or restoring of data.
	...(Both new module options can be found on the Extended Options).

04 July 2006 - v4.71
	Updated KB and notes 'hook' routines to work correctly on RightClick.
	Menu now checks for Titan and Minimap screen locations.
	...(Will go upwards if Titan or Minimap are located at bottom of screen).
	Updated some routines for better integration to MetaMapBWP.
	NEW MetaMapBWP load-on-demand module available as a Beta from Curse & Worldofwar.net.
	...(Noticed BetterWaypoints was no longer being updated and needed attention).
	...(Not sure if it will remain as such, as it all depends on the author returning to it).
	NEW option in Imports section, 'Export user KB file'.
	...(Creates an Import.lua in the SavedVariables folder, which any MetaMap user can import).
	MetaMapBLT default data updated to match latest AtlasLoot data.
	...(Import Default BLT data to apply the changes).
	Updated the Readme.

10 July 2006 - v4.72
	Hopefully tracked down and fixed startup error a few were getting.
	...(Caused by another addon somewhere, opening the map before all vars were initialised).
	NEW MetaMapBWP module out of Beta, and now included as standard.
	...(Recommend deleting the old MetaMapBWP folder first, to get rid of any obsolete files).
	Updated remainder of MetaMapBWP variables to unique names.
	Fixed occasional BWP nil library error on first run when 'Always On' was active.
	Removed the old WoWKB import routines, as well as the old KB data conversion routine.
	...(The WoWKB conversion utility will do both old data types if anyone still needs it).
	Reworked the Import/Export routines to give a nicer progression overall.
	NEW User notes export facilty will export map notes and lines to the Import.lua file.
	...(Choice to export KB, Notes & Lines, or both to the same Import.lua file).
	...(If both data sets are in the file, the importer will have the same choice on import).
	Updated the MetaMapBLT localisation file with latest info.
	MetaMapBLT default data updated to match latest AtlasLoot data.
	...(Import Default BLT data to apply the changes).
	Updated the Readme.

13 July 2006 - v4.73
	Fixed startup error caused by QuestHistory. No, honest, really fixed this time. :p
	Corrected German Zoneshift matrix for imports. Adjusted routines in Zoneshift module.
	...(Import default Instance data to correct the German World Boss locations).
	RightClick on a KB display item will now handle ranged coords correctly.
	...(Original BWP code incorrectly parsed those as not being in current zone).
	MetaMapBWP menu now checks for Waypoint screen location and positions accordingly.
	Setting a Waypoint will now be retained, even when moving into another zone.
	...(Will display again when moving back into the zone where it was set).
	A Waypoint can now be preset for any note on the map.
	...(Will display when you move into the zone it was set for).
	BWP option added to always set a Waypoint to your corpse when loaded.
	BWP display frame will now remember screen position between sessions when 'Always Load' is used.
	Removed Instance information lines from the Instance maps.
	NEW InfoLine button added to Instance maps. Mouseover shows Tooltip with Instance information.
	...(Clicking on InfoLine button brings up storyline for that Instance).
	...(May look at expanding that to World maps as well at some stage).

13 July 2006 - v4.74
	Quick fix for MetaMapBWP. Removed obsolete call and replaced with later MetaMap function.

14 July 2006 - v4.75
	Fixed MetaMapBWP distance display not updating correctly.
	Changed Instance import routine to direct inject into the database.
	...(Hopefully will resolve the German import issue for World bosses).
	Fixed BWP_MenuFrame overlapping the Playerframe after a menu show.
	...(Original code didn't hide the menu frame. Correctly hides now after a menu show).
	NEW Backdrop Shade Slider added for Instance maps. Slider available on MetaMap menu.
	...(Will only be displayed on the menu when an Instance map is selected).
	...(Will save different setting for each SaveSet as well).
	NEW Shade colour option available on the MetaMap menu.
	...(Toggles the Instance backdrop between black, red, green, and blue).

16 July 2006 - v4.76
	Completed Storylines for remaining instances.
	Added Undercity, Orgrimmar, and Thunder Bluff to MapLibrary scaling.
	...(BWP Distance will now correctly update in those cities).
	Fixed error when attempting to move the map when set to Fullscreen mode.
	Increased Tooltip scaling range.
	Tooltip scaling now checks for NotesUNeed and adjusts the scale accordingly.
	...(Previously NotesUNeed forced the MetaMap setting back to its own setting).
	Fixed unlocalised 'button' variable interfering with another addon's Minimap button.
	Main map coords will now show 'Instance' or 'Dead Zone' instead of boring 0,0 coords.

18 July 2006 - v4.77
	Removed all dependancy on MapLibrary for MetaMapBWP.
	...(Yards/Metres is now handled by a simple conversion routine).
	Added additional checks for initialisation completion.
	Added check for data corruption for near notes routine.
	Replaced old note deletion routine for MetaKB with updated one which got missed out.
	Updated French/English zone conversion matrix.
	...(World bosses now export to correct locations for French clients).
	Added saved instance display to InfoLine button with ID and time remaining.
	Extended the InfoLine button to all other maps.
	...(Currently shows colour coded faction and range levels).

20 July 2006 - v4.78
	Tidied various bits of display stuff.
	Added data verification routine for notes on startup.
	RightClick on InfoLine button now toggles the SideList.
	Instance backdrop now covers entire map when Sidelist is hidden.
	User file export option now remains active for multiple export opportunities.
	Renamed User file for import to 'MetaMapEXP.lua'. Related folder now shown as MetaMapEXP.
	...(Note, as always, ANY file for import MUST be placed in the MetaMapCVT folder).
	Included Niflheim's new HQ maps for Stratholme & UBRS, and updated the note locations.
	...(Import updated Instance file from Extended Options to apply the changes).

22 July 2006 - v4.79
	Fixed ancient problem of non functioning notes when placed on a WorldMapPOI.
	Removed MetaMapPOI delete routine from General tab in Extended Options.
	...(Batch delete option on MetaNotes tab does a better job, without zone restrictions).
	Minimap coords should now update correctly in Battlegrounds.
	MetaMapBWP no longer attempts to set a corpse Waypoint in Battlegrounds.
	Removed the filter icons from Extended Options and moved creator option from MetaMap menu.
	Changed 'Show Notes' option on MetaMap menu to 'Notes Filter'.
	Clicking on 'Notes Filter' shows a Filter Submenu, with options to filter map notes.

24 July 2006 - v4.80
	Fixed Help Tooltip not hiding in Extended Options. Missed it out on last version's rework.
	Deleting a note with bounding box now removes the whole set, including lines.
	Changed icons for outer bounding box. Function as normal icons but, cannot be edited.
	Added routines to hide the bounding box icons and lines when main note is filtered.
	Due to these changes, the SideList now shows only the main bounding box note.

26 July 2006 - v4.81
	Fixed imports not importing all notes from MapMod. Due to a 'break' error.
	Non-boundingbox lines are now also hidden when connected note is filtered.
	BWP menu now correctly hidden on startup, and will no longer cover Player frame.
	Changed the German instance name for Stockades again to correctly select 'Das Verlies'.
	Completed the MetaMapZSM module. Will now also ZoneShift Lines and MetaKB data.
	Extended startup data verification to verify Lines and MetaKB data as well.
	Changed the notes highlighting routine to use a single highlighter.
	...(This allowed the removal of 20 icons, which previously provided the highlighting).
	...(Recommend removing the previous installation before installing this).
	...(This will ensure any redundant files will not be loaded into memory).
	Added routines to handle the new Class Set data format in AtlasLoot.
	Updated the default instance data to match latest AtlasLoot data format.
	Updated the default MetaMapBLT data to match the latest AtlasLoot data.
	...(Import BOTH default instance data and default BLT data to apply the changes).

31 July 2006 - v11100.1
	Version numbering changed to include TOC prefix.
	MetaMapPOI will now correctly set a guard note without the need to open the WorldMap.
	NEW option for MetaMapBWP to auto set a Waypoint on Guard directions.
	MetaKB now displays related data when Continents or World are displayed on the map.
	Removed fixed name tables for ZoneLevels and changed routines to use zone indexes.
	...(That solves any localisation problems, as it now gets the info from the server).
	Standardised module loading routines and improved the event handling for some modules.
	...(Hopefully the changes for FWM might solve the startup problem a few were having).
	NEW MetaKB is now a Load-on-Demand module named MetaMapWKB.
	...(IMPORTANT! If you have saved MetaKB data, ensure you carry out the following).
	1. BACKUP your data from Extended Options BEFORE installing this version.
	2. Install this version, log in to WoW, and load the MetaKB module in Extended Options.
	3. Use the RESTORE option to reload all your saved data.
	4. Reload the User Interface from the Import section to save the data and clear memory.
	...(MetaMapWKB will now load any time you select a related option for it).
	...(Alternatively, set the 'Always Load' option to always have it load on startup).

01 August 2006 - v11100.2
	Fixed MetaMap menu not hiding on mouseout when TitanBar icon was hidden.
	Corrected the timing on a couple of initialisation routines.
	...(Should correct the problem a few were having with scaling and FWM startup).
	NEW Text colour can now be set for Minimap coords display.
	...(CTRL+Click on coords to cycle through colours).

03 August 2006 - v11100.3
	Updated level ranges for instance maps.
	Fixed Battlegrounds attempting to load an instance map instead of the BG map.
	Fixed MetaMapWKB error when selecting 'Show on Map' for a zone other than the current.
	Fixed typo for variable which was preventing BLT from showing when clicking on a note.
	Delayed the MetaMapFWM table initialisation routine to fix the problem a few were having.
	Added routine to correctly distinguish between single note and Bounded note deletion.
	NOTE! If this is a first time upgrade from v4.xx to v11100.xx, read the v11100.1 notes!!

05 August 2006 - v11100.4
	Updated the deletion checking routine and Ping routine for a more global approach.
	...(This fixes all MetaMapWKB bounded note problems, and single/bounded note deletion).
	Bounding box is no longer created when central icon is rejected due to near note.
	Tracked down MetaMapFWM error to incorrectly placed localised functions.
	...(Only manifested itself when there was actual data in the Errata table).
	Removed the Blizzard Instance check, and reverted back to my own routine.
	...(Fixes the Battlegrounds error, which was attempting to load an Instance map).
	NOTE! If this is a first time upgrade from v4.xx to v11100.xx, read the v11100.1 notes!!

11 August 2006 - v11100.5
	Added support for FuBar. Recommended - none of the TitanBar memory problems.
	Fixed error on single note deletion for instance maps.
	Fixed error on Player ping for Sidelist. Missed updating it to changed ping routine.
	Added two keybindings. Each will toggle the WorldMap with a specific saved mode.
	MetaMapWKB will now display newly discovered target message, regardless of Updates option.
	Optimised coords display routines. Should fix the 618 error a few were getting randomly.
	Extended the MetaMapWKB startup verification routine down to zone level.
	NOTE! If this is a first time upgrade from v4.xx to v11100.xx, read the v11100.1 notes!!

11 August 2006 - v11100.6
	Quick fix for MetaMap menu not hiding on mouseout.
	...(Totally missed checking for non existance of FuBar. Apologies on that one).

16 August 2006 - v11100-7
	Updated routine that matches Mininote with existing map note to be totally unique.
	...(Previously took first name match, not taking into account multiples with same name).
	Slight change to the MiniCoords routine.
	...(Possible fix for the unexplainable 616 error a few were getting).

24 August 2006 - v11200-1
	Removed all AtlasLoot import options. Later versions of AtlasLoot are now totally incompatible.
	...(Default BLT import only for now, which I will keep updated).
	Fixed map opening to full screen. Will again open to correct scale setting.
	..(Looks like Blizz screwed up on the 'OnShow' function somehow).
	Fixed MetaMapBLT Dressing room not displaying character on opening.
	No ZoneShifts required for German/French clients on this patch. :)
	..(Load ZoneShift module and select 'Update Version' to update the tracker).
	NOTE! The last version included a MetaMapEXP.lua in the MetaMapCVT folder in error.
	...(DO NOT import this file. DELETE it! It's a ZoneShifted TEST file).

28 August 2006 - v11200-2
	Fixed error when deleting note set in Battlegrounds.
	Notes can now be created in Battlegrounds with the QuickNote option.
