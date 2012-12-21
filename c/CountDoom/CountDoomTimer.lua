-- CountDoom 0.46
-- CountDoomTimer stuff
-- Author: Scrum


CDTimer_maxButtons = 5;
CDTimer_numTimers = 0;


CDTIMERPRIORITY_LOW     = 2;
CDTIMERPRIORITY_MEDIUM  = 1;
CDTIMERPRIORITY_HIGH    = 0;

CDTIMEREVENT_ONUPDATE       = 1;
CDTIMEREVENT_ONTIMERWARNING = 2;
CDTIMEREVENT_ONTIMEREND     = 3;
CDTIMEREVENT_ONMOVETIMER    = 4;
CDTIMEREVENT_ONENTER        = 5;
CDTIMEREVENT_ONLEAVE        = 6;
CDTIMEREVENT_ONMOUSEDOWN    = 7;
CDTIMEREVENT_ONMOUSEUP      = 8;
CDTIMEREVENT_ONCLICK        = 9;
CDTIMEREVENT_MAXEVENTS      = 10;



CDTimers = {};

--Internal members
--userHandle        - custom object to store anything in a timer
--startTime         - time timer was created
--warningTime       - number of seconds before warning is signaled
--duration          - lifetime of timer.  -1 is infinite
--icon              - cache of texture to be displayed
--text              - cache of text to be displayed    
--flashInterval     - flash period in seconds. 0 = disabled
--flashTime         - time within flash period [0 .. flashInterval]
--funcHandlers      - table of callbacks based on events
--priority          - determines button priority {HIGH, NORMAL, LOW}
--countDown         - true if display a countdown versus a countup
--prefix            - text added to beginning of timer countdown text
--suffix            - text added to end of timer countdown text

--Public methods
--CDTimer_Create( priority, duration, warningTime, handle )
--CDTimer_Destroy( timerIndex ) 
--CDTimer_SetFunctionHandler( timerIndex, handlerName, funcHandler )
--CDTimer_GetRemainingTime( timerIndex )
--CDTimer_SetText( timerIndex, timerText )
--CDTimer_GetText( timerIndex )
--CDTimer_SetIcon( timerIndex, timerIcon )
--CDTimer_GetIcon( timerIndex )
--CDTimer_SetWarningTime( timerIndex, warningTime )
--CDTimer_GetWarningTime( timerIndex )
--CDTimer_SetUserHandle( timerIndex, userHandle )
--CDTimer_GetUserHandle( timerIndex )
--CDTimer_SetCountDown( timerIndex, countDown );
--CDTimer_GetCountDown( timerIndex );
--CDTimer_EnableFlash( timerIndex, interval )
--CDTimer_DisableFlash( timerIndex )
--CDTimer_SetPriority( timerIndex, priority );
--CDTimer_Copy( destIndex, srcIndex );
--CDTimer_SetTimerPrefix( timerPrefix, prefixStr )
--CDTimer_SetTimerSuffix( timerPrefix, suffixStr )

--Private methods
--CDTimer_GenericHandler( timerIndex, eventName, arg1 )
--CDTimer_OnUpdate(arg1)
--CDTimer_OnEnter(arg1)
--CDTimer_OnLeave(arg1)
--CDTimer_OnMouseDown(arg1)
--CDTimer_OnMouseUp(arg1)
--CDTimer_OnClick(arg1)
--CDTimer_ShowButton( timerIndex, showButton )
--CDTimer_SetAlpha( timerIndex, alpha ) - NOTE: This is used by the flashing logic and shouldn't be called directly
--CDTimer_UpdateFlash( timerIndex, timeDelta )


local function CDTimer_Dump( timerIndex )
    CountDoom.dpf( "Timer: " .. timerIndex );
    CountDoom.dpf( "userHandle: " .. CDTimers[ timerIndex ].userHandle );
    CountDoom.dpf( "startTime: " .. CDTimers[ timerIndex ].startTime );
    CountDoom.dpf( "warningTime: " .. CDTimers[ timerIndex ].warningTime );
    CountDoom.dpf( "duration: " .. CDTimers[ timerIndex ].duration );
    CountDoom.dpf( "icon: " .. CountDoom.ToStr( CDTimers[ timerIndex ].icon ) );
    CountDoom.dpf( "text: " .. CountDoom.ToStr( CDTimers[ timerIndex ].text ) );
    CountDoom.dpf( "flashInterval: " .. CDTimers[ timerIndex ].flashInterval );
    CountDoom.dpf( "flashTime: " .. CDTimers[ timerIndex ].flashTime );
    CountDoom.dpf( "priority: " .. CDTimers[ timerIndex ].priority );
end


local function CDTimer_DumpAll()
    local timerIndex;
    for timerIndex = 0, CDTimer_numTimers - 1, 1 do
        CDTimer_Dump( timerIndex );
    end
end


local function CDTimer_SetAlpha( timerIndex, alpha )
    if CDTimers[ timerIndex ] == nil then
        CountDoom.dpf( "Invalid timerIndex in CDTimer_SetAlpha" );
        return;
    end

    local buttonName = "CDTimerButton" .. timerIndex .. "_DurationText";
    local buttonItem = getglobal( buttonName );
    if( buttonItem ~= nil ) then
        buttonItem:SetAlpha( alpha );
    elseif timerIndex < CDTimer_maxButtons then
        CountDoom.dpf( "Unable to call " .. buttonName .. ":SetAlpha()" );
    end
    
    --TODO set the icon alpha also
end


local function CDTimer_ShowButton( timerIndex, showButton )
    CountDoom.dpf( "CDTimer_ShowButton(" .. CountDoom.ToStr( timerIndex ) .. ")" );

    if timerIndex >= CDTimer_numTimers then
        CountDoom.dpf( "CDTimer_ShowButton: Invalid index " .. timerIndex );
        return
    end

    local buttonName = "CDTimerButton" .. timerIndex;
    local buttonItem = getglobal( buttonName );
    if( buttonItem ~= nil ) then
        if( showButton ) then
            CountDoom.dpf( "CDTimer_ShowButton: calling Show() " );
            buttonItem:Show();
        else
            CountDoom.dpf( "CDTimer_ShowButton: calling Hide() " );
            buttonItem:Hide();
        end
    elseif timerIndex < CDTimer_maxButtons then
        CountDoom.dpf( "Unable to call " .. buttonName .. ":Show()" );
    end
end


local function CDTimer_UpdateFlash( timerIndex, timeDelta )
    if CDTimers[ timerIndex ] == nil then
        CountDoom.dpf( "Invalid timerIndex in CDTimer_UpdateFlash" );
        return -1;
    end
    
    if CDTimers[ timerIndex ].flashInterval <= 0.0 then
        return
    end
    
    CDTimers[ timerIndex ].flashTime = CDTimers[ timerIndex ].flashTime + timeDelta;
    while CDTimers[ timerIndex ].flashTime > CDTimers[ timerIndex ].flashInterval do
        CDTimers[ timerIndex ].flashTime = CDTimers[ timerIndex ].flashTime - CDTimers[ timerIndex ].flashInterval;
    end
    
    local alpha = 2.0 * CDTimers[ timerIndex ].flashTime / CDTimers[ timerIndex ].flashInterval;
    if( alpha > 1.0 ) then
        alpha = 2.0 - alpha;
    end
    
    CDTimer_SetAlpha( timerIndex, alpha );
end


local function CDTimer_GenericHandler( timerIndex, eventName, arg1 )
    
    if timerIndex == nil then
        --CountDoom.dpf( "ButtonID doesn't map to a valid timerIndex in CDTimer_" .. eventName );
        return nil;
    end
    
    if CDTimers[ timerIndex ] == nil then
        CountDoom.dpf( "Invalid timerIndex in CDTimer_" .. eventName );
        return nil;
    end
    
    -- Call the callback function
    if CDTimers[ timerIndex ].funcHandlers ~= nil then
        local funcHandler = CDTimers[ timerIndex ].funcHandlers[ eventName ];
        if funcHandler ~= nil then
            funcHandler( timerIndex, arg1 );
        end
    end
        
    return timerIndex;
end


function CDTimer_UpdateTimer( timerIndex )
    
    if( CDTimers[ timerIndex ] == nil ) then
        CountDoom.dpf( "Invalid timerIndex in CDTimer_OnUpdate: " .. timerIndex );
        return;
    end
    
    local currentTime = GetTime();
    local rawDelta = currentTime - CDTimers[ timerIndex ].startTime;
    local duration = CDTimers[ timerIndex ].duration;
    local warningTime = CDTimers[ timerIndex ].warningTime;
    local finished = false;

    local delta = floor(rawDelta);
    if( delta > duration ) then
        delta = duration;
        finished = true;
    end
    
    -- Update the timer
    local flashAlpha = 1.0;
    
    local textColor = {};
    local alpha = 1.0;
    
    if (rawDelta > duration) then
        textColor["r"] = 1.0;
        textColor["g"] = 0.0;
        textColor["b"] = 0.0;
    elseif (rawDelta > warningTime) then
        alpha = (rawDelta - warningTime) / (duration - warningTime);
        textColor["r"] = 1.0;
        textColor["g"] = 1.0 - alpha;
        textColor["b"] = 0.0;
    else
        alpha = rawDelta / warningTime;
        textColor["r"] = 1.0;
        textColor["g"] = 1.0;
        textColor["b"] = 1.0 - alpha;
    end
    
    -- Invert for count down situations
    local timeDelta = rawDelta;
    if( CDTimers[ timerIndex ].countDown ) then
        timeDelta = duration - rawDelta;
    end

    local signStr = "";
    if timeDelta < 0 then
        signStr = "-";
        timeDelta = -timeDelta;
    end

    local minutes = floor(timeDelta/60);
    local seconds = floor(math.mod(timeDelta, 60));
    local hseconds = floor(math.mod(floor(rawDelta*100), 100));

    local htimeText = "";

    if (CountDoom.config.hseconds == true) then
        if (hseconds >= 10) then
            htimeText = "." .. hseconds;
        else
            htimeText = ".0" .. hseconds;
        end
    end

    local timeText = "";
    if (seconds >= 10) then
        timeText = signStr .. minutes .. ":" .. seconds .. htimeText;
    else
        timeText = signStr .. minutes .. ":0" .. seconds .. htimeText;
    end

    -- Add any prefix or suffix
    if CDTimers[ timerIndex ].prefix ~= nil then
        timeText = CDTimers[ timerIndex ].prefix .. timeText;
    end

    if CDTimers[ timerIndex ].suffix ~= nil then
        timeText = timeText .. CDTimers[ timerIndex ].suffix;
    end
    
    -- Set the timer text
    CDTimer_SetText( timerIndex, timeText, textColor );
    
    -- Update flash time
    local flashRate = 0.1;
    if CDTimers[ timerIndex ].flashInterval ~= 0.0 then
        CDTimer_UpdateFlash( timerIndex, flashRate );
    else
        CDTimer_SetAlpha( timerIndex, 1.0 );
    end
    
    -- Callback for custom OnUpdate calls
    CDTimer_GenericHandler( timerIndex, CDTIMEREVENT_ONUPDATE, arg1 );
    
    if( finished ) then
        --CountDoom.dpf( "Calling OnTimerEnd for timer #" .. timerIndex );
        CDTimer_GenericHandler( timerIndex, CDTIMEREVENT_ONTIMEREND, delta );
    elseif( delta >= warningTime ) then
        --CountDoom.dpf( "Calling OnTimerWarning for timer #" .. timerIndex );
        CDTimer_GenericHandler( timerIndex, CDTIMEREVENT_ONTIMERWARNING, delta );
    end
end


function CDTimer_OnUpdate( arg1 )
    local timerIndex = this:GetID();
    
    CDTimer_UpdateTimer( timerIndex );
end


function CDTimer_OnEnter( arg1 )
    local timerIndex = this:GetID();
    
    -- put the tool tip in the default position
    GameTooltip_SetDefaultAnchor(GameTooltip, this);
    
    -- set the tool tip text
    GameTooltip:SetText(COUNTDOOM_TITLE, 255/255, 209/255, 0/255);
    
    CDTimer_GenericHandler( timerIndex, CDTIMEREVENT_ONENTER, arg1 );
    
    GameTooltip:AddLine(COUNTDOOM_DESCRIPTION, 80/255, 143/255, 148/255);
    GameTooltip:Show();
end


function CDTimer_OnLeave( arg1 )
    local timerIndex = this:GetID();
    CDTimer_GenericHandler( timerIndex, CDTIMEREVENT_ONLEAVE, arg1 );
    
    GameTooltip:Hide(arg1);
end


function CDTimer_OnMouseDown( arg1 )
    -- if not loaded yet then get out
    if (CountDoom.initialized == false) then
        return;
    end
    
    local timerIndex = this:GetID();
    CDTimer_GenericHandler( timerIndex, CDTIMEREVENT_ONMOUSEDOWN, arg1 );
end


function CDTimer_OnMouseUp( arg1 )
    -- if not loaded yet then get out
    if CountDoom.initialized == false then
        return;
    end
    
    local timerIndex = this:GetID();
    CDTimer_GenericHandler( timerIndex, CDTIMEREVENT_ONMOUSEUP, arg1 );
end


function CDTimer_OnClick( arg1 )
    -- if not loaded yet then get out
    if CountDoom.initialized == false then
        return;
    end
    
    local timerIndex = this:GetID();
    CDTimer_GenericHandler( timerIndex, CDTIMEREVENT_ONCLICK, arg1 );
end


local function CDTimer_Constructor( timerIndex )
    if CDTimers[ timerIndex ] == nil then
        CDTimers[ timerIndex ] = {};
    end
    
    CDTimers[ timerIndex ].userHandle = nil;
    CDTimers[ timerIndex ].priority = nil;
    CDTimers[ timerIndex ].startTime = GetTime();
    CDTimers[ timerIndex ].warningTime = nil;
    CDTimers[ timerIndex ].duration = nil;
    CDTimers[ timerIndex ].icon = nil;
    CDTimers[ timerIndex ].text = nil;
    CDTimers[ timerIndex ].flashInterval = 0.0;
    CDTimers[ timerIndex ].flashTime = 0.0;
    CDTimers[ timerIndex ].countDown = true;
    CDTimers[ timerIndex ].prefix = nil;
    CDTimers[ timerIndex ].suffix = nil;

    CDTimers[ timerIndex ].funcHandlers = nil;
    CDTimers[ timerIndex ].funcHandlers = {};
end


local function CDTimer_GetInsertionIndex( priority, duration )
    local foundIndex = CDTimer_numTimers;
    
    if( CDTimer_numTimers > 0 ) then
   
        local currentTime = GetTime();

        -- Loop through all items stopping at first button less than 
        local timerIndex;
        for timerIndex = 0, CDTimer_numTimers - 1, 1 do
            
            if( CDTimers[ timerIndex ] ~= nil ) then
            
                -- Check for priority is a lower number (higher priority)
                if( priority < CDTimers[ timerIndex ].priority ) then
                    foundIndex = timerIndex;
                    break;
                end
                
                -- If equivalent, check remaining time
                local elapsed = currentTime - CDTimers[ timerIndex ].startTime;
                local remaining = CDTimers[ timerIndex ].duration - elapsed;
                
                if( duration <= remaining ) then
                    foundIndex = timerIndex;
                    break;
                end
            else
                foundIndex = timerIndex;
                break;
            end
        end
    
        -- if it's the last index, we're done
        if( foundIndex <= CDTimer_numTimers ) then
        
            -- Slide all the items to the next slots
            CountDoom.dpf( "CDTimer_numTimers " .. CDTimer_numTimers );
            CountDoom.dpf( "foundIndex " .. foundIndex );
            
            for newID = CDTimer_numTimers, foundIndex + 1, -1 do
            
                local oldID = newID - 1;
                
                CountDoom.dpf( "oldID: " .. oldID .. "  newID: " .. newID );
                
                CDTimer_Copy( newID, oldID );
            end
        end
    end
    
    local buttonToEnable = CDTimer_numTimers;
        
    CDTimer_numTimers = CDTimer_numTimers + 1;
    
    -- Enable the last button 
    CDTimer_ShowButton( buttonToEnable, true );
    

    return foundIndex;
end


function CDTimer_Create( priority, duration )
    local timerIndex = -1;
    
    timerIndex = CDTimer_GetInsertionIndex( priority, duration );
    CountDoom.dpf( "CDTimer_Create: Insertion Index is " .. timerIndex );
    
    CDTimer_Constructor( timerIndex );
    CDTimers[ timerIndex ].priority = priority;
    CDTimers[ timerIndex ].warningTime = duration;
    CDTimers[ timerIndex ].duration = duration;
    
    CDTimer_ShowButton( timerIndex, true );
    
    CountDoomFrame:Show();
    
    return timerIndex;
end


function CDTimer_Destroy( removeID )
    CountDoom.dpf( "Destroy: " .. removeID );
    
    if CDTimers[ removeID ] == nil then
        CountDoom.dpf( "Invalid index(" .. timerIndex .. ") in CDTimer_Destroy. " .. CDTimer_numTimers );
        return;
    end

    CDTimer_DumpAll();
    
    if( removeID ~= ( CDTimer_numTimers - 1 ) ) then
        
        -- shift all buttons down by one
        local oldID;
        for oldID = removeID + 1, CDTimer_numTimers - 1, 1 do
            local newID = oldID - 1;
            
            CountDoom.dpf( "oldID: " .. oldID .. "  newID: " .. newID );
        
            CDTimer_Copy( newID, oldID );
        end   
    end
    
    -- Erase the button
    local deleteID = CDTimer_numTimers - 1;
    CDTimers[ deleteID ] = nil;

    -- And hide the last one
    CDTimer_ShowButton( deleteID, false );
    
    CDTimer_numTimers = CDTimer_numTimers - 1;
    
    if CDTimer_numTimers <= 0 then
        if CountDoom.config.isLocked == true then
            CountDoomFrame:Hide();
        end
    end
    
    CDTimer_DumpAll();
end


function CDTimer_SetFunctionHandler( timerIndex, handlerName, funcHandler )
    if CDTimers[ timerIndex ] == nil then
        CountDoom.dpf( "Invalid timerIndex in CDTimer_SetFunctionHandler" );
        return;
    end

    CountDoom.dpf( "SetFunctionHandler before: " .. table.getn( CDTimers[ timerIndex ].funcHandlers ) );
    
    CDTimers[ timerIndex ].funcHandlers[ handlerName ] = funcHandler;
    
    CountDoom.dpf( "SetFunctionHandler after: " .. table.getn( CDTimers[ timerIndex ].funcHandlers ) );
end


function CDTimer_GetRemainingTime( timerIndex )
    if CDTimers[ timerIndex ] == nil then
        CountDoom.dpf( "Invalid timerIndex in CDTimer_GetRemainingTime" );
        return nil;
    end
    
    return CDTimers[ timerIndex ].duration - (GetTime() - CDTimers[ timerIndex ].startTime);
end


function CDTimer_SetWarningTime( timerIndex, warningTime )
    if CDTimers[ timerIndex ] == nil then
        CountDoom.dpf( "Invalid timerIndex in CDTimer_SetWarningTime" );
        return;
    end
    
    CDTimers[ timerIndex ].warningTime = warningTime;
end


function CDTimer_GetWarningTime( timerIndex )
    if CDTimers[ timerIndex ] == nil then
        CountDoom.dpf( "Invalid timerIndex in CDTimer_GetWarningTime" );
        return nil;
    end
    
    return CDTimers[ timerIndex ].warningTime;
end


function CDTimer_SetUserHandle( timerIndex, userHandle )
    if CDTimers[ timerIndex ] == nil then
        CountDoom.dpf( "Invalid timerIndex in CDTimer_SetUserHandle" );
        return;
    end
    
    CDTimers[ timerIndex ].userHandle = userHandle;
end


function CDTimer_GetUserHandle( timerIndex )
    if CDTimers[ timerIndex ] == nil then
        CountDoom.dpf( "Invalid timerIndex in CDTimer_GetUserHandle" );
        return nil;
    end
    
    return CDTimers[ timerIndex ].userHandle;
end


function CDTimer_SetCountDown( timerIndex, countDown )
    if CDTimers[ timerIndex ] == nil then
        CountDoom.dpf( "Invalid timerIndex in CDTimer_SetCountDown" );
        return;
    end
    
    CDTimers[ timerIndex ].countDown = countDown;
end


function CDTimer_GetCountDown( timerIndex )
    if CDTimers[ timerIndex ] == nil then
        CountDoom.dpf( "Invalid timerIndex in CDTimer_GetCountDown" );
        return nil;
    end
    
    return CDTimers[ timerIndex ].countDown;
end


function CDTimer_SetText( timerIndex, timerText, textColor )
    if CDTimers[ timerIndex ] == nil then
        CountDoom.dpf( "Invalid timerIndex in CDTimer_SetText" );
        return;
    end
    
    local red = 1.0;
    local green = 1.0;
    local blue = 1.0;

    if textColor ~= nil then
        red = textColor["r"];
        green = textColor["g"];
        blue = textColor["b"];
    end
    
    CDTimers[ timerIndex ].text = timerText;

    local buttonName = "CDTimerButton" .. timerIndex .. "_DurationText";
    local buttonItem = getglobal( buttonName );
    if( buttonItem ~= nil ) then
        buttonItem:SetTextColor( red, green, blue );
        buttonItem:SetText( timerText );
    elseif timerIndex < CDTimer_maxButtons then
        CountDoom.dpf( "Unable to call " .. buttonName .. ":SetText()" );
    end
end


function CDTimer_GetText( timerIndex )
    if CDTimers[ timerIndex ] == nil then
        CountDoom.dpf( "Invalid timerIndex in CDTimer_GetText" );
        return nil;
    end
    
    return CDTimers[ timerIndex ].text;
end


function CDTimer_SetIcon( timerIndex, timerIcon )
    if CDTimers[ timerIndex ] == nil then
        CountDoom.dpf( "Invalid timerIndex in CDTimer_SetIcon" );
        return;
    end
    
    CDTimers[ timerIndex ].icon = timerIcon;
    
    local buttonName = "CDTimerButton" .. timerIndex .. "_Icon";
    local buttonItem = getglobal( buttonName );
    if( buttonItem ~= nil ) then
        buttonItem:SetTexture( timerIcon );
    elseif timerIndex < CDTimer_maxButtons then
        CountDoom.dpf( "Unable to call " .. buttonName .. ":SetTexture()" );
    end
end


function CDTimer_GetIcon( timerIndex )
    if CDTimers[ timerIndex ] == nil then
        CountDoom.dpf( "Invalid timerIndex in CDTimer_GetIcon" );
        return nil;
    end
    
    return CDTimers[ timerIndex ].icon;
end


function CDTimer_EnableFlash( timerIndex, interval )
    if CDTimers[ timerIndex ] == nil then
        CountDoom.dpf( "Invalid timerIndex in CDTimer_EnableFlash" );
        return;
    end
    
    if interval <= 0 then
        interval = 0.0;
    end
    
    CDTimers[ timerIndex ].flashTime = 0.0;
    CDTimers[ timerIndex ].flashInterval = interval;
end


function CDTimer_SetTimerPrefix( timerIndex, prefixStr )
    if CDTimers[ timerIndex ] == nil then
        CountDoom.dpf( "Invalid timerIndex in CDTimer_SetTimerPrefix" );
        return;
    end
    
    CDTimers[ timerIndex ].prefix = prefixStr;
end


function CDTimer_SetTimerSuffix( timerIndex, suffixStr )
    if CDTimers[ timerIndex ] == nil then
        CountDoom.dpf( "Invalid timerIndex in CDTimer_SetTimerSuffix" );
        return;
    end
    
    CDTimers[ timerIndex ].suffix = suffixStr;
end


function CDTimer_DisableFlash( timerIndex )
    if CDTimers[ timerIndex ] == nil then
        CountDoom.dpf( "Invalid timerIndex in CDTimer_DisableFlash" );
        return;
    end
    
    CDTimers[ timerIndex ].flashTime = 0.0;
    CDTimers[ timerIndex ].flashInterval = 0.0;
end


function CDTimer_Copy( destIndex, srcIndex )
    CountDoom.dpf( "CDTimer_Copy(" .. CountDoom.ToStr( destIndex ) .. ", " .. CountDoom.ToStr( srcIndex ) .. ")" );
    
    if CDTimers[ srcIndex ] == nil then
        CDTimers[ destIndex ] = nil;
    else
        if CDTimers[ destIndex ] == nil then
            CDTimers[ destIndex ] = {};
        end
        CDTimers[ destIndex ].userHandle = CDTimers[ srcIndex ].userHandle;
        CDTimers[ destIndex ].priority = CDTimers[ srcIndex ].priority;
        CDTimers[ destIndex ].startTime = CDTimers[ srcIndex ].startTime;
        CDTimers[ destIndex ].warningTime = CDTimers[ srcIndex ].warningTime;
        CDTimers[ destIndex ].duration = CDTimers[ srcIndex ].duration;
        CDTimers[ destIndex ].icon = CDTimers[ srcIndex ].icon;
        CDTimers[ destIndex ].text = CDTimers[ srcIndex ].text;
        CDTimers[ destIndex ].flashInterval = CDTimers[ srcIndex ].flashInterval;
        CDTimers[ destIndex ].flashTime = CDTimers[ srcIndex ].flashTime;
        CDTimers[ destIndex ].countDown = CDTimers[ srcIndex ].countDown;
        CDTimers[ destIndex ].prefix = CDTimers[ srcIndex ].prefix;
        CDTimers[ destIndex ].suffix = CDTimers[ srcIndex ].suffix;
        
        -- Copy the event table
        CDTimers[ destIndex ].funcHandlers = {};
        if CDTimers[ srcIndex ].funcHandlers ~= nil then

            local index;        
            for index=1, CDTIMEREVENT_MAXEVENTS, 1 do
                CDTimers[ destIndex ].funcHandlers[ index ] = CDTimers[ srcIndex ].funcHandlers[ index ];
            end
            
            CDTimers[ srcIndex ].funcHandlers = nil;
        end
        
        -- Move the visual items
        CDTimer_SetText( destIndex, CDTimers[ destIndex ].text );
        CDTimer_SetIcon( destIndex, CDTimers[ destIndex ].icon );
    end

    -- Notify client of new timer index
    CDTimer_GenericHandler( destIndex, CDTIMEREVENT_ONMOVETIMER, srcIndex );    
end


function CDTimers_GetButtonSize()
    if CountDoom.config.scale == "large" then
        return 50;
    elseif CountDoom.config.scale == "small" then
        return 30;
    end;
    return 40;
end


function CDTimers_LayoutHorizontal()
    local buttonID = 0;
    local prevButton = nil;

    local buttonSize = CDTimers_GetButtonSize();

    for buttonID = 0, CDTimer_maxButtons - 1 do
        local button = getglobal( "CDTimerButton" .. buttonID);
        
        if button ~= nil then
            if prevButton ~= nil then
                button:ClearAllPoints();
                button:SetPoint("TOPLEFT", prevButton, "TOPRIGHT", 0, 0);
            end

            local buttonTexture = getglobal( "CDTimerButton" .. buttonID .. "_Icon" );
            if buttonTexture ~= nil then
                buttonTexture:Show();
            end

            button:SetHeight(buttonSize);
            button:SetWidth(buttonSize);
        end

        local buttonText = getglobal( "CDTimerButton" .. buttonID .. "_DurationText" );
        if buttonText ~= nil then
            if button ~= nil then
                buttonText:ClearAllPoints();
                buttonText:SetPoint("LEFT", button, "LEFT", 0, -(5 + (buttonSize/2)));
            end
        end

        prevButton = button;        
    end

    local numTimers = CDTimer_maxButtons;
    if numTimers == 0 then
        numTimers = 1;
    end

    CountDoomFrame:SetWidth( 5 + 5 + (buttonSize * numTimers) );
    CountDoomFrame:SetHeight( 5 + 5 + buttonSize + 12 ); 
end


function CDTimers_LayoutVertical()
    local buttonID = 0;
    local prevButton = nil;

    local buttonSize = CDTimers_GetButtonSize();

    for buttonID = 0, CDTimer_maxButtons - 1 do
        local button = getglobal( "CDTimerButton" .. buttonID);
        
        if button ~= nil then
            if prevButton ~= nil then
                button:ClearAllPoints();
                button:SetPoint("TOPLEFT", prevButton, "BOTTOMLEFT", 0, 0);
            end

            local buttonTexture = getglobal( "CDTimerButton" .. buttonID .. "_Icon" );
            if buttonTexture ~= nil then
                buttonTexture:Show();
            end

            button:SetHeight(buttonSize);
            button:SetWidth(buttonSize);
        end

        local buttonText = getglobal( "CDTimerButton" .. buttonID .. "_DurationText" );
        if buttonText ~= nil then
            if button ~= nil then
                buttonText:ClearAllPoints();
                buttonText:SetPoint("LEFT", button, "LEFT", buttonSize + 10, -7);
            end
        end

        prevButton = button;        
    end

    local numTimers = CDTimer_maxButtons;
    if numTimers == 0 then
        numTimers = 1;
    end

    CountDoomFrame:SetWidth(  5 + 5 + buttonSize + 40 );
    CountDoomFrame:SetHeight( 5 + 5 + ( buttonSize * numTimers ) ); 
end


function CDTimers_LayoutTextOnly()
    local buttonID = 0;
    local prevButton = nil;
    local prevButtonText = nil;

    for buttonID = 0, CDTimer_maxButtons - 1 do
        local button = getglobal( "CDTimerButton" .. buttonID);
        
        if button ~= nil then
            if prevButton ~= nil then
                button:ClearAllPoints();
                button:SetPoint("TOPLEFT", prevButton, "BOTTOMLEFT", 0, 0);
            end
        end

        if button ~= nil then
            local buttonTexture = getglobal( "CDTimerButton" .. buttonID .. "_Icon" );
            if buttonTexture ~= nil then
                buttonTexture:Hide();
            end

            button:SetHeight(15);
            button:SetWidth(30);
        end

        local buttonText = getglobal( "CDTimerButton" .. buttonID .. "_DurationText" );
        if buttonText ~= nil then
            buttonText:ClearAllPoints();
            buttonText:SetPoint("LEFT", button, "LEFT", 0, 0);
        end

        prevButtonText = buttonText;
        prevButton = button;
    end

    local numTimers = CDTimer_maxButtons;
    if numTimers == 0 then
        numTimers = 1;
    end

    CountDoomFrame:SetWidth(  5 + 5 + 250 );
    CountDoomFrame:SetHeight( 5 + 5 + ( 15 * numTimers ) ); 
end