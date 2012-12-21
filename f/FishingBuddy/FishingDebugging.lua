-- outfit debugging functions
FishingBuddy.Commands["outfit"] = {};
FishingBuddy.Commands["outfit"].func =
   function(what)
      if ( what ) then
	 if ( what == FishingBuddy.RESET ) then
	    FishingBuddy.SetWasWearing(nil);
	 elseif ( what == "dump" ) then
	    FishingBuddy.Debug("Outfit");
	    FishingBuddy.Dump(FishingBuddy.GetOutfit());
	    FishingBuddy.Debug("Was Wearing");
	    FishingBuddy.Dump(FishingBuddy.GetWasWearing());
	 end
      end
      return true;
   end;

-- test the extravaganze school marking functions
-- need to expand this for 1.9 if we can tell automatically
FishingBuddy.Commands["mark"] = {};
FishingBuddy.Commands["mark"].func =
   function(what)
      if ( what == "reset" ) then
	 FishingBuddy_Info["Schools"] = nil;
      elseif ( what == "debug" ) then
	 local hour,_ = GetGameTime();
	 local day = date("%w");
	 FishingBuddy.Extravaganza.Debug(day, hour, GetRealZoneText());
      elseif ( what == "dump" ) then
	 FishingBuddy.Extravaganza.Dump();
      else
	 FishingBuddy.Extravaganza.MarkSchool();
      end
      return true;
   end;

-- random debugging code, likely out of date
FishingBuddy.Commands["debug"] = {};
FishingBuddy.Commands["debug"].func =
   function(what)
      if ( what ) then
         if ( what == "on" ) then
            FishingBuddy_Debugging = 1;
         elseif ( what == "reset" ) then
            FishingBuddy_Info["Testing"] = nil;
	 elseif ( what == "test" ) then
	    local STVInfo = { scale = 0.18128603034401, xoffset = 0.39145470225916, yoffset = 0.79412224886668 };
	    local xscale = 10448.3;
	    local yscale = 7072.7;
	    local playerX, playerY = GetPlayerMapPosition("player");
	    local x = playerX * STVInfo.scale + STVInfo.xoffset;
	    local y = playerY * STVInfo.scale + STVInfo.yoffset;
	    FishingBuddy.Print("PlayerMap: %f, %f", x, y);
	    for idx=1,10 do
	       playerY = playerY + 0.01;
	       local dx = playerX * STVInfo.scale + STVInfo.xoffset;
	       local dy = playerY * STVInfo.scale + STVInfo.yoffset;
	       local dist = math.sqrt((dx*xscale*dx*xscale)+(dy*yscale*dy*yscale));
	       FishingBuddy.Print("PlayerMap: %f, %f - %f", dx, dy, dist);
	    end
         else
	    local func = getglobal("FishingBuddy_Localize_"..what);
	    if ( func ) then
	       func();
	    else
	       FishingBuddy_Debugging = 0;
	    end
         end
      end
      return true;
   end;
