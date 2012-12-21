-- Display the fish you're catching and/or have caught in a live display

FishingBuddy.WatchFrame = {};

local MAX_FISHINGWATCH_LINES = 20;
local WATCHDRAGGER_SHOW_DELAY = 0.2;

local WATCHDRAGGER_FADE_TIME = 0.15;

local DRAGFRAME_TEXTURES = {
	"Background",
	"TopLeft",
	"TopRight",
	"BottomLeft",
	"BottomRight",
	"Top",
	"Bottom",
	"Left",
	"Right"
};

local function ShowDraggerFrame()
   if ( not FishingWatchDragFrame:IsVisible() ) then
      local width = FishingWatchFrame:GetWidth();
      local height = FishingWatchFrame:GetHeight();
      FishingWatchDragFrame:SetHeight(height);
      FishingWatchDragFrame:SetWidth(width);
      FishingWatchDragFrame:Show();
      for index, value in DRAGFRAME_TEXTURES do
         UIFrameFadeIn(getglobal("FishingWatchDragFrame"..value), WATCHDRAGGER_FADE_TIME, 0, 0.25);
      end
   end
end

local function HideDraggerFrame()
   if ( FishingWatchDragFrame:IsVisible() ) then
      for index, value in DRAGFRAME_TEXTURES do
         UIFrameFadeOut(getglobal("FishingWatchDragFrame"..value), WATCHDRAGGER_FADE_TIME, 0.25, 0);
      end
      FishingWatchDragFrame:Hide();
      local qx, qy = UIParent:GetCenter();
      local wx, wy = FishingWatchDragFrame:GetCenter();
      local where = {};
      where.x = qx - wx;
      where.y = wy - qy;
      FishingBuddy.SetSetting("WatcherLocation", where);
   end
end

FishingBuddy.Commands[FishingBuddy.WATCHER] = {};
FishingBuddy.Commands[FishingBuddy.WATCHER].help = FishingBuddy.WATCHER_HELP;
FishingBuddy.Commands[FishingBuddy.WATCHER].func =
   function(what)
      if ( what and ( what == FishingBuddy.RESET ) ) then
	 FishingWatchDragFrame:ClearAllPoints();
	 FishingWatchDragFrame:SetPoint("CENTER", "UIParent",
					"CENTER", 0, 0);
	 FishingWatchDragFrame:Hide();
	 FishingBuddy.SetSetting("WatcherLocation", nil);
	 return true;
      end
   end;

-- handle really old versions
local function UpdateUnknownZones(zone, subzone)
   if ( FishingBuddy_Info["FishingHoles"][FishingBuddy.UNKNOWN] ) then
      if ( FishingBuddy_Info["FishingHoles"][FishingBuddy.UNKNOWN][subzone] ) then
	 if ( not FishingBuddy_Info["FishingHoles"][zone] ) then
	    FishingBuddy_Info["FishingHoles"][zone] = { };
	    tinsert(FishingBuddy.SortedZones, zone);
	    table.sort(FishingBuddy.SortedZones);
	 end
	 if ( not FishingBuddy_Info["FishingHoles"][zone][subzone] ) then
	    FishingBuddy_Info["FishingHoles"][zone][subzone] = { };
	 end
	 for k,v in FishingBuddy_Info["FishingHoles"][FishingBuddy.UNKNOWN][subzone] do
	    FishingBuddy_Info["FishingHoles"][zone][subzone][k] = v;
	 end
	 FishingBuddy_Info["FishingHoles"][FishingBuddy.UNKNOWN][subzone] = nil;
      end
      FishingBuddy.Locations.DataChanged(zone, subzone);
      -- Duh, table.getn doesn't work because there aren't any integer
      -- keys in this table
      if ( next(FishingBuddy_Info["FishingHoles"][FishingBuddy.UNKNOWN]) == nil ) then
	 FishingBuddy_Info["FishingHoles"][FishingBuddy.UNKNOWN] = nil;
	 local pos;
	 while ( pos < table.getn(FishingBuddy.SortedZones) ) do
	    if ( FishingBuddy.SortedZones[pos] == FishingBuddy.UNKNOWN ) then
	       break;
	    end
	    pos = pos + 1;
	 end
	 tremove(FishingBuddy.SortedZones, pos);
      end
   end
end

-- fix a bug where we were recording 'GetZoneText' instead
-- of 'GetRealZoneText'
local function UpdateRealZones(zone, subzone)
   local oldzone = GetZoneText();
   if ( FishingBuddy_Info["FishingHoles"][oldzone] and oldzone ~= zone ) then
      if ( not FishingBuddy_Info["FishingHoles"][zone] ) then
	 FishingBuddy_Info["FishingHoles"][zone] = { };
      end
      for oldsubzone in FishingBuddy_Info["FishingHoles"][oldzone] do
	 local sub = oldsubzone;
	 if ( oldsubzone == oldzone ) then
	    sub = subzone;
	 end
	 if ( not FishingBuddy_Info["FishingHoles"][zone][sub] ) then
	    FishingBuddy_Info["FishingHoles"][zone][sub] = {};
	 end
	 for k,v in FishingBuddy_Info["FishingHoles"][oldzone][oldsubzone] do
	    FishingBuddy_Info["FishingHoles"][zone][sub][k] = v;
	 end
      end
      FishingBuddy_Info["FishingHoles"][oldzone] = nil;
   end
end

-- Fish watcher functions
FishingBuddy.WatchUpdate = function()
   if ( FishingWatchFrame:IsVisible() ) then
      FishingWatchFrame:Hide();
      for i=1, MAX_FISHINGWATCH_LINES, 1 do
         local line = getglobal("FishingWatchLine"..i);
         line:Hide();
      end
   end

   local zone, subzone = FishingBuddy.GetZoneInfo();

   UpdateUnknownZones(zone, subzone);
   UpdateRealZones(zone, subzone);

   local fz = FishingBuddy_Info["FishingHoles"][zone];
   if ( FishingBuddy.GetSetting("WatchFishies") == 0 or
        not fz or not fz[subzone] ) then
      return;
   end

   if ( FishingBuddy.GetSetting("WatchOnlyWhenFishing") == 1 and
       not FishingBuddy.IsFishingPole() ) then
      return;
   end

   local current = FishingBuddy.currentFishies;
   local ff = FishingBuddy_Info["Fishies"];
   local fishsort = {};
   local totalCount = 0;
   local totalCurrent = 0;
   local gotDiffs = false;
   for fishid in fz[subzone] do
      local info = {};
      info.text = ff[fishid].name;
      info.count = fz[subzone][fishid];
      totalCount = totalCount + info.count;
      if ( current[subzone] ) then
         info.current = current[subzone][fishid] or 0;
      else
         info.current = 0;
      end
      if ( info.current > 0 and info.current ~= info.count ) then
         gotDiffs = true;
      end
      totalCurrent = totalCurrent + info.current;
      tinsert(fishsort, info);
   end

   if ( totalCount == 0 ) then
      return;
   end

   FishingBuddy.FishSort(fishsort);

   local fishingWatchMaxWidth = 0;
   local tempWidth;
   local index = 1;
   local start = 1;
   local dopercent = FishingBuddy.GetSetting("WatchFishPercent");

   if ( FishingBuddy.GetSetting("WatchCurrentZone") == 1 ) then
      local entry = getglobal("FishingWatchLine"..index);
      local line = zone.." : "..subzone;
      entry:SetText(line);
      local tempWidth = entry:GetWidth();
      if ( tempWidth > fishingWatchMaxWidth ) then
	 fishingWatchMaxWidth = tempWidth;
      end
      entry:Show();
      index = index + 1;
   end
   if ( FishingBuddy.GetSetting("WatchCurrentSkill") == 1 ) then
      local entry = getglobal("FishingWatchLine"..index);
      local skill, mods = FishingBuddy.GetCurrentSkill();
      local line = "Skill: |cff00ff00"..skill.."+"..mods.."|r";
      if ( StartedFishing ) then
	 local elapsed = GetTime() - StartedFishing;
	 local t = math.floor(elapsed);
	 local seconds = math.mod(t, 60);
	 t = math.floor(t / 60);
	 local minutes = math.mod(t, 60);
	 local hours = math.floor(t / 60);
	 line = line.."  Elapsed: ";
	 if ( hours < 10 ) then
	    line = line.."0";
	 end
	 line = line..hours..":";
	 if ( minutes < 10 ) then
	    line = line.."0";
	 end
	 line = line..minutes..":";
	 if ( seconds < 10 ) then
	    line = line.."0";
	 end
	 line = line..seconds;
      end

      entry:SetText(line);
      local tempWidth = entry:GetWidth();
      if ( tempWidth > fishingWatchMaxWidth ) then
	 fishingWatchMaxWidth = tempWidth;
      end
      entry:Show();
      index = index + 1;
   end
   
   for j=1,table.getn(fishsort),1 do
      local info = fishsort[j];
      if( index <= MAX_FISHINGWATCH_LINES ) then
	 local entry = getglobal("FishingWatchLine"..index);
	 local fishie = info.text;
	 local amount = info.count;
	 local s,e = string.find(fishie, FishingBuddy.RAW.." ");
	 if ( s ) then
	    if ( s > 1 ) then
	       fishie = string.sub(fishie, 1, s-1)..string.sub(fishie, e+1);
	    else
	       fishie = string.sub(fishie, e+1);
	    end
	 else
	    s,e = string.find(fishie, " "..FishingBuddy.RAW);
	    if ( s ) then
	       fishie = string.sub(fishie, 1, s-1)..string.sub(fishie, e+1);
	    end
	 end
	 local fishietext = fishie.." ("..amount;
	 if ( dopercent == 1 ) then
	    local percent = format("%.1f", ( amount / totalCount ) * 100);
	    fishietext = fishietext.." : "..percent.."%";
	 end
         if ( gotDiffs ) then
            amount = info.current;
            local color;
            fishietext = fishietext..", |c"..FishingBuddy.Colors.GREEN..amount;
            if ( dopercent == 1 ) then
               local percent = format("%.1f", ( amount / totalCurrent ) * 100);
               fishietext = fishietext.." : "..percent.."%";
            end
            fishietext = fishietext.."|r";
         end
	 fishietext = fishietext..")";
	 entry:SetText(fishietext);
	 tempWidth = entry:GetWidth();
	 entry:Show();
	 if ( tempWidth > fishingWatchMaxWidth ) then
	    fishingWatchMaxWidth = tempWidth;
	 end
      end
      index = index + 1;
   end

   FishingWatchFrame:SetHeight(index * 13);
   FishingWatchFrame:SetWidth(fishingWatchMaxWidth + 10);
   FishingWatchFrame:Show();
end

FishingBuddy.WatchFrame.OnLoad = function()
   local where = FishingBuddy.GetSetting("WatcherLocation");
   if ( not where ) then
      where = {};
      where.x = 0;
      where.y = 0;
   end
   FishingWatchDragFrame:ClearAllPoints();
   FishingWatchDragFrame:SetPoint("CENTER", "UIParent", "CENTER",
				  where.x, where.y);
   FishingWatchDragFrame:Hide();

   this:ClearAllPoints();
   this:SetPoint("TOPRIGHT", "FishingWatchDragFrame", "TOPRIGHT", 0, 0);
end

local hover;
FishingBuddy.WatchFrame.OnUpdate = function(elapsed)
   if ( FishingWatchFrame:IsVisible() ) then
      if ( MouseIsOver(FishingWatchFrame) ) then
	 local xPos, yPos = GetCursorPosition();
	 if ( hover ) then
	    if ( hover.xPos == xPos and hover.yPos == yPos ) then
	       hover.hoverTime = hover.hoverTime + elapsed;
	    else
	       hover.hoverTime = 0;
	       hover.xPos = xPos;
	       hover.yPos = yPos;
	    end
	 else
	    hover = {};
	    hover.hoverTime = 0;
	    hover.xPos = xPos;
	    hover.yPos = yPos;
	 end
	 if ( hover.hoverTime > WATCHDRAGGER_SHOW_DELAY ) then
	    ShowDraggerFrame();
	 end
      else
	 HideDraggerFrame();
	 hover = nil;
      end
   elseif ( hover ) then
      HideDraggerFrame();
      hover = nil;
   end
end

