--[[

	LootLink 3.5: An in-game item database
		copyright 2004 by Telo
	
	- Watches all chat links you see to cache link color and link data
	- Automatically extracts data from items already in or added to your inventory
	- Automatically caches link data from items already in or added to your bank
	- Automatically inspects your target and extracts data for each of their equipped items
	- Automatically gets link data from your auction queries
	- Can perform a fully automatic scan of the entire auction house inventory
	- Stores sell prices for items that you've had in inventory when you've talked to a merchant
	  and displays them in the tooltips for stacks of items that you are looting, stacks of items
	  in your inventory and entries in the LootLink browse window
	- Converts green loot messages into correctly colored item messages if the item is cached
	- Provides a browsable, searchable window that allows you to find any item in the cache
	- Allows you to shift-click items in the browse window to insert links in the chat edit box
	
]]

--------------------------------------------------------------------------------------------------
-- Local LootLink variables
--------------------------------------------------------------------------------------------------

-- Function hooks
local lOriginal_CanSendAuctionQuery;
local lOriginal_AuctionFrameBrowse_OnEvent;
local lOriginal_ContainerFrameItemButton_OnEnter;
local lOriginal_ContainerFrame_Update;
local lOriginal_GameTooltip_SetLootItem;
local lOriginal_GameTooltip_SetOwner;
local lOriginal_GameTooltip_OnHide;
local lOriginal_GameTooltip_ClearMoney;
local lOriginal_GameTooltip_ClearMoney_Temp;
local lOriginal_ShoppingTooltip1_SetMerchantCompareItem;
local lOriginal_ShoppingTooltip2_SetMerchantCompareItem;
local lOriginal_ShoppingTooltip1_SetAuctionCompareItem;
local lOriginal_ShoppingTooltip2_SetAuctionCompareItem;
local lOriginal_SetItemRef;
local lOriginal_OnTooltipAddMoney;

--local ll = {};

-- If non-nil, kick off a full auction scan next time auctioneer is used
local lScanAuction;

-- Used for scanning inventory items for their sell prices at a merchant
local lBagID;
local lSlotID;

-- If non-nil, don't add extra information to the tooltip on GameTooltip_ClearMoney
local lSuppressInfoAdd;

-- If non-nil, check for appearance of GameTooltip for adding information
local lCheckTooltip;

-- Timer for frequency of tooltip checks
local lCheckTimer = 0;

-- The current owner of the GameTooltip
local lGameToolTipOwner;

-- Cache of auction item information
local lAuctionItemInfo;

-- Used to remember that confirmation is needed of irreversible commands
local lResetNeedsConfirm;
local lMakeHomeNeedsConfirm;
local lLightModeNeedsConfirm;

-- If non-nil, the data version upgrade reminder is not displayed on every /lootlink or /ll command
local lDisableVersionReminder;

-- The current server name and index
local lServer;
local lServerIndex;

-- The number of items in the database, total and for this server
local lItemLinksSizeTotal;
local lItemLinksSizeServer;

local STATE_NAME = 0;
local STATE_BOUND = 1;
local STATE_UNIQUE = 2;
local STATE_LOCATION = 3;
local STATE_TYPE = 4;
local STATE_DAMAGE = 5;
local STATE_DPS = 6;
local STATE_ARMOR = 7;
local STATE_BLOCK = 8;
local STATE_CONTAINER = 9;
local STATE_REQUIRES = 10;
local STATE_FINISH = 11;
local STATE_SPACE = 12
local STATE_SET = 13;

local tooltipSpace = " "..string.char(10);

local BINDS_DOES_NOT_BIND = 0;
local BINDS_EQUIP = 1;
local BINDS_PICKUP = 2;
local BINDS_USED = 3;

local TYPE_ARMOR = 0;
local TYPE_WEAPON = 1;
local TYPE_SHIELD = 2;
local TYPE_RECIPE = 3;
local TYPE_CONTAINER = 4;
local TYPE_MISC = 5;

local SUBTYPE_ARMOR_CLOTH = 0;
local SUBTYPE_ARMOR_LEATHER = 1;
local SUBTYPE_ARMOR_MAIL = 2;
local SUBTYPE_ARMOR_PLATE = 3;
local SUBTYPE_ARMOR_RELIC = 4;

local lColorSortTable = { };
lColorSortTable["ffff8000"] = 1;	-- legendary, orange
lColorSortTable["ffa335ee"] = 2;	-- epic, purple
lColorSortTable["ff0070dd"] = 3;	-- rare, blue
lColorSortTable["ff1eff00"] = 4;	-- uncommon, green
lColorSortTable["ffffffff"] = 5;	-- common, white
lColorSortTable["ff9d9d9d"] = 6;	-- poor, gray
lColorSortTable["ff40ffc0"] = 100;	-- unknown, teal

local ArmorSubtypes = { };
ArmorSubtypes[CLOTH] = SUBTYPE_ARMOR_CLOTH;
ArmorSubtypes[LEATHER] = SUBTYPE_ARMOR_LEATHER;
ArmorSubtypes[MAIL] = SUBTYPE_ARMOR_MAIL;
ArmorSubtypes[PLATE] = SUBTYPE_ARMOR_PLATE;
ArmorSubtypes[INVTYPE_RELIC] = SUBTYPE_ARMOR_RELIC;

local SUBTYPE_WEAPON_AXE = 0;
local SUBTYPE_WEAPON_BOW = 1;
local SUBTYPE_WEAPON_DAGGER = 2;
local SUBTYPE_WEAPON_MACE = 3;
local SUBTYPE_WEAPON_FISHING_POLE = 4;
local SUBTYPE_WEAPON_STAFF = 5;
local SUBTYPE_WEAPON_SWORD = 6;
local SUBTYPE_WEAPON_GUN = 7;
local SUBTYPE_WEAPON_WAND = 8;
local SUBTYPE_WEAPON_THROWN = 9;
local SUBTYPE_WEAPON_POLEARM = 10;
local SUBTYPE_WEAPON_FIST_WEAPON = 11;
local SUBTYPE_WEAPON_CROSSBOW = 12;

local WeaponSubtypes = { };
WeaponSubtypes[AXE] = SUBTYPE_WEAPON_AXE;
WeaponSubtypes[BOW] = SUBTYPE_WEAPON_BOW;
WeaponSubtypes[DAGGER] = SUBTYPE_WEAPON_DAGGER;
WeaponSubtypes[MACE] = SUBTYPE_WEAPON_MACE;
WeaponSubtypes[FISHING_POLE] = SUBTYPE_WEAPON_FISHING_POLE;
WeaponSubtypes[STAFF] = SUBTYPE_WEAPON_STAFF;
WeaponSubtypes[SWORD] = SUBTYPE_WEAPON_SWORD;
WeaponSubtypes[GUN] = SUBTYPE_WEAPON_GUN;
WeaponSubtypes[WAND] = SUBTYPE_WEAPON_WAND;
WeaponSubtypes[THROWN] = SUBTYPE_WEAPON_THROWN;
WeaponSubtypes[POLEARM] = SUBTYPE_WEAPON_POLEARM;
WeaponSubtypes[FIST_WEAPON] = SUBTYPE_WEAPON_FIST_WEAPON;
WeaponSubtypes[CROSSBOW] = SUBTYPE_WEAPON_CROSSBOW;

local SUBTYPE_SHIELD_BUCKLER = 0;
local SUBTYPE_SHIELD_SHIELD = 1;

local ShieldSubtypes = { };
ShieldSubtypes["Buckler"] = SUBTYPE_SHIELD_BUCKLER;
ShieldSubtypes[SHIELD] = SUBTYPE_SHIELD_SHIELD;

local SUBTYPE_RECIPE_ALCHEMY = 0;
local SUBTYPE_RECIPE_BLACKSMITHING = 1;
local SUBTYPE_RECIPE_COOKING = 2;
local SUBTYPE_RECIPE_ENCHANTING = 3;
local SUBTYPE_RECIPE_ENGINEERING = 4;
local SUBTYPE_RECIPE_LEATHERWORKING = 5;
local SUBTYPE_RECIPE_TAILORING = 6;
local SUBTYPE_RECIPE_FIRST_AID = 7;
local SUBTYPE_RECIPE_FISHING = 8;

local RecipeSubtypes = { };
RecipeSubtypes[ALCHEMY] = SUBTYPE_RECIPE_ALCHEMY;
RecipeSubtypes[BLACKSMITHING] = SUBTYPE_RECIPE_BLACKSMITHING;
RecipeSubtypes[COOKING] = SUBTYPE_RECIPE_COOKING;
RecipeSubtypes[ENCHANTING] = SUBTYPE_RECIPE_ENCHANTING;
RecipeSubtypes[ENGINEERING] = SUBTYPE_RECIPE_ENGINEERING;
RecipeSubtypes[LEATHERWORKING] = SUBTYPE_RECIPE_LEATHERWORKING;
RecipeSubtypes[TAILORING] = SUBTYPE_RECIPE_TAILORING;
RecipeSubtypes[FIRST_AID] = SUBTYPE_RECIPE_FIRST_AID;
RecipeSubtypes[FISHING] = SUBTYPE_RECIPE_FISHING;

local SUBTYPE_CONTAINER_BAG = 0;
local SUBTYPE_CONTAINER_AMMO_POUCH = 1;
local SUBTYPE_CONTAINER_QUIVER = 2;
local SUBTYPE_CONTAINER_SOUL_BAG = 3;
local SUBTYPE_CONTAINER_HERB_BAG = 4;
local SUBTYPE_CONTAINER_ENCHANTING_BAG = 5;
local SUBTYPE_CONTAINER_ENGINEERING_BAG = 6;

local ContainerSubtypes = { };
ContainerSubtypes[BAG] = SUBTYPE_CONTAINER_BAG;
ContainerSubtypes[AMMO_POUCH] = SUBTYPE_CONTAINER_AMMO_POUCH;
ContainerSubtypes[QUIVER] = SUBTYPE_CONTAINER_QUIVER;
ContainerSubtypes[SOUL_BAG] = SUBTYPE_CONTAINER_SOUL_BAG;
ContainerSubtypes[HERB_BAG] = SUBTYPE_CONTAINER_HERB_BAG;
ContainerSubtypes[ENCHANTING_BAG] = SUBTYPE_CONTAINER_ENCHANTING_BAG;
ContainerSubtypes[ENGINEERING_BAG] = SUBTYPE_CONTAINER_ENGINEERING_BAG;

local lTypeAndSubtypeToSkill = { };
lTypeAndSubtypeToSkill[TYPE_ARMOR] = { };
lTypeAndSubtypeToSkill[TYPE_ARMOR][SUBTYPE_ARMOR_CLOTH] = CLOTH;
lTypeAndSubtypeToSkill[TYPE_ARMOR][SUBTYPE_ARMOR_LEATHER] = LEATHER;
lTypeAndSubtypeToSkill[TYPE_ARMOR][SUBTYPE_ARMOR_MAIL] = MAIL;
lTypeAndSubtypeToSkill[TYPE_ARMOR][SUBTYPE_ARMOR_PLATE] = PLATE_MAIL;
lTypeAndSubtypeToSkill[TYPE_ARMOR][SUBTYPE_ARMOR_RELIC] = INVTYPE_RELIC;
lTypeAndSubtypeToSkill[TYPE_WEAPON] = { };
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_AXE] = { }
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_AXE][0] = AXES;
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_AXE][1] = TWO_HANDED_AXES;
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_BOW] = BOWS;
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_DAGGER] = DAGGERS;
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_MACE] = { }
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_MACE][0] = MACES;
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_MACE][1] = TWO_HANDED_MACES;
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_FISHING_POLE] = FISHING_POLE;
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_STAFF] = STAVES;
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_SWORD] = { };
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_SWORD][0] = SWORDS;
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_SWORD][1] = TWO_HANDED_SWORDS;
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_GUN] = GUNS;
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_WAND] = WANDS;
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_THROWN] = THROWN;
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_POLEARM] = POLEARMS;		--@todo Telo: unconfirmed
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_FIST_WEAPON] = UNARMED;
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_CROSSBOW] = CROSSBOWS;
lTypeAndSubtypeToSkill[TYPE_SHIELD] = { };
lTypeAndSubtypeToSkill[TYPE_SHIELD][SUBTYPE_SHIELD_BUCKLER] = SHIELD;			--@todo Telo: deprecated subtype, should remove
lTypeAndSubtypeToSkill[TYPE_SHIELD][SUBTYPE_SHIELD_SHIELD] = SHIELD;
lTypeAndSubtypeToSkill[TYPE_RECIPE] = { };
lTypeAndSubtypeToSkill[TYPE_RECIPE][SUBTYPE_RECIPE_ALCHEMY] = ALCHEMY;
lTypeAndSubtypeToSkill[TYPE_RECIPE][SUBTYPE_RECIPE_BLACKSMITHING] = BLACKSMITHING;
lTypeAndSubtypeToSkill[TYPE_RECIPE][SUBTYPE_RECIPE_COOKING] = COOKING;
lTypeAndSubtypeToSkill[TYPE_RECIPE][SUBTYPE_RECIPE_ENCHANTING] = ENCHANTING;
lTypeAndSubtypeToSkill[TYPE_RECIPE][SUBTYPE_RECIPE_ENGINEERING] = ENGINEERING;
lTypeAndSubtypeToSkill[TYPE_RECIPE][SUBTYPE_RECIPE_LEATHERWORKING] = LEATHERWORKING;
lTypeAndSubtypeToSkill[TYPE_RECIPE][SUBTYPE_RECIPE_TAILORING] = TAILORING;
lTypeAndSubtypeToSkill[TYPE_RECIPE][SUBTYPE_RECIPE_FIRST_AID] = FIRST_AID;
lTypeAndSubtypeToSkill[TYPE_RECIPE][SUBTYPE_RECIPE_FISHING] = FISHING;
lTypeAndSubtypeToSkill[TYPE_CONTAINER] = { };
lTypeAndSubtypeToSkill[TYPE_CONTAINER][SUBTYPE_CONTAINER_BAG] = BAG;
lTypeAndSubtypeToSkill[TYPE_CONTAINER][SUBTYPE_CONTAINER_AMMO_POUCH] = AMMO_POUCH;
lTypeAndSubtypeToSkill[TYPE_CONTAINER][SUBTYPE_CONTAINER_QUIVER] = QUIVER;
lTypeAndSubtypeToSkill[TYPE_CONTAINER][SUBTYPE_CONTAINER_SOUL_BAG] = SOUL_BAG;
lTypeAndSubtypeToSkill[TYPE_CONTAINER][SUBTYPE_CONTAINER_ENCHANTING_BAG] = ENCHANTING_BAG;

local LocationTypes = { };
LocationTypes[INVTYPE_HOLDABLE]		= { i = 0, type = TYPE_MISC };
LocationTypes[INVTYPE_CLOAK]		= { i = 1, type = TYPE_ARMOR, subtypes = ArmorSubtypes };
LocationTypes[INVTYPE_WEAPON]		= { i = 2, type = TYPE_WEAPON, subtypes = WeaponSubtypes };
LocationTypes[INVTYPE_2HWEAPON]		= { i = 3, type = TYPE_WEAPON, subtypes = WeaponSubtypes };
LocationTypes[INVTYPE_WEAPONOFFHAND]	= { i = 4, type = TYPE_SHIELD, subtypes = ShieldSubtypes };
LocationTypes[INVTYPE_WRIST]		= { i = 5, type = TYPE_ARMOR, subtypes = ArmorSubtypes };
LocationTypes[INVTYPE_CHEST]		= { i = 6, type = TYPE_ARMOR, subtypes = ArmorSubtypes };
LocationTypes[INVTYPE_LEGS]		= { i = 7, type = TYPE_ARMOR, subtypes = ArmorSubtypes };
LocationTypes[INVTYPE_FEET]		= { i = 8, type = TYPE_ARMOR, subtypes = ArmorSubtypes };
LocationTypes[INVTYPE_BODY]		= { i = 9, type = TYPE_MISC };
LocationTypes[INVTYPE_RANGED]		= { i = 10, type = TYPE_WEAPON, subtypes = WeaponSubtypes };
LocationTypes[INVTYPE_WEAPONMAINHAND]	= { i = 11, type = TYPE_WEAPON, subtypes = WeaponSubtypes };
LocationTypes[INVTYPE_WAIST]		= { i = 12, type = TYPE_ARMOR, subtypes = ArmorSubtypes };
LocationTypes[INVTYPE_HEAD]		= { i = 13, type = TYPE_ARMOR, subtypes = ArmorSubtypes };
LocationTypes[GUN]			= { i = 14, type = TYPE_WEAPON, subtype = SUBTYPE_WEAPON_GUN };
LocationTypes[INVTYPE_FINGER]		= { i = 15, type = TYPE_MISC };
LocationTypes[INVTYPE_HAND]		= { i = 16, type = TYPE_ARMOR, subtypes = ArmorSubtypes };
LocationTypes[INVTYPE_SHOULDER]		= { i = 17, type = TYPE_ARMOR, subtypes = ArmorSubtypes };
LocationTypes[WAND]			= { i = 18, type = TYPE_WEAPON, subtype = SUBTYPE_WEAPON_WAND };
LocationTypes[INVTYPE_TRINKET]		= { i = 19, type = TYPE_MISC };
LocationTypes[INVTYPE_TABARD]		= { i = 20, type = TYPE_MISC };
LocationTypes[INVTYPE_NECK]		= { i = 21, type = TYPE_MISC };
LocationTypes[THROWN]			= { i = 22, type = TYPE_WEAPON, subtype = SUBTYPE_WEAPON_THROWN };
LocationTypes[CROSSBOW]			= { i = 23, type = TYPE_WEAPON, subtype = SUBTYPE_WEAPON_CROSSBOW };
LocationTypes[INVTYPE_RELIC]		= { i = 24, type = TYPE_ARMOR, subtype = SUBTYPE_ARMOR_RELIC };

local INVENTORY_SLOT_LIST = {
	{ name = "HeadSlot" },
	{ name = "NeckSlot" },
	{ name = "ShoulderSlot" },
	{ name = "BackSlot" },
	{ name = "ChestSlot" },
	{ name = "ShirtSlot" },
	{ name = "TabardSlot" },
	{ name = "WristSlot" },
	{ name = "HandsSlot" },
	{ name = "WaistSlot" },
	{ name = "LegsSlot" },
	{ name = "FeetSlot" },
	{ name = "Finger0Slot" },
	{ name = "Finger1Slot" },
	{ name = "Trinket0Slot" },
	{ name = "Trinket1Slot" },
	{ name = "MainHandSlot" },
	{ name = "SecondaryHandSlot" },
	{ name = "RangedSlot" },
};

local ChatMessageTypes = {
	"CHAT_MSG_SYSTEM",
	"CHAT_MSG_SAY",
	"CHAT_MSG_TEXT_EMOTE",
	"CHAT_MSG_YELL",
	"CHAT_MSG_WHISPER",
	"CHAT_MSG_PARTY",
	"CHAT_MSG_GUILD",
	"CHAT_MSG_OFFICER",
	"CHAT_MSG_CHANNEL",
	"CHAT_MSG_RAID",
	"CHAT_MSG_LOOT",
};

local LOOTLINK_DROPDOWN_LIST = {
	{ name = SORT_NAME, sortType = "name" },
	{ name = SORT_RARITY, sortType = "rarity" },
	{ name = SORT_LOCATION, sortType = "location" },
	{ name = SORT_TYPE, sortType = "type" },
	{ name = SORT_SUBTYPE, sortType = "subtype" },
	{ name = SORT_LEVEL, sortType = "level" },
	{ name = SORT_BINDS, sortType = "binds" },
	{ name = SORT_UNIQUE, sortType = "unique" },
	{ name = SORT_ARMOR, sortType = "armor" },
	{ name = SORT_BLOCK, sortType = "block" },
	{ name = SORT_MINDAMAGE, sortType = "minDamage" },
	{ name = SORT_MAXDAMAGE, sortType = "maxDamage" },
	{ name = SORT_DPS, sortType = "DPS" },
	{ name = SORT_SPEED, sortType = "speed" },
	{ name = SORT_SLOTS, sortType = "slots" },
	{ name = SORT_SKILL, sortType = "skill" },
	{ name = SORT_SET, sortType = "set" },
};

local LLS_RARITY_LIST = {
	{ name = ANY, value = nil },
	{ name = UNKNOWN, value = "ff40ffc0", r = 64 / 255, g = 255 / 255, b = 192 / 255 },
	{ name = POOR, value = "ff9d9d9d", r = 157 / 255, g = 157 / 255, b = 157 / 255 },
	{ name = COMMON, value = "ffffffff", r = 1, g = 1, b = 1 },
	{ name = UNCOMMON, value = "ff1eff00", r = 30 / 255, g = 1, b = 0 },
	{ name = RARE, value = "ff0070dd", r = 0, g = 70 / 255, b = 221 / 255 },
	{ name = EPIC, value = "ffa335ee", r = 163 / 255, g = 53 / 255, b = 238 / 255 },
	{ name = LEGENDARY, value = "ffff8000", r = 1, g = 128 / 255, b = 0 },
};

local LLS_BINDS_LIST = {
	{ name = ANY, value = nil },
	{ name = DOES_NOT, value = BINDS_DOES_NOT_BIND },
	{ name = ON_EQUIP, value = BINDS_EQUIP },
	{ name = ON_PICKUP, value = BINDS_PICKUP },
	{ name = ON_USE, value = BINDS_USE },
};

local LLS_TYPE_LIST = {
	{ name = ANY, value = nil },
	{ name = ARMOR, value = TYPE_ARMOR },
	{ name = CONTAINER, value = TYPE_CONTAINER },
	{ name = OTHER, value = TYPE_MISC },
	{ name = RECIPE, value = TYPE_RECIPE },
	{ name = SHIELD, value = TYPE_SHIELD },
	{ name = WEAPON, value = TYPE_WEAPON },
};

local LLS_SUBTYPE_ARMOR_LIST = {
	{ name = ANY, value = nil },
	{ name = CLOTH, value = SUBTYPE_ARMOR_CLOTH },
	{ name = LEATHER, value = SUBTYPE_ARMOR_LEATHER },
	{ name = MAIL, value = SUBTYPE_ARMOR_MAIL },
	{ name = PLATE, value = SUBTYPE_ARMOR_PLATE },
	{ name = INVTYPE_RELIC, value = SUBTYPE_ARMOR_RELIC },
};

local LLS_SUBTYPE_WEAPON_LIST = {
	{ name = ANY, value = nil },
	{ name = AXE, value = SUBTYPE_WEAPON_AXE },
	{ name = BOW, value = SUBTYPE_WEAPON_BOW },
	{ name = CROSSBOW, value = SUBTYPE_WEAPON_CROSSBOW },
	{ name = DAGGER, value = SUBTYPE_WEAPON_DAGGER },
	{ name = FISHING_POLE, value = SUBTYPE_WEAPON_FISHING_POLE },
	{ name = FIST_WEAPON, value = SUBTYPE_WEAPON_FIST_WEAPON },
	{ name = GUN, value = SUBTYPE_WEAPON_GUN },
	{ name = MACE, value = SUBTYPE_WEAPON_MACE },
	{ name = POLEARM, value = SUBTYPE_WEAPON_POLEARM },
	{ name = STAFF, value = SUBTYPE_WEAPON_STAFF },
	{ name = SWORD, value = SUBTYPE_WEAPON_SWORD },
	{ name = THROWN, value = SUBTYPE_WEAPON_THROWN },
	{ name = WAND, value = SUBTYPE_WEAPON_WAND },
};

local LLS_SUBTYPE_SHIELD_LIST = {
	{ name = ANY, value = nil },
	{ name = BUCKLER, value = SUBTYPE_SHIELD_BUCKLER },
	{ name = SHIELD, value = SUBTYPE_SHIELD_SHIELD },
};

local LLS_SUBTYPE_RECIPE_LIST = {
	{ name = ANY, value = nil },
	{ name = ALCHEMY, value = SUBTYPE_RECIPE_ALCHEMY },
	{ name = BLACKSMITHING, value = SUBTYPE_RECIPE_BLACKSMITHING },
	{ name = COOKING, value = SUBTYPE_RECIPE_COOKING },
	{ name = ENCHANTING, value = SUBTYPE_RECIPE_ENCHANTING },
	{ name = ENGINEERING, value = SUBTYPE_RECIPE_ENGINEERING },
	{ name = LEATHERWORKING, value = SUBTYPE_RECIPE_LEATHERWORKING },
	{ name = TAILORING, value = SUBTYPE_RECIPE_TAILORING },
};

local LLS_SUBTYPE_CONTAINER_LIST = {
	{ name = ANY, value = nil },
	{ name = BAG, value = SUBTYPE_CONTAINER_BAG },
	{ name = AMMO_POUCH, value = SUBTYPE_CONTAINER_AMMO_POUCH },
	{ name = QUIVER, value = SUBTYPE_CONTAINER_QUIVER },
	{ name = ENCHANTING_BAG, value = SUBTYPE_CONTAINER_ENCHANTING_BAG },
	{ name = ENGINEERING_BAG, value = SUBTYPE_CONTAINER_ENGINEERING_BAG },
	{ name = HERB_BAG, value = SUBTYPE_CONTAINER_HERB_BAG },
	{ name = SOUL_BAG, value = SUBTYPE_CONTAINER_SOUL_BAG },
};

local LLS_LOCATION_LIST = {
	{ name = ANY, },
	{ name = NONE, },
	{ name = INVTYPE_CLOAK, },
	{ name = INVTYPE_CHEST, },
	{ name = CROSSBOW, },
	{ name = INVTYPE_FEET, },
	{ name = INVTYPE_FINGER, },
	{ name = INVTYPE_HAND, },
	{ name = INVTYPE_HEAD, },
	{ name = INVTYPE_HOLDABLE, },
	{ name = GUN, },
	{ name = INVTYPE_LEGS, },
	{ name = INVTYPE_WEAPONMAINHAND, },
	{ name = INVTYPE_NECK, },
	{ name = INVTYPE_WEAPONOFFHAND, },
	{ name = INVTYPE_WEAPON, },
	{ name = INVTYPE_RANGED, },
	{ name = INVTYPE_BODY, },
	{ name = INVTYPE_SHOULDER, },
	{ name = INVTYPE_TABARD, },
	{ name = THROWN, },
	{ name = INVTYPE_TRINKET, },
	{ name = INVTYPE_2HWEAPON, },
	{ name = INVTYPE_WAIST, },
	{ name = WAND, },
	{ name = INVTYPE_WRIST, },
};

local LLS_EXTRA_LIST = {
	{ name = ALL, },
	{ name = ONLY, },
	{ name = NONE, },
};

local LLO_RARITY_LIST = {
	{ name = NONE },
	{ name = "|cff9d9d9d"..POOR },
	{ name = "|cffffffff"..COMMON },
	{ name = "|cff1eff00"..UNCOMMON },
	{ name = "|cff0070dd"..RARE },
	{ name = "|cffa335ee"..EPIC },
	{ name = "|cffff8000"..LEGENDARY },
};

local lMagicCharacters = { };
lMagicCharacters["^"] = 1;
lMagicCharacters["$"] = 1;
lMagicCharacters["("] = 1;
lMagicCharacters[")"] = 1;
lMagicCharacters["%"] = 1;
lMagicCharacters["."] = 1;
lMagicCharacters["["] = 1;
lMagicCharacters["]"] = 1;
lMagicCharacters["*"] = 1;
lMagicCharacters["+"] = 1;
lMagicCharacters["-"] = 1;
lMagicCharacters["?"] = 1;

local lBankBagIDs = { BANK_CONTAINER, 5, 6, 7, 8, 9, 10, };
	
-- Item types that can't have enchants or "of" stat bonuses
local lNoBonuses = {
	[""] = 2,
	["INVTYPE_TRINKET"] = 2,
	["INVTYPE_AMMO"] = 2,
	["INVTYPE_THROWN"] = 2,
	["INVTYPE_BAG"] = 2,
	["INVTYPE_TABARD"] = 2,
	["INVTYPE_BODY"] = 2,
	["INVTYPE_HOLDABLE"] = 1,
	["INVTYPE_FINGER"] = 1,
	["INVTYPE_WAIST"] = 1,
}

local lRarityFilter = {
	ff40ffc0 = -1,
	ff9d9d9d = 0,
	ffffffff = 1,
	ff1eff00 = 2,
	ff0070dd = 3,
	ffa335ee = 4,
	ffff8000 = 5,
};

--------------------------------------------------------------------------------------------------
-- Global LootLink variables
--------------------------------------------------------------------------------------------------

LOOTLINK_VERSION = 350;	-- version 3.50

LOOTLINK_ITEM_HEIGHT = 16;
LOOTLINK_ITEMS_SHOWN = 22;

UIPanelWindows["LootLinkFrame"] =		{ area = "left",	pushable = 11,	whileDead = 1 };
UIPanelWindows["LootLinkSearchFrame"] =		{ area = "center",	pushable = 0,	whileDead = 1 };
UIPanelWindows["LootLinkOptionsFrame"] =	{ area = "center",	pushable = 0,	whileDead = 1 };

--------------------------------------------------------------------------------------------------
-- Internal functions
--------------------------------------------------------------------------------------------------

--
-- Functions with no other functional dependencies
--

local function LootLink_MakeIntFromHexString(str)
	local remain = str;
	local amount = 0;
	while( remain ~= "" ) do
		amount = amount * 16;
		local byteVal = string.byte(strupper(strsub(remain, 1, 1)));
		if( byteVal >= string.byte("0") and byteVal <= string.byte("9") ) then
			amount = amount + (byteVal - string.byte("0"));
		elseif( byteVal >= string.byte("A") and byteVal <= string.byte("F") ) then
			amount = amount + 10 + (byteVal - string.byte("A"));
		end
		remain = strsub(remain, 2);
	end
	return amount;
end

local function LootLink_GetRGBFromHexColor(hexColor)
	local red = LootLink_MakeIntFromHexString(strsub(hexColor, 3, 4)) / 255;
	local green = LootLink_MakeIntFromHexString(strsub(hexColor, 5, 6)) / 255;
	local blue = LootLink_MakeIntFromHexString(strsub(hexColor, 7, 8)) / 255;
	return red, green, blue;
end

local function LootLink_MouseIsOver(frame)
	local x, y = GetCursorPosition();
	
	if( not frame ) then
		return nil;
	end
	
	x = x / frame:GetEffectiveScale();
	y = y / frame:GetEffectiveScale();

	local left = frame:GetLeft();
	local right = frame:GetRight();
	local top = frame:GetTop();
	local bottom = frame:GetBottom();
	
	if( not left or not right or not top or not bottom ) then
		return nil;
	end
	
	if( (x > left and x < right) and (y > bottom and y < top) ) then
		return 1;
	else
		return nil;
	end
end

local function LootLink_GetDataVersion()
	if( not LootLinkState or not LootLinkState.DataVersion ) then
		return 0;
	end
	return LootLinkState.DataVersion;
end

local function LootLink_SetDataVersion(version)
	if( not LootLinkState ) then
		LootLinkState = { };
	end
	if( not LootLinkState.DataVersion or LootLinkState.DataVersion < version ) then
		LootLinkState.DataVersion = version;
	end
end

local function LootLink_AddServer(name)
	if( not LootLinkState ) then
		LootLinkState = { };
	end
	
	if( not LootLinkState.Servers ) then
		LootLinkState.Servers = 0;
		LootLinkState.ServerNamesToIndices = { };
	end
	
	if( not LootLinkState.ServerNamesToIndices[name] ) then
		LootLinkState.ServerNamesToIndices[name] = LootLinkState.Servers;
		LootLinkState.Servers = LootLinkState.Servers + 1;
	end
	
	return LootLinkState.ServerNamesToIndices[name];
end

local function LootLink_ConvertServerFormat(item)
	if( item.servers ) then
		local i, v;
		local list;
		for i, v in item.servers do
			if( not list ) then
				list = TEXT(i);
			else
				list = list.." "..i;
			end
		end
		item.s = list;
		item.servers = nil;
	end
end

local function LootLink_CheckItemServerRaw(item, serverIndex)
	if( not item.s ) then
		return nil;
	end
	
	local server;
	for server in string.gfind(item.s, "(%d+)") do
		if( tonumber(server) == serverIndex ) then
			return 1;
		end
	end

	return nil;
end

local function LootLink_AddItemServer(item, serverIndex)
	if( not item.s ) then
		item.s = TEXT(serverIndex);
	elseif( not LootLink_CheckItemServerRaw(item, serverIndex) ) then
		item.s = item.s.." "..serverIndex;
	end
end

local function LootLink_EscapeString(string)
	return string.gsub(string, "\"", "\\\"");
end

local function LootLink_UnescapeString(string)
	return string.gsub(string, "\\\"", "\"");
end

local function LootLink_EscapePattern(string)
	local result = "";
	local remain = string;
	local char;
	
	while( remain ~= "" ) do
		char = strsub(remain, 1, 1);
		if( lMagicCharacters[char] ) then
			result = result.."%"..char;
		else
			result = result..char;
		end
		remain = strsub(remain, 2);
	end
	
	return result;
end

local function LootLink_CheckNumeric(string)
	local remain = string;
	local hasNumber;
	local hasPeriod;
	local char;
	
	while( remain ~= "" ) do
		char = strsub(remain, 1, 1);
		if( char >= "0" and char <= "9" ) then
			hasNumber = 1;
		elseif( char == "." and not hasPeriod ) then
			hasPeriod = 1;
		else
			return nil;
		end
		remain = strsub(remain, 2);
	end
	
	return hasNumber;
end

local function LootLink_NameFromLink(link)
	local name;
	if( not link ) then
		return nil;
	end
	for name in string.gfind(link, "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[(.-)%]|h|r") do
		return name;
	end
	return nil;
end

function LootLink_MoneyToggle(force)
	if( lOriginal_GameTooltip_ClearMoney_Temp ) then
		GameTooltip_ClearMoney = lOriginal_GameTooltip_ClearMoney_Temp;
		lOriginal_GameTooltip_ClearMoney_Temp = nil;
	elseif ( not force ) then
		lOriginal_GameTooltip_ClearMoney_Temp = GameTooltip_ClearMoney;
		GameTooltip_ClearMoney = LootLink_GameTooltip_ClearMoney_Temp;
	else
		DEFAULT_CHAT_FRAME:AddMessage( "LootLink_MoneyToggle just tried to break?" );
	end
end

local function LootLink_MatchType(left, right)
	local lt = LocationTypes[left];
	local _type;
	local subtype;
	
	if( lt ) then
		local subtypes;
		
		-- Check for weapon override of base type
		if( WeaponSubtypes[right] ) then
			_type = TYPE_WEAPON;
			subtypes = WeaponSubtypes;
		else
			_type = lt.type;
			subtypes = lt.subtypes;
		end
		
		if( subtypes ) then
			subtype = subtypes[right];
		else
			subtype = lt.subtype;
		end
		return nil, lt.i, _type, subtype;
	end
	
	return 1, nil, TYPE_MISC, nil;
end

local function LootLink_HideTooltipMoney()
	LootLinkTooltipMoneyFrame:SetPoint("LEFT", "LootLinkTooltipTextLeft1", "LEFT", 0, 0);
	LootLinkTooltipMoneyFrame:Hide();
end

local function LootLink_SetTooltipMoney(frame, count, money, stack)
	if( count and count > 1 ) then
		money = money * count;
		frame:AddLine(format(LOOTLINK_SELL_PRICE_N, count), 1.0, 1.0, 1.0);
	elseif( stack ) then
		frame:AddLine(LOOTLINK_SELL_PRICE_EACH, 1.0, 1.0, 1.0);
	else
		frame:AddLine(LOOTLINK_SELL_PRICE, 1.0, 1.0, 1.0);
	end
	
	local numLines = frame:NumLines();
	local moneyFrame = getglobal(frame:GetName().."MoneyFrame");
	local newLine = frame:GetName().."TextLeft"..numLines;
	
	moneyFrame:SetPoint("LEFT", newLine, "RIGHT", 4, 0);
	moneyFrame:Show();
	MoneyFrame_Update(moneyFrame:GetName(), money);
	frame:SetMinimumWidth(moneyFrame:GetWidth() + getglobal(newLine):GetWidth() - 10);
end

local function LL_SearchData(item, tag)
	if( item.d ) then
		local s, e;
		local value;

		s, e, value = string.find(item.d, tag.."(.-)·")
		if( value ) then
			return tonumber(value);
		end
	end
	return nil;
end

--
-- Functions that are dependent on preceding local functions, ordered appropriately
--

local function LootLink_GetName( elem )
	if ( type(elem) == "table" ) then
		return elem[1], elem[2];
	else
		return elem;
	end
end

local function LootLink_GetValue( elem, index, link )
	local name;
	if ( type(elem) == "table" ) then
		index = elem[2];
		elem = elem[1];
	end
	if ( link and ItemLinks[elem] and ItemLinks[elem].i ~= link ) then
		if ( ItemLinks[elem].m ) then
			for k, v in ItemLinks[elem].m do
				if v.i == link then
					index = k;
					break;
				end
			end
			if ( not index ) then
				--DEFAULT_CHAT_FRAME:AddMessage( elem.." "..link.." doesn't appear to exist yet?" );
				return nil;
			end
		end
	end
	if ( index and ItemLinks[elem] and ItemLinks[elem].m ) then
		return ItemLinks[elem].m[index], index;
	elseif ( ItemLinks[elem] ) then
		return ItemLinks[elem];
	else
		return nil;
	end
end

local function LootLink_InitSizes(serverIndex)
	local index;
	local value;

	lItemLinksSizeTotal = 0;
	lItemLinksSizeServer = 0;
	
	for index, value in ItemLinks do
		lItemLinksSizeTotal = lItemLinksSizeTotal + 1;
		if( LootLink_CheckItemServer(value, serverIndex) ) then
			lItemLinksSizeServer = lItemLinksSizeServer + 1;
		end
	end
end

local function LootLink_GetSize(serverIndex)
	if( not serverIndex ) then
		return lItemLinksSizeTotal;
	end
	return lItemLinksSizeServer;
end

local function LootLink_Status()
	DEFAULT_CHAT_FRAME:AddMessage(format(LOOTLINK_STATUS_HEADER, LOOTLINK_VERSION / 100));
	if( LootLinkState ) then
		DEFAULT_CHAT_FRAME:AddMessage(format(LOOTLINK_DATA_VERSION, LootLink_GetSize(), LootLink_GetSize(lServerIndex), lServer, LootLink_GetDataVersion() / 100));
		if( LootLinkState.HideInfo ) then
			DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_INFO_HIDDEN);
		else
			DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_INFO_SHOWN);
		end
		if( LootLinkState.LightMode ) then
			DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_LIGHT_MODE);
		else
			DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_FULL_MODE);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_INFO_SHOWN);
	end
	if( lScanAuction ) then
		DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_SCHEDULED_AUCTION_SCAN);
	end
end

local function LootLink_GetHyperlink(name, index)
	local itemLink = LootLink_GetValue( name, index );
	if( itemLink and itemLink.i --[[and LootLink_CheckItemServer(itemLink, lServerIndex)]] ) then
		-- Remove instance-specific data that we captured from the link we return
		local item = string.gsub(itemLink.i, "(%d+):(%d+):(%d+):(%d+)", "%1:%2:%3:0");
		return "item:"..item;
	end
	return nil;
end

local function LootLink_GetLink(name, index)
	local itemLink = LootLink_GetValue(name, index);
	if( itemLink and itemLink.c and itemLink.i --[[and (IsAltKeyDown() or LootLink_CheckItemServer(itemLink, lServerIndex))]] ) then
		local link = "|c"..itemLink.c.."|H"..LootLink_GetHyperlink(name, index).."|h["..name.."]|h|r";
		return link;
	end
	return nil;
end

local function LootLink_GetSet(set)
	if ( not LootLinkState.sets ) then
		LootLinkState.sets = {}
	end
	local sets = LootLinkState.sets;
	for k, v in sets do
		if ( v == set ) then
			return k;
		end
	end
	tinsert(sets, set);
	return getn(sets);
end

function LootLink_BuildSearchData(name, value, alternate)
	local state, itemLink, loop, index, field, left, right, iStart, iEnd, val1, val2, val3, foundRequires, _type, subtype = STATE_NAME, LootLink_GetHyperlink(name, alternate);
	
	if( not itemLink ) then
		return nil;
	end
	
	-- This is the only place the tooltip hyperlink is set directly, therefore
	-- this should only be called when we know that the tooltip will be valid

	-- Protect money frame while we set hidden tooltip
	LootLink_MoneyToggle();
	LLHiddenTooltip:SetOwner(WorldFrame,"ANCHOR_NONE");
	LLHiddenTooltip:SetHyperlink(itemLink);
	LootLink_MoneyToggle(1);
	
	-- Double check that the data is good
	local realname, link, quality, level, _, _, _, count = GetItemInfo(itemLink);
	if ( not realname ) then
		LootLink_ScheduleItem(name,LootLink_GetValue(name,alternate).i);
		return nil;
	else
		local tooltipname = LLHiddenTooltipTextLeft1:GetText();
		if ( realname ~= tooltipname ) then
			-- if this returns, we're in trouble.
			return nil;
		end
	end

	local savedD = value.d;
	local savedT = value.t;

	value.d = "";
	if( not LootLinkState.LightMode ) then
		value.t = "";
	end
	
	value.c = string.gsub( ITEM_QUALITY_COLORS[quality].hex, "|c(.+)", "%1" );
	
	for index = 1, 30, 1 do
		field = getglobal("LLHiddenTooltipTextLeft"..index);
		if( field and field:IsShown() ) then
			left = field:GetText();
		else
			left = nil;
		end
		
		field = getglobal("LLHiddenTooltipTextRight"..index);
		if( field and field:IsShown() ) then
			right = field:GetText();
		else
			right = nil;
		end
		
		if( left ) then
			if( not LootLinkState.LightMode ) then
				-- cull set data to show 0/# and don't save durability
				left = string.gsub( left, "(.+ %()%d+(%/%d%))", "%10%2" );
				if ( string.sub( left, 1, 10 ) ~= "Durability" ) then
					value.t = value.t..left.."·";
				end
			end
		else
			left = "";
		end
		if( right ) then
			if( not LootLinkState.LightMode ) then
				value.t = value.t..right.."·";
			end
		else
			right = "";
		end
		
		loop = 1;
		while( loop ) do
			if( state == STATE_NAME ) then
				state = STATE_BOUND;
				loop = nil;
			elseif( state == STATE_BOUND ) then
				iStart, iEnd, val1 = string.find(left, "Binds when (.+)");
				if( val1 ) then
					if( val1 == "equipped" ) then
						value.d = value.d.."bi"..BINDS_EQUIP.."·";
					elseif( val1 == "picked up" ) then
						value.d = value.d.."bi"..BINDS_PICKUP.."·";
					elseif( val1 == "used" ) then
						value.d = value.d.."bi"..BINDS_USED.."·";
					end
					loop = nil;
				else
					value.d = value.d.."bi"..BINDS_DOES_NOT_BIND.."·";
				end
				state = STATE_UNIQUE;
			elseif( state == STATE_UNIQUE ) then
				if( string.find(left, "Unique") ) then
					value.d = value.d.."un1·";
					loop = nil;
				end
				state = STATE_LOCATION;
			elseif( state == STATE_LOCATION ) then
				local location;
				loop, location, _type, subtype = LootLink_MatchType(left, right);
				if( location ) then
					value.d = value.d.."lo"..location.."·";
				end
				if( _type == TYPE_WEAPON ) then
					state = STATE_DAMAGE;
				elseif( _type == TYPE_ARMOR or _type == TYPE_SHIELD ) then
					state = STATE_ARMOR;
				else
					state = STATE_CONTAINER;
				end
			elseif( state == STATE_DAMAGE ) then
				iStart, iEnd, val1, val2 = string.find(left, "(%d+) %- (%d+) Damage");
				if( val1 and val2 ) then
					value.d = value.d.."mi"..val1.."·ma"..val2.."·";
				end
				iStart, iEnd, val1 = string.find(right, "Speed (.+)");
				if( val1 ) then
					value.d = value.d.."sp"..val1.."·";
				end
				state = STATE_DPS;
				loop = nil;
			elseif( state == STATE_DPS ) then
				iStart, iEnd, val1 = string.find(left, "%((.+) damage per second%)");
				if( val1 ) then
					value.d = value.d.."dp"..val1.."·";
				end
				state = STATE_REQUIRES;
				loop = nil;
			elseif( state == STATE_ARMOR ) then
				iStart, iEnd, val1 = string.find(left, "(%d+) Armor");
				if( val1 ) then
					value.d = value.d.."ar"..val1.."·";
				end
				if( _type == TYPE_SHIELD ) then
					state = STATE_BLOCK;
				else
					state = STATE_REQUIRES;
				end
				loop = nil;
			elseif( state == STATE_BLOCK ) then
				iStart, iEnd, val1 = string.find(left, "(%d+) Block");
				if( val1 ) then
					value.d = value.d.."bl"..val1.."·";
				end
				state = STATE_REQUIRES;
				loop = nil;
			elseif( state == STATE_CONTAINER ) then
				iStart, iEnd, val1, val2 = string.find(left, "(%d+) Slot (.+)");
				if( val1 ) then
					_type = TYPE_CONTAINER;
					subtype = ContainerSubtypes[val2];
					value.d = value.d.."sl"..val1.."·";
					loop = nil;
				end
				state = STATE_REQUIRES;
			elseif( state == STATE_REQUIRES ) then
				iStart, iEnd, val1 = string.find(left, "Requires (.+)");
				if( val1 ) then
					iStart, iEnd, val2 = string.find(val1, "Level (%d+)");
					if( val2 ) then
						value.d = value.d.."le"..val2.."·";
					else
						iStart, iEnd, val2, val3 = string.find(val1, "(.+) %((%d+)%)");
						if( val2 and val3 ) then
							val1 = RecipeSubtypes[val2];
							if( val1 and _type == TYPE_MISC ) then
								_type = TYPE_RECIPE;
								subtype = val1;
								value.d = value.d.."sk"..val3.."·";
							end
						end
					end
				else
					state = STATE_SPACE;
				end
				loop = nil;
			elseif( state == STATE_SPACE ) then
				if ( left == tooltipSpace ) then
					state = STATE_SET;
				end
				loop = nil;
			elseif( state == STATE_SET ) then
				if ( left ~= "" ) then
					iStart, iEnd, val1, val2 = string.find(left, "(.+) %(%d+%/(%d+)%)");
					if( val2 ) then
						local set = LootLink_GetSet(val1);
						value.d = value.d.."se"..set.."·";
						state = STATE_FINISH;
					end
				end
				loop = nil;
			elseif( state == STATE_FINISH ) then
				loop = nil;
			end
		end
	end
	if( _type ) then
		value.d = value.d.."ty".._type.."·";
	end
	if( subtype ) then
		value.d = value.d.."su"..subtype.."·";
	end
	
	if ( realname and name ~= realname ) then
		if ( not ItemLinks[realname] ) then
			ItemLinks[realname] = {};
			ItemLinks[realname] = value;
		else
			if ( ItemLinks[realname].i ~= value.i and ItemLinks[realname].m ) then
				local found;
				for k, v in ItemLinks[realname].m do
					if v.i == value.i then
						found = 1;
						break;
					end
				end
				if ( not found ) then
					tinsert( ItemLinks[realname].m, value );
				end
			end
		end
	end
		
	if ( savedD ~= value.d or savedT ~= value.t ) then
		return 2;
	end
	return 1;
end

local function BuildUsabilityData(data)
	local nSkills;
	local iSkill;
	local HeaderData = { };
	local name, header, isExpanded, rank;
	local Collapse = { };
	local nToCollapse = 0;
	local iCollapse;

	data.class = UnitClass("player");
	data.race = UnitRace("player");
	data.level = UnitLevel("player");
	data.skills = { };
	
	-- We need to expand all of the skills, but first want to save off their state
	nSkills = GetNumSkillLines();
	for iSkill = 1, nSkills do
		local name, header, isExpanded, rank = GetSkillLineInfo(iSkill);
		if( header and not isExpanded ) then
			-- Since we don't know the final index for this item yet, we'll store it by name
			HeaderData[name] = 0;
		end
	end
	
	-- Now expand everything and save off our known skills
	ExpandSkillHeader(0);
	nSkills = GetNumSkillLines()
	for iSkill = 1, nSkills do
		local name, header, isExpanded, rank = GetSkillLineInfo(iSkill);
		if( not header ) then
			data.skills[name] = rank;
		elseif( HeaderData[name] ) then
			-- We now know the final index for this header item
			HeaderData[name] = iSkill;
		end
	end
	
	-- Finally, return the skills page to its original state
	for name, iSkill in HeaderData do
		Collapse[nToCollapse + 1] = iSkill;
		nToCollapse = nToCollapse + 1;
	end
	if( nToCollapse > 0 ) then
		table.sort(Collapse);
		for iCollapse = nToCollapse, 1, -1 do
			CollapseSkillHeader(Collapse[iCollapse]);
		end
	end
end

local function LootLink_GetSkillRank(ud, _type, subtype, location)
	local entry = lTypeAndSubtypeToSkill[_type][subtype];
	
	if( type(entry) == "table" ) then
		-- Two-handed vs. One-handed weapon
		if( location ) then
			if( location == 3 ) then
				return ud.skills[entry[1]];
			else
				return ud.skills[entry[0]];
			end
		else
			return nil;
		end
	else
		-- Everything else
		return ud.skills[entry];
	end
end

local function LootLink_SetHyperlink(tooltip, name, link, index)
	-- If the link isn't in the local cache, it may not be valid
	if ( not link ) then
		return nil;
	end
	local value = ItemLinks[name];
	if ( index and value.m ) then
		value = value.m[index];
	end
	if( not GetItemInfo(link) ) then
		-- To avoid disconnects, we'll create our own lame tooltip for these
		if( value ) then
			local extraSkip = 0;
			local lines = 1;
			local usabilityData;
			
			-- Name, in rarity color
			tooltip:SetText("|c"..value.c..name.."|r");
			
			-- Binds on equip, binds on pickup
			local binds = LL_SearchData(value, "bi");
			if( binds == BINDS_EQUIP ) then
				tooltip:AddLine(ITEM_BIND_ON_EQUIP, 1, 1, 1);
				lines = lines + 1;
			elseif( binds == BINDS_PICKUP ) then
				tooltip:AddLine(ITEM_BIND_ON_PICKUP, 1, 1, 1);
				lines = lines + 1;
			elseif( binds == BINDS_USED ) then
				tooltip:AddLine(ITEM_BIND_ON_USE, 1, 1, 1);
				lines = lines + 1;
			end
			
			-- Unique?
			local unique = LL_SearchData(value, "un");
			if( unique ) then
				tooltip:AddLine("Unique", 1, 1, 1);
				lines = lines + 1;
			end
			
			local _type = LL_SearchData(value, "ty");
			local subtype = LL_SearchData(value, "su");

			-- Equip location and type/subtype
			local location = LL_SearchData(value, "lo");
			if( location ) then
				local subtypes;
				local name;
				for i, v in LocationTypes do
					if( v.i == location ) then
						name = i;
						subtypes = v.subtypes;
						break;
					end
				end
				if( name ) then
					tooltip:AddLine(name, 1, 1, 1);
					lines = lines + 1;
					if( subtype ) then
						if( _type == TYPE_WEAPON ) then
							subtypes = WeaponSubtypes;
						end
						if( subtypes ) then
							for i, v in subtypes do
								if( v == subtype ) then
									if( i == name ) then
										local line = getglobal(tooltip:GetName().."TextLeft"..lines);
										
										if( not usabilityData ) then
											usabilityData = { };
											BuildUsabilityData(usabilityData);
										end
										if( not LootLink_GetSkillRank(usabilityData, _type, subtype, location) ) then
											line:SetTextColor(1, 0, 0);
										end
									else
										local line = getglobal(tooltip:GetName().."TextRight"..lines);
										line:SetText(i);

										if( not usabilityData ) then
											usabilityData = { };
											BuildUsabilityData(usabilityData);
										end
										if( LootLink_GetSkillRank(usabilityData, _type, subtype, location) ) then
											line:SetTextColor(1, 1, 1);
										else
											line:SetTextColor(1, 0, 0);
										end
										
										line:Show();
										extraSkip = extraSkip + 1;
										break;
									end
								end
							end
						end
					end
				end
			end
			
			-- Now do type specific data
			if( _type == TYPE_ARMOR ) then
				local armor = LL_SearchData(value, "ar");
				if( armor ) then
					tooltip:AddLine(armor.." Armor", 1, 1, 1);
					lines = lines + 1;
				end
			elseif( _type == TYPE_WEAPON ) then
				local min = LL_SearchData(value, "mi");
				local max = LL_SearchData(value, "ma");
				local speed = LL_SearchData(value, "sp");
				local dps = LL_SearchData(value, "dp");
				
				if( min and max ) then
					tooltip:AddLine(min.." - "..max.." Damage", 1, 1, 1);
					lines = lines + 1;
					if( speed ) then
						local line = getglobal(tooltip:GetName().."TextRight"..lines);
						line:SetText(format("Speed %.2f", tonumber(speed)));
						line:SetTextColor(1, 1, 1);
						line:Show();
						extraSkip = extraSkip + 1;
					end
				end
				if( dps ) then
					tooltip:AddLine("("..dps.." damage per second)", 1, 1, 1);
					lines = lines + 1;
				end
			elseif( _type == TYPE_SHIELD ) then
				local armor = LL_SearchData(value, "ar");
				local block = LL_SearchData(value, "bl");
				if( armor ) then
					tooltip:AddLine(armor.." Armor", 1, 1, 1);
					lines = lines + 1;
				end
				if( block ) then
					tooltip:AddLine(block.." Block", 1, 1, 1);
					lines = lines + 1;
				end
			elseif( _type == TYPE_RECIPE ) then
				local skill = LL_SearchData(value, "sk");
				if( skill and subtype ) then
					for i, v in RecipeSubtypes do
						if( v == subtype ) then
							if( not usabilityData ) then
								usabilityData = { };
								BuildUsabilityData(usabilityData);
							end
							local rank = LootLink_GetSkillRank(usabilityData, _type, subtype, location);
							if( not rank or rank < skill ) then
								tooltip:AddLine("Requires "..i.." ("..skill..")", 1, 0, 0);
							else
								tooltip:AddLine("Requires "..i.." ("..skill..")", 1, 1, 1);
							end
							lines = lines + 1;
							break;
						end
					end
				end
			elseif( _type == TYPE_CONTAINER ) then
				local slots = LL_SearchData(value, "sl");
				if( slots ) then
					local subtype = LL_SearchData(value, "su") or 0;
					local bag = lTypeAndSubtypeToSkill[_type][subtype]; -- repurposed skill table, fix later?
					tooltip:AddLine(slots.." Slot "..bag, 1, 1, 1);
					lines = lines + 1;
				end
			end
			
			local level = LL_SearchData(value, "le");

			-- Now add any extra text data that we have
			if( value.t ) then
				local skip = lines + extraSkip;
				local piece;
				for piece in string.gfind(value.t, "(.-)·") do
					if( lines < 29 ) then
						if( skip == 0 ) then
							if( string.find(piece, "Requires Level .*") ) then
								if( level and tonumber(level) > UnitLevel("player") ) then
									tooltip:AddLine(piece, 1, 0, 0, 1, 1);
								else
									tooltip:AddLine(piece, 1, 1, 1, 1, 1);
								end
							elseif( string.find(piece, ":") ) then
								if( string.find(piece, "^Class") ) then
									if( string.find(piece, "^Class.*"..UnitClass("player")) ) then
										tooltip:AddLine(piece, 1, 1, 1, 1, 1);
									else
										tooltip:AddLine(piece, 1, 0, 0, 1, 1);
									end
								else
									tooltip:AddLine(piece, 0, 1, 0, 1, 1);
								end
							elseif( string.find(piece, "\"") or string.find(piece, "%(%d+/%d+%)") ) then
								tooltip:AddLine(piece, 1, 0.8235, 0, 1, 1);
							elseif( string.find(piece, "^  ") ) then
								tooltip:AddLine(piece, 0.5, 0.5, 0.5, 1, 1);
							else
								tooltip:AddLine(piece, 1, 1, 1, 1, 1);
							end
							lines = lines + 1;
						else
							skip = skip - 1;
						end
					end
				end
			end
			
			-- And, after all that, let the user know that we faked this tooltip
			if( lines < 30 ) then
				tooltip:AddLine("|cff40ffc0<"..LOOTLINK_TOOLTIP_GENERATED..">|r");
				lines = lines + 1;
			end
			
			if( lines < 30 and not LootLink_CheckItemServer(value, lServerIndex) ) then
				tooltip:AddLine("|cff40ffc0<"..LOOTLINK_TOOLTIP_SERVER..">|r");
				lines = lines + 1;
			end
			
			-- Finally, show the tooltip, which adjusts its size
			tooltip:Show();
		end
	else
		-- Get the actual tooltip from the cache
		tooltip:SetHyperlink(link);
		
		-- After setting the tooltip, parse its data
		LootLink_ScheduleItem(name, value.i);
		--LootLink_BuildSearchData(name, value, index);
			
		if( not LootLink_ValidateItem(name, link) ) then
			tooltip:AddLine("|cff40ffc0<"..LOOTLINK_TOOLTIP_BAD_ITEM..">|r");
		elseif( not LootLink_CheckItemServerRaw(value, lServerIndex) ) then
			tooltip:AddLine("|cff40ffc0<"..LOOTLINK_TOOLTIP_SERVER..">|r");
			--LootLink_AddItemServer(value, lServerIndex);
			--lItemLinksSizeServer = lItemLinksSizeServer + 1;
			--return 1;
		end
	end
end

local function LootLink_SetTitle()
	local lootLinkTitle = getglobal("LootLinkTitleText");
	local total = LootLink_GetSize(lServerIndex);
	local size;
	
	if( not DisplayIndices ) then
		size = total;
	else
		size = DisplayIndices.onePastEnd - 1;
	end
	if( size < total ) then
		if( size == 1 ) then
			lootLinkTitle:SetText(TEXT(LOOTLINK_TITLE_FORMAT_PARTIAL_SINGULAR));
		else
			lootLinkTitle:SetText(format(TEXT(LOOTLINK_TITLE_FORMAT_PARTIAL_PLURAL), size));
		end
	else
		if( size == 1 ) then
			lootLinkTitle:SetText(TEXT(LOOTLINK_TITLE_FORMAT_SINGULAR));
		else
			lootLinkTitle:SetText(format(TEXT(LOOTLINK_TITLE_FORMAT_PLURAL), size));
		end
	end
end

local function LootLink_MatchesSearch(name, value, ud)
	if( not value ) then
		return nil;
	end
	if( LootLinkState ) then
		if ( LootLinkState.spoof and name ) then
			if ( not LootLink_ValidateItem( name, value.i ) ) then
				return nil;
			end
		end
		if ( LootLinkState.server ) then
			if ( not LootLink_CheckItemServer(value, lServerIndex) ) then
				return nil;
			end
		end
		if ( LootLinkState.rarityfilter ) then
			if ( value.c and lRarityFilter[value.c] < LootLinkState.rarityfilter ) then
				return nil;
			end
		end
		if ( LootLinkState.noname ) then
			if ( ItemLinks[name] and ItemLinks[name].i and ItemLinks[name].i ~= value.i ) then
				return nil;
			end
		else
			if ( LootLinkState.novariants ) then
				if ( string.gsub(value.i, "%d+:%d+:(%d+):%d+", "%1") ~="0" and ItemLinks[name] and ItemLinks[name].i and ItemLinks[name].i ~= value.i ) then
					return nil;
				end
			end
			if ( LootLinkState.enchants ) then
				if ( string.gsub(value.i, "%d+:(%d+):%d+:%d+", "%1") ~= "0" ) then
					return nil;
				end
			end
		end
	end
	if( not LootLinkFrame.SearchParams or not name ) then
		return 1;
	end
	
	if( value.d ) then
		local sp = LootLinkFrame.SearchParams; 
		
		if( sp.server ) then
			if ( not LootLink_CheckItemServer(value, lServerIndex) ) then
				return nil;
			end
		end
		
		if( sp.spoof ) then
			if ( LootLink_ValidateItem( name, value.i ) ) then
				return nil;
			end
		end
		
		if( sp.text ) then
			if( not value.t ) then
				return nil;
			end
			if( not string.find(string.lower(value.t), string.lower(sp.text), 1, sp.plain) ) then
				return nil;
			end
		end
		
		if( sp.name ) then
			if( not string.find(string.lower(name), string.lower(sp.name), 1, sp.plain) ) then
				return nil;
			end
		end
		
		if( sp.rarity ) then
			if( LLS_RARITY_LIST[sp.rarity].value ~= value.c ) then
				return nil;
			end
		end
		
		if( sp.binds ) then
			if( LLS_BINDS_LIST[sp.binds].value ~= LL_SearchData(value, "bi") ) then
				return nil;
			end
		end
		
		if( sp.unique ) then
			if( sp.unique ~= LL_SearchData(value, "un") ) then
				return nil;
			end
		end
		
		if( sp.usable ) then
			local _type = LL_SearchData(value, "ty");
			local subtype = LL_SearchData(value, "su");
			local level = LL_SearchData(value, "le");
			local skill = LL_SearchData(value, "sk");
			
			-- Check for the required skill
			if( _type ) then
				if( subtype ) then
					local rank = LootLink_GetSkillRank(ud, _type, subtype, LL_SearchData(value, "lo"));
					if( not rank or (skill and skill > rank) ) then
						return nil;
					end
				end
			end
			
			-- Check for the required class
			if( value.t and string.find(value.t, "·Class") and not string.find(value.t, "·Class.*"..UnitClass("player")) ) then
				return nil;
			end
			
			-- Check level requirement
			if( level and level > ud.level ) then
				return nil;
			end
		end
		
		if( sp.location ) then
			local location = LL_SearchData(value, "lo");
		
			if( sp.location == 2 ) then
				if( location ) then
					return nil;
				end
			elseif( sp.location ~= 1 ) then
				if( LocationTypes[LLS_LOCATION_LIST[sp.location].name].i ~= location ) then
					return nil;
				end
			end
		end
		
		if( sp.minLevel ) then
			local level = LL_SearchData(value, "le");
			if( not level or level < sp.minLevel ) then
				return nil;
			end
		end
		
		if( sp.maxLevel ) then
			local level = LL_SearchData(value, "le");
			if( level and level > sp.maxLevel ) then
				return nil;
			end
		end
		
		if( sp.set ) then
			local set = LL_SearchData(value, "se");
			if( not set ) then
				return nil;
			end
		end
		
		if( sp.type ) then
			local _type = LLS_TYPE_LIST[sp.type].value;
			if( _type ~= LL_SearchData(value, "ty") ) then
				return nil;
			end
			if( sp.subtype ) then
				local subtype;
				if( _type == TYPE_ARMOR ) then
					subtype = LLS_SUBTYPE_ARMOR_LIST[sp.subtype].value;
				elseif( _type == TYPE_SHIELD ) then
					subtype = LLS_SUBTYPE_SHIELD_LIST[sp.subtype].value;
				elseif( _type == TYPE_WEAPON ) then
					subtype = LLS_SUBTYPE_WEAPON_LIST[sp.subtype].value;
				elseif( _type == TYPE_RECIPE ) then
					subtype = LLS_SUBTYPE_RECIPE_LIST[sp.subtype].value;
				elseif( _type == TYPE_CONTAINER ) then
					subtype = LLS_SUBTYPE_CONTAINER_LIST[sp.subtype].value;
				end
				if( subtype and subtype ~= LL_SearchData(value, "su") ) then
					return nil;
				end
			end
			
			if( _type == TYPE_WEAPON ) then
				if( sp.minMinDamage ) then
					local damage = LL_SearchData(value, "mi");
					if( not damage or damage < sp.minMinDamage ) then
						return nil;
					end
				end

				if( sp.minMaxDamage ) then
					local damage = LL_SearchData(value, "ma");
					if( not damage or damage < sp.minMaxDamage ) then
						return nil;
					end
				end

				if( sp.maxSpeed ) then
					local speed = LL_SearchData(value, "sp");
					if( not speed or speed > sp.maxSpeed ) then
						return nil;
					end
				end

				if( sp.minDPS ) then
					local DPS = LL_SearchData(value, "dp");
					if( not DPS or DPS < sp.minDPS ) then
						return nil;
					end
				end
			elseif( _type == TYPE_ARMOR or _type == TYPE_SHIELD ) then
				if( sp.minArmor ) then
					local armor = LL_SearchData(value, "ar");
					if( not armor or armor < sp.minArmor ) then
						return nil;
					end
				end
				
				if( _type == TYPE_SHIELD ) then
					if( sp.minBlock ) then
						local block = LL_SearchData(value, "bl");
						if( not block or block < sp.minBlock ) then
							return nil;
						end
					end
				end
			elseif( _type == TYPE_CONTAINER ) then
				if( sp.minSlots ) then
					local slots = LL_SearchData(value, "sl");
					if( not slots or slots < sp.minSlots ) then
						return nil;
					end
				end
			elseif( _type == TYPE_RECIPE ) then
				if( sp.minSkill ) then
					local skill = LL_SearchData(value, "sk");
					if( not skill or skill < sp.minSkill ) then
						return nil;
					end
				end
				
				if( sp.maxSkill ) then
					local skill = LL_SearchData(value, "sk");
					if( not skill or skill > sp.maxSkill ) then
						return nil;
					end
				end
			end
		end
	else
		return nil;
	end

	return 1;
end

local function LootLink_NameComparison(elem1, elem2)
	local v1, i1 = elem1[1], elem1[3];
	local v2, i2 = elem2[1], elem2[3];
	
	if ( v1 == v2 ) then
		if ( i1 and i2 ) then
			return i1 < i2;
		elseif ( i1 ) then
			return false;
		elseif ( i2 ) then
			return true;
		end
	end
	return v1 < v2;
end

local function LootLink_ColorComparison(elem1, elem2)
	local color1;
	local color2;
	local v1 = elem1[2];
	local v2 = elem2[2];
	
	if( v1 and v1.c ) then
		color1 = v1.c;
	else
		color1 = "ffffffff";
	end
	if( v2 and v2.c ) then
		color2 = v2.c;
	else
		color2 = "ffffffff";
	end
	
	if( color1 == color2 ) then
		return LootLink_NameComparison( elem1, elem2 );
	end
	
	if( not lColorSortTable[color1] and not lColorSortTable[color2] ) then
		return color1 < color2;
	end
	
	if( lColorSortTable[color1] ) then
		if( lColorSortTable[color2] ) then
			return lColorSortTable[color1] < lColorSortTable[color2];
		end
		return nil;
	end
	return 1;
end

local function LootLink_GenericComparison(elem1, elem2, v1, v2)
	if( v1 == v2 ) then
		return LootLink_NameComparison( elem1, elem2 );
	end
	if( not v1 ) then
		return 1;
	end
	if( not v2 ) then
		return nil;
	end
	if( tonumber(v1) and tonumber(v2) ) then
		return tonumber(v1) < tonumber(v2);
	end
	return v1 < v2;
end

local function LootLink_BindsComparison(elem1, elem2)
	local v1, v2;
	
	local value1 = elem1[2];
	local value2 = elem2[2];
	
	if( value1 and value1.d ) then
		v1 = LL_SearchData(ItemLinks[elem1], "bi");
	end
	if( value2 and value2.d ) then
		v2 = LL_SearchData(ItemLinks[elem2], "bi");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

local function LootLink_UniqueComparison(elem1, elem2)
	local v1, v2;
	
	local value1 = elem1[2];
	local value2 = elem2[2];
	
	if( value1 and value1.d ) then
		v1 = LL_SearchData(value1, "un");
	end
	if( value2 and value2.d ) then
		v2 = LL_SearchData(value2, "un");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

local function LootLink_LocationComparison(elem1, elem2)
	local v1, v2;
	
	local value1 = elem1[2];
	local value2 = elem2[2];
	
	if( value1 and value1.d ) then
		v1 = LL_SearchData(value1, "lo");
	end
	if( value2 and value2.d ) then
		v2 = LL_SearchData(value2, "lo");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

local function LootLink_TypeComparison(elem1, elem2)
	local v1, v2;
	
	local value1 = elem1[2];
	local value2 = elem2[2];
	
	if( value1 and value1.d ) then
		v1 = LL_SearchData(value1, "ty");
	end
	if( value2 and value2.d ) then
		v2 = LL_SearchData(value2, "ty");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

local function LootLink_SubtypeComparison(elem1, elem2)
	local v1, v2;
	
	local value1 = elem1[2];
	local value2 = elem2[2];
	
	if( value1 and value1.d ) then
		v1 = LL_SearchData(value1, "su");
	end
	if( value2 and value2.d ) then
		v2 = LL_SearchData(value2, "su");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

local function LootLink_MinDamageComparison(elem1, elem2)
	local v1, v2;
	
	local value1 = elem1[2];
	local value2 = elem2[2];
	
	if( value1 and value1.d ) then
		v1 = LL_SearchData(value1, "mi");
	end
	if( value2 and value2.d ) then
		v2 = LL_SearchData(value2, "mi");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

local function LootLink_MaxDamageComparison(elem1, elem2)
	local v1, v2;
	
	local value1 = elem1[2];
	local value2 = elem2[2];
	
	if( value1 and value1.d ) then
		v1 = LL_SearchData(value1, "ma");
	end
	if( value2 and value2.d ) then
		v2 = LL_SearchData(value2, "ma");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

local function LootLink_SpeedComparison(elem1, elem2)
	local v1, v2;
	
	local value1 = elem1[2];
	local value2 = elem2[2];
	
	if( value1 and value1.d ) then
		v1 = LL_SearchData(value1, "sp");
	end
	if( value2 and value2.d ) then
		v2 = LL_SearchData(value2, "sp");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

local function LootLink_DPSComparison(elem1, elem2)
	local v1, v2;
	
	local value1 = elem1[2];
	local value2 = elem2[2];
	
	if( value1 and value1.d ) then
		v1 = LL_SearchData(value1, "dp");
	end
	if( value2 and value2.d ) then
		v2 = LL_SearchData(value2, "dp");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

local function LootLink_ArmorComparison(elem1, elem2)
	local v1, v2;
	
	local value1 = elem1[2];
	local value2 = elem2[2];
	
	if( value1 and value1.d ) then
		v1 = LL_SearchData(value1, "ar");
	end
	if( value2 and value2.d ) then
		v2 = LL_SearchData(value2, "ar");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

local function LootLink_BlockComparison(elem1, elem2)
	local v1, v2;
	
	local value1 = elem1[2];
	local value2 = elem2[2];
	
	if( value1 and value1.d ) then
		v1 = LL_SearchData(value1, "bl");
	end
	if( value2 and value2.d ) then
		v2 = LL_SearchData(value2, "bl");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

local function LootLink_SlotsComparison(elem1, elem2)
	local v1, v2;
	
	local value1 = elem1[2];
	local value2 = elem2[2];
	
	if( value1 and value1.d ) then
		v1 = LL_SearchData(value1, "sl");
	end
	if( value2 and value2.d ) then
		v2 = LL_SearchData(value2, "sl");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

local function LootLink_SkillComparison(elem1, elem2)
	local v1, v2;
	
	local value1 = elem1[2];
	local value2 = elem2[2];
	
	if( value1 and value1.d ) then
		v1 = LL_SearchData(value1, "sk");
	end
	if( value2 and value2.d ) then
		v2 = LL_SearchData(value2, "sk");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

local function LootLink_LevelComparison(elem1, elem2)
	local v1, v2;
	
	local value1 = elem1[2];
	local value2 = elem2[2];
	
	if( value1 and value1.d ) then
		v1 = LL_SearchData(value1, "le");
	end
	if( value2 and value2.d ) then
		v2 = LL_SearchData(value2, "le");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

-- Ugly, but functional
local function LootLink_SetComparison(elem1, elem2)
	local v1, v2;
	
	local value1 = elem1[2];
	local value2 = elem2[2];
	
	local sets = LootLinkState.sets;
	
	if ( not sets ) then
		return LootLink_NameComparison(elem1, elem2);
	end
	
	if( value1 and value1.d ) then
		v1 = LL_SearchData(value1, "se");
		v1 = sets[v1];
	end
	if( value2 and value2.d ) then
		v2 = LL_SearchData(value2, "se");
		v2 = sets[v2];
	end
	
	if ( not v1 and not v2 ) then
		return LootLink_NameComparison(elem1, elem2);
	elseif ( not v1 ) then
		return nil;
	elseif ( not v2 ) then
		return 1;
	else
		if ( v1 == v2 ) then
			return LootLink_NameComparison(elem1, elem2);
		else
			return v1 < v2;
		end
	end
end

local function LootLink_Sort()
	if( LOOTLINK_DROPDOWN_LIST[UIDropDownMenu_GetSelectedID(LootLinkFrameDropDown)].sortType ) then
		local sortType = LOOTLINK_DROPDOWN_LIST[UIDropDownMenu_GetSelectedID(LootLinkFrameDropDown)].sortType;
		if( sortType == "name" ) then
			table.sort(DisplayIndices, LootLink_NameComparison);
		elseif( sortType == "rarity" ) then
			table.sort(DisplayIndices, LootLink_ColorComparison);
		elseif( sortType == "binds" ) then
			table.sort(DisplayIndices, LootLink_BindsComparison);
		elseif( sortType == "unique" ) then
			table.sort(DisplayIndices, LootLink_UniqueComparison);
		elseif( sortType == "location" ) then
			table.sort(DisplayIndices, LootLink_LocationComparison);
		elseif( sortType == "type" ) then
			table.sort(DisplayIndices, LootLink_TypeComparison);
		elseif( sortType == "subtype" ) then
			table.sort(DisplayIndices, LootLink_SubtypeComparison);
		elseif( sortType == "minDamage" ) then
			table.sort(DisplayIndices, LootLink_MinDamageComparison);
		elseif( sortType == "maxDamage" ) then
			table.sort(DisplayIndices, LootLink_MaxDamageComparison);
		elseif( sortType == "speed" ) then
			table.sort(DisplayIndices, LootLink_SpeedComparison);
		elseif( sortType == "DPS" ) then
			table.sort(DisplayIndices, LootLink_DPSComparison);
		elseif( sortType == "armor" ) then
			table.sort(DisplayIndices, LootLink_ArmorComparison);
		elseif( sortType == "block" ) then
			table.sort(DisplayIndices, LootLink_BlockComparison);
		elseif( sortType == "slots" ) then
			table.sort(DisplayIndices, LootLink_SlotsComparison);
		elseif( sortType == "skill" ) then
			table.sort(DisplayIndices, LootLink_SkillComparison);
		elseif( sortType == "level" ) then
			table.sort(DisplayIndices, LootLink_LevelComparison);
		elseif( sortType == "set" ) then
			table.sort(DisplayIndices, LootLink_SetComparison);
		end
	end
end

local function LootLink_BuildDisplayIndices()
	local iNew = 1;
	local index;
	local value;
	local UsabilityData;
	
	if( LootLinkFrame.SearchParams and LootLinkFrame.SearchParams.usable ) then
		UsabilityData = { };
		BuildUsabilityData(UsabilityData);
	end
	
	DisplayIndices = { };
	for index, value in ItemLinks do
		if( LootLink_MatchesSearch(index, value, UsabilityData) ) then
			DisplayIndices[iNew] = { index, value, nil };
			iNew = iNew + 1;
		end
		if( value.m ) then
			for i, altvalue in value.m do
				if( LootLink_MatchesSearch(index, altvalue, UsabilityData) ) then
					DisplayIndices[iNew] = { index, altvalue, i };
					iNew = iNew + 1;
				end
			end
		end	
	end
	DisplayIndices.onePastEnd = iNew;
	LootLink_SetDataVersion(100); -- version 1.00
	LootLink_Sort();
	LootLink_SetTitle();
	LootLinkQuickSearch_Clear();
end

local function LootLink_Reset()
	ItemLinks = { };

	LootLink_SetDataVersion(110);	-- version 1.10

	LootLink_InitSizes(lServerIndex);
	
	if( DisplayIndices ) then
		LootLink_BuildDisplayIndices();
		LootLink_Update();
	end
end

local function LootLink_MakeHome()
	local index;
	local value;

	LootLink_SetDataVersion(110);	-- version 1.10
	
	for index, value in ItemLinks do
		if( not value._ ) then
			-- If this item predates multiple server support, mark is as seen on this server
			LootLink_AddItemServer(value, lServerIndex);
		else
			-- Otherwise just wipe the flag since it only applies to pre-1.10 data
			value._ = nil;
		end
	end

	LootLink_InitSizes(lServerIndex);
end

local function LootLink_LightMode()
	local index;
	local value;

	for index, value in ItemLinks do
		value.t = nil;
	end
	LootLinkState.LightMode = 1;
end

--
-- Uncategorized functions; will sort later
--

local function LootLinkFrameDropDown_Initialize()
	local info;
	for i = 1, getn(LOOTLINK_DROPDOWN_LIST), 1 do
		info = { };
		info.text = LOOTLINK_DROPDOWN_LIST[i].name;
		info.func = LootLinkFrameDropDownButton_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

local function LLS_RarityDropDown_Initialize()
	local info;
	for i = 1, getn(LLS_RARITY_LIST), 1 do
		info = { };
		info.text = LLS_RARITY_LIST[i].name;
		info.func = LLS_RarityDropDown_OnClick;
		if( LLS_RARITY_LIST[i].value ) then
			info.textR = LLS_RARITY_LIST[i].r;
			info.textG = LLS_RARITY_LIST[i].g;
			info.textB = LLS_RARITY_LIST[i].b;
		end
		UIDropDownMenu_AddButton(info);
	end
end

local function LLO_RarityDropDown_Initialize()
	local info;
	for i = 1, getn(LLO_RARITY_LIST), 1 do
		info = { };
		info.text = LLO_RARITY_LIST[i].name;
		info.func = LLO_RarityDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

local function LLS_BindsDropDown_Initialize()
	local info;
	for i = 1, getn(LLS_BINDS_LIST), 1 do
		info = { };
		info.text = LLS_BINDS_LIST[i].name;
		info.func = LLS_BindsDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

local function LLS_LocationDropDown_Initialize()
	local info;
	for i = 1, getn(LLS_LOCATION_LIST), 1 do
		info = { };
		info.text = LLS_LOCATION_LIST[i].name;
		info.func = LLS_LocationDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

local function LLS_TypeDropDown_Initialize()
	local info;
	for i = 1, getn(LLS_TYPE_LIST), 1 do
		info = { };
		info.text = LLS_TYPE_LIST[i].name;
		info.func = LLS_TypeDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

local function LLS_SubtypeDropDownArmor_Initialize()
	local info;
	for i = 1, getn(LLS_SUBTYPE_ARMOR_LIST), 1 do
		info = { };
		info.text = LLS_SUBTYPE_ARMOR_LIST[i].name;
		info.func = LLS_SubtypeDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

local function LLS_SubtypeDropDownShield_Initialize()
	local info;
	for i = 1, getn(LLS_SUBTYPE_SHIELD_LIST), 1 do
		info = { };
		info.text = LLS_SUBTYPE_SHIELD_LIST[i].name;
		info.func = LLS_SubtypeDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

local function LLS_SubtypeDropDownWeapon_Initialize()
	local info;
	for i = 1, getn(LLS_SUBTYPE_WEAPON_LIST), 1 do
		info = { };
		info.text = LLS_SUBTYPE_WEAPON_LIST[i].name;
		info.func = LLS_SubtypeDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

local function LLS_SubtypeDropDownRecipe_Initialize()
	local info;
	for i = 1, getn(LLS_SUBTYPE_RECIPE_LIST), 1 do
		info = { };
		info.text = LLS_SUBTYPE_RECIPE_LIST[i].name;
		info.func = LLS_SubtypeDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

local function LLS_SubtypeDropDownContainer_Initialize()
	local info;
	for i = 1, getn(LLS_SUBTYPE_CONTAINER_LIST), 1 do
		info = { };
		info.text = LLS_SUBTYPE_CONTAINER_LIST[i].name;
		info.func = LLS_SubtypeDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

local function LootLink_UIDropDownMenu_SetSelectedID(frame, id, names)
	UIDropDownMenu_SetSelectedID(frame, id);
	if( not frame ) then
		frame = this;
	end
	UIDropDownMenu_SetText(names[id].name, frame);
end

local function LootLink_SetupTypeUI(iType, iSubtype)
	local _type = LLS_TYPE_LIST[iType].value;
	
	if( not iSubtype ) then
		iSubtype = 1;
	end

	-- Hide all of the variable labels and fields to start
	getglobal("LLS_SubtypeLabel"):Hide();
	getglobal("LLS_SubtypeDropDown"):Hide();
	getglobal("LLS_MinimumArmorLabel"):Hide();
	getglobal("LLS_MinimumBlockLabel"):Hide();
	getglobal("LLS_MinimumDamageLabel"):Hide();
	getglobal("LLS_MaximumDamageLabel"):Hide();
	getglobal("LLS_MaximumSpeedLabel"):Hide();
	getglobal("LLS_MinimumDPSLabel"):Hide();
	getglobal("LLS_MinimumSlotsLabel"):Hide();
	getglobal("LLS_MinimumSkillLabel"):Hide();
	getglobal("LLS_MaximumSkillLabel"):Hide();
	getglobal("LLS_MinimumArmorEditBox"):Hide();
	getglobal("LLS_MinimumBlockEditBox"):Hide();
	getglobal("LLS_MinimumDamageEditBox"):Hide();
	getglobal("LLS_MaximumDamageEditBox"):Hide();
	getglobal("LLS_MaximumSpeedEditBox"):Hide();
	getglobal("LLS_MinimumDPSEditBox"):Hide();
	getglobal("LLS_MinimumSlotsEditBox"):Hide();
	getglobal("LLS_MinimumSkillEditBox"):Hide();
	getglobal("LLS_MaximumSkillEditBox"):Hide();
	
	if( _type ~= TYPE_OTHER ) then
		local label = getglobal("LLS_SubtypeLabel");
		local dropdown = getglobal("LLS_SubtypeDropDown");
		local initfunc;
		
		-- Show the dropdown and its label
		label:Show();
		dropdown:Show();
		
		if( _type == TYPE_ARMOR ) then
			label:SetText(LLS_SUBTYPE_ARMOR);
			initfunc = LLS_SubtypeDropDownArmor_Initialize;
			
			getglobal("LLS_MinimumArmorLabel"):Show();
			getglobal("LLS_MinimumArmorEditBox"):Show();
		elseif( _type == TYPE_SHIELD ) then
			label:SetText(LLS_SUBTYPE_SHIELD);
			initfunc = LLS_SubtypeDropDownShield_Initialize;

			getglobal("LLS_MinimumArmorLabel"):Show();
			getglobal("LLS_MinimumBlockLabel"):Show();
			getglobal("LLS_MinimumArmorEditBox"):Show();
			getglobal("LLS_MinimumBlockEditBox"):Show();
		elseif( _type == TYPE_WEAPON ) then
			label:SetText(LLS_SUBTYPE_WEAPON);
			initfunc = LLS_SubtypeDropDownWeapon_Initialize;
			
			getglobal("LLS_MinimumDamageLabel"):Show();
			getglobal("LLS_MaximumDamageLabel"):Show();
			getglobal("LLS_MaximumSpeedLabel"):Show();
			getglobal("LLS_MinimumDPSLabel"):Show();
			getglobal("LLS_MinimumDamageEditBox"):Show();
			getglobal("LLS_MaximumDamageEditBox"):Show();
			getglobal("LLS_MaximumSpeedEditBox"):Show();
			getglobal("LLS_MinimumDPSEditBox"):Show();
		elseif( _type == TYPE_CONTAINER ) then
			label:SetText(LLS_SUBTYPE_CONTAINER);
			initfunc = LLS_SubtypeDropDownContainer_Initialize;

			getglobal("LLS_MinimumSlotsLabel"):Show();
			getglobal("LLS_MinimumSlotsEditBox"):Show();
		else
			label:SetText(LLS_SUBTYPE_RECIPE);
			initfunc = LLS_SubtypeDropDownRecipe_Initialize;

			getglobal("LLS_MinimumSkillLabel"):Show();
			getglobal("LLS_MaximumSkillLabel"):Show();
			getglobal("LLS_MinimumSkillEditBox"):Show();
			getglobal("LLS_MaximumSkillEditBox"):Show();
		end
		
		UIDropDownMenu_Initialize(dropdown, initfunc);
		UIDropDownMenu_SetSelectedID(LLS_SubtypeDropDown, iSubtype);
	end
	
	LLS_TextEditBox:SetFocus();
end

local function LootLink_InspectSlot(unit, id)
	local link = GetInventoryItemLink(unit, id);
	if( link ) then
		local name = LootLink_ProcessLinks(link, 1);
		if( name and ItemLinks[name] ) then
			local count = GetInventoryItemCount(unit, id);
			if( count > 1 ) then
				ItemLinks[name].x = 1;
			end
			LootLink_Event_InspectSlot(name, count, ItemLinks[name], unit, id);
		end
	end
end

function LootLink_Inspect(who)
	if ( not UnitIsPlayer(who) ) then return; end
	if ( who == "mouseover" ) then
		if ( not LLInspect_List ) then
			LLInspect_List = {};
		end
		local name = UnitName(who);
		local time = GetTime();
		local lasttime = LLInspect_List[name];
		if ( lasttime and time - lasttime < 120 ) then
			return nil;
		end
		if ( not lasttime ) then
			LLInspect_List.total = (LLInspect_List.total or 0) + 1;
		end
		if ( LLInspect_List.total and LLInspect_List.total > 250 ) then
			local list = 0;
			for k, v in LLInspect_List do
				list = list + 1;
				v = nil;
				if ( list == 100 ) then
					break;
				end
			end
		end
				
		LLInspect_List[name] = time;
	end	
			
	local index;
	
	for index = 1, getn(INVENTORY_SLOT_LIST), 1 do
		LootLink_InspectSlot(who, INVENTORY_SLOT_LIST[index].id)
	end
end

local function LootLink_ScanInventory()
	local bagid;
	local size;
	local slotid;
	local link;
	
	for bagid = 0, 4, 1 do
		size = GetContainerNumSlots(bagid);
		if( size ) then
			for slotid = size, 1, -1 do
				link = GetContainerItemLink(bagid, slotid);
				if( link ) then
					local name = LootLink_ProcessLinks(link, 1);
					if( name and ItemLinks[name] ) then
						local texture, count, locked, quality, readable = GetContainerItemInfo(bagid, slotid);
						if( count > 1 ) then
							ItemLinks[name].x = 1;
						end
						LootLink_Event_ScanInventory(name, count, ItemLinks[name], bagid, slotid);
					end
				end
			end
		end
	end
end

local function LootLink_ScanSellPrices()
	local bagid;
	local size;
	local slotid;
	local link;
	
	LootLink_MoneyToggle();
	for bagid = 0, 4, 1 do
		lBagID = bagid;
		size = GetContainerNumSlots(bagid);
		if( size ) then
			for slotid = size, 1, -1 do
				lSlotID = slotid;
				LLHiddenTooltip:SetBagItem(bagid, slotid);
			end
		end
	end
	
	lBagID = nil;
	lSlotID = nil;
	
	LootLink_MoneyToggle(1);
end

local function LootLink_StartAuctionScan()
	-- Start with the first page
	lCurrentAuctionPage = nil;

	-- Hook the functions that we need for the scan
	if( not lOriginal_CanSendAuctionQuery ) then
		lOriginal_CanSendAuctionQuery = CanSendAuctionQuery;
		CanSendAuctionQuery = LootLink_CanSendAuctionQuery;
	end
	if( not lOriginal_AuctionFrameBrowse_OnEvent ) then
		lOriginal_AuctionFrameBrowse_OnEvent = AuctionFrameBrowse_OnEvent;
		AuctionFrameBrowse_OnEvent = LootLink_AuctionFrameBrowse_OnEvent;
	end
	
	LootLink_Event_StartAuctionScan();
end

local function LootLink_StopAuctionScan()
	LootLink_Event_StopAuctionScan();
	
	-- Unhook the scanning functions
	if( lOriginal_CanSendAuctionQuery ) then
		CanSendAuctionQuery = lOriginal_CanSendAuctionQuery;
		lOriginal_CanSendAuctionQuery = nil;
	end
	if( lOriginal_AuctionFrameBrowse_OnEvent ) then
		AuctionFrameBrowse_OnEvent = lOriginal_AuctionFrameBrowse_OnEvent;
		lOriginal_AuctionFrameBrowse_OnEvent = nil;
	end
end

local function LootLink_AuctionNextQuery()
	if( lCurrentAuctionPage ) then
		local numBatchAuctions, totalAuctions = GetNumAuctionItems("list");
		local maxPages = floor(totalAuctions / NUM_AUCTION_ITEMS_PER_PAGE);
		
		if( lCurrentAuctionPage < maxPages ) then
			lCurrentAuctionPage = lCurrentAuctionPage + 1;
			BrowseNoResultsText:SetText(format(LOOTLINK_AUCTION_PAGE_N, lCurrentAuctionPage + 1, maxPages + 1));
		else
			lScanAuction = nil;
			LootLink_StopAuctionScan();
			if( totalAuctions > 0 ) then
				BrowseNoResultsText:SetText(LOOTLINK_AUCTION_SCAN_DONE);
				LootLink_Event_FinishedAuctionScan();
			end
			return;
		end
	else
		lCurrentAuctionPage = 0;
		BrowseNoResultsText:SetText(LOOTLINK_AUCTION_SCAN_START);
	end
	QueryAuctionItems("", "", "", nil, nil, nil, lCurrentAuctionPage, nil, nil);
	LootLink_Event_AuctionQuery(lCurrentAuctionPage);
end

local function LootLink_ScanAuction()
	local numBatchAuctions, totalAuctions = GetNumAuctionItems("list");
	local auctionid;
	local link;

	if( numBatchAuctions > 0 ) then
		for auctionid = 1, numBatchAuctions do
			link = GetAuctionItemLink("list", auctionid);
			if( link ) then
				local name = LootLink_ProcessLinks(link, 1);
				if( name and ItemLinks[name] ) then
					local name_, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner = GetAuctionItemInfo("list", auctionid);
					if( count > 1 ) then
						ItemLinks[name].x = 1;
					end
					LootLink_Event_ScanAuction(name, count, ItemLinks[name], lCurrentAuctionPage, auctionid);
				end
			end
		end
	end
end

local function LootLink_ScanBank()
	local index;
	local bagid;
	local size;
	local slotid;
	local link;
	
	for index, bagid in lBankBagIDs do
		size = GetContainerNumSlots(bagid);
		if( size ) then
			for slotid = size, 1, -1 do
				link = GetContainerItemLink(bagid, slotid);
				if( link ) then
					local name = LootLink_ProcessLinks(link, 1);
					if( name and ItemLinks[name] ) then
						local texture, count, locked, quality, readable = GetContainerItemInfo(bagid, slotid);
						if( count > 1 ) then
							ItemLinks[name].x = 1;
						end
						LootLink_Event_ScanBank(name, count, ItemLinks[name], bagid, slotid);
					end
				end
			end
		end
	end
end

local function LootLink_ScanSellPrice(price)
	local link = GetContainerItemLink(lBagID, lSlotID);
	local texture, itemCount, locked, quality, readable = GetContainerItemInfo(lBagID, lSlotID);
	local name;
	
	if( itemCount and itemCount > 1 ) then
		price = price / itemCount;
	end
	
	name = LootLink_NameFromLink(link);
	if( name and ItemLinks[name] ) then
		ItemLinks[name].p = price;
		if( itemCount and itemCount > 1 ) then
			ItemLinks[name].x = 1;
		end
	end
end

local function LootLink_CheckTooltipInfo()
	if( GameTooltip:IsVisible() ) then
		-- If we've already added our information or money is already showing, no need to do it again
		if( GameTooltip.llDone or GameTooltipMoneyFrame:IsVisible() ) then
			return nil;
		end
	
		-- Don't add information to tooltips generated while the mouse is over the minimap
		if( LootLink_MouseIsOver(MinimapCluster) ) then
			return nil;
		end
	
		local field = getglobal("GameTooltipTextLeft1");
		if( field and field:IsShown() ) then
			local name = field:GetText();
			if( name ) then
				if( ItemLinks[name] ) then
					LootLink_AddTooltipInfo(name, GameTooltip);
				end
				-- Whether or not we had information for this item, there's no need to check it again
				return nil;
			end
		end
	end
	
	return 1;
end

local function LootLink_CheckVersionReminder()
	local index;
	local value;
	local version;
	
	version = LootLink_GetDataVersion();
	for index, value in LOOTLINK_DATA_UPGRADE_HELP do
		if( version < value.version ) then
			DEFAULT_CHAT_FRAME:AddMessage(value.text);
		end
	end
end

local function LootLink_UpgradeData()
	local index;
	local item;
	
	for index, item in ItemLinks do
		LootLink_ConvertServerFormat(item);
		if( item.item ) then
			item.i = item.item;
			item.item = nil;
		end
		if( item.color ) then
			item.c = item.color;
			item.color = nil;
		end
		if( item.price ) then
			item.p = item.price;
			item.price = nil;
		end
		if( item.stack ) then
			item.x = item.stack;
			item.stack = nil;
		end
		
		if( item.SearchData ) then
			local data = "";

			if( item.SearchData.type ) then
				data = data.."ty"..item.SearchData.type.."·";
			end
			if( item.SearchData.location ) then
				data = data.."lo"..LocationTypes[item.SearchData.location].i.."·";
			end
			if( item.SearchData.subtype ) then
				data = data.."su"..item.SearchData.subtype.."·";
			end
			if( item.SearchData.binds ) then
				data = data.."bi"..item.SearchData.binds.."·";
			end
			if( item.SearchData.level ) then
				data = data.."le"..item.SearchData.level.."·";
			end
			if( item.SearchData.armor ) then
				data = data.."ar"..item.SearchData.armor.."·";
			end
			if( item.SearchData.minDamage ) then
				data = data.."mi"..item.SearchData.minDamage.."·";
			end
			if( item.SearchData.maxDamage ) then
				data = data.."ma"..item.SearchData.maxDamage.."·";
			end
			if( item.SearchData.speed ) then
				data = data.."sp"..item.SearchData.speed.."·";
			end
			if( item.SearchData.DPS ) then
				data = data.."dp"..item.SearchData.DPS.."·";
			end
			if( item.SearchData.unique ) then
				data = data.."un"..item.SearchData.unique.."·";
			end
			if( item.SearchData.block ) then
				data = data.."bl"..item.SearchData.block.."·";
			end
			if( item.SearchData.slots ) then
				data = data.."sl"..item.SearchData.slots.."·";
			end
			if( item.SearchData.skill ) then
				data = data.."sk"..item.SearchData.skill.."·";
			end
			
			if( item.SearchData.text ) then
				item.t = item.SearchData.text;
			end
			
			item.d = data;
			item.SearchData = nil;
		end
	end
end

local function LootLink_VariablesLoaded()
	local index;
	local value;

	if( not LootLinkState ) then
		LootLinkState = { };
	elseif ( LootLinkState.options ) then
		for k, v in LootLinkState.options do
			LootLinkState[k] = v;
		end
		LootLinkState.options = nil;
	end
	
	if( not ItemLinks ) then
		LootLink_Reset();
	end
	
	lServer = GetCVar("realmName");
	lServerIndex = LootLink_AddServer(lServer);
	
	LootLink_UpgradeData();
	
	LootLink_InitSizes(lServerIndex);
	
	-- Display and move minimap button --
	if ( not LootLinkState.hideminimap ) then
		LootLinkMinimapButton:Show();
		LootLink_Minimap_Position();
	end
	
	if ( LootLinkState.mouseover ) then	
		this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
	end
	if ( LootLinkState.sortType ) then
		LootLink_UIDropDownMenu_SetSelectedID(LootLinkFrameDropDown, LootLinkState.sortType, LOOTLINK_DROPDOWN_LIST);
	end
end

--------------------------------------------------------------------------------------------------
-- OnFoo functions
--------------------------------------------------------------------------------------------------
function LootLink_OnLoad()
	local index;
	local value;

	for index, value in ChatMessageTypes do
		this:RegisterEvent(value);
	end
	
	for index = 1, getn(INVENTORY_SLOT_LIST), 1 do
		INVENTORY_SLOT_LIST[index].id = GetInventorySlotInfo(INVENTORY_SLOT_LIST[index].name);
	end
	
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	this:RegisterEvent("BANKFRAME_OPENED");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("AUCTION_HOUSE_SHOW");
	this:RegisterEvent("AUCTION_HOUSE_CLOSE");
	this:RegisterEvent("AUCTION_ITEM_LIST_UPDATE");
	this:RegisterEvent("MERCHANT_SHOW");
	--this:RegisterEvent("PLAYER_LOGOUT");
	this:RegisterEvent("MEMORY_EXHAUSTED");
	this:RegisterEvent("MEMORY_RECOVERED");

	-- Register our slash command
	SLASH_LOOTLINK1 = "/lootlink";
	SLASH_LOOTLINK2 = "/ll";
	SlashCmdList["LOOTLINK"] = function(msg)
		LootLink_SlashCommandHandler(msg);
	end
	
	-- Hook the GameTooltip:SetOwner function
	lOriginal_GameTooltip_SetOwner = GameTooltip.SetOwner;
	GameTooltip.SetOwner = LootLink_GameTooltip_SetOwner;
	
	-- Hook the ContainerFrameItemButton_OnEnter, ContainerFrame_Update and GameTooltip:SetLootItem functions
	lOriginal_ContainerFrameItemButton_OnEnter = ContainerFrameItemButton_OnEnter;
	ContainerFrameItemButton_OnEnter = LootLink_ContainerFrameItemButton_OnEnter;
	lOriginal_ContainerFrame_Update = ContainerFrame_Update;
	ContainerFrame_Update = LootLink_ContainerFrame_Update;
	lOriginal_GameTooltip_SetLootItem = GameTooltip.SetLootItem;
	GameTooltip.SetLootItem = LootLink_GameTooltip_SetLootItem;
	
	-- Hook GameTooltip_OnHide and GameTooltip_ClearMoney
	lOriginal_GameTooltip_OnHide = GameTooltip_OnHide;
	GameTooltip_OnHide = LootLink_GameTooltip_OnHide;
	lOriginal_GameTooltip_ClearMoney = GameTooltip_ClearMoney;
	GameTooltip_ClearMoney = LootLink_GameTooltip_ClearMoney;
	
	-- Hook the shopping tooltip functions
	lOriginal_ShoppingTooltip1_SetMerchantCompareItem = ShoppingTooltip1.SetMerchantCompareItem;
	ShoppingTooltip1.SetMerchantCompareItem = LootLink_ShoppingTooltip1_SetMerchantCompareItem;
	lOriginal_ShoppingTooltip2_SetMerchantCompareItem = ShoppingTooltip2.SetMerchantCompareItem;
	ShoppingTooltip2.SetMerchantCompareItem = LootLink_ShoppingTooltip2_SetMerchantCompareItem;

	lOriginal_ShoppingTooltip1_SetAuctionCompareItem = ShoppingTooltip1.SetAuctionCompareItem;
	ShoppingTooltip1.SetAuctionCompareItem = LootLink_ShoppingTooltip1_SetAuctionCompareItem;
	lOriginal_ShoppingTooltip2_SetAuctionCompareItem = ShoppingTooltip2.SetAuctionCompareItem;
	ShoppingTooltip2.SetAuctionCompareItem = LootLink_ShoppingTooltip2_SetAuctionCompareItem;
	
	-- Hook SetItemRef
	lOriginal_SetItemRef = SetItemRef;
	SetItemRef = LootLink_SetItemRef;
	
	-- Hook our hidden tooltip's OnTooltipAddMoney
	lOriginal_OnTooltipAddMoney = LLHiddenTooltip:GetScript("OnTooltipAddMoney");
	LLHiddenTooltip:SetScript("OnTooltipAddMoney", LootLink_OnTooltipAddMoney);
	
	-- Hook chat edit box
	lOriginal_ChatEdit_OnTabPressed = ChatEdit_OnTabPressed;
	ChatEdit_OnTabPressed = LootLink_ChatEdit_OnTabPressed;
	lOriginal_ChatEdit_OnTextChanged = ChatEdit_OnTextChanged;
	ChatEdit_OnTextChanged = LootLink_ChatEdit_OnTextChanged;
	
	-- Hook CloseWindows
	lOriginal_CloseWindows = CloseWindows;
	CloseWindows = LootLink_CloseWindows;

	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_LOADED);
	end
	UIErrorsFrame:AddMessage(LOOTLINK_LOADED, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
end

function LootLink_Minimap_OnEnter()
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT");
	GameTooltip:AddLine(LOOTLINK_TITLE);
	if ( not LootLinkState.lockminimap ) then
		GameTooltip:AddLine("|cffaaaaaa "..LOOTLINK_MINIMAP_DRAG);
	end
	if ( LootLinkFrame.process ) then
		GameTooltip:AddLine("|cffaaaaaa "..getglobal("LLP_"..LootLinkFrame.process.."_LABEL"));
		if ( LootLink_Process:IsVisible() ) then
			GameTooltip:AddLine("|cffaaaaaa "..LOOTLINK_MINIMAP_PROCESS_SHOW);
		else
			GameTooltip:AddLine("|cffaaaaaa "..LOOTLINK_MINIMAP_PROCESS_HIDE);
		end
	end
	GameTooltip:Show();
end

function LootLink_Minimap_Position(x,y)
	if ( x or y ) then
		if ( x ) then if ( x < 0 ) then x = x + 360; end LootLinkState.x = x; end
		if ( y ) then LootLinkState.y = y; end
	end
	x, y = LootLinkState.x, LootLinkState.y

	if ( LootLinkOptionsFrame:IsVisible() ) then
		LLO_MinimapPos:SetValue( x or LLO_MINIMAP_X );
		LLO_MinimapOffset:SetValue( y or LLO_MINIMAP_Y );
	end
	LootLinkMinimapButton:SetPoint("TOPLEFT","Minimap","TOPLEFT",53-((80+(y or LLO_MINIMAP_Y))*cos(x or LLO_MINIMAP_X)),((80+(y or LLO_MINIMAP_Y))*sin(x or LLO_MINIMAP_X))-55);
end

function LootLink_Minimap_DragStart()
	if ( LootLinkState.lockminimap ) then return; end
	this:SetScript("OnUpdate", LootLink_Minimap_DragUpdate);
end
function LootLink_Minimap_DragStop()
	LootLinkMinimapButton:UnlockHighlight()
	this:SetScript("OnUpdate", nil);
end
function LootLink_Minimap_DragUpdate()
	-- Thanks to Gello for making this a ton shorter
	LootLinkMinimapButton:LockHighlight();
	local curX, curY = GetCursorPosition();
	local mapX, mapY = Minimap:GetCenter();
	local x, y;
	if ( IsShiftKeyDown() ) then
		y = math.pow( math.pow(curY - mapY * Minimap:GetEffectiveScale(), 2) + math.pow(mapX * Minimap:GetEffectiveScale() - curX, 2), 0.5) - 70;
		y = min( max( y, -30 ), 30 );
	end
	x = math.deg(math.atan2( curY - mapY * Minimap:GetEffectiveScale(), mapX * Minimap:GetEffectiveScale() - curX ));
	LootLink_Minimap_Position(x,y);
end

function LootLink_CanSendAuctionQuery()
	local value = lOriginal_CanSendAuctionQuery();
	if( value ) then
		LootLink_AuctionNextQuery();
		return nil;
	end
	return value;
end

function LootLink_AuctionFrameBrowse_OnEvent()
	-- Intentionally empty; don't allow the auction UI to update while we're scanning
end

function LootLink_GameTooltip_SetOwner(this, owner, anchor)
	lOriginal_GameTooltip_SetOwner(this, owner, anchor);
	lGameToolTipOwner = owner;
end

function LootLink_GameTooltip_ClearMoney()
	lOriginal_GameTooltip_ClearMoney();
	if( not lSuppressInfoAdd ) then
		lCheckTooltip = LootLink_CheckTooltipInfo();
	end
end

function LootLink_GameTooltip_ClearMoney_Temp()
	-- Intentionally empty; don't clear money while we use our hidden tooltip
end

function LootLink_ContainerFrameItemButton_OnEnter()
	LootLink_AutoInfoOff();
	lOriginal_ContainerFrameItemButton_OnEnter();
	if( not InRepairMode() and not MerchantFrame:IsVisible() ) then
		local frameID = this:GetParent():GetID();
		local buttonID = this:GetID();
		local link = GetContainerItemLink(frameID, buttonID);
		local name = LootLink_NameFromLink(link);
		
		if( name and ItemLinks[name] ) then
			local texture, itemCount, locked, quality, readable = GetContainerItemInfo(frameID, buttonID);
			LootLink_AddTooltipInfo(name, GameTooltip, itemCount);
			GameTooltip:Show();
		end
	end
	LootLink_AutoInfoOn();
end

function LootLink_ContainerFrame_Update(frame)
	LootLink_AutoInfoOff();
	lOriginal_ContainerFrame_Update(frame);
	if( not InRepairMode() and not MerchantFrame:IsVisible() and GameTooltip:IsVisible() ) then
		local frameID = frame:GetID();
		local frameName = frame:GetName();
		local iButton;
		for iButton = 1, frame.size do
			local button = getglobal(frameName.."Item"..iButton);
			if( GameTooltip:IsOwned(button) ) then
				local buttonID = button:GetID();
				local link = GetContainerItemLink(frameID, buttonID);
				local name = LootLink_NameFromLink(link);
				
				if( name and ItemLinks[name] ) then
					local texture, itemCount, locked, quality, readable = GetContainerItemInfo(frameID, buttonID);
					LootLink_AddTooltipInfo(name, GameTooltip, itemCount);
					GameTooltip:Show();
				end
			end
		end
	end
	LootLink_AutoInfoOn();
end

function LootLink_GameTooltip_OnHide()
	lOriginal_GameTooltip_OnHide();
	GameTooltip.llDone = nil;
	lCheckTooltip = nil;
end

function LootLink_GameTooltip_SetLootItem(this, slot)
	LootLink_AutoInfoOff();
	lOriginal_GameTooltip_SetLootItem(this, slot);
	
	local link = GetLootSlotLink(slot);
	local name = LootLink_NameFromLink(link);
	if( name and ItemLinks[name] and ItemLinks[name].p ) then
		local texture, item, quantity, quality = GetLootSlotInfo(slot);
		LootLink_AddTooltipInfo(name, GameTooltip, quantity);
	end
	LootLink_AutoInfoOn();
end

function LootLink_ShoppingTooltip1_SetMerchantCompareItem(this, id, num)
	LootLink_MoneyToggle();
	local retval = lOriginal_ShoppingTooltip1_SetMerchantCompareItem(this, id, num);
	LootLink_MoneyToggle(1);
	return retval;
end

function LootLink_ShoppingTooltip2_SetMerchantCompareItem(this, id, num)
	LootLink_MoneyToggle();
	local retval = lOriginal_ShoppingTooltip2_SetMerchantCompareItem(this, id, num);
	LootLink_MoneyToggle(1);
	return retval;
end

function LootLink_ShoppingTooltip1_SetAuctionCompareItem(this, _type, index, num)
	LootLink_MoneyToggle();
	local retval = lOriginal_ShoppingTooltip1_SetAuctionCompareItem(this, _type, index, num);
	LootLink_MoneyToggle(1);
	return retval;
end

function LootLink_ShoppingTooltip2_SetAuctionCompareItem(this, _type, index, num)
	LootLink_MoneyToggle();
	local retval = lOriginal_ShoppingTooltip2_SetAuctionCompareItem(this, _type, index, num);
	LootLink_MoneyToggle(1);
	return retval;
end

function LootLink_SetItemRef(link, text, button)
	lOriginal_SetItemRef(link, text, button);

	-- If this is a tooltip-creating link, add our information to it
	if( strsub(link, 1, 6) ~= "Player" ) then
		ItemRefTooltipMoneyFrame:SetPoint("LEFT", "ItemRefTooltipTextLeft1", "LEFT", 0, 0);
		ItemRefTooltipMoneyFrame:Hide();

		if( ItemRefTooltip:IsVisible() ) then
			local field = getglobal("ItemRefTooltipTextLeft1");
			if( field and field:IsShown() ) then
				local name = field:GetText();
				if( name and ItemLinks[name] ) then
					LootLink_AddTooltipInfo(name, ItemRefTooltip);
				end
			end
		end
	end
end

function LootLink_OnTooltipAddMoney()
	lOriginal_OnTooltipAddMoney();
	if( lBagID and lSlotID ) then
		LootLink_ScanSellPrice(arg1);
	end
end

function LootLink_OnEvent()
	if( event == "PLAYER_TARGET_CHANGED" ) then
		if( UnitIsUnit("target", "player") ) then
			return;
		elseif( UnitIsPlayer("target") ) then
			LootLink_Inspect("target");
		end
	elseif( event == "UPDATE_MOUSEOVER_UNIT" ) then
		LootLink_Inspect("mouseover");
	elseif( event == "PLAYER_ENTERING_WORLD" ) then
		this:RegisterEvent("UNIT_INVENTORY_CHANGED");
		-- Now that we're in the world, we want to watch for inventory changes
		this:RegisterEvent("UNIT_INVENTORY_CHANGED");

		-- Check to see if the user needs to upgrade their database
		LootLink_CheckVersionReminder();
		
		-- Do initial scan of inventory and equipped items
		LootLink_ScanInventory();
		LootLink_Inspect("player");
	elseif( event == "PLAYER_LEAVING_WORLD" ) then
		-- When we leave the world, we don't need to watch for inventory changes,
		-- especially since zoning will cause one UNIT_INVENTORY_CHANGED event for
		-- each item in the player's inventory and that they have equipped
		this:UnregisterEvent("UNIT_INVENTORY_CHANGED");
	elseif( event == "UNIT_INVENTORY_CHANGED" ) then
		if( arg1 == "player" ) then
			LootLink_ScanInventory();
			LootLink_Inspect("player");
		end
	elseif( event == "BANKFRAME_OPENED" ) then
		LootLink_ScanBank();
	elseif( event == "VARIABLES_LOADED" ) then
		LootLink_VariablesLoaded();
	elseif( event == "AUCTION_HOUSE_SHOW" ) then
		if( lScanAuction ) then
			LootLink_StartAuctionScan();
		end
	elseif( event == "AUCTION_HOUSE_CLOSED" ) then
		LootLink_StopAuctionScan();
	elseif( event == "AUCTION_ITEM_LIST_UPDATE" ) then
		LootLink_ScanAuction();
	elseif( event == "MERCHANT_SHOW" ) then
		LootLink_ScanSellPrices();
	--elseif( event == "PLAYER_LOGOUT" ) then
		--LootLink_ClearDelayed();
	elseif( event == "MEMORY_EXHAUSTED" ) then
		LLP_OUTOFMEM = 1;
	elseif( event == "MEMORY_RECOVERED" ) then
		LLP_OUTOFMEM = nil;
	else
		local name = LootLink_ProcessLinks(arg1, event == "CHAT_MSG_LOOT");
		if( name and ItemLinks[name] ) then
			LootLink_Event_ScanChat(name, ItemLinks[name], arg1);
		end
	end
end

function LootLink_RemoveItem(name, link, displayindex, index)
	local value = ItemLinks[name];
	if ( not value ) then
		return;
	end
	local found;
	if ( link and string.sub(link, 1, 5) == "item:" ) then
		link = string.sub( link, 6 );
	end
	if ( displayindex and not link and not index ) then
		link = DisplayIndices[displayindex][2].i;
	end
	if ( not link and not index ) then
		index = 0;
	end
	if ( link or index ) then
		if ( (index and index == 0) or (value.i and value.i == link) ) then
			found = 1;
			if ( value.m and value.m[1] ) then
				for k, v in value.m[1] do
					value[k] = v;
				end
				tremove( value.m, 1 );

				if ( getn(value.m) == 0 ) then
					value.m = nil;
				end
			else
				ItemLinks[name] = nil;
				di = 0;
			end
		else
			if ( value.m ) then
				for i=1, getn(value.m) do
					if ( (index and index == i) or (value.m[i].i == link) ) then
						found = 1;
						tremove( value.m, i );
						break;
					end
				end
			end
		end
		
		if ( found ) then
			LootLink_SortAlternates( name );
		
			if ( DisplayIndices and LootLinkFrame:IsVisible() ) then
				local dName, start;
				local i = 1;
				if ( DisplayIndices[i] ) then
					dName = DisplayIndices[i][1];
				end
				while dName do
					if dName == name then
						if not start then
							start = i;
						end
					elseif start then
						break;
					end
					i = i+1;
					if ( DisplayIndices[i] ) then
						dName = DisplayIndices[i][1];
					else
						dName = nil;
					end
				end
				if ( start and i ) then
					tremove(DisplayIndices, i-1);
					DisplayIndices.onePastEnd = DisplayIndices.onePastEnd - 1;
					if ( displayindex ) then
						LootLink_Update();
						LootLink_SetTitle();
					end
				end
			else
				DisplayIndices = nil;
			end
			return 1;
		end
	end
end

function LootLinkItemButton_OnClick(button)
	local name = this:GetText();
	local index = this.i;
	if( button == "LeftButton" ) then
		local data = DisplayIndices[this:GetID()+FauxScrollFrame_GetOffset(LootLinkListScrollFrame)];
		if( IsShiftKeyDown() and ChatFrameEditBox:IsVisible() ) then
			if ( not LootLink_CheckItemServer(data[2], lServerIndex) ) then
				local dialog = StaticPopup_Show("LOOTLINK_LINK_CONFIRM", LOOTLINK_STATICPOPUP_SERVER, LOOTLINK_STATICPOPUP_LINKITEM);
				if ( dialog ) then
					dialog.data = data;
				end
			elseif ( not GetItemInfo("item:"..data[2].i) ) then
				local dialog = StaticPopup_Show("LOOTLINK_LINK_CONFIRM", LOOTLINK_STATICPOPUP_INVALID, LOOTLINK_STATICPOPUP_LINKITEM);
				if ( dialog ) then
					dialog.data = data;
				end
			else			
				ChatFrameEditBox:Insert(LootLink_GetLink(name, data[3]));
			end
		end
		if( IsControlKeyDown() ) then
			if ( not LootLink_CheckItemServer(data[2], lServerIndex) ) then
				local dialog = StaticPopup_Show("LOOTLINK_DRESSUP_CONFIRM", LOOTLINK_STATICPOPUP_SERVER, LOOTLINK_STATICPOPUP_DRESSUP);
				if ( dialog ) then
					dialog.data = data;
				end
			elseif ( not GetItemInfo("item:"..data[2].i) ) then
				local dialog = StaticPopup_Show("LOOTLINK_DRESSUP_CONFIRM", LOOTLINK_STATICPOPUP_INVALID, LOOTLINK_STATICPOPUP_DRESSUP);
				if ( dialog ) then
					dialog.data = data;
				end
			else			
				DressUpItemLink(LootLink_GetLink(name, data[3]));
			end
		end
	elseif( button == "RightButton" ) then
		if( IsShiftKeyDown() and IsControlKeyDown() ) then
			local data = DisplayIndices[this:GetID()+FauxScrollFrame_GetOffset(LootLinkListScrollFrame)];
			local dialog = StaticPopup_Show("LOOTLINK_DELETEITEM_CONFIRM", data[2].c, name);
			if ( dialog ) then
				dialog.data = data;
			end
			--if ( LootLink_RemoveItem(name, nil, this:GetID()+FauxScrollFrame_GetOffset(LootLinkListScrollFrame)) ) then
			--	LootLink_SortAlternates(name);
			--end
		end
	end
	--@todo Telo: add a method to correct the color of items
end

function LootLink_OnShow()
	PlaySound("igMainMenuOpen");
	LootLink_Update();
end

function LootLink_OnHide()
	PlaySound("igMainMenuClose");
end

function LootLink_ClearDelayed()
	if ( LootLinkFrame.schedule ) then
		for k, v in LootLinkFrame.schedule do
			local value, index = LootLink_GetValue( v[1], nil, v[2] );
			if ( v and not v.t ) then
				if ( LootLink_RemoveItem(v[1], v[2]) ) then
					LootLink_SortAlternates(v[1]);
				end
			end
		end
	end
	LootLinkFrame.schedule = nil;
end

function LootLink_ScheduleItem(name,link,time)
	if ( not LootLinkFrame.schedule ) then
		LootLinkFrame.schedule = {};
	end
	for k, v in LootLinkFrame.schedule do
		if ( v[1] == name and v[2] == link ) then
			return;
		end
	end
	LLHiddenTooltip:SetHyperlink("item:"..link);
	tinsert( LootLinkFrame.schedule, {name,link,(time or LOOTLINK_SCHEDULE_DELAY)} );
end
	
function LootLink_OnUpdate(elapsed)
	if( lCheckTooltip ) then
		lCheckTooltip = LootLink_CheckTooltipInfo();
	end
	if ( LootLinkFrame.process ) then
		LootLinkProcess_Run();
	end
	local list = LootLinkFrame.schedule;
	if ( list ) then
		for k, v in list do
			v[3] = v[3] - elapsed;
			if ( v[3] < 0 ) then
				local value, index = LootLink_GetValue( v[1], nil, v[2] );
				if ( not value ) then
					-- Item was remove from ItemLinks table, stop trying to check for it.
					tremove( list, k );
					return;	
				elseif ( LootLink_BuildSearchData( v[1], value, index ) ) then
					tremove( list, k );
					return;
				else
					-- Still don't have information from server.
					if ( v[4] and v[4] == 60 ) then
						-- we've tried long enough, fail this item;
						if ( LootLink_RemoveItem(v[1], v[2]) ) then
							LootLink_SortAlternates(name);
						end
						tremove( list, k );
						return;
					end
					v[4] = (v[4] or 0) + 1;
					v[3] = LOOTLINK_SCHEDULE_DELAY;
				end
			end
		end
		if ( getn(list) == 0 ) then
			list = nil;
		end
	end
end

function LootLinkItemButton_OnEnter()
	local link = LootLink_GetHyperlink(this:GetText(), this.i);
	if( link ) then
		LootLinkFrame.TooltipButton = this:GetID();
		LootLinkTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
		if ( LootLink_SetHyperlink(LootLinkTooltip, this:GetText(), link, this.i) ) then
			LootLink_Update();
		end
		LootLink_AddTooltipTexture(link);
		LootLink_AddTooltipInfo(this:GetText(), nil, nil, this.i);
	end
end

function LootLinkItemButton_OnLeave()
	if( LootLinkFrame.TooltipButton ) then
		LootLinkFrame.TooltipButton = nil;
		HideUIPanel(LootLinkTooltip);
	end
	LootLink_AddTooltipTexture();
end

function LootLinkFrameDropDown_OnLoad()
	UIDropDownMenu_Initialize(LootLinkFrameDropDown, LootLinkFrameDropDown_Initialize);
	LootLink_UIDropDownMenu_SetSelectedID(LootLinkFrameDropDown, 1, LOOTLINK_DROPDOWN_LIST);
	UIDropDownMenu_SetWidth(80);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", LootLinkFrameDropDown)
end

function LootLinkFrameDropDownButton_OnClick()
	local oldID = UIDropDownMenu_GetSelectedID(LootLinkFrameDropDown);
	UIDropDownMenu_SetSelectedID(LootLinkFrameDropDown, this:GetID());
	if( oldID ~= this:GetID() ) then
		LootLink_Refresh();
	end
	LootLinkState.sortType = this:GetID();
end

function LLS_RarityDropDown_OnLoad()
	UIDropDownMenu_SetWidth(90);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", LLS_RarityDropDown);
end

function LLS_RarityDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(LLS_RarityDropDown, this:GetID());
end

function LLS_BindsDropDown_OnLoad()
	UIDropDownMenu_SetWidth(90);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", LLS_BindsDropDown);
end

function LLS_BindsDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(LLS_BindsDropDown, this:GetID());
end

function LLS_LocationDropDown_OnLoad()
	UIDropDownMenu_SetWidth(90);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", LLS_LocationDropDown);
end

function LLS_LocationDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(LLS_LocationDropDown, this:GetID());
end

function LLS_TypeDropDown_OnLoad()
	UIDropDownMenu_SetWidth(90);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", LLS_TypeDropDown);
end

function LLS_TypeDropDown_OnClick()
	local oldID = UIDropDownMenu_GetSelectedID(LLS_TypeDropDown);
	UIDropDownMenu_SetSelectedID(LLS_TypeDropDown, this:GetID());
	if( oldID ~= this:GetID() ) then
		LootLink_SetupTypeUI(this:GetID(), 1);
	end
end

function LLS_SubtypeDropDown_OnLoad()
	UIDropDownMenu_SetWidth(90);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", LLS_SubtypeDropDown);
end

function LLS_SubtypeDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(LLS_SubtypeDropDown, this:GetID());
end

function LLO_RarityDropDown_OnLoad()
	UIDropDownMenu_SetWidth(90);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", LLO_RarityDropDown);
end

function LLO_RarityDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(LLO_RarityDropDown, this:GetID());
end

--------------------------------------------------------------------------------------------------
-- Callback functions
--------------------------------------------------------------------------------------------------
function ToggleLootLink()
	if( LootLinkFrame:IsVisible() ) then
		HideUIPanel(LootLinkFrame);
	else
		ShowUIPanel(LootLinkFrame);
	end
end

function LootLink_SlashCommandHandler(msg)
	local reset;
	local makehome;
	local light;
	local aborted;

	if( not lDisableVersionReminder ) then
		LootLink_CheckVersionReminder();
	end
	if( not msg or msg == "" ) then
		ToggleLootLink();
	else
		local command = string.lower(msg);
		if( command == LOOTLINK_HELP ) then
			local index = 0;
			local value = getglobal("LOOTLINK_HELP_TEXT"..index);
			while( value ) do
				DEFAULT_CHAT_FRAME:AddMessage(value);
				index = index + 1;
				value = getglobal("LOOTLINK_HELP_TEXT"..index);
			end
		elseif( command == LOOTLINK_STATUS ) then
			LootLink_Status();
		elseif( command == LOOTLINK_AUCTION or command == LOOTLINK_SCAN ) then
			if( AuctionFrame and AuctionFrame:IsVisible() ) then
				local iButton;
				local button;

				-- Hide the UI from any current results, show the no results text so we can use it
				BrowseNoResultsText:Show();
				for iButton = 1, NUM_BROWSE_TO_DISPLAY do
					button = getglobal("BrowseButton"..iButton);
					button:Hide();
				end
				BrowsePrevPageButton:Hide();
				BrowseNextPageButton:Hide();
				BrowseSearchCountText:Hide();

				LootLink_StartAuctionScan();
			else
				lScanAuction = 1;
				LootLink_Status();
			end
		elseif( command == LOOTLINK_SHOWINFO ) then
			LootLinkState.HideInfo = nil;
			LootLink_Status();
		elseif( command == LOOTLINK_HIDEINFO ) then
			LootLinkState.HideInfo = 1;
			LootLink_Status();
		elseif( command == LOOTLINK_FULLMODE ) then
			LootLinkState.LightMode = nil;
			LootLink_Status();
		else
			local iStart;
			local iEnd;
			local args;
			
			iStart, iEnd, command, args = string.find(command, "^(%w+)%s*(.*)$");
	
			if( command == LOOTLINK_RESET ) then
				if( lResetNeedsConfirm ) then
					if( args == LOOTLINK_CONFIRM ) then
						LootLink_Reset();
						lResetNeedsConfirm = nil;
						lDisableVersionReminder = nil
						DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_RESET_DONE);
					end
				else
					reset = 1;
					lResetNeedsConfirm = 1;
					lDisableVersionReminder = 1;
				end
			elseif( LootLink_GetDataVersion() < 110 and command == LOOTLINK_MAKEHOME ) then
				if( lMakeHomeNeedsConfirm ) then
					if( args == LOOTLINK_CONFIRM ) then
						LootLink_MakeHome();
						lMakeHomeNeedsConfirm = nil;
						lDisableVersionReminder = nil;
						DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_MAKEHOME_DONE);
					end
				else
					makehome = 1;
					lMakeHomeNeedsConfirm = 1;
					lDisableVersionReminder = 1;
				end
			elseif( command == LOOTLINK_LIGHTMODE ) then
				if( lLightModeNeedsConfirm ) then
					if( args == LOOTLINK_CONFIRM ) then
						LootLink_LightMode();
						lLightModeNeedsConfirm = nil;
						DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_LIGHTMODE_DONE);
					end
				else
					light = 1;
					lLightModeNeedsConfirm = 1;
				end
			end
		end
	end
	
	if( not reset ) then
		if( lResetNeedsConfirm ) then
			aborted = 1;
			lResetNeedsConfirm = nil;
			DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_RESET_ABORTED);
		end
	end
	
	if( not makehome ) then
		if( lMakeHomeNeedsConfirm ) then
			aborted = 1;
			lMakeHomeNeedsConfirm = nil;
			DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_MAKEHOME_ABORTED);
		end
	end
	
	if( not light ) then
		if( lLightModeNeedsConfirm ) then
			lLightModeNeedsConfirm = nil;
			DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_LIGHTMODE_ABORTED);
		end
	end
	
	if( reset ) then
		DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_RESET_NEEDS_CONFIRM);
	end
	
	if( makehome ) then
		DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_MAKEHOME_NEEDS_CONFIRM);
	end
	
	if( light ) then
		DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_LIGHTMODE_NEEDS_CONFIRM);
	end
	
	if( aborted and not reset and not makehome ) then
		lDisableVersionReminder = nil
	end
end

function LootLink_Update()
	local iItem;
	
	if( not DisplayIndices ) then
		LootLink_BuildDisplayIndices();
	end
	FauxScrollFrame_Update(LootLinkListScrollFrame, DisplayIndices.onePastEnd - 1, LOOTLINK_ITEMS_SHOWN, LOOTLINK_ITEM_HEIGHT, nil, nil, nil, LootLinkHighlightFrame, 293, 316);
	LootLinkHighlightFrame:Hide();
	for iItem = 1, LOOTLINK_ITEMS_SHOWN, 1 do
		local itemIndex = iItem + FauxScrollFrame_GetOffset(LootLinkListScrollFrame);
		local lootLinkItem = getglobal("LootLinkItem"..iItem);
		
		if( itemIndex < DisplayIndices.onePastEnd ) then
			local value = DisplayIndices[itemIndex][2]; --LootLink_GetValue(DisplayIndices[itemIndex]);
			if ( not value ) then
				LootLink_Refresh();
				return;
			end
			if ( value ) then		
				local color = { };
				local name = DisplayIndices[itemIndex][1]; --LootLink_GetName(DisplayIndices[itemIndex]);
				local index = DisplayIndices[itemIndex][3];
				local extra = getglobal(lootLinkItem:GetName().."Type");
				lootLinkItem.i = nil;
				local text = getglobal(lootLinkItem:GetName().."Text");
				local indexed = getglobal(lootLinkItem:GetName().."Indexed");
				text:SetPoint( "LEFT",  20, 0 );
				text:SetWidth(275);
				getglobal(lootLinkItem:GetName().."Indexed"):Hide();
				if ( index and index > 0 ) then
					lootLinkItem.i = index;
					if ( DisplayIndices[itemIndex-1] and DisplayIndices[itemIndex-1][1] == name ) then
						local _,_, enchant, bonus = string.find(value.i, "%d+:(%d+):(%d+):%d+");
						bonus = tonumber(bonus);
						enchant = tonumber(enchant);
						if ( bonus > 0 or enchant > 0 ) then
							text:SetPoint( "LEFT",  30, 0 );
							text:SetWidth(245);
							indexed:Show();
						end
						if ( enchant > 0 ) then
							indexed:SetVertexColor(0,1,0);
						else
							indexed:SetVertexColor(1,1,1);
						end
					end
				end
				local link = "item:"..value.i;
				local realname
				if ( link ) then
					realname = GetItemInfo( link );
				end
				local onserver = LootLink_CheckItemServer(value, lServerIndex);
				extra:SetVertexColor(1.0,1.0,1.0)
				SetDesaturation(extra,0);
				extra:SetAlpha(1.0);
				if ( not onserver ) then
					extra:SetTexture("Interface\\GossipFrame\\TaxiGossipIcon");
					extra:Show();
				elseif ( not realname ) then
					extra:SetTexture("Interface\\GossipFrame\\ActiveQuestIcon");
					extra:SetAlpha(0.5);
					SetDesaturation(extra,1);
					extra:Show();
				elseif ( not LootLink_ValidateItem(name, link) ) then
					extra:SetTexture("Interface\\GossipFrame\\AvailableQuestIcon");
					extra:SetVertexColor(1.0,0,0)
					extra:Show();
				else
					extra:Hide();
				end

				lootLinkItem:SetText(name);
				if( value.c ) then
					color.r, color.g, color.b = LootLink_GetRGBFromHexColor(value.c);
					lootLinkItem:SetTextColor(color.r, color.g, color.b);
					lootLinkItem.r = color.r;
					lootLinkItem.g = color.g;
					lootLinkItem.b = color.b;
				else
					lootLinkItem.r = 0;
					lootLinkItem.g = 0;
					lootLinkItem.b = 0;
				end
				if ( LootLinkFrame.qs and LootLinkFrame.qs == itemIndex ) then
					if ( color ) then
						LootLinkHighlight:SetVertexColor(color.r, color.g, color.b);
					else
						LootLinkHighlight:SetVertexColor(0.5, 0.5, 0.5);
					end
					lootLinkItem:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
					LootLinkHighlightFrame:SetPoint("TOPLEFT", "LootLinkItem"..iItem, "TOPLEFT", 0, 0);
					LootLinkHighlightFrame:Show();
				end
				lootLinkItem:Show();

				if( LootLinkFrame.TooltipButton and LootLinkFrame.TooltipButton == iItem ) then
					if( value.i ) then
						local link = LootLink_GetHyperlink(name, index);				
						LootLinkTooltip:SetOwner(lootLinkItem, "ANCHOR_BOTTOMRIGHT");
						LootLink_SetHyperlink(LootLinkTooltip, name, link, index);
						LootLink_AddTooltipInfo(name);
						LootLink_AddTooltipTexture(link);
						LootLinkTooltip:Show();
					else
						LootLinkItemButton_OnLeave();
					end
				end
			end
		else
			lootLinkItem:Hide();
		end
	end
end

function LootLink_Search()
	LootLinkSearchFrame:Show();
end

function LootLink_Refresh()
	FauxScrollFrame_SetOffset(LootLinkListScrollFrame, 0);
	getglobal("LootLinkListScrollFrameScrollBar"):SetValue(0);
	LootLink_BuildDisplayIndices();
	LootLink_Update();
end

function LootLink_DoSearch()
	LootLink_Refresh();
end

function LootLinkSearch_LoadValues()
	local sp = LootLinkFrame.SearchParams;
	local field;
	
	if( LootLinkState.LightMode ) then
		getglobal("LLS_TextDisabled"):Show();
		getglobal("LLS_TextEditBox"):Hide();
		getglobal("LLS_NameEditBox"):SetFocus();
	else
		getglobal("LLS_TextDisabled"):Hide();
		field = getglobal("LLS_TextEditBox");
		field:Show();
		field:SetFocus();
		if( sp and sp.text ) then
			field:SetText(sp.text);
		else
			field:SetText("");
		end
	end
	
	field = getglobal("LLS_NameEditBox");
	if( sp and sp.name ) then
		field:SetText(sp.name);
	else
		field:SetText("");
	end
	
	UIDropDownMenu_Initialize(LLS_RarityDropDown, LLS_RarityDropDown_Initialize);
	if( sp and sp.rarity ) then
		LootLink_UIDropDownMenu_SetSelectedID(LLS_RarityDropDown, sp.rarity, LLS_RARITY_LIST);
	else
		LootLink_UIDropDownMenu_SetSelectedID(LLS_RarityDropDown, 1, LLS_RARITY_LIST);
	end
	
	if( sp and sp.server ) then
		getglobal("LLS_ServerCheckButton"):SetChecked(1);
	else
		getglobal("LLS_ServerCheckButton"):SetChecked(0);
	end
	
	UIDropDownMenu_Initialize(LLS_BindsDropDown, LLS_BindsDropDown_Initialize);
	if( sp and sp.binds ) then
		LootLink_UIDropDownMenu_SetSelectedID(LLS_BindsDropDown, sp.binds, LLS_BINDS_LIST);
	else
		LootLink_UIDropDownMenu_SetSelectedID(LLS_BindsDropDown, 1, LLS_BINDS_LIST);
	end
	
	if( sp and sp.unique ) then
		getglobal("LLS_UniqueCheckButton"):SetChecked(1);
	else
		getglobal("LLS_UniqueCheckButton"):SetChecked(0);
	end
	
	UIDropDownMenu_Initialize(LLS_LocationDropDown, LLS_LocationDropDown_Initialize);
	if( sp and sp.location ) then
		LootLink_UIDropDownMenu_SetSelectedID(LLS_LocationDropDown, sp.location, LLS_LOCATION_LIST);
	else
		LootLink_UIDropDownMenu_SetSelectedID(LLS_LocationDropDown, 1, LLS_LOCATION_LIST);
	end
	
	if( LootLinkState and LootLinkState.spoof ) then
		LLS_SpoofCheckButton:Hide();
	else
		LLS_SpoofCheckButton:Show();
		if( sp and sp.spoof ) then
			getglobal("LLS_SpoofCheckButton"):SetChecked(1);
		else
			getglobal("LLS_SpoofCheckButton"):SetChecked(0);
		end
	end
	
	if( sp and sp.usable ) then
		getglobal("LLS_UsableCheckButton"):SetChecked(1);
	else
		getglobal("LLS_UsableCheckButton"):SetChecked(0);
	end
	
	field = getglobal("LLS_MinimumLevelEditBox");
	if( sp and sp.minLevel ) then
		field:SetText(sp.minLevel);
	else
		field:SetText("");
	end

	field = getglobal("LLS_MaximumLevelEditBox");
	if( sp and sp.maxLevel ) then
		field:SetText(sp.maxLevel);
	else
		field:SetText("");
	end
	
	UIDropDownMenu_Initialize(LLS_TypeDropDown, LLS_TypeDropDown_Initialize);
	if( sp and sp.type ) then
		LootLink_UIDropDownMenu_SetSelectedID(LLS_TypeDropDown, sp.type, LLS_TYPE_LIST);
	else
		LootLink_UIDropDownMenu_SetSelectedID(LLS_TypeDropDown, 1, LLS_TYPE_LIST);
	end
	
	if( sp and sp.type ) then
		LootLink_SetupTypeUI(sp.type, sp.subtype);
	else
		LootLink_SetupTypeUI(1, 1);
	end

	field = getglobal("LLS_MinimumDamageEditBox");
	if( sp and sp.minMinDamage ) then
		field:SetText(sp.minMinDamage);
	else
		field:SetText("");
	end
	
	field = getglobal("LLS_MaximumDamageEditBox");
	if( sp and sp.minMaxDamage ) then
		field:SetText(sp.minMaxDamage);
	else
		field:SetText("");
	end
	
	field = getglobal("LLS_MaximumSpeedEditBox");
	if( sp and sp.maxSpeed ) then
		field:SetText(sp.maxSpeed);
	else
		field:SetText("");
	end
	
	field = getglobal("LLS_MinimumDPSEditBox");
	if( sp and sp.minDPS ) then
		field:SetText(sp.minDPS);
	else
		field:SetText("");
	end
	
	field = getglobal("LLS_MinimumArmorEditBox");
	if( sp and sp.minArmor ) then
		field:SetText(sp.minArmor);
	else
		field:SetText("");
	end
	
	field = getglobal("LLS_MinimumBlockEditBox");
	if( sp and sp.minBlock ) then
		field:SetText(sp.minBlock);
	else
		field:SetText("");
	end
	
	field = getglobal("LLS_MinimumSlotsEditBox");
	if( sp and sp.minSlots ) then
		field:SetText(sp.minSlots);
	else
		field:SetText("");
	end
	
	field = getglobal("LLS_MinimumSkillEditBox");
	if( sp and sp.minSkill ) then
		field:SetText(sp.minSkill);
	else
		field:SetText("");
	end
	
	field = getglobal("LLS_MaximumSkillEditBox");
	if( sp and sp.maxSkill ) then
		field:SetText(sp.maxSkill);
	else
		field:SetText("");
	end
	
	--[[if( sp and sp.set ) then
		getglobal("LLS_SetCheckButton"):SetChecked(1);
	else
		getglobal("LLS_SetCheckButton"):SetChecked(0);
	end]]
end

function LootLinkSearch_SaveValues()
	local sp;
	local interesting;
	local field;
	local value;
	
	LootLinkFrame.SearchParams = { };
	sp = LootLinkFrame.SearchParams;
	
	field = getglobal("LLS_TextEditBox");
	value = field:GetText();
	if( value and value ~= "" ) then
		sp.text = value;
		interesting = 1;
	end
	
	field = getglobal("LLS_NameEditBox");
	value = field:GetText();
	if( value and value ~= "" ) then
		sp.name = value;
		interesting = 1;
	end
	
	value = UIDropDownMenu_GetSelectedID(LLS_RarityDropDown);
	if( value and value ~= 1 ) then
		sp.rarity = value;
		interesting = 1;
	end
	
	field = getglobal("LLS_ServerCheckButton");
	value = field:GetChecked();
	if( value ) then
		sp.server = value;
		interesting = 1;
	end
	
	value = UIDropDownMenu_GetSelectedID(LLS_BindsDropDown);
	if( value and value ~= 1 ) then
		sp.binds = value;
		interesting = 1;
	end
	
	field = getglobal("LLS_UniqueCheckButton");
	value = field:GetChecked();
	if( value ) then
		sp.unique = value;
		interesting = 1;
	end
	
	value = UIDropDownMenu_GetSelectedID(LLS_LocationDropDown);
	if( value and value ~= 1 ) then
		sp.location = value;
		interesting = 1;
	end
	
	field = getglobal("LLS_UsableCheckButton");
	value = field:GetChecked();
	if( value ) then
		sp.usable = value;
		interesting = 1;
	end
	
	field = getglobal("LLS_MinimumLevelEditBox");
	value = field:GetText();
	if( value and LootLink_CheckNumeric(value) ) then
		sp.minLevel = tonumber(value);
		interesting = 1;
	end
	
	field = getglobal("LLS_MaximumLevelEditBox");
	value = field:GetText();
	if( value and LootLink_CheckNumeric(value) ) then
		sp.maxLevel = tonumber(value);
		interesting = 1;
	end

	value = UIDropDownMenu_GetSelectedID(LLS_TypeDropDown);
	if( value and value ~= 1 ) then
		sp.type = value;
		interesting = 1;
	end
	
	field = getglobal("LLS_SpoofCheckButton");
	value = field:GetChecked();
	if( value ) then
		sp.spoof = value;
		interesting = 1;
	end
	
	value = UIDropDownMenu_GetSelectedID(LLS_SubtypeDropDown);
	if( value and value ~= 1 ) then
		sp.subtype = value;
		if( sp.type and sp.type ~= 1 ) then
			interesting = 1;
		end
	end

	field = getglobal("LLS_MinimumDamageEditBox");
	value = field:GetText();
	if( value and LootLink_CheckNumeric(value) ) then
		sp.minMinDamage = tonumber(value);
		interesting = 1;
	end
	
	field = getglobal("LLS_MaximumDamageEditBox");
	value = field:GetText();
	if( value and LootLink_CheckNumeric(value) ) then
		sp.minMaxDamage = tonumber(value);
		interesting = 1;
	end
	
	field = getglobal("LLS_MaximumSpeedEditBox");
	value = field:GetText();
	if( value and LootLink_CheckNumeric(value) ) then
		sp.maxSpeed = tonumber(value);
		interesting = 1;
	end
	
	field = getglobal("LLS_MinimumDPSEditBox");
	value = field:GetText();
	if( value and LootLink_CheckNumeric(value) ) then
		sp.minDPS = tonumber(value);
		interesting = 1;
	end
	
	field = getglobal("LLS_MinimumArmorEditBox");
	value = field:GetText();
	if( value and LootLink_CheckNumeric(value) ) then
		sp.minArmor = tonumber(value);
		interesting = 1;
	end
	
	field = getglobal("LLS_MinimumBlockEditBox");
	value = field:GetText();
	if( value and LootLink_CheckNumeric(value) ) then
		sp.minBlock = tonumber(value);
		interesting = 1;
	end

	field = getglobal("LLS_MinimumSlotsEditBox");
	value = field:GetText();
	if( value and LootLink_CheckNumeric(value) ) then
		sp.minSlots = tonumber(value);
		interesting = 1;
	end

	field = getglobal("LLS_MinimumSkillEditBox");
	value = field:GetText();
	if( value and LootLink_CheckNumeric(value) ) then
		sp.minSkill = tonumber(value);
		interesting = 1;
	end

	field = getglobal("LLS_MaximumSkillEditBox");
	value = field:GetText();
	if( value and LootLink_CheckNumeric(value) ) then
		sp.maxSkill = tonumber(value);
		interesting = 1;
	end
	
	--[[value = getglobal("LLS_SetCheckButton"):GetChecked();
	if ( value ) then
		sp.set = value;
		interesting = 1;
	end]]

	-- Only save search params if we had interesting data on the page	
	if( not interesting ) then
		LootLinkFrame.SearchParams = nil;
	else
		if( IsControlKeyDown() ) then
			sp.plain = nil;
		else
			sp.plain = 1;
		end
	end
end

function LootLinkSearchFrame_SaveSearchParams()
	LootLinkSearchFrame.OldSearchParams = LootLinkFrame.SearchParams;
end

function LootLinkSearchFrame_RestoreSearchParams()
	LootLinkFrame.SearchParams = LootLinkSearchFrame.OldSearchParams;
end

function LootLinkSearchFrame_ChangeFocus()
	local frames = {"LLS_TextEditBox",
		"LLS_NameEditBox",
		"LLS_MinimumLevelEditBox",
		"LLS_MaximumLevelEditBox",
		"LLS_MinimumSlotsEditBox",
		"LLS_MinimumDamageEditBox",
		"LLS_MaximumDamageEditBox",
		"LLS_MaximumSpeedEditBox",
		"LLS_MinimumDPSEditBox",
		"LLS_MinimumArmorEditBox",
		"LLS_MinimumBlockEditBox",
		"LLS_MinimumSkillEditBox",
		"LLS_MaximumSkillEditBox",
	}
	
	local name = this:GetName();
	for i=1, 13 do
		if ( frames[i] == name ) then
			if ( IsShiftKeyDown() ) then
				i = i-1;
			else
				i = i+1;
			end
			while frames[i] do
				local nextframe = getglobal(frames[i]);
				if ( nextframe:IsVisible() ) then
					nextframe:SetFocus();
					return;
				end
				if ( IsShiftKeyDown() ) then
					i = i-1;
				else
					i = i+1;
				end
			end
			return;
		end
	end
end

function LootLinkSearchFrame_Cancel()
	PlaySound("gsTitleOptionExit");
	LootLinkSearchFrame:Hide();
	LootLinkSearchFrame_RestoreSearchParams();
end

function LootLinkSearchFrame_Okay()
	PlaySound("gsTitleOptionOK");
	LootLinkSearchFrame:Hide();
	LootLinkSearch_SaveValues();
	LootLink_DoSearch();
end

function LootLinkQuickSearch_Search(Next)
	if ( not Next ) then
		Next = 0;
	end
	local text = LootLinkFrameQuickSearch:GetText();
	local length = string.len( text );
	local last = LootLinkFrameQuickSearch.last;
	local function DoScroll(i)
		local offset = FauxScrollFrame_GetOffset(LootLinkListScrollFrame);
		if ( i < offset or i > offset + LOOTLINK_ITEMS_SHOWN ) then
			if ( i > DisplayIndices.onePastEnd - LOOTLINK_ITEMS_SHOWN ) then
				i = DisplayIndices.onePastEnd - LOOTLINK_ITEMS_SHOWN;
			end
			i = i-1;
			local val = (i * 16) - 0.5
			LootLinkListScrollFrameScrollBar:SetValue(val);
			LootLinkListScrollFrame.offset = i;
		end
	end
	local function DoSearch(index, offset)
		if ( not offset ) then
			offset = getn(DisplayIndices);
		end
		for i=index+Next, offset do
			local name = LootLink_GetName(DisplayIndices[i]);
			if ( name and string.find( string.lower(name), string.lower(text), 1, 1 ) ) then
				LootLinkFrame.qs = i;
				DoScroll(i);
				return 1;
			end
		end
	end
	if ( text and text ~= "" ) then
		if ( not last or length < last ) then
			if ( not DoSearch(LootLinkFrame.qs) and not DoSearch(1, LootLinkFrame.qs+1) ) then
				LootLinkFrameQuickSearch.last = length;
				LootLinkFrameQuickSearch:SetTextColor(1,0,0);
				LootLinkFrame.qs = 0;
			else
				LootLinkFrameQuickSearch:SetTextColor(1,1,1);
				LootLinkFrameQuickSearch.last = nil;
			end
		end
	else
		LootLinkFrame.qs = 0;
		LootLinkFrameQuickSearch:SetTextColor(1,1,1);
	end
	LootLink_Update();
end

function LootLinkQuickSearch_FullSearch()
	local name = this:GetText();
	if ( name ) then
		if ( name == "" ) then
			name = nil;
		end
		if ( name and not LootLinkFrame.SearchParams ) then
			LootLinkFrame.SearchParams = { };
		end
		if ( LootLinkFrame.SearchParams ) then
			LootLinkFrame.SearchParams.name = name;
		end
	end
	LootLink_DoSearch();
	LootLinkFrameQuickSearch:SetText(name or "");
end

function LootLinkQuickSearch_Clear()
	LootLinkFrameQuickSearch:SetText("");
	LootLinkFrameQuickSearch.last = nil;
end

LootLinkOptionsList = {
	hideminimap	= { frame = "LLO_HideMinimap", flip = 1 },
	lockminimap	= { frame = "LLO_LockMinimap" },
	hideicon	= { frame = "LLO_IconCheckButton", flip = 1 },
	HideInfo	= { frame = "LLO_ExtraInfoCheckButton", flip = 1 },
	mouseover	= { frame = "LLO_MouseoverCheckButton" },
	typelinks	= { frame = "LLO_TypeLinksCheckButton" },
	autotypelinks	= { frame = "LLO_AutoTypeLinksCheckButton", dependancy = "typelinks" },
	
	server		= { frame = "LLO_ServerCheckButton", refresh = 1 },
	spoof		= { frame = "LLO_SpoofCheckButton", refresh = 1 },
	nosame		= { frame = "LLO_SameNameCheckButton", flip = 1, refresh = 1 },
	novariants	= { frame = "LLO_VariantCheckButton", flip = 1, dependancy = "nosame", refresh = 1 },
	enchants	= { frame = "LLO_EnchantsCheckButton", flip = 1, dependancy = "nosame", refresh = 1 },

	x		= { frame = "LLO_MinimapPos", slider = LLO_MINIMAP_X},
	y		= { frame = "LLO_MinimapOffset", slider = LLO_MINIMAP_Y },

	rarityfilter	= { frame = "LLO_RarityDropDown", dropdown = {LLO_RarityDropDown_Initialize, 2, LLO_RARITY_LIST}, refresh = 1 },
	};
	
function LootLinkOptions_LoadValues()
	local op = LootLinkState;
	
	for k, v in LootLinkOptionsList do
		local frame = getglobal( v.frame );
		if ( frame ) then
			if ( v.dropdown ) then
				UIDropDownMenu_Initialize(frame, v.dropdown[1]);
				LootLink_UIDropDownMenu_SetSelectedID(frame, 1, v.dropdown[3]);
			end
			local value = op[k];
			if value then
				if ( v.slider ) then
					frame:SetValue( value );
					LootLinkOptionsFrame[k] = value;
				elseif ( v.dropdown ) then
					LootLink_UIDropDownMenu_SetSelectedID(frame, value+v.dropdown[2], v.dropdown[3]);
				end
			elseif ( v.slider ) then
				frame:SetValue( v.slider );
				LootLinkOptionsFrame[k] = nil;
			end
			if ( not v.slider and not v.dropdown ) then
				if ( v.flip ) then
					frame:SetChecked(1-(value or 0))
				else
					frame:SetChecked(value)
				end
			end
			if ( v.dependancy ) then
				if ( getglobal(LootLinkOptionsList[v.dependancy].frame):GetChecked() ) then
					frame:Enable();
					getglobal(frame:GetName().."Text"):SetTextColor(1, 0.82, 0);
				else
					frame:Disable();
					getglobal(frame:GetName().."Text"):SetTextColor(0.3, 0.3, 0.3);
				end
			end
		else
			ChatFrame1:AddMessage(k.." no frame?");
		end
	end
	
	LootLinkOptionsFrame.needsave = 1;
end

function LootLinkOptions_SaveValues()
	local op = LootLinkState;
	local refresh;
	
	for k, v in LootLinkOptionsList do
		local frame = getglobal( v.frame );
		if ( frame ) then
			local value = op[k];
			if ( v.dropdown ) then
				value = UIDropDownMenu_GetSelectedID(frame);
				if ( value == 1 ) then
					value = nil;
				else
					value = value - (v.dropdown[2] or 0);
				end
			elseif ( not v.slider ) then
				local checked = frame:GetChecked();
				if ( v.flip ) then
					if ( checked ) then
						checked = nil
					else
						checked = 1;
					end
				end
				value = checked;		
			end
			if ( v.refresh and op[k] ~= value ) then
				refresh = 1;
			end
			op[k] = value;
		else
			ChatFrame1:AddMessage(k.." no frame?");
		end
	end
	
	if ( refresh ) then
		LootLink_Refresh();
	end
	LootLinkOptionsFrame.needsave = nil;
end

function LootLinkOptionsFrame_Defaults()
	local op = LootLinkState;
	for k, v in LootLinkOptionsList do
		op[k] = nil;
	end
	LootLinkOptions_LoadValues();
end

function LootLinkOptionsFrame_Cancel()
	if ( LootLinkOptionsFrame.needsave ) then
		LootLinkOptionsFrame.needsave = nil;
		if ( LootLinkOptionsFrame.x or LootLinkOptionsFrame.y ) then
			LootLink_Minimap_Position( LootLinkOptionsFrame.x, LootLinkOptionsFrame.y );
		end
	end
	PlaySound("gsTitleOptionExit");
	LootLinkOptionsFrame:Hide();
end

function LootLinkOptionsFrame_Okay()
	PlaySound("gsTitleOptionOK");
	LootLinkOptions_SaveValues();
	LootLinkOptionsFrame:Hide();
end

function LootLink_CloseWindows(ignoreCenter)
	if ( LootLinkOptionsFrame:IsVisible() ) then
		LootLinkOptionsFrame_Cancel();
		return 1;
	end
	if ( LootLinkSearchFrame:IsVisible() ) then
		LootLinkSearchFrame_Cancel();
		return 1;
	end
	return lOriginal_CloseWindows(ignoreCenter);
end

function LootLink_ValidateItem(name, link, fixlink)
	-- Basic validation of enchants and stat bonuses
	-- todo : more complex evaluation of the stat bonuses taking in to account item level and base stats
	if ( not link ) then return nil; 
	elseif ( string.sub(link, 1, 5) ~= "item:" ) then
		link = "item:"..link;
	end
	local realname, ilink, quality, level, sType, sSubType, count, equip = GetItemInfo(link);
	if ( realname ) then
		if ( realname ~= name ) then
			-- quickly kill anything that's really wrong.
			if ( not fixlink ) then	return nil; end
			name = realname;
		end
		
		local _,_, itemid, enchant, stat = string.find( link, "(%d+):(%d+):(%d+):%d+" );
		
		if ( tonumber(stat) > 0 ) then
			if ( quality ~= 2 and quality ~= 3 and itemid ~= "20039" ) then -- special case for Dark Iron Boots, grr.
				-- Nothing but Uncommon and Rare items have stat bonuses
				if ( not fixlink ) then	return nil; end
				stat = 0;
			elseif( lNoBonuses[equip] == 2 ) then
				-- Nothing that can't be equiped can't have stat bonuses
				if ( not fixlink ) then	return nil; end
				stat = 0;
			end
		end
		if ( tonumber(enchant) > 0 ) then
			if ( lNoBonuses[equip] ) then
				-- Nothing that isn't armor or weapons can have enchants
				if ( not fixlink ) then	return nil; end
				enchant = 0;
			end
		end
		
		return name, itemid..":"..enchant..":"..stat..":0";
	else
		if ( not fixlink ) then return 1; end
		return name, string.sub(link,6);
	end
end


--------------------------------------------------------------------------------------------------
-- Clean and Purge functions
--------------------------------------------------------------------------------------------------

local LLPtodo;
local LLPvars;

function LootLink_CheckDuplicate(name)
	local links = {};
	local value = ItemLinks[name];
	local dups = 0;
	if ( value and value.m ) then
		links[value.i] = 1;
		local i = 1;
		--while value and value.m and value.m[i] do
		for i=getn(value.m), 1, -1 do
			if ( links[value.m[i].i] ) then
				dups = dups + 1;
				LootLink_RemoveItem(name, nil, nil, i);
			else
				links[value.m[i].i] = 1;
			end
		end
	end
	return dups;
end

function LootLink_Process_Cancel()
	LootLink_Process:Hide();
	LootLink_Process:SetScript("OnUpdate", nil);
	LootLink_Process.fade = nil;
	LootLinkFrame.process = nil;
	LootLink_Process_ToggleButtons(1);
	
	if ( LLPtodo ) then
		local text = getglobal("LLP_"..LLPvars.functype.."_CANCEL");
		text = string.gsub( text, "%%r", LLPvars.total-LLPvars.done );
		text = string.gsub( text, "%%u", LLPvars.updated );
		text = string.gsub( text, "%%t", LLPvars.total );
		text = string.gsub( text, "%%f", LLPvars.failed );
		DEFAULT_CHAT_FRAME:AddMessage(text);

		LootLink_Process_Time:SetText("");

		LLPvars = nil;
		LLPtodo = nil;
	end
end

function LootLink_Process_Memory()
	LootLink_Process_Cancel();
	DEFAULT_CHAT_FRAME:AddMessage(LLP_ABORT1);
	DEFAULT_CHAT_FRAME:AddMessage(LLP_ABORT2);
end

function LootLink_Process_ToggleButtons(on)
	if ( on ) then
		LLO_Purge:Enable();
		LLO_Fix:Enable();
	else
		LLO_Purge:Disable();
		LLO_Fix:Disable();
	end
end

function LootLinkProcess_PURGE()
	local todo = LLPtodo[LLPvars.done+1];
	
	local name, link = todo[1], todo[2];	
	local _,_,itemid,enchantid,suffixid=string.find(link, "(%d+):(%d+):(%d+):%d+");
	
	LootLink_SortAlternates(name);
	local op = LootLinkState;
	local value = ItemLinks[name];
	
	if ( value and value.m ) then
		if ( op.nosame or (op.novariants and tonumber(suffixid) > 0) ) then
			LLPvars.updated = LLPvars.updated + getn(value.m);
			value.m = nil;
		end
		if ( op.enchants ) then
			if ( tonumber(enchantid) > 0 ) then
				if ( LootLink_RemoveItem(name, link) ) then
					return 1;
				end
			end
		end
	end
	value = LootLink_GetValue(name, link);
	if ( not value ) then
		return 2;
	end
	if ( value.c and op.rarityfilter ) then
		local rarity = lRarityFilter[value.c];
		if ( rarity and rarity < op.rarityfilter ) then
			if ( LootLink_RemoveItem(name, link) ) then
				return 1;
			end
		end
	end
	if ( LootLinkState.spoof ) then
		local valid = LootLink_ValidateItem(name, link)
		if ( not valid ) then
			if ( LootLink_RemoveItem(name, link) ) then
				return 1;
			end
		elseif ( valid == 1 ) then
			return 2;
		end
	end
end

function LootLinkProcess_FIXCACHE()
	local todo = LLPtodo[LLPvars.done+1];
	local name, link, index = todo[1], todo[2], todo[3];
	local realname = GetItemInfo("item:"..link);
	local value = LootLink_GetValue( name, nil, link );
	if ( not value ) then return; end
	value.i = string.gsub(link,"(%d+:%d+:%d+:)%d+","%10");
	if ( realname ) then
		if ( LootLink_BuildSearchData( name, value, index ) == 2 ) then
			return 1;
		end
	elseif ( not value.t or value.t == "" ) then
		value.t = name.."·Bad Search Data·";
		return 1;
	else
		local changes;
		if ( value.t ) then
			local t = value.t;
			local d = value.d;
			local s, e, val = string.find(t, "^(.-)·");
			if ( not val or not string.find(name, val) ) then
				return 2;
			end
			if ( string.find(t, "%/") ) then
				-- cull out durability data.
				t = string.gsub(t, "Durability %d+ %/ %d+·", "");
				-- check set data.
				s,e,val = string.find(t, ".+·(.-) %(%d%/%d+%)·.+");
				if ( val ) then
					t = string.gsub(t, "(.+ %()%d+(%/%d+%)·.+)", "%10%2");
					local newset = LootLink_GetSet(val);
					local setnum = LL_SearchData(value, "se");
					if ( d ) then
						if ( not setnum ) then
							d = d.."se"..newset.."·";
							changes = 1;
						elseif( newset ~= setnum ) then
							d = string.gsub(d, "(.+·se)%d+(·.+)", "%1"..newset.."%2");
							changes = 1;
						end
					end
				end
			end
			
			if ( value.t ~= t ) then
				changes = 1;
			end
			value.t = t;
			value.d = d;
		end
		if ( changes ) then
			return 1;
		end
		return 2;
	end
end

function LootLinkProcess_Process(func)
	if ( not LLPvars ) then
		LootLink_Process_ToggleButtons();
		
		LLPvars = {};
		
		LLPvars.func = getglobal( "LootLinkProcess_"..func );
		
		if ( not LLPvars.func ) then
			LootLink_Process_ToggleButtons(1);
			preprocess = nil;
			return;
		end
		
		HideUIPanel(LootLinkFrame);
		
		LootLink_Process_Header:SetText(getglobal("LLP_"..func.."_LABEL") );
		LootLink_Process_Num:SetText("Preprocessing");
		LootLink_Process_Bar:SetMinMaxValues(0,1);
		LootLink_Process_Bar:SetValue(0);
		
		LLPvars.functype = func;
		LLPvars.elapsed = 0;
		LLPvars.done = 0;
		LLPvars.updated = 0;
		LLPvars.failed = 0;
		LLPvars.wait = 0;
		LLPvars.total = 0;
		
		LootLink_Process:SetAlpha( 1 );
		LootLink_Process:Show();
		
		LootLinkFrame.process = func;
	end
end

function LootLinkProcess_Run()
	local thisprocess = 0;
	local func = LLPvars.func;
	
	if ( LLP_OUTOFMEM ) then
		LootLink_Process_Memory();
	end
	
	if ( LLPvars.wait ) then
		LLPvars.wait = LLPvars.wait - arg1;
		if ( LLPvars.wait <= 0 ) then
			LLPvars.wait = nil;
		end
		return;
	end
	
	if ( not LLPtodo ) then
		local normal, mult = 0,0;
		LLPtodo = {};
		for k, v in ItemLinks do
			if ( strlen(k) == 0 ) then
				ItemLinks[k] = nil;
				LLPvars.updated = LLPvars.updated + 1;
			elseif ( v.i ) then
				normal = normal + 1;
				tinsert( LLPtodo, {k, v.i} );
				if ( GetItemInfo("item:"..v.i) ) then
					LLHiddenTooltip:SetHyperlink("item:"..v.i);
				end
				if ( v.m ) then
					for i=1, getn(v.m) do
						if v.m[i].i then
							mult = mult + 1;
							tinsert( LLPtodo, {k, v.m[i].i, i} );
							if ( GetItemInfo("item:"..v.m[i].i) ) then
								LLHiddenTooltip:SetHyperlink("item:"..v.m[i].i);
							end
						else
							LootLink_RemoveItem(k, i);
							LLPvars.updated = LLPvars.updated + 1;
						end
					end
				end
			else
				LootLink_RemoveItem(k);
				LLPvars.updated = LLPvars.updated + 1;
			end
		end
		LLPvars.total = normal + mult;
		LootLink_Process_Bar:SetValue(0)
		LootLink_Process_Bar:SetMinMaxValues(0, LLPvars.total)
		LLPvars.wait = 2;
		return;
	end
	
	local todo = LLPtodo;
	
	LLPvars.elapsed = LLPvars.elapsed + arg1;
	
	while todo and todo[LLPvars.done+1] do
		local ret = func();
		if ( ret ) then
			if ( ret == 1 ) then
				LLPvars.updated = LLPvars.updated + 1;
			else
				LLPvars.failed = LLPvars.failed + 1;
			end
		end
		
		LLPvars.updated = LLPvars.updated + LootLink_CheckDuplicate(todo[LLPvars.done+1][1]);
		LootLink_SortAlternates(todo[LLPvars.done+1][1]);
		
		thisprocess = thisprocess + 1;
		LLPvars.done = LLPvars.done + 1;
		
		if ( thisprocess == 50 ) then
			thisprocess = 0;
			LootLink_Process_Bar:SetValue( LLPvars.done );
			LootLink_Process_Num:SetText( LLPvars.done .. "/".. LLPvars.total );
			local time = (LLPvars.elapsed / LLPvars.done ) * (LLPvars.total - LLPvars.done);
			local s = mod( time, 60 );
			local m = (time-s) / 60;
			s = floor(s)
			if ( strlen(s) == 1 ) then
				s = "0"..s;
			end
			LootLink_Process_Time:SetText( "Estimated "..m..":"..s.." remaining" );
			
			if ( DisplayIndices and LootLinkFrame:IsVisible() ) then
				LootLink_Update();
				LootLink_SetTitle();
			end
			
			return;
		end
	end
	
	if ( todo and not todo[LLPvars.done+1] ) then
		local text = getglobal("LLP_"..LLPvars.functype.."_END");
		text = string.gsub( text, "%%u", LLPvars.updated );
		text = string.gsub( text, "%%t", LLPvars.total );
		text = string.gsub( text, "%%f", LLPvars.failed );
		DEFAULT_CHAT_FRAME:AddMessage(text);
		LootLink_Process_Time:SetText("");
		LootLink_Process_Num:SetText("Finished");
		LootLink_Process_Bar:SetValue(LLPvars.total);

		LootLink_Process_ToggleButtons(1);
		
		LLPvars = nil;
		LLPtodo = nil;
		LootLinkFrame.process = nil;
		
		LootLink_Process.fade = 2;
		LootLink_Process:SetScript("OnUpdate", LootLink_Process_Fade);
	end
end

function LootLink_Process_Fade()
	if ( LootLink_Process.fade ) then
		LootLink_Process.fade = LootLink_Process.fade - (arg1 / 2);
		if ( LootLink_Process.fade < 1 ) then
			this:SetAlpha( LootLink_Process.fade );
			if ( LootLink_Process.fade <= 0 ) then
				this:Hide();
				LootLink_Process.fade = nil;
				LootLink_Process:SetScript("OnUpdate", nil);
			end
		end
	end
end

--------------------------------------------------------------------------------------------------
-- External functions
--------------------------------------------------------------------------------------------------

-- Looks for and deconstructs links contained in a text string; if trusted, existing information will be verified
-- Trusted sources are everything except chat links; since these can be spoofed, we want to allow them to be replaced
function LootLink_ProcessLinks(text, trusted)
	local enchants, spoof, nosame, rarityfilter, lastName = LootLinkState.enchants, LootLinkState.spoof, LootLinkState.nosame, LootLinkState.rarityfilter;
	if( text ) then
		for color, item, name in string.gfind(text, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r") do
			if ( item ~= "0:0:0:0" and ( not rarityfilter or lRarityFilter[color] > rarityfilter ) and LootLink_CheckSame(name, item) ) then
				local fixedname, fixeditem;
				if ( not trusted ) then
					if ( spoof ) then
						name, item = LootLink_ValidateItem(name, item, 1);
					else
						fixedname, fixeditem = LootLink_ValidateItem(name, item, 1);
						if ( fixedname and fixedname ~= name ) then
							LootLink_AddItem(fixedname, fixeditem, color, trusted);
						end
					end
				end
				local enchant;
				if ( not enchants and not nosame ) then
					enchant = string.gsub(item, "^(%d+):(%d+):(%d+):%d+$", "%1:%2:%3:0");
				end
				item = string.gsub(item, "^(%d+):%d+:(%d+):%d+$", "%1:0:%2:0");
				LootLink_AddItem(name, item, color, trusted);
				if ( enchant and enchant ~= item ) then
					LootLink_AddItem(name, enchant, color, trusted);
				end
				LootLink_SortAlternates(name);
				lastName = name;
			end
		end
	end	
	return lastName;
end

function LootLink_CheckSame(name, item)
	local _,_,itemid,suffixid=string.find(item, "(%d+):%d+:(%d+):%d+");
	local value = ItemLinks[name];
	if ( value and (LootLinkState.nosame or LootLinkState.novariants) ) then
		-- Assumes no same name items are both different itemid and have suffixids
		if ( value.i and value.i ~= item ) then
			for id, suf in string.gfind( value.i, "(%d+):%d+:(%d+):") do
				if ( nosame and tonumber(id) > tonumber(itemid) ) then
					return;
				elseif ( tonumber(suf) > tonumber(suffixid) ) then
					return;
				end
			end
		end
	end
	return 1;
end

-- old filter function, keeping for posterity
--[[function LootLink_FilterCheck(name, item, color)
	if ( item == "0:0:0:0" ) then
		return;
	end
	local op = LootLinkState;
	if ( op.rarityfilter ) then
		local rarity = lRarityFilter[color];
		if ( rarity and rarity < op.rarityfilter ) then
			return;
		end
	end		
	local _,_,itemid,enchantid,suffixid=string.find(item, "(%d+):(%d+):(%d+):%d+");
	if ( not tonumber(enchantid) ) then
		--ChatFrame1:AddMessage((name or "??").." no enchant id "..(item or "???"));
		return;
	end
	local value = ItemLinks[name];
	if ( value and (op.nosame or op.novariants) ) then
		-- Assumes no same name items are both different itemid and have suffixids
		if ( value.i and value.i ~= item ) then
			for id, suf in string.gfind( value.i, "(%d+):%d+:(%d+):") do
				if ( op.nosame and tonumber(id) > tonumber(itemid) ) then
					return;
				elseif ( tonumber(suf) > tonumber(suffixid) ) then
					return;
				end
			end
		end
	end
	return 1;
end]]

-- Add items to the database
function LootLink_AddItem(name, link, color, trusted)
	local nosame, value, index = LootLinkState.nosame;
	if ( name and link ) then
		if ( not ItemLinks[name] ) then
			ItemLinks[name] = { };
			lItemLinksSizeTotal = lItemLinksSizeTotal + 1;
			if( LootLink_GetDataVersion() < 110 ) then
				-- Set a flag to indicate that this item is new and should be skipped on a makehome
				ItemLinks[name]._ = 1;
			end
		end
		value = ItemLinks[name];
		if ( not nosame and LootLinkState.novariants ) then
			for suffixid in string.gfind(link, "%d+:%d+:(%d+):%d+") do
				if ( tonumber(suffixid) > 0 ) then
					nosame = 1;
				end
			end
		end
		if ( not nosame and value.i and value.i ~= link ) then
			if ( value.m and getn(value.m) > 0 ) then
				for k, v in value.m do
					if ( v.i == link ) then
						if ( not trusted ) then
							return nil;
						end
						index = k;
						break;
					end
				end
			end
			if ( index ) then
				value = value.m[index];
			else
				if ( not value.m ) then
					value.m = {};
				end
				tinsert( value.m, {} );
				index = getn(value.m);
				value = value.m[index];
				lItemLinksSizeTotal = lItemLinksSizeTotal + 1;
			end
		end
		
		value.i = link;
		value.c = color;
		
		LootLink_BuildSearchData(name, value, index);
		if( not LootLink_CheckItemServerRaw(value, lServerIndex) ) then
			LootLink_AddItemServer(value, lServerIndex);
		end
		return value;
	end
end

-- Sort same name items by ids
function LootLink_SortAlternates(name)
	if ( not name ) then return; end
	local value = ItemLinks[name];
	local newval;
	local values = {};
	local itemval = {};

	-- cleaned up by Adrine
	function sortByLink(e1, e2)
		if ( not e1 ) then return true;	elseif ( not e2 ) then return false; end
		local _,_,a,b,c = string.find(e1.i, "(%d+):(%d+):(%d+)");
		local _,_,d,e,f = string.find(e2.i, "(%d+):(%d+):(%d+)");

		if a ~= d then return tonumber(a) > tonumber(d); end
		if c ~= f then return tonumber(c) > tonumber(f); end
		if b ~= e then return tonumber(b) < tonumber(e); end
		return false;
	end
			
	if value and value.m then
		if ( getn(value.m) == 0 ) then
			value.m = nil;
			return nil;
		end
		for k, v in value do
			if ( k ~= "m" ) then
				itemval[k] = v;
			end
		end
		tinsert( values, itemval );
		for k, v in value.m do
			tinsert( values, v );
		end
		
		table.sort(values, sortByLink);
		
		newval = values[1];
		newval.m = {};
		for i=2, getn(values) do
			tinsert( newval.m, values[i] );
		end
	else
		return nil;
	end
	ItemLinks[name] = {};
	ItemLinks[name] = newval;
end

-- Adds icon of the item if it's valid
function LootLink_AddTooltipTexture(link)
	if ( link and not LootLinkState.hideicon) then
		local _, _, _, _, _, _, _, _, itemTexture = GetItemInfo(link);
		if ( itemTexture ) then
			local iItem = LootLinkFrame.TooltipButton or 0;
			LootLinkTooltipIconTexture:SetTexture( itemTexture );
			LootLinkTooltipIcon:ClearAllPoints();
			LootLinkTooltipIcon:SetPoint("BOTTOMLEFT", getglobal("LootLinkItem"..iItem), "BOTTOMRIGHT");
			LootLinkTooltipIcon:Show();
			return;
		end
	end
	LootLinkTooltipIcon:Hide();
end			

-- Adds extra tooltip information for the item with the given name
function LootLink_AddTooltipInfo(name, tooltip, quantity, index)
	if( not tooltip ) then
		tooltip = LootLinkTooltip;
	end
	if( not quantity ) then
		quantity = 1;
	end
	if( tooltip == LootLinkTooltip ) then
		LootLink_HideTooltipMoney();
	end
	if( not LootLinkState.HideInfo and ItemLinks[name] ) then
		if( tooltip == GameTooltip ) then
			GameTooltip.llDone = 1;
		end
		if( ItemLinks[name].p ) then
			LootLink_SetTooltipMoney(tooltip, quantity, ItemLinks[name].p, ItemLinks[name].x);
		end
		LootLink_AddExtraTooltipInfo(tooltip, name, quantity, ItemLinks[name]);
		tooltip:Show();
	end
end

-- This will set up a tooltip with item information for the given name if it's known
function LootLink_SetTooltip(tooltip, name, quantity)
	local link;
	
	if( tooltip and name ) then
		link = LootLink_GetHyperlink(name);
		if( link ) then
			LootLink_SetHyperlink(tooltip, name, link);
			if( quantity ) then
				quantity = tonumber(quantity);
			else
				quantity = 1;
			end
			if( quantity > 0 ) then
				LootLink_AddTooltipInfo(name, tooltip, quantity);
			end
		end
	end
end

-- 
function LootLink_ChatEdit_OnTabPressed()
	
	lOriginal_ChatEdit_OnTabPressed();
end

function LootLink_ChatEdit_OnTextChanged()
	local text = this:GetText();
	if (string.sub(text, 1, 7) ~= "/script" or string.sub(text, 1, 5) ~= "/dump") then
		--text = string.gsub(text, "([|]?[h]?)%[(.-)%]([|]?[h]?)", FLT_LinkifyName);
		--end
	end
	lOriginal_ChatEdit_OnTextChanged();
end

-- Calling this will allow LootLink to automatically add information to tooltips when needed
function LootLink_AutoInfoOn()
	lSuppressInfoAdd = nil;
end

-- Calling this will prevent LootLink from automatically adding information to tooltips
function LootLink_AutoInfoOff()
	lSuppressInfoAdd = 1;
end

-- Use this function to get the current server name from LootLink's perspective
function LootLink_GetCurrentServerName()
	return lServer;
end

-- Use this function to get the current server index
function LootLink_GetCurrentServerIndex()
	return lServerIndex;
end

-- Use this function to map a server name to the server index for the ItemLinks[name].servers array
function LootLink_GetServerIndex(name)
	if( not LootLinkState or not LootLinkState.ServerNamesToIndices ) then
		return nil;
	end
	return LootLinkState.ServerNamesToIndices[name];
end

-- Use this function to check whether an ItemLinks[name] entry is valid for a given server index
function LootLink_CheckItemServer(item, serverIndex)
	-- If we haven't converted and this item predates multiple server support, count it as valid
	if( LootLink_GetDataVersion() < 110 and not item._ ) then
		return 1;
	end
	return LootLink_CheckItemServerRaw(item, serverIndex);
end

-- Used for debugging changes in item data and tooltip format
function LootLink_Validate()
	for index, value in ItemLinks do
		if( not value.d ) then
			DEFAULT_CHAT_FRAME:AddMessage(index.." has no search data");
--		else
--			if( not LL_SearchData(value, "su") ) then
--				DEFAULT_CHAT_FRAME:AddMessage(index.." has no subtype");
--			end
		end
	end
end

--------------------------------------------------------------------------------------------------
-- Hookable callback functions
--------------------------------------------------------------------------------------------------

-- Hook this function to add any extra information you like to the tooltip
function LootLink_AddExtraTooltipInfo(tooltip, name, quantity, item)
	-- tooltip: the current tooltip frame
	-- name: the name of the item
	-- quantity: the number of items, if known, else 1
	-- item: ItemLinks[name]; LootLink's data for this item
end

-- Hook this function to be called whenever an equipment slot is successfully inspected
function LootLink_Event_InspectSlot(name, count, item, unit, slotid)
	-- name: the name of the item
	-- count: the number of items, if known, else 1
	-- item: ItemLinks[name]; LootLink's data for this item
	-- unit: "target", "player", etc.
	-- slotid: the id of the slot inspected
end

-- Hook this function to be called whenever an inventory slot is successfully inspected
function LootLink_Event_ScanInventory(name, count, item, bagid, slotid)
	-- name: the name of the item
	-- count: the number of items, if known, else 1
	-- item: ItemLinks[name]; LootLink's data for this item
	-- bagid: the id of the bag containing the item
	-- slotid: the id of the slot inspected
end

-- Hook this function to be called whenever a bank slot is successfully inspected
function LootLink_Event_ScanBank(name, count, item, bagid, slotid)
	-- name: the name of the item
	-- count: the number of items, if known, else 1
	-- item: ItemLinks[name]; LootLink's data for this item
	-- bagid: the id of the bag containing the item
	-- slotid: the id of the slot inspected
end

-- Hook this function to be called whenever an auction entry is successfully inspected
function LootLink_Event_ScanAuction(name, count, item, auctionpage, auctionid)
	-- name: the name of the item
	-- count: the number of items, if known, else 1
	-- item: ItemLinks[name]; LootLink's data for this item
	-- auctionpage: the page number this item was found on
	-- auctionid: the id of the inspected item
end

-- Hook this function to be called whenever a chat message is successfully inspected
function LootLink_Event_ScanChat(name, item, text)
	-- name: the name of the last item in the chat message
	-- item: ItemLinks[name]; LootLink's data for this item
	-- text: the inspected chat message
end

-- Hook this function to be called whenever LootLink starts an auction scan
function LootLink_Event_StartAuctionScan()
end

-- Hook this function to be called whenever LootLink stops an auction scan
function LootLink_Event_StopAuctionScan()
end

-- Hook this function to be called whenever LootLink completes a full auction scan
function LootLink_Event_FinishedAuctionScan()
end

-- Hook this function to be called whenever LootLink sends a new auction query
function LootLink_Event_AuctionQuery(auctionpage)
	-- auctionpage: the page number for the query that was just sent
end


--------------------------------------------------------------------------------------------------
-- Static Popup Dialogs
--------------------------------------------------------------------------------------------------

StaticPopupDialogs["LOOTLINK_DELETEITEM_CONFIRM"] = {
	text = TEXT(LOOTLINK_STATICPOPUP_DELETE_ITEM_CONFIRM),
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	OnAccept = function(data)
		if ( not data ) then return; end
		if ( LootLink_RemoveItem(data[1], data[2].i, data[3] ) ) then
			LootLink_Update();
			LootLink_SetTitle();
		end
	end,
	showAlert = 1,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1,
	};

StaticPopupDialogs["LOOTLINK_LITEMODE_CONFIRM"] = {
	text = TEXT(LOOTLINK_STATICPOPUP_LITE_MODE_CONFIRM),
	button1 = TEXT(OKAY),
	button2 = TEXT(CANCEL),
	OnCancel = function()
		LLO_LiteModeCheckButton:SetChecked();
	end,
	showAlert = 1,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1,
	};

StaticPopupDialogs["LOOTLINK_LINK_CONFIRM"] = {
	text = TEXT(LOOTLINK_STATICPOPUP_ITEM_CONFIRM),
	button1 = TEXT(OKAY),
	button2 = TEXT(CANCEL),
	OnAccept = function(data)
		ChatFrameEditBox:Insert(LootLink_GetLink(data[1], data[3]));
	end,
	showAlert = 1,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1,
	};

StaticPopupDialogs["LOOTLINK_DRESSUP_CONFIRM"] = {
	text = TEXT(LOOTLINK_STATICPOPUP_ITEM_CONFIRM),
	button1 = TEXT(OKAY),
	button2 = TEXT(CANCEL),
	OnAccept = function(data)
		DressUpItemLink(LootLink_GetLink(data[1], data[3]));
	end,
	showAlert = 1,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1,
	};
	

--------------------------------------------------------------------------------------------------
-- Type links - borrowed from Gazmik Fizzwidget's Linkerator
--------------------------------------------------------------------------------------------------

function LootLink_TypeLinks_LinkifyName(head, text, tail)
	if (head ~= "|h" and tail ~= "|h") then -- only linkify things text that isn't linked already
		local link = LootLink_GetLink(text);
		if (link) then return link; end
	end
	return head.."["..text.."]"..tail;
end

function LootLink_TypeLinks_ParseChatMessage(text)
	return string.gsub(text, "([|]?[h]?)%[(.-)%]([|]?[h]?)", LootLink_TypeLinks_LinkifyName);
end

-- thank you ckknight
function LootLink_TypeLinks_AutoComplete(text)
	local _,_,body,name = string.find( text, "(.*%[)(%S[^%[^%]]+)$" );
	if ( name ) then
		local textlen, namelen, found = strlen(text), strlen(name);
		if ( this.lastLength and this.lastItem and textlen > this.lastLength ) then
			if string.find(strlower(this.lastItem), strlower(name)) then
				this.lastLength = textlen;
				this:SetText(body..this.lastItem);
				this:HighlightText(textlen);
				return 1;
			end
		end
		this.lastLength = textlen;
		for k, v in ItemLinks do
			if ( strlen(k) >= namelen and strlower(strsub(k,1,namelen)) == strlower(name) ) then
				found = 1;
				if ( (not this.itemComplete or not this.itemComplete[k]) ) then
					if ( not this.itemComplete ) then
						this.itemComplete = {};
					end
					this.ignoreTextChange = 1;
					this:SetText(body..k);
					this:HighlightText(textlen);
					this.lastItem = k;
					this.itemComplete[k] = 1;
					return 1;
				end
			end
		end
		if ( found ) then
			this.lastLength = nil;
			this.lastItem = nil;
			this.itemComplete = nil;
			return LootLink_TypeLinks_AutoComplete(text);
		end
	end
	this.lastItem = nil;
	this.itemComplete = nil;
end

-- Hooks

lOrig_ChatEdit_OnTextChanged = ChatEdit_OnTextChanged;
function ChatEdit_OnTextChanged()
	if ( LootLinkState.typelinks ) then
		local text = this:GetText();
		if (string.find(text, "^/script") or string.find(text, "^/dump")) then
			-- don't parse
		else
			local newtext = LootLink_TypeLinks_ParseChatMessage(text);
			if ( text ~= newtext ) then
				this:SetText(newtext);
				return;
			end
		end
	end
	lOrig_ChatEdit_OnTextChanged(this);
end

lOrig_ChatEdit_OnChar = ChatFrameEditBox:GetScript("OnChar");
function ChatEdit_OnChar()
	if ( LootLinkState.typelinks and LootLinkState.autotypelinks ) then
		local text = this:GetText();
		if ( string.find(text, "^/script") or string.find(text, "^/dump")) then
		else
			LootLink_TypeLinks_AutoComplete(text);
		end
	elseif ( lOrig_ChatEdit_OnChar ) then
		lOrig_ChatEdit_OnChar(this);
	end
end
ChatFrameEditBox:SetScript("OnChar", ChatEdit_OnChar);

lOrig_ChatEdit_OnTabPressed = ChatEdit_OnTabPressed;
function ChatEdit_OnTabPressed()
	this.lastLength = nil;
	if ( LootLinkState.typelinks and LootLinkState.autotypelinks and this.lastItem ) then
		this:Insert("");
	else
		lOrig_ChatEdit_OnTabPressed();
	end
end

lOrig_ChatEdit_OnEnterPressed = ChatEdit_OnEnterPressed;
function ChatEdit_OnEnterPressed()
	if ( LootLinkState.typelinks and LootLinkState.autotypelinks and this.itemComplete ) then
		this:SetText(this:GetText().."]");
	else
		lOrig_ChatEdit_OnEnterPressed();
	end
	this.itemComplete = nil;
end
