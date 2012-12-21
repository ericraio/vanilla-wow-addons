-- Handle all the option settings

FishingBuddy.OptionsFrame = {};

FishingBuddy.CheckButton_OnShow = function()
   this:SetChecked(FishingBuddy.GetSetting(this.name));
   getglobal(this:GetName().."Text"):SetText(this.text);
end

FishingBuddy.CheckButton_OnClick = function()
   local value = 0;
   if ( this:GetChecked() ) then
      PlaySound("igMainMenuOptionCheckBoxOff");
      value = 1;
   else
      PlaySound("igMainMenuOptionCheckBoxOn");
   end
   FishingBuddy.SetSetting(this.name, value);
end

FishingBuddy.CheckButton_OnEnter = function()
   local tooltip = this.tooltip;
   if ( tooltip ) then
      GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
      GameTooltip:SetText(tooltip, nil, nil, nil, nil, 1);
      GameTooltip:Show();
   end
end

FishingBuddy.CheckButton_OnLeave = function()
   GameTooltip:Hide();
end

FishingBuddy.OptionsFrame.Setup = function()
   for _, option in FishingBuddy.OPTIONS do
      local button = getglobal("FishingBuddyOption_"..option.name);
      if (button) then
	 local showthis = true;
	 if ( option.check ) then
	    showthis = option.check();
	 end
	 if ( showthis ) then
	    button:Show();
	    button.name = option.name;
	    button.text = option.text;
	    button.tooltip = option.tooltip;
	 else
	    button:Hide();
	 end
      end
   end

   if ( FishingBuddy.UseButtonHole() ) then
      FishingBuddyMinimapPosSlider:Hide();
   end
   local gs = FishingBuddy.GetSetting;
   FishingBuddy.OptionsFrame.SetKeyValue("EasyCastKeys", gs("EasyCastKeys"));
 end

FishingBuddy.OptionsFrame.SetKeyValue = function(what, value)
   local show = FishingBuddy.Keys[value];
   FishingBuddy.SetSetting(what, value);
   local menu = getglobal("FishingBuddyOption_"..what);
   if ( menu ) then
      local label = getglobal("FishingBuddyOption_"..what.."Label");
      UIDropDownMenu_SetWidth(90, menu);
      UIDropDownMenu_SetSelectedValue(menu, show);
      UIDropDownMenu_SetText(show, menu);
      label:SetText(FishingBuddy.KEYS_LABEL_TEXT);
   end
end

FishingBuddy.OptionsFrame.LoadKeyMenu = function(what)
   local info = {};
   local setting = FishingBuddy.GetSetting(what);
   for value,label in FishingBuddy.Keys do
      local v = value;
      local w = what;
      info.text = label;
      info.func = function() FishingBuddy.OptionsFrame.SetKeyValue(w, v); end;
      if ( setting == value ) then
	 info.checked = true;
      else
	 info.checked = false;
      end
      UIDropDownMenu_AddButton(info);
   end
end

FishingBuddy.OptionsFrame.MenuSetup = function(what)
   UIDropDownMenu_Initialize(this,
			     function()
				local w = what;
				FishingBuddy.OptionsFrame.LoadKeyMenu(what);
			     end);
end
