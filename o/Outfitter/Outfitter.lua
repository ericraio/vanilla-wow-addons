gOutfitter_Settings = nil;

local Outfitter_cInitializationEvent = "PLAYER_ENTERING_WORLD";

local BANKED_FONT_COLOR = {r = 0.25, g = 0.2, b = 1.0};
local BANKED_FONT_COLOR_CODE = "|cff4033ff";
local OUTFIT_MESSAGE_COLOR = {r = 0.2, g = 0.75, b = 0.3};

local Outfitter_cSlotNames =
{
	-- First priority goes to armor
	
	"HeadSlot",
	"ShoulderSlot",
	"ChestSlot",
	"WristSlot",
	"HandsSlot",
	"WaistSlot",
	"LegsSlot",
	"FeetSlot",
	
	-- Second priority goes to weapons
	
	"MainHandSlot",
	"SecondaryHandSlot",
	"RangedSlot",
	"AmmoSlot",
	
	-- Last priority goes to items with no durability
	
	"BackSlot",
	"NeckSlot",
	"ShirtSlot",
	"TabardSlot",
	"Finger0Slot",
	"Finger1Slot",
	"Trinket0Slot",
	"Trinket1Slot",
};

local Outfitter_cSlotDisplayNames =
{
	HeadSlot = HEADSLOT,
	NeckSlot = NECKSLOT,
	ShoulderSlot = SHOULDERSLOT,
	BackSlot = BACKSLOT,
	ChestSlot = CHESTSLOT,
	ShirtSlot = SHIRTSLOT,
	TabardSlot = TABARDSLOT,
	WristSlot = WRISTSLOT,
	HandsSlot = HANDSSLOT,
	WaistSlot = WAISTSLOT,
	LegsSlot = LEGSSLOT,
	FeetSlot = FEETSLOT,
	Finger0Slot = Outfitter_cFinger0SlotName,
	Finger1Slot = Outfitter_cFinger1SlotName,
	Trinket0Slot = Outfitter_cTrinket0SlotName,
	Trinket1Slot = Outfitter_cTrinket1SlotName,
	MainHandSlot = MAINHANDSLOT,
	SecondaryHandSlot = SECONDARYHANDSLOT,
	RangedSlot = RANGEDSLOT,
	AmmoSlot = AMMOSLOT,
};

local Outfitter_cInvTypeToSlotName =
{
	INVTYPE_2HWEAPON = {SlotName = "MainHandSlot", MetaSlotName = "TwoHandSlot"},
	INVTYPE_BAG = {SlotName = "Bag"},
	INVTYPE_BODY = {SlotName = "ShirtSlot"},
	INVTYPE_CHEST = {SlotName = "ChestSlot"},
	INVTYPE_CLOAK = {SlotName = "BackSlot"},
	INVTYPE_FEET = {SlotName = "FeetSlot"},
	INVTYPE_FINGER = {SlotName = "Finger0Slot"},
	INVTYPE_HAND = {SlotName = "HandsSlot"},
	INVTYPE_HEAD = {SlotName = "HeadSlot"},
	INVTYPE_HOLDABLE = {SlotName = "SecondaryHandSlot"},
	INVTYPE_LEGS = {SlotName = "LegsSlot"},
	INVTYPE_NECK = {SlotName = "NeckSlot"},
	INVTYPE_RANGED = {SlotName = "RangedSlot"},
	INVTYPE_ROBE = {SlotName = "ChestSlot"},
	INVTYPE_SHIELD = {SlotName = "SecondaryHandSlot"},
	INVTYPE_SHOULDER = {SlotName = "ShoulderSlot"},
	INVTYPE_TABARD = {SlotName = "TabardSlot"},
	INVTYPE_TRINKET = {SlotName = "Trinket0Slot"},
	INVTYPE_WAIST = {SlotName = "WaistSlot"},
	INVTYPE_WEAPON = {SlotName = "MainHandSlot", MetaSlotName = "Weapon0Slot"},
	INVTYPE_WEAPONMAINHAND = {SlotName = "MainHandSlot"},
	INVTYPE_WEAPONOFFHAND = {SlotName = "SecondaryHandSlot"},
	INVTYPE_WRIST = {SlotName = "WristSlot"},
	INVTYPE_RANGEDRIGHT = {SlotName = "RangedSlot"},
	INVTYPE_AMMO = {SlotName = "AmmoSlot"},
	INVTYPE_THROWN = {SlotName = "RangedSlot"},
	INVTYPE_RELIC = {SlotName = "RangedSlot"},
};

local Outfitter_cHalfAlternateStatSlot =
{
	Trinket0Slot = "Trinket1Slot",
	Finger0Slot = "Finger1Slot",
	Weapon0Slot = "Weapon1Slot",
};

local Outfitter_cFullAlternateStatSlot =
{
	Trinket0Slot = "Trinket1Slot",
	Trinket1Slot = "Trinket0Slot",
	Finger0Slot = "Finger1Slot",
	Finger1Slot = "Finger0Slot",
	Weapon0Slot = "Weapon1Slot",
	Weapon1Slot = "Weapon0Slot",
};

local gOutfitter_cCategoryOrder =
{
	"Complete",
	"Partial",
	"Accessory",
	"Special"
};

local gOutfitter_Collapsed = {};
local gOutfitter_BankFrameOpened = false;

local Outfitter_cItemAliases =
{
	[18608] = 18609,	-- Benediction -> Anathema
	[18609] = 18608,	-- Anathema -> Benediction
	[17223] = 17074,	-- Thunderstrike -> Shadowstrike
	[17074] = 17223,	-- Shadowstrike -> Thunderstrike
};

local Outfitter_cSpecialtyBags =
{
	[21340] = {Name = "Soul Pouch", Type = "ShardBag"},
	[21341] = {Name = "Felcloth Bag", Type = "ShardBag"},
	[21342] = {Name = "Core Felcloth Bag", Type = "ShardBag"},
	[22243] = {Name = "Small Soul Pouch", Type = "ShardBag"},
	[22244] = {Name = "Box of Souls", Type = "ShardBag"},
	
	[2102] = {Name = "Small Ammo Pouch", Type = "AmmoPouch"},
	[7279] = {Name = "Small Leather Ammo Pouch", Type = "AmmoPouch"},
	[8218] = {Name = "Thick Leather Ammo Pouch", Type = "AmmoPouch"},
	[7372] = {Name = "Heavy Leather Ammo Pouch", Type = "AmmoPouch"},
	[3574] = {Name = "Hunting Ammo Sack", Type = "AmmoPouch"},
	[3604] = {Name = "Bandolier of the Night Watch", Type = "AmmoPouch"},
	[5441] = {Name = "Small Shot Pouch", Type = "AmmoPouch"},
	[2663] = {Name = "Ribbly's Bandolier", Type = "AmmoPouch"},
	[19320] = {Name = "Gnoll Skin Bandolier", Type = "AmmoPouch"},

	[19319] = {Name = "Harpy Hide Quiver", Type = "Quiver"},
	[7371] = {Name = "Heavy Quiver", Type = "Quiver"},
	[3573] = {Name = "Hunting Quiver", Type = "Quiver"},
	[7278] = {Name = "Light Leather Quiver", Type = "Quiver"},
	[2101] = {Name = "Light Quiver", Type = "Quiver"},
	[11362] = {Name = "Medium Quiver", Type = "Quiver"},
	[8217] = {Name = "Quickdraw Quiver", Type = "Quiver"},
	[3605] = {Name = "Quiver of the Night Watch", Type = "Quiver"},
	[2662] = {Name = "Ribbly's Quiver", Type = "Quiver"},
	[5439] = {Name = "Small Quiver", Type = "Quiver"},
	[18714] = {Name = "Ancient Sinew Wrapped Lamina", Type = "Quiver"},
	
	[22246] = {Name = "Enchanted Mageweave Pouch", Type = "Enchant"},
	[22248] = {Name = "Enchanted Runecloth Bag", Type = "Enchant"},
	[22249] = {Name = "Big Bag of Enchantment", Type = "Enchant"},
	
	[22250] = {Name = "Herb Pouch", Type = "Herb"},
	[22251] = {Name = "Cenarian Herb Bag", Type = "Herb"},
	[22252] = {Name = "Satchel of Cenarious", Type = "Herb"},
};

local Outfitter_cFishingPoles =
{
	{Code = 19970, SubCode = 0}, -- Outfitter_cArcaniteFishingPole
	{Code = 19022, SubCode = 0}, -- Outfitter_cNatPaglesFishingPole
	{Code = 12224, SubCode = 0}, -- Outfitter_cBlumpFishingPole
	{Code = 6367, SubCode = 0}, -- Outfitter_cBigIronFishingPole
	{Code = 6365, SubCode = 0}, -- Outfitter_cStrongFishingPole
	{Code = 6256, SubCode = 0}, -- Outfitter_cFishingPole
};

local Outfitter_cRidingItems =
{
	{Code = 11122, SubCode = 0}, -- Outfitter_cCarrotOnAStick
};

local Outfitter_cArgentDawnTrinkets = 
{
	{Code = 13209, SubCode = 0}, -- Outfitter_cSealOfTheDawn
	{Code = 19812, SubCode = 0}, -- Outfitter_cRuneOfTheDawn
	{Code = 12846, SubCode = 0}, -- Outfitter_cArgentDawnCommission
};

local Outfitter_cStatIDItems =
{
	Fishing = Outfitter_cFishingPoles,
	Riding = Outfitter_cRidingItems,
	ArgentDawn = Outfitter_cArgentDawnTrinkets,
};

local Outfitter_cIgnoredUnusedItems = 
{
	[2901] = "Mining Pick",
	[5956] = "Blacksmith hammer",
	[6219] = "Arclight Spanner",
	[7005] = "Skinning Knife",
	[7297] = "Morbent's Bane",
	[10696] = "Enchanted Azsharite Felbane Sword",
	[10697] = "Enchanted Azsharite Felbane Dagger",
	[10698] = "Enchanted Azsharite Felbane Staff",
	[20406] = "Twilight Cultist Mantle",
	[20407] = "Twilight Cultist Robe",
	[20408] = "Twilight Cultist Cowl",
};

local Outfitter_cSmartOutfits =
{
	{Name = Outfitter_cFishingOutfit, StatID = "Fishing", IsAccessory = true},
	{Name = Outfitter_cHerbalismOutfit, StatID = "Herbalism", IsAccessory = true},
	{Name = Outfitter_cMiningOutfit, StatID = "Mining", IsAccessory = true},
	{Name = Outfitter_cSkinningOutfit, StatID = "Skinning", IsAccessory = true},
	{Name = Outfitter_cFireResistOutfit, StatID = "FireResist"},
	{Name = Outfitter_cNatureResistOutfit, StatID = "NatureResist"},
	{Name = Outfitter_cShadowResistOutfit, StatID = "ShadowResist"},
	{Name = Outfitter_cArcaneResistOutfit, StatID = "ArcaneResist"},
	{Name = Outfitter_cFrostResistOutfit, StatID = "FrostResist"},
};

local Outfitter_cStatCategoryInfo =
{
	{Category = "Stat", Name = Outfitter_cStatsCategory},
	{Category = "Melee", Name = Outfitter_cMeleeCategory},
	{Category = "Spell", Name = Outfitter_cSpellsCategory},
	{Category = "Regen", Name = Outfitter_cRegenCategory},
	{Category = "Resist", Name = Outfitter_cResistCategory},
	{Category = "Trade", Name = Outfitter_cTradeCategory},
};

local Outfitter_cItemStatInfo =
{
	{ID = "Agility", Name = Outfitter_cAgilityStatName, Category = "Stat"},
	{ID = "Armor", Name = Outfitter_cArmorStatName, Category = "Stat"},
	{ID = "Defense", Name = Outfitter_cDefenseStatName, Category = "Stat"},
	{ID = "Intellect", Name = Outfitter_cIntellectStatName, Category = "Stat"},
	{ID = "Spirit", Name = Outfitter_cSpiritStatName, Category = "Stat"},
	{ID = "Stamina", Name = Outfitter_cStaminaStatName, Category = "Stat"},
	{ID = "Strength", Name = Outfitter_cStrengthStatName, Category = "Stat"},
	
	{ID = "ManaRegen", Name = Outfitter_cManaRegenStatName, Category = "Regen"},
	{ID = "HealthRegen", Name = Outfitter_cHealthRegenStatName, Category = "Regen"},
	
	{ID = "SpellCrit", Name = Outfitter_cSpellCritStatName, Category = "Spell"},
	{ID = "SpellHit", Name = Outfitter_cSpellHitStatName, Category = "Spell"},
	{ID = "SpellDmg", Name = Outfitter_cSpellDmgStatName, Category = "Spell"},
	{ID = "FrostDmg", Name = Outfitter_cFrostDmgStatName, Category = "Spell"},
	{ID = "FireDmg", Name = Outfitter_cFireDmgStatName, Category = "Spell"},
	{ID = "ArcaneDmg", Name = Outfitter_cArcaneDmgStatName, Category = "Spell"},
	{ID = "ShadowDmg", Name = Outfitter_cShadowDmgStatName, Category = "Spell"},
	{ID = "NatureDmg", Name = Outfitter_cNatureDmgStatName, Category = "Spell"},
	{ID = "Healing", Name = Outfitter_cHealingStatName, Category = "Spell"},
	
	{ID = "MeleeCrit", Name = Outfitter_cMeleeCritStatName, Category = "Melee"},
	{ID = "MeleeHit", Name = Outfitter_cMeleeHitStatName, Category = "Melee"},
	{ID = "MeleeDmg", Name = Outfitter_cMeleeDmgStatName, Category = "Melee"},
	{ID = "Dodge", Name = Outfitter_cDodgeStatName, Category = "Melee"},
	{ID = "Attack", Name = Outfitter_cAttackStatName, Category = "Melee"},
	
	{ID = "ArcaneResist", Name = Outfitter_cArcaneResistStatName, Category = "Resist"},
	{ID = "FireResist", Name = Outfitter_cFireResistStatName, Category = "Resist"},
	{ID = "FrostResist", Name = Outfitter_cFrostResistStatName, Category = "Resist"},
	{ID = "NatureResist", Name = Outfitter_cNatureResistStatName, Category = "Resist"},
	{ID = "ShadowResist", Name = Outfitter_cShadowResistStatName, Category = "Resist"},
	
	{ID = "Fishing", Name = Outfitter_cFishingStatName, Category = "Trade"},
	{ID = "Herbalism", Name = Outfitter_cHerbalismStatName, Category = "Trade"},
	{ID = "Mining", Name = Outfitter_cMiningStatName, Category = "Trade"},
	{ID = "Skinning", Name = Outfitter_cSkinningStatName, Category = "Trade"},
};

local Outfitter_cNormalizedClassName =
{
	[Outfitter_cDruidClassName] = "Druid",
	[Outfitter_cHunterClassName] = "Hunter",
	[Outfitter_cMageClassName] = "Mage",
	[Outfitter_cPaladinClassName] = "Paladin",
	[Outfitter_cPriestClassName] = "Priest",
	[Outfitter_cRogueClassName] = "Rogue",
	[Outfitter_cShamanClassName] = "Shaman",
	[Outfitter_cWarlockClassName] = "Warlock",
	[Outfitter_cWarriorClassName] = "Warrior",
};

local Outfitter_cClassSpecialOutfits =
{
	Warrior =
	{
		{Name = Outfitter_cWarriorBattleStance, SpecialID = "Battle"},
		{Name = Outfitter_cWarriorDefensiveStance, SpecialID = "Defensive"},
		{Name = Outfitter_cWarriorBerserkerStance, SpecialID = "Berserker"},
	},
	
	Druid =
	{
		{Name = Outfitter_cDruidBearForm, SpecialID = "Bear"},
		{Name = Outfitter_cDruidCatForm, SpecialID = "Cat"},
		{Name = Outfitter_cDruidAquaticForm, SpecialID = "Aquatic"},
		{Name = Outfitter_cDruidTravelForm, SpecialID = "Travel"},
		{Name = Outfitter_cDruidMoonkinForm, SpecialID = "Moonkin"},
	},
	
	Priest =
	{
		{Name = Outfitter_cPriestShadowform, SpecialID = "Shadowform"},
	},
	
	Rogue =
	{
		{Name = Outfitter_cRogueStealth, SpecialID = "Stealth"},
	},
	
	Shaman =
	{
		{Name = Outfitter_cShamanGhostWolf, SpecialID = "GhostWolf"},
	},
	
	Hunter =
	{
		{Name = Outfitter_cHunterMonkey, SpecialID = "Monkey"},
		{Name = Outfitter_cHunterHawk, SpecialID = "Hawk"},
		{Name = Outfitter_cHunterCheetah, SpecialID = "Cheetah"},
		{Name = Outfitter_cHunterPack, SpecialID = "Pack"},
		{Name = Outfitter_cHunterBeast, SpecialID = "Beast"},
		{Name = Outfitter_cHunterWild, SpecialID = "Wild"},
	},
	
	Mage =
	{
		{Name = Outfitter_cMageEvocate, SpecialID = "Evocate"},
	},
};

local	gOutfitter_SpellNameSpecialID =
{
	[Outfitter_cAspectOfTheCheetah] = "Cheetah",
	[Outfitter_cAspectOfThePack] = "Pack",
	[Outfitter_cAspectOfTheBeast] = "Beast",
	[Outfitter_cAspectOfTheWild] = "Wild",
	[Outfitter_cEvocate] = "Evocate",
};

local	gOutfitter_AuraIconSpecialID =
{
	["INV_Misc_Fork&Knife"] = "Dining",
	["Spell_Shadow_Shadowform"] = "Shadowform",
	["Spell_Nature_SpiritWolf"] = "GhostWolf",
	["Ability_Rogue_FeignDeath"] = "Feigning",
	["Ability_Hunter_AspectOfTheMonkey"] = "Monkey",
	["Spell_Nature_RavenForm"] = "Hawk",
};

local Outfitter_cSpecialOutfitDescriptions =
{
	ArgentDawn = Outfitter_cArgentDawnOutfitDescription,
	Riding = Outfitter_cRidingOutfitDescription,
	Dining = Outfitter_cDiningOutfitDescription,
	Battleground = Outfitter_cBattlegroundOutfitDescription,
	AB = Outfitter_cArathiBasinOutfitDescription,
	AV = Outfitter_cAlteracValleyOutfitDescription,
	WSG = Outfitter_cWarsongGulchOutfitDescription,
	City = Outfitter_cCityOutfitDescription,
};

-- Note that zone special outfits will be worn in the order
-- the are listed here, with later outfits being worn over
-- earlier outfits (when they're being applied at the same time)
-- This allows BG-specific outfits to take priority of the generic
-- BG outfit

local Outfitter_cZoneSpecialIDs =
{
	"ArgentDawn",
	"City",
	"Battleground",
	"AV",
	"AB",
	"WSG",
};

local Outfitter_cZoneSpecialIDMap =
{
	[Outfitter_cWesternPlaguelands] = {"ArgentDawn"},
	[Outfitter_cEasternPlaguelands] = {"ArgentDawn"},
	[Outfitter_cStratholme] = {"ArgentDawn"},
	[Outfitter_cScholomance] = {"ArgentDawn"},
	[Outfitter_cNaxxramas] = {"ArgentDawn"},
	[Outfitter_cAlteracValley] = {"Battleground", "AV"},
	[Outfitter_cArathiBasin] = {"Battleground", "AB"},
	[Outfitter_cWarsongGulch] = {"Battleground", "WSG"},
	[Outfitter_cIronforge] = {"City"},
	[Outfitter_cCityOfIronforge] = {"City"},
	[Outfitter_cDarnassus] = {"City"},
	[Outfitter_cStormwind] = {"City"},
	[Outfitter_cOrgrimmar] = {"City"},
	[Outfitter_cThunderBluff] = {"City"},
	[Outfitter_cUndercity] = {"City"},
};

local gOutfitter_StatDistribution =
{
	DRUID =
	{
		Agility = {Armor = {Coeff = 2}, Dodge = {Coeff = 1 / 20}},
		Stamina = {Health = {Coeff = 10}},
		Intellect = {Mana = {Coeff = 15}, SpellCrit = {Coeff = 1 / 30}},
		Spirit = {ManaRegen = {Coeff = 0.25 * 2.5}}, -- * 2.5 to convert from ticks to per-five-seconds
		Strength = {BlockAmount = {Coeff = 1 / 22}},
	},
	
	HUNTER =
	{
		Agility = {Armor = {Coeff = 2}, Dodge = {Coeff = 1 / 26.5}, MeleeCrit = {Coeff = 1 / 53}},
		Stamina = {Health = {Coeff = 10}},
		Intellect = {Mana = {Coeff = 15}},
		Spirit = {ManaRegen = {Coeff = 0.25 * 2.5}}, -- * 2.5 to convert from ticks to per-five-seconds
		Strength = {BlockAmount = {Coeff = 1 / 22}},
	},
	
	MAGE =
	{
		Agility = {Armor = {Coeff = 2}, Dodge = {Coeff = 1 / 20}, MeleeCrit = {Coeff = 1 / 20}},
		Stamina = {Health = {Coeff = 10}},
		Intellect = {Mana = {Coeff = 15}, SpellCrit = {Coeff = 1.0 / 59.5}},
		Spirit = {ManaRegen = {Coeff = 0.25 * 2.5}}, -- * 2.5 to convert from ticks to per-five-seconds
		Strength = {BlockAmount = {Coeff = 1 / 22}},
	},
	
	PALADIN =
	{
		Agility = {Armor = {Coeff = 2}, Dodge = {Coeff = 1 / 20}, MeleeCrit = {Coeff = 1 / 20}},
		Stamina = {Health = {Coeff = 10}},
		Intellect = {Mana = {Coeff = 15}, SpellCrit = {Coeff = 1.0 / 20}},
		Spirit = {ManaRegen = {Coeff = 0.25 * 2.5}}, -- * 2.5 to convert from ticks to per-five-seconds
		Strength = {BlockAmount = {Coeff = 1 / 22}},
	},
	
	PRIEST =
	{
		Agility = {Armor = {Coeff = 2}, Dodge = {Coeff = 1 / 20}, MeleeCrit = {Coeff = 1 / 20}},
		Stamina = {Health = {Coeff = 10}},
		Intellect = {Mana = {Coeff = 15}, SpellCrit = {Coeff = 1.0 / 30}},
		Spirit = {ManaRegen = {Coeff = 0.25 * 2.5}}, -- * 2.5 to convert from ticks to per-five-seconds
		Strength = {BlockAmount = {Coeff = 1 / 22}},
	},
	
	ROGUE =
	{
		Agility = {Armor = {Coeff = 2}, Dodge = {Coeff = 1 / 14.5}, MeleeCrit = {Coeff = 1 / 29}},
		Stamina = {Health = {Coeff = 10}},
		Intellect = {Mana = {Coeff = 15}},
		Spirit = {ManaRegen = {Coeff = 0.25 * 2.5}}, -- * 2.5 to convert from ticks to per-five-seconds
		Strength = {BlockAmount = {Coeff = 1 / 22}},
	},
	
	SHAMAN =
	{
		Agility = {Armor = {Coeff = 2}, Dodge = {Coeff = 1 / 20}, MeleeCrit = {Coeff = 1 / 20}},
		Stamina = {Health = {Coeff = 10}},
		Intellect = {Mana = {Coeff = 15}, SpellCrit = {Coeff = 1.0 / 20}},
		Spirit = {ManaRegen = {Coeff = 0.25 * 2.5}}, -- * 2.5 to convert from ticks to per-five-seconds
		Strength = {BlockAmount = {Coeff = 1 / 22}},
	},
	
	WARLOCK =
	{
		Agility = {Armor = {Coeff = 2}, Dodge = {Coeff = 1 / 20}, MeleeCrit = {Coeff = 1 / 20}},
		Stamina = {Health = {Coeff = 10}},
		Intellect = {Mana = {Coeff = 15}, SpellCrit = {Coeff = 1.0 / 30}},
		Spirit = {ManaRegen = {Coeff = 0.25 * 2.5}}, -- * 2.5 to convert from ticks to per-five-seconds
		Strength = {BlockAmount = {Coeff = 1 / 22}},
	},
	
	WARRIOR =
	{
		Agility = {Armor = {Coeff = 2}, Dodge = {Coeff = 1 / 20}, MeleeCrit = {Coeff = 1 / 20}},
		Stamina = {Health = {Coeff = 10}},
		Intellect = {Mana = {Coeff = 15}},
		Spirit = {ManaRegen = {Coeff = 0.25 * 2.5}}, -- * 2.5 to convert from ticks to per-five-seconds
		Strength = {BlockAmount = {Coeff = 1 / 22}},
	},
};

local Outfitter_cCombatEquipmentSlots =
{
	MainHandSlot = true,
	SecondaryHandSlot = true,
	RangedSlot = true,
	AmmoSlot = true,
};

local gOutfitter_OutfitStack = {};

local gOutfitter_SelectedOutfit = nil;
local gOutfitter_DisplayIsDirty = true;

local gOutfitter_CurrentZone = nil;
local gOutfitter_InCombat = false;
local gOutfitter_IsDead = false;
local gOutfitter_IsFeigning = false;

local gOutfitter_EquippedNeedsUpdate = false;
local gOutfitter_WeaponsNeedUpdate = false;
local gOutfitter_LastEquipmentUpdateTime = 0;
local Outfitter_cMinEquipmentUpdateInterval = 1.5;

local gOutfitter_CurrentOutfit = nil;
local gOutfitter_ExpectedOutfit = nil;
local gOutfitter_CurrentInventoryOutfit = nil;
local gOutfitter_EquippableItems = nil;

local gOutfitter_Initialized = false;
local gOutfitter_Suspended = false;

local Outfitter_cMaxDisplayedItems = 14;

local gOutfitter_PanelFrames =
{
	"OutfitterMainFrame",
	"OutfitterOptionsFrame",
	"OutfitterAboutFrame",
};

local gOutfitter_CurrentPanel = 0;

local	Outfitter_cShapeshiftSpecialIDs =
{
	-- Warriors
	
	[Outfitter_cBattleStance] = {ID = "Battle"},
	[Outfitter_cDefensiveStance] = {ID = "Defensive"},
	[Outfitter_cBerserkerStance] = {ID = "Berserker"},
	
	-- Druids
	
	[Outfitter_cBearForm] = {ID = "Bear"},
	[Outfitter_cCatForm] = {ID = "Cat"},
	[Outfitter_cAquaticForm] = {ID = "Aquatic"},
	[Outfitter_cTravelForm] = {ID = "Travel"},
	[Outfitter_cDireBearForm] = {ID = "Bear"},
	[Outfitter_cMoonkinForm] = {ID = "Moonkin"},
	
	-- Rogues
	
	[Outfitter_cStealth] = {ID = "Stealth"},
};

local gOutfitter_SpecialState = {};

StaticPopupDialogs["OUTFITTER_CONFIRM_DELETE"] =
{
	text = TEXT(Outfitter_cConfirmDeleteMsg),
	button1 = TEXT(DELETE),
	button2 = TEXT(CANCEL),
	OnAccept = function() Outfitter_DeleteSelectedOutfit(); end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};

StaticPopupDialogs["OUTFITTER_CONFIRM_REBUILD"] =
{
	text = TEXT(Outfitter_cConfirmRebuildMsg),
	button1 = TEXT(Outfitter_cRebuild),
	button2 = TEXT(CANCEL),
	OnAccept = function() Outfitter_RebuildSelectedOutfit(); end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1,
};

function Outfitter_ToggleOutfitterFrame()
	if Outfitter_IsOpen() then
		OutfitterFrame:Hide();
	else
		OutfitterFrame:Show();
	end
end

function Outfitter_IsOpen()
	return OutfitterFrame:IsVisible();
end

function Outfitter_OnLoad()
	Outfitter_RegisterEvent(this, "PLAYER_ENTERING_WORLD", Outfitter_PlayerEnteringWorld);
	Outfitter_RegisterEvent(this, "PLAYER_LEAVING_WORLD", Outfitter_PlayerLeavingWorld);
	Outfitter_RegisterEvent(this, "VARIABLES_LOADED", Outfitter_VariablesLoaded);
	
	-- For monitoring mounted, dining and shadowform states
	
	Outfitter_RegisterEvent(this, "PLAYER_AURAS_CHANGED", Outfitter_UpdateAuraStates);
	
	-- For monitoring plaguelands and battlegrounds
	
	Outfitter_RegisterEvent(this, "ZONE_CHANGED_NEW_AREA", Outfitter_UpdateZone);
	
	-- For monitoring player combat state
	
	Outfitter_RegisterEvent(this, "PLAYER_REGEN_ENABLED", Outfitter_RegenEnabled);
	Outfitter_RegisterEvent(this, "PLAYER_REGEN_DISABLED", Outfitter_RegenDisabled);
	
	-- For monitoring player dead/alive stat
	
	Outfitter_RegisterEvent(this, "PLAYER_DEAD", Outfitter_PlayerDead);
	Outfitter_RegisterEvent(this, "PLAYER_ALIVE", Outfitter_PlayerAlive);
	Outfitter_RegisterEvent(this, "PLAYER_UNGHOST", Outfitter_PlayerAlive);
	
	Outfitter_RegisterEvent(this, "UNIT_INVENTORY_CHANGED", Outfitter_InventoryChanged);
	
	-- For indicating which outfits are missing items
	
	Outfitter_RegisterEvent(this, "BAG_UPDATE", Outfitter_BagUpdate);
	Outfitter_RegisterEvent(this, "PLAYERBANKSLOTS_CHANGED", Outfitter_BankSlotsChanged);
	
	-- For monitoring bank bags
	
	Outfitter_RegisterEvent(this, "BANKFRAME_OPENED", Outfitter_BankFrameOpened);
	Outfitter_RegisterEvent(this, "BANKFRAME_CLOSED", Outfitter_BankFrameClosed);
	
	-- For unequipping the dining outfit
	
	Outfitter_RegisterEvent(this, "UNIT_HEALTH", Outfitter_UnitHealthOrManaChanged);
	Outfitter_RegisterEvent(this, "UNIT_MANA", Outfitter_UnitHealthOrManaChanged);
	
	Outfitter_SuspendEvent(this, "UNIT_HEALTH"); -- Don't actually care until the dining outfit equips
	Outfitter_SuspendEvent(this, "UNIT_MANA");
	
	-- Tabs
	
	PanelTemplates_SetNumTabs(this, table.getn(gOutfitter_PanelFrames));
	OutfitterFrame.selectedTab = gOutfitter_CurrentPanel;
	PanelTemplates_UpdateTabs(this);
	
	-- Install the /outfit command handler

	SlashCmdList["OUTFITTER"] = Outfitter_ExecuteCommand;
	
	SLASH_OUTFITTER1 = "/outfitter";
	
	-- Fake a leaving world event to suspend inventory/bag
	-- updating until loading is completed
	
	Outfitter_PlayerLeavingWorld();
end

function Outfitter_OnShow()
	Outfitter_ShowPanel(1); -- Always switch to the main view when showing the window
end

function Outfitter_OnHide()
	Outfitter_ClearSelection();
	OutfitterQuickSlots_Close();
	OutfitterFrame:Hide(); -- This seems redundant, but the OnHide handler gets called
	                       -- in response to the parent being hidden (the character window)
	                       -- so calling Hide() on the frame here ensures that when the
	                       -- character window is hidden then Outfitter won't be displayed
	                       -- next time it's opened
end

function Outfitter_OnEvent(pEvent)
	-- Ignore all events except for entering world until initialization is
	-- completed
	
	if not gOutfitter_Initialized
	and pEvent ~= "VARIABLES_LOADED" then
		if pEvent ~= Outfitter_cInitializationEvent then
			return;
		end
		
		Outfitter_Initialize();
	end
	
	--
	
	Outfitter_DispatchEvent(this, pEvent);
	Outfitter_Update(false);
end

function Outfitter_PlayerLeavingWorld()
	-- To improve load screen performance, suspend events which are
	-- fired repeatedly and rapidly during zoning
	
	gOutfitter_Suspended = true;
	
	Outfitter_SuspendEvent(OutfitterFrame, "BAG_UPDATE");
	Outfitter_SuspendEvent(OutfitterFrame, "UNIT_INVENTORY_CHANGED");
	Outfitter_SuspendEvent(OutfitterFrame, "UPDATE_INVENTORY_ALERTS");
	Outfitter_SuspendEvent(OutfitterFrame, "SPELLS_CHANGED");
	Outfitter_SuspendEvent(OutfitterFrame, "PLAYER_AURAS_CHANGED");
	Outfitter_SuspendEvent(OutfitterFrame, "PLAYERBANKSLOTS_CHANGED");
end

function Outfitter_PlayerEnteringWorld()
	OutfitterItemList_FlushEquippableItems();
	
	Outfitter_RegenEnabled();
	Outfitter_UpdateAuraStates();
	Outfitter_SetSpecialOutfitEnabled("Riding", false);
	
	Outfitter_ResumeLoadScreenEvents();
end

function Outfitter_ResumeLoadScreenEvents()
	if gOutfitter_Suspended then
		-- To improve load screen performance, suspend events which are
		-- fired repeatedly and rapidly during zoning
		
		gOutfitter_Suspended = false;

		Outfitter_ResumeEvent(OutfitterFrame, "BAG_UPDATE");
		Outfitter_ResumeEvent(OutfitterFrame, "UNIT_INVENTORY_CHANGED");
		Outfitter_ResumeEvent(OutfitterFrame, "UPDATE_INVENTORY_ALERTS");
		Outfitter_ResumeEvent(OutfitterFrame, "SPELLS_CHANGED");
		Outfitter_ResumeEvent(OutfitterFrame, "PLAYER_AURAS_CHANGED");
		Outfitter_ResumeEvent(OutfitterFrame, "PLAYERBANKSLOTS_CHANGED");
		
		Outfitter_InventoryChanged2();
	end
end

function Outfitter_VariablesLoaded()
	-- Change the initialization event to PLAYER_ALIVE if this is the first use
	-- This will ensure that the bags and inventory info has been loaded before
	-- trying to generate the automatic outfits
	
	if not gOutfitter_Settings
	or not gOutfitter_Settings.Outfits then
		Outfitter_cInitializationEvent = "PLAYER_ALIVE";
	end
end

function Outfitter_BankSlotsChanged()
	OutfitterItemList_FlushBagFromEquippableItems(-1);
	
	for vBagIndex = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
		OutfitterItemList_FlushBagFromEquippableItems(vBagIndex);
	end
	
	-- Force the bank bags to update since they now exist
	
	if gOutfitter_EquippableItems then
		gOutfitter_EquippableItems.NeedsUpdate = true;
	end
	
	gOutfitter_DisplayIsDirty = true;
	Outfitter_Update(false);
end

function Outfitter_BagUpdate()
	local	vBagIndex = arg1;
	
	OutfitterItemList_FlushBagFromEquippableItems(vBagIndex);

	-- This is a messy hack to ensure the database gets updated properly
	-- after an upgrade.  WoW doesn't always have the players items
	-- loaded on PLAYER_ENTERING_WORLD so once the bag update fires
	-- we check the databases again if necessary
	
	if gOutfitter_NeedItemCodesUpdated then
		gOutfitter_NeedItemCodesUpdated = gOutfitter_NeedItemCodesUpdated - 1;
		
		if gOutfitter_NeedItemCodesUpdated == 0 then
			gOutfitter_NeedItemCodesUpdated = nil;
		end
		
		if Outfitter_UpdateDatabaseItemCodes() then
			gOutfitter_NeedItemCodesUpdated = nil;
		end
	end
	
	--
	
	gOutfitter_DisplayIsDirty = true;
	Outfitter_Update(false);
end

local	gOutfitter_OutfitEvents = {};

function Outfitter_RegisterOutfitEvent(pEvent, pFunction)
	local	vHandlers = gOutfitter_OutfitEvents[pEvent];
	
	if not vHandlers then
		vHandlers = {};
		gOutfitter_OutfitEvents[pEvent] = vHandlers;
	end
	
	table.insert(vHandlers, pFunction);
end

function Outfitter_UnregisterOutfitEvent(pEvent, pFunction)
	local	vHandlers = gOutfitter_OutfitEvents[pEvent];
	
	if not vHandlers then
		return;
	end
	
	for vIndex, vFunction in vHandlers do
		if vFunction == pFunction then
			table.remove(vHandlers, vIndex);
			return;
		end
	end
end

function Outfitter_DispatchOutfitEvent(pEvent, pParameter1, pParameter2)
	-- Don't send out events until we're initialized
	
	if not gOutfitter_Initialized then
		return;
	end
	
	--
	
	OutfitterMinimapDropDown_OutfitEvent(pEvent, pParameter1, pParameter2);
	
	local	vHandlers = gOutfitter_OutfitEvents[pEvent];
	
	if not vHandlers then
		return;
	end
	
	for _, vFunction in vHandlers do
		-- Call in protected mode so that if they fail it doesn't
		-- screw up Outfitter or other addons wishing to be notified
		
		pcall(vFunction, pEvent, pParameter1, pParameter2);
	end
end

function Outfitter_BankFrameOpened()
	gOutfitter_BankFrameOpened = true;
	gOutfitter_DisplayIsDirty = true;
	
	Outfitter_BankSlotsChanged();
	
	Outfitter_Update(false);
end

function Outfitter_BankFrameClosed()
	gOutfitter_BankFrameOpened = false;
	
	Outfitter_BankSlotsChanged();
	
	gOutfitter_DisplayIsDirty = true;
	Outfitter_Update(false);
end

function Outfitter_RegenEnabled(pEvent)
	gOutfitter_InCombat = false;
end

function Outfitter_RegenDisabled(pEvent)
	gOutfitter_InCombat = true;
end

function Outfitter_PlayerDead(pEvent)
	gOutfitter_IsDead = true;
end

function Outfitter_PlayerAlive(pEvent)
	if not UnitIsDeadOrGhost("player") then
		gOutfitter_IsDead = false;
	end
end

function Outfitter_UnitHealthOrManaChanged()
	if arg1 ~= "player" then
		return;
	end
	
	local	vHealth = UnitHealth("player");
	local	vMaxHealth = UnitHealthMax("player");
	local	vFullHealth = false;
	local	vFullMana = false;
	
	if vHealth > (vMaxHealth * 0.99) then
		vFullHealth = true;
	end
	
	if UnitPowerType("player") == 0 then
		local	vMana = UnitMana("player");
		local	vMaxMana = UnitManaMax("player");
		
		if vMana > (vMaxMana * 0.99) then
			vFullMana = true;
		end
	else
		vFullMana = true;
	end
	
	if vFullHealth and vFullMana then
		Outfitter_SetSpecialOutfitEnabled("Dining", false);
	end
end

function Outfitter_InventoryChanged(pEvent)
	if arg1 ~= "player" then
		return;
	end
	
	Outfitter_InventoryChanged2();
end

function Outfitter_InventoryChanged2()
	OutfitterItemList_FlushEquippableItems(); -- Flush everything because the game sends bag update
	                                          -- events for an item after it's already appeared in the inventory.  This
	                                          -- creates a brief situation in which the item appears to be both in the
	                                          -- bank and in the inventory which causes various problems for Outfitter
	                                          -- when checking for items.
	
	gOutfitter_DisplayIsDirty = true; -- Update the list so the checkboxes reflect the current state
	
	local	vNewItemsOutfit, vCurrentOutfit = Outfitter_GetNewItemsOutfit(gOutfitter_CurrentOutfit);
	
	if vNewItemsOutfit then
		if not gOutfitter_Settings.Options.DisableAutoVisibility then
			-- If the cloak is changing, remember the visibility for the old one and set
			-- it for the new one
			
			if vNewItemsOutfit.Items.BackSlot then
				if gOutfitter_CurrentOutfit.Items.BackSlot.Code then
					if ShowingCloak() then
						gOutfitter_Settings.HideCloak[gOutfitter_CurrentOutfit.Items.BackSlot.Code] = false;
					else
						gOutfitter_Settings.HideCloak[gOutfitter_CurrentOutfit.Items.BackSlot.Code] = true;
					end
				end
				
				if gOutfitter_Settings.HideCloak[vNewItemsOutfit.Items.BackSlot.Code] ~= nil then
					if gOutfitter_Settings.HideCloak[vNewItemsOutfit.Items.BackSlot.Code] then
						ShowCloak(0);
					else
						ShowCloak(1);
					end
				end
			end
			
			-- If the helm is changing, remember the visibility for the old one and set
			-- it for the new one
			
			if vNewItemsOutfit.Items.HeadSlot then
				if gOutfitter_CurrentOutfit.Items.HeadSlot.Code then
					if ShowingHelm() then
						gOutfitter_Settings.HideHelm[gOutfitter_CurrentOutfit.Items.HeadSlot.Code] = false;
					else
						gOutfitter_Settings.HideHelm[gOutfitter_CurrentOutfit.Items.HeadSlot.Code] = true;
					end
				end
				
				if gOutfitter_Settings.HideHelm[vNewItemsOutfit.Items.HeadSlot.Code] ~= nil then
					if gOutfitter_Settings.HideHelm[vNewItemsOutfit.Items.HeadSlot.Code] then
						ShowHelm(0);
					else
						ShowHelm(1);
					end
				end
			end
		end
		
		-- Save the new outfit
		
		gOutfitter_CurrentOutfit = vCurrentOutfit;
		
		-- Close QuickSlots if there's an inventory change (except if the only
		-- change is with the ammo slots)
		
		if OutfitterQuickSlots.SlotName ~= "AmmoSlot"
		or not Outfitter_OutfitIsAmmoOnly(vNewItemsOutfit) then
			OutfitterQuickSlots_Close();
		end
		
		-- Update the selected outfit or temporary outfit
		
		Outfitter_SubtractOutfit(vNewItemsOutfit, gOutfitter_ExpectedOutfit);
		
		if gOutfitter_SelectedOutfit then
			Outfitter_UpdateOutfitFromInventory(gOutfitter_SelectedOutfit, vNewItemsOutfit);
		else
			Outfitter_UpdateTemporaryOutfit(vNewItemsOutfit);
		end
	end
	
	Outfitter_Update(true);
end

function Outfitter_OutfitIsAmmoOnly(pOutfit)
	local	vHasAmmoItem = false;
	
	for vInventorySlot, vItem in pOutfit.Items do
		if vInventorySlot ~= "AmmoSlot" then
			return false;
		else
			vHasAmmoItem = true;
		end
	end
	
	return vHasAmmoItem;
end

function Outfitter_ExecuteCommand(pCommand)
	vCommands =
	{
		wear = {useOutfit = true, func = Outfitter_WearOutfit},
		unwear = {useOutfit = true, func = Outfitter_RemoveOutfit},
		toggle = {useOutfit = true, func = Outfitter_ToggleOutfit},
		summary = {useOutfit = false, func = Outfitter_OutfitSummary},
	}

	local	vStartIndex, vEndIndex, vCommand, vParameter = string.find(pCommand, "(%w+) ?(.*)");
	
	if not vCommand then
		Outfitter_NoteMessage(HIGHLIGHT_FONT_COLOR_CODE.."/outfitter wear <outfit name>"..NORMAL_FONT_COLOR_CODE..": Wear an outfit");
		Outfitter_NoteMessage(HIGHLIGHT_FONT_COLOR_CODE.."/outfitter unwear <outfit name>"..NORMAL_FONT_COLOR_CODE..": Remove an outfit");
		Outfitter_NoteMessage(HIGHLIGHT_FONT_COLOR_CODE.."/outfitter toggle <outfit name>"..NORMAL_FONT_COLOR_CODE..": Wears or removes an outfit");
		return;
	end
	
	vCommand = strlower(vCommand);
	
	local	vCommandInfo = vCommands[vCommand];
	
	if not vCommandInfo then
		Outfitter_ErrorMessage("Outfitter: Expected command");
		return;
	end
	
	local	vOutfit = nil;
	local	vCategoryID = nil;
	
	if vCommandInfo.useOutfit then
		if not vParameter then
			Outfitter_ErrorMessage("Outfitter: Expected outfit name for "..vCommand.." command");
			return;
		end
		
		vOutfit, vCategoryID = Outfitter_FindOutfitByName(vParameter);
		
		if not vOutfit then
			Outfitter_ErrorMessage("Outfitter: Couldn't find outfit named "..vParameter);
			return;
		end
		
		vCommandInfo.func(vOutfit, vCategoryID);
	else
		vCommandInfo.func();
	end
end

function Outfitter_AskRebuildOutfit(pOutfit, pCategoryID)
	gOutfitter_OutfitToRebuild = pOutfit;
	gOutfitter_OutfitCategoryToRebuild = pCategoryID;
	
	StaticPopup_Show("OUTFITTER_CONFIRM_REBUILD", gOutfitter_OutfitToRebuild.Name);
end

function Outfitter_RebuildSelectedOutfit()
	if not gOutfitter_OutfitToRebuild then
		return;
	end
	
	local	vOutfit = Outfitter_GenerateSmartOutfit("temp", gOutfitter_OutfitToRebuild.StatID, OutfitterItemList_GetEquippableItems(true));
	
	if vOutfit then
		gOutfitter_OutfitToRebuild.Items = vOutfit.Items;
		Outfitter_UpdateOutfitCategory(gOutfitter_OutfitToRebuild);
		Outfitter_WearOutfit(gOutfitter_OutfitToRebuild, gOutfitter_OutfitCategoryToRebuild);
		Outfitter_Update(true);
	end
	
	gOutfitter_OutfitToRebuild = nil;
	gOutfitter_OutfitCategoryToRebuild = nil;
end

function Outfitter_AskDeleteOutfit(pOutfit)
	gOutfitter_OutfitToDelete = pOutfit;
	StaticPopup_Show("OUTFITTER_CONFIRM_DELETE", gOutfitter_OutfitToDelete.Name);
end

function Outfitter_DeleteSelectedOutfit()
	if not gOutfitter_OutfitToDelete then
		return;
	end
	
	Outfitter_DeleteOutfit(gOutfitter_OutfitToDelete);
	
	Outfitter_Update(true);
end

function Outfitter_ShowPanel(pPanelIndex)
	Outfitter_CancelDialogs(); -- Force any dialogs to close if they're open
	
	if gOutfitter_CurrentPanel > 0
	and gOutfitter_CurrentPanel ~= pPanelIndex then
		Outfitter_HidePanel(gOutfitter_CurrentPanel);
	end
	
	-- NOTE: Don't check for redundant calls since this function
	-- will be called to reset the field values as well as to 
	-- actually show the panel when it's hidden
	
	gOutfitter_CurrentPanel = pPanelIndex;
	
	getglobal(gOutfitter_PanelFrames[pPanelIndex]):Show();
	
	PanelTemplates_SetTab(OutfitterFrame, pPanelIndex);
	
	-- Update the control values
	
	if pPanelIndex == 1 then
		-- Main panel
		
	elseif pPanelIndex == 2 then
		-- Options panel
		
	elseif pPanelIndex == 3 then
		-- About panel
		
	else
		Outfitter_ErrorMessage("Outfitter: Unknown index ("..pPanelIndex..") in ShowPanel()");
	end
	
	Outfitter_Update(false);
end

function Outfitter_HidePanel(pPanelIndex)
	if gOutfitter_CurrentPanel ~= pPanelIndex then
		return;
	end
	
	getglobal(gOutfitter_PanelFrames[pPanelIndex]):Hide();
	gOutfitter_CurrentPanel = 0;
end

function Outfitter_CancelDialogs()
end

function OutfitterItemDropDown_OnLoad()
	UIDropDownMenu_SetAnchor(0, 0, this, "TOPLEFT", this:GetName(), "CENTER");
	UIDropDownMenu_Initialize(this, OutfitterItemDropDown_Initialize);
	--UIDropDownMenu_Refresh(this); -- Don't refresh on menus which don't have a text portion
	
	this:SetHeight(this.SavedHeight);
end

function Outfitter_AddDividerMenuItem()
	UIDropDownMenu_AddButton({text = " ", notCheckable = true, notClickable = true});
end

function Outfitter_AddCategoryMenuItem(pName)
	UIDropDownMenu_AddButton({text = pName, notCheckable = true, notClickable = true});
end

function Outfitter_AddMenuItem(pFrame, pName, pValue, pChecked, pLevel, pColor, pDisabled)
	if not pColor then
		pColor = NORMAL_FONT_COLOR;
	end
	
	UIDropDownMenu_AddButton({text = pName, value = pValue, owner = pFrame, checked = pChecked, func = OutfitterDropDown_OnClick2, textR = pColor.r, textG = pColor.g, textB = pColor.b, disabled = pDisabled}, pLevel);
end

function Outfitter_AddSubmenuItem(pFrame, pName, pValue)
	UIDropDownMenu_AddButton({text = pName, owner = pFrame, hasArrow = 1, value = pValue, textR = NORMAL_FONT_COLOR.r, textG = NORMAL_FONT_COLOR.g, textB = NORMAL_FONT_COLOR.b});
end

function OutfitterItemDropDown_Initialize()
	local	vFrame = getglobal(UIDROPDOWNMENU_INIT_MENU);
	local	vItem = vFrame:GetParent():GetParent();
	local	vOutfit, vCategoryID = Outfitter_GetOutfitFromListItem(vItem);
	
	if not vOutfit then
		return;
	end
	
	if UIDROPDOWNMENU_MENU_LEVEL == 1 then
		local	vIsSpecialOutfit = vCategoryID == "Special";
		
		Outfitter_AddCategoryMenuItem(vOutfit.Name);
		
		if vIsSpecialOutfit then
			Outfitter_AddMenuItem(vFrame, Outfitter_cDisableOutfit, "DISABLE", vOutfit.Disabled);
			Outfitter_AddMenuItem(vFrame, Outfitter_cDisableOutfitInBG, "BGDISABLE", vOutfit.BGDisabled);
		else
			Outfitter_AddMenuItem(vFrame, PET_RENAME, "RENAME");
		end
		
		if not vIsSpecialOutfit
		and vOutfit.StatID then
			local	vStatName = Outfitter_GetStatIDName(vOutfit.StatID);
			
			if vStatName then
				Outfitter_AddMenuItem(vFrame, format(Outfitter_cRebuildOutfitFormat, vStatName), "REBUILD");
			end
		end
		
		Outfitter_AddSubmenuItem(vFrame, Outfitter_cKeyBinding, "BINDING");
		
		if not vIsSpecialOutfit then
			Outfitter_AddMenuItem(vFrame, DELETE, "DELETE");
		end
		
		Outfitter_AddCategoryMenuItem(Outfitter_cBankCategoryTitle);
		Outfitter_AddMenuItem(vFrame, Outfitter_cDepositToBank, "DEPOSIT", nil, nil, nil, not gOutfitter_BankFrameOpened);
		Outfitter_AddMenuItem(vFrame, Outfitter_cDepositUniqueToBank, "DEPOSITUNIQUE", nil, nil, nil, not gOutfitter_BankFrameOpened);
		Outfitter_AddMenuItem(vFrame, Outfitter_cWithdrawFromBank, "WITHDRAW", nil, nil, nil, not gOutfitter_BankFrameOpened);
		
		if not vIsSpecialOutfit
		and vCategoryID ~= "Complete" then
			Outfitter_AddCategoryMenuItem(Outfitter_cOutfitCategoryTitle);
			Outfitter_AddMenuItem(vFrame, Outfitter_cPartialOutfits, "PARTIAL", vCategoryID == "Partial");
			Outfitter_AddMenuItem(vFrame, Outfitter_cAccessoryOutfits, "ACCESSORY", vCategoryID == "Accessory");
		end
		
	elseif UIDROPDOWNMENU_MENU_LEVEL == 2 then
		if UIDROPDOWNMENU_MENU_VALUE == "BINDING" then
			for vIndex = 1, 10 do
				Outfitter_AddMenuItem(vFrame, getglobal("BINDING_NAME_OUTFITTER_OUTFIT"..vIndex), "BINDING"..vIndex, vOutfit.BindingIndex == vIndex, UIDROPDOWNMENU_MENU_LEVEL);
			end
		end
	end
	
	vFrame:SetHeight(vFrame.SavedHeight);
end

function Outfitter_SetShowMinimapButton(pShowButton)
	gOutfitter_Settings.Options.HideMinimapButton = not pShowButton;
	
	if gOutfitter_Settings.Options.HideMinimapButton then
		OutfitterMinimapButton:Hide();
	else
		OutfitterMinimapButton:Show();
	end
	
	Outfitter_Update(false);
end

function Outfitter_SetRememberVisibility(pRememberVisibility)
	gOutfitter_Settings.Options.DisableAutoVisibility = not pRememberVisibility;
	
	Outfitter_Update(false);
end

function Outfitter_SetShowHotkeyMessages(pShowHotkeyMessages)
	gOutfitter_Settings.Options.DisableHotkeyMessages = not pShowHotkeyMessages;
	
	Outfitter_Update(false);
end

function OutfitterMinimapDropDown_OnLoad()
	UIDropDownMenu_SetAnchor(3, -7, this, "TOPRIGHT", this:GetName(), "TOPLEFT");
	UIDropDownMenu_Initialize(this, OutfitterMinimapDropDown_Initialize);
	--UIDropDownMenu_Refresh(this); -- Don't refresh on menus which don't have a text portion
	
	Outfitter_RegisterOutfitEvent("WEAR_OUTFIT", OutfitterMinimapDropDown_OutfitEvent);
	Outfitter_RegisterOutfitEvent("UNWEAR_OUTFIT", OutfitterMinimapDropDown_OutfitEvent);
end

function OutfitterMinimapDropDown_OutfitEvent(pEvent, pParameter1, pParameter2)
	if UIDROPDOWNMENU_OPEN_MENU ~= "OutfitterMinimapButton" then
		return;
	end
	
	UIDropDownMenu_Initialize(OutfitterMinimapButton, OutfitterMinimapDropDown_Initialize);
end

function OutfitterMinimapDropDown_AdjustScreenPosition(pMenu)
	local	vListFrame = getglobal("DropDownList1");
	
	if not vListFrame:IsVisible() then
		return;
	end
	
	local	vCenterX, vCenterY = pMenu:GetCenter();
	local	vScreenWidth, vScreenHeight = GetScreenWidth(), GetScreenHeight();
	
	local	vAnchor;
	local	vOffsetX, vOffsetY;
	
	if vCenterY < vScreenHeight / 2 then
		vAnchor = "BOTTOM";
		vOffsetY = -8;
	else
		vAnchor = "TOP";
		vOffsetY = -17;
	end
	
	if vCenterX < vScreenWidth / 2 then
		vAnchor = vAnchor.."LEFT";
		vOffsetX = 21;
	else
		vAnchor = vAnchor.."RIGHT";
		vOffsetX = 3;
	end
	
	vListFrame:ClearAllPoints();
	vListFrame:SetPoint(vAnchor, pMenu.relativeTo, pMenu.relativePoint, vOffsetX, vOffsetY);
end

function Outfitter_OutfitIsVisible(pOutfit)
	return not pOutfit.Disabled
	   and not Outfitter_IsEmptyOutfit(pOutfit);
end

function Outfitter_HasVisibleOutfits(pOutfits)
	if not pOutfits then
		return false;
	end
	
	for vIndex, vOutfit in pOutfits do
		if Outfitter_OutfitIsVisible(vOutfit) then	
			return true;
		end
	end
	
	return false;
end

function OutfitterMinimapDropDown_Initialize()
	-- Just return if not initialized yet
	
	if not gOutfitter_Initialized then
		return;
	end
	
	--
	
	local	vFrame = getglobal(UIDROPDOWNMENU_INIT_MENU);
	
	Outfitter_AddCategoryMenuItem(Outfitter_cTitleVersion);
	Outfitter_AddMenuItem(vFrame, Outfitter_cOpenOutfitter, 0);
	
	OutfitterMinimapDropDown_InitializeOutfitList();
end

function Outfitter_GetCategoryOrder()
	return gOutfitter_cCategoryOrder;
end

function Outfitter_GetOutfitsByCategoryID(pCategoryID)
	return gOutfitter_Settings.Outfits[pCategoryID];
end

function OutfitterMinimapDropDown_InitializeOutfitList()
	-- Just return if not initialized yet
	
	if not gOutfitter_Initialized then
		return;
	end
	
	--
	
	local	vFrame = getglobal(UIDROPDOWNMENU_INIT_MENU);
	local	vEquippableItems = OutfitterItemList_GetEquippableItems();
	local	vCategoryOrder = Outfitter_GetCategoryOrder();
	
	for vCategoryIndex, vCategoryID in vCategoryOrder do
		local	vCategoryName = getglobal("Outfitter_c"..vCategoryID.."Outfits");
		local	vOutfits = Outfitter_GetOutfitsByCategoryID(vCategoryID);
		
		if Outfitter_HasVisibleOutfits(vOutfits) then
			Outfitter_AddCategoryMenuItem(vCategoryName);
			
			for vIndex, vOutfit in vOutfits do
				if Outfitter_OutfitIsVisible(vOutfit) then
					local	vWearingOutfit = Outfitter_WearingOutfit(vOutfit);
					local	vMissingItems, vBankedItems = OutfitterItemList_GetMissingItems(vEquippableItems, vOutfit);
					local	vItemColor = NORMAL_FONT_COLOR;
					
					if vMissingItems then
						vItemColor = RED_FONT_COLOR;
					elseif vBankedItems then
						vItemColor = BANKED_FONT_COLOR;
					end
					
					Outfitter_AddMenuItem(vFrame, vOutfit.Name, {CategoryID = vCategoryID, Index = vIndex}, vWearingOutfit, nil, vItemColor);
				end
			end
		end
	end
end

function OutfitterDropDown_OnClick()
	UIDropDownMenu_SetSelectedValue(this.owner, this.value);
	OutfitterDropDown_OnClick2();
end

function OutfitterDropDown_OnClick2()
	if this.owner.ChangedValueFunc then
		this.owner.ChangedValueFunc(this.owner, this.value);
	end
	
	CloseDropDownMenus();
end

function OutfitterItem_SetTextColor(pItem, pRed, pGreen, pBlue)
	local	vItemNameField;
	
	if pItem.isCategory then
		vItemNameField = getglobal(pItem:GetName().."CategoryName");
	else
		vItemNameField = getglobal(pItem:GetName().."OutfitName");
	end
	
	vItemNameField:SetTextColor(pRed, pGreen, pBlue);
end

Outfitter_cCategoryDescriptions =
{
	Complete = Outfitter_cCompleteCategoryDescripton,
	Partial = Outfitter_cPartialCategoryDescription,
	Accessory = Outfitter_cAccessoryCategoryDescription,
	Special = Outfitter_cSpecialCategoryDescription,
	OddsNEnds = Outfitter_cOddsNEndsCategoryDescription,
};

Outfitter_cMissingItemsSeparator = ", ";

function Outfitter_GenerateItemListString(pLabel, pListColorCode, pItems)
	local	vItemList = nil;

	for vIndex, vOutfitItem in pItems do
		if not vItemList then
			vItemList = HIGHLIGHT_FONT_COLOR_CODE..pLabel..pListColorCode..vOutfitItem.Name;
		else
			vItemList = vItemList..Outfitter_cMissingItemsSeparator..vOutfitItem.Name;
		end
	end
	
	return vItemList;
end

function OutfitterItem_OnEnter(pItem)
	OutfitterItem_SetTextColor(pItem, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	
	if pItem.isCategory then
		local	vDescription = Outfitter_cCategoryDescriptions[pItem.categoryID];
		
		if vDescription then
			local	vCategoryName = getglobal("Outfitter_c"..pItem.categoryID.."Outfits");
			
			GameTooltip_AddNewbieTip(vCategoryName, 1.0, 1.0, 1.0, vDescription, 1);
		end
		
		ResetCursor();
	elseif pItem.isOutfitItem then
		local	vHasCooldown, vRepairCost;
		
		GameTooltip:SetOwner(pItem, "ANCHOR_TOP");
		
		if pItem.outfitItem.Location.SlotName then
			if not pItem.outfitItem.Location.SlotID then
				local	vSlotID, vEmptySlotTexture = GetInventorySlotInfo(pItem.outfitItem.Location.SlotName);
				
				pItem.outfitItem.Location.SlotID = vSlotID;
			end
			
			GameTooltip:SetInventoryItem("player", pItem.outfitItem.Location.SlotID);
		else
			vHasCooldown, vRepairCost = GameTooltip:SetBagItem(pItem.outfitItem.Location.BagIndex, pItem.outfitItem.Location.BagSlotIndex);
		end
		
		GameTooltip:Show();

		if InRepairMode() and (vRepairCost and vRepairCost > 0) then
			GameTooltip:AddLine(TEXT(REPAIR_COST), "", 1, 1, 1);
			SetTooltipMoney(GameTooltip, vRepairCost);
			GameTooltip:Show();
		elseif MerchantFrame:IsShown() and MerchantFrame.selectedTab == 1 then
			if pItem.outfitItem.Location.BagIndex then
				ShowContainerSellCursor(pItem.outfitItem.Location.BagIndex, pItem.outfitItem.Location.BagSlotIndex);
			end
		else
			ResetCursor();
		end
	else
		local	vOutfit = Outfitter_GetOutfitFromListItem(pItem);
		
		if pItem.MissingItems
		or pItem.BankedItems then
			GameTooltip:SetOwner(pItem, "ANCHOR_LEFT");
			
			GameTooltip:AddLine(vOutfit.Name);
			
			if pItem.MissingItems then
				local	vItemList = Outfitter_GenerateItemListString(Outfitter_cMissingItemsLabel, RED_FONT_COLOR_CODE, pItem.MissingItems);
				GameTooltip:AddLine(vItemList, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, true);
			end
			
			if pItem.BankedItems then
				local	vItemList = Outfitter_GenerateItemListString(Outfitter_cBankedItemsLabel, BANKED_FONT_COLOR_CODE, pItem.BankedItems);
				GameTooltip:AddLine(vItemList, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, true);
			end
			
			GameTooltip:Show();
		elseif vOutfit.SpecialID then
			local	vDescription = Outfitter_cSpecialOutfitDescriptions[vOutfit.SpecialID];
			
			if vDescription then
				GameTooltip_AddNewbieTip(vOutfit.Name, 1.0, 1.0, 1.0, vDescription, 1);
			end
		end
		
		ResetCursor();
	end
end

function OutfitterItem_OnLeave(pItem)
	if pItem.isCategory then
		OutfitterItem_SetTextColor(pItem, 1, 1, 1);
	else
		OutfitterItem_SetTextColor(pItem, pItem.DefaultColor.r, pItem.DefaultColor.g, pItem.DefaultColor.b);
	end
	
	GameTooltip:Hide();
end

function OutfitterItem_OnClick(pItem, pButton, pIgnoreModifiers)
	if pItem.isCategory then
		local	vCategoryOutfits = gOutfitter_Settings.Outfits[pItem.categoryID];
		
		gOutfitter_Collapsed[pItem.categoryID] = not gOutfitter_Collapsed[pItem.categoryID];
		gOutfitter_DisplayIsDirty = true;
	elseif pItem.isOutfitItem then
		if pButton == "LeftButton" then
			Outfitter_PickupItemLocation(pItem.outfitItem.Location);
			StackSplitFrame:Hide();
		else
			if MerchantFrame:IsShown() and MerchantFrame.selectedTab == 2 then
				-- Don't sell the item if the buyback tab is selected
				return;
			else
				if pItem.outfitItem.Location.BagIndex then
					UseContainerItem(pItem.outfitItem.Location.BagIndex, pItem.outfitItem.Location.BagSlotIndex);
					StackSplitFrame:Hide();
				end
			end
		end
	else
		local	vOutfit = Outfitter_GetOutfitFromListItem(pItem);
		
		if not vOutfit then
			-- Error: outfit not found
			return;
		end
		
		vOutfit.Disabled = nil;
		Outfitter_WearOutfit(vOutfit, pItem.categoryID);
	end
	
	Outfitter_Update(true);
end

function OutfitterItem_CheckboxClicked(pItem)
	if pItem.isCategory then
		return;
	end
	
	local	vOutfits = gOutfitter_Settings.Outfits[pItem.categoryID];
	
	if not vOutfits then
		-- Error: outfit category not found
		return;
	end
	
	local	vOutfit = vOutfits[pItem.outfitIndex];
	
	if not vOutfit then
		-- Error: outfit not found
		return;
	end
	
	local	vCheckbox = getglobal(pItem:GetName().."OutfitSelected");
	
	if vCheckbox:GetChecked() then
		vOutfit.Disabled = nil;
		Outfitter_WearOutfit(vOutfit, pItem.categoryID);
	else
		Outfitter_RemoveOutfit(vOutfit);
	end
	
	Outfitter_Update(true);
end

function OutfitterItem_SetToOutfit(pItemIndex, pOutfit, pCategoryID, pOutfitIndex, pEquippableItems)
	local	vItemName = "OutfitterItem"..pItemIndex;
	local	vItem = getglobal(vItemName);
	local	vOutfitFrameName = vItemName.."Outfit";
	local	vOutfitFrame = getglobal(vOutfitFrameName);
	local	vItemFrame = getglobal(vItemName.."Item");
	local	vCategoryFrame = getglobal(vItemName.."Category");
	local	vMissingItems, vBankedItems = OutfitterItemList_GetMissingItems(pEquippableItems, pOutfit);
	
	vOutfitFrame:Show();
	vCategoryFrame:Hide();
	vItemFrame:Hide();
	
	local	vItemSelectedCheckmark = getglobal(vOutfitFrameName.."Selected");
	local	vItemNameField = getglobal(vOutfitFrameName.."Name");
	local	vItemMenu = getglobal(vOutfitFrameName.."Menu");
	
	vItemSelectedCheckmark:Show();
	
	if Outfitter_WearingOutfit(pOutfit) then
		vItemSelectedCheckmark:SetChecked(true);
	else
		vItemSelectedCheckmark:SetChecked(nil);
	end
	
	vItem.MissingItems = vMissingItems;
	vItem.BankedItems = vBankedItems;
	
	if pOutfit.Disabled then
		vItemNameField:SetText(format(Outfitter_cDisabledOutfitName, pOutfit.Name));
		vItem.DefaultColor = GRAY_FONT_COLOR;
	else
		vItemNameField:SetText(pOutfit.Name);
		if vMissingItems then
			vItem.DefaultColor = RED_FONT_COLOR;
		elseif vBankedItems then
			vItem.DefaultColor = BANKED_FONT_COLOR;
		else
			vItem.DefaultColor = NORMAL_FONT_COLOR;
		end
	end
	
	vItemNameField:SetTextColor(vItem.DefaultColor.r, vItem.DefaultColor.g, vItem.DefaultColor.b);
	
	vItemMenu:Show();
	
	vItem.isCategory = false;
	vItem.isOutfitItem = false;
	vItem.outfitItem = nil;
	vItem.categoryID = pCategoryID;
	vItem.outfitIndex = pOutfitIndex;
	
	vItem:Show();
	
	-- Update the highlighting
	
	if gOutfitter_SelectedOutfit == pOutfit then
		OutfitterMainFrameHighlight:SetPoint("TOPLEFT", vItem, "TOPLEFT", 0, 0);
		OutfitterMainFrameHighlight:Show();
	end
end

function OutfitterItem_SetToItem(pItemIndex, pOutfitItem)
	local	vItemName = "OutfitterItem"..pItemIndex;
	local	vItem = getglobal(vItemName);
	local	vCategoryFrameName = vItemName.."Category";
	local	vItemFrameName = vItemName.."Item";
	local	vItemFrame = getglobal(vItemFrameName);
	local	vOutfitFrame = getglobal(vItemName.."Outfit");
	local	vCategoryFrame = getglobal(vCategoryFrameName);
	
	vItem.isOutfitItem = true;
	vItem.isCategory = false;
	vItem.outfitItem = pOutfitItem;
	
	vItemFrame:Show();
	vOutfitFrame:Hide();
	vCategoryFrame:Hide();

	local	vItemNameField = getglobal(vItemFrameName.."Name");
	local	vItemIcon = getglobal(vItemFrameName.."Icon");
	
	vItemNameField:SetText(pOutfitItem.Name);
	
	if pOutfitItem.Quality then
		vItem.DefaultColor = ITEM_QUALITY_COLORS[pOutfitItem.Quality];
	else
		vItem.DefaultColor = GRAY_FONT_COLOR;
	end
	
	if pOutfitItem.Texture then
		vItemIcon:SetTexture(pOutfitItem.Texture);
		vItemIcon:Show();
	else
		vItemIcon:Hide();
	end
	
	vItemNameField:SetTextColor(vItem.DefaultColor.r, vItem.DefaultColor.g, vItem.DefaultColor.b);
	
	vItem:Show();
end

function OutfitterItem_SetToCategory(pItemIndex, pCategoryID)
	local	vCategoryName = getglobal("Outfitter_c"..pCategoryID.."Outfits");
	local	vItemName = "OutfitterItem"..pItemIndex;
	local	vItem = getglobal(vItemName);
	local	vCategoryFrameName = vItemName.."Category";
	local	vOutfitFrame = getglobal(vItemName.."Outfit");
	local	vItemFrame = getglobal(vItemName.."Item");
	local	vCategoryFrame = getglobal(vCategoryFrameName);
	
	vOutfitFrame:Hide();
	vCategoryFrame:Show();
	vItemFrame:Hide();
	
	local	vItemNameField = getglobal(vCategoryFrameName.."Name");
	local	vExpandButton = getglobal(vCategoryFrameName.."Expand");
	
	vItem.MissingItems = nil;
	vItem.BankedItems = nil;
	
	if gOutfitter_Collapsed[pCategoryID] then
		vExpandButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up"); 
	else
		vExpandButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
	end
	
	vItemNameField:SetText(vCategoryName);
	
	vItem.isCategory = true;
	vItem.isOutfitItem = false;
	vItem.outfitItem = nil;
	vItem.categoryID = pCategoryID;
	
	vItem:Show();
end

function Outfitter_AddOutfitsToList(pOutfits, pCategoryID, pItemIndex, pFirstItemIndex, pEquippableItems)
	local	vOutfits = pOutfits[pCategoryID];
	local	vItemIndex = pItemIndex;
	local	vFirstItemIndex = pFirstItemIndex;
	
	if vFirstItemIndex == 0 then
		OutfitterItem_SetToCategory(vItemIndex, pCategoryID, false);
		vItemIndex = vItemIndex + 1;
	else
		vFirstItemIndex = vFirstItemIndex - 1;
	end

	if vItemIndex >= Outfitter_cMaxDisplayedItems then
		return vItemIndex, vFirstItemIndex;
	end

	if not gOutfitter_Collapsed[pCategoryID]
	and vOutfits then
		for vIndex, vOutfit in vOutfits do
			if vFirstItemIndex == 0 then
				OutfitterItem_SetToOutfit(vItemIndex, vOutfit, pCategoryID, vIndex, pEquippableItems);
				vItemIndex = vItemIndex + 1;
				
				if vItemIndex >= Outfitter_cMaxDisplayedItems then
					return vItemIndex, vFirstItemIndex;
				end
			else
				vFirstItemIndex = vFirstItemIndex - 1;
			end
		end
	end
	
	return vItemIndex, vFirstItemIndex;
end

function Outfitter_AddOutfitItemsToList(pOutfitItems, pCategoryID, pItemIndex, pFirstItemIndex)
	local	vItemIndex = pItemIndex;
	local	vFirstItemIndex = pFirstItemIndex;
	
	if vFirstItemIndex == 0 then
		OutfitterItem_SetToCategory(vItemIndex, pCategoryID, false);
		vItemIndex = vItemIndex + 1;
	else
		vFirstItemIndex = vFirstItemIndex - 1;
	end

	if vItemIndex >= Outfitter_cMaxDisplayedItems then
		return vItemIndex, vFirstItemIndex;
	end

	if not gOutfitter_Collapsed[pCategoryID] then
		for vIndex, vOutfitItem in pOutfitItems do
			if vFirstItemIndex == 0 then
				OutfitterItem_SetToItem(vItemIndex, vOutfitItem);
				vItemIndex = vItemIndex + 1;
				
				if vItemIndex >= Outfitter_cMaxDisplayedItems then
					return vItemIndex, vFirstItemIndex;
				end
			else
				vFirstItemIndex = vFirstItemIndex - 1;
			end
		end
	end
	
	return vItemIndex, vFirstItemIndex;
end

function Outfitter_SortOutfits()
	for vCategoryID, vOutfits in gOutfitter_Settings.Outfits do
		table.sort(vOutfits, Outfiter_CompareOutfitNames);
	end
end

function Outfiter_CompareOutfitNames(pOutfit1, pOutfit2)
	return pOutfit1.Name < pOutfit2.Name;
end

function Outfitter_Update(pUpdateSlotEnables)
	if not OutfitterFrame:IsVisible() then
		return;
	end
	
	if gOutfitter_CurrentPanel == 1 then
		-- Main panel
		
		if not gOutfitter_DisplayIsDirty then
			return;
		end
		
		gOutfitter_DisplayIsDirty = false;
		
		-- Sort the outfits
		
		Outfitter_SortOutfits();
		
		-- Get the equippable items so outfits can be marked if they're missing anything
		
		local	vEquippableItems = OutfitterItemList_GetEquippableItems();
		
		-- Update the slot enables if they're shown
		
		if pUpdateSlotEnables
		and OutfitterSlotEnables:IsVisible() then
			Outfitter_UpdateSlotEnables(gOutfitter_SelectedOutfit, vEquippableItems);
		end
		
		OutfitterItemList_CompiledUnusedItemsList(vEquippableItems);
		
		-- Update the list
		
		OutfitterMainFrameHighlight:Hide();

		local	vFirstItemIndex = FauxScrollFrame_GetOffset(OutfitterMainFrameScrollFrame);
		local	vItemIndex = 0;
		
		OutfitterItemList_ResetIgnoreItemFlags(vEquippableItems);
		
		for vCategoryIndex, vCategoryID in gOutfitter_cCategoryOrder do
			vItemIndex, vFirstItemIndex = Outfitter_AddOutfitsToList(gOutfitter_Settings.Outfits, vCategoryID, vItemIndex, vFirstItemIndex, vEquippableItems);
			
			if vItemIndex >= Outfitter_cMaxDisplayedItems then
				break;
			end
		end
		
		if vItemIndex < Outfitter_cMaxDisplayedItems
		and vEquippableItems.UnusedItems then
			vItemIndex, vFirstItemIndex = Outfitter_AddOutfitItemsToList(vEquippableItems.UnusedItems, "OddsNEnds", vItemIndex, vFirstItemIndex);
		end
		
		-- Hide any unused items
		
		for vItemIndex2 = vItemIndex, (Outfitter_cMaxDisplayedItems - 1) do
			local	vItemName = "OutfitterItem"..vItemIndex2;
			local	vItem = getglobal(vItemName);
			
			vItem:Hide();
		end
		
		local	vTotalNumItems = 0;
		
		for vCategoryIndex, vCategoryID in gOutfitter_cCategoryOrder do
			vTotalNumItems = vTotalNumItems + 1;
			
			local	vOutfits = gOutfitter_Settings.Outfits[vCategoryID];
			
			if not gOutfitter_Collapsed[vCategoryID]
			and vOutfits then
				vTotalNumItems = vTotalNumItems + table.getn(vOutfits);
			end
		end
		
		if vEquippableItems.UnusedItems then
			vTotalNumItems = vTotalNumItems + 1;
			
			if not gOutfitter_Collapsed["OddsNEnds"] then
				vTotalNumItems = vTotalNumItems + table.getn(vEquippableItems.UnusedItems);
			end
		end
		
		FauxScrollFrame_Update(
				OutfitterMainFrameScrollFrame,
				vTotalNumItems,                 -- numItems
				Outfitter_cMaxDisplayedItems,   -- numToDisplay
				18,                             -- valueStep
				nil, nil, nil,                  -- button, smallWidth, bigWidth
				nil,                            -- highlightFrame
				0, 0);                          -- smallHighlightWidth, bigHighlightWidth
	elseif gOutfitter_CurrentPanel == 2 then -- Options panel
		OutfitterShowMinimapButton:SetChecked(not gOutfitter_Settings.Options.HideMinimapButton);
		OutfitterRememberVisibility:SetChecked(not gOutfitter_Settings.Options.DisableAutoVisibility);
		OutfitterShowHotkeyMessages:SetChecked(not gOutfitter_Settings.Options.DisableHotkeyMessages);
	end
end

function Outfitter_OnVerticalScroll()
	gOutfitter_DisplayIsDirty = true;
	Outfitter_Update(false);
end

function Outfitter_SelectOutfit(pOutfit, pCategoryID)
	if not Outfitter_IsOpen() then
		return;
	end
	
	gOutfitter_SelectedOutfit = pOutfit;
	
	-- Get the equippable items so outfits can be marked if they're missing anything
	
	local	vEquippableItems = OutfitterItemList_GetEquippableItems();
	
	-- Update the slot enables
	
	Outfitter_UpdateSlotEnables(pOutfit, vEquippableItems);
	OutfitterSlotEnables:Show();
	
	-- Done, rebuild the list
	
	gOutfitter_DisplayIsDirty = true;
end

function Outfitter_UpdateSlotEnables(pOutfit, pEquippableItems)
	if UnitHasRelicSlot("player") then
		OutfitterEnableAmmoSlot:Hide();
	else
		OutfitterEnableAmmoSlot:Show();
	end
	
	for _, vInventorySlot in Outfitter_cSlotNames do
		local	vOutfitItem = pOutfit.Items[vInventorySlot];
		local	vCheckbox = getglobal("OutfitterEnable"..vInventorySlot);
		
		if not vOutfitItem then
			vCheckbox:SetChecked(false);
		else
			if OutfitterItemList_InventorySlotContainsItem(pEquippableItems, vInventorySlot, vOutfitItem) then
				vCheckbox:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check");
				vCheckbox.IsUnknown = false;
			else
				vCheckbox:SetCheckedTexture("Interface\\Addons\\Outfitter\\Textures\\CheckboxUnknown");
				vCheckbox.IsUnknown = true;
			end
			
			vCheckbox:SetChecked(true);
		end
	end
end

function Outfitter_ClearSelection()
	gOutfitter_SelectedOutfit = nil;
	gOutfitter_DisplayIsDirty = true;
	OutfitterSlotEnables:Hide();
end

function Outfitter_FindOutfitItemIndex(pOutfit)
	local	vOutfitCategoryID, vOutfitIndex = Outfitter_FindOutfit(pOutfit);
	
	if not vOutfitCategoryID then
		return nil;
	end
	
	local	vItemIndex = 0;
	
	for vCategoryIndex, vCategoryID in gOutfitter_cCategoryOrder do
		vItemIndex = vItemIndex + 1;
		
		if not gOutfitter_Collapsed[vCategoryID] then
			if vOutfitCategoryID == vCategoryID then
				return vItemIndex + vOutfitIndex - 1;
			else
				vItemIndex = vItemIndex + table.getn(gOutfitter_Settings.Outfits[vCategoryID]);
			end
		end
	end
	
	return nil;
end

function OutfitterStack_FindOutfit(pOutfit)
	for vIndex, vOutfit in gOutfitter_OutfitStack do
		if vOutfit == pOutfit then
			return true, vIndex;
		end
	end
	
	return false, nil;
end

function OutfitterStack_FindOutfitByCategory(pCategoryID)
	for vIndex, vOutfit in gOutfitter_OutfitStack do
		if vOutfit.CategoryID == pCategoryID then
			return true, vIndex;
		end
	end
	
	return false, nil;
end

function OutfitterStack_Clear()
	for vIndex, vOutfit in gOutfitter_OutfitStack do
		Outfitter_DispatchOutfitEvent("UNWEAR_OUTFIT", vOutfit.Name, vOutfit)
	end
	
	gOutfitter_OutfitStack = {};
	gOutfitter_Settings.LastOutfitStack = {};
	gOutfitter_DisplayIsDirty = true;
	
	if gOutfitter_Settings.Options.ShowStackContents then
		Outfitter_DebugMessage("Outfitter stack cleared");
	end
end

function OutfitterStack_ClearCategory(pCategoryID)
	local	vIndex = 1;
	local	vStackLength = table.getn(gOutfitter_OutfitStack);
	local	vChanged = false;
	
	while vIndex <= vStackLength do
		local	vOutfit = gOutfitter_OutfitStack[vIndex];
		
		if vOutfit
		and vOutfit.CategoryID == pCategoryID then
			Outfitter_DispatchOutfitEvent("UNWEAR_OUTFIT", vOutfit.Name, vOutfit)
			
			table.remove(gOutfitter_OutfitStack, vIndex);
			table.remove(gOutfitter_Settings.LastOutfitStack, vIndex);
			
			vStackLength = vStackLength - 1;
			vChanged = true;
		else
			vIndex = vIndex + 1;
		end
	end
	
	OutfitterStack_CollapseTemporaryOutfits();
	
	if vChanged then
		if gOutfitter_Settings.Options.ShowStackContents then
			OutfitterStack_DumpStackContents("Clear category "..pCategoryID);
		end
		
		gOutfitter_DisplayIsDirty = true;
	end
end

function OutfitterStack_GetTemporaryOutfit()
	local	vStackSize = table.getn(gOutfitter_OutfitStack);
	
	if vStackSize == 0 then
		return nil;
	end
	
	local	vOutfit = gOutfitter_OutfitStack[vStackSize];
	
	if vOutfit.Name then
		return nil;
	end
	
	return vOutfit;
end

function OutfitterStack_CollapseTemporaryOutfits()
	local	vIndex = 1;
	local	vStackLength = table.getn(gOutfitter_OutfitStack);
	local	vTemporaryOutfit1 = nil;
	
	while vIndex <= vStackLength do
		local	vOutfit = gOutfitter_OutfitStack[vIndex];
		
		if vOutfit
		and vOutfit.Name == nil then
			if vTemporaryOutfit1 then
				-- Copy the items up
				
				for vInventorySlot, vItem in vTemporaryOutfit1.Items do
					if not vOutfit.Items[vInventorySlot] then
						vOutfit.Items[vInventorySlot] = vItem;
					end
				end
				
				-- Remove the lower temp outfit
				
				table.remove(gOutfitter_OutfitStack, vIndex - 1);
				vStackLength = vStackLength - 1;
			else
				vIndex = vIndex + 1;
			end
			
			vTemporaryOutfit1 = vOutfit;
		else
			vTemporaryOutfit1 = nil;
			vIndex = vIndex + 1;
		end
	end
end

function OutfitterStack_IsTopmostOutfit(pOutfit)
	local	vStackLength = table.getn(gOutfitter_OutfitStack);
	
	if vStackLength == 0 then
		return false;
	end
	
	return gOutfitter_OutfitStack[vStackLength] == pOutfit;
end

function OutfitterStack_AddOutfit(pOutfit, pBelowOutfit)
	local	vFound, vIndex = OutfitterStack_FindOutfit(pOutfit);
	
	-- If it's already on then remove it from the stack
	-- so it can be added to the end
	
	if vFound then
		table.remove(gOutfitter_OutfitStack, vIndex);
		table.remove(gOutfitter_Settings.LastOutfitStack, vIndex);
		Outfitter_DispatchOutfitEvent("UNWEAR_OUTFIT", pOutfit.Name, pOutfit);
	end
	
	-- Figure out the position to insert at
	
	local	vStackLength = table.getn(gOutfitter_OutfitStack);
	local	vInsertIndex = vStackLength + 1;
	
	if pBelowOutfit then
		local	vFound2, vIndex = OutfitterStack_FindOutfit(pBelowOutfit);
		
		if vFound2 then
			vInsertIndex = vIndex;
		end
	end
	
	--[[ Always insert below the temporary outfit
	
	local	vTemporaryOutfit;
	
	if vStackLength > 0 then
		vTemporaryOutfit = gOutfitter_OutfitStack[vStackLength];
	end
	
	if vTemporaryOutfit and vTemporaryOutfit.Name == nil then
		-- Knock out any slots used by the new outfit if it's being inserted at the top
		
		if vInsertIndex >= vStackLength then
			for vInventorySlot, vItem in pOutfit.Items do
				vTemporaryOutfit.Items[vInventorySlot] = nil;
			end
			
			-- Remove the temporary outfit if it's empty now
			
			if Outfitter_IsEmptyOutfit(vTemporaryOutfit) then
				table.remove(gOutfitter_OutfitStack, vStackLength);
				table.remove(gOutfitter_Settings.LastOutfitStack, vStackLength);
				
				vInsertIndex = vStackLength;
				vStackLength = vStackLength - 1;
			else
				vInsertIndex = vStackLength;
			end
		end
	end
	
	]]--
	
	-- Add the outfit
	
	table.insert(gOutfitter_OutfitStack, vInsertIndex, pOutfit);
	
	if pOutfit.Name then
		table.insert(gOutfitter_Settings.LastOutfitStack, vInsertIndex, {Name = pOutfit.Name});
	else
		table.insert(gOutfitter_Settings.LastOutfitStack, vInsertIndex, pOutfit);
	end
	
	gOutfitter_DisplayIsDirty = true;
	
	if gOutfitter_Settings.Options.ShowStackContents then
		OutfitterStack_DumpStackContents("Add outfit");
	end
	
	if vFound then
		OutfitterStack_CollapseTemporaryOutfits();
	end
	
	Outfitter_DispatchOutfitEvent("WEAR_OUTFIT", pOutfit.Name, pOutfit);
end

function OutfitterStack_RemoveOutfit(pOutfit)
	local	vFound, vIndex = OutfitterStack_FindOutfit(pOutfit);
	
	if not vFound then
		return false;
	end
	
	-- Remove the outfit
	
	table.remove(gOutfitter_OutfitStack, vIndex);
	table.remove(gOutfitter_Settings.LastOutfitStack, vIndex);
	
	OutfitterStack_CollapseTemporaryOutfits();
	
	gOutfitter_DisplayIsDirty = true;
	
	if gOutfitter_Settings.Options.ShowStackContents then
		OutfitterStack_DumpStackContents("Remove outfit");
	end
	
	return true;
end

function OutfitterStack_RestoreSavedStack()
	if not gOutfitter_Settings.LastOutfitStack then
		gOutfitter_Settings.LastOutfitStack = {};
	end
	
	for vIndex, vOutfit in gOutfitter_Settings.LastOutfitStack do
		if vOutfit.Name then
			vOutfit = Outfitter_FindOutfitByName(vOutfit.Name);
		end
		
		if vOutfit then
			table.insert(gOutfitter_OutfitStack, vOutfit);
		end
	end
	
	gOutfitter_ExpectedOutfit = Outfitter_GetCompiledOutfit();
	
	Outfitter_UpdateTemporaryOutfit(Outfitter_GetNewItemsOutfit(gOutfitter_ExpectedOutfit));
	
	if gOutfitter_Settings.Options.ShowStackContents then
		OutfitterStack_DumpStackContents("Restore saved stack");
	end
end

function OutfitterStack_DumpStackContents(pOperation)
	Outfitter_DebugMessage("Outfitter Stack Contents: "..pOperation);
	
	for vIndex, vOutfit in gOutfitter_OutfitStack do
		if vOutfit.Name then
			Outfitter_DebugMessage("Slot "..vIndex..": "..vOutfit.Name);
		else
			Outfitter_DebugMessage("Slot "..vIndex..": Temporaray outfit");
		end
	end
end

function Outfitter_WearOutfit(pOutfit, pCategoryID, pWearBelowOutfit)
	if pOutfit.Disabled then
		return;
	end
	
	--
	
	Outfitter_BeginEquipmentUpdate();
	
	if pCategoryID == "Complete" then
		OutfitterStack_Clear();
	elseif pCategoryID == "Partial" then
		OutfitterStack_ClearCategory(pCategoryID);
		OutfitterStack_ClearCategory("Accessory");
	end
	
	OutfitterStack_AddOutfit(pOutfit, pWearBelowOutfit);
	
	-- If outfitter is open then also select the outfit
	
	if Outfitter_IsOpen() then
		if OutfitterStack_IsTopmostOutfit(pOutfit) then
			Outfitter_SelectOutfit(pOutfit, pCategoryID);
		else
			Outfitter_ClearSelection();
		end
	end
	
	-- Update the equipment
	
	gOutfitter_EquippedNeedsUpdate = true;
	gOutfitter_WeaponsNeedUpdate = true;
	
	Outfitter_EndEquipmentUpdate("Outfitter_WearOutfit");
end

function Outfitter_SetOutfitBindingIndex(pOutfit, pBindingIndex)
	for vCategoryID, vOutfits in gOutfitter_Settings.Outfits do
		for vOutfitIndex, vOutfit in vOutfits do
			if vOutfit.BindingIndex == pBindingIndex then
				vOutfit.BindingIndex = nil;
			end
		end
	end
	
	pOutfit.BindingIndex = pBindingIndex;
end

local	gOutfitter_LastBindingIndex = nil;
local	gOutfitter_LastBindingTime = nil;
local	Outfitter_cMinBindingTime = 0.75;

function Outfitter_WearBoundOutfit(pBindingIndex)
	-- Check for the user spamming the button so prevent the outfit from
	-- toggling if they're panicking
	
	local	vTime = GetTime();
	
	if gOutfitter_LastBindingIndex == pBindingIndex then
		local	vElapsed = vTime - gOutfitter_LastBindingTime;
		
		if vElapsed < Outfitter_cMinBindingTime then
			gOutfitter_LastBindingTime = vTime;
			return;
		end
	end
	
	--
	
	for vCategoryID, vOutfits in gOutfitter_Settings.Outfits do
		for vOutfitIndex, vOutfit in vOutfits do
			if vOutfit.BindingIndex == pBindingIndex then
				vOutfit.Disabled = nil;
				if vCategoryID == "Complete" then
					Outfitter_WearOutfit(vOutfit, vCategoryID);
					if not gOutfitter_Settings.Options.DisableHotkeyMessages then
						UIErrorsFrame:AddMessage(format(Outfitter_cEquipOutfitMessageFormat, vOutfit.Name), OUTFIT_MESSAGE_COLOR.r, OUTFIT_MESSAGE_COLOR.g, OUTFIT_MESSAGE_COLOR.b);
					end
				else
					local	vEquipped = Outfitter_ToggleOutfit(vOutfit, vCategoryID);
					
					if not gOutfitter_Settings.Options.DisableHotkeyMessages then
						if vEquipped then
							UIErrorsFrame:AddMessage(format(Outfitter_cEquipOutfitMessageFormat, vOutfit.Name), OUTFIT_MESSAGE_COLOR.r, OUTFIT_MESSAGE_COLOR.g, OUTFIT_MESSAGE_COLOR.b);
						else
							UIErrorsFrame:AddMessage(format(Outfitter_cUnequipOutfitMessageFormat, vOutfit.Name), OUTFIT_MESSAGE_COLOR.r, OUTFIT_MESSAGE_COLOR.g, OUTFIT_MESSAGE_COLOR.b);
						end
					end

				end
				
				-- Remember the binding used to filter for button spam
				
				gOutfitter_LastBindingIndex = pBindingIndex;
				gOutfitter_LastBindingTime = vTime;
				
				return;
			end
		end
	end
end

function Outfitter_FindOutfit(pOutfit)
	for vCategoryID, vOutfits in gOutfitter_Settings.Outfits do
		for vOutfitIndex, vOutfit in vOutfits do
			if vOutfit == pOutfit then
				return vCategoryID, vOutfitIndex;
			end
		end
	end
	
	return nil, nil;
end

function Outfitter_FindOutfitByName(pName)
	if not pName
	or pName == "" then
		return nil;
	end
	
	local	vLowerName = strlower(pName);
	
	for vCategoryID, vOutfits in gOutfitter_Settings.Outfits do
		for vOutfitIndex, vOutfit in vOutfits do
			if strlower(vOutfit.Name) == vLowerName then
				return vOutfit, vCategoryID, vOutfitIndex;
			end
		end
	end
	
	return nil, nil;
end

-- Outfitter doesn't use this function, but other addons such as
-- Fishing Buddy might use it to locate specific generated outfits

function Outfitter_FindOutfitByStatID(pStatID)
	if not pStatID or pStatID == "" then
		return nil;
	end

	for vCategoryID, vOutfits in gOutfitter_Settings.Outfits do
		for vOutfitIndex, vOutfit in vOutfits do
			if vOutfit.StatID and vOutfit.StatID == pStatID then
				return vOutfit, vCategoryID, vOutfitIndex;
			end
		end
	end
	
	return nil;
end

function Outfitter_RemoveOutfit(pOutfit)
	if not OutfitterStack_RemoveOutfit(pOutfit) then
		return;
	end
	
	-- Stop monitoring health and mana if it's the dining outfit
	
	if pOutfit.SpecialID == "Dining" then
		Outfitter_SuspendEvent(OutfitterFrame, "UNIT_HEALTH");
		Outfitter_SuspendEvent(OutfitterFrame, "UNIT_MANA");
	end
	
	--
	
	Outfitter_BeginEquipmentUpdate();
	
	-- Clear the selection if the outfit being removed
	-- is selected too
	
	if gOutfitter_SelectedOutfit == pOutfit then
		Outfitter_ClearSelection();
	end
	
	-- Update the list
	
	gOutfitter_EquippedNeedsUpdate = true;
	gOutfitter_WeaponsNeedUpdate = true;
	
	Outfitter_EndEquipmentUpdate("Outfitter_RemoveOutfit");
	
	Outfitter_DispatchOutfitEvent("UNWEAR_OUTFIT", pOutfit.Name, pOutfit);
end

function Outfitter_ToggleOutfit(pOutfit, pCategoryID)
	if Outfitter_WearingOutfit(pOutfit) then
		Outfitter_RemoveOutfit(pOutfit);
		return false;
	else
		Outfitter_WearOutfit(pOutfit, pCategoryID);
		return true;
	end
end

function Outfitter_OutfitSummary()
	local	_, vPlayerClass = UnitClass("player");
	local	vStatDistribution = gOutfitter_StatDistribution[vPlayerClass];
	local	vCurrentOutfitStats = OutfitterTankPoints_GetCurrentOutfitStats(vStatDistribution);
	
	Outfitter_DumpArray("Current Stats", vCurrentOutfitStats);
end

function Outfitter_GetCompiledOutfit()
	local	vCompiledOutfit = Outfitter_NewEmptyOutfit();
	
	vCompiledOutfit.SourceOutfit = {};
	
	for vStackIndex, vOutfit in gOutfitter_OutfitStack do
		for vInventorySlot, vOutfitItem in vOutfit.Items do
			vCompiledOutfit.Items[vInventorySlot] = vOutfitItem;
			vCompiledOutfit.SourceOutfit[vInventorySlot] = vOutfit.Name;
		end
	end
	
	return vCompiledOutfit;
end

function Outfitter_GetExpectedOutfit(pExcludeOutfit)
	local	vCompiledOutfit = Outfitter_NewEmptyOutfit();
	
	vCompiledOutfit.SourceOutfit = {};
	
	for vStackIndex, vOutfit in gOutfitter_OutfitStack do
		if vOutfit ~= pExcludeOutfit then
			for vInventorySlot, vOutfitItem in vOutfit.Items do
				vCompiledOutfit.Items[vInventorySlot] = vOutfitItem;
				vCompiledOutfit.SourceOutfit[vInventorySlot] = vOutfit.Name;
			end
		end
	end
	
	return vCompiledOutfit;
end

function Outfitter_GetEmptyBagSlot(pStartBagIndex, pStartBagSlotIndex, pIncludeBank)
	local	vStartBagIndex = pStartBagIndex;
	local	vStartBagSlotIndex = pStartBagSlotIndex;
	
	if not vStartBagIndex then
		vStartBagIndex = NUM_BAG_SLOTS;
	end
	
	if not vStartBagSlotIndex then
		vStartBagSlotIndex = 1;
	end
	
	local	vEndBagIndex = 0;
	
	if pIncludeBank then
		vEndBagIndex = -1;
	end
	
	for vBagIndex = vStartBagIndex, vEndBagIndex, -1 do
		-- Skip the bag if it's a specialty bag (ammo pouch, quiver, shard bag)
		
		local	vSkipBag = false;
		
		if vBagIndex > 0 then -- Don't worry about the backpack
			local	vItemLink = GetInventoryItemLink("player", ContainerIDToInventoryID(vBagIndex));
			local	vItemInfo = Outfitter_GetItemInfoFromLink(vItemLink);
			
			if vItemInfo
			and Outfitter_cSpecialtyBags[vItemInfo.Code] ~= nil then
				vSkipBag = true;
			end
		end
		
		-- Search the bag for empty slots
		
		if not vSkipBag then
			local	vNumBagSlots = GetContainerNumSlots(vBagIndex);
			
			if vNumBagSlots > 0 then
				for vSlotIndex = vStartBagSlotIndex, vNumBagSlots do
					local	vItemInfo = Outfitter_GetBagItemInfo(vBagIndex, vSlotIndex);
					
					if not vItemInfo then
						return {BagIndex = vBagIndex, BagSlotIndex = vSlotIndex};
					end
				end
			end
		end
		
		vStartBagSlotIndex = 1;
	end
	
	return nil;
end

function Outfitter_GetEmptyBagSlotList()
	local	vEmptyBagSlots = {};
	
	local	vBagIndex = NUM_BAG_SLOTS;
	local	vBagSlotIndex = 1;
	
	while true do
		local	vBagSlotInfo = Outfitter_GetEmptyBagSlot(vBagIndex, vBagSlotIndex);
		
		if not vBagSlotInfo then
			return vEmptyBagSlots;
		end
		
		table.insert(vEmptyBagSlots, vBagSlotInfo);
		
		vBagIndex = vBagSlotInfo.BagIndex;
		vBagSlotIndex = vBagSlotInfo.BagSlotIndex + 1;
	end
end

function Outfitter_GetEmptyBankSlotList()
	local	vEmptyBagSlots = {};
	
	local	vBagIndex = NUM_BAG_SLOTS + NUM_BANKBAGSLOTS;
	local	vBagSlotIndex = 1;
	
	while true do
		local	vBagSlotInfo = Outfitter_GetEmptyBagSlot(vBagIndex, vBagSlotIndex, true);
		
		if not vBagSlotInfo then
			return vEmptyBagSlots;
		
		elseif vBagSlotInfo.BagIndex > NUM_BAG_SLOTS
		or vBagSlotInfo.BagIndex < 0 then
			table.insert(vEmptyBagSlots, vBagSlotInfo);
		end
		
		vBagIndex = vBagSlotInfo.BagIndex;
		vBagSlotIndex = vBagSlotInfo.BagSlotIndex + 1;
	end
end

function Outfitter_FindItemsInBagsForSlot(pSlotName)
	local	vInventorySlot = pSlotName;
	
	-- Alias the slot names down for finger and trinket
	
	if vInventorySlot == "Finger1Slot" then
		vInventorySlot = "Finger0Slot";
	elseif vInventorySlot == "Trinket1Slot" then
		vInventorySlot = "Trinket0Slot";
	end
	
	--
	
	local	vItems = {};
	local	vNumBags, vFirstBagIndex = Outfitter_GetNumBags();
	
	for vBagIndex = vFirstBagIndex, vNumBags do
		local	vNumBagSlots = GetContainerNumSlots(vBagIndex);
		
		if vNumBagSlots > 0 then
			for vSlotIndex = 1, vNumBagSlots do
				local	vItemInfo = Outfitter_GetBagItemInfo(vBagIndex, vSlotIndex);
				
				if vItemInfo then
					local	vItemSlotName = vItemInfo.ItemSlotName;
					
					if vItemInfo.MetaSlotName then
						vItemSlotName = vItemInfo.MetaSlotName;
					end
					
					if vItemSlotName == "TwoHandSlot" then
						vItemSlotName = "MainHandSlot";
					elseif vItemSlotName == "Weapon0Slot" then
						if vInventorySlot == "MainHandSlot"
						or vInventorySlot == "SecondaryHandSlot" then
							vItemSlotName = vInventorySlot;
						end
					end
					
					if vItemSlotName == vInventorySlot then
						table.insert(vItems, {BagIndex = vBagIndex, BagSlotIndex = vSlotIndex, Code = vItemInfo.Code, Name = vItemInfo.Name});
					end
				end
			end
		end
	end
	
	if table.getn(vItems) == 0 then	
		return nil;
	end
	
	return vItems;
end

function Outfitter_PickupItemLocation(pItemLocation)
	if pItemLocation == nil then
		Outfitter_ErrorMessage("Outfitter: nil location in PickupItemLocation");
		return;
	end
	
	if pItemLocation.BagIndex then
		PickupContainerItem(pItemLocation.BagIndex, pItemLocation.BagSlotIndex);
	elseif pItemLocation.SlotName then
		local	vSlotID, vEmptySlotTexture = GetInventorySlotInfo(pItemLocation.SlotName);
		
		PickupInventoryItem(vSlotID);
	else
		Outfitter_ErrorMessage("Outfitter: Unknown location in PickupItemLocation");
		return;
	end
end

function Outfitter_BuildUnequipChangeList(pOutfit, pEquippableItems)
	local	vEquipmentChangeList = {};

	for vInventorySlot, vOutfitItem in pOutfit.Items do
		local	vItem, vIgnoredItem = OutfitterItemList_FindItemOrAlt(pEquippableItems, vOutfitItem, true);
		
		if vItem then
			table.insert(vEquipmentChangeList, {FromLocation = vItem.Location, Item = vItem, ToLocation = nil});
		end
	end -- for
	
	return vEquipmentChangeList;
end

function Outfitter_BuildEquipmentChangeList(pOutfit, pEquippableItems)
	local	vEquipmentChangeList = {};
	
	OutfitterItemList_ResetIgnoreItemFlags(pEquippableItems);
	
	-- Remove items which are already in the correct slot from the outfit and from the
	-- equippable items list
	
	for vInventorySlot, vOutfitItem in pOutfit.Items do
		local	vContainsItem, vItem = OutfitterItemList_InventorySlotContainsItem(pEquippableItems, vInventorySlot, vOutfitItem);
		
		if vContainsItem then
			pOutfit.Items[vInventorySlot] = nil;
			
			if vItem then
				vItem.IgnoreItem = true;
			end
		end
	end
	
	-- Scan the outfit using the Outfitter_cSlotNames array as an index so that changes
	-- are executed in the specified order
	
	for _, vInventorySlot in Outfitter_cSlotNames do
		local	vOutfitItem = pOutfit.Items[vInventorySlot];
		
		if vOutfitItem then
			local	vSlotID, vEmptySlotTexture = GetInventorySlotInfo(vInventorySlot);
			local	vCurrentItemInfo = Outfitter_GetInventoryItemInfo(vInventorySlot);
			
			-- Empty the slot if it's supposed to be blank
			
			if vOutfitItem.Code == 0 then
				if vCurrentItemInfo then
					table.insert(vEquipmentChangeList, {SlotName = vInventorySlot, SlotID = vSlotID, ItemName = vOutfitItem.Name, ItemLocation = nil});
				end

			else
				-- Find the item
				
				local	vItem, vIgnoredItem = OutfitterItemList_FindItemOrAlt(pEquippableItems, vOutfitItem, true);
				
				-- If the item wasn't found then show an appropriate error message
				
				if not vItem then
					if vOutfitItem.Name then
						if vIgnoredItem then
							local	vSlotDisplayName = Outfitter_cSlotDisplayNames[vInventorySlot];
							
							if not vSlotDisplayName then
								vSlotDisplayName = vInventorySlot;
							end
							
							Outfitter_ErrorMessage(format(Outfitter_cItemAlreadyUsedError, vOutfitItem.Name, vSlotDisplayName));
						else
							Outfitter_ErrorMessage(format(Outfitter_cItemNotFoundError, vOutfitItem.Name));
						end
					else
						Outfitter_ErrorMessage(format(Outfitter_cItemNotFoundError, "unknown"));
					end
				
				-- Generate a change to move the item from its present location to the correct slot
				
				else
					pOutfit.Items[vInventorySlot].MetaSlotName = vItem.MetaSlotName;
					table.insert(vEquipmentChangeList, {SlotName = vInventorySlot, SlotID = vSlotID, ItemName = vOutfitItem.Name, ItemMetaSlotName = vItem.MetaSlotName, ItemLocation = vItem});
				end
			end
		end -- if
	end -- for
	
	if table.getn(vEquipmentChangeList) == 0 then
		return nil;
	end
	
	Outfitter_OptimizeEquipmentChangeList(vEquipmentChangeList);
	
	return vEquipmentChangeList;
end

function Outfitter_FindEquipmentChangeForSlot(pEquipmentChangeList, pSlotName)
	for vChangeIndex, vEquipmentChange in pEquipmentChangeList do
		if vEquipmentChange.SlotName == pSlotName then
			return vChangeIndex, vEquipmentChange;
		end
	end
	
	return nil, nil;
end

function Outfitter_FixSlotSwapChange(pEquipmentList, pChangeIndex1, pEquipmentChange1, pSlotName1, pChangeIndex2, pEquipmentChange2, pSlotName2)
	-- No problem if both slots will be emptied
	
	if not pEquipmentChange1.ItemLocation
	and not pEquipmentChange2.ItemLocation then
		return;
	end
	
	-- No problem if neither slot is being moved to the other one
	
	local	vSlot2ToSlot1 = pEquipmentChange1.ItemLocation ~= nil
			            and pEquipmentChange1.ItemLocation.SlotName == pSlotName2;
	
	local	vSlot1ToSlot2 = pEquipmentChange2.ItemLocation ~= nil
			            and pEquipmentChange2.ItemLocation.SlotName == pSlotName1;
	
	-- No problem if the slots are swapping with each other
	-- or not moving between each other at all
	
	if vSlot2ToSlot1 == vSlot1ToSlot2 then
		return;
	end
	
	-- Slot 1 is moving to slot 2
	
	if vSlot1ToSlot2 then
		
		if pEquipmentChange1.ItemLocation then
			-- Swap change 1 and change 2 around
			
			pEquipmentList[pChangeIndex1] = pEquipmentChange2;
			pEquipmentList[pChangeIndex2] = pEquipmentChange1;
			
			-- Insert a change to empty slot 2
			
			table.insert(pEquipmentList, pChangeIndex1, {SlotName = pEquipmentChange2.SlotName, SlotID = pEquipmentChange2.SlotID, ItemLocation = nil});
		else
			-- Slot 1 is going to be empty, so empty slot 2 instead
			-- and then when slot 1 is moved it'll swap the empty space
			
			pEquipmentChange1.SlotName = pSlotName2;
			pEquipmentChange1.SlotID = pEquipmentChange2.SlotID;
			pEquipmentChange1.ItemLocation = nil;
		end
		
	-- Slot 2 is moving to slot 1
	
	else
		if pEquipmentChange2.ItemLocation then
			-- Insert a change to empty slot 1 first
			
			table.insert(pEquipmentList, pChangeIndex1, {SlotName = pEquipmentChange1.SlotName, SlotID = pEquipmentChange1.SlotID, ItemLocation = nil});
		else
			-- Slot 2 is going to be empty, so empty slot 1 instead
			-- and then when slot 2 is moved it'll swap the empty space
			
			pEquipmentChange2.SlotName = pSlotName1;
			pEquipmentChange2.SlotID = pEquipmentChange1.SlotID;
			pEquipmentChange2.ItemLocation = nil;
			
			-- Change the order so that slot 1 gets emptied before the move
			
			pEquipmentList[pChangeIndex1] = pEquipmentChange2;
			pEquipmentList[pChangeIndex2] = pEquipmentChange1;
		end
	end
end

function Outfitter_OptimizeEquipmentChangeList(pEquipmentChangeList)
	local	vSwapList =
	{
		{Slot1 = "Finger0Slot", Slot2 = "Finger1Slot"},
		{Slot1 = "Trinket0Slot", Slot2 = "Trinket1Slot"},
		{Slot1 = "MainHandSlot", Slot2 = "SecondaryHandSlot"},
	};
	
	local	vDidSlot = {};
	
	local	vChangeIndex = 1;
	local	vNumChanges = table.getn(pEquipmentChangeList);
	
	while vChangeIndex <= vNumChanges do
		local	vEquipmentChange = pEquipmentChangeList[vChangeIndex];
		
		-- If a two-hand weapon is being equipped, remove the change event
		-- for removing the offhand slot
		
		if vEquipmentChange.ItemMetaSlotName == "TwoHandSlot" then
			local	vChangeIndex2, vEquipmentChange2 = Outfitter_FindEquipmentChangeForSlot(pEquipmentChangeList, "SecondaryHandSlot");
			
			-- If there's a change for the offhand slot, remove it
			
			if vChangeIndex2 then
				table.remove(pEquipmentChangeList, vChangeIndex2);
				
				if vChangeIndex2 < vChangeIndex then
					vChangeIndex = vChangeIndex - 1;
				end
				
				vNumChanges = vNumChanges - 1;
			end
			
			-- Insert a new change for the offhand slot to empty it ahead
			-- of equipping the two-hand item
			
			local	vSlotID, vEmptySlotTexture = GetInventorySlotInfo("SecondaryHandSlot");
			
			table.insert(pEquipmentChangeList, vChangeIndex, {SlotName = "SecondaryHandSlot", SlotID = vSlotID, ItemLocation = nil});
			
		-- Otherwise see if the change needs to be re-arranged so that slot
		-- swapping works correctly
		
		else
			for vSwapListIndex, vSwapSlotInfo in vSwapList do
				if vEquipmentChange.SlotName == vSwapSlotInfo.Slot1
				and not vDidSlot[vEquipmentChange.SlotName] then
					local	vChangeIndex2, vEquipmentChange2 = Outfitter_FindEquipmentChangeForSlot(pEquipmentChangeList, vSwapSlotInfo.Slot2);
					
					if vChangeIndex2 then
						Outfitter_FixSlotSwapChange(pEquipmentChangeList, vChangeIndex, vEquipmentChange, vSwapSlotInfo.Slot1, vChangeIndex2, vEquipmentChange2, vSwapSlotInfo.Slot2);
					end
					
					vDidSlot[vEquipmentChange.SlotName] = true;
					
					vNumChanges = table.getn(pEquipmentChangeList);
				end
			end
		end
		
		vChangeIndex = vChangeIndex + 1;
	end
end

function Outfitter_ExecuteEquipmentChangeList(pEquipmentChangeList, pEmptyBagSlots, pExpectedEquippableItems)
	for vChangeIndex, vEquipmentChange in pEquipmentChangeList do
		if vEquipmentChange.ItemLocation then
			Outfitter_PickupItemLocation(vEquipmentChange.ItemLocation);
			EquipCursorItem(vEquipmentChange.SlotID);
			
			if pExpectedEquippableItems then
				OutfitterItemList_SwapLocationWithInventorySlot(pExpectedEquippableItems, vEquipmentChange.ItemLocation, vEquipmentChange.SlotName);
			end
		else
			-- Remove the item
			
			if not pEmptyBagSlots
			or table.getn(pEmptyBagSlots) == 0 then
				local	vItemInfo = Outfitter_GetInventoryItemInfo(vEquipmentChange.SlotName);
				
				if not vItemInfo then
					Outfitter_ErrorMessage("Outfitter internal error: Can't empty slot "..vEquipmentChange.SlotName.." because bags are full but slot is empty");
				else
					Outfitter_ErrorMessage(format(Outfitter_cBagsFullError, vItemInfo.Name));
				end
			else
				local	vBagIndex = pEmptyBagSlots[1].BagIndex;
				local	vBagSlotIndex = pEmptyBagSlots[1].BagSlotIndex;
				
				table.remove(pEmptyBagSlots, 1);
				
				PickupInventoryItem(vEquipmentChange.SlotID);
				PickupContainerItem(vBagIndex, vBagSlotIndex);
				
				if pExpectedEquippableItems then
					OutfitterItemList_SwapBagSlotWithInventorySlot(pExpectedEquippableItems, vBagIndex, vBagSlotIndex, vEquipmentChange.SlotName);
				end
			end
		end
	end
end

function Outfitter_ExecuteEquipmentChangeList2(pEquipmentChangeList, pEmptySlots, pBagsFullErrorFormat, pExpectedEquippableItems)
	for vChangeIndex, vEquipmentChange in pEquipmentChangeList do
		if vEquipmentChange.ToLocation then
			Outfitter_PickupItemLocation(vEquipmentChange.FromLocation);
			EquipCursorItem(vEquipmentChange.SlotID);
			
			if pExpectedEquippableItems then
				OutfitterItemList_SwapLocationWithInventorySlot(pExpectedEquippableItems, vEquipmentChange.ToLocation, vEquipmentChange.SlotName);
			end
		else
			-- Remove the item
			
			if not pEmptySlots
			or table.getn(pEmptySlots) == 0 then
				Outfitter_ErrorMessage(format(pBagsFullErrorFormat, vEquipmentChange.Item.Name));
			else
				local	vToLocation = {BagIndex = pEmptySlots[1].BagIndex, BagSlotIndex = pEmptySlots[1].BagSlotIndex};
				
				table.remove(pEmptySlots, 1);
				
				Outfitter_PickupItemLocation(vEquipmentChange.FromLocation);
				Outfitter_PickupItemLocation(vToLocation);
				
				if pExpectedEquippableItems then
					OutfitterItemList_SwapLocations(pExpectedEquippableItems, vEquipmentChange.FromLocation, vToLocation);
				end
			end
		end
	end
end

function Outfitter_OutfitHasCombatEquipmentSlots(pOutfit)
	for vEquipmentSlot, _ in Outfitter_cCombatEquipmentSlots do
		if pOutfit.Items[vEquipmentSlot] then
			return true;
		end
	end
	
	return false;
end

function Outfitter_OutfitOnlyHasCombatEquipmentSlots(pOutfit)
	for vEquipmentSlot, _ in pOutfit.Items do
		if not Outfitter_cCombatEquipmentSlots[vEquipmentSlot] then
			return false;
		end
	end
	
	return true;
end

local	gOutfitter_EquipmentUpdateCount = 0;

function Outfitter_BeginEquipmentUpdate()
	gOutfitter_EquipmentUpdateCount = gOutfitter_EquipmentUpdateCount + 1;
end

function Outfitter_EndEquipmentUpdate(pCallerName)
	gOutfitter_EquipmentUpdateCount = gOutfitter_EquipmentUpdateCount - 1;
	
	if gOutfitter_EquipmentUpdateCount == 0 then
		Outfitter_UpdateEquippedItems();
		Outfitter_Update(false);
	end
end

function Outfitter_UpdateEquippedItems()
	if not gOutfitter_EquippedNeedsUpdate
	and not gOutfitter_WeaponsNeedUpdate then
		return;
	end
	
	-- Delay all changes until they're alive
	
	if gOutfitter_IsDead then
--	or gOutfitter_IsFeigning then -- no longer disabling outfit changes during FD
		return;
	end
	
	local	vCurrentTime = GetTime();
	
	if vCurrentTime - gOutfitter_LastEquipmentUpdateTime < Outfitter_cMinEquipmentUpdateInterval then
		OutfitterTimer_AdjustTimer();
		return;
	end
	
	gOutfitter_LastEquipmentUpdateTime = vCurrentTime;
	
	local	vWeaponsNeedUpdate = gOutfitter_WeaponsNeedUpdate;
	
	gOutfitter_EquippedNeedsUpdate = false;
	gOutfitter_WeaponsNeedUpdate = false;
	
	-- Compile the outfit
	
	local	vEquippableItems = OutfitterItemList_GetEquippableItems();
	local	vCompiledOutfit = Outfitter_GetCompiledOutfit();
	
	-- If the outfit contains non-weapon changes then
	-- delay the change until they're out of combat but go
	-- ahead and swap the weapon slots if there are any
	
	if gOutfitter_InCombat then
		if vWeaponsNeedUpdate
		and Outfitter_OutfitHasCombatEquipmentSlots(vCompiledOutfit) then
			
			-- Allow the weapon change to proceed but defer the rest
			-- until they're out of combat
			
			local	vWeaponOutfit = Outfitter_NewEmptyOutfit();
			
			for vEquipmentSlot, _ in Outfitter_cCombatEquipmentSlots do
				vWeaponOutfit.Items[vEquipmentSlot] = vCompiledOutfit.Items[vEquipmentSlot];
			end
			
			-- Still need to update the rest once they exit combat
			-- if there are non-equipment slot items
			
			if not Outfitter_OutfitOnlyHasCombatEquipmentSlots(vCompiledOutfit) then
				gOutfitter_EquippedNeedsUpdate = true;
			end
			
			-- Switch to the weapons-only part
			
			vCompiledOutfit = vWeaponOutfit;
		else
			-- No weapon changes, just defer the whole outfit change
			
			gOutfitter_EquippedNeedsUpdate = true;
			return;
		end
	end
	
	-- Equip it
	
	local	vEquipmentChangeList = Outfitter_BuildEquipmentChangeList(vCompiledOutfit, vEquippableItems);
	
	if vEquipmentChangeList then
		-- local	vExpectedEquippableItems = OutfitterItemList_New();
	
		Outfitter_ExecuteEquipmentChangeList(vEquipmentChangeList, Outfitter_GetEmptyBagSlotList(), vExpectedEquippableItems);
		
		-- Outfitter_DumpArray("ExpectedEquippableItems", vExpectedEquippableItems);
	end
	
	-- Update the outfit we're expecting to see on the player
	
	for vInventorySlot, vItem in vCompiledOutfit.Items do
		gOutfitter_ExpectedOutfit.Items[vInventorySlot] = vCompiledOutfit.Items[vInventorySlot];
	end
end

function Outfitter_InitDebugging()
	if gOutfitter_InitializedDebug then
		return;
	end
	
	gOutfitter_InitializedDebug = true;
	
	-- Find the debug frame if there is one
	
	for vChatIndex = 1, NUM_CHAT_WINDOWS do
		local	vChatFrame = getglobal("ChatFrame"..vChatIndex);
		
		if vChatFrame
		and (vChatFrame:IsVisible() or vChatFrame.isDocked) then
			local	vTab = getglobal("ChatFrame"..vChatIndex.."Tab");
			local	vName = vTab:GetText();
			
			if vName == "Debug" then
				gOutfitter_DebugFrame = vChatFrame;
				if gOutfitter_DebugFrame:GetMaxLines() < 1000 then
					gOutfitter_DebugFrame:SetMaxLines(1000);
				end
				_ERRORMESSAGE = function(message) Outfitter_DebugMessage(message); end;
			end
		end
	end
	
	if gOutfitter_DebugFrame then
		Outfitter_DebugMessage("Found debugging chat frame");
	end
end

function Outfitter_DebugMessage(pMessage)
	if gOutfitter_DebugFrame then
		gOutfitter_DebugFrame:AddMessage("DEBUG: "..pMessage, 0.7, 0.3, 1.0);
		
		local vTabFlash = getglobal(gOutfitter_DebugFrame:GetName().."TabFlash");
		
		vTabFlash:Show();
		UIFrameFlash(vTabFlash, 0.25, 0.25, 60, nil, 0.5, 0.5);
	else
		DEFAULT_CHAT_FRAME:AddMessage("DEBUG: "..pMessage, 0.7, 0.3, 1.0);
	end
end

function Outfitter_ErrorMessage(pMessage)
	DEFAULT_CHAT_FRAME:AddMessage(pMessage, 0.8, 0.3, 0.5);
end

function Outfitter_TestMessage(pMessage)
	if gOutfitter_DebugFrame then
		gOutfitter_DebugFrame:AddMessage("TEST: "..pMessage, 0.7, 0.3, 1.0);
	else
		DEFAULT_CHAT_FRAME:AddMessage("TEST: "..pMessage, 0.7, 0.3, 1.0);
	end
end

function Outfitter_NoteMessage(pMessage)
	DEFAULT_CHAT_FRAME:AddMessage(pMessage, 0.6, 1.0, 0.3);
end

function Outfitter_RenameLink(pLink, pName)
	local	vMessage = string.gsub(pLink, "%[.*%]", "["..pName.."]");
	-- local	vMessage = string.gsub(pMessage, "||", "|");
	
	DEFAULT_CHAT_FRAME:AddMessage(vMessage);
end

function Outfitter_DumpArray(pPrefixString, pArray)
	if not pArray then
		Outfitter_DebugMessage(pPrefixString.." is nil");
		return;
	end
	
	local	vFoundElement = false;
	
	for vIndex, vElement in pArray do
		vFoundElement = true;
		
		local	vType = type(vElement);
		local	vPrefix;
		
		if type(vIndex) == "number" then
			vPrefix = pPrefixString.."["..vIndex.."]";
		else
			vPrefix = pPrefixString.."."..vIndex;
		end
		
		if vType == "number" then
			Outfitter_DebugMessage(vPrefix.." = "..vElement);
		elseif vType == "string" then
			Outfitter_DebugMessage(vPrefix.." = \""..vElement.."\"");
		elseif vType == "boolean" then
			if vElement then
				Outfitter_DebugMessage(vPrefix.." = true");
			else
				Outfitter_DebugMessage(vPrefix.." = false");
			end
		elseif vType == "table" then
			Outfitter_DumpArray(vPrefix, vElement);
		else
			Outfitter_DebugMessage(vPrefix.." "..vType);
		end
	end
	
	if not vFoundElement then
		Outfitter_DebugMessage(pPrefixString.." is empty");
	end
end

function Outfitter_InventorySlotIsEmpty(pInventorySlot)
	return Outfitter_GetInventoryItemInfo(pInventorySlot) == nil;
end

function Outfitter_GetBagItemInfo(pBagIndex, pSlotIndex)
	local	vItemLink = GetContainerItemLink(pBagIndex, pSlotIndex);
	local	vItemInfo = Outfitter_GetItemInfoFromLink(vItemLink);
	
	if not vItemInfo then
		return nil;
	end
	
	vItemInfo.Texture, _, _, vItemInfo.Quality, _ = GetContainerItemInfo(pBagIndex, pSlotIndex);
	
	return vItemInfo;
end

local	gOutfitter_AmmoSlotInfoCache = nil;

function Outfitter_FindAmmoSlotItem(pName, pTexture)
	if gOutfitter_AmmoSlotInfoCache
	and gOutfitter_AmmoSlotInfoCache.Name == pName
	and gOutfitter_AmmoSlotInfoCache.Texture == pTexture then
		return gOutfitter_AmmoSlotInfoCache.ItemInfo;
	end
		
	for vBagIndex = 0, NUM_BAG_SLOTS do
		local	vNumBagSlots = GetContainerNumSlots(vBagIndex);
		
		if vNumBagSlots > 0 then
			for vBagSlotIndex = 1, vNumBagSlots do
				local	vTexture = GetContainerItemInfo(vBagIndex, vBagSlotIndex);
				
				if vTexture == pTexture then
					local	vItemInfo = Outfitter_GetBagItemInfo(vBagIndex, vBagSlotIndex);
					
					if vItemInfo.Name == pName then
						if not gOutfitter_AmmoSlotInfoCache then
							gOutfitter_AmmoSlotInfoCache = {};
						end
						
						gOutfitter_AmmoSlotInfoCache.Name = pName;
						gOutfitter_AmmoSlotInfoCache.Texture = pTexture;
						gOutfitter_AmmoSlotInfoCache.ItemInfo = vItemInfo;
						
						return vItemInfo;
					end
				end
			end -- for vBagSlotIndex
		end -- if vNumBagSlots
	end -- for vBagIndex
	
	return nil;
end

function Outfitter_GetInventoryItemInfo(pInventorySlot)
	local	vSlotID = GetInventorySlotInfo(pInventorySlot);
	local	vItemLink = GetInventoryItemLink("player", vSlotID);
	
	-- GetInventoryItemLink doesn't work for the ammo slot, so instead get the icon
	-- for the slot and then search for a matching icon in the bags
	
	if vItemLink == nil
	and pInventorySlot == "AmmoSlot" then
		OutfitterTooltip:SetOwner(OutfitterFrame, "ANCHOR_BOTTOMRIGHT", 0, 0);
		OutfitterTooltip:SetInventoryItem("player", vSlotID);
		
		if not OutfitterTooltipTextLeft1:IsShown() then
			OutfitterTooltip:Hide();
			return nil;
		end
		
		local	vAmmoItemName = OutfitterTooltipTextLeft1:GetText();
		
		OutfitterTooltip:Hide();
		
		local	vAmmoItemTexture = GetInventoryItemTexture("player", vSlotID);
		
		return Outfitter_FindAmmoSlotItem(vAmmoItemName, vAmmoItemTexture);
	end
	
	local	vItemInfo = Outfitter_GetItemInfoFromLink(vItemLink);
	
	if not vItemInfo then
		return nil;
	end
	
	vItemInfo.Quality = GetInventoryItemQuality("player", vSlotID);
	vItemInfo.Texture = GetInventoryItemTexture("player", vSlotID);
	
	return vItemInfo;
end

function Outfitter_GetItemInfoFromLink(pItemLink)
	if not pItemLink then
		return nil;
	end
	-- |cff1eff00|Hitem:1465:803:0:0|h[Tigerbane]|h|r
	-- |cff1eff00|Hitem:1465:803:0:0|h[Tigerbane]|h|r
	-- |(hex code for item color)|Hitem:(item ID code):(enchant code):(added stats code):0|h[(item name)]|h|r
	
	local	vStartIndex, vEndIndex, vLinkColor, vItemCode, vItemEnchantCode, vItemSubCode, vUnknownCode, vItemName = strfind(pItemLink, "|(%x+)|Hitem:(%d+):(%d+):(%d+):(%d+)|h%[([^%]]+)%]|h|r");
	
	if not vStartIndex then
		return nil;
	end
	
	vItemCode = tonumber(vItemCode);
	vItemSubCode = tonumber(vItemSubCode);
	vItemEnchantCode = tonumber(vItemEnchantCode);
	
	local	vItemFamilyName,
			vItemLink,
			vItemQuality,
			vItemLevel,
			vItemType,
			vItemSubType,
			vItemCount,
			vItemInvType = GetItemInfo(vItemCode);
	
	local	vItemInfo =
	{
		Code = vItemCode,
		SubCode = vItemSubCode,
		Name = vItemName,
		EnchantCode = vItemEnchantCode,
		Level = vItemLevel,
	};
	
	-- Just return if there's no inventory type
	
	if not vItemInvType
	or vItemInvType == "" then
		return vItemInfo;
	end
	
	-- Just return if we don't know anything about the inventory type
	
	local	vInvTypeInfo = Outfitter_cInvTypeToSlotName[vItemInvType];
	
	if not vInvTypeInfo then
		Outfitter_ErrorMessage("Outfitter error: Unknown slot type "..vItemInvType.." for item "..vItemName);
		return vItemInfo;
	end
	
	-- Get the slot name
	
	if not vInvTypeInfo.SlotName then
		Outfitter_ErrorMessage("Unknown slot name for inventory type "..vItemInvType);
		return vItemInfo;
	end
	
	vItemInfo.ItemSlotName = vInvTypeInfo.SlotName;
	vItemInfo.MetaSlotName = vInvTypeInfo.MetaSlotName;
	
	-- Return the info
	
	return vItemInfo;
end

function Outfitter_CreateNewOutfit()
	OutfitterNameOutfit_Open(nil);
end

function Outfitter_NewEmptyOutfit(pName)
	return {Name = pName, Items = {}};
end

function Outfitter_IsEmptyOutfit(pOutfit)
	return Outfitter_ArrayIsEmpty(pOutfit.Items);
end

function Outfitter_NewNakedOutfit(pName)
	local	vOutfit = Outfitter_NewEmptyOutfit(pName);
	
	for _, vInventorySlot in Outfitter_cSlotNames do
		Outfitter_AddOutfitItem(vOutfit, vInventorySlot, 0, 0, "", 0);
	end
	
	return vOutfit;
end

function Outfitter_AddOutfitItem(pOutfit, pSlotName, pItemCode, pItemSubCode, pItemName, pItemEnchantCode)
	pOutfit.Items[pSlotName] = {Code = pItemCode, SubCode = pItemSubCode, Name = pItemName, EnchantCode = pItemEnchantCode};
end

function Outfitter_AddOutfitStatItem(pOutfit, pSlotName, pItemCode, pItemSubCode, pItemName, pItemEnchantCode, pStatID, pStatValue)
	if not pSlotName then
		Outfitter_ErrorMessage("AddOutfitStatItem: SlotName is nil for "..pItemName);
		return;
	end
	
	if not pStatID then
		Outfitter_ErrorMessage("AddOutfitStatItem: StatID is nil for "..pItemName);
		return;
	end
	
	Outfitter_AddOutfitItem(pOutfit, pSlotName, pItemCode, pItemSubCode, pItemName, pItemEnchantCode);
	pOutfit.Items[pSlotName][pStatID] = pStatValue;
end

function Outfitter_AddOutfitStatItemIfBetter(pOutfit, pSlotName, pItemCode, pItemSubCode, pItemName, pItemEnchantCode, pStatID, pStatValue)
	local	vCurrentItem = pOutfit.Items[pSlotName];
	local	vAlternateSlotName = Outfitter_cHalfAlternateStatSlot[pSlotName];
	
	if not vCurrentItem
	or not vCurrentItem[pStatID]
	or vCurrentItem[pStatID] < pStatValue then
		-- If we're bumping the current item, see if it should be moved to the alternate slot
		
		if vCurrentItem
		and vCurrentItem[pStatID]
		and vAlternateSlotName then
			Outfitter_AddOutfitStatItemIfBetter(pOutfit, vAlternateSlotName, vCurrentItem.Code, vCurrentItem.SubCode, vCurrentItem.Name, vCurrentItem.EnchantCode, pStatID, vCurrentItem[pStatID])
		end
		
		Outfitter_AddOutfitStatItem(pOutfit, pSlotName, pItemCode, pItemSubCode, pItemName, pItemEnchantCode, pStatID, pStatValue);
	else
		if not vAlternateSlotName then
			return;
		end
		
		return Outfitter_AddOutfitStatItemIfBetter(pOutfit, vAlternateSlotName, pItemCode, pItemSubCode, pItemName, pItemEnchantCode, pStatID, pStatValue);
	end
end

function Outfitter_AddStats(pItem1, pItem2, pStatID)
	local	vStat = 0;
	
	if pItem1
	and pItem1[pStatID] then
		vStat = pItem1[pStatID];
	end
	
	if pItem2
	and pItem2[pStatID] then
		vStat = vStat + pItem2[pStatID];
	end
	
	return vStat;
end

function Outfitter_CollapseMetaSlotsIfBetter(pOutfit, pStatID)
	-- Compare the weapon slot with the 1H/OH slots
	
	local	vWeapon0Item = pOutfit.Items.Weapon0Slot;
	local	vWeapon1Item = pOutfit.Items.Weapon1Slot;
	
	if vWeapon0Item or vWeapon1Item then
		-- Try the various combinations of MH/OH/W0/W1
		
		local	v1HItem = pOutfit.Items.MainHandSlot;
		local	vOHItem = pOutfit.Items.SecondaryHandSlot;
		
		local	vCombinations =
		{
			{MainHand = v1HItem, SecondaryHand = vOHItem, AllowEmptyMainHand = true},
			{MainHand = v1HItem, SecondaryHand = vWeapon0Item, AllowEmptyMainHand = false},
			{MainHand = v1HItem, SecondaryHand = vWeapon1Item, AllowEmptyMainHand = false},
			{MainHand = vWeapon0Item, SecondaryHand = vOHItem, AllowEmptyMainHand = true},
			{MainHand = vWeapon1Item, SecondaryHand = vOHItem, AllowEmptyMainHand = true},
			{MainHand = vWeapon0Item, SecondaryHand = vWeapon1Item, AllowEmptyMainHand = false},
		};
		
		local	vBestCombinationIndex = nil;
		local	vBestCombinationValue = nil;
		
		for vIndex = 1, 6 do
			local	vCombination = vCombinations[vIndex];
			
			-- Ignore combinations where the main hand is empty if
			-- that's not allowed in this combinations
			
			if vCombination.AllowEmptyMainHand
			or vCombination.MainHand then
				local	vCombinationValue = Outfitter_AddStats(vCombination.MainHand, vCombination.SecondaryHand, pStatID);
				
				if not vBestCombinationIndex
				or vCombinationValue > vBestCombinationValue then
					vBestCombinationIndex = vIndex;
					vBestCombinationValue = vCombinationValue;
				end
			end
		end
		
		if vBestCombinationIndex then
			local	vCombination = vCombinations[vBestCombinationIndex];
			
			pOutfit.Items.MainHandSlot = vCombination.MainHand;
			pOutfit.Items.SecondaryHandSlot = vCombination.SecondaryHand;
		end
		
		pOutfit.Items.Weapon0Slot = nil;
		pOutfit.Items.Weapon1Slot = nil;
	end
	
	-- Compare the 2H slot with the 1H/OH slots
	
	local	v2HItem = pOutfit.Items.TwoHandSlot;
	
	if v2HItem then
		local	v1HItem = pOutfit.Items.MainHandSlot;
		local	vOHItem = pOutfit.Items.SecondaryHandSlot;
		local	v1HOHTotalStat = Outfitter_AddStats(v1HItem, vOHItem, pStatID);
		
		if v2HItem[pStatID]
		and v2HItem[pStatID] > v1HOHTotalStat then
			pOutfit.Items.MainHandSlot = v2HItem;
			pOutfit.Items.SecondaryHandSlot = nil;
		end
		
		pOutfit.Items.TwoHandSlot = nil;
	end
end

function Outfitter_RemoveOutfitItem(pOutfit, pSlotName)
	pOutfit.Items[pSlotName] = nil;
end

function Outfitter_GetInventoryOutfit(pName, pOutfit)
	local	vOutfit;
	
	if pOutfit then
		vOutfit = pOutfit;
	else
		vOutfit = Outfitter_NewEmptyOutfit(pName);
	end
	
	for _, vInventorySlot in Outfitter_cSlotNames do
		local	vItemInfo = Outfitter_GetInventoryItemInfo(vInventorySlot);
		
		-- To avoid extra memory operations, only update the item if it's different
		
		local	vExistingItem = vOutfit.Items[vInventorySlot];
		
		if not vItemInfo then
			if not vExistingItem
			or vExistingItem.Code ~= 0 then
				Outfitter_AddOutfitItem(vOutfit, vInventorySlot, 0, 0, "", 0);
			end
		else
			if not vExistingItem
			or vExistingItem.Code ~= vItemInfo.Code
			or vExistingItem.SubCode ~= vItemInfo.SubCode
			or vExistingItem.EnchantCode ~= vItemInfo.EnchantCode then
				Outfitter_AddOutfitItem(vOutfit, vInventorySlot, vItemInfo.Code, vItemInfo.SubCode, vItemInfo.Name, vItemInfo.EnchantCode);
			end
		end
	end
	
	return vOutfit;
end

function Outfitter_UpdateOutfitFromInventory(pOutfit, pNewItemsOutfit)
	if not pNewItemsOutfit then
		return;
	end
	
	for vInventorySlot, vItem in pNewItemsOutfit.Items do
		-- Only update slots which aren't in an unknown state
		
		local	vCheckbox = getglobal("OutfitterEnable"..vInventorySlot);
		
		if not vCheckbox:GetChecked()
		or not vCheckbox.IsUnknown then
			pOutfit.Items[vInventorySlot] = vItem;
			Outfitter_NoteMessage(format(Outfitter_cAddingItem, vItem.Name, pOutfit.Name));
			Outfitter_UpdateOutfitCategory(pOutfit);
		end
	end
	
	-- Add the new items to the current compiled outfit
	
	for vInventorySlot, vItem in pNewItemsOutfit.Items do
		gOutfitter_ExpectedOutfit.Items[vInventorySlot] = pNewItemsOutfit.Items[vInventorySlot];
	end
	
	gOutfitter_DisplayIsDirty = true;
end

function Outfitter_SubtractOutfit(pOutfit1, pOutfit2, pCheckAlternateSlots)
	local	vEquippableItems = OutfitterItemList_GetEquippableItems();
	
	-- Remove items from pOutfit1 if they match the item in pOutfit2
	
	for _, vInventorySlot in Outfitter_cSlotNames do
		local	vItem1 = pOutfit1.Items[vInventorySlot];
		local	vItem2 = pOutfit2.Items[vInventorySlot];
		
		if OutfitterItemList_ItemsAreSame(vEquippableItems, vItem1, vItem2) then
			pOutfit1.Items[vInventorySlot] = nil;
		elseif pCheckAlternateSlots then
			local	vAlternateSlotName = Outfitter_cFullAlternateStatSlot[vInventorySlot];
			
			vItem2 = pOutfit2.Items[vAlternateSlotName];
			
			if OutfitterItemList_ItemsAreSame(vEquippableItems, vItem1, vItem2) then
				pOutfit1.Items[vInventorySlot] = nil;
			end
		end
	end
end

function Outfitter_GetNewItemsOutfit(pPreviousOutfit)
	-- Get the current outfit and the list
	-- of equippable items
	
	gOutfitter_CurrentInventoryOutfit = Outfitter_GetInventoryOutfit(gOutfitter_CurrentInventoryOutfit);
	
	local	vEquippableItems = OutfitterItemList_GetEquippableItems();
	
	-- Create a temporary outfit from the differences
	
	local	vNewItemsOutfit = Outfitter_NewEmptyOutfit();
	local	vOutfitHasItems = false;
	
	for _, vInventorySlot in Outfitter_cSlotNames do
		local	vCurrentItem = gOutfitter_CurrentInventoryOutfit.Items[vInventorySlot];
		local	vPreviousItem = pPreviousOutfit.Items[vInventorySlot];
		local	vSkipSlot = false;
		
		if vInventorySlot == "SecondaryHandSlot" then
			local	vMainHandItem = pPreviousOutfit.Items["MainHandSlot"];
			
			if vMainHandItem
			and vMainHandItem.MetaSlotName == "TwoHandSlot" then
				vSkipSlot = true;
			end
		elseif vInventorySlot == "AmmoSlot"
		and (not vCurrentItem or vCurrentItem.Code == 0) then
			vSkipSlot = true;
		end
		
		if not vSkipSlot
		and not OutfitterItemList_InventorySlotContainsItem(vEquippableItems, vInventorySlot, vPreviousItem) then
			vNewItemsOutfit.Items[vInventorySlot] = vCurrentItem;
			vOutfitHasItems = true;
		end
	end
	
	if not vOutfitHasItems then
		return nil;
	end
	
	return vNewItemsOutfit, gOutfitter_CurrentInventoryOutfit;
end

function Outfitter_UpdateTemporaryOutfit(pNewItemsOutfit)
	-- Just return if nothing has changed
	
	if not pNewItemsOutfit then
		return;
	end
	
	-- Merge the new items with an existing temporary outfit
	
	local	vTemporaryOutfit = OutfitterStack_GetTemporaryOutfit();
	local	vUsingExistingTempOutfit = false;
	
	if vTemporaryOutfit then
	
		for vInventorySlot, vItem in pNewItemsOutfit.Items do
			vTemporaryOutfit.Items[vInventorySlot] = vItem;
		end
		
		vUsingExistingTempOutfit = true;
	
	-- Otherwise add the new items as the temporary outfit
	
	else
		vTemporaryOutfit = pNewItemsOutfit;
	end
	
	-- Subtract out items which are expected to be in the outfit
	
	local	vExpectedOutfit = Outfitter_GetExpectedOutfit(vTemporaryOutfit);
	
	Outfitter_SubtractOutfit(vTemporaryOutfit, vExpectedOutfit);
	
	if Outfitter_IsEmptyOutfit(vTemporaryOutfit) then
		if vUsingExistingTempOutfit then
			Outfitter_RemoveOutfit(vTemporaryOutfit);
		end
	else
		if not vUsingExistingTempOutfit then
			OutfitterStack_AddOutfit(vTemporaryOutfit);
		end
	end
	
	-- Add the new items to the current compiled outfit
	
	for vInventorySlot, vItem in pNewItemsOutfit.Items do
		gOutfitter_ExpectedOutfit.Items[vInventorySlot] = vItem;
	end
end

function Outfitter_SetSlotEnable(pSlotName, pEnable)
	if not gOutfitter_SelectedOutfit then
		return;
	end
	
	if pEnable then
		local	vItemInfo = Outfitter_GetInventoryItemInfo(pSlotName);
		
		if vItemInfo then
			gOutfitter_SelectedOutfit.Items[pSlotName] = {Code = vItemInfo.Code, SubCode = vItemInfo.SubCode, Name = vItemInfo.Name, EnchantCode = vItemInfo.EnchantCode};
		else
			gOutfitter_SelectedOutfit.Items[pSlotName] = {Code = 0, SubCode = 0, Name = "", EnchantCode = 0};
		end
	else
		gOutfitter_SelectedOutfit.Items[pSlotName] = nil;
	end
	
	gOutfitter_DisplayIsDirty = true;
end

function Outfitter_GetSpecialOutfit(pSpecialID)
	for vOutfitIndex, vOutfit in gOutfitter_Settings.Outfits.Special do
		if vOutfit.SpecialID == pSpecialID then
			return vOutfit;
		end
	end
	
	return nil;
end

function Outfitter_GetPlayerAuraStates()
	local		vAuraStates =
	{
		Dining = false,
		Shadowform = false,
		Riding = false,
		GhostWolf = false,
		Feigning = false,
		Evocate = false,
		Monkey = false,
		Hawk = false,
		Cheetah = false,
		Pack = false,
		Beast = false,
		Wild = false
	};
	
	local		vBuffIndex = 1;
	
	while true do
		vTexture = UnitBuff("player", vBuffIndex);
		
		if not vTexture then
			return vAuraStates;
		end
		
		local	vStartIndex, vEndIndex, vTextureName = string.find(vTexture, "([^%\\]*)$");
		
		--
		
		local	vSpecialID = gOutfitter_AuraIconSpecialID[vTextureName];
		
		if vSpecialID then
			vAuraStates[vSpecialID] = true;
		
		--
		
		elseif not vAuraStates.Dining
		and string.find(vTextureName, "INV_Drink") then
			vAuraStates.Dining = true;
		
		--
		
		else
			local	vTextLine1, vTextLine2 = Outfitter_GetBuffTooltipText(vBuffIndex);
			
			if vTextLine1 then
				local	vSpecialID = gOutfitter_SpellNameSpecialID[vTextLine1];
				
				if vSpecialID then
					vAuraStates[vSpecialID] = true;
				
				elseif vTextLine2
				and string.find(vTextLine2, Outfitter_cMountSpeedFormat) then
					vAuraStates.Riding = true;
				end
			end
		end
		
		vBuffIndex = vBuffIndex + 1;
	end
end

function Outfitter_GetBuffTooltipText(pBuffIndex)
	OutfitterTooltip:SetOwner(OutfitterFrame, "ANCHOR_BOTTOMRIGHT", 0, 0);
	OutfitterTooltip:SetUnitBuff("player", pBuffIndex);
	
	local	vText1, vText2;
	
	if OutfitterTooltipTextLeft1:IsShown() then
		vText1 = OutfitterTooltipTextLeft1:GetText();
	end -- if IsShown

	if OutfitterTooltipTextLeft2:IsShown() then
		vText2 = OutfitterTooltipTextLeft2:GetText();
	end -- if IsShown

	OutfitterTooltip:Hide();
	
	return vText1, vText2;
end

function Outfitter_UpdateAuraStates()
	-- Check for special aura outfits
	
	local	vAuraStates = Outfitter_GetPlayerAuraStates();
	
	for vSpecialID, vIsActive in vAuraStates do
		if vSpecialID == "Feigning" then
			gOutfitter_IsFeigning = vIsActive;
		else
			if not gOutfitter_SpecialState[vSpecialID] then
				gOutfitter_SpecialState[vSpecialID] = false;
			end
			
			if gOutfitter_SpecialState[vSpecialID] ~= vIsActive then
				gOutfitter_SpecialState[vSpecialID] = vIsActive;
				Outfitter_SetSpecialOutfitEnabled(vSpecialID, vIsActive);
			end
		end
	end
	
	-- As of 1.12 aura changes are the only way to detect shapeshifts, so update those too
	
	Outfitter_UpdateShapeshiftState();
end

function Outfitter_UpdateShapeshiftState()
	local	vNumForms = GetNumShapeshiftForms();
	
	for vIndex = 1, vNumForms do
		local	vTexture, vName, vIsActive, vIsCastable = GetShapeshiftFormInfo(vIndex);
		local	vSpecialID = Outfitter_cShapeshiftSpecialIDs[vName];
		
		if vSpecialID then
			if not vIsActive then
				vIsActive = false;
			end
			
			if gOutfitter_SpecialState[vSpecialID.ID] == nil then
				gOutfitter_SpecialState[vSpecialID.ID] = Outfitter_WearingSpecialOutfit(vSpecialID.ID);
			end
			
			if gOutfitter_SpecialState[vSpecialID.ID] ~= vIsActive then
				gOutfitter_SpecialState[vSpecialID.ID] = vIsActive;
				Outfitter_SetSpecialOutfitEnabled(vSpecialID.ID, vIsActive);
			end
		end
	end
end

function Outfitter_SetSpecialOutfitEnabled(pSpecialID, pEnable)
	local	vOutfit = Outfitter_GetSpecialOutfit(pSpecialID);
	
	if not vOutfit
	or vOutfit.Disabled
	or (pEnable and vOutfit.BGDisabled and Outfitter_InBattlegroundZone()) then
		return;
	end
	
	if pEnable then
		-- Start monitoring health and mana if it's the dining outfit
		
		if pSpecialID == "Dining" then
			Outfitter_ResumeEvent(OutfitterFrame, "UNIT_HEALTH");
			Outfitter_ResumeEvent(OutfitterFrame, "UNIT_MANA");
		end
		
		--
		
		local	vWearBelowOutfit = nil;
		
		-- If it's the ArgentDawn outfit, wear it below the
		-- riding outfit.  Once the player dismounts then
		-- overlapping items from the ArgentDawn outfit will equip.
		-- This will prevent the Argent Dawn trinket from interfering
		-- with the carrot trinket when riding into the plaguelands
		
		if pSpecialID == "ArgentDawn" then
			vWearBelowOutfit = Outfitter_GetSpecialOutfit("Riding");
		end
		
		--
		
		Outfitter_WearOutfit(vOutfit, "Special", vWearBelowOutfit);
	else
		Outfitter_RemoveOutfit(vOutfit);
	end
end

function Outfitter_WearingSpecialOutfit(pSpecialID)
	for vIndex, vOutfit in gOutfitter_OutfitStack do
		if vOutfit.SpecialID == pSpecialID then
			return true, vIndex;
		end
	end
end

function Outfitter_UpdateZone()
	local	vCurrentZone = GetZoneText();
	local	vPVPType, vFactionName, vIsArena = GetZonePVPInfo();
	
	if vCurrentZone == gOutfitter_CurrentZone then
		return;
	end
	
	gOutfitter_CurrentZone = vCurrentZone;
	
	local	vZoneSpecialIDMap = Outfitter_cZoneSpecialIDMap[vCurrentZone];
	local	vSpecialZoneStates = {};
	
	if vZoneSpecialIDMap then
		for _, vZoneSpecialID in vZoneSpecialIDMap do
			if vZoneSpecialID ~= "City" or vPVPType ~= "hostile" then
				vSpecialZoneStates[vZoneSpecialID] = true;
			end
		end
	end
	
	for _, vSpecialID in Outfitter_cZoneSpecialIDs do
		local	vIsActive = vSpecialZoneStates[vSpecialID];
		
		if vIsActive == nil then
			vIsActive = false;
		end
		
		local	vCurrentIsActive = gOutfitter_SpecialState[vSpecialID];
		
		if vCurrentIsActive == nil then
			vCurrentIsActive = Outfitter_WearingSpecialOutfit(vSpecialID);
			gOutfitter_SpecialState[vSpecialID] = vCurrentIsActive;
		end
		
		if vCurrentIsActive ~= vIsActive then
			gOutfitter_SpecialState[vSpecialID] = vIsActive;
			Outfitter_SetSpecialOutfitEnabled(vSpecialID, vIsActive);
		end
	end
end

function Outfitter_InBattlegroundZone()
	local	vZoneSpecialIDMap = Outfitter_cZoneSpecialIDMap[gOutfitter_CurrentZone];
	
	return vZoneSpecialIDMap and vZoneSpecialIDMap[1] == "Battleground";
end

function Outfitter_SetAllSlotEnables(pEnable)
	for _, vInventorySlot in Outfitter_cSlotNames do
		Outfitter_SetSlotEnable(vInventorySlot, pEnable);
	end
	
	Outfitter_UpdateOutfitCategory(gOutfitter_SelectedOutfit);
	Outfitter_Update(true);
end

function Outfitter_OutfitIsComplete(pOutfit, pIgnoreAmmoSlot)
	for _, vInventorySlot in Outfitter_cSlotNames do
		if not pOutfit.Items[vInventorySlot]
		and (not pIgnoreAmmoSlot or vInventorySlot ~= "AmmoSlot") then
			return false;
		end
	end
	
	return true;
end

function Outfitter_CalculateOutfitCategory(pOutfit)
	local	vIgnoreAmmoSlot = UnitHasRelicSlot("player");

	if Outfitter_OutfitIsComplete(pOutfit, vIgnoreAmmoSlot) then
		return "Complete";
	elseif pOutfit.IsAccessory then
		return "Accessory";
	else
		return "Partial";
	end
end

function Outfitter_UpdateOutfitCategory(pOutfit)
	if not pOutfit then
		return;
	end
	
	local	vTargetCategoryID = Outfitter_CalculateOutfitCategory(pOutfit);
	local	vOutfitCategoryID, vOutfitIndex = Outfitter_FindOutfit(pOutfit);
	
	-- Don't move special outfits around
	
	if vOutfitCategoryID == "Special" then
		return;
	end
	
	-- Move the outfit if necessary
	
	if vTargetCategoryID ~= vOutfitCategoryID then
		table.remove(gOutfitter_Settings.Outfits[vOutfitCategoryID], vOutfitIndex);
		Outfitter_AddOutfit(pOutfit);
	end
end

function Outfitter_DeleteOutfit(pOutfit)
	local	vWearingOutfit = Outfitter_WearingOutfit(pOutfit);
	local	vOutfitCategoryID, vOutfitIndex = Outfitter_FindOutfit(pOutfit);
	
	if not vOutfitCategoryID then
		return;
	end
	
	-- Delete the outfit
	
	table.remove(gOutfitter_Settings.Outfits[vOutfitCategoryID], vOutfitIndex);
	
	-- Deselect the outfit
	
	if pOutfit == gOutfitter_SelectedOutfit then
		Outfitter_ClearSelection();
	end
	
	-- Remove the outfit if it's being worn
	
	Outfitter_RemoveOutfit(pOutfit);
	
	--
	
	gOutfitter_DisplayIsDirty = true;
end

function Outfitter_AddOutfit(pOutfit)
	local	vCategoryID;
	
	if pOutfit.SpecialID then
		vCategoryID = "Special"
	else
		vCategoryID = Outfitter_CalculateOutfitCategory(pOutfit);
	end
	
	if not gOutfitter_Settings.Outfits then
		gOutfitter_Settings.Outfits = {};
	end
	
	if not gOutfitter_Settings.Outfits[vCategoryID] then
		gOutfitter_Settings.Outfits[vCategoryID] = {};
	end
	
	table.insert(gOutfitter_Settings.Outfits[vCategoryID], pOutfit);
	pOutfit.CategoryID = vCategoryID;
	
	gOutfitter_DisplayIsDirty = true;
	
	return vCategoryID;
end

function Outfitter_SlotEnableClicked(pCheckbox, pButton)
	-- If the user is attempting to drop an item put it in the slot for them
	
	if CursorHasItem() then
		local	vSlotID, vEmptySlotTexture = GetInventorySlotInfo(pCheckbox.SlotName);
		PickupInventoryItem(vSlotID);
		return;
	end
	
	--
	
	local	vChecked = pCheckbox:GetChecked();
	
	if pCheckbox.IsUnknown then
		pCheckbox.IsUnknown = false;
		pCheckbox:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check");
		vChecked = true;
	end
	
	Outfitter_SetSlotEnable(pCheckbox.SlotName, vChecked);
	Outfitter_UpdateOutfitCategory(gOutfitter_SelectedOutfit);
	Outfitter_Update(true);
end

function Outfitter_FindMultipleItemLocation(pItems, pEquippableItems)
	for vListIndex, vListItem in pItems do
		local	vItem = OutfitterItemList_FindItemOrAlt(pEquippableItems, vListItem);
		
		if vItem then
			return vItem, vListItem;
		end
	end
	
	return nil, nil;
end

function Outfitter_FindAndAddItemsToOutfit(pOutfit, pSlotName, pItems, pEquippableItems)
	vItemLocation, vItem = Outfitter_FindMultipleItemLocation(pItems, pEquippableItems);
	
	if vItemLocation then
		local	vInventorySlot = pSlotName;
		
		if not vInventorySlot then
			vInventorySlot = vItemLocation.ItemSlotName;
		end
		
		Outfitter_AddOutfitItem(pOutfit, vInventorySlot, vItem.Code, vItem.SubCode, vItem.Name, vItem.EnchantCOde);
	end
end

function Outfitter_AddItemsWithStatToOutfit(pOutfit, pStatID, pEquippableItems)
	local	vItemStats;
	
	if not pEquippableItems then
		return;
	end
	
	for vInventorySlot, vItems in pEquippableItems.ItemsBySlot do
		for vIndex, vItem in vItems do
			local	vStatValue = vItem.Stats[pStatID];
			
			if vStatValue then
				local	vSlotName = vItem.MetaSlotName;
				
				if not vSlotName then
					vSlotName = vItem.ItemSlotName;
				end
				
				Outfitter_AddOutfitStatItemIfBetter(pOutfit, vSlotName, vItem.Code, vItem.SubCode, vItem.Name, vItem.EnchantCode, pStatID, vStatValue);
			end
		end
	end
	
	-- Collapse the meta slots (currently just 2H vs. 1H/OH)
	
	Outfitter_CollapseMetaSlotsIfBetter(pOutfit, pStatID);
end

function Outfitter_IsInitialized()
	return gOutfitter_Initialized;
end

function Outfitter_Initialize()
	if gOutfitter_Initialized then
		return;
	end
	
	--
	
	if not gOutfitter_Settings then
		gOutfitter_Settings = {};
		gOutfitter_Settings.Version = 7;
		gOutfitter_Settings.Options = {};
		gOutfitter_Settings.LastOutfitStack = {};
		gOutfitter_Settings.HideHelm = {};
		gOutfitter_Settings.HideCloak = {};
	end
	
	if not gOutfitter_Settings.HideHelm then
		gOutfitter_Settings.HideHelm = {};
	end
	
	if not gOutfitter_Settings.HideCloak then
		gOutfitter_Settings.HideCloak = {};
	end
	
	--
	
	Outfitter_InitDebugging();
	
	-- Initialize the outfits and outfit stack
	
	gOutfitter_CurrentOutfit = Outfitter_GetInventoryOutfit();
	
	if not gOutfitter_Settings.Outfits then
		Outfitter_InitializeOutfits();
	end
	
	Outfitter_CheckDatabase();
	
	Outfitter_InitializeSpecialOccassionOutfits(); -- Make sure the special occassion outfits are intact
	                                               -- since the user has no way of creating them himself
	OutfitterStack_RestoreSavedStack();
	
	-- Set the minimap button
	
	if gOutfitter_Settings.Options.HideMinimapButton then
		OutfitterMinimapButton:Hide();
	else
		OutfitterMinimapButton:Show();
	end
	
	if not gOutfitter_Settings.Options.MinimapButtonAngle then
		gOutfitter_Settings.Options.MinimapButtonAngle = -1.5708;
	end
	
	OutfitterMinimapButton_SetPositionAngle(gOutfitter_Settings.Options.MinimapButtonAngle);
	
	-- Hook QuickSlots into the paper doll frame
	
	Outfitter_HookPaperDollFrame();
	
	-- Done initializing
	
	gOutfitter_Initialized = true;

	-- Make sure the outfit state is good
	
	Outfitter_SetSpecialOutfitEnabled("Riding", false);
	Outfitter_SetSpecialOutfitEnabled("Spirit", false);
	Outfitter_UpdateAuraStates();
	
	Outfitter_ResumeLoadScreenEvents();
	
	Outfitter_DispatchOutfitEvent("OUTFITTER_INIT")
end

function Outfitter_InitializeOutfits()
	local	vOutfit, vItemLocation, vItem;
	local	vEquippableItems = OutfitterItemList_GetEquippableItems(true);
	
	-- Create the outfit categories
	
	gOutfitter_Settings.Outfits = {};
	
	for vCategoryIndex, vCategoryID in gOutfitter_cCategoryOrder do
		gOutfitter_Settings.Outfits[vCategoryID] = {};
	end

	-- Create the normal outfit using the current
	-- inventory and set it as the currently equipped outfit
	
	vOutfit = Outfitter_GetInventoryOutfit(Outfitter_cNormalOutfit);
	Outfitter_AddOutfit(vOutfit);
	gOutfitter_Settings.LastOutfitStack = {{Name = Outfitter_cNormalOutfit}};
	gOutfitter_OutfitStack = {vOutfit};
	
	-- Create the naked outfit
	
	vOutfit = Outfitter_NewNakedOutfit(Outfitter_cNakedOutfit);
	Outfitter_AddOutfit(vOutfit);
	
	-- Generate the smart outfits
	
	for vSmartIndex, vSmartOutfit in Outfitter_cSmartOutfits do
		vOutfit = Outfitter_GenerateSmartOutfit(vSmartOutfit.Name, vSmartOutfit.StatID, vEquippableItems);
		
		if vOutfit then
			vOutfit.IsAccessory = vSmartOutfit.IsAccessory;
			Outfitter_AddOutfit(vOutfit);
		end
	end
	
	Outfitter_InitializeSpecialOccassionOutfits();
end

function Outfitter_CreateEmptySpecialOccassionOutfit(pSpecialID, pName)
	vOutfit = Outfitter_GetSpecialOutfit(pSpecialID);
	
	if not vOutfit then
		vOutfit = Outfitter_NewEmptyOutfit(pName);
		vOutfit.SpecialID = pSpecialID;
		
		Outfitter_AddOutfit(vOutfit);
	end
end

function Outfitter_InitializeSpecialOccassionOutfits()
	local	vEquippableItems = OutfitterItemList_GetEquippableItems(true);
	local	vOutfit;
	
	-- Find an argent dawn trinket and set the argent dawn outfit
	
	vOutfit = Outfitter_GetSpecialOutfit("ArgentDawn");
	
	if not vOutfit then
		vOutfit = Outfitter_GenerateSmartOutfit(Outfitter_cArgentDawnOutfit, "ArgentDawn", vEquippableItems, true);
		vOutfit.SpecialID = "ArgentDawn";
		Outfitter_AddOutfit(vOutfit);
	end
	
	-- Find riding items
	
	vOutfit = Outfitter_GetSpecialOutfit("Riding");
	
	if not vOutfit then
		vOutfit = Outfitter_GenerateSmartOutfit(Outfitter_cRidingOutfit, "Riding", vEquippableItems, true);
		vOutfit.SpecialID = "Riding";
		vOutfit.BGDisabled = true;
		Outfitter_AddOutfit(vOutfit);
	end
	
	-- Create the dining outfit
	
	Outfitter_CreateEmptySpecialOccassionOutfit("Dining", Outfitter_cDiningOutfit);
	
	-- Create the Battlegrounds outfits
	
	Outfitter_CreateEmptySpecialOccassionOutfit("Battleground", Outfitter_cBattlegroundOutfit);
	Outfitter_CreateEmptySpecialOccassionOutfit("AB", Outfitter_cABOutfit);
	Outfitter_CreateEmptySpecialOccassionOutfit("AV", Outfitter_cAVOutfit);
	Outfitter_CreateEmptySpecialOccassionOutfit("WSG", Outfitter_cWSGOutfit);
	
	-- Create the city outfit
	
	Outfitter_CreateEmptySpecialOccassionOutfit("City", Outfitter_cCityOutfit);
	
	-- Create class-specific outfits
	
	Outfitter_InitializeClassOutfits();
end

function Outfitter_InitializeClassOutfits()
	local	vClassName = Outfitter_cNormalizedClassName[UnitClass("player")];
	local	vOutfits = Outfitter_cClassSpecialOutfits[vClassName];
	
	if not vOutfits then
		return;
	end
	
	for vIndex, vOutfitInfo in vOutfits do
		Outfitter_CreateEmptySpecialOccassionOutfit(vOutfitInfo.SpecialID, vOutfitInfo.Name);
	end
end

function Outfitter_IsStatText(pText)
	for vStatIndex, vStatInfo in Outfitter_cItemStatFormats do
		local	vStartIndex, vEndIndex, vValue = string.find(pText, vStatInfo.Format);
		
		if vStartIndex then
			vValue = tonumber(vValue);
			
			if not vValue then
				vValue = vStatInfo.Value;
			end
			
			if not vValue then
				vValue = 0;
			end
			
			return vStatInfo.Types, vValue;
		end
	end
	
	return nil, nil;
end

function Outfitter_GetItemStatsFromTooltip(pTooltip, pDistribution)
	local	vStats = {};
	local	vTooltipName = pTooltip:GetName();
	
	for vLineIndex = 1, 30 do
		local	vLeftText = getglobal(vTooltipName.."TextLeft"..vLineIndex):GetText();
		-- local	vRightText = getglobal(vTooltipName.."TextRight"..vLineIndex):GetText();
		
		if vLeftText then
			-- Check for the start of the set bonus section
			
			local	vStartIndex, vEndIndex, vValue = string.find(vLeftText, "%(%d/%d%)");
			
			if vStartIndex then
				break;
			end
			
			--
			
			for vStatString in string.gfind(vLeftText, "([^/]+)") do
				local	vStatIDs, vValue = Outfitter_IsStatText(vStatString);
				
				if vStatIDs then
					for vStatIDIndex, vStatID in vStatIDs do
						OutfitterStats_AddStatValue(vStats, vStatID, vValue, pDistribution);
					end
				end
			end
		end
	end -- for vLineIndex
	
	return vStats;
end

function Outfitter_TooltipContainsText(pTooltip, pText)
	local	vTooltipName = pTooltip:GetName();
	
	for vLineIndex = 1, 30 do
		local	vLeftText = getglobal(vTooltipName.."TextLeft"..vLineIndex):GetText();
		
		if vLeftText
		and string.find(vLeftText, pText) then
			return true;
		end
	end -- for vLineIndex
	
	return false;
end

function Outfitter_CanEquipBagItem(pBagIndex, pBagSlotIndex)
	local	vItemInfo = Outfitter_GetBagItemInfo(pBagIndex, pBagSlotIndex);
	
	if vItemInfo
	and vItemInfo.Level
	and UnitLevel("player") < vItemInfo.Level then
		return false;
	end
	
	return true;
end

function Outfitter_BagItemWillBind(pBagIndex, pBagSlotIndex)
	local	vItemLink = GetContainerItemLink(pBagIndex, pBagSlotIndex);
	
	if not vItemLink then
		return nil;
	end
	
	OutfitterTooltip:SetOwner(OutfitterFrame, "ANCHOR_BOTTOMRIGHT", 0, 0);
	OutfitterTooltip:SetBagItem(pBagIndex, pBagSlotIndex);
	
	local	vIsBOE = Outfitter_TooltipContainsText(OutfitterTooltip, ITEM_BIND_ON_EQUIP);
	
	OutfitterTooltip:Hide();
	
	return vIsBOE;
end

function Outfitter_GenerateSmartOutfit(pName, pStatID, pEquippableItems, pAllowEmptyOutfit)
	local	vOutfit = Outfitter_NewEmptyOutfit(pName);
	
	if pStatID == "TANKPOINTS" then
		return;
	end
	
	local	vItems = Outfitter_cStatIDItems[pStatID];
	
	OutfitterItemList_ResetIgnoreItemFlags(pEquippableItems);
	
	if vItems then
		Outfitter_FindAndAddItemsToOutfit(vOutfit, nil, vItems, pEquippableItems);
	end
	
	Outfitter_AddItemsWithStatToOutfit(vOutfit, pStatID, pEquippableItems);
	
	if not pAllowEmptyOutfit
	and Outfitter_IsEmptyOutfit(vOutfit) then
		return nil;
	end
	
	vOutfit.StatID = pStatID;
	
	return vOutfit;
end

function Outfitter_ArrayIsEmpty(pArray)
	if not pArray then
		return true;
	end
	
	for vIndex, vValue in pArray do
		return false;
	end
	
	return true;
end

function OutfitterNameOutfit_Open(pOutfit)
	gOutfitter_OutfitToRename = pOutfit;
	
	if gOutfitter_OutfitToRename then
		OutfitterNameOutfitDialogTitle:SetText(Outfitter_cRenameOutfit);
		OutfitterNameOutfitDialogName:SetText(gOutfitter_OutfitToRename.Name);
		OutfitterNameOutfitDialogCreateUsing:Hide();
		OutfitterNameOutfitDialog:SetHeight(OutfitterNameOutfitDialog.baseHeight - 35);
	else
		OutfitterNameOutfitDialogTitle:SetText(Outfitter_cNewOutfit);
		OutfitterNameOutfitDialogName:SetText("");
		OutfitterDropDown_SetSelectedValue(OutfitterNameOutfitDialogCreateUsing, 0);
		OutfitterNameOutfitDialogCreateUsing:Show();
		OutfitterNameOutfitDialog:SetHeight(OutfitterNameOutfitDialog.baseHeight);
		OutfitterNameOutfitDialogCreateUsing.ChangedValueFunc = OutfitterNameOutfit_CheckForStatOutfit;
	end
	
	OutfitterNameOutfitDialog:Show();
	OutfitterNameOutfitDialogName:SetFocus();
end

function OutfitterNameOutfit_CheckForStatOutfit(pMenu, pValue)
	OutfitterNameOutfit_Update(true);
end

function OutfitterNameOutfit_Done()
	local	vName = OutfitterNameOutfitDialogName:GetText();
	
	if vName
	and vName ~= "" then
		if gOutfitter_OutfitToRename then
			local	vWearingOutfit = Outfitter_WearingOutfit(gOutfitter_OutfitToRename);
			
			if vWearingOutfit then
				Outfitter_DispatchOutfitEvent("UNWEAR_OUTFIT", gOutfitter_OutfitToRename.Name, gOutfitter_OutfitToRename)
			end
			
			gOutfitter_OutfitToRename.Name = vName;
			gOutfitter_DisplayIsDirty = true;

			if vWearingOutfit then
				Outfitter_DispatchOutfitEvent("WEAR_OUTFIT", gOutfitter_OutfitToRename.Name, gOutfitter_OutfitToRename)
			end
		else
			-- New outift
			
			local	vStatID = UIDropDownMenu_GetSelectedValue(OutfitterNameOutfitDialogCreateUsing);
			local	vOutfit;
			
			if not vStatID
			or vStatID == 0 then
				vOutfit = Outfitter_GetInventoryOutfit(vName);
			elseif vStatID == "EMPTY" then
				vOutfit = Outfitter_NewEmptyOutfit(vName);
			else
				vOutfit = Outfitter_GenerateSmartOutfit(vName, vStatID, OutfitterItemList_GetEquippableItems(true));
			end
			
			if not vOutfit then
				vOutfit = Outfitter_NewEmptyOutfit(vName);
			end
			
			local	vCategoryID = Outfitter_AddOutfit(vOutfit);
			
			Outfitter_WearOutfit(vOutfit, vCategoryID);
		end
	end
	
	OutfitterNameOutfitDialog:Hide();
	
	Outfitter_Update(true);
end

function OutfitterNameOutfit_Cancel()
	OutfitterNameOutfitDialog:Hide();
end

function OutfitterNameOutfit_Update(pCheckForStatOutfit)
	local	vEnableDoneButton = true;
	local	vErrorMessage = nil;
	
	-- If there's no name entered then disable the okay button
	
	local	vName = OutfitterNameOutfitDialogName:GetText();
	
	if not vName
	or vName == "" then
		vEnableDoneButton = false;
	else
		local	vOutfit = Outfitter_FindOutfitByName(vName);
		
		if vOutfit
		and vOutfit ~= gOutfitter_OutfitToRename then
			vErrorMessage = Outfitter_cNameAlreadyUsedError;
			vEnableDoneButton = false;
		end
	end
	
	-- 
	
	if not vErrorMessage
	and pCheckForStatOutfit then
		local	vStatID = UIDropDownMenu_GetSelectedValue(OutfitterNameOutfitDialogCreateUsing);
		
		if vStatID
		and vStatID ~= 0
		and vStatID ~= "EMPTY" then
			local	vOutfit = Outfitter_GenerateSmartOutfit("temp outfit", vStatID, OutfitterItemList_GetEquippableItems(true));
			
			if not vOutfit
			or Outfitter_IsEmptyOutfit(vOutfit) then
				vErrorMessage = Outfitter_cNoItemsWithStatError;
			end
		end
	end
	
	if vErrorMessage then
		OutfitterNameOutfitDialogError:SetText(vErrorMessage);
		OutfitterNameOutfitDialogError:Show();
	else
		OutfitterNameOutfitDialogError:Hide();
	end
	
	Outfitter_SetButtonEnable(OutfitterNameOutfitDialogDoneButton, vEnableDoneButton);
end

function Outfitter_SetButtonEnable(pButton, pEnabled)
	if pEnabled then
		pButton:Enable();
		pButton:SetAlpha(1.0);
		pButton:EnableMouse(true);
		--getglobal(pButton:GetName().."Text"):SetAlpha(1.0);
	else
		pButton:Disable();
		pButton:SetAlpha(0.7);
		pButton:EnableMouse(false);
		--getglobal(pButton:GetName().."Text"):SetAlpha(0.7);
	end
end

function Outfitter_GetOutfitFromListItem(pItem)
	if pItem.isCategory then
		return nil;
	end
	
	if not gOutfitter_Settings.Outfits then
		return nil;
	end
	
	local	vOutfits = gOutfitter_Settings.Outfits[pItem.categoryID];
	
	if not vOutfits then
		-- Error: outfit category not found
		return nil;
	end
	
	return vOutfits[pItem.outfitIndex], pItem.categoryID;
end

function Outfitter_OutfitItemSelected(pMenu, pValue)
	local	vItem = pMenu:GetParent():GetParent();
	local	vOutfit, vCategoryID = Outfitter_GetOutfitFromListItem(vItem);
	
	if not vOutfit then
		Outfitter_ErrorMessage("Outfitter Error: Outfit for menu item "..vItem:GetName().." not found");
		return;
	end
	
	-- Perform the selected action
	
	if pValue == "DELETE" then
		Outfitter_AskDeleteOutfit(vOutfit);
	elseif pValue == "RENAME" then
		OutfitterNameOutfit_Open(vOutfit);
	elseif pValue == "DISABLE" then
		if vOutfit.Disabled then
			vOutfit.Disabled = nil;
		else
			vOutfit.Disabled = true;
		end
		gOutfitter_DisplayIsDirty = true;
	elseif pValue == "BGDISABLE" then
		if vOutfit.BGDisabled then
			vOutfit.BGDisabled = nil;
		else
			vOutfit.BGDisabled = true;
		end
		gOutfitter_DisplayIsDirty = true;
	elseif pValue == "ACCESSORY" then
		vOutfit.IsAccessory = true;
		Outfitter_UpdateOutfitCategory(vOutfit);
	elseif pValue == "PARTIAL" then
		vOutfit.IsAccessory = nil;
		Outfitter_UpdateOutfitCategory(vOutfit);
	elseif string.sub(pValue, 1, 7) == "BINDING" then
		Outfitter_SetOutfitBindingIndex(vOutfit, tonumber(string.sub(pValue, 8)));
	elseif pValue == "REBUILD" then
		Outfitter_AskRebuildOutfit(vOutfit, vCategoryID);
	elseif pValue == "DEPOSIT" then
		Outfitter_DepositOutfit(vOutfit);
	elseif pValue == "DEPOSITUNIQUE" then
		Outfitter_DepositOutfit(vOutfit, true);
	elseif pValue == "WITHDRAW" then
		Outfitter_WithdrawOutfit(vOutfit);
	end
	
	Outfitter_Update(true);
end

function OutfitterStatDropdown_OnLoad()
	UIDropDownMenu_Initialize(this, OutfitterStatDropdown_Initialize);
	UIDropDownMenu_SetWidth(150);
	UIDropDownMenu_Refresh(this);
end

function Outfitter_GetStatIDName(pStatID)
	for vStatIndex, vStatInfo in Outfitter_cItemStatInfo do
		if vStatInfo.ID == pStatID then
			return vStatInfo.Name;
		end
	end
	
	return nil;
end

function OutfitterStatDropdown_Initialize()
	local	vFrame = getglobal(UIDROPDOWNMENU_INIT_MENU);
	
	if UIDROPDOWNMENU_MENU_LEVEL == 2 then
		for vStatIndex, vStatInfo in Outfitter_cItemStatInfo do
			if vStatInfo.Category == UIDROPDOWNMENU_MENU_VALUE then
				UIDropDownMenu_AddButton({text = vStatInfo.Name, value = vStatInfo.ID, owner = vFrame, func = OutfitterDropDown_OnClick}, UIDROPDOWNMENU_MENU_LEVEL);
			end
		end
	else
		UIDropDownMenu_AddButton({text = Outfitter_cUseCurrentOutfit, value = 0, owner = vFrame, func = OutfitterDropDown_OnClick});
		UIDropDownMenu_AddButton({text = Outfitter_cUseEmptyOutfit, value = "EMPTY", owner = vFrame, func = OutfitterDropDown_OnClick});
		
		UIDropDownMenu_AddButton({text = " ", notCheckable = true, notClickable = true});
		
		for vCategoryIndex, vCategoryInfo in Outfitter_cStatCategoryInfo do
			UIDropDownMenu_AddButton({text = vCategoryInfo.Name, owner = vFrame, hasArrow = 1, value = vCategoryInfo.Category});
		end
		
		if false and IsAddOnLoaded("TankPoints") then
			UIDropDownMenu_AddButton({text = " ", notCheckable = true, notClickable = true});
			UIDropDownMenu_AddButton({text = Outfitter_cTankPoints, value="TANKPOINTS", owner = vFrame, func = OutfitterDropDown_OnClick});
		end
	end
end

function OutfitterDropDown_SetSelectedValue(pDropDown, pValue)
	UIDropDownMenu_SetText("", pDropDown); -- Set to empty in case the selected value isn't there

	UIDropDownMenu_Initialize(pDropDown, pDropDown.initialize);
	UIDropDownMenu_SetSelectedValue(pDropDown, pValue);
	
	-- All done if the item text got set successfully
	
	local	vItemText = UIDropDownMenu_GetText(pDropDown);
	
	if vItemText and vItemText ~= "" then
		return;
	end
	
	-- Scan for submenus
	
	local	vRootListFrameName = "DropDownList1";
	local	vRootListFrame = getglobal(vRootListFrameName);
	local	vRootNumItems = vRootListFrame.numButtons;
	
	for vRootItemIndex = 1, vRootNumItems do
		local	vItem = getglobal(vRootListFrameName.."Button"..vRootItemIndex);
		
		if vItem.hasArrow then
			local	vSubMenuFrame = getglobal("DropDownList2");
			
			UIDROPDOWNMENU_OPEN_MENU = pDropDown:GetName();
			UIDROPDOWNMENU_MENU_VALUE = vItem.value;
			UIDROPDOWNMENU_MENU_LEVEL = 2;
			
			UIDropDownMenu_Initialize(pDropDown, pDropDown.initialize, nil, 2);
			UIDropDownMenu_SetSelectedValue(pDropDown, pValue);
			
			-- All done if the item text got set successfully
			
			local	vItemText = UIDropDownMenu_GetText(pDropDown);
			
			if vItemText and vItemText ~= "" then
				return;
			end
			
			-- Switch back to the root menu
			
			UIDROPDOWNMENU_OPEN_MENU = nil;
			UIDropDownMenu_Initialize(pDropDown, pDropDown.initialize, nil, 1);
		end
	end
end

function OutfitterScrollbarTrench_SizeChanged(pScrollbarTrench)
	local	vScrollbarTrenchName = pScrollbarTrench:GetName();
	local	vScrollbarTrenchMiddle = getglobal(vScrollbarTrenchName.."Middle");
	
	local	vMiddleHeight= pScrollbarTrench:GetHeight() - 51;
	vScrollbarTrenchMiddle:SetHeight(vMiddleHeight);
end

function OutfitterInputBox_OnLoad(pChildDepth)
	if not pChildDepth then
		pChildDepth = 0;
	end
	
	local	vParent = this:GetParent();
	
	for vDepthIndex = 1, pChildDepth do
		vParent = vParent:GetParent();
	end
	
	if vParent.lastEditBox then
		this.prevEditBox = vParent.lastEditBox;
		this.nextEditBox = vParent.lastEditBox.nextEditBox;
		
		this.prevEditBox.nextEditBox = this;
		this.nextEditBox.prevEditBox = this;
	else
		this.prevEditBox = this;
		this.nextEditBox = this;
	end

	vParent.lastEditBox = this;
end

function OutfitterInputBox_TabPressed()
	local		vReverse = IsShiftKeyDown();
	local		vEditBox = this;
	
	for vIndex = 1, 50 do
		local	vNextEditBox;
			
		if vReverse then
			vNextEditBox = vEditBox.prevEditBox;
		else
			vNextEditBox = vEditBox.nextEditBox;
		end
		
		if vNextEditBox:IsVisible()
		and not vNextEditBox.isDisabled then
			vNextEditBox:SetFocus();
			return;
		end
		
		vEditBox = vNextEditBox;
	end
end

function OutfitterTimer_AdjustTimer()
	local	vNeedTimer = false;
	
	if OutfitterMinimapButton.IsDragging then
		vNeedTimer = true;
	end
	
	if gOutfitter_EquippedNeedsUpdate
	or gOutfitter_WeaponsNeedUpdate then
		vNeedTimer = true;
	end
	
	if vNeedTimer then
		OutfitterUpdateFrame:Show();
	else
		OutfitterUpdateFrame:Hide();
		OutfitterUpdateFrame.Elapsed = nil;
	end
end

function OutfitterUpdateFrame_OnUpdate(pElapsed)
	if OutfitterMinimapButton.IsDragging then
		OutfitterMinimapButton_UpdateDragPosition();
	end
	
	if not OutfitterUpdateFrame.Elapsed then
		OutfitterUpdateFrame.Elapsed = 0;
	else
		OutfitterUpdateFrame.Elapsed = OutfitterUpdateFrame.Elapsed + pElapsed;
		
		if OutfitterUpdateFrame.Elapsed > 0.25 then
			Outfitter_UpdateEquippedItems();
			OutfitterUpdateFrame.Elapsed = 0;
		end
	end
	
	OutfitterTimer_AdjustTimer();
end

function OutfitterMinimapButton_MouseDown()
	-- Remember where the cursor was in case the user drags
	
	local	vCursorX, vCursorY = GetCursorPosition();
	
	vCursorX = vCursorX / this:GetEffectiveScale();
	vCursorY = vCursorY / this:GetEffectiveScale();
	
	OutfitterMinimapButton.CursorStartX = vCursorX;
	OutfitterMinimapButton.CursorStartY = vCursorY;
	
	local	vCenterX, vCenterY = OutfitterMinimapButton:GetCenter();
	local	vMinimapCenterX, vMinimapCenterY = Minimap:GetCenter();
	
	OutfitterMinimapButton.CenterStartX = vCenterX - vMinimapCenterX;
	OutfitterMinimapButton.CenterStartY = vCenterY - vMinimapCenterY;
end

function OutfitterMinimapButton_DragStart()
	OutfitterMinimapButton.IsDragging = true;
	OutfitterTimer_AdjustTimer();
end

function OutfitterMinimapButton_DragEnd()
	OutfitterMinimapButton.IsDragging = false;
	OutfitterTimer_AdjustTimer();
end

function OutfitterMinimapButton_UpdateDragPosition()
	-- Remember where the cursor was in case the user drags
	
	local	vCursorX, vCursorY = GetCursorPosition();
	
	vCursorX = vCursorX / this:GetEffectiveScale();
	vCursorY = vCursorY / this:GetEffectiveScale();
	
	local	vCursorDeltaX = vCursorX - OutfitterMinimapButton.CursorStartX;
	local	vCursorDeltaY = vCursorY - OutfitterMinimapButton.CursorStartY;
	
	--
	
	local	vCenterX = OutfitterMinimapButton.CenterStartX + vCursorDeltaX;
	local	vCenterY = OutfitterMinimapButton.CenterStartY + vCursorDeltaY;
	
	-- Calculate the angle
	
	local	vAngle = math.atan2(vCenterX, vCenterY);
	
	-- Set the new position
	
	OutfitterMinimapButton_SetPositionAngle(vAngle);
end

function Outfitter_RestrictAngle(pAngle, pRestrictStart, pRestrictEnd)
	if pAngle <= pRestrictStart
	or pAngle >= pRestrictEnd then
		return pAngle;
	end
	
	local	vDistance = (pAngle - pRestrictStart) / (pRestrictEnd - pRestrictStart);
	
	if vDistance > 0.5 then
		return pRestrictEnd;
	else
		return pRestrictStart;
	end
end

function OutfitterMinimapButton_SetPositionAngle(pAngle)
	local	vAngle = pAngle;
	
	-- Restrict the angle from going over the date/time icon or the zoom in/out icons
	
	local	vRestrictedStartAngle = nil;
	local	vRestrictedEndAngle = nil;
	
	if GameTimeFrame:IsVisible() then
		if MinimapZoomIn:IsVisible()
		or MinimapZoomOut:IsVisible() then
			vAngle = Outfitter_RestrictAngle(vAngle, 0.4302272732931596, 2.930420793963121);
		else
			vAngle = Outfitter_RestrictAngle(vAngle, 0.4302272732931596, 1.720531504573905);
		end
		
	elseif MinimapZoomIn:IsVisible()
	or MinimapZoomOut:IsVisible() then
		vAngle = Outfitter_RestrictAngle(vAngle, 1.720531504573905, 2.930420793963121);
	end
	
	-- Restrict it from the tracking icon area
	
	vAngle = Outfitter_RestrictAngle(vAngle, -1.290357134304173, -0.4918423429923585);
	
	--
	
	local	vRadius = 80;
	
	vCenterX = math.sin(vAngle) * vRadius;
	vCenterY = math.cos(vAngle) * vRadius;
	
	OutfitterMinimapButton:SetPoint("CENTER", "Minimap", "CENTER", vCenterX - 1, vCenterY - 1);
	
	gOutfitter_Settings.Options.MinimapButtonAngle = vAngle;
end

function OutfitterMinimapButton_ItemSelected(pMenu, pValue)
	local	vType = type(pValue);
	
	if vType == "table" then
		local	vCategoryID = pValue.CategoryID;
		local	vIndex = pValue.Index;
		local	vOutfit = gOutfitter_Settings.Outfits[vCategoryID][vIndex];
		local	vDoToggle = vCategoryID ~= "Complete";
		
		if vDoToggle
		and Outfitter_WearingOutfit(vOutfit) then
			Outfitter_RemoveOutfit(vOutfit);
		else
			Outfitter_WearOutfit(vOutfit, vCategoryID);
		end
		
		if vDoToggle then
			return true;
		end
	else
		if pValue == 0 then -- Open Outfitter
			ShowUIPanel(CharacterFrame);
			CharacterFrame_ShowSubFrame("PaperDollFrame");
			OutfitterFrame:Show();
		end
	end
	
	return false;
end

function Outfitter_WearingOutfit(pOutfit)
	return OutfitterStack_FindOutfit(pOutfit);
end

function Outfitter_GetCurrentOutfitInfo()
	if not gOutfitter_Initialized then
		return "", nil;
	end
	
	local	vStackLength = table.getn(gOutfitter_OutfitStack);
	
	if vStackLength == 0 then
		return "", nil;
	end
	
	local	vOutfit = gOutfitter_OutfitStack[vStackLength];
	
	if vOutfit and vOutfit.Name then
		return vOutfit.Name, vOutfit;
	else
		return Outfitter_cCustom, vOutfit;
	end
end

function Outfitter_CheckDatabase()
	local	vOutfit;
	
	if not gOutfitter_Settings.Version then
		local	vOutfits = gOutfitter_Settings.Outfits[vCategoryID];
		
		if gOutfitter_Settings.Outfits then
			for vCategoryID, vOutfits in gOutfitter_Settings.Outfits do
				for vIndex, vOutfit in vOutfits do
					if Outfitter_OutfitIsComplete(vOutfit, true) then
						Outfitter_AddOutfitItem(vOutfit, "AmmoSlot", 0, 0, "", 0);
					end
				end
			end
		end
		
		gOutfitter_Settings.Version = 1;
	end
	
	-- Versions 1 and 2 both simply add class outfits
	-- so just reinitialize those
	
	if gOutfitter_Settings.Version < 3 then
		Outfitter_InitializeClassOutfits();
		gOutfitter_Settings.Version = 3;
	end
	
	-- Version 4 sets the BGDisabled flag for the mounted outfit
	
	if gOutfitter_Settings.Version < 4 then
		local	vRidingOutfit = Outfitter_GetSpecialOutfit("Riding");
		
		if vRidingOutfit then
			vRidingOutfit.BGDisabled = true;
		end
		
		gOutfitter_Settings.Version = 4;
	end
	
	-- Version 5 adds moonkin form, just reinitialize class outfits

	if gOutfitter_Settings.Version < 5 then
		Outfitter_InitializeClassOutfits();
		gOutfitter_Settings.Version = 5;
	end
	
	-- Make sure all outfits have an associated category ID
	
	if gOutfitter_Settings.Outfits then
		for vCategoryID, vOutfits in gOutfitter_Settings.Outfits do
			for vIndex, vOutfit in vOutfits do
				vOutfit.CategoryID = vCategoryID;
			end
		end
	end
	
	-- Version 6 and 7 adds item sub-code and enchantment codes
	-- (7 tries to clean up failed updates from 6)
	
	if gOutfitter_Settings.Version < 7 then
		if not Outfitter_UpdateDatabaseItemCodes() then
			gOutfitter_NeedItemCodesUpdated = 5; -- Do up to five attempts at updated the item codes
		end
		
		gOutfitter_Settings.Version = 7;
	end
	
	-- Scan the outfits and make sure everything is in order
	
	for vCategoryID, vOutfits in gOutfitter_Settings.Outfits do
		for vIndex, vOutfit in vOutfits do
			Outfitter_CheckOutfit(vOutfit);
		end
	end
end

function Outfitter_CheckOutfit(pOutfit)
	if not pOutfit.Name then
		pOutfit.Name = "Damaged outfit";
	end
	
	if not pOutfit.Items then
		pOutfit.Items = {};
	end
	
	for vInventorySlot, vItem in pOutfit.Items do
		if not vItem.Code then
			vItem.Code = 0;
		end
		
		if not vItem.SubCode then
			vItem.SubCode = 0;
		end
		
		if not vItem.Name then
			vItem.Name = "";
		end
		
		if not vItem.EnchantCode then
			vItem.EnchantCode = 0;
		end
	end
end

function Outfitter_UpdateDatabaseItemCodes()
	local	vEquippableItems = OutfitterItemList_GetEquippableItems();
	local	vResult = true;
	
	for vCategoryID, vOutfits in gOutfitter_Settings.Outfits do
		for vIndex, vOutfit in vOutfits do
			for vInventorySlot, vOutfitItem in vOutfit.Items do
				if vOutfitItem.Code ~= 0 then
					local	vItem = OutfitterItemList_FindItemOrAlt(vEquippableItems, vOutfitItem, false, true);
					
					if vItem then
						vOutfitItem.SubCode = vItem.SubCode;
						vOutfitItem.Name = vItem.Name;
						vOutfitItem.EnchantCode = vItem.EnchantCode;
						vOutfitItem.Checksum = nil;
					else
						vResult = false;
					end
				end
			end
		end
	end
	
	return vResult;
end

local	gOutfitter_PaperDollItemSlotButton_OnClick;

function Outfitter_HookPaperDollFrame()
	gOutfitter_PaperDollItemSlotButton_OnClick = PaperDollItemSlotButton_OnClick;
	PaperDollItemSlotButton_OnClick = Outfitter_PaperDollItemSlotButton_OnClick
end

local	Outfitter_cMaxNumQuickSlots = 9;
local	Outfitter_cSlotIDToInventorySlot = nil;

function Outfitter_PaperDollItemSlotButton_OnClick(pButton, pIgnoreModifiers)
	-- Build the table to convert from slot ID to inventory slot name
	
	if not Outfitter_cSlotIDToInventorySlot then
		Outfitter_cSlotIDToInventorySlot = {};
		
		for _, vInventorySlot in Outfitter_cSlotNames do
			local	vSlotID = GetInventorySlotInfo(vInventorySlot);
			
			Outfitter_cSlotIDToInventorySlot[vSlotID] = vInventorySlot;
		end
	end
	
	--
	
	local	vSlotID = this:GetID();
	local	vInventorySlot = Outfitter_cSlotIDToInventorySlot[vSlotID];
	local	vItemLink = GetInventoryItemLink("player", vSlotID);
	local	vSlotIsEmpty = vItemLink == nil;
	
	-- Call the original function
	
	gOutfitter_PaperDollItemSlotButton_OnClick(pButton, pIgnoreModifiers);
	
	-- If there's an item on the cursor then open the slots otherwise
	-- make sure they're closed
	
	if not OutfitterQuickSlots:IsVisible()
	and (CursorHasItem() or vSlotIsEmpty) then
		-- Hide the tooltip so that it isn't in the way
		
		GameTooltip:Hide();
		
		-- Open QuickSlots
		
		OutfitterQuickSlots_Open(vInventorySlot);
	else
		OutfitterQuickSlots_Close();
	end
end

function OutfitterItemList_AddItem(pItemList, pItem)
	-- Add the item to the code list

	local	vItemFamily = pItemList.ItemsByCode[pItem.Code];

	if not vItemFamily then
		vItemFamily = {};
		pItemList.ItemsByCode[pItem.Code] = vItemFamily;
	end
	
	table.insert(vItemFamily, pItem);
	
	-- Add the item to the slot list
	
	local	vItemSlot = pItemList.ItemsBySlot[pItem.ItemSlotName];
	
	if not vItemSlot then
		vItemSlot = {};
		pItemList.ItemsBySlot[pItem.ItemSlotName] = vItemSlot;
	end
	
	table.insert(vItemSlot, pItem);
	
	-- Add the item to the bags
	
	if pItem.Location.BagIndex then
		local	vBagItems = pItemList.BagItems[pItem.Location.BagIndex];
		
		if not vBagItems then
			vBagItems = {};
			pItemList.BagItems[pItem.Location.BagIndex] = vBagItems;
		end
		
		vBagItems[pItem.Location.BagSlotIndex] = pItem;
		
	-- Add the item to the inventory
	
	elseif pItem.Location.SlotName then
		pItemList.InventoryItems[pItem.Location.SlotName] = pItem;
	end
end

function Outfitter_GetNumBags()
	if gOutfitter_BankFrameOpened then
		return NUM_BAG_SLOTS + NUM_BANKBAGSLOTS, -1;
	else
		return NUM_BAG_SLOTS, 0;
	end
end

function OutfitterItemList_FlushEquippableItems()
	gOutfitter_EquippableItems = nil;
end

function OutfitterItemList_FlushBagFromEquippableItems(pBagIndex)
	if gOutfitter_EquippableItems
	and gOutfitter_EquippableItems.BagItems[pBagIndex] then
		for vBagSlotIndex, vItem in gOutfitter_EquippableItems.BagItems[pBagIndex] do
			OutfitterItemList_RemoveItem(gOutfitter_EquippableItems, vItem);
		end
		
		gOutfitter_EquippableItems.NeedsUpdate = true;
		gOutfitter_EquippableItems.BagItems[pBagIndex] = nil;
	end
end

function OutfitterItemList_FlushInventoryFromEquippableItems()
	if gOutfitter_EquippableItems then
		for vInventorySlot, vItem in gOutfitter_EquippableItems.InventoryItems do
			OutfitterItemList_RemoveItem(gOutfitter_EquippableItems, vItem);
		end
		
		gOutfitter_EquippableItems.NeedsUpdate = true;
		gOutfitter_EquippableItems.InventoryItems = nil;
	end
end

function OutfitterItemList_New()
	return {ItemsByCode = {}, ItemsBySlot = {}, InventoryItems = nil, BagItems = {}};
end

function OutfitterItemList_RemoveItem(pItemList, pItem)
	-- Remove the item from the code list
	
	local	vItems = pItemList.ItemsByCode[pItem.Code];
	
	for vIndex, vItem in vItems do
		if vItem == pItem then
			table.remove(vItems, vIndex);
			break;
		end
	end

	-- Remove the item from the slot list
	
	local	vItemSlot = pItemList.ItemsBySlot[pItem.ItemSlotName];
	
	if vItemSlot then
		for vIndex, vItem in vItemSlot do
			if vItem == pItem then
				table.remove(vItemSlot, vIndex);
				break;
			end
		end
	end
	
	-- Remove the item from the bags list
	
	if pItem.Location.BagIndex then
		local	vBagItems = pItemList.BagItems[pItem.Location.BagIndex];
		
		if vBagItems then
			vBagItems[pItem.Location.BagSlotIndex] = nil;
		end
		
	-- Remove the item from the inventory list
	
	elseif pItem.Location.SlotName then
		pItemList.InventoryItems[pItem.Location.SlotName] = nil;
	end
end

function OutfitterItemList_GetInventoryOutfit(pEquippableItems)
	return pEquippableItems.InventoryItems;
end

function OutfitterItemList_ResetIgnoreItemFlags(pItemList)
	for vItemCode, vItemFamily in pItemList.ItemsByCode do
		for _, vItem in vItemFamily do
			vItem.IgnoreItem = nil;
		end
	end
end

function OutfitterItemList_GetEquippableItems(pIncludeItemStats)
	-- If there's a cached copy just clear the IgnoreItem flags and return it
	-- (never used cached copy if the caller wants stats)
	
	if gOutfitter_EquippableItems
	and not gOutfitter_EquippableItems.NeedsUpdate
	and not pIncludeItemStats then
		OutfitterItemList_ResetIgnoreItemFlags(gOutfitter_EquippableItems);
		
		return gOutfitter_EquippableItems;
	end
	
	if not gOutfitter_EquippableItems
	or pIncludeItemStats then
		gOutfitter_EquippableItems = OutfitterItemList_New();
	end
	
	local	_, vPlayerClass = UnitClass("player");
	local	vStatDistribution = gOutfitter_StatDistribution[vPlayerClass];
	
	if not gOutfitter_EquippableItems.InventoryItems
	or pIncludeItemStats then
		gOutfitter_EquippableItems.InventoryItems = {};
		
		for _, vInventorySlot in Outfitter_cSlotNames do
			local	vItemInfo = Outfitter_GetInventoryItemInfo(vInventorySlot);
			
			if vItemInfo
			and vItemInfo.ItemSlotName
			and vItemInfo.Code ~= 0 then
				vItemInfo.SlotName = vInventorySlot;
				vItemInfo.Location = {SlotName = vInventorySlot};
				
				if pIncludeItemStats then	
					OutfitterItemList_GetItemStats(vItemInfo, vStatDistribution);
				end
				
				OutfitterItemList_AddItem(gOutfitter_EquippableItems, vItemInfo);
			end
		end
	else
		for vInventorySlot, vItem in gOutfitter_EquippableItems.InventoryItems do
			vItem.IgnoreItem = nil;
		end
	end
	
	local	vNumBags, vFirstBagIndex = Outfitter_GetNumBags();
	
	for vBagIndex = vFirstBagIndex, vNumBags do
		local		vBagItems = gOutfitter_EquippableItems.BagItems[vBagIndex];
		
		if not vBagItems
		or pIncludeItemStats then
			gOutfitter_EquippableItems.BagItems[vBagIndex] = {};
			
			local	vNumBagSlots = GetContainerNumSlots(vBagIndex);
			
			if vNumBagSlots > 0 then
				for vBagSlotIndex = 1, vNumBagSlots do
					local	vItemInfo = Outfitter_GetBagItemInfo(vBagIndex, vBagSlotIndex);
					
					if vItemInfo
					and vItemInfo.Code ~= 0
					and vItemInfo.ItemSlotName
					and Outfitter_CanEquipBagItem(vBagIndex, vBagSlotIndex)
					and not Outfitter_BagItemWillBind(vBagIndex, vBagSlotIndex) then
						vItemInfo.BagIndex = vBagIndex;
						vItemInfo.BagSlotIndex = vBagSlotIndex;
						vItemInfo.Location = {BagIndex = vBagIndex, BagSlotIndex = vBagSlotIndex};
						
						if pIncludeItemStats then	
							OutfitterItemList_GetItemStats(vItemInfo, vStatDistribution);
						end
						
						OutfitterItemList_AddItem(gOutfitter_EquippableItems, vItemInfo);
					end
				end -- for vBagSlotIndex
			end -- if vNumBagSlots > 0
		else -- if not BagItems
			for vBagSlotIndex, vItem in vBagItems do
				vItem.IgnoreItem = nil;
			end
		end -- if not BagItems
	end -- for vBagIndex
	
	gOutfitter_EquippableItems.NeedsUpdate = false;
	
	return gOutfitter_EquippableItems;
end

function OutfitterItemList_SwapLocations(pItemList, pLocation1, pLocation2)
	-- if pLocation1.BagIndex then
	-- 	Outfitter_TestMessage("OutfitterItemList_SwapLocations: Swapping bag "..pLocation1.BagIndex..", "..pLocation1.BagSlotIndex);
	-- elseif pLocation1.SlotName then
	-- 	Outfitter_TestMessage("OutfitterItemList_SwapLocations: Swapping slot "..pLocation1.SlotName);
	-- end
	-- if pLocation2.BagIndex then
	-- 	Outfitter_TestMessage("OutfitterItemList_SwapLocations: with bag "..pLocation2.BagIndex..", "..pLocation2.BagSlotIndex);
	-- elseif pLocation2.SlotName then
	-- 	Outfitter_TestMessage("OutfitterItemList_SwapLocations: with slot "..pLocation2.SlotName);
	-- end
end

function OutfitterItemList_SwapLocationWithInventorySlot(pItemList, pLocation, pSlotName)
	-- if pLocation.BagIndex then
	-- 	Outfitter_TestMessage("OutfitterItemList_SwapLocationWithInventorySlot: Swapping bag "..pLocation.BagIndex..", "..pLocation.BagSlotIndex.." with slot "..pSlotName);
	-- elseif pLocation.SlotName then
	-- 	Outfitter_TestMessage("OutfitterItemList_SwapLocationWithInventorySlot: Swapping slot "..pLocation.SlotName.." with slot "..pSlotName);
	-- end
end

function OutfitterItemList_SwapBagSlotWithInventorySlot(pItemList, pBagIndex, pBagSlotIndex, pSlotName)
	-- Outfitter_TestMessage("OutfitterItemList_SwapBagSlotWithInventorySlot: Swapping bag "..pBagIndex..", "..pBagSlotIndex.." with slot "..pSlotName);
end

function OutfitterItemList_FindItemOrAlt(pItemList, pOutfitItem, pMarkAsInUse, pAllowSubCodeWildcard)
	local	vItem, vIgnoredItem = OutfitterItemList_FindItem(pItemList, pOutfitItem, pMarkAsInUse, pAllowSubCodeWildcard);
	
	if vItem then
		return vItem;
	end
	
	-- See if there's an alias for the item if it wasn't found
	
	local	vAltCode = Outfitter_cItemAliases[pOutfitItem.Code];
	
	if not vAltCode then
		return nil, vIgnoredItem;
	end
	
	return OutfitterItemList_FindItem(pItemList, {Code = vAltCode}, pMarkAsInUse, true);
end

function OutfitterItemList_FindItem(pItemList, pOutfitItem, pMarkAsInUse, pAllowSubCodeWildcard)
	local	vItem, vIndex, vItemFamily, vIgnoredItem = OutfitterItemList_FindItemIndex(pItemList, pOutfitItem, pAllowSubCodeWildcard);
	
	if not vItem then
		return nil, vIgnoredItem;
	end
	
	if pMarkAsInUse then
		vItem.IgnoreItem = true;
	end
	
	return vItem;
end

function OutfitterItemList_FindAllItemsOrAlt(pItemList, pOutfitItem, pAllowSubCodeWildcard, rItems)
	local	vNumItems = OutfitterItemList_FindAllItems(pItemList, pOutfitItem, pAllowSubCodeWildcard, rItems);
	local	vAltCode = Outfitter_cItemAliases[pOutfitItem.Code];
	
	if vAltCode then
		vNumItems = vNumItems + OutfitterItemList_FindAllItems(pItemList, {Code = vAltCode}, true, rItems);
	end
	
	return vNumItems;
end

function OutfitterItemList_FindAllItems(pItemList, pOutfitItem, pAllowSubCodeWildcard, rItems)
	if not pItemList then
		return 0;
	end
	
	local	vItemFamily = pItemList.ItemsByCode[pOutfitItem.Code];
	
	if not vItemFamily then
		return 0;
	end
	
	local	vNumItemsFound = 0;
	
	for vIndex, vItem in vItemFamily do
		if (pAllowSubCodeWildcard and not pOutfitItem.SubCode)
		or vItem.SubCode == pOutfitItem.SubCode then
			table.insert(rItems, vItem);
			vNumItemsFound = vNumItemsFound + 1;
		end
	end
	
	return vNumItemsFound;
end

function OutfitterItemList_FindItemIndex(pItemList, pOutfitItem, pAllowSubCodeWildcard)
	if not pItemList then
		return nil, nil, nil, nil;
	end
	
	local	vItemFamily = pItemList.ItemsByCode[pOutfitItem.Code];
	
	if not vItemFamily then
		return nil, nil, nil, nil;
	end
	
	local	vBestMatch = nil;
	local	vBestMatchIndex = nil;
	local	vNumItemsFound = 0;
	local	vFoundIgnoredItem = nil;
	
	for vIndex, vItem in vItemFamily do
		if pAllowSubCodeWildcard
		and not pOutfitItem.SubCode then
			if vItem.IgnoreItem then
				vFoundIgnoredItem = vItem;
			else
				return vItem, vIndex, vItemFamily, nil;
			end
		
		--  If the subcode matches then check for an enchant match
		
		elseif vItem.SubCode == pOutfitItem.SubCode then
			-- If the enchant matches then we're all done
			
			if vItem.EnchantCode == pOutfitItem.EnchantCode then
				if vItem.IgnoreItem then
					vFoundIgnoredItem = vItem;
				else
					return vItem, vIndex, vItemFamily;
				end
			
			-- Otherwise save the match in case a better one can
			-- be found
			
			else
				if vItem.IgnoreItem then
					if not vFoundIgnoredItem then
						vFoundIgnoredItem = vItem;
					end
				else
					vBestMatch = vItem;
					vBestMatchIndex = vIndex;
					vNumItemsFound = vNumItemsFound + 1;
				end
			end
		end
	end
	
	-- Return the match if only one item was found
	
	if vNumItemsFound == 1
	and not vBestMatch.IgnoreItem then
		return vBestMatch, vBestMatchIndex, vItemFamily, nil;
	end
	
	return nil, nil, nil, vFoundIgnoredItem;
end
		
function OutfitterItemList_GetItemStats(pItem, pDistribution)
	if pItem.Stats then
		return pItem.Stats;
	end
	
	OutfitterTooltip:SetOwner(OutfitterFrame, "ANCHOR_BOTTOMRIGHT", 0, 0);
	
	if pItem.SlotName then
		local	vHasItem = OutfitterTooltip:SetInventoryItem("player", GetInventorySlotInfo(pItem.SlotName));
		
		if not vHasItem then
			OutfitterTooltip:Hide();
			return nil;
		end
	elseif pItem.BagIndex == -1 then
		OutfitterTooltip:SetInventoryItem("player", BankButtonIDToInvSlotID(pItem.BagSlotIndex));
	else
		OutfitterTooltip:SetBagItem(pItem.BagIndex, pItem.BagSlotIndex);
	end
	
	local	vStats = Outfitter_GetItemStatsFromTooltip(OutfitterTooltip, pDistribution);
	
	OutfitterTooltip:Hide();
	
	if not vStats then
		return nil;
	end
	
	pItem.Stats = vStats;
	
	return vStats;
end

function Outfitter_IsBankBagIndex(pBagIndex)
	return pBagIndex and (pBagIndex > NUM_BAG_SLOTS or pBagIndex < 0);
end

function OutfitterItemList_GetMissingItems(pEquippableItems, pOutfit)
	local	vMissingItems = nil;
	local	vBankedItems = nil;
	
	for vInventorySlot, vOutfitItem in pOutfit.Items do
		if vOutfitItem.Code ~= 0 then
			local	vItem = OutfitterItemList_FindItemOrAlt(pEquippableItems, vOutfitItem);
			
			if not vItem then
				if not vMissingItems then
					vMissingItems = {};
				end
				
				table.insert(vMissingItems, vOutfitItem);
			elseif Outfitter_IsBankBagIndex(vItem.Location.BagIndex) then
				if not vBankedItems then
					vBankedItems = {};
				end
				
				table.insert(vBankedItems, vOutfitItem);
			end
		end
	end
	
	return vMissingItems, vBankedItems;
end

function OutfitterItemList_CompiledUnusedItemsList(pEquippableItems)
	OutfitterItemList_ResetIgnoreItemFlags(pEquippableItems);
	
	for vCategoryID, vOutfits in gOutfitter_Settings.Outfits do
		for vOutfitIndex, vOutfit in vOutfits do
			for vInventorySlot, vOutfitItem in vOutfit.Items do
				if vOutfitItem.Code ~= 0 then
					local	vItem = OutfitterItemList_FindItemOrAlt(pEquippableItems, vOutfitItem, true);
					
					if vItem then
						vItem.UsedInOutfit = true;
					end
				end
			end
		end
	end
	
	local	vUnusedItems = nil;
	
	for vCode, vFamilyItems in pEquippableItems.ItemsByCode do
		for vIndex, vOutfitItem in vFamilyItems do
			if not vOutfitItem.UsedInOutfit
			and vOutfitItem.ItemSlotName ~= "AmmoSlot"
			and Outfitter_cIgnoredUnusedItems[vOutfitItem.Code] == nil then
				if not vUnusedItems then
					vUnusedItems = {};
				end
				
				table.insert(vUnusedItems, vOutfitItem);
			end
		end
	end
	
	pEquippableItems.UnusedItems = vUnusedItems;
end

function OutfitterItemList_ItemsAreSame(pEquippableItems, pItem1, pItem2)
	if not pItem1 then
		return pItem2 == nil;
	end
	
	if not pItem2 then
		return false;
	end
	
	if pItem1.Code == 0 then
		return pItem2.Code == 0;
	end
	
	if pItem1.Code ~= pItem2.Code
	or pItem1.SubCode ~= pItem2.SubCode then
		return false;
	end
	
	local	vItems = {};
	local	vNumItems = OutfitterItemList_FindAllItemsOrAlt(pEquippableItems, pItem1, nil, vItems);
	
	if vNumItems == 0 then
		-- Shouldn't ever get here
		
		Outfitter_ErrorMessage("OutfitterItemList_ItemsAreSame: Item not found");
		return false;
	elseif vNumItems == 1 then
		-- If there's only one of that item then the enchant code
		-- is disregarded so just make sure it's the same
		
		return true;
	else
		return pItem1.EnchantCode == pItem2.EnchantCode;
	end
end

function OutfitterItemList_InventorySlotContainsItem(pEquippableItems, pInventorySlot, pOutfitItem)
	-- Nil items are supposed to be ignored, so never claim the slot contains them
	
	if pOutfitItem == nil then
		return false, nil;
	end
	
	-- If the item specifies and empty slot check to see if the slot is actually empty
	
	if pOutfitItem.Code == 0 then
		return pEquippableItems.InventoryItems[pInventorySlot] == nil;
	end
	
	local	vItems = {};
	local	vNumItems = OutfitterItemList_FindAllItemsOrAlt(pEquippableItems, pOutfitItem, nil, vItems);
	
	if vNumItems == 0 then
		return false;
	elseif vNumItems == 1 then
		-- If there's only one of that item then the enchant code
		-- is disregarded so just make sure it's in the slot
		
		return vItems[1].SlotName == pInventorySlot, vItems[1];
	else
		-- See if one of the items is in the slot
		
		for vIndex, vItem in vItems do
			if vItem.SlotName == pInventorySlot then
				-- Must match the enchant code if there are multiple items
				-- in order to be considered a perfect match
				
				return vItem.EnchantCode == pOutfitItem.EnchantCode, vItem;
			end
		end
		
		-- No items in the slot
		
		return false, nil;
	end
end

function OutfitterQuickSlots_Open(pSlotName)
	local	vPaperDollSlotName = "Character"..pSlotName;
	
	-- Hide the tooltip so that it isn't in the way
	
	GameTooltip:Hide();
	
	-- Position the window
	
	if pSlotName == "MainHandSlot"
	or pSlotName == "SecondaryHandSlot"
	or pSlotName == "RangedSlot"
	or pSlotName == "AmmoSlot" then
		OutfitterQuickSlots:SetPoint("TOPLEFT", vPaperDollSlotName, "BOTTOMLEFT", 0, 0);
	else
		OutfitterQuickSlots:SetPoint("TOPLEFT", vPaperDollSlotName, "TOPRIGHT", 5, 6);
	end
	
	OutfitterQuickSlots.SlotName = pSlotName;
	
	-- Populate the items
	
	local	vItems = Outfitter_FindItemsInBagsForSlot(pSlotName);
	local	vNumSlots = 0;
	
	if vItems then
		for vItemInfoIndex, vItemInfo in vItems do
			if vNumSlots >= Outfitter_cMaxNumQuickSlots then
				break;
			end
			
			vNumSlots = vNumSlots + 1;
			OutfitterQuickSlots_SetSlotToBag(vNumSlots, vItemInfo.BagIndex, vItemInfo.BagSlotIndex);
		end
	end
	
	-- If the slot isn't empty, offer an empty slot to put the item in
	
	if vNumSlots < Outfitter_cMaxNumQuickSlots
	and not Outfitter_InventorySlotIsEmpty(pSlotName) then
		local	vBagSlotInfo = Outfitter_GetEmptyBagSlot();
		
		if vBagSlotInfo then
			vNumSlots = vNumSlots + 1;
			OutfitterQuickSlots_SetSlotToBag(vNumSlots, vBagSlotInfo.BagIndex, vBagSlotInfo.BagSlotIndex);
		end
	end
	
	-- Resize the window and show it
	
	OutfitterQuickSlots_SetNumSlots(vNumSlots);
	
	if vNumSlots == 0 then
		OutfitterQuickSlots:Hide();
	else
		OutfitterQuickSlots:Show();
	end
end

function OutfitterQuickSlots_Close()
	OutfitterQuickSlots:Hide();
end

function OutfitterQuickSlots_OnLoad()
	table.insert(UIMenus, this:GetName());
end

function OutfitterQuickSlots_OnShow()
end

function OutfitterQuickSlots_OnHide()
end

function OutfitterQuickSlots_OnEvent(pEvent)
end

function OutfitterQuickSlotItem_OnLoad()
	this.size = 1; -- one-slot container
end

function OutfitterQuickSlotItem_OnShow()
	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("BAG_UPDATE_COOLDOWN");
	this:RegisterEvent("ITEM_LOCK_CHANGED");
	this:RegisterEvent("UPDATE_INVENTORY_ALERTS");
end

function OutfitterQuickSlotItem_OnHide()
	this:UnregisterEvent("BAG_UPDATE");
	this:UnregisterEvent("BAG_UPDATE_COOLDOWN");
	this:UnregisterEvent("ITEM_LOCK_CHANGED");
	this:UnregisterEvent("UPDATE_INVENTORY_ALERTS");
end

function OutfitterQuickSlotItemButton_OnEnter(button)
	GameTooltip:SetOwner(button, "ANCHOR_RIGHT");
	
	local	vBagIndex = button:GetParent():GetID();
	local	vBagSlotIndex = button:GetID();
	
	local	hasItem, hasCooldown, repairCost;
	
	if vBagIndex == -1 then
		hasItem, hasCooldown, repairCost = GameTooltip:SetInventoryItem("player", BankButtonIDToInvSlotID(vBagSlotIndex));
	else
		hasCooldown, repairCost = GameTooltip:SetBagItem(vBagIndex, vBagSlotIndex);
	end
	
	if ( InRepairMode() and (repairCost and repairCost > 0) ) then
		GameTooltip:AddLine(TEXT(REPAIR_COST), "", 1, 1, 1);
		SetTooltipMoney(GameTooltip, repairCost);
		GameTooltip:Show();
	elseif ( this.readable or (IsControlKeyDown() and button.hasItem) ) then
		ShowInspectCursor();
	elseif ( MerchantFrame:IsVisible() and MerchantFrame.selectedTab == 1 ) then
		ShowContainerSellCursor(button:GetParent():GetID(),button:GetID());
	else
		ResetCursor();
	end
end

function OutfitterQuickSlots_SetNumSlots(pNumSlots)
	if pNumSlots > Outfitter_cMaxNumQuickSlots then
		pNumSlots = Outfitter_cMaxNumQuickSlots;
	end
	
	local	vBaseWidth = 11;
	local	vSlotWidth = 42;
	
	for vIndex = 1, pNumSlots do
		local	vSlotItem = getglobal("OutfitterQuickSlotsItem"..vIndex);
		
		vSlotItem:ClearAllPoints();
		
		if vIndex == 1 then
			vSlotItem:SetPoint("TOPLEFT", "OutfitterQuickSlots", "TOPLEFT", 6, -6);
		else
			vSlotItem:SetPoint("TOPLEFT", "OutfitterQuickSlotsItem"..(vIndex - 1), "TOPLEFT", vSlotWidth, 0);
		end
		
		vSlotItem:Show();
	end
	
	-- Hide the unused slots
	
	for vIndex = pNumSlots + 1, Outfitter_cMaxNumQuickSlots do
		local	vSlotItem = getglobal("OutfitterQuickSlotsItem"..vIndex);
		
		vSlotItem:Hide();
	end
	
	-- Size the frame
	
	OutfitterQuickSlots:SetWidth(vBaseWidth + vSlotWidth * pNumSlots);
	
	-- Fix the background
	
	if pNumSlots > 0 then
		for vIndex = 1, pNumSlots - 1 do
			getglobal("OutfitterQuickSlotsBack"..vIndex):Show();
		end
		
		for vIndex = pNumSlots, Outfitter_cMaxNumQuickSlots - 1 do
			getglobal("OutfitterQuickSlotsBack"..vIndex):Hide();
		end
		
		OutfitterQuickSlotsBackEnd:SetPoint("LEFT", "OutfitterQuickSlotsBack"..(pNumSlots - 1), "RIGHT", 0, 0);
	end
end

function OutfitterQuickSlots_SetSlotToBag(pQuickSlotIndex, pBagIndex, pBagSlotIndex)
	local	vQuickSlotItem = getglobal("OutfitterQuickSlotsItem"..pQuickSlotIndex);
	local	vQuickSlotItemButton = getglobal("OutfitterQuickSlotsItem"..pQuickSlotIndex.."Item1");
	
	vQuickSlotItem:SetID(pBagIndex);
	vQuickSlotItemButton:SetID(pBagSlotIndex);
	
	ContainerFrame_Update(vQuickSlotItem);
end

function Outfitter_RegisterEvent(pFrame, pEvent, pHandler)
	if not pFrame.EventHandlers then
		pFrame.EventHandlers = {};
	end
	
	pFrame.EventHandlers[pEvent] = pHandler;
	pFrame:RegisterEvent(pEvent);
end

function Outfitter_UnregisterEvent(pFrame, pEvent)
	if pFrame.EventHandlers then
		pFrame.EventHandlers[pEvent] = nil;
	end
	
	pFrame:UnregisterEvent(pEvent);
end

function Outfitter_SuspendEvent(pFrame, pEvent)
	if not pFrame.EventHandlers
	or not pFrame.EventHandlers[pEvent] then
		return;
	end

	pFrame:UnregisterEvent(pEvent);
end

function Outfitter_ResumeEvent(pFrame, pEvent)
	if not pFrame.EventHandlers
	or not pFrame.EventHandlers[pEvent] then
		return;
	end

	pFrame:RegisterEvent(pEvent);
end

function Outfitter_DispatchEvent(pFrame, pEvent)
	if not pFrame.EventHandlers then	
		return false;
	end
	
	local	vEventHandler = pFrame.EventHandlers[pEvent];
	
	if not vEventHandler then
		return false;
	end
	
	Outfitter_BeginEquipmentUpdate();
	vEventHandler(pEvent);
	Outfitter_EndEquipmentUpdate("Outfitter_DispatchEvent("..pEvent..")");
	
	return true;
end

function Outfitter_GetPlayerStat(pStatIndex)
	local	_, vEffectiveValue, vPosValue, vNegValue = UnitStat("player", pStatIndex);
	
	return vEffectiveValue - vPosValue - vNegValue, vPosValue + vNegValue;
end

function Outfitter_DepositOutfit(pOutfit, pUniqueItemsOnly)
	-- Deselect any outfits to avoid them from being updated when
	-- items get put away
	
	Outfitter_ClearSelection();
	
	-- Build a list of items for the outfit
	
	local	vEquippableItems = OutfitterItemList_GetEquippableItems();
	
	OutfitterItemList_ResetIgnoreItemFlags(vEquippableItems);
	
	-- Make a copy of the outfit
	
	local	vUnequipOutfit = Outfitter_NewEmptyOutfit();
	
	for vInventorySlot, vItem in pOutfit.Items do
		vUnequipOutfit.Items[vInventorySlot] = vItem;
	end
	
	-- Subtract out items from other outfits if unique is specified
	
	if pUniqueItemsOnly then
		for vCategoryID, vOutfits in gOutfitter_Settings.Outfits do
			for vOutfitIndex, vOutfit in vOutfits do
				if vOutfit ~= pOutfit then
					local	vMissingItems, vBankedItems = OutfitterItemList_GetMissingItems(vEquippableItems, vOutfit);
					
					-- Only subtract out items from outfits which aren't themselves partialy banked
					
					if vBankedItems == nil then
						Outfitter_SubtractOutfit(vUnequipOutfit, vOutfit, true);
					end
				end -- if vOutfit
			end -- for vOutfitIndex
		end -- for vCategoryID
	end -- if pUniqueItemsOnly
	
	-- Build the change list
	
	OutfitterItemList_ResetIgnoreItemFlags(vEquippableItems);
	
	local	vEquipmentChangeList = Outfitter_BuildUnequipChangeList(vUnequipOutfit, vEquippableItems);
	
	if not vEquipmentChangeList then
		return;
	end
	
	-- Eliminate items which are already banked
	
	local	vChangeIndex = 1;
	local	vNumChanges = table.getn(vEquipmentChangeList);
	
	while vChangeIndex <= vNumChanges do
		vEquipmentChange = vEquipmentChangeList[vChangeIndex];
		
		if Outfitter_IsBankBagIndex(vEquipmentChange.FromLocation.BagIndex) then
			table.remove(vEquipmentChangeList, vChangeIndex);
			vNumChanges = vNumChanges - 1;
		else
			vChangeIndex = vChangeIndex + 1;
		end
	end
	
	-- Get the list of empty bank slots
	
	local	vEmptyBankSlots = Outfitter_GetEmptyBankSlotList();
	
	-- Execute the changes
	
	Outfitter_ExecuteEquipmentChangeList2(vEquipmentChangeList, vEmptyBankSlots, Outfitter_cDepositBagsFullError, vExpectedEquippableItems);
end

function Outfitter_WithdrawOutfit(pOutfit)
	local	vEquippableItems = OutfitterItemList_GetEquippableItems();
	
	-- Build a list of items for the outfit
	
	OutfitterItemList_ResetIgnoreItemFlags(vEquippableItems);
	
	local	vEquipmentChangeList = Outfitter_BuildUnequipChangeList(pOutfit, vEquippableItems);
	
	if not vEquipmentChangeList then
		return;
	end
	
	-- Eliminate items which aren't in the bank
	
	local	vChangeIndex = 1;
	local	vNumChanges = table.getn(vEquipmentChangeList);
	
	while vChangeIndex <= vNumChanges do
		vEquipmentChange = vEquipmentChangeList[vChangeIndex];
		
		if not Outfitter_IsBankBagIndex(vEquipmentChange.FromLocation.BagIndex) then
			table.remove(vEquipmentChangeList, vChangeIndex);
			vNumChanges = vNumChanges - 1;
		else
			vChangeIndex = vChangeIndex + 1;
		end
	end
	
	-- Get the list of empty bag slots

	local	vEmptyBagSlots = Outfitter_GetEmptyBagSlotList();
	
	-- Execute the changes
	
	Outfitter_ExecuteEquipmentChangeList2(vEquipmentChangeList, vEmptyBagSlots, Outfitter_cWithdrawBagsFullError, vExpectedEquippableItems);
end

function Outfitter_TestOutfitCombinations()
	local	vEquippableItems = OutfitterItemList_GetEquippableItems(true);
	local	vFilterStats = {["FireResist"] = true};
	local	vOutfit = Outfitter_FindOutfitCombination(vEquippableItems, vFilterStats, Outfitter_OutfitTestEval, {});
end

function Outfitter_OutfitTestEval(pOpcode, pParams, pOutfit1, pOutfit2)
	if pOpcode == "INIT" then
		Outfitter_TestMessage("Outfitter_OutfitTestEval: INIT");
	elseif pOpcode == "COMPARE" then
		Outfitter_TestMessage("Outfitter_OutfitTestEval: COMPARE");
	end
end

function Outfitter_FindOutfitCombination(pEquippableItems, pFilterStats, pOutfitEvalFunc, pOutfitEvalParams)
	local	vSlotIterators = OutfitterSlotIterators_New(pEquippableItems, pFilterStats);
	
	Outfitter_DumpArray("vSlotIterators", vSlotIterators);
	
	local	vBestOutfit = nil;
	local	vNumIterations = 0;
	
	pOutfitEvalFunc("INIT", pOutfitEvalParams);
	
	while vSlotIterators:Increment() do
		local	vOutfit = vSlotIterators:GetOutfit();
		
		if pOutfitEvalFunc("COMPARE", pOutfitEvalParams, vBestOutfit, vOutfit) then
			vBestOutfit = vOutfit;
		end
		
		vNumIterations = vNumIterations + 1;
		
		if vNumIterations > 20 then
			return vBestOutfit;
		end
	end
	
	return vBestOutfit;
end

function Outfitter_ItemContainsStats(pItem, pFilterStats)
	for vStatID, _ in pFilterStats do
		if pItem.Stats[vStatID] then
			return true;
		end
	end
	
	return false;
end

function OutfitterSlotIterators_New(pEquippableItems, pFilterStats)
	local	vSlotIterators = {Slots = {}};
	local	vNumCombinations = 1;
	
	for vInventorySlot, vItems in pEquippableItems.ItemsBySlot do
		local	vNumItems = table.getn(vItems);
		
		if vInventorySlot ~= "AmmoSlot"
		and vNumItems > 0 then
			-- Filter the items by stat
			
			local	vFilteredItems = nil;
			
			if pFilterStats then
				vNumItems = 0;
				
				for vItemIndex, vItem in vItems do
					if Outfitter_ItemContainsStats(vItem, pFilterStats) then
						if not vFilteredItems then
							vFilteredItems = {};
						end
						
						table.insert(vFilteredItems, vItem);
						vNumItems = vNumItems + 1;
					end
				end
			else
				vFilteredItems = vItems;
			end
			
			-- Add the filtered list
			
			if vFilteredItems then
				table.insert(vSlotIterators.Slots, {ItemSlotName = vInventorySlot, Items = vItems, Index = 0, MaxIndex = vNumItems});
				
				vNumCombinations = vNumCombinations * (vNumItems + 1);
				
				Outfitter_TestMessage("OutfitterSlotIterators_New: "..vInventorySlot.." has "..vNumItems.." items. Combinations "..vNumCombinations);
			end
		end
	end
	
	vSlotIterators.Increment = OutfitterSlotIterators_Increment;
	vSlotIterators.GetOutfit = OutfitterSlotIterators_GetOutfit;
	vSlotIterators.NumCombinations = vNumCombinations;
	
	Outfitter_TestMessage("OutfitterSlotIterators_New: Total combinations "..vNumCombinations);
	
	return vSlotIterators;
end

function OutfitterSlotIterators_Increment(pSlotIterators)
	for vSlotIndex, vSlotIterator in pSlotIterators.Slots do
		vSlotIterator.Index = vSlotIterator.Index + 1;
		
		if vSlotIterator.Index <= vSlotIterator.MaxIndex then
			return true;
		end
		
		vSlotIterator.Index = 0;
	end
	
	return false; -- Couldn't increment
end

function OutfitterSlotIterators_GetOutfit(pSlotIterators)
	local	vOutfit = Outfitter_NewEmptyOutfit();

	for _, vItems in pSlotIterators.Slots do
		-- if vItems.Index > 0 then
		-- 	local	vItem = vItems.Items[vItems.Index];
		-- 	
		-- 	Outfitter_AddOutfitItem(vOutfit, vItems.ItemSlotName, vItem.Code, vItem.SubCode, vItem.Name, vItem.EnchantCode);
		-- end
	end
	
	return vOutfit;
end

function OutfitterStats_AddStatValue(pStats, pStat, pValue, pDistribution)
	if not pStats[pStat] then
		pStats[pStat] = pValue;
	else
		pStats[pStat] = pStats[pStat] + pValue;
	end
	
	if not pDistribution then
		return;
	end
	
	local	vStatDistribution = pDistribution[pStat];
	
	if not vStatDistribution then
		return;
	end
	
	for vSecondaryStat, vFactors in vStatDistribution do
		local	vSecondaryValue = pValue * vFactors.Coeff;
		
		if vFactors.Const then
			vSecondaryValue = vSecondaryValue + vFactors.Const;
		end
		
		if pStats[vSecondaryStat] then
			pStats[vSecondaryStat] = pStats[vSecondaryStat] + vSecondaryValue;
		else
			pStats[vSecondaryStat] = vSecondaryValue;
		end
	end
end

function OutfitterStats_SubtractStats(pStats, pStats2)
	for vStat, vValue in pStats2 do
		if pStats[vStat] then
			pStats[vStat] = pStats[vStat] - vValue;
		end
	end
end

function OutfitterStats_AddStats(pStats, pStats2)
	for vStat, vValue in pStats2 do
		if pStats[vStat] then
			pStats[vStat] = pStats[vStat] + vValue;
		else
			pStats[vStat] = vValue;
		end
	end
end

function OutfitterTankPoints_New()
	local	vTankPointData = {};
	local	_, vPlayerClass = UnitClass("player");
	local	vStatDistribution = gOutfitter_StatDistribution[vPlayerClass];
	
	if not vStatDistribution then
		Outfitter_ErrorMessage("Outfitter: Missing stat distribution data for "..vPlayerClass);
	end
	
	vTankPointData.PlayerLevel = UnitLevel("player");
	vTankPointData.StaminaFactor = 1.0; -- Warlocks with demonic embrace = 1.15
	
	-- Get the base stats
	
	vTankPointData.BaseStats = {};
	
	OutfitterStats_AddStatValue(vTankPointData.BaseStats, "Strength", UnitStat("player", 1), vStatDistribution);
	OutfitterStats_AddStatValue(vTankPointData.BaseStats, "Agility", UnitStat("player", 2), vStatDistribution);
	OutfitterStats_AddStatValue(vTankPointData.BaseStats, "Stamina", UnitStat("player", 3), vStatDistribution);
	OutfitterStats_AddStatValue(vTankPointData.BaseStats, "Intellect", UnitStat("player", 4), vStatDistribution);
	OutfitterStats_AddStatValue(vTankPointData.BaseStats, "Spirit", UnitStat("player", 5), vStatDistribution);
	
	OutfitterStats_AddStatValue(vTankPointData.BaseStats, "Health", UnitHealthMax("player"), vStatDistribution);
	
	vTankPointData.BaseStats.Health = vTankPointData.BaseStats.Health - vTankPointData.BaseStats.Stamina * 10;
	
	vTankPointData.BaseStats.Dodge = GetDodgeChance();
	vTankPointData.BaseStats.Parry = GetParryChance();
	vTankPointData.BaseStats.Block = GetBlockChance();
	
	local	vBaseDefense, vBuffDefense = UnitDefense("player");
	OutfitterStats_AddStatValue(vTankPointData.BaseStats, "Defense", vBaseDefense + vBuffDefense, vStatDistribution);
	
	-- Replace the armor with the current value since that already includes various factors
	
	local	vBaseArmor, vEffectiveArmor, vArmor, vArmorPosBuff, vArmorNegBuff = UnitArmor("player");
	vTankPointData.BaseStats.Armor = vEffectiveArmor;
	
	Outfitter_TestMessage("------------------------------------------");
	Outfitter_DumpArray("vTankPointData", vTankPointData);
	
	-- Subtract out the current outfit
	
	local	vCurrentOutfitStats = OutfitterTankPoints_GetCurrentOutfitStats(vStatDistribution);
	
	Outfitter_TestMessage("------------------------------------------");
	Outfitter_DumpArray("vCurrentOutfitStats", vCurrentOutfitStats);
	
	OutfitterStats_SubtractStats(vTankPointData.BaseStats, vCurrentOutfitStats);
	
	-- Calculate the buff stats (stuff from auras/spell buffs/whatever)
	
	vTankPointData.BuffStats = {};
	
	-- Reset the cumulative values
	
	OutfitterTankPoints_Reset(vTankPointData);
	
	Outfitter_TestMessage("------------------------------------------");
	Outfitter_DumpArray("vTankPointData", vTankPointData);
	
	Outfitter_TestMessage("------------------------------------------");
	return vTankPointData;
end

function OutfitterTankPoints_Reset(pTankPointData)
	pTankPointData.AdditionalStats = {};
end

function OutfitterTankPoints_GetTotalStat(pTankPointData, pStat)
	local	vTotalStat = pTankPointData.BaseStats[pStat];
	
	if not vTotalStat then
		vTotalStat = 0;
	end
	
	local	vAdditionalStat = pTankPointData.AdditionalStats[pStat];
	
	if vAdditionalStat then
		vTotalStat = vTotalStat + vAdditionalStat;
	end
	
	local	vBuffStat = pTankPointData.BuffStats[pStat];
	
	if vBuffStat then
		vTotalStat = vTotalStat + vBuffStat;
	end
	
	--
	
	return vTotalStat;
end

function OutfitterTankPoints_CalcTankPoints(pTankPointData, pStanceModifier)
	if not pStanceModifier then
		pStanceModifier = 1;
	end
	
	Outfitter_DumpArray("pTankPointData", pTankPointData);
	
	local	vEffectiveArmor = OutfitterTankPoints_GetTotalStat(pTankPointData, "Armor");

	Outfitter_TestMessage("Armor: "..vEffectiveArmor);
	
	local	vArmorReduction = vEffectiveArmor / ((85 * pTankPointData.PlayerLevel) + 400);
	
	vArmorReduction = vArmorReduction / (vArmorReduction + 1);
	
	local	vEffectiveHealth = OutfitterTankPoints_GetTotalStat(pTankPointData, "Health");
	
	Outfitter_TestMessage("Health: "..vEffectiveHealth);
	
	Outfitter_TestMessage("Stamina: "..OutfitterTankPoints_GetTotalStat(pTankPointData, "Stamina"));
	
	--
	
	local	vEffectiveDodge = OutfitterTankPoints_GetTotalStat(pTankPointData, "Dodge") * 0.01;
	local	vEffectiveParry = OutfitterTankPoints_GetTotalStat(pTankPointData, "Parry") * 0.01;
	local	vEffectiveBlock = OutfitterTankPoints_GetTotalStat(pTankPointData, "Block") * 0.01;
	local	vEffectiveDefense = OutfitterTankPoints_GetTotalStat(pTankPointData, "Defense");
	
	-- Add agility and defense to dodge
	
	-- defenseInputBox:GetNumber() * 0.04 + agiInputBox:GetNumber() * 0.05

	Outfitter_TestMessage("Dodge: "..vEffectiveDodge);
	Outfitter_TestMessage("Parry: "..vEffectiveParry);
	Outfitter_TestMessage("Block: "..vEffectiveBlock);
	Outfitter_TestMessage("Defense: "..vEffectiveDefense);
	
	local	vDefenseModifier = (vEffectiveDefense - pTankPointData.PlayerLevel * 5) * 0.04 * 0.01;
	
	Outfitter_TestMessage("Crit reduction: "..vDefenseModifier);
	
	local	vMobCrit = max(0, 0.05 - vDefenseModifier);
	local	vMobMiss = 0.05 + vDefenseModifier;
	local	vMobDPS = 1;
	
	local	vTotalReduction = 1 - (vMobCrit * 2 + (1 - vMobCrit - vMobMiss - vEffectiveDodge - vEffectiveParry)) * (1 - vArmorReduction) * pStanceModifier;
	
	Outfitter_TestMessage("Total reduction: "..vTotalReduction);
	
	local	vTankPoints = vEffectiveHealth / (vMobDPS * (1 - vTotalReduction));
	
	return vTankPoints;
	
	--[[
	Stats used in TankPoints calculation:
		Health
		Dodge
		Parry
		Block
		Defense
		Armor
	]]--
end

function OutfitterTankPoints_GetCurrentOutfitStats(pStatDistribution)
	local	vTotalStats = {};
	
	for _, vSlotName in Outfitter_cSlotNames do
		local	vStats = OutfitterItemList_GetItemStats({SlotName = vSlotName});
		
		if vStats then
			for vStat, vValue in vStats do
				OutfitterStats_AddStatValue(vTotalStats, vStat, vValue, pStatDistribution);
			end
		end
	end
	
	return vTotalStats;
end

function OutfitterTankPoints_Test()
	local	_, vPlayerClass = UnitClass("player");
	local	vStatDistribution = gOutfitter_StatDistribution[vPlayerClass];
	
	local	vTankPointData = OutfitterTankPoints_New();
	local	vStats = OutfitterTankPoints_GetCurrentOutfitStats(vStatDistribution);
	
	OutfitterStats_AddStats(vTankPointData.AdditionalStats, vStats);
	
	local	vTankPoints = OutfitterTankPoints_CalcTankPoints(vTankPointData);
	
	Outfitter_TestMessage("TankPoints = "..vTankPoints);
end

function Outfitter_TestAmmoSlot()
	local	vItemInfo = Outfitter_GetInventoryItemInfo("AmmoSlot");
	local	vSlotID = GetInventorySlotInfo("AmmoSlot");
	local	vItemLink = GetInventoryItemLink("player", vSlotID);
	
	Outfitter_TestMessage("SlotID: "..vSlotID);
	Outfitter_TestMessage("ItemLink: "..vItemLink);
	
	Outfitter_DumpArray("vItemInfo", vItemInfo);
end
