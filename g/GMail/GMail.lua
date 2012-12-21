GMail = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceHook-2.0")

function GMail:OnInitialize()

tinsert(UISpecialFrames, "GMailInboxOpenAll")

-- Allows the mail frame to be pushed
if ( UIPanelWindows["MailFrame"] ) then
	UIPanelWindows["MailFrame"].pushable = 1
else
	UIPanelWindows["MailFrame"] = { area = "left", pushable = 1 }
end

-- Close FriendsFrame will close if you try to open a mail with mailframe+friendsframe open
if ( UIPanelWindows["FriendsFrame"] ) then
	UIPanelWindows["FriendsFrame"].pushable = 2
else
	UIPanelWindows["FriendsFrame"] = { area = "left", pushable = 2 }
end

MailItem1:SetPoint("TOPLEFT", "InboxFrame", "TOPLEFT", 48, -80)
for i = 1, 7, 1 do
	getglobal("MailItem" .. i .. "ExpireTime"):SetPoint("TOPRIGHT", "MailItem" .. i, "TOPRIGHT", 10, -4)
	getglobal("MailItem" .. i):SetWidth(280)
end

GMAIL_NUMITEMBUTTONS = 21
GMail_BagLinks = { }
GMail_ScheduledStack = { }
GMail_SelectedItems = { }
GMail_DELETEDELAY = 1
GMail_DELETEEVENTDELAY = 1

GMailFrame.num = 0
PanelTemplates_SetNumTabs(MailFrame, 3)

GMailForwardFrame.pickItem = { }
GMailForwardFrame.process = 0

GMailGlobalFrame.queue = { }
GMailGlobalFrame.update = 0
GMailGlobalFrame.total = 0
GMailGlobalFrame.sendmail = 0
GMailGlobalFrame.latency = 2.25

GMailTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")

GMailInboxFrame.eventFunc = { }

end

function GMail:OnEnable()

self:RegisterEvent("MAIL_INBOX_UPDATE")
self:RegisterEvent("UI_ERROR_MESSAGE")
self:RegisterEvent("MAIL_SEND_SUCCESS")
self:RegisterEvent("MAIL_SEND_INFO_UPDATE")
self:RegisterEvent("MAIL_CLOSED")
self:RegisterEvent("BAG_UPDATE")

self:Hook("ContainerFrameItemButton_OnClick")
self:Hook("PickupContainerItem")
self:Hook("ContainerFrame_Update")
self:Hook("ClickSendMailItemButton")
self:HookScript(TradeFrame, "OnShow", "TF_Show")
self:Hook("InboxFrameItem_OnEnter")
self:Hook("MailFrameTab_OnClick")
self:Hook("InboxFrame_OnClick")
self:Hook("InboxFrame_Update")
self:Hook("CloseMail")
self:Hook("TakeInboxItem")
self:Hook("OpenMail_Reply")
oldTakeInboxMoney = OpenMailMoneyButton:GetScript("OnClick")

end

function GMail:MAIL_CLOSED()
	GMail:ClearItems()
	GMailGlobalFrame.total = 0
	GMailGlobalFrame.queue = { }
end

function GMail:MAIL_SEND_SUCCESS() 
	GMAIL_CANSENDNEXT = 1 
end

function GMail:ContainerFrameItemButton_OnClick(btn, ignore)
	if ( self:GetItemFrame(this:GetParent():GetID(), this:GetID()) ) then
		return
	end
	self.hooks["ContainerFrameItemButton_OnClick"].orig(btn, ignore)
	self:UpdateItemButtons()
end

function GMail:PickupContainerItem(bag, item, special)
	if ( ( self:GetItemFrame(bag, item) or ( GMail_addItem and GMail_addItem[1] == bag and GMail_addItem[2] == item ) ) and not special ) then
		return
	end
	if ( not CursorHasItem() ) then
		GMailFrame.bag = bag
		GMailFrame.item = item
	end
	if ( IsAltKeyDown() and GMailFrame:IsVisible() and not CursorHasItem() ) then
		local i
		for i = 1, GMAIL_NUMITEMBUTTONS, 1 do
			if ( not getglobal("GMailButton" .. i).item ) then

				if ( self:ItemIsMailable(bag, item) ) then
					GMail:Print("GMail: Cannot attach item.", 1, 0.5, 0)
					return
				end

				self.hooks["PickupContainerItem"].orig(bag, item)
				self:MailButton_OnClick(getglobal("GMailButton" .. i))
				self:UpdateItemButtons()
				return
			end
		end
	elseif ( IsAltKeyDown() and SendMailFrame:IsVisible() and not CursorHasItem() ) then
		self.hooks["PickupContainerItem"].orig(bag, item)
		ClickSendMailItemButton()
		return
	elseif ( IsAltKeyDown() and TradeFrame:IsVisible() and not CursorHasItem() ) then
		for i = 1, 6, 1 do
			if ( not GetTradePlayerItemLink(i) ) then
				self.hooks["PickupContainerItem"].orig(bag, item)
				ClickTradeButton(i)
				return
			end
		end
	elseif ( IsAltKeyDown() and not CursorHasItem() and ( not TradeFrame or not TradeFrame:IsVisible() ) and ( not AuctionFrame or not AuctionFrame:IsVisible() ) and UnitExists("target") and CheckInteractDistance("target", 2) and UnitIsFriend("player", "target") and UnitIsPlayer("target") ) then
		InitiateTrade("target")
		GMail_addItem = { bag, item, UnitName("target"), 2 }
		for i = 1, NUM_CONTAINER_FRAMES, 1 do
			if ( getglobal("ContainerFrame" .. i):IsVisible() ) then
				ContainerFrame_Update(getglobal("ContainerFrame" .. i))
			end
		end
		return
	end
	self.hooks["PickupContainerItem"].orig(bag, item)
	self:UpdateItemButtons()
end

function GMail:MailFrameTab_OnClick(tab)
	if ( not tab ) then 
		tab = this:GetID()
	end

	if ( tab == 3 ) then
		PanelTemplates_SetTab(MailFrame, 3)
		InboxFrame:Hide()
		SendMailFrame:Hide()
		GMailFrame:Show()
		SendMailFrame.sendMode = "massmail"
		MailFrameTopLeft:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-TopLeft")
		MailFrameTopRight:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-TopRight")
		MailFrameBotLeft:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-BotLeft")
		MailFrameBotRight:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-BotRight")
		MailFrameTopLeft:SetPoint("TOPLEFT", "MailFrame", "TOPLEFT", 2, -1)
		return
	else
		GMailFrame:Hide()
	end
	self.hooks["MailFrameTab_OnClick"].orig(tab)
	self:Forward_EnableForward()
end

function GMail:ClickSendMailItemButton()
	if ( not GetSendMailItem() ) then
		GMailFrame.mailbag = GMailFrame.bag
		GMailFrame.mailitem = GMailFrame.item
	end
	self.hooks["ClickSendMailItemButton"].orig()
end

-- Handle the dragging of items
function GMail:MailButton_OnClick(button)
	if ( not button ) then button = this end
	if ( CursorHasItem() ) then
		local bag = GMailFrame.bag
		local item = GMailFrame.item
		if ( not bag or not item ) then return end
		if ( self:ItemIsMailable(bag, item) ) then
			GMail:Print("GMail: Cannot attach item.", 1, 0.5, 0)
			self.hooks["PickupContainerItem"].orig(bag, item)
			return
		end
		self.hooks["PickupContainerItem"].orig(bag, item)
		if ( this.bag and this.item ) then
			-- There's already an item there
			-- Pickup that item to replicate Send Mail's behaviour
			self.hooks["PickupContainerItem"].orig(button.bag, button.item)
			GMailFrame.bag = button.bag
			GMailFrame.item = button.item
		else
			GMailFrame.bag = nil
			GMailFrame.item = nil
		end
		local texture, count = GetContainerItemInfo(bag, item)
		getglobal(button:GetName() .. "IconTexture"):Show()
		getglobal(button:GetName() .. "IconTexture"):SetTexture(texture)
		if ( count > 1 ) then
			getglobal(button:GetName() .. "Count"):SetText(count)
			getglobal(button:GetName() .. "Count"):Show()
		else
			getglobal(button:GetName() .. "Count"):Hide()
		end
		button.bag = bag
		button.item = item
		button.texture = texture
		button.count = count
	elseif ( button.item and button.bag ) then
		self.hooks["PickupContainerItem"].orig(button.bag, button.item)
		getglobal(button:GetName() .. "IconTexture"):Hide()
		getglobal(button:GetName() .. "Count"):Hide()
		GMailFrame.bag = button.bag
		GMailFrame.item = button.item
		button.item = nil
		button.bag = nil
		button.count = nil
		button.texture = nil

	end
	local num = self:GetNumMails()
	GMailFrame.num = num
	self:CanSend(GMailNameEditBox)
	if ( num == 0 ) then num = 1 end
	MoneyFrame_Update("GMailCostMoneyFrame", GetSendMailPrice()*num)
	for i = 1, NUM_CONTAINER_FRAMES, 1 do
		if ( getglobal("ContainerFrame" .. i):IsVisible() ) then
			ContainerFrame_Update(getglobal("ContainerFrame" .. i))
		end
	end
end

function GMail:ItemIsMailable(bag, item)

	-- Make sure tooltip is cleared
	for i = 1, 29, 1 do
		getglobal("GMailTooltipTextLeft" .. i):SetText("")
	end

	GMailTooltip:SetBagItem(bag, item)
	for i = 1, GMailTooltip:NumLines(), 1 do
		local text = getglobal("GMailTooltipTextLeft" .. i):GetText()
		if ( text == ITEM_SOULBOUND or text == ITEM_BIND_QUEST or text == ITEM_CONJURED or text == ITEM_BIND_ON_PICKUP ) then
			return 1
		end
	end
	return nil
end


function GMail:UpdateItemButtons(frame)
	local i
	for i = 1, GMAIL_NUMITEMBUTTONS, 1 do
		local btn = getglobal("GMailButton" .. i)
		if ( not frame or btn ~= frame ) then
			local texture, count
			if ( btn.item and btn.bag ) then
				texture, count = GetContainerItemInfo(btn.bag, btn.item)
			end
			if ( not texture ) then
				getglobal(btn:GetName() .. "IconTexture"):Hide()
				getglobal(btn:GetName() .. "Count"):Hide()
				btn.item = nil
				btn.bag = nil
				btn.count = nil
				btn.texture = nil
			else
				btn.count = count
				btn.texture = texture
				getglobal(btn:GetName() .. "IconTexture"):Show()
				getglobal(btn:GetName() .. "IconTexture"):SetTexture(texture)
				if ( count > 1 ) then
					getglobal(btn:GetName() .. "Count"):Show()
					getglobal(btn:GetName() .. "Count"):SetText(count)
				else
					getglobal(btn:GetName() .. "Count"):Hide()
				end
			end
		end
	end
end

function GMail:GetItemFrame(bag, item)
	local i
	for i = 1, GMAIL_NUMITEMBUTTONS, 1 do
		local btn = getglobal("GMailButton" .. i)
		if ( btn.item == item and btn.bag == bag ) then
			return btn
		end
	end
	return nil
end

function GMail:GetNumMails()
	local i
	local num = 0
	for i = 1, GMAIL_NUMITEMBUTTONS, 1 do
		local btn = getglobal("GMailButton" .. i)
		if ( btn.item and btn.bag ) then
			num = num + 1
		end
	end
	return num
end

function GMail:ClearItems()
	local i
	local num = 0
	for i = 1, GMAIL_NUMITEMBUTTONS, 1 do
		local btn = getglobal("GMailButton" .. i)
		btn.item = nil
		btn.count = nil
		btn.bag = nil
		btn.texture = nil
	end
	self:UpdateItemButtons()
	GMailMailButton:Disable()
	GMailNameEditBox:SetText("")
	GMailSubjectEditBox:SetText("")
	GMailStatusText:SetText("")
	GMailAbortButton:Hide()
	GMailAcceptSendFrame:Hide()
end

function GMail:CanSend(eb)
	if ( not eb ) then eb = this end
	if ( strlen(eb:GetText()) > 0 and GMailFrame.num > 0 and GetSendMailPrice()*GMailFrame.num <= GetMoney() ) then
		GMailMailButton:Enable()
	else
		GMailMailButton:Disable()
	end
end

function GMail:SendMail()
	for key, val in this.queue do
		GMailStatusText:SetText(format(GMAIL_SENDING, key, this.total))
		GMailAbortButton:Show()

		if ( GetSendMailItem() and GMailFrame.mailbag and GMailFrame.mailitem ) then
			-- There's already an item in the slot
			ClickSendMailItemButton()
			self.hooks["PickupContainerItem"].orig(GMailFrame.mailbag, GMailFrame.mailitem)
			GMailFrame.mailbag = nil
			GMailFrame.mailitem = nil
		elseif ( CursorHasItem() and GMailFrame.bag and GMailFrame.item ) then
			PickupContainerItem(GMailFrame.bag, GMailFrame.item)
			GMailFrame.bag = nil
			GMailFrame.item = nil
		end

		self.hooks["PickupContainerItem"].orig(val.bag, val.item)

		ClickSendMailItemButton()

		local name, useless, count = GetSendMailItem()

		if ( not name ) then 
			GMail:Print("GMail: " .. GMAIL_ERROR, 1, 0, 0)
		else

			local subjectstr = GMailSubjectEditBox:GetText()
			if ( strlen(subjectstr) > 0 ) then
				subjectstr = subjectstr .. " "
			end

			if ( count > 1 ) then
				subjectstr = subjectstr .. "[" .. name .. " x" .. count .. "]"
			else
				subjectstr = subjectstr .. "[" .. name .. "]"
			end

			SendMail(val.to, subjectstr, format(GMAIL_ITEMNUM, key, this.total))
		end

		GMailGlobalFrame.queue[key] = nil
		return
	end
	GMailStatusText:SetText(format(GMAIL_DONESENDING, this.total))
	GMailAbortButton:Hide()
	GMailGlobalFrame:Hide()

	GMailGlobalFrame.total = 0
	GMailGlobalFrame.queue = { }
end

function GMail:FillItemTable()
	local arr = { }
	for i = 1, GMAIL_NUMITEMBUTTONS, 1 do
		local btn = getglobal("GMailButton" .. i)
		if ( btn.item and btn.bag ) then
			tinsert(arr, { ["item"] = btn.item, ["bag"] = btn.bag, ["to"] = GMailNameEditBox:GetText() })
		end
	end
	return arr
end

function GMail:ProcessQueue(elapsed)
	if ( not GMAIL_CANSENDNEXT ) then
		return
	end
	this.sendmail = this.sendmail + elapsed
	if ( this.sendmail > 0.5 ) then
		this.sendmail = 0
		if ( this.total > 0 ) then
			self:SendMail()
			GMAIL_CANSENDNEXT = nil
		end
	end
end

function GMail:ContainerFrame_Update(frame)
	self.hooks["ContainerFrame_Update"].orig(frame)
	local id = frame:GetID()
	if ( GMailFrame:IsVisible() ) then
		local i
		for i = 1, GMAIL_NUMITEMBUTTONS, 1 do
			local btn = getglobal("GMailButton" .. i)
			if ( btn.item and btn.bag ) then
				if ( btn.bag == frame:GetID() ) then
					SetItemButtonDesaturated(getglobal(frame:GetName() .. "Item" .. (frame.size-btn.item)+1), 1, 0.5, 0.5, 0.5)
				end
			end
		end
	end
	if ( GMail_addItem and GMail_addItem[1] == frame:GetID() ) then
		SetItemButtonDesaturated(getglobal(frame:GetName() .. "Item" .. (frame.size-GMail_addItem[2])+1), 1, 0.5, 0.5, 0.5)
	end
end

function GMail:MAIL_SEND_INFO_UPDATE()
	if ( not SendMailFrame:IsVisible() ) then return end
	local name, useless, count = GetSendMailItem()

	if ( name and strlen(SendMailSubjectEditBox:GetText()) == 0 ) then
		if ( count > 1 ) then
			name = name .. " x" .. count
		end
		SendMailSubjectEditBox:SetText(name)
	end
end

function GMail:InboxFrameItem_OnEnter()
	local didSetTooltip
	if ( this.index ) then
		if ( GetInboxItem(this.index) ) then
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
			GameTooltip:SetInboxItem(this.index)
			didSetTooltip = 1
		end
	end
	if ( not didSetTooltip ) then
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
	end
	if (this.money) then
		GameTooltip:AddLine(ENCLOSED_MONEY, "", 1, 1, 1)
		SetTooltipMoney(GameTooltip, this.money)
		SetMoneyFrameColor("GameTooltipMoneyFrame", HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
	elseif (this.cod) then
		GameTooltip:AddLine(COD_AMOUNT, "", 1, 1, 1)
		SetTooltipMoney(GameTooltip, this.cod)
		if ( this.cod > GetMoney() ) then
			SetMoneyFrameColor("GameTooltipMoneyFrame", RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b)
		else
			SetMoneyFrameColor("GameTooltipMoneyFrame", HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
		end
	end
	if ( didSetTooltip and ( this.money or this.cod ) ) then
		GameTooltip:SetHeight(GameTooltip:GetHeight()+getglobal("GameTooltipTextLeft" .. GameTooltip:NumLines()):GetHeight())
		if ( GameTooltipMoneyFrame:IsVisible() ) then
			GameTooltip:SetHeight(GameTooltip:GetHeight()+GameTooltipMoneyFrame:GetHeight())
		end
	end
	GameTooltip:Show()
end

function GMail:TF_Show()
	self.hooks[TradeFrame].OnShow.orig()
	if ( GMail_addItem and not CursorHasItem() and UnitName("NPC") == GMail_addItem[3] ) then
		self.hooks["PickupContainerItem"].orig(GMail_addItem[1], GMail_addItem[2])
		
		ClickTradeButton(1)
	end
	GMail_addItem = nil
end

function GMail:Inbox_OnUpdate(elapsed)
	if ( GMail_addItem ) then
		GMail_addItem[4] = GMail_addItem[4] - elapsed
		if ( GMail_addItem[4] <= 0 ) then
			GMail_addItem = nil
			for i = 1, NUM_CONTAINER_FRAMES, 1 do
				if ( getglobal("ContainerFrame" .. i):IsVisible() ) then
					ContainerFrame_Update(getglobal("ContainerFrame" .. i))
				end
			end
		end
	end
	if ( this.num and this.elapsed ) then
		this.elapsed = this.elapsed - elapsed
		if ( this.elapsed <= 0 ) then
			this.elapsed = nil
			if ( this.id[1] ) then
				local val = this.id[1]
				local success = GMail:PickMail(val, this.openSelected)
				if ( success ~= 2 ) then
					tremove(this.id, 1)
					this.num = this.num - 1
				end
				if ( success == 1 ) then
					for key, va in this.id do
						if ( va > val ) then
							this.id[key] = va-1
						end
					end
					this.lastVal = val
					InboxFrame_Update()
				else
					this.elapsed = 1+GMail_DELETEDELAY
					this.lastVal = nil
				end
				if ( this.num == 0 ) then
					this.num = nil
					GMail:Inbox_DisableClicks(nil)
				end
			end
		end
	end
	if ( this.delete ) then
		this.delete[1] = this.delete[1] - elapsed
		if ( this.delete[1] <= 0 ) then
			local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, itemID, wasRead, wasReturned, textCreated  = GetInboxHeaderInfo(this.delete[2])
			if ( money == 0 and not itemID ) then
				GetInboxText(this.delete[2])
				DeleteInboxItem(this.delete[2])
			end
			this.delete = nil
			this.elapsed = 0.5+GMail_DELETEDELAY
		end
	end
end

function GMail:MAIL_INBOX_UPDATE()
	if ( GMailInboxFrame.eventDelete ) then
		GMailInboxFrame.delete = { GMail_DELETEEVENTDELAY, GMailInboxFrame.eventDelete }
		GMailInboxFrame.eventDelete = nil
	end
end
function GMail:UI_ERROR_MESSAGE()
	if ( event == "UI_ERROR_MESSAGE" and ( arg1 == ERR_INV_FULL or arg1 == ERR_ITEM_MAX_COUNT ) ) then
		if ( this.num ) then
			if ( arg1 == ERR_INV_FULL ) then
				GMail:Inbox_Abort()
				GMail:Print("GMail: Inventory full. Aborting.", 1, 0, 0)
			elseif ( arg1 == ERR_ITEM_MAX_COUNT ) then
				GMail:Print("GMail: You already have the maximum amount of that item. Skipping.", 1, 0, 0)
				this.elapsed = GMail_DELETEDELAY
				if ( this.lastVal ) then
					for key, va in this.id do
						if ( va >= this.lastVal ) then
							this.id[key] = va+1
						end
					end
				end
			end
		end
end
end

function GMail:Print(msg, r, g, b)
	DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b);
end

function GMail:PickMail(id, openSelected)
	if ( not id ) then
		return 0
	end
	local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, hasItem, wasRead, wasReturned, textCreated, canReply = GetInboxHeaderInfo(id)
	if ( CODAmount > 0 ) then
		GMail:Print("GMail: Mail |c00FFFFFF" .. this.numMails-(this.num-1) .. "|r/|c00FFFFFF" .. this.numMails .. "|r is Cash on Delivery, skipping.", 1, 0, 0)
		return 0
	elseif ( not hasItem and money == 0 and not openSelected ) then
		GMail:Print("GMail: Mail |c00FFFFFF" .. this.numMails-(this.num-1) .. "|r/|c00FFFFFF" .. this.numMails .. "|r has no money or items, skipping.", 1, 1, 0)
		return 0
	end
	GMail:Print("GMail: Opening mail |c00FFFFFF" .. this.numMails-(this.num-1) .. "|r/|c00FFFFFF" .. this.numMails .. "|r: \"|c00FFFFFF" .. ( subject or "<No Subject>" ) .. "|r\" from |c00FFFFFF" .. ( sender or "<Unknown Sender>" ) .. "|r.", 1, 1, 0)
	local eventDelete
	if ( hasItem ) then
		self.hooks["TakeInboxItem"].orig(id)
		eventDelete = 1
		if ( money > 0 ) then
			return 2
		end
	end
	if ( money > 0 ) then
		TakeInboxMoney(id)
		eventDelete = 1
	end
	if ( eventDelete ) then
		GMailInboxFrame.eventDelete = id
	else
		GMailInboxFrame.delete = { GMail_DELETEDELAY, id }
	end
	return 1
end

function GMail_Inbox_SetSelected()
	local id = this:GetID() + (InboxFrame.pageNum-1)*7
	if ( not this:GetChecked() ) then
		for k, v in GMail_SelectedItems do
			if ( v == id ) then
				tremove(GMail_SelectedItems, k)
				break
			end
		end
	else
		tinsert(GMail_SelectedItems, id)
	end
end

function GMail_Inbox_OpenSelected(openAll)
	GMail:Inbox_DisableClicks(1)
	GMailInboxFrame.num = 0
	GMailInboxFrame.elapsed = GMail_DELETEDELAY
	GMailInboxFrame.id = { }
	GMailInboxFrame.openSelected = not openAll
	if ( openAll ) then
		for i = 1, GetInboxNumItems(), 1 do
			GMailInboxFrame.num = GMailInboxFrame.num + 1
			tinsert(GMailInboxFrame.id, i)
		end
	else
		for k, v in GMail_SelectedItems do
			GMailInboxFrame.num = GMailInboxFrame.num + 1
			tinsert(GMailInboxFrame.id, v)
		end
	end
	GMailInboxFrame.numMails = GMailInboxFrame.num
	GMail_SelectedItems = { }
end

function GMail:InboxFrame_Update()
	self.hooks["InboxFrame_Update"].orig()
	for i = 1, 7, 1 do
		local index = (i + (InboxFrame.pageNum-1)*7)
		if ( index > GetInboxNumItems() ) then
			getglobal("GMailBoxItem" .. i .. "CB"):Hide()
		else
			getglobal("GMailBoxItem" .. i .. "CB"):Show()
			getglobal("GMailBoxItem" .. i .. "CB"):SetChecked(nil)
			for k, v in GMail_SelectedItems do
				if ( v == index ) then
					getglobal("GMailBoxItem" .. i .. "CB"):SetChecked(1)
					break
				end
			end
		end
	end
	if ( GMailInboxFrame.num ) then
		GMail:Inbox_DisableClicks(1, 1)
	end
end

function GMail:Inbox_DisableClicks(disable, loopPrevention)
	if ( disable ) then
		for i = 1, 7, 1 do
			getglobal("MailItem" .. i .. "ButtonIcon"):SetDesaturated(1)
		end
		if not self:IsHooked("InboxFrame_OnClick") then self:Hook("InboxFrame_OnClick", "DummyFunction") end
	else
		for i = 1, 7, 1 do
			getglobal("MailItem" .. i .. "ButtonIcon"):SetDesaturated(nil)
		end
		if ( not loopPrevention ) then
			InboxFrame_Update()
		end
		if self:IsHooked("InboxFrame_OnClick") then self:Unhook("InboxFrame_OnClick") end
	end
end

function GMail:InboxFrame_OnClick()
	this:SetChecked(nil)
end

function GMail:Inbox_Abort()
	GMailInboxFrame.num = nil
	GMailInboxFrame.elapsed = nil
	GMailInboxFrame.id = { }
	GMail_SelectedItems = { }
	GMail:Inbox_DisableClicks()
	HideUIPanel(GMailInboxOpenAll)
end

function GMail:CloseMail()
	self.hooks["CloseMail"].orig()
	GMail:Inbox_Abort()
end

function GMail:TakeInboxItem(id)
	self.hooks["TakeInboxItem"].orig(id)
	local name, itemTexture, count, quality, canUse = GetInboxItem(id)
	tinsert(GMailForwardFrame.pickItem, name)
end

-- Mail Forwarding
function GMail:DisableAttachments(disable)
	if ( disable ) then
		OpenMailMoneyButtonIconTexture:SetDesaturated(1)
		OpenMailPackageButtonIconTexture:SetDesaturated(1)
		if not self:IsHooked(OpenMailMoneyButton, "OnClick") then self:HookScript(OpenMailMoneyButton, "OnClick", "DummyFunction") end
		if not self:IsHooked(OpenMailPackageButton, "OnClick") then self:HookScript(OpenMailPackageButton, "OnClick", "DummyFunction") end
	else
		OpenMailMoneyButtonIconTexture:SetDesaturated(nil)
		OpenMailPackageButtonIconTexture:SetDesaturated(nil)
		if self:IsHooked(OpenMailMoneyButton, "OnClick") then self:Unhook(OpenMailMoneyButton, "OnClick") end
		if self:IsHooked(OpenMailPackageButton, "OnClick") then self:Unhook(OpenMailPackageButton, "OnClick") end
	end
end

function GMail:DummyFunction()
end

function GMail:OpenMail_Reply()
	self.hooks["OpenMail_Reply"].orig()
	SendMailMoneyCopper:SetText("")
	SendMailMoneySilver:SetText("")
	SendMailMoneyGold:SetText("")
end


function GMail:OpenReply()
	OpenMail_Reply()
	local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, hasItem, wasRead, wasReturned, textCreated, canReply = GetInboxHeaderInfo(InboxFrame.openMailID)
	
	-- Money
	local gold, silver, copper = "", "", ""
	if ( money and money > 0 ) then
		gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD))
		silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER)
		copper = mod(money, COPPER_PER_SILVER)
	end
	SendMailMoneyCopper:SetText(copper)
	SendMailMoneySilver:SetText(silver)
	SendMailMoneyGold:SetText(gold)
	
	-- Items
	local name, itemTexture, count, quality, canUse = GetInboxItem(InboxFrame.openMailID)
	SendMailPackageButton:SetNormalTexture(itemTexture)
	if ( count > 1 ) then
		SendMailPackageButtonCount:SetText(count)
	else
		SendMailPackageButtonCount:SetText("")
	end
	
	-- Text fields
	SendMailNameEditBox:SetText("")
	local subject = OpenMailSubject:GetText()
	local prefix = "FW:".." "
	if ( strsub(subject, 1, strlen(prefix)) ~= prefix ) then
		subject = prefix..subject
	end
	SendMailSubjectEditBox:SetText(subject or "")
	SendMailBodyEditBox:SetText(string.gsub(OpenMailBodyText:GetText() or "", "\n", "\n>"))
	SendMailNameEditBox:SetFocus()

	-- Set the send mode so the work flow can change accordingly
	SendMailFrame.sendMode = "reply"
	
	self:Forward_EnableForward(1)
end

function GMail:SendMailMailButton_OnClick()
	local name, itemTexture, count, quality, canUse = GetInboxItem(InboxFrame.openMailID)
	local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, hasItem, wasRead, wasReturned, textCreated, canReply = GetInboxHeaderInfo(InboxFrame.openMailID)
	if ( name ) then
		GMailForwardFrame.searchItem = name
		GMailForwardFrame.forwardStep = 1
		self.hooks["TakeInboxItem"].orig(InboxFrame.openMailID)
	else
		GMailForwardFrame.forwardStep = 2
		if ( money and money > 0 ) then
			SetSendMailMoney(money)
			GMailForwardFrame.countDown = 2
			oldTakeInboxMoney(InboxFrame.openMailID)
		else
			GMailForwardFrame.countDown = 0.5
		end
	end
	SendMailMailButton:Disable()
end

function GMail:Forward_OnUpdate(elapsed)
	if ( this.forwardStep and this.forwardStep > 1 ) then
		if ( this.countDown ) then
			this.countDown = this.countDown - elapsed
			if ( this.countDown <= 0 ) then
				if ( this.forwardStep == 2 ) then
					this.countDown = 0.5
					this.forwardStep = 3
					-- Send the mail
					SendMail(SendMailNameEditBox:GetText(), SendMailSubjectEditBox:GetText(), SendMailBodyEditBox:GetText())
					SendMailMailButton:Disable()
				elseif ( this.forwardStep == 3 ) then
					-- Delete the old one
					local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, itemID, wasRead, wasReturned, textCreated  = GetInboxHeaderInfo(InboxFrame.openMailID)
					if ( money == 0 and not itemID ) then
						DeleteInboxItem(InboxFrame.openMailID)
					end
					self:MailFrameTab_OnClick(1)
					HideUIPanel(OpenMailFrame)
					this.countDown = nil
					this.forwardStep = nil
				end
			end
		end
	end
	this.process = this.process - elapsed
	if ( this.process <= 0 ) then
		this.process = 3
		if ( getn(GMail_ScheduledStack) > 0 ) then
			self:ProcessStack()
		end
	end
end

function GMail:InboxFrame_OnClick(id)
	self.hooks["InboxFrame_OnClick"].orig(id)
	local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, itemID, wasRead, wasReturned, textCreated  = GetInboxHeaderInfo(id)
	if ( CODAmount and CODAmount > 0 ) then
		OpenMailForwardButton:Disable()
	else
		OpenMailForwardButton:Enable()
	end
end

function GMail:Forward_EnableForward(enable)
	if ( enable ) then
		OpenMailForwardButton:Disable()
		if not self:IsHooked(SendMailPackageButton, "OnEnter") then self:HookScript(SendMailPackageButton, "OnEnter", "SMPBOE") end
		SendMailCODButton:Disable()
		self:DisableAttachments(1)
		if not self:IsHooked("SendMailMailButton_OnClick") then self:Hook("SendMailMailButton_OnClick") end
		if not self:IsHooked("SendMailPackageButton_OnClick") then self:Hook("SendMailPackageButton_OnClick") end
	else
		OpenMailForwardButton:Enable()
		if self:IsHooked(SendMailPackageButton, "OnEnter") then self:Unhook(SendMailPackageButton, "OnEnter") end
		SendMailCODButton:Enable()
		self:DisableAttachments(nil)
		if self:IsHooked("SendMailMailButton_OnClick") then self:Unhook("SendMailMailButton_OnClick") end
		if self:IsHooked("SendMailPackageButton_OnClick") then self:Unhook("SendMailPackageButton_OnClick") end
	end
end

function GMail:SMPBOE()
	GameTooltip:SetOwner(SendMailPackageButton, "ANCHOR_RIGHT")
	GameTooltip:SetInboxItem(InboxFrame.openMailID) 
end
function GMail:SendMailPackageButton_OnClick()
end

function GMail:Forward_AttachSlot(container, item)
	PickupContainerItem(container, item)
	ClickSendMailItemButton()
	GMailForwardFrame.searchItem = nil
	GMailForwardFrame.forwardStep = 2
	GMailForwardFrame.countDown = 1.5
end

function GMail:BAG_UPDATE()
	local old = { }
	for k, v in GMail_BagLinks do
		if ( type(v) == "table" ) then
			old[k] = { }
			for key, val in v do
				old[k][key] = val
			end
		end
	end
	GMail_BagLinks = { }
	for i = 0, 4, 1 do
		GMail_BagLinks[i] = { }
		for y = 1, GetContainerNumSlots(i), 1 do
			local curr = GetContainerItemLink(i, y)
			local _, _, name = string.find(( curr or "" ), "%[(.+)%]")
			if ( name ) then
				if ( GMailForwardFrame.searchItem ) then
					if ( name and name == GMailForwardFrame.searchItem and not old[i][y] ) then
						self:Forward_AttachSlot(i, y)
					end
				else
					local _, _, name = string.find(( curr or "" ), "%[(.+)%]")
					if ( name and name == GMailForwardFrame.pickItem[1] and not old[i][y] ) then
						tremove(GMailForwardFrame.pickItem, 1)
						for k, v in old do
							local hasFound
							for key, val in v do
								if ( val == name and ( k ~= i or key ~= y ) ) then
									local _,_, link = string.find((GetContainerItemLink(k, key) or ""), "(item:[%d:]+)")
									if ( link ) then
										local texture, itemCount = GetContainerItemInfo(k,key)
										local tex, iC = GetContainerItemInfo(i, y)
										local sName, sLink, iQuality, iLevel, sType, sSubType, iCount = GetItemInfo(link)
										if ( sName and itemCount and iCount and iC ) then
											if ( iCount >= (itemCount+iC) ) then
												if ( getn(GMail_ScheduledStack) == 0 ) then
													GMailForwardFrame.process = 2
												end
												tinsert(GMail_ScheduledStack, { i, y, k, key })
												hasFound = 1
												break
											end
										end
									end
								end
							end
							if ( hasFound ) then
								break
							end
						end
					end
				end
				GMail_BagLinks[i][y] = name
			end
		end
	end
end


function GMail:ProcessStack()
	local val = tremove(GMail_ScheduledStack, 1)
	PickupContainerItem(val[1], val[2])
	PickupContainerItem(val[3], val[4])
end

local oldSMMFfunc = SendMailMoneyFrame.onvalueChangedFunc
SendMailMoneyFrame.onvalueChangedFunc = function()
	if ( oldSMMFfunc ) then
		oldSMMFfunc()
	end
	local subject = SendMailSubjectEditBox:GetText()
	if ( subject == "" or string.find(subject, "%[%d+G, %d+S, %d+C%]") ) then
		local copper, silver, gold = SendMailMoneyFrameCopper:GetText(), SendMailMoneyFrameSilver:GetText(), SendMailMoneyFrameGold:GetText()
		if ( not tonumber(copper) ) then
			copper = 0
		end
		if ( not tonumber(silver) ) then
			silver = 0
		end
		if ( not tonumber(gold) ) then
			gold = 0
		end
		SendMailSubjectEditBox:SetText(format("[%sG, %sS, %sC]", gold, silver, copper))
	end
end
