
-- French Localization by Olivier Mayeres
if GetLocale() ~= "frFR" then return end
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
ACETIMER.PAT_RANK = "Rang (%d+)"
ACETIMER.FMT_CAST = "%s(Rang %d)"

ACETIMER.DRUID = {
	ABOLISH_POISON    = "Abolir le poison";
	BARKSKIN          = "Ecorce";
	BASH              = "Sonner";
	DASH              = "Célérité";
	DEMORALIZING_ROAR = "Grognement d'intimidation";
	ENRAGE            = "Enrager";
	ENTANGLING_ROOTS  = "Sarments";
	FAERIE_FIRE       = "Lucioles";
	FAERIE_FIRE_FERAL = "Lucioles (farouche)";
	FERAL_CHARGE      = "Charge farouche";
	FRENZIED_REGENERATION = "Régénération frénétique";
	HIBERNATE         = "Hibernation";
	INNERVATE         = "Innervation";
	INSECT_SWARM      = "Essaim d'insectes";
	MOONFIRE          = "Eclat lunaire";
	NATURE_S_GRASP    = "Emprise de la nature";
	POUNCE            = "Traquenard";
	RAKE              = "Griffure";
	REGROWTH          = "Rétablissement";
	REJUVENATION      = "Récupération";
	RIP               = "Déchirure";
	SOOTHE_ANIMAL     = "Apaiser les animaux";
	STARFIRE          = "Feu stellaire";
	TIGER_S_FURY      = "Fureur du tigre";

	BRUTAL_IMPACT     = "Impact brutal";
	NATURE_S_GRACE    = "Grâce de la nature";
	
	CLEARCASTING      = "Idées claires";
	POUNCE_BLEED      = "Traquenard sanglant";
	STARFIRE_STUN     = "Feu stellaire étourdissant";
}

ACETIMER.HUNTER = {
	BESTIAL_WRATH   = "Courroux bestial";
	CONCUSSIVE_SHOT = "Trait de choc";
	COUNTERATTACK   = "Contre-attaque";
	DETERRENCE      = "Dissuasion";
	EXPLOSIVE_TRAP  = "Piège explosif";
	FLARE           = "Sixième sens";
	FREEZING_TRAP   = "Piège gelant";
	FROST_TRAP      = "Piège de givre";
	HUNTER_S_MARK   = "Marque du chasseur";
	IMMOLATION_TRAP = "Piège d'Immolation";
	MONGOOSE_BITE   = "Morsure de la mangouste";
	RAPID_FIRE      = "Tir rapide";
	SCARE_BEAST     = "Effrayer une bête";
	SCATTER_SHOT    = "Flèche de dispersion";
	SCORPID_STING   = "Piqûre de scorpion";
	SERPENT_STING   = "Morsure de serpent";
	VIPER_STING     = "Piqûre de vipère";
	WING_CLIP       = "Coupure d'ailes";
	WYVERN_STING    = "Piqûre de Wyverne";
	
	CLEVER_TRAPS             = "Piège d'Immolation amélioré";
	IMPROVED_CONCUSSIVE_SHOT = "Trait de choc amélioré";
	IMPROVED_WING_CLIP       = "Coupure d'ailes améliorée";

	EXPLOSIVE_TRAP_EFFECT  = "Effet Piège explosif";
	FREEZING_TRAP_EFFECT   = "Effet Piège gelant";
	FROST_TRAP_EFFECT      = "Effet Piège de givre";
	IMMOLATION_TRAP_EFFECT = "Effet Piège immolation";
	QUICK_SHOTS            = "Tir rapide";
}

ACETIMER.MAGE = {
	ARCANE_POWER = "Puissance des arcanes";
	BLAST_WAVE   = "Vague d'Explosions";
	CONE_OF_COLD = "Cône de froid";
	COUNTERSPELL = "Contresort";
	DETECT_MAGIC = "Détection de la magie";
	FIRE_WARD    = "Gardien de feu";
	FIREBALL     = "Boule de feu";
	FLAMESTRIKE  = "Choc de flammes";
	FROST_NOVA   = "Nova de givre";
	FROST_WARD   = "Gardien de givre";
	FROSTBOLT    = "Eclair de givre";
	ICE_BLOCK    = "Parade de glace";
	ICE_BARRIER  = "Barrière de glace";
	MANA_SHIELD  = "Bouclier de mana";
	POLYMORPH    = "Métamorphose";
	PYROBLAST    = "Explosion pyrotechnique";
	SCORCH       = "Brûlure";

	FROSTBITE       = "Morsure de givre";
	IGNITE          = "Enflammer";
	IMPACT          = "Impact";
	IMPROVED_SCORCH = "Brûlure améliorée";
	PERMAFROST      = "Gel prolongé";

	CLEARCASTING          = "Idées claires";
	COUNTERSPELL_SILENCED = "Contresort - Silencieux";
	FIRE_VULNERABILITY    = "Vulnérabilité au feu";
}

ACETIMER.PALADIN = {
	BLESSING_OF_FREEDOM    = "Bénédiction de liberté";
	BLESSING_OF_KINGS      = "Bénédiction des rois";
	BLESSING_OF_LIGHT      = "Bénédiction de lumière";
	BLESSING_OF_MIGHT      = "Bénédiction de puissance";
	BLESSING_OF_PROTECTION = "Bénédiction de protection";
	BLESSING_OF_SACRIFICE  = "Bénédiction de sacrifice";
	BLESSING_OF_SALVATION  = "Bénédiction de salut";
	BLESSING_OF_SANCTUARY  = "Bénédiction du sanctuaire";
	BLESSING_OF_WISDOM     = "Bénédiction de sagesse";
	CONSECRATION           = "Consécration";
	DIVINE_PROTECTION      = "Protection divine";
	DIVINE_SHIELD          = "Bouclier divin";
	HAMMER_OF_JUSTICE      = "Marteau de la justice";
	HAMMER_OF_WRATH        = "Marteau de Courroux";
	HOLY_SHIELD            = "Bouclier divin";
	JUDGEMENT              = "Jugement";
	LAY_ON_HANDS           = "Imposition des mains";
	REPENTANCE             = "Repentir";
	SEAL_OF_COMMAND        = "Sceau d'autorité";
	SEAL_OF_JUSTICE        = "Sceau de justice";
	SEAL_OF_LIGHT          = "Sceau de lumière";
	SEAL_OF_RIGHTEOUSNESS  = "Sceau de piété";
	SEAL_OF_THE_CRUSADER   = "Sceau du Croisé";
	SEAL_OF_WISDOM         = "Sceau de sagesse";
	TURN_UNDEAD            = "Renvoi des morts-vivants";
	
	GUARDIAN_S_FAVOR  = "Bénédiction de protection améliorée";
	LASTING_JUDGEMENT = "Sceau de lumière amélioré";
	REDOUBT           = "Redoute";
	VENGEANCE         = "Vengeance";
	VINDICATION       = "Justification";
	
	FORBEARANCE               = "Longanimité";
	JUDGEMENT_OF_JUSTICE      = "Jugement de justice";
	JUDGEMENT_OF_LIGHT        = "Jugement de lumière";   
	JUDGEMENT_OF_WISDOM       = "Jugement de sagesse"; 
	JUDGEMENT_OF_THE_CRUSADER = "Jugement du Croisé";
}

ACETIMER.PRIEST = {
	ABOLISH_DISEASE   = "Abolir maladie";
	DEVOURING_PLAGUE  = "Peste dévorante";
	ELUNE_S_GRACE     = "Elune's Grace";
	FADE              = "Oubli";
	FEEDBACK          = "Réaction";
	HEX_OF_WEAKNESS   = "Hex de faiblesse";
	HOLY_FIRE         = "Flammes sacrées";
	MIND_SOOTHE       = "Apaisement";
	POWER_INFUSION    = "Infusion de Puissance";
	POWER_WORD_SHIELD = "Mot de pouvoir : Bouclier";
	PSYCHIC_SCREAM    = "Cri psychique";
	RENEW             = "Rénovation";
	SHACKLE_UNDEAD    = "Entraves des morts-vivants";
	SHADOW_WORD_PAIN  = "Mot de l'ombre : Douleur";
	SILENCE           = "Silence";
	STARSHARDS        = "Eclats stellaires";
	TOUCH_OF_WEAKNESS = "Toucher de faiblesse";
	VAMPIRIC_EMBRACE  = "Etreinte vampirique";

	BLACKOUT                   = "Aveuglement";
	BLESSED_RECOVERY           = "Rétablissement Béni";
	IMPROVED_POWER_WORD_SHIELD = "Mot de pouvoir : Bouclier amélioré";
	IMPROVED_SHADOW_WORD_PAIN  = "Mot de l'ombre : Douleur amélioré";
	INSPIRATION                = "Inspiration";
	SHADOW_VULNERABILITY       = "Vulnérabilité à l'ombre";
	SHADOW_WEAVING             = "Tissage de l'ombre";
	SPIRIT_TAP                 = "Connexion spirituelle";

	WEAKENED_SOUL = "Ame affaiblie";
}

ACETIMER.ROGUE = {
	ADRENALINE_RUSH = "Poussée d'adrénaline";
	BLADE_FLURRY    = "Déluge de lames";
	BLIND           = "Cécité";
	CHEAP_SHOT      = "Coup bas";
	DISTRACT        = "Distraction";
	EXPOSE_ARMOR    = "Exposer l'armure";
	EVASION         = "Evasion";
	GARROTE         = "Garrot";
	GOUGE           = "Suriner";
	HEMORRHAGE      = "Hémorragie";
	KICK            = "Coup de pied";
	KIDNEY_SHOT     = "Aiguillon perfide";
	RIPOSTE         = "Riposte";
	RUPTURE         = "Rupture";
	SAP             = "Assommer";
	SLICE_AND_DICE  = "Débiter";
	SPRINT          = "Sprint";
	VANISH          = "Disparition";

	IMPROVED_GOUGE          = "Suriner amélioré";
	IMPROVED_GARROTE        = "Garrot amélioré";
	IMPROVED_EVASION        = "Evasion améliorée";
	IMPROVED_SLICE_AND_DICE = "Débiter amélioré";
	MACE_SPECIALIZATION     = "Spécialisation Masse";
	REMORSELESS_ATTACKS     = "Attaques impitoyables";

	KICK_SILENCED    = "Coup de pied - Silencieux";
	MACE_STUN_EFFECT = "Effet étourdissant de la masse";
	REMORSELESS      = "Impitoyables";
}

ACETIMER.SHAMAN = {
	DISEASE_CLEANSING_TOTEM  = "Totem de Purification des Maladies";
	EARTH_SHOCK              = "Horion de terre";
	EARTHBIND_TOTEM          = "Totem de lien terrestre";
	FIRE_NOVA_TOTEM          = "Totem Nova de feu";
	FIRE_RESISTANCE_TOTEM    = "Totem de résistance au feu";
	FROST_SHOCK              = "Horion de givre";
	FLAME_SHOCK              = "Horion de flammes";
	FLAMETONGUE_TOTEM        = "Totem Langue de feu";
	FROST_RESISTANCE_TOTEM   = "Totem de résistance au Givre";
	GRACE_OF_AIR_TOTEM       = "Totem de Grâce Aérienne";
	GROUNDING_TOTEM          = "Totem de Glèbe";
	HEALING_STREAM_TOTEM     = "Totem guérisseur";
	MAGMA_TOTEM              = "Totem de Magma";
	MANA_SPRING_TOTEM        = "Totem Fontaine de mana";
	MANA_TIDE_TOTEM          = "Totem de Vague de mana";
	NATURE_RESISTANCE_TOTEM  = "Totem de résistance à la Nature";
	POISON_CLEANSING_TOTEM   = "Totem de Purification du poison";
	SEARING_TOTEM            = "Totem incendiaire";
	SENTRY_TOTEM             = "Totem Sentinelle";
	STONECLAW_TOTEM          = "Totem de Griffes de pierre";
	STONESKIN_TOTEM          = "Totem de Peau de pierre";
	STORMSTRIKE              = "Courroux naturel";
	STRENGTH_OF_EARTH_TOTEM  = "Totem de Force de la Terre";
	TRANQUIL_AIR_TOTEM       = "Totem de Tranquilité de l'Air";
	TREMOR_TOTEM             = "Totem de Séisme";
	WINDFURY_TOTEM           = "Totem Furie-des-vents";
	WINDWALL_TOTEM           = "Totem de Mur des vents";

	ANCESTRAL_HEALING        = "Guérison des Ancien";
	EVENTIDE                 = "Tombée du jour";
	IMPROVED_FIRE_NOVA_TOTEM = "Totem de Nova de feu amélioré";
	IMPROVED_STONECLAW_TOTEM = "Totem de Griffes de Pierre Amélioré";
	
	ANCESTRAL_FORTITUDE      = "Robustesse des anciens";
	CLEARCASTING             = "Idées claires";
	ENAMORED_WATER_SPIRIT    = "Esprit de l'eau amoureux";
}

ACETIMER.WARLOCK = {
	AMPLIFY_CURSE         = "Malédiction amplifiée";
	BANISH                = "Bannir";
	CORRUPTION            = "Corruption";
	CURSE_OF_AGONY        = "Malédiction d'agonie";
	CURSE_OF_DOOM         = "Malédiction funeste";
	CURSE_OF_EXHAUSTION   = "Malédiction de fatigue";
	CURSE_OF_RECKLESSNESS = "Malédiction de témérité";
	CURSE_OF_SHADOW       = "Malédiction des ténèbres";
	CURSE_OF_TONGUES      = "Malédiction des langages";
	CURSE_OF_WEAKNESS     = "Malédiction de faiblesse";
	CURSE_OF_THE_ELEMENTS = "Malédiction des éléments";
	DEATH_COIL            = "Voile mortel";
	DRAIN_SOUL            = "Siphon d'âme";
	FEAR                  = "Peur";
	FEL_DOMINATION        = "Domination corrompue";
	ENSLAVE_DEMON         = "Asservir démon";
	HOWL_OF_TERROR        = "Hurlement de terreur";
	IMMOLATE              = "Immolation";
	SHADOW_BOLT           = "Trait de l'ombre";
	SHADOW_WARD           = "Gardien de l'ombre";
	SHADOWBURN            = "Brûlure de l'ombre";
	SIPHON_LIFE           = "Siphon de vie";

	AFTERMATH             = "Conséquences";
	NIGHTFALL             = "Crépuscule";
	PYROCLASM             = "Pyroclasme";
	SACRIFICE             = "Sacrifice";
	SEDUCTION             = "Séduction";

	SHADOW_TRANCE         = "Transe de l'ombre";
	SHADOW_VULNERABILITY  = "Vulnérabilité à l'ombre";
	SOUL_SIPHON           = "Siphon d’âme";
}

ACETIMER.WARRIOR = {
	BATTLE_SHOUT       = "Cri de guerre";
	BERSERKER_RAGE     = "Furie berserker";
	BLOODRAGE          = "Rage sanguinaire";
	BLOODTHIRST        = "Sanguinaire";
	CHARGE             = "Charge";
	CHALLENGING_SHOUT  = "Cri de défi";
	CONCUSSION_BLOW    = "Bourrasque";
	DEATH_WISH         = "Souhait mortel";
	DEMORALIZING_SHOUT = "Cri d'affliction";
	DISARM             = "Désarmement";
	EXECUTE            = "Exécution";
	HAMSTRING          = "Brise-genou";
	INTERCEPT          = "Interception";
	INTIMIDATING_SHOUT = "Cri d’intimidation";
	LAST_STAND         = "Dernier rempart";
	MOCKING_BLOW       = "Coup railleur";
	MORTAL_STRIKE      = "Frappe mortelle";
	OVERPOWER          = "Fulgurance";
	PIERCING_HOWL      = "Hurlement perçant";
	PUMMEL             = "Volée de coups";
	RECKLESSNESS       = "Témérité";
	REND               = "Pourfendre";
	RETALIATION        = "Représailles";
	REVENGE            = "Vengeance";
	SHIELD_BLOCK       = "Maîtrise du blocage";
	SHIELD_BASH        = "Coup de bouclier";
	SHIELD_WALL        = "Mur protecteur";
	SUNDER_ARMOR       = "Fracasser armure";
	SWEEPING_STRIKES   = "Attaques circulaires";
	THUNDER_CLAP       = "Coup de tonnerre";
	
	BOOMING_VOICE         = "Voix tonitruante";
	BLOOD_CRAZE           = "Folie sanguinaire";
	DEEP_WOUNDS           = "Blessures profondes";
	ENRAGE                = "Enrager";
	FLURRY                = "Rafale";
	IMPROVED_DISARM       = "Désarmement amélioré";
	IMPROVED_HAMSTRING    = "Brise-genou amélioré";
	IMPROVED_SHIELD_BLOCK = "aîtrise du blocage améliorée";
	IMPROVED_SHIELD_WALL  = "Mur protecteur amélioré";
	MACE_SPECIALIZATION   = "Spécialisation Masse";

	CHARGE_STUN          = "Charge étourdissante";
	INTERCEPT_STUN       = "Bloquer Etourdissemen";
	MACE_STUN_EFFECT     = "Effet étourdissant de la masse";
	REVENGE_STUN         = "Etourdissement vengeur";
	SHIELD_BASH_SILENCED = "Coup de bouclier - silencieux";
}

