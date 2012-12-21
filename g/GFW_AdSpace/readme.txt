------------------------------------------------------
Fizzwidget AdSpace
by Gazmik Fizzwidget
http://www.fizzwidget.com/adspace
gazmik@fizzwidget.com
------------------------------------------------------

My colleagues in the Vendors' Union of Azeroth are appalled! Many adventurers these days are buying tradeskill recipes on the Auction House at insanely high prices... when they could be getting a much better deal from us! Someone's been buying our wares and marking them up for 100%, 200%, even 400% profit, and you silly adventurers are falling for it. 

Lucky for you, Gazmik Fizzwidget is here to set you straight. This device provides a friendly reminder whenever you consider buying a recipe, pointing out which vendors it can be bought from. Never pay outrageous prices for your recipes again!

------------------------------------------------------

INSTALLATION: Put the GFW_AdSpace folder into your World Of Warcraft/Interface/AddOns folder and launch WoW.

FEATURES: Simple enough for even an ogre to use: Whenever you see a recipe (on the Auction House, in loot, or wherever) that's also available from a vendor, the tooltip will provide a list of who sells it and where you can find them.

CHAT COMMANDS:
	/adspace (or /ads) <command>
where <command> can be any of the following:
	help - Print this list.
	[item link] - Show info for an item in the chat window.
	status - Check current settings.
	recipes on | off - Show info for vendor-supplied recipes in tooltips.
	showcost on | off - Also show vendor prices for recipes.
	librams on | off - Show info for librams in tooltips.
	darkmoon on | off - Show info for Darkmoon Faire grey item turn-ins in tooltips.
	zg on | off - Show info for for special raid loot from Zul'Gurub (Zandalar Tribe rewards) in tooltips.
	aq20 on | off - Show info for for special raid loot from Ruins of Ahn'Qiraj (Cenarion Circle rewards) in tooltips.
	aq40 on | off - Show info for for special raid loot from Ahn'Qiraj (Brood of Nozdormu rewards) in tooltips.
	post on | off - Post to raid/party chat when getting raid loot info via /ads [item link].

CAVEATS, KNOWN BUGS, ETC.: 
	- Many vendors that sell "interesting" recipes have a limited supply of such (which replenishes on a timer of a few hours or more). If a vendor listed by AdSpace doesn't have the item you're looking for, it may just have already been bought by another player. You'll have to stick around or check back again to be sure.
	- AdSpace lists vendors of your faction (Alliance/Horde) and neutral vendors only. Some recipes are only sold to one side, though they can be resold through the neutral Auction House.

------------------------------------------------------
VERSION HISTORY

v. 11200.2 - 2006/10/07
- Added an option to mark tooltips for items which can be turned in to the Argent Dawn for [Seal of the Dawn][Seal of the Crusade].
- Tooltips for ZG Coins now show which three types of coins can be turned in together for Zandalar faction/tokens (if display of ZG items is turned on).

v. 11200.1 - 2006/08/22
- Updated TOC to reflect compatibility with WoW patch 1.12. (No actual changes.)

v. 11100.1 - 2006/06/20
- Updated TOC to reflect compatibility with WoW patch 1.11.
- Added Cenarion Circle and some Argent Dawn recipes introduced in patch 1.11.
- Zul'Gurub item info reflects changes from patch 1.11:
 	- Coins and Bijous are no longer needed for armor quests.
	- Primal Hakkari tokens are used only for armor quests (they're no longer needed for head/leg enchants).
	- A new item, [Primal Hakkari Idol], is used for the class-specific head/leg enchants.
- Added info for [Punctured Voodoo Doll]s and their use in ZG enchants.
- Corrected quantities in output for `/ads [Presence of Might]` and other ZG enchants.
- Fixed error related to [Recipe: Transmute Elemental Fire].

v. 11000.1 - 2006/04/17
- Items used in the Zul'Gurub and Ahn'Qiraj faction/token quests for class-specific gear (e.g. [Zulian Coin], [Primal Hakkari Bindings], [Idol of Rebirth], [Qiraji Ornate Hilt]) now show which classes can use them, which rewards they're used for, and what reputation level is needed for those rewards.
- Typing `/ads [item link]` shows more detailed info for ZG/AQ tokens and their rewards. Insert a link for a token (e.g. [Bone Scarab]) and you'll get the same information as is shown in that token's tooltip, plus item links for the rewards (if they're available in your WoW client's cache); insert a link for a reward (e.g. [Zandalar Predator's Belt]) and you'll get the list of tokens and the reputation level needed to obtain it.
- When you request info for raid items via `/ads [item link]`, AdSpace can automatically post the results to raid chat if you're in a raid (or to party chat if in a party).
- You can now choose individually which types of items you want AdSpace to show information for. (e.g. show info for vendor recipes and librams, but not Darkmoon Faire turnins; show raid token info for ZG and AQ20 but not AQ40.)
- AdSpace settings can new be edited via a new Options panel. Type `/ads` (with no arguments) to show it. (Options can still be controlled via chat commands, but they've changed a bit: type `/ads help` for details.)
- Fixed some issues with the tooltip code shared across Fizzwidget addons; AdSpace's additions to item tooltips should now be showing up in just about every place you can get an item tooltip.
- Added new vendor-sold recipes introduced in WoW patch 1.10.
- Updated TOC to reflect compatibility with WoW patch 1.10. (No actual changes were needed.)
- Minor improvements to utility code shared across Fizzwidget addons.

v. 10900.4 - 2006/01/27
- Includes an update to tooltip-related code shared with other Fizzwidget addons, which should resolve an issue where having two or more addons with conflicting versions of said code could cause a "stack overflow" error.

v. 10900.3 - 2006/01/11
- Added a few more new recipes from the 1.9 patch and their vendor info.

v. 10900.2 - 2006/01/04
- Now lists (all?) ten new vendor-supplied tradeskill recipes from WoW patch 1.9 (enchanter oils, two new cloak enchants, and [Pattern: Soul Pouch]), with verified prices and vendor listings for each.

v. 10900.1 - 2006/01/03
- Updated for WoW patch 1.9; includes vendor info for several of the new recipes introduced in this patch. (More complete vendor info for new items will be available in an update shortly following the release of the patch.)
- Error messages reporting discrepancies in the internal database will appear no more often than once per minute. (Previously, if such errors came up in tooltip handling, they could end up being repeatedly spammed to the chat window.)
- Includes refinements to code shared with other GFW mods.
- Knows its own version number -- it's present in startup and error messages and if you type `/ads help` or `/ads version`. Please include this version number when sending bug reports or help requests!

See http://fizzwidget.com/notes/adspace/ for older release notes.