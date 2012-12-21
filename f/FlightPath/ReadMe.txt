
               ----- Kwraz's Flight Path Tracker -----
               
NOTE: I AM NO LONGER ACTIVELY SUPPORTING FLIGHTPATH FOR PUBLIC DISTRIBUTION.
      I MAY UPDATE IT AS NECESSARY TO WORK WITH BLIZZARD API CHANGES, BUT
      NO FURTHER ENHANCEMENTS ARE EXPECTED TO BE MADE.  Kwraz 6/22/2006

This World of Warcraft addon makes flying around the world of Azeroth a
little easier.

It automatically learns flight paths as you talk to flight masters, including
any future flight paths Blizzard may add. It also comes with a list of flight
paths, zeppelin routes, and boat connections that you can load if you desire.

FlightPath has the following features:

o  Known flight masters show up on your zone maps. Hovering your mouse over
   the icon displays all the connections available from that flight master.

o  An on screen arrival time countdown is displayed while in flight once
   FlightPath has learned the time it takes to make the trip.

o  When talking to flight masters, the time needed to make each trip is
   shown in a tooltip as you hover over each destination.

o  You can bring up a dialog that allows you to query connections by typing
   '/fp' at the WoW chat prompt (bindable to a key). You can then click on
   the connections that are displayed in the dialog and the view switches
   to the clicked location. If you right click on a connection, the map for
   that zone will open with the flight master's location highlighted.

o  Many of the travel paths around Azeroth have been supplied. You can load
   these with the '/fp load' command if you don't want to learn them all
   yourself.

There is no configuration needed. Just unzip the files into the WoW
Interface\Addons\FlightPath directory and log in.

FlightPath learns new flight paths when you talk to a flight master. The
duration for each flight is not recorded (or known) until you actually fly
the route. You have to have either flown to a destination or talked to the
flight master there before FlightPath can learn that flight master's
location for display on the zone map.

Every time you talk to a flight master, the prices are checked and updated
in the event you have achieved a faction discount.

Enjoy!


Kwraz
60 Troll Mage
Black Lotus
Icecrown

kwraz@kjware.net
(or in game mail to Kwraz if you play Horde on Icecrown)



Updates to FlightPath can be found at the following places:

http://ui.worldofwar.net/ui.php?id=594
http://www.curse-gaming.com/mod.php?addid=909


Version History:

  Date    Rev    Comments
--------  ----   --------------------------------------------------------------
 9/13/05  1.14   - Fixed WorldMapButton:OnUpdate error, UI version set for 1.7

 6/27/05  1.13   - Update to WoW UI interface version 1.5
                 - Flight time remaining could be a bit off on slow computers. Fixed.
                 - Width of on screen destination increased to prevent truncation

 4/18/05  1.12   - Removed debug statement causing concatenate error.

 4/18/05  1.11   - I broke the /fp load command in 1.10. It has now been fixed.

 4/18/05  1.10   - Bound key now toggles dialog on/off correctly
                 - Alt-Z to hide UI now also hides the in-flight counter
                 - Aligned text on the zone map connection tooltip (cosmetic)
                 - Zone names with foreign characters in them (for non-English
                   clients) should now work correctly
                 - Other faction's flight paths were showing on the Booty Bay
                   zone map tooltip. Fixed.
                 - Changing zones with the FlightPath dialog open caused the
                   dropdown list to display zones instead of flight master
                   locations. Fixed.

 4/14/05  1.09   - Fixed incompatibility with VisibleFlightMap
                 - Zone map icons changed to the same as the flight master's map
                 - Undiscovered flight path locations show as grey on zone map
                 - Dialog drop down box scaled down to fit within dialog
                 - Many Alliance flight paths added (thanks Morphiasgnom!)

 4/13/05  1.08   - Added key binding support
                 - Undiscovered flight masters no longer show on zone map if
                   /fp hidegrey set
                 - Added more durations to Horde flight paths
                 - Added hideremaining and showremaining commands.
                 - Fixed problem with incorrect locations being stored for flight
                   masters

 4/12/05  1.07   - On screen 'flight time remaining' countdown added.
                 - Added the '/fp load' command to allow loading supplied flight
                   info.
                 - Flight duration now shown in map tooltip when talking to
                   flight master.
                 - Added confirmation dialog to /fp erase.
                 - Added myAddons support.
                 - Flight durations are now tracked separately for each direction.
                   (They initially start out the same).
                 - Fixed 32 location limit on dialog drop down
                 - Removed the obsolete HordePaths.lua and AlliancePaths.lua
                   file. All supplied paths are now in KnownPaths.lua

 4/8/05   1.06   - Fixed a problem with Stormwind, Ironforge, and Moonglade.
                 - Added the '/fp hidegrey' and '/fp showgrey' commands.
                 - Added the '/fp erase' command to erase your recorded flight
                   paths.
                 - Added the '/fp check' command to help users debug flight
                   master location mismatches.
                 - Fixed a problem with the KnownPaths.lua file that caused the
                   supplied preloads to be greyed out.
                 - Added a skeleton AlliancePaths.lua.

 4/7/05   1.05   - Fixed minor string error the first time FlightPath is
                   installed

 4/7/05   1.04   - Escape key now closes the FlightPath dialog.
                 - Whether or not to gray out a connection is now tracked by
                   character, since different characters will know different
                   routes. Note that the first character to log in after
                   installing this version will have all your existing flight
                   paths flagged as known (including preloads).

 4/7/05   1.03   - Unreachable routes are now greyed in map tooltip as well.

 4/7/05   1.02   - Removed some bad cost data in the HordePaths.lua file.
                 - Preloaded flights you cannot take are now shown in gray. (Note:
                   you have to clear your SavedVariables.lua data and reload if you
                   loaded preloaded flights with a previous version of FlightPath.)

 4/6/05   1.01   - Fixed a problem with the drop down listbox position when many
                   entries

 4/6/05   1.0    - Initial release
