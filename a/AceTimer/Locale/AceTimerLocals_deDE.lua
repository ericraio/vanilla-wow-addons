
-- German Localization by Filion of Perenolde (EU)
if GetLocale() ~= "deDE" then return end
ACETIMER = {}

--<< ====================================================================== >>--
-- Section Defaults: Optionals, Able to be localizd                           --
--<< ====================================================================== >>--
ACETIMER.NAME            = "AceTimer"
ACETIMER.DESCRIPTION     = "AceTimer, your spell timer addon."

ACETIMER.CMD_SHORT       = "/at"
ACETIMER.CMD_LONG        = "/acetimer"

ACETIMER.OPT_ANCHOR      = "anchor"
ACETIMER.OPT_ANCHOR_DESC = "Shows the dragable anchor."
ACETIMER.OPT_ANCHOR_TEXT = "Anchor is now: "

ACETIMER.OPT_SCALE       = "scale"
ACETIMER.OPT_SCALE_DESC  = "Sets bar scale ( 0.5 ~ 1)."
ACETIMER.OPT_SCALE_TEXT  = "Bar Scale is: "

ACETIMER.OPT_GROW        = "grow"
ACETIMER.OPT_GROW_DESC   = "Toggles bar growing up or downwards."
ACETIMER.OPT_GROW_TEXT   = "Growth is now: "

ACETIMER.OPT_FADE        = "fade"
ACETIMER.OPT_FADE_DESC   = "Toggles whether bars disappear when spells fade."
ACETIMER.OPT_FADE_TEXT   = "Bar disappear on fade is now: "

ACETIMER.OPT_KILL        = "kill"
ACETIMER.OPT_KILL_DESC   = "Toggles whether bars disappear when killing things."
ACETIMER.OPT_KILL_TEXT   = "Bar disappear on kill is now: "

ACETIMER.OPT_SKILL       = "skill"
ACETIMER.OPT_SKILL_DESC  = "Toggles whether bars appear when skills is avaiable."
ACETIMER.OPT_SKILL_TEXT  = "Bar appear on skill avaiable is now: "

ACETIMER.MAP_ONOFF       = {[0]="|cff00ff00On|r",  [1]="|cffff5050Off|r"}
ACETIMER.MAP_DOWNUP      = {[0]="|cff00ff00Down|r",[1]="|cffff5050Up|r" }
ACETIMER.WORD_TEST       = "Test"
ACETIMER.WORD_HIDE       = "Hide"

--<< ====================================================================== >>--
-- Section Criticals: Imperatives, Not work unless localized                  --
--<< ====================================================================== >>--
ACETIMER.PAT_RANK = "Rang (%d+)"
ACETIMER.FMT_CAST = "%s(Rang %d)"

ACETIMER.DRUID = {
	ABOLISH_POISON    = "Vergiftung aufheben";
	BARKSKIN          = "Baumrinde";
	BASH              = "Hieb";
	DASH              = "Spurt";
	DEMORALIZING_ROAR = "Demoralisierendes Gebrüll";
	ENRAGE            = "Wutanfall";
	ENTANGLING_ROOTS  = "Wucherwurzeln";
	FAERIE_FIRE       = "Feenfeuer";
	FAERIE_FIRE_FERAL = "Feenfeuer (Tiergestalt)";
	FERAL_CHARGE      = "Wilde Attacke";
	FRENZIED_REGENERATION = "Rasende Regeneration";
	HIBERNATE         = "Winterschlaf";
	INNERVATE         = "Anregen";
	INSECT_SWARM      = "Insektenschwarm";
	MOONFIRE          = "Mondfeuer";
	NATURE_S_GRASP    = "Griff der Natur";
	POUNCE            = "Anspringen";
	RAKE              = "Krallenhieb";
	REGROWTH          = "Nachwachsen";
	REJUVENATION      = "Verjüngung";
	RIP               = "Zerfetzen";
	SOOTHE_ANIMAL     = "Tier besänftigen";
	STARFIRE          = "Sternenfeuer";
	TIGER_S_FURY      = "Tigerfuror";

	BRUTAL_IMPACT     = "Brutaler Hieb";
	NATURE_S_GRACE    = "Anmut der Natur";
	
	CLEARCASTING      = "Freizaubern";
	POUNCE_BLEED      = "Anspringblutung";
	STARFIRE_STUN     = "Sternenfeuer-Betäubung";
}

ACETIMER.HUNTER = {
	BESTIAL_WRATH   = "Zorn des Wildtiers";
	CONCUSSIVE_SHOT = "Erschütternder Schuss";
	COUNTERATTACK   = "Gegenangriff";
	DETERRENCE      = "Abschreckung";
	EXPLOSIVE_TRAP  = "Sprengfalle";
	FLARE           = "Leuchtfeuer";
	FREEZING_TRAP   = "Eiskältefalle";
	FROST_TRAP      = "Frostfalle";
	HUNTER_S_MARK   = "Mal des Jägers";
	IMMOLATION_TRAP = "Feuerbrandfalle";
	MONGOOSE_BITE   = "Mungobiss";
	RAPID_FIRE      = "Schnellfeuer";
	SCARE_BEAST     = "Wildtier ängstigen";
	SCATTER_SHOT    = "Streuschuss";
	SCORPID_STING   = "Skorpidstich";
	SERPENT_STING   = "Schlangenbiss";
	VIPER_STING     = "Vipernbiss";
	WING_CLIP       = "Zurechtstutzen";
	WYVERN_STING    = "Stich des Flügeldrachen";
	
	CLEVER_TRAPS             = "Verbesserte 'Feuerbrandfalle'";
	IMPROVED_CONCUSSIVE_SHOT = "Verbesserter Erschütternder Schuss";
	IMPROVED_WING_CLIP       = "Verbessertes Zurechtstutzen";
	
	EXPLOSIVE_TRAP_EFFECT  = "Sprengfalle'-Effekt";
	FREEZING_TRAP_EFFECT   = "Eiskältefalle";
	IMMOLATION_TRAP_EFFECT = "Feuerbrandfalle";
	FROST_TRAP_EFFECT      = "Frostfalle-Aura";
	QUICK_SHOTS            = "Schnelle Schüsse";
}

ACETIMER.MAGE = {
	ARCANE_POWER = "Arkane Macht";
	BLAST_WAVE   = "Druckwelle";
	CONE_OF_COLD = "Kältekegel";
	COUNTERSPELL = "Gegenzauber";
	DETECT_MAGIC = "Magie entdecken";
	FIRE_WARD    = "Feuerzauberschutz";
	FIREBALL     = "Feuerball";
	FLAMESTRIKE  = "Flammenstoß";
	FROST_NOVA   = "Frostnova";
	FROST_WARD   = "Frostzauberschutz";
	FROSTBOLT    = "Frostblitz";
	ICE_BLOCK    = "Eisblock";
	ICE_BARRIER  = "Eis-Barriere";
	MANA_SHIELD  = "Manaschild";
	POLYMORPH    = "Verwandlung";
	PYROBLAST    = "Pyroschlag";
	SCORCH       = "Versengen";

	FROSTBITE       = "Erfrierung";
	IGNITE          = "Entzünden";
	IMPACT          = "Einschlag";
	IMPROVED_SCORCH = "Verbessertes Versengen";
	PERMAFROST      = "Dauerfrost";

	CLEARCASTING          = "Freizaubern";
	COUNTERSPELL_SILENCED = "Gegenzauber - zum Schweigen gebracht";
	FIRE_VULNERABILITY    = "Feuerverwundbarkeit";
}

ACETIMER.PALADIN = {
	BLESSING_OF_FREEDOM    = "Segen der Freiheit";
	BLESSING_OF_KINGS      = "Segen der Könige";
	BLESSING_OF_LIGHT      = "Segen des Lichts";
	BLESSING_OF_MIGHT      = "Segen der Macht";
	BLESSING_OF_PROTECTION = "Segen des Schutzes";
	BLESSING_OF_SACRIFICE  = "Segen der Opferung";
	BLESSING_OF_SALVATION  = "Segen der Rettung";
	BLESSING_OF_SANCTUARY  = "Segen des Refugiums";
	BLESSING_OF_WISDOM     = "Segen der Weisheit";
	CONSECRATION           = "Weihe";
	DIVINE_PROTECTION      = "Göttlicher Schutz";
	DIVINE_SHIELD          = "Gottesschild";
	HAMMER_OF_JUSTICE      = "Hammer der Gerechtigkeit";
	HAMMER_OF_WRATH        = "Hammer des Zorns";
	HOLY_SHIELD            = "Heiliger Schild";
	JUDGEMENT              = "Richturteil";
	LAY_ON_HANDS           = "Handauflegung";
	REPENTANCE             = "Buße";
	SEAL_OF_COMMAND        = "Siegel des Befehls";
	SEAL_OF_JUSTICE        = "Siegel der Gerechtigkeit";
	SEAL_OF_LIGHT          = "Siegel des Lichts";
	SEAL_OF_RIGHTEOUSNESS  = "Siegel der Rechtschaffenheit";
	SEAL_OF_THE_CRUSADER   = "Siegel des Kreuzfahrers";
	SEAL_OF_WISDOM         = "Siegel der Weisheit";
	TURN_UNDEAD            = "Untote vertreiben";
	
	GUARDIAN_S_FAVOR       = "Gunst des Hüters";
	LASTING_JUDGEMENT      = "Dauerhaftes Richturteil";
	REDOUBT                = "Verschanzen";
	VENGEANCE              = "Rache";
	VINDICATION            = "Rechtschaffene Schwächung";
	
	FORBEARANCE               = "Vorahnung"; -- Please test
	JUDGEMENT_OF_JUSTICE      = "Richturteil der Gerechtigkeit";
	JUDGEMENT_OF_LIGHT        = "Richturteil des Lichts";   
	JUDGEMENT_OF_WISDOM       = "Richturteil der Weisheit"; 
	JUDGEMENT_OF_THE_CRUSADER = "Richturteil des Kreuzfahrers";
}

ACETIMER.PRIEST = {
	ABOLISH_DISEASE   = "Krankheit aufheben";
	DEVOURING_PLAGUE  = "Verschlingende Seuche";
	ELUNE_S_GRACE     = "Elunes Anmut";
	FADE              = "Verblassen";
	FEEDBACK          = "Rückkopplung";
	HEX_OF_WEAKNESS   = "Verhexung der Schwäche";
	HOLY_FIRE         = "Heiliges Feuer";
	MIND_SOOTHE       = "Gedankenbesänftigung";
	POWER_INFUSION    = "Seele der Macht";
	POWER_WORD_SHIELD = "Machtwort: Schild";
	PSYCHIC_SCREAM    = "Psychischer Schrei";
	RENEW             = "Erneuerung";
	SHACKLE_UNDEAD    = "Untote fesseln";
	SHADOW_WORD_PAIN  = "Schattenwort: Schmerz";
	SILENCE           = "Stille";
	STARSHARDS        = "Sternensplitter";
	TOUCH_OF_WEAKNESS = "Berührung der Schwäche";
	VAMPIRIC_EMBRACE  = "Vampirumarmung";

	BLACKOUT                   = "Blackout";
	BLESSED_RECOVERY           = "Gesegnete Erholung";
	IMPROVED_POWER_WORD_SHIELD = "Verbessertes Machtwort: Schild";
	IMPROVED_SHADOW_WORD_PAIN  = "Verbessertes Schattenwort: Schmerz";
	INSPIRATION                = "Inspiration";
	SHADOW_VULNERABILITY       = "Schattenverwundbarkeit";
	SHADOW_WEAVING             = "Schattenwirken";
	SPIRIT_TAP                 = "Willensentzug";

	WEAKENED_SOUL = "Geschwächte Seele";
}

ACETIMER.ROGUE = {
	ADRENALINE_RUSH = "Adrenalinrausch";
	BLADE_FLURRY    = "Klingenwirbel";
	BLIND           = "Blenden";
	CHEAP_SHOT      = "Fieser Trick";
	DISTRACT        = "Ablenken";
	EXPOSE_ARMOR    = "Rüstung schwächen";
	EVASION         = "Entrinnen";
	GARROTE         = "Erdrosseln";
	GOUGE           = "Solarplexus";
	HEMORRHAGE      = "Blutsturz";
	KICK            = "Tritt";
	KIDNEY_SHOT     = "Nierenhieb";
	RIPOSTE         = "Riposte";
	RUPTURE         = "Blutung";
	SAP             = "Kopfnuss";
	SLICE_AND_DICE  = "Zerhäckseln";
	SPRINT          = "Sprinten";
	VANISH          = "Verschwinden";

	IMPROVED_GOUGE          = "Verbesserter Solarplexus";
	IMPROVED_GARROTE        = "Verbessertes Erdrosseln";
	IMPROVED_EVASION        = "Verbessertes Entrinnen";
	IMPROVED_SLICE_AND_DICE = "Verbessertes Zerhäckseln";
	MACE_SPECIALIZATION     = "Streitkolben-Spezialisierung";
	REMORSELESS_ATTACKS     = "Gnadenlose Angriffe";

	KICK_SILENCED    = "Tritt - zum Schweigen gebracht";
	MACE_STUN_EFFECT = "Streitkolbenbetäubung-Effekt";
	REMORSELESS      = "Gnadenlos";
}

ACETIMER.SHAMAN = {
	DISEASE_CLEANSING_TOTEM  = "Totem der Krankheitsreinigung";
	EARTH_SHOCK              = "Erdschock";
	EARTHBIND_TOTEM          = "Totem der Erdbindung";
	FIRE_NOVA_TOTEM          = "Totem der Feuernova";
	FIRE_RESISTANCE_TOTEM    = "Totem des Feuerwiderstands";
	FROST_SHOCK              = "Frostschock";
	FLAME_SHOCK              = "Flammenschock";
	FLAMETONGUE_TOTEM        = "Totem der Flammenzunge";
	FROST_RESISTANCE_TOTEM   = "Totem des Frostwiderstands";
	GRACE_OF_AIR_TOTEM       = "Totem der luftgleichen Anmut";
	GROUNDING_TOTEM          = "Totem der Erdung";
	HEALING_STREAM_TOTEM     = "Totem des heilenden Flusses";
	MAGMA_TOTEM              = "Totem der glühenden Magma";
	MANA_SPRING_TOTEM        = "Totem der Manaquelle";
	MANA_TIDE_TOTEM          = "Totem der Manaflut";
	NATURE_RESISTANCE_TOTEM  = "Totem des Naturwiderstands";
	POISON_CLEANSING_TOTEM   = "Totem der Giftreinigung";
	SEARING_TOTEM            = "Totem der Verbrennung";
	SENTRY_TOTEM             = "Totem des Wachens";
	STONECLAW_TOTEM          = "Totem der Steinklaue";
	STONESKIN_TOTEM          = "Totem der Steinhaut";
	STORMSTRIKE              = "Sturmschlag";
	STRENGTH_OF_EARTH_TOTEM  = "Totem der Erdstärke";
	TRANQUIL_AIR_TOTEM       = "Totem der beruhigenden Winde";
	TREMOR_TOTEM             = "Totem des Erdstoßes";
	WINDFURY_TOTEM           = "Totem des Windzorns";
	WINDWALL_TOTEM           = "Totem der Windmauer";

	ANCESTRAL_HEALING        = "Heilung der Ahnen";
	EVENTIDE                 = "Abendzeit";
	IMPROVED_FIRE_NOVA_TOTEM = "Verbessertes Totem der Feuernova";
	IMPROVED_STONECLAW_TOTEM = "Verbessertes Totem der Steinklaue";
	
	ANCESTRAL_FORTITUDE      = "Seelenstärke der Ahnen";
	CLEARCASTING             = "Freizaubern";
	ENAMORED_WATER_SPIRIT    = "Entzückter Wassergeist";
}

ACETIMER.WARLOCK = {
	AMPLIFY_CURSE         = "Fluch verstärken";
	BANISH                = "Verbannen";
	CORRUPTION            = "Verderbnis";
	CURSE_OF_AGONY        = "Fluch der Pein";
	CURSE_OF_DOOM         = "Fluch der Verdammnis";
	CURSE_OF_EXHAUSTION   = "Fluch der Erschöpfung";
	CURSE_OF_RECKLESSNESS = "Fluch der Tollkühnheit";
	CURSE_OF_SHADOW       = "Schattenfluch";
	CURSE_OF_TONGUES      = "Fluch der Sprachen";
	CURSE_OF_WEAKNESS     = "Fluch der Schwäche";
	CURSE_OF_THE_ELEMENTS = "Fluch der Elemente";
	DEATH_COIL            = "Todesmantel";
	DRAIN_SOUL            = "Seelendieb";
	FEAR                  = "Furcht";
	FEL_DOMINATION        = "Teufelsbeherrschung";
	ENSLAVE_DEMON         = "Dämonensklave";
	HELLFIRE              = "Höllenfeuer";
	HOWL_OF_TERROR        = "Schreckgeheul";
	IMMOLATE              = "Feuerbrand";
	SHADOW_BOLT           = "Schattenblitz";
	SHADOW_WARD           = "Schattenzauberschutz";
	SHADOWBURN            = "Schattenbrand";
	SIPHON_LIFE           = "Lebensentzug";

	AFTERMATH             = "Nachwirkung";
	NIGHTFALL             = "Einbruch der Nacht";
	PYROCLASM             = "Feuerschwall";
	SACRIFICE             = "Opferung";
	SEDUCTION             = "Verführung";

	SHADOW_TRANCE         = "Schattentrance";
	SHADOW_VULNERABILITY  = "Schattenverwundbarkeit";
	SOUL_SIPHON           = "Seelen-Siphon";
}

ACETIMER.WARRIOR = {
	BATTLE_SHOUT       = "Schlachtruf";
	BERSERKER_RAGE     = "Berserkerwut";
	BLOODRAGE          = "Blutrausch";
	BLOODTHIRST        = "Blutdurst";
	CHARGE             = "Sturmangriff";
	CHALLENGING_SHOUT  = "Herausforderungsruf";
	CONCUSSION_BLOW    = "Erschütternder Schlag";
	DEATH_WISH         = "Todeswunsch";
	DEMORALIZING_SHOUT = "Demoralisierungsruf";
	DISARM             = "Entwaffnen";
	EXECUTE            = "Hinrichten";
	HAMSTRING          = "Kniesehne";
	INTERCEPT          = "Abfangen";
	INTIMIDATING_SHOUT = "Drohruf";
	LAST_STAND         = "Letztes Gefecht";
	MOCKING_BLOW       = "Spöttischer Schlag";
	MORTAL_STRIKE      = "Tödlicher Stoß";
	OVERPOWER          = "Überwältigen";
	PIERCING_HOWL      = "Durchdringendes Heulen";
	PUMMEL             = "Zuschlagen";
	RECKLESSNESS       = "Tollkühnheit";
	REND               = "Verwunden";
	RETALIATION        = "Gegenschlag";
	REVENGE            = "Rache";
	SHIELD_BLOCK       = "Schildblock";
	SHIELD_BASH        = "Schildhieb";
	SHIELD_WALL        = "Schildwall";
	SUNDER_ARMOR       = "Rüstung zerreißen";
	SWEEPING_STRIKES   = "Weitreichende Stöße";
	THUNDER_CLAP       = "Donnerknall";
	
	BOOMING_VOICE         = "Donnernde Stimme";
	BLOOD_CRAZE           = "Blutwahnsinn";
	DEEP_WOUNDS           = "Tiefe Wunden";
	ENRAGE                = "Wutanfall";
	FLURRY                = "Schlaghagel";
	IMPROVED_DISARM       = "Verbessertes Entwaffnen";
	IMPROVED_HAMSTRING    = "Verbesserte Kniesehne";
	IMPROVED_SHIELD_BLOCK = "Verbesserter Schildblock";
	IMPROVED_SHIELD_WALL  = "Verbesserter Schildwall";
	MACE_SPECIALIZATION   = "Streitkolben-Spezialisierung";

	CHARGE_STUN          = "Sturmangriffsbetäubung";
	INTERCEPT_STUN       = "Betäubung abfangen";
	MACE_STUN_EFFECT     = "Streitkolbenbetäubung-Effekt";
	REVENGE_STUN         = "Rachebetäubung";
	SHIELD_BASH_SILENCED = "Schildhieb - zum Schweigen gebracht";
}