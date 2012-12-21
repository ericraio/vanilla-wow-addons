local _;

-- metadata magic
YATLAS_TITLE = GetAddOnMetadata("Yatlas", "Title") or "Y";
YATLAS_VERSION = GetAddOnMetadata("Yatlas","Version") or "???";
_,_,YATLAS_RELEASE_DATE = string.find(GetAddOnMetadata("Yatlas","X-LastChangedDate") or "", "[(](.+)[)]");

YATLAS_WEBSITE = "http://endif.cjb.net/wowui/wiki/Yatlas"
YATLAS_AUTHOR = "Robin Schoonover (endx7)";
YATLAS_AUTHOR_EMAIL = "robin.schoonover@gmail.com";

-- localize from this point on as needed
YATLAS_HELP_TEXT = {
    "Yatlas provides a minimap-based map of the world (reasonably high "..
        "detail).\n\n"..
    "To move your view around click and drag on the map itself. You can "..
        "choose which map (currently only Kalimdor and the Eastern "..
        "Kingdoms) at the top. You can jump around by zone and zoom to "..
        "player as well.\n\n"..
    "Mousing over a point of interest will bring up a tooltip.\n\n"..
    "If you have Gatherer or MapNotes installed, it will shows points from "..
        "these two addons as well.\n"
    };

YATLAS_TAB_DATA = "Show Data";
YATLAS_TAB_OPTIONS = "Options";

YATLAS_BUTTON_TOOLTIP1 = "Yatlas";
YATLAS_BUTTON_TOOLTIP2 = "- Click to open the Yatlas";
YATLAS_BUTTON_TOOLTIP3 = "- Right-click and drag to move the minimap button.";
YATLAS_PLAYERJUMP = "Goto Player";
YATLAS_OPTIONSBUTTON = "Options";

YATLAS_OPTIONS_TITLE = "Yatlas Options";
YATLAS_OPTIONS_BUTTONPOS = "Minimap Button Position";
YATLAS_OPTIONS_BUTTONPOS_TIP = "%d degrees";
YATLAS_OPTIONS_ENABLEBUTTON = "Enable Minimap Button";
YATLAS_OPTIONS_TRACKONSHOW = "Zoom to Player on Show";
YATLAS_OPTIONS_ALPHA = "Transparency";
YATLAS_OPTIONS_ICONSIZE = "Icon Size";
YATLAS_OPTIONS_ENABLECOORD = "Enable Cursor Coordinates";

YATLAS_POINTS_SHOWPOINTS_TITLE = "Show Points";
YATLAS_POINTS_LANDMARKS = "Landmarks";
YATLAS_POINTS_GRAVEYARDS = "Graveyards";
YATLAS_POINTS_MAPNOTES = "MapNotes";
YATLAS_POINTS_GATHERER = "Gatherer";
YATLAS_POINTS_GATHERER_TREASURE = "Treasure";
YATLAS_POINTS_GATHERER_ORES = "Ores";
YATLAS_POINTS_GATHERER_HERBS = "Herbs";
YATLAS_POINTS_CTMAPMOD = "CTMapMod";

YATLAS_UNKNOWN_ZONE = "Unknown";

YATLAS_BIGDRAGMESSAGE = "Click on map and drag to move view."
YATLAS_ZOOMIN =     "+";
YATLAS_ZOOMOUT =     "-";

BINDING_NAME_YATLAS_TOGGLE = "Toggle Yatlas Frame";
BINDING_NAME_YATLAS_BIG_TOGGLE = "Toggle Fullscreen Yatlas Frame";
BINDING_HEADER_YATLAS = YATLAS_TITLE;

