
assert( oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRAPReady")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["ready"] = true,
	["readyparticipant"] = true,
	["Options for ready checks and votes."] = true,
	["sound"] = true,
	["Sound"] = true,
	["Toggle an audio warning upon a ready check or vote."] = true,
	["Ready"] = true,
	["Not Ready"] = true,
	["Are you Ready?"] = true,
	["Yes"] = true,
	["No"] = true,
	["Ready Check"] = true,
	["check"] = true,
	["Vote"] = true,
	["vote"] = true,
	["Perform a vote."] = true,
	["Participant/Ready"] = true,
	["Closing Vote"] = true,
	["Closing Check"] = true,
} end)

L:RegisterTranslations("koKR", function() return {

	["Options for ready checks and votes."] = "준비 확인과 투표 설정",
	["Sound"] = "소리",
	["Toggle an audio warning upon a ready check or vote."] = "투표나 준비 확인시 경고음 토글",
	["Ready"] = "준비완료",
	["Not Ready"] = "준비안됨",
	["Are you Ready?"] = "준비 되셨습니까?",
	["Yes"] = "예",
	["No"] = "아니오",
	["Ready Check"] = "준비 확인",
	["check"] = "확인",
	["Vote"] = "투표",
	["Perform a vote."] = "투표를 실시합니다.",
	["Participant/Ready"] = "부분/준비",
	["Closing Vote"] = "투표 닫기",
	["Closing Check"] = "확인 닫기",
} end)

L:RegisterTranslations("zhCN", function() return {
	["ready"] = "准备",
	["readyparticipant"] = "readyparticipant",
	["Options for ready checks and votes."] = "准备检查和投票的选项",
	["sound"] = "声音",
	["Sound"] = "声音",
	["Toggle an audio warning upon a ready check or vote."] = "准备检查或投票时发声",
	["Ready"] = "准备就绪",
	["Not Ready"] = "未准备好",
	["Are you Ready?"] = "准备好了么？",
	["Yes"] = "是",
	["No"] = "否",
	["Ready Check"] = "准备检查",
	["check"] = "检查",
	["Vote"] = "投票",
	["vote"] = "投票",
	["Perform a vote."] = "进行投票",
	["Participant/Ready"] = "Participant/Ready",
	["Closing Vote"] = "关闭投票",
	["Closing Check"] = "关闭检查",
} end)

L:RegisterTranslations("zhTW", function() return {
	["ready"] = "就位確認",
	["readyparticipant"] = "readyparticipant",
	["Options for ready checks and votes."] = "就位確認與投票選項",
	["sound"] = "聲音",
	["Sound"] = "聲音",
	["Toggle an audio warning upon a ready check or vote."] = "就位確認與投票時播放音效",
	["Ready"] = "已就緒",
	["Not Ready"] = "未就緒",
	["Are you Ready?"] = "準備好了嗎？",
	["Yes"] = "是",
	["No"] = "否",
	["Ready Check"] = "就位確認",
	["check"] = "檢查",
	["Vote"] = "投票",
	["vote"] = "投票",
	["Perform a vote."] = "進行投票",
	["Participant/Ready"] = "隊員/就位確認",
	["Closing Vote"] = "關閉投票",
	["Closing Check"] = "關閉檢查",
} end)

L:RegisterTranslations("frFR", function() return {
	--["ready"] = true,
	--["readyparticipant"] = true,
	["Options for ready checks and votes."] = "Options concernant les appels et les votes.",
	--["sound"] = true,
	["Sound"] = "Son",
	["Toggle an audio warning upon a ready check or vote."] = "Joue ou non un avertissement sonore lors d'un appel ou d'un vote.",
	["Ready"] = "Pr\195\170t",
	["Not Ready"] = "Pas pr\195\170t",
	["Are you Ready?"] = "\195\138tes-vous pr\195\170t ?",
	["Yes"] = "Oui",
	["No"] = "Non",
	["Ready Check"] = "Appel",
	--["check"] = true,
	["Vote"] = "Vote",
	--["vote"] = true,
	["Perform a vote."] = "Soumet un vote.",
	["Participant/Ready"] = "Participant/Appel",
	["Closing Vote"] = "Cl\195\180ture du vote",
	["Closing Check"] = "Cl\195\180ture de l'appel",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

oRAPReady = oRA:NewModule(L["readyparticipant"], "CandyBar-2.0")
oRAPReady.defaults = {
	sound = true,
}
oRAPReady.participant = true
oRAPReady.name = L["Participant/Ready"]
oRAPReady.consoleCmd = L["ready"]
oRAPReady.consoleOptions = {
	type = "group",
	desc = L["Options for ready checks and votes."],
	name = L["Ready"],
	args = {
		[L["sound"]] = {
			name = L["Sound"], type = "toggle",
			desc = L["Toggle an audio warning upon a ready check or vote."],
			get = function() return oRAPReady.db.profile.sound end,
			set = function(v)
				oRAPReady.db.profile.sound = v
			end,
		},
	}
}

------------------------------
--      Initialization      --
------------------------------

function oRAPReady:OnEnable()

	self:RegisterCheck("CHECKREADY", "oRA_ReadyCheck")
	self:RegisterCheck("VOTE", "oRA_Vote")
	self:RegisterEvent( "oRA_BarTexture" )

	self:SetupFrames()
end

function oRAPReady:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterCheck("CHECKREADY")
	self:UnregisterCheck("VOTE")
end

-------------------------
--   Command Handlers  --
-------------------------


-------------------------
--   Event Handlers    --
-------------------------

-- Handles an incoming ready check

function oRAPReady:oRA_ReadyCheck(msg, author)
	if not self:IsValidRequest(author) then return end
	if UnitName("player") ~= author then
		if self.db.profile.sound then PlaySoundFile("Sound\\interface\\levelup2.wav") end
		self:ShowReady( author )
	end
end

-- Handles an incoming vote

function oRAPReady:oRA_Vote(msg, author)
	if not self:IsValidRequest(author) then return end
	msg = self:CleanMessage(msg)
	local _,_,question = string.find(msg, "^VOTE (.+)$")
	if not question then return end
	if UnitName("player") ~= author then
		if self.db.profile.sound then PlaySoundFile("Sound\\interface\\levelup2.wav") end
		self:ShowVote( author, question )
	end
end

function oRAPReady:oRA_BarTexture( texture )
	if self:CandyBarStatus( "oRAPReadyTimeOut" ) then
		self:SetCandyBarTexture( "oRAPReadyTimeOut", self.core.bartextures[texture] )
	end
end

--------------------------
--     Core function    --
--------------------------

function oRAPReady:Vote( answer )
	if not answer then return end
	if answer=="yes" then self:SendMessage("VOTEYES") 
	elseif answer=="no" then self:SendMessage("VOTENO")
	end
end


function oRAPReady:Ready( readystate )
	if not readystate then return end
	if readystate == "ready" then self:SendMessage("READY")
	elseif readystate == "notready" then self:SendMessage("NOTREADY")
	end
end

------------------------------------
--     Frame Setup and Handling   --
------------------------------------

function oRAPReady:ShowVote( author, question )
	self.frames.cheader:SetText(L["Vote"])
	self.frames.cinfo:SetText("|cffffffff"..author.. "|r: " .. question)
	self.frames.leftbuttontext:SetText(L["Yes"])
	self.frames.rightbuttontext:SetText(L["No"])

	self.frames.leftbutton:SetScript("OnClick", 
			function() 
				this.owner:Vote("yes")
				this.owner:StopCandyBar("oRAPReadyTimeOut")
				this.owner.frames.check:Hide()
				this.owner:CancelScheduledEvent("oRAPReady_HideCheck")
			end )
	self.frames.rightbutton:SetScript("OnClick",
			function() 
				this.owner:Vote("no")
				this.owner:StopCandyBar("oRAPReadyTimeOut")
				this.owner.frames.check:Hide()
				this.owner:CancelScheduledEvent("oRAPReady_HideCheck")
			end )

	self.frames.check:Show()

	self:RegisterCandyBar( "oRAPReadyTimeOut", 30, L["Closing Vote"], nil, "green", "yellow", "orange", "red")
	self:SetCandyBarPoint( "oRAPReadyTimeOut", "BOTTOM", self.frames.check, "BOTTOM", 0, 7 )
	self:SetCandyBarBackgroundColor( "oRAPReadyTimeOut", "black", 0 )
	self:SetCandyBarTexture( "oRAPReadyTimeOut", self.core.bartextures[self.core.db.profile.bartexture] )
	self:StartCandyBar( "oRAPReadyTimeOut", 1)

	self:ScheduleEvent( "oRAPReady_HideCheck", function() self.frames.check:Hide() end, 30)
end


function oRAPReady:ShowReady( author )
	self.frames.cheader:SetText(L["Ready Check"])
	self.frames.cinfo:SetText("|cffffffff"..author.. "|r: " .. L["Are you Ready?"] )
	self.frames.leftbuttontext:SetText(L["Ready"])
	self.frames.rightbuttontext:SetText(L["Not Ready"])

	self.frames.leftbutton:SetScript("OnClick",
		function() 
				this.owner:Ready("ready")
				this.owner:StopCandyBar("oRAPReadyTimeOut") 
				this.owner.frames.check:Hide()
				this.owner:CancelScheduledEvent("oRAPReady_HideCheck")
			end )
	self.frames.rightbutton:SetScript("OnClick",
			function() 
				this.owner:Ready("notready") 
				this.owner:StopCandyBar("oRAPReadyTimeOut")
				this.owner.frames.check:Hide()
				this.owner:CancelScheduledEvent("oRAPReady_HideCheck")
			end )
	self.frames.check:Show()

	self:RegisterCandyBar( "oRAPReadyTimeOut", 30, L["Closing Check"], nil, "green", "yellow", "orange", "red")
	self:SetCandyBarPoint( "oRAPReadyTimeOut", "BOTTOM", self.frames.check, "BOTTOM", 0, 7 )
	self:SetCandyBarBackgroundColor( "oRAPReadyTimeOut", "black", 0 )
	self:SetCandyBarTexture( "oRAPReadyTimeOut", self.core.bartextures[self.core.db.profile.bartexture] )
	self:StartCandyBar( "oRAPReadyTimeOut", 1)

	self:ScheduleEvent( "oRAPReady_HideCheck", function() self.frames.check:Hide() end, 30)
end

function oRAPReady:SetupFrames()
	local f, t	

	f, _, _ = GameFontNormal:GetFont()

	self.frames = {}
	self.frames.check = CreateFrame("Frame", nil, UIParent)
	self.frames.check:Hide()
	self.frames.check:SetWidth(325)
	self.frames.check:SetHeight(125)
	self.frames.check:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 16,
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
		insets = {left = 4, right = 4, top = 4, bottom = 4},
		})
	self.frames.check:SetBackdropBorderColor(.5, .5, .5)
	self.frames.check:SetBackdropColor(0,0,0)
	self.frames.check:ClearAllPoints()
	self.frames.check:SetPoint("CENTER", WorldFrame, "CENTER", 0, 0)

	self.frames.cfade = self.frames.check:CreateTexture(nil, "BORDER")
	self.frames.cfade:SetWidth(319)
	self.frames.cfade:SetHeight(25)
	self.frames.cfade:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	self.frames.cfade:SetPoint("TOP", self.frames.check, "TOP", 0, -4)
	self.frames.cfade:SetBlendMode("ADD")
	self.frames.cfade:SetGradientAlpha("VERTICAL", .1, .1, .1, 0, .25, .25, .25, 1)
	self.frames.check.Fade = self.frames.fade

	self.frames.cheader = self.frames.check:CreateFontString(nil,"OVERLAY")
	self.frames.cheader:SetFont(f, 14)
	self.frames.cheader:SetWidth(300)
	self.frames.cheader:SetText("header")
	self.frames.cheader:SetTextColor(1, .8, 0)
	self.frames.cheader:ClearAllPoints()
	self.frames.cheader:SetPoint("TOP", self.frames.check, "TOP", 0, -10)

	self.frames.cinfo = self.frames.check:CreateFontString(nil,"OVERLAY")
	self.frames.cinfo:SetFont(f, 10)
	self.frames.cinfo:SetWidth(300)
	self.frames.cinfo:SetText("info")
	self.frames.cinfo:SetTextColor(1, .8, 0)
	self.frames.cinfo:ClearAllPoints()
	self.frames.cinfo:SetPoint("TOP", self.frames.cheader, "BOTTOM", 0, -10)
	
	self.frames.leftbutton = CreateFrame("Button", nil, self.frames.check)
	self.frames.leftbutton.owner = self
	self.frames.leftbutton:SetWidth(125)
	self.frames.leftbutton:SetHeight(32)
	self.frames.leftbutton:SetPoint("RIGHT", self.frames.check, "CENTER", -10, -20)
	
	t = self.frames.leftbutton:CreateTexture()
	t:SetWidth(125)
	t:SetHeight(32)
	t:SetPoint("CENTER", self.frames.leftbutton, "CENTER")
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Up")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	self.frames.leftbutton:SetNormalTexture(t)

	t = self.frames.leftbutton:CreateTexture(nil, "BACKGROUND")
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Down")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	t:SetAllPoints(self.frames.leftbutton)
	self.frames.leftbutton:SetPushedTexture(t)
	
	t = self.frames.leftbutton:CreateTexture()
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Highlight")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	t:SetAllPoints(self.frames.leftbutton)
	t:SetBlendMode("ADD")
	self.frames.leftbutton:SetHighlightTexture(t)
	self.frames.leftbuttontext = self.frames.leftbutton:CreateFontString(nil,"OVERLAY")
	self.frames.leftbuttontext:SetFontObject(GameFontHighlight)
	self.frames.leftbuttontext:SetText("left")
	self.frames.leftbuttontext:SetAllPoints(self.frames.leftbutton)

	self.frames.rightbutton = CreateFrame("Button", nil, self.frames.check)
	self.frames.rightbutton.owner = self
	self.frames.rightbutton:SetWidth(125)
	self.frames.rightbutton:SetHeight(32)
	self.frames.rightbutton:SetPoint("LEFT", self.frames.check, "CENTER", 10, -20)
	
	t = self.frames.rightbutton:CreateTexture()
	t:SetWidth(125)
	t:SetHeight(32)
	t:SetPoint("CENTER", self.frames.rightbutton, "CENTER")
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Up")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	self.frames.rightbutton:SetNormalTexture(t)

	t = self.frames.rightbutton:CreateTexture(nil, "BACKGROUND")
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Down")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	t:SetAllPoints(self.frames.rightbutton)
	self.frames.rightbutton:SetPushedTexture(t)
	
	t = self.frames.rightbutton:CreateTexture()
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Highlight")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	t:SetAllPoints(self.frames.rightbutton)
	t:SetBlendMode("ADD")
	self.frames.rightbutton:SetHighlightTexture(t)
	self.frames.rightbuttontext = self.frames.rightbutton:CreateFontString(nil,"OVERLAY")
	self.frames.rightbuttontext:SetFontObject(GameFontHighlight)
	self.frames.rightbuttontext:SetText("right")
	self.frames.rightbuttontext:SetAllPoints(self.frames.rightbutton)

end
