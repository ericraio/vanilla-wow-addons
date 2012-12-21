-- Allows the mail frame to be pushed
if ( UIPanelWindows["MailFrame"] ) then
	UIPanelWindows["MailFrame"].pushable = 1;
else
	UIPanelWindows["MailFrame"] = { area = "left", pushable = 1 };
end
-- This makes sure the FriendsFrame will close if you try to open a mail with mailframe+friendsframe open
if ( UIPanelWindows["FriendsFrame"] ) then
	UIPanelWindows["FriendsFrame"].pushable = 2;
else
	UIPanelWindows["FriendsFrame"] = { area = "left", pushable = 2 };
end
CT_MAIL_NUMITEMBUTTONS = 21;

-- Hook the ContainerFrameItemButton_OnClick function
local CT_MM_oldCFIB_OC = ContainerFrameItemButton_OnClick;

function CT_MM_ContainerFrameItemButton_OnClick(btn, ignore)
	if ( CT_Mail_GetItemFrame(this:GetParent():GetID(), this:GetID()) ) then
		return;
	end

	CT_MM_oldCFIB_OC(btn, ignore);

	CT_Mail_UpdateItemButtons();
end

ContainerFrameItemButton_OnClick = CT_MM_ContainerFrameItemButton_OnClick;

CT_oldPickupContainerItem = PickupContainerItem;

function CT_newPickupContainerItem(bag, item, special)
	if ( ( CT_Mail_GetItemFrame(bag, item) or ( CT_Mail_addItem and CT_Mail_addItem[1] == bag and CT_Mail_addItem[2] == item ) ) and not special ) then
		return;
	end
	if ( not CursorHasItem() ) then
		CT_MailFrame.bag = bag;
		CT_MailFrame.item = item;
	end
	if ( IsAltKeyDown() and CT_MailFrame:IsVisible() and not CursorHasItem() ) then
		local i;
		for i = 1, CT_MAIL_NUMITEMBUTTONS, 1 do
			if ( not getglobal("CT_MailButton" .. i).item ) then

				local canMail = CT_Mail_ItemIsMailable(bag, item);
				if ( canMail ) then
					DEFAULT_CHAT_FRAME:AddMessage("<CTMod> Cannot attach item, item is " .. canMail, 1, 0.5, 0);
					return;
				end

				CT_oldPickupContainerItem(bag, item);
				CT_MailButton_OnClick(getglobal("CT_MailButton" .. i));
				CT_Mail_UpdateItemButtons();
				return;
			end
		end
	elseif ( IsAltKeyDown() and SendMailFrame:IsVisible() and not CursorHasItem() ) then
		CT_oldPickupContainerItem(bag, item);
		ClickSendMailItemButton();
		return;
	elseif ( IsAltKeyDown() and TradeFrame:IsVisible() and not CursorHasItem() ) then
		for i = 1, 6, 1 do
			if ( not GetTradePlayerItemLink(i) ) then
				CT_oldPickupContainerItem(bag, item);
				ClickTradeButton(i);
				return;
			end
		end
	elseif ( IsAltKeyDown() and not CursorHasItem() and ( not TradeFrame or not TradeFrame:IsVisible() ) and ( not AuctionFrame or not AuctionFrame:IsVisible() ) and UnitExists("target") and CheckInteractDistance("target", 2) and UnitIsFriend("player", "target") and UnitIsPlayer("target") ) then
		InitiateTrade("target");
		CT_Mail_addItem = { bag, item, UnitName("target"), 2 };
		for i = 1, NUM_CONTAINER_FRAMES, 1 do
			if ( getglobal("ContainerFrame" .. i):IsVisible() ) then
				ContainerFrame_Update(getglobal("ContainerFrame" .. i));
			end
		end
		return;
	end
	CT_oldPickupContainerItem(bag, item);
	CT_Mail_UpdateItemButtons();
end

PickupContainerItem = CT_newPickupContainerItem;

-- Hook the MailFrameTab_OnClick function
local CT_MM_oldMFT_OC = MailFrameTab_OnClick;
function CT_MM_MailFrameTab_OnClick(tab)
	if ( not tab ) then 
		tab = this:GetID();
	end

	if ( tab == 3 ) then
		PanelTemplates_SetTab(MailFrame, 3);
		InboxFrame:Hide();
		SendMailFrame:Hide();
		CT_MailFrame:Show();
		SendMailFrame.sendMode = "massmail";
		MailFrameTopLeft:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-TopLeft");
		MailFrameTopRight:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-TopRight");
		MailFrameBotLeft:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-BotLeft");
		MailFrameBotRight:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-BotRight");
		MailFrameTopLeft:SetPoint("TOPLEFT", "MailFrame", "TOPLEFT", 2, -1);
		return;
	else
		CT_MailFrame:Hide();
	end
	CT_MM_oldMFT_OC(tab);
end

MailFrameTab_OnClick = CT_MM_MailFrameTab_OnClick;

-- Hook the ClickSendMailItemButton function
local CT_MM_oldCSMIB = ClickSendMailItemButton;
function CT_MM_newCSMIB()
	if ( not GetSendMailItem() ) then
		CT_MailFrame.mailbag = CT_MailFrame.bag;
		CT_MailFrame.mailitem = CT_MailFrame.item;
	end
	CT_MM_oldCSMIB();
end

ClickSendMailItemButton = CT_MM_newCSMIB;

-- Handle the dragging of items

function CT_MailButton_OnClick(button)

	if ( not button ) then button = this; end
	if ( CursorHasItem() ) then

		local bag = CT_MailFrame.bag;
		local item = CT_MailFrame.item;

		if ( not bag or not item ) then return; end
		
		local canMail = CT_Mail_ItemIsMailable(bag, item)
		if ( canMail ) then
			DEFAULT_CHAT_FRAME:AddMessage("<CTMod> Cannot attach item, item is " .. canMail, 1, 0.5, 0);
			CT_oldPickupContainerItem(bag, item);
			return;
		end

		CT_oldPickupContainerItem(bag, item);

		if ( this.bag and this.item ) then
			-- There's already an item there
			-- Pickup that item to replicate Send Mail's behaviour
			CT_oldPickupContainerItem(button.bag, button.item);
			CT_MailFrame.bag = button.bag;
			CT_MailFrame.item = button.item;
		else
			CT_MailFrame.bag = nil;
			CT_MailFrame.item = nil;
		end

		local texture, count = GetContainerItemInfo(bag, item);

		getglobal(button:GetName() .. "IconTexture"):Show();
		getglobal(button:GetName() .. "IconTexture"):SetTexture(texture);

		if ( count > 1 ) then
			getglobal(button:GetName() .. "Count"):SetText(count);
			getglobal(button:GetName() .. "Count"):Show();
		else
			getglobal(button:GetName() .. "Count"):Hide();
		end

		button.bag = bag;
		button.item = item;
		button.texture = texture;
		button.count = count;

	elseif ( button.item and button.bag ) then

		CT_oldPickupContainerItem(button.bag, button.item);
		getglobal(button:GetName() .. "IconTexture"):Hide();
		getglobal(button:GetName() .. "Count"):Hide();

		CT_MailFrame.bag = button.bag;
		CT_MailFrame.item = button.item;

		button.item = nil;
		button.bag = nil;
		button.count = nil;
		button.texture = nil;

	end
	local num = CT_Mail_GetNumMails();
	CT_MailFrame.num = num;
	CT_Mail_CanSend(CT_MailNameEditBox);
	if ( num == 0 ) then num = 1; end
	MoneyFrame_Update("CT_MailCostMoneyFrame", GetSendMailPrice()*num);
	for i = 1, NUM_CONTAINER_FRAMES, 1 do
		if ( getglobal("ContainerFrame" .. i):IsVisible() ) then
			ContainerFrame_Update(getglobal("ContainerFrame" .. i));
		end
	end
end

function CT_Mail_ItemIsMailable(bag, item)

	-- Make sure tooltip is cleared
	for i = 1, 29, 1 do
		getglobal("CT_MMTooltipTextLeft" .. i):SetText("");
	end

	CT_MMTooltip:SetBagItem(bag, item);
	for i = 1, CT_MMTooltip:NumLines(), 1 do
		local text = getglobal("CT_MMTooltipTextLeft" .. i):GetText();
		if ( text == ITEM_SOULBOUND ) then
			return "soulbound.";
		elseif ( text == ITEM_BIND_QUEST ) then
			return "a quest item.";
		elseif ( text == ITEM_CONJURED ) then
			return "a conjured item.";
		end
	end
	return nil;
end


function CT_Mail_UpdateItemButtons(frame)
	local i;
	for i = 1, CT_MAIL_NUMITEMBUTTONS, 1 do
		local btn = getglobal("CT_MailButton" .. i);
		if ( not frame or btn ~= frame ) then
			local texture, count;
			if ( btn.item and btn.bag ) then
				texture, count = GetContainerItemInfo(btn.bag, btn.item);
			end
			if ( not texture ) then
				getglobal(btn:GetName() .. "IconTexture"):Hide();
				getglobal(btn:GetName() .. "Count"):Hide();
				btn.item = nil; btn.bag = nil; btn.count = nil; btn.texture = nil;
			else
				btn.count = count;
				btn.texture = texture;
				getglobal(btn:GetName() .. "IconTexture"):Show();
				getglobal(btn:GetName() .. "IconTexture"):SetTexture(texture);
				if ( count > 1 ) then
					getglobal(btn:GetName() .. "Count"):Show();
					getglobal(btn:GetName() .. "Count"):SetText(count);
				else
					getglobal(btn:GetName() .. "Count"):Hide();
				end
			end
		end
	end
end

function CT_Mail_GetItemFrame(bag, item)
	local i;
	for i = 1, CT_MAIL_NUMITEMBUTTONS, 1 do
		local btn = getglobal("CT_MailButton" .. i);
		if ( btn.item == item and btn.bag == bag ) then
			return btn;
		end
	end
	return nil;
end

function CT_Mail_GetNumMails()
	local i;
	local num = 0;
	for i = 1, CT_MAIL_NUMITEMBUTTONS, 1 do
		local btn = getglobal("CT_MailButton" .. i);
		if ( btn.item and btn.bag ) then
			num = num + 1;
		end
	end
	return num;
end

function CT_Mail_ClearItems()
	local i;
	local num = 0;
	for i = 1, CT_MAIL_NUMITEMBUTTONS, 1 do
		local btn = getglobal("CT_MailButton" .. i);
		btn.item = nil;
		btn.count = nil;
		btn.bag = nil;
		btn.texture = nil;
	end
	CT_Mail_UpdateItemButtons();
	CT_MailMailButton:Disable();
	CT_MailNameEditBox:SetText("");
	CT_MailSubjectEditBox:SetText("");
	CT_MailStatusText:SetText("");
	CT_MailAbortButton:Hide();

	CT_Mail_AcceptSendFrame:Hide();
end

function CT_Mail_AutoComplete()
	local text = this:GetText();
	local textlen = strlen(text);
	local numFriends = GetNumFriends();
	local name;
	if ( numFriends > 0 ) then
		for i=1, numFriends do
			name = 	GetFriendInfo(i);
			if ( name ) then
				if ( strfind(strupper(name), "^"..strupper(text)) ) then
					this:SetText(name);
					this:HighlightText(textlen, -1);
					return;
				end
			end
		end
	end

	-- Hack to scan offline members
	local oldOffline = GetGuildRosterShowOffline();
	SetGuildRosterShowOffline(true);

	local numGuildMembers = GetNumGuildMembers();
	if ( numGuildMembers > 0 ) then
		for i=1, numGuildMembers do
			name = GetGuildRosterInfo(i);
			if ( strfind(strupper(name), "^"..strupper(text)) ) then
				this:SetText(name);
				this:HighlightText(textlen, -1);
				return;
			end
		end
	end

	-- Revert to old scanning
	SetGuildRosterShowOffline(oldOffline);
end

SendMailFrame_SendeeAutocomplete = CT_Mail_AutoComplete; -- No need for a before/after hook, since our function does both friends & guildies

function CT_Mail_CanSend(eb)
	if ( not eb ) then eb = this; end
	if ( strlen(eb:GetText()) > 0 and CT_MailFrame.num > 0 and GetSendMailPrice()*CT_MailFrame.num <= GetMoney() ) then
		CT_MailMailButton:Enable();
	else
		CT_MailMailButton:Disable();
	end
end

function CT_Mail_SendMail()
	for key, val in this.queue do
		CT_MailStatusText:SetText(format(CT_MAIL_SENDING, key, this.total));
		CT_MailAbortButton:Show();

		if ( GetSendMailItem() and CT_MailFrame.mailbag and CT_MailFrame.mailitem ) then
			-- There's already an item in the slot
			ClickSendMailItemButton();
			CT_oldPickupContainerItem(CT_MailFrame.mailbag, CT_MailFrame.mailitem);
			CT_MailFrame.mailbag = nil;
			CT_MailFrame.mailitem = nil;
		elseif ( CursorHasItem() and CT_MailFrame.bag and CT_MailFrame.item ) then
			PickupContainerItem(CT_MailFrame.bag, CT_MailFrame.item);
			CT_MailFrame.bag = nil;
			CT_MailFrame.item = nil;
		end

		CT_oldPickupContainerItem(val.bag, val.item);

		ClickSendMailItemButton();

		local name, useless, count = GetSendMailItem();

		if ( not name ) then 
			DEFAULT_CHAT_FRAME:AddMessage("<CTMod> " .. CT_MAIL_ERROR, 1, 0, 0);
		else

			local subjectstr = CT_MailSubjectEditBox:GetText();
			if ( strlen(subjectstr) > 0 ) then
				subjectstr = subjectstr .. " ";
			end

			if ( count > 1 ) then
				subjectstr = subjectstr .. "[" .. name .. " x" .. count .. "]";
			else
				subjectstr = subjectstr .. "[" .. name .. "]";
			end

			SendMail(val.to, subjectstr, format(CT_MAIL_ITEMNUM, key, this.total));
		end

		CT_MailGlobalFrame.queue[key] = nil;
		return;
	end
	CT_MailStatusText:SetText(format(CT_MAIL_DONESENDING, this.total));
	CT_MailAbortButton:Hide();
	CT_MailGlobalFrame:Hide();

	CT_MailGlobalFrame.total = 0;
	CT_MailGlobalFrame.queue = { };
end

function CT_Mail_FillItemTable()
	local arr = { };
	for i = 1, CT_MAIL_NUMITEMBUTTONS, 1 do
		local btn = getglobal("CT_MailButton" .. i);
		if ( btn.item and btn.bag ) then
			tinsert(arr, { ["item"] = btn.item, ["bag"] = btn.bag, ["to"] = CT_MailNameEditBox:GetText() });
		end
	end
	return arr;
end

function CT_Mail_ProcessQueue(elapsed)
	if ( not CT_Mail_CanSendNext ) then
		return;
	end
	this.sendmail = this.sendmail + elapsed;
	if ( this.sendmail > 0.5 ) then
		this.sendmail = 0;
		if ( this.total > 0 ) then
			CT_Mail_SendMail();
			CT_Mail_CanSendNext = nil;
		end
	end
end

local CT_oldMM_CF_U = ContainerFrame_Update

function CT_Mail_ContainerFrame_Update(frame)
	CT_oldMM_CF_U(frame);

	local id = frame:GetID();
	if ( CT_MailFrame:IsVisible() ) then
		local i;
		for i = 1, CT_MAIL_NUMITEMBUTTONS, 1 do
			local btn = getglobal("CT_MailButton" .. i);
			if ( btn.item and btn.bag ) then
				if ( btn.bag == frame:GetID() ) then
					SetItemButtonDesaturated(getglobal(frame:GetName() .. "Item" .. (frame.size-btn.item)+1), 1, 0.5, 0.5, 0.5);
				end
			end
		end
	end
	
	if ( CT_Mail_addItem and CT_Mail_addItem[1] == frame:GetID() ) then
		SetItemButtonDesaturated(getglobal(frame:GetName() .. "Item" .. (frame.size-CT_Mail_addItem[2])+1), 1, 0.5, 0.5, 0.5);
	end

end

ContainerFrame_Update = CT_Mail_ContainerFrame_Update;

function CT_Mail_AddSubject()
	if ( not SendMailFrame:IsVisible() ) then return; end
	local name, useless, count = GetSendMailItem();

	if ( name and strlen(SendMailSubjectEditBox:GetText()) == 0 ) then
		if ( count > 1 ) then
			name = name .. " x" .. count;
		end
		SendMailSubjectEditBox:SetText(name);
	end
end

function CT_Mail_OnEvent(event)
	if ( event == "MAIL_SEND_SUCCESS" ) then
		CT_Mail_CanSendNext = 1;
	else
		CT_Mail_AddSubject();
	end
end

-- Show item link if there is one
CT_Mail_oldInboxFrameItem_OnEnter = InboxFrameItem_OnEnter;
function CT_Mail_newInboxFrameItem_OnEnter()
	local didSetTooltip;
	if ( this.index ) then
		if ( GetInboxItem(this.index) ) then
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
			GameTooltip:SetInboxItem(this.index);
			didSetTooltip = 1;
		end
	end
	if ( not didSetTooltip ) then
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	end
	if (this.money) then
		GameTooltip:AddLine(ENCLOSED_MONEY, "", 1, 1, 1);
		SetTooltipMoney(GameTooltip, this.money);
		SetMoneyFrameColor("GameTooltipMoneyFrame", HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	elseif (this.cod) then
		GameTooltip:AddLine(COD_AMOUNT, "", 1, 1, 1);
		SetTooltipMoney(GameTooltip, this.cod);
		if ( this.cod > GetMoney() ) then
			SetMoneyFrameColor("GameTooltipMoneyFrame", RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
		else
			SetMoneyFrameColor("GameTooltipMoneyFrame", HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		end
	end
	if ( didSetTooltip and ( this.money or this.cod ) ) then
		GameTooltip:SetHeight(GameTooltip:GetHeight()+getglobal("GameTooltipTextLeft" .. GameTooltip:NumLines()):GetHeight());
		if ( GameTooltipMoneyFrame:IsVisible() ) then
			GameTooltip:SetHeight(GameTooltip:GetHeight()+GameTooltipMoneyFrame:GetHeight());
		end
	end
	GameTooltip:Show();
end
InboxFrameItem_OnEnter = CT_Mail_newInboxFrameItem_OnEnter;

-- Hook the TradeFrame OnShow
CT_Mail_oldTradeFrameShow = TradeFrame:GetScript("OnShow");
function CT_Mail_newTradeFrameShow()
	CT_Mail_oldTradeFrameShow();
	if ( CT_Mail_addItem and not CursorHasItem() and UnitName("NPC") == CT_Mail_addItem[3] ) then
		CT_oldPickupContainerItem(CT_Mail_addItem[1], CT_Mail_addItem[2]);
		ClickTradeButton(1);
	end
	CT_Mail_addItem = nil;
end
TradeFrame:SetScript("OnShow", CT_Mail_newTradeFrameShow);

-- Add slash command for stacking
SlashCmdList["MAILSTACK"] = function()
	CT_MMInbox_StackMail = not CT_MMInbox_StackMail;
	if ( CT_MMInbox_StackMail ) then
		CT_MMInbox_Print("<CTMod> Mail Stacking is now turned |cFF00FF00on|r.", 1, 1, 0);
	else
		CT_MMInbox_Print("<CTMod> Mail Stacking is now turned |cFFFF0000off|r.", 1, 1, 0);
	end
end
SLASH_MAILSTACK1 = "/mailstack";
SLASH_MAILSTACK2 = "/ms";