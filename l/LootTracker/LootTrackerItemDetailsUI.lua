--===========================================================================--
----------------------------  LootTracker by PNB  ----------------------------
--===========================================================================--
-- LootTrackerItemDetailsUI.lua
--
-- Code behind the item details UI
--===========================================================================--


------------------------------------------------------------------------------
-- SetItem
------------------------------------------------------------------------------

function LT_SetItem(item)

    LT_DebugMessage(2, string.format("Viewing item %s", item.Name));

    LT_ItemDetails:Show();
    LT_PlayerDetails:Hide();
    LT_KillDetails:Hide();
    LT_SettingsFrame:Hide();

    local qualityColor = LT_QualityColors[tostring(item.Quality)];
    local description = LT_ColorText(item.Name, qualityColor);

    LT_Item_DescriptionText:SetText(description);
    
    local value = item.Value;
    if (value == nil) then
        value = 0;
    end
    
    local gold, silver, copper = LT_GetValueByCoinType(value);

    LT_GoldEditBox:SetText(gold);
    LT_SilverEditBox:SetText(silver);
    LT_CopperEditBox:SetText(copper);
    
    LT_ItemDetails.Data = item;
    LT_RecipientsList.Data = item;
    LT_SourcesList.Data = item;
    
    LT_UpdateGenericScroller(LT_RecipientsList);
    LT_UpdateGenericScroller(LT_SourcesList);

end


------------------------------------------------------------------------------
-- ItemDetails_SetValue
------------------------------------------------------------------------------

function LT_ItemDetails_SetValue()

    local gold = tonumber(LT_GoldEditBox:GetText());
    local silver = tonumber(LT_SilverEditBox:GetText());
    local copper = tonumber(LT_CopperEditBox:GetText());
    
    local value = LT_GetValueFromCoins(gold, silver, copper);

    local item = LT_ItemDetails.Data;
    
    LT_DebugMessage(1, string.format("Setting new value on %s: %d", item.Name, value));
    
    item.Value = value;

end


------------------------------------------------------------------------------
-- Sources_GetTotal
------------------------------------------------------------------------------

function LT_Sources_GetTotal(scroller)

    if (scroller.Data == nil) then
        LT_DebugMessage(1, "No item: Unable to get Sources total");
        return 0;
    end
    
    if (scroller.Data.Sources == nil) then
        return 0;
    end
    
    local uniqueCount = 0;
    local totalCount = 0;
    local totalCountReceived = 0;
    foreach(scroller.Data.Sources, function(k,v)
    
        uniqueCount = uniqueCount + 1;
        totalCount = totalCount + v;
    
    end);
    foreach(scroller.Data.Recipients, function(k,v)
    
        totalCountReceived = totalCountReceived + v;
    
    end);
    
    scroller.TotalCount = totalCountReceived;
    scroller.UnknownCount = totalCountReceived - totalCount;
    
    if (totalCount ~= totalCountReceived) then
        -- Add one entry for the unknown sources
        uniqueCount = uniqueCount + 1;
    end

    return uniqueCount;

end

------------------------------------------------------------------------------
-- Sources_GetItemLabel
------------------------------------------------------------------------------

function LT_Sources_GetItemLabel(scroller, index)

    if (scroller.Data == nil) then
        return "Unknown";
    end
    
    local label, data = LT_GetItemLabel(scroller, scroller.Data.Sources, index, LT_Scroller_GetPercentageLabel);
    return label, data;

end


------------------------------------------------------------------------------
-- Recipients_GetTotal
------------------------------------------------------------------------------

function LT_Recipients_GetTotal(scroller)

    if (scroller.Data == nil) then
        LT_DebugMessage(1, "No item: Unable to get Recipients total");
        return 0;
    end
    
    if (scroller.Data.Recipients == nil) then
        LT_DebugMessage(1, "No recipients: Unable to get Recipients total");
        return 0;
    end

    local uniqueCount = 0;
    local totalCount = 0;
    foreach(scroller.Data.Recipients, function(k,v)
    
        uniqueCount = uniqueCount + 1;
        totalCount = totalCount + v;
    
    end);
    
    scroller.TotalCount = totalCount;

    return uniqueCount;

end

------------------------------------------------------------------------------
-- Recipients_GetItemLabel
------------------------------------------------------------------------------

function LT_Recipients_GetItemLabel(scroller, index)

    if (scroller.Data == nil) then
        return "Unknown";
    end
    
    local label, data = LT_GetItemLabel(scroller, scroller.Data.Recipients, index, LT_Scroller_GetPercentageLabel);
    return label, data;

end


------------------------------------------------------------------------------
-- OnItemButtonClicked
------------------------------------------------------------------------------

function LT_OnItemButtonClicked(button)

    local name = button.Data;
    
    LT_DebugMessage(2, string.format("Clicked %s", name));
    
    local items = LT_GetItems();
    local item = items[name];

    if (item ~= nil) then
        LT_SetItem(item);
    end

end


------------------------------------------------------------------------------
-- InitializeDropDown
-- TESTING
------------------------------------------------------------------------------

function LT_InitializeDropDown()

	local info = {};
	info.text = "Test";
	info.func = LT_OnPlayerButtonClicked;
	--info.arg1 = value.index;
	UIDropDownMenu_AddButton(info);

end


