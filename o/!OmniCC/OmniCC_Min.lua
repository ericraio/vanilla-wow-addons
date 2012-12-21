--[[
	OmniCC_Min
		Simplified version of OmniCC
--]]

--[[
	To use this setting, you must remove the saved variables entry from the TOC file.
--]]
OmniCC = {
	min = 3, --minimum duration to show text
	font = STANDARD_TEXT_FONT, --cooldown text font
	size = 20, --cooldown text size
}

--returns the formatted time with the appropiate scale and color
local function GetFormattedTime(time)
	if (time > 86400) then
		return ( math.floor((time / 86400 + 1)) .. DAY_ONELETTER_ABBR );
	elseif (time >= 3600) then
		return ( math.floor((time / 3600 + 1)) .. HOUR_ONELETTER_ABBR );
	elseif (time >= 60) then
		return ( math.floor((time / 60 + 1)) .. MINUTE_ONELETTER_ABBR );
	elseif (time > 5) then
		return math.floor(time + 1);
	end
	return math.floor(time + 1);
end

--[[
	Constructor
--]]

local function CreateCooldownCount(cooldown, start, duration)
	cooldown.textFrame = CreateFrame("Frame", nil, cooldown:GetParent());
	cooldown.textFrame:SetAllPoints(cooldown:GetParent());
	cooldown.textFrame:SetFrameLevel(cooldown.textFrame:GetFrameLevel() + 1);
	
	cooldown.textFrame.text = cooldown.textFrame:CreateFontString(nil, "OVERLAY");
	cooldown.textFrame.text:SetFont(OmniCC.font , OmniCC.size, "OUTLINE");
	cooldown.textFrame.text:SetTextColor(1, 1, 0.2);
	cooldown.textFrame.text:SetPoint("CENTER", cooldown.textFrame, "CENTER", 0, 1);
	
	--[[
			OmniCC hides the text cooldown if the icon the button is hidden or not.
			This makes it a bit more dependent on other mods as far as their icon format goes.
			Its the only way I can think of to absolutely make sure that the text cooldown is hidden properly.
	--]]
	cooldown.textFrame.icon = 
		--standard action button icon, $parentIcon
		getglobal(cooldown:GetParent():GetName() .. "Icon") or 
		--standard item button icon,  $parentIconTexture
		getglobal(cooldown:GetParent():GetName() .. "IconTexture") or 
		--discord action button, $parent_Icon
		getglobal(cooldown:GetParent():GetName() .. "_Icon");
	
	if(cooldown.textFrame.icon) then
		cooldown.textFrame:SetScript("OnUpdate", OmniCC_OnUpdate);
	end
	
	cooldown.textFrame:Hide();
end
--[[
	OnX functions
--]]

function OmniCC_OnUpdate()
	local remain = this.duration - (GetTime() - this.start);
	if( remain >= 0 and this.icon:IsVisible() ) then
		this.text:SetText( GetFormattedTime( remain ) );
	else
		this:Hide();
	end
end

--[[
		Function Overrides
--]]
function CooldownFrame_SetTimer(this, start, duration, enable)
	if ( start > 0 and duration > 0 and enable > 0) then
		this.start = start;
		this.duration = duration;
		this.stopping = 0;
		this:SetSequence(0);
		this:Show();
		
		--show cooldown text if the duration exceeds the minimum duration to show text
		if( duration > OmniCC.min ) then
			if( not this.textFrame ) then
				CreateCooldownCount(this, start, duration);
			end
			this.textFrame.start = start;
			this.textFrame.duration = duration;
			this.textFrame:Show();
		elseif( this.textFrame ) then
			this.textFrame:Hide();
		end	
	else
		this:Hide();
	end
end