-- Deutsche Lokalisierung von oneofamillion aka Cyrdhan / Alexstrasza
-- hoffentlich sind nicht zu viele Fehler drin...

-- mind the Umlauts !!!
-- Ä: C3 84 - \195\132
-- Ö: C3 96 - \195\150
-- Ü: C3 9C - \195\156
-- ß: C3 9F - \195\159
-- ä: C3 A4 - \195\164
-- ö: C3 B6 - \195\182
-- ü: C3 BC - \195\188

if (GetLocale() == "deDE") then

-- General
METAMAP_CATEGORY = "Interface";
METAMAP_SUBTITLE = "WorldMap Mod";
METAMAP_DESC = "MetaMap ist eine Erweiterung der standard Weltkarte.";
METAMAP_OPTIONS_BUTTON = "Optionen";
METAMAP_STRING_LOCATION = "Ort";
METAMAP_STRING_LEVELRANGE = "Stufen";
METAMAP_STRING_PLAYERLIMIT = "Max. Spieleranzahl";
METAMAP_MAPLIST_INFO = "LeftClick: Ping Note\nRightClick: Edit Note\nCTRL+Click: Loot Table";
METAMAP_BUTTON_TOOLTIP1 = "Links-Klick f\195\188r Karte";
METAMAP_BUTTON_TOOLTIP2 = "Rechts-Klick f\195\188r Optionen";
METAMAP_OPTIONS_TITLE = "MetaMap Optionen";
METAMAP_KB_TEXT = "Knowledge Base"
METAMAP_HINT = "Hinweis: Links-klick \195\182ffnet MetaMap.\nRechts-klick \195\182ffnet Optionen";
METAMAP_NOTES_SHOWN = "Notizen"
METAMAP_LINES_SHOWN = "Lines"
METAMAP_INFOLINE_HINT1 = "LeftClick to toggle StoryLine";
METAMAP_INFOLINE_HINT2 = "RightClick to toggle SideList";
BINDING_HEADER_METAMAP_TITLE = "MetaMap";
BINDING_NAME_METAMAP_MAPTOGGLE = "Toggle WorldMap";
BINDING_NAME_METAMAP_MAPTOGGLE1 = "WorldMap Mode 1";
BINDING_NAME_METAMAP_MAPTOGGLE2 = "WorldMap Mode 2";
BINDING_NAME_METAMAP_FSTOGGLE = "Toggle FullScreen";
BINDING_NAME_METAMAP_SAVESET = "Toggle Map Mode";
BINDING_NAME_METAMAP_KB = "Toggle Database Display"
BINDING_NAME_METAMAP_KB_TARGET_UNIT = "Capture Target Details";
BINDING_NAME_METAMAP_QUICKNOTE = "Set Quick Note";

-- Commands
METAMAPNOTES_ENABLE_COMMANDS = { "/mapnote" }
METAMAPNOTES_ONENOTE_COMMANDS = { "/onenote", "/allowonenote", "/aon" }
METAMAPNOTES_MININOTE_COMMANDS = { "/nextmininote", "/nmn" }
METAMAPNOTES_MININOTEONLY_COMMANDS = { "/nextmininoteonly", "/nmno" }
METAMAPNOTES_MININOTEOFF_COMMANDS = { "/mininoteoff", "/mno" }
METAMAPNOTES_QUICKNOTE_COMMANDS = { "/quicknote", "/qnote", "/qtloc" }

-- Interface Configuration
METAMAP_MENU_MODE = "Menu on Click";
METAMAP_OPTIONS_EXT = "Extended Options";
METAMAP_OPTIONS_COORDS = "Zeige Koordinaten";
METAMAP_OPTIONS_MINICOORDS = "Zeige MiniMap Koordinaten";
METAMAP_OPTIONS_SHOWAUTHOR = "Notizen anzeigen sch\195\182pfer"
METAMAP_OPTIONS_SHOWNOTES = "Notes Filter"
METAMAP_OPTIONS_FILTERON = "Show All"
METAMAP_OPTIONS_FILTEROFF = "Hide All"
METAMAP_OPTIONS_SHOWBUT = "Minimap Schalter anzeigen";
METAMAP_OPTIONS_AUTOSEL = "Autowrap Tooltip Text";
METAMAP_OPTIONS_BUTPOS = "MetaMap Schalterposition";
METAMAP_OPTIONS_POI = "Set POI when entering new zone (Points Of Interest)";
METAMAP_OPTIONS_LISTCOLORS = "Use coloured Sidelist";
METAMAP_OPTIONS_ZONEHEADER = "Show Zone information in WorldMap header";
METAMAP_OPTIONS_MOZZ = "Show Unexplored";
METAMAP_OPTIONS_TRANS = "Kartentransparenz";
METAMAP_OPTIONS_SHADER = "BackDrop Shader";
METAMAP_OPTIONS_SHADESET = "Instance Backdrop Shade";
METAMAP_OPTIONS_FWM = "Show Unexplored Areas";
METAMAP_OPTIONS_DONE = "Fertig";
METAMAP_FLIGHTMAP_OPTIONS = "FlightMap Optionen";
METAMAP_GATHERER_OPTIONS = "Gatherer Optionen";
METAMAP_BWP_OPTIONS = "Set a Waypoint";
METAMAP_OPTIONS_SCALE = "Map Scale";
METAMAP_OPTIONS_TTSCALE = "Tooltip Scale";
METAMAP_OPTIONS_SAVESET = "Map Display Mode";
METAMAP_OPTIONS_USEMAPMOD = "Create notes with MapMod";
METAMAP_ACTION_MODE = "Allow clicks through map";
METAMAPLIST_SORTED = "Sorted List";
METAMAPLIST_UNSORTED = "Unsorted List";
METAMAP_CLOSE_BUTTON ="Schlie\195\159en";

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

METAMAPNOTES_WORLDMAP_HELP_1 = "Rechts-Klicken um aus der Karte zu zoomen"
METAMAPNOTES_WORLDMAP_HELP_2 = "<Strg>+Links-Klicken an Notiz erstellen"
METAMAPNOTES_CLICK_ON_SECOND_NOTE = "W\195\164hle eine zweite Notiz um jene\ndurch eine Linie zu verbinden/Linie wieder zu l\195\182schen."
METAMAPNOTES_CLICK_ON_LOCATION = "Left-Click on map for new note location"

METAMAPNOTES_NEW_NOTE = "Notiz erstellen"
METAMAPNOTES_MININOTE_OFF = "Kurz-Notizen aussch."
METAMAPNOTES_OPTIONS_TEXT = "Notizen Einstellungen"
METAMAPNOTES_CANCEL = "Abbrechen"
METAMAPNOTES_EDIT_NOTE = "Notiz bearbeiten"
METAMAPNOTES_MININOTE_ON = "Als Kurz-Notiz"
METAMAPNOTES_SEND_NOTE = "Notiz senden"
METAMAPNOTES_TOGGLELINE = "Notizen verbinden"
METAMAPNOTES_MOVE_NOTE = "Move Note";
METAMAPNOTES_DELETE_NOTE = "Notiz l\195\182schen"
METAMAPNOTES_SAVE_NOTE = "Speichern"
METAMAPNOTES_EDIT_TITLE = "Titel (erfordert):"
METAMAPNOTES_EDIT_INFO1 = "Info Zeile 1 (optional):"
METAMAPNOTES_EDIT_INFO2 = "Info Zeile 2 (optional):"
METAMAPNOTES_EDIT_CREATOR = "Sch\195\182pfer (optional - leave blank to hide):"

METAMAPNOTES_SEND_MENU = "Notiz Senden"
METAMAPNOTES_SLASHCOMMAND = "Modus wechseln"
METAMAPNOTES_SEND_TIP = "Diese Notiz kann von allen Benutzern der Karten Notizen MetaMap empfangen werden"
METAMAPNOTES_SEND_PLAYER = "Spielername eingeben:"
METAMAPNOTES_SENDTOPLAYER = "An Spieler senden"
METAMAPNOTES_SENDTOPARTY = "An Gruppe senden"
METAMAPNOTES_SHOWSEND = "Modus wechseln"
METAMAPNOTES_SEND_SLASHTITLE = "Slash-Befehle:"
METAMAPNOTES_SEND_SLASHTIP = "Dies markieren und STRG+C dr\195\188cken um in die Zwischenablage zu kopieren.\n(dann kann es zum Beispiel in einem Forum ver\195\182ffentlicht werden)"
METAMAPNOTES_SEND_SLASHCOMMAND = "/Befehl:"
METAMAPNOTES_PARTYSENT = "PartyNote sent to all Party members.";
METAMAPNOTES_RAIDSENT = "PartyNote sent to all Raid members.";
METAMAPNOTES_NOPARTY = "Not currently in a Party or Raid.";

METAMAPNOTES_OWNNOTES = "Notizen anzeigen, die von diesem Charakter erstellt wurden"
METAMAPNOTES_OTHERNOTES = "Notizen anzeigen, die von anderen Spielern empfangen wurden"
METAMAPNOTES_HIGHLIGHT_LASTCREATED = "Zuletzt erstellte Notiz in |cFFFF0000rot|r hervorheben"
METAMAPNOTES_HIGHLIGHT_MININOTE = "Notizen die als Kurz-Notiz markiert wurden in |cFF6666FFblau|r hervorheben"
METAMAPNOTES_ACCEPTINCOMING = "Ankommende Notizen von anderen Spielern akzeptieren"
METAMAPNOTES_AUTOPARTYASMININOTE = "Markiere Gruppen-Notizen automatisch als Kurz-Notiz"
METAMAPNOTES_ZONESEARCH_TEXT = "Delete notes for |cffffffff%s|r by creator:"
METAMAPNOTES_ZONESEARCH_TEXTHINT = "Hint: Open WorldMap and set map to desired area for deletion";
METAMAPNOTES_BATCHDELETE = "This will delete all notes for |cFFFFD100%s|r with creator as |cFFFFD100%s|r.";
METAMAPNOTES_DELETED_BY_NAME = "Deleted selected notes with creator |cFFFFD100%s|r and name |cFFFFD100%s|r."
METAMAPNOTES_DELETED_BY_CREATOR = "Deleted all notes with creator |cFFFFD100%s|r."
METAMAPNOTES_DELETED_BY_ZONE = "Deleted all notes for |cFFFFD100%s|r with creator |cFFFFD100%s|r."


METAMAPNOTES_CREATEDBY = "Erstellt von"
METAMAPNOTES_CHAT_COMMAND_ENABLE_INFO = "Dieser Befehl erlaubt es zum Beispiel Notizen, die von einer Webseite empfangen wurden, einzuf\195\188gen."
METAMAPNOTES_CHAT_COMMAND_ONENOTE_INFO = "\195\156bergeht die Einstellungen, wodurch die n\195\164chste empfangene Notiz in jedem Fall akzeptiert wird."
METAMAPNOTES_CHAT_COMMAND_MININOTE_INFO = "Markiert die n\195\164chste empfangene Notiz direkt als Kurz-Notiz (und f\195\188gt jene auf der Karte ein)."
METAMAPNOTES_CHAT_COMMAND_MININOTEONLY_INFO = "Markiert die n\195\164chste empfangene Notiz nur als Kurz-Notiz (und f\195\188gt jene nicht auf der Karte ein)."
METAMAPNOTES_CHAT_COMMAND_MININOTEOFF_INFO = "Kurz-Notizen nicht mehr anzeigen."
METAMAPNOTES_CHAT_COMMAND_QUICKNOTE = "F\195\188gt auf der momentanen Position auf der Karte eine Notiz ein."
METAMAPNOTES_MAPNOTEHELP = "Dieser Befehl kann nur zum Einf\195\188gen einer Notiz benutzt werden."
METAMAPNOTES_ONENOTE_OFF = "Eine Notiz zulassen: AUS"
METAMAPNOTES_ONENOTE_ON = "Eine Notiz zulassen: AN"
METAMAPNOTES_MININOTE_SHOW_0 = "N\195\164chste als Kurz-Notiz: AUS"
METAMAPNOTES_MININOTE_SHOW_1 = "N\195\164chste als Kurz-Notiz: AN"
METAMAPNOTES_MININOTE_SHOW_2 = "N\195\164chste als Kurz-Notiz: IMMER"
METAMAPNOTES_ACCEPT_NOTE = "Notiz auf der Karte von |cFFFFD100%s|r hinzugef\195\188gt."
METAMAPNOTES_DECLINE_NOTE = "Notiz kann nicht hinzugef\195\188gt werden, sie befindet sich zu nahe an |cFFFFD100%q|r in |cFFFFD100%s|r."
METAMAPNOTES_ACCEPT_MININOTE = "MiniNote set for the map of |cFFFFD100%s|r.";
METAMAPNOTES_DECLINE_GET = "|cFFFFD100%s|r hat versucht dir in |cFFFFD100%s|r eine Notiz zu senden, aber jene war zu nahe bei |cFFFFD100%q|r."
METAMAPNOTES_DISABLED_GET = "Notiz von |cFFFFD100%s|r konnte nicht empfangen werden: Empfang in den Einstellungen deaktiviert."
METAMAPNOTES_ACCEPT_GET = "Notiz von |cFFFFD100%s|r in |cFFFFD100%s|r empfangen."
METAMAPNOTES_PARTY_GET = "|cFFFFD100%s|r hat eine neue Gruppen-Notiz in |cFFFFD100%s|r hinzugef\195\188gt."
METAMAPNOTES_NOTE_SENT = "Note sent to |cFFFFD100%s|r."
METAMAPNOTES_QUICKNOTE_DEFAULTNAME = "Schnell-Notiz"
METAMAPNOTES_MININOTE_DEFAULTNAME = "Kurz-Notiz"
METAMAPNOTES_VNOTE_DEFAULTNAME = "VirtualNote"
METAMAPNOTES_SETMININOTE = "Setzt die Notiz als neue Kurz-Notiz."
METAMAPNOTES_PARTYNOTE = "Gruppen-Notiz"
METAMAPNOTES_SETCOORDS = "Coords (xx,yy):"
METAMAPNOTES_VNOTE = "Virtual"
METAMAPNOTES_VNOTE_INFO = "Creates a virtual note. Save on map of choice to bind."
METAMAPNOTES_VNOTE_SET = "Virtual note created on the World Map."
METAMAPNOTES_MININOTE_INFO = "Creates a note on the Minimap only."
METAMAPNOTES_INVALIDZONE = "Could not create - no player coords available in this zone.";

-- Buttons, Headers, Various Text
METAMAPNOTES_WARSONGGULCH = "Warsongschlucht"
METAMAPNOTES_ALTERACVALLEY = "Alteractal"
METAMAPNOTES_ARATHIBASIN = "Arathibecken"

-- Game Data
MetaMap_Data = {
[1] = {
["ZoneName"] = "Blackfathom-Tiefe",
["Location"] = "Ashenvale",
["LevelRange"] = "24-32",
["PlayerLimit"] = "10",
["texture"] = "BlackfathomDeeps",
		["infoline"] = "Die Blackfathom-Tiefen in der N\195\164he des Zoramstrandes in Ashenvale waren vor langer Zeit ein Tempel, den die Nachtelfen zu Ehren ihrer Mondg\195\182ttin Elune erbaut hatten. Doch als die Welt gespalten wurde versank der Tempel in den Fluten des verh\195\188llten Meeres. Dort ruhte er lange Zeit ungest\195\182rt, bis eines Tages die Naga und Satyrn auftauchten, angezogen von seiner uralten Kraft, um die Geheimnisse des Tempels zu ergr\195\188nden. Legenden zufolge soll das uralte Wesen Aku’mai sich ebenfalls in den Ruinen niedergelassen haben. Das liebste Scho\195\159tier der urzeitlichen G\195\182tter ist schon oft auf Beutez\195\188gen in der Gegend gesichtet worden. Die Gegenwart von Aku’mai hat auch einen Kult mit Namen Twilight’s Hammer angezogen, der sich die b\195\182sen M\195\164chte der Alten G\195\182tter zunutze machen will.",
},
[2] = {
["ZoneName"] = "Blackrocktiefen",
["Location"] = "Blackrock",
["LevelRange"] = "52+",
["PlayerLimit"] = "5",
["texture"] = "BlackrockDepths",
		["infoline"] = "In dem vulkanischen Labyrinth, das von der einstigen Hauptstadt der Zwerge des D\195\188stereisenklans \195\188briggeblieben ist, herrscht nun Ragnaros der Feuerf\195\188rst \195\188ber die Abgr\195\188nde des Blackrock. Ragnaros ist es gelungen, das Geheimnis zu l\195\188ften, wie Leben aus Stein erschaffen werden kann. Nun plant er, sein neu gewonnenes Wissen dazu einzusetzen, eine Armee unaufhaltsamer Golems zu schaffen, die ihm bei der Eroberung des Blackrock helfen sollen. Vollkommen besessen von dem Gedanken daran, Nefarian endlich zu vernichten, wird Ragnaros alles tun, um seinen Konkurrenten aus dem Weg zu r\195\164umen.",
},
[3] = {
["ZoneName"] = "Blackrockspitze",
["Location"] = "Blackrock",
["LevelRange"] = "55+",
["PlayerLimit"] = "10",
["texture"] = "BlackrockSpireLower",
		["infoline"] = "Die m\195\164chtige Festung, die aus der feurigen Flanke des Blackrock herausgeschnitten wurde, geht auf Entw\195\188rfe des zwergischen Meistersteinmetzes Franclorn Forgewright zur\195\188ck. Jahrhunderte lang war die Zitadelle ein Symbol der Macht des D\195\188stereisenklans, das von den Zwergen mit \195\164u\195\159erstem Ingrimm verteidigt wurde. Allerdings gab es jemanden, der andere Pl\195\164ne f\195\188r die Zitadelle hatte: Nefarian, der listige Sohn des Drachen Deathwing, stieg eines Tages mit Flamme und Klaue auf den oberen Teil der Zitadelle hinab und trug zusammen mit seinen drachischen Untergebenen den Kampf bis zu den Stellungen der Zwerge tief unten, bei den vulkanischen Abgr\195\188nden unter dem Berg. Dort erkannte der Drache, dass der Anf\195\188hrer der Zwerge kein geringerer als der Feuerf\195\188rst Ragnaros h\195\182chstpers\195\182nlich war. Nachdem sein Vordringen gestoppt worden war, schwor sich Nefarian, seine Feinde endg\195\188ltig zu vernichten und somit die Herrschaft \195\188ber den Blackrock an sich zu rei\195\159en.",
},
[4] = {
["ZoneName"] = "Blackrockspitze(Oben)",
["Location"] = "Blackrock",
["LevelRange"] = "58+",
["PlayerLimit"] = "10",
["texture"] = "BlackrockSpireUpper",
		["infoline"] = "Die m\195\164chtige Festung, die aus der feurigen Flanke des Blackrock herausgeschnitten wurde, geht auf Entw\195\188rfe des zwergischen Meistersteinmetzes Franclorn Forgewright zur\195\188ck. Jahrhunderte lang war die Zitadelle ein Symbol der Macht des D\195\188stereisenklans, das von den Zwergen mit \195\164u\195\159erstem Ingrimm verteidigt wurde. Allerdings gab es jemanden, der andere Pl\195\164ne f\195\188r die Zitadelle hatte: Nefarian, der listige Sohn des Drachen Deathwing, stieg eines Tages mit Flamme und Klaue auf den oberen Teil der Zitadelle hinab und trug zusammen mit seinen drachischen Untergebenen den Kampf bis zu den Stellungen der Zwerge tief unten, bei den vulkanischen Abgr\195\188nden unter dem Berg. Dort erkannte der Drache, dass der Anf\195\188hrer der Zwerge kein geringerer als der Feuerf\195\188rst Ragnaros h\195\182chstpers\195\182nlich war. Nachdem sein Vordringen gestoppt worden war, schwor sich Nefarian, seine Feinde endg\195\188ltig zu vernichten und somit die Herrschaft \195\188ber den Blackrock an sich zu rei\195\159en.",
},
[5] = {
["ZoneName"] = "Pechschwingenhort",
["Location"] = "Blackrockspitze",
["LevelRange"] = "60+",
["PlayerLimit"] = "40",
["texture"] = "BlackwingLair",
		["infoline"] = "Nefarians Heiligtum, der Pechschwingenhort, befindet sich am h\195\182chsten Punkt der Zitadelle des Blackrock. Dort, in den finsteren Nischen der zerkl\195\188fteten Bergspitze, setzt Nefarian nun die letzten Schritte seines teuflischen Plans in Gang, um Ragnaros ein f\195\188r allemal zu vernichten und mit seiner Armee die Herrschaft \195\188ber alle V\195\182lker Azeroths an sich zu rei\195\159en. Nefarian will Ragnaros um jeden Preis vernichten. Zu diesem Zweck hat er vor kurzem damit begonnen, seine Macht auszuweiten, so wie sein Vater Deathwing es bereits vor langer Zeit versucht hat. Der berechnende Nefarian scheint allerdings dort Erfolg zu haben, wo sein Vater einst versagte. Nefarians krankes D\195\188rsten nach \195\156berlegenheit hat inzwischen auch den Zorn des roten Drachenschwarms auf sich gezogen, der gef\195\164hrlichsten Feinde des schwarzen Drachenschwarms. Obwohl Nefarians Absichten bekannt sind, bleibt seine Vorgehensweise jedoch ein Geheimnis. Man sagt, dass Nefarian mit dem Blut aller Drachenschw\195\164rme experimentiert, um unaufhaltsame Krieger zu erschaffen.",
},
[6] = {
["ZoneName"] = "D\195\188sterbruch",
["Location"] = "Feralas",
["LevelRange"] = "56-60",
["PlayerLimit"] = "5",
["texture"] = "DireMaul",
		["infoline"] = "Vor fast zw\195\182lftausend Jahren errichtete eine geheime Sekte nachtelfischer Zauberer die uralte Stadt Eldre’Thalas, um die wertvollsten Geheimnisse von K\195\182nigin Azshara zu sch\195\188tzen. Selbst die Ruinen der Stadt, die w\195\164hrend der Spaltung der Welt verw\195\188stet wurde, sind immer noch \195\164u\195\159erst beeindruckend und ehrfurchtgebietend. In den drei Fl\195\188geln der Stadt, die heute nur noch als der D\195\188sterbruch bekannt ist, haben sich inzwischen die seltsamsten Kreaturen niedergelassen – besonders die spektralen Hochgeborenen, die hinterh\195\164ltigen Satyrn und die brutalen Oger. Nur die mutigsten Abenteurer sollten sich dieser verfluchten Ruine n\195\164hern und die unglaublichen Schrecken herausfordern, die hinter den verfallenen Mauern lauern.",
},
[7] = {
["ZoneName"] = "D\195\188sterbruch (Ost)",
["Location"] = "Feralas",
["LevelRange"] = "56-60",
["PlayerLimit"] = "5",
["texture"] = "DireMaulEast",
		["infoline"] = "Vor fast zw\195\182lftausend Jahren errichtete eine geheime Sekte nachtelfischer Zauberer die uralte Stadt Eldre’Thalas, um die wertvollsten Geheimnisse von K\195\182nigin Azshara zu sch\195\188tzen. Selbst die Ruinen der Stadt, die w\195\164hrend der Spaltung der Welt verw\195\188stet wurde, sind immer noch \195\164u\195\159erst beeindruckend und ehrfurchtgebietend. In den drei Fl\195\188geln der Stadt, die heute nur noch als der D\195\188sterbruch bekannt ist, haben sich inzwischen die seltsamsten Kreaturen niedergelassen – besonders die spektralen Hochgeborenen, die hinterh\195\164ltigen Satyrn und die brutalen Oger. Nur die mutigsten Abenteurer sollten sich dieser verfluchten Ruine n\195\164hern und die unglaublichen Schrecken herausfordern, die hinter den verfallenen Mauern lauern.",
},
[8] = {
["ZoneName"] = "D\195\188sterbruch (Nord)",
["Location"] = "Feralas",
["LevelRange"] = "56-60",
["PlayerLimit"] = "5",
["texture"] = "DireMaulNorth",
		["infoline"] = "Vor fast zw\195\182lftausend Jahren errichtete eine geheime Sekte nachtelfischer Zauberer die uralte Stadt Eldre’Thalas, um die wertvollsten Geheimnisse von K\195\182nigin Azshara zu sch\195\188tzen. Selbst die Ruinen der Stadt, die w\195\164hrend der Spaltung der Welt verw\195\188stet wurde, sind immer noch \195\164u\195\159erst beeindruckend und ehrfurchtgebietend. In den drei Fl\195\188geln der Stadt, die heute nur noch als der D\195\188sterbruch bekannt ist, haben sich inzwischen die seltsamsten Kreaturen niedergelassen – besonders die spektralen Hochgeborenen, die hinterh\195\164ltigen Satyrn und die brutalen Oger. Nur die mutigsten Abenteurer sollten sich dieser verfluchten Ruine n\195\164hern und die unglaublichen Schrecken herausfordern, die hinter den verfallenen Mauern lauern.",
},
[9] = {
["ZoneName"] = "D\195\188sterbruch (West)",
["Location"] = "Feralas",
["LevelRange"] = "56-60",
["PlayerLimit"] = "5",
["texture"] = "DireMaulWest",
		["infoline"] = "Vor fast zw\195\182lftausend Jahren errichtete eine geheime Sekte nachtelfischer Zauberer die uralte Stadt Eldre’Thalas, um die wertvollsten Geheimnisse von K\195\182nigin Azshara zu sch\195\188tzen. Selbst die Ruinen der Stadt, die w\195\164hrend der Spaltung der Welt verw\195\188stet wurde, sind immer noch \195\164u\195\159erst beeindruckend und ehrfurchtgebietend. In den drei Fl\195\188geln der Stadt, die heute nur noch als der D\195\188sterbruch bekannt ist, haben sich inzwischen die seltsamsten Kreaturen niedergelassen – besonders die spektralen Hochgeborenen, die hinterh\195\164ltigen Satyrn und die brutalen Oger. Nur die mutigsten Abenteurer sollten sich dieser verfluchten Ruine n\195\164hern und die unglaublichen Schrecken herausfordern, die hinter den verfallenen Mauern lauern.",
},
[10] = {
["ZoneName"] = "Gnomeregan",
["Location"] = "Dun Morogh",
["LevelRange"] = "29-38",
["PlayerLimit"] = "10",
["texture"] = "Gnomeregan",
		["infoline"] = "Gnomeregan war seit ungez\195\164hlten Generationen die Hauptstadt der Gnome, eine Stadt, wie es sie davor noch nie in Azeroth gegeben hatte, wo selbst die k\195\188hnsten Tr\195\164ume der gnomischen T\195\188ftler wahr wurden. Die Wellen der j\195\188ngsten Invasion der mutierten Troggs in Dun Morogh erreichten schlie\195\159lich auch die Wunderwelt der Gnome. In einem Akt der Verzweiflung befahl Hocht\195\188ftler Mekkatorque, die Tanks f\195\188r den radioaktiven Abfall der Stadt nach Gnomeregan zu entleeren und so die Troggs zu vernichten. Viele Gnome brachten sich vor den radioaktiven D\195\164mpfen und dem Giftm\195\188ll in Sicherheit und warteten darauf, dass die Troggs entweder starben oder flohen. Doch statt zu sterben oder zu fliehen, verwandelten sich die mutierten, brutalen Troggs in mutierte, brutale und radioaktive Troggs, die nun obendrein noch w\195\188tender waren als zuvor (sofern das \195\188berhaupt m\195\182glich war). Die Gnome, die nicht von der Radioaktivit\195\164t oder den Toxinen get\195\182tet wurden, mussten fliehen und in der nahegelegenen Stadt Ironforge Schutz suchen. Dort ist Hocht\195\188ftler Mekkatorque momentan dabei, tapfere Helden f\195\188r die Zur\195\188ckeroberung der gnomischen Hauptstadt zu suchen. Ger\195\188chten zufolge soll Mekkatorques ehemaliger Berater, der Robogenieur Thermaplug, sein Volk verraten haben, indem er die Invasion geschehen liess. Der wahnsinnige Gnom ist in Gnomeregan zur\195\188ckgeblieben, wo der Technof\195\188rst nun neue sinistre Pl\195\164ne aust\195\188ftelt.",
},
[11] = {
["ZoneName"] = "Maraudon",
["Location"] = "Desolace",
["LevelRange"] = "46-55",
["PlayerLimit"] = "10",
["texture"] = "Maraudon",
		["infoline"] = "Maraudon, eine der heiligsten St\195\164tten in Desolace, wird von den wilden Maraudinezentauren besch\195\188tzt. Der gro\195\159e Tempel ist die letzte Ruhest\195\164tte von Zaetar, einem der zwei unsterblichen S\195\182hne des Halbgottes Cenarius. Die Legende besagt, dass Zaetar zusammen mit Theradras, der Prinzessin der Erdelementare, das missgestaltete Volk der Zentauren in die Welt setzte. Man sagt, dass die barbarischen Zentauren, als sie sich ihrer abscheulichen Gestalt gewahr wurden, sich von wildem Zorn beseelt auf ihren Vater st\195\188rzten und ihn ermordeten. Einige glauben, dass Theradras in ihrer Trauer den Geist von Zaetar in den gewundenen H\195\182hlen von Maraudon einfing und seine Energien f\195\188r einen b\195\182sartigen Zweck missbrauchte. Die Tunnels des Heligtums sind nun das Zuhause der finsteren Geister l\195\164ngst verstorbener Zentauren und Theradras eigener elementarer Diener.",
},
[12] = {
["ZoneName"] = "Der Geschmolzene Kern",
["Location"] = "Blackrocktiefen",
["LevelRange"] = "60+",
["PlayerLimit"] = "40",
["texture"] = "MoltenCore",
		["infoline"] = "Der geschmolzene Kern befindet sich am tiefsten Punkt des Blackrock. Genau hier, im Herzen des Berges, beschwor Imperator Thaurissan vor langer Zeit in einem Akt der Verzweiflung den elementaren Feuerf\195\188rsten Ragnaros, um seinen gescheiterten Putsch gegen die Zwerge von Ironforge doch noch in einen Sieg zu verwandeln. Obwohl der Feuerf\195\188rst immer in der N\195\164he des feurigen Kerns bleiben muss, treiben seine Offiziere die Dunkeleisenzwerge gnadenlos dazu an, ihm eine Armee aus lebendem Gestein zu erschaffen. Der See aus Magma, in dem Ragnaros schl\195\164ft, ist in Wirklichkeit ein interplanarer Riss, durch den b\195\182sartige Feuerelementare von der Ebene des Feuers nach Azeroth gelangen. Der h\195\182chstrangige von Ragnaros' Untergebenen ist Majordomo Executus, der als einziger in der Lage ist, den schlafenden Feuerf\195\188rsten zu wecken.",
},
[13] = {
["ZoneName"] = "Onyxias Hort",
["Location"] = "Marschen von Dustwallow",
["LevelRange"] = "60+",
["PlayerLimit"] = "40",
["texture"] = "OnyxiasLair",
		["infoline"] = "Onyxia ist die Tochter des m\195\164chtigen Drachen Deathwing und die Schwester des gerissenen Nefarian, dem F\195\188rsten des Blackrock. Selbst f\195\188r einen Drachen ist Onyxia \195\164u\195\159erst intelligent, und sie nimmt gerne die Form einer Sterblichen an, um sich heimlich in die politischen Angelegenheiten der sterblichen V\195\182lker einzumischen. Obwohl sie f\195\188r einen schwarzen Drachen ihres Alters recht klein ist, verf\195\188gt sie dennoch \195\188ber die gleichen Kr\195\164fte und F\195\164higkeiten wie der Rest ihres f\195\188rchterlichen Schwarms. Manche sagen, Onyxia habe sogar eine Tarnidentit\195\164t ihres Vaters \195\188bernommen - den Titel des k\195\182niglichen Hauses Prestor. Wenn sie sich nicht in den Angelegenheiten der Sterblichen einmischt, ruht Onyxia in einer feurigen H\195\182hle unterhalb des Drachensumpfes, einer unwirtlichen Gegend der Marschen von Dustwallow. Dort wird sie von ihren Gefolgsleuten bewacht, den verbleibenden Mitgliedern des grausamen schwarzen Drachenschwarms",
},
[14] = {
["ZoneName"] = "Ragefireabgrund",
["Location"] = "Orgrimmar",
["LevelRange"] = "13-15",
["PlayerLimit"] = "10",
["texture"] = "RagefireChasm",
		["infoline"] = "Der Ragefireabgrund besteht aus einer Reihe vulkanischer H\195\182hlen, die unter Orgrimmar verlaufen, der neuen Hauptstadt der Orcs. Vor nicht allzulanger Zeit soll sich in den feurigen Tiefen ein Kult eingenistet haben, der dem d\195\164monischen Schattenrat nahe steht. Dieser Kult, der sich selbst die Burning Blade nennt, stellt eine direkte Bedrohung der Unabh\195\164ngigkeit von Orgrimmar dar. Viele glauben, dass Kriegsh\195\164uptling Thrall die Burning Blade nur deshalb nicht sofort ausl\195\182scht, weil er sich erhofft, dass sie ihn direkt zu seinem wahren Feind f\195\188hren werden, dem mysteri\195\182sen Schattenrat selbst. Dennoch k\195\182nnten die dunklen M\195\164chte, die sich im Ragefireabgrund sammeln, alles zerst\195\182ren, was die Orcs mit so viel Blut und Leid erk\195\164mpft haben.",
},
[15] = {
["ZoneName"] = "H\195\188gel von Razorfen",
["Location"] = "Brachland",
["LevelRange"] = "33-40",
["PlayerLimit"] = "10",
["texture"] = "RazorfenDowns",
		["infoline"] = "Die H\195\188gel von Razorfen, die von den selben dornigen Ranken wie der Kral von Razorfen dominiert werden, beherbergen seit jeher die Hauptstadt des Volks der Stacheleber. In dem weitl\195\164ufigen, dornenverseuchten Labyrinth h\195\164lt sich eine riesige Armee wilder Stacheleberkrieger auf, die ihr Leben darauf geschworen haben, ihre Hohepriester – die Mitglieder des Totenkopfstammes – um jeden Preis zu besch\195\188tzen. Vor Kurzem hat sich jedoch ein unheilbringender Schatten \195\188ber den kruden Bau gelegt. Abgesandte der untoten Gei\195\159el unter der F\195\188hrung des Lichs Amnennar der K\195\164ltebringer haben die Kontrolle \195\188ber das Volk der Stacheleber \195\188bernommen und das Labyrinth der Dornen in eine vorgeschobene Bastion untoter Macht verwandelt. Nun k\195\164mpfen die Stacheleber einen verzweifelten Kampf gegen die Zeit, denn Amnennars Einfluss dehnt sich jeden Tag weiter aus. Wenn er nicht aufgehalten wird, ist es nur eine Frage der Zeit, bis das Banner der Gei\195\159el \195\188ber dem Brachland wehen wird.",
},
[16] = {
["ZoneName"] = "Kral von Razorfen",
["Location"] = "Brachland",
["LevelRange"] = "25-30",
["PlayerLimit"] = "10",
["texture"] = "RazorfenKraul",
		["infoline"] = "Vor zehntausend Jahren, zum H\195\182hepunkt des Kriegs der Uralten, betrat der m\195\164chtige Halbgott Agamaggan das Schlachtfeld, um sich der Brennenden Legion entgegenzustellen. Seinen Beitrag zur Rettung Azeroths vor dem sicheren Untergang musste der stolze Eber jedoch mit seinem Leben bezahlen. Im Lauf der Zeit sprossen dort, wo die Tropfen seines Blutes auf die Erde gefallen waren, gewaltige Dornenranken. Die Stacheleber, die sterblichen Nachkommen des m\195\164chtigen Gottes, siedelten sich dort an und betrachten den Kral bis zum heutigen Tag als ihr h\195\182chstes Heiligtum, dessen Herz der Razorfen (Klingenbusch) genannt wird. Heute wird der gr\195\182\195\159te Teil des Krals von Razorfen von der alten Stammesf\195\188rstin Charlga Razorflank und ihrem Stamm kontrolliert. Unter ihrer F\195\188hrung greifen die schamanistischen Stacheleber regelm\195\164\195\159ig sowohl die feindlichen St\195\164mme als auch nahegelegene Siedlungen der Orcs und Tauren an. In j\195\188ngster Zeit gab es Hinweise, die auf einen m\195\182glichen Pakt zwischen Charlga und den Agenten der untoten Gei\195\159el hindeuten. Kann es tats\195\164chlich sein, dass die Uralte ihren nichtsahnenden Stamm zu irgendeinem finsteren Zweck direkt in die Arme der Untoten treibt?",
},
[17] = {
["ZoneName"] = "Das scharlachrote Kloster",
["Location"] = "Tirisfal",
["LevelRange"] = "34-45",
["PlayerLimit"] = "10",
["texture"] = "ScarletMonastery",
		["infoline"] = "Das Kloster war einst der ganze Stolz der Priesterschaft von Lordaeron, ein Ort der Studien und der Erleuchtung. Doch seit dem Auftauchen der untoten Gei\195\159el w\195\164hrend des Dritten Krieges wurde das friedliche Kloster in eine Festung des fanatischen Scharlachroten Kreuzzuges verwandelt. Die Kreuzritter zeigen gegen\195\188ber allen nichtmenschlichen V\195\182lkern nicht den geringsten Funken von Toleranz oder Achtung, egal auf welcher Seite sie stehen m\195\182gen. Sie glauben, dass alle Au\195\159enseiter potentielle \195\156bertr\195\164ger der Seuche des Untodes sind und deswegen vernichtet werden m\195\188ssen. Berichten \195\156berlebender zufolge m\195\188ssen sich Eindringlinge darauf gefasst machen, dem Scharlachroten Kommandanten Mograine entgegenzutreten, der zudem \195\188ber eine gro\195\159e Streitmacht ihm fanatisch ergebener Krieger gebietet. Der wahre Herr \195\188ber das Scharlachrote Kloster ist jedoch Hochinquisitor Whitemane – eine furchteinfl\195\182\195\159ende Priesterin, die \195\188ber die einzigartige Gabe verf\195\188gt, gefallene K\195\164mpfer in ihrem Namen ins Kampfgeschehen zur\195\188ckholen zu k\195\182nnen.",
},
[18] = {
["ZoneName"] = "Scholomance",
["Location"] = "Westliche Pestl\195\164nder",
["LevelRange"] = "56-60",
["PlayerLimit"] = "5",
["texture"] = "Scholomance",
		["infoline"] = "Die Scholomance ist ein weitl\195\164ufiges Netzwerk unterirdischer Krypten, das sich unter der verfallenen Burg Caer Darrow erstreckt. Caer Darrow war fr\195\188her im Besitz der Barovs, einer alten Adelsfamilie, doch w\195\164hrend des Zweiten Krieges verfiel die Burg und wurde zu einer Ruine. Eine g\195\164ngige Methode, mit der Kel’thuzad neue Anh\195\164nger f\195\188r seinen Kult der Verdammten warb, war es, potentiellen Neuzug\195\164ngen im Austausch gegen ihre Dienste f\195\188r den Lichk\195\182nig die Unsterblichkeit zu versprechen. Die Barovs fielen auf Kel’thuzads charismatischen Schwindel herein und \195\188berlie\195\159en die Burg und die dazugeh\195\182rigen Krypten der Gei\195\159el. Im Gegenzug t\195\182teten die Kultisten die Barovs und machten aus den uralten Gew\195\182lben eine Schule der Nekromantie, die sie die Scholomance tauften. Auch wenn Kel’thuzad schon lange nicht mehr in den Krypten weilt, verbleiben dennoch viele Kultisten und Lehrmeister in der Scholomance. Der m\195\164chtige Lich Ras Frostwhisper verteidigt die Scholomance im Namen der Gei\195\159el gegen alle, die unbefugterweise einen Fu\195\159 \195\188ber ihre Schwelle setzen, w\195\164hrend Dunkelmeister Gandling als der hinterh\195\164ltige Direktor der Schule f\195\188r Ordnung unter den Lernenden sorgt.",
},
[19] = {
["ZoneName"] = "Burg Shadowfang",
["Location"] = "Silberwald",
["LevelRange"] = "22-30",
["PlayerLimit"] = "10",
["texture"] = "ShadowfangKeep",
		["infoline"] = "W\195\164hrend des Dritten Krieges k\195\164mpften die Hexer der Kirin Tor gegen die untoten Armeen der Gei\195\159el. Mit jedem Hexer, der im Kampf fiel, stand kurze Zeit sp\195\164ter bereits ein weiterer Untoter auf Seiten der Gei\195\159el seinen einstmaligen Mitstreitern als Feind gegen\195\188ber. Frustriert \195\188ber den aussichtslosen Kampf beschloss der Erzmagier Arugal gegen den Willen seiner Kollegen, Wesen aus einer fremden Dimension zu Hilfe zu rufen um die schwindenden Reihen der Hexer zu st\195\164rken. Arugals Beschw\195\182rung brachte die gefr\195\164\195\159igen Worgen nach Azeroth. Zwar machten die unaufhaltsamen Werw\195\182lfe kurzen Prozess mit allem, was die Gei\195\159el ihnen entgegenstellte, doch nach kurzer Zeit wandten sie sich auch gegen die Magier, denen sie eigentlich dienen sollten. So kam es, dass die Worgen die Burg des adligen Barons Silverlaine jenseits des unscheinbaren D\195\182rfchens Pyrewood angriffen. Von Schuldgef\195\188hlen halb wahnsinnig adoptierte Arugal die Worgen als seine Kinder und zog sich in die inzwischen verfallene Burgruine zur\195\188ck. Dort soll er immer noch hausen, unter dem immer wachsamen Auge seines gewaltigen Scho\195\159hundes Fenrus, heimgesucht von dem rastlosen Geist von Baron Silverlaine.",
},
[20] = {
["ZoneName"] = "Stratholme",
["Location"] = "\195\182stliche Pestl\195\164nder",
["LevelRange"] = "55-60",
["PlayerLimit"] = "5",
["texture"] = "Stratholme",
		["infoline"] = "Einst war Stratholme das Juwel von Lordaeron, aber es ist schon lange her, dass jemand die Stadt bei diesem Namen genannt hat. Hier, an genau diesem Ort, vollzog sich der Anfang des Untergangs von Lordaeron, als sich Arthas gegen seinen Mentor Uther Lightbringer wandte und hunderte treu ergebener Untertanen, die angeblich mit der Seuche des Untodes in Ber\195\188hrung gekommen waren, ohne jegliches Erbarmen zur Schlachtbank f\195\188hrte. Dies war der erste Schritt auf Arthas langer Reise abw\195\164rts in die finstersten Abgr\195\188nde der menschlichen Seele, die ihn schlie\195\159lich in die offenen Arme des Lichk\195\182nigs trieb. Stratholme ist nun unter der Verwaltung des m\195\164chtigen Lichs Kel’thuzad eine Festung der untoten Gei\195\159el. Ein Teil der Ruinen wird mit dem Mut der Verzweiflung von einem Kontingent Scharlachroter Kreuzritter gehalten, die von dem Obersten Kreuzritter Dathrohan angef\195\188hrt werden. Beide Seiten sind in einem erbitterten Stra\195\159enkampf gefangen. Abenteurer, die mutig (oder t\195\182richt) genug sind, Stratholme zu betreten, werden sich fr\195\188her oder sp\195\164ter mit beiden Seiten auseinandersetzen m\195\188ssen. Man sagt, die Stadt werde von drei gewaltigen Wacht\195\188rmen, m\195\164chtigen Totenbeschw\195\182rern, Banshees und Monstrosit\195\164ten bewacht. Es gibt auch Berichte von einem unheimlichen Todesritter, der auf seinem untoten Ross durch die Stra\195\159en reitet, und jeden heimsucht, der es wagt, in das Reich der Gei\195\159el vorzudringen.",
},
[21] = {
["ZoneName"] = "Die Todesminen",
["Location"] = "Westfall",
["LevelRange"] = "17-26",
["PlayerLimit"] = "10",
["texture"] = "TheDeadmines",
		["infoline"] = "Die Todesminen, einst die wichtigste Goldquelle der Menschen, wurden aufgegeben, als die Horde Stormwind w\195\164hrend des Ersten Krieges in Schutt und Asche legte. Nun haben sich die Defias in den verlassenen Minen niedergelassen und die dunklen Sch\195\164chte in ihre eigene unterirdische Festung verwandelt. Ger\195\188chten zufolge sollen die Diebe die gewitzten Goblins angeheuert haben, um tief in den Minen etwas f\195\188rchterliches zu konstruieren – doch welche Teufelei dies konkret sein soll, ist nicht bekannt. Der Zugang zu den Todesminen liegt inmitten des ruhigen, unscheinbaren Dorfes Moonbrook.",
},
[22] = {
["ZoneName"] = "Das Verlies",
["Location"] = "Stormwind",
["LevelRange"] = "23-26",
["PlayerLimit"] = "10",
["texture"] = "TheStockades",
		["infoline"] = "Bei den Palisaden handelt es sich um ein Hochsicherheitsgef\195\164ngnis, das unter dem Kanalbezirk von Stormwind verborgen liegt. Unter der F\195\188hrung von W\195\164rter Thelwater sammelten sich in den Palisaden mit der Zeit ein bunter Haufen simpler Gauner, politischer Aufr\195\188hrer, M\195\182rder, Diebe, Halsabschneider und einiger der gef\195\164hrlichsten Kriminellen des Landes an. Vor kurzem gab es einen Aufstand der Gefangenen, der in den Palisaden f\195\188r Chaos sorgte – die Wachen sind geflohen und die Gefangenen haben das Gef\195\164ngnis \195\188bernommen. Thelwater konnte knapp entkommen und sucht momentan nach tapferen Abenteurern, um den Anf\195\188hrer der Revolte auszuschalten, den gerissenen Meisterverbrecher Bazil Thredd.",
},
[23] = {
["ZoneName"] = "Der Tempel von Atal'Hakkar",
["Location"] = "S\195\188mpfe des Elends",
["LevelRange"] = "45-55",
["PlayerLimit"] = "10",
["texture"] = "TheSunkenTemple",
		["infoline"] = "Vor mehr als tausend Jahren wurde das m\195\164chtige Reich der Gurubashi von einem gewaltigen B\195\188rgerkrieg auseinandergerissen. Eine einflussreiche Gruppe trollischer Priester, die als die Atal’ai bekannt waren, wagten den Versuch, einen uralten Blutgott namens Hakkar der Seelenschinder zu beschw\195\182ren. Obwohl ihr Plan vereitelt und die Priester letztenendes verbannt wurden zerbrach das Reich und kollabierte, da der Krieg s\195\164mtlichen inneren Zusammenhalt zwischen den Klans zerst\195\182rt hatte. Die verbannten Priester flohen weit in den Norden zu den S\195\188mpfen des Elends. Dort bauten sie Hakkar einen gro\195\159en Tempel, wo sie erneut seine R\195\188ckkehr in die Welt vorbereiten wollten. Als der gro\195\159e Drachenaspekt Ysera von den Pl\195\164nen der Atal’ai erfuhr gab es nichts, was den Zorn des Drachen zur\195\188ckhalten konnte, und so zerschmetterte sie den Tempel und lie\195\159 ihn in den Marschen versinken. Bis zum heutigen Tag werden die Ruinen des Tempels von gr\195\188nen Drachen bewacht, so dass niemand hinein oder hinaus kann. Allerdings sollen einige der verfluchten Atal’ai \195\188berlebt haben und immer noch an der Vollendung ihrer finsteren Pl\195\164ne arbeiten.",
},
[24] = {
["ZoneName"] = "Uldaman",
["Location"] = "Das \195\182dland",
["LevelRange"] = "35-47",
["PlayerLimit"] = "10",
["texture"] = "Uldaman",
		["infoline"] = "Uldaman ist ein uraltes titanisches Verlies, das seit der Zeit der Titanen tief unter der Erde verborgen lag. Vor Kurzem stie\195\159en die Zwerge bei ihren Ausgrabungen auf die vergessene Stadt, wobei sie die missgl\195\188ckten ersten Sch\195\182pfungen der Titanen entfesselten: Die Troggs. Der Legende nach erschufen die Titanen die Troggs aus Stein. Als sie sahen, dass ihre Sch\195\182pfung ein Fehlschlag war, verbannten sie die Troggs nach Uldaman und begannen von vorne. Das Ergebnis dieses zweiten Versuchs waren die Urahnen der heutigen Zwerge. Das Geheimnis der Entstehung der Zwerge ist auf den sagenumwobenen Scheiben von Norgannon festgehalten, gewaltigen titanischen Artefakten, die im Allerheiligsten der vergessenen Stadt Uldaman aufbewahrt werden. Die Zwerge des D\195\188stereisenklans haben damit begonnen, nach Uldaman vorzudringen, um die Scheiben f\195\188r ihren Meister zu stehlen, den Feuerf\195\188rsten Ragnaros. Die Stadt und die Scheiben werden jedoch von mehreren W\195\164chtern besch\195\188tzt, riesigen Gesch\195\182pfen aus lebendem Stein, die jeden ungl\195\188cklichen Eindringling zerquetschen, der ihnen \195\188ber den Weg l\195\164uft. Die Scheiben selbst werden von einem gewaltigen Steinw\195\164chter namens Archaedas bewacht, und einige, die aus Uldaman zur\195\188ckgekehrt sind, berichten von Begegnungen mit seltsamen Wesen, bei denen es sich aller Wahrscheinlichkeit um die steinh\195\164utigen Vorfahren der Zwerge handelt, die lange verloren geglaubten Irdenen.",
},
[25] = {
["ZoneName"] = "Die H\195\182hlen des Wehklagens",
["Location"] = "Brachland",
["LevelRange"] = "17-24",
["PlayerLimit"] = "10",
["texture"] = "WailingCaverns",
		["infoline"] = "Vor nicht allzu langer Zeit entdeckte ein nachtelfischer Druide namens Naralex eine Reihe unterirdischer Kavernen im Herzen des Brachlands. Er gab den H\195\182hlen des Wehklagens ihren Namen, da sich dort viele Risse im Boden befinden, durch die in regelm\195\164\195\159igen Abst\195\164nden hei\195\159er Dampf entweicht, wobei ein lang gezogenes, wehleidig klingenendes Heulen ert\195\182nt. Naralex glaubte, die unterirdischen Quellen der Kavernen dazu nutzen zu k\195\182nnen, das Brachland wieder gr\195\188n und fruchtbar zu machen. Um seinen mutigen Plan in die Tat umzusetzen, musste er zuerst die Energien des sagenumwobenen Smaragdgr\195\188nen Traums anzapfen. Sobald er sich in den Traum versetzte, geschah jedoch das Unfassbare: Seine Vision verwandelte sich in einen Alptraum! Kurz darauf fingen auch die H\195\182hlen des Wehklagens an, sich zu ver\195\164ndern. Das einst reine Quellwasser wurde faulig, und die zahmen Kreaturen vollzogen eine perverse Metamorphose, aus der sie als blutr\195\188nstige Monster hervorgingen. Man sagt, Naralex hielte sich immer noch in den H\195\182hlen auf, gefangen in seinem eigenen Smaragdgr\195\188nen Alptraum. Sogar die Gefolgsleute von Naralex wurden durch das Versagen ihres Meisters korrumpiert und in die grausamen Druiden des Fangzahns verwandelt.",
},
[26] = {
["ZoneName"] = "Zul'Farrak",
["Location"] = "Tanaris",
["LevelRange"] = "43-47",
["PlayerLimit"] = "10",
["texture"] = "ZulFarrak",
		["infoline"] = "Unter der brennenden Sonne von Tanaris liegt die Hauptstadt der Trolle des Sandfuryclans, die wegen ihrer Ruchlosigkeit und Grausamkeit gef\195\188rchtet sind. Die Legenden der Trolle erz\195\164hlen von einem m\195\164chtigen Schwert namens Sul’thraze dem Peitscher, einer Waffe, die selbst den gef\195\164hrlichsten Gegner mit Angst und Schrecken erf\195\188llen kann. Vor langer Zeit wurde die Waffe in zwei Teile gespalten, doch es halten sich hartn\195\164ckige Ger\195\188chte, dass sich beide H\195\164lften irgendwo in Zul’Farrak befinden. Es gibt Berichte, dass eine Gruppe von S\195\182ldnern, die aus Gadgetzan fliehen mussten, die Stadt betraten und pl\195\182tzlich dort gefangen waren. \195\156ber ihr Schicksal ist nichts weiter bekannt. Doch noch viel bedenkniserregender erscheinen die nur unter vorgehaltener Hand \195\188berlieferten Erz\195\164hlungen von einer uralten Kreatur, die in den heiligen Wassern im Herzen der Stadt schlummern soll – ein m\195\164chtiger Halbgott, der jeden vernichten wird, der t\195\182richt genug ist, ihn aus seinem Schlaf zu wecken.",
},
[27] = {
["ZoneName"] = "Zul'Gurub",
["Location"] = "Stranglethorn",
["LevelRange"] = "60+",
["PlayerLimit"] = "20",
["texture"] = "ZulGurub",
		["infoline"] = "Vor mehr als tausend Jahren wurde das m\195\164chtige Reich der Gurubashi von einem gewaltigen B\195\188rgerkrieg in St\195\188cke gerissen. Eine einflussreiche Gruppe trollischer Priester, die als die Atal’ai bekannt waren, beschworen damals den Avatar des uralten und f\195\188rchterlichen Blutgottes, Hakkar, der Seelenschinder. Obwohl die Priester besiegt und ins Exil geschickt wurden, brach das ehemals glorreiche Reich der Trolle zusammen. Die Reise ins Exil f\195\188hrte die verbannten Priester weit nach Norden, bis in die S\195\188mpfe des Elends, wo sie ihrem Gott Hakkar einen Tempel errichteten, um seine R\195\188ckkehr in die Welt der Sterblichen vorzubereiten.",
},
[28] = {
["ZoneName"] = "Ahn'Quiraj",
["Location"] = "Silithus",
["LevelRange"] = "60+",
["PlayerLimit"] = "40",
["texture"] = "TempleofAhnQiraj",
		["infoline"] = "Im Herzen Ahn’Qirajs liegt ein uralter Tempelkomplex. Vor Beginn der Zeitrechnung erbaut, ist es ein Monument scheu\195\159licher Gottheiten und die gewaltige Brutst\195\164tte der Qiraji Streitmacht. Seit der Krieg der wehenden Sande vor tausend Jahren endete, waren die Zwilingsimperatoren von Ahn’Qiraj, Vek’nilash und Vek’lor, in ihrem Tempel gefangen. Die magische Barriere des bronzenen Drachen Anachronos und der Nachtelfen hielt sie in ihrem Bann. Doch nun, da das Szepter der Sandst\195\188rme wieder vereint und das Siegel gebrochen ist, steht der Weg in das Heiligtum Ahn’Qirajs erneut offen. Hinter dem krabbelnden Wahnsinn des Schwarmbaus, unter dem Tempel von Ahn’Qiraj, bereiten sich Heerscharen der Qiraji auf den Einmarsch vor. Nun gilt es, sie um jeden Preis aufzuhalten bevor sie ihre uners\195\164ttlichen, insektenartigen Armeen erneut auf auf Kalimdor loslassen und ein zweiter Krieg der Silithiden beginnt!",
},
[29] = {
["ZoneName"] = "Ruins of Ahn'Qiraj",
["Location"] = "Silithus",
["LevelRange"] = "60+",
["PlayerLimit"] = "20",
["texture"] = "RuinsofAhnQiraj",
		["infoline"] = "In den letzten Stunden des Krieges gegen die Silithiden trugen die Nachtelfen und die vier Drachenschw\195\164rme die Schlacht in das Herz des Qiraji Reichs zur\195\188ck: in die Festung von Ahn'Qiraj. An den Toren der Stadt stie\195\159en sie auf ein Aufgebot von Kriegsdrohnen, gewaltiger als es je zuvor gesehen wurde. Die Silithiden und ihre Qiraji Herren konnten nicht besiegt werden und wurden stattdessen innerhalb einer magischen Barriere eingeschlossen; der Krieg hinterlie\195\159 die verfluchte Stadt in Ruinen. Tausend Jahre sind seitdem vergangen – Jahre, in denen die Qiraji nicht unt\195\164tig waren. Eine neue und schreckliche Streitmacht ist in den St\195\182cken ausgebr\195\188tet worden und die Ruinen von Ahn'Qiraj wurden erneut von Silithidenschw\195\164rmen und Qiraji bev\195\182lkert. Diese Bedrohung gilt es zu meistern, ansonsten wird Azeroth der schrecklichen Macht dieser neuen Qiraji Streitkraft zum Opfer fallen.",
},
[30] = {
["ZoneName"] = "Naxxramas",
["Location"] = "Eastern Plaguelands",
["LevelRange"] = "60+",
["PlayerLimit"] = "40",
["texture"] = "Naxxramas",
		["infoline"] = "Hoch \195\188ber den Pestl\195\164ndern schwebt die Nekropole Naxxramas, die Kel’Thuzad, einem der m\195\164chtigsten Offiziere des Lichk\195\182nigs, als Heimstatt dient. Schrecken der Vergangenheit und noch unbekannte Grauen warten darauf, auf die Welt losgelassen zu werden, w\195\164hrend sich die Diener der Gei\195\159el auf ihren Ansturm vorbereiten. Bald wird die Gei\195\159el erneut marschieren… Findet die vollst\195\164ndige Geschichte von Kel’Thuzads Korruption und der verdammten Nekropole Naxxramas in der Warcraft Kurzgeschichte Weg zur Verdammnis und seht euch den Trailer zu der Hintergrundgeschichte dieses neuen Dungeons an.",
},
};

end
