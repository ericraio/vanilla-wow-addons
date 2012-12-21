--[[
  Healers Assist by Kiki of European Cho'gall (Alliance)
    Configuration module

]]


--------------- Saved variables ---------------
HA_Config = {};
-- -= Global =-
--  ButtonPosition : Position of Minimap button
--  Auto : Auto open window in group or raid
--  GrowUpwards : If true, HA's main window will grow upwards
--  UseEstimatedHealth : Use estimated health value, base on WOUNDS/HEALS of raid members (should be more accurate than without it)

-- -= Healers =-
--  ShowInstants : Show instant spells in the Spell column
--  ShowHoT : Show HoTs in the Spell column
--  KeepValue : Nombre of seconds to keep showing a successfull spell
--  HealersClasses[] : Healing classes to show in Healers window
--  AllowSpellRequest[] : Spell you don't automatically deny requests for
--  HealersLines : Number of lines you want to see (from 1 to 10)
--  HealersCollapsed : True if Healers list is collapsed
--  NotifyRegen : True if you want to be informed when a healer goes into regen mode

-- -= Emergency =-
--  MinEmergencyPercent : Min percent value for showing a raider in Emergency list
--  EmergencyGroups[] : Groups to show in emergency window (Raid only)
--  EmergencyClasses[] : Classes to show in emergency window
--  EmergLines : Number of lines you want to see (from 1 to 6)
--  FilterRange : True if range filtering is active (30yards)

-- -= Plugins =-
--  PluginOrder[] : The order to load and call plugins
--  PluginAuto[] : Array of the auto loaded plugins

--------------- UI buttons ---------------

_HA_CONFIG_SLIDER_MINIMAP_INDEX = 1;
_HA_CONFIG_SLIDER_KEEPVALUE_INDEX = 2;
_HA_CONFIG_SLIDER_MINHEALTHPERCENT_INDEX = 3;
_HA_CONFIG_SLIDER_HEALERLINES_INDEX = 4;
_HA_CONFIG_SLIDER_EMERGLINES_INDEX = 5;
_HA_CONFIG_SLIDER_SCALE_INDEX = 6;
_HA_CONFIG_SLIDER_ALPHA_INDEX = 7;
_HA_CONFIG_SLIDER_GUI_REFRESH_INDEX = 8;
_HA_CONFIG_SLIDER_BACKDROP_ALPHA_INDEX = 9;

HA_Conf_Sliders = {};
HA_Conf_Sliders[_HA_CONFIG_SLIDER_MINIMAP_INDEX] = { var="ButtonPosition", text=HA_GUI_MINIMAP_TITLE, low="0", high="360", min=0, max=360 };
HA_Conf_Sliders[_HA_CONFIG_SLIDER_KEEPVALUE_INDEX] = { var="KeepValue", text=HA_GUI_HEALOPT_KEEP_SPELL_TITLE, low=HA_GUI_HEALOPT_KEEP_SPELL_SHORT, high=HA_GUI_HEALOPT_KEEP_SPELL_LONG, min=0, max=10 };
HA_Conf_Sliders[_HA_CONFIG_SLIDER_MINHEALTHPERCENT_INDEX] = { var="MinEmergencyPercent", text=HA_GUI_EMERGOPT_MIN_HEALTH_TITLE, low=LOW, high=HIGH, min=0, max=100 };
HA_Conf_Sliders[_HA_CONFIG_SLIDER_HEALERLINES_INDEX] = { var="HealersLines", text=HA_GUI_HEALOPT_LINES_TITLE, low="1", high="16", min=1, max=16 };
HA_Conf_Sliders[_HA_CONFIG_SLIDER_EMERGLINES_INDEX] = { var="EmergLines", text=HA_GUI_EMERGOPT_LINES_TITLE, low="0", high="6", min=0, max=6 };
HA_Conf_Sliders[_HA_CONFIG_SLIDER_SCALE_INDEX] = { var="Scale", text=HA_GUI_SCALE_TITLE, low="30%", high="150%", min=30, max=150 };
HA_Conf_Sliders[_HA_CONFIG_SLIDER_ALPHA_INDEX] = { var="Alpha", text=HA_GUI_ALPHA_TITLE, low="0%", high="100%", min=0, max=100 };
HA_Conf_Sliders[_HA_CONFIG_SLIDER_GUI_REFRESH_INDEX] = { var="GUIRefresh", text=HA_GUI_GUI_REFRESH_TITLE, low="100 msec", high="1 sec", min=100, max=1000 };
HA_Conf_Sliders[_HA_CONFIG_SLIDER_BACKDROP_ALPHA_INDEX] = { var="BackdropAlpha", text=HA_GUI_BACKDROP_ALPHA_TITLE, low="0%", high="100%", min=0, max=100 };

HA_Conf_CheckButtons = {};
HA_Conf_CheckButtons[1] = { var = "Auto", text = HA_GUI_AUTO_OPEN };
HA_Conf_CheckButtons[3] = { var = "UseEstimatedHealth", text = HA_GUI_REALTIME_LIFE_UPDATES };

HA_Conf_CheckButtons[21] = { var = "HealersClasses", subvar = HA_ClassesID["DRUID"], text = HA_GUI_HEALOPT_CLASSES_DRUID };
HA_Conf_CheckButtons[22] = { var = "HealersClasses", subvar = HA_ClassesID["PRIEST"], text = HA_GUI_HEALOPT_CLASSES_PRIEST };
HA_Conf_CheckButtons[23] = { var = "HealersClasses", subvar = HA_ClassesID["PALADIN"], text = HA_GUI_HEALOPT_CLASSES_PALA_SHAM };
HA_Conf_CheckButtons[25] = { var = "ShowInstants", text = HA_GUI_HEALOPT_SHOW_INSTANTS };
HA_Conf_CheckButtons[26] = { var = "ShowHoT", text = HA_GUI_HEALOPT_SHOW_HOTS };
HA_Conf_CheckButtons[27] = { var = "GrowUpwards", text = HA_GUI_HEALOPT_GROW_UPWARDS };
HA_Conf_CheckButtons[28] = { var = "NotifyRegen", text = HA_GUI_HEALOPT_NOTIFY_REGEN };
HA_Conf_CheckButtons[29] = { var = "FilterRange", text = HA_GUI_EMERGOPT_FILTER_RANGE };

HA_Conf_CheckButtons[31] = { var = "AllowSpellRequest", subvar = HA_INNERVATE, text = HA_INNERVATE };
HA_Conf_CheckButtons[32] = { var = "AllowSpellRequest", subvar = HA_REBIRTH, text = HA_REBIRTH };
HA_Conf_CheckButtons[33] = { var = "AllowSpellRequest", subvar = HA_DIVINE_INTERVENTION, text = HA_DIVINE_INTERVENTION };
HA_Conf_CheckButtons[34] = { var = "AllowSpellRequest", subvar = HA_LIGHTWELL, text = HA_LIGHTWELL };
HA_Conf_CheckButtons[35] = { var = "AllowSpellRequest", subvar = HA_MANA_TIDE, text = HA_MANA_TIDE };
HA_Conf_CheckButtons[36] = { var = "AllowSpellRequest", subvar = HA_POWER_INFUSION, text = HA_POWER_INFUSION };
--HA_Conf_CheckButtons[37] = { var = "AllowSpellRequest", subvar = nil, text = nil };
HA_Conf_CheckButtons[38] = { var = "AllowSpellRequest", subvar = HA_BLESSING_OF_PROTECTION, text = HA_BLESSING_OF_PROTECTION };
--HA_Conf_CheckButtons[39] = { var = "AllowSpellRequest", subvar = nil, text = nil };


HA_Conf_CheckButtons[41] = { var = "EmergencyGroups", subvar=1, text = HA_GUI_EMERGOPT_GRPS_G1 };
HA_Conf_CheckButtons[42] = { var = "EmergencyGroups", subvar=2, text = HA_GUI_EMERGOPT_GRPS_G2 };
HA_Conf_CheckButtons[43] = { var = "EmergencyGroups", subvar=3, text = HA_GUI_EMERGOPT_GRPS_G3 };
HA_Conf_CheckButtons[44] = { var = "EmergencyGroups", subvar=4, text = HA_GUI_EMERGOPT_GRPS_G4 };
HA_Conf_CheckButtons[45] = { var = "EmergencyGroups", subvar=5, text = HA_GUI_EMERGOPT_GRPS_G5 };
HA_Conf_CheckButtons[46] = { var = "EmergencyGroups", subvar=6, text = HA_GUI_EMERGOPT_GRPS_G6 };
HA_Conf_CheckButtons[47] = { var = "EmergencyGroups", subvar=7, text = HA_GUI_EMERGOPT_GRPS_G7 };
HA_Conf_CheckButtons[48] = { var = "EmergencyGroups", subvar=8, text = HA_GUI_EMERGOPT_GRPS_G8 };

HA_Conf_CheckButtons[61] = { var = "EmergencyClasses", subvar = HA_ClassesID["DRUID"], text = HA_GUI_EMERGOPT_CLASSES_DRUID };
HA_Conf_CheckButtons[62] = { var = "EmergencyClasses", subvar = HA_ClassesID["HUNTER"], text = HA_GUI_EMERGOPT_CLASSES_HUNTER };
HA_Conf_CheckButtons[63] = { var = "EmergencyClasses", subvar = HA_ClassesID["MAGE"], text = HA_GUI_EMERGOPT_CLASSES_MAGE };
HA_Conf_CheckButtons[64] = { var = "EmergencyClasses", subvar = HA_ClassesID["PRIEST"], text = HA_GUI_EMERGOPT_CLASSES_PRIEST };
HA_Conf_CheckButtons[65] = { var = "EmergencyClasses", subvar = HA_ClassesID["ROGUE"], text = HA_GUI_EMERGOPT_CLASSES_ROGUE };
HA_Conf_CheckButtons[66] = { var = "EmergencyClasses", subvar = HA_ClassesID["WARLOCK"], text = HA_GUI_EMERGOPT_CLASSES_WARLOCK };
HA_Conf_CheckButtons[67] = { var = "EmergencyClasses", subvar = HA_ClassesID["WARRIOR"], text = HA_GUI_EMERGOPT_CLASSES_WARRIOR };
HA_Conf_CheckButtons[68] = { var = "EmergencyClasses", subvar = HA_ClassesID["PALADIN"], text = HA_GUI_EMERGOPT_CLASSES_PALA_SHAM };


--------------- Shared variables ---------------

--------------- Local variables ---------------


--------------- Internal functions ---------------

--------------- XML functions ---------------

function HA_MoveMinimapButton()
  HAMinimapButton:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 48 - (80 * cos(HA_Config.ButtonPosition)), (80 * sin(HA_Config.ButtonPosition)) - 52);
end

function HA_Toggle()
  if(HealersAssistMainFrame:IsVisible())
  then
    HealersAssistMainFrame:Hide();
  else
    HealersAssistMainFrame:Show();
  end
end

function HA_ToggleDropDown()
  if(TitanPanelFrame_OnLoad ~= nil)
  then
    HA_DropDown.point = "TOPRIGHT";
    HA_DropDown.relativePoint = "TOPLEFT";
  else
    HA_DropDown.point = "TOPLEFT";
    HA_DropDown.relativePoint = "TOPLEFT";
  end
  HA_DropDown.relativeTo="HAMinimapButton";
  ToggleDropDownMenu(1, nil, HA_DropDown);
end

function HA_DropDown_OnLoad()
  UIDropDownMenu_Initialize(this, HA_DropDown_Initialize, "MENU");
end

function HA_DropDown_Initialize()
  local dropdown;
  if ( UIDROPDOWNMENU_OPEN_MENU ) then
    dropdown = getglobal(UIDROPDOWNMENU_OPEN_MENU);
  else
    dropdown = this;
  end
  HA_DropDown_InitButtons();
end

function HA_DropDown_InitButtons()
  local info = {};
  
  info.text = "HA Options";
  info.isTitle = 1;
  info.justifyH = "CENTER";
  info.notCheckable = 1;
  UIDropDownMenu_AddButton(info);
  
  info = { };
  info.text = HA_GUI_SUBMENU_OPEN_OPTIONS;
  info.notCheckable = 1;
  info.func = HA_ToggleOption;
  UIDropDownMenu_AddButton(info);

  info = { };
  if(HA_Config.Lock)
  then
    info.text = HA_GUI_SUBMENU_UNLOCK;
  else
    info.text = HA_GUI_SUBMENU_LOCK;
  end
  info.notCheckable = 1;
  info.func = HA_ToggleLock;
  UIDropDownMenu_AddButton(info);
end

function HA_ToggleOption()
  if(HAConfFrame:IsVisible())
  then
    HAConfFrame:Hide();
  else
    HAConfFrame:Show();
  end
end

function HA_ToggleLock()
  if(HA_Config.Lock)
  then
    HA_Config.Lock = nil;
  else
    HA_Config.Lock = true;
  end
  HA_SetNewLock(false);
end

function HA_Config_SetNewSliderValue(slider)
  local id = slider:GetParent():GetID();
  local value = HA_Conf_Sliders[id];
  HA_Config[value.var] = slider:GetValue();

  if(id == _HA_CONFIG_SLIDER_MINIMAP_INDEX) -- Check dependencies
  then
    HA_MoveMinimapButton();
  elseif(id == _HA_CONFIG_SLIDER_KEEPVALUE_INDEX)
  then
    getglobal("HAConfFrameSlider".._HA_CONFIG_SLIDER_KEEPVALUE_INDEX.."SliderTitle"):SetText(HA_GUI_HEALOPT_KEEP_SPELL_TITLE..HA_Config[value.var].."sec");
  elseif(id == _HA_CONFIG_SLIDER_MINHEALTHPERCENT_INDEX)
  then
    getglobal("HAConfFrameSlider".._HA_CONFIG_SLIDER_MINHEALTHPERCENT_INDEX.."SliderTitle"):SetText(HA_GUI_EMERGOPT_MIN_HEALTH_TITLE..HA_Config[value.var].."%");
  elseif(id == _HA_CONFIG_SLIDER_HEALERLINES_INDEX)
  then
    getglobal("HAConfFrameSlider".._HA_CONFIG_SLIDER_HEALERLINES_INDEX.."SliderTitle"):SetText(HA_GUI_HEALOPT_LINES_TITLE..HA_Config[value.var]);
    HA_SetWidgetSizeAndPosition();
  elseif(id == _HA_CONFIG_SLIDER_EMERGLINES_INDEX)
  then
    getglobal("HAConfFrameSlider".._HA_CONFIG_SLIDER_EMERGLINES_INDEX.."SliderTitle"):SetText(HA_GUI_EMERGOPT_LINES_TITLE..HA_Config[value.var]);
    HA_SetWidgetSizeAndPosition();
  elseif(id == _HA_CONFIG_SLIDER_SCALE_INDEX)
  then
    getglobal("HAConfFrameSlider".._HA_CONFIG_SLIDER_SCALE_INDEX.."SliderTitle"):SetText(HA_GUI_SCALE_TITLE..HA_Config[value.var].."%");
    HA_SetWidgetSizeAndPosition();
  elseif(id == _HA_CONFIG_SLIDER_ALPHA_INDEX)
  then
    getglobal("HAConfFrameSlider".._HA_CONFIG_SLIDER_ALPHA_INDEX.."SliderTitle"):SetText(HA_GUI_ALPHA_TITLE..HA_Config[value.var].."%");
    HA_SetWidgetSizeAndPosition();
  elseif(id == _HA_CONFIG_SLIDER_GUI_REFRESH_INDEX)
  then
    getglobal("HAConfFrameSlider".._HA_CONFIG_SLIDER_GUI_REFRESH_INDEX.."SliderTitle"):SetText(HA_GUI_GUI_REFRESH_TITLE..HA_Config[value.var].." msec");
    HA_SetWidgetSizeAndPosition();
  elseif(id == _HA_CONFIG_SLIDER_BACKDROP_ALPHA_INDEX)
  then
    getglobal("HAConfFrameSlider".._HA_CONFIG_SLIDER_BACKDROP_ALPHA_INDEX.."SliderTitle"):SetText(HA_GUI_BACKDROP_ALPHA_TITLE..HA_Config[value.var].."%");
    HA_SetWidgetSizeAndPosition();
  end
end

function HA_Config_SetNewCheckState(button)
  local new_state = false;
  if(button:GetChecked())
  then
    new_state = true;
  end
  local id = button:GetID();
  local value = HA_Conf_CheckButtons[id];
  if(value.subvar)
  then
    HA_Config[value.var][value.subvar] = new_state;
  else
    HA_Config[value.var] = new_state;
  end
end

function HA_Config_OnLoad()
end

function HA_Config_Menu_OnShow()
  -- Debug
  if(HA_Config.Debug)
  then
    HA_Conf_Sliders[_HA_CONFIG_SLIDER_MINHEALTHPERCENT_INDEX].max=101;
  end

  -- Check buttons
  local button, string, checked;
  for index, value in HA_Conf_CheckButtons
  do
    button = getglobal("HAConfFrameCheckButton"..index);
    string = getglobal("HAConfFrameCheckButton"..index.."Text");
    checked = nil;
    if(value.subvar)
    then
      checked = HA_Config[value.var][value.subvar];
    else
      checked = HA_Config[value.var];
    end
    button:SetChecked(checked);
    string:SetText(value.text);
  end
  -- Sliders
  local slider, string, low, high;
  for index, value in HA_Conf_Sliders
  do
    slider = getglobal("HAConfFrameSlider"..index.."Slider");
    string = getglobal("HAConfFrameSlider"..index.."SliderTitle");
    low = getglobal("HAConfFrameSlider"..index.."SliderLow");
    high = getglobal("HAConfFrameSlider"..index.."SliderHigh");
    slider:SetMinMaxValues(value.min,value.max);
    slider:SetValueStep(1);
    slider:SetValue(HA_Config[value.var]);
    string:SetText(value.text);
    low:SetText(value.low);
    high:SetText(value.high);
    HA_Config_SetNewSliderValue(slider);
  end
end

function HA_Config_General_OnShow()
  HA_Config_Menu_OnShow();
end

function HA_Config_Healers_OnShow()
  HA_Config_Menu_OnShow();
  -- Check if RequestSpells are known
  for i=31,39
  do
    if(HA_Conf_CheckButtons[i] and HA_SpellCooldowns[HA_Conf_CheckButtons[i].subvar] == nil) -- Not available
    then
      getglobal("HAConfFrameCheckButton"..i):Disable();
      getglobal("HAConfFrameCheckButton"..i.."Text"):SetTextColor(0.6,0.6,0.6);
    end
  end
end

function HA_Config_Emergency_OnShow()
  HA_Config_Menu_OnShow();
end

function HA_Config_Plugins_OnShow()
  HA_Config_Menu_OnShow();
  HA_Config_Plugins_UpdateList();
end

function HA_Config_OnShow()
end

-------- HELP ------
function HA_Help_SetTooltip()
	local uiX, uiY = UIParent:GetCenter();
	local thisX, thisY = this:GetCenter();

	local anchor = "";
	if ( thisY > uiY ) then
		anchor = "BOTTOM";
	else
		anchor = "TOP";
	end
	
	if ( thisX < uiX  ) then
		if ( anchor == "TOP" ) then
			anchor = "TOPLEFT";
		else
			anchor = "BOTTOMRIGHT";
		end
	else
		if ( anchor == "TOP" ) then
			anchor = "TOPRIGHT";
		else
			anchor = "BOTTOMLEFT";
		end
	end
	GameTooltip:SetOwner(this, "ANCHOR_" .. anchor);
end

function HA_Help_LoadText()
 local texts = {
    HA_HELP_CHAN_OPT,
    HA_HELP_HEAL_OPT,
    HA_HELP_EMERG_OPT,
  };

  this.text = texts[this:GetID()];
end

