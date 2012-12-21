--[[

    PvPLog 
        Author:         Josh Estelle
        Version:        0.4.6
        Last Modified:  2005-04-27
        
]]

-- version information
local VER_NUM = 0;
local VER_SUB = 4;
local VER_REL = 6;

-- Function hooks
local lOriginalChatFrame_OnEvent;

-- Local variables
local variablesLoaded = false;
local initialized = false;

local realm = "";
local player = "";
local plevel = -1;

local NUMRECENT = 10;
local recentTargets = { };

local NUMDAMAGED = 5;
local damagedTargets = { };

local lastDamagerToMe = "";

local lastDing = -1000;

local yourDamageMatch = {
	-- Your damage or healing

    -- ENGLISH
	{ pattern = "Your (.+) hits (.+) for (%d+)", spell = 0, mob = 1, pts = 2 },
	{ pattern = "Your (.+) crits (.+) for (%d+)", spell = 0, mob = 1, pts = 2 },
	{ pattern = "You drain (%d+) (.+) from (.+)", mob = 2, pts = 0, stat = 1 },
	{ pattern = "Your (.+) causes (.+) (%d+) damage", spell = 0, mob = 1, pts = 2 },
	{ pattern = "You reflect (%d+) (.+) damage to (.+)", mob = 2, pts = 0, type = 1 },
	{ pattern = "(.+) suffers (%d+) (.+) damage from your (.+)", spell = 3, mob = 0, 
                                                                 pts = 1, type = 2 },
	{ pattern = "You hit (.+) for (%d+)", mob = 0, pts = 1 },
	{ pattern = "You crit (.+) for (%d+)", mob = 0, pts = 1 }

    -- GERMAN
};

local damageToYouMatch = {
	{ pattern = "(.+)'s (.+) hits you for (%d+)", spell = 1, pts = 2, cause = 0 },
	{ pattern = "(.+)'s (.+) crits you for (%d+)", spell = 1, pts = 2, cause = 0 },
	{ pattern = "(.+) drains (%d+) (.+) from you", pts = 1, stat = 2, cause = 0 },
	{ pattern = "(.+)'s (.+) causes you (%d+) damage", spell = 1, pts = 2, cause = 0 },
	{ pattern = "(.+) reflects (%d+) (.+) damage to you", pts = 1, type = 2, cause = 0 },
	{ pattern = "You suffer (%d+) (.+) damage from (.+)'s (.+)", spell = 3, pts = 0, 
                                                                 type = 1, cause = 2 },
	{ pattern = "(.+) hits you for (%d+)", pts = 1, cause = 0 },
	{ pattern = "(.+) crits you for (%d+)", pts = 1, cause = 0 }
};

local RED     = "|cffff0000";
local GREEN   = "|cff00ff00";
local BLUE    = "|cff0000ff";
local MAGENTA = "|cffff00ff";
local YELLOW  = "|cffffff00";
local CYAN    = "|cff00ffff";
local WHITE   = "|cffffffff";

-- Called OnLoad of the add on
function PvPLogOnLoad()

    PvPLogChatMsg(CYAN .. "PvPLog Loaded, type " .. 
                  RED  .. "/pvplog" .. CYAN .. " for useage");

    -- respond to saved variable load
    this:RegisterEvent("VARIABLES_LOADED");

    -- respond to player entering the world
    this:RegisterEvent("PLAYER_ENTERING_WORLD");

    -- respond to player name update
    this:RegisterEvent("UNIT_NAME_UPDATE");

    -- respond when player dies
    this:RegisterEvent("PLAYER_DEAD"); 

    -- respond to when hostiles die
    this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH"); 

    -- respond when our target changes
    this:RegisterEvent("PLAYER_TARGET_CHANGED");

    -- respond to when you change mouseovers
    this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");

    -- keep track of players level
    this:RegisterEvent("PLAYER_LEVEL_UP");
end

function PvPLogOnEvent()
    -- loads and initializes our variables
    if (event == "VARIABLES_LOADED") then
        variablesLoaded = true;
        PvPLogInitialize();

    -- initialize when entering world
    elseif( event == "PLAYER_ENTERING_WORLD" ) then
        PvPLogInitialize();

    -- initialize when name changes
    elseif( event == "UNIT_NAME_UPDATE" ) then
        PvPLogInitialize();

    -- keep track of players level
    elseif( event == "PLAYER_LEVEL_UP" ) then
        plevel = UnitLevel("player");

    -- respond to player death, tracking if another player killed us
    elseif( event == "PLAYER_DEAD" ) then
        -- initialize if we're not for some reason
        PvPLogInitialize();
        if( not initialized ) then
            return;
        end
        
        -- did we find in target list
        local found = false;

        -- make sure we have a last damager
        -- and are enabled
        if( lastDamagerToMe == nil or 
            lastDamagerToMe == "" or 
            not PvPLogData[realm][player].enabled) then
            return;
        end
        
        -- search in player list
        table.foreach( recentTargets, 
            function(i,v)
                if( v.name == lastDamagerToMe ) then
                    PvPLogChatMsg(CYAN .. "PvP death logged, killed by: " .. RED .. v.name);

                    PvPLogRecord(v.name, v.level, v.race, v.class, v.guild, true, false);

                    found = true;
                    
                    return 1;
                end
            end);

        -- if killer not found in targets, try to target them so we can check they are a PC
        if( not found ) then
            TargetByName(lastDamagerToMe);
            if( UnitName("target") == lastDamagerToMe and
                UnitIsPlayer("target") ) then

                PvPLogChatMsg(CYAN .. "PvP death logged, killed by: " .. 
                              RED .. lastDamagerToMe);
                            
                PvPLogRecord(lastDamagerToMe, UnitLevel("target"), UnitRace("target"), 
                                  UnitClass("target"), GetGuildInfo("target"), true, false);
            end
        end

    -- add record to mouseover
    elseif( event == "UPDATE_MOUSEOVER_UNIT" ) then
        -- initialize if we're not for some reason
        PvPLogInitialize();
        if( not initialized ) then
            return;
        end

        -- adds record to mouseover if it exists
        if( UnitExists("mouseover") and PvPLogData[realm][player].enabled ) then
            local total = PvPLogGetPvPTotals(UnitName("mouseover"));
            local guildTotal = PvPLogGetGuildTotals(GetGuildInfo("mouseover"));
                  
--                local tooltipcount = 4;

            if( total and (total.wins > 0 or total.loss > 0) ) then
                if( PvPLogData[realm][player].battles[UnitName("mouseover")].enemy ) then 
                    GameTooltip:AddLine(CYAN .. "PvP: " .. GREEN .. total.wins .. 
                                        CYAN .. " / " .. RED .. total.loss, 
                                        1.0, 1.0, 1.0, 0 );
                else
                    GameTooltip:AddLine(CYAN .. "Duels: " .. GREEN .. total.wins .. 
                                        CYAN .. " / " .. RED .. total.loss, 
                                        1.0, 1.0, 1.0, 0 );
                end
--                    getglobal(GameTooltip:GetName().."TextLeft"..tooltipcount):SetTextColor( 0.05, 1.0, 0.05 );
--                    tooltipcount = tooltipcount + 1;

                GameTooltip:SetHeight( GameTooltip:GetHeight() + 
                                       GameTooltip:GetHeight() / GameTooltip:NumLines() );
            end

            if( guildTotal and (guildTotal.wins > 0 or guildTotal.loss > 0) and
                (not total or total.wins ~= guildTotal.wins or total.loss ~= guildTotal.loss) ) then
                if( not PvPLogFriends(UnitRace("mouseover"), UnitRace("player")) ) then 
                    GameTooltip:AddLine(CYAN .. "Guild PvP: " .. GREEN .. guildTotal.wins .. 
                                        CYAN .. " / " .. RED .. guildTotal.loss, 
                                        1.0, 1.0, 1.0, 0 );
                else
                    GameTooltip:AddLine(CYAN .. "Guild Duels: " .. GREEN .. guildTotal.wins .. 
                                        CYAN .. " / " ..  RED .. guildTotal.loss, 
                                        1.0, 1.0, 1.0, 0 );
                end
--                    getglobal(GameTooltip:GetName().."TextLeft"..tooltipcount):SetTextColor( 0.05, 1.0, 0.05 );
--                    tooltipcount = tooltipcount + 1;

                GameTooltip:SetHeight( GameTooltip:GetHeight() + 
                                       GameTooltip:GetHeight() / GameTooltip:NumLines() );
            end

--            if( GetGuildInfo("mouseover") ) then
--                GameTooltip:AddLine(WHITE .. GetGuildInfo("mouseover"));
--                GameTooltip:SetHeight( GameTooltip:GetHeight() + 
--                                       GameTooltip:GetHeight() / GameTooltip:NumLines() );
--            end


            if( lastDing <= GetTime()-PvPLogData[realm][player].dingTimeout and
                not UnitInParty("mouseover") and
                UnitIsPlayer("mouseover") and
                ((total and 
                    (total.wins > 0 or total.loss > 0) and 
                    PvPLogData[realm][player].ding ~= "never") or
                 (guildTotal and (guildTotal.wins > 0 or guildTotal.loss > 0) and
                    PvPLogData[realm][player].ding ~= "noguild" and
                    PvPLogData[realm][player].ding ~= "noguildorduel" and
                    PvPLogData[realm][player].ding ~= "never"
                  )) and
                (UnitIsEnemy("player", "mouseover") or
                    (PvPLogData[realm][player].ding ~= "noduel" and 
                     PvPLogData[realm][player].ding ~= "never" and
                     PvPLogData[realm][player].ding ~= "noguildorduel"))
              ) then
                if( PvPLogData[realm][player].dispLocation == "chat" ) then
                    local msg = CYAN .. "PvPLog: " .. RED .. UnitName("mouseover") ..
                                CYAN .. " (" .. UnitLevel("mouseover") .. "," .. 
                                UnitRace("mouseover") .. "," .. UnitClass("mouseover");
                    if( GetGuildInfo("mouseover") ) then
                        msg = msg .. ", " .. GetGuildInfo("mouseover");
                    end
                    msg = msg .. ") -- ";
                    if( total and (total.wins > 0 or total.loss > 0) ) then
                        msg = msg .. GREEN .. total.wins .. CYAN .. " / " .. 
                              RED .. total.loss;  
                    end
                    if( GetGuildInfo("mouseover") and guildTotal and 
                        (guildTotal.wins > 0 or guildTotal.loss > 0) and
                        (not total or total.wins ~= guildTotal.wins or total.loss ~= guildTotal.loss) ) then
                        msg = msg .. CYAN .. " (Guild: " .. GREEN .. guildTotal.wins.. 
                              CYAN .. " / " .. RED .. guildTotal.loss.. CYAN .. ")";
                    end
                    PvPLogChatMsg(msg);
                else
                    local msg = "PvPLog: " .. UnitName("mouseover") ..
                                " (" .. UnitLevel("mouseover") .. "," .. 
                                UnitRace("mouseover") .. "," .. UnitClass("mouseover");
                    if( GetGuildInfo("mouseover") ) then
                        msg = msg .. ", " .. GetGuildInfo("mouseover");
                    end
                    msg = msg .. ") -- ";
                    if( total and (total.wins > 0 or total.loss > 0) ) then
                        msg = msg .. total.wins.. " / " .. total.loss;
                    end
                    if( GetGuildInfo("mouseover") and guildTotal and 
                        (guildTotal.wins > 0 or guildTotal.loss > 0) and
                        (not total or total.wins ~= guildTotal.wins or total.loss ~= guildTotal.loss) ) then
                        msg = msg .. " (Guild: " .. guildTotal.wins.. " / "
                                  .. guildTotal.loss.. ")";
                    end
                    PvPLogFloatMsg(msg, "cyan");
                end
                PlaySound(PvPLogData[realm][player].dingSound);
                lastDing = GetTime();
            end
        end

    -- keep track of those we've targeted
    elseif (event == "PLAYER_TARGET_CHANGED") then
        -- initialize if we're not for some reason
        PvPLogInitialize();
        if( not initialized ) then
            return;
        end

        local field = getglobal("PvPLogTargetText");
        field:Hide();
        field:SetText("");

        -- if we're enabled
        if( PvPLogData[realm][player].enabled ) then
            PvPLogUpdateTargetText();

            -- if we have a vaild target, its a player, and its an enemy
            if( UnitName("target") and 
                UnitIsPlayer("target") and 
                UnitIsEnemy("player", "target")
              ) then
                -- will contain about target
                local target = { };
                target.name = UnitName("target");
                target.level = UnitLevel("target");
                target.race = UnitRace("target");
                target.class = UnitClass("target");
                target.guild = GetGuildInfo("target");

                -- add to our list of recent targets
                table.insert( recentTargets, target );
                -- remove if we've hit our cap
                if( table.getn( recentTargets ) > NUMRECENT ) then
                    table.remove( recentTargets, 1 );
                end
            end
        end

    -- record a hostile death, if we killed them
    elseif( event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" ) then
        -- initialize if we're not for some reason
        PvPLogInitialize();
        if( not initialized ) then
            return;
        end

        -- if we're enabled
        if( PvPLogData[realm][player].enabled ) then
            -- get name 
            local index = string.find( arg1, " dies." );
            if( not index ) then
                return;
            end
            local value = string.sub( arg1, 0, index-1 );
            -- if we have a name
            if( value ) then
                -- search in damaged list
                table.foreach( damagedTargets, 
                        function(i,v)
                            if( v.name == value ) then
                                PvPLogChatMsg(CYAN .. "PvP kill logged: " .. GREEN .. v.name);
                                
                                PvPLogRecord(v.name, v.level, v.race, v.class, v.guild, true, true);

                                return 1;
                            end
                        end);
            end
        end
    end 
end

-- Helper Functions
function PvPLogSetEnabled(toggle)
    toggle = string.lower(toggle);
    if (toggle == "off") then
        PvPLogData[realm][player].enabled = false;
        PvPLogFloatMsg(CYAN .. "PvPLog " .. WHITE .. "Off");
    else
        PvPLogData[realm][player].enabled = true;
        PvPLogFloatMsg(CYAN .. "PvPLog " .. WHITE .. "On");
    end        
end

function PvPLogSetDisplayLoc(loc)
    PvPLogData[realm][player].dispLocation = loc;
    PvPLogFloatMsg(CYAN .. "PvPLog display location: " .. WHITE .. loc);
end

function PvPLogSlashHandler(msg)
    -- initialize if we're not for some reason
    PvPLogInitialize();
    if( not initialized ) then
        return;
    end

    local firsti, lasti, command, value = string.find (msg, "(%w+) \"(.*)\"");
    if (command == nil) then
        firsti, lasti, command, value = string.find (msg, "(%w+) (%w+)");
    end
    if (command == nil) then
        firsti, lasti, command = string.find(msg, "(%w+)");
    end    
    --PvPLogChatMsg(msg);
    --PvPLogChatMsg(command);
    --PvPLogChatMsg(value);
    -- respond to commands
    if (command == nil) then
        PvPLogDisplayUsage();
    elseif (string.lower(command) == "reset") then
        if( value == "confirm" ) then
            PvPLogData[realm][player] = { };
            PvPLogData[realm][player].battles = { };
            PvPLogData[realm][player].enabled = true;
            PvPLogData[realm][player].dispLocation = "overhead";
            PvPLogData[realm][player].ding = "always";
            PvPLogData[realm][player].dingSound = "AuctionWindowOpen";
            PvPLogData[realm][player].dingTimeout = 120.0;
            PvPLogData[realm][player].notifyKill = "party";
            PvPLogData[realm][player].notifyDeath = "guild";
            PvPLogData[realm][player].notifyKillText = "I killed $n (Level $l %r %c) at [%x,%y] in %z.";
            PvPLogData[realm][player].notifyDeathText = "%n (Level %l %r %c) killed me at [%x,%y] in %z.";
            PvPLogData[realm][player].version = VER_NUM.."."..VER_SUB.."."..VER_REL;
            PvPLogChatMsg(CYAN .. "PvPLog " .. MAGENTA .. "Reset" .. CYAN .. " Completely!");
        end
    elseif( string.lower(command) == "notifykillstext") then
        if( value == "long" ) then
            value = "I killed %n (Level %l %r %c) at [%x,%y] in %z.";
        elseif( value == "medium" ) then
            value = "I killed %n (Level %l %r %c) at [%x,%y].";
        elseif( value == "short" ) then
            value = "Killed Level %l %r %c.";
        elseif( value == "custom" ) then
            PvPLogChatMsg(CYAN .. "PvPLog: Custom Chat Noftifications\n");
            PvPLogChatMsg(CYAN .. "  Type the following to use a custom chat notification:\n");
            PvPLogChatMsg(CYAN .. "    /pvplog notifykillstext \"custom string\"  -- or --\n");
            PvPLogChatMsg(CYAN .. "    /pvplog notifydeathtext \"custom string\"\n");
            PvPLogChatMsg(CYAN .. "  Where <custom string> is the text you want used, with\n");
            PvPLogChatMsg(CYAN .. "  format codes as follows:\n");
            PvPLogChatMsg(CYAN .. "    %n - name, %l - level, %r - race, %c - class, %g - guild\n");
            PvPLogChatMsg(CYAN .. "    %x - X:coordinate, %y - Y:coordinate, %z - zone\n");
            PvPLogChatMsg(CYAN .. "  Example:\n");
            PvPLogChatMsg(CYAN .. "    /pvplog notifykillstext \"I killed %n (Level %l %r %c) at [%x,%y] in %z.\"\n");
            PvPLogChatMsg(CYAN .. "  Current setting: " .. PvPLogData[realm][player].notifyKillText .. "\n");
            value = nil;
        else
            firsti, lasti, value = string.find( msg, "\"(.*)\"" );
        end
        if( value ~= nil ) then 
            PvPLogData[realm][player].notifyKillText = value;
            PvPLogFloatMsg(CYAN .. "PvPLog Set " .. WHITE .. "notifykillstext" .. CYAN .. " to " .. MAGENTA .. value);
        end
    elseif( string.lower(command) == "notifydeathtext") then
        if( value == "long" ) then
            value = "%n (Level %l %r %c) killed me at [%x,%y] in %z.";
        elseif( value == "medium" ) then
            value = "%n (Level %l %r %c) killed me at [%x,%y].";
        elseif( value == "short" ) then
            value = "Level %l %r %c killed me.";
        elseif( value == "custom" ) then
            PvPLogChatMsg(CYAN .. "PvPLog: Custom Chat Noftifications\n");
            PvPLogChatMsg(CYAN .. "  Type the following to use a custom chat notification:\n");
            PvPLogChatMsg(CYAN .. "    /pvplog notifykillstext \"custom string\"  -- or --\n");
            PvPLogChatMsg(CYAN .. "    /pvplog notifydeathtext \"custom string\"\n");
            PvPLogChatMsg(CYAN .. "  Where <custom string> is the text you want used, with\n");
            PvPLogChatMsg(CYAN .. "  format codes as follows:\n");
            PvPLogChatMsg(CYAN .. "    %n - name, %l - level, %r - race, %c - class,\n");
            PvPLogChatMsg(CYAN .. "    %x - X:coordinate, %y - Y:coordinate, %z - zone\n");
            PvPLogChatMsg(CYAN .. "  Example:\n");
            PvPLogChatMsg(CYAN .. "    /pvplog notifydeathtext \"%n (Level %l %r %c) killed me at [%x,%y] in %z.\"\n");
            PvPLogChatMsg(CYAN .. "  Current setting: " .. PvPLogData[realm][player].notifyDeathText .. "\n");
            value = nil
        else
            firsti, lasti, value = string.find( msg, "\"(.*)\"" );
        end
        if( value ~= nil ) then
            PvPLogData[realm][player].notifyDeathText = value;
            PvPLogFloatMsg(CYAN .. "PvPLog Set " .. WHITE .. "notifydeathtext" .. CYAN .. " to " .. MAGENTA .. value);
        end
    elseif( string.lower(command) == "notifykills") then
        if( value ~= nil ) then
            PvPLogData[realm][player].notifyKill = value;
            PvPLogFloatMsg(CYAN .. "PvPLog Set " .. WHITE .. "notifykills" .. CYAN .. " to " .. MAGENTA .. value);
        else
            PvPLogDisplayUsage();
        end
    elseif( string.lower(command) == "notifydeath") then
        if( value ~= nil ) then
            PvPLogData[realm][player].notifyDeath = value;
            PvPLogFloatMsg(CYAN .. "PvPLog Set " .. WHITE .. "notifydeath" .. CYAN .. " to " .. MAGENTA .. value);
        else
            PvPLogDisplayUsage();
        end
    elseif (string.lower(command) == "targetreset") then
        PvPLogTargetFrame:ClearAllPoints();
        PvPLogTargetFrame:SetPoint("TOP", "TargetFrameHealthBar", "BOTTOM", -2, -5);
    elseif (string.lower(command) == "enable") then
        PvPLogSetEnabled("on");
    elseif (string.lower(command) == "disable") then
        PvPLogSetEnabled("off");
    elseif (string.lower(command) == "location") then
        if (value ~= nil) then
            PvPLogSetDisplayLoc(string.lower(value));
        else
            PvPLogDisplayUsage();
        end
    elseif( string.lower(command) == "version" ) then
        PvPLogChatMsg(CYAN .. "PvPLog version " .. WHITE .. VER_NUM .. "." .. VER_SUB .. "." .. VER_REL);
    elseif( string.lower(command) == "dingsound" ) then
        if( value ~= nil ) then
            PvPLogData[realm][player].dingSound = value;
            PvPLogFloatMsg(CYAN .. "PvPLog ding sound: " .. WHITE .. value);
        else
            PvPLogDisplayUsage();
        end
    elseif( string.lower(command) == "dingtimeout" ) then
        if( value ~= nil ) then
            PvPLogData[realm][player].dingTimeout = value;
            PvPLogFloatMsg(CYAN .. "PvPLog ding timeout: " .. WHITE .. value);
        else
            PvPLogDisplayUsage();
        end
    elseif( string.lower(command) == "ding" ) then
        if( value ~= nil ) then
            PvPLogData[realm][player].ding = string.lower(value);
            PvPLogFloatMsg(CYAN .. "PvPLog ding setting: " .. WHITE .. value);
        else
            PvPLogDisplayUsage();
        end
    elseif( string.lower(command) == "stats") then
        local stats = PvPLogGetStats();
        local gankLevel = "Fair Fighter";
        if( stats.pvpWinAvgLevelDiff <= -25 ) then
            gankLevel = "I Have No Mercy";
        elseif( stats.pvpWinAvgLevelDiff <= -20 ) then
            gankLevel = "Newb Masher";
        elseif( stats.pvpWinAvgLevelDiff <= -15 ) then
            gankLevel = "No Seriously, Get a Life";
        elseif( stats.pvpWinAvgLevelDiff <= -12 ) then
            gankLevel = "Get a Life";
        elseif( stats.pvpWinAvgLevelDiff <= -9 ) then
            gankLevel = "Gankity Gank Gank";
        elseif( stats.pvpWinAvgLevelDiff <= -6 ) then
            gankLevel = "Major Ganker";
        elseif( stats.pvpWinAvgLevelDiff <= -3 ) then
            gankLevel = "Minor Ganker";
        elseif( stats.pvpWinAvgLevelDiff >= 8 ) then
            gankLevel = "I Gank GameMasters";
        elseif( stats.pvpWinAvgLevelDiff >= 5 ) then
            gankLevel = "PvP God";
        elseif( stats.pvpWinAvgLevelDiff >= 4 ) then
            gankLevel = "PvP Legend";
        elseif( stats.pvpWinAvgLevelDiff >= 3 ) then
            gankLevel = "Ungankable";
        elseif( stats.pvpWinAvgLevelDiff >= 2 ) then
            gankLevel = "Just try to gank me";
        elseif( stats.pvpWinAvgLevelDiff >= 1 ) then
            gankLevel = "Difficult to Gank";
        end
        PvPLogChatMsg("|cff33ffffPvPLog Statistics:");
        PvPLogChatMsg("|cff33ffff  Total wins:    " .. stats.totalWins .. " (avg.level.diff: " .. (math.floor(stats.totalWinAvgLevelDiff*100)/100) .. ")");
        PvPLogChatMsg("|cff33ffff  Total losses:  " .. stats.totalLoss .. " (avg.level.diff: " .. (math.floor(stats.totalLossAvgLevelDiff*100)/100) .. ")");
        PvPLogChatMsg("|cff33ffff    PvP wins:    " .. stats.pvpWins .. " (avg.level.diff: " .. (math.floor(stats.pvpWinAvgLevelDiff*100)/100) .. ", " .. gankLevel .. ")");
        PvPLogChatMsg("|cff33ffff    PvP losses:  " .. stats.pvpLoss .. " (avg.level.diff: " .. (math.floor(stats.pvpLossAvgLevelDiff*100)/100) .. ")");
        PvPLogChatMsg("|cff33ffff    Duel wins:   " .. stats.duelWins .. " (avg.level.diff: " .. (math.floor(stats.duelWinAvgLevelDiff*100)/100) .. ")");
        PvPLogChatMsg("|cff33ffff    Duel losses: " .. stats.duelLoss .. " (avg.level.diff: " .. (math.floor(stats.duelLossAvgLevelDiff*100)/100) .. ")");
    elseif( string.lower(command) == "find") then
        PvPLogFind(value);
    elseif( string.lower(command) == "listall") then
        PvPLogListAll();
    else
        PvPLogDisplayUsage();
    end
end

function PvPLogDisplayUsage()
    local text;

    text = CYAN .. "Usage:\n  /PvPLog <";
    if( PvPLogData[realm][player].enabled ) then
        text = text .. WHITE .. "enable" .. CYAN .. " | disable>\n";
    else
        text = text .. "enable | " .. WHITE .. "disable" .. CYAN .. ">\n";
    end
    PvPLogChatMsg(text);

    PvPLogChatMsg(CYAN .. "  /PvPLog reset confirm (DANGER -- erases all records)\n");
    PvPLogChatMsg(CYAN .. "  /PvPLog listall\n");
    text = CYAN .. "  /PvPLog location <";
    if( PvPLogData[realm][player].dispLocation == "chat" ) then
        text = text .. WHITE .. "chat" .. CYAN .. " | ";
    else
        text = text .. "chat | ";
    end
    if( PvPLogData[realm][player].dispLocation == "overhead" ) then
        text = text .. WHITE .. "overhead" .. CYAN .. " | ";
    else
        text = text .. "overhead | ";
    end
    if( PvPLogData[realm][player].dispLocation == "none" ) then
        text = text .. WHITE .. "overhead" .. CYAN .. ">\n";
    else
        text = text .. "none>\n";
    end
    PvPLogChatMsg(text);

    PvPLogChatMsg(CYAN .. "  /PvPLog find <search string>\n");
    PvPLogChatMsg(CYAN .. "  /PvPLog stats\n");
    
    text = CYAN .. "  /PvPLog ding <";
    if( PvPLogData[realm][player].ding == "always" ) then
        text = text .. WHITE .. "always" .. CYAN .. " | ";
    else
        text = text .. "always | ";
    end
    if( PvPLogData[realm][player].ding == "never" ) then
        text = text .. WHITE .. "never" .. CYAN .. " | ";
    else
        text = text .. "never | ";
    end
    if( PvPLogData[realm][player].ding == "noguild" ) then
        text = text .. WHITE .. "noGuild" .. CYAN .. " | ";
    else
        text = text .. "noGuild | ";
    end
    if( PvPLogData[realm][player].ding == "noduel" ) then
        text = text .. WHITE .. "noDuel" .. CYAN .. " | ";
    else
        text = text .. "noDuel | ";
    end
    if( PvPLogData[realm][player].ding == "noguildorduel" ) then
        text = text .. WHITE .. "noGuildOrDuel" .. CYAN .. ">\n";
    else
        text = text .. "noGuildOrDuel>\n";
    end
    PvPLogChatMsg(text);

    PvPLogChatMsg(CYAN .. "  /PvPLog dingsound <soundfile> (default=AuctionWindowOpen, current=" .. WHITE .. PvPLogData[realm][player].dingSound .. CYAN .. ")\n");
    PvPLogChatMsg(CYAN .. "  /PvPLog dingtimeout <seconds> (default=120.0, current=" .. WHITE .. PvPLogData[realm][player].dingTimeout .. CYAN .. ")\n");

    local nkills = 0;
    text = CYAN .. "  /PvPLog notifykills <";
    if( PvPLogData[realm][player].notifyKill == "none" ) then
        text = text .. WHITE .. "none" .. CYAN .. " | ";
        nkills = 1;
    else
        text = text .. "none | ";
    end
    if( PvPLogData[realm][player].notifyKill == "party" ) then
        text = text .. WHITE .. "party" .. CYAN .. " | ";
        nkills = 1;
    else
        text = text .. "party | ";
    end
    if( PvPLogData[realm][player].notifyKill == "guild" ) then
        text = text .. WHITE .. "guild" .. CYAN .. " | ";
        nkills = 1;
    else
        text = text .. "guild | ";
    end
    if( PvPLogData[realm][player].notifyKill == "raid" ) then
        text = text .. WHITE .. "raid" .. CYAN .. " | ";
        nkills = 1;
    else
        text = text .. "raid | ";
    end
    if( not nkills ) then
        text = text .. WHITE .. "channelname=" .. PvPLogData[realm][player].notifyKill .. CYAN .. ">\n";
    else
        text = text .. "channelname>\n";
    end
    PvPLogChatMsg(text);

    nkills = 0;
    text = CYAN .. "  /PvPLog notifydeath <";
    if( PvPLogData[realm][player].notifyDeath == "none" ) then
        text = text .. WHITE .. "none" .. CYAN .. " | ";
        nkills = 1;
    else
        text = text .. "none | ";
    end
    if( PvPLogData[realm][player].notifyDeath == "party" ) then
        text = text .. WHITE .. "party" .. CYAN .. " | ";
        nkills = 1;
    else
        text = text .. "party | ";
    end
    if( PvPLogData[realm][player].notifyDeath == "guild" ) then
        text = text .. WHITE .. "guild" .. CYAN .. " | ";
        nkills = 1;
    else
        text = text .. "guild | ";
    end
    if( PvPLogData[realm][player].notifyDeath == "raid" ) then
        text = text .. WHITE .. "raid" .. CYAN .. " | ";
        nkills = 1;
    else
        text = text .. "raid | ";
    end
    if( not nkills ) then
        text = text .. WHITE .. "channelname=" .. PvPLogData[realm][player].notifyDeath .. CYAN .. ">\n";
    else
        text = text .. "channelname>\n";
    end
    PvPLogChatMsg(text);

    PvPLogChatMsg(CYAN .. "  /PvPLog notifykillstext <short | medium | long | custom>\n");
    PvPLogChatMsg(CYAN .. "  /PvPLog notifydeathtext <short | medium | long | custom>\n");
    PvPLogChatMsg(CYAN .. "  /PvPLog version\n");
    PvPLogChatMsg(CYAN .. "  /PvPLog targetreset\n");
end

function PvPLogChatMsg(msg)
    if( DEFAULT_CHAT_FRAME ) then
        DEFAULT_CHAT_FRAME:AddMessage(msg);
    end
end

function PvPLogFloatMsg(msg, color)
    -- Display overhead message.  7 basic colors available
    -- Use at most 3 lines here - the rest get lost
    local r, g, b

    if (color == nil) then 
        color = "white";
    end

    if (string.lower(color) == "red") then
        r, g, b = 1.0, 0.0, 0.0;
    elseif (string.lower(color) == "green") then
        r, g, b = 0.0, 1.0, 0.0;
    elseif (string.lower(color) == "blue") then
        r, g, b = 0.0, 0.0, 1.0;
    elseif (string.lower(color) == "magenta") then
        r, g, b = 1.0, 0.0, 1.0;
    elseif (string.lower(color) == "yellow") then
        r, g, b = 1.0, 1.0, 0.0;
    elseif (string.lower(color) == "cyan") then
        r, g, b = 0.0, 1.0, 1.0;
    else 
        r, g, b = 1.0, 1.0, 1.0;
    end

    UIErrorsFrame:AddMessage(msg, r, g, b, 1.0, UIERRORS_HOLD_TIME);
    
end


function PvPLogInitialize()
    -- get realm and player
    realm = GetCVar("realmName");
    player = UnitName("player");
    plevel = UnitLevel("player");

    -- check for valid realm and player
    if( initialized or (not variablesLoaded) or (not realm) or 
        (not plevel) or (not player) or (player == "Unknown Entity")
      ) then
        return;
    end
    initialized = true;

    -- Register command handler and new commands
    SlashCmdList["PvPLogCOMMAND"] = PvPLogSlashHandler;
    SLASH_PvPLogCOMMAND1 = "/pvplog";
    SLASH_PvPLogCOMMAND2 = "/pl";
    
	-- Hook the ChatFrame_OnEvent function
	lOriginalChatFrame_OnEvent = ChatFrame_OnEvent;
	ChatFrame_OnEvent = PvPLog_ChatFrame_OnEvent;

    -- initialize data structure
    if( PvPLogData == nil ) then
        PvPLogData = { };
    end
    if( PvPLogData[realm] == nil ) then
        PvPLogData[realm] = { };
    end
    if( PvPLogData[realm][player] == nil ) then
        PvPLogData[realm][player] = { };
        PvPLogData[realm][player].battles = { };
        PvPLogData[realm][player].enabled = true;
        PvPLogData[realm][player].dispLocation = "overhead";
        PvPLogData[realm][player].ding = "always";
        PvPLogData[realm][player].dingSound = "AuctionWindowOpen";
        PvPLogData[realm][player].dingTimeout = 120.0;
        PvPLogData[realm][player].notifyKill = "party";
        PvPLogData[realm][player].notifyDeath = "guild";
        PvPLogData[realm][player].notifyKillText = "I killed %n (Level %l %r %c) at [%x,%y] in %z.";
        PvPLogData[realm][player].notifyDeathText = "%n (Level %l %r %c) killed me at [%x,%y] in %z.";
        PvPLogData[realm][player].version = VER_NUM.."."..VER_SUB.."."..VER_REL;
    end
    if( PvPLogData[realm][player].battles == nil ) then
        PvPLogData[realm][player].battles = { };
    end
    if( PvPLogData[realm][player].enabled == nil ) then
        PvPLogData[realm][player].enabled = true;
    end
    if( PvPLogData[realm][player].dispLocation == nil ) then
        PvPLogData[realm][player].dispLocation = "overhead";
    end
    if( PvPLogData[realm][player].dingSound == nil ) then
        PvPLogData[realm][player].dingSound = "AuctionWindowOpen";
    end
    if( PvPLogData[realm][player].ding == nil ) then
        PvPLogData[realm][player].ding = "always";
    end
    if( PvPLogData[realm][player].dingTimeout == nil ) then
        PvPLogData[realm][player].dingTimeout = 120.0;
    end
    if( PvPLogData[realm][player].notifyKill == nil ) then
        PvPLogData[realm][player].notifyKill = "party";
    end
    if( PvPLogData[realm][player].notifyDeath == nil ) then
        PvPLogData[realm][player].notifyDeath = "guild";
    end
    if( PvPLogData[realm][player].notifyKillText == nil ) then
        PvPLogData[realm][player].notifyKillText = "I killed %n (Level %l %r %c) at [%x,%y] in %z.";
    end
    if( PvPLogData[realm][player].notifyDeathText == nil ) then
        PvPLogData[realm][player].notifyDeathText = "%n (Level %l %r %c) killed me at [%x,%y] in %z.";
    end
    if( PvPLogData[realm][player].version == nil ) then
        PvPLogData[realm][player].version = VER_NUM.."."..VER_SUB.."."..VER_REL;
    end

    local stats = PvPLogGetStats();
    local allRecords = stats.totalWins + stats.totalLoss;

    -- Report load
    PvPLogChatMsg("PvPLog variables loaded: " .. allRecords .. " records (" .. 
                  stats.totalWins .. "/" .. stats.totalLoss .. ") for " .. 
                  player .. " | " .. realm);
end


function PvPLogListAll()
    table.foreach( PvPLogData[realm][player].battles,
            function( target,v1 )
            PvPLogData[realm][player].battles[target].enemy = not PvPLogFriends(UnitRace("player"), v1.race);
            table.foreach( v1,
                function( targLevel,v2 )
                if( targLevel ~= "race" and
                    targLevel ~= "class" and
                    targLevel ~= "enemy" and
                    targLevel ~= "guild" ) then
                    table.foreach( v2,
                        function( playerLevel, v3 )
                        local msg = "|cff00ffffPvP: "..target.." ("..targLevel..",".. v1.race ..",".. v1.class;
                        if( v1.guild ) then
                            msg = msg .. "," .. v1.guild;
                        end
                        msg = msg .. ") [".. playerLevel ..",".. v3.wins .."," .. v3.loss .. "]";
                        PvPLogChatMsg(msg);
                        end);
                end
                end)
            end)
end

function PvPLog_ChatFrame_OnEvent()
	lOriginalChatFrame_OnEvent(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);

    -- initialize if we're not for some reason
    PvPLogInitialize();
    if( not initialized ) then
        return;
    end

    -- occasionally I was getting a nil value on the
    -- if statement after this one so this is a check
    -- to make sure that doesn't happen
    if( not PvPLogData[realm][player] ) then
        return;
    end

    -- check to see if we're enabled
    if( not PvPLogData[realm][player].enabled ) then
        return;
    end
	
    if( event and arg1 ) then
        local s, e;
        s, e, winner, loser = string.find(arg1, "(.+) has defeated (.+) in a duel");
        if( winner ) then
            --- CHAT_MSG_SYSTEM
            if( player == winner ) then
                local v = { };
                v.name = loser;
                TargetByName(loser);
                if( UnitName("target") == loser ) then
                    v.level = UnitLevel("target");
                    v.class = UnitClass("target");
                    v.guild = GetGuildInfo("target");
                    v.race = UnitRace("target");
                else
                    v.level = -1;
                end

                PvPLogChatMsg(CYAN .. "PvP duel win logged against: " .. GREEN .. v.name);

                PvPLogRecord(v.name, v.level, v.race, v.class, v.guild, false, true);
                
            elseif( player == loser ) then
                local v = { };
                v.name = winner;
                TargetByName(winner);
                if( UnitName("target") == winner ) then
                    v.level = UnitLevel("target");
                    v.class = UnitClass("target");
                    v.guild = GetGuildInfo("target");
                    v.race = UnitRace("target");
                else
                    v.level = -1;
                end

                PvPLogChatMsg(CYAN .. "PvP duel loss logged against: " .. RED .. v.name);

                PvPLogRecord(v.name, v.level, v.race, v.class, v.guild, false, false);
            end
        end
    end

    if( event and (strsub(event, 1, 15) == "CHAT_MSG_COMBAT" or strsub(event, 1, 14) == "CHAT_MSG_SPELL") ) then
        for index, value in yourDamageMatch do
            local s, e;
            local results = { };
            s, e, results[0], results[1], results[2], results[3], results[4] = string.find(arg1, value.pattern);
            if( results[0] ~= nil ) then
                table.foreach( recentTargets, 
                    function(i,v)
                        if( v.name == results[value.mob] ) then
                            table.insert( damagedTargets, v );
                            if( table.getn( damagedTargets ) > NUMDAMAGED ) then
                                table.remove( damagedTargets, 1 );
                            end
                            return 1;
                        end
                    end);
                return;
            end
        end
        for index, value in damageToYouMatch do
            local s, e;
            local results = { };
            s, e, results[0], results[1], results[2], results[3], results[4] = string.find(arg1, value.pattern);
            if( results[0] ~= nil ) then
                lastDamagerToMe = results[value.cause];
                return;
            end
        end
    end
end

function PvPLogFind(search)
    if( not search ) then
        return;
    end
    search = string.lower(search);
    table.foreach( PvPLogData[realm][player].battles,
        function( target,v1 )
            local found = string.find( string.lower(target), search );
            if( not found) then found = string.find( string.lower(v1.race), search ) end
            if( not found) then found = string.find( string.lower(v1.class), search ) end
            if( not found and v1.guild ) then found = string.find( string.lower(v1.guild), search ) end
            if( found ) then
                local totals = PvPLogGetPvPTotals(target);
                local msg = "|cff00ffffPvP: "..target.." (" ..totals.highestLevel .. "," .. v1.race ..",".. v1.class;
                if( v1.guild ) then
                    msg = msg .. "," .. v1.guild;
                end
                msg = msg .. ") Wins: ".. totals.wins ..", Losses:" .. totals.loss .. ", Avg. Level Difference: " .. totals.avgLevelDiff;
                PvPLogChatMsg(msg);
            end
        end)
end

function PvPLogGetPvPTotals(name)
    if( not name ) then
        return nil;
    end

    if( not PvPLogData[realm][player].battles[name] ) then
        return nil;
    end

    local total = { };
    total.wins = 0;
    total.loss = 0;
    total.highestLevel = 0;
    total.avgLevelDiff = 0;
    total.winsStr = "";
    total.lossStr = "";
    total.slashy  = true;

    table.foreach( PvPLogData[realm][player].battles[name],
        function( targLevel,v2 )
        if( targLevel ~= "race" and
            targLevel ~= "class" and
            targLevel ~= "enemy" and
            targLevel ~= "guild" ) then
            if( targLevel > total.highestLevel ) then
                total.highestLevel = targLevel;
            end
            table.foreach( v2,
                function( playerLevel, v3 )
                    total.wins = total.wins + v3.wins;
                    total.loss = total.loss + v3.loss;
                    total.avgLevelDiff = total.avgLevelDiff + (v3.wins+v3.loss)*(targLevel-playerLevel);
                end);
        end
    end);
    total.avgLevelDiff = total.avgLevelDiff / (total.wins + total.loss);

    if( total.wins == 1 ) then
        total.winsStr = "1 win";
    elseif( total.wins > 1 ) then
        total.winsStr = total.wins .. " wins";
    else
        total.slashy = false;
    end

    if( total.loss == 1 ) then
        total.lossStr = "1 loss";
    elseif( total.loss > 1 ) then
        total.lossStr = total.loss .. " losses";
    end

    if( total.slashy and total.loss > 0 ) then
        total.slashy = " / ";
    else
        total.slashy = "";
    end
            
    return total;
end


function PvPLogGetGuildTotals(guild)
    if( not guild ) then
        return nil;
    end
    guild = string.lower(guild);
    local total = { };
    total.wins = 0;
    total.loss = 0;
    total.winsStr = "";
    total.lossStr = "";
    total.slashy  = true;

    table.foreach( PvPLogData[realm][player].battles,
        function( target,v1 )
            if( v1.guild and guild == string.lower(v1.guild) ) then
                local indiv = PvPLogGetPvPTotals(target);
                total.wins = total.wins + indiv.wins;
                total.loss = total.loss + indiv.loss;
            end
        end)

    if( total.wins == 1 ) then
        total.winsStr = "1 win";
    elseif( total.wins > 1 ) then
        total.winsStr = total.wins .. " wins";
    else
        total.slashy = false;
    end

    if( total.loss == 1 ) then
        total.lossStr = "1 loss";
    elseif( total.loss > 1 ) then
        total.lossStr = total.loss .. " losses";
    end

    if( total.slashy and total.loss > 0 ) then
        total.slashy = " / ";
    else
        total.slashy = "";
    end

    return total;
end

function PvPLogGetStats()
    local stats = { };
    stats.totalWins = 0;
    stats.totalWinAvgLevelDiff = 0;
    stats.totalLoss = 0;
    stats.totalLossAvgLevelDiff = 0;
    stats.pvpWins = 0;
    stats.pvpWinAvgLevelDiff = 0;
    stats.pvpLoss = 0;
    stats.pvpLossAvgLevelDiff = 0;
    stats.duelWins = 0;
    stats.duelWinAvgLevelDiff = 0;
    stats.duelLoss = 0;
    stats.duelLossAvgLevelDiff = 0;
    stats.levels = { };
    stats.levels[0] = { };
    stats.levels[1] = { };
    stats.levels[2] = { };
    stats.levels[3] = { };
    stats.levels[4] = { };
    stats.levels[5] = { };
    stats.levels[6] = { };
    stats.levels[7] = { };
    stats.levels[8] = { };
    stats.levels[9] = { };
    stats.levels[10] = { };
    stats.levels[0].wins = 0;
    stats.levels[1].wins = 0;
    stats.levels[2].wins = 0;
    stats.levels[3].wins = 0;
    stats.levels[4].wins = 0;
    stats.levels[5].wins = 0;
    stats.levels[6].wins = 0;
    stats.levels[7].wins = 0;
    stats.levels[8].wins = 0;
    stats.levels[9].wins = 0;
    stats.levels[10].wins = 0;
    stats.levels[0].loss = 0;
    stats.levels[1].loss = 0;
    stats.levels[2].loss = 0;
    stats.levels[3].loss = 0;
    stats.levels[4].loss = 0;
    stats.levels[5].loss = 0;
    stats.levels[6].loss = 0;
    stats.levels[7].loss = 0;
    stats.levels[8].loss = 0;
    stats.levels[9].loss = 0;
    stats.levels[10].loss = 0;
    stats.classes = { };
    stats.punchingbag = "";
    stats.punchingbagkills = 0;
    stats.feared = "";
    stats.feareddeaths = 0;

    table.foreach( PvPLogData[realm][player].battles,
            function( target,v1 )
            if( v1.enemy == nil ) then
                PvPLogData[realm][player].battles[target].enemy = not PvPLogFriends( UnitRace("player"), v1.race );
            end

            table.foreach( v1,
                function( targLevel,v2 )
                if( targLevel ~= "race" and
                    targLevel ~= "class" and
                    targLevel ~= "enemy" and
                    targLevel ~= "guild" ) then
                    table.foreach( v2,
                        function( playerLevel, v3 )
                            stats.totalWins = stats.totalWins + v3.wins;
                            if( targLevel < 0 ) then
                                stats.totalWinAvgLevelDiff = stats.totalWinAvgLevelDiff + v3.wins*(-targLevel-playerLevel);
                            else
                                stats.totalWinAvgLevelDiff = stats.totalWinAvgLevelDiff + v3.wins*(targLevel-playerLevel);
                            end
                            stats.totalLoss = stats.totalLoss + v3.loss;
                            if( targLevel < 0 ) then
                                stats.totalLossAvgLevelDiff = stats.totalLossAvgLevelDiff + v3.loss*(-targLevel-playerLevel);
                            else
                                stats.totalLossAvgLevelDiff = stats.totalLossAvgLevelDiff + v3.loss*(targLevel-playerLevel);
                            end
                            if( v1.enemy ) then
                                stats.pvpWins = stats.pvpWins + v3.wins;
                                if( targLevel < 0 ) then
                                    stats.pvpWinAvgLevelDiff = stats.pvpWinAvgLevelDiff + v3.wins*(targLevel-playerLevel);
                                else
                                    stats.pvpWinAvgLevelDiff = stats.pvpWinAvgLevelDiff + v3.wins*(targLevel-playerLevel);
                                end
                                stats.pvpLoss = stats.pvpLoss + v3.loss;
                                if( targLevel < 0 ) then
                                    stats.pvpLossAvgLevelDiff = stats.pvpLossAvgLevelDiff + v3.loss*(targLevel-playerLevel);
                                else
                                    stats.pvpLossAvgLevelDiff = stats.pvpLossAvgLevelDiff + v3.loss*(targLevel-playerLevel);
                                end
                            else
                                stats.duelWins = stats.duelWins + v3.wins;
                                if( targLevel < 0 ) then
                                    stats.duelWinAvgLevelDiff = stats.duelWinAvgLevelDiff + v3.wins*(targLevel-playerLevel);
                                else
                                    stats.duelWinAvgLevelDiff = stats.duelWinAvgLevelDiff + v3.wins*(targLevel-playerLevel);
                                end
                                stats.duelLoss = stats.duelLoss + v3.loss;
                                if( targLevel < 0 ) then
                                    stats.duelLossAvgLevelDiff = stats.duelLossAvgLevelDiff + v3.loss*(targLevel-playerLevel);
                                else
                                    stats.duelLossAvgLevelDiff = stats.duelLossAvgLevelDiff + v3.loss*(targLevel-playerLevel);
                                end
                            end
                        end);
                end
                end);
            end);

    stats.totalWinAvgLevelDiff = stats.totalWinAvgLevelDiff / stats.totalWins;
    stats.totalLossAvgLevelDiff = stats.totalLossAvgLevelDiff / stats.totalLoss;
    stats.pvpWinAvgLevelDiff = stats.pvpWinAvgLevelDiff / stats.pvpWins;
    stats.pvpLossAvgLevelDiff = stats.pvpLossAvgLevelDiff / stats.pvpLoss;
    stats.duelWinAvgLevelDiff = stats.duelWinAvgLevelDiff / stats.duelWins;
    stats.duelLossAvgLevelDiff = stats.duelLossAvgLevelDiff / stats.duelLoss;

    return stats;
end

function PvPLogFriends(race1, race2)
    local alliance = { "Human", "Night Elf", "Dwarf", "Gnome" };
    local horde = { "Orc", "Tauren", "Undead", "Troll" };

    local found1 = false;
    local found2 = false;

    table.foreach( alliance,
        function( i,v )
            if( v == race1 ) then
                found1 = true;
            end
            if( v == race2 ) then
                found2 = true;
            end
        end);

    if( found1 and found2 ) then
        return true;
    end

    found1 = false;
    found2 = false;

    table.foreach( horde,
        function( i,v )
            if( v == race1 ) then
                found1 = true;
            end
            if( v == race2 ) then
                found2 = true;
            end
        end);

    return (found1 and found2);
end

function PvPLogRecord(vname,vlevel,vrace,vclass,vguild,venemy,win)
    -- deal with vlevel being negative 1 when they're 10 levels
    -- or more greater
    if( vlevel == -1 ) then
        vlevel = -plevel - 11;
    end

    -- check to see if we've encountered this person before
    if( PvPLogData[realm][player].battles[vname] == nil ) then
        PvPLogData[realm][player].battles[vname] = { };
    end
    if( PvPLogData[realm][player].battles[vname][vlevel] == nil ) then
        PvPLogData[realm][player].battles[vname][vlevel] = { };
    end
    if( PvPLogData[realm][player].battles[vname][vlevel][plevel] == nil ) then
        PvPLogData[realm][player].battles[vname][vlevel][plevel] = { };
        PvPLogData[realm][player].battles[vname][vlevel][plevel].wins = 0;
        PvPLogData[realm][player].battles[vname][vlevel][plevel].loss = 0;
    end
    
    -- record info
    PvPLogData[realm][player].battles[vname].race = vrace;
    PvPLogData[realm][player].battles[vname].class = vclass;
    PvPLogData[realm][player].battles[vname].guild = vguild;
    PvPLogData[realm][player].battles[vname].enemy = venemy;

    local x, y = GetPlayerMapPosition("player");
    x = math.floor(x*100);
    y = math.floor(y*100);
    local notifyMsg = "";
    local notifySystem = nil;

    local vleveltext = vlevel;
    if( vlevel < 0 ) then
        vleveltext = (-vlevel) .. "+";
    end
    
    if( win ) then
        PvPLogData[realm][player].battles[vname][vlevel][plevel].wins = 
            PvPLogData[realm][player].battles[vname][vlevel][plevel].wins + 1;

        notifyMsg = PvPLogData[realm][player].notifyKillText;
        notifyMsg = string.gsub( notifyMsg, "%%n", vname );
        notifyMsg = string.gsub( notifyMsg, "%%l", vleveltext );
        notifyMsg = string.gsub( notifyMsg, "%%r", vrace );
        notifyMsg = string.gsub( notifyMsg, "%%c", vclass );
        if( vguild ) then
            notifyMsg = string.gsub( notifyMsg, "%%g", vguild );
        end
        notifyMsg = string.gsub( notifyMsg, "%%x", x );
        notifyMsg = string.gsub( notifyMsg, "%%y", y );
        notifyMsg = string.gsub( notifyMsg, "%%z", GetZoneText() );
        --notifyMsg = notifyMsg .. "I killed " .. vname .. 
        --    " (Level " .. vleveltext .. " " .. vrace .. " " .. vclass;
        --if( vguild ) then
        --    notifyMsg = notifyMsg .. ", from " .. vguild;
        --end
        --notifyMsg = notifyMsg .. ") at [" ..x..","..y .. "] in " .. GetZoneText();
        --notifyMsg = notifyMsg .. ") at [" ..x..","..y .. "]";

        notifySystem = PvPLogData[realm][player].notifyKill;
    else
        PvPLogData[realm][player].battles[vname][vlevel][plevel].loss = 
            PvPLogData[realm][player].battles[vname][vlevel][plevel].loss + 1;

        --notifyMsg = notifyMsg .. vname .. 
        --    " (Level " .. vleveltext .. " " .. vrace .. " " .. vclass;
        --if( vguild ) then
        --    notifyMsg = notifyMsg .. ", from " .. vguild;
        --end
        --notifyMsg = notifyMsg .. ") just killed me at [" ..x..","..y .. "]";

        notifyMsg = PvPLogData[realm][player].notifyDeathText;
        notifyMsg = string.gsub( notifyMsg, "%%n", vname );
        notifyMsg = string.gsub( notifyMsg, "%%l", vleveltext );
        notifyMsg = string.gsub( notifyMsg, "%%r", vrace );
        notifyMsg = string.gsub( notifyMsg, "%%c", vclass );
        if( vguild ) then
            notifyMsg = string.gsub( notifyMsg, "%%g", vguild );
        end
        notifyMsg = string.gsub( notifyMsg, "%%x", x );
        notifyMsg = string.gsub( notifyMsg, "%%y", y );
        notifyMsg = string.gsub( notifyMsg, "%%z", GetZoneText() );

        notifySystem = PvPLogData[realm][player].notifyDeath;

        -- fix to double recording of deaths
        -- likely caused by blizzard sending PLAYER_DEAD twice
        lastDamagerToMe = "";
    end

    if( venemy and
          ((notifySystem == "party" and GetNumPartyMembers() > 0) or 
           (notifySystem == "guild" and GetGuildInfo("player") )  or 
           (notifySystem == "raid"  and GetNumRaidMembers() > 0)) ) then
        SendChatMessage(notifyMsg, notifySystem);
    elseif( venemy and notifySystem ~= "none" and notifySystem ~= "party" and
            notifySystem ~= "guild" and notifySystem ~= "raid" ) then
        PvPLogSendMessageOnChannel(notifyMsg, notifySystem);
    end

    PvPLogUpdateTargetText();
end


function PvPLogUpdateTargetText()
    local field = getglobal("PvPLogTargetText");

    if( UnitName("target") ) then
        local total = PvPLogGetPvPTotals(UnitName("target"));
        local guildTotal = PvPLogGetGuildTotals(GetGuildInfo("target"));
        local msg = "";
        local show = false;
        if( total and (total.wins > 0 or total.loss > 0) ) then
            msg = msg .. CYAN .. "PvP: " .. GREEN .. total.wins.. CYAN .. " / " .. RED .. total.loss;
            show = true;
        end
        if( guildTotal and (guildTotal.wins > 0 or guildTotal.loss > 0) and 
            (not total or total.wins ~= guildTotal.wins or total.loss ~= guildTotal.loss) ) then
            if( show ) then
                msg = msg .. CYAN .. " - ";
            end
            msg = msg .. CYAN .. "Guild: ";
            msg = msg .. GREEN .. guildTotal.wins.. CYAN .. " / ".. RED .. guildTotal.loss;
            show = true;
        end
        if( show ) then
            field:SetText(msg);
            field:Show();
        end
    end
end

function PvPLogSendMessageOnChannel(message, channelName)
	local channelNum = PvPLogGetChannelNumber(channelName);

	if (not channelNum or channelNum == 0) then
		PvPLogJoinChannel(channelName);
        channelNum = PvPLogGetChannelNumber(channelName);
	end

	if (not channelNum or channelNum == 0) then
		PvPLogChatMsg(MAGENTA.."PvPLog Error: Not in notification channel \""..channelName.."\".");
		return;
	end

	SendChatMessage(message, "CHANNEL", GetLanguageByIndex(0), channelNum);
end


function PvPLogGetChannelNumber(channel)
	local num = 0;
	for i = 1, 200, 1 do
		local channelNum, channelName = GetChannelName(i);

		if ((channelNum > 0) and channelName and (string.lower(channelName) == string.lower(channel))) then
			num = channelNum;
			break;
		end
	end
	
	return num;
end

function PvPLogJoinChannel(channelName)
    local channelNumber = PvPLogGetChannelNumber(channelName);
    local needToJoin = (channelNumber <= 0);

    if( needToJoin ) then
        local i = 1;
		while ( DEFAULT_CHAT_FRAME.channelList[i] ) do
			local zoneValue = "nil";
			if (DEFAULT_CHAT_FRAME.zoneChannelList[i])
			then
				zoneValue = DEFAULT_CHAT_FRAME.zoneChannelList[i];
			end
			if ( string.lower(DEFAULT_CHAT_FRAME.channelList[i]) == string.lower(channelName) and 
				DEFAULT_CHAT_FRAME.zoneChannelList[i] and DEFAULT_CHAT_FRAME.zoneChannelList[i] > 0)
			then
				needToJoin = false;
				break;
			end
			i = i + 1;
		end

		JoinChannelByName(channelName, "", DEFAULT_CHAT_FRAME:GetID());
		DEFAULT_CHAT_FRAME.channelList[i] = channelName;
		DEFAULT_CHAT_FRAME.zoneChannelList[i] = 0;
	end
end
