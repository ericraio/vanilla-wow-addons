
assert( oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRALItem")

local compost = AceLibrary:HasInstance("Compost-2.0") and AceLibrary("Compost-2.0")
local function getnewtable() return compost and compost:Acquire() or {} end
local function reclaimtable(t) if compost then compost:Reclaim(t) end end

-- DO NOT translate these, use the locale tables below
local reagents = {
	["PRIEST"] = "SacredCandle",
	["MAGE"] = "ArcanePowder",
	["DRUID"] = "WildThornroot",
	["WARLOCK"] = "SoulShard",
	["SHAMAN"] = "Ankh",
	["PALADIN"] = "SymbolofDivinity",
	["ROGUE"] = "FlashPowder",
}

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["itemleader"] = true,
	["item"] = true,
	["Options for item checks."] = true,
	["SacredCandle"] = "Sacred Candle",
	["ArcanePowder"] = "Arcane Powder",
	["WildThornroot"] = "Wild Thornroot",
	["Ankh"] = "Ankh",
	["SymbolofDivinity"] = "Symbol of Divinity",
	["FlashPowder"] = "Flash Powder",
	["SoulShard"] = "Soul Shard",
	["Checks Disabled"] = true,
	["Items"] = true,
	["Reagents"] = true,
	["Close"] = true,
	["Refresh"] = true,
	["Name"] = true,
	["Item"] = true,
	["Amount"] = true,
	["Nr"] = true,
	["Perform item check"] = true,
	["Check the raid for an item."] = true,
	["<item>"] = true,
	["Perform reagent check"] = true,
	["Check the raid for reagents."] = true,
	["check"] = true,
	["reagent"] = true,
	["Leader/Item"] = true,
} end )

L:RegisterTranslations("koKR", function() return {

	["Options for item checks."] = "아이템 확인 설정",
	["SacredCandle"] = "성스러운 양초",
	["ArcanePowder"] = "불가사의한 가루",
	["WildThornroot"] = "야생 가시",
	["Ankh"] = "십자가",
	["SymbolofDivinity"] = "신앙의 징표",
	["FlashPowder"] = "섬광 화약",
	["SoulShard"] = "영혼의 조각",
	["Checks Disabled"] = "확인 사용안함",
	["Items"] = "아이템",
	["Reagents"] = "재료",
	["Close"] = "닫기",
	["Refresh"] = "갱신",
	["Name"] = "이름",
	["Item"] = "아이템",
	["Amount"] = "수량",
	["Nr"] = "갯수",
	["Perform item check"] = "아이템 확인 실시",
	["Check the raid for an item."] = "공격대원의 아이템을 확인합니다.",
	["<item>"] = "<아이템>",
	["Perform reagent check"] = "재료 확인 실시",
	["Check the raid for reagents."] = "공격대원의 재료를 확인합니다.",
	["Leader/Item"] = "공격대장/아이템",
} end )

L:RegisterTranslations("zhCN", function() return {
	["itemleader"] = "itemleader",
	["item"] = "物品",
	["Options for item checks."] = "物品检查选项",
	["SacredCandle"] = "神圣蜡烛",
	["ArcanePowder"] = "魔粉",
	["WildThornroot"] = "野生棘根草",
	["Ankh"] = "十字章",
	["SymbolofDivinity"] = "神圣符印",
	["FlashPowder"] = "闪光粉",
	["SoulShard"] = "灵魂碎片",
	["Checks Disabled"] = "禁止检查",
	["Items"] = "物品",
	["Reagents"] = "施法材料",
	["Close"] = "关闭",
	["Refresh"] = "刷新",
	["Name"] = "姓名",
	["Item"] = "物品",
	["Amount"] = "数量",
	["Nr"] = "数量",
	["Perform item check"] = "进行物品检查",
	["Check the raid for an item."] = "对团队进行物品检查",
	["<item>"] = "<物品>",
	["Perform reagent check"] = "进行施法材料检查",
	["Check the raid for reagents."] = "对团队进行施法材料检查",
	["check"] = "检查",
	["reagent"] = "施法材料",
	["Leader/Item"] = "Leader/Item",
} end )

L:RegisterTranslations("zhTW", function() return {
	["itemleader"] = "itemleader",
	["item"] = "物品",
	["Options for item checks."] = "物品檢查選項",
	["SacredCandle"] = "神聖蠟燭",
	["ArcanePowder"] = "魔粉",
	["WildThornroot"] = "野生棘根草",
	["Ankh"] = "十字章",
	["SymbolofDivinity"] = "神聖符印",
	["FlashPowder"] = "閃光粉",
	["SoulShard"] = "靈魂碎片",
	["Checks Disabled"] = "檢查已停用",
	["Items"] = "物品",
	["Reagents"] = "施法材料",
	["Close"] = "關閉",
	["Refresh"] = "更新",
	["Name"] = "姓名",
	["Item"] = "物品",
	["Amount"] = "數量",
	["Nr"] = "數量",
	["Perform item check"] = "進行物品檢查",
	["Check the raid for an item."] = "對團隊進行物品檢查",
	["<item>"] = "<物品>",
	["Perform reagent check"] = "進行施法材料檢查",
	["Check the raid for reagents."] = "對團隊進行施法材料檢查",
	["check"] = "檢查",
	["reagent"] = "施法材料",
	["Leader/Item"] = "Leader/Item",
} end )

L:RegisterTranslations("deDE", function() return {
	["SacredCandle"] = "Hochheilige Kerze",
	["ArcanePowder"] = "Arkanes Pulver",
	["WildThornroot"] = "Wilder Dornwurz",
	["Ankh"] = "Ankh",
	["SymbolofDivinity"] = "Symbol der Offenbarung",
	["FlashPowder"] = "Blitzstrahlpulver",
	["SoulShard"] = "Seelensplitter",
} end )

L:RegisterTranslations("frFR", function() return {
	--["itemleader"] = true,
	--["item"] = true,
	["Options for item checks."] = "Options concernant les v\195\169rifications des objets.",
	["SacredCandle"] = "Bougie sacr\195\169e",
	["ArcanePowder"] = "Poudre des arcanes",
	["WildThornroot"] = "Ronceterre sauvage",
	["Ankh"] = "Ankh",
	["SymbolofDivinity"] = "Symbole de divinit\195\169",
	["FlashPowder"] = "Poudre aveuglante",
	["SoulShard"] = "Fragment d'\195\162me",
	["Checks Disabled"] = "V\195\169rifications d\195\169sactiv\195\169es.",
	["Items"] = "Objets",
	["Reagents"] = "Composants",
	["Close"] = "Fermer",
	["Refresh"] = "Rafra\195\174chir",
	["Name"] = "Nom",
	["Item"] = "Objet",
	["Amount"] = "Quantit\195\169",
	["Nr"] = "N\194\176",
	["Perform item check"] = "V\195\169rifier un objet",
	["Check the raid for an item."] = "V\195\169rifie la disponibilit\195\169 d'un objet dans le raid.",
	["<item>"] = "<objet>",
	["Perform reagent check"] = "V\195\169rifier les composants",
	["Check the raid for reagents."] = "V\195\169rifie les composants du raid.",
	--["check"] = true,
	--["reagent"] = true,
	["Leader/Item"] = "Chef/Objet",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

oRALItem = oRA:NewModule(L["itemleader"])
oRALItem.defaults = {
}
oRALItem.leader = true
oRALItem.name = L["Leader/Item"]
oRALItem.consoleCmd = L["item"]
oRALItem.consoleOptions = {
	type = "group",
	desc = L["Options for item checks."],
	name = L["Item"],
	args = {
		[L["check"]] = {
			type="text", name = L["Perform item check"],
			desc = L["Check the raid for an item."],
			get = false,
			set = function(v)
					oRALItem:PerformItemCheck(v)
				end,
			validate = function(v)
					return string.find(v, "(.+)")
				end,
			usage = L["<item>"],
			disabled = function() return not oRA:IsModuleActive(oRALItem) or not oRALItem:IsValidRequest() end,
		},
		[L["reagent"]] = {
			type="execute", name = L["Perform reagent check"],
			desc = L["Check the raid for reagents."],
			func = function()
					oRALItem:PerformReagentCheck()
				end,
			disabled = function() return not oRA:IsModuleActive(oRALItem) or not oRALItem:IsValidRequest() end,
		},
		
	}
}

------------------------------
--      Initialization      --
------------------------------

function oRALItem:OnEnable()
	self.items = getnewtable()
	self.sorting = getnewtable()

	self.sorting[1] = L["Name"]
	self.sorting[2] = L["Item"]
	self.sorting[3] = L["Amount"]

	self:SetupFrames()
	self:RegisterCheck("ITM", "oRA_ItemResponse")
	self:RegisterCheck("REA", "oRA_ReagentResponse") 

	self:RegisterShorthand("raitem", function(item) self:PerformItemCheck(item) end )
	self:RegisterShorthand("rareg", function() self:PerformReagentCheck() end )
end

function oRALItem:OnDisable()
	self:UnregisterAllEvents()

	self:UnregisterCheck("ITM")
	self:UnregisterCheck("REA")

	self:UnregisterShorthand("raitem")
	self:UnregisterShorthand("rareg")

	reclaimtable( self.items )
	self.items = nil
	reclaimtable( self.sorting )
	self.sorting = nil
end
	

function oRALItem:oRA_ItemResponse( msg, author)
	if not self:IsValidRequest(author, true) then return end
	msg = self:CleanMessage(msg)
	local _,_,numitems,itemname,requestby = string.find(msg, "^ITM ([-%d]+) (.+) ([^%s]+)$")
	if numitems and itemname and requestby and requestby == UnitName("player") then
		numitems = tonumber(numitems)
		if numitems == -1 then
			self:AddPlayer( author, L["Checks Disabled"], 0 )
		else
			self:AddPlayer( author, itemname, numitems )
		end
		self:UpdateScrollBar()
	end

end

function oRALItem:oRA_ReagentResponse( msg, author)
	msg = self:CleanMessage(msg)
	local _,_,numitems,requestby = string.find(msg, "^REA ([^%s]+) ([^%s]+)$")
	if numitems and requestby and requestby == UnitName("player") then
		numitems = tonumber(numitems)
		for i = 1, GetNumRaidMembers(), 1 do
			local rostername, _, _, _, _, _, _, _, _ = GetRaidRosterInfo(i)
			if rostername==author then
				if UnitClass("raid"..i) then
					local _,class = UnitClass("raid"..i)
					if reagents[class] then
						self:AddPlayer( author, L[reagents[class]], numitems )
						self:UpdateScrollBar()
					end
				end
			end
		end

	end
end
	
---------------------------
--   Utility Functions   --
---------------------------

function oRALItem:AddPlayer( nick, item, amount )
	local update, i
	for i=1, 40, 1 do
		if (self.items[i] and self.items[i][1] == nick) then
			update = i
		end
	end
	if (update) then
		self.items[update][3] = amount or 0
	else
		table.insert(self.items,{nick, item, amount or 0})
	end
end

function oRALItem:SetupFrames()
	local f, t, sframe, i, j

	f, _, _ = GameFontNormal:GetFont()

	self.frames = {}

	self.frames.main = CreateFrame("Frame", "oRAItemReportFrame", UIParent)
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
	self.frames.header:SetText("Durability")
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
				this.owner:Sort(self.items, 1)
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

	self.frames.headeritem = CreateFrame("Button", nil, self.frames.main)
	self.frames.headeritem.owner = self
	self.frames.headeritem:SetWidth(125)
	self.frames.headeritem:SetHeight(16)
	self.frames.headeritem:SetPoint("LEFT", self.frames.headername, "RIGHT")
	self.frames.headeritem:SetScript("OnClick",
			function()
				this.owner:Sort(self.items, 2)
				this.owner:UpdateScrollBar()
			end)

	self.frames.headeritemhigh = self.frames.headeritem:CreateTexture(nil, "BORDER")
	self.frames.headeritemhigh:SetWidth(125)
	self.frames.headeritemhigh:SetHeight(16)
	self.frames.headeritemhigh:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	self.frames.headeritemhigh:SetAllPoints(self.frames.headeritem)
	self.frames.headeritemhigh:SetBlendMode("ADD")
	self.frames.headeritemhigh:SetGradientAlpha("VERTICAL", .1, .08, 0, 0, .2, .16, 0, 1)
	self.frames.headeritem:SetHighlightTexture(self.frames.headeritemhigh)


	self.frames.headeritemtext = self.frames.main:CreateFontString(nil,"OVERLAY")
	self.frames.headeritemtext:SetFont(f, 14)
	self.frames.headeritemtext:SetWidth(125)
	self.frames.headeritemtext:SetText(L["Item"])
	self.frames.headeritemtext:SetTextColor(1, .8, 0)
	self.frames.headeritemtext:ClearAllPoints()
	self.frames.headeritemtext:SetJustifyH("LEFT")
	self.frames.headeritemtext:SetAllPoints(self.frames.headeritem)

	self.frames.headeramount = CreateFrame("Button", nil, self.frames.main)
	self.frames.headeramount.owner = self
	self.frames.headeramount:SetWidth(30)
	self.frames.headeramount:SetHeight(16)
	self.frames.headeramount:SetPoint("LEFT", self.frames.headeritem, "RIGHT")
	self.frames.headeramount:SetScript("OnClick",
			function()
				this.owner:Sort(self.items, 3)
				this.owner:UpdateScrollBar()
			end)

	self.frames.headeramounthigh = self.frames.headeramount:CreateTexture(nil, "BORDER")
	self.frames.headeramounthigh:SetWidth(30)
	self.frames.headeramounthigh:SetHeight(16)
	self.frames.headeramounthigh:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	self.frames.headeramounthigh:SetAllPoints(self.frames.headeramount)
	self.frames.headeramounthigh:SetBlendMode("ADD")
	self.frames.headeramounthigh:SetGradientAlpha("VERTICAL", .1, .08, 0, 0, .2, .16, 0, 1)
	self.frames.headeramount:SetHighlightTexture(self.frames.headeramounthigh)


	self.frames.headeramounttext = self.frames.main:CreateFontString(nil,"OVERLAY")
	self.frames.headeramounttext.owner = self
	self.frames.headeramounttext:SetFont(f, 14)
	self.frames.headeramounttext:SetWidth(30)
	self.frames.headeramounttext:SetText(L["Nr"])
	self.frames.headeramounttext:SetTextColor(1, .8, 0)
	self.frames.headeramounttext:ClearAllPoints()
	self.frames.headeramounttext:SetJustifyH("LEFT")
	self.frames.headeramounttext:SetAllPoints(self.frames.headeramount)




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
				this.owner:PerformItemCheck()
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


	self.frames.sframe = CreateFrame("ScrollFrame", "oRAItemScrollFrame", self.frames.main, "FauxScrollFrameTemplate")
	self.frames.sframe.owner = self
	self.frames.sframe:SetWidth(285)
	self.frames.sframe:SetHeight(240)
	self.frames.sframe:SetPoint("TOPLEFT", self.frames.main, "TOPLEFT", 5, -55)

	self.frames.sframe:SetScript("OnVerticalScroll",
			function()
				FauxScrollFrame_OnVerticalScroll(16, function() this.owner:UpdateScrollBar() end)
			end )

end

function oRALItem:ScrollEntryFrame()
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

	f.textitem = f:CreateFontString(nil,"ARTWORK")
	f.textitem:SetFontObject(GameFontHighlight)
	f.textitem:SetWidth(125)
	f.textitem:SetHeight(16)
	f.textitem:SetJustifyH("LEFT")
	f.textitem:SetNonSpaceWrap(false)
	f.textitem:ClearAllPoints()
	f.textitem:SetPoint("LEFT", f.textname, "RIGHT")
	f.textitem:SetTextColor(1,1,1)
	f.textitem:SetText("125")

	f.textamount = f:CreateFontString(nil,"ARTWORK")
	f.textamount:SetFontObject(GameFontHighlight)
	f.textamount:SetWidth(30)
	f.textamount:SetHeight(16)
	f.textamount:SetJustifyH("RIGHT")
	f.textamount:SetNonSpaceWrap(false)
	f.textamount:ClearAllPoints()
	f.textamount:SetPoint("LEFT", f.textitem, "RIGHT")
	f.textamount:SetTextColor(1,1,1)
	f.textamount:SetText("3")

	return f
end

function oRALItem:UpdateScrollBar()
	local i,j
	local entries = table.getn(self.items)
	FauxScrollFrame_Update(self.frames.sframe, entries, 15, 16)

	for i = 1, 15 do
		j = i + FauxScrollFrame_GetOffset(self.frames.sframe)

		if j <= entries then
			self.frames.entry[i].textname:SetText(self.items[j][1])
			self.frames.entry[i].textitem:SetText(self.items[j][2])
			self.frames.entry[i].textamount:SetText(self.items[j][3])
			self.frames.entry[i]:Show()
		else
			self.frames.entry[i]:Hide()
		end
	end
end

--------------------------
--   Command Handlers   --
--------------------------

function oRALItem:PerformItemCheck( item )
	if not self:IsPromoted() then return end
	local _, _, linkName = string.find(item, "%[(.+)%]")
	if ( linkName ) then
		item = linkName
	end
	self.item = item

	reclaimtable(self.items)
	self.items = nil
	self.items = getnewtable()

	self:SendMessage( "ITMC "..item )

	self.frames.header:SetText(L["Items"])
	self.frames.leftbutton:SetScript("OnClick",
			function()
				this.owner:PerformItemCheck( self.item )
			end)
	local i
	for i=1, 40 do
		if UnitExists("raid" .. i) then
			self:AddPlayer(UnitName("raid" .. i), item)
		end
	end

	self.frames.main:Show()
	self:UpdateScrollBar()
end

function oRALItem:PerformReagentCheck()
	if not self:IsPromoted() then return end

	reclaimtable(self.items)
	self.items = nil
	self.items = getnewtable()

	self:SendMessage( "REAC" )
	self.frames.header:SetText(L["Reagents"])
	self.frames.leftbutton:SetScript("OnClick",
			function()
				this.owner:PerformReagentCheck()
			end)
	self.frames.main:Show()
	self:UpdateScrollBar()
end


function oRALItem:Sort( tbl, sortBy )
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

