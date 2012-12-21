--===========================================================================--
----------------------------  LootTracker by PNB  ----------------------------
--===========================================================================--
-- LootTrackerPlayerDetailsUI.lua
--
-- Code behind the player details UI
--===========================================================================--


------------------------------------------------------------------------------
-- SetPlayer
------------------------------------------------------------------------------

function LT_SetPlayer(player)

    LT_DebugMessage(2, string.format("Viewing player %s", player.Name));

    LT_PlayerDetails:Show();
    LT_ItemDetails:Hide();
    LT_KillDetails:Hide();
    LT_SettingsFrame:Hide();
    
    local description = player.Name;
    description = description .. string.format("\nLevel %d", player.Level);
    description = description .. string.format("\n%s %s %s", player.Gender, player.Race, player.Class);
    
    if (player.TimesKilled ~= nil) then
        local deaths = getn(player.TimesKilled);
        if (deaths == 1) then
            description = description .. string.format("\n%d death", deaths);
        else
            description = description .. string.format("\n%d deaths", deaths);
        end
    end
    
    LT_Player_DescriptionText:SetText(description);
    
    
    local totalValue = 0;
    local items = LT_GetItems();
    foreach(player.Loot, function(k,v)
    
        local item = items[k];
        if (item.Value) then
            totalValue = totalValue + (item.Value * v);
        end
    
    end);
    
    local totalValueString = LT_GetValueString(totalValue, true);
    LT_Player_ValueText:SetText(totalValueString);
    
    
    LT_Player_GearList.Data = player;
    LT_Player_LootList.Data = player;
    LT_PlayerDetails.Data = player;
    
    LT_UpdateGenericScroller(LT_Player_GearList);
    LT_UpdateGenericScroller(LT_Player_LootList);

end


------------------------------------------------------------------------------
-- Player_Update
------------------------------------------------------------------------------

function LT_Player_Update()

    local player = LT_PlayerDetails.Data;
    LT_UpdatePlayer(player);
    
    LT_UpdateGenericScroller(LT_Player_GearList);

end


------------------------------------------------------------------------------
-- Player_Loot_GetTotal
------------------------------------------------------------------------------

function LT_Player_Loot_GetTotal(scroller)

    if (scroller.Data == nil) then
        LT_DebugMessage(1, "No player: Unable to get Loot total");
        return 0;
    end
    
    if (scroller.Data.Loot == nil) then
        LT_DebugMessage(1, "No loot list: Unable to get Loot total");
        return 0;
    end

    local uniqueCount = 0;
    local totalCount = 0;
    foreach(scroller.Data.Loot, function(k,v)
    
        uniqueCount = uniqueCount + 1;
        totalCount = totalCount + v;
    
    end);
    
    scroller.TotalCount = totalCount;

    return uniqueCount;

end

------------------------------------------------------------------------------
-- Player_Loot_GetItemLabel
------------------------------------------------------------------------------

function LT_Player_Loot_GetItemLabel(scroller, index)

    if (scroller.Data == nil) then
        return "Unknown";
    end
    
    local label, data = LT_GetItemLabel(scroller, scroller.Data.Loot, index, LT_Player_Loot_GetItemLabelWorker);
    return label, data;

end


------------------------------------------------------------------------------
-- Player_Loot_GetItemLabelWorker
------------------------------------------------------------------------------

function LT_Player_Loot_GetItemLabelWorker(scroller, k, v)

    local items = LT_GetItems();
    local item = items[k];
    
    if (item == nil) then
        return "Unknown", k;
    end
    
    local count = v;

    local qualityColor = LT_QualityColors[tostring(item.Quality)];
    local description = LT_ColorText(item.Name, qualityColor);

    local valueString = "";
    if (item.Value) then
        valueString = "(" .. LT_GetValueString(item.Value, true) .. ")";
    end

    local label = string.format("%s: %d %s", description, count, valueString);
    local data = k;

    return label, data;

end


------------------------------------------------------------------------------
-- Player_Gear_GetTotal
------------------------------------------------------------------------------

function LT_Player_Gear_GetTotal(scroller)

    if (scroller.Data == nil) then
        LT_DebugMessage(1, "No player: Unable to get Gear total");
        return 0;
    end
    
    if (scroller.Data.Gear == nil) then
        LT_DebugMessage(1, "No gear list: Unable to get Gear total");
        return 0;
    end

    local uniqueCount = 0;
    local totalCount = 0;
    foreach(scroller.Data.Gear, function(k,v)
    
        uniqueCount = uniqueCount + 1;
    
    end);
    
    scroller.TotalCount = uniqueCount;

    return uniqueCount;

end

------------------------------------------------------------------------------
-- Player_Gear_GetItemLabel
------------------------------------------------------------------------------

function LT_Player_Gear_GetItemLabel(scroller, index)

    if (scroller.Data == nil) then
        return "Unknown";
    end
    
    local label, data = LT_GetItemLabel(scroller, scroller.Data.Gear, index, LT_Player_Gear_GetItemLabelWorker);
    return label, data;

end


------------------------------------------------------------------------------
-- Player_Gear_GetItemLabelWorker
------------------------------------------------------------------------------

function LT_Player_Gear_GetItemLabelWorker(scroller, k, v)

    local item = v;

    local qualityColor = LT_QualityColors[tostring(item.Quality)];
    local description = LT_ColorText(item.Name, qualityColor);
    
    return description, item.Name;

end


------------------------------------------------------------------------------
-- OnPlayerButtonClicked
------------------------------------------------------------------------------

function LT_OnPlayerButtonClicked(button)

    local name = button.Data;
    
    LT_DebugMessage(2, string.format("Clicked %s", name));
    
    local players = LT_GetPlayers();
    local player = players[name];

    LT_SetPlayer(player);

end
