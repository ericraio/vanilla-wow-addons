
Auction House Favorites README

Version: 1800.2
Required Dependencies: ACE
Optional Dependencies: myAddOns, Fizzwidget ShoppingList

Ever find yourself doing the same queries all the time at the Auction House?

If so, Auction House Favorites can help you.

For example, my main character is an alchemist, and I'm always checking out the prices for Arcane Crystals.  It's such a pain to clear out all the fields from the last search you did, select Trade Goods, then enter "Arcane Crystal" in the name box.

Auction House Favorites can save your current search criteria in a favorites list, and it will automatically repopulate all the fields when selected. 

Auction House Favorites adds a pulldown menu called "Favorites" to the Name field in the Browse tab at the auction house.

It's easy to use:

1) Set up your search criteria. (you don't have to click the search button)
2) Choose "Save" from the Favorites pulldown.
3) Give your search a name (For instance "Arcane Crystal" if that's what you were searching for)

That's it.

If you want to get rid of a favorite, select it, then choose "Delete" from the Favorites pulldown.

To clear the current search criteria, choose "Clear" from the Favorites pulldown.

By default, AHFavorites will press the "Search" button for you when you select a favorite. If you want to change it so you have to manually click the Search button, use the slash command /AHFav AutoQuery.  This command toggles the functionality.

If you have Fizzwidget's ShoppingList mod installed, by default you will see items from the shopping list at the bottom of the pulldown menu.  Selecting any item will initiate a search.  If you want to turn off the ShoppingList integration, use the slash command /AHFav FSL to toggle integration on and off.

Finally, by default, all settings and searches are shared by all your characters.  If you would like to have different searches for each of your characters, you can use the ACE profile manager to help.

For example, to save your searches on a per-character basis, use this command:

/ace profile char AHFavorites

That's it.


VERSION HISTORY:

1700.1: Initial Release

1700.2:	Changed interface to work like MailTo.  Favorites pulldown is now attached to the Name field.  No longer obscures the Dressing Room checkbox.
(Thanks to the author of MailTo for coming up with the pulldown technique used here)

1700.3: Fixed initialization issue which prevented favorites from working if FSL was installed, but had never had anything added to the list.

1700.4: Enhancement: Favorites sorted alphabetically now.
		Enhancement: Display on Char checkbox state saved as part of favorite search (Patch thanks to LeisureLarry at curse-gaming.com)
		Enhancement: German translation from LeisureLarry at curse-gaming.com
		Enhancement: Works with myAddOns 2.3
		
		NOTE: If you have used Ace to save your searches on a per-character basis, your searches will be missing after this upgrade.  You have two choices: a) Recreate all your searches, or b) Edit the file WTF/Account/<char name>/SavedVariables/Ace.lua and change all references from ["AuctionHouse Favorites"] to ["AHFavorites"].
		
		Known Bug: Rarity dropdown is not updating properly.  Calls to UIDropDownMenu_Refresh(BrowseDropDown) don't seem to set the text value anymore.  If anyone has any ideas, please send me a PM.
		
		Updated to use the Ace 1.2 method calls.
		
1800.1: Updated to WoW version 1800.
		TOC file now notes the dependency on the Blizzard AuctionUI for this to work properly.
		
1800.2: No longer preloads the Blizzard Auction UI.
		- Patch thanks to Sariash at curse-gaming.com
		Default favorite name pulled from "Name" field in AH interface.
		- Patch thanks to peppa at curse-gaming.com
		Max favorite save name upped to 40 chars
		- Patch thanks to peppa at curse-gaming.com
		
		When 1.9 is released, AHFavorites will go to full dynamic loading using the LoadWith TOC entry.
		

