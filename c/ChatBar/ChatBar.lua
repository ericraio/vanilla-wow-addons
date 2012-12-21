--------------------------------------------------------------------------
-- ChatBar.lua 
--------------------------------------------------------------------------
--[[
ChatBar

Author: AnduinLothar KarlKFI@cosmosui.org
Graphics: Vynn

-Button Bar for openning chat messages of each type.

Change Log:
v1.0
-Initial Release
v1.1
-Addon Channels Hidden added GuildMap
-Text has been made Localizable
-Officer chat shows up if you CanEditOfficerNote()
-Buttons now correctly update when raid, party, and guild changes
-Hide Text now correctly says Show Text
-Fixed button for channel 8 to diplay and tooltip correctly
-Added Reset Position Option
-Added Options to hide the each button by chat type or channel name (hide from button menu, show from main sub menu)
-Added option to use Channel Numbers as text overlay
-Added VisibilityOptions, however autohide is a bit finicky atm.
v1.2
-VisibilityOptions AutoHide is now smarter and shows whenever ChatBar is sliding or being dragged or the cursor is over its menu
-Fixed Eclipse onload error
-Fixed Whisper abreviation
v1.3
-Fixed nil SetText errors
-Fixed channel 10 nil errors
-Added Channel Reorder (from ChannelManager) if you have Sky installed (uses many library functions)
v1.4
-Fixed a nil loading error
v1.5
-Fixed saved variables issue with 1.11 not saving nils
-Fixed a nill bug with the right-click menu
v1.6
-Channel Reorder no longer requires Sky
-toc to 11200

]]--

--------------------------------------------------
-- Globals
--------------------------------------------------

CHAT_BAR_MAX_BUTTONS = 20;
CHAT_BAR_UPDATE_DELAY = 30;
ChatBar_VerticalDisplay = false;
ChatBar_AlternateOrientation = false;
ChatBar_TextOnButtonDisplay = false;
ChatBar_ButtonFlashing = true;
ChatBar_BarBorder = true;
ChatBar_ButtonText = true;
ChatBar_TextChannelNumbers = false;
ChatBar_VerticalDisplay_Sliding = false;
ChatBar_AlternateDisplay_Sliding = false;
ChatBar_HideSpecialChannels = true;
ChatBar_LastTell = nil;
ChatBar_StoredStickies = { };
ChatBar_HiddenButtons = { };

--------------------------------------------------
-- Retell Hook
--------------------------------------------------

local SendChatMessage_orig = SendChatMessage;
function ChatBar_SendChatMessage(text, type, language, target)
	SendChatMessage_orig(text, type, language, target);
	-- saves target for 'Retell'
	if ( type == "WHISPER" ) then
		ChatBar_LastTell = target;
	end
end
SendChatMessage = ChatBar_SendChatMessage;

--------------------------------------------------
-- Button Functions
--------------------------------------------------

function ChatBar_StandardButtonClick(button)
	local chatFrame = SELECTED_DOCK_FRAME
	if ( not chatFrame ) then
		chatFrame = DEFAULT_CHAT_FRAME;
	end
	if (button == "RightButton") then
		ToggleDropDownMenu(1, this.ChatID, ChatBar_DropDown, this:GetName(), 10, 0, "TOPRIGHT");
	else
		local chatType = ChatBar_ChatTypes[this.ChatID].type;
		chatFrame.editBox:Show();
		if (chatFrame.editBox.chatType == chatType) then
			ChatFrame_OpenChat("", chatFrame);
		else
			chatFrame.editBox.chatType = chatType;
		end
		ChatEdit_UpdateHeader(chatFrame.editBox);
	end
end

function ChatBar_WhisperButtonClick(button)
	local chatFrame = SELECTED_DOCK_FRAME
	if ( not chatFrame ) then
		chatFrame = DEFAULT_CHAT_FRAME;
	end
	if (button == "RightButton") then
		ToggleDropDownMenu(1, this.ChatID, ChatBar_DropDown, this:GetName(), 10, 0, "TOPRIGHT");
	else
		local chatType = ChatBar_ChatTypes[this.ChatID].type;
		--ChatFrame_SendTell(name, SELECTED_DOCK_FRAME)
		if (chatFrame.editBox.chatType == chatType) then
			ChatFrame_OpenChat("", chatFrame);
		else
			ChatFrame_ReplyTell(chatFrame);
			if (not chatFrame.editBox:IsVisible()) or (chatFrame.editBox.chatType ~= chatType) then
				ChatFrame_OpenChat("/w ", chatFrame);
			end
		end
	end
end

function ChatBar_ChannelShortText(index)
	local channelNum, channelName = GetChannelName(index);
	if (channelNum ~= 0) then
		if (ChatBar_TextChannelNumbers) then
			return channelNum;
		else
			return strsub(channelName,1,1);
		end
	end
end

function ChatBar_ChannelText(index)
	local channelNum, channelName = GetChannelName(index);
	if (channelNum ~= 0) then
		return channelNum..") "..channelName;
	end
	return "";
end

function ChatBar_ChannelClick(button, index)
	if (not index) then
		index = 1;
	end
	local chatFrame = SELECTED_DOCK_FRAME
	if ( not chatFrame ) then
		chatFrame = DEFAULT_CHAT_FRAME;
	end
	if (button == "RightButton") then
		ToggleDropDownMenu(1, this.ChatID, ChatBar_DropDown, this:GetName(), 10, 0, "TOPRIGHT");
	else
		--local chatType = ChatBar_ChatTypes[this.ChatID].type;
		chatFrame.editBox:Show();
		if (chatFrame.editBox.chatType == "CHANNEL") and (chatFrame.editBox.channelTarget == index) then
			ChatFrame_OpenChat("", chatFrame);
		else
			chatFrame.editBox.chatType = "CHANNEL";
			chatFrame.editBox.channelTarget = index
			ChatEdit_UpdateHeader(chatFrame.editBox);
		end
	end

end

function ChatBar_ChannelShow(index)
	local channelNum, channelName = GetChannelName(index);
	if (channelNum ~= 0) then
		if (ChatBar_HideSpecialChannels) then
			--Special Hidden Whisper Ignores
			if ( IsAddOnLoaded("Sky") ) then
				if (string.len(channelName) >= 3) and (string.sub(channelName,1,3) == "Sky") then
					--Hide Sky channels
					return;
				end
				for i, bogusName in BOGUS_CHANNELS do
					if (channelName == bogusName) then
						--Hide reorder channels
						return;
					end
				end
			elseif ( IsAddOnLoaded("CallToArms") ) and (channelName == CTA_DEFAULT_RAID_CHANNEL) then
				--Hide CallToArms channel
				return;
			elseif ( IsAddOnLoaded("CT_RaidAssist") ) and (channelName == CT_RA_Channel) then
				--Hide CT_RaidAssist channel
				return;
			elseif ( IsAddOnLoaded("GuildMap") ) and (GuildMapConfig) and (channelName == GuildMapConfig.channel) then
				--Hide GuildMap channel
				return;
			elseif ( channelName == "GlobalComm" ) then
				--Hide standard GlobalComm channel (Telepathy, AceComm)
				return;
			end
		end
		return (not ChatBar_HiddenButtons[ChatBar_GetFirstWord(channelName)]);
	end
end

--------------------------------------------------
-- Button Info
--------------------------------------------------

ChatBar_ChatTypes = {
	{
		type = "SAY",
		shortText = function() return CHATBAR_SAY_ABRV; end,
		text = function() return CHAT_MSG_SAY; end,
		click = ChatBar_StandardButtonClick,
		show = function()
			return (not ChatBar_HiddenButtons[CHAT_MSG_SAY]);
		end
	},
	{
		type = "YELL",
		shortText = function() return CHATBAR_YELL_ABRV; end,
		text = function() return CHAT_MSG_YELL; end,
		click = ChatBar_StandardButtonClick,
		show = function()
			return (not ChatBar_HiddenButtons[CHAT_MSG_YELL]);
		end
	},
	{
		type = "PARTY",
		shortText = function() return CHATBAR_PARTY_ABRV; end,
		text = function() return CHAT_MSG_PARTY; end,
		click = ChatBar_StandardButtonClick,
		show = function()
			return UnitExists("party1") and (not ChatBar_HiddenButtons[CHAT_MSG_PARTY]);
		end
	},
	{
		type = "RAID",
		shortText = function() return CHATBAR_RAID_ABRV; end,
		text = function() return CHAT_MSG_RAID; end,
		click = ChatBar_StandardButtonClick,
		show = function()
			return (GetNumRaidMembers() > 0) and (not ChatBar_HiddenButtons[CHAT_MSG_RAID]);
		end
	},
	{
		type = "GUILD",
		shortText = function() return CHATBAR_GUILD_ABRV; end,
		text = function() return CHAT_MSG_GUILD; end,
		click = ChatBar_StandardButtonClick,
		show = function()
			return IsInGuild() and (not ChatBar_HiddenButtons[CHAT_MSG_GUILD]);
		end
	},
	{
		type = "OFFICER",
		shortText = function() return CHATBAR_OFFICER_ABRV; end,
		text = function() return CHAT_MSG_OFFICER; end,
		click = ChatBar_StandardButtonClick,
		show = function()
			return CanEditOfficerNote() and (not ChatBar_HiddenButtons[CHAT_MSG_OFFICER]);
		end
	},
	{
		type = "WHISPER",
		shortText = function() return CHATBAR_WHISPER_ABRV; end,
		text = function() return CHAT_MSG_WHISPER_INFORM; end,
		click = ChatBar_WhisperButtonClick,
		show = function()
			return (not ChatBar_HiddenButtons[CHAT_MSG_WHISPER_INFORM]);
		end
	},
	{
		type = "EMOTE",
		shortText = function() return CHATBAR_EMOTE_ABRV; end,
		text = function() return CHAT_MSG_EMOTE; end,
		click = ChatBar_StandardButtonClick,
		show = function()
			return (not ChatBar_HiddenButtons[CHAT_MSG_EMOTE]);
		end
	},
	{
		type = "CHANNEL1",
		shortText = function() return ChatBar_ChannelShortText(1); end,
		text = function() return ChatBar_ChannelText(1); end,
		click = function(button) ChatBar_ChannelClick(button, 1); end,
		show = function() return ChatBar_ChannelShow(1); end
	},
	{
		type = "CHANNEL2",
		shortText = function() return ChatBar_ChannelShortText(2); end,
		text = function() return ChatBar_ChannelText(2); end,
		click = function(button) ChatBar_ChannelClick(button, 2); end,
		show = function() return ChatBar_ChannelShow(2); end
	},
	{
		type = "CHANNEL3",
		shortText = function() return ChatBar_ChannelShortText(3); end,
		text = function() return ChatBar_ChannelText(3); end,
		click = function(button) ChatBar_ChannelClick(button, 3); end,
		show = function() return ChatBar_ChannelShow(3); end
	},
	{
		type = "CHANNEL4",
		shortText = function() return ChatBar_ChannelShortText(4); end,
		text = function() return ChatBar_ChannelText(4); end,
		click = function(button) ChatBar_ChannelClick(button, 4); end,
		show = function() return ChatBar_ChannelShow(4); end
	},
	{
		type = "CHANNEL5",
		shortText = function() return ChatBar_ChannelShortText(5); end,
		text = function() return ChatBar_ChannelText(5); end,
		click = function(button) ChatBar_ChannelClick(button, 5); end,
		show = function() return ChatBar_ChannelShow(5); end
	},
	{
		type = "CHANNEL6",
		shortText = function() return ChatBar_ChannelShortText(6); end,
		text = function() return ChatBar_ChannelText(6); end,
		click = function(button) ChatBar_ChannelClick(button, 6); end,
		show = function() return ChatBar_ChannelShow(6); end
	},
	{
		type = "CHANNEL7",
		shortText = function() return ChatBar_ChannelShortText(7); end,
		text = function() return ChatBar_ChannelText(7); end,
		click = function(button) ChatBar_ChannelClick(button, 7); end,
		show = function() return ChatBar_ChannelShow(7); end
	},
	{
		type = "CHANNEL8",
		shortText = function() return ChatBar_ChannelShortText(8); end,
		text = function() return ChatBar_ChannelText(8); end,
		click = function(button) ChatBar_ChannelClick(button, 8); end,
		show = function() return ChatBar_ChannelShow(8); end
	},
	{
		type = "CHANNEL9",
		shortText = function() return ChatBar_ChannelShortText(9); end,
		text = function() return ChatBar_ChannelText(9); end,
		click = function(button) ChatBar_ChannelClick(button, 9); end,
		show = function() return ChatBar_ChannelShow(9); end
	},
	{
		type = "CHANNEL10",
		shortText = function() return ChatBar_ChannelShortText(10); end,
		text = function() return ChatBar_ChannelText(10); end,
		click = function(button) ChatBar_ChannelClick(button, 10); end,
		show = function() return ChatBar_ChannelShow(10); end
	}
	
};

ChatBar_BarTypes = {};

--------------------------------------------------
-- Frame Scripts
--------------------------------------------------

function ChatBar_OnLoad()
	this:RegisterEvent("UPDATE_CHAT_COLOR");
	this:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("PLAYER_GUILD_UPDATE");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterForDrag("LeftButton");
	this.velocity = 0;
	if (Eclipse) then
		--Register with VisibilityOptions
		Eclipse.registerForVisibility( {
			name = "ChatBarFrame";	--The name of the config, in this case also the name of the frame
			uiname = "ChatBar";	--This is the base name of this reg to display in the description and ui
			slashcom = { "chatbar", "cb" };	--These are the slash commands
			reqs = { var=ChatBar_ShowIf, val=true, show=true };
		}	);
	end
end

function ChatBar_ShowIf()
	return ChatBarFrame.isSliding or ChatBarFrame.isMoving or (type(ChatBarFrame.count)=="number") or ((UIDROPDOWNMENU_OPEN_MENU=="ChatBar_DropDown" and (MouseIsOver(DropDownList1) or (UIDROPDOWNMENU_MENU_LEVEL==2 and MouseIsOver(DropDownList2))))==1);
end

function ChatBar_OnEvent(event)
	if ( event == "UPDATE_CHAT_COLOR" ) then
		ChatBarFrame.count = 0;
	elseif ( event == "CHAT_MSG_CHANNEL_NOTICE" ) then
		ChatBarFrame.count = 0;
	elseif ( event == "PARTY_MEMBERS_CHANGED" ) then
		ChatBarFrame.count = 0;
	elseif ( event == "RAID_ROSTER_UPDATE" ) then
		ChatBarFrame.count = 0;
	elseif ( event == "PLAYER_GUILD_UPDATE" ) then
		ChatBarFrame.count = 0;
	elseif ( event == "CHAT_MSG_CHANNEL" ) and (type(arg8) == "number") then
		if (ChatBar_BarTypes["CHANNEL"..arg8]) then
			UIFrameFlash(getglobal("ChatBarFrameButton"..ChatBar_BarTypes["CHANNEL"..arg8].."Flash"), .5, .5, 1.1);
		end
	elseif (event == "CHAT_MSG_SAY") or (event == "CHAT_MSG_YELL") or (event == "CHAT_MSG_PARTY") or (event == "CHAT_MSG_RAID") or 
		(event == "CHAT_MSG_GUILD") or (event == "CHAT_MSG_OFFICER") or (event == "CHAT_MSG_WHISPER") or (event == "CHAT_MSG_EMOTE") then
		--Sea.io.printComma(arg1,arg2,arg3);
		if (ChatBar_BarTypes[strsub(event,10)]) then
			UIFrameFlash(getglobal("ChatBarFrameButton"..ChatBar_BarTypes[strsub(event,10)].."Flash"), .5, .5, 1.1);
		end
	elseif ( event == "VARIABLES_LOADED" ) then
		ChatBar_UpdateButtonOrientation();
		ChatBar_UpdateButtonFlashing();
		ChatBar_UpdateBarBorder();
		ChatBar_UpdateButtonText();
		
		--Update live Stickies
		for chatType, enabled in ChatBar_StoredStickies do
			if (enabled) then
				ChatTypeInfo[chatType].sticky = enabled;
			end
		end
	end
end

--ConstantInitialVelocity = 10;
ConstantVelocityModifier = 1.25;
ConstantJerk = 3*ConstantVelocityModifier;
ConstantSnapLimit = 2;

function ChatBar_OnUpdate(elapsed)
	
	if (this.slidingEnabled) and (this.isSliding) and (this.velocity) and (this.endsize) then
		local currSize = ChatBar_GetSize();
		if (math.abs(currSize - this.endsize) < ConstantSnapLimit) then
			ChatBar_SetSize(this.endsize);
			ChatBarFrame.isSliding = nil;
			this.velocity = 0;
			if (ChatBar_VerticalDisplay_Sliding or ChatBar_AlternateDisplay_Sliding) and (this:GetWidth() <= 17) and (this:GetHeight() <= 17) then
				if (ChatBar_VerticalDisplay_Sliding) then
					ChatBar_VerticalDisplay_Sliding = nil;
					ChatBar_Toggle_VerticalButtonOrientation();
				elseif (ChatBar_AlternateDisplay_Sliding) then
					ChatBar_AlternateDisplay_Sliding = nil;
					ChatBar_Toggle_AlternateButtonOrientation();
				end
				ChatBar_UpdateOrientationPoint();
			else
				ChatBar_UpdateOrientationPoint(true);
			end
		else
			--[[
			local desiredVelocity = ConstantVelocityModifier * (this.endsize - currSize);
			this.velocity = (1 - ConstantJerk) * this.velocity + ConstantJerk * desiredVelocity;
			ChatBar_SetSize(currSize + this.velocity * elapsed);
			]]--
			--[[
			local w = 1 - math.exp(-ConstantJerk* elapsed);
			this.velocity = (1-w)*this.velocity + w*ConstantVelocityModifier*(this.endsize - currSize);
			ChatBar_SetSize(currSize + this.velocity * elapsed);
			]]--
			--[[ incomplete
			local totalDistance = this.endsize - this.startsize; 
			local distanceFromStart = this.startsize - currSize;
			local accel = math.cos(distanceFromStart/totalDistance*math.pi) * ConstantJerk;
			ChatBar_SetSize(currSize + accel * elapsed * elapsed);
			]]--
			local desiredVelocity = ConstantVelocityModifier * (this.endsize - currSize);
			local acceleration = ConstantJerk * (desiredVelocity - this.velocity);
			this.velocity = this.velocity + acceleration * elapsed;
			ChatBar_SetSize(currSize + this.velocity * elapsed);
		end
		local frame, init, final, step;
		for i=1, CHAT_BAR_MAX_BUTTONS do
			frame = getglobal("ChatBarFrameButton".. i);
			if (currSize >= i*16+18) then
				frame:Show();
			else
				frame:Hide();
			end
		end
	elseif (this.count) then
		if (this.count > CHAT_BAR_UPDATE_DELAY) then
			this.count = nil;
			ChatBarFrame.slidingEnabled = true;
			ChatBar_UpdateButtons();
		else
			this.count = this.count+1;
		end
	end
	
end

function ChatBar_GetSize()
	if (ChatBar_VerticalDisplay) then
		return ChatBarFrame:GetHeight();
	else
		return ChatBarFrame:GetWidth();
	end
end

function ChatBar_SetSize(size)
	if (ChatBar_VerticalDisplay) then
		ChatBarFrame:SetHeight(size);
	else
		ChatBarFrame:SetWidth(size);
	end
end

function ChatBar_Button_OnLoad()
	this.Text = getglobal("ChatBarFrameButton"..this:GetID().."Text");
	this.ChatID = this:GetID();

	getglobal(this:GetName().."Highlight"):SetAlpha(.75);
	getglobal(this:GetName().."UpTex_Spec"):SetAlpha(.75);
	getglobal(this:GetName().."UpTex_Shad"):SetAlpha(.75);
	--getglobal(this:GetName().."DownTex_Spec"):SetAlpha(1);
	getglobal(this:GetName().."DownTex_Shad"):SetAlpha(1);
	
	this:SetFrameLevel(this:GetFrameLevel()+1);
	this:RegisterForClicks("LeftButtonDown", "RightButtonDown");
end

function ChatBar_Button_OnClick()
	ChatBar_ChatTypes[this.ChatID].click(arg1);
end

function ChatBar_Button_OnEnter()
	--local id = this:GetID();
	if (this.ChatID) then
		ChatBarFrameTooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		ChatBarFrameTooltip:SetText(ChatBar_ChatTypes[this.ChatID].text());
	end
end

function ChatBar_Button_OnLeave()
	if (ChatBarFrameTooltip:IsOwned(this)) then
		ChatBarFrameTooltip:Hide();
	end
end

function ChatBar_OnMouseDown(button)
	if (button == "RightButton") then
		ToggleDropDownMenu(1, "ChatBarMenu", ChatBar_DropDown, "cursor");
	else
		local x, y = GetCursorPosition();
		this.xOffset = x - this:GetLeft();
		this.yOffset = y - this:GetBottom();
	end
end

function ChatBar_OnDragStart()
	if (not this.isSliding) then
		local x, y = GetCursorPosition();
		this:ClearAllPoints();
		this:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", x-this.xOffset, y-this.yOffset);
		this:StartMoving();
		this.isMoving = true;
	end
end

function ChatBar_OnDragStop()
	this:StopMovingOrSizing();
	this.isMoving = false;
	ChatBar_UpdateOrientationPoint(true);
end

--------------------------------------------------
-- DropDown Menu
--------------------------------------------------

function ChatBar_DropDownOnLoad()
	UIDropDownMenu_Initialize(this, ChatBar_LoadDropDownMenu, "MENU");
end

function ChatBar_LoadDropDownMenu()
	if (not UIDROPDOWNMENU_MENU_VALUE) then
		return;
	end
	
	if (UIDROPDOWNMENU_MENU_VALUE == "ChatBarMenu") then
		ChatBar_CreateFrameMenu();
	elseif (UIDROPDOWNMENU_MENU_VALUE == "HiddenButtonsMenu") then
		ChatBar_CreateHiddenButtonsMenu();
	else
		ChatBar_CreateButtonMenu();
	end
	
end

function ChatBar_CreateFrameMenu()
	--Title
	local info = {};
	info.text = CHATBAR_MENU_MAIN_TITLE;
	info.notClickable = 1;
	info.isTitle = 1;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	--Vertical
	local info = {};
	info.text = CHATBAR_MENU_MAIN_VERTICAL;
	info.func = ChatBar_Toggle_VerticalButtonOrientationSlide;
	if (ChatBar_VerticalDisplay) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	--Alt Button
	local info = {};
	info.text = CHATBAR_MENU_MAIN_REVERSE;
	info.func = ChatBar_Toggle_AlternateButtonOrientationSlide;
	if (ChatBar_AlternateOrientation) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	--Text On Buttons
	local info = {};
	info.text = CHATBAR_MENU_MAIN_TEXTONBUTTONS;
	info.func = ChatBar_Toggle_TextOrientation;
	info.keepShownOnClick = 1;
	if (ChatBar_TextOnButtonDisplay) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	--Show Button Text
	local info = {};
	info.text = CHATBAR_MENU_MAIN_SHOWTEXT;
	info.func = ChatBar_Toggle_ButtonText;
	info.keepShownOnClick = 1;
	if (ChatBar_ButtonText) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	--Use Channel ID on Buttons
	local info = {};
	info.text = CHATBAR_MENU_MAIN_CHANNELID;
	info.func = ChatBar_Toggle_TextChannelNumbers;
	info.keepShownOnClick = 1;
	if (ChatBar_TextChannelNumbers) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	--Button Flashing
	local info = {};
	info.text = CHATBAR_MENU_MAIN_BUTTONFLASHING;
	info.func = ChatBar_Toggle_ButtonFlashing;
	info.keepShownOnClick = 1;
	if (ChatBar_ButtonFlashing) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	--Bar Border
	local info = {};
	info.text = CHATBAR_MENU_MAIN_BARBORDER;
	info.func = ChatBar_Toggle_BarBorder;
	info.keepShownOnClick = 1;
	if (ChatBar_BarBorder) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	--Hide Special
	local info = {};
	info.text = CHATBAR_MENU_MAIN_ADDONCHANNELS;
	info.func = ChatBar_Toggle_HideSpecialChannels;
	if (ChatBar_HideSpecialChannels) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	if (ChatBar_GetTableSize(ChatBar_HiddenButtons) > 0) then
		--Show Hidden Buttons
		local info = {};
		info.text = CHATBAR_MENU_MAIN_HIDDENBUTTONS;
		info.hasArrow = 1;
		info.func = nil;
		info.value = "HiddenButtonsMenu";
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	end
	
	--Reset Position
	local info = {};
	info.text = CHATBAR_MENU_MAIN_RESET;
	info.func = ChatBar_Reset;
	if (not ChatBarFrame:IsUserPlaced()) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	if (ChatBar_ReorderChannels) then
		--Reorder Channels
		local info = {};
		info.text = CHATBAR_MENU_MAIN_REORDER;
		info.func = ChatBar_ReorderChannels;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	end
end

function ChatBar_CreateHiddenButtonsMenu()
	for k,v in ChatBar_HiddenButtons do
		--Show Button
		local info = {};
		info.text = format(CHATBAR_MENU_SHOW_BUTTON, k);
		local ctype = k;
		info.func = function() ChatBar_HiddenButtons[ctype]=nil ChatBarFrame.count = 0; end;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	end
end

function ChatBar_CreateButtonMenu()
	local buttonHeader = ChatBar_ChatTypes[UIDROPDOWNMENU_MENU_VALUE].type;
	
	--Title
	local info = {};
	info.text = ChatBar_ChatTypes[UIDROPDOWNMENU_MENU_VALUE].text();
	info.notClickable = 1;
	info.isTitle = 1;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	local chatType, channelIndex = string.gfind(buttonHeader, "([^%d]*)([%d]+)$")();
	if (channelIndex) then
		local channelNum, channelName = GetChannelName(tonumber(channelIndex));
		--Leave
		local info = {};
		info.text = CHATBAR_MENU_CHANNEL_LEAVE;
		info.func = function() LeaveChannelByName(channelNum) end;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		--Channel User List
		local info = {};
		info.text = CHATBAR_MENU_CHANNEL_LIST;
		info.func = function() ListChannelByName(channelNum) end;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		
		--Hide Button
		local channelShortName = ChatBar_GetFirstWord(channelName);
		local info = {};
		info.text = format(CHATBAR_MENU_HIDE_BUTTON, channelShortName);
		info.func = function() ChatBar_HiddenButtons[channelShortName]=true; ChatBarFrame.count = 0; end;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	else
		--Hide Button
		local info = {};
		local localizedChatType = ChatBar_ChatTypes[UIDROPDOWNMENU_MENU_VALUE].text()
		info.text = format(CHATBAR_MENU_HIDE_BUTTON, localizedChatType);
		info.func = function() ChatBar_HiddenButtons[localizedChatType]=true; ChatBarFrame.count = 0; end;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	end
	
	if (buttonHeader == "WHISPER") then
		local chatFrame = SELECTED_DOCK_FRAME
		if ( not chatFrame ) then
			chatFrame = DEFAULT_CHAT_FRAME;
		end
		
		--Reply
		local info = {};
		info.text = CHATBAR_MENU_WHISPER_REPLY;
		info.func = function()
			ChatFrame_ReplyTell(chatFrame)
		end;
		if (ChatEdit_GetLastTellTarget(ChatFrameEditBox) == "") then
			info.disabled = 1;
		end
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		
		--Retell
		local info = {};
		info.text = CHATBAR_MENU_WHISPER_RETELL;
		info.func = function()
			ChatFrame_SendTell(ChatBar_LastTell, chatFrame)
		end;
		if (not ChatBar_LastTell) then
			info.disabled = 1;
		end
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	end
	
	--Sticky
	local info = {};
	if (chatType) then
		info.text = CHATBAR_MENU_CHANNEL_STICKY;
	else
		info.text = CHATBAR_MENU_STICKY;
		chatType = buttonHeader;
	end
	info.func = function()
		if (ChatTypeInfo[chatType].sticky == 1) then
			ChatTypeInfo[chatType].sticky = 0;
			ChatBar_StoredStickies[chatType] = 0;
		else
			ChatTypeInfo[chatType].sticky = 1;
			ChatBar_StoredStickies[chatType] = 1;
		end
	end;
	if (ChatTypeInfo[chatType].sticky == 1) then
		info.checked = 1;
	end
	if (not ChatTypeInfo[chatType]) then
		info.disabled = 1;
	end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

end

--------------------------------------------------
-- Update Functions
--------------------------------------------------

function ChatBar_UpdateButtons()
	
	ChatBar_BarTypes = {};
	local i = 1;
	local buttonIndex = 1;
	while (ChatBar_ChatTypes[i]) and (buttonIndex <= CHAT_BAR_MAX_BUTTONS) do
		if (ChatBar_ChatTypes[i].show()) then
			local info=ChatTypeInfo[ChatBar_ChatTypes[i].type];
			ChatBar_BarTypes[ChatBar_ChatTypes[i].type] = buttonIndex;
			getglobal("ChatBarFrameButton".. buttonIndex.."Highlight"):SetVertexColor(info.r, info.g, info.b);
			getglobal("ChatBarFrameButton".. buttonIndex.."Flash"):SetVertexColor(info.r, info.g, info.b);
			getglobal("ChatBarFrameButton".. buttonIndex.."Center"):SetVertexColor(info.r, info.g, info.b);
			getglobal("ChatBarFrameButton".. buttonIndex.."Text"):SetText(ChatBar_ChatTypes[i].shortText());
			getglobal("ChatBarFrameButton".. buttonIndex).ChatID = i;
			--getglobal("ChatBarFrameButton".. buttonIndex):Show();
			buttonIndex = buttonIndex+1;
		end
		i = i+1;
	end
	local size = (buttonIndex-1)*16+20;
	if (ChatBar_VerticalDisplay) then
		ChatBarFrame:SetWidth(16);
		if (ChatBarFrame:GetTop()) then
			ChatBar_StartSlidingTo(size);
		else
			ChatBarFrame:SetHeight(size);
		end
	else
		ChatBarFrame:SetHeight(16);
		if (ChatBarFrame:GetRight()) then
			ChatBar_StartSlidingTo(size);
		else
			ChatBarFrame:SetWidth(size);
		end
		--/z ChatBarFrame.startpoint = ChatBarFrame:GetRight();ChatBarFrame.endsize = ChatBarFrame:GetLeft() + 260;
		--/z ChatBarFrame.centerpoint = ChatBarFrame.startpoint + (ChatBarFrame.endsize - ChatBarFrame.startpoint)/2;ChatBarFrame.velocity = 0;ChatBarFrame.isSliding = true;
		--/z ChatBarFrame.isSliding = nil; ChatBarFrame:SetWidth(180)
		--/z ChatBar_StartSlidingTo(300)
	end
	while (buttonIndex <= CHAT_BAR_MAX_BUTTONS) do
		--getglobal("ChatBarFrameButton".. buttonIndex):Hide();
		getglobal("ChatBarFrameButton".. buttonIndex).ChatID = nil;
		buttonIndex = buttonIndex+1;
	end

end

function ChatBar_StartSlidingTo(size)
	ChatBarFrame.endsize = size;
	ChatBarFrame.isSliding = true;
end

function ChatBar_PrintSlideInfo()
	Sea.io.printComma(ChatBarFrame.isSliding, ChatBarFrame.endsize, ChatBarFrame.velocity);
end

function ChatBar_UpdateButtonOrientation()
	local button = ChatBarFrameButton1;
	button:ClearAllPoints();
	button.Text:ClearAllPoints();
	if (ChatBar_VerticalDisplay) then
		if (ChatBar_AlternateOrientation) then
			button:SetPoint("TOP", "ChatBarFrame", "TOP", 0, -10);
		else
			button:SetPoint("BOTTOM", "ChatBarFrame", "BOTTOM", 0, 10);
		end
		if (ChatBar_TextOnButtonDisplay) then
			button.Text:SetPoint("CENTER", button);
		else
			button.Text:SetPoint("RIGHT", button, "LEFT", 0, 0);
		end
	else
		if (ChatBar_AlternateOrientation) then
			button:SetPoint("RIGHT", "ChatBarFrame", "RIGHT", -10, 0);
		else
			button:SetPoint("LEFT", "ChatBarFrame", "LEFT", 10, 0);
		end
		if (ChatBar_TextOnButtonDisplay) then
			button.Text:SetPoint("CENTER", button);
		else
			button.Text:SetPoint("BOTTOM", button, "TOP");
		end
	end
	for i=2, CHAT_BAR_MAX_BUTTONS do
		button = getglobal("ChatBarFrameButton"..i);
		button:ClearAllPoints();
		button.Text:ClearAllPoints();
		if (ChatBar_VerticalDisplay) then
			if (ChatBar_AlternateOrientation) then
				button:SetPoint("TOP", "ChatBarFrameButton"..(i-1), "BOTTOM");
			else
				button:SetPoint("BOTTOM", "ChatBarFrameButton"..(i-1), "TOP");
			end
			if (ChatBar_TextOnButtonDisplay) then
				button.Text:SetPoint("CENTER", button);
			else
				button.Text:SetPoint("RIGHT", button, "LEFT");
			end
		else
			if (ChatBar_AlternateOrientation) then
				button:SetPoint("RIGHT", "ChatBarFrameButton"..(i-1), "LEFT");
			else
				button:SetPoint("LEFT", "ChatBarFrameButton"..(i-1), "RIGHT");
			end
			if (ChatBar_TextOnButtonDisplay) then
				button.Text:SetPoint("CENTER", button);
			else
				button.Text:SetPoint("BOTTOM", button, "TOP");
			end
		end
	end
end

function ChatBar_UpdateButtonFlashing()
	local frame = ChatBarFrame;
	if (ChatBar_ButtonFlashing) then
		frame:RegisterEvent("CHAT_MSG_SAY");
		frame:RegisterEvent("CHAT_MSG_YELL");
		frame:RegisterEvent("CHAT_MSG_PARTY");
		frame:RegisterEvent("CHAT_MSG_RAID");
		frame:RegisterEvent("CHAT_MSG_GUILD");
		frame:RegisterEvent("CHAT_MSG_OFFICER");
		frame:RegisterEvent("CHAT_MSG_WHISPER");
		frame:RegisterEvent("CHAT_MSG_EMOTE");
		frame:RegisterEvent("CHAT_MSG_CHANNEL");
	else
		frame:UnregisterEvent("CHAT_MSG_SAY");
		frame:UnregisterEvent("CHAT_MSG_YELL");
		frame:UnregisterEvent("CHAT_MSG_PARTY");
		frame:UnregisterEvent("CHAT_MSG_RAID");
		frame:UnregisterEvent("CHAT_MSG_GUILD");
		frame:UnregisterEvent("CHAT_MSG_OFFICER");
		frame:UnregisterEvent("CHAT_MSG_WHISPER");
		frame:UnregisterEvent("CHAT_MSG_EMOTE");
		frame:UnregisterEvent("CHAT_MSG_CHANNEL");

	end
end

function ChatBar_UpdateBarBorder()
	if (ChatBar_BarBorder) then
		ChatBarFrameBackground:Show();
	else
		ChatBarFrameBackground:Hide();
	end
end

function ChatBar_Reset()
	ChatBarFrame:ClearAllPoints();
	ChatBarFrame:SetPoint("BOTTOMLEFT", "ChatFrame1", "TOPLEFT", 0, 30);
	ChatBarFrame:SetUserPlaced(0);
end

--------------------------------------------------
-- Configuration Functions
--------------------------------------------------

function ChatBar_Toggle_VerticalButtonOrientationSlide()
	if (not ChatBarFrame.isMoving) then
		ChatBar_VerticalDisplay_Sliding = true;
		ChatBar_StartSlidingTo(16);
	end
end

function ChatBar_Toggle_AlternateButtonOrientationSlide()
	if (not ChatBarFrame.isMoving) then
		ChatBar_AlternateDisplay_Sliding = true;
		ChatBar_StartSlidingTo(16);
	end
end

function ChatBar_Toggle_VerticalButtonOrientation()
	if (ChatBar_VerticalDisplay) then
		ChatBar_VerticalDisplay = false;
	else
		ChatBar_VerticalDisplay = true;
	end
	--ChatBar_UpdateOrientationPoint();
	ChatBar_UpdateButtonOrientation();
	ChatBar_UpdateButtons();
end

function ChatBar_UpdateOrientationPoint(expanded)
	local x, y;
	if (ChatBarFrame:IsUserPlaced()) then
		if (expanded) then
			if (ChatBar_AlternateOrientation) then
				x = ChatBarFrame:GetRight();
				y = ChatBarFrame:GetTop();
				ChatBarFrame:ClearAllPoints();
				ChatBarFrame:SetPoint("TOPRIGHT", "UIParent", "BOTTOMLEFT", x, y);
			else
				x = ChatBarFrame:GetLeft();
				y = ChatBarFrame:GetBottom();
				ChatBarFrame:ClearAllPoints();
				ChatBarFrame:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", x, y);
			end
		else
			if (ChatBar_AlternateOrientation) then
				x = ChatBarFrame:GetLeft()+16;
				y = ChatBarFrame:GetBottom()+16;
				ChatBarFrame:ClearAllPoints();
				ChatBarFrame:SetPoint("TOPRIGHT", "UIParent", "BOTTOMLEFT", x, y);
			else
				x = ChatBarFrame:GetRight()-16;
				y = ChatBarFrame:GetTop()-16;
				ChatBarFrame:ClearAllPoints();
				ChatBarFrame:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", x, y);
			end
		end
	else
		if (ChatBar_AlternateOrientation) then
			ChatBarFrame:ClearAllPoints();
			ChatBarFrame:SetPoint("TOPRIGHT", "ChatFrame1", "TOPLEFT", 16, 46);
		else
			ChatBarFrame:ClearAllPoints();
			ChatBarFrame:SetPoint("BOTTOMLEFT", "ChatFrame1", "TOPLEFT", 0, 30);
		end
	end
end

function ChatBar_Toggle_AlternateButtonOrientation()
	if (ChatBar_AlternateOrientation) then
		ChatBar_AlternateOrientation = false;
	else
		ChatBar_AlternateOrientation = true;
	end
	--ChatBar_UpdateOrientationPoint();
	ChatBar_UpdateButtonOrientation();
	ChatBar_UpdateButtons();
end

function ChatBar_Toggle_TextOrientation()
	if (ChatBar_TextOnButtonDisplay) then
		ChatBar_TextOnButtonDisplay = false;
	else
		ChatBar_TextOnButtonDisplay = true;
	end
	ChatBar_UpdateButtonOrientation();
end

function ChatBar_Toggle_ButtonFlashing()
	if (ChatBar_ButtonFlashing) then
		ChatBar_ButtonFlashing = false;
	else
		ChatBar_ButtonFlashing = true;
	end
	ChatBar_UpdateButtonFlashing();
end

function ChatBar_Toggle_BarBorder()
	if (ChatBar_BarBorder) then
		ChatBar_BarBorder = false;
	else
		ChatBar_BarBorder = true;
	end
	ChatBar_UpdateBarBorder();
end

function ChatBar_Toggle_HideSpecialChannels()
	if (ChatBar_HideSpecialChannels) then
		ChatBar_HideSpecialChannels = false;
	else
		ChatBar_HideSpecialChannels = true;
	end
	ChatBar_UpdateButtons();
end

function ChatBar_UpdateButtonText()
	if (ChatBar_ButtonText) then
		for i=1, CHAT_BAR_MAX_BUTTONS do
			local button = getglobal("ChatBarFrameButton"..i);
			button.Text:Show();
		end
	else
		for i=1, CHAT_BAR_MAX_BUTTONS do
			local button = getglobal("ChatBarFrameButton"..i);
			button.Text:Hide();
		end
	end
end

function ChatBar_Toggle_ButtonText()
	if (ChatBar_ButtonText) then
		ChatBar_ButtonText = false;
	else
		ChatBar_ButtonText = true;
	end
	ChatBar_UpdateButtonText();
end

function ChatBar_Toggle_TextChannelNumbers()
	if (ChatBar_TextChannelNumbers) then
		ChatBar_TextChannelNumbers = false;
	else
		ChatBar_TextChannelNumbers = true;
	end
	ChatBar_UpdateButtons();
end

--------------------------------------------------
-- Helper Functions
--------------------------------------------------

function ChatBar_GetTableSize(t)
	local i=0;
	for k,v in t do
		if (k and v) then i=i+1 end;
	end
	return i;
end

function ChatBar_GetFirstWord(s)
	local firstWord, count = gsub(s, "%s.*", "")
	return firstWord;
end


--------------------------------------------------
-- Reorder Channels
--------------------------------------------------

-- Standard Channel Order
STANDARD_CHANNEL_ORDER = {
	[CHATBAR_GENERAL] = 1,
	[CHATBAR_TRADE] = 2,
	[CHATBAR_LOCALDEFENSE] = 3,
	[CHATBAR_LFG] = 4,
	[CHATBAR_WORLDDEFENSE] = 5,
	[CHATBAR_GUILDRECRUITMENT] = 6,
};

BOGUS_CHANNELS = {
	"morneusgbyfyh",
	"akufbhfeuinjke",
	"lkushawdewui",
	"auwdbadwwho",
	"uawhbliuernb",
	"nvcuoiisnejfk",
	"cmewhumimr",
	"cliuchbwubine",
	"omepwucbawy",
	"yuiwbefmopou"
};

CHATBAR_CAPITAL_CITIES = {
	[CHATBAR_ORGRIMMAR] = 1,
	[CHATBAR_STORMWIND] = 1,
	[CHATBAR_IRONFORGE] = 1,
	[CHATBAR_DARNASSUS] = 1,
	[CHATBAR_UNDERCITY] = 1,
	[CHATBAR_THUNDERBLUFF] = 1,
};

--
--	reorderChannels()
--		Stores current channels, Leaves all channels and then rejoins them in a standard ordering.
--		
--
function ChatBar_ReorderChannels()
	if UnitOnTaxi("player") then
		Sea.io.printfc(SELECTED_CHAT_FRAME,  ChatTypeInfo["SYSTEM"], CHATBAR_REORDER_FLIGHT_FAIL);
		-- For some reason channels do not register join/leave in a reasonable amount of time while in transit.
		return;
	end
	
	local newChannelOrder = {};
	local openChannelIndex = 1;
	local currIdentifier, simpleName, inGlobalComm, _;
	
	--Get Channel List
	local list = {GetChannelList()};
	local currChannelList = {};
	for i=1, getn(list), 2 do
		table.insert(currChannelList, tonumber(list[i]), list[i+1]);
	end
	
	-- Find current standard channels: store and leave
	for index, chanName in currChannelList do
		if (type(chanName) == "string") then
			_, _, simpleName = strfind(chanName, "(%w+).*");
			if (STANDARD_CHANNEL_ORDER[simpleName]) then
				if ( simpleName == "GlobalComm" ) then 
					inGlobalComm = true;
				else
					newChannelOrder[STANDARD_CHANNEL_ORDER[simpleName]] = simpleName;
				end
				LeaveChannelByName(chanName);
				currChannelList[index] = nil;
			end
		end
	end
	--Sea.io.printTable(currChannelList);
	-- Find current non-standard channels: store and leave
	for index, chanName in currChannelList do
		if (type(chanName) == "string") then
			while (newChannelOrder[openChannelIndex]) do
				openChannelIndex = openChannelIndex + 1;
			end
			newChannelOrder[openChannelIndex] = chanName;
			LeaveChannelByName(chanName);
			openChannelIndex = openChannelIndex + 1;
		end
	end
	
	if (inGlobalComm) then
		while (newChannelOrder[openChannelIndex]) do
			openChannelIndex = openChannelIndex + 1;
		end
		newChannelOrder[openChannelIndex] = "GlobalComm";
	end
	
	--Sea.io.printTable(newChannelOrder);
	Sea.io.print(CHATBAR_REORDER_START);
	Chronos.schedule(.6, ChatBar_joinChannelsInOrder, newChannelOrder);
	Chronos.schedule(1.2, function() Sea.io.print(CHATBAR_REORDER_END); end );
	Chronos.schedule(2, ListChannels );
end

function ChatBar_joinChannelsInOrder(newChannelOrder)
	
	local inACity = CHATBAR_CAPITAL_CITIES[GetRealZoneText()];
	
	-- Join channels in new order
	for i=1, 10 do
		if (newChannelOrder[i]) then
			if (ChannelManager_CustomChannelPasswords) and (ChannelManager_CustomChannelPasswords[newChannelOrder[i]]) then
				JoinChannelByName(newChannelOrder[i], ChannelManager_CustomChannelPasswords[newChannelOrder[i]]);
			else
				JoinChannelByName(newChannelOrder[i]);
			end
		else
			-- Allow for hidden trade channel (Unfortunetly if you're not in a city and aren't in trade then numbers will be slightly off)
			if (inACity) or (STANDARD_CHANNEL_ORDER[CHATBAR_TRADE] ~= i) then
				JoinChannelByName(BOGUS_CHANNELS[i]);
			end
		end
	end
	Chronos.schedule(.6, ChatBar_leaveExtraChannels, newChannelOrder );
end

function ChatBar_leaveExtraChannels(newChannelOrder)
	
	for i, bogusName in BOGUS_CHANNELS do
		local channelNum, channelName = GetChannelName(bogusName);
		if (channelName) then
			LeaveChannelByName(channelNum);
		end
	end

end

