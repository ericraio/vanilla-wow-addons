--[[
 Clean Minimap
    By joev (joev@jarhedz.com)
  
    This mod provides total control over your minimap including moving it where you want, 
    hiding the Titlebar (and [X] button), the + and - zoom buttons and the Daytime/Clock button on the 
    Minimap and adding the three other compass points.

    Westpointer functionality (Compass coordinates) is from "EastWest" by Silwyn
    
    $Id: CleanMinimap.lua 75 2005-08-30 06:30:20Z joev $
--]]

local CMM_VERSION = "2.7";

local CMM_INFO = CMMSTRINGS.appName.." "..
                 CMM_VERSION.." "..
                 CMMSTRINGS.by.." "..
                 CMMSTRINGS.author.name;

local CMM_DEBUG = 0;

BINDING_HEADER_CLEANMINIMAP               = CMMSTRINGS.bindings.title;
BINDING_NAME_CLEANMINIMAPTOGGLE           = CMMSTRINGS.bindings.toggleOnOff;
BINDING_NAME_CLEANMINIMAPOPTIONS          = CMMSTRINGS.bindings.toggleOptions;
BINDING_NAME_CLEANMINIMAPINCREASEOPACITY  = CMMSTRINGS.bindings.increaseOpacity;
BINDING_NAME_CLEANMINIMAPDECREASEOPACITY  = CMMSTRINGS.bindings.decreaseOpacity;
BINDING_NAME_CLEANMINIMAPTOGGLESIZE       = CMMSTRINGS.bindings.toggleSize;


local DEFAULT_SIZE= 192;

local RED     = "|cffff0000";
local GREEN   = "|cff00ff00";
local BLUE    = "|cff0000ff";
local MAGENTA = "|cffff00ff";
local YELLOW  = "|cffffff00";
local CYAN    = "|cff00ffff";
local WHITE   = "|cffffffff";

-- Print Debug info
local function Print_Debug(s)
   if (CMM_DEBUG == 1) then
      DEFAULT_CHAT_FRAME:AddMessage(s, 1, 1, 0)
   end
end

-- Print to chat
local function Print_Chat(s)
    DEFAULT_CHAT_FRAME:AddMessage(s)
end

function Print_Chat_Table(t)
    for key,value in t do 
        Print_Chat(value) 
    end    
end


-- SavedVariables
CleanMinimapConfig = {};
CleanMinimapConfig.perCharSettings=true;

-- Global for unitname
CleanMinimap_player = nil;


-- Set up namespace.
local CleanMinimap = {};

CleanMinimap.player = nil;
CleanMinimap.variablesLoaded = false;
CleanMinimap.configLoaded = false;
CleanMinimap.reset = false;
CleanMinimap.sizing = false;
CleanMinimap.state = 2;
CleanMinimap.iconsPosition = {};
CleanMinimap.iconsPosition["MinimapZoomIn"] = 209;
CleanMinimap.iconsPosition["MinimapZoomOut"] = 235;
CleanMinimap.iconsPosition["MiniMapMailFrame"] = 168;
CleanMinimap.iconsPosition["MiniMapTrackingFrame"] = 37;
CleanMinimap.iconsPosition["MiniMapBattlefieldFrame"] = 302;
CleanMinimap.iconsPosition["MiniMapMeetingStoneFrame"] = 189;

local CleanMinimap_OriginalOnClick;

-- Show slash command usage
function CleanMinimap.ShowUsage()
    Print_Chat(CMM_INFO);
    Print_Chat_Table(CMMSTRINGS.usage);
end

function CleanMinimap.ShowAuthor()
    Print_Chat(CMMSTRINGS.appName.." v"..CMM_VERSION.." - "..CMMSTRINGS.authorInfo);
    Print_Chat(CMMSTRINGS.author.name.." ("..CMMSTRINGS.author.email..")");
    Print_Chat(CMMSTRINGS.playsAs);
    Print_Chat_Table(CMMSTRINGS.author.aliases);
end

function CleanMinimap.ShowCredits()
    Print_Chat(CMMSTRINGS.appName.." v"..CMM_VERSION.." - "..CMMSTRINGS.creditsInfo.."\n\n");
    
    for key,value in CMMSTRINGS.credits do
        Print_Chat(CYAN..value.task);
        if (value.alias == "") then
            Print_Chat(YELLOW..value.name.."\n\n");
        else
            Print_Chat(YELLOW..value.name..CMMSTRINGS.aka..value.alias.."\n\n");
        end
    end
end


-- Setup config information
function CleanMinimap.ConfigInit()
    if (not CleanMinimap.configLoaded) then
      if (not CleanMinimapConfig[CleanMinimap.player]) then
          CleanMinimapConfig[CleanMinimap.player] = {};
          CleanMinimapConfig[CleanMinimap.player].on = true;
          CleanMinimapConfig[CleanMinimap.player].alpha = 1.0;
          CleanMinimapConfig[CleanMinimap.player].left = nil;
          CleanMinimapConfig[CleanMinimap.player].bottom = nil;
          CleanMinimapConfig[CleanMinimap.player].scale = nil;
          CleanMinimapConfig[CleanMinimap.player].origtop = nil;
          CleanMinimapConfig[CleanMinimap.player].origright = nil;
          CleanMinimapConfig[CleanMinimap.player].origleft = nil;
          CleanMinimapConfig[CleanMinimap.player].origbottom = nil;
          CleanMinimapConfig[CleanMinimap.player].origscale = nil;
          CleanMinimapConfig[CleanMinimap.player].clock = false;
          CleanMinimapConfig[CleanMinimap.player].title = false;
          CleanMinimapConfig[CleanMinimap.player].zoom = false;
          CleanMinimapConfig[CleanMinimap.player].nsew = false;
          CleanMinimapConfig[CleanMinimap.player].showButton = true;
          CleanMinimapConfig[CleanMinimap.player].buttonPos = 90;
          CleanMinimapConfig[CleanMinimap.player].smallScale = 0.50;
          CleanMinimapConfig[CleanMinimap.player].largeScale = 2.0;
          CleanMinimapConfig[CleanMinimap.player].modifierKey = "SHIFT";            
          CleanMinimapConfig[CleanMinimap.player].iconsPosition = {};
          CleanMinimapConfig[CleanMinimap.player].iconsPosition["MinimapZoomIn"] = CleanMinimap.iconsPosition["MinimapZoomIn"];
          CleanMinimapConfig[CleanMinimap.player].iconsPosition["MinimapZoomOut"] = CleanMinimap.iconsPosition["MinimapZoomOut"];
          CleanMinimapConfig[CleanMinimap.player].iconsPosition["MiniMapMailFrame"] = CleanMinimap.iconsPosition["MiniMapMailFrame"];
          CleanMinimapConfig[CleanMinimap.player].iconsPosition["MiniMapTrackingFrame"] = CleanMinimap.iconsPosition["MiniMapTrackingFrame"];
          CleanMinimapConfig[CleanMinimap.player].iconsPosition["MiniMapBattlefieldFrame"] = CleanMinimap.iconsPosition["MiniMapBattlefieldFrame"];
          CleanMinimapConfig[CleanMinimap.player].iconsPosition["MiniMapMeetingStoneFrame"] = CleanMinimap.iconsPosition["MiniMapMeetingStoneFrame"];
          CleanMinimapConfig[CleanMinimap.player].version = tonumber(CMM_VERSION);
      else
        if (not CleanMinimapConfig[CleanMinimap.player].version) then
          CleanMinimapConfig[CleanMinimap.player].version = 1;
        end
        if (CleanMinimapConfig[CleanMinimap.player].version < tonumber(CMM_VERSION)) then
            -- From here on, we only need to add new things per version here.
            CleanMinimapConfig[CleanMinimap.player].version = tonumber(CMM_VERSION);
        end
      end
      CleanMinimap.configLoaded = true;
      Print_Debug("Finished Config Loading");

      CleanMinimap.SetOn(CleanMinimapConfig[CleanMinimap.player].on);
    end
end

function CleanMinimap.Setup()    
    if (CleanMinimap.player ~= nil and CleanMinimap.IsOn() and not CleanMinimap.reset) then
        Print_Debug("Setting CMM start position");
        CleanMinimap.SetClock(CleanMinimapConfig[CleanMinimap.player].clock,CleanMinimapConfig[CleanMinimap.player].alpha);
        CleanMinimap.SetTitle(CleanMinimapConfig[CleanMinimap.player].title,CleanMinimapConfig[CleanMinimap.player].alpha);
        CleanMinimap.SetZoom(CleanMinimapConfig[CleanMinimap.player].zoom);
        CleanMinimap.SetNsew(CleanMinimapConfig[CleanMinimap.player].nsew);
        CleanMinimap.SetPosition(CleanMinimapConfig[CleanMinimap.player].top,CleanMinimapConfig[CleanMinimap.player].right);
        CleanMinimap.SetMapScale(CleanMinimapConfig[CleanMinimap.player].scale);
        if (CleanMinimapConfig[CleanMinimap.player].showButton) then
            CleanMinimapButton_UpdatePosition();
        else
            CleanMinimapButtonFrame:Hide();
        end
        CleanMinimap.InitIconPositions(true);
    else
        Print_Debug("Setting CMM default position");
        CleanMinimap.SetClock(true,1.0);
        CleanMinimap.SetTitle(true,1.0);
        CleanMinimap.SetZoom(true);
        CleanMinimap.SetNsew(false);
        CleanMinimap.SetPosition(CleanMinimapConfig[CleanMinimap.player].origtop,CleanMinimapConfig[CleanMinimap.player].origright);
        CleanMinimap.SetMapScale(CleanMinimapConfig[CleanMinimap.player].origscale);
        CleanMinimap.InitIconPositions(false);
    end
end

function CleanMinimap.InitIconPositions(manage)
  if (manage) then
    CleanMinimap.UpdateIconPosition("MinimapZoomIn",CleanMinimapConfig[CleanMinimap.player].iconsPosition["MinimapZoomIn"]); 
    CleanMinimap.UpdateIconPosition("MinimapZoomOut",CleanMinimapConfig[CleanMinimap.player].iconsPosition["MinimapZoomOut"]); 
    CleanMinimap.UpdateIconPosition("MiniMapMailFrame",CleanMinimapConfig[CleanMinimap.player].iconsPosition["MiniMapMailFrame"]); 
    CleanMinimap.UpdateIconPosition("MiniMapTrackingFrame",CleanMinimapConfig[CleanMinimap.player].iconsPosition["MiniMapTrackingFrame"]); 
    CleanMinimap.UpdateIconPosition("MiniMapBattlefieldFrame",CleanMinimapConfig[CleanMinimap.player].iconsPosition["MiniMapBattlefieldFrame"]); 
    CleanMinimap.UpdateIconPosition("MiniMapMeetingStoneFrame",CleanMinimapConfig[CleanMinimap.player].iconsPosition["MiniMapMeetingStoneFrame"]); 
  else
    CleanMinimap.UpdateIconPosition("MinimapZoomIn",CleanMinimap.iconsPosition["MinimapZoomIn"]); 
    CleanMinimap.UpdateIconPosition("MinimapZoomOut",CleanMinimap.iconsPosition["MinimapZoomOut"]); 
    CleanMinimap.UpdateIconPosition("MiniMapMailFrame",CleanMinimap.iconsPosition["MiniMapMailFrame"]); 
    CleanMinimap.UpdateIconPosition("MiniMapTrackingFrame",CleanMinimap.iconsPosition["MiniMapTrackingFrame"]); 
    CleanMinimap.UpdateIconPosition("MiniMapBattlefieldFrame",CleanMinimap.iconsPosition["MiniMapBattlefieldFrame"]); 
    CleanMinimap.UpdateIconPosition("MiniMapMeetingStoneFrame",CleanMinimap.iconsPosition["MiniMapMeetingStoneFrame"]); 
  end
end


function CleanMinimap.UpdateIconPosition(frameName, position)
      getglobal(frameName):ClearAllPoints();
      getglobal(frameName):SetPoint(
          "TOPLEFT",
          "Minimap",
          "TOPLEFT",
          52 - (80 * cos(position)),
          (80 * sin(position)) - 52
         );
end

function CleanMinimap.doZoomIn()
    if (Minimap:GetZoom() == 5) then
        Minimap:SetZoom(5);
    else
        Minimap:SetZoom(Minimap:GetZoom() + 1);
    end
end

function CleanMinimap.doZoomOut()
    if (Minimap:GetZoom() == 0) then
        Minimap:SetZoom(0);
    else
        Minimap:SetZoom(Minimap:GetZoom() - 1);
    end
end

function CleanMinimap.doZoomAlphaIn()
    CleanMinimap.SetAlpha((CleanMinimapConfig[CleanMinimap.player].alpha*100) - 5);
end

function CleanMinimap.doZoomAlphaOut()
    CleanMinimap.SetAlpha((CleanMinimapConfig[CleanMinimap.player].alpha*100) + 5);
end

function CleanMinimap.IsOn()
    if (CleanMinimap.reset) then
        return true;  -- Always return true on a reset.
    elseif (MinimapCluster:IsVisible()) then
      if (CleanMinimap.player) then
        return CleanMinimapConfig[CleanMinimap.player].on;
      else
        return false;
      end
    else
        return false;
    end
end

function CleanMinimap.SetOn(val)
    CleanMinimapConfig[CleanMinimap.player].on = val;
    if (not val) then
        CleanMinimap.reset = true;
    end;
    CleanMinimap.Setup();
    CleanMinimap.reset = false;       
end

function CleanMinimap.SetPosition(top,right)
    if (CleanMinimap.IsOn()) then
        if (not CleanMinimap.reset) then
            CleanMinimapConfig[CleanMinimap.player].top = top;   
            CleanMinimapConfig[CleanMinimap.player].right= right;
        end
        if (top ~= nil and right ~= nil) then  
          Print_Debug("Setting top="..CleanMinimapConfig[CleanMinimap.player].top..",right="..CleanMinimapConfig[CleanMinimap.player].right);
          MinimapCluster:ClearAllPoints();
          MinimapCluster:SetPoint("TOPRIGHT", "UIParent", "TOPRIGHT",right,top);
        end
    end
end

function CleanMinimap.SetMapScale(scale)
    if (CleanMinimap.IsOn()) then
        if (not CleanMinimap.reset) then
            CleanMinimapConfig[CleanMinimap.player].scale = scale;   
        end
        
        if (scale ~= nil) then  
          Print_Debug("Setting scale to: "..scale);
          MinimapCluster:SetScale(scale);
        end
    end
end

function CleanMinimap.SetScale(scale)
    -- sets the scale without saving it
    if (CleanMinimap.IsOn()) then        
        if (scale ~= nil) then  
          Print_Debug("Setting scale to: "..scale);
          MinimapCluster:SetScale(scale*CleanMinimapConfig[CleanMinimap.player].scale);
          Minimap:SetScale(scale*CleanMinimapConfig[CleanMinimap.player].scale);
        end
    end
end

function CleanMinimap.SetClock(val,alpha)
    if (CleanMinimap.IsOn()) then
        if (alpha == nil) then
            alpha = CleanMinimapConfig[CleanMinimap.player].alpha;
        end
        if (not CleanMinimap.reset) then
            CleanMinimapConfig[CleanMinimap.player].clock = val;
        end;
        if (val) then
            GameTimeFrame:Show();
            -- This needs alpha to be set because it's anchored to the cluster, not the minimap itself.
            GameTimeFrame:SetAlpha(alpha);
        else
            GameTimeFrame:Hide();
        end            
    end
end

function CleanMinimap.ToggleClock()
    if (CleanMinimapConfig[CleanMinimap.player].clock) then
        CleanMinimap.SetClock(false,nil);
    else
        CleanMinimap.SetClock(true,nil);
    end
    
end

function CleanMinimap.SetTitle(val,alpha)
    if (CleanMinimap.IsOn()) then
        if (alpha == nil) then
            alpha = CleanMinimapConfig[CleanMinimap.player].alpha;
        end
        if (not CleanMinimap.reset) then
            CleanMinimapConfig[CleanMinimap.player].title = val;
        end
        if (val) then
            MinimapCluster:SetAlpha(alpha);
            MinimapToggleButton:Enable();
            MinimapZoneTextButton:Enable();
            GameTimeFrame:SetAlpha(alpha);
            Minimap:SetAlpha(alpha);
      else
            MinimapCluster:SetAlpha(0.0);
            MinimapToggleButton:Disable();
            MinimapZoneTextButton:Disable();
            GameTimeFrame:SetAlpha(alpha);
            Minimap:SetAlpha(alpha);
        end            
    end
end

function CleanMinimap.ToggleTitle()
    if (CleanMinimapConfig[CleanMinimap.player].title) then
        CleanMinimap.SetTitle(false,nil);
    else
        CleanMinimap.SetTitle(true,nil);
    end
end

function CleanMinimap.SetZoom(val)
    if (CleanMinimap.IsOn()) then
        if (not CleanMinimap.reset) then
            CleanMinimapConfig[CleanMinimap.player].zoom = val;
        end
        if (val) then
            MinimapZoomIn:Show();
            MinimapZoomOut:Show();
        else
            MinimapZoomIn:Hide();
            MinimapZoomOut:Hide();
        end            
    end
end

function CleanMinimap.ToggleZoom()
    if (CleanMinimapConfig[CleanMinimap.player].zoom) then
        CleanMinimap.SetZoom(false);
    else
        CleanMinimap.SetZoom(true);
    end
end

function CleanMinimap.SetNsew(val)
    if (CleanMinimap.IsOn()) then
        if (not CleanMinimap.reset) then
            CleanMinimapConfig[CleanMinimap.player].nsew = val
        end
        if (val) then
            WestPointer:Show();
        else
            WestPointer:Hide();
        end
    end
end

function CleanMinimap.ToggleNsew()
    if (CleanMinimapConfig[CleanMinimap.player].nsew) then
        CleanMinimap.SetNsew(false);    
    else
        CleanMinimap.SetNsew(true);
    end
end

function CleanMinimap.SetAlpha(val, silent)
    if (CleanMinimap.IsOn()) then
        if (val ~= nil) then
            if (val < 1) then 
                val = 1;
            end
            if (val > 100) then
                val = 100;
            end
            CleanMinimapConfig[CleanMinimap.player].alpha = val/100;
            Minimap:SetAlpha(val/100);
            --CleanMinimap.Setup();
        end
    end    
end

function CleanMinimap.SetLargeSize(val, silent)
    if (CleanMinimap.IsOn()) then
        if (val ~= nil) then
            if (val < 100) then 
                val = 100;
            end
            if (val > 300) then
                val = 300;
            end
            CleanMinimapConfig[CleanMinimap.player].largeScale = val/100;
        end
    end    
end

function CleanMinimap.SetSmallSize(val, silent)
    if (CleanMinimap.IsOn()) then
        if (val ~= nil) then
            if (val < 50) then 
                val = 50;
            end
            if (val > 100) then
                val = 100;
            end
            CleanMinimapConfig[CleanMinimap.player].smallScale = val/100;
        end
    end    
end

function CleanMinimap.ResetAll()
  Print_Debug("Resetting");
  Print_Debug(CleanMinimap.player);
  Print_Debug(CleanMinimapConfig[CleanMinimap.player].origscale);
  CleanMinimap.SetMapScale(CleanMinimapConfig[CleanMinimap.player].origscale);
  CleanMinimap.SetPosition(CleanMinimapConfig[CleanMinimap.player].origtop, CleanMinimapConfig[CleanMinimap.player].origright);
end

function CleanMinimap.ModifierKeyIsDown()
  local retval = false;
  if ((IsShiftKeyDown() and CleanMinimapConfig[CleanMinimap.player].modifierKey == "SHIFT") or 
      (IsControlKeyDown() and CleanMinimapConfig[CleanMinimap.player].modifierKey == "CTRL") or
      (IsAltKeyDown() and CleanMinimapConfig[CleanMinimap.player].modifierKey == "ALT")) then
    retval = true;
  end
  return retval;
end

--[[ Event handlers
  These functions are global and are called by the UI
--]]

function CleanMinimap_OnLoad()

    this:RegisterEvent("VARIABLES_LOADED");
    this:RegisterEvent("PLAYER_ENTERING_WORLD");

    -- Slash Commands
    SlashCmdList["CMM"] = CleanMinimap_Slash;
    SLASH_CMM1 = "/cleanminimap";
    SLASH_CMM2 = "/cmm";

end


function CleanMinimap_OnEvent()
    if (event == "VARIABLES_LOADED") then
        -- Hook the Minimap_OnClick function
        CleanMinimap_OriginalOnClick = Minimap_OnClick;
        Minimap_OnClick = CleanMinimap_OnClick;

        -- Init Config        
        CleanMinimap.variablesLoaded = true;
        Print_Debug("Variables Loaded");
        if (CleanMinimap.player) then
            CleanMinimap.ConfigInit();
        end
        -- Add myAddOns support
        if myAddOnsList then
            myAddOnsList.CleanMinimap = {name = "Clean Minimap", description = CMMSTRINGS.myAddonsDescription, version = CMM_VERSION, category = MYADDONS_CATEGORY_MAP, frame = "CleanMinimap", optionsframe = "CleanMinimapOptionsFrame"};
        end
        if ButtonHole then
            ButtonHole.application.RegisterMod({id="CLEANMINIMAP", name="Clean Minimap", tooltip=CMMSTRINGS.myAddonsDescription, buttonFrame="CleanMinimapButtonFrame", updateFunction="CleanMinimapButton_UpdatePosition"});
        end
     elseif( event == "PLAYER_ENTERING_WORLD" and not CleanMinimap.player) then
        local name = UnitName("player");
        if (CleanMinimapConfig.perCharSettings == nil) then
          CleanMinimapConfig.perCharSettings = false;
        end
        if (CleanMinimapConfig.perCharSettings) then        
          Print_Debug("Setting name to default");
          name = "default";
        end
        if( name and name ~= UNKNOWNOBJECT ) then
          CleanMinimap.player = name;
          CleanMinimap_player = name;
          Print_Debug("Unit Name: player = "..CleanMinimap.player);
          if (CleanMinimap.variablesLoaded) then
            CleanMinimap.ConfigInit();
          end
        end
     end        
end

function CleanMinimap_OnMouseWheel(value)
    if (CleanMinimap.IsOn()) then
        if (IsShiftKeyDown()) then
            if ( value > 0 ) then CleanMinimap.doZoomAlphaIn()
            elseif ( value < 0 ) then CleanMinimap.doZoomAlphaOut()
            end
        else
            if ( value > 0 ) then CleanMinimap.doZoomIn()
            elseif ( value < 0 ) then CleanMinimap.doZoomOut()
            end
        end
    end
end

function CleanMinimap_StartMoving()
    if (CleanMinimap.IsOn()) then
      if (CleanMinimapConfig[CleanMinimap.player].origright == nil) then
        -- This is the first move therefore record where we started from.
        local right = MinimapCluster:GetRight() - UIParent:GetRight();
        local top = MinimapCluster:GetTop() - UIParent:GetTop();
        if (right > 0 ) then
          right = 0;
        end
        if (top > 0 ) then
          top = 0;
        end
        
        CleanMinimapConfig[CleanMinimap.player].origright = right;
        
        CleanMinimapConfig[CleanMinimap.player].origtop = top;
        CleanMinimapConfig[CleanMinimap.player].origscale = MinimapCluster:GetScale();        

      end
      MinimapCluster:SetMovable(true);
      MinimapCluster:SetResizable(true);
      CleanMinimapMover_Attach(CleanMinimapMoverFrame,MinimapCluster);
    end
end

function CleanMinimap_StopMoving()
    if (CleanMinimap.IsOn()) then
        MinimapCluster:SetMovable(false);
        MinimapCluster:SetResizable(false);
        local right = MinimapCluster:GetRight() - UIParent:GetRight();
        local top = MinimapCluster:GetTop() - UIParent:GetTop();
        Print_Debug("top ="..top..", right="..right);
        if (right > 0 ) then
          right = 0;
        end
        if (top > 0 ) then
          top = 0;
        end
        
        CleanMinimap.SetPosition(top,right);
        CleanMinimap.SetMapScale(MinimapCluster:GetScale());        
    end
end

function CleanMinimap_OnClick(button)
    if (CleanMinimap.ModifierKeyIsDown()) then
       CleanMinimap_StartMoving();
    else
       CleanMinimap_OriginalOnClick(button);
    end
end
----------------------------------------------------------------------------------------------------------------------------------
--[[ External functions
  These functions are global and can be called by other mods
--]]

function CleanMinimap_GetAlpha()
    if (CleanMinimap.IsOn()) then
        return CleanMinimapConfig[CleanMinimap.player].alpha;
    else
        return MinimapCluster:GetAlpha();
    end
end

function CleanMinimap_GetClock()
    if (CleanMinimap.IsOn()) then
        return CleanMinimapConfig[CleanMinimap.player].clock;
    else
        return GameTimeFrame:IsVisible();
    end
end

function CleanMinimap_GetZoom()
    if (CleanMinimap.IsOn()) then
        return CleanMinimapConfig[CleanMinimap.player].zoom;
    else
        return MinimapZoomIn:IsVisible();
    end
end

function CleanMinimap_GetTitle()
    if (CleanMinimap.IsOn()) then
        return CleanMinimapConfig[CleanMinimap.player].title;
    else
        return MinimapCluster:IsVisible();
    end
end

function CleanMinimap_GetNsew()
    if (CleanMinimap.IsOn()) then
        return CleanMinimapConfig[CleanMinimap.player].nsew;
    else
        return WestPointer:IsVisible();
    end
end

function CleanMinimap_IsOn()
    return CleanMinimap.IsOn();
end

function CleanMinimap_Toggle()
  if (CleanMinimap.IsOn()) then
    CleanMinimap.SetOn(false);
  else
    CleanMinimap.SetOn(true);
  end
end

function CleanMinimap_ToggleClock()
  CleanMinimap.ToggleClock();
end

function CleanMinimap_ToggleZoom()
  CleanMinimap.ToggleZoom();
end
function CleanMinimap_ToggleNsew()
  CleanMinimap.ToggleNsew();
end
function CleanMinimap_ToggleTitle()
  CleanMinimap.ToggleTitle();
end

-- Handle slash commands
function CleanMinimap_Slash(msg)
    if msg == nil or msg == "" then
        msg = "help";
    end
    msg = strlower(msg);
    local args = {n=0}
    local function helper(word) table.insert(args, word) end
    string.gsub(msg, "[_\.%w]+", helper);
    if args[1] == 'on'  then
        CleanMinimap.SetOn(true);
    elseif args[1] == 'off' then
        CleanMinimap.SetOn(false);
    elseif args[1] == 'reset' then
        CleanMinimap.ResetAll();
    elseif args[1] == 'author' then
        CleanMinimap.ShowAuthor();
    elseif args[1] == 'credits' then
        CleanMinimap.ShowCredits();
    elseif args[1] == 'config' then
        CleanMinimapOptions_Toggle();
    else
        CleanMinimap.ShowUsage();
    end
end

function CleanMinimap_IncreaseOpacity()
  CleanMinimap.SetAlpha(CleanMinimapConfig[CleanMinimap.player].alpha*100 + 10)
end

function CleanMinimap_DecreaseOpacity()
  CleanMinimap.SetAlpha(CleanMinimapConfig[CleanMinimap.player].alpha*100 - 10)
end

function CleanMinimap_SilentSetAlpha(val)
  if (val ~= nil) then
    CleanMinimap.SetAlpha(val,true);
  end
end
function CleanMinimap_SilentSetLargeSize(val)
  if (val ~= nil) then
    CleanMinimap.SetLargeSize(val,true);
  end
end
function CleanMinimap_SilentSetSmallSize(val)
  if (val ~= nil) then
    CleanMinimap.SetSmallSize(val,true);
  end
end

function CleanMinimap_ToggleSize()

  CleanMinimap.state = CleanMinimap.state + 1;
  if (CleanMinimap.state > 3) then
    CleanMinimap.state = 1;
  end
  Print_Debug("Map state = "..CleanMinimap.state);
  
  if (CleanMinimap.state == 1) then
    CleanMinimap.SetScale(CleanMinimapConfig[CleanMinimap.player].smallScale);
  elseif (CleanMinimap.state == 3) then
    CleanMinimap.SetScale(CleanMinimapConfig[CleanMinimap.player].largeScale);
  else
    Print_Debug("Map state set to default");
    CleanMinimap.SetScale(1);
  end
  -- reset position
  CleanMinimap.SetPosition(CleanMinimapConfig[CleanMinimap.player].top,CleanMinimapConfig[CleanMinimap.player].right);
end

function CleanMinimap_SetModifier(keyname)
  CleanMinimapConfig[CleanMinimap.player].modifierKey = keyname;
end

function CleanMinimap_SetOneConfig(toggle)
  if (toggle) then
    CleanMinimapConfig.perCharSettings = true;
    CleanMinimap.player = "default";
    CleanMinimap_player = "default";
  else
    CleanMinimapConfig.perCharSettings = false;
    CleanMinimap.player = UnitName("player");
    CleanMinimap_player = UnitName("player");
  end
  CleanMinimap.configLoaded = false;
  CleanMinimap.ConfigInit();
  if (CleanMinimapOptionsFrame:IsVisible()) then
    CleanMinimapOptions_Refresh();
  end
  if (CleanMinimapButtonFrame:IsVisible()) then 
    CleanMinimapButton_UpdatePosition();
  end
end

function CleanMinimap_SetIconPosition(frameName, position)
  CleanMinimapConfig[CleanMinimap.player].iconsPosition[frameName] = position;
  CleanMinimap.UpdateIconPosition(frameName, position);
end
