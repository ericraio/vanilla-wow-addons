local module = ArcHUD:NewModule("DruidMana")
module.unit = "player"
module.defaults = {
	Enabled = false,
	Outline = true,
	ShowText = true,
	ShowPerc = true,
	Side = 2,
	Level = 1,
}
module.options = {
	{name = "ShowText", text = "SHOWTEXT", tooltip = "SHOWTEXT"},
	{name = "ShowPerc", text = "SHOWPERC", tooltip = "SHOWPERC"},
	attach = true,
}
module.localized = true

function module:Initialize()
	-- Setup the frame we need
	self.f = self:CreateRing(true, ArcHUDFrame)
	self.f:SetAlpha(0)

	self.MPText = self:CreateFontString(self.f, "BACKGROUND", {150, 13}, 12, "LEFT", {0.0, 1.0, 1.0}, {"TOPLEFT", ArcHUDFrameCombo, "TOPRIGHT", 0, 14})
	self.MPPerc = self:CreateFontString(self.f, "BACKGROUND", {70, 12}, 10, "LEFT", {1.0, 1.0, 1.0}, {"TOPLEFT", self.parent:GetModule("Mana").MPPerc, "TOPRIGHT", 0, -1})

	-- Override Update timer
	self:RegisterMetro(self.name .. "Update", self.UpdateAlpha, 0.05, self)

	-- Add timer for DruidBar
	self:RegisterMetro(self.name .. "DruidBarUpdate", self.DruidBarUpdate, 0.5, self)
end

function module:Update()
	if(self.db.profile.ShowText) then
		self.MPText:Show()
	else
		self.MPText:Hide()
	end

	if(self.db.profile.ShowPerc) then
		self.MPPerc:Show()
	else
		self.MPPerc:Hide()
	end

	if(self.db.profile.Outline) then
		self.f.BG:Show()
	else
		self.f.BG:Hide()
	end

	-- Clear all points for the ring
	self.f:ClearAllPoints()
	self.f:SetValue(0)
	if(self.db.profile.Side == 1) then
		-- Attach to left side
		self.f:SetPoint("TOPLEFT", self.parent:GetModule("Anchors").Left, "TOPLEFT", self.db.profile.Level * -15, 0)
		self.f.BG:SetReversed(false)
		self.f:SetReversed(false)
	else
		-- Attach to right side
		self.f:SetPoint("TOPRIGHT", self.parent:GetModule("Anchors").Right, "TOPRIGHT", self.db.profile.Level * 15, 0)
		self.f.BG:SetReversed(true)
		self.f:SetReversed(true)
	end
	self.f.BG:SetAngle(180)
end

function module:Enable()
	self.f:UpdateColor({r=0.0, g=0.0, b=1.0})

	-- Don't go further if player is not a druid
	local _, class = UnitClass(self.unit)
	if(class ~= "DRUID") then return end

	-- Register the events we will use
	self:RegisterEvent("UNIT_DISPLAYPOWER")

	-- Activate the timers
	self:StartMetro(self.name .. "Alpha")
	self:StartMetro(self.name .. "Fade")
	self:StartMetro(self.name .. "Update")

	-- Check if we have any druid mana addons loaded
	if(DruidBarKey) then
		-- We got DruidBar
		self:StartMetro(self.name .. "DruidBarUpdate")

		self.gotAddon = true
	elseif(SoleManax) then
		-- We got SoleManax
		SoleManax:AddUser(self.UpdateMana, true, self)
		--self:UpdateMana(SoleManax:GetPlayerMana())

		self.gotAddon = true
	end

	self.f:Show()
end

function module:Disable()
	if(SoleManax) then
		SoleManax:DelUser(self.UpdateMana)
	end
end

function module:UpdateAlpha()
	if(self.doUpdates) then
		if(self.f.startValue < self.f.maxValue and ArcHUD.PlayerIsInCombat) then
			self.f:SetRingAlpha(ArcHUD.db.profile.FadeIC)
		elseif(self.f.startValue < self.f.maxValue and not ArcHUD.PlayerIsInCombat) then
			self.f:SetRingAlpha(ArcHUD.db.profile.FadeOOC)
		else
			self.f:SetRingAlpha(0)
		end
	else
		self.f:SetRingAlpha(0)
	end
end

function module:DruidBarUpdate()
	self:UpdateMana(DruidBarKey.keepthemana, DruidBarKey.maxmana)
end

function module:UpdateMana(curMana, maxMana)
	if(self.doUpdates) then
		self.MPText:SetText(floor(curMana).."/"..floor(maxMana))
		self.MPPerc:SetText(floor((curMana/maxMana)*100).."%")
		self.f:SetMax(maxMana)
		self.f:SetValue(curMana)
	end
end

function module:UNIT_DISPLAYPOWER()
	if(arg1 ~= self.unit) then return end
	if(UnitPowerType(self.unit) == 1 or UnitPowerType(self.unit) == 3 and not self.doUpdates) then
		--Bear or Cat form
		self.doUpdates = true
	elseif(UnitPowerType(self.unit) == 0 and self.doUpdates) then
		--player/aqua/travel
		self.doUpdates = false
	end
end
