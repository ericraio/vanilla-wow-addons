MobInfo-2 is a World of Warcraft AddOn that provides you with useful additional information about Mobs (ie. opponents/monsters). It adds new information to the game's Tooltip whenever you hover with your mouse over a mob. It also adds a numeric display of the Mobs health and mana (current and max) to the Mob target frame. MobInfo-2 is the continuation of the now abandoned "MobInfo" by Dizzarian combined with the original "MobHealth2" by Wyv. 

[[ IMPORTANT NOTE FOR DEVELOPERS OF OTHER ADDONS:           ]]
[[ Please read the informatin in "ReadMe_MobInfo_API.txt" ! ]]


*****************************
***     MobInfo-2 Data    ***

MobInfo collects data whenever you fight a Mob. It starts off with an empty database, which fills up automatically the more you fight and play. The data it collects is used for enhancing the game tooltip and the game target frame. It is also available to other AddOns (mostly the mob/target health values).

NEW FEATURE: The MobInfo database has become searchable. You can do a search for the 12 most profitable Mobs. You will find the "Search" button on the "Database" page of the options dialog.


******************************************
*** Extra Information For Game Tooltip ***

The extra information available to show on the game tooltip is:

Class - class of mob
Health - current and total health of the mob
Mana - current and total mana of the mob
Damage - min/max damage range of Mob against you (stored per char)
DPS - your DPS (damage per second) against the Mob (stored per char)
Kills - number of times you have killed the mob (stored per char)
Total Looted - number of times you have looted the mob
Empty Loots - number of times you found empty loot on the mob
XP - actual LAST xp amount you gained from the mob
# to Level - number of kills of this mob neede to gain a level
Quality - the quality of items that are dropped by the mob
Cloth drops - the number of times cloth has dropped on the mob
Avg Coin Drop - average amount of money dropped by the mob
Avg Item Value - average vendor value of items dropped by mob
Total Mob Value - total sum of avg coin drop and avg item value

Note that MobInfo offers a "Combined Mode" where the data of Mobs with the same name that only differ in level gets combined (added up) into one tooltip. This mode can be enabled through the options dialog


***************************************
*** Target Frame Health/Mana Values ***

MobInfo can display the numeric and percentage values for your current targets health and mana right on the target frame (formerly known as MobHealth functionality). This display is highly configurable through the MobInfo options dialog (position, font, size, etc).


******************************
*** MobInfo Options Dialog ***

Type "/mi2" or "/mobinfo2" on the chat prompt to open the MobInfo2 options dialog. This dialog gives you full interactive control over EVERYTHING that MobInfo can do. All options take immediate effect. Simply try them all out. Decent defaults get set when you start MobInfo for the first time. Note that the 3 main categories "Tooltip", "Mob Health/Mana", and "Database Maintenance" have separate dedicated options pages within the options dialog.

Note that everything in the options dialog has an associated help text that explains to you what the option does. The help texts are shown automatically as a tooltip.

**NEW FEATURES** : Have a look at the "Database" page of the options dialog. Several new features have been added here, like "Clear" buttons and a "Search" button for finding the most profitable Mobs.


**********************
*** How to Install ***

Unpack the ZIP file and copy the folder 'MobInfo2' into your 'World of Warcraft\Interface\AddOns' folder. MobInfo-2 will automatically load the next time you login with one of your chars. When starting the first time you might get a message that a separate MobHealth AddOn was detected. If so please remove it, or at least disable it. You will find that it is no longer needed, because MobInfo-2 is a full featured and fully compatible replacement. 


**********************************************
*** IMPORT of an External MobInfo Database ***
**********************************************

MobInfo can import externally supplied MobInfo databases. This can be a database from a friend of yours or a database that you have downloaded somewhere. WARNING : the database that you import MUST be from someone who uses exactly the same WoW localization as you do (ie. the same WoW client language). Importing a MobInfo database rom someone using a different WoW language will NOT work and might destroy your own database.

First of all before importing data you should make a backup of your own database. It never hurts to be able to restore your original data in case you are unhappy with the import result. The entire MobInfo database is contained within this file:
  \World of Warcraft\WTF\Account\<your_account_name>\SavedVariables\MobInfo2.lua

Make a copy of that exact file to a save location. This is also the file that you must pass on if you want to give your MobInfo database to someone else. Which of course means it is also the file you receive when someone else gives you his MobInfo database.

Here are the detailed import instructions:

1) Close your WoW client

2) Backup your MobInfo database as explained above

3) Rename the database file that you want to import from "MobInfo2.lua" to "MI2_Import.lua"

4) Copy the file "MI2_Import.lua" into this folder:
\World of Warcraft\Interface\AddOns\MobInfo2\
(that is the folder where the AddOn has been installed)

5) Start WoW and login with one of your chars

6) Open the MobInfo options (enter "/mi2" at the chat prompt) and go to the "Database" options page. Near the bottom of the page you should now see whether the AddOn has found valid data to be imported. If you did everything correctly the "Import" button should be clickable.

7) Choose whether you want to import only unknown Mobs, otherwise all Mobs will get imported. If a Mob already exists in your database and you choose to import it the data of the new Mob will get added to the data of the existing Mob. Now click the Import button to star the database import operation. In your normal chat window you will see a summary of the import results.

8) Logout to cause WoW to save your now extended MobInfo database file. You should now delete the file "MI2_Import.lua". It is no longer needed and it will waste memory as long as it exists.

TIP : use the "import only unknown Mobs" if you know that there is a large amount of overlap between your current database and the imported database. For instance if you import data from the same source again (because he released a newer version).

TIP2 : You can also use this Import feature to import databases of the "MobHealth" AddOn. Use the instructions exactly as listed above, but in step 2 rename "MobHealth.lua" (the MobHealth database file from "savedvariables" folder) to "MI2_Import.lua".


*****************************************
***  Conversion of DropRate Database  ***
*****************************************

The integrated DropRate converter can convert the contents of a DropRate database into MobInfo database entries. Yet in order for the converter to work an additional item database must be installed. THIS IS ABSOLUTELY MANDATORY !

Right now the DropRate conversion supports the following item database tools: ItemSync (from Derkyle), LootLink and LootLink Enhanced (from Telo and Brodrick) and KS_Items (from Kaelten). You MUST have one of these AddOns installed and you MUST have a sufficiently large database. Why is this so important ? Because DropRate recorded only the item names, which is highly inefficient. All modern tools use instead mainly the item ID code. Yet name to code conversion is tricky, because the WoW client does not support this. Instead an item database is required that knows item names and that can convert a given item name into an item ID code. The AddOns that MobInfo currently supports all offer this feature.

Right now Using LootLink is recommended for the conversion because AddOns sites like "http://ui.worldofwar.net" host huge downloadable LootLink item databases that ensure a high conversion success rate. After successful conversion LootLink (or any other item database tool) can be uninstalled, if you dont want to keep it.

Note that whenever the item database AddOn does not know an item from the DropRate database this item can NOT be converted into the MobInfo database. Therefore Mobs with unknown items can only be partially converted. The unknown items will be missing from the Mobs when looking at their MobInfo data.

Here is how to make the conversion:

1) You must have the following AddOns installed and active: MobInfo, DropRate, and either ItemSync or KC_Items. I'd like to mention that I made all my tests with ItemSync and it worked very well.

2) Backup your MobInfo database as explained in the "IMPORT" chapter. Similarely backup your DropRate database. The conversion will modify both databases ! Therefore it is very important to have backups of the originals so that you can go back to the state before the conversion, in case you encounter a problem, or in case you are not happy with the result

3) To start the conversion enter "/mi2 convertDropRate" at the chat prompt. The conversion result will appear in the standard chat log window.

4) Logout from WoW to make WoW save your modified database files.

5) Now have a look at the file "savedvariables/DropRate.lua" (this is the DropRate database in the "savedvariables" folder). This database has been modified by the converter. All data that was converted successfully has been removed from the database called "drdb". All entries that still exist in "drdb" represent data (Mobs or other stuff) that the converter has not converted. Non Mob data will always remain because MobInfo does not support this (chests, mining, etc). If Mobs remain it means that the Mob references unknown and thus unconvertable items.

6) If the conversion result is OK you can simply leave things as they are. If very many items were not converted then you should try to obtain a larger items database and start the conversion again from step 3. You can repeat the conversion as often as you like because the converted removes all successfully converted data from the DropRate database.

NOTE: During normal game play you should NEVER (!) have both DropRate and MobInfo running. Doing so will result in incorrect data when you start the converter. Both AddOns will record the same data and starting the converter will copy the DropRate data into the MobInfo database, which will incorrectly double some of the data for the Mob. You should ONLY have both AddOns active at the same time for the purpose of doing a conversion.

7) If the conversion encounters an error, or in case you are unhappy with the result of the conversion, please use the backups you made in step 2 to go back to your previous databases. To restore your databases you MUST first exit WoW. Then simply copy the backups of "MobInfo2.lua" and "DropRate.lua" into your "savedvariables" folder. Start WoW again and you should have your old data back. Please observe the NOTE above and NEVER play with MobInfo and DropRate active at the same time.




***-----------------------------------------------***
***-----------------------------------------------***
      F. A. Q. - Frequently Asked Questions
***-----------------------------------------------***
***-----------------------------------------------***


******************************************************
** Where do the health values come from ?
** Why do max health values change so much at first ?

WoW itself does not allow AddOns to see the numeric health value of a Mob or other players. Instead WoW reports only a percentage value. To obtain an absolute health value this value must be calculated, or more correctly approximated. Thats what MobInfo does. In order to do this you must fight the creature. During the fight the damage you do is reported as actual damage points. The current health of the Mob is reported as percentage values. What MobInfo does is add up the damage numbers and calculate the corresponding difference in health percentage. The result is the number of points-per-percent (PPP) for the Mob. PPP times 100 thus is the maximum health value for the Mob. PPP allows calculating the numeric health value of a Mob from the Mobs health percentage.

The data collected during one fight is not sufficient to get a good reliable PPP value. It needs accumulation of the data for at least 5 to 10 fights to get a reliable stable PPP value and thus a reliable and stable max health value for the Mob. In fact MobInfo will accumulate the data for 100 fights to obtain the best possible health approximation for a Mob. If you do not like to see a changing maximum health value for a Mob during a fight you can use the MobInfo obtion "Show stable Health Max". The health max will only get updated in between fights when activating this.

The method described above for approximating a Mobs health was first developed by "Telo" for his AddOn "MobHealth". It was then refined by "Wyv" for his own AddOn "MobHealth2". The MobInfo implementation is based on "MobHealth2" with kind approval of Wyv.

******************************************************************
** How do I change tooltip position or tooltip popup behaviour ?

MobInfo only adds information to the tooltip, but it does not modify where or how the tooltip appears. To change this there are a large number of real good tooltip controll AddOns available. I can't list them all here, but some of the better and more popular ones are: TipBuddy (http://ui.worldofwar.net/ui.php?id=607), AF Tooltip Extreme (http://ui.worldofwar.net/ui.php?id=2416), or TooltipsKhaos (part of Cosmos compilation: http://www.cosmosui.org/).



***-----------------------------------------------***
***-----------------------------------------------***
             MobInfo-2 Version History
***-----------------------------------------------***
***-----------------------------------------------***

ver 2.97
  - updated to comply with newest WoW version 1.11
  - show items on search options page in correct item color
  - search options page again shows result list size
  - fixed bug in search for Mobs that drop a certain item

2.96
  - new feature: store health value obtained through Beast Lore in health database
  - new feature: added chinese translation submitted by Andyca Chiou
  - fixed nil error for items with legendary and artifact rarity

2.95
  - bugfix release : fixes wrong max health display

2.94
  - huge update of MobInfo vendor sell price table (over 1000 new prices)
  - DropRate conversion now supports LootLink databases
  - fixed: DropRate conversion nil bug "Mobinfo2.lua Line: 383"
  - fixed bug where health was displayed wrong after using "BeastLore" on Mob

2.93
  - new feature: implemented DropRate database converter from NakorNH
  - bugfix: correctly import locations for mobs in instances
  - added new items (loot from Silithus) to MobInfo item price table
  - several new skinning loot items added to skinning loot detection table

2.92
  - new feature: you can choose to import only unknown (ie. new) Mobs
  - improved item colors in Mob tooltip for better readability
  - fixed all health/mana updating issues for unit frame and tooltip
  - fixed max health not increasing correctly for group member targets

2.91
  - new feature: importing of externally supplied MobInfo databases
  - new feature: option to delete all Mobs shown in search result
  - added Turtle Scales to skinning loot detection table
  - show all "green hills of Strangle" pages on one tooltip line
  - item list on search page: show all items if item name field is empty
  - fixed: mob name search errors on special chars
  - fixed: correct independant show/hide of basic loot items

2.90
  - added separate tooltip option for cloth and skinning loot
  - show drop percentages for items in Mob tooltip
  - calculate skinning loot percantage based on skinned counter
  - rearranged tooltips options page
  - new skinning loot support for Shiny Fish Scales and Red Whelp Scales

2.89
  - reinserted missing spaces in tooltip health
  - abbreviate long tooltip item names instead of using 2 lines
  - fixed to correctly call original GameTooltip:OnShow()

2.88
  - fixed ItemSync support to behave properly
  - fix for stack overflow caused by CastParty AddOn
  - internal event handling improvements

2.87
  - bugfix for NIL bug "MI2_Events.lua:100"

2.86
  - fixed to support newest version 12 of ItemSync
  - fixed health updating during combat within Mob tooltip
  - improved and extended Spanish localization (thanks to Pyrgus Malvae)
  - fixed: show correct health updates for group member targets

2.85
  - fixed Spanish localization: should work now

2.84
  - fixed incorrect counting of item quantities
    (special thanks to Nakor for finding all those tricky item bugs)
  - basic spanish localization for MobInfo (thanks to Pyrgus Malvae)

2.83
  - feature: added keybinding for MobInfo
  - feature: always show mana/rage/energy value if available
  - bugfix: incorrect health percentage for party members

2.82
  - bugfix: not counting skinning loot correctly
  - bugfix: quest items getting counted in quality overview
  - bugfix: health not updating when Mob health itself
  - updated french localisation (thanks to Sasmira)

2.81
  - drastically improved French translation (many thanks to Sasmira!)
  - fixed NIL bug for "Mobinfo2.lua:1432"
  - improved MI2_Browser data import and error checking

2.80
  - updated version number for WoW 1.10 compatibility
  - new feature separate "skinned" counter
  - new feature: mob location recording
  - addded mob location to tooltip and options
  - automatic conversion of MI2-Browser location data
  - sort "Dropped By" list also by reliability of percentage
  - reduced database size by storing char names in separate table
  - combined basic mob data with quality overview data
  - bugfix: empty loot counting should now always work
  - bugfix: improved health calculation accuracy
  - bugfix: do not count quest items in quality overview
  - improved compatibility with TipBuddy 2.10 Compact Mode


(for previous version info or any questions regarding MobInfo-2 please visit http://www.dizzarian.com/forums/viewforum.php?f=16)

