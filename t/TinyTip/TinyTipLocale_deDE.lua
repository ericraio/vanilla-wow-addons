--[[ TinyTip by Thrae
-- 
-- German Localization
-- Any wrong words, change them here.
-- 
-- TinyTipLocale should be defined in your FIRST included
-- localization file.
--
-- Note: Localized slash commands are in TinyTipChatLocale_deDE.
--
-- Contributors: Slayman
--]]

if TinyTipLocale and TinyTipLocale == "deDE" then
	-- slash commands
	SLASH_TINYTIP1 = "/tinytip"
	SLASH_TINYTIP2 = "/ttip"

	-- TinyTipUtil 
	TinyTipLocale_InitDB1		= "Leeres Profil. Setze Voreinstellungen..."
	TinyTipLocale_InitDB2		= "Voreinstellungen gesetzt."
	TinyTipLocale_InitDB3		= "Neue Datenbankversion entdeckt. Migriere..."
	TinyTipLocale_InitDB4		= "Migration vollständig."
	TinyTipLocale_InitDB5		= "Fertig."

	TinyTipLocale_DefaultDB1	= "Alle Einstellungen zurückgesetzt."
	TinyTipLocale_DefaultDB2	= "Fehler - Datenbankversionen inkompatibel."

	-- TinyTip core
	TinyTipLocale_Tapped		= "Markiert"
	TinyTipLocale_RareElite		= "Elite Rar"

	TinyTipLocale_Level	= "Stufe"
	
	TinyTipLocale = nil -- we no longer need this
end
