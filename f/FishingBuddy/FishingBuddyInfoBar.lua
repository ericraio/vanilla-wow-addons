-- InfoBar support

FishingBuddy.InfoBar = {};

FishingBuddy.InfoBar.OnLoad = function()
   if ( not InfoBarFrame ) then
      return;
   end

   this:RegisterForClicks("LeftButtonUp", "RightButtonUp");

   this.info = {
      name = FishingBuddy.NAME,
      version = FishingBuddy.CURRENTVERSION/100,
      tooltip = FishingBuddy.InfoBar.Tooltip,
   };	
end

FishingBuddy.InfoBar.OnClick = function(button)
   if (button == "LeftButton") then
      if (FishingBuddy.GetSetting("InfoBarClickToSwitch") == 1) then
	 FishingBuddy.Command(FishingBuddy.SWITCH);
      else
	 FishingBuddy.Command("");
      end
   else
      -- Toggle menu
      local menu = getglobal("FishingBuddyInfoBarMenu");
      menu.point = "TOPRIGHT";
      menu.relativePoint = "CENTER";
      local level = 1;
      ToggleDropDownMenu(level, nil, menu, "IB_FishingBuddy", 0, 0);
   end
end

FishingBuddy.InfoBar.OnEvent = function()
end

FishingBuddy.InfoBar.Tooltip = function()
   local text = FishingBuddy.DESCRIPTION1.."\n"..FishingBuddy.DESCRIPTION2.."\n";
   text = text.."|c"..FishingBuddy.Colors.GREEN;
   if (FishingBuddy.GetSetting("InfoBarClickToSwitch") == 1) then
      text = text..FishingBuddy.TOOLTIP_HINTSWITCH;
   else
      text = text..FishingBuddy.TOOLTIP_HINTTOGGLE;
   end
   text = text.."|r";
   return text;
end

FishingBuddy.InfoBar.Menu_Initialize = function()
   FishingBuddy.MakeDropDown(FishingBuddy.TITAN_CLICKTOSWITCH_ONOFF,
		"InfoBarClickToSwitch");
end
