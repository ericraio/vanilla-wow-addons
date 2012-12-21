assert( oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRAPAssist")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["'|c00FFFFFF%s|r' wants you to assist him/her.\nPress Assist to assist."] = true,
	["assistparticipant"] = true,
	["assist"] = true,
	["Assist"] = true,
	["Options for assist."] = true,
	["sound"] = true,
	["Sound"] = true,
	["Toggle an audio warning upon an assist request."] = true,
	["Participant/Assist"] = true,
} end )

L:RegisterTranslations("koKR", function() return {

	["'|c00FFFFFF%s|r' wants you to assist him/her.\nPress Assist to assist."] = "'|c00FFFFFF%s|r'님이 당신이 지원해주기를 원합니다.\n지원하기 위해서는 지원 버튼을 누르세요.",
	["Assist"] = "지원",
	["Options for assist."] = "지원 설정",
	["Sound"] = "소리",
	["Toggle an audio warning upon an assist request."] = "지원 요청이 들어 왔을 때의 경고음을 토글합니다.",
	["Participant/Assist"] = "부분/지원",
} end )

L:RegisterTranslations("zhCN", function() return {
	["'|c00FFFFFF%s|r' wants you to assist him/her.\nPress Assist to assist."] = "'|c00FFFFFF%s|r' 希望你协助他的目标r。\n点击协助来允许。",
	["assistparticipant"] = "assistparticipant",
	["assist"] = "协助",
	["Assist"] = "协助",
	["Options for assist."] = "协助选项",
	["sound"] = "声音",
	["Sound"] = "声音",
	["Toggle an audio warning upon an assist request."] = "收到协助请求发声",
	["Participant/Assist"] = "Participant/Assist",
} end )

L:RegisterTranslations("zhTW", function() return {
	["'|c00FFFFFF%s|r' wants you to assist him/her.\nPress Assist to assist."] = "'|c00FFFFFF%s|r' 希望你協助他的目標。\n點擊協助來協助。",
	["assistparticipant"] = "assistparticipant",
	["assist"] = "協助",
	["Assist"] = "協助",
	["Options for assist."] = "協助選項",
	["sound"] = "聲音",
	["Sound"] = "聲音",
	["Toggle an audio warning upon an assist request."] = "收到協助請求時聲音提示",
	["Participant/Assist"] = "隊員/協助",
} end )

L:RegisterTranslations("frFR", function() return {
	["'|c00FFFFFF%s|r' wants you to assist him/her.\nPress Assist to assist."] = "'|c00FFFFFF%s|r' veux que vous l'aidiez.\nAppuyez sur Aide pour l'aider.",
	--["assistparticipant"] = true,
	--["assist"] = true,
	["Assist"] = "Aide",
	["Options for assist."] = "Options concernant l'aide.",
	--["sound"] = true,
	["Sound"] = "Son",
	["Toggle an audio warning upon an assist request."] = "Joue un avertissement sonore quand quelqu'un demande de l'aide.",
	["Participant/Assist"] = "Participant/Aide",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

oRAPAssist = oRA:NewModule(L["assistparticipant"])
oRAPAssist.defaults = {
	sound = true,
}
oRAPAssist.participant = true
oRAPAssist.consoleCmd = L["assist"]
oRAPAssist.name = L["Participant/Assist"]
oRAPAssist.consoleOptions = {
	type = "group",
	desc = L["Options for assist."],
	name = L["Assist"],
	args = {
		[L["sound"]] = {
			name = L["Sound"], type = "toggle",
			desc = L["Toggle an audio warning upon an assist request."],
			get = function() return oRAPAssist.db.profile.sound end,
			set = function(v)
				oRAPAssist.db.profile.sound = v
			end,
		},
	}
}


------------------------------
--      Initialization      --
------------------------------

function oRAPAssist:OnEnable()
	self:SetupFrames()
	self:RegisterCheck("ASSISTME", "oRA_AssistMe")
	self:RegisterCheck("STOPASSIST", "oRA_StopAssist")
end

function oRAPAssist:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterCheck("ASSISTME")
	self:UnregisterCheck("STOPASSIST")
end


function oRAPAssist:oRA_AssistMe(msg, author)
	if not self:IsValidRequest(author) then return end
	msg = self:CleanMessage(msg)
	local _,_,p = string.find(msg, "^ASSISTME (.+)$")
	if p and p == UnitName("player") then
		self.assistPerson = author
		self.frames.aheader:SetText(L["Assist"])
		self.frames.ainfo:SetText(string.format( L["'|c00FFFFFF%s|r' wants you to assist him/her.\nPress Assist to assist."], self.assistPerson))
		self.frames.abuttontext:SetText(L["Assist"])
		self.frames.assist:Show()
		if self.db.profile.sound then PlaySound("TellMessage") end
	end
end

function oRAPAssist:oRA_StopAssist(msg, author)
	if not self:IsValidRequest(author) then return end
	msg = self:CleanMessage(msg)
	local _,_,p = string.find(msg, "^STOPASSIST (.+)$")
	if p and p == UnitName("player") then
		self.frames.assist:Hide()
	end
end


function oRAPAssist:SetupFrames()	
	local f, t	

	f, _, _ = GameFontNormal:GetFont()

	self.frames = {}
	self.frames.assist = CreateFrame("Frame", nil, UIParent)
	self.frames.assist:Hide()
	self.frames.assist:SetWidth(325)
	self.frames.assist:SetHeight(125)
	self.frames.assist:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 16,
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
		insets = {left = 4, right = 4, top = 4, bottom = 4},
		})
	self.frames.assist:SetBackdropBorderColor(.5, .5, .5)
	self.frames.assist:SetBackdropColor(0,0,0)
	self.frames.assist:ClearAllPoints()
	self.frames.assist:SetPoint("CENTER", WorldFrame, "CENTER", 0, 0)

	self.frames.cfade = self.frames.assist:CreateTexture(nil, "BORDER")
	self.frames.cfade:SetWidth(319)
	self.frames.cfade:SetHeight(25)
	self.frames.cfade:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	self.frames.cfade:SetPoint("TOP", self.frames.assist, "TOP", 0, -4)
	self.frames.cfade:SetBlendMode("ADD")
	self.frames.cfade:SetGradientAlpha("VERTICAL", .1, .1, .1, 0, .25, .25, .25, 1)
	self.frames.assist.Fade = self.frames.fade

	self.frames.aheader = self.frames.assist:CreateFontString(nil,"OVERLAY")
	self.frames.aheader:SetFont(f, 14)
	self.frames.aheader:SetWidth(300)
	self.frames.aheader:SetText("header")
	self.frames.aheader:SetTextColor(1, .8, 0)
	self.frames.aheader:ClearAllPoints()
	self.frames.aheader:SetPoint("TOP", self.frames.assist, "TOP", 0, -10)

	self.frames.ainfo = self.frames.assist:CreateFontString(nil,"OVERLAY")
	self.frames.ainfo:SetFont(f, 10)
	self.frames.ainfo:SetWidth(300)
	self.frames.ainfo:SetText("info")
	self.frames.ainfo:SetTextColor(1, .8, 0)
	self.frames.ainfo:ClearAllPoints()
	self.frames.ainfo:SetPoint("TOP", self.frames.aheader, "BOTTOM", 0, -10)
	
	self.frames.abutton = CreateFrame("Button", nil, self.frames.assist)
	self.frames.abutton.owner = self
	self.frames.abutton:SetWidth(125)
	self.frames.abutton:SetHeight(32)
	self.frames.abutton:SetPoint("CENTER", self.frames.assist, "CENTER", 0, -20)
	
	t = self.frames.abutton:CreateTexture()
	t:SetWidth(125)
	t:SetHeight(32)
	t:SetPoint("CENTER", self.frames.abutton, "CENTER")
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Up")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	self.frames.abutton:SetNormalTexture(t)

	t = self.frames.abutton:CreateTexture(nil, "BACKGROUND")
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Down")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	t:SetAllPoints(self.frames.abutton)
	self.frames.abutton:SetPushedTexture(t)
	
	t = self.frames.abutton:CreateTexture()
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Highlight")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	t:SetAllPoints(self.frames.abutton)
	t:SetBlendMode("ADD")
	self.frames.abutton:SetHighlightTexture(t)
	self.frames.abuttontext = self.frames.abutton:CreateFontString(nil,"OVERLAY")
	self.frames.abuttontext:SetFontObject(GameFontHighlight)
	self.frames.abuttontext:SetText("Assist")
	self.frames.abuttontext:SetAllPoints(self.frames.abutton)
	
	self.frames.abutton:SetScript("OnClick",
			function()
				for i = 1, GetNumRaidMembers(), 1 do
					if ( UnitName("raid" .. i) == this.owner.assistPerson ) then
							AssistUnit("raid" .. i)
						break;
					end
				end
				this.owner.frames.assist:Hide()
				PlaySound("UChatScrollButton")
			end )
end
