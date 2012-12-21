-- Handle displaying all the fish in their habitats

FishingBuddy.Locations = {};

local NUM_THINGIES_DISPLAYED = 20;
FishingBuddy.Locations.FRAME_THINGIEHEIGHT = 16;

local Collapsed = false;
local LocationLineSelected = 0;
local LocationLines = {};
local LocationLastLine = 1;

local function MakeInfo(line, level, collapsible, expanded, hasicon, text, extra, index, id)
   if ( not LocationLines[line] ) then
      LocationLines[line] = {};
   end
   LocationLines[line].level = level;
   LocationLines[line].collapsible = collapsible;
   LocationLines[line].expanded = expanded;
   LocationLines[line].hasicon = hasicon;
   LocationLines[line].text = text;
   LocationLines[line].extra = extra;
   if ( index ) then
      LocationLines[line].index = index;
   else
      LocationLines[line].index = text;
   end
   LocationLines[line].id = id;
   LocationLines[line].valid = true;
end

local function CountLocationLines()
   local linecount = 0;
   local j = 1;
   local limit = LocationLastLine;
   while ( j <= limit ) do
      local info = LocationLines[j];
      j = j + 1;
      if ( info and info.valid ) then
	 linecount = linecount + 1;
         if ( info.collapsible and not info.expanded ) then
            local i2 = LocationLines[j];
	    while ( i2 and (i2.level > info.level) ) do
	       j = j + 1;
	       i2 = LocationLines[j];
            end
	 end	 
      end
   end
   -- there's a zero-based vs. one-based bug here, somewhere
   if ( linecount > NUM_THINGIES_DISPLAYED and
       limit >= table.getn(LocationLines)) then
      linecount = linecount + 1;
   end
--   FishingBuddy.Debug("Count "..linecount.." limit "..limit);
   return linecount;
end

local function FishiesChanged()
   local fh = FishingBuddy_Info["FishingHoles"];
   local ff = FishingBuddy_Info["Fishies"];
   local line = 1
   local fishcount = table.getn(FishingBuddy.SortedFishies);
   local zonetotals = {};

   for i=1,fishcount,1 do
      local fishid = FishingBuddy.SortedFishies[i].id;
      local fishname = ff[fishid].name;
      local locsort = {};
      local total = 0;
      for zone in FishingBuddy.ByFishie[fishid] do
	 if ( not zonetotals[zone] ) then
	    local fi = nil;
	    for z in fh do
	       if ( fh[z][zone] ) then
		  fi = fh[z][zone];
		  break;
	       end
	    end
	    if ( fi ) then
	       local tot = 0;
	       for f in fi do
		  tot = tot + fi[f];
	       end
	       zonetotals[zone] = tot;
	    end
	 end
	 local count = FishingBuddy.ByFishie[fishid][zone];
	 local info = {};
	 info.text = zone;
	 info.count = count;
	 info.total = zonetotals[zone];
	 if ( not info.total or info.total == 0) then
	    info.total = 1;
	 end
	 tinsert(locsort, info);
	 total = total + count;
      end
      local extra = " ("..total.." total";
      if ( ff[fishid].level ) then
	 extra = extra..", "..ff[fishid].level;
      end
      extra = extra..")";
      MakeInfo(line, 0, true, true, true, fishname, extra, nil, fishid);
      line = line + 1;
      FishingBuddy.FishSort(locsort);
      for j=1,table.getn(locsort),1 do
	 local zone = locsort[j].text;
	 local amount = locsort[j].count;
	 local total = locsort[j].total;
	 local percent = format("%.1f", ( amount / total ) * 100);
	 MakeInfo(line, 1, false, false, false, zone, " ("..amount..", "..percent.."%)");
	 line = line + 1;
      end
   end
   LocationLastLine = line;
end

local function BothLocationsChanged()
   local fh = FishingBuddy_Info["FishingHoles"];
   local ff = FishingBuddy_Info["Fishies"];
   local sorted = FishingBuddy.SortedZones;
   local line = 1;
   local zonecount = table.getn(sorted);
   for i=1,zonecount,1 do
      local zone = sorted[i];
      local where = zone;
      MakeInfo(line, 0, true, true, false, zone, nil, where);
      line = line + 1;
      local subsorted = FishingBuddy.SortedByZone[zone];
      local subcount = table.getn(subsorted);
      for s=1,subcount,1 do
	 local subzone = subsorted[s];
	 local count, total = FishingBuddy.FishCount(zone, subzone);
	 where = zone.."."..subzone;
	 local extra = " ("..count.." types, "..total.." total)";
	 if ( FishingBuddy_Info["FishingSkill"][zone] and FishingBuddy_Info["FishingSkill"][zone][subzone] ) then
	    extra = extra.." ["..FishingBuddy_Info["FishingSkill"][zone][subzone].."]";
	 end
	 if ( fh[zone][subzone] ) then
	    MakeInfo(line, 1, true, true, false,  subzone, extra, where);
	    line = line + 1;
	    local fishsort = {};
	    for fishid in fh[zone][subzone] do
	       local info = {};
	       info.id = fishid;
	       info.text = ff[fishid].name;
	       info.count = fh[zone][subzone][fishid];
	       tinsert(fishsort, info);
	    end
	    FishingBuddy.FishSort(fishsort);
	    for j=1,table.getn(fishsort),1 do
	       local fishie = fishsort[j].text;
	       local id = fishsort[j].id;
	       local amount = fishsort[j].count;
	       local percent = format("%.1f", ( amount / total ) * 100);
	       MakeInfo(line, 2, false, false, true, fishie, " ("..percent.."%)", nil, id);
	       line = line + 1;
	    end
	 end
      end
   end
   LocationLastLine = line;
end

local function SubZonesChanged()
   local fh = FishingBuddy_Info["FishingHoles"];
   local ff = FishingBuddy_Info["Fishies"];
   local mapping = {};
   for zone in fh do
      for subzone in fh[zone] do
	 mapping[subzone] = zone;
      end
   end
   local line = 1;
   local zonecount = table.getn(FishingBuddy.SortedSubZones);
   for i=1,zonecount,1 do
      local subzone = FishingBuddy.SortedSubZones[i];
      local zone = mapping[subzone];
      local extra = nil;
      if ( FishingBuddy_Info["FishingSkill"][zone] and FishingBuddy_Info["FishingSkill"][zone][subzone] ) then
	 extra = " ["..FishingBuddy_Info["FishingSkill"][zone][subzone].."]";
      end
      MakeInfo(line, 0, true, true, false, subzone, extra);
      line = line + 1;
      local zone = mapping[subzone];
      local count, total = FishingBuddy.FishCount(zone, subzone);
      local fishsort = {};
      for fishid in fh[zone][subzone] do
	 local info = {};
	 info.id = fishid;
	 info.text = ff[fishid].name;
	 info.count = fh[zone][subzone][fishid];
	 tinsert(fishsort, info);
      end
      FishingBuddy.FishSort(fishsort);
      for j=1,table.getn(fishsort),1 do
	 local id = fishsort[j].id;
	 local fishie = fishsort[j].text;
	 local amount = fishsort[j].count;
	 local percent = format("%.1f", ( amount / total ) * 100);
	 MakeInfo(line, 1, false, false, true, fishie, " ("..percent.."%)", nil, id);
	 line = line + 1;
      end
   end
   LocationLastLine = line;
end

local function LinesChanged()
   if ( FishingBuddy.GetSetting("GroupByLocation") == 1 ) then
      if ( FishingBuddy.GetSetting("ShowLocationZones") == 1 ) then
	 BothLocationsChanged();
      else
	 SubZonesChanged();
      end
   else
      FishiesChanged();
   end
   for i=LocationLastLine,table.getn(LocationLines) do
      local info = LocationLines[i];
      if ( info ) then
         info.valid = false;
      end
   end
   FishingLocationsFrame.valid = true;
end

-- local MOUSEWHEEL_DELAY = 0.1;
-- local lastScrollTime = nil;
-- function FishingLocationsFrame_OnMouseWheel(value)
--    local now = GetTime();
--    if ( not lastScrollTime ) then
--       lastScrollTime = now - 0.2;
--    end
--    if ( (now - lastScrollTime) > MOUSEWHEEL_DELAY ) then
--       -- call the old mouse wheel function somehow?
--    end
-- end

function FishingLocationsFrame_SetSelection(id, line)
   local info = LocationLines[line];
   FishingLocationHighlightFrame:Hide();
   if info then
      if ( info.collapsible ) then
	 info.expanded = not info.expanded;
      else
	 LocationLineSelected = line;
	 FishingLocationHighlightFrame:SetPoint ( "TOPLEFT" ,  getglobal("FishingLocations"..id):GetName() , "TOPLEFT" , 5 , 0 )
	 FishingLocationHighlightFrame:Show()
      end
   end
end

function FishingLocationsFrame_MoveButtonText(i, what)
   local relativeTo = "FishingLocations"..i..what;
   local textfield = getglobal("FishingLocations"..i.."Text");
   textfield:SetPoint("LEFT", relativeTo, "RIGHT", 2, 0);
   textfield = getglobal("FishingLocations"..i.."HighlightText");
   textfield:SetPoint("LEFT", relativeTo, "RIGHT", 2, 0);
end

FishingBuddy.Locations.Update = function(forced)
   if ( not FishingLocationsFrame:IsVisible() ) then
      return;
   end

   if ( forced or not FishingLocationsFrame.valid ) then
      LinesChanged();
   end

   local offset = FauxScrollFrame_GetOffset(FishingLocsScrollFrame);
   FauxScrollFrame_Update( FishingLocsScrollFrame, CountLocationLines(),
			  NUM_THINGIES_DISPLAYED,
			  FishingBuddy.Locations.FRAME_THINGIEHEIGHT );

   local lastlevel = 0;
   FishingLocationHighlightFrame:Hide();
   local j = 1;
   local o = 1;
   while ( o < offset ) do
      local info = LocationLines[j];
      if ( info ) then
         j = j + 1;
         o = o + 1;
         if ( info.collapsible and not info.expanded ) then
	    local i2 = LocationLines[j];
	    while ( i2 and i2.level > info.level ) do
               j = j + 1;
	       i2 = LocationLines[j];
	    end
         end
      end
   end
   for i = 1,NUM_THINGIES_DISPLAYED,1 do
      local locButton = getglobal ( "FishingLocations"..i );
      if ( LocationLines[j] ) then
	 local icon = getglobal("FishingLocations"..i.."Icon");
	 local icontex = getglobal("FishingLocations"..i.."IconTexture");
	 local info = LocationLines[j];
         locButton.id = i;
         locButton.line = j;

	 local leveloffset = (info.level - lastlevel)*16;
	 if ( i == 1 ) then
	    locButton:SetPoint("TOPRIGHT", "FishingLocsScrollFrame", "TOPLEFT", leveloffset, 0);
	 else
	    local t = i - 1;
	    locButton:SetPoint("TOPLEFT", "FishingLocations"..t, "BOTTOMLEFT", leveloffset, 0);
	 end
	 lastlevel = info.level;

	 local text = info.text;
	 if text and info.extra then
	    text = text .. info.extra;
	 end

	 locButton:SetText( text );
	 icon:ClearAllPoints();
	 if ( info.collapsible ) then
	    icon:SetPoint("LEFT", "FishingLocations"..i, "LEFT", 21, 0);
	    locButton:SetTextColor( 1, 0.82, 0 );
	    if ( info.expanded ) then
	       locButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
	    else
	       locButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
	    end
	    getglobal("FishingLocations"..i.."Highlight"):SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight");
	    getglobal("FishingLocations"..i):UnlockHighlight();
	 else
	    icon:SetPoint("LEFT", "FishingLocations"..i, "LEFT", 3, 0);
	    locButton:SetTextColor( .5, .5, .5 );
	    locButton:SetNormalTexture("");
	    getglobal("FishingLocations"..i.."Highlight"):SetTexture("");
	    -- Place the highlight and lock the highlight state
	    if ( LocationLineSelected == j ) then
	       FishingLocationHighlightFrame:SetPoint("TOPLEFT", "FishingLocations"..i, "TOPLEFT", 21, 0);
	       FishingLocationHighlightFrame:Show();
	       locButton:LockHighlight();
	    else
	       locButton:UnlockHighlight();
	    end
	 end

	 locButton.tooltip = nil;
	 if ( info.hasicon ) then
	    local item, texture, _, _, _ = FishingBuddy.GetFishie(info.id);
	    locButton.item = item;
	    locButton.name = info.text;
	    if( texture ) then
	       icontex:SetTexture(texture);
	       icon:Show();
	       icontex:Show();
	    end
	    FishingLocationsFrame_MoveButtonText(i, "Icon");
	 else
	    locButton.item = nil;
	    locButton.name = nil;
	    icontex:SetTexture("");
	    icontex:Hide();
	    icon:Hide();
	    FishingLocationsFrame_MoveButtonText(i, "Highlight");
	 end
	 locButton:Show();
	 j = j + 1;
	 if ( info.collapsible and not info.expanded ) then
	    local i2 = LocationLines[j];	    
	    while ( i2 and (i2.level > info.level) ) do
	       j = j + 1;
	       i2 = LocationLines[j];
	    end
	 end
      else
	 locButton:Hide();
         locButton.id = nil;
         locButton.line = nil;
      end
   end

   if LocationLines then
      -- Set the expand/collapse all button texture
      local numHeaders = 0;
      local notExpanded = 0;
      for i=1,table.getn(LocationLines),1 do
	 local j = i + offset;
	 local info = LocationLines[j];
	 if ( info and info.collapsible ) then
	    numHeaders = numHeaders + 1;
	    if ( not info.expanded ) then
	       notExpanded = notExpanded + 1;
	    end
	 end
      end
      FishingLocationsCollapseAllButton:Show();
      -- If all headers are not expanded then show collapse button, otherwise show the expand button
      if ( notExpanded ~= numHeaders ) then
	 Collapsed = false;
	 FishingLocationsCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
      else
	 Collapsed = true;
	 FishingLocationsCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
      end
   else
      FishingLocationsCollapseAllButton:Hide();
   end
end

FishingBuddy.Locations.Button_OnClick = function(button)
   if ( button == "LeftButton" ) then
      if( IsShiftKeyDown() and this.item ) then
	 FishingBuddy.ChatLink(this.item, this.name, this.color);
      elseif ( this.id and this.line ) then
	 FishingLocationsFrame_SetSelection(this.id, this.line);
	 FishingBuddy.Locations.Update();
      end
   end
end

function FishingLocationsCollapseAllButton_OnClick()
   if not Collapsed then
      FishingLocsScrollFrameScrollBar:SetValue(0);
      LocationLineSelected = 1;
   end
   for _,info in LocationLines do
      info.expanded = Collapsed;
   end
   Collapsed = not Collapsed;
   FishingBuddy.Locations.Update();
end

FishingBuddy.Locations.Button_OnEnter = function()
   if( GameTooltip.finished ) then
      return;
   end
   if( this.item or this.tooltip ) then
      GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
      if ( this.item and this.item ~= "" ) then
	 local link = "item:"..this.item;
	 local n,l,_,_,_,_,_,_ = GetItemInfo(link);
	 if ( n and l ) then
	    GameTooltip:SetHyperlink(link);
	 else
	    this.tooltip = {}
	    this.tooltip[1] = { ["text"] = this.name };
	    this.tooltip[2] = { ["text"] = FishingBuddy.NOTLINKABLE, ["r"] = 1.0, ["g"] = 0, ["b"] = 0 };
	    FishingBuddy.AddTooltip(this.tooltip);
	    this.item = nil;
	 end
      elseif ( this.tooltip ) then
	 FishingBuddy.AddTooltip(this.tooltip, 1, 1, 1);
      end
      GameTooltip.finished = 1;
      GameTooltip:Show();
   end
end

FishingBuddy.Locations.Button_OnLeave = function()
   GameTooltip.finished = nil;
   if( this.item or this.tooltip ) then
      GameTooltip:Hide();
   end
end

FishingBuddy.Locations.DisplayChanged = function()
   FishingLocsScrollFrameScrollBar:SetValue(0);
   LocationLineSelected = 1;
   FishingBuddy.Locations.Update(true);
end

FishingBuddy.Locations.SwitchDisplay = function()
   -- backwards logic check, we're about to change...
   if ( FishingBuddy.GetSetting("GroupByLocation") == 1 ) then
      FishingLocationsSwitchButton:SetText(FishingBuddy.SHOWLOCATIONS);
      FishingBuddyOptionSLZ:Hide();
      FishingBuddy.SetSetting("GroupByLocation", 0);
   else
      FishingLocationsSwitchButton:SetText(FishingBuddy.SHOWFISHIES);
      FishingBuddyOptionSLZ:Show();
      FishingBuddy.SetSetting("GroupByLocation", 1);
   end
   FishingBuddy.Locations.DisplayChanged();
end

FishingBuddy.Locations.SwitchButton_OnEnter = function()
   if ( FishingBuddy.GetSetting("GroupByLocation") == 1 ) then
      GameTooltip:SetText(FishingBuddy.SHOWFISHIES_INFO);
   else
      GameTooltip:SetText(FishingBuddy.SHOWLOCATIONS_INFO);
   end
   GameTooltip:Show();
end

FishingBuddy.Locations.OnLoad = function()
   this:RegisterEvent("VARIABLES_LOADED");
   FishingLocationsSwitchButton:SetText(FishingBuddy.SHOWFISHIES);
   -- Set up checkbox
   FishingBuddyOptionSLZ.name = "ShowLocationZones";
   FishingBuddyOptionSLZ.text = FishingBuddy.CONFIG_SHOWLOCATIONZONES_ONOFF;
   FishingBuddyOptionSLZ.tooltip = FishingBuddy.CONFIG_SHOWLOCATIONZONES_INFO;
end

FishingBuddy.Locations.OnShow = function()
   if ( FishingBuddy.IsLoaded() ) then
      FishingBuddy.Locations.Update();
   end
end

FishingBuddy.Locations.OnEvent = function()
   -- this crashes the client when enabled
   -- this:EnableMouseWheel(0);
end

FishingBuddy.FishCount = function(zone, subzone)
   local count = 0;
   local total = 0;
   local fh = FishingBuddy_Info["FishingHoles"];
   if( fh[zone] and fh[zone][subzone] ) then
      for fishie in fh[zone][subzone] do
	 count = count + 1;
	 total = total + fh[zone][subzone][fishie];
      end
   end
   return count, total;
end

FishingBuddy.Locations.DataChanged = function(zone, subzone, fishie)
   FishingLocationsFrame.valid = false;   
end
