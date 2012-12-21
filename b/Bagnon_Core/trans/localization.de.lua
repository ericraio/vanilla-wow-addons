--[[
	Bagnon Localization file
	
	TODO:
		Add some frame strings and other things
		I could probably Babelfish the translation, but most likely it would insult someone's 
			mother or something.
--]]

--[[
	German
		Credit goes to Sarkan on Curse
--]]


if ( GetLocale() == "deDE" ) then
	--[[ Keybindings ]]--

	BINDING_HEADER_BAGNON = "Bagnon";
	BINDING_NAME_BAGNON_TOGGLE = "Zeige Bagnon";
	BINDING_NAME_BANKNON_TOGGLE = "Zeige Banknon";

	--[[ Slash Commands ]]--

	--[[
		These may or may not work, so I've decided to disable non english versions of slash commands
		
		BAGNON_COMMAND_HELP = "hilfe";
		BAGNON_COMMAND_SHOWBAGS = "taschen";
		BAGNON_COMMAND_SHOWBANK = "bank";
		BAGNON_COMMAND_REVERSE = "umgekehrt";
		BAGNON_COMMAND_OVERRIDE_BANK = "bank ansicht \195\164ndern";
	--]]

	--[[ Messages from the slash commands ]]--

	--/bgn help
	BAGNON_HELP_TITLE = "Bagnon Kommandos:";
	BAGNON_HELP_SHOWBAGS = "/bgn " .. BAGNON_COMMAND_SHOWBAGS .. " - Zeige/Verstecke Bagnon.";
	BAGNON_HELP_SHOWBANK = "/bgn " .. BAGNON_COMMAND_SHOWBANK .. " - Zeige/Verstecke Banknon.";
	BAGNON_HELP_HELP = "/bgn " .. BAGNON_COMMAND_HELP .. " - Zeige Slash Kommandos.";

	--[[ System Messages ]]--

	BAGNON_INITIALIZED = "Bagnon inizialisiert. Bitte /bagnon oder /bgn f\195\188r Kommandos";
	BAGNON_UPDATED = "Bagnon Einstellungen aktualisiert auf v" .. BAGNON_VERSION .. ". Bitte /bagnon oder /bgn f\195\188r Kommandos";

	--[[ UI Text ]]--

	--Titles

	--These should probably read Inventory of <player> and Bank of <player> in other versions I guess
	BAGNON_INVENTORY_TITLE = "%s's Inventar";
	BAGNON_BANK_TITLE = "%s's Bank";

	--Bag Button
	BAGNON_SHOWBAGS = "+ Taschen";
	BAGNON_HIDEBAGS = "- Taschen";

	--Options Menu
	BAGNON_OPTIONS_TITLE = "%s Einstellungen";
	BAGNON_OPTIONS_LOCK = "Fixiere Position";
	BAGNON_OPTIONS_BACKGROUND = "Hintergrund";
	BAGNON_OPTIONS_REVERSE = "Drehe Taschenanordnung um";
	BAGNON_OPTIONS_COLUMNS = "Spalte";
	BAGNON_OPTIONS_SPACING = "Abstand";
	BAGNON_OPTIONS_SCALE = "Masstab";
	BAGNON_OPTIONS_OPACITY = "Transparenz";
	BAGNON_OPTIONS_STRATA = "Layer";

	--[[ Tooltips ]]--

	--Title tooltip
	BAGNON_TITLE_TOOLTIP = "<Rechts-Klick> Um Einstellungs Men\195\188 zu zeigen";

	--Bag Tooltips
	BAGNON_BAGS_HIDE = "<Shift-Klick> zum verstecken.";
	BAGNON_BAGS_SHOW = "<Shift-Klick> zum zeigen.";

	--[[ Other ]]--
	--this should be the sixth return value for a bag from GetItemInfo()
	BAGNON_ITEMTYPE_CONTAINER = "Beh\195\164lter";
	BAGNON_ITEMTYPE_QUIVER = "K\195\182cher";
	BAGNON_SUBTYPE_SOULBAG = "Seelentasche";
	BAGNON_SUBTYPE_BAG = "Beh\195\164lter";
	return;
end