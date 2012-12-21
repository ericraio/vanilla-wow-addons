-- Version : French (by Vjeux)
-- Last Update : 02/17/2005

if ( GetLocale() == "frFR" ) then

-- UltimateUI Configuration
	ULTIMATEUI_CONFIG_QLOOT_HEADER		= "Loot Rapide";
	ULTIMATEUI_CONFIG_QLOOT_HEADER_INFO		= "Le Loot Rapide va d\195\169placer la fen\195\170tre de loot sous votre curseur lorsqu\'elle s\'ouvre, et elle se d\195\169place \195\160 chaque fois que vous prennez un objet.";
	ULTIMATEUI_CONFIG_QLOOT			= "Cliquer ici pour activer le Loot Rapide.";
	ULTIMATEUI_CONFIG_QLOOT_INFO		= "Le Loot Rapide va d\195\169placer la fen\195\170tre de loot sous votre curseur lorsqu\'elle s\'ouvre, et elle se d\195\169place \195\160 chaque fois que vous prennez un objet.";
	ULTIMATEUI_CONFIG_QLOOT_HIDE		= "Fermer automatiquement la fen\195\170tre quand vide.";	
	ULTIMATEUI_CONFIG_QLOOT_HIDE_INFO		= "Si il n\'y a aucun objets dans la fen\195\170tre de loots, celle-ci va \195\170tre automatiquement ferm\195\169e si cette option est activ\195\169e.";
	ULTIMATEUI_CONFIG_QLOOT_ONSCREEN		= "Toujours afficher la fen\195\170tre de loot m\195\170me en dehors de l\'\195\169cran.";
	ULTIMATEUI_CONFIG_QLOOT_ONSCREEN_INFO	= "Si cette option est activ\195\169e, la fen\195\170tre de loot ne sortira plus jamais de l\'\195\169cran.";
	
	ULTIMATEUI_CONFIG_QLOOT_MOVE_ONCE		= "D\195\169placer la fen\195\170tre sur la Souris.";
	ULTIMATEUI_CONFIG_QLOOT_MOVE_ONCE_INFO	= "Lorsque l'option est activ\195\169e, Loot Rapide ne d\195\169placera pas la fen\195\170tre plus d\'une fois.";
	
-- Chat Configuration
	ERR_LOOT_NONE				= "Il n\'y avait aucun objet !";

	QUICKLOOT_CHAT_COMMAND_INFO		= "Options de Loot Rapide en ligne de commandes. Essayer sans param\195\170tre pour acc\195\169der \195\160 l\'aide.";
	QUICKLOOT_CHAT_COMMAND_USAGE		= "Utilisation : /quickloot <enable/autohide/onscreen/moveonce>\nToutes les commandes de changement d\'\195\169tat.\nCommandes:\n enable - Actives/d\195\169sactive Loot Rapide\n autohide - Disparition automatique de Loot Rapide lorsque la fen\195\170tre est vide ou non\n onscree - Garde la fen\195\170tre affich\195\169e a l\'\195\169cran ou non";
	QUICKLOOT_CHAT_COMMAND_ENABLE		= ULTIMATEUI_CONFIG_QLOOT_HEADER;
	QUICKLOOT_CHAT_COMMAND_HIDE		= ULTIMATEUI_CONFIG_QLOOT_HEADER.." Cacher";
	QUICKLOOT_CHAT_COMMAND_ONSCREEN		= ULTIMATEUI_CONFIG_QLOOT_HEADER.." Garder \195\160 \195\169cran";
	QUICKLOOT_CHAT_COMMAND_MOVE_ONCE	= ULTIMATEUI_CONFIG_QLOOT_HEADER.." D\195\169placer une fois";

	QUICKLOOT_CHAT_STATE_ENABLED		= " Activ\195\169";
	QUICKLOOT_CHAT_STATE_DISABLED		= " D\195\169sactiv\195\169";
	
end