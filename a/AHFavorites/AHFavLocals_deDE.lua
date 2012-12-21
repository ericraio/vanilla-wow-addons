--[[---------------------------------------------------------------------------------
  German Localization
  
  $Revision: 1.1 $
  $Date: 2005/10/10 17:35:29 $
------------------------------------------------------------------------------------]]

function AHFav_Locals_deDE()

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

AH_FAV.POPUP_TEXT = "Neuer Suchname:"; 			-- "New Search Name:";
AH_FAV.SAVE = "Speichern"; 						-- "Save";
AH_FAV.CANCEL = "Abbrechen"; 					-- "Cancel";
AH_FAV.DELETE = "L\195\182schen"; 				-- "Delete";
AH_FAV.CLEAR = "Zur\195\188cksetzen"; 			-- "Clear";
AH_FAV.FAVORITES = "Favoriten"; 				-- "Favorites";

end


