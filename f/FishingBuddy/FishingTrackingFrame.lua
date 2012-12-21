-- Handle tracking cycle fish

FishingBuddy.TrackingFrame = {};

local GRAPH_HEIGHT = 120;

local trackingWordMap = {
   ["WEEKLY"] = FishingBuddy.WEEKLY,
   ["HOURLY"] = FishingBuddy.HOURLY,
   [FishingBuddy.WEEKLY] = "WEEKLY",
   [FishingBuddy.HOURLY] = "HOURLY",
};

local byhours = {
   [13759] = {
      ["n"] = "Raw Nightfin Snapper",
      ["c"] = { r = 0.5, g = 0.5, b = 1.0, a = 0.75 },
   },
   [13760] = {
      ["n"] = "Raw Sunscale Salmon",
      ["c"] = { r = 0.8, g = 0.8, b = 0.1, a = 0.75 },
   },
};
local byweeks = {
   [13756] = {
      ["n"] = "Raw Summer Bass",
      ["c"] = { r = 1.0, g = 1.0, b = 0.0, a = 0.75 },
   },
   [13755] = {
      ["n"] = "Winter Squid",
      ["c"] = { r = 0.4, g = 0.1, b = 0.4, a = 0.75 },
   },
};

local function UntrackThis(id, name)
   if ( not byhours[id] and not byweeks[id] ) then
      for how in FishingBuddy_Info["FishTracking"] do
	 if ( FishingBuddy_Info["FishTracking"][how][id] ) then
	    FishingBuddy_Info["FishTracking"][how][id] = nil;
	    FishingBuddy.Print(FishingBuddy.NOTRACKMSG, name);
	 end
      end
   else
      FishingBuddy.Message(FishingBuddy.NOTRACKERRMSG);
   end
end

local function TrackThis(how, id, color, name)
   if ( not FishingBuddy_Info["FishTracking"][how] ) then
      FishingBuddy_Info["FishTracking"][how] = {};
   end
   local limit = 23;
   if ( how == "WEEKLY" ) then
      limit = 52;
   end
   if ( not FishingBuddy_Info["FishTracking"][how][id] ) then
      FishingBuddy_Info["FishTracking"][how][id] = {};
      FishingBuddy_Info["FishTracking"][how][id].data = {};
      for i=0,limit,1 do
	 FishingBuddy_Info["FishTracking"][how][id].data[i] = 0;
      end
      FishingBuddy_Info["FishTracking"][how][id].data.n = limit+1;
   end
   if ( name and not FishingBuddy_Info["FishTracking"][how][id].name ) then
      FishingBuddy_Info["FishTracking"][how][id].name = name;
   end
   if ( color ) then
      if ( type(color) == "string") then
	 local a = tonumber(string.sub(color,1,2),16);
	 local r = tonumber(string.sub(color,3,4),16);
	 local g = tonumber(string.sub(color,5,6),16);
	 local b = tonumber(string.sub(color,7,8),16);
	 color = { a = a, r = r, g = g, b = b };
      end
      FishingBuddy_Info["FishTracking"][how][id].color = color;
   end
end

FishingBuddy.Commands[FishingBuddy.TRACK] = {};
FishingBuddy.Commands[FishingBuddy.TRACK].args = {};
FishingBuddy.Commands[FishingBuddy.TRACK].args[1] = "[%w]+";
FishingBuddy.Commands[FishingBuddy.TRACK].args[2] = "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[.-%]|h|r";
FishingBuddy.Commands[FishingBuddy.TRACK].help = FishingBuddy.TRACKING_HELP;
FishingBuddy.Commands[FishingBuddy.TRACK].func =
   function(how, fishlink)
      if ( how and (how == FishingBuddy.HOURLY or
		     how == FishingBuddy.WEEKLY)) then
	 local c, i, n = FishingBuddy.SplitFishLink(fishlink);
	 if ( i ) then
	    TrackThis(trackingWordMap[how], i, c, n);
	    FishingBuddy.Print(FishingBuddy.TRACKINGMSG, n, how);
	    return true;
	 end
      end
   end;
FishingBuddy.Commands[FishingBuddy.NOTRACK] = {};
FishingBuddy.Commands[FishingBuddy.NOTRACK].args = {};
FishingBuddy.Commands[FishingBuddy.NOTRACK].args[1] = "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[.-%]|h|r";
FishingBuddy.Commands[FishingBuddy.NOTRACK].help = FishingBuddy.TRACKING_HELP;
FishingBuddy.Commands[FishingBuddy.NOTRACK].func =
   function(fishlink)
      local c, i, n = FishingBuddy.SplitFishLink(fishlink);
      if ( i ) then
	 UntrackThis(i, n);
	 return true;
      end
   end;
FishingBuddy.Commands[FishingBuddy.TRACKING] = {};
FishingBuddy.Commands[FishingBuddy.TRACKING].help = FishingBuddy.TRACKING_HELP;
FishingBuddy.Commands[FishingBuddy.TRACKING].func =
   function()
      local pr = FishingBuddy.Print;
      for jdx in FishingBuddy_Info["FishTracking"] do
	 local how = trackingWordMap[jdx];
	 pr("Tracking "..how);
	 local ft = FishingBuddy_Info["FishTracking"];
	 for id in ft[jdx] do
	    local name;
	    if ( ft[jdx][id].name ) then
	       name = ft[jdx][id].name;
	    else
	       name = id;
	    end
	    local line = name.."; ";
	    for k,v in ft[jdx][id].data do
	       line = line.." "..k..": "..v;
	    end
	    pr(line);
	 end
      end
      return true;
   end;

FishingBuddy.InitTracking = function()
   if ( not FishingBuddy_Info["FishTracking"] ) then
      FishingBuddy_Info["FishTracking"] = { };
   end
   for k,v in byhours do
      TrackThis("HOURLY", k, v.c);
   end
   for k,v in byweeks do
      TrackThis("WEEKLY", k, v.c);
   end
end

FishingBuddy.AddTracking = function(id, name)
   local ft = FishingBuddy_Info["FishTracking"];
   local index, how;
   if ( ft["HOURLY"][id] ) then
      how = "HOURLY";
      index,_ = GetGameTime();
   elseif ( ft["WEEKLY"][id] ) then
      how = "WEEKLY";
      index = date("%W");
   else
      return false;
   end
   if ( not FishingBuddy_Info["FishTracking"][how][id].name ) then
      FishingBuddy_Info["FishTracking"][how][id].name = name;
   end
   index = tonumber(index);

   local p = FishingBuddy.printable;
   FishingBuddy_Info["FishTracking"][how][id].data[index] =
      FishingBuddy_Info["FishTracking"][how][id].data[index] + 1;
   return true;
end

local function PlotData(graph, num, bw, bs, tab, hlabels)
   local plotem = {};
   local maxval = 0;
   local width = 0;
   local plotted = false;
   local fdx = 1;
   local line;
   local mv = 0;
   for _,info in tab do
      plotem[fdx] = false;
      -- our data is zero based...
      local n = table.getn(info.data);
      width = n * (bw+bs);
      n = n - 1;
      for idx=0,n do
	 if ( info.data[idx] > mv ) then
	    mv = info.data[idx];
	 end
      end
      if ( mv > 0 ) then
	 if ( mv > maxval ) then
	    maxval = mv;
	 end
	 plotem[fdx] = true;
	 plotted = true;
      end
      fdx = fdx + 1;
   end
   local delta = math.mod(maxval, 5);
   if ( delta > 0 ) then
      maxval = maxval + (5 - delta);
   end
   graph.maxVal = maxval;
   graph.barWidth = bw;
   graph.barSpacing = bs;
   local count = num;
   fdx = 1;
   for id, info in tab do
      if ( count > 0 and plotem[fdx] ) then
	 local c = info.color or {};
	 local item, texture, _, _, _ = FishingBuddy.GetFishie(id);
	 GraphHandler.PlotLegend(graph, num-count+1, info.name, id,
				 texture, c.r, c.g, c.b);
	 local w = GraphHandler.PlotData(graph, info.data, num-count, 1,
					 c.r, c.g, c.b);
     if ( info.name ) then
        if ( line ) then
	       line = line.." / "..info.name;
	    else
	       line = info.name;
	    end
	 end
	 count = count - 1;
      end
      fdx = fdx + 1;
   end
   if ( plotted ) then
      local values = {};
      local delta = maxval/5;
      for v=0,5 do
	 values[string.format("%d", v*delta)] = v;
      end
      GraphHandler.PlotGrid(graph, line or "", values, width, hlabels);
   else
      GraphHandler.PlotGrid(graph, FishingBuddy.NODATAMSG );
   end
   return width, maxval, line;
end

FishingBuddy.TrackingFrame.OnShow = function()
   local fi = FishingBuddy_Info["FishTracking"];
   local graph1 = getglobal("FishingTrackingFrameGraph1");
   local graph2 = getglobal("FishingTrackingFrameGraph2");

   PlotData(graph1, 2, 5, 5, fi["HOURLY"],
	    {["00:00"] = 0, ["06:00"] = 6, ["12:00"] = 12, ["18:00"] = 18, ["23:59"] = 24});
   PlotData(graph2, 2, 3, 2, fi["WEEKLY"], FishingBuddy.BYWEEKS_TABLE);
end
