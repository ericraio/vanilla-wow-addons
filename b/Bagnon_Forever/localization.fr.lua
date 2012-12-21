--[[
	Bagnon Forever Localization file
		This provides a way to translate Bagnon_Forever into different languages.
--]]

--[[
	French   by   namAtsar
--]]

if ( GetLocale() == "frFR" ) then
	--[[ Slash Commands ]]--

	BAGNON_FOREVER_COMMAND_DELETE_CHARACTER = "delete"

	--[[ Messages from the slash commands ]]--

	--/bgn help
	BAGNON_FOREVER_HELP_DELETE_CHARACTER = "/bgn " .. BAGNON_FOREVER_COMMAND_DELETE_CHARACTER .. 
		" <character> <realm> - Supprime les donn\195\169s des sacs et la banque du personnage .";

	--/bgn delete <character> <realm>
	BAGNON_FOREVER_CHARACTER_DELETED = "Supprime les donn\195\169s des sacs de %s de %s.";

	--[[ System Messages ]]--

	--Bagnon Forever version update
	BAGNON_FOREVER_UPDATED = "Bagnon Forever donn\195\169s \195\160 jour v" .. BAGNON_FOREVER_VERSION .. ".";

	--[[ Tooltips ]]--

	--Title tooltip
	--BAGNON_TITLE_FOREVERTOOLTIP = "<Double-Clic> pour changer de personnage.";

	--Total gold on realm
	BAGNON_FOREVER_MONEY_ON_REALM = "Total d\'argent de %s";
	return;
end