== Skeev's SimpleTip (redux) : Ayradyss code mod ==
Following are the previous notes for SimpleTip 1.2.4, the last available version of SimpleTip.  It's been several version patches now and no new SimpleTip to be found.  The original SimpleTip is available at Curse Gaming, http://www.curse-gaming.com/mod.php?addid=425 and ALL coding credit should go to Skeev.  I just updated it for the last few patches and changes therein.
I'm releasing 1.5 with the understanding that if Skeev wants me to make it go away again, or updates his own SimpleTip, it's all his code and hard work, not mine.  And so.

-- SimpleTip 1.5a --
Skeev's simple tooltip enhancer, redux credit to Ayradyss - dr.nykki[at]gmail.com

* Enhances the player/NPC tooltips by doing the following:
1) Set tooltip background color according to faction/aggro
2) Changes player tooltips to read as follows:

   Avara
   Undead Priest, Level 39
   <Draug Ronoh>
   PvP

3) Adds PvP line to only PvP-flagged NPC's/players
4) Newbie tips, if they're enabled, should be left intact
5) Configurable tooltip repositioning

Skeev said his version was localization-friendly, so I presume this one is.

* Usage: 
-- Base usage:
  /simpletip [command]            ( /stip [command] )

-- In-game help:
  /simpletip help                 ( /simpletip usage, /simpletip ? )

-- Set base tooltip position:
  /simpletip moveto [pos]         ( /simpletip anchor [pos] )

  Where [pos] is one of the following:

	 topleft     top     topright
	  left      center    right
   bottomleft   bottom  bottomright

   This sets both the overall location of the tooltip (top left corner, bottom center, etc), as well as which point on the tooltip is anchored -- e.g. "/simpletip moveto bottomleft" positions the tooltip at the bottom left corner of the screen, such that it grows up and to the right from there, depending on the size.
   Or, to tie the tooltip to the mouse pointer:

  /simpletip moveto pointer       ( /stip moveto pointer, /stip moveto mouse )

-- Fine-tune tooltip position:
  /simpletip offset [x, y]        ( /simpletip xy [x,y] )

  Set [x, y] values to offset the tooltip from the absolute corner/edge.  The "x" value controls the horizontal position (- left, + right), the "y" value controls vertical (- down, + up).
  When the tooltip anchor position is changed, the [x, y] offset values automatically default to set the tooltip slightly inside the edge of the screen.
  If the tooltip is set to the mouse position, offsets are disabled.

-- Disable tooltip positioning
  /simpletip nomove               ( /simpletip noanchor )

  This prevents SimpleTip from making any adjustments to the tooltip position whatsoever -- the tooltip will appear in the default location (or, SimpleTip will stay out of the way of any other tooltip position mods you are using).
  This is the "default" state -- until you tell it otherwise, SimpleTip won't attempt to reposition the tooltip at all.


-- Show position / offset status
  /simpletip status               ( /simpletip show, /simpletip info )

  SimpleTip will display the current placement settings in the default chat window.

-- Show / hide PvP flagged line
  /simpletip pvp [status] where [status] is either "show" or "hide" :)
  
-- Credits
  /simpletip about                ( /simpletip credits )

  SimpleTip will tell you who the fabulous people are that worked on this mod.  And they are fabulous (well, once someone helps with translation, it'll be a "they", for now, it's just "he".  But he's fabulous nevertheless).
  [Well, now it's two, and Skeev is way more fabulous than I could ever be, but it's cool anyway.]

*** CHANGELOG ***
1.5 : Ayradyss assumed care and feeding of SimpleTip, in Skeev's absence.  Maintaining WoW-synced version numbers.
- Removed the level reveal functionality; sadly, it doesn't work any more.  ?? is ??.
- Also returned the skull texture to ?? level folks.  Otherwise, strange things were happening.
- Added /stip pvp on|off option.
- Updated version number.
1.5a : Whoops, that was interesting.  When did it start eating doodad tooltips?





== SimpleTip v1.2.4 by Skeev of Proudmoore (North America) ==

A basic tooltip-enhancer.  Coded to a) make the tooltips look the way I wanted 'em to, and b) do it as efficiently as possible, so's to minimize impact on framerate.

I use it with (and wrote it for) Gypsy, but it should work with dang near anything.  It's as localized as possible; however, the repositioning commands and help info need translations (if you're up for translating the text into French and/or German, shoot me an email -- I'll add you to the credits :)

French translation by:  (translator needed!)
German translation by:  (translation in process, allegedly)
Korean translation by:  (translator needed!)

Send suggestions/bug reports/etc to myers(at)pobox.com.  Enjoy!


== Enhances the tooltip by doing the following:

1) Set tooltip background color according to faction/aggro
2) Changes player tooltips to read like so:

   Skeev
   Gnome Rogue, Level 60
   <Sidewinders>

3) Removes "PVP Enabled" and "PVP Disabled" from both player and NPC tooltips
4) Reveals all monster levels (ie, no ??) on both tooltip and target panel
5) Newbie tips, if they're enabled, should be left intact
6) Configurable tooltip repositioning
7) Localization-friendly


== Command usage:
(See commands, above.)

== Revision history

v1.2.4-1  Fixed version number correctly.  Sorry 'bout that :)

v1.2.4    Updated version numbers to match most recent Blizzard patch.  No other changes.

v1.2.3-1  Fixed bug where tooltips would blow up to cover 90% of the screen if you opened a bag while a tooltip was up.

v1.2.3    Two significant additions:  level reveal and repositioning.  Switched to Telo-style version numbering (synced with WoW version #).

v1.02a    Fixed toc file for wow patch 1.2.3 (4211); tightened up event handler

v1.02     Fixed tooltip resizing weirdness that cropped up

v1.01     Fixed the odd bit of item names turning gold when browsing w/vendors

v1.0      Initial release
