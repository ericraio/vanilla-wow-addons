-- Wrap OutfitDisplayFrame with our "improvements"
FishingBuddy.OutfitFrame = {};

local function StylePoints(outfit)
   local isp = FishingBuddy.OutfitManager.ItemStylePoints;
   local points = 0;
   if ( outfit )then
      for slot in outfit do
	 if ( outfit[slot].item ) then
	    local _,_,check, enchant = string.find(outfit[slot].item,
						   "^(%d+):(%d+)");
	    points = points + isp(check, enchant);
	 end
      end
   end
   return points;
end

local match;
local function ItemBonusPoints(item)
   local points = 0;
   if ( item and item ~= "" ) then
      if ( not match ) then
	 match = FishingBuddy.GetFishingSkillName().." %+(%d+)";
      end
      FishingOutfitTooltip:SetHyperlink("item:"..item);
      local bodyslot = FishingOutfitTooltipTextLeft2:GetText();
      local textline = 2;
      while (bodyslot) do
	 local _,_,bonus = string.find(bodyslot, match);
	 if bonus then
	    points = points + bonus;
	 end
	 textline = textline + 1;
	 bodyslot = getglobal("FishingOutfitTooltipTextLeft"..textline):GetText();
      end
      -- See if the Eternium Fishing Line has been applied
      local _,_,check, enchant = string.find(item, "^(%d+):(%d+)");
      if ( enchant == "2603" ) then
	 points = points + 5;
      end
   end
   return points;
end

local function BonusPoints(outfit)
   local points = 0;
   if ( outfit )then
      for slot in outfit do
	 points = points + ItemBonusPoints(outfit[slot].item);
      end
   end
   return points;
end

local function UpdateSwitchButton(outfit)
   if ( outfit and not OutfitDisplayFrame_SwitchWillFail(FishingOutfitFrame, outfit) ) then
      FishingOutfitSwitchButton:Enable();
   else
      FishingOutfitSwitchButton:Disable();
   end
end

FishingBuddy.OutfitFrame.OutfitChanged = function(button)
   local outfit = OutfitDisplayFrame_GetOutfit(FishingOutfitFrame);
   if ( outfit ) then
      FishingBuddy.SetOutfit(outfit);
   end
   local points = BonusPoints(outfit);
   if ( points >= 0 ) then
      points = "+"..points;
   else
      points = 0 - points;
      points = "-"..points;
   end
   FishingOutfitSkill:SetText(FishingBuddy.CONFIG_SKILL_TEXT..points);
   points = StylePoints(outfit);
   local pstring;
   if ( points == 1 ) then
      pstring = FishingBuddy.POINT;
   else
      pstring = FishingBuddy.POINTS;
   end
   FishingOutfitStyle:SetText(FishingBuddy.CONFIG_STYLISH_TEXT..points.." "..pstring);
   UpdateSwitchButton(outfit);
   FishingOutfitFrame.valid = true;
end

FishingBuddy.OutfitFrame.OnLoad = function()
   -- Handle the override
   if ( OutfitDisplayFrame_OnLoad ) then
      OutfitDisplayFrame_OnLoad();
      FishingOutfitSkill.tooltip = FishingBuddy.CONFIG_SKILL_INFO;
      FishingOutfitStyle.tooltip = FishingBuddy.CONFIG_STYLISH_INFO;
      FishingOutfitSwitchButton:SetText(FishingBuddy.SWITCHOUTFIT);
      FishingOutfitFrame.OutfitChanged = FishingBuddy.OutfitFrame.OutfitChanged;
   else
      FishingBuddy.DisableSubFrame("FishingOutfitFrame");
   end
end

FishingBuddy.OutfitFrame.OnShow = function()
   if ( not this.valid ) then
      local outfit = FishingBuddy.GetOutfit();
      OutfitDisplayFrame_SetOutfit(FishingOutfitFrame, outfit);
      FishingBuddy.OutfitFrame.OutfitChanged();
   end
end

FishingBuddy.OutfitFrame.OnHide = function()
   -- FishingOutfitFrame_OutfitChanged();
end

FishingBuddy.OutfitFrame.Button_OnClick = function()
   -- make sure we have the current state
   FishingBuddy.SetOutfit(OutfitDisplayFrame_GetOutfit(FishingOutfitFrame));
   FishingBuddy.OutfitFrame.Switch();
end

-- only have one outfit at the moment
-- don't switch if
-- we can't find everything in the outfit
-- we have saved stuff but we're not wearing everything in the outfit
-- We don't have the outfit display frame!
FishingBuddy.OutfitFrame.Switch = function()
   if (CursorHasItem()) then
      FishingBuddy.UIError(FishingBuddy.CURSORBUSYMSG);
      return false;
   end
   if ( OutfitDisplayFrame_IsSwapping() ) then
      FishingBuddy.UIError(OUTFITDISPLAYFRAME_TOOFASTMSG);
      return false;
   end

   local isfishing = FishingBuddy.IsFishingPole();
   local outfit = FishingBuddy.GetOutfit();
   local waswearing = FishingBuddy.GetWasWearing();
   if ( waswearing ) then
      local msg;

      if ( isfishing ) then
	 msg = OutfitDisplayFrame_SwitchWillFail(FishingOutfitFrame, waswearing);
      else
	 msg = FishingBuddy.CANTSWITCHBACK;
	 FishingBuddy.SetWasWearing(nil);
	 StartedFishing = nil;
      end

      if ( msg ) then
	 FishingBuddy.UIError(msg);
	 return false;
      end
      local check = OutfitDisplayFrame_SwitchOutfit(waswearing);
      if ( check ) then
	 FishingBuddy.SetWasWearing(nil);
	 FishingBuddy.OutfitManager.CheckSwitch(false);
      end
   elseif ( outfit ) then
      local msg;
      if ( not isfishing ) then
	 msg = OutfitDisplayFrame_SwitchWillFail(FishingOutfitFrame, outfit);
      else
	 msg = FishingBuddy.POLEALREADYEQUIPPED;
      end
      if ( msg ) then
	 FishingBuddy.UIError(msg);
	 return false;
      end
      local waswearing = OutfitDisplayFrame_SwitchOutfit(outfit);
      if ( waswearing ) then
	 FishingBuddy.SetWasWearing(waswearing);
	 FishingBuddy.OutfitManager.CheckSwitch(true);
      end
   else
      FishingBuddy.UIError(FishingBuddy.NOOUTFITDEFINED);
   end
   return true;
end
