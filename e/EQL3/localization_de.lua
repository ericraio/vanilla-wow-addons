-- German localization for Extended Questlog 3.5
-- Thanks to Zwixx
-- Extended QuestLog is Copyright © 2006 Daniel Rehn

--[[--------------------------------------------------------------------------------
	Special Keys in German:
	-- Ä =  \195\132
	-- Ö =  \195\150
	-- Ü =  \195\156
	-- ä =  \195\164
	-- ö =  \195\182
	-- ü =  \195\188
	-- ß =  \195\159
-----------------------------------------------------------------------------------]]

if ( GetLocale() == "deDE" ) then

EQL3_QUEST_LOG = "Erweitertes QuestLog";

EQL3_OPTIONS = "Optionen";
EQL3_OPTIONS_INFO = "\195\150ffnet die Optionen für das erweiterte QuestLog.";
EQL3_OPTIONS_TITLE = EQL3_QUEST_LOG.." "..EQL3_OPTIONS

EQL3_QUEST_WATCH_TOOLTIP = "Shift-Klick ein Quest um es dem Tracker hinzuzufügen oder zu entfernen.\n\nCtrl-Klick um deinen aktuellen Status im Chat einzuf\195\188gen.\n\nCtrl-Shift-Klick um den Tracker zu leeren und diesen Quest einzuf\195\188gen.";

EQL3_SHRINK = "Normal";
EQL3_EXTEND = "Erweitert";
EQL3_RESTORE = "Wiederherstellen";

EQL3_MINIMIZE_TIP = "QuestLog wiederherstellen";
EQL3_MAXIMIZE_TIP = "QuestLog maximieren";

EQL3_LOG_OPTIONS = "Log Optionen";
EQL3_SHOW_QUEST_LEVELS = "Zeige Questlevels";
EQL3_RESTORE_UPON_SELECT = "Maximieren beim selektieren";
EQL3_MINIMIZE_UPON_CLOSE = "Minimieren beim schlie/195/159en";
EQL3_LOCK_QUESTLOG = "Sperre QuestLog";
EQL3_OPACITY = "Log Transparenz";

EQL3_COLOR_OPTIONS = "Farboptionen";
EQL3_ZONE_COLOR = "Benutzerdefinierte Zonenfarbe";
EQL3_HEADER_COLOR = "Benutzerdefinierte Kopffarbe";
EQL3_OBJECTIVE_COLOR = "Benutzerdefinierte Questzielfarbe";
EQL3_FADE_HEADER = "Verblassende Quests";
EQL3_FADE_OBJECTIVE = "Verblassende Questziele";
EQL3_TRACKER_BG = "Tracker Hintergrundfarbe";
EQL3_RESTORE_COLORS = "Farben zur\195\188cksetzen";

EQL3_QUEST_TRACKER = "Erweiterter Quest Tracker";

EQL3_TRACKER_OPTIONS = "Tracker Optionen";
EQL3_USE_TRACKER_LISTING = "Benutze Trackerliste";
EQL3_SHOW_ZONES = "Zeige Zonen im Tracker";
EQL3_SORT_TRACKER = "Sortiere Quests im Tracker";
EQL3_LOCK_TRACKER = "Tracker sperren";
EQL3_ADD_NEW = "Neue Quests im Tracker anzeigen";
EQL3_ADD_UNTRACKED = "F\195\188ge Quests die in Arbeit sind dem Tracker hinzu.";
EQL3_REMOVE_FINISHED = "Entferne beendete Quests aus dem Tracker";
EQL3_MINIMIZE_FINISHED = "Verstecke Ziele f\195\188r beendete Quests";
EQL3_SHOW_MINIMIZER = "Minimierenicon in Tracker zeigen";
EQL3_TRACKERFONTSIZE = "Tracker Schriftgr\195\182\195\159e";


--new
--Some masks
EQL_QUEST_ACCEPTED = "Quest angenommen:";
EQL_COMPLETE = "%(abgeschlossen%)";

--Organize Strings
EQL3_ORGANIZE_TITLE = "Quest Organizer"
EQL3_ORGANIZE_TEXT = "Klicke eine Questgruppe oder\ngib eine ein und klicke OK";

EQL3_POPUP_MOVE = "Verschiebe Quest in andere Gruppe";
EQL3_POPUP_RESET = "Verschiebe Quest in Originalgruppe";
EQL3_POPUP_RESETALL = "Alle Quests zur\195\188cksetzen";
EQL3_POPUP_CANCEL = "Abbruch";
EQL3_OKAY = "OK";
EQL3_POPUP_TRACK = "Quest verfolgen";
EQL3_POPUP_UNTRACK = "Questverfolgung deaktivieren";


--Load
EQL3_LOAD_TIP = "Lade Einstellungen";


-- new to 3.5.6
EQL3_HIDE_COMPLETED_OBJECTIVES = "Verstecke fertige Ziele einzeln";
EQL3_AUTO_COMPLETE_QUESTS = "Quests automatisch fertig stellen";
EQL3_SHOW_OBJECTIVE_MARKERS = "Zeige Zielmarkierungen";
EQL3_LEVELS_ONLY_IN_LOG = "Nur in Log und Tracker";


-- 3.6.0
EQL3_TOOLTIP_OPTIONS = "Tooltip Optionen";
EQL3_SHOW_ITEM_TOOLTIP = "Zeige Quest im Gegenstands-Tooltip";
EQL3_SHOW_MOB_TOOLTIP = "Zeige Quest im Mob-Tooltip";
EQL3_INFO_ON_QUEST_COMPLETE = "Informiere bei beendetem Quest";
EQL3_TOOLTIP_COLOR = "Benutzerdefinierte Tooltip-Farbe";


end
