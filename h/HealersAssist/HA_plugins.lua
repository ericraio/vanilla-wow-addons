--[[
  Healers Assist by Kiki of European Cho'gall (Alliance)
    Plugins

]]


--------------- Constantes ---------------

HA_EVENT_WINDOW_SHOW = 1;
HA_EVENT_WINDOW_HIDE   = 2;
HA_EVENT_WINDOW_SIZED   = 3;

HA_EVENT_GUI_UPDATED_HEALERS = 5;
HA_EVENT_GUI_UPDATED_EMERGENCY = 6;

HA_EVENT_PLUGIN_LOAD = 11;
HA_EVENT_PLUGIN_UNLOAD = 12;

HA_EVENT_USE_ACTION = 31;
HA_EVENT_CAST_SPELL = 32;
HA_EVENT_CAST_SPELL_BY_NAME = 33;

HA_EVENT_RAIDER_JOINED   = 51;
HA_EVENT_RAIDER_LEFT  = 52;
HA_EVENT_HEALER_JOINED   = 53;
HA_EVENT_HEALER_LEFT = 54;
HA_EVENT_RAIDER_DIED   = 56;
HA_EVENT_RAIDER_RESURRECTED   = 57;
HA_EVENT_HEALER_DIED   = 58;
HA_EVENT_HEALER_RESURRECTED   = 59;


--------------- Shared variables ---------------

HA_Plugins = {};
HA_ActivePlugins = {};

--------------- Local variables ---------------

--------------- Local functions ---------------

local _HA_Plugin_AnchorConvertFrom = { ["LEFT"] = "TOPRIGHT", ["RIGHT"] = "TOPLEFT", ["TOP"] = "BOTTOMLEFT", ["BOTTOM"] = "TOPLEFT" };
local _HA_Plugin_AnchorConvertRelative = { ["LEFT"] = "TOPLEFT", ["RIGHT"] = "TOPRIGHT", ["TOP"] = "TOPLEFT", ["BOTTOM"] = "BOTTOMLEFT" };

local function _HA_SetPluginsAnchors()
  local pos,x,y,relative;
  local anchors = {};
  anchors["LEFT"] = "HealersAssistMainFrame";
  anchors["RIGHT"] = "HealersAssistMainFrame";
  anchors["TOP"] = "HealersAssistMainFrame";
  anchors["BOTTOM"] = "HealersAssistMainFrame";

  for n,pl in HA_ActivePlugins
  do
    if(pl.Anchors)
    then
      for frame,anchor in pl.Anchors
      do
        x = 0;
        y = 0;
        if(anchor.x) then x = anchor.x; end
        if(anchor.y) then y = anchor.y; end
        relative = anchors[anchor.point];
        if(relative ~= nil)
        then
          getglobal(frame):SetPoint(_HA_Plugin_AnchorConvertFrom[anchor.point],relative,_HA_Plugin_AnchorConvertRelative[anchor.point],x,y);
          anchors[anchor.point] = frame;
        end
      end
    end
  end
end

--------------- Shared functions ---------------

function HA_RegisterPlugin(plugin)
  if(type(plugin) ~= "table")
  then
    HA_ChatPrint("HA_RegisterPlugin : Failed to register plugin : Passed plugin is not a table");
    return;
  end
  if(plugin.Name == nil)
  then
    HA_ChatPrint("HA_RegisterPlugin : Failed to register plugin : Passed plugin has no 'Name' parameter");
    return;
  end
  if(type(plugin.Name) ~= "string")
  then
    HA_ChatPrint("HA_RegisterPlugin : Failed to register plugin : Passed plugin's 'Name' value is not a string");
    return;
  end
  local name = plugin.Name;
  -- Check for double load
  if(HA_Plugins[name] ~= nil)
  then
    HA_ChatPrint("HA_RegisterPlugin : Failed to register plugin '"..name.."'. Plugin already loaded");
    return;
  end
  if(plugin.OnEvent and type(plugin.OnEvent) ~= "function")
  then
    HA_ChatPrint("HA_RegisterPlugin : Failed to register plugin '"..name.."' : Passed plugin's 'OnEvent' value is not a function");
    return;
  end
  -- Must check other functions
  if(plugin.OnGetHealersList and type(plugin.OnGetHealersList) ~= "function")
  then
    HA_ChatPrint("HA_RegisterPlugin : Failed to register plugin '"..name.."' : Passed plugin's 'OnGetHealersList' value is not a function");
    return;
  end
  if(plugin.SortHealers and type(plugin.SortHealers) ~= "function")
  then
    HA_ChatPrint("HA_RegisterPlugin : Failed to register plugin '"..name.."' : Passed plugin's 'SortHealers' value is not a function");
    return;
  end
  if(plugin.OnGetEmergencyList and type(plugin.OnGetEmergencyList) ~= "function")
  then
    HA_ChatPrint("HA_RegisterPlugin : Failed to register plugin '"..name.."' : Passed plugin's 'OnGetEmergencyList' value is not a function");
    return;
  end
  if(plugin.SortEmergency and type(plugin.SortEmergency) ~= "function")
  then
    HA_ChatPrint("HA_RegisterPlugin : Failed to register plugin '"..name.."' : Passed plugin's 'SortEmergency' value is not a function");
    return;
  end
  -- Ok add plugin
  HA_Plugins[name] = plugin;
  HA_ChatDebug(HA_DEBUG_GLOBAL,"HA_RegisterPlugin : Successfully loaded plugin '"..name.."'");
end

function HA_CheckLoadPlugins()
  -- Remove not loaded plugins
  local new_list = {};
  for idx,name in HA_Config.PluginOrder
  do
    if(HA_Plugins[name])
    then
      tinsert(new_list,name);
    end
  end
  HA_Config.PluginOrder = new_list;

  -- Now load plugins
  for name in HA_Plugins
  do
    if(HA_GetPluginIndex(name) == 0) -- First time loaded
    then
      HA_ChoosePluginIndex(name);
      HA_ChatDebug(HA_DEBUG_GLOBAL,"HA_CheckLoadPlugins : First time for plugin '"..name.."'");
    end
    -- Check if we must auto load the plugin
    if(HA_IsAutoLoadedPlugin(name))
    then
      HA_LoadPlugin(name);
    end
  end
end

function HA_IsAutoLoadedPlugin(Name)
  if(HA_Config.PluginAuto[Name])
  then
    return true;
  end
  return false;
end

function HA_LoadPlugin(Name)
  local plugin = HA_Plugins[Name];
  HA_ActivePlugins[HA_GetPluginIndex(Name)] = plugin;
  if(plugin.OnEvent)
  then
    plugin.OnEvent(HA_EVENT_PLUGIN_LOAD);
    -- Forward current list of healers/raiders to the plugin
    for name,raider in HA_Raiders
    do
      plugin.OnEvent(HA_EVENT_RAIDER_JOINED,{name});
      if(raider.ishealer)
      then
        plugin.OnEvent(HA_EVENT_HEALER_JOINED,{name});
      end
    end

    _HA_SetPluginsAnchors();
    if(HealersAssistMainFrame:IsVisible())
    then
      plugin.OnEvent(HA_EVENT_WINDOW_SHOW);
      HA_SetWidgetSizeAndPosition();
    else
      plugin.OnEvent(HA_EVENT_WINDOW_HIDE);
    end
  end
end

function HA_UnLoadPlugin(Name)
  if(HA_Plugins[Name].OnEvent)
  then
    HA_Plugins[Name].OnEvent(HA_EVENT_WINDOW_HIDE);
    HA_Plugins[Name].OnEvent(HA_EVENT_PLUGIN_UNLOAD);
  end
  HA_ActivePlugins[HA_GetPluginIndex(Name)] = nil;
  _HA_SetPluginsAnchors();
end

function HA_SetAutoLoadedPlugin(Name,state)
  if(state)
  then
    HA_Config.PluginAuto[Name] = true;
  else
    HA_Config.PluginAuto[Name] = nil;
  end
end

function HA_IsPluginActive(Name)
  for i,pl in HA_ActivePlugins
  do
    if(pl.Name == Name)
    then
      return true;
    end
  end
  return false;
end

function HA_ChoosePluginIndex(Name)
  tinsert(HA_Config.PluginOrder,Name);
end

function HA_GetPluginIndex(Name)
  for i,n in HA_Config.PluginOrder
  do
    if(n == Name)
    then
      return i;
    end
  end
  return 0;
end

function HA_GetPluginsCount()
  return table.getn(HA_Config.PluginOrder);
end

function HA_MovePluginUp(Name)
  local idx = HA_GetPluginIndex(Name);
  if(idx ~= 0)
  then
    local old = HA_Config.PluginOrder[idx-1];
    HA_Config.PluginOrder[idx-1] = HA_Config.PluginOrder[idx];
    HA_Config.PluginOrder[idx] = old;
    local old_act = HA_ActivePlugins[idx-1];
    HA_ActivePlugins[idx-1] = HA_ActivePlugins[idx];
    HA_ActivePlugins[idx] = old_act;
  end
end

function HA_MovePluginDown(Name)
  local idx = HA_GetPluginIndex(Name);
  if(idx ~= 0)
  then
    local old = HA_Config.PluginOrder[idx+1];
    HA_Config.PluginOrder[idx+1] = HA_Config.PluginOrder[idx];
    HA_Config.PluginOrder[idx] = old;
    local old_act = HA_ActivePlugins[idx+1];
    HA_ActivePlugins[idx+1] = HA_ActivePlugins[idx];
    HA_ActivePlugins[idx] = old_act;
  end
end


--------------- XML functions ---------------

local selectPlItem = nil;
local HA_PL_MAX_LIST_ITEMS = 10;

function HA_Config_Plugins_OnSelected(item)
  selectPlItem = item.Name;
  HA_Config_Plugins_UpdateList();
end

function HA_Config_Plugins_OnClickAuto(button)
  if(button:GetChecked())
  then
    HA_SetAutoLoadedPlugin(button:GetParent().Name,true);
  else
    HA_SetAutoLoadedPlugin(button:GetParent().Name,false);
  end
end

function HA_Config_Plugins_OnClickLoad(button)
  if(button:GetChecked())
  then
    HA_LoadPlugin(button:GetParent().Name);
  else
    HA_UnLoadPlugin(button:GetParent().Name);
  end
end

function HA_Config_Plugins_GetList()
  local list = {};
  local auto,load;
  for idx,name in HA_Config.PluginOrder
  do
    if(HA_IsPluginActive(name)) then load = true; else load = false; end;
    if(HA_IsAutoLoadedPlugin(name)) then auto = true; else auto = false; end;
    list[idx] = { Name=name; Auto=auto; Load=load };
  end
  return list;
end

function HA_Config_Plugins_UpdateList()
	if(not HAConfFramePluginsMenuFrame:IsVisible()) then
		return;
	end
	local list = HA_Config_Plugins_GetList();
	local size = table.getn(list);
        local enableButtons = false;
	
	local offset = FauxScrollFrame_GetOffset(HAConfFramePluginsMenuFramePlListScrollFrame);
	numButtons = HA_PL_MAX_LIST_ITEMS;
	i = 1;

	while (i <= numButtons) do
		local j = i + offset
		local prefix = "HAConfFramePluginsMenuFramePlListItem"..i;
		local button = getglobal(prefix);
		
		if (j <= size) then
			button.Name = list[j].Name;
			getglobal(prefix.."Name"):SetText(list[j].Name);
                        getglobal(prefix.."Auto"):SetChecked(list[j].Auto);
                        getglobal(prefix.."Load"):SetChecked(list[j].Load);
			button:Show();
			
			-- selected
			if (selectPlItem == list[j].Name) then
				button:LockHighlight();
				enableButtons = true;
			else
				button:UnlockHighlight();
			end
		else
			button.Name = nil;
			button:Hide();
		end
		
		i = i + 1;
	end
	
	if(enableButtons)
	then
		HAConfFramePluginsMenuFrameConfigure:Show();
		HAConfFramePluginsMenuFrameMoveUp:Show();
		HAConfFramePluginsMenuFrameMoveDown:Show();
		if(HA_GetPluginIndex(selectPlItem) == 1)
		then
			HAConfFramePluginsMenuFrameMoveUp:Disable();
		else
			HAConfFramePluginsMenuFrameMoveUp:Enable();
		end
		if(HA_GetPluginIndex(selectPlItem) == HA_GetPluginsCount())
		then
			HAConfFramePluginsMenuFrameMoveDown:Disable();
		else
			HAConfFramePluginsMenuFrameMoveDown:Enable();
		end
		if(HA_Plugins[selectPlItem].OnConfigure)
		then
			HAConfFramePluginsMenuFrameConfigure:Enable();
		else
			HAConfFramePluginsMenuFrameConfigure:Disable();
		end
	else
		HAConfFramePluginsMenuFrameConfigure:Hide();
		HAConfFramePluginsMenuFrameMoveUp:Hide();
		HAConfFramePluginsMenuFrameMoveDown:Hide();
	end
	FauxScrollFrame_Update(HAConfFramePluginsMenuFramePlListScrollFrame, size, HA_PL_MAX_LIST_ITEMS, 1);
end

function HA_Config_Plugins_OnConfigure()
  HA_Plugins[selectPlItem].OnConfigure();
end

function HA_Config_Plugins_OnMoveUp()
  HA_MovePluginUp(selectPlItem);
  HA_Config_Plugins_UpdateList();
  _HA_SetPluginsAnchors();
end

function HA_Config_Plugins_OnMoveDown()
  HA_MovePluginDown(selectPlItem);
  HA_Config_Plugins_UpdateList();
  _HA_SetPluginsAnchors();
end
