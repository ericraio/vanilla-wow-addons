

function FlightTime_OnLoad() 
    this:RegisterEvent("PLAYER_CONTROL_LOST");
    this:RegisterEvent("PLAYER_CONTROL_GAINED");
    this:RegisterEvent("VARIABLES_LOADED");
    this:RegisterEvent("TAXIMAP_OPENED");
    this:RegisterEvent("TAXIMAP_CLOSED");
    
    SlashCmdList["FLIGHTTIME"] = FlightTime_Slash_Handler
    SLASH_FLIGHTTIME1 = "/ft"
    SLASH_FLIGHTTIMEE2 = "/flighttime"
    
    Saved_GameTooltipOnShowFunction = GameTooltip:GetScript("OnShow")
    GameTooltip:SetScript("OnShow",FT_ShowTooltip)

    taxiMapIsOpen = 0
end

function FT_ShowTooltip()

    --[[
    FT_ChatMsg("---------")
    local kids = { GameTooltip:GetChildren() };
    for _,child in ipairs(kids) do
        FT_ChatMsg(child:GetName())
    end
    FT_ChatMsg("---------")]]--
    
    if (taxiMapIsOpen == 1) then
        copperCost = 0
        silverCost = 0
        goldCost = 0
        if (GameTooltipMoneyFrameCopperButton:GetText()) then
            copperCost = GameTooltipMoneyFrameCopperButton:GetText()
        end
        if (GameTooltipMoneyFrameSilverButton:GetText()) then
            silverCost = GameTooltipMoneyFrameSilverButton:GetText()
        end
        if (GameTooltipMoneyFrameGoldButton:GetText()) then
            goldCost = GameTooltipMoneyFrameGoldButton:GetText()
        end
        totalCost = copperCost + (silverCost * 100) + (goldCost * 10000)
        --FT_ChatMsg("Total Cost: " .. totalCost)
    
        TtText = GameTooltipTextLeft1:GetText()
        numTaxiSpots = NumTaxiNodes()
        taxiNode = 1
        
        while (taxiNode <= numTaxiSpots) do
            if (TaxiNodeCost(taxiNode) == 0) then
                FT_startPoint = string.gsub(TaxiNodeName(taxiNode), "(%,.*)", "")
            end
            taxiNode = taxiNode + 1
        end
        
        taxiNode = 1
        while (taxiNode <= numTaxiSpots) do
            if (TaxiNodeName(taxiNode) == TtText) then
                FT_endPoint = string.gsub(TaxiNodeName(taxiNode), "(%,.*)", "")
                pointString = FT_startPoint .. "_to_" .. FT_endPoint
                if (FTDB[pointString]) then
                    Flight_Time = FT_ConvertTime(FTDB[pointString])
                else
                    Flight_Time = "Unknown"
                end
                if (FT_startPoint ~= FT_endPoint) then
                    --FT_ChatMsg(FT_startPoint .. " to " .. FT_endPoint .. ": " .. Flight_Time)
                    GameTooltip:AddLine("ETA: " .. Flight_Time,1,1,1)
                    GameTooltip:SetHeight(GameTooltip:GetHeight() + 15)
                end
            end
            taxiNode = taxiNode + 1
        end
        
        
    end
    
    
    if (Saved_GameTooltipOnShowFunction) then
        Saved_GameTooltipOnShowFunction()
    end
    
    
end

function FlightTime_OnEvent(event)
    if (event == "VARIABLES_LOADED") then
        FT_LoadVars()
       -- FT_ChatMsg("FlightTime Loaded! Type /ft or /flighttime for more info")
        
    elseif (event == "PLAYER_CONTROL_LOST") then
        FT_onFlight = 0
        FlightTime:Show()
        --[[FT_ChatMsg("Leavin on a jet plane")
        if (UnitOnTaxi("player")) then
            FT_onFlight = 1
            FT_startTime = GetTime()
            FlightTime:Show()
        else
            FT_onFlight = 0
        end]]
        -- check to see if they are on a griffon
    elseif (event == "PLAYER_CONTROL_GAINED") then
        if (FT_onFlight == 1) then
            FT_endTime = GetTime()
            FT_totalTime = FT_endTime - FT_startTime
            FT_onFlight = 0
            FlightTime:SetAlpha(0)
            if (FTDB[pointString] == nil) then
                FT_ChatMsg("FlightTime: Saved data going from " .. FT_startPoint .. " to " .. FT_endPoint)
            end
            FTDB[pointString] = FT_totalTime
            FlightTime:Hide()
        end            
        -- check to see if they were just on a griffon
    elseif (event == "TAXIMAP_OPENED") then
        taxiMapIsOpen = 1
    elseif (event == "TAXIMAP_CLOSED") then
        taxiMapIsOpen = 0
    end
end

function FT_ChatMsg(msg)
    if(DEFAULT_CHAT_FRAME) then
        DEFAULT_CHAT_FRAME:AddMessage("|cffffffff" .. msg);
    end
end

function FlightTime_UpdateTime()
    if (UnitOnTaxi("player") and FT_onFlight == 0) then 
        FlightTime:SetAlpha(1)
        FT_onFlight = 1
        FT_startTime = GetTime()
    end
    
    if (FT_onFlight == 1) then
        if (FTDB[pointString]) then
            FT_FormatDisplay(0)
            timeRemaining = FTround(FTDB[pointString] - (GetTime() - FT_startTime),0)
            if (timeRemaining < 0) then timeRemaining = 0 end -- don't display negative seconds
            minutes = math.floor(timeRemaining/60)
            seconds = timeRemaining - (minutes*60)
            seconds = tostring(seconds)
            if (string.len(seconds) == 1) then
                seconds = "0" .. seconds
            end
            if (FTDB["display"] == 1) then
                dispString = FT_endPoint .. " - " .. minutes .. ":" .. seconds
            else
                dispString = minutes .. ":" .. seconds
            end
            FlightTime_Text:SetText(dispString)
        else
            FT_FormatDisplay(1)
            FlightTime_Text:SetText("Recording Flight Times");
        end
    end
end

function FT_ConvertTime(totalSeconds)
    totalSeconds = FTround(totalSeconds,0)
    if (totalSeconds < 0) then totalSeconds = 0 end -- don't display negative seconds
    minutes = math.floor(totalSeconds/60)
    seconds = totalSeconds - (minutes*60)
    seconds = tostring(seconds)
    if (string.len(seconds) == 1) then
        seconds = "0" .. seconds
    end
        dispString = minutes .. ":" .. seconds
    return dispString
end

function FlightTime_Slash_Handler(msg)
    argv = {};
    for arg in string.gfind(string.lower(msg), '[%a%d%-%.]+') do
        table.insert(argv, arg);
    end
    
    if (argv[1] == "forcehide") then
        if (FTDB["forcehide"] == 0) then 
            FTDB["forcehide"] = 1
            FT_ChatMsg("FlightTime display de-activated, data to new Flight Path's will still be recorded")
        else
            if (UnitOnTaxi("player")) then FlightTime:Show() end
            FTDB["forcehide"] = 0
            FT_ChatMsg("Flight display activated")
        end
    elseif (argv[1] == "color") then
        if (argv[2]) then
            if (argv[2] == "blue") then
                FTDB["color"] = argv[2]
                FT_ChatMsg("FlightTime background color set to " .. FTDB["color"])
            elseif (argv[2] == "green") then
                FTDB["color"] = argv[2]
                FT_ChatMsg("FlightTime background color set to " .. FTDB["color"])
            elseif (argv[2] == "yellow") then
                FTDB["color"] = argv[2]
                FT_ChatMsg("FlightTime background color set to " .. FTDB["color"])
            elseif (argv[2] == "red") then
                FTDB["color"] = argv[2]
                FT_ChatMsg("FlightTime background color set to " .. FTDB["color"])
            else
                FT_ChatMsg("Invalid color: " .. argv[2] .. ". Example: '/ft color blue'")
            end
        else
            FT_ChatMsg("You must specify a color! Example: '/ft color blue'")
        end
    elseif (argv[1] == "bgtoggle") then
        if (FTDB["bgtoggle"] == 0) then 
            FTDB["bgtoggle"] = .5
            FT_ChatMsg("FlightTime background disabled")
        else
            FTDB["bgtoggle"] = 0
            FT_ChatMsg("FlightTime background enabled")
        end
    elseif (argv[1] == "display") then
        if (FTDB["display"] == 0) then 
            FTDB["display"] = 1
            FT_ChatMsg("FlightTime now displaying Destination and time remaining")
        else
            FTDB["display"] = 0
            FT_ChatMsg("FlightTime only showing time remaining")
        end
    elseif (argv[1] == "notify") then
        if (FTDB["notify"] == 0) then 
            FTDB["notify"] = 1
            FT_ChatMsg("FlightTime will no longer display when recording data")
        else
            FTDB["notify"] = 0
            if (UnitOnTaxi("player")) then FlightTime:Show() end
            FT_ChatMsg("FlightTime will now display when recording data")
        end
    else
        if (argv[1] == nil) then
            FlightTime_Help()
        else
            FT_ChatMsg("Invalid command: " .. argv[1] .. ". Type /ft for more info")
        end
    end
end

function FlightTime_Help()
    FT_ChatMsg("FlightTime Commands");
    FT_ChatMsg("----------------------------------");
    FT_ChatMsg("/ft forcehide - toggles display during flight (times are still recorded)");
    FT_ChatMsg("/ft color green|yellow|blue|red - sets background color");
    FT_ChatMsg("/ft bgtoggle - toggles display of background");
    FT_ChatMsg("/ft record - toggles display when data is being recorded for the first time");
    FT_ChatMsg("/ft display - toggles short or long display of time left");
end

function FTround( num, vdp )
    local vdp = vdp or 2
    return tonumber( string.format("%."..vdp.."f", num ) )
end

function FT_FormatDisplay(recording)
    if (FTDB["forcehide"] == 1) then FlightTime:Hide() end
    if (recording == 1) then
        if (FTDB["notify"] == 1) then FlightTime:Hide() end
    end
    if (FTDB["color"] == "blue") then
        FlightTime:SetBackdropColor(0,0,1,FTDB["bgtoggle"])
    elseif (FTDB["color"] == "green") then
        FlightTime:SetBackdropColor(0,1,0,FTDB["bgtoggle"])
    elseif (FTDB["color"] == "red") then
        FlightTime:SetBackdropColor(1,0,0,FTDB["bgtoggle"])
    else --yellow
        FlightTime:SetBackdropColor(1,1,0,FTDB["bgtoggle"])
    end
end

function FT_LoadVars()
    if (FTDB == nil) then
        FTDB = {}
    end

    if (FTDB["forcehide"] == nil) then
        FTDB["forcehide"] = 0
    end
    if (FTDB["color"] == nil) then
        FTDB["color"] = "blue"
    end
    if (FTDB["bgtoggle"] == nil) then
        FTDB["bgtoggle"] = .5
    end
    if (FTDB["display"] == nil) then
        FTDB["display"] = 1
    end
    if (FTDB["notify"] == nil) then
        FTDB["notify"] = 0
    end
    
    pointsArray = nil
    pointsArray = {}
end