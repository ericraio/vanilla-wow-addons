--
-- LevelRange :: Main Lua File
-- Copyright (c) 2006 Philip Hughes (Bull3t)
-- 
-- Shows the zone level range on the World Map.
--
-- Thanks to Dhask for allowing the use of his FlightMap.
--
-- An unlimited license to use, reproduce and copy this work is granted, on
-- the condition that the licensee accepts all responsibility and liability
-- for any damage that may arise from the use of this AddOn.
--


--------------------------------------------------------------------------------------------------
-- Global Variables
--------------------------------------------------------------------------------------------------

-- Name
LEVELRANGE_NAME			= "LevelRange"

-- Version Number
LEVELRANGE_VERSION   		= "1.2.0";

-- Details
Details = {
    name 			= LEVELRANGE_NAME,
    version 			= LEVELRANGE_VERSION,
    releaseDate 		= "September 05, 2006",
    author 			= "Bull3t",
    email 			= "bull3t@ntlworld.com",
    website 			= "http://www.levelrange.co.nr",
    category 			= MYADDONS_CATEGORY_MAP,
    optionsframe 		= "LevelRangeOptionsFrame"
};

-- Help
Help = {
    [1] 			= LEVELRANGE_HELP0 .. "\n" .. LEVELRANGE_HELP1 .. "\n" .. LEVELRANGE_HELP2 .. "\n" .. LEVELRANGE_HELP3 .. "\n" .. LEVELRANGE_HELP4 .. "\n" .. LEVELRANGE_HELP5,
};

-- Player Info
playerName                      = UnitName("player");
realmName                       = GetRealmName();

-- Default Variables
LevelRangeSettings		= {};
DEFAULT_LEVELRANGE_SHOW		= true;
DEFAULT_LEVELRANGE_SHOWINSTANCE = true;
DEFAULT_LEVELRANGE_SHOWRAIDS	= true;
DEFAULT_LEVELRANGE_SHOWPVP	= true;

-- Realm|PlayerName
LEVELRANGE_REALMPLAYERNAME 	= realmName .. "|" .. playerName

-- Slash Commands
LEVELRANGE_SLASH1     		= "lr"
LEVELRANGE_SLASH2     		= "levelrange"

-- Faction Types
local lTYPE_HORDE     		= LEVELRANGE_HORDE;
local lTYPE_ALLIANCE  		= LEVELRANGE_ALLIANCE;
local lTYPE_CONTESTED 		= LEVELRANGE_CONTESTED;

-- Level Ranges
LEVELRANGE_RANGES = {
    [LEVELRANGE_ELWYNN]        	= { 1, 10, lTYPE_ALLIANCE},
    [LEVELRANGE_DUNMOROGH]     	= { 1, 10, lTYPE_ALLIANCE},
    [LEVELRANGE_TIRISFAL]      	= { 1, 10, lTYPE_HORDE},
    [LEVELRANGE_LOCHMODAN]    	= {10, 20, lTYPE_ALLIANCE},
    [LEVELRANGE_SILVERPINE]    	= {10, 20, lTYPE_HORDE},
    [LEVELRANGE_WESTFALL]      	= {10, 20, lTYPE_ALLIANCE},
    [LEVELRANGE_REDRIDGE]      	= {15, 25, lTYPE_CONTESTED},
    [LEVELRANGE_DUSKWOOD]      	= {18, 30, lTYPE_CONTESTED},
    [LEVELRANGE_HILLSBRAD]     	= {20, 30, lTYPE_CONTESTED},
    [LEVELRANGE_WETLANDS]      	= {20, 30, lTYPE_CONTESTED},
    [LEVELRANGE_ALTERAC]       	= {30, 40, lTYPE_CONTESTED},
    [LEVELRANGE_ARATHI]        	= {30, 40, lTYPE_CONTESTED},
    [LEVELRANGE_STRANGLETHORN] 	= {30, 45, lTYPE_CONTESTED},
    [LEVELRANGE_BADLANDS]      	= {35, 45, lTYPE_CONTESTED},
    [LEVELRANGE_SORROWS]       	= {35, 45, lTYPE_CONTESTED},
    [LEVELRANGE_HINTERLANDS]   	= {40, 50, lTYPE_CONTESTED},
    [LEVELRANGE_SEARINGGORGE]  	= {43, 50, lTYPE_CONTESTED},
    [LEVELRANGE_BLASTEDLANDS]  	= {45, 55, lTYPE_CONTESTED},
    [LEVELRANGE_BURNINGSTEPPE] 	= {50, 58, lTYPE_CONTESTED},
    [LEVELRANGE_WESTERNPLAGUE] 	= {51, 58, lTYPE_CONTESTED},
    [LEVELRANGE_EASTERNPLAGUE] 	= {53, 60, lTYPE_CONTESTED},
    [LEVELRANGE_DEADWINDPASS]  	= {55, 60, lTYPE_CONTESTED},
    
    [LEVELRANGE_DUROTAR]       	= { 1, 10, lTYPE_HORDE},
    [LEVELRANGE_MULGORE]       	= { 1, 10, lTYPE_HORDE},
    [LEVELRANGE_DARKSHORE]     	= {10, 20, lTYPE_ALLIANCE},
    [LEVELRANGE_BARRENS]       	= {10, 25, lTYPE_HORDE},
    [LEVELRANGE_STONETALON]    	= {15, 27, lTYPE_CONTESTED},
    [LEVELRANGE_ASHENVALE]     	= {18, 30, lTYPE_CONTESTED},
    [LEVELRANGE_1KNEEDLES]     	= {25, 35, lTYPE_CONTESTED},
    [LEVELRANGE_DESOLACE]      	= {30, 40, lTYPE_CONTESTED},
    [LEVELRANGE_DUSTWALLOW]    	= {35, 45, lTYPE_CONTESTED},
    [LEVELRANGE_FERALAS]       	= {40, 50, lTYPE_CONTESTED},
    [LEVELRANGE_TANARIS]       	= {40, 50, lTYPE_CONTESTED},
    [LEVELRANGE_AZSHARA]       	= {45, 55, lTYPE_CONTESTED},
    [LEVELRANGE_FELWOOD]       	= {48, 55, lTYPE_CONTESTED},
    [LEVELRANGE_UNGOROCRATER]  	= {48, 55, lTYPE_CONTESTED},
    [LEVELRANGE_SILITHUS]      	= {55, 60, lTYPE_CONTESTED},
    [LEVELRANGE_WINTERSPRING]  	= {55, 60, lTYPE_CONTESTED},

    [LEVELRANGE_MOONGLADE]     	= { 1, 60, lTYPE_CONTESTED},
    
    [LEVELRANGE_TELDRASSIL]    	= { 1, 10, lTYPE_ALLIANCE},

};

-- Instances
LEVELRANGE_INSTANCES = {
    [LEVELRANGE_WESTFALL]	= {LEVELRANGE_DEADMINES, " (17-26)"},	
    [LEVELRANGE_BARRENS]	= {LEVELRANGE_WAILINGCAVERNS, " (17-24)", LEVELRANGE_RAZORFENKRAUL, " (25-30)", LEVELRANGE_RAZORFENDOWNS, " (33-45)"},
    [LEVELRANGE_SILVERPINE]	= {LEVELRANGE_SHADOWFANGKEEP, " (22-30)"},
    [LEVELRANGE_ASHENVALE]	= {LEVELRANGE_BLACKFATHOMDEEPS, " (24-32)"},
    [LEVELRANGE_DUNMOROGH]	= {LEVELRANGE_GNOMEREGAN, " (29-38)"},
    [LEVELRANGE_TIRISFAL]	= {LEVELRANGE_SCARLETMONASTERY, " (34-45)"},
    [LEVELRANGE_BADLANDS]  	= {LEVELRANGE_ULDAMAN, " (35-47)"},
    [LEVELRANGE_DESOLACE]	= {LEVELRANGE_MARAUDON, " (46-55)"},
    [LEVELRANGE_SORROWS]    	= {LEVELRANGE_SUNKENTEMPLE, " (45-55)"},
    [LEVELRANGE_SEARINGGORGE]   = {LEVELRANGE_BLACKROCKDEPTH, " (52-60)", LEVELRANGE_BLACKROCKSPIRE, " (58-60)"},
    [LEVELRANGE_BURNINGSTEPPE]  = {LEVELRANGE_BLACKROCKDEPTH, " (52-60)", LEVELRANGE_BLACKROCKSPIRE, " (58-60)"},
    [LEVELRANGE_EASTERNPLAGUE]  = {LEVELRANGE_STRATHOLME, " (58-60)"},
    [LEVELRANGE_FERALAS]    	= {LEVELRANGE_DIREMAUL, " (55-60)"},
    [LEVELRANGE_WESTERNPLAGUE]  = {LEVELRANGE_SCHOLOMANCE, " (57-60)"},
    [LEVELRANGE_DUROTAR]     	= {LEVELRANGE_RAGEFIRECHASM, " (13-18)"},
    [LEVELRANGE_ELWYNN]		= {LEVELRANGE_STOCKADES, " (24-32)"},
    [LEVELRANGE_TANARIS] 	= {LEVELRANGE_ZULFARRAK, " (44-54)"},
};

-- Raids
LEVELRANGE_RAIDS = {
    [LEVELRANGE_EASTERNPLAGUE]	= {LEVELRANGE_NAXXRAMAS, " (60+)"},
    [LEVELRANGE_DUSTWALLOW]	= {LEVELRANGE_ONYXIASLAIR, " (60+)"},
    [LEVELRANGE_SILITHUS]	= {LEVELRANGE_RUINSAHNQIRAJ, " (60+)", LEVELRANGE_TEMPLEAHNQIRAJ, " (60+)"},
    [LEVELRANGE_STRANGLETHORN]	= {LEVELRANGE_ZULGURUB, " (60+)"},
};

-- Sub-zones
LEVELRANGE_SUBZONES = {
    [LEVELRANGE_ORGRIMMAR]    	= LEVELRANGE_DUROTAR,
    [LEVELRANGE_THUNDERBLUFF] 	= LEVELRANGE_MULGORE,
    [LEVELRANGE_UNDERCITY]    	= LEVELRANGE_TIRISFAL,
    [LEVELRANGE_IRONFORGE]    	= LEVELRANGE_DUNMOROGH,
    [LEVELRANGE_STORMWIND]    	= LEVELRANGE_ELWYNN,
};

-- Colours
LEVELRANGE_COLORS = {
    Unknown   			= { r = 0.8, g = 0.8, b = 0.8 },
    Hostile   			= { r = 0.9, g = 0.2, b = 0.2 },
    Friendly  			= { r = 0.2, g = 0.9, b = 0.2 },
    Contested 			= { r = 0.8, g = 0.6, b = 0.4 },
    
    None      			= { r = 1.0, g = 1.0, b = 1.0 },
    Levels    			= { r = 0.8, g = 0.6, b = 0.0 },
};

-- Options
LevelRange = {
    ["Opts"]			= LEVELRANGE_DEFAULT_OPTS,
};


--------------------------------------------------------------------------------------------------
-- Map Drawing Functions
--------------------------------------------------------------------------------------------------

-- Update the tooltip for a zone
local function lUpdateTooltip(zoneName)
    
    -- Check Toggle
    if (LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showLevelRange == false) then
        LevelRangeTooltip:Hide();
        return;
    end

    -- No zone name, no tooltip!
    if not zoneName or zoneName == "" then
        LevelRangeTooltip:Hide();
        return;
    end

    -- Unused anchor point
    LevelRangeTooltip:SetOwner(this, "ANCHOR_LEFT");

    -- Determine colour and level range
    local title = LEVELRANGE_COLORS.Unknown;
    local normalcol = LEVELRANGE_COLORS.None;
    local levelscol = LEVELRANGE_COLORS.Levels;

    local levels = nil;
    local actualside = nil;

    if (LEVELRANGE_RANGES[zoneName]) then
        local _, faction = UnitFactionGroup("player");
        local min = LEVELRANGE_RANGES[zoneName][1];
        local max = LEVELRANGE_RANGES[zoneName][2];
        local side = LEVELRANGE_RANGES[zoneName][3];
        
        if (side == lTYPE_CONTESTED) then
            title = LEVELRANGE_COLORS.Contested;
            actualside = "Contested";
        else
            if (faction == side) then
                title = LEVELRANGE_COLORS.Friendly;
                actualside = "Friendly";
            else
                title = LEVELRANGE_COLORS.Hostile;
                actualside = "Hostile";
            end
        end
        levels = string.format(LEVELRANGE_LEVELS, min, max);
    end

    -- Start making the Tooltip

    -- Show the zone title and add level range if known
    LevelRangeTooltip:SetText(zoneName, normalcol.r, normalcol.g, normalcol.b);
    if levels then
        LevelRangeTooltip:AddLine(levels, levelscol.r, levelscol.g, levelscol.b);
    end
    
    -- Show diplomacy if known and if wanted
    if (LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showPvP == true) then
        if actualside then
            LevelRangeTooltip:AddLine(actualside, title.r, title.g, title.b);
        end
    end
    
    -- Add instance info if wanted
    if (LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showInstances == true) then
        if (LEVELRANGE_INSTANCES[zoneName]) then
            LevelRangeTooltip:AddLine(" ");
            LevelRangeTooltip:AddLine(LEVELRANGE_INSTANCESTEXT);
            getInstanceLevels(zoneName, LevelRangeTooltip);
        end
    end
    if (LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showRaids == true) then
        if (LEVELRANGE_RAIDS[zoneName]) then
            LevelRangeTooltip:AddLine(" ");
            LevelRangeTooltip:AddLine(LEVELRANGE_RAIDSTEXT);
            getRaidLevels(zoneName, LevelRangeTooltip);
        end
    end

    -- This stuff seems to get reset each time
    --LevelRangeTooltip:SetBackdropColor(0, 0, 0, 0.8);
    LevelRangeTooltip:SetBackdropBorderColor(1, 1, 1, 1);
    LevelRangeTooltip:ClearAllPoints();
    LevelRangeTooltip:SetPoint("BOTTOMLEFT", "WorldMapDetailFrame", "BOTTOMLEFT", 0, 0);

    -- Only show if there is level information
    if levels then
        LevelRangeTooltip:Show();
    else
        LevelRangeTooltip:Hide();
    end

    -- Now go ahead and put the tooltip into the right location
    LevelRangeTooltip:ClearAllPoints();
    LevelRangeTooltip:SetPoint("BOTTOMLEFT", WorldMapDetailFrame);

    if (FlightMapFrame) then
        LevelRangeTooltip:ClearAllPoints();
        LevelRangeTooltip:SetPoint("BOTTOMRIGHT", "WorldMapDetailFrame",
                "BOTTOMRIGHT", 0, 0);
    end

end

-- Last drawn info for tooltip
lLR_CurrentZone = nil;
lLR_CurrentArea = nil;
local lLR_OldUpdate = function() end;

-- Replacement function to draw all the extra goodies of LevelRange
function LevelRange_WorldMapButton_OnUpdate(arg1)
    lLR_OldUpdate(arg1);
    local areaName = WorldMapFrame.areaName;
    local zoneNum = GetCurrentMapZone();

    -- Zone name equivalence map
    if LEVELRANGE_SUBZONES[areaName] then
        areaName = LEVELRANGE_SUBZONES[areaName];
    end

    -- Bail out if nothing has changed
    if zoneNum == lLR_CurrentZone and areaName == lLR_CurrentArea then
        return;
    end

    -- Continent or zone map?
    if zoneNum == 0 then
        lUpdateTooltip(areaName);
    else
        lUpdateTooltip(nil);            -- hide it
    end
end


--------------------------------------------------------------------------------------------------
-- Print Message Functions
--------------------------------------------------------------------------------------------------

function printMSG(msg)
   DEFAULT_CHAT_FRAME:AddMessage("|CF4FFFF4FLevelRange|r: " .. msg, 1, 1, 1);
end

function printHELPMSG(msg)
   DEFAULT_CHAT_FRAME:AddMessage("|CF4FF4F4FLevelRange Help|r: " .. msg, 1, 1, 1);
end

function printOPTION(msg, status)
   DEFAULT_CHAT_FRAME:AddMessage("|CF4FFFF4F" .. msg .. "|r" .. ": " .. status, 1 ,1 ,1);
end


--------------------------------------------------------------------------------------------------
-- Slash Command Functions
--------------------------------------------------------------------------------------------------

-- Command
function LevelRange_GetCmd(msg)
    if msg then
        local a,b,c=strfind(msg, "(%S+)"); -- contiguous string of non-space characters
        if a then
            return c, strsub(msg, b+2);
        else	            
	    return "";
        end
    end
end

-- Handler
function LevelRange_SlashHandler(msg)
    local Cmd, SubCmd = LevelRange_GetCmd(msg); -- call to above function
    if (Cmd == "help") then
 	showHelp();

    elseif (Cmd == "list") then
 	printInstances();

    -- Toggle LevelRange tooltip
    elseif (Cmd == "toggle") then
        toggleLevelRange();

    -- Toggle LevelRange showing instances
    elseif (Cmd == "instances") then
        toggleInstances();

    elseif (Cmd == "") then
        if (LevelRangeOptionsFrame:IsVisible()) then
            HideUIPanel(LevelRangeOptionsFrame);
        else
            ShowUIPanel(LevelRangeOptionsFrame);
        end

    -- Wrong command so show help
    else
        showHelp();
    end
end

function printInstances()
    return;
end

function showHelp()
    printHELPMSG(LEVELRANGE_HELP0);
    printHELPMSG(LEVELRANGE_HELP1);
    printHELPMSG(LEVELRANGE_HELP2);
    printHELPMSG(LEVELRANGE_HELP3);
    printHELPMSG(LEVELRANGE_HELP4);
    printHELPMSG(LEVELRANGE_HELP5);
end


--------------------------------------------------------------------------------------------------
-- Toggles
--------------------------------------------------------------------------------------------------

function toggleLevelRange()
    if (LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showLevelRange == false) then
       LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showLevelRange = true;
       printOPTION(LEVELRANGE_TOGGLESHOW, LEVELRANGE_ENABLED);
    else
       LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showLevelRange = false;
       printOPTION(LEVELRANGE_TOGGLESHOW, LEVELRANGE_DISABLED);
    end
end

function toggleInstances()
    if (LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showInstances == false) then
       LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showInstances = true;
       printOPTION(LEVELRANGE_TOGGLEINSTANCES, LEVELRANGE_ON);
    else
       LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showInstances = false;
       printOPTION(LEVELRANGE_TOGGLEINSTANCES, LEVELRANGE_OFF);
    end
end

function toggleRaids()
    if (LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showRaids == false) then
       LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showRaids = true;
       printOPTION(LEVELRANGE_TOGGLERAIDS, LEVELRANGE_ON);
    else
       LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showRaids = false;
       printOPTION(LEVELRANGE_TOGGLERAIDS, LEVELRANGE_OFF);
    end
end

function togglePvP()
    if (LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showPvP == false) then
       LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showPvP = true;
       printOPTION(LEVELRANGE_TOGGLEPVP, LEVELRANGE_ON);
    else
       LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showPvP = false;
       printOPTION(LEVELRANGE_TOGGLEPVP, LEVELRANGE_OFF);
    end
end


--------------------------------------------------------------------------------------------------
-- Instance and Raid Information
--------------------------------------------------------------------------------------------------

function getInstanceLevels(zoneName, theTooltip) 
    if (LEVELRANGE_INSTANCES[zoneName]) then
        if (LEVELRANGE_INSTANCES[zoneName][1]) then
            theTooltip:AddDoubleLine("|CFFcFcFcF" .. LEVELRANGE_INSTANCES[zoneName][1] .. "|r", "|CFFcFcFcF" .. LEVELRANGE_INSTANCES[zoneName][2] .. "|r");
        end
        if (LEVELRANGE_INSTANCES[zoneName][3]) then
            theTooltip:AddDoubleLine("|CFFcFcFcF" .. LEVELRANGE_INSTANCES[zoneName][3] .. "|r", "|CFFcFcFcF" .. LEVELRANGE_INSTANCES[zoneName][4] .. "|r");
        end
        if (LEVELRANGE_INSTANCES[zoneName][5]) then
            theTooltip:AddDoubleLine("|CFFcFcFcF" .. LEVELRANGE_INSTANCES[zoneName][5] .. "|r", "|CFFcFcFcF" .. LEVELRANGE_INSTANCES[zoneName][6] .. "|r");
        end
    end
end

function getRaidLevels(zoneName, theTooltip) 
    if (LEVELRANGE_RAIDS[zoneName]) then
        if (LEVELRANGE_RAIDS[zoneName][1]) then
            theTooltip:AddDoubleLine("|CFFcFcFcF" .. LEVELRANGE_RAIDS[zoneName][1] .. "|r", "|CFFcFcFcF" .. LEVELRANGE_RAIDS[zoneName][2] .. "|r");
        end
        if (LEVELRANGE_RAIDS[zoneName][3]) then
            theTooltip:AddDoubleLine("|CFFcFcFcF" .. LEVELRANGE_RAIDS[zoneName][3] .. "|r", "|CFFcFcFcF" .. LEVELRANGE_RAIDS[zoneName][4] .. "|r");
        end
    end
end


--------------------------------------------------------------------------------------------------
-- Options Frame
--------------------------------------------------------------------------------------------------

-- OnShow of options frame
function LevelRangeOptionsFrame_OnShow()
    -- Set localised strings
    LevelRangeOptionsFrameClose:SetText(LEVELRANGE_OPTIONS_CLOSE);
    LevelRangeOptionsFrameTitle:SetText(LEVELRANGE_OPTIONS_TITLE);

    -- Set up options from localised data
    local base = "LevelRangeOptionsFrame"
    for optid, option in pairs(LEVELRANGE_OPTIONS) do
        local name = base .. "Opt" .. optid;
        local button = getglobal(name);
        local label = getglobal(name .. "Text");
        OptionsFrame_EnableCheckBox(button, 1, LevelRange.Opts[option.option]);

        -- Simple stuff
        label:SetText(option.label);
        button.tooltipText = option.tooltip;
        button.option = option.option;
        button.children = option.children or {};
    end 

    for optid, option in pairs(LEVELRANGE_OPTIONS) do
        -- Enable/disable any children
        for _, child in option.children or {} do
            local other = getglobal(base .. "Opt" .. child);
            if other then
                if LevelRange.Opts[option.option] then
                    OptionsFrame_EnableCheckBox(other, 1,
                        LevelRange.Opts[LEVELRANGE_OPTIONS[child].option]);
                else
                    OptionsFrame_DisableCheckBox(other);
                end
            end
        end
    end
    loadSettings();
end

-- OnHide of options frame
function LevelRangeOptionsFrame_OnHide()
    return;
end

-- OnClick of options button
function LevelRangeOptionsCheckButton_OnClick()

    if (this.option == "showLevelRange") then
        toggleLevelRange(this);
    elseif (this.option == "showInstances") then
        toggleInstances();
    elseif (this.option == "showRaids") then
	toggleRaids();
    elseif (this.option == "showPvP") then
	togglePvP();
    end
    
    if (this:GetChecked()) then
        LevelRange.Opts[this.option] = true;
    else
        LevelRange.Opts[this.option] = false;
    end

    local base = "LevelRangeOptionsFrame";
    for _, child in this.children do
        local other = getglobal(base .. "Opt" .. child);
        if other then
            if LevelRange.Opts[this.option] then
                OptionsFrame_EnableCheckBox(other, 1,
                    LevelRange.Opts[LEVELRANGE_OPTIONS[child].option]);
            else
                OptionsFrame_DisableCheckBox(other);
            end
        end
    end
end

-- Load Settings
function loadSettings()
   if (LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showLevelRange == true) then    
        local optionButton = getglobal("LevelRangeOptionsFrame" .. "Opt1");
        
        optionButton:SetChecked(true);
        LevelRange.Opts["showLevelRange"] = true;

    elseif (LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showLevelRange == false) then
        local optionButton = getglobal("LevelRangeOptionsFrame" .. "Opt1");

        optionButton:SetChecked(false);
        LevelRange.Opts["showLevelRange"] = false;
    end

    if (LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showInstances == true) then
        local optionButton = getglobal("LevelRangeOptionsFrame" .. "Opt2");
        
        optionButton:SetChecked(true);
        LevelRange.Opts["showInstances"] = true;

    elseif (LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showInstances == false) then
        local optionButton = getglobal("LevelRangeOptionsFrame" .. "Opt2");
        
        optionButton:SetChecked(false);
        LevelRange.Opts["showInstances"] = false;
    end

    if (LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showRaids == true) then
        local optionButton = getglobal("LevelRangeOptionsFrame" .. "Opt3");
        
        optionButton:SetChecked(true);
        LevelRange.Opts["showRaids"] = true;

    elseif (LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showRaids == false) then
        local optionButton = getglobal("LevelRangeOptionsFrame" .. "Opt3");

        optionButton:SetChecked(false);
        LevelRange.Opts["showRaids"] = false;
    end

    if (LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showPvP == true) then
        local optionButton = getglobal("LevelRangeOptionsFrame" .. "Opt4");
        
        optionButton:SetChecked(true);
        LevelRange.Opts["showPvP"] = true;

    elseif (LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showPvP == false) then
        local optionButton = getglobal("LevelRangeOptionsFrame" .. "Opt4");

        optionButton:SetChecked(false);
        LevelRange.Opts["showPvP"] = false;
    end
end


--------------------------------------------------------------------------------------------------
-- Initialize Functions
--------------------------------------------------------------------------------------------------

function LevelRange_OnLoad()
    -- Override the world map function
    lLR_OldUpdate = WorldMapButton_OnUpdate;
    WorldMapButton_OnUpdate = LevelRange_WorldMapButton_OnUpdate;
    
    -- Setup slash commands
    SlashCmdList["LEVELRANGE"] = LevelRange_SlashHandler;
    SLASH_LEVELRANGE1 = "/" .. LEVELRANGE_SLASH1;
    SLASH_LEVELRANGE2 = "/" .. LEVELRANGE_SLASH2;

    -- Reload UI Commands
    SlashCmdList["RELOADUI"] = ReloadUI;
    SLASH_RELOADUI1 = "/rui";
    SLASH_RELOADUI2 = "/reloadui";

    -- LevelRange is loaded
    printMSG(LEVELRANGE_LOADEDPREFIX .. LEVELRANGE_VERSION .. LEVELRANGE_LOADEDSUFFIX)
    this:RegisterEvent("ADDON_LOADED");
    this:RegisterEvent("VARIABLES_LOADED");
    this:RegisterEvent("PLAYER_ENTERING_WORLD");
end

function LevelRange_Initialize()
    -- Make sure LevelRangeSettings is ready
    if (not LevelRangeSettings) then
        LevelRangeSettings = { };
    end

    if (not LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME]) then
        LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME] = { };
    end


    -- LevelRange Toggle
    if (LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showLevelRange == nil) then
        LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showLevelRange = DEFAULT_LEVELRANGE_SHOW;
    end

    -- Instances Toggle
    if (LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showInstances == nil) then
        LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showInstances = DEFAULT_LEVELRANGE_SHOWINSTANCE;
    end

    -- Raids Toggle
    if (LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showRaids == nil) then
        LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showRaids = DEFAULT_LEVELRANGE_SHOWRAIDS;
    end

    -- PvP Toggle
    if (LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showPvP == nil) then
        LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME].showPvP = DEFAULT_LEVELRANGE_SHOWPVP;
    end
end

function LevelRange_OnEvent(event)
    if (event == "VARIABLES_LOADED") then			
        LevelRange_Initialize();
    
        -- Register LevelRange with myAddons
        if (myAddOnsFrame_Register) then
            myAddOnsFrame_Register(Details, Help);
        end
    end
end