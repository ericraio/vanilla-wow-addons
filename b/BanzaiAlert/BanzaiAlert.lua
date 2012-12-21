-------------------------------------------------------------------------------
-- Locals                                                                    --
-------------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BanzaiAlert")

local lastAggroAlert = nil
local isFlashing = nil
--local lastUnitTable = nil

-------------------------------------------------------------------------------
-- Localization                                                              --
-------------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Sound alert"] = true,
	["Plays a sound alert when you get aggro."] = true,
	["Text alert"] = true,
	["Displays a message on the screen when you get aggro."] = true,
	["Only in group"] = true,
	["Only alert for aggro when you are grouped."] = true,
	["Health frame flash"] = true,
	["Flash the health frame when you get aggro."] = true,
	["Lost aggro"] = true,
	["Alerts you when you lose aggro."] = true,

	["Aggro from %s!"] = true,
	["Lost aggro!"] = true,

	-- oRA2 module
	["aggroalert"] = true,
	["Participant/AggroAlert"] = true,
	["aggro"] = true,
	["Aggro alert"] = true,
	["Options for aggro notifications."] = true,
	
	["Display"] = true,
	["Set where messages are displayed."] = true,
	
	["Default Frame"] = "Default",
	["BigWigs frame"] = "BigWigs",
	["Mik's Scrolling Battle Text"] = "MSBT",
	["Scrolling Combat Text"] = "SCT",
} end)

L:RegisterTranslations("koKR", function() return {
	["Sound alert"] = "경고 효과음",
	["Plays a sound alert when you get aggro."] = "어그로 획득시 경고 효과음을 재생합니다.",
	["Text alert"] = "경고 텍스트",
	["Displays a message on the screen when you get aggro."] = "어그로 획득시 화면에 메세지를 표시합니다.",
	["Only in group"] = "파티만 사용",
	["Only alert for aggro when you are grouped."] = "파티에 속해 있을 때에만 경고를 사용합니다.",
	["Health frame flash"] = "화면 번쩍임",
	["Flash the health frame when you get aggro."] = "어그로 획득시 생명력 프레임(화면 외곽)을 번쩍입니다.",
	["Lost aggro"] = "어그로 손실",
	["Alerts you when you lose aggro."] = "어그로 손실시 알립니다.",

	["Aggro from %s!"] = "%s의 어그로 획득!",
	["Lost aggro!"] = "어그로 손실!",

	-- oRA2 module
--	["aggroalert"] = "어그로경고",
--	["Participant/AggroAlert"] = true,
--	["aggro"] = "어그로",
	["Aggro alert"] = "어그로 경고",
	["Options for aggro notifications."] = "어그로 경고에 대해 설정합니다.",
	
	["Display"] = "디스플레이",
	["Set where messages are displayed."] = "메세지가 표시되는 곳을 설정합니다.",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Sound alert"] = "聲音警告",
	["Plays a sound alert when you get aggro."] = "當你得到Aggro時發出聲音警告",
	["Text alert"] = "文字警告",
	["Displays a message on the screen when you get aggro."] = "當你得到Aggro時在螢幕顯示文字警告",
	["Only in group"] = "隊伍模式",
	["Only alert for aggro when you are grouped."] = "只有當你在隊伍裡時發出Aggro警告",
	["Health frame flash"] = "全螢幕閃光警告",
	["Flash the health frame when you get aggro."] = "在你得到Aggro後發出全螢幕閃光警告",
	["Lost aggro"] = "失去Aggro",
	["Alerts you when you lose aggro."] = "當你失去Aggro時發出警告",

	["Aggro from %s!"] = "得到 %s 的 Aggro！",
	["Lost aggro!"] = "失去 Aggro！",

	-- oRA2 module
	["aggroalert"] = "Aggro警報",
	["Participant/AggroAlert"] = "Participant/AggroAlert",
	["aggro"] = "aggro",
	["Aggro alert"] = "Aggro警報",
	["Options for aggro notifications."] = "Aggro 通知選項",
	
	["Display"] = "顯示",
	["Set where messages are displayed."] = "設定訊息將會顯示在哪裡",
	
	["Default Frame"] = "預設",
	["BigWigs frame"] = "BigWigs",
	["Mik's Scrolling Battle Text"] = "MSBT",
	["Scrolling Combat Text"] = "SCT",
} end)

-------------------------------------------------------------------------------
-- Addon declaration                                                         --
-------------------------------------------------------------------------------

BanzaiAlert = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "AceEvent-2.0")
BanzaiAlert:RegisterDB("BanzaiAlertDB")
BanzaiAlert:RegisterDefaults("profile", {
	sound = true,
	message = true,
	onlyInGroup = true,
	flash = true,
	lost = false,
	display = L["Default Frame"],
})

local options = {
	type = "group",
	name = L["Aggro alert"],
	desc = L["Options for aggro notifications."],
	args = {
		sound = {
			type = "toggle",
			name = L["Sound alert"],
			desc = L["Plays a sound alert when you get aggro."],
			get = function() return BanzaiAlert.db.profile.sound end,
			set = function(v) BanzaiAlert.db.profile.sound = v end,
		},
		message = {
			type = "toggle",
			name = L["Text alert"],
			desc = L["Displays a message on the screen when you get aggro."],
			get = function() return BanzaiAlert.db.profile.message end,
			set = function(v) BanzaiAlert.db.profile.message = v end,
		},
		onlyInGroup = {
			type = "toggle",
			name = L["Only in group"],
			desc = L["Only alert for aggro when you are grouped."],
			get = function() return BanzaiAlert.db.profile.onlyInGroup end,
			set = function(v) BanzaiAlert.db.profile.onlyInGroup = v end,
		},
		flash = {
			type = "toggle",
			name = L["Health frame flash"],
			desc = L["Flash the health frame when you get aggro."],
			get = function() return BanzaiAlert.db.profile.flash end,
			set = function(v) BanzaiAlert.db.profile.flash = v end,
		},
		lost = {
			type = "toggle",
			name = L["Lost aggro"],
			desc = L["Alerts you when you lose aggro."],
			get = function() return BanzaiAlert.db.profile.lost end,
			set = function(v) BanzaiAlert.db.profile.lost = v end,
		},
		display = {
			type = "text",
			name = L["Display"],
			desc = L["Set where messages are displayed."],
			get = function() return BanzaiAlert.db.profile.display end,
			set = function(v) BanzaiAlert.db.profile.display = v end,
			validate = {
				L["Default Frame"],
				L["BigWigs frame"],
				L["Scrolling Combat Text"],
				L["Mik's Scrolling Battle Text"]
			},
			disabled = function() return BanzaiAlert.db.profile.message ~= true end,
		}
	},
}

BanzaiAlert:RegisterChatCommand({"/banzaialert", "/banzai"}, options, "BANZAIALERT")

-------------------------------------------------------------------------------
-- Initialization                                                            --
-------------------------------------------------------------------------------

local function _InitoRA()
	if oRA and not oRAPAggroAlert then
		oRAPAggroAlert = oRA:NewModule(L["aggroalert"])
		oRAPAggroAlert.participant = true
		oRAPAggroAlert.name = L["Participant/AggroAlert"]
		oRAPAggroAlert.consoleCmd = L["aggro"]
		oRAPAggroAlert.consoleOptions = options
	end
end

function BanzaiAlert:ADDON_LOADED()
	if arg1 == "oRA2" then
		_InitoRA()
	end
end

function BanzaiAlert:OnEnable()
	lastAggroAlert = nil

	_InitoRA()

	self:RegisterEvent("Banzai_PlayerGainedAggro")
	self:RegisterEvent("Banzai_PlayerLostAggro")
	self:RegisterEvent("ADDON_LOADED")
end

-------------------------------------------------------------------------------
-- Addon methods                                                             --
-------------------------------------------------------------------------------

function BanzaiAlert:Alert( gainedAggro, unitId )
	local text = nil
	if gainedAggro then
		text = string.format(L["Aggro from %s!"], UnitName(unitId))
	else
		text = L["Lost aggro!"]
	end

	if self.db.profile.display == L["BigWigs frame"] and BigWigs then -- Big Wigs
		self:TriggerEvent("BigWigs_Message", text, "Red", true, nil)
	elseif self.db.profile.display == L["Scrolling Combat Text"] and SCT then -- SCT 5.x
		SCT_MSG_FRAME:AddMessage(text, 1.0, 0.0, 0.0, 1)
	elseif self.db.profile.display == L["Mik's Scrolling Battle Text"] and MikSBT then -- MSBT
		MikSBT.DisplayMessage(text, MikSBT.DISPLAYTYPE_NOTIFICATION, false, 255, 0, 0)
	elseif CombatText_AddMessage then -- Blizzards FCT
		CombatText_AddMessage(text, COMBAT_TEXT_SCROLL_FUNCTION, 1.0, 0.0, 0.0, "sticky", nil)
	else -- Fallback
		UIErrorsFrame:AddMessage(text, 1.0, 0.0, 0.0, 1, UIERRORS_HOLD_TIME)
	end
end

-------------------------------------------------------------------------------
-- Events                                                                    --
-------------------------------------------------------------------------------

function BanzaiAlert:Banzai_PlayerGainedAggro( unitTable )
	if (self.db.profile.onlyInGroup and GetNumPartyMembers() == 0) or not unitTable then
		return
	end

	if not lastAggroAlert or (GetTime() - lastAggroAlert) > 5 then
		if self.db.profile.sound then
			PlaySoundFile("Interface\\AddOns\\BanzaiAlert\\aggro.wav")
		end
		if unitTable[1] then
			if self.db.profile.message then
				self:Alert(true, unitTable[1])
			end
			if self.db.profile.flash and not isFlashing then
				self:StartFlashing()
			end
		end
		lastAggroAlert = GetTime()
	end
end

function BanzaiAlert:Banzai_PlayerLostAggro( unitId )
	if self.db.profile.flash or isFlashing then
		self:StopFlashing()
	end

	if self.db.profile.onlyInGroup and GetNumPartyMembers() == 0 then
		return
	end

	if self.db.profile.lost and self.db.profile.message then
		self:Alert()
	end
end

-------------------------------------------------------------------------------
-- Frame flashing                                                            --
-------------------------------------------------------------------------------

function BanzaiAlert:StartFlashing()
	if self:IsEventScheduled("banzaiflash") or isFlashing then return end
	UIFrameFlash(LowHealthFrame, 0.2, 0.8, 10, nil, .5, 0)
	self:ScheduleRepeatingEvent("banzaiflash", function() UIFrameFlash(LowHealthFrame, 0.2, 0.8, 10, nil, .5, 0) end, .5)
	isFlashing = true
end

function BanzaiAlert:StopFlashing()
	if not isFlashing then return end

	if self:IsEventScheduled("banzaiflash") then
		self:CancelScheduledEvent("banzaiflash")
	end
	UIFrameFlashRemoveFrame(LowHealthFrame)
	UIFrameFadeRemoveFrame(LowHealthFrame)
	UIFrameFadeOut(LowHealthFrame, 0.5, LowHealthFrame:GetAlpha(), 0)
	isFlashing = nil
end

