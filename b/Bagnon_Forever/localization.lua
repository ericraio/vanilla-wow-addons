--[[
	Bagnon Forever Localization file
		This provides a way to translate Bagnon_Forever into different languages.
--]]

BAGNON_FOREVER_VERSION = "6.6.30";

--[[
	English - Default Language
		Any gaps in the translations are filled by English words.
--]]


--[[ Slash Commands ]]--

BAGNON_FOREVER_COMMAND_DELETE_CHARACTER = "delete"

--[[ Messages from the slash commands ]]--

--/bgn help
BAGNON_FOREVER_HELP_DELETE_CHARACTER = "/bgn " .. BAGNON_FOREVER_COMMAND_DELETE_CHARACTER .. 
	" <character> <realm> - Removes the given character's inventory and bank data.";

--/bgn delete <character> <realm>
BAGNON_FOREVER_CHARACTER_DELETED = "Removed inventory data about %s of %s.";

--[[ System Messages ]]--

--Bagnon Forever version update
BAGNON_FOREVER_UPDATED = "Bagnon Forever data updated to v" .. BAGNON_FOREVER_VERSION .. ".";

--[[ Tooltips ]]--

--Title tooltip
BAGNON_TITLE_FOREVERTOOLTIP = "<Double-Click> to switch characters.";

--Total gold on realm
BAGNON_FOREVER_MONEY_ON_REALM = "Total Funds On %s";

--[[
	German
		Credit goes to Sarkan on Curse
--]]


if ( GetLocale() == "deDE" ) then
	BAGNON_TITLE_FOREVERTOOLTIP = "<Doppel-Klick> um Charakter zu wechseln.";
	return;
end

--[[
	French
--]]

if ( GetLocale() == "frFR" ) then
	return;
end