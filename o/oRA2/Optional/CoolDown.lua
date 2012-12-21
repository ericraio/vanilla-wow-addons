assert( oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRAOCoolDown")

local roster = AceLibrary("RosterLib-2.0")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["CoolDown Monitor"] = true,
	["cooldown"] = true,
	["cooldownoptional"] = true,
	["Optional/CoolDown"] = true,
	["Options for CoolDown."] = true,
	["Toggle"] = true,
	["toggle"] = true,
	["Toggle the CoolDown Monitor."] = true,
} end )

L:RegisterTranslations("koKR", function() return {
	["CoolDown Monitor"] = "재사용대기시간 모니터",
	["Optional/CoolDown"] = "부가/재사용대기시간",
	["Options for CoolDown."] = "재사용대기시간에 관한 설정.",
	["Toggle"] = "토글",
	["Toggle the CoolDown Monitor."] = "재사용대기시간 모니터 토글",
} end )

L:RegisterTranslations("zhCN", function() return {
	["CoolDown Monitor"] = "冷却监视器",
	["cooldown"] = "冷却",
	["cooldownoptional"] = "cooldownoptional",
	["Optional/CoolDown"] = "Optional/CoolDown",
	["Options for CoolDown."] = "冷却监视器的选项",
	["Toggle"] = "显示",
	["toggle"] = "显示",
	["Toggle the CoolDown Monitor."] = "显示冷却监视器",
} end )

L:RegisterTranslations("zhTW", function() return {
	["CoolDown Monitor"] = "冷卻監視器",
	["cooldown"] = "冷卻",
	["cooldownoptional"] = "cooldownoptional",
	["Optional/CoolDown"] = "可選/冷卻",
	["Options for CoolDown."] = "冷卻監視器的選項",
	["Toggle"] = "顯示",
	["toggle"] = "顯示",
	["Toggle the CoolDown Monitor."] = "顯示冷卻監視器",
} end )

L:RegisterTranslations("frFR", function() return {
	["CoolDown Monitor"] = "Surveillance des \"cooldowns\"",
	--["cooldown"] = true,
	--["cooldownoptional"] = true,
	["Optional/CoolDown"] = "Optionnel/Temps de recharge",
	["Options for CoolDown."] = "Options concernant les temps de recharge.",
	["Toggle"] = "Afficher",
	--["toggle"] = true,
	["Toggle the CoolDown Monitor."] = "Affiche ou non la surveillance des temps de recharge.",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

oRAOCoolDown = oRA:NewModule(L["cooldownoptional"], "CandyBar-2.0")
oRAOCoolDown.defaults = {
	hidden = false,
	cooldowns = {},
}
oRAOCoolDown.optional = true
oRAOCoolDown.name = L["Optional/CoolDown"]
oRAOCoolDown.consoleCmd = L["cooldown"]
oRAOCoolDown.consoleOptions = {
	type = "group",
	desc = L["Options for CoolDown."],
	name = L["CoolDown Monitor"],
	args = {
		[L["toggle"]] = {
			type = "toggle", name = L["Toggle"],
			desc = L["Toggle the CoolDown Monitor."],
			get = function() return not oRAOCoolDown.db.profile.hidden end,
			set = function(v)
					oRAOCoolDown:ToggleView()
			end,
		},
	}
}

------------------------------
--      Initialization      --
------------------------------

function oRAOCoolDown:OnEnable()
	roster:Enable()
	if not self.db.profile.cooldowns then self.db.profile.cooldowns = {} end
	self.enabled = nil

	self:RegisterEvent("oRA_LeftRaid")	
	self:RegisterEvent("oRA_JoinedRaid")
	self:RegisterEvent("oRA_BarTexture")
end

function oRAOCoolDown:OnDisable()
	self:UnregisterAllEvents()
	self:DisableMonitor()
end


------------------------
--   Event Handlers   --
------------------------

function oRAOCoolDown:oRA_JoinedRaid()
	if not self.enabled then
		self.enabled = true
		if not self.db.profile.hidden then
			self:SetupFrames()
			self.cdframe:Show()
			self:StartAllCoolDowns()
		end
		self:RegisterCheck("CD", "oRA_CoolDown")
	end
end

function oRAOCoolDown:oRA_LeftRaid()
	self:DisableMonitor()
end

function oRAOCoolDown:oRA_CoolDown(msg, author)
	msg = self:CleanMessage(msg)
	local _,_,what,length = string.find( msg, "^CD (%d+) (%d+)")
	if author and what and time then
		if not self.db.profile.cooldowns then self.db.profile.cooldowns = {} end
		self.db.profile.cooldowns[author] = time() + tonumber(length)*60
		self:StartCoolDown( author, tonumber(length)*60)
	end
end

function oRAOCoolDown:oRA_BarTexture( texture )
	for key, val in pairs( self.db.profile.cooldowns) do
		self:SetCandyBarTexture( "oRAOCoolDown "..key, self.core.bartextures[texture] )
	end
end

-------------------------
--  Utility Functions  --
-------------------------

function oRAOCoolDown:DisableMonitor()
	self.enabled = nil
	if self.cdframe and self.cdframe:IsVisible() then self.cdframe:Hide() end
	self:StopAllCoolDowns()
	self:UnregisterCheck("CD")
end

function oRAOCoolDown:SavePosition()
	local f = self.cdframe
	local x,y = f:GetLeft(), f:GetTop()
	local s = f:GetEffectiveScale()
		
	x,y = x*s,y*s

	self.db.profile.posx = x
	self.db.profile.posy = y		
end

function oRAOCoolDown:RestorePosition()
	local x = self.db.profile.posx
	local y = self.db.profile.posy
		
	if not x or not y then return end
				
	local f = self.cdframe
	local s = f:GetEffectiveScale()

	x,y = x/s,y/s

	f:ClearAllPoints()
	f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y)
end

function oRAOCoolDown:SetupFrames()
	if not self.cdframe then
		local cdframe = CreateFrame("Frame", "oRACoolDownFrame", UIParent)
		cdframe:EnableMouse(true)
		cdframe:SetMovable(true)
		cdframe:RegisterForDrag("LeftButton")
		cdframe:SetScript("OnDragStart", function() if IsAltKeyDown() then self["cdframe"]:StartMoving() end end)
		cdframe:SetScript("OnDragStop", function() self["cdframe"]:StopMovingOrSizing() self:SavePosition() end)
		cdframe:SetWidth(175)
		cdframe:SetHeight(50)
		--cdframe:SetBackdrop({
		--	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 16,
		--	edgeFile = "Interface\Tooltips\UI-Tooltip-Border", edgeSize = 16,
		--	insets = {left = 0, right = 0, top = 0, bottom = 0},
		--})
		--cdframe:SetBackdropColor(0,0,0,0.5)
		--cdframe:SetBackdropBorderColor(1,1,1,.5)
		cdframe:Hide()
		cdframe:SetPoint("CENTER", UIParent, "CENTER", 0, 100)

		local title = cdframe:CreateFontString(nil, "ARTWORK")
		title:SetFontObject(GameFontNormalSmall)
		title:SetText(L["CoolDown Monitor"])
		title:SetJustifyH("CENTER")
		title:SetWidth(160)
		title:SetHeight(12)
		title:Show()
		title:ClearAllPoints()
		title:SetPoint("TOP", cdframe, "TOP", 0, -5)

		local text = cdframe:CreateFontString(nil, "ARTWORK")
		text:SetFontObject(GameFontHighlightSmall)
		text:SetJustifyH("CENTER")
		text:SetJustifyV("TOP")
		text:SetWidth(160)
		--text:SetHeight(25)
		text:Show()
		text:ClearAllPoints()
		text:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -5)

		self.cdframe = cdframe
		self.title = title
		self.text = text
		
		self:RestorePosition()
	end
end


function oRAOCoolDown:StartAllCoolDowns()
	local t = time()
	for key, val in pairs(self.db.profile.cooldowns) do
		if t >= val then
			self.db.profile.cooldowns[key] = nil
			self:StopCoolDown( key )
		else
			self:StartCoolDown( key, val - t )
		end
	end
end

function oRAOCoolDown:StopAllCoolDowns()
	local t = time()
	for key, val in pairs(self.db.profile.cooldowns) do
		if t >= val then self.db.profile.cooldowns[key] = nil end
		self:StopCoolDown( key )
	end
end

function oRAOCoolDown:StartCoolDown( player, time )
	if not self.enabled or self.db.profile.hidden then return end
	local unit = roster:GetUnitObjectFromName( player )
	if not unit then return end
	self:RegisterCandyBarGroup("oRAOCoolDownGroup")
	self:SetCandyBarGroupPoint("oRAOCoolDownGroup", "TOP", self.text, "BOTTOM", 0, -5 )
	self:RegisterCandyBar( "oRAOCoolDown "..player, time, player, nil, unit.class)
	self:RegisterCandyBarWithGroup( "oRAOCoolDown "..player, "oRAOCoolDownGroup")
	self:SetCandyBarWidth( "oRAOCoolDown "..player, 150)
	self:SetCandyBarTexture( "oRAOCoolDown "..player, self.core.bartextures[self.core.db.profile.bartexture] )
	self:StartCandyBar( "oRAOCoolDown "..player, true)
end

function oRAOCoolDown:StopCoolDown( player )
	self:UnregisterCandyBar( "oRAOCoolDown "..player )
end


-------------------------
--  Command Handlers   --
-------------------------

function oRAOCoolDown:ToggleView()
	self.db.profile.hidden = not self.db.profile.hidden
	if self.cdframe and self.cdframe:IsVisible() then
		self:StopAllCoolDowns()
		self.cdframe:Hide()
	end
	if self.enabled and not self.db.profile.hidden then
		if not self.cdframe then self:SetupFrames() end
		self.cdframe:Show()
		self:StartAllCoolDowns()
	end
end
