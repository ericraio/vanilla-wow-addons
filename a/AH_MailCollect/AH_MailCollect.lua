local AH_MAILCOLLECT_DEFAULT_OPTIONS = {
	dbNames			= {},
	displayMail		= TRUE,
	summaryMail	= TRUE,
	itemsMail			= TRUE,
	deleteAllMail	= false,
	auctionMail		= false,
}


--[[--------------------------------------------------------------------------------
  Class Setup
-----------------------------------------------------------------------------------]]
AH_MailCollect	= AceAddon:new({
    name          		= AH_MailCollectLocals.Name,
    description   	= AH_MailCollectLocals.Description, -- Optional  Ace will use the .toc Notes text
    version       		= AH_MailCollectLocals.Version,
    releaseDate   	= AH_MailCollectLocals.ReleaseDate,
    aceCompatible = "102", 
    author        		= "Tain",
    email         		= "tain.dev@gmail.com",
    website       		= "http://tain.wowinterface.com",
    category      	= "inventory",
    db            		= AceDatabase:new("AH_MailCollectDB"),
    defaults      		= AH_MAILCOLLECT_DEFAULT_OPTIONS,
    cmd           		= AceChatCmd:new(AH_MailCollectLocals.ChatCmd, AH_MailCollectLocals.ChatOpt)
})

function AH_MailCollect:Initialize()
	self.GetOpt		= function(var) local v=self.db:get(self.profilePath,var) return v end
	self.SetOpt		= function(var,val) self.db:set(self.profilePath,var,val)	end
	self.TogOpt		= function(var) return self.db:toggle(self.profilePath,var) end
	self.TogMsg		= function(text, val) self.cmd:status(text, val, ACEG_MAP_ONOFF) end
	self.Ins			= function(db, val) return self.db:insert(self.profilePath, db, val) end
end


--[[--------------------------------------------------------------------------------
  Addon Enabling/Disabling
-----------------------------------------------------------------------------------]]

function AH_MailCollect:Enable()
	self:RegisterEvent("MAIL_INBOX_UPDATE")
	self:RegisterEvent("MAIL_SHOW")
	self:RegisterEvent("MAIL_CLOSED")
	self:RegisterEvent("PLAYER_MONEY")
	self:RegisterEvent("BAG_UPDATE")
	self:Hook("InboxFrame_OnClick", "InboxFrameOnClick")
	self.TotalCashMsg = 0
end

function AH_MailCollect:InboxFrameOnClick(mailIndex)
	local _, _, sender, subject, money, CODAmount, _, hasItem, _, _, _, _= GetInboxHeaderInfo(mailIndex)
	if CODAmount == 0 then
		if money>0 then
				ace:print(format(AH_MailCollectLocals.GAINED_MSG, Ace.CashTextLetters(money)))
				TakeInboxMoney(mailIndex)
		end
		if hasItem then
        	if self.GetOpt("itemsMail") then
        		if AH_MailCollect:CheckFreeInventory() then
	        		ace:print(format(AH_MailCollectLocals.GAINED_MSG, GetInboxItem(mailIndex)))
       				TakeInboxItem(mailIndex)
       			else
        			error(AH_MailCollectLocals.TEXT_INV_FULL, 2)
        		end
        	end
		end
--	if (self.GetOpt("deleteAllMail") and (not money) and (not hasItem)) then
--        	DeleteInboxItem(mailIndex)
--	end
	end
	-- return self:CallHook("InboxFrame_OnClick",mailIndex)
	return self.Hooks["InboxFrame_OnClick"].orig(mailIndex)
end

function AH_MailCollect:MAIL_SHOW()
	self.FirstFire = TRUE
	self.TotalCashMsg = 0
	self.TotalItemMsg = 0
	self.Collecting = FALSE
	self.FreeBagSlot = -1
	self.BagNumber = -1
	self.cash = GetMoney() -- Save initial starting cash
	if self.GetOpt("summaryMail") then
		self.cashOnOpen = GetMoney()
	end
end

function AH_MailCollect:MAIL_CLOSED()
	local mailNumber = GetInboxNumItems();
	if mailNumber == 0 then
		MiniMapMailFrame:Hide();
	end
	if self.cashOnOpen and (self.cashOnOpen ~= GetMoney()) then
		self:DisplaySummary()
	end
	self.cashOnOpen = nil
end

function AH_MailCollect:PLAYER_MONEY()
	if InboxFrame:IsVisible() then
		self.Collecting = FALSE
		self:TriggerEvent("MAIL_INBOX_UPDATE")
	end
end

function AH_MailCollect:BAG_UPDATE()
	if InboxFrame:IsVisible() then
		if self.BagNumber and self.FreeBagSlot then
			texture = GetContainerItemInfo(self.BagNumber,self.FreeBagSlot)
		else return
		end
		if texture == nil then return
		else
			self.Collecting = FALSE
			self.FreeBagSlot = -1
			self.BagNumber = -1
		end
		self:TriggerEvent("MAIL_INBOX_UPDATE")
	end
end

function AH_MailCollect:MAIL_INBOX_UPDATE()
	self.cash = self.cash or GetMoney()
	if self.FirstFire == TRUE then
		self.FirstFire = FALSE
		updateCount = 0
		self.inboxItem = GetInboxNumItems()
		if self.inboxItem > 0 then
			AH_MailCollect:ScanMailBox()
		end
	end
	cashNow = GetMoney()
	cashStr = abs(cashNow - self.cash)
	if cashStr ~= 0 then
		if self.GetOpt("displayMail") then
			if cashNow > self.cash then
				ace:print(format(AH_MailCollectLocals.GAINED_MSG, Ace.CashTextLetters(cashStr)))
			elseif cashNow < self.cash then
				ace:print(format(AH_MailCollectLocals.LOST_CASH_MSG, Ace.CashTextLetters(cashStr)))
			end
		end
		self.cash = cashNow
	end
	if self.Collecting == FALSE then
		if self.TotalCashMsg > 0 then
			AH_MailCollect:CollectMoney()
		end
		if self.GetOpt("auctionMail") and self.TotalItemMsg > 0 then
			AH_MailCollect:CollectItems()
		end
	end
end

function AH_MailCollect:DisplaySummary()
	cashNow = GetMoney()
	cashStr = abs(cashNow - self.cashOnOpen)
	if cashStr ~= 0 then
		if cashNow > self.cashOnOpen then
			ace:print(format(AH_MailCollectLocals.GAINED_SUM_MSG, Ace.CashTextLetters(cashStr)))
		elseif cashNow < self.cashOnOpen then
			ace:print(format(AH_MailCollectLocals.LOST_SUM_MSG, Ace.CashTextLetters(cashStr)))
		end
		self.cashOnOpen = nil
	end
end

function AH_MailCollect:ToggleGainLossDisplayMail()
	self.TogMsg(AH_MailCollectLocals.TEXT_DISPLAY_MAIL, self.TogOpt("displayMail"))
end

function AH_MailCollect:ToggleGainLossSummaryMail()
	self.TogMsg(AH_MailCollectLocals.TEXT_SUM_MAIL, self.TogOpt("summaryMail"))
end

function AH_MailCollect:ToggleDeleteAllMail()
	self.TogMsg(AH_MailCollectLocals.TEXT_DELETE_ALL, self.TogOpt("deleteAllMail"))
end

function AH_MailCollect:ToggleLootItems()
	self.TogMsg(AH_MailCollectLocals.TEXT_LOOT_ITEMS, self.TogOpt("itemsMail"))
end

function AH_MailCollect:ToggleAuctionItems()
	self.TogMsg(AH_MailCollectLocals.TEXT_AUCTION_ITEMS, self.TogOpt("auctionMail"))
end

function AH_MailCollect:Report()
	self.cmd:report({
		{text=AH_MailCollectLocals.TEXT_DISPLAY_MAIL, val=self.GetOpt("displayMail"), map=ACEG_MAP_ONOFF},
		{text=AH_MailCollectLocals.TEXT_SUM_MAIL, val=self.GetOpt("summaryMail"), map=ACEG_MAP_ONOFF},
		{text=AH_MailCollectLocals.TEXT_LOOT_ITEMS, val=self.GetOpt("itemsMail"), map=ACEG_MAP_ONOFF},
		{text=AH_MailCollectLocals.TEXT_DELETE_ALL, val=self.GetOpt("deleteAllMail"), map=ACEG_MAP_ONOFF},
		{text=AH_MailCollectLocals.TEXT_AUCTION_ITEMS, val=self.GetOpt("auctionMail"), map=ACEG_MAP_ONOFF},
	})
end

function AH_MailCollect:ScanMailBox()
	self.SetOpt("MsgsWithCash", {})
	self.SetOpt("MsgsWithItem", {})
	for inbox_item_index = 1, self.inboxItem do
		_, _, _, msgSubject, msgMoney, _, _, msgItem, msgRead, _, _, _ = GetInboxHeaderInfo(inbox_item_index)
		if string.find(msgSubject, string.sub(AUCTION_SOLD_MAIL_SUBJECT,1,10)) or string.find(msgSubject, string.sub(AUCTION_OUTBID_MAIL_SUBJECT,1,10)) or string.find(msgSubject, string.sub(AUCTION_REMOVED_MAIL_SUBJECT,1,10)) then
			msgMoneyIndex = inbox_item_index
			self.Ins("MsgsWithCash",msgMoneyIndex)
			self.TotalCashMsg = (self.TotalCashMsg + 1)
		elseif string.find(msgSubject, string.sub(AUCTION_EXPIRED_MAIL_SUBJECT,1,10)) or string.find(msgSubject, string.sub(AUCTION_WON_MAIL_SUBJECT ,1,10)) then
			msgItemIndex = inbox_item_index
			self.Ins("MsgsWithItem",msgItemIndex)
			self.TotalItemMsg = self.TotalItemMsg + 1
		end
	end
	 -- ace:print(format("self.TotalItems start %s", self.TotalItems))
end

function AH_MailCollect:CollectMoney()
	self.Collecting = TRUE
	-- if (self.Collecting) then
	-- ace:print(format("self.Collecting is true."))
	-- end
	msgMoneyIndex = self.GetOpt("MsgsWithCash")[self.TotalCashMsg]
	_, _, _, msgSubject, msgMoney, _, _, msgItem, msgRead, _, _, _ = GetInboxHeaderInfo(msgMoneyIndex)
	if msgMoney > 0 then
		TakeInboxMoney(msgMoneyIndex)
		ace:print(format(msgSubject))
--	else 
--		DeleteInboxItem(msgMoneyIndex)
--		self.Collecting = FALSE
	end
	self.TotalCashMsg = self.TotalCashMsg - 1
end

function AH_MailCollect:CollectItems()
	self.Collecting = TRUE
	-- if (self.Collecting) then
	-- ace:print(format("self.Collecting is true."))
	-- end
	msgItemIndex = self.GetOpt("MsgsWithItem")[self.TotalItemMsg]
	_, _, _, msgSubject, msgMoney, _, _, msgItem, msgRead, _, _, _ = GetInboxHeaderInfo(msgItemIndex)
	if msgItem then
		if AH_MailCollect:CheckFreeInventory() then
			TakeInboxItem(msgItemIndex)
			ace:print(format(msgSubject))
		else
			error(AH_MailCollectLocals.TEXT_INV_FULL, 2)
			return
		end
	end
	self.TotalItemMsg = self.TotalItemMsg - 1
end

function AH_MailCollect:CheckFreeInventory()
	for bags=0,4 do
		for bagSlot=1,GetContainerNumSlots(bags) do
			texture = GetContainerItemInfo(bags,bagSlot);
			if texture == nil then
				self.FreeBagSlot = bagSlot
				self.BagNumber = bags
				return TRUE
			end
		end
	end
	return FALSE
end
--[[--------------------------------------------------------------------------------
  Register the Addon
-----------------------------------------------------------------------------------]]

AH_MailCollect:RegisterForLoad()
