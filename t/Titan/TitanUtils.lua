-- Constants
TITAN_ARTWORK_PATH = "Interface\\AddOns\\Titan\\Artwork\\";
TITAN_THRESHOLD_EXCEPTION_COLOR = GRAY_FONT_COLOR;

-- Tables
TITAN_PANEL_NONMOVABLE_PLUGINS = {"Clock", "Volume", "UIScale", "Trans", "AutoHide", "AuxAutoHide"};

TitanPlugins = {};
TitanPluginsIndex = {};

function TitanDebug(debug_message)
	-- Default green color
	DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00" .. TITAN_DEBUG .. " " .. debug_message);
end

function TitanUtils_GetNextButtonOnBar(bar, id, side)
	local index = TitanUtils_GetCurrentIndex(TitanPanelSettings.Buttons, id);
	
	for i, id in TitanPanelSettings.Buttons do
		if TitanUtils_GetWhichBar(id) == bar and i > index and TitanPanel_GetPluginSide(id) == side then
			return i;
		end
	end
end

function TitanUtils_GetRealPosition(id)
	local i = TitanPanel_GetButtonNumber(id);
	if TitanPanelSettings.Location[i] == "Bar" and TitanPanelGetVar("BothBars") then
		return TITAN_PANEL_PLACE_TOP;
	elseif TitanPanelSettings.Location[i] == "Bar" then
		return TitanPanelGetVar("Position");
	else
		return TITAN_PANEL_PLACE_BOTTOM;
	end
end

function TitanUtils_GetWhichBar(id)
	local i = TitanPanel_GetButtonNumber(id);
	return TitanPanelSettings.Location[i];
end

function TitanUtils_GetDoubleBar(bothbars, framePosition)
	if framePosition == TITAN_PANEL_PLACE_TOP then
		return TitanPanelGetVar("DoubleBar")
	elseif framePosition == TITAN_PANEL_PLACE_BOTTOM and bothbars == nil then
		return TitanPanelGetVar("DoubleBar")
	elseif framePosition == TITAN_PANEL_PLACE_BOTTOM and bothbars == 1 then
		return TitanPanelGetVar("AuxDoubleBar")
	end
end

function TitanUtils_CheckAutoHideCounting(elapsed)
	local frame = TitanPanelBarButtonHider;
	local auxframe = TitanPanelAuxBarButtonHider;

	if (TitanPanelGetVar("AutoHide")) then
		if (not frame.frameTimer or not frame.isCounting) then
			-- Do nothing
		elseif (frame.frameTimer < 0) then
			TitanPanelBarButton_Hide("TitanPanelBarButton", TitanPanelGetVar("Position"));
			frame.frameTimer = nil;
			frame.isCounting = nil;
		else
			frame.frameTimer = frame.frameTimer - elapsed;
		end
	end
	if (TitanPanelGetVar("AuxAutoHide")) then
		if (not auxframe.frameTimer or not auxframe.isCounting) then
			-- Do nothing
		elseif (auxframe.frameTimer < 0) then
			TitanPanelBarButton_Hide("TitanPanelAuxBarButton", TITAN_PANEL_PLACE_BOTTOM);
			auxframe.frameTimer = nil;
			auxframe.isCounting = nil;
		else
			auxframe.frameTimer = auxframe.frameTimer - elapsed;
		end
	end
end

function TitanUtils_StartAutoHideCounting(frame)
	TITAN_PANEL_SELECTED = TitanUtils_GetButtonID(this:GetName())
	-- Toggle menu

	if TITAN_PANEL_SELECTED == "MoneyButtonGold" or  TITAN_PANEL_SELECTED == "MoneyButtonSilver" or  TITAN_PANEL_SELECTED == "MoneyButtonCopper" then
		TITAN_PANEL_SELECTED = "Money"
	end

	if frame ~= nil then
		local frname = getglobal(frame);
		frname.frameTimer = TITAN_AUTOHIDE_WAIT_TIME;
		frname.isCounting = 1;
	end

end

function TitanUtils_StopAutoHideCounting(frame)
	TITAN_PANEL_SELECTED = TitanUtils_GetButtonID(this:GetName())
	-- Toggle menu
	
	if TITAN_PANEL_SELECTED == "MoneyButtonGold" or  TITAN_PANEL_SELECTED == "MoneyButtonSilver" or  TITAN_PANEL_SELECTED == "MoneyButtonCopper" then
		TITAN_PANEL_SELECTED = "Money"
	end

	if frame == nil then
		frame = "TitanPanel" .. TitanUtils_GetWhichBar(TITAN_PANEL_SELECTED) .. "ButtonHider";
	end

	local frname = getglobal(frame)
	frname.isCounting = nil;
end

function TitanUtils_CheckFrameCounting(frame, elapsed)
	if (frame:IsVisible()) then
		if (not frame.frameTimer or not frame.isCounting) then
			return;
		elseif ( frame.frameTimer < 0 ) then
			frame:Hide();
			frame.frameTimer = nil;
			frame.isCounting = nil;
		else
			frame.frameTimer = frame.frameTimer - elapsed;
		end
	end
end

function TitanUtils_StartFrameCounting(frame, frameShowTime)
	frame.frameTimer = frameShowTime;
	frame.isCounting = 1;
end

function TitanUtils_StopFrameCounting(frame)
	frame.isCounting = nil;
end

function TitanUtils_CloseAllControlFrames()
	for index, value in TitanPlugins do
		local frame = getglobal("TitanPanel"..index.."ControlFrame");
		if (frame and frame:IsVisible()) then
			frame:Hide();
		end
	end
end

function TitanUtils_IsAnyControlFrameVisible()
	for index, value in TitanPlugins do
		local frame = getglobal("TitanPanel"..index.."ControlFrame");
		if (frame:IsVisible()) then
			return true;
		end
	end
	return false;
end

function TitanUtils_CloseRightClickMenu()
	if (DropDownList1:IsVisible()) then
		DropDownList1:Hide();
	end
end

function TitanUtils_Ternary(a, b, c)
	if (a) then
		return b;
	else
		return c;
	end
end

function TitanUtils_Toggle(value)
	if (value == 1) then
		return nil;
	else
		return 1;
	end
end

function TitanUtils_Min(a, b)
	if (a and b) then
		return TitanUtils_Ternary((a < b), a, b);
	end
end

function TitanUtils_Max(a, b)
	if (a and b) then
		return TitanUtils_Ternary((a > b), a, b);
	end
end

function TitanUtils_GetEstTimeText(s)
	if (s < 0) then
		return TITAN_NA;
	elseif (s < 60) then
		return format("%d "..TITAN_SECONDS, s);
	elseif (s < 60*60) then
		return format("%.1f "..TITAN_MINUTES, s/60);
	elseif (s < 24*60*60) then
		return format("%.1f "..TITAN_HOURS, s/60/60);
	else
		return format("%.1f "..TITAN_DAYS, s/24/60/60);
	end
end

function TitanUtils_GetFullTimeText(s)
	if (s < 0) then
		return TITAN_NA;
	end
	
	local days = floor(s/24/60/60); s = mod(s, 24*60*60);
	local hours = floor(s/60/60); s = mod(s, 60*60);
	local minutes = floor(s/60); s = mod(s, 60);
	local seconds = s;
	
	return format("%d"..TITAN_DAYS_ABBR..", %2d"..TITAN_HOURS_ABBR..", %2d"..TITAN_MINUTES_ABBR..", %2d"..TITAN_SECONDS_ABBR,
				days, hours, minutes, seconds);
end

function TitanUtils_GetAbbrTimeText(s)
	if (s < 0) then
		return TITAN_NA;
	end
	
	local days = floor(s/24/60/60); s = mod(s, 24*60*60);
	local hours = floor(s/60/60); s = mod(s, 60*60);
	local minutes = floor(s/60); s = mod(s, 60);
	local seconds = s;
	
	local timeText = "";
	if (days ~= 0) then
		timeText = timeText..format("%d"..TITAN_DAYS_ABBR.." ", days);
	end
	if (days ~= 0 or hours ~= 0) then
		timeText = timeText..format("%d"..TITAN_HOURS_ABBR.." ", hours);
	end
	if (days ~= 0 or hours ~= 0 or minutes ~= 0) then
		timeText = timeText..format("%d"..TITAN_MINUTES_ABBR.." ", minutes);
	end	
	timeText = timeText..format("%d"..TITAN_SECONDS_ABBR, seconds);
	
	return timeText;
end

function TitanUtils_GetButton(id, returnThis)
	if (id) then
		return getglobal("TitanPanel"..id.."Button"), id;
	elseif (returnThis) then
		return this, TitanUtils_GetButtonID();
	end
end

function TitanUtils_GetButtonID(name)
	if (name == nil) then
		name = this:GetName();
	end

	if (name ~= nil) then
		local s, e, id = string.find(name, "TitanPanel(.*)Button");
		return id;
	else
		return "not found";
	end
end

function TitanUtils_GetParentButtonID(name)
	local frame = TitanUtils_Ternary(name, getglobal(name), this);

	if ( frame and frame:GetParent() ) then
		return TitanUtils_GetButtonID(frame:GetParent():GetName());
	end
end

function TitanUtils_GetButtonIDFromMenu()
	if ( this:GetParent() ) then
		if ( this:GetParent():GetName() == "TitanPanelBarButton" ) then
			return "Bar";
		elseif ( this:GetParent():GetName() == "TitanPanelAuxBarButton" ) then
			return "Bar";
		elseif ( this:GetParent():GetParent()) then  
			-- TitanPanelChildButton
			return TitanUtils_GetButtonID(this:GetParent():GetParent():GetName());		
		else
			-- TitanPanelButton
			return TitanUtils_GetButtonID(this:GetParent():GetName());		
		end	
	end
end

function TitanUtils_GetControlFrame(id)
	if (id == nil) then
		id = TitanUtils_GetButtonID();
	end

	if (id) then
		return getglobal("TitanPanel"..id.."ControlFrame");
	else
		return;
	end
end

function TitanUtils_GetPlugin(id)
	if (id == nil) then
		id = TitanUtils_GetButtonID();
	end

	if (id) then
		return TitanPlugins[id];
	end
end

function TitanUtils_IsPluginRegistered(id)
	if (id and TitanPlugins[id]) then
		return true;
	else
		return false;
	end
end

function TitanUtils_RegisterPlugin(registry) 
	if (registry and registry.id) then
		local id = registry.id;		
		if TitanUtils_IsPluginRegistered(id) then
			-- We have already registered this plugin we have an issue!
			TitanPanel_LoadError("Plugin " .. id .. TITAN_PANEL_ERROR_DUP_PLUGIN);
		else
			if (not TitanUtils_TableContainsValue(TitanPluginsIndex, id)) then
				TitanPlugins[id] = registry;
	--			if (not TitanUtils_TableContainsValue(TITAN_PANEL_NONMOVABLE_PLUGINS, id)) then
					table.insert(TitanPluginsIndex, registry.id);
					table.sort(TitanPluginsIndex, 
						function(a, b)
							return TitanPlugins[a].menuText < TitanPlugins[b].menuText;
						end
					);
	--			end
			end
		end	
	end
end

function TitanUtils_TableContainsValue(table, value)
	if (table and value) then
		for i, v in table do
			if (v == value) then
				return i;
			end
		end
	end
end

function TitanUtils_TableContainsIndex(table, index)
	if (table and index) then
		for i, v in table do
			if (i == index) then
				return i;
			end
		end
	end
end

function TitanUtils_GetCurrentIndex(table, value)
	return TitanUtils_TableContainsValue(table, value);
end

function TitanUtils_GetPreviousButton(table, id, isSameType, ignoreClock)	
	local index = TitanUtils_GetCurrentIndex(table, id);
	local isIcon = TitanPanelButton_IsIcon(id);	
	local previousButton, isPreviousIcon;
	
	if ( isSameType ) then
		-- Get the previous button with the same type
		while ( index > 1 ) do
			previousButton = TitanUtils_GetButton(table[index - 1]);
			isPreviousIcon = TitanPanelButton_IsIcon(table[index - 1]);
			
			if ( ( isIcon and isPreviousIcon ) or ( not isIcon and not isPreviousIcon ) ) then
				if ( ( table[index - 1] == TITAN_CLOCK_ID ) and ignoreClock ) then
					-- Do nothing, ignore Clock button
				else
					return previousButton;
				end
			end
			
			index = index - 1;
		end
	else
		-- Simply get the previous button
		if ( index > 1 ) then
			return TitanUtils_GetButton(table[index - 1]);
		end		
	end
end

function TitanUtils_GetNextButton(table, id, isSameType, ignoreClock)	
	local index = TitanUtils_GetCurrentIndex(table, id);
	local isIcon = TitanPanelButton_IsIcon(id);	
	local nextButton, isNextIcon;
	
	if ( isSameType ) then
		-- Get the next button with the same type
		while ( table[index + 1] ) do
			nextButton = TitanUtils_GetButton(table[index + 1]);
			isNextIcon = TitanPanelButton_IsIcon(table[index + 1]);
			
			if ( ( isIcon and isNextIcon ) or ( not isIcon and not isNextIcon ) ) then
				if ( ( table[index + 1] == TITAN_CLOCK_ID ) and ignoreClock ) then
					-- Do nothing, ignore Clock button
				else
					return nextButton;
				end
			end
			
			index = index + 1;
		end
	else
		-- Simply get the next button
		if ( table[index + 1] ) then
			return TitanUtils_GetButton(table[index + 1]);
		end		
	end
end

function TitanUtils_GetFirstButton(array, isSameType, isIcon, ignoreClock)	
	local firstButton, isFirstIcon;
	local size = table.getn(array);
	local index = 1;
	
	if ( isSameType ) then
		-- Get the first button with the same type
		while ( index <= size ) do
			firstButton = TitanUtils_GetButton(array[index]);
			isFirstIcon = TitanPanelButton_IsIcon(array[index]);

			if ( ( isIcon and isFirstIcon ) or ( not isIcon and not isFirstIcon ) ) then
				if ( ( array[index] == TITAN_CLOCK_ID ) and ignoreClock ) then
					-- Do nothing, ignore Clock button
				elseif TitanUtils_GetWhichBar(array[index]) == "AuxBar" then
					-- Do nothing wrong bar
				else
					return firstButton;
				end
			end
			
			index = index + 1;
		end
	else
		-- Simply get the first button
		if ( size > 0 ) then
			return TitanUtils_GetButton(array[1]);
		end		
	end
end

function TitanUtils_GetFirstAuxButton(array, isSameType, isIcon, ignoreClock)	
	local firstButton, isFirstIcon;
	local size = table.getn(array);
	local index = 1;
	
	if ( isSameType ) then
		-- Get the first button with the same type
		while ( index <= size ) do
			firstButton = TitanUtils_GetButton(array[index]);
			isFirstIcon = TitanPanelButton_IsIcon(array[index]);

			if ( ( isIcon and isFirstIcon ) or ( not isIcon and not isFirstIcon ) ) then
				if ( ( array[index] == TITAN_CLOCK_ID ) and ignoreClock ) then
					-- Do nothing, ignore Clock button
				elseif TitanUtils_GetWhichBar(array[index]) == "Bar" then
					-- Do nothing wrong bar
				else
					return firstButton;
				end
			end
						
			index = index + 1;
		end
	else
		-- Simply get the first button
		if ( size > 0 ) then
			return TitanUtils_GetButton(array[1]);
		end		
	end
end

function TitanUtils_GetLastButton(array, isSameType, isIcon, ignoreClock)	
	local lastButton, isLastIcon;
	local size = table.getn(array);
	local index = size;
	
	if ( isSameType ) then
		-- Get the last button with the same type
		while ( index > 0 ) do
			lastButton = TitanUtils_GetButton(array[index]);
			isLastIcon = TitanPanelButton_IsIcon(array[index]);

			if ( ( isIcon and isLastIcon ) or ( not isIcon and not isLastIcon ) ) then
				if ( ( array[index] == TITAN_CLOCK_ID ) and ignoreClock ) then
					-- Do nothing, ignore Clock button
				else
					return lastButton;
				end
			end
			
			index = index - 1;
		end
	else
		-- Simply get the last button
		if ( size > 0 ) then
			return TitanUtils_GetButton(array[size]);
		end		
	end
end

function TitanUtils_GetCPNIndexInArray(array, value)
	if (not array) then
		return;
	end
	
	local currentIndex, previousIndex, nextIndex;
	for i, v in array do
		if (v == value) then
			currentIndex = i;
		end
	end
	
	if (currentIndex > 1) then
		previousIndex = currentIndex - 1;
	end
	
	if (array[currentIndex + 1]) then
		nextIndex = currentIndex + 1;
	end
	
	return currentIndex, previousIndex, nextIndex;
end

function TitanUtils_PrintArray(array) 
	if (not array) then
		TitanDebug("array is nil");
	else
		TitanDebug("{");
		for i, v in array do
			TitanDebug("array[" .. tostring(i) .. "] = " .. tostring(v));
		end
		TitanDebug("}");
	end
	
end

function TitanUtils_GetRedText(text)
	if (text) then
		return RED_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE;
	end
end

function TitanUtils_GetGreenText(text)
	if (text) then
		return GREEN_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE;
	end
end

function TitanUtils_GetNormalText(text)
	if (text) then
		return NORMAL_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE;
	end
end

function TitanUtils_GetHighlightText(text)
	if (text) then
		return HIGHLIGHT_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE;
	end
end

function TitanUtils_GetColoredText(text, color)
	if (text and color) then
		local redColorCode = format("%02x", color.r * 255);		
		local greenColorCode = format("%02x", color.g * 255);
		local blueColorCode = format("%02x", color.b * 255);		
		local colorCode = "|cff"..redColorCode..greenColorCode..blueColorCode;
		return colorCode..text..FONT_COLOR_CODE_CLOSE;
	end
end

function TitanUtils_GetThresholdColor(ThresholdTable, value)
	if ( not tonumber(value) or type(ThresholdTable) ~= "table" or
			ThresholdTable.Values == nil or ThresholdTable.Colors == nil or
			table.getn(ThresholdTable.Values) >= table.getn(ThresholdTable.Colors) ) then
		return TITAN_THRESHOLD_EXCEPTION_COLOR;
	end

	local n = table.getn(ThresholdTable.Values) + 1;
	for i = 1, n do 
		local low = TitanUtils_Ternary(i == 1, nil, ThresholdTable.Values[i-1]);
		local high = TitanUtils_Ternary(i == n, nil, ThresholdTable.Values[i]);
		
		if ( not low and not high ) then
			-- No threshold values
			return ThresholdTable.Colors[i];
			
		elseif ( not low and high ) then
			-- Value is smaller than the first threshold			
			if ( value < high ) then return ThresholdTable.Colors[i] end
			
		elseif ( low and not high ) then
			-- Value is larger than the last threshold
			if ( low <= value ) then return ThresholdTable.Colors[i] end
			
		else
			-- Value is in between 2 adjacent thresholds
			if ( low <= value and value < high ) then return ThresholdTable.Colors[i] end
		end
	end
	
	-- Should never reach here
	return TITAN_THRESHOLD_EXCEPTION_COLOR;
end

function TitanUtils_ToString(text) 
	return TitanUtils_Ternary(text, text, "");
end

function TitanUtils_GetTotalTime()
	return TitanPanelBarButton.totalTime;
end

function TitanUtils_GetLevelTime()
	return TitanPanelBarButton.levelTime;
end

function TitanUtils_GetSessionTime()
	return TitanPanelBarButton.sessionTime;
end

function TitanUtils_GetOffscreen(frame)
	local offscreenX, offscreenY;

	if ( frame and frame:GetLeft() and frame:GetLeft() * frame:GetEffectiveScale() < UIParent:GetLeft() * UIParent:GetEffectiveScale() ) then
		offscreenX = -1;
	elseif ( frame and frame:GetRight() and frame:GetRight() * frame:GetEffectiveScale() > UIParent:GetRight() * UIParent:GetEffectiveScale() ) then
		offscreenX = 1;
	else
		offscreenX = 0;
	end

	if ( frame and frame:GetTop() and frame:GetTop() * frame:GetEffectiveScale() > UIParent:GetTop() * UIParent:GetEffectiveScale() ) then
		offscreenY = -1;
	elseif ( frame and frame:GetBottom() and frame:GetBottom() * frame:GetEffectiveScale() < UIParent:GetBottom() * UIParent:GetEffectiveScale() ) then
		offscreenY = 1;
	else
		offscreenY = 0;
	end
	
	--[[
	TitanDebug(frame:GetName());
	TitanDebug("frame:GetScale() = "..frame:GetScale());	
	TitanDebug("frame:GetLeft() = "..frame:GetLeft());	
	TitanDebug("frame:GetRight() = "..frame:GetRight());	
	TitanDebug("frame:GetTop() = "..frame:GetTop());	
	TitanDebug("frame:GetBottom() = "..frame:GetBottom());	
	TitanDebug("UIParent:GetScale() = "..UIParent:GetScale());	
	TitanDebug("UIParent:GetLeft() = "..UIParent:GetLeft());	
	TitanDebug("UIParent:GetRight() = "..UIParent:GetRight());	
	TitanDebug("UIParent:GetTop() = "..UIParent:GetTop());	
	TitanDebug("UIParent:GetBottom() = "..UIParent:GetBottom());	
	TitanDebug("offscreenX = "..offscreenX.." | offscreenY = "..offscreenY);
	]]--
	return offscreenX, offscreenY;
end

-- There's obvious bug in Blizzard code to handle the drop down menu offscreen cases.
-- I overwrote this function in order to do it right
function ToggleDropDownMenu(level, value, dropDownFrame, anchorName, xOffset, yOffset)
	if ( not level ) then
		level = 1;
	end
	UIDROPDOWNMENU_MENU_LEVEL = level;
	UIDROPDOWNMENU_MENU_VALUE = value;
	local listFrame = getglobal("DropDownList"..level);
	local listFrameName = "DropDownList"..level;
	local tempFrame;
	local point, relativePoint, relativeTo;
	if ( not dropDownFrame ) then
		tempFrame = this:GetParent();
	else
		tempFrame = dropDownFrame;
	end
	if ( listFrame:IsVisible() and (UIDROPDOWNMENU_OPEN_MENU == tempFrame:GetName()) ) then
		listFrame:Hide();
	else
		-- Hide the listframe anyways since it is redrawn OnShow() 
		listFrame:Hide();
		
		-- Frame to anchor the dropdown menu to
		local anchorFrame;

		-- Display stuff
		-- Level specific stuff
		if ( level == 1 ) then
			if ( not dropDownFrame ) then
				dropDownFrame = this:GetParent();
			end
			UIDROPDOWNMENU_OPEN_MENU = dropDownFrame:GetName();
			listFrame:ClearAllPoints();
			-- If there's no specified anchorName then use left side of the dropdown menu
			if ( not anchorName ) then
				-- See if the anchor was set manually using setanchor
				if ( dropDownFrame.xOffset ) then
					xOffset = dropDownFrame.xOffset;
				end
				if ( dropDownFrame.yOffset ) then
					yOffset = dropDownFrame.yOffset;
				end
				if ( dropDownFrame.point ) then
					point = dropDownFrame.point;
				end
				if ( dropDownFrame.relativeTo ) then
					relativeTo = dropDownFrame.relativeTo;
				else
					relativeTo = UIDROPDOWNMENU_OPEN_MENU.."Left";
				end
				if ( dropDownFrame.relativePoint ) then
					relativePoint = dropDownFrame.relativePoint;
				end
			elseif ( anchorName == "cursor" ) then
				relativeTo = "UIParent";
				local cursorX, cursorY = GetCursorPosition();
				if ( not xOffset ) then
					xOffset = 0;
				end
				if ( not yOffset ) then
					yOffset = 0;
				end
				xOffset = cursorX + xOffset;
				yOffset = cursorY + yOffset;
			else
				relativeTo = anchorName;
			end
			if ( not xOffset or not yOffset ) then
				xOffset = 8;
				yOffset = 22;
			end
			if ( not point ) then
				point = "TOPLEFT";
			end
			if ( not relativePoint ) then
				relativePoint = "BOTTOMLEFT";
			end
			listFrame:SetPoint(point, relativeTo, relativePoint, xOffset, yOffset);
		else
			if ( not dropDownFrame ) then
				dropDownFrame = getglobal(UIDROPDOWNMENU_OPEN_MENU);
			end
			listFrame:ClearAllPoints();
			-- If this is a dropdown button, not the arrow anchor it to itself
			if ( strsub(this:GetParent():GetName(), 0,12) == "DropDownList" and strlen(this:GetParent():GetName()) == 13 ) then
				anchorFrame = this:GetName();
			else
				anchorFrame = this:GetParent():GetName();
			end
			listFrame:SetPoint("TOPLEFT", anchorFrame, "TOPRIGHT", 0, 0);
		end
		
		-- Change list box appearance depending on display mode
		if ( dropDownFrame and dropDownFrame.displayMode == "MENU" ) then
			getglobal(listFrameName.."Backdrop"):Hide();
			getglobal(listFrameName.."MenuBackdrop"):Show();
		else
			getglobal(listFrameName.."Backdrop"):Show();
			getglobal(listFrameName.."MenuBackdrop"):Hide();
		end

		UIDropDownMenu_Initialize(dropDownFrame, dropDownFrame.initialize, nil, level);
		-- If no items in the drop down don't show it
		if ( listFrame.numButtons == 0 ) then
			return;
		end


		-- Check to see if the dropdownlist is off the screen, if it is anchor it to the top of the dropdown button
		-- I overwrote this part to fix Blizzard's offscreen bug
		listFrame:Show();
		local offscreenX, offscreenY = TitanUtils_GetOffscreen(listFrame);
		offscreenX = TitanUtils_Ternary(offscreenX == 0, nil, 1);
		offscreenY = TitanUtils_Ternary(offscreenY == 0, nil, 1);
		
		--[[
		listFrame:Show();
		-- Hack since GetCenter() is returning coords relative to 1024x768
		local x, y = listFrame:GetCenter();
		-- Hack will fix this in next revision of dropdowns
		if ( not x or not y ) then
			listFrame:Hide();
			return;
		end
		-- Determine whether the menu is off the screen or not
		local offscreenY, offscreenX;
		if ( (y - listFrame:GetHeight()/2) < 0 ) then
			offscreenY = 1;
		end
		if ( x + listFrame:GetWidth()/2 > GetScreenWidth() ) then
			offscreenX = 1;		
		end
		]]--

		
		--  If level 1 can only go off the bottom of the screen
		if ( level == 1 ) then
			if ( offscreenY ) then
				listFrame:ClearAllPoints();
				if ( anchorName == "cursor" ) then
					listFrame:SetPoint("BOTTOMLEFT", relativeTo, "BOTTOMLEFT", xOffset, yOffset);
				else
					listFrame:SetPoint("BOTTOMLEFT", relativeTo, "TOPLEFT", xOffset, -yOffset);
				end
			end

		else
			local anchorPoint, relativePoint, offsetX, offsetY;
			if ( offscreenY ) then
				if ( offscreenX ) then
					anchorPoint = "BOTTOMRIGHT";
					relativePoint = "BOTTOMLEFT";
					offsetX = 0;
					offsetY = -14;
				else
					anchorPoint = "BOTTOMLEFT";
					relativePoint = "BOTTOMRIGHT";
					offsetX = 0;
					offsetY = -14;
				end
			else
				if ( offscreenX ) then
					anchorPoint = "TOPRIGHT";
					relativePoint = "TOPLEFT";
					offsetX = 0;
					offsetY = 14;
				else
					anchorPoint = "TOPLEFT";
					relativePoint = "TOPRIGHT";
					offsetX = 0;
					offsetY = 14;
				end
			end
			listFrame:ClearAllPoints();
			listFrame:SetPoint(anchorPoint, anchorFrame, relativePoint, offsetX, offsetY);
		end
	end
end

