GroupCalendar_cTitle = string.format(GroupCalendar_cTitle, gGroupCalendar_VersionString);

gGroupCalendar_Settings =
{
	Debug = false,
	ShowEventsInLocalTime = false,
};

gGroupCalendar_PlayerSettings = nil;
gGroupCalendar_RealmSettings = nil;

gGroupCalendar_PlayerName = nil;
gGroupCalendar_PlayerGuild = nil;
gGroupCalendar_PlayerLevel = nil;
gGroupCalendar_PlayerFactionGroup = nil;
gGroupCalendar_PlayerGuildRank = nil;
gGroupCalendar_RealmName = GetRealmName();
gGroupCalendar_Initialized = false;

gGroupCalendar_ServerTimeZoneOffset = 0; -- Offset that, when added to the server time yields the local time

gGroupCalendar_ActiveDialog = nil;

gGroupCalendar_CurrentPanel = 1;

gGroupCalendar_PanelFrames =
{
	"GroupCalendarCalendarFrame",
	"GroupCalendarChannelFrame",
	"GroupCalendarTrustFrame",
	"GroupCalendarAboutFrame",
};

function GroupCalendar_OnLoad()
	SlashCmdList["CALENDAR"] = GroupCalendar_ExecuteCommand;
	
	SLASH_CALENDAR1 = "/calendar";
	
	tinsert(UISpecialFrames, "GroupCalendarFrame");
	
	UIPanelWindows["GroupCalendarFrame"] = {area = "left", pushable = 5, whileDead = 1};
	
	gGroupCalendar_PlayerName = UnitName("player");
	gGroupCalendar_PlayerLevel = UnitLevel("player");
	
	-- Register events
	
	GroupCalendar_RegisterEvent(this, "VARIABLES_LOADED", GroupCalendar_VariablesLoaded);
	GroupCalendar_RegisterEvent(this, "PLAYER_ENTERING_WORLD", GroupCalendar_PlayerEnteringWorld);
	
	-- For updating auto-config settings and guild trust
	-- values
	
	GroupCalendar_RegisterEvent(this, "GUILD_ROSTER_UPDATE", GroupCalendar_GuildRosterUpdate);
	GroupCalendar_RegisterEvent(this, "PLAYER_GUILD_UPDATE", GroupCalendar_PlayerGuildUpdate);
	
	-- For updating the enabled events when the players
	-- level changes
	
	GroupCalendar_RegisterEvent(this, "PLAYER_LEVEL_UP", GroupCalendar_PlayerLevelUp);
	
	-- For monitoring the status of the chat channel
	
	GroupCalendar_RegisterEvent(this, "CHAT_MSG_SYSTEM", GroupCalendar_ChatMsgSystem);
	GroupCalendar_RegisterEvent(this, "CHAT_MSG_CHANNEL_NOTICE", GroupCalendar_ChatMsgChannelNotice);
	GroupCalendar_RegisterEvent(this, "CHAT_MSG_WHISPER", GroupCalendar_ChatMsgWhisper);
	
	-- For suspending/resuming the chat channel during logout
	
	GroupCalendar_RegisterEvent(this, "PLAYER_CAMPING", CalendarNetwork_SuspendChannel);
	GroupCalendar_RegisterEvent(this, "PLAYER_QUITING", CalendarNetwork_SuspendChannel);
	GroupCalendar_RegisterEvent(this, "LOGOUT_CANCEL", CalendarNetwork_ResumeChannel);
	
	-- For monitoring tradeskill cooldowns
	
	GroupCalendar_RegisterEvent(this, "TRADE_SKILL_UPDATE", EventDatabase_UpdateCurrentTradeskillCooldown);
	GroupCalendar_RegisterEvent(this, "TRADE_SKILL_SHOW", EventDatabase_UpdateCurrentTradeskillCooldown);
	GroupCalendar_RegisterEvent(this, "BAG_UPDATE_COOLDOWN", GroupCalendar_CheckItemCooldowns);
	GroupCalendar_RegisterEvent(this, "BAG_UPDATE", GroupCalendar_CheckItemCooldowns);
	
	-- For managing group invites
	
	GroupCalendar_RegisterEvent(this, "PARTY_MEMBERS_CHANGED", CalendarGroupInvites_PartyMembersChanged);
	GroupCalendar_RegisterEvent(this, "RAID_ROSTER_UPDATE", CalendarGroupInvites_PartyMembersChanged);
	GroupCalendar_RegisterEvent(this, "PARTY_LOOT_METHOD_CHANGED", CalendarGroupInvites_PartyLootMethodChanged);
	
	-- For dragging the window
	
	this:RegisterForDrag("LeftButton");
	
	-- Tabs
	
	PanelTemplates_SetNumTabs(this, table.getn(gGroupCalendar_PanelFrames));
	GroupCalendarFrame.selectedTab = gGroupCalendar_CurrentPanel;
	PanelTemplates_UpdateTabs(this);
	
	-- Done initializing
	
	if DEFAULT_CHAT_FRAME then
		DEFAULT_CHAT_FRAME:AddMessage(GroupCalendar_cLoadMessage, 0.8, 0.8, 0.2);
	end
end

function GroupCalendar_RegisterEvent(pFrame, pEvent, pHandler)
	if not pHandler then
		Calendar_ErrorMessage("GroupCalendar: Attemping to install a nil handler for event "..pEvent);
		return;
	end
	
	if not pFrame.EventHandlers then
		pFrame.EventHandlers = {};
	end
	
	pFrame.EventHandlers[pEvent] = pHandler;
	pFrame:RegisterEvent(pEvent);
end

function GroupCalendar_UnregisterEvent(pFrame, pEvent)
	if pFrame.EventHandlers then
		pFrame.EventHandlers[pEvent] = nil;
	end
	
	pFrame:UnregisterEvent(pEvent);
end

function GroupCalendar_DispatchEvent(pFrame, pEvent)
	if not pFrame.EventHandlers then	
		return false;
	end
	
	local	vEventHandler = pFrame.EventHandlers[pEvent];
	
	if not vEventHandler then
		Calendar_ErrorMessage("GroupCalendar: No event handler for "..pEvent);
		return false;
	end
	
	vEventHandler(pEvent);
	return true;
end

function GroupCalendar_VariablesLoaded()
	gGroupCalendar_MinimumEventDate = Calendar_GetCurrentLocalDate() - gGroupCalendar_MaximumEventAge;
	
	EventDatabase_SetUserName(gGroupCalendar_PlayerName);
	EventDatabase_PlayerLevelChanged(gGroupCalendar_PlayerLevel);
	CalendarNetwork_CheckPlayerGuild();
	
	EventDatabase_Initialize();
	
	CalendarNetwork_CalendarLoaded();
end

function GroupCalendar_OnShow()
	PlaySound("igCharacterInfoOpen");
	
	local	vYear, vMonth, vDay, vHour, vMinute = Calendar_GetCurrentYearMonthDayHourMinute();
	local	vMonthStartDate = Calendar_ConvertMDYToDate(vMonth, 1, vYear);
	
	-- Update the guild roster
	
	if IsInGuild() and GetNumGuildMembers() == 0 then
		GuildRoster();
	end
	
	Calendar_SetDisplayDate(vMonthStartDate);
	Calendar_SetActualDate(vMonthStartDate + vDay - 1);
	GroupCalendar_ShowPanel(1); -- Always switch  back to the Calendar view when showing the window
	
	GroupCalendarUseServerTime:SetChecked(not gGroupCalendar_Settings.ShowEventsInLocalTime);
end

function GroupCalendar_OnHide()
	PlaySound("igCharacterInfoClose");
	CalendarEventEditor_DoneEditing();
	CalendarEventViewer_DoneViewing();
	CalendarEditor_Close();
end

function GroupCalendar_OnEvent(pEvent)
	local	vLatencyStartTime;
	
	if gGroupCalendar_Settings.DebugLatency then
		vLatencyStartTime = GetTime();
	end
	
	if GroupCalendar_DispatchEvent(this, pEvent) then
		
		-- Handled
		
	elseif pEvent == "CHAT_MSG_SYSTEM" then
		CalendarNetwork_SystemMessage(arg1);
		CalendarGroupInvites_SystemMessage(arg1);
		
	elseif pEvent == "GUILD_ROSTER_UPDATE" then
		-- Ignore the update if we're not initialized yet
		
		if not gGroupCalendar_Initialized then
			return;
		end
		
		CalendarNetwork_GuildRosterChanged();
		CalendarGroupInvites_GuildRosterChanged();
		
	elseif pEvent == "PLAYER_GUILD_UPDATE" then
		CalendarNetwork_CheckPlayerGuild();

		-- Ignore the update if we're not initialized yet
		
		if not gGroupCalendar_Initialized then
			return;
		end
		
		GroupCalendar_UpdateEnabledControls();
		
	elseif pEvent == "PLAYER_LEVEL_UP" then
		gGroupCalendar_PlayerLevel = tonumber(arg1);
		EventDatabase_PlayerLevelChanged(gGroupCalendar_PlayerLevel);
		GroupCalendar_MajorDatabaseChange(nil);
	end
	
	--
	
	if gGroupCalendar_Settings.DebugLatency then
		local	vElapsed = GetTime() - vLatencyStartTime;
		
		if vElapsed > 0.1 then
			Calendar_DebugMessage("Event "..pEvent.." took "..vElapsed.."s to execute");
		end
	end
end

function GroupCalendar_PlayerEnteringWorld(pEvent)
	Calendar_InitDebugging();
	
	gGroupCalendar_PlayerSettings = GroupCalendar_GetPlayerSettings(gGroupCalendar_PlayerName, GetRealmName());
	gGroupCalendar_RealmSettings = GroupCalendar_GetRealmSettings(GetRealmName());
	
	gGroupCalendar_PlayerLevel = UnitLevel("player");
	gGroupCalendar_PlayerFactionGroup = UnitFactionGroup("player");
	gGroupCalendar_PlayerSettings = GroupCalendar_GetPlayerSettings(gGroupCalendar_PlayerName, GetRealmName());
	gGroupCalendar_RealmSettings = GroupCalendar_GetRealmSettings(GetRealmName());
	EventDatabase_PlayerLevelChanged(gGroupCalendar_PlayerLevel);
	GroupCalendar_CalculateTimeZoneOffset();
	GroupCalendar_MajorDatabaseChange(nil);
end

function GroupCalendar_ChatMsgChannel(pEvent)
	if arg9
	and strlower(arg9) == gGroupCalendar_Channel.NameLower
	and arg1
	and type(arg1) == "string"
	then
		if arg2 == gGroupCalendar_PlayerName then
			-- Ignore messages from ourselves
			
			if not gGroupCalendar_Settings.Debug then
				return;
			end
			
			-- Special debugging case: allow self-send of messages starting with '!'
			
			if strsub(arg1, 1, 1) ~= "!" then
				return;
			end
			
			arg1 = strsub(arg1, 2);
		end
		
		-- Clean up drunkeness
		
		if strsub(arg1, -8) == " ...hic!" then
			arg1 = strsub(arg1, 1, -9);
		end
		
		arg1 = Calendar_UnescapeChatString(arg1);
		
		--
		
		CalendarNetwork_ChannelMessageReceived(arg2, arg1);
	end
end

function GroupCalendar_ChatMsgChannelNotice(pEvent)
	local	vChannelMessage = arg1;
	local	vChannelName = arg4;
	local	vChannelID = arg8;
	local	vActualChannelName = arg9;

	CalendarNetwork_ChannelNotice(vChannelMessage, vChannelName, vChannelID, vActualChannelName);
end

function GroupCalendar_ChatMsgWhisper(pEvent)
	CalendarWhisperLog_AddWhisper(arg2, arg1);
end

function GroupCalendar_ChatMsgSystem(pEvent)
	CalendarNetwork_SystemMessage(arg1);
	CalendarGroupInvites_SystemMessage(arg1);
end

function GroupCalendar_GuildRosterUpdate(pEvent)
	-- Ignore the update if we're not initialized yet

	if not gGroupCalendar_Initialized then
		return;
	end

	CalendarNetwork_GuildRosterChanged();
	CalendarGroupInvites_GuildRosterChanged();
end

function GroupCalendar_PlayerGuildUpdate(pEvent)
	CalendarNetwork_CheckPlayerGuild();

	-- Ignore the update if we're not initialized yet
	
	if not gGroupCalendar_Initialized then
		return;
	end
	
	GroupCalendar_UpdateEnabledControls();
end

function GroupCalendar_PlayerLevelUp(pEvent)
	gGroupCalendar_PlayerLevel = tonumber(arg1);
	EventDatabase_PlayerLevelChanged(gGroupCalendar_PlayerLevel);
	GroupCalendar_MajorDatabaseChange(nil);
end

GroupCalendar_cCooldownItemInfo =
{
	[15846] = {EventID = "Leatherworking"}, -- Salt Shaker
	[17716] = {EventID = "Snowmaster"}, -- Snowmaster 9000
};

function GroupCalendar_CheckItemCooldowns()
	for vBagIndex = 0, NUM_BAG_SLOTS do
		local	vNumBagSlots = GetContainerNumSlots(vBagIndex);
		
		for vBagSlotIndex = 1, vNumBagSlots do
			local	vItemLink = GetContainerItemLink(vBagIndex, vBagSlotIndex);
			
			if vItemLink then
				local	vStartIndex, vEndIndex, vLinkColor, vItemCode, vItemEnchantCode, vItemSubCode, vUnknownCode, vItemName = strfind(vItemLink, "|(%x+)|Hitem:(%d+):(%d+):(%d+):(%d+)|h%[([^%]]+)%]|h|r");
				
				if vStartIndex then
					vItemCode = tonumber(vItemCode);
					
					local	vCooldownItemInfo = GroupCalendar_cCooldownItemInfo[vItemCode];
					
					if vCooldownItemInfo then
						local vStart, vDuration, vEnable = GetContainerItemCooldown(vBagIndex, vBagSlotIndex);
						
						-- local	texture, itemCount, locked, quality, readable = GetContainerItemInfo(vBagIndex, vBagSlotIndex);
						-- Calendar_TestMessage(vItemName..": "..texture);
						
						if vEnable > 0 then
							vRemainingTime = vDuration - (GetTime() - vStart);
							
							if vRemainingTime > 0 then
								EventDatabase_ScheduleTradeskillCooldownEvent(gGroupCalendar_UserDatabase, vCooldownItemInfo.EventID, vRemainingTime);
							end
						end
					end
				end
			end
		end
	end
end

function GroupCalendar_UpdateEnabledControls()
	if GroupCalendarFrame.selectedTab == 1 then
		-- Update the calendar display
		
	elseif GroupCalendarFrame.selectedTab == 2 then
		-- Update the channel frame
		
		Calendar_SetCheckButtonEnable(GroupCalendarAutoChannelConfig, IsInGuild());
		
		Calendar_SetEditBoxEnable(GroupCalendarChannelName, GroupCalendarManualChannelConfig:GetChecked());
		Calendar_SetEditBoxEnable(GroupCalendarChannelPassword, GroupCalendarManualChannelConfig:GetChecked());
		
		if IsInGuild()
		and CanEditPublicNote()
		and GroupCalendarManualChannelConfig:GetChecked() then
			Calendar_SetCheckButtonEnable(GroupCalendarStoreAutoConfig, true);
			
			if GroupCalendarStoreAutoConfig:GetChecked() then
				Calendar_SetEditBoxEnable(GroupCalendarAutoConfigPlayer, true);
			else
				Calendar_SetEditBoxEnable(GroupCalendarAutoConfigPlayer, false);
			end
		else
			Calendar_SetCheckButtonEnable(GroupCalendarStoreAutoConfig, false);
			Calendar_SetEditBoxEnable(GroupCalendarAutoConfigPlayer, false);
		end
		
		Calendar_SetButtonEnable(GroupCalendarApplyChannelButton, GroupCalendar_ChannelPanelHasChanges());
		
	elseif GroupCalendarFrame.selectedTab == 3 then
		-- Update the trust frame
		
		if gGroupCalendar_PlayerSettings.Channel.AutoConfig then
			Calendar_SetDropDownEnable(GroupCalendarTrustGroup, false);
			Calendar_SetDropDownEnable(GroupCalendarTrustMinRank, false);
		else
			GroupCalendar_SaveTrustGroup();
			
			Calendar_SetDropDownEnable(GroupCalendarTrustGroup, true);
			Calendar_SetDropDownEnable(GroupCalendarTrustMinRank, UIDropDownMenu_GetSelectedValue(GroupCalendarTrustGroup) == 2);
		end
		
		if UIDropDownMenu_GetSelectedValue(GroupCalendarTrustGroup) == 2 then
			GroupCalendarTrustMinRank:Show();
		else
			GroupCalendarTrustMinRank:Hide();
		end
		
	elseif GroupCalendarFrame.selectedTab == 4 then
		-- Update the ignore frame
	
	end
end

function GroupCalendar_SetAutoChannelConfig(pEnableAutoConfig)
	GroupCalendarAutoChannelConfig:SetChecked(pEnableAutoConfig);
	GroupCalendarManualChannelConfig:SetChecked(not pEnableAutoConfig);
	
	GroupCalendar_UpdateEnabledControls();
end

function GroupCalendar_EnableAutoConfigPlayer(pEnableStoreAutoConfig)
	GroupCalendarStoreAutoConfig:SetChecked(pEnableStoreAutoConfig);
	GroupCalendar_UpdateEnabledControls();
end

function GroupCalendar_SavePanel(pIndex)
	if pIndex == 2 then
		-- Channel panel
		
		gGroupCalendar_PlayerSettings.Channel.AutoConfig = GroupCalendarAutoChannelConfig:GetChecked() == 1;
		
		if gGroupCalendar_PlayerSettings.Channel.AutoConfig then
			gGroupCalendar_PlayerSettings.Channel.Name = nil;
			gGroupCalendar_PlayerSettings.Channel.Password = nil;
			gGroupCalendar_PlayerSettings.Channel.AutoConfigPlayer = nil;
			
			CalendarNetwork_ScheduleAutoConfig(0.5);
			
			GroupCalendar_ShowPanel(pIndex); -- Refresh the controls
		else
			gGroupCalendar_PlayerSettings.Channel.Name = GroupCalendarChannelName:GetText();

			if gGroupCalendar_PlayerSettings.Channel.Name == "" then
				gGroupCalendar_PlayerSettings.Channel.Name = nil;
			end
			
			gGroupCalendar_PlayerSettings.Channel.Password = GroupCalendarChannelPassword:GetText();
			
			if gGroupCalendar_PlayerSettings.Channel.Password == "" then
				gGroupCalendar_PlayerSettings.Channel.Password = nil;
			end
			
			CalendarNetwork_SetChannel(gGroupCalendar_PlayerSettings.Channel.Name, gGroupCalendar_PlayerSettings.Channel.Password);
			
			if GroupCalendarStoreAutoConfig:GetChecked() then
				gGroupCalendar_PlayerSettings.Channel.AutoConfigPlayer = GroupCalendarAutoConfigPlayer:GetText();
				CalendarNetwork_SetAutoConfigData(gGroupCalendar_PlayerSettings.Channel.AutoConfigPlayer);
			elseif gGroupCalendar_PlayerSettings.Channel.AutoConfigPlayer then
				gGroupCalendar_PlayerSettings.Channel.AutoConfigPlayer = nil;

				if CanEditPublicNote() then
					CalendarNetwork_RemoveAllAutoConfigData();
				end
			end
		end
	elseif pIndex == 3 then
		-- Trust panel
		
		if not gGroupCalendar_PlayerSettings.Channel.AutoConfig then
			GroupCalendar_SaveTrustGroup();
		end
	end
	
	GroupCalendar_UpdateEnabledControls();
end

function GroupCalendar_ChannelPanelHasChanges()
	if (GroupCalendarAutoChannelConfig:GetChecked() == 1)
	~= gGroupCalendar_PlayerSettings.Channel.AutoConfig then
		return true;
	end
	
	if GroupCalendarManualChannelConfig:GetChecked() then
		local	vChannelName = gGroupCalendar_PlayerSettings.Channel.Name;
		
		if not vChannelName then
			vChannelName = "";
		end
		
		local	vChannelPassword = gGroupCalendar_PlayerSettings.Channel.Password;
		
		if not vChannelPassword then
			vChannelPassword = "";
		end
		
		if GroupCalendarChannelName:GetText() ~= vChannelName
		or GroupCalendarChannelPassword:GetText() ~= vChannelPassword then
			return true;
		end
	end
	
	local	vStoreAutoConfigIsEnabled = (not gGroupCalendar_PlayerSettings.Channel.AutoConfig)
	                               and (gGroupCalendar_PlayerSettings.Channel.AutoConfigPlayer ~= nil);

	if (GroupCalendarStoreAutoConfig:GetChecked() == 1)
	~= vStoreAutoConfigIsEnabled then
		return true;
	end
	
	if GroupCalendarStoreAutoConfig:GetChecked()
	and GroupCalendarAutoConfigPlayer:GetText() ~= gGroupCalendar_PlayerSettings.Channel.AutoConfigPlayer then
		return true;
	end
	
	return false;
end

function GroupCalendar_SaveTrustGroup()
	local	vTrustGroup = UIDropDownMenu_GetSelectedValue(GroupCalendarTrustGroup);
	local	vChanged = false;
	
	if vTrustGroup == 1
	and not gGroupCalendar_PlayerSettings.Security.TrustAnyone then
		gGroupCalendar_PlayerSettings.Security.TrustAnyone = true;
		gGroupCalendar_PlayerSettings.Security.TrustGuildies = false;
		vChanged = true;
	elseif vTrustGroup == 2 then
		if not gGroupCalendar_PlayerSettings.Security.TrustGuildies then
			gGroupCalendar_PlayerSettings.Security.TrustAnyone = false;
			gGroupCalendar_PlayerSettings.Security.TrustGuildies = true;
			vChanged = true;
		end
		
		local	vMinTrustedRank = UIDropDownMenu_GetSelectedValue(GroupCalendarTrustMinRank);
		
		if not vMinTrustedRank then
			vMinTrustedRank = 1;
			CalendarDropDown_SetSelectedValue(GroupCalendarTrustMinRank, vMinTrustedRank);
		end
		
		if vMinTrustedRank ~= gGroupCalendar_PlayerSettings.Security.MinTrustedRank then
			gGroupCalendar_PlayerSettings.Security.MinTrustedRank = vMinTrustedRank;
			vChanged = true;
		end
	elseif vTrustGroup == 3
	and (gGroupCalendar_PlayerSettings.Security.TrustAnyone
	or gGroupCalendar_PlayerSettings.Security.TrustGuildies) then
		gGroupCalendar_PlayerSettings.Security.TrustAnyone = false;
		gGroupCalendar_PlayerSettings.Security.TrustGuildies = false;
		vChanged = true;
	end
	
	if vChanged then
		-- Update auto-config string with the trust config
		
		if CanEditPublicNote()
		and gGroupCalendar_PlayerSettings.Channel.AutoConfigPlayer then
			CalendarNetwork_SetAutoConfigData(gGroupCalendar_PlayerSettings.Channel.AutoConfigPlayer);
		end
		
		CalendarTrust_TrustSettingsChanged();
	end
end

function GroupCalendar_ShowPanel(pPanelIndex)
	if gGroupCalendar_CurrentPanel > 0
	and gGroupCalendar_CurrentPanel ~= pPanelIndex then
		GroupCalendar_HidePanel(gGroupCalendar_CurrentPanel);
	end
	
	-- NOTE: Don't check for redundant calls since this function
	-- will be called to reset the field values as well as to 
	-- actuall show the panel when it's hidden
	
	gGroupCalendar_CurrentPanel = pPanelIndex;
	
	-- Hide the event editor/viewer if the calendar panel is being hidden
	
	if pPanelIndex ~= 1 then
		CalendarEventEditor_DoneEditing();
		CalendarEventViewer_DoneViewing();
		CalendarEditor_Close();
	end
	
	-- Update the control values
	
	if pPanelIndex == 1 then
	elseif pPanelIndex == 2 then
		-- Channel panel
		
		if gGroupCalendar_PlayerSettings.Channel.AutoConfig
		and not IsInGuild() then
			gGroupCalendar_PlayerSettings.Channel.AutoConfig = false;
		end
		
		GroupCalendarAutoChannelConfig:SetChecked(gGroupCalendar_PlayerSettings.Channel.AutoConfig);
		GroupCalendarManualChannelConfig:SetChecked(not gGroupCalendar_PlayerSettings.Channel.AutoConfig);
		
		local	vChannelName;
		local	vAutoConfigPlayer;
		
		if gGroupCalendar_PlayerSettings.Channel.AutoConfig then
			vChannelName = gGroupCalendar_Channel.Name;
			if gGroupCalendar_Channel.Password then
				GroupCalendarChannelPassword:SetText("******");
			else
				GroupCalendarChannelPassword:SetText("");
			end
			
			vAutoConfigPlayer = gGroupCalendar_Channel.AutoPlayer;
		else
			vChannelName = gGroupCalendar_PlayerSettings.Channel.Name;
			vAutoConfigPlayer = gGroupCalendar_PlayerSettings.Channel.AutoConfigPlayer;
			
			if gGroupCalendar_PlayerSettings.Channel.Password then
				GroupCalendarChannelPassword:SetText(gGroupCalendar_PlayerSettings.Channel.Password);
			else
				GroupCalendarChannelPassword:SetText("");
			end
		end
		
		if vChannelName ~= nil then
			GroupCalendarChannelName:SetText(vChannelName);
		else
			GroupCalendarChannelName:SetText("");
		end
		
		if vAutoConfigPlayer then
			GroupCalendarAutoConfigPlayer:SetText(vAutoConfigPlayer);
		else
			GroupCalendarAutoConfigPlayer:SetText("");
		end
		
		if not gGroupCalendar_PlayerSettings.Channel.AutoConfig
		and gGroupCalendar_PlayerSettings.Channel.AutoConfigPlayer then
			GroupCalendarStoreAutoConfig:SetChecked(true);
		else
			GroupCalendarStoreAutoConfig:SetChecked(false);
		end
		
		GroupCalendar_UpdateChannelStatus();
		
	elseif pPanelIndex == 3 then
		-- Trust panel
		
		GroupCalendarTrustGroup.ChangedValueFunc = GroupCalendar_UpdateEnabledControls;
		
		if gGroupCalendar_PlayerSettings.Security.TrustGuildies
		and not IsInGuild() then
			gGroupCalendar_PlayerSettings.Security.TrustGuildies = false;
		end
		
		if gGroupCalendar_PlayerSettings.Security.TrustAnyone then
			CalendarDropDown_SetSelectedValue(GroupCalendarTrustGroup, 1);
		elseif gGroupCalendar_PlayerSettings.Security.TrustGuildies then
			CalendarDropDown_SetSelectedValue(GroupCalendarTrustGroup, 2);
		else
			CalendarDropDown_SetSelectedValue(GroupCalendarTrustGroup, 3);
		end
		
		if gGroupCalendar_PlayerSettings.Security.TrustGuildies then
			GroupCalendarTrustMinRank:Show();
			
			if gGroupCalendar_PlayerSettings.Security.MinTrustedRank ~= nil then
				CalendarDropDown_SetSelectedValue(GroupCalendarTrustMinRank, gGroupCalendar_PlayerSettings.Security.MinTrustedRank);
			else
				UIDropDownMenu_SetText("", GroupCalendarTrustMinRank); -- In case the value doesn't exist
			end
		else
			GroupCalendarTrustMinRank:Hide();
		end
		
		CalendarPlayerList_SetItemFunction(CalendarTrustedPlayersList, GroupCalendar_GetIndexedTrustedPlayer);
		CalendarPlayerList_SetSelectionChangedFunction(CalendarTrustedPlayersList, GroupCalendar_TrustedPlayerSelected);
		
		CalendarPlayerList_SetItemFunction(CalendarExcludedPlayersList, GroupCalendar_GetIndexedExcludedPlayer);
		CalendarPlayerList_SetSelectionChangedFunction(CalendarExcludedPlayersList, GroupCalendar_ExcludedPlayerSelected);
	end
	
	GroupCalendar_UpdateEnabledControls();
	
	getglobal(gGroupCalendar_PanelFrames[pPanelIndex]):Show();
	
	PanelTemplates_SetTab(GroupCalendarFrame, pPanelIndex);
end

function GroupCalendar_HidePanel(pFrameIndex)
	if gGroupCalendar_CurrentPanel ~= pFrameIndex then
		return;
	end
	
	GroupCalendar_SavePanel(pFrameIndex);
	
	getglobal(gGroupCalendar_PanelFrames[pFrameIndex]):Hide();
	gGroupCalendar_CurrentPanel = 0;
end

function GroupCalendar_UpdateChannelStatus()
	local	vChannelStatus = CalendarNetwork_GetChannelStatus();
	local	vStatusText = GroupCalendar_cChannelStatus[vChannelStatus];
	
	GroupCalendarChannelStatus:SetText(string.format(vStatusText.mText, gGroupCalendar_Channel.StatusMessage));
	GroupCalendarChannelStatus:SetTextColor(vStatusText.mColor.r, vStatusText.mColor.g, vStatusText.mColor.b);
	
	if vChannelStatus == "Connected" then
		Calendar_SetButtonEnable(GroupCalendarConnectChannelButton, true);
		GroupCalendarConnectChannelButton:SetText(GroupCalendar_cDisconnectChannel);
	elseif vChannelStatus == "Disconnected" or vChannelStatus == "Error" then
		Calendar_SetButtonEnable(GroupCalendarConnectChannelButton, true);
		GroupCalendarConnectChannelButton:SetText(GroupCalendar_cConnectChannel);
	else
		Calendar_SetButtonEnable(GroupCalendarConnectChannelButton, false);
	end
end

function GroupCalendar_FixPlayerName(pName)
	if pName == nil
	or pName == "" then
		return nil;
	end
	
	local	vFirstChar = string.sub(pName, 1, 1);
	
	if (vFirstChar >= "a" and vFirstChar <= "z")
	or (vFirstChar >= "A" and vFirstChar <= "Z") then
		return string.upper(vFirstChar)..string.lower(string.sub(pName, 2));
	else
		return pName;
	end
end

function GroupCalendar_AddTrustedPlayer(pPlayerName)
	local	vPlayerName = GroupCalendar_FixPlayerName(pPlayerName);
	
	if vPlayerName == nil then
		return;
	end
	
	gGroupCalendar_PlayerSettings.Security.Player[vPlayerName] = 1;
	GroupCalendar_UpdateTrustedPlayerList();
	CalendarTrust_TrustSettingsChanged();
end

function GroupCalendar_AddExcludedPlayer(pPlayerName)
	local	vPlayerName = GroupCalendar_FixPlayerName(pPlayerName);

	if vPlayerName == nil then
		return;
	end
	
	gGroupCalendar_PlayerSettings.Security.Player[vPlayerName] = 2;
	GroupCalendar_UpdateTrustedPlayerList();
	CalendarTrust_TrustSettingsChanged();
end

function GroupCalendar_RemoveTrustedPlayer(pPlayerName)
	local	vPlayerName = GroupCalendar_FixPlayerName(pPlayerName);

	if vPlayerName == nil then
		return;
	end
	
	gGroupCalendar_PlayerSettings.Security.Player[vPlayerName] = nil;
	
	GroupCalendar_UpdateTrustedPlayerList();
	
	CalendarPlayerList_SelectIndexedPlayer(CalendarTrustedPlayersList, 0);
	CalendarPlayerList_SelectIndexedPlayer(CalendarExcludedPlayersList, 0);
	
	CalendarTrust_TrustSettingsChanged();
end

function GroupCalendar_UpdateTrustedPlayerList()
	CalendarPlayerList_Update(CalendarTrustedPlayersList);
	CalendarPlayerList_Update(CalendarExcludedPlayersList);
end

function GroupCalendar_GetIndexedTrustedPlayer(pIndex)
	if pIndex == 0 then
		return CalendarTrust_GetNumTrustedPlayers(1);
	end
	
	return
	{
		Text = CalendarTrust_GetIndexedTrustedPlayers(1, pIndex);
	};
end

function GroupCalendar_GetIndexedExcludedPlayer(pIndex)
	if pIndex == 0 then
		return CalendarTrust_GetNumTrustedPlayers(2);
	end
	
	return
	{
		Text = CalendarTrust_GetIndexedTrustedPlayers(2, pIndex);
	};
end

function GroupCalendar_TrustedPlayerSelected(pIndex)
	if pIndex == 0 then
		return;
	end
	
	CalendarPlayerList_SelectIndexedPlayer(CalendarExcludedPlayersList, 0);
	
	local	vName = CalendarTrust_GetIndexedTrustedPlayers(1, pIndex);
	
	if vName then
		CalendarTrustedPlayerName:SetText(vName);
		CalendarTrustedPlayerName:HighlightText();
		CalendarTrustedPlayerName:SetFocus();
	end
end

function GroupCalendar_ExcludedPlayerSelected(pIndex)
	if pIndex == 0 then
		return;
	end
	
	CalendarPlayerList_SelectIndexedPlayer(CalendarTrustedPlayersList, 0);
	
	local	vName = CalendarTrust_GetIndexedTrustedPlayers(2, pIndex);
	
	if vName then
		CalendarTrustedPlayerName:SetText(vName);
		CalendarTrustedPlayerName:HighlightText();
		CalendarTrustedPlayerName:SetFocus();
	end
end

function GroupCalendar_SelectDateWithToggle(pDate)
	if CalendarEditor_IsOpen()
	and gCalendarEditor_SelectedDate == pDate then
		CalendarEditor_Close();
	else
		GroupCalendar_SelectDate(pDate);
	end
end

function GroupCalendar_SelectDate(pDate)
	Calendar_SetSelectedDate(pDate);
	
	local	vCompiledSchedule = EventDatabase_GetCompiledSchedule(pDate);
	
	CalendarEditor_ShowCompiledSchedule(pDate, vCompiledSchedule);
end

function GroupCalendar_EditorClosed()
	Calendar_ClearSelectedDate();
end

function GroupCalendar_EventChanged(pDatabase, pEvent, pChangedFields)
	GroupCalendar_ScheduleChanged(pDatabase, pEvent.mDate);
	CalendarEventEditor_EventChanged(pEvent);
end

function GroupCalendar_ScheduleChanged(pDatabase, pDate)
	GroupCalendar_ScheduleChanged2(pDatabase, pDate);
	
	if gGroupCalendar_Settings.ShowEventsInLocalTime then
		if gGroupCalendar_ServerTimeZoneOffset < 0 then
			GroupCalendar_ScheduleChanged2(pDatabase, pDate - 1);
		elseif gGroupCalendar_ServerTimeZoneOffset > 0 then
			GroupCalendar_ScheduleChanged2(pDatabase, pDate + 1);
		end
	end
end

function GroupCalendar_ScheduleChanged2(pDatabase, pDate)
	local	vSchedule = pDatabase.Events[pDate];
	
	CalendarEditor_ScheduleChanged(pDate, pSchedule);
	Calendar_ScheduleChanged(pDate, pSchedule);
	CalendarEventViewer_ScheduleChanged(pDate);
end

function GroupCalendar_MajorDatabaseChange(pDatabase)
	CalendarEditor_MajorDatabaseChange();
	CalendarEventViewer_MajorDatabaseChange();
	CalendarEventEditor_MajorDatabaseChange();
	Calendar_MajorDatabaseChange();
end

gGroupCalendar_QueueElapsedTime = 0;

function GroupCalendar_Update(pElapsed)
	local	vLatencyStartTime;
	
	-- Process invites
	
	if gGroupCalendar_Settings.DebugLatency then
		vLatencyStartTime = GetTime();
	end
	
	CalendarGroupInvites_Update(pElapsed);
	
	if gGroupCalendar_Settings.DebugLatency then
		local	vElapsed = GetTime() - vLatencyStartTime;
		
		if vElapsed > 0.1 then
			Calendar_DebugMessage("CalendarGroupInvites_Update took "..vElapsed.."s to execute");
		end
		
		vLatencyStartTime = GetTime();
	end

	-- Process the event queues if it's time
	
	gGroupCalendar_QueueElapsedTime = gGroupCalendar_QueueElapsedTime + pElapsed;
	
	if gGroupCalendar_QueueElapsedTime > 0.1 then
		CalendarNetwork_ProcessQueues(gGroupCalendar_QueueElapsedTime);
		
		gGroupCalendar_QueueElapsedTime = 0;
	end
	
	if gGroupCalendar_Settings.DebugLatency then
		local	vElapsed = GetTime() - vLatencyStartTime;
		
		if vElapsed > 0.1 then
			Calendar_DebugMessage("CalendarNetwork_ProcessQueues took "..vElapsed.."s to execute");
		end
		
		vLatencyStartTime = GetTime();
	end

	-- Stop the timer if it isn't needed
	
	if not CalendarNetwork_NeedsUpdateTimer()
	and not CalendarGroupInvites_NeedsUpdateTimer() then
		if gGroupCalendar_Settings.DebugTimer then
			Calendar_DebugMessage("GroupCalendar_Update: Stopping timer");
		end
		
		GroupCalendarUpdateFrame:Hide();
	end

	if gGroupCalendar_Settings.DebugLatency then
		local	vElapsed = GetTime() - vLatencyStartTime;
		
		if vElapsed > 0.1 then
			Calendar_DebugMessage("NeedsUpdateTimer took "..vElapsed.."s to execute");
		end
	end
end

function GroupCalendar_StartUpdateTimer()
	if GroupCalendarUpdateFrame:IsVisible() then
		return;
	end
	
	if gGroupCalendar_Settings.DebugTimer then
		Calendar_DebugMessage("GroupCalendar_StartUpdateTimer()");
	end
	
	GroupCalendarUpdateFrame:Show();
end

function GroupCalendar_StartMoving()
	if not gGroupCalendar_PlayerSettings.UI.LockWindow then
		GroupCalendarFrame:StartMoving();
	end
end

function GroupCalendar_GetPlayerSettings(pPlayerName, pRealmName)
	-- Wipe the settings if they're the alpha version
	
	if not gGroupCalendar_Settings.Format then
		gGroupCalendar_Settings =
		{
			Debug = false,
			Format = 1,
		};
	end
	
	local	vSettings = gGroupCalendar_Settings[pRealmName.."_"..pPlayerName];
	
	if vSettings == nil then
		vSettings =
		{
			Security =
			{
				TrustAnyone = false,
				TrustGuildies = IsInGuild(),
				MinTrustedRank = 1,
				Player = {},
			},
			
			Channel =
			{
				AutoConfig = IsInGuild(),
				AutoConfigPlayer = nil,
				Name = nil,
				Password = nil,
			},
			
			UI =
			{
				LockWindow = false,
			},
		};
		
		gGroupCalendar_Settings[pRealmName.."_"..pPlayerName] = vSettings;
	end
	
	return vSettings;
end

function GroupCalendar_GetRealmSettings(pRealmName)
	local	vSettings = gGroupCalendar_Settings[pRealmName];
	
	if vSettings == nil then
		vSettings = {};
		gGroupCalendar_Settings[pRealmName] = vSettings;
	end
	
	return vSettings;
end

function GroupCalendar_RoundTimeOffsetToNearest30(pOffset)
	local	vNegativeOffset;
	local	vOffset;
	
	if pOffset < 0 then
		vNegativeOffset = true;
		vOffset = -pOffset;
	else
		vNegativeOffset = false;
		vOffset = pOffset;
	end
	
	vOffset = vOffset - (math.mod(vOffset + 15, 30) - 15);
	
	if vNegativeOffset then
		return -vOffset;
	else
		return vOffset;
	end
end

function GroupCalendar_CalculateTimeZoneOffset()
	local	vServerTime = Calendar_ConvertHMToTime(GetGameTime());
	local	vLocalDate, vLocalTime = Calendar_GetCurrentLocalDateTime();
	local	vUTCDate, vUTCTime = Calendar_GetCurrentUTCDateTime();
	
	local	vLocalDateTime = vLocalDate * 1440 + vLocalTime;
	local	vUTCDateTime = vUTCDate * 1440 + vUTCTime;
	
	local	vLocalUTCDelta = GroupCalendar_RoundTimeOffsetToNearest30(vLocalDateTime - vUTCDateTime);
	local	vLocalServerDelta = GroupCalendar_RoundTimeOffsetToNearest30(vLocalTime - vServerTime);
	local	vServerUTCDelta = vLocalUTCDelta - vLocalServerDelta;
	
	if vServerUTCDelta < (-12 * 60) then
		vServerUTCDelta = vServerUTCDelta + (24 * 60);
	elseif vServerUTCDelta > (12 * 60) then
		vServerUTCDelta = vServerUTCDelta - (24 * 60);
	end
	
	vLocalServerDelta = vLocalUTCDelta - vServerUTCDelta;
	
	if vLocalServerDelta ~= gGroupCalendar_ServerTimeZoneOffset then
		gGroupCalendar_ServerTimeZoneOffset = vLocalServerDelta;
		
		-- Time zone changed
		
		if gGroupCalendar_ServerTimeZoneOffset == 0 then
			GroupCalendarUseServerTime:Hide();
		else
			GroupCalendarUseServerTime:Show();
		end
	end
end

function GroupCalendar_UpdateTimeTooltip()
	local	vServerTime = Calendar_ConvertHMToTime(GetGameTime());
	local	vLocalDate = Calendar_GetCurrentLocalDate();
	
	local	vServerTimeString = Calendar_GetShortTimeString(vServerTime);
	local	vLocalDateString = Calendar_GetLongDateString(vLocalDate, true);

	GameTooltip:AddLine(vLocalDateString);
	GameTooltip:AddLine(vServerTimeString);
	
	if gGroupCalendar_ServerTimeZoneOffset ~= 0 then
		local	vLocalTime = Calendar_GetLocalTimeFromServerTime(vServerTime);
		local	vLocalTimeString = Calendar_GetShortTimeString(vLocalTime);
		
		GameTooltip:AddLine(string.format(GroupCalendar_cLocalTimeNote, vLocalTimeString));
	end
	
	GameTooltip:Show();
end

function GroupCalendar_ChannelChanged()
	if CalendarNetwork_GetChannelStatus() == "Connected" then
		GroupCalendar_RegisterEvent(GroupCalendarFrame, "CHAT_MSG_CHANNEL", GroupCalendar_ChatMsgChannel);
	else
		GroupCalendar_UnregisterEvent(GroupCalendarFrame, "CHAT_MSG_CHANNEL");
	end

	if GroupCalendarFrame:IsVisible()
	and (gGroupCalendar_CurrentPanel == 2
	or gGroupCalendar_CurrentPanel == 3) then
		if GroupCalendarAutoChannelConfig:GetChecked() then
			GroupCalendar_ShowPanel(gGroupCalendar_CurrentPanel); -- Refresh the channel and auto-player names
		end
		
		if gGroupCalendar_CurrentPanel == 2 then
			GroupCalendar_UpdateChannelStatus();
		end
	end
end

function GroupCalendar_GetLocalizedStrings(pLocale)
	local	vStrings = {};
	
	-- Initialize the strings with copies form the enUS set
	
	for vIndex, vString in gCalendarLocalizedStrings.enUS do
		vStrings[vIndex] = vString;
	end
	
	-- Select a set to use for overwriting
	
	local	vLocalizedStrings = gCalendarLocalizedStrings[pLocale];
	
	if not vLocalizedStrings then
		-- There's not a fit for the exact language/country specified, so just match the language
		
		local	vLanguageCode = string.sub(pLocale, 1, 2);
		
		vLocalizedStrings = GroupCalendar_SelectLanguage(vLanguageCode);
		
		if not vLocalizedStrings then
			return vStrings;
		end
	end
	
	-- Overwrise the english strings with translated strings
	
	for vIndex, vString in vLocalizedStrings do
		vStrings[vIndex] = vString;
	end
	
	return vStrings;
end

function GroupCalendar_SelectLanguage(pLanguageCode)
	-- There's not a fit for the exact language/country specified, so just match the language

	local	vLanguageCode = string.sub(pLocale, 1, 2);

	for vLocale, vLocalizedStrings in gCalendarLocalizedStrings do
		if pLanguageCode == string.sub(vLocale, 1, 2) then
			return vLocalizedStrings;
		end
	end
	
	-- No luck, hope they know english!
	
	return nil;
end

function GroupCalendar_ToggleChannelConnection()
	local	vChannelStatus = CalendarNetwork_GetChannelStatus();
	
	if vChannelStatus == "Initializing" then
		return;
	end
	
	if vChannelStatus == "Connected" then
		gGroupCalendar_Channel.Disconnected = true;
		
		CalendarNetwork_LeaveChannel();
	else
		gGroupCalendar_Channel.Disconnected = false;
		
		CalendarNetwork_SetChannelStatus("Initializing");
		
		if gGroupCalendar_PlayerSettings.Channel.AutoConfig then
			CalendarNetwork_ScheduleAutoConfig(0.5);
		elseif gGroupCalendar_PlayerSettings.Channel.Name then
			CalendarNetwork_SetChannel(
					gGroupCalendar_PlayerSettings.Channel.Name,
					gGroupCalendar_PlayerSettings.Channel.Password);
		else
			CalendarNetwork_SetChannelStatus("Disconnected");
		end
	end
end

function GroupCalendar_ToggleCalendarDisplay()
	if GroupCalendarFrame:IsVisible() then
		HideUIPanel(GroupCalendarFrame);
	else
		ShowUIPanel(GroupCalendarFrame);
	end
end

function GroupCalendar_SetUseServerDateTime(pUseServerDateTime)
	gGroupCalendar_Settings.ShowEventsInLocalTime = not pUseServerDateTime;
	
	GroupCalendarUseServerTime:SetChecked(pUseServerDateTime);
	
	GroupCalendar_MajorDatabaseChange(nil); -- Force the display to update
end

function GroupCalendar_BeginModalDialog(pDialogFrame)
	if gGroupCalendar_ActiveDialog then
		GroupCalendar_EndModalDialog(gGroupCalendar_ActiveDialog);
	end
	
	gGroupCalendar_ActiveDialog = pDialogFrame;
end

function GroupCalendar_EndModalDialog(pDialogFrame)
	if pDialogFrame ~= gGroupCalendar_ActiveDialog then
		return;
	end
	
	gGroupCalendar_ActiveDialog = nil;
	
	pDialogFrame:Hide();
end

function GroupCalendar_ExecuteCommand(pCommandString)
	local	vStartIndex, vEndIndex, vCommand, vParameter = string.find(pCommandString, "(%w+) ?(.*)");
	
	if not vCommand then
		ShowUIPanel(GroupCalendarFrame);
		return;
	end
	
	local	vCommandTable =
	{
		["help"] = {func = GroupCalendar_ShowCommandHelp},
		["versions"] = {func = GroupCalendar_DumpUserVersions},
	};
	
	local	vCommandInfo = vCommandTable[strlower(vCommand)];
	
	if not vCommandInfo then
		GroupCalendar_ShowCommandHelp();
		return;
	end
	
	vCommandInfo.func(vParameter);
end

function GroupCalendar_ShowCommandHelp()
	Calendar_NoteMessage("GroupCalendar commands:");
	Calendar_NoteMessage(HIGHLIGHT_FONT_COLOR_CODE.."/calendar help"..NORMAL_FONT_COLOR_CODE..": Shows this list of commands");
	Calendar_NoteMessage(HIGHLIGHT_FONT_COLOR_CODE.."/calendar versions"..NORMAL_FONT_COLOR_CODE..": Displays the last known versions of GroupCalendar each user was running");
end

function GroupCalendar_DumpUserVersions()
	for vRealmUser, vDatabase in gGroupCalendar_Database.Databases do
		if EventDatabase_DatabaseIsVisible(vDatabase) then
			if vDatabase.IsPlayerOwned then
				Calendar_NoteMessage(HIGHLIGHT_FONT_COLOR_CODE..vDatabase.UserName..NORMAL_FONT_COLOR_CODE..": "..gGroupCalendar_VersionString);
			elseif vDatabase.AddonVersion then
				Calendar_NoteMessage(HIGHLIGHT_FONT_COLOR_CODE..vDatabase.UserName..NORMAL_FONT_COLOR_CODE..": "..vDatabase.AddonVersion);
			else
				Calendar_NoteMessage(HIGHLIGHT_FONT_COLOR_CODE..vDatabase.UserName..NORMAL_FONT_COLOR_CODE..": Unknown version");
			end
		end
	end
end
