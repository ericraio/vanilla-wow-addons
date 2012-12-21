if GetLocale() == "deDE" then
	Outfitter_cTitle = "Outfitter";
	Outfitter_cTitleVersion = Outfitter_cTitle.." "..Outfitter_cVersion;

	Outfitter_cNameLabel = "Name:";
	Outfitter_cCreateUsingTitle = "Optimieren f\195\188r:";
	Outfitter_cUseCurrentOutfit = "Benutze derzeitiges Outfit";
	Outfitter_cUseEmptyOutfit = "Erstelle neues Outfit";

	Outfitter_cOutfitterTabTitle = "Outfitter";
	Outfitter_cOptionsTabTitle = "Einstellungen";
	Outfitter_cAboutTabTitle = "\195\188ber";

	Outfitter_cNewOutfit = "Neues Outfit";
	Outfitter_cRenameOutfit = "Outfit umbenennen";

	Outfitter_cCompleteOutfits = "Vollst\195\164ndige Ausr\195\188stungen";
	Outfitter_cPartialOutfits = "Mix-n-match";
	Outfitter_cAccessoryOutfits = "Zusatzgegenst\195\164nde";
	Outfitter_cSpecialOutfits = "Besondere Gelegenheiten";

	Outfitter_cNormalOutfit = "Normal";
	Outfitter_cNakedOutfit = "Ausgehroben";

	Outfitter_cFishingOutfit = "Angeln";
	Outfitter_cHerbalismOutfit = "Kr\195\164uterkunde";
	Outfitter_cMiningOutfit = "Bergbau";
	Outfitter_cSkinningOutfit = "K\195\188rschnerei";
	Outfitter_cFireResistOutfit = "Feuerwiderstand";
	Outfitter_cNatureResistOutfit = "Naturwiderstand";
	Outfitter_cShadowResistOutfit = "Schattenwiderstand";
	Outfitter_cArcaneResistOutfit = "Arkanwiderstand";
	Outfitter_cFrostResistOutfit = "Frostwiderstand";

	Outfitter_cArgentDawnOutfit = "Argentumd\195\164mmerung";
	Outfitter_cRidingOutfit = "Reiten";
	Outfitter_cDiningOutfit = "Ausruhen";
	Outfitter_cBattlegroundOutfit = "Schlachtfeld";
	
	Outfitter_cABOutfit = "Schlachtfeld: Arathibecken";
	Outfitter_cAVOutfit = "Schlachtfeld: Alteractal";
	Outfitter_cWSGOutfit = "Schlachtfeld: Warsongschlucht";
	Outfitter_cCityOutfit = "Stadt";

	Outfitter_cMountSpeedFormat = "Erh\195\182ht Tempo um (%d+)%%."; -- For detecting when mounted

	Outfitter_cBagsFullError = "Outfitter: %s kann nicht enfernt werden da alle Taschen voll sind.";
	Outfitter_cItemNotFoundError = "Outfitter: Kann %s nicht finden.";
	Outfitter_cAddingItem = "Outfitter: F\195\188ge %s zum %s Outfit.";
	Outfitter_cNameAlreadyUsedError = "Fehler: Dieser Name ist bereits vergeben.";
	Outfitter_cNoItemsWithStatError = "Warnung: Keines deiner Gegenst\195\164nde hat dieses Attribut.";

	Outfitter_cEnableAll = "Alle aktivieren";
	Outfitter_cEnableNone = "Alle deaktivieren";

	Outfitter_cConfirmDeleteMsg = "Bist du sicher dass du das %s Outfit l\195\182schen willst?";
	Outfitter_cConfirmRebuildMsg = "Bist du sicher dass du das %s Outfit ver\195\164ndern willst?";
	Outfitter_cRebuild = "Ver\195\164ndern";

	Outfitter_cWesternPlaguelands = "Westliche Pestl\195\164nder";
	Outfitter_cEasternPlaguelands = "\195\150stliche Pestl\195\164nder";
	Outfitter_cStratholme = "Stratholme";
	Outfitter_cScholomance = "Scholomance";
	Outfitter_cNaxxramas = "Naxxramas";
	Outfitter_cAlteracValley = "Alteractal";
	Outfitter_cArathiBasin = "Arathibecken";
	Outfitter_cWarsongGulch = "Warsongschlucht";
	Outfitter_cIronforge = "Ironforge";
	Outfitter_cDarnassus = "Darnassus";
	Outfitter_cStormwind = "Stormwind";
	Outfitter_cOrgrimmar = "Orgrimmar";
	Outfitter_cThunderBluff = "Thunder Bluff";
	Outfitter_cUndercity = "Undercity";

	Outfitter_cFishingPole = "Angel";
	Outfitter_cStrongFishingPole = "Starke Angel";
	Outfitter_cBigIronFishingPole = "Gro\195\159e Eisenangel";
	Outfitter_cBlumpFishingPole = "Angel der Familie Blump";
	Outfitter_cNatPaglesFishingPole = "Nat Pagles Extremangler FC-5000";
	Outfitter_cArcaniteFishingPole = "Arkanitangel";

	Outfitter_cArgentDawnCommission = "Anstecknadel der Argentumd\195\164mmerung";
	Outfitter_cSealOfTheDawn = "Siegel der D\195\164mmerung";
	Outfitter_cRuneOfTheDawn = "Rune der D\195\164mmerung";

	Outfitter_cCarrotOnAStick = "Karotte am Stiel";

	Outfitter_cItemStatFormats =
	{
		{Format = "Ausdauer %+(%d+)", Types = {"Stamina"}},
		{Format = "Intelligenz %+(%d+)", Types = {"Intellect"}},
		{Format = "Beweglichkeit %+(%d+)", Types = {"Agility"}},
		{Format = "St\195\164rke %+(%d+)", Types = {"Strength"}},
		{Format = "Willenskraft %+(%d+)", Types = {"Spirit"}},
		{Format = "R\195\188stung %+(%d+)", Types = {"Armor"}},
		{Format = "Verteidigung %+(%d+)", Types = {"Defense"}},
		{Format = "Anlegen: Verteidigung %+(%d+)", Types = {"Defense"}},
		
		{Format = "%+(%d+) Ausdauer", Types = {"Stamina"}},
		{Format = "%+(%d+) Intelligenz", Types = {"Intellect"}},
		{Format = "%+(%d+) Beweglichkeit", Types = {"Agility"}},
		{Format = "%+(%d+) St\195\164rke", Types = {"Strength"}},
		{Format = "%+(%d+) Willenskraft", Types = {"Spirit"}},
		{Format = "(%d+) R\195\188stung", Types = {"Armor"}},
		{Format = "%+(%d+) Angriffskraft", Types = {"Attack"}},
		
		{Format = "Mana %+(%d+)", Types = {"Mana"}},
		{Format = "Gesundheit %+(%d+)", Types = {"Health"}},
		
		{Format = "%+(%d+) Mana alle 5 Sek.", Types = {"ManaRegen"}},
		{Format = "Stellt alle 5 Sek. (%d+) Punkt(e) Mana wieder her.", Types = {"ManaRegen"}},
		
		{Format = "%+(%d+) Gesundheit alle 5 Sek.", Types = {"HealthRegen"}},
		{Format = "Stellt alle 5 Sek. (%d+) Punkt(e) Gesundheit wieder her.", Types = {"HealthRegen"}},
		
		{Format = "Schwache Reittemposteigerung", Value = 3, Types = {"Riding"}},
		{Format = "Mithrilsporen", Value = 3, Types = {"Riding"}},
		
		{Format = "%+(%d+) Feuerwiderstand", Types = {"FireResist"}},
		{Format = "%+(%d+) Naturwiderstand", Types = {"NatureResist"}},
		{Format = "%+(%d+) Frostwiderstand", Types = {"FrostResist"}},
		{Format = "%+(%d+) Schattenwiderstand", Types = {"ShadowResist"}},
		{Format = "%+(%d+) Arkanwiderstand", Types = {"ArcaneResist"}},
		{Format = "%+(%d+) Alle Widerst\195\164nde", Types = {"FireResist", "NatureResist", "FrostResist", "ShadowResist", "ArcaneResist"}},
		
		{Format = "Waffenschaden %+(%d+)", Types = {"MeleeDmg"}},
		{Format = "Erh\195\182ht Eure Trefferchance um (%d+)%%", Types = {"MeleeHit"}},
		{Format = "Erh\195\182ht Eure Chance, einen kritischen Schlag zu erzielen, um (%d+)%%", Types = {"MeleeCrit"}},
		{Format = "Erh\195\182ht Eure Chance, einem Angriff auszuweichen, um (%d+)%%", Types = {"Dodge"}},
		{Format = "Schaden %+(%d+)", Types = {"MeleeDmg"}},
		{Format = "(%d+) Blocken", Types = {"BlockAmount"}},
		
		{Format = "Erh\195\182ht Angeln um %+(%d+)%.", Types = {"Fishing"}},
		{Format = "Angeln %+(%d+)", Types = {"Fishing"}},
		{Format = "Kr\195\164uterkunde %+(%d+)", Types = {"Herbalism"}},
		{Format = "Bergbau %+(%d+)", Types = {"Mining"}},
		{Format = "K\195\188rschnerei %+(%d+)", Types = {"Skinning"}},
		
		{Format = "Erh\195\182ht Eure Chance, einen kritischen Treffer durch Zauber zu erzielen, um (%d+)%%", Types = {"SpellCrit"}},
		{Format = "Improves your chance to hit with spells by (%d+)%%", Types = {"SpellHit"}},
		{Format = "Erh\195\182ht durch Zauber und magische Effekte zugef\195\188gten Schaden und Heilung um bis zu (%d+)", Types = {"SpellDmg", "ShadowDmg", "FireDmg", "FrostDmg", "ArcaneDmg", "NatureDmg", "Healing"}},
		{Format = "Erh\195\182ht durch Zauber und Effekte verursachte Heilung um bis zu (%d+)", Types = {"Healing"}},
		{Format = "Heilzauber %+(%d+)", Types = {"Healing"}},
		{Format = "%+(%d+) Heilzauber", Types = {"Healing"}},
		
		{Format = "%+(%d+) Feuerzauberschaden", Types = {"FireDmg"}},
		{Format = "%+(%d+) Schattenzauberschaden", Types = {"ShadowDmg"}},
		{Format = "%+(%d+) Frostzauberschaden", Types = {"FrostDmg"}},
		{Format = "%+(%d+) Arkanzauberschaden", Types = {"ArcaneDmg"}},
		{Format = "%+(%d+) Naturzauberschaden", Types = {"NatureDmg"}},
		
		{Format = "Increases damage done by Fire spells and effects by up to (%d+)", Types = {"FireDmg"}},
		{Format = "Increases damage done by Shadow spells and effects by up to (%d+)", Types = {"ShadowDmg"}},
		{Format = "Increases damage done by Frost spells and effects by up to (%d+)", Types = {"FrostDmg"}},
		{Format = "Increases damage done by Arcane spells and effects by up to (%d+)", Types = {"ArcaneDmg"}},
		{Format = "Increases damage done by Nature spells and effects by up to (%d+)", Types = {"NatureDmg"}},
	};

	Outfitter_cAgilityStatName = "Beweglichkeit";
	Outfitter_cArmorStatName = "R\195\188stung";
	Outfitter_cDefenseStatName = "Verteidigung";
	Outfitter_cIntellectStatName = "Intelligenz";
	Outfitter_cSpiritStatName = "Willenskraft";
	Outfitter_cStaminaStatName = "Ausdauer";
	Outfitter_cStrengthStatName = "St\195\164rke";

	Outfitter_cManaRegenStatName = "Manaregeneration";
	Outfitter_cHealthRegenStatName = "Gesundheitsregeneration";

	Outfitter_cSpellCritStatName = "Zauberkritisch";
	Outfitter_cSpellHitStatName = "Spell Chance to Hit";
	Outfitter_cSpellDmgStatName = "Zauberschaden";
	Outfitter_cFrostDmgStatName = "Frostzauberschaden";
	Outfitter_cFireDmgStatName = "Feuerzauberschaden";
	Outfitter_cArcaneDmgStatName = "Arkanzauberschaden";
	Outfitter_cShadowDmgStatName = "Schattenzauberschaden";
	Outfitter_cNatureDmgStatName = "Naturzauberschaden";
	Outfitter_cHealingStatName = "Heilung";

	Outfitter_cMeleeCritStatName = "Kampfkritisch";
	Outfitter_cMeleeHitStatName = "Kampftrefferchance";
	Outfitter_cMeleeDmgStatName = "Kampfschaden";
	Outfitter_cAttackStatName = "Angriffskraft";
	Outfitter_cDodgeStatName = "Ausweichen";

	Outfitter_cArcaneResistStatName = "Arkanwiderstand";
	Outfitter_cFireResistStatName = "Feuerwiderstand";
	Outfitter_cFrostResistStatName = "Frostwiderstand";
	Outfitter_cNatureResistStatName = "Naturwiderstand";
	Outfitter_cShadowResistStatName = "Schattenwiderstand";

	Outfitter_cFishingStatName = "Angeln";
	Outfitter_cHerbalismStatName = "Kr\195\164uterkunde";
	Outfitter_cMiningStatName = "Bergbau";
	Outfitter_cSkinningStatName = "K\195\188rschnerei";

	Outfitter_cOptionsTitle = "Outfitter Einstellungen";
	Outfitter_cShowMinimapButton = "Zeige Minimapbutton";
	Outfitter_cShowMinimapButtonOnDescription = "Deaktivieren, um den Minimapbutton von Outfitter zu verstecken.";
	Outfitter_cShowMinimapButtonOffDescription = "Aktivieren, um den Minimapbutton von Outfitter zu zeigen.";
	Outfitter_cRememberVisibility = "Remember cloak and helm settings";
	Outfitter_cRememberVisibilityOnDescription = "Turn this off if you want to use a single show/hide setting for all cloaks and helms";
	Outfitter_cRememberVisibilityOffDescription = "Turn this on if you want Outfitter to remember your preference for showing or hiding each cloak and helm individually";

	Outfitter_cAboutTitle = "\195\188ber Outfitter";
	Outfitter_cAuthor = "Gestaltet und geschrieben von John Stephen";
	Outfitter_cTestersTitle = "Beta Tester";
	Outfitter_cTestersNames = "Airmid, Desiree, Fizzlebang, Harper, Kallah und Sumitra";
	Outfitter_cSpecialThanksTitle = "Besonderen Dank f\195\188r ihre Unterst\195\188tzung geht an";
	Outfitter_cSpecialThanksNames = "Brian, Dave, Glenn, Leah, Mark, The Mighty Pol, SFC und Forge";
	Outfitter_cGuildURL = "http://www.starfleetclan.com";
	Outfitter_cGuildURL2 = "http://www.forgeguild.com";

	Outfitter_cOpenOutfitter = "Outfitter \195\182ffnen";

	Outfitter_cArgentDawnOutfitDescription = "Dieses Outfit wird automatisch beim Betreten der Pestl\195\164nder angelegt.";
	Outfitter_cRidingOutfitDescription = "Dieses Outfit wird automatisch beim Reiten angelegt.";
	Outfitter_cDiningOutfitDescription = "Dieses Outfit wird automatisch beim Essen und/oder Trinken angelegt.";
	Outfitter_cBattlegroundOutfitDescription = "Dieses Outfit wird automatisch beim Betreten eines Schlachtfeldes angelegt.";
	Outfitter_cArathiBasinOutfitDescription = "This outfit will automatically be worn whenever you're in the Arathi Basin battleground";
	Outfitter_cAlteracValleyOutfitDescription = "This outfit will automatically be worn whenever you're in the Alterac Valley battleground";
	Outfitter_cWarsongGulchOutfitDescription = "This outfit will automatically be worn whenever you're in the Warsong Gulch battleground";
	Outfitter_cCityOutfitDescription = "This outfit will automatically be worn whenever you're in a friendly major city";

	Outfitter_cKeyBinding = "Tastaturbelegung";

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

	Outfitter_cDisableOutfit = "Outfit abschalten";
	Outfitter_cDisableOutfitInBG = "Outfit beim Betreten eines Schlachtfeldes abschalten.";
	Outfitter_cDisabledOutfitName = "%s (Abgeschalten)";

	Outfitter_cMinimapButtonTitle = "Outfitter Minimapbutton";
	Outfitter_cMinimapButtonDescription = "Klicken f\195\188r eine Auswahl an Outfits oder gedr\195\188ckthalten zum bewegen des Buttons.";

	Outfitter_cDruidClassName = "Druide";
	Outfitter_cHunterClassName = "J\195\164ger";
	Outfitter_cMageClassName = "Magier";
	Outfitter_cPaladinClassName = "Paladin";
	Outfitter_cPriestClassName = "Priester";
	Outfitter_cRogueClassName = "Schurke";
	Outfitter_cShamanClassName = "Schamane";
	Outfitter_cWarlockClassName = "Hexenmeister";
	Outfitter_cWarriorClassName = "Krieger";

	Outfitter_cBattleStance = "Kampfhaltung";
	Outfitter_cDefensiveStance = "Verteidigungshaltung";
	Outfitter_cBerserkerStance = "Berserkerhaltung";

	Outfitter_cWarriorBattleStance = "Krieger: Kampfhaltung";
	Outfitter_cWarriorDefensiveStance = "Krieger: Verteidigungshaltung";
	Outfitter_cWarriorBerserkerStance = "Krieger: Berserkerhaltung";

	Outfitter_cBearForm = "B\195\164rengestalt";
	Outfitter_cCatForm = "Katzengestalt";
	Outfitter_cAquaticForm = "Wassergestalt";
	Outfitter_cTravelForm = "Reisegestalt";
	Outfitter_cDireBearForm = "Terrorb\195\164rengestalt";
	Outfitter_cMoonkinForm = "Moonkin Form";
	
	Outfitter_cGhostWolfForm = "Geisterwolf";

	Outfitter_cStealth = "Verstohlenheit";

	Outfitter_cDruidBearForm = "Druide: B\195\164rengestalt";
	Outfitter_cDruidCatForm = "Druide: Katzengestalt";
	Outfitter_cDruidAquaticForm = "Druide: Wassergestalt";
	Outfitter_cDruidTravelForm = "Druide: Reisegestalt";
	Outfitter_cDruidMoonkinForm = "Druide: Moonkin Form";

	Outfitter_cPriestShadowform = "Priester: Schattengestalt";

	Outfitter_cRogueStealth = "Schurke: Verstohlenheit";

	Outfitter_cShamanGhostWolf = "Schamane: Geisterwolf";

	Outfitter_cCompleteCategoryDescripton = "Vollst\195\164ndige Outfits haben f\195\188r jeden Inventarslot festgelegte Gegenst\195\164nde, die alles andere ersetzen wenn sie getragen werden.";
	Outfitter_cPartialCategoryDescription = "Bei Mix-n-match Outfits sind nur einige Gegenst\195\164nde festgelegt, jedoch nicht alle.  Werden diese Outfits ausgew\195\164hlt bleibt das vorherige Outfit erhalten, nur die neuen Gegenst\195\164nde werden ge\195\164ndert.";
	Outfitter_cAccessoryCategoryDescription = "Zusatzgegenst\195\164nde-Outfits haben nur einige festgelegte Inventarslots.  Anders als beim Mix-n-match kannst du so viele Zusatzgegenst\195\164nde-Outfits erstellen und tragen, sie werden alle miteinander verbunden und \195\188ber bestehenden Outfits getragen.";
	Outfitter_cSpecialCategoryDescription = "Besondere Gelegenheit-Outfits werden automatisch angelegt wenn die Situation es verlangt.  Sie werden \195\188ber allen anderen Outfits getragen.";
	Outfitter_cOddsNEndsCategoryDescription = "Odds 'n ends ist eine Auflistung der Gegenst\195\164nde, die keinem Outfit zugewiesen sind. Mit dieser Funktion kannst du sicherstellen, dass alle Gegenst\195\164nde ihren Platz haben oder dass du keine unn\195\182tigen Gegenst\195\164nde mit dir herumtr\195\164gst.";
	
	Outfitter_cRebuildOutfitFormat = "%s ge\195\164ndert.";
	
	Outfitter_cTranslationCredit = "Deutsche \195\156bersetzung: Ani";
	
	Outfitter_cSlotEnableTitle = "Slot aktivieren";
	Outfitter_cSlotEnableDescription = "Aktiviere diese Option, damit der Gegenstand in diesem Slot automatisch angelegt wird wenn du zu diesem Outfit wechselst.  Ist dieser Slot nicht aktiviert, wird er beim Anlegen eines anderen Outfits nicht ver\195\164ndert.";
	
	Outfitter_cFinger0SlotName = "Erster Finger";
	Outfitter_cFinger1SlotName = "Zweiter Finger";
	
	Outfitter_cTrinket0SlotName = "Erstes Schmuckst\195\188ck";
	Outfitter_cTrinket1SlotName = "Zweites Schmuckst\195\188ck";
	
	Outfitter_cOutfitCategoryTitle = "Kategorie";
	Outfitter_cBankCategoryTitle = "Bank";
	Outfitter_cDepositToBank = "Gegenst\195\164nde im Bankfach ablegen";
	Outfitter_cDepositUniqueToBank = "Deposit unique items to bank";
	Outfitter_cWithdrawFromBank = "Gegenst\195\164nde vom Bankfach aufnehmen";
	
	Outfitter_cMissingItemsLabel = "Fehlende Gegenst\195\164nde: ";
	Outfitter_cBankedItemsLabel = "Gegenst\195\164nde auf der Bank: ";

	Outfitter_cStatsCategory = "Stats";
	Outfitter_cMeleeCategory = "Melee";
	Outfitter_cSpellsCategory = "Healing and Spells";
	Outfitter_cRegenCategory = "Regeneration";
	Outfitter_cResistCategory = "Resistances";
	Outfitter_cTradeCategory = "Trade Skills";
end
