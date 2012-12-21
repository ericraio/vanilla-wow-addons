-- Kwraz's Flightpath Tracker Addon
--
-- Displays known flightpaths on the world map, etc.
--
-- All contents property of Kwraz of Icecrown. You are hereby given permission
-- to make changes to this addon provided proper credit is given if you
-- disseminate your changes publicly.
--
-- Comments and questions can be addressed to kwraz@kjware.net (or via in game
-- mail to Kwraz if you play Horde on Icecrown)
--

local VERSION = "1.16";

--  Date    Rev   Comments
-- ------   ----  -----------------------------------
-- 06/22/06 1.16  Updated for UI version 1.11
--
-- 10/12/05 1.15  Fixed error that occurred in 1.8 when reporting bound key
--                Updated TOC to 1.8
--
-- 9/13/05  1.14  Fixed WorldMapButton error in 1.7. UI version set to 1.7
--
-- 6/27/05  1.13  OnPlayerEnteringWorld logic only done once
--                Flight timer now takes UI delays into account
--                On screen destination width increased
--
-- 4/18/05  1.12  Removed debug statement causing user errors
--
-- 4/18/05  1.11  Fixed bug with /fp load introduced in 1.10
--
-- 4/18/05  1.10  SetMapToCurrentZone fixup
--                Bound key now toggles dialog on/off
--                Alt-z to hide UI now also hides time remaining counter
--                Cleaned up appearance of zone map connection tooltip
--                Changed regular expressions to correction handle foreign characters
--                Version number displayed on the dialog
--                Other faction's paths were showing on Booty Bay flightmaster. Fixed.
--                Changing zones with the dialog up caused the drop down to display
--                zones instead of locations. Fixed.
--
-- 4/14/05  1.09  Fixed incompatibility with VisibleFlightMap
--                Zone map icons changed to the same as the flight master's map
--                Undiscovered flight path locations show as grey on zone map
--                Dialog drop down box scaled down to fit within dialog
--
-- 4/13/05  1.08  Added bindings.xml to support hotkey assignment via wow menu
--                Flight master icons will no longer display on the zone map if greyed
--                Added flight times and costs to zone map tooltips
--                Added hideremaining and showremaining commands
--                Fixed problem with incorrect locations being stored for flight masters (hopefully)
--
-- 4/12/05  1.07  Cleaned up shared variable names to respect conventions. Added confirmation
--                dialog to /fp erase. Added MyAddons support. Flight time now shown when talking
--                to flight master. Flight time remaining countdown timer added. Flight duration
--                tracked separately for each direction. Added /fp load command. Fixed drop down
--                problem when more than 32 locations.
--
-- 4/8/05   1.06  Added /fp erase, /fp showgrey, /fp hidegray. Additional changes
--                made to location matching logic to try and avoid duplicate path
--                creation for Stormwind, Ironforge, and Moonglade.
--
-- 4/7/05   1.05  Fixed string error the first time FlightPath is installed.
--
-- 4/7/05   1.04  Whether or not to gray out a connection is now tracked by character,
--                since different characters will have different routes available to them.
--                Escape key now closes dialog.
--
-- 4/7/05   1.03  Greyed out unavailable routes in map tooltip as well.
--
-- 4/7/05   1.02  Preloaded flights you cannot take are now coded in a different color.
--
-- 4/6/05   1.01  Fixed a problem with the drop down list running off screen with a large number
--                of entries
-- 4/6/05   1.0   Initial release
--
---------------------------------------------------------------------

-- Info to show on the WoW Key Bindings menu

BINDING_HEADER_FPHEADER = "Kwraz's Flightpath Tracker";
BINDING_NAME_FPDIALOG = "Query dialog";

-- Constants

local STATUS_COLOR                  = "|c0033CCFF";
local CONNECTION_COLOR              = "|c0033FF66";
local MONEY_COLOR                   = "|c00FFCC33";
local DEBUG_COLOR                   = "|c0000FF00";
local GREY                          = "|c00909090";
local BRIGHTGREY                    = "|c00D0D0D0";
local WHITE                         = "|c00FFFFFF";
local MAX_CONNECTIONS               = 16;
local MAX_POI_BUTTONS               = 48;
local CONNECTION_START_ID           = 1101;
local FP_LEARNED_FROM_FLIGHTMASTER  = 1;
local FP_LEARNED_FROM_PRELOAD       = 2;
local NOCOORDS                      = "0,0";
local MAXDROPDOWN                   = 21;
local MORECOLOR                     = "|c00FF9900";
local MOREUP                        = MORECOLOR.."--- More ^ ---";
local MOREDOWN                      = MORECOLOR.."--- More v ---";

-- Shared variables

local StartRecording          = false;
local Recording               = false;
local TaxiOrigin              = "";
local TaxiDestination         = "";
local TaxiDirection           = 0;
local CurrentFlight           = {};
local StartTime;
local Connections             = {};
local LastTime                = time();
local PopulatePass            = 0;
local TaximapOpen             = false;
local TimeRemaining           = 0;
local DropDownStartIndex      = 1;

-- Hooked functions

local Original_WorldMapButton_OnUpdate;
local Original_TaxiNodeOnButtonEnter;
local Original_TakeTaxiNode;

---------------------------------------------------------------------

function FP_Help()
   FPCHAT(" ");
   FPCHAT(BINDING_HEADER_FPHEADER.." commands:");
   FPCHAT("/fp"                              ..FPSPACE(50)..WHITE.." - Displays the FlightPath dialog");
   FPCHAT("/fp enable | disable"             ..FPSPACE(24)..WHITE.." - Enables or disables the FlightPath addon");
   FPCHAT("/fp showgrey | hidegrey"          ..FPSPACE(17)..WHITE.." - Show greyed out flight paths or not");
   FPCHAT("/fp showremaining | hideremaining"..FPSPACE(0) ..WHITE.." - Show or hide in flight time remaining");
   FPCHAT("/fp erase"                        ..FPSPACE(40)..WHITE.." - Erases all remembered flight paths");
   FPCHAT("/fp load misc | horde | alliance" ..FPSPACE(7) ..WHITE.." - Load a supplied flight path list");
   FPCHAT("/fp status"                       ..FPSPACE(40)..WHITE.." - Displays various flight path statistics");
   FPCHAT(" ");
end

---------------------------------------------------------------------

-- Handle command line arguments

function FP_SlashHandler(msg)

   local _,_,command,options = string.find(msg,"([%w%p]+)%s*(.*)$");

   if       (command == nil)                             then  FP_FlightPathDialog();
   elseif   (string.lower(command) == 'enable')          then  FP_Enable();
   elseif   (string.lower(command) == 'disable')         then  FP_Disable();
   elseif   (string.lower(command) == 'status')          then  FP_Status();
   elseif   (string.lower(command) == 'erase')           then  FP_Erase();
   elseif   (string.lower(command) == 'showgrey')        then  FP_SetShowGrey();
   elseif   (string.lower(command) == 'hidegrey')        then  FP_SetHideGrey();
   elseif   (string.lower(command) == 'showremaining')   then  FP_SetShowRemaining();
   elseif   (string.lower(command) == 'hideremaining')   then  FP_SetHideRemaining();
   elseif   (string.lower(command) == 'load')            then  FP_Load(options);
   elseif   (string.lower(command) == 'check')           then  FP_Check();       -- Undocumented: Validate current flight master
   elseif   (string.lower(command) == 'debug')           then  FP_Debug();       -- Undocumented: Enable debug output
   elseif   (string.lower(command) == 'test')            then  FP_Test(options); -- Undocumented: Invoke testbed
   else                                                        FP_Help();
   end

end

---------------------------------------------------------------------

-- Tell WoW what events we are interested in being notified of

function FP_EventFrame_OnLoad(frameName)

   -- Register for any event we want to be notified of

   this:RegisterEvent("VARIABLES_LOADED");
   this:RegisterEvent("PLAYER_ENTERING_WORLD");
   this:RegisterEvent("TAXIMAP_OPENED");
   this:RegisterEvent("TAXIMAP_CLOSED");
   this:RegisterEvent("WORLD_MAP_UPDATE");

end

---------------------------------------------------------------------

-- Map events to the appropriate internal handler

function FP_EventFrame_OnEvent()

   if       (event == "VARIABLES_LOADED")       then FP_VariablesLoaded();
   elseif   (event == "PLAYER_ENTERING_WORLD")  then FP_PlayerEnteringWorld();
   elseif   (event == "TAXIMAP_OPENED")         then FP_TaxiMapOpened();
   elseif   (event == "TAXIMAP_CLOSED")         then FP_TaxiMapClosed();
   elseif   (event == "WORLD_MAP_UPDATE")       then FP_WorldMapUpdate();

   else FPDEBUG("Unhandled Event "..WHITE..event); end;
end

---------------------------------------------------------------------

function FP_VariablesLoaded()

   -- Update the global WoW command handler table so it knows about us

   SlashCmdList["FLIGHTPATH"] = FP_SlashHandler;
   SLASH_FLIGHTPATH1 = "/flightpath";
   SLASH_FLIGHTPATH2 = "/fp";

   if (FlightPath_Config == nil) then FP_InitializeConfig(); end

   -- Let them know we're up and running

   FPCHAT(BINDING_HEADER_FPHEADER.." version "..VERSION.." loaded. Type "..WHITE.."/fp ?"..STATUS_COLOR.." for more info.");
   local sbool = "disabled.";
   if(FlightPath_Config.Enabled) then sbool = "enabled."; end;
   FPCHAT("Flightpath hooks are "..sbool);

   -- MyAddons support

   if(myAddOnsFrame) then
      myAddOnsList.FlightPath = { name = "FlightPath", description = BINDING_HEADER_FPHEADER, version = VERSION, category = MYADDONS_CATEGORY_MAP, frame = "FP_UIFrame"};
   end

end

---------------------------------------------------------------------

function FP_InitializeConfig()
   FlightPath_Config = {};
   FlightPath_Config.Version = VERSION;
   FlightPath_Config.Enabled = true;
   FlightPath_Config.HideRemaining = false;
   FlightPath_Config.FlightPaths = {};
end

---------------------------------------------------------------------

function FP_PlayerEnteringWorld()
   FP_DoVersionFixups(); -- Perform any version specific fixups on the users database
   FlightPath_Config.Version = VERSION;
   FP_EnableHooks();
   FP_ReportBindingKey();
   this:UnregisterEvent("PLAYER_ENTERING_WORLD"); -- So boat/zep zoning doesn't call this again
end

---------------------------------------------------------------------

function FP_Enable()
   FlightPath_Config.Enabled = true;
   FP_EnableHooks();
   FPCHAT("FlightPath hooks have been enabled.");
end

---------------------------------------------------------------------

function FP_Disable()
   FlightPath_Config.Enabled = false;
   Recording = false; -- Just in case we are in flight
   FP_DisableHooks();
   FPCHAT("FlightPath hooks have been disabled.");
end

---------------------------------------------------------------------

function FP_SetShowRemaining()
   FlightPath_Config.HideRemaining = false;
   FPCHAT("The in flight time remaining display has been enabled.");
end

---------------------------------------------------------------------

function FP_SetHideRemaining()
   FlightPath_Config.HideRemaining = true;
   FPCHAT("The in flight time remaining display has been disabled.");
end

---------------------------------------------------------------------

-- User typed /fp erase. Clear out the old database and start from scratch.
-- But first make sure they really really want to

function FP_Erase()
   StaticPopupDialogs["FP_CONFIRM_ERASE"] = {
      text = "\nThis will erase ALL of your recorded flight paths.\n\nAre you sure?",
      button1 = TEXT(ACCEPT),
      button2 = TEXT(CANCEL),
      OnAccept = function()
      FP_EraseConfirmed();
      end,
      timeout = 0,
   };
   StaticPopup_Show("FP_CONFIRM_ERASE")
end

function FP_EraseConfirmed()
   FP_InitializeConfig();
   FPCHAT("All FlightPath routes have been cleared.");
end

---------------------------------------------------------------------

function FP_SetShowGrey()
   if(FlightPath_Config.HideGrey ~= nil) then
      for i in FlightPath_Config.HideGrey do
         if(FlightPath_Config.HideGrey[i] == FP_GetNameServer()) then
            table.remove(FlightPath_Config.HideGrey,i);
            break;
         end
      end
   end
   FPCHAT("Greyed out flight paths will now be shown for "..UnitName("player"));
end

---------------------------------------------------------------------

function FP_SetHideGrey()
   if(FlightPath_Config.HideGrey == nil) then FlightPath_Config.HideGrey = {}; end;

   local found = false;
   for i in FlightPath_Config.HideGrey do
      if(FlightPath_Config.HideGrey[i] == FP_GetNameServer()) then
         found = true;
         break;
      end
   end
   if(not found) then
      table.insert(FlightPath_Config.HideGrey,FP_GetNameServer());
   end
   FPCHAT("Greyed out flight paths will now be hidden for "..UnitName("player"));
end

---------------------------------------------------------------------

function FP_HideGrey()
   if(FlightPath_Config.HideGrey == nil) then return false; end;

   for i in FlightPath_Config.HideGrey do
      if(FlightPath_Config.HideGrey[i] == FP_GetNameServer()) then
         return true;
      end
   end
   return false;
end

---------------------------------------------------------------------

function FP_EnableHooks()

   -- Hook the world map button so we know when map zones change via pulldown menu
   if(WorldMapButton_OnUpdate ~= FP_WorldMapButton_OnUpdate) then
      Original_WorldMapButton_OnUpdate = WorldMapButton_OnUpdate;
      WorldMapButton_OnUpdate = FP_WorldMapButton_OnUpdate;
   end

   -- Hook the TaxiMap tooltip function so we can add duration info
   if(TaxiNodeOnButtonEnter ~= FP_TaxiNodeOnButtonEnter) then
      Original_TaxiNodeOnButtonEnter = TaxiNodeOnButtonEnter
      TaxiNodeOnButtonEnter = FP_TaxiNodeOnButtonEnter;
   end

   -- Hook the TakeTaxiNode function so we know where we are going
   if(TakeTaxiNode ~= FP_TakeTaxiNode) then
      Original_TakeTaxiNode = TakeTaxiNode;
      TakeTaxiNode = FP_TakeTaxiNode;
   end

end

---------------------------------------------------------------------

function FP_DisableHooks()

   -- Unhook the world map button
   if(Original_WorldMapButton_OnUpdate and (WorldMapButton_OnUpdate == FP_WorldMapButton_OnUpdate)) then
      WorldMapButton_OnUpdate = Original_WorldMapButton_OnUpdate;
   end

   -- Unhook the TaxiMap tooltip
   if(Original_TaxiNodeOnButtonEnter and (TaxiNodeOnButtonEnter == FP_TaxiNodeOnButtonEnter)) then
      TaxiNodeOnButtonEnter = Original_TaxiNodeOnButtonEnter;
   end

   -- Unhook the TakeTaxiNode function
   if(Original_TakeTaxiNode and (TakeTaxiNode == FP_TakeTaxiNode)) then
      TakeTaxiNode = Original_TakeTaxiNode;
   end

end

---------------------------------------------------------------------

function FP_DoVersionFixups()

   -- Check what version the user was running previously and do any needed upgrades

   if(FlightPath_Config.Version == nil) then return; end;

   local dbversion;
   _,_,dbversion = string.find(FlightPath_Config.Version,"(%d*.%d+)"); -- Beta had format ".98 beta" so only grab the number part
   dbversion = tonumber(dbversion);

   -- If this is a user that participated in the beta test, clear out the old (incompatible) database

   if(dbversion < 1.0) then
      FlightPath_Config.FlightPaths = {};
      FPCHAT("\nThanks for beta testing FlightPath!");
      FPCHAT("All of your flight path information has been reset.");
      FPCHAT("If you don't want to have to relearn all of your flight paths use the '/fp load' command.");

   -- Versions lower than 1.04 did not have the KnownBy field, and some had the deprecated Greyed flag.

   elseif(dbversion < 1.04) then
      FPCHAT("Converting FlightPath data from version "..dbversion.." to version "..VERSION);
      for i in FlightPath_Config.FlightPaths do

         local greyed = false;
         local thisPathKnownBy = FP_GetNameServer();

         if(FlightPath_Config.FlightPaths[i].Greyed ~= nil) then
            greyed = FlightPath_Config.FlightPaths[i].Greyed;
            if(not greyed) then
               -- This item was forced to be not greyed in prior versions. We accomplish
               -- the same thing in 1.04 by setting the KnownBy to ALL
               thisPathKnownBy = "ALL";
            end
         end
         if(not greyed) then
            if(not FP_UserKnowsPath(FlightPath_Config.FlightPaths[i])) then
               if(FlightPath_Config.FlightPaths[i].KnownBy == nil) then
                  FlightPath_Config.FlightPaths[i].KnownBy = {}
               end
               table.insert(FlightPath_Config.FlightPaths[i].KnownBy,thisPathKnownBy);
            end
         end
         FlightPath_Config.FlightPaths[i].Greyed = nil; -- Remove deprecated field
      end

   -- Version 1.07 changed the duration from a single value to a value for each direction

   elseif(dbversion < 1.07) then

      FPCHAT("Converting FlightPath data from version "..dbversion.." to version "..VERSION);
      for i in FlightPath_Config.FlightPaths do
         if(FlightPath_Config.FlightPaths[i].Duration ~= nil) then
            local duration = FlightPath_Config.FlightPaths[i].Duration;
            FlightPath_Config.FlightPaths[i].Duration = { duration, duration }; -- start with both directions the same
         end
      end

   end

   FlightPath_Config.Version = VERSION;

end

---------------------------------------------------------------------

function FP_EventFrame_OnUpdate()

   -- This function is called frequently so be cpu and memory friendly

   if (FlightPath_Config.Enabled) then

      FP_CheckInFlightStatus();

      local ctime = time();
      if(ctime ~= LastTime) then

         -- Do periodic processing (once per second or so)

         FP_ShowInFlightCountdown(ctime-LastTime);
         LastTime = ctime;

      end

   end
end

---------------------------------------------------------------------

function FP_CheckInFlightStatus()

-- Check the flight recording state.

   if (Recording and not UnitOnTaxi("player")) then
      -- End of the road, stop recording
      FP_FlightPathEnd();
      Recording = false;
      StartRecording = false;
   end

   if (StartRecording) then
      if (UnitOnTaxi("player")) then
         FPDEBUG("Beginning flight from "..TaxiOrigin.." to "..TaxiDestination);
         StartRecording = false;
         Recording = true;
      end
   end

end

---------------------------------------------------------------------

function FP_ShowInFlightCountdown(secondsElapsed)

   if(TimeRemaining > 0) then
      TimeRemaining = TimeRemaining - secondsElapsed;  -- Decrease in flight time remaining
   end

   if((not FlightPath_Config.HideRemaining) and (TimeRemaining > 0)) then
      if(UnitOnTaxi("player")) then
         FP_CountdownTimerCity:SetText(TaxiDestination);
         FP_CountdownTimerCity:Show();
         local text = "Arriving in ";
         text = text..FP_FormatTime(TimeRemaining);
         FP_CountdownTimerRemaining:SetText(text);
         FP_CountdownTimerRemaining:Show();
      end
   else
      FP_CountdownTimerCity:Hide();
      FP_CountdownTimerRemaining:Hide();
   end

end

---------------------------------------------------------------------

function FP_GetNameServer()
   local name, server;
   name = UnitName("player");
   server = GetCVar("realmName");
   return name..","..server
end

---------------------------------------------------------------------

function FP_TaxiMapOpened()

   if(FlightPath_Config.Enabled) then

      TaximapOpen = true;

      -- Loop through the displayed buttons on the taxi map and
      -- add any routes that we haven't yet recorded

      local numButtons = NumTaxiNodes();

      -- Find out what flight masters like to call this location

      for i = 1, numButtons, 1 do
         if(TaxiNodeGetType(i) == "CURRENT") then
            TaxiOrigin = TaxiNodeName(i);
            break;
         end
      end

      -- Now check for new flight paths between here and all the ones shown on the taxi map

      local x, y = FP_GetPlayerCoords();
      local continent,zone = FP_GetRealContinentZone();
      FPDEBUG("Setting continent,zone,coords for current flight master to:",continent,zone,x,y);

      for i = 1, numButtons, 1 do
         if(TaxiNodeGetType(i) == "REACHABLE") then
            local index, path;
            index,path = FP_FindPath(TaxiOrigin, TaxiNodeName(i));
            if(index == 0) then
               path = {};
               path.Endpoints = {TaxiOrigin,TaxiNodeName(i)};
               path.Continent = {continent,0};
               path.Zone = {zone,0};
               path.Faction = UnitFactionGroup("player");
               path.Coords = {x..","..y,NOCOORDS};
            else
               if(path.Endpoints[1] == TaxiOrigin) then
                  path.Coords[1] = x..","..y;
                  path.Continent[1] = continent;
                  path.Zone[1] = zone;
               else
                  path.Coords[2] = x..","..y;
                  path.Continent[2] = continent;
                  path.Zone[2] = zone;
               end
            end
            path.Cost = TaxiNodeCost(i);
            FP_AddNewFlightPath(path,FP_LEARNED_FROM_FLIGHTMASTER);
         end
      end

   end
end

---------------------------------------------------------------------

function FP_TaxiMapClosed()
   if(FlightPath_Config.Enabled) then
      TaximapOpen = false;
   end
end

---------------------------------------------------------------------

function FP_TakeTaxiNode(nodeID)

   TaxiDestination = TaxiNodeName(nodeID);
   StartTime = time();
   TimeRemaining = 0;
   local index;

   index,CurrentFlight = FP_FindPath(TaxiOrigin, TaxiDestination);

   if(index == 0) then
      FPDEBUG("Internal error! FlightPath could not locate the flight path from "..TaxiOrigin.." to "..TaxiDestination);
   else

      -- Durations are stored associated with the from endpoint. TaxiDirection tells whether we are
      -- traveling from the first endpoint or the second endpoint of the connection pair.

      if(TaxiOrigin == CurrentFlight.Endpoints[1]) then TaxiDirection = 1; else TaxiDirection = 2; end

      if(CurrentFlight.Duration == nil) then
         CurrentFlight.Duration = {"",""};
      else
         local _,_,minutes,seconds = string.find(CurrentFlight.Duration[TaxiDirection],"(%d+):(%d+)");
         if(minutes and seconds) then
            TimeRemaining = (minutes*60) + seconds;
         end
      end
   end

   StartRecording =true; -- Tell the OnUpdate handler to start checking flight status

   Original_TakeTaxiNode(nodeID); -- Call the original handler now
end

---------------------------------------------------------------------

function FP_FlightPathEnd()

   -- We've landed. Record the duration of the flight and the coordinates of the
   -- flightmaster here if not already known.

   local x, y = FP_GetPlayerCoords();
   local destIndex = 2;
   if(TaxiDirection == 2) then destIndex = 1; end;

   TimeRemaining = 0;
   CurrentFlight.Duration[TaxiDirection] = FP_Elapsed(StartTime,time());
   CurrentFlight.Coords[destIndex] = x..","..y;
   CurrentFlight.Continent[destIndex],CurrentFlight.Zone[destIndex] = FP_GetRealContinentZone();

   FP_AddNewFlightPath(CurrentFlight,FP_LEARNED_FROM_FLIGHTMASTER);
end

---------------------------------------------------------------------

function FP_AddNewFlightPath(new,source)

   -- We have a potential new flight path. If we already know the path then update any
   -- relevant information, otherwise add the path to our data base.

   local index,foundPath = FP_FindPath(new.Endpoints[1],new.Endpoints[2]);
   local isNewPath = (foundPath == nil);

   -- Update the coords, continent, and zone of any connection point that matches one in the new path.
   -- (The need for this will go away once I properly normalize the data tables)

   if(source == FP_LEARNED_FROM_FLIGHTMASTER) then
      for i in FlightPath_Config.FlightPaths do
         for j = 1, 2, 1 do
            for k = 1, 2, 1 do
               if (new.Endpoints[j] == FlightPath_Config.FlightPaths[i].Endpoints[k]) then
                  if(new.Coords[j] ~= NOCOORDS) then
                     if(new.Coords[j] ~= FlightPath_Config.FlightPaths[i].Coords[k]) then
                        FPDEBUG("Replacing coords on flightpath "..i.." ("..FlightPath_Config.FlightPaths[i].Endpoints[k]..")\nFrom "..FlightPath_Config.FlightPaths[i].Coords[k].." to "..new.Coords[j]);
                        FlightPath_Config.FlightPaths[i].Coords[k] = new.Coords[j];
                     end
                  end
                  if(new.Continent[j] ~= 0) then FlightPath_Config.FlightPaths[i].Continent[k] = new.Continent[j]; end
                  if(new.Zone[j] ~= 0) then FlightPath_Config.FlightPaths[i].Zone[k] = new.Zone[j]; end
               end
            end
         end
      end
   end

   -- Either add it to our flight path database or update the cost and duration

   if(isNewPath) then
      table.insert(FlightPath_Config.FlightPaths,new);
      index = table.getn(FlightPath_Config.FlightPaths);
      if (source == FP_LEARNED_FROM_FLIGHTMASTER) then
         FPCHAT("FlightPath learned a new route between "..new.Endpoints[1].." and "..new.Endpoints[2]);
      end
   else

      -- I'm going to go on the assumption that information coming in from a flightmaster is more current
      -- than the potentially stale preloaded flight path information. If the user types a /fp load command
      -- after having learned their own flight paths I want to ensure that the preloaded data does not overwrite
      -- the learned data. For this reason costs and times are only updated in the database when the path is
      -- one we obtained from a flight master. (On an initial /fp load the paths will be unknown so the the
      -- times and costs from the preloaded paths will be the initial values).

      if(source == FP_LEARNED_FROM_FLIGHTMASTER) then

         -- Cost
         if(new.Cost) then FlightPath_Config.FlightPaths[index].Cost = new.Cost; end;

         -- Duration
         if(new.Duration and (table.getn(new.Duration) >= 1)) then

            if(FlightPath_Config.FlightPaths[index].Duration == nil) then FlightPath_Config.FlightPaths[index].Duration = {"",""}; end

            if(new.Endpoints[1] == FlightPath_Config.FlightPaths[index].Endpoints[1]) then
               FlightPath_Config.FlightPaths[index].Duration[1] = new.Duration[1];
               if(FlightPath_Config.FlightPaths[index].Duration[2] == "") then FlightPath_Config.FlightPaths[index].Duration[2] = new.Duration[2]; end
            else
               FlightPath_Config.FlightPaths[index].Duration[2] = new.Duration[1];
               if(FlightPath_Config.FlightPaths[index].Duration[1] == "") then FlightPath_Config.FlightPaths[index].Duration[1] = new.Duration[2]; end
            end

            -- If one direction still has no duration, assume it's the same as the other leg

            if(FlightPath_Config.FlightPaths[index].Duration[1] == "") then
               FlightPath_Config.FlightPaths[index].Duration[1] = FlightPath_Config.FlightPaths[index].Duration[2];
            end
            if(FlightPath_Config.FlightPaths[index].Duration[2] == "") then
               FlightPath_Config.FlightPaths[index].Duration[2] = FlightPath_Config.FlightPaths[index].Duration[1];
            end
         end;

      end
   end

   -- Record the fact that the user knows this flight so it no longer displays as grey or shows up if they have hidegrey set

   if(source == FP_LEARNED_FROM_FLIGHTMASTER) then
      if(not FP_UserKnowsPath(FlightPath_Config.FlightPaths[index])) then
         if(FlightPath_Config.FlightPaths[index].KnownBy == nil) then FlightPath_Config.FlightPaths[index].KnownBy = {}; end
         table.insert(FlightPath_Config.FlightPaths[index].KnownBy,FP_GetNameServer());
      end
   end

end

---------------------------------------------------------------------

function FP_Elapsed(start,finish)
   return FP_FormatTime(finish-start);
end

---------------------------------------------------------------------

function FP_FormatTime(duration)
   local minutes = floor(duration / 60);
   local seconds = duration - (minutes * 60);
   local tens = floor(seconds/10);
   local single = seconds - (tens * 10);
   return minutes..":"..tens..single;
end

---------------------------------------------------------------------

function FP_GetPlayerCoords()

   FP_ForceMapToCurrentZone(); -- voodoo here to try and address WoW bug

   local px, py = GetPlayerMapPosition("player");

   -- normalize coords to ##.## format

   px = floor(px * 10000);
   py = floor(py * 10000);
   px = px / 100;
   py = py / 100;
   return px,py
end

---------------------------------------------------------------------

function FP_ForceMapToCurrentZone()
   if(GetCurrentMapZone() ~= 0) then
      SetMapToCurrentZone();  -- Normally this is what will happen
   else
      local continent,zone = FP_GetRealContinentZone();
      SetMapZoom(continent,zone);
   end
end

---------------------------------------------------------------------

function FP_GetRealContinentZone()

   if(GetCurrentMapZone() ~= 0) then
      return GetCurrentMapContinent(),GetCurrentMapZone();
   end

   -- We're bugged. Fortunately GetRealZoneText() is accurate so we can use that
   -- to figure out our zone. (Remember, continent and zone numbers equate to their
   -- index number in the world map pulldowns). This idea was first implemented by
   -- Legorol in his ZoneFix mod.

   local continent,zone,name
   local zoneText = GetRealZoneText();
   for continent in ipairs{GetMapContinents()} do
      for zone,name in ipairs{GetMapZones(continent)} do
         if(name == zoneText) then
            FPDEBUG("SetMapToCurrentZone bug detected!! You should zone or logout before talking to any flight masters. Returning fixed up continent,zone:",continent,zone);
            return continent,zone;
         end
      end
   end
   return 0,0; -- Should never happen
end

---------------------------------------------------------------------

function FP_GetLocale()

   local zone = GetRealZoneText();
   local city = GetMinimapZoneText();

   if (zone == city) then
      return zone;
   else
      return city..", "..zone;
   end

end

---------------------------------------------------------------------

function FP_Load(option)

   if(option == nil or option == "") then
      FPCHAT("Usage: "..WHITE.."/fp load name"..STATUS_COLOR.." where name is one of 'misc', 'horde', or 'alliance'.");
      return;
   end

   local toLoad = getglobal("FP_"..option.."Paths");
   if(toLoad == nil) then
      FPCHAT("Could not find a list called "..option.."Paths in the KnownPaths.lua file.\nType '/fp ?' for help.");
      return;
   end

   for i in toLoad do
      FP_AddNewFlightPath(toLoad[i],FP_LEARNED_FROM_PRELOAD);
   end

   FPCHAT("Scanned "..table.getn(toLoad).." "..option.." paths for new connections.");

end

---------------------------------------------------------------------

function FP_IsSameLocation(location1, location2)

   -- So why are we going through all these gyrations to see if one location is
   -- the same as another? Because WoW uses different location names in the taxi
   -- map than they do for the city and zone names proper. For example. the
   -- flight master in Orgrimmar is located in the "Valley of Strength, Orgrimmar"
   -- if you use GetZoneText() or other API calls. However the name of the
   -- taxi node for that flight master is "Orgrimmar, Durotar". There are many
   -- other locations in Azeroth that have similar discrepancies. (Ironforge,
   -- Moonglade, ...)
   --
   -- In order to bring up the correct dialog page for the location the player
   -- is currently, we need to correlate these two different versions of a place name.

   -- See if they just match

   if(location1 == location2) then return true; end

   local c1, z1, c2, z2;
   c1,z1 = FP_ParseLocation(location1);
   c2,z2 = FP_ParseLocation(location2);

   -- See if city names match (since city names are unique)

   if((c1 ~= "") and (c1 == c2)) then return true; end

   -- See if the city and zones are swapped (e.g. Orgrimmar)

   if((c1 ~= "") and (c1 == z2)) then return true; end
   if((c2 ~= "") and (c2 == z1)) then return true; end

   -- See if parts of city match (e.g. "The Crossroads", "Crossroads")

   local b, e, match;
   if(c1 ~= "" and c2 ~= "") then
      b,e,match = string.find(c1,c2,1,true);
      if(b) then return true; end;

      b,e,match = string.find(c2,c1,1,true);
      if(b) then return true; end;
   end

   -- See if parts of zone match city (e.g. "Stormwind,Elwynn", "Trade District,Stormwind City")

   if(c1 ~= "" and z2 ~= "") then
      b,e,match = string.find(c1,z2,1,true);
      if(b) then return true; end;
      b,e,match = string.find(z2,c1,1,true);
      if(b) then return true; end;
   end
   if(c2 ~= "" and z1 ~= "") then
      b,e,match = string.find(c2,z1,1,true);
      if(b) then return true; end;
      b,e,match = string.find(z1,c2,1,true);
      if(b) then return true; end;
   end

   -- Give up and assume the locations are not the same

   return false;
end

---------------------------------------------------------------------

function FP_FindCoords(location)

   -- Loop through all known flight paths and see if we can find the
   -- coordinate position of the specified flight master.
   -- This will be uneccessary when I properly normalize the data tables

   local coords = NOCOORDS;

   for i in FlightPath_Config.FlightPaths do

      if(FP_IsSameLocation(location,FlightPath_Config.FlightPaths[i].Endpoints[1])) then
         if(FlightPath_Config.FlightPaths[i].Coords[1] ~= NOCOORDS) then
            coords = FlightPath_Config.FlightPaths[i].Coords[1];
            break;
         end
      end

      if(FP_IsSameLocation(location,FlightPath_Config.FlightPaths[i].Endpoints[2])) then
         if(FlightPath_Config.FlightPaths[i].Coords[2] ~= NOCOORDS) then
            coords = FlightPath_Config.FlightPaths[i].Coords[2];
            break;
         end
      end

   end

   return coords;
end

---------------------------------------------------------------------

function FP_GetRecordedFlightpaths()

   -- Return a list of known locations for display in the dialog drop down list

   local flightpaths = {}; -- reverse zone and city so list is sorted by zone
   local lookup = {}

   for i in FlightPath_Config.FlightPaths do
      if (FlightPath_Config.FlightPaths[i].Faction == UnitFactionGroup("player")) then
         if(FP_UserKnowsPath(FlightPath_Config.FlightPaths[i]) or (not FP_HideGrey())) then
            for j = 1, 2, 1 do
               local tcity, tzone = FP_ParseLocation(FlightPath_Config.FlightPaths[i].Endpoints[j]);
               local zoneFirst = tzone;
               if(tcity ~= "") then zoneFirst = zoneFirst.." - "..tcity; end
               if (lookup[zoneFirst] == nil) then
                  lookup[zoneFirst] = true;
                  table.insert(flightpaths,zoneFirst);
               end
            end
         end
      end
   end

   table.sort(flightpaths);
   return flightpaths;
end

---------------------------------------------------------------------

function FP_ParseCoord(coord)
   local _, _, x, y = string.find(coord,"(%d*.%d*),(%d*.%d*)");
   return tonumber(x), tonumber(y);
end

---------------------------------------------------------------------

function FP_ParseLocation(locale)

   -- locale can be:
   -- zone              we are in an unnamed area of a zone
   -- city, zone        normal parse
   -- zone - city       dash means swap zone city order (is dropdown entry)

   if(not locale) then return "",""; end

   local b, e, city, zone, dash;

   b,e,dash = string.find(locale," - ", 1, true); -- it's in dropdown format if it has a dash
   if(b) then
      zone = FP_Trim(string.sub(locale,1,b-1));
      city = FP_Trim(string.sub(locale,e+1,string.len(locale)));
      return city,zone;
   end

   b,e,city = string.find(locale, "([%P%'%` ]+),"); -- This should be good for foreign character sets as well
   if(not b) then
      city = "";
      zone = FP_Trim(locale);
   else
      b,e,zone = string.find(locale, "[%P%'%` ]+,%s*([%P%'%` ]+)");
      if(not b) then
         -- For degenerate cases like Moonglade that don't return a zone use the city name as the zone
         zone = FP_Trim(city);
      end;
   end

   return city,zone;
end

---------------------------------------------------------------------

function FP_Trim(text)
   -- Remove trailing spaces from a string
   if(text == nil) then return; end;
   local _,_,trimmed = string.find(text,"(.-)%s*$");
   return trimmed;
end

---------------------------------------------------------------------
--
--              User Interface logic
--
---------------------------------------------------------------------

function FP_FlightPathDialog()

   if (FP_UIFrame:IsVisible() ) then
      FP_UIFrame:Hide();   -- So bound key toggles dialog on/off
   else
      DropDownStartIndex=1;
      FP_DisplayDialogConnections();
      FP_UIFrame:Show();
   end

end

---------------------------------------------------------------------

function FP_WorldMapUpdate()

   -- Changing zones overwrites DropDownList1 which the dialog uses.
   -- If we change zones with the dialog open, repopulate the list

   if (FP_UIFrame:IsVisible() ) then
      FP_UIZoneDropDown_Initialize();
   end

end

---------------------------------------------------------------------

function FP_UIZoneDropDown_Initialize()

   -- Called from the frames OnShow

   FP_UIZoneDropDownClear();

   local index=DropDownStartIndex;
   local info = {};
   local buttonCount = 0;

   local flightpaths = FP_GetRecordedFlightpaths();
   local knownCount = table.getn(flightpaths);

   for i = 1, MAXDROPDOWN, 1 do

      local buttonText = "";

      if((i == 1) and (DropDownStartIndex > 1)) then
         buttonText = MOREUP;

      elseif((i == MAXDROPDOWN) and (index < (knownCount-1))) then
         buttonText = MOREDOWN;

      else
         if(index > knownCount) then break;end;
         buttonText = flightpaths[index];
         index = index + 1;
      end

      info={};
      info.text = buttonText;
      info.func = FP_UIZoneDropDown_OnClick;
      info.keepShownOnClick = true;
      info.notCheckable = true; -- WoW is bugged and will still show check but at least save width
      UIDropDownMenu_AddButton(info,1);
   end

   DropDownList1:ClearAllPoints();
   DropDownList1:SetPoint("CENTER","FP_UIFrame","CENTER",0,0);

end

---------------------------------------------------------------------

function FP_UIZoneDropDownClear()
   local text = UIDropDownMenu_GetText(FP_UIZoneDropDown);
   UIDropDownMenu_ClearAll(FP_UIZoneDropDown);
   UIDropDownMenu_SetText(text,FP_UIZoneDropDown);
   DropDownList1.numButtons = 0;
end

---------------------------------------------------------------------

function FP_UIZoneDropDown_OnClick()

   if(this:GetText() == MOREDOWN) then
      FPDEBUG("Down arrow detected");
      local flightpaths = FP_GetRecordedFlightpaths();
      local knownCount = table.getn(flightpaths);
      DropDownStartIndex = knownCount - MAXDROPDOWN+1;
      FP_UIZoneDropDown_Initialize();
      return;

   elseif(this:GetText() == MOREUP) then
      FPDEBUG("Up arrow detected");
      DropDownStartIndex = 1;
      FP_UIZoneDropDown_Initialize();
      return;

   else
      FP_DisplayDialogConnections(this:GetText());
      DropDownList1:Hide();
   end

end

---------------------------------------------------------------------

function FP_FormatMoney(money)

   if(money == nil) then return ""; end;

   amount = tonumber(money);
   if(amount == nil) then
      FPDEBUG("Failed to convert money string to number: ",money);
      return ""
   end

   local gold, silver, copper, text;

   gold = floor(amount / (100*100));
   silver = mod(floor(amount / 100),  100);
   copper = mod(floor(amount + .5), 100);

   text = "";
   if(gold > 0) then text = gold.."g"; end
   if(silver > 0) then
      if(text ~= "") then text = text.." "; end;
      text = text..silver.."s";
   end
   if(copper > 0) then
      if(text ~= "") then text = text.." "; end;
      text = text..copper.."c";
   end
   return text;
end
---------------------------------------------------------------------

function FP_DisplayDialogConnections(location)

   -- Display the appropriate connections text on the FlightPath dialog box

   local text;
   local routeFound = false;
   local databaseIsEmpty = true;
   local tlocation, b, e, i, j, duration;

   -- Used to make a second attempt based on zone number if we fail to populate based on location text

   PopulatePass = PopulatePass+1;
   local _,currentMapZone = FP_GetRealContinentZone();
   local repopulateLoc = "";

   if(not location) then
      location = FP_GetLocale(); -- On initial call determine where we are
   end
   tlocation = location;

   Connections = {}; -- clear shared table
   local connectionCost = {};
   local connectionColor = {};

   for i in FlightPath_Config.FlightPaths do
      if (FlightPath_Config.FlightPaths[i].Faction == UnitFactionGroup("player")) then
         for j = 1, 2, 1 do

            if(FlightPath_Config.FlightPaths[i].Zone[j] == currentMapZone) then
               repopulateLoc = FlightPath_Config.FlightPaths[i].Endpoints[j]; -- In case we need to make 2nd pass cause 1st came up empty
            end

            if(FP_IsSameLocation(location,FlightPath_Config.FlightPaths[i].Endpoints[j])) then
               tlocation = FlightPath_Config.FlightPaths[i].Endpoints[j];
               local which = 1;
               if(j == 1) then which = 2; end;

               -- If this is a preloaded flight can't yet fly, grey it out

               local color = CONNECTION_COLOR;
               local mcolor = MONEY_COLOR;
               if(not FP_UserKnowsPath(FlightPath_Config.FlightPaths[i])) then
                  color = GREY;
                  mcolor = GREY;
               end

               -- Only show greyed paths if user hasn't disabled displaying them

               if((color ~= GREY) or (not FP_HideGrey())) then

                  connectionColor[FlightPath_Config.FlightPaths[i].Endpoints[which]] = color;

                  -- Add this endpoint to our available connections

                  table.insert(Connections,FlightPath_Config.FlightPaths[i].Endpoints[which]);

                  -- If we know the cost, display it

                  text = ""
                  if(FlightPath_Config.FlightPaths[i].Cost) then
                     text =  mcolor..FP_FormatMoney(FlightPath_Config.FlightPaths[i].Cost);
                  end

                  -- If we know the duration, display it

                  duration = FP_GetDuration(FlightPath_Config.FlightPaths[i], FlightPath_Config.FlightPaths[i].Endpoints[j]);
                  if(duration == nil or duration == "") then duration = "        "; end; -- Because column is right justified
                  text = text..color.."  "..duration;
                  connectionCost[FlightPath_Config.FlightPaths[i].Endpoints[which]] = text;

                  routeFound = true;
               end
            end
            databaseIsEmpty = false;
         end
      end
   end
   table.sort(Connections);

   FP_ClearDialogScreen();

   if (routeFound) then

      local text;

      FP_UIStaticConnections:SetText(WHITE.."Connections");
      FP_UIStaticZone:SetText(WHITE.."Zone");
      for i in Connections do
         if(i > MAX_CONNECTIONS) then
            FPCHAT("Maximum number of connections ("..MAX_CONNECTIONS..") exceeded for zone "..zone..".");
            break;
         end
         text = getglobal("FP_Connection"..i);
         text:SetText(connectionColor[Connections[i]]..Connections[i]);
         text = getglobal("FP_ConnectionCost"..i);
         text:SetText(connectionCost[Connections[i]]);
      end

      local tcity, tzone = FP_ParseLocation(tlocation);
      tlocation = tzone;
      if(tcity ~= "") then
         tlocation = tlocation.." - "..tcity;
      end
      UIDropDownMenu_SetText(tlocation,FP_UIZoneDropDown);
      FP_UIErrorText:SetText("");
      PopulatePass = 0;
   else
      UIDropDownMenu_SetText("",FP_UIZoneDropDown);
      if (databaseIsEmpty) then
         -- If we don't know any flight paths at all display a reassuring message to the user
         text = WHITE..
            "FlightPath has not yet learned any flight paths for the "..UnitFactionGroup("player")..".\n\n"..
            "As you travel around Azeroth, FlightPath will learn the flight paths available to you.\n\n"..
            "Soon it will know connections for each flight master, how much each flight costs, and how long it takes to get from one point to another.\n\n"..
            "If you would rather not wait and would like to load any of the optional flight paths available, use the "..STATUS_COLOR.."/fp load"..WHITE.." command.";
         FP_UIErrorText:SetText(text);
         return;
      else
         if((PopulatePass == 1) and (repopulateLoc ~= "")) then
            -- Didn't match anything first time through
            FP_DisplayDialogConnections(repopulateLoc);
            PopulatePass = 0;
         end
      end
   end

end

---------------------------------------------------------------------

function FP_ClearDialogScreen()

   local button;

   FP_UIErrorText:SetText("");
   FP_UIStaticConnections:SetText("");

   for i = 1, MAX_CONNECTIONS, 1 do

      button = getglobal("FP_Connection"..i);
      button:SetText("");

      button = getglobal("FP_ConnectionCost"..i);
      button:SetText("");

   end

   FP_DialogHeading:SetText(BRIGHTGREY..BINDING_HEADER_FPHEADER);
   FP_DialogVersion:SetText(GREY.."Version "..VERSION);
end

---------------------------------------------------------------------

function FP_UIFrame_OnShow()
--   UIDropDownMenu_Initialize(FP_UIZoneDropDown, FP_UIZoneDropDown_Initialize);
end

---------------------------------------------------------------------

function FP_Clicked(leftOrRight, buttonID)

   -- Process left mouse button click

   local index = 0;
   local tzone, tcity;

   if (tonumber(buttonID) >= CONNECTION_START_ID) then
      index = buttonID - CONNECTION_START_ID + 1;
      if(index <= table.getn(Connections)) then

         if ( leftOrRight == "LeftButton" ) then

            FP_DisplayDialogConnections(Connections[index]);

         else
            local continent, zone = GetMapNumbers(Connections[index]);
            if((continent ~= 0) and (zone ~= 0)) then
               -- Display appropriate map on right click
               ToggleWorldMap();
               SetMapZoom(continent,zone);
            end
         end
      end

   else
      FPCHAT("FlightPath received a click from unknown button "..buttonID.."");
   end

   return;
end

---------------------------------------------------------------------

function FP_UserKnowsPath(path)

   if(path.KnownBy == nil) then return false; end;

   for i in path.KnownBy do
      if(path.KnownBy[i] == "ALL") then return true; end;
      if(path.KnownBy[i] == FP_GetNameServer()) then return true; end;
   end

   return false;
end

---------------------------------------------------------------------

function GetMapNumbers(location)
   local continent, zone;
   for i in FlightPath_Config.FlightPaths do
      for j = 1, 2, 1 do
         if( FP_IsSameLocation(location,FlightPath_Config.FlightPaths[i].Endpoints[j])) then
            continent = FlightPath_Config.FlightPaths[i].Continent[j];
            zone = FlightPath_Config.FlightPaths[i].Zone[j];
            if(continent ~= 0 and zone ~= 0) then
               return continent, zone;
            end
         end
      end
   end
   return 0,0;
end

---------------------------------------------------------------------

function FP_Status()

   if (FlightPath_Config.Enabled) then
      FPCHAT(BINDING_HEADER_FPHEADER.." version "..VERSION.." is enabled.");
   else
      FPCHAT(BINDING_HEADER_FPHEADER.." version "..VERSION.." is disabled.");
   end

   FP_ReportBindingKey();

   if(FlightPath_Config.HideRemaining) then FPCHAT("The in flight time remaining counter is disabled."); end;

   local x, y = FP_GetPlayerCoords();
   FPCHAT("You are now at location "..x..","..y.." in "..FP_GetLocale());
   if (UnitOnTaxi("player")) then
      FPCHAT("You are currently flying from "..TaxiOrigin.." to "..TaxiDestination);
   end

   local flightpaths = FP_GetRecordedFlightpaths();
   if (flightpaths) then
      faction = UnitFactionGroup("player")
      local factionRoutes = 0
      for i in FlightPath_Config.FlightPaths do
         if (FlightPath_Config.FlightPaths[i].Faction == faction) then
            factionRoutes = factionRoutes + 1;
         end
      end
      FPCHAT("FlightPath knows of "..factionRoutes.." "..faction.." routes between "..table.getn(flightpaths).." locations.");
   end
end

---------------------------------------------------------------------

function FP_ReportBindingKey()
   if(GetBindingKey("FPDIALOG")) then
      FPCHAT("The FlightPath dialog is bound to key "..GetBindingKey("FPDIALOG"));
   end
end

---------------------------------------------------------------------
--
--              World Map logic
--
---------------------------------------------------------------------

function FP_Round(value)
   return math.floor(value*10000.0)/10000.0;
end

---------------------------------------------------------------------

function FP_GetPOITooltipText(location)

   local leftSide = {};
   local rightSide = {}
   local text;
   local routeFound = false;
   local city, zone, tcity, tzone, i;

   if(not location) then
      city = "";
      zone = WorldMapZoneDropDownText:GetText();
   else
      city, zone = FP_ParseLocation(location);
   end

   leftSide[1] = location;             rightSide[1] = " ";
   leftSide[2] = " ";                  rightSide[3] = " ";
   leftSide[3] = WHITE.."Connections:";rightSide[4] = " ";
   leftSide[4] = " ";                  rightSide[5] = " ";
   local lineNumber = 5;

   local poiConnections = {};
   local poiCosts = {}
   local unique = {};
   local connectionColors = {};
   local connection,cost,duration, pline;

   for i in FlightPath_Config.FlightPaths do
      if (FlightPath_Config.FlightPaths[i].Faction == UnitFactionGroup("player")) then
         local color = STATUS_COLOR;
         if(not FP_UserKnowsPath(FlightPath_Config.FlightPaths[i])) then color = GREY; end

         if((color ~= GREY) or (not FP_HideGrey())) then
            tcity, tzone = FP_ParseLocation(FlightPath_Config.FlightPaths[i].Endpoints[1]);
            if ((((city == "") or (city == tcity)) and (zone == tzone))) then
               if(unique[FlightPath_Config.FlightPaths[i].Endpoints[2]] == nil) then
                  unique[FlightPath_Config.FlightPaths[i].Endpoints[2]] = true;
                  connection, cost = FP_BuildPOITipLine(FlightPath_Config.FlightPaths[i],2,location, color == GREY)
                  table.insert(poiConnections,connection);
                  poiCosts[connection] = cost;
                  connectionColors[connection] = color;
                  routeFound = true;
               end
            end
            tcity, tzone = FP_ParseLocation(FlightPath_Config.FlightPaths[i].Endpoints[2]);
            if ((((city == "") or (city == tcity)) and (zone == tzone))) then
               if(unique[FlightPath_Config.FlightPaths[i].Endpoints[1]] == nil) then
                  unique[FlightPath_Config.FlightPaths[i].Endpoints[1]] = true;
                  connection, cost = FP_BuildPOITipLine(FlightPath_Config.FlightPaths[i],1,location, color == GREY)
                  table.insert(poiConnections,connection);
                  poiCosts[connection] = cost;
                  connectionColors[connection] = color;
                  routeFound = true;
               end
            end
         end
      end
   end
   table.sort(poiConnections);

   if (routeFound) then
      for i in poiConnections do
         leftSide[lineNumber] = connectionColors[poiConnections[i]]..poiConnections[i];
         rightSide[lineNumber] = poiCosts[poiConnections[i]];
         lineNumber = lineNumber + 1;
      end
   else
      leftSide[lineNumber] = STATUS_COLOR.."No connections found.";
      rightSide[lineNumber] = " ";
   end

   return leftSide,rightSide;
end

---------------------------------------------------------------------

function FP_BuildPOITipLine(path,index,location,isGrey)
   local text = "";
   local color;
   local duration = FP_GetDuration(path,location);
   if(path.Cost ~= nil and path.Cost ~= "") then
      color = MONEY_COLOR;
      if(isGrey) then color = GREY; end;
      text = color..FP_FormatMoney(path.Cost);
   end

   if(duration ~= nil and duration ~="") then
      color = WHITE;
      if(isGrey) then color = GREY; end;
      text = text.."  "..color..duration;
   else
      text = text.."          ";
   end
   return path.Endpoints[index],text;
end

---------------------------------------------------------------------

function FP_WorldMapButton_OnUpdate(elapsed)

   Original_WorldMapButton_OnUpdate(elapsed); -- Call the original owner of the hook so we don't break other mods

   if(FlightPath_Config.Enabled) then

      local path;
      local buttonCount = 0;

      -- Hide all the POI buttons

      for i = 1, MAX_POI_BUTTONS, 1 do
         POI = getglobal("FP_POI"..i);
         if(POI) then
            POI:ClearAllPoints();
            POI.Location = nil;
            POI:Hide();
         end
      end

      -- What map are we looking at?

      -- Returns 0=world, 1=kalimdor or a zone in kalimdor, 2=ek or a zone in ek
      local continent = GetCurrentMapContinent();
      if(continent ==0) then return; end; -- We don't support the world map yet

      -- Returns zone index or 0 if showing the entire continent
      local zone = GetCurrentMapZone();
      if(zone == 0) then return; end; -- We don't support the continent map yet

      -- Create a table of locations to display in this zone

      local displayable = {};

      for i in FlightPath_Config.FlightPaths do
         if((FlightPath_Config.FlightPaths[i].Faction == UnitFactionGroup("player")) and (FP_UserKnowsPath(FlightPath_Config.FlightPaths[i]) or not FP_HideGrey()) ) then
            for j = 1, 2, 1 do
               if(FlightPath_Config.FlightPaths[i].Continent[j] == continent) then
                  if(FlightPath_Config.FlightPaths[i].Zone[j] == zone) then
                     dindex = FlightPath_Config.FlightPaths[i].Endpoints[j];
                     if(displayable[dindex] == nil) then
                        displayable[dindex] = {};
                        displayable[dindex].Coords = FlightPath_Config.FlightPaths[i].Coords[j];
                     end
                     if(FP_UserKnowsPath(FlightPath_Config.FlightPaths[i])) then
                        displayable[dindex].Texture = "Interface\\TaxiFrame\\UI-Taxi-Icon-Yellow";
                     else
                        if(displayable[dindex].Texture == nil) then
                           displayable[dindex].Texture = "Interface\\TaxiFrame\\UI-Taxi-Icon-Gray";
                        end
                     end
                  end
               end
            end
         end
      end

      -- Create POI's for found flight masters

      for j in displayable do
         buttonCount = buttonCount + 1;
         local POI = getglobal("FP_POI"..buttonCount);
         local POITexture = getglobal("FP_POI"..buttonCount.."Icon");
         local x, y = FP_ParseCoord(displayable[j].Coords);
         POITexture:SetTexture(displayable[j].Texture);
         POI:ClearAllPoints();
         POI:SetPoint("CENTER", "WorldMapDetailFrame", "TOPLEFT", x/100*WorldMapButton:GetWidth(), -y/100*WorldMapButton:GetHeight());
         POI:Show();

         -- Add a location field to the POI so we can query it when creating a tooltip

         POI.Location = j;

      end

   end
end

---------------------------------------------------------------------

function FP_POIOnEnter()

   -- Called when the mouse hovers over the flight path POI button on the zone map

   local px, py = this:GetCenter();
   local wx, wy = WorldMapButton:GetCenter();
   local align = "ANCHOR_LEFT";
   if(px <= wx) then align = "ANCHOR_RIGHT"; end

   WorldMapFrameAreaLabel:SetText(this.Location);
   WorldMapTooltip:SetOwner(this, align);
   local leftSide,rightSide = FP_GetPOITooltipText(this.Location);
   for i in leftSide do
      if(rightSide[i] ~= nil) then
         WorldMapTooltip:AddDoubleLine(leftSide[i],rightSide[i]);
      else
         WorldMapTooltip:AddLine(leftSide[i]);
      end
   end
   WorldMapTooltip:Show();
end

---------------------------------------------------------------------

function FP_POIOnLeave()
   WorldMapTooltip:Hide();
   WorldMapTooltip:SetText("");
end

---------------------------------------------------------------------

function FP_TaxiNodeOnButtonEnter(button)

   local showDuration = false;
   local buttonLocation = TaxiNodeName(this:GetID());

   if(buttonLocation ~= "INVALID") then
      if(not FP_IsSameLocation(TaxiOrigin,buttonLocation)) then
         local index,path = FP_FindPath(TaxiOrigin,buttonLocation);
         if(index ~= 0) then
            local duration = FP_GetDuration(path,TaxiOrigin);
            if((duration ~= nil) and (duration ~= "")) then
               ShoppingTooltip2:SetOwner(GameTooltip, "ANCHOR_BOTTOMRIGHT");
               ShoppingTooltip2:ClearAllPoints();
               ShoppingTooltip2:SetPoint("TOPLEFT", "GameTooltip", "TOPRIGHT", 0, -10);
               ShoppingTooltip2:AddLine("Flight time: "..duration, "", 0.5, 1.0, 0.5);
               showDuration = true;
            end
         end
      end
   end

   Original_TaxiNodeOnButtonEnter(button); -- call original handler

   if(showDuration) then
      ShoppingTooltip2:Show();
   end

end

---------------------------------------------------------------------

function FP_GetDuration(path,location)

   if(path.Duration == nil) then
      return nil;

   end

   if(location == path.Endpoints[1]) then
      return path.Duration[1];   -- Duration is always stored as 'time from' the corresponding endpoint
   else
      return path.Duration[2];
   end
end

---------------------------------------------------------------------

function FP_FindPath(location1, location2)
   for i in FlightPath_Config.FlightPaths do
      local endpoint1 = FlightPath_Config.FlightPaths[i].Endpoints[1];
      local endpoint2 = FlightPath_Config.FlightPaths[i].Endpoints[2];
      if((FP_IsSameLocation(location1,endpoint1) and FP_IsSameLocation(location2,endpoint2)) or
         (FP_IsSameLocation(location1,endpoint2) and FP_IsSameLocation(location2,endpoint1))) then
            return i,FlightPath_Config.FlightPaths[i];
      end
   end
   return 0,nil;
end

---------------------------------------------------------------------

function FP_Debug()
   FPDebugShow = true;
   FPDEBUG("Debug output enabled.");
end

---------------------------------------------------------------------

-- Debug routine to help users debug flightmaster/zone name mismatches.

function FP_Check()

   if(not TaximapOpen) then
      FPCHAT("Please open up the flight master's connections map then type /fp check again.");
      return;
   end

   -- Find out what flight masters like to call this location

   local where;
   local numButtons = NumTaxiNodes();
   for i = 1, numButtons, 1 do
      if(TaxiNodeGetType(i) == "CURRENT") then
         where = TaxiNodeName(i);
         break;
      end
   end

   if(FP_IsSameLocation(where, FP_GetLocale())) then
      FPCHAT("FlightPath was able to match the flight master's name for this location ("..where..") to the map location ("..FP_GetLocale().."). No problems detected.");
   else
      FPCHAT("FlightPath was unable to match the flight master's name for this location ("..where..") to the map location ("..FP_GetLocale().."). Please report this to Kwraz!!!");
   end
end

---------------------------------------------------------------------

-- Display functions

function FPCHAT(text)
   DEFAULT_CHAT_FRAME:AddMessage(STATUS_COLOR..text);
end


FPDebugShow = false;

function FPDEBUG(...)
   if(FPDebugShow) then
      local text = "";
      for i = 1, arg.n, 1 do
         if(i>2) then text = text..", ";end;
         local value="";
         local vtype = type(arg[i]);
         if    (vtype == "nil")        then text = text.."(nil)";
         elseif(vtype == "number")     then text = text..tostring(arg[i]);
         elseif(vtype == "string")     then text = text..arg[i];
         elseif(vtype == "boolean")    then if(arg[i]) then text = text.."true"; else text = text.."false"; end
         elseif(vtype == "table"    or
                vtype == "function" or
                vtype == "thread"   or
                vtype == "userdata")   then text = text.."("..vtype..")";
         else                               text = text.."(unknown)";end
      end
      DEFAULT_CHAT_FRAME:AddMessage(DEBUG_COLOR.."FPDBG: "..text);
   end
end

function FPSPACE(count)
   return string.rep(" ",count);
end

---------------------------------------------------------------------
-- Development only
---------------------------------------------------------------------

function FP_Test(text)
   local txt = "";
   if(text ~= nil) then txt=text;end;
   FPDEBUG("In FP_Test("..txt..")...");

   -- Begin test code

   local testForeign = "Grom'Gul, Mitteilung Mu\195\159sein";
   local tcity, tzone = FP_ParseLocation(testForeign);
   FPDEBUG(testForeign.." parsed to city '"..tcity.."' zone='"..tzone.."'");

   -- End test code

   FPDEBUG("...Exited FP_Test");
end

