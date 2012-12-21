assert( oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRAPRaidWarn")

local blockregexs = {
        "%*+ .+ %*+$",
}

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["rw"] = true,
	["raidwarning"] = true,
	["Raidwarning"] = true,
	["Options for raid warning."] = true,
	["Participant/RaidWarn"] = true,
	["Bossblock"] = true,
	["Block messages from Bossmods."] = true,
} end )

L:RegisterTranslations("koKR", function() return {

	["Raidwarning"] = "공격대 경고",
	["Options for raid warning."] = "공격대 경고 설정",
	["Participant/RaidWarn"] = "부분/공격대경고",
	["Bossblock"] = "보스차단",
	["Block messages from Bossmods."] = "보스 모드 관련 메세지 차단",
} end )

L:RegisterTranslations("zhCN", function() return {
	["rw"] = "rw",
	["raidwarning"] = "团队警告",
	["Raidwarning"] = "团队警告",
	["Options for raid warning."] = "团队警告选项",
	["Participant/RaidWarn"] = "Participant/RaidWarn",
	["Bossblock"] = "阻止bossmod预警",
	["Block messages from Bossmods."] = "阻止bossmod预警",
} end )

L:RegisterTranslations("zhTW", function() return {
	["rw"] = "rw",
	["raidwarning"] = "團隊警告",
	["Raidwarning"] = "團隊警告",
	["Options for raid warning."] = "團隊警告選項",
	["Participant/RaidWarn"] = "隊員/團隊警告",
	["Bossblock"] = "阻擋bossmod預警",
	["Block messages from Bossmods."] = "阻擋bossmod的預警訊息",
} end )

L:RegisterTranslations("frFR", function() return {
	--["rw"] = true,
	--["raidwarning"] = true,
	["Raidwarning"] = "Avertissement du raid",
	["Options for raid warning."] = "Options concernant l'avertissement du raid.",
	["Participant/RaidWarn"] = "Participant/Avertissement du raid",
	["Bossblock"] = "BloquerBoss",
	["Block messages from Bossmods."] = "Bloque les messages provenant des bossmods.",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

oRAPRaidWarn = oRA:NewModule(L["raidwarning"])
oRAPRaidWarn.defaults = {
	bossblock = true,
}
oRAPRaidWarn.participant = true
oRAPRaidWarn.name = L["Participant/RaidWarn"]

oRAPRaidWarn.consoleCmd = L["rw"]
oRAPRaidWarn.consoleOptions = {
	type = "group",
	desc = L["Options for raid warning."],
	name = L["Raidwarning"],
	args = {
		[L["Bossblock"]] = {
			name = L["Bossblock"], type = "toggle",
			desc = L["Block messages from Bossmods."],
			get = function() return oRAPRaidWarn.db.profile.bossblock end,
			set = function(v)
				oRAPRaidWarn.db.profile.bossblock = v
			end,
		},
	}
}


------------------------------
--      Initialization      --
------------------------------

function oRAPRaidWarn:OnEnable()
	self.core:RegisterCheck("MS", "oRA_RaidWarnMessage")

	self:RegisterEvent("oRA_RaidWarnMessage")
end

function oRAPRaidWarn:OnDisable()

	self:UnregisterAllEvents()

	self:UnregisterCheck("MS")
end


-------------------------------
--      Event Handlers       --
-------------------------------

function oRAPRaidWarn:oRA_RaidWarnMessage(msg, author)
	if not self.core:IsValidRequest(author) then return end
	msg = self.core:CleanMessage(msg)

	if not msg then return end

	_,_, msg = string.find(msg, "^MS (.+)$")
	
	if not msg then return end

	if self.db.profile.bossblock and self:IsSpam(msg) then return end

	local info = ChatTypeInfo["RAID_WARNING"]

	PlaySound("RaidWarning")

	RaidWarningFrame:AddMessage( author .. ": " .. msg, info.r, info.g, info.b, 1.0, UIERRORS_HOLD_TIME)
end

function oRAPRaidWarn:IsSpam(text)
	if not text then return end
	for _,regex in pairs(blockregexs) do if string.find(text, regex) then return true end end
end
