--
-- Language DE (deDE)
--

if ( GetLocale() == "deDE" ) then

	-- -- --- --- -- --
	-- LANGUAGE VARS --	-- German/Deutsch
	-- -- --- --- -- --
	-- 
	NL_LANG_RANK			= "Rang";
	NL_MOVE_TOOLTIP			= "Linksklick und gedr\195\188ckt halten zum Verschieben.\nRechtsklick zur Konfiguration.\nMittlerer Klick zum Minimieren.";
	NL_MOVE_TOOLTIP_MINI	= "Rechtsklick zur Konfiguration.\nMittlererklick zur Maximierung.";

	NL_WELLFED				= "Satt";
	NL_HEALTH				= "Leben";
	NL_MANA					= "Mana";
	
	NL_NEVERSHOW			= "Ignorierte Spieler";
	NL_STICKYUNITS			= "Spieler Permanent anzeigen";
	NL_RESURRECT			= "Wiederbelebung";
	NL_CURSE				= "Fluch";
	NL_DISEASE				= "Krankheit";
	NL_POISON				= "Gift";
	NL_MAGIC_DEBUFF			= "Negativer Magie Effekt";
	NL_CLICKANDDRAG			= "Klicken und geklickt halten sowie verschieben um die Priorit\195\164t zu \195\164ndern.";
	NL_USEWHENSOLO			= "Zeige wenn allein";
	NL_USEINPARTY			= "Zeige in Gruppe";
	NL_USEINRAID			= "Zeige in Schlachtzug";
	NL_SHOWHEALTHBAR		= "Zeige Lebensbalken";
	NL_SHOWRAGEMANAENERGY	= "Zeige Mana/Wut/Energie";
	NL_USECASTPARTYCLICKS	= "Verwende CastParty Klicks";
	NL_LARGENEEDICONS		= "Grosse Buff Kn\195\182pfe";
	NL_GROWLISTUPWARD		= "Liste nach oben \195\182ffnen";
	NL_COLORFRAMESBYCLASS	= "Klassen farbig kennzeichnen";
	ML_SHOWTARGETMONITOR	= "Zeige Ziel des Spielers an";
	NL_SHOWHEALTHASNUMBER	= "Zeige Leben als Zahl";
	NL_SHOWHEALTHLOST		= "Zeige Lebensdefizit";
	NL_SHOWNEEDICONS		= "Zeige Ben\195\182tigte Symbole";
	NL_SHOWBUFFS			= "Zeige Buffs";
	NL_SHOWHEALBUFFS		= "Zeige heilende Buffs";
	NL_SHOWDEBUFFS			= "Zeige negative Buffs";
	NL_SHOWNEEDONLEFT		= "Zeige ben\195\182tigte Buffs links";
	NL_AUTOSORT				= "Automatisch Sortieren";
	NL_SHOWTOOLTIP			= "Zeige Maustips an";
	NL_WISPERCASTNOTIFY		= "Fl\195\188stere Buffs an Spieler";
	NL_HIDELISTWHENEMTPY	= "Verberge die Liste wenn leer";

	
	-- Priester
	NL_PRIEST_NAME			= "Priester";
	NL_PRIEST_FORTITUDE		= "Machtwort: Seelenst\195\164rke";
	NL_PRIEST_FORTITUDE_PRAYER	= "Gebet der Seelenst\195\164rke";
	NL_PRIEST_SHADOWPROT		= "Schattenschutz";
	NL_PRIEST_SHADOWPROT_PRAYER	= "Gebet des Schattenschutzes";
	NL_PRIEST_PW_SHIELD		= "Machtwort: Schild";
	NL_PRIEST_SPIRIT		= "G\195\182ttlicher Willen";
	NL_PRIEST_SPIRIT_PRAYER		= "Gebet der Willenskraft";
	NL_PRIEST_FEARWARD		= "Furchtzauberschutz";
	NL_PRIEST_INNERFIRE		= "Inneres Feuer";
	NL_PRIEST_DISEASE		= "Krankheit Heilen";
	NL_PRIEST_DISEASE_ABOLISH	= "Krankheit Aufheben";
	NL_PRIEST_MAGIC			= "Magiebannung";
	NL_PRIEST_RESURRECT		= "Auferstehung";
	NL_PRIEST_TOUCHOFWEAKNESS	= "Ber\195\188hrung der Schw\195\164che";		
	NL_PRIEST_FEEDBACK		= "R\195\188ckkopplung";				
	NL_PRIEST_SHADOWGUARD		= "Schattenschild";			

	-- Warrior
	NL_WARRIOR_NAME			= "Krieger";
	NL_WARRIOR_BATTLESHOUT		= "Schlachtruf";

	-- Rogue
	NL_ROGUE_NAME			= "Schurke";
	NL_ROGUE_DETECTTRAPS		= "Fallen entdecken";
	NL_ROGUE_MAINHANDPOISON		= "Waffenhand Gift";
	NL_ROGUE_OFFHANDPOISON		= "Nebenhand Gift";
	
	-- Mage
	NL_MAGE_NAME			= "Magier";
	NL_MAGE_INTELLECT		= "Arkane Intelligenz";
	NL_MAGE_INTELLECT_BIG		= "Arkane Brillanz";
	NL_MAGE_MAGEARMOR		= "Magische R\195\188stung";
	NL_MAGE_FROSTARMOR		= "Frostr\195\188stung";
	NL_MAGE_ICEARMOR		= "Eisr\195\188stung";
	NL_MAGE_AMPLIFYMAGIC		= "Magie verst\195\164rken";
	NL_MAGE_DAMPENMAGIC		= "Magied\195\164mpfer";
	NL_MAGE_MANASHIELD		= "Manaschild";
	NL_MAGE_REMOVELESSERCURSE	= "Geringen Fluch aufheben";
	
	-- Warlock
	NL_WARLOCK_NAME			= "Hexenmeister";
	NL_WARLOCK_SOULSTONE		= "Seelenstein-Auferstehung";
	NL_WARLOCK_DEMONSKIN		= "D\195\164monenhaut";
	NL_WARLOCK_DEMONARMOR		= "D\195\164monenr\195\188stung";
	NL_WARLOCK_UNENDINGBREATH	= "Unendlicher Atem";
	NL_WARLOCK_DETECT_LESS_INVISI   = "Geringe Unsichtbarkeit entdecken";
	NL_WARLOCK_DETECT_INVISIBILITY  = "Unsichtbarkeit entdecken";
	NL_WARLOCK_DETECT_BIG_INVISI    = "Gro\195\159e Unsichtbarkeit entdecken";
	NL_WARLOCK_DETECT_FIRESHIELD	= "Feuerschild";
	
	-- Paladin
	NL_PALADIN_NAME			= "Paladin";
	NL_PALADIN_BLESS_MIGHT		= "Segen der Macht";
	NL_PALADIN_BLESS_MIGHT_BIG	= "Gro\195\159er Segen der Macht";
	NL_PALADIN_BLESS_WISDOM		= "Segen der Weisheit";
	NL_PALADIN_BLESS_WISDOM_BIG	= "Gro\195\159er Segen der Weisheit";
	NL_PALADIN_BLESS_KINGS		= "Segen der K\195\182nige";
	NL_PALADIN_BLESS_KINGS_BIG	= "Gro\195\159er Segen der K\195\182nige";
	NL_PALADIN_BLESS_SALVATION	= "Segen der Rettung";
	NL_PALADIN_BLESS_SALVATION_BIG	= "Gro\195\159er Segen der Rettung";
	NL_PALADIN_BLESS_LIGHT		= "Segen des Lichts";
	NL_PALADIN_BLESS_LIGHT_BIG	= "Gro\195\159er Segen des Lichts";
	NL_PALADIN_SANCTUARY		= "Segen des Refugiums";
	NL_PALADIN_SANCTUARY_BIG	= "Gro\195\159er Segen des Refugiums";
	NL_PALADIN_POISON		= "L\195\164utern";			
	NL_PALADIN_DISEASE		= "Reinigung des Glaubens";
	NL_PALADIN_RESURRECTION		= "Erl\195\182sung";

	-- Druid
	NL_DRUID_NAME			= "Druide";
	NL_DRUID_MOTW			= "Mal der Wildnis";
	NL_DRUID_GOTW			= "Gabe der Wildnis";
	NL_DRUID_THORNS			= "Dornen";
	NL_DRUID_CLARITY                = "Omen der Klarsicht";
	NL_DRUID_POISON			= "Vergiftung heilen";
	NL_DRUID_POISON_ABOLISH		= "Vergiftung aufheben";
	NL_DRUID_CURSE			= "Fluch aufheben";
	NL_DRUID_RESURRECTION           = "Wiedergeburt";

	-- Hunter
	NL_HUNTER_NAME			= "J\195\164ger";

	-- Shaman
	NL_SHAMAN_NAME                  = "Schamane";
	NL_SHAMAN_LIGHTNINGSHIELD       = "Blitzschlagschild";
	NL_SHAMAN_ROCKBITER             = "Felsbei\195\159erwaffe";
	NL_SHAMAN_FLAMETONGUE           = "Waffe der Flammenzunge";
	NL_SHAMAN_FROSTBRAND            = "Waffe des Frostbrands";
	NL_SHAMAN_WINDFURY              = "Waffe des Windfurors";
	NL_SHAMAN_POISON                = "Vergiftung heilen";
	NL_SHAMAN_DISEASE               = "Krankheit heilen";
	NL_SHAMAN_RESURRECTION          = "Geist der Ahnen";
	
	-- Beast
	NL_BEAST_NAME			= "Bestie";

	-- Demon
	NL_DEMON_NAME			= "Demon";
	
	-- Dwarf
	NL_DWARF_NAME			= "Zwerg";
	
	-- Undead
	NL_UNDEAD_NAME			= "Untoter";

	-- Human
	NL_HUMAN_NAME			= "Mensch";

	-- Troll
	NL_TROLL_NAME			= "Troll";

	-- Factions
	NL_FACTION_ALLIANCE		= "Alliance";
	NL_FACTION_HORDE		= "Horde";

	NL_NEEDY_CONFIG			= "Needy List Konfiguration";
	NL_CONFIG_SPELLS		= "Einstellungen";
	NL_CONFIG_NEEDS			= "Buff Einstellungen";
	NL_SAVE					= "Sichern";
	NL_CANCEL				= "Abbruch";
	NL_STR_FRAME_WIDTH		= "Fenster breite:";
	NL_STR_MAX_UNITS		= "Maximale Anzahl gezeigter Spieler:";
	NL_STR_BLACKLIST_TIMER	= "Ausser Reichweite Spieler ignorieren f\195\188r (in Sek):";
	
	NL_CONFIG_SPELL_DESC	= "Einstellung der Zauber oder Items in eckigen Klammern [ ].";
	NL_CONFIG_SPELL_HEAL1	= "Linker Maustaste:";
	NL_CONFIG_SPELL_HEAL2	= "Rechter Maustaste:";
	NL_CONFIG_SPELL_HEAL3	= "Mittlerer Maustaste:";
	NL_CONFIG_SPELL_HEAL4	= "4. Maustaste:";
	NL_CONFIG_SPELL_HEAL5	= "5. Maustaste:";
	
	NL_LOAD_DEFAULTS		= "Zur\195\188cksetzen";

	NL_FILTER_NAMES_DESC	= "Liste der Spieler, Komma zum Trennen:";	
	NL_FILTERS				= "Filter";
	NL_FILTER_PARTIES_ALL	= "alle Gruppen";
	NL_FILTER_PARTIES_NONE	= "keine Gruppe";
	NL_FILTER_CLASSES_ALL	= "alle Klassen";
	NL_FILTER_CLASSES_NONE	= "keine Klasse";
	
	NL_PARTY1				= "Gruppe 1";
	NL_PARTY2				= "Gruppe 2";
	NL_PARTY3				= "Gruppe 3";
	NL_PARTY4				= "Gruppe 4";
	NL_PARTY5				= "Gruppe 5";
	NL_PARTY6				= "Gruppe 6";
	NL_PARTY7				= "Gruppe 7";
	NL_PARTY8				= "Gruppe 8";
	NL_MYPARTY				= "meine Grp";

	NL_FILTER_TYPE_NAMES = { Everyone="Alle", Units="Spieler", Multi="Gemischt" };
	
	BINDING_HEADER_NEEDYLIST = "Needy List";
	BINDING_NAME_NEEDYLIST_CURETOP = "Ersten De/Buffen mit Hauptfunktion";
	BINDING_NAME_NEEDYLIST_CURETOP_ALTERNATE = "Ersten De/Buffen mit Nebenfunktion";
	BINDING_NAME_NEEDYLIST_SORTUNITS = "Sortiere Spieler";
	BINDING_NAME_NEEDYLIST_MINIMIZE = "Verkleinere Needy List";
	BINDING_NAME_NEEDYLIST_CONFIGURE = "Konfiguriere Needy List";

	NL_STR_INTRO_PREFIX		= "Ralak's Needy List v";
	NL_STR_INTRO_SUFFIX		= " erfolgreich geladen.";
	NL_STR_INTRO_DESC		= "Rechtsklick auf den Needy List Knopf oder gebe /nlconfig ein für Optionen.";
-- end deDE

elseif ( GetLocale() == "frFR" ) then

	-- -- --- --- -- --
	-- LANGUAGE VARS --	-- French/Francais
	-- -- --- --- -- --
	-- 
	NL_LANG_RANK			= "Rang";
	NL_MOVE_TOOLTIP			= "Clic gauche et maintenir pour d\195\169placer.\nClic droit pour Configuration.\nClic du milieu pour minimaliser.";
	NL_MOVE_TOOLTIP_MINI	= "Clic droit pour Configuration.\nClic du milieu pour maximaliser.";

	NL_WELLFED				= "Bien Nourri";
	NL_HEALTH				= "Vie";
	NL_MANA					= "Mana";
	
	NL_NEVERSHOW			= "Ignorer le jouer";
	NL_STICKYUNITS			= "Toujours montrer le joueur";
	NL_RESURRECT			= "R\195\169surrection";
	NL_CURSE				= "Mal\195\169diction";
	NL_DISEASE				= "Maladie";
	NL_POISON				= "Poison";
	NL_MAGIC_DEBUFF			= "Debuff";
	NL_CLICKANDDRAG			= "Clic et maintenir en glissant pour modifier les priorit\195\169s.";
	NL_USEWHENSOLO			= "Utiliser en solo";
	NL_USEINPARTY			= "Utiliser en groupe";
	NL_USEINRAID			= "Utiliser en Raid";
	NL_SHOWHEALTHBAR		= "Montrer barre de vie";
	NL_SHOWRAGEMANAENERGY	= "Montrer Mana/Rage/Energie";
	NL_USECASTPARTYCLICKS	= "Utiliser clics CastParty";
	NL_LARGENEEDICONS		= "Grandes ic\195\180nes";
	NL_GROWLISTUPWARD		= "Ouvrir la liste vers le haut";
	NL_COLORFRAMESBYCLASS	= "Couleurs par classe";
	ML_SHOWTARGETMONITOR	= "Montrer moniteur";
	NL_SHOWHEALTHASNUMBER	= "Vie en chiffre";
	NL_SHOWHEALTHLOST		= "Montrer perte de vie";
	NL_SHOWNEEDICONS		= "Montrer ic\195\180nes de besoin";
	NL_SHOWBUFFS			= "Montrer les buffs";
	NL_SHOWHEALBUFFS		= "Montrer les buffs de soins";
	NL_SHOWDEBUFFS			= "Montrer les debuffs";
	NL_SHOWNEEDONLEFT		= "Montrer les besoins \195\160 gauche";
	NL_AUTOSORT				= "Tri automatique";
	NL_SHOWTOOLTIP			= "Montrer les tooltips";
	NL_WISPERCASTNOTIFY		= "Chuchoter les sorts au joueur";
	NL_HIDELISTWHENEMTPY	= "Cacher la liste quand vide";

	
	-- Priester
	NL_PRIEST_NAME			= "Pr\195\170tre";
	NL_PRIEST_FORTITUDE		= "Mot de pouvoir : Robustesse";
	NL_PRIEST_FORTITUDE_PRAYER	= "Pri\195\168re de robustesse";
	NL_PRIEST_SHADOWPROT		= "Protection contre l'Ombre";
	NL_PRIEST_SHADOWPROT_PRAYER	= "Pri\195\168re de protection contre l'Ombre";
	NL_PRIEST_PW_SHIELD		= "Mot de pouvoir : Bouclier";
	NL_PRIEST_SPIRIT		= "Esprit divin";
	NL_PRIEST_SPIRIT_PRAYER		= "Pri\195\168re d'Esprit";
	NL_PRIEST_FEARWARD		= "Gardien de peur";
	NL_PRIEST_INNERFIRE		= "Feu int\195\169rieur";
	NL_PRIEST_DISEASE		= "Gu\195\169rison des maladies";
	NL_PRIEST_DISEASE_ABOLISH	= "Abolir maladie";
	NL_PRIEST_MAGIC			= "Dissipation de la magie";
	NL_PRIEST_RESURRECT		= "R\195\169surrection";
	NL_PRIEST_TOUCHOFWEAKNESS	= "Toucher de faiblesse";			
	NL_PRIEST_FEEDBACK		= "R\195\169action";				
	NL_PRIEST_SHADOWGUARD		= "Garde de l'ombre";			

	-- Warrior
	NL_WARRIOR_NAME			= "Guerrier";
	NL_WARRIOR_BATTLESHOUT		= "Cri de guerre";

	-- Rogue
	NL_ROGUE_NAME			= "Voleur";
	NL_ROGUE_DETECTTRAPS		= "D\195\169tection des pi\195\168ges";
	NL_ROGUE_MAINHANDPOISON		= "Poison arme principale";
	NL_ROGUE_OFFHANDPOISON		= "Poison arme secondaire";
	
	-- Mage
	NL_MAGE_NAME			= "Mage";
	NL_MAGE_INTELLECT		= "Intelligence des arcanes";
	NL_MAGE_INTELLECT_BIG		= "Illumination des arcanes";
	NL_MAGE_MAGEARMOR		= "Armure du mage";
	NL_MAGE_FROSTARMOR		= "Armure de givre";
	NL_MAGE_ICEARMOR		= "Armure de glace";
	NL_MAGE_AMPLIFYMAGIC		= "Amplification de la magie";
	NL_MAGE_DAMPENMAGIC		= "Att\195\169nuation de la magie";
	NL_MAGE_MANASHIELD		= "Bouclier de mana";
	NL_MAGE_REMOVELESSERCURSE	= "D\195\169livrance de la mal\195\169diction mineure";
	
	-- Warlock
	NL_WARLOCK_NAME			= "D\195\169moniste";
	NL_WARLOCK_SOULSTONE		= "R\195\169surrection de Pierre d'\195\162me";
	NL_WARLOCK_DEMONSKIN		= "Peau de d\195\169mon";
	NL_WARLOCK_DEMONARMOR		= "Armure d\195\169moniaque";
	NL_WARLOCK_UNENDINGBREATH	= "Respiration interminable";
	NL_WARLOCK_DETECT_LESS_INVISI   = "D\195\169tection de l'invisibilit\195\169 inf\195\169rieure";
	NL_WARLOCK_DETECT_INVISIBILITY  = "D\195\169tection de l'invisibilit\195\169";
	NL_WARLOCK_DETECT_BIG_INVISI    = "D\195\169tection de l'invisibilit\195\169 sup\195\169rieure";
	NL_WARLOCK_DETECT_FIRESHIELD	= "Bouclier de feu";
	
	-- Paladin
	NL_PALADIN_NAME			= "Paladin";
	NL_PALADIN_BLESS_MIGHT		= "B\195\169n\195\169diction de puissance";
	NL_PALADIN_BLESS_MIGHT_BIG	= "B\195\169n\195\169diction de puissance sup\195\169rieure";
	NL_PALADIN_BLESS_WISDOM		= "B\195\169n\195\169diction de sagesse";
	NL_PALADIN_BLESS_WISDOM_BIG	= "B\195\169n\195\169diction de sagesse sup\195\169rieure";
	NL_PALADIN_BLESS_KINGS		= "B\195\169n\195\169diction des rois";
	NL_PALADIN_BLESS_KINGS_BIG	= "B\195\169n\195\169diction des rois sup\195\169rieure";
	NL_PALADIN_BLESS_SALVATION	= "B\195\169n\195\169diction de salut";
	NL_PALADIN_BLESS_SALVATION_BIG	= "B\195\169n\195\169diction de salut sup\195\169rieure";
	NL_PALADIN_BLESS_LIGHT		= "B\195\169n\195\169diction de lumière";
	NL_PALADIN_BLESS_LIGHT_BIG	= "B\195\169n\195\169diction de lumière sup\195\169rieure";
	NL_PALADIN_SANCTUARY		= "B\195\169n\195\169diction du sanctuaire";
	NL_PALADIN_SANCTUARY_BIG	= "B\195\169n\195\169diction du sanctuaire sup\195\169rieure";
	NL_PALADIN_POISON		= "Purification";			
	NL_PALADIN_DISEASE		= "Epuration";
	NL_PALADIN_RESURRECTION		= "R\195\169demption";

	-- Druid
	NL_DRUID_NAME			= "Druide";
	NL_DRUID_MOTW			= "Marque du fauve";
	NL_DRUID_GOTW			= "Don du fauve";
	NL_DRUID_THORNS			= "Epines";
	NL_DRUID_CLARITY                = "Augure de clart\195\169";
	NL_DRUID_POISON			= "Gu\195\169rison du poison";
	NL_DRUID_POISON_ABOLISH		= "Abolir le poison";
	NL_DRUID_CURSE			= "D\195\169livrance de la mal\195\169diction";
	NL_DRUID_RESURRECTION           = "Renaissance";

	-- Hunter
	NL_HUNTER_NAME			= "Chasseur";

	-- Shaman
	NL_SHAMAN_NAME                  = "Chaman";
	NL_SHAMAN_LIGHTNINGSHIELD       = "Bouclier de foudre";
	NL_SHAMAN_ROCKBITER             = "Arme Croque-roc";
	NL_SHAMAN_FLAMETONGUE           = "Arme Langue de Feu";
	NL_SHAMAN_FROSTBRAND            = "Arme de givre";
	NL_SHAMAN_WINDFURY              = "Arme Furie-des-vents";
	NL_SHAMAN_POISON                = "Gu\195\169rison du poison";
	NL_SHAMAN_DISEASE               = "Gu\195\169rison des maladies";
	NL_SHAMAN_RESURRECTION          = "Esprit ancestral";
	
	-- Beast
	NL_BEAST_NAME			= "B\195\170te";

	-- Demon
	NL_DEMON_NAME			= "D\195\169mon";
	
	-- Dwarf
	NL_DWARF_NAME			= "Nain";
	
	-- Undead
	NL_UNDEAD_NAME			= "Mort-Vivant";

	-- Human
	NL_HUMAN_NAME			= "Humain";

	-- Troll
	NL_TROLL_NAME			= "Troll";

	-- Factions
	NL_FACTION_ALLIANCE		= "Alliance";
	NL_FACTION_HORDE		= "Horde";

	NL_NEEDY_CONFIG			= "Configuration Needy List";
	NL_CONFIG_SPELLS		= "Options des sorts";
	NL_CONFIG_NEEDS			= "Options des besoins";
	NL_SAVE					= "Sauver";
	NL_CANCEL				= "Cancel";
	NL_STR_FRAME_WIDTH		= "Largeur de fen\195\170tre:";
	NL_STR_MAX_UNITS		= "Nombre max. de joueurs \195\160 afficher:";
	NL_STR_BLACKLIST_TIMER	= "Nombre de seconde sur liste noire (pour les joueurs trop \195\169loign\195\169s):";
	
	NL_CONFIG_SPELL_DESC	= "Introduisez les sorts ou objects entre [ ].";
	NL_CONFIG_SPELL_HEAL1	= "Clic gauche:";
	NL_CONFIG_SPELL_HEAL2	= "Clic droit:";
	NL_CONFIG_SPELL_HEAL3	= "Clic du milieu:";
	NL_CONFIG_SPELL_HEAL4	= "Bouton 4:";
	NL_CONFIG_SPELL_HEAL5	= "Bouton 5:";
	
	NL_LOAD_DEFAULTS		= "Config. par d\195\169faut";

	NL_FILTER_NAMES_DESC	= "Liste des joueurs, s\195\169par\195\169s par ',':";	
	NL_FILTERS				= "Filtre";
	NL_FILTER_PARTIES_ALL	= "tous les groupes";
	NL_FILTER_PARTIES_NONE	= "aucun groupe";
	NL_FILTER_CLASSES_ALL	= "toutes les classes";
	NL_FILTER_CLASSES_NONE	= "aucune classe";
	
	NL_PARTY1				= "Groupe 1";
	NL_PARTY2				= "Groupe 2";
	NL_PARTY3				= "Groupe 3";
	NL_PARTY4				= "Groupe 4";
	NL_PARTY5				= "Groupe 5";
	NL_PARTY6				= "Groupe 6";
	NL_PARTY7				= "Groupe 7";
	NL_PARTY8				= "Groupe 8";
	NL_MYPARTY				= "mon Groupe";

	NL_FILTER_TYPE_NAMES = { Everyone="Tous", Units="Joueurs", Multi="Multi" };
	
	BINDING_HEADER_NEEDYLIST = "Needy List";
	BINDING_NAME_NEEDYLIST_CURETOP = "Cure Top Need";
	BINDING_NAME_NEEDYLIST_CURETOP_ALTERNATE = "Cure Top Need Alternate";
	BINDING_NAME_NEEDYLIST_SORTUNITS = "Trier les joueurs";
	BINDING_NAME_NEEDYLIST_MINIMIZE = "Minimiser Needy List";
	BINDING_NAME_NEEDYLIST_CONFIGURE = "Configurer Needy List";

	NL_STR_INTRO_PREFIX		= "Ralak's Needy List v";
	NL_STR_INTRO_SUFFIX		= " charg\195\169.";
	NL_STR_INTRO_DESC		= "Clic droit sur le bouton Needy List ou taper /nlconfig pour les Options.";
-- end frFR


else
	-- Language English (default)
	
	-- -- --- --- -- --
	-- LANGUAGE VARS --	-- English
	-- -- --- --- -- --
	
	NL_LANG_RANK			= "Rank";
	NL_MOVE_TOOLTIP			= "Left-click and drag to move Needy List.\nRight-click for configuration options.\nMiddle-click to minimize.";
	NL_MOVE_TOOLTIP_MINI		= "Right-click for configuration options.\nMiddle-click to show list (and allow movement of list).";
	NL_WELLFED			= "Well Fed";
	NL_HEALTH			= "Health";
	NL_MANA				= "Mana";
	NL_NEVERSHOW			= "Unmonitored Units";
	NL_STICKYUNITS			= "Stickied Units";
	NL_RESURRECT			= "Resurrection";
	NL_CURSE			= "Curse";
	NL_DISEASE			= "Disease";
	NL_POISON			= "Poison";
	NL_MAGIC_DEBUFF			= "Magic Debuff";
	NL_CLICKANDDRAG			= "Click and drag up or down to change need priority.";
	NL_USEWHENSOLO			= "Use when solo";
	NL_USEINPARTY			= "Use in party";
	NL_USEINRAID			= "Use in raid";
	NL_SHOWHEALTHBAR		= "Show health bar";
	NL_SHOWRAGEMANAENERGY		= "Show mana/rage/energy bar";
	NL_USECASTPARTYCLICKS		= "Use CastParty clicks";
	NL_LARGENEEDICONS		= "Large need icons";
	NL_GROWLISTUPWARD		= "Grow list upward";
	NL_COLORFRAMESBYCLASS		= "Color frames by class";
	ML_SHOWTARGETMONITOR		= "Show target monitor";
	NL_SHOWHEALTHASNUMBER		= "Show health as a number";
	NL_SHOWHEALTHLOST		= "Show health lost";
	NL_SHOWNEEDICONS		= "Show need icons";
	NL_SHOWBUFFS			= "Show buffs";
	NL_SHOWHEALBUFFS		= "Show heal buffs";
	NL_SHOWDEBUFFS			= "Show debuffs";
	NL_SHOWNEEDONLEFT		= "Show needs on left";
	NL_AUTOSORT			= "Auto sort";
	NL_SHOWTOOLTIP			= "Show tooltips";
	NL_WISPERCASTNOTIFY		= "Whisper casting notification";
	NL_HIDELISTWHENEMTPY		= "Hide list when empty";
	
	-- Priest
	NL_PRIEST_NAME			= "Priest";
	NL_PRIEST_FORTITUDE		= "Power Word: Fortitude";
	NL_PRIEST_FORTITUDE_PRAYER	= "Prayer of Fortitude";
	NL_PRIEST_SHADOWPROT		= "Shadow Protection";
	NL_PRIEST_SHADOWPROT_PRAYER	= "Prayer of Shadow Protection";
	NL_PRIEST_PW_SHIELD		= "Power Word: Shield";
	NL_PRIEST_SPIRIT		= "Divine Spirit";
	NL_PRIEST_SPIRIT_PRAYER		= "Prayer of Spirit";
	NL_PRIEST_FEARWARD		= "Fear Ward";
	NL_PRIEST_INNERFIRE		= "Inner Fire";
	NL_PRIEST_DISEASE		= "Cure Disease";
	NL_PRIEST_DISEASE_ABOLISH	= "Abolish Disease";
	NL_PRIEST_MAGIC			= "Dispel Magic";
	NL_PRIEST_RESURRECT		= "Resurrection";
	NL_PRIEST_TOUCHOFWEAKNESS	= "Touch of Weakness";
	NL_PRIEST_FEEDBACK		= "Feedback";
	NL_PRIEST_SHADOWGUARD		= "Shadowguard";
	
	-- Warrior
	NL_WARRIOR_NAME			= "Warrior";
	NL_WARRIOR_BATTLESHOUT		= "Battle Shout";
	
	-- Rogue
	NL_ROGUE_NAME			= "Rogue";
	NL_ROGUE_DETECTTRAPS		= "Detect Traps";
	NL_ROGUE_MAINHANDPOISON		= "Mainhand Poison";
	NL_ROGUE_OFFHANDPOISON		= "Offhand Poison";
	
	-- Mage
	NL_MAGE_NAME			= "Mage";
	NL_MAGE_INTELLECT		= "Arcane Intellect";
	NL_MAGE_INTELLECT_BIG		= "Arcane Brilliance";
	NL_MAGE_MAGEARMOR		= "Mage Armor";
	NL_MAGE_FROSTARMOR		= "Frost Armor";
	NL_MAGE_ICEARMOR		= "Ice Armor";
	NL_MAGE_AMPLIFYMAGIC		= "Amplify Magic";
	NL_MAGE_DAMPENMAGIC		= "Dampen Magic";
	NL_MAGE_MANASHIELD		= "Mana Shield";
	NL_MAGE_REMOVELESSERCURSE	= "Remove Lesser Curse";
	
	-- Warlock
	NL_WARLOCK_NAME			= "Warlock";
	NL_WARLOCK_SOULSTONE		= "Soulstone Resurrection";
	NL_WARLOCK_DEMONSKIN		= "Demon Skin";
	NL_WARLOCK_DEMONARMOR		= "Demon Armor";
	NL_WARLOCK_UNENDINGBREATH	= "Unending Breath";
	NL_WARLOCK_DETECT_LESS_INVISI	= "Detect Lesser Invisibility";
	NL_WARLOCK_DETECT_INVISIBILITY	= "Detect Invisibility";
	NL_WARLOCK_DETECT_BIG_INVISI	= "Detect Greater Invisibility";
	NL_WARLOCK_DETECT_FIRESHIELD	= "Fire Shield";
		
	-- Paladin
	NL_PALADIN_NAME			= "Paladin";
	NL_PALADIN_BLESS_MIGHT		= "Blessing of Might";
	NL_PALADIN_BLESS_MIGHT_BIG	= "Greater Blessing of Might";
	NL_PALADIN_BLESS_WISDOM		= "Blessing of Wisdom";
	NL_PALADIN_BLESS_WISDOM_BIG	= "Greater Blessing of Wisdom";
	NL_PALADIN_BLESS_KINGS		= "Blessing of Kings";
	NL_PALADIN_BLESS_KINGS_BIG	= "Greater Blessing of Kings";
	NL_PALADIN_BLESS_SALVATION	= "Blessing of Salvation";
	NL_PALADIN_BLESS_SALVATION_BIG	= "Greater Blessing of Salvation";
	NL_PALADIN_BLESS_LIGHT		= "Blessing of Light";
	NL_PALADIN_BLESS_LIGHT_BIG	= "Greater Blessing of Light";
	NL_PALADIN_SANCTUARY		= "Blessing of Sanctuary";
	NL_PALADIN_SANCTUARY_BIG	= "Greater Blessing of Sanctuary";
	NL_PALADIN_POISON		= "Purify";
	NL_PALADIN_DISEASE		= "Cleanse";
	NL_PALADIN_RESURRECTION		= "Redemption";
		
	-- Druid
	NL_DRUID_NAME			= "Druid";
	NL_DRUID_MOTW			= "Mark of the Wild";
	NL_DRUID_GOTW			= "Gift of the Wild";
	NL_DRUID_THORNS			= "Thorns";
	NL_DRUID_CLARITY		= "Omen of Clarity";
	NL_DRUID_POISON			= "Cure Poison";
	NL_DRUID_POISON_ABOLISH		= "Abolish Poison";
	NL_DRUID_CURSE			= "Remove Curse";
	NL_DRUID_RESURRECTION		= "Rebirth";
		
	-- Hunter
	NL_HUNTER_NAME			= "Hunter";
	
	-- Shaman
	NL_SHAMAN_NAME			= "Shaman";
	NL_SHAMAN_LIGHTNINGSHIELD	= "Lightning Shield";
	NL_SHAMAN_ROCKBITER		= "Rockbiter Weapon";
	NL_SHAMAN_FLAMETONGUE		= "Flametongue Weapon";
	NL_SHAMAN_FROSTBRAND		= "Frostbrand Weapon";
	NL_SHAMAN_WINDFURY		= "Windfury Weapon";
	NL_SHAMAN_POISON		= "Cure Poison";
	NL_SHAMAN_DISEASE		= "Cure Disease";
	NL_SHAMAN_RESURRECTION		= "Ancestral Spirit";
	
	-- Beast
	NL_BEAST_NAME			= "Beast";
	
	-- Demon
	NL_DEMON_NAME			= "Demon";
	
	-- Dwarf
	NL_DWARF_NAME			= "Dwarf";

	-- Undead
	NL_UNDEAD_NAME			= "Undead";

	-- Human
	NL_HUMAN_NAME			= "Human";

	-- Troll
	NL_TROLL_NAME			= "Troll";

	-- Factions
	NL_FACTION_ALLIANCE		= "Alliance";
	NL_FACTION_HORDE		= "Horde";

	NL_NEEDY_CONFIG			= "Needy List Configuration";

	NL_CONFIG_SPELLS		= "Configure Spells";
	NL_CONFIG_NEEDS			= "Configure Needs";
	NL_SAVE					= "Save";
	NL_CANCEL				= "Cancel";
	NL_STR_FRAME_WIDTH		= "Frame width:";
	NL_STR_MAX_UNITS		= "Maximum number of displayed units:";
	NL_STR_BLACKLIST_TIMER	= "Number of seconds to keep out-of-range units blacklisted:";

	NL_CONFIG_SPELL_DESC	= "Enter heal spell names, or item names in brackets [ ].";
	NL_CONFIG_SPELL_HEAL1	= "Left button heal:";
	NL_CONFIG_SPELL_HEAL2	= "Right button heal:";
	NL_CONFIG_SPELL_HEAL3	= "Middle button heal:";
	NL_CONFIG_SPELL_HEAL4	= "Button 4 heal:";
	NL_CONFIG_SPELL_HEAL5	= "Button 5 heal:";

	NL_LOAD_DEFAULTS		= "Load Defaults";

	NL_FILTER_NAMES_DESC	= "List of names, comma separated:";	
	NL_FILTERS				= "Filters";
	NL_FILTER_PARTIES_ALL	= "All Parties";
	NL_FILTER_PARTIES_NONE	= "No Parties";
	NL_FILTER_CLASSES_ALL	= "All Classes";
	NL_FILTER_CLASSES_NONE	= "No Classes";
	
	NL_PARTY1				= "Party 1";
	NL_PARTY2				= "Party 2";
	NL_PARTY3				= "Party 3";
	NL_PARTY4				= "Party 4";
	NL_PARTY5				= "Party 5";
	NL_PARTY6				= "Party 6";
	NL_PARTY7				= "Party 7";
	NL_PARTY8				= "Party 8";
	NL_MYPARTY				= "My Party";

	NL_FILTER_TYPE_NAMES = { Everyone="Everyone", Units="Units", Multi="Multi" };
	
	BINDING_HEADER_NEEDYLIST = "Needy List";
	BINDING_NAME_NEEDYLIST_CURETOP = "Cure Top Need";
	BINDING_NAME_NEEDYLIST_CURETOP_ALTERNATE = "Cure Top Need Alternate";
	BINDING_NAME_NEEDYLIST_SORTUNITS = "Sort Units";
	BINDING_NAME_NEEDYLIST_MINIMIZE = "Minimize Needy List";
	BINDING_NAME_NEEDYLIST_CONFIGURE = "Configure Needy List";
	
	NL_STR_INTRO_PREFIX		= "Loaded Ralak's Needy List v";
	NL_STR_INTRO_SUFFIX		= ".";
	NL_STR_INTRO_DESC		= "Right-click the Needy List button or type /nlconfig for options.";
end



-- -- --- --- -- --- -- -- --
-- LANGUAGE IMPLEMENTATION --	
-- -- --- --- -- --- -- -- --
	
NL_BUFF_SPELLS = {};
NL_BUFF_SPELLS[NL_PRIEST_NAME] = {
		Fortitude = { NL_PRIEST_FORTITUDE, NL_PRIEST_FORTITUDE_PRAYER, Icons={"Spell_Holy_WordFortitude","Spell_Holy_PrayerOfFortitude"}, Ranks={1,12,24,36,48,60} },
		ShadowProt = { NL_PRIEST_SHADOWPROT, NL_PRIEST_SHADOWPROT_PRAYER, Icons={"Spell_Shadow_AntiShadow","Spell_Holy_PrayerofShadowProtection"}, Ranks={30,42,56} },
		PWShield = { NL_PRIEST_PW_SHIELD, Icons={"Spell_Holy_PowerWordShield"}, Ranks={6,12,18,24,30,36,42,48,54,60} },
		DivineSpirit = { NL_PRIEST_SPIRIT, NL_PRIEST_SPIRIT_PRAYER, Icons={"Spell_Holy_DivineSpirit","Spell_Holy_PrayerofSpirit"}, Ranks={30,40,50,60} },
		FearWard = { NL_PRIEST_FEARWARD, Icons={"Spell_Holy_Excorcism"} },
		InnerFire = { NL_PRIEST_INNERFIRE, Icons={"Spell_Holy_InnerFire"}, NoTarget=true },
		TouchOfWeakness = { NL_PRIEST_TOUCHOFWEAKNESS, Icons={"Spell_Shadow_DeadofNight"}, NoTarget=true },
		Feedback = { NL_PRIEST_FEEDBACK, Icons={"Spell_Shadow_RitualOfSacrifice"}, NoTarget=true },
		Shadowguard = { NL_PRIEST_SHADOWGUARD, Icons={"Spell_Nature_LightningShield"}, NoTarget=true },
		};
NL_BUFF_SPELLS[NL_DRUID_NAME] = {
		Mark = { NL_DRUID_MOTW, NL_DRUID_GOTW, Icons={"Spell_Nature_Regeneration","Spell_Nature_Regeneration"}, Ranks = {1,10,20,30,40,50,60}},
		Thorns = { NL_DRUID_THORNS, Icons={"Spell_Nature_Thorns"}, Ranks={6,14,24,34,44,54}},
		Clarity = { NL_DRUID_CLARITY, Icons={"Spell_Nature_CrystalBall"} },
		};
NL_BUFF_SPELLS[NL_MAGE_NAME] = {
		Intellect = { NL_MAGE_INTELLECT, NL_MAGE_INTELLECT_BIG, Icons={"Spell_Holy_MagicalSentry","Spell_Holy_ArcaneIntellect"}, Ranks={1,14,28,42,56}},
		MageArmor = { NL_MAGE_MAGEARMOR, Icons={"Spell_MageArmor"}, NoTarget=true},
		FrostArmor = { NL_MAGE_FROSTARMOR, Icons={"Spell_Frost_FrostArmor02"}, NoTarget=true},
		IceArmor = { NL_MAGE_ICEARMOR, Icons={"Spell_Frost_FrostArmor02"}, NoTarget=true},
		AmplifyMagic = { NL_MAGE_AMPLIFYMAGIC, Icons={"Spell_Holy_FlashHeal"}, Ranks={18,30,42,54}},
		DampenMagic = { NL_MAGE_DAMPENMAGIC, Icons={"Spell_Nature_AbolishMagic"}, Ranks={12,24,36,48,60}},
		ManaShield = { NL_MAGE_MANASHIELD, Icons={"Spell_Shadow_DetectLesserInvisibility"}, NoTarget=true}
		};
NL_BUFF_SPELLS[NL_PALADIN_NAME] = {
		BlessMight = { NL_PALADIN_BLESS_MIGHT, NL_PALADIN_BLESS_MIGHT_BIG, Icons={"Spell_Holy_FistOfJustice", "Spell_Holy_GreaterBlessingofKings"}, Ranks={4,12,22,32,42,52,60} },
		BlessWisdom = { NL_PALADIN_BLESS_WISDOM, NL_PALADIN_BLESS_WISDOM_BIG, Icons={"Spell_Holy_SealOfWisdom", "Spell_Holy_GreaterBlessingofWisdom"}, Ranks={14,24,34,44,54,60}},
		BlessKings = { NL_PALADIN_BLESS_KINGS, NL_PALADIN_BLESS_KINGS_BIG, Icons={"Spell_Magic_MageArmor", "Spell_Magic_GreaterBlessingofKings"}},
		BlessSalvation = { NL_PALADIN_BLESS_SALVATION, NL_PALADIN_BLESS_SALVATION_BIG, Icons={"Spell_Holy_SealOfSalvation", "Spell_Holy_GreaterBlessingofSalvation"}},
		BlessLight = { NL_PALADIN_BLESS_LIGHT, NL_PALADIN_BLESS_LIGHT_BIG, Icons={"Spell_Holy_PrayerOfHealing02", "Spell_Holy_GreaterBlessingofLight"}, Ranks={40,50,60}},
		BlessSanctuary = { NL_PALADIN_SANCTUARY, NL_PALADIN_SANCTUARY_BIG, Icons={"Spell_Nature_LightningShield","Spell_Holy_GreaterBlessingofSanctuary"}, Ranks={20,30,40,50,60}},
		};
NL_BUFF_SPELLS[NL_WARLOCK_NAME] = {
		Soulstone = { NL_WARLOCK_SOULSTONE, Icons={"Spell_Shadow_SoulGem"}},
		DemonSkin = { NL_WARLOCK_DEMONSKIN, Icons={"Spell_Shadow_RagingScream"}, NoTarget=true},
		DemonArmor = { NL_WARLOCK_DEMONARMOR, Icons={"Spell_Shadow_RagingScream"}, NoTarget=true},
		UnendingBreath = { NL_WARLOCK_UNENDINGBREATH, Icons={"Spell_Shadow_DemonBreath"}},
		DetectLesserInvis = { NL_WARLOCK_DETECT_LESS_INVISI, Icons={"Spell_Shadow_DetectLesserInvisibility"}},
		DetectInvis = { NL_WARLOCK_DETECT_INVISIBILITY, Icons={"Spell_Shadow_DetectInvisibility"}},
		DetectGreaterInvis = { NL_WARLOCK_DETECT_BIG_INVISI, Icons={"Spell_Shadow_DetectInvisibility"}},
		FireShield = { NL_WARLOCK_DETECT_FIRESHIELD, Icons={"Spell_Fire_FireArmor"}},
		};
NL_BUFF_SPELLS[NL_ROGUE_NAME] = {
		DetectTraps = { NL_ROGUE_DETECTTRAPS, Icons={"Ability_Spy"}, NoTarget=true}
		};
NL_BUFF_SPELLS[NL_SHAMAN_NAME] = {
		LightningShield = { NL_SHAMAN_LIGHTNINGSHIELD, Icons={"Spell_Nature_LightningShield"}, NoTarget=true},
		};
NL_BUFF_SPELLS[NL_WARRIOR_NAME] = {
		BattleShout = { NL_WARRIOR_BATTLESHOUT, Icons={"Ability_Warrior_BattleShout"}, NoTarget=true},
		};

NL_ENCHANT_SPELLS = {};
NL_ENCHANT_SPELLS[NL_SHAMAN_NAME] = {
		Rockbiter = { NL_SHAMAN_ROCKBITER, Icon="Spell_Nature_RockBiter", Ranks={1,8,24,34,44,54}},
		Flametongue = { NL_SHAMAN_FLAMETONGUE, Icon="Spell_Fire_FlameTounge", Ranks={10,18,26,36,46,56}},
		Frostbrand = { NL_SHAMAN_FROSTBRAND, Icon="Spell_Frost_FrostBrand", Ranks={20,28,38,48,58}},
		Windfury = { NL_SHAMAN_WINDFURY, Icon="Spell_Nature_Cyclone", Ranks={30,40,50,60}},
		};
NL_ENCHANT_SPELLS[NL_ROGUE_NAME] = {
		MainhandPoison = { NL_ROGUE_MAINHANDPOISON, Icon="Ability_Poisons"},
		OffhandPoison = { NL_ROGUE_OFFHANDPOISON, Icon="Ability_Poisons"}
		};

NL_CURE_SPELLS = {};
NL_CURE_SPELLS[NL_PRIEST_NAME] = {
		Disease = { NL_PRIEST_DISEASE, NL_PRIEST_DISEASE_ABOLISH, Icon="Spell_Holy_NullifyDisease" },
		Magic = { NL_PRIEST_MAGIC, Icon="Spell_Holy_DispelMagic", CanTargetEnemy=true },
		Resurrection = { NL_PRIEST_RESURRECT, Icon="Ability_Vanish", Ranks={10,22,34,46,58} },
		};
NL_CURE_SPELLS[NL_DRUID_NAME] = {
		Poison = { NL_DRUID_POISON, NL_DRUID_POISON_ABOLISH, Icon="Spell_Nature_NullifyPoison"},
		Curse = { NL_DRUID_CURSE, Icon="Spell_Nature_RemoveCurse"},
		Resurrection = { NL_DRUID_RESURRECTION, Icon="Ability_Vanish", Ranks={20,30,40,50,60} },
		};
NL_CURE_SPELLS[NL_MAGE_NAME] = {
		Curse = { NL_MAGE_REMOVELESSERCURSE, Icon="Spell_Nature_RemoveCurse"},
		};
NL_CURE_SPELLS[NL_PALADIN_NAME] = {
		Poison = { NL_PALADIN_POISON, NL_PALADIN_DISEASE, Icon="Spell_Nature_NullifyPoison"},
		Disease = { NL_PALADIN_POISON, NL_PALADIN_DISEASE, Icon="Spell_Nature_NullifyDisease"},
		Magic = { NL_PALADIN_DISEASE, Icon="Spell_Holy_DispelMagic"},
		Resurrection = { NL_PALADIN_RESURRECTION, Icon="Ability_Vanish", Ranks={12,24,36,48,60}},
		};
NL_CURE_SPELLS[NL_SHAMAN_NAME] = {
		Poison = { NL_SHAMAN_POISON, Icon="Spell_Nature_NullifyPoison"},
		Disease = { NL_SHAMAN_DISEASE, Icon="Spell_Nature_NullifyDisease"},
		Resurrection = { NL_SHAMAN_RESURRECTION, Icon="Ability_Vanish", Ranks={12,24,36,48,60}},
		};

NL_OTHER = {
	WellFed = { NL_WELLFED, Icon="Spell_Misc_Food"},
	Health = { NL_HEALTH, Icon="Spell_Holy_Heal"},
	Mana = { NL_MANA, Icon="Spell_Nature_Lightning"},
};


NLClassLists = {};
NLClassLists[1] = {};
NLClassLists[1][NL_FACTION_ALLIANCE] = NL_WARRIOR_NAME;
NLClassLists[1][NL_FACTION_HORDE] = NL_WARRIOR_NAME;
NLClassLists[2] = {};
NLClassLists[2][NL_FACTION_ALLIANCE] = NL_PRIEST_NAME;
NLClassLists[2][NL_FACTION_HORDE] = NL_PRIEST_NAME;
NLClassLists[3] = {};
NLClassLists[3][NL_FACTION_ALLIANCE] = NL_ROGUE_NAME;
NLClassLists[3][NL_FACTION_HORDE] = NL_ROGUE_NAME;
NLClassLists[4] = {};
NLClassLists[4][NL_FACTION_ALLIANCE] = NL_MAGE_NAME;
NLClassLists[4][NL_FACTION_HORDE] = NL_MAGE_NAME;
NLClassLists[5] = {};
NLClassLists[5][NL_FACTION_ALLIANCE] = NL_HUNTER_NAME;
NLClassLists[5][NL_FACTION_HORDE] = NL_HUNTER_NAME;
NLClassLists[6] = {};
NLClassLists[6][NL_FACTION_ALLIANCE] = NL_DRUID_NAME;
NLClassLists[6][NL_FACTION_HORDE] = NL_DRUID_NAME;
NLClassLists[7] = {};
NLClassLists[7][NL_FACTION_ALLIANCE] = NL_WARLOCK_NAME;
NLClassLists[7][NL_FACTION_HORDE] = NL_WARLOCK_NAME;
NLClassLists[8] = {};
NLClassLists[8][NL_FACTION_ALLIANCE] = NL_PALADIN_NAME;
NLClassLists[8][NL_FACTION_HORDE] = NL_SHAMAN_NAME;
NLClassLists[9] = {};
NLClassLists[9][NL_FACTION_ALLIANCE] = NL_BEAST_NAME;
NLClassLists[9][NL_FACTION_HORDE] = NL_BEAST_NAME;
NLClassLists[10] = {};
NLClassLists[10][NL_FACTION_ALLIANCE] = NL_DEMON_NAME;
NLClassLists[10][NL_FACTION_HORDE] = NL_DEMON_NAME;



