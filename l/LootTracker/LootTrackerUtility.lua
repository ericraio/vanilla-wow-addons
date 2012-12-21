--===========================================================================--
----------------------------  LootTracker by PNB  ----------------------------
--===========================================================================--
-- LootTrackerUtility.lua
--
-- Common utility methods
--===========================================================================--

------------------------------------------------------------------------------
-- AddIfNotPresent
-- Adds the given value to the given table, but only if the table does not
-- already have that value.
------------------------------------------------------------------------------

function LT_AddIfNotPresent(t, value)

    if (LT_TableHasValue(t, value)) then
        return;
    end

    tinsert(t, value);
end


------------------------------------------------------------------------------
-- TableHasValue
-- Checks if the table contains the given value.
------------------------------------------------------------------------------

function LT_TableHasValue(t, value)

    local match = false;
    
    foreach(t, function(k,v)
        if (v == value) then 
            match = true;
            return; 
        end 
    end);
    
    return match;
end


------------------------------------------------------------------------------
-- TableHasKey
-- Checks if the table contains the given key.
------------------------------------------------------------------------------

function LT_TableHasKey(t, key)

    local match = false;
    
    foreach(t, function(k,v) 
        if (k == key) then 
            match = true;
            return;
        end 
    end);
    
    return match;
end


------------------------------------------------------------------------------
-- IndexOf
-- Gets the key for a value in the table.
------------------------------------------------------------------------------

function LT_IndexOf(t, value)

    foreach(t, function(k,v) 
    
        if (v == value) then
            return k;
        end
    
    end);
    
    return nil;

end


------------------------------------------------------------------------------
-- GetCount
-- Because getn(t) doesn't seem to always work...
-- TODO: Figure out if there's a dictionary friendly version of the array
--       oriented getn(t) function.
------------------------------------------------------------------------------

function LT_GetCount(t)

    if (t == nil) then
        return 0;
    end
    
    local count = 0;
    
    foreach(t, function(k,v)
        count = count + 1;
    end);

    return count;

end


------------------------------------------------------------------------------
-- InsertSorted
-- Inserts and item into a table based on the output of some compare function
------------------------------------------------------------------------------

function LT_InsertSorted(t, v, compareFunction)

    if (v == nil) then
        return;
    end
    if (compareFunction == nil) then
        tinsert(t, v)
    end

    local count = getn(t);

    for i = 1, count, 1 do
        local tv = t[i];
        local compare = 1;
        
        if (tv ~= nil) then
            compare = compareFunction(tv, v);
        end
        
        if (compare > 0) then
            tinsert(t, i, v);
            return;
        elseif (compare < 0) then
            -- do nothing
        else
            tinsert(t, i, v);
            return;
        end
    end
    
    tinsert(t, v);

end


------------------------------------------------------------------------------
-- StrCmp
-- String comparison - returns 0 if equal, positive if A is greater, negative
-- if B is greater
------------------------------------------------------------------------------

function LT_StrCmp(a, b)

    local aLen = strlen(a);
    local bLen = strlen(b);

    for i = 1, aLen, 1 do
        local aByte = strbyte(a, i);
        local bByte = strbyte(b, i);

        local compare = 0;
        if (bByte ~= nil) then
            compare = aByte - bByte;
        end
        
        if (compare ~= 0) then
            return compare;
        end
    end
    
    if (aLen > bLen) then
        return 1;
    else
        return -1;
    end

end


------------------------------------------------------------------------------
-- StrAppend
-- Appends A to B, with a separator.
------------------------------------------------------------------------------

function LT_StrAppend(a, b, separator)
    
    if (a == nil) then
        return b;
    else
        return a .. separator .. b;
    end

end


------------------------------------------------------------------------------
-- StrIsNilOrEmpty
-- Checks if the string is nil or empty.
------------------------------------------------------------------------------

function LT_StrIsNilOrEmpty(s)

    return (s == nil) or (s == "")

end

------------------------------------------------------------------------------
-- GetMatchingKeys
-- Returns a list of keys that have a substring match to the query string.
------------------------------------------------------------------------------

function LT_GetMatchingKeys(t, query)

    local matches = {};
    
    local queryLowercase = strlower(query);

    foreach(t, function(k,v)
    
        local keyLowercase = strlower(k);
    
        LT_DebugMessage(5, string.format("Matching \"%s\" against \"%s\"", k, query));
    
        local beginMatch, endMatch = string.find(keyLowercase, queryLowercase);
    
        if (beginMatch) then
            LT_DebugMessage(4, string.format("Matched \"%s\" to \"%s\"", k, query));
            tinsert(matches, k);
        end
    
    end);
    
    return matches;

end

------------------------------------------------------------------------------
-- GetZoneString
-- Gets a nice formatted zone description.
------------------------------------------------------------------------------

function LT_GetZoneString()

    local zoneText      = GetZoneText();
    local subZoneText   = GetSubZoneText();
    
    if ((subZoneText == nil) or (subZoneText == "")) then
        return zoneText;
    end;
    
    return zoneText .. ", " .. subZoneText;

end


------------------------------------------------------------------------------
-- GetCommandAndValue
-- Given a console command, get the verb and target.
------------------------------------------------------------------------------

function LT_GetCommandAndValue(text)

    -- Example: "color 255, 255, 255"
    -- Result:  command = "color"
    --          value   = "255, 255, 255"
    local beginMatch, endMatch, command, value = string.find(text, "([^%s]*)%s(.*)");
    
    -- No match: return the string as it was
    if (command == nil) then
        return text;
    end;
    
    return command, value;

end


------------------------------------------------------------------------------
-- GetPlayerUnitID
-- Gets the UnitID for the player with the given name.  May return nil.
------------------------------------------------------------------------------

function LT_GetPlayerUnitID(name)

    -- TODO: The perf here can't be good.  It'd be better to trap party change
    --       events and just have a cache of UnitName() for all members in the
    --       party up front.
    local testIds = {"player", "party1", "party2", "party3", "party4", "target", 
                     "raid1",  "raid2",  "raid3",  "raid4",  "raid5",  "raid6",  "raid7",  "raid8",  "raid9",  "raid10",
                     "raid11", "raid12", "raid13", "raid14", "raid15", "raid16", "raid17", "raid18", "raid19", "raid20",
                     "raid21", "raid22", "raid23", "raid24", "raid25", "raid26", "raid27", "raid28", "raid29", "raid30",
                     "raid31", "raid32", "raid33", "raid34", "raid35", "raid36", "raid37", "raid38", "raid39", "raid40"};
    
    local unitId = nil;
    
    foreach(testIds, function(k,v)
        local unitName = UnitName(v);
        if (name == unitName) then
            unitId = v;
            return v;
        end
    end);
    
    return unitId;

end


------------------------------------------------------------------------------
-- GetInventoryItem
-- Get an item given the unit and inventory slot.  May return nil.
------------------------------------------------------------------------------

function LT_GetInventoryItem(unitId, slotId)
    
    local inventoryItemLink = GetInventoryItemLink(unitId, slotId);
    
    if (inventoryItemLink == nil) then
        return nil;
    end
    
    LT_DebugMessage(4, "Inventory item link = " .. inventoryItemLink .. " for unit \"" .. unitId .. "\", slot " .. slotId);
    
    
    local beginMatch, endMatch, itemId = strfind(inventoryItemLink, "(%d+):");
    
    LT_DebugMessage(4, "Stripped out item id: " .. itemId);
        
    if (beginMatch == nil) then
        LT_Message("Error parsing item link: " .. inventoryItemLink);
        return nil;
    end
    
    
    local rawItem = LT_GetItem(itemId);
    
    if (rawItem == nil) then
        LT_DebugMessage(2, "Error getting item info from link " .. inventoryItemLink .. " (id = " .. itemId .. ")");
        return nil;
    end

    return rawItem;

end


------------------------------------------------------------------------------
-- GetItem
-- Lookup an item by id and return an object to wrap that.  May return nil.
------------------------------------------------------------------------------

function LT_GetItem(itemId)

    -- Call the WoW API to get the item details
    local name, link, quality, minLevel, class, subClass, maxStack, equipLoc, texture = GetItemInfo(itemId);
    
    if (name == nil) then
        return nil;
    end
    
    
    local rawItem       = {};
    rawItem.Name        = name;
    rawItem.Link        = link;
    rawItem.Quality     = quality;
    rawItem.MinLevel    = minLevel;
    rawItem.Class       = class;
    rawItem.SubClass    = subClass;
    rawItem.MaxStack    = maxStack;
    rawItem.EquipLoc    = equipLoc;
    rawItem.Texture     = texture;

    return rawItem;

end


------------------------------------------------------------------------------
-- GetGear
-- Create a table of all the gear on the given unit.
------------------------------------------------------------------------------

function LT_GetGear(unitId)

    gear = {};

    -- Note: The strings here aren't used for anything in the result.  They're
    -- just here in the code for clarity.
    local slots = {};
    slots[0]="ammo";
    slots[1]="head";
    slots[2]="neck";
    slots[3]="shoulder";
    slots[4]="shirt";
    slots[5]="chest";
    slots[6]="belt";
    slots[7]="legs";
    slots[8]="feet";
    slots[9]="wrist";
    slots[10]="gloves";
    slots[11]="finger 1";
    slots[12]="finger 2";
    slots[13]="trinket 1";
    slots[14]="trinket 2";
    slots[15]="back";
    slots[16]="main hand";
    slots[17]="off hand";
    slots[18]="ranged";
    slots[19]="tabard";
        
    foreach(slots, function(slot,slotName) 
        
        local rawItem = LT_GetInventoryItem(unitId, slot);
    
        if (rawItem ~= nil) then
            LT_DebugMessage(3, "Inventory[" .. slot .. "] " .. rawItem.Name);
            tinsert(gear, rawItem);
        end
    end);
    
    return gear;

end


------------------------------------------------------------------------------
-- LT_ExtractItemIDFromLink
-- Parses an item link to extract the item id.
-- This version based on Auctioneer code.
------------------------------------------------------------------------------

function LT_ExtractItemIDFromLink(link)

    --Format: "item:2673:0:0:0"    
    local beginMatch, endMatch, itemId = string.find(link, "item:(%d+):%d+:%d+:%d+");
    
    if (itemId ~= nil) then
        return tonumber(itemId);
    end
    
    return nil;

end


------------------------------------------------------------------------------
-- ExtractItemIDFromChatLink
-- Parses an item link to extract the item id.
-- This version based on Looto code.
------------------------------------------------------------------------------

function LT_ExtractItemIDFromChatLink(itemLink)

    local beginMatch, endMatch, itemId, itemName = string.find(itemLink, "|H(.*)|h(.*)|h");
    
    if (not beginMatch) then
        LT_DebugMessage(2, "Did not match pattern: " .. itemLink);
        return nil;
    end

    if (itemId == nil) then
        LT_DebugMessage(2, "itemId was nil");
        return nil;
    end

    if (itemName == nil) then
        LT_DebugMessage(2, "itemName was nil");
        return nil;
    end

    return itemId;

end



------------------------------------------------------------------------------
-- ColorText
-- Emits the correct color tags so that the text will be rendered with color.
------------------------------------------------------------------------------

function LT_ColorText(text, color)

    local r = color.r;
    local g = color.g;
    local b = color.b;
    local alpha = color.alpha;

    if alpha == nil then
        alpha = 1.0;
    end

    return "|c" 
        .. format("%02x", alpha * 255)
        .. format("%02x", r * 255)
        .. format("%02x", g * 255)
        .. format("%02x", b * 255)
        .. text .. FONT_COLOR_CODE_CLOSE;
end


------------------------------------------------------------------------------
-- GetValueByCoinType
-- Gets a the gold, silver, copper breakdown of a raw value.
------------------------------------------------------------------------------

function LT_GetValueByCoinType(value)

    -- Split out the g/s/c values
    local gold      = math.floor(value / 10000);
    local silver    = math.mod(math.floor(value / 100), 100);
    local copper    = math.mod(value, 100);
    
    return gold, silver, copper;

end


------------------------------------------------------------------------------
-- GetValueString
-- Gets a text description of a money value.
------------------------------------------------------------------------------

function LT_GetValueString(value, applyColor)

    local gold, silver, copper = LT_GetValueByCoinType(value);
    
    local goldString    = string.format(LT_GOLD, gold);
    local silverString  = string.format(LT_SILVER, silver);
    local copperString  = string.format(LT_COPPER, copper);
    
    -- Apply coloring to the string value
    if (applyColor) then
        goldString   = LT_ColorText(goldString,   LT_MoneyColors[0]);
        silverString = LT_ColorText(silverString, LT_MoneyColors[1]);
        copperString = LT_ColorText(copperString, LT_MoneyColors[2]);
    end
    
    
    local string = nil;
    
    -- Append the Gold value
    if (gold > 0) then
        string = goldString;
    end
    
    -- Append the Silver value
    if (silver > 0) then
        if (string == nil) then
            string = silverString;
        else
            string = string .. " " .. silverString;
        end
    end
    
    -- Append the Copper value
    if (copper > 0) then
        if (string == nil) then
            string = copperString;
        else
            string = string .. " " .. copperString;
        end
    end
    
    -- Don't return nil - always return a valid string
    if (string == nil) then
        string = "";
    end
    
    return string;

end


------------------------------------------------------------------------------
-- MoneyParseHelper
-- Extracts a certain coin value from a money string.
-- (e.g. 1 Gold, 2 Silver, 21 Copper)
------------------------------------------------------------------------------

function LT_MoneyParseHelper(text, coinType, messageOnError)

    local pattern = "(%d*) " .. coinType;
    local beginMatch, endMatch, coinAmount = string.find(text, pattern);
    
    if (beginMatch) then
        local amount = tonumber(coinAmount);
        
        if (amount == nil) then
            LT_DebugMessage(2, "Unable to convert " .. coinAmount .. " " .. coinType .. " to a number");
            return 0;
        end
        
        return amount;
    else
        if (messageOnError) then
            LT_DebugMessage(2, "Money value did not match pattern for " .. coinType .. ": " .. text);
        end
        return 0;
    end

end


------------------------------------------------------------------------------
-- ParseMoney
-- Extracts the total value from a money string.
------------------------------------------------------------------------------

function LT_ParseMoney(text)

    local gold      = LT_MoneyParseHelper(text, LT_COIN_NAME[0], false);
    local silver    = LT_MoneyParseHelper(text, LT_COIN_NAME[1], false);
    local copper    = LT_MoneyParseHelper(text, LT_COIN_NAME[2], false);
    
    -- Get the total (copper) value given the gold/silver/copper contributions
    local value = LT_GetValueFromCoins(gold, silver, copper);
    
    return value, gold, silver, copper;
    
end


------------------------------------------------------------------------------
-- GetValueFromCoins
-- Get the total (copper) value given the gold/silver/copper contributions
------------------------------------------------------------------------------

function LT_GetValueFromCoins(gold, silver, copper)

    return (gold * 10000) + (silver * 100) + (copper);

end


------------------------------------------------------------------------------
-- IsMoneyString
-- Tests if the given text is a money string.
-- (e.g. 1 Gold, 2 Silver, 21 Copper)
------------------------------------------------------------------------------

function LT_IsMoneyString(text)

    local value = LT_ParseMoney(text);

    if (value ~= 0) then
        return true;
    else
        return false;
    end

end


------------------------------------------------------------------------------
-- IsPlayerSolo
------------------------------------------------------------------------------

function LT_IsPlayerSolo()

    local settings = LT_GetSettings()
    if (settings.JustMyLoot) then
        return true;
    end
    
    if (GetNumPartyMembers() > 0) then
        return false;
    end
    
    return true;

end


------------------------------------------------------------------------------
-- GetColoredQualityName
------------------------------------------------------------------------------

function LT_GetColoredQualityName(quality)

    local qualityAsString = tostring(quality);

    local name = LT_QUALITY_NAME[qualityAsString]
    return LT_ColorText(name, LT_QualityColors[qualityAsString]);

end

