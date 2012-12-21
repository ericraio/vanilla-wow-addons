Outfitter_cVersion = "1.4";

Outfitter_cTitle = "Outfitter";
Outfitter_cTitleVersion = Outfitter_cTitle.." "..Outfitter_cVersion;

Outfitter_cNameLabel = "Name:";
Outfitter_cCreateUsingTitle = "Optimize for:";
Outfitter_cUseCurrentOutfit = "Use Current Outfit";
Outfitter_cUseEmptyOutfit = "Create Empty Outfit";

Outfitter_cOutfitterTabTitle = "Outfitter";
Outfitter_cOptionsTabTitle = "Options";
Outfitter_cAboutTabTitle = "About";

Outfitter_cNewOutfit = "New Outfit";
Outfitter_cRenameOutfit = "Rename Outfit";

Outfitter_cCompleteOutfits = "Complete wardrobes";
Outfitter_cPartialOutfits = "Mix-n-match";
Outfitter_cAccessoryOutfits = "Accessories";
Outfitter_cSpecialOutfits = "Special occassions";
Outfitter_cOddsNEndsOutfits = "Odds 'n ends";

Outfitter_cNormalOutfit = "Normal";
Outfitter_cNakedOutfit = "Birthday Suit";

Outfitter_cFishingOutfit = "Fishing";
Outfitter_cHerbalismOutfit = "Herbalism";
Outfitter_cMiningOutfit = "Mining";
Outfitter_cSkinningOutfit = "Skinning";
Outfitter_cFireResistOutfit = "Fire Resist";
Outfitter_cNatureResistOutfit = "Nature Resist";
Outfitter_cShadowResistOutfit = "Shadow Resist";
Outfitter_cArcaneResistOutfit = "Arcane Resist";
Outfitter_cFrostResistOutfit = "Frost Resist";

Outfitter_cArgentDawnOutfit = "Argent Dawn";
Outfitter_cRidingOutfit = "Riding";
Outfitter_cDiningOutfit = "Dining";
Outfitter_cBattlegroundOutfit = "Battleground";
Outfitter_cABOutfit = "Battleground: Arathi Basin";
Outfitter_cAVOutfit = "Battleground: Alterac Valley";
Outfitter_cWSGOutfit = "Battleground: Warsong Gulch";
Outfitter_cCityOutfit = "Around Town";

Outfitter_cMountSpeedFormat = "Increases speed by (%d+)%%."; -- For detecting when mounted

Outfitter_cBagsFullError = "Outfitter: Can't remove %s because all bags are full";
Outfitter_cDepositBagsFullError = "Outfitter: Can't deposit %s because all bank bags are full";
Outfitter_cWithdrawBagsFullError = "Outfitter: Can't withdraw %s because all bags are full";
Outfitter_cItemNotFoundError = "Outfitter: Can't find item %s";
Outfitter_cItemAlreadyUsedError = "Outfitter: Can't put %s in the %s slot because it's already being used in another slot";
Outfitter_cAddingItem = "Outfitter: Adding %s to %s outfit";
Outfitter_cNameAlreadyUsedError = "Error: That name is already being used";
Outfitter_cNoItemsWithStatError = "Warning: None of your items have that attribute";

Outfitter_cEnableAll = "Enable all";
Outfitter_cEnableNone = "Enable none";

Outfitter_cConfirmDeleteMsg = "Are you sure you want to delete the outfit %s?";
Outfitter_cConfirmRebuildMsg = "Are you sure you want to rebuild the outfit %s?";
Outfitter_cRebuild = "Rebuild";

Outfitter_cWesternPlaguelands = "Western Plaguelands";
Outfitter_cEasternPlaguelands = "Eastern Plaguelands";
Outfitter_cStratholme = "Stratholme";
Outfitter_cScholomance = "Scholomance";
Outfitter_cNaxxramas = "Naxxramas";
Outfitter_cAlteracValley = "Alterac Valley";
Outfitter_cArathiBasin = "Arathi Basin";
Outfitter_cWarsongGulch = "Warsong Gulch";
Outfitter_cIronforge = "Ironforge";
Outfitter_cCityOfIronforge = "City of Ironforge";
Outfitter_cDarnassus = "Darnassus";
Outfitter_cStormwind = "Stormwind City";
Outfitter_cOrgrimmar = "Orgrimmar";
Outfitter_cThunderBluff = "Thunder Bluff";
Outfitter_cUndercity = "Undercity";

Outfitter_cFishingPole = "Fishing Pole";
Outfitter_cStrongFishingPole = "Strong Fishing Pole";
Outfitter_cBigIronFishingPole = "Big Iron Fishing Pole";
Outfitter_cBlumpFishingPole = "Blump Family Fishing Pole";
Outfitter_cNatPaglesFishingPole = "Nat Pagle's Extreme Angler FC-5000";
Outfitter_cArcaniteFishingPole = "Arcanite Fishing Pole";

Outfitter_cArgentDawnCommission = "Argent Dawn Commission";
Outfitter_cSealOfTheDawn = "Seal of the Dawn";
Outfitter_cRuneOfTheDawn = "Rune of the Dawn";

Outfitter_cCarrotOnAStick = "Carrot on a Stick";

Outfitter_cItemStatFormats =
{
	{Format = "Stamina %+(%d+)", Types = {"Stamina"}},
	{Format = "Intellect %+(%d+)", Types = {"Intellect"}},
	{Format = "Agility %+(%d+)", Types = {"Agility"}},
	{Format = "Strength %+(%d+)", Types = {"Strength"}},
	{Format = "Spirit %+(%d+)", Types = {"Spirit"}},
	{Format = "Armor %+(%d+)", Types = {"Armor"}},
	{Format = "Defense %+(%d+)", Types = {"Defense"}},
	{Format = "Increased Defense %+(%d+)", Types = {"Defense"}},
	
	{Format = "%+(%d+) Stamina", Types = {"Stamina"}},
	{Format = "%+(%d+) Intellect", Types = {"Intellect"}},
	{Format = "%+(%d+) Agility", Types = {"Agility"}},
	{Format = "%+(%d+) Strength", Types = {"Strength"}},
	{Format = "%+(%d+) Spirit", Types = {"Spirit"}},
	{Format = "(%d+) Armor", Types = {"Armor"}},
	{Format = "%+(%d+) Attack Power", Types = {"Attack"}},
	
	{Format = "All Stats %+(%d+)", Types = {"Stamina", "Intellect", "Agility", "Strength", "Spirit"}},
	
	{Format = "Mana %+(%d+)", Types = {"Mana"}},
	{Format = "Health %+(%d+)", Types = {"Health"}},
	
	{Format = "%+(%d+) mana every 5 sec.", Types = {"ManaRegen"}},
	{Format = "Restores (%d+) mana per 5 sec.", Types = {"ManaRegen"}},
	
	{Format = "%+(%d+) health every 5 sec.", Types = {"HealthRegen"}},
	{Format = "Restores (%d+) health every 5 sec.", Types = {"HealthRegen"}},
	{Format = "Restores (%d+) health per 5 sec.", Types = {"HealthRegen"}},
	
	{Format = "Minor Mount Speed Increase", Value = 3, Types = {"Riding"}},
	{Format = "Mithril Spurs", Value = 3, Types = {"Riding"}},
	
	{Format = "%+(%d+) Fire Resistance", Types = {"FireResist"}},
	{Format = "%+(%d+) Nature Resistance", Types = {"NatureResist"}},
	{Format = "%+(%d+) Frost Resistance", Types = {"FrostResist"}},
	{Format = "%+(%d+) Shadow Resistance", Types = {"ShadowResist"}},
	{Format = "%+(%d+) Arcane Resistance", Types = {"ArcaneResist"}},
	{Format = "%+(%d+) All Resistances", Types = {"FireResist", "NatureResist", "FrostResist", "ShadowResist", "ArcaneResist"}},
	
	{Format = "Weapon Damage %+(%d+)", Types = {"MeleeDmg"}},
	{Format = "Improves your chance to hit by (%d+)%%", Types = {"MeleeHit"}},
	{Format = "Improves your chance to get a critical strike by (%d+)%%", Types = {"MeleeCrit"}},
	{Format = "Increases your chance to dodge an attack by (%d+)%%", Types = {"Dodge"}},
	{Format = "Damage %+(%d+)", Types = {"MeleeDmg"}},
	{Format = "(%d+) Block", Types = {"Block"}},
	{Format = "Block Value %+(%d+)", Types = {"Block"}},
	{Format = "Increases the block value of your shield by (%d+)", Types = {"Block"}},
	
	{Format = "Increased Fishing %+(%d+)%.", Types = {"Fishing"}},
	{Format = "Fishing %+(%d+)", Types = {"Fishing"}},
	{Format = "Herbalism %+(%d+)", Types = {"Herbalism"}},
	{Format = "Mining %+(%d+)", Types = {"Mining"}},
	{Format = "Skinning %+(%d+)", Types = {"Skinning"}},
	
	{Format = "Improves your chance to get a critical strike with spells by (%d+)%%", Types = {"SpellCrit"}},
	{Format = "Improves your chance to hit with spells by (%d+)%%", Types = {"SpellHit"}},
	{Format = "Increases damage and healing done by magical spells and effects by up to (%d+)", Types = {"SpellDmg", "ShadowDmg", "FireDmg", "FrostDmg", "ArcaneDmg", "NatureDmg", "Healing"}},
	{Format = "Increases healing done by spells and effects by up to (%d+)", Types = {"Healing"}},
	{Format = "Healing Spells %+(%d+)", Types = {"Healing"}},
	{Format = "%+(%d+) Healing Spells", Types = {"Healing"}},
	
	{Format = "%+(%d+) Fire Spell Damage", Types = {"FireDmg"}},
	{Format = "%+(%d+) Shadow Spell Damage", Types = {"ShadowDmg"}},
	{Format = "%+(%d+) Frost Spell Damage", Types = {"FrostDmg"}},
	{Format = "%+(%d+) Arcane Spell Damage", Types = {"ArcaneDmg"}},
	{Format = "%+(%d+) Nature Spell Damage", Types = {"NatureDmg"}},

	{Format = "Increases damage done by Fire spells and effects by up to (%d+)", Types = {"FireDmg"}},
	{Format = "Increases damage done by Shadow spells and effects by up to (%d+)", Types = {"ShadowDmg"}},
	{Format = "Increases damage done by Frost spells and effects by up to (%d+)", Types = {"FrostDmg"}},
	{Format = "Increases damage done by Arcane spells and effects by up to (%d+)", Types = {"ArcaneDmg"}},
	{Format = "Increases damage done by Nature spells and effects by up to (%d+)", Types = {"NatureDmg"}},
};

Outfitter_cAgilityStatName = "Agility";
Outfitter_cArmorStatName = "Armor";
Outfitter_cDefenseStatName = "Defense";
Outfitter_cIntellectStatName = "Intellect";
Outfitter_cSpiritStatName = "Spirit";
Outfitter_cStaminaStatName = "Stamina";
Outfitter_cStrengthStatName = "Strength";

Outfitter_cManaRegenStatName = "Mana Regeneration";
Outfitter_cHealthRegenStatName = "Health Regeneration";

Outfitter_cSpellCritStatName = "Spell Critical Strike";
Outfitter_cSpellHitStatName = "Spell Chance to Hit";
Outfitter_cSpellDmgStatName = "Spell Damage";
Outfitter_cFrostDmgStatName = "Frost Spell Damage";
Outfitter_cFireDmgStatName = "Fire Spell Damage";
Outfitter_cArcaneDmgStatName = "Arcane Spell Damage";
Outfitter_cShadowDmgStatName = "Shadow Spell Damage";
Outfitter_cNatureDmgStatName = "Nature Spell Damage";
Outfitter_cHealingStatName = "Healing";

Outfitter_cMeleeCritStatName = "Melee Critical Strike";
Outfitter_cMeleeHitStatName = "Melee Chance to Hit";
Outfitter_cMeleeDmgStatName = "Melee Damage";
Outfitter_cAttackStatName = "Attack Power";
Outfitter_cDodgeStatName = "Dodge";

Outfitter_cArcaneResistStatName = "Arcane Resistance";
Outfitter_cFireResistStatName = "Fire Resistance";
Outfitter_cFrostResistStatName = "Frost Resistance";
Outfitter_cNatureResistStatName = "Nature Resistance";
Outfitter_cShadowResistStatName = "Shadow Resistance";

Outfitter_cFishingStatName = "Fishing";
Outfitter_cHerbalismStatName = "Herbalism";
Outfitter_cMiningStatName = "Mining";
Outfitter_cSkinningStatName = "Skinning";

Outfitter_cOptionsTitle = "Outfitter Options";
Outfitter_cShowMinimapButton = "Show Minimap Button";
Outfitter_cShowMinimapButtonOnDescription = "Turn this off if you don't want the Outfitter button on your minimap cluster";
Outfitter_cShowMinimapButtonOffDescription = "Turn this on if you want the Outfitter button on your minimap cluster";
Outfitter_cRememberVisibility = "Remember cloak and helm settings";
Outfitter_cRememberVisibilityOnDescription = "Turn this off if you want to use a single show/hide setting for all cloaks and helms";
Outfitter_cRememberVisibilityOffDescription = "Turn this on if you want Outfitter to remember your preference for showing or hiding each cloak and helm individually";
Outfitter_cShowHotkeyMessages = "Show key binding outfit changes";
Outfitter_cShowHotkeyMessagesOnDescription = "Turn this off if you don't want to see a message when you change outfits using a key binding";
Outfitter_cShowHotkeyMessagesOffDescription = "Turn this on if you want to see a message when you change outfits using a key binding";

Outfitter_cEquipOutfitMessageFormat = "Outfitter: %s equipped";
Outfitter_cUnequipOutfitMessageFormat = "Outfitter: %s unequipped";

Outfitter_cAboutTitle = "About Outfitter";
Outfitter_cAuthor = "Designed and written by John Stephen";
Outfitter_cTestersTitle = "Beta Testers";
Outfitter_cTestersNames = "Airmid, Desiree, Fizzlebang, Harper, Kallah and Sumitra";
Outfitter_cSpecialThanksTitle = "Special thanks for their support to";
Outfitter_cSpecialThanksNames = "Brian, Dave, Glenn, Leah, Mark, The Mighty Pol, SFC and Forge";
Outfitter_cGuildURL = "http://www.starfleetclan.com";
Outfitter_cGuildURL2 = "http://www.forgeguild.com";

Outfitter_cOpenOutfitter = "Open Outfitter";

Outfitter_cArgentDawnOutfitDescription = "This outfit will automatically be worn whenever you're in the Plaguelands";
Outfitter_cRidingOutfitDescription = "This outfit will automatically be worn whenever you're mounted";
Outfitter_cDiningOutfitDescription = "This outfit will automatically be worn whenever you're eating or drinking";
Outfitter_cBattlegroundOutfitDescription = "This outfit will automatically be worn whenever you're in a battleground";
Outfitter_cArathiBasinOutfitDescription = "This outfit will automatically be worn whenever you're in the Arathi Basin battleground";
Outfitter_cAlteracValleyOutfitDescription = "This outfit will automatically be worn whenever you're in the Alterac Valley battleground";
Outfitter_cWarsongGulchOutfitDescription = "This outfit will automatically be worn whenever you're in the Warsong Gulch battleground";
Outfitter_cCityOutfitDescription = "This outfit will automatically be worn whenever you're in a friendly major city";

Outfitter_cKeyBinding = "Key Binding";

BINDING_HEADER_OUTFITTER_TITLE = Outfitter_cTitle;

BINDING_NAME_OUTFITTER_OUTFIT1  = "Outfit 1";
BINDING_NAME_OUTFITTER_OUTFIT2  = "Outfit 2";
BINDING_NAME_OUTFITTER_OUTFIT3  = "Outfit 3";
BINDING_NAME_OUTFITTER_OUTFIT4  = "Outfit 4";
BINDING_NAME_OUTFITTER_OUTFIT5  = "Outfit 5";
BINDING_NAME_OUTFITTER_OUTFIT6  = "Outfit 6";
BINDING_NAME_OUTFITTER_OUTFIT7  = "Outfit 7";
BINDING_NAME_OUTFITTER_OUTFIT8  = "Outfit 8";
BINDING_NAME_OUTFITTER_OUTFIT9  = "Outfit 9";
BINDING_NAME_OUTFITTER_OUTFIT10 = "Outfit 10";

Outfitter_cDisableOutfit = "Disable Outfit";
Outfitter_cDisableOutfitInBG = "Disable Outfit When in Battlegrounds";
Outfitter_cDisabledOutfitName = "%s (Disabled)";

Outfitter_cMinimapButtonTitle = "Outfitter Minimap Button";
Outfitter_cMinimapButtonDescription = "Click to select a different outfit or drag to re-position this button.";

Outfitter_cDruidClassName = "Druid";
Outfitter_cHunterClassName = "Hunter";
Outfitter_cMageClassName = "Mage";
Outfitter_cPaladinClassName = "Paladin";
Outfitter_cPriestClassName = "Priest";
Outfitter_cRogueClassName = "Rogue";
Outfitter_cShamanClassName = "Shaman";
Outfitter_cWarlockClassName = "Warlock";
Outfitter_cWarriorClassName = "Warrior";

Outfitter_cBattleStance = "Battle Stance";
Outfitter_cDefensiveStance = "Defensive Stance";
Outfitter_cBerserkerStance = "Berserker Stance";

Outfitter_cWarriorBattleStance = "Warrior: Battle Stance";
Outfitter_cWarriorDefensiveStance = "Warrior: Defensive Stance";
Outfitter_cWarriorBerserkerStance = "Warrior: Berserker Stance";

Outfitter_cBearForm = "Bear Form";
Outfitter_cCatForm = "Cat Form";
Outfitter_cAquaticForm = "Aquatic Form";
Outfitter_cTravelForm = "Travel Form";
Outfitter_cDireBearForm = "Dire Bear Form";
Outfitter_cMoonkinForm = "Moonkin Form";

Outfitter_cGhostWolfForm = "Ghost Wolf";

Outfitter_cStealth = "Stealth";

Outfitter_cDruidBearForm = "Druid: Bear Form";
Outfitter_cDruidCatForm = "Druid: Cat Form";
Outfitter_cDruidAquaticForm = "Druid: Aquatic Form";
Outfitter_cDruidTravelForm = "Druid: Travel Form";
Outfitter_cDruidMoonkinForm = "Druid: Moonkin Form";

Outfitter_cPriestShadowform = "Priest: Shadowform";

Outfitter_cRogueStealth = "Rogue: Stealth";

Outfitter_cShamanGhostWolf = "Shaman: Ghost Wolf";

Outfitter_cHunterMonkey = "Hunter: Monkey";
Outfitter_cHunterHawk =  "Hunter: Hawk";
Outfitter_cHunterCheetah =  "Hunter: Cheetah";
Outfitter_cHunterPack =  "Hunter: Pack";
Outfitter_cHunterBeast =  "Hunter: Beast";
Outfitter_cHunterWild =  "Hunter: Wild";

Outfitter_cMageEvocate = "Mage: Evocate";

Outfitter_cAspectOfTheCheetah = "Aspect of the Cheetah";
Outfitter_cAspectOfThePack = "Aspect of the Pack";
Outfitter_cAspectOfTheBeast = "Aspect of the Beast";
Outfitter_cAspectOfTheWild = "Aspect of the Wild";
Outfitter_cEvocate = "Evocation";

Outfitter_cCompleteCategoryDescripton = "Complete outfits have items specified for every slot and will replace all other outfits when worn.";
Outfitter_cPartialCategoryDescription = "Mix-n-match outfits have only some slots specified, but not all.  When equipped, they are added on top of your selcted Complete outfit, replacing any other Mix-n-match or Accessory outfits selected.";
Outfitter_cAccessoryCategoryDescription = "Accessory outfits have only some slots specified, but not all.  Unlike mix-n-match, you can select as many Accessory outfits as you like and they will all be combined together and worn on top of your selected Complete and Mix-n-match outfits.";
Outfitter_cSpecialCategoryDescription = "Special Occassion outfits are automatically worn whenever the occassion warrants it.  They are worn over all other selected outfits.";
Outfitter_cOddsNEndsCategoryDescription = "Odds 'n ends is a list of items which you haven't used in any of your outfits.  This may be useful in ensuring that you're using all of your items or that you're not carrying around excess baggage.";

Outfitter_cRebuildOutfitFormat = "Rebuild for %s";

Outfitter_cTranslationCredit = " ";

Outfitter_cSlotEnableTitle = "Slot Enable";
Outfitter_cSlotEnableDescription = "Select this if you want the item in this slot to be equipped when changing to the selected outfit.  If not selected then this slot will not be modified when changing to the selected outfit.";

Outfitter_cFinger0SlotName = "First Finger";
Outfitter_cFinger1SlotName = "Second Finger";

Outfitter_cTrinket0SlotName = "First Trinket";
Outfitter_cTrinket1SlotName = "Second Trinket";

Outfitter_cOutfitCategoryTitle = "Category";
Outfitter_cBankCategoryTitle = "Bank";
Outfitter_cDepositToBank = "Deposit all items to bank";
Outfitter_cDepositUniqueToBank = "Deposit unique items to bank";
Outfitter_cWithdrawFromBank = "Withdraw items from bank";

Outfitter_cMissingItemsLabel = "Missing items: ";
Outfitter_cBankedItemsLabel = "Banked items: ";

Outfitter_cRepairAllBags = "Outfitter: Repair All Bagged Items";

Outfitter_cStatsCategory = "Stats";
Outfitter_cMeleeCategory = "Melee";
Outfitter_cSpellsCategory = "Healing and Spells";
Outfitter_cRegenCategory = "Regeneration";
Outfitter_cResistCategory = "Resistances";
Outfitter_cTradeCategory = "Trade Skills";

Outfitter_cTankPoints = "TankPoints";
Outfitter_cCustom = "Custom";
