if( GetLocale() == "frFR" ) then
	--abilities-----------------------------------------
	--shots
	SHT_AIMED_SHOT = "Vis\195\169e";
	SHT_CONC_SHOT = "Trait de choc";
	SHT_IMP_CONC = "Trait de choc am\195\169lior\195\169";
	SHT_IMP_CONC_SHORT = "Trait de choc am\195\169lior\195\169";
	SHT_SCATTER = "Fl\195\168che de dispersion";
	SHT_AUTO_SHOT = "Tir automatique";
	
	--buffs
	SHT_HUNTERS_MARK = "Marque du chasseur";
	SHT_RAPID_FIRE = "Tir rapide";
	SHT_QUICK_SHOTS = "Tirs acc\195\169l\195\169r\195\169s";
	SHT_EXPOSE_WEAKNESS = "Perce-faille";
	SHT_PRIMAL_BLESSING = "B\195\169n\195\169diction primordiale";
	SHT_BERSERKING = "Berserker";

	--Trinkets
	SHT_DEVILSAUR = "Oeil de diablosaure";
	SHT_DEVILSAUR_PROC = "Fureur du diablosaure";
	SHT_ZHM = "M\195\169daillon de h\195\169ros zandalarien";
	SHT_ZHM_PROC = "Force inconstante";
	SHT_EARTHSTRIKE = "Choc de terre";
	SHT_SWARMGUARD = "Insigne de garde-essaim";
	SHT_JOM_GABBAR = "Jom Gabbar";
	SHT_KISS_SPIDER = "Baiser de l'araign\195\169e";

	--pet abilities
	SHT_PET_INTIM = "Pet Intimidation";
	SHT_INTIM = "Intimidation";
	SHT_BW = "Courroux bestial";
	
	--traps
	SHT_TRAP = "Pi\195\168ge";
	SHT_FROST_TRAP = "Pi\195\168ge de givre";
	SHT_EXPL_TRAP = "Pi\195\168ge explosif";
	SHT_IMMO_TRAP = "Pi\195\168ge immolation";
	SHT_FREEZING_TRAP = "Pi\195\168ge givrant";
	SHT_ENTRAPMENT = "Pi\195\168ge";
	SHT_AURA = "aura";
	SHT_PRIMED = "pos\195\169";
	
	--Melee abilities
	SHT_WING_CLIP = "Coupure d'ailes";
	SHT_IMP_WC = "Coupure d'ailes am\195\169lior\195\169e";
	SHT_IMP_WC_SHORT = "Imp. Wing Clip";
	SHT_COUNTER = "Contre-attaque";
	SHT_DETERRENCE = "Dissuasion";
	
	--Stings
	SHT_STING = "Morsure|Piq\195\187re";
	SHT_WYVERN = "Piq\195\187re de wyverne";
	SHT_WYVERN_TEXT = "Wyvern Sting (Sleep)";
	SHT_SERPENT = "Morsure de serpent";
	SHT_VIPER = "Morsure de vip\195\168re";
	SHT_SCORPID = "Piq\195\187re de scorpide";
	
	--other
	SHT_FLARE = "Fus\195\169e \195\169clairante";
	SHT_FEAR_BEAST = "Effrayer une b\195\170te";
	SHT_YOUR = "Votre ";
	SHT_DONE = "Fini!";
	SHT_FEIGN_DEATH = "Feindre la mort";
	
	--enemies
	SHT_FRENZY = "fr\195\169n\195\169sie";
	SHT_FRENZY_EMOTE = "rentre en fr\195\169n\195\169sie sanglante!";
	SHT_FRENZY_FLAMEGOR = "rentre en fr\195\169n\195\169sie!";
	SHT_CHROMAGGUS = "Chromaggus";
	SHT_FLAMEGOR = "Flamegor";
	SHT_MAGMADAR = "Magmadar";
	SHT_HUHURAN = "Princesse Huhuran";
	SHT_GLUTH = "Gluth";
	
	--messages
	SHT_RESIST = "r\195\169sis\195\169";
	SHT_IMMUNE = "immunis\195\169";
	SHT_EVADE = "\195\169vite";
	SHT_FADE = "vient de se dissiper";
	SHT_FAILED = "rat\195\169";
	SHT_HITS = "touche";
	SHT_CRITS = "critique";
	SHT_MISSES = "manque";
	
	--status text---------------------------------------
	SHT_ON = "on";
	SHT_OFF = "off";
	--Slash text
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
	
	--Regular Expression Strings
	SHT_TRAP_AFFLICT_STRING = "(.+) subit les effets de.+(Pi\195\168ge.+)";
	SHT_AFFLICT_STRING = "(.+) subit les effets de (.+)";
	SHT_FAILED_STRING = "Votre (.+) a \195\169chou\195\169";
	SHT_MISSES_STRING = "Votre (.+) a manqu\195\169 la cible";
	SHT_FIND_TRAP_FAILED = "'s.+(Pi\195\168ge.+)";
	SHT_FADE_STRING = "(.+) sur (.+) vient de se dissiper";
	SHT_SPELL_RANK_STRIP = "(.+) %(Rang %d+%)";
	SHT_DIES = "(.+) meurt";
	
	--Options moved to globals because they dealt with other variables
		
end
	
