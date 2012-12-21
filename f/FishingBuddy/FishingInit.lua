-- FishingBuddy
--
-- Everything you wanted support for in your fishing endeavors

local gotSetupDone = false;
local playerName;
local realmName;

local DEFAULT_MINIMAP_POSITION = 256;

FishingBuddy.IsLoaded = function()
   return gotSetupDone;
end

-- if the old information is still there, then we might not have per
-- character saved info, so let's save it away just in case. It'll go
-- away the second time we load the add-on
FishingBuddy.SavePlayerInfo = function()
   if ( FishingBuddy_Info[realmName] and
        FishingBuddy_Info[realmName]["Settings"] and
        FishingBuddy_Info[realmName]["Settings"][playerName] ) then
      local tabs = { "Settings", "Outfit", "WasWearing" };
      for _,tab in tabs do
	 for k,v in FishingBuddy_Player[tab] do
	    FishingBuddy_Info[realmName][tab][playerName][k] = v;
	 end
      end
   end
end

local Setup = {};
Setup.CheckPlayerInfo = function()
   local tabs = { "Settings", "Outfit", "WasWearing" };
   if ( not FishingBuddy_Player ) then
      FishingBuddy_Player = {};
      for _,tab in tabs do
	 FishingBuddy_Player[tab] = { };
      end
      if ( FishingBuddy_Info[realmName] and
	   FishingBuddy_Info[realmName]["Settings"] and
	   FishingBuddy_Info[realmName]["Settings"][playerName] ) then
	 for _,tab in tabs do
	    if ( FishingBuddy_Info[realmName][tab] and
		 FishingBuddy_Info[realmName][tab][playerName] ) then
	       for k,v in FishingBuddy_Info[realmName][tab][playerName] do
		  FishingBuddy_Player[tab][k] = v;
	       end
	    end
	 end
      end
   elseif ( FishingBuddy_Info[realmName] and
	   FishingBuddy_Info[realmName]["Settings"] ) then
      -- the saved information is there, kill the old stuff
      for _,tab in tabs do
	 if ( FishingBuddy_Info[realmName][tab] ) then
	    FishingBuddy_Info[realmName][tab][playerName] = nil;
	    -- Duh, table.getn doesn't work because there
	    -- aren't any integer keys in this table
	    if ( next(FishingBuddy_Info[realmName][tab]) == nil ) then
	       FishingBuddy_Info[realmName][tab] = nil;
	    end
	 end
      end
      if ( next(FishingBuddy_Info[realmName]) == nil ) then
	 FishingBuddy_Info[realmName] = nil;
      end
   end
end

Setup.CheckPlayerSetting = function(setting, defaultvalue)
   if ( not FishingBuddy_Player["Settings"] ) then
      FishingBuddy_Player["Settings"] = { };
   end
   if ( not FishingBuddy_Player["Settings"][setting] ) then
      FishingBuddy_Player["Settings"][setting] = defaultvalue;
   end
end

Setup.CheckGlobalSetting = function(setting, defaultvalue)
   if ( not FishingBuddy_Info[setting] ) then
      if ( not defaultvalue ) then
	 FishingBuddy_Info[setting] = {};
      else
	 FishingBuddy_Info[setting] = defaultvalue;
      end
   end
end

Setup.CheckRealm = function()
   local tabs = { "Settings", "Outfit", "WasWearing" };
   for _,tab in tabs do
      if ( FishingBuddy_Info[tab] ) then
	 local old = FishingBuddy_Info[tab][playerName];
	 if ( old ) then
	    if ( not FishingBuddy_Info[realmName] ) then
	       FishingBuddy_Info[realmName] = { };
	       for _,tab in tabs do
		  FishingBuddy_Info[realmName][tab] = { };
	       end
	    end

	    FishingBuddy_Info[realmName][tab][playerName] = { };
	    for k, v in old do
	       FishingBuddy_Info[realmName][tab][playerName][k] = v;
	    end
	    FishingBuddy_Info[tab][playerName] = nil;
	 end

	 -- clean out cruft, if we have some
	 FishingBuddy_Info[tab][UNKNOWNOBJECT] = nil;
	 FishingBuddy_Info[tab][UKNOWNBEING] = nil;

	 -- Duh, table.getn doesn't work because there
	 -- aren't any integer keys in this table
	 if ( next(FishingBuddy_Info[tab]) == nil ) then
	    FishingBuddy_Info[tab] = nil;
	 end
      end
   end
end

Setup.UpdateFishingDB1 = function()
   local version = FishingBuddy_Info["Version"];
   if ( not version ) then
      version = 7700; -- be really old
   end

   if ( FishingBuddy_Info["FishingHoles"] ) then
      if ( version < 8300 ) then
         -- handle a beta bug where we missed that GetSubZoneText() returns "" and not nil
         for zone in FishingBuddy_Info["FishingHoles"] do
	    if ( FishingBuddy_Info["FishingHoles"][zone][""] ) then
	       if ( not FishingBuddy_Info["FishingHoles"][zone][zone] ) then
	          FishingBuddy_Info["FishingHoles"][zone][zone] = { };
	       end
	       for k,v in FishingBuddy_Info["FishingHoles"][zone][""] do
	          FishingBuddy_Info["FishingHoles"][zone][zone][k] = v;
	       end
	       FishingBuddy_Info["FishingHoles"][zone][""] = nil;
	    end
         end
      end

      if ( version < 8503 ) then
         local fh = FishingBuddy_Info["FishingHoles"];
         local ff = FishingBuddy_Info["Fishies"];
         for zone in fh do
	    for subzone in fh[zone] do
	       local crap = {};
	       for fishie in fh[zone][subzone] do
	          if ( type(fishie) == "string" ) then
	             tinsert(crap, fishie);
	          end
	       end
	       for _,fishie in crap do
	          if ( ff[fishie] ) then
		     local item = ff[fishie].item;
		     if ( item ) then
		        local _,_,id = string.find(item, "^(%d+):");
		        id = id + 0;
		        fh[zone][subzone][id] = fh[zone][subzone][fishie];
		        fh[zone][subzone][fishie] = nil;
		        end
	          end
	       end
	    end
         end
         local fishes = {};
         for fishie in ff do
            if ( type(fishie) == "string" ) then
	           tinsert(fishes, fishie);
	        end
         end
         for _,fishie in fishes do
	    local item = ff[fishie].item;
	    if ( item ) then
	       local _,_,id = string.find(item, "^(%d+):");
	       id = id + 0;
	       ff[id] = {};
	       ff[id].name = fishie;
	       for k,v in ff[fishie] do
	          if ( k ~= "item" ) then
	             ff[id][k] = v;
	          end
           end
	       ff[fishie] = nil;
	    end
         end
      --    tracking information
         local ft = FishingBuddy_Info["FishTracking"];
         for how in ft do
	    local fishes = {};
	    for item in ft[how] do
           if ( type(item) == "string" ) then
	          tinsert(fishes, item);
	       end
	    end
	    for _,item in fishes do
	       local _,_,id = string.find(item, "^(%d+):");
	       id = tonumber(id);
	       ft[how][id] = {};
	       for k,v in ft[how][item] do
	          ft[how][id][k] = v;
	       end
	       if ( ft[how][id].count ) then
	          ft[how][id].data = {};
	          for k,v in ft[how][id].count do
	             ft[how][id].data[k] = v;
	          end
	          ft[how][id].count = nil;
	       end
	    end
	    for _,item in fishes do
	       ft[how][item] = nil;
	    end
         end
      end
   end

   if ( version < 8504 ) then
      -- Let's not store default colors for things
      local ff = FishingBuddy_Info["Fishies"];
      if ( ff ) then
	 for id in ff do
	    if ( ff[id].color and ff[id].color == "ffffffff" ) then
	       ff[id].color = nil;
	    end
	 end
      end
   end

   if ( version < 8509 and FishingBuddy_Info["FishTracking"] ) then
      local ft = FishingBuddy_Info["FishTracking"]["WEEKLY"];
      for id,what in ft do
	 if ( not ft[id].data[52] ) then
	    ft[id].data[52] = 0;
	    table.setn(ft[id].data, 53);
	 end
      end
   end

   if ( not FishingBuddy_Info["Locations"] ) then
      return;
   end

   -- Duh, table.getn doesn't work because there aren't any integer
   -- keys in this table
   if ( next(FishingBuddy_Info["Locations"]) == nil ) then
      FishingBuddy_Info["Locations"] = nil;
      return;
   end

   FishingBuddy_Info["FishingHoles"] = { };
   FishingBuddy_Info["FishingHoles"][FishingBuddy.UNKNOWN] = { };
   for zone in FishingBuddy_Info["Locations"] do
      FishingBuddy_Info["FishingHoles"][FishingBuddy.UNKNOWN][zone] = { };
      local tab = FishingBuddy_Info["FishingHoles"][FishingBuddy.UNKNOWN][zone];
      for k,v in FishingBuddy_Info["Locations"][zone] do
	 tab[k] = v;
      end
   end
   FishingBuddy_Info["Locations"] = nil;
end

Setup.UpdateFishingDB2 = function()
   local version = FishingBuddy_Info["Version"];
   if ( not version ) then
      version = 7700; -- be really old
   end

   -- track the weekly fish that got missed at the end of the year
   if ( version < 8509 ) then
      local ft = FishingBuddy_Info["FishTracking"]["WEEKLY"];
      for id,what in ft do
	 if ( FishingBuddy.ByFishie[id] ) then
	    local total = 0;
	    for subzone,count in FishingBuddy.ByFishie[id] do
	       total = total + count;
	    end
	    local tracked = 0;
	    local limit = table.getn(what.data)-1;
	    for i=0,limit do
	       tracked = tracked + what.data[i];
	    end
	    local diff = total - tracked;
	    if ( diff > 0 ) then
	       ft[id].data[52] = ft[id].data[52] + diff;
	    end
	 end
      end
   end

   FishingBuddy_Info["Version"] = FishingBuddy.CURRENTVERSION;
end

-- Based on code in QuickMountEquip
Setup.HookFunction = function(func, newfunc)
   local oldValue = getglobal(func);
   if ( oldValue ~= getglobal(newfunc) ) then
      setglobal(func, getglobal(newfunc));
      return true;
   end
   return false;
end

-- set up alternate view of fish data. do this as startup to
-- lower overall dynamic hit when loading the window
Setup.SetupByFishie = function()
   if ( not FishingBuddy.ByFishie ) then
      local fh = FishingBuddy_Info["FishingHoles"];
      local ff = FishingBuddy_Info["Fishies"];
      FishingBuddy.ByFishie = { };
      FishingBuddy.SortedFishies = { };
      for zone in fh do
	 for subzone in fh[zone] do
	    for id in fh[zone][subzone] do
	       local quantity = fh[zone][subzone][id];
	       if ( not FishingBuddy.ByFishie[id] ) then
		  FishingBuddy.ByFishie[id] = { };
		  tinsert(FishingBuddy.SortedFishies,
			  { text = ff[id].name, id = id });
	       end
	       if ( not FishingBuddy.ByFishie[id][subzone] ) then
		  FishingBuddy.ByFishie[id][subzone] = quantity;
	       else
		  FishingBuddy.ByFishie[id][subzone] = FishingBuddy.ByFishie[id][subzone] + quantity;
	       end
	    end
	 end
      end
      FishingBuddy.FishSort(FishingBuddy.SortedFishies, true);
   end
end

Setup.InitSortHelpers = function()
   local fh = FishingBuddy_Info["FishingHoles"];
   FishingBuddy.SortedZones = {};
   FishingBuddy.SortedByZone = {};
   FishingBuddy.SortedSubZones = {};
   for zone in fh do
      tinsert(FishingBuddy.SortedZones, zone);
      FishingBuddy.SortedByZone[zone] = {};
      for subzone in fh[zone] do
	 tinsert(FishingBuddy.SortedByZone[zone], subzone);
	 tinsert(FishingBuddy.SortedSubZones, subzone);
      end
      table.sort(FishingBuddy.SortedByZone[zone]);
   end
   table.sort(FishingBuddy.SortedZones);
   table.sort(FishingBuddy.SortedSubZones);
end

Setup.EnhanceSoundDefaults = function()
   Setup.CheckPlayerSetting("EnhanceSoundSoundVolume", 1.0);
   Setup.CheckPlayerSetting("EnhanceSoundMusicVolume", 0.0);
   Setup.CheckPlayerSetting("EnhanceSoundAmbienceVolume", 0.0);
end

Setup.InitSettings = function()
   if( not FishingBuddy_Info ) then
      FishingBuddy_Info = { };
   end
   -- global stuff
   Setup.UpdateFishingDB1();
   Setup.CheckRealm();

   Setup.CheckGlobalSetting("ImppDBLoaded", 0);
   Setup.CheckGlobalSetting("FishInfo2", 0);
   Setup.CheckGlobalSetting("DataFish", 0);
   Setup.CheckGlobalSetting("FishingHoles");
   Setup.CheckGlobalSetting("FishingSkill");
   Setup.CheckGlobalSetting("Fishies");

   Setup.CheckPlayerInfo();

   -- per user stuff
   for _,option in FishingBuddy.OPTIONS do
      local setting = option.default;
      if ( option.check and option.checkfail ) then
	 if ( not option.check() ) then
	    setting = option.checkfail;
	 end
      end
      Setup.CheckPlayerSetting(option.name, setting);
   end

   -- setting not on option pane (or not checkboxes)
   Setup.CheckPlayerSetting("ShowLocationZones", 1);
   Setup.CheckPlayerSetting("GroupByLocation", 1);

   -- titan panel support
   Setup.CheckPlayerSetting("TitanClickToSwitch", 1);
   -- InfoBar support
   Setup.CheckPlayerSetting("InfoBarClickToSwitch", 1);
   -- minimap button support
   Setup.CheckPlayerSetting("MinimapClickToSwitch", 1);
   Setup.CheckPlayerSetting("MinimapButtonPosition", DEFAULT_MINIMAP_POSITION);

   -- Option key casting
   Setup.CheckPlayerSetting("EasyCastKeys", FishingBuddy.KEYS_NONE);
   Setup.CheckPlayerSetting("SuitUpKeys", FishingBuddy.KEYS_NONE);

   Setup.EnhanceSoundDefaults();

   if ( FishingBuddy.InitTracking ) then
      FishingBuddy.InitTracking();
   end
   Setup.SetupByFishie();
   Setup.UpdateFishingDB2();
   Setup.InitSortHelpers();
end

Setup.RegisterMyAddOn = function()
   -- Register the addon in myAddOns
   if (myAddOnsFrame_Register) then
      local details = {
	 name = FishingBuddy.ID,
	 description = FishingBuddy.DESCRIPTION,
	 version = FishingBuddy.VERSION,
	 releaseDate = 'July 21, 2005',
	 author = 'Sutorix',
	 email = 'Windrunner',
	 category = MYADDONS_CATEGORY_PROFESSIONS,
	 frame = "FishingBuddy",
	 optionsframe = "FishingBuddyFrame",
      };
      local help = "";
      for _,line in FishingBuddy.HELPMSG do
	 if ( type(line) == "table" ) then
	    for _,l in line do
	       help = help.."\n"..l;
	    end
	 else
	    help = help.."\n"..line;
	 end
      end
      myAddOnsFrame_Register(details, { help });
   end
end

Setup.RegisterHandlers = function()
   temp = ToggleMinimap;
   if ( Setup.HookFunction("ToggleMinimap", "FishingBuddy_ToggleMinimap") ) then
      FishingBuddy.SavedToggleMinimap = temp;
   end
   FishingBuddy.TrapWorldMouse()
end

FishingBuddy.Initialize = function()
   -- Set everything up, then dump the code we don't need anymore
   playerName, realmName = FishingBuddy.SetupNameInfo();
   if ( Setup ) then
      if ( GetBuildInfo ) then
	 local version, buildnum, builddate = GetBuildInfo();
      else
	 FishingBuddy.Is10900 = true;
      end
      Setup.RegisterHandlers();
      Setup.InitSettings();
      -- register with myAddOn
      Setup.RegisterMyAddOn();

      gotSetupDone = true;
      FishingBuddy.WatchUpdate();
      -- we don't need these functions anymore, gc 'em
      Setup = nil;
   end
end
