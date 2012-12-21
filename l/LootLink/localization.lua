--------------------------------------------------------------------------------------------------
-- Localizable strings
--------------------------------------------------------------------------------------------------

LOOTLINK_VERSION = "1.10.1 e14";
LOOTLINK_LOADED = "Telo's LootLink "..LOOTLINK_VERSION.." loaded";

BINDING_HEADER_LOOTLINK = "LootLink Buttons";
BINDING_NAME_TOGGLELOOTLINK = "Toggle LootLink";
LOOTLINK_TITLE = "LootLink";
LOOTLINK_SEARCH_TITLE = "LootLink Search";
LOOTLINK_OPTIONS_TITLE = "LootLink Options";
LOOTLINK_TITLE_FORMAT_SINGULAR = "LootLink - 1 item total";
LOOTLINK_TITLE_FORMAT_PLURAL = "LootLink - %d items total";
LOOTLINK_TITLE_FORMAT_PARTIAL_SINGULAR = "LootLink - 1 item found";
LOOTLINK_TITLE_FORMAT_PARTIAL_PLURAL = "LootLink - %d items found";
LOOTLINK_SEARCH_LABEL = "Search...";
LOOTLINK_REFRESH_LABEL = "Refresh";
LOOTLINK_RESET_LABEL = "Reset";
LOOTLINK_OPTIONS_LABEL = "Options";
LOOTLINK_QUICK_LABEL = "Quick Search";
LOOTLINK_AUCTION_SCAN_START = "LootLink: scanning page 1...";
LOOTLINK_AUCTION_PAGE_N = "LootLink: scanning page %d of %d...";
LOOTLINK_AUCTION_SCAN_DONE = "LootLink: auction scanning finished";
LOOTLINK_SELL_PRICE = "Sell price:";
LOOTLINK_SELL_PRICE_N = "Sell price for %d:";
LOOTLINK_SELL_PRICE_EACH = "Sell price, each:";
LOOTLINK_SCHEDULED_AUCTION_SCAN = "LootLink: will perform a full auction scan the next time you talk to an auctioneer.";

LOOTLINK_HELP = "help";			-- must be lowercase; command to display help
LOOTLINK_STATUS = "status";		-- must be lowercase; command to display status
LOOTLINK_AUCTION = "auction";	-- must be lowercase; command to scan auctions
LOOTLINK_SCAN = "scan";			-- must be lowercase; alias for command to scan auctions
LOOTLINK_SHOWINFO = "showinfo";	-- must be lowercase; command to show extra info on tooltips
LOOTLINK_HIDEINFO = "hideinfo";	-- must be lowercase; command to hide extra info on tooltips
LOOTLINK_MAKEHOME = "makehome";	-- must be lowercase; command to make the current server your home
LOOTLINK_RESET = "reset";		-- must be lowercase; command to reset the database
LOOTLINK_LIGHTMODE = "light";	-- must be lowercase; command to disable full-text search, using less memory
LOOTLINK_FULLMODE = "full";		-- must be lowercase; command to enable full-text search, using more memory
LOOTLINK_CONFIRM = "confirm";	-- must be lowercase; confirmation of MAKEHOME, RESET, or LIGHT

LOOTLINK_RESET_NEEDS_CONFIRM = "|cffff0000LootLink: Warning!  This will irreversibly erase all LootLink data.  If you really want to do this, use /lootlink or /ll with the following command: "..LOOTLINK_RESET.." "..LOOTLINK_CONFIRM.."|r";
LOOTLINK_RESET_ABORTED = "|cff00ff00LootLink: Data erase was NOT confirmed and will not be done.|r";
LOOTLINK_RESET_DONE = "|cffffff00LootLink: All data erased.|r";
LOOTLINK_MAKEHOME_NEEDS_CONFIRM = "|cffff0000LootLink: Warning!  This will irreversibly mark all LootLink data that predates multiple server support as having been seen on "..GetCVar("realmName")..".  If you really want to do this, use /lootlink or /ll with the following command: "..LOOTLINK_MAKEHOME.." "..LOOTLINK_CONFIRM.."|r";
LOOTLINK_MAKEHOME_ABORTED = "|cff00ff00LootLink: Home server was NOT confirmed and no changes will be made.|r";
LOOTLINK_MAKEHOME_DONE = "|cffffff00LootLink: Existing data that predated multiple server support was marked as seen on "..GetCVar("realmName")..". Multiple server support is fully enabled.|r";
LOOTLINK_LIGHTMODE_NEEDS_CONFIRM = "|cffff0000LootLink: Warning!  This will disable full-text search, losing known text for all items, but using less memory.  If you really want to do this, use /lootlink or /ll with the following command: "..LOOTLINK_LIGHTMODE.." "..LOOTLINK_CONFIRM.."|r";
LOOTLINK_LIGHTMODE_ABORTED = "|cff00ff00LootLink: Light mode was NOT confirmed and no changes will be made.|r";
LOOTLINK_LIGHTMODE_DONE = "|cffffff00LootLink: Light mode enabled.  Full-text search is disabled and memory is no longer used for item descriptions.|r";

LOOTLINK_STATUS_HEADER = "|cffffff00LootLink (version %.2f) status:|r";
LOOTLINK_DATA_VERSION = "LootLink: %d items known [%d on %s], data version %.2f";
LOOTLINK_INFO_HIDDEN = "LootLink: extra tooltip information hidden";
LOOTLINK_INFO_SHOWN = "LootLink: extra tooltip information shown";
LOOTLINK_FULL_MODE = "LootLink: full mode; full-text search is enabled";
LOOTLINK_LIGHT_MODE = "LootLink: light mode; full-text search is disabled";

LOOTLINK_HELP_TEXT0 = " ";
LOOTLINK_HELP_TEXT1 = "|cffffff00LootLink command help:|r";
LOOTLINK_HELP_TEXT2 = "|cff00ff00Use |r|cffffffff/lootlink|r|cff00ff00 or |r|cffffffff/ll|r|cff00ff00 without any arguments to toggle the browse window open or closed.|r";
LOOTLINK_HELP_TEXT3 = "|cff00ff00Use |r|cffffffff/lootlink <command>|r|cff00ff00 or |r|cffffffff/ll <command>|r|cff00ff00 to perform the following commands:|r";
LOOTLINK_HELP_TEXT4 = "|cffffffff"..LOOTLINK_HELP.."|r|cff00ff00: displays this message.|r";
LOOTLINK_HELP_TEXT5 = "|cffffffff"..LOOTLINK_STATUS.."|r|cff00ff00: displays status information for data and current options.|r";
LOOTLINK_HELP_TEXT6 = "|cffffffff"..LOOTLINK_AUCTION.."|r|cff00ff00 or |r|cffffffff"..LOOTLINK_SCAN.."|r|cff00ff00: starts or schedules an automatic scan of all items in the auction house.|r";
LOOTLINK_HELP_TEXT7 = "|cffffffff"..LOOTLINK_SHOWINFO.."|r|cff00ff00: shows extra information, including known sell prices, on all tooltips.|r";
LOOTLINK_HELP_TEXT8 = "|cffffffff"..LOOTLINK_HIDEINFO.."|r|cff00ff00: stops showing extra information on tooltips.|r";
LOOTLINK_HELP_TEXT9 = "|cffffffff"..LOOTLINK_FULLMODE.."|r|cff00ff00: enables full-text search. This is the default mode..|r";
LOOTLINK_HELP_TEXT10 = "|cffffffff"..LOOTLINK_LIGHTMODE.."|r|cff00ff00: disables full-text search, using less memory.|r";
LOOTLINK_HELP_TEXT11 = " ";
LOOTLINK_HELP_TEXT12 = "|cff00ff00For example: |r|cffffffff/lootlink scan|r|cff00ff00 will start an auction house scan if the auction window is open.|r";

LOOTLINK_DATA_UPGRADE_HELP_TEXT0 = "|cffffff00LootLink needs action from you to upgrade its data for full multiple server support.  Use one of the following commands to do so:|r";
LOOTLINK_DATA_UPGRADE_HELP_TEXT1 = "|cffffffff"..LOOTLINK_MAKEHOME.."|r|cff00ff00: makes the current server your home.  This will mark all existing items that predate multiple server support as having been seen on the current server.|r";
LOOTLINK_DATA_UPGRADE_HELP_TEXT2 = "|cffffffff"..LOOTLINK_RESET.."|r|cff00ff00: resets and wipes the existing database.  This is the safest thing to do if you've ever played on more than one server, but you will lose your existing data.|r";

LOOTLINK_DATA_UPGRADE_HELP = {
	{ version = 110, text = LOOTLINK_DATA_UPGRADE_HELP_TEXT0, },
	{ version = 110, text = LOOTLINK_DATA_UPGRADE_HELP_TEXT1, },
	{ version = 110, text = LOOTLINK_DATA_UPGRADE_HELP_TEXT2, },
};

LOOTLINK_MINIMAP_DRAG = "Drag to reposition";
LOOTLINK_MINIMAP_PROCESS_SHOW = "Right click to show progress bar";
LOOTLINK_MINIMAP_PROCESS_HIDE = "Right click to hide progress bar";

LOOTLINK_TOOLTIP_GENERATED = "Generated by LootLink from cached data";
LOOTLINK_TOOLTIP_BAD_ITEM = "Bad Item - linking could cause a disconnect";
LOOTLINK_TOOLTIP_SERVER = "Item not validated for this server";

LOOTLINK_STATICPOPUP_DELETE_ITEM_CONFIRM = "Are you sure you want to delete\n|c%s[%s]|r\nfrom Loot Link's database?";
LOOTLINK_STATICPOPUP_LITE_MODE_CONFIRM = "Warning!  This will disable full-text search, losing known text for all items, but using less memory."
LOOTLINK_STATICPOPUP_ITEM_CONFIRM = "%s %s  Are you sure you want to do this?";
	LOOTLINK_STATICPOPUP_SERVER = "This item has not been seen by you on this server.";
	LOOTLINK_STATICPOPUP_INVALID = "This item has not been seen by you recently.";
	LOOTLINK_STATICPOPUP_LINKITEM = "Attempting to link this item could cause a disconnect.";
	LOOTLINK_STATICPOPUP_DRESSUP = "Attempting to dress up with this item could cause a disconnect.";

LLS_TEXT = "All text:";
LLS_NAME = "Name:";
LLS_RARITY = "Rarity:";
LLS_SERVER = "On this server?";
LLS_BINDS = "Binds:";
LLS_UNIQUE = "Is Unique?";
LLS_USABLE = "Usable?";
LLS_SPOOF = "Is bad item?";
LLS_SET = "Set items?";
LLS_LOCATION = "Equip location:";
LLS_MINIMUM_LEVEL = "Minimum level:";
LLS_MAXIMUM_LEVEL = "Maximum level:";
LLS_TYPE = "Type:";
LLS_SUBTYPE_ARMOR = "Armor subtype:";
LLS_SUBTYPE_WEAPON = "Weapon subtype:";
LLS_SUBTYPE_SHIELD = "Shield subtype:";
LLS_SUBTYPE_RECIPE = "Recipe subtype:";
LLS_SUBTYPE_CONTAINER = "Container subtype:";
LLS_MINIMUM_DAMAGE = "Min. low damage:";
LLS_MAXIMUM_DAMAGE = "Min. high damage:";
LLS_MAXIMUM_SPEED = "Maximum speed:";
LLS_MINIMUM_DPS = "Minimum DPS:";
LLS_MINIMUM_ARMOR = "Minimum armor:";
LLS_MINIMUM_BLOCK = "Minimum block:";
LLS_MINIMUM_SLOTS = "Minimum slots:";
LLS_MINIMUM_SKILL = "Minimum skill:";
LLS_MAXIMUM_SKILL = "Maximum skill:";
LLS_TEXT_DISABLED = "(full-text search is disabled)";

LLO_MINIMAP_LABEL = "Minimap";
LLO_MINIMAP_HIDE = "Show minimap button";
LLO_MINIMAP_LOCK = "Lock minimap button";
LLO_MINIMAP_POS = "Minimap button position";
LLO_MINIMAP_OFFSET = "Minimap button offset";

LLO_SPOOF = "Don't allow bad items";
LLO_PURGE = "Purge";
LLO_FIX_LABEL = "Cached Data";
LLO_FIX = "Fix Cache";
LLO_GENERAL_LABEL = "General";
LLO_MOUSEOVER = "Inspect on mouseover";
LLO_SERVER = "Only show this server";
LLO_ENCHANTS = "Allow item enchants";
LLO_ICON = "Allow item icon";
LLO_RARITY_THRESHOLD = "Item rarity threshold"
LLO_VARIANT = "Allow item stat variants";
LLO_SAME_NAME = "Allow same name items";
LLO_LITE_MODE = "Enable lite mode";
LLO_EXTRA_INFO = "Show extra tooltip info";
LLO_TYPE_LINKS = "Enable type links";
LLO_AUTO_TYPE_LINKS = "Auto complete type links";

LLO_MINIMAP_X = 325;
LLO_MINIMAP_Y = 0;

LOOTLINK_SCHEDULE_DELAY = 2;

LLP_PURGE_LABEL = "Purging Filtered items"
LLP_PURGE_END = "|cffff0000LootLink: Finished purging filtered items.  Removed %u items out of %t.  Unable to validate %f items.";
LLP_PURGE_CANCEL = "|cffff0000LootLink: Cancelled purging of filtered items with %r items remaining.  Removed %u items out of %t.  Unable to validate %f items.";
LLP_FIXCACHE_LABEL = "Fixing Cached Data"
LLP_FIXCACHE_END = "|cffff0000LootLink: Finished fixing bad cached data.  Updated %u items out of %t.  Unable to update %f items.";
LLP_FIXCACHE_CANCEL = "|cffff0000LootLink: Cancelled fixing of bad cached data with %r items remaining.  Updated %u items out of %t.  Unable to update %f items.";

LLP_ABORT1 = "Aborted process : Out of memory!";
LLP_ABORT2 = "Please increase your script memory setting in the \"Addons\" menu";

LLHELP_MAIN = "Shift + Click to link an item in chat.\nCtrl + Click to see the item on your character\nShift + Ctrl + Right Click to delete the item from the database";
LLHELP_DISCONNECT = "Linking this item could cause a disconnect.";
LLHELP_SERVER = "This item not seen by you on this server yet. "..LLHELP_DISCONNECT;
LLHELP_INVALID = "This item is not valid. "..LLHELP_DISCONNECT;
LLHELP_NOTINLOCAL = "This item has not been seen recently. "..LLHELP_DISCONNECT;

ONLY = "Only";
ANY = "Any";
POOR = "Poor";
COMMON = "Common";
UNCOMMON = "Uncommon";
RARE = "Rare";
EPIC = "Epic";
LEGENDARY = "Legendary";
DOES_NOT = "Does Not";
ON_EQUIP = "On Equip";
ON_PICKUP = "On Pickup";
ON_USE = "On Use";
--ARMOR = "Armor"; -- already in globalstrings
WEAPON = "Weapon";
SHIELD = "Shield";
CONTAINER = "Container";
OTHER = "Other";
RECIPE = "Recipe";
CLOTH = "Cloth";
LEATHER = "Leather";
MAIL = "Mail";
PLATE = "Plate";
AXE = "Axe";
BOW = "Bow";
DAGGER = "Dagger";
MACE = "Mace";
STAFF = "Staff";
SWORD = "Sword";
GUN = "Gun";
WAND = "Wand";
POLEARM = "Polearm";
FIST_WEAPON = "Fist Weapon";
FISHING_POLE = "Fishing Pole";
UNARMED = "Unarmed";
CROSSBOW = "Crossbow";
THROWN = "Thrown";
BUCKLER = "Buckler";
ALCHEMY = "Alchemy";
BLACKSMITHING = "Blacksmithing";
COOKING = "Cooking";
ENCHANTING = "Enchanting";
ENGINEERING = "Engineering";
LEATHERWORKING = "Leatherworking";
TAILORING = "Tailoring";
FIRST_AID = "First Aid";
FISHING = "Fishing";
BAG = "Bag";
AMMO_POUCH = "Ammo Pouch";
QUIVER = "Quiver";
SOUL_BAG = "Soul Bag";
HERB_BAG = "Herb Bag";
ENCHANTING_BAG = "Enchanting Bag";
ENGINEERING_BAG = "Engineering Bag";
IDOL = "Idol";
LIBRAM = "Libram";
TOTEM = "Totem";
DURABILITY = "Durability";

-- Skills
PLATE_MAIL = "Plate Mail";
AXES = "Axes";
TWO_HANDED_AXES = "Two-Handed Axes";
BOWS = "Bows";
DAGGERS = "Daggers";
MACES = "Maces";
TWO_HANDED_MACES = "Two-Handed Maces";
STAVES = "Staves";
SWORDS = "Swords";
TWO_HANDED_SWORDS = "Two-Handed Swords";
GUNS = "Guns";
WANDS = "Wands";
POLEARMS = "Polearms";
CROSSBOWS = "Crossbows";

-- For sorting
SORT_NAME = "Name";
SORT_RARITY = "Rarity";
SORT_BINDS = "Binds";
SORT_UNIQUE = "Unique";
SORT_LOCATION = "Location";
SORT_TYPE = "Type";
SORT_SUBTYPE = "Subtype";
SORT_MINDAMAGE = "Min Damage";
SORT_MAXDAMAGE = "Max Damage";
SORT_SPEED = "Speed";
SORT_DPS = "DPS";
SORT_ARMOR = "Armor";
SORT_BLOCK = "Block";
SORT_SLOTS = "Slots";
SORT_LEVEL = "Level";
SORT_SKILL = "Skill Level";
SORT_SET = "Item Sets";
