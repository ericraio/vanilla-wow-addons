--[[
  Guild Event Manager by Kiki of European Cho'gall
    Events list - By Kiki
]]

local selectChanItem = nil;
local GEM_Conf_ChanList = {};

function GEMOptions_Click_Validate()
  -- Save options
  local newdf = GEMOptions_DateFormat:GetText();
  if(newdf == "")
  then
    newdf = GEM_DATE_FORMAT;
  end
  GEM_Events.DateFormat = newdf;

  GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].BipOnChannel = GEMOptions_ChannelBip:GetChecked();
  GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].BipOnChannelValue = GEMOptions_ChannelBipValue:GetText();
  GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].FilterEvents = GEMOptions_FilterEvents:GetChecked();
  GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].UseServerTime = GEMOptions_DateUseServer:GetChecked();

  if(GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].comment ~= comment)
  then
    GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].comment = comment;
    GEM_COM_PlayerInfos();
  end
  
  GEMList_Notify(GEM_NOTIFY_MY_SUBSCRIPTION,""); -- Force update of the list
  GEM_Toggle();
end

function GEMOptions_SetBipBoxState()
  if(GEMOptions_ChannelBip:GetChecked())
  then
    GEMOptions_ChannelBipValue:EnableKeyboard(1);
    GEMOptions_ChannelBipValue:EnableMouse(1);
    GEMOptions_ChannelBipValue:SetTextColor(1,1,1);
  else
    GEMOptions_ChannelBipValue:EnableKeyboard(0);
    GEMOptions_ChannelBipValue:EnableMouse(0);
    GEMOptions_ChannelBipValue:SetTextColor(0.5,0.5,0.5);
  end
  if(GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].BipOnChannelValue)
  then
    GEMOptions_ChannelBipValue:SetText(GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].BipOnChannelValue);
  else
    GEMOptions_ChannelBipValue:SetText("");
  end
end

function GEMOptions_OnShow()
  if(GEM_COM_Channels == nil)
  then
    GEMOptionsFrame:Hide();
    return;
  end

  -- Change all that channel part by Add/Remove buttons
  if(GEM_DefaultSendChannel and GEM_COM_Channels[GEM_DefaultSendChannel]) -- Reset password that might have been lost
  then
    GEM_COM_Channels[GEM_DefaultSendChannel].password = GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].channels[1].password;
  end
  -- End of future change
  
  if(GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName] and GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].comment)
  then
    GEMOptions_Comment:SetText(GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].comment);
  else
    GEMOptions_Comment:SetText("");
  end
  GEM_MinimapArcSlider:SetValue(GEM_Events.MinimapArcOffset);
  GEM_MinimapRadiusSlider:SetValue(GEM_Events.MinimapRadiusOffset);
  GEMOptions_DateFormat:SetText(GEM_Events.DateFormat);
  GEMOptions_ChannelBip:SetChecked(GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].BipOnChannel);
  if(GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].BipOnChannelValue == nil)
  then
    GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].BipOnChannelValue = GEM_PlayerName;
  end
  GEMOptions_SetBipBoxState();
  GEMOptions_FilterEvents:SetChecked(GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].FilterEvents);
  GEMOptions_DateUseServer:SetChecked(GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].UseServerTime);
  
  GEMOptionsFrameChannelsListAddChannel:SetText("");
  GEMOptionsFrameChannelsListAddPassword:SetText("");
  GEMOptionsFrameChannelsListAddAlias:SetText("");
  GEMOptionsFrameChannelsListAddSlash:SetText("");
  selectChanItem = nil;
  GEM_Config_Channels_UpdateList();
end

--------------------------------------------
function GEMOptions_LoadChannelsConfig(pl_name)
  GEM_COM_Channels = {};

  if(GEM_Events.realms[GEM_Realm].my_names[pl_name].channels == nil) -- Never init channels
  then
    GEM_Events.realms[GEM_Realm].my_names[pl_name].channels = {};
    GEMOptions_AddChannel(GEM_DEFAULT_CHANNEL,GEM_DEFAULT_PASSWORD,GEM_DEFAULT_ALIAS,GEM_DEFAULT_SLASH);
  end

  GEM_DefaultSendChannel = nil;
  for i,chantab in GEM_Events.realms[GEM_Realm].my_names[pl_name].channels
  do
    local channame = chantab.name;
    GEM_COM_Channels[channame] = {};
    GEM_COM_Channels[channame].id = 0;
    if(i == 1)
    then
      GEM_COM_Channels[channame].default = true;
      GEM_DefaultSendChannel = channame;
    end
    GEM_COM_Channels[channame].password = chantab.password;
    GEM_COM_Channels[channame].alias = chantab.alias;
    GEM_COM_Channels[channame].slash = chantab.slash;
    GEM_COM_Channels[channame].notify = chantab.notify;
    GEM_COM_Channels[channame].retries = 0;
  end
end

function GEMOptions_AddChannel(channel,password,alias,slash)
  channel = strlower(channel);
  if(GEM_COM_Channels[channel] == nil) -- If channel is not in my list, init it
  then
    -- Add to saved config
    table.insert(GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].channels,{ name=channel, password=password, alias=alias, slash=slash });
  
    -- Add to running config
    GEM_COM_Channels[channel] = {};
    GEM_COM_Channels[channel].id = 0;
    GEM_COM_Channels[channel].retries = 0;
    GEM_COM_Channels[channel].password = password;
    GEM_COM_Channels[channel].alias = alias;
    GEM_COM_Channels[channel].slash = slash;

    if(GEM_DefaultSendChannel == nil) -- Only channel we join ?
    then
      GEM_DefaultSendChannel = channel;
    end
    
    -- Create Players struct
    if(GEM_Players[GEM_Realm] == nil) -- First time in this realm
    then
      GEM_Players[GEM_Realm] = {};
      GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEMOptions_AddChannel : First time in Realm "..GEM_Realm..", creating GEM_Players struct");
    end
    if(GEM_Players[GEM_Realm][channel] == nil) -- First time in this channel
    then
      GEM_Players[GEM_Realm][channel] = {};
      GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEMOptions_AddChannel : First time in channel "..channel.." for Realm "..GEM_Realm..", creating GEM_Players struct for this channel");
    end
    -- Join new channel
    GEM_InitChannels(false);
    GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEMOptions_AddChannel : Added new channel : "..channel);
  end
end

function GEMOptions_RemoveChannel(channel)
  if(GEM_COM_Channels[channel]) -- If channel is in my list, remove it
  then
    -- Unalias channel
    GEM_COM_UnAliasChannel(channel,GEM_COM_Channels[channel].alias,GEM_COM_Channels[channel].slash);
    -- Leave channel
    GEM_COM_LeaveChannel(channel);
    --[[while(GetChannelName(channel) ~= 0)
    do
      GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEMOptions_RemoveChannel : Waiting for channel "..channel.." leave notification...");
    end]]

    -- Remove from running config
    GEM_COM_Channels[channel] = nil;

    -- Remove from saved config
    for i,chantab in GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].channels
    do
      if(chantab.name == channel)
      then
        table.remove(GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].channels,i);
        break;
      end
    end

    -- Change default channel
    if(GEM_DefaultSendChannel == channel)
    then
      GEM_DefaultSendChannel = nil;
      for i,chantab in GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].channels
      do
        GEM_DefaultSendChannel = chantab.name;
        break;
      end
    end

    -- Clear all events from that channel
    for ev_id,event in GEM_Events.realms[GEM_Realm].events
    do
      GEM_CheckEventHasChannel(event);
      if(not GEM_IsChannelInList(event.channel))
      then
        if(not GEM_IsMyReroll(event.leader))
        then
          GEM_EVT_ClearEvent(ev_id,"Left channel",true);
        end
      end
    end
    
    -- Clear buffered send queue
    GEM_COM_PurgeQueueMessageForChannel(channel);

    GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEMOptions_RemoveChannel : Removed channel : "..channel);
  end
end

function GEMOptions_GetComment(pl_name)
  return "";
end

function GEMOptions_MustBip(str)
  local match = GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].BipOnChannelValue;
  if(not GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].BipOnChannel or match == nil or match == "")
  then
    return false;
  end
  if(string.find(str,match)) -- Try something like "(^match^) | (^match[%s]) | ([%s]match^) | ([%s]match[%s])"
  then
    return true;
  else
    return false;
  end
end

function GEM_Config_Channels_GetList()
  GEM_Conf_ChanList = {};
  for channame, tab in GEM_COM_Channels
  do
    local def = false;
    if(channame == GEM_DefaultSendChannel)
    then
      def = true;
    end
    tinsert(GEM_Conf_ChanList, { Name = channame; Pwd = tab.password; Slash = tab.slash; Alias = tab.alias; Default = def; Notify = tab.notify } );
  end
  return GEM_Conf_ChanList;
end

local GEM_CHANS_MAX_LIST_ITEMS = 4;

function GEM_Config_Channels_UpdateList()
	if(not GEMOptionsFrame:IsVisible()) then
		return;
	end
	local list = GEM_Config_Channels_GetList();
	local size = table.getn(list);
        local enableButtons = false;
	
	local offset = FauxScrollFrame_GetOffset(GEMOptionsFrameChannelsListScrollFrame);
	numButtons = GEM_CHANS_MAX_LIST_ITEMS;
	i = 1;
        GEMOptionsFrameChannelsListUpdateButton:Disable();
        GEMOptionsFrameChannelsListRemoveButton:Disable();

	while (i <= numButtons) do
		local j = i + offset
		local prefix = "GEMOptionsFrameChannelsListItem"..i;
		local button = getglobal(prefix);
		
		if (j <= size) then
			button.Name = list[j].Name;
                        button.Pwd = list[j].Pwd;
                        button.Alias = list[j].Alias;
                        button.Slash = list[j].Slash;
			getglobal(prefix.."Name"):SetText(list[j].Name);
			getglobal(prefix.."Pwd"):SetText(list[j].Pwd);
			getglobal(prefix.."Alias"):SetText(list[j].Alias);
			getglobal(prefix.."Slash"):SetText(list[j].Slash);
                        getglobal(prefix.."Notify"):SetChecked(list[j].Notify);
			button:Show();
			
			-- selected
			if (selectChanItem == list[j].Name) then
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
          GEMOptionsFrameChannelsListUpdateButton:Enable();
          if(table.getn(GEM_Conf_ChanList) > 1)
          then
            GEMOptionsFrameChannelsListRemoveButton:Enable();
          end
	end
	FauxScrollFrame_Update(GEMOptionsFrameChannelsListScrollFrame, size, GEM_CHANS_MAX_LIST_ITEMS, 10);
end

function GEM_Config_UpdateNotify(name,state)
  for i,infos in GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].channels
  do
    if(infos.name == name)
    then
      infos.notify = state;
      return;
    end
  end
end

function GEM_Config_OnClickNotify(button)
  local channel = getglobal(button:GetParent():GetName()).Name;
  if(GEM_COM_Channels[channel])
  then
    if(button:GetChecked())
    then
      GEM_COM_Channels[channel].notify = true;
    else
      GEM_COM_Channels[channel].notify = false;
    end
    GEM_Config_UpdateNotify(channel,GEM_COM_Channels[channel].notify);
  end
end

function GEM_Config_OnChanSelected(item)
  selectChanItem = item.Name;
  GEM_Config_Channels_UpdateList();
  GEMOptionsFrameChannelsListAddChannel:SetText(item.Name);
  GEMOptionsFrameChannelsListAddPassword:SetText(item.Pwd);
  GEMOptionsFrameChannelsListAddAlias:SetText(item.Alias);
  GEMOptionsFrameChannelsListAddSlash:SetText(item.Slash);
end

function GEM_Conf_Click_AddChannel()
  local name = GEMOptionsFrameChannelsListAddChannel:GetText();
  local pwd = GEMOptionsFrameChannelsListAddPassword:GetText();
  local alias = GEMOptionsFrameChannelsListAddAlias:GetText();
  local slash = GEMOptionsFrameChannelsListAddSlash:GetText();
  if(name == nil or name == "")
  then
    GEM_ChatPrint(GEM_TEXT_ERR_NEED_CHANNEL);
    GEMOptionsFrameChannelsListAddChannel:SetFocus();
    return;
  end
  if(GEM_COM_Channels[name])
  then
    GEM_ChatPrint("Already a channel with that name, use the 'Update' button to modify channel configuration.");
    GEMOptionsFrameChannelsListAddChannel:SetFocus();
    return;
  end
  if(pwd == nil) then pwd = ""; end
  if(alias == nil) then alias = ""; end
  if(slash == nil) then slash = ""; end
  if((alias == "" and slash ~= "") or (alias ~= "" and slash == ""))
  then
    if(alias == "")
    then
      GEMOptionsFrameChannelsListAddAlias:SetFocus();
    else
      GEMOptionsFrameChannelsListAddSlash:SetFocus();
    end
    GEM_ChatPrint(GEM_TEXT_ERR_NEED_ALIAS);
    return;
  end;
  
  GEMOptions_AddChannel(name,pwd,alias,slash);
  GEM_Config_Channels_UpdateList();
end

function GEM_Conf_Click_UpdateChannel()
  local name = GEMOptionsFrameChannelsListAddChannel:GetText();
  local pwd = GEMOptionsFrameChannelsListAddPassword:GetText();
  local alias = GEMOptionsFrameChannelsListAddAlias:GetText();
  local slash = GEMOptionsFrameChannelsListAddSlash:GetText();
  if(name == nil or name == "")
  then
    GEM_ChatPrint(GEM_TEXT_ERR_NEED_CHANNEL);
    GEMOptionsFrameChannelsListAddChannel:SetFocus();
    return;
  end
  if(name ~= selectChanItem)
  then
    GEM_ChatPrint("You must use the 'Add' button to create a new GEM channel");
    return;
  end
  if(pwd == nil) then pwd = ""; end
  if(alias == nil) then alias = ""; end
  if(slash == nil) then slash = ""; end

  if((alias == "" and slash ~= "") or (alias ~= "" and slash == ""))
  then
    if(alias == "")
    then
      GEMOptionsFrameChannelsListAddAlias:SetFocus();
    else
      GEMOptionsFrameChannelsListAddSlash:SetFocus();
    end
    GEM_ChatPrint(GEM_TEXT_ERR_NEED_ALIAS);
    return;
  end;
  
  local GEMchannelName = selectChanItem;
  local GEMchannelPassword = "";
  local GEMchannelAlias = "";
  local GEMchannelSlashCmd = "";
  
  if(GEM_COM_Channels[selectChanItem].password) then GEMchannelPassword = GEM_COM_Channels[selectChanItem].password; end
  if(GEM_COM_Channels[selectChanItem].alias) then GEMchannelAlias = GEM_COM_Channels[selectChanItem].alias; end
  if(GEM_COM_Channels[selectChanItem].slash) then GEMchannelSlashCmd = GEM_COM_Channels[selectChanItem].slash; end

  if(name ~= GEMchannelName or pwd ~= GEMchannelPassword or alias ~= GEMchannelAlias or slash ~= GEMchannelSlashCmd)
  then
    if(name == GEMchannelName and pwd == GEMchannelPassword) -- Don't remove chan if it is the same (but changing the alias)
    then
      for i,chantab in GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].channels
      do
        if(chantab.name == name)
        then
          chantab.alias = alias;
          chantab.slash = slash;
          break;
        end
      end
      if(alias == "") -- No alias anymore
      then
        GEM_COM_UnAliasChannel(name,GEM_COM_Channels[name].alias,GEM_COM_Channels[name].slash);
        GEM_COM_Channels[name].alias = "";
        GEM_COM_Channels[name].slash = "";
      else
        GEM_COM_Channels[name].alias = alias;
        GEM_COM_Channels[name].slash = slash;
        GEM_COM_AliasChannel(name,GEM_COM_Channels[name].alias,GEM_COM_Channels[name].slash);
      end
    else -- Not the same channel, remove and add new one
      GEMOptions_RemoveChannel(GEMchannelName);
      GEMOptions_AddChannel(name,pwd,alias,slash);
    end

    -- Force reroll lists to be re-init
    getglobal("GEMListFrameRerollDropDown").name = nil;
    getglobal("GEMNewRerollDropDown").name = nil;
  end
  GEM_Config_Channels_UpdateList();
end

function GEM_Conf_Click_DelChannel()
  if(selectChanItem and selectChanItem ~= "")
  then
    GEMOptions_RemoveChannel(selectChanItem);
    GEM_Config_Channels_UpdateList();
  end
end

