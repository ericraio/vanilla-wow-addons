assert( oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRAPMainTank")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["maintank"] = true,
	["MainTank"] = true,
	["mt"] = true,
	["Options for the maintanks."] = true,
	["refresh"] = true,
	["The local maintank list has been refreshed."] = true,
	["Refresh Maintanks"] = true,
	["Refresh the local maintank list."] = true,
	["Participant/MainTank"] = true,
	["notifydeath"] = true,
	["Notify deaths"] = true,
	["Notifies you when a main tank dies."] = true,
	["Tank %s has died!"] = true,

	maintankdies = "^([^%s]+) dies%.$",
} end )

L:RegisterTranslations("koKR", function() return {

	["MainTank"] = "메인탱커",
	["Options for the maintanks."] = "메인탱커 설정",
	["The local maintank list has been refreshed."] = "로컬 메인탱커 목록이 갱신되었습니다.",
	["Refresh Maintanks"] = "메인탱커 갱신",
	["Refresh the local maintank list."] = "로컬 메인탱커 목록을 갱신합니다.",
	["Participant/MainTank"] = "부분/메인탱커",
	["Notify deaths"] = "사망 알림",
	["Notifies you when a main tank dies."] = "메인탱커가 사망시 이를 알려줍니다.",
	["Tank %s has died!"] = "메인탱커 %s|1이;가; 죽었습니다!",

	maintankdies = "^([^%s]+)|1이;가; 죽었습니다%.$",
} end )

L:RegisterTranslations("zhCN", function() return {
	["maintank"] = "MT目标",
	["MainTank"] = "MT目标",
	["mt"] = "MT目标",
	["Options for the maintanks."] = "MT选项",
	["refresh"] = "刷新",
	["The local maintank list has been refreshed."] = "本地MT已刷新",
	["Refresh Maintanks"] = "刷新MT",
	["Refresh the local maintank list."] = "刷新本地MT名单",
	["Participant/MainTank"] = "Participant/MainTank",
	["notifydeath"] = "死亡通知",
	["Notify deaths"] = "死亡通知",
	["Notifies you when a main tank dies."] = "当MT死亡是通知你",
	["Tank %s has died!"] = "MT %s 已死亡！",

	maintankdies = "^(.+)死亡了．",
} end )

L:RegisterTranslations("zhTW", function() return {
	["maintank"] = "主坦",
	["MainTank"] = "主坦",
	["mt"] = "主坦",
	["Options for the maintanks."] = "主坦選項",
	["refresh"] = "更新",
	["The local maintank list has been refreshed."] = "個人主坦名單已更新",
	["Refresh Maintanks"] = "更新主坦",
	["Refresh the local maintank list."] = "更新個人主坦名單",
	["Participant/MainTank"] = "隊員/主坦",
	["notifydeath"] = "死亡通知",
	["Notify deaths"] = "死亡通知",
	["Notifies you when a main tank dies."] = "當主坦死亡時通知你",
	["Tank %s has died!"] = "主坦 %s 已死亡！",

	maintankdies = "^(.+)死亡了．",
} end )

L:RegisterTranslations("frFR", function() return {
	--["maintank"] = true,
	--["MainTank"] = true,
	--["mt"] = true,
	["Options for the maintanks."] = "Options concernant les maintanks.",
	--["refresh"] = true,
	["The local maintank list has been refreshed."] = "La liste locale des maintanks a \195\169t\195\169 rafra\195\174chie.",
	["Refresh Maintanks"] = "Rafra\195\174chir les maintanks",
	["Refresh the local maintank list."] = "Rafra\195\174chit la liste locale des maintanks.",
	["Participant/MainTank"] = "Participant/MainTank",
	--["notifydeath"] = true,
	["Notify deaths"] = "Annoncer les morts",
	["Notifies you when a main tank dies."] = "Pr\195\169viens quand un maintank meurt.",
	["Tank %s has died!"] = "Le tank %s est mort !",

	maintankdies = "^([^%s]+) meurt%.$",
} end )

L:RegisterTranslations("deDE", function() return {
    ["Tank %s has died!"] = "Tank %s ist gestorben!",
    maintankdies = "^([^%s]+) stirbt%.$",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

oRAPMainTank = oRA:NewModule(L["maintank"])
oRAPMainTank.defaults = {
	notifydeath = false,
}
oRAPMainTank.participant = true
oRAPMainTank.name = L["Participant/MainTank"]
oRAPMainTank.consoleCmd = L["mt"]
oRAPMainTank.consoleOptions = {
	type = "group",
	desc = L["Options for the maintanks."],
	name = L["MainTank"],
	args = {
		[L["refresh"]] = {
			name = L["Refresh Maintanks"], type = "execute",
			desc = L["Refresh the local maintank list."],
			func = function()
				oRAPMainTank:Refresh()
			end,
			disabled = function() return not oRA:IsModuleActive(oRAPMainTank) end,
		},
		[L["notifydeath"]] = {
			name = L["Notify deaths"], type = "toggle",
			desc = L["Notifies you when a main tank dies."],
			get = function() return oRAPMainTank.db.profile.notifydeath end,
			set = function(v) oRAPMainTank.db.profile.notifydeath = v end,
		},
	}
}


------------------------------
--      Initialization      --
------------------------------

function oRAPMainTank:OnRegister()
	if not self.core.maintanktable then
		self.core.maintanktable = self.core.db.profile.maintanktable or {}
	end
end

function oRAPMainTank:OnEnable()
	self:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLY_DEATH")
	self:RegisterEvent("oRA_LeftRaid")
	self:RegisterCheck("SET", "oRA_SetMainTank")
	self:RegisterCheck("R", "oRA_RemoveMainTank")
end

function oRAPMainTank:OnDisable()

	self:UnregisterAllEvents()

	self:UnregisterCheck("SET")
	self:UnregisterCheck("R")
end


-------------------------------
--      Event Handlers       --
-------------------------------

function oRAPMainTank:CHAT_MSG_COMBAT_FRIENDLY_DEATH(msg)
	if not self.db.profile.notifydeath then return end
	local _, _, tank = string.find(msg, L["maintankdies"])
	if not tank then return end
	for k, name in pairs(self.core.maintanktable) do
		if name == tank then
			-- I'm pretty sure this is the same sound that CTRA uses, someone
			-- should confirm.
			if BigWigs then
				self:TriggerEvent("BigWigs_Message", string.format(L["Tank %s has died!"], name), "Red", true, false)
			elseif RaidWarningFrame then
				RaidWarningFrame:AddMessage(string.format(L["Tank %s has died!"], name), 1.0, 0, 0, 1.0, UIERRORS_HOLD_TIME)
			end
			PlaySound("igQuestFailed")
		end
	end
end

function oRAPMainTank:oRA_SetMainTank(msg, author)
	if not self:IsValidRequest( author, true ) then return end
	msg = self:CleanMessage(msg)

	local _, _, num, name = string.find(msg, "^SET (%d+) (.+)$")
	if not num or not name then return end

	self:RemoveTank(name)

	self.core.maintanktable[tonumber(num)] = name
	self.core.db.profile.maintanktable = self.core.maintanktable
	self:TriggerEvent("oRA_MainTankUpdate", self.core.maintanktable)		
end

function oRAPMainTank:oRA_RemoveMainTank(msg, author)
	if not self:IsValidRequest( author, true ) then return end
	msg = self:CleanMessage(msg)
	local _, _, name = string.find( msg, "^R (.+)$")
	if not name then return end

	self:RemoveTank(name)
	
	self:TriggerEvent("oRA_MainTankUpdate", self.core.maintanktable)
end

function oRAPMainTank:oRA_LeftRaid()
	self.core.maintanktable = {}
	self.core.db.profile.maintanktable = nil
	self:TriggerEvent("oRA_MainTankUpdate", self.core.maintanktable )
end

-------------------------------
--     Utility Functions     --
-------------------------------

function oRAPMainTank:RemoveTank(name)
	if not name then return end
	for n, t in pairs(self.core.maintanktable) do
		if t == name then
			self.core.maintanktable[n] = nil
		end
	end
	self.core.db.profile.maintanktable = self.core.maintanktable
end

-------------------------------
--      Command Handlers     --
-------------------------------

function oRAPMainTank:Refresh()
	self:TriggerEvent("oRA_MainTankUpdate", self.core.maintanktable)
	self:Print(L["The local maintank list has been refreshed."])
end
