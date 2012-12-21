--===========================================================================--
----------------------------  LootTracker by PNB  ----------------------------
--===========================================================================--
-- LootTrackerQueryUI.lua
--
-- Code behind the query UI
--===========================================================================--

------------------------------------------------------------------------------
-- DoQuery
------------------------------------------------------------------------------

LT_QueryResultData = {};

function LT_DoQuery(query)

    LT_QueryResultData = {};
    
    local queryLowercase = strlower(query);
    
    if (queryLowercase == LT_QUERY_TARGETS or queryLowercase == LT_QUERY_LOOT) then

        LT_WriteBuffer = "";

        -- forward these on to the standard output handler
        LT_OutputSummary(query, LT_BufferOut);
        
        LT_QueryResultText:SetText(LT_WriteBuffer);
        LT_QueryResult:AddMessage(LT_WriteBuffer);
        LT_WriteBuffer = "";

    else
        -- Do a search through all the item/kill/player keys and list all the matches
    
        local items = LT_GetItems();
        local kills = LT_GetKills();
        local players = LT_GetPlayers();
        
        local itemMatches = {};
        local killMatches = {};
        local playerMatches = {};
        
        if (queryLowercase == LT_QUERY_ITEMS) then
            foreach(items, function(k,v)
                tinsert(itemMatches, k);
            end);
        elseif (queryLowercase == LT_QUERY_KILLS) then
            foreach(kills, function(k,v)
                tinsert(killMatches, k);
            end);
        elseif (queryLowercase == LT_QUERY_PLAYERS) then
            foreach(players, function(k,v)
                tinsert(playerMatches, k);
            end);
        else
            itemMatches = LT_GetMatchingKeys(items, query);
            killMatches = LT_GetMatchingKeys(kills, query);
            playerMatches = LT_GetMatchingKeys(players, query);
        end
        
        foreach(itemMatches, function(k,v)
            local data = {};
            data.Type = "Item";
            data.Object = items[v];
            data.Description = LT_GetItemSummary(data.Object);
            
            LT_InsertSorted(LT_QueryResultData, data, LT_DataCmp);
        end);
        foreach(killMatches, function(k,v)
            local data = {};
            data.Type = "Kill";
            data.Object = kills[v];
            data.Description = LT_GetKillSummary(data.Object);
            
            LT_InsertSorted(LT_QueryResultData, data, LT_DataCmp);
        end);
        foreach(playerMatches, function(k,v)
            local data = {};
            data.Type = "Player";
            data.Object = players[v];
            data.Description = LT_GetPlayerSummary(data.Object);
            
            LT_InsertSorted(LT_QueryResultData, data, LT_DataCmp);
        end);
        
        LT_QueryResultText:SetText("");
        LT_UpdateQueryScroll();
    end

end


------------------------------------------------------------------------------
-- DataCmp
------------------------------------------------------------------------------

function LT_DataCmp(a, b)

    if ((a == nil) or (b == nil)) then
        return 1;
    end
    
    if (a.Type ~= b.Type) then
    
        return LT_StrCmp(a.Type, b.Type);
    
    else
        
        if (a.Type == "Item") then
            return LT_ItemCmp(a.Object, b.Object);
        else
            return LT_NameCmp(a.Object, b.Object);
        end
    
    end

end


------------------------------------------------------------------------------
-- ItemCmp
------------------------------------------------------------------------------

function LT_ItemCmp(a, b)

    if ((a == nil) or (b == nil)) then
        return 1;
    end

    local qualityDiff = b.Quality - a.Quality;
    
    if (qualityDiff ~= 0) then
        return qualityDiff;
    end
    
    return LT_NameCmp(a, b);

end


------------------------------------------------------------------------------
-- NameCmp
------------------------------------------------------------------------------

function LT_NameCmp(a, b)

    return LT_StrCmp(a.Name, b.Name);

end


------------------------------------------------------------------------------
-- UpdateQueryScroll
------------------------------------------------------------------------------

LT_SCROLL_QUERYITEMHEIGHT = 14;
LT_SCROLL_QUERYVISIBLECOUNT = 25;

function LT_UpdateQueryScroll()

    local offset = FauxScrollFrame_GetOffset(LT_QueryScrollFrame);

    local numItems = getn(LT_QueryResultData);
    
    FauxScrollFrame_Update(LT_QueryScrollFrame, numItems, LT_SCROLL_QUERYVISIBLECOUNT, LT_SCROLL_QUERYITEMHEIGHT, nil, nil, nil, nil, LT_QueryScrollFrame:GetWidth(), LT_QueryScrollFrame:GetHeight());
    
    -- Fill in the buttons
	for i=1, LT_SCROLL_QUERYVISIBLECOUNT, 1 do

		local index = i + offset;
		local button = getglobal("LT_QueryButton" .. i);
		assert(button ~= nil);
		
		local data = LT_QueryResultData[index];
		
		if ((index <= numItems) and (data ~= nil)) then
		    local description = data.Description;
		    
		    local text = getglobal("LT_QueryButton" .. i .. "Text");
		    assert(text ~= nil);
		    text:SetText(description);
		    
		    button.Data = data;
	        button:Show();
	    else
	        button:Hide();
	    end

	end

end


------------------------------------------------------------------------------
-- QueryButtonClicked
------------------------------------------------------------------------------

function LT_QueryButtonClicked(button)

    local data = button.Data;
    
    if (data.Type == "Item") then
    
        LT_SetItem(data.Object);
    
    elseif (data.Type == "Kill") then
    
        LT_SetKill(data.Object);
    
    elseif (data.Type == "Player") then
    
        LT_SetPlayer(data.Object);

    end
    
end

