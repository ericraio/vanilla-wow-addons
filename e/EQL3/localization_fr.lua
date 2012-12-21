-- French localization for Extended Questlog 3.5
-- Thanks to Shaeck, khellendros and Trucifix
-- Extended QuestLog is Copyright © 2006 Daniel Rehn

--[[--------------------------------------------------------------------------------
Special Keys in French:
-- é = \195\169
-- è = \195\168
-- ê = \195\170

Questlog = Journal des quêtes ( Non traduit par manque de place)
Tracker = Le suivi des quêtes ( Non traduit par manque de place)
-----------------------------------------------------------------------------------]]

if ( GetLocale() == "frFR" ) then


EQL3_QUEST_LOG = "Extention du Questlog";

EQL3_OPTIONS = "Options";
EQL3_OPTIONS_INFO = "Ouvrir les options du Questlog";
EQL3_OPTIONS_TITLE = EQL3_QUEST_LOG.." "..EQL3_OPTIONS;

EQL3_QUEST_WATCH_TOOLTIP = "Shift-click sur une qu\195\170te pour ajouter ou enlever du Tracker.\n\nCtrl-click pour ajouter le statut actuel dans la fen\195\170tre de chat.\n\nCtrl-Shift-click pour effacer du Tracker et ajouter la qu\195\170te cliqu\195\169e.";

EQL3_SHRINK = "Normal";
EQL3_EXTEND = "Agrandir";
EQL3_RESTORE = "Restaurer";

EQL3_MINIMIZE_TIP = "Restaurer le QuestLog";
EQL3_MAXIMIZE_TIP = "Agrandir le Questlog";

EQL3_LOG_OPTIONS = "Options du Journal";
EQL3_SHOW_QUEST_LEVELS = "Montrer le niveau des qu\195\170tes";
EQL3_RESTORE_UPON_SELECT = "Agrandir la s\195\169lection";
EQL3_MINIMIZE_UPON_CLOSE = "R\195\169duire si fermer (Taille normal r\195\169ouverture)";
EQL3_LOCK_QUESTLOG = "V\195\169rouiller le QuestLog";
EQL3_OPACITY = "Transparence du Journal";

EQL3_COLOR_OPTIONS = "Options des couleurs";
EQL3_ZONE_COLOR = "Modifier la couleur de la zone";
EQL3_HEADER_COLOR = "Modifier la couleur d'en-t\195\170te";
EQL3_OBJECTIVE_COLOR = "Modifier la couleur des objectifs";
EQL3_FADE_HEADER = "La couleur d'en-t\195\170te fane";
EQL3_FADE_OBJECTIVE = "La couleur des objectifs fane";
EQL3_TRACKER_BG = "Couleur de l'arri\195\168re plan du Tracker";
EQL3_RESTORE_COLORS = "Restaurer les couleurs";

EQL3_QUEST_TRACKER = "Extension du Tracker";

EQL3_TRACKER_OPTIONS = "Options du Tracker";
EQL3_USE_TRACKER_LISTING = "Utiliser la liste du Tracker";
EQL3_SHOW_ZONES = "Montrer les zones dans le Tracker";
EQL3_SORT_TRACKER = "Trier les qu\195\170tes du Tracker";
EQL3_LOCK_TRACKER = "V\195\169rouiller le Tracker";
EQL3_ADD_NEW = "Ajouter les nouvelles qu\195\170tes dans le Tracker"; --Traduction incertaine
EQL3_ADD_UNTRACKED = "Arr\195\170ter de suivre la progression des qu\195\170tes";
EQL3_REMOVE_FINISHED = "Enlever les qu\195\170tes termin\195\169es du Traker";
EQL3_MINIMIZE_FINISHED = "Cacher les objectifs des qu\195\170tes accomplis";
EQL3_SHOW_MINIMIZER = "Montrer le bouton de r\195\169duction du Tracker";
EQL3_TRACKERFONTSIZE = "Taille de la police du Tracker";


--new
--Some masks
EQL_QUEST_ACCEPTED = "Qu\195\170te accept\195\169e:";
EQL_COMPLETE = "%(Accompli%)";

--Organize Strings
EQL3_ORGANIZE_TITLE = "Organisation des qu\195\170tes"
EQL3_ORGANIZE_TEXT = "Cliquer sur un lieu ou tapper\nun nouveau et appuyer sur OK"

EQL3_POPUP_MOVE = "D\195\169placer la qu\195\170te dans un autre groupe";
EQL3_POPUP_RESET = "Restaurer la qu\195\170te dans son groupe d'origine";
EQL3_POPUP_RESETALL = "Restaurer toutes les qu\195\170tes";
EQL3_POPUP_CANCEL = "Annuler";
EQL3_OKAY = "OK";
EQL3_POPUP_TRACK = "Suivre la qu\195\170te";
EQL3_POPUP_UNTRACK = "Arr\195\170ter de suivre la qu\195\170te";


--Load
EQL3_LOAD_TIP = "Charger les options";


-- new to 3.5.6
EQL3_HIDE_COMPLETED_OBJECTIVES = "Cacher individuelement les objectifs accomplis";
EQL3_AUTO_COMPLETE_QUESTS = "Valider automatiquement les qu\195\170tes accomplies";
EQL3_SHOW_OBJECTIVE_MARKERS = "Montrer les marquages des objectifs";
EQL3_LEVELS_ONLY_IN_LOG = "Seulement dans le Questlog et le Tracker";


-- news 3.6.0
EQL3_TOOLTIP_OPTIONS = "Options Tooltip";
EQL3_SHOW_ITEM_TOOLTIP = "Montrer un objet appropri\195\169 \195\160 une qu\195\170te dans le Tooltip";
EQL3_SHOW_MOB_TOOLTIP = "Montrer un mosntre appropri\195\169 \195\160 une qu\195\170te dans le Tooltip";
EQL3_INFO_ON_QUEST_COMPLETE = "Informer sur l'accomplissement d'une qu\195\170te";
EQL3_TOOLTIP_COLOR = "Modifier la couleur des infos dans le Tooltip";


end
