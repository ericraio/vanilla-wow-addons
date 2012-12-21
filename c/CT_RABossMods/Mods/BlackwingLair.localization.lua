-- Vaelastrasz
CT_RABOSS_VAEL_BURNINGWARNTELL 		= "YOU ARE BURNING!";
CT_RABOSS_VAEL_TELL_TARGET			= "Send tells to targets";
CT_RABOSS_VAEL_TELL_TARGET_INFO		= "Sends a tell to players that are affected with Burning Adrenaline";

-- Firemaw
CT_RABOSS_FIREMAW_BUFFET		= "Firemaw begins to cast Wing Buffet.";
CT_RABOSS_FIREMAW_BUFFET_INFO		= "Displays a warning when Firemaw begins to cast Wing Buffet.";
CT_RABOSS_FIREMAW_BUFFET_WARN		= "** Firemaw begins to cast Wing buffet. **";
CT_RABOSS_FIREMAW_3SECWARN		= "** 3 Seconds before Firemaw casts Wing buffet. **";
CT_RABOSS_FIREMAW_30SECWARN		= "** 30 Secnds till next Wing buffet. **";
CT_RABOSS_FIREMAW_SHADOWFLAME_WARN	= "** Shadow Flame Incoming! **";

CT_RABOSS_FIREMAW_SHADOWFLAMETEST	= "charges!"
CT_RABOSS_FIREMAW_SHADOWFLAME_DETECT	= "Firemaw begins to cast Shadow Flame.";

-- Ebonroc
CT_RABOSS_EBONROC_BUFFET			= "Ebonroc begins to cast Wing Buffet.";
CT_RABOSS_EBONROC_BUFFET_INFO		= "Displays to the raid when Ebonroc casts Flame Buffet and Shadowflame.";
CT_RABOSS_EBONROC_BUFFET_WARN		= "** Ebonroc begins to cast Wing buffet. **";
CT_RABOSS_EBONROC_3SECWARN		= "** 3 Seconds before Ebonroc casts Wing buffet. **";
CT_RABOSS_EBONROC_30SECWARN		= "** 30 Secnds till next Wing buffet. **";
CT_RABOSS_EBONROC_SHADOWFLAME_WARN	= "** Shadow Flame Incoming! **";

CT_RABOSS_EBONROC_SHADOWFLAME_DETECT	= "Ebonroc begins to cast Shadow Flame.";

CT_RABOSS_EBONROC_AFFLICT_BOMB 		= "^([^%s]+) ([^%s]+) afflicted by Shadow of Ebonroc";
CT_RABOSS_EBONROC_AFFLICT_SELF_MATCH1	= "You";
CT_RABOSS_EBONROC_AFFLICT_SELF_MATCH2	= "are";
CT_RABOSS_EBONROC_SOEOTHER = "*** %s HAS SHADOW OF EBONROC ***";
CT_RABOSS_EBONROC_SOEYOU = "*** YOU HAVE SHADOW OF EBONROC ***";

-- Flamegor
CT_RABOSS_FLAMEGOR_BUFFET			= "Flamegor begins to cast Wing Buffet.";
CT_RABOSS_FLAMEGOR_BUFFET_INFO		= "Displays to the raid when Flamegor casts Flame Buffet and Shadowflame.";
CT_RABOSS_FLAMEGOR_BUFFET_WARN		= "** Flamegor begins to cast Wing buffet. **";
CT_RABOSS_FLAMEGOR_3SECWARN		= "** 3 Seconds before Flamegor casts Wing buffet. **";
CT_RABOSS_FLAMEGOR_30SECWARN		= "** 30 Secnds till next Wing buffet. **";
CT_RABOSS_FLAMEGOR_SHADOWFLAME_WARN	= "** Shadow Flame Incoming! **";
CT_RABOSS_FLAMEGOR_TRANQSHOT		= "*** FRENZY ALERT - HUNTER TRANQ SHOT NOW! ***";

CT_RABOSS_FLAMEGOR_SHADOWFLAME_DETECT	= "Flamegor begins to cast Shadow Flame.";
CT_RABOSS_FLAMEGOR_FRENZY 			= "%s goes into a frenzy!";

-- Chromaggus
	-- General Info
CT_RABOSS_CHROMAGGUS_BOSSNAME = "Chromaggus";
CT_RABOSS_CHROMAGGUS_DESC = "Provides a warning when Chromaggus uses its breaths."
	-- Different Warnings
CT_RABOSS_CHROMAGGUS_BREATHWARNING = "Breath Warning";
CT_RABOSS_CHROMAGGUS_BREATHWARNING_INFO = "Warn 7 seconds before a breath is cast.";
CT_RABOSS_CHROMAGGUS_CASTWARNING = "Breath Casting Warning";
CT_RABOSS_CHROMAGGUS_CASTWARNING_INFO = "Warn when a breath is casting.";
CT_RABOSS_CHROMAGGUS_FRENZYWARNING = "Frenzy Warning";
CT_RABOSS_CHROMAGGUS_FRENZYWARNING_INFO = "Warn when Chromaggus gains Frenzy.";
CT_RABOSS_CHROMAGGUS_SHIELDWARNING = "Elemental Shield Warning";
CT_RABOSS_CHROMAGGUS_SHIELDWARNING_INFO = "Warns when Chromaggus's Elemental Shield changes spell schools.";
	-- String Matches
CT_RABOSS_CHROMAGGUS_BREATHCASTSTRING = "^Chromaggus begins to cast ([%w ]+)\.";
CT_RABOSS_CHROMAGGUS_SPELLDAMAGESTRING = "^[%w']+ [%w' ]+ ([%w]+) Chromaggus for ([%d]+) ([%w ]+) damage%..*";
CT_RABOSS_CHROMAGGUS_TIMELAPSERESIST = "Chromaggus's Time Lapse was resisted by ([%w]+)%.";
	-- Warning Messages
CT_RABOSS_CHROMAGGUS_BREATH10SECWARNING = "*** %s IN 10 SECONDS ***";
CT_RABOSS_CHROMAGGUS_BREATHCASTINGWARNING = "*** %s IS CASTING ***";
CT_RABOSS_CHROMAGGUS_NEWVULNERABILITYFOUNDWARNING = "*** NEW SPELL VULNERABILITY: %s ***";
CT_RABOSS_CHROMAGGUS_NEWVULNERABILITYWARNING = "*** SPELL VULNERABILITY CHANGED ***";
CT_RABOSS_CHROMAGGUS_FRENZYCASTWARNING = "*** FRENZY - TRANQ SHOT ***";
	-- Emotes
CT_RABOSS_CHROMAGGUS_FRENZYEMOTE = "%s goes into a killing frenzy!";
CT_RABOSS_CHROMAGGUS_SHIELDEMOTE = "%s flinches as its skin shimmers.";
	-- Constants
CT_RABOSS_CHROMAGGUS_WAITSHIELDCLEAR = 2.5;
CT_RABOSS_CHROMAGGUS_BREATHWARNINGTIME = 50;
CT_RABOSS_CHROMAGGUS_BREATHINTERVAL = 30;
CT_RABOSS_CHROMAGGUS_COMBATLIMIT = 60;
CT_RABOSS_CHROMAGGUS_ELEMENTALSHIELDLIMIT_HIT = 550;
CT_RABOSS_CHROMAGGUS_ELEMENTALSHIELDLIMIT_CRIT = 1100;
CT_RABOSS_CHROMAGGUS_HIT = "hits";
CT_RABOSS_CHROMAGGUS_CRIT = "crits";

--[[

CT_RABOSS_CHROMAGGUS_CAST_MASK = "^Chromaggus begins to cast ([%w ]+)\.";
CT_RABOSS_CHROMAGGUS_FRENZY_STR = "Chromaggus gains Frenzy.";
CT_RABOSS_CHROMAGGUS_CHROMAGGUS_STR = "Chromaggus";
CT_RABOSS_CHROMAGGUS_SHIELDCHG_STR = "flinches as its skin shimmers.";
CT_RABOSS_CHROMAGGUS_DMGDONE_MASK = "^[%w']+ [%w' ]+ ([%w]+) Chromaggus for ([%d]+) ([%w ]+) damage\..*";
CT_RABOSS_CHROMAGGUS_HITS_STR = "hits";
CT_RABOSS_CHROMAGGUS_CRITS_STR = "crits";

CT_RABOSS_CHROMAGGUS_FRENZY_ALERTMSG = "*** FRENZY ALERT, USE TRANQ SHOT ***";
CT_RABOSS_CHROMAGGUS_SHIELD_ALERTMSG = "*** ELEMENTAL SHIELD CHANGED SPELL SCHOOL ***";

CT_RABOSS_CHROMAGGUS_COMBAT_LIMIT = 60; -- Time before we wipe combat state because we think combat exited
CT_RABOSS_CHROMAGGUS_BREATH_WARNING_TIME = 53; -- Scheduling time for breath warning events
CT_RABOSS_CHROMAGGUS_BREATH_INTERVAL = 30; -- Time between breaths
CT_RABOSS_CHROMAGGUS_ELEMENTAL_SHIELD_LIMIT = 325; -- Min damage for attack to consider elemental shield for that school.
]]

-- Nefarian
CT_RABOSS_NEFARIAN_INFO			= "Displays phase 2 and 3 transitions, fears, and what class Nefarian is yelling at.";

CT_RABOSS_NEFARIAN_LAND_20SEC_DETECT	= "Well done, my minions";
CT_RABOSS_NEFARIAN_LAND_20SEC		= "*** Nefarian landing in 10 seconds ***";

CT_RABOSS_NEFARIAN_LANDING_DETECT	= "BURN! You wretches";
CT_RABOSS_NEFARIAN_LANDING		= "*** Nefarian is landing ***";

CT_RABOSS_NEFARIAN_ZERG_DETECT		= "Impossible! Rise my";
CT_RABOSS_NEFARIAN_ZERG			= "*** Zerg Incoming ***";

CT_RABOSS_NEFARIAN_FEAR_WARN		= "*** FEAR IN 2 SECONDS ***"
CT_RABOSS_NEFARIAN_FEAR_DETECT		= "Nefarian begins to cast Bellowing Roar"

CT_RABOSS_NEFARIAN_SHADOWFLAME_DETECT	= "Nefarian begins to cast Shadow Flame";
CT_RABOSS_NEFARIAN_SHADOWFLAME_WARN	= "** Shadow Flame Incoming! **";

CT_RABOSS_NEFARIAN_SHAMAN_CALL		= "Shamans, show me";
CT_RABOSS_NEFARIAN_DRUID_CALL		= "Druids and your silly";
CT_RABOSS_NEFARIAN_WARLOCK_CALL		= "Warlocks, you shouldn't be playing";
CT_RABOSS_NEFARIAN_PRIEST_CALL		= "Priests! If you're going to keep";
CT_RABOSS_NEFARIAN_HUNTER_CALL		= "Hunters and your annoying";
CT_RABOSS_NEFARIAN_WARRIOR_CALL		= "Warriors, I know you can hit harder";
CT_RABOSS_NEFARIAN_ROGUE_CALL		= "Rogues%? Stop hiding";
CT_RABOSS_NEFARIAN_PALADIN_CALL		= "Paladins";
CT_RABOSS_NEFARIAN_MAGE_CALL		= "Mages too%?";

CT_RABOSS_NEFARIAN_SHAMAN_ALERT		= "*** Shamans - Totems spawned ***";
CT_RABOSS_NEFARIAN_DRUID_ALERT		= "*** Druids - Stuck in cat form ***";
CT_RABOSS_NEFARIAN_WARLOCK_ALERT	= "*** Warlocks - Incoming Infernals ***";
CT_RABOSS_NEFARIAN_PRIEST_ALERT		= "*** Priests - Stop Healing ***";
CT_RABOSS_NEFARIAN_HUNTER_ALERT		= "*** Hunters - Bows/Guns broken ***";
CT_RABOSS_NEFARIAN_WARRIOR_ALERT	= "*** Warriors - Stuck in berserking stance ***";
CT_RABOSS_NEFARIAN_ROGUE_ALERT		= "*** Rogues - Ported and rooted ***";
CT_RABOSS_NEFARIAN_PALADIN_ALERT	= "*** Paladins - Blessing of Protection ***";
CT_RABOSS_NEFARIAN_MAGE_ALERT		= "*** Mages - Incoming polymorphs ***";
CT_RABOSS_NEFARIAN_5SECCALLWARNING  = "*** CLASS CALL INC ***";

if ( GetLocale() == "deDE" ) then
	-- Vaelastrasz
	CT_RABOSS_VAEL_AFFLICT_BURN			=  "^([^%s]+) ([^%s]+) von Brennendes Adrenalin betroffen";
	CT_RABOSS_VAEL_AFFLICT_SELF_MATCH1  =  "Ihr";
	CT_RABOSS_VAEL_AFFLICT_SELF_MATCH2  =  "seid";
	CT_RABOSS_VAEL_BURNINGWARNTELL 		= "YOU ARE BURNING!";
	CT_RABOSS_VAEL_TELL_TARGET			= "Send tells to targets";
	CT_RABOSS_VAEL_TELL_TARGET_INFO		= "Sends a tell to players that are affected with Burning Adrenaline";
	
	-- Firemaw
	CT_RABOSS_FIREMAW_BUFFET		= "Firemaw beginnt Fl\195\188gelpuffer zu wirken.";
	CT_RABOSS_FIREMAW_BUFFET_INFO		= "Displays a warning when Firemaw begins to cast Wing Buffet.";
	CT_RABOSS_FIREMAW_BUFFET_WARN		= "** Firemaw begins to cast Wing buffet. **";
	CT_RABOSS_FIREMAW_3SECWARN		= "** 3 Seconds before Firemaw casts Wing buffet. **";
	CT_RABOSS_FIREMAW_30SECWARN		= "** 30 Secnds till next Wing buffet. **";
	CT_RABOSS_FIREMAW_SHADOWFLAME_WARN	= "** Shadow Flame Incoming! **";
	
	CT_RABOSS_FIREMAW_SHADOWFLAMETEST	= "charges!"
	CT_RABOSS_FIREMAW_SHADOWFLAME_DETECT	= "Firemaw beginnt Schattenflamme zu wirken.";
	
	-- Ebonroc
	CT_RABOSS_EBONROC_BUFFET			= "Ebonroc beginnt Fl\195\188gelpuffer zu wirken.";
	CT_RABOSS_EBONROC_BUFFET_INFO		= "Displays to the raid when Ebonroc casts Flame Buffet and Shadowflame.";
	CT_RABOSS_EBONROC_BUFFET_WARN		= "** Ebonroc begins to cast Wing buffet. **";
	CT_RABOSS_EBONROC_3SECWARN		= "** 3 Seconds before Ebonroc casts Wing buffet. **";
	CT_RABOSS_EBONROC_30SECWARN		= "** 30 Secnds till next Wing buffet. **";
	CT_RABOSS_EBONROC_SHADOWFLAME_WARN	= "** Shadow Flame Incoming! **";
	
	CT_RABOSS_EBONROC_SHADOWFLAME_DETECT	= "Ebonroc beginnt Schattenflamme zu wirken.";
	
	CT_RABOSS_EBONROC_AFFLICT_BOMB 		= "^([^%s]+) ([^%s]+) ist von Ebonroc-Schatten betroffen.";
	CT_RABOSS_EBONROC_AFFLICT_SELF_MATCH1	= "Ihr";
	CT_RABOSS_EBONROC_AFFLICT_SELF_MATCH2	= "seid";
	CT_RABOSS_EBONROC_SOEOTHER = "*** %s HAS SHADOW OF EBONROC ***";
	CT_RABOSS_EBONROC_SOEYOU = "*** YOU HAVE SHADOW OF EBONROC ***";
	
	-- Flamegor
	CT_RABOSS_FLAMEGOR_BUFFET			= "Flamegor beginnt Fl\195\188gelpuffer zu wirken.";
	CT_RABOSS_FLAMEGOR_BUFFET_INFO		= "Displays to the raid when Flamegor casts Flame Buffet and Shadowflame.";
	CT_RABOSS_FLAMEGOR_BUFFET_WARN		= "** Flamegor begins to cast Wing buffet. **";
	CT_RABOSS_FLAMEGOR_3SECWARN		= "** 3 Seconds before Flamegor casts Wing buffet. **";
	CT_RABOSS_FLAMEGOR_30SECWARN		= "** 30 Secnds till next Wing buffet. **";
	CT_RABOSS_FLAMEGOR_SHADOWFLAME_WARN	= "** Shadow Flame Incoming! **";
	CT_RABOSS_FLAMEGOR_TRANQSHOT		= "*** FRENZY ALERT - HUNTER TRANQ SHOT NOW! ***";
	
	CT_RABOSS_FLAMEGOR_SHADOWFLAME_DETECT	= "Flamegor beginnt Schattenflamme zu wirken.";
	CT_RABOSS_FLAMEGOR_FRENZY 			= "ger\195\164t in Raserei!";
	
	-- Chromaggus
		-- General Info
	CT_RABOSS_CHROMAGGUS_BOSSNAME = "Chromaggus";
	CT_RABOSS_CHROMAGGUS_DESC = "Provides a warning when Chromaggus uses its breaths."
		-- Different Warnings
	CT_RABOSS_CHROMAGGUS_BREATHWARNING = "Breath Warning";
	CT_RABOSS_CHROMAGGUS_BREATHWARNING_INFO = "Warn 7 seconds before a breath is cast.";
	CT_RABOSS_CHROMAGGUS_CASTWARNING = "Breath Casting Warning";
	CT_RABOSS_CHROMAGGUS_CASTWARNING_INFO = "Warn when a breath is casting.";
	CT_RABOSS_CHROMAGGUS_FRENZYWARNING = "Frenzy Warning";
	CT_RABOSS_CHROMAGGUS_FRENZYWARNING_INFO = "Warn when Chromaggus gains Frenzy.";
	CT_RABOSS_CHROMAGGUS_SHIELDWARNING = "Elemental Shield Warning";
	CT_RABOSS_CHROMAGGUS_SHIELDWARNING_INFO = "Warns when Chromaggus's Elemental Shield changes spell schools.";
		-- String Matches
	CT_RABOSS_CHROMAGGUS_BREATHCASTSTRING = "^Chromaggus beginnt ([%w ]+)\ zu wirken.";
	CT_RABOSS_CHROMAGGUS_SPELLDAMAGESTRING = "^[%w']+ [%w' ]+ ([%w]+) Chromaggus for ([%d]+) ([%w ]+) damage%..*";
	CT_RABOSS_CHROMAGGUS_TIMELAPSERESIST = "Chromagguss Zeitraffer wurde von ([%w]+)% wiederstanden.";
		-- Warning Messages
	CT_RABOSS_CHROMAGGUS_BREATH10SECWARNING = "*** %s IN 10 SECONDS ***";
	CT_RABOSS_CHROMAGGUS_BREATHCASTINGWARNING = "*** %s IS CASTING ***";
	CT_RABOSS_CHROMAGGUS_NEWVULNERABILITYFOUNDWARNING = "*** NEW SPELL VULNERABILITY: %s ***";
	CT_RABOSS_CHROMAGGUS_NEWVULNERABILITYWARNING = "*** SPELL VULNERABILITY CHANGED ***";
	CT_RABOSS_CHROMAGGUS_FRENZYCASTWARNING = "*** FRENZY - TRANQ SHOT ***";
		-- Emotes
	CT_RABOSS_CHROMAGGUS_FRENZYEMOTE = "Chromaggus ger\195\164t in t\195\182dliche Raserei!";
	CT_RABOSS_CHROMAGGUS_SHIELDEMOTE = "als die Haut schimmert";
		-- Constants
	CT_RABOSS_CHROMAGGUS_WAITSHIELDCLEAR = 2.5;
	CT_RABOSS_CHROMAGGUS_BREATHWARNINGTIME = 50;
	CT_RABOSS_CHROMAGGUS_BREATHINTERVAL = 30;
	CT_RABOSS_CHROMAGGUS_COMBATLIMIT = 60;
	CT_RABOSS_CHROMAGGUS_ELEMENTALSHIELDLIMIT_HIT = 550;
	CT_RABOSS_CHROMAGGUS_ELEMENTALSHIELDLIMIT_CRIT = 1100;
	CT_RABOSS_CHROMAGGUS_HIT = "hits";
	CT_RABOSS_CHROMAGGUS_CRIT = "crits";
	
	--[[
	
	CT_RABOSS_CHROMAGGUS_CAST_MASK = "^Chromaggus begins to cast ([%w ]+)\.";
	CT_RABOSS_CHROMAGGUS_FRENZY_STR = "Chromaggus gains Frenzy.";
	CT_RABOSS_CHROMAGGUS_CHROMAGGUS_STR = "Chromaggus";
	CT_RABOSS_CHROMAGGUS_SHIELDCHG_STR = "flinches as its skin shimmers.";
	CT_RABOSS_CHROMAGGUS_DMGDONE_MASK = "^[%w']+ [%w' ]+ ([%w]+) Chromaggus for ([%d]+) ([%w ]+) damage\..*";
	CT_RABOSS_CHROMAGGUS_HITS_STR = "hits";
	CT_RABOSS_CHROMAGGUS_CRITS_STR = "crits";
	
	CT_RABOSS_CHROMAGGUS_FRENZY_ALERTMSG = "*** FRENZY ALERT, USE TRANQ SHOT ***";
	CT_RABOSS_CHROMAGGUS_SHIELD_ALERTMSG = "*** ELEMENTAL SHIELD CHANGED SPELL SCHOOL ***";
	
	CT_RABOSS_CHROMAGGUS_COMBAT_LIMIT = 60; -- Time before we wipe combat state because we think combat exited
	CT_RABOSS_CHROMAGGUS_BREATH_WARNING_TIME = 53; -- Scheduling time for breath warning events
	CT_RABOSS_CHROMAGGUS_BREATH_INTERVAL = 30; -- Time between breaths
	CT_RABOSS_CHROMAGGUS_ELEMENTAL_SHIELD_LIMIT = 325; -- Min damage for attack to consider elemental shield for that school.
	]]
	
	CT_RABOSS_NEFARIAN_INFO			= "Displays phase 2 and 3 transitions, fears, and what class Nefarian is yelling at.";
	
	CT_RABOSS_NEFARIAN_LAND_20SEC_DETECT	= "Sehr gut, meine Diener";
	CT_RABOSS_NEFARIAN_LAND_20SEC		= "*** Nefarian landet in 20 Sekunden ***";
	
	CT_RABOSS_NEFARIAN_LANDING_DETECT	= "BRENNT! Ihr Elenden";
	CT_RABOSS_NEFARIAN_LANDING		= "*** Nefarian landet ***";
	
	CT_RABOSS_NEFARIAN_ZERG_DETECT		= "Erhebt euch meine Diener";
	CT_RABOSS_NEFARIAN_ZERG			= "*** Zerg Incoming ***";
	
	CT_RABOSS_NEFARIAN_FEAR_WARN		= "Fear in 2 seconds"
	CT_RABOSS_NEFARIAN_FEAR_DETECT		= "Nefarian beginnt Dr\195\182hnendes Gebr\195\188ll zu wirken"
	
	CT_RABOSS_NEFARIAN_SHADOWFLAME_DETECT	= "Nefarian beginnt Schattenflamme zu wirken";
	CT_RABOSS_NEFARIAN_SHADOWFLAME_WARN	= "** Shadow Flame Incoming! **";
	
	CT_RABOSS_NEFARIAN_SHAMAN_CALL		= "Schamanen";
	CT_RABOSS_NEFARIAN_DRUID_CALL		= "Druiden und ihre l\195\164cherliche";
	CT_RABOSS_NEFARIAN_WARLOCK_CALL		= "Hexenmeister, Ihr sollt nicht mit Magie";
	CT_RABOSS_NEFARIAN_PRIEST_CALL		= "Priester! Wenn Ihr weiterhin";
	CT_RABOSS_NEFARIAN_HUNTER_CALL		= "J\195\164ger und ihre l\195\164stigen";
	CT_RABOSS_NEFARIAN_WARRIOR_CALL		= "Krieger, Ich bin mir";
	CT_RABOSS_NEFARIAN_ROGUE_CALL		= "Schurken? Kommt aus";
	CT_RABOSS_NEFARIAN_PALADIN_CALL		= "Paladine";
	CT_RABOSS_NEFARIAN_MAGE_CALL		= "Auch Magier";
	
	CT_RABOSS_NEFARIAN_SHAMAN_ALERT		= "*** Shamans - Totems spawned ***";
	CT_RABOSS_NEFARIAN_DRUID_ALERT		= "*** Druiden - Katzenform ***";
	CT_RABOSS_NEFARIAN_WARLOCK_ALERT	= "*** Hexenmeister - Incoming Infernals ***";
	CT_RABOSS_NEFARIAN_PRIEST_ALERT		= "*** Priester - Heilung stoppen ***";
	CT_RABOSS_NEFARIAN_HUNTER_ALERT		= "*** J\195\164ger -  Fernkampfwaffen defekt***";
	CT_RABOSS_NEFARIAN_WARRIOR_ALERT	= "*** Krieger - Berserker Stance ***";
	CT_RABOSS_NEFARIAN_ROGUE_ALERT		= "*** Schurken - Port ***";
	CT_RABOSS_NEFARIAN_PALADIN_ALERT	= "*** Paladine - Segen des Schutzes ***";
	CT_RABOSS_NEFARIAN_MAGE_ALERT		= "*** Magier - Incoming polymorphs ***";
elseif ( GetLocale() == "frFR" ) then
	-- Vaelastrasz
	CT_RABOSS_VAEL_INFO = "Displays a warning when you or nearby players are inflicted by Burning Adrenaline.";
	CT_RABOSS_VAEL_BURNINGWARNTELL = "TU BRULES!";
	CT_RABOSS_VAEL_BURNINGWARNRAID = " BRULE ***";
	CT_RABOSS_VAEL_BOMBWARNYOU = "*** JE BRULE ***";
	CT_RABOSS_VAEL_ALERT_NEARBY = "Alert for nearby players";
	CT_RABOSS_VAEL_ALERT_NEARBY_INFO = "Alert you when nearby players are affected with Burning Adrenaline"
	CT_RABOSS_VAEL_TELL_TARGET = "Envoi un message aux cibles";
	CT_RABOSS_VAEL_TELL_TARGET_INFO = "Envoi un message au joueur qui est affecte par Burning Adrenaline";
	CT_RABOSS_VAEL_AFFLICT_BURNING = "^([^%s]+) ([^%s]+) les effets de Mont195169e d'adr195169naline.";
	CT_RABOSS_VAEL_AFFLICT_SELF_MATCH1 = "Vous";
	CT_RABOSS_VAEL_AFFLICT_SELF_MATCH2 = "subissez";
	
	-- Firemaw
	CT_RABOSS_FIREMAW_INFO = "Displays to the raid when Firemaw casts Wing Buffet and Shadowflame.";
	CT_RABOSS_FIREMAW_BUFFET = "Gueule-de-feu commence 195160 lancer Frappe des ailes.";
	CT_RABOSS_FIREMAW_BUFFET_INFO = "Displays a warning when Firemaw begins to cast Wing Buffet.";
	CT_RABOSS_FIREMAW_BUFFET_WARN = "** il cast Frappe des ailes. **";
	CT_RABOSS_FIREMAW_3SECWARN = "** 3 Sec avant Frappe des ailes MT2-3 Taunt **";
	CT_RABOSS_FIREMAW_30SECWARN = "** 30 Sec avant la prochaine Frappe des ailes. **";
	CT_RABOSS_FIREMAW_SHADOWFLAME_WARN = "** il cast Flamme d'ombre **";
	CT_RABOSS_FIREMAW_SHADOWFLAME_DETECT = "Gueule-de-feu commence 195160 lancer Flamme d'ombre.";
	CT_RABOSS_FIREMAW_SHADOWFLAMETEST = "charges!"
	
	-- Ebonroc
	
	CT_RABOSS_EBONROC_INFO = "Displays to the raid when Ebonroc casts Wing Buffet and Shadowflame.";
	CT_RABOSS_EBONROC_BUFFET = "Ebonroc commence 195160 lancer Frappe des ailes";
	CT_RABOSS_EBONROC_BUFFET_WARN = "** il cast Frappe des ailes. **";
	CT_RABOSS_EBONROC_3SECWARN = "** 3 Sec avant Frappe des ailes MT2-3 Taunt **";
	CT_RABOSS_EBONROC_30SECWARN = "** 30 Sec avant la prochaine Frappe des ailes. **";
	CT_RABOSS_EBONROC_SHADOWFLAME_WARN = "** il cast Flamme d'ombre **";
	CT_RABOSS_EBONROC_SHADOWFLAME_DETECT = "Ebonroc commence 195160 lancer Flamme d'ombre.";
	CT_RABOSS_EBONROC_AFFLICT_BOMB = "^([^%s]+) ([^%s]+) les effets de Ombre d'Ebonroc";
	CT_RABOSS_EBONROC_AFFLICT_SELF_MATCH1 = "Vous";
	CT_RABOSS_EBONROC_AFFLICT_SELF_MATCH2 = "subissez";
	CT_RABOSS_EBONROC_BOMBWARNYOU = "*** Tu as l'Ombre d'Ebonroc ***";
	CT_RABOSS_EBONROC_BOMBWARNRAID = " as l'Ombre d'Ebonroc";
	
	
	-- Flamegor
	CT_RABOSS_FLAMEGOR_INFO = "Displays when Flamegor casts Wing Buffet, Shadowflame, and goes into a frenzy."
	CT_RABOSS_FLAMEGOR_BUFFET = "Flamegor commence 195160 lancer Frappe des ailes";
	CT_RABOSS_FLAMEGOR_BUFFET_WARN = "** il cast Frappe des ailes. **";
	CT_RABOSS_FLAMEGOR_3SECWARN = "** 3 Sec avant Frappe des ailes MT2-3 Taunt **";
	CT_RABOSS_FLAMEGOR_30SECWARN = "** 30 Sec avant la prochaine Frappe des ailes. **";
	CT_RABOSS_FLAMEGOR_SHADOWFLAME_WARN = "** il cast Flamme d'ombre **";
	CT_RABOSS_FLAMEGOR_TRANQSHOT = "*** ALERTE FRENESIE - CHASSEURS TIR TRANQUILISANT MAINTENANT! ***";
	CT_RABOSS_FLAMEGOR_SHADOWFLAME_DETECT = "Flamegor commence 195160 lancer Flamme d'ombre.";
	CT_RABOSS_FLAMEGOR_FRENZY = "Flamegor est pris de fr195169n195169sie !";
	
	-- Chromaggus
	CT_RABOSS_CHROMAGGUS_INFO = "Displays each breath attack, changing resistances, and when he goes into a frenzy."
	CT_RABOSS_CHROMAGGUS_TRANQSHOT = "*** ALERTE FRENESIE - CHASSEURS TIR TRANQUILISANT MAINTENANT! ***";
	CT_RABOSS_CHROMAGGUS_RESIST_CHANGE = "** les resistance de Chromaggus ont Change! **";
	
	CT_RABOSS_CHROMAGGUS_FROSTBURNCAST = "Chromaggus commence 195160 lancer Brûlure de givre.";
	CT_RABOSS_CHROMAGGUS_FROSTBURN = "** Chromaggus is casting Frost Burn **";
	CT_RABOSS_CHROMAGGUS_FROSTBURN8SEC = "** Frost Burn - 8 Seconds **";
	
	CT_RABOSS_CHROMAGGUS_TIMELAPSECAST = "Chromaggus commence 195160 lancer Trou de temps.";
	CT_RABOSS_CHROMAGGUS_TIMELAPSE = "** Chromaggus is casting Time Lapse **";
	CT_RABOSS_CHROMAGGUS_TIMELAPSE8SEC = "** Time Lapse - 8 Seconds **";
	
	CT_RABOSS_CHROMAGGUS_IGNITECAST = "Chromaggus commence 195160 lancer Enflammer la chair.";
	CT_RABOSS_CHROMAGGUS_IGNITE = "** Chromaggus is casting Ignite Flesh **";
	CT_RABOSS_CHROMAGGUS_IGNITE8SEC = "** Ignite Flesh - 8 Seconds **";
	
	CT_RABOSS_CHROMAGGUS_ACIDCAST = "Chromaggus commence 195160 lancer Acide corrosif.";
	CT_RABOSS_CHROMAGGUS_ACID = "** Chromaggus is casting Corrosive Acid **";
	CT_RABOSS_CHROMAGGUS_ACID8SEC = "** Corrosive Acid - 8 Seconds **";
	
	CT_RABOSS_CHROMAGGUS_INCINERATECAST = "Chromaggus commence 195160 lancer Incinérer.";
	CT_RABOSS_CHROMAGGUS_INCINERATE = "** Chromaggus is casting Incinerate **";
	CT_RABOSS_CHROMAGGUS_INCINERATE8SEC = "** Incinerate - 8 Seconds **";
	
	CT_RABOSS_CHROMAGGUS_FRENZY = "entre dans une sanglante fr195169n195169sie !";
	CT_RABOSS_CHROMAGGUS_RESIST = "grimace lorsque sa peau se met à briller.";
end