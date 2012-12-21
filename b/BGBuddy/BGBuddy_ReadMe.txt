-=-=-=-=-=-=-=-=-=-=-=-=-=-
=                         =
= BGBuddy v1.5            = by Conflictus (Illidan Alliance)
=                         = 
-=-=-=-=-=-=-=-=-=-=-=-=-=-

BGBuddy is a simple addon which tracks your progress in 
the battlegrounds and provides helpful features such as
Auto-Join, Auto-Resurrect and Auto-Release.

If you have any suggestions, comments, questions or 
problems, please feel free to post them at any of the
following websites. Your input is always very appreciated!

http://ui.worldofwar.net/ui.php?id=941
http://www.curse-gaming.com/mod.php?addid=1506
http://wowinterface.com/downloads/fileinfo.php?id=4023


------------------------------------------------------------
- INSTALLATION
------------------------------------------------------------
1) Copy the "BGBuddy" folder and it's contents to your 
   "Interface/Addons" folder.

2) Run World of Warcraft.

3) Enter a queue for Battlegrounds to display BGBuddy.


------------------------------------------------------------
- COMING SOON
------------------------------------------------------------
-> Localization
-> Option to save Session Honor throughout a number of 
   sessions with the ability to "Reset Honor" when desired.
-> Options for CTF to show/target Flag Carriers and to show
   the score.
-> TitalPanel support
-> InfoBar support
-> Any other mentionable suggestions you might have :)


------------------------------------------------------------
- HISTORY
------------------------------------------------------------
+ Version 1.5					06/28/2005
  -> Fixed bug with French and German clients that was
     causing a nil error when entering a battleground
     (serious this time!) :)
  -> Added the feature of automatically coming out of AFK
     before joining a battleground
  -> Fixed bug with Auto-Resurrect hiding the "Release"
     button if you had Auto-Release disabled while Auto-Res
     was enabled
  -> Fixed bug with the auto-resizing function that caused
     the score button (+) to ocassionally overlap the 
     contents beneath it

+ Version 1.45					06/28/2005
  -> Fixed bug with French and German clients that made
     honor point calculations incorrect

+ Version 1.4					06/28/2005
  -> Fixed bug with French and German clients that caused
     nil value errors when entering a battleground
  -> Honor point calculations now factor in diminishing 
     returns. The Session Honor and Last Kill fields now 
     display in the following format:
     (diminished honor / full honor)
  -> Added the option to hide the BGBuddy display

+ Version 1.35					06/23/2005
  -> Fixed bug that caused BGBuddy to use Alterac Valley's
     customized display settings when you were inside of 
     Warsong Gulch -_-

+ Version 1.3					06/23/2005
  -> Added the ability to customize the display for Alterac 
     Valley and Warsong Gulch seperately
  -> Added the option to show/hide your current honor rank
     name and icon
  -> Fixed bug that wasn't displaying current rankname and
     rankicon correctly for non-english clients
  -> Fixed bug with nil values that occurred in Warsong 
     Gulch

+ Version 1.2					06/22/2005
  -> Added several more displayable statistics such as
     Lifetime Kills, Graveyards Assaulted/Defended,
     Towers Assaulted/Defended, Mines Captured, Leaders
     Killed, Secondary Objectives and Bonus Honor
  -> Added the ability to select which items you want 
     BGBuddy to display while inside the Battleground
  -> BGBuddy now auto-resizes to fit it's content
  -> Removed "BGBuddy is enabled..." message upon loading
  -> Fixed bug that labeled the 1st rank as "Unranked"
  -> Fixed bug that wasn't setting saved transparency 
     settings upon loading

+ Version 1.1					06/21/2005
  -> Added option to adjust Border Transparency
  -> Removed "Change Instance" and "Leave Queue" buttons and 
     replaced with an icon to toggle a dropdown menu

+ Version 1.05					06/21/2005
  -> Added myAddons support
  -> Integrated the standard BG Minimap Icon features and
     popup windows into BGBuddy
  -> Integrated Auto-Join, Auto-Res and Auto-Release 
     enabling/disabling into the options menu
  -> Rearranged the options on the Graphical Options Menu
  -> Fixed bug that would hide the countdown popup windows 
     if you tried to exit or logout while the Auto-Join
     feature was enabled

+ Version 1.0					06/20/2005
  -> Added functionality to remember settings
  -> Added a Graphical Options Menu 
     + Added Enable BGBuddy checkbox
     + Added Lock BGBuddy checkbox
     + Added Always Show BGBuddy checkbox
     + Added Play Sound When Ready checkbox
     + Added Background Transparency slider
  -> Added command '/bgbuddy' to toggle options menu
  -> Added several helpful ToolTips
  -> Fixed bug that wasn't calculating the total players
     within the battlefield correctly.

+ Version 1.0 BETA 2				06/18/2005
  -> Fixed bug that removed "Release" button if you died
     outside of the instance.

+ Version 1.0 BETA 1				06/18/2005
  -> Added Statistics Tracking for Standings, Kills,
     Killing Blows, Deaths, Session Honor and Last Kill.
  -> Added Auto-Join feature
  -> Added Auto-Resurrect feature
  -> Added Auto-Release feature


