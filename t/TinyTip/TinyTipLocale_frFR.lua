--[[ TinyTip by Thrae
-- 
-- French Localization
-- Any wrong words, change them here.
-- 
-- TinyTipLocale should be defined in your FIRST included
-- localization file.
--
-- Note: Localized slash commands are in TinyTipChatLocale_frFR.
--
-- Contributors:
--]]

if TinyTipLocale and TinyTipLocale == "frFR" then
	-- slash commands
	SLASH_TINYTIP1 = "/tinytip"
	SLASH_TINYTIP2 = "/ttip"

	-- TinyTipUtil
	-- NEEDS TRANSLATION
	TinyTipLocale_InitDB1		= "Empty profile. Setting with defaults..."
	TinyTipLocale_InitDB2		= "Defaults set."
	TinyTipLocale_InitDB3		= "New database version detected. Migrating..."
	TinyTipLocale_InitDB4		= "Migration complete."
	TinyTipLocale_InitDB5		= "Ready."

	TinyTipLocale_DefaultDB1	= "All settings are now back to default."
	TinyTipLocale_DefaultDB2	= "Error - Database version mismatch."

	-- TinyTip core
	TinyTipLocale_Tapped		= "Engag\195\169"
	TinyTipLocale_RareElite		= "Elite Rare"

	TinyTipLocale_Level = getglobal("LEVEL")

	TinyTipLocale = nil -- we no longer need this
end

