This is Gatherer v<%version%>
http://gatherer.sf.net/

ABOUT:
--------------
Gatherer is an addon for herbalists, miners and treasure hunters in World of Warcraft. It's main purpose is to track the closest plants, deposits and treasure locations on you minimap.

The addon does not track like a tracking ability does, rather it "remembers" where you have found various items in the past. It does this whenever you gather (perform herbalism, mining or opening) on an item, and records the specific map location in it's history. From then on, whenever the item comes into range of being one of the closest 1-25 (configurable) items to your present location, it will pop up on you minimap.

When you view your main map, you will also see the item locations marked on the particular map you are viewing there.

INSTALLATION:
--------------
Extract the data to your "World of Warcraft/Interface/AddOns" directory so that the "Gatherer" directory is a subdirectory of the "AddOns" directory.

USAGE:
--------------
Just use the game as normal.
When you gather things, they will appear on your minimap and your main map.
If you want to configure the addon, click the Gatherer configuration icon floating around your minimap frame or type /gather options.


CHANGELOG (- done, = to test, + todo):
----------

2.2.0:
======
# Bug Fix:
- map delay/freeze problem fixed, brought back max items displayed on world map to 600.
- fixed typo in GathererUI_Lang.lua for zone match (french localization only) with fix item checked.
- added extra convertion of old style quote to standard quote for german version (zone match, fix item checked).
- Silithus scale and offset fixed (courtesy of an unknown contributor on the forum who did the math).
- added extra check to prevent record in pre-instance zones
- zoomlevel (indoors too) taken into account for minimum icon distance.
- Put node icons back under character icon/pointer (minimap)

# Change:
- Mininote tooltips display multiple nodes at the same location.
- Added radius component to minimap icon position.
- Added reset button for filters
- added sub-menu for item filters dropdown (herbs).

# New:
- native In-game Help

2.1.1:
======

# Bug Fix:
- Dark Iron recorded as Iron (english version) and not recorded (french version) now records (Note that english users will have to use the node editor to correct the icon type for already recorded dark iron).
- Init based on ADDON_LOADED instead of VARIABLE_LOADED
- Modified init for UNIT_NAME_UPDATE to work along with VARIABLES_LOADED to allow proper initialization when changing character without exiting the game.
- French localisation, all "veine" were translated to "filon", this has been included in the fix item facility of the Zone Rematch.
- minor display and parameter parsing fix for /gather loginfo command
- Backdrop color for option dialog reverted to black (1.7 wow patch inverted colors for backdrop frame functions).
- Added divide by zero check and default value in report and search routines for % calculations.
- Minor fix to Gathering event well no skill (or too low skill) is used so that the item count isn't increase (or set to 0 for a new node).
- Upgraded transition matrixes number to 1.7 for German and French (identity matrix, zone order did not change between 1.6 and 1.7).
- Added extra check for changing maps.

2.1.0: (#1700)
=======
# Bug Fix:
- error on load fixed (False instead of Hide in widget call).
- error opening report dialog in specific place fixed (Onyxia lair, etc.), change base dialog placement so the handle should be grabbable to move the dialog where you want it.
- added warning and ignore for invalid continent/zone in database in Search UI code (ie. = 0).
- box icon changed to the same one as Crates (previously using the Chest one).
- new icon for rich thorium veins (courtesy of ksmith22).
- changed icon for Blood of Heroes to correct one.
- small correction for required skill level values in GatherIcons.lua for Dark Iron and Rich Thorium veins
- small fixes in german localization

# Change:
- polling the skill tree for existing Gather skill on the character will trigger only at startup and upon learning new skills (tree skill state will be conserved too, contrary to old behaviour which opened everything every 5 seconds)
- Configuration Dialog and Zone match dialog movable (new UI dialogs are movable too).
- Filters in the world map screen reworked in a single dropdown menu.
- Option dialog reorganized to use tabs (Filters, Globals, Quick Menu).
- Reorganized content of UI_localization.lua so that it's easier to fill in, texts and tips regrouped by dialog.
- Upgraded myAddons support up to version 2.0 standard (along with help pages for english, french and chinese).
- added small delay to display/hide notes on world map (50 ms every 100 notes).
- redistributed world map buttons in subframes of the GathererOverlayFrame (rougthly 100 per subframe).
- updated #interface number for 1.7.0 WoW Patch

# New:
- report by zone (new UI, access through command line, binding, button on config dialog, button in quickmenu).
- search utility (new UI, access through command line, binding, button on config dialog, button in quickmenu).
- Ingame edit utility for nodes (delete, toggle bugged, change icon, type, gather name) with selectable scope at node, zone, continent or world level for propagation of the change, alt right click on a node on the world map to display the dialog. 
- added world map icon alpha setting selector in config dialog.
- added option to have an alpha value for mininotes under the minimum icon distance (100% by default).
- added binding for option, report, search dialogs.
- added dark iron to gatherable items (for WoW 1.7.0, icon courtesy of ksmith22, possibly missing french text).
- added shellfish trap items.
- support for Chinese WoW added (thanks goes to biAji for localization).

2.0.4.2: (#1600)
========
# Change:
- coupled display of the "show items" button with the basic world map display activation (behaviour unchanged).
- scaled down buttons and dropdown menus on world map by 30%
- coupled display of filters in world map to basic world map display activation.
- added checkbutton in configuration dialog to ignore the show/item item button (enable at your own risk).

# Bug Fix:
- attached "show items", "delete" and "toggle bugged" buttons relative to WoldMapPositionningGuide for proper display in large resolution mode.
- error when using linked filter recording with empty filters fixed.

# Layout:
- layout in configuration dialog rearanged to put all buttons in the subframe they belong to.

2.0.4.1: (#1600)
========
# Bug Fix:
- world map filters display option value taken into account at logon

# Localization:
- French region table updated for new zone order in 1.6.0, translation matrix between 1.5.1 and 1.6.0 added.

2.0.4: (#1600)
======
# Bug Fixes:
- brought back the maximum number of items displayable on the world map to 300 (600 was causing disconnect in some cases) as a temporary fix until the world map display can be done another, meanwhile use the filters provided in the configuration dialog to see what you're interested in.
  Note that this does not resolve the basic issue (the delay itself isn't in Gatherer but in the game UI engine) but seems to make the problem not occur. Also it almost never seems to occur when you come back to the map your character is in before exiting the world map.
- a side effect of the new format will fix wandering icons on the minimap for users importing data  (could previouly be fixed by doing a zone match with same source and destination or running the RecalcNotes function which was removed since it now serves no purpose without minimap coordinates in the stored data).
- caught a few memory leaks (still plenty around though).

# Features:
* Commands:
- added /gather loginfo on/off slash command to show/hide logon information (version string is still displayed).
- added /gather filterrec slash command and corresponding checkboxes in the configuration dialog to link actual recording of nodes to the current filter content (broken down by characters and gather type).

* Database:
- Changed database format, replacing gtype and icon by indexes (saves 30-50% space depending on database content), complete conversion will only occur on using the zone match facility (same origin and destination).
- Gatherer version number added in GatherConfig.Version variable (for DB backup applications).

* Items
- New Items:
  - Un'Goro Power Crystals 
  - Un'Goro Soil
  - BloodPetal Sprouts
  - Blood of Heroes
  - Footlockers (need to unlock them before being able to record them, so this is rogue only strictly speaking)
- New set of icons for Ores and Un'Goro items (courtesy of Wt, Melina and Iriel).
- Rich Thorium now has it's own icon (a placeholder really, until someone provides something more appropriate), the change will appear immediately on the world map, change on the minimap will be visible only after using the zone match facility (same origin and destination).

* External interface
- New interface function (Gatherer_AddGather , see Gatherer.lua for parameters) for external addons to add record things in the Gatherer database.

* World Map
- World Map now has a show/hide button for items (lower left corner), It is off by default and will reset to that whenever you change zone (or miniregion), if the display is off, the delay/freeze while displaying items on the world map won't happen (if any) until you click to show the items. 
- Filters are now accessible from the world map (note that changing the on/off/auto setting from the world map will bring you back to your character's current zone map). This is off by default, to enable it, check the button in the configuration dialog.
- Interface to delete/flag node as bugged (accessible through alt-right clicking on an item, which used to delete it right away), these buttons appear on the lower right of the world map frame when available.

* Localization
- Localized clients (ie. non-english) will get a popup at startup if a version new of Gatherer is installed as a reminder to check for new zone matches), this will be enabled when appropriate.

2.0.3:
===========
* Bug Fixes:
- Localization:
  # german: error in localization.lua
- Map should show correctly in battlegrounds now.

2.0.2:
===========
* Bug Fixes:
- Localization:
  # english: barrel gathering should now read barrels that have the keyword at the beginning of the gather text
  # german: firebloom, mountain silversage, clam, rich thorium and small thorium should be fixed, "ooze covered" display problem should be fixed too.
  # french: zone transition matrix for wow patch 1.5.0 added
  # french: new french GatherRegionData ordered table
- slowdown on using no icon under min distance option should be lessened in gather item heavy environment
- delay opening world map with a huge number of items should be reasonable now.

* Features:
- Icon size on worldmap can now be changed (between 8 and 16, included, hit enter in the edit box to validate the new value)
- option to hide the minimap menu icon
- tooltips added for all UI elements
- added tooltip to menu title to make it more obvious you can click on it to access configuration dialog
- option to hide mininotes while still displaying gather items on minimap
- option to display full item name on worldmap item tooltip instead of the short one (thorium will always show the long name whatever the option value is)
- myAddOns support
- ingame item deletion facility added (alt right click on item on the worldmap), alt mousing over an item in the worldmap display full name and item indexes in the GatherItems structure.
- misc: added a hundred more buttons to display items on world map as part of the large item DB fix.

2.0.1:
======
* UI: New movable UI button on minimap border, gives access to a quick toggle menu for main filters (options for show/hide the quickmenu and move the minimap icon in the options dialog).
* UI: by clicking on the quick menu title, you access a configuration windows for Gatherer options (can also be accessed by using /gather options).
* UI: key binding available for the quickmenu.

* Filter (UI only): possibility to filter ore/herbs display by giving minimum skill level (text field next to the gather type filter boxes).
* Filter (UI only): possibility to select specific objects to display.
* Filter (UI only): couple rare ore/herbs so that they can be displayed together (ex: tin and silver shown together by selecting only one, or for herbs selection swiftthistle will show briarthorn and mageroyal)
* Filter (UI only): prevent gatherer icon from displaying when a node is closer than the min icon distance (used to switch between theme icon and item icon).

* Localization: french and german localization fixes
* Localization: facility for swapping data around zones and fixing item names for localized clients

* Various: GatherRegionTable moved to it's own file outside of Gatherer.lua

* Bug Fix: remaining RegisterForSave removed from code, in some case they could cause a fatal client error with #132 error (note: this is not specific to gatherer, it's true for all WoW addons)
* Bug Fix: missing icon for treasure in original theme fixed
* Bug Fix: Real zone text is now used that should alleviate difficulty to display the map in some zone on first try (ie. Ironforge).


1.9.12:
=======
- Updated patch number.

1.9.11:
=======
- Fixed some other small stuff

1.9.10:
- Fixed nasty bug where icons would not appear on minimap.

1.9.9:
======
- Fixed minimap tooltip layering issue

1.9.8:
======
- Patched to version 1.2.4
- Added extra german and french localizations
- Fixed wandering icons on french localized versions
- Reduced sizes of minimap icons to 12x12
- Increased size of mainmap icons to 12x12
- Improved visibility by moving minimap icons below player and skill icons
- Added the ability to add herbs/ore when you do not have the ability simply by attempting to gather it (triggered by the error message that you can't gather it)
- Tweaked map-minder to be less annoying
- Fixed map-minder disable bug

1.9.7:
======
- Fixed stupid unset variable bug with mapMinder

1.9.6:
======
=> Patch day! Now up to date with patch level 4211 (1.2.3)
- Reduced size of icons on main-map, made partially transparent and popped 'em under the player icons.
- Added "Map Minder". This little beast will remember your last open main map for 60 seconds and then take you back to it. If it's more than 60 seconds, you get taken to your current location. You can turn it off with the new "/gather minder off" command, but then you will just be taken to your current map every time you close and reopen your main map.
- Changed the icons, so they no longer have a border... nobody liked em 'cept me... Poot.
- Added icon fading in your minimap so that as the icons get farther away, they will progressivly fade out.
- Added partial German translations care of Lokibar - Dankeshoen! (Any further translations very welcome!)

1.9.4:
======
- Fixed a bug when no arg1 was passed to the buffer reader.

1.9.3:
======
- No major changes, just packaging changes.

1.9.2:
======
- Fixed positioning, add multiline notes, correctly justified.

1.9.1:
Fixed ore and treasure not appearing on main map as icon, but as a circle.
Deleted a rogue print2 statement.

1.9.0:
======
- Fixed wandering icon bug
- Added main-map item locations
- Added locale fixes for French localized version

1.8.8:
======
- Fixed some herb icon displaying stuff for mountain silversage and wildvine.

1.8.7:
======
- Fix ore gathering bug that was causing ore to not be recognized.

1.8.6:
======
- Cosmetic change - names in tooltips now in Title Case

1.8.5:
======
- Fixed bug where data was not initialized causing error

1.8.4: (many thanks to Jet who contributed much for this version)
======
- Fixed bug with icon display causing script errors
- Added per character filtering options.
- Added localizations in french.
- Added giant clam treasure

--------------
Revision: $Id: Readme.txt,v 1.15 2006/01/04 11:55:00 islorgris Exp $
