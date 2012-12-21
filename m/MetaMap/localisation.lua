-- Default English Data for MetaMap

-- General
METAMAP_CATEGORY = "Interface";
METAMAP_SUBTITLE = "WorldMap Mod";
METAMAP_DESC = "MetaMap adds enhancements to the standard World Map.";
METAMAP_OPTIONS_BUTTON = "Options";
METAMAP_STRING_LOCATION = "Location";
METAMAP_STRING_LEVELRANGE = "Level Range";
METAMAP_STRING_PLAYERLIMIT = "Player Limit";
METAMAP_MAPLIST_INFO = "LeftClick: Ping Note\nRightClick: Edit Note\nCTRL+Click: Loot Table";
METAMAP_BUTTON_TOOLTIP1 = "LeftClick to Show Map";
METAMAP_BUTTON_TOOLTIP2 = "RightClick for Options";
METAMAP_OPTIONS_TITLE = "MetaMap Options";
METAMAP_KB_TEXT = "Knowledge Base"
METAMAP_HINT = "Hint: Left-click to open MetaMap.\nRight-click for options";
METAMAP_NOTES_SHOWN = "Notes"
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
METAMAP_OPTIONS_COORDS = "Show Main Coords";
METAMAP_OPTIONS_MINICOORDS = "Show MiniMap Coords";
METAMAP_OPTIONS_SHOWAUTHOR = "Show notes author"
METAMAP_OPTIONS_SHOWNOTES = "Notes Filter"
METAMAP_OPTIONS_FILTERON = "Show All"
METAMAP_OPTIONS_FILTEROFF = "Hide All"
METAMAP_OPTIONS_SHOWBUT = "Show Minimap Button";
METAMAP_OPTIONS_AUTOSEL = "Autowrap Tooltip Text";
METAMAP_OPTIONS_BUTPOS = "MetaMap Button Position";
METAMAP_OPTIONS_POI = "Set POI when entering new zone (Points Of Interest)";
METAMAP_OPTIONS_LISTCOLORS = "Use coloured Sidelist";
METAMAP_OPTIONS_ZONEHEADER = "Show Zone information in WorldMap header";
METAMAP_OPTIONS_MOZZ = "Show Unexplored";
METAMAP_OPTIONS_TRANS = "Map Transparency";
METAMAP_OPTIONS_SHADER = "BackDrop Shader";
METAMAP_OPTIONS_SHADESET = "Instance Backdrop Shade";
METAMAP_OPTIONS_FWM = "Show Unexplored Areas";
METAMAP_OPTIONS_DONE = "Done";
METAMAP_FLIGHTMAP_OPTIONS = "FlightMap Options";
METAMAP_GATHERER_OPTIONS = "Gatherer Options";
METAMAP_BWP_OPTIONS = "Set a Waypoint";
METAMAP_OPTIONS_SCALE = "Map Scale";
METAMAP_OPTIONS_TTSCALE = "Tooltip Scale";
METAMAP_OPTIONS_SAVESET = "Map Display Mode";
METAMAP_OPTIONS_USEMAPMOD = "Create notes with MapMod";
METAMAP_ACTION_MODE = "Allow clicks through map";
METAMAPLIST_SORTED = "Sorted List";
METAMAPLIST_UNSORTED = "Unsorted List";
METAMAP_CLOSE_BUTTON ="Close";

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

METAMAPNOTES_WORLDMAP_HELP_1 = "RightClick On Map To Zoom Out"
METAMAPNOTES_WORLDMAP_HELP_2 = "Ctrl+LeftClick to create a note"
METAMAPNOTES_CLICK_ON_SECOND_NOTE = "Choose Second Note To Draw/Clear A Line"
METAMAPNOTES_CLICK_ON_LOCATION = "LeftClick on map for new note location"

METAMAPNOTES_NEW_NOTE = "Create Note"
METAMAPNOTES_MININOTE_OFF = "MiniNote Off"
METAMAPNOTES_OPTIONS_TEXT = "Notes Options"
METAMAPNOTES_CANCEL = "Cancel"
METAMAPNOTES_EDIT_NOTE = "Edit Note"
METAMAPNOTES_MININOTE_ON = "Set MiniNote"
METAMAPNOTES_SEND_NOTE = "Send Note"
METAMAPNOTES_TOGGLELINE = "Toggle Line"
METAMAPNOTES_MOVE_NOTE = "Move Note";
METAMAPNOTES_DELETE_NOTE = "Delete Note"
METAMAPNOTES_SAVE_NOTE = "Save"
METAMAPNOTES_EDIT_TITLE = "Title (required):"
METAMAPNOTES_EDIT_INFO1 = "Info Line 1 (optional):"
METAMAPNOTES_EDIT_INFO2 = "Info Line 2 (optional):"
METAMAPNOTES_EDIT_CREATOR = "Creator (optional - leave blank to hide):"

METAMAPNOTES_SEND_MENU = "Send Note"
METAMAPNOTES_SLASHCOMMAND = "Change Mode"
METAMAPNOTES_SEND_TIP = "These notes can be received by all MetaMap users"
METAMAPNOTES_SEND_PLAYER = "Enter player name:"
METAMAPNOTES_SENDTOPLAYER = "Send to player"
METAMAPNOTES_SENDTOPARTY = "Send to party"
METAMAPNOTES_SHOWSEND = "Change Mode"
METAMAPNOTES_SEND_SLASHTITLE = "Get slash Command:"
METAMAPNOTES_SEND_SLASHTIP = "Highlight this and use CTRL+C to copy to clipboard\n(then you can post it in a forum for example)"
METAMAPNOTES_SEND_SLASHCOMMAND = "/Command:"
METAMAPNOTES_PARTYSENT = "PartyNote sent to all Party members.";
METAMAPNOTES_RAIDSENT = "PartyNote sent to all Raid members.";
METAMAPNOTES_NOPARTY = "Not currently in a Party or Raid.";

METAMAPNOTES_OWNNOTES = "Show notes created by your character"
METAMAPNOTES_OTHERNOTES = "Show notes received from other characters"
METAMAPNOTES_HIGHLIGHT_LASTCREATED = "Highlight last created note in |cFFFF0000red|r"
METAMAPNOTES_HIGHLIGHT_MININOTE = "Highlight note selected for MiniNote in |cFF6666FFblue|r"
METAMAPNOTES_ACCEPTINCOMING = "Accept incoming notes from other players"
METAMAPNOTES_AUTOPARTYASMININOTE = "Automatically set party notes as MiniNote."
METAMAPNOTES_ZONESEARCH_TEXT = "Delete notes for |cffffffff%s|r by creator:"
METAMAPNOTES_ZONESEARCH_TEXTHINT = "Hint: Open WorldMap and set map to desired area for deletion";
METAMAPNOTES_BATCHDELETE = "This will delete all notes for |cFFFFD100%s|r with creator as |cFFFFD100%s|r.";
METAMAPNOTES_DELETED_BY_NAME = "Deleted selected notes with creator |cFFFFD100%s|r and name |cFFFFD100%s|r."
METAMAPNOTES_DELETED_BY_CREATOR = "Deleted all notes with creator |cFFFFD100%s|r."
METAMAPNOTES_DELETED_BY_ZONE = "Deleted all notes for |cFFFFD100%s|r with creator |cFFFFD100%s|r."

METAMAPNOTES_CREATEDBY = "Created by"
METAMAPNOTES_CHAT_COMMAND_ENABLE_INFO = "This command enables you to instert notes gotten by a webpage for example."
METAMAPNOTES_CHAT_COMMAND_ONENOTE_INFO = "Overrides the options setting, so that the next note you receive is accepted."
METAMAPNOTES_CHAT_COMMAND_MININOTE_INFO = "Displays the next received note directly as MiniNote (and insterts it into the map):"
METAMAPNOTES_CHAT_COMMAND_MININOTEONLY_INFO = "Displays the next note received as MiniNote only (not inserted into map)."
METAMAPNOTES_CHAT_COMMAND_MININOTEOFF_INFO = "Turns the MiniNote off."
METAMAPNOTES_CHAT_COMMAND_QUICKNOTE = "Creates a note at the specified position on the map."
METAMAPNOTES_MAPNOTEHELP = "This command can only be used to insert a note"
METAMAPNOTES_ONENOTE_OFF = "Allow one note: OFF"
METAMAPNOTES_ONENOTE_ON = "Allow one note: ON"
METAMAPNOTES_MININOTE_SHOW_0 = "Next as MiniNote: OFF"
METAMAPNOTES_MININOTE_SHOW_1 = "Next as MiniNote: ON"
METAMAPNOTES_MININOTE_SHOW_2 = "Next as MiniNote: ONLY"
METAMAPNOTES_ACCEPT_NOTE = "Note added to the map of |cFFFFD100%s|r."
METAMAPNOTES_DECLINE_NOTE = "Could not add, this note is too near to |cFFFFD100%q|r in |cFFFFD100%s|r."
METAMAPNOTES_ACCEPT_MININOTE = "MiniNote set for the map of |cFFFFD100%s|r.";
METAMAPNOTES_DECLINE_GET = "|cFFFFD100%s|r tried to send you a note in |cFFFFD100%s|r, but it was too near to |cFFFFD100%q|r."
METAMAPNOTES_DISABLED_GET = "Could not receive note from |cFFFFD100%s|r: reception disabled in the options."
METAMAPNOTES_ACCEPT_GET = "You received a map note from |cFFFFD100%s|r for |cFFFFD100%s|r."
METAMAPNOTES_PARTY_GET = "|cFFFFD100%s|r set a new party note in |cFFFFD100%s|r."
METAMAPNOTES_NOTE_SENT = "Note sent to |cFFFFD100%s|r."
METAMAPNOTES_QUICKNOTE_DEFAULTNAME = "QuickNote"
METAMAPNOTES_MININOTE_DEFAULTNAME = "MiniNote"
METAMAPNOTES_VNOTE_DEFAULTNAME = "VirtualNote"
METAMAPNOTES_SETMININOTE = "Set note as new MiniNote"
METAMAPNOTES_PARTYNOTE = "Party Note"
METAMAPNOTES_SETCOORDS = "Coords (xx,yy):"
METAMAPNOTES_VNOTE = "Virtual"
METAMAPNOTES_VNOTE_INFO = "Creates a virtual note. Save on map of choice to bind."
METAMAPNOTES_VNOTE_SET = "Virtual note created on the World Map."
METAMAPNOTES_MININOTE_INFO = "Creates a note on the Minimap only."
METAMAPNOTES_INVALIDZONE = "Could not create - no player coords available in this zone.";

-- Buttons, Headers, Various Text

METAMAPNOTES_WARSONGGULCH = "Warsong Gulch"
METAMAPNOTES_ALTERACVALLEY = "Alterac Valley"
METAMAPNOTES_ARATHIBASIN = "Arathi Basin"

MetaMap_Data = {
	[1] = {
		["ZoneName"] = "Blackfathom Deeps",
		["Location"] = "Ashenvale",
		["LevelRange"] = "24-32",
		["PlayerLimit"] = "10",
		["texture"] = "BlackfathomDeeps",
		["infoline"] = "Situated along the Zoram Strand of Ashenvale, Blackfathom Deeps was once a glorious temple dedicated to the night elves' moon-goddess, Elune. However, the great Sundering shattered the temple - sinking it beneath the waves of the Veiled Sea. There it remained untouched - until, drawn by its ancient power - the naga and satyr emerged to plumb its secrets. Legends hold that the ancient beast, Aku'mai, has taken up residence within the temple's ruins. Aku'mai, a favored pet of the primordial Old Gods, has preyed upon the area ever since. Drawn to Aku'mai's presence, the cult known as the Twilight's Hammer has also come to bask in the Old Gods' evil presence.",
	},
	[2] = {
		["ZoneName"] = "Blackrock Depths",
		["Location"] = "Blackrock Mountain",
		["LevelRange"] = "52+",
		["PlayerLimit"] = "5",
		["texture"] = "BlackrockDepths",
		["infoline"] = "Once the capital city of the Dark Iron dwarves, this volcanic labyrinth now serves as the seat of power for Ragnaros the Firelord. Ragnaros has uncovered the secret to creating life from stone and plans to build an army of unstoppable golems to aid him in conquering the whole of Blackrock Mountain. Obsessed with defeating Nefarian and his draconic minions, Ragnaros will go to any extreme to achieve final victory.",
	},
	[3] = {
		["ZoneName"] = "Blackrock Spire",
		["Location"] = "Blackrock Mountain",
		["LevelRange"] = "55+",
		["PlayerLimit"] = "10",
		["texture"] = "BlackrockSpireLower",
		["infoline"] = "The mighty fortress carved within the fiery bowels of Blackrock Mountain was designed by the master dwarf-mason, Franclorn Forgewright. Intended to be the symbol of Dark Iron power, the fortress was held by the sinister dwarves for centuries. However, Nefarian - the cunning son of the dragon, Deathwing - had other plans for the great keep. He and his draconic minions took control of the upper Spire and made war on the dwarves' holdings in the mountain's volcanic depths. Realizing that the dwarves were led by the mighty fire elemental, Ragnaros - Nefarian vowed to crush his enemies and claim the whole of Blackrock mountain for himself.",
	},
	[4] = {
		["ZoneName"] = "Blackrock Spire (Upper)",
		["Location"] = "Blackrock Mountain",
		["LevelRange"] = "58+",
		["PlayerLimit"] = "10",
		["texture"] = "BlackrockSpireUpper",
		["infoline"] = "The mighty fortress carved within the fiery bowels of Blackrock Mountain was designed by the master dwarf-mason, Franclorn Forgewright. Intended to be the symbol of Dark Iron power, the fortress was held by the sinister dwarves for centuries. However, Nefarian - the cunning son of the dragon, Deathwing - had other plans for the great keep. He and his draconic minions took control of the upper Spire and made war on the dwarves' holdings in the mountain's volcanic depths. Realizing that the dwarves were led by the mighty fire elemental, Ragnaros - Nefarian vowed to crush his enemies and claim the whole of Blackrock mountain for himself.",
	},
	[5] = {
		["ZoneName"] = "Blackwing Lair",
		["Location"] = "Blackrock Spire",
		["LevelRange"] = "60+",
		["PlayerLimit"] = "40",
		["texture"] = "BlackwingLair",
		["infoline"] = "Blackwing Lair can be found at the very height of Blackrock Spire. It is there in the dark recesses of the mountain's peak that Nefarian has begun to unfold the final stages of his plan to destroy Ragnaros once and for all and lead his army to undisputed supremacy over all the races of Azeroth. Nefarian has vowed to crush Ragnaros. To this end, he has recently begun efforts to bolster his forces, much as his father Deathwing had attempted to do in ages past. However, where Deathwing failed, it now seems the scheming Nefarian may be succeeding. Nefarian's mad bid for dominance has even attracted the ire of the Red Dragon Flight, which has always been the Black Flight's greatest foe. Though Nefarian's intentions are known, the methods he is using to achieve them remain a mystery. It is believed, however that Nefarian has been experimenting with the blood of all of the various Dragon Flights to produce unstoppable warriors.",
	},
	[6] = {
		["ZoneName"] = "Dire Maul",
		["Location"] = "Feralas",
		["LevelRange"] = "56-60",
		["PlayerLimit"] = "5",
		["texture"] = "DireMaul",
		["infoline"] = "Built twelve thousand years ago by a covert sect of night elf sorcerers, the ancient city of Eldre'Thalas was used to protect Queen Azshara's most prized arcane secrets. Though it was ravaged by the Great Sundering of the world, much of the wondrous city still stands as the imposing Dire Maul. The ruins' three distinct districts have been overrun by all manner of creatures - especially the spectral highborne, foul satyr and brutish ogres. Only the most daring party of adventurers can enter this broken city and face the ancient evils locked within its ancient vaults.",
	},
	[7] = {
		["ZoneName"] = "Dire Maul East",
		["Location"] = "Feralas",
		["LevelRange"] = "56-60",
		["PlayerLimit"] = "5",
		["texture"] = "DireMaulEast",
		["infoline"] = "Built twelve thousand years ago by a covert sect of night elf sorcerers, the ancient city of Eldre'Thalas was used to protect Queen Azshara's most prized arcane secrets. Though it was ravaged by the Great Sundering of the world, much of the wondrous city still stands as the imposing Dire Maul. The ruins' three distinct districts have been overrun by all manner of creatures - especially the spectral highborne, foul satyr and brutish ogres. Only the most daring party of adventurers can enter this broken city and face the ancient evils locked within its ancient vaults.",
	},
	[8] = {
		["ZoneName"] = "Dire Maul North",
		["Location"] = "Feralas",
		["LevelRange"] = "56-60",
		["PlayerLimit"] = "5",
		["texture"] = "DireMaulNorth",
		["infoline"] = "Built twelve thousand years ago by a covert sect of night elf sorcerers, the ancient city of Eldre'Thalas was used to protect Queen Azshara's most prized arcane secrets. Though it was ravaged by the Great Sundering of the world, much of the wondrous city still stands as the imposing Dire Maul. The ruins' three distinct districts have been overrun by all manner of creatures - especially the spectral highborne, foul satyr and brutish ogres. Only the most daring party of adventurers can enter this broken city and face the ancient evils locked within its ancient vaults.",
	},
	[9] = {
		["ZoneName"] = "Dire Maul West",
		["Location"] = "Feralas",
		["LevelRange"] = "56-60",
		["PlayerLimit"] = "5",
		["texture"] = "DireMaulWest",
		["infoline"] = "Built twelve thousand years ago by a covert sect of night elf sorcerers, the ancient city of Eldre'Thalas was used to protect Queen Azshara's most prized arcane secrets. Though it was ravaged by the Great Sundering of the world, much of the wondrous city still stands as the imposing Dire Maul. The ruins' three distinct districts have been overrun by all manner of creatures - especially the spectral highborne, foul satyr and brutish ogres. Only the most daring party of adventurers can enter this broken city and face the ancient evils locked within its ancient vaults.",
	},
	[10] = {
		["ZoneName"] = "Gnomeregan",
		["Location"] = "Dun Morogh",
		["LevelRange"] = "29-38",
		["PlayerLimit"] = "10",
		["texture"] = "Gnomeregan",
		["infoline"] = "Located in Dun Morogh, the technological wonder known as Gnomeregan has been the gnomes' capital city for generations. Recently, a hostile race of mutant troggs infested several regions of Dun Morogh - including the great gnome city. In a desperate attempt to destroy the invading troggs, High Tinker Mekkatorque ordered the emergency venting of the city's radioactive waste tanks. Several gnomes sought shelter from the airborne pollutants as they waited for the troggs to die or flee. Unfortunately, though the troggs became irradiated from the toxic assault - their siege continued, unabated. Those gnomes who were not killed by noxious seepage were forced to flee, seeking refuge in the nearby dwarven city of Ironforge. There, High Tinker Mekkatorque set out to enlist brave souls to help his people reclaim their beloved city. It is rumored that Mekkatorque's once-trusted advisor, Mekgineer Thermaplug, betrayed his people by allowing the invasion to happen. Now, his sanity shattered, Thermaplug remains in Gnomeregan - furthering his dark schemes and acting as the city's new techno-overlord.",
	},
	[11] = {
		["ZoneName"] = "Maraudon",
		["Location"] = "Desolace",
		["LevelRange"] = "46-55",
		["PlayerLimit"] = "10",
		["texture"] = "Maraudon",
		["infoline"] = "Protected by the fierce Maraudine centaur, Maraudon is one of the most sacred sites within Desolace. The great temple/cavern is the burial place of Zaetar, one of two immortal sons born to the demigod, Cenarius. Legend holds that Zaetar and the earth elemental princess, Theradras, sired the misbegotten centaur race. It is said that upon their emergence, the barbaric centaur turned on their father and killed him. Some believe that Theradras, in her grief, trapped Zaetar's spirit within the winding cavern - used its energies for some malign purpose. The subterranean tunnels are populated by the vicious, long-dead ghosts of the Centaur Khans, as well as Theradras' own raging, elemental minions.",
	},
	[12] = {
		["ZoneName"] = "Molten Core",
		["Location"] = "Blackrock Depths",
		["LevelRange"] = "60+",
		["PlayerLimit"] = "40",
		["texture"] = "MoltenCore",
		["infoline"] = "The Molten Core lies at the very bottom of Blackrock Depths. It is the heart of Blackrock Mountain and the exact spot where, long ago in a desperate bid to turn the tide of the dwarven civil war, Emperor Thaurissan summoned the elemental Firelord, Ragnaros, into the world. Though the fire lord is incapable of straying far from the blazing Core, it is believed that his elemental minions command the Dark Iron dwarves, who are in the midst of creating armies out of living stone. The burning lake where Ragnaros lies sleeping acts as a rift connecting to the plane of fire, allowing the malicious elementals to pass through. Chief among Ragnaros' agents is Majordomo Executus - for this cunning elemental is the only one capable of calling the Firelord from his slumber.",
	},
	[13] = {
		["ZoneName"] = "Onyxia's Lair",
		["Location"] = "Dustwallow Marsh",
		["LevelRange"] = "60+",
		["PlayerLimit"] = "40",
		["texture"] = "OnyxiasLair",
		["infoline"] = "Onyxia is the daughter of the mighty dragon Deathwing, and sister of the scheming Nefarion Lord of Blackrock Spire. It is said that Onyxia delights in corrupting the mortal races by meddling in their political affairs. To this end it is believed that she takes on various humanoid forms and uses her charm and power to influence delicate matters between the different races. Some believe that Onyxia has even assumed an alias once used by her father - the title of the royal House Prestor. When not meddling in mortal concerns, Onyxia resides in a fiery cave below the Dragonmurk, a dismal swamp located within Dustwallow Marsh. There she is guarded by her kin, the remaining members of the insidious Black Dragon Flight.",
	},
	[14] = {
		["ZoneName"] = "Ragefire Chasm",
		["Location"] = "Orgrimmar",
		["LevelRange"] = "13-15",
		["PlayerLimit"] = "10",
		["texture"] = "RagefireChasm",
		["infoline"] = "Ragefire Chasm consists of a network of volcanic caverns that lie below the orcs' new capital city of Orgrimmar. Recently, rumors have spread that a cult loyal to the demonic Shadow Council has taken up residence within the Chasm's fiery depths. This cult, known as the Burning Blade, threatens the very sovereignty of Durotar. Many believe that the orc Warchief, Thrall, is aware of the Blade's existence and has chosen not to destroy it in the hopes that its members might lead him straight to the Shadow Council. Either way, the dark powers emanating from Ragefire Chasm could undo all that the orcs have fought to attain.",
	},
	[15] = {
		["ZoneName"] = "Razorfen Downs",
		["Location"] = "The Barrens",
		["LevelRange"] = "33-40",
		["PlayerLimit"] = "10",
		["texture"] = "RazorfenDowns",
		["infoline"] = "Crafted from the same mighty vines as Razorfen Kraul, Razorfen Downs is the traditional capital city of the quillboar race. The sprawling, thorn-ridden labyrinth houses a veritable army of loyal quillboar as well as their high priests - the Death's Head tribe. Recently, however, a looming shadow has fallen over the crude den. Agents of the undead Scourge - led by the lich, Amnennar the Coldbringer - have taken control over the quillboar race and turned the maze of thorns into a bastion of undead might. Now the quillboar fight a desperate battle to reclaim their beloved city before Amnennar spreads his control across the Barrens.",
	},
	[16] = {
		["ZoneName"] = "Razorfen Kraul",
		["Location"] = "The Barrens",
		["LevelRange"] = "25-30",
		["PlayerLimit"] = "10",
		["texture"] = "RazorfenKraul",
		["infoline"] = "Ten thousand years ago, during the War of the Ancients, the mighty demigod, Agamaggan, came forth to battle the Burning Legion. Though the colossal boar fell in combat, his actions helped save Azeroth from ruin. Yet over time, in the areas where his blood fell, massive thorn-ridden vines sprouted from the earth. The quillboar - believed to be the mortal offspring of the mighty god, came to occupy these regions and hold them sacred. The heart of these thorn-colonies was known as the Razorfen. The great mass of Razorfen Kraul was conquered by the old crone, Charlga Razorflank. Under her rule, the shamanistic quillboar stage attacks on rival tribes as well as Horde villages. Some speculate that Charlga has even been negotiating with agents of the Scourge - aligning her unsuspecting tribe with the ranks of the Undead for some insidious purpose.",
	},
	[17] = {
		["ZoneName"] = "Scarlet Monastery",
		["Location"] = "Tirisfal Glades",
		["LevelRange"] = "34-45",
		["PlayerLimit"] = "10",
		["texture"] = "ScarletMonastery",
		["infoline"] = "The Monastery was once a proud bastion of Lordaeron's priesthood - a center for learning and enlightenment. With the rise of the undead Scourge during the Third War, the peaceful Monastery was converted into a stronghold of the fanatical Scarlet Crusade. The Crusaders are intolerant of all non-human races, regardless of alliance or affiliation. They believe that any and all outsiders are potential carriers of the undead plague - and must be destroyed. Reports indicate that adventurers who enter the monastery are forced to contend with Scarlet Commander Mograine - who commands a large garrison of fanatically devoted warriors. However, the monastery's true master is High Inquisitor Whitemane - a fearsome priestess who possesses the ability to resurrect fallen warriors to do battle in her name.",
	},
	[18] = {
		["ZoneName"] = "Scholomance",
		["Location"] = "Western Plaguelands",
		["LevelRange"] = "56-60",
		["PlayerLimit"] = "5",
		["texture"] = "Scholomance",
		["infoline"] = "The Scholomance is housed within a series of crypts that lie beneath the ruined keep of Caer Darrow. Once owned by the noble Barov family, Caer Darrow fell to ruin following the Second War. As the wizard Kel'thuzad enlisted followers for his Cult of the Damned he would often promise immortality in exchange for serving his Lich King. The Barov family fell to Kel'thuzad's charismatic influence and donated the keep and its crypts to the Scourge. The cultists then killed the Barovs and turned the ancient crypts into a school for necromancy known as the Scholomance. Though Kel'thuzad no longer resides in the crypts, devoted cultists and instructors still remain. The powerful lich, Ras Frostwhisper, rules over the site and guards it in the Scourge's name - while the mortal necromancer, Darkmaster Gandling, serves as the school's insidious headmaster.",
	},
	[19] = {
		["ZoneName"] = "Shadowfang Keep",
		["Location"] = "Silverpine Forest",
		["LevelRange"] = "22-30",
		["PlayerLimit"] = "10",
		["texture"] = "ShadowfangKeep",
		["infoline"] = "During the Third War, the wizards of the Kirin Tor battled against the undead armies of the Scourge. When the wizards of Dalaran died in battle, they would rise soon after - adding their former might to the growing Scourge. Frustrated by their lack of progress (and against the advice of his peers), the Archmage Arugal elected to summon extra-dimensional entities to bolster Dalaran's diminishing ranks. Arugal's summoning brought the ravenous worgen into the world of Azeroth. The feral wolf-men slaughtered not only the Scourge, but quickly turned on the wizards themselves. The worgen sieged the keep of the noble, Baron Silverlaine. Situated above the tiny hamlet of Pyrewood, the keep quickly fell into shadow and ruin. Driven mad with guilt, Arugal adopted the worgen as his children and retreated to the newly dubbed 'Shadowfang Keep'. It's said he still resides there, protected by his massive pet, Fenrus - and haunted by the vengeful ghost of Baron Silverlaine.",
	},
	[20] = {
		["ZoneName"] = "Stratholme",
		["Location"] = "Eastern Plaguelands",
		["LevelRange"] = "55-60",
		["PlayerLimit"] = "5",
		["texture"] = "Stratholme",
		["infoline"] = "Once the jewel of northern Lordaeron, the city of Stratholme is where Prince Arthas turned against his mentor, Uther Lightbringer, and slaughtered hundreds of his own subjects who were believed to have contracted the dreaded plague of undeath. Arthas' downward spiral and ultimate surrender to the Lich King soon followed. The broken city is now inhabited by the undead Scourge - led by the powerful lich, Kel'thuzad. A contingent of Scarlet Crusaders, led by Grand Crusader Dathrohan, also holds a portion of the ravaged city. The two sides are locked in constant, violent combat. Those adventurers brave (or foolish) enough to enter Stratholme will be forced to contend with both factions before long. It is said that the city is guarded by three massive watchtowers, as well as powerful necromancers, banshees and abominations. There have also been reports of a malefic Death Knight riding atop an unholy steed - dispensing indiscriminate wrath on all those who venture within the realm of the Scourge.",
	},
	[21] = {
		["ZoneName"] = "The Deadmines",
		["Location"] = "Westfall",
		["LevelRange"] = "17-26",
		["PlayerLimit"] = "10",
		["texture"] = "TheDeadmines",
		["infoline"] = "Once the greatest gold production center in the human lands, the Dead Mines were abandoned when the Horde razed Stormwind city during the First War. Now the Defias Brotherhood has taken up residence and turned the dark tunnels into their private sanctum. It is rumored that the thieves have conscripted the clever goblins to help them build something terrible at the bottom of the mines - but what that may be is still uncertain. Rumor has it that the way into the Deadmines lies through the quiet, unassuming village of Moonbrook.",
	},
	[22] = {
		["ZoneName"] = "The Stockade",
		["Location"] = "Stormwind",
		["LevelRange"] = "23-26",
		["PlayerLimit"] = "10",
		["texture"] = "TheStockades",
		["infoline"] = "The Stockades are a high-security prison complex, hidden beneath the canal district of Stormwind city. Presided over by Warden Thelwater, the Stockades are home to petty crooks, political insurgents, murderers and a score of the most dangerous criminals in the land. Recently, a prisoner-led revolt has resulted in a state of pandemonium within the Stockades - where the guards have been driven out and the convicts roam free. Warden Thelwater has managed to escape the holding area and is currently enlisting brave thrill-seekers to venture into the prison and kill the uprising's mastermind - the cunning felon, Bazil Thredd.",
	},
	[23] = {
		["ZoneName"] = "The Temple of Atal'Hakkar",
		["Location"] = "Swamp of Sorrows",
		["LevelRange"] = "45-55",
		["PlayerLimit"] = "10",
		["texture"] = "TheSunkenTemple",
		["infoline"] = "Over a thousand years ago, the powerful Gurubashi Empire was torn apart by a massive civil war. An influential group of troll priests, known as the Atal'ai, attempted to bring back an ancient blood god named Hakkar the Soulflayer. Though the priests were defeated and ultimately exiled, the great troll empire buckled in upon itself. The exiled priests fled far to the north, into the Swamp of Sorrows. There they erected a great temple to Hakkar - where they could prepare for his arrival into the physical world. The great dragon Aspect, Ysera, learned of the Atal'ai's plans and smashed the temple beneath the marshes. To this day, the temple's drowned ruins are guarded by the green dragons who prevent anyone from getting in or out. However, it is believed that some of the fanatical Atal'ai may have survived Ysera's wrath - and recommitted themselves to the dark service of Hakkar.",
	},
	[24] = {
		["ZoneName"] = "Uldaman",
		["Location"] = "The Badlands",
		["LevelRange"] = "35-47",
		["PlayerLimit"] = "10",
		["texture"] = "Uldaman",
		["infoline"] = "Uldaman is an ancient Titan vault that has laid buried deep within the earth since the world's creation. Dwarven excavations have recently penetrated this forgotten city, releasing the Titans' first failed creations: the troggs. Legends say that the Titans created troggs from stone. When they deemed the experiment a failure, the Titans locked the troggs away and tried again - resulting in the creation of the dwarven race. The secrets of the dwarves' creation are recorded on the fabled Discs of Norgannon - massive Titan artifacts that lie at the very bottom of the ancient city. Recently, the Dark Iron dwarves have launched a series of incursions into Uldaman, hoping to claim the discs for their fiery master, Ragnaros. However, protecting the buried city are several guardians - giant constructs of living stone that crush any hapless intruders they find. The Discs themselves are guarded by a massive, sentient Stonekeeper called Archaedas. Some rumors even suggest that the dwarves' stone-skinned ancestors, the earthen, still dwell deep within the city's hidden recesses.",
	},
	[25] = {
		["ZoneName"] = "Wailing Caverns",
		["Location"] = "The Barrens",
		["LevelRange"] = "17-24",
		["PlayerLimit"] = "10",
		["texture"] = "WailingCaverns",
		["infoline"] = "Recently, a night elf druid named Naralex discovered a network of underground caverns within the heart of the Barrens. Dubbed the 'Wailing Caverns', these natural caves were filled with steam fissures which produced long, mournful wails as they vented. Naralex believed he could use the caverns' underground springs to restore lushness and fertility to the Barrens - but to do so would require siphoning the energies of the fabled Emerald Dream. Once connected to the Dream however, the druid's vision somehow became a nightmare. Soon the Wailing Caverns began to change - the waters turned foul and the once-docile creatures inside metamorphosed into vicious, deadly predators. It is said that Naralex himself still resides somewhere inside the heart of the labyrinth, trapped beyond the edges of the Emerald Dream. Even his former acolytes have been corrupted by their master's waking nightmare - transformed into the wicked Druids of the Fang.",
	},
	[26] = {
		["ZoneName"] = "Zul'Farrak",
		["Location"] = "Tanaris Desert",
		["LevelRange"] = "43-47",
		["PlayerLimit"] = "10",
		["texture"] = "ZulFarrak",
		["infoline"] = "This sun-blasted city is home to the Sandfury trolls, known for their particular ruthlessness and dark mysticism. Troll legends tell of a powerful sword called Sul'thraze the Lasher, a weapon capable of instilling fear and weakness in even the most formidable of foes. Long ago, the weapon was split in half. However, rumors have circulated that the two halves may be found somewhere within Zul'Farrak's walls. Reports have also suggested that a band of mercenaries fleeing Gadgetzan wandered into the city and became trapped. Their fate remains unknown. But perhaps most disturbing of all are the hushed whispers of an ancient creature sleeping within a sacred pool at the city's heart - a mighty demigod who will wreak untold destruction upon any adventurer foolish enough to awaken him.",
	},
	[27] = {
		["ZoneName"] = "Zul'Gurub",
		["Location"] = "Stranglethorn Vale",
		["LevelRange"] = "60+",
		["PlayerLimit"] = "20",
		["texture"] = "ZulGurub",
		["infoline"] = "Over a thousand years ago the powerful Gurubashi Empire was torn apart by a massive civil war. An influential group of troll priests, known as the Atal'ai, called forth the avatar of an ancient and terrible blood god named Hakkar the Soulflayer. Though the priests were defeated and ultimately exiled, the great troll empire collapsed upon itself. The exiled priests fled far to the north, into the Swamp of Sorrows, where they erected a great temple to Hakkar in order to prepare for his arrival into the physical world.",
	},
	[28] = {
		["ZoneName"] = "Ahn'Qiraj",
		["Location"] = "Silithus",
		["LevelRange"] = "60+",
		["PlayerLimit"] = "40",
		["texture"] = "TempleofAhnQiraj",
		["infoline"] = "At the heart of Ahn'Qiraj lies an ancient temple complex. Built in the time before recorded history, it is both a monument to unspeakable gods and a massive breeding ground for the qiraji army. Since the War of the Shifting Sands ended a thousand years ago, the Twin Emperors of the qiraji empire have been trapped inside their temple, barely contained behind the magical barrier erected by the bronze dragon Anachronos and the night elves. Now that the Scepter of the Shifting Sands has been reassembled and the seal has been broken, the way into the inner sanctum of Ahn'Qiraj is open. Beyond the crawling madness of the hives, beneath the Temple of Ahn'Qiraj, legions of qiraji prepare for invasion. They must be stopped at all costs before they can unleash their voracious insectoid armies on Kalimdor once again, and a second War of the Shifting Sands breaks loose!",
	},
	[29] = {
		["ZoneName"] = "Ruins of Ahn'Qiraj",
		["Location"] = "Silithus",
		["LevelRange"] = "60+",
		["PlayerLimit"] = "20",
		["texture"] = "RuinsofAhnQiraj",
		["infoline"] = "During the final hours of the War of the Shifting Sands, the combined forces of the night elves and the four dragonflights drove the battle to the very heart of the qiraji empire, to the fortress city of Ahn'Qiraj. Yet at the city gates, the armies of Kalimdor encountered a concentration of silithid war drones more massive than any they had encountered before. Ultimately the silithid and their qiraji masters were not defeated, but merely imprisoned inside a magical barrier, and the war left the cursed city in ruins. A thousand years have passed since that day, but the qiraji forces have not been idle. A new and terrible army has been spawned from the hives, and the ruins of Ahn'Qiraj are teeming once again with swarming masses of silithid and qiraji. This threat must be eliminated, or else all of Azeroth may fall before the terrifying might of the new qiraji army.",
	},
	[30] = {
		["ZoneName"] = "Naxxramas",
		["Location"] = "Eastern Plaguelands",
		["LevelRange"] = "60+",
		["PlayerLimit"] = "40",
		["texture"] = "Naxxramas",
		["infoline"] = "Floating above the Plaguelands, the necropolis known as Naxxramas serves as the seat of one of the Lich King's most powerful officers, the dreaded lich Kel'Thuzad. Horrors of the past and new terrors yet to be unleashed are gathering inside the necropolis as the Lich King's servants prepare their assault. Soon the Scourge will march again...",
	},
};
