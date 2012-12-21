
assert( oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRAOVersion")
local roster = AceLibrary("RosterLib-2.0")

local compost = AceLibrary:HasInstance("Compost-2.0") and AceLibrary("Compost-2.0")
local function getnewtable() return compost and compost:Acquire() or {} end
local function reclaimtable(t) if compost then compost:Reclaim(t) end end

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["versionoptional"] = true,
	["version"] = true,
	["Version"] = true,
	["Options for version checks."] = true,
	["Refresh"] = true,
	["Close"] = true,
	["Unknown"] = true,
	["Name"] = true,
	["Optional/Version"] = true,
	["check"] = true,
	["Perform version check"] = true,
	["Check the raid's versions."] = true,
	["CTRA"] = true,
	["oRA"] = true,
	["n/a"] = true,
} end )

L:RegisterTranslations("koKR", function() return {

	["Version"] = "버전",
	["Options for version checks."] = "버전 확인 설정.",
	["Refresh"] = "갱신",
	["Close"] = "닫기",
	["Unknown"] = "알수없음",
	["Name"] = "이름",
	["Optional/Version"] = "부가/버전",
	["Perform version check"] = "버전 확인 실시",
	["Check the raid's versions."] = "공격대원의 애드온 버전을 확인합니다.",
	["CTRA"] = "공격대 도우미",
	["oRA"] = "oRA",
	["n/a"] = "없음",
} end )

L:RegisterTranslations("zhCN", function() return {
	["versionoptional"] = "versionoptional",
	["version"] = "版本",
	["Version"] = "版本",
	["Options for version checks."] = "版本检查选项",
	["Refresh"] = "刷新",
	["Close"] = "关闭",
	["Unknown"] = "未知",
	["Name"] = "姓名",
	["Optional/Version"] = "Optional/Version",
	["check"] = "检查",
	["Perform version check"] = "进行版本检查",
	["Check the raid's versions."] = "检查团队版本",
	["CTRA"] = "CTRA",
	["oRA"] = "oRA",
	["n/a"] = "n/a",
} end )

L:RegisterTranslations("zhTW", function() return {
	["versionoptional"] = "versionoptional",
	["version"] = "版本",
	["Version"] = "版本",
	["Options for version checks."] = "版本檢查選項",
	["Refresh"] = "更新",
	["Close"] = "關閉",
	["Unknown"] = "未知",
	["Name"] = "姓名",
	["Optional/Version"] = "可選/版本",
	["check"] = "檢查",
	["Perform version check"] = "進行版本檢查",
	["Check the raid's versions."] = "檢查團隊版本",
	["CTRA"] = "CTRA",
	["oRA"] = "oRA",
	["n/a"] = "無",
} end )

L:RegisterTranslations("frFR", function() return {
	--["versionoptional"] = true,
	--["version"] = true,
	--["Version"] = true,
	["Options for version checks."] = "Options concernant les v\195\169rifications des versions.",
	["Refresh"] = "Rafra\195\174chir",
	["Close"] = "Fermer",
	["Unknown"] = "Inconnu",
	["Name"] = "Nom",
	["Optional/Version"] = "Optionnel/Version",
	--["check"] = true,
	["Perform version check"] = "V\195\169rifier les versions",
	["Check the raid's versions."] = "V\195\169rifie les versions du raid.",
	--["CTRA"] = true,
	--["oRA"] = true,
	--["n/a"] = true,
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

oRAOVersion = oRA:NewModule(L["versionoptional"])
oRAOVersion.defaults = {
}
oRAOVersion.participant = true
oRAOVersion.name = L["Optional/Version"]
oRAOVersion.consoleCmd = L["version"]
oRAOVersion.consoleOptions = {
	type = "group",
	desc = L["Options for version checks."],
	name = L["Version"],
	args = {
		[L["check"]] = {
			type="execute", name = L["Perform version check"],
			desc = L["Check the raid's versions."],
			func = function()
					oRAOVersion:PerformVersionCheck()
			end,
			disabled = function() return not oRA:IsModuleActive(oRAOVersion) end,
		},
	}
}

------------------------------
--      Initialization      --
------------------------------

function oRAOVersion:OnEnable()
	self.versions = getnewtable()
	self.sorting = getnewtable()

	self.sorting[1] = L["Name"]
	self.sorting[2] = L["CTRA"]
	self.sorting[3] = L["oRA"]

	self:SetupFrames()
	self:RegisterShorthand("raver", function() self:PerformVersionCheck() end )
	self:RegisterShorthand("raversion", function() self:PerformVersionCheck() end )
end

function oRAOVersion:OnDisable()
	self:UnregisterAllEvents()

	self:UnregisterShorthand("raver")
	self:UnregisterShorthand("raversion")

	reclaimtable( self.versions )
	self.versions = nil
	reclaimtable( self.sorting )
	self.sorting = nil
end
	

-----------------------
--  Command Handlers --
-----------------------

function oRAOVersion:PerformVersionCheck()
	reclaimtable( self.versions )
	self.versions = nil
	self.versions = getnewtable()

	for n, u in pairs(roster.roster) do
		if u and u.name and u.class ~= "PET" then
			local ctraversion = u.ora_ctraversion or L["n/a"]
			local oraversion = u.ora_version or L["n/a"]
			table.insert(self.versions, {u.name, ctraversion, oraversion} )
		end
	end
	self.frames.main:Show()
	self:UpdateScrollBar()
end
	
---------------------------
--   Utility Functions   --
---------------------------

function oRAOVersion:SetupFrames()
	local f, t, sframe, i, j

	f, _, _ = GameFontNormal:GetFont()

	self.frames = {}

	self.frames.main = CreateFrame("Frame", "oRAVersionReportFrame", UIParent)
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
	self.frames.header:SetText(L["Version"])
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
				this.owner:Sort(self.versions, 1)
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

	self.frames.headerctraversion = CreateFrame("Button", nil, self.frames.main)
	self.frames.headerctraversion.owner = self
	self.frames.headerctraversion:SetWidth(75)
	self.frames.headerctraversion:SetHeight(16)
	self.frames.headerctraversion:SetPoint("LEFT", self.frames.headername, "RIGHT")
	self.frames.headerctraversion:SetScript("OnClick",
			function()
				this.owner:Sort(self.versions, 2)
				this.owner:UpdateScrollBar()
			end)

	self.frames.headerctraversionhigh = self.frames.headerctraversion:CreateTexture(nil, "BORDER")
	self.frames.headerctraversionhigh:SetWidth(75)
	self.frames.headerctraversionhigh:SetHeight(16)
	self.frames.headerctraversionhigh:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	self.frames.headerctraversionhigh:SetAllPoints(self.frames.headerctraversion)
	self.frames.headerctraversionhigh:SetBlendMode("ADD")
	self.frames.headerctraversionhigh:SetGradientAlpha("VERTICAL", .1, .08, 0, 0, .2, .16, 0, 1)
	self.frames.headerctraversion:SetHighlightTexture(self.frames.headerctraversionhigh)


	self.frames.headerctraversiontext = self.frames.main:CreateFontString(nil,"OVERLAY")
	self.frames.headerctraversiontext:SetFont(f, 14)
	self.frames.headerctraversiontext:SetWidth(75)
	self.frames.headerctraversiontext:SetText(L["CTRA"])
	self.frames.headerctraversiontext:SetTextColor(1, .8, 0)
	self.frames.headerctraversiontext:ClearAllPoints()
	self.frames.headerctraversiontext:SetJustifyH("LEFT")
	self.frames.headerctraversiontext:SetAllPoints(self.frames.headerctraversion)

	self.frames.headeroraversion = CreateFrame("Button", nil, self.frames.main)
	self.frames.headeroraversion.owner = self
	self.frames.headeroraversion:SetWidth(75)
	self.frames.headeroraversion:SetHeight(16)
	self.frames.headeroraversion:SetPoint("LEFT", self.frames.headerctraversion, "RIGHT")
	self.frames.headeroraversion:SetScript("OnClick",
			function()
				this.owner:Sort(self.versions, 3)
				this.owner:UpdateScrollBar()
			end)

	self.frames.headeroraversionhigh = self.frames.headeroraversion:CreateTexture(nil, "BORDER")
	self.frames.headeroraversionhigh:SetWidth(75)
	self.frames.headeroraversionhigh:SetHeight(16)
	self.frames.headeroraversionhigh:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	self.frames.headeroraversionhigh:SetAllPoints(self.frames.headeroraversion)
	self.frames.headeroraversionhigh:SetBlendMode("ADD")
	self.frames.headeroraversionhigh:SetGradientAlpha("VERTICAL", .1, .08, 0, 0, .2, .16, 0, 1)
	self.frames.headeroraversion:SetHighlightTexture(self.frames.headeroraversionhigh)


	self.frames.headeroraversiontext = self.frames.main:CreateFontString(nil,"OVERLAY")
	self.frames.headeroraversiontext.owner = self
	self.frames.headeroraversiontext:SetFont(f, 14)
	self.frames.headeroraversiontext:SetWidth(75)
	self.frames.headeroraversiontext:SetText(L["oRA"])
	self.frames.headeroraversiontext:SetTextColor(1, .8, 0)
	self.frames.headeroraversiontext:ClearAllPoints()
	self.frames.headeroraversiontext:SetJustifyH("LEFT")
	self.frames.headeroraversiontext:SetAllPoints(self.frames.headeroraversion)




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
				this.owner:PerformVersionCheck()
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


	self.frames.sframe = CreateFrame("ScrollFrame", "oRAVersionScrollFrame", self.frames.main, "FauxScrollFrameTemplate")
	self.frames.sframe.owner = self
	self.frames.sframe:SetWidth(285)
	self.frames.sframe:SetHeight(240)
	self.frames.sframe:SetPoint("TOPLEFT", self.frames.main, "TOPLEFT", 5, -55)

	self.frames.sframe:SetScript("OnVerticalScroll",
			function()
				FauxScrollFrame_OnVerticalScroll(16, function() this.owner:UpdateScrollBar() end)
			end )

end

function oRAOVersion:ScrollEntryFrame()
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
	f.textname:SetText(L["Name"])

	f.textctraversion = f:CreateFontString(nil,"ARTWORK")
	f.textctraversion:SetFontObject(GameFontHighlight)
	f.textctraversion:SetWidth(75)
	f.textctraversion:SetHeight(16)
	f.textctraversion:SetJustifyH("LEFT")
	f.textctraversion:SetNonSpaceWrap(false)
	f.textctraversion:ClearAllPoints()
	f.textctraversion:SetPoint("LEFT", f.textname, "RIGHT")
	f.textctraversion:SetTextColor(1,1,1)
	f.textctraversion:SetText("125")

	f.textoraversion = f:CreateFontString(nil,"ARTWORK")
	f.textoraversion:SetFontObject(GameFontHighlight)
	f.textoraversion:SetWidth(75)
	f.textoraversion:SetHeight(16)
	f.textoraversion:SetJustifyH("RIGHT")
	f.textoraversion:SetNonSpaceWrap(false)
	f.textoraversion:ClearAllPoints()
	f.textoraversion:SetPoint("LEFT", f.textctraversion, "RIGHT")
	f.textoraversion:SetTextColor(1,1,1)
	f.textoraversion:SetText("3")

	return f
end

function oRAOVersion:UpdateScrollBar()
	local i,j
	local entries = table.getn(self.versions)
	FauxScrollFrame_Update(self.frames.sframe, entries, 15, 16)

	for i = 1, 15 do
		j = i + FauxScrollFrame_GetOffset(self.frames.sframe)

		if j <= entries then
			self.frames.entry[i].textname:SetText(self.versions[j][1])
			self.frames.entry[i].textctraversion:SetText(self.versions[j][2])
			self.frames.entry[i].textoraversion:SetText(self.versions[j][3])
			self.frames.entry[i]:Show()
		else
			self.frames.entry[i]:Hide()
		end
	end
end


function oRAOVersion:Sort( tbl, sortBy )
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

