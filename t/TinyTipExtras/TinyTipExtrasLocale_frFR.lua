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

if TinyTipExtrasLocale and TinyTipExtrasLocale == "frFR" then
	-- TinyTipTargets
	TinyTipTargetsLocale_Targeting		= "Optimisation"	-- babelfish
	TinyTipTargetsLocale_YOU					= "<<VOUS>>"			-- babelfish
	TinyTipTargetsLocale_TargetedBy		= "Vis\195\168 pr\195\169s" -- babelfish

	-- TinyTipExtras core
	TinyTipExtrasLocale_Buffs = "Buffs"
	TinyTipExtrasLocale_DispellableDebuffs = "Dispellable"
	TinyTipExtrasLocale_DebuffMap = {
		["Magic"] = "|cFF5555FFMagic|r",
		["Poison"] = "|cFFFF5555Poison|r",
		["Curse"] = "|cFFFF22FFCurse|r",
		["Disease"] = "|cFF555555Disease|r" }

	TinyTipExtrasLocale = nil -- we no longer need this
end
