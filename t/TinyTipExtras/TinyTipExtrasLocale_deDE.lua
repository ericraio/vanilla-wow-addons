--[[ TinyTip by Thrae
-- 
-- German Localization
-- Any wrong words, change them here.
-- 
-- TinyTipLocale should be defined in your FIRST included
-- localization file.
--
-- Contributors:
--]]

if TinyTipExtrasLocale and TinyTipExtrasLocale == "deDE" then
	-- TinyTipTargeting
	TinyTipTargetsLocale_Targeting		= "Ziel:"
	TinyTipTargetsLocale_YOU		= "<<DU>>"
	TinyTipTargetsLocale_TargetedBy	= "im Ziel von"
	
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
