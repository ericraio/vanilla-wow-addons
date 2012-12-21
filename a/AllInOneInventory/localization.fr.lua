if (GetLocale()=="frFR") then

-- Version : English - sarf
-- Translation by : Skoot / Sasmira
-- Last Update 08/07/2005

BINDING_HEADER_ALLINONEINVENTORYHEADER				= "Inventaire Combiné";
BINDING_NAME_ALLINONEINVENTORY					= "[ON/OFF] l\'Inventaire Combiné";

ALLINONEINVENTORY_BAG_TITLE_SHORT 				= "AIOI";
ALLINONEINVENTORY_BAG_TITLE_LONG  				= "Inventaire Combiné";

ALLINONEINVENTORY_CONFIG_HEADER					= "Inventaire Combiné";
ALLINONEINVENTORY_CONFIG_HEADER_INFO				= "Contient la configuration de l\'Inventaire Combiné,\nun addOn qui vous permet de regrouper tous les sacs en un seul.";
ALLINONEINVENTORY_CONFIG_HEADER_SHORT_INFO			= "Inventaire Pratique";
ALLINONEINVENTORY_CONFIG_HEADER_TEXTURE				= "Interface\\Buttons\\Button-Backpack-Up";

ALLINONEINVENTORY_CHAT_ENABLED					= "Inventaire Combiné activé";
ALLINONEINVENTORY_CHAT_DISABLED					= "Inventaire Combiné désactivé.";

ALLINONEINVENTORY_CHAT_ALPHA_FORMAT					= "Configuration de la Transparence \195\160 %f (0 Config. par d\195\169faut)";

ALLINONEINVENTORY_CHAT_SCALE_FORMAT					= "Configuration de l\'Echelle \195\160 %f (0 Config. par d\195\169faut)";

ALLINONEINVENTORY_CHAT_SWAP_BAG_ORDER_ENABLED		= "Changement de l\'ordre des sacs activ\195\169.";
ALLINONEINVENTORY_CHAT_SWAP_BAG_ORDER_DISABLED		= "Changement de l\'ordre des sacs d\195\169activ\195\169.";

ALLINONEINVENTORY_CHAT_LOCKED_ENABLED				= "Inventaire Combiné vérouillé";
ALLINONEINVENTORY_CHAT_LOCKED_DISABLED				= "Inventaire Combiné dévérouillé.";

ALLINONEINVENTORY_CHAT_COMMAND_INFO					= "Contrôle l'Inventaire Combiné depuis le chat - /modname pour l'aide.";

ALLINONEINVENTORY_CHAT_COMMAND_USAGE				= {};
table.insert(ALLINONEINVENTORY_CHAT_COMMAND_USAGE, "Usage: /allinoneinventory [toggle/includeshotbags/replacebags/reset/columns]");
table.insert(ALLINONEINVENTORY_CHAT_COMMAND_USAGE, "Commands:");
table.insert(ALLINONEINVENTORY_CHAT_COMMAND_USAGE, "toggle - active ou désactive la fenêtre de l'Inventaire Combiné");
table.insert(ALLINONEINVENTORY_CHAT_COMMAND_USAGE, " includeshotbags - s'il faut ou pas inclure les sacs de munitions");
table.insert(ALLINONEINVENTORY_CHAT_COMMAND_USAGE, " reset - réinitialise la position de la fenêtre");
table.insert(ALLINONEINVENTORY_CHAT_COMMAND_USAGE, " replacebags - s'il faut ou non remplacer les sacs classiques");
table.insert(ALLINONEINVENTORY_CHAT_COMMAND_USAGE, " columns - combien de colonnes afficher par ligne");
table.insert(ALLINONEINVENTORY_CHAT_COMMAND_USAGE, " togglebags - active ou désactive le sac numéroté, ou le sac à dos");

ALLINONEINVENTORY_TOGGLE_SLOT_FAIL					= "Inventaire Combiné - Echec du changement sac/emplacement - sp\195\169cification incorrecte .";
ALLINONEINVENTORY_TOGGLE_SLOT						= "Inventaire Combiné - Changement sac/emplacement %d/%d %s.";
ALLINONEINVENTORY_TOGGLE_SLOT_ON					= "on";
ALLINONEINVENTORY_TOGGLE_SLOT_OFF					= "off";

ALLINONEINVENTORY_CHAT_COLUMNS_FORMAT				= "Nombre de colonnes dans l'Inventaire Combiné défini à %d.";

ALLINONEINVENTORY_CHAT_REPLACEBAGS_ENABLED			= "Les sacs normaux sont remplacés par l'Inventaire Combiné.";
ALLINONEINVENTORY_CHAT_REPLACEBAGS_DISABLED			= "Les sacs normaux ne sont pas remplacés par l'Inventaire Combiné.";

ALLINONEINVENTORY_CHAT_RESETPOSITION				= "La position de l'Inventaire Combiné a été réinitialisée.";

ALLINONEINVENTORY_CHAT_INCLUDE_SHOTBAGS_ENABLED		= "Les sacs de munition sont inclus dans l'Inventaire Combiné.";
ALLINONEINVENTORY_CHAT_INCLUDE_SHOTBAGS_DISABLED	= "Les sacs de munition ne sont pas inclus dans l'Inventaire Combiné.";

ALLINONEINVENTORY_CHAT_INCLUDE_BAGZERO_ENABLED		= "Le sac à dos est inclu dans l'Inventaire Combiné.";
ALLINONEINVENTORY_CHAT_INCLUDE_BAGZERO_DISABLED		= "Le sac à dos n'est pas inclu dans l'Inventaire Combiné.";

ALLINONEINVENTORY_CHAT_INCLUDE_BAGONE_ENABLED		= "Le sac 1 est inclu dans l'Inventaire Combiné.";
ALLINONEINVENTORY_CHAT_INCLUDE_BAGONE_DISABLED		= "Le sac 1 n'est pas inclu dans l'Inventaire Combiné.";

ALLINONEINVENTORY_CHAT_INCLUDE_BAGTWO_ENABLED		= "Le sac 2 est inclu dans l'Inventaire Combiné.";
ALLINONEINVENTORY_CHAT_INCLUDE_BAGTWO_DISABLED		= "Le sac 2 n'est pas inclu dans l'Inventaire Combiné.";

ALLINONEINVENTORY_CHAT_INCLUDE_BAGTHREE_ENABLED		= "Le sac 3 est inclu dans l'Inventaire Combiné.";
ALLINONEINVENTORY_CHAT_INCLUDE_BAGTHREE_DISABLED	= "Le sac 3 n'est pas inclu dans l'Inventaire Combiné.";

ALLINONEINVENTORY_CHAT_INCLUDE_BAGFOUR_ENABLED		= "Le sac 4 est inclu dans l'Inventaire Combiné.";
ALLINONEINVENTORY_CHAT_INCLUDE_BAGFOUR_DISABLED		= "Le sac 4 n'est pas inclu dans l'Inventaire Combiné.";

ALLINONEINVENTORY_CHAT_NO_SUCH_BAGNUMBER			= "L'Inventaire Combiné ne reconnait pas le numéro du sac - 0 est pour le sac à dos, 1-4 est pour le sac correspondant.";

end
