------------------------------------------------------
Fizzwidget Linkerator
by Gazmik Fizzwidget
http://fizzwidget.com/linkerator/
gazmik@fizzwidget.com
------------------------------------------------------

Have you ever wanted to tell your friends about some impressive loot you saw another adventurer using? Share your regret about the quest reward you foolishly didn't choose? Spread word to your guild of what your raiding party found? Now you can do so easily with my latest gizmo! Not only does it help you keep track of all the items you encounter, Linkerator makes it super-easy to tell your friends about them in full detail! 
 
------------------------------------------------------

INSTALLATION: Put this folder into your World Of Warcraft/Interface/AddOns folder and launch WoW.

USAGE: 
	- Automatically remembers item links you come across (some of which you might not even see!)... in chat channels, in your inventory and bank, on other players, in loot messages, etc. (Unlike some addons which do this, Linkerator only keeps the name and item ID, so its database stays small.)
	- Allows you to insert an item link in chat by merely typing its name in brackets. (i.e., type `/g [swift razzashi raptor]` to send a message to your guild with a clickable link for the mount they likely won't see often.) 
	- Since there are some cases of different items which have the same name, you can type the name followed by something distinctive about the item in parentheses (e.g. `[punctured voodoo doll (druid)]` or `[warblade of the hakkari (main)]`) if you're looking for a specific match -- you can use any item attribute that shows up in that item's tooltip. (This only works if the variant you're looking for is in your WoW client's cache, however.) Alternately, if you know the item ID of a specific item, you can type it in brackets (preceded by a poind sign) to link it (e.g. `[#18473]` to get the Hunter variant of [Royal Seal of Eldre'thalas]).
	- You can also retrieve stored links via various `/link` chat commands.
	
CHAT COMMANDS:
	/linkerator (or /link) <command>
where <command> can be any of the following:
	help - Print this list.
	list - List all links known. (Currently kinda useless, as you'll quickly accumulate more links than the chat window can display at once.)
	count - Show how many links are stored in Linkerator's database.
	<number> - Print a link in the chat window for an item given its ID number.
	<link code> - Print a link in the chat window for an item given a complete link code (e.g. "item:789:241:2029:0" for a [Stout Battlehammer of Healing] with a +2 damage enchant).
	<name> - Print a link in the chat window for an item given its name or part of its name. (Will show more than one match if available.)
	
CAVEATS, ETC.: 
	- Retrieving item links by name uses the database Linkerator builds itself (by scanning your inventory, monitoring chat channels, inspecting other players in the background when you target them, etc.)... if Linkerator hasn't seen an item yet, it can't produce a link for it just based on the name.
	- WoW only allows hyperlinks for items that the server has seen since its last reset. You can link items not in Linkerator's database if you know their ID numbers, but only if they're known to the server. (So, unless you have your very own [Thunderfury, Blessed Blade of the Windseeker], don't be surprised if you can't produce a link to it on a Tuesday morning.)
	
------------------------------------------------------
VERSION HISTORY

v. 11000.2 - 2006/04/11
- `/link` partial-name searches are now properly case-insensitive (this was always supposed to be the case -- no pun intended -- but some mistakenly placed code had it requiring all-lowercase instead).
- We now make sure to only scan inventory once when logging in or zoning. (Previously it was possible for us to end up scanning your inventory repeatedly in such cases; this may have had a noticeable effect on loading time.)
- Using new Blizzard API for standard link color codes. (This should have no visible effect, other than perhaps to make sure we don't get disconnected for bad color codes if Blizzard changes them in the future.)
- Minor improvements to utility code shared across Fizzwidget addons.

v. 11000.1 - 2006/03/28
- Updated for compatibility with WoW patch 1.10. (Minor changes were needed.)
- Minor improvements to utility code shared across Fizzwidget addons.

v. 10900.2 - 2006/02/04
- Fixed a problem where all orange (legendary) links were causing disconnects if sent to chat. (Had the wrong color code, oops!)
- The /script (and /dump, if you're using Vigilance Committee's DevTools) commands are exempt from automatic "linkifying" of item names or numbers typed in brackets. (You can still insert a hyperlink into such commands by shift-clicking.)
- Automatic "linkifying" based on item IDs now requires they be prefaced by a pound sign (e.g. `[#16955]`), due to a conflict with addons that put quest levels in brackets when inserting quest names to chat. (Kinda confuses people when you say things like "LFG [Apprentice's Robe] It's Dangerous to Go Alone".)
- Now supports bulk import from LootLink for those looking to switch. Log in once with both addons enabled, type `/link import`, and in a few moments Linkerator will know about all the items LootLink does, and you can uninstall LootLink if you so desire. (This may lock up the game UI for a couple minutes if your LootLink database is large.)

v. 10900.1 - 2006/01/27
- Initial release.
