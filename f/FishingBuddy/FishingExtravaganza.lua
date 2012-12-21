-- Support for the Extravaganza
--
-- Map support liberally borrowed from GuildMap, by Bru on Blackhand

FishingBuddy.Extravaganza = {};

local NUMMINIPOIS = 10;
local ICONPATH = "Interface\\AddOns\\FishingBuddy\\Icons\\";
local CLOSEENOUGH = 10.0;

-- the actual names don't matter, except to help make sure I've got 'em all
local ExtravaganzaFish = {};
ExtravaganzaFish[19807] = "Speckled Tastyfish";
ExtravaganzaFish[19806] = "Dezian Queenfish";
ExtravaganzaFish[19805] = "Keefer's Angelfish";
-- makes you wonder what item 19804 is, doesn't it...
ExtravaganzaFish[19803] = "Brownell's Blue Striped Racer";

local UPDATETIME_SCHOOLS = 0.1;
local UPDATETIME_COUNTER = 60.0;
local STVUpdateTimer = 0;
local numCaught = 0;
local tastyfish_id = 19807;
local tastyfish;

-- convert zone coords into minimap coords
local STVInfo = { scale = 0.18128603034401,
   xoffset = 0.39145470225916, yoffset = 0.79412224886668 };

local ZoomScale = {};
ZoomScale[0] = { xscale = 10448.3, yscale = 7072.7 };
ZoomScale[1] = { xscale = 12160.5, yscale = 8197.8 };
ZoomScale[2] = { xscale = 14703.1, yscale = 9825.0 };
ZoomScale[3] = { xscale = 18568.7, yscale = 12472.2 };
ZoomScale[4] = { xscale = 24390.3, yscale = 15628.5 };
ZoomScale[5] = { xscale = 37012.2, yscale = 25130.6 };

local function GetSTVPosition()
   local x, y = GetPlayerMapPosition("player");
   x = (x * STVInfo.scale) + STVInfo.xoffset;
   y = (y * STVInfo.scale) + STVInfo.yoffset;
   return x, y;
end

-- stolen directly from GuildMap
local function GetAngleIcon(x, y)
   local angle = asin(x / 57);
   if (x <= 0 and y <= 0) then
      angle = 180 - angle;
   elseif (x <= 0 and y > 0) then
      angle = 360 + angle;
   elseif (x > 0 and y >= 0) then
      angle = angle;
   else
      angle = 180 - angle;
   end
   local fileNumber = math.floor((angle / 10) + 0.5) * 10;
   if (fileNumber == 360) then
      fileNumber = 0;
   end
   return ICONPATH.."MiniMapArrow"..fileNumber;
end

local function PlotPOI(index, x, y)
   local poi = getglobal("FishingExtravaganzaMini"..index);
   if ( poi ) then
      if ( x and y ) then
         local tex = getglobal("FishingExtravaganzaMini"..index.."Texture");
         local zoom = ZoomScale[Minimap:GetZoom()];
         x = x * zoom.xscale;
         y = y * zoom.yscale;
         local dist = math.sqrt(x*x + y*y);
         if ( dist > 56.5 ) then
            x = x * 57 / dist;
            y = y * 57 / dist;
            tex:SetTexture(GetAngleIcon(x, y));
            tex:SetTexCoord(0.0, 1.0, 0.0, 1.0);
         else
            tex:SetTexture("Interface\\Minimap\\ObjectIcons");
            tex:SetTexCoord(0.0, 0.25, 0.25, 0.5);
         end
         poi:SetPoint("CENTER", "MinimapCluster", "TOPLEFT", 107 + x, y - 92);
         poi:Show();
         return true;
      else
         poi:Hide();
      end
   end
   return false;
end

local function CloseEnough(x1, y1, x2, y2)
   local zoom = Minimap:GetZoom();
   local x = (x1 - x2) * ZoomScale[zoom].xscale;
   local y = (y1 - y2) * ZoomScale[zoom].yscale;
   if (sqrt( (x * x) + (y * y) ) > 56.5) then
      return; -- false
   end
   return true;
end

local function GetMinimapDistance(x1, y1, x2, y2)
   local zoom = ZoomScale[Minimap:GetZoom()];
   local dx = (x1 - x2) * zoom.xscale;
   local dy = (y1 - y2) * zoom.yscale;
   return math.sqrt(dx*dx+dy*dy);
end

local function FindClosest(row, x, y)
   local dist;
   local didx;
   for idx=1,table.getn(row) do
      local t = row[idx];
      local dx = (t.x - x);
      local dy = (t.y - y);
      local d = dx*dx + dy*dy;
      if ( not dist ) then
         dist = d;
         didx = idx;
      elseif ( d < dist ) then
         dist = d;
         didx = idx;
      end
   end
   if ( dist and didx ) then
      local t = row[didx];
      dist = GetMinimapDistance(t.x, t.y, x, y);
   end
   return didx, dist;
end

local function GetNearestTen(x, y, dir)
   local r = math.floor(y * 100);
   local found = 1;
   local limit = 10;
   local locations = {};
   if ( FishingBuddy_Info["Schools"] ) then
      while ( r >=0 and r <100 ) do
         local iy = string.format("%d", r);
         local dist;
         local row = FishingBuddy_Info["Schools"][iy];
         if ( row ) then
            local rowsize = table.getn(row);
            if ( rowsize > 5 and limit < 11 ) then
               limit = limit + rowsize - 5;
            end
            for idx=1,rowsize do
               local t = row[idx];
               local dist = GetMinimapDistance(t.x, t.y, x, y);
               tinsert(locations, { dist = dist, x = t.x, y = t.y });
               found = found + 1;
               if ( found >= limit ) then
                  return locations;
               end
            end
         end
         r = r + dir;
      end
   end
   return locations;
end

-- save a school location
local function MarkSchool()
   if ( not FishingBuddy_Info["Schools"] ) then
      FishingBuddy_Info["Schools"] = {};
   end
   local x, y = GetSTVPosition();
   local iy = string.format("%d", y * 100);
   if ( not FishingBuddy_Info["Schools"][iy] ) then
      FishingBuddy_Info["Schools"][iy] = { { x = x, y = y } };
   else
      local idx, dist = FindClosest(FishingBuddy_Info["Schools"][iy], x, y);
      if ( dist > CLOSEENOUGH ) then
         tinsert(FishingBuddy_Info["Schools"][iy], { x = x, y = y });
         STVUpdateTimer = 0;
      else
         -- average something? that will cascade, which might be okay
         -- or do we store them all during the contest and average later?
         -- i.e. store 'close ones' in a separate place and then clean up
         -- later
      end
   end
end

-- let an external entity forcibly mark a school
FishingBuddy.Extravaganza.MarkSchool = function()
   local zone, subzone = FishingBuddy.GetZoneInfo();
   if ( zone == FishingBuddy.STVZONENAME ) then
      MarkSchool();
   end
end

-- Sunday, 2pm
local STVDay = "0";
local STVStartHour = 14;

-- Should we display the extravaganza message?
local function IsTime(activate)
   local showit = false;
   if ( FishingBuddy.IsLoaded() ) then
      if ( FishingBuddy.GetSetting("STVTimer") == 1 ) then
	 local mhour = date("%H");
         local hour,minute = GetGameTime();
         local day = date("%w");
         -- Is it Sunday?
         if ( day == STVDay and
             (hour >= (STVStartHour-2) and hour <(STVStartHour+2))) then
            showit = true;
         end
      end
   end
   if ( showit ) then
      if ( activate ) then
         FishingExtravaganzaFrame:Show();
      end
   elseif ( FishingExtravaganzaFrame:IsVisible() or
            FishingExtravaganzaMini1:IsVisible() ) then
      FishingExtravaganzaFrame:Hide();
      for idx=1,NUMMINIPOIS do
         PlotPOI(idx);
      end
   end
   return showit;
end
FishingBuddy.Extravaganza.IsTime = IsTime;

local function UpdatePOI()
   local x, y = GetSTVPosition();
   local loc1 = GetNearestTen(x, y, -1);
   local loc2 = GetNearestTen(x, y+0.01, 1);
   local func = function(a, b) return a.dist < b.dist; end;
   for idx=1,table.getn(loc2) do
      tinsert(loc1, loc2[idx]);
   end
   table.sort(loc1, func);
   for idx=1,NUMMINIPOIS do
      local t = loc1[idx];
      if ( t ) then
         PlotPOI(idx, t.x - x, y - t.y);
      else
         PlotPOI(idx);
      end
   end
end

-- Check for mouse down event for dragging frame.
FishingBuddy.Extravaganza.OnDragStart = function(arg1)
   if (arg1 == "LeftButton") then
      FishingExtravaganzaFrame:StartMoving();
      FishingExtravaganzaFrame.isMoving = true;
   end
end

-- Check for drag stop event to stop dragging.
FishingBuddy.Extravaganza.OnDragStop = function(arg1)
   if (arg1 == "LeftButton") then
      FishingExtravaganzaFrame:StopMovingOrSizing();
      FishingExtravaganzaFrame.isMoving = false;
   end
end

-- Handle watching the loot
FishingBuddy.Extravaganza.OnLoad = function()
   this:RegisterEvent("PLAYER_LOGIN");
   this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
   this:RegisterEvent("VARIABLES_LOADED");

   this:RegisterForDrag("LeftButton");
   this:Hide();
end

FishingBuddy.Extravaganza.OnEvent = function()
   local zone, subzone = FishingBuddy.GetZoneInfo();
   if ( event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_LOGIN" ) then
      if ( zone == FishingBuddy.STVZONENAME and IsTime() ) then
	 this:RegisterEvent("LOOT_OPENED");
	 this:RegisterEvent("MINIMAP_UPDATE_ZOOM");
      else
	 this:UnregisterEvent("LOOT_OPENED");
	 this:UnregisterEvent("MINIMAP_UPDATE_ZOOM");
      end
   elseif ( event == "LOOT_OPENED" ) then
      if ( IsFishingLoot()) then
         for index = 1, GetNumLootItems(), 1 do
            if (LootSlotIsItem(index)) then
               local fishlink = GetLootSlotLink(index);
               local _, id, _ = FishingBuddy.SplitFishLink(fishlink);
               if ( ExtravaganzaFish[id] ) then
                  MarkSchool();
                  STVUpdateTimer = 0;
                  if ( id == tastyfish_id ) then
                     numCaught = numCaught + 1;
                  end
               end
            end
         end
      end
   elseif ( event == "MINIMAP_UPDATE_ZOOM" ) then
      if ( zone == FishingBuddy.STVZONENAME ) then
         if ( FishingBuddy.GetSetting("STVTimer") == 1 ) then
	    UpdatePOI();
	 end
      end
   elseif ( event == "VARIABLES_LOADED" ) then
      local _,_,_,_,_,n = FishingBuddy.GetFishie(tastyfish_id);
      if ( n ) then
         tastyfish = n;
      else
         tastyfish = FISH;
      end
      IsTime(true);
      this:UnregisterEvent("VARIABLES_LOADED");
   end
end

FishingBuddy.Extravaganza.OnUpdate = function(elapsed)
   if ( IsTime() ) then
      if ( not FishingExtravaganzaFrame:IsVisible() ) then
         FishingExtravaganzaFrame:Show();
      end
      STVUpdateTimer = STVUpdateTimer - elapsed;
      if ( STVUpdateTimer < 0 ) then
         local hour,minute = GetGameTime();
         local minleft;
         local checkhour = STVStartHour;
         local line;
         if ( hour >= STVStartHour ) then
            line = FishingBuddy.TIMELEFT;
            checkhour = checkhour + 2;
         else
            line = FishingBuddy.TIMETOGO;
         end
         minleft = (checkhour - hour)*60 - minute;
         if ( minleft > 0 ) then
            FishingExtravaganzaFrameButtonText:SetTextColor(0.1, 1.0, 0.1);
            if ( minleft < 10 ) then
               FishingExtravaganzaFrameButtonText:SetTextColor(1.0, 0.1, 0.1);
            end
            line = string.format(line, minleft/60, math.mod(minleft, 60),
                                 numCaught, tastyfish);
            FishingExtravaganzaFrameButtonText:SetText(line);
            local width = FishingExtravaganzaFrameButtonText:GetWidth();
            FishingExtravaganzaFrame:SetWidth(width + 16);
            UpdatePOI();
            if ( FishingBuddy_Info["Schools"] ) then
               STVUpdateTimer = UPDATETIME_SCHOOLS;
            else
               STVUpdateTimer = UPDATETIME_COUNTER;
            end
         end
      end
   else
      FishingExtravaganzaFrame:Hide();
   end
end

local function GetObjectCoords(poi, index, numcolumns, texturewidth)
   local width = poi:GetWidth();
   local xCoord1, xCoord2, yCoord1, yCoord2; 
   local coordIncrement = width / texturewidth;
   xCoord1 = mod(index , numcolumns) * coordIncrement;
   xCoord2 = xCoord1 + coordIncrement;
   yCoord1 = floor(index / numcolumns) * coordIncrement;
   yCoord2 = yCoord1 + coordIncrement;
   return xCoord1, xCoord2, yCoord1, yCoord2;
end

local start = 0;
-- debugging routines
FishingBuddy.Extravaganza.Debug = function(day, hour, zone)
   STVDay = day;
   STVStartHour = hour;
   if ( zone ) then
      FishingBuddy.STVZONENAME = zone;
   end
   IsTime(true);
end

FishingBuddy.Extravaganza.Dump = function()
   local x, y = GetSTVPosition();
   local iy = string.format("%d", y * 100);

   FishingBuddy.Print("Current location: %d - %f, %f", iy, x, y);

   if ( FishingBuddy_Info["Schools"][iy] ) then
      for idx=1,table.getn(FishingBuddy_Info["Schools"][iy]) do
         local t = FishingBuddy_Info["Schools"][iy][idx];
         local dist = GetMinimapDistance(t.x, t.y, x, y);
         FishingBuddy.Print("Distance: %f", dist);
      end
   end
end

-- eventually, display what fish you caught here
FishingBuddy.Extravaganza.MiniMap_OnEnter = function()
end

