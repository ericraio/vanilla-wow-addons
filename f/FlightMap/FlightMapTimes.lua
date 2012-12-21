FLIGHTMAPTIMES_FADESTEP  = 0.05;
FLIGHTMAPTIMES_FLASHSTEP = 0.05;

local lFMT_OldTakeTaxiNode;

StaticPopupDialogs["FLIGHT_CONFIRM"] = {
    text = TEXT(FLIGHTMAP_CONFIRM),
    button1 = TEXT(YES),
    button2 = TEXT(NO),
    OnAccept = function(data)
        FlightMapTimesFrame:Show();
        lFMT_OldTakeTaxiNode(data);
        if eCastingBar_SetTaxiInfo then eCastingBar_SetTaxiInfo(); end
    end,
    timeout = 0,
    hideOnEscape = 1
};

-- Hook the TakeTaxiNode() call to determine where the player is
-- flying to.
function FlightMapTimes_TakeTaxiNode(id)
    -- Some AddOns call this function with an invalid ID!
    if not id or id < 1 or id > NumTaxiNodes() then
        return
    end

    -- Establish where we are and where we're going
    local thisNode, thatNode = nil, id;
    for index = 1, NumTaxiNodes(), 1 do
        local tType = TaxiNodeGetType(index)
        if (tType == "CURRENT") then
            thisNode = index;
            break;
        end
    end

    -- Dig out the flight time data
    local map = FlightMapUtil.getFlightMap();

    -- Get the current continent number
    local cont = FlightMapUtil.getContinent();

    -- Construct node names
    local source = FlightMapUtil.makeNodeName(cont,
            TaxiNodePosition(thisNode));
    local dest = FlightMapUtil.makeNodeName(cont,
            TaxiNodePosition(thatNode));

    -- If both thisNode and thatNode exist...
    if (FlightMap.Opts.useTimer and thisNode and thatNode) then
        -- Check if this flight path has a known duration
        if map[source] and map[source].Flights[dest] then
            -- Time exists, so set it up
            FlightMapTimesFrame.startTime = GetTime();
            FlightMapTimesFrame.endTime = FlightMapTimesFrame.startTime
                                        + map[source].Flights[dest];
            FlightMapTimesFrame:SetMinMaxValues(
                    FlightMapTimesFrame.startTime,
                    FlightMapTimesFrame.endTime);
            FlightMapTimesFrame:SetValue(FlightMapTimesFrame.startTime);
            FlightMapTimesFrame:SetStatusBarColor(1.0, 0.7, 0.0);
            FlightMapTimesSpark:Show();
        else
            -- endTime of nil means we're timing this flight
            FlightMapTimesFrame.startTime = GetTime();
            FlightMapTimesFrame.endTime = nil;
            FlightMapTimesFrame:SetMinMaxValues(0, 100);
            FlightMapTimesFrame:SetValue(100);
            FlightMapTimesFrame:SetStatusBarColor(0.0, 0.0, 1.0);
            FlightMapTimesSpark:Hide();
        end
        -- Always keep track of the source and destination nodes,
        -- and the unqualified destination label
        FlightMapTimesFrame.sourceNode = source;
        FlightMapTimesFrame.destNode = dest;
        FlightMapTimesFrame.started = false;

        -- Dig out a shorter and easier on the eye name for the destination
        local nodeName = FlightMapUtil.getNameAndZone(TaxiNodeName(thatNode));
        FlightMapTimesFrame.endPoint = nodeName;

        -- Prepare to fade in
        FlightMapTimesFrame:SetAlpha(0);
        FlightMapTimesFrame:Show();
    else
        FlightMapTimesFrame:Hide();
    end

    -- Check for confirmation box
    if FlightMap.Opts.confirmFlights then
        local name = TaxiNodeName(thatNode);
        local duration = "";

        if map[dest] then name = map[dest].Name; end
        if map[source] and map[source].Flights[dest] then
            local seconds = map[source].Flights[dest];
            local timer = FlightMapUtil.formatTime(seconds);
            duration = FLIGHTMAP_CONFIRM_TIME;
            duration = duration .. timer;
        end
        local dialog = StaticPopup_Show("FLIGHT_CONFIRM", name, duration);
        if dialog then dialog.data = thatNode; end;

        -- Hide the times frame; it will get shown if the flight is accepted.
        FlightMapTimesFrame:Hide();
    else
        -- Get ourselves airborne
        lFMT_OldTakeTaxiNode(id);
    end
end

-- Hook TaxiNodeOnButtonEnter() to show flight times; this is hooked
-- after the Blizzard UI function so that the tooltip can be replaced
-- with one featuring additional information.
local lFMT_OldTaxiNodeOnButtonEnter;
function FlightMapTimes_TaxiNodeOnButtonEnter(button)
    -- Let old function get its job done
    lFMT_OldTaxiNodeOnButtonEnter(button);

    -- Establish a node key
    local index = this:GetID();
    local thisCont = FlightMapUtil.getContinent();
    local x, y = TaxiNodePosition(index);
    local nodeKey = FlightMapUtil.makeNodeName(thisCont, x, y);  

    -- Establish a source node
    local sourceKey;
    for i = 1, NumTaxiNodes(), 1 do
        if TaxiNodeGetType(i) == "CURRENT" then
            local x, y = TaxiNodePosition(i);
            sourceKey = FlightMapUtil.makeNodeName(thisCont, x, y);
        end
    end

    -- Recreate the tooltip!
    GameTooltip:SetOwner(button, "ANCHOR_RIGHT");
    FlightMapUtil.addFlightsForNode(GameTooltip, nodeKey, "", sourceKey);
    SetTooltipMoney(GameTooltip, TaxiNodeCost(this:GetID()));
    GameTooltip:Show();
end

function FlightMapTimes_OnLoad()
    lFMT_OldTakeTaxiNode = TakeTaxiNode;
    if (Sea) then
        lFMT_OldTaxiNodeOnButtonEnter = function() end;
        Sea.util.hook("TakeTaxiNode", "FlightMapTimes_TakeTaxiNode", "replace");
        Sea.util.hook("TaxiNodeOnButtonEnter",
                "FlightMapTimes_TaxiNodeOnButtonEnter", "after");
    else
        lFMT_OldTaxiNodeOnButtonEnter = TaxiNodeOnButtonEnter;
        TakeTaxiNode = FlightMapTimes_TakeTaxiNode;
        TaxiNodeOnButtonEnter = FlightMapTimes_TaxiNodeOnButtonEnter;
    end
    this:RegisterForDrag("LeftButton");
    FlightMapTimesFlash:SetAlpha(0);
end

local function lSaveFlightTime(length, from, to)
    -- Check for locked times
    if FlightMap.Opts.lockFlightTimes then return; end

    local map = FlightMapUtil.getFlightMap();

    -- Ensure we landed in the correct zone
    if map[this.destNode] then
        SetMapToCurrentZone();
        local zname = FlightMapUtil.getZoneName();
        if zname ~= map[this.destNode].Zone then return; end
    end

    -- Save the time
    if map[this.sourceNode] then
        map[this.sourceNode].Flights[this.destNode] = length;
    end
end

function FlightMapTimes_OnUpdate()
    -- Gotta wait until we mount up...
    if (not this.started) then
        if UnitOnTaxi("player") then this.started = true; end
        return;
    end

    -- Make sure the user is still airborne
    if (not UnitOnTaxi("player")) then
        local alpha = this:GetAlpha() - FLIGHTMAPTIMES_FADESTEP;
        local flash = FlightMapTimesFlash:GetAlpha();
        -- Flash the overlay in
        if flash < 1 then
            flash = flash + FLIGHTMAPTIMES_FLASHSTEP;
            if flash > 1 then flash = 1; end
            FlightMapTimesFlash:SetAlpha(flash);
        -- Fade the bar out
        elseif alpha > 0 then
            this:SetAlpha(alpha);
        else
            -- Hide up, reset alpha/flash
            this:Hide();
            this:SetAlpha(1.0);
            FlightMapTimesFlash:SetAlpha(0);
            -- If no time existed, or it was too long, save the recorded time
            if (not this.endTime or (GetTime() < this.endTime)) then
                local length = GetTime() - this.startTime;
                lSaveFlightTime(length, this.sourceNode, this.destNode);
            end
        end
    else
        local label = this.endPoint .. ": ";
        local now = GetTime();
        -- If the time was too short, wipe it out and save a new one!
        if (this.endTime and this.endTime < now) then
            this.endTime = nil;
            FlightMapTimesFrame:SetMinMaxValues(0, 100);
            FlightMapTimesFrame:SetValue(100);
            FlightMapTimesFrame:SetStatusBarColor(0.0, 0.0, 1.0);
            FlightMapTimesSpark:Hide();
        end

        -- Update the spark, status bar and label
        if (this.endTime) then
            local remains = this.endTime - now;
            label = label .. FlightMapUtil.formatTime(remains, true);
            local sparkPos = ((now - this.startTime)
                            / (this.endTime - this.startTime)) * 195;
            FlightMapTimesSpark:SetPoint("CENTER",
                    "FlightMapTimesFrame", "LEFT", sparkPos, 2);
            FlightMapTimesFrame:SetValue(now);
        else
            label = label .. FLIGHTMAP_TIMING;
        end
        FlightMapTimesText:SetText(label);

        -- If alpha is below one, fade-in is active
        local alpha = this:GetAlpha();
        if (alpha < 1) then
            alpha = alpha + FLIGHTMAPTIMES_FADESTEP * 4;
            if (alpha > 1) then alpha = 1; end
            this:SetAlpha(alpha);
        end
    end
end

-- Movable window
function FlightMapTimes_OnDragStart()
    if IsShiftKeyDown() then
        FlightMapTimesFrame:StartMoving();
    end
end

function FlightMapTimes_OnDragStop()
    FlightMapTimesFrame:StopMovingOrSizing();
end
