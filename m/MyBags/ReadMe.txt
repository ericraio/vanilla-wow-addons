Addon:    MyBags
Author:   Ramble (modified by Isharra)
Version:  0.4.4 (TOC: 11100)
Released: 07/13/06 mm/dd/yy

--DESCRIPTION-------------------------------------------------------------
MyBags is a replacement to the default interface's Inventory and Bank
features.  It replaces smaller individual frames and places them into a
larger frame showing all your inventory or bank slots.

It is really three addons in one, MyInventory, MyBank, and MyEquipment. 
Each addon can be disabled entirely if you don't wish to have the features
of it.  

In the MyBags Folder there are 5 folders:
MyBagsCore: This is for things common to MyEquipment, MyInventory and MyBank.
	You must have this.
MyBank: This is for things specific to MyBank.  Remove this folder to 
   disable MyBank
MyInventory: This is for things specific to MyInventory.  Remove this 
   folder to disable MyInventory
MyEquipment: blah, blah, blah. Remove this to disable MyEquipment
Skin: This holds the image files used by the previous components. 
	Do NOT delete this.

MyBagsCache: This saves your inventory and bank items for offline viewing.
	**note**: DISABLE MyBagsCache IF:
	  1. You use KC_Items
	  2. You don't wish to have offline (or away from bank) viewing (it 
		  will bloat your saved vars)

--FEATURES----------------------------------------------------------------
Features:
* Toggle to completely replace default UI.  MyBags can be used with or 
   instead of the default UI
* Bag Slots are shown in the bag window and can be toggled
* Item Borders reflect their rarity
* Frame can be resized by changing the columns
* Frame background is configurable:default background, graphical 
   background, or no background

MyInventory Specific Features:
* You can disable specific bags in MyInventory by shift+right clicking 
   the bag slot.  This will remove it from the MyInventory frame and 
	allow the default UI to handle just the bags you disable.

MyBank Specific Features:
* When at bank, click an unbought bag to buy a slot.  It asks you to
	confirm before you actually purchase it.

Additional Features:
* Bank and inventory Viewing is possible with one of the following addons:
	- KC_Items (KC_Bank for bank, KC_Inventory for Inventory and 
		KC_Equipment for Equipment)
	- MyBagsCache (Included in this package)
	
--TODO--------------------------------------------------------------------
**NOTE** MyBags is in beta release.

1. Change MyBagsCache data format (it's using far too much memory)
2. Break out MyBags, MyBank, and MyInventory into load on demand addons 
with MyBags as a core dependency. 
3. Add right click menu for frame strata (dropped in priority since the 
command line is in).
4. Apologize to Ramble for making a mess of his nice clean code.

--DEPENDANCY NOTES--------------------------------------------------------
Ace: Required for a simpler, more efficent MyBags.
KC_Items:  KC_Inventory and KC_Bank allow for offline viewing of character
  Bank and Inventory.  KC_Bank allows you to also view your bank when not
  at Bank.

--SLASH COMMANDS----------------------------------------------------------
/(myinventory|mi)         [OPTION [ARGUMENTS]]: change MyInventory options
/(mybank|mb)              [OPTION [ARGUMENTS]]: change MyBank options
/(myequipment|myequip|mq) [OPTION [ARGUMENTS]]: change MyEquipment options

Options:

aioi    - Enables "AIOI" style bag ordering. 
		[Partial row at the top right versus bottom left.]
anchor  - Sets the anchor point for the frame
	bottomleft  - Frame grows from bottom left, tooltips open right
	bottomright - Frame grows from bottom right, tooltips open left
	topleft     - Frame grows from top left, tooltips open right
	topright    - Frame grows from top right, tooltips open left
back    - toggle window background options
	default  - translucent minimilistic frame
		(optional addition) alpha red green blue (numeric 0-1) 
			   - sets the background color settings
	art      - blizzard style artwork
	none     - background disabled 
bag     - toggle between bag button view options
	bar      - Bags are displayed on a bar at the top of the frame
	before   - Bags start their own row and the first slot shows the bag
	none     - Bags are not shown in the frame
buttons - Show/Hide the close and lock buttons
cash    - Show/Hide the money display
cols    - set the number of columns
companion  - Open/close MyInventory with bank, mail and trade windows
count   - toggle between the item count options
	free     - Show Free Slots
	used     - Show Used slots
	none     - Disable slots display
["count" now only displays the items in standard bags]
freeze  - keep window from closing if it was open prior to visiting 
	merchants or the bank 
	always  - only manually open and close frames
	sticky  - leave windows open if they were manually opened 
		(automatically opened windows will still close)
	none    - don't block the UI from closing windows
noesc   - remove the frame from the list of UISpecialFrames, most obvious change
		is that the window may stay open when you hit "esc".
["freeze always" plus "noesc" reproduces the freeze behavior that Ramble coded]
highlight - highlight options
	items - highlight items when you mouse over bag slots
	bag   - highlight bag when you mouse over an item
lock    - keep the window from moving
title   - Show/Hide the title
player  - Show/Hide the offline player selection box
quality - Highlight items based on quality
replace - toggle replacing of default bags
reset   - Resets elements of the addon
	settings - resets settings to default
	anchor   - moves frame back to it's origional position
reverse - Reverse the order of the bags display (the contents remain in the same order)
	backpack on bottom versus backpack on bottom for inventory...
scale   - Set the frame scale (between 0.2 and 2.0, blank resets to default)
strata  - Set the frame strata
	background
	low
	medium
	high
	dialog
tog     - toggle the frame
slotcolor - bagname red green blue
	default  - standard (hold anything) bags
	ammo     - ammunition bags and quivers
	soul     - soul (shard) bags
	enchant  - enchanting bags
	engineer - engineering bags (I've not actually seen these yet)
	herb     - herb bags