IMBA (IMpervious Boss Addons) 1.4 - November 11th, 2006
by John "Cryect" Rittenhouse
This is an addon trying to achieve the third generation of information supplied by boss mods. All options can be set via the options window which can be accessed via "/imba". Windows if hidden will pop up on the start of a boss fight so you can position and close them. 

For the Addons Friendly Neighbor and Tank Finder they have slash commands for targeting a unit in a macro. For Friendly Neighbor its "/targetfn #" where # is the position on the list and the same for Tank Finder except its "/targettf #". For either of the commands to work the player needs to have the corresponding window open.

Current Addons
-Zul'Gurub
	Hakkar
-Temple of Ahn'Qiraj
	Huhu
	Ouro
	Twin Emperors
	Viscidus
-Naxxramas - Abomination Wing
	Grobbulus
	Gluth
	Thaddius
-Naxxramas - Deathknight Wing
	Razuvious
	Gothik
	Four Horsemen
-Naxxramas - Plague Wing
	Noth the Plaguebringer
	Heigan the Unclean
	Loatheb
-Naxxramas - Spider Wing
	Anub'Rekhan
	Grand Widow Faerlina
	Maexxna
-Naxxramas - Frostwyrm Lair
	Sapphiron
	Kel'Thuzad
	Kel'Thuzad - Interrupt Assister
-Other
	Blackboard
	Friendly Neighbor
	Minimap Marker
	Raid Icon Monitor
	Range Checker
	Tank Finder



Credits
A Function for parsing strings is taken from AIOI
The Templates for enabling & disabling mods is from CTRA (I really liked that setup so figure I would borrow it)
Thanks to MRNaxxramas addon for the basis of the charge detection on Thaddius and the quick confirmation of a few events for a few boss encounters (my own personal old CTRA Boss addons over used events lets say)
Template for the timer bars is based off the template from SWStats
Thanks to Transcriptor for easing my logging of events for AQ40 (I wish I had known of this for Naxx :-p)


Release History
1.4 - November 11th, 2006
Fixes the error message when you login
Fixes closing on mob death (whoops >_>)
Adds raid tracking ability though no tools to use it yet (next version but wanted to get 1.4 out with Fixes)
Changed how maps work slightly with Blackboard to allow catergorizing by zone
Four Horsemen mod will now flash red when Blaumeux casts a void zone or you are standing in one
Fixed Faerlina enrage announces to take into account silences
Added the below Boss Mod
-Hakkar

1.3 - November 4th, 2006
Adds French Translation for boss mods in Naxx for all but Four Horsemen, Sapphiron and Kel'Thuzad thanks to A.su.K.A
Boss Windows will now AutoClose on Boss Death
Fixed Rogue not being selectable to ignore for Friendly Neighbor (sorry rogues :-p)
Fixed issue with leaving combat and reentering can trigger the addon to restart (Feign Death or Combat Res will both cause this issue)
Added the slash commands "/targetfn #" and "/targettf #" to allow users to easily macro targeting a specific position in the list


1.2 - October 30th, 2006
Fixes bugs with Ouro, Twin Emps, and Viscidus addons
Adds Blackboard

1.1 - October 25th, 2006
Fixed Minimap Issues with other minimap mods
Changed unit boxes that find mobs by name to be able to click on to target those mobs and determine the health without anyone targetting them (will be broken in TBC though)
Raid Icon Monitor now no longer shows raid icons that haven't been seen in 30 seconds (autohides/shows them as they are added/removed)
Fixed an issue with whispers for Horde side being in common
Added the below boss mod
-Twin Emperors

1.0 - October 22nd, 2006
First Public Release
Fixed various bugs from 0.14
Added the below boss mod
-Huhu

0.14 - October 14th, 2006
Likely the last version before a public release.
Changed the way to simplify how timers are started and added prewarning msgs.
Changed how options are done and setup so its on a per character basis instead of per account the settings (as a result your old settings are all gone).
Major changes that allow you to customize how most things look
Changes to most the various boss mods adding more alerts if chosen to be enabled
Added the below new boss mods
-Ouro
-Viscidus

0.13 - October 2nd, 2006
Fixes an error with minimap additions
Added a Range Checker mod which can be set to activate for the relevant fights
If the background is Grey then the mod is currently not checking range
If the background is Red then you are too close to someone 
If the background is Green then you should be a safe distance from everyone
Is setup to automatically disable/enable for Kel'Thuzad, Sapphiron, and Four Horsemen. Other fights you want to use it for will have to set it to always active

0.12 - September 30th, 2006
Added minimap markers for Sapphiron for the Ice Blocks
Added few announces to Loatheb mod
Improved performance of the minimap markers
Added the below Boss Mods
-Kel'Thuzad
-Kel'Thuzad - Interrupt Assister

0.11 - September 26th, 2006
Fixed issue with when bringing up the map it saying activated/deactivated
Fixed some issues with attempting to send alerts to everyone when not promoted
Added the Minimap Marker which allows the Raid Leaders to place icons on everyones minimap

0.10 - September 24th, 2006
Added option for scaling the alert message size
Added ability to deactivate raid announces for Four Horsemen in options (will be allowing raid announcements in other addons shortly)
Can non deactivate/activate IMBA by ctrl clicking on the minimap icon
Added the below boss mod
-Sapphiron

0.9 - September 20th, 2006
Fixed Class Colors actually being saved this time for Friendly Neighbor >_> 
Fixed all the health bars so you can click spells on them and will cast at that unit
Few more optimizations mainly for memory
Added the below boss mod
-Instructor Razuvious (Still planning to add mod with timers for all abilities and cooldowns)

0.8 - September 19th, 2006
Performed a lot of performance tuning which should improve performance by at least 2/3 fold. (Tank Finder, Friendly Neighbor, and Raid Icon Tracker had the most tuneups)
Fixed some minor bugs with Tank Finder & Friendly Neighbor (dead people on the list and class colors not being updated on UI reload or restart)
Fixed an issue with SW Stats 2.0 screwing up log parsing
Added the below boss mod
-Noth the Plaguebringer
Disabled the full version of Four Horsemen but its still there just add it to the TOC if you want it

0.7 - September 17th, 2006
Fixed a bug preventing Maexxna from popping up
Added feature to Friendly Neighbor allowing classes to be selected for tracking and allowing bars to be colored instead by class colors
Changed the Minimap Icon
Added the below mods
-Thaddius Phase 1 & 2 (Phase 2 mod also reduces combat log range for just the Thaddius fight to improve performance)
-Raid Icon Monitor (Tracks the HP of all the Raid Icons and allows them to be clicked on to target if someone else has one targeted)

0.6b - September 13th, 2006
Performance change with how events are handled

0.6 - September 13th, 2006
Added alerts and fixed some minor bugs
Added the below boss mods
-Maexxna
-Loatheb

0.5 - September 10th, 2006
Added Void Zone timer to Four Horsemen mod as well included a reduced version for those who don't want the mark countdown on their marks.
Added the below boss mod
-Grand Widow Faerlina
Added an additional mod called Friendly Neighbor which works similarly to Tank Finder except for all classes and shows 5 players within 30 yds sorted by percent health (should assist with healing on Thane)

0.4 - September 9th, 2006
Fixed Heigan Timing
Fixed issue with regen activated based mods not starting
Fixed issue with grobbulus slime spray detection
Added the below boss mods
-Four Horsemen
Added an additional mod called Tank Finder which finds the 3 tanks within 30 yds of the player that are lowest on health. Intended for Four Horsemen to aid finding the tanking warrior.

0.3 - September 4th, 2006
Adds the below mods and fixes minor issue with scalebar not being set on load. Also fixes some minor timing with Gothik
-Anub'Rekhan
-Grobbulus

0.2b - September 3rd, 2006
Fixes an issue with mods not being displayed

0.2 - September 2nd, 2006
First Guild Release
-Gluth
-Gothik
-Heigan