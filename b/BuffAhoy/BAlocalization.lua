--BuffAhoy localization file

BA_GREATER_BLESSING_TEXT	= "Greater Blessing"

--Faction Names
BUFFAHOY_HORDE			= "Horde";
BUFFAHOY_ALLIANCE	       	= "Alliance";

--Class Names
BUFFAHOY_DRUID			= "Druid";
BUFFAHOY_HUNTER			= "Hunter";
BUFFAHOY_MAGE		       	= "Mage";
BUFFAHOY_PRIEST			= "Priest";
BUFFAHOY_ROGUE			= "Rogue";
BUFFAHOY_WARLOCK	       	= "Warlock";
BUFFAHOY_WARRIOR	       	= "Warrior";
BUFFAHOY_SHAMAN			= "Shaman";
BUFFAHOY_PALADIN	       	= "Paladin";

--GUI text
BUFFAHOY_HELP 			= "Drag Buff spells from your spellbook \ninto the boxes. Then press the appropriate \nkeybind.  Bind keys to each \nfunction in the Key Bindings Pane.";
BUFFAHOY_VERBOSE_TIP 		= "Check for Verbose casting"
BUFFAHOY_OPTIONS_TIP 		= "Check to toggle the appropriate option"
BUFFAHOYBC34_HELP 		= "Buff Sequences 2 and 3 will cast the same spell on all 5 party members."
BUFFAHOYRC23_HELP 		= "Class Sequences 2 and 3 will cast the same spell on all raid/party members."

--Slash command text
BUFFAHOY_VERBOSESLASH1		= "BuffAhoy Components set to Verbose Mode ('/ba toggle' will toggle all)"
BUFFAHOY_VERBOSESLASH2		= "Type '/ba help' for instructions."
BUFFAHOY_VERBOSESLASH3		= "BuffAhoy Components set to Silent Mode ('/ba toggle' will toggle)"
BUFFAHOY_SLASHHELP1		= "BuffAhoy Help:"
BUFFAHOY_SLASHHELP2		= "To bring up the Config Panel, type '/ba config'"
BUFFAHOY_SLASHHELP3		= "Drag spells into the appropriate slots, and bind keys to the functions you want to use in the Key Bindings interface (accessible by pressing Escape to bring up the game menu)"
BUFFAHOY_ANNOUNCE_ON		= "BuffAhoy buff announcements on, type /ba announce to toggle"
BUFFAHOY_ANNOUNCE_OFF		= "BuffAhoy buff announcements off, type /ba announce to toggle"

--OnLoad text
BUFFAHOY_ONLOAD_TEXT		="Theck's BuffAhoy loaded"

--Error message texts
BUFFAHOY_SPELL_INTERRUPTED	="Spell Interrupted!!"
BUFFAHOY_SPELL_FAILED		="Spell Failed!!"
BUFFAHOY_SPELL_DELAYED		="Getting hit, spell delayed!!"


BUFFAHOY_PB_TEXT                = "Buffing Interface"
BUFFAHOY_PB_TOOLTIP             = "Configure party buffing sequences"

BUFFAHOY_UF_TEXT                = "Utility Functions"
BUFFAHOY_UF_TOOLTIP             = "Configure the utility functions (Healing, Cleansing, etc)"

BUFFAHOY_MC_TEXT                = "Multi/Shoutcast"
BUFFAHOY_MC_TOOLTIP             = "Configure Multicast sequences and Shoutcast slots"

BUFFAHOY_GO_TEXT                = "BuffAhoy Options"
BUFFAHOY_GO_TOOLTIP             = "Configure global options"

BUFFAHOY_CLASSBASE_TEXT         = "Class-based"
BUFFAHOY_CLASSBASE_TOOLTIP      = "Party/Raid members will be buffed based on their class"

BUFFAHOY_INDIV_TEXT             = "Individualized"
BUFFAHOY_INDIV_TOOLTIP          = "Party members can be buffed on an individual basis.  Does not work in Raids."

BUFFAHOY_GROUP_TEXT		= "Group-based"
BUFFAHOY_GROUP_TOOLTIP		= "Choose which groups to include or exclude from Class-based buffing routine."
BUFFAHOY_GROUP_HELP		= "Check the boxes for the groups you wish to be included in the Class-Based buffing routines.  These class selections will apply for all 3 Class-Based buff sequences."

BUFFAHOY_VERBOSE_RAID_TEXT      = "Raid"
BUFFAHOY_VERBOSE_RAID_TT        = "Verbose functions will send messages to the raid group"

BUFFAHOY_VERBOSE_PARTY_TEXT     = "Party"
BUFFAHOY_VERBOSE_PARTY_TT       = "Verbose functions will send messages to the party"

BUFFAHOY_VERBOSE_SAY_TEXT       = "Say"
BUFFAHOY_VERBOSE_SAY_TT        = "Verbose functions will send messages aloud"


BUFFAHOY_ALTSELF_TOOLTIP        = "Holding Alt will cause the PPT system to target you instead of the Passive Party Target"
BUFFAHOY_SHIFTSELF_TOOLTIP      = "Holding shift will cause the PPT system to target you instead of the Passive Party Target"
   
BUFFAHOY_ERR_NOPET1             = "You have no targettable pet."
BUFFAHOY_ERR_NOPET2             = " has no targettable pet."
BUFFAHOY_ERR_NOPARTYMBR         = "No party member"
BUFFAHOY_ERR_NORAIDMBR          = "No Raid Member " 

BUFFAHOY_ERR_WAIT               = "Patience, young padawan"
BUFFAHOY_ERR_MANA               = "Not enough Mana"
BUFFAHOY_ERR_RANGE              = "Out of Range"

BUFFAHOY_MSG_FINISH             = "Buff Sequence Finished"

BUFFAHOY_ERR_MANA_HEAL          = "Not enough mana to heal"
BUFFAHOY_ERR_MANA_PROT          = "Not enough mana to Protect"
BUFFAHOY_ERR_PROT               = "Cannot Protect a non-party or non-raid member"

--Text in casting functions
BUFFAHOY_PPT_NOT_VALID		="The current Passive Party Target is invalid"
BUFFAHOY_GATHER_START		="BuffAhoy sequence started, gather round "
BUFFAHOY_GATHER_END		=" for buffs."
BUFFAHOY_BUFFING_ONE		="Buffing " 
BUFFAHOY_BUFFING_TWO		=" with "

BUFFAHOY_NO_MANA_TO_HEAL	="Not enough mana to heal"
BUFFAHOY_NO_MANA_TO_CLEANSE	="Not enough mana to cleanse"
BUFFAHOY_NO_MANA_TO_PROT	="Not enough mana to protect"
BUFFAHOY_PROT_ERROR		="Cannot Protect a non-party or non-raid member"

BUFFAHOY_HEALZOR_TEXT		="Healing"
BUFFAHOY_CLEANZOR_TEXT		="Cleansing"
BUFFAHOY_SHOUTCAST_TEXT		="Casting "
BUFFAHOY_SHOUTCAST_TEXT2	=" on"

BUFFAHOY_PANIC_TEXT		="Casting Divine Intervention on "
BUFFAHOY_PANIC_FAILED		="Panic button failed to find a valid target!!"

if ( GetLocale() == "frFR" ) then
	-- Traductions par Duanra and vjeux


	BUFFAHOY_HORDE			= "Horde";
	BUFFAHOY_ALLIANCE	        = "Alliance";

	BUFFAHOY_DRUID			= "Druide";
	BUFFAHOY_HUNTER			= "Chasseur";
	BUFFAHOY_MAGE			= "Mage";
	BUFFAHOY_PRIEST			= "Pr\195\170tre";
	BUFFAHOY_ROGUE			= "Voleur";
	BUFFAHOY_WARLOCK		= "D\195\169moniste";
	BUFFAHOY_WARRIOR		= "Guerrier";
	BUFFAHOY_SHAMAN			= "Chaman";
	BUFFAHOY_PALADIN		= "Paladin";

	--GUI text
	BUFFAHOY_HELP = "S\195\169lectionnez une b\195\169n\195\169diction et placez-la \ndans les cases. Puis appuy\195\169 sur le\nraccourci. Assignez une touche a chaque \nfonction dans le panneau des raccourcis.";
	BUFFAHOY_VERBOSE_TIP = "S\195\169lectionnez pour annoncer les b\195\169n\195\169dictions"
	BUFFAHOY_OPTIONS_TIP = "S\195\169lectionnez pour changer l'option"
	BUFFAHOYBC34_HELP = "Les s\195\169quences 2 et 3 lancerons les m\195\170mes sur tout les 5 membres du groupe."
	BUFFAHOYRC23_HELP = "Les s\195\169quences 2 et 3 lancerons les m\195\170mes sur tout les membres du raid/groupe."

	--Slash command text
	BUFFAHOY_VERBOSESLASH1 = "BuffAhoy est en mode Annonce ('/ba toggle' permet de changer cet option)"
	BUFFAHOY_VERBOSESLASH2 = "Tapez '/ba help' pour lire les instructions."
	BUFFAHOY_VERBOSESLASH3 = "BuffAhoy est en mode Silence ('/ba toggle' permet de changer cet option)"
	BUFFAHOY_SLASHHELP1 = "BuffAhoy Aide:"
	BUFFAHOY_SLASHHELP2 = "Pour afficher le panneau de configuration, tapez '/ba config'"
	BUFFAHOY_SLASHHELP3 = "S\195\169lectionnez les sorts et placez-les, puis assignez les touches aux fonctions que vous voulez utilisez grâce aux raccourcis dans le menu de configuration puis Raccourcis de World of Warcraft"
	BUFFAHOY_ANNOUNCE_ON = "BuffAhoy Annonce des b\195\169n\195\169dictions activ\195\169, taper /ba announce pour changer"
	BUFFAHOY_ANNOUNCE_OFF = "BuffAhoy Annonce des b\195\169n\195\169dictions d\195\169sactiv\195\169, taper /ba announce pour changer"

	--Error message texts
	BUFFAHOY_PB_TEXT = "Interface de b\195\169n\195\169dictions"
	BUFFAHOY_PB_TOOLTIP = "Configurez les s\195\169quences de b\195\169n\195\169dictions de groupe"

	BUFFAHOY_UF_TEXT = "Fonctions utiles"
	BUFFAHOY_UF_TOOLTIP = "Configurez les fonctions utiles (Soins,Maladie,Magie, etc)"
	
	BUFFAHOY_MC_TEXT = "Multiple/Annonces"
	BUFFAHOY_MC_TOOLTIP = "Configurez les s\195\169quences de lancement et les annonces"

	BUFFAHOY_GO_TEXT = "BuffAhoy Options"
	BUFFAHOY_GO_TOOLTIP = "Configurez les options globales"

	BUFFAHOY_CLASSBASE_TEXT = "Bas\195\169 sur les classes"
	BUFFAHOY_CLASSBASE_TOOLTIP = "Les membre du Groupe/Raid seront b\195\169nits selon leur classe"

	BUFFAHOY_INDIV_TEXT = "Individuel"
	BUFFAHOY_INDIV_TOOLTIP = "Les membres du groupe seront b\195\169nit individuellement. Ne fonctionne pas en raid."

	BUFFAHOY_GROUP_TEXT = "Selon les groupes"
	BUFFAHOY_GROUP_TOOLTIP = "Choisissez quels groupes a inclure ou exclure selon les groupes de la s\195\169quence de b\195\169n\195\169dictions."
	BUFFAHOY_GROUP_HELP = "S\195\169lectionnez pour inclure les groupes dans la s\195\169quence de b\195\169n\195\169dictions. La s\195\169lection des classe sera appliqu\195\169e pour les 3 s\195\169quences de b\195\169n\195\169dictions selon les groupes"

	BUFFAHOY_VERBOSE_RAID_TEXT = "Raid"
	BUFFAHOY_VERBOSE_RAID_TT = "La fonction annonce enverra un message au groupe de RAID"

	BUFFAHOY_VERBOSE_PARTY_TEXT = "Groupe"
	BUFFAHOY_VERBOSE_PARTY_TT = "La fonction annonce enverra un message au groupe"

	BUFFAHOY_VERBOSE_SAY_TEXT = "Dire"
	BUFFAHOY_VERBOSE_SAY_TT = "La fonction annonce enverra un message public"


	BUFFAHOY_ALTSELF_TOOLTIP = "Tenir appuy\195\169 la touche Alt aura pour effet d'activer le systeme PPT a la cible si vous avez choisi une cible du groupe inactive"
	BUFFAHOY_SHIFTSELF_TOOLTIP = "Tenir appuy\195\169 Maj aura pour effet d'activer le systeme PPT a la cible si vous avez choisi une cible du groupe inactive"

	BUFFAHOY_ERR_NOPET1 = "Vous n'avez pas d'animal de compagnie s\195\169lectionnable."
	BUFFAHOY_ERR_NOPET2 = " n'a pas d'animal de compagnie s\195\169lectionnable."
	BUFFAHOY_ERR_NOPARTYMBR = "Aucun membre de groupe"
	BUFFAHOY_ERR_NORAIDMBR = "Aucun membre de RAID"
	
	BUFFAHOY_ERR_WAIT = "Patience, une autre action est en cours"
	BUFFAHOY_ERR_MANA = "Vous n'avez plus de mana"
	BUFFAHOY_ERR_RANGE = "En dehors de la zone"

	BUFFAHOY_MSG_FINISH = "S\195\169quence de b\195\169n\195\169dictions termin\195\169e !"

	BUFFAHOY_ERR_MANA_HEAL = "Vous n'avez plus de mana pour soigner"
	BUFFAHOY_ERR_MANA_PROT = "Vous n'avez plus de mana pour prot\195\169ger"
	BUFFAHOY_ERR_PROT = "Vous ne pouvez pas prot\195\169ger un membre qui ne fait pas partie du groupe/RAID"
	BUFFAHOY_MSG_BANDAGE = "Bandage"

	
elseif ( GetLocale() == "deDE" ) then

	BA_GREATER_BLESSING_TEXT	="Gro\195\159er Segen"
	-- Translation by DoctorVanGogh
	BUFFAHOY_HORDE			= "Horde";
	BUFFAHOY_ALLIANCE		= "Allianz";

	BUFFAHOY_DRUID			= "Druide";
	BUFFAHOY_HUNTER			= "J\195\164ger";
	BUFFAHOY_MAGE		       	= "Magier";
	BUFFAHOY_PRIEST			= "Priester";
	BUFFAHOY_ROGUE			= "Schurke";
	BUFFAHOY_WARLOCK		= "Hexenmeister";
	BUFFAHOY_WARRIOR		= "Krieger";
	BUFFAHOY_SHAMAN			= "Schamane";
	BUFFAHOY_PALADIN	        = "Paladin";

	-- Translation by ne0
	BUFFAHOY_HELP = "Ziehe Buffspells aus deinem Zauberbuch \nin die Boxen. Dann dr\195\188cke die dazugeh\195\182rige \nTaste.  Binde Tasten zu jeder \nFunktion in der Tastenkombinationseinstellung.";
	BUFFAHOY_VERBOSE_TIP = "Anhaken f\195\188r Ausgesprochene Buffs"
	BUFFAHOY_OPTIONS_TIP = "Anhaken um die jeweilige Option umzuschalten"
	BUFFAHOYBC34_HELP= "Buff Sequenz 2 und 3 werden den selben Spell auf alle 5 Gruppenmitglieder zaubern"
	BUFFAHOYRC23_HELP= "Klassen Sequenz 2 und 3 werden den selben Spell auf alle Raid/Gruppenmitglieder zaubern"
 
	--Slash command text
	BUFFAHOY_VERBOSESLASH1="BuffAhoy Komponenten sind im Ausgabemodus ('/ba toggle' wird alle \195\164ndern)"
	BUFFAHOY_VERBOSESLASH2="Schreibe '/ba help' f\195\188r Instruktionen."
--	BUFFAHOY_VERBOSESLASH3="BuffAhoy Komponenten sind im Ausgabemodus ('/ba toggle' \195\164ndert dies)"
	BUFFAHOY_SLASHHELP1="BuffAhoy Hilfe:"
	BUFFAHOY_SLASHHELP2="F\195\188r das Konfigurationsfenster schreibe '/ba config'"
	BUFFAHOY_SLASHHELP3="Ziehe Zauberspr\195\188che in die dazugeh\195\182rigen Felder, und Belege Tasten f\195\188r die jeweilige Funktion im Tastenbelegungsmenu (Zugriff \195\188ber ESC um das Spielmenu zu zeigen)"
 
	--Error message texts
	BUFFAHOY_PETTARGETMINE="Du hast kein Ausw\195\164hlbares Tier."


        BUFFAHOY_PB_TEXT                = "Buff-Interface"
        BUFFAHOY_PB_TOOLTIP             = "Konfiguration Gruppenbuff-Sequenzen"

        BUFFAHOY_UF_TEXT                = "Utility Funktionen"
        BUFFAHOY_UF_TOOLTIP             = "Konfiguration der Utility Funktionen (Heilen, Reinigung, etc)"

        BUFFAHOY_MC_TEXT                = "Multi/Shoutcast"
        BUFFAHOY_MC_TOOLTIP             = "Konfiguration Multicast-Sequenzen und Shoutcast-Slots"

        BUFFAHOY_GO_TEXT                = "BuffAhoy Optionen"
        BUFFAHOY_GO_TOOLTIP             = "Konfiguration globale Optionen"

        BUFFAHOY_CLASSBASE_TEXT         = "Klassenbasiert"
        BUFFAHOY_CLASSBASE_TOOLTIP      = "Gruppen/Raid-Mitglieder werden klassenbasiert gebufft."

        BUFFAHOY_INDIV_TEXT             = "Individuell"
        BUFFAHOY_INDIV_TOOLTIP          = "Gruppenmitglieder werden individuell gebufft.  Funktioniert nicht in Raidgruppen."
 
        BUFFAHOY_VERBOSE_RAID_TEXT      = "Raid"
        BUFFAHOY_VERBOSE_RAID_TT        = "Ansage-Funktion sendet die Nachrichten an die Raidgruppe"

        BUFFAHOY_VERBOSE_PARTY_TEXT     = "Gruppe"
        BUFFAHOY_VERBOSE_PARTY_TT       = "Ansage-Funktion sendet die Nachrichten an die Gruppe"

        BUFFAHOY_VERBOSE_SAY_TEXT       = "Say"
        BUFFAHOY_VERBOSE_SAY_TT        = "Ansage-Funktion sendet die Nachrichten +laut+' (say)"

        BUFFAHOY_ALTSELF_TOOLTIP        = "Durch halten der Alt-Taste selektiert das PPT System Dich, anstatt das 'Passive Party Target'"
        BUFFAHOY_SHIFTSELF_TOOLTIP      = "Durch halten der Shift-Taste selektiert das PPT System Dich, anstatt das 'Passive Party Target'"

        BUFFAHOY_ERR_NOPET1              = "Kein anw\195\164hlbares Pet vorhanden."
        BUFFAHOY_ERR_NOPET2             = " hat kein anw\195\164hlbares Pet."
        BUFFAHOY_ERR_NOPARTYMBR         = "Kein Gruppenmitglied"
        BUFFAHOY_ERR_NORAIDMBR          = "Kein Raid-Mitglied " 

        BUFFAHOY_ERR_WAIT               = "Bitte etwas mehr Geduld"
        BUFFAHOY_ERR_MANA               = "Nicht genug Mana"
        BUFFAHOY_ERR_RANGE              = "Au\195\159er Reichweite"

        BUFFAHOY_MSG_FINISH             = "Buffsequenz beendet"

        BUFFAHOY_ERR_MANA_HEAL          = "Nicht genug Mana zum heilen"
        BUFFAHOY_ERR_MANA_PROT          = "Nicht genug Mana zum protecten"
        BUFFAHOY_ERR_PROT               = "Protect geht nur f\195\188r Gruppen- und Raid-Mitglieder"

        BUFFAHOY_MSG_BANDAGE            = "Bandagiere"


end
