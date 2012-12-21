--[[

AutoBuff -- Automatically casts self-buffs, weapon buffs, tracking abilites, and aspects.
Originally authored by Frosty @ http://www.curse-gaming.com/mod.php?addid=1400

ADOPTED 2005-08 by Dsanai, as Frosty is no longer playing World of Warcraft.
Please direct any suggestions, comments, or blame, to Dsanai. Frosty still deserves the praise, though. :-)

http://membersui.worldofwar.net/ui.php?id=1475
http://www.curse-gaming.com/mod.php?addid=2442
http://www.wowinterface.com/downloads/fileinfo.php?s=&id=4259

FEATURE REQUESTS (Not added yet)
-- Option to not cast while Resting (removed it a while back, add back in with default Off)
-- Option to not cast while in Battlegrounds (check MetaMap for method to test this state)
-- Figure out what changed to make the Expiration flag unknowable (won't cast until spell is gone).

-[ MOST RECENT HISTORY ]-  (For older history, see ReadMe.txt)

v11200-3
-- Fixed error caused by not having Titan installed.

v11200-2
-- Fixed error caused by not having FuBar installed.

v11200-1
-- Updated TOC for Patch 1.12.
-- Added Warlock Life Tap scaling (code from ScaledLifeTap by Kimilly). Requires  BonusScanner mod.
-- Added option to recast Priests' Inner Fire spell at a set number of charges or less (5/20 is default).
-- Added option to change Inner Fire recast charges to anything from 1 to 19 (/ab innercharges <integer>).
-- Removed check for weapons before casting Shaman weapon buffs (fixes tooltip bug). If you're working on your Unarmed skill, disable the selected weapon buff in /autobuff and all will be well.
-- Hid options on Titan and FuBar tooltips if they do not apply to the currently-played character class.

v11100-3b/c
-- Fixed bug introduced by Detect Traps removal.

v11100-3
-- Added FuBar 2+ support.
-- Priest: Will no longer cast while Spirit of Redemption is active (EN,DE,FR clients)
-- Fixed DE Windfury translation (courtesy Helaku@WorldOfWar)
-- Fixed DE Sense Undead translation (courtesy DelphiDie@WorldOfWar)
-- Fixed DE Ice Barrier translation (courtesy DelphiDie@WorldOfWar)
-- Removed Detect Traps (Blizzard passive spell now)

]]

-- Constants
--AUTOBUFF_USAGE_LIST = "/autobuff on|off|toggle|track|weapon|mana\n/autobuff trigger|rebuff|combat|enable|disable|list\n/autobuff hide|resetbutton";
AUTOBUFF_USAGE_LIST = "/autobuff on | off | toggle\n";
AUTOBUFF_USAGE_LIST = AUTOBUFF_USAGE_LIST.."/autobuff track | weapon\n";
AUTOBUFF_USAGE_LIST = AUTOBUFF_USAGE_LIST.."/autobuff mana | trigger | rebuff | combat | enable | disable | list\n";
AUTOBUFF_USAGE_LIST = AUTOBUFF_USAGE_LIST.."/autobuff reset\n";
AUTOBUFF_USAGE_LIST = AUTOBUFF_USAGE_LIST.."/autobuff water | tap | scaled | inner\n";
AUTOBUFF_USAGE_LIST = AUTOBUFF_USAGE_LIST.."/autobuff innercharges <num>\n";
AUTOBUFF_USAGE_LIST = AUTOBUFF_USAGE_LIST.."/autobuff hide | resetbutton\n";
AUTOBUFF_USAGE_LIST = AUTOBUFF_USAGE_LIST.."To Run Autobuff: /autobuff run\n";

BINDING_HEADER_AUTOBUFF = "AutoBuff";

local AUTOBUFF_GUI_ABILITY_TOTALROWS = 30;
local AUTOBUFF_GUI_ABILITY_OVERHEAD = 14;
local AUTOBUFF_GUI_ABILITY_INTERVAL = 18;

cSpellList = {
	[AUTOBUFF_ABILITY_FORTITUDE] =         { ["type"] = "friendly",
	[0] = string.lower(AUTOBUFF_ABILITY_PRAYEROFFORTITUDE) },
	[AUTOBUFF_ABILITY_PWSHIELD] =          { ["type"] = "friendly",
	[0] = string.lower(AUTOBUFF_ABILITY_WEAKENEDSOUL) },
	[AUTOBUFF_ABILITY_INNER_FIRE] =        { ["type"] = "self" },
	[AUTOBUFF_ABILITY_SHADOW_PROTECTION] = { ["type"] = "friendly",
	[0] = string.lower(AUTOBUFF_ABILITY_PRAYEROFSHADOWPROTECTION) },
	[AUTOBUFF_ABILITY_FEARWARD] =          { ["type"] = "friendly" },
	[AUTOBUFF_ABILITY_DIVINESPIRIT] =      { ["type"] = "friendly",
	[0] = string.lower(AUTOBUFF_ABILITY_PRAYEROFSPIRIT) },
	[AUTOBUFF_ABILITY_MOTW] =              { ["type"] = "friendly",
	[0] = string.lower(AUTOBUFF_ABILITY_GOTW) },
	[AUTOBUFF_ABILITY_THORNS] =            { ["type"] = "friendly" },
	[AUTOBUFF_ABILITY_ELUNESGRACE] =       { ["type"] = "self" },
	[AUTOBUFF_ABILITY_LIGHTNING_SHIELD] =  { ["type"] = "self" },
	[AUTOBUFF_ABILITY_INTELLECT] =         { ["type"] = "friendly",
	[0] = string.lower(AUTOBUFF_ABILITY_ARCANEBRILLIANCE) },
	[AUTOBUFF_ABILITY_MAGE_ARMOR] =        { ["type"] = "self",
	[0] = string.lower(AUTOBUFF_ABILITY_ICE_ARMOR) },
	[AUTOBUFF_ABILITY_ICE_ARMOR] =         { ["type"] = "self",
	[0] = string.lower(AUTOBUFF_ABILITY_MAGE_ARMOR) },
	[AUTOBUFF_ABILITY_FROST_ARMOR] =       { ["type"] = "self" },
	[AUTOBUFF_ABILITY_MANASHIELD] =        { ["type"] = "self" },
	[AUTOBUFF_ABILITY_ICEBARRIER] =        { ["type"] = "self" },
	[AUTOBUFF_ABILITY_FIREWARD] =          { ["type"] = "self" },
	[AUTOBUFF_ABILITY_FROSTWARD] =         { ["type"] = "self" },
	[AUTOBUFF_ABILITY_AMPLIFYMAGIC] =      { ["type"] = "friendly" },
	[AUTOBUFF_ABILITY_DAMPENMAGIC] =       { ["type"] = "friendly",
	[0] = string.lower(AUTOBUFF_ABILITY_AMPLIFYMAGIC) },
	[AUTOBUFF_ABILITY_DEMON_SKIN] =        { ["type"] = "self" },
	[AUTOBUFF_ABILITY_DEMON_ARMOR] =       { ["type"] = "self" },
	[AUTOBUFF_ABILITY_DETECT_LINVIS] =     { ["type"] = "friendly" },
	[AUTOBUFF_ABILITY_DETECT_INVIS] =      { ["type"] = "friendly" },
	[AUTOBUFF_ABILITY_DETECT_GINVIS] =     { ["type"] = "friendly" },
	[AUTOBUFF_ABILITY_UNENDING_BREATH] =   { ["type"] = "friendly" },
	[AUTOBUFF_ABILITY_SOULLINK] =          { ["type"] = "self" },
	[AUTOBUFF_ABILITY_SHADOWWARD] =        { ["type"] = "self" },
	[AUTOBUFF_ABILITY_TRUESHOTAURA] =      { ["type"] = "self" },
	[AUTOBUFF_ABILITY_BATTLESHOUT] =       { ["type"] = "self" },
	[AUTOBUFF_ABILITY_NATURES_GRASP] =     { ["type"] = "self" },
	[AUTOBUFF_ABILITY_OMENOFCLARITY] =     { ["type"] = "self" },
	[AUTOBUFF_ABILITY_BARKSKIN] =          { ["type"] = "self" },
	[AUTOBUFF_ABILITY_FEINT] =             { ["type"] = "self" },
	[AUTOBUFF_ABILITY_BLADE_FLURRY] =      { ["type"] = "self" },
	[AUTOBUFF_ABILITY_SHADOWGUARD] =       { ["type"] = "self" },
	[AUTOBUFF_ABILITY_TOUCHOFWEAKNESS] =   { ["type"] = "self" },
	[AUTOBUFF_ABILITY_WATER_BREATHING] =   { ["type"] = "friendly" },
	[AUTOBUFF_ABILITY_RIGHTFURY] =         { ["type"] = "self" },
	[AUTOBUFF_ABILITY_LIFE_TAP] =          { ["type"] = "self" },
	[AUTOBUFF_ABILITY_DARK_PACT] =         { ["type"] = "self" },
	[AUTOBUFF_ABILITY_BERSERKING] =        { ["type"] = "self" },
	[AUTOBUFF_ABILITY_FADE] =              { ["type"] = "self" },
	[AUTOBUFF_ABILITY_COWER] =             { ["type"] = "self" },
	[AUTOBUFF_ABILITY_PERCEPTION] =        { ["type"] = "self" },
	[AUTOBUFF_ABILITY_BLOODFURY] =         { ["type"] = "self" },
	[AUTOBUFF_ABILITY_REJUV] =             { ["type"] = "friendly" },
	[AUTOBUFF_ABILITY_RENEW] =             { ["type"] = "friendly" },
	[AUTOBUFF_ABILITY_ICEBLOCK] =          { ["type"] = "self" },
	[AUTOBUFF_ABILITY_BLOODRAGE] =         { ["type"] = "self" },
	[AUTOBUFF_ABILITY_EVASION] =           { ["type"] = "self" },
	[AUTOBUFF_ABILITY_SPRINT] =            { ["type"] = "self" },
	[AUTOBUFF_ABILITY_STONEFORM] =         { ["type"] = "self" },
	[AUTOBUFF_ABILITY_FOCUSEDCASTING] =    { ["type"] = "self" },
	[AUTOBUFF_ABILITY_HOLYSHIELD] =        { ["type"] = "self" },
	[AUTOBUFF_ABILITY_BERSERKERRAGE] =     { ["type"] = "self" },
	[AUTOBUFF_ABILITY_DIVINEFAVOR] =       { ["type"] = "self" },
	[AUTOBUFF_ABILITY_COLDBLOOD] =         { ["type"] = "self" },
	};

local cBlessing = {
	[0] = AUTOBUFF_ABILITY_BLESSING_MIGHT,
	[1] = AUTOBUFF_ABILITY_BLESSING_WISDOM,
	[2] = AUTOBUFF_ABILITY_BLESSING_SALVATION,
	[3] = AUTOBUFF_ABILITY_BLESSING_KINGS,
	[4] = AUTOBUFF_ABILITY_BLESSING_SANCTUARY,
	[5] = AUTOBUFF_ABILITY_BLESSING_LIGHT,
}

local cBlessingOther = {
	[0] = AUTOBUFF_ABILITY_BLESSING_FREEDOM,
	[1] = AUTOBUFF_ABILITY_BLESSING_PROTECTION,
}

local cBlessingPoly = {
	[AUTOBUFF_ABILITY_GREATBLESSING_MIGHT] = AUTOBUFF_ABILITY_BLESSING_MIGHT,
	[AUTOBUFF_ABILITY_GREATBLESSING_WISDOM] = AUTOBUFF_ABILITY_BLESSING_WISDOM,
	[AUTOBUFF_ABILITY_GREATBLESSING_SALVATION] = AUTOBUFF_ABILITY_BLESSING_SALVATION,
	[AUTOBUFF_ABILITY_GREATBLESSING_KINGS] = AUTOBUFF_ABILITY_BLESSING_KINGS,
	[AUTOBUFF_ABILITY_GREATBLESSING_SANCTUARY] = AUTOBUFF_ABILITY_BLESSING_SANCTUARY,
	[AUTOBUFF_ABILITY_GREATBLESSING_LIGHT] = AUTOBUFF_ABILITY_BLESSING_LIGHT,
}

local cAura = {
	[0] = AUTOBUFF_ABILITY_AURA_DEVOTION,
	[1] = AUTOBUFF_ABILITY_AURA_RETRIBUTION,
	[2] = AUTOBUFF_ABILITY_AURA_CONCENTRATION,
	[3] = AUTOBUFF_ABILITY_AURA_SHADOWRESIST,
	[4] = AUTOBUFF_ABILITY_AURA_FROSTRESIST,
	[5] = AUTOBUFF_ABILITY_AURA_FIRERESIST,
	[6] = AUTOBUFF_ABILITY_AURA_SANCTITY,
}

local cTrackList = {
	[AUTOBUFF_ABILITY_FIND_MINERALS] =   "Spell_Nature_Earthquake",
	[AUTOBUFF_ABILITY_FIND_HERBS] =      "Unknown",
	[AUTOBUFF_ABILITY_SENSE_DEMONS] =    "Spell_Shadow_Metamorphosis",
	[AUTOBUFF_ABILITY_TRACK_BEASTS] =    "Unknown",
	[AUTOBUFF_ABILITY_TRACK_UNDEAD] =    "Unknown",
	[AUTOBUFF_ABILITY_TRACK_HIDDEN] =    "Unknown",
	[AUTOBUFF_ABILITY_TRACK_ELEMENTAL] = "Unknown",
	[AUTOBUFF_ABILITY_TRACK_DEMONS] =    "Unknown",
	[AUTOBUFF_ABILITY_TRACK_GIANTS] =    "Unknown",
	[AUTOBUFF_ABILITY_TRACK_DRAGONKIN] = "Unknown",
	[AUTOBUFF_ABILITY_FIND_TREASURE] =   "Unknown",
	[AUTOBUFF_ABILITY_SENSE_UNDEAD] =    "Unknown",
}; -- 	[AUTOBUFF_ABILITY_TRACK_HUMANOIDS] = "Unknown",
-- Added dynamically now, based on if you're a Druid (goes to cSpellList) or a Hunter (goes to cTrackList).

local cAspectList = {
	[AUTOBUFF_ASPECT_MONKEY] =  "Unknown",
	[AUTOBUFF_ASPECT_HAWK] =    "Unknown",
	[AUTOBUFF_ASPECT_CHEETAH] = "Unknown",
	[AUTOBUFF_ASPECT_PACK] =    "Unknown",
	[AUTOBUFF_ASPECT_WILD] =    "Unknown",
	[AUTOBUFF_ASPECT_BEAST] =   "Unknown",
};

local cSealList = {
	[AUTOBUFF_ABILITY_SEAL_COMMAND] =  { ["i"] = 1, ["type"] = "self" },
	[AUTOBUFF_ABILITY_SEAL_FURY] =     { ["i"] = 2, ["type"] = "self" },
	[AUTOBUFF_ABILITY_SEAL_JUSTICE] =  { ["i"] = 3, ["type"] = "self" },
	[AUTOBUFF_ABILITY_SEAL_LIGHT] =    { ["i"] = 4, ["type"] = "self" },
	[AUTOBUFF_ABILITY_SEAL_RIGHT] =    { ["i"] = 5, ["type"] = "self" },
	[AUTOBUFF_ABILITY_SEAL_WISDOM] =   { ["i"] = 6, ["type"] = "self" },
	[AUTOBUFF_ABILITY_SEAL_CRUSADER] = { ["i"] = 7, ["type"] = "self" },
};

local cWarlockPet = { ["Lesser Invisibility"] = "Spell_Magic_LesserInvisibilty"; }; -- Beta function. /autobuff succubus

local cWeaponList = {
	[AUTOBUFF_ABILITY_PRIEST_FEEDBACK] =    0,
	[AUTOBUFF_ABILITY_SHAMAN_FLAMETONGUE] = 0,
	[AUTOBUFF_ABILITY_SHAMAN_FROSTBRAND] =  0,
	[AUTOBUFF_ABILITY_SHAMAN_ROCKBITER] =   0,
	[AUTOBUFF_ABILITY_SHAMAN_WINDFURY] =    0,
};

local cPolyList = {
	["all"] = {
		[AUTOBUFF_POLY_ALL_INVISIBILITY] = true,
		[AUTOBUFF_POLY_ALL_LESSERINVISIBILITY] = true,
		[AUTOBUFF_POLY_ALL_SHADOWMELD] = true,
		[AUTOBUFF_POLY_ALL_DRINK] = true,
		[AUTOBUFF_POLY_ALL_FOOD] = true,
		[AUTOBUFF_POLY_ALL_FIRSTAID] = true,
	},
	[string.lower(AUTOBUFF_CLASS_PRIEST)] = {
		[AUTOBUFF_POLY_PRIEST_MINDCONTROL] = true,
		[AUTOBUFF_POLY_PRIEST_SPIRITTAP] = true,
		[AUTOBUFF_POLY_PRIEST_MINDVISION] = true,
		[AUTOBUFF_POLY_PRIEST_INNERFOCUS] = true,
		[AUTOBUFF_POLY_PRIEST_SPIRITOFREDEMPTION] = true,
	},
	[string.lower(AUTOBUFF_CLASS_ROGUE)] = {},
	[string.lower(AUTOBUFF_CLASS_PALADIN)] = {},
	[string.lower(AUTOBUFF_CLASS_WARLOCK)] = {
		[AUTOBUFF_POLY_WARLOCK] = true,
		[AUTOBUFF_POLY_WARLOCK_SOULSIPHON] = true,
	},
	[string.lower(AUTOBUFF_CLASS_WARRIOR)] = {},
	[string.lower(AUTOBUFF_CLASS_HUNTER)] = {},
	[string.lower(AUTOBUFF_CLASS_MAGE)] = {
		[AUTOBUFF_POLY_MAGE] = true,
	},
	[string.lower(AUTOBUFF_CLASS_SHAMAN)] = {
		[AUTOBUFF_POLY_SHAMAN] = true,
	},
	[string.lower(AUTOBUFF_CLASS_DRUID)] = {
		[AUTOBUFF_POLY_DRUID_BEAR] = true,
		[AUTOBUFF_POLY_DRUID_CAT] = true,
		[AUTOBUFF_POLY_DRUID_AQUATIC] = true,
		[AUTOBUFF_POLY_DRUID_TRAVEL] = true,
		[AUTOBUFF_POLY_DRUID_DIREBEAR] = true,
		[AUTOBUFF_POLY_DRUID_MOONKIN] = true,
	}
};

local cDefault = {  -- Default saved settings.
	['e'] = 1,         -- Enabled
	['x'] = {           -- Spell Settings
		['d'] = {          -- Default Settings
			['c'] = 3,        -- Combat
			['h'] = 1,        -- Health
			['m'] = 40,       -- Mana
			['r'] = 10,       -- Rebuff
			['t'] = 126,      -- Hook Trigger
			['z'] = 1,        -- Class Specific (Stealth/Breath) UNUSED
			['p'] = 3,        -- Party
		},
		[AUTOBUFF_ABILITY_PWSHIELD] = {
			['d'] = 1,
		},
		[AUTOBUFF_ABILITY_ICEBARRIER] = {
			['d'] = 1,
		},
		[AUTOBUFF_ABILITY_BATTLESHOUT] = {
			['m'] = 10,
			['r'] = 5,
		},
		[AUTOBUFF_ABILITY_FIREWARD] = {
			['d'] = 1,
		},
		[AUTOBUFF_ABILITY_FROSTWARD] = {
			['d'] = 1,
		},
		[AUTOBUFF_ABILITY_WATER_BREATHING] = {
			['d'] = 1,
		},
		[AUTOBUFF_ABILITY_TRACK_HUMANOIDS] = {
			['m'] = 1,
		},
		[AUTOBUFF_ABILITY_LIFE_TAP] = {
			['m'] = -40, -- < 40% mana
			['h'] = 80, -- > 80% health
		},
		[AUTOBUFF_ABILITY_BERSERKING] = {
			['c'] = 1, -- IN Combat
			['h'] = -70, -- < 70% health
		},
		[AUTOBUFF_ABILITY_FADE] = {
			['c'] = 1, -- IN Combat
		},
	},
	['z'] = 0,
	['v'] = "11200-3",  -- VERSION
	['b'] = true, -- Button visibility
	["water"] = true, -- Warlock/Shaman Underwater 30-second trap (ON by default)
	["tap"] = true, -- Prevent casting while Spirit Tap / Soul Siphon are active (ON by default)
	["scaled"] = true, -- Warlock Life Tap scaling based on Item Bonuses (ON by default)
	["inner"] = true, -- Inner Fire casts at XX/20 charges (ON by default)
	["innercharges"] = 5, -- Number of charges (between 1 and 19) (5 by default)
};

local cSheep = "Spell_Nature_Polymorph";
local cEnslave = "Spell_Shadow_EnslaveDemon";
local cBanish = "Spell_Shadow_Cripple";
local cTracking = "Ability_Tracking";
local cStealth = "Ability_Stealth";
local cPre = "Interface\\Icons\\";
local cTime = 1000;
local cIconOn = "Interface\\AddOns\\AutoBuff\\ABEnabled";
local cIconOff = "Interface\\AddOns\\AutoBuff\\ABDisabled";
local cIconInnerFire = "Interface\\Icons\\Spell_Holy_InnerFire";

-- Used for the table index finder function.
local bIndex = nil;
local bValue = nil;

-- Used for LifeTap Scaling
local overtapEnabled = true;
local AFFLICTION_TAB = 1;
local IMP_LIFETAP_ID = 5;
local RANK_MULTIPLIER = {0.38,0.68,0.8,0.8,0.8,0.8};
local BASE_DAMAGE = {30,75,140,220,310,424};

-- Temp variables.
local vSit = 0;
local vBreath = 0;
local vRestingAlertTimer = 0;
local vError = {};
local vGUI = {};
local vTime = 0;
local vRejuv = 0;
local vTrack = nil;
local vWeapon = nil;
local vAspect = nil;
local vSeal = nil;
local vClass = nil;
local vSpellList = { };
local sSpellList = { };
local vTrackList = { };
local vAspectList = { };
local vSealList = { };
local vWeaponList = { };
local vC = nil;
local vLoaded = nil;
local vLoaded = {
	var = false;
	player = false;
	autobuff = false;
};
local vCombat = nil;
local AutoBuff_MFSx, AutoBuff_MBSx, AutoBuff_MLSx, AutoBuff_MRSx, AutoBuff_SRSx, AutoBuff_SLSx, AutoBuff_TARx, AutoBuff_TASx, AutoBuff_TAFx, AutoBuffCMSx, AutoBuff_CMFx, AutoBuff_WHEELUx, AutoBuff_WHEELDx, AutoBuff_TARGETx;

-- Titan Variables
TITAN_AUTOBUFF_ID =  "AutoBuff";
TITAN_AUTOBUFF_DESC =  "Auto-casts self-buffs, weapon buffs, tracking abilites, aspects, and seals.";
TITAN_AUTOBUFF_MENU_TEXT = "AutoBuff";
TITAN_AUTOBUFF_BUTTON_LABEL =  "AutoBuff";
TITAN_AUTOBUFF_TOOLTIP = "AutoBuff v"..cDefault['v'];
TITAN_AUTOBUFF_ICON_ON = "Interface\\AddOns\\AutoBuff\\ABEnabled";
TITAN_AUTOBUFF_ICON_OFF = "Interface\\AddOns\\AutoBuff\\ABDisabled";
TITAN_AUTOBUFF_ENABLE = "Enable AutoBuff";
TITAN_AUTOBUFF_BUTTONSHOW = "Show UI Button";
TITAN_AUTOBUFF_BUTTONRESET = "Reset UI Button";
TITAN_AUTOBUFF_DEBUG = "Debug Mode";
TITAN_AUTOBUFF_WATER = "Wait 30s to cast WaterBreathing";
TITAN_AUTOBUFF_TAP = "Off while Spirit Tap or Soul Siphon active";
TITAN_AUTOBUFF_SCALED = "Warlock Life Tap scaling (w/BonusScanner)";
TITAN_AUTOBUFF_INNER = "Priest Inner Fire casts at XX charges left";
TitanAutoBuffStates = {};
TitanAutoBuffStates.Enabled = nil;
TitanAutoBuffStates.Button = nil;
TitanAutoBuffStates.Debug = nil;
TitanAutoBuffStates.Water = nil;
TitanAutoBuffStates.Tap = nil;
TitanAutoBuffStates.Scaled = nil;
TitanAutoBuffStates.Inner = nil;
TITAN_AUTOBUFF_TOOLTIP_CONTENTS = "";
local u = {};

-- AutoBuffOptionsButton functions
local AutoBuffOptionsButton_BeingDragged = false;

function AutoBuffOptionsButton_OnLoad()
   	this:RegisterForClicks("LeftButtonUp", "RightButtonUp");
   	this:RegisterForDrag("LeftButton");
end

function AutoBuffOptionsButton_OnClick(arg1)
	if (arg1 == "LeftButton") then
		-- Open Options Window
		AutoBuffFrame_Toggle();
	elseif (arg1 == "RightButton") then
		-- Toggle on/off status
		AutoBuffToggle();
	end
end

function AutoBuffToggle()
	if (AutoBuff_Data[vC]['e'] == 1) then
		AutoBuff_Off();
	else
		AutoBuff_On();
	end
end

function AutoBuffDebug()
	if (AutoBuff_Data[vC]['d']) then
		AutoBuff_Data[vC]['d'] = nil;
		AutoBuff_Print("Debug is now off.");
		TitanAutoBuffStates.Debug = nil;
	else
		AutoBuff_Data[vC]['d'] = 1;
		AutoBuff_Print("Debug is now on.");
		TitanAutoBuffStates.Debug = 1;
	end
end

function AutoBuffWaterToggle()
	if (AutoBuff_Data[vC]["water"]) then
		AutoBuff_Data[vC]["water"] = false;
		AutoBuff_Print("Underwater Breathing spells will ignore swim timers.");
		TitanAutoBuffStates.Water = nil;
	else
		AutoBuff_Data[vC]["water"] = true;
		AutoBuff_Print("Underwater Breathing spells will require 30 seconds underwater time before casting (Default Behavior).");
		TitanAutoBuffStates.Water = 1;
	end
end

function AutoBuffTapToggle()
	if (AutoBuff_Data[vC]["tap"]) then
		AutoBuff_Data[vC]["tap"] = false;
		AutoBuff_Print("Will now cast spells while Spirit Tap or Soul Siphon are active.");
		TitanAutoBuffStates.Tap = nil;
	else
		AutoBuff_Data[vC]["tap"] = true;
		AutoBuff_Print("Will not cast spells while Spirit Tap or Soul Siphon are active (Default Behavior).");
		TitanAutoBuffStates.Tap = 1;
	end
end

function AutoBuffScaledToggle()
	if (AutoBuff_Data[vC]["scaled"]) then
		AutoBuff_Data[vC]["scaled"] = false;
		AutoBuff_Print("Warlock Life Tap spell will ignore scaling routines.");
		TitanAutoBuffStates.Scaled = nil;
	else
		AutoBuff_Data[vC]["scaled"] = true;
		if (IsAddOnLoaded("BonusScanner")) then
			AutoBuff_Print("Warlock Life Tap spell will be scaled for efficiency (Default Behavior).");
		else
			AutoBuff_Print("Warlock Life Tap scaling is dependent on BonusScanner. You must have that mod loaded before scaling will work.");
		end
		TitanAutoBuffStates.Scaled = 1;
	end
end

function AutoBuffInnerToggle()
	if (AutoBuff_Data[vC]["inner"]) then
		AutoBuff_Data[vC]["inner"] = false;
		AutoBuff_Print("Inner Fire will only cast when totally removed (or recast timer is up).");
		TitanAutoBuffStates.Inner = nil;
	else
		AutoBuff_Data[vC]["inner"] = true;
		AutoBuff_Print("Inner Fire will cast when "..AutoBuff_Data[vC]["innercharges"].." charges are left (Default Behavior).");
		TitanAutoBuffStates.Inner = 1;
	end
end

function AutoBuffOptionsButton_OnDragStart()
	if (not AutoBuffOptionsButton_BeingDragged) then
		this:StartMoving();
		AutoBuffOptionsButton_BeingDragged = true;
	end
end

function AutoBuffOptionsButton_OnDragStop()
	if (AutoBuffOptionsButton_BeingDragged) then
		this:StopMovingOrSizing()
		AutoBuffOptionsButton_BeingDragged = false;
	end
end

local function AutoBuff_ScaledLifeTap_GetLifeTapMultiplier()
  local name,iconPath,tier,column,rank = GetTalentInfo(AFFLICTION_TAB, IMP_LIFETAP_ID);
  local multiplier = 1;
  if (name == AUTOBUFF_ABILITY_LIFE_TAP_TALENT) then
    if rank == 1 then
      multiplier = 1.1;
    elseif rank == 2 then
      multiplier = 1.2;
    end
  else
    AutoBuff_Debug("Talent tree has changed.  Cannot determine Improved Life Tap Rank. Assuming 0 ranks.");
  end
  return multiplier;
end

local function AutoBuff_ScaledLifeTap_GetMaxLifeTapRank()
  local rank = 0;
  local count = 1;
  local foundSpell = false;
    
  while true do
    local spellName, spellRank = GetSpellName(count, BOOKTYPE_SPELL);

    if spellName == AUTOBUFF_ABILITY_LIFE_TAP then
      startPos,endPos,rank = string.find(spellRank, AUTOBUFF_SCALEDLIFETAP_RANKREGEXP);
      foundSpell = true;
    else
      if foundSpell then
        break;
      end
    end
    count = count + 1;
  end 
    
  AutoBuff_Debug("Highest rank of Life Tap is " .. rank);
  return rank;
end

local function AutoBuff_ScaledLifeTap_GetDamageBonus()
  local damageBonus = 0;
	local sentDebug = false;
  if IsAddOnLoaded("BonusScanner") then
    damageBonus = BonusScanner:GetBonus("SHADOWDMG") + BonusScanner:GetBonus("DMG");
	else
		AutoBuff_Debug("BonusScanner is not loaded.");
		sentDebug = true;
  end
  if (not sentDebug) then AutoBuff_Debug("BonusScanner reports total shadow damage bonus as: " .. damageBonus); end
	return damageBonus;
end

function AutoBuff_ScaledLifeTap_CastLifeTap()
  local damageModifier = AutoBuff_ScaledLifeTap_GetDamageBonus();
  local lifetapMultiplier = AutoBuff_ScaledLifeTap_GetLifeTapMultiplier();
  local maxRank = AutoBuff_ScaledLifeTap_GetMaxLifeTapRank();
  local castSpell = false;
  
  for i=maxRank,1,-1 do 
    if ((i == 1 and overtapEnabled and (UnitManaMax("player") ~= UnitMana("player")))) or ((UnitHealth("player")>=BASE_DAMAGE[i]+RANK_MULTIPLIER[i]*damageModifier and (UnitManaMax("player")-UnitMana("player")>=(BASE_DAMAGE[i]+RANK_MULTIPLIER[i]*damageModifier)*lifetapMultiplier))) then 
      CastSpellByName(AUTOBUFF_ABILITY_LIFE_TAP .. "(" .. AUTOBUFF_LIST_RANK .. " "..i..")");
      AutoBuff_Debug("Casting Scaled Life Tap (Rank " .. i .. ")");  
      castSpell = true;
      break;
    end
  end
  
  if not castSpell then
    AutoBuff_Debug("Canceling Life Tap (it isn't needed right now).");
  end
end

-- myAddOns Support
AutoBuff_myAddOns = {
	name = 'AutoBuff',
	description = 'Auto-self buff',
	version = cDefault['v'],
	author = 'Dsanai',
	category = MYADDONS_CATEGORY_CLASS,
	frame = '_AutoBuff',
	optionsframe = 'AutoBuffFrame'
};

UIPanelWindows["AutoBuffFrame"] = {area = "center", pushable = 0};

function AutoBuff_OnLoad()
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("LEARNED_SPELL_IN_TAB");
	this:RegisterEvent("UI_ERROR_MESSAGE");
	this:RegisterEvent("MIRROR_TIMER_START");
	this:RegisterEvent("MIRROR_TIMER_STOP");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	
	SlashCmdList["AUTOBUFF"] = AutoBuff_SlashHandler;
	SLASH_AUTOBUFF1 = "/autobuff";
	SLASH_AUTOBUFF2 = "/ab";
	
	-- Fubar Includes
	if (IsAddOnLoaded("FuBar")) then
		FuBarAutoBuff_OnLoad();
	end

	-- AutoBuff_MFSx = MoveForwardStart;		-- [Start] These hook the movement functions.
	-- AutoBuff_MBSx = MoveBackwardStart;
	-- AutoBuff_TLSx = TurnLeftStart;
	-- AutoBuff_TRSx = TurnRightStart;
	-- AutoBuff_SLSx = StrafeLeftStart;
	-- AutoBuff_SRSx = StrafeRightStart;
	-- AutoBuff_MFFx = MoveForwardStop;		-- [Stop]
	-- AutoBuff_MBFx = MoveBackwardStop;
	-- AutoBuff_TLFx = TurnLeftStop;
	-- AutoBuff_TRFx = TurnRightStop;
	-- AutoBuff_SLFx = StrafeLeftStop;
	-- AutoBuff_SRFx = StrafeRightStop;
	-- AutoBuff_TARx = ToggleAutoRun;			-- [ToggleAutorun]
	
	-- AutoBuff_TASx = TurnOrActionStart;
	-- AutoBuff_TAFx = TurnOrActionStop;
	--AutoBuff_CMSx = CameraOrSelectOrMoveStart;
	--AutoBuff_CMFx = CameraOrSelectOrMoveStop;
	
	--AutoBuff_JMPx = Jump;
	
	--Jump = AutoBuff_JMP;
	-- MoveForwardStart = AutoBuff_MFS;
	-- MoveBackwardStart = AutoBuff_MBS;
	-- TurnLeftStart = AutoBuff_TLS;
	-- TurnRightStart = AutoBuff_TRS;
	-- StrafeLeftStart = AutoBuff_SLS;
	-- StrafeRightStart = AutoBuff_SRS;
	-- MoveForwardStop = AutoBuff_MFF;
	-- MoveBackwardStop = AutoBuff_MBF;
	-- TurnLeftStop = AutoBuff_TLF;
	-- TurnRightStop = AutoBuff_TRF;
	-- StrafeLeftStop = AutoBuff_SLF;
	-- StrafeRightStop = AutoBuff_SRF;
	-- ToggleAutoRun = AutoBuff_TAR;
	-- TurnOrActionStart = AutoBuff_TAS;
	-- TurnOrActionStop = AutoBuff_TAF;
	--CameraOrSelectOrMoveStart = AutoBuff_CMS;
	--CameraOrSelectOrMoveStop = AutoBuff_CMF;
	
	AutoBuff_WHEELUx = CameraZoomIn;
	AutoBuff_WHEELDx = CameraZoomOut;
	CameraZoomIn  = AutoBuff_WHEELU;
	CameraZoomOut = AutoBuff_WHEELD;	

	AutoBuff_TableConfig();	
	AutoBuff_PaladinSetup();
	
	-- Apply INDEX numbers to the cSpellList (add element to each, named ["i"] = #
	local indexAssignment = 1;
	for key, value in cSpellList do
		cSpellList[key]["i"] = indexAssignment;
		indexAssignment = indexAssignment + 1;
		--AutoBuff_Print("cSpellList INDEXING: "..key.." to "..indexAssignment);
	end
	
	if ButtonHole then -- ButtonHole support (did it like author said, but don't think it works)
		ButtonHole.application.RegisterMod({id='AutoBuffEmerald1800', name='AutoBuff',tooltip='Automatically casts self-buffs, weapon buffs, tracking abilites, and aspects.',buttonFrame='AutoBuffOptionsButton',updateFunction='AutoBuffOptionsButton_OnDragStart'});
	end
	
	u = Utility_Class:New();
	
end

function AutoBuff_ZMI(arg1)
	AutoBuff_Check(0);
	AutoBuff_ZMIx(arg1);
end

function AutoBuff_ZMO(arg1)
	AutoBuff_Check(0);
	AutoBuff_ZMOx(arg1);
end

function AutoBuff_OnEvent(event)

	if (event == "UNIT_NAME_UPDATE" and arg1 == "player") or (event == "PLAYER_ENTERING_WORLD") then
		if (vLoaded.autobuff ~= true) then
			vLoaded.player = true;
		end
		
	elseif (event == "VARIABLES_LOADED") then
		vLoaded.var = true;
		if (myAddOnsFrame_Register) then
			myAddOnsFrame_Register(AutoBuff_myAddOns);
		elseif (myAddOnsFrame) then
			myAddOnsList.AutoBuff = AutoBuff_myAddOns;
		end
		
	elseif (event == "PLAYER_TARGET_CHANGED") then
		--AutoBuff_Check(0);
		AutoBuff_TARGET();

	elseif (event == "PLAYER_REGEN_ENABLED") then
		vCombat = nil;
	
	elseif (event == "PLAYER_REGEN_DISABLED") then
		vCombat = true;
	
	elseif (event == "LEARNED_SPELL_IN_TAB") then
		AutoBuff_Reload();
	
	elseif (event == "MIRROR_TIMER_START" and arg6=="Breath") then
		--AutoBuff_Debug("---MirrorTimerStart with arg6="..arg6);
		vBreath = time() +30;
		
	elseif (event == "MIRROR_TIMER_STOP") then
		--AutoBuff_Debug("---MirrorTimerStop");
		vBreath = 0;
		
	elseif (event == "UI_ERROR_MESSAGE") then
		if (arg1 == SPELL_FAILED_AURA_BOUNCED) then
			vTime = time() + 30; end -- A more powerful spell is already active
		if (arg1 == SPELL_FAILED_ONLY_OUTDOORS) then
			vTime = time() + 30; end -- Nature's Grasp trap
		if (arg1 == SPELL_FAILED_SILENCED) then
			vTime = time() + 5; end -- Silenced
		if (arg1 == SPELL_FAILED_REAGENTS) then
			vTime = time() + 30; end -- Out of regeant(s)
		if (arg1 == SPELL_FAILED_MAINHAND_EMPTY) then
			vTime = time() + 30; end -- No main-hand weapon
		if (arg1 == SPELL_FAILED_NOT_STANDING) then
			vSit = time() + 5; end
			
	end
	
	if (vLoaded.player) and (vLoaded.var) and (vLoaded.autobuff ~= true) then
		-- Only load when Character + Vars are loaded
		
		-- Expand Trigger text on GUI if using french locale.
		if (GetLocale() == "frFR") then
			AutoBuffFrameOptionsTrigger_Text:SetWidth(AutoBuffFrameOptionsTrigger_Text:GetWidth() +40);
		end
		
		local vServer = GetCVar("realmName");
		local vPlayer = UnitName("player");
	
		vClass = string.lower(UnitClass("player"));
		vC = vPlayer.." of "..vServer;		-- Used for character specific saved variables

		if (vClass == string.lower(AUTOBUFF_CLASS_DRUID)) then -- fix Druid Track Humanoids setup
			if not cSpellList[AUTOBUFF_ABILITY_TRACK_HUMANOIDS] then
				cSpellList[AUTOBUFF_ABILITY_TRACK_HUMANOIDS] = { ["i"] = table.getn(cSpellList)+1, ["type"] = "self" };
			end
		elseif (vClass == string.lower(AUTOBUFF_CLASS_HUNTER)) then
			--table.insert(cTrackList, AUTOBUFF_ABILITY_TRACK_HUMANOIDS);
			if not cTrackList[AUTOBUFF_ABILITY_TRACK_HUMANOIDS] then
				cTrackList[AUTOBUFF_ABILITY_TRACK_HUMANOIDS] = "Unknown";
			end
		end

		AutoBuff_LoadDefaults(); 			-- Check SavedVariables against defaults,
								-- if any missing entries, defaults for those entries are loaded
		AutoBuff_TableConfig();				-- table.setn's the 3 constant tables, cSpellList, cTrackList and cWeaponList
		
		-- Fix my ['w'] vs. ['water'] screw-up
		if (AutoBuff_Data[vC]['w']==true or not AutoBuff_Data[vC]['w']) then
			AutoBuff_Data[vC]['w'] = "off";
		end

		AutoBuff_Reload();				-- Next we run through the constant tables for list of spells,
								-- and create temporary ones that have just those that are truly available
		
		if (cPolyList[vClass] == nil) then
			AutoBuff_Print("Your language is not supported!");
		else
			vLoaded.autobuff = true; 			-- Loading complete.
			AutoBuff_Debug("AutoBuff Loaded.");
		end
		
		if (AutoBuff_Data[vC]['b']) then -- Set Button Visibility State
			AutoBuffOptionsButton:Show();
			TitanAutoBuffStates.Button = 1;
		else
			AutoBuffOptionsButton:Hide();
			TitanAutoBuffStates.Button = nil;
		end
		
		if (AutoBuff_Data[vC]['d']) then -- Set Debug State
			TitanAutoBuffStates.Debug = 1;
		else
			TitanAutoBuffStates.Debug = nil;
		end

		if (AutoBuff_Data[vC]["water"]) then -- Set Water State
			TitanAutoBuffStates.Water = 1;
		else
			TitanAutoBuffStates.Water = nil;
		end

		if (AutoBuff_Data[vC]["tap"]) then -- Set Spirit Tap Block State
			TitanAutoBuffStates.Tap = 1;
		else
			TitanAutoBuffStates.Tap = nil;
		end

		if (AutoBuff_Data[vC]["scaled"]) then -- Set Life Tap Scaling State
			TitanAutoBuffStates.Scaled = 1;
		else
			TitanAutoBuffStates.Scaled = nil;
		end

		if (AutoBuff_Data[vC]["inner"]) then -- Set Inner Fire recast State
			TitanAutoBuffStates.Inner = 1;
		else
			TitanAutoBuffStates.Inner = nil;
		end

		if (AutoBuff_Data[vC]["innercharges"]) then -- Set Inner Fire recast charges
			TITAN_AUTOBUFF_INNER = "Priest Inner Fire casts at "..AutoBuff_Data[vC]["innercharges"].." charges left";
		else
			AutoBuff_Data[vC]["innercharges"] = cDefault["innercharges"];
			TITAN_AUTOBUFF_INNER = "Priest Inner Fire casts at "..AutoBuff_Data[vC]["innercharges"].." charges left";
		end
		if (IsAddOnLoaded("FuBar")) then AutoBuffFu:Update(); end

		if (AutoBuff_Data[vC]['e'] == 1) then -- Fix button texture based on On/Off state
			AutoBuffOptionsButton:SetNormalTexture(cIconOn);
			AutoBuffOptionsButton:SetPushedTexture(cIconOff);
			if (AutoBuffFu) then
				AutoBuffFu:SetIcon(TITAN_AUTOBUFF_ICON_ON..".tga");
			end
			if (IsAddOnLoaded("Titan")) then
				local button = TitanUtils_GetButton(TITAN_AUTOBUFF_ID, true);
				if (button) then
					button.registry.icon = TITAN_AUTOBUFF_ICON_ON;
					TitanPanelButton_UpdateButton(TITAN_AUTOBUFF_ID);
				end
				--TITAN_AUTOBUFF_TOOLTIP_CONTENTS = TitanUtils_GetColoredText("Enabled", u.ColorList[string.lower("green")]).."\t"..TitanUtils_GetColoredText("", u.ColorList[string.lower("yellow")]).."\n";
			end
			TitanAutoBuffStates.Enabled = 1;
		else
			AutoBuffOptionsButton:SetNormalTexture(cIconOff);
			AutoBuffOptionsButton:SetPushedTexture(cIconOn);
			if (AutoBuffFu) then
				AutoBuffFu:SetIcon(TITAN_AUTOBUFF_ICON_OFF..".tga");
			end
			if (IsAddOnLoaded("Titan")) then
				local button = TitanUtils_GetButton(TITAN_AUTOBUFF_ID, true);
				if (button) then
					button.registry.icon = TITAN_AUTOBUFF_ICON_OFF;
					TitanPanelButton_UpdateButton(TITAN_AUTOBUFF_ID);
				end
				--TITAN_AUTOBUFF_TOOLTIP_CONTENTS = TitanUtils_GetColoredText("Disabled", u.ColorList[string.lower("red")]).."\t"..TitanUtils_GetColoredText("", u.ColorList[string.lower("yellow")]).."\n";
			end
			TitanAutoBuffStates.Enabled = nil;
		end
		
	end
	--UpdateABClickyBox();
end

function AutoBuff_Trigger(spell)
	local n = AutoBuff_Option(spell, 't');
	if (n == nil) then n = AutoBuff_Option('d', 't'); end
	local i,t; local z = { 0, 0, 0, 0, 0, 0 };
	for i=6,1,-1 do
		t = n - 2^i;
		if (t >= 0) then
			n = t; z[i] = 1;
		end
		if (n == 0) then
			break; end
		end
	--	forward, strafe, turn, lmb, rmb
	AutoBuff_Debug("["..z[1]..", "..z[2]..", "..z[3]..", "..z[4]..", "..z[5]..", "..z[6].."]");
	return z;
end

function AutoBuff_On()
	AutoBuff_Data[vC]['e'] = 1;
	AutoBuff_Print(AUTOBUFF_ENABLED);
	AutoBuffOptionsButton:SetNormalTexture(cIconOn);
	AutoBuffOptionsButton:SetPushedTexture(cIconOff);
	if (AutoBuffFu) then
		AutoBuffFu:SetIcon(TITAN_AUTOBUFF_ICON_ON..".tga");
	end
	-- Change Titan icon, if applicable
	if (IsAddOnLoaded("Titan")) then
		local button = TitanUtils_GetButton(TITAN_AUTOBUFF_ID, true);
		if (button) then
			button.registry.icon = TITAN_AUTOBUFF_ICON_ON;
			TitanPanelButton_UpdateButton(TITAN_AUTOBUFF_ID);
		end
		--TITAN_AUTOBUFF_TOOLTIP_CONTENTS = TitanUtils_GetColoredText("Enabled", u.ColorList[string.lower("green")]).."\t"..TitanUtils_GetColoredText("", u.ColorList[string.lower("yellow")]).."\n";
	end
	TitanAutoBuffStates.Enabled = 1;
end

function AutoBuff_Off()
	AutoBuff_Data[vC]['e'] = 0;
	AutoBuff_Print(AUTOBUFF_DISABLED);
	AutoBuffOptionsButton:SetNormalTexture(cIconOff);
	AutoBuffOptionsButton:SetPushedTexture(cIconOn);
	if (AutoBuffFu) then
		AutoBuffFu:SetIcon(TITAN_AUTOBUFF_ICON_OFF..".tga");
	end
	-- Change Titan icon, if applicable
	if (IsAddOnLoaded("Titan")) then
		local button = TitanUtils_GetButton(TITAN_AUTOBUFF_ID, true);
		if (button) then
			button.registry.icon = TITAN_AUTOBUFF_ICON_OFF;
			TitanPanelButton_UpdateButton(TITAN_AUTOBUFF_ID);
		end
		--TITAN_AUTOBUFF_TOOLTIP_CONTENTS = TitanUtils_GetColoredText("Disabled", u.ColorList[string.lower("red")]).."\t"..TitanUtils_GetColoredText("", u.ColorList[string.lower("yellow")]).."\n";
	end
	TitanAutoBuffStates.Enabled = nil;
end

function AutoBuff_HideButton() -- toggle
	if (AutoBuff_Data[vC]['b']) then
		AutoBuff_Data[vC]['b'] = false;
		AutoBuffOptionsButton:Hide();
		AutoBuff_Print(AUTOBUFF_BUTTON_HIDDEN);
		TitanAutoBuffStates.Button = nil;
	else
		AutoBuff_Data[vC]['b'] = true;
		AutoBuffOptionsButton:Show();
		AutoBuff_Print(AUTOBUFF_BUTTON_SHOWN);
		TitanAutoBuffStates.Button = 1;
	end
end

function AutoBuff_ResetButton() -- reset position
	AutoBuffOptionsButton:ClearAllPoints();
	AutoBuffOptionsButton:SetPoint("CENTER", "UIParent", "CENTER", 200, 200);
	AutoBuff_Data[vC]['b'] = true;
	AutoBuffOptionsButton:Show();
	TitanAutoBuffStates.Button = 1;
end

function AutoBuff_SlashHandler(msg)

	-- Thanks to AutoRepair for this wicked seperator :)
	if (msg) then msg = string.lower(msg); end
	local _,_,c,p = string.find(msg,"([%w%p]+)%s*(.*)$");
	
	if (c == "on") then
		AutoBuff_On();
		
	elseif (c == "off") then
		AutoBuff_Off();
		
	elseif (c == "hide") then
		AutoBuff_HideButton();
		
	elseif (c == "resetbutton") then
		AutoBuff_ResetButton();
		
	elseif (c == "toggle") then
		if (p) and (strlen(p) > 0) then
			if (vSpellList[p]) then
				local g = 1;
				if (AutoBuff_Option(p, 'd') == 1) then g = "default"; end
				AutoBuff_Option(p, 'd', g, 1);
				if (AutoBuff_IsBlessing(p)) then AutoBuff_FixBlessing(p); end if (AutoBuff_IsAura(p)) then AutoBuff_FixAura(p); end
			elseif (vWeaponList[p]) then
				if (vWeapon == p) then p = "off"; end
				AutoBuff_Data[vC]['w'] = p;
				AutoBuff_WeaponLoad("show")
			else AutoBuff_Print(string.format(AUTOBUFF_NOTSUPPORTED, p)); end
		else
			if (AutoBuff_Data[vC]['e'] == 1) then
				AutoBuff_Off();
			else
				AutoBuff_On();
			end
		end
		
	elseif (c == "debug") then
		AutoBuffDebug();
		
	elseif (c == "water") then
		AutoBuffWaterToggle();
		
	elseif (c == "tap") then
		AutoBuffTapToggle();
	
	elseif (c == "scaled") then
		AutoBuffScaledToggle();
		
	elseif (c == "inner") then
		AutoBuffInnerToggle();
		
	elseif (c == "checkbuffs") or (c == "check") or (c == "run") then
		AutoBuff_Check(0);
		
	elseif (c == "reset") then
		if (p == "confirm") then
			AutoBuff_Data[vC] = nil;
			AutoBuff_LoadDefaults();
			AutoBuff_Reload();
			AutoBuff_Print(AUTOBUFF_RESET);
		else
			AutoBuff_Print(AUTOBUFF_RESET_CONFIRM);
		end
		
	elseif (c == "rank") then
		local _,_,v,a = string.find(p,"([%w%p]+)%s*(.*)$");
		if (v) and (strlen(v) > 0) and ((v == "default") or ((tonumber(v)) and (tonumber(v) > 0) and (tonumber(v) < 20))) then
			if (v ~= "default") then v = math.floor(tonumber(v)); end
			if (not a) or (strlen(a) == 0) then a = "none"; end
			if (not vSpellList[a]) and (not vWeaponList[a]) then AutoBuff_Print(string.format(AUTOBUFF_NOTSUPPORTED, a));
			elseif (v == "default") or ((vSpellList[a]) and (vSpellList[a]['k']) and (v <= vSpellList[a]['k'])) or ((vWeaponList[a]) and (vWeaponList[a] ~= true) and (v <= vWeaponList[a])) or ((vSealList[a]) and (vSealList[a]['k']) and (v <= vSealList[a]['k'])) then
				AutoBuff_Option(a, 'k', v, 1);
			else
				AutoBuff_Print(AUTOBUFF_NOSUCHRANK);
			end
		else AutoBuff_Print(AUTOBUFF_RANK_USAGE1.."\n"..AUTOBUFF_RANK_USAGE2.."\n"..AUTOBUFF_RANK_USAGE3.."\n"..AUTOBUFF_RANK_USAGE4); end
	elseif (c == "rebuff") then
		local _,_,v,a = string.find(p,"([%w%p]+)%s*(.*)$");
		if (v) and (strlen(v) > 0) and ((v == "default") or ((tonumber(v)) and (tonumber(v) >= 0) and (tonumber(v) < 300))) then
			if (v ~= "default") then v = math.floor(tonumber(v)); end
			if (a) and (strlen(a) > 0) and (not vSpellList[a]) and (not vWeaponList[a]) then AutoBuff_Print(string.format(AUTOBUFF_NOTSUPPORTED, a));
			else AutoBuff_Option(a, 'r', v, 1); end
		else AutoBuff_Print(AUTOBUFF_REBUFF_USAGE1.."\n"..AUTOBUFF_REBUFF_USAGE2.."\n"..AUTOBUFF_REBUFF_USAGE3.."\n"..AUTOBUFF_REBUFF_USAGE4.."\n"
								..AUTOBUFF_REBUFF_USAGE5); end
	
	elseif (c == "trigger") then
		local _,_,v,a = string.find(p,"([%w%p]+)%s*(.*)$");
		if (v) and
		(strlen(v) > 0) and	((v == "default") or ((tonumber(v)) and	(tonumber(v) >= 0) and (tonumber(v) <= 126) and ((tonumber(v) /2) == floor(tonumber(v) /2)))) then
			if (a) and (strlen(a) > 0) and (not vSpellList[a]) and (not vWeaponList[a]) then AutoBuff_Print(string.format(AUTOBUFF_NOTSUPPORTED, a));
			else AutoBuff_Option(a, 't', v, 1); end
		else AutoBuff_Print(AUTOBUFF_TRIGGER_USAGE1.."\n"..AUTOBUFF_TRIGGER_USAGE2.."\n"..AUTOBUFF_TRIGGER_USAGE3.."\n"..AUTOBUFF_TRIGGER_USAGE4.."\n"
								..AUTOBUFF_TRIGGER_USAGE5); end
	
	elseif (c == "reload") then
		AutoBuff_Reload();
		AutoBuff_Print(AUTOBUFF_RELOADED);
		
	elseif (c == "combat") then
		local _,_,v,a = string.find(p,"([%w%p]+)%s*(.*)$");
		if (v) and (strlen(v) > 0) and ((v == "default") or (v == ">") or (v == "<") or (v == "<>")) then
			if (v == "<") then v = 1; elseif (v == ">") then v = 2; elseif (v == "<>") then v = 3; end
			if (a) and (strlen(a) > 0) and (not vSpellList[a]) and (not vWeaponList[a]) then AutoBuff_Print(string.format(AUTOBUFF_NOTSUPPORTED, a));
			else AutoBuff_Option(a, 'c', v, 1); end
		else AutoBuff_Print(AUTOBUFF_COMBAT_USAGE1.."\n"..AUTOBUFF_COMBAT_USAGE2.."\n"..AUTOBUFF_COMBAT_USAGE3.."\n"..AUTOBUFF_COMBAT_USAGE4
							.."\n"..AUTOBUFF_COMBAT_USAGE5); end
	
	elseif (c == "party") then
		local _,_,v,a = string.find(p,"([%w%p]+)%s*(.*)$");
		if (v) and (strlen(v) > 0) and ((v == "default") or (v == ">") or (v == "<") or (v == "<>")) then
			if (v == "<") then v = 1; elseif (v == ">") then v = 2; elseif (v == "<>") then v = 3; end
			if (a) and (strlen(a) > 0) and (not vSpellList[a]) and (not vWeaponList[a]) then AutoBuff_Print(string.format(AUTOBUFF_NOTSUPPORTED, a));
			else AutoBuff_Option(a, 'p', v, 1); end
		else AutoBuff_Print(AUTOBUFF_PARTY_USAGE1.."\n"..AUTOBUFF_PARTY_USAGE2.."\n"..AUTOBUFF_PARTY_USAGE3.."\n"..AUTOBUFF_PARTY_USAGE4
							.."\n"..AUTOBUFF_PARTY_USAGE5); end
	
	elseif (c == "track") then
		if (p) and (strlen(p) > 0) then
			if (p == "auto") then p = nil;
			elseif (p ~= "off") and (not vTrackList[p]) then AutoBuff_Print(string.format(AUTOBUFF_NOTSUPPORTED, p)); end
			AutoBuff_Data[vC]['t'] = p;
			AutoBuff_TrackLoad("show")
		else
			AutoBuff_Print(AUTOBUFF_TRACK_USAGE1.."\n"..AUTOBUFF_TRACK_USAGE2);
		end
		
	elseif (c == "aspect") then
		if (p) and (strlen(p) > 0) then
			if (p == "auto") then p = nil;
			elseif (p ~= "off") and (not vAspectList[p]) then AutoBuff_Print(string.format(AUTOBUFF_NOTSUPPORTED, p)); end
			AutoBuff_Data[vC]['a'] = p;
			AutoBuff_AspectLoad("show");
		else
			AutoBuff_Print(AUTOBUFF_ASPECT_USAGE1.."\n"..AUTOBUFF_ASPECT_USAGE2);
		end
		
	elseif (c == "seal") then
		if (p) and (strlen(p) > 0) then
			if (p == "auto") then p = nil;
			elseif (p ~= "off") and (not vSealList[p]) then AutoBuff_Print(string.format(AUTOBUFF_NOTSUPPORTED, p)); end
			AutoBuff_Data[vC]['seal'] = p;
			AutoBuff_SealLoad("show");
		else
			AutoBuff_Print(AUTOBUFF_SEAL_USAGE1.."\n"..AUTOBUFF_SEAL_USAGE2);
		end
		
	elseif (c == "weapon") then
		if (p) and (strlen(p) > 0) then
			if (p == "auto") then p = nil;
			elseif (p ~= "off") and (not vWeaponList[p]) then AutoBuff_Print(string.format(AUTOBUFF_NOTSUPPORTED, p)); end
			AutoBuff_Data[vC]['w'] = p;
			AutoBuff_WeaponLoad("show")
		else
			AutoBuff_Print(AUTOBUFF_WEAPON_USAGE1.."\n"..AUTOBUFF_WEAPON_USAGE2);
		end
		
	elseif (c == "mana") then
		local _,_,v,a = string.find(p,"([%w%p]+)%s*(.*)$");
		if (v) and (strlen(v) > 0) and ((v == "default") or ((tonumber(v)) and (tonumber(v) >= -100) and (tonumber(v) < 100))) then
			if (v ~= "default") then v = math.floor(tonumber(v)); end
			if (a) and (strlen(a) > 0) and (not vSpellList[a]) and (not vWeaponList[a]) then AutoBuff_Print(string.format(AUTOBUFF_NOTSUPPORTED, a));
			else AutoBuff_Option(a, 'm', v, 1); end
		else AutoBuff_Print(AUTOBUFF_MANA_USAGE1.."\n"..AUTOBUFF_MANA_USAGE2.."\n"..AUTOBUFF_MANA_USAGE3); end
		
	elseif (c == "health") then
		local _,_,v,a = string.find(p,"([%w%p]+)%s*(.*)$");
		if (v) and (strlen(v) > 0) and ((v == "default") or ((tonumber(v)) and (tonumber(v) >= -100) and (tonumber(v) < 100))) then
			if (v ~= "default") then v = math.floor(tonumber(v)); end
			if (a) and (strlen(a) > 0) and (not vSpellList[a]) and (not vWeaponList[a]) then AutoBuff_Print(string.format(AUTOBUFF_NOTSUPPORTED, a));
			else AutoBuff_Option(a, 'h', v, 1); end
		else AutoBuff_Print(AUTOBUFF_HEALTH_USAGE1.."\n"..AUTOBUFF_HEALTH_USAGE2.."\n"..AUTOBUFF_HEALTH_USAGE3); end
		
	elseif (c == "innercharges") then
		local _,_,v = string.find(p,"([%w%p]+)$");
		if (v) and (strlen(v) > 0) and ((v == "default") or ((tonumber(v)) and (tonumber(v) > 0) and (tonumber(v) <= 19))) then
			if (v ~= "default") then
				AutoBuff_Data[vC]["innercharges"] = math.floor(tonumber(v));
			else
				AutoBuff_Data[vC]["innercharges"] = 5;
			end
			TITAN_AUTOBUFF_INNER = "Priest Inner Fire casts at "..AutoBuff_Data[vC]["innercharges"].." charges left";
			AutoBuff_Print("Inner Fire will now be cast when there are "..AutoBuff_Data[vC]["innercharges"].." charges left");
			if (IsAddOnLoaded("FuBar")) then AutoBuffFu:Update(); end
		else AutoBuff_Print(AUTOBUFF_INNERCHARGES_USAGE1.."\n"..AUTOBUFF_INNERCHARGES_USAGE2.."\n"..AUTOBUFF_INNERCHARGES_USAGE3); AutoBuff_Print("It is currently set to "..AutoBuff_Data[vC]["innercharges"].."."); end
		
	elseif (vClass == string.lower(AUTOBUFF_CLASS_WARLOCK)) and (c == "succubus") then
		if (AutoBuff_Data[vC]['s'] == nil) then
			AutoBuff_Data[vC]['s'] = 1;
			AutoBuff_Print("Succubus, |cffa0ffa0"..AUTOBUFF_ENABLED..FONT_COLOR_CODE_CLOSE);
		else
			AutoBuff_Data[vC]['s'] = nil;
			AutoBuff_Print("Succubus, |cffffa0a0"..AUTOBUFF_DISABLED..FONT_COLOR_CODE_CLOSE);
		end
		
	elseif (c == "enable") then
		if (p) and (strlen(p) > 0) then
			if (vSpellList[p]) then AutoBuff_Option(p, 'd', "default", 1); if (AutoBuff_IsBlessing(p)) then AutoBuff_FixBlessing(p); end if (AutoBuff_IsAura(p)) then AutoBuff_FixAura(p); end
			else AutoBuff_Print(string.format(AUTOBUFF_NOTSUPPORTED, p)); end
		else 
			AutoBuff_Print(AUTOBUFF_SETABILITY_ENABLE_USAGE1.."\n"..AUTOBUFF_SETABILITY_ENABLE_USAGE2.."\n"
							..AUTOBUFF_SETABILITY_ENABLE_USAGE3.."\n"..AUTOBUFF_SETABILITY_ENABLE_USAGE4);
		end
		
	elseif (c == "disable") then
		if (p) and (strlen(p) > 0) then
			if (vSpellList[p]) then AutoBuff_Option(p, 'd', 1, 1);
			else AutoBuff_Print(string.format(AUTOBUFF_NOTSUPPORTED, p)); end
		else 
			AutoBuff_Print(AUTOBUFF_SETABILITY_DISABLE_USAGE1.."\n"..AUTOBUFF_SETABILITY_DISABLE_USAGE2.."\n"
							..AUTOBUFF_SETABILITY_DISABLE_USAGE3.."\n"..AUTOBUFF_SETABILITY_DISABLE_USAGE4);
		end
		
	elseif (c == "list") then
		local i,x,v,k,m;
		AutoBuff_Seperator();
		local default, spell, weapon, track, aspect, seal, text = "", "", "", "", "", "", "";
		text = AUTOBUFF_LIST_START.."\n-\n";
		i = 1;
		while (i > -1) do
			x = AutoBuff_SpellList(i);
			if (not x) then break; end
			x = string.lower(x);
			if (vSpellList[x]) then spell = spell..AutoBuff_ListItem(x).."\n"; end
			i=i+1;
		end
		for iName, xName in vWeaponList do
			weapon = weapon..AutoBuff_ListItem(iName).."\n";
		end
		for iName, xName in vTrackList do
			track = track..AutoBuff_ListItem(iName).."\n";
		end
		for iName, xName in vAspectList do
			aspect = aspect..AutoBuff_ListItem(iName).."\n";
		end
		for iName, xName in vSealList do
			seal = seal..AutoBuff_ListItem(iName).."\n";
		end
		default = AutoBuff_ListItem('d');
		if (strlen(spell) >0) then text = text..spell.."-\n"; end
		if (strlen(weapon) >0) then text = text..weapon.."-\n"; end
		if (strlen(track) >0) then text = text..track.."-\n"; end
		if (strlen(aspect) >0) then text = text..aspect.."-\n"; end
		if (strlen(seal) >0) then text = text..seal.."-\n"; end
		text = text..string.upper(AUTOBUFF_LIST_DEFAULT).." - "..default.."\n-";
		AutoBuff_Print(text);
	elseif (c == "help") then
		AutoBuff_Print(AUTOBUFF_USAGE.."\n"..AUTOBUFF_USAGE_LIST);
		
	else
		AutoBuffFrame_Toggle();
		
	end
end

function AutoBuff_ListItem(i)
	local m = "";
	if (i ~= 'd') then m = m.."|cffffffa0"..string.upper(i)..FONT_COLOR_CODE_CLOSE.." - "; end
	if ((AutoBuff_Data[vC]['x'][i]) and (AutoBuff_Data[vC]['x'][i]['d'] == 1)) or ((vTrackList[i]) and (vTrack ~= i)) or ((vWeaponList[i]) and (vWeapon ~= i)) or ((vAspectList[i]) and (vAspect ~= i)) or ((vSealList[i]) and (vSeal ~= i)) then return m.."|cffff5050"..AUTOBUFF_LIST_DISABLED..FONT_COLOR_CODE_CLOSE;
	-- EMERALD: I think this is where the "change aspect, AB disables" is happening. Why was this written?
	elseif (vTrackList[i]) then return m..AUTOBUFF_ENABLED;
	elseif (vAspectList[i]) then return m..AUTOBUFF_ENABLED;
	elseif (vSealList[i]) then return m..AUTOBUFF_ENABLED; end
	if (AutoBuff_Data[vC]['x'][i] == nil) then return m..AUTOBUFF_LIST_USINGDEFAULTS; end
	local trigger, health, mana, rebuff, combat, rank = "","","","","","";
	for v, k in AutoBuff_Data[vC]['x'][i] do
		if (v == 'h') then
			if (k < 0) then t = "<"; k = k * -1;
			else t = ">"; end
			health = "|cffffa0a0"..AUTOBUFF_LIST_HEALTH..", "..t..k.."%"..FONT_COLOR_CODE_CLOSE.." ";
		elseif (v == 'm')  then
			if (k < 0) then t = "<"; k = k * -1;
			else t = ">"; end
			mana = "|cff5e9ae4"..AUTOBUFF_LIST_MANA..", "..t..k.."%"..FONT_COLOR_CODE_CLOSE.." ";
		elseif (v == 'c')  then
			if (k == 1) then combat = AUTOBUFF_LIST_COMBAT_IN; end
			if (k == 2) then combat = AUTOBUFF_LIST_COMBAT_OUT; end
			if (k == 3) then combat = AUTOBUFF_LIST_COMBAT_ALWAYS; end
			combat = "|cfff0802e"..combat..FONT_COLOR_CODE_CLOSE.." ";
		--elseif (v == 'r') and (not AutoBuff_IsAura(i)) and (i ~= string.lower(AUTOBUFF_ABILITY_TRUESHOTAURA)) then
		elseif (v == 'r') and (not AutoBuff_IsAura(i)) then
			rebuff = "|cffa0a0a0"..string.format(AUTOBUFF_LIST_REBUFF,k)..FONT_COLOR_CODE_CLOSE.." ";
		elseif (v == 't') then
			trigger = "|cffe0e0e0"..AUTOBUFF_LIST_TRIGGER..", "..k..FONT_COLOR_CODE_CLOSE.." ";
		elseif (v == 'k') then
			rank = "|cffffa0ff"..AUTOBUFF_LIST_RANK..", "..k..FONT_COLOR_CODE_CLOSE.." ";
		end
	end
	if (strlen(trigger..health..mana..rebuff..combat..rank) < 1) then rebuff = AUTOBUFF_LIST_USINGDEFAULTS; end
	m = m..trigger..health..mana..rebuff..combat..rank;
	return m;
end

function AutoBuff_IsBlessing(n)
	local a,d;
	n = string.lower(n);
	for _, d in cBlessing do
		a = string.lower(d);
		if (n == a) then a = 1; break; end
	end
	if (a == 1) then return 1; end
end

function AutoBuff_IsAura(n)
	local a,d;
	n = string.lower(n);
	for _, d in cAura do
		a = string.lower(d);
		if (n == a) then a = 1; break; end
	end
	if (a == 1) then return 1; end
end

function AutoBuff_FixBlessing(b)
	b = string.lower(b);
	local n,a;
	for _, n in cBlessing do
		a = string.lower(n);
		if (a ~= b) and (vSpellList[a]) then AutoBuff_Option(a, 'd', 1); end
	end
end

function AutoBuff_FixAura(b)
	b = string.lower(b);
	local n,a;
	for _, n in cAura do
		a = string.lower(n);
		if (a ~= b) and (vSpellList[a]) then AutoBuff_Option(a, 'd', 1); end
	end
end

function AutoBuff_PaladinSetup()
	local i,n,d,o,x;
	x = table.getn(cSpellList);
	o = 0;
	while (o > -1) do
		n = cBlessing[o];
		if (not n) then break; end
		i=0;
		cSpellList[n] = { ['type'] = "friendly", ['i'] = (x+o+1) };
		for _, d in cBlessing do
			if (n ~= d) then cSpellList[n][i] = string.lower(d); i=i+1; end
		end
		for _, d in cBlessingOther do
			cSpellList[n][i] = string.lower(d); i=i+1
		end
		o=o+1;
	end
	x = x+o;
	o = 0;
	while (o > -1) do
		n = cAura[o];
		if (not n) then break; end
		i=0;
		cSpellList[n] = { ['type'] = "self", ['i'] = (x+o+1) };
		for _, d in cAura do
			if (n ~= d) then cSpellList[n][i] = string.lower(d); i=i+1; end
		end
		o=o+1;
	end
end

function AutoBuff_BuffName(i, filter)
	--AutoBuffTooltip:SetOwner(WorldFrame,"ANCHOR_NONE");
	if (filter == nil) then	filter = "HELPFUL|HARMFUL"; end
	local iBuff,iBuffConc = GetPlayerBuff(i, filter);
	if (iBuff >= 0) and (iBuff < 24) then
		--local tooltip = AutoBuffTooltip;
		--tooltip:Hide();
		--tooltip:SetPlayerBuff(iBuff);
		local tooltip = AutoBuffTooltip;
		tooltip:SetOwner(tooltip,"ANCHOR_NONE");
		tooltip:ClearLines();
		tooltip:SetPlayerBuff(iBuff);
		local toolTipText = getglobal("AutoBuffTooltipTextLeft1");
		if (toolTipText) then
			local name = toolTipText:GetText();
			if ( name ~= nil ) then	return iBuff, name, iBuffConc; end
		end
	end
end

function AutoBuff_IsBuffActive(buffname)
	--AutoBuffTooltip:SetOwner("UIParent", "ANCHOR_NONE");
	if (not buffname) then
		return;
	end;
	unit="player";
  local i = 1;
  while UnitBuff(unit, i) do 
		AutoBuffTooltip:ClearLines();
		AutoBuffTooltip:SetUnitBuff(unit,i);
    if string.find(AutoBuffTooltipTextLeft1:GetText() or "", buffname) then
      return true, i
    end;
    i = i + 1;
  end;
end

function AutoBuff_IsDebuffActive(buffname)
	--AutoBuffTooltip:SetOwner("UIParent", "ANCHOR_NONE");
	if (not buffname) then
		return;
	end;
	unit="player";
  local i = 1;
  while UnitDebuff(unit, i) do 
		AutoBuffTooltip:ClearLines();
		AutoBuffTooltip:SetUnitDebuff(unit,i);
    if string.find(AutoBuffTooltipTextLeft1:GetText() or "", buffname) then
      return true, i
    end;
    i = i + 1;
  end;
end

function AutoBuff_BuffLine(i, line, filter)
	--AutoBuffTooltip:SetOwner(WorldFrame,"ANCHOR_NONE");
	if (filter == nil) then	filter = "HELPFUL|HARMFUL"; end
	local iBuff,_ = GetPlayerBuff(i, filter);
	if (iBuff >= 0) and (iBuff < 24) then
		--local tooltip = AutoBuffTooltip;
		--tooltip:SetPlayerBuff(iBuff);
		--tooltip:Hide();
		local tooltip = AutoBuffTooltip;
		tooltip:SetOwner(tooltip,"ANCHOR_NONE");
		tooltip:ClearLines();
		tooltip:SetPlayerBuff(iBuff);
		local toolTipText = getglobal("AutoBuffTooltipTextLeft"..line);
		if (toolTipText) then
			local name = toolTipText:GetText();
			if ( name ~= nil ) then	return iBuff, name; end
		end
	end
end

function AutoBuff_ShieldMod_SetCTShieldMod() -- EMERALD
	--local highestRank = AutoBuff_GetHighestSpellRank("Power Word: Shield");
	local highestRank = AutoBuff_Rank(AUTOBUFF_ABILITY_PWSHIELD);
	highestRank = tonumber(highestRank);
	AutoBuff_Debug("highestRank="..tostring(highestRank));
	local dmg;
	if (highestRank) then
		if (highestRank==1) then
			dmg = "48";
		elseif (highestRank==2) then
			dmg = "94";
		elseif (highestRank==3) then
			dmg = "166";
		elseif (highestRank==4) then
			dmg = "242";
		elseif (highestRank==5) then
			dmg = "301";
		elseif (highestRank==6) then
			dmg = "381";
		elseif (highestRank==7) then
			dmg = "484";
		elseif (highestRank==8) then
			dmg = "605";
		elseif (highestRank==9) then
			dmg = "763";
		elseif (highestRank==10) then
			dmg = "942";
		end
		if (dmg) then
			CT_ShieldMod_ShieldDamageLeft = tonumber(dmg);
			CT_ShieldFrame:Hide();
			CT_ShieldFrame:Show();
		end
	end
end

function AutoBuff_CanCast(spell, trigger, ltime)
	local translatedSpell = spell;
	if (spell=="track") then translatedSpell = string.lower(vTrack);
	elseif (spell=="aspect") then translatedSpell = string.lower(vAspect);
	elseif (spell=="seal") then translatedSpell = string.lower(vSeal);
	end
	local t = AutoBuff_Trigger(translatedSpell);
	AutoBuff_Debug("CanCast: trigger="..trigger..", translatedSpell="..translatedSpell);
	if (AutoBuff_CheckCombat(translatedSpell)) then AutoBuff_Debug("AutoBuff_CheckCombat=true"); else AutoBuff_Debug("AutoBuff_CheckCombat=false"); end
	if (AutoBuff_CheckParty(translatedSpell)) then AutoBuff_Debug("AutoBuff_CheckParty=true"); else AutoBuff_Debug("AutoBuff_CheckParty=false"); end
	if (AutoBuff_Mana(translatedSpell)) then AutoBuff_Debug("AutoBuff_Mana=true"); else AutoBuff_Debug("AutoBuff_Mana=false"); end
	if (AutoBuff_Health(translatedSpell)) then AutoBuff_Debug("AutoBuff_Health=true"); else AutoBuff_Debug("AutoBuff_Health=false"); end
	if (AutoBuff_Option(translatedSpell,'d')) then AutoBuff_Debug("Enabled=false"); else AutoBuff_Debug("Enabled=true"); end
	--if () then AutoBuff_Debug(""); else AutoBuff_Debug(""); end
	--AutoBuff_Debug("");

	if (translatedSpell == string.lower(AUTOBUFF_ABILITY_UNENDING_BREATH) or translatedSpell == string.lower(AUTOBUFF_ABILITY_WATER_BREATHING)) then
		local ltimer = time();
		if (AutoBuff_Data[vC]["water"]) then
			if (vBreath > ltimer) or vBreath == 0 then
				AutoBuff_Debug("  Cannot cast "..translatedSpell.." because you haven't been underwater for more than 30 seconds. Type \"/autobuff water\" to change this behavior.");
				AutoBuff_Debug("  vBreath="..vBreath..", ltimer="..ltimer);
				return nil;
			end
		end
	end
	
	if ((trigger == 0) or (t[trigger] == 1)) and
	(not AutoBuff_Option(translatedSpell,'d')) and
	(AutoBuff_CheckCombat(translatedSpell)) and
	(AutoBuff_CheckParty(translatedSpell)) and
	((not ltime) or ((ltime ~= -1) and (AutoBuff_Rebuff(translatedSpell, ltime)))) and
	(((spell == "track") or (spell == "aspect")) or
	(AutoBuff_Mana(translatedSpell)) and
	(AutoBuff_Health(translatedSpell))) then
		local spell_texture = GetSpellTexture(AutoBuff_Ability(translatedSpell), BOOKTYPE_SPELL);
		if (spell=="track") then return 1; end
		if (vClass == string.lower(AUTOBUFF_CLASS_WARLOCK)) then
			if (spell == string.lower(AUTOBUFF_ABILITY_SOULLINK)) then
				if (UnitHealth("pet") > 1) then -- Only cast Soul Link if the demon is out
					-- Scan debuffs, don't cast if your pet is Banished or Enslaved
					local i = 1;
					while (UnitDebuff("pet", i)) do
						if (UnitDebuff("pet", i)==cPre..cEnslave or UnitDebuff("pet", i)==cPre..cBanish) then
							return nil;
						end
						i = i + 1;
					end
					return 1;
				end
			elseif (spell == string.lower(AUTOBUFF_ABILITY_DARK_PACT)) then
				if (UnitMana("pet") > 1) then -- Only Dark Pact if demon is out and has mana
					if ((UnitManaMax("player")-UnitMana("player")) >= 150) then -- Only if needed
						return 1;
					else
						return nil;
					end
				else
					return nil;
				end
			else
				return 1;
			end
			
		elseif (vClass == string.lower(AUTOBUFF_CLASS_ROGUE)) then
			-- Don't cast any spells when rogue is stealthed
			local i = 1;
			while (UnitBuff("player", i)) do
				if (UnitBuff("player", i)==cPre..cStealth) then
					AutoBuff_Debug("ROGUE: Can't cast spells in Stealth Mode!");
					return nil;
				end
				i = i + 1;
			end
			return 1;
			
		else
			return 1;
		end
		
	end
end

function AutoBuff_Check(trigger) -- EMERALD: TriggerFire
	-- Check for frames that, while visible, should block spellcasting
	if (CastingBarFrame and CastingBarFrame:IsVisible()) then return; end
	if (eCastingBar and eCastingBar:IsVisible()) then return; end
	if (Perl_ArcaneBarFrame and Perl_ArcaneBarFrame:IsVisible()) then return; end
	if (LootFrame and LootFrame:IsVisible()) then AutoBuff_Debug("Can't cast: LootFrame is visible!"); return; end
	
	local ltime = time();
	if (vTime > ltime) or (vSit > ltime) then return; end
	
	if (AutoBuff_Data[vC]['e'] == 1) and
	 (not UnitOnTaxi("player")) and
	 (not CursorHasItem()) and
	 (not CursorHasSpell()) and
	 (not SpellIsTargeting()) and
	 (not UnitIsDeadOrGhost("player")) then
		AutoBuff_Debug("----------------------------");
		AutoBuff_Debug("### Beginning buff-check ###");
		local buffline,mounted,poly,buffIndex,buffName,buffConc,i,done,iName,xName,iiName,xxName,id;
		local polyShadowform = nil;
		local polyMoon = nil;
		local polyCat = nil;
		local polyBlessing = nil;
		local iBuff = {};
		
		for i=0,23 do -- Cycle currently active buffs
			buffIndex, buffName, buffConc = AutoBuff_BuffName(i, "HELPFUL|HARMFUL");
			if (buffName) then
			
				-- This is done outside of the Class Poly loop because we don't store Greater Blessings in Class Poly's
				if (vClass == string.lower(AUTOBUFF_CLASS_PALADIN)) then
					if (cBlessingPoly[buffName]) then -- A greater blessing was found on the player
						polyBlessing = string.lower(buffName);
					end
				end
				
				buffName = string.lower(buffName);
				
				for iName, xName in cPolyList[vClass] do -- Cycle list of Class Poly's
				
					-- Don't POLY for AUTOBUFF_POLY_PRIEST_SPIRITTAP if mana is currently full
					if (vClass == string.lower(AUTOBUFF_CLASS_PRIEST)) then
						if (buffName == string.lower(AUTOBUFF_POLY_PRIEST_SPIRITTAP) and AutoBuff_Data[vC]["tap"]) then
							AutoBuff_Debug("  Spirit Tap is currently active...");
							if (UnitMana("player")==UnitManaMax("player")) then
								-- Mana is full, we can go ahead and cast even though Spirit Tap is active.
								AutoBuff_Debug("  Player's Mana is full, ignoring Spirit Tap.");
							else
								AutoBuff_Debug("  Player's Mana is regenerating -- blocking other spells from firing.");
								poly = string.lower(iName);
								do break end;
							end
						end
						-- Prevent Holy spells from firing while in Shadowform
						if (buffName == string.lower(AUTOBUFF_POLY_PRIEST_SHADOWFORM)) then
							polyShadowform = true;
						end
					
					elseif (vClass == string.lower(AUTOBUFF_CLASS_WARLOCK)) then
						if (buffName == string.lower(AUTOBUFF_POLY_WARLOCK_SOULSIPHON) and AutoBuff_Data[vC]["tap"]) then
							AutoBuff_Debug("  Soul Siphon is currently active...");
							if (UnitMana("player")==UnitManaMax("player")) then
								-- Mana is full, we can go ahead and cast even though Soul Siphon is active.
								AutoBuff_Debug("  Player's Mana is full, ignoring Soul Siphon.");
							else
								AutoBuff_Debug("  Player's Mana is regenerating -- blocking other spells from firing.");
								poly = string.lower(iName);
								do break end;
							end
						end
						
					elseif (vClass == string.lower(AUTOBUFF_CLASS_DRUID)) then
						-- Don't POLY for AUTOBUFF_POLY_DRUID_CAT if casting Track Humanoids
						if (buffName == string.lower(AUTOBUFF_POLY_DRUID_CAT)) then
							polyCat = true;
						-- Don't allow Mark of the Wild if you're a Moonkin
						elseif (buffName == string.lower(AUTOBUFF_POLY_DRUID_MOONKIN)) then
							polyMoon = true;
						end
					end
					
					if (buffName == string.lower(iName)) then
						if (string.lower(iName)~=string.lower(AUTOBUFF_POLY_DRUID_CAT) and string.lower(iName)~=string.lower(AUTOBUFF_POLY_DRUID_MOONKIN) and string.lower(iName)~=string.lower(AUTOBUFF_POLY_PRIEST_SHADOWFORM) and string.lower(iName)~=string.lower(AUTOBUFF_POLY_PRIEST_SPIRITTAP) and string.lower(iName)~=string.lower(AUTOBUFF_POLY_WARLOCK_SOULSIPHON)) then
							-- Only break if this poly isn't polyCat, polyMoon, or polyShadowform (nor SpiritTap)
							AutoBuff_Debug("  STOP -- Poly found: "..iName);
							poly = string.lower(iName);
							do break end;
						end
					end
					
					-- PRIEST LOGIC:
					-- SpiritTap+FullMana = GO
					-- SpiritTap+FullMana+Shadowform = GO
					-- SpiritTap+LowMana = STOP
					-- SpiritTap+LowMana+Shadowmeld(ALL_POLY) = STOP
					
				end -- for iName, xName in cPolyList[vClass] do
				
				for iName, xName in cPolyList["all"] do -- Cycle list of All Poly's (invis, shadowmeld)
					if (buffName == string.lower(iName)) then
						AutoBuff_Debug("  STOP -- Poly found: "..iName);
						poly = string.lower(iName);
						do break end;
					end
				end
				
				if (buffConc == 1) then
					iBuff[buffName] = -1;
				else
					iBuff[buffName] = GetPlayerBuffTimeLeft(buffIndex);
				end
				
				-- MOUNT CHECK
				_, buffline = AutoBuff_BuffLine(i, 2, "HELPFUL|HARMFUL");
				if (buffline) then
					buffline = string.lower(buffline);
					if ((buffline == string.lower(AUTOBUFF_MOUNT_60)) or (buffline == string.lower(AUTOBUFF_MOUNT_100)) or (buffline == string.lower(AUTOBUFF_MOUNT_60_2)) or (buffline == string.lower(AUTOBUFF_MOUNT_100_2)) or (buffline == string.lower(AUTOBUFF_MOUNT_60_3)) or (buffline == string.lower(AUTOBUFF_MOUNT_100_3))) then
						mounted = true;
					end
				end -- if (buffline) then
				
			end -- if (buffName) then
		end -- for i=0,23 do
		
		for i=1,10 do buffName = UnitDebuff("player",i);
			if (buffName and buffName == cPre..cSheep) then
				poly = "Sheep";
			end
		end
		
		if (poly == nil) then
		
			if (not mounted or (mounted and vClass==string.lower(AUTOBUFF_CLASS_PALADIN))) then
				for iName, xName in vSpellList do
					local several = nil;
					local polyCatCast = nil;
					local polyMoonCast = nil;
					local polyRogue = nil;
					local polyPaladin = nil;
					local polyRejuv = nil;
					if (AutoBuff_CanCast(iName, trigger, iBuff[iName])) then
						for iiName, xxName in vSpellList[iName] do
							if (iiName ~= "type") and (iBuff[xxName]) then several = true; break; end
						end
						if (not several) then
							id = AutoBuff_Ability(iName);
							if (AutoBuff_Cooldown(id) == 0) then
							
								if (vClass==string.lower(AUTOBUFF_CLASS_PRIEST) and polyShadowform) then
									-- put Holy spells in if statements, below, to prevent casting those spells in Shadow form
									if (iName == string.lower(AUTOBUFF_ABILITY_FEARWARD) or iName == string.lower(AUTOBUFF_ABILITY_RENEW)) then
										AutoBuff_Debug("  Cannot cast "..iName.." - Shadowform is active.");
									else
										polyShadowform = nil;
									end
								
								elseif (vClass==string.lower(AUTOBUFF_CLASS_ROGUE)) then
									if (iName == string.lower(AUTOBUFF_ABILITY_FEINT) or iName == string.lower(AUTOBUFF_ABILITY_BLADE_FLURRY)) then
										if (UnitAffectingCombat("player") and UnitExists("target") and UnitReaction("target","player") <= 4 and CheckInteractDistance("target",1)) then
											-- Only if (1) in combat, (2) has target, (3) target is attackable, (4) 5 yards or closer.
											polyRogue = nil;
										else
											polyRogue = true;
											AutoBuff_Debug("  Cannot cast "..iName.." - Combat conditions are not correct (in combat, target attackable, 5 yards or less)");
										end
									end
								
								elseif (vClass==string.lower(AUTOBUFF_CLASS_DRUID) and polyMoon and iName ~= string.lower(AUTOBUFF_ABILITY_TRACK_HUMANOIDS) and iName ~= string.lower(AUTOBUFF_ABILITY_COWER)) then
									-- put Balance spells in if statements, below, to prevent casting those spells in Moonkin form
									if (iName == string.lower(AUTOBUFF_ABILITY_MOTW) or iName == string.lower(AUTOBUFF_ABILITY_REJUV)) then
										AutoBuff_Debug("  Cannot cast "..iName.." - Moonkin form is active.");
										polyMoonCast = true;
									else
										polyMoonCast = nil;
									end
								
								elseif (vClass==string.lower(AUTOBUFF_CLASS_DRUID)) then
									if (iName == string.lower(AUTOBUFF_ABILITY_TRACK_HUMANOIDS) or iName == string.lower(AUTOBUFF_ABILITY_COWER)) then
										if (polyCat) then
											if (iName == string.lower(AUTOBUFF_ABILITY_TRACK_HUMANOIDS)) then
												if (GetTrackingTexture()) then
													local iconTrack = GetTrackingTexture();
													AutoBuff_Debug("  Track already enabled: "..iconTrack);
													if (iconTrack==cPre..cTracking) then
														polyCatCast = true; -- don't recast if it's already on!
													end
												else
													polyCatCast = nil; --polyCat = nil; -- Can cast, clear polyCatCast.
												end
											elseif (iName == string.lower(AUTOBUFF_ABILITY_COWER)) then
												if (UnitAffectingCombat("player") and UnitExists("target") and UnitReaction("target","player") <= 4 and CheckInteractDistance("target",1)) then
													-- Only if (1) in combat, (2) has target, (3) target is attackable, (4) 5 yards or closer.
													polyCatCast = nil; -- Can cast, clear polyCatCast.
												else
													AutoBuff_Debug("  Cannot cast "..iName.." - Combat conditions are not correct (in combat, target attackable, 5 yards or less)");
													polyCatCast = true;
												end
											end
										elseif (polyMoon) then
											AutoBuff_Debug("  Cannot cast "..iName.." - You're not in cat form.");
											polyCatCast = true;
										else -- not polyCat
											AutoBuff_Debug("  Cannot cast "..iName.." - You're not in cat form.");
											polyCatCast = true;
										end
									else
										if (polyCat) then
											AutoBuff_Debug("  Cannot cast "..iName.." - Only Track Humanoids or Cower can be cast in cat form.");
											polyCatCast = true;
										end
									end
									
								elseif (vClass == string.lower(AUTOBUFF_CLASS_PALADIN)) then
									if (mounted) then
										if (not AutoBuff_IsAura(iName)) then
											polyPaladin = true; -- don't cast anything other than an Aura while mounted
										end
									elseif (polyBlessing and polyBlessing==iName) then
										-- Lesser spell (same effect as the Greater Blessing on the player currently) attempting to be cast
										AutoBuff_Debug("  Cannot cast "..iName.." - A Greater Blessing with the same effect is already active.");
										polyPaladin = true;
									end

								--elseif (vClass==string.lower(AUTOBUFF_CLASS_)) then
								end
								
								if (iName==string.lower(AUTOBUFF_ABILITY_REJUV) or iName==string.lower(AUTOBUFF_ABILITY_RENEW)) then
									local ltime = time();
									if (vRejuv > ltime) then polyRejuv = true; end
								end
								
								-- CASTING ROUTINE
								if (not polyShadowform and not polyCatCast and not polyMoonCast and not polyRogue and not polyPaladin and not polyRejuv) then
									AutoBuff_Debug("  Casting Buff: "..iName);
									done = true;
									AutoBuff_UseAbility(iName,xName.type);
									AutoBuff_Debug("  iName="..iName);
									if (iName==string.lower(AUTOBUFF_ABILITY_PWSHIELD)) then
										-- Set CT_ShieldMod's initial damage ounter
										if (CT_ShieldFrame) then
											AutoBuff_ShieldMod_SetCTShieldMod();
											AutoBuff_Debug("Setting CT_Shield");
										end
									end
									if (iName==string.lower(AUTOBUFF_ABILITY_REJUV) or iName==string.lower(AUTOBUFF_ABILITY_RENEW)) then
										-- Set vRejuv, which allows the spell time to work before it can fire again
										vRejuv = time() + 15; -- Rejuv is 12 sec, but Renew is 15 (and Improved Rejuv Duration is 15), so I'm going with the higher common number.
									end
									do break end;
								end
								
							end
						end
					end
				end
				if (not done) then
					local m,o,_,_,_,_ = GetWeaponEnchantInfo();
					if (o) then o = floor(o/1000); end
					if (vWeapon) and AutoBuff_CanCast(vWeapon, trigger, o) then
						--local mhHasItem,_,_=GameTooltip:SetInventoryItem("player",16);
						--local ohHasItem,_,_=GameTooltip:SetInventoryItem("player",17);
						--if (mhHasItem or ohHasItem) then
							AutoBuff_Debug("  Weapon Buff: "..vWeapon);
							AutoBuff_UseAbility(vWeapon,'self');
						--else
							--AutoBuff_Debug("  Weapon Buff cannot be cast. You have no melee weapon equipped.");
						--end
					end
					local a, b, c, d, e;
					if (vWeapon) then a = vWeapon; else a = "false"; end
					if (m) then
						b = m;
						if (AutoBuff_Rebuff(vWeapon, floor(o/1000))) then c = "true"; else c = "false"; end
					else b = "false"; c = "none";
					end
					if (AutoBuff_Mana(vWeapon)) then d = "true"; else d = "false"; end
					if (AutoBuff_Health(vWeapon)) then e = "true"; else e = "false"; end
					AutoBuff_Debug("  Weapon, "..a.."; m, "..b.."; rebuff, "..c.."; mana, "..d.."; health, "..e);
				end
			end		
		end

		if (vSeal and not mounted and not poly) then
			AutoBuff_Debug("Check Seal Setting...");
			local buffline,mounted,poly,buffIndex,buffName,buffConc,i,done,iName,xName,iiName,xxName,id; local iBuff = {};
			local hasSeal = false;
			for i=0,23 do
				buffIndex, buffName, buffConc = AutoBuff_BuffName(i, "HELPFUL|HARMFUL");
				if (buffName) then
					if (string.find(buffName,AUTOBUFF_SEAL)) then hasSeal = true; break; end
				end
			end
			if (not hasSeal) then
				if (AutoBuff_CanCast("seal", trigger, nil)) then
					AutoBuff_UseAbility(vSeal,'self');
					AutoBuff_Debug("  Seal not found. Casting "..vSeal);
				else
					AutoBuff_Debug("  Seal not found, but I can't cast right now.");
				end
			else
				AutoBuff_Debug("  Seal found. Doing nothing.");
			end
		end

		if (vAspect and not mounted and not poly) then
			AutoBuff_Debug("Check Aspect Setting...");
			local buffline,mounted,poly,buffIndex,buffName,buffConc,i,done,iName,xName,iiName,xxName,id; local iBuff = {};
			local hasAspect = false;
			for i=0,23 do
				buffIndex, buffName, buffConc = AutoBuff_BuffName(i, "HELPFUL|HARMFUL");
				if (buffName) then
					--buffName = string.lower(buffName);
					--buffCompare = string.lower(AUTOBUFF_ASPECT_OF);
					--AutoBuff_Debug("  Comparing "..buffName.." to "..vAspect);
					if (string.find(buffName,AUTOBUFF_ASPECT_OF)) then hasAspect = true; break; end
				end
			end
			if (not hasAspect) then
				if (AutoBuff_CanCast("aspect", trigger, nil)) then
					AutoBuff_UseAbility(vAspect,'self');
					AutoBuff_Debug("  Aspect not found. Casting "..vAspect);
				else
					AutoBuff_Debug("  Aspect not found, but I can't cast right now.");
				end
			else
				AutoBuff_Debug("  Aspect found. Doing nothing.");
			end
		end

		if (vClass == string.lower(AUTOBUFF_CLASS_DRUID) and polyCat and not AutoBuff_Option(string.lower(AUTOBUFF_ABILITY_TRACK_HUMANOIDS),'d')) then -- Druid + Cat + Track Humanoids (enabled)
			done = true; -- Do NOT check normal tracking if Track Humanoids is being fired on the Cat form.
		end
		
		if ((not done or vClass == string.lower(AUTOBUFF_CLASS_ROGUE))) then
			AutoBuff_Debug("Check Track Setting...");
			if (vTrack) then
				AutoBuff_Debug("  Found: "..vTrack);
				if (not GetTrackingTexture()) then
					if (AutoBuff_CanCast("track", trigger, nil)) then
						AutoBuff_Debug("  Tracking Ability: "..vTrack);
						AutoBuff_UseAbility(vTrack,'self');
					else
						AutoBuff_Debug("  Track failed 'CanCast'.");
					end
				else
					AutoBuff_Debug("  Track already enabled: "..GetTrackingTexture());
				end
			end
		else AutoBuff_Debug("  Already done, not checking track.");
		end
		if (done) and (vTime < ltime) then vTime = ltime; end
		
		if (vClass == string.lower(AUTOBUFF_CLASS_WARLOCK)) and (vCombat == nil) and (AutoBuff_Data[vC]['s']) and not poly then
			for iName, xName in cWarlockPet do
				local petspell = AutoBuff_CheckPetAbility(iName);
				local petbuff;
				if (petspell) then
					AutoBuff_Debug("  Petspell button: "..petspell);
					for i=1,10 do if (UnitBuff("pet",i) == cPre..xName) then petbuff = true; end end
					if (not petbuff) and AutoBuff_Mana_Pet() then CastPetAction(petspell); end
				end
			end
		end
		
		AutoBuff_Debug("### Finished buff-check ###");
	end
end

function AutoBuff_CheckCombat(spell)
	local s = string.lower(spell);
	local x = AutoBuff_Option(s,'c');
	if (not x) then x = AutoBuff_Option('d','c'); end
	if (UnitAffectingCombat("player")) then -- Should prevent most false positives
		vCombat = true;
	else
		vCombat = nil;
	end
	if (not x) or (x == 3) then return true;
	elseif (vCombat) and (x == 1) then return true;
	elseif (not vCombat) and (x == 2) then return true; end
end

function AutoBuff_CheckParty(spell)
	local s = string.lower(spell);
	local x = AutoBuff_Option(s,'p');
	local p = nil;
	if (GetNumPartyMembers() > 0) or (GetNumRaidMembers() > 0) then p = 1; end
	if (not x) then x = AutoBuff_Option('d','p'); end
	if (not x) or (x == 3) then return true;
	elseif (p) and (x == 1) then return true;
	elseif (not p) and (x == 2) then return true; end
end

function AutoBuff_Rebuff(name, ltime)
	if (ltime) then ltime = floor(ltime); end
	local r = AutoBuff_Option(name, 'r');
	if (not r) then r = AutoBuff_Option('d', 'r'); end
	local t = ltime;
	if (not t) then t = "nil"; end
	if (not name) then name = "[default]"; end
	
	if (string.lower(name) == string.lower(AUTOBUFF_ABILITY_INNER_FIRE)) and (AutoBuff_Data[vC]["inner"]) then -- We want to fire this at XX/20 charges left, instead of removed totally
		local i = 1;
		while (UnitBuff("player", i)) do
			buff, numbuff = UnitBuff("player", i);
			-- Already buffed with Inner Fire
			if (buff==cIconInnerFire) then
				AutoBuff_Debug("Found InnerFire with "..numbuff.." out of "..AutoBuff_Data[vC]["innercharges"].." charges left.");
			end
			if (buff==cIconInnerFire) and (numbuff <= AutoBuff_Data[vC]["innercharges"]) then
				return true; -- Recast, because we're at or under XX charges
			end
			i = i + 1;
		end
	end
	
	AutoBuff_Debug("Rebuff, "..name.." r:"..r.." t:"..t);
	if (not ltime) or (r > ltime) then
		AutoBuff_Debug("Rebuff should fire!");
		return true;
	end
end

function AutoBuff_Mana(name)
	local c = (UnitMana("player")/UnitManaMax("player"))*100;
	AutoBuff_Debug("Player Mana is at "..c.."%.");
	local n = AutoBuff_Option(name,'m');
	if (n == nil) then n = AutoBuff_Option('d','m'); end
	if (n > 0) and (c > n) then return true;
	elseif (n < 0) and (c < (n*-1)) then return true; end
end

function AutoBuff_Mana_Pet()
	local c = (UnitMana("pet")/UnitManaMax("pet"))*100;
	local n = 35;
	if (c > n) then return true; end
end

function AutoBuff_CheckPetAbility(spellName)
	local name, i;
	for i=1,10 do
		name, _, _, _, _, _, _ = GetPetActionInfo(i)
		if (name) and (string.lower(name) == string.lower(spellName)) then return i; end
	end
end

function AutoBuff_Health(name)
	local c = (UnitHealth("player")/UnitHealthMax("player"))*100;
	local n = AutoBuff_Option(name,'h');
	if (n == nil) then n = AutoBuff_Option('d','h'); end
	if (n > 0) and (c > n) then return true;
	elseif (n < 0) and (c < (n*-1)) then return true; end
end

function AutoBuff_GetHighestSpellRank(spell)
	if (spell) then spell = string.lower(spell);
	else return; end
	local i=1
	local id = nil;
	while true do
   		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL);
   		if (not spellName) then break; end
		if (string.lower(spellName) == spell) then id = spellRank; end
   		i = i+1;
	end
	
	local _,_,realRank = string.find(id, "([%d]+)$");
	
	if (GetLocale() == "koKR") then -- Korean ranks are reversed.
		local _,_,realRank = string.find(id, "(%d+%.?%d*)");
	end
	return tonumber(realRank);
end

function AutoBuff_Cooldown(id)
	if (id) then return GetSpellCooldown(id, BOOKTYPE_SPELL); end
end

function AutoBuff_UseAbility(spell, type)
	--local testScaled = "";
	--if (AutoBuff_Data[vC]["scaled"]) then testScaled = "true"; else testScaled = "false"; end
	--AutoBuff_Debug("spell: "..spell.." life tap: "..AUTOBUFF_ABILITY_LIFE_TAP.." BonusScanner: "..IsAddOnLoaded("BonusScanner").." scaled? "..testScaled);
	if (spell==string.lower(AUTOBUFF_ABILITY_LIFE_TAP)) and IsAddOnLoaded("BonusScanner") and (AutoBuff_Data[vC]["scaled"]) then
		AutoBuff_ScaledLifeTap_CastLifeTap();
		AutoBuff_Debug("Going into Scaled Life Tap routine.");
	else
		local i=1; local name, d;
		local id = AutoBuff_Ability(spell);
		if id then
			if (AutoBuff_Cooldown(id) == 0) then
				if (type == "friendly") and (UnitIsFriend("player", "target")) and (not UnitIsUnit("player","target")) then
					name = UnitName("target");
					ClearTarget();
				end
				CastSpell(id,BOOKTYPE_SPELL);
				if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
					SpellTargetUnit("player");
				end
				if (name) then TargetByName(name); end
			end
		end
	end
end

function AutoBuff_Ability(spell, rank)
	if (spell) then spell = string.lower(spell);
	else return; end
	local o = AutoBuff_Option(spell, 'k');
	local i=1;
	local id = nil;
	while true do
   		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL);
   		if (not spellName) then break; end
		if (string.lower(spellName) == spell) then
			id = i;
			if (o) then
				local _,_,realRank = string.find(spellRank, "([%d]+)$");
				if (tonumber(realRank) == o) then break; end
			end
		end
   		i = i+1;
	end
	if (id) then local a,b = "", ""; a,b = GetSpellName(id, BOOKTYPE_SPELL); AutoBuff_Debug("Got Spell ID for, "..a.." "..b); end
	return id;
end

function AutoBuff_Rank(spell)
	AutoBuff_Debug("AutoBuff_Rank: entering function");
	if (spell) then spell = string.lower(spell);
	else return; end
	local o = AutoBuff_Option(spell, 'k');
	local i=1;
	while true do
   		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL);
   		if (not spellName) then break; end
		if (string.lower(spellName) == spell) then
			if (o) then
				local _,_,realRank = string.find(spellRank, "([%d]+)$");
				if (tonumber(realRank) == o) then break; end
			end
		end
   		i = i+1;
	end
	if (o) then return o;
	elseif (realRank) then return realRank;
	else
		return AutoBuff_GetHighestSpellRank(spell);
	end
end

function AutoBuff_Debug(text) 						-- Prints debug information only if switched on
	if (AutoBuff_Data[vC]['d'] == 1) then DEFAULT_CHAT_FRAME:AddMessage("|cff5e9ae4AutoBuff"..FONT_COLOR_CODE_CLOSE.."/".."|cffffa0a0Debug"..FONT_COLOR_CODE_CLOSE..": "..text); end
end

function AutoBuff_TableIndex(tbl, index)			-- This and the next function are used to get the table index name
	bIndex = index;									-- by giving the index as an integer.
	bValue = 0;
	return table.foreach(tbl, AutoBuff_foreach);
end

function AutoBuff_foreach(index, value)
	if (bValue == bIndex) then return index; end
	bValue = bValue +1;
end

function AutoBuff_TableConfig()
	AutoBuff_setn(cSpellList);
	AutoBuff_setn(cTrackList);
	AutoBuff_setn(cWeaponList);
	AutoBuff_setn(cAspectList);
	AutoBuff_setn(cSealList);
end

function AutoBuff_setn(tbl)
	bValue = 0;
	table.foreach(tbl, AutoBuff_setn_foreach);
	table.setn(tbl, bValue);
end

function AutoBuff_setn_foreach(index, value)
	bValue = bValue +1;
end

function AutoBuff_Print(text)
	if (text) then DEFAULT_CHAT_FRAME:AddMessage("|cff5e9ae4AutoBuff"..FONT_COLOR_CODE_CLOSE..": "..text); end
end

function AutoBuff_Seperator()
	DEFAULT_CHAT_FRAME:AddMessage("-");
end

function AutoBuff_WHEELU()	-- Hook for scrollwheel-up
	AutoBuff_Check(1);
	AutoBuff_WHEELUx();
end
function AutoBuff_WHEELD()	-- Hook for scrollwheel-down
	AutoBuff_Check(2);
	AutoBuff_WHEELDx();
end
function AutoBuff_TARGET()	-- Hook for target-switching
	AutoBuff_Check(3);
end

function AutoBuff_JMP()
	AutoBuff_Check(4);
	AutoBuff_JMPx();
end
function AutoBuff_MFS()							-- These are the hook functions for movement
	vSit = 0;
	AutoBuff_Check(1);
	AutoBuff_MFSx();
end
function AutoBuff_MBS()
	vSit = 0;
	AutoBuff_Check(1);
	AutoBuff_MBSx();
end
function AutoBuff_TLS()
	vSit = 0;
	AutoBuff_Check(3);
	AutoBuff_TLSx();
end
function AutoBuff_TRS()
	vSit = 0;
	AutoBuff_Check(3);
	AutoBuff_TRSx();
end
function AutoBuff_SLS()
	vSit = 0;
	AutoBuff_Check(2);
	AutoBuff_SLSx();
end
function AutoBuff_SRS()
	vSit = 0;
	AutoBuff_Check(2);
	AutoBuff_SRSx();
end
function AutoBuff_MFF()
	AutoBuff_Check(1);
	AutoBuff_MFFx();
end
function AutoBuff_MBF()
	AutoBuff_Check(1);
	AutoBuff_MBFx();
end
function AutoBuff_TLF()
	AutoBuff_Check(3);
	AutoBuff_TLFx();
end
function AutoBuff_TRF()
	AutoBuff_Check(3);
	AutoBuff_TRFx();
end
function AutoBuff_SLF()
	AutoBuff_Check(2);
	AutoBuff_SLFx();
end
function AutoBuff_SRF()
	AutoBuff_Check(2);
	AutoBuff_SRFx();
end
function AutoBuff_TAR()
	AutoBuff_Check(1);
	AutoBuff_TARx();
end
function AutoBuff_TAS(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
	AutoBuff_Check(6);
	AutoBuff_TASx(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
end
function AutoBuff_TAF(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
	AutoBuff_Check(6);
	AutoBuff_TAFx(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
end
function AutoBuff_CMS(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
	AutoBuff_Check(5);
	AutoBuff_CMSx(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
end
function AutoBuff_CMF(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
	AutoBuff_Check(5);
	AutoBuff_CMFx(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
end

function AutoBuff_Option(n, o, z, s)
	if (s == nil) then s = ""; end
	if (type(n) == "string") and (strlen(n) < 1) then n = nil; end
	local a,b,c = "|cffffa0a0nil","|cffa0ffa0nil","|cffa0a0ffnil";
	if (n) then a = "|cffffa0a0"..n; end
	if (o) then b = "|cffa0ffa0"..o; end
	if (z) then c = "|cffa0a0ff"..z; end
--	AutoBuff_Debug("Option -> "..a.." "..b.." "..c);
	if (not o) then return; end
	if (not n) then n = 'd'; end
	if (not vSpellList[n]) and (not vWeaponList[n]) and (not vTrackList[n]) and (not vAspectList[n]) and (not vSealList[n]) and (n ~= 'd') then return; end
	if (z == nil) then
		if (AutoBuff_Data[vC]['x'][n] ~= nil) then
				local r = AutoBuff_Data[vC]['x'][n][o];
				if (r ~= nil) then
					return r;
				end
			end
	else
		if (z == "default") then z = nil; end
		if (AutoBuff_Data[vC]['x'][n] == nil) then AutoBuff_Data[vC]['x'][n] = {}; end
		AutoBuff_Data[vC]['x'][n][o] = z;
		
		-- Output
		if (s == 1) then
			if (n == 'd') then n = "default"; end
			n = "'|cffffffa0"..n..FONT_COLOR_CODE_CLOSE.."'";
			if (z == nil) then z = "default"; end
			if (o == 'm') then s = "|cff5e9ae4mana";
			elseif (o == 'h') then s = "|cffffa0a0health";
			elseif (o == 'c') then s = "|cfff0802ecombat";
			elseif (o == 'r') then s = "|cffa0a0a0rebuff";
			elseif (o == 't') then s = "|cffc0c0c0trigger";
			elseif (o == 'k') then s = "|cffffa0ffrank";
			end
			if (s ~= 1) then
				s = s..FONT_COLOR_CODE_CLOSE;
				z = "|cffa0ffa0"..z..FONT_COLOR_CODE_CLOSE;
				AutoBuff_Print(string.format(AUTOBUFF_CHANGE,s,n,z));
			elseif (o == 'd') then
				if (z == 1) then o = "|cffffa0a0"..AUTOBUFF_DISABLED;
				else o = "|cffa0ffa0"..AUTOBUFF_ENABLED; end
				o = o..FONT_COLOR_CODE_CLOSE;
				AutoBuff_Print(n..", "..o);
			end
		end
	end
	if (n ~= 'd') and (AutoBuff_Data[vC]['x'][n] ~= nil) then
		local v,k,empty = nil,nil,1;
		for v, k in AutoBuff_Data[vC]['x'][n] do empty = nil; break; end
		if (empty) then AutoBuff_Data[vC]['x'][n] = nil; end
	end
end

function AutoBuff_TrackLoad(s)
	local x = AutoBuff_Data[vC]['t'];				-- Get stored tracking ability
	local d = AutoBuff_TableIndex(vTrackList,0);
	local z;
	if (d) then d = string.lower(d); end
	if (x) then
		x = string.lower(x);
		if (x == "off") then
			z = nil;			
		elseif (vTrackList[x]) and (AutoBuff_Ability(x)) then
			z = x;
		elseif (d) then
			x = d;
			z = d;
		end
	elseif (d) then
		x = d;
		z = d;
	else
		z = nil;
		x = "off";
	end
	AutoBuff_Data[vC]['t'] = x;
	vTrack = z;
	if (z) then
		z = "'|cffa0ffa0"..z..FONT_COLOR_CODE_CLOSE.."'";
	else
		z = "'|cffffa0a0".."off"..FONT_COLOR_CODE_CLOSE.."'";
	end
	if (s == "show") then AutoBuff_Print(AUTOBUFF_CHANGE_TRACK..", "..z); end
end

function AutoBuff_AspectLoad(s)
	local x = AutoBuff_Data[vC]['a'];				-- Get stored aspect ability
	local d = AutoBuff_TableIndex(vAspectList,0);
	local z;
	if (d) then d = string.lower(d); end
	if (x) then
		x = string.lower(x);
		if (x == "off") then
			z = nil;			
		elseif (vAspectList[x]) and (AutoBuff_Ability(x)) then
			z = x;
		elseif (d) then
			x = d;
			z = d;
		end
	elseif (d) then
		x = d;
		z = d;
	else
		z = nil;
		x = "off";
	end
	AutoBuff_Data[vC]['a'] = x;
	vAspect = z;
	if (z) then
		z = "'|cffa0ffa0"..z..FONT_COLOR_CODE_CLOSE.."'";
	else
		z = "'|cffffa0a0".."off"..FONT_COLOR_CODE_CLOSE.."'";
	end
	if (s == "show") then AutoBuff_Print(AUTOBUFF_CHANGE_ASPECT..", "..z); end
end

function AutoBuff_SealLoad(s)
	local x = AutoBuff_Data[vC]["seal"];				-- Get stored seal ability
	local d = AutoBuff_TableIndex(vSealList,0);
	local z;
	if (d) then d = string.lower(d); end
	if (x) then
		x = string.lower(x);
		if (x == "off") then
			z = nil;			
		elseif (vSealList[x]) and (AutoBuff_Ability(x)) then
			z = x;
		elseif (d) then
			x = d;
			z = d;
		end
	elseif (d) then
		x = d;
		z = d;
	else
		z = nil;
		x = "off";
	end
	AutoBuff_Data[vC]["seal"] = x;
	vSeal = z;
	if (z) then
		z = "'|cffa0ffa0"..z..FONT_COLOR_CODE_CLOSE.."'";
	else
		z = "'|cffffa0a0".."off"..FONT_COLOR_CODE_CLOSE.."'";
	end
	if (s == "show") then AutoBuff_Print(AUTOBUFF_CHANGE_SEAL..", "..z); end
end

function AutoBuff_WeaponLoad(s)
	local x = AutoBuff_Data[vC]['w'];				-- Get stored weapon ability
	local d = AutoBuff_TableIndex(vWeaponList,0);
	local z;
	if (d) then d = string.lower(d); end
	if (x) then
		x = string.lower(x);
		if (x == "off") then
			z = nil;
		elseif (vWeaponList[x]) and (AutoBuff_Ability(x)) then
			z = x;
		elseif (d) then
			z = d;
			x = d;
		end
	elseif (d) then
		z = d;
		x = d;
	else
		z = nil;
		x = "off";
	end
	AutoBuff_Data[vC]['w'] = x;
	vWeapon = z;
	if (z) then
		z = "'|cffa0ffa0"..z..FONT_COLOR_CODE_CLOSE.."'";
	else
		z = "'|cffffa0a0".."off"..FONT_COLOR_CODE_CLOSE.."'";
	end
	if (s == "show") then AutoBuff_Print(AUTOBUFF_CHANGE_WEAPON..", "..z); end
end

function AutoBuff_LoadDefaults()
	if (not AutoBuff_Data) then AutoBuff_Data = { }; end
	if (AutoBuff_Data[vC] == nil) then AutoBuff_Data[vC] = { }; end
	if (AutoBuff_Data[vC]['version']) then AutoBuff_Data = { [vC] = {} }; end
	table.foreach(cDefault, AutoBuff_CheckDefaults);
	if (AutoBuff_Data[vC]['x'] == nil) then AutoBuff_Data[vC]['x'] = {}; end
	if (AutoBuff_Data[vC]['x']['d'] == nil) then AutoBuff_Data[vC]['x']['d'] = {}; end
	table.foreach(cDefault['x']['d'], AutoBuff_CheckDefaults_Ability);
	if (AutoBuff_Data[vC]['v'] ~= cDefault['v']) then AutoBuff_Upgrade(AutoBuff_Data[vC]['v']); end
end

function AutoBuff_Upgrade(ver)
	local c = cDefault['v']
	--if (ver < 31) then
		--AutoBuff_Data[vC]['h'] = cDefault['h'];
	--end
	AutoBuff_Data[vC]['v'] = c;
end

function AutoBuff_CheckSpellList()
	local iName, xName;
	for iName, xName in AutoBuff_Data[vC]['x'] do
		if (iName ~= "d") and (not vSpellList[iName]) and (not vWeaponList[iName]) and (not vTrackList[iName]) and (not vAspectList[iName]) and (not vSealList[iName]) then AutoBuff_Data[vC]['x'][iName] = nil; end
	end
end

function AutoBuff_CheckDefaults(index, value)
	if (AutoBuff_Data[vC][index] == nil) then AutoBuff_Data[vC][index] = cDefault[index]; end
end

function AutoBuff_CheckDefaults_Ability(index, value)
	if (AutoBuff_Data[vC]['x']['d'][index] == nil) then AutoBuff_Data[vC]['x']['d'][index] = cDefault['x']['d'][index]; end
end

function AutoBuff_Reload()
	AutoBuffFrame_Close();
	vSpellList = { };
	vTrackList = { };
	vWeaponList = { };
	vAspectList = { };
	vSealList = { };
	vTrack = nil;
	vWeapon = nil;
	vAspect = nil;
	vSeal = nil;
	AutoBuff_Debug("Total spells available -> "..table.getn(cSpellList));
	local iName, xName;
	for iName, xName in cSpellList do
		if (AutoBuff_Ability(iName)) then
			AutoBuff_Debug("Adding Ability -> "..iName);
			vSpellList[string.lower(iName)] = xName;
			local rank = AutoBuff_GetHighestSpellRank(iName);
			if (rank) then vSpellList[string.lower(iName)]['k'] = rank; end
		end
	end
							-- Same for tracking abilities..
	AutoBuff_Debug("Total track available -> "..table.getn(cTrackList));
	for iName, xName in cTrackList do
		if (AutoBuff_Ability(iName)) then
			AutoBuff_Debug("Adding Track -> "..iName);
			vTrackList[string.lower(iName)] = xName;
		end
	end
							-- EMERALD: aspect buffs
	AutoBuff_Debug("Total aspect available -> "..table.getn(cAspectList));
	for iName, xName in cAspectList do
		if (AutoBuff_Ability(iName)) then
			AutoBuff_Debug("Adding Aspect -> "..iName);
			vAspectList[string.lower(iName)] = xName;
		end
	end
							-- EMERALD: seal buffs
	AutoBuff_Debug("Total seals available -> "..table.getn(cSealList));
	for iName, xName in cSealList do
		if (AutoBuff_Ability(iName)) then
			AutoBuff_Debug("Adding Seal -> "..iName);
			vSealList[string.lower(iName)] = xName;
			local rank = AutoBuff_GetHighestSpellRank(iName);
			if (rank) then vSealList[string.lower(iName)]['k'] = rank; end
		end
	end
							-- And weapon buffs...
	AutoBuff_Debug("Total weaponbuff available -> "..table.getn(cWeaponList));
	for iName, xName in cWeaponList do
		if (AutoBuff_Ability(iName)) then
			AutoBuff_Debug("Adding WeaponBuff -> "..iName);
			vWeaponList[string.lower(iName)] = xName;
			local rank = AutoBuff_GetHighestSpellRank(iName);
			if (rank) then vWeaponList[string.lower(iName)] = rank; end
		end
	end
	
	AutoBuff_setn(vSpellList);
	AutoBuff_setn(vWeaponList);
	AutoBuff_setn(vTrackList);
	AutoBuff_setn(vAspectList);
	AutoBuff_setn(vSealList);
							-- Some spells overwrite others, or are higher ranked
							-- versions of another spell but with a different name.
							-- So we make sure only the best version is in the table
							
	if (vClass == string.lower(AUTOBUFF_CLASS_MAGE)) and (vSpellList[string.lower(AUTOBUFF_ABILITY_ICE_ARMOR)]) then vSpellList[string.lower(AUTOBUFF_ABILITY_FROST_ARMOR)] = nil; end
	if (vClass == string.lower(AUTOBUFF_CLASS_WARLOCK)) then
		if (vSpellList[string.lower(AUTOBUFF_ABILITY_DEMON_ARMOR)]) then vSpellList[string.lower(AUTOBUFF_ABILITY_DEMON_SKIN)] = nil; end
		if (vSpellList[string.lower(AUTOBUFF_ABILITY_DETECT_GINVIS)]) then vSpellList[string.lower(AUTOBUFF_ABILITY_DETECT_INVIS)] = nil; vSpellList[string.lower(AUTOBUFF_ABILITY_DETECT_LINVIS)] = nil;
		elseif (vSpellList[string.lower(AUTOBUFF_ABILITY_DETECT_INVIS)]) then vSpellList[string.lower(AUTOBUFF_ABILITY_DETECT_LINVIS)] = nil; end
	end
	AutoBuff_TrackLoad();				-- Checks for available Tracking Abilities
	AutoBuff_WeaponLoad();
	AutoBuff_AspectLoad();
	AutoBuff_SealLoad();
	AutoBuff_CheckSpellList();			-- Checks the disabled, mana, and combat tables for spells that this character can't use.
end

--[[ Dialog control functions ]]
function AutoBuffFrame_OnShow()
	PlaySound("igMainMenuOpen");
	AutoBuffFrameCheckButton:SetChecked(AutoBuff_Data[vC]['e']);
	if (AutoBuff_Data[vC]['e']) then
		AutoBuffFrameAbility:Show();
		AutoBuff_Populate();
	else
		AutoBuffFrameAbility:Hide();
	end
end

function AutoBuffFrame_OnHide()
	PlaySound("igMainMenuClose");
end

function AutoBuffFrame_Toggle()
		vGUI = {};
		vGUI['m'] = { [1] = "default" }; -- EMERALD: Line 2205 bug (nil on field 'm')
    AutoBuffFrame:StopMovingOrSizing();
	if (not AutoBuffFrame:IsVisible()) then
		AutoBuffFrame_Open();
	else
		AutoBuffFrame_Close();
	end
end

function AutoBuffFrame_Open()
	ShowUIPanel(AutoBuffFrame);
end

function AutoBuffFrame_Close()
	AutoBuffFrame:StopMovingOrSizing();
	HideUIPanel(AutoBuffFrame);
	
	-- myAddOns window
	if(MYADDONS_ACTIVE_OPTIONSFRAME == AutoBuffFrame) then ShowUIPanel(myAddOnsFrame); end
end

function AutoBuff_Populate()
	local i,v,k,x,r,g,b = 1,nil,nil,nil,0.4,0.4,0.4;
	for x=1,AUTOBUFF_GUI_ABILITY_TOTALROWS do
		getglobal("AutoBuffName"..x):UnlockHighlight();
	end
	vGUI['m'] = { [1] = "default" };
	AutoBuff_PopulateInsert(1, AUTOBUFF_GUI_DEFAULTABILITY, 0.6, 0.6, 1)
	if (table.getn(vSpellList) > 0) then
		i=i+1;
		AutoBuff_PopulateInsert(2, "- "..AUTOBUFF_GUI_SPELLS, 1, 1, 1);
		getglobal("AutoBuffName"..i):Disable();
		--for v, k in vSpellList do
		k = 1;
		while (k > -1) do
			v = AutoBuff_SpellList(k);
			if (not v) then break; end
			v = string.lower(v);
			if (vSpellList[v]) then
				i = i+1;
				if (AutoBuff_Option(v, 'd')) then r,g,b = 1, 0.6, 0.6; else r,g,b = 0.6, 1, 0.6; end
				AutoBuff_PopulateInsert(i, AutoBuff_CorrectName(v), r, g, b);
				vGUI['m'][i] = "spell";
			end
			k = k+1;
		end
	end
	if (table.getn(vWeaponList) > 0) then
		i = i+1;
		AutoBuff_PopulateInsert(i, "- "..AUTOBUFF_GUI_WEAPON, 1, 1, 1);
		getglobal("AutoBuffName"..i):Disable();
		for v, k in vWeaponList do
			i = i+1;
			if (v == vWeapon) then r,g,b = 0.6, 1, 0.6; else r,g,b = 1, 0.6, 0.6; end
			AutoBuff_PopulateInsert(i, AutoBuff_CorrectName(v), r, g, b);
			vGUI['m'][i] = "weapon";
		end
	end
	if (table.getn(vTrackList) > 0) then
		i = i+1;
		AutoBuff_PopulateInsert(i, "- "..AUTOBUFF_GUI_TRACK, 1, 1, 1);
		getglobal("AutoBuffName"..i):Disable();
		for v, k in vTrackList do
			i = i+1;
			if (v == vTrack) then r,g,b = 0.6, 1, 0.6; else r,g,b = 1, 0.6, 0.6; end
			AutoBuff_PopulateInsert(i, AutoBuff_CorrectName(v), r, g, b);
			vGUI['m'][i] = "track";
		end
	end
	if (table.getn(vAspectList) > 0) then
		i = i+1;
		AutoBuff_PopulateInsert(i, "- "..AUTOBUFF_GUI_ASPECT, 1, 1, 1);
		getglobal("AutoBuffName"..i):Disable();
		for v, k in vAspectList do
			i = i+1;
			if (v == vAspect) then r,g,b = 0.6, 1, 0.6; else r,g,b = 1, 0.6, 0.6; end
			AutoBuff_PopulateInsert(i, AutoBuff_CorrectName(v), r, g, b);
			vGUI['m'][i] = "aspect";
		end
	end
	if (table.getn(vSealList) > 0) then
		i = i+1;
		AutoBuff_PopulateInsert(i, "- "..AUTOBUFF_GUI_SEAL, 1, 1, 1);
		getglobal("AutoBuffName"..i):Disable();
		for v, k in vSealList do
			i = i+1;
			if (v == vSeal) then r,g,b = 0.6, 1, 0.6; else r,g,b = 1, 0.6, 0.6; end
			AutoBuff_PopulateInsert(i, AutoBuff_CorrectName(v), r, g, b);
			vGUI['m'][i] = "seal";
		end
	end
	AutoBuffFrameAbility:SetHeight(AUTOBUFF_GUI_ABILITY_OVERHEAD + (AUTOBUFF_GUI_ABILITY_INTERVAL*i));
	AutoBuffFrameOptions:Hide();
end

function AutoBuff_PopulateInsert(n, t, r, g, b)
	local itemButton = getglobal("AutoBuffName"..n);
	local itemText = getglobal("AutoBuffName"..n.."_Text");
	if (t) and (n <= AUTOBUFF_GUI_ABILITY_TOTALROWS) then
		itemText:SetText(t);
		itemText:SetTextColor(r, g, b, 1);
		itemButton:Enable();
		itemButton:Show();
	end	
end

function AutoBuffFrameCloseButton_OnClick()
	AutoBuffFrame_Close();
end

function AutoBuffFrame_ResetAbility()
	vGUI['r'] = 1;
	local x,y;

	AutoBuffFrameOptionsDefaultAbility:Hide();

	AutoBuffFrameOptionsEnable_Text:Show();
	AutoBuffFrameOptionsEnableButton:Show();
	AutoBuffFrameOptionsEnableButton:SetChecked(0);

	AutoBuffFrameOptionsDefaultTrigger_Text:Hide();
	AutoBuffFrameOptionsTrigger_Text:Hide();
	AutoBuffFrameOptionsTriggerDefaultButton:Hide();
	AutoBuffFrameOptionsTriggerDefaultButton:SetChecked(0);
	AutoBuffFrameOptionsTriggerWheelUp_Text:Hide();
	AutoBuffFrameOptionsTriggerWheelUpButton:Hide();
	AutoBuffFrameOptionsTriggerWheelUpButton:SetChecked(0);
	AutoBuffFrameOptionsTriggerWheelDown_Text:Hide();
	AutoBuffFrameOptionsTriggerWheelDownButton:Hide();
	AutoBuffFrameOptionsTriggerWheelDownButton:SetChecked(0);
	AutoBuffFrameOptionsTriggerTarget_Text:Hide();
	AutoBuffFrameOptionsTriggerTargetButton:Hide();
	AutoBuffFrameOptionsTriggerTargetButton:SetChecked(0);
	
	
	AutoBuffFrameOptionsCombat_Text:ClearAllPoints();
	--AutoBuffFrameOptionsCombat_Text:SetPoint("TOPLEFT", "AutoBuffFrameOptionsTrigger_Text", "BOTTOMLEFT", 0, -110)
	AutoBuffFrameOptionsCombat_Text:SetPoint("TOPLEFT", "AutoBuffFrameOptionsTrigger_Text", "BOTTOMLEFT", 0, -55)
	AutoBuffFrameOptionsCombatDefaultButton:Hide();
	AutoBuffFrameOptionsCombatDefaultButton:SetChecked(0);
	AutoBuffFrameOptionsCombat_Text:Hide();
	AutoBuffFrameOptionsDefaultCombat_Text:Hide();
	AutoBuffFrameOptionsCombatIn_Text:Hide();
	AutoBuffFrameOptionsCombatInButton:Hide();
	AutoBuffFrameOptionsCombatInButton:SetChecked(0);
	AutoBuffFrameOptionsCombatOut_Text:Hide();
	AutoBuffFrameOptionsCombatOutButton:Hide();
	AutoBuffFrameOptionsCombatOutButton:SetChecked(0);
	AutoBuffFrameOptionsCombatAlways_Text:Hide();
	AutoBuffFrameOptionsCombatAlwaysButton:Hide();
	AutoBuffFrameOptionsCombatAlwaysButton:SetChecked(0);
	
	
	AutoBuffFrameOptionsParty_Text:ClearAllPoints();
	AutoBuffFrameOptionsParty_Text:SetPoint("TOPLEFT", "AutoBuffFrameOptionsCombat_Text", "BOTTOMLEFT", 0, -25)
	AutoBuffFrameOptionsPartyDefaultButton:Hide();
	AutoBuffFrameOptionsPartyDefaultButton:SetChecked(0);
	AutoBuffFrameOptionsParty_Text:Hide();
	AutoBuffFrameOptionsDefaultParty_Text:Hide();
	AutoBuffFrameOptionsPartyIn_Text:Hide();
	AutoBuffFrameOptionsPartyInButton:Hide();
	AutoBuffFrameOptionsPartyInButton:SetChecked(0);
	AutoBuffFrameOptionsPartyOut_Text:Hide();
	AutoBuffFrameOptionsPartyOutButton:Hide();
	AutoBuffFrameOptionsPartyOutButton:SetChecked(0);
	AutoBuffFrameOptionsPartyAlways_Text:Hide();
	AutoBuffFrameOptionsPartyAlwaysButton:Hide();
	AutoBuffFrameOptionsPartyAlwaysButton:SetChecked(0);

	
	AutoBuffFrameOptionsHealth_Text:ClearAllPoints();
	AutoBuffFrameOptionsHealth_Text:SetPoint("TOPLEFT", "AutoBuffFrameOptionsParty_Text", "BOTTOMLEFT", 0, -25)
	AutoBuffFrameOptionsHealthDefaultButton:Hide();
	AutoBuffFrameOptionsHealthDefaultButton:SetChecked(0);
	AutoBuffFrameOptionsHealth_Text:Hide();
	AutoBuffFrameOptionsDefaultHealth_Text:Hide();
	AutoBuffFrameOptionsHealth:Hide();
	x, y = AutoBuffFrameOptionsHealth:GetMinMaxValues();
	AutoBuffFrameOptionsHealth:SetValue(x);
	AutoBuffFrameOptionsHealth_ValueText:Hide();
	AutoBuffFrameOptionsHealth_ValueText:SetText("#");
	AutoBuffFrameOptionsHealthButton:Hide();
	AutoBuffFrameOptionsHealthButton:SetChecked(0);
	
	AutoBuffFrameOptionsManaDefaultButton:Hide();
	AutoBuffFrameOptionsManaDefaultButton:SetChecked(0);
	AutoBuffFrameOptionsMana_Text:Hide();
	AutoBuffFrameOptionsDefaultMana_Text:Hide();
	AutoBuffFrameOptionsMana:Hide();
	x, y = AutoBuffFrameOptionsMana:GetMinMaxValues();
	AutoBuffFrameOptionsMana_ValueText:Hide();
	AutoBuffFrameOptionsMana_ValueText:SetText("#");
	AutoBuffFrameOptionsManaButton:Hide();
	AutoBuffFrameOptionsManaButton:SetChecked(0);
	
	AutoBuffFrameOptionsRebuffDefaultButton:Hide();
	AutoBuffFrameOptionsRebuffDefaultButton:SetChecked(0);
	AutoBuffFrameOptionsRebuff:Hide();
	x, y = AutoBuffFrameOptionsRebuff:GetMinMaxValues();
	AutoBuffFrameOptionsRebuff:SetValue(x);
	AutoBuffFrameOptionsDefaultRebuff_Text:Hide();
	AutoBuffFrameOptionsRebuff_Text:Hide();
	AutoBuffFrameOptionsRebuff_ValueText:Hide();
	AutoBuffFrameOptionsRebuff_ValueText:SetText("#");
	
	AutoBuffFrameOptionsRankDefaultButton:Hide();
	AutoBuffFrameOptionsRankDefaultButton:SetChecked(0);
	AutoBuffFrameOptionsRank:Hide();
	x, y = AutoBuffFrameOptionsRank:GetMinMaxValues();
	AutoBuffFrameOptionsRank:SetValue(x);
	AutoBuffFrameOptionsDefaultRank_Text:Hide();
	AutoBuffFrameOptionsRank_Text:Hide();
	AutoBuffFrameOptionsRank_ValueText:Hide();
	AutoBuffFrameOptionsRank_ValueText:SetText("#");
	AutoBuffFrameOptionsRank_Text:ClearAllPoints();
	AutoBuffFrameOptionsRank_Text:SetPoint("TOPLEFT", "AutoBuffFrameOptionsRebuff_Text", "BOTTOMLEFT", 0, -9)
	AutoBuffFrameOptions:Show();
	AutoBuffFrameOptions:SetHeight(40);
	vGUI['r'] = nil;
end

function AutoBuffNameButton_OnClick(s)
	if (vGUI['r']) then return; end
	local n = string.lower(getglobal("AutoBuffName"..s.."_Text"):GetText());
	local t,x;
	if (vGUI['s']) then getglobal("AutoBuffName"..vGUI['s']):UnlockHighlight(); end
	vGUI['s'] = s;
	getglobal("AutoBuffName"..s):LockHighlight();
	AutoBuffFrame_ResetAbility();
	if (s == 1) then n = nil; end
	vGUI['n'] = n;
	x = vGUI['m'][s];
	if (x == "default") then
		AutoBuffFrameOptionsEnable_Text:Hide();
		AutoBuffFrameOptionsEnableButton:Hide();
		AutoBuffFrameOptionsDefaultAbility:Show();
		AutoBuffFrameOptions:SetHeight(295); -- JURYRIG
		--AutoBuffFrameOptions:SetHeight(340);
		
		AutoBuffFrameOptionsTrigger_Text:Show();
		AutoBuffFrameOptionsTriggerWheelUp_Text:Show();
		AutoBuffFrameOptionsTriggerWheelUpButton:Show();
		AutoBuffFrameOptionsTriggerWheelDown_Text:Show();
		AutoBuffFrameOptionsTriggerWheelDownButton:Show();
		AutoBuffFrameOptionsTriggerTarget_Text:Show();
		AutoBuffFrameOptionsTriggerTargetButton:Show();
		
		AutoBuffFrameOptionsCombat_Text:Show();
		AutoBuffFrameOptionsCombatIn_Text:Show();
		AutoBuffFrameOptionsCombatInButton:Show();
		AutoBuffFrameOptionsCombatOut_Text:Show();
		AutoBuffFrameOptionsCombatOutButton:Show();
		AutoBuffFrameOptionsCombatAlways_Text:Show();
		AutoBuffFrameOptionsCombatAlwaysButton:Show();
		
		AutoBuffFrameOptionsParty_Text:Show();
		AutoBuffFrameOptionsPartyIn_Text:Show();
		AutoBuffFrameOptionsPartyInButton:Show();
		AutoBuffFrameOptionsPartyOut_Text:Show();
		AutoBuffFrameOptionsPartyOutButton:Show();
		AutoBuffFrameOptionsPartyAlways_Text:Show();
		AutoBuffFrameOptionsPartyAlwaysButton:Show();
		AutoBuffFrameOptionsHealth_Text:Show();
		AutoBuffFrameOptionsHealth:Show();
		AutoBuffFrameOptionsHealth_ValueText:Show();
		AutoBuffFrameOptionsHealthButton:Show();
		AutoBuffFrameOptionsMana_Text:Show();
		AutoBuffFrameOptionsMana:Show();
		AutoBuffFrameOptionsMana_ValueText:Show();
		AutoBuffFrameOptionsManaButton:Show();
		AutoBuffFrameOptionsRebuff:Show();
		AutoBuffFrameOptionsRebuff_Text:Show();
		AutoBuffFrameOptionsRebuff_ValueText:Show();
		
		local trigger = AutoBuff_Trigger('d');
		AutoBuffFrameOptionsTriggerWheelUpButton:SetChecked(trigger[1]);
		AutoBuffFrameOptionsTriggerWheelDownButton:SetChecked(trigger[2]);
		AutoBuffFrameOptionsTriggerTargetButton:SetChecked(trigger[3]);
		
		if (AutoBuff_Option(n, 'c') == 1) then AutoBuffFrameOptionsCombatInButton:SetChecked(1); end
		if (AutoBuff_Option(n, 'c') == 2) then AutoBuffFrameOptionsCombatOutButton:SetChecked(1); end
		if (AutoBuff_Option(n, 'c') == 3) then AutoBuffFrameOptionsCombatAlwaysButton:SetChecked(1); end
		
		if (AutoBuff_Option(n, 'p') == 1) then AutoBuffFrameOptionsPartyInButton:SetChecked(1); end
		if (AutoBuff_Option(n, 'p') == 2) then AutoBuffFrameOptionsPartyOutButton:SetChecked(1); end
		if (AutoBuff_Option(n, 'p') == 3) then AutoBuffFrameOptionsPartyAlwaysButton:SetChecked(1); end
		
		t = AutoBuff_Option(n, 'h');
		if (t > 0) then
			AutoBuffFrameOptionsHealthButton:SetChecked(0);
			AutoBuffFrameOptionsHealth_ValueText:SetText(">"..t.."%");
			AutoBuffFrameOptionsHealth:SetValue(t);
		else
			t = t*-1;
			AutoBuffFrameOptionsHealthButton:SetChecked(1);
			AutoBuffFrameOptionsHealth_ValueText:SetText("<"..t.."%");
			AutoBuffFrameOptionsHealth:SetValue(t);
		end
		
		t = AutoBuff_Option(n, 'm');
		if (t > 0) then
			AutoBuffFrameOptionsManaButton:SetChecked(0);
			AutoBuffFrameOptionsMana:SetValue(t);
			AutoBuffFrameOptionsMana_ValueText:SetText(">"..t.."%");
		else
			t = t*-1;
			AutoBuffFrameOptionsManaButton:SetChecked(1);
			AutoBuffFrameOptionsMana:SetValue(t);
			AutoBuffFrameOptionsMana_ValueText:SetText("<"..t.."%");
		end
		
		t = AutoBuff_Option(n, 'r');
		AutoBuffFrameOptionsRebuff:SetValue(t);
		AutoBuffFrameOptionsRebuff_ValueText:SetText(AutoBuffFrame_RebuffValueText(t));
		
		
	-- elseif (vGUI['m'][s] == "track") then
		-- if (vTrack == n) then AutoBuffFrameOptionsEnableButton:SetChecked(1); end
	-- elseif (vGUI['m'][s] == "aspect") then
		-- if (vAspect == n) then AutoBuffFrameOptionsEnableButton:SetChecked(1); end
	-- elseif (vGUI['m'][s] == "seal") then
		-- if (vSeal == n) then AutoBuffFrameOptionsEnableButton:SetChecked(1); end
	--elseif (x ~= "track" and x ~= "aspect" and x ~= "seal") then
	else
		--if ((x == "spell") and (not AutoBuff_Option(n, 'd'))) or ((x == "weapon") and (vWeapon == n)) then
		if ((x == "spell") and (not AutoBuff_Option(n, 'd'))) or ((x == "weapon") and (vWeapon == n)) or ((x == "track") and (vTrack == n)) or ((x == "aspect") and (vAspect == n)) or ((x == "seal") and (vSeal == n)) then
			AutoBuffFrameOptionsEnableButton:SetChecked(1);
			local height = 370;
			
			AutoBuffFrameOptionsCombatDefaultButton:Show();
			AutoBuffFrameOptionsCombat_Text:Show();
			AutoBuffFrameOptionsCombatIn_Text:Show();
			AutoBuffFrameOptionsCombatInButton:Show();
			AutoBuffFrameOptionsCombatOut_Text:Show();
			AutoBuffFrameOptionsCombatOutButton:Show();
			AutoBuffFrameOptionsCombatAlways_Text:Show();
			AutoBuffFrameOptionsCombatAlwaysButton:Show();
			
			AutoBuffFrameOptionsPartyDefaultButton:Show();
			AutoBuffFrameOptionsParty_Text:Show();
			AutoBuffFrameOptionsPartyIn_Text:Show();
			AutoBuffFrameOptionsPartyInButton:Show();
			AutoBuffFrameOptionsPartyOut_Text:Show();
			AutoBuffFrameOptionsPartyOutButton:Show();
			AutoBuffFrameOptionsPartyAlways_Text:Show();
			AutoBuffFrameOptionsPartyAlwaysButton:Show();
			
			AutoBuffFrameOptionsHealthDefaultButton:Show();
			AutoBuffFrameOptionsHealth_Text:Show();
			AutoBuffFrameOptionsHealth:Show();
			AutoBuffFrameOptionsHealth_ValueText:Show();
			AutoBuffFrameOptionsHealthButton:Show();
			AutoBuffFrameOptionsManaDefaultButton:Show();
			AutoBuffFrameOptionsMana_Text:Show();
			AutoBuffFrameOptionsMana:Show();
			AutoBuffFrameOptionsMana_ValueText:Show();
			AutoBuffFrameOptionsManaButton:Show();
			AutoBuffFrameOptionsRebuffDefaultButton:Show();
			AutoBuffFrameOptionsRebuff:Show();
			AutoBuffFrameOptionsRebuff_Text:Show();
			AutoBuffFrameOptionsRebuff_ValueText:Show();
			
			AutoBuffFrameOptionsRankDefaultButton:Show();
			AutoBuffFrameOptionsRank:Show();
			AutoBuffFrameOptionsRank_Text:Show();
			AutoBuffFrameOptionsRank_ValueText:Show();
			
			AutoBuffFrameOptionsTrigger_Text:Show();
			AutoBuffFrameOptionsTriggerDefaultButton:Show();
			AutoBuffFrameOptionsTriggerWheelUp_Text:Show();
			AutoBuffFrameOptionsTriggerWheelUpButton:Show();
			AutoBuffFrameOptionsTriggerWheelDown_Text:Show();
			AutoBuffFrameOptionsTriggerWheelDownButton:Show();
			AutoBuffFrameOptionsTriggerTarget_Text:Show();
			AutoBuffFrameOptionsTriggerTargetButton:Show();
			
			if (AutoBuff_Option(n, 't')) then
				AutoBuffFrameOptionsTriggerDefaultButton:SetChecked(1);
				local trigger = AutoBuff_Trigger(n);
				AutoBuffFrameOptionsTriggerWheelUpButton:SetChecked(trigger[1]);
				AutoBuffFrameOptionsTriggerWheelDownButton:SetChecked(trigger[2]);
				AutoBuffFrameOptionsTriggerTargetButton:SetChecked(trigger[3]);
				height = height - 55;
			else
				AutoBuffFrameOptionsDefaultTrigger_Text:Show();
				AutoBuffFrameOptionsTriggerWheelUp_Text:Hide();
				AutoBuffFrameOptionsTriggerWheelUpButton:Hide();
				AutoBuffFrameOptionsTriggerWheelDown_Text:Hide();
				AutoBuffFrameOptionsTriggerWheelDownButton:Hide();
				AutoBuffFrameOptionsTriggerTarget_Text:Hide();
				AutoBuffFrameOptionsTriggerTargetButton:Hide();
				AutoBuffFrameOptionsCombat_Text:ClearAllPoints();
				AutoBuffFrameOptionsCombat_Text:SetPoint("TOPLEFT", "AutoBuffFrameOptionsTrigger_Text", "BOTTOMLEFT", 0, -9);
				height = height - 105;
			end
			
			if (AutoBuff_Option(n, 'c')) then
				AutoBuffFrameOptionsCombatDefaultButton:SetChecked(1);
				if (AutoBuff_Option(n, 'c') == 1) then AutoBuffFrameOptionsCombatInButton:SetChecked(1); end
				if (AutoBuff_Option(n, 'c') == 2) then AutoBuffFrameOptionsCombatOutButton:SetChecked(1); end
				if (AutoBuff_Option(n, 'c') == 3) then AutoBuffFrameOptionsCombatAlwaysButton:SetChecked(1); end
			else
				AutoBuffFrameOptionsCombatIn_Text:Hide();
				AutoBuffFrameOptionsCombatInButton:Hide();
				AutoBuffFrameOptionsCombatOut_Text:Hide();
				AutoBuffFrameOptionsCombatOutButton:Hide();
				AutoBuffFrameOptionsCombatAlways_Text:Hide();
				AutoBuffFrameOptionsCombatAlwaysButton:Hide();
				AutoBuffFrameOptionsDefaultCombat_Text:Show();
				AutoBuffFrameOptionsParty_Text:ClearAllPoints();
				AutoBuffFrameOptionsParty_Text:SetPoint("TOPLEFT", "AutoBuffFrameOptionsCombat_Text", "BOTTOMLEFT", 0, -9)
				height = height - 15;
			end
			
			
			if (AutoBuff_Option(n, 'p')) then
				AutoBuffFrameOptionsPartyDefaultButton:SetChecked(1);
				if (AutoBuff_Option(n, 'p') == 1) then AutoBuffFrameOptionsPartyInButton:SetChecked(1); end
				if (AutoBuff_Option(n, 'p') == 2) then AutoBuffFrameOptionsPartyOutButton:SetChecked(1); end
				if (AutoBuff_Option(n, 'p') == 3) then AutoBuffFrameOptionsPartyAlwaysButton:SetChecked(1); end
			else
				AutoBuffFrameOptionsPartyIn_Text:Hide();
				AutoBuffFrameOptionsPartyInButton:Hide();
				AutoBuffFrameOptionsPartyOut_Text:Hide();
				AutoBuffFrameOptionsPartyOutButton:Hide();
				AutoBuffFrameOptionsPartyAlways_Text:Hide();
				AutoBuffFrameOptionsPartyAlwaysButton:Hide();
				AutoBuffFrameOptionsDefaultParty_Text:Show();
				AutoBuffFrameOptionsHealth_Text:ClearAllPoints();
				AutoBuffFrameOptionsHealth_Text:SetPoint("TOPLEFT", "AutoBuffFrameOptionsParty_Text", "BOTTOMLEFT", 0, -9)
				height = height -15;
			end
			
			t = AutoBuff_Option(n, 'h');
			if (not t) then
				AutoBuffFrameOptionsHealth:Hide();
				AutoBuffFrameOptionsHealth_ValueText:Hide();
				AutoBuffFrameOptionsHealthButton:Hide();
				AutoBuffFrameOptionsDefaultHealth_Text:Show();
			else
				AutoBuffFrameOptionsHealthDefaultButton:SetChecked(1);
				if (t > 0) then
					AutoBuffFrameOptionsHealthButton:SetChecked(0);
					AutoBuffFrameOptionsHealth_ValueText:SetText(">"..t.."%");
					AutoBuffFrameOptionsHealth:SetValue(t);
				else
					t = t*-1;
					AutoBuffFrameOptionsHealthButton:SetChecked(1);
					AutoBuffFrameOptionsHealth_ValueText:SetText("<"..t.."%");
					AutoBuffFrameOptionsHealth:SetValue(t);
				end
			end
			
			t = AutoBuff_Option(n, 'm');
			if (not t) then
				AutoBuffFrameOptionsMana:Hide();
				AutoBuffFrameOptionsMana_ValueText:Hide();
				AutoBuffFrameOptionsManaButton:Hide();
				AutoBuffFrameOptionsDefaultMana_Text:Show();
			else
				AutoBuffFrameOptionsManaDefaultButton:SetChecked(1);
				if (t > 0) then
					AutoBuffFrameOptionsManaButton:SetChecked(0);
					AutoBuffFrameOptionsMana:SetValue(t);
					AutoBuffFrameOptionsMana_ValueText:SetText(">"..t.."%");
				else
					t = t*-1;
					AutoBuffFrameOptionsManaButton:SetChecked(1);
					AutoBuffFrameOptionsMana:SetValue(t);
					AutoBuffFrameOptionsMana_ValueText:SetText("<"..t.."%");
				end
			end
			--if (not AutoBuff_IsAura(n)) and (n ~= string.lower(AUTOBUFF_ABILITY_TRUESHOTAURA)) then
			if (not AutoBuff_IsAura(n)) then
				t = AutoBuff_Option(n, 'r');
				if (not t) then
					AutoBuffFrameOptionsRebuff:Hide();
					AutoBuffFrameOptionsRebuff_ValueText:Hide();
					AutoBuffFrameOptionsDefaultRebuff_Text:Show();
				else
					AutoBuffFrameOptionsRebuffDefaultButton:SetChecked(1);
					AutoBuffFrameOptionsRebuff:SetValue(t);
					AutoBuffFrameOptionsRebuff_ValueText:SetText(AutoBuffFrame_RebuffValueText(t));
				end
			else
				AutoBuffFrameOptionsRebuffDefaultButton:Hide();
				AutoBuffFrameOptionsRebuff:Hide();
				AutoBuffFrameOptionsRebuff_Text:Hide();
				AutoBuffFrameOptionsRebuff_ValueText:Hide();
				height = height - 28;
				AutoBuffFrameOptionsRank_Text:ClearAllPoints();
				AutoBuffFrameOptionsRank_Text:SetPoint("TOPLEFT", "AutoBuffFrameOptionsMana_Text", "BOTTOMLEFT", 0, -9)
			end
			local hr = 0;
			if (x == "weapon") then hr = vWeaponList[n]; end
			--if (x == "track") then hr = vTrackList[n]; end
			--if (x == "aspect") then hr = vAspectList[n]; end
			--if (x == "seal") then hr = vSealList[n]; end
			if (x == "spell") and (vSpellList[n]['k']) then hr = vSpellList[n]['k']; end
			--if (x == "track") and (vTrackList[n]['k']) then hr = vTrackList[n]['k']; end
			--if (x == "aspect") and (vAspectList[n]['k']) then hr = vAspectList[n]['k']; end
			if (x == "seal") and (vSealList[n]['k']) then hr = vSealList[n]['k']; end
			if (hr and hr > 1) then
				t = AutoBuff_Option(n, 'k');
				AutoBuffFrameOptionsRank:SetMinMaxValues(1, hr);
				if (not t) then
					AutoBuffFrameOptionsRank:Hide();
					AutoBuffFrameOptionsRank_ValueText:Hide();
					AutoBuffFrameOptionsDefaultRank_Text:Show();
				else
					AutoBuffFrameOptionsRankDefaultButton:SetChecked(1);
					AutoBuffFrameOptionsRank:SetValue(t);
					AutoBuffFrameOptionsRank_ValueText:SetText(t);
				end			
			else
				AutoBuffFrameOptionsRankDefaultButton:Hide();
				AutoBuffFrameOptionsRank:Hide();
				AutoBuffFrameOptionsRank_Text:Hide();
				AutoBuffFrameOptionsRank_ValueText:Hide();
				height = height - 28;
			end
			
			AutoBuffFrameOptions:SetHeight(height);
		end
	end
end

function AutoBuffFrame_OnClick()
	if (vGUI['r']) then return; end
	local s = vGUI['s'];
	local x = vGUI['m'][s];
	local frame, n = this:GetName(), vGUI['n']
		if (not frame) then return; end
		local c = this:GetChecked();
		if (frame == "AutoBuffFrameCheckButton") then
			if (not c or c==0) then AutoBuff_Off(); end -- EMERALD: Persistant on/off checkbox
			--else AutoBuff_On(); end
			if (not c or c==0) then
				AutoBuff_Off();
				AutoBuffFrameAbility:Hide();
			else
				AutoBuff_On();
				AutoBuffFrameAbility:Show();
				AutoBuff_Populate();
			end
		elseif (frame == "AutoBuffFrameOptionsEnableButton") then
			local t = vGUI['m'][(vGUI['s'])];
			if (t == "spell") then
				if (c == 1) then c = "default"; else c = 1; end
				AutoBuff_Option(n, 'd', c);
				if (AutoBuff_IsBlessing(n)) then AutoBuff_FixBlessing(n); end
				if (AutoBuff_IsAura(n)) then AutoBuff_FixAura(n); end
			elseif (t == "weapon") then
				if (c == 1) then AutoBuff_Data[vC]['w'] = vGUI['n'];
				else AutoBuff_Data[vC]['w'] = "off"; end
				AutoBuff_WeaponLoad();
			elseif (t == "track") then
				if (c == 1) then AutoBuff_Data[vC]['t'] = vGUI['n'];
				else AutoBuff_Data[vC]['t'] = "off"; end
				AutoBuff_TrackLoad();
			elseif (t == "aspect") then
				if (c == 1) then AutoBuff_Data[vC]['a'] = vGUI['n'];
				else AutoBuff_Data[vC]['a'] = "off"; end
				AutoBuff_AspectLoad();
			elseif (t == "seal") then
				if (c == 1) then AutoBuff_Data[vC]["seal"] = vGUI['n'];
				else AutoBuff_Data[vC]["seal"] = "off"; end
				AutoBuff_SealLoad();
			end
			AutoBuff_Populate();
			AutoBuffNameButton_OnClick(vGUI['s']);

		elseif (frame == "AutoBuffFrameOptionsHealthButton") then
			if (c == 1) then t = "<";
			else t = ">"; end
			AutoBuffFrameOptionsHealth_ValueText:SetText(t..AutoBuffFrameOptionsHealth:GetValue().."%");
			AutoBuff_Option(n, 'h', (AutoBuff_Option(n, 'h')*-1));
		elseif (frame == "AutoBuffFrameOptionsManaButton") then
			if (c == 1) then t = "<";
			else t = ">"; end
			AutoBuffFrameOptionsMana_ValueText:SetText(t..AutoBuffFrameOptionsMana:GetValue().."%");
			AutoBuff_Option(n, 'm', (AutoBuff_Option(n, 'm')*-1));
		elseif (frame == "AutoBuffFrameOptionsCombatInButton") then
			this:SetChecked(1);
			AutoBuffFrameOptionsCombatOutButton:SetChecked(0);
			AutoBuffFrameOptionsCombatAlwaysButton:SetChecked(0);
			AutoBuff_Option(n, 'c', 1);
		elseif (frame == "AutoBuffFrameOptionsCombatOutButton") then
			this:SetChecked(1);
			AutoBuffFrameOptionsCombatInButton:SetChecked(0);
			AutoBuffFrameOptionsCombatAlwaysButton:SetChecked(0);
			AutoBuff_Option(n, 'c', 2);
		elseif (frame == "AutoBuffFrameOptionsCombatAlwaysButton") then
			this:SetChecked(1);
			AutoBuffFrameOptionsCombatInButton:SetChecked(0);
			AutoBuffFrameOptionsCombatOutButton:SetChecked(0);
			AutoBuff_Option(n, 'c', 3);
		elseif (frame == "AutoBuffFrameOptionsCombatDefaultButton") then
			if (c == 1) then
				AutoBuff_Option(n, 'c', AutoBuff_Option('d', 'c'));
			else
				AutoBuff_Option(n, 'c', "default");
			end
			AutoBuffNameButton_OnClick(vGUI['s']);
			
		elseif (frame == "AutoBuffFrameOptionsPartyInButton") then
			this:SetChecked(1);
			AutoBuffFrameOptionsPartyOutButton:SetChecked(0);
			AutoBuffFrameOptionsPartyAlwaysButton:SetChecked(0);
			AutoBuff_Option(n, 'p', 1);
		elseif (frame == "AutoBuffFrameOptionsPartyOutButton") then
			this:SetChecked(1);
			AutoBuffFrameOptionsPartyInButton:SetChecked(0);
			AutoBuffFrameOptionsPartyAlwaysButton:SetChecked(0);
			AutoBuff_Option(n, 'p', 2);
		elseif (frame == "AutoBuffFrameOptionsPartyAlwaysButton") then
			this:SetChecked(1);
			AutoBuffFrameOptionsPartyInButton:SetChecked(0);
			AutoBuffFrameOptionsPartyOutButton:SetChecked(0);
			AutoBuff_Option(n, 'p', 3);
		elseif (frame == "AutoBuffFrameOptionsPartyDefaultButton") then
			if (c == 1) then
				AutoBuff_Option(n, 'p', AutoBuff_Option('d', 'p'));
			else
				AutoBuff_Option(n, 'p', "default");
			end
			AutoBuffNameButton_OnClick(vGUI['s']);
		
		
		elseif (frame == "AutoBuffFrameOptionsTriggerWheelUpButton") or
				(frame == "AutoBuffFrameOptionsTriggerWheelDownButton") or
				(frame == "AutoBuffFrameOptionsTriggerTargetButton") then
			local trigger = 0;
			if (AutoBuffFrameOptionsTriggerWheelUpButton:GetChecked() == 1) then trigger = trigger + 2^1; end
			if (AutoBuffFrameOptionsTriggerWheelDownButton:GetChecked() == 1) then trigger = trigger + 2^2; end
			if (AutoBuffFrameOptionsTriggerTargetButton:GetChecked() == 1) then trigger = trigger + 2^3; end
			AutoBuff_Option(n, 't', trigger);
		elseif (frame == "AutoBuffFrameOptionsTriggerDefaultButton") then
			if (c == 1) then
				AutoBuff_Option(n, 't', AutoBuff_Option('d', 't'));
			else
				AutoBuff_Option(n, 't', "default");
			end
			AutoBuffNameButton_OnClick(vGUI['s']);
		elseif (frame == "AutoBuffFrameOptionsHealthDefaultButton") then
			if (c == 1) then
				AutoBuff_Option(n, 'h', AutoBuff_Option('d', 'h'));
			else
				AutoBuff_Option(n, 'h', "default");
			end
			AutoBuffNameButton_OnClick(vGUI['s']);
		elseif (frame == "AutoBuffFrameOptionsManaDefaultButton") then
			if (c == 1) then
				AutoBuff_Option(n, 'm', AutoBuff_Option('d', 'm'));
			else
				AutoBuff_Option(n, 'm', "default");
			end
			AutoBuffNameButton_OnClick(vGUI['s']);
		elseif (frame == "AutoBuffFrameOptionsRebuffDefaultButton") then
			if (c == 1) then
				AutoBuff_Option(n, 'r', AutoBuff_Option('d', 'r'));
			else
				AutoBuff_Option(n, 'r', "default");
			end
			AutoBuffNameButton_OnClick(vGUI['s']);
		elseif (frame == "AutoBuffFrameOptionsRankDefaultButton") then
			if (c == 1) then
				local a, b = AutoBuffFrameOptionsRank:GetMinMaxValues();
				AutoBuff_Option(n, 'k', b);
			else
				AutoBuff_Option(n, 'k', "default");
			end
			AutoBuffNameButton_OnClick(vGUI['s']);
		end
end

function AutoBuffFrame_OnValueChanged()
	if (vGUI['r']) then return; end
	local frame = this:GetName();
	if (not frame) then return; end
	local c = this:GetValue();
	local t;
	if (frame == "AutoBuffFrameOptionsHealth") then
		if (AutoBuffFrameOptionsHealthButton:GetChecked() == 1) then t = "<"..c.."%"; c=c*-1;
		else t = ">"..c.."%"; end
		AutoBuffFrameOptionsHealth_ValueText:SetText(t);
		AutoBuff_Option(vGUI['n'],'h',c);
	elseif (frame == "AutoBuffFrameOptionsMana") then
		if (AutoBuffFrameOptionsManaButton:GetChecked() == 1) then t = "<"..c.."%"; c=c*-1;
		else t = ">"..c.."%"; end
		AutoBuffFrameOptionsMana_ValueText:SetText(t);
		AutoBuff_Option(vGUI['n'],'m',c);
	elseif (frame == "AutoBuffFrameOptionsRebuff") then
		AutoBuffFrameOptionsRebuff_ValueText:SetText(AutoBuffFrame_RebuffValueText(c));
		AutoBuff_Option(vGUI['n'], 'r', c);
	elseif (frame == "AutoBuffFrameOptionsRank") then
		AutoBuffFrameOptionsRank_ValueText:SetText(c);
		AutoBuff_Option(vGUI['n'], 'k', c);
	end
end

function AutoBuffFrame_RebuffValueText(c)
	c = tonumber(c);
	if (c == nil) then return; end
	local m = floor(c/60);
	local s = c - (m*60);
	local v = s.."s";
	if (m>0) and (s == 0) then v = m.."m";
	elseif (m>0) then v = m.."m"..v; end
	return v;
end


function AutoBuffFrame_Tooltip(arg1,arg2,arg3)
	if (not arg3) then arg3 = "ANCHOR_TOPLEFT"; end
	GameTooltip:SetOwner(this, arg3);
    GameTooltip:SetText(arg1);
    GameTooltip:AddLine(arg2, .75, .75, .75, 1);
    GameTooltip:Show();
end

function AutoBuffFrame_OnEnter()
	local frame = this:GetName();
	if (not frame) then return; end
	if (frame == "AutoBuffFrameCheckButton") then
		AutoBuffFrame_Tooltip(AUTOBUFF_GUI_ENABLE_TOOLTIP_TITLE, AUTOBUFF_GUI_ENABLE_TOOLTIP);
	elseif (frame == "AutoBuffFrameOptionsEnableButton") then
		AutoBuffFrame_Tooltip(AUTOBUFF_GUI_ENABLEABILITY_TOOLTIP_TITLE, AUTOBUFF_GUI_ENABLEABILITY_TOOLTIP, "ANCHOR_BOTTOMRIGHT");
	elseif (frame == "AutoBuffFrameOptionsRebuff") then
		AutoBuffFrame_Tooltip(AUTOBUFF_GUI_REBUFF_TOOLTIP_TITLE, AUTOBUFF_GUI_REBUFF_TOOLTIP);
	elseif (frame == "AutoBuffFrameOptionsHealth") then
		AutoBuffFrame_Tooltip(AUTOBUFF_GUI_HEALTH_TOOLTIP_TITLE, AUTOBUFF_GUI_HEALTH_TOOLTIP);
	elseif (frame == "AutoBuffFrameOptionsMana") then
		AutoBuffFrame_Tooltip(AUTOBUFF_GUI_MANA_TOOLTIP_TITLE, AUTOBUFF_GUI_MANA_TOOLTIP);
	elseif (frame == "AutoBuffFrameOptionsHealthButton") or (frame == "AutoBuffFrameOptionsManaButton") then
		AutoBuffFrame_Tooltip(AUTOBUFF_GUI_INVERT_TOOLTIP_TITLE, AUTOBUFF_GUI_INVERT_TOOLTIP);
	elseif (frame == "AutoBuffFrameOptionsCombatInButton") then
		AutoBuffFrame_Tooltip(AUTOBUFF_GUI_COMBAT_IN_TOOLTIP_TITLE, AUTOBUFF_GUI_COMBAT_IN_TOOLTIP);
	elseif (frame == "AutoBuffFrameOptionsCombatOutButton") then
		AutoBuffFrame_Tooltip(AUTOBUFF_GUI_COMBAT_OUT_TOOLTIP_TITLE, AUTOBUFF_GUI_COMBAT_OUT_TOOLTIP);
	elseif (frame == "AutoBuffFrameOptionsCombatAlwaysButton") then
		AutoBuffFrame_Tooltip(AUTOBUFF_GUI_COMBAT_ALWAYS_TOOLTIP_TITLE, AUTOBUFF_GUI_COMBAT_ALWAYS_TOOLTIP);
		
	elseif (frame == "AutoBuffFrameOptionsPartyInButton") then
		AutoBuffFrame_Tooltip(AUTOBUFF_GUI_PARTY_IN_TOOLTIP_TITLE, AUTOBUFF_GUI_PARTY_IN_TOOLTIP);
	elseif (frame == "AutoBuffFrameOptionsPartyOutButton") then
		AutoBuffFrame_Tooltip(AUTOBUFF_GUI_PARTY_OUT_TOOLTIP_TITLE, AUTOBUFF_GUI_PARTY_OUT_TOOLTIP);
	elseif (frame == "AutoBuffFrameOptionsPartyAlwaysButton") then
		AutoBuffFrame_Tooltip(AUTOBUFF_GUI_PARTY_ALWAYS_TOOLTIP_TITLE, AUTOBUFF_GUI_PARTY_ALWAYS_TOOLTIP);
		
	elseif (frame == "AutoBuffFrameOptionsCombatDefaultButton") or (frame == "AutoBuffFrameOptionsHealthDefaultButton") or (frame == "AutoBuffFrameOptionsTriggerDefaultButton") or
		   (frame == "AutoBuffFrameOptionsManaDefaultButton") or (frame == "AutoBuffFrameOptionsRebuffDefaultButton") or (frame == "AutoBuffFrameOptionsPartyDefaultButton") then
		AutoBuffFrame_Tooltip(AUTOBUFF_GUI_DEFAULT_TOOLTIP_TITLE, AUTOBUFF_GUI_DEFAULT_TOOLTIP);
	elseif (frame == "AutoBuffFrameOptionsTriggerWheelUpButton") or (frame == "AutoBuffFrameOptionsTriggerWheelDownButton") or (frame == "AutoBuffFrameOptionsTriggerTargetButton") then
		AutoBuffFrame_Tooltip(AUTOBUFF_GUI_TRIGGER_TITLE, AUTOBUFF_GUI_TRIGGER_TOOLTIP);
	end
end

function AutoBuffFrame_OnMouseDown(arg1) if arg1=="LeftButton" then	AutoBuffFrame:StartMoving(); end end
function AutoBuffFrame_OnMouseUp(arg1) if arg1=="LeftButton" then AutoBuffFrame:StopMovingOrSizing(); end end


-- Had to make this function weird, as it was giving me an awful 'next' key is invalid error.
function AutoBuff_CorrectName(s)
	s = string.lower(s);
	local a,b,c,d;
	for a, b in cSpellList do
		c = string.lower(a);
		if (c == s) then d = a; break; end
	end
	if (not d) then
		for a, b in cWeaponList do
			c = string.lower(a);
			if (c == s) then d = a; break; end
		end
	end
	if (not d) then
		for a, b in cTrackList do
			c = string.lower(a);
			if (c == s) then d = a; break; end
		end
	end
	if (not d) then
		for a, b in cAspectList do
			c = string.lower(a);
			if (c == s) then d = a; break; end
		end
	end
	if (not d) then
		for a, b in cSealList do
			c = string.lower(a);
			if (c == s) then d = a; break; end
		end
	end
	return d;
end

function AutoBuff_SpellList(n)
	local a,b,r;
	for a,b in cSpellList do
		if (b['i'] == n) then r = a; break; end
	end
	return r;
end

-- ==================================================

function TitanPanelAutoBuffButton_OnLoad()
	this.registry = { 
		id = TITAN_AUTOBUFF_ID,
		menuText = TITAN_AUTOBUFF_MENU_TEXT,
		buttonTextFunction = nil,
		tooltipTitle = TITAN_AUTOBUFF_TOOLTIP,
		tooltipTextFunction = "TitanPanelAutoBuffButton_GetTooltipText",
		icon = TITAN_AUTOBUFF_ICON_ON,
		iconWidth = 16,
    frequency = 5,
	};
end

function TitanPanelAutoBuffButton_OnClick()
	if (arg1=="LeftButton") then
		AutoBuffOptionsButton_OnClick(arg1);
	end
end

function TitanPanelAutoBuffButton_GetTooltipText()

	--if (IsAddOnLoaded("Titan")) then TITAN_AUTOBUFF_TOOLTIP_CONTENTS = TITAN_AUTOBUFF_TOOLTIP_CONTENTS..TitanUtils_GetColoredText("Testing", u.ColorList[string.lower("red")]).."\t"..TitanUtils_GetColoredText("Testing", u.ColorList[string.lower("yellow")]).."\n"; end
	
	TITAN_AUTOBUFF_TOOLTIP_CONTENTS = TitanUtils_GetColoredText(TITAN_AUTOBUFF_ENABLE, u.ColorList[string.lower("yellow")]).."\t";
	
	if (TitanAutoBuffStates.Enabled) then
		TITAN_AUTOBUFF_TOOLTIP_CONTENTS = TITAN_AUTOBUFF_TOOLTIP_CONTENTS..TitanUtils_GetColoredText("Enabled", u.ColorList[string.lower("green")]).."\n";
	else
		TITAN_AUTOBUFF_TOOLTIP_CONTENTS = TITAN_AUTOBUFF_TOOLTIP_CONTENTS..TitanUtils_GetColoredText("Disabled", u.ColorList[string.lower("red")]).."\n";
	end
	
	TITAN_AUTOBUFF_TOOLTIP_CONTENTS = TITAN_AUTOBUFF_TOOLTIP_CONTENTS..TitanUtils_GetColoredText(TITAN_AUTOBUFF_DEBUG, u.ColorList[string.lower("yellow")]).."\t";
	
	if (TitanAutoBuffStates.Debug) then
		TITAN_AUTOBUFF_TOOLTIP_CONTENTS = TITAN_AUTOBUFF_TOOLTIP_CONTENTS..TitanUtils_GetColoredText("Enabled", u.ColorList[string.lower("green")]).."\n";
	else
		TITAN_AUTOBUFF_TOOLTIP_CONTENTS = TITAN_AUTOBUFF_TOOLTIP_CONTENTS..TitanUtils_GetColoredText("Disabled", u.ColorList[string.lower("red")]).."\n";
	end

if (vClass == string.lower(AUTOBUFF_CLASS_WARLOCK) or vClass == string.lower(AUTOBUFF_CLASS_SHAMAN)) then
	TITAN_AUTOBUFF_TOOLTIP_CONTENTS = TITAN_AUTOBUFF_TOOLTIP_CONTENTS..TitanUtils_GetColoredText(TITAN_AUTOBUFF_WATER, u.ColorList[string.lower("yellow")]).."\t";
	
	if (TitanAutoBuffStates.Water) then
		TITAN_AUTOBUFF_TOOLTIP_CONTENTS = TITAN_AUTOBUFF_TOOLTIP_CONTENTS..TitanUtils_GetColoredText("Enabled", u.ColorList[string.lower("green")]).."\n";
	else
		TITAN_AUTOBUFF_TOOLTIP_CONTENTS = TITAN_AUTOBUFF_TOOLTIP_CONTENTS..TitanUtils_GetColoredText("Disabled", u.ColorList[string.lower("red")]).."\n";
	end
end

if (vClass == string.lower(AUTOBUFF_CLASS_WARLOCK) or vClass == string.lower(AUTOBUFF_CLASS_PRIEST)) then
	TITAN_AUTOBUFF_TOOLTIP_CONTENTS = TITAN_AUTOBUFF_TOOLTIP_CONTENTS..TitanUtils_GetColoredText(TITAN_AUTOBUFF_TAP, u.ColorList[string.lower("yellow")]).."\t";
	
	if (TitanAutoBuffStates.Tap) then
		TITAN_AUTOBUFF_TOOLTIP_CONTENTS = TITAN_AUTOBUFF_TOOLTIP_CONTENTS..TitanUtils_GetColoredText("Enabled", u.ColorList[string.lower("green")]).."\n";
	else
		TITAN_AUTOBUFF_TOOLTIP_CONTENTS = TITAN_AUTOBUFF_TOOLTIP_CONTENTS..TitanUtils_GetColoredText("Disabled", u.ColorList[string.lower("red")]).."\n";
	end
end

if (vClass == string.lower(AUTOBUFF_CLASS_WARLOCK)) then
	TITAN_AUTOBUFF_TOOLTIP_CONTENTS = TITAN_AUTOBUFF_TOOLTIP_CONTENTS..TitanUtils_GetColoredText(TITAN_AUTOBUFF_SCALED, u.ColorList[string.lower("yellow")]).."\t";
	
	if (TitanAutoBuffStates.Scaled) then
		TITAN_AUTOBUFF_TOOLTIP_CONTENTS = TITAN_AUTOBUFF_TOOLTIP_CONTENTS..TitanUtils_GetColoredText("Enabled", u.ColorList[string.lower("green")]).."\n";
	else
		TITAN_AUTOBUFF_TOOLTIP_CONTENTS = TITAN_AUTOBUFF_TOOLTIP_CONTENTS..TitanUtils_GetColoredText("Disabled", u.ColorList[string.lower("red")]).."\n";
	end
end

if (vClass == string.lower(AUTOBUFF_CLASS_PRIEST)) then
	TITAN_AUTOBUFF_TOOLTIP_CONTENTS = TITAN_AUTOBUFF_TOOLTIP_CONTENTS..TitanUtils_GetColoredText(TITAN_AUTOBUFF_INNER, u.ColorList[string.lower("yellow")]).."\t";
	
	if (TitanAutoBuffStates.Inner) then
		TITAN_AUTOBUFF_TOOLTIP_CONTENTS = TITAN_AUTOBUFF_TOOLTIP_CONTENTS..TitanUtils_GetColoredText("Enabled", u.ColorList[string.lower("green")]).."\n";
	else
		TITAN_AUTOBUFF_TOOLTIP_CONTENTS = TITAN_AUTOBUFF_TOOLTIP_CONTENTS..TitanUtils_GetColoredText("Disabled", u.ColorList[string.lower("red")]).."\n";
	end
end

	return TITAN_AUTOBUFF_TOOLTIP_CONTENTS;
	
end

function TitanPanelRightClickMenu_PrepareAutoBuffMenu()

	local info;
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_AUTOBUFF_ID].menuText);	
	
	info = {};
	info.text = TITAN_AUTOBUFF_ENABLE;
	info.func = AutoBuffToggle;
	info.checked = TitanAutoBuffStates.Enabled;
	UIDropDownMenu_AddButton(info); 
	
	TitanPanelRightClickMenu_AddSpacer();	
	
if (vClass == string.lower(AUTOBUFF_CLASS_WARLOCK) or vClass == string.lower(AUTOBUFF_CLASS_SHAMAN)) then
	info = {};
	info.text = TITAN_AUTOBUFF_WATER;
	info.func = AutoBuffWaterToggle;
	info.checked = TitanAutoBuffStates.Water;
	UIDropDownMenu_AddButton(info); 
end
	
if (vClass == string.lower(AUTOBUFF_CLASS_WARLOCK) or vClass == string.lower(AUTOBUFF_CLASS_PRIEST)) then
	info = {};
	info.text = TITAN_AUTOBUFF_TAP;
	info.func = AutoBuffTapToggle;
	info.checked = TitanAutoBuffStates.Tap;
	UIDropDownMenu_AddButton(info); 
end
	
if (vClass == string.lower(AUTOBUFF_CLASS_WARLOCK)) then
	info = {};
	info.text = TITAN_AUTOBUFF_SCALED;
	info.func = AutoBuffScaledToggle;
	info.checked = TitanAutoBuffStates.Scaled;
	UIDropDownMenu_AddButton(info); 
end
	
if (vClass == string.lower(AUTOBUFF_CLASS_PRIEST)) then
	info = {};
	info.text = TITAN_AUTOBUFF_INNER;
	info.func = AutoBuffInnerToggle;
	info.checked = TitanAutoBuffStates.Inner;
	UIDropDownMenu_AddButton(info); 
end

	TitanPanelRightClickMenu_AddSpacer();	
	
	info = {};
	info.text = TITAN_AUTOBUFF_BUTTONSHOW;
	info.func = AutoBuff_HideButton;
	info.checked = TitanAutoBuffStates.Button;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = TITAN_AUTOBUFF_BUTTONRESET;
	info.func = AutoBuff_ResetButton;
	info.checked = nil;
	UIDropDownMenu_AddButton(info);	
	
	TitanPanelRightClickMenu_AddSpacer();	
	
	info = {};
	info.text = TITAN_AUTOBUFF_DEBUG;
	info.func = AutoBuffDebug;
	info.checked = TitanAutoBuffStates.Debug;
	UIDropDownMenu_AddButton(info);
	
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_AUTOBUFF_ID, TITAN_PANEL_MENU_FUNC_HIDE);
	
end

-- Fubar Functions
function FuBarAutoBuff_OnLoad()

	AutoBuffFu = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0");
	local L = AceLibrary("AceLocale-2.0"):new("AutoBuffFu");
	local Dewdrop = AceLibrary("Dewdrop-2.0");
	local Tablet = AceLibrary("Tablet-2.0");

L:RegisterTranslations("enUS", function() return {
	["enable"] = TITAN_AUTOBUFF_ENABLE,
	["buttonshow"] = TITAN_AUTOBUFF_BUTTONSHOW,
	["buttonreset"] = TITAN_AUTOBUFF_BUTTONRESET,
	["debug"] = TITAN_AUTOBUFF_DEBUG,
	["water"] = TITAN_AUTOBUFF_WATER,
	["tap"] = TITAN_AUTOBUFF_TAP,
	["scaled"] = TITAN_AUTOBUFF_SCALED,
	["inner"] = TITAN_AUTOBUFF_INNER,
	["tablethint"] = "Left-Click for AutoBuff UI",
} end);

	AutoBuffFu:RegisterDB("AutoBuffFuDB");
	AutoBuffFu.hasNoText  = true;
	AutoBuffFu.hasIcon = true;
	AutoBuffFu.defaultPosition = "RIGHT";
	--AutoBuffFu.title = TITAN_AUTOBUFF_ID;
	AutoBuffFu.title = TITAN_AUTOBUFF_TOOLTIP; -- With Version number
	AutoBuffFu:SetIcon(TITAN_AUTOBUFF_ICON_ON..".tga");

	local optionsTable = {
		handler = AutoBuffFu,
		type = "Buffs",
		args = {};
	};

	AutoBuffFu.OnMenuRequest = optionsTable;

function AutoBuffFu:OnTooltipUpdate()

	-- Have been unable to get the tooltip to work, keeps erroring out with:
	-- Count: 5
	-- Error: ...rface\AddOns\AutoBuff\libs\Tablet-2.0\Tablet-2.0.lua:2265: attempt to index a nil value

	local cat = Tablet:AddCategory(
		'columns', 2
	);
	if (TitanAutoBuffStates.Enabled) then
	cat:AddLine(
		'text', L"enable",
		'textR', 1,
		'textG', 1,
		'textB', 0,
		'text2', "Enabled",
		'text2R', 0,
		'text2G', 1,
		'text2B', 0
	);
	else
	cat:AddLine(
		'text', L"enable",
		'textR', 1,
		'textG', 1,
		'textB', 0,
		'text2', "Disabled",
		'text2R', 1,
		'text2G', 0,
		'text2B', 0
	);
	end
	
	if (TitanAutoBuffStates.Debug) then
	cat:AddLine(
		'text', L"debug",
		'textR', 1,
		'textG', 1,
		'textB', 0,
		'text2', "Enabled",
		'text2R', 0,
		'text2G', 1,
		'text2B', 0
	);
	else
	cat:AddLine(
		'text', L"debug",
		'textR', 1,
		'textG', 1,
		'textB', 0,
		'text2', "Disabled",
		'text2R', 1,
		'text2G', 0,
		'text2B', 0
	);
	end

if (vClass == string.lower(AUTOBUFF_CLASS_WARLOCK) or vClass == string.lower(AUTOBUFF_CLASS_SHAMAN)) then
	if (TitanAutoBuffStates.Water) then
	cat:AddLine(
		'text', L"water",
		'textR', 1,
		'textG', 1,
		'textB', 0,
		'text2', "Enabled",
		'text2R', 0,
		'text2G', 1,
		'text2B', 0
	);
	else
	cat:AddLine(
		'text', L"water",
		'textR', 1,
		'textG', 1,
		'textB', 0,
		'text2', "Disabled",
		'text2R', 1,
		'text2G', 0,
		'text2B', 0
	);
	end
end

if (vClass == string.lower(AUTOBUFF_CLASS_WARLOCK) or vClass == string.lower(AUTOBUFF_CLASS_PRIEST)) then
	if (TitanAutoBuffStates.Tap) then
	cat:AddLine(
		'text', L"tap",
		'textR', 1,
		'textG', 1,
		'textB', 0,
		'text2', "Enabled",
		'text2R', 0,
		'text2G', 1,
		'text2B', 0
	);
	else
	cat:AddLine(
		'text', L"tap",
		'textR', 1,
		'textG', 1,
		'textB', 0,
		'text2', "Disabled",
		'text2R', 1,
		'text2G', 0,
		'text2B', 0
	);
	end
end

if (vClass == string.lower(AUTOBUFF_CLASS_WARLOCK)) then
	if (TitanAutoBuffStates.Scaled) then
	cat:AddLine(
		'text', L"scaled",
		'textR', 1,
		'textG', 1,
		'textB', 0,
		'text2', "Enabled",
		'text2R', 0,
		'text2G', 1,
		'text2B', 0
	);
	else
	cat:AddLine(
		'text', L"scaled",
		'textR', 1,
		'textG', 1,
		'textB', 0,
		'text2', "Disabled",
		'text2R', 1,
		'text2G', 0,
		'text2B', 0
	);
	end
end

if (vClass == string.lower(AUTOBUFF_CLASS_PRIEST)) then
	if (TitanAutoBuffStates.Inner) then
	cat:AddLine(
		'text', TITAN_AUTOBUFF_INNER,
		'textR', 1,
		'textG', 1,
		'textB', 0,
		'text2', "Enabled",
		'text2R', 0,
		'text2G', 1,
		'text2B', 0
	);
	else
	cat:AddLine(
		'text', TITAN_AUTOBUFF_INNER,
		'textR', 1,
		'textG', 1,
		'textB', 0,
		'text2', "Disabled",
		'text2R', 1,
		'text2G', 0,
		'text2B', 0
	);
	end
end

	cat:AddLine("text", "");

	Tablet:SetHint(L"tablethint");
end

function AutoBuffFu:OnMenuRequest(value)
		Dewdrop:AddLine(
			"text", TITAN_AUTOBUFF_ENABLE,
			"arg1", self,
			"func", AutoBuffToggle,
			"checked", TitanAutoBuffStates.Enabled
		);
		Dewdrop:AddLine(
			"text", ""
		);
if (vClass == string.lower(AUTOBUFF_CLASS_WARLOCK) or vClass == string.lower(AUTOBUFF_CLASS_SHAMAN)) then
		Dewdrop:AddLine(
			"text", TITAN_AUTOBUFF_WATER,
			"arg1", self,
			"func", AutoBuffWaterToggle,
			"checked", TitanAutoBuffStates.Water
		);
end
if (vClass == string.lower(AUTOBUFF_CLASS_WARLOCK) or vClass == string.lower(AUTOBUFF_CLASS_PRIEST)) then
		Dewdrop:AddLine(
			"text", TITAN_AUTOBUFF_TAP,
			"arg1", self,
			"func", AutoBuffTapToggle,
			"checked", TitanAutoBuffStates.Tap
		);
end
if (vClass == string.lower(AUTOBUFF_CLASS_WARLOCK)) then
		Dewdrop:AddLine(
			"text", TITAN_AUTOBUFF_SCALED,
			"arg1", self,
			"func", AutoBuffScaledToggle,
			"checked", TitanAutoBuffStates.Scaled
		);
end
if (vClass == string.lower(AUTOBUFF_CLASS_PRIEST)) then
		Dewdrop:AddLine(
			"text", TITAN_AUTOBUFF_INNER,
			"arg1", self,
			"func", AutoBuffInnerToggle,
			"checked", TitanAutoBuffStates.Inner
		);
end
		Dewdrop:AddLine(
			"text", ""
		);
		Dewdrop:AddLine(
			"text", TITAN_AUTOBUFF_BUTTONSHOW,
			"arg1", self,
			"func", AutoBuff_HideButton,
			"checked", TitanAutoBuffStates.Button
		);
		Dewdrop:AddLine(
			"text", TITAN_AUTOBUFF_BUTTONRESET,
			"arg1", self,
			"func", AutoBuff_ResetButton,
			"checked", nil
		);
		Dewdrop:AddLine(
			"text", ""
		);
		Dewdrop:AddLine(
			"text", TITAN_AUTOBUFF_DEBUG,
			"arg1", self,
			"func", AutoBuffDebug,
			"checked", TitanAutoBuffStates.Debug
		);

	Dewdrop:AddLine("text", "");
end

function AutoBuffFu:OnClick() -- Only reacts on "LeftButton"
	AutoBuffOptionsButton_OnClick("LeftButton");
end

end -- End prevention code wrap

-- Class declarations
-- Utility class provides print (to the chat box) and echo (displays over your character's head).
-- Instantiate it and use the colon syntax.
-- Color is an optional argument.  You can either use one of 7 named colors
-- "red", "green", "blue", "yellow", "cyan", "magenta", "white" or
-- a table with the r, g, b values.
-- IE foo:Print("some text", {r = 1.0, g=1.0, b=.5})

-- if there is an existing Utility Class version of equal or greater version, don't declare.
if not Utility_Class or (not Utility_Class.version) or (Utility_Class.version < 1.01) then
	Utility_Class = {};
	Utility_Class.version = 1.01
	function Utility_Class:New ()
		local o = {}   -- create object
		setmetatable(o, self)
		self.__index = self
		return o
	end
	
	function Utility_Class:Print(msg, color)
	local text;
	local r, g, b;
		if msg == nil then return; end
		if color == nil then color = "white"; end
		r, g, b = self.GetColor(color);
		
		if( DEFAULT_CHAT_FRAME ) then
			DEFAULT_CHAT_FRAME:AddMessage(msg,r,g,b);
		end
		
	end
	
	function Utility_Class:Echo(msg, color)
	local text;
	local r, g, b;
		if msg == nil then return; end
		if color == nil then color = "white"; end
		r, g, b = self.GetColor(color);
		
		UIErrorsFrame:AddMessage(msg, r, g, b, 1.0, UIERRORS_HOLD_TIME);
		
	end
	
	function Utility_Class:GetColor(color)
		if color == nil then color = self; end
		if color == nil then return 0, 0, 0 end
	
		if type(color) == "string" then 
			color = Utility_Class.ColorList[string.lower(color)];
		end
		
		if type(color) == "table" then
			if color.r == nil then color.r = 0.0 end
			if color.g == nil then color.g = 0.0 end
			if color.b == nil then color.g = 0.0 end
		else
			return 0, 0, 0 
		end
	
		if color.r < 0 then color.r = 0.0 end
		if color.g < 0 then color.g = 0.0 end
		if color.b < 0 then color.g = 0.0 end
	
		if color.r > 1 then color.r = 1.0 end
		if color.g > 1 then color.g = 1.0 end
		if color.b > 1 then color.g = 1.0 end
		
		return color.r, color.g, color.b
		
	end
	
	Utility_Class.ColorList = {}
	Utility_Class.ColorList["red"] = { r = 1.0, g = 0.0, b = 0.0 }
	Utility_Class.ColorList["green"] = { r = 0.0, g = 1.0, b = 0.0 }
	Utility_Class.ColorList["blue"] = { r = 0.0, g = 0.0, b = 1.0 }
	Utility_Class.ColorList["white"] = { r = 1.0, g = 1.0, b = 1.0 }
	Utility_Class.ColorList["magenta"] = { r = 1.0, g = 0.0, b = 1.0 }
	Utility_Class.ColorList["yellow"] = { r = 1.0, g = 1.0, b = 0.0 }
	Utility_Class.ColorList["cyan"] = { r = 0.0, g = 1.0, b = 1.0 }
	Utility_Class.ColorList["orange"] = { r = 1.0, g = 0.6, b = 0.0 }
end
