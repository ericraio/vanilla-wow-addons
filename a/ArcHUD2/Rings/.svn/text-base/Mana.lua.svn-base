local module = ArcHUD:NewModule("Mana")
module.unit = "player"
module.defaults = {
	Enabled = true,
	Outline = true,
	ShowText = true,
	ShowPerc = true,
	Side = 2,
	Level = 0,
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

	self.MPText = self:CreateFontString(self.f, "BACKGROUND", {150, 15}, 14, "LEFT", {1.0, 1.0, 0.0}, {"TOPLEFT", ArcHUDFrameCombo, "TOPRIGHT", 0, 0})
	self.MPPerc = self:CreateFontString(self.f, "BACKGROUND", {40, 14}, 12, "LEFT", {1.0, 1.0, 1.0}, {"TOPLEFT", self.MPText, "BOTTOMLEFT", 0, 0})
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
	self.f:SetValue(UnitMana(self.unit))
	self.f.BG:SetAngle(180)
end

function module:Enable()
	self.f.pulse = false

	if(UnitIsGhost(self.unit)) then
		self.f:GhostMode(true, self.unit)
	else
		self.f:GhostMode(false, self.unit)

		if (UnitPowerType(self.unit) == 0) then
			info = { r = 0.00, g = 1.00, b = 1.00 }
		else
			info = ManaBarColor[UnitPowerType(self.unit)]
		end
		self.f:UpdateColor(ManaBarColor[UnitPowerType(self.unit)])
		self.MPText:SetVertexColor(info.r, info.g, info.b)

		self.f:SetMax(UnitManaMax(self.unit))
		self.f:SetValue(UnitMana(self.unit))
		self.MPText:SetText(UnitMana(self.unit).."/"..UnitManaMax(self.unit))
		self.MPPerc:SetText(floor((UnitMana(self.unit)/UnitManaMax(self.unit))*100).."%")
	end

	-- Register the events we will use
	self:RegisterEvent("UNIT_MANA", 		"UpdateMana")
	self:RegisterEvent("UNIT_MAXMANA", 		"UpdateMana")
	self:RegisterEvent("UNIT_ENERGY", 		"UpdateMana")
	self:RegisterEvent("UNIT_MAXENERGY", 	"UpdateMana")
	self:RegisterEvent("UNIT_RAGE", 		"UpdateMana")
	self:RegisterEvent("UNIT_MAXRAGE", 		"UpdateMana")
	self:RegisterEvent("UNIT_DISPLAYPOWER", "UpdateMana")
	self:RegisterEvent("PLAYER_ALIVE", 		"UpdateMana")
	self:RegisterEvent("PLAYER_LEVEL_UP")

	-- Activate the timers
	self:StartMetro(self.name .. "Alpha")
	self:StartMetro(self.name .. "Fade")
	self:StartMetro(self.name .. "Update")

	self.f:Show()
end

function module:PLAYER_LEVEL_UP()
	self.f:SetMax(UnitManaMax(self.unit))
end

function module:UpdateMana()
	if (arg1 == self.unit) then
		if(UnitIsGhost(self.unit) or (UnitIsDead(self.unit) and event == "PLAYER_ALIVE")) then
			self.f:GhostMode(true, self.unit)
		else
			self.f:GhostMode(false, self.unit)

			if(event == "UNIT_DISPLAYPOWER") then
				if(UnitPowerType(self.unit) == 0) then
					info = { r = 0.00, g = 1.00, b = 1.00 }
				else
					info = ManaBarColor[UnitPowerType(self.unit)]
				end
				self.f:UpdateColor(ManaBarColor[UnitPowerType(self.unit)])
				self.MPText:SetVertexColor(info.r, info.g, info.b)
			end

			self.MPText:SetText(UnitMana(self.unit).."/"..UnitManaMax(self.unit))
			self.MPPerc:SetText(floor((UnitMana(self.unit)/UnitManaMax(self.unit))*100).."%")

			self.f:SetMax(UnitManaMax(self.unit))
			self.f:SetValue(UnitMana(self.unit))
		end
	end
end
