if( GetLocale() == "deDE" ) then
	--abilities-----------------------------------------
	--shots
	SHT_AIMED_SHOT = "Gezielter Schuss";
	SHT_CONC_SHOT = "Ersch\195\188tternder Schuss";
	SHT_IMP_CONC = "Verbesserter Ersch\195\188tternder Schuss";
	SHT_IMP_CONC_SHORT = "Verb. Ersch\195\188tternder Schuss";
	SHT_SCATTER = "Streuschuss";
	SHT_AUTO_SHOT = "Autom. Schuss";
	
	--buffs
	SHT_HUNTERS_MARK = "Mal des J\195\164gers";
	SHT_RAPID_FIRE = "Schnellfeuer";
	SHT_QUICK_SHOTS = "Schnelle Sch\195\188sse";
	SHT_EXPOSE_WEAKNESS = "Schw\195\164che aufdecken";
	SHT_PRIMAL_BLESSING = "Ursegen";
	SHT_BERSERKING = "Berserker";

	--Trinkets
	SHT_DEVILSAUR = "Auge eines Teufelssauriers";
	SHT_DEVILSAUR_PROC = "Zorn des Teufelssauriers";
	SHT_ZHM = "Zandalarianisches Heldenmedallion";
	SHT_ZHM_PROC = "Ruhelose St\195\164rke";
	SHT_EARTHSTRIKE = "Erdschlag";
	SHT_SWARMGUARD = "Abzeichen der Schwarmwache";
	SHT_JOM_GABBAR = "Jom Gabbar";
	SHT_KISS_SPIDER = "Kuss der Spinne";

	--pet abilities
	SHT_PET_INTIM = "Tier Einsch\195\188chterung";
	SHT_INTIM = "Einsch\195\188chterung";
	SHT_BW = "Zorn des Wildtiers";
	
	--traps
	SHT_TRAP = "falle";
	SHT_FROST_TRAP = "Frostfalle";
	SHT_EXPL_TRAP = "Sprengfalle";
	SHT_IMMO_TRAP = "Feuerbrandfalle";
	SHT_FREEZING_TRAP = "Eisk\195\164ltefalle";
	SHT_ENTRAPMENT = "Einfangen";
	SHT_AURA = "-Aura";
	SHT_PRIMED = "gelegt";
	
	--Melee abilities
	SHT_WING_CLIP = "Zurechtstutzen";
	SHT_IMP_WC = "Verbessertes Zurechtstutzen";
	SHT_IMP_WC_SHORT = "Verb. Zurechtstutzen";
	SHT_COUNTER = "Gegenangriff";
	SHT_DETERRENCE = "Abschreckung";
	
	--Stings
	SHT_STING = "biss|stich|Stich";
	-- needs to be "biss" or "stich" or "Stich"
	SHT_WYVERN = "Stich des Fl\195\188geldrachen";
	SHT_WYVERN_TEXT = "Stich des Fl\195\188geldrachen (Schlaf)";
	SHT_SERPENT = "Schlangenbiss";
	SHT_VIPER = "Vipernbiss";
	SHT_SCORPID = "Skorpidstich";
	
	--other
	SHT_FLARE = "Leuchtfeuer";
	SHT_FEAR_BEAST = "Wildtier \195\164ngstigen";
	SHT_YOUR = "";
	SHT_DONE = "Fertig!"
	SHT_FEIGN_DEATH = "Totstellen";
	
	--enemies
	SHT_FRENZY = "Raserei";
	SHT_FRENZY_EMOTE = "ger\195\164t in t\195\182dliche Raserei!";
	SHT_FRENZY_FLAMEGOR = "ger\195\164t in Raserei!";
	SHT_CHROMAGGUS = "Chromaggus";
	SHT_FLAMEGOR = "Flammenmaul";
	SHT_MAGMADAR = "Magmadar";
	SHT_HUHURAN = "Prinzessin Huhuran";
	SHT_GLUTH = "Gluth";
	
	--messages
	SHT_RESIST = "widerstanden";
	SHT_IMMUNE = "immun";
	SHT_EVADE = "ausgewichen";
	SHT_FADE = "schwindet";
	SHT_FAILED = "scheitert";
	SHT_HITS = "trifft";
	SHT_CRITS = "kritisch";
	SHT_MISSES = "verfehlt";
	
	--status text---------------------------------------
	SHT_ON = "an";
	SHT_OFF = "aus";
	--Slash text
	SHT_SLASH_HELP = {
		[1] = "Sorren's Hunter Timers "..SHT_VERSION,
		[2] = "Befehle: /sht",
		[3] = "/sht "..SHT_ON.."/"..SHT_OFF,
		[4] = "/sht menu (zeigt das SHT Men\195\188)",
		[5] = "/sht reset (resets all the visible bars)",
		[6] = "/sht resetpos (resets the bar frame position)",
		[7] = "/sht aimed "..SHT_ON.."/"..SHT_OFF.." (schaltet Zauberleiste an/aus)",
		[8] = "/sht delay <Zeit> (Zeit in Milisekunden f\195\188r Lagverz\195\182gerung)",
		[9] = "/sht aimeddelay <time> (time is in milliseconds)",
		[10] = "/sht flash <Zeit> (\195\188brige Zeit in Sekunden, ab der die Leiste blinkt, 0 f\195\188r Aus)",
		[11] = "/sht step <Schritt> (Gr\195\182ssere Schritte bedeutet schnelleres Blinken wenn Zeit abl\195\164uft)",
		[12] = "/sht barcolor r g b (Leistenfarbe, r, g, b Werte zwischen 0 und 1)",
		[13] = "/sht barendcolor r g b (Leisten-Endfarbe, r, g, b Werte zwischen 0 und 1)",
		[14] = "/sht setbgcolor r g b a (Hintergrundfarbe, r, g, b, a Werte zwischen 0 und 10)",
		[15] = "/sht colorchange "..SHT_ON.."/"..SHT_OFF.." (color change feature)",
		[16] = "/sht up/down (cascade bars up or down)",
		[17] = "/sht scale % (/sht scale 100 = 100% Skalierung)",
		[18] = "/sht lock/unlock (lock or unlock the frame)",
		[19] = "/sht status",
		[20] = "/sht clear all (resets all options to defaults)",
		[21] = "/sht debug (debug info for testing purposes)"
	};
	SHT_STATUS_STRINGS = {
		[1] = "|cFFFFFF00Sorren's Hunter Timers "..SHT_VERSION.."|r",
		[2] = "|cFFFFFF00Status:|r %s |cFFFFFF00Gezielter Schuss Zauberleiste:|r %s",
		[3] = "|cFFFFFF00Schuss Verz\195\182gerung:|r %dms |cFFFFFF00Gezielter Schuss Verz\195\182gerung:|r %dms", 
		[4] = "|cFFFFFF00Flash time:|r %ds |cFFFFFF00Step:|r %f",
		[5] = "|cFFFFFF00Leistenfarbe:|r %s |cFFFFFF00Leisten-Endfarbe:|r %s",
		[6] = "|cFFFFFF00Farb\195\164nderung:|r %s |cFFFFFF00Vergr\195\182sserung:|r %s",
		[7] = "|cFFFFFF00Skalierung:|r %d%%"
	};
	
	SHT_OPTIONS_COLOR_CHANGE = "Farb\195\164nderung";
	SHT_OPTIONS_MILI = "ms";
	SHT_OPTIONS_LOCK = "Sperren";
	SHT_OPTIONS_BAR_DIST = "Abstand zwischen Leisten";
	SHT_OPTIONS_SCALE = "Skalierung";
	SHT_OPTIONS_FLASH = "Blink Zeit";
	SHT_OPTIONS_STEP = "Blink Schritte";
	SHT_OPTIONS_BARSTART = "Leiste Anfangsfarbe";
	SHT_OPTIONS_BAREND = "Leiste Endfarbe";
	SHT_OPTIONS_BACKDROP = "Hintergrundfarbe";
	SHT_OPTIONS_TIMERS_TEXT = "Timer";
	SHT_OPTIONS_BARS_TEXT = "Leisten";
	SHT_OPTIONS_DECIMALS = "Dezimalstellen";
	SHT_OPTIONS_AIMED_DELAY = "Gez. Schuss Verz\195\182gerung";
	SHT_OPTIONS_SHOT_DELAY = "Schuss Verz\195\182gerung";
	SHT_OPTIONS_SHOW_TEX = "Zeige Texturen";
	SHT_OPTIONS_LARGE_TEX = "Grosse Texturen";
	SHT_OPTIONS_APPEND = "Ziel anh\195\164ngen";
	SHT_OPTIONS_BORDER = "Rahmenfarbe";
	SHT_OPTIONS_TEXT_COLOR = "Text Farbe";
	SHT_OPTIONS_TIME_COLOR = "Zeit Farbe";
	SHT_OPTIONS_TARGET_COLOR = "Ziel Text Farbe";
	SHT_OPTIONS_OVERALL_OPACITY = "Durchsichtigkeit";
	SHT_OPTIONS_HIDE_TEXT = "Verstecke Text";
	SHT_OPTIONS_HIDE_TIME = "Verstecke Zeit";
	SHT_OPTIONS_HIDE_GAP = "Verstecke L\195\188cke";
	SHT_OPTIONS_BAR_THICKNESS = "Leistendicke";
	SHT_OPTIONS_HIDE_PADDING = "Verstecke Padding";
	SHT_OPTIONS_STICKY = "Sticky Auto Shot";
	
	--Regular Expression Strings
	SHT_TRAP_AFFLICT_STRING = "(.+) ist von (.+falle) betroffen";
	SHT_AFFLICT_STRING = "(.+) ist von (.+) betroffen";
	SHT_FAILED_STRING = "Ihr scheitert beim Wirken von (.+)"; -- kA wo das benutzt wird
	SHT_MISSES_STRING = "(.+) hat %a+ verfehlt"; -- auch kA wofür das ist ;)
	SHT_FIND_TRAP_FAILED = "s (.+falle) wurde"; -- Muss ich noch testen...
	SHT_FADE_STRING = "(.+) schwindet von (.+)%.";
	SHT_SPELL_RANK_STRIP = "(.+)%(Rang %d+%)"; -- Für Aimed Shot Casting Bar
	SHT_DIES = "(.+) stirbt";
	-- Beutju
	
	--Options moved to globals because they dealt with other variables
		
end
	
