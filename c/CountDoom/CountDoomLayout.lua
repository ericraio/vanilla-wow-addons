CountDoomLayouts = {};

local CDL = {};
---------------------------------------
--
-- CountDoom's default text only layout
--
---------------------------------------
-- Common button attributes
CDL.button = {};
CDL.button.visible = true;
CDL.button.width = 30;
CDL.button.height = 15;
CDL.button.point = "TOPLEFT";
CDL.button.relativeObject = "previous";
CDL.button.relativePoint = "BOTTOMLEFT";
CDL.button.xoffset = 0;
CDL.button.yoffset = 0;

-- Overrides for specific buttons
CDL.button0 = {};
CDL.button0.relativeObject = "frame";
CDL.button0.relativePoint = "TOPLEFT";
CDL.button0.xoffset = 5;
CDL.button0.yoffset = -5;

-- Texture/Icon settings    
CDL.texture = {};
CDL.texture.visible = false;
CDL.texture.width = 30;
CDL.texture.height = 15;

-- Text settings
CDL.text = {};
CDL.text.visible = true;
CDL.text.point = "LEFT";
CDL.text.relativeObject = "button";
CDL.text.relativePoint = "LEFT";
CDL.text.xoffset = 0;
CDL.text.yoffset = 0;
CDL.text.formatString = "$ti";

-- Frame settings
CDL.frame = {};
CDL.frame.visible = false;
CDL.frame.point = "TOP";
CDL.frame.relativeObject = "UIParent";
CDL.frame.relativePoint = nil;
CDL.frame.xoffset = 150;
CDL.frame.yoffset = -50;
CDL.frame.widthPerTimer = 0;
CDL.frame.widthBase = 5 + 5 + 250;
CDL.frame.heightPerTimer = 15;
CDL.frame.heightBase = 5 + 5;

-- Store this in our table
CountDoomLayouts.textonly = CDL;
CDL = {};


---------------------------------------
--
-- CountDoom's default horizontal layout
--
---------------------------------------
-- Common button attributes
CDL.button = {};
CDL.button.visible = true;
CDL.button.width = 30;
CDL.button.height = 30;
CDL.button.point = "TOPLEFT";
CDL.button.relativeObject = "previous";
CDL.button.relativePoint = "TOPRIGHT";
CDL.button.xoffset = 0;
CDL.button.yoffset = 0;

-- Overrides for specific buttons
CDL.button0 = {};
CDL.button0.relativeObject = "frame";
CDL.button0.relativePoint = "TOPLEFT";
CDL.button0.xoffset = 5;
CDL.button0.yoffset = -5;

-- Texture/Icon settings    
CDL.texture = {};
CDL.texture.visible = true;
CDL.texture.width = 30;
CDL.texture.height = 30;

-- Text settings
CDL.text = {};
CDL.text.visible = true;
CDL.text.point = "LEFT";
CDL.text.relativeObject = "button";
CDL.text.relativePoint = "LEFT";
CDL.text.xoffset = 0;
CDL.text.yoffset = -(5 + (CDL.button.height/2));
CDL.text.formatString = "$ti";

-- Frame settings
CDL.frame = {};
CDL.frame.visible = false;
CDL.frame.point = "TOP";
CDL.frame.relativeObject = "UIParent";
CDL.frame.relativePoint = nil;
CDL.frame.xoffset = 150;
CDL.frame.yoffset = -50;
CDL.frame.widthPerTimer = CDL.button.width;
CDL.frame.widthBase = 5 + 5;
CDL.frame.heightPerTimer = 0;
CDL.frame.heightBase = 5 + 5 + CDL.button.height + 12;

-- Store this in our table
CountDoomLayouts.horizontal = CDL;
CDL = {};


---------------------------------------
--
-- CountDoom's default vertical layout
--
---------------------------------------
-- Common button attributes
CDL.button = {};
CDL.button.visible = true;
CDL.button.width = 30;
CDL.button.height = 30;
CDL.button.point = "TOPLEFT";
CDL.button.relativeObject = "previous";
CDL.button.relativePoint = "BOTTOMLEFT";
CDL.button.xoffset = 0;
CDL.button.yoffset = 0;

-- Overrides for specific buttons
CDL.button0 = {};
CDL.button0.relativeObject = "frame";
CDL.button0.relativePoint = "TOPLEFT";
CDL.button0.xoffset = 5;
CDL.button0.yoffset = -5;

-- Texture/Icon settingsCDL.
CDL.texture = {};
CDL.texture.visible = true;
CDL.texture.width = 30;
CDL.texture.height = 30;

-- Text settings
CDL.text = {};
CDL.text.visible = true;
CDL.text.point = "LEFT";
CDL.text.relativeObject = "button";
CDL.text.relativePoint = "LEFT";
CDL.text.xoffset = CDL.button.width + 10;
CDL.text.yoffset = -7;
CDL.text.formatString = "$ti";

-- Frame settings
CDL.frame = {};
CDL.frame.visible = false;
CDL.frame.point = "TOP";
CDL.frame.relativeObject = "UIParent";
CDL.frame.relativePoint = nil;
CDL.frame.xoffset = 150;
CDL.frame.yoffset = -50;
CDL.frame.widthPerTimer = 0;
CDL.frame.widthBase = 5 + 5 + CDL.button.width + 40;
CDL.frame.heightPerTimer = CDL.button.height;
CDL.frame.heightBase = 5 + 5;

-- Store this in our table
CountDoomLayouts.vertical = CDL;
CDL = {};

CountDoomLayout = {};

-- Function to set the parameters on a frame
CountDoomLayout.LoadFrameSettings = function( CDL )
    local numTimers = CDTimer_maxButtons;
    if numTimers == 0 then
        numTimers = 1;
    end

    -- Set the frame parameters
    local frame = CDL.frame;
    if frame ~= nil then

        local obj = CountDoomFrame;

        --[[
        -- The frame is enabled/disabled when timers are active or unlocked.
        if frame.visible then
            obj:Show(); 
        else
            obj:Hide();
        end
        --]]

        ---
        --- Set width
        ---
        local width = 0;
        if frame.widthPerTimer ~= nil then
            width = frame.widthPerTimer * numTimers;
        end

        if frame.widthBase ~= nil then
            width = width + frame.widthBase;
        end

        if width ~= 0 then
            obj:SetWidth( width );
        end

        ---
        --- Set height
        ---
        local height = 0;
        if frame.heightPerTimer ~= nil then
            height = frame.heightPerTimer * numTimers;
        end

        if frame.heightBase ~= nil then
            height = height + frame.heightBase;
        end

        if height ~= 0 then
            obj:SetHeight( height );
        end

        --[[
        CDL.frame = {};
        CDL.frame.point = "TOP";
        CDL.frame.relativeObject = "UIParent";
        CDL.frame.relativePoint = nil;
        CDL.frame.xoffset = 150;
        CDL.frame.yoffset = -50;
        --]]
    end;
end;


CountDoomLayout.LoadButtonSettings = function( CDL )
    local buttonID = 0;
    local prevObj = nil;

    if CDL.button == nil then
        CountDoom.prt( "No button settings found." );
        return;
    end;

    for buttonID = 0, CDTimer_maxButtons - 1 do
        local obj = getglobal( "CDTimerButton" .. buttonID);
        
        if obj ~= nil then

            local overrideString = "button" .. buttonID;
            
            local point = CDL.button.point;
            if CDL[overrideString] ~= nil and
                CDL[overrideString].point ~= nil then
                point = CDL[overrideString].point;
            end;

            local relativeObjectString = CDL.button.relativeObject;
            if CDL[overrideString] ~= nil and
                CDL[overrideString].relativeObject ~= nil then
                relativeObjectString = CDL[overrideString].relativeObject;
            end;

            local relativePoint = CDL.button.relativePoint;
            if CDL[overrideString] ~= nil and
                CDL[overrideString].relativePoint ~= nil then
                relativePoint = CDL[overrideString].relativePoint;
            end;

            local xoffset = CDL.button.xoffset;
            if CDL[overrideString] ~= nil and
                CDL[overrideString].xoffset ~= nil then
                xoffset = CDL[overrideString].xoffset;
            end;

            local yoffset = CDL.button.yoffset;
            if CDL[overrideString] ~= nil and
                CDL[overrideString].yoffset ~= nil then
                yoffset = CDL[overrideString].yoffset;
            end;

            if relativeObjectString == "previous" then
                relativeObject = prevObj;
            elseif relativeObjectString == "frame" then
                relativeObject = CountDoomFrame;
            else
                relativeObject = getglobal( relativeObjectString );
            end;

            if  point ~= nil and
                relativeObject ~= nil and
                relativePoint ~= nil and
                xoffset ~= nil and
                yoffset ~= nil then
                --
                -- Set this button's anchor information
                obj:ClearAllPoints();
                obj:SetPoint(point, relativeObject, relativePoint, xoffset, yoffset);
            end;

            --
            -- Set button width
            --
            local width = CDL.button.width;
            if CDL[overrideString] ~= nil and
                CDL[overrideString].width ~= nil then
                width = CDL[overrideString].width;
            end;

            if width ~= nil then
                obj:SetWidth(width);
            end;

            --
            -- Set button height
            --
            local height = CDL.button.height;
            if CDL[overrideString] ~= nil and
                CDL[overrideString].height ~= nil then
                height = CDL[overrideString].height;
            end;

            if height ~= nil then
                obj:SetHeight(height);
            end;

            --
            -- Button visibility is determined by an active timer.
            -- Not sure we should be setting here.
            --
        end;

        prevObj = obj;        
    end;
end;


CountDoomLayout.LoadTextSettings = function( CDL )
    local buttonID = 0;
    local prevObj = nil;

    if CDL.button == nil then
        CountDoom.prt( "No button settings found." );
        return;
    end;

    for buttonID = 0, CDTimer_maxButtons - 1 do
        local obj = getglobal( "CDTimerButton" .. buttonID .. "_DurationText" );
        
        if obj ~= nil then

            local point = CDL.text.point;
            local relativeObjectString = CDL.text.relativeObject;
            local relativePoint = CDL.text.relativePoint;
            local xoffset = CDL.text.xoffset;
            local yoffset = CDL.text.yoffset;

            if relativeObjectString == "previous" then
                relativeObject = prevObj;
            elseif relativeObjectString == "frame" then
                relativeObject = CountDoomFrame;
            elseif relativeObjectString == "button" then
                relativeObject = getglobal( "CDTimerButton" .. buttonID );
            else
                relativeObject = getglobal( relativeObjectString );
            end;

            if  point ~= nil and
                relativeObject ~= nil and
                relativePoint ~= nil and
                xoffset ~= nil and
                yoffset ~= nil then
                --
                -- Set this button's anchor information
                obj:ClearAllPoints();
                obj:SetPoint(point, relativeObject, relativePoint, xoffset, yoffset);
            end;

            --
            -- Set width
            --
            local width = CDL.text.width;
            if width ~= nil then
                obj:SetWidth(width);
            end;

            --
            -- Set height
            --
            local height = CDL.text.height;
            if height ~= nil then
                obj:SetHeight(height);
            end;

            --
            -- Set visibility
            --
            local visible = CDL.text.visible;
            if visible then
                obj:Show();
            else
                obj:Hide();
            end;
        end;

        prevObj = obj;        
    end;

end;


CountDoomLayout.LoadIconSettings = function( CDL )
    local buttonID = 0;
    local prevObj = nil;

    if CDL.button == nil then
        CountDoom.prt( "No button settings found." );
        return;
    end;

    for buttonID = 0, CDTimer_maxButtons - 1 do
        local obj = getglobal( "CDTimerButton" .. buttonID .. "_Icon" );
        
        if obj ~= nil then
            local width = CDL.texture.width;
            if width ~= nil then
                obj:SetWidth(width);
            end;

            local height = CDL.texture.height;
            if height ~= nil then
                obj:SetHeight(height);
            end;

            local visible = CDL.texture.visible;
            if visible then
                obj:Show();
            else
                obj:Hide();
            end;
        end;

        prevObj = obj;        
    end;
end;


-- Function to load a layout
CountDoomLayout.Load = function ( layout )
    if layout == nil then
        CountDoom.prt( "nil passed to CountDoomLayout.Load" );
        return;
    end;

    local CDL = CountDoomLayouts[ layout ];
    if CDL == nil then
        CountDoom.prt( "Layout " .. layout .. " not found." );
        return;
    end;

    CountDoomLayout.LoadFrameSettings( CDL );
    CountDoomLayout.LoadButtonSettings( CDL );
    CountDoomLayout.LoadTextSettings( CDL );
    CountDoomLayout.LoadIconSettings( CDL );

    CountDoom.prt( "Layout " .. layout .. " loaded." );
end;


CountDoomLayout.Delete = function ( layout )
    if layout == nil then
        CountDoom.prt( "nil passed to CountDoomLayout.Delete" );
        return;
    end;

    if CountDoomLayouts[ layout ] == nil then
        CountDoom.prt( "Layout " .. layout .. " not found." );
        return;
    end;

    CountDoomLayouts[ layout ] = nil;

    CountDoom.prt( "Layout " .. layout .. " deleted." );
end;


function CDIcon_Update(arg1)
end;


CountDoomLayout.textTable = {};


CountDoomLayout.GetRemainingTime = function( timerIndex, countDown )
    local minutes = 0;
    local seconds = 0;
    local hseconds = 0;

    if( CDTimers[ timerIndex ] == nil ) then
        CountDoom.dpf( "Invalid timerIndex in CountDoomLayout.textTable: " .. timerIndex );
        return minutes, seconds, hseconds;
    end
    
    local currentTime = GetTime();
    local rawDelta = currentTime - CDTimers[ timerIndex ].startTime;
    local duration = CDTimers[ timerIndex ].duration;
    local warningTime = CDTimers[ timerIndex ].warningTime;

    local delta = floor(rawDelta);
    if( delta > duration ) then
        delta = duration;
    end
    
    -- Invert for count down situations
    local timeDelta = rawDelta;
    if( countDown ) then
        timeDelta = duration - rawDelta;
    end

    local signScalar = 1;
    if timeDelta < 0 then
        signScalar = -1;
        timeDelta = -timeDelta;
    end

    local minutes = signScalar * floor(timeDelta/60);
    local seconds = floor(math.mod(timeDelta, 60));
    local hseconds = floor(math.mod(floor(rawDelta*100), 100));

    return minutes, seconds, hseconds;
end;


CountDoomLayout.textTable[ "$t1" ] = function( textStr, timerIndex )
    local countDown = CDTimers[ timerIndex ].countDown;
    local minutes, seconds, hseconds = CountDoomLayout.GetRemainingTime( timerIndex, countDown );

    local timeText = "" .. minutes;
	textStr = string.gsub(textStr, '$t1', timeText);
	return textStr;
end;


CountDoomLayout.textTable[ "$t2" ] = function( textStr, timerIndex )
    local countDown = CDTimers[ timerIndex ].countDown;
    local minutes, seconds, hseconds = CountDoomLayout.GetRemainingTime( timerIndex, countDown );

    local timeText = "";
    if (seconds >= 10) then
        timeText = minutes .. ":" .. seconds;
    else
        timeText = minutes .. ":0" .. seconds;
    end

	textStr = string.gsub(textStr, '$t2', timeText);
	return textStr;
end;


CountDoomLayout.textTable[ "$t3" ] = function( textStr, timerIndex )
    local countDown = CDTimers[ timerIndex ].countDown;
    local minutes, seconds, hseconds = CountDoomLayout.GetRemainingTime( timerIndex, countDown );

    local timeText = "";
    if (seconds >= 10) then
        timeText = minutes .. ":" .. seconds;
    else
        timeText = minutes .. ":0" .. seconds;
    end

    local htimeText = "";
    if (hseconds >= 10) then
        htimeText = "." .. hseconds;
    else
        htimeText = ".0" .. hseconds;
    end

	textStr = string.gsub(textStr, '$t3', timeText .. htimeText);
	return textStr;
end;


function CDText_Update(arg1)
    --[[
    if( CDTimers[ timerIndex ] == nil ) then
        CountDoom.dpf( "Invalid timerIndex in CountDoomLayout.textTable: " .. timerIndex );
        return;
    end
    --]]
end;


CDLTest = function()
    CountDoomLayout.Load( "NotFoundLayout" );
    CountDoomLayout.Load( "horizontal" );
    CountDoomLayout.Load( "vertical" );
    CountDoomLayout.Load( "textonly" );

    --CountDoomLayout.Delete( "textonly" );

    CountDoomLayout.Load( "horizontal" );
    CountDoomLayout.Load( "vertical" );
    CountDoomLayout.Load( "textonly" );
end;