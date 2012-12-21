-- CountDoomSpellTimer stuff
-- Author: Scrum


CDTimerSpell_numSpells = 0;
CDTimerSpell_spellID = 0;


CDTimerSpells = {};
-- timerIndex = timerIndex;    
-- warningHit = false;
-- spellAbbreviation = spellAbbreviation;
-- announceWarning = false;
-- warningSound = false;
-- announceEnd = false;
-- endSound = false;
-- targetName = nil;
-- targetLevel = nil;
-- type = nil;
-- ID = 0;


local function CDTimerSpell_Dump( spellIndex )
    CountDoom.dpf( "Spell#: "            .. spellIndex );
    CountDoom.dpf( "  timerIndex: "      .. CountDoom.ToStr( CDTimerSpells[ spellIndex ].timerIndex ) );
    CountDoom.dpf( "  spellID: "         .. CountDoom.ToStr( CDTimerSpells[ spellIndex ].spellID ) );
    CountDoom.dpf( "  warningHit: "      .. CountDoom.ToStr( CDTimerSpells[ spellIndex ].warningHit ) );
    CountDoom.dpf( "  spellAbbreviation: "       .. CDTimerSpells[ spellIndex ].spellAbbreviation );
    CountDoom.dpf( "  announceWarning: " .. CountDoom.ToStr( CDTimerSpells[ spellIndex ].announceWarning ) );
    CountDoom.dpf( "  warningSound: "    .. CountDoom.ToStr( CDTimerSpells[ spellIndex ].warningSound ) );
    CountDoom.dpf( "  announceEnd: "     .. CountDoom.ToStr( CDTimerSpells[ spellIndex ].announceEnd ) );
    CountDoom.dpf( "  endSound: "        .. CountDoom.ToStr( CDTimerSpells[ spellIndex ].endSound ) );
end


local function CDTimerSpell_DumpAll()
    if CountDoom.debugVerbose then
        local spellIndex;
        for spellIndex = 0, CDTimerSpell_numSpells - 1 do
            CDTimerSpell_Dump( spellIndex );
        end
    end        
end


local function CDTimerSpell_AnnounceMessage( msg )
    if CountDoom.config.announceSpells == nil or CountDoom.config.announceSpells == "never" then
        return;
    end

    local announceRaid = CountDoom.config.announceSpells == "all" or CountDoom.config.announceSpells == "raid";
    local announceParty = CountDoom.config.announceSpells == "all" or CountDoom.config.announceSpells == "party";

    local isRaid = GetNumRaidMembers() > 0;
    local isParty = GetNumPartyMembers() > 0;
    
    if( CountDoom.debugVerbose ) then
        isRaid = false;
        isParty = false;
    end
    
    if( announceRaid and isRaid ) then
        SendChatMessage( msg, "RAID" )
    elseif( announceParty and isParty ) then
        SendChatMessage( msg, "PARTY" );
    elseif ( CountDoom.config.announceSpells == "channel" )and 
           ( CountDoom.config.announceChannel ~= nil ) then

        local channelID = GetChannelName( CountDoom.config.announceChannel );
        if channelID ~= nil then
            SendChatMessage( msg, "CHANNEL", nil, channelID);
        else
            CountDoom.prt( msg, 1, 1, 1);
        end
    else
        CountDoom.prt( msg, 1, 1, 1);
    end
end


function CDTimerSpell_OnTimerWarning( timerIndex, timeUsed )
    local spellIndex = CDTimer_GetUserHandle( timerIndex );
    
    if spellIndex == nil then
        return;
    elseif CDTimerSpells[ spellIndex ].warningHit ~= true then
        if CountDoom.config.flashSpells ~= nil and
            CountDoom.config.flashSpells == true then
            CDTimer_EnableFlash( timerIndex, 2.0 );
        end

        CDTimerSpells[ spellIndex ].warningHit = true;
        
        local spellAbbreviation = CDTimerSpells[ spellIndex ].spellAbbreviation;
        local spellText = CountDoomSpell[ spellAbbreviation ].text;
        
        --
        -- Announce a warning message
        --
        if CDTimerSpells[ spellIndex ].announceWarning then
            local timeRemaining = CountDoomSpell[ spellAbbreviation ].warningTime;
            
            CDTimerSpell_AnnounceMessage( string.format( "%s has %d seconds remaining.", spellText, timeRemaining ) );
        end
        
        --
        -- Play a warning sound
        --
        if CDTimerSpells[ spellIndex ].warningSound and CountDoom.config.playSounds then
            local soundFile = CountDoom.soundPath .. CDTimerSpells[ spellIndex ].warningSound .. ".wav";
            CountDoom.dpf("Playing " .. soundFile);
            PlaySoundFile(soundFile);
        end
    end
end


function CDTimerSpell_OnTimerEnd( timerIndex, arg1 )
    local spellIndex = CDTimer_GetUserHandle( timerIndex );
    
    if spellIndex ~= nil then
    
        local spellAbbreviation = CDTimerSpells[ spellIndex ].spellAbbreviation;
        local spellText = CountDoomSpell[ spellAbbreviation ].text;

        --
        -- Announce a completion message
        --
        if CDTimerSpells[ spellIndex ].announceEnd then
            CDTimerSpell_AnnounceMessage( string.format( "%s has finished.", spellText ) );
            CDTimerSpells[ spellIndex ].announceEnd = false;
        end
    
        --
        -- Play a completion sound
        --
        if CDTimerSpells[ spellIndex ].endSound and CountDoom.config.playSounds then
            local soundFile = CountDoom.soundPath .. CDTimerSpells[ spellIndex ].endSound .. ".wav";
            CountDoom.dpf("Playing " .. soundFile);
            PlaySoundFile(soundFile);
            CDTimerSpells[ spellIndex ].endSound = false;
        end
    
        local remainingTime = CDTimer_GetRemainingTime( timerIndex );
        if (remainingTime + CountDoom.config.postExpireDelay) < 0 then
            CDTimerSpell_DeleteIndex( spellIndex );
        end
    end
end


function CDTimerSpell_OnTimerMove( newTimerIndex, oldTimerIndex )
    local spellIndex = CDTimer_GetUserHandle( newTimerIndex );
    if spellIndex ~= nil then
        if CDTimerSpells[ spellIndex ] ~= nil then
            CDTimerSpells[ spellIndex ].timerIndex = newTimerIndex;
        else
            CountDoom.dpf( "Unexpected nil CDTimerSpells[ spellIndex ] in CDTimerSpell_OnTimerMove" );
        end
    else
        CountDoom.dpf( "Unexpected nil spellIndex in CDTimerSpell_OnTimerMove" );
    end
end


function CDTimerSpell_TargetUnit( spellIndex )
    if spellIndex == nil then
        return false
    end

    local changedTarget = false;
    
    if CDTimerSpells[ spellIndex ].targetID == CountDoom.targetID then
    
        if (UnitName( "target" ) == nil and CDTimerSpells[ spellIndex ].targetName ~= nil) then
            TargetByName( CDTimerSpells[ spellIndex ].targetName );
            changedTarget = true;
        end
        
    elseif UnitName( "target" ) == CDTimerSpells[ spellIndex ].targetName and
    
        UnitLevel( "target" ) == CDTimerSpells[ spellIndex ].targetLevel then
        -- Nothing to do here as this matches our target
        
    elseif( CDTimerSpells[ spellIndex ].targetName ~= nil ) then
    
        ClearTarget();
        TargetByName( CDTimerSpells[ spellIndex ].targetName );
        changedTarget = true;
        
    end
    
    return changedTarget;
end


function CDTimerSpell_RecastSpell( spellIndex )
    if spellIndex == nil or spellIndex == -1 then
        return
    end
    
    local spellAbbreviation = CDTimerSpells[ spellIndex ].spellAbbreviation;
    
    if spellAbbreviation ~= nil then
        local spellName = CountDoomSpell[ spellAbbreviation ].text;
        
        -- recast spell
        if spellName ~= nil and spellName ~= COUNTDOOMSPELL_SEDUCE then
        
            -- re-target this mob
            local changedTarget = CDTimerSpell_TargetUnit( spellIndex );

            -- cast the spell
            if CountDoom.spellTable and CountDoom.spellTable[spellName] then
                local maxRank = CountDoom.spellTable[spellName].maxRank;
                
                if maxRank then
                    local tab = CountDoom.spellTable[spellName][maxRank].tab;
                    local spellID = CountDoom.spellTable[spellName][maxRank].spell;
    
                    if spellID and tab then
                        CountDoom.dpf( "recasting " .. spellName .. " ID " .. spellID .. " tab " .. tab + 1 );
                        CastSpell( spellID, tab + 1 );
                    end
                end
            end            
        
            -- revert to previous target
            if changedTarget then
                TargetLastTarget();
            end
        end
    end
end


function CDTimerSpell_OnTimerClick( timerIndex, arg1 )
    local spellIndex = CDTimer_GetUserHandle( timerIndex );

    CountDoom.dpf( "CDTimerSpell_OnTimerClick(spellIndex = " .. spellIndex .. " arg1 = " .. arg1 .. ")" );
    
    if arg1 == "LeftButton" then 
        if IsShiftKeyDown() then
            if IsAltKeyDown() then
                -- Do nothing.  Too complex of a key combination
            else
                -- Delete this timer
                CDTimerSpell_DeleteIndex( spellIndex );
            end
        elseif IsAltKeyDown() then
        else
            -- re-target this mob
            CDTimerSpell_TargetUnit( spellIndex );
        end
    elseif arg1 == "RightButton" then
        if IsShiftKeyDown() then
            -- Cast secondary spell (conflagrate if immolated)
        elseif IsAltKeyDown() then
        else
            -- recast the spell                
            CDTimerSpell_RecastSpell( spellIndex );
        end
    end
end


function CDTimerSpell_OnEnter( timerIndex )
    local spellIndex = CDTimer_GetUserHandle( timerIndex );
    
    if spellIndex ~= nil then
        local msg = "Target: ";
        if( CDTimerSpells[ spellIndex ].targetName ~= nil ) then
            msg = msg .. CDTimerSpells[ spellIndex ].targetName .. "("; 
            msg = msg .. CDTimerSpells[ spellIndex ].targetLevel .. ")";
        end
        GameTooltip:AddLine( msg, 1.00, 1.00, 1.00 );
    end
    
    GameTooltip:AddLine("Left-click to target", 1.00, 1.00, 1.00);
    --GameTooltip:AddLine("Right-click to re-cast", 1.00, 1.00, 1.00);
    GameTooltip:AddLine("Shift+Left-click to delete", 1.00, 1.00, 1.00);
end


function CDTimerSpell_CreateTimerString(spellIndex)
    local timerIndex = CDTimerSpells[ spellIndex ].timerIndex;
    local targetName = CDTimerSpells[ spellIndex ].targetName;
    local targetLevel = CDTimerSpells[ spellIndex ].targetLevel;
    local spellAbbreviation = CDTimerSpells[ spellIndex ].spellAbbreviation;

    if targetName == nil then
        targetName = "Unknown";
    end;

    if targetLevel == nil then
        targetLevel = "??";
    end;

    local timerString = " - " .. string.upper(spellAbbreviation) .. " - ";
    timerString = timerString .. CountDoom.ToStr(targetName) .. "(" .. CountDoom.ToStr(targetLevel) .. ")";

    return timerString;
end


function CDTimerSpell_CreateBySpellAbbreviation( spellAbbreviation, targetInfo, in_rank )
    CountDoom.dpf( "CDTimerSpell_CreateBySpellAbbreviation( " .. CountDoom.ToStr( spellAbbreviation ) .. ")" );
    
    local spellIndex = -1;
    local replacedASpell = false;
    
    if CountDoomSpell.IsEnabled( spellAbbreviation ) ~= true then
        return -1, replacedASpell;
    end

    --See if the spell is already on our target
    local targetName = targetInfo.targetName;
    local targetLevel = targetInfo.targetLevel;
    local targetID = targetInfo.id;
    
    --If we're replacing a spell such as a curse, delete the old one
    for spellIndex = 0, CDTimerSpell_numSpells - 1 do
        if (CDTimerSpells[ spellIndex ].type == CountDoomSpell[ spellAbbreviation ].type ) and
            CDTimerSpells[ spellIndex ].targetName == targetName and
            CDTimerSpells[ spellIndex ].targetLevel == targetLevel then
            if CountDoomSpell[ spellAbbreviation ].replacesSameType then
        		CDTimerSpell_DeleteIndex( spellIndex );
		        replacedASpell = true;
            end
            break;
        end
    end
    
    spellIndex = CDTimerSpell_numSpells;
    CDTimerSpell_numSpells = CDTimerSpell_numSpells + 1;
        
    if CDTimerSpells[ spellIndex ] == nil then
        CDTimerSpells[ spellIndex ] = {};
    end

    --if rank was passed in as nil, use max rank    
    local rank = in_rank;
    if rank == nil then
        rank = 10;
    end;
    
    --determine duration
    local duration = nil;

    if CountDoomSpell[ spellAbbreviation ] ~= nil then
        duration = CountDoomSpell[ spellAbbreviation ].rankDuration[ rank ];
    end;
    
    while duration == nil and rank > 0 do
        rank = rank - 1;
        duration = CountDoomSpell[ spellAbbreviation ].rankDuration[ rank ];
    end
    
    local warningTime = duration - CountDoomSpell[ spellAbbreviation ].warningTime;
    local icon = CountDoomSpell[ spellAbbreviation ].icon;
    local type = CountDoomSpell[ spellAbbreviation ].type;
    
    -- Give unique spellIDs to each spell.
    local spellID = CDTimerSpell_spellID;
    CDTimerSpell_spellID = CDTimerSpell_spellID + 1;
    if CDTimerSpell_spellID > 1000 then
        CDTimerSpell_spellID = 0;
    end
    
    local timerIndex = CDTimer_Create( CDTIMERPRIORITY_MEDIUM, duration );
    CDTimerSpells[ spellIndex ].timerIndex          = timerIndex;    
    CDTimerSpells[ spellIndex ].warningHit          = false;
    CDTimerSpells[ spellIndex ].spellAbbreviation   = spellAbbreviation;
    CDTimerSpells[ spellIndex ].announceWarning     = CountDoomSpell[ spellAbbreviation ].announceWarning;
    CDTimerSpells[ spellIndex ].announceEnd         = CountDoomSpell[ spellAbbreviation ].announceEnd;

    CDTimerSpells[ spellIndex ].warningSound        = CountDoom.config.warningSound[ spellAbbreviation ];
    CDTimerSpells[ spellIndex ].endSound            = CountDoom.config.endSound[ spellAbbreviation ];
    
    CDTimerSpells[ spellIndex ].targetName          = targetName;
    CDTimerSpells[ spellIndex ].targetLevel         = targetLevel;
    CDTimerSpells[ spellIndex ].targetID            = targetID;
    CDTimerSpells[ spellIndex ].spellID             = spellID;
    CDTimerSpells[ spellIndex ].type                = type;

    if CountDoom.config.layout == "textonly" then
        local timerString = CDTimerSpell_CreateTimerString(spellIndex);
        CDTimer_SetTimerSuffix( timerIndex, timerString );
    end
    
    CDTimer_SetUserHandle( timerIndex, spellIndex );
    CDTimer_SetWarningTime( timerIndex, warningTime );
    CDTimer_SetCountDown( timerIndex, CountDoomSpell[ spellAbbreviation ].countDown );
    CDTimer_SetFunctionHandler( timerIndex, CDTIMEREVENT_ONTIMERWARNING, CDTimerSpell_OnTimerWarning );
    CDTimer_SetFunctionHandler( timerIndex, CDTIMEREVENT_ONTIMEREND, CDTimerSpell_OnTimerEnd );
    CDTimer_SetFunctionHandler( timerIndex, CDTIMEREVENT_ONMOVETIMER, CDTimerSpell_OnTimerMove );
    CDTimer_SetFunctionHandler( timerIndex, CDTIMEREVENT_ONCLICK, CDTimerSpell_OnTimerClick );
    CDTimer_SetFunctionHandler( timerIndex, CDTIMEREVENT_ONENTER, CDTimerSpell_OnEnter );
    CDTimer_SetIcon( timerIndex, icon );
    
    CDTimerSpell_DumpAll();

    return spellID, replacedASpell;
end


function CDTimerSpell_CreateBySpellName( spellName, targetInfo, rank )
    CountDoom.dpf( "CDTimerSpell_CreateBySpellName(" .. CountDoom.ToStr( spellName ) .. ")" );

    -- Enslave Demon is detected differently than the rest of the Warlock spells.
    -- It relies on a change on event in pet status
    if spellName == COUNTDOOMSPELL_ENSLAVEDEMON then
        return -1;
    end

    local spellAbbreviation = CountDoomSpellMapping[ spellName ];
    if spellAbbreviation ~= nil then
        return CDTimerSpell_CreateBySpellAbbreviation( spellAbbreviation, targetInfo, rank );
    end

    return -1, false;
end


function CDTimerSpell_DeleteIndex( spellIndex )
    CountDoom.dpf( "CDTimerSpell_DeleteIndex(" .. CountDoom.ToStr( spellIndex ) .. ")" );
    
    if spellIndex >= CDTimerSpell_numSpells then
        CountDoom.dpf( "Invalid param CDTimerSpell_DeleteIndex(" .. spellIndex .. ")" );
        return;
    end

    -- Destroy the timer associated with the spell
    CDTimer_Destroy( CDTimerSpells[ spellIndex ].timerIndex );
    
    -- Collapse the array table by removing the deleted spell
    local srcIndex;
    for srcIndex = spellIndex + 1, CDTimerSpell_numSpells - 1do
        local dstIndex = srcIndex - 1;
        CDTimerSpells[ dstIndex ].timerIndex        = CDTimerSpells[ srcIndex ].timerIndex;    
        CDTimerSpells[ dstIndex ].warningHit        = CDTimerSpells[ srcIndex ].warningHit;
        CDTimerSpells[ dstIndex ].spellAbbreviation = CDTimerSpells[ srcIndex ].spellAbbreviation;
        CDTimerSpells[ dstIndex ].announceWarning   = CDTimerSpells[ srcIndex ].announceWarning;
        CDTimerSpells[ dstIndex ].warningSound      = CDTimerSpells[ srcIndex ].warningSound;
        CDTimerSpells[ dstIndex ].announceEnd       = CDTimerSpells[ srcIndex ].announceEnd;
        CDTimerSpells[ dstIndex ].endSound          = CDTimerSpells[ srcIndex ].endSound;
        CDTimerSpells[ dstIndex ].targetName        = CDTimerSpells[ srcIndex ].targetName;
        CDTimerSpells[ dstIndex ].targetLevel       = CDTimerSpells[ srcIndex ].targetLevel;
        CDTimerSpells[ dstIndex ].targetID          = CDTimerSpells[ srcIndex ].targetID;
        CDTimerSpells[ dstIndex ].spellID           = CDTimerSpells[ srcIndex ].spellID;
        CDTimerSpells[ dstIndex ].type              = CDTimerSpells[ srcIndex ].type;
                
        CDTimer_SetUserHandle( CDTimerSpells[ dstIndex ].timerIndex, dstIndex );
    end
    
    -- Update spell count
    CDTimerSpell_numSpells = CDTimerSpell_numSpells - 1; 
    
    -- Erase the last spell
    CDTimerSpells[ CDTimerSpell_numSpells ] = nil;
    
    -- Dump all spells in debug mode
    CDTimerSpell_DumpAll();
end


function CDTimerSpell_DeleteID( spellID )
    CountDoom.dpf( "CDTimerSpell_DeleteID(" .. CountDoom.ToStr( spellID ) .. ")" );

    local matchingIndex = -1;
    local spellIndex;
    for spellIndex = 0, CDTimerSpell_numSpells - 1 do
        if CDTimerSpells[ spellIndex ].spellID == spellID then
            matchingIndex = spellIndex;
            break;
        end
    end
    
    if matchingIndex ~= -1 then
        CDTimerSpell_DeleteIndex( matchingIndex );
    end
end


function CDTimerSpell_GetSpellIndex( spellID )
    CountDoom.dpf( "CDTimerSpell_GetSpellIndex(" .. CountDoom.ToStr( spellID ) .. ")" );

    local matchingIndex = -1;
    local spellIndex;
    for spellIndex = 0, CDTimerSpell_numSpells - 1 do
        if CDTimerSpells[ spellIndex ].spellID == spellID then
            return spellIndex;
        end
    end

    return -1;    
end


function CDTimerSpell_DeleteTarget( targetID )
    CountDoom.dpf( "CDTimerSpell_DeleteID(" .. CountDoom.ToStr( targetID ) .. ")" );

    local matchingIndex = -1;
    local spellIndex;
    for spellIndex = 0, CDTimerSpell_numSpells - 1 do
        if CDTimerSpells[ spellIndex ].targetID == targetID then
            matchingIndex = spellIndex;
            break;
        end
    end
    
    if matchingIndex ~= -1 then
        CDTimerSpell_DeleteIndex( matchingIndex );
        return true;
    end
    return false;
end


function CDTimerSpell_DestroyBySpellAbbreviation( spellAbbreviation )
    local found = false;
    
    CountDoom.dpf( "CDTimerSpell_DestroyBySpellAbbreviation(" .. CountDoom.ToStr( spellAbbreviation ) .. " )" );
    
    -- Look for the spell in question
    local foundIndex = 0;
    local spellIndex;
    for spellIndex = 0, CDTimerSpell_numSpells - 1 do
        if CDTimerSpells[ spellIndex ].spellAbbreviation == spellAbbreviation then
            CountDoom.dpf( "[spellIndex]: " .. CDTimerSpells[ spellIndex ].spellAbbreviation );
            CountDoom.dpf( "spellAbbr: " .. spellAbbreviation );
            found = true;
            foundIndex = spellIndex;
            break;
        end
    end
    
    if not found then
        CountDoom.dpf( "Attempting to delete a spell not found: " .. spellAbbreviation );
        return;
    end
    
    CountDoom.dpf( CountDoom.ToStr( found ) .. " " .. CountDoom.ToStr( foundIndex ) .. ": " .. CountDoom.ToStr( CDTimerSpells[ foundIndex ].spellAbbreviation ) );
    
    -- Collapsed the spell table into a contiguous array
    CDTimerSpell_DeleteIndex( foundIndex );
end


function CDTimerSpell_DestroyBySpellName( spellName )
    CountDoom.dpf( "CDTimerSpell_DestroyBySpellName(" .. CountDoom.ToStr( spellName ) .. " )" );
    
    local spellAbbreviation = CountDoomSpellMapping[ spellName ];
    if spellAbbreviation ~= nil then
        CDTimerSpell_DestroyBySpellAbbreviation( spellAbbreviation );
    end
end


function CDTimerSpell_GetSpellName( spellIndex )
    if CDTimerSpells[ spellIndex ] ~= nil then
        local spellAbbreviation = CDTimerSpells[ spellIndex ].spellAbbreviation;
        if spellAbbreviation ~= nil and CountDoomSpell[ spellAbbreviation ] ~= nil then
            return CountDoomSpell[ spellAbbreviation ].text;
        else
            CountDoom.dpf( "CDTimerSpell_GetSpellName failed: " .. spellAbbreviation );
        end
    end
    
    return nil;
end


function CDTimerSpell_RemoveCombatSpellTimers()
    local spellIndex;

    for spellIndex = CDTimerSpell_numSpells - 1, 0, -1 do
        local spellAbbreviation = CDTimerSpells[ spellIndex ].spellAbbreviation;
        CountDoom.dpf( "Checking for combat removal: " .. spellAbbreviation );
        if CountDoomSpell[ spellAbbreviation ].combatOnly then
            CDTimerSpell_DeleteIndex( spellIndex );
        end
    end
end


function CDTimerSpell_UpdateSpellPrefixes()
    local spellIndex;

    for spellIndex = 0, CDTimerSpell_numSpells - 1 do
        local timerIndex = CDTimerSpells[ spellIndex ].timerIndex;
        if CountDoom.config.layout == "textonly" then
            local timerString = CDTimerSpell_CreateTimerString(spellIndex);
            CDTimer_SetTimerSuffix( timerIndex, timerString );
        else
            CDTimer_SetTimerSuffix( timerIndex, nil );
        end
    end
end


function TargetHasMyDebuff(spellAbbreviation)
    local spellIndex = 0;
    local TimerSpell_numSpells = CDTimerSpell_numSpells - 1;
    CountDoom.dpf(CDTimerSpell_numSpells.." Spells." );
    for spellIndex = 0, TimerSpell_numSpells do
--    CountDoom.dpf(CDTimerSpells[ spellIndex ].targetName.."--"..UnitName("target"));
--    CountDoom.dpf(CDTimerSpells[ spellIndex ].spellAbbreviation.."--"..spellAbbreviation);
--    CountDoom.dpf(CDTimerSpells[ spellIndex ].targetLevel.."--"..UnitLevel("target"));
        if CDTimerSpells[ spellIndex ].targetName == UnitName("target") and
           CDTimerSpells[ spellIndex ].spellAbbreviation == spellAbbreviation and
           CDTimerSpells[ spellIndex ].targetLevel == UnitLevel("target") then
           return true;
        end           
    end  
    return false;  
end  

function CDTimerSpell_isDebuffCast(spellAbbreviation)
    return TargetHasMyDebuff(spellAbbreviation);
end