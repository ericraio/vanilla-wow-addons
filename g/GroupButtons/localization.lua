GB_VERSION = "4.97";

GB_ANCHORS_INDEX = nil;
GB_ANNOUNCED = {};
GB_ANNOUNCETEXT = nil;
GB_ANNOUNCEFAILURE = nil;
GB_ANNOUNCEINTERRUPTED = nil;
GB_ATTACKING = false;
GB_BAGS_LOADED = true;
GB_BAR = "player";
GB_BAR_OPTIONS_INIT = nil;
GB_BAR_TO_COPY = nil;
GB_BUFFS = {};
GB_BUTTON = nil;
GB_CLICKBOX = nil;
GB_CLICKCAST_BUTTON = nil;
GB_CURRENT_HEAL = {};
GB_CURRENT_KB_BAR = "GB_PlayerBar";
GB_DEBUFFS = {};
GB_ENTERING_WORLD = nil;
GB_INCOMBAT = false;
GB_INDEX = "";
GB_INITIALIZED = nil;
GB_INSTANTCASTING = nil;
GB_INVENTORY = {};
GB_ISCASTING = nil;
GB_ITEMS = {};
GB_LAST_SPELL = nil;
GB_LAST_SPELLNUM = 0;
GB_LAST_SPELLNUM2 = 0;
GB_LAST_UNIT = nil;
GB_MACROS = {};
GB_MOUSE_ACTION = {};
GB_MOUSEOUT_TIME = .5;
GB_NAME_UPDATE = nil;
GB_RAID_MEMBERS = {};
GB_REGEN = true;
GB_SPELLBOOKPAGE = 0;
GB_SPELLISCASTING = nil;
GB_SPELLS = {};
GB_SPELLS_COUNT = 0;
GB_SPELLS_UPDATED = nil;
GB_VARIABLES_LOADED = nil;
GB_WHISPERTARGET = nil;

GB_UNITFRAMES = {
		player = { 
			frames={"PlayerFrame"},
			onClick =  {name="PlayerFrame_OnClick", params={"mousebutton"}},
			onEnter = {name="UnitFrame_OnEnter", params = {}},
			onLeave = {name="UnitFrame_OnLeave", params = {}},
			onDrag = {name="PlayerFrame_OnReceiveDrag", params = {}}
			},
		party = {
			frames={"PartyMemberFrame1", "PartyMemberFrame2", "PartyMemberFrame3", "PartyMemberFrame4"},
			onClick= {name="PartyMemberFrame_OnClick", params = {}},
			onEnter = {name="UnitFrame_OnEnter", override="GB_DefaultPartyFrame_OnEnter", params = {}},
			onLeave = {name="UnitFrame_OnLeave", override="GB_DefaultPartyFrame_OnLeave", params = {}}
			},
		target = {
			frames={"TargetFrame"},
			onClick =  {name="TargetFrame_OnClick", params={"mousebutton"}},
			onEnter = {name="UnitFrame_OnEnter", params = {}},
			onLeave = {name="UnitFrame_OnLeave", params = {}}
			},
		pet = {
			frames={"PetFrame"},
			onClick =  {name="PetFrame_OnClick", params={"mousebutton"}},
			onEnter = {name="UnitFrame_OnEnter", override="GB_DefaultPartyFrame_OnEnter", params = {}},
			onLeave = {name="UnitFrame_OnLeave", override="GB_DefaultPartyFrame_OnLeave", params = {}}
		},
		partypet = {
			frames={"PartyMemberFrame1PetFrame", "PartyMemberFrame2PetFrame", "PartyMemberFrame3PetFrame", "PartyMemberFrame4PetFrame"},
			onClick =  {name="PartyMemberPetFrame_OnClick", params={}},
			onEnter = {name="UnitFrame_OnEnter", params = {}},
			onLeave = {name="UnitFrame_OnLeave", params = {}}
		}
	};

GB_CLICKBOXES = { "GB_PlayerClickbox", "GB_Party1Clickbox", "GB_Party2Clickbox", "GB_Party3Clickbox", "GB_Party4Clickbox", "GB_TargetClickbox", "GB_Pet0Clickbox", "GB_Pet1Clickbox", "GB_Pet2Clickbox", "GB_Pet3Clickbox", "GB_Pet4Clickbox"};
GB_CLICKBOXES2 = { 
	player = { "GB_PlayerClickbox" },
	party = { "GB_Party1Clickbox", "GB_Party2Clickbox", "GB_Party3Clickbox", "GB_Party4Clickbox" },
	target = { "GB_TargetClickbox" },
	pet = {"GB_Pet0Clickbox"},
	partypet = {"GB_Pet1Clickbox", "GB_Pet2Clickbox", "GB_Pet3Clickbox", "GB_Pet4Clickbox"}
	};

GB_TEXT_OPTIONS = "Options";
GB_APPEARANCE = "APPEARANCE";
GB_MINISPELLBOOK = "GROUP BUTTONS SPELLBOOK";
GB_DEFAULT_ANNOUNCE_TEXT = "Now casting $s $r on $t.";
GB_ANNOUNCE_HELP_TEXT = "Use $t for target's name, $s for spellname, $r for spell rank,\n$c for casting time, $a for heal amount, $m for percent of mana you have left";
GB_COPY_BAR_SETTINGS = "Copy Bar Settings:";
GB_COPY = "COPY";
GB_RESET = "RESET";
GB_COLORS = "COLORS";
GB_RAID_MEMBER_HEADER = "Check the raid members for whom you want a bar to display.";

GB_UNITS_ARRAY = {
		player = { frames = { "GB_PlayerBar" }, labels = { "SELF" }, buttons = 20 },
		party = { frames = { "GB_PartyBar1", "GB_PartyBar2", "GB_PartyBar3", "GB_PartyBar4" }, labels = { "PARTY 1", "PARTY 2", "PARTY 3", "PARTY 4" }, buttons = 20 },
		friendlytarget = { frames = { "GB_FriendlyTargetBar" }, labels = { "FRIENDLY TARGET" }, buttons = 20 },
		hostiletarget = { frames = { "GB_HostileTargetBar" }, labels = { "HOSTILE TARGET" }, buttons = 20 },
		lowesthealth = { frames = { "GB_LowestHealthBar" }, labels = { "LOWEST HEALTH" }, buttons = 20 },
		pet = { frames = {"GB_PetBar0"}, labels = {"PET"}, buttons = 6 },
		partypet = { frames = {"GB_PetBar1", "GB_PetBar2", "GB_PetBar3", "GB_PetBar4"}, labels = {"PARTY PET 1", "PARTY PET 2", "PARTY PET 3", "PARTY PET 4"}, buttons = 6 },
		raid = { frames = {"GB_RaidBar1", "GB_RaidBar2", "GB_RaidBar3", "GB_RaidBar4", "GB_RaidBar5", "GB_RaidBar6", "GB_RaidBar7", "GB_RaidBar8", "GB_RaidBar9", "GB_RaidBar10", "GB_RaidBar11", "GB_RaidBar12", "GB_RaidBar13", "GB_RaidBar14", "GB_RaidBar15", "GB_RaidBar16", "GB_RaidBar17", "GB_RaidBar18", "GB_RaidBar19", "GB_RaidBar20", "GB_RaidBar21", "GB_RaidBar22", "GB_RaidBar23", "GB_RaidBar24", "GB_RaidBar25", "GB_RaidBar26", "GB_RaidBar27", "GB_RaidBar28", "GB_RaidBar29", "GB_RaidBar30", "GB_RaidBar31", "GB_RaidBar32", "GB_RaidBar33", "GB_RaidBar34", "GB_RaidBar35", "GB_RaidBar36", "GB_RaidBar37", "GB_RaidBar38", "GB_RaidBar39", "GB_RaidBar40"}, labels = {"RAID 1", "RAID 2", "RAID 3", "RAID 4", "RAID 5", "RAID 6", "RAID 7", "RAID 8", "RAID 9", "RAID 10", "RAID 11", "RAID 12", "RAID 13", "RAID 14", "RAID 15", "RAID 16", "RAID 17", "RAID 18", "RAID 19", "RAID 20", "RAID 21", "RAID 22", "RAID 23", "RAID 24", "RAID 25", "RAID 26", "RAID 27", "RAID 28", "RAID 29", "RAID 30", "RAID 31", "RAID 32", "RAID 33", "RAID 34", "RAID 35", "RAID 36", "RAID 37", "RAID 38", "RAID 39", "RAID 40"}, buttons = 6 }
	};

GB_FILTERS = {
		CastingTime = "([\.%d]*) sec cast",
		Curse = "Curse",
		Damage = "damage",
		Disease = "Disease",
		Energy = "(%d*) Energy",
		Heal = "HEAL",
		Over = " over ",
		DamageOverTime = "(%d[^%s]*) %a* damage over (%d*) sec",
		HealOverTime = "(%d[^%s]*) damage over (%d*) sec",
		DruidHealOverTime = "(%d[^%s]*) over (%d*) sec",
		Magic = "Magic",
		Mana = "(%d*) Mana",
		Poison = "Poison",
		Rage = "(%d*) Rage",
		Range = "(%d*) yd range",
		To = "(%d[^%s]*) to (%d*)"
	};
--(%d*.?%d?) to (%d*.?%d?)

GB_TEXT = {
		Actions = "Actions",
		AdjustClickbox = "Adjust Clickbox:",
		Alt = "Alt",
		AnchorPoint = "Attach Point:",
		AnchorTo = "Attach To:",
		Announce = "Announce Spellcast",
		AnnounceFailures = "Annouce Failed Casts",
		AnnounceInterrupts = "Announce Interrupted Casts",
		AnnounceNum = "Use Announce Number:",
		AnnounceOptions = "Announce Options",
		AnnounceOptions2 = "ANNOUNCE SPELLCAST OPTIONS",
		AnnounceText = "Announce Text ",
		Appearance = "Appearance",
		AreaHealThreshold = "Area Heal Threshold:",
		Assist = "Assist Unit Before Casting",
		Attach = "Attach:",
		AttachTo = "To:",
		AttachToUnitFrame = "Attach To Unit Frame",
		Attack = "Attack",
		AutoUpdate = "Auto-Update to Next Rank",
		BarXOffset = "Bar X Offset",
		BarYOffset = "Bar Y Offset",
		Beast = "Beast",
		BindingBarLock = "Lock/Unlock Bars",
		BindingButtonLock = "Lock/Unlock Buttons",
		BindingClickboxes = "Hide/Show Clickboxes",
		BindingEmpty = "Toggle Empty Buttons",
		BindingLabels = "Toggle Bar Labels",
		BindingMiniSpellbook = "Toggle Mini-Spellbook",
		BindingOptions = "Toggle Options Window",
		Blessing = "Blessing",
		Button = "Button ",
		Button4 = "Button 4",
		Button5 = "Button 5",
		ButtonAlpha = "Button Transparency",
		ButtonRows = "Button Rows",
		ButtonSize = "Button Size",
		ButtonSpacing = "Button Spacing",
		CancelHealThreshold = "Cancel Spellcast Threshold:",
		CastOptions = "Cast Options",
		ChainHeal =  "Chain Heal",
		ClickboxLeftXOffset = "Clickbox Left X Offset",
		ClickboxRightXOffset = "Clickbox Right X Offset",
		ClickboxTopYOffset = "Clickbox Top Y Offset",
		ClickboxBottomYOffset = "Clickbox Bottom Y Offset",
		ClickCast = "ClickCast",
		CollapseHiddenButtons = "Collapse Hidden Buttons",
		Control = "Ctrl",
		CurseOfDoom = "Curse of Doom",
		DefaultFailedText = "My spellcast of $s on $t has failed!",
		DefaultInterruptedText = "My spellcast of $s on $t has been interrupted!",
		DefineFrames = "Define Frames",
		Demon = "Demon",
		DisableActionInProgressSpam = "Disable Spam: Another Action Is In Progress",
		DisableCantDoYetSpam = "Disable Spam: Can't Do That Yet",
		DisableGBSpam = "Disable Spam: Group Buttons",
		DisableOutOfRangeSpam = "Disable Spam: Out of Range",
		DisableTooltip = "Disable Tooltip",
		DispelMagic = "Dispel Magic",
		DisplayOptions = "Display Options",
		DoNotAttack = "Do Not Auto-Attack",
		DoNotTargetPet = "Do Not Target Pet on Shift-Click",
		DoNotUseSay = "Do not use say to announce",
		DoNotUseParty = "Do not use party chat to announce",
		DoNotUseRaid = "Do not use raid chat to announce",
		DoNotAnnounceSolo = "Do not announce when soloing",
		Dragonkin = "Dragonkin",
		Druid = "Druid",
		DynamicKeybindings = "Group Buttons Dynamic Hotkeys",
		Elemental = "Elemental",
		FailedText = "Cast Failed Text",
		FriendlyTarget = "Friendly Target",
		friendlytargetBarOptions = "FRIENDLY TARGET BAR OPTIONS",
		GroupButtons = "GROUP BUTTONS v"..GB_VERSION,
		HealCancelledMessage = "$s $r cancelled.  Target gained too much health.",
		HealPrevented = "Heal prevented.  Target hasn't taken enough damage.",
		HealthThreshold1 = "Health Threshold 1:",
		HealthThreshold2 = "Health Threshold 2:",
		HealthThreshold3 = "Health Threshold 3:",
		HealthThreshold4 = "Health Threshold 4:",
		HideBar = "Hide Bar",
		HideBaseBindings = "Hide Static Keybindings",
		HideClickboxes = "Hide Clickboxes",
		HideDynamicBindings = "Hide Dynamic Keybindings",
		HideLabels = "Hide Labels",
		HideEmpty = "Hide Empty",
		HostileTarget = "Hostile Target",
		hostiletargetBarOptions = "HOSTILE TARGET BAR OPTIONS",
		Humanoid = "Humanoid",
		Hunter = "Hunter",
		InterruptedText = "Cast Interrupted Text",
		Left = "Left",
		LevelTooLow = "Target level too low for any rank.",
		LockBars = "Lock Bars",
		LockButtons = "Lock Buttons",
		LowestHealth = "Lowest Health",
		LowestHealthBar = "Lowest Health Bar",
		lowesthealthBarOptions = "LOWEST HEALTH BAR OPTIONS",
		LowManaRank = "Cast Lower Rank When Mana's Low",
		Mage = "Mage",
		ManaBurn = "Mana Burn",
		ManaThreshold = "Mana Threshold:",
		MatchCastingTime = "Match Casting Time",
		MatchSpellName = "Match Spell Name",
		MiniSpellbook = "Mini Spellbook",
		MiscellaneousOptions = "MISCELLANEOUS OPTIONS",
		MiscOptions = "Misc Options",
		NoForm = "No Form",
		None = "None",
		NotEnoughMana = "Not enough mana.  Spell changed to $name $rank.",
		NumPartyToCheck = "Number of Party Members to Check:",
		Paladin = "Paladin",
		Party = "Party",
		Party1 = "Party 1 Bar",
		Party2 = "Party 2 Bar",
		Party3 = "Party 3 Bar",
		Party4 = "Party 4 Bar",
		partyBarOptions = "PARTY BARS OPTIONS",
		Pets = "Pets",
		playerBarOptions = "SELF BAR OPTIONS",
		POChangedSpell = "Prevent Overhealing changed spell to $name $rank.",
		PrayerOfHealing =  "Prayer of Healing",
		PreventOverhealing = "Prevent Overhealing",
		PreventOverhealingCancelThreshold = "Cancel Spellcast Threshold:",
		PreventRebuff = "Prevent Re-buff",
		PreventedRebuff = "Spellcast prevented.  Buff/Debuff found on target.",
		Priest = "Priest",
		Purify = "Purify",
		Raid = "Raid",
		Rank = "Rank ",
		RankScaled = "Target's level was too low.  Changed spell to $name $rank.",
		ResetBarLocation = "Reset Bar Location:",
		Right = "Right",
		Rogue = "Rogue",
		ScaleRank = "Scale Buff's Rank to Target's Level",
		Self = "Self",
		SelfBar = "Self Bar",
		SetDynamicKBToBar = "Group Buttons Set Dynamic Hotkeys to Bar:",
		SetThresholdValues = "SET THRESHOLD VALUES",
		Shaman = "Shaman",
		Shift = "Shift",
		ShowClickboxes = "Show Clickboxes",
		ShowEmpty = "Show Empty",
		ShowForClass = "Show For Classes:",
		ShowForForm = "Show For Shapeshift Form:",
		ShowIfValidTarget = "Show if Unit is a Valid Target",
		ShowInCombat = "Show When I'm In Combat",
		ShowLabels = "Show Labels",
		ShowNotInCombat = "Show When I'm Not In Combat",
		ShowOnMouseover = "Show On Mouseover",
		ShowWhen = "Show When:",
		Target = "Target",
		TargetBar = "Target Bar",
		Thresholds = "Thresholds",
		TurnOffAllAnnouncements = "Turn Off All Announcements",
		Undead = "Undead",
		UnlockBars = "Unlock Bars",
		UnlockButtons = "Unlock Buttons",
		ViperSting = "Viper Sting",
		Warlock = "Warlock",
		Warrior = "Warrior",
		WeakenedSoul = "Weakened Soul",

		BarsUnlockedWarning = "Your bars are unlocked.  Buttons will not be pressed until you lock the bars.",
		HideButton = "Hide Button",
		POkillChangedSpell = "Prevent Overkill changed spell to $name $rank.",
		PreventOverkill = "Prevent Overkill",
		SunderArmor = "Sunder Armor",
		DisablePartyRange = "Disable Out Of Range Indicator on the Party Bars",
		Middle = "Middle",
		DesperatePrayer = "Desperate Prayer",
		CancelHeal = "Cancel Spellcast if Target is Healed",
		DefaultLeftClick = "Old Left-Click:",
		DefaultRightClick = "Old Right-Click:",
		BindingBars = "Show/Hide All Bars",
		LayOnHands = "Lay on Hands",
		raidBarOptions = "RAID BAR OPTIONS",
		partypetBarOptions = "PARTY PET BAR OPTIONS",
		WhenOOC = "When Out of Context:",
		TooLowForAnyRank = "Mana too low for any rank.",
		TargetNotFound = "No target found for $n.",
		NoEffectsFound = "No curable effects found.",
		IncludePets = "Include Pets in the Lowest Health Bar",
		IncludeRaid = "Include Raid Members in the Lowest Health Bar",
		InnerFocus = "Inner Focus",
		Clearcasting = "Clearcasting",
		ShowCooldownCount = "Show Cooldown Count",
		FlashInContext = "Flash When In Context",
		Pet = "Pet",
		PartyPets = "Party Pets",
		Range = "Range",
		Mana = "Mana",
		Grey = "Grey",
		Silence = "Silence",
		NotPastCancelHeal = "Spellcast prevented.  Target isn't past the Cancel Heal Threshold.",
		petBarOptions = "PET BAR OPTIONS",
		RaidMembers = "Raid Members",
		SelectRaidMembers = "SELECT RAID MEMBERS",
		ApplyPOOnCtrl = "Apply Instead of Override Prevent Overhealing/kill When Ctrl is Pressed",
		Counterspell = "Counterspell",
		CheckAll = "Check All",
		Cannibalize = "Cannibalize",
		HideInRaid = "Hide Party Bars In Raids",
		ChangeTarget = "Change My Target When Casting",
		DisableGB = "Disable Group Buttons for this Character",
		PlayerOnly = "Show For Players Only",
		ModifyByUIScale = "Modify Cooldown Display\nby UI Scale",
		SendToChannel = "Announce to Channel: ",
		HolyNova = "Holy Nova",
		HealingBonus = "Healing Bonus:",
		SpiritOfRedemption = "Spirit of Redemption",
		Resurrection = "Resurrection",
		PowerInfusion = "Power Infusion",
		Shadowform = "Shadowform",
		AutoCancel = "Auto-cancel Shadowform / animal form",
		LimitLHRange = "Limit Lowest Health Bar Range",
		LimitAERange = "Limit Area Threshold Range"
	};

GB_CONTEXTS = {
		{ index = "Always", text = "Always Show" },
		{ index = "DmgGTHeal", text = "Unit Damage > Heal Amount" },
		{ index = "Health1", text = "Unit Past Health Threshold 1" },
		{ index = "Health2", text = "Unit Past Health Threshold 2" },
		{ index = "Health3", text = "Unit Past Health Threshold 3" },
		{ index = "Health4", text = "Unit Past Health Threshold 4" },
		{ index = "Mana", text = "Unit Past Mana Threshold" },
		{ index = "Area", text = "Party Past Area Threshold" },
		{ index = "NotBuffed", text = "Unit Isn't Buffed" },
		{ index = "NotDebuffed", text = "Unit Isn't Debuffed" },
		{ index = "MagicDebuffed", text = "Unit Is Magic Debuffed" },
		{ index = "Cursed", text = "Unit Is Cursed" },
		{ index = "Diseased", text = "Unit Is Diseased" },
		{ index = "Poisoned", text = "Unit Is Poisoned" },
		{ index = "Dead", text = "Unit Is Dead" }
	}

GB_MINLVL_SPELLS = {
		AbolishDisease = "Abolish Disease",
		AbolishPoison = "Abolish Poison",
		AmplifyMagic = "Amplify Magic",
		ArcaneIntellect = "Arcane Intellect",
		Blessing = "Blessing of",
		BlessingFreedom = "Blessing of Freedom",
		BlessingKings = "Blessing of Kings",
		BlessingLight = "Blessing of Light",
		BlessingMight = "Blessing of Might",
		BlessingProtection = "Blessing of Protection",
		BlessingSacrifice = "Blessing of Sacrifice",
		BlessingSalvation = "Blessing of Salvation",
		BlessingSanctuary = "Blessing of Sanctuary",
		BlessingWisdom = "Blessing of Wisdom",
		DampenMagic = "Dampen Magic",
		DesperatePrayer = "Desperate Prayer",
		DispelMagic = "Dispel Magic",
		DivineSpirit = "Divine Spirit",
		MarkOfTheWild = "Mark of the Wild",
		PWFortitude = "Power Word: Fortitude",
		PWShield = "Power Word: Shield",
		Regrowth = "Regrowth",
		Rejuvenation = "Rejuvenation",
		Renew = "Renew",
		ShadowProtection = "Shadow Protection",
		Thorns = "Thorns"
	};

GB_AREA_BUFFS = {
		[GB_MINLVL_SPELLS.PWFortitude] = "Prayer of Fortitude",
		["Prayer of Fortitude"] = GB_MINLVL_SPELLS.PWFortitude,
		[GB_MINLVL_SPELLS.MarkOfTheWild] = "Gift of the Wild",
		["Gift of the Wild"] = GB_MINLVL_SPELLS.MarkOfTheWild,
		[GB_MINLVL_SPELLS.ArcaneIntellect] = "Arcane Brilliance",
		["Arcane Brilliance"] = GB_MINLVL_SPELLS.ArcaneIntellect,
		["Prayer of Spirit"] = GB_MINLVL_SPELLS.DivineSpirit,
		[GB_MINLVL_SPELLS.DivineSpirit] = "Prayer of Spirit",
		["Prayer of Shadow Protection"] = GB_MINLVL_SPELLS.ShadowProtection,
		[GB_MINLVL_SPELLS.ShadowProtection] = "Prayer of Shadow Protection",
		[GB_MINLVL_SPELLS.BlessingKings] = "Greater Blessing of Kings",
		["Greater Blessing of Kings"] = GB_MINLVL_SPELLS.BlessingKings,
		[GB_MINLVL_SPELLS.BlessingLight] = "Greater Blessing of Light",
		["Greater Blessing of Light"] = GB_MINLVL_SPELLS.BlessingLight,
		[GB_MINLVL_SPELLS.BlessingMight] = "Greater Blessing of Might",
		["Greater Blessing of Might"] = GB_MINLVL_SPELLS.BlessingMight,
		[GB_MINLVL_SPELLS.BlessingWisdom] = "Greater Blessing of Wisdom",
		["Greater Blessing of Wisdom"] = GB_MINLVL_SPELLS.BlessingWisdom,
		[GB_MINLVL_SPELLS.BlessingSalvation] = "Greater Blessing of Salvation",
		["Greater Blessing of Salvation"] = GB_MINLVL_SPELLS.BlessingSalvation,
		[GB_MINLVL_SPELLS.BlessingSanctuary] = "Greater Blessing of Sanctuary",
		["Greater Blessing of Sanctuary"] = GB_MINLVL_SPELLS.BlessingSanctuary,
	};

GB_TARGET_SPELLS = {
		["Banish"] = { [GB_TEXT.Demon] = true, [GB_TEXT.Elemental] = true },
		["Beast Lore"] = { [GB_TEXT.Beast] = true },
		["Enslave Demon"] = { [GB_TEXT.Demon] = true },
		["Exorcism"] = { [GB_TEXT.Undead] = true, [GB_TEXT.Demon] = true },
		["Hibernate"] = { [GB_TEXT.Dragonkin] = true, [GB_TEXT.Beast] = true },
		["Mind Control"] = { [GB_TEXT.Humanoid] = true },
		["Mind Soothe"] = { [GB_TEXT.Humanoid] = true },
		["Polymorph"] = { [GB_TEXT.Humanoid] = true, [GB_TEXT.Beast] = true, ["Critter"] = true },
		["Sap"] = { [GB_TEXT.Humanoid] = true },
		["Scare Beast"] = { [GB_TEXT.Beast] = true },
		["Shackle Undead"] = { [GB_TEXT.Undead] = true },
		["Soothe Animal"] = { [GB_TEXT.Beast] = true },
		["Turn Undead"] = { [GB_TEXT.Undead] = true },
		["Holy Wrath"] = { [GB_TEXT.Undead] = true, [GB_TEXT.Demon] = true }
	};

GB_ANCHOR_POINTS = {
		{ text="TOPLEFT", value="TOPLEFT" },
		{ text="TOP", value="TOP" },
		{ text="TOPRIGHT", value="TOPRIGHT" },
		{ text="LEFT", value="LEFT" },
		{ text="CENTER", value="CENTER" },
		{ text="RIGHT", value="RIGHT" },
		{ text="BOTTOMLEFT", value="BOTTOMLEFT" },
		{ text="BOTTOM", value="BOTTOM" },
		{ text="BOTTOMRIGHT", value="BOTTOMRIGHT" }
	};

GB_OOC_MENU = {
		{ text="Hide", value="hide" },
		{ text="Grey Out", value="grey" },
		{ text="Flash", value="flash" }
	};

GB_CURES = {
		CureDisease = { text="Cure Disease", effects={GB_FILTERS.Disease} },
		AbolishDisease = { text=GB_MINLVL_SPELLS.AbolishDisease, effects = {GB_FILTERS.Disease} },
		AbolishPoison = { text=GB_MINLVL_SPELLS.AbolishPoison, effects = {GB_FILTERS.Poison} },
		DispelMagic = { text=GB_TEXT.DispelMagic, effects = {GB_FILTERS.Magic} },
		RemoveCurse = { text="Remove Curse", effects = {GB_FILTERS.Curse} },
		Purify = { text=GB_TEXT.Purify, effects = {GB_FILTERS.Disease, GB_FILTERS.Poison} },
		Cleanse = { text="Cleanse", effects = {GB_FILTERS.Disease, GB_FILTERS.Poison, GB_FILTERS.Magic} },
		CurePoison = { text = "Cure Poison", effects = {GB_FILTERS.Poison} }
	};

GB_HELP_TEXT = {
	"GROUP BUTTONS v"..GB_VERSION,
	"---------------------------------",
	"/gb - Toggles the options window",
	"/gb hidebar bartype - Hides a group of bars.  Valid bartypes are player, pet, party, partypet, raid, lowesthealth, friendlytarget, hostiletarget.",
	"/gb showbar bartype - Shows a group of bars.",
	"/gb toggle labels - Toggles the bar labels",
	"/gb toggle empty - Toggles display of buttons without actions",
	"/gb toggle spellbook - Toggles display of the minispellbook",
	"/gb toggle barlock - Locks and unlocks the bars for dragging",
	"/gb toggle buttonlock - Locks and unlocks actions in buttons to prevent or enable dragging them out",
	"/gb setkeybar bar - Sets your dynamic keybindings to the specified bar.  Valid bars are: self, party1, party2, party3, party4, target",
	"/gb useaction bar button - Presses the specified button on the specified bar using its action with all of Group Buttons's options enabled.  Valid bars are self, party1, party2, party3, party4, friendlytarget, hostiletarget and button is a number from 1 to 20",
	"/gb clearall - Erases all settings for the current character",
	"/gb updateranges - Forces the mod to check your regular actions for spells to match with your target buttons for range checking",
	"/gb updatespells - Forces the mod to rebuild its internal spell data table.  This can fix it when Prevent Overhealing and other options stop working.",
	"/gb spelldata spellname - You can use this command to see all the data the mod keeps on a particular spell.  Don't include the rank in spellname.  You don't have to type the full spellname."
}

--**************************************************
--           GERMAN TRANSLATIONS
--      A great many thanks to Boergen!
--**************************************************
if (GetLocale() == "deDE") then

-- Translate only what's shown in quotes.
GB_TEXT_OPTIONS = "Optionen";
GB_APPEARANCE = "AUSSEHEN";
GB_MINISPELLBOOK = "GROUP BUTTONS SPRUCHBUCH";
GB_DEFAULT_ANNOUNCE_TEXT = "Spreche $s $r auf $t.";
GB_ANNOUNCE_HELP_TEXT = "$t f\195\188r Namen des Ziels, $s f\195\188r Namen des Spruches, $r f\195\188r Rang des Spruches,\n$c for Wirkzeit, $a f\195\188r Heilbetrag, $m f\195\188r Prozent von \195\188brig gebliebener Mana";
GB_COPY_BAR_SETTINGS = "Leisten Einstellungen kopieren:";
GB_COPY = "KOPIEREN";
GB_RESET = "RESET";
GB_RAID_MEMBER_HEADER = "Check the raid members for whom you want a bar to display.";

-- Translate only the labels
GB_UNITS_ARRAY = {
player = { frames = { "GB_PlayerBar" }, labels = { "EIGEN" }, buttons = 20 },
party = { frames = { "GB_PartyBar1", "GB_PartyBar2", "GB_PartyBar3", "GB_PartyBar4" }, labels = { "MITGLIED 1", "MITGLIED 2", "MITGLIED 3", "MITGLIED 4" }, buttons = 20 },
friendlytarget = { frames = { "GB_FriendlyTargetBar" }, labels = { "FREUNDLICHES ZIEL" }, buttons = 20 },
hostiletarget = { frames = { "GB_HostileTargetBar" }, labels = { "FEINDLICHES ZIEL" }, buttons = 20 },
lowesthealth = { frames = { "GB_LowestHealthBar" }, labels = { "NIEDRIGSTE GESUNDHEIT" }, buttons = 20 },
pet = { frames = {"GB_PetBar0"}, labels = {"PET"}, buttons = 6 },
partypet = { frames = {"GB_PetBar1", "GB_PetBar2", "GB_PetBar3", "GB_PetBar4"}, labels = {"GRUPPEN PET 1", "GRUPPEN PET 2", "GRUPPEN PET 3", "GRUPPEN PET 4"}, buttons = 6 },
raid = { frames = {"GB_RaidBar1", "GB_RaidBar2", "GB_RaidBar3", "GB_RaidBar4", "GB_RaidBar5", "GB_RaidBar6", "GB_RaidBar7", "GB_RaidBar8", "GB_RaidBar9", "GB_RaidBar10", "GB_RaidBar11", "GB_RaidBar12", "GB_RaidBar13", "GB_RaidBar14", "GB_RaidBar15", "GB_RaidBar16", "GB_RaidBar17", "GB_RaidBar18", "GB_RaidBar19", "GB_RaidBar20", "GB_RaidBar21", "GB_RaidBar22", "GB_RaidBar23", "GB_RaidBar24", "GB_RaidBar25", "GB_RaidBar26", "GB_RaidBar27", "GB_RaidBar28", "GB_RaidBar29", "GB_RaidBar30", "GB_RaidBar31", "GB_RaidBar32", "GB_RaidBar33", "GB_RaidBar34", "GB_RaidBar35", "GB_RaidBar36", "GB_RaidBar37", "GB_RaidBar38", "GB_RaidBar39", "GB_RaidBar40"}, labels = {"RAID 1", "RAID 2", "RAID 3", "RAID 4", "RAID 5", "RAID 6", "RAID 7", "RAID 8", "RAID 9", "RAID 10", "RAID 11", "RAID 12", "RAID 13", "RAID 14", "RAID 15", "RAID 16", "RAID 17", "RAID 18", "RAID 19", "RAID 20", "RAID 21", "RAID 22", "RAID 23", "RAID 24", "RAID 25", "RAID 26", "RAID 27", "RAID 28", "RAID 29", "RAID 30", "RAID 31", "RAID 32", "RAID 33", "RAID 34", "RAID 35", "RAID 36", "RAID 37", "RAID 38", "RAID 39", "RAID 40"}, buttons = 6 }
};

-- These are found in a spell's tooltip. Translate only what's shown in quotes.
GB_FILTERS = {
CastingTime = "Wirken in ([,.%d]*) Sek.",
Curse = "Fluch",
Damage = "SCHADEN",
Disease = "Krankheit",
Heal = "HEIL[^I]",
Over = " over ",
DamageOverTime = "(%d[^%s]*) %a* damage over (%d*) sec",
HealOverTime = "(%d[^%s]*) over (%d*) sec",
DruidHealOverTime = "(%d[^%s]*) over (%d*) sec",
Magic = "Magie",
Mana = "(%d*) Mana",
Poison = "Gift",
Range = "(%d*) m Reichweite",
To = "(%d+[.%d]*) bis (%d+[.%d]*)",
		Energy = "(%d*) Energie",
		Rage = "(%d*) Wut"
}

--Translate only what is shown in quotes
GB_TEXT = {
Actions = "Aktionen",
AdjustClickbox = "Klickbox anpassen:",
Alt = "Alt",
AnchorPoint = "Anheft Punkt:",
AnchorTo = "Anheften An:",
Announce = "Spruchwirken ank\195\188ndigen",
AnnounceFailures = "Fehlgeschlagene Spr\195\188che ank\195\188ndigen",
AnnounceInterrupts = "Unterbrochene Spr\195\188che ank\195\188ndigen",
AnnounceNum = "Verwende Ank\195\188ndigung Nr:",
AnnounceOptions = "Ank\195\188ndigungs Optionen",
AnnounceOptions2 = "ANK\195\156NDIGUNGS OPTIONEN",
AnnounceText = "Ank\195\188ndigungs Text ",
Appearance = "Aussehen",
AreaHealThreshold = "Fl\195\164chenheilungs-Schwelle:",
Assist = "Ziel assisten vor dem Wirken",
Attach = "Anheften:",
AttachTo = "An:",
AttachToUnitFrame = "Anheften an Rahmen der Einheit",
Attack = "Angreifen",
AutoUpdate = "Auto-Update zum n\195\164chsten Rang",
BarXOffset = "Leiste X Ausgleich",
BarYOffset = "Leiste Y Ausgleich",
Beast = "Wildtier",
BindingBarLock = "Leisten Fixieren/L\195\182sen",
BindingButtonLock = "Buttons Fixieren/L\195\182sen",
BindingClickboxes = "Klickboxen Verstecken/Anzeigen",
BindingEmpty = "Leere Buttons ein/aus",
BindingLabels = "Leisten-Namen ein/aus",
BindingMiniSpellbook = "Mini-Spruchbuch ein/aus",
BindingOptions = "Optionen Fenster ein/aus",
Blessing = "Segen",
Button = "Button ",
ButtonAlpha = "Button Transparenz",
ButtonRows = "Button Reihen",
ButtonSize = "Button Gr\195\182\195\159e",
ButtonSpacing = "Button Abstand",
CancelHealThreshold = "Verhindern von \195\156berheilung: Abbruch-Schwelle:",
CastOptions = "Wirk-Optionen",
ChainHeal = "Kettenheilung",
ClickboxLeftXOffset = "Klickbox Linker X Ausgleich",
ClickboxRightXOffset = "Klickbox Rechter X Ausgleich",
ClickboxTopYOffset = "Klickbox Oberer Y Ausgleich",
ClickboxBottomYOffset = "Klickbox Unterer Y Ausgleich",
ClickCast = "KlickCast",
CollapseHiddenButtons = "Versteckte Buttons zusammenklappen",
Control = "Strg",
CurseOfDoom = "Fluch der Verdammnis",
DefaultFailedText = "Mein Wirken von $s auf $t ist gescheitert!",
DefaultInterruptedText = "Mein Wirken von $s auf $t wurde unterbrochen!",
DefineFrames = "Rahmen definieren",
Demon = "D\195\164mon",
DisableActionInProgressSpam = "Spam verhindern: Eine andere Aktion wird ausgef\195\188hrt",
DisableCantDoYetSpam = "Spam verhindern: Kann ich noch nicht machen",
DisableGBSpam = "Spam verhindern: Group Buttons",
DisableOutOfRangeSpam = "Spam verhindern: Au\195\159er Reichweite",
DisableTooltip = "Tooltip ausschalten",
DispelMagic = "Magiebannung",
DisplayOptions = "Anzeige Optionen",
DoNotAttack = "Nicht Auto-Angreifen",
DoNotTargetPet = "Nicht Pet anw\195\164hlen beim Shift-Klick",
DoNotUseSay = "Nicht Sagen-Channel benutzen beim Ank\195\188ndigen",
DoNotUseParty = "Nicht den Partychannel benutzen beim Ank\195\188ndigen",
DoNotUseRaid = "Nicht den Raidchannel benutzen beim Ank\195\188ndigen",
DoNotAnnounceSolo = "Nicht Ank\195\188ndigen beim Solospiel",
Dragonkin = "Drachkin",
Druid = "Druide",
DynamicKeybindings = "Dynamische Hotkeys",
Elemental = "Elementargeist",
FailedText = "Text beim gescheiterten Wirken",
FriendlyTarget = "Freundliches Ziel",
friendlytargetBarOptions = "FREUNDLICHES ZIEL - LEISTE OPTIONEN",
GroupButtons = "GROUP BUTTONS v"..GB_VERSION,
HealCancelledMessage = "$s $r abgebrochen. Ziel bekam zu viele Hitpoints.",
HealPrevented = "Heilung verhindert. Ziel hatte nicht genug Schaden.",
HealthThreshold1 = "Gesundheits Schwelle 1:",
HealthThreshold2 = "Gesundheits Schwelle 2:",
HealthThreshold3 = "Gesundheits Schwelle 3:",
HealthThreshold4 = "Gesundheits Schwelle 4:",
HideBar = "Leiste verstecken",
HideBaseBindings = "Verstecke feste Tastenbindungen",
HideClickboxes = "Verstecke Klickboxen",
HideDynamicBindings = "Verstecke dynamische Tastenbindungen",
HideLabels = "Verstecke Bezeichnungen",
HideEmpty = "Verstecke Leere",
HostileTarget = "Feindliches Ziel",
hostiletargetBarOptions = "FEINDLICHES ZIEL - LEISTE OPTIONEN",
Humanoid = "Humanoid",
Hunter = "J\195\164ger",
InterruptedText = "Unterbrochenes Wirken Text",
Left = "Links",
LevelTooLow = "Level des Ziels zu gering f\195\188r jeden Rang.",
LockBars = "Fixiere Leisten",
LockButtons = "Fixiere Buttons",
LowestHealth = "Geringste Gesundheit",
LowestHealthBar = "Geringste Gesundheit - Leiste",
lowesthealthBarOptions = "GERINGSTE GESUNDHEIT - LEISTE OPTIONEN",
LowManaRank = "Geringeren Rang wirken wenn Mana zu niedrig",
Mage = "Magier",
ManaBurn = "Manabrand",
ManaThreshold = "Mana Schwelle:",
MatchCastingTime = "Wirkzeit angleichen",
MatchSpellName = "Spruchname angleichen",
MiniSpellbook = "Mini Spruchbuch",
MiscellaneousOptions = "VERSCHIEDENE OPTIONEN",
MiscOptions = "Verschiedene Optionen",
NoForm = "Keine Form",
None = "Nichts",
NotEnoughMana = "Nicht genug Mana. Spruch ge\195\164ndert in $name $rank.",
NumPartyToCheck = "Anzahl der zu \195\188berpr\195\188fenden Gruppenmitglieder:",
Paladin = "Paladin",
Party = "Gruppe",
Party1 = "Mitglied 1 Leiste",
Party2 = "Mitglied 2 Leiste",
Party3 = "Mitglied 3 Leiste",
Party4 = "Mitglied 4 Leiste",
partyBarOptions = "GRUPPEN LEISTEN OPTIONEN",
Pets = "Pets",
playerBarOptions = "EIGENE LEISTE OPTIONEN",
POChangedSpell = "Verhindern von \195\156berheilung \195\164nderte Spruch in $name $rank.",
PrayerOfHealing = "Gebet der Heilung",
PreventOverhealing = "Verhindern von \195\156berheilung",
PreventOverhealingCancelThreshold = "Spruch-Abbruch Schwelle:",
PreventRebuff = "Re-buff Verhindern",
PreventedRebuff = "Spruchwirken verhindert. Buff/Debuff auf Ziel gefunden.",
Priest = "Priester",
Purify = "L\195\164utern",
Raid = "Raid",
Rank = "Rang ",
RankScaled = "Level des Ziels war zu gering. Spruch ge\195\164ndert in $name $rank.",
ResetBarLocation = "Reset Leisten Position:",
Right = "Rechts",
Rogue = "Schurke",
ScaleRank = "Buff Rang an Ziel-Level anpassen",
Self = "Eigen",
SelfBar = "Eigen Leiste",
SetDynamicKBToBar = "Binde Dynamische Hotkeys an Leiste:",
SetThresholdValues = "SETZE SCHWELLEN WERTE",
Shaman = "Schamane",
Shift = "Shift",
ShowClickboxes = "Klickboxen anzeigen",
ShowEmpty = "Leere anzeigen",
ShowForClass = "Anzeigen f\195\188r Klassen:",
ShowForForm = "Anzeigen f\195\188r Verwandlungs-Form:",
ShowIfValidTarget = "Anzeigen wenn Einheit ein g\195\188ltiges Ziel ist",
ShowInCombat = "Anzeigen wenn ich im Kampf bin",
ShowLabels = "Bezeichnungen anzeigen",
ShowNotInCombat = "Anzeigen wenn ich nicht im Kampf bin",
ShowOnMouseover = "Anzeigen bei Mouseover",
ShowWhen = "Anzeigen wenn:",
Target = "Ziel",
TargetBar = "Ziel Leiste",
Thresholds = "Schwellen",
TurnOffAllAnnouncements = "Deaktiviere alle Ank\195\188ndigungen",
Undead = "Untoter",
UnlockBars = "L\195\182se Leisten",
UnlockButtons = "L\195\182se Buttons",
Warlock = "Hexenmeister",
Warrior = "Krieger",
WeakenedSoul = "Geschw\195\164chte Seele",
BarsUnlockedWarning = "Leisten sind gel\195\182st. Buttons k\195\182nnen nicht gedr\195\188ckt werden, bis die Leisten fixiert sind.",
HideButton = "Verstecke Button",
POkillChangedSpell = "Verhindern von Overkill \195\164nderte Spruch in $name $rank.",
PreventOverkill = "Verhindern von Overkill",
SunderArmor = "R\195\188stung zerrei\195\159en",
DisablePartyRange = "Deaktiviere Ausser-Reichweite Indikator in den Gruppe Leisten",
Middle = "Mittel",
DesperatePrayer = "Verzweifeltes Gebet",
CancelHeal = "Spruchwirken unterbrechen wenn Ziel geheilt wird",
DefaultLeftClick = "Alter Links-Klick:",
DefaultRightClick = "Alter Rechts-Klick:",
ViperSting = "Schlangenbiss",
BindingBars = "Zeige/Verstecke alle Leisten",
LayOnHands = "Handauflegung",
raidBarOptions = "RAID LEISTE OPTIONEN",
petBarOptions = "PET LEISTE OPTIONEN",
WhenOOC = "Wenn nicht im Kontext:",
Button4 = "Button 4",
Button5 = "Button 5",
TooLowForAnyRank = "Mana zu niedrig f\195\188r jeden Rang.",
TargetNotFound = "Kein Ziel gefunden f\195\188r $n.",
NoEffectsFound = "Keine kurierbaren Effekte gefunden.",
IncludePets = "Beziehe Pets in die Niedrigste Gesundheit Leiste ein",
IncludeRaid = "Beziehe Raidmitglieder in die Niedrigste Gesundheit Leiste ein",
InnerFocus = "Innerer Fokus",
Clearcasting = "Freizauber",
ShowCooldownCount = "Zeige Cooldown",
FlashInContext = "Blinke wenn im Kontext",
Pet = "Pet",
PartyPets = "Gruppen Pets",
Range = "Reichweite",
Mana = "Mana",
Grey = "Grau",
Silence = "Stille",
NotPastCancelHeal = "Spruchwirken verhindert. Ziel nicht \195\188ber der Heilabbruch Schwelle.",
partypetBarOptions = "GRUPPEN PET LEISTE OPTIONEN",
RaidMembers = "Raid Mitglieder",
SelectRaidMembers = "WAEHLE RAID MITGLIEDER",
ApplyPOOnCtrl = "Aktiviere das Verhindern von \195\188berheilen/Overkill nur wenn Strg gedr\195\188ckt wird",
Counterspell = "Gegenzauber",
CheckAll = "Alles ausw\195\164hlen",
Cannibalize = "Kannibalismus",
HideInRaid = "Verstecke Gruppen Leisten in Raids",
ChangeTarget = "Ziel wechseln beim Zaubern",
DisableGB = "Deaktiviere Group Buttons f\195\188r diesen Charakter",
PlayerOnly = "Nur f\195\188r Spieler anzeigen",

ModifyByUIScale = "Modify Cooldown Display\nby UI Scale",
		SendToChannel = "Announce to Channel: ",
		HolyNova = "Holy Nova",
		HealingBonus = "Healing Bonus:",
		SpiritOfRedemption = "Geist der Erl\195\182sung",
		Resurrection = "Resurrection",
		PowerInfusion = "Power Infusion",
		Shadowform = "Shadowform",
		AutoCancel = "Auto-cancel Shadowform / animal form",
		LimitLHRange = "Limit Lowest Health Bar Range",
		LimitAERange = "Limit Area Threshold Range"
};

-- Translate only what appears in quotes after text =
GB_CONTEXTS = {
{ index = "Always", text = "Immer anzeigen" },
{ index = "DmgGTHeal", text = "Einheit Schaden > Heilbetrag" },
{ index = "Health1", text = "Einheit \195\188ber Gesundheits Schwelle 1" },
{ index = "Health2", text = "Einheit \195\188ber Gesundheits Schwelle 2" },
{ index = "Health3", text = "Einheit \195\188ber Gesundheits Schwelle 3" },
{ index = "Health4", text = "Einheit \195\188ber Gesundheits Schwelle 4" },
{ index = "Mana", text = "Einheit \195\188ber Mana Schwelle" },
{ index = "Area", text = "Gruppe \195\188ber Fl\195\164chen Schwelle" },
{ index = "NotBuffed", text = "Einheit nicht gebufft" },
{ index = "NotDebuffed", text = "Einheite nicht debufft" },
{ index = "MagicDebuffed", text = "Einheit ist Magie debufft" },
{ index = "Cursed", text = "Einheit ist verflucht" },
{ index = "Diseased", text = "Einheit ist Krank" },
{ index = "Poisoned", text = "Einheit ist vergiftet" },
{ index = "Dead", text = "Einheit ist tot" }
}

-- Translate only the spell names that appear in quotes
GB_MINLVL_SPELLS = {
AbolishDisease = "Krankheit aufheben",
AbolishPoison = "Vergiftung heilen",
AmplifyMagic = "Magie verst\195\164rken",
ArcaneIntellect = "Arkane Intelligenz",
Blessing = "Segen",
BlessingFreedom = "Segen der Freiheit",
BlessingKings = "Segen der K\195\182nige",
BlessingLight = "Segen des Lichts",
BlessingMight = "Segen der Macht",
BlessingProtection = "Segen des Schutzes",
BlessingSacrifice = "Segen der Opferung",
BlessingSalvation = "Segen der Rettung",
BlessingSanctuary = "Segen des Refugiums",
BlessingWisdom = "Segen der Weisheit",
DampenMagic = "Magied\195\164mpfer",
DesperatePrayer = "Verzweifeltes Gebet",
DispelMagic = "Magiebannung",
DivineSpirit = "G\195\182ttlicher Willen",
MarkOfTheWild = "Mal der Wildnis",
PWFortitude = "Machtwort: Seelenst\195\164rke",
PWShield = "Machtwort: Schild",
Regrowth = "Nachwachsen",
Rejuvenation = "Verj\195\188ngung",
Renew = "Erneuerung",
ShadowProtection = "Schattenschutz",
Thorns = "Dornen"
};

-- Translate only the spell names that appear in quotes on either side of the =
GB_AREA_BUFFS = {
[GB_MINLVL_SPELLS.PWFortitude] = "Gebet der Seelenst\195\164rke",
["Gebet der Seelenst\195\164rke"] = GB_MINLVL_SPELLS.PWFortitude,
[GB_MINLVL_SPELLS.MarkOfTheWild] = "Gabe der Wildnis",
["Gabe der Wildnis"] = GB_MINLVL_SPELLS.MarkOfTheWild,
[GB_MINLVL_SPELLS.ArcaneIntellect] = "Arkane Brillanz",
["Arkane Brillanz"] = GB_MINLVL_SPELLS.ArcaneIntellect,
		["Gebet der Willenskraft"] = GB_MINLVL_SPELLS.DivineSpirit,
		[GB_MINLVL_SPELLS.DivineSpirit] = "Gebet der Willenskraft",
		["Gebet des Schattenschutzes"] = GB_MINLVL_SPELLS.ShadowProtection,
		[GB_MINLVL_SPELLS.ShadowProtection] = "Gebet des Schattenschutzes",

		[GB_MINLVL_SPELLS.BlessingKings] = "Greater Blessing of Kings",
		["Greater Blessing of Kings"] = GB_MINLVL_SPELLS.BlessingKings,
		[GB_MINLVL_SPELLS.BlessingLight] = "Greater Blessing of Light",
		["Greater Blessing of Light"] = GB_MINLVL_SPELLS.BlessingLight,
		[GB_MINLVL_SPELLS.BlessingMight] = "Greater Blessing of Might",
		["Greater Blessing of Might"] = GB_MINLVL_SPELLS.BlessingMight,
		[GB_MINLVL_SPELLS.BlessingWisdom] = "Greater Blessing of Wisdom",
		["Greater Blessing of Wisdom"] = GB_MINLVL_SPELLS.BlessingWisdom,
		[GB_MINLVL_SPELLS.BlessingSalvation] = "Greater Blessing of Salvation",
		["Greater Blessing of Salvation"] = GB_MINLVL_SPELLS.BlessingSalvation,
		[GB_MINLVL_SPELLS.BlessingSanctuary] = "Greater Blessing of Sanctuary",
		["Greater Blessing of Sanctuary"] = GB_MINLVL_SPELLS.BlessingSanctuary,
};

-- Translate only the spell names that appear in quotes.
GB_TARGET_SPELLS = {
["Verbannen"] = { [GB_TEXT.Demon] = true, [GB_TEXT.Elemental] = true },
["Wildtierlehre"] = { [GB_TEXT.Beast] = true },
["D\195\164monensklave"] = { [GB_TEXT.Demon] = true },
["Exorzismus"] = { [GB_TEXT.Undead] = true, [GB_TEXT.Demon] = true },
["Winterschlaf"] = { [GB_TEXT.Dragonkin] = true, [GB_TEXT.Beast] = true },
["Gedankenkontrolle"] = { [GB_TEXT.Humanoid] = true },
["Gedankenbes\195\164nftigung"] = { [GB_TEXT.Humanoid] = true },
["Verwandlung"] = { [GB_TEXT.Humanoid] = true, [GB_TEXT.Beast] = true, ["Critter"] = true },
["Kopfnuss"] = { [GB_TEXT.Humanoid] = true },
["Wildtier aufscheuchen"] = { [GB_TEXT.Beast] = true },
["Untote fesseln"] = { [GB_TEXT.Undead] = true },
["Tier bes\195\164nftigen"] = { [GB_TEXT.Beast] = true },
["Untote vertreiben"] = { [GB_TEXT.Undead] = true },
["Heiliger Zorn"] = { [GB_TEXT.Undead] = true, [GB_TEXT.Demon] = true } 
};

-- Translate only what appears in quotes after text=
GB_ANCHOR_POINTS = {
{ text="OBEN LINKS", value="TOPLEFT" },
{ text="OBEN", value="TOP" },
{ text="OBEN RECHTS", value="TOPRIGHT" },
{ text="LINKS", value="LEFT" },
{ text="MITTE", value="CENTER" },
{ text="RECHTS", value="RIGHT" },
{ text="UNTEN LINKS", value="BOTTOMLEFT" },
{ text="UNTEN", value="BOTTOM" },
{ text="UNTEN RECHTS", value="BOTTOMRIGHT" }
};

GB_CURES = {
CureDisease = { text="Krankheit heilen", effects={GB_FILTERS.Disease} },
AbolishDisease = { text=GB_MINLVL_SPELLS.AbolishDisease, effects = {GB_FILTERS.Disease} },
AbolishPoison = { text=GB_MINLVL_SPELLS.AbolishPoison, effects = {GB_FILTERS.Poison} },
DispelMagic = { text=GB_TEXT.DispelMagic, effects = {GB_FILTERS.Magic} },
RemoveCurse = { text="Fluch aufheben", effects = {GB_FILTERS.Curse} },
Purify = { text=GB_TEXT.Purify, effects = {GB_FILTERS.Disease, GB_FILTERS.Poison} },
Cleanse = { text="S\195\164ubern", effects = {GB_FILTERS.Disease, GB_FILTERS.Poison, GB_FILTERS.Magic} },
CurePoison = { text = "Vergiftung Aufheben", effects = {GB_FILTERS.Poison} } 
	};
end 

--**************************************************
--           FRENCH TRANSLATIONS
--       Many, many thanks to IDispatch!
--**************************************************
if (GetLocale() == "frFR") then

-- Translate only what's shown in quotes.
GB_TEXT_OPTIONS = "Options";
GB_APPEARANCE = "APPARENCE";
GB_MINISPELLBOOK = "GRIMOIRE GROUP BUTTONS";
GB_DEFAULT_ANNOUNCE_TEXT = "Lancement de $s $r sur $t.";
GB_ANNOUNCE_HELP_TEXT = "Utilisez $t pour le nom de la cible, $s pour le nom du sort, $r pour le rank,\n$c pour le temp d'incantation, $a pour quantit\195\169 de vie,\n$m pour le pourcentage de mana qu'il vous reste";
GB_COPY_BAR_SETTINGS = "Copier r\195\170glages:";
GB_COPY = "COPIER";
GB_RESET = "RESET";
GB_RAID_MEMBER_HEADER = "Check the raid members for whom you want a bar to display.";

-- Translate only the labels
GB_UNITS_ARRAY = {
		player = { frames = { "GB_PlayerBar" }, labels = { "MOI" }, buttons = 20 },
		party = { frames = { "GB_PartyBar1", "GB_PartyBar2", "GB_PartyBar3", "GB_PartyBar4" }, labels = { "MEMBRE 1", "MEMBRE 2", "MEMBRE 3", "MEMBRE 4" }, buttons = 20 },
		friendlytarget = { frames = { "GB_FriendlyTargetBar" }, labels = { "CIBLE AMIE" }, buttons = 20 },
		hostiletarget = { frames = { "GB_HostileTargetBar" }, labels = { "CIBLE ENNEMIE" }, buttons = 20 },
		lowesthealth = { frames = { "GB_LowestHealthBar" }, labels = { "VIE FAIBLE" }, buttons = 20 },
		pet = { frames = {"GB_PetBar0"}, labels = {"PET"}, buttons = 6 },
		partypet = { frames = {"GB_PetBar1", "GB_PetBar2", "GB_PetBar3", "GB_PetBar4"}, labels = { "PARTY PET 1", "PARTY PET 2", "PARTY PET 3", "PARTY PET 4"}, buttons = 6 },
		raid = { frames = {"GB_RaidBar1", "GB_RaidBar2", "GB_RaidBar3", "GB_RaidBar4", "GB_RaidBar5", "GB_RaidBar6", "GB_RaidBar7", "GB_RaidBar8", "GB_RaidBar9", "GB_RaidBar10", "GB_RaidBar11", "GB_RaidBar12", "GB_RaidBar13", "GB_RaidBar14", "GB_RaidBar15", "GB_RaidBar16", "GB_RaidBar17", "GB_RaidBar18", "GB_RaidBar19", "GB_RaidBar20", "GB_RaidBar21", "GB_RaidBar22", "GB_RaidBar23", "GB_RaidBar24", "GB_RaidBar25", "GB_RaidBar26", "GB_RaidBar27", "GB_RaidBar28", "GB_RaidBar29", "GB_RaidBar30", "GB_RaidBar31", "GB_RaidBar32", "GB_RaidBar33", "GB_RaidBar34", "GB_RaidBar35", "GB_RaidBar36", "GB_RaidBar37", "GB_RaidBar38", "GB_RaidBar39", "GB_RaidBar40"}, labels = {"RAID 1", "RAID 2", "RAID 3", "RAID 4", "RAID 5", "RAID 6", "RAID 7", "RAID 8", "RAID 9", "RAID 10", "RAID 11", "RAID 12", "RAID 13", "RAID 14", "RAID 15", "RAID 16", "RAID 17", "RAID 18", "RAID 19", "RAID 20", "RAID 21", "RAID 22", "RAID 23", "RAID 24", "RAID 25", "RAID 26", "RAID 27", "RAID 28", "RAID 29", "RAID 30", "RAID 31", "RAID 32", "RAID 33", "RAID 34", "RAID 35", "RAID 36", "RAID 37", "RAID 38", "RAID 39", "RAID 40"}, buttons = 6 }
	};

-- These are found in a spell's tooltip.  Translate only what's shown in quotes.
GB_FILTERS = {
		CastingTime = "([,.%d]*) sec d'incantation",
		Curse = "Mal\195\169diction",
		Damage = "points de d\195\169g\195\162t",
		Disease = "Maladie",
		Heal = "POINTS DE VIE",
		Over = " en ",
		DamageOverTime = "(%d[^%s]*) %a* dommages en (%d*) sec",
		HealOverTime = "(%d[^%s]*) en (%d*) sec",
		DruidHealOverTime = "(%d[^%s]*) en (%d*) sec",
		Magic = "Magie",
		Mana = "Mana : (%d*)",
		Poison = "Poison",
		Range = "de (%d*) m\195\168tres",
		To = "(%d[^%s]*) \195\160 (%d*)",
		Energy = "(%d*) Energie",
		Rage = "(%d*) Rage",
	} ;

--Translate only what is shown in quotes
GB_TEXT = {
		Actions = "Actions",
		AdjustClickbox = "Adjust Clickbox:",
		Alt = "Alt",
		AnchorPoint = "Point\nd'attache:",
		AnchorTo = "Sur:",
		Announce = "Annoncer l'incantation",
		AnnounceFailures = "Annoncer les sorts qui ont \195\169chou\195\169",
		AnnounceInterrupts = "Annonce les sorts interrompus",
		AnnounceNum = "Utiliser l'annonce No:",
		AnnounceOptions = "Options d'Annonce",
		AnnounceOptions2 = "OPTIONS ANNONCE DES SORTS",
		AnnounceText = "Texte d'annonce",
		Appearance = "Apparence",
		ApplyPOOnCtrl = "Lancer le sort malgr\195\169 les r\195\169glages sursoins/dommages si CTRL est press\195\169", 
		AreaHealThreshold = "Niveau de vie critique:",
		Assist = "Assister avant de lancer",
		Attach = "Attacher:",
		AttachTo = "su:",
		AttachToUnitFrame = "Attacher au(x) cadre(s)\nde(s) l'unit\195\169(s)",
		Attack = "Attaque",
		AutoUpdate = "Mise à jour auto rang suivant",
		BarXOffset = "Ajuster axe X",
		BarYOffset = "Ajuster axe Y",
		BarsUnlockedWarning = "Vos barres sont d\195\169verouill\195\169es.  Les bouttons ne peuvent pas etre pr\195\169ss\195\169s tant que les barres ne sont pas bloqu\195\169s.",
		Beast = "B\195\168te",
		BindingBarLock = "Bloquer/D\195\169bloquer Barres",
		BindingBars = "Cacher/Montrer toutes barres",
		BindingButtonLock = "Bloquer/D\195\169bloquer Bouttons",
		BindingClickboxes = "Cacher/Montrer Cadres",
		BindingEmpty = "Cacher/Montrer Bouttons vide",
		BindingLabels = "Cacher/Montrer titres",
		BindingMiniSpellbook = "Cacher/Montrer Grimoire",
		BindingOptions = "Cacher/Montrer Options",
		Blessing = "B\195\169n\195\169diction",
		Button = "Boutton ",
		Button4 = "Button 4",
		Button5 = "Button 5",
		ButtonAlpha = "Transparence",
		ButtonRows = "Disposition",
		ButtonSize = "Taille",
		ButtonSpacing = "Espacement",
		CancelHeal = "Annuler si la cible est soign\195\169",
		CancelHealThreshold = "Prevent Overhealing's Cancel Heal Threshold:",
		Cannibalize = "Cannibalisme",
		CastOptions = "Options de sort",
		ChainHeal =  "Salve de gu\195\169rison",
		ChangeTarget = "Changer ma cible pendant l'incantation",
		CheckAll = "Tous",
		Clearcasting = "Id\195\169es claires",
		ClickCast = "ClickCast",
		ClickboxBottomYOffset = "Ajuster axe Y bas",
		ClickboxLeftXOffset = "Ajuster axe X gauche",
		ClickboxRightXOffset = "Ajuster axe X droit",
		ClickboxTopYOffset = "Ajuster axe Y haut",
		CollapseHiddenButtons = "Cacher Bouttons vides",
		Control = "Ctrl",
		Counterspell = "Contresort",
		CurseOfDoom = "Mal\195\169diction funeste",
		DefaultFailedText = "Mon incantation de $s sur $t a \195\169chou\195\169!",
		DefaultInterruptedText = "Mon incantation de $s sur $t a \195\169t\195\169 interrompu!",
		DefaultLeftClick = "Maintenir clic gauche:",
		DefaultRightClick = "Maintenir clic droit:",
		DefineFrames = "Definir Cadre",
		Demon = "D\195\169mon",
		DesperatePrayer = "Pri\195\168re d\195\169sesp\195\169e",
		DisableActionInProgressSpam = "Arreter le spam: Une sutre action est en cours",
		DisableCantDoYetSpam = "Arreter le spam: Pas encore pret",
		DisableGB = "D\195\169sactiver GroupBoutons pour ce personnage",
		DisableGBSpam = "Arreter le spam: Group Buttons",
		DisableOutOfRangeSpam = "Arreter le spam: Hors de port\195\169",
		DisablePartyRange = "D\195\169sactiver les indicateurs de port\195\169 sur le barre de groupe",
		DisableTooltip = "D\195\169sactiver les astuces",
		DispelMagic = "Dissipation de la magie",
		DisplayOptions = "Options visuelles",
		DoNotAnnounceSolo = "Ne pas annoncer si en solo",
		DoNotAttack = "Ne pas attaquer automatiquement",
		DoNotTargetPet = "Ne pas cibler le famillier avec Shift-Click",
		DoNotUseParty = "Ne pas utiliser le canal Groupe pour annoncer",
		DoNotUseRaid = "Ne pas utiliser le canal Raid pour annoncer",
		DoNotUseSay = "Ne pas utiliser \"dire\" pour annoncer",
		Dragonkin = "Dragonkin",
		Druid = "Druide",
		DynamicKeybindings = "Raccourcis Dynamiques",
		Elemental = "El\195\169mentaire",
		FailedText = "Texte pour les sorts\nayant \195\169chou\195\169s",
		FlashInContext = "Clignote",
		FriendlyTarget = "Cible amie",
		Grey = "Gris",
		GroupButtons = "GROUP BUTTONS v"..GB_VERSION,
		HealCancelledMessage = "$s $r annul\195\169.  La cible a trop de vie.",
		HealPrevented = "Pr\195\169vention.  La cible n'a subit aucun dommage.",
		HealingBonus = "Bonus de soins:",
		HealthThreshold1 = "Niveau de vie critique 1:",
		HealthThreshold2 = "Niveau de vie critique 2:",
		HealthThreshold3 = "Niveau de vie critique 3:",
		HealthThreshold4 = "Niveau de vie critique 4:",
		HideBar = "Cacher Barres",
		HideBaseBindings = "Hide Static Keybindings",
		HideButton = "Cacher Bouttons",
		HideClickboxes = "Cacher Cadres",
		HideDynamicBindings = "Hide Dynamic Keybindings",
		HideEmpty = "Cacher Barres Vides",
		HideInRaid = "Cacher les barres de groupe dans les Raids",
		HideLabels = "Cacher Titres",
		HolyNova = "Nova Sacr\195\168e",
		HolyNova = "Nova Sacr\195\168e",
		HostileTarget = "Cible Ennemie",
		Humanoid = "Humano\195\175de",
		Hunter = "Chasseur",
		IncludePets = "Inclure les familiers pour la barre du plus faible",
		IncludeRaid = "Inclure les membres du raid pour la barre du plus faible",
		InnerFocus = "Feu int\195\169rieur",
		InterruptedText = "Texte pour les sorts\ninterrompus",
		LayOnHands = "Imposition des mains",
		Left = "Gauche",
		LevelTooLow = "Niveau de la cible trop bas pour tous les rangs.",
		LockBars = "Verrouiller Barres",
		LockButtons = "Verrouiller Bouttons",
		LowManaRank = "Sort inf\195\169rieur si mana faible",
		LowestHealth = "Vie faible",
		LowestHealthBar = "Barre de vie faible",
		Mage = "Mage",
		Mana = "Mana",
		ManaBurn = "Br\195\187lure de mana",
		ManaThreshold = "Niveau de mana critique:",
		MatchCastingTime = "Meme temps de cast",
		MatchSpellName = "Meme sort",
		Middle = "Milieu",
		MiniSpellbook = "Mini Grimoire",
		MiscOptions = "Options Divers",
		MiscellaneousOptions = "OPTIONS DIVERS",
		ModifyByUIScale = "Affichage de la\nrecharge en fonction\nde l'\195\169chelle de l'interface",
		NoEffectsFound = "No curable effects found.",
		NoForm = "No Form",
		None = "None",
		NotEnoughMana = "Pas assez de mana.  Nouveau sort: $name $rank.",
		NotPastCancelHeal = "Sort empecher.  La cible n'a pas atteint le Seuil Limite de vie.",
		NumPartyToCheck = "Nombre de joueur a v\195\169rifier:",
		POChangedSpell = "Pour pr\195\169venir le sursoin le sort suvant va etre lanc\195\169: $name $rank.",
		POkillChangedSpell = "Pour pr\195\169venir le surdommage le sort suivant va etre lanc\195\169 $name $rank.",
		Paladin = "Paladin",
		Party = "Membre",
		Party1 = "Barre Membre 1",
		Party2 = "Barre Membre 2",
		Party3 = "Barre Membre 3",
		Party4 = "Barre Membre 4",
		PartyPets = "Familiers Groupe",
		Pet = "Familier",
		Pets = "Famillier",
		PlayerOnly = "Montrer seulement pour les joueurs",
		PowerInfusion = "Power Infusion",
		PrayerOfHealing =  "Pri\195\170re de soins",
		PreventOverhealing = "Pr\195\169venir le sursoin",
		PreventOverhealingCancelThreshold = "Cancel Spellcast Threshold:",
		PreventOverkill = "pr\195\169venir le surdommage",
		PreventRebuff = "Pr\195\169venir le Re-buff",
		PreventedRebuff = "Lancement pr\195\169venu.  Buff/Debuff trouv\195\169 sur la cible.",
		Priest = "Pr\195\170tre",
		Purify = "Purification",
		Raid = "Raid",
		RaidMembers = "Membres du raid",
		Range = "Port\195\169e",
		Rank = "Rang ",
		RankScaled = "Niveau de la cible trop bas.  Nouveau sort: $name $rank.",
		ResetBarLocation = "R\195\169initialiser les positions:",
		Resurrection = "Resurrection", 
		Right = "Droite",
		Rogue = "Voleur",
		ScaleRank = "Scale Buff's Rank to Target's Level",
		SelectRaidMembers = "CHOISIR LES MEMBRES DU RAID",
		Self = "Moi",
		SelfBar = "Ma barre",
		SendToChannel = "Annonce dans le Canal : ",
		SetDynamicKBToBar = "Attribuer raccourcis sur barre:",
		SetThresholdValues = "REGLAGE DES VALEURS CRITIQUES",
		Shaman = "Chaman",
		Shift = "Shift",
		ShowClickboxes = "Montrer Cadres",
		ShowCooldownCount = "Voir le temps de recharge",
		ShowEmpty = "Montrer Barres Vides",
		ShowForClass = "Montrer pour les Classes:",
		ShowForForm = "Show For Shapeshift Form:",
		ShowIfValidTarget = "Montrer si l'unit\195\169 est une cible valide",
		ShowInCombat = "Montrer seulement en combat",
		ShowLabels = "Montrer Titres",
		ShowNotInCombat = "Monter seulement hors combat",
		ShowOnMouseover = "Monter quand souris\nau dessus",
		ShowWhen = "Montrer si:",
		Silence = "Silence",
		SpiritOfRedemption = "Esprit de R\195\168demption ",
		SunderArmor = "Fracasser armure",
		Target = "Cible",
		TargetBar = "Barre de cible",
		TargetNotFound = "Pas de cible pour $n.",
		Thresholds = "Niveau Critique",
		TooLowForAnyRank = "Mana trop faible pour tous les rangs.",
		TurnOffAllAnnouncements = "Ne rien annoncer",
		Undead = "Mort-vivant",
		UnlockBars = "D\195\169verouiller Barre",
		UnlockButtons = "D\195\169verouiller Bouttons",
		ViperSting = "Piq\195\187re de vip\195\168re",
		Warlock = "D\195\169moniste",
		Warrior = "Guerrier",
		WeakenedSoul = "Ame affaiblie",
		WhenOOC = "Quand ce n'est pas le cas:",
		friendlytargetBarOptions = "OPTIONS DE LA BARRE CIBLE AMIE",
		hostiletargetBarOptions = "OPTIONS DE LA BARRE CIBLE ENNEMIE",
		lowesthealthBarOptions = "OPTIONS DE LA BARRE VIE FAIBLE",
		partyBarOptions = "OPTIONS DE LA BARRE DE GROUPE",
		partypetBarOptions = "LES BARRES DES FAMILIERS DU GROUPE",
		petBarOptions = "LA BARRE DU FAMILIER",
		playerBarOptions = "MA BARRE D'OPTIONS",
		raidBarOptions = "LA BARRE DE RAID",
		Shadowform = "Shadowform",
		AutoCancel = "Auto-cancel Shadowform / animal form",
		LimitLHRange = "Limit Lowest Health Bar Range",
		LimitAERange = "Limit Area Threshold Range"
	};

-- Translate only what appears in quotes after text =
GB_CONTEXTS = {
		{ index = "Always", text = "Toujours" },
		{ index = "DmgGTHeal", text = "D\195\169gats > Montant du Soin" },
		{ index = "Health1", text = "Le joueur a d\195\169pass\195\169 le Seuil Limite 1" },
		{ index = "Health2", text = "Le joueur a d\195\169pass\195\169 le Seuil Limite 2" },
		{ index = "Health3", text = "Le joueur a d\195\169pass\195\169 le Seuil Limite 3" },
		{ index = "Health4", text = "Le joueur a d\195\169pass\195\169 le Seuil Limite 4" },
		{ index = "Mana", text = "Le joueur a d\195\169pass\195\169 le Seuil Limite de mana" },
		{ index = "Area", text = "Le groupe a d\195\169pass\195\169 le Seuil Limite" },
		{ index = "NotBuffed", text = "N'est pas buff\195\169" },
		{ index = "NotDebuffed", text = "N'est pas debuff\195\169" },
		{ index = "MagicDebuffed", text = "Souffre de Magie " },
		{ index = "Cursed", text = "Maudit" },
		{ index = "Diseased", text = "Malade" },
		{ index = "Poisoned", text = "Empoisonn\195\169" },
		{ index = "Dead", text = "Mort" }
	}

-- Translate only the spell names that appear in quotes
GB_MINLVL_SPELLS = {
		AbolishDisease = "Abolir maladie",
		AbolishPoison = "Abolir Poison",
		AmplifyMagic = "Amplifier la magie",
		ArcaneIntellect = "Intelligence des arcanes",
		Blessing = "B\195\169n\195\169diction",
		BlessingFreedom = "B\195\169n\195\169diction de libert\195\169",
		BlessingKings = "B\195\169n\195\169diction des Rois",
		BlessingLight = "B\195\169n\195\169diction de lumi\195\168re",
		BlessingMight = "B\195\169n\195\169diction de puissance",
		BlessingProtection = "B\195\169n\195\169diction de protection",
		BlessingSacrifice = "B\195\169n\195\169diction de sacrifice",
		BlessingSalvation = "B\195\169n\195\169diction de salut",
		BlessingSanctuary = "B\195\169n\195\169diction du sanctuaire",
		BlessingWisdom = "B\195\169n\195\169diction de sagesse",
		DampenMagic = "Att\195\169nuer la magie",
		DesperatePrayer = "Pri\195\168re d\195\169sesp\195\169e",
		DispelMagic = "Dissipation de la magie",
		DivineSpirit = "Esprit divin",
		MarkOfTheWild = "Marque du fauve",
		PWFortitude = "Mot de pouvoir : Robustesse",
		PWShield = "Mot de pouvoir : Bouclier",
		Regrowth = "R\195\169tablissement",
		Rejuvenation = "R\195\169cup\195\169ration",
		Renew = "R\195\169novation",
		ShadowProtection = "Protection contre l'ombre",
		Thorns = "Epines"
	}; 

-- Translate only the spell names that appear in quotes on either side of the =
GB_AREA_BUFFS = {
		[GB_MINLVL_SPELLS.PWFortitude] = "Pri\195\168re de robustesse",
		["Pri\195\168re de robustesse"] = GB_MINLVL_SPELLS.PWFortitude,
		[GB_MINLVL_SPELLS.MarkOfTheWild] = "Don du fauve",
		["Don du fauve"] = GB_MINLVL_SPELLS.MarkOfTheWild,
		[GB_MINLVL_SPELLS.ArcaneIntellect] = "Illumination des arcanes",
		["Illumination des arcanes"] = GB_MINLVL_SPELLS.ArcaneIntellect,
		["Pri\195\168re d'Esprit"] = GB_MINLVL_SPELLS.DivineSpirit,
		[GB_MINLVL_SPELLS.DivineSpirit] = "Pri\195\168re d'Esprit",
		["Pri\195\168re de protection contre l'Ombre"] = GB_MINLVL_SPELLS.ShadowProtection,
		[GB_MINLVL_SPELLS.ShadowProtection] = "Pri\195\168re de protection contre l'Ombre",

		[GB_MINLVL_SPELLS.BlessingKings] = "Greater Blessing of Kings",
		["Greater Blessing of Kings"] = GB_MINLVL_SPELLS.BlessingKings,
		[GB_MINLVL_SPELLS.BlessingLight] = "Greater Blessing of Light",
		["Greater Blessing of Light"] = GB_MINLVL_SPELLS.BlessingLight,
		[GB_MINLVL_SPELLS.BlessingMight] = "Greater Blessing of Might",
		["Greater Blessing of Might"] = GB_MINLVL_SPELLS.BlessingMight,
		[GB_MINLVL_SPELLS.BlessingWisdom] = "Greater Blessing of Wisdom",
		["Greater Blessing of Wisdom"] = GB_MINLVL_SPELLS.BlessingWisdom,
		[GB_MINLVL_SPELLS.BlessingSalvation] = "Greater Blessing of Salvation",
		["Greater Blessing of Salvation"] = GB_MINLVL_SPELLS.BlessingSalvation,
		[GB_MINLVL_SPELLS.BlessingSanctuary] = "Greater Blessing of Sanctuary",
		["Greater Blessing of Sanctuary"] = GB_MINLVL_SPELLS.BlessingSanctuary,
	};

-- Translate only the spell names that appear in quotes.
GB_TARGET_SPELLS = {
		["Bannir"] = { [GB_TEXT.Demon] = true, [GB_TEXT.Elemental] = true },
		["Connaissance des b\195\170tes"] = { [GB_TEXT.Beast] = true },
		["Asservir d\195\169mon"] = { [GB_TEXT.Demon] = true },
		["Exorcisme"] = { [GB_TEXT.Undead] = true, [GB_TEXT.Demon] = true },
		["Hibernation"] = { [GB_TEXT.Dragonkin] = true, [GB_TEXT.Beast] = true },
		["Contr\195\180le mental"] = { [GB_TEXT.Humanoid] = true },
		["Apaisement"] = { [GB_TEXT.Humanoid] = true },
		["Polymorphe"] = { [GB_TEXT.Humanoid] = true, [GB_TEXT.Beast] = true, ["Bestiole"] = true },
		["Col\195\168re divine"] = { [GB_TEXT.Undead] = true , [GB_TEXT.Demon] = true },
		["Assommer"] = { [GB_TEXT.Humanoid] = true },
		["Effrayer une b\195\170te"] = { [GB_TEXT.Beast] = true },
		["Entraves des morts-vivants"] = { [GB_TEXT.Undead] = true },
		["Apaiser les animaux"] = { [GB_TEXT.Beast] = true },
		["Renvoi des morts-vivants"] = { [GB_TEXT.Undead] = true },
		["Holy Wrath"] = { [GB_TEXT.Undead] = true, [GB_TEXT.Demon] = true }
	};

-- Translate only what appears in quotes after text=
GB_ANCHOR_POINTS = {
		{ value="TOPLEFT", text="HAUTGAUCHE" },
		{ value="TOP", text="HAUT" },
		{ value="TOPRIGHT", text="HAUTDROITE" },
		{ value="LEFT", text="GAUCHE" },
		{ value="CENTER", text="MILIEU" },
		{ value="RIGHT", text="DROITE" },
		{ value="BOTTOMLEFT", text="BASGAUCHE" },
		{ value="BOTTOM", text="BAS" },
		{ value="BOTTOMRIGHT", text="BASDROITE" }
	};

GB_CURES = {
		CureDisease = { text="Gu\195\168rison des maladies", effects={GB_FILTERS.Disease} },
		Cleanse = { text="Epuration", effects = {GB_FILTERS.Disease, GB_FILTERS.Poison, GB_FILTERS.Magic} },
		CurePoison = { text = "Gu\195\168rison du poison", effects = {GB_FILTERS.Poison} },
		AbolishDisease = { text=GB_MINLVL_SPELLS.AbolishDisease, effects = {GB_FILTERS.Disease} },
		AbolishPoison = { text=GB_MINLVL_SPELLS.AbolishPoison, effects = {GB_FILTERS.Poison} },
		DispelMagic = { text=GB_TEXT.DispelMagic, effects = {GB_FILTERS.Magic} },
		RemoveCurse = { text="Remove Curse", effects = {GB_FILTERS.Curse} },
		Purify = { text=GB_TEXT.Purify, effects = {GB_FILTERS.Disease, GB_FILTERS.Poison} },
	};
end

--**************************************************
--           END OF TRANSLATIONS
--**************************************************
GB_SKIP_NAMES = {};

GB_CLICKBOX_MENU = {
		{ text=GB_TEXT.Self, value="player" },
		{ text=GB_TEXT.Party, value="party" },
		{ text=GB_TEXT.Target, value="friendlytarget" },
		{ text=GB_TEXT.Pet, value="pet" },
		{ text=GB_TEXT.PartyPets, value="partypet" }
	};

GB_COPYBAR_MENU = {
		{ text=GB_TEXT.Self, value="player" },
		{ text=GB_TEXT.Party, value="party" },
		{ text=GB_TEXT.FriendlyTarget, value="friendlytarget" },
		{ text=GB_TEXT.HostileTarget, value="hostiletarget" },
		{ text=GB_TEXT.LowestHealth, value="lowesthealth" }
	};

GB_CLICK_MENU = {
		{ i="l", v=GB_TEXT.Left },
		{ i="m", v=GB_TEXT.Middle },
		{ i="r", v=GB_TEXT.Right },
		{ i="4", v=GB_TEXT.Button4},
		{ i="5", v=GB_TEXT.Button5},
		{ i="sl", v=GB_TEXT.Shift.."+"..GB_TEXT.Left },
		{ i="sm", v=GB_TEXT.Shift.."+"..GB_TEXT.Middle },
		{ i="sr", v=GB_TEXT.Shift.."+"..GB_TEXT.Right },
		{ i="cl", v=GB_TEXT.Control.."+"..GB_TEXT.Left },
		{ i="cm", v=GB_TEXT.Control.."+"..GB_TEXT.Middle },
		{ i="cr", v=GB_TEXT.Control.."+"..GB_TEXT.Right },
		{ i="al", v=GB_TEXT.Alt.."+"..GB_TEXT.Left },
		{ i="am", v=GB_TEXT.Alt.."+"..GB_TEXT.Middle },
		{ i="ar", v=GB_TEXT.Alt.."+"..GB_TEXT.Right },
		{ i="scl", v=GB_TEXT.Shift.."+"..GB_TEXT.Control.."+"..GB_TEXT.Left },
		{ i="scm", v=GB_TEXT.Shift.."+"..GB_TEXT.Control.."+"..GB_TEXT.Middle },
		{ i="scr", v=GB_TEXT.Shift.."+"..GB_TEXT.Control.."+"..GB_TEXT.Right },
		{ i="sal", v=GB_TEXT.Shift.."+"..GB_TEXT.Alt.."+"..GB_TEXT.Left },
		{ i="sam", v=GB_TEXT.Shift.."+"..GB_TEXT.Alt.."+"..GB_TEXT.Middle },
		{ i="sar", v=GB_TEXT.Shift.."+"..GB_TEXT.Alt.."+"..GB_TEXT.Right },
		{ i="acl", v=GB_TEXT.Alt.."+"..GB_TEXT.Control.."+"..GB_TEXT.Left },
		{ i="acm", v=GB_TEXT.Alt.."+"..GB_TEXT.Control.."+"..GB_TEXT.Middle },
		{ i="acr", v=GB_TEXT.Alt.."+"..GB_TEXT.Control.."+"..GB_TEXT.Right },
		{ i="sacl", v=GB_TEXT.Shift.."+"..GB_TEXT.Alt.."+"..GB_TEXT.Control.."+"..GB_TEXT.Left },
		{ i="sacm", v=GB_TEXT.Shift.."+"..GB_TEXT.Alt.."+"..GB_TEXT.Control.."+"..GB_TEXT.Middle },
		{ i="sacr", v=GB_TEXT.Shift.."+"..GB_TEXT.Alt.."+"..GB_TEXT.Control.."+"..GB_TEXT.Right }
	};

GB_SKIP_SPELLS = {
	[GB_TEXT.PrayerOfHealing] = true,
	[GB_TEXT.ChainHeal] = true,
	[GB_TEXT.DesperatePrayer] = true,
	[GB_TEXT.LayOnHands] = true,
	[GB_TEXT.Cannibalize] = true,
	[GB_TEXT.HolyNova] = true,
	[GB_TEXT.Resurrection] = true
}

BINDING_HEADER_GROUPBUTTONS = GB_TEXT.GroupButtons;
BINDING_NAME_GROUPBUTTONS_OPTIONS = GB_TEXT.BindingOptions;
BINDING_NAME_GROUPBUTTONS_LABELS = GB_TEXT.BindingLabels
BINDING_NAME_GROUPBUTTONS_EMPTY = GB_TEXT.BindingEmpty;
BINDING_NAME_GROUPBUTTONS_SPELLBOOK = GB_TEXT.BindingMiniSpellbook;
BINDING_NAME_GROUPBUTTONS_BARLOCK = GB_TEXT.BindingBarLock;
BINDING_NAME_GROUPBUTTONS_BUTTONLOCK = GB_TEXT.BindingButtonLock;
BINDING_NAME_GROUPBUTTONS_CLICKBOXES = GB_TEXT.BindingClickboxes;
BINDING_NAME_GROUPBUTTONS_BARS = GB_TEXT.BindingBars;

BINDING_HEADER_GB_SETDYNAMICKBTOBAR = GB_TEXT.SetDynamicKBToBar;
BINDING_NAME_GB_SETDYNAMICKBTOBAR_SELF = GB_TEXT.SelfBar;
BINDING_NAME_GB_SETDYNAMICKBTOBAR_PARTY1 = GB_TEXT.Party1;
BINDING_NAME_GB_SETDYNAMICKBTOBAR_PARTY2 = GB_TEXT.Party2;
BINDING_NAME_GB_SETDYNAMICKBTOBAR_PARTY3 = GB_TEXT.Party3;
BINDING_NAME_GB_SETDYNAMICKBTOBAR_PARTY4 = GB_TEXT.Party4;
BINDING_NAME_GB_SETDYNAMICKBTOBAR_TARGET = GB_TEXT.TargetBar;
BINDING_NAME_GB_SETDYNAMICKBTOBAR_LOWESTHEALTH = GB_TEXT.LowestHealthBar;

BINDING_HEADER_GB_DYNAMICKB = GB_TEXT.DynamicKeybindings;
for i=1, 20 do
	setglobal("BINDING_NAME_GB_DYNAMICKB"..i, GB_TEXT.Button..i);
end

BINDING_HEADER_GB_PLAYER = GB_TEXT.SelfBar;
for i=1, 20 do
	setglobal("BINDING_NAME_GB_PLAYER"..i, GB_TEXT.Button..i);
end

BINDING_HEADER_GB_PARTY1 = GB_TEXT.Party1;
for i=1, 20 do
	setglobal("BINDING_NAME_GB_PARTY1_"..i, GB_TEXT.Button..i);
end

BINDING_HEADER_GB_PARTY2 = GB_TEXT.Party2;
for i=1, 20 do
	setglobal("BINDING_NAME_GB_PARTY2_"..i, GB_TEXT.Button..i);
end

BINDING_HEADER_GB_PARTY3 = GB_TEXT.Party3;
for i=1, 20 do
	setglobal("BINDING_NAME_GB_PARTY3_"..i, GB_TEXT.Button..i);
end

BINDING_HEADER_GB_PARTY4 = GB_TEXT.Party4;
for i=1, 20 do
	setglobal("BINDING_NAME_GB_PARTY4_"..i, GB_TEXT.Button..i);
end

BINDING_HEADER_GB_TARGET = GB_TEXT.TargetBar;
for i=1, 20 do
	setglobal("BINDING_NAME_GB_TARGET"..i, GB_TEXT.Button..i);
end

BINDING_HEADER_GB_LOWESTHEALTH = GB_TEXT.LowestHealthBar;
for i=1, 20 do
	setglobal("BINDING_NAME_GB_LOWESTHEALTH"..i, GB_TEXT.Button..i);
end