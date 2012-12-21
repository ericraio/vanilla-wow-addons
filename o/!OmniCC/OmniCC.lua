--[[
	Omni Cooldown Count
		A universal cooldown count, based on Gello's spec
--]]

--[[
	Saved Variables
		These values are reloaded from saved variables if the user already has saved settings.
		So, the settings always exist
--]]

OmniCC = {
	min = 3, --minimum duration to show text
	font = STANDARD_TEXT_FONT, --cooldown text font; ClearFont loads before OmniCC and will be used if its there.
	size = 20, --cooldown text size
	long = {r = 0.8, g = 0.8, b = 0.9}, --long duration color
	medium = {r = 1, g = 1, b = 0.4}, --medium duration color
	short = {r = 1, g = 0, b = 0}, --short duration color
	--hideModel = nil,
}

--returns the formatted time, scaling to use, color, and the time until the next update is needed
local function GetFormattedTime(time)
	--day
	if (time >= 86400) then
		return ( math.floor((time / 86400 + 0.5)) .. DAY_ONELETTER_ABBR ), 0.6, OmniCC.long.r, OmniCC.long.g, OmniCC.long.b, math.mod(time, 86400);
	--hour
	elseif (time >= 3600) then
		return ( math.floor((time / 3600 + 0.5)) .. HOUR_ONELETTER_ABBR ), 0.6, OmniCC.long.r, OmniCC.long.g, OmniCC.long.b, math.mod(time, 3600);
	--minute
	elseif (time >= 60) then
		return ( math.floor((time / 60 + 0.5)) .. MINUTE_ONELETTER_ABBR ), 0.8, OmniCC.long.r, OmniCC.long.g, OmniCC.long.b, math.mod(time, 60);
	--second, more than 5 seconds left
	elseif (time > 5) then
		return math.floor(time + 1), 1.0, OmniCC.medium.r, OmniCC.medium.g, OmniCC.medium.b, 0.2;
	end
	--[[
	Tenths of seconds left, doesn't look all that good
	if( OmniCC.useTenths and time <= 1) then
		return string.format("%.1f", time), 1.1, OmniCC.short.r, OmniCC.short.g, OmniCC.short.b, 0;
	end
	--]]
	--second, 5 or less left
	return math.floor(time + 0.5), 1.3, OmniCC.short.r, OmniCC.short.g, OmniCC.short.b, 0.1;
end

--[[
	Text cooldown constructor
		Its a seperate frame to prevent some rendering issues.
--]]
local function CreateCooldownCount(cooldown, start, duration)
	--yet another failsafe for the font
	if(not OmniCCFont) then
		CreateFont("OmniCCFont");
		if( not OmniCCFont:SetFont(OmniCC.font, OmniCC.size) ) then
			OmniCC.font = STANDARD_TEXT_FONT;
		end
	end
	
	cooldown.textFrame = CreateFrame("Frame", nil, cooldown:GetParent());
	cooldown.textFrame:SetAllPoints(cooldown:GetParent());
	cooldown.textFrame:SetFrameLevel(cooldown.textFrame:GetFrameLevel() + 1);
	
	cooldown.textFrame.text = cooldown.textFrame:CreateFontString(nil, "OVERLAY");
	cooldown.textFrame.text:SetPoint("CENTER", cooldown.textFrame, "CENTER", 0, 1);
	
	cooldown.textFrame:SetAlpha(cooldown:GetParent():GetAlpha());
	
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
	Slash Command Handler
--]]
SlashCmdList["OmniCCCOMMAND"] = function(msg)
	if(not msg or msg == "" or msg == "help" or msg == "?") then
		--print help messages
		DEFAULT_CHAT_FRAME:AddMessage("OmniCC Commands:");
		DEFAULT_CHAT_FRAME:AddMessage("/omnicc size <value> - Set font size.  24 is the default.");
		DEFAULT_CHAT_FRAME:AddMessage("/omnicc font <value> - Set the font to use.  " .. STANDARD_TEXT_FONT .. " is the default.");
		DEFAULT_CHAT_FRAME:AddMessage("/omnicc color <duration> <red> <green> <blue> - Set the color to use for cooldowns of <duration>.  Duration can be long, medium or short.");
		DEFAULT_CHAT_FRAME:AddMessage("/omnicc min <value> - Set the minimum duration (seconds) a cooldown should be to show text.  Default value of 3.");
		DEFAULT_CHAT_FRAME:AddMessage("/omnicc hidemodel - Hide the cooldown model");
		DEFAULT_CHAT_FRAME:AddMessage("/omnicc showmodel - Show the cooldown model (default behavior)");
		DEFAULT_CHAT_FRAME:AddMessage("/omnicc reset - Go back to default settings.");
	else
		local args = {};
		
		local word;
		for word in string.gfind(msg, "[^%s]+") do
			table.insert(args, word );
		end

		cmd = string.lower(args[1]);
		
		--/omnicc size <size>
		if(cmd == "size" and tonumber(args[2]) ) then
			if(tonumber(args[2]) > 0) then
				OmniCC.size = tonumber(args[2]);
			else
				DEFAULT_CHAT_FRAME:AddMessage("Invalid font size.");
			end
		--/omnicc font <font>
		elseif(cmd == "font" and args[2] ) then
			--this font is created solely for testing if the user's selection is a valid font or not.
			if(not OmniCCFont) then
				CreateFont("OmniCCFont");
			end
			
			if( OmniCCFont:SetFont(args[2], OmniCC.size) ) then
				OmniCC.font = args[2];
				DEFAULT_CHAT_FRAME:AddMessage("Set font to " .. OmniCC.font .. ".");
			else
				DEFAULT_CHAT_FRAME:AddMessage(args[2] .. " is an invalid font.  Using previous selection.");
			end
		--/omnicc min <size>
		elseif(cmd == "min" and tonumber(args[2]) ) then
			OmniCC.min  = tonumber(args[2]);
		elseif(cmd == "hidemodel") then
			OmniCC.hideModel = 1;
		elseif(cmd == "showmodel") then
			OmniCC.hideModel = nil;
		elseif(cmd == "color" and args[2] and tonumber(args[3]) and tonumber(args[4]) and tonumber(args[5]) ) then
			local index = string.lower(args[2]);
			if(index == "long" or index == "short" or index == "medium") then
				OmniCC[index] = {r = tonumber(args[3]), g = tonumber(args[4]), b = tonumber(args[5])};
			end
		elseif(cmd == "reset") then
			OmniCC = {
				min = 3, --minimum duration to show text
				font = STANDARD_TEXT_FONT, --cooldown text font
				size = 20, --cooldown text size
				long = {r = 0.8, g = 0.8, b = 0.9}, --long duration color
				medium = {r = 1, g = 1, b = 0.4}, --medium duration color
				short = {r = 1, g = 0, b = 0}, --short duration color
				--hideModel = nil,
			}
		end
	end
end
SLASH_OmniCCCOMMAND1 = "/omnicc";

--[[
	OnX functions
		It now uses a seperate OnX function, but it no longer blinks.
--]]
function OmniCC_OnUpdate()
	if( this.timeToNextUpdate <= 0 or not this.icon:IsVisible() ) then
		local remain = this.duration - (GetTime() - this.start);

		if( remain >= 0 and this.icon:IsVisible() ) then
			local time, scale, r, g, b, timeToNextUpdate = GetFormattedTime( remain );
			this.text:SetFont(OmniCC.font , OmniCC.size * scale, "OUTLINE");
			this.text:SetText( time );
			this.text:SetTextColor(r, g, b);
			this.timeToNextUpdate = timeToNextUpdate;
		else
			this:Hide();
		end
	else
		this.timeToNextUpdate = this.timeToNextUpdate - arg1;
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
		
		if(OmniCC.hideModel) then
			this:Hide();
		else
			this:Show();
		end
		
		if( duration > OmniCC.min ) then
			if( not this.textFrame ) then
				CreateCooldownCount(this, start, duration);
			end
			this.textFrame.start = start;
			this.textFrame.duration = duration;
			
			this.textFrame.timeToNextUpdate = 0;
			this.textFrame:Show();
		elseif( this.textFrame ) then
			this.textFrame:Hide();
		end	
	else
		this:Hide();
		if( this.textFrame ) then
			this.textFrame:Hide();
		end	
	end
end