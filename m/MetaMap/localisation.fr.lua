--[[

-- MetaMap Localization Data (French)
-- Translation by Sparrows (Comics UI)
-- Last Update: 05/16/2006

--]]

-- ?C3 A0 - \195\160
-- ?C3 A2 - \195\162
-- ?C3 A7 - \195\167
-- ?C3 A8 - \195\168
-- ?C3 A9 - \195\169
-- ?C3 AA - \195\170
-- ?C3 AB - \195\171
-- ?C3 AE - \195\174
-- : C3 B4 - \195\180
-- : C3 BB - \195\187
-- : C5 93 - \197\147
-- ': E2 80 99 - \226\128\153

if (GetLocale() == "frFR") then

-- General
METAMAP_CATEGORY = "Interface";
METAMAP_SUBTITLE = "WorldMap Mod";
METAMAP_DESC = "MetaMap est une modification de la carte standard du monde.";
METAMAP_OPTIONS_BUTTON = "Options";
METAMAP_STRING_LOCATION = "Lieux";
METAMAP_STRING_LEVELRANGE = "Plage de niveaux";
METAMAP_STRING_PLAYERLIMIT = "Limit\195\169 \195\160";
METAMAP_MAPLIST_INFO = "LeftClick: Ping Note\nRightClick: Edit Note\nCTRL+Click: Loot Table";
METAMAP_BUTTON_TOOLTIP1 = "Clic-Droit pour affiche la carte";
METAMAP_BUTTON_TOOLTIP2 = "Clic-Gauche pour les options";
METAMAP_OPTIONS_TITLE = "MetaMap Options";
METAMAP_KB_TEXT = "Base de donn\195\169es"
METAMAP_HINT = "Conseil : clic-droit pour ouvrir MetaMap.\nclic-gauche pour les options";
METAMAP_NOTES_SHOWN = "Notes"
METAMAP_LINES_SHOWN = "Lignes"
METAMAP_INFOLINE_HINT1 = "LeftClick to toggle StoryLine";
METAMAP_INFOLINE_HINT2 = "RightClick to toggle SideList";
BINDING_HEADER_METAMAP_TITLE = "MetaMap";
BINDING_NAME_METAMAP_MAPTOGGLE = "Toggle WorldMap";
BINDING_NAME_METAMAP_MAPTOGGLE1 = "WorldMap Mode 1";
BINDING_NAME_METAMAP_MAPTOGGLE2 = "WorldMap Mode 2";
BINDING_NAME_METAMAP_FSTOGGLE = "Toggle FullScreen";
BINDING_NAME_METAMAP_SAVESET = "Choisir le mode d\'affichage de la carte";
BINDING_NAME_METAMAP_KB = "Afficher la base de donn\195\169es"
BINDING_NAME_METAMAP_KB_TARGET_UNIT = "Enregistrer les infos de la cible";
BINDING_NAME_METAMAP_QUICKNOTE = "Cr\195\169er une Note Rapide";

-- Commands
METAMAPNOTES_ENABLE_COMMANDS = { "/mapnote" }
METAMAPNOTES_ONENOTE_COMMANDS = { "/onenote", "/allowonenote", "/aon" }
METAMAPNOTES_MININOTE_COMMANDS = { "/nextmininote", "/nmn" }
METAMAPNOTES_MININOTEONLY_COMMANDS = { "/nextmininoteonly", "/nmno" }
METAMAPNOTES_MININOTEOFF_COMMANDS = { "/mininoteoff", "/mno" }
METAMAPNOTES_QUICKNOTE_COMMANDS = { "/quicknote", "/qnote", "/qtloc" }

-- Interface Configuration
METAMAP_MENU_MODE = "Menu sur clic";
METAMAP_OPTIONS_EXT = "Options \195\169tendues";
METAMAP_OPTIONS_COORDS = "Voir Coords";
METAMAP_OPTIONS_MINICOORDS = "Voir les Coords sur MiniMap";
METAMAP_OPTIONS_SHOWAUTHOR = "Afficher le cr\195\169ateur des notes"
METAMAP_OPTIONS_SHOWNOTES = "Notes Filter"
METAMAP_OPTIONS_FILTERON = "Show All"
METAMAP_OPTIONS_FILTEROFF = "Hide All"
METAMAP_OPTIONS_SHOWBUT = "Voir Bouton Minimap";
METAMAP_OPTIONS_AUTOSEL = "Retour a la ligne auto du tooltip";
METAMAP_OPTIONS_BUTPOS = "Position du Bouton";
METAMAP_OPTIONS_POI = "Afficher les POI a l'entr\195\169e de zone (Points Of Interest)";
METAMAP_OPTIONS_LISTCOLORS = "Use coloured Sidelist";
METAMAP_OPTIONS_ZONEHEADER = "Show Zone information in WorldMap header";
METAMAP_OPTIONS_MOZZ = "Affiche l\'inexplor\195\169";
METAMAP_OPTIONS_TRANS = "Transparence";
METAMAP_OPTIONS_SHADER = "BackDrop Shader";
METAMAP_OPTIONS_SHADESET = "Instance Backdrop Shade";
METAMAP_OPTIONS_FWM = "Afficher Zones inexplor\195\169es";
METAMAP_OPTIONS_DONE = "OK";
METAMAP_FLIGHTMAP_OPTIONS = "Options FlightMap";
METAMAP_GATHERER_OPTIONS = "Options Gatherer";
METAMAP_BWP_OPTIONS = "Set a Waypoint";
METAMAP_OPTIONS_SCALE = "Taille de la carte";
METAMAP_OPTIONS_TTSCALE = "Taille des Tooltip";
METAMAP_OPTIONS_SAVESET = "Mode d\'affichage de la carte";
METAMAP_OPTIONS_USEMAPMOD = "Cr\195\169er Notes avec MapMod";
METAMAP_ACTION_MODE = "Allow clicks through map";
METAMAPLIST_SORTED = "Sorted List";
METAMAPLIST_UNSORTED = "Unsorted List";
METAMAP_CLOSE_BUTTON ="Fin";

METAMAP_LOADIMPORTS_BUTTON = "Load Import Module";
METAMAP_LOADEXPORTS_BUTTON = "Export User file";
METAMAP_IMPORTS_HEADER = "Import/Export Module";
METAMAP_RELOADUI_BUTTON = "Reload UI";
METAMAP_IMPORT_BUTTON = "Import";
METAMAP_IMPORT_INSTANCE = "Instance Notes";
METAMAP_IMPORT_INSTANCE_INFO = "This will import any notes created for the instance maps. The file 'MetaMapData.lua' must exist in the MetaMapCVT directory, and contain data in the correct format. This file is included as standard with MetaMap";
METAMAP_IMPORT_NOTES = "Map notes";
METAMAP_IMPORT_NOTES_INFO = "This will import notes created by MapNotes or MapMod into MetaMap. The file 'MapNotes.lua' or 'CT_MapMod.lua' must exist in the MetaMapCVT directory, and contain data in the correct format. These original files can be found in the 'SavedVariables' folder if you have previously used those addons.";
METAMAP_IMPORT_KB = "User File";
METAMAP_IMPORT_KB_INFO = "This will import User created notes into MetaMap. The file 'MetaMapEXP.lua' must exist in the MetaMapCVT directory, and contain data in the correct format. This is the file created as 'SavedVariables\\MetaMapEXP.lua' by the 'Export User File' option.";
METAMAP_IMPORT_BLT = "BLT Data";
METAMAP_IMPORT_BLT_INFO = "This will import the Boss Loot Tables. The file 'MetaMapBLTdata.lua' must exist in the MetaMapCVT directory, and contain data in the correct format. This will additionally import AtlasLoot data, if the AtlasLoot localisation files are found in the MetaMapCVT folder.";
METAMAP_IMPORTS_INFO = "Reload the User Interface after import, to ensure all import data is cleared from memory.";

METAMAPCVT_NOLOAD = "WARNING! MetaMapCVT is disabled. No import possible! MetaMapCVT MUST be enabled in the addons section.";
METAMAPEXP_NOT_ENABLED = "MetaMapEXP module is missing or not enabled!";
METAMAPEXP_KB_EXPORTED = "Exported |cffffffff%s|r unique KB entries to SavedVariables\\MetaMapEXP.lua";
METAMAPEXP_NOTES_EXPORTED = "Exported |cffffffff%s|r unique Notes entries to SavedVariables\\MetaMapEXP.lua";

METAMAPFWM_RETAIN = "FWM always on";
METAMAPFWM_USECOLOR = "Color unexplored areas";
METAMAPFWM_SETCOLOR = "Set Color";
METAFWM_NOT_LOADED = "MetaMapFWM module is not loaded";
METAMAPFWM_NOT_ENABLED = "MetaMapFWM module is missing or not enabled!";

METAKB_NOT_LOADED = "MetaMapWKB module is not loaded";
METAKB_LOAD_MODULE = "Load Module";
METAKB_NOT_ENABLED = "MetaMapWKB module is missing or not enabled!";
METAMAP_NOKBDATA = "MetaMapWKB module not loaded - KB data not processed";

METAMAPBLT_NOT_ENABLED = "MetaMapBLT module is missing or not enabled!";
METAMAPBLT_CONFIRM_IMPORT = "Please select the desired data file to import";
METAMAPBLT_CONFIRM_EXPORT = "Please select the desired data file to export";
METAMAPBLT_IMPORT_DONE = "MetaMapBLT succesfully imported default data";
METAMAPBLT_IMPORT_FAIL = "Selected data unavailable - No data imported";
METAMAPBLT_UPDATE_DONE = "MetaMapBLT updated with latest information";
METAMAPBLT_IMPORT_TIMEOUT = "Timeout - No data imported";
METAMAPBLT_HINT = "Shift+Click: Link Item  -  CTRL+Click: Dressing Room";
METAMAPBLT_NO_INFO = "No information available for this item";
METAMAPBLT_NO_DATA = "Data not yet available or data not imported";
METAMAPBLT_CLASS_SELECT = "Select required class below";

METAMAPZSM_NOT_ENABLED = "MetaMapZSM module is missing or not enabled!";
METAMAPZSM_NEW_VERSION = "New zoneshift version detected. Please select correct conversion below";
METAMAPZSM_NO_SHIFT = "Zoneshifts are up to date. No conversion required";
METAMAPZSM_NO_DETECT = "No updated ZoneShift information detected";
METAMAPZSM_UPDATE_DONE = "MetaMapZSM ZoneShift updated to version |cFFFFD100%s|r";
METAMAPZSM_SKIP_SHIFT = "Skip to next Zoneshift if already shifted";
METAMAPZSM_UPDATE_VERSION = "Update Version";
METAMAPZSM_UPDATE_INFO = "Use the 'Update Version' option if none of the above ZoneShifts need to be applied";

METAMAPBWP_NOT_ENABLED = "MetaMapBWP module is missing or not enabled!";

METAMAPBKP_BACKUP = "Backup Data";
METAMAPBKP_RESTORE = "Restore Data";
METAMAPBKP_INFO_HEADER = "Backup and Restore Module for MetaMap data";
METAMAPBKP_INFO = "Backup will save all current data related to Mapnotes, Mapnote Lines, and MetaKB data to a seperate file. Choose restore at any time to replace the current data with the last saved data.";
METAMAPBKP_BACKUP_DONE = "Successfuly backed up all MetaMap data";
METAMAPBKP_RESTORE_DONE = "Successfuly restored all MetaMap data";
METAMAPBKP_NO_LOAD = "MetaMapBKP module is missing or not enabled!";

METAMAPNOTES_WORLDMAP_HELP_1 = "-Clic Droit sur la carte pour faire un zoom arriere"
METAMAPNOTES_WORLDMAP_HELP_2 = "-<Commande>+Clic Gauche pour Cr\195\169er une Note"
METAMAPNOTES_CLICK_ON_SECOND_NOTE = "Choisissez une Note pour tracer/effacer une ligne"
METAMAPNOTES_CLICK_ON_LOCATION = "Clic Gauche sur la Carte pour un nouvel emplacement de Note"

METAMAPNOTES_NEW_NOTE = "Cr\195\169er Note"
METAMAPNOTES_MININOTE_OFF = "MiniNotes off"
METAMAPNOTES_OPTIONS_TEXT = "Notes Options"
METAMAPNOTES_CANCEL = "Annuler"
METAMAPNOTES_EDIT_NOTE = "Modifier Note"
METAMAPNOTES_MININOTE_ON = " MiniNote On"
METAMAPNOTES_SEND_NOTE = "Envoyer Note"
METAMAPNOTES_TOGGLELINE = "Ligne +/-"
METAMAPNOTES_MOVE_NOTE = "D\195\169placer Note";
METAMAPNOTES_DELETE_NOTE = "Supprimer Note"
METAMAPNOTES_SAVE_NOTE = "Sauvegarder"
METAMAPNOTES_EDIT_TITLE = "Titre (requis):"
METAMAPNOTES_EDIT_INFO1 = "Ligne d\226\128\153Information 1 (optionnelle):"
METAMAPNOTES_EDIT_INFO2 = "Ligne d\226\128\153Information 2 (optionnelle):"
METAMAPNOTES_EDIT_CREATOR = "Cr\195\169ateur (optionnel - Laisser vide pour cacher):"

METAMAPNOTES_SEND_MENU = "Envoyer Note"
METAMAPNOTES_SLASHCOMMAND = "Changer de Mode"
METAMAPNOTES_SEND_TIP = "Les Notes peuvent \195\170tre re\195\167ues par tous les utilisateurs de Notes de Carte"
METAMAPNOTES_SEND_PLAYER = "Nom du joueur :"
METAMAPNOTES_SENDTOPLAYER = "Envoyer Joueur"
METAMAPNOTES_SENDTOPARTY = "Envoyer Groupe"
METAMAPNOTES_SHOWSEND = "Changer Mode"
METAMAPNOTES_SEND_SLASHTITLE = "Obtenir la /commande :"
METAMAPNOTES_SEND_SLASHTIP = "Selectionnez ceci et utilisez CTRL+C pour la copier dans le presse-papier.\n(Vous pouvez ensuite l\226\128\153envoyer sur un forum par exemple)"
METAMAPNOTES_SEND_SLASHCOMMAND = "/Commande :"
METAMAPNOTES_PARTYSENT = "PartyNote sent to all Party members.";
METAMAPNOTES_RAIDSENT = "PartyNote sent to all Raid members.";
METAMAPNOTES_NOPARTY = "Not currently in a Party or Raid.";

METAMAPNOTES_OWNNOTES = "Afficher les notes cr\195\169\195\169es par votre personnage."
METAMAPNOTES_OTHERNOTES = "Afficher les Notes re\195\167ues des autres joueurs."
METAMAPNOTES_HIGHLIGHT_LASTCREATED = "Mettre en \195\169vidence (en |cFFFF0000rouge|r) la derni\195\168re Note cr\195\169\195\169e."
METAMAPNOTES_HIGHLIGHT_MININOTE = "Mettre en \195\169vidence (en |cFF6666FFbleu|r) la Note selectionn\195\169e."
METAMAPNOTES_ACCEPTINCOMING = "Accepter les Notes des autres utilisateurs."
METAMAPNOTES_AUTOPARTYASMININOTE = "Membres du groupe en MiniNote."
METAMAPNOTES_ZONESEARCH_TEXT = "Delete notes for |cffffffff%s|r by creator:"
METAMAPNOTES_ZONESEARCH_TEXTHINT = "Hint: Open WorldMap and set map to desired area for deletion";
METAMAPNOTES_BATCHDELETE = "This will delete all notes for |cFFFFD100%s|r with creator as |cFFFFD100%s|r.";
METAMAPNOTES_DELETED_BY_NAME = "Deleted selected notes with creator |cFFFFD100%s|r and name |cFFFFD100%s|r."
METAMAPNOTES_DELETED_BY_CREATOR = "Deleted all notes with creator |cFFFFD100%s|r."
METAMAPNOTES_DELETED_BY_ZONE = "Deleted all notes for |cFFFFD100%s|r with creator |cFFFFD100%s|r."


METAMAPNOTES_CREATEDBY = "Cr\195\169\195\169 par"
METAMAPNOTES_CHAT_COMMAND_ENABLE_INFO = "Cette commande vous permet d\226\128\153ajouter une Note trouv\195\169e sur une page web par exemple."
METAMAPNOTES_CHAT_COMMAND_ONENOTE_INFO = "Autorise la r\195\169ception de la prochaine Note."
METAMAPNOTES_CHAT_COMMAND_MININOTE_INFO = "Mettre la prochaine Note re\195\167ue en tant que MiniNote (avec une copie sur la carte)."
METAMAPNOTES_CHAT_COMMAND_MININOTEONLY_INFO = "Mettre la prochaine Note re\195\167ue en tant que MiniNote (seulement sur la minicarte)."
METAMAPNOTES_CHAT_COMMAND_MININOTEOFF_INFO = "D\195\169sactiver MiniNote."
METAMAPNOTES_CHAT_COMMAND_QUICKNOTE = "Cr\195\169er une Note \195\160 votre position actuelle."
METAMAPNOTES_MAPNOTEHELP = "Cette commande ne peut \195\170tre utilis\195\169e que pour ajouter une Note."
METAMAPNOTES_ONENOTE_OFF = "Autoriser une Note : D\195\169sactiv\195\169"
METAMAPNOTES_ONENOTE_ON = "Autoriser une Note : Activ\195\169"
METAMAPNOTES_MININOTE_SHOW_0 = "Prochaine Note en MiniNote: D\195\169sactiv\195\169"
METAMAPNOTES_MININOTE_SHOW_1 = "Prochaine Note en MiniNote: Activ\195\169"
METAMAPNOTES_MININOTE_SHOW_2 = "Prochaine Note en MiniNote: Seulement"
METAMAPNOTES_ACCEPT_NOTE = "Note ajout\195\169 dans |cFFFFD100%s|r."
METAMAPNOTES_DECLINE_NOTE = "Ajout impossible, Note trop proche de |cFFFFD100%q|r dans |cFFFFD100%s|r."
METAMAPNOTES_ACCEPT_MININOTE = "MiniNote set for the map of |cFFFFD100%s|r.";
METAMAPNOTES_DECLINE_GET = "|cFFFFD100%s|r a essay\195\169 de vous envoyer la Note |cFFFFD100%s|r, mais elle est trop proche de |cFFFFD100%q|r."
METAMAPNOTES_DISABLED_GET = "R\195\169ception impossible, la r\195\169ception de Notes est d\195\169sactiv\195\169e."
METAMAPNOTES_ACCEPT_GET = "Vous avez re\195\167u la Note \226\128\153|cFFFFD100%s|r dans |cFFFFD100%s|r"
METAMAPNOTES_PARTY_GET = "|cFFFFD100%s|r utilis\195\169 comme Note de g\226\128\153roupe dans |cFFFFD100%s|r."
METAMAPNOTES_NOTE_SENT = "Note sent to |cFFFFD100%s|r."
METAMAPNOTES_QUICKNOTE_DEFAULTNAME = "Note Rapide"
METAMAPNOTES_MININOTE_DEFAULTNAME = "MiniNote"
METAMAPNOTES_VNOTE_DEFAULTNAME = "VirtuelNote"
METAMAPNOTES_SETMININOTE = "Utiliser comme MiniNote"
METAMAPNOTES_PARTYNOTE = "Note de groupe"
METAMAPNOTES_SETCOORDS = "Coords (xx,yy):"
METAMAPNOTES_VNOTE = "Virtuel"
METAMAPNOTES_VNOTE_INFO = "Cr\195\169er une note virtuelle. Save on map of choice to bind."
METAMAPNOTES_VNOTE_SET = "Note virtuelle cr\195\169e sur la carte du monde."
METAMAPNOTES_MININOTE_INFO = "Cr\195\169e une note sur la Minimap seulement."
METAMAPNOTES_INVALIDZONE = "Could not create - no player coords available in this zone.";

-- Buttons, Headers, Various Text

-- Informational
METAKB_NO_NPC_MOB_FOUND = "Aucun NPCs/mobs  trouv\195\169 pour: \"%s\""
METAKB_REMOVED_FROM_DATABASE = "Enlev\195\169 \"%s\" dans \"%s\" de la base de donn\195\169es"
METAKB_DISCOVERED_UNIT = "D\195\169couvert %s!"
METAKB_ADDED_UNIT_IN_ZONE = "Suppl\195\169mentaire %s in %s"
METAKB_UPDATED_MINMAX_XY = "Mis \195\160 jour Min/Max X/Y pour %s dans %s"
METAKB_UPDATED_INFO = "Information mise \195\160 jour pour %s dans %s"
METAKB_IMPORT_SUCCESSFUL = "MetaKB Data imported successfully, added %u entries from a total of %u with %u unknown and %u duplicates not imported."
METAKB_STATS_LINE = "%u NPCs dans %u Zones/Instances"
METAKB_NOTARGET = "Vous devez avoir une cible pour l\'enregistrer."
METAKB_TRIM_DBASE = "This will delete all entries from the database listed by search results.\nIf search box is empty, ALL listed entries will be removed from the database.";

METAMAPNOTES_WARSONGGULCH = "Goulet des Warsong"
METAMAPNOTES_ALTERACVALLEY = "Vall\195\169e d\226\128\153Alterac"
METAMAPNOTES_ARATHIBASIN = "Bassin d\226\128\153Arathi"

MetaMap_Data = {
[1] = {
["ZoneName"] = "Profondeurs de Brassenoire",
["Location"] = "Ashenvale",
["LevelRange"] = "24-32",
["PlayerLimit"] = "10",
["texture"] = "BlackfathomDeeps",
		["infoline"] = "Situé le long de la grève de Zoram, en Ashenvale, les profondeurs de Brassenoire étaient autrefois un merveilleux temple, dédié à Élune, la déesse-lune des elfes de la nuit. La Grande Fracture a englouti le temple sous les vagues de la Mer voilée. Il y est resté, intouché, jusqu'à ce que les nagas et les satyres, attirés par son pouvoir ancien, émergent pour fouiller ses secrets. À en croire la légende, la bête ancienne nommée Aku'mai s'y est installée. Aku'mai, qui était le familier favori des Anciens dieux primordiaux, sévit dans la région depuis fort longtemps. Attiré par la présence d'Aku'mai, le culte connu sous le nom de Marteau du crépuscule est venu savourer la présence maléfique des Anciens dieux.",
},
[2] = {
["ZoneName"] = "Profondeurs de Blackrock",
["Location"] = "Montagne de Blackrock",
["LevelRange"] = "52+",
["PlayerLimit"] = "5",
["texture"] = "BlackrockDepths",
		["infoline"] = "Ce labyrinthe volcanique était autrefois la capitale des nains Dark Iron. C'est aujourd'hui le domaine de Ragnaros, le seigneur du feu. Ragnaros a découvert le moyen de créer la vie à partir de la pierre, et il compte bâtir une armée de golems pour l'aider à conquérir la totalité du mont Blackrock. Obsédé par l'idée de vaincre Nefarian et ses sbires draconiques, Ragnaros est prêt à n'importe quelle extrémité pour triompher.",
},
[3] = {
["ZoneName"] = "Pic Blackrock",
["Location"] = "Montagne de Blackrock",
["LevelRange"] = "55+",
["PlayerLimit"] = "10",
["texture"] = "BlackrockSpireLower",
		["infoline"] = "La puissante forteresse taillée dans les entrailles enflammées du mont Blackrock fut conçue par le maître-maçon nain Franclorn Forgewright. Elle devait être le symbole de la puissance des Dark Iron, et ceux-ci la conservèrent pendant des siècles. Mais Nefarian, le rusé fils du dragon Deathwing avait d'autres plans pour cet immense donjon. Aidé par ses sbires draconiques, il prit le contrôle du haut du pic et partit en guerre contre les domaines des nains, dans les profondeurs volcaniques de la montagne. Réalisant que les nains étaient dirigés par le grand élémentaire de feu, Ragnaros, Nefarian fit le vœu d'écraser ses adversaires et de s'emparer de la totalité de la montagne.",
},
[4] = {
["ZoneName"] = "Pic Blackrock (sup\195\169rieur)",
["Location"] = "Montagne de Blackrock",
["LevelRange"] = "58+",
["PlayerLimit"] = "10",
["texture"] = "BlackrockSpireUpper",
		["infoline"] = "La puissante forteresse taillée dans les entrailles enflammées du mont Blackrock fut conçue par le maître-maçon nain Franclorn Forgewright. Elle devait être le symbole de la puissance des Dark Iron, et ceux-ci la conservèrent pendant des siècles. Mais Nefarian, le rusé fils du dragon Deathwing avait d'autres plans pour cet immense donjon. Aidé par ses sbires draconiques, il prit le contrôle du haut du pic et partit en guerre contre les domaines des nains, dans les profondeurs volcaniques de la montagne. Réalisant que les nains étaient dirigés par le grand élémentaire de feu, Ragnaros, Nefarian fit le vœu d'écraser ses adversaires et de s'emparer de la totalité de la montagne.",
},
[5] = {
["ZoneName"] = "Repaire de l\'Aile noire",
["Location"] = "Montagne de Blackrock",
["LevelRange"] = "60+",
["PlayerLimit"] = "40",
["texture"] = "BlackwingLair",
		["infoline"] = "Le repaire de l'Aile noire se trouve au sommet du Pic Blackrock. C'est dans les recoins les plus sombres, au sommet de cette montagne que Nefarian a élaboré les dernières phases de son plan pour détruire Ragnaros une fois pour toute et lancer son armée à l'assaut d'Azeroth. Cliquez ici pour en apprendre plus sur le repaire de l'Aile noire. Nefarian a juré la perte de Ragnaros. Dans ce but, il cherche depuis peu à renforcer ses troupes, comme son père Deathwing avait tenté de le faire autrefois. Cependant, là où Deathwing a échoué, on dirait que Nefarian le comploteur pourrait réussir. La folle quête de pouvoir de Nefarian a même déclenché la colère du Vol rouge, qui a toujours été le pire ennemi du Vol noir. Bien que les intentions de Nefarian soient connues, ses méthodes demeurent mystérieuses. On pense cependant que Nefarian s'est livré à des expériences avec le sang de tous les vols de dragon pour obtenir des guerriers invincibles.",
},
[6] = {
["ZoneName"] = "Hache-Tripes",
["Location"] = "Feralas",
["LevelRange"] = "56-60",
["PlayerLimit"] = "5",
["texture"] = "DireMaul",
		["infoline"] = "Bâtie il y a douze mille ans par une secte secrète de sorciers elfes de la nuit, l'antique cite d'Eldre'Thalas servait à protéger les secrets magiques les plus précieux de la reine Azshara. Elle fut ravagée par la Grande Fracture du monde, mais une bonne partie de la ville se dresse encore, rebaptisée Hache-tripes. Les trois quartiers de la ville ont été envahis de toutes sortes de créatures, Bien-nés spectraux, vils satyres et ogres brutaux. Seuls les groupes d'aventuriers les plus audacieux peuvent pénétrer dans cette ville détruite et affronter les maux anciens qui y sont enfermés dans ses salles antiques.",
},
[7] = {
["ZoneName"] = "Hache-Tripes (Est)",
["Location"] = "Feralas",
["LevelRange"] = "56-60",
["PlayerLimit"] = "5",
["texture"] = "DireMaulEast",
		["infoline"] = "Bâtie il y a douze mille ans par une secte secrète de sorciers elfes de la nuit, l'antique cite d'Eldre'Thalas servait à protéger les secrets magiques les plus précieux de la reine Azshara. Elle fut ravagée par la Grande Fracture du monde, mais une bonne partie de la ville se dresse encore, rebaptisée Hache-tripes. Les trois quartiers de la ville ont été envahis de toutes sortes de créatures, Bien-nés spectraux, vils satyres et ogres brutaux. Seuls les groupes d'aventuriers les plus audacieux peuvent pénétrer dans cette ville détruite et affronter les maux anciens qui y sont enfermés dans ses salles antiques.",
},
[8] = {
["ZoneName"] = "Hache-Tripes (Nord)",
["Location"] = "Feralas",
["LevelRange"] = "56-60",
["PlayerLimit"] = "5",
["texture"] = "DireMaulNorth",
		["infoline"] = "Bâtie il y a douze mille ans par une secte secrète de sorciers elfes de la nuit, l'antique cite d'Eldre'Thalas servait à protéger les secrets magiques les plus précieux de la reine Azshara. Elle fut ravagée par la Grande Fracture du monde, mais une bonne partie de la ville se dresse encore, rebaptisée Hache-tripes. Les trois quartiers de la ville ont été envahis de toutes sortes de créatures, Bien-nés spectraux, vils satyres et ogres brutaux. Seuls les groupes d'aventuriers les plus audacieux peuvent pénétrer dans cette ville détruite et affronter les maux anciens qui y sont enfermés dans ses salles antiques.",
},
[9] = {
["ZoneName"] = "Hache-Tripes (Ouest)",
["Location"] = "Feralas",
["LevelRange"] = "56-60",
["PlayerLimit"] = "5",
["texture"] = "DireMaulWest",
		["infoline"] = "Bâtie il y a douze mille ans par une secte secrète de sorciers elfes de la nuit, l'antique cite d'Eldre'Thalas servait à protéger les secrets magiques les plus précieux de la reine Azshara. Elle fut ravagée par la Grande Fracture du monde, mais une bonne partie de la ville se dresse encore, rebaptisée Hache-tripes. Les trois quartiers de la ville ont été envahis de toutes sortes de créatures, Bien-nés spectraux, vils satyres et ogres brutaux. Seuls les groupes d'aventuriers les plus audacieux peuvent pénétrer dans cette ville détruite et affronter les maux anciens qui y sont enfermés dans ses salles antiques.",
},
[10] = {
["ZoneName"] = "Gnomeregan",
["Location"] = "Dun Morogh",
["LevelRange"] = "29-38",
["PlayerLimit"] = "10",
["texture"] = "Gnomeregan",
		["infoline"] = "Capitale des gnomes depuis des générations, Gnomeregan était la merveille technologique de Dun Morogh. Mais il y a peu, une race de troggs mutants hostiles a attaqué plusieurs régions de Dun Morogh, y compris la grand cité gnome. Dans une tentative désespérée pour repousser les envahisseurs, le Grand Artisan Mekkatorque ordonna que les réservoirs de déchets radioactifs soient purgés. Les gnomes se précipitèrent aux abris, attendant que les substances toxiques qui saturaient l'air tuent les troggs ou les poussent à la fuite. Malheureusement, bien que les troggs aient été irradiés, ils poursuivirent le siège. Les gnomes qui ne furent pas tués par les vapeurs durent fuir et se réfugier dans la cité naine toute proche, Ironforge. Le Grand Artisan Mekkatorque cherche à y recruter des âmes vaillantes pour aider son peuple à reprendre sa ville bien-aimée. On murmure que l'ancien conseiller de Mekkatorque, le Mekgineer Thermaplug a trahi son peuple en permettant à l'invasion de se produire. Devenu fou, Thermaplug est toujours à Gnomeregan, ourdissant de sinistres complots et servant de nouveau technomaître à la ville.",
},
[11] = {
["ZoneName"] = "Maraudon",
["Location"] = "Desolace",
["LevelRange"] = "46-55",
["PlayerLimit"] = "10",
["texture"] = "Maraudon",
		["infoline"] = "Protégé par les terribles centaures Maraudine, Maraudon est l'un des lieux les plus sacrés de Désolace. Ce grand temple/caverne est la tombe de Zaetar, l'un des deux fils immortels nés du demi-dieu Cénarius. A en croire la légende, Zaetar et Theradras, la princesse des élémentaires de terre, engendrèrent le peuple des centaures. On dit également que peu après, les centaures barbares se retournèrent contre leur père et le tuèrent. Certains croient que Theradras, dans son chagrin, emprisonna l'esprit de Zaetar dans la caverne sinueuse, et qu'elle se servit de cette énergie dans des buts maléfiques. Les tunnels souterrains sont peuplés des esprits cruels des Khans centaures morts depuis longtemps, sans oublier les sbires élémentaires déchaînés de Theradras.",
},
[12] = {
["ZoneName"] = "C\197\147ur du Magma",
["Location"] = "Profondeurs de Blackrock",
["LevelRange"] = "60+",
["PlayerLimit"] = "40",
["texture"] = "MoltenCore",
		["infoline"] = "Le Cœur du Magma repose au fin fond des profondeurs de Blackrock. Il est le cœur de la montagne Blackrock et le lieu où, il y a bien longtemps, tentant désespérément de changer le cours de la guerre civile naine, l'empereur Thaurissan invoqua Ragnaros, le seigneur du Feu, en Azeroth. Bien que le seigneur du Feu soit incapable de s'éloigner du noyau ardent, certains pensent que ses serviteurs commandent aux nains Dark Iron, travaillant activement à la création d'une armée à partir de pierre vivante. Le lac enflammé où Ragnaros repose endormi sert de portail vers le plan du feu, que des élémentaires malveillants n'hésitent pas à traverser. C'est au majordome Executus que revient le soin de diriger les agents de Ragnaros. Cet élémentaire particulièrement rusé est le seul capable de réveiller le seigneur du Feu.",
},
[13] = {
["ZoneName"] = "Repaire d\'Onyxia",
["Location"] = "Mar\195\169cage d\'Aprefange",
["LevelRange"] = "60+",
["PlayerLimit"] = "40",
["texture"] = "OnyxiasLair",
		["infoline"] = "Onyxia est la fille du puissant dragon Deathwing, et la sœur de l'intrigant Nefarian, seigneur du Pic Blackrock. Il est dit qu'Onyxia aime à corrompre les peuples mortels en se mêlant de leurs affaires politiques. À cette fin, elle revêtirait diverses formes humanoïdes et userait de ses charmes et de ses pouvoirs pour influencer à sa convenance la diplomatie, ô combien délicate, entre les différents peuples d'Azeroth. Certains croient même qu'Onyxia a assumé une identité autrefois prise par son père, à savoir le titre de la maison royale Prestor. Lorsqu'elle ne se mêle pas des affaires des mortels, Onyxia demeure dans les caves embrasées sous le Cloaque aux dragons, un lugubre marais du Marécage d'Âprefange. Dans son repaire, elle est protégée par ses pairs, membres survivants du Vol des dragon noirs.",
},
[14] = {
["ZoneName"] = "Gouffre de Ragefeu",
["Location"] = "Orgrimmar",
["LevelRange"] = "13-15",
["PlayerLimit"] = "10",
["texture"] = "RagefireChasm",
		["infoline"] = "Le gouffre de Ragefeu est un réseau de cavernes volcaniques qui se trouve sous Orgrimmar, la nouvelle capitale des orcs. Depuis peu, des rumeurs prétendent qu'un culte loyal au démoniaque Conseil des ombres s'est installé dans ses profondeurs enflammées. Ce culte, nommé la Lame ardente, menace la souveraineté même de Durotar. Beaucoup de gens croient que le Chef de guerre Thrall est informé de l'existence de la Lame et a choisi de ne pas la détruire dans l'espoir que ses membres pourraient le mener au Conseil des ombres. Quoi qu'il advienne, la puissance ténébreuse qui émane du gouffre de Ragefeu pourrait anéantir tout ce pour quoi les orcs ont lutté.",
},
[15] = {
["ZoneName"] = "Souilles de Tranchebauge",
["Location"] = "Les Tarides",
["LevelRange"] = "33-40",
["PlayerLimit"] = "10",
["texture"] = "RazorfenDowns",
		["infoline"] = "Taillées dans les mêmes ronces géantes que le Kraal de Tranchebauge, les Souilles de Tranchebauge sont la capitale traditionnelle du peuple huran, le peuple des hommes-sangliers. Ce labyrinthe immense et hérissé d'épines abrite une véritable armée de hurans loyaux et leurs grands prêtres – la tribu Tête de Mort. Depuis peu, une ombre lugubre s'étend sur ce domaine primitif. Des agents du Fléau mort-vivant, conduits par la liche Amnennar, dite le Porte-froid, ont pris le contrôle du peuple huran et ont transformé le labyrinthe de ronces en un bastion de la puissance des morts-vivants. Les hurans livrent une bataille désespérée pour reconquérir leur ville bien-aimée avant qu'Amnennar n'étende sa puissance sur les Tarides.",
},
[16] = {
["ZoneName"] = "Kraal de Tranchebauge",
["Location"] = "Les Tarides",
["LevelRange"] = "25-30",
["PlayerLimit"] = "10",
["texture"] = "RazorfenKraul",
		["infoline"] = "Il y a dix mille ans, au cours de la guerre des Anciens, le puissant demi-dieu Agamaggan partit affronter la Légion ardente. Le colossal sanglier tomba au combat, mais son sacrifice aida à préserver Azeroth de la défaite. Avec le temps, là où avait coulé son sang, d'immenses plantes épineuses sortirent du sol. Les hurans, les hommes-sangliers, dont on suppose qu'ils sont les descendants mortels du dieu, vinrent occuper ces régions, sacrées pour eux. Le cœur de ces colonies de ronces géantes prit le nom de Tranchebauge. Une grande partie du Kraal a été conquise par la vieille mégère Charlga Razorflank. Sous sa férule, les hurans, pratiquant la foi chamanique, attaquent les tribus rivales et les villages de la Horde. À en croire les rumeurs, Charlga négocierait avec des agents du Fléau, et serait en train de placer sa tribu, qui ne se doute de rien, parmi les rangs des morts-vivants pour une raison inconnue.",
},
[17] = {
["ZoneName"] = "Monast\195\168re \195\169carlate",
["Location"] = "Clairi\195\168re de Tirisfal",
["LevelRange"] = "34-45",
["PlayerLimit"] = "10",
["texture"] = "ScarletMonastery",
		["infoline"] = "Le monastère était autrefois un grand centre d'éducation et d'illumination, l'orgueil de la prêtrise de Lordaeron. Avec la venue du Fléau mort-vivant au cours de la Troisième Guerre, ce paisible monastère devint la forteresse des fanatiques de la Croisade écarlate. Les Croisés se montrent intolérants envers toutes les races non-humaines, quelles que soient leurs alliances ou leur affiliation. Soupçonnant tous les étrangers d'être porteurs de la Peste de la non-vie, ils les tuent sans hésitation. Les rapports indiquent que les aventuriers qui pénètrent dans le monastère sont forcés d'affronter le Commandant écarlate Mograine, qui contrôle une importante garnison de guerriers fanatiques. Toutefois, le vrai maître des lieux est la Grande inquisitrice Whithemane – une prêtresse qui possède la capacité de ressusciter les guerriers qui tombent en combattant pour elle.",
},
[18] = {
["ZoneName"] = "Scholomance",
["Location"] = "Maleterres de l\'Ouest",
["LevelRange"] = "56-60",
["PlayerLimit"] = "5",
["texture"] = "Scholomance",
		["infoline"] = "La Scholomance se trouve dans une série de cryptes, sous le donjon en ruine de Caer Darrow. C'était autrefois le domaine de la noble famille Barov, mais il tomba au cours de la Deuxième Guerre. Lorsque le mage Kel'thuzad recrutait des disciples pour former le Culte des Damnés, il promettait souvent l'immortalité en échange de la promesse de servir le Roi-liche. La famille Barov succomba au charisme de Kel'thuzad et donna son donjon et ses cryptes au Fléau. Les sectateurs tuèrent les Barov et transformèrent les cryptes en une école de nécromancie, la Scholomance. Kel'thuzad ne réside plus dans les cryptes, mais elles sont encore infestées de fanatiques et de leurs instructeurs. La liche Ras Frostwhisper règne sur les lieux et les protége au nom du Fléau. Quant au nécromancien mortel, le Sombre Maître Gandling, il sert de directeur à l'école.",
},
[19] = {
["ZoneName"] = "Donjon d\'Ombrecroc",
["Location"] = "For\195\170t des Pins Argent\195\169s",
["LevelRange"] = "22-30",
["PlayerLimit"] = "10",
["texture"] = "ShadowfangKeep",
		["infoline"] = "Au cours de la Troisième Guerre, les mages du Kirin Tor combattirent les armées mortes-vivantes du Fléau. Mais à chaque mage de Dalaran qui tombait au combat, se relevait peu après un mort-vivant ; et leur puissance s'ajoutait à celle du Fléau. Frustré par l'absence de résultats (et contre l'avis de ses pairs), l'archimage Arugal décida d'invoquer des entités extradimensionnelles pour renforcer les rangs déclinants de Dalaran. L'invocation d'Arugal ouvrit les portes d'Azeroth aux voraces worgens. Ces hommes-loups sauvages massacrèrent les troupes du Fléau avant de se retourner contre les mages eux-mêmes. Ensuite, ils assiégèrent le château du noble baron Silverlaine. Situé au-dessus du hameau de Bois-du-Bûcher, le donjon ne tarda pas à se transformer en une sombre ruine. Rendu fou par la culpabilité, Arugal adopta les worgens comme ses enfants et se retira dans le tout fraîchement rebaptisé « donjon d'Ombrecroc ». On dit qu'il y vit toujours, protégé par son colossal familier Fenrus, et hanté par le fantôme vengeur du baron Silverlaine.",
},
[20] = {
["ZoneName"] = "Stratholme",
["Location"] = "Maleterres de l\'Est",
["LevelRange"] = "55-60",
["PlayerLimit"] = "5",
["texture"] = "Stratholme",
		["infoline"] = "La ville de Stratholme était le joyau de Lordaeron. C'est là que le prince Arthas se retourna contre son mentor, Uther Lightbringer, et qu'il mit à mort des centaines de ses propres sujets, qu'il croyait atteint par la terrible Peste de la non-vie. Peu après, Arthas bascula et se livra au Roi-liche. La cité en ruine est à présent le domaine du Fléau mort-vivant, dirigé par la puissante liche Kel'thuzad. Un contingent de Croisés écarlates, dirigés par le Grand croisé Dathrohan tient également une partie de la ville. Les deux camps ne cessent de se combattre. Les aventuriers assez braves (ou assez fous) pour pénétrer dans Stratholme ne tarderont pas à se mettre les deux factions à dos. On dit que la ville est gardée par trois tours de garde géantes, sans oublier de puissants nécromanciens, des banshees et des abominations. Certains rapports mentionnent également un Chevalier de la mort monté sur un effrayant destrier. Sa colère s'abattrait sur tous ceux qui osent pénétrer dans le royaume du Fléau.",
},
[21] = {
["ZoneName"] = "Les Mortemines",
["Location"] = "Marche de l\'Ouest",
["LevelRange"] = "17-26",
["PlayerLimit"] = "10",
["texture"] = "TheDeadmines",
		["infoline"] = "Les « mines mortes » étaient autrefois le principal centre de production d'or des royaumes humains, mais elles furent abandonnées lorsque la Horde rasa Stormwind au cours de la Première Guerre. De nos jours, la Confrérie défias s'est établie dans ces tunnels obscurs et en a fait son sanctuaire. On murmure que ces voleurs auraient recruté des gobelins pour les aider à construire quelque chose de terrible au fond des mines – mais nul ne sait quoi. À en croire les rumeurs, l'accès des Mortemines se trouverait non loin du petit village discret de Ruisselune.",
},
[22] = {
["ZoneName"] = "La Prison",
["Location"] = "Stormwind",
["LevelRange"] = "23-26",
["PlayerLimit"] = "10",
["texture"] = "TheStockades",
		["infoline"] = "La Prison est un complexe de haute sécurité, caché sous le quartier des canaux de Stormwind. Dirigée par le Gardien Thelwater, la Prison est le domaine des petits voyous, des protestataires, des assassins et de dizaines de criminels violents. Récemment, une révolte de prisonniers à déclenché le chaos dans la Prison – les gardes en ont été chassés et les prisonniers ont pris le contrôle des lieux. Le Gardien Thelwater est parvenu à s'échapper et tente de recruter des têtes brûlées pour s'introduire dans la prison et liquider le chef des mutins, le rusé Bazil Thredd.",
},
[23] = {
["ZoneName"] = "Le temple d\'Atal\'Hakkar",
["Location"] = "Marais des chagrins",
["LevelRange"] = "45-55",
["PlayerLimit"] = "10",
["texture"] = "TheSunkenTemple",
		["infoline"] = "Il y a plus de mille ans, le puissant empire Gurubashi a été ravagé par une guerre civile de grande ampleur. Un groupe de prêtres trolls influents, les Ata'lai, ont tenté de ramener un ancien dieu du sang nommé Hakkar l'Ecorcheur d'esprit. Bien que les prêtres aient été vaincus et exilés, le grand empire troll s'effondra malgré tout. Les prêtres exilés s'enfuirent vers le nord, dans le Marais des Chagrins. Ils y bâtirent un grand temple dédié à Hakkar, d'où ils préparèrent son arrivée dans le monde physique. Le grand Aspect dragon, Ysera, découvrit les plans des Ata'lai et détruisit le temple. Aujourd'hui encore, ses ruines englouties sont gardées par des dragons verts qui tentent d'empêcher toute entrée ou sortie. On suppose que certains Ata'lai auraient survécu à la colère d'Ysera, et se seraient consacrés à nouveau au noir service d'Hakkar.",
},
[24] = {
["ZoneName"] = "Uldaman",
["Location"] = "Terres ingrates",
["LevelRange"] = "35-47",
["PlayerLimit"] = "10",
["texture"] = "Uldaman",
		["infoline"] = "Uldaman est une antique cache des Titans, enfoui au plus profond de la terre depuis la création du monde. Des fouilles naines ont récemment ouvert cette cité oubliée, libérant la première création manquée des Titans, les troggs. La légende prétend que les Titans ont taillé les troggs dans la pierre. Lorsqu'ils ont estimé que l'expérience était un échec, les Titans ont enfermé les troggs et ont procédé à un deuxième essai, donnant naissance aux nains. Les secrets de la création des nains sont conservés sur les Disques de Norgannon, de massifs artefacts fabriqués par les Titans, et qui se trouvent aux tréfonds de la ville. Depuis peu, les nains Dark Iron ont lancé une série d'incursions dans Uldaman, dans l'espoir de découvrir les disques pour leur maître incandescent, Ragnaros. Toutefois, la ville est protégée par plusieurs gardiens, des géants de pierre artificiels et animés qui broient les intrus. Les Disques eux-mêmes sont protégés par Archadeas, un colossal Gardien des pierres éveillé à la conscience. Certaines rumeurs laissent entendre que les ancêtres des nains, les terrestres à la peau de pierre, pourraient encore vivre dans les cachettes les plus profondes de la cité.",
},
[25] = {
["ZoneName"] = "Cavernes des lamentations",
["Location"] = "Les Tarides",
["LevelRange"] = "17-24",
["PlayerLimit"] = "10",
["texture"] = "WailingCaverns",
		["infoline"] = "Récemment, Naralex, un druide elfe de la nuit, a découvert un réseau de cavernes souterraines au cœur des Tarides. Elles doivent leur nom aux évents volcaniques qui produisent de longs gémissements lugubres lorsque de la vapeur s'en échappe. Naralex s'imaginait qu'il pourrait se servir des sources souterraines des cavernes pour rendre leur fertilité aux Tarides - mais pour cela, il aurait dû siphonner l'énergie du légendaire Rêve d'émeraude. Mais lorsqu'il se connecta au Rêve, la vision du druide tourna au cauchemar. Les Cavernes des lamentations changèrent. Leurs eaux croupirent et les créatures dociles qui y vivaient se métamorphosèrent en prédateurs vicieux. On dit que Naralex en personne vit quelque part au cœur de ce labyrinthe, piégé aux confins du Rêve d'émeraude. Même ses anciens acolytes ont été corrompus par le cauchemar éveillé de leur maître. Ils sont devenus les cruels Druides déviants.",
},
[26] = {
["ZoneName"] = "Zul'Farrak",
["Location"] = "D\195\169sert de Tanaris",
["LevelRange"] = "43-47",
["PlayerLimit"] = "10",
["texture"] = "ZulFarrak",
		["infoline"] = "Cette cite écrasée de soleil est le domaine des trolls Sandfury, connus pour leur cruauté et leur mysticisme ténébreux. Les légendes trolls parlent d'une épée puissante, Sul'thraze la Flagellante, capable d'instiller la peur et la faiblesse au plus redoutable des ennemis. Il y a bien longtemps, l'épée fut brisée en deux, mais on dit que les deux moitiés se trouveraient quelque part dans les murs de Zul'Farrak. D'autres rumeurs laissent entendre qu'une bande de mercenaires fuyant Gadgetzan se sont aventurés dans la cité et y ont été piégés. Le sort reste mystérieux. Mais le plus perturbant restent les murmures qui mentionnent une créature ancienne qui dormirait sous un bassin sacré au cœur de la cité – un puissant demi-dieu qui détruira impitoyablement tout aventurier assez fou pour venir l'éveiller.",
},
[27] = {
["ZoneName"] = "Zul'Gurub",
["Location"] = "Vall\195\169e de Strangleronce",
["LevelRange"] = "60+",
["PlayerLimit"] = "20",
["texture"] = "ZulGurub",
		["infoline"] = "Plus de mille ans auparavant, le puissant empire Gurubashi a été déchiré par une gigantesque guerre civile. Un groupe de prêtres trolls influents, les Atal'ai, tenta de faire revenir l'avatar d'un dieu ancien et terrible, Hakkar l'Écorcheur d'âmes, le Dieu sanglant. Les prêtres furent vaincus, puis exilés, mais le grand empire troll s'effondra. Les prêtres bannis s'enfuirent vers le nord, dans le marais des Chagrins, où ils bâtirent un grand temple à Hakkar pour préparer son retour dans le monde physique.",
},
[28] = {
["ZoneName"] = "Ahn'Qiraj",
["Location"] = "Silithus",
["LevelRange"] = "60+",
["PlayerLimit"] = "40",
["texture"] = "TempleofAhnQiraj",
		["infoline"] = "C'est au cœur d'Ahn'Qiraj que repose ce très ancien temple. Construit en des temps où l'histoire n'était pas encore écrite, c'est à la fois un monument à d'indicibles dieux et une ruche massive où nait l'armée qiraji. Depuis que la guerre des Sables changeants s'est achevée il y a un millier d'années, les empereurs jumeaux de l'empire qiraji ont été enfermés dans leur temple, à peine contenus par la barrière magique érigée par le dragon de bronze Anachronos et les elfes de la nuit. Maintenant que le sceptre des Sables changeant a été réassemblé et que le sceau a été brisé, le chemin vers le sanctuaire d'Ahn'Qiraj a été ouvert. Par delà la folie grouillante des ruches, sous le temple d'Ahn'Qiraj, des légions de qiraji se préparent à l'invasion. Ils doivent être arrêtés à tout prix, avant qu'ils ne lâchent à nouveau sur Kalimdor leurs armées insectoïdes et voraces, et qu'une seconde guerre des Sables changeants ne se déclenche.",
},
[29] = {
["ZoneName"] = "Ruines d'Ahn'Qiraj",
["Location"] = "Silithus",
["LevelRange"] = "60+",
["PlayerLimit"] = "20",
["texture"] = "RuinsofAhnQiraj",
		["infoline"] = "Au cours des instants finaux de la guerre des Sables changeants, les forces combinées des elfes de la nuit et des quatre vols de dragon poussèrent la bataille jusqu'au cœur même de l'empire qiraji, dans la cité forteresse d'Ahn'Qiraj. Toutefois, alors qu'elles étaient aux portes de la cité, les armées de Kalimdor rencontrèrent une concentration de silithides guerriers plus importante que tout ce qu'elles avaient affronté auparavant. Finalement, les silithides et leurs maîtres qiraji ne furent point défaits, mais seulement emprisonnés derrière une barrière magique ; et la guerre laissa en ruines la cité maudite. Un millier d'années a passé depuis ce jour mais les forces qiraji ne sont pas restées inactives. Une nouvelle et terrible armée est née des ruches, et les ruines d'Ahn'Qiraj grouillent à nouveau de nuées de silithides et de qiraji. Cette menace doit être éliminée ou tout Azeroth pourrait tomber devant la puissance terrifiante de la nouvelle armée qiraji.",
},
[30] = {
["ZoneName"] = "Naxxramas",
["Location"] = "Eastern Plaguelands",
["LevelRange"] = "60+",
["PlayerLimit"] = "40",
["texture"] = "Naxxramas",
		["infoline"] = "Flottant au-dessus des Maleterres, la nécropole de Naxxramas sert de résidence à l'un des plus puissants serviteurs du roi-liche, la terrible liche Kel'Thuzad. Des horreurs venues du passé s'y rassemblent, rejoignant de nouvelles terreurs encore inconnues du reste du monde. Les serviteurs du roi-liche se préparent à l'assaut. Le Fléau est en marche... Naxxramas est un nouveau donjon de raid pour 40 personnes. Il représentera un défi épique pour les personnages-joueurs les plus puissants et les plus expérimentés.",
},
};

end
