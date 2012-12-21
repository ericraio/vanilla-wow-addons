-- Version : French ( by Vjeux, Sasmira )
-- last update : 08/10/2005 

if ( GetLocale() == "frFR" ) then

-- Interface Configuration
	IEF_FILE		= "Fichier : ";
	IEF_STRING		= "Cha\195\174ne : ";
	IEF_LINE		= "Ligne : ";
	IEF_COUNT		= "Nombre : ";
	IEF_ERROR		= "Erreur : ";

	IEF_CANCEL		= "Annuler";
	IEF_CLOSE		= "Fermer";
	IEF_REPORT		= "Reporter";

	IEF_INFINITE		= "Infini";

-- Slash command strings
IEF_NOTIFY_ON		= "ImprovedErrorFrame: Affichage des alertes activ\159\169es.";
IEF_NOTIFY_OFF		= "ImprovedErrorFrame: Rapporter les erreurs comme elles se produisent.";
IEF_BLINK_ON		= "ImprovedErrorFrame: Clignotement des erreurs en suspens.";
IEF_BLINK_OFF		= "ImprovedErrorFrame: Le bouton ne clignotera pas.";
IEF_COUNT_ON		= "ImprovedErrorFrame: Compteur d\'affichage pour les erreurs en suspens.";
IEF_COUNT_OFF		= "ImprovedErrorFrame: Aucun compteur pour les erreurs en suspens.";
IEF_ALWAYS_ON		= "ImprovedErrorFrame: Toujours afficher le bouton d\'erreurs.";
IEF_ALWAYS_OFF		= "ImprovedErrorFrame: Affichage du bouton lors d\'une erreur.";
IEF_SOUND_ON		= "ImprovedErrorFrame: Son jou\195\169 lors d\'une erreur.";
IEF_SOUND_OFF		= "ImprovedErrorFrame: Pas de son jou\195\169.";
IEF_EMPTY_ON		= "ImprovedErrorFrame: Le bouton graphique dispara\195\174t en clignotant.";
IEF_EMPTY_OFF		= "ImprovedErrorFrame: Le bouton graphique ne change pas avec le clignotement.";
IEF_DEBUG_ON		= "ImprovedErrorFrame: Entrer en mode FrameXML d\195\169taill\195\169";
IEF_DEBUG_OFF		= "ImprovedErrorFrame: Sortir du mode FrameXML d\195\169taill\195\169";
IEF_FORMAT_STR		= "Format: /ief <NOTIFY|BLINK|COUNT|ALWAYS|SOUND|EMPTY|DEBUG> <ON|OFF>";
IEF_FORMAT_STR_NOCHRON	= "Format: /ief <NOTIFY|COUNT|ALWAYS|SOUND|DEBUG> <ON|OFF>";
IEF_CURRENT_SETTINGS	= "Configuration courante :";
IEF_BLINK_OPT		= "blink";
IEF_NOTIFY_OPT		= "notify";
IEF_COUNT_OPT		= "count";
IEF_ALWAYS_OPT		= "always";
IEF_SOUND_OPT		= "son";
IEF_EMPTY_OPT		= "empty";
IEF_DEBUG_OPT		= "debug";
IEF_ON			= "on";
IEF_OFF			= "off";
IEF_HELP_TEXT		= "/ief - Configuration d\'Improved Error Frame";

-- Tooltip Text
IEF_TOOLTIP		= "Cliquer pour voir les erreurs.";
-- Header Text
IEF_TITLE_TEXT		= "Erreurs en Queue";
IEF_ERROR_TEXT		= "Erreurs en Temps R\195\169el";

-- Khaos/Cosmos descriptions
IEF_OPTION_TEXT		= "Improved Error Frame";
IEF_OPTION_HELP		= "Permet de configurer les options des rapports d\'erreurs.";
IEF_HEADER_TEXT		= "Improved Error Frame";
IEF_HEADER_HELP		= "Configure les diverses options dont vous avez besoin pour votre rapports d\'erreurs.";
IEF_NOTIFY_TEXT		= "Erreurs mises en attentes";
IEF_NOTIFY_HELP		= "Si activ\195\169, les erreurs seront mises en attentes et pourront \195\170tre visualis\195\169es plutard.";
IEF_BLINK_TEXT		= "Bouton Clignotant";
IEF_BLINK_HELP		= "Si v\195\169rifi\195\169, le bouton clignotera lorsqu\'une erreur apparaitra.";
IEF_COUNT_TEXT		= "Un compteur d\'erreurs s\'affichage sur le bouton";
IEF_COUNT_HELP		= "Si v\195\169rifi\195\169, un compteur d\'erreurs s\'affichera sur le bouton.";
IEF_ALWAYS_TEXT		= "Toujours afficher le bouton d\'erreur";
IEF_ALWAYS_HELP		= "Si v\195\169rifi\195\169, le bouton sera toujours pr\195\169sent sur l\'\195\169cran.";
IEF_SOUND_TEXT		= "Jouer un son lors d\'une erreur";
IEF_SOUND_HELP		= "Si v\195\169rifi\195\169, un son sera jou\195\169 lors d\'une erreur.";
IEF_EMPTY_TEXT		= "Effacer le bouton graphique";
IEF_EMPTY_HELP		= "Si v\195\169rifi\195\169, le bouton d\'erreurs disparait quand il clignote.";
IEF_DEBUG_TEXT		= "Afficher le journal d\'erreurs d\195\169taill\195\169 FrameXML";
IEF_DEBUG_HELP		= "Si v\195\169rifi\195\169, journal d\'erreurs FrameXML sortira plus d\195\169taill\195\169. (N\195\169cessite un relancement d\'UI)";

end