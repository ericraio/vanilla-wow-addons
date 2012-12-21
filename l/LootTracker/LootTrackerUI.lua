--===========================================================================--
----------------------------  LootTracker by PNB  ----------------------------
--===========================================================================--
-- LootTrackerSettingsUI.lua
--
-- Code behind the settings UI
--===========================================================================--


------------------------------------------------------------------------------
-- UpdateUI
------------------------------------------------------------------------------

function LT_UpdateUI()

    -- TODO: Move to LootTrackerSessionChangeUI.lua
    LT_OnSessionEditValueChanged(LT_ChangeSessionEditBox:GetText());
    
    LT_UpdateCurrentSessionText();

end


------------------------------------------------------------------------------
-- UpdateCurrentSessionText
------------------------------------------------------------------------------

function LT_UpdateCurrentSessionText()

    local settings = LT_GetSettings();
    local sessionName = settings.CurrentSession;
    LT_CurrentSessionText:SetText(LT_FormatSessionName(sessionName));

end


------------------------------------------------------------------------------
-- FormatSessionName
------------------------------------------------------------------------------

function LT_FormatSessionName(sessionName)

    local text = LT_ColorText(sessionName, LT_White);
    
    local session = LT_GetSession(sessionName, false);
    if (session ~= nil) then
        
        local sessionBeginTime  = session.FirstEventTime;
        local sessionEndTime    = session.MostRecentEventTime;
        if ((sessionBeginTime ~= nil) and (sessionEndTime ~= nil)) then
            -- Would use difftime() here, but WoW doesn't include that LUA API.
            local elapsedTime = sessionEndTime - sessionBeginTime;
            
            -- If I don't do this I'm getting a time that's offset by 16 hours.
            -- I don't exactly understand why, but this seems to clear it up...
            local baseTime = {};
            baseTime.year = 1970;
            baseTime.month = 1;
            baseTime.day = 1;
            baseTime.hour = 0;
            local offsetTime = time(baseTime);
            
            -- I'm not sure why time() is sometimes returning nil here, but some
            -- people are reporting an error there.  Pretty harmless to just
            -- check for nil and leave off the time display if that's the case.
            if (offsetTime ~= nil) then
            
                -- Get the elapsed time for this session.
                local elapsedTime = elapsedTime + offsetTime;

                local formattedStartTime = date(LT_LABEL_FORMAT_TIMESTART, sessionBeginTime);
                local formattedElapsedTime = date(LT_LABEL_FORMAT_TIMEELAPSED, elapsedTime);
                text = text .. "\n" .. string.format(LT_LABEL_TIMESUMMARY, formattedStartTime, formattedElapsedTime);
            end
        end
        
        local totalValue = 0;
        local items = session.Items;
        if (items ~= nil) then
            foreach(items, function(itemName, item)
                local itemValue = item.Value;
                if (itemValue ~= nil) then
                    local timesLooted = getn(item.TimesLooted);
                    totalValue = totalValue + (timesLooted * itemValue);
                end
            end);
        end
        
        if (totalValue > 0) then
            text = text .. "\nValue: " .. LT_GetValueString(totalValue, true);
        end
    end
    
    return text;

end


------------------------------------------------------------------------------
-- OnSessionEditValueChanged
------------------------------------------------------------------------------

function LT_OnSessionEditValueChanged(value)

    local settings = LT_GetSettings();
    local userData = LT_Data[LT_RealmAndPlayer];
    
    local isCurrentSession = (value == settings.CurrentSession);
    local doesSessionExist = LT_TableHasKey(userData, value);
    local isValidSessionName = not LT_StrIsNilOrEmpty(value);
    
    if (isCurrentSession) then
        LT_SetSessionButton:SetText(LT_BUTTON_CREATE);
        LT_SetSessionButton:Disable();
        
        LT_ResetButton:SetText(LT_BUTTON_RESET);
        LT_ResetButton:Enable();
        
        LT_ExportSessionButton:Disable();
    else
        if (isValidSessionName) then
            if (doesSessionExist) then
                LT_SetSessionButton:SetText(LT_BUTTON_SET);
            else
                LT_SetSessionButton:SetText(LT_BUTTON_CREATE);
            end
            LT_SetSessionButton:Enable();
        else
            LT_SetSessionButton:SetText(LT_BUTTON_CREATE);
            LT_SetSessionButton:Disable();
        end

        LT_ResetButton:SetText(LT_BUTTON_DELETE);        
        if (doesSessionExist) then
            LT_ResetButton:Enable();
        else
            LT_ResetButton:Disable();
        end
        
        if (isValidSessionName) then
            LT_ExportSessionButton:Enable();
        else
            LT_ExportSessionButton:Disable();
        end
    end

end


------------------------------------------------------------------------------
-- UpdateSessionScroll
------------------------------------------------------------------------------

LT_SCROLL_SESSIONITEMHEIGHT = 20;
LT_SCROLL_SESSIONVISIBLECOUNT = 5;

function LT_UpdateSessionScroll()

    local offset = FauxScrollFrame_GetOffset(LT_SessionScrollFrame);
    
    local validSessions = LT_GetAvailableSessions();
    local numItems = getn(validSessions);
    
    FauxScrollFrame_Update(LT_SessionScrollFrame, numItems, LT_SCROLL_SESSIONVISIBLECOUNT, LT_SCROLL_SESSIONITEMHEIGHT, nil, nil, nil, nil, 165, 100);
    
    -- Fill in the buttons
	for i=1, LT_SCROLL_SESSIONVISIBLECOUNT, 1 do

		local index = i + offset;
		local button = getglobal("LT_SessionButton" .. i);
		assert(button ~= nil);
		
		local sessionName = validSessions[index];
		
		if ((index <= numItems) and (sessionName ~= nil)) then
		    button:SetText(sessionName);
	        button:Show();
	    else
	        button:Hide();
	    end

	end

end

------------------------------------------------------------------------------
-- SessionButtonClicked
------------------------------------------------------------------------------

function LT_SessionButtonClicked(button)

    local text = button:GetText();
    LT_ChangeSessionEditBox:SetText(text);
    LT_UpdateCurrentSessionText();

end


------------------------------------------------------------------------------
-- SessionButtonClicked
------------------------------------------------------------------------------

function LT_SessionButtonClicked(button)

    local text = button:GetText();
    LT_ChangeSessionEditBox:SetText(text);
    LT_UpdateCurrentSessionText();

end


------------------------------------------------------------------------------
-- UpdateGenericScroller
------------------------------------------------------------------------------

function LT_UpdateGenericScroller(scroller)

    if (scroller == nil) then
        scroller = this;
    end
    
    assert(scroller ~= nil);
    
    if (scroller.Data ~= nil) then
        LT_DebugMessage(4, "Data: " .. scroller.Data.Name);
    end
    

    local offset = FauxScrollFrame_GetOffset(scroller);
    if (offset == nil) then
        offset = 0;
    end    
    
    local numItems = scroller.TotalCountHandler(scroller);
    LT_DebugMessage(4, "NumItems: " .. tostring(numItems));
    
    FauxScrollFrame_Update(scroller, numItems, scroller.VisibleCount, scroller.ItemHeight, nil, nil, nil, nil, scroller:GetWidth(), scroller:GetHeight());
    
    -- Fill in the buttons
	for i=1, scroller.VisibleCount, 1 do

		local index = i + offset;
		local button = getglobal(scroller.ButtonName .. i);
		assert(button ~= nil);
		
		if (index <= numItems) then
		
		    local label, data = scroller.ItemLabelHandler(scroller, index);
		    LT_DebugMessage(4, "Label(" .. index .. "): " .. tostring(label));
		    button:Show();

		    if (label ~= nil) then
		        button:SetText(label);
		        button.Data = data;

	            local text = getglobal(button:GetName() .. "Text");
		        assert(text ~= nil);
		        text:SetText(label);
		    end
	    else
	        LT_DebugMessage(4, "Label(" .. index .. "): <Hide>");
	        button:Hide();
	    end

	end

end


------------------------------------------------------------------------------
-- GetItemLabel
------------------------------------------------------------------------------

function LT_GetItemLabel(scroller, t, index, func)

    if (t == nil) then
        return "Unknown";
    end

    local currentIndex = 1;
    local label = nil;
    local data = nil;
    foreach(t, function(k,v)
        if (currentIndex == index) then
            label, data = func(scroller, k, v);
        end
        currentIndex = currentIndex + 1;
    end);

    if (label == nil) then
        label = func(scroller, "Unknown", nil);
    end
    
    return label, data;

end

------------------------------------------------------------------------------
-- Scroller_GetPercentageLabel
------------------------------------------------------------------------------

function LT_Scroller_GetPercentageLabel(scroller, k, v)

    local name = k;
    local count = v;

    if (count == nil) then
        count = scroller.UnknownCount;
        if ((count == nil) or (count == 0)) then
            return name, name;
        end
    end

    local percentage = (count / scroller.TotalCount) * 100;

    local label = string.format("%s: %d (%.0f%%)", name, count, percentage);
    local data = name;
    
    return label, data;

end


------------------------------------------------------------------------------
-- Scroller_GetLabel
------------------------------------------------------------------------------

function LT_Scroller_GetLabel(scroller, k, v)

    return tostring(v), k;

end
