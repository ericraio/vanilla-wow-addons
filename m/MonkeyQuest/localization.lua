--[[

	MonkeyQuest:
	Displays your quests for quick viewing.
	
	Website:	http://wow.visualization.ca/
	Author:		Trentin (trentin@toctastic.net)
	
	
	Contributors:
	Celdor
		- Help with the Quest Log Freeze bug
		
	Diungo
		- Toggle grow direction
		
	Pkp
		- Color Quest Titles the same as the quest level
	
	wowpendium.de
		- German translation
		
	MarsMod
		- Valid player name before the VARIABLES_LOADED event bug
		- Settings resetting bug

	Juki
		- French translation
	
	Global
		- PvP Quests

--]]

-- ** NOTE ** The other languages are getting out of date, 
-- if you'd like to submit an update please email it to trentin@toctastic.net


-- English, the default
MONKEYQUEST_TITLE					= "MonkeyQuest";
MONKEYQUEST_VERSION					= "2.4";
MONKEYQUEST_TITLE_VERSION			= MONKEYQUEST_TITLE .. " v" .. MONKEYQUEST_VERSION;
MONKEYQUEST_DESCRIPTION				= "Displays your quests for quick viewing.";
MONKEYQUEST_INFO_COLOUR				= "|cffffff00";
MONKEYQUEST_LOADED_MSG				= MONKEYQUEST_INFO_COLOUR .. MONKEYQUEST_TITLE .. " v" .. MONKEYQUEST_VERSION .. " loaded";

MONKEYQUEST_QUEST_DONE				= "done";
MONKEYQUEST_QUEST_FAILED			= "failed";
MONKEYQUEST_CONFIRM_RESET			= "Okay to reset " .. MONKEYQUEST_TITLE .. " settings to default values?";

MONKEYQUEST_CHAT_COLOUR				= "|cff00ff00";
MONKEYQUEST_SET_WIDTH_MSG			= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": You may need to '/console reloadui' to see the changes in width.";
MONKEYQUEST_RESET_MSG				= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": Settings reset.";

MONKEYQUEST_HELP_MSG				= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest help <command>\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Where <command> is any of the following: \n" ..
									  "reset, open, close, showhidden, hidehidden, useoverviews, nooverviews, " ..
									  "tipanchor, alpha, width, hideheaders, showheaders, hideborder, showborder, " ..
									  "growup, growdown, hidenumquests, shownumquests, lock, unlock, colourtitleon, " ..
									  "colourtitleoff, hidecompletedquests, showcompletedquests, hidecompletedobjectives, " ..
									  "showcompletedobjectives, fontheight, showtooltipobjectives, hidetootipobjectives, " ..
									  "allowrightclick, disallowrightclick, hidetitlebuttons, showtitlebuttons.";
MONKEYQUEST_HELP_RESET_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest reset\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Displays the reset config variables dialog.\n";
MONKEYQUEST_HELP_OPEN_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest open\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Shows the main " .. MONKEYQUEST_TITLE .. " frame.\n";
MONKEYQUEST_HELP_CLOSE_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest close\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Hides the main " .. MONKEYQUEST_TITLE .. " frame.\n";
MONKEYQUEST_HELP_SHOWHIDDEN_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showhidden\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Shows collapsed zone headers and hidden quests.\n";
MONKEYQUEST_HELP_HIDEHIDDEN_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidehidden\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Hides collapsed zone headers and hidden quests.\n";
MONKEYQUEST_HELP_USEOVERVIEWS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest useoverviews\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Displays the quest overview for quests without objectives.\n";
MONKEYQUEST_HELP_NOOVERVIEWS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest nooverviews\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Don't display the quest overview for quests without objectives.\n";
MONKEYQUEST_HELP_TIPANCHOR_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest tipanchor=<anchor position>\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Sets the anchor point of the tooltip where <anchor position> " .. 
									  "can be any of the following:\nANCHOR_TOPLEFT, ANCHOR_TOPRIGHT, ANCHOR_TOP, ANCHOR_LEFT, " ..
									  "ANCHOR_RIGHT, ANCHOR_BOTTOMLEFT, ANCHOR_BOTTOMRIGHT, ANCHOR_BOTTOM, ANCHOR_CURSOR, " .. 
									  "DEFAULT, NONE";
MONKEYQUEST_HELP_ALPHA_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest alpha=<0 - 255>\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Sets the backdrop alpha to the specified value.\n";
MONKEYQUEST_HELP_WIDTH_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest width=<positive integer>\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Sets the width to the specified value, the default is 255.\n";
MONKEYQUEST_HELP_HIDEHEADERS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hideheaders\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Never display any zone headers.\n";
MONKEYQUEST_HELP_SHOWHEADERS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showheaders\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Display zone headers.\n";
MONKEYQUEST_HELP_HIDEBORDER_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hideborder\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Hide the border around the main " .. MONKEYQUEST_TITLE .. " frame.\n";
MONKEYQUEST_HELP_SHOWBORDER_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showborder\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Show the border around the main " .. MONKEYQUEST_TITLE .. " frame.\n";
MONKEYQUEST_HELP_GROWUP_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest growup\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Makes the main " .. MONKEYQUEST_TITLE .. " frame expand upwards.\n";
MONKEYQUEST_HELP_GROWDOWN_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest growdown\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Makes the main " .. MONKEYQUEST_TITLE .. " frame expand downwards.\n";
MONKEYQUEST_HELP_HIDENUMQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidenumquests\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Hide the number of quests next to the title.\n";
MONKEYQUEST_HELP_SHOWNUMQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest shownumquests\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Show the number of quests next to the title.\n";
MONKEYQUEST_HELP_LOCK_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest lock\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Locks the " .. MONKEYQUEST_TITLE .. " frame in place.\n";
MONKEYQUEST_HELP_UNLOCK_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest unlock\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Unlocks the " .. MONKEYQUEST_TITLE .. " frame, making it movable.\n";
MONKEYQUEST_HELP_COLOURTITLEON_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest colourtitleon\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Uses the difficulty to colour the entier quest title.\n";
MONKEYQUEST_HELP_COLOURTITLEOFF_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest colourtitleoff\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Doesn't colour the entier quest title by difficulty.\n";
MONKEYQUEST_HELP_HIDECOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidecompletedquests\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Hides completed quests.\n";
MONKEYQUEST_HELP_SHOWCOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showcompletedquests\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Shows completed quests.\n";
MONKEYQUEST_HELP_HIDECOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidecompletedobjectives\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Hides completed objectives.\n";
MONKEYQUEST_HELP_SHOWCOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showcompletedobjectives\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Shows completed objectives.\n";
MONKEYQUEST_HELP_FONTHEIGHT_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest fontheight=<positive integer>\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Sets the font height to the specified value, the default is 12.\n";
MONKEYQUEST_HELP_SHOWTOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showtooltipobjectives\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Adds a line to the tooltip which shows the completeness of that quest objective.\n";
MONKEYQUEST_HELP_HIDETOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidetooltipobjectives\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Does not add a line to the tooltip about the completeness of that quest objective.\n";
MONKEYQUEST_HELP_ALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest allowrightclick\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Allows you to right-click to open MonkeyBuddy.\n";
MONKEYQUEST_HELP_DISALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest disallowrightclick\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Disallows you from right-clicking to open MonkeyBuddy.\n";
MONKEYQUEST_HELP_HIDETITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidetitlebuttons\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Hides the title buttons.\n";
MONKEYQUEST_HELP_SHOWTITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showtitlebuttons\n" ..
									  MONKEYQUEST_CHAT_COLOUR .. "Shows the title buttons.\n";

									  
-- tooltip strings
MONKEYQUEST_TOOLTIP_QUESTITEM		= "Quest Item";		-- as it appears in the tooltip of unique quest items
MONKEYQUEST_TOOLTIP_QUEST			= "Quest";
MONKEYQUEST_TOOLTIP_SLAIN			= "slain";			-- as it appears in the objective text

-- misc quest strings
MONKEYQUEST_DUNGEON					= "Dungeon";
MONKEYQUEST_PVP						= "PvP";

-- noob tips
MONKEYQUEST_NOOBTIP_HEADER			= "Noob Tip:";

MONKEYQUEST_NOOBTIP_CLOSE			= "Click here to close the main frame. To get it back try:";
MONKEYQUEST_NOOBTIP_MINIMIZE		= "Click here to minimize the main frame";
MONKEYQUEST_NOOBTIP_RESTORE			= "Click here to restore the main frame";
MONKEYQUEST_NOOBTIP_SHOWALLHIDDEN	= "Click here to show all hidden items";
MONKEYQUEST_NOOBTIP_HIDEALLHIDDEN	= "Click here to hide all hidden items";
MONKEYQUEST_NOOBTIP_HIDEBUTTON		= "Click here to hide this quest. Activate 'Show all hidden items' to see this quest again";
MONKEYQUEST_NOOBTIP_TITLE			= "Right Click here to open MonkeyBuddy so you can configure " .. MONKEYQUEST_TITLE;
MONKEYQUEST_NOOBTIP_QUESTHEADER		= "Click here to hide/show all the quests under this zone. Activate 'Show all hidden items' to show zone headers you've hidden.";

-- bindings
BINDING_HEADER_MONKEYQUEST 			= MONKEYQUEST_TITLE;
BINDING_NAME_MONKEYQUEST_CLOSE 		= "Close/Open";
BINDING_NAME_MONKEYQUEST_MINIMIZE 	= "Minimize/Restore";
BINDING_NAME_MONKEYQUEST_HIDDEN		= "Hide/Show all hidden items";
BINDING_NAME_MONKEYQUEST_NOHEADERS	= "Toggle No Headers";


if ( GetLocale() == "frFR" ) then
    -- Traduit par Juki <Unskilled>
    
    MONKEYQUEST_DESCRIPTION             = "Affiche vos quêtes pour un aperçu rapide.";
    MONKEYQUEST_LOADED_MSG              = MONKEYQUEST_INFO_COLOUR .. MONKEYQUEST_TITLE .. " v" .. MONKEYQUEST_VERSION .. " chargé";
    
    MONKEYQUEST_CLOSE_TOOLTIP           = "Fermer";
    MONKEYQUEST_MINIMIZE_TOOLTIP        = "Réduire";
    MONKEYQUEST_HIDDEN_TOOLTIP          = "Montrer les quêtes cachées";
    
    MONKEYQUEST_QUEST_DONE              = "Terminée";
    MONKEYQUEST_CONFIRM_RESET           = "Ok pour remettre les options " .. MONKEYQUEST_TITLE .. " à leurs valeurs par défaut ?";
    
    MONKEYQUEST_SET_WIDTH_MSG           = MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. " : Vous aurez peut être besoin de '/console reloadui' pour voir les changements de la largeur."
    MONKEYQUEST_ALLOW_CLICKS_ON_MSG     = MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. " : Autorise les clics sur les quêtes."
    MONKEYQUEST_ALLOW_CLICKS_OFF_MSG    = MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. " : N'autorise pas les clics sur les quêtes."
    MONKEYQUEST_RESET_MSG               = MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. " : Options remises à zero."
    
    MONKEYQUEST_HELP_MSG                = MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest help <command>\n" ..
                                          MONKEYQUEST_CHAT_COLOUR .. "Où <command> est une des suivantes : \n" ..
                                          "reset, open, close, showhidden, hidehidden, useoverviews, nooverviews, " ..
                                          "tipanchor, alpha, width, hideheaders, showheaders, hideborder, showborder, " ..
                                          "growup, growdown, hidenumquests, shownumquests, lock, unlock, colourtitleon, " ..
                                          "colourtitleoff, hidecompletedquests, showcompletedquests, hidecompletedobjectives, " ..
                                          "showcompletedobjectives.";
    MONKEYQUEST_HELP_RESET_MSG          = MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest reset\n" ..
                                          MONKEYQUEST_CHAT_COLOUR .. "Affiche le dialogue de remise à zero des options.\n"
    MONKEYQUEST_HELP_OPEN_MSG           = MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest open\n" ..
                                          MONKEYQUEST_CHAT_COLOUR .. "Ouvre la fenêtre " .. MONKEYQUEST_TITLE .. ".\n"
    MONKEYQUEST_HELP_CLOSE_MSG          = MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest close\n" ..
                                          MONKEYQUEST_CHAT_COLOUR .. "Ferme la fenêtre " .. MONKEYQUEST_TITLE .. ".\n"
    MONKEYQUEST_HELP_SHOWHIDDEN_MSG     = MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest showhidden\n" ..
                                          MONKEYQUEST_CHAT_COLOUR .. "Montrer les noms de zone et les quêtes cachées.\n"
    MONKEYQUEST_HELP_HIDEHIDDEN_MSG     = MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest hidehidden\n" ..
                                          MONKEYQUEST_CHAT_COLOUR .. "Cacher les noms de zone et les quêtes cachées.\n"
    MONKEYQUEST_HELP_USEOVERVIEWS_MSG   = MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest useoverviews\n" ..
                                          MONKEYQUEST_CHAT_COLOUR .. "Montrer la description quand il n'y a pas d'objectifs.\n"
    MONKEYQUEST_HELP_NOOVERVIEWS_MSG    = MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest nooverviews\n" ..
                                          MONKEYQUEST_CHAT_COLOUR .. "Ne pas montrer la description quand il n'y a pas d'objectifs.\n"
    MONKEYQUEST_HELP_TIPANCHOR_MSG      = MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest tipanchor=<anchor position>\n" ..
                                          MONKEYQUEST_CHAT_COLOUR .. "Fixer le point d'ancrage du tooltip où <anchor position> " .. 
                                          "peut être un des suivants :\nANCHOR_TOPLEFT, ANCHOR_TOPRIGHT, ANCHOR_TOP, ANCHOR_LEFT, " ..
                                          "ANCHOR_RIGHT, ANCHOR_BOTTOMLEFT, ANCHOR_BOTTOMRIGHT, ANCHOR_BOTTOM, ANCHOR_CURSOR, " .. 
                                          "DEFAULT, NONE";
    MONKEYQUEST_HELP_ALPHA_MSG          = MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest alpha=<0 - 255>\n" ..
                                          MONKEYQUEST_CHAT_COLOUR .. "Fixer l'Alpha à la valeur spécifiée.\n"
    MONKEYQUEST_HELP_WIDTH_MSG          = MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest width=<positive integer>\n" ..
                                          MONKEYQUEST_CHAT_COLOUR .. "Fixer la largeur à la valeur spécifiée, 255 par défaut. " .. 
                                          "Nécessite de '/console reloadui' pour prendre effet.\n"
    MONKEYQUEST_HELP_HIDEHEADERS_MSG    = MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest hideheaders\n" ..
                                          MONKEYQUEST_CHAT_COLOUR .. "Cacher les noms de zone.\n"
    MONKEYQUEST_HELP_SHOWHEADERS_MSG    = MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest showheaders\n" ..
                                          MONKEYQUEST_CHAT_COLOUR .. "Montrer les noms de zone.\n"
    MONKEYQUEST_HELP_HIDEBORDER_MSG     = MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest hideborder\n" ..
                                          MONKEYQUEST_CHAT_COLOUR .. "Cacher les bords de la fenêtre " .. MONKEYQUEST_TITLE .. ".\n"
    MONKEYQUEST_HELP_SHOWBORDER_MSG     = MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest showborder\n" ..
                                          MONKEYQUEST_CHAT_COLOUR .. "Montrer les bords de la fenêtre " .. MONKEYQUEST_TITLE .. ".\n"
    MONKEYQUEST_HELP_GROWUP_MSG         = MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest growup\n" ..
                                          MONKEYQUEST_CHAT_COLOUR .. "Augmenter la fenêtre " .. MONKEYQUEST_TITLE .. " vers le haut.\n"
    MONKEYQUEST_HELP_GROWDOWN_MSG       = MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest growdown\n" ..
                                          MONKEYQUEST_CHAT_COLOUR .. "Augmenter la fenêtre " .. MONKEYQUEST_TITLE .. " vers le bas.\n"
    MONKEYQUEST_HELP_HIDENUMQUESTS_MSG  = MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest hidenumquests\n" ..
                                          MONKEYQUEST_CHAT_COLOUR .. "Cacher le nombre de quêtes.\n"
    MONKEYQUEST_HELP_SHOWNUMQUESTS_MSG  = MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest shownumquests\n" ..
                                          MONKEYQUEST_CHAT_COLOUR .. "Montrer le nombre de quêtes.\n"
    MONKEYQUEST_HELP_LOCK_MSG           = MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest lock\n" ..
                                          MONKEYQUEST_CHAT_COLOUR .. "Bloquer la fenêtre " .. MONKEYQUEST_TITLE .. ".\n"
    MONKEYQUEST_HELP_UNLOCK_MSG         = MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest unlock\n" ..
                                          MONKEYQUEST_CHAT_COLOUR .. "Débloquer la fenêtre " .. MONKEYQUEST_TITLE .. ", la rend mobile.\n"
    MONKEYQUEST_HELP_COLOURTITLEON_MSG  = MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest colourtitleon\n" ..
                                          MONKEYQUEST_CHAT_COLOUR .. "Colorer les titres de quêtes selon la difficulté.\n"
    MONKEYQUEST_HELP_COLOURTITLEOFF_MSG = MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest colourtitleoff\n" ..
                                          MONKEYQUEST_CHAT_COLOUR .. "Ne pas colorer les titres de quêtes selon la difficulté.\n"
    MONKEYQUEST_HELP_HIDECOMPLETEDQUESTS_MSG    = MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest hidecompletedquests\n" ..
                                          MONKEYQUEST_CHAT_COLOUR .. "Cacher les quêtes terminées.\n"
    MONKEYQUEST_HELP_SHOWCOMPLETEDQUESTS_MSG    = MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest showcompletedquests\n" ..
                                          MONKEYQUEST_CHAT_COLOUR .. "Montrer les quêtes terminées.\n"
    MONKEYQUEST_HELP_HIDECOMPLETEDOBJECTIVES_MSG    = MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest hidecompletedobjectives\n" ..
                                          MONKEYQUEST_CHAT_COLOUR .. "Cacher les objectifs terminés.\n"
    MONKEYQUEST_HELP_SHOWCOMPLETEDOBJECTIVES_MSG    = MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest showcompletedobjectives\n" ..
                                          MONKEYQUEST_CHAT_COLOUR .. "Montrer les objectifs terminés.\n"
                                          
    MONKEYQUEST_HELP_FONTHEIGHT_MSG		= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest fontheight=<entier positif>\n" ..
    									  MONKEYQUEST_CHAT_COLOUR .. "Fixe la taille de la police de caractères, 12 par défaut.\n";
    MONKEYQUEST_HELP_SHOWTOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest showtooltipobjectives\n" ..
    									  MONKEYQUEST_CHAT_COLOUR .. "Ajoute une ligne au tooltip qui montre l'avancement de cet objectif de quête.\n";
    MONKEYQUEST_HELP_HIDETOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest hidetooltipobjectives\n" ..
    									  MONKEYQUEST_CHAT_COLOUR .. "Retire la ligne du tooltip qui montre l'avancement de cet objectif de quête.\n";
    MONKEYQUEST_HELP_ALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest allowrightclick\n" ..
    									  MONKEYQUEST_CHAT_COLOUR .. "Vous permet de faire un clic droit pour ouvrir MonkeyBuddy.\n";
    MONKEYQUEST_HELP_DISALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest disallowrightclick\n" ..
    									  MONKEYQUEST_CHAT_COLOUR .. "Désactive le clic droit pour ouvrir MonkeyBuddy.\n";
    MONKEYQUEST_HELP_HIDETITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest hidetitlebuttons\n" ..
    									  MONKEYQUEST_CHAT_COLOUR .. "Cacher les boutons de titre.\n";
    MONKEYQUEST_HELP_SHOWTITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Utilisation : /mquest showtitlebuttons\n" ..
    									  MONKEYQUEST_CHAT_COLOUR .. "Montrer les boutons de titre.\n";                                          

    -- tooltip strings
    MONKEYQUEST_TOOLTIP_QUESTITEM		= "Objet de quête";		-- as it appears in the tooltip of unique quest items
    MONKEYQUEST_TOOLTIP_SLAIN			= "morts";			        -- as it appears in the objective text                                          

	-- misc quest strings
	MONKEYQUEST_DUNGEON					= "Donjon";
	MONKEYQUEST_PVP						= "JcJ";

    -- bindings
    BINDING_HEADER_MONKEYQUEST          = MONKEYQUEST_TITLE;
    BINDING_NAME_MONKEYQUEST_CLOSE      = MONKEYQUEST_CLOSE_TOOLTIP.."/Open";
    BINDING_NAME_MONKEYQUEST_MINIMIZE   = MONKEYQUEST_MINIMIZE_TOOLTIP.."/Restore";
    BINDING_NAME_MONKEYQUEST_HIDDEN     = "Hide/"..MONKEYQUEST_HIDDEN_TOOLTIP;
    BINDING_NAME_MONKEYQUEST_NOHEADERS  = "Afficher/Masquer Headers";

elseif (GetLocale() == "deDE") then
-- Translation by Maischter (http://www.curse-gaming.com/mod.php?addid=429) & wowpendium.de
--
-- Umlaute sind wie folgt kodiert:
--
-- � - \195\188
-- � - \195\156
-- � - \195\182
-- � - \195\150
-- � - \195\164
-- � - \195\134
-- � - \195\159

--MONKEYQUEST_TITLE = "MonkeyQuest";
--MONKEYQUEST_VERSION = "1.4";
MONKEYQUEST_DESCRIPTION = "Stellt Quests in einer kompakten \195\156bersicht dar.";
MONKEYQUEST_INFO_COLOUR = "|cffffff00";
MONKEYQUEST_LOADED_MSG = MONKEYQUEST_INFO_COLOUR .. MONKEYQUEST_TITLE .. " v" .. MONKEYQUEST_VERSION .. " geladen";

MONKEYQUEST_CLOSE_TOOLTIP = "Schlie\195\159en";
MONKEYQUEST_MINIMIZE_TOOLTIP = "Minimieren";
MONKEYQUEST_HIDDEN_TOOLTIP = "Zeige versteckte Elemente";

MONKEYQUEST_QUEST_DONE = "fertig";
MONKEYQUEST_CONFIRM_RESET = "Einstellungen von " .. MONKEYQUEST_TITLE .. " wirklich zur\195\188cksetzen?";

MONKEYQUEST_CHAT_COLOUR = "|cff00ff00";
MONKEYQUEST_SET_WIDTH_MSG = MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": Um \195\134nderungen an der Breite wirksam werden zu lassen, m\195\188ssen Sie '/console reloadui' ausf\195\188hren."
MONKEYQUEST_ALLOW_CLICKS_ON_MSG = MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": \195\150ffnen des Blizzard Quest Logs durch einen Klick auf eine Quest."
MONKEYQUEST_ALLOW_CLICKS_OFF_MSG = MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": Kein \195\150ffnen des Blizzard Quest Logs durch einen Klick auf eine Quest."
MONKEYQUEST_RESET_MSG = MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": Einstellungen zur\195\188cksetzen."

MONKEYQUEST_HELP_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest help <Kommando>\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Anzeigen der Hilfe, wobei <Kommando> eines der folgenden sein kann: \n" ..
"reset, open, close, showhidden, hidehidden, useoverviews, nooverviews, " ..
"tipanchor, alpha, width, hideheaders, showheaders, hideborder, showborder, " ..
"growup, growdown, hidenumquests, shownumquests, lock, unlock, colourtitleon, " ..
"colourtitleoff, hidecompletedquests, showcompletedquests, hidecompletedobjectives, " ..
"showcompletedobjectives, fontheight, showtooltipobjectives, hidetootipobjectives, " ..
"allowrightclick, disallowrightclick, hidetitlebuttons, showtitlebuttons.";
MONKEYQUEST_HELP_RESET_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest reset\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Zur\195\188cksetzen der Einstellungen auf die Werkseinstellung\n"
MONKEYQUEST_HELP_OPEN_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest open\n" ..
MONKEYQUEST_CHAT_COLOUR .. "\195\150ffnen des " .. MONKEYQUEST_TITLE .. " Fensters\n"
MONKEYQUEST_HELP_CLOSE_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest close\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Schlie\195\159en des " .. MONKEYQUEST_TITLE .. " Fensters\n"
MONKEYQUEST_HELP_SHOWHIDDEN_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest showhidden\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Anzeigen aller, auch ausgeblendeter Quests\n"
MONKEYQUEST_HELP_HIDEHIDDEN_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest hidehidden\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Ausblenden entsprechend markierter Quests\n"
MONKEYQUEST_HELP_USEOVERVIEWS_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest useoverviews\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Anzeigen der Questzusammenfassung bei Quests, die keine Sammel- oder Killquest sind\n"
MONKEYQUEST_HELP_NOOVERVIEWS_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest nooverviews\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Kein Anzeigen der Questzusammenfassung bei Quests, die keine Sammel- oder Killquest sind\n"
MONKEYQUEST_HELP_TIPANCHOR_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest tipanchor=<Ankerposition>\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Festlegen der Tooltip Position. M\195\182gliche Werte f\195\188r <Ankerposition> sind \n" ..
"ANCHOR_TOPLEFT, ANCHOR_TOPRIGHT, ANCHOR_TOP, ANCHOR_LEFT, " ..
"ANCHOR_RIGHT, ANCHOR_BOTTOMLEFT, ANCHOR_BOTTOMRIGHT, ANCHOR_BOTTOM, ANCHOR_CURSOR, " ..
"DEFAULT, NONE";
MONKEYQUEST_HELP_ALPHA_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest alpha=<0 - 255>\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Festlegen der Transparenz des Fensters, mu\195\159 eine positive Ganzzahl sein. 0 ist komplett transparent, 255 komplett undurchsichtig\n"
MONKEYQUEST_HELP_WIDTH_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest width=<positive integer>\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Festlegen der Fensterbreite, Standardwert ist 225, mu\195\159 eine positive Ganzahl sein. Um die \195\134nderung sichtbar zu machen, mu\195\159 die Oberfl\195\164che \195\188ber das Kommando /console reloadui neu geladen werden\n"
MONKEYQUEST_HELP_SHOWHEADERS_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest showheaders\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Einblenden der Namen der Regionen\n"
MONKEYQUEST_HELP_HIDEHEADERS_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest hideheaders\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Ausblenden der Namen der Regionen\n"
MONKEYQUEST_HELP_HIDEBORDER_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest hideborder\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Kein Zeichnen eines Rahmens um das Fenster\n"
MONKEYQUEST_HELP_SHOWBORDER_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest showborder\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Zeichnen eines Rahmens um das Fenster\n"
MONKEYQUEST_HELP_GROWUP_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest growup\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Festlegung, da\195\159 sich das Fenster nach oben hin erweitert, wenn eine neue Quest angenommen wird\n"
MONKEYQUEST_HELP_GROWDOWN_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest growdown\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Festlegung, da\195\159 sich das Fenster nach unten hin erweitert, wenn eine neue Quest angenommen wird\n"
MONKEYQUEST_HELP_HIDENUMQUESTS_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest hidenumquests\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Keine Anzeige der Anzahl der angenommenen Quests\n"
MONKEYQUEST_HELP_SHOWNUMQUESTS_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest shownumquests\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Anzeige der Anzahl der angenommenen Quests\n"
MONKEYQUEST_HELP_LOCK_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest lock\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Fixierung des Fensters\n"
MONKEYQUEST_HELP_UNLOCK_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest unlock\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Aufhebung der Fixierung des Fensters\n"
MONKEYQUEST_HELP_COLOURTITLEON_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest colourtitleon\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Farbliche Kodierung der Quests nach ihrem Schwierigkeitsgrad\n"
MONKEYQUEST_HELP_COLOURTITLEOFF_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest colourtitleoff\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Keine farbliche Kodierung der Quests nach ihrem Schwierigkeitsgrad\n"
MONKEYQUEST_HELP_HIDECOMPLETEDQUESTS_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest hidecompletedquests\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Versteckt alle Quests.\n";
MONKEYQUEST_HELP_SHOWCOMPLETEDQUESTS_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest showcompletedquests\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Zeigt alle Quests.\n";
MONKEYQUEST_HELP_HIDECOMPLETEDOBJECTIVES_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest hidecompletedobjectives\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Versteckt alle Questziele.\n";
MONKEYQUEST_HELP_SHOWCOMPLETEDOBJECTIVES_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest showcompletedobjectives\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Zeigt alle Questsziele.\n";
MONKEYQUEST_HELP_FONTHEIGHT_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest fontheight=<positive integer>\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Stellt die Schriftgr\195\182sse ein, Standart ist 12.\n";
MONKEYQUEST_HELP_SHOWTOOLTIPOBJECTIVES_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest showtooltipobjectives\n" ..
MONKEYQUEST_CHAT_COLOUR .. "F\195\188gt den Tooltips eine Linie hinzu, welche die Vollstandigkeit der jeweiligen Questziele anzeigt.\n";
MONKEYQUEST_HELP_HIDETOOLTIPOBJECTIVES_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest hidetooltipobjectives\n" ..
MONKEYQUEST_CHAT_COLOUR .. "F\195\188gt den Tooltips keine Linie hinzu, welche die Vollstandigkeit der jeweiligen Questziele anzeigen w\195\188rde.\n";
MONKEYQUEST_HELP_ALLOWRIGHTCLICK_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest allowrightclick\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Erlaubt Rechtsklick um \195\182ffnen von MonkeyBuddy.\n";
MONKEYQUEST_HELP_DISALLOWRIGHTCLICK_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest disallowrightclick\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Erlaubt nicht Rechtsklick zum \195\182ffnen von MonkeyBuddy.\n";
MONKEYQUEST_HELP_HIDETITLEBUTTONS_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest hidetitlebuttons\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Versteckt die Titeltasten.\n";
MONKEYQUEST_HELP_SHOWTITLEBUTTONS_MSG = MONKEYQUEST_INFO_COLOUR .. "Verwendung: /mquest showtitlebuttons\n" ..
MONKEYQUEST_CHAT_COLOUR .. "Zeigt die Titeltasten.\n";

-- tooltip strings
MONKEYQUEST_TOOLTIP_QUESTITEM = "Questgegenstand";
MONKEYQUEST_TOOLTIP_SLAIN = "get\195\182tet";

-- bindings
BINDING_HEADER_MONKEYQUEST = MONKEYQUEST_TITLE;
BINDING_NAME_MONKEYQUEST_CLOSE = MONKEYQUEST_CLOSE_TOOLTIP.."/Open";
BINDING_NAME_MONKEYQUEST_MINIMIZE = MONKEYQUEST_MINIMIZE_TOOLTIP.."/Restore";
BINDING_NAME_MONKEYQUEST_HIDDEN = "Hide/"..MONKEYQUEST_HIDDEN_TOOLTIP;
BINDING_NAME_MONKEYQUEST_NOHEADERS = "Toggle No Headers";

elseif (GetLocale() == "esES") then
	MONKEYQUEST_QUEST_DONE				= "hecho";
	MONKEYQUEST_CONFIRM_RESET			= "Vale para reset " .. MONKEYQUEST_TITLE .. " settings to default values?";
	
	MONKEYQUEST_CHAT_COLOUR				= "|cff00ff00";
	MONKEYQUEST_SET_WIDTH_MSG			= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": Tu puedes necesitar de '/console reloadui' para ver los cambios.";
	MONKEYQUEST_RESET_MSG				= MONKEYQUEST_CHAT_COLOUR .. MONKEYQUEST_TITLE .. ": Opciones reseteadas.";
	
	MONKEYQUEST_HELP_MSG				= MONKEYQUEST_INFO_COLOUR .. "Comando: /mquest help <command>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Cuando <command> is any of the following: \n" ..
										  "reset, open, close, showhidden, hidehidden, useoverviews, nooverviews, " ..
										  "tipanchor, alpha, width, hideheaders, showheaders, hideborder, showborder, " ..
										  "growup, growdown, hidenumquests, shownumquests, lock, unlock, colourtitleon, " ..
										  "colourtitleoff, hidecompletedquests, showcompletedquests, hidecompletedobjectives, " ..
										  "showcompletedobjectives, fontheight, showtooltipobjectives, hidetootipobjectives, " ..
										  "allowrightclick, disallowrightclick, hidetitlebuttons, showtitlebuttons.";
	MONKEYQUEST_HELP_RESET_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest reset\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Displays the reset config variables dialog.\n";
	MONKEYQUEST_HELP_OPEN_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest open\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Shows the main " .. MONKEYQUEST_TITLE .. " frame.\n";
	MONKEYQUEST_HELP_CLOSE_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest close\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Hides the main " .. MONKEYQUEST_TITLE .. " frame.\n";
	MONKEYQUEST_HELP_SHOWHIDDEN_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showhidden\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Shows collapsed zone headers and hidden quests.\n";
	MONKEYQUEST_HELP_HIDEHIDDEN_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidehidden\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Hides collapsed zone headers and hidden quests.\n";
	MONKEYQUEST_HELP_USEOVERVIEWS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest useoverviews\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Displays the quest overview for quests without objectives.\n";
	MONKEYQUEST_HELP_NOOVERVIEWS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest nooverviews\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Don't display the quest overview for quests without objectives.\n";
	MONKEYQUEST_HELP_TIPANCHOR_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest tipanchor=<anchor position>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Sets the anchor point of the tooltip where <anchor position> " .. 
										  "can be any of the following:\nANCHOR_TOPLEFT, ANCHOR_TOPRIGHT, ANCHOR_TOP, ANCHOR_LEFT, " ..
										  "ANCHOR_RIGHT, ANCHOR_BOTTOMLEFT, ANCHOR_BOTTOMRIGHT, ANCHOR_BOTTOM, ANCHOR_CURSOR, " .. 
										  "DEFAULT, NONE";
	MONKEYQUEST_HELP_ALPHA_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest alpha=<0 - 255>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Sets the backdrop alpha to the specified value.\n";
	MONKEYQUEST_HELP_WIDTH_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest width=<positive integer>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Sets the width to the specified value, the default is 255.\n";
	MONKEYQUEST_HELP_HIDEHEADERS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hideheaders\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Never display any zone headers.\n";
	MONKEYQUEST_HELP_SHOWHEADERS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showheaders\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Display zone headers.\n";
	MONKEYQUEST_HELP_HIDEBORDER_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hideborder\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Hide the border around the main " .. MONKEYQUEST_TITLE .. " frame.\n";
	MONKEYQUEST_HELP_SHOWBORDER_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showborder\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Show the border around the main " .. MONKEYQUEST_TITLE .. " frame.\n";
	MONKEYQUEST_HELP_GROWUP_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest growup\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Makes the main " .. MONKEYQUEST_TITLE .. " frame expand upwards.\n";
	MONKEYQUEST_HELP_GROWDOWN_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest growdown\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Makes the main " .. MONKEYQUEST_TITLE .. " frame expand downwards.\n";
	MONKEYQUEST_HELP_HIDENUMQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidenumquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Hide the number of quests next to the title.\n";
	MONKEYQUEST_HELP_SHOWNUMQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest shownumquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Show the number of quests next to the title.\n";
	MONKEYQUEST_HELP_LOCK_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest lock\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Locks the " .. MONKEYQUEST_TITLE .. " frame in place.\n";
	MONKEYQUEST_HELP_UNLOCK_MSG			= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest unlock\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Unlocks the " .. MONKEYQUEST_TITLE .. " frame, making it movable.\n";
	MONKEYQUEST_HELP_COLOURTITLEON_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest colourtitleon\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Uses the difficulty to colour the entier quest title.\n";
	MONKEYQUEST_HELP_COLOURTITLEOFF_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest colourtitleoff\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Doesn't colour the entier quest title by difficulty.\n";
	MONKEYQUEST_HELP_HIDECOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidecompletedquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Hides completed quests.\n";
	MONKEYQUEST_HELP_SHOWCOMPLETEDQUESTS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showcompletedquests\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Shows completed quests.\n";
	MONKEYQUEST_HELP_HIDECOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidecompletedobjectives\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Hides completed objectives.\n";
	MONKEYQUEST_HELP_SHOWCOMPLETEDOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showcompletedobjectives\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Shows completed objectives.\n";
	MONKEYQUEST_HELP_FONTHEIGHT_MSG		= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest fontheight=<positive integer>\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Sets the font height to the specified value, the default is 12.\n";
	MONKEYQUEST_HELP_SHOWTOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showtooltipobjectives\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Adds a line to the tooltip which shows the completeness of that quest objective.\n";
	MONKEYQUEST_HELP_HIDETOOLTIPOBJECTIVES_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidetooltipobjectives\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Does not add a line to the tooltip about the completeness of that quest objective.\n";
	MONKEYQUEST_HELP_ALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest allowrightclick\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Allows you to right-click to open MonkeyBuddy.\n";
	MONKEYQUEST_HELP_DISALLOWRIGHTCLICK_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest disallowrightclick\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Disallows you from right-clicking to open MonkeyBuddy.\n";
	MONKEYQUEST_HELP_HIDETITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest hidetitlebuttons\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Hides the title buttons.\n";
	MONKEYQUEST_HELP_SHOWTITLEBUTTONS_MSG	= MONKEYQUEST_INFO_COLOUR .. "Slash Command: /mquest showtitlebuttons\n" ..
										  MONKEYQUEST_CHAT_COLOUR .. "Shows the title buttons.\n";
	
										  
	-- tooltip strings
	MONKEYQUEST_TOOLTIP_QUESTITEM		= "Objeto de Quest";		-- as it appears in the tooltip of unique quest items
	MONKEYQUEST_TOOLTIP_QUEST			= "Quest";
	MONKEYQUEST_TOOLTIP_SLAIN			= "slain";			-- as it appears in the objective text
	
	-- misc quest strings
	MONKEYQUEST_DUNGEON					= "Mazmorra";
	MONKEYQUEST_PVP						= "PvP";
	
	-- noob tips
	MONKEYQUEST_NOOBTIP_HEADER			= "Noob Tip:";
	
	MONKEYQUEST_NOOBTIP_CLOSE			= "Pulsa aqui para cerrar esta ventana. Podras volver:";
	MONKEYQUEST_NOOBTIP_MINIMIZE		= "Pulsa aqui para miminizar esta ventana";
	MONKEYQUEST_NOOBTIP_RESTORE			= "Pulsa aqui para restaurar esta ventana";
	MONKEYQUEST_NOOBTIP_SHOWALLHIDDEN	= "Pulsa aqui para ver todos los objetos ocultos";
	MONKEYQUEST_NOOBTIP_HIDEALLHIDDEN	= "Pulsa aqui para ocultar todos los objetos escondidos";
	MONKEYQUEST_NOOBTIP_HIDEBUTTON		= "Pulsa aqui para ocultar esta quest. Activalo en 'Show all hidden items' para mirar todas las quest";
	MONKEYQUEST_NOOBTIP_TITLE			= "Click derecho para abrir MonkeyBuddy y poder configurarlo " .. MONKEYQUEST_TITLE;
	MONKEYQUEST_NOOBTIP_QUESTHEADER		= "Pulsa aqui para ocultar/mostrar todas las quest en esta zona. Activa 'Show all hidden items' para mostrar las de las zonas en que no estas.";
	
	-- bindings
	BINDING_HEADER_MONKEYQUEST 			= MONKEYQUEST_TITLE;
	BINDING_NAME_MONKEYQUEST_CLOSE 		= "Cerrar/Abrir";
	BINDING_NAME_MONKEYQUEST_MINIMIZE 	= "Minimizar/Restaurar";
	BINDING_NAME_MONKEYQUEST_HIDDEN		= "Ocultar/Mostrar todos los objetos ocultos";
	BINDING_NAME_MONKEYQUEST_NOHEADERS	= "Toggle No Headers";
end