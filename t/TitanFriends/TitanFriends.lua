GRAY_FONT_COLOR_CODE = "|cff808080";
TITANFRIENDS_ARTWORK_PATH = "Interface\\AddOns\\TitanFriends\\"

function TitanPanelFriendsButton_OnLoad()
	this.registry = { 
		id = "Friends",
		menuText = TITAN_FRIENDS_MENU_TEXT, 
		buttonTextFunction = "TitanPanelFriendsButton_GetButtonText", 
		tooltipTitle = TITAN_FRIENDS_TOOLTIP,
		tooltipTextFunction = "TitanPanelFriendsButton_GetTooltipText",

		icon = TITANFRIENDS_ARTWORK_PATH.."TitanFriends",
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
		}

	};

	this:RegisterEvent("FRIENDLIST_SHOW");
	this:RegisterEvent("FRIENDLIST_UPDATE");
end

function TitanPanelFriendsButton_OnEvent()
	TitanPanelButton_UpdateButton("Friends");	
	TitanPanelButton_UpdateTooltip();
end

function TitanPanelFriendsButton_OnEnter()
	-- refresh the friends list
	ShowFriends();
end



function TitanPanelRightClickMenu_PrepareFriendsMenu()
	local info = {};
	local id = "Friends";


	-- create the Whisper submenu items

	if ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then

		if ( UIDROPDOWNMENU_MENU_VALUE == TITAN_FRIENDS_MENU_WHISPER ) then

			-- generate a list of online friends and set up whisper
			local NumFriends = GetNumFriends();

			local friend_name, friend_level, friend_class, friend_area, friend_connected
			local friendIndex

			-- get a count of the number of online friends
			for friendIndex=1, NumFriends do
				friend_name, friend_level, friend_class, friend_area, friend_connected = GetFriendInfo(friendIndex);
				if ( friend_connected ) then
					info = {};
					info.text = friend_name;
					info.func = friendWhisper;
					info.value = friend_name;
					UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
				end
			end
		end


		if ( UIDROPDOWNMENU_MENU_VALUE == TITAN_FRIENDS_MENU_INVITE ) then

			-- generate a list of online friends and set up whisper
			local NumFriends = GetNumFriends();

			local friend_name, friend_level, friend_class, friend_area, friend_connected
			local friendIndex

			-- get a count of the number of online friends
			for friendIndex=1, NumFriends do
				friend_name, friend_level, friend_class, friend_area, friend_connected = GetFriendInfo(friendIndex);
				if ( friend_connected ) then
					info = {};
					info.text = friend_name;
					info.func = friendInvite;
					info.value = friend_name;
					UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
				end
			end
		end
		return;
	end

	TitanPanelRightClickMenu_AddTitle(TitanPlugins[id].menuText);

	-- create the title for the Whisper submenu
	info = {};
	info.text = TITAN_FRIENDS_MENU_WHISPER;
	info.value = TITAN_FRIENDS_MENU_WHISPER;
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);

	-- create the title for the Invite submenu
	info = {};
	info.text = TITAN_FRIENDS_MENU_INVITE;
	info.value = TITAN_FRIENDS_MENU_INVITE;
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();

	TitanPanelRightClickMenu_AddToggleIcon("Friends");
	TitanPanelRightClickMenu_AddToggleLabelText("Friends");

	-- default Titan Panel right-click menu options
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_CUSTOMIZE..TITAN_PANEL_MENU_POPUP_IND, id, TITAN_PANEL_MENU_FUNC_CUSTOMIZE);
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, id, TITAN_PANEL_MENU_FUNC_HIDE);

end

function friendInvite()
	InviteByName( this.value );
end

function friendWhisper()
	if ( not ChatFrameEditBox:IsVisible() ) then
		ChatFrame_OpenChat("/w "..this.value.." ");
	else
		ChatFrameEditBox:SetText("/w "..this.value.." ");
	end
end


function TitanPanelFriendsButton_GetButtonText(id)
	local id = TitanUtils_GetButton(id, true);
	local NumFriends = GetNumFriends();
	local NumFriendsOnline = 0;

	local friend_name, friend_level, friend_class, friend_area, friend_connected
	local friendIndex

	-- get a count of the number of online friends
	for friendIndex=1, NumFriends do
		friend_name, friend_level, friend_class, friend_area, friend_connected = GetFriendInfo(friendIndex);
		if ( friend_connected ) then
			NumFriendsOnline = NumFriendsOnline + 1;
		end
	end

	-- create string for Titan bar display
	local buttonRichText = format(TITAN_FRIENDS_BUTTON_TEXT, TitanUtils_GetGreenText(NumFriendsOnline), TitanUtils_GetHighlightText(NumFriends));
	return TITAN_FRIENDS_BUTTON_LABEL, buttonRichText;
end

function TitanPanelFriendsButton_GetTooltipText()
	local NumFriends = GetNumFriends();
	local tooltipRichText = "";

	local friend_name, friend_level, friend_class, friend_area, friend_connected
	local friendIndex

	-- create tooltip
	for friendIndex=1, NumFriends do
		friend_name, friend_level, friend_class, friend_area, friend_connected = GetFriendInfo(friendIndex);
		if ( friend_connected ) then
			tooltipRichText = tooltipRichText..TitanUtils_GetNormalText(friend_name)..TitanUtils_GetHighlightText(" - "..friend_area.." ["..friend_level.." "..friend_class.."]").."\n";
		end
	end

	-- remove the last \n
	tooltipRichText = string.sub(tooltipRichText, 1, string.len(tooltipRichText)-1);

	return tooltipRichText;
end
