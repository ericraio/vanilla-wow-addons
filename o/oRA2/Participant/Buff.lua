assert( oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRAPBuff")

local buffs = {
	["PowerWordFortitude"] = { 1, 1},
	["PrayerOfFortitude"] = {1, 2},
	["MarkOfTheWild"] = {2, 1},
	["GiftOfTheWild"] = {2, 2},
	["ArcaneIntellect"] = {3, 1},
	["ArcaneBrilliance"] = {3, 2},
	-- 4 missing from CTRA as well.
	["ShadowProtection"] = {5, 1},
	["PrayerofShadowProtection"] = {5, 2},
	["PowerWordShield"] = {6, 0},
	["SoulstoneResurrection"] = {7, 0},
	["DivineSpirit"] = {8, 1},
	["PrayerOfSpirit"] = {8, 2},
	["Thorns"] = {9, 0},
	["FearWard"] = {10, 0},
	["BlessingOfMight"] = {11, 1},
	["GreaterBlessingOfMight"] = {11, 2},
	["BlessingOfWisdom"] = {12, 1},
	["GreaterBlessingOfWisdom"] = {12, 2},
	["BlessingOfKings"] = {13, 1},
	["GreaterBlessingOfKings"] = {13, 2},
	["BlessingOfSalvation"] = {14, 1},
	["GreaterBlessingOfSalvation"] = {14, 2},
	["BlessingOfLight"] = {15, 1},
	["GreaterBlessingOfLight"] = {15, 2},
	["BlessingOfSanctuary"] = {16, 1},
	["GreaterBlessingOfSanctuary"] = {16, 2},
	["Renew"] = {17, 0},
	["Rejuvenation"] = {18, 0},
	["Regrowth"] = {19, 0},
	["AmplifyMagic"] = {20, 0},
	["DampenMagic"] = {21, 0},
}

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["buffparticipant"] = true,
	["Participant/Buff"] = true,
	["buff"] = true,
	["Buff"] = true,
	["Options for buffs."] = true,

	["PowerWordFortitude"] = "Power Word: Fortitude",
	["PrayerOfFortitude"] = "Prayer of Fortitude",
	["GiftOfTheWild"] = "Gift of the Wild",
	["MarkOfTheWild"] = "Mark of the Wild",
	["ArcaneIntellect"] = "Arcane Intellect",
	["ArcaneBrilliance"] = "Arcane Brilliance",
	["ShadowProtection"] = "Shadow Protection",
	["PrayerofShadowProtection"] = "Prayer of Shadow Protection",
	["PowerWordShield"] = "Power Word: Shield",
	["SoulstoneResurrection"] = "Soulstone Resurrection",
	["DivineSpirit"] = "Divine Spirit",
	["PrayerOfSpirit"] = "Prayer of Spirit",
	["Thorns"] = "Thorns",
	["FearWard"] = "Fear Ward",
	["BlessingOfMight"] = "Blessing of Might",
	["GreaterBlessingOfMight"] = "Greater Blessing of Might",
	["BlessingOfWisdom"] = "Blessing of Wisdom",
	["GreaterBlessingOfWisdom"] = "Greater Blessing of Wisdom",
	["BlessingOfKings"] = "Blessing of Kings",
	["GreaterBlessingOfKings"] = "Greater Blessing of Kings",
	["BlessingOfSalvation"] = "Blessing of Salvation",
	["GreaterBlessingOfSalvation"] = "Greater Blessing of Salvation",
	["BlessingOfLight"] = "Blessing of Light",
	["GreaterBlessingOfLight"] = "Greater Blessing of Light",
	["BlessingOfSanctuary"] = "Blessing of Sanctuary",
	["GreaterBlessingOfSanctuary"] = "Greater Blessing of Sanctuary",
	["Renew"] = "Renew",
	["Rejuvenation"] = "Rejuvenation",
	["Regrowth"] = "Regrowth",
	["AmplifyMagic"] = "Amplify Magic",
	["DampenMagic"] = "Dampen Magic",
} end )

L:RegisterTranslations("koKR", function() return {

	["Participant/Buff"] = "부분/버프",
	["Buff"] = "버프",
	["Options for buffs."] = "버프 설정",

	["PowerWordFortitude"] = "신의 권능: 인내",
	["PrayerOfFortitude"] = "인내의 기원",
	["GiftOfTheWild"] = "야생의 선물",
	["MarkOfTheWild"] = "야생의 징표",
	["ArcaneIntellect"] = "신비한 지능",
	["ArcaneBrilliance"] = "신비한 총명함",
	["ShadowProtection"] = "어둠의 보호",
	["PrayerofShadowProtection"] = "암흑 보호의 기원",
	["PowerWordShield"] = "신의 권능: 보호막",
	["SoulstoneResurrection"] = "영혼석 보관",
	["DivineSpirit"] = "천상의 정신",
	["PrayerOfSpirit"] = "정신력의 기원",
	["Thorns"] = "가시",
	["FearWard"] = "공포의 수호물",
	["BlessingOfMight"] = "힘의 축복",
	["GreaterBlessingOfMight"] = "상급 힘의 축복",
	["BlessingOfWisdom"] = "지혜의 축복",
	["GreaterBlessingOfWisdom"] = "상급 지혜의 축복",
	["BlessingOfKings"] = "왕의 축복",
	["GreaterBlessingOfKings"] = "상급 왕의 축복",
	["BlessingOfSalvation"] = "구원의 축복",
	["GreaterBlessingOfSalvation"] = "상급 구원의 축복",
	["BlessingOfLight"] = "빛의 축복",
	["GreaterBlessingOfLight"] = "상급 빛의 축복",
	["BlessingOfSanctuary"] = "성역의 축복",
	["GreaterBlessingOfSanctuary"] = "상급 성역의 축복",
	["Renew"] = "소생",
	["Rejuvenation"] = "회복",
	["Regrowth"] = "재생",
	["AmplifyMagic"] = "마법 증폭",
	["DampenMagic"] = "마법 감쇠",
} end )

L:RegisterTranslations("zhCN", function() return {
	["buffparticipant"] = "buffparticipant",
	["Participant/Buff"] = "Participant/Buff",
	["buff"] = "buff",
	["Buff"] = "buff",
	["Options for buffs."] = "buff助手选项",

	["PowerWordFortitude"] = "真言术：韧",
	["PrayerOfFortitude"] = "坚韧祷言",
	["GiftOfTheWild"] = "野性赐福",
	["MarkOfTheWild"] = "野性印记",
	["ArcaneIntellect"] = "奥术智慧",
	["ArcaneBrilliance"] = "奥术光辉",
	["ShadowProtection"] = "防护暗影",
	["PrayerofShadowProtection"] = "暗影防护祷言",
	["PowerWordShield"] = "真言术：盾",
	["SoulstoneResurrection"] = "灵魂石复活",
	["DivineSpirit"] = "神圣之灵",
	["PrayerOfSpirit"] = "精神祷言",
	["Thorns"] = "荆棘",
	["FearWard"] = "防护恐惧结界",
	["BlessingOfMight"] = "力量祝福",
	["GreaterBlessingOfMight"] = "强效力量祝福",
	["BlessingOfWisdom"] = "智慧祝福",
	["GreaterBlessingOfWisdom"] = "强效智慧祝福",
	["BlessingOfKings"] = "王者祝福",
	["GreaterBlessingOfKings"] = "强效王者祝福",
	["BlessingOfSalvation"] = "拯救祝福",
	["GreaterBlessingOfSalvation"] = "强效拯救祝福",
	["BlessingOfLight"] = "光明祝福",
	["GreaterBlessingOfLight"] = "强效光明祝福",
	["BlessingOfSanctuary"] = "庇护祝福",
	["GreaterBlessingOfSanctuary"] = "强效庇护祝福",
	["Renew"] = "恢复",
	["Rejuvenation"] = "回春术",
	["Regrowth"] = "愈合",
	["AmplifyMagic"] = "魔法增效",
	["DampenMagic"] = "魔法抑制",
} end )

L:RegisterTranslations("zhTW", function() return {
	["buffparticipant"] = "buffparticipant",
	["Participant/Buff"] = "隊員/增益",
	["buff"] = "增益",
	["Buff"] = "增益",
	["Options for buffs."] = "增益狀態選項",

	["PowerWordFortitude"] = "真言術：韌",
	["PrayerOfFortitude"] = "堅韌禱言",
	["GiftOfTheWild"] = "野性賜福",
	["MarkOfTheWild"] = "野性印記",
	["ArcaneIntellect"] = "祕法智慧",
	["ArcaneBrilliance"] = "祕法光輝",
	["ShadowProtection"] = "暗影防護",
	["PrayerofShadowProtection"] = "防護暗影禱言",
	["PowerWordShield"] = "真言術：盾",
	["SoulstoneResurrection"] = "靈魂石冷卻",
	["DivineSpirit"] = "神聖之靈",
	["PrayerOfSpirit"] = "精神禱言",
	["Thorns"] = "荊棘術",
	["FearWard"] = "防護恐懼結界",
	["BlessingOfMight"] = "力量祝福",
	["GreaterBlessingOfMight"] = "強效力量祝福",
	["BlessingOfWisdom"] = "智慧祝福",
	["GreaterBlessingOfWisdom"] = "強效智慧祝福",
	["BlessingOfKings"] = "王者祝福",
	["GreaterBlessingOfKings"] = "強效王者祝福",
	["BlessingOfSalvation"] = "拯救祝福",
	["GreaterBlessingOfSalvation"] = "強效拯救祝福",
	["BlessingOfLight"] = "光明祝福",
	["GreaterBlessingOfLight"] = "強效光明祝福",
	["BlessingOfSanctuary"] = "庇護祝福",
	["GreaterBlessingOfSanctuary"] = "強效庇護祝福",
	["Renew"] = "恢復",
	["Rejuvenation"] = "回春術",
	["Regrowth"] = "愈合",
	["AmplifyMagic"] = "魔法增效",
	["DampenMagic"] = "魔法抑制",
} end )

L:RegisterTranslations("frFR", function() return {
	--["buffparticipant"] = true,
	--["Participant/Buff"] = true,
	--["buff"] = true,
	--["Buff"] = true,
	["Options for buffs."] = "Options concernant les buffs.",

	["PowerWordFortitude"] = "Mot de pouvoir : Robustesse",
	["PrayerOfFortitude"] = "Pri\195\168re de robustesse",
	["GiftOfTheWild"] = "Don du fauve",
	["MarkOfTheWild"] = "Marque du fauve",
	["ArcaneIntellect"] = "Intelligence des arcanes",
	["ArcaneBrilliance"] = "Illumination des arcanes",
	["ShadowProtection"] = "Protection contre l'ombre",
	["PrayerofShadowProtection"] = "Pri\195\168re de protection contre l'Ombre",
	["PowerWordShield"] = "Mot de pouvoir : Bouclier",
	["SoulstoneResurrection"] = "R\195\169surrection de pierre d'\195\162me",
	["DivineSpirit"] = "Esprit divin",
	["PrayerOfSpirit"] = "Pri\195\168re d'esprit",
	["Thorns"] = "Epines",
	["FearWard"] = "Gardien de la peur",
	["BlessingOfMight"] = "B\195\169n\195\169diction de puissance",
	["GreaterBlessingOfMight"] = "B\195\169n\195\169diction de puissance sup\195\169rieure",
	["BlessingOfWisdom"] = "B\195\169n\195\169diction de sagesse",
	["GreaterBlessingOfWisdom"] = "B\195\169n\195\169diction de sagesse sup\195\169rieure",
	["BlessingOfKings"] = "B\195\169n\195\169diction des rois",
	["GreaterBlessingOfKings"] = "B\195\169n\195\169diction des rois sup\195\169rieure",
	["BlessingOfSalvation"] = "B\195\169n\195\169diction de salut",
	["GreaterBlessingOfSalvation"] = "B\195\169n\195\169diction de salut sup\195\169rieure",
	["BlessingOfLight"] = "B\195\169n\195\169diction de lumi\195\168re",
	["GreaterBlessingOfLight"] = "B\195\169n\195\169diction de lumi\195\168re sup\195\169rieure",
	["BlessingOfSanctuary"] = "B\195\169n\195\169diction de sanctuaire",
	["GreaterBlessingOfSanctuary"] = "B\195\169n\195\169diction de sanctuaire sup\195\169rieure",
	["Renew"] = "R\195\169novation",
	["Rejuvenation"] = "R\195\169cup\195\169ration",
	["Regrowth"] = "R\195\169tablissement",
	["AmplifyMagic"] = "Amplification de la magie",
	["DampenMagic"] = "Att\195\169nuation de la magie",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

oRAPBuff = oRA:NewModule(L["buffparticipant"])

oRAPBuff.defaults = {
}
oRAPBuff.participant = true
oRAPBuff.name = L["Participant/Buff"]
-- oRAPBuff.consoleCmd = L["buff"]
-- oRAPBuff.consoleOptions = {
-- 	type = "group",
-- 	desc = L["Options for buffs."],
-- 	args = {
-- 	}
-- }


------------------------------
--      Initialization      --
------------------------------

function oRAPBuff:OnEnable()
	self:RegisterEvent("SpecialEvents_PlayerBuffGained")
	self:RegisterEvent("SpecialEvents_PlayerBuffLost")
end

function oRAPBuff:OnDisable()
	self:UnregisterAllEvents()
end

------------------------------
--      Event Handlers      --
------------------------------

function oRAPBuff:SpecialEvents_PlayerBuffGained(buff, index)
	if L:HasReverseTranslation( buff ) then
		local ourbuff = L:GetReverseTranslation( buff )
		local timeleft = floor( GetPlayerBuffTimeLeft( index ) + .5 )
		self:SendMessage( "RN " .. timeleft .. " " .. buffs[ourbuff][1] .. " " .. buffs[ourbuff][2] )
	end
end

function oRAPBuff:SpecialEvents_PlayerBuffLost(buff)
	if L:HasReverseTranslation( buff ) then
		local ourbuff = L:GetReverseTranslation( buff )
		-- we send 1 second left on this buff.
		self:SendMessage( "RN 1 ".. buffs[ourbuff][1] .. " " .. buffs[ourbuff][2] )
	end
end
