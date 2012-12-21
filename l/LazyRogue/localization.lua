lrLocale = {}

-- assume english, unless overridden below
lrLocale.SPELLCASTOTHERSTART = "(.+) begins to cast (.+)."
lrLocale.SPELLPERFORMOTHERSTART = "(.+) begins to perform (.+)."
lrLocale.EVISCERATE_HIT = "Your Eviscerate hits (.+) for (%d+)."
lrLocale.EVISCERATE_CRIT = "Your Eviscerate crits (.+) for (%d+).";
--lrLocale.MOUNTED_BUFF_TT = "Increases speed by (%d+)%%."
lrLocale.MOUNTED_BUFF_TT = "Increases speed"

lrLocale.BGWGTEXT0="Warsong Gulch"
lrLocale.BGWGTEXT1="The %s flag was picked up by (.+)!"
lrLocale.BGWGTEXT2="captured the %s flag!"
lrLocale.BGWGTEXT3="The %s flag was dropped by"
lrLocale.BGWGTEXT4="The %s flag was returned to its base by"

lrLocale.DUEL_COUNTDOWN="Duel starting: (%d+)"
lrLocale.DUEL_WINNER_KNOCKOUT="(.+) has defeated (.+) in a duel"
lrLocale.DUEL_WINNER_RETREAT="(.+) has fled from (.+) in a duel"

lrLocale.GANKED="Ganked By: %s Count: %d"
-- COMBATHITCRITOTHERSELF = "%s crits you for %d.";
-- COMBATHITOTHERSELF = "%s hits you for %d.";
lrLocale.GANKED_CHATS = {
   "(.+) crits you for",
   "(.+) hits you for",
}

lrLocale.IMMUNE="Your (.+) failed. (.+) is immune."
lrLocale.ImmunityProblemCreatures = {
	"Scarlet",
	"Crimson",
	"Phasing",
	"Doan",
	"Gurubashi",
	"Springvale",
	"Arugal"
}

lrLocale.INSTANCES = {
"Ragefire Chasm",
"Deadmines",
"Wailing Caverns",
"Shadowfang Keep",
"The Stockades",
"Blackfathom Depths",
"Gnomeregan",
"Razorfen Kraul",
"The Scarlet Monastery",
"Razorfen Downs",
"Uldaman",
"Maraudon",
"Zul'Farrak",
"The Sunken Temple",
"Blackrock Depths",
"Blackrock Spire",
"Stratholme",
"Dire Maul",
"Scholomance",
"Onyxia's Lair",
"Ruins of Ahn'Qiraj",
"Zul'Gurub",
"Molten Core",
"Blackwing Lair",
"Temple of Ahn'Qiraj",
"Naxxramas Necropolis",
}


lrLocale.HuntersMark_TTS = {
   Ability_Hunter_SniperShot = "Hunter's Mark"
}

lrLocale.Polymorph_TTS = {
   Spell_Nature_Polymorph = "Polymorph"
}

lrLocale.SLOWED_TTS = {
   "Movement slowed by (%d+)%%.",
   "Movement speed reduced by (%d+)%%.",
}
lrLocale.STUNNED_TTS = {
   "Stunned.",
   "Disoriented.",
   "Frozen.",
}
lrLocale.DOT_TTS = {
   "(.+) damage over (%d+) sec(.+).",
   "(.+) damage every (%d+) sec(.+).",
}
lrLocale.FEAR_TTS = {
   "Intimidated.",
   "Fleeing in fear.",
   "Running in Fear.",
   "Feared.",
}
lrLocale.IMMOBILE_TTS = {
   "Immobilized.",
   "Rooted in place.",
   "Unable to move",
   "Rooted.  Causes (%d+) Nature damage every (%d+) seconds.",
}
lrLocale.Bleed_TTS = {
   Ability_Gouge              = "Rend",
   Ability_Druid_Disembowel   = "Rake",
   Ability_Rogue_Garrote      = "Garrote",
   Spell_Shadow_LifeDrain     = "Hemorrhage",
   Ability_Rogue_Rupture      = "Rupture",
   Ability_Rogue_Backstab     = "Deep Wound",
}
lrLocale.CC_TTS = {
   Spell_Nature_Sleep         = { "Hibernate" },
   Spell_Frost_ChainsOfIce    = { "Freezing Trap" },
   INV_Spear_02               = { "Wyvern Sting", "Asleep" },
   Spell_Nature_Polymorph     = { "Polymorph" },
   Spell_Holy_PrayerOfHealing = { "Repentance" },
   Spell_Nature_Slow          = { "Shackle Undead" },
   Ability_Gouge              = { "Gouge" },
   Ability_Sap                = { "Sap" },
   Spell_Shadow_MindSteal     = { "Blind" },
}
lrLocale.BUFF_TTS = {
   adrenalineRush   = "Adrenaline Rush",
   berserking       = "Berserking",
   bladeFlurry      = "Blade Flurry",
   blind            = "Blind",
   cheapShot        = "Cheap Shot",
   coldBlood        = "Cold Blood",
   evasion          = "Evasion",
   exposeArmor      = "Expose Armor",
   firstAid         = "First Aid",
   garrote          = "Garrote",
   ghostlyStrike    = "Ghostly Strike",
   gouge            = "Gouge",
   hemorrhage       = "Hemorrhage",
   kidneyShot       = "Kidney Shot",
   recentlyBandaged = "Recently Bandaged",
   remorseless      = "Remorseless",
   rupture          = "Rupture",
   sap              = "Sap",
   sliceNDice       = "Slice and Dice",
   stealth          = "Stealth",
   vanish           = "Vanish",
}


if (GetLocale() == "deDE") then
   -- German
   lrLocale.SPELLCASTOTHERSTART = "(.+) beginnt (.+) zu wirken."
   lrLocale.SPELLPERFORMOTHERSTART = "(.+) beginnt (.+) auszuf\195\188hren."
   lrLocale.EVISCERATE_HIT = "Ausweiden von Euch trifft (.+) f\195\188r (%d+) Schaden."
   lrLocale.EVISCERATE_CRIT = "Euer Ausweiden trifft (.+) kritisch. Schaden: (%d+).";
   lrLocale.MOUNTED_BUFF_TT = "Erh\195\182ht Tempo um (%d+)%%."
   -- this is reported to have problems:
   --lrLocale.MOUNTED_BUFF_TT = "Erh\195\182hte Geschwindigkeit"

   
   lrLocale.DUEL_COUNTDOWN="Duell beginnt: (%d)"
   lrLocale.DUEL_WINNER_KNOCKOUT="(.+) hat (.+) in einem Duell besiegt."
   lrLocale.DUEL_WINNER_RETREAT="(.+) ist vor (.+) aus einem Duell gefl\195\188chtet."


   lrLocale.Polymorph_TTS = {
      Spell_Nature_Polymorph = "Verwandlung"
   }

   -- Thank you to Golonator for these translations!

   lrLocale.IMMUNE = "(.+) war ein Fehlschlag. (.+) ist immun.";
   lrLocale.ImmunityProblemCreatures = {
      "Scharlachrot",
      "Purpurrot",
      "Doan",
      "Gurubashi",
      "Springvale",
      "Arugal"
   }
   lrLocale.HuntersMark_TTS = {
      Ability_Hunter_SniperShot = "J\195\164germal"
   }
   lrLocale.SLOWED_TTS = {
      "Movement slowed by (%d+)%%.",
      "Movement speed reduced by (%d+)%%.",
   }
   lrLocale.STUNNED_TTS = {
      "Stunned.",
      "Disoriented.",
      "Frozen.",
   }
   lrLocale.DOT_TTS = {
      "(.+) alle (%d+) Sek(.+)",
      "Alle (%d+) Sek(.+)",
      "(%d+) Sek. lang (.+)",
   }
   lrLocale.FEAR_TTS = {
      "Intimidated.",
      "Fleeing in fear.",
      "Running in Fear.",
      "Feared.",
   }
   lrLocale.IMMOBILE_TTS = {
      "Immobilized.",
      "Rooted in place.",
      "Unable to move",
      "Rooted. Causes (%d+) Nature damage every (%d+) seconds.",
   }
   lrLocale.Bleed_TTS = {
      Ability_Gouge = "Zerfleischen",
      Ability_Druid_Disembowel = "Krallenhieb",
      Ability_Rogue_Garrote = "Erdrosseln",
      Spell_Shadow_LifeDrain = "Blutsturz",
      Ability_Rogue_Rupture = "Blutung",
      Ability_Rogue_Backstab = "Tiefe Wunde",
   }
   lrLocale.INSTANCES = {
      "Ragefireabgrund",
      "Die Todesminen",
      "Die H\195\182hlen des Wehklagens",
      "Burg Shadowfang",
      "Verlies von Stormwind",
      "Blackfathom-Tiefe",
      "Gnomeregan",
      "Der Kral von Razorfen",
      "Das scharlachrote Kloster",
      "Die H\195\188gel von Razorfen",
      "Uldaman",
      "Maraudon",
      "Zul'Farrak",
      "Der Tempel von Atal'Hakkar",
      "Blackrocktiefen",
      "Blackrockspitze",
      "Stratholme",
      "D\195\188sterbruch",
      "Scholomance",
      "Onyxia's Hort",
      "Ruinen von Ahn'Qiraj",
      "Zul'Gurub",
      "Der geschmolzene Kern",
      "Pechschwingenhort",
      "Ahn'Qiraj",
      "Naxxramas",
   }
   
   lrLocale.BGWGTEXT0="Warsong Gulch"
   lrLocale.BGWGTEXT1="The %s flag was picked up by (.+)!"
   lrLocale.BGWGTEXT2="captured the %s flag!"
   lrLocale.BGWGTEXT3="The %s flag was dropped by"
   lrLocale.BGWGTEXT4="The %s flag was returned to its base by"
   
   lrLocale.GANKED="Gegankt von: %s Anzahl: %d"
   -- COMBATHITCRITOTHERSELF = "(.+) trifft Euch kritisch";
   -- COMBATHITOTHERSELF = "(.+) trifft Euch";
   lrLocale.GANKED_CHATS = {
      "(.+) trifft Euch kritisch";
      "(.+) trifft Euch";
   }
   
   


   lrLocale.CC_TTS = {
      Spell_Nature_Sleep         = { "Winterschlaf" },
      Spell_Frost_ChainsOfIce    = { "Eisk\195\164ltefalle" },
      INV_Spear_02               = { "Stich des Fl\195\188geldrachen", "Schlafend" },
      Spell_Nature_Polymorph     = { "Verwandlung" },
      Spell_Holy_PrayerOfHealing = { "Bu\195\159e" },
      Spell_Nature_Slow          = { "Untote Fesseln" },
      Ability_Gouge              = { "Solarplexus" },
      Ability_Sap                = { "Kopfnuss" },
      Spell_Shadow_MindSteal     = { "Blenden" },
   }
   lrLocale.BUFF_TTS = {
      adrenalineRush   = "Adrenalinrausch",
      berserking       = "Berserker",
      bladeFlurry      = "Klingenwirbel",
      blind            = "Blenden",
      cheapShot        = "Fieser Trick",
      coldBlood        = "Kaltbl\195\188tigkeit",
      evasion          = "Entrinnen",
      exposeArmor      = "R\195\188stung schw\195\164chen",
      firstAid         = "Erste Hilfe",
      garrote          = "Erdrosseln",
      ghostlyStrike    = "Geisterhafter Sto\195\159",
      gouge            = "Solarplexus",
      hemorrhage       = "Blutsturz",
      kidneyShot       = "Nierenhieb",
      pickpocket       = "Taschendieb",
      recentlyBandaged = "K\195\188rzlich bandagiert",
      remorseless      = "Gnadenlos",
      rupture          = "Blutung",
      sap              = "Kopfnuss",
      sliceNDice       = "Zerh\195\164ckseln",
      stealth          = "Verstohlenheit",
      vanish           = "Verschwinden",
   }

   
elseif (GetLocale() == "frFR") then
   -- French
   lrLocale.SPELLCASTOTHERSTART = "(.+) commence \195\160 lancer (.+)."
   lrLocale.SPELLPERFORMOTHERSTART = "(.+) commence \195\160 ex\195\169cuter (.+)."
   lrLocale.EVISCERATE_HIT = "Votre Evisc\195\169ration touche (.+) et inflige (%d+) points de d\195\169g\195\162ts."
   lrLocale.EVISCERATE_CRIT = "Votre Evisc\195\169ration inflige un coup critique \195\160 (.+) %((%d+) points de d\195\169g\195\162ts%).";
   lrLocale.MOUNTED_BUFF_TT = "Augmente la vitesse de (%d+)%%."
   --lrLocale.MOUNTED_BUFF_TT = "Augmente la vitesse de mouvement";

   lrLocale.DUEL_COUNTDOWN="D\195\169but du duel : (%d)"
   lrLocale.DUEL_WINNER_KNOCKOUT="(.+) a triomph\195\169 de (.+) lors d'un duel"
   lrLocale.DUEL_WINNER_RETREAT="(.+) s'enfuit de son duel contre (.+)"

   lrLocale.Polymorph_TTS = {
      Spell_Nature_Polymorph = "M\195\169tamorphose"
   }

   -- TBD: BEGIN NEED LOCALIZATION!
   
   lrLocale.IMMUNE=nil
   lrLocale.ImmunityProblemCreatures = nil
   lrLocale.HuntersMark_TTS = nil
   lrLocale.SLOWED_TTS = nil
   lrLocale.STUNNED_TTS = nil
   lrLocale.DOT_TTS = nil
   lrLocale.FEAR_TTS = nil
   lrLocale.IMMOBILE_TTS = nil
   lrLocale.Bleed_TTS = nil
   lrLocale.INSTANCES = nil
   lrLocale.BGWGTEXT0=nil
   lrLocale.GANKED=nil
   lrLocale.GANKED_CHATS = nil

   -- TBD: END NEED LOCALIZATION!

   lrLocale.CC_TTS = {
      Spell_Nature_Sleep         = { "Hibernation" },
      Spell_Frost_ChainsOfIce    = { "Pi\195\168ge givrant" },
      INV_Spear_02               = { "Piq\195\187re de wyverne", "Endormi" },
      Spell_Nature_Polymorph     = { "M\195\169tamorphose" },
      Spell_Holy_PrayerOfHealing = { "Repentir" },
      Spell_Nature_Slow          = { "Entraves des morts-vivants" },
      Ability_Gouge              = { "Suriner" },
      Ability_Sap                = { "Assommer" },
      Spell_Shadow_MindSteal     = { "C\195\169cit\195\169" },
   }
   lrLocale.BUFF_TTS = {
      adrenalineRush   = "Pouss\195\169e d'adr\195\169naline",
      berserking       = "Berserker",
      bladeFlurry      = "D\195\169luge de lames",
      blind            = "C\195\169cit\195\169",
      cheapShot        = "Coup bas",
      coldBlood        = "Sang froid",
      evasion          = "Evasion",
      exposeArmor      = "Exposer l'armure",
      firstAid         = "Premiers soins",
      garrote          = "Garrot",
      ghostlyStrike    = "Frappe fantomatique",
      gouge            = "Suriner",
      hemorrhage       = "H\195\169morragie",
      kidneyShot       = "Aiguillon perfide",
      pickpocket       = "Vol \195\160 la tire",
      recentlyBandaged = "",
      remorseless      = "Attaques impitoyables",
      rupture          = "Rupture",
      sap              = "Assommer",
      sliceNDice       = "D\195\169biter",
      stealth          = "Camouflage",
      vanish           = "Disparition",
   }
end
