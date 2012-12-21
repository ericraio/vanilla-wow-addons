SHT_VERSION = "v1.6.11";

--Abilities-----------------------------------------
--Shots
SHT_AIMED_SHOT = "Aimed Shot";
SHT_CONC_SHOT = "Concussive Shot";
SHT_IMP_CONC = "Improved Concussive Shot";
SHT_IMP_CONC_SHORT = "Imp. Concussive Shot";
SHT_SCATTER = "Scatter Shot";
SHT_AUTO_SHOT = "Auto Shot";

--Buffs
SHT_HUNTERS_MARK = "Hunter's Mark";
SHT_RAPID_FIRE = "Rapid Fire";
SHT_QUICK_SHOTS = "Quick Shots";
SHT_EXPOSE_WEAKNESS = "Expose Weakness";
SHT_PRIMAL_BLESSING = "Primal Blessing";
SHT_BERSERKING = "Berserking";

--Trinkets
SHT_DEVILSAUR = "Devilsaur Eye";
SHT_DEVILSAUR_PROC = "Devilsaur Fury";
SHT_ZHM = "Zandalarian Hero Medallion";
SHT_ZHM_PROC = "Restless Strength";
SHT_EARTHSTRIKE = "Earthstrike";
SHT_SWARMGUARD = "Badge of the Swarmguard";
SHT_JOM_GABBAR = "Jom Gabbar";
SHT_KISS_SPIDER = "Kiss of the Spider";

--Pet Abilities
SHT_PET_INTIM = "Pet Intimidation";
SHT_INTIM = "Intimidation";
SHT_BW = "Bestial Wrath";

--Traps
SHT_TRAP = "Trap";
SHT_FROST_TRAP = "Frost Trap";
SHT_EXPL_TRAP = "Explosive Trap";
SHT_IMMO_TRAP = "Immolation Trap";
SHT_FREEZING_TRAP = "Freezing Trap";
SHT_ENTRAPMENT = "Entrapment";
SHT_AURA = "aura";
SHT_PRIMED = "primed";

--Melee Abilities
SHT_WING_CLIP = "Wing Clip";
SHT_IMP_WC = "Improved Wing Clip";
SHT_IMP_WC_SHORT = "Imp. Wing Clip";
SHT_COUNTER = "Counterattack";
SHT_DETERRENCE = "Deterrence";

--Stings
SHT_STING = "Sting";
SHT_WYVERN = "Wyvern Sting";
SHT_WYVERN_TEXT = "Wyvern Sting (Sleep)";
SHT_SERPENT = "Serpent Sting";
SHT_VIPER = "Viper Sting";
SHT_SCORPID = "Scorpid Sting";

--Other
SHT_FLARE = "Flare";
SHT_FEAR_BEAST = "Scare Beast";
SHT_YOUR = "Your ";
SHT_DONE = "Done!"
SHT_FEIGN_DEATH = "Feign Death";

--Enemies
SHT_FRENZY = "Frenzy";
SHT_FRENZY_EMOTE = "goes into a killing frenzy!";
SHT_FRENZY_FLAMEGOR = "goes into a frenzy!";
SHT_CHROMAGGUS = "Chromaggus";
SHT_FLAMEGOR = "Flamegor";
SHT_MAGMADAR = "Magmadar";
SHT_HUHURAN = "Princess Huhuran";
SHT_GLUTH = "Gluth";

--Messages
SHT_RESIST = "resisted";
SHT_IMMUNE = "immune";
SHT_EVADE = "evaded";
SHT_FADE = "fades";
SHT_FAILED = "failed";
SHT_HITS = "hits";
SHT_CRITS = "crits";
SHT_MISSES = "missed";

--Status Text---------------------------------------
SHT_ON = "on";
SHT_OFF = "off";
--Slash Text
SHT_SLASH_HELP = {
	[1] = "Sorren's Hunter Timers "..SHT_VERSION,
	[2] = "Commands: /sht",
	[3] = "/sht "..SHT_ON.."/"..SHT_OFF,
	[4] = "/sht menu (bring up the gui menu)",
	[5] = "/sht reset (resets all the visible bars)",
	[6] = "/sht resetpos (resets the bar frame position)",
	[7] = "/sht aimed "..SHT_ON.."/"..SHT_OFF.." (aimed shot casting bar)",
	[8] = "/sht delay <time> (time is in milliseconds)",
	[9] = "/sht aimeddelay <time> (time is in milliseconds)",
	[10] = "/sht flash <timeleft> (timeleft in seconds to flash the bar, 0 for off)",
	[11] = "/sht step <step> (higher step means faster flashing when time is low)",
	[12] = "/sht barcolor r g b (where r, g, b are between 0 and 1)",
	[13] = "/sht barendcolor r g b (where r, g, b are between 0 and 1)",
	[14] = "/sht setbgcolor r g b a (where r, g, b, a are between 0 and 10)",
	[15] = "/sht colorchange "..SHT_ON.."/"..SHT_OFF.." (color change feature)",
	[16] = "/sht up/down (cascade bars up or down)",
	[17] = "/sht scale % (/sht scale 100 = 100% scale)",
	[18] = "/sht lock/unlock (lock or unlock the frame)",
	[19] = "/sht status",
	[20] = "/sht clear all (resets all options to defaults)",
	[21] = "/sht debug (debug info for testing purposes)"
};
SHT_STATUS_STRINGS = {
	[1] = "|cFFFFFF00Sorren's Hunter Timers "..SHT_VERSION.."|r",
	[2] = "|cFFFFFF00Status:|r %s |cFFFFFF00Aimed Shot Casting Bar:|r %s",
	[3] = "|cFFFFFF00Shot delay:|r %dms |cFFFFFF00Aimed Shot delay:|r %dms", 
	[4] = "|cFFFFFF00Flash time:|r %ds |cFFFFFF00Step:|r %f",
	[5] = "|cFFFFFF00Barcolor:|r %s |cFFFFFF00Barcolorend:|r %s",
	[6] = "|cFFFFFF00Colorchange:|r %s |cFFFFFF00Growth:|r %s",
	[7] = "|cFFFFFF00Scale:|r %d%%"
};

SHT_OPTIONS_COLOR_CHANGE = "Color Change";
SHT_OPTIONS_MILI = "ms";
SHT_OPTIONS_LOCK = "Lock";
SHT_OPTIONS_BAR_DIST = "Distance Between Bars";
SHT_OPTIONS_SCALE = "Scale";
SHT_OPTIONS_FLASH = "Flash Time";
SHT_OPTIONS_STEP = "Flash Step";
SHT_OPTIONS_BARSTART = "Bar Start Color";
SHT_OPTIONS_BAREND = "Bar End Color";
SHT_OPTIONS_BACKDROP = "Backdrop Color";
SHT_OPTIONS_TIMERS_TEXT = "Timers";
SHT_OPTIONS_BARS_TEXT = "Bars";
SHT_OPTIONS_DECIMALS = "Decimals";
SHT_OPTIONS_AIMED_DELAY = "Aimed Delay";
SHT_OPTIONS_SHOT_DELAY = "Shot Delay";
SHT_OPTIONS_SHOW_TEX = "Show Textures";
SHT_OPTIONS_LARGE_TEX = "Large Textures";
SHT_OPTIONS_APPEND = "Append Target";
SHT_OPTIONS_BORDER = "Border Color";
SHT_OPTIONS_TEXT_COLOR = "Text Color";
SHT_OPTIONS_TIME_COLOR = "Time Color";
SHT_OPTIONS_TARGET_COLOR = "Target Text Color";
SHT_OPTIONS_OVERALL_OPACITY = "Overall Opacity";
SHT_OPTIONS_HIDE_TEXT = "Hide Text";
SHT_OPTIONS_HIDE_TIME = "Hide Time";
SHT_OPTIONS_HIDE_GAP = "Hide Gap";
SHT_OPTIONS_BAR_THICKNESS = "Bar Thickness";
SHT_OPTIONS_HIDE_PADDING = "Hide Padding";
SHT_OPTIONS_STICKY = "Sticky Auto Shot";
SHT_OPTIONS_DOWN = "Cascade Bars Down";

--Regular Expression Strings
SHT_TRAP_AFFLICT_STRING = "(.+) is afflicted by (.+ Trap)";
SHT_AFFLICT_STRING = "(.+) is afflicted by (.+)";
SHT_FAILED_STRING = "Your (.+) failed";
SHT_MISSES_STRING = "Your (.+) missed";
SHT_FIND_TRAP_FAILED = "'s (.+ Trap)";
SHT_FADE_STRING = "(.+) fades from (.+)%.";
SHT_SPELL_RANK_STRIP = "(.+)%(Rank %d+%)";
SHT_DIES = "(.+) dies";

--Options moved to globals because they dealt with other variables
