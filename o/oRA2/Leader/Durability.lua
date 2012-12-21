
assert( oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRALDurability")

local compost = AceLibrary:HasInstance("Compost-2.0") and AceLibrary("Compost-2.0")
local function getnewtable() return compost and compost:Acquire() or {} end
local function reclaimtable(t) if compost then compost:Reclaim(t) end end

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["durabilityleader"] = true,
	["durability"] = true,
	["Durability"] = true,
	["Leader/Durability"] = true,
	["Options for durability checks."] = true,
	["check"] = true,
	["Perform durability check"] = true,
	["Check the raid's durability."] = true,
	["Name"] = true,
	["Percent"] = true,
	["Broken"] = true,
	["Perc"] = true,
	["Close"] = true,
	["Refresh"] = true,
} end )

L:RegisterTranslations("koKR", function() return {

	["Durability"] = "내구도",
	["Leader/Durability"] = "공격대장/내구도",
	["Options for durability checks."] = "내구도 확인 설정",
	["Perform durability check"] = "내구도 확인 실시",
	["Check the raid's durability."] = "공격대원의 아이템의 내구도를 확인합니다",
	["Name"] = "이름",
	["Percent"] = "백분률",
	["Broken"] = "파손",
	["Perc"] = "백분률",
	["Close"] = "닫기",
	["Refresh"] = "갱신",
} end )

L:RegisterTranslations("zhCN", function() return {
	["durabilityleader"] = "durabilityleader",
	["durability"] = "装备耐久度",
	["Durability"] = "装备耐久度",
	["Leader/Durability"] = "Leader/Durability",
	["Options for durability checks."] = "耐久度选项",
	["check"] = "检查",
	["Perform durability check"] = "执行耐久度检查",
	["Check the raid's durability."] = "检查团队耐久度",
	["Name"] = "姓名",
	["Percent"] = "百分比",
	["Broken"] = "损坏",
	["Perc"] = "百分比",
	["Close"] = "关闭",
	["Refresh"] = "刷新",
} end )

L:RegisterTranslations("zhTW", function() return {
	["durabilityleader"] = "durabilityleader",
	["durability"] = "裝備耐久度",
	["Durability"] = "裝備耐久度",
	["Leader/Durability"] = "領隊/裝備耐久度",
	["Options for durability checks."] = "耐久度選項",
	["check"] = "檢查",
	["Perform durability check"] = "執行耐久度檢查",
	["Check the raid's durability."] = "檢查團隊耐久度",
	["Name"] = "姓名",
	["Percent"] = "百分比",
	["Broken"] = "損壞",
	["Perc"] = "百分比",
	["Close"] = "關閉",
	["Refresh"] = "更新",
} end )

L:RegisterTranslations("frFR", function() return {
	--["durabilityleader"] = true,
	--["durability"] = true,
	["Durability"] = "Durabilit\195\169",
	["Leader/Durability"] = "Chef/Durabilit\195\169",
	["Options for durability checks."] = "Options concernant les v\195\169rifications des durabilit\195\169s.",
	--["check"] = true,
	["Perform durability check"] = "V\195\169rifier les durabilit\195\169s",
	["Check the raid's durability."] = "V\195\169rifie les durabilit\195\169s du raid.",
	["Name"] = "Nom",
	["Percent"] = "Pourcent",
	["Broken"] = "Cass\195\169(s)",
	["Perc"] = "Pourc",
	["Close"] = "Fermer",
	["Refresh"] = "Rafra\195\174chir",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

oRALDurability = oRA:NewModule(L["durabilityleader"])
oRALDurability.defaults = {
}
oRALDurability.leader = true
oRALDurability.name = L["Leader/Durability"]
oRALDurability.consoleCmd = L["durability"]
oRALDurability.consoleOptions = {
	type = "group",
	desc = L["Options for durability checks."],
	name = L["Durability"],
	args = {
		[L["check"]] = {
			type="execute", name = L["Perform durability check"],
			desc = L["Check the raid's durability."],
			func = function()
					oRALDurability:PerformDurabilityCheck()
				end,
			disabled = function() return not oRA:IsModuleActive(oRALDurability) or not oRALDurability:IsValidRequest() end,
		},
	}
}


------------------------------
--      Initialization      --
------------------------------

function oRALDurability:OnEnable()
	self.durability = getnewtable()
	self.sorting = getnewtable()

	self.sorting[1] = L["Name"]
	self.sorting[2] = L["Percent"]
	self.sorting[3] = L["Broken"]

	self:SetupFrames()
	self:RegisterCheck("DUR", "oRA_DurabilityResponse")

	self:RegisterShorthand("radur", function(item) self:PerformDurabilityCheck() end )
end

function oRALDurability:OnDisable()
	self:UnregisterAllEvents()

	self:UnregisterCheck("DUR")

	self:UnregisterShorthand("radur")

	reclaimtable( self.durability )
	self.durability = nil
	reclaimtable( self.sorting )
	self.sorting = nil
end


--------------------
-- Event Handlers --
--------------------

function oRALDurability:oRA_DurabilityResponse(msg, author)
	if not self:IsValidRequest(author, true) then return end
	msg = self:CleanMessage(msg)
	local _,_,cur,max,broken,requestby = string.find(msg, "^DUR (%d+) (%d+) (%d+) ([^%s]+)$")
	if cur and requestby and requestby == UnitName("player") then
		local p = math.floor(cur / max * 100)
		table.insert(self.durability, {author, p, broken})
		self:UpdateScrollBar()
	end
end

----------------------
-- Command handlers --
----------------------

function oRALDurability:PerformDurabilityCheck()
	if not self:IsPromoted() then return end

	reclaimtable(self.durability)
	self.durability = nil
	self.durability = getnewtable()

	self:SendMessage("DURC")

	self.frames.main:Show()
	self:UpdateScrollBar()
end

-----------------------
-- Utility Functions --
-----------------------

function oRALDurability:SetupFrames()
	local f, t, sframe, i, j

	f, _, _ = GameFontNormal:GetFont()

	self.frames = {}

	self.frames.main = CreateFrame("Frame", "oRADurReportFrame", UIParent)
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
	self.frames.header:SetText(L["Durability"])
	self.frames.header:SetTextColor(1, .8, 0)
	self.frames.header:ClearAllPoints()
	self.frames.header:SetPoint("TOP", self.frames.main, "TOP", 0, -10)

	self.frames.headername = CreateFrame("Button", nil, self.frames.main)
	self.frames.headername.owner = self
	self.frames.headername:SetWidth(150)
	self.frames.headername:SetHeight(16)
	self.frames.headername:SetPoint("TOPLEFT", self.frames.main, "TOPLEFT", 10, -35)
	self.frames.headername:SetScript("OnClick",
			function()
				this.owner:Sort(self.durability, 1)
				this.owner:UpdateScrollBar()
			end)

	self.frames.headernamehigh = self.frames.headername:CreateTexture(nil, "BORDER")
	self.frames.headernamehigh:SetWidth(150)
	self.frames.headernamehigh:SetHeight(16)
	self.frames.headernamehigh:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	self.frames.headernamehigh:SetAllPoints(self.frames.headername)
	self.frames.headernamehigh:SetBlendMode("ADD")
	self.frames.headernamehigh:SetGradientAlpha("VERTICAL", .1, .08, 0, 0, .2, .16, 0, 1)
	self.frames.headername:SetHighlightTexture(self.frames.headernamehigh)

	self.frames.headernametext = self.frames.headername:CreateFontString(nil,"OVERLAY")
	self.frames.headernametext.owner = self
	self.frames.headernametext:SetFont(f, 14)
	self.frames.headernametext:SetWidth(150)
	self.frames.headernametext:SetText(L["Name"])
	self.frames.headernametext:SetTextColor(1, .8, 0)
	self.frames.headernametext:ClearAllPoints()
	self.frames.headernametext:SetJustifyH("LEFT")
	self.frames.headernametext:SetAllPoints(self.frames.headername)

	self.frames.headerperc = CreateFrame("Button", nil, self.frames.main)
	self.frames.headerperc.owner = self
	self.frames.headerperc:SetWidth(70)
	self.frames.headerperc:SetHeight(16)
	self.frames.headerperc:SetPoint("LEFT", self.frames.headername, "RIGHT")
	self.frames.headerperc:SetScript("OnClick",
			function()
				this.owner:Sort(self.durability, 2)
				this.owner:UpdateScrollBar()
			end)

	self.frames.headerperchigh = self.frames.headerperc:CreateTexture(nil, "BORDER")
	self.frames.headerperchigh:SetWidth(70)
	self.frames.headerperchigh:SetHeight(16)
	self.frames.headerperchigh:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	self.frames.headerperchigh:SetAllPoints(self.frames.headerperc)
	self.frames.headerperchigh:SetBlendMode("ADD")
	self.frames.headerperchigh:SetGradientAlpha("VERTICAL", .1, .08, 0, 0, .2, .16, 0, 1)
	self.frames.headerperc:SetHighlightTexture(self.frames.headerperchigh)


	self.frames.headerperctext = self.frames.main:CreateFontString(nil,"OVERLAY")
	self.frames.headerperctext:SetFont(f, 14)
	self.frames.headerperctext:SetWidth(70)
	self.frames.headerperctext:SetText(L["Perc"])
	self.frames.headerperctext:SetTextColor(1, .8, 0)
	self.frames.headerperctext:ClearAllPoints()
	self.frames.headerperctext:SetJustifyH("LEFT")
	self.frames.headerperctext:SetAllPoints(self.frames.headerperc)

	self.frames.headerbroken = CreateFrame("Button", nil, self.frames.main)
	self.frames.headerbroken.owner = self
	self.frames.headerbroken:SetWidth(60)
	self.frames.headerbroken:SetHeight(16)
	self.frames.headerbroken:SetPoint("LEFT", self.frames.headerperc, "RIGHT")
	self.frames.headerbroken:SetScript("OnClick",
			function()
				this.owner:Sort(self.durability, 3)
				this.owner:UpdateScrollBar()
			end)

	self.frames.headerbrokenhigh = self.frames.headerbroken:CreateTexture(nil, "BORDER")
	self.frames.headerbrokenhigh:SetWidth(60)
	self.frames.headerbrokenhigh:SetHeight(16)
	self.frames.headerbrokenhigh:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	self.frames.headerbrokenhigh:SetAllPoints(self.frames.headerbroken)
	self.frames.headerbrokenhigh:SetBlendMode("ADD")
	self.frames.headerbrokenhigh:SetGradientAlpha("VERTICAL", .1, .08, 0, 0, .2, .16, 0, 1)
	self.frames.headerbroken:SetHighlightTexture(self.frames.headerbrokenhigh)


	self.frames.headerbrokentext = self.frames.main:CreateFontString(nil,"OVERLAY")
	self.frames.headerbrokentext.owner = self
	self.frames.headerbrokentext:SetFont(f, 14)
	self.frames.headerbrokentext:SetWidth(60)
	self.frames.headerbrokentext:SetText(L["Broken"])
	self.frames.headerbrokentext:SetTextColor(1, .8, 0)
	self.frames.headerbrokentext:ClearAllPoints()
	self.frames.headerbrokentext:SetJustifyH("LEFT")
	self.frames.headerbrokentext:SetAllPoints(self.frames.headerbroken)




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
				this.owner:PerformDurabilityCheck()
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


	self.frames.sframe = CreateFrame("ScrollFrame", "oRADurabilityScrollFrame", self.frames.main, "FauxScrollFrameTemplate")
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

function oRALDurability:ScrollEntryFrame()
	local f = CreateFrame("Button", nil, self.frames.main )
	f:SetWidth(240)
	f:SetHeight(16)

	f.textname = f:CreateFontString(nil,"ARTWORK")
	f.textname:SetFontObject(GameFontHighlight)
	f.textname:SetWidth(150)
	f.textname:SetHeight(16)
	f.textname:SetJustifyH("LEFT")
	f.textname:SetNonSpaceWrap(false)
	f.textname:ClearAllPoints()
	f.textname:SetPoint( "LEFT", f, "LEFT")
	f.textname:SetTextColor(1,1,1)
	f.textname:SetText("Name")

	f.textperc = f:CreateFontString(nil,"ARTWORK")
	f.textperc:SetFontObject(GameFontHighlight)
	f.textperc:SetWidth(70)
	f.textperc:SetHeight(16)
	f.textperc:SetJustifyH("LEFT")
	f.textperc:SetNonSpaceWrap(false)
	f.textperc:ClearAllPoints()
	f.textperc:SetPoint("LEFT", f.textname, "RIGHT")
	f.textperc:SetTextColor(1,1,1)
	f.textperc:SetText("12%")

	f.textbroken = f:CreateFontString(nil,"ARTWORK")
	f.textbroken:SetFontObject(GameFontHighlight)
	f.textbroken:SetWidth(60)
	f.textbroken:SetHeight(16)
	f.textbroken:SetJustifyH("LEFT")
	f.textbroken:SetNonSpaceWrap(false)
	f.textbroken:ClearAllPoints()
	f.textbroken:SetPoint("LEFT", f.textperc, "RIGHT")
	f.textbroken:SetTextColor(1,1,1)
	f.textbroken:SetText("3")

	return f
end

function oRALDurability:UpdateScrollBar()
	local i,j
	local entries = table.getn(self.durability)
	FauxScrollFrame_Update(self.frames.sframe, entries, 15, 16)

	for i = 1, 15 do
		j = i + FauxScrollFrame_GetOffset(self.frames.sframe)

		if j <= entries then
			self.frames.entry[i].textname:SetText(self.durability[j][1])
			self.frames.entry[i].textperc:SetText(self.durability[j][2].."%")
			self.frames.entry[i].textbroken:SetText(self.durability[j][3])
			self.frames.entry[i]:Show()
		else
			self.frames.entry[i]:Hide()
		end
	end

end



function oRALDurability:Sort(tbl, sortBy)
	if( sortBy == 2 or sortBy == 1 ) then
		--percent, lowest to highest
		table.sort(tbl,
			function(t1, t2)
				if (t1[sortBy] == t2[sortBy] ) then
					return t1[1] > t2[1]
				else
					return t1[sortBy] < t2[sortBy]
				end
			end
		)
	else
		--broken, highest to lowest
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
end
