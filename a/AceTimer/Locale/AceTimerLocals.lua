

if ACETIMER then return end
ACETIMER = {}

--<< ====================================================================== >>--
-- Section Defaults: Optionals, Able to be localizd                           --
--<< ====================================================================== >>--
ACETIMER.NAME			 = "AceTimer"
ACETIMER.DESCRIPTION	 = "AceTimer, your spell timer addon."

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
ACETIMER.PAT_RANK = "Rank (%d+)"
ACETIMER.FMT_CAST = "%s(Rank %d)"

ACETIMER.DRUID = {
	ABOLISH_POISON    = "Abolish Poison";
	BARKSKIN          = "Barkskin";
	BASH              = "Bash";
	DASH              = "Dash";
	DEMORALIZING_ROAR = "Demoralizing Roar";
	ENRAGE            = "Enrage";
	ENTANGLING_ROOTS  = "Entangling Roots";
	FAERIE_FIRE       = "Faerie Fire";
	FAERIE_FIRE_FERAL = "Faerie Fire (Feral)";
	FERAL_CHARGE      = "Feral Charge";
	FRENZIED_REGENERATION = "Frenzied Regeneration";
	HIBERNATE         = "Hibernate";
	INNERVATE         = "Innervate";
	INSECT_SWARM      = "Insect Swarm";
	MOONFIRE          = "Moonfire";
	NATURE_S_GRASP    = "Nature's Grasp";
	POUNCE            = "Pounce";
	RAKE              = "Rake";
	REGROWTH          = "Regrowth";
	REJUVENATION      = "Rejuvenation";
	RIP               = "Rip";
	SOOTHE_ANIMAL     = "Soothe Animal";
	STARFIRE          = "Starfire";
	TIGER_S_FURY      = "Tiger's Fury";

	BRUTAL_IMPACT     = "Brutal Impact";
	NATURE_S_GRACE    = "Nature's Grace";
	
	CLEARCASTING      = "Clearcasting";
	POUNCE_BLEED      = "Pounce Bleed";
	STARFIRE_STUN     = "Starfire Stun";
}

ACETIMER.HUNTER = {
	BESTIAL_WRATH   = "Bestial Wrath";
	CONCUSSIVE_SHOT = "Concussive Shot";
	COUNTERATTACK   = "Counterattack";
	DETERRENCE      = "Deterrence";
	EXPLOSIVE_TRAP  = "Explosive Trap";
	FLARE           = "Flare";
	FREEZING_TRAP   = "Freezing Trap";
	FROST_TRAP      = "Frost Trap";
	HUNTER_S_MARK   = "Hunter's Mark";
	IMMOLATION_TRAP = "Immolation Trap";
	MONGOOSE_BITE   = "Mongoose Bite";
	RAPID_FIRE      = "Rapid Fire";
	SCARE_BEAST     = "Scare Beast";
	SCATTER_SHOT    = "Scatter Shot";
	SCORPID_STING   = "Scorpid Sting";
	SERPENT_STING   = "Serpent Sting";
	VIPER_STING     = "Viper Sting";
	WING_CLIP       = "Wing Clip";
	WYVERN_STING    = "Wyvern Sting";
	
	CLEVER_TRAPS             = "Clever Traps";
	IMPROVED_CONCUSSIVE_SHOT = "Improved Concussive Shot";
	IMPROVED_WING_CLIP       = "Improved Wing Clip";

	EXPLOSIVE_TRAP_EFFECT  = "Explosive Trap Effect";
	FREEZING_TRAP_EFFECT   = "Freezing Trap Effect";
	FROST_TRAP_EFFECT      = "Frost Trap Effect";
	IMMOLATION_TRAP_EFFECT = "Immolation Trap Effect";
	QUICK_SHOTS            = "Quick Shots";
}

ACETIMER.MAGE = {
	ARCANE_POWER = "Arcane Power";
	BLAST_WAVE   = "Blast Wave";
	CONE_OF_COLD = "Cone of Cold";
	COUNTERSPELL = "Counterspell";
	DETECT_MAGIC = "Detect Magic";
	FIRE_WARD    = "Fire Ward";
	FIREBALL     = "Fireball";
	FLAMESTRIKE  = "Flamestrike";
	FROST_NOVA   = "Frost Nova";
	FROST_WARD   = "Frost Ward";
	FROSTBOLT    = "Frostbolt";
	ICE_BLOCK    = "Ice Block";
	ICE_BARRIER  = "Ice Barrier";
	MANA_SHIELD  = "Mana Shield";
	POLYMORPH    = "Polymorph";
	PYROBLAST    = "Pyroblast";
	SCORCH       = "Scorch";

	FROSTBITE       = "Frostbite";
	IGNITE          = "Ignite";
	IMPACT          = "Impact";
	IMPROVED_SCORCH = "Improved Scorch";
	PERMAFROST      = "Permafrost";

	CLEARCASTING          = "Clearcasting";
	COUNTERSPELL_SILENCED = "Counterspell - Silenced";
	FIRE_VULNERABILITY    = "Fire Vulnerability";
}

ACETIMER.PALADIN = {
	BLESSING_OF_FREEDOM    = "Blessing of Freedom";
	BLESSING_OF_KINGS      = "Blessing of Kings";
	BLESSING_OF_LIGHT      = "Blessing of Light";
	BLESSING_OF_MIGHT      = "Blessing of Might";
	BLESSING_OF_PROTECTION = "Blessing of Protection";
	BLESSING_OF_SACRIFICE  = "Blessing of Sacrifice";
	BLESSING_OF_SALVATION  = "Blessing of Salvation";
	BLESSING_OF_SANCTUARY  = "Blessing of Sanctuary";
	BLESSING_OF_WISDOM     = "Blessing of Wisdom";
	CONSECRATION           = "Consecration";
	DIVINE_PROTECTION      = "Divine Protection";
	DIVINE_SHIELD          = "Divine Shield";
	HAMMER_OF_JUSTICE      = "Hammer of Justice";
	HAMMER_OF_WRATH        = "Hammer of Wrath";
	HOLY_SHIELD            = "Holy Shield";
	JUDGEMENT              = "Judgement";
	LAY_ON_HANDS           = "Lay on Hands";
	REPENTANCE             = "Repentance";
	SEAL_OF_COMMAND        = "Seal of Command";
	SEAL_OF_JUSTICE        = "Seal of Justice";
	SEAL_OF_LIGHT          = "Seal of Light";
	SEAL_OF_RIGHTEOUSNESS  = "Seal of Righteousness";
	SEAL_OF_THE_CRUSADER   = "Seal of the Crusader";
	SEAL_OF_WISDOM         = "Seal of Wisdom";
	TURN_UNDEAD            = "Turn Undead";
	
	GUARDIAN_S_FAVOR  = "Guardian's Favor";
	LASTING_JUDGEMENT = "Lasting Judgement";
	REDOUBT           = "Redoubt";
	VENGEANCE         = "Vengeance";
	VINDICATION       = "Vindication";
	
	FORBEARANCE               = "Forbearance";
	JUDGEMENT_OF_JUSTICE      = "Judgement of Justice";
	JUDGEMENT_OF_LIGHT        = "Judgement of Light";   
	JUDGEMENT_OF_WISDOM       = "Judgement of Wisdom"; 
	JUDGEMENT_OF_THE_CRUSADER = "Judgement of the Crusader";
}

ACETIMER.PRIEST = {
	ABOLISH_DISEASE   = "Abolish Disease";
	DEVOURING_PLAGUE  = "Devouring Plague";
	ELUNE_S_GRACE     = "Elune's Grace";
	FADE              = "Fade";
	FEEDBACK          = "Feedback";
	HEX_OF_WEAKNESS   = "Hex of Weakness";
	HOLY_FIRE         = "Holy Fire";
	MIND_SOOTHE       = "Mind Soothe";
	POWER_INFUSION    = "Power Infusion";
	POWER_WORD_SHIELD = "Power Word: Shield";
	PSYCHIC_SCREAM    = "Psychic Scream";
	RENEW             = "Renew";
	SHACKLE_UNDEAD    = "Shackle Undead";
	SHADOW_WORD_PAIN  = "Shadow Word: Pain";
	SILENCE           = "Silence";
	STARSHARDS        = "Starshards";
	TOUCH_OF_WEAKNESS = "Touch of Weakness";
	VAMPIRIC_EMBRACE  = "Vampiric Embrace";

	BLACKOUT                   = "Blackout";
	BLESSED_RECOVERY           = "Blessed Recovery";
	IMPROVED_POWER_WORD_SHIELD = "Improved Power Word: Shield";
	IMPROVED_SHADOW_WORD_PAIN  = "Improved Shadow Word: Pain";
	INSPIRATION                = "Inspiration";
	SHADOW_VULNERABILITY       = "Shadow Vulnerability";
	SHADOW_WEAVING             = "Shadow Weaving";
	SPIRIT_TAP                 = "Spirit Tap";

	WEAKENED_SOUL = "Weakened Soul";
}

ACETIMER.ROGUE = {
	ADRENALINE_RUSH = "Adrenaline Rush";
	BLADE_FLURRY    = "Blade Flurry";
	BLIND           = "Blind";
	CHEAP_SHOT      = "Cheap Shot";
	DISTRACT        = "Distract";
	EXPOSE_ARMOR    = "Expose Armor";
	EVASION         = "Evasion";
	GARROTE         = "Garrote";
	GOUGE           = "Gouge";
	HEMORRHAGE      = "Hemorrhage";
	KICK            = "Kick";
	KIDNEY_SHOT     = "Kidney Shot";
	RIPOSTE         = "Riposte";
	RUPTURE         = "Rupture";
	SAP             = "Sap";
	SLICE_AND_DICE  = "Slice and Dice";
	SPRINT          = "Sprint";
	VANISH          = "Vanish";

	IMPROVED_GOUGE          = "Improved Gouge";
	IMPROVED_GARROTE        = "Improved Garrote";
	IMPROVED_EVASION        = "Improved Evasion";
	IMPROVED_SLICE_AND_DICE = "Improved Slice and Dice";
	MACE_SPECIALIZATION     = "Mace Specialization";
	REMORSELESS_ATTACKS     = "Remorseless Attacks";

	KICK_SILENCED    = "Kick - Silenced";
	MACE_STUN_EFFECT = "Mace Stun Effect";
	REMORSELESS      = "Remorseless";
}

ACETIMER.SHAMAN = {
	DISEASE_CLEANSING_TOTEM  = "Disease Cleansing Totem";
	EARTH_SHOCK              = "Earth Shock";
	EARTHBIND_TOTEM          = "Earthbind Totem";
	FIRE_NOVA_TOTEM          = "Fire Nova Totem";
	FIRE_RESISTANCE_TOTEM    = "Fire Resistance Totem";
	FROST_SHOCK              = "Frost Shock";
	FLAME_SHOCK              = "Flame Shock";
	FLAMETONGUE_TOTEM        = "Flametongue Totem";
	FROST_RESISTANCE_TOTEM   = "Frost Resistance Totem";
	GRACE_OF_AIR_TOTEM       = "Grace of Air Totem";
	GROUNDING_TOTEM          = "Grounding Totem";
	HEALING_STREAM_TOTEM     = "Healing Stream Totem";
	MAGMA_TOTEM              = "Magma Totem";
	MANA_SPRING_TOTEM        = "Mana Spring Totem";
	MANA_TIDE_TOTEM          = "Mana Tide Totem";
	NATURE_RESISTANCE_TOTEM  = "Nature Resistance Totem";
	POISON_CLEANSING_TOTEM   = "Poison Cleansing Totem";
	SEARING_TOTEM            = "Searing Totem";
	SENTRY_TOTEM             = "Sentry Totem";
	STONECLAW_TOTEM          = "Stoneclaw Totem";
	STONESKIN_TOTEM          = "Stoneskin Totem";
	STORMSTRIKE              = "Stormstrike";
	STRENGTH_OF_EARTH_TOTEM  = "Strength of Earth Totem";
	TRANQUIL_AIR_TOTEM       = "Tranquil Air Totem";
	TREMOR_TOTEM             = "Tremor Totem";
	WINDFURY_TOTEM           = "Windfury Totem";
	WINDWALL_TOTEM           = "Windwall Totem";

	ANCESTRAL_HEALING        = "Ancestral Healing";
	EVENTIDE                 = "Eventide";
	IMPROVED_FIRE_NOVA_TOTEM = "Improved Fire Nova Totem";
	IMPROVED_STONECLAW_TOTEM = "Improved Stoneclaw Totem";
	
	ANCESTRAL_FORTITUDE      = "Ancestral Fortitude";
	CLEARCASTING             = "Clearcasting";
	ENAMORED_WATER_SPIRIT    = "Enamored Water Spirit";
}

ACETIMER.WARLOCK = {
	AMPLIFY_CURSE         = "Amplify Curse";
	BANISH                = "Banish";
	CORRUPTION            = "Corruption";
	CURSE_OF_AGONY        = "Curse of Agony";
	CURSE_OF_DOOM         = "Curse of Doom";
	CURSE_OF_EXHAUSTION   = "Curse of Exhaustion";
	CURSE_OF_RECKLESSNESS = "Curse of Recklessness";
	CURSE_OF_SHADOW       = "Curse of Shadow";
	CURSE_OF_TONGUES      = "Curse of Tongues";
	CURSE_OF_WEAKNESS     = "Curse of Weakness";
	CURSE_OF_THE_ELEMENTS = "Curse of the Elements";
	DEATH_COIL            = "Death Coil";
	DRAIN_SOUL            = "Drain Soul";
	FEAR                  = "Fear";
	FEL_DOMINATION        = "Fel Domination";
	ENSLAVE_DEMON         = "Enslave Demon";
	HOWL_OF_TERROR        = "Howl of Terror";
	IMMOLATE              = "Immolate";
	SHADOW_BOLT           = "Shadow Bolt";
	SHADOW_WARD           = "Shadow Ward";
	SHADOWBURN            = "Shadowburn";
	SIPHON_LIFE           = "Siphon Life";

	AFTERMATH             = "Aftermath";
	NIGHTFALL             = "Nightfall";
	PYROCLASM             = "Pyroclasm";
	SACRIFICE             = "Sacrifice";
	SEDUCTION             = "Seduction";

	SHADOW_TRANCE         = "Shadow Trance";
	SHADOW_VULNERABILITY  = "Shadow Vulnerability";
	SOUL_SIPHON           = "Soul Siphon";
}

ACETIMER.WARRIOR = {
	BATTLE_SHOUT       = "Battle Shout";
	BERSERKER_RAGE     = "Berserker Rage";
	BLOODRAGE          = "Bloodrage";
	BLOODTHIRST        = "Bloodthirst";
	CHARGE             = "Charge";
	CHALLENGING_SHOUT  = "Challenging Shout";
	CONCUSSION_BLOW    = "Concussion Blow";
	DEATH_WISH         = "Death Wish";
	DEMORALIZING_SHOUT = "Demoralizing Shout";
	DISARM             = "Disarm";
	EXECUTE            = "Execute";
	HAMSTRING          = "Hamstring";
	INTERCEPT          = "Intercept";
	INTIMIDATING_SHOUT = "Intimidating Shout";
	LAST_STAND         = "Last Stand";
	MOCKING_BLOW       = "Mocking Blow";
	MORTAL_STRIKE      = "Mortal Strike";
	OVERPOWER          = "Overpower";
	PIERCING_HOWL      = "Piercing Howl";
	PUMMEL             = "Pummel";
	RECKLESSNESS       = "Recklessness";
	REND               = "Rend";
	RETALIATION        = "Retaliation";
	REVENGE            = "Revenge";
	SHIELD_BLOCK       = "Shield Block";
	SHIELD_BASH        = "Shield Bash";
	SHIELD_WALL        = "Shield Wall";
	SUNDER_ARMOR       = "Sunder Armor";
	SWEEPING_STRIKES   = "Sweeping Strikes";
	TAUNT              = "Taunt";
	THUNDER_CLAP       = "Thunder Clap";
	
	BOOMING_VOICE         = "Booming Voice";
	BLOOD_CRAZE           = "Blood Craze";
	DEEP_WOUNDS           = "Deep Wounds";
	ENRAGE                = "Enrage";
	FLURRY                = "Flurry";
	IMPROVED_DISARM       = "Improved Disarm";
	IMPROVED_HAMSTRING    = "Improved Hamstring";
	IMPROVED_SHIELD_BLOCK = "Improved Shield Block";
	IMPROVED_SHIELD_WALL  = "Improved Shield Wall";
	MACE_SPECIALIZATION   = "Mace Specialization";

	CHARGE_STUN          = "Charge Stun";
	INTERCEPT_STUN       = "Intercept Stun";
	MACE_STUN_EFFECT     = "Mace Stun Effect";
	REVENGE_STUN         = "Revenge Stun";
	SHIELD_BASH_SILENCED = "Shield Bash - Silenced";
}
