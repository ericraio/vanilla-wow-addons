local module = ArcHUD:NewModule("Casting")
module.unit = "player"
module.defaults = {
	Enabled = true,
	Outline = true,
	ShowSpell = true,
	ShowTime = true,
	Side = 2,
	Level = -1,
}
module.options = {
	{name = "ShowSpell", text = "SHOWSPELL", tooltip = "SHOWSPELL"},
	{name = "ShowTime", text = "SHOWTIME", tooltip = "SHOWTIME"},
	attach = true,
}
module.localized = true
module.disableEvents = {
	{frame = "CastingBarFrame", hide = TRUE, events = {"SPELLCAST_START", "SPELLCAST_STOP", "SPELLCAST_DELAYED",
														"SPELLCAST_FAILED", "SPELLCAST_INTERRUPTED",
														"SPELLCAST_CHANNEL_START", "SPELLCAST_CHANNEL_UPDATE",
														"SPELLCAST_CHANNEL_STOP"}},
}

function module:Initialize()
	-- Setup the frame we need
	self.f = self:CreateRing(true, ArcHUDFrame)
	self.f:SetAlpha(0)

	self.Text = self:CreateFontString(self.f, "BACKGROUND", {175, 14}, 12, "LEFT", {1.0, 1.0, 1.0}, {"TOP", "ArcHUDFrameCombo", "BOTTOM", -28, 0})
	self.Time = self:CreateFontString(self.f, "BACKGROUND", {40, 14}, 12, "RIGHT", {1.0, 1.0, 1.0}, {"TOPLEFT", self.Text, "TOPRIGHT", 0, 0})

	-- Register timers
	self:RegisterMetro(self.name .. "Taxi", self.Taxi, 0.05, self)
	self:RegisterMetro(self.name .. "Casting", self.Casting, 0.01, self)
end

function module:Update()
	if(self.db.profile.ShowSpell) then
		self.Text:Show()
	else
		self.Text:Hide()
	end

	if(self.db.profile.ShowTime) then
		self.Time:Show()
	else
		self.Time:Hide()
	end

	if(self.db.profile.Outline) then
		self.f.BG:Show()
	else
		self.f.BG:Hide()
	end

	-- Clear all points for the ring
	self.f:ClearAllPoints()
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
	self.OnTaxi = nil
	self.flying = nil
	self.f.casting = 0
	self.channeling = 0
	self.spellstart = GetTime()
	self.f.fadeIn = 0.25
	self.f.fadeOut = 2

	self.f.dirty = true

	-- Register the events we will use
	self:RegisterEvent("SPELLCAST_START")
	self:RegisterEvent("SPELLCAST_DELAYED")
	self:RegisterEvent("SPELLCAST_CHANNEL_START")
	self:RegisterEvent("SPELLCAST_CHANNEL_UPDATE")

	self:RegisterEvent("SPELLCAST_STOP", 			"SpellcastStop")
	self:RegisterEvent("SPELLCAST_FAILED", 			"SpellcastStop")
	self:RegisterEvent("SPELLCAST_INTERRUPTED", 	"SpellcastStop")
	self:RegisterEvent("SPELLCAST_CHANNEL_STOP", 	"SpellcastStop")

	-- Do hooks for FlightMap
	self:Debug(2, "Hooking TakeTaxiNode")
	self:Hook("TakeTaxiNode", "TakeTaxiNode")

	-- Activate the timers
	self:StartMetro(self.name .. "Taxi")
	self:StartMetro(self.name .. "Casting")
	self:StartMetro(self.name .. "Alpha")
	self:StartMetro(self.name .. "Fade")

	self.f:Show()
end

function module:Disable()
	if (FlightMapFrame) then
		if (self.FlightMapX and self.FlightMapY) then
			FlightMapTimesFrame:ClearAllPoints()
			FlightMapTimesFrame:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", self.FlightMapX, self.FlightMapY )
		end
	end
end

function module:Casting()
	if ( self.f.casting == nil ) then
		self.f.casting = 0 end
	if ( self.channeling == nil ) then
		self.channeling = 0 end
	if ( self.spellstart == nil ) then
		self.spellstart = GetTime() end

	if ( self.f.casting == 1) then
		local status = (GetTime() - self.spellstart)*1000
		local time_remaining = self.f.maxValue - status

		if ( self.channeling == 1) then
			status = time_remaining
		end

		if ( status > self.f.maxValue ) then
			status = self.f.maxValue
		end

		self.f:SetValue(status)

		if ( time_remaining < 0 ) then
			time_remaining = 0
		end

		local texttime = ""
		if((time_remaining/1000) > 60) then
			local minutes = math.floor(time_remaining/60000)
			local seconds = math.floor(((time_remaining/60000) - minutes) * 60)
			if(seconds < 10) then
				texttime = minutes..":0"..seconds
			else
				texttime = minutes..":"..seconds
			end
		else
			local intlength = string.len(string.format("%u",time_remaining/1000))
			texttime = strsub(string.format("%f",time_remaining/1000),1,intlength+2)
		end
		self.Time:SetText(texttime)
	end
end

function module:TakeTaxiNode(id)
	self.hooks["TakeTaxiNode"].orig(id)

	self:Debug(2, "TakeTaxiNode called")
	if (FlightMapTimesFrame) then
		self:Debug(2, "FlightMapTimesFrame exists")
		if (FlightMapTimesFrame:IsVisible()) then
			self:Debug(2, "FlightMapTimesFrame is visible")
			-- grab all the values for this casting bar
			local intDuration = nil

			if (FlightMapTimesFrame.endTime ~= nil) then
				intDuration = (FlightMapTimesFrame.endTime - FlightMapTimesFrame.startTime) * 1000
			end

			-- Set up casting bar for flight
			self.OnTaxi = true
			if(intDuration == 0) then
				self.Text:SetText(FlightMapTimesFrame.endPoint.. " - Timing")
				self.taxiDur = 1
			else
				self.Text:SetText(FlightMapTimesFrame.endPoint)
				self.taxiDur = intDuration
				self.channeling = 1
				self.f.casting = 1
				self.spellstart = GetTime()
			end


			if(not self.FlightMapX) then
				self:Debug(2, "Hide the FlightMapTimesFrame frame")
				-- store the flight map position
				self.FlightMapX = FlightMapTimesFrame:GetLeft()
				self.FlightMapY = FlightMapTimesFrame:GetBottom()

				-- now move the frame off the screen
				FlightMapTimesFrame:ClearAllPoints()
				FlightMapTimesFrame:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", -2000, 2000 )
			end
		end
	end
end

function module:Taxi()
	if(self.OnTaxi) then
		if(not self.flying) then
			if(UnitOnTaxi(self.unit)) then
				self.flying = true
				self.f:SetMax(self.taxiDur)
				self.f:SetValue(self.taxiDur)
				self.taxiDur = nil
				self.f:UpdateColor({["r"] = 0.3, ["g"] = 0.3, ["b"] = 1.0})
				if(ArcHUD.db.profile.FadeIC > ArcHUD.db.profile.FadeOOC) then
					self.f:SetRingAlpha(ArcHUD.db.profile.FadeIC)
				else
					self.f:SetRingAlpha(ArcHUD.db.profile.FadeOOC)
				end
			end
			return
		end

		-- are we on a taxi?
		-- Did we just get off?
		if (not UnitOnTaxi(self.unit)) then
			self.flying = nil
			self.OnTaxi = nil
			self.channeling = 0
			self.f:SetRingAlpha(0)
			self.f:SetValue(0)
			self.f.casting = 0
			self.Text:SetText("")
			self.Time:SetText("")
		end
	end
end

function module:SPELLCAST_START()
	self.f:UpdateColor({["r"] = 1.0, ["g"] = 0.7, ["b"] = 0})
	self.Text:SetText(arg1)
	self.startValue = 0
	self.f:SetMax(arg2)
	self.f.casting = 1
	self.channeling = 0
	self.spellstart = GetTime()
	self.stopSet = false
	if(ArcHUD.db.profile.FadeIC > ArcHUD.db.profile.FadeOOC) then
		self.f:SetRingAlpha(ArcHUD.db.profile.FadeIC)
	else
		self.f:SetRingAlpha(ArcHUD.db.profile.FadeOOC)
	end
end

function module:SPELLCAST_CHANNEL_START()
	self.f:UpdateColor({["r"] = 0.3, ["g"] = 0.3, ["b"] = 1.0})
	self.Text:SetText(arg2)
	self.startValue = 0
	self.f:SetMax(arg1)
	self.f:SetValue(arg1)
	self.channeling = 1
	self.f.casting = 1
	self.spellstart = GetTime()
	if(ArcHUD.db.profile.FadeIC > ArcHUD.db.profile.FadeOOC) then
		self.f:SetRingAlpha(ArcHUD.db.profile.FadeIC)
	else
		self.f:SetRingAlpha(ArcHUD.db.profile.FadeOOC)
	end
end

function module:SPELLCAST_CHANNEL_UPDATE()
	self.f:SetValue(self.f.maxValue-arg1)
	self.spellstart = GetTime() - (self.f.endValue/1000)
end

function module:SPELLCAST_DELAYED()
	self.f:SetValue(self.f.startValue - arg1)
	self.spellstart = self.spellstart + (arg1/1000)
end

function module:SpellcastStop()
	if(self.channeling == nil or event == "SPELLCAST_CHANNEL_STOP") then
		self.channeling = 0
	end
	if(self.channeling == 0) then
		if(self.f.casting == 1) then
			self.f.casting = 0
			if(event == "SPELLCAST_CHANNEL_STOP") then
				self.Text:SetText("")
				self.f:SetValue(0)
			else
				self.f:SetValue(self.f.maxValue)
			end
			if(event == "SPELLCAST_STOP" or event == "SPELLCAST_CHANNEL_STOP") then
				self.f:UpdateColor({["r"] = 0, ["g"] = 1.0, ["b"] = 0})
			else
				self.f:UpdateColor({["r"] = 1.0, ["g"] = 0, ["b"] = 0})
				if(event == "SPELLCAST_FAILED") then
					self.Text:SetText("Failed")
				else
					self.Text:SetText("Interrupted")
				end
			end
		elseif(self.f.casting == 0 and (event == "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPTED")) then
			self.f:UpdateColor({["r"] = 1.0, ["g"] = 0, ["b"] = 0})
			if(event == "SPELLCAST_FAILED") then
				self.Text:SetText("Failed")
			else
				self.Text:SetText("Interrupted")
			end
		end
		self.waschanneling = false
		self.Time:SetText("")
		self.f:SetRingAlpha(0)
	end
end
