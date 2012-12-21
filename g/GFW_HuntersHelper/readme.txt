------------------------------------------------------
Fizzwidget Hunter's Helper
by Gazmik Fizzwidget
http://fizzwidget.com/huntershelper
gazmik@fizzwidget.com
------------------------------------------------------

Really, I'm not one to gallivant about the wilderness trying to make friends with beasts... at my size, it's a good way to get eaten! Besides, keeping a full stock of bits & bibbles for your critter can be terrible for your cash flow. But a Hunter friend of mine managed to convince me there'd be good money in outfitting such outdoorsy types, and before I knew it my workbench was cluttered with all sorts of animal-seeking, food-measuring, and pet-minding contraptions.

This gadget couldn't be any simpler to use: point it at a beast you see in the wild, and its zootropic neurowave scanner will analyze the critter's noggin and tell you what, if any, new tricks it can teach you.* Know what you're looking for, but not sure where to look? It'll help with that, too -- I've pre-programmed it with an extensive database on creature behavior (straight from the Encyclopedia Azerothica), easily indexed by skill.

* Not recommended for use by elderly gnolls.

------------------------------------------------------

INSTALLATION: Put this folder into your World Of Warcraft/Interface/AddOns folder and launch WoW.

USAGE: 
	- When you mouse over a beast in the world, the tooltip will show which abilities a Hunter could learn after taming it. (Or no additional info if the beast doesn't have any known abilities.)
	- If you're currently playing a hunter, the abilities will be colored according to whether you've already learned them: green for abilities you have yet to learn, and gray for those you already know. Hunter's Helper will notice when you learn new abilities and will automatically refresh its index whenever you open the Beast Training window. (If you already know a few abilities, you should open you Beast Training window the first time you play after installing Hunter's Helper.)
	- Need to know where to find new abilities for your pet? Type (for example) '/huntershelper find Bite 6' to get a list of beasts known to have that ability. Results are sorted by zone, with those areas closest to (or most accessible from) your current location first. (The list cuts off after four zones if you look for an ability found on a wide variety of beast types; typing `findall` instead of `find` will list everything applicable.)
	- Hunter's Helper also notifies you in chat if you tame a beast whose skillset isn't what was expected. Please contact me so I can update Hunter's Helper with corrected information! 

CHAT COMMANDS:
	/huntershelper (or /hh) <command>
where <command> can be any of the following:
	help - Print this list.
	status - Check current settings.
	on|off|onlyhunter - enable/disable display of pet abilities in beast tooltips. (Or enable only for Hunter characters.)
	find <ability> <rank> - Lists in the chat window which beasts have an ability and where they can be found. 

------------------------------------------------------
VERSION HISTORY

v. 11200.1 - 2006/08/22
- Updated TOC to reflect compatibility with WoW patch 1.12. (No actual changes.)

v. 11100.1 - 2006/06/20
- Updated for compatibility with WoW patch 1.11.
- Changed names of global variables used for localization to be less likely to conflict with other third-party AddOns or future WoW patches.
- Added several previously unknown beasts to the database (Deadly Cleft Scorpid, Old Grizzlegut, Ripscale, Vile Sting) and corrected listings for a few existing ones (Ashmane Boar, Ironback).

v. 11000.2 - 2006/04/11
- Added Simplified Chinese localization from Zhang Yi.
- Fixed a bug that could cause an error panel to pop up if using `/hh find` after making use of the new feature in WoW patch 1.10 that allows moving factions to an "Inactive" group in the Reputation UI.
- Added listing for Death Howl, a rare wolf in Felwood.
- Minor improvements to utility code shared across Fizzwidget addons.

v. 11000.1 - 2006/04/01
- Added listings for new beast ability introduced in the WoW 1.10 patch: Charge (Rank 6), found on Plagued Swine in the Eastern Plaguelands.
- Updated TOC to reflect compatibility with WoW patch 1.10. (No actual changes were needed.)
- Minor improvements to utility code shared across Fizzwidget addons.

v. 10900.3 - 2006/01/27
- Updated beast ability listings: 
	- Scorpashi Lasher in Desolace has Scorpid Poison (Rank 2) and Claw (Rank 5).
	- Kresh in Wailing Caverns has Bite (Rank 3) and Shell Shield (Rank 1).
- The required levels for each rank of Prowl are now reported correctly (levels 30, 40, and 50).

v. 10900.2 - 2006/01/18
- Localized the beast names in our database to French and German using data from WoWGuru.com -- tooltips should show HH-provided info for beasts you haven't tamed (or inspected with Beast Lore) before now if you're using WoW in one of those languages, and `/hh find` results will show localized names.
- Fixed a couple errors some users were experiencing. 
- Ashmane boar has Charge (Rank 5), not rank 4 (which has not been found on any known beast).
- Updated/corrected some existing beast ability listings.

v. 10900.1 - 2006/01/03
- Updated for WoW patch 1.9: Includes information on where to find the three new pet skills (Charge for boars, Shell Shield for turtles, and Thunderstomp for gorillas).
- Includes several fixes and additions to the database for existing skills and mobs, too.
- Updated French and German partial localizations.
- Knows its own version number -- it's present in startup messages and if you type `/hh help` or `/hh version`. Please include this version number when sending bug reports or help requests!

See http://www.fizzwidget.com/notes/huntershelper for older release notes.
