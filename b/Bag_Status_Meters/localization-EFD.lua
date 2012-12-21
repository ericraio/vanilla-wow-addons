--French (frFR)Translation: kiki
--German (deDE) Translation: SirPennt

BSM_VERSION         = "v1.3.7";

--Untranslated variables
BSM_TEXT_BACK       = "Show background and meter";

if ( GetLocale() == "frFR" ) then
BINDING_HEADER_BSM = "Indicateur d’Etat des Sacs";
BINDING_NAME_BSM_OPTIONS = "Options de l’IES";

BSM_MSG             = "|cffffff00Indicateur d’Etat des Sacs|r: ";
BSM_AMMO			= { "Carquois", "giberne", "Bandolier" };
BSM_FREEBAGSLOTS	= "Places libres:";
BSM_BAG             = "Le sac ";
BSM_BACKPACK        = "Le sac à dos";
BSM_FULL            = " est plein!";

BSM_OPTIONS         = "Options de IES";
BSM_OPTIONS_INDIVID = "Jauges Individuelles";
BSM_OPTIONS_OVERALL = "Jauge Globale";
BSM_OPTIONS_GLOBAL  = "Options Globales";
BSM_OPTIONS_DEFAULT = "Défaut";
BSM_OPTIONS_CLOSE   = "Fermer";

BSM_TEXT_HIDE       = "Cache la jauge globale";
BSM_TEXT_SHOW       = "Affiche la jauge globale";
BSM_TEXT_INDIVIDUAL = "Active les jauges individuelles";
BSM_TEXT_OVERLAY    = "Active la sur-impression";
BSM_TEXT_BAR        = "Utilise une barre pour indiquer l’état des sacs";
BSM_TEXT_LABELSTAT  = "N’utilise que du texte pour indiquer l’état";
BSM_TEXT_DROPDOWN   = "Utilise une boîte défilante pour la jauge globale";
BSM_TEXT_BINDINGS   = "Affiche les raccourcis pour ouvrir les sacs";
BSM_TEXT_OVERALL    = "Active la jauge globale";
BSM_TEXT_OVERALLLOCK= "Verrouille la position de la jauge globale";
BSM_TEXT_OVERALLPOS = "Change la position de la jauge globale (x y):";
BSM_TEXT_SET        = "OK";
BSM_TEXT_LABELS     = "Affiche les chiffres";
BSM_TEXT_COLOR      = "Utilise des couleurs";
BSM_TEXT_TOTALS     = "Affiche la capacité des sacs";
BSM_TEXT_SLOTS      = "Affiche le nombre d'emplacements libre plutôt qu'utilisés";
BSM_TEXT_TITLE      = "Affiche le titre au dessus de la jauge globale";
BSM_TEXT_NOTIFY     = "Active les notifications quand un sac est plein";
BSM_TEXT_OPTBUTTON  = "Affiche le bouton des options";

elseif ( GetLocale() == "deDE" ) then
BINDING_HEADER_BSM = "Bag Status Meters";
BINDING_NAME_BSM_OPTIONS = "BSM Options Pane";

BSM_MSG             = "|cffffff00Bag Status Meters|r: ";

BSM_AMMO			= { "K\195\182cher", "Munition", "Bandolier", "Jagdk�cher" };
BSM_FREEBAGSLOTS	= "Inventar";
BSM_BAG             = "Beutel ";
BSM_BACKPACK        = "Rucksack";
BSM_FULL            = " ist voll!";

BSM_OPTIONS         = "BSM Optionen";
BSM_OPTIONS_INDIVID = "Individuelles";
BSM_OPTIONS_OVERALL = "Gesamtanzeige";
BSM_OPTIONS_GLOBAL  = "Globales";
BSM_OPTIONS_DEFAULT = "Reset";
BSM_OPTIONS_CLOSE   = "Schliessen";

BSM_TEXT_HIDE       = "Gesamtanzeige verstecken";
BSM_TEXT_SHOW       = "Gesamtanzeige anzeigen";
BSM_TEXT_INDIVIDUAL = "Individuelle Beutelanzeige verwenden";
BSM_TEXT_OVERLAY    = "Status der Beutel anzeigen";
BSM_TEXT_BAR        = "Balken zum anzeigen des Status verwenden";
BSM_TEXT_LABELSTAT  = "Nur Zahlen zum anzeigen des Status verwenden";
BSM_TEXT_DROPDOWN   = "Ein Dropdownmen\195\188 zum anzeigen des Beutelstandes anzeigen";
BSM_TEXT_BINDINGS   = "Zeige Tastenkombination neben dem Dropdownmen\195\188";
BSM_TEXT_OVERALL    = "Gesamtstatusanzeige verwenden";
BSM_TEXT_OVERALLLOCK= "Gesamtstatusanzeige festsetzen (lock)";
BSM_TEXT_OVERALLPOS = "Position der Gesamtanzeige setzen (x y):";
BSM_TEXT_SET        = "Los";
BSM_TEXT_LABELS     = "Zahlen anzeigen";
BSM_TEXT_COLOR      = "Farben verwenden";
BSM_TEXT_TOTALS     = "Totalen Beutelstatus anzeigen";
BSM_TEXT_SLOTS      = "Freie Slots anzeigen, statt verwendete Slots anzeigen";
BSM_TEXT_TITLE      = "Titel �ber der Gesamtanzeige zeigen";
BSM_TEXT_NOTIFY     = "Text einblenden und Sound abspielen wenn ein Beutel voll ist";
BSM_TEXT_OPTBUTTON  = "Optionsbutton neben Gesamtanzeige zeigen";

else
BINDING_HEADER_BSM = "Bag Status Meters";
BINDING_NAME_BSM_OPTIONS = "BSM Options Pane";

BSM_MSG             = "|cffffff00Bag Status Meters|r: ";

BSM_AMMO			= { "Quiver", "Ammo", "Bandolier", "Lamina" };
BSM_FREEBAGSLOTS	= "Free Bag Slots:";
BSM_BAG             = "Bag ";
BSM_BACKPACK        = "Backpack";
BSM_FULL            = " is now full!";

BSM_OPTIONS         = "BSM Options";
BSM_OPTIONS_INDIVID = "Individual Meters";
BSM_OPTIONS_OVERALL = "Overall Meter";
BSM_OPTIONS_GLOBAL  = "Global";
BSM_OPTIONS_DEFAULT = "Default";
BSM_OPTIONS_CLOSE   = "Close";

BSM_TEXT_HIDE       = "Hide the overall slot meter";
BSM_TEXT_SHOW       = "Show the overall slot meter";
BSM_TEXT_INDIVIDUAL = "Enable individual bag status";
BSM_TEXT_OVERLAY    = "Enable bag overlay meters";
BSM_TEXT_BAR        = "Use a bar to display bag status";
BSM_TEXT_LABELSTAT  = "Use only text to display bag status";
BSM_TEXT_DROPDOWN   = "Use a dropdown from the overall slot meter to display bag status";
BSM_TEXT_BINDINGS   = "Show key binding buttons to bags";
BSM_TEXT_OVERALL    = "Enable the overall meter";
BSM_TEXT_OVERALLLOCK= "Lock the position of the overall meter";
BSM_TEXT_OVERALLPOS = "Set the position of the overall meter (x y):";
BSM_TEXT_SET        = "Set";
BSM_TEXT_LABELS     = "Show labels";
BSM_TEXT_COLOR      = "Use color";
BSM_TEXT_TOTALS     = "Display total bag slots";
BSM_TEXT_SLOTS      = "Use free slots as opposed to used slots for display";
BSM_TEXT_TITLE      = "Display the title on the overall meter";
BSM_TEXT_NOTIFY     = "Enable notifications when bags are full";
BSM_TEXT_OPTBUTTON  = "Enable the options button";
end
