


local L = {
		["physical"] = SPELL_SCHOOL0_CAP,
		["holy"] = SPELL_SCHOOL1_CAP,
		["fire"] = SPELL_SCHOOL2_CAP,
		["nature"] = SPELL_SCHOOL3_CAP,
		["frost"] = SPELL_SCHOOL4_CAP,
		["shadow"] = SPELL_SCHOOL5_CAP,
		["arcane"] = SPELL_SCHOOL6_CAP,
	}

if GetLocale() == "frFR" then
	L["arcane"] = "Arcane"
end

if GetLocale() == "zhTW" then
	L["shadow"] = "暗影"
end

SimpleCombatLog.fixCombatLog = L