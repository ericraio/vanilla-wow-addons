AcePlayerMenu = AceAddon:new({
        name          = AcePlayerMenuLocals.NAME,
        description   = AcePlayerMenuLocals.DESCRIPTION,
        version       = "0.3",
        releaseDate   = "06-27-2006",
        aceCompatible = "103",
        author        = "hshh",
        email         = "hunreal@gmail.com",
        website       = "http://www.hshh.org",
        category      = "interface",
        cmd           = AceChatCmd:new(AcePlayerMenuLocals.COMMANDS, AcePlayerMenuLocals.CMD_OPTIONS),
		db            = AceDatabase:new("apm"),
})


function AcePlayerMenu:Initialize()
	self.UnitPopupButtons={};
	self.UnitPopupMenus={};
	for k,v in UnitPopupButtons do
		self.UnitPopupButtons[k]=v;
	end
	for k,v in UnitPopupMenus do
		self.UnitPopupMenus[k]=v;
	end

	if (not self.db:get("toggle")) then
		self.db:set("toggle", "on");
	end
	if (not self.db:get("left")) then
		self.db:set("left", "off");
	end
end

function AcePlayerMenu:Enable()
	if (self.db:get("toggle")~="on") then
		return
	end

	self:Hook("UnitPopup_OnClick");
	self:Hook("UnitPopup_HideButtons");
	if (self.db:get("left")=="on") then
		self:Hook("SetItemRef");
	end

	UnitPopupButtons["ADD_FRIEND"] = { text = TEXT(ADD_FRIEND), dist = 0 };
	UnitPopupButtons["GUILD_INVITE"] = { text = TEXT(AcePlayerMenuLocals.TEXT.GUILD_INVITE), dist = 0 };
	UnitPopupButtons["IGNORE"] = { text = TEXT(IGNORE), dist = 0 };
	UnitPopupButtons["GET_NAME"] = { text = TEXT(AcePlayerMenuLocals.TEXT.GET_NAME), dist = 0 };
	UnitPopupButtons["WHO"] = { text = TEXT(WHO), dist = 0 };

	UnitPopupMenus["FRIEND"] = { "WHISPER", "INVITE", "TARGET", "GUILD_PROMOTE", "GUILD_LEAVE", "ADD_FRIEND", "GUILD_INVITE", "IGNORE", "GET_NAME", "WHO", "CANCEL" };
end

function AcePlayerMenu:Disable()
	for k,v in self.UnitPopupButtons do
		UnitPopupButtons[k]=v;
	end
	for k,v in self.UnitPopupMenus do
		UnitPopupMenus[k]=v;
	end

	self:Unhook("UnitPopup_OnClick");
	self:Unhook("UnitPopup_HideButtons");
	self:Unhook("SetItemRef");
end

function AcePlayerMenu:UnitPopup_HideButtons()
	self:CallHook("UnitPopup_HideButtons");
	local dropdownMenu = getglobal(UIDROPDOWNMENU_INIT_MENU);
	for index, value in UnitPopupMenus[dropdownMenu.which] do
		if ( value == "GUILD_INVITE" ) then
			if ( not CanGuildInvite() or dropdownMenu.name == UnitName("player") ) then
				UnitPopupShown[index] = 0;
			else
				UnitPopupShown[index] = 1;
			end
		elseif ( value == "ADD_FRIEND" or value == "IGNORE" or value == "WHO" or value == "GET_NAME") then
			if (dropdownMenu.name == UnitName("player")) then
				UnitPopupShown[index] = 0;
			else
				UnitPopupShown[index] = 1;
			end
		end
	end
end

function AcePlayerMenu:UnitPopup_OnClick()
	local dropdownFrame = getglobal(UIDROPDOWNMENU_INIT_MENU);
	local button = this.value;
	local unit = dropdownFrame.unit;
	local name = dropdownFrame.name;

	if (button == "ADD_FRIEND") then
		AddFriend(name);
	elseif (button == "GUILD_INVITE") then
		GuildInviteByName(name);
	elseif (button == "IGNORE") then
		AddIgnore(name);
	elseif (button == "GET_NAME") then
		ChatFrameEditBox:Show();
		ChatFrameEditBox:Insert(name);
	elseif (button == "WHO") then
		SendWho(name);
	else
		return self:CallHook("UnitPopup_OnClick");
	end
	PlaySound("UChatScrollButton");
end

function AcePlayerMenu:SetItemRef(link, text, button)
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
				
			else
				FriendsFrame_ShowDropdown(name, 1);
			end 
		end
		return;
	end

	return self:CallHook("SetItemRef", link, text, button);
end

function AcePlayerMenu:Toggle()
	local toggle = self.db:get("toggle");
	if ( not toggle or toggle ~= "on" ) then
		self.db:set("toggle", "on");
		self.cmd:msg(AcePlayerMenuLocals.MSG.APM_ON)
		self:Reload();
	else
		self.db:set("toggle", "off");
		self.cmd:msg(AcePlayerMenuLocals.MSG.APM_OFF)
		self:Reload();
	end
end

function AcePlayerMenu:Left()
	local toggle = self.db:get("left");
	if ( not toggle or toggle ~= "off" ) then
		self.db:set("left", "off");
		self.cmd:msg(AcePlayerMenuLocals.MSG.LEFT_OFF)
		self:Reload();
	else
		self.db:set("left", "on");
		self.cmd:msg(AcePlayerMenuLocals.MSG.LEFT_ON)
		self:Reload();
	end
end

function AcePlayerMenu:Reload()
	self:Disable();
	self:Enable();
end
AcePlayerMenu:RegisterForLoad()
