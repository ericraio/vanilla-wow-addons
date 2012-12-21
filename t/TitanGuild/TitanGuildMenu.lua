----------------------------------------------------------------------
-- TitanGuildMenu.lua
-- code for generating the cascading right-click menus
----------------------------------------------------------------------

----------------------------------------------------------------------
-- TitanPanelRightClickMenu_PrepareGuildMenu()
----------------------------------------------------------------------
function TitanPanelRightClickMenu_PrepareGuildMenu()
	local id = TITAN_GUILD_ID;
	local NumGuild = 0;
	local guild_name = "";
	local guild_rank = "";
	local guild_rankIndex = "";
	local guild_level = "";
	local guild_class = "";
	local guild_zone = "";
	local guild_note = "";
	local guild_officernote = "";
	local guild_online = "";
	local guild_status = "";
	local guildIndex;
	
	if (IsInGuild()) then
		-- get guild members
		NumGuild = GetNumGuildMembers();
		-- Level 2 -----------------------------------------
		if ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then
			if (UIDROPDOWNMENU_MENU_VALUE) then
				-- chat
				if (UIDROPDOWNMENU_MENU_VALUE == TITAN_GUILD_MENU_CHAT_TEXT) then
					TitanPanelRightClickMenu_AddTitle(UIDROPDOWNMENU_MENU_VALUE, UIDROPDOWNMENU_MENU_LEVEL);						
					-- open guild chat
					info = {};
					info.text = TITAN_GUILD_GUILD_CHAT;
					info.func = TitanPanelGuildButton_OpenGuildChat;
					UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
					-- open officer chat only for officers
					local guildName, guildRankName, guildRankIndex = GetGuildInfo("player");
					-- assuming if the player can view the officer note, then they can do /o chat
					if (CanViewOfficerNote()) then
						info = {};
						info.text = TITAN_GUILD_GUILD_OFFICER_CHAT;
						info.func = TitanPanelGuildButton_OpenGuildOfficerChat;
						UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
					end
				-- sort
				elseif (UIDROPDOWNMENU_MENU_VALUE == TITAN_GUILD_MENU_SORT_TEXT) then
					-- sort options
					TitanPanelRightClickMenu_AddTitle(UIDROPDOWNMENU_MENU_VALUE, UIDROPDOWNMENU_MENU_LEVEL);					
					local choiceIndex;
					for choiceIndex = 1, table.getn(sortChoicesValues) do
						info = {};
						info.text = sortChoicesLabels[choiceIndex];
						info.value = string.lower(sortChoicesValues[choiceIndex]);
						info.func = TitanPanelGuildButton_SetSortByValue;
						--info.checked = TitanGetVar(TITAN_GUILD_ID, "SortByValue");
						UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);					
					end
					TitanPanelRightClickMenu_AddCommand(TITAN_GUILD_MENU_HIDE, TITAN_GUILD_ID, TITAN_GUILD_BUTTON_CLOSEMENU, UIDROPDOWNMENU_MENU_LEVEL);					
				elseif (UIDROPDOWNMENU_MENU_VALUE == TITAN_GUILD_MENU_TOOLTIP_TEXT) then
					-- tooltip options
					TitanPanelRightClickMenu_AddTitle(UIDROPDOWNMENU_MENU_VALUE, UIDROPDOWNMENU_MENU_LEVEL);					
					local choiceIndex;
					for choiceIndex = 1, table.getn(sortChoicesValues) do
						info = {};
						info.text = sortChoicesLabels[choiceIndex];
						info.value = sortChoicesValues[choiceIndex];
						info.func = TitanPanelGuildButton_SetTooltipChoice;
						info.checked = TitanGetVar(TITAN_GUILD_ID, "ShowTooltip"..sortChoicesValues[choiceIndex]);
						info.keepShownOnClick = 1;
						UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);					
					end
					TitanPanelRightClickMenu_AddCommand(TITAN_GUILD_MENU_HIDE, TITAN_GUILD_ID, TITAN_GUILD_BUTTON_CLOSEMENU, UIDROPDOWNMENU_MENU_LEVEL);
				elseif (UIDROPDOWNMENU_MENU_VALUE == TITAN_GUILD_MENU_FILTER_TEXT) then
					-- filter options
					TitanPanelRightClickMenu_AddTitle(UIDROPDOWNMENU_MENU_VALUE, UIDROPDOWNMENU_MENU_LEVEL);
					-- lvl
					info = {};
					info.text = TITAN_GUILD_MENU_FILTER_MYLEVEL;
					info.func = TitanPanelGuildButton_ToggleFilterMyLevel;
					info.checked = TitanGetVar(TITAN_GUILD_ID, "FilterMyLevel");
					UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
					-- zone
					info = {};
					info.text = TITAN_GUILD_MENU_FILTER_MYZONE;
					info.func = TitanPanelGuildButton_ToggleFilterMyZone;
					info.checked = TitanGetVar(TITAN_GUILD_ID, "FilterMyZone");
					UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
					-- class
					info = {};
					info.text = TITAN_GUILD_MENU_FILTER_CLASS;
					info.hasArrow = 1;
					UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);												
					TitanPanelRightClickMenu_AddCommand(TITAN_GUILD_MENU_HIDE, TITAN_GUILD_ID, TITAN_GUILD_BUTTON_CLOSEMENU, UIDROPDOWNMENU_MENU_LEVEL);					
				elseif (UIDROPDOWNMENU_MENU_VALUE == TITAN_GUILD_MENU_CONFIGURE_UPDATE_TIME) then
					-- update options
					TitanPanelRightClickMenu_AddTitle(UIDROPDOWNMENU_MENU_VALUE, UIDROPDOWNMENU_MENU_LEVEL);
					local choiceIndex;
					for choiceIndex = 1, table.getn(updateTimeOptions) do
						info = {};
						info.text = updateTimeLabels[choiceIndex];
						info.value = updateTimeOptions[choiceIndex];
						info.func = TitanPanelGuildButton_SetRosterUpdateTime;
						if (updateTimeOptions[choiceIndex] == TitanGetVar(TITAN_GUILD_ID, "RosterUpdateTime")) then
							info.checked = 1;
						end
						UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);					
					end
					-- toggle roster updates
					info = {};
					info.text = TITAN_GUILD_MENU_DISABLE_UPDATE_TEXT;
					info.func = TitanPanelGuildButton_ToggleRosterUpdates
					info.checked = TitanGetVar(TITAN_GUILD_ID, "DisableRosterUpdates");
					UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
					-- toggle mouse-over updates
					info = {};
					info.text = TITAN_GUILD_MENU_DISABLE_MOUSEOVER_UPDATE;
					info.func = TitanPanelGuildButton_ToggleMouseOverUpdates
					info.checked = TitanGetVar(TITAN_GUILD_ID, "DisableMouseOverUpdates");
					UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);					
					-- hide							
					TitanPanelRightClickMenu_AddCommand(TITAN_GUILD_MENU_HIDE, TITAN_GUILD_ID, TITAN_GUILD_BUTTON_CLOSEMENU, UIDROPDOWNMENU_MENU_LEVEL);
				-- player submenus
				else
					if (TitanGetVar(TITAN_GUILD_ID, "ShowAdvancedMenus")) then
						-- if hovering over a different rank, then refresh paging
						if (priorAdvMenuValue ~= UIDROPDOWNMENU_MENU_VALUE) then
							TitanPanelGuildButton_InitPaging();
							priorAdvMenuValue = UIDROPDOWNMENU_MENU_VALUE;
						end
						-- generate lvl 2 player lists based on rank
						TitanPanelRightClickMenu_AddTitle(GuildControlGetRankName(UIDROPDOWNMENU_MENU_VALUE), UIDROPDOWNMENU_MENU_LEVEL);
						TitanPanelGuildButton_ComputeAdvancedPages(table.getn(masterTable[UIDROPDOWNMENU_MENU_VALUE].members));
						TitanPanelGuildButton_BuildBackwardPageControl();
						for numMember = currIndex, maxIndex do
							if (masterTable[UIDROPDOWNMENU_MENU_VALUE].members[numMember]) then
								info = {};
								info.text = masterTable[UIDROPDOWNMENU_MENU_VALUE].members[numMember];
								info.hasArrow = 1;
								UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
							end				
						end
						TitanPanelGuildButton_BuildForwardPageControl();
					else
						-- build interaction menus for simple player list
						TitanPanelGuildButton_BuildInteractionMenu();
					end
				end
			end
		-- End Level 2 -------------------------------------
		elseif (UIDROPDOWNMENU_MENU_LEVEL == 1) then
		-- Level 1 -----------------------------------------
			TitanPanelRightClickMenu_AddTitle(TitanPlugins[id].menuText);
			-- build the lvl 1 menus based on rank
			-- ADVANCED ---------------------------------------------			
			if (TitanGetVar(TITAN_GUILD_ID, "ShowAdvancedMenus")) then
				if (table.getn(masterTable) <= 0) then
					TitanPanelRightClickMenu_AddSpacer();
					TitanPanelRightClickMenu_AddTitle(TITAN_GUILD_MENU_PLEASE_WAIT_TEXT);
				else
					for rankMenuIndex = 1, table.getn(masterTable) do
						if (table.getn(masterTable[rankMenuIndex].members) > 0) then
							info = {};
							info.text = TitanPanelGuildButton_ColorRankNameText(rankMenuIndex-1, masterTable[rankMenuIndex].rank);
							info.hasArrow = 1;
							info.value = rankMenuIndex;
							UIDropDownMenu_AddButton(info);
						end						
					end
				end
			else			
				-- build the lvl 1 simple menus
				-- SIMPLE ---------------------------------------------
				TitanPanelGuildButton_BuildBackwardPageControl();
				for guildIndex = currIndex, maxIndex do
					if (masterTableSimple[guildIndex]) then
						info = {};
						info.text = TitanPanelGuildButton_ColorRankNameText(masterTableSimple[guildIndex].rankIndex, masterTableSimple[guildIndex].name);
						info.hasArrow = 1;
						info.value = masterTableSimple[guildIndex].name;
						info.func = TitanPanelGuildButton_GuildWhisper;							
						UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
					end				
				end
				TitanPanelGuildButton_BuildForwardPageControl();
			end
	
			if (TitanGetVar(TITAN_GUILD_ID, "ShowMenuOptions")) then
				TitanPanelRightClickMenu_AddSpacer();

				-- toggle the menu options for more room
				TitanPanelRightClickMenu_AddCommand(TITAN_GUILD_MENU_HIDE_OPTIONS_TEXT, TITAN_GUILD_ID, TITAN_GUILD_BUTTON_SHOWOPTIONS);				
	
				-- toggle the advanced menus
				info = {};
				info.text = TITAN_GUILD_MENU_SHOWADVANCED_TEXT;
				info.func = TitanPanelGuildButton_ToggleAdvancedMenus
				info.checked = TitanGetVar(TITAN_GUILD_ID, "ShowAdvancedMenus");
				UIDropDownMenu_AddButton(info);		
	
				-- open guild chat
				info = {};
				info.text = TITAN_GUILD_MENU_CHAT_TEXT;
				info.hasArrow = 1;
				UIDropDownMenu_AddButton(info);
				
				-- open sort submenu
				info = {};
				info.text = TITAN_GUILD_MENU_SORT_TEXT;
				info.hasArrow = 1;
				UIDropDownMenu_AddButton(info);
				
				-- open tooltip submenu
				info = {};
				info.text = TITAN_GUILD_MENU_TOOLTIP_TEXT;
				info.hasArrow = 1;
				UIDropDownMenu_AddButton(info);
				
				-- open filter submenu
				info = {};
				info.text = TITAN_GUILD_MENU_FILTER_TEXT;
				info.hasArrow = 1;
				UIDropDownMenu_AddButton(info);
			
				-- configure roster updates
				info = {};
				info.text = TITAN_GUILD_MENU_CONFIGURE_UPDATE_TIME;
				info.hasArrow = 1;
				UIDropDownMenu_AddButton(info);					
				
				-- add default menu options
				TitanPanelRightClickMenu_AddSpacer();
				TitanPanelRightClickMenu_AddToggleIcon(TITAN_GUILD_ID);	
				TitanPanelRightClickMenu_AddToggleLabelText(TITAN_GUILD_ID);
				TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_GUILD_ID, TITAN_PANEL_MENU_FUNC_HIDE);					
			else
				-- toggle the menu options for more room
				TitanPanelRightClickMenu_AddCommand(TITAN_GUILD_MENU_SHOW_OPTIONS_TEXT, TITAN_GUILD_ID, TITAN_GUILD_BUTTON_SHOWOPTIONS);
			end					
		-- End Level 1 --------------------------------------
		elseif (UIDROPDOWNMENU_MENU_LEVEL == 3) then
		-- Level 3 ------------------------------------------
			if (UIDROPDOWNMENU_MENU_VALUE == TITAN_GUILD_MENU_FILTER_CLASS) then
				TitanPanelGuildButton_BuildClassFilterMenu();
			else
				TitanPanelGuildButton_BuildInteractionMenu();
			end
													
		-- End Level 3 --------------------------------------
		end
	else
		-- add a nice title for those that are not in a guild
		TitanPanelRightClickMenu_AddTitle(TitanPlugins[id].menuText);	
		-- add default menu options
		TitanPanelRightClickMenu_AddSpacer();
		TitanPanelRightClickMenu_AddToggleIcon(TITAN_GUILD_ID);	
		TitanPanelRightClickMenu_AddToggleLabelText(TITAN_GUILD_ID);
		TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_GUILD_ID, TITAN_PANEL_MENU_FUNC_HIDE);	
	end
end

----------------------------------------------------------------------
--  TitanPanelGuildButton_BuildInteractionMenu()
----------------------------------------------------------------------
function TitanPanelGuildButton_BuildInteractionMenu()
	TitanPanelRightClickMenu_AddTitle(UIDROPDOWNMENU_MENU_VALUE, UIDROPDOWNMENU_MENU_LEVEL);
	-- whisper
	info = {};
	info.text = TITAN_GUILD_MENU_ADVANCED_WHISPER_TEXT;
	info.value = UIDROPDOWNMENU_MENU_VALUE;
	info.func = TitanPanelGuildButton_GuildWhisper;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);			
	-- invite
	info = {};
	info.text = TITAN_GUILD_MENU_ADVANCED_INVITE_TEXT;
	info.value = UIDROPDOWNMENU_MENU_VALUE;
	info.func = TitanPanelGuildButton_InviteToGroup;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	-- who
	info = {};
	info.text = TITAN_GUILD_MENU_ADVANCED_WHO_TEXT;
	info.value = UIDROPDOWNMENU_MENU_VALUE;
	info.func = TitanPanelGuildButton_SendWhoRequest;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	-- friend
	info = {};
	info.text = TITAN_GUILD_MENU_ADVANCED_FRIEND_TEXT;
	info.value = UIDROPDOWNMENU_MENU_VALUE;
	info.func = TitanPanelGuildButton_AddFriend;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);	
end



