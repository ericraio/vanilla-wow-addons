assert( oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRAOResurrection")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Resurrection Monitor"] = true,
	["resurrection"] = true,
	["resurrectionoptional"] = true,
	["Optional/Resurrection"] = true,
	["Options for resurrection."] = true,
	["Toggle"] = true,
	["toggle"] = true,
	["Toggle the Resurrection Monitor."] = true,
} end )

L:RegisterTranslations("koKR", function() return {

	["Resurrection Monitor"] = "부활상태 모니터",
	["Optional/Resurrection"] = "부가/부활",
	["Options for resurrection."] = "부활 모니터링 설정",
	["Toggle"] = "토글",
	["Toggle the Resurrection Monitor."] = "부활 상태 모니터를 토글합니다.",
} end )

L:RegisterTranslations("zhCN", function() return {
	["Resurrection Monitor"] = "复活监视器",
	["resurrection"] = "复活",
	["resurrectionoptional"] = "resurrectionoptional",
	["Optional/Resurrection"] = "Optional/Resurrection",
	["Options for resurrection."] = "复活选项",
	["Toggle"] = "激活",
	["toggle"] = "激活",
	["Toggle the Resurrection Monitor."] = "激活复活监视器",
} end )

L:RegisterTranslations("zhTW", function() return {
	["Resurrection Monitor"] = "復活監視器",
	["resurrection"] = "復活",
	["resurrectionoptional"] = "resurrectionoptional",
	["Optional/Resurrection"] = "可選/復活",
	["Options for resurrection."] = "復活選項",
	["Toggle"] = "顯示",
	["toggle"] = "顯示",
	["Toggle the Resurrection Monitor."] = "顯示復活監視器",
} end )

L:RegisterTranslations("frFR", function() return {
	["Resurrection Monitor"] = "Surveillance des r\195\169surrections",
	--["resurrection"] = true,
	--["resurrectionoptional"] = true,
	["Optional/Resurrection"] = "Optionnel/R\195\169surrection",
	["Options for resurrection."] = "Options concernant les r\195\169surrections.",
	["Toggle"] = "Afficher",
	--["toggle"] = true,
	["Toggle the Resurrection Monitor."] = "Affiche ou non la surveillance des r\195\169surrections.",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

oRAOResurrection = oRA:NewModule(L["resurrectionoptional"])
oRAOResurrection.defaults = {
	hidden = true,
}
oRAOResurrection.optional = true
oRAOResurrection.name = L["Optional/Resurrection"]
oRAOResurrection.consoleCmd = L["resurrection"]
oRAOResurrection.consoleOptions = {
	type = "group",
	desc = L["Options for resurrection."],
	name = L["Resurrection Monitor"],
	args = {
		[L["toggle"]] = {
			type = "toggle", name = L["Toggle"],
			desc = L["Toggle the Resurrection Monitor."],
			get = function() return not oRAOResurrection.db.profile.hidden end,
			set = function(v)
				oRAOResurrection:ToggleView()
			end,
		}
	}
}

------------------------------
--      Initialization      --
------------------------------

function oRAOResurrection:OnEnable()
	self.ressers = {}
	self.enabled = nil

	self:RegisterEvent("oRA_LeftRaid")	
	self:RegisterEvent("oRA_JoinedRaid")
end

function oRAOResurrection:OnDisable()
	self:UnregisterAllEvents()
	self:DisableMonitor()
end


------------------------
--   Event Handlers   --
------------------------

function oRAOResurrection:oRA_JoinedRaid()
	if not self.enabled then
		self.enabled = true
		self.ressers = {}
		if not self.db.profile.hidden then
			self:SetupFrames()
			self.resframe:Show()
			self:UpdateFrame()
		end
		self:RegisterCheck("RES", "oRA_ResurrectionStart")
		self:RegisterCheck("RESNO", "oRA_ResurrectionStop")
		self:RegisterCheck("CANRES", "oRA_PlayerCanResurrect")
		self:RegisterCheck("RESSED", "oRA_PlayerResurrected")
		self:RegisterCheck("NORESSED", "oRA_PlayerNotResurrected")
		self:RegisterEvent("RosterLib_RosterChanged", function() self:ScheduleEvent("oRACheckMonitor", self.CheckMonitor, 2, self) end )
	end
end

function oRAOResurrection:oRA_LeftRaid()
	self:DisableMonitor()
end

function oRAOResurrection:CheckMonitor()
	local u,v
	local update = false
	for key, val in pairs(self.ressers) do
		u = self.core.roster:GetUnitObjectFromName(key)
		v = self.core.roster:GetUnitObjectFromName(val)
		if not u or not v then
			self.ressers[key] = nil
			update = true
		end
	end
	if update and self.enabled and not self.db.profile.hidden then self:UpdateFrame() end
end

function oRAOResurrection:oRA_ResurrectionStart(msg, author)
	msg = self:CleanMessage(msg)
	local _,_,player = string.find(msg, "^RES (.+)$")
	if player and author then
		if not self.ressers then self.ressers = {} end
		self.ressers[author] = player
		self:UpdateFrame()
	end
end

function oRAOResurrection:oRA_ResurrectionStop(msg, author)
	msg = self:CleanMessage(msg)
	if not self.ressers then self.ressers = {} end
	if author and self.ressers[author] then
		self.ressers[author] = nil
		self:UpdateFrame()
	end
end

function oRAOResurrection:oRA_PlayerCanResurrect( msg, author)
	-- we do nothing with these atm.
end

function oRAOResurrection:oRA_PlayerResurrected( msg, author)
	-- we do nothing with these atm.
end

function oRAOResurrection:oRA_PlayerNotResurrected( msg, author)
	-- we do nothing with these atm.
end

-------------------------
--  Utility Functions  --
-------------------------

function oRAOResurrection:DisableMonitor()
	self.enabled = nil
	if self.resframe and self.resframe:IsVisible() then self.resframe:Hide() end
	if self:IsEventRegistered("RosterLib_RosterChanged") then self:UnregisterEvent("RosterLib_RosterChanged") end
	self:UnregisterCheck("RES")
	self:UnregisterCheck("RESNO")
	self:UnregisterCheck("CANRES")
	self:UnregisterCheck("RESSED")
	self:UnregisterCheck("NORESSED")
end

function oRAOResurrection:SavePosition()
	local f = self.resframe
	local x,y = f:GetLeft(), f:GetTop()
	local s = f:GetEffectiveScale()
		
	x,y = x*s,y*s

	self.db.profile.posx = x
	self.db.profile.posy = y		
end

function oRAOResurrection:RestorePosition()
	local x = self.db.profile.posx
	local y = self.db.profile.posy
		
	if not x or not y then return end
				
	local f = self.resframe
	local s = f:GetEffectiveScale()

	x,y = x/s,y/s

	f:ClearAllPoints()
	f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y)
end

function oRAOResurrection:SetupFrames()
	if not self.resframe then
		local resframe = CreateFrame("Frame", "oRAResurrectionFrame", UIParent)
		resframe:EnableMouse(true)
		resframe:SetMovable(true)
		resframe:RegisterForDrag("LeftButton")
		resframe:SetScript("OnDragStart", function() if IsAltKeyDown() then self["resframe"]:StartMoving() end end)
		resframe:SetScript("OnDragStop", function() self["resframe"]:StopMovingOrSizing() self:SavePosition() end)
		resframe:SetWidth(175)
		resframe:SetHeight(50)
		--resframe:SetBackdrop({
		--	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 16,
		--	edgeFile = "Interface\Tooltips\UI-Tooltip-Border", edgeSize = 16,
		--	insets = {left = 0, right = 0, top = 0, bottom = 0},
		--})
		--resframe:SetBackdropColor(0,0,0,0.5)
		--resframe:SetBackdropBorderColor(1,1,1,.5)
		resframe:Hide()
		resframe:SetPoint("CENTER", UIParent, "CENTER", 0, 0)

		local title = resframe:CreateFontString(nil, "ARTWORK")
		title:SetFontObject(GameFontNormalSmall)
		title:SetText(L["Resurrection Monitor"])
		title:SetJustifyH("CENTER")
		title:SetWidth(160)
		title:SetHeight(12)
		title:Show()
		title:ClearAllPoints()
		title:SetPoint("TOP", resframe, "TOP", 0, -5)

		local text = resframe:CreateFontString(nil, "ARTWORK")
		text:SetFontObject(GameFontHighlightSmall)
		text:SetJustifyH("CENTER")
		text:SetJustifyV("TOP")
		text:SetWidth(160)
		--text:SetHeight(25)
		text:Show()
		text:ClearAllPoints()
		text:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -5)

		self.resframe = resframe
		self.title = title
		self.text = text
		
		self:RestorePosition()
	end
end


function oRAOResurrection:UpdateFrame()
	if self.resframe and self.resframe:IsVisible() then
		local text = ""
		for key, val in pairs(self.ressers) do
			if ( strlen(text) > 0 ) then
				text = text.."\n"
			end
			text = string.format("%s %s: %s",text, key, val)
		end
		self.text:SetText(text)
		self.resframe:SetWidth(max(self.text:GetWidth()+15, 175))
		self.resframe:SetHeight(max(self.text:GetHeight()+25, 50))
	end
end

-------------------------
--  Command Handlers   --
-------------------------

function oRAOResurrection:ToggleView()
	self.db.profile.hidden = not self.db.profile.hidden
	if self.resframe and self.resframe:IsVisible() then
		self.resframe:Hide()
	end
	if self.enabled and not self.db.profile.hidden then
		if not self.resframe then self:SetupFrames() end
		self.resframe:Show()
	end
end

