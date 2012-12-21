-- Titan Panel support

FishingBuddy.Titan = {};

FishingBuddy.Titan.OnLoad = function()
   if not TitanPanelButton_UpdateButton then
      return;
   end

   this.registry = {
      id = FishingBuddy.ID,
      menuText = FishingBuddy.NAME,
      version = FishingBuddy.VERSION,
      category = "Profession",
      icon = "Interface\\AddOns\\FishingBuddy\\Icons\\Fishing-Icon",
      iconWidth = 16,
      tooltipTitle = FishingBuddy.NAME,
      tooltipTextFunction = "TitanPanelFishingBuddyButton_GetTooltipText",
      savedVariables = {
	     ShowIcon = 1,
      }
   };	

   this:RegisterEvent("PLAYER_ENTERING_WORLD");
end

FishingBuddy.Titan.OnClick = function(button)
   if (button == "LeftButton") then
      if (FishingBuddy.GetSetting("TitanClickToSwitch") == 1) then
	 FishingBuddy.Command(FishingBuddy.SWITCH);
      else
	 FishingBuddy.Command("");
      end
   end
end

FishingBuddy.Titan.OnEvent = function()
   if TitanPanelButton_UpdateButton then
      TitanPanelButton_UpdateButton(FishingBuddy.ID);	
      TitanPanelButton_UpdateTooltip();
   end
end

function TitanPanelFishingBuddyButton_GetTooltipText()
   local text = FishingBuddy.DESCRIPTION1.."\n"..FishingBuddy.DESCRIPTION2.."\n";
   if (FishingBuddy.GetSetting("TitanClickToSwitch") == 1) then
      text = text..TitanUtils_GetGreenText(FishingBuddy.TOOLTIP_HINTSWITCH);
   else
      text = text..TitanUtils_GetGreenText(FishingBuddy.TOOLTIP_HINTTOGGLE);
   end
   return text;
end

function TitanPanelRightClickMenu_PrepareFishingBuddyMenu()
   TitanPanelRightClickMenu_AddTitle(TitanPlugins[FishingBuddy.ID].menuText);

   FishingBuddy.MakeDropDown(FishingBuddy.TITAN_CLICKTOSWITCH_ONOFF, "TitanClickToSwitch");

   TitanPanelRightClickMenu_AddSpacer();	
   TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE,
				       FishingBuddy.ID,
				       TITAN_PANEL_MENU_FUNC_HIDE);
end

