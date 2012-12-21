--[[ THIS FILE IS ENCODED IN UTF-8 ]]--

--[[
	Bagnon Forever Localization file
		This provides a way to translate Bagnon_Forever into different languages.
--]]

--[[
	Chinese    by   Diablohu
--]]

if ( GetLocale() == "zhCN" ) then
	--[[ Slash Commands ]]--
	
	BAGNON_FOREVER_COMMAND_DELETE_CHARACTER = "delete"
	
	--[[ Messages from the slash commands ]]--
	
	--/bgn help
	BAGNON_FOREVER_HELP_DELETE_CHARACTER = "/bgn " .. BAGNON_FOREVER_COMMAND_DELETE_CHARACTER .. 
		" <角色> <服务器> - 删除该角色的背包和银行数据。";
	
	--/bgn delete <character> <realm>
	BAGNON_FOREVER_CHARACTER_DELETED = "删除%s(%s)的背包数据。";
	
	--[[ System Messages ]]--
	
	--Bagnon Forever version update
	BAGNON_FOREVER_UPDATED = "Bagnon Forever 数据更新至 v" .. BAGNON_FOREVER_VERSION .. "。";
	
	--[[ Tooltips ]]--
	
	--Title tooltip
	--BAGNON_TITLE_FOREVERTOOLTIP = "<双击>切换角色";
	
	--Total gold on realm
	BAGNON_FOREVER_MONEY_ON_REALM = "%s服务器上的总资产";
end