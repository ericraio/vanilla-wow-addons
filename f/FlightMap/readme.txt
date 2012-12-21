                            FlightMap v1.9-3
            By Dhask of Uther, guild leader of The Wanderers

FlightMap is all about the flights you take in the World of Warcraft.

Features
~~~~~~~~
  Flight lines drawn on the World Map when showing a continent
        When you mouse over a zone, flight lines from all flight
        masters in that zone will appear.
  Destination list window on the World Map
        Also on the continent level map, a window will appear in the
        bottom left corner of the map, showing the current zone's
        flights, and their costs and/or times.
  Flight master locations on the World Map
        On the zone level map, flight master locations will appear as
        green "winged boot" icons -- the same as appears on the flight
        selection window.  Flight master coordinates are also given.
  Flight duration meters
        During flights, a progress bar will appear, showing you where
        you are flying to, and how much longer it will take for you to
        get there.  This window can be moved by holding down the SHIFT
        key and dragging the window with the left mouse button.  Its
        position can be reset using "/fmap reset".
  All flight masters shown on the flight selection window
        When you talk to a flight master, FlightMap will fill in all
        the flight master locations, and the paths between them.  For
        destinations with no direct flight, FlightMap will show you
        the shortest route there, and automatically take the first
        stage of that route if you click on the destination's icon.
  Open the flight selection window anywhere
        FlightMap offers a key binding to open the flight selection
        window any time, showing you all routes on either continent.

Options
~~~~~~~
Use /fmap or /flightmap to bring up the options window.  From here,
you can enable or disable the world map line drawing, the flight timer
window, the flight master icons on the world map, and the flight
selection window enhancements.  You can also choose whether you want
to see flight times, flight costs, both or neither, and whether you
want to be shown flights and flight masters your current character
hasn't yet discovered.

To view the flight selection window any time, you must bind a key to
open the window from the Key Bindings menu.

Operation
~~~~~~~~~
FlightMap comes with a fairly comprehensive set of already known
flight details.  For the Alliance, this set is complete as of patch
1.8, but may be inaccurate as flights are changed and added.  For the
Horde, this set is complete as of patch 1.8 save for a handful of
flight times, but may also be inaccurate over time.

FlightMap will update itself whenever you open a flight selection
window.  This will tell it that your current character knows the
current flight master and any flight masters your character can reach
from there.  Knowledge of flights between distant masters will be
inferred from which flight masters your character knows.  The costs of
flights will also be updated to match what you see.

When you take a flight, FlightMap will adjust its stored time for
flights that are longer or shorter than what it knows.  This
information is shared across all characters, so FlightMap will be
inaccurate at most once per patch.

Credits
~~~~~~~
Many thanks to Thorarin (aka Marcel Veldhuizen) who not only reported
bugs, but also reported their fixes, and who supplied the Alliance
default data. Thanks also to Simon, who has helped immensely with the
German translations. And of course, thanks to everyone who downloaded
beta versions, put up with bugs and helped me fix them, and for those
who offered suggestions or asked for features.
