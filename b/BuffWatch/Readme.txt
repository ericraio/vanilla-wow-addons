Buffwatch++
-----------

BuffWatch is a powerful buff manager that lets you easily and clearly keep
track of active and inactive buffs, as well as allowing you to rebuff players
with a single click.

Simply setup the buffs you want to monitor for each player in your party/raid,
and buffwatch will notify you if the buff expires. You can then click the
highlighted buff to automatically recast the buff on that player, if you have
the ability to do so.

This allows you focus more on important tasks such as decursing, healing or
fighting, while still allowing you to rebuff mid fight if needed.

Buffwatch can also be useful for raid leaders to check important buffs are on
certain players before continuing, eg. Blessing of Salvation on your healers.

Please type /buffwatch or /bw in-game for usage details

To download the latest version or to report any bugs or requested changes go
here : http://www.curse-gaming.com/mod.php?addid=2003

-------------------------------------------------------------------------------

Buffwatch++ is based on the mod of the same name by Tyrrael, which had stopped
being updated since WoW 1.4

Original version here : http://www.curse-gaming.com/mod.php?addid=678

-------------------------------------------------------------------------------

General Usage
-------------

Setting up :

  * Cast the buffs you want monitor
  * Lock the buffs for the players by checking the box to the left of their
      name
  * Remove buffs you dont want to monitor by [Ctrl + Right Click]ing them.
      (If you only have one buff to monitor on a player, use
        [Alt + Right Click] on that buff icon to remove all others)

Once setup :

  * Buffs will highlight in red if they expire. Left clicking will recast.
  * If a player is dead or goes offline, their buffs will grey out.
  * To target a player, left click their name. To assist, right click.
  * To hide players for which you are not monitoring any buffs, toggle the
      'Showing Unmonitored' icon in the BuffWatch window.
  * To hide players for which you do have monitored buffs, but having none
      expired, toggle the 'Showing Monitored' icon in the BuffWatch window.
      Player will re-appear when one of their buffs expires.
  * Buffwatch will automatically cast the group version of a buff if you set
      the Buff Threshold setting in options to a value between 1 and 5.
      Buffwatch will check how many players are missing the buff (regardless
      of whether you are monitoring for it), and cast the group version if the
      Threshold setting is less than or equal to this value. (This does not
      work however for the Druid's Gift of the Wild, and Mark of the Wild will
      always be cast)
  * If you have run out of reagents for a group buff, have not yet learnt the
      spell(s), or never want BuffWatch to cast them, set the Threshold
      setting to 0.
  * If you find buffwatch starts to reduce your fps in some boss fights 
      (eg. Lucifron when he debuffs whole raid), then play with the 'Max 
      Updates Per Second' setting to improve performance. Setting Max UPS to 
      to a low value may cause short delays in buffs being updated.

For help and information on other features, type '/bw' or '/buffwatch' in game.

-------------------------------------------------------------------------------

Known Issues
------------

  * When buffwatch checks to see if a group buff is in your spellbook (eg 
      Arcane Brilliance or Greater Blessing of Wisdom), it stores the spell id 
      to save searching for it on subsequent usage. If you learn new spells 
      (including new ranks) the spell id's can change, and buffwatch might 
      start to cast the wrong spell instead of the group buff. If this happens, 
      you will need to reload your UI or log out and back in again.
      
  * When 'Show Only Castable Buffs' is selected, Buffwatch doesn't show 
      selfcast only buffs. (eg. Ice Armour. Paladin Auras). This is due to
      what the WoW API considers a castable buff. To setup monitoring of these
      types of buff (as with any buff that you cannot cast), you must deselect
      this option before locking the relevant players.

-------------------------------------------------------------------------------

Version History
---------------

1.15
----

Added option to restrict buff updates
Fixed a couple of bugs as a result of 1.11

1.14
----

Added Priest Shadow and Spirit Group Buffs
Option to always show players with debuffs
Added optional sound on expired buff

1.13
----

Shows class colours properly for non EN localisations
Added option to highlight players that are PvP Flagged
Added option to prevent BuffWatch from casting on players that are PvP Flagged
Added option to show only buffs player can cast
Added option to show only debuffs player can dispell

1.12
----

Ignores pets for GroupBuff Threshold count
Added current Threshold value to slider label
Added casting of druids group buff GotW based on Threshold

1.11
----

Switches buff icon between lesser and greater type buffs
Added Buff Threshold option to determine version to cast for 
  Group buffs and their lesser versions (except Druid GOTW)
Added tooltips to options panel

1.10
----

Reset debuffs back to 8
Option to hide players with no locked buffs
Option to hide players with locked buffs until they expire
Header text is now highlighted if a buff expires while minimised
Updated Interface number to 10900

1.01
----

Fixed problem where locked buffs were lost if pet died or was dismissed briefly

1.00
----

Largely recoded to allow new features and a bug fix
Maintains locked buff settings when raid/party is adjusted
Option button and CheckAll box now properly dissapear when minimised
Allows sorting of player list by Raid Order, Class or Name

0.622
-----

Darkens buff icon if player is dead or offline
Minimize button to hide players (Warning message will still display)
Updated Interface number to 1800

0.621
-----

Alt-RightClick to remove all buffs other than this one
Optional warning message for when a monitored buff expires
Added support for 16 debuffs
Updated Interface number to 1700


0.620
-----

Added BuffWatch Options Toggle to keybindings
Options toggle button added next to buffwatch label
Option to left align buffs
Removed event PLAYER_REGEN_ENABLED
Can now click anywhere on player name to select them (used to be first 18
  pixels)
Fixed window resize error when first loaded
Some other minor fixes/code optimisation


0.610
-----

Group checkbox for all
Fixed playerframes left behind if you drop from raid down to party
Toggle button added to options panel
Help page will show even when BuffWatch is hidden
Changed hiding and showing of pets to a toggle
Option to hide debuffs


0.600
-----

Now shows debuffs when player is locked
Ability to hide or show pets
Raid & pet support with new unit id's
Class coloured names
Options GUI with myAddons, CTMod & Cosmos support
Various minor fixes & changes, particulary relating to pets and buff
  targetting.
