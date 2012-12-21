--[[ TinyTip by Thrae
-- 
--
-- English Localization (Default)
-- 
-- TinyTipLocale should be defined in your FIRST localization
-- code.
--
-- Note: Localized slash commands are in TinyTipChatLocale_enEN.
-- 
--]]

if TinyTipLocale then
	-- slash commands
	SLASH_TINYTIP1 = "/tinytip"
	SLASH_TINYTIP2 = "/ttip"

	-- TinyTipUtil
	TinyTipLocale_InitDB1		= "Empty profile. Setting with defaults..."
	TinyTipLocale_InitDB2		= "Defaults set."
	TinyTipLocale_InitDB3		= "New database version detected. Migrating..."
	TinyTipLocale_InitDB4		= "Migration complete."
	TinyTipLocale_InitDB5		= "Ready."

	TinyTipLocale_DefaultDB1	= "All settings are now back to default."
	TinyTipLocale_DefaultDB2	= "Error - Database version mismatch."

	-- TinyTip core
	TinyTipLocale_Tapped		= "Tapped"
	TinyTipLocale_RareElite		= string.format("%s %s", getglobal("ITEM_QUALITY3_DESC"), getglobal("ELITE") )

	TinyTipLocale_Level = getglobal("LEVEL")

	TinyTipLocale = nil -- we no longer need this
end
