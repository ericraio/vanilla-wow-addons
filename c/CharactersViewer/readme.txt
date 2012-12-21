	0.99 - Modified the bag handling code for better Blizzard merge on future patch, this include fix for 4 slot and unlocking bag > 20 slot
	0.98 - Added the Keyring Container, reload each char to add the data, the keyring is handled as a normal container.
	0.98 - Modified Wakyhorse code for fixing the sex issue with 1.11
	0.98 - Merged the 1.11 bagfix from Wakyhorse.
	0.97 - Fixed the calculation of Undead Money.
	0.96 - Fixed the /cv bags and baguse command that was broken in 0.94
	0.95 - Removed the button to toggle money option and added them as text.
	0.95 - Fixed the new option about money config.
	0.94 - Added Money per faction, baaed on Wakyhorse code (reoptimized by myself)
	0.94 - Fixed the invenotry content to be linkable
	0.94 - Added Bank Timestamping, by Wakyhorse, note that the GUI doesn't report it yet
	0.94 - Added HK/DK collecting, by Wakyhorse, note that the GUI doesn't report it yet
	0.93 - Fixed the empty slot in bank bag error, reported by fluffy
	0.92 - Officially merged the Cosmos Team, Vincent and Galmok improvement.
	0.91 - Galmok - Updated to handle larger than 16 slot bags by Galmok@Stormrage-EU
	0.91 - Crude support for 24-slot bags.
	0.90 - Added bags, baguse commands (First update by Vincent).

Change from 0.82 to 0.87
-0.83: Added timestamp in the guild Pannel Tooltip, thank LordRod
-0.83: Add timestamp in the Character Panel, thank LordRod
-0.83: Closing main CV frame now close the bank properly, 
-0.83: Greatly Improved windows positionning / remeinder location, thank AnduinLothar
-----Sidenote: Right clicking on bag/bank toggle in mainframe reset position, left click show/hide, position is now reminded!
-0.84: Removed MailTo Relocate on right click.
-0.84: Added a dropdown menu in the Bank Frame
-0.84: Added a /cv bank
-0.84: Added a resetlocSlashCmd to reset the location of the main CV frame
-0.85: Added a bank bag relocate toggle
-0.85: Fixed guild tooltip for GCV.
-0.85: Fixed a contstant about timestamps
-0.86: Fixed the bag drawing for 1.9 compatibility, note that soulbag aren't tested yet.
-0.86: Workaround for souldbag bigger than 20 are capped to 20.
-0.86: Fixed the bag mis-relocation when entering the game
-0.87: Fixed the tooltip scan for crit % for 1.10

Change from 0.81 to 0.82
-0.82: Fixed the xml to call the KR localization
-0.82: Fixed myAddOns support, thank's to loramaru for the solution and wrmonger

Change from 0.79 to 0.81
-0.81: Fixed a "call to nil value" on close
-0.80: Added Korean Localization
-0.80: Fixed the toc to 1800
-0.80: Added Keybinding for the Bank
-0.80: Fixed Bank Toggle button to appear even if no bank,but disabled.
-0.80: Split bankbrame from cvmainframe, add bank close on cv OnClose
-0.80: Closing CV will now close the CV Bank.

Change from 0.78 to 0.79
-0.79: Added data  protection code for GCV, by LordRod
-0.79: Fixed the OnEnter in Bank Bag
-0.79: Fix the Button when empty in main bank frame

todo / known issues:
-Fix the OnClick event for bank / bank bag buttons.
-Fix the empty bag OnOver in the bankframe.
add a Disabled bank button
Fix the portrait location of bank
Split bankbrame from cvmainframe, add bank close on cv OnClose
Add timestamp in guildpanel tooltip
Add timestamp in the Character Panel
Add a Keybinding for BankShowing
Add a slashcmd for the bank

Change from 0.72 to 0.78
-0.73: Changed toc to 1700
-0.73: Bank information gathering
-0.73: Fixed Bag name (Bank / Inventory)
-0.74: Added BankFrame (greatly inspired from BankItems)
-0.74: Added Total Money in the bankframe
-0.74: Added bank main frame texture, link and tooltip display
-0.75: Added DressingRoom support (ctrl-leftclick object)
-0.76: Changed the right-click behavior on mail/bag/bank to switch to different layout
-0.76: Improved general coding of a few thing.
-0.76: Added tooltip for the bank
-0.77: Fixed DE/FR localization
-0.77: Fixed Bank Toggle Tooltip
-0.78: Fixed Toc/Lua version and posted of UI website

To make the lua file lighter, comment and update log are moved to a readme.txt
Change from 0.72 to 0.77 (beta)
-0.73: Changed toc to 1700
-0.73: Bank information gathering
-0.73: Fixed Bag name (Bank / Inventory)
-0.74: Added BankFrame (greatly inspired from BankItems)
-0.74: Added Total Money in the bankframe
-0.74: Added bank main frame texture, link and tooltip display
-0.75: Added DressingRoom support (ctrl-leftclick object)
-0.76: Changed the right-click behavior on mail/bag/bank to switch to different layout
-0.76: Improved general coding of a few thing.
-0.76: Added tooltip for the bank
-0.77: Fixed DE/FR localization

Change from 0.71 to 0.72
-0.72: Updated to 1700 interface version
-0.72: Improved ArmorCraft compatibility
-0.72: Improved bag handling

Change from 0.69 to 0.71
-0.70: MailTo now switch when you change characters, by Flisher
-0.70: Fixed German/French localization of portrait, by Flisher
-0.70: Fixed problem when the first character of the name is an accent, by Flisher
-0.71: Fixed misc typo, internal push, by Flisher / LordRod
-0.71: Added Dropdown protection, they only contain "self" type now, guildmate (GCV) visible in guild pannel, by Flisher

Planned Milestone 1: "Fix / improvement release"
-Add anti level 60 rested xp
-Add level icon to portrait
-Redesign the placement of information in the frame as it sometime get out of the frame
-Add a total money tooltip over the money frame

Change from 0.67 to 0.69
-(0.68) Added a field containing the non-localized race/class, by Flisher
-(0.68) Added generic portrait per sex/race, by Flisher
-(0.68) Fixed the class/level display, by Flisher
-(0.69) Added support for MailTo, by Flisher and Vincent

Change from 0.65 to 0.67
-(0.66) Fixed the splitstring function, non-standard characters will be accepted now, by Flisher
-(0.66) Added current xp to data saved, by Flisher
-(0.66) Major GUI improved xp display, by Flisher
-(0.66) Added the "Resting" flag next to the CV portrait, by Flisher
-(0.67) Improved data collection for future inspect/remote integration, by Flisher
-(0.67) Added button in GuildPannel to see their data if know, by Flisher
-(0.67) Minor GUI improvement in headers, by Flisher

Change from 0.64 to 0.65
-(0.65) Fixed the caching validation on equiped item, by Flisher
-(0.65) Added MakeLink and DeLink data protection, by Flisher

Change from 0.59 to 0.64
Key Feature: "/cv List", Rested XP and Mailbox status and easier plugin integration.

Change from 0.58 to 0.59
-(0.59) Fixed the .toc file to 1600

Change from 0.57 to 0.58
-(0.58) Added ReceipeBook Support. (by Flisher)
-(0.58) Fixed the money frame click to not do anything (by flisher, inspired from Accountant code)

Change from 0.57 to 0.58
-(0.58) Added ReceipeBook Support. (by Flisher)
-(0.58) Fixed the money frame click to not do anything (by flisher, inspired from Accountant code)

Change from 0.55 to 0.57
-(0.56) Removed the "return" clause of Component call (by Flisher)
-(0.56) Added CTmod button upport, in the "Party" section (by Flisher, thank to Sarmira&Cide help)
-(0.57) Added Book of Crafts compatibility (by Flisher, thank's to Blackdove)
-(0.57) Fixed Component compatibility (by Flisher, thank's to Vincent)
-(0.57) Added Auctioneer support (by Flisher, thank's to Norgana)
-(0.57) Localized the "Empty" of empty slot (by Flisher, thank's to Sasmira)
-(0.57) Override Titan [ModMenu] registration in CV code. (by Flisher)

Change from 0.54 to 0.55
-(0.55) Improved backward compatibility code for inter-addon operation (by Flisher)
-(0.55) Centralized the index management, making it more robust (by Flisher)
-(0.55) Improved the Initialization and Showing sequence (by Flisher)
-(0.55) Improved the event handler (by Flisher)
-(0.55) Centralized the Hide sequence (by Flisher)
-(0.55) Fixed the right-click on bag-reset and other button to be properly initialized(by Flisher)
-(0.55) Improved various status handling in the code (by Flisher
-(0.55) Added internal support for Component addon (by Flisher)

]]--


Change from 0.53 to 0.54
-Fixed internal structure to work with EquipCompare (by Legorol / Flisher)
   
Change from 0.52 to 0.53a
-Fixed the title to work as intented with the new Blizzard patch.  (by Flisher)
-Changed the way alot of internal stuff work.  (by Flisher)
-Fixed a sky optional depency (by Flisher)
-Fixed a clear & clearall switchplayer issue (by Flisher)

Change from 0.51 to 0.52
-Fixed the .toc file to interface version 1500 (by Flisher)
-Fixed the Hooking method (by Flisher)
-Fixed compatibility issue with the new patch, blizzard calling event after flushing all info doesn't helped... (by Flisher)

Current todo:
-Fix the bag anchoring before they are reseted.
-Add the ammo slot
-help integration with cosmos
-slash command with cosmos
-Prevent the CoinPickup when money is clicked (blizzard bad code)
-Add a total money pannel
-Add more honor information
-Add AIOI support
-Prevent the CoinPickup when money is clicked (blizzard bad code)
-Find a new location for the MoneyFrame display, and display
-Add a total money pannel
-Add BankStatement support
-Add BankItem support
-Add crafting skill level
-Add crafting receipe known
-ADd CTmod button support
-Add Khaos support

---- Removed from Curse-Gaming update log ----

Change from 0.50 to 0.51
-(0.51) Fixed the bug on the ranged slot. (by Flisher)

Change from 0.49 to 0.50
-(0.50) Improved the data handling, saved about 15% of space per profile (by Flisher)
-(0.50) Improved the performance of various part of the code (by Flisher)
-(0.50) Added SVN tracking to all file (by Flisher)
-(0.50) Improved FR localization (by Sarmira)
-(0.50) Fixed a en/fr localization that was too long (by Flisher)
-(0.50) Another DE Localization improvement (by Stardust)
-(0.50) Fixed MyAddons registration information (by Flisher)

Changes from 0.48 to 0.49
-(0.49) Updated German Localization by Stardust(Cosmos SVN 1698, updated by Sarf)
-(0.49) Fixed (hopefully) the CritPercent for localization (by Flisher)
-(0.49) Fixed the parry, shouldn't be displayed on character without the ability (by Flisher)
-(0.49) Fixed the Logout/Quit Hook with Sea (by Flisher)

Changes from 0.47 to 0.48
-(0.48) Fixed some localization / cosmosregistration constant. (by Sarf)
-(0.48) Fixed an error added by Sarf (by Moof)
-(0.48) Fixed the Bag status on/off initialisation to not overide the saved status. (by Flisher)
-(0.48) Localised DE/FR cosmos registration stuff (by Flisher)

Change from 0.43 to 0.47
-(0.44) Updated Cosmos button registration to Earth way of doing it
-(0.44) Updated German Localization (Thank Stardust)
-(0.44) Standardized the localization file to allow easier integration with other people
-(0.44) Removed the update event since they aren't needed, data is now gathered on display of youself with CharactersViewer, or when you quit the game properly.
-(0.44) Major code revamp, removed unused function and variable reference
-(0.45) Improved the non-Sea hooking
-(0.45) Fixed an old Keybinding issue (was not reported for the last 3 month...)duh?
-(0.45) Readded the event call since alt-f4 doesn't use hooked function.
-(0.45) Fixed(I hope) the error from line 451 that very few players had
-(0.46) Modified the Paperdoll "Compare" to display only when required
-(0.46) Fixed the format display of the CombatStats (now 09.99 format)
-(0.46) Fixed equipcompare tooltip when the character compared is the current one.
-(0.46) Modified the Paperdoll "Compare" button state is reseted on clearing data
-(0.46) Improved clear/clearall data re-initialization
-(0.46) Improved clear/clearall handling
-(0.47) Fixed the item count in the main CharactersViewer Frame (you now see the count of throwing in the ranged slot)
-(0.47) Moved the "Select Player" dropdown in the CV frame to the same location than the one on the PaperDoll.

Change from 0.41 to 0.43:
-Added a dropdown in the Paperdoll
-Fixed Tooltip Localization

Change from 0.38 to 0.41:
-Improve code to take care of all the possible way to call a show/hide
-Add a "/cv switch <charname>"
-Miscealeanous code / localization improvement
-Honor system support

Older change can be found at the begining of the .lua file.

Wishlist: (not for the next release but will come someday)
-Fix de crit over the FR/DE Version
-Add AIOI support
-Prevent the CoinPickup when money is clicked (blizzard bad code)
-Find a new location for the MoneyFrame display, and display
-Add a total money pannel
-Add BankStatement support
-Add BankItem support
-Add crafting skill level
-Add crafting receipe known
-Add the ammo slot
-Add a Config Pannel
-ADd CTmod button support
-Add Khaos support

Change from 0.38 to 0.41:
-Improve code to take care of all the possible way to call a show/hide
-Add a "/cv switch <charname>"
-Miscealeanous code / localization improvement
-Honor system support

Change from 0.33 to 0.38
-Fixed some typos / localization
-Added a "next/previous" character keybinding and slashcommand
-Added the possibility to remove a saved character information. (/cv clear charactername)
-Fixed the resistance value to those with modifier (couting base/ring/equipement/buff)
-Added DodgePercent, ParryPercent, BlockPercent, CritPercent (critpercent should work localisez, please confirm)

Change from 0.30 to 0.33
-Fixup: Different number of bag won't cause display mis-behavior
-Fixup: Fixed the error when you left-click on an empty item in the main pannel
-Improvement: Added Cosmos support, icon in the cosmos pannel at the minimap (not a requirement)
-Improvement: Added MyAddons support (not a requirement)
-Improvement: Added a reset bag position when you Right click on the bag button
-LUA Improvement: Slashhandler, Comments, Constant
-XML Improvement: Removed unused resist stuff
-XML Improvement: Removed unused bag part from bankitems
-Localization: The sex is now using the localized value

Change from 0.29 to 0.30
-Added bag display... and item display from backpack and bag(item display tooltip and are linkable to chat)
-Saved data optimized

Change from 0.28 to 0.29
-Fixed a function name to really make interroperability with EquipCompare
-Fixed the external tooltip function call to not display anything when called on an empty CharactersViuewer slot(used in EquipCompare)

Change from 0.27 to 0.28
-Fixed the interface number to the new Blizzard Scheme
-Fixed many variables name to ensure non-conflicting name with other addons
-Fixed incompatibility issues with CharacterProfiler (Thank's Woofiest for the feedback)
-Fixed the update routine to update before "/cv show" and "/cv"  (Thank jgleigh for the feedback)
-Rewriten the .xml file by using the BankItems template, (Thank Kaitlin, the coder of BankItems)
--This allow to be a movable frame now
--This will allow easier bag integration on a future version

Change from 0.26 to 0.27
-Fixed incompatibility with CharactersProfiler
-Hook the logout/quit function to update on quit/logout
-Gather information about the current character on show.
-Improve the character location detection (came with the 2 previous fix)

Change from 0.25 to 0.26
-Added viewing of Magic Resistances
-Added viewing of gold per characters
-Fixed miscealanous localization using WoW Constant
-Implemented interroperability with EquipCompare(from legorol)

Change from 0.24 to 0.25
-Fixed the secondhand/ranged weapon placement
-Fixed the clear / clearall to allow the addon to work without having to logout.
-Fix non EN crash, compatibility is to be tested
-Added/fixed localization friendly code
-Fixed some code to use Blizzard Constant instead of Localization

Change from 0.23 to 0.24
-Removed the dependency on CharacterProfiler
-Removed BankStatement trace in the code
-Fixed default texture on empty slot
-Fixed tooltip on empty slot
-Fixed error when character was not guilded
-Fixed mana display for non-spellcasting class
-Fixed the help menu, binding and command line function
