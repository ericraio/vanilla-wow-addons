--$Id: OneBag.lua 8277 2006-08-17 14:11:43Z kaelten $
OneBag = OneCore:NewModule("OneBag", "AceEvent-2.0", "AceHook-2.0", "AceDebug-2.0", "AceConsole-2.0", "AceDB-2.0")

local L = AceLibrary("AceLocale-2.0"):new("OneBag")

function OneBag:OnInitialize()
    local baseArgs = OneCore:GetFreshOptionsTable(self)

    local customArgs = {
        ["0"] = {
            name = L"Backpack", type = 'toggle', order = 5,
            desc = L"Turns display of your backpack on and off.",
            get = function() return self.db.profile.show[0] end,
            set = function(v) 
                self.db.profile.show[0] = v 
                self:OrganizeFrame(true)
            end,
        },
        ["1"] = {
            name = L"First Bag", type = 'toggle', order = 6,
            desc = L"Turns display of your first bag on and off.",
            get = function() return self.db.profile.show[1] end,
            set = function(v) 
                self.db.profile.show[1] = v 
                self:OrganizeFrame(true)
            end,
        },
        ["2"] = {
            name = L"Second Bag", type = 'toggle', order = 7,
            desc = L"Turns display of your second bag on and off.",
            get = function() return self.db.profile.show[2] end,
            set = function(v) 
                self.db.profile.show[2] = v 
                self:OrganizeFrame(true)
            end,
        },
        ["3"] = {
            name = L"Third Bag", type = 'toggle', order = 8,
            desc = L"Turns display of your third bag on and off.",
            get = function() return self.db.profile.show[3] end,
            set = function(v) 
                self.db.profile.show[3] = v 
                self:OrganizeFrame(true)
            end,
        },
        ["4"] = {
            name = L"Fourth Bag", type = 'toggle', order = 9,
            desc = L"Turns display of your fourth bag on and off.",
            get = function() return self.db.profile.show[4] end,
            set = function(v) 
                self.db.profile.show[4] = v 
                self:OrganizeFrame(true)
            end,
        },
    }
    
    OneCore:CopyTable(customArgs, baseArgs.args.show.args)
	
    OneCore:LoadOptionalCommands(baseArgs, self)
       
	self:RegisterDB("OneBagDB")
	self:RegisterDefaults('profile', OneCore.defaults)
	self:RegisterChatCommand({"/ob", "/OneBag"}, baseArgs, string.upper(self.title))
	
	--self:SetDebugging(true)
	self.fBags			= {0, 1, 2, 3, 4}
    self.rBags          = {4, 3, 2, 1, 0}
	
	OneBagFrameName:SetText(UnitName("player").. L"'s Bags")
	
	self.frame = OneBagFrame
	self.frame.handler = self
    
    self.frame.bagFrame = OBBagFram
	self.frame.bagFrame.handler = self
    
    self.frame.bags = {}
		
	self:RegisterDewdrop(baseArgs)
end

function OneBag:OnEnable()	
	self:Hook("IsBagOpen")
	self:Hook("ToggleBag")
	self:Hook("OpenBag")
	self:Hook("CloseBag")
	self:Hook("OpenBackpack", "OpenBag")
	self:Hook("CloseBackpack", "CloseBag")
	self:Hook("ToggleBackpack", "ToggleBag")
	
	self:RegisterEvent("BAG_UPDATE",			  function() self:UpdateBag(arg1) end)
	self:RegisterEvent("BAG_UPDATE_COOLDOWN",	  function() self:UpdateBag(arg1) end)
	
	self:RegisterEvent("ITEM_LOCK_CHANGED",		  function() for i = 0, 4 do self:UpdateBag(i) end end)
	self:RegisterEvent("UPDATE_INVENTORY_ALERTS", function() for i = 0, 4 do self:UpdateBag(i) end end)
	
	self:RegisterEvent("AUCTION_HOUSE_SHOW", 	function() self:OpenBag() end)
	self:RegisterEvent("AUCTION_HOUSE_CLOSED", 	function() self:CloseBag() end)
	self:RegisterEvent("BANKFRAME_OPENED", 		function() self:OpenBag() end)
	self:RegisterEvent("BANKFRAME_CLOSED", 		function() self:CloseBag() end)
	self:RegisterEvent("MAIL_CLOSED", 			function() self:CloseBag() end)
	self:RegisterEvent("MERCHANT_SHOW", 		function() self:OpenBag() end)
	self:RegisterEvent("MERCHANT_CLOSED", 		function() self:CloseBag() end)
	self:RegisterEvent("TRADE_SHOW", 			function() self:OpenBag() end)
	self:RegisterEvent("TRADE_CLOSED", 			function() self:CloseBag() end)
end

function OneBag:OnDisable()
	for id=1, 12 do
		local frame = getglobal("ContainerFrame"..id)
		frame:ClearAllPoints()
		frame:SetScale(1)
		frame:SetAlpha(1)        
	end
end

function OneBag:OnKeyRingButtonClick()
	if (CursorHasItem()) then
		PutKeyInKeyRing();
	else
		ToggleKeyRing();
	end
	local shownContainerID = IsBagOpen(KEYRING_CONTAINER)
	if ( shownContainerID ) then
		local frame = getglobal("ContainerFrame"..shownContainerID)
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOMLEFT", this:GetParent():GetName() , "TOPLEFT", -9, 0)
		frame:SetScale(OneBag.db.profile.scale)
		frame:SetAlpha(OneBag.db.profile.alpha)
    else
        for id=1, 12 do
            local frame = getglobal("ContainerFrame"..id)
            frame:ClearAllPoints()
            frame:SetScale(1)
            frame:SetAlpha(1)        
        end
	end
end

--Hook responses
function OneBag:ToggleBag(bag)
	if bag and (bag < 0 or bag > 4) then
		return self.hooks.ToggleBag.orig(bag)
	end
	
	if self.frame:IsVisible() then
		self.frame:Hide()
	else
		self.frame:Show()
	end
end

function OneBag:IsBagOpen(bag)
	self:Debug(L"Checking if bag %s is open", bag)
	if bag < 0 or bag > 4 then
		return self.hooks.IsBagOpen.orig(bag)
	end
	
	if self.frame:IsVisible() then
		return bag
	else
		return nil	
	end
end

function OneBag:OpenBag(bag)
	self:Debug(L"Opening bag %s", bag)
	if bag and (bag < 0 or bag > 4) then
		return self.hooks.OpenBag.orig(bag)
	end
	
	self.frame:Show()
end


function OneBag:CloseBag(bag)
	self:Debug(L"Closing bag %s", bag)
	if bag and (bag < 0 or bag > 4) then
		return self.hooks.CloseBag.orig(bag)
	end
	
	self.frame:Hide()
end

function OneBag:OnCustomShow() 
    if self.db.profile.point then
        local point = self.db.profile.point
        this:ClearAllPoints()
        this:SetPoint("TOPLEFT", point.parent, "BOTTOMLEFT", point.left, point.top)
    end
end

function OneBag:OnCustomHide()
    local shownContainerID = IsBagOpen(KEYRING_CONTAINER)
    if ( shownContainerID ) then
        getglobal("ContainerFrame"..shownContainerID):Hide()
    end
    for id=1, 12 do
		local frame = getglobal("ContainerFrame"..id)
		frame:ClearAllPoints()
		frame:SetScale(1)
		frame:SetAlpha(1)        
	end
end