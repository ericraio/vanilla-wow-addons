--[[

	BuffTimers: Mini timers for the top right buff icons
		copyright 2004 by Telo
	
	- Displays small timer text below each of the top right buff and debuff icons
	
]]

--------------------------------------------------------------------------------------------------
-- Local variables
--------------------------------------------------------------------------------------------------

-- Function hooks
local lOriginal_BuffButton_Update;
local lOriginal_BuffButton_OnUpdate;

-- Track whether we've moved the buff buttons yet or not
local lMovedButtons;

--------------------------------------------------------------------------------------------------
-- Internal functions
--------------------------------------------------------------------------------------------------

local function lSetTimeText(button, time)
	local d, h, m, s;
	local text;
	
	if( time <= 0 ) then
		text = "";
	elseif( time < 3600 ) then
		d, h, m, s = ChatFrame_TimeBreakDown(time);
		text = format("%02d:%02d", m, s);
	else
		text = "1 hr+";
	end
	
	button:SetText(text);
end

local function lGetField(name)
	local s, e, number = string.find(name, "BuffButton(%d+)");
	return getglobal("BuffTimer"..number.."Time");
end

--------------------------------------------------------------------------------------------------
-- OnFoo functions
--------------------------------------------------------------------------------------------------

function BuffTimers_OnLoad()
	-- Hook the button functions we need to override
	lOriginal_BuffButton_Update = BuffButton_Update;
	BuffButton_Update = BuffTimers_BuffButton_Update;
	lOriginal_BuffButton_OnUpdate = BuffButton_OnUpdate;
	BuffButton_OnUpdate = BuffTimers_BuffButton_OnUpdate;

	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage("Telo's BuffTimers AddOn loaded");
	end
	UIErrorsFrame:AddMessage("Telo's BuffTimers AddOn loaded", 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
end

function BuffTimers_OnShow()
	-- Move the buff buttons slightly to accomodate our timer text
	if( not lMovedButtons ) then
		local iButton;
		
		getglobal("BuffButton8"):SetPoint("TOP", "BuffButton0", "BOTTOM", 0, -11);
		for iButton = 9, 15 do
			getglobal("BuffButton"..iButton):SetPoint("RIGHT", "BuffButton"..(iButton - 1), "LEFT", -5, 0);
		end
		getglobal("BuffButton16"):SetPoint("TOP", "BuffButton8", "BOTTOM", 0, -11);
		for iButton = 17, 23 do
			getglobal("BuffButton"..iButton):SetPoint("RIGHT", "BuffButton"..(iButton - 1), "LEFT", -5, 0);
		end
	
		lMovedButtons = 1;
	end
end

function BuffTimers_BuffButton_Update()
	lOriginal_BuffButton_Update();
	
	if( this.untilCancelled ) then
		lGetField(this:GetName()):SetText("");
	end
end

function BuffTimers_BuffButton_OnUpdate()
	lOriginal_BuffButton_OnUpdate();
	
	if( BuffFrameUpdateTime <= 0 ) then
		lSetTimeText(lGetField(this:GetName()), GetPlayerBuffTimeLeft(this.buffIndex));
	end
end
