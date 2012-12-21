--===========================================================================--
----------------------------  LootTracker by PNB  ----------------------------
--===========================================================================--
-- LootTracker.lua
--
-- Primary entry points to the AddOn
--===========================================================================--

--===========================================================================--
-- Constants
--===========================================================================--

LT_Version              = "1.5.1";

LT_MinTooltipMode       = 1;
LT_MaxTooltipMode       = 3;

LT_QualityColors = {
    ["-2"] = {r=0.00, g=0.88, b=1.00},
    ["-1"] = {r=0.89, g=0.82, b=0.39},
    ["0"]  = {r=0.50, g=0.50, b=0.50},
    ["1"]  = {r=1.00, g=1.00, b=1.00},
    ["2"]  = {r=0.12, g=1.00, b=0.00},
    ["3"]  = {r=0.00, g=0.44, b=0.87},
    ["4"]  = {r=0.64, g=0.21, b=0.93},
    ["5"]  = {r=1.00, g=1.00, b=1.00}
};

LT_MinQuality = -2
LT_MaxQuality = 5;

LT_MoneyColors = {
    [0] = {r=0.89, g=0.82, b=0.39},
    [1] = {r=0.71, g=0.71, b=0.71},
    [2] = {r=0.66, g=0.33, b=0.11}
};

LT_White = {r=1.00, g=1.00, b=1.00};


--===========================================================================--
-- Saved Variables
-- These are the values that will be persisted from session to session.
--===========================================================================--

------------------------------------------------------------------------------
-- LT_Data holds all data on items, kills, and players for the current session
-- and for any other saved sessions.
-- TODO: Make this also forked per-character
------------------------------------------------------------------------------
LT_Data = { }
-- ["Realm - Player"]
--   ["SessionName"]
--     Items
--       ["ItemName"]
--         Name
--         Quality
--         Value
--         Zones (list)
--         TimesLooted (list)
--         Recipients (list)
--         Sources (list)
--     Kills
--       ["KillName"]
--         Name
--         Level
--         TimesKilled (list)
--         Drops (list)
--     Players
--       ["PlayerName"]
--         Name
--         Level
--         TimesKilled (list)
--         LootReceived (list)
--         Gear (list)

------------------------------------------------------------------------------
-- LT_Settings holds configuration values.
------------------------------------------------------------------------------
LT_Settings = { }
-- ["Realm - Player"]
--   CurrentSession
--   DebugLevel
--   JustMyLoot
--   ChatColor
--   QualityThreshold
--   TooltipShowItems
--   TooltipShowKills
--   TooltipShowPlayers
--   IgnoreCraftLoot
--   IgnoreQuestLoot
--   IgnoreVendorLoot


--===========================================================================--
-- Globals
-- These values are global, but not saved when the session ends.
--===========================================================================--

LT_RealmAndPlayer       = "";
LT_ChangeListeners      = nil;

------------------------------------------------------------------------------
-- LT_PendingLoot holds onto any items we've seen in a loot window, but 
-- haven't yet linked to a recipient.
------------------------------------------------------------------------------
LT_PendingLoot = {};
-- ["ItemName"]
--   Name
--   Source
--   Quantity (sometimes)
--   Value (sometimes)

------------------------------------------------------------------------------
-- LT_PendingLootBySlot holds the same information as LT_PendingLoot, but its
-- indexed by the original loot slot index, and the table is cleared as soon
-- as the loot window is closed.  This table is used to handle the LootRemoved
-- event.
------------------------------------------------------------------------------
LT_PendingLootBySlot = {};
-- ["Slot"]


------------------------------------------------------------------------------
-- LT_PendingTarget holds onto any units we've targeted.
------------------------------------------------------------------------------
LT_PendingTargets = {};
-- ["TargetName"]
--   Class
--   Level


--===========================================================================--
-- Frame Hooks
-- These are the functions linked from LootTracker.xml
--===========================================================================--

------------------------------------------------------------------------------
-- OnLoad
-- Invoked when the addon is loaded.  Gives us a chance to register for any 
-- events we might care about.
------------------------------------------------------------------------------

function LootTracker_OnLoad()

    this:RegisterEvent("VARIABLES_LOADED");
    this:RegisterEvent("ADDON_LOADED");
    
    this:RegisterEvent("CHAT_MSG_LOOT");
    this:RegisterEvent("CHAT_MSG_MONEY");
    this:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLY_DEATH");
    this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
    this:RegisterEvent("CHAT_MSG_SYSTEM");
    this:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE");
    this:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN");
    this:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN");
    this:RegisterEvent("CHAT_MSG_SKILL");

    this:RegisterEvent("PLAYER_TARGET_CHANGED");
    
    this:RegisterEvent("LOOT_OPENED");
    this:RegisterEvent("LOOT_CLOSED");
    this:RegisterEvent("LOOT_SLOT_CLEARED");

end


------------------------------------------------------------------------------
-- OnEvent
-- Invoked when any of our registered events are fired
------------------------------------------------------------------------------

function LootTracker_OnEvent(event, arg1)

    if (event == "VARIABLES_LOADED") then
        LT_OnStartup();
        return;
    end
    
    if (event == "ADDON_LOADED") then
        return;
    end

    if (event == "CHAT_MSG_LOOT") then
        LT_OnLootMessage(arg1);
        return;
    end
    
    if (event == "CHAT_MSG_MONEY") then
        LT_OnMoneyMessage(arg1);
        return;
    end
    
    if (event == "CHAT_MSG_COMBAT_FRIENDLY_DEATH") then
        LT_OnFriendlyDeathMessage(arg1);
        return;
    end
    
    if (event == "CHAT_MSG_COMBAT_HOSTILE_DEATH") then
        LT_OnHostileDeathMessage(arg1);
        return;
    end
    
    if (event == "CHAT_MSG_SYSTEM") then
        LT_OnSystemMessage(arg1);
        return;
    end
    
    if (event == "CHAT_MSG_COMBAT_FACTION_CHANGE") then
        LT_OnFactionChange(arg1);
        return;
    end
    
    if (event == "CHAT_MSG_COMBAT_HONOR_GAIN") then
        LT_OnGainHonor(arg1);
        return;
    end
    
    if (event == "CHAT_MSG_COMBAT_XP_GAIN") then
        LT_OnGainExperience(arg1);
        return;
    end
    
    if (event == "CHAT_MSG_SKILL") then
        LT_OnSkillMessage(arg1);
        return;
    end
    
    if (event == "LOOT_OPENED") then
        LT_OnLootBegin();
        return;        
    end
    
    if (event == "LOOT_CLOSED") then
        LT_OnLootEnd();
        return;
    end
    
    if (event == "LOOT_SLOT_CLEARED") then
        LT_OnLootSlotCleared(arg1);
        return;
    end
    
    if (event == "PLAYER_TARGET_CHANGED") then
        LT_OnTargetChanged();
        return;
    end
    
    LT_DebugMessage(2, "Unexpected event: " .. event);

end



--===========================================================================--
-- Event Handlers
--===========================================================================--

------------------------------------------------------------------------------
-- OnStartup
------------------------------------------------------------------------------

function LT_OnStartup()

    -- Hook into console commands
    SlashCmdList["LT_"] = LT_OnSlashCommand;
    
    
    -- Get realm and player names
    local realm   =  GetCVar("realmName");
    local player  =  UnitName("player");
    LT_RealmAndPlayer = realm .. " - " .. player;

    
    -- Initialize the LT_Settings structure
    local settings = LT_GetSettings();
    
    if (settings.CurrentSession == nil) then
        settings.CurrentSession = LT_DEFAULT_SESSIONNAME;
    end
    
    if (settings.DebugLevel == nil) then
        settings.DebugLevel = 0;
    end
    
    if (settings.JustMyLoot == nil) then
        settings.JustMyLoot = false;
    end
    
    if (settings.ChatColor == nil) then
        settings.ChatColor = {r=0.78,g=0.55,b=1.0};
    else
        -- Convert from 0-255 range to 0-1 range
        if (settings.ChatColor.r > 1.0) then
            settings.ChatColor.r = settings.ChatColor.r / 255;
        end
        if (settings.ChatColor.g > 1.0) then
            settings.ChatColor.g = settings.ChatColor.g / 255;
        end
        if (settings.ChatColor.b > 1.0) then
            settings.ChatColor.b = settings.ChatColor.b / 255;
        end
    end
    
    if (settings.QualityThreshold == nil) then
        settings.QualityThreshold = 2;
    end
    
    if (settings.TooltipMode == nil) then
        settings.TooltipMode = LT_MinTooltipMode;
    end
    if (settings.TooltipShowItems == nil) then
        settings.TooltipShowItems = true;
    end
    if (settings.TooltipShowKills == nil) then
        settings.TooltipShowKills = true;
    end
    if (settings.TooltipShowPlayers == nil) then
        settings.TooltipShowPlayers = false;
    end
    
    if (settings.IgnoreCraftLoot == nil) then
        settings.IgnoreCraftLoot = true;
    end
    if (settings.IgnoreQuestLoot == nil) then
        settings.IgnoreQuestLoot = false;
    end
    if (settings.IgnoreVendorLoot == nil) then
        settings.IgnoreVendorLoot = true;
    end

    -- Initialize the LT_Data structure
    if (LT_Data == nil) then
        LT_Data = {};
    end

    -- Check the version    
    LT_ValidateSession();
    
    
    -- Initialize the settings UI
    -- TODO: Does this really do anything?
    UIPanelWindows["LT_SettingsUI"] = {area = "center", pushable = 0};
    
    
    -- Output a "We've loaded" message
    -- TODO: Why isn't this appropriately colored?
    LT_Message(string.format(LT_STARTUP, LT_Version));
    
end


------------------------------------------------------------------------------
-- OnLootMessage
-- There's been a loot message in chat - process it.
------------------------------------------------------------------------------

function LT_OnLootMessage(text)

    LT_DebugMessage(4, "Raw Loot Message: " .. text);
    local settings = LT_GetSettings();

    -- SomeOtherPlayer receives loot: [Heavy Leather]
    local beginMatch, endMatch, recipient, itemLink = string.find(text, LT_LOOT_RECEIVED);
    
    if (beginMatch) then
    
        LT_OnParsedLootMessage(recipient, itemLink);

        return;
    end
    
    -- You receive loot: [Heavy Leather]
    local beginMatch, endMatch, itemLink = string.find(text, LT_LOOT_RECEIVED_YOU);
    
    if (beginMatch) then
    
        LT_OnParsedLootMessage(LT_YOU, itemLink);

        return;
    end
    
    
    -- You receive item: [Warlords Deck]
    local beginMatch, endMatch, itemLink = string.find(text, LT_LOOT_ITEM);
    
    if (beginMatch) then
    
        if (not settings.IgnoreVendorLoot) then
    
            -- This match covers both bought items and combined items (like Warlords Deck).
            -- We need the setting to disable it for people who don't want to include 
            -- purchased ammo etc., but it'd be nice to be able to sort out true vendor
            -- items from quest created items.
        
            local item, player = LT_OnParsedLootMessage(LT_YOU, itemLink);
            
            -- Mark the source as "Vendor"
            LT_AddSource(item, LT_SOURCE_VENDOR, 1);
            
        else
            LT_DebugMessage(2, "Ignoring vendor loot.");
        end

        return;
    end
    
    -- "You create: [Copper Bar]"   
    local beginMatch, endMatch, itemLink = string.find(text, LT_LOOT_CREATED);
    if (beginMatch) then
    
        if (not settings.IgnoreCraftLoot) then
    
            -- Keep processing the loot message
            local item, player = LT_OnParsedLootMessage(LT_YOU, itemLink);
            
            -- Mark the source as "Craft"
            LT_AddSource(item, LT_SOURCE_CRAFT, 1);

        else
            LT_DebugMessage(2, "Ignoring craft loot.");
        end
    
        return;
    end
    
    -- "You won [Meaty Bat Wing]"
    local beginMatch, endMatch, recipient, itemLink = string.find(text, LT_LOOT_WON);
    if (beginMatch) then

        -- TODO: Do something with this message
        LT_DebugMessage(1, string.format("%s won %s", recipient, itemLink));

    end
    
    LT_DebugMessage(2, "Loot message did not match pattern: " .. text);

end


------------------------------------------------------------------------------
-- OnParsedLootMessage
-- Process a loot message.
------------------------------------------------------------------------------

function LT_OnParsedLootMessage(recipientName, itemLink)

    -- This shouldn't happen, but validate that we got our out parameters.
    if (recipientName == nil) then
        LT_DebugMessage(2, "Recipient was nil");
        return;
    end
    if (itemLink == nil) then
        LT_DebugMessage(2, "Item link was nil");
        return;
    end

    -- Map "You" to a player name
    if (recipientName == LT_YOU) then
        recipientName = UnitName("player");
    else
        -- If we're configured to only consider local loot, and this isn't
        -- going to us, bail now.
        if (LT_IsPlayerSolo()) then
            LT_DebugMessage(2, "Ignoring loot going to another player.");
            return;
        end
    end
    
    -- Get the Id from the link
    local itemId = LT_ExtractItemIDFromChatLink(itemLink);
    
    LT_DebugMessage(4, "Extracted item id: " .. itemId);
    
    local item, quantity = LT_CreateItem(itemId);
    local player         = LT_CreatePlayer(recipientName);
    
    -- Bail out if we were unable to create either an item or player object.
    if (item == nil) then
        LT_DebugMessage(2, "Error creating item object");
        return;
    end
    if (player == nil) then
        LT_DebugMessage(2, "Error creating player object");
        return;
    end
    
    for i = 1, quantity do
        LT_AddLootToPlayer(item, player);
    end
    
    return item, player;

end


------------------------------------------------------------------------------
-- OnFriendlyDeathMessage
-- There's been a death message in chat - process it.
------------------------------------------------------------------------------

function LT_OnFriendlyDeathMessage(text)

    LT_DebugMessage(4, "Raw (Friendly) Death Message: " .. text);
    
    local beginMatch, endMatch, deceased = string.find(text, LT_FRIENDLY_DEATH);

    if (beginMatch) then
        -- This shouldn't happen, but validate that we got our out parameters.
        if (deceased == nil) then
            LT_DebugMessage(2, "Deceased was nil");
            return;
        end

        local unitId = nil;
        
        -- Map "You" to a player name
        if (deceased == LT_YOU) then
            deceased = UnitName("player");
            unitId = "player";
        else
            unitId = LT_GetPlayerUnitID(deceased);
        end
        
        if (unitId == nil) then
            LT_DebugMessage(2, "Unable to get UnitID for player: " .. deceased);
            return;
        end
        
        -- We don't want to bother logging non-party deaths.
        if (not UnitInParty(unitId) and not UnitInRaid(unitId)) then
            LT_DebugMessage(2, "Ignoring death of non-party character: " .. deceased);
        end
        
        -- Create an entry for this player if there isn't one already.
        local player = LT_CreatePlayer(deceased);

        local timeOfDeath = date();
            
        -- Log the time of death.
        if (player.TimesKilled == nil) then
            player.TimesKilled = { timeOfDeath };
        else
            table.insert(player.TimesKilled, timeOfDeath);
        end
        
        LT_DebugMessage(2, "Player died: " .. player.Name);
        
        return;
    else
        LT_DebugMessage(3, "Friendly death message did not match pattern: " .. text);
    end

end


------------------------------------------------------------------------------
-- OnHostileDeathMessage
-- There's been a death message in chat - process it.
------------------------------------------------------------------------------

function LT_OnHostileDeathMessage(text)

    LT_DebugMessage(4, "Raw (Hostile) Death Message: " .. text);
    
    local beginMatch, endMatch, deceased = string.find(text, LT_HOSTILE_DEATH);

    if (beginMatch) then
        -- This shouldn't happen, but validate that we got our out parameters.
        if (deceased == nil) then
            LT_DebugMessage(2, "Deceased was nil");
            return;
        end
        
        -- TODO: If this kill did not come from our group, don't count it.
        --       Use tapped state to detect this... somehow?
        
        -- Log this kill
        kill = LT_CreateKill(deceased);
        
        return;
    else
        LT_DebugMessage(3, "Hostile death message did not match pattern: " .. text);
    end

end


------------------------------------------------------------------------------
-- OnSystemMessage
-- There's been a system message in chat - process it.
------------------------------------------------------------------------------

function LT_OnSystemMessage(text)

    LT_DebugMessage(4, "Raw System Message: " .. text);

    -- Received item: [Super Duper Quest Reward]
    local beginMatch, endMatch, itemLink = string.find(text, LT_RECEIVED_ITEM);
    if (beginMatch) then
    
        local settings = LT_GetSettings();
        if (not settings.IgnoreQuestLoot) then
    
            -- This shouldn't happen, but validate that we got our out parameters.
            if (itemLink == nil) then
                LT_DebugMessage(2, "Link was nil");
                return;
            end
            
            -- Keep processing the loot message
            local item, player = LT_OnParsedLootMessage(LT_YOU, itemLink);
            
            -- Mark the source as "Quest"
            LT_AddSource(item, LT_SOURCE_QUEST, 1);

        else
            LT_DebugMessage(2, "Ignoring quest loot.");
        end
    
        return;
    end
    
    -- Received 7 Silver.
    local beginMatch, endMatch, amount = string.find(text, LT_RECEIVED_MONEY);
    if (beginMatch) then
    
        local settings = LT_GetSettings();
        if (not settings.IgnoreQuestLoot) then
        
            LT_DebugMessage(2, "Quest money reward: " .. tostring(amount));
    
            local item = LT_OnMoneyLootText(amount, false);

            -- Mark the source as "Quest"
            LT_AddSource(item, LT_SOURCE_QUEST, 1);
            
        else
            LT_DebugMessage(2, "Ignoring quest money reward.");
        end
    
        return;
    end
    
    -- Discovered Ratchet: 105 experience gained
    local beginMatch, endMatch, amount = string.find(text, LT_EXPERIENCE_GAINED_EXPLORE);
    if (beginMatch) then
    
        LT_OnGainExperienceAmount(tonumber(amount), LT_SOURCE_EXPLORATION);
        
        return;

    end
    
    -- Experience gained: 1950
    local beginMatch, endMatch, amount = string.find(text, LT_EXPERIENCE_GAINED_QUEST);
    if (beginMatch) then
    
        LT_OnGainExperienceAmount(tonumber(amount), LT_SOURCE_QUEST);
        
        return;

    end
    
    LT_DebugMessage(4, "System message did not match pattern: " .. text);

end


------------------------------------------------------------------------------
-- OnFactionChange
-- There's been a faction message in chat - process it.
------------------------------------------------------------------------------

function LT_OnFactionChange(text)

    LT_DebugMessage(4, "Raw faction change: " .. text);

    -- Your reputation with Timbermaw Hold has very slightly increased (5 reputation gained)
    local beginMatch, endMatch, faction = string.find(text, LT_REPUTATION_FACTION);
    if (beginMatch) then
    
        local beginMatch, endMatch, amount = string.find(text, LT_REPUTATION_GAINED);
        if (beginMatch) then
        
            amount = tonumber(amount);
            
            LT_DebugMessage(2, string.format("Gained %d %s reputation", amount, faction));
            
            LT_OnReputationChange(faction, amount)
            
            return;
        end
    
        local beginMatch, endMatch, amount = string.find(text, LT_REPUTATION_LOST);
        if (beginMatch) then
        
            amount = tonumber(amount);
        
            LT_DebugMessage(2, string.format("Lost %d %s reputation", amount, faction));
            
            LT_OnReputationChange(faction, -amount)
        
        end
        
    end
    
    -- You are now Neutral with Booty Bay
    
    LT_DebugMessage(2, "Faction message did not match pattern: " .. text);

end


------------------------------------------------------------------------------
-- OnGainHonor
-- There's been an honor message in chat - process it.
------------------------------------------------------------------------------

function LT_OnGainHonor(text)

    LT_DebugMessage(4, "Raw honor change: " .. text);
    
    -- Rolbek dies, honorable kill Rank: Knight (Estimated Honor Points: 32)
    local beginMatch, endMatch, amount = string.find(text, LT_HONOR_GAINED_KILL);
    if (beginMatch) then
    
        LT_OnGainHonorAmount(tonumber(amount), LT_SOURCE_KILL);
        return;
    end
    
    -- You have been awarded 198 honor points.
    local beginMatch, endMatch, amount = string.find(text, LT_HONOR_GAINED_AWARD);
    if (beginMatch) then
    
        LT_OnGainHonorAmount(tonumber(amount), nil);
        return;
    end
    
    LT_DebugMessage(1, "Honor message did not match pattern: " .. text);

end


------------------------------------------------------------------------------
-- OnGainExperience
-- There's been an experience message in chat - process it.
------------------------------------------------------------------------------

function LT_OnGainExperience(text)

    LT_DebugMessage(4, "Raw experience change: " .. text);
    
    -- Greater Plainstrider dies, you gain 144 experience. (+72 Rested bonus)
    local beginMatch, endMatch, amount = string.find(text, LT_EXPERIENCE_GAINED_KILL);
    if (beginMatch) then
    
        LT_OnGainExperienceAmount(tonumber(amount), LT_SOURCE_KILL);
        
        return;

    end
    
    -- You gain 440 experience
    local beginMatch, endMatch, amount = string.find(text, LT_EXPERIENCE_GAINED);
    if (beginMatch) then
    
        -- Ignore these and instead use the system message
        LT_DebugMessage(2, "Ignoring duplicate experience message for " .. amount);
        return;

    end
        
    LT_DebugMessage(1, "Experience message did not match pattern: " .. text);

end


------------------------------------------------------------------------------
-- OnSkillMessage
-- There's been an skill message in chat - process it.
------------------------------------------------------------------------------

function LT_OnSkillMessage(text)

    LT_DebugMessage(4, "Raw skill message: " .. text);
    
    -- Your skill in Staves has increased to 64
    local beginMatch, endMatch, skill, value = string.find(text, LT_SKILL_GAINED);
    if (beginMatch) then
    
        value = tonumber(value);
        
        -- We're assuming that skill changes always come in units of one.
        -- If this isn't true we'll need to do more work and remember the old
        -- skill value.
        local amount = 1;
        
        LT_DebugMessage(1, string.format("Skill change: %s, %d", skill, value));
        
        -- Create a fake item entry to represent the experience
        local rawItem = {};
        rawItem.Quality = -2;
        rawItem.Name = string.format(LT_SKILL_TYPE, skill);
        rawItem.Class = LT_SKILL;
        rawItem.SubClass = skill;

        -- Create the real item entry
        local item = LT_CreateItemFromRaw(rawItem, nil);

        if (item ~= nil) then

            local recipient = UnitName("player");

            -- Add the receiving player to the item's Recipients list
            if (item.Recipients == nil) then
                item.Recipients = { };
            end
            LT_AddCountEntry(item.Recipients, recipient, amount);

            return item;

        end
    
        return;
    end
    
    LT_DebugMessage(1, "Skill message did not match pattern: " .. text);

end


------------------------------------------------------------------------------
-- OnMoneyMessage
-- There's been a mmoney loot message in chat - process it.
------------------------------------------------------------------------------

function LT_OnMoneyMessage(text)

    LT_DebugMessage(4, "Raw Money Message: " .. text);

    -- "You loot 1 Silver, 10 Copper"   
    local beginMatch, endMatch, amount = string.find(text, LT_MONEY_LOOT);
    if (beginMatch) then
        -- This shouldn't happen, but validate that we got our out parameters.
        if (amount == nil) then
            LT_DebugMessage(2, "Amount was nil");
            return;
        end
        
        -- Non-shared money

        -- We ignore non-shared loot messages that come from chat if we're in
        -- "solo" mode.  We'll get a LT_OnLootSlotCleared event for those ones 
        -- consistently.  We only get the chat message when it's a shift-click 
        -- loot.
        if (not LT_IsPlayerSolo()) then
            LT_OnMoneyLootText(amount, false);
        else
            LT_DebugMessage(2, "Ignoring loot chat message.");
        end
        
        return;
    end
    
    --  "Your share of the loot is 2 Silver, 21 Copper."
    local beginMatch, endMatch, amount = string.find(text, LT_SHARED_MONEY_LOOT);
    if (beginMatch) then
        -- This shouldn't happen, but validate that we got our out parameters.
        if (amount == nil) then
            LT_DebugMessage(2, "Amount was nil");
            return;
        end
        
        -- Shared money
        LT_OnMoneyLootText(amount, true);
        
        return;
    end
    
    LT_DebugMessage(2, "Money message did not match pattern: " .. text);

end


------------------------------------------------------------------------------
-- OnMoneyLootText
-- Parse and process cash loot
------------------------------------------------------------------------------

function LT_OnMoneyLootText(text, shared)

    -- 1 Gold, 2 Silver, 21 Copper."
    local value, gold, silver, copper = LT_ParseMoney(text);
    
    local sharedString = "";
    if (shared) then
        sharedString = " (shared)"
    end
    LT_DebugMessage(2, "Looted Money" .. sharedString .. ": " .. tostring(gold) .. "g " .. tostring(silver) .. "s " .. tostring(copper) .. "c");
    
    return LT_OnMoneyLoot(value, shared, nil);
    
end


------------------------------------------------------------------------------
-- OnMoneyLoot
-- Process cash loot
------------------------------------------------------------------------------

function LT_OnMoneyLoot(value, shared, source)

    local rawItem = {};
    rawItem.Name = LT_MONEY;
    rawItem.Quality = -1;
    rawItem.Class = LT_MONEY;

    local item = LT_CreateItemFromRaw(rawItem, source);

    if (item ~= nil) then
        if (item.Value == nil) then
            item.Value = 0;
        end

        -- The Value of the Money item is an average drop size.
        -- Add this new loot value into the running average.

        local oldValue = item.Value;
        local newCount = getn(item.TimesLooted);

        local oldTotalMoneyLooted = oldValue * (newCount - 1);
        local newTotalMoneyLooted = oldTotalMoneyLooted + value;
        local newAverage = newTotalMoneyLooted / newCount;

        item.Value = newAverage;

        -- If this is shared loot, go to "Everyone", otherwise go to the local player.
        local recipient = LT_EVERYONE;
        if (not shared) then
            recipient = UnitName("player");
        end

        -- Add the receiving player to the item's Recipients list
        if (item.Recipients == nil) then
            item.Recipients = { };
        end
        LT_AddCountEntry(item.Recipients, recipient, 1);

        return item;

    end

end


------------------------------------------------------------------------------
-- OnReputationChange
-- There has been a reputation gain/loss.
------------------------------------------------------------------------------

function LT_OnReputationChange(faction, amount)

    LT_DebugMessage(1, string.format("Faction gain: %s - %d", faction, amount));

    -- Create a fake item entry to represent the reputation
    local rawItem = {};
    rawItem.Quality = -2;
    
    -- Give separate names for gain/loss
    local formatString = LT_REPUTATION_TYPE;
    if (amount < 0) then    
        formatString = LT_REPUTATION_TYPELOST;
    end
        
    rawItem.Name = string.format(formatString, faction);
    rawItem.Class = LT_REPUTATION;
    rawItem.SubClass = faction;
    

    -- Create the final item entry
    local item = LT_CreateItemFromRaw(rawItem, nil);

    if (item ~= nil) then

        local recipient = UnitName("player");

        -- Add the receiving player to the item's Recipients list
        if (item.Recipients == nil) then
            item.Recipients = { };
        end
        LT_AddCountEntry(item.Recipients, recipient, amount);

        return item;

    end

end


------------------------------------------------------------------------------
-- OnGainExperienceAmount
-- There's been an experience gain.
------------------------------------------------------------------------------

function LT_OnGainExperienceAmount(amount, source)

    LT_DebugMessage(1, string.format("Experience gain: %d (%s)", amount, source));
    
    -- Create a fake item entry to represent the experience
    local rawItem = {};
    rawItem.Quality = -2;
    rawItem.Name = LT_EXPERIENCE;
    rawItem.Class = LT_EXPERIENCE;

    -- Create the real item entry
    local item = LT_CreateItemFromRaw(rawItem, nil);

    if (item ~= nil) then

        local recipient = UnitName("player");

        -- Add the receiving player to the item's Recipients list
        if (item.Recipients == nil) then
            item.Recipients = { };
        end
        LT_AddCountEntry(item.Recipients, recipient, amount);

        if (source ~= nil) then
            LT_AddSource(item, source, amount);
        else
            LT_DebugMessage(1, "Unspecified source for experience");
        end

        return item;

    end
    
    

end


------------------------------------------------------------------------------
-- OnGainHonorAmount
-- There's been an honor gain.
------------------------------------------------------------------------------

function LT_OnGainHonorAmount(amount, source)

    LT_DebugMessage(1, string.format("Honor gain: %d", amount));
    
    -- Create a fake item entry to represent the honor
    local rawItem = {};
    rawItem.Quality = -2;
    rawItem.Name = LT_HONOR;
    rawItem.Class = LT_HONOR;

    -- Create the real item entry
    local item = LT_CreateItemFromRaw(rawItem, nil);

    if (item ~= nil) then

        local recipient = UnitName("player");

        -- Add the receiving player to the item's Recipients list
        if (item.Recipients == nil) then
            item.Recipients = { };
        end
        LT_AddCountEntry(item.Recipients, recipient, amount);
        
        if (source ~= nil) then
            LT_AddSource(item, source, amount);
        else
            LT_DebugMessage(1, "Unspecified source for honor");
        end

        return item;

    end

end


------------------------------------------------------------------------------
-- OnLootBegin
-- The current player has opened the loot window.
------------------------------------------------------------------------------

function LT_OnLootBegin()

    LT_PendingLootBySlot = {};

    -- Determine the target being looted
    local source = UnitName("target");
    
    if (source == nil) then
        LT_DebugMessage(3, "Looting (Unknown)");
    else
        LT_DebugMessage(3, "Looting " .. source);
    end
    
    local lootCount = GetNumLootItems();
    
    for slot = 1, lootCount, 1 do

        -- Create a pending loot entry
        LT_CreatePendingLoot(slot, source);
    end
    
end


------------------------------------------------------------------------------
-- OnLootEnd
-- The current player has closed the loot window.
------------------------------------------------------------------------------

function LT_OnLootEnd()

    LT_DebugMessage(3, "Done looting");
    
end


------------------------------------------------------------------------------
-- OnLootEnd
-- The current player has closed the loot window.
------------------------------------------------------------------------------

function LT_OnLootSlotCleared(slot)

    LT_DebugMessage(3, "Slot looted: " .. slot);
    
    if (LT_PendingLootBySlot == nil) then
        LT_DebugMessage(2, "Invalid slot looting.  Expected pending loot table to still be valid.");
        return;
    end
    
    local loot = LT_PendingLootBySlot[slot];
    
    if (loot == nil) then
        LT_DebugMessage(2, "Invalid slot looting.  Expected pending loot item to still be valid for slot " .. slot .. ".");
        return;
    end
    
    LT_DebugMessage(4, "Loot cleared: " .. loot.Name .. " (slot " .. slot .. ")");
    
    local settings = LT_GetSettings();
    if (loot.Name == LT_MONEY) then
        -- Disabling because we can't determine at this point if this will
        -- end up being a shared (split) money drop or not.  We will always
        -- get this event for the local player, and so when solo-ing this is
        -- the best event to hook (since the chat message is *not* always
        -- sent).  However, when in a group we don't want to think the local
        -- player will receive 100% of the cash when in fact it will be split.
        if (LT_IsPlayerSolo()) then
            -- Non-shared loot
            local item = LT_OnMoneyLoot(loot.Value, false, loot.Source);
        end
        
        LT_PendingLoot[loot.Name] = nil;
    end
    
    LT_PendingLootBySlot[slot] = nil;
    
end


------------------------------------------------------------------------------
-- OnTargetChanged
-- The current player has changed who they're targeting.
------------------------------------------------------------------------------

function LT_OnTargetChanged()

    LT_CreatePendingTarget();

end


------------------------------------------------------------------------------
-- SlashCommand
-- Handles console commands.
------------------------------------------------------------------------------

function LT_OnSlashCommand(rawArgument)

    local command, value = LT_GetCommandAndValue(rawArgument);
    
    local settings = LT_GetSettings();
    
    if (LT_StrIsNilOrEmpty(command)) then
        command = LT_SLASHCOMMAND_SETTINGS;
    end
    
    if (command == LT_SLASHCOMMAND_DEBUG) then
        
        if (value ~= nil) then
            local level = tonumber(value);
            if (level == nil) then
                LT_Message(LT_SLASHCOMMAND_DEBUG_ERROR);
            else
                settings.DebugLevel = level;
            end
        end
        
        LT_Message(string.format(LT_SLASHCOMMAND_DEBUG_QUERY, settings.DebugLevel));
        return;
        
    elseif (command == LT_SLASHCOMMAND_JUSTMYLOOT) then
    
        if (value ~= nil) then
            settings.JustMyLoot = value;
        else
            LT_Message(string.format(LT_SLASHCOMMAND_JUSTMYLOOT_QUERY, tostring(settings.JustMyLoot)));
        end;
        return;
        
    elseif (command == LT_SLASHCOMMAND_SESSION) then
    
        if (value ~= nil) then
            LT_SetSession(value);
        else
            LT_Message(string.format(LT_SLASHCOMMAND_SESSION_QUERY, settings.CurrentSession));
        end;
            
        return;
        
    elseif (command == LT_SLASHCOMMAND_SESSIONS) then
    
        LT_Message(LT_SLASHCOMMAND_SESSIONS_QUERY);
        LT_MessageIndent();
    
        local sessions = LT_GetAvailableSessions();
        foreach(sessions, function(k,v)
            LT_Message(LT_FormatSessionName(v, true));
        end);
        
        LT_MessageUnindent();
        
        return;
        
    elseif (command == LT_SLASHCOMMAND_EXPORT) then
    
        LT_ExportSession(value);
        return;
        
    elseif (command == LT_SLASHCOMMAND_SUMMARY) then
    
        LT_OutputSummary(value);
        return;
        
    elseif (command == LT_SLASHCOMMAND_CHATCOLOR) then
    
        if (value ~= nil) then
        
            -- TODO: Validate that this parses comma separated RGB values as well as space values,
            --       Because I don't think it does...
            local beginMatch, endMatch, r, g, b = string.find(value, "(%d+)[%s,](%d+)[%s,](%d+)");
            
            if (beginMatch) then
            
                if ((r == nil) or (g == nil) or (b == nil)) then
                    LT_Message(LT_SLASHCOMMAND_CHATCOLOR_ERROR);
                else
                    settings.ChatColor = {};
                    settings.ChatColor.r = r;
                    settings.ChatColor.g = g;
                    settings.ChatColor.b = b;
                end
            else
                LT_Message(LT_SLASHCOMMAND_CHATCOLOR_ERROR);
            end
        end;
        
        LT_Message(string.format(LT_SLASHCOMMAND_CHATCOLOR_QUERY, settings.ChatColor.r, settings.ChatColor.g, settings.ChatColor.b));
        return;
        
    elseif (command == LT_SLASHCOMMAND_THRESHOLD) then
        if (value ~= nil) then
            settings.QualityThreshold = tonumber(value);
            LT_FireChange();
        else
            LT_Message(LT_SLASHCOMMAND_THRESHOLD_ERROR);
        end
        
        LT_Message(string.format(LT_SLASHCOMMAND_THRESHOLD_QUERY, settings.QualityThreshold));
        return;
        
    elseif (command == LT_SLASHCOMMAND_RESET) then
    
        LT_ResetSession(value);
        return;
        
    elseif (command == LT_SLASHCOMMAND_UPDATE) then
    
        if (value ~= nil) then
            LT_UpdateObject(value);
        else
            LT_Message(LT_SLASHCOMMAND_UPDATE_ERROR);
        end
        return;
        
    elseif (command == LT_SLASHCOMMAND_TRANSFER) then
    
        if (value ~= nil) then
            -- /lt transfer playerNameSource playerNameTarget itemName
            local beginMatch, endMatch, playerNameSource, playerNameTarget, itemName = string.find(value, "([^%s]*)%s([^%s]*)%s(.*)");
            if (beginMatch) then
                LT_TransferItem(playerNameSource, playerNameTarget, itemName);
            else
                LT_Message(LT_SLASHCOMMAND_TRANSFER_ERROR);
            end
            
        end
    
        return;
        
    elseif (command == LT_SLASHCOMMAND_SETTINGS) then
    
        if (LT_SettingsUI:IsShown()) then
            HideUIPanel(LT_SettingsUI);
        else
            ShowUIPanel(LT_SettingsUI);
        end
    
        return;
        
    elseif (command == LT_SLASHCOMMAND_HELP) then
    
        -- Fall through to the help code below.

    elseif (rawArgument ~= nil) then
    
        LT_Message(string.format(LT_SLASHCOMMAND_ERROR, rawArgument));
        
    end
    
    -- Show the help
    LT_Message(string.format(LT_HELPMESSAGE_1, LT_Version));
    LT_Message(LT_HELPMESSAGE_2);
    LT_Message(LT_HELPMESSAGE_3);
    LT_Message(LT_HELPMESSAGE_4);
    LT_Message(LT_HELPMESSAGE_5);
    LT_Message(LT_HELPMESSAGE_6);
    LT_Message(LT_HELPMESSAGE_7);
    LT_Message(LT_HELPMESSAGE_8);
    LT_Message(LT_HELPMESSAGE_9);
    LT_Message(LT_HELPMESSAGE_10);
    LT_Message(LT_HELPMESSAGE_11);
    LT_Message(LT_HELPMESSAGE_12);

end


------------------------------------------------------------------------------
-- AddListener
------------------------------------------------------------------------------

function LT_AddListener(event)

    if (LT_ChangeListeners == nil) then
        LT_ChangeListeners = {};
    end

    tinsert(LT_ChangeListeners, event);

end


------------------------------------------------------------------------------
-- RemoveListener
------------------------------------------------------------------------------

function LT_RemoveListener(event)

    if (LT_ChangeListeners == nil) then
        return;
    end

    tremove(LT_ChangeListeners, LT_IndexOf(LT_ChangeListeners, event));

end


------------------------------------------------------------------------------
-- FireChange
------------------------------------------------------------------------------

function LT_FireChange()

    if (LT_ChangeListeners ~= nil) then
        foreach(LT_ChangeListeners, function(k,v)
            v();
        end);
    end

end

