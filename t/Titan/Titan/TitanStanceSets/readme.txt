StanceSets - v10

===========
Quick Start
===========
THIS ADDON REQUIRES THE WeaponQuickSwap ADDON v17 OR ABOVE!!
http://capnbry.net/wow/

Unzip the contents of the zip archive into your WoW game directory. 
Make sure you "Use folder names" so the files end up in the right
place.  You should end up with:
  <wowdir>\Interface\AddOns\StanceSets\readme.txt
  <wowdir>\Interface\AddOns\StanceSets\StanceSets.toc
  <wowdir>\Interface\AddOns\StanceSets\StanceSets.xml
  <wowdir>\Interface\AddOns\StanceSets\StanceSets.lua

Typing /stancesets will open the stance set configuration dialog.  Drag and drop
the weapons you want equipped for each set into the containers, starting from 
the left.  If you want to make sure the first set is in your hands when you
assume that stance / form, check the "Equip first on activate".  If you do not
have this checked, and the weapons in your hand match one of the sets from your
new stance, no swap will occur.  To remove a weapon, drag it off the slot.

Up to 3 sets of weapons can be available for each stance.  To cycle through
them, use "/stancesets next".  The addon will loop around to the beginning of 
the list when it sees the first empty mainhand slot, so:
weapon1,weapon2    blank,weapon3    weapon4, weapon5
will not cycle at all if your hands are already holding weapon1 and weapon2.
If you don't have any matching set in your hand when you call "next", the first
set will be put in your hands.

The panel toggle and set cycle can be bound to a key combination.

** CapnBry <bmayland@capnbry.net> **

Thanks to Hackle (on Icecrown) for validating my stance list code and tracking 
	down the (A, )->(B,C) bug.
Thanks to Richard Hess for fixing the missing sound problem.

Version History:
10 - Fix for "Duplicate header" error in FrameXML.log.  Thanks to James Stuart
		 for pointing this out.
9 - Interface version 1300.
8 - Interface version 4216.
7 - Interface version 4222.
6 - Interface version 4211.
5 - Fixed drag n drop support to stance item buttons.
	  Fixed missing sound when opening and closing stance set frame.
	  Fixed problems with (A, )->(B,C) swaps, where (A, ) would always stay equipped.
4 - Added sounds to dialog open and close.
3 - Fix for not being able to add weapons to a new set
2 - Fix for "Attempt to index StanceSets, a nil value"
1 - First release (2004-12-30)