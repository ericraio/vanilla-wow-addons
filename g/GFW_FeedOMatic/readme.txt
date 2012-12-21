------------------------------------------------------
Fizzwidget Feed-O-Matic
by Gazmik Fizzwidget
http://fizzwidget.com
gazmik@fizzwidget.com
------------------------------------------------------

As my Hunter friends can readily attest, keeping a wild pet can be a full-time job. Why, just feeding the critter when he gets hungry can throw off your routine -- you've got to rummage around in your bags, find a piece of food, make sure it's appropriate for his diet, and check your aim before tossing it to him (lest you accidentally destroy a tasty morsel). So inconvenient! Not to mention potentially dangerous... you don't want to spend so long digging through your bags that you or your pet become someone else's snack.

Never fear, Gazmik Fizzwidget is here with a new gadget to automate all your pet-food-management tasks! My incredible Feed-O-Matic features state-of-the-art nutritional analyzers to make sure your pet's hunger is satisfied with a minimum of fuss, advanced selective logic to make your pet doesn't eat anything you have another use for, and a weight optimizer to make sure the food in your bags stays well organized! Just press the "Feed Now" button and it'll intelligently choose a food and accurately toss it to your pet. This is actually one of the first gizmos I started work on... but because I'm a perfectionist I haven't considered it ready for release until now.

------------------------------------------------------

INSTALLATION: Put this folder into your World Of Warcraft/Interface/AddOns folder and launch WoW.

USAGE:
Makes feeding your pet quick, easy, and fun:
	- Bind a key to "Feed Pet", and Feed-O-Matic will automatically choose an appropriate food and give it to the pet whenever you press it. 
	- Can use an emote to notify you when it's feeding your pet, with custom randomized messages. See FeedOMatic_Emotes.lua to customize them to your characters!

Helps you manage all the pet food in your inventory:
	- Keeps track of which foods your pet likes more, and prioritizes "better" foods when choosing what to feed the pet. Also remembers what foods your pet has "outgrown", and doesn't choose them in the future (unless you've switched to a pet who might have different tastes).
	- If you're on a quest to collect several of a certain item which also happens to be something your pet likes to eat, Feed-O-Matic can avoid consuming it. (Unless you're carrying more than is needed for the quest or there's nothing else for your pet to eat.) Type `/feedomatic savequest on` to enable this feature.
	- Feed-O-Matic can keep track of what foods are used by the Cooking recipes you know and avoid choosing food you'd rather cook. To enable this feature, type `/feedomatic saveforcook` followed by the difficulty color you want to save ingredients for. (For example, `/feedomatic saveforcook orange` will cause Feed-O-Matic to avoid choosing food items you're guaranteed to get a skillup from cooking; foods used in lower-level recipes won't be given special attention.)
	- If you'd prefer to save the better food (that is, those which provide a "well fed" bonus or other effect when eaten) for yourself, Feed-O-Matic can also avoid it when looking for pet food.
	- All other things being equal, Feed-O-Matic will try to pick foods from smaller stacks, making sure your food supply doesn't take up all your bag space. When your bags get close to full, Feed-O-Matic will start ignoring other criteria and always choosing the smallest stack so that you won't run out of inventory sooner.

CHAT COMMANDS:
	/feedomatic (or /fom or /feed) <command>
where <command> can be any of the following:
	`help` - Print this helplist.
	`status` - Check current settings.
	`reset` - Reset to default settings.
	`feed` - Feed your pet (automatically finds an appropriate food).
	`feed <item link>` - Feed your pet a specific food.
	`add <diet> <item link>` - Add food to the list for a specific diet (meat, fish, fruit, etc).
	`remove <diet> <item link>` - Remove food from the list.
	`show <diet>` - Show food list for a specific diet (or for `all`).

CAVEATS, ETC.: 
	- Feed-O-Matic has a database of many known foods, but it's not guaranteed to be comprehensive. You can use the `add`, `remove`, and `show` commands noted above to manage these lists directly. (Please drop me a line if you find a food that should be on there, or discover that something on the list shouldn't be there.) 
	- Currently, Feed-O-Matic can only update its list of which foods you know how to cook when your Cooking window is open. (So if you read a new recipe, we won't know to preserve the ingredients until you open your Cooking window again.)
	- Only works in English, French, and German (for now). Localizers interested in helping with other WoW client languages please contact gazmik@fizzwidget.com.

------------------------------------------------------
VERSION HISTORY

v. 11200.1 - 2006/08/22
- Updated TOC to reflect compatibility with WoW patch 1.12.
- Updated use of WoW's UnitSex() function to match changes in its behavior from WoW patch 1.11... your pet's gender should be reported correctly again.

v. 11100.1 - 2006/06/20
- Updated TOC to reflect compatibility with WoW patch 1.11. (No actual changes were needed.)
- Added French localization by "Artaher Medivh".

v. 11000.4 - 2006/04/17
- Fixed some issues with the tooltip code shared across Fizzwidget addons; Feed-O-Matic's addition to item tooltips should now be able to show up in just about every place you can get an item tooltip.

v. 11000.3 - 2006/04/11
- Feed-O-Matic settings can now be edited via a new Options panel. Typing `/fom` alone shows this panel (the various configuration subcommands, e.g. `/fom alert`, etc., are still available), which controls all aspects of Feed-O-Matic's behavior except for its list of known foods (for now, you'll still need to use slash commands to edit that).
- Additional options are available for warning you that your pet needs feeding: besides flashing the default UI's pet happiness icon, Feed-O-Matic can now also alert you via text message or with the sounds of your pet begging for food. (If you don't like these species-specific pet noises, there's also an option to have a simple bell sound as reminder.)
- You can now click the default UI's pet happiness icon to invoke Feed-O-Matic's feeding function. (This makes three ways to feed your pet with Feed-O-Matic: click the icon, set up a key for Feed Pet in the standard Key Bindings menu, or type or macro `/fom feed`.) Right-click the icon to show the new Options panel.
- Fixed a bug where we could bloat the SavedVariables file when attempting to clean it up upon visiting a stable master. (Now we properly discard data from pets no longer in service.)
- Fixed a bug where we'd still keep trying to feed a food to the pet after finding out it's too low level.

v. 11000.2 - 2006/04/01
- Due to changes in WoW patch 1.10, it's no longer possible for UI addons to feed your pet automatically without direct input; the automatic feeding function is thus no longer available in Feed-O-Matic. You may still find Feed-O-Matic quite useful for its ability to automatically choose foods for your pet and feed them at the touch of a button -- the "Feed Pet" button (configurable in WoW's Key Bindings menu) and `/fom feed` chat/macro command still work just great.
- As an aid to those suffering auto-feed withdrawal, there's now an option for Feed-O-Matic to provide an extra reminder when your pet needs feeding (in case you find the icon next to your pet's health bar too subtle). This is accessed by the same `/fom level` command that previously controlled automatic feeding; when your pet's happiness falls below the specified level, the happiness icon will blink until you feed him enough to sate his hunger.
- Fixed a bug where an error panel could appear when attempting to feed the pet with the `fallback` option turned off and the only foods in your inventory being types you'd prefer to avoid.
- KNOWN BUG: The tooltip additions aren't showing up in all cases where they should. Another update to address this issue should be coming along soon.

v. 11000.1 - 2006/03/28
- Updated for compatibility with WoW patch 1.10. (Minor changes were needed.)
- Should no longer disconnect if you have feed emotes turned on and you try to feed your pet a Legendary item. (Probably not a bug many experienced, but still...)
- Minor improvements to utility code shared across Fizzwidget addons.
- KNOWN BUG: The tooltip additions aren't showing up in all cases where they should. Another update to address this issue should be coming along soon.

See http://fizzwidget.com/notes/feedomatic/ for older release notes.