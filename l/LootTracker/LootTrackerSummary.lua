--===========================================================================--
----------------------------  LootTracker by PNB  ----------------------------
--===========================================================================--
-- LootTrackerSummary.lua
--
-- Functions to output object summaries.
--===========================================================================--


------------------------------------------------------------------------------
-- GetItemSummary
-- Return a string summary representation of an item.
------------------------------------------------------------------------------

function LT_GetItemSummary(item, qualityThreshold, currentPlayer, qualityColor)

    --local qualityThreshold = settings.QualityThreshold;
    if (qualityThreshold == nil) then
        qualityThreshold = LT_MinQuality;
    end
    
    if (qualityColor == nil) then
        qualityColor = LT_QualityColors[tostring(item.Quality)];
    end
    
    -- Initialize our return values
    local contentText = nil;
    local count = 0;
    local totalValue = 0;
    local playerValue = 0;
    
    -- Number of times this item has been looted
    count = getn(item.TimesLooted);
    
    -- Process the item value
    local valueString = "";
    if ((item.Value ~= nil) and (item.Value > 0)) then
    
        -- The total value is the per-item value multiplied by the count looted
        totalValue = (item.Value * count);
        
        -- Create a colored value string
        valueString = " (" .. LT_GetValueString(item.Value, true) .. ")";
        
        -- Determine what the end value is to the current player
        if (item.Recipients ~= nil) then
            local countReceivedByPlayer = 0;
            
            -- See how many times this loot was received by the current player
            if (currentPlayer ~= nil) then
                local recipientCount = item.Recipients[currentPlayer];
                if (recipientCount ~= nil) then
                    countReceivedByPlayer = countReceivedByPlayer + recipientCount;
                end
            end
            
            -- See how many times this loot was received by everyone
            local recipientCount = item.Recipients[LT_EVERYONE];
            if (recipientCount ~= nil) then
                countReceivedByPlayer = countReceivedByPlayer + recipientCount;
            end
            
            -- The player's received value is the per-item value multiplied by his received count
            playerValue = (item.Value * countReceivedByPlayer);
        end
    end
                    
    -- Only create a content string for this item if we're above the threshold
    if (item.Quality >= qualityThreshold) then
    
        -- Display a list of who received this item and how many they received
        local recipients = LT_GetRecipientsString(item, nil, ", ");
        if (recipients ~= nil) then
            recipients = ": " .. recipients;
        else
            recipients = "";
        end

        -- Format:
        --  Name: Recipient (Count), Recipient (Count) Value
                                            
        contentText = LT_ColorText(item.Name, qualityColor) .. valueString .. recipients;
    end
    
    return contentText, count, totalValue, playerValue;

end


------------------------------------------------------------------------------
-- GetKillSummary
-- Get a string representation of a kill.
------------------------------------------------------------------------------

function LT_GetKillSummary(kill)

    local killCount = getn(kill.TimesKilled);
    local killName  = LT_ColorText(kill.Name, LT_White);
    
    local killDrops = nil;
    local killValue = "";
    
    local killLevel = "";
    if (kill.Level ~= nil) then
        killLevel = ", level " .. kill.Level;
        if (kill.Elite) then
            killLevel = killLevel .. "+";
        end
    end
    
    if (kill.Drops ~= nil) then
    
        local dropsByQuality = {};
        
        local items = LT_GetItems();
        local totalValue = 0;
    
        -- Calculate the number of drops by quality type
        foreach(kill.Drops, function(k,v)
            local item = items[k];
            local quality = item.Quality;
        
            if (dropsByQuality[quality] == nil) then
                dropsByQuality[quality] = 0;
            end
            
            dropsByQuality[quality] = dropsByQuality[quality] + v;
            if (item.Value ~= nil) then
                totalValue = totalValue + (item.Value * v);
            end
        end);
        
        for quality = LT_MaxQuality, LT_MinQuality, -1 do
            local dropsOfQuality = dropsByQuality[quality];
            if (dropsOfQuality ~= nil) then
                local color = LT_QualityColors[tostring(quality)];
                killDrops = LT_StrAppend(killDrops, LT_ColorText(dropsOfQuality, color), ",");
            end
        end
        
        if (totalValue > 0) then
            local averageValue = totalValue / killCount;
            local averageValueString = string.format("%.1d", averageValue);
            killValue = string.format(" (%s)", LT_GetValueString(averageValueString, true));
        end
    end
    
    if (killDrops == nil) then
        killDrops = "";
    end
    
    
    -- Format:
    --  Name, level Level (Number)(Value): Drops

    return string.format("%s%s (%d)%s %s", killName, killLevel, killCount, killValue, killDrops);

end


------------------------------------------------------------------------------
-- GetPlayerSummary
-- Get a string representation of a player.
------------------------------------------------------------------------------

function LT_GetPlayerSummary(player, playerCountString)

    local playerName = LT_ColorText(player.Name, LT_White);
    
    -- Level
    local level = "??";
    if (player.Level ~= nil) then
        level = player.Level;
    end
    
    -- Class
    local class = "Unknown";
    if (player.Class ~= nil) then
        class = player.Class;
    end

    local text = (playerName .. ", level " .. level .. " " .. class);
    
    -- Deaths
    if (player.TimesKilled ~= nil) then
        local deathCount = getn(player.TimesKilled);
        
        text = text .. " (" .. deathCount .. " deaths)";
    end
    
    -- Loot
    if (playerCountString ~= nil) then
        text = text .. ": " .. playerCountString;
    end
    
    -- Format:
    --  Name, level Level Class, (NumberOfDeaths deaths): loot

    return text;

end


------------------------------------------------------------------------------
-- OutputSummary
-- Outputs a summary of an object or set of objects to the console.
------------------------------------------------------------------------------

function LT_OutputSummary(argument, output)

    local items = LT_GetItems();
    local kills = LT_GetKills();
    local players = LT_GetPlayers();
    
    if (output == nil) then
        LT_DebugMessage(2, "Redirecting to standard output in LT_OutputSummary");
        output = LT_StdOut;
    end

    if (argument == LT_QUERY_ITEMS) then
        LT_OutputItemsSummary(output);
        
    elseif (argument == LT_QUERY_KILLS) then
        LT_OutputKillsSummary(output);
    
    elseif (argument == LT_QUERY_PLAYERS) then
        LT_OutputPlayersSummary(output);
        
    elseif (argument == LT_QUERY_LOOT) then
        local pendingLoot = LT_GetPendingLoot();
        foreach(pendingLoot, function(k,v)
            LT_FormatMessageKeyValue(k, v, output);
        end);
    
    elseif (argument == LT_QUERY_TARGETS) then
        local pendingTargets = LT_GetPendingTargets();
        foreach(pendingTargets, function(k,v)
            LT_FormatMessageKeyValue(k, v, output);
        end);
    
    elseif ((argument == nil) or (argument == "")) then
        output.Write("Items: {");
        output.Indent();
        LT_OutputItemsSummary(output);
        output.Unindent();
        output.Write("}");
        
        output.Write("Kills: {");
        output.Indent();
        LT_OutputKillsSummary(output);
        output.Unindent();
        output.Write("}");
        
        output.Write("Players: {");
        output.Indent();
        LT_OutputPlayersSummary(output);
        output.Unindent();
        output.Write("}");

    else
        if (LT_TableHasKey(items, argument)) then
            foreach(items[argument], function(k,v)
                LT_FormatMessageKeyValue(k, v, output);
            end);
            
        elseif (LT_TableHasKey(kills, argument)) then
            foreach(kills[argument], function(k,v)
                LT_FormatMessageKeyValue(k, v, output);
            end);
            
        elseif (LT_TableHasKey(players, argument)) then
            foreach(players[argument], function(k,v)
                LT_FormatMessageKeyValue(k, v, output);
            end);
            
        else
            output.Write(string.format(LT_QUERY_ERROR, argument));
        end
    end

end


------------------------------------------------------------------------------
-- GetToolbarSummary
-- Get the label to display on the toolbar.
------------------------------------------------------------------------------

function LT_GetToolbarSummary()

    local settings = LT_GetSettings();
    
    local text = nil;

    if (settings.TooltipShowItems) then
        -- Get item counts (excluding Money (-1))
        local totalCountString = LT_GetTotalItemCountString(0);
        -- Default to 0
        if (totalCountString == nil) then
            totalCountString = "0";
        end
        
        local itemText = string.format(LT_TOOLBAR_ITEMS, totalCountString);
        
        if (text == nil) then
            text = itemText;
        else
            text = string.format(LT_TOOLBAR_DIVIDER, text, itemText);
        end
    end

    if (settings.TooltipShowKills) then
        -- Total number of kills
        local killCount     = LT_GetTotalKillCount(kills);
        local killText      = string.format(LT_TOOLBAR_KILLS, killCount);
        
        if (text == nil) then
            text = killText;
        else
            text = string.format(LT_TOOLBAR_DIVIDER, text, killText);
        end
    end
    
    if (settings.TooltipShowPlayers) then
        -- Total number of players
        local players       = LT_GetPlayers();
        local playerCount   = LT_GetCount(players);
        local playerText    = string.format(LT_TOOLBAR_PLAYERS, playerCount);
        
        if (text == nil) then
            text = playerText;
        else
            text = string.format(LT_TOOLBAR_DIVIDER, text, playerText);
        end
    end
    
    
    -- Format:
    --  Items: 26,13,4 | Kills: 51 | Players: 4
    
    return text;

end


------------------------------------------------------------------------------
-- GetTotalItemCountString
-- Put together a string of the count of items looted by quality type.
------------------------------------------------------------------------------

function LT_GetTotalItemCountString(qualityThreshold)

    local itemsByQuality = LT_GetItemsByQuality();
    local settings = LT_GetSettings();
    
    if (qualityThreshold == nil) then
        qualityThreshold = settings.QualityThreshold;
    end

    local totalCountString = nil;    
    local playerCountString = {};
    
    -- The results come back unsorted.  We need to walk through in a specific order    
    for quality = LT_MaxQuality, LT_MinQuality, -1 do
        itemsInBucket = itemsByQuality[quality];
        
        -- Only process this quality bucket if it meets our threshold
        if ((itemsInBucket ~= nil) and (quality >= qualityThreshold)) then
        
            local color = LT_QualityColors[tostring(quality)];
        
            -- Calculate the total item count, including redundant loots
            local itemCount = 0;
            local playerCount = {};
            foreach (itemsInBucket, function(k,item)
                itemCount = itemCount + getn(item.TimesLooted);
                
                if (item.Recipients ~= nil) then
                    -- Also keep track of counts by player
                    foreach(item.Recipients, function(k,v)
                        if (playerCount[k] == nil) then
                            playerCount[k] = 0;
                        end
                        
                        playerCount[k] = playerCount[k] + v;
                    end);
                end
            end);
            
            -- Color the count and add it to the item string.
            local countString = LT_ColorText(itemCount, color);
            totalCountString = LT_StrAppend(totalCountString, countString, ",");
            
            -- Process all the player count strings.
            foreach(playerCount, function(playerName,count)
                local countString = LT_ColorText(count, color);
                playerCountString[playerName] = LT_StrAppend(playerCountString[playerName], countString, ",");
            end);
            
        end
    end
    
    return totalCountString, playerCountString;
end


------------------------------------------------------------------------------
-- GetTotalKillCount
-- Get the deep number of kills.
------------------------------------------------------------------------------

function LT_GetTotalKillCount()

    local kills = LT_GetKills();
    
    local count = 0;
    
    foreach (kills, function(k,v)
    
        count = count + getn(v.TimesKilled);
    
    end);

    return count;

end


------------------------------------------------------------------------------
-- GetTooltipSummary
-- Get the text to display in the tooltip.
------------------------------------------------------------------------------

function LT_GetTooltipSummary()

    -- Use the tooltip mode to decide what to output.
    
    local settings = LT_GetSettings();
    local mode = settings.TooltipMode;

    if (mode == 1) then
        return LT_GetItemsTooltipSummary();
    elseif (mode == 2) then
        return LT_GetKillsTooltipSummary();
    elseif (mode == 3) then
        return LT_GetPlayersTooltipSummary();
    end
    
    -- Error: Should never happen
    return "Unknown tooltip mode";

end


------------------------------------------------------------------------------
-- NextTooltipMode
-- Change the tooltip mode.
------------------------------------------------------------------------------

function LT_NextTooltipMode()

    local settings = LT_GetSettings();

    local mode = settings.TooltipMode + 1;

    if (mode > LT_MaxTooltipMode) then
        mode = LT_MinTooltipMode;
    end
    
    settings.TooltipMode = mode;
    LT_FireChange();

end


------------------------------------------------------------------------------
-- GetKillsTooltipSummary
-- Get the text to display in the tooltip.
------------------------------------------------------------------------------

function LT_GetKillsTooltipSummary()

    local text = "";
    
    local killTextList = LT_GetSortedKillSummary();
    foreach(killTextList, function(k,killText) 
        text = text .. killText .. "\n"
    end);
    
    return text;

end


------------------------------------------------------------------------------
-- GetPlayersTooltipSummary
-- Get the text to display in the tooltip.
------------------------------------------------------------------------------

function LT_GetPlayersTooltipSummary()

    local text = "";
    
    local playerTextList = LT_GetSortedPlayerSummary();
    foreach(playerTextList, function(k,playerText) 
        text = text .. playerText .. "\n"
    end);
    
    return text;

end


------------------------------------------------------------------------------
-- GetItemsTooltipSummary
-- Get the text to display in the tooltip.
------------------------------------------------------------------------------

function LT_GetItemsTooltipSummary()

    local settings = LT_GetSettings();
   
    -- Put together a list of the items looted sorted by quality.
    local itemsByQuality = LT_GetItemsByQuality(); 
    
    local totalValue = 0;
    local playerValue = 0;
    local textByQuality = {};
    local qualityHeadingInfo = {};
    local currentPlayer = UnitName("player")

    -- The results come back unsorted.  We need to walk through in a specific order    
    for quality = LT_MaxQuality, LT_MinQuality, -1 do

        itemsInBucket = itemsByQuality[quality];

        if (itemsInBucket ~= nil) then
            local qualityName = LT_QUALITY_NAME[tostring(quality)];

            local qualityColor = LT_QualityColors[tostring(quality)];

            local contentText = "";
            local valueInGroup = 0;
            local countInGroup = 0;

            local itemTextList = {};

            -- Get info from each item
            foreach(itemsInBucket, function(k, item)

                local itemText, itemCount, itemTotalValue, itemPlayerValue = LT_GetItemSummary(item, settings.QualityThreshold, currentPlayer, qualityColor);

                countInGroup = countInGroup + itemCount;
                valueInGroup = valueInGroup + itemTotalValue;
                playerValue = playerValue + itemPlayerValue;

                -- Add the item into the sorted array
                if (itemText ~= nil) then
                    LT_InsertSorted(itemTextList, itemText, LT_StrCmp);
                end

            end);

            -- Append the sorted results
            foreach(itemTextList, function(k,itemText) 
                contentText = contentText .. itemText .. "\n"
            end);

            -- Group label
            if (countInGroup > 0) then
                totalValue = totalValue + valueInGroup;
            
                local headingInfo = {};
                headingInfo.Name=qualityName;
                headingInfo.Color=qualityColor;
                headingInfo.Count=countInGroup; 
                headingInfo.Value=valueInGroup;
                
                qualityHeadingInfo[quality] = headingInfo;

            end

            textByQuality[quality] = contentText;
        end
    end

    -- Start the output text string
    local text = "";

    -- Add a group total value label
    if (totalValue > 0) then
        local valueString = LT_GetValueString(totalValue, true);
        
        -- Add a player total value label
        if (playerValue ~= totalValue) then
            local playerValueString = LT_GetValueString(playerValue, true);
            if (playerValueString == "") then
                playerValueString = 0;
            end

            text = text .. string.format(LT_TOOLTIP_VALUE2, valueString, playerValueString);
        else
            text = text .. string.format(LT_TOOLTIP_VALUE, valueString);
        end
        
        text = text .. "\n";
    end

    local qualityHeadingsString = nil;

    -- Quality headings
    for quality = LT_MaxQuality, LT_MinQuality, -1 do
        local headingInfo = qualityHeadingInfo[quality];
        if (headingInfo ~= nil) then
        
            -- Get a colored string of the value sum in this rarity group
            if (headingInfo.Value > 0) then
                local percent = (headingInfo.Value / totalValue) * 100;
                local percentString = string.format("%d%%", percent);
                local headingString = string.format("%s (%s)", LT_ColorText(percentString, headingInfo.Color), LT_GetValueString(headingInfo.Value, true));
            
                -- Format:
                --  Percent Name (TotalValue)
                
                qualityHeadingsString = LT_StrAppend(qualityHeadingsString, headingString, ", ");
            end
            
        end
    end
    
    if (qualityHeadingsString ~= nil) then
        text = text .. string.format(LT_TOOLTIP_BREAKDOWN, qualityHeadingsString) .. "\n";
    end

    -- Append the full info, sorted by quality group
    for quality = LT_MaxQuality, LT_MinQuality, -1 do
        if (textByQuality[quality] ~= nil) then
            text = text .. textByQuality[quality];
        end
    end

    return text;

end


------------------------------------------------------------------------------
-- GetRecipientsString
-- Get a string representation of the recipients of an item.
------------------------------------------------------------------------------

function LT_GetRecipientsString(item, default, separator)

    local recipients = default;

    if (item.Recipients ~= nil) then
    
        -- Walk the recipients list, building up a recipient string
        recipients = nil;
        foreach(item.Recipients, function(recipientName, recipientCount) 
            
            -- Format: Name (CountReceived)
            local recipient = recipientName .. " (" .. recipientCount .. ")";
            
            -- Append this entry to the list
            if (recipients ~= nil) then
                recipients = recipients .. separator .. recipient; 
            else
                recipients = recipient;
            end
            
        end);

    end
    
    return recipients;
end


------------------------------------------------------------------------------
-- GetSortedItemSummary
-- Gets a sorted list of outputs GetItemSummary 
------------------------------------------------------------------------------

function LT_GetSortedItemSummary()

    local items = LT_GetItems();
    
    -- Get the item summaries and put them into a sorted list    
    local itemSummaries = {};
    foreach(items, function(k,v) 
        local summary = LT_GetItemSummary(v);
        LT_InsertSorted(itemSummaries, summary, LT_StrCmp);
    end);
    
    return itemSummaries;

end


------------------------------------------------------------------------------
-- GetSortedKillSummary
-- Gets a sorted list of outputs GetKillSummary 
------------------------------------------------------------------------------

function LT_GetSortedKillSummary()

    local kills = LT_GetKills();

    -- Walk through the kills and get info on each one
    local killTextList = {};
    foreach(kills, function(k,v) 
        LT_InsertSorted(killTextList, LT_GetKillSummary(v), LT_StrCmp); 
    end);
    
    return killTextList;
    
end


------------------------------------------------------------------------------
-- GetSortedPlayerSummary
-- Gets a sorted list of outputs GetPlayerSummary 
------------------------------------------------------------------------------

function LT_GetSortedPlayerSummary()

    local players = LT_GetPlayers();
    local totalCountString, playerCountString = LT_GetTotalItemCountString();

    -- Walk through the kills and get info on each one
    local playerTextList = {};
    foreach(players, function(k,v) 
        LT_InsertSorted(playerTextList, LT_GetPlayerSummary(v, playerCountString[k]), LT_StrCmp); 
    end);
    
    return playerTextList;

end


------------------------------------------------------------------------------
-- OutputItemsSummary
-- Output a summary of all items to the console.
------------------------------------------------------------------------------

function LT_OutputItemsSummary(output)

    if (output == nil) then
        LT_DebugMessage(2, "Redirecting to standard output in LT_OutputItemsSummary");
        output = LT_StdOut;
    end

    -- Get the item summaries and put them into a sorted list    
    local itemTextList = LT_GetSortedItemSummary();
    foreach(itemTextList, function(k,v) 
        output.Write(v); 
    end);

end


------------------------------------------------------------------------------
-- OutputKillsSummary
-- Output a summary of all kills to the console.
------------------------------------------------------------------------------

function LT_OutputKillsSummary(output)

    if (output == nil) then
        LT_DebugMessage(2, "Redirecting to standard output in LT_OutputKillsSummary");
        output = LT_StdOut;
    end
    
    local killTextList = LT_GetSortedKillSummary();
    foreach(killTextList, function(k,v) 
        output.Write(v); 
    end);

end


------------------------------------------------------------------------------
-- OutputPlayersSummary
-- Output a summary of all players to the console.
------------------------------------------------------------------------------

function LT_OutputPlayersSummary(output)

    if (output == nil) then
        LT_DebugMessage(2, "Redirecting to standard output in LT_OutputKillsSummary");
        output = LT_StdOut;
    end

    local playerTextList = LT_GetSortedPlayerSummary();
    foreach(playerTextList, function(k,v) 
        output.Write(v); 
    end);

end

