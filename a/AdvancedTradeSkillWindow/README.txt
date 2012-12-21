Advanced Trade Skill Window v0.4.0
a World of Warcraft UI Addon
written 2006 by Rene Schneider (Slarti on EU-Blackhand)
----------------------------------------------------------------

1. Installation
The installation of this addon works like the installation of many
other addons: extract the archive into your WoW directory (and make
sure that your unpacker uses the path names in the archive!) and have fun!

2. Commands
There are no commands - you just open your tradeskill window as you
always do. If this addon is enabled, it will replace the standard
tradeskill window.
Okay...there is actually one command:
/atsw [disable/enable] - This (typed while you have the window for a
trade skill opened) will enable or disable ATSW for the opened trade skill.
Most buttons in ATSW are self-explaining.
By clicking on an item with your chat line opened and your shift key pressed
ATSW will add a list of the reagents necessary to create a single item 
to the chat line.
The "Reagents" button will show you a list of items needed to produce the
queued things. It will show you how many reagents you have in your inventory,
in your bank, on alternative characters on the same server and if a reagent
can be bought from a merchant. By clicking on the reagent count on alternative
characters, you get a list of all alts currently posessing the item in question.
ATSW can also automatically buy necessary items from a merchant when speaking to
him - either manually by clicking a button in the reagents window or
automatically when opening the merchant window.
ATSW has a powerful search function built-in. You can either just type some text
into the search box and have ATSW filter the recipe list according to your entry,
or you can use one of the following parameters:
----------------------------------------------------------------------------------
:reagent [reagent name] - filters the list to only include items that need the
                          specified reagent
:minlevel [level] - filters the list to only include recipes for items with at
                    least the given level requirement
:maxlevel [level] - the same as minlevel, just the other way round
:minrarity [grey/white/green/blue/purple] - filters the list to only include recipes
                                            for items with at least the given rarity
:maxrarity [grey/white/green/blue/purple] - should be self-explanatory
:minpossible [count] - filters the list to only include items that can be produced
                       at least [count] times with the material in your inventory
:maxpossible [count] - do I really need to explain this?
:minpossibletotal [count] - like minpossible, but considers material in your bank,
                            your alt's banks and buyable materials (actually it
			    depends on what you have activated in the options
			    window!)
:maxpossibletotal [count] - doh!
----------------------------------------------------------------------------------
You can even combine multiple parameters and a text for a name search, like this:
"leather :minlevel 20 :minrarity green" - this will show you only recipes with the
word "leather" in their name, a minimum level requirement of 20 and a minimum rarity
of "green".

3. Compatibility
I know that this addon does prevent several additions to the standard
tradeskill window from working correctly. This is because ATSW is not a
simple addition to the tradeskill window but a replacement. I decided to do
it this way because I think Blizzards tradeskill window is ugly: it's way
too small and missing some essential functions for effectively dealing with
a long list of recipes.

3. Changelog

v0.1 
- initial version

v0.1.1
- fixed:   pressing ESC now correctly closes the tradeskill window without
           displaying "UNKNOWN" in the title
- fixed:   pressing the tradeskill button again now correctly closes the
           tradeskill window
- fixed:   graphic errors in the window background
- fixed:   sort type checkboxes showing the wrong sort type
- added:   "filter" text input box for fast filtering of recipes
- fixed:   cancellation of production if a newly produced part has not found
           its way into the inventory yet (the whole production process 
	   should now be much more stable and fault-tolerant)
- fixed:   display of wrong possible item count (at least I hope this
           problem is fixed now!)
- added:   function to paste info about necessary reagents for a recipe
           into the chat line
- changed: english button texts changed to use caps

v0.1.2
- fixed:   error in v0.1.1 that sometimes caused the tradeskill window to
           lockup WoW

v0.1.3
- fixed:   another error in v0.1.2 that caused WoW lockups in certain
           situations (hopefully the last error with such drastic consequences)
- fixed:   a substantial mistake that sometimes caused ATSW to display the
           wrong items necessary to produce something, to queue the wrong 
	   items and to stop production when the recipe list was filtered.
- changed: reagents-to-chat function now posts each reagent in a single line
           and the name of the recipe as well

v0.2
- fixed:   some minor bugs
- added:   a new window that displays the reagents necessary to produce the
           queued items. It also shows you how many of each reagent you have
	   in your inventory, on the bank and on alternative characters and
	   which reagent can be bought from a merchant.
- added:   a function to automatically buy necessary reagents from merchants
- changed: you can now queue whatever you want - no matter if you have all
           the reagents in your inventory or not

v0.2.1
- fixed:   items that are produced in stacks are now queued correctly
- fixed:   items that are bought in stacks are now bought correctly
- fixed:   leather transformations are now queued and executed correctly
- fixed:   clicking the "reagents" button when the window is opened will now 
           correctly close the reagents window
- fixed:   the "opening a different trade skill but still getting old list"-bug
           has been fixed (at least I hope my fix was successful, as I have never
	   been able to really reproduce this exact bug)
- fixed:   a bug that caused ATSW to queue parts incorrectly in certain situations
- changed: the "create all" button now only queues as many items as you can create
           with the reagents currently in your inventory
- added:   a tooltip for every single tradeskill that shows you how many items
           can be created with the stuff currently in your inventory and which
	   reagents you need to produce one of the selected item (including a
	   list of the numbers of reagents you currently have in your inventory/
	   on your bank/on alternative characters).

v0.2.2
- fixed:   the "only one item is being produced" bug that came up together with
           patch 1.10
	   This bug is due to a change in the UI API: Blizzard has made a hardware
	   input event mandatory for a successful execution of the DoTradeSkill()
	   function (this function actually starts production of an item).
	   Unfortunately they left this change undocumented. While I was able to
	   make ATSW produce multiple items of the same kind in a row without
	   user interaction, I am unable (because the API does not allow me to)
	   to make it produce different items in a queue without user interaction.
	   This fix adds a dialog box that pops up whenever a new item is being
	   produced. You have to manually click the "OK" button to start production.
	   This click on the button essentially supplies the needed hardware event.
- added:   an option to turn the new tradeskill tooltips on and off
- added:   another possibility to display possible item counts (an alternative
           to the old method with slightly more information)

v0.3.0
- fixed:   the tradeskill list should now be updated with newly learned tradeskills
           immediately
- fixed:   this version now displays the correct version number
- fixed:   ATSW should now buy the correct amount from merchants no matter how many
           stacks you need to buy
- fixed:   the "continue queue processing" window should now be displayed at the
           correct time and not in the middle of production
- fixed:   if you directly queue an item that is produced in stacks, ATSW will now
           queue the correct number of stacks instead of queueing just a fraction
           depending on the number of items produced in one stack
- added:   the possibility to sort recipes by difficulty (color)
- fixed:   Rugged Leather is now recognized correctly in the english language
           version
- changed: The "order by"-setting is now saved once for every different character
           and every different tradeskill
- added:   you can now create your own recipe groups and sort your recipes the
           way you like

v0.3.1
- fixed:   auto-buying from vendors should now buy the correct amount and not
           double as much as needed
- fixed:   some errors in the queueing functions that caused ATSW to sometimes 
           queue wrong item counts
- added:   French translation (thanks to Nilyn)

v0.3.2
- fixed:   the problems with rogue poison creation (UI lags heavily when creating 
           and/or in combat when using rogue poisons on weapons) should now be fixed
- fixed:   clicking on a category with the same name as a recipe in the sorting editor
           will not remove this recipe from the categorized list anymore. In addition
	   to that, several problems that occured when categories had the same name
	   as recipes have been corrected. It should now be safe to create categories
	   with recipe names.
- fixed:   the trade skill list should now be updated correctly when learning a new
           recipe by "using" a recipe item
- fixed:   seemingly random spamming of recipe requirements into chat when chatting 
           while simultaneously producing items
- fixed:   several issues regarding the french localisation
- fixed:   compatibility issues with the Bagnon/Banknon addon and other addons
           that replace the Blizzard bank window
- fixed:   an error in a core function that caused errors in buying stuff from vendors
           and in the reagents list whenever you had multiple items in your queue in
	   a specific order
- added:   a new autobuy button that is displayed within the merchant window whenever
           you have recipes in your queue that need at least one reagent buyable at
	   the specific vendor
- fixed:   the "ghost window" problems: the old tradeskill window still was
           accessible on the screen even though it was not visible, therefore
	   clicking on the wrong place of your screen sometimes accidentially caused
	   errors within ATSW. The old window should now be inaccessible.

v0.4.0
- fixed:   the bank content information is now being saved correctly and will not be
           deleted when your bag contents change
- added:   a new addition to the auction window: a shopping list that resembles the
           reagents window on smaller space and lets you quickly search for reagents
	   in the auction house by just clicking on a reagent name
- fixed:   the recipe radar bug should be fixed
- added:   possibility to switch off ATSW for certain tradeskills
- added:   more powerful search function (take a look at the readme for details!)