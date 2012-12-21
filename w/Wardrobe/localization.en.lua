--[[
--------------------------------------------------
	File: localization.en.lua
	Addon: Wardrobe
	Language: English
	Translation by : AnduinLothar
	Last Update : 4/9/2006
--------------------------------------------------
]]--

Localization.RegisterGlobalAddonStrings("enUS", "Wardrobe", {

	-- Binding Configuration
	BINDING_HEADER_WARDROBE_HEADER    = "Wardrobe";
	BINDING_NAME_WARDROBE1_BINDING    = "Outfit 1";
	BINDING_NAME_WARDROBE2_BINDING    = "Outfit 2";
	BINDING_NAME_WARDROBE3_BINDING    = "Outfit 3";
	BINDING_NAME_WARDROBE4_BINDING    = "Outfit 4";
	BINDING_NAME_WARDROBE5_BINDING    = "Outfit 5";
	BINDING_NAME_WARDROBE6_BINDING    = "Outfit 6";
	BINDING_NAME_WARDROBE7_BINDING    = "Outfit 7";
	BINDING_NAME_WARDROBE8_BINDING    = "Outfit 8";
	BINDING_NAME_WARDROBE9_BINDING    = "Outfit 9";
	BINDING_NAME_WARDROBE10_BINDING   = "Outfit 10";
	BINDING_NAME_WARDROBE11_BINDING   = "Outfit 11";
	BINDING_NAME_WARDROBE12_BINDING   = "Outfit 12";
	BINDING_NAME_WARDROBE13_BINDING   = "Outfit 13";
	BINDING_NAME_WARDROBE14_BINDING   = "Outfit 14";
	BINDING_NAME_WARDROBE15_BINDING   = "Outfit 15";
	BINDING_NAME_WARDROBE16_BINDING   = "Outfit 16";
	BINDING_NAME_WARDROBE17_BINDING   = "Outfit 17";
	BINDING_NAME_WARDROBE18_BINDING   = "Outfit 18";
	BINDING_NAME_WARDROBE19_BINDING   = "Outfit 19";
	BINDING_NAME_WARDROBE20_BINDING   = "Outfit 20";
	
})
	
Localization.RegisterAddonStrings("enUS", "Wardrobe", {
	
	-- Configuration
	CONFIG_HEADER				= "Wardrobe";
	CONFIG_HEADER_INFO			= "Wardrobe lets you define and switch amongst up to 20 distinct equipment profiles.";
	
	CONFIG_ENABLED				= "Enable Wardrobe";
	CONFIG_ENABLED_INFO			= "Check to enable the plugin.";
	
	CONFIG_RESET_BUTTON			= "Reset";
	CONFIG_RESET				= "Reset Wardrobe Data";
	CONFIG_RESET_INFO			= "Clear all outfits!";
	CONFIG_RESET_FEEDBACK		= "All wardrobe data has been reset.";
	
	CONFIG_KEY_HEADER			= "Outfit Color Key";
	
	CONFIG_OPTIONS_HEADER		= "Options";
	
	CONFIG_WEAROUTFIT			= "Wear Outfit";
	CONFIG_WEAROUTFIT_INFO		= "Equip the items fromt he outfit of your choice.";
	CONFIG_WEAROUTFIT_FEEDBACK	= "You have equipped \"%s\".";
	
	CONFIG_EDIT_BUTTON			= "Edit";
	CONFIG_EDIT					= "Edit Wardrobe Outfits";
	CONFIG_EDIT_INFO			= "Open the outfit edit control panel.";
	CONFIG_EDIT_FEEDBACK		= "Openning outfit edit control panel.";
	
	CONFIG_REQCLICK				= "Require Click for Outfit Menu";
	CONFIG_REQCLICK_INFO		= "Show the minimap button outfit menu only when it is clicked.";
	
	CONFIG_LOCKBUTTON			= "Lock the Minimap Button Position";
	CONFIG_LOCKBUTTON_INFO		= "Do no allow minimap button to be dragged.";
	
	CONFIG_DROPDOWNSCALE			= "Set the Dropdown List Scale";
	CONFIG_DROPDOWNSCALE_INFO		= "Set the Dropdown List Scale";
	CONFIG_DROPDOWNSCALE_FEEDBACK	= "Dropdown List Scale set to %s%%.";
	
	CHAT_COMMAND_INFO      = "";
	
	TEXT_MENU_TITLE		= " Outfits";
	TEXT_MENU_OPEN		= "[MENU]";
	NAME_LABEL			= "Name Your Current Outfit";
	
	PLAGUEBUTTON_TIP1   = "Wear the selected outfit\nwhen you enter the\nPlaguelands.";
	MOUNTBUTTON_TIP1    = "Wear the selected outfit\nwhen you mount.";
	MOUNTBUTTON_TIP2    = "Auto-mount equipment swap requires the IsMounted Addon.";
	EATDRINKBUTTON_TIP1 = "Wear the selected outfit\nwhen you are eating\nor drinking.";
	COLORBUTTON_TIP1    = "Set the color of the\nselected outfit.";
	EDITBUTTON_TIP1     = "Edit the selected outfit.";
	UPDATEBUTTON_TIP1   = "Update the selected outfit with\nwhat you're currently wearing.";
	DELETEBUTTON_TIP1   = "Delete the selected outfit.";
	DOWNBUTTON_TIP1     = "Move the selected outfit\ndown the list.";
	UPBUTTON_TIP1       = "Move the selected outfit\nup the list.";
	
	CMD_RESET      = "reset";
	CMD_LIST       = "list";
	CMD_WEAR       = "wear";
	CMD_WEAR2      = "switch";
	CMD_WEAR3      = "use";
	CMD_ON         = "on";
	CMD_OFF        = "off";
	CMD_LOCK       = "lock";
	CMD_UNLOCK     = "unlock";
	CMD_CLICK      = "click";
	CMD_MOUSEOVER  = "mouseover";
	CMD_SCALE      = "scale";
	CMD_VERSION    = "version";
	CMD_HELP       = "help";
	
	TXT_ACCEPT                 = "Accept";
	TXT_CANCEL                 = "Cancel";
	TXT_TOGGLE                 = "Toggle";
	TXT_COLOR                  = "Color";
	TXT_EDITOUTFITS            = "Edit Outfits";
	TXT_NEW                    = "New";
	TXT_CLOSE                  = "Close";
	TXT_SELECTCOLOR            = "Select a Color";
	TXT_OK                     = "OK";
	TXT_WPLAGUELANDS           = "Western Plaguelands";
	TXT_EPLAGUELANDS           = "Eastern Plaguelands";
	TXT_STRATHOLME             = "Stratholme";
	TXT_SCHOLOMANCE            = "Scholomance";
	TXT_WARDROBEVERSION        = "Wardrobe version";
	TXT_OUTFITNAMEEXISTS       = "An outfit with the same name already exists!  Please use a different name.";
	TXT_USEDUPALL              = "You've used up all";
	TXT_OFYOUROUTFITS          = "of your outfits on this character.  Please delete one before creating another.";
	TXT_OUTFIT                 = "Outfit";
	TXT_PLEASEENTERNAME        = "Please enter an outfit name to update with your currently equipped items.";
	TXT_OUTFITNOTEXIST         = "That outfit name doesn't exist!  Please select an existing outfit to update with your currently equipped items.";
	TXT_NOTEXISTERROR          = "Outfit name doesn't exist!";
	TXT_UPDATED                = "updated";
	TXT_DELETED                = "deleted.";
	TXT_UNABLETOFIND           = "Unable to find an outfit named";
	TXT_UNABLEFINDERROR        = "Unable to find outfit!";
	TXT_ALLOUTFITSDELETED      = "All outfits deleted!";
	TXT_YOURCURRENTARE         = "Your current outfits are:";
	TXT_NOOUTFITSFOUND         = "No outfits found!";
	TXT_SPECIFYOUTFITTOWEAR    = "Please specify an outfit to wear.";
	TXT_UNABLEFIND             = "Unable to find";
	TXT_INYOURLISTOFOUTFITS    = "in your list of outfits!";
	TXT_SWITCHINGTOOUTFIT      = "Switching to outfit";
	TXT_WARNINGUNABLETOFIND    = "Warning: Unable to find item";
	TXT_INYOURBAGS             = "in your bags!";
	TXT_SWITCHEDTOOUTFIT       = "Wardrobe: Switched to outfit";
	TXT_PROBLEMSCHANGING       = "Wardrobe: Problems changing outfits.  Bags might be full.";
	TXT_OUTFITRENAMEDERROR     = "Outfit renamed.";
	TXT_OUTFITRENAMEDTO        = "Renamed outfit";
	TXT_TOWORDONLY             = "to";
	TXT_UNABLETOFINDOUTFIT     = "Unable to find outfit";
	TXT_WILLBEWORNWHENMOUNTED  = "will be worn when mounted.";
	TXT_BUTTONLOCKED           = "Wardrobe button locked.  To reposition, use /wardrobe unlock";
	TXT_BUTTONUNLOCKED         = "Wardrobe button unlocked.  You may reposition the wardrobe button.  To lock the button in place, use /wardrobe lock";
	TXT_BUTTONONCLICK          = "Wardrobe menu shown on click.";
	TXT_BUTTONONMOUSEOVER      = "Wardrobe menu shown on mouseover.";
	TXT_MOUNTEDNOTEXIST        = "That outfit doesn't exist.  Please enter an existing outfit to use when mounted.";
	TXT_ERRORINCONFIG          = "Error in Wardrobe_ShowWardrobeConfigurationScreen: Wardrobe_Config.DefaultCheckboxState has unknown value of ";
	TXT_CHANGECANCELED         = "Wardrobe change canceled!";
	TXT_NEWOUTFITNAME          = "New Outfit Name";
	TXT_NOLONGERWORNMOUNTERR   = "will no longer be worn when you mount.";
	TXT_WORNWHENMOUNTERR       = "will now be worn when you mount.";
	TXT_NOLONGERWORNPLAGUEERR  = "will no longer be worn when you are in the Plaguelands.";
	TXT_WORNPLAGUEERR          = "will now be worn when you are in the Plaguelands.";
	TXT_NOLONGERWORNEATERR     = "will no longer be worn when you are eating / drinking.";
	TXT_WORNEATERR             = "will now be worn when you are eating / drinking.";
	TXT_WORNSWIMR			   = "will now be worn when you swim.";
	TXT_NOLONGERWORNSWIMR	   = "will no longer be worn when you swim.";
	TXT_REALLYDELETEOUTFIT     = "Really Delete This Outfit?";
	TXT_PLEASESELECTDELETE     = "Please select an outfit to delete!";
	TXT_WARDROBENAME           = "Wardrobe";
	TXT_WARDROBEBUTTON         = "Wardrobe Button";
	TXT_ENABLED			       = "Wardrobe Enabled.";
	TXT_DISABLED			   = "Wardrobe Disabled.";
	TXT_NO_OUTFIT				= "<no outfit>";
	
	TITAN_BUTTON_TEXT			= "Wardrobe: ";
	TITAN_TOOLTIP_TEXT			= "Select your outfit or configure Wardrobe";
	TITAN_MENU_SHOW_MINIMAP_ICON	= "Show minimap icon";
	TITAN_MENU_SMALL_MENU		= "Small outfit menu";
	
	HELP_1		= "Wardrobe, an AddOn by AnduinLothar, Miravlix  and Cragganmore, Version ";
	HELP_2		= "Wardrobe allows you to define and switch among up to 20 different outfits.";
	HELP_3		= "The main interface can be accessed from the Wardrobe icon, which defaults";
	HELP_4		= "to just under your minimap/radar.  You may also use the following commands:";
	HELP_5		= "Usage: /wardrobe <wear/list/reset/lock/unlock/click/mouseover/scale>";
	HELP_6		= "   wear [outfit name] - Wear the specified outfit.";
	HELP_7		= "   list - List your outfits.";
	HELP_8		= "   reset - Delete all outfits in your wardrobe.";
	HELP_9		= "   lock/unlock - Lock or unlock moving the wardrobe icon interface.";
	HELP_10		= "   click/mouseover - Show the wardrobe menu on mouseover or only on click.";
	HELP_11		= "   scale [0.5 - 1.0] - Set the scale of the drop down menu.";
	HELP_12		= "In the UI, outfit names are colored as follows:";
	HELP_13		= "   Bright Colored: Your currently equipped outfit.";
	HELP_14		= "   Drab Colored: An outfit where one or more items aren't currently equipped.";
	HELP_15		= "   Grey: An outfit where one or more items aren't in your inventory.";
	HELP_16		= "   Greyed outfits may still be equipped.  The missing items just won't be worn.";

})
