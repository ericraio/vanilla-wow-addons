
assert( oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRALResist")
local compost = AceLibrary:HasInstance("Compost-2.0") and AceLibrary("Compost-2.0")
local function getnewtable() return compost and compost:Acquire() or {} end
local function reclaimtable(t) if compost then compost:Reclaim(t) end end

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["resist"] = true,
	["resistleader"] = true,
	["Options for resistance checks."] = true,
	["Leader/Resist"] = true,
	["Name"] = true,
	["Fire"] = true,
	["Nature"] = true,
	["Frost"] = true,
	["Shadow"] = true,
	["Arcane"] = true,
	["Resistance checks disabled."] = true,
	["Resistances"] = true,
	["Fr"] = true,
	["Ft"] = true,
	["N"] = true,
	["A"] = true,
	["S"] = true,
	["Refresh"] = true,
	["Close"] = true,
	["check"] = true,
	["Perform resistance check"] = true,
	["Check the raid's resistances."] = true,
} end )

L:RegisterTranslations("koKR", function() return {

	["Options for resistance checks."] = "공격대원 저항 확인 설정",
	["Leader/Resist"] = "공격대장/저항",
	["Name"] = "이름",
	["Fire"] = "화염",
	["Nature"] = "자연",
	["Frost"] = "냉기",
	["Shadow"] = "암흑",
	["Arcane"] = "비전",
	["Resistance checks disabled."] = "저항확인이 불가능합니다",
	["Resistances"] = "저항",
	["Fr"] = "화",
	["Ft"] = "냉",
	["N"] = "자",
	["A"] = "비",
	["S"] = "암",
	["Refresh"] = "갱신",
	["Close"] = "닫기",
	["Perform resistance check"] = "저항 확인 실시",
	["Check the raid's resistances."] = "공격대원의 저항을 확인합니다.",
} end )

L:RegisterTranslations("zhCN", function() return {
	["resist"] = "抗性",
	["resistleader"] = "resistleader",
	["Options for resistance checks."] = "抗性助手选项",
	["Leader/Resist"] = "Leader/Resist",
	["Name"] = "姓名",
	["Fire"] = "火焰",
	["Nature"] = "自然",
	["Frost"] = "冰霜",
	["Shadow"] = "暗影",
	["Arcane"] = "奥术",
	["Resistance checks disabled."] = "禁止抗性检查",
	["Resistances"] = "抗性",
	["Fr"] = "火",
	["Ft"] = "冰",
	["N"] = "自",
	["A"] = "奥",
	["S"] = "暗",
	["Refresh"] = "刷新",
	["Close"] = "关闭",
	["check"] = "检查",
	["Perform resistance check"] = "进行抗性检查",
	["Check the raid's resistances."] = "检查团队抗性",
} end )

L:RegisterTranslations("zhTW", function() return {
	["resist"] = "抗性",
	["resistleader"] = "resistleader",
	["Options for resistance checks."] = "抗性助手選項",
	["Leader/Resist"] = "領隊/抗性",
	["Name"] = "姓名",
	["Fire"] = "火焰",
	["Nature"] = "自然",
	["Frost"] = "冰霜",
	["Shadow"] = "陰影",
	["Arcane"] = "祕法",
	["Resistance checks disabled."] = "已停用抗性檢查",
	["Resistances"] = "抗性",
	["Fr"] = "火",
	["Ft"] = "冰",
	["N"] = "自",
	["A"] = "祕",
	["S"] = "陰",
	["Refresh"] = "更新",
	["Close"] = "關閉",
	["check"] = "檢查",
	["Perform resistance check"] = "進行抗性檢查",
	["Check the raid's resistances."] = "檢查團隊抗性",
} end )

L:RegisterTranslations("frFR", function() return {
	--["resist"] = true,
	--["resistleader"] = true,
	["Options for resistance checks."] = "Options concernant les v\195\169rifications des r\195\169sistances.",
	["Leader/Resist"] = "Chef/R\195\169sistances",
	["Name"] = "Nom",
	["Fire"] = "Feu",
	--["Nature"] = true,
	["Frost"] = "Givre",
	["Shadow"] = "Ombre",
	["Arcane"] = "Arcanes",
	["Resistance checks disabled."] = "V\195\169rifications des r\195\169sistances désactiv\195\169es.",
	["Resistances"] = "R\195\169sistances",
	["Fr"] = "F",
	["Ft"] = "G",
	--["N"] = true,
	--["A"] = true,
	["S"] = "O",
	["Refresh"] = "Rafra\195\174chir",
	["Close"] = "Fermer",
	--["check"] = true,
	["Perform resistance check"] = "V\195\169rifier les r\195\169sistances",
	["Check the raid's resistances."] = "V\195\169rifie les r\195\169sistances du raid.",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

oRALResist = oRA:NewModule(L["resistleader"])
oRALResist.defaults = {
}
oRALResist.participant = true
oRALResist.name = L["Leader/Resist"]
oRALResist.consoleCmd = L["resist"]
oRALResist.consoleOptions = {
	type = "group",
	desc = L["Options for resistance checks."],
	name = L["Resistances"],
	args = {
		[L["check"]] = {
			type="execute", name = L["Perform resistance check"],
			desc = L["Check the raid's resistances."],
			func = function()
					oRALResist:PerformResistanceCheck()
				end,
			disabled = function() return not oRA:IsModuleActive(oRALResist) or not oRALResist:IsValidRequest() end,
		},

	}
}

------------------------------
--      Initialization      --
------------------------------

function oRALResist:OnEnable()
	self.resists = getnewtable()
        self.sorting = getnewtable()
	
	self.sorting[1] = L["Name"]
	self.sorting[2] = L["Fire"]
	self.sorting[3] = L["Nature"]
	self.sorting[4] = L["Frost"]
	self.sorting[5] = L["Shadow"]
	self.sorting[6] = L["Arcane"]

	self:RegisterCheck("RST", "oRA_ResistanceResponse")
	self:RegisterShorthand("raresist", function() self:PerformResistanceCheck() end )
	self:SetupFrames()
end

function oRALResist:OnDisable()
	reclaimtable(self.resists)
	self.resists = nil
	reclaimtable(self.sorting)
	self.sorting = nil
	self:UnregisterAllEvents()
	self:UnregisterCheck("RST")
	self:UnregisterShorthand("raresist")
end


-------------------------
--   Event Handlers    --
-------------------------

function oRALResist:oRA_ResistanceResponse( msg, author)
	msg = self:CleanMessage(msg)
	local _,_,requestby = string.find(msg, "^RST %-1 ([^%s]+)$")
	if requestby and requestby == UnitName("player") then
		self:Print( author .. " " .. L["Resistance checks disabled."])
	else
		local _,_, fire, nature, frost, shadow, arcane, requestby = string.find(msg, "^RST (%d+) (%d+) (%d+) (%d+) (%d+) ([^%s]+)$")
		if fire and requestby and requestby == UnitName("player") then
			table.insert( self.resists, {author, tonumber(fire), tonumber(nature), tonumber(frost), tonumber(shadow), tonumber(arcane)})
			self:UpdateScrollBar()
		end
	end
end

-------------------------
--  Utility Functions  --
-------------------------

function oRALResist:SetupFrames()
	local f, t, sframe, i, j

	f, _, _ = GameFontNormal:GetFont()

	self.frames = {}

	self.frames.main = CreateFrame("Frame", "oRAResistReportFrame", UIParent)
	self.frames.main:Hide()
	self.frames.main:SetWidth(325)
	self.frames.main:SetHeight(350)
	self.frames.main:EnableMouse(true)
	self.frames.main:SetMovable(true)
	self.frames.main:RegisterForDrag("LeftButton")
	self.frames.main:SetScript("OnDragStart", function() this:StartMoving() end)
	self.frames.main:SetScript("OnDragStop", function() this:StopMovingOrSizing() end)
	self.frames.main:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 16,
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
		insets = {left = 4, right = 4, top = 4, bottom = 4},
		})
	self.frames.main:SetBackdropBorderColor(.5, .5, .5)
	self.frames.main:SetBackdropColor(0,0,0)
	self.frames.main:ClearAllPoints()
	self.frames.main:SetPoint("CENTER", WorldFrame, "CENTER", 0, 0)

	self.frames.fade = self.frames.main:CreateTexture(nil, "BORDER")
	self.frames.fade:SetWidth(319)
	self.frames.fade:SetHeight(25)
	self.frames.fade:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	self.frames.fade:SetPoint("TOP", self.frames.main, "TOP", 0, -4)
	self.frames.fade:SetBlendMode("ADD")
	self.frames.fade:SetGradientAlpha("VERTICAL", .1, .1, .1, 0, .25, .25, .25, 1)
	self.frames.main.Fade = self.frames.fade

	self.frames.header = self.frames.main:CreateFontString(nil,"OVERLAY")
	self.frames.header:SetFont(f, 14)
	self.frames.header:SetWidth(300)
	self.frames.header:SetText(L["Resistances"])
	self.frames.header:SetTextColor(1, .8, 0)
	self.frames.header:ClearAllPoints()
	self.frames.header:SetPoint("TOP", self.frames.main, "TOP", 0, -10)

	self.frames.headername = CreateFrame("Button", nil, self.frames.main)
	self.frames.headername.owner = self
	self.frames.headername:SetWidth(130)
	self.frames.headername:SetHeight(16)
	self.frames.headername:SetPoint("TOPLEFT", self.frames.main, "TOPLEFT", 10, -35)
	self.frames.headername:SetScript("OnClick",
			function()
				this.owner:Sort(self.resists, 1)
				this.owner:UpdateScrollBar()
			end)

	self.frames.headernamehigh = self.frames.headername:CreateTexture(nil, "BORDER")
	self.frames.headernamehigh:SetWidth(130)
	self.frames.headernamehigh:SetHeight(16)
	self.frames.headernamehigh:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	self.frames.headernamehigh:SetAllPoints(self.frames.headername)
	self.frames.headernamehigh:SetBlendMode("ADD")
	self.frames.headernamehigh:SetGradientAlpha("VERTICAL", .1, .08, 0, 0, .2, .16, 0, 1)
	self.frames.headername:SetHighlightTexture(self.frames.headernamehigh)

	self.frames.headernametext = self.frames.headername:CreateFontString(nil,"OVERLAY")
	self.frames.headernametext.owner = self
	self.frames.headernametext:SetFont(f, 14)
	self.frames.headernametext:SetWidth(130)
	self.frames.headernametext:SetText(L["Name"])
	self.frames.headernametext:SetTextColor(1, .8, 0)
	self.frames.headernametext:ClearAllPoints()
	self.frames.headernametext:SetJustifyH("LEFT")
	self.frames.headernametext:SetAllPoints(self.frames.headername)

	self.frames.headerfire = CreateFrame("Button", nil, self.frames.main)
	self.frames.headerfire.owner = self
	self.frames.headerfire:SetWidth(30)
	self.frames.headerfire:SetHeight(16)
	self.frames.headerfire:SetPoint("LEFT", self.frames.headername, "RIGHT")
	self.frames.headerfire:SetScript("OnClick",
			function()
				this.owner:Sort(self.resists, 2)
				this.owner:UpdateScrollBar()
			end)

	self.frames.headerfirehigh = self.frames.headerfire:CreateTexture(nil, "BORDER")
	self.frames.headerfirehigh:SetWidth(30)
	self.frames.headerfirehigh:SetHeight(16)
	self.frames.headerfirehigh:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	self.frames.headerfirehigh:SetAllPoints(self.frames.headerfire)
	self.frames.headerfirehigh:SetBlendMode("ADD")
	self.frames.headerfirehigh:SetGradientAlpha("VERTICAL", .1, .08, 0, 0, .2, .16, 0, 1)
	self.frames.headerfire:SetHighlightTexture(self.frames.headerfirehigh)


	self.frames.headerfiretext = self.frames.main:CreateFontString(nil,"OVERLAY")
	self.frames.headerfiretext:SetFont(f, 14)
	self.frames.headerfiretext:SetWidth(30)
	self.frames.headerfiretext:SetText(L["Fr"])
	self.frames.headerfiretext:SetTextColor(1, 0, 0)
	self.frames.headerfiretext:ClearAllPoints()
	self.frames.headerfiretext:SetJustifyH("RIGHT")
	self.frames.headerfiretext:SetAllPoints(self.frames.headerfire)

	self.frames.headernature = CreateFrame("Button", nil, self.frames.main)
	self.frames.headernature.owner = self
	self.frames.headernature:SetWidth(30)
	self.frames.headernature:SetHeight(16)
	self.frames.headernature:SetPoint("LEFT", self.frames.headerfire, "RIGHT")
	self.frames.headernature:SetScript("OnClick",
			function()
				this.owner:Sort(self.resists, 3)
				this.owner:UpdateScrollBar()
			end)

	self.frames.headernaturehigh = self.frames.headernature:CreateTexture(nil, "BORDER")
	self.frames.headernaturehigh:SetWidth(30)
	self.frames.headernaturehigh:SetHeight(16)
	self.frames.headernaturehigh:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	self.frames.headernaturehigh:SetAllPoints(self.frames.headernature)
	self.frames.headernaturehigh:SetBlendMode("ADD")
	self.frames.headernaturehigh:SetGradientAlpha("VERTICAL", .1, .08, 0, 0, .2, .16, 0, 1)
	self.frames.headernature:SetHighlightTexture(self.frames.headernaturehigh)


	self.frames.headernaturetext = self.frames.main:CreateFontString(nil,"OVERLAY")
	self.frames.headernaturetext.owner = self
	self.frames.headernaturetext:SetFont(f, 14)
	self.frames.headernaturetext:SetWidth(60)
	self.frames.headernaturetext:SetText(L["N"])
	self.frames.headernaturetext:SetTextColor(0, 1, 0)
	self.frames.headernaturetext:ClearAllPoints()
	self.frames.headernaturetext:SetJustifyH("RIGHT")
	self.frames.headernaturetext:SetAllPoints(self.frames.headernature)

	self.frames.headerfrost = CreateFrame("Button", nil, self.frames.main)
	self.frames.headerfrost.owner = self
	self.frames.headerfrost:SetWidth(30)
	self.frames.headerfrost:SetHeight(16)
	self.frames.headerfrost:SetPoint("LEFT", self.frames.headernature, "RIGHT")
	self.frames.headerfrost:SetScript("OnClick",
			function()
				this.owner:Sort(self.resists, 4)
				this.owner:UpdateScrollBar()
			end)

	self.frames.headerfrosthigh = self.frames.headerfrost:CreateTexture(nil, "BORDER")
	self.frames.headerfrosthigh:SetWidth(30)
	self.frames.headerfrosthigh:SetHeight(16)
	self.frames.headerfrosthigh:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	self.frames.headerfrosthigh:SetAllPoints(self.frames.headerfrost)
	self.frames.headerfrosthigh:SetBlendMode("ADD")
	self.frames.headerfrosthigh:SetGradientAlpha("VERTICAL", .1, .08, 0, 0, .2, .16, 0, 1)
	self.frames.headerfrost:SetHighlightTexture(self.frames.headerfrosthigh)


	self.frames.headerfrosttext = self.frames.main:CreateFontString(nil,"OVERLAY")
	self.frames.headerfrosttext.owner = self
	self.frames.headerfrosttext:SetFont(f, 14)
	self.frames.headerfrosttext:SetWidth(60)
	self.frames.headerfrosttext:SetText(L["Ft"])
	self.frames.headerfrosttext:SetTextColor(.5, .5, 1)
	self.frames.headerfrosttext:ClearAllPoints()
	self.frames.headerfrosttext:SetJustifyH("RIGHT")
	self.frames.headerfrosttext:SetAllPoints(self.frames.headerfrost)

	self.frames.headershadow = CreateFrame("Button", nil, self.frames.main)
	self.frames.headershadow.owner = self
	self.frames.headershadow:SetWidth(30)
	self.frames.headershadow:SetHeight(16)
	self.frames.headershadow:SetPoint("LEFT", self.frames.headerfrost, "RIGHT")
	self.frames.headershadow:SetScript("OnClick",
			function()
				this.owner:Sort(self.resists, 5)
				this.owner:UpdateScrollBar()
			end)

	self.frames.headershadowhigh = self.frames.headershadow:CreateTexture(nil, "BORDER")
	self.frames.headershadowhigh:SetWidth(30)
	self.frames.headershadowhigh:SetHeight(16)
	self.frames.headershadowhigh:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	self.frames.headershadowhigh:SetAllPoints(self.frames.headershadow)
	self.frames.headershadowhigh:SetBlendMode("ADD")
	self.frames.headershadowhigh:SetGradientAlpha("VERTICAL", .1, .08, 0, 0, .2, .16, 0, 1)
	self.frames.headershadow:SetHighlightTexture(self.frames.headershadowhigh)


	self.frames.headershadowtext = self.frames.main:CreateFontString(nil,"OVERLAY")
	self.frames.headershadowtext.owner = self
	self.frames.headershadowtext:SetFont(f, 14)
	self.frames.headershadowtext:SetWidth(60)
	self.frames.headershadowtext:SetText(L["S"])
	self.frames.headershadowtext:SetTextColor(.8, 0, 1)
	self.frames.headershadowtext:ClearAllPoints()
	self.frames.headershadowtext:SetJustifyH("RIGHT")
	self.frames.headershadowtext:SetAllPoints(self.frames.headershadow)

	self.frames.headerarcane = CreateFrame("Button", nil, self.frames.main)
	self.frames.headerarcane.owner = self
	self.frames.headerarcane:SetWidth(30)
	self.frames.headerarcane:SetHeight(16)
	self.frames.headerarcane:SetPoint("LEFT", self.frames.headershadow, "RIGHT")
	self.frames.headerarcane:SetScript("OnClick",
			function()
				this.owner:Sort(self.resists, 6)
				this.owner:UpdateScrollBar()
			end)

	self.frames.headerarcanehigh = self.frames.headerarcane:CreateTexture(nil, "BORDER")
	self.frames.headerarcanehigh:SetWidth(30)
	self.frames.headerarcanehigh:SetHeight(16)
	self.frames.headerarcanehigh:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	self.frames.headerarcanehigh:SetAllPoints(self.frames.headerarcane)
	self.frames.headerarcanehigh:SetBlendMode("ADD")
	self.frames.headerarcanehigh:SetGradientAlpha("VERTICAL", .1, .08, 0, 0, .2, .16, 0, 1)
	self.frames.headerarcane:SetHighlightTexture(self.frames.headerarcanehigh)


	self.frames.headerarcanetext = self.frames.main:CreateFontString(nil,"OVERLAY")
	self.frames.headerarcanetext.owner = self
	self.frames.headerarcanetext:SetFont(f, 14)
	self.frames.headerarcanetext:SetWidth(60)
	self.frames.headerarcanetext:SetText(L["A"])
	self.frames.headerarcanetext:SetTextColor(1, 1, 1)
	self.frames.headerarcanetext:ClearAllPoints()
	self.frames.headerarcanetext:SetJustifyH("RIGHT")
	self.frames.headerarcanetext:SetAllPoints(self.frames.headerarcane)




	self.frames.leftbutton = CreateFrame("Button", nil, self.frames.main)
	self.frames.leftbutton.owner = self
	self.frames.leftbutton:SetWidth(125)
	self.frames.leftbutton:SetHeight(32)
	self.frames.leftbutton:SetPoint("BOTTOMRIGHT", self.frames.main, "BOTTOM", -10, 10)
	
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
	self.frames.leftbuttontext:SetText(L["Refresh"])
	self.frames.leftbuttontext:SetAllPoints(self.frames.leftbutton)

	self.frames.leftbutton:SetScript("OnClick",
			function()
				this.owner:PerformResistanceCheck()
			end)



	self.frames.rightbutton = CreateFrame("Button", nil, self.frames.main)
	self.frames.rightbutton.owner = self
	self.frames.rightbutton:SetWidth(125)
	self.frames.rightbutton:SetHeight(32)
	self.frames.rightbutton:SetPoint("BOTTOMLEFT", self.frames.main, "BOTTOM", 10, 10)
	
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
	self.frames.rightbuttontext:SetText(L["Close"])
	self.frames.rightbuttontext:SetAllPoints(self.frames.rightbutton)

	self.frames.rightbutton:SetScript("OnClick",
			function()
				this.owner.frames.main:Hide()
			end)


	self.frames.entry = {}
	self.frames.entry[1] = self:ScrollEntryFrame(1)
	self.frames.entry[1]:SetPoint("TOPLEFT", self.frames.main, "TOPLEFT", 10, -55 )
	
	for i=2, 15 do
		j = i - 1
		self.frames.entry[i] = self:ScrollEntryFrame()
		self.frames.entry[i]:SetPoint("TOPLEFT", self.frames.entry[j], "BOTTOMLEFT")
	end


	self.frames.sframe = CreateFrame("ScrollFrame", "oRAResistScrollFrame", self.frames.main, "FauxScrollFrameTemplate")
	self.frames.sframe.owner = self
	self.frames.sframe:SetParent(self.frames.main)
	self.frames.sframe:SetWidth(285)
	self.frames.sframe:SetHeight(240)
	self.frames.sframe:SetPoint("TOPLEFT", self.frames.main, "TOPLEFT", 5, -55)

	self.frames.sframe:SetScript("OnVerticalScroll",
			function()
				FauxScrollFrame_OnVerticalScroll(16, function() this.owner:UpdateScrollBar() end)
			end )

end

function oRALResist:ScrollEntryFrame()
	local f = CreateFrame("Button", nil, self.frames.main )
	f:SetWidth(240)
	f:SetHeight(16)

	f.textname = f:CreateFontString(nil,"ARTWORK")
	f.textname:SetFontObject(GameFontHighlight)
	f.textname:SetWidth(130)
	f.textname:SetHeight(16)
	f.textname:SetJustifyH("LEFT")
	f.textname:SetNonSpaceWrap(false)
	f.textname:ClearAllPoints()
	f.textname:SetPoint( "LEFT", f, "LEFT")
	f.textname:SetTextColor(1,1,1)
	f.textname:SetText("Name")

	f.textfire = f:CreateFontString(nil,"ARTWORK")
	f.textfire:SetFontObject(GameFontHighlight)
	f.textfire:SetWidth(30)
	f.textfire:SetHeight(16)
	f.textfire:SetJustifyH("RIGHT")
	f.textfire:SetNonSpaceWrap(false)
	f.textfire:ClearAllPoints()
	f.textfire:SetPoint("LEFT", f.textname, "RIGHT")
	f.textfire:SetTextColor(1,0,0)
	f.textfire:SetText("12")

	f.textnature = f:CreateFontString(nil,"ARTWORK")
	f.textnature:SetFontObject(GameFontHighlight)
	f.textnature:SetWidth(30)
	f.textnature:SetHeight(16)
	f.textnature:SetJustifyH("RIGHT")
	f.textnature:SetNonSpaceWrap(false)
	f.textnature:ClearAllPoints()
	f.textnature:SetPoint("LEFT", f.textfire, "RIGHT")
	f.textnature:SetTextColor(0,1,0)
	f.textnature:SetText("3")

	f.textfrost = f:CreateFontString(nil,"ARTWORK")
	f.textfrost:SetFontObject(GameFontHighlight)
	f.textfrost:SetWidth(30)
	f.textfrost:SetHeight(16)
	f.textfrost:SetJustifyH("RIGHT")
	f.textfrost:SetNonSpaceWrap(false)
	f.textfrost:ClearAllPoints()
	f.textfrost:SetPoint("LEFT", f.textnature, "RIGHT")
	f.textfrost:SetTextColor(.5,.5,1)
	f.textfrost:SetText("3")

	f.textshadow = f:CreateFontString(nil,"ARTWORK")
	f.textshadow:SetFontObject(GameFontHighlight)
	f.textshadow:SetWidth(30)
	f.textshadow:SetHeight(16)
	f.textshadow:SetJustifyH("RIGHT")
	f.textshadow:SetNonSpaceWrap(false)
	f.textshadow:ClearAllPoints()
	f.textshadow:SetPoint("LEFT", f.textfrost, "RIGHT")
	f.textshadow:SetTextColor(.8,0,1)
	f.textshadow:SetText("3")

	f.textarcane = f:CreateFontString(nil,"ARTWORK")
	f.textarcane:SetFontObject(GameFontHighlight)
	f.textarcane:SetWidth(30)
	f.textarcane:SetHeight(16)
	f.textarcane:SetJustifyH("RIGHT")
	f.textarcane:SetNonSpaceWrap(false)
	f.textarcane:ClearAllPoints()
	f.textarcane:SetPoint("LEFT", f.textshadow, "RIGHT")
	f.textarcane:SetTextColor(1,1,1)
	f.textarcane:SetText("3")

	return f
end

function oRALResist:UpdateScrollBar()
	local i,j
	local entries = table.getn(self.resists)
	FauxScrollFrame_Update(self.frames.sframe, entries, 15, 16)

	for i = 1, 15 do
		j = i + FauxScrollFrame_GetOffset(self.frames.sframe)

		if j <= entries then
			self.frames.entry[i].textname:SetText(self.resists[j][1])
			self.frames.entry[i].textfire:SetText(self.resists[j][2])
			self.frames.entry[i].textnature:SetText(self.resists[j][3])
			self.frames.entry[i].textfrost:SetText(self.resists[j][4])
			self.frames.entry[i].textshadow:SetText(self.resists[j][5])
			self.frames.entry[i].textarcane:SetText(self.resists[j][6])
			self.frames.entry[i]:Show()
		else
			self.frames.entry[i]:Hide()
		end
	end

end

----------------------
-- Command Handlers --
----------------------

function oRALResist:PerformResistanceCheck()
	if not self:IsPromoted() then return end
	reclaimtable(self.resists)
	self.resists = nil
	self.resists = getnewtable()
	self:SendMessage("RSTC")
	self.frames.main:Show()
	self:UpdateScrollBar()
end


function oRALResist:Sort(tbl, sortBy)
	table.sort(tbl,
		function(t1, t2)
			if (t1[sortBy] == t2[sortBy] ) then
				return t1[1] < t2[1]
			else
				return t1[sortBy] > t2[sortBy]
			end
		end
	)
end

