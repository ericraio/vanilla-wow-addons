UnitPopupButtons["ADD_FRIEND"] = { text = TEXT(ADD_FRIEND), dist = 0 };
UnitPopupButtons["ADD_IGNORE"] = { text = TEXT(IGNORE), dist = 0 };
UnitPopupButtons["WHO"] = { text = TEXT(WHO), dist = 0 };
UnitPopupButtons["ADD_GUILD"] = { text = "Guild Invite", dist = 0 };
UnitPopupButtons["GET_NAME"] = { text = "Get Name", dist = 0 };

UnitPopupMenus["FRIEND"] = { "WHISPER", "INVITE", "TARGET", "GET_NAME", "ADD_FRIEND", "ADD_IGNORE", "WHO", "ADD_GUILD", "GUILD_PROMOTE", "GUILD_LEAVE", "CANCEL" };
UnitPopupMenus["PARTY"] = { "WHISPER", "PROMOTE", "LOOT_PROMOTE", "UNINVITE", "INSPECT", "TRADE", "FOLLOW", "DUEL", "ADD_FRIEND", "WHO", "ADD_GUILD", "GET_NAME", "RAID_TARGET_ICON", "CANCEL" };
UnitPopupMenus["PLAYER"] = { "WHISPER", "INSPECT", "INVITE", "TRADE", "FOLLOW", "DUEL", "ADD_FRIEND", "ADD_IGNORE", "WHO", "ADD_GUILD", "GET_NAME", "RAID_TARGET_ICON", "CANCEL" };

function SuperPlayerLink_OnLoad()
	--hook UnitPopup_OnClick funciton
	ori_unitpopup = UnitPopup_OnClick;
	UnitPopup_OnClick = spl_unitpopup;

	--hook SetItemRef funciton
	ori_SetItemRef = SetItemRef;
	SetItemRef = spl_SetItemRef;
end

function spl_unitpopup() 
	local dropdownFrame = getglobal(UIDROPDOWNMENU_INIT_MENU);
	local button = this.value;
	local unit = dropdownFrame.unit;
	local name = dropdownFrame.name;
	local server = dropdownFrame.server;

	if ( button == "ADD_FRIEND" ) then 
		AddFriend(name);
	elseif ( button == "ADD_IGNORE" ) then 
		AddIgnore(name);
	elseif ( button == "WHO" ) then
		SendWho("n-"..name);
	elseif (button == "ADD_GUILD") then
		GuildInviteByName(name);
	elseif (button == "GET_NAME") then
		spl_GetName(name);
	else
		return ori_unitpopup();
	end
	PlaySound("UChatScrollButton");
end 

function spl_SetItemRef(link, text, button)
	if (not link) then
			link = arg1;
	end
	if (not text) then
			text = arg2;
	end
	if (not button) then
			button = arg3;
	end
	if ( strsub(link, 1, 6) == "player" ) then
		local name = strsub(link, 8);
		if ( name and (strlen(name) > 0) ) then
			name = gsub(name, "([^%s]*)%s+([^%s]*)%s+([^%s]*)", "%3");
			name = gsub(name, "([^%s]*)%s+([^%s]*)", "%2");
			if ( IsShiftKeyDown() ) then
				local staticPopup;
				staticPopup = StaticPopup_Visible("ADD_IGNORE");
				if ( staticPopup ) then
					-- If add ignore dialog is up then enter the name into the editbox
					getglobal(staticPopup.."EditBox"):SetText(name);
					return;
				end
				staticPopup = StaticPopup_Visible("ADD_FRIEND");
				if ( staticPopup ) then
					-- If add ignore dialog is up then enter the name into the editbox
					getglobal(staticPopup.."EditBox"):SetText(name);
					return;
				end
				staticPopup = StaticPopup_Visible("ADD_GUILDMEMBER");
				if ( staticPopup ) then
					-- If add ignore dialog is up then enter the name into the editbox
					getglobal(staticPopup.."EditBox"):SetText(name);
					return;
				end
				staticPopup = StaticPopup_Visible("ADD_RAIDMEMBER");
				if ( staticPopup ) then
					-- If add ignore dialog is up then enter the name into the editbox
					getglobal(staticPopup.."EditBox"):SetText(name);
					return;
				end
				if ( ChatFrameEditBox:IsVisible() ) then
					ChatFrameEditBox:Insert(name);
				else
					SendWho("n-"..name);					
				end
			elseif ( IsControlKeyDown() ) then
				TargetByName(name);
			elseif ( IsAltKeyDown() ) then
				spl_GetName(name);				
			elseif ( button == "RightButton" ) then
				FriendsFrame_ShowDropdown(name, 1);
			else
				ChatFrame_SendTell(name);
			end
		end
		return;
	end
	return ori_SetItemRef(link, text, button);
end

function spl_GetName(name)
	if ( ChatFrameEditBox:IsVisible() ) then
		ChatFrameEditBox:Insert(name);
	else
		DEFAULT_CHAT_FRAME.editBox:Hide();
		DEFAULT_CHAT_FRAME.editBox.chatType = "SAY";
		ChatEdit_UpdateHeader(DEFAULT_CHAT_FRAME.editBox);
		if (not DEFAULT_CHAT_FRAME.editBox:IsVisible()) then
			ChatFrame_OpenChat(name, DEFAULT_CHAT_FRAME);
		end
	end
end