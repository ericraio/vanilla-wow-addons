--[[

Bar1 = ActionButton1-12
Bar2 = MultiBarBottomLeft
Bar3 = MultiBarBottomRight
Bar4 = MultiBarRight
Bar5 = MultiBarLeft
Bar6 = ShapeshiftButton1-10
Bar7 = PetActionButton1-10
Bar8 = Bags
Bar9 = MicroButtons
Bar10 = BonusActionButton1-12

]]--

StaticPopupDialogs["BARTENDER2CONFIRM"] = { text = "Reset ALL settings?", button1 = "Yes", button2 = "No", timeout = 0, whileDead = 1, OnAccept = function() Bartender:ResetALL() end}

Bartender = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceHook-2.0", "AceDB-2.0", "AceConsole-2.0", "AceModuleCore-2.0")
Bartender:RegisterDB("BarDB")
Bartender:SetModuleMixins("AceEvent-2.0")

Bartender.version = "2.0." .. string.sub("$Revision: 11401 $", 12, -3)
Bartender.date = string.sub("$Date: 2006-09-19 22:35:24 +0300 (Tue, 19 Sep 2006) $", 8, 17)

Bartender:RegisterDefaults('profile', BT2Defaults )

local _G = getfenv(0)
local DBVersion = "Bar2DB-2"

function Bartender:OnEnable()
	self:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
	self:Hook("ActionButton_ShowGrid")
	self:Hook("ActionButton_HideGrid")
	self:Hook("MultiActionBar_ShowAllGrids")
	self:Hook("MultiActionBar_HideAllGrids")
	self:Hook("UpdateTalentButton")
	self:Hook("MainMenuBar_UpdateKeyRing")
	self:MakeFrames()
	self:OnProfileEnable()
	self:ScheduleEvent(self.EnableAllBars, 10.0, self);
	self:Print("How may I serve you?")
end

function Bartender:EnableAllBars()
	SHOW_MULTI_ACTIONBAR_1 = 1
	SHOW_MULTI_ACTIONBAR_2 = 1
	SHOW_MULTI_ACTIONBAR_3 = 1
	SHOW_MULTI_ACTIONBAR_4 = 1
	MultiActionBar_Update()
	SetActionBarToggles(1,1,1,1)
end

function Bartender:OnProfileEnable()
	self:AllowMoving()
	if not self.db.profile.Extra[DBVersion] then
		self:ResetALL()
	end
	self:SetAllParents()
	self:SetupBars()
	self:ButtonHideCheck()
	self:ButtonScaleCheck()
	self:ButtonHotKeyCheck()
	self:ButtonAlphaCheck()
	self:ButtonNoCustomPositionCheck()
	self:ButtonZoomCheck()
	self:LoadAllPositions()
	self:UPDATE_BONUS_ACTIONBAR()
	MainMenuBar:Hide()
	MultiActionBar_Update()
	self:HideNormalTexture()
end

function Bartender:AllowMoving()
	MultiBarLeft:ClearAllPoints()
	MultiBarRight:ClearAllPoints()
	MultiBarBottomLeft:ClearAllPoints()
	MultiBarBottomRight:ClearAllPoints()
	for i,v in ipairs(AllButtons) do v:ClearAllPoints() end
end

function Bartender:MakeFrames()
	for i=1,10 do
		self:CreateFrame("Bar"..i)
	end
end

function Bartender:DefaultBars()
	for i=1,10 do
		_G["Bar"..i]:ClearAllPoints()
		_G["Bar"..i]:Show()
		_G["Bar"..i]:SetScale(1)
	end
	for i=1,12 do
		_G["Bar1Button"..i]:SetAlpha(1)
		_G["Bar2Button"..i]:SetAlpha(1)
		_G["Bar3Button"..i]:SetAlpha(1)
		_G["Bar4Button"..i]:SetAlpha(1)
		_G["Bar5Button"..i]:SetAlpha(1)
		_G["Bar10Button"..i]:SetAlpha(1)
	end
	for i=1,10 do
		_G["Bar6Button"..i]:SetAlpha(1)
		_G["Bar7Button"..i]:SetAlpha(1)
	end
	for i=1,5 do
		_G["Bar8Button"..i]:SetAlpha(1)
	end
	for i=1,8 do
		_G["Bar9Button"..i]:SetAlpha(1)
	end
	Bar1:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", -5, -5)
	Bar2:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", -5, 31)
	Bar3:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", -5, 67)
	Bar4:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMRIGHT", -41, 100)
	Bar5:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMRIGHT", -77, 100)
	Bar6:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 20, 110)
	Bar7:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 20, 140)
	Bar8:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMRIGHT", -190, 30)
	Bar9:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMRIGHT", -205, -5)
	Bar10:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", -5, -5)
	self.db.profile.Extra[DBVersion] = true
end

function Bartender:SetAllParents()
	for i=1,12 do
		_G["Bar1Button"..i]:SetParent("Bar1")
		_G["Bar10Button"..i]:SetParent("Bar10")
	end
		MultiBarBottomLeft:SetParent("Bar2")
		MultiBarBottomRight:SetParent("Bar3")
		MultiBarRight:SetParent("Bar4")
		MultiBarLeft:SetParent("Bar5")
	for i=1,10 do
		_G["Bar6Button"..i]:SetParent("Bar6")
		_G["Bar7Button"..i]:SetParent("Bar7")
	end
	for i=1,5 do
		_G["Bar8Button"..i]:SetParent("Bar8")
	end
	for i=1,8 do
		_G["Bar9Button"..i]:SetParent("Bar9")
	end
	KeyRingButton:SetParent("UIParent")
end

function Bartender:SetupBars()
	for i=1,10 do
		self["SetupBar"..i](self)
	end
end

-- for bars 1-5 + 10
function Bartender:SetupActionBars(bar)
	local BarString = bar:GetName()
	local Rows = self.db.profile[BarString].Rows
	local ButtonPerRow = math.floor(12 / Rows) -- just a precaution
	local Padding = self.db.profile[BarString].Padding
	bar:SetWidth(36 * ButtonPerRow + ((ButtonPerRow - 1) * Padding) + 8)
	bar:SetHeight(36 * Rows + ((Rows - 1) * Padding) + 8)
	for i=1,Rows do
		if i > 1 then
			local FirstButton = (ButtonPerRow * (i - 1) + 1)
			_G[BarString.."Button"..FirstButton]:ClearAllPoints()
			_G[BarString.."Button"..FirstButton]:SetPoint("TOPLEFT", BarString.."Button"..(FirstButton - ButtonPerRow), "BOTTOMLEFT", 0, -Padding)
		end
		for k=(ButtonPerRow * (i - 1) + 2),(ButtonPerRow * i) do
			_G[BarString.."Button"..k]:ClearAllPoints()
			_G[BarString.."Button"..k]:SetPoint("BOTTOMLEFT", BarString.."Button"..k - 1, "BOTTOMRIGHT", Padding, 0)
		end
	end
	_G[BarString.."Button1"]:ClearAllPoints()
	_G[BarString.."Button1"]:SetPoint("TOPLEFT", BarString, "TOPLEFT", 5, -3)
	self:LoadPosition(bar)
end

function Bartender:SetupBar1()
	self:SetupActionBars(Bar1)
end

function Bartender:SetupBar2()
	self:SetupActionBars(Bar2)
end

function Bartender:SetupBar3()
	self:SetupActionBars(Bar3)
end

function Bartender:SetupBar4()
	self:SetupActionBars(Bar4)
end

function Bartender:SetupBar5()
	self:SetupActionBars(Bar5)
end

function Bartender:SetupBar6()
	local pad = self.db.profile.Bar6.Padding
	if self.db.profile.Bar6.Swap then
		Bar6:SetWidth(38)
		Bar6:SetHeight(308 + (pad * 9))
		for i=2,10 do
			_G["Bar6Button"..i]:SetPoint("BOTTOMLEFT", "Bar6Button"..i - 1, "TOPLEFT", 0, pad)
		end
	else
		Bar6:SetWidth(308 + (pad * 9))
		Bar6:SetHeight(38)
		for i=2,10 do
			_G["Bar6Button"..i]:SetPoint("BOTTOMLEFT", "Bar6Button"..i - 1, "BOTTOMRIGHT", pad, 0)
		end
	end
	Bar6Button1:SetPoint("BOTTOMLEFT", "Bar6", "BOTTOMLEFT", 5, 5)
	self:LoadPosition(Bar6)
end

function Bartender:SetupBar7()
	local pad = self.db.profile.Bar7.Padding
	if self.db.profile.Bar7.Swap then
		Bar7:SetWidth(38)
		Bar7:SetHeight(308 + (pad * 9))
		for i=2,10 do
			_G["Bar7Button"..i]:SetPoint("BOTTOMLEFT", "Bar7Button"..i - 1, "TOPLEFT", 0, pad)
		end
	else
		Bar7:SetWidth(308 + (pad * 9))
		Bar7:SetHeight(38)
		for i=2,10 do
			_G["Bar7Button"..i]:SetPoint("BOTTOMLEFT", "Bar7Button"..i - 1, "BOTTOMRIGHT", pad, 0)
		end
	end
	Bar7Button1:SetPoint("BOTTOMLEFT", "Bar7", "BOTTOMLEFT", 5, 5)
	self:LoadPosition(Bar7)
end

function Bartender:SetupBar8()
	local pad = self.db.profile.Bar8.Padding
	if self.db.profile.Bar8.Swap then
		Bar8:SetWidth(45)
		Bar8:SetHeight(193 + (pad *4))
		for i=2,5 do
			_G["Bar8Button"..i]:SetPoint("BOTTOMLEFT", "Bar8Button"..i - 1, "TOPLEFT", 0, pad)
		end
	else
		Bar8:SetWidth(193 + (pad * 4))
		Bar8:SetHeight(45)
		for i=2,5 do
			_G["Bar8Button"..i]:SetPoint("BOTTOMLEFT", "Bar8Button"..i - 1, "BOTTOMRIGHT", pad, 0)
		end
	end
	Bar8Button1:SetPoint("BOTTOMLEFT", "Bar8", "BOTTOMLEFT", 5, 5)
	self:LoadPosition(Bar8)
end

function Bartender:SetupBar9()
	local pad = self.db.profile.Bar9.Padding
	if self.db.profile.Bar9.Swap then
		Bar9:SetWidth(34)
		Bar9:SetHeight(302 + (pad * 7))
		for i=2,8 do
			_G["Bar9Button"..i]:SetPoint("BOTTOMLEFT", "Bar9Button"..i - 1, "TOPLEFT", 0, pad - 21)
		end
	else
		Bar9:SetWidth(236 + (pad * 7))
		Bar9:SetHeight(43)
		for i=2,8 do
			_G["Bar9Button"..i]:SetPoint("BOTTOMLEFT", "Bar9Button"..i - 1, "BOTTOMRIGHT", pad, 0)
		end
	end
	Bar9Button1:SetPoint("BOTTOMLEFT", "Bar9", "BOTTOMLEFT", 3, 4)
	self:LoadPosition(Bar9)
end

function Bartender:SetupBar10()
	self:SetupActionBars(Bar10)
end

function Bartender:ButtonHideCheck()
	for i=1,10 do
		if self.db.profile["Bar"..i].Hide then _G["Bar"..i]:Hide() end
	end
end

function Bartender:ButtonScaleCheck()
	for i=1,10 do
		_G["Bar"..i]:SetScale(self.db.profile["Bar"..i].Scale)
	end
end

function Bartender:ButtonHotKeyCheck()
	for i=1,12 do
		if self.db.profile.Bar1.HideHotKey then _G["Bar1Button"..i.."HK"]:Hide() end
		if self.db.profile.Bar2.HideHotKey then _G["Bar2Button"..i.."HK"]:Hide() end
		if self.db.profile.Bar3.HideHotKey then _G["Bar3Button"..i.."HK"]:Hide() end
		if self.db.profile.Bar4.HideHotKey then _G["Bar4Button"..i.."HK"]:Hide() end
		if self.db.profile.Bar5.HideHotKey then _G["Bar5Button"..i.."HK"]:Hide() end
		if self.db.profile.Bar10.HideHotKey then _G["Bar10Button"..i.."HK"]:Hide() end
	end
end

function Bartender:ButtonAlphaCheck()
	for i=1,12 do
		_G["Bar1Button"..i]:SetAlpha(self.db.profile.Bar1.Alpha)
		_G["Bar2Button"..i]:SetAlpha(self.db.profile.Bar2.Alpha)
		_G["Bar3Button"..i]:SetAlpha(self.db.profile.Bar3.Alpha)
		_G["Bar4Button"..i]:SetAlpha(self.db.profile.Bar4.Alpha)
		_G["Bar5Button"..i]:SetAlpha(self.db.profile.Bar5.Alpha)
		_G["Bar10Button"..i]:SetAlpha(self.db.profile.Bar10.Alpha)
	end
	for i=1,10 do
		_G["Bar6Button"..i]:SetAlpha(self.db.profile.Bar6.Alpha)
		_G["Bar7Button"..i]:SetAlpha(self.db.profile.Bar7.Alpha)
	end
	for i=1,5 do
		_G["Bar8Button"..i]:SetAlpha(self.db.profile.Bar8.Alpha)
	end
	for i=1,8 do
		_G["Bar9Button"..i]:SetAlpha(self.db.profile.Bar9.Alpha)
	end
end

function Bartender:ButtonNoCustomPositionCheck()
	if ((not self.db.profile.Bar1.PosX) and (not self.db.profile.Bar1.PosY)) then Bar1:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", -5, -5) end
	if ((not self.db.profile.Bar2.PosX) and (not self.db.profile.Bar2.PosY)) then Bar2:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", -5, 31) end
	if ((not self.db.profile.Bar3.PosX) and (not self.db.profile.Bar3.PosY)) then Bar3:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", -5, 67) end
	if ((not self.db.profile.Bar4.PosX) and (not self.db.profile.Bar4.PosY)) then Bar4:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMRIGHT", -41, 100) end
	if ((not self.db.profile.Bar5.PosX) and (not self.db.profile.Bar5.PosY)) then Bar5:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMRIGHT", -77, 100) end
	if ((not self.db.profile.Bar6.PosX) and (not self.db.profile.Bar6.PosY)) then Bar6:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 20, 110) end
	if ((not self.db.profile.Bar7.PosX) and (not self.db.profile.Bar7.PosY)) then Bar7:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 20, 140) end
	if ((not self.db.profile.Bar8.PosX) and (not self.db.profile.Bar8.PosY)) then Bar8:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMRIGHT", -190, 30) end
	if ((not self.db.profile.Bar9.PosX) and (not self.db.profile.Bar9.PosY)) then Bar9:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMRIGHT", -205, -5) end
	if ((not self.db.profile.Bar10.PosX) and (not self.db.profile.Bar10.PosY)) then Bar10:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", -5, -5) end
end

function Bartender:ButtonZoomCheck()
	if self.db.profile.Extra.HideBorder then
		for i,v in ipairs(AllIcons) do v:SetTexCoord(0.07,0.93,0.07,0.93) end
	else
		for i,v in ipairs(AllIcons) do v:SetTexCoord(0,1,0,1) end
	end
end

function Bartender:LoadAllPositions()
	for i=1,10 do
		if self.db.profile["Bar"..i].PosX and self.db.profile["Bar"..i].PosY then self:LoadPosition(_G["Bar"..i]) end
	end
end

function Bartender:CreateFrame(name, text)
	if not name then return end
	local frame = CreateFrame("Button", name, UIParent)
	frame:EnableMouse(false)
	frame:SetMovable(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetWidth(10)
	frame:SetHeight(10)
	frame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16, edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16, insets = {left = 5, right = 3, top = 3, bottom = 5},})
	frame:ClearAllPoints()
	frame:SetBackdropColor(0, 0, 0, 0)
	frame:SetBackdropBorderColor(0.5, 0.5, 0, 0)
	frame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0)
	frame.Text = frame:CreateFontString(nil, "ARTWORK")
	frame.Text:SetFontObject(GameFontNormal)
	frame.Text:SetText(text)
	frame.Text:Show()
	frame.Text:ClearAllPoints()
	frame.Text:SetPoint("CENTER", name, "CENTER",0,0)
end

function Bartender:SavePosition(arg1)
	if not arg1 then return end
	local frame = arg1:GetName()
	local x,y = arg1:GetLeft(), arg1:GetBottom()
	local s = arg1:GetEffectiveScale()
	x,y = x*s,y*s
	self.db.profile[frame].PosX = x
	self.db.profile[frame].PosY = y
end

function Bartender:LoadPosition(arg1)
	if not arg1 then return end
	local frame = arg1:GetName()
	local x = self.db.profile[frame].PosX
	local y = self.db.profile[frame].PosY
	if ((not x) or (not y)) then return end
	local s = arg1:GetEffectiveScale()
	x,y = x/s,y/s
	arg1:ClearAllPoints()
	arg1:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", x, y)
end

function Bartender:HideBar(arg1)
	self.db.profile[arg1:GetName()].Hide = true
	arg1:Hide()
end

function Bartender:ShowBar(arg1)
	self.db.profile[arg1:GetName()].Hide = nil
	arg1:Show()
end

function Bartender:HideBorder()
	self.db.profile.Extra.HideBorder = true
	self:ButtonZoomCheck()
end

function Bartender:ShowBorder()
	self.db.profile.Extra.HideBorder = nil
	self:ButtonZoomCheck()
end

function Bartender:SwapOff(arg1)
	self.db.profile[arg1:GetName()].Swap = false
	self["Setup"..arg1:GetName()](self)
end

function Bartender:SwapOn(arg1)
	self.db.profile[arg1:GetName()].Swap = true
	self["Setup"..arg1:GetName()](self)
end

function Bartender:Rows(arg1,arg2)
	self.db.profile[arg1:GetName()].Rows = 12 /  math.floor(12 / arg2)
	self["Setup"..arg1:GetName()](self)
end

function Bartender:ShowHK(arg1)
	self.db.profile[arg1:GetName()].HideHotKey = nil
	for i=1,12 do
		_G[arg1:GetName().."Button"..i.."HK"]:Show()
	end
end

function Bartender:HideHK(arg1)
	self.db.profile[arg1:GetName()].HideHotKey = true
	for i=1,12 do
		_G[arg1:GetName().."Button"..i.."HK"]:Hide()
	end
end

function Bartender:Scale(arg1,arg2)
	arg1:SetScale(arg2)
	self.db.profile[arg1:GetName()].Scale = arg2	
	self:LoadPosition(arg1)
end

function Bartender:Alpha(arg1,arg2)
	if self.unlock then
		self:Print("Please lock your bars first")
		return
	elseif ((arg1 == Bar1) or (arg1 == Bar2) or (arg1 == Bar3) or (arg1 == Bar4) or (arg1 == Bar5) or (arg1 == Bar10)) then
		for i=1,12 do
			_G[arg1:GetName().."Button"..i]:SetAlpha(arg2)
		end
		self.db.profile[arg1:GetName()].Alpha = arg2	
	elseif ((arg1 == Bar6) or (arg1 == Bar7)) then
		for i=1,10 do
			_G[arg1:GetName().."Button"..i]:SetAlpha(arg2)
		end
		self.db.profile[arg1:GetName()].Alpha = arg2	
	elseif arg1 == Bar8 then
		for i=1,5 do
			_G[arg1:GetName().."Button"..i]:SetAlpha(arg2)
		end
		self.db.profile[arg1:GetName()].Alpha = arg2	
	elseif arg1 == Bar9 then
		for i=1,8 do
			_G[arg1:GetName().."Button"..i]:SetAlpha(arg2)
		end
		self.db.profile[arg1:GetName()].Alpha = arg2	
	end
end

function Bartender:Padding(arg1,arg2)
	self.db.profile[arg1:GetName()].Padding = arg2
	self["Setup"..arg1:GetName()](self)
end

function Bartender:ResetPadding(arg1)
	self.db.profile[arg1:GetName()].Padding = nil
	self["Setup"..arg1:GetName()](self)
end

function Bartender:ResetScale(arg1)
	arg1:SetScale(1)
	self.db.profile[arg1:GetName()].Scale = nil
	self:LoadPosition(arg1)
end

function Bartender:ResetAlpha(arg1)
	if self.unlock then
		self:Print("Please lock your bars first")
		return
	elseif ((arg1 == Bar1) or (arg1 == Bar2) or (arg1 == Bar3) or (arg1 == Bar4) or (arg1 == Bar5) or (arg1 == Bar10)) then
		for i=1,12 do
			_G[arg1:GetName().."Button"..i]:SetAlpha(1)
		end
		self.db.profile[arg1:GetName()].Alpha = nil
	elseif ((arg1 == Bar6) or (arg1 == Bar7)) then
		for i=1,10 do
			_G[arg1:GetName().."Button"..i]:SetAlpha(1)
		end
		self.db.profile[arg1:GetName()].Alpha = nil
	elseif arg1 == Bar8 then
		for i=1,5 do
			_G[arg1:GetName().."Button"..i]:SetAlpha(1)
		end
		self.db.profile[arg1:GetName()].Alpha = nil
	elseif arg1 == Bar9 then
		for i=1,8 do
			_G[arg1:GetName().."Button"..i]:SetAlpha(1)
		end
		self.db.profile[arg1:GetName()].Alpha = nil
	end
end

function Bartender:ResetPosition(arg1)
	self.db.profile[arg1:GetName()].PosX = nil
	self.db.profile[arg1:GetName()].PosY = nil
	arg1:ClearAllPoints()
	if arg1 == Bar1 then
		Bar1:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", -5, -5)
	elseif arg1 == Bar2 then
		Bar2:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", -5, 31)
	elseif arg1 == Bar3 then
		Bar3:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", -5, 67)
	elseif arg1 == Bar4 then
		Bar4:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMRIGHT", -41, 100)
	elseif arg1 == Bar5 then
		Bar5:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMRIGHT", -77, 100)
	elseif arg1 == Bar6 then
		Bar6:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 20, 110)
	elseif arg1 == Bar7 then
		Bar7:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 20, 140)
	elseif arg1 == Bar8 then
	    Bar8:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMRIGHT", -190, 30)
	elseif arg1 == Bar9 then
	    Bar9:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMRIGHT", -205, -5)
	elseif arg1 == Bar10 then
		Bar10:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", -5, -5)
	end
end

function Bartender:ResetBar(arg1)
	if self.unlock then
		self:Print("Please lock your bars first")
		return
	else
		self.db.profile[arg1:GetName()].Scale = nil
		self.db.profile[arg1:GetName()].Padding = nil
		self.db.profile[arg1:GetName()].Swap = nil
		self.db.profile[arg1:GetName()].Hide = nil
		arg1:Show()
		arg1:SetScale(1)
		if ((arg1 == Bar1) or (arg1 == Bar2) or (arg1 == Bar3) or (arg1 == Bar4) or (arg1 == Bar5) or (arg1 == Bar10)) then
			self:ShowHK(arg1)
		end
		self:ResetAlpha(arg1)
		self:ResetPosition(arg1)
		self["Setup"..arg1:GetName()](self)
	end
end

function Bartender:ResetALL()
	self:Print("Creating new DB")
	self:ResetDB("profile")
	self:DefaultBars()
	self:SetupBars()
	self:ShowBorder()
	self:UPDATE_BONUS_ACTIONBAR()
	self:Lock()
end

function Bartender:LockButtons()
	if LOCK_ACTIONBAR == "1" then
		LOCK_ACTIONBAR = "0"
		Bartender:Print("ActionBar lock |cffffffcf[|r|cffff0000Off|cffffffcf]|r")
	else
		LOCK_ACTIONBAR = "1"
		Bartender:Print("ActionBar lock |cffffffcf[|r|cff00ff00On|cffffffcf]|r")
	end
end

function Bartender:Move()
	for i=1,10 do
		_G["Bar"..i]:EnableMouse(true)
		_G["Bar"..i]:SetScript("OnEnter", function() this:SetBackdropBorderColor(0.5, 0.5, 0, 1) end)
		_G["Bar"..i]:SetScript("OnLeave", function() this:SetBackdropBorderColor(0, 0, 0, 0) end)
		_G["Bar"..i]:SetScript("OnDragStart", function() this:StartMoving() this:SetBackdropBorderColor(0, 0, 0, 0) end)
		_G["Bar"..i]:SetScript("OnDragStop", function() this:StopMovingOrSizing() self:SavePosition(this) end)
		_G["Bar"..i]:SetBackdropColor(0, 1, 0, 0.5)
		_G["Bar"..i]:SetFrameLevel(3)
	end
	for i,v in ipairs(AllButtons) do v:SetAlpha(0.5) v:SetFrameLevel(2) end
	Bar1.Text:SetText("Bar1")
	Bar2.Text:SetText("Bar2")
	Bar3.Text:SetText("Bar3")
	Bar4.Text:SetText("Bar4")
	Bar5.Text:SetText("Bar5")
	Bar6.Text:SetText("Bar6 (Shapebar)")
	Bar7.Text:SetText("Bar7 (Petbar)")
	Bar8.Text:SetText("Bar8 (Bagbar)")
	Bar9.Text:SetText("Bar9 (Microbar)")
	Bar10.Text:SetText("Bar10 (Bonusbar)")
	self.unlock = true
	self:EnableAllBars()
end

function Bartender:Lock()
	for i=1,10 do
		_G["Bar"..i]:EnableMouse(false)
		_G["Bar"..i]:SetScript("OnEnter", function() self:DummyFunction() end)
		_G["Bar"..i]:SetScript("OnLeave", function() self:DummyFunction() end)
		_G["Bar"..i]:SetScript("OnDragStart", function() self:DummyFunction() end)
		_G["Bar"..i]:SetScript("OnDragStop", function() self:DummyFunction() end)
		_G["Bar"..i]:SetBackdropColor(0, 0, 0, 0)
		_G["Bar"..i]:SetBackdropBorderColor(0, 0, 0, 0)
		_G["Bar"..i].Text:SetText("")
		_G["Bar"..i]:SetFrameLevel(1)
	end
	for i,v in ipairs(AllButtons) do v:SetAlpha(self.db.profile.Bar8.Alpha) v:SetFrameLevel(2) end
	self.unlock = nil
end

function Bartender:DummyFunction()
end

function Bartender:ActionButton_ShowGrid(button)
	if ( not button ) then
		button = this;
	end
	button.showgrid = button.showgrid+1
	for i=1,12 do
		_G[button:GetName().."NormalTexture"]:SetVertexColor(0,0,0) 
		_G[button:GetName().."NormalTexture"]:SetAlpha(0.3)
	end
	button:Show()
end

function Bartender:ActionButton_HideGrid(button)
	if ( not button ) then
		button = this;
	end
	button.showgrid = button.showgrid-1
	if ( button.showgrid == 0 and not HasAction(ActionButton_GetPagedID(button)) ) then
		button:Hide()
		self:HideNormalTexture()
	end
end

function Bartender:MultiActionBar_ShowAllGrids()
	self.hooks["MultiActionBar_ShowAllGrids"].orig()
	for i=1,12 do
		_G["Bar1Button"..i]:Show()
		_G["Bar1Button"..i.."NT"]:SetVertexColor(0,0,0)
		_G["Bar1Button"..i.."NT"]:SetAlpha(0.3)
	end
	self:HideNormalTexture()
end

function Bartender:MultiActionBar_HideAllGrids()
		self.hooks["MultiActionBar_HideAllGrids"].orig()
		for i=1,12 do
			local buttons = _G["Bar1Button"..i]
			if ( not HasAction(ActionButton_GetPagedID(buttons)) ) then
				buttons:Hide()
			end
		end
	self:HideNormalTexture()
end

function Bartender:UpdateTalentButton()
end

function Bartender:MainMenuBar_UpdateKeyRing()
	KeyRingButton:Hide()
end

function Bartender:HideNormalTexture()
	for i,v in ipairs(AllNormalTextures) do v:SetAlpha(0) end
end

function Bartender:UPDATE_BONUS_ACTIONBAR()
	if self.db.profile.Bar10.NoSwap then 
		Bar10:Hide()
		Bar1:Show()
		CURRENT_ACTIONBAR_PAGE = 1
		ChangeActionBarPage()
		BonusActionBarFrame:Hide()
		return
	else
		local x = GetBonusBarOffset()
		if x == 3 then
			Bar1:Hide()
			if not self.db.profile.Bar10.Hide then
				Bar10:Show()
				BonusActionBarFrame:Show()
			end
			CURRENT_ACTIONBAR_PAGE = 9
			ChangeActionBarPage()
		elseif x == 2 then
			Bar1:Hide()
			if not self.db.profile.Bar10.Hide then
				Bar10:Show()
				BonusActionBarFrame:Show()
			end
			CURRENT_ACTIONBAR_PAGE = 8
			ChangeActionBarPage()
		elseif x == 1 then
			Bar1:Hide()
			if not self.db.profile.Bar10.Hide then
				Bar10:Show()
				BonusActionBarFrame:Show()
			end
			CURRENT_ACTIONBAR_PAGE = 7
			ChangeActionBarPage()
		else
			Bar10:Hide()
			if not self.db.profile.Bar1.Hide then
				Bar1:Show()
				BonusActionBarFrame:Hide()
			end
			CURRENT_ACTIONBAR_PAGE = 1
			ChangeActionBarPage()
			BonusActionBarFrame:Hide()
		end
	end
end