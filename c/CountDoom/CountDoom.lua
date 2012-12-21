-- CountDoom
-- Author: Scrum
-- based on work by Justin Milligan


-- USEFUL STUFF
-- isDemon = UnitCreatureType("target") == "Demon"
-- isElemental = UnitCreatureType("target") == "Elemental"
-- local targetName = UnitName("target");
-- TargetByName( targetName )


CD_DefaultConfig = {};
-- 0.3 config items
CD_DefaultConfig.isLocked = true;
CD_DefaultConfig.announceSpells = "never";
CD_DefaultConfig.playSounds = true;
CD_DefaultConfig.flashSpells = true;
CD_DefaultConfig.enable = true;
CD_DefaultConfig.layout = "vertical";
CD_DefaultConfig.scale = "small";
CD_DefaultConfig.hseconds = false;
CD_DefaultConfig.postExpireDelay = 0;
CD_DefaultConfig.outofcombatDelay = 0;
CD_DefaultConfig.announceChannel = nil;

CountDoom = {};
CountDoom.debugVerbose = false;
CountDoom.debugEvents = false;
CountDoom.initialized = false;
CountDoom.playerName = nil;
CountDoom.realmName = nil;
CountDoom.activeSpell = nil;
CountDoom.soundPath = "Interface\\AddOns\\CountDoom\\";
CountDoom.targetID = 0;
CountDoom.targetName = nil;
CountDoom.activeSpell = nil;
CountDoom.totalTime = 0;
CountDoom.activeSpellWaitingForTarget = nil;
CountDoom.petTargetName = nil;
CountDoom.petTargeLevel = 0;
CountDoom.petActiveSpell = nil;
CountDoom.lastSpellID = -1;
CountDoom.spellRank = nil;
CountDoom.timeRemoveAllTimers = nil;
CountDoom.event = {};
CountDoom.event.castSpellName = nil;
CountDoom.event.castMode = nil;
CountDoom.event.castTarget = nil;
CountDoom.event.removedSpellName = nil;
CountDoom.event.removedLastReason = nil;
CountDoom.event.removedTarget = nil;


CountDoom.prt = function( msg, r, g, b )
    local msgOutput = DEFAULT_CHAT_FRAME;
    if( msgOutput ) then
        msgOutput:AddMessage( msg, r, g, b );
    end
end;


CountDoom.CombatPrint = function( msg, r, g, b )
    local msgOutput = ChatFrame2;
    if( msgOutput ) then
        msgOutput:AddMessage( msg, r, g, b );
    end
end;


CountDoom.dpf = function(arg1)
    if (CountDoom.debugVerbose) then
        CountDoom.prt("CountDoom<DEBUG>: " .. arg1);
        debuginfo( arg1 );
    end
end;


CountDoom.ToStr = function(arg1)
    local argType = type( arg1 );
    
    if argType == "nil" then
        return "nil";
    elseif argType == "boolean" then
        if arg1 then 
            return COUNTDOOM_TRUE;
        else
            return COUNTDOOM_FALSE;
        end
    else
        return "" .. arg1;
    end
end;


CountDoom.DisplaySettings = function()
    CountDoom.prt( "Locked: " .. CountDoom.ToStr( CountDoom.config.isLocked ) );
    CountDoom.prt( "Announce Spells: " .. CountDoom.ToStr( CountDoom.config.announceSpells ) );
    CountDoom.prt( "Announce channel: " .. CountDoom.ToStr( CountDoom.config.announceChannel ) );
    CountDoom.prt( "Flash Spells: " .. CountDoom.ToStr( CountDoom.config.flashSpells ) );
    CountDoom.prt( "Play sounds: " .. CountDoom.ToStr( CountDoom.config.playSounds ) );
    CountDoom.prt( "Layout: " .. CountDoom.ToStr( CountDoom.config.layout ) );
    CountDoom.prt( "Scale: " .. CountDoom.ToStr( CountDoom.config.scale ) );
    CountDoom.prt( "Out of combat delay: " .. CountDoom.ToStr( CountDoom.config.outofcombatDelay ) );
    CountDoom.prt( "Delay after expiration: " .. CountDoom.ToStr( CountDoom.config.postExpireDelay ) );
    CountDoom.prt( "Display Hundredths: " .. CountDoom.ToStr( CountDoom.config.hseconds ) );
end;


CountDoom.DisplayCommands = function()
    CountDoom.prt("CountDoom Usage:");
    CountDoom.prt("/cd <enable|disable>        -- enable/disable CountDoom" );
    CountDoom.prt("/cd <lock|unlock>           -- lock/unlock timers" );
    CountDoom.prt("/cd announce                -- toggle per spell announce" );
    CountDoom.prt("/cd play                    -- toggle per spell sounds" );
    CountDoom.prt("/cd flash                   -- toggle warning flashes" );
    CountDoom.prt("/cd layout                  -- cycle layout styles horiz/vert/text" );
    CountDoom.prt("/cd scale                   -- cycle icon scale" );
    CountDoom.prt("/cd <spell>                 -- dump spell information" );
    CountDoom.prt("/cd <spell>  start          -- debug: start a spell" );
    CountDoom.prt("/cd <spell>  end            -- debug: end a spell" );
    CountDoom.prt("/cd <spell>  toggle         -- enable disable tracking a spell" );
    CountDoom.prt("/cd ooc <seconds>           -- delay before removing all timers" );
    CountDoom.prt("/cd expire <seconds>        -- delay before removing expired timers" );
    CountDoom.prt("/cd hseconds    	         -- display Hundredths of a second" );
    CountDoom.prt("/cd debug    verbose        -- verbose debug msgs" );
end;


CountDoom.RegisterWorldEvents = function()

    -- Need to detect changes to enslaved demon state
    this:RegisterEvent("LOCALPLAYER_PET_CHANGED");
    this:RegisterEvent("UNIT_PET");

    this:RegisterEvent("SPELLCAST_STOP");
    this:RegisterEvent("SPELLCAST_FAILED");
    this:RegisterEvent("SPELLCAST_INTERRUPTED");
    
    -- Used for clearing timers after combat
    this:RegisterEvent("PLAYER_REGEN_ENABLED");
    this:RegisterEvent("PLAYER_REGEN_DISABLED");

    -- Used to determine the target ID of a timer.  It counts how many times
    -- a player changes target (including back and forth)
    this:RegisterEvent("PLAYER_TARGET_CHANGED");

    -- Used to detect when a spell was resisted or immune
    this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");

    -- Used to detect when Succubus casts Seduction
    this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
    this:RegisterEvent("CHAT_MSG_SPELL_PET_DAMAGE");

    -- Used to detect when the succubus Seduction fades
    this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");

    -- Used to detect when someone dies.
    this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
end;


CountDoom.RegisterEvents = function()
    -- Used to know when a player zones in.
    this:RegisterEvent("PLAYER_ENTERING_WORLD");
    this:RegisterEvent("PLAYER_LEAVING_WORLD");
    
    CountDoom.RegisterWorldEvents();
end;


CountDoom.UnregisterWorldEvents = function()
    -- Need to detect changes to enslaved demon state
    this:UnregisterEvent("LOCALPLAYER_PET_CHANGED");
    this:UnregisterEvent("UNIT_PET");

    this:UnregisterEvent("SPELLCAST_STOP");
    this:UnregisterEvent("SPELLCAST_FAILED");
    this:UnregisterEvent("SPELLCAST_INTERRUPTED");
    
    -- Used for clearing timers after combat
    this:UnregisterEvent("PLAYER_REGEN_ENABLED");
    this:UnregisterEvent("PLAYER_REGEN_DISABLED");

    -- Used to determine the target ID of a timer.  It counts how many times
    -- a player changes target (including back and forth)
    this:UnregisterEvent("PLAYER_TARGET_CHANGED");

    -- Used to detect when a spell was resisted or immune
    this:UnregisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");

    -- Used to detect when Succubus casts Seduction
    this:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
    this:UnregisterEvent("CHAT_MSG_SPELL_PET_DAMAGE");

    -- Used to detect when the succubus Seduction fades
    this:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");

    -- Used to detect when someone dies.
    this:UnregisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
end;


CountDoom.UnregisterEvents = function()
    -- Used to know when a player zones in.
    this:UnregisterEvent("PLAYER_ENTERING_WORLD");
    this:UnregisterEvent("PLAYER_LEAVING_WORLD");
    
    CountDoom.UnregisterWorldEvents();
end;


CountDoom.RegisterCommands = function()
    SLASH_COUNTDOOM1 = "/countdoom";
    SLASH_COUNTDOOM2 = "/cd";
    SlashCmdList["COUNTDOOM"] = function(msg)
        CountDoomSlash(msg);
    end
end;


-- Credit to Morbain for the logic
CountDoom.UpdateDurations = function()
    local tab, talent;
    local numTalentTabs = GetNumTalentTabs();
    CountDoom.dpf( "Talent Tabs: " .. CountDoom.ToStr( numTalentTabs ) );

    for tab = 1, numTalentTabs do
        local numTalents = GetNumTalents(tab);
        CountDoom.dpf( "Talents: " .. CountDoom.ToStr( numTalents ) );
        for talent=1, numTalents do
    		local name, iconTexture, tier, column, rank, maxRank, isExceptional, meetsPrereq = 
                GetTalentInfo(tab, talent);
            if name then
                CountDoom.dpf( "("..tab..","..talent .. "): " .. name .. "= " .. rank .. "(" .. maxRank .. 
")" );
            end
        end
    end

    local duration = CountDoomSpell[ "seduce" ].rankDuration[1];

    -- Determine if the player has improved succubus which increases timer duration.
    local _, texture, _, _, rank, _, _, _ = GetTalentInfo(2, 7);
    if (texture) then
        duration = duration + (duration * 0.1 * rank)
    end

    CountDoomSpell[ "seduce" ].rankDuration[1] = duration;
end;


CountDoom.UpdateLayout = function()
    if CountDoom.config.layout == "horizontal" then
        CDTimers_LayoutHorizontal();
    elseif CountDoom.config.layout == "textonly" then
        CDTimers_LayoutTextOnly();
    else
        CDTimers_LayoutVertical();
    end
    CDTimerSpell_UpdateSpellPrefixes();
end;


CountDoom.CycleScale = function()
    if CountDoom.config.scale == "small" then
        CountDoom.config.scale = "medium";
    elseif CountDoom.config.scale == "medium" then
        CountDoom.config.scale = "large";
    else
        CountDoom.config.scale = "small";
    end
    CountDoom.UpdateLayout();
    CountDoom.prt( "Scale set to: " .. CountDoom.config.scale );
end;



CountDoom.UpdateDragButtons = function()
    if CountDoom.config.isLocked ~= true then
        CountDoomFrame:SetBackdropColor( 1.0, 1.0, 1.0, 1.0 );
        CountDoomFrame:SetBackdropBorderColor( 1.0, 1.0, 1.0, 1.0 );
        CountDoomFrameBackground:SetAlpha(1.0);
        CountDoomFrame:Show();
        getglobal("CountDoomFrameDragButton"):Show();
        CountDoom.dpf("Showing drag buttons.");                   
    else
        CountDoomFrame:SetBackdropColor( 1.0, 1.0, 1.0, 0.0 );
        CountDoomFrame:SetBackdropBorderColor( 1.0, 1.0, 1.0, 0.0 );
        CountDoomFrameBackground:SetAlpha(0.0);
        getglobal("CountDoomFrameDragButton"):Hide();
        CountDoom.dpf("Hiding drag buttons.");                   

        if CDTimer_numTimers == 0 then
            CountDoomFrame:Hide();
        end
    end
end;


CountDoom.RotateLayout = function( frameName )
    if frameName == "CountDoomFrame" then
        if CountDoom.config.layout == "vertical" then
            CountDoom.config.layout = "horizontal";
        elseif CountDoom.config.layout == "horizontal" then
            CountDoom.config.layout = "textonly";
        else
            CountDoom.config.layout = "vertical";
        end
        CountDoom.UpdateLayout();
    end

    CountDoom.prt( "Layout set to: " .. CountDoom.config.layout );
end;


CountDoom.CreateConfig = function( playerName, realmName )
    CountDoom.dpf("Initializing CountDoom.config");                    
    if not CountDoomConfig then
        CountDoom.dpf("Allocating CountDoomConfig");                   
        CountDoomConfig = {};
    end
    
    if not CountDoomConfig[realmName] then
        CountDoomConfig[realmName] = {};
    end
    
    if not CountDoomConfig[realmName][playerName] then
        CountDoomConfig[realmName][playerName] = {};
    end

    if (not CountDoomConfig[realmName][playerName].enableSpell) then
        CountDoomConfig[realmName][playerName].enableSpell = {};
    end
        
    -- set the defaults if the values weren't loaded by the SavedVariables.lua
    if( CountDoomConfig[realmName][playerName].isLocked == nil ) then
        CountDoomConfig[realmName][playerName].isLocked = CD_DefaultConfig.isLocked;
    end
    if( CountDoomConfig[realmName][playerName].warningSound == nil ) then
        CountDoomConfig[realmName][playerName].warningSound = {};
        CountDoomConfig[realmName][playerName].warningSound[ "enslave" ] = "enslavewarning";
    end
    if( CountDoomConfig[realmName][playerName].endSound == nil ) then
        CountDoomConfig[realmName][playerName].endSound = {};
        CountDoomConfig[realmName][playerName].endSound[ "enslave" ] = "enslaveend";
    end
    if( CountDoomConfig[realmName][playerName].announceSpells == nil ) then
        CountDoomConfig[realmName][playerName].announceSpells = CD_DefaultConfig.announceSpells;
    end
    if( CountDoomConfig[realmName][playerName].playSounds == nil ) then
        CountDoomConfig[realmName][playerName].playSounds = CD_DefaultConfig.playSounds;
    end
    if( CountDoomConfig[realmName][playerName].flashSpells == nil ) then
        CountDoomConfig[realmName][playerName].flashSpells = CD_DefaultConfig.flashSpells;
    end
    if( CountDoomConfig[realmName][playerName].enable == nil ) then
        CountDoomConfig[realmName][playerName].enable = CD_DefaultConfig.enable;
    end
    if( CountDoomConfig[realmName][playerName].layout == nil ) then
        CountDoomConfig[realmName][playerName].layout = CD_DefaultConfig.layout;
    end
    if( CountDoomConfig[realmName][playerName].scale == nil ) then
        CountDoomConfig[realmName][playerName].scale = CD_DefaultConfig.scale;
    end
    if( CountDoomConfig[realmName][playerName].hseconds == nil ) then
        CountDoomConfig[realmName][playerName].hseconds = CD_DefaultConfig.hseconds;
    end
    if( CountDoomConfig[realmName][playerName].outofcombatDelay == nil ) then
        CountDoomConfig[realmName][playerName].outofcombatDelay = CD_DefaultConfig.outofcombatDelay;
    end
    if( CountDoomConfig[realmName][playerName].postExpireDelay == nil ) then
        CountDoomConfig[realmName][playerName].postExpireDelay = CD_DefaultConfig.postExpireDelay;
    end
    if( CountDoomConfig[realmName][playerName].announceChannel == nil ) then
        CountDoomConfig[realmName][playerName].announceChannel = CD_DefaultConfig.announceChannel;
    end
end;


CountDoom.Initialize = function ()

    if (CountDoom.initialized == true) then
        CountDoom.dpf("Initialize: already loaded. returning.");                   
        return
    end    
    
    local playerName = UnitName("player");
    local realmName = GetRealmName();
    
    -- if CountDoom.playerName is "Unknown Entity" get out, need a real name
    if (playerName == nil or playerName == UNKNOWNOBJECT) then
        CountDoom.dpf("Initialize: invalid name. returning");                  
        return
    end
    
    CountDoom.playerName = playerName;
    CountDoom.realmName = realmName;
        
    -- Initialize our configuration
    CountDoom.CreateConfig(playerName, realmName);
    
    -- Alias the config to shorten the name.  Hopefully, this save settings otherwise we're toast.
    CountDoom.config = CountDoomConfig[realmName][playerName];

    CountDoom.RegisterEvents();
    CountDoom.RegisterCommands();
    CountDoom.UpdateDurations();
    CountDoom.UpdateLayout();
    CountDoom.UpdateDragButtons();
    CountDoom.GetSpellBookInfo();
    
    -- print out a nice message letting the user know the addon loaded
    CountDoom.prt( COUNTDOOM_LOADED );

    -- All variables are loaded now
    CountDoom.initialized = true;
end;


-- Sets the warning sound. (FUTURE USE)
CountDoom.SetWarningSound = function(spellAbbreviation, msg)
    CountDoom.config.warningSound[ spellAbbreviation ] = msg;
    CountDoom.prt( string.format( COUNTDOOM_SETWARNINGSOUNDMSG, warningSound[ spellAbbreviation ] )  );
end;


-- Sets the end sound. (FUTURE USE)
CountDoom.SetEndSound = function(spellAbbreviation, msg)
    CountDoom.config.endSound[ spellAbbreviation ] = msg;
    CountDoom.prt( string.format( COUNTDOOM_SETENDSOUNDMSG, CountDoom.config.endSound[ spellAbbreviation ] )  );
end;


CountDoom.ToggleAnnouncingSpells = function()
    if CountDoom.config.announceSpells == nil or CountDoom.config.announceSpells == "never" then
        CountDoom.config.announceSpells = "local";
    elseif CountDoom.config.announceSpells == "local" then
        CountDoom.config.announceSpells = "party";
    elseif CountDoom.config.announceSpells == "party" then
        CountDoom.config.announceSpells = "raid";
    elseif CountDoom.config.announceSpells == "raid" then
        CountDoom.config.announceSpells = "channel";
    elseif CountDoom.config.announceSpells == "channel" then
        CountDoom.config.announceSpells = "all";
    else
        CountDoom.config.announceSpells = "never";
    end

    CountDoom.prt( "Spells will be announced: " .. CountDoom.config.announceSpells );
end;


CountDoom.SetEnable = function( enable )
    CountDoom.config.enable = enable;
    if( CountDoom.config.enable == true ) then
        CountDoom.prt( COUNTDOOM_ENABLEDMSG );
    else
        CountDoom.prt( COUNTDOOM_DISABLEDMSG );
    end
end;


CountDoom.SetLocked = function( locked )
    CountDoom.config.isLocked = locked;
    if( CountDoom.config.isLocked == true ) then
        CountDoom.prt( COUNTDOOM_LOCKED );
    else
        CountDoom.prt( COUNTDOOM_UNLOCKED );
    end
    
    CountDoom.UpdateDragButtons();
end;


CountDoom.ToggleFlashingSpells = function ()
    if( CountDoom.config.flashSpells == true ) then
        CountDoom.config.flashSpells = false;
        CountDoom.prt( COUNTDOOM_NOFLASHMSG );
    else
        CountDoom.config.flashSpells = true;
        CountDoom.prt( COUNTDOOM_YESFLASHMSG );
    end
end;


CountDoom.TogglePlayingSounds = function ()
    if( CountDoom.config.playSounds == true ) then
        CountDoom.config.playSounds = false;
        CountDoom.prt( COUNTDOOM_NOSOUNDSMSG );
    else
        CountDoom.config.playSounds = true;
        CountDoom.prt( COUNTDOOM_YESSOUNDSMSG );
    end
end;


CountDoom.ToggleHseconds = function ()
    if( CountDoom.config.hseconds == true ) then
        CountDoom.config.hseconds = false;
        CountDoom.prt( COUNTDOOM_HSECONDS_OFF );
    else
        CountDoom.config.hseconds = true;
        CountDoom.prt( COUNTDOOM_HSECONDS_ON );
    end
end;


CountDoom.SetOOCTime = function ( delayString )
    if delayString ~= nil then
        local oocTime = tonumber( delayString );
        if oocTime ~= nil then
            CountDoom.config.outofcombatDelay = oocTime;
        end 
    end
    
    CountDoom.prt( "Out of combat delay is: " .. CountDoom.ToStr( CountDoom.config.outofcombatDelay ) );
end;


CountDoom.SetPostExpireDelay = function ( delayString )
    if delayString ~= nil then
        local expireDelayTime = tonumber( delayString );
        if expireDelayTime ~= nil then
            CountDoom.config.postExpireDelay = expireDelayTime;
        end 
    end
    
    CountDoom.prt( "Delay before removing expired timers: " .. CountDoom.ToStr( CountDoom.config.postExpireDelay ) );
end;


CountDoom.SetAnnounceChannel = function( channelName )
    if channelName ~= nil then
        CountDoom.config.announceChannel = channelName;
    end
    CountDoom.prt( "Announce channel: " .. CountDoom.ToStr( CountDoom.config.announceChannel ) );
end;


CountDoom.DumpEvents = function ()
    CountDoom.prt( "Last spell cast: " .. CountDoom.ToStr( CountDoom.event.castSpellName ) );
    CountDoom.prt( "Mode: " .. CountDoom.ToStr( CountDoom.event.castMode ) );
    CountDoom.prt( "Target: " .. CountDoom.ToStr( CountDoom.event.castTarget ) );
    CountDoom.prt( "Last spell removed: " .. CountDoom.ToStr( CountDoom.event.removedSpellName ) );
    CountDoom.prt( "Removal reason: " .. CountDoom.ToStr( CountDoom.event.removedLastReason ) );
    CountDoom.prt( "Target: " .. CountDoom.ToStr( CountDoom.event.removedTarget ) );
end;


CountDoom.FilterTimer = function( spellName )
    CountDoom.dpf( "CD: CountDoom.FilterTimer " .. CountDoom.ToStr( spellName ) );

    -- Destroy the last active spell
    CountDoom.activeSpell = nil;

	if (CountDoom.lastSpellID == nil or CountDoom.lastSpellID == -1 or
        CountDoom.replacedASpell) then
        return;
    end

    local spellIndex = CDTimerSpell_GetSpellIndex( CountDoom.lastSpellID );
    local spellNameLast = nil;

    if spellIndex ~= -1 then
        spellNameLast = CDTimerSpell_GetSpellName( spellIndex );
    end
    
    if spellNameLast == spellName then
    	CDTimerSpell_DeleteIndex( spellIndex );	
    end

    CountDoom.lastSpellID = -1;
end;


function CountDoomSlash(msg)

    msg = string.lower(msg);
    local a, b, c, n = string.find (msg, "(%w+) ([_%w]+)");
    
    if( c == nil and n == nil ) then
        a, b, c = string.find (msg, "(%w+)");
    end
    
    if (c ~= nil) then
        CountDoom.dpf("c:"..c);
    else
        CountDoom.dpf("c: nil");
    end
    
    if (n ~= nil) then
        CountDoom.dpf("n:"..n);
    else
        CountDoom.dpf("n: nil");
    end

    if (c == nil) then
        CountDoom.DisplayCommands();
        CountDoom.DisplaySettings();
        return;
    end
    
    if( CountDoomSpell[ c ] ~= nil ) then
        if( n == "start" ) then
        
            local targetInfo = {};
            targetInfo.targetName = UnitName( "target" );
            targetInfo.targetLevel = UnitLevel( "target" );
            targetInfo.id = CountDoom.targetID;
            
            CountDoom.lastSpellID, CountDoom.replacedASpell = CDTimerSpell_CreateBySpellAbbreviation( c, targetInfo, nil );
            
        elseif( n == "end" ) then
            CDTimerSpell_DestroyBySpellAbbreviation( c );

            CountDoom.event.removedSpellName = c;
            CountDoom.event.removedLastReason = "/cd " .. c .. " end";
            CountDoom.event.removedTarget = nil;
        elseif( n == "toggle" ) then
            CountDoomSpell.ToggleEnabled( c );
        elseif( n == "play" ) then
            CountDoomSpell.ToggleSound( c );
        elseif( n == "announce" ) then
            CountDoomSpell.ToggleAnnounce( c );
        elseif( n == nil ) then
            CountDoomSpell.Dump( c );
        end
    elseif( c == "announce" ) then
        CountDoom.ToggleAnnouncingSpells();        
    elseif( c == "play" ) then
        CountDoom.TogglePlayingSounds();
    elseif( c == "flash" ) then
        CountDoom.ToggleFlashingSpells();
    elseif( c == "debug" ) then
        if( n == "verbose" ) then
            if( CountDoom.debugVerbose == true ) then
                CountDoom.debugVerbose = false;
                CountDoom.dpf( "debugVerbose is off" );
            else
                CountDoom.debugVerbose = true;
                CountDoom.dpf( "debugVerbose is on" );
            end
        elseif( n == "events" ) then
            if( CountDoom.debugEvents == true ) then
                CountDoom.debugEvents = false;
                CountDoom.prt( "debugEvents is off" );
            else
                CountDoom.debugEvents = true;
                CountDoom.prt( "debugEvents is on" );
            end
        elseif( n == "dump" ) then
            CountDoom.DumpEvents();
        end
    elseif( c == "enable" ) then
        CountDoom.SetEnable( true );
    elseif( c == "disable" ) then
        CountDoom.SetEnable( false );
    elseif( c == "layout" ) then
        CountDoom.RotateLayout( "CountDoomFrame" );
    elseif( c == "unlock" ) then
        CountDoom.SetLocked( false );
    elseif( c == "lock" ) then
        CountDoom.SetLocked( true );
    elseif( c == "scale" ) then
        CountDoom.CycleScale();
    elseif( c == "hseconds" ) then
        CountDoom.ToggleHseconds();
    elseif( c == "ooc" and n ~= nil ) then
        CountDoom.SetOOCTime( n );
    elseif( c == "expire" and n ~= nil ) then
        CountDoom.SetPostExpireDelay( n );
    elseif( c == "channel" ) then
        CountDoom.SetAnnounceChannel( n );
    end
end


function CDFrame_OnUpdate(elapsed)
    CountDoom.totalTime = CountDoom.totalTime + elapsed;

    if CountDoom.timeRemoveAllTimers ~= nil then

        -- Dont' remove timers if we have a pending spell to cast
        if CountDoom.activeSpell ~= nil then
            CountDoom.timeRemoveAllTimers = nil;
            return;
        end

        if GetTime() >= CountDoom.timeRemoveAllTimers then
            CountDoom.event.removedSpellName = "All timers";
            CountDoom.event.removedLastReason = event;
            CountDoom.event.removedTarget = nil;

            CDTimerSpell_RemoveCombatSpellTimers();
            CountDoom.timeRemoveAllTimers = nil;
        end
    end
end


function CDFrame_OnLoad()
    -- Used for initialization of the mod
    this:RegisterEvent("VARIABLES_LOADED");
end


function CDFrame_OnEvent(event)

    -- Keep track of the events
    if CountDoom.debugVerbose or CountDoom.debugEvents then
        local msg = "Event: " .. event .. ": " .. CountDoom.ToStr( arg1 ) .. " " .. CountDoom.ToStr( arg2 );
        
        if CountDoom.debugEvents then
            CountDoom.CombatPrint(msg);
        end

        CountDoom.dpf(msg);
    end        
    
    -- Initialize as soon as the player logs in
    if (event == "VARIABLES_LOADED") then
        CountDoom.Initialize();
        return;
    end
    
    if CountDoom.initialized ~= true then
        return;
    end 
    
    if CountDoom.config.enable ~= true then 
        return;
    end 

    if UnitClass("player") ~= COUNTDOOM_WARLOCK then
        return;
    end
    
    -- Pet status changed
    if (event == "UNIT_PET" and arg1 == "player") or 
       (event == "LOCALPLAYER_PET_CHANGED") then
        
        if (UnitIsFriend("player", "pet")) then
            local iIterator = 1
            while (UnitDebuff("pet", iIterator)) do
                local debuffString = UnitDebuff("pet", iIterator);
                CountDoom.dpf( "Debuff[" .. iIterator .. "] " .. debuffString);
                if (string.find(debuffString, COUNTDOOMDEBUFF_ENSLAVEDEMON)) then
                
                    local targetInfo = {};
                    targetInfo.targetName = UnitName( "target" );
                    targetInfo.targetLevel = UnitLevel( "target" );
                    targetInfo.id = CountDoom.targetID;
                    
                    CountDoom.lastSpellID, CountDoom.replacedASpell = CDTimerSpell_CreateBySpellAbbreviation( "enslave", targetInfo, nil );
                end                       
                iIterator = iIterator + 1
            end 
        else
            CDTimerSpell_DestroyBySpellAbbreviation( "enslave" );

            CountDoom.event.removedSpellName = "enslave";
            CountDoom.event.removedLastReason = event;
            CountDoom.event.removedTarget = nil;
        end

    -- Started casting a spell (DEBUG)
    elseif event == "SPELLCAST_START" then
    
        --We used to track the activeSpell name by monitoring this event but
        --unfortunately it doesn't track insta-cast spells
        
    -- Spell casting was interrupted
    elseif event == "SPELLCAST_INTERRUPTED" or event == "SPELLCAST_FAILED" then

        CountDoom.activeSpell = nil;
        CountDoom.targetName = nil;
        CountDoom.targetLevel = 0;
        CountDoom.activeSpellWaitingForTarget = nil;

        if CountDoom.lastSpellID ~= -1 and CountDoom.replacedASpell == false then
            CDTimerSpell_DeleteID( CountDoom.lastSpellID );	

            CountDoom.event.removedSpellName = "spellID: " .. CountDoom.lastSpellID;
            CountDoom.event.removedLastReason = event;
            if CDTimerSpells[ CountDoom.lastSpellID ] ~= nil then
                CountDoom.event.removedTarget = CDTimerSpells[ CountDoom.lastSpellID ].targetName;
            else
                CountDoom.event.removedTarget = nil;
            end
        end
        
        CountDoom.lastSpellID = -1;
        CountDoom.replacedASpell = false;

    -- User stopped casting a spell
    elseif event == "SPELLCAST_STOP" then

        if CountDoom.activeSpell ~= nil then
            local targetInfo = {};
            targetInfo.targetName = CountDoom.targetName;
            targetInfo.targetLevel = CountDoom.targetLevel;
            targetInfo.id = CountDoom.targetID;

            -- We are likely to enter combat.  Don't delete timers immediately.
            CountDoom.timeRemoveAllTimers = nil;
        
            CountDoom.lastSpellID, CountDoom.replacedASpell = CDTimerSpell_CreateBySpellName(
                CountDoom.activeSpell, targetInfo, CountDoom.spellRank );
            CountDoom.activeSpell = nil;
        end
    
    -- Player has left combat
    elseif event == "PLAYER_REGEN_ENABLED" then
        
        CountDoom.timeRemoveAllTimers = GetTime() + CountDoom.config.outofcombatDelay;

    -- Player has entered combat
    elseif event == "PLAYER_REGEN_DISABLED" then

        CountDoom.timeRemoveAllTimers = nil;

    -- Pet has cast a spell (DEBUG)
    elseif(event == "CHAT_MSG_SPELL_PET_DAMAGE") then
		arg1 = string.gsub(arg1," %(.+%)","") -- strip trailing ()'s we don't use
		arg1 = string.gsub(arg1,"%.$","") -- strip trailing .'s
		
        local found,_,casterName,spellName,index3,index4,index5 = string.find(arg1, CD_SPELLCASTOTHERSTART);
        if found then
            CountDoom.dpf( "CD: " .. CountDoom.ToStr( casterName ) .. " begins to cast " .. CountDoom.ToStr( spellName ) );
            
            CountDoom.petTargetName = UnitName( "pettarget" );
            CountDoom.petTargeLevel = UnitLevel( "pettarget" );
            CountDoom.petActiveSpell = spellName;
        end

    elseif(event == "CHAT_MSG_SPELL_SELF_DAMAGE") then
		arg1 = string.gsub(arg1," %(.+%)","") -- strip trailing ()'s we don't use
		arg1 = string.gsub(arg1,"%.$","") -- strip trailing .'s

        -- Determine if the target resisted
        local found,_,spellName,mobName,index3,index4,index5 = string.find(arg1, CD_SPELLRESISTSELFOTHER);
        if found then
            CountDoom.dpf( "CD: " .. CountDoom.ToStr( spellName ) .. " was resisted by " .. CountDoom.ToStr( mobName ) );

            CountDoom.FilterTimer( spellName );
            return;
        end

        -- Determine if the target was immune
        local found,_,spellName,mobName,index3,index4,index5 = string.find(arg1, CD_SPELLIMMUNESELFOTHER);
        if found then
            CountDoom.dpf( "CD: " .. CountDoom.ToStr( mobName ) .. " was immune to " .. CountDoom.ToStr( spellName ) );

            CountDoom.FilterTimer( spellName );
            return;
        end

        -- Determine if the target was evaded
        local found,_,spellName,mobName,index3,index4,index5 = string.find(arg1, CD_SPELLEVADEDSELFOTHER);
        if found then
            CountDoom.dpf( "CD: " .. CountDoom.ToStr( mobName ) .. " evaded your " .. CountDoom.ToStr( spellName ) );

            CountDoom.FilterTimer( spellName );
            return;
        end

    -- Creature received damage.  See if Succubus seduced a mob.
    elseif(event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE") then
		arg1 = string.gsub(arg1," %(.+%)","") -- strip trailing ()'s we don't use
		arg1 = string.gsub(arg1,"%.$","") -- strip trailing .'s

        local found,_,mobName,spellName,index3,index4,index5 = string.find(arg1, CD_AURAADDEDOTHERHARMFUL);
        if found and spellName ~= nil then
            CountDoom.dpf( "CD: " .. CountDoom.ToStr( mobName ) .. " is afflicted by " .. CountDoom.ToStr( spellName ) );

            if (spellName == COUNTDOOMSPELL_SEDUCE and CountDoom.petActiveSpell == COUNTDOOMSPELL_SEDUCE) or
               (spellName == COUNTDOOMSPELL_SPELL_LOCK) then
                local targetInfo = {};
                targetInfo.targetName = CountDoom.petTargetName;
                targetInfo.targetLevel = CountDoom.petTargeLevel;
                targetInfo.id = -1;
                
                -- Currently we assume pet casts max rank spell.
                local petRank = nil;
                
                CountDoom.lastSpellID, CountDoom.replacedASpell = CDTimerSpell_CreateBySpellName( spellName, targetInfo, petRank );
                
                CountDoom.petTargetName = nil;
                CountDoom.petTargeLevel = 0;
                CountDoom.petActiveSpell = nil;
            end

            return;
        end

    -- Created lost a debuff.  See if Succubus' seduction had faded.
    elseif(event == "CHAT_MSG_SPELL_AURA_GONE_OTHER") then

		arg1 = string.gsub(arg1," %(.+%)","") -- strip trailing ()'s we don't use
		arg1 = string.gsub(arg1,"%.$","") -- strip trailing .'s

        local found,_,spellName,mobName,index3,index4,index5 = string.find(arg1, CD_AURAREMOVEDOTHER);
        if found then
            CountDoom.dpf( "CD: " .. CountDoom.ToStr( spellName ) .. " fades from " .. CountDoom.ToStr( mobName ) );

            if spellName == COUNTDOOMSPELL_SEDUCE or spellName == COUNTDOOMSPELL_SPELL_LOCK then
                CDTimerSpell_DestroyBySpellName( spellName );

                CountDoom.event.removedSpellName = spellName;
                CountDoom.event.removedLastReason = CHAT_MSG_SPELL_AURA_GONE_OTHER;
                CountDoom.event.removedTarget = mobName;
            end

            return;
        end

    elseif event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" then

		arg1 = string.gsub(arg1," %(.+%)","") -- strip trailing ()'s we don't use
		arg1 = string.gsub(arg1,"%.$","") -- strip trailing .'s

        local found,_,mobName,index3,index4,index5 = string.find(arg1, CD_UNITDIESOTHER);
        if found then
            CountDoom.dpf( "CD: " .. CountDoom.ToStr( mobName ) .. " dies." );

            if UnitIsDead( "target" ) then
                local deletedOne;

                repeat
                    deletedOne = CDTimerSpell_DeleteTarget( CountDoom.targetID );
                until deletedOne == false;
            end;

            return;
        end

    -- Determine if the player has changed targets (FUTURE USE)
    elseif event == "PLAYER_TARGET_CHANGED" then

        -- Keep track of the current targetID
        CountDoom.targetID = CountDoom.targetID + 1;
        if CountDoom.targetID > 10000 then
            CountDoom.targetID = 0;
        end

    -- Player has changed zones
    elseif event == "PLAYER_ENTERING_WORLD" then
        
        CountDoom.timeRemoveAllTimers = GetTime() + CountDoom.config.outofcombatDelay;
        
        CountDoom.RegisterWorldEvents();
        
    -- Player has changed zones
    elseif event == "PLAYER_LEAVING_WORLD" then
    
        CountDoom.UnregisterWorldEvents();
    
    end
end

CountDoom.GetSpellBookInfo = function()
    CountDoom.dpf( "CountDoom.GetSpellBookInfo" );

    local i;
	for i = 1, GetNumSpellTabs(), 1 do
		local name, texture, offset, numSpells = GetSpellTabInfo(i);
		local y;
		for y = 1, numSpells, 1 do
			local spellName, rankName = GetSpellName(offset+y, BOOKTYPE_SPELL);
			local _, _, rankStr = string.find(rankName, "(%d+)");

            local rank = tonumber(rankStr);
            if rank then
                if not CountDoom.spellTable then
                    CountDoom.spellTable = {};
                end;

                if not CountDoom.spellTable[spellName] then
                    CountDoom.spellTable[spellName] = {};
                end
                
                if not CountDoom.spellTable[spellName].maxRank or
                    rank > CountDoom.spellTable[spellName].maxRank then
                    CountDoom.spellTable[spellName].maxRank = rank;
                end

                CountDoom.dpf( "Adding spell (" .. y+offset .. ") " .. spellName .. " rank " .. rank .. " to spellTable" );

                CountDoom.spellTable[spellName][rank] = { ["tab"] = i, ["spell"] = y+offset };
            end
		end
	end
end;


-- SPELLCAST_START event only sets the spell name for spells that are
-- not insta-cast.  To detect insta-cast spells, we need to hook into
-- the CastSpell function.  Once hooked, each spell is placed into a hidden
-- tooltip and the name is extracted.  Courtesy of CT_RaidAssist.

CountDoom.oldCastSpell = CastSpell;
CountDoom.OnCastSpell = function (spellId,spellbookTabNum)
	local spellName, spellRank = GetSpellName(spellId, spellbookTabNum);

    CountDoom.dpf( CountDoom.ToStr( spellName ) .. " " .. CountDoom.ToStr( spellRank ) );
    
    if spellRank ~= nil then
    	local _, _, spellRankString = string.find(spellRank, "(%d+)");
        --local _, _, spellRankString = string.find( spellRank, "[^%d]*(%d+)");
        rank = tonumber(spellRankString);
        
        CountDoom.dpf( "Rank: " .. CountDoom.ToStr( rank ) );
    end;

    CountDoom.spellRank = rank;
    if SpellIsTargeting() then
        CountDoom.activeSpellWaitingForTarget = spellName;
    else
        CountDoom.activeSpell = spellName;
        CountDoom.targetName = UnitName( "target" );
        CountDoom.targetLevel = UnitLevel( "target" );
        CountDoom.lastSpellID = -1;
        CountDoom.replacedASpell = false;

        CountDoom.event.castSpellName = spellName;
        CountDoom.event.castMode = "CastSpell";
        CountDoom.event.castTarget = CountDoom.targetName;
    end
    
    CountDoom.dpf( "Starting cast of: " .. CountDoom.ToStr( spellName ) .. " " .. spellId .. " " .. spellbookTabNum );

    CountDoom.oldCastSpell( spellId, spellbookTabNum );
end;
CastSpell = CountDoom.OnCastSpell;


CountDoom.oldSpellTargetUnit = SpellTargetUnit;
CountDoom.OnSpellTargetUnit = function (unit)
    if CountDoom.activeSpellWaitingForTarget then
        CountDoom.activeSpell = CountDoom.activeSpellWaitingForTarget;
        CountDoom.targetName = UnitName( unit );
        CountDoom.targetLevel = UnitLevel( unit );
        CountDoom.activeSpellWaitingForTarget = nil;
        CountDoom.lastSpellID = -1;
    end

    CountDoom.oldSpellTargetUnit(unit);
end;
SpellTargetUnit = CountDoom.OnSpellTargetUnit;


CountDoom.oldTargetUnit = TargetUnit;
CountDoom.OnTargetUnit = function (unit)
    if CountDoom.activeSpellWaitingForTarget then
        CountDoom.activeSpell = CountDoom.activeSpellWaitingForTarget;
        CountDoom.targetName = UnitName( unit );
        CountDoom.targetLevel = UnitLevel( unit );
        CountDoom.activeSpellWaitingForTarget = nil;
        CountDoom.lastSpellID = -1;
    end
    CountDoom.oldTargetUnit(unit);
end;
TargetUnit = CountDoom.OnTargetUnit;


CountDoom.oldSpellStopTargetting = SpellStopTargetting;
CountDoom.OnSpellStopTargetting = function()
    if CountDoom.activeSpellWaitingForTarget then
        CountDoom.activeSpell = nil;
        CountDoom.targetName = nil;
        CountDoom.targetLevel = 0;
        CountDoom.activeSpellWaitingForTarget = nil;
    end

    CountDoom.oldSpellStopTargetting();
end;
SpellStopTargetting = CountDoom.OnSpellStopTargetting;


CountDoom.oldUseAction = UseAction;
CountDoom.OnUseAction = function (a1, a2, a3)
    
    -- Only process if it isn't a macro
    if GetActionText(a1) == nil then 
   
        CD_SpellDetector:Hide();
        CD_SpellDetector:SetOwner(CountDoomFrame,"ANCHOR_NONE");
        CD_SpellDetector:SetAction(a1);

        local spellName = nil;
        
        if CD_SpellDetectorTextLeft1 ~= nil then
            spellName = CD_SpellDetectorTextLeft1:GetText();
        end;
        
        local spellRank = nil;
        if CD_SpellDetectorTextRight1 ~= nil then 
            spellRank = CD_SpellDetectorTextRight1:GetText();
        end;
        local rank = nil;
        
        if spellRank ~= nil then
            local _, _, spellRankString = string.find( spellRank, "[^%d]*(%d+)");
            rank = tonumber(spellRankString);
        end;
        
        CountDoom.spellRank = rank;
        if SpellIsTargeting() then
            CountDoom.activeSpellWaitingForTarget = spellName;
        else
            CountDoom.activeSpell = spellName;
            CountDoom.targetName = UnitName( "target" );
            CountDoom.targetLevel = UnitLevel( "target" );
            CountDoom.lastSpellID = -1;

            CountDoom.event.castSpellName = spellName;
            CountDoom.event.castMode = "UseAction";
            CountDoom.event.castTarget = CountDoom.targetName;
        end
        
        if ( a3 and a3 == 1 ) then
            CountDoom.activeSpell = nil;
        end
    
        if CountDoom.debugEvents then
            local msg = "UseAction: " .. CountDoom.ToStr( a1 ) .. " " .. CountDoom.ToStr( a2 ) .. " " .. CountDoom.ToStr( a3 );
            msg = msg .. " " .. CountDoom.ToStr( spellName );
            CountDoom.CombatPrint(msg);
        end
        
        CountDoom.dpf( "UseAction cast of: " .. CountDoom.ToStr( spellName ) .. " Rank: " .. CountDoom.ToStr( rank ) );
    end

    CountDoom.oldUseAction(a1, a2, a3);
end;
UseAction = CountDoom.OnUseAction;


CountDoom.oldCastSpellByName = CastSpellByName;
CountDoom.OnCastSpellByName = function(spellString)
   
    local startIndex, endIndex, spellName = string.find( spellString, "(.+)%(" );
    local _, _, spellRankStr = string.find( spellString, "([%d]+)");
    local rank = nil;

    CountDoom.dpf( spellString );
    
    if spellName == nil then
        startIndex, endIndex, spellName = string.find( spellString, "(.+)" );
    end

    if spellName == nil then
        CountDoom.prt( "CountDoom: Error: Unable to determine spell information from: '" .. spellString .. "'");
        CountDoom.prt( "CountDoom: contact mod owner with string for help." );
    end

    if spellRankStr ~= nil then
        CountDoom.dpf( spellRankStr );
        rank = tonumber( spellRankStr );
    end;
    
    CountDoom.spellRank = rank;
    if SpellIsTargeting() then
        CountDoom.activeSpellWaitingForTarget = spellName;
    else
        CountDoom.activeSpell = spellName;
        CountDoom.targetName = UnitName( "target" );
        CountDoom.targetLevel = UnitLevel( "target" );
        CountDoom.lastSpellID = -1;
        CountDoom.replacedASpell = false;

        CountDoom.event.castSpellName = spellName;
        CountDoom.event.castMode = "CastSpellByName";
        CountDoom.event.castTarget = CountDoom.targetName;
    end

    CountDoom.dpf( "CastSpellByName cast of: " .. CountDoom.ToStr( spellName ) .. " Rank: " .. CountDoom.ToStr( rank ) );

    return CountDoom.oldCastSpellByName(spellString);
end;
CastSpellByName = CountDoom.OnCastSpellByName;

--[[  Can't hook this in 1.10

CountDoom.oldCameraOrSelectOrMoveStart = CameraOrSelectOrMoveStart;
function CountDoom.OnCameraOrSelectOrMoveStart()
   -- If we're waiting to target
   local targetName = nil;
   local targetLevel = 0;
   
   if CountDoom.activeSpellWaitingForTarget and UnitName("mouseover") then
       targetName = UnitName("mouseover");
       targetLevel = UnitLevel("mouseover");
   end
   
   CountDoom.oldCameraOrSelectOrMoveStart();
   
   if CountDoom.activeSpellWaitingForTarget then
       CountDoom.activeSpell = CountDoom.activeSpellWaitingForTarget;
       CountDoom.targetName = targetName;
       CountDoom.targetLevel = targetLevel;
       CountDoom.activeSpellWaitingForTarget = nil;
       CountDoom.lastSpellID = -1;
       CountDoom.replacedASpell = false;
   end

end;
CameraOrSelectOrMoveStart = CountDoom.OnCameraOrSelectOrMoveStart;
--]]


