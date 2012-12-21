-- ## Loading function for the main frames.
function TitanBG_Menu_LoadMenuFrames()

	-- GENERAL
		TitanBG_Menu_Header_General:SetText(TITANBG_COLOR_BLUE .. TITANBG_MENU_GENERAL_OPTIONS);

		UIDropDownMenu_SetText(TITANBG_MENU_GENERAL_OPTIONS, TitanBG_Menu_DD_General);
		TitanBG_Menu_DD_GeneralText:SetFontObject("GameFontNormalSmall");
		TitanBG_Menu_DD_GeneralMiddle:SetWidth(540);

		-- BATTLEGROUND
			TitanBG_Menu_Header_General_Battleground:SetText(TITANBG_COLOR_GREEN .. CHAT_MSG_BATTLEGROUND);

			UIDropDownMenu_SetText(CHAT_MSG_BATTLEGROUND, TitanBG_Menu_DD_General_Battleground);
			TitanBG_Menu_DD_General_BattlegroundText:SetFontObject("GameFontNormalSmall");
			TitanBG_Menu_DD_General_BattlegroundMiddle:SetWidth(520);

		-- INTERFACE
			TitanBG_Menu_Header_General_Interface:SetText(TITANBG_COLOR_GREEN .. TITANBG_MENU_HEADER_INTERFACE);

			UIDropDownMenu_SetText(TITANBG_MENU_HEADER_INTERFACE, TitanBG_Menu_DD_General_Interface);
			TitanBG_Menu_DD_General_InterfaceText:SetFontObject("GameFontNormalSmall");
			TitanBG_Menu_DD_General_InterfaceMiddle:SetWidth(520);

			UIDropDownMenu_SetText(TITANBG_MENU_PLAYWHICHSOUND, TitanBG_Menu_DD_General_Interface_WhichSound);
			TitanBG_Menu_DD_General_Interface_WhichSoundMiddle:SetWidth(520);

	-- DISPLAY
		TitanBG_Menu_Header_Display:SetText(TITANBG_COLOR_BLUE .. TITANBG_MENU_DISP_OPTIONS);

		UIDropDownMenu_SetText(TITANBG_MENU_DISP_OPTIONS, TitanBG_Menu_DD_Display);
		TitanBG_Menu_DD_DisplayText:SetFontObject("GameFontNormalSmall");
		TitanBG_Menu_DD_DisplayMiddle:SetWidth(540);

		-- WORLD
			TitanBG_Menu_Header_Display_World:SetText(TITANBG_COLOR_GREEN .. TITANBG_MENU_HEADER_WORLD);

			UIDropDownMenu_SetText(TITANBG_MENU_BUTTON_OPTIONS, TitanBG_Menu_DD_Display_World_Button);
			TitanBG_Menu_DD_Display_World_ButtonText:SetFontObject("GameFontNormalSmall");
			TitanBG_Menu_DD_Display_World_ButtonMiddle:SetWidth(158);

			UIDropDownMenu_SetText(TITANBG_MENU_TT_OPTIONS, TitanBG_Menu_DD_Display_World_Tooltip);
			TitanBG_Menu_DD_Display_World_TooltipText:SetFontObject("GameFontNormalSmall");
			TitanBG_Menu_DD_Display_World_TooltipMiddle:SetWidth(158);

			UIDropDownMenu_SetText(TITANBG_MENU_POPUP_OPTIONS, TitanBG_Menu_DD_Display_World_Popup);
			TitanBG_Menu_DD_Display_World_PopupText:SetFontObject("GameFontNormalSmall");
			TitanBG_Menu_DD_Display_World_PopupMiddle:SetWidth(158);

		-- BATTLEGROUND
			TitanBG_Menu_Header_Display_Battleground:SetText(TITANBG_COLOR_GREEN .. CHAT_MSG_BATTLEGROUND);

			UIDropDownMenu_SetText(TITANBG_MENU_BUTTON_OPTIONS, TitanBG_Menu_DD_Display_Battleground_Button);
			TitanBG_Menu_DD_Display_Battleground_ButtonText:SetFontObject("GameFontNormalSmall");
			TitanBG_Menu_DD_Display_Battleground_ButtonMiddle:SetWidth(158);

			UIDropDownMenu_SetText(TITANBG_MENU_TT_OPTIONS, TitanBG_Menu_DD_Display_Battleground_Tooltip);
			TitanBG_Menu_DD_Display_Battleground_TooltipText:SetFontObject("GameFontNormalSmall");
			TitanBG_Menu_DD_Display_Battleground_TooltipMiddle:SetWidth(158);

			UIDropDownMenu_SetText(TITANBG_MENU_PANEL_OPTIONS, TitanBG_Menu_DD_Display_Battleground_Panel);
			TitanBG_Menu_DD_Display_Battleground_PanelText:SetFontObject("GameFontNormalSmall");
			TitanBG_Menu_DD_Display_Battleground_PanelMiddle:SetWidth(158);

end

-- ## Hides and shows the options menu.
function TitanBG_Menu_Toggle()
	if (TitanBG_Menu:IsVisible()) then
		TitanBG_Menu:Hide();
	else
		TitanBG_Menu:Show();
	end

	CloseDropDownMenus();
end

-- ## GENERAL

	function TitanBG_Menu_DropDownInit_General()
		info                  = {};
		info.keepShownOnClick = 1;

		info.text  = TITANBG_MENU_OVERWRITESIMILAR;
		info.value = "I_OverwriteOtherSettings";
		info.func  = TitanPanelTitanBG_MenuToggleOverwriteSettings;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);
	end

	function TitanBG_Menu_DropDownInit_General_Battleground()
		info                  = {};
		info.keepShownOnClick = 1;

		info.text  = TITANBG_MENU_AUTOJOIN;
		info.value = "B_AutoJoinBG";
		info.func  = TitanPanelTitanBG_MenuToggleAutoJoin;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		info.text  = TITANBG_MENU_AUTOLEAVE;
		info.value = "B_AutoLeaveBG";
		info.func  = TitanPanelTitanBG_MenuToggleAutoLeave;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		TitanBG_Menu_AddDropDownSpacer();

		info.text  = TITANBG_MENU_AUTORELEASE;
		info.value = "B_AutoRelease";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		info.text  = TITANBG_MENU_RELEASECHECK;
		info.value = "B_ReleaseCheck";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);
	end

	function TitanBG_Menu_DropDownInit_General_Interface()
		info                  = {};
		info.keepShownOnClick = 1;

		info.text  = TITANBG_MENU_HIDEMINIMAPBUTTON;
		info.value = "B_HideMinimapButton";
		info.func  = TitanPanelTitanBG_MenuToggleMinimapIcon;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		info.text  = TITANBG_MENU_AUTOSHOWBATTLEMAP;
		info.value = "B_AutoShowBGMinimap";
		info.func  = TitanPanelTitanBG_MenuToggleBattlegroundMinimap;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		TitanBG_Menu_AddDropDownSpacer();

		info.text  = TITANBG_MENU_HIDEJOINPOPUP;
		info.value = "B_HideJoinPopup";
		info.func  = TitanPanelTitanBG_MenuHideBattlegroundReadyPopup;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		info.text  = TITANBG_MENU_REPEATSOUND;
		info.value = "D_S_RepeatSound";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);
	end

	function TitanBG_Menu_DropDownInit_General_Interface_WhichSound()
		info = {};

		info.text  = NONE;
		info.value = "D_S_Sound";
		info.arg1  = "D_S_PlayWhatSound";
		info.arg2  = 0;
		info.func  = TitanPanelTitanBG_MenuChangeSoundOnReady;
		if (sv_menu[info.arg1] == info.arg2) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		info.text  = TITANBG_SOUNDS_BGWARNING[1].name;
		info.value = "D_S_Sound";
		info.arg1  = "D_S_PlayWhatSound";
		info.arg2  = 1;
		info.func  = TitanPanelTitanBG_MenuChangeSoundOnReady;
		if (sv_menu[info.arg1] == info.arg2) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		TitanBG_Menu_AddDropDownSpacer();

		for i = 2, table.getn(TITANBG_SOUNDS_BGWARNING) do
			info.text  = TITANBG_SOUNDS_BGWARNING[i].name;
			info.value = "D_S_Sound";
			info.arg1  = "D_S_PlayWhatSound";
			info.arg2  = i;
			info.func  = TitanPanelTitanBG_MenuChangeSoundOnReady;
			if (sv_menu[info.arg1] == info.arg2) then info.checked = 1; else info.checked = nil; end

			UIDropDownMenu_AddButton(info);
		end
	end

-- ## DISPLAY

	function TitanBG_Menu_DropDownInit_Display()
		info                  = {};
		info.keepShownOnClick = 1;

		info.text  = TITANBG_MENU_B_SPACERS;
		info.value = "D_B_Spacers";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);
	end

	function TitanBG_Menu_DropDownInit_Display_World_Button()
		info                  = {};
		info.keepShownOnClick = 1;

		info.text  = TITANBG_MENU_B_TIME;
		info.value = "D_B_Time";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		info.text  = TITANBG_MENU_B_TIMELEFT;
		info.value = "D_B_QueueExpire";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);
	end

	function TitanBG_Menu_DropDownInit_Display_World_Tooltip()
		info                  = {};
		info.keepShownOnClick = 1;

		info.text  = TITANBG_MENU_TT_QUEUETIMERS;
		info.value = "D_TT_QueueTimers";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		info.text  = TITANBG_MENU_TT_REMBGSOPEN;
		info.value = "D_TT_RememberOpenBgs";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);
	end

	function TitanBG_Menu_DropDownInit_Display_World_Popup()
		info                  = {};
		info.keepShownOnClick = 1;

		info.text  = TITANBG_MENU_POPUP_EXPIRE;
		info.value = "D_POP_QueueExpire";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);
	end

	function TitanBG_Menu_DropDownInit_Display_Battleground_Button()
		info                  = {};
		info.keepShownOnClick = 1;

		info.text  = TITANBG_PANEL_HIDEACTIVE;
		info.value = "B_ReplaceActive";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		TitanBG_Menu_AddDropDownSpacer();

		info.text  = TITANBG_PANEL_P;
		info.value = "D_B_Players";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		info.text  = TITANBG_PANEL_S;
		info.value = "D_B_Standing";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		info.text  = TITANBG_PANEL_K;
		info.value = "D_B_Kills";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		info.text  = TITANBG_PANEL_KB;
		info.value = "D_B_KillingBlows";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		info.text  = TITANBG_PANEL_D;
		info.value = "D_B_Deaths";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		info.text  = TITANBG_PANEL_H;
		info.value = "D_B_Honor";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);
	end

	function TitanBG_Menu_DropDownInit_Display_Battleground_Tooltip()
		info                  = {};
		info.keepShownOnClick = 1;

		info.text  = TITANBG_MENU_TT_TWOTOOLTIPS;
		info.value = "D_BG_SeperateActiveQueue";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		TitanBG_Menu_AddDropDownSpacer();

		info.text  = TITANBG_MENU_SHOWCAPTURE;
		info.value = "D_TT_Capture";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		info.text  = TITANBG_MENU_TT_AB_WINESTIMATE;
		info.value = "D_TT_ABWinEstimates";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		info.text  = TITANBG_MENU_TT_WSG_FLAG;
		info.value = "D_TT_FlagTracker";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		TitanBG_Menu_AddDropDownSpacer();

		info.text  = TITANBG_MENU_SHOWSTATS;
		info.value = "D_TT_PlayerStats";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		info.text  = TITANBG_MENU_SHOWLOCATIONSTATS;
		info.value = "D_TT_LocationStats";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		info.text  = TITANBG_MENU_SHOWFRIENDS;
		info.value = "D_TT_Friends";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);
	end

	function TitanBG_Menu_DropDownInit_Display_Battleground_Panel()
		info                  = {};
		info.keepShownOnClick = 1;

		info.text  = TITANBG_MENU_PANEL_LOCK;
		info.value = "D_OS_PanelLock";
		info.func  = TitanPanelTitanBG_MenuToggleLockCaptures;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		TitanBG_Menu_AddDropDownSpacer();

		info.text  = TITANBG_MENU_PANEL_CAP_SHOW;
		info.value = "D_OS_CaptureShow";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		info.text  = TITANBG_MENU_PANEL_CAP_INVERT;
		info.value = "D_NT_TimersInvert";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		TitanBG_Menu_AddDropDownSpacer();

		info.text  = TITANBG_MENU_PANEL_WSG_SHOW;
		info.value = "D_OS_WSG_Show";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		info.text  = TITANBG_MENU_PANEL_WSG_TEXTCLASS;
		info.value = "D_OS_WSG_TextClass";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		info.text  = TITANBG_MENU_PANEL_WSG_COLORCLASS;
		info.value = "D_OS_WSG_ColorClass";
		info.func  = TitanPanelTitanBG_MenuClicked;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		info.text  = TITANBG_MENU_PANEL_WSG_CLICK;
		info.value = "D_OS_WSG_Click";
		info.func  = TitanPanelTitanBG_MenuToggleClickFlagRunner;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		info.text  = TITANBG_MENU_PANEL_WSG_ATTACH;
		info.value = "D_OS_WSG_AttachScore";
		info.func  = TitanPanelTitanBG_MenuChangeAttachFlagTracker;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);

		info.text  = TITANBG_MENU_PANEL_WSG_INVERT;
		info.value = "D_OS_WSG_Invert";
		info.func  = TitanPanelTitanBG_MenuInvertFlagTracker;
		if (sv_menu[info.value]) then info.checked = 1; else info.checked = nil; end
		UIDropDownMenu_AddButton(info);
	end


-- ## TITAN MENU

	-- ## Creates the titan drop down menu for the addon.
	function TitanPanelRightClickMenu_PrepareTitanBGMenu()
		local info = {};

		-- First Level Menu
		if ( UIDROPDOWNMENU_MENU_LEVEL == 1 or UIDROPDOWNMENU_MENU_LEVEL == nil ) then
			TitanPanelTitanBG_MenuAddHeader(TITANBG_MENU_HEADER);
			TitanPanelRightClickMenu_AddSpacer();

			-- Show Icon
			TitanPanelRightClickMenu_AddToggleIcon(TITAN_TITANBG_ID);

			info            = {};
			info.text       = TITAN_PANEL_MENU_SHOW_LABEL_TEXT;
			info.value      = "ShowLabelText";
			info.func       = TitanPanelTitanBG_MenuClicked;
			TitanPanelTitanBG_MenuAddOption(info, nil);

			if (_bgs and _bgs.queue and _bgs.queue > 0) then
				TitanPanelRightClickMenu_AddSpacer();
				info            = {};
				info.text       = TITANBG_COLOR_GREEN .. TITANBG_MENU_QUEUE_OPTIONS;
				info.value      = "QueueOptions";
				TitanPanelTitanBG_MenuAddMenu(info);
			end

			TitanPanelRightClickMenu_AddSpacer();

			info            = {};
			info.text       = TITANBG_COLOR_BLUE .. TITANBG_MENU_SHOW_OPTIONS;
			info.value      = "ShowMainMenu";
			info.func       = TitanBG_Menu_Toggle;
			TitanPanelTitanBG_MenuAddOption(info, nil, false);

			-- Hide
			TitanPanelRightClickMenu_AddSpacer();
			TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_TITANBG_ID, TITAN_PANEL_MENU_FUNC_HIDE);

		-- Second Level Menu
		elseif ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then
			if ( UIDROPDOWNMENU_MENU_VALUE == "QueueOptions" ) then
				local active_bgs = 0;

				-- Loop through and check on the status of the battlegrounds.
				for i = 1, MAX_BATTLEFIELD_QUEUES do
					local status, name, id = GetBattlefieldStatus(i);

					if (status == TITANBG_BG_STATUS_CONFIRM or status == TITANBG_BG_STATUS_QUEUED) then
						active_bgs = active_bgs + 1;

						-- If battlegrounds were listed before this one, insert a spacer.
						if (active_bgs > 1) then
							TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL);
						end

						TitanPanelTitanBG_MenuAddHeader(name, UIDROPDOWNMENU_MENU_LEVEL);
					end

					if (status == TITANBG_BG_STATUS_CONFIRM) then
						info = {};
						info.text = ENTER_BATTLE;
						info.func = AcceptBattlefieldPort;
						info.arg1 = i;
						info.arg2 = 1;
						UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
						info = {};
						info.text = LEAVE_QUEUE;
						info.func = AcceptBattlefieldPort;
						info.arg1 = i;
						info.arg2 = nil;
						UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

					elseif (status == TITANBG_BG_STATUS_QUEUED) then
						info = {};
						info.text = CHANGE_INSTANCE;
						info.func = ShowBattlefieldList;
						info.arg1 = i;
						UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
						info = {};
						info.text = LEAVE_QUEUE;
						info.func = AcceptBattlefieldPort;
						info.arg1 = i;
						info.arg2 = nil;
						UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
					end
				end
			end
		end

		return;
	end

-- ## Adds a new drop down menu to the menu.
function TitanPanelTitanBG_MenuAddMenu(info, level)
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info, level);
end


-- ## Adds a new header to the menu.
function TitanPanelTitanBG_MenuAddHeader(title, level)
	info              = {};
	info.text         = title;
	info.notClickable = 1;
	info.isTitle      = 1;
	UIDropDownMenu_AddButton(info, level);
end


-- ## Adds a new option to the menu.
function TitanPanelTitanBG_MenuAddOption(info, level, show)
	if (show == nil) then
		info.keepShownOnClick = 1;
	else
		info.keepShownOnClick = show;
	end

	if (sv_menu[info.value]) then info.checked = 1; end
	UIDropDownMenu_AddButton(info, level);
end

-- ## Adds a spacer to the drop down menu.
function TitanBG_Menu_AddDropDownSpacer()
	local info    = {};
	info.disabled = 1;
	UIDropDownMenu_AddButton(info);
end


-- ## Called when a menu item is clicked and requires action.
function TitanPanelTitanBG_MenuClicked()
	TitanPanelTitanBG_MenuToggleVar(this.value);
end


-- ## Toggles a specified variable in the menu, changing it from true to false and vice versa.
-- ##
-- ## Variables
-- ##     value: The value that UIDROPDOWNMENU_MENU_VALUE is set to when the button is clicked.
function TitanPanelTitanBG_MenuToggleVar(value)
	if (sv_menu[value]) then
		sv_menu[value] = false;
	else
		sv_menu[value] = true;
	end
end


-- ## Locks and unlocks the on screen capture timers.
function TitanPanelTitanBG_MenuToggleLockCaptures()
	TitanPanelTitanBG_MenuToggleVar(this.value);
	TitanPanelTitanBG_ToggleLockCaptures();
end


-- ## Toggles showing of the mimimap bg icon.
function TitanPanelTitanBG_MenuToggleMinimapIcon()
	TitanPanelTitanBG_MenuToggleVar(this.value);
	TitanPanelTitanBG_ToggleMiniMapIcon();
end


-- ## Toggles showing of the battleground minimap.
function TitanPanelTitanBG_MenuToggleBattlegroundMinimap()
	TitanPanelTitanBG_MenuToggleVar(this.value);
	TitanPanelTitanBG_ToggleBattlefieldMinimap();
end


-- ## Toggles hiding of the battelground ready popup.
function TitanPanelTitanBG_MenuHideBattlegroundReadyPopup()
	TitanPanelTitanBG_MenuToggleVar(this.value);
	TitanPanelTitanBG_HideBattlegroundReadyPopup();
end


-- ## Toggles the auto joining of the battleground.
function TitanPanelTitanBG_MenuToggleAutoJoin()
	TitanPanelTitanBG_MenuToggleVar(this.value);

	_autojoin_bg     = "";
	_autojoin_time   = 0;
	_autojoin_paused = 0;
end


-- ## Toggles the auto leaving of the battleground.
function TitanPanelTitanBG_MenuToggleAutoLeave()
	TitanPanelTitanBG_MenuToggleVar(this.value);

	_autoleave_time   = 0;
	_autoleave_paused = 0;
end


-- ## Toggles overwriting similar settings from other addons.
function TitanPanelTitanBG_MenuToggleOverwriteSettings()
	TitanPanelTitanBG_MenuToggleVar(this.value);
	TitanPanelTitanBG_ToggleOverwriteOtherSettings();
end


-- ## Changes what sound will be played when the battleground is ready.
function TitanPanelTitanBG_MenuChangeSoundOnReady()
	sv_menu[this.arg1] = this.arg2;

	if (this.arg2 > 0) then
		if (sv_menu[this.arg1] == 1) then
			PlaySound("PVPTHROUGHQUEUE", true);
		else
			PlaySoundFile(TITANBG_SOUNDS_BGWARNING[this.arg2].file);
		end
	end
end


-- ## Enables and disables click targetting of the flag runners.
function TitanPanelTitanBG_MenuToggleClickFlagRunner()
	TitanPanelTitanBG_MenuToggleVar(this.value);
	TitanPanelTitanBG_ToggleClickFlagRunner();
end


-- ## Changes attach position of the flag tracker frames.
function TitanPanelTitanBG_MenuInvertFlagTracker()
	TitanPanelTitanBG_MenuToggleVar(this.value);
	TitanPanelTitanBG_InvertFlagTracker();
end


-- ## Changes attach position of the flag tracker frames.
function TitanPanelTitanBG_MenuChangeAttachFlagTracker()
	TitanPanelTitanBG_MenuToggleVar(this.value);
	TitanPanelTitanBG_ChangeAttachFlagTracker();
end