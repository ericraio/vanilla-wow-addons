--===========================================================================--
----------------------------  LootTracker by PNB  ----------------------------
--===========================================================================--
-- LootTrackerKillDetailsUI.lua
--
-- Code behind the kill details UI
--===========================================================================--


------------------------------------------------------------------------------
-- SetKill
------------------------------------------------------------------------------

function LT_SetKill(kill)

    LT_DebugMessage(2, string.format("Viewing kill %s", kill.Name));

    LT_KillDetails:Show();
    LT_ItemDetails:Hide();
    LT_PlayerDetails:Hide();
    LT_SettingsFrame:Hide();
    
    local description = kill.Name;
    description = description .. string.format("\nLevel %d", kill.Level);
    --description = description .. string.format("\n%s %s %s", kill.Gender, kill.Race, kill.Class);
    
    if (kill.TimesKilled ~= nil) then
        local deaths = getn(kill.TimesKilled);
        if (deaths == 1) then
            description = description .. string.format("\n%d death", deaths);
        else
            description = description .. string.format("\n%d deaths", deaths);
        end
    end
    
    LT_Kill_DescriptionText:SetText(description);
    
    LT_Kill_RemoveDeathButton:Disable();
    
    local totalValue = 0;
    if (kill.Drops ~= nil) then
        local items = LT_GetItems();
        foreach(kill.Drops, function(k,v)
        
            local item = items[k];
            if (item.Value) then
                totalValue = totalValue + (item.Value * v);
            end
        
        end);
    end
    
    local averageValue = totalValue / getn(kill.TimesKilled);
    
    local averageValueString = LT_GetValueString(averageValue, true);
    LT_Kill_ValueText:SetText(averageValueString);
    
    LT_Kill_DeathsList.Data = kill;
    LT_Kill_DropsList.Data = kill;
    LT_KillDetails.Data = kill;
    
    LT_UpdateGenericScroller(LT_Kill_DeathsList);
    LT_UpdateGenericScroller(LT_Kill_DropsList);

end


------------------------------------------------------------------------------
-- Kill_RemoveDeath
------------------------------------------------------------------------------

function LT_Kill_RemoveDeath()

    LT_DebugMessage(1, "TODO: Remove the currently selected death entry");

end



------------------------------------------------------------------------------
-- Kill_Drops_GetTotal
------------------------------------------------------------------------------

function LT_Kill_Drops_GetTotal(scroller)

    if (scroller.Data == nil) then
        LT_DebugMessage(1, "No kill: Unable to get Drops total");
        return 0;
    end
    
    if (scroller.Data.Drops == nil) then
        LT_DebugMessage(1, "No drop list: Unable to get Drops total");
        return 0;
    end

    local uniqueCount = 0;
    foreach(scroller.Data.Drops, function(k,v)
    
        uniqueCount = uniqueCount + 1;
    
    end);
    
    local totalCount = getn(scroller.Data.TimesKilled);
    
    scroller.TotalCount = totalCount;

    return uniqueCount;

end

------------------------------------------------------------------------------
-- Kill_Drops_GetItemLabel
------------------------------------------------------------------------------

function LT_Kill_Drops_GetItemLabel(scroller, index)

    if (scroller.Data == nil) then
        return "Unknown";
    end
    
    local label, data = LT_GetItemLabel(scroller, scroller.Data.Drops, index, LT_Kill_Drops_GetItemLabelWorker);
    return label, data;

end


------------------------------------------------------------------------------
-- Kill_Drops_GetItemLabelWorker
------------------------------------------------------------------------------

function LT_Kill_Drops_GetItemLabelWorker(scroller, k, v)

    local items = LT_GetItems();
    local item = items[k];
    
    local count = v;
    local percentage = (count / scroller.TotalCount) * 100;

    local qualityColor = LT_QualityColors[tostring(item.Quality)];
    local description = LT_ColorText(item.Name, qualityColor);
    
    local label = string.format("%s: %d (%.2f%%)", description, count, percentage);
    local data = item.Name;
    
    return label, data;

end


------------------------------------------------------------------------------
-- Kill_Deaths_GetTotal
------------------------------------------------------------------------------

function LT_Kill_Deaths_GetTotal(scroller)

    if (scroller.Data == nil) then
        LT_DebugMessage(1, "No kill: Unable to get Deaths total");
        return 0;
    end
    
    if (scroller.Data.TimesKilled == nil) then
        LT_DebugMessage(1, "No death list: Unable to get Deaths total");
        return 0;
    end

    local uniqueCount = 0;
    local totalCount = 0;
    foreach(scroller.Data.TimesKilled, function(k,v)
    
        uniqueCount = uniqueCount + 1;
    
    end);
    
    scroller.TotalCount = uniqueCount;

    return uniqueCount;

end

------------------------------------------------------------------------------
-- Kill_Deaths_GetItemLabel
------------------------------------------------------------------------------

function LT_Kill_Deaths_GetItemLabel(scroller, index)

    if (scroller.Data == nil) then
        return "Unknown";
    end
    
    local label, data = LT_GetItemLabel(scroller, scroller.Data.TimesKilled, index, LT_Scroller_GetLabel);
    return label, data;

end


------------------------------------------------------------------------------
-- OnKillButtonClicked
------------------------------------------------------------------------------

function LT_OnKillButtonClicked(button)

    local name = button.Data;
    
    local kills = LT_GetKills();
    local kill = kills[name];
    
    if (kill ~= nil) then
        LT_SetKill(kill);
    else
        LT_DebugMessage(2, string.format("No kill found for name %s", name));
    end

end

