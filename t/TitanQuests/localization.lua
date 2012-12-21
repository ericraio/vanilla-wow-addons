TITAN_QUESTS_VERSION = "0.17";

TITAN_QUESTS_MENU_TEXT = "Quests";
TITAN_QUESTS_BUTTON_LABEL = "Quests: ";
TITAN_QUESTS_BUTTON_TEXT = "%s"..TitanUtils_GetHighlightText("/").."%s";
TITAN_QUESTS_TOOLTIP = "Quests Info";

TITAN_QUESTS_OPTIONS_TEXT = "Options";

TITAN_QUESTS_LEVEL_TEXT = "Level ";

TITAN_QUESTS_ABOUT_VERSION_TEXT = "Version";
TITAN_QUESTS_ABOUT_AUTHOR_TEXT = "Author";
TITAN_QUESTS_ABOUT_POPUP_TEXT = TitanUtils_GetGreenText("Titan Panel [Quests]").."\n"..TitanUtils_GetNormalText(TITAN_QUESTS_ABOUT_VERSION_TEXT..": ")..TitanUtils_GetHighlightText(TITAN_QUESTS_VERSION).."\n"..TitanUtils_GetNormalText(TITAN_QUESTS_ABOUT_AUTHOR_TEXT..": ")..TitanUtils_GetHighlightText("Corgi/Ryessa");

TITAN_QUESTS_SORT_TEXT = "Sort";
TITAN_QUESTS_SORT_LOCATION_TEXT = "by Location (Default)";
TITAN_QUESTS_SORT_LEVEL_TEXT = "by Level";
TITAN_QUESTS_SORT_TITLE_TEXT = "by Title";

TITAN_QUESTS_SHOW_TEXT = "Show";
TITAN_QUESTS_SHOW_ELITE_TEXT = "only Elite";
TITAN_QUESTS_SHOW_DUNGEON_TEXT = "only Dungeon";
TITAN_QUESTS_SHOW_RAID_TEXT = "only Raid";
TITAN_QUESTS_SHOW_PVP_TEXT = "only PvP";
TITAN_QUESTS_SHOW_REGULAR_TEXT = "only Regular";
TITAN_QUESTS_SHOW_COMPLETED_TEXT = "only Completed";
TITAN_QUESTS_SHOW_INCOMPLETE_TEXT = "only Incomplete";
TITAN_QUESTS_SHOW_ALL_TEXT = "All (Default)";

TITAN_QUESTS_TOGGLE_TEXT = "Toggle";

TITAN_QUESTS_CLICK_BEHAVIOR_TEXT = "Left Click to Watch Quest";
TITAN_QUESTS_GROUP_BEHAVIOR_TEXT = "Group Sorted Quests";

TITAN_QUESTS_QUESTLOG_TRUNCATED_TEXT = "Quest Display Truncated...";
TITAN_QUESTS_OPEN_QUESTLOG_TEXT = "Open QuestLog";
TITAN_QUESTS_CLOSE_QUESTLOG_TEXT = "Close QuestLog";

TITAN_QUESTS_OPEN_MONKEYQUEST_TEXT = "Open MonkeyQuest";
TITAN_QUESTS_CLOSE_MONKEYQUEST_TEXT = "Close MonkeyQuest";

TITAN_QUESTS_OPEN_QUESTION_TEXT = "Open QuestIon";
TITAN_QUESTS_CLOSE_QUESTION_TEXT = "Close QuestIon";

TITAN_QUESTS_OPEN_PARTYQUESTS_TEXT = "Open PartyQuests";
TITAN_QUESTS_CLOSE_PARTYQUESTS_TEXT = "Close PartyQuests";

TITAN_QUESTS_OPEN_QUESTHISTORY_TEXT = "Open QuestHistory";
TITAN_QUESTS_CLOSE_QUESTHISTORY_TEXT = "Close QuestHistory";

TITAN_QUESTS_OPEN_QUESTBANK_TEXT = "Open QuestBank";
TITAN_QUESTS_CLOSE_QUESTBANK_TEXT = "Close QuestBank";

TITAN_QUESTS_ABOUT_TEXT = "About";

TITAN_QUESTS_OBJECTIVESTXT_LONG_TEXT = TitanUtils_GetRedText("Objectives text too long,\nClick quest for details.");

TITAN_QUESTS_REMOVE_FROM_WATCHER_TEXT = "Remove from Watcher";
TITAN_QUESTS_ADD_TO_WATCHER_TEXT = "Add to Watcher";

TITAN_QUESTS_ABANDON_QUEST_TEXT = "Abandon Quest";

TITAN_QUESTS_QUEST_DETAILS_TEXT = "Quest Details";
TITAN_QUESTS_QUEST_DETAILS_OPTIONS_TEXT = "Quest Options";

TITAN_QUESTS_LINK_QUEST_TEXT = "Link Quest";

TITAN_QUESTS_DETAILS_SHARE_BUTTON_TEXT = "Share";
TITAN_QUESTS_DETAILS_WATCH_BUTTON_TEXT = "Watch";

TITAN_QUESTS_NEWBIE_TOOLTIP_WATCHQUEST = "Add/Remove quest from Quest Tracker.";

TITAN_QUESTS_TOOLTIP_QUESTS_TEXT = "Total Quests: ";
TITAN_QUESTS_TOOLTIP_ELITE_TEXT = "Elite Quests: ";
TITAN_QUESTS_TOOLTIP_DUNGEON_TEXT = "Dungeon Quests: ";
TITAN_QUESTS_TOOLTIP_RAID_TEXT = "Raid Quests: ";
TITAN_QUESTS_TOOLTIP_PVP_TEXT = "PvP Quests: ";
TITAN_QUESTS_TOOLTIP_REGULAR_TEXT = "Regular Quests: ";
TITAN_QUESTS_TOOLTIP_COMPLETED_TEXT = "Completed Quests: ";
TITAN_QUESTS_TOOLTIP_INCOMPLETE_TEXT = "Incomplete Quests: ";
TITAN_QUESTS_TOOLTIP_HINT_TEXT = "Hint: Right-click for quest list.";

-- quest labels 
TITAN_QUESTS_DUNGEON = "Dungeon";
TITAN_QUESTS_RAID = "Raid";
TITAN_QUESTS_PVP = "PvP";

-- German localization
-- by Scarabeus
-- and Kaesemuffin
if ( GetLocale() == "deDE" ) then
	TITAN_QUESTS_MENU_TEXT = "Quest Men\195\188";
	TITAN_QUESTS_BUTTON_LABEL = "Quests: ";
	TITAN_QUESTS_TOOLTIP = "Quest Infos";

	TITAN_QUESTS_OPTIONS_TEXT = "Options";

	TITAN_QUESTS_LEVEL_TEXT = "Level ";

	TITAN_QUESTS_ABOUT_VERSION_TEXT = "Version";
	TITAN_QUESTS_ABOUT_AUTHOR_TEXT = "Author";

	TITAN_QUESTS_SORT_TEXT = "Sortieren";
	TITAN_QUESTS_SORT_LOCATION_TEXT = "nach Zonen (Standart)";
    TITAN_QUESTS_SORT_LEVEL_TEXT = "nach Level";
    TITAN_QUESTS_SORT_TITLE_TEXT = "nach Bezeichnung";

	TITAN_QUESTS_SHOW_TEXT = "Anzeige";
    TITAN_QUESTS_SHOW_ELITE_TEXT = "nur Elite-Quests";
    TITAN_QUESTS_SHOW_DUNGEON_TEXT = "nur Dungeon-Quests";
    TITAN_QUESTS_SHOW_RAID_TEXT = "nur Schlachtzugs-Quests";
    TITAN_QUESTS_SHOW_PVP_TEXT = "nur PvP-Quests";
    TITAN_QUESTS_SHOW_REGULAR_TEXT = "nur regul\195\164re Quests";
    TITAN_QUESTS_SHOW_COMPLETED_TEXT = "nur vervollst\195\164ndigte Quests";
    TITAN_QUESTS_SHOW_INCOMPLETE_TEXT = "nur nicht vervollst\195\164ndigte Quests";
    TITAN_QUESTS_SHOW_ALL_TEXT = "Alle (Standart)";

	TITAN_QUESTS_TOGGLE_TEXT =  "Ein/Ausschalten";

	TITAN_QUESTS_CLICK_BEHAVIOR_TEXT = "Left-Click to Watch Quest";
	TITAN_QUESTS_GROUP_BEHAVIOR_TEXT = "Group Sorted Quests";

	TITAN_QUESTS_QUESTLOG_TRUNCATED_TEXT = "Quest Display Truncated...";
	TITAN_QUESTS_OPEN_QUESTLOG_TEXT = "\195\150ffne QuestLog";
    TITAN_QUESTS_CLOSE_QUESTLOG_TEXT = "Schlie\195\159e QuestLog";

    TITAN_QUESTS_OPEN_MONKEYQUEST_TEXT = "\195\150ffne MonkeyQuest";
    TITAN_QUESTS_CLOSE_MONKEYQUEST_TEXT = "Schlie\195\159e MonkeyQuest";

    TITAN_QUESTS_OPEN_QUESTION_TEXT = "\195\150ffne QuestIon";
    TITAN_QUESTS_CLOSE_QUESTION_TEXT = "Schlie\195\159e QuestIon";

    TITAN_QUESTS_OPEN_PARTYQUESTS_TEXT = "\195\150ffne PartyQuests";
    TITAN_QUESTS_CLOSE_PARTYQUESTS_TEXT = "Schlie\195\159e PartyQuests";

    TITAN_QUESTS_OPEN_QUESTHISTORY_TEXT = "\195\150ffne Questverlauf";
    TITAN_QUESTS_CLOSE_QUESTHISTORY_TEXT = "Schlie\195\159e Questverlauf";

    TITAN_QUESTS_OPEN_QUESTBANK_TEXT = "\195\150ffne QuestBank";
    TITAN_QUESTS_CLOSE_QUESTBANK_TEXT = "Schlie\195\159e QuestBank";

    TITAN_QUESTS_ABOUT_TEXT = "\195\156ber";

    TITAN_QUESTS_OBJECTIVESTXT_LONG_TEXT = TitanUtils_GetRedText("Questbeschreibung zu lang,\nklicken f\195\188r Details.");

    TITAN_QUESTS_REMOVE_FROM_WATCHER_TEXT = "Vom 'Beobachter' entfernen";
    TITAN_QUESTS_ADD_TO_WATCHER_TEXT = "Zum 'Beobachter' hinzuf\195\188gen";

    TITAN_QUESTS_QUEST_DETAILS_TEXT = "Quest Details";
	TITAN_QUESTS_QUEST_DETAILS_OPTIONS_TEXT = "Quest Options";

    TITAN_QUESTS_LINK_QUEST_TEXT = "Verlinke Quest";

    TITAN_QUESTS_DETAILS_SHARE_BUTTON_TEXT = "Teilen";
    TITAN_QUESTS_DETAILS_WATCH_BUTTON_TEXT = "Beobachten";

    TITAN_QUESTS_NEWBIE_TOOLTIP_WATCHQUEST = "F\195\188ge hinzu / entferne die Quest vom Quest Tracker.";

    TITAN_QUESTS_TOOLTIP_QUESTS_TEXT = "Insgesamt # Quests: ";
    TITAN_QUESTS_TOOLTIP_ELITE_TEXT = "Davon # Elite-Quests: ";
	TITAN_QUESTS_TOOLTIP_DUNGEON_TEXT = "# Dungeon-Quests: ";
    TITAN_QUESTS_TOOLTIP_RAID_TEXT = "# Schlachtzugs-Quests: ";
    TITAN_QUESTS_TOOLTIP_PVP_TEXT = "# PvP-Quests: ";
    TITAN_QUESTS_TOOLTIP_REGULAR_TEXT = "# regul\195\164re Quests: ";
    TITAN_QUESTS_TOOLTIP_COMPLETED_TEXT = "# vervollst\195\164ndigte Quests: ";
    TITAN_QUESTS_TOOLTIP_INCOMPLETE_TEXT = "# nicht vervollst\195\164ndigte Quests: ";
    TITAN_QUESTS_TOOLTIP_HINT_TEXT = "Hinweis: Rechts-klick f\195\188r Quest-Liste.";

    -- quest labels
    TITAN_QUESTS_DUNGEON = "Dungeon";
    TITAN_QUESTS_RAID = "Schlachtzug";
    TITAN_QUESTS_PVP = "PvP";
end


-- French localization
-- by Vorpale
if ( GetLocale() == "frFR" ) then
	TITAN_QUESTS_MENU_TEXT = "Qu\195\170tes";
	TITAN_QUESTS_BUTTON_LABEL = "Qu\195\170tes: ";
	TITAN_QUESTS_TOOLTIP = "Infos Qu\195\170tes";

	TITAN_QUESTS_OPTIONS_TEXT = "Options";

	TITAN_QUESTS_LEVEL_TEXT = "Level ";

	TITAN_QUESTS_ABOUT_VERSION_TEXT = "Version";
	TITAN_QUESTS_ABOUT_AUTHOR_TEXT = "Auteur";
	
	TITAN_QUESTS_SORT_TEXT = "Trier";
	TITAN_QUESTS_SORT_LOCATION_TEXT = "par Localisation (D\195\168faut)";
	TITAN_QUESTS_SORT_LEVEL_TEXT = "par Niveau";
	TITAN_QUESTS_SORT_TITLE_TEXT = "Par Titre";

	TITAN_QUESTS_SHOW_TEXT = "Afficher";
	TITAN_QUESTS_SHOW_ELITE_TEXT = "seulement Elites";
	TITAN_QUESTS_SHOW_DUNGEON_TEXT = "seulement Donjons";
	TITAN_QUESTS_SHOW_RAID_TEXT = "seulement Raids";
	TITAN_QUESTS_SHOW_PVP_TEXT = "seulement JcJ";
	TITAN_QUESTS_SHOW_REGULAR_TEXT = "seulement Normales";
	TITAN_QUESTS_SHOW_COMPLETED_TEXT = "seulement Compl\195\168t\195\168es";
	TITAN_QUESTS_SHOW_INCOMPLETE_TEXT = "seulement Non Compl\195\168t\195\168es";
	TITAN_QUESTS_SHOW_ALL_TEXT = "Tout (D\195\168faut)";

	TITAN_QUESTS_TOGGLE_TEXT = "Activer";

	TITAN_QUESTS_CLICK_BEHAVIOR_TEXT = "Left-Click to Watch Quest";
	TITAN_QUESTS_GROUP_BEHAVIOR_TEXT = "Group Sorted Quests";

	TITAN_QUESTS_QUESTLOG_TRUNCATED_TEXT = "Qu\195\170t Display Truncated...";
	TITAN_QUESTS_OPEN_QUESTLOG_TEXT = "Ouvrir le journal de qu\195\170tes";
	TITAN_QUESTS_CLOSE_QUESTLOG_TEXT = "Fermer le journal de qu\195\170tes";

	TITAN_QUESTS_OPEN_MONKEYQUEST_TEXT = "Ouvrir MonkeyQuest";
	TITAN_QUESTS_CLOSE_MONKEYQUEST_TEXT = "Fermer MonkeyQuest";

	TITAN_QUESTS_OPEN_QUESTION_TEXT = "Ouvrir QuestIon";
	TITAN_QUESTS_CLOSE_QUESTION_TEXT = "Fermer QuestIon";

	TITAN_QUESTS_OPEN_PARTYQUESTS_TEXT = "Ouvrir PartyQuests";
	TITAN_QUESTS_CLOSE_PARTYQUESTS_TEXT = "Fermer PartyQuests";

	TITAN_QUESTS_OPEN_QUESTHISTORY_TEXT = "Ouvrir QuestHistory";
	TITAN_QUESTS_CLOSE_QUESTHISTORY_TEXT = "Fermer QuestHistory";

	TITAN_QUESTS_OPEN_QUESTBANK_TEXT = "Ouvrir QuestBank";
	TITAN_QUESTS_CLOSE_QUESTBANK_TEXT = "Fermer QuestBank";

	TITAN_QUESTS_ABOUT_TEXT = "A propos";

	TITAN_QUESTS_OBJECTIVESTXT_LONG_TEXT = TitanUtils_GetRedText("Texte des objectifs trop long,\ncliquez sur la qu\195\170te pour les d\195\168tails.");

	TITAN_QUESTS_REMOVE_FROM_WATCHER_TEXT = "Enlever de la surveillance";
	TITAN_QUESTS_ADD_TO_WATCHER_TEXT = "Ajouter \195\160 la surveillance";

	TITAN_QUESTS_ABANDON_QUEST_TEXT = "Abandonner la qu\195\170te";

	TITAN_QUESTS_QUEST_DETAILS_TEXT = "D\195\168tails de la qu\195\170te";
	TITAN_QUESTS_QUEST_DETAILS_OPTIONS_TEXT = "Quest Options";

	TITAN_QUESTS_LINK_QUEST_TEXT = "Lier la qu\195\170te";

	TITAN_QUESTS_DETAILS_SHARE_BUTTON_TEXT = "Partager";
	TITAN_QUESTS_DETAILS_WATCH_BUTTON_TEXT = "Surveiller";

	TITAN_QUESTS_NEWBIE_TOOLTIP_WATCHQUEST = "Ajouter/supprimer la qu\195\170te du Quest Tracker.";

	TITAN_QUESTS_TOOLTIP_QUESTS_TEXT = "# de qu\195\170tes: ";
	TITAN_QUESTS_TOOLTIP_ELITE_TEXT = "# de qu\195\170tes Elite: ";
	TITAN_QUESTS_TOOLTIP_DUNGEON_TEXT = "# de qu\195\170tes Donjon: ";
	TITAN_QUESTS_TOOLTIP_RAID_TEXT = "# de qu\195\170tes Raid: ";
	TITAN_QUESTS_TOOLTIP_PVP_TEXT = "# de qu\195\170tes JcJ: ";
	TITAN_QUESTS_TOOLTIP_REGULAR_TEXT = "# de qu\195\170tes normales: ";
	TITAN_QUESTS_TOOLTIP_COMPLETED_TEXT = "# de qu\195\170tes actuellement termin\195\168es: ";
	TITAN_QUESTS_TOOLTIP_INCOMPLETE_TEXT = "# de qu\195\170tes non actuellement termin\195\168es: ";
	TITAN_QUESTS_TOOLTIP_HINT_TEXT = "Astuce: Clic-droit pour la liste des qu\195\170tes.";
	
	-- quest labels
	TITAN_QUESTS_DUNGEON = "Donjon";
	TITAN_QUESTS_RAID = "Raid";
	TITAN_QUESTS_PVP = "JcJ";
end

-- Korean localization
if ( GetLocale() == "koKR" ) then
	TITAN_QUESTS_MENU_TEXT = "Quests";
	TITAN_QUESTS_BUTTON_LABEL = "Quests: ";
	TITAN_QUESTS_TOOLTIP = "Quest Info:";

	TITAN_QUESTS_OPTIONS_TEXT = "Options";

	TITAN_QUESTS_LEVEL_TEXT = "Level ";

	TITAN_QUESTS_ABOUT_VERSION_TEXT = "Version";
	TITAN_QUESTS_ABOUT_AUTHOR_TEXT = "Author";
	
	TITAN_QUESTS_SORT_TEXT = "Sort";
	TITAN_QUESTS_SORT_LOCATION_TEXT = "by Location (Default)";
	TITAN_QUESTS_SORT_LEVEL_TEXT = "by Level";
	TITAN_QUESTS_SORT_TITLE_TEXT = "by Title";
	
	TITAN_QUESTS_SHOW_TEXT = "Show";
	TITAN_QUESTS_SHOW_ELITE_TEXT = "only Elite";
	TITAN_QUESTS_SHOW_DUNGEON_TEXT = "only Dungeon";
	TITAN_QUESTS_SHOW_RAID_TEXT = "only Raid";
	TITAN_QUESTS_SHOW_PVP_TEXT = "only PvP";
	TITAN_QUESTS_SHOW_REGULAR_TEXT = "only Regular";
	TITAN_QUESTS_SHOW_COMPLETED_TEXT = "only Completed";
	TITAN_QUESTS_SHOW_COMPLETED_TEXT = "only Incomplete";
	TITAN_QUESTS_SHOW_ALL_TEXT = "All (Default)";

	TITAN_QUESTS_TOGGLE_TEXT = "Toggle";

	TITAN_QUESTS_CLICK_BEHAVIOR_TEXT = "Left-Click to Watch Quest";
	TITAN_QUESTS_GROUP_BEHAVIOR_TEXT = "Group Sorted Quests";

	TITAN_QUESTS_QUESTLOG_TRUNCATED_TEXT = "Quest Display Truncated...";
	TITAN_QUESTS_OPEN_QUESTLOG_TEXT = "Open QuestLog";
	TITAN_QUESTS_CLOSE_QUESTLOG_TEXT = "Close QuestLog";

	TITAN_QUESTS_OPEN_MONKEYQUEST_TEXT = "Open MonkeyQuest";
	TITAN_QUESTS_CLOSE_MONKEYQUEST_TEXT = "Close MonkeyQuest";

	TITAN_QUESTS_OPEN_QUESTION_TEXT = "Open QuestIon";
	TITAN_QUESTS_CLOSE_QUESTION_TEXT = "Close QuestIon";

	TITAN_QUESTS_OPEN_PARTYQUESTS_TEXT = "Open PartyQuests";
	TITAN_QUESTS_CLOSE_PARTYQUESTS_TEXT = "Close PartyQuests";

	TITAN_QUESTS_OPEN_QUESTHISTORY_TEXT = "Open QuestHistory";
	TITAN_QUESTS_CLOSE_QUESTHISTORY_TEXT = "Close QuestHistory";

	TITAN_QUESTS_OPEN_QUESTBANK_TEXT = "Open QuestBank";
	TITAN_QUESTS_CLOSE_QUESTBANK_TEXT = "Close QuestBank";

	TITAN_QUESTS_ABOUT_TEXT = "About";

	TITAN_QUESTS_OBJECTIVESTXT_LONG_TEXT = TitanUtils_GetRedText("Objectives text too long,\nClick quest for details.");

	TITAN_QUESTS_REMOVE_FROM_WATCHER_TEXT = "Remove from Watcher";
	TITAN_QUESTS_ADD_TO_WATCHER_TEXT = "Add to Watcher";

	TITAN_QUESTS_QUEST_DETAILS_TEXT = "Quest Details";
	TITAN_QUESTS_QUEST_DETAILS_OPTIONS_TEXT = "Quest Options";
	

	TITAN_QUESTS_LINK_QUEST_TEXT = "Link Quest";

	TITAN_QUESTS_DETAILS_SHARE_BUTTON_TEXT = "Share";
	TITAN_QUESTS_DETAILS_WATCH_BUTTON_TEXT = "Watch";

	TITAN_QUESTS_NEWBIE_TOOLTIP_WATCHQUEST = "Add/Remove quest from Quest Tracker.";

	TITAN_QUESTS_TOOLTIP_QUESTS_TEXT = "# of quests: ";
	TITAN_QUESTS_TOOLTIP_ELITE_TEXT = "# of Elite quests: ";
	TITAN_QUESTS_TOOLTIP_DUNGEON_TEXT = "# of Dungeon quests: ";
	TITAN_QUESTS_TOOLTIP_RAID_TEXT = "# of Raid quests: ";
	TITAN_QUESTS_TOOLTIP_PVP_TEXT = "# of PvP quests: ";
	TITAN_QUESTS_TOOLTIP_REGULAR_TEXT = "# of Regular quests: ";
	TITAN_QUESTS_TOOLTIP_COMPLETED_TEXT = "# of quests currently completed: ";
	TITAN_QUESTS_TOOLTIP_COMPLETED_TEXT = "# of quests currently incomplete: ";
	TITAN_QUESTS_TOOLTIP_HINT_TEXT = "Hint: Right-click for quest list.";

	-- quest labels
	TITAN_QUESTS_DUNGEON = "Dungeon";
	TITAN_QUESTS_RAID = "Raid";
	TITAN_QUESTS_PVP = "PvP";
end