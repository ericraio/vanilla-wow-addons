--[[
    Version: $Rev: 2928 $
    Last Changed by: $LastChangedBy: Flisher $
    Date: $Date: 2006-05-28 12:27:21 -0400 (dim., 28 mai 2006) $

    Note: Please don't remove commented line and change the layout of this file, the main goal is to have 3 localization files with the same layout for easy spotting of missing information.
    The SVN tag at the begining of the file will automaticaly update upon uploading.
]]--

-- Default English text

    -- Configuration variables
    SLASH_CHARACTERSVIEWER1                             = "/charactersviewer";
    SLASH_CHARACTERSVIEWER2                             = "/cv";
    CHARACTERSVIEWER_SUBCMD_SHOW                        = "show";
    CHARACTERSVIEWER_SUBCMD_CLEAR                       = "clear";
    CHARACTERSVIEWER_SUBCMD_CLEARALL                    = "clearall";
    CHARACTERSVIEWER_SUBCMD_PREVIOUS                    = "previous";
    CHARACTERSVIEWER_SUBCMD_NEXT                        = "next";
    CHARACTERSVIEWER_SUBCMD_SWITCH                      = "switch";
    CHARACTERSVIEWER_SUBCMD_LIST                        = "list";
    CHARACTERSVIEWER_SUBCMD_BANK                        = "bank";
    CHARACTERSVIEWER_SUBCMD_RESETLOC                    = "resetloc";
    CHARACTERSVIEWER_SUBCMD_BAGS                        = "bags";
    CHARACTERSVIEWER_SUBCMD_BAGUSE                      = "baguse";

    -- Localization text
    BINDING_HEADER_CHARACTERSVIEWER                     = "Characters Viewer";
    BINDING_NAME_CHARACTERSVIEWER_TOGGLE                = "Open / Close CharactersViewer";
    BINDING_NAME_CHARACTERSVIEWER_BANKTOGGLE            = "Open / Close CharactersViewer Bank";
    BINDING_NAME_CHARACTERSVIEWER_SWITCH_PREVIOUS       = "Switch to the previous character";
    BINDING_NAME_CHARACTERSVIEWER_SWITCH_NEXT           = "Switch to the next character";

    CHARACTERSVIEWER_CRIT                               = "Critical";

    CHARACTERSVIEWER_SELPLAYER                          = "Switch";
    CHARACTERSVIEWER_DROPDOWN2                          = "Compare";
    CHARACTERSVIEWER_TOOLTIP_BAGRESET                   = "Left-Click: Toggle bags display on/off.\nRight-Click: Reset layout position.";
    CHARACTERSVIEWER_TOOLTIP_MAIL                       = "Left-Click: Toggle the Inbox(MailTo) display on/off.\nRight-Click: Reset layout position.";
    CHARACTERSVIEWER_TOOLTIP_BANK                       = "Left-Click: Toggle the Bank display on/off.\nRight-Click: Reset layout position.";
    CHARACTERSVIEWER_TOOLTIP_DROPDOWN2                  = "Click to select one of your other characters from the same server,\nit'll be displayed with CharactersViewer Frame";
    CHARACTERSVIEWER_TOOLTIP_BANKBAG                    = "Left-Click: Toggle bank bags display on/off.\nRight-Click: Reset layout position.";
    CHARACTERSVIEWER_SAVEDON                            = "Saved on: ";

    CHARACTERSVIEWER_PROFILECLEARED                     = "This profile has been deleted: ";
    CHARACTERSVIEWER_ALLPROFILECLEARED                  = "Profiles for all server have been cleared. Current character profile added";
    CHARACTERSVIEWER_NOT_FOUND                          = "Character not found: ";

    CHARACTERSVIEWER_USAGE                              = "Usage: '/cv <command>' where <command> is";
    CHARACTERSVIEWER_USAGE_SUBCMD                       = {};
    CHARACTERSVIEWER_USAGE_SUBCMD[1]                    = " show : displays equipment/stats in a PaperDoll window";
    CHARACTERSVIEWER_USAGE_SUBCMD[2]                    = " clear <arg1>: clear the profile of character <arg1>";
    CHARACTERSVIEWER_USAGE_SUBCMD[3]                    = " clearall : clear all stored equipement/stats for all chars in all servers";
    CHARACTERSVIEWER_USAGE_SUBCMD[4]                    = " previous : " .. BINDING_NAME_CHARACTERSVIEWER_SWITCH_PREVIOUS;
    CHARACTERSVIEWER_USAGE_SUBCMD[5]                    = " next : " .. BINDING_NAME_CHARACTERSVIEWER_SWITCH_NEXT;
    CHARACTERSVIEWER_USAGE_SUBCMD[6]                    = " switch <arg1>: Switch to character <arg1>";
    CHARACTERSVIEWER_USAGE_SUBCMD[7]                    = " list : Display various information about player on the current server";
    CHARACTERSVIEWER_USAGE_SUBCMD[8]                    = " bank : Toggle the Bank display on/off";
    CHARACTERSVIEWER_USAGE_SUBCMD[9]                    = " resetloc : Reset the position of the main frame of " .. BINDING_HEADER_CHARACTERSVIEWER;
    CHARACTERSVIEWER_USAGE_SUBCMD[10]                   = " bags : List the bag sizes owned by each character";
    CHARACTERSVIEWER_USAGE_SUBCMD[11]                   = " baguse : List the bag usage of each character";

    CHARACTERSVIEWER_DESCRIPTION                        = "View your other characters equipment, inventory and stats";
    CHARACTERSVIEWER_SHORT_DESC                         = "Toggle CV on/off";
    CHARACTERSVIEWER_ICON                               = "Interface\\Buttons\\Button-Backpack-Up";

    CHARACTERSVIEWER_NOT_CACHED                         = "Item not in local cache";
    CHARACTERSVIEWER_RESTED                             = "rested";
    CHARACTERSVIEWER_RESTING                            = "resting";
    CHARACTERSVIEWER_NOT_RESTING                        = "not resting";
    CHARACTERSVIEWER_BAG_USE                            = "Bags in use on ";

    CHARACTERSVIEWER_BANK_TITLE                         = "CharactersViewer (Bank)";
	CHARACTERSVIEWER_ALLIANCE_HORDE					= "Horde";
   CHARACTERSVIEWER_ALLIANCE_ALLIANCE				= "Alliance";
	CHARACTERSVIEWER_ALLIANCE_TOTAL					= "Total";
	 