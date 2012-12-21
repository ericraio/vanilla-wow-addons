tinsert(UISpecialFrames, "CT_MMInbox_OpenAll");
CT_MMINBOX_DELETEDELAY = 1;
CT_MMINBOX_DELETEEVENTDELAY = 1;

CT_MMInbox_SelectedItems = { };
function CT_MMInbox_OnLoad()
	MailItem1:SetPoint("TOPLEFT", "InboxFrame", "TOPLEFT", 48, -80);
	for i = 1, 7, 1 do
		getglobal("MailItem" .. i .. "ExpireTime"):SetPoint("TOPRIGHT", "MailItem" .. i, "TOPRIGHT", 10, -4);
		getglobal("MailItem" .. i):SetWidth(280);
	end
	this.eventFunc = { };
	this:RegisterEvent("MAIL_INBOX_UPDATE");
	this:RegisterEvent("UI_ERROR_MESSAGE");
	this:RegisterEvent("VARIABLES_LOADED");
end

function CT_MMInbox_OnUpdate(elapsed)
	if ( CT_Mail_addItem ) then
		CT_Mail_addItem[4] = CT_Mail_addItem[4] - elapsed;
		if ( CT_Mail_addItem[4] <= 0 ) then
			CT_Mail_addItem = nil;
			for i = 1, NUM_CONTAINER_FRAMES, 1 do
				if ( getglobal("ContainerFrame" .. i):IsVisible() ) then
					ContainerFrame_Update(getglobal("ContainerFrame" .. i));
				end
			end
		end
	end
	if ( this.num and this.elapsed ) then
		this.elapsed = this.elapsed - elapsed;
		if ( this.elapsed <= 0 ) then
			this.elapsed = nil;
			if ( this.id[1] ) then
				local val = this.id[1];
				local success = CT_MMInbox_PickMail(val, this.openSelected);
				if ( success ~= 2 ) then
					tremove(this.id, 1);
					this.num = this.num - 1;
				end
				if ( success == 1 ) then
					for key, va in this.id do
						if ( va > val ) then
							this.id[key] = va-1;
						end
					end
					this.lastVal = val;
					InboxFrame_Update();
				else
					this.elapsed = 1+CT_MMINBOX_DELETEDELAY;
					this.lastVal = nil;
				end
				if ( this.num == 0 ) then
					this.num = nil;
					CT_MMInbox_DisableClicks(nil);
				end
			end
		end
	end
	if ( this.delete ) then
		this.delete[1] = this.delete[1] - elapsed;
		if ( this.delete[1] <= 0 ) then
			local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, itemID, wasRead, wasReturned, textCreated  = GetInboxHeaderInfo(this.delete[2]);
			if ( money == 0 and not itemID ) then
				GetInboxText(this.delete[2]);
				DeleteInboxItem(this.delete[2]);
			end
			this.delete = nil;
			this.elapsed = 0.5+CT_MMINBOX_DELETEDELAY;
		end
	end
end

function CT_MMInbox_OnEvent(event)
	if ( event == "MAIL_INBOX_UPDATE" ) then
		if ( this.eventDelete ) then
			this.delete = { CT_MMINBOX_DELETEEVENTDELAY, this.eventDelete };
			this.eventDelete = nil;
		end
	elseif ( event == "UI_ERROR_MESSAGE" and ( arg1 == ERR_INV_FULL or arg1 == ERR_ITEM_MAX_COUNT ) ) then
		if ( this.num ) then
			if ( arg1 == ERR_INV_FULL ) then
				CT_MMInbox_Abort();
				if ( CT_MMInbox_DisplayMessages ) then
					CT_MMInbox_Print("<CTMod> Error: Inventory full. Aborting.", 1, 0, 0);
				end
			elseif ( arg1 == ERR_ITEM_MAX_COUNT ) then
				if ( CT_MMInbox_DisplayMessages ) then
					CT_MMInbox_Print("<CTMod> Error: You already have the maximum amount of that item. Skipping.", 1, 0, 0);
				end
				this.elapsed = CT_MMINBOX_DELETEDELAY;
				if ( this.lastVal ) then
					for key, va in this.id do
						if ( va >= this.lastVal ) then
							this.id[key] = va+1;
						end
					end
				end
			end
		end
	elseif ( event == "VARIABLES_LOADED" ) then
		CT_MMInboxDisplayMessagesCB:SetChecked(CT_MMInbox_DisplayMessages);
	end
end

function CT_MMInbox_PickMail(id, openSelected)
	if ( not id ) then
		return 0;
	end
	local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, hasItem, wasRead, wasReturned, textCreated, canReply = GetInboxHeaderInfo(id);
	if ( CODAmount > 0 ) then
		if ( CT_MMInbox_DisplayMessages ) then
			CT_MMInbox_Print("<CTMod> Mail |c00FFFFFF" .. this.numMails-(this.num-1) .. "|r/|c00FFFFFF" .. this.numMails .. "|r is Cash on Delivery, skipping.", 1, 0, 0);
		end
		return 0;
	elseif ( not hasItem and money == 0 and not openSelected ) then
		if ( CT_MMInbox_DisplayMessages ) then
			CT_MMInbox_Print("<CTMod> Mail |c00FFFFFF" .. this.numMails-(this.num-1) .. "|r/|c00FFFFFF" .. this.numMails .. "|r has no money or items, skipping.", 1, 1, 0);
		end
		return 0;
	end
	if ( CT_MMInbox_DisplayMessages ) then
		CT_MMInbox_Print("<CTMod> Opening mail |c00FFFFFF" .. this.numMails-(this.num-1) .. "|r/|c00FFFFFF" .. this.numMails .. "|r: \"|c00FFFFFF" .. ( subject or "<No Subject>" ) .. "|r\" from |c00FFFFFF" .. ( sender or "<Unknown Sender>" ) .. "|r.", 1, 1, 0);
	end
	local eventDelete;
	if ( hasItem ) then
		TakeInboxItem(id);
		eventDelete = 1;
		if ( money > 0 ) then
			return 2;
		end
	end
	if ( money > 0 ) then
		TakeInboxMoney(id);
		eventDelete = 1;
	end
	if ( eventDelete ) then
		CT_MMInboxFrame.eventDelete = id;
	else
		CT_MMInboxFrame.delete = { CT_MMINBOX_DELETEDELAY, id };
	end
	return 1;
end

function CT_MMInbox_SetSelected()
	local id = this:GetID() + (InboxFrame.pageNum-1)*7;
	if ( not this:GetChecked() ) then
		for k, v in CT_MMInbox_SelectedItems do
			if ( v == id ) then
				tremove(CT_MMInbox_SelectedItems, k);
				break;
			end
		end
	else
		tinsert(CT_MMInbox_SelectedItems, id);
	end
end

function CT_MMInbox_OpenSelected(openAll)
	CT_MMInbox_DisableClicks(1);
	CT_MMInboxFrame.num = 0;
	CT_MMInboxFrame.elapsed = CT_MMINBOX_DELETEDELAY;
	CT_MMInboxFrame.id = { };
	CT_MMInboxFrame.openSelected = not openAll;
	if ( openAll ) then
		for i = 1, GetInboxNumItems(), 1 do
			CT_MMInboxFrame.num = CT_MMInboxFrame.num + 1;
			tinsert(CT_MMInboxFrame.id, i);
		end
	else
		for k, v in CT_MMInbox_SelectedItems do
			CT_MMInboxFrame.num = CT_MMInboxFrame.num + 1;
			tinsert(CT_MMInboxFrame.id, v);
		end
	end
	CT_MMInboxFrame.numMails = CT_MMInboxFrame.num;
	CT_MMInbox_SelectedItems = { };
end

-- Hook InboxFrame_Update
CT_MMInbox_oldInboxFrame_Update = InboxFrame_Update;
function CT_MMInbox_newInboxFrame_Update()
	CT_MMInbox_oldInboxFrame_Update();
	for i = 1, 7, 1 do
		local index = (i + (InboxFrame.pageNum-1)*7);
		if ( index > GetInboxNumItems() ) then
			getglobal("CT_MailBoxItem" .. i .. "CB"):Hide();
		else
			getglobal("CT_MailBoxItem" .. i .. "CB"):Show();
			getglobal("CT_MailBoxItem" .. i .. "CB"):SetChecked(nil);
			for k, v in CT_MMInbox_SelectedItems do
				if ( v == index ) then
					getglobal("CT_MailBoxItem" .. i .. "CB"):SetChecked(1);
					break;
				end
			end
		end
	end
	if ( CT_MMInboxFrame.num ) then
		CT_MMInbox_DisableClicks(1, 1);
	end
end
InboxFrame_Update = CT_MMInbox_newInboxFrame_Update;
CT_MMInbox_oldInboxFrame_OnClick = InboxFrame_OnClick;
function CT_MMInbox_DisableClicks(disable, loopPrevention)
	if ( disable ) then
		for i = 1, 7, 1 do
			getglobal("MailItem" .. i .. "ButtonIcon"):SetDesaturated(1);
		end
		InboxFrame_OnClick = function() this:SetChecked(nil) end;
	else
		for i = 1, 7, 1 do
			getglobal("MailItem" .. i .. "ButtonIcon"):SetDesaturated(nil);
		end
		if ( not loopPrevention ) then
			InboxFrame_Update();
		end
		InboxFrame_OnClick = CT_MMInbox_oldInboxFrame_OnClick;
	end
end

function CT_MMInbox_Abort()
	CT_MMInboxFrame.num = nil;
	CT_MMInboxFrame.elapsed = nil;
	CT_MMInboxFrame.id = { };
	CT_MMInbox_SelectedItems = { };
	CT_MMInbox_DisableClicks();
	HideUIPanel(CT_MMInbox_OpenAll);
end

function CT_MMInbox_Print(msg, r, g, b)
	DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b);
end

CT_MMInbox_oldCloseMail = CloseMail;
function CT_MMInbox_newCloseMail()
	CT_MMInbox_oldCloseMail();
	CT_MMInbox_Abort();
end
CloseMail = CT_MMInbox_newCloseMail;

CT_MMInbox_oldTakeInboxItem = TakeInboxItem;
function CT_MMInbox_newTakeInboxItem(id)
	CT_MMInbox_oldTakeInboxItem(id);
	local name, itemTexture, count, quality, canUse = GetInboxItem(id);
	tinsert(CT_MMForwardFrame.pickItem, name);
end
TakeInboxItem = CT_MMInbox_newTakeInboxItem;

-- Mail Forwarding
CT_MMForward_BagLinks = { };
function CT_MMForward_DisableAttachments(disable)
	if ( not CT_MMForward_oldTakeInboxMoney ) then
		CT_MMForward_oldTakeInboxMoney = OpenMailMoneyButton:GetScript("OnClick");
		CT_MMForward_oldTakeInboxItem = OpenMailPackageButton:GetScript("OnClick");
	end
	if ( disable ) then
		OpenMailMoneyButtonIconTexture:SetDesaturated(1);
		OpenMailPackageButtonIconTexture:SetDesaturated(1);
		OpenMailMoneyButton:SetScript("OnClick", function() end);
		OpenMailPackageButton:SetScript("OnClick", function() end);
	else
		OpenMailMoneyButtonIconTexture:SetDesaturated(nil);
		OpenMailPackageButtonIconTexture:SetDesaturated(nil);
		OpenMailMoneyButton:SetScript("OnClick", CT_MMForward_oldTakeInboxMoney);
		OpenMailPackageButton:SetScript("OnClick", CT_MMForward_oldTakeInboxItem);
	end
end

CT_MMForward_oldOpenMail_Reply = OpenMail_Reply;
function CT_MMForward_newOpenMail_Reply()
	CT_MMForward_oldOpenMail_Reply();
	SendMailMoneyCopper:SetText("");
	SendMailMoneySilver:SetText("");
	SendMailMoneyGold:SetText("");
end
OpenMail_Reply = CT_MMForward_newOpenMail_Reply;


CT_MMInbox_oldSendMailPackageButton_OnEnter = SendMailPackageButton:GetScript("OnEnter");
function CT_MMForward_OpenReply()
	OpenMail_Reply();
	local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, hasItem, wasRead, wasReturned, textCreated, canReply = GetInboxHeaderInfo(InboxFrame.openMailID);
	
	-- Money
	local gold, silver, copper = "", "", "";
	if ( money and money > 0 ) then
		gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD));
		silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
		copper = mod(money, COPPER_PER_SILVER);
	end
	SendMailMoneyCopper:SetText(copper);
	SendMailMoneySilver:SetText(silver);
	SendMailMoneyGold:SetText(gold);
	
	-- Items
	local name, itemTexture, count, quality, canUse = GetInboxItem(InboxFrame.openMailID);
	SendMailPackageButton:SetNormalTexture(itemTexture);
	if ( count > 1 ) then
		SendMailPackageButtonCount:SetText(count);
	else
		SendMailPackageButtonCount:SetText("");
	end
	
	-- Text fields
	SendMailNameEditBox:SetText("")
	local subject = OpenMailSubject:GetText();
	local prefix = "FW:".." ";
	if ( strsub(subject, 1, strlen(prefix)) ~= prefix ) then
		subject = prefix..subject;
	end
	SendMailSubjectEditBox:SetText(subject or "")
	SendMailBodyEditBox:SetText(string.gsub(OpenMailBodyText:GetText() or "", "\n", "\n>"));
	SendMailNameEditBox:SetFocus();

	-- Set the send mode so the work flow can change accordingly
	SendMailFrame.sendMode = "reply";
	
	CT_MMForward_EnableForward(1);
end

CT_MMForward_oldSendMailMailButton_OnClick = SendMailMailButton_OnClick;
CT_MMForward_oldSendMailPackageButton_OnClick = SendMailPackageButton_OnClick;
function CT_MMForward_newSendMailMailButton_OnClick()
	local name, itemTexture, count, quality, canUse = GetInboxItem(InboxFrame.openMailID);
	local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, hasItem, wasRead, wasReturned, textCreated, canReply = GetInboxHeaderInfo(InboxFrame.openMailID);
	if ( name ) then
		CT_MMForwardFrame.searchItem = name;
		CT_MMForwardFrame.forwardStep = 1;
		CT_MMForward_oldTakeInboxItem(InboxFrame.openMailID);
	else
		CT_MMForwardFrame.forwardStep = 2;
		if ( money and money > 0 ) then
			SetSendMailMoney(money);
			CT_MMForwardFrame.countDown = 2;
			CT_MMForward_oldTakeInboxMoney(InboxFrame.openMailID);
		else
			CT_MMForwardFrame.countDown = 0.5;
		end
	end
	SendMailMailButton:Disable();
end

function CT_MMForward_OnUpdate(elapsed)
	if ( this.forwardStep and this.forwardStep > 1 ) then
		if ( this.countDown ) then
			this.countDown = this.countDown - elapsed;
			if ( this.countDown <= 0 ) then
				if ( this.forwardStep == 2 ) then
					this.countDown = 0.5;
					this.forwardStep = 3;
					-- Send the mail
					SendMail(SendMailNameEditBox:GetText(), SendMailSubjectEditBox:GetText(), SendMailBodyEditBox:GetText());
					SendMailMailButton:Disable();
				elseif ( this.forwardStep == 3 ) then
					-- Delete the old one
					local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, itemID, wasRead, wasReturned, textCreated  = GetInboxHeaderInfo(InboxFrame.openMailID);
					if ( money == 0 and not itemID ) then
						DeleteInboxItem(InboxFrame.openMailID);
					end
					MailFrameTab_OnClick(1);
					HideUIPanel(OpenMailFrame);
					this.countDown = nil;
					this.forwardStep = nil;
				end
			end
		end
	end
	this.process = this.process - elapsed;
	if ( this.process <= 0 ) then
		this.process = 3;
		if ( getn(CT_MMForward_ScheduledStack) > 0 ) then
			CT_MMForward_ProcessStack();
		end
	end
end

CT_MMForward_oldInboxFrame_OnClick = InboxFrame_OnClick;
function CT_MMForward_newInboxFrame_OnClick(id)
	CT_MMForward_oldInboxFrame_OnClick(id);
	local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, itemID, wasRead, wasReturned, textCreated  = GetInboxHeaderInfo(id);
	if ( CODAmount and CODAmount > 0 ) then
		OpenMailForwardButton:Disable();
	else
		OpenMailForwardButton:Enable();
	end
end
InboxFrame_OnClick = CT_MMForward_newInboxFrame_OnClick;

function CT_MMForward_EnableForward(enable)
	if ( enable ) then
		OpenMailForwardButton:Disable();
		SendMailPackageButton:SetScript("OnEnter", function() GameTooltip:SetOwner(SendMailPackageButton, "ANCHOR_RIGHT") GameTooltip:SetInboxItem(InboxFrame.openMailID) end);
		SendMailCODButton:Disable();
		CT_MMForward_DisableAttachments(1);
		SendMailMailButton_OnClick = CT_MMForward_newSendMailMailButton_OnClick;
		SendMailPackageButton_OnClick = function() end;
	else
		OpenMailForwardButton:Enable();
		SendMailPackageButton:SetScript("OnEnter", CT_MMInbox_oldSendMailPackageButton_OnEnter);
		SendMailCODButton:Enable();
		CT_MMForward_DisableAttachments(nil);
		SendMailPackageButton_OnClick = CT_MMForward_oldSendMailPackageButton_OnClick;
		SendMailMailButton_OnClick = CT_MMForward_oldSendMailMailButton_OnClick;
	end
end

function CT_MMForward_AttachSlot(container, item)
	PickupContainerItem(container, item);
	ClickSendMailItemButton();
	CT_MMForwardFrame.searchItem = nil;
	CT_MMForwardFrame.forwardStep = 2;
	CT_MMForwardFrame.countDown = 1.5;
end

function CT_MMForward_ScanItems()
	local old = { };
	for k, v in CT_MMForward_BagLinks do
		if ( type(v) == "table" ) then
			old[k] = { };
			for key, val in v do
				old[k][key] = val;
			end
		end
	end
	CT_MMForward_BagLinks = { };
	for i = 0, 4, 1 do
		CT_MMForward_BagLinks[i] = { };
		for y = 1, GetContainerNumSlots(i), 1 do
			local curr = GetContainerItemLink(i, y);
			local _, _, name = string.find(( curr or "" ), "%[(.+)%]");
			if ( name ) then
				if ( CT_MMForwardFrame.searchItem ) then
					if ( name and name == CT_MMForwardFrame.searchItem and not old[i][y] ) then
						CT_MMForward_AttachSlot(i, y);
					end
				elseif ( CT_MMInbox_StackMail ) then
					local _, _, name = string.find(( curr or "" ), "%[(.+)%]");
					if ( name and name == CT_MMForwardFrame.pickItem[1] and not old[i][y] ) then
						tremove(CT_MMForwardFrame.pickItem, 1);
						for k, v in old do
							local hasFound;
							for key, val in v do
								if ( val == name and ( k ~= i or key ~= y ) ) then
									local _,_, link = string.find((GetContainerItemLink(k, key) or ""), "(item:[%d:]+)")
									if ( link ) then
										local texture, itemCount = GetContainerItemInfo(k,key);
										local tex, iC = GetContainerItemInfo(i, y);
										local sName, sLink, iQuality, iLevel, sType, sSubType, iCount = GetItemInfo(link);
										if ( sName and itemCount and iCount and iC ) then
											if ( iCount >= (itemCount+iC) ) then
												if ( getn(CT_MMForward_ScheduledStack) == 0 ) then
													CT_MMForwardFrame.process = 2;
												end
												tinsert(CT_MMForward_ScheduledStack, { i, y, k, key });
												hasFound = 1;
												break;
											end
										end
									end
								end
							end
							if ( hasFound ) then
								break;
							end
						end
					end
				end
				CT_MMForward_BagLinks[i][y] = name;
			end
		end
	end
end

CT_MMForward_ScheduledStack = { };

function CT_MMForward_ProcessStack()
	local val = tremove(CT_MMForward_ScheduledStack, 1);
	PickupContainerItem(val[1], val[2]);
	PickupContainerItem(val[3], val[4]);
end

CT_MMForward_oldMailFrameTab_OnClick = MailFrameTab_OnClick;
function CT_MMForward_newMailFrameTab_OnClick(id)
	CT_MMForward_EnableForward();
	CT_MMForward_oldMailFrameTab_OnClick(id);
end
MailFrameTab_OnClick = CT_MMForward_newMailFrameTab_OnClick;

local oldSMMFfunc = SendMailMoneyFrame.onvalueChangedFunc;
SendMailMoneyFrame.onvalueChangedFunc = function()
	if ( oldSMMFfunc ) then
		oldSMMFfunc();
	end
	local subject = SendMailSubjectEditBox:GetText();
	if ( subject == "" or string.find(subject, "%[%d+G, %d+S, %d+C%]") ) then
		local copper, silver, gold = SendMailMoneyFrameCopper:GetText(), SendMailMoneyFrameSilver:GetText(), SendMailMoneyFrameGold:GetText();
		if ( not tonumber(copper) ) then
			copper = 0;
		end
		if ( not tonumber(silver) ) then
			silver = 0;
		end
		if ( not tonumber(gold) ) then
			gold = 0;
		end
		SendMailSubjectEditBox:SetText(format("[%sG, %sS, %sC]", gold, silver, copper));
	end
end