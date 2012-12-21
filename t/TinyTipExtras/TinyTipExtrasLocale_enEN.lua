--[[ TinyTip by Thrae
-- 
--
-- English Localization (Default)
-- 
-- TinyTipLocale should be defined in your FIRST localization
-- code.
--]]

if TinyTipExtrasLocale then
	-- TinyTipTargets
	TinyTipTargetsLocale_Targeting		= "Targeting"
	TinyTipTargetsLocale_YOU			= "<<YOU>>"
	TinyTipTargetsLocale_TargetedBy	= "Targeted by"

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
