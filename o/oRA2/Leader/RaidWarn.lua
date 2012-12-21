
assert( oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRALRaidWarn")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["rw"] = true,
	["raidwarningleader"] = true,
	["Raidwarning"] = true,
	["Options for raid warning."] = true,
	["Leader/RaidWarn"] = true,
	["Send"] = true,
	["Send an RS Message."] = true,
	["<message>"] = true,
	["ToRaid"] = true,
	["OldStyle"] = true,
	["To Raid"] = true,
	["Old Style"] = true,
	["Send RS Messages to Raid as well."] = true,
	["Use CTRA RS Messages instead of RaidWarning."] = true,
} end )

L:RegisterTranslations("koKR", function() return {
	["Raidwarning"] = "공격대경보",
	["Options for raid warning."] = "공격대 경보에 관한 설정",
	["Leader/RaidWarn"] = "공격대장/공격대경보",
	["Send"] = "보내기",
	["Send an RS Message."] = "RS메세지로 보내기",
	["<message>"] = "<메세지>",
	["ToRaid"] = "공격대",
	["OldStyle"] = "옛날방식",
	["To Raid"] = "공격대에 보내기",
	["Old Style"] = "옛 방식 사용",
	["Send RS Messages to Raid as well."] = "RS 메세지를 공격대 대화로도 표시합니다.",
	["Use CTRA RS Messages instead of RaidWarning."] = "공격대 경보 대신에 공격대 도우미의 RS 메세지를 사용합니다.",
} end )

L:RegisterTranslations("zhCN", function() return {
	["rw"] = "rw",
	["raidwarningleader"] = "raidwarningleader",
	["Raidwarning"] = "团队报警",
	["Options for raid warning."] = "团队警报选项.",
	["Leader/RaidWarn"] = "Leader/RaidWarn",
	["Send"] = "发送",
	["Send an RS Message."] = "发送一条RS消息",
	["<message>"] = "<message>",
	["ToRaid"] = "发送到RAID",
	["OldStyle"] = "老样式",
	["To Raid"] = "进行RAID",
	["Old Style"] = "老样式",
	["Send RS Messages to Raid as well."] = "RS同时发送一条消息到团队聊天频道",
	["Use CTRA RS Messages instead of RaidWarning."] = "使用CTRA消息取代团队警报",
} end )

L:RegisterTranslations("zhTW", function() return {
	["rw"] = "rw",
	["raidwarningleader"] = "raidwarningleader",
	["Raidwarning"] = "團隊報警",
	["Options for raid warning."] = "團隊警報選項",
	["Leader/RaidWarn"] = "領隊/團隊報警",
	["Send"] = "發送",
	["Send an RS Message."] = "發送RS訊息",
	["<message>"] = "<訊息>",
	["ToRaid"] = "發送到團隊",
	["OldStyle"] = "舊式風格",
	["To Raid"] = "發送到團隊",
	["Old Style"] = "舊式風格",
	["Send RS Messages to Raid as well."] = "發送RS訊息時也發送到團隊頻道",
	["Use CTRA RS Messages instead of RaidWarning."] = "使用團隊助手訊息取代團隊警報",
} end )

L:RegisterTranslations("frFR", function() return {
	--["rw"] = true,
	--["raidwarningleader"] = true,
	["Raidwarning"] = "Avertissement du raid",
	["Options for raid warning."] = "Options concernant l'avertissement du raid.",
	["Leader/RaidWarn"] = "Chef/AvertirRaid",
	["Send"] = "Envoyer",
	["Send an RS Message."] = "Envoye un message RS.",
	--["<message>"] = true,
	--["ToRaid"] = true,
	--["OldStyle"] = true,
	["To Raid"] = "Au raid",
	["Old Style"] = "Ancienne m\195\169thode",
	["Send RS Messages to Raid as well."] = "Envoye les messages RS \195\169galement au canal Raid.",
	["Use CTRA RS Messages instead of RaidWarning."] = "Utilise les messages RS de CTRA au lieu de l'Avertissement Raid.",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

oRALRaidWarn = oRA:NewModule(L["raidwarningleader"])
oRALRaidWarn.defaults = {
	oldstyle = false,
	toraid = false,
}
oRALRaidWarn.leader = true
oRALRaidWarn.name = L["Leader/RaidWarn"]
oRALRaidWarn.consoleCmd = L["rw"]
oRALRaidWarn.consoleOptions = {
	type = "group",
	desc = L["Options for raid warning."],
	name = L["Raidwarning"],
	args = {
		[L["Send"]] = {
			name = L["Send"], type = "text",
			desc = L["Send an RS Message."],
			usage = L["<message>"],
			get = false,
			set = function(v)
				oRALRaidWarn:SendRS(v)
			end,
			validate = function(v)
				return string.find(v, "^(.+)$")
			end,
			disabled = function() return not oRA:IsModuleActive(oRALRaidWarn) or not oRALRaidWarn:IsValidRequest() end,
		},
		[L["ToRaid"]] = {
			name = L["To Raid"], type = "toggle",
			desc = L["Send RS Messages to Raid as well."],
			get = function() return oRALRaidWarn.db.profile.toraid end,
			set = function(v)
				oRALRaidWarn.db.profile.toraid = v
			end,	
		},
		[L["OldStyle"]] = {
			name = L["Old Style"], type = "toggle",
			desc = L["Use CTRA RS Messages instead of RaidWarning."],
			get = function() return oRALRaidWarn.db.profile.oldstyle end,
			set = function(v)
				oRALRaidWarn.db.profile.oldstyle = v
			end,
		},
	}
}

------------------------------
--      Initialization      --
------------------------------

function oRALRaidWarn:OnEnable()
	self:RegisterShorthand("rs", function(msg) self:SendRS(msg) end )
end

function oRALRaidWarn:OnDisable()
	self:UnregisterShorthand("rs")
end

------------------------------
--     Command Handlers     --
------------------------------

function oRALRaidWarn:SendRS(msg)
	if not msg or not oRALRaidWarn:IsValidRequest() then return end
	if self.db.profile.oldstyle then
		self:SendMessage("MS ".. string.gsub(msg, "%%t", UnitName("target") or TARGET_TOKEN_NOT_FOUND) )
	else
		SendChatMessage(msg, "RAID_WARNING")
	end
	if self.db.profile.toraid then SendChatMessage(msg, "RAID") end
end
