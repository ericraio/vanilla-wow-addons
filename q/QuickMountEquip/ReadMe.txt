QuickMountEquip - by Merrem @ Perenolde - robj@suvangi.com

VERSION
 2.20 - 2006/03/28

	patch 1.10 compatible

 2.19 - 2005/08/22

	Added Earth (Khaos) configuration option. Thanks to Marsman for the heads-up.

 2.18 - 2005/07/18

	.toc changed to 1600
	Added an option to auto-reconfigure, for those that like to manually switch trinkets.
 		Unfortunately, right-click to equip won't auto-reconfigure. You have to drag
		and drop to re-equip.
	Hopefully improved the equip functionality for same-name items.
	Added German "Aspekt" check.


 2.17 -

	Cleaned up 'detect' option a little.
	Changed which functions are Hooked. This should fix incompatibilities with AddOns like AdvancedBags and AIOI.

 2.16 - 2005/03/30

	.toc changed to 1300
	Added optional Fetch support.
	Added profile saving and loading. (For people that have multiple equipment sets.)
	Added fix for items named the same switching when you first login.
	Made flightpoint (Griffin) checking configurable. Off by default now.
	Expanded GUI to include options like Quiet and FlightPoint check.
	Added initial support for a 'detect' option. If the AddOn isn't properly detecting
		when you mount, you can try to manually detect the mount and then use that
		setting. **Advanced**

 2.14 - 2005/03/05

	Fixed myAddOns support a little.

 2.13 - 2005/03/05

	Added support for the myAddOns AddOn.

 2.12 - 2005/02/26

	Added optional check for Sea.util.hook for the new Cosmos Alpha.
	Changed .zip to include full Interface\AddOns\QuickMountEquip path.
	Added Interface\AddOns\QuickMountEquip.nopatch for Cosmos users.

 2.11 - 2005/02/22

	Changed .toc to 4216

 2.10 - 2005/02/16

	Changed .toc version number to match latest US servers. (4211)
	Switched from RegisterForSave to SavedVariables in .toc
	Made the flight point check a little more efficient.
           Still requires an attack button somewhere in the first 72 hotkeys, but will only
           search once. If none is found, the Wind Rider/Griffin check is disabled. Reportedly
           spurs/carrot/etc don't work on them, but I like switching anyway, so I'm leaving the
           check in.

 2.09 - 2005/02/12

	Made it so that it's impossible to destroy items when the configuration frame is open.

 2.08 - 2005/01/31

	Fixed typo in ReadMe.txt
	Added check for Tiger's Fury
	Added check for Polymorph
	Added fix for Flexbar conflict

 2.07 - 2005/01/28

	Added check for Kodo Mounts.

 2.06 - 2005/01/28

	Fixed error that occured on characters other than the first.

 2.05 - 2005/01/27

	Added new Paladin/Warlock Mount check.
	Added a check for Hunter "Aspect of the Pack" buff that was triggering the swap.
	Mounting should no longer interfere with the main tooltip.
	Equipping multiple trinkets should work now. Items of similar types must "line up" in the config GUI now, however.

 2.04 - 2005/01/26

	Fixed typo in config loading.

 2.03 - 2005/01/26

	Added the ability to turn off and on the AddOn using "/mountequip on" or "/mountequip off"
	Added the ability to turn on/off equip messages.
	Configuration is now saved on a Realm/Player basis.
	   (So if you have multiple players each will have their own config.)
	Misc. Cleanup / Error checking on initial loading...
	Shortened the messages that show-up when multiple items are equipped at once.
 
 2.02 - 2005/01/25

	Removed the need for Cosmos.

 2.00 - 2005/01/24

	Initial public release. Required Cosmos.


FEATURES

	Whenever you Mount or Dismount it will automatically switch to the gear you specify. 

	Full GUI to configure which gear to switch to. /mountequip to show GUI. 

	Optionally will automatically detects Griffins and switches then also. (Off by default) 

	If you get automatically dismounted due to water, or running into buildings, etc... it will switch gear correctly. 

	If you get dismounted while aggroed by a foe, WoW won't let you switch equipment. But as soon as combat or aggro is clear, it will automatically switch gear correctly.


USAGE

/mountequip - This is the main interface to the configuration options.

	There are several options available: on, off, quiet, verbose, flightpoint, config, status, load, save, delete, profiles, detect

/mountequip config - This will open up the GUI interface to select which items you want equipped when you mount/dismount.

/mountequip on - Turns on the auto-equip functionality (default)

/mountequip off - Turns off the auto-equip functionality

/mountequip verbose - Informs you when it auto-equips items. (default)

/mountequip quiet - Doesn't inform you when it auto-equips items.

/mountequip flightpoint on - Turns on flightpoint (Griffin) checking

/mountequip flightpoint off - Turns off flightpoint (Griffin) checking (default)

/mountequip status - Shows you the status of the settings, and a usage statement.

/mountequip save "ProfileName" - Saves the profile named "ProfileName"

/mountequip load "ProfileName" - Loads the profile named "ProfileName"

/mountequip profiles - lists all saved profiles

/mountequip delete "ProfileName" - Deletes the profile named "ProfileName"

/mountequip detect now|on|off|clear - Attempts to detect the name of your mount. Should only be used if the AddOn doesn't work at all when you mount-up normally.
