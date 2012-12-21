------------------------------------------------------
Fizzwidget Disenchant Predictor
by Gazmik Fizzwidget
http://fizzwidget.com/disenchantpredictor
gazmik@fizzwidget.com
------------------------------------------------------

Enchanters: have you ever tried to accumulate reagents for your latest formula and come away feeling... well, disenchanted? Got Strange Dust when you really wanted Soul? Is that Brilliant Shard just not large enough to satisfy? Suffer no more! Through countless hours of research, I've discovered the scientific laws governing the mystic composition of enchanted items. I just *had* to build a gadget to make use of this knowledge.

My latest invention will help you make sure you always disenchant the right stuff to get the shards, dusts, or essences you need.  Simply point it at any such reagent -- or even the reagent requirements listed in your formula book -- and you'll see an instant readout showing what types of items it can be disenchanted from. No more guesswork!*

* Due to fluctuations in the astral plane, disenchanting an item of merely "uncommon" quality will still produce variable results. No one can predict for certain whether you'll get a pile of dust, an essence, or a shard, but thanks to my invention you'll at least know what variety of dust, kind and potency of essence, or luster and size of shard can be produced. 

------------------------------------------------------

INSTALLATION: Put the GFW_DisenchantPredictor and EnhTooltip folders into your World Of Warcraft/Interface/AddOns folder and launch WoW.

USAGE: 
	- By default, reagents produced by disenchanting items (a dust, essence, or shard) will show two new lines of information in their tooltips: the first shows which levels of items can be disenchanted to produce the reagent, and the second provides additional info on which types of items are more or less likely to produce the reagent.
	- Disenchantable items will also show information in their tooltip predicting which types of dust, essence, or shard they can disenchant into.
	- Also, you can use a chat command to check which types of dust, essence, and shard can be disenchanted from an item by inserting a chat link or typing its level requirement (see below). 

CHAT COMMANDS:
	/enchant (or /ench or /disenchant or /dis or /de or /dp) <command>
where <command> can be any of the following:
	help - Print this list.
	status - Check current settings.
	items on | off - add info to tooltips for disenchantable items (e.g. green weapons) showing what they can disenchant into.
	reagents on | off - add info to tooltips for enchanting reagents (e.g. Strange Dust) showing what they can disenchant from.
	verbose on | off - add a second line in the tooltip showing detailed disenchant info.
	tooltip on | off - enable/disable or disable this addon's tooltip modification entirely.
	<number> - Show disenchant info for level <number> in the chat window.

CAVEATS, KNOWN BUGS, ETC.: 
	- Disenchant Predictor bases its predictions on common "rules" for item disenchants as observed by the player community... but not all items that fit these "rules" are disenchantable. (Notable exceptions include PvP or Battleground faction rewards which can be purchased from vendors and the Twilight Trappings set.) Disenchant Predictor keeps a database of several known exceptions, but it may not always be complete -- the presence of disenchant info in an item's tooltip shouldn't be taken as a reliable indicator of whether an item can be disenchanted.
	- Not all disenchantable items have a level requirement -- quest rewards notably don't. It seems WoW's formula for determining disenchant results uses the level at which the quest first becomes available. For example, [Masons Fraternity Ring] disenchants into a Large Radiant Shard (which usually comes from level 41-45 items), even though "Divino-matic Rod" is listed as a level 47 quest. (Unfortunately, this information can't be readily indexed by an addon.)
	- Some items have a skill requirement instead of a level requirement (e.g. many items produced by Engineering), but can still be disenchanted. Unfortunately, no direct relationship between skill requirement and disenchant results has yet been verified.

------------------------------------------------------
VERSION HISTORY

v. 11200.1 - 2006/08/22
- Updated TOC to reflect compatibility with WoW patch 1.12. (No actual changes.)

v. 11100.1 - 2006/06/20
- Updated TOC to reflect compatibility with WoW patch 1.11.
- Fixed a case where items without a level requirement would show predicted disenchants for a level 1-10 item in their tooltips.
- Added Korean localization by "Halfcreep".

v. 11000.2 - 2006/04/17
- Slightly changed formatting of tooltip info for Uncommon and Epic items; it should be less likely to result in an extremely wide tooltip now.
- Fixed some issues with the tooltip code shared across Fizzwidget addons; Disenchant Predictor's additions to item tooltips should now be showing up in just about every place you can get an item tooltip.
- Minor improvements to utility code shared across Fizzwidget addons.

v. 11000.1 - 2006/03/28
- Updated for compatibility with WoW patch 1.10. (Minor changes were needed.)
- Minor improvements to utility code shared across Fizzwidget addons.
- KNOWN BUG: The tooltip additions aren't showing up in all cases where they should. Another update to address this issue should be coming along soon.

v. 10900.3 - 2006/01/27
- Improved the mechanism we use to detect likely-disenchantable items... should be more efficient and reliable now. (Not that there were any known bugs with it before, but having a well oiled machine is good, y'know?)
- We now keep a list of known exceptions to the common rules for which items are disenchantable. (Generally, anything that's equippable, not stackable and not a container can be disenchanted if it's of Uncommon/green or better quality. However, some specific items that fit these critera aren't disenchantable, presumably because they're easy to get in quantity.) Thus far it contains the Twilight Trappings cloth pieces and all PvP/Battleground reward armor and weapons. If you come across any other items which DP shows predictions for that turn out to not be disenchantable (but still fit the aforementioned criteria), let me know!
- The `verbose` option now also controls the presentation of possible disenchant results in item tooltips: when off, all shards/essences/etc will be listed on one line, resulting in a vertically shorter (though often wider) tooltip.
- Changed wording of tooltips and chat-window output a bit. (Localizers take note!)
- Includes an update to tooltip-related code shared with other Fizzwidget addons, which should resolve an issue where having two or more addons with conflicting versions of said code could cause a "stack overflow" error.

See http://fizzwidget.com/notes/disenchantpredictor/ for older release notes.