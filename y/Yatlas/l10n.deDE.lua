
if (GetLocale() == "deDE") then

-- Deutsche
--            lower      upper
-- a umlaut   \195\164   \195\132
-- o umlaut   \195\192   \195\150
-- u umlaut   \195\188   \195\156
-- "          \"
-- '          \'

YATLAS_HELP_TEXT = {
    "Yatlas bietet eine Minimap-basierte Weltkarte (deutlich mehr Details).\n\n"..
    "Zum Schieben der Karte klickt direkt auf die Karte und verschiebt sie."..
    "W\195\164hlt den darzustellenden Kontinent oberhalb der Karte aus (derzeit nur".. 
    "Kalimdor und die \195\182stlichen K\195\182nigreiche). \n"..
    "Ihr k\195\182nnt verschieden Zonen ausw\195\164hlen oder zur Spielerposition springen."..
    "Im Bereich \"Daten\" werden wichtige Orte in Form einer Legende angezeigt".. 
    "und im Bereich \"Optionen\" k\195\182nnen Sichtbarkeit und Position des Minimap-Icons"..
    "und auch die Transparenz des Yatlas-Fensters ver\195\164ndert werden.\n\n"..
    "Sofern Ihr den Gatherer oder MapNotes installiert habt, werden ebendso die "..
    "Fundorte oder Notizen dieser Addons in der Legende angezeigt."
    };

YATLAS_TAB_DATA = "Zeige Daten";
YATLAS_TAB_OPTIONS = "Optionen";

YATLAS_BUTTON_TOOLTIP1 = "Yatlas";
YATLAS_BUTTON_TOOLTIP2 = "- Klicken, zum \195\182ffnen des Yatlas";
YATLAS_BUTTON_TOOLTIP3 = "- Rechtsklicken, zum Schieben des Minimap Buttons";
YATLAS_PLAYERJUMP = "Spielerposition";
YATLAS_OPTIONSBUTTON = "Optionen";

YATLAS_OPTIONS_BUTTONPOS = " Position des Minimap-Icon";
YATLAS_OPTIONS_BUTTONPOS_TIP = "%d\°";
YATLAS_OPTIONS_ENABLEBUTTON = "Aktiviere Minimap-Icon";
YATLAS_OPTIONS_ALPHA = "Transparenz";
YATLAS_OPTIONS_ICONSIZE = "Icon Gr\195\182\195\159e";
YATLAS_OPTIONS_ENABLECOORD = "Aktiviere Cursor Koordinaten";

YATLAS_OVERLAY_SHOWPOINTS_TITLE = "Zeige Punkte";
-- Landmarks would tranlsate to "Landmarken", "wichtige Orte" would be translated to English: "important places"
-- I would prefer "wichtige Orte" over "Landmarken"
YATLAS_OVERLAY_LANDMARKS = "wichtige Orte";
YATLAS_OVERLAY_GRAVEYARDS = "Friedh\195\182fe";
YATLAS_OVERLAY_MAPNOTES = "MapNotes";
YATLAS_OVERLAY_GATHERER = "Gatherer";
YATLAS_OVERLAY_GATHERER_TREASURE = "Sch\195\164tze";
YATLAS_OVERLAY_GATHERER_ORES = "Erze";
YATLAS_OVERLAY_GATHERER_HERBS = "Kr\195\164uter";
YATLAS_OVERLAY_CTMAPMOD = "CTMapMod";

YATLAS_UNKNOWN_ZONE = "Unbekannt";

YATLAS_BIGDRAGMESSAGE = "Klicke und ziehe die Karte um den Ausschnitt zu verschieben."

BINDING_NAME_YATLAS_TOGGLE = "Ein- und Ausblenden des Yatlas-Fenster";
BINDING_NAME_YATLAS_BIG_TOGGLE = "Ein- und Ausblenden des gro\195\159en Yatlas-Fensters";
BINDING_HEADER_YATLAS = YATLAS_TITLE;

end
