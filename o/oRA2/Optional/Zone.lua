
assert( oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRAOZone")

local compost = AceLibrary:HasInstance("Compost-2.0") and AceLibrary("Compost-2.0")
local function getnewtable() return compost and compost:Acquire() or {} end
local function reclaimtable(t) if compost then compost:Reclaim(t) end end

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["zoneoptional"] = true,
	["zone"] = true,
	["Zone"] = true,
	["Options for zone checks."] = true,
	["Refresh"] = true,
	["Close"] = true,
	["Unknown"] = true,
	["Name"] = true,
	["Optional/Zone"] = true,
	["check"] = true,
	["Perform zone check"] = true,
	["Check the raid's location."] = true,
} end )

L:RegisterTranslations("koKR", function() return {

	["Zone"] = "지역",
	["Options for zone checks."] = "지역 확인 설정",
	["Refresh"] = "갱신",
	["Close"] = "닫기",
	["Unknown"] = "알수없음",
	["Name"] = "이름",
	["Optional/Zone"] = "부가/지역",
	["Perform zone check"] = "지역 확인 실시",
	["Check the raid's location."] = "공격대원의 위치를 확인합니다.",
} end )

L:RegisterTranslations("zhCN", function() return {
	["zoneoptional"] = "zoneoptional",
	["zone"] = "区域",
	["Zone"] = "区域",
	["Options for zone checks."] = "区域检查选项",
	["Refresh"] = "刷新",
	["Close"] = "关闭",
	["Unknown"] = "未知",
	["Name"] = "姓名",
	["Optional/Zone"] = "Optional/Zone",
	["check"] = "检查",
	["Perform zone check"] = "区域检查",
	["Check the raid's location."] = "检查团队所在区域",
} end )

L:RegisterTranslations("zhTW", function() return {
	["zoneoptional"] = "zoneoptional",
	["zone"] = "區域",
	["Zone"] = "區域",
	["Options for zone checks."] = "區域檢查選項",
	["Refresh"] = "更新",
	["Close"] = "關閉",
	["Unknown"] = "未知",
	["Name"] = "姓名",
	["Optional/Zone"] = "可選/區域",
	["check"] = "檢查",
	["Perform zone check"] = "區域檢查",
	["Check the raid's location."] = "檢查團隊所在區域",
} end )

L:RegisterTranslations("frFR", function() return {
	--["zoneoptional"] = true,
	--["zone"] = true,
	--["Zone"] = true,
	["Options for zone checks."] = "Options concernant les v\195\169rifications de zone.",
	["Refresh"] = "Rafra\195\174chir",
	["Close"] = "Fermer",
	["Unknown"] = "Inconnu",
	["Name"] = "Nom",
	["Optional/Zone"] = "Optionnel/Zone",
	--["check"] = true,
	["Perform zone check"] = "V\195\169rifier les zones",
	["Check the raid's location."] = "V\195\169rifie la position des membres du raid.",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

oRAOZone = oRA:NewModule(L["zoneoptional"])
oRAOZone.defaults = {
}
oRAOZone.participant = true
oRAOZone.name = L["Optional/Zone"]
oRAOZone.consoleCmd = L["zone"]
oRAOZone.consoleOptions = {
	type = "group",
	desc = L["Options for zone checks."],
	name = L["Zone"],
	args = {
		[L["check"]] = {
			type="execute", name = L["Perform zone check"],
			desc = L["Check the raid's location."],
			func = function()
				oRAOZone:PerformZoneCheck()
			end,
			disabled = function() return not oRA:IsModuleActive(oRAOZone) end,
		},
	}
}

------------------------------
--      Initialization      --
------------------------------

function oRAOZone:OnEnable()
	self.players = getnewtable()
	self.sorting = getnewtable()

	self.sorting[1] = L["Name"]
	self.sorting[2] = L["Zone"]

	self:SetupFrames()
	self:RegisterShorthand("razone", function() self:PerformZoneCheck() end )
end

function oRAOZone:OnDisable()
	self:UnregisterAllEvents()

	self:UnregisterShorthand("razone")

	reclaimtable( self.players )
	self.players = nil
	reclaimtable( self.sorting )
	self.sorting = nil
end
	

-----------------------
--  Command Handlers --
-----------------------

function oRAOZone:PerformZoneCheck()
	local playerzone = GetRealZoneText()
	local playername = UnitName("player")

	reclaimtable( self.players )
	self.players = nil
	self.players = getnewtable()

	for i = 1, GetNumRaidMembers() do
		local name, _, _, _, _, class, zone, _, _ = GetRaidRosterInfo(i)
		zone = zone or L["Unknown"]
		if name ~= playername and zone ~= playerzone then
			table.insert(self.players, {name, zone})
		end
	end
	self.frames.main:Show()
	self:UpdateScrollBar()
	
end
	
---------------------------
--   Utility Functions   --
---------------------------

function oRAOZone:SetupFrames()
	local f, t, sframe, i, j

	f, _, _ = GameFontNormal:GetFont()

	self.frames = {}

	self.frames.main = CreateFrame("Frame", "oRAZoneReportFrame", UIParent)
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
	self.frames.header:SetText(L["Zone"])
	self.frames.header:SetTextColor(1, .8, 0)
	self.frames.header:ClearAllPoints()
	self.frames.header:SetPoint("TOP", self.frames.main, "TOP", 0, -10)

	self.frames.headername = CreateFrame("Button", nil, self.frames.main)
	self.frames.headername.owner = self
	self.frames.headername:SetWidth(125)
	self.frames.headername:SetHeight(16)
	self.frames.headername:SetPoint("TOPLEFT", self.frames.main, "TOPLEFT", 10, -35)
	self.frames.headername:SetScript("OnClick",
			function()
				this.owner:Sort(self.players, 1)
				this.owner:UpdateScrollBar()
			end)

	self.frames.headernamehigh = self.frames.headername:CreateTexture(nil, "BORDER")
	self.frames.headernamehigh:SetWidth(125)
	self.frames.headernamehigh:SetHeight(16)
	self.frames.headernamehigh:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	self.frames.headernamehigh:SetAllPoints(self.frames.headername)
	self.frames.headernamehigh:SetBlendMode("ADD")
	self.frames.headernamehigh:SetGradientAlpha("VERTICAL", .1, .08, 0, 0, .2, .16, 0, 1)
	self.frames.headername:SetHighlightTexture(self.frames.headernamehigh)

	self.frames.headernametext = self.frames.headername:CreateFontString(nil,"OVERLAY")
	self.frames.headernametext.owner = self
	self.frames.headernametext:SetFont(f, 14)
	self.frames.headernametext:SetWidth(125)
	self.frames.headernametext:SetText(L["Name"])
	self.frames.headernametext:SetTextColor(1, .8, 0)
	self.frames.headernametext:ClearAllPoints()
	self.frames.headernametext:SetJustifyH("LEFT")
	self.frames.headernametext:SetAllPoints(self.frames.headername)

	self.frames.headerzone = CreateFrame("Button", nil, self.frames.main)
	self.frames.headerzone.owner = self
	self.frames.headerzone:SetWidth(155)
	self.frames.headerzone:SetHeight(16)
	self.frames.headerzone:SetPoint("LEFT", self.frames.headername, "RIGHT")
	self.frames.headerzone:SetScript("OnClick",
			function()
				this.owner:Sort(self.players, 2)
				this.owner:UpdateScrollBar()
			end)

	self.frames.headerzonehigh = self.frames.headerzone:CreateTexture(nil, "BORDER")
	self.frames.headerzonehigh:SetWidth(155)
	self.frames.headerzonehigh:SetHeight(16)
	self.frames.headerzonehigh:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	self.frames.headerzonehigh:SetAllPoints(self.frames.headerzone)
	self.frames.headerzonehigh:SetBlendMode("ADD")
	self.frames.headerzonehigh:SetGradientAlpha("VERTICAL", .1, .08, 0, 0, .2, .16, 0, 1)
	self.frames.headerzone:SetHighlightTexture(self.frames.headerzonehigh)


	self.frames.headerzonetext = self.frames.main:CreateFontString(nil,"OVERLAY")
	self.frames.headerzonetext:SetFont(f, 14)
	self.frames.headerzonetext:SetWidth(155)
	self.frames.headerzonetext:SetText(L["Zone"])
	self.frames.headerzonetext:SetTextColor(1, .8, 0)
	self.frames.headerzonetext:ClearAllPoints()
	self.frames.headerzonetext:SetJustifyH("LEFT")
	self.frames.headerzonetext:SetAllPoints(self.frames.headerzone)

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
				this.owner:PerformZoneCheck()
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


	self.frames.sframe = CreateFrame("ScrollFrame", "oRAOZoneScrollFrame", self.frames.main, "FauxScrollFrameTemplate")
	self.frames.sframe.owner = self
	self.frames.sframe:SetWidth(285)
	self.frames.sframe:SetHeight(240)
	self.frames.sframe:SetPoint("TOPLEFT", self.frames.main, "TOPLEFT", 5, -55)

	self.frames.sframe:SetScript("OnVerticalScroll",
			function()
				FauxScrollFrame_OnVerticalScroll(16, function() this.owner:UpdateScrollBar() end)
			end )

end

function oRAOZone:ScrollEntryFrame()
	local f = CreateFrame("Button", nil, self.frames.main )
	f:SetWidth(240)
	f:SetHeight(16)

	f.textname = f:CreateFontString(nil,"ARTWORK")
	f.textname:SetFontObject(GameFontHighlight)
	f.textname:SetWidth(125)
	f.textname:SetHeight(16)
	f.textname:SetJustifyH("LEFT")
	f.textname:SetNonSpaceWrap(false)
	f.textname:ClearAllPoints()
	f.textname:SetPoint( "LEFT", f, "LEFT")
	f.textname:SetTextColor(1,1,1)
	f.textname:SetText(L["Name"])

	f.textzone = f:CreateFontString(nil,"ARTWORK")
	f.textzone:SetFontObject(GameFontHighlight)
	f.textzone:SetWidth(155)
	f.textzone:SetHeight(16)
	f.textzone:SetJustifyH("LEFT")
	f.textzone:SetNonSpaceWrap(false)
	f.textzone:ClearAllPoints()
	f.textzone:SetPoint("LEFT", f.textname, "RIGHT")
	f.textzone:SetTextColor(1,1,1)
	f.textzone:SetText(L["Zone"])

	return f
end

function oRAOZone:UpdateScrollBar()
	local i,j
	local entries = table.getn(self.players)
	FauxScrollFrame_Update(self.frames.sframe, entries, 15, 16)

	for i = 1, 15 do
		j = i + FauxScrollFrame_GetOffset(self.frames.sframe)

		if j <= entries then
			self.frames.entry[i].textname:SetText(self.players[j][1])
			self.frames.entry[i].textzone:SetText(self.players[j][2])
			self.frames.entry[i]:Show()
		else
			self.frames.entry[i]:Hide()
		end
	end
end

function oRAOZone:Sort( tbl, sortBy )
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

