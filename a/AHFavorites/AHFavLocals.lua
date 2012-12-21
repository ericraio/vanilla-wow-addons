--[[

	English/Default translations for AH Favorites

	$Revision: 1.1 $
	$Date: 2005/10/10 17:35:29 $

]]--

-- All strings will be placed in the AH_FAV table.
AH_FAV = {};
AH_FAV.NAME = "AHFavorites";

-- Default English translations here
if( not ace:LoadTranslation("AHFav") ) then

AH_FAV.DESCRIPTION = "Saves AH searches in a favorites list";
AH_FAV.COMMANDS = {"/AHFavorites", "/AHFav", "/AHFavs"};

AH_FAV.AUTOQUERY = "AutoQuery";
AH_FAV.AUTOQUERY_DESC = "Automatically run a favorite search when selected from the pulldown";

AH_FAV.FSL = "FSL";
AH_FAV.FSL_NAME = "Fizzwidget ShoppingList";
AH_FAV.FSL_SHORT = "ShoppingList";
AH_FAV.FSL_DESC = "List items on Fizzwidget ShoppingList";

AH_FAV.ENABLED = "Enabled";
AH_FAV.DISABLED = "Disabled";

AH_FAV.INIT_MSG = AH_FAV.NAME .. " Initialized";
AH_FAV.ENABLE_MSG = AH_FAV.NAME .. " " .. AH_FAV.ENABLED;
AH_FAV.DISABLE_MSG = AH_FAV.NAME .. " " .. AH_FAV.DISABLED;

AH_FAV.AUTOQUERY_ENABLE_MSG = AH_FAV.NAME .. " " .. AH_FAV.AUTOQUERY .. " " .. AH_FAV.ENABLED;
AH_FAV.AUTOQUERY_DISABLE_MSG = AH_FAV.NAME .. " " .. AH_FAV.AUTOQUERY .. " " .. AH_FAV.DISABLED;

AH_FAV.FSL_ENABLE_MSG = AH_FAV.NAME .. " " .. AH_FAV.FSL_NAME .. " " .. AH_FAV.ENABLED;
AH_FAV.FSL_DISABLE_MSG = AH_FAV.NAME .. " " .. AH_FAV.FSL_NAME .. " " .. AH_FAV.DISABLED;

AH_FAV.POPUP_TEXT = "New Search Name:";
AH_FAV.SAVE = "Save";
AH_FAV.CANCEL = "Cancel";
AH_FAV.DELETE = "Delete";
AH_FAV.CLEAR = "Clear";
AH_FAV.FAVORITES = "Favorites";




end

