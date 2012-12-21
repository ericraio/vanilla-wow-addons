--	ArcaneBar
--	 	Adds a second casting bar to the player frame.
--
--	By: Zlixar
--
--	Adds a second casting bar to the player frame.
--
--	Modified by Nymbia for Nymbia's Perl Unitframes

-----------------------------
-- Configuration Functions --
-----------------------------

-- Registers frame to spellcast events.

local XPerl_ArcaneBar_Colors = {
	main = {r = 1.0, g = 0.7, b = 0.0},
	channel = {r = 0.0, g = 1.0, b = 0.0},
	success = {r = 0.0, g = 1.0, b = 0.0},
	failure = {r = 1.0, g = 0.0, b = 0.0}
}

local events = {"SPELLCAST_START", "SPELLCAST_STOP", "SPELLCAST_FAILED", "SPELLCAST_INTERRUPTED",
		"SPELLCAST_DELAYED", "SPELLCAST_CHANNEL_START", "SPELLCAST_CHANNEL_UPDATE"}

function XPerl_ArcaneBar_Register(frame)
	for i,event in pairs(events) do
		frame:RegisterEvent(event)
	end
	frame:SetScript("OnUpdate", XPerl_ArcaneBar_OnUpdate)
end

-- Unregisters from spellcast events.
function XPerl_ArcaneBar_Unregister(frame)
	for i,event in pairs(events) do
		frame:UnregisterEvent(event)
	end
	frame:SetScript("OnUpdate", nil)
end

-- XPerl_ArcaneBar_EnableToggle
function XPerl_ArcaneBar_EnableToggle(value)
	if (value == 1) then
		if (XPerl_ArcaneBarFrame.Enabled ~= 1) then
			XPerl_ArcaneBar_Register(XPerl_ArcaneBarFrame)
			XPerl_ArcaneBarFrame.Enabled = 1
		end
	else
		if (XPerl_ArcaneBarFrame.Enabled == 1) then
			XPerl_ArcaneBar_Unregister(XPerl_ArcaneBarFrame)
			XPerl_ArcaneBarFrame.Enabled = 0
			XPerl_ArcaneBarFrame:Hide()
		end
	end
end

-- XPerl_ArcaneBar_OverrideToggle
function XPerl_ArcaneBar_OverrideToggle(value)
	if (value == 1) then
		if (XPerl_ArcaneBarFrame.Overrided ~= 1) then
			XPerl_ArcaneBar_Unregister(CastingBarFrame)
			XPerl_ArcaneBarFrame.Overrided = 1
		end
	else
		if (XPerl_ArcaneBarFrame.Overrided == 1) then
			XPerl_ArcaneBar_Register(CastingBarFrame)
			XPerl_ArcaneBarFrame.Overrided = 0
		end
	end
end

--------------------------------------------------
--
-- Event/Update Handlers
--
--------------------------------------------------

-- XPerl_ArcaneBar_OnEvent
function XPerl_ArcaneBar_OnEvent()
	if ( event == "SPELLCAST_START" ) then
		XPerl_ArcaneBar:SetStatusBarColor(XPerl_ArcaneBar_Colors.main.r, XPerl_ArcaneBar_Colors.main.g, XPerl_ArcaneBar_Colors.main.b, XPerlConfig.Transparency)
		XPerl_ArcaneBarSpark:Show()
		this.startTime = GetTime()
		this.maxValue = this.startTime + (arg2 / 1000)
		XPerl_ArcaneBar:SetMinMaxValues(this.startTime, this.maxValue)
		XPerl_ArcaneBar:SetValue(this.startTime)
		this:SetAlpha(0.8)
		this.holdTime = 0
		this.casting = 1
		this.fadeOut = nil
		this:Show()
		this.delaySum = 0
		if XPerlConfig.CastTime==1 then XPerl_ArcaneBar_CastTime:Show(); else XPerl_ArcaneBar_CastTime:Hide(); end
		this.mode = "casting"
	elseif ( event == "SPELLCAST_STOP" ) then
		this.delaySum = 0
		this.sign = "+"
		if (not this.casting) then
			XPerl_ArcaneBar_CastTime:Hide()
		end
		if ( not this:IsVisible() ) then
			this:Hide()
		end
		if ( this:IsShown() ) then
			XPerl_ArcaneBar:SetValue(this.maxValue)
			XPerl_ArcaneBar:SetStatusBarColor(XPerl_ArcaneBar_Colors.success.r, XPerl_ArcaneBar_Colors.success.g, XPerl_ArcaneBar_Colors.success.b, XPerlConfig.Transparency)
			XPerl_ArcaneBarSpark:Hide()
			XPerl_ArcaneBarFlash:SetAlpha(0.0)
			XPerl_ArcaneBarFlash:Show()
			this.casting = nil
			this.flash = 1
			this.fadeOut = 1

			this.mode = "flash"
		end
	elseif ( event == "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPTED" ) then
		if ( this:IsShown() ) then
			XPerl_ArcaneBar:SetValue(this.maxValue)
			XPerl_ArcaneBar:SetStatusBarColor(XPerl_ArcaneBar_Colors.failure.r, XPerl_ArcaneBar_Colors.failure.g, XPerl_ArcaneBar_Colors.failure.b, XPerlConfig.Transparency)
			XPerl_ArcaneBarSpark:Hide()
			this.casting = nil
			this.fadeOut = 1
			this.holdTime = GetTime() + CASTING_BAR_HOLD_TIME
		end
	elseif ( event == "SPELLCAST_DELAYED" ) then
		if( this:IsShown() ) then
			if arg1 then
				this.startTime = this.startTime + (arg1 / 1000)
				this.maxValue = this.maxValue + (arg1 / 1000)
				this.delaySum = this.delaySum + arg1
				XPerl_ArcaneBar:SetMinMaxValues(this.startTime, this.maxValue)
			end
		end
	elseif ( event == "SPELLCAST_CHANNEL_START" ) then
		XPerl_ArcaneBar:SetStatusBarColor(XPerl_ArcaneBar_Colors.channel.r, XPerl_ArcaneBar_Colors.channel.g, XPerl_ArcaneBar_Colors.channel.b, XPerlConfig.Transparency)
		XPerl_ArcaneBarSpark:Show()
		this.maxValue = 1
		this.startTime = GetTime()
		this.endTime = this.startTime + (arg1 / 1000)
		this.duration = arg1 / 1000
		XPerl_ArcaneBar:SetMinMaxValues(this.startTime, this.endTime)
		XPerl_ArcaneBar:SetValue(this.endTime)
		this:SetAlpha(1.0)
		this.holdTime = 0
		this.casting = nil
		this.channeling = 1
		this.fadeOut = nil
		this:Show()
		this.delaySum = 0
		if XPerlConfig.CastTime==1 then XPerl_ArcaneBar_CastTime:Show(); else XPerl_ArcaneBar_CastTime:Hide(); end

	elseif ( event == "SPELLCAST_CHANNEL_UPDATE" ) then
		if ( arg1 == 0 ) then
			this.channeling = nil
			this.delaySum = 0
			XPerl_ArcaneBar_CastTime:Hide()
		elseif ( this:IsShown() ) then
			local origDuration = this.endTime - this.startTime
			local elapsedTime = GetTime() - this.startTime
			local losttime = origDuration*1000 - elapsedTime*1000 - arg1
			this.delaySum = this.delaySum + losttime
			this.startTime = this.endTime - origDuration
			this.endTime = GetTime() + (arg1 / 1000)
			XPerl_ArcaneBar:SetMinMaxValues(this.startTime, this.endTime)

		end
	else
		this.delaySum = 0
		this.sign = "+"
		XPerl_ArcaneBar_CastTime:Hide()
	end
end

-- XPerl_ArcaneBar_OnUpdate
function XPerl_ArcaneBar_OnUpdate()
	if (not XPerl_ArcaneBar:IsShown()) then
		XPerl_ArcaneBar_CastTime:Hide()
	end
	local current_time = this.maxValue - GetTime()
	if (this.channeling) then
		current_time = this.endTime - GetTime()
	end


	local text = string.sub(math.max(current_time,0)+0.001,1,4)
	if (this.delaySum and this.delaySum ~= 0) then
		local delay = string.sub(math.max(this.delaySum/1000, 0)+0.001,1,4)

		if (this.channeling == 1) then
			this.sign = "-"
		else
			this.sign = "+"
		end
		text = "|cffcc0000"..this.sign..delay.."|r "..text
	end
	XPerl_ArcaneBar_CastTime:SetText(text)


	if ( this.casting ) then
		local status = GetTime()
		if ( status > this.maxValue ) then
			status = this.maxValue
		end
		XPerl_ArcaneBar:SetValue(status)
		XPerl_ArcaneBarFlash:Hide()
		local sparkPosition = ((status - this.startTime) / (this.maxValue - this.startTime)) * 154
		if ( sparkPosition < 0 ) then
			sparkPosition = 0
		end
		XPerl_ArcaneBarSpark:SetPoint("CENTER", "XPerl_ArcaneBar", "LEFT", sparkPosition, 0)
	elseif ( this.channeling ) then
		local time = GetTime()
		if ( time > this.endTime ) then
			time = this.endTime
		end
		if ( time == this.endTime ) then
			this.channeling = nil
			this.fadeOut = 1
			return
		end
		local barValue = this.startTime + (this.endTime - time)
		XPerl_ArcaneBar:SetValue( barValue )
		XPerl_ArcaneBarFlash:Hide()
		local sparkPosition = ((barValue - this.startTime) / (this.endTime - this.startTime)) * 154
		XPerl_ArcaneBarSpark:SetPoint("CENTER", "XPerl_ArcaneBar", "LEFT", sparkPosition, 0)
	elseif ( GetTime() < this.holdTime ) then
		return
	elseif ( this.flash ) then
		local alpha = XPerl_ArcaneBarFlash:GetAlpha() + CASTING_BAR_FLASH_STEP
		if ( alpha < 1 ) then
			XPerl_ArcaneBarFlash:SetAlpha(alpha)
		else
			this.flash = nil
		end
	elseif ( this.fadeOut ) then
		local alpha = this:GetAlpha() - CASTING_BAR_ALPHA_STEP
		if ( alpha > 0 ) then
			this:SetAlpha(alpha)
		else
			this.fadeOut = nil
			this:Hide()
		end
	end
end

-- XPerl_ArcaneBar_OnLoad
function XPerl_ArcaneBar_OnLoad()
	XPerl_ArcaneBar:SetFrameLevel(XPerl_Player_NameFrame:GetFrameLevel() + 1)
	--XPerl_Player_Name:SetFrameLevel(XPerl_Player_NameFrame:GetFrameLevel() + 2)
	XPerl_ArcaneBarFlashTex:SetTexture("Interface\\AddOns\\XPerl\\Images\\XPerl_ArcaneBarFlash")
	XPerl_ArcaneBarTex:SetTexture("Interface\\AddOns\\XPerl\\Images\\XPerl_StatusBar")
	this.casting = nil
	this.holdTime = 0
	this.Enabled = 0
	this.Overrided = 0
end

-- XPerl_ArcaneBar_Set
function XPerl_ArcaneBar_Set()
	if (XPerl_ArcaneBarFrame) then
		if (XPerlConfig.ArcaneBar == 0) then
			XPerl_ArcaneBar_EnableToggle(0)
		else
			XPerl_ArcaneBar_EnableToggle(1)
		end

		if (XPerlConfig.OldCastBar == 0) then
			XPerl_ArcaneBar_OverrideToggle(1)
		else
			XPerl_ArcaneBar_OverrideToggle(0)
		end
	end
end
