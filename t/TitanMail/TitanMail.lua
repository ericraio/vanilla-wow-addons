--  Titan Panel [Mail]
--  tekkub is the original creator of this mod
--  Bugfixes and updates by Larholm

-- Version information
local TITAN_MAIL_VERSION = 1.15;
-- Constants
TITAN_MAIL_ID = "Mail";
TITAN_MAIL_ID_RIGHT = "MailRight";
TITAN_MAIL_ICON_NOMAIL = "Interface\\Cursor\\UnableMail";
TITAN_MAIL_ICON_NEW = "Interface\\Cursor\\Mail";
TITAN_MAIL_ICON_AH = "Interface\\Cursor\\LootAll";
TITAN_MAIL_ICON_AH_ALT = "Interface\\Icons\\Spell_Holy_RighteousFury";
TITAN_MAIL_SOUND = "Interface\\AddOns\\TitanMail\\mail.wav";

--/script TitanMail_TestIcon("Interface\\Icons\\Spell_Nature_ThunderClap");
--/script TitanMail_TestIcon("Interface\\Icons\\Spell_Holy_RighteousFury");
--/script TitanMail_TestIcon("Interface\\HelpFrame\\OpenTicketIcon");
--/script TitanMail_TestIcon("Interface\\Icons\\INV_Letter_16");
--/script TitanMail_TestIcon("Interface\\Cursor\\Inspect");

TITAN_FORMAT_COUNT_MAIL = "%u/%u";
TITAN_FORMAT_COUNT_NOMAIL = "0";
TITAN_FORMAT_TEXTCOUNT_MAIL = "%s (%u/%u)";

-- Local variables
local TPM_numNew = 0;
local TPM_numTotal = 0;
local TPM_ignorenext = false;
local TPM_lastclose = 0;
local TPM_closedelay = 5;
local TPM_checkedmail = false;
local TPM_player = GetCVar("RealmName").. UnitName("player");
local TPM_debug = false;

-- Events that don't fire UPDATE_PENDING_MAIL like they should
local TPM_brokenEvents = {
		[ERR_AUCTION_WON_S] = false,
		[ERR_AUCTION_SOLD_S] = false,
		[ERR_AUCTION_OUTBID_S] = true,
		[ERR_AUCTION_EXPIRED_S] = false,
		[ERR_AUCTION_REMOVED_S] = false,
};

----------------------------------------------------------------------------------

function TPM_Debug(str)
	if (TPM_debug) then
		DEFAULT_CHAT_FRAME:AddMessage("|cffff00ff<Mail> ".. str);
	end
end

function TitanPanelMailButton_OnLoad()
	this.registry = { 
		id = TITAN_MAIL_ID,
		menuText = TITAN_MAIL_MENU_TEXT, 
		buttonTextFunction = "TitanPanelMailButton_GetButtonText", 
		tooltipTitle = TITAN_MAIL_TOOLTIP,
		tooltipTextFunction = "TitanPanelMailButton_GetTooltipText", 
		icon = TITAN_MAIL_ICON_NEW,	
		category = "Information",
		version = TITAN_MAIL_VERSION,
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowIconAlt = 0,
			ShowCount = 1,
			NoIconNoMail = 0,
			ShowText = 1,
			compact = 1,
			hidemm = 1,
			new = 0,
			total = 0,
			sound = 1,
			chat = 1,
		}
	};
	
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("CHAT_MSG_SYSTEM");
	this:RegisterEvent("MAIL_SHOW");
	this:RegisterEvent("MAIL_CLOSED");
	this:RegisterEvent("MAIL_INBOX_UPDATE");
	this:RegisterEvent("UPDATE_PENDING_MAIL");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage("Titan Panel [Mail] v"..TITAN_MAIL_VERSION.." loaded");
	end
end

function TitanPanelMailRightButton_OnLoad()
	this.registry = { 
		id = TITAN_MAIL_ID_RIGHT,
		menuText = TITAN_MAILRIGHT_MENU_TEXT, 
		buttonTextFunction = "TitanPanelMailButton_GetButtonText", 
		tooltipTitle = TITAN_MAIL_TOOLTIP,
		tooltipTextFunction = "TitanPanelMailButton_GetTooltipText", 
		icon = TITAN_MAIL_ICON_NEW,	
		version = TITAN_MAIL_VERSION,
		iconWidth = 16,
		category = "Information",
	};
end

function TitanPanelMailButton_UpdateIcon(forceAH)
	local hidemm = TitanGetVar(TITAN_MAIL_ID, "hidemm");
	local total = TitanGetVar(TITAN_MAIL_ID, "total");
	local iconshown = TitanGetVar(TITAN_MAIL_ID, "ShowIcon");
	local alticon = TitanGetVar(TITAN_MAIL_ID, "ShowIconAlt");
	local noiconnomail = TitanGetVar(TITAN_MAIL_ID, "NoIconNoMail");

	MiniMapMailFrame:Show();
	
	if (hidemm and MiniMapMailFrame:IsVisible()) then 
		MiniMapMailFrame:Hide(); 
	end

	local button = TitanUtils_GetButton(TITAN_MAIL_ID, true);
	local buttonR = TitanUtils_GetButton(TITAN_MAIL_ID_RIGHT, true);

	if (iconshown) then
--		TPM_Debug("Icon is shown");
	else
--		TPM_Debug("Icon is hidden");
	end

	
	if TITAN_MAIL_SETTINGS[TPM_player].ahalerts then
		if (alticon) then
			button.registry.icon = TITAN_MAIL_ICON_AH_ALT;
			buttonR.registry.icon = TITAN_MAIL_ICON_AH_ALT;
		else
			button.registry.icon = TITAN_MAIL_ICON_AH;
			buttonR.registry.icon = TITAN_MAIL_ICON_AH;
		end
	elseif ((total and (total > 0)) or (HasNewMail() and (not TPM_checkedmail))) then
		button.registry.icon = TITAN_MAIL_ICON_NEW;
		buttonR.registry.icon = TITAN_MAIL_ICON_NEW;
	elseif (noiconnomail) then
		button.registry.icon = "";
		buttonR.registry.icon = "";
	else
		button.registry.icon = TITAN_MAIL_ICON_NOMAIL;
		buttonR.registry.icon = TITAN_MAIL_ICON_NOMAIL;
	end
	if (forceAH) then
		if (alticon) then
			button.registry.icon = TITAN_MAIL_ICON_AH_ALT;
			buttonR.registry.icon = TITAN_MAIL_ICON_AH_ALT;
		else
			button.registry.icon = TITAN_MAIL_ICON_AH;
			buttonR.registry.icon = TITAN_MAIL_ICON_AH;
		end
	end
	TitanPanelButton_UpdateButton(TITAN_MAIL_ID);
	TitanPanelButton_UpdateButton(TITAN_MAIL_ID_RIGHT);
end

function TitanPanelMailButton_GetButtonText(id)
	local showt = TitanGetVar(TITAN_MAIL_ID, "ShowText");
	local showc = TitanGetVar(TITAN_MAIL_ID, "ShowCount");
	local new = TitanGetVar(TITAN_MAIL_ID, "new");
	local total = TitanGetVar(TITAN_MAIL_ID, "total");

	if (not total) then return; end

	local buttonRichText = "";
	
	if (showt and (not showc)) then
		if TITAN_MAIL_SETTINGS[TPM_player].ahalerts then
			buttonRichText = TitanUtils_GetRedText(TITAN_MAIL_BUTTON_TEXT_ALERT);
		elseif ((total > 0) or (HasNewMail() and (not TPM_checkedmail))) then
			buttonRichText = TitanUtils_GetGreenText(TITAN_MAIL_BUTTON_TEXT_MAIL);	
		else
			buttonRichText = TitanUtils_GetNormalText(TITAN_MAIL_BUTTON_TEXT_NOMAIL);
		end
	elseif (showc and showt) then
		if TITAN_MAIL_SETTINGS[TPM_player].ahalerts then
			buttonRichText = TitanUtils_GetRedText(string.format(TITAN_FORMAT_TEXTCOUNT_MAIL, TITAN_MAIL_BUTTON_TEXT_ALERT, new, total));
		elseif ((total > 0) or (HasNewMail() and (not TPM_checkedmail))) then
			buttonRichText = TitanUtils_GetGreenText(string.format(TITAN_FORMAT_TEXTCOUNT_MAIL, TITAN_MAIL_BUTTON_TEXT_MAIL, new, total));	
		else
			buttonRichText = TitanUtils_GetNormalText(TITAN_MAIL_BUTTON_TEXT_NOMAIL);
		end
	else
		if TITAN_MAIL_SETTINGS[TPM_player].ahalerts then
			buttonRichText = TitanUtils_GetRedText(string.format(TITAN_FORMAT_COUNT_MAIL, new, total));
		elseif ((total > 0) or (HasNewMail() and (not TPM_checkedmail))) then
			buttonRichText = TitanUtils_GetGreenText(string.format(TITAN_FORMAT_COUNT_MAIL, new, total));	
		else
			buttonRichText = TitanUtils_GetNormalText(TITAN_FORMAT_COUNT_NOMAIL);
		end
	end
	return buttonRichText;
end

function TitanPanelMailButton_GetTooltipText()
	local retstr = "";
	local new = TitanGetVar(TITAN_MAIL_ID, "new");
	local total = TitanGetVar(TITAN_MAIL_ID, "total");
	
	if (total > 0) or (HasNewMail()) then
		retstr = retstr.. TITAN_MAIL_BUTTON_TEXT_MAIL.. "\n\n";	
		retstr = retstr.. TitanUtils_GetGreenText(new.. TITAN_MAIL_TOOLTIP_NEW);
		retstr = retstr.. TitanUtils_GetNormalText(total.. TITAN_MAIL_TOOLTIP_TOTAL)
		
	else
		retstr = TITAN_MAIL_BUTTON_TEXT_NOMAIL;	
	end

	if TITAN_MAIL_SETTINGS[TPM_player].ahalerts then
		retstr = retstr.. "\n";
		for i=1,table.getn(TITAN_MAIL_SETTINGS[TPM_player].ahalerts) do
			retstr = retstr.. "\n".. TITAN_MAIL_SETTINGS[TPM_player].ahalerts[i];
		end
	end
	
	return retstr;	
end

function TitanPanelMailButton_OnEvent()
	TPM_Debug(time().. " ".. event);
	if (event == "VARIABLES_LOADED") then
		if (not TITAN_MAIL_SETTINGS) then TITAN_MAIL_SETTINGS = {}; end
		if (not TITAN_MAIL_SETTINGS[TPM_player]) then TITAN_MAIL_SETTINGS[TPM_player] = {}; end
		TitanPanelMailButton_UpdateIcon(false);
	end
	if (event == "PLAYER_ENTERING_WORLD") then
		TPM_Debug("Ignoring next pending");
		TPM_ignorenext = true;
	end
	if (event == "CHAT_MSG_SYSTEM") then
		TitanMail_ReadAHMsg(arg1);
		TitanPanelMailButton_UpdateIcon(false);
	end
	if (event == "MAIL_SHOW") then
		TPM_checkedmail = true;
		TITAN_MAIL_SETTINGS[TPM_player].ahalerts = nil;
		TitanPanelMailButton_UpdateIcon(false);
	end
	if (event == "MAIL_CLOSED") then
		TPM_lastclose = time()
	end
	if ( event == "MAIL_INBOX_UPDATE" ) then
		TPM_Debug("Inbox: ".. GetInboxNumItems());
		TitanSetVar(TITAN_MAIL_ID, "new", 0);
		TitanSetVar(TITAN_MAIL_ID, "total", GetInboxNumItems());
		TitanPanelMailButton_UpdateIcon(false);
	end
	if ( event == "UPDATE_PENDING_MAIL" ) then
		if ((TPM_lastclose + TPM_closedelay) > time()) then 
			TPM_Debug("Ignoring this pending");
			TPM_ignorenext = true
		end
		if (HasNewMail()) then TPM_Debug("Has mail"); end
		TitanMail_IncNew()
		TitanPanelMailButton_UpdateIcon(false);
	end
end

function TitanMail_Debug(state)
	TPM_debug = state
end

function TitanMail_TestIcon(icon)
	local button = TitanUtils_GetButton(TITAN_MAIL_ID, true);
	button.registry.icon = icon;
	TitanPanelButton_UpdateButton(TITAN_MAIL_ID);
end

function TitanMail_TestInc(isAH)
	TitanMail_IncNew()
	if (isAH) then
		TitanPanelMailButton_UpdateIcon(true);
		PlaySound("AuctionWindowOpen");
	else
		TitanPanelMailButton_UpdateIcon(false);
		PlaySoundFile(TITAN_MAIL_SOUND);
	end
end

function TitanMail_IncNew()		
	if (TPM_ignorenext) then
		TPM_Debug("Ignoring that one");
		TPM_ignorenext = false;
	else
		local new = TitanGetVar(TITAN_MAIL_ID, "new") + 1;
		local total = TitanGetVar(TITAN_MAIL_ID, "total") + 1;
		
		if (TPM_checkedmail) then
			total = GetInboxNumItems() + new;
		end
			
		TitanSetVar(TITAN_MAIL_ID, "new", new)
		TitanSetVar(TITAN_MAIL_ID, "total", total)
		
		if (TitanGetVar(TITAN_MAIL_ID, "chat")) then
			DEFAULT_CHAT_FRAME:AddMessage(TITAN_MAIL_CHAT_NEW.."("..new.."/"..total..")");
		end
		if (TitanGetVar(TITAN_MAIL_ID, "sound")) then 
			PlaySoundFile(TITAN_MAIL_SOUND); 
			TPM_Debug("Play Sound");
		end
		
	end
end

function TitanMail_ReadAHMsg(msg)
	local foundAH = false;
	local strset = {
		{ERR_AUCTION_WON_S, TITAN_MAIL_TOOLTIP_WON},
		{ERR_AUCTION_SOLD_S, TITAN_MAIL_TOOLTIP_SOLD},
		{ERR_AUCTION_OUTBID_S, TITAN_MAIL_TOOLTIP_OUTBID},
		{ERR_AUCTION_EXPIRED_S, TITAN_MAIL_TOOLTIP_EXPIRED},
		{ERR_AUCTION_REMOVED_S, TITAN_MAIL_TOOLTIP_CANCELLED},
	};
	
	for i,arr in strset do
		local searchstr = string.gsub(arr[1], "%%[^%s]+", "(.+)")
		local _, _, item = string.find(msg, searchstr)
		if (item) then 
			if (not TITAN_MAIL_SETTINGS[TPM_player].ahalerts) then
				TITAN_MAIL_SETTINGS[TPM_player].ahalerts = {};
			end
			tinsert(TITAN_MAIL_SETTINGS[TPM_player].ahalerts, arr[2].. item);
			-- Increment our count if this is a bugged event
			if (TPM_brokenEvents[arr[1]]) then
				TitanMail_IncNew();
				brokenevent = true;
			end
			foundAH = true;
		end
	end

	if (foundAH) then
		TPM_Debug("AH Mail");
		if (TitanGetVar(TITAN_MAIL_ID, "sound")) then 
			--PlaySound("AuctionWindowOpen"); 
			--TPM_Debug("Play Sound AH");
		end
	else
		TPM_Debug("Not an AH message.");
	end

end

function TitanPanelRightClickMenu_PrepareMailRightMenu()
	TitanMail_PrepareMenu(true)
end

function TitanPanelRightClickMenu_PrepareMailMenu()
	TitanMail_PrepareMenu()
end

function TitanMail_PrepareMenu(isright)
	local info;
	
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_MAIL_ID].menuText);
	TitanPanelRightClickMenu_AddSpacer();		

	info = {};
	info.text = TITAN_MAIL_MENU_HIDEMM;
	info.value = "hidemm";
	info.keepShownOnClick = 1;
	info.func = TitanMail_Toggle;
	info.checked = TitanGetVar(TITAN_MAIL_ID, "hidemm");
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TITAN_MAIL_MENU_SOUND;
	info.value = "sound";
	info.func = TitanMail_Toggle;
	info.keepShownOnClick = 1;
	info.checked = TitanGetVar(TITAN_MAIL_ID, "sound");
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TITAN_MAIL_MENU_CHAT;
	info.value = "chat";
	info.func = TitanMail_Toggle;
	info.keepShownOnClick = 1;
	info.checked = TitanGetVar(TITAN_MAIL_ID, "chat");
	UIDropDownMenu_AddButton(info);

	if (not isright) then
		TitanPanelRightClickMenu_AddSpacer();		
		local info = {};
		info.text = TITAN_PANEL_MENU_SHOW_ICON;
		info.value = "ShowIcon";
		info.func = TitanMail_Toggle;
		info.checked = TitanGetVar(TITAN_MAIL_ID, "ShowIcon");
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.text = TITAN_MAIL_MENU_STEXT;
		info.value = "ShowText";
		info.func = TitanMail_Toggle;
		info.checked = TitanGetVar(TITAN_MAIL_ID, "ShowText");
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.text = TITAN_MAIL_MENU_COUNT;
		info.value = "ShowCount";
		info.func = TitanMail_Toggle;
		info.keepShownOnClick = 1;
		info.checked = TitanGetVar(TITAN_MAIL_ID, "ShowCount");
		UIDropDownMenu_AddButton(info);
	end
	
	TitanPanelRightClickMenu_AddSpacer();		

	info = {};
	info.text = TITAN_MAIL_MENU_ALTICON;
	info.value = "ShowIconAlt";
	info.func = TitanMail_Toggle;
	info.keepShownOnClick = 1;
	info.checked = TitanGetVar(TITAN_MAIL_ID, "ShowIconAlt");
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TITAN_MAIL_MENU_NOICONNOMAIL;
	info.value = "NoIconNoMail";
	info.func = TitanMail_Toggle;
	info.keepShownOnClick = 1;
	info.checked = TitanGetVar(TITAN_MAIL_ID, "NoIconNoMail");
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();		

	if (isright) then
		TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_MAIL_ID_RIGHT, TITAN_PANEL_MENU_FUNC_HIDE);
	else
		TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_MAIL_ID, TITAN_PANEL_MENU_FUNC_HIDE);
	end

end

function TitanMail_Toggle()
	TitanToggleVar(TITAN_MAIL_ID, this.value);
	TitanPanelMailButton_UpdateIcon(false);
end

local function sorted_index(table)
    local index = {}
    for key in table do tinsert(index,key); end
    sort(index)
    return index
end
