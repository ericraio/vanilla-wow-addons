-- *
-- * ENGLISH (DEFAULT)
-- *

-- The next 6 lines define the names of the pets abilities. The localization of these settings
-- into the clients language are a "must" to use the basic functions of SmartPet.

SMARTPET_ACTIONS_GROWL		= "Growl";
SMARTPET_ACTIONS_COWER		= "Cower";
SMARTPET_ACTIONS_CLAW		= "Claw";
SMARTPET_ACTIONS_BITE		= "Bite";
SMARTPET_ACTIONS_DASH		= "Dash";
SMARTPET_ACTIONS_DIVE		= "Dive";
SMARTPET_SCATTERSHOT		="Scatter Shot";

-- Name for the follow icon, possibly does not need to be translated as it is a global id
SMARTPET_ACTION_NOCHASE		= "PET_ACTION_FOLLOW";

-- The next line defines the text that is used by SmartPet to determine if the opponent flees.
-- The localization of this text into the clients language is a "must" for using the anti-chasing
-- functions of SmartPet.

SMARTPET_SEARCH_RUNAWAY = "attempts to run away in fear";

-- The lines below are normal text and not necessary for SmartPets functionality. You can
-- translate them to be displayed in your clients language.

-- KeyBinding Lables
SMARTPET_BINDING_NAME_TOGGLETAUNT = "Toggle Management Between Growl/Cower";
SMARTPET_BINDING_NAME_CHASETOGGLE = "Toggle No Chase Option On/Off";

-- Slash Commands
SMARTPET_HELP			= "help";
SMARTPET_ENABLE			= "enable";
SMARTPET_DISABLE		= "disable";
SMARTPET_TAUNTMAN		= "tauntman";
SMARTPET_SMARTFOCUS		= "smartfocus";
SMARTPET_ON			= "on";
SMARTPET_OFF			= "off";
SMARTPET_AUTOWARN 		= "autowarn";
SMARTPET_WARNHEALTH		= "warnhealth";
SMARTPET_AUTOCOWER		= "autocower";
SMARTPET_COWERHEALTH		= "cowerhealth";
SMARTPET_CHANNEL		= "channel";
SMARTPET_NOCHASE		= "nochase";
SMARTPET_SHOWDEBUG		= "showdebug";
SMARTPET_TOOLTIPS		= "tooltips";


-- Loading strings
SMARTPET_VERSION_RUNNING = "Version %v loaded: Type /smartpet or /sp for more information.";		-- %v = Version number
SMARTPET_VERSION_CHANGED = "Version changed, resetting all variables to default.";
SMARTPET_ONLY_FOR_HUNTER = "This AddOn is for Hunter pets only.";
SMARTPET_WARLOCK_MEMO	= "Limited Intigration for Warlocks."

-- Pet messages
SMARTPET_PET_NEEDS_HEALING = "%n needs healing! (%h% Health)";		-- %n = Pet name | %h = Pet health
SMARTPET_PET_BREAKS_COMBAT = "%n breaking off from combat!";			-- %n = Pet name

-- Tooltips
SMARTPET_TOOLTIP_MANAGEMENT	= "Management";
SMARTPET_TOOLTIP_AUTOCOWER	= "Because AutoCower is enabled SmartPet\nwill enable Cower if your pets health\ndrops below %h%. If Growl is enabled when\nthis happens SmartPet will automatically\ndisable it.";
SMARTPET_TOOLTIP_SMARTFOCUS1	= "Because SmartFocus is enabled SmartPet\nwill attempt to optimize your pets DPS\nby enabling Claw and disabling Bite for\nthe first 12 seconds of combat. After\nthat time your pet will switch to Bite.";
SMARTPET_TOOLTIP_SMARTFOCUS2	= "You must enable both Claw and Bite for\nSmartFocus to work."
SMARTPET_TOOLTIP_GROWL1		= "SmartPet will ensure that your pet has\nenough focus to cast Growl every 5 seconds.";
SMARTPET_TOOLTIP_GROWL2		= "You must have Cower on your Pet Action\nBar for AutoCower to work.";
SMARTPET_TOOLTIP_GROWL3		= "SmartPet will disable Growl during combat.";
SMARTPET_TOOLTIP_GROWL4		= "SmartPet will not change the Autocast\nstate of Growl during combat.";
SMARTPET_TOOLTIP_COWER1		= "SmartPet will ensure that your pet has\nenough focus to cast Cower every 5 seconds."
SMARTPET_TOOLTIP_COWER3		= "SmartPet will disable Cower during combat.";
SMARTPET_TOOLTIP_COWER4		= "SmartPet will not change the Autocast\nstate of Cower during combat.";
SMARTPET_TOOLTIP_CLAW1		= "SmartPet will disable Claw during combat\nif using it would not leave your pet with\nenough focus to cast %a. It will be\nre-enabled if your pet gains enough focus\nto use both %a and Claw."
SMARTPET_TOOLTIP_CLAW2		= "SmartPet will disable Claw during combat.";
SMARTPET_TOOLTIP_BITE1		= "SmartPet will disable Bite during combat\nif using it would not leave your pet with\nenough focus to cast %a. It will be\nre-enabled if your pet gains enough focus\nto use both %a and Bite."
SMARTPET_TOOLTIP_BITE2		= "SmartPet will disable Bite during combat.";
SMARTPET_TOOLTIP_NOCHASE1	= "Your pet will stop attacking if your target flees";
SMARTPET_TOOLTIP_NOCHASE2	= "Your pet will chase fleeing targets";




-- Toggle commands
SMARTPET_COMMANDS_SMARTPET_ENABLED	= "SmartPet enabled";
SMARTPET_COMMANDS_SMARTPET_DISABLED	= "SmartPet disabled";
SMARTPET_COMMANDS_TAUNTMAN		= "Use the check buttons above Growl and Cower on your pet action bar to enable Taunt Management";
SMARTPET_COMMANDS_SMARTFOCUS_ENABLED	= "Smart Focus management enabled";
SMARTPET_COMMANDS_SMARTFOCUS_DISABLED	= "Smart Focus management disabled";
SMARTPET_COMMANDS_AUTOWARN_ENABLED	= "Low health warning enabled";
SMARTPET_COMMANDS_AUTOWARN_DISABLED	= "Low health warning disabled";
SMARTPET_COMMANDS_WARNHEALTH		= "Low health warning set to %h%";		-- %h = health percent
SMARTPET_COMMANDS_CHANNEL		= "Channel set to %c";								-- %c = Channel name
SMARTPET_COMMANDS_AUTOCOWER_ENABLED	= "Cower when low health enabled";
SMARTPET_COMMANDS_AUTOCOWER_DISABLED	= "Cower when low health disabled";
SMARTPET_COMMANDS_COWERHEALTH		= "Auto-cower health set to %h%";			-- %h = health percent
SMARTPET_COMMANDS_NOCHASE_ENABLED	= "Your pet will stop attacking if your target flees";
SMARTPET_COMMANDS_NOCHASE_DISABLED	= "Your pet will chase fleeing targets";
SMARTPET_COMMANDS_SHOWDEBUG_ENABLED	= "Debug text display enabled";
SMARTPET_COMMANDS_SHOWDEBUG_DISABLED	= "Debug text display disabled";
SMARTPET_COMMANDS_TOOLTIPS_ENABLED	= "Tooltips enabled";
SMARTPET_COMMANDS_TOOLTIPS_DISABLED	= "Tooltips disabled";

-- Usage messages
SMARTPET_USAGE_ENABLED			= "enabled";
SMARTPET_USAGE_DISABLED			= "disabled";
SMARTPET_USAGE_PERCENT			= "<percent>"
SMARTPET_USAGE_SMARTPET			= "enables or disables all SmartPet functionality.";
SMARTPET_USAGE_TAUNTMAN			= "toggles taunt management.";
SMARTPET_USAGE_SMARTFOCUS		= "toggles smart focus management.";
SMARTPET_USAGE_AUTOWARN			= "toggles warning when pet health is low.";
SMARTPET_USAGE_WARNHEALTH		= "pet will report health when below this level.";
SMARTPET_USAGE_CHANNEL			= "pet health informs will go to this channel.";
SMARTPET_USAGE_AUTOCOWER		= "toggles auto cowering when health is low.";
SMARTPET_USAGE_COWERHEALTH		= "pet will begin cowering when health below this level.";
SMARTPET_USAGE_NOCHASE			= "pet will stop combat if your target flees.";
SMARTPET_USAGE_TOOLTIPS			= "toggles tooltip display.";
SMARTPET_USEAGE_HELP			= "displays more detailed help information";

-- Help messages
SMARTPET_HELP_TITLE			= "SmartPet command help:";
SMARTPET_HELP_TAUNTMAN1			= "Taunt Management ";
SMARTPET_HELP_TAUNTMAN2			= "Enabling this will ensure that your pet always has enough focus to Cower or Growl.  Each time you enter combat, your pet will make use of the abilities that were set to Autocast when combat started, while maintaining enough focus to growl or cower every 5 seconds.";
SMARTPET_HELP_SMARTFOCUS1		= "Smart Focus Management ";
SMARTPET_HELP_SMARTFOCUS2		=  "Enabling this will attempt to maximize your pets DPS output by automatically enabling and disabling burst and sustained damage abilities at the appropriate time.";
SMARTPET_HELP_AUTOHEALTH1		="Auto Health Warning ";
SMARTPET_HELP_AUTOHEALTH2		= "Enabling this will send a message to your party if your pets health drops below the specified amount.";
SMARTPET_HELP_AUTOCOWER1		= "Auto Cower "; 
SMARTPET_HELP_AUTOCOWER2		="Enabling this will cause your pet to cower when its health drops below the specified amount.";

if ( GetLocale() == "deDE" ) then

	-- *
	-- * DEUTSCH
	-- *

	-- Die nächsten 6 Zeilen legen die Namen der Tier-Aktionen fest. Diese *müssen* an die
	-- Sprache des Clients angepasst werden damit die grundlegenden Funktionen von SmartPet
	-- benutzt werden können!

	SMARTPET_ACTIONS_GROWL	= "Knurren";
	SMARTPET_ACTIONS_COWER	= "Ducken";
	SMARTPET_ACTIONS_CLAW		= "Klaue";
	SMARTPET_ACTIONS_BITE		= "Bei\195\159en";
	SMARTPET_ACTIONS_DASH		= "Spurt";
	SMARTPET_ACTIONS_DIVE		= "Tauchen";

	-- Die nächste Zeile legt den Text fest nach dem SmartPet sucht um zu ermitteln ob ein Gegner
	-- die Flucht ergreift. Dieser Text *muss* an die Sprache des Clients angepasst werden damit
	-- das automatische ablassen vom Gegner funktioniert!
	
	SMARTPET_SEARCH_RUNAWAY = "versucht, voller Furcht fortzulaufen!";

	-- Die nächsten Zeilen sind normaler Text und für die Funktionalität von SmartPet nicht un-
	-- bedingt wichtig. Die Übersetzung dient nur der Darstellung in der eigenen Sprache.

	-- Lade Texte
	SMARTPET_VERSION_RUNNING = "Version %v geladen: Tippe /smartpet oder /sp f\195\188r mehr Informationen.";
	SMARTPET_VERSION_CHANGED = "Die Versionsnummer hat sich ge\195\164ndert und alle Einstellungen wurden zur\195\188ckgesetzt";
	SMARTPET_ONLY_FOR_HUNTER = "Diese Erweiterung ist nur f\195\188r die Tiere der J\195\164ger gedacht!";

	-- Tier Texte
	SMARTPET_PET_NEEDS_HEALING = "%n ben\195\182tigt Heilung! (%h% Leben)";
	SMARTPET_PET_BREAKS_COMBAT = "%n l\195\164\195\159t von seinem Ziel ab!";

	-- Tooltipp Texte
	SMARTPET_TOOLTIP_MANAGEMENT			= "Management";
	SMARTPET_TOOLTIP_AUTOCOWER			= "Da AutoCower eingeschaltet ist, wird SmartPet\nDucken einschalten sobald das Leben deines\nTiers unter %h% f\195\164llt. Wenn Knurren eingeschaltet\nist wird es automatisch ausgeschaltet.";
	SMARTPET_TOOLTIP_SMARTFOCUS1			= "Da SmartFocus eingeschalten ist, wird\nSmartPet versuche den Schaden deines Tiers\nzu optimieren, indem es im Kampf die\nersten 12 Sekunden nur Klaue benutzt und\nBei\195\159en ausschaltet. Danach wechselt das\nTier zu Bei\195\159en.";
	SMARTPET_TOOLTIP_SMARTFOCUS2			= "Du mu\195\159t Klaue und Bei\195\159en einschalten damit\nSmartFocus korrekt arbeitet."
	SMARTPET_TOOLTIP_GROWL1				= "SmartPet stellt sicher das dein Tier immer\ngenug Fokus hat um alle 5 Sekunden Knurren\nanwenden zu k\195\182nnen.";
	SMARTPET_TOOLTIP_GROWL2				= "Dein Tier mu\195\159 Ducken gelernt haben damit\nAutoCower benutzt werden kann.";
	SMARTPET_TOOLTIP_GROWL3				= "SmartPet schaltet Knurren w\195\164hrend des\nKampfes aus.";
	SMARTPET_TOOLTIP_GROWL4				= "SmartPet wird die Einstellung von Knurren\nw\195\164hrend des Kampfes nicht ver\195\164ndern.";
	SMARTPET_TOOLTIP_COWER1				= "SmartPet stellt sicher das dein Tier immer\ngenug Fokus hat um alle 5 Sekunden Ducken\nanwenden zu k\195\182nnen."
	SMARTPET_TOOLTIP_COWER3				= "SmartPet schaltet Ducken w\195\164hrend des\nKampfes aus.";
	SMARTPET_TOOLTIP_COWER4				= "SmartPet wird die Einstellung von Ducken\nw\195\164hrend des Kampfes nicht ver\195\164ndern.";
	SMARTPET_TOOLTIP_CLAW1				= "SmartPet schaltet Klaue im Kampf aus wenn\ndie Benutzung nicht genug Fokus f\195\188r %a\n\195\188brig lassen w\195\188rde. Es wird automatisch\nwieder eingeschaltet wenn genug Fokus f\195\188r\nKlaue und %a vorhanden ist."
	SMARTPET_TOOLTIP_CLAW2				= "SmartPet schaltet Klaue im Kampf aus.";
	SMARTPET_TOOLTIP_BITE1				= "SmartPet schaltet Bei\195\159en im Kampf aus wenn\ndie Benutzung nicht genug Fokus f\195\188r %a\n\195\188brig lassen w\195\188rde. Es wird automatisch\nwieder eingeschaltet wenn genug Fokus f\195\188r\nBei\195\159en und %a vorhanden ist."
	SMARTPET_TOOLTIP_BITE2				= "SmartPet schaltet Bei\195\159en im Kampf aus.";
	SMARTPET_TOOLTIP_NOCHASE1			= "Dein Tier verfolgt sein Ziel wenn es flieht.";
	SMARTPET_TOOLTIP_NOCHASE2			= "Dein Tier verfolgt sein Ziel nicht wenn es flieht.";

	-- Ein/Aus Texte
	SMARTPET_COMMANDS_SMARTPET_ENABLED		= "SmartPet ist jetzt aktiv.";
	SMARTPET_COMMANDS_SMARTPET_DISABLED		= "SmartPet ist jetzt nicht mehr aktiv.";
	SMARTPET_COMMANDS_TAUNTMAN			= "Benutze die H\195\164ckchen \195\188ber der Tier-Aktionsleiste von Knurren und Ducken um das Bedrohungs Management zu aktivieren.";
	SMARTPET_COMMANDS_SMARTFOCUS_ENABLED		= "Fokus Management ist jetzt aktiv.";
	SMARTPET_COMMANDS_SMARTFOCUS_DISABLED		= "Fokus Management ist jetzt nicht mehr aktiv.";
	SMARTPET_COMMANDS_AUTOWARN_ENABLED		= "Lebenswarnung ist aktiv.";
	SMARTPET_COMMANDS_AUTOWARN_DISABLED		= "Lebenswarnung ist nicht mehr aktiv.";
	SMARTPET_COMMANDS_WARNHEALTH			= "Lebenswarnung des Tiers wird bei weniger als %h% Leben ausgeben.";
	SMARTPET_COMMANDS_CHANNEL			= 'Lebenswarnung wird in Kanal "%c" ausgegeben.';
	SMARTPET_COMMANDS_AUTOCOWER_ENABLED		= "Automatisches Ducken ist aktiv.";
	SMARTPET_COMMANDS_AUTOCOWER_DISABLED		= "Automatisches Ducken ist nicht mehr aktiv.";
	SMARTPET_COMMANDS_COWERHEALTH			= "Automatisches Ducken wird aktiviert wenn das Tier weniger als %h% Leben hat.";
	SMARTPET_COMMANDS_NOCHASE_ENABLED		= "Dein Tier verfolgt sein Ziel nicht wenn es flieht.";
	SMARTPET_COMMANDS_NOCHASE_DISABLED		= "Dein Tier verfolgt sein Ziel wenn es flieht.";
	SMARTPET_COMMANDS_SHOWDEBUG_ENABLED		= "Debug Meldungen werden angezeigt.";
	SMARTPET_COMMANDS_SHOWDEBUG_DISABLED		= "Debug Meldungen werden nicht mehr angezeigt.";
	SMARTPET_COMMANDS_TOOLTIPS_ENABLED		= "Tooltips werden angezeigt.";
	SMARTPET_COMMANDS_TOOLTIPS_DISABLED		= "Tooltips werden nicht mehr angezeigt.";


	-- Benutzungstexte
	SMARTPET_USAGE_ENABLED			= "aktiviert";
	SMARTPET_USAGE_DISABLED			= "deaktiviert";
	SMARTPET_USAGE_PERCENT			= "<prozent>"
	SMARTPET_USAGE_SMARTPET			= "Aktiviert/Deaktiviert alle Funktionen von SmartPet.";
	SMARTPET_USAGE_TAUNTMAN			= "Aktiviert/Deaktiviert das Bedrohungs Management.";
	SMARTPET_USAGE_SMARTFOCUS		= "Aktiviert/Deaktiviert das Fokus Management.";
	SMARTPET_USAGE_AUTOWARN			= "Aktiviert/Deaktiviert die Warnung wenn das Tier nur noch wenig Leben hat.";
	SMARTPET_USAGE_WARNHEALTH		= "Lebenswarnung des Tiers wenn Leben unter diesem Wert.";
	SMARTPET_USAGE_CHANNEL			= "Lebenswarnung des Tiers in diesem Kanal ausgeben.";
	SMARTPET_USAGE_AUTOCOWER		= "Aktiviert/Deaktiviert automatisches Ducken wenn das Tier nur noch wenig Leben hat.";
	SMARTPET_USAGE_COWERHEALTH		= "Automatisches Ducken wenn Leben unter diesem Wert.";
	SMARTPET_USAGE_NOCHASE			= "Tier beendet den Kampf wenn Ziel flieht.";
	SMARTPET_USAGE_TOOLTIPS			= "Zeigt/Versteckt die Tooltips von SmartPet.";


elseif ( GetLocale() == "frFR" ) then
-- *
-- * FRENCH
-- *

-- The next 6 lines define the names of the pets abilities. The localization of these settings
-- into the clients language are a "must" to use the basic functions of SmartPet.

SMARTPET_ACTIONS_GROWL		= "Grondement";
SMARTPET_ACTIONS_COWER		= "Tremblements";
SMARTPET_ACTIONS_CLAW		= "Griffe";
SMARTPET_ACTIONS_BITE		= "Morsure";
SMARTPET_ACTIONS_DASH		= "C/233l/233rit/233";
SMARTPET_ACTIONS_DIVE		= "Plongeon";

-- The next line defines the text that is used by SmartPet to determine if the opponent flees.
-- The localization of this text into the clients language is a "must" for using the anti-chasing
-- functions of SmartPet.

SMARTPET_SEARCH_RUNAWAY = "essaie de s'enfuir dans un moment de panique";

-- The lines below are normal text and not necessary for SmartPets functionality. You can
-- translate them to be displayed in your clients language.

-- Loading strings
SMARTPET_VERSION_RUNNING = "Version %v POUR CLIENT FR charg\195\169e: Tapez /smartpet ou /sp Pour des informations.";		-- %v = Version number
SMARTPET_VERSION_CHANGED = "Variables par d\195\169faut charg\195\169es. Tapez /sp";
SMARTPET_ONLY_FOR_HUNTER = "Cet addon est destin\195\169 aux chasseurs uniquement.";

-- Pet messages
SMARTPET_PET_NEEDS_HEALING = "%n a besoin de soins! (%h% de vie)";		-- %n = Pet name | %h = Pet health
SMARTPET_PET_BREAKS_COMBAT = "%n interrompt le combat!";			-- %n = Pet name

-- Tooltips
SMARTPET_TOOLTIP_MANAGEMENT		= "Gestion";
SMARTPET_TOOLTIP_AUTOCOWER		= "AutoTremblements est activ\195\169\nSmartpet lancera Tremblements quand la\nvie du familier sera de %h%. Si Grondement est activ\195\169 \nSmartpet le d\195\169sactivera.";
SMARTPET_TOOLTIP_SMARTFOCUS1	= "SmartFocus est activ\195\169 SmartPet\noptimisera les DPS du familier\nen activant Griffe et en d\195\169sactivant Morsure\npendant le d\195\169but du combat soit 12 sec. Ensuite\nle familier utilisera Morsure.";
SMARTPET_TOOLTIP_SMARTFOCUS2	= "Vous devez activer Griffe et Morsure pour\nque SmartFocus fonctionne."
SMARTPET_TOOLTIP_GROWL1				= "SmartPet fait en sorte que le familier\npuisse activer Grondement toutes les 5 secondes.";
SMARTPET_TOOLTIP_GROWL2				= "Vous devez avoir Tremblements sur votre\nbarre d'action de familier pour que\n AutoTremblements fonctionne.";
SMARTPET_TOOLTIP_GROWL3				= "SmartPet d\195\169sactivera Grondement durant le combat.";
SMARTPET_TOOLTIP_GROWL4				= "SmartPet ne changera pas l'activation automatique\nde Grondement durant le combat.";
SMARTPET_TOOLTIP_COWER1				= "SmartPet fait en sorte que le familier puisse\nactiver Tremblements toutes les 5 secondes."
SMARTPET_TOOLTIP_COWER3				= "SmartPet d\195\169sactivera Tremblements durant le combat.";
SMARTPET_TOOLTIP_COWER4				= "SmartPet ne changera pas l'activation automatique\nde Tremblements durant le combat.";
SMARTPET_TOOLTIP_CLAW1				= "SmartPet d\195\169sactivera Griffe durant le combat\nsi le pet ne dispose pas de suffisamment de focus\npour lancer %a. Il sera\nr\195\169activer si le familier a assez de focus\npour utiliser %a et Griffe."
SMARTPET_TOOLTIP_CLAW2				= "SmartPet d\195\169sactivera Griffe durant le combat.";
SMARTPET_TOOLTIP_BITE1				= "SmartPet d\195\169sactivera Morsure durant le combat\nsi le pet ne dispose pas de suffisamment de focus\npour lancer %a. Il sera\nr\195\169activer si le familier a assez de focus\npour utiliser %a et Morsure."
SMARTPET_TOOLTIP_BITE2				= "SmartPet d\195\169sactivera Morsure durant le combat.";

-- Toggle commands
SMARTPET_COMMANDS_SMARTPET_ENABLED		= "SmartPet activ\195\169";
SMARTPET_COMMANDS_SMARTPET_DISABLED		= "SmartPet d\195\169sactiv\195\169";
SMARTPET_COMMANDS_TAUNTMAN						= "Utilisez les boutons au-dessus de Tremblements et Grondement sur votre barre de familier pour activer la gestion du Taunt";
SMARTPET_COMMANDS_SMARTFOCUS_ENABLED	= "Gestion de Smart Focus activ\195\169e";
SMARTPET_COMMANDS_SMARTFOCUS_DISABLED	= "Gestion de Smart Focus d\195\169sactiv\195\169e";
SMARTPET_COMMANDS_AUTOWARN_ENABLED		= "niveau bas de vie activ\195\169";
SMARTPET_COMMANDS_AUTOWARN_DISABLED		= "niveau bas de vie d\195\169sactiv\195\169";
SMARTPET_COMMANDS_WARNHEALTH					= "niveau bas de vie configur\195\169 pour %h%";		-- %h = health percent
SMARTPET_COMMANDS_CHANNEL							= "Channel choisi %c";								-- %c = Channel name
SMARTPET_COMMANDS_AUTOCOWER_ENABLED		= "Activation de Tremblements quand niveau bas de vie activ\195\169";
SMARTPET_COMMANDS_AUTOCOWER_DISABLED	= "Activation de Tremblements quand niveau bas de vie d\195\169sactiv\195\169";
SMARTPET_COMMANDS_COWERHEALTH					= "AutoTremblements pour un niveau de vie de %h%";			-- %h = health percent
SMARTPET_COMMANDS_NOCHASE_ENABLED			= "Votre familier cessera le combat si la créature s'enfuit";
SMARTPET_COMMANDS_NOCHASE_DISABLED		= "Votre familier poursuivra sa cible";
SMARTPET_COMMANDS_SHOWDEBUG_ENABLED		= "Correction affichage de texte activ\195\169";
SMARTPET_COMMANDS_SHOWDEBUG_DISABLED	= "Correction affichage de texte d\195\169sactiv\195\169";
SMARTPET_COMMANDS_TOOLTIPS_ENABLED		= "Astuces activ\195\169es";
SMARTPET_COMMANDS_TOOLTIPS_DISABLED		= "Astuces d\195\169sactiv\195\169es";

-- Usage messages
SMARTPET_USAGE_ENABLED			= "activ\195\169";
SMARTPET_USAGE_DISABLED			= "d\195\169sactiv\195\169";
SMARTPET_USAGE_PERCENT			= "<percent>"
SMARTPET_USAGE_SMARTPET			= "active ou d\195\169sactive les fonctionnalit\195\169s de Smartpet.";
SMARTPET_USAGE_TAUNTMAN			= "Bascule sur la gestion du Taunt.";
SMARTPET_USAGE_SMARTFOCUS		= "Bascule sur la gestion de AutoFocus.";
SMARTPET_USAGE_AUTOWARN			= "Bascule sur l'alerte de niveau bas de vie du familier.";
SMARTPET_USAGE_WARNHEALTH		= "Le familier donnera son niveau de vie si il descend sous la limite donn\195\169e ";
SMARTPET_USAGE_CHANNEL			= "Les informations de niveau de vie du familier iront sur ce channel.";
SMARTPET_USAGE_AUTOCOWER		= "Bascule sur la gestion de Autotremblement quand le niveau de vie du pet est bas.";
SMARTPET_USAGE_COWERHEALTH	= "Le familier utilsera Tremblements quand son niveau de vie sera sous la limite donn\195\169e.";
SMARTPET_USAGE_NOCHASE			= "Le familier arr\195\170tera le combat si la cr\195\169ature s'enfuit.";
SMARTPET_USAGE_TOOLTIPS			= "Bascule sur l'affichage des Astuces.";
end

