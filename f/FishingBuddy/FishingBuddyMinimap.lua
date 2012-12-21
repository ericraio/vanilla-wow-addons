-- Minimap Button Handling

FishingBuddy.UseButtonHole = function()
   if ( ButtonHole and FishingBuddy.GetSetting("UseButtonHole") == 1 ) then
      return true;
   else
      return false;
   end
end

FishingBuddy.Minimap = {};

FishingBuddy.Minimap.OnLoad = function()
   this:RegisterEvent("VARIABLES_LOADED");
end

FishingBuddy.Minimap.OnEvent = function()
   if ( FishingBuddy.UseButtonHole() ) then
      local info = {};
      info.id=FishingBuddy.ID;
      info.name=FishingBuddy.NAME;
      info.tooltip=FishingBuddy.DESCRIPTION;
      info.buttonFrame="FishingBuddyMinimapFrame";
      info.updateFunction="FishingBuddyMinimapButton_MoveButton";
      ButtonHole.application.RegisterMod(info);
   elseif ( ButtonHole ) then
      -- hack, hack, hack
      local playerName = UnitName("player");
      if ( ButtonHoleConfig[playerName] and
	   ButtonHoleConfig[playerName].visibleMod == FishingBuddy.ID ) then
	 ButtonHoleConfig[playerName].visibleMod = nil;
      end
   end
end

FishingBuddy.Minimap.Button_OnLoad = function()
   this:SetFrameLevel(this:GetFrameLevel()+1)
   this:RegisterForClicks("LeftButtonDown", "RightButtonDown");
   this:RegisterEvent("VARIABLES_LOADED");
end

FishingBuddy.Minimap.Button_OnClick = function(button)
   if ( button == "RightButton" ) then
      -- Toggle menu
      local menu = getglobal("FishingBuddyMinimapMenu");
      menu.point = "TOPRIGHT";
      menu.relativePoint = "CENTER";
      local level = 1;
      ToggleDropDownMenu(level, nil, menu, "FishingBuddyMinimapButton", 0, 0);
   elseif ( FishingBuddy.GetSetting("MinimapClickToSwitch") == 1 ) then
      FishingBuddy.Command(FishingBuddy.SWITCH);
   else
      FishingBuddy.Command("");
   end
end

FishingBuddyMinimapButton_MoveButton = function()
   if ( FishingBuddy.IsLoaded() ) then
      local where = FishingBuddy.GetSetting("MinimapButtonPosition");
      FishingBuddyMinimapFrame:ClearAllPoints();
      FishingBuddyMinimapFrame:SetPoint("TOPLEFT", "Minimap", "TOPLEFT",
					 52 - (80 * cos(where)),
					 (80 * sin(where)) - 52);
   end
end

FishingBuddy.UpdateMinimap = function()
   FishingBuddyMinimapButton_MoveButton();
   if ( FishingBuddy.GetSetting("MinimapButtonVisible") == 1 and
        Minimap:IsVisible() ) then
      FishingBuddyMinimapButton:EnableMouse(true);
      FishingBuddyMinimapButton:Show();
      FishingBuddyMinimapFrame:Show();
   else
      FishingBuddyMinimapButton:EnableMouse(false);
      FishingBuddyMinimapButton:Hide();
      FishingBuddyMinimapFrame:Hide();
   end
end

FishingBuddy.Minimap.Button_OnEvent = function()
   FishingBuddy.UpdateMinimap();
end

FishingBuddy.Minimap.Button_OnEnter = function()
   if ( GameTooltip.finished ) then
      return;
   end
   if ( FishingBuddy.GetSetting("UseButtonHole") == 0 ) then
      GameTooltip.finished = 1;
      GameTooltip:SetOwner(FishingBuddyMinimapFrame, "ANCHOR_LEFT");
      GameTooltip:AddLine(FishingBuddy.NAME);
      GameTooltip:AddLine(FishingBuddy.DESCRIPTION,.8,.8,.8,1);
      GameTooltip:Show();
   end
end

FishingBuddy.Minimap.Button_OnLeave = function()
   GameTooltip:Hide();
   GameTooltip.finished = nil;
end

function FishingBuddy_ToggleMinimap()
   FishingBuddy.SavedToggleMinimap();
   FishingBuddy.UpdateMinimap();
end

FishingBuddy.Minimap.Menu_Initialize = function()
   FishingBuddy.MakeDropDown(FishingBuddy.TITAN_CLICKTOSWITCH_ONOFF,
		"MinimapClickToSwitch");
end

