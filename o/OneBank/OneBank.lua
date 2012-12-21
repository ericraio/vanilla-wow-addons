--$Id: OneBank.lua 8012 2006-08-14 20:35:14Z hk2717 $
OneBank = OneCore:NewModule("OneBank", "AceEvent-2.0", "AceHook-2.0", "AceDebug-2.0", "AceConsole-2.0", "AceDB-2.0")
local L = AceLibrary("AceLocale-2.0"):new("OneBank")

function OneBank:OnInitialize()
	
    local baseArgs = OneCore:GetFreshOptionsTable(self)
    
	local customArgs = {
        ["5"] = {
            name = L"First Bag", type = 'toggle', order = 5,
            desc = L"Turns display of your first bag on and off.",
            get = function() return self.db.profile.show[5] end,
            set = function(v) 
                self.db.profile.show[5] = v 
                self:OrganizeFrame(true)
            end,
        },
        ["6"] = {
            name = L"Second Bag", type = 'toggle', order = 6,
            desc = L"Turns display of your second bag on and off.",
            get = function() return self.db.profile.show[6] end,
            set = function(v) 
                self.db.profile.show[6] = v 
                self:OrganizeFrame(true)
            end,
        },
        ["7"] = {
            name = L"Third Bag", type = 'toggle', order = 7,
            desc = L"Turns display of your third bag on and off.",
            get = function() return self.db.profile.show[7] end,
            set = function(v) 
                self.db.profile.show[7] = v 
                self:OrganizeFrame(true)
            end,
        },
        ["8"] = {
            name = L"Fourth Bag", type = 'toggle', order = 8,
            desc = L"Turns display of your fourth bag on and off.",
            get = function() return self.db.profile.show[8] end,
            set = function(v) 
                self.db.profile.show[8] = v 
                self:OrganizeFrame(true)
            end,
        },
        ["9"] = {
            name = L"Fifth Bag", type = 'toggle', order = 9,
            desc = L"Turns display of your fifth bag on and off.",
            get = function() return self.db.profile.show[9] end,
            set = function(v) 
                self.db.profile.show[9] = v 
                self:OrganizeFrame(true)
            end,
        },
        ["10"] = {
            name = L"Sixth Bag", type = 'toggle', order = 10,
            desc = L"Turns display of your sixth bag on and off.",
            get = function() return self.db.profile.show[10] end,
            set = function(v) 
                self.db.profile.show[10] = v 
                self:OrganizeFrame(true)
            end,
        },
    }
	
    OneCore:CopyTable(customArgs, baseArgs.args.show.args)
	
    OneCore:LoadOptionalCommands(baseArgs, self)
	
	self:RegisterDB("OneBankDB")
	self:RegisterDefaults('profile', OneCore.defaults)
	self:RegisterChatCommand({"/obb", "/OneBank"}, baseArgs, string.upper(self.title))
	
    --self:SetDebugging(true)
	
	self.fBags = {-1, 5, 6, 7, 8, 9, 10}
    self.rBags = {10, 9, 8, 7, 6, 5, -1}

	OneBankFrameName:SetText(UnitName("player").. L"'s Bank Bags")
	
    self.frame = OneBankFrame
	self.frame.handler = self
    
    self.frame.bagFrame = OBBBagFra
	self.frame.bagFrame.handler = self
    
    self.frame.bags = {}
    
	self.lastCounts = {}
    self.isBank = true
	
	self:RegisterDewdrop(baseArgs)
end

function OneBank:OnEnable()
	self.frame:SetClampedToScreen(true)
		
	self:RegisterEvent("BAG_UPDATE",			  function() self:UpdateBag(arg1) end)
	self:RegisterEvent("BAG_UPDATE_COOLDOWN",	  function() self:UpdateBag(arg1) end)
	
	self:RegisterEvent("BANKFRAME_OPENED", function() self.frame:Show() end)
	self:RegisterEvent("BANKFRAME_CLOSED", function() self.frame:Hide() end)
	
	self:RegisterEvent("PLAYERBANKSLOTS_CHANGED", function() 
		if not self.frame.bags[-1].colorLocked then
			for k, v in ipairs(self.frame.bags[-1]) do 
				self:SetBorderColor(v)
			end
		end
	end)
	
	if CT_oldPurchaseSlot then PurchaseSlot = CT_oldPurchaseSlot end
	self:Hook("PurchaseSlot", function() self.hooks.PurchaseSlot.orig() self.bagPurchased = true end)
    self:BuildFrame()
end

function OneBank:OnUpdate()
    local total, bagChanged = 0, false
    
    for i, k in self.fBags do
        local count = GetContainerNumSlots(k)
        if self.lastCounts[k] ~= count then
            self.lastCounts[k] = count
            bagChanged = true
        end
        total = total + count
    end
    
    if self.lastCount ~= total or bagChanged then
        self:BuildFrame()
        self:OrganizeFrame()
        self:DoSlotCounts()
        
        self.lastCount = total
    end
    
    if self.bagPurchased then
        self:UpdateBagSlotStatus()
    end
end

function OneBank:StartOnUpdate()
    self:ScheduleRepeatingEvent(self.title, self.OnUpdate, .25, self)
    self:UpdateBag(-1)
end

function OneBank:StopOnUpdate()
    self:CancelScheduledEvent(self.title)
end

function OneBank:UpdateBagSlotStatus() 
	local purchaseFrame = OBBBagFraPurchaseInfo
	if( purchaseFrame == nil ) then
		return
	end
	
	local numSlots,full = GetNumBankSlots()
	local button
	for i=1, NUM_BANKBAGSLOTS, 1 do
		button = getglobal("OBBBagFraBag"..i)
		if ( button ) then
			if ( i <= numSlots ) then
				SetItemButtonTextureVertexColor(button, 1.0,1.0,1.0)
				button.tooltipText = BANK_BAG
			else
				SetItemButtonTextureVertexColor(button, 1.0,0.1,0.1)
				button.tooltipText = BANK_BAG_PURCHASE
			end
		end
	end

	-- pass in # of current slots, returns cost of next slot
	local cost = GetBankSlotCost(numSlots)
	BankFrame.nextSlotCost = cost
	if( GetMoney() >= cost ) then
		SetMoneyFrameColor("OBBBagFraPurchaseInfoDetailMoneyFrame", 1.0, 1.0, 1.0)
	else
		SetMoneyFrameColor("OBBBagFraPurchaseInfoDetailMoneyFrame", 1.0, 0.1, 0.1)
	end
	MoneyFrame_Update("OBBBagFraPurchaseInfoDetailMoneyFrame", cost)

	if( full ) then
		purchaseFrame:Hide()
	else
		purchaseFrame:Show()
	end
end


function OneBank:OnCustomShow() 
    if self.db.profile.point then
        local point = self.db.profile.point
        this:ClearAllPoints()
        this:SetPoint("TOPLEFT", point.parent, "BOTTOMLEFT", point.left, point.top)
    else
        if not OneBag:IsActive() then 
            this:ClearAllPoints() 
            this:SetPoint("CENTER", UIParent, "CENTER", 0, 0) 
        else 
            this:ClearAllPoints() 
            this:SetPoint("BOTTOMLEFT", OneBagFrame, "TOPLEFT", 0, 25) 
        end
        
        
    end
    self:StartOnUpdate()
    self:UpdateBagSlotStatus()
end

function OneBank:OnCustomHide()
    CloseBankFrame()
    self:StopOnUpdate()
end
