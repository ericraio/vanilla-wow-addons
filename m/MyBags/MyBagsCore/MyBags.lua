--------------------------------------------------------------------------
-- MyBagsCore
-- Author: Ramble
--
-- Credits
--   Svarten for MyInventory
--   Turan for OneBag
--   Sarf for AIOI and initail concept
--------------------------------------------------------------------------

local MYBAGS_BOTTOMOFFSET = 20
local MYBAGS_COLWIDTH     = 40
local MYBAGS_ROWHEIGHT    = 40

local MYBAGS_MAXBAGSLOTS  = 28

local MIN_SCALE_VAL 	= "0.2"
local MAX_SCALE_VAL 	= "2.0"

local MYBAGS_SLOTCOLOR     = { 0.5, 0.5, 0.5 }
local MYBAGS_AMMOCOLOR     = { 0.6, 0.6, 0.1 }
local MYBAGS_SHARDCOLOR    = { 0.6, 0.3, 0.6 }
local MYBAGS_ENCHANTCOLOR  = { 0.2, 0.2, 1.0 }
local MYBAGS_ENGINEERCOLOR = { 0.6, 0.0, 0.0 }
local MYBAGS_HERBCOLOR     = { 0.0, 0.6, 0.0 }
local MYBAGS_KEYRINGCOLOR  = { 0.7, 0.4, 0.4 }

local CHARACTER_DELIMITOR = " " .. ACE_TEXT_OF .. " " -- surrounding spaces are needed

MYBAGS_KC_CHARS = nil
MYBAGS_CACHE_CHARS = nil

MyBagsCoreClass = AceAddonClass:new({
	version		  = "0.4.6 (11100)",
	releaseDate   = "07/19/06",
	category	     = "inventory",
	author		  = "Ramble (modified by Isharra)",
	email		  	  = "isharra (at) gmail (dot) com",
	website		  = "http://isharra.wowinterface.com",
	aceCompatible = "103",

   MAXBAGSLOTS = 36,
   minColumns = 2,
   maxColumns = 24,

   _TOPOFFSET    = 28,
   _BOTTOMOFFSET = 20,
   _LEFTOFFSET   =  8,
   _RIGHTOFFSET  =  3,

})
ace:RegisterFunctions(MyBagsCoreClass, {
	ColorConvertHexToDigit = function(h)
		if(strlen(h)~=6) then return 0,0,0 end
		local r={a=10,b=11,c=12,d=13,e=14,f=15}
		return ((tonumber(strsub(h,1,1)) or r[strsub(h,1,1)] or 0) * 16 +
				(tonumber(strsub(h,2,2)) or r[strsub(h,2,2)] or 0))/255,
			   ((tonumber(strsub(h,3,3)) or r[strsub(h,3,3)] or 0) * 16 +
				(tonumber(strsub(h,4,4)) or r[strsub(h,4,4)] or 0))/255,
			   ((tonumber(strsub(h,5,5)) or r[strsub(h,5,5)] or 0) * 16 +
				(tonumber(strsub(h,6,6)) or r[strsub(h,6,6)] or 0))/255
	end,

	GetItemInfoFromLink = function(l)
		if(not l) then return end
		local _,_,c,id,il,n=strfind(l,"|cff(%x+)|Hitem:(%d+)(:%d+:%d+:%d+)|h%[(.-)%]|h|r")
		return n,c,id..il,id
	end,

	IsSpecialtyBagFromLink = function(b)
		local _,_,_,i=ace.GetItemInfoFromLink(b)
		if(not i) then return end
		local _,_,_,_,c,d=GetItemInfo(i)
		return ace.IsSpecialtyBag(c,d)
	end,

	IsSpecialtyBagFromID = function(i)
		if(not i) then return end
		local _,_,_,_,c,d=GetItemInfo(i)
		return ace.IsSpecialtyBag(c,d)
	end,

	IsSpecialtyBag = function(itype,isubtype)
		if(strlower(itype or "")==strlower(ACEG_TEXT_AMMO)) then return 1 end
		if(strlower(itype or "")==strlower(ACEG_TEXT_QUIVER)) then return 2 end
		if(strlower(isubtype or "")==strlower(ACEG_TEXT_SOUL)) then return 3 end
		if(strlower(isubtype or "")==strlower(ACEG_TEXT_ENCHANT)) then return 4 end
		if(strlower(isubtype or "")==strlower(ACEG_TEXT_ENGINEER)) then return 5 end
		if(strlower(isubtype or "")==strlower(ACEG_TEXT_HERB)) then return 6 end
	end,

SplitString = function(s,p,n)
	if (type(s) ~= "string") then
		error("SplitString must be passed a string as the first argument", 2)
	end

    local l,sp,ep = {},0
    while(sp) do
        sp,ep=strfind(s,p)
        if(sp) then
            tinsert(l,strsub(s,1,sp-1))
            s=strsub(s,ep+1)
        else
            tinsert(l,s)
            break
        end
        if(n) then n=n-1 end
        if(n and (n==0)) then tinsert(l,s) break end
    end
    return unpack(l)
end,
})

function MyBagsCoreClass:Initialize()
	self.GetOpt = function(var) return self.db:get(self.profilePath,var)	end
	self.SetOpt = function(var,val) self.db:set(self.profilePath,var,val)	end
	self.TogOpt = function(var) return self.db:toggle(self.profilePath,var) end
	self.Result = function(text, val, map)
		if( map ) then val = map[val or 0] or val end
		self.cmd:result(text, " ", ACEG_TEXT_NOW_SET_TO, " ",
						format(ACEG_DISPLAY_OPTION, val or ACE_CMD_REPORT_NO_VAL)
					   )
	end
	self.Error  = function(...) self.cmd:result(format(unpack(arg))) end
	self.TogMsg = function(var,text) self.Result(text,self.TogOpt(var),ACEG_MAP_ONOFF) end
	self.frame = getglobal(self.frameName)
	self.frame.self = self
--	self:IsLive()
end
function MyBagsCoreClass:Enable()
	self:RegisterEvents()
	self:HookFunctions()
	if self.GetOpt("Scale") then
		self.frame:SetScale(self.GetOpt("Scale"))
	end
	self:SetUISpecialFrames()
	self:SetFrozen()
	self:SetLockTexture()
	local point = self.GetOpt("Anchor")
	if point then
		self.frame:ClearAllPoints()
		self.frame:SetPoint(string.upper(point), self.frame:GetParent():GetName(), string.upper(point), 0, 0)
	end
	if self:CanSaveItems() then
		self:LoadDropDown()
	else
		self.SetOpt("Player")
	end
	self:ChkCompanion()
	if self.GetOpt("Strata") then
		self.frame:SetFrameStrata(self.GetOpt("Strata"))
	end
end
function MyBagsCoreClass:RegisterEvents()
	self:RegisterEvent("BAG_UPDATE")
	self:RegisterEvent("BAG_UPDATE_COOLDOWN",     "LayoutFrameOnEvent")
	self:RegisterEvent("ITEM_LOCK_CHANGED",       "LayoutFrameOnEvent")
	-- I hate ITEM_LOCK_CHANGED but without it dragging to the actionbars never resets the item button.
--	self:RegisterEvent("UPDATE_INVENTORY_ALERTS", "LayoutFrameOnEvent")
end
function MyBagsCoreClass:HookFunctions()
	self:Hook("ToggleBag")
	self:Hook("OpenBag")
	self:Hook("CloseBag")
end
function MyBagsCoreClass:ToggleBag(bag)
--	self:debug("ToggleBagHook")
	if self.GetOpt("Replace") and self:IncludeBag(bag) then
		self:Toggle()
	else
		self.Hooks["ToggleBag"].orig(bag)
	end
end
function MyBagsCoreClass:OpenBag(bag)
--	self:debug("OpenBagHook")
	if (self.GetOpt("Replace") and self:IncludeBag(bag)) then
		self:Open()
	elseif not self.isBank then
		self.Hooks["OpenBag"].orig(bag)
	end
end
function MyBagsCoreClass:CloseBag(bag)
--	self:debug("CloseBagHook")
	if not self.Freeze and (self.GetOpt("Replace") and self:IncludeBag(bag)) then
		self:Close()
	elseif not self.isBank then
		self.Hooks["CloseBag"].orig(bag)
	end
end

function MyBagsCoreClass:TooltipSetOwner(owner, anchor)
	if not owner then owner = UIParent end
	local parent = owner:GetParent()
	if parent and (parent == self.frame or parent:GetParent() == self.frame ) then
		local point = self.GetOpt("Anchor") or "bottomright"
		if point == "topleft" or point == "bottomleft" then
			anchor = "ANCHOR_RIGHT"
		else
			anchor = "ANCHOR_LEFT"
		end
	else
		anchor = "ANCHOR_PRESERVE"
	end
	GameTooltip:SetOwner(owner, anchor)
end
-- Frame Toggle {{{
function MyBagsCoreClass:Open()
	if not self.frame:IsVisible() then self.frame:Show() end
	if self.Player and self.Player ~= ace.char.id then
		self.Player = ace.char.id
		local dropDown = getglobal(self.frameName .. "CharSelectDropDown")
		if dropDown then
		   UIDropDownMenu_SetSelectedValue(dropDown, ace.char.id)
		end
	end
	self:LayoutFrame()
end
function MyBagsCoreClass:Close()
	if self.frame:IsVisible() then self.frame:Hide() end
end
function MyBagsCoreClass:Toggle()
	if self.frame:IsVisible() then
		self:Close()
	else
		self:Open()
	end
end

function MyBagsCoreClass:GetHyperlink(ID)
	local _,	link = GetItemInfo("item:" .. ID)
	return link
end
function MyBagsCoreClass:GetTextLink(ID)
   local myName, myLink, myQuality = GetItemInfo("item:" .. ID)
   local	_,_,_,myColor = GetItemQualityColor(myQuality or 0)
	local textLink = "|cff" .. (strsub(myColor,5)) ..  "|H" .. myLink .. "|h[" .. myName .. "]|h|r"
   return textLink
end

--ITEMBUTTONS--
function MyBagsCoreClass:ItemButton_OnLoad()
	getglobal(this:GetName().."NormalTexture"):SetTexture("Interface\\AddOns\\MyBags\\Skin\\Button");
	ContainerFrameItemButton_OnLoad()
end
function MyBagsCoreClass:ItemButton_OnLeave()
	GameTooltip:Hide()
	local bagButton = getglobal(this:GetParent():GetName() .. "Bag")
	if bagButton then bagButton:UnlockHighlight() end
	CursorUpdate()
end
function MyBagsCoreClass:ItemButton_OnClick(button, ignoreShift)
	if self.isLive then
		if this.hasItem then self.watchLock = 1 end
		if self.isBank and this:GetParent():GetID() == BANK_CONTAINER then
			BankFrameItemButtonGeneric_OnClick(button)
		else
			ContainerFrameItemButton_OnClick(button, ignoreShift)
		end
	else
		if button == "LeftButton" and IsControlKeyDown() and not ignoreShift then
			local _, _, ID = self:GetInfo(this:GetParent():GetID(), this:GetID() )
			if DressUpItemLink and ID ~= "" then
				DressUpItemLink("item:"..ID)
			end
		elseif (button == "LeftButton" ) and ( IsShiftKeyDown() and not ignoreShift) then
			if (ChatFrameEditBox:IsVisible()) then
				local _, _, ID = self:GetInfo(this:GetParent():GetID(), this:GetID() )
				local textLink
				if ID then textLink = self:GetTextLink(ID) end
				if textLink then ChatFrameEditBox:Insert(textLink)  end
			end
		end
	end
end
function MyBagsCoreClass:ItemButton_OnEnter()
	if self.GetOpt("HlBags") == 1 then
		local bagButton = getglobal(this:GetParent():GetName() .. "Bag")
		if bagButton then bagButton:LockHighlight() end
	end
	self:TooltipSetOwner(this)
	if self.isLive then
		if this:GetParent() == MyBankFrameBank then -- OnEnter for BankItems is in XML, need 1.7 to use actual code
			GameTooltip:SetInventoryItem("player", BankButtonIDToInvSlotID(this:GetID()))
		else
			ContainerFrameItemButton_OnEnter(this)
		end
	else
		local ID
		_, _, ID = self:GetInfo(this:GetParent():GetID(), this:GetID())
		if ID then
			local hyperlink = self:GetHyperlink(ID)
			if hyperlink then GameTooltip:SetHyperlink(hyperlink) end
		end
	end
	if ( this.readable or (IsControlKeyDown() and this.hasItem) ) then
		ShowInspectCursor()
	end
end
function MyBagsCoreClass:ItemButton_OnDragStart()
	if self.isLive then
		self:ItemButton_OnClick("LeftButton", 1)
	end
end
function MyBagsCoreClass:ItemButton_OnReceiveDrag()
	if self.isLive then
		self:ItemButton_OnClick("LeftButton", 1)
	end
end
function MyBagsCoreClass:ItemButton_OnUpdate(arg1)
end

--BAGBUTTONS--
function MyBagsCoreClass:BagButton_OnEnter()
	local bagFrame = this:GetParent()
	local setTooltip = true
	self:TooltipSetOwner(this)
	if self.isLive then
		local invSlot = self:BagIDToInvSlotID(bagFrame:GetID())
		if not invSlot or (not GameTooltip:SetInventoryItem("player", invSlot)) or bagFrame:GetID() == KEYRING_CONTAINER then
			setTooltip = false
		end
	else
		_, _, ID = self:GetInfo(this:GetParent():GetID())
		if bagFrame:GetID() == 0 then
			GameTooltip:SetText(BACKPACK_TOOLTIP, 1.0,1.0,1.0)
		elseif bagFrame:GetID() == KEYRING_CONTAINER then
			setTooltip = false
		elseif ID then
			hyperlink = self:GetHyperlink(ID)
			if hyperlink then
				GameTooltip:SetHyperlink(hyperlink)
			end
		else
			setTooltip = false
		end
	end
	if not setTooltip then
		local keyBinding
		if self.isBank then
			if self.isLive and not self:IsBagSlotUsable(bagFrame:GetID()) then
				GameTooltip:SetText(BANK_BAG_PURCHASE)
				if MyBank.atBank then
					local cost = GetBankSlotCost()
					GameTooltip:AddLine("Purchase:", "", 1, 1, 1)
					SetTooltipMoney(GameTooltip, cost)
					if GetMoney() > cost then
						SetMoneyFrameColor("GameTooltipMoneyFrame", 1.0, 1.0, 1.0)
					else
						SetMoneyFrameColor("GameTooltipMoneyFrame", 1.0, 0.1, 0.1)
					end
					GameTooltip:Show()
				end
				keyBinding = GetBindingKey("TOGGLEBAG"..(4-this:GetID()))
			else
				GameTooltip:SetText(BANK_BAG)
			end
		else
			if bagFrame:GetID() == 0 then -- SetScript("OnEnter", MainMenuBarBackpackButton:GetScript("OnEnter"))
				GameTooltip:SetText(BACKPACK_TOOLTIP, 1.0,1.0,1.0)
				keyBinding = GetBindingKey("TOGGLEBACKPACK")
			elseif bagFrame:GetID() == KEYRING_CONTAINER then
				GameTooltip:SetText(KEYRING, 1.0,1.0,1.0)
				keyBinding = GetBindingKey("TOGGLEKEYRING")
			else
				GameTooltip:SetText(EQUIP_CONTAINER)
			end
		end
	end
	if self.GetOpt("HlItems") == 1 then -- Highlight
		local i
		for i = 1, self.MAXBAGSLOTS do
			local button = getglobal(bagFrame:GetName() .. "Item" .. i)
			if button then
				button:LockHighlight()
			end
		end
	end
end
function MyBagsCoreClass:BagButton_OnLeave()
	SetMoneyFrameColor("GameTooltipMoneyFrame", 1.0, 1.0, 1.0);
	GameTooltip:Hide()
	for i = 1, self.MAXBAGSLOTS do
		button = getglobal(this:GetParent():GetName() .. "Item" .. i)
		if button then	button:UnlockHighlight() end
	end
end
function MyBagsCoreClass:BagButton_OnClick(button, ignoreShift)
	if self.isBank then
		this:SetChecked(nil)
	else
		this:SetChecked(self:IncludeBag(this:GetID()))
	end
	if self.isLive then
		if button == "LeftButton" then
			if not self:IsBagSlotUsable(this:GetParent():GetID()) then
				local cost = GetBankSlotCost()
				if GetMoney() > cost then
					if not StaticPopupDialogs["PURCHASE_BANKBAG"] then	return end
					StaticPopup_Show("PURCHASE_BANKBAG")
				end
				return
			end
			if (not IsShiftKeyDown()) then
			self:BagButton_OnReceiveDrag()
			else
			end
		else
			if (IsShiftKeyDown()) then
				self.db:toggle({self.profilePath, "BagSlot" .. this:GetParent():GetID() }, "Exclude")
				self.Hooks["CloseBag"].orig(this:GetParent():GetID())
				self:LayoutFrame()
			end
		end
	end
end
function MyBagsCoreClass:BagButton_OnDragStart()
	if self.isLive then
		local bagFrame = this:GetParent()
		local invID = self:BagIDToInvSlotID(bagFrame:GetID())
		if invID then
			PickupBagFromSlot(invID)
			PlaySound("BAGMENUBUTTONPRESS")
			self.watchLock = 1
		end
	end
end
function MyBagsCoreClass:BagButton_OnReceiveDrag()
	if self.isLive then
		local bagFrame = this:GetParent()
		local invID = self:BagIDToInvSlotID(bagFrame:GetID())
		local hadItem
		if not invID then
			hadItem = PutItemInBackpack()
		elseif bagFrame:GetID() == KEYRING_CONTAINER then
			PutKeyInKeyRing()
		else
			hadItem = PutItemInBag(invID)
		end
		if not hadItem then
			if not self:IncludeBag(bagFrame:GetID()) then
				if bagFrame:GetID() == KEYRING_CONTAINER then
					self.Hooks["ToggleKeyRing"].orig()
				else
					self.Hooks["ToggleBag"].orig(bagFrame:GetID())
				end
			end
		end
	end
end

function MyBagsCoreClass:LoadDropDown()
	local dropDown = getglobal(self.frameName .. "CharSelectDropDown")
	local dropDownButton = getglobal(self.frameName .. "CharSelectDropDownButton")
	if not dropDown then return end
	local last_this = getglobal("this")
	setglobal("this", dropDownButton)
	UIDropDownMenu_Initialize(dropDown, self.UserDropDown_Initialize)
	UIDropDownMenu_SetSelectedValue(dropDown, self:GetCurrentPlayer())
	UIDropDownMenu_SetWidth(140, dropDown)
	OptionsFrame_EnableDropDown(dropDown)
	setglobal("this", last_this)
end
function MyBagsCoreClass:UserDropDown_Initialize()
	--if not KC_Items then return end
	local chars
	local hasList = 0
	if KC_Items then
		chars = KC_Items.common:GetCharList(ace.char.realm, ace.char.faction)
		for key, value in chars do
			hasList = 1
			MYBAGS_KC_CHARS = chars
			break
		end
		if charCount == 0 then 
			self.GetOpt("Player")
			return 
		end
	elseif MyBagsCache then
		chars = MyBagsCache:GetCharList()
		for key, value in chars do
			hasList = 1
			MYBAGS_CACHE_CHARS = chars
			break
		end
		if hasList == 0 then 
			self.GetOpt("Player")
			return 
		end
	else
		return
	end
	MyBank:debug("Character list is available")
	local frame = this:GetParent():GetParent():GetParent()
	local selectedValue = UIDropDownMenu_GetSelectedValue(this)

	for key, value in chars do
		info = {
			["text"] = key,
			["value"] = key,
			["func"] = frame.self.UserDropDown_OnClick,
			["owner"] = frame.self,
			["checked"] = nil,
		}
		if selectedValue == info.value then info.checked = 1 end
		UIDropDownMenu_AddButton(info)
	end
end
function MyBagsCoreClass:UserDropDown_OnClick()
	self = this.owner
	local dropDown = getglobal(self.frameName .. "CharSelectDropDown")
	self.Player = this.value
	UIDropDownMenu_SetSelectedValue(dropDown, this.value)
	self:LayoutFrame()
end
function MyBagsCoreClass:GetCurrentPlayer()
	if self.Player then return self.Player end
	return ace.char.id
end

function MyBagsCoreClass:CanSaveItems()
	local live = self:IsLive()
	self.isLive = FALSE
	if self:GetInfoFunc() ~= self.GetInfoNone then
		self.isLive = live
		return TRUE
	end
	self.isLive = live
	return FALSE
end
function MyBagsCoreClass:IsLive()
	local isLive = true
	local charID = self:GetCurrentPlayer()
	if charID ~= ace.char.id then isLive = false end
	if self.isBank and not MyBank.atBank then isLive = false end
	self.isLive = isLive
	return isLive
end
function MyBagsCoreClass:BagIDToInvSlotID(bag, isBank)
	if bag == -1 or bag >= 5 and bag <= 10 then isBank = 1 end
	if isBank then return BankButtonIDToInvSlotID(bag, 1)	end
	return ContainerIDToInventoryID(bag)
end

function MyBagsCoreClass:IncludeBag(bag)
	if self.isBank and bag == BANK_CONTAINER then return TRUE end
	if not self.isBank and bag == KEYRING_CONTAINER then
		if self.db:get({self.profilePath, "BagSlot"..bag} , "Exclude") then
			return FALSE
		end
		return TRUE
	end
	if bag < self.firstBag or bag > (self.firstBag + self.totalBags-1) then
		return FALSE
	else
		if self.db:get({self.profilePath, "BagSlot"..bag} , "Exclude") then
			return FALSE
		end
		return TRUE
	end
end
function MyBagsCoreClass:IsBagSlotUsable(bag)
	if not self.isBank then return TRUE end
	local slots, full = GetNumBankSlots()
	if (bag+1 - self.firstBag) <= slots  then return TRUE end
	return FALSE
end

function MyBagsCoreClass:GetCash()
	if self.isLive then return GetMoney()
	elseif  IsAddOnLoaded("MyBagsCache") then
		local charID = self:GetCurrentPlayer()
		return MyBagsCache:GetCash(charID)
	end
	return nil
end	
function MyBagsCoreClass:GetInfo(bag, slot)
	local infofunc = self:GetInfoFunc()
	if infofunc then
		return infofunc(self, bag, slot)
	end
	return nil, 0, nil, nil, nil, nil, nil
end
function MyBagsCoreClass:GetInfoLive(bag, slot)
	local texture, count, ID
	local locked, quality, readable
	local itemLink

	self.Player = ace.char.id
	if slot ~= nil then
		-- it's an item
		texture, count, locked, _ , readable = GetContainerItemInfo(bag, slot)
		itemLink = GetContainerItemLink(bag, slot)
		if itemLink then
			_, quality, _, ID = ace.GetItemInfoFromLink(itemLink)
		end
	else
		-- it's a bag
		 	if(bag == KEYRING_CONTAINER) then
				count = GetKeyRingSize()
			else
				count = GetContainerNumSlots(bag)
			end
			local inventoryID = self:BagIDToInvSlotID(bag)
			if inventoryID then
				texture = GetInventoryItemTexture("player", inventoryID)
				itemLink = GetInventoryItemLink("player", inventoryID)
				if itemLink then
					_, quality, _, ID = ace.GetItemInfoFromLink(itemLink)
				end
				locked = IsInventoryItemLocked(inventoryID)
				readable = ace.IsSpecialtyBagFromLink(itemLink)
			else
				texture = "Interface\\Buttons\\Button-Backpack-Up"
				count = 16
			end
	end
	count = tonumber(count)
	if count == nil then count = 0 end
	return texture, count, ID, locked, quality, readable, nil
end
function MyBagsCoreClass:GetInfoMyBagsCache(bag,slot,charID)
	local charID = self:GetCurrentPlayer()
	local texture, count, ID, locked, quality, readable, name
	if self.isEquipment then
		slot = bag
		texture, count, ID, quality, name = MyBagsCache:GetInfo("equipment", bag, charID)
	else -- data.Texture, data.Count, data.Link, data.Color, data.Name
		texture, count, ID, quality, name = MyBagsCache:GetInfo(bag, slot, charID)
		if not slot and ID then
			local _,_,_,_,c,d=GetItemInfo("item:"..ID)
			readable = ace.IsSpecialtyBag(c,d)
		end
	end
	count = tonumber(count)
	if count == nil then count = 0 end
	return texture, count, ID, nil, quality, readable, name
end
function MyBagsCoreClass:GetInfoNone(bag, slot)
	return nil, 0, nil, nil, nil, nil, nil
end

function MyBagsCoreClass:GetSlotCount()
	local slots, used, displaySlots = 0, 0, 0
	if self.isBank then
		if self:CanSaveItems() or self.isLive then
			slots = 24 
			displaySlots = 24 
		end
		for i = 1, slots do
			if (self:GetInfo(BANK_CONTAINER, i)) then used = used + 1 end
		end
	end
	for bagIndex = 0, self.totalBags -1 do
		local bagFrame = getglobal(self.frameName .. "Bag" .. bagIndex)
		if bagFrame and self:IncludeBag(bagFrame:GetID()) then
			local bagID = bagFrame:GetID()
			local bagSlots, specBag
			_, bagSlots, _, _, _, specBag = self:GetInfo(bagID)
			bagSlots = ace.tonum(bagSlots)
			if not specBag or specBag == "" then
				slots = slots + bagSlots
				displaySlots = displaySlots + bagSlots
				for i = 1, bagSlots do
					if self:GetInfo(bagID, i) then used = used + 1 end
				end
			else
				displaySlots = displaySlots + bagSlots
			end
		end
	end
	if self:IncludeBag(KEYRING_CONTAINER) then
		_, bagSlots, _, _, _, specBag = self:GetInfo(KEYRING_CONTAINER)
		displaySlots = displaySlots + bagSlots
	end
	return slots, used, displaySlots
end

function MyBagsCoreClass:LayoutOptions()
	local playerSelectFrame = getglobal(self.frameName .. "CharSelect")
	local title = getglobal(self.frameName .. "Name")
	local cash = getglobal(self.frameName .. "MoneyFrame")
	local slots = getglobal(self.frameName .. "Slots")
	local buttons = getglobal(self.frameName .. "Buttons")
	self:UpdateTitle()
	if self.GetOpt("Title") == TRUE then   title:Show()
	else                                   title:Hide() end
	if self.GetOpt("Cash") == TRUE then
		local cashvalue = self:GetCash()
		if cashvalue then
			MoneyFrame_Update(self.frameName .. "MoneyFrame", cashvalue)
			cash:Show()
		else
			cash:Hide()
		end
	else                                   cash:Hide()	end
	if self.GetOpt("Buttons") == TRUE then buttons:Show()
	else                                   buttons:Hide()	end
	self:SetFrameMode(self.GetOpt("Graphics"))
	if self.GetOpt("Player") == TRUE then
		playerSelectFrame:Show()
	else
		playerSelectFrame:Hide()
	end
	playerSelectFrame:ClearAllPoints()

	if (self.GetOpt("Graphics")) == "art" then
		playerSelectFrame:SetPoint("TOP", self.frameName, "TOP", 22, -38)
		self._TOPOFFSET = 32
	elseif self.GetOpt("Title") or self.GetOpt("Buttons") then
		playerSelectFrame:SetPoint("TOP", self.frameName, "TOP", 0, -38)
		self._TOPOFFSET = 28
	else
		playerSelectFrame:SetPoint("TOP", self.frameName, "TOP", 0, -18)
		self._TOPOFFSET =  8
	end
	if self.GetOpt("Cash") or (not self.isEquipment and self.GetOpt("Count") ~= "none") then
		self._BOTTOMOFFSET = 25
	else
		self._BOTTOMOFFSET = 3
	end
	if (self.frame.isBank) then
--		self:debug("self.frame.isBank") -- does this ever occur?
		MYBAGS_BOTTOMOFFSET = MYBAGS_BOTTOMOFFSET+20
		cash:ClearAllPoints()
		cash:SetPoint("BOTTOMRIGHT", self.frameName, "BOTTOMRIGHT", 0, 25)
	end

	if self.GetOpt("Player") == TRUE or self.GetOpt("Graphics") == "art" then
		self.curRow = self.curRow + 1
	end
	if self.GetOpt("Bag") == "bar" then
		self.curRow = self.curRow + 1
	end
	local count, used, displaySlots = nil
	if not (self.isEquipment) then
		count, used, displaySlots = self:GetSlotCount()
		count = ace.tonum(count)
		displaySlots = ace.tonum(displaySlots)
		if self.GetOpt("Count") == "free" then
			slots:Show()
			slots:SetText(format(MYBAGS_SLOTS_DD, (count - used), count ))
		elseif self.GetOpt("Count") == "used" then
			slots:Show()
			slots:SetText(format(MYBAGS_SLOTS_DD, (used), count ))
		else
			slots:Hide()
		end
		if self.GetOpt("Reverse") then
			self.reverseOrder = TRUE
		else
			self.reverseOrder = nil
		end
	end
	if self.GetOpt("AIOI") then
		self.aioiOrder = TRUE
		local columns = self.GetOpt("Columns")
		if not (self.isEquipment) and self.GetOpt("Bag") == "before" then displaySlots = displaySlots + self.totalBags end
		columns = ace.tonum(columns)
		if self.isEquipment then displaySlots = 20 end
		self.curCol = columns - (mod(displaySlots, columns) )
		if self.curCol == columns then self.curCol = 0 end
	else
		self.aioiOrder = nil
	end

end
function MyBagsCoreClass:UpdateTitle()
	local title1 = 4
	local title2 = 7
	if self.GetOpt("Graphics") == "art" then
		title1 = 5
		title2 = 9
	end
	local columns = self.GetOpt("Columns")
	local titleString
	if columns > title2 then
		titleString = MYBAGS_TITLE2
	elseif columns > title1 then
		titleString = MYBAGS_TITLE1
	else
		titleString = MYBAGS_TITLE0
	end
	titleString = titleString .. getglobal(string.upper(self.frameName) .. "_TITLE")
	local title = getglobal(self.frameName .. "Name")
   local player, realm = ace.SplitString(self:GetCurrentPlayer(), CHARACTER_DELIMITOR)
	title:SetText(format(titleString, player, realm))
end
function MyBagsCoreClass:SetFrameMode(mode)
	local frame = self.frame
	local frameName = self.frameName
	local textureTopLeft, textureTop, textureTopRight
	local textureLeft, textureCenter, textureRight
	local textureBottomLeft, textureBottom, textureBottomRight
	local texturePortrait
	local frameTitle
	local frameButtonBar = getglobal(frameName .. "Buttons")
	textureTopLeft     = getglobal(frameName .. "TextureTopLeft")
	textureTopCenter   = getglobal(frameName .. "TextureTopCenter")
	textureTopRight    = getglobal(frameName .. "TextureTopRight")

	textureLeft        = getglobal(frameName .. "TextureLeft")
	textureCenter      = getglobal(frameName .. "TextureCenter")
	textureRight       = getglobal(frameName .. "TextureRight")

	textureBottomLeft  = getglobal(frameName .. "TextureBottomLeft")
	textureBottomCenter= getglobal(frameName .. "TextureBottomCenter")
	textureBottomRight = getglobal(frameName .. "TextureBottomRight")
	texturePortrait    = getglobal(frameName .. "Portrait")
	frameTitle = getglobal(frameName .. "Name")
	frameTitle:ClearAllPoints()
	frameButtonBar:ClearAllPoints()
	if mode == "art" then
		frameTitle:SetPoint("TOPLEFT", frameName, "TOPLEFT", 70, -10)
		frameTitle:Show()
		frameButtonBar:Show()
		frameButtonBar:SetPoint("TOPRIGHT", frameName, "TOPRIGHT", 10, 0)
		frame:SetBackdropColor(0,0,0,0)
		frame:SetBackdropBorderColor(0,0,0,0)
		textureTopLeft:Show()
		textureTopCenter:Show()
		textureTopRight:Show()
		textureLeft:Show()
		textureCenter:Show()
		textureRight:Show()
		textureBottomLeft:Show()
		textureBottomCenter:Show()
		textureBottomRight:Show()
		texturePortrait:Show()
	else
		frameTitle:SetPoint("TOPLEFT", frameName, "TOPLEFT", 5, -6)
		frameButtonBar:SetPoint("TOPRIGHT", frameName, "TOPRIGHT", 0, 0)
		textureTopLeft:Hide()
		textureTopCenter:Hide()
		textureTopRight:Hide()
		textureLeft:Hide()
		textureCenter:Hide()
		textureRight:Hide()
		textureBottomLeft:Hide()
		textureBottomCenter:Hide()
		textureBottomRight:Hide()
		texturePortrait:Hide()
		if mode == "default" then
			local BackColor = self.GetOpt("BackColor") or {0.7,0,0,0}
			local a, r, g, b = unpack(BackColor)
			frame:SetBackdropColor(r,g,b,a)
			frame:SetBackdropBorderColor(1,1,1,a)
		else
			frame:SetBackdropColor(0,0,0,0)
			frame:SetBackdropBorderColor(0,0,0,0)
		end
	end
end
function MyBagsCoreClass:GetXY(row, col)
	return (self._LEFTOFFSET + (col * MYBAGS_COLWIDTH)),  (0 - self._TOPOFFSET - (row * MYBAGS_ROWHEIGHT))
end
function MyBagsCoreClass:LayoutBagFrame(bagFrame)
	local bagFrameName = bagFrame:GetName()
	local slot
	local itemBase = bagFrameName .. "Item"
	local bagButton = getglobal(bagFrameName .. "Bag")
	local texture, count, _, locked, quality, ammo
	local slotColor = ((self.GetOpt("SlotColor")) or MYBAGS_SLOTCOLOR)
	local ammoColor = ((self.GetOpt("AmmoColor")) or MYBAGS_AMMOCOLOR)
	local shardColor = ((self.GetOpt("ShardColor")) or MYBAGS_SHARDCOLOR)
	local enchantColor = ((self.GetOpt("EnchantColor")) or MYBAGS_ENCHANTCOLOR)
	local engColor = ((self.GetOpt("EngColor")) or MYBAGS_ENGINEERCOLOR)
	local herbColor = ((self.GetOpt("HerbColor")) or MYBAGS_HERBCOLOR)
	local keyringColor = ((self.GetOpt("KeyRingColor")) or MYBAGS_KEYRINGCOLOR)
	self.watchLock = nil

	texture, count, _, locked, _, specialty = self:GetInfo(bagFrame:GetID())
	bagFrame.size = ace.tonum(count)
	if bagButton and bagFrame:GetID() ~= BANK_CONTAINER then
		if not texture then _, texture = GetInventorySlotInfo("Bag0Slot")	end
		if not self.isLive or (self.isLive and self:IsBagSlotUsable(bagFrame:GetID())) then
			SetItemButtonTextureVertexColor(bagButton, 1.0, 1.0, 1.0)
			SetItemButtonDesaturated(bagButton, locked, 0.5, 0.5, 0.5)
		else
			SetItemButtonTextureVertexColor(bagButton, 1.0, 0.1, 0.1)
		end
		SetItemButtonTexture(bagButton, texture)
		if self.GetOpt("Bag") == "bar" then
			local col, row = 0, 0
			if self.GetOpt("Player") or self.GetOpt("Graphics") == "art" then row = 1 end
			if self.isBank then
				col = (self.GetOpt("Columns") - self.totalBags)/2
			else
				col = (self.GetOpt("Columns") - self.totalBags -.5)/2
			end
			if bagFrame:GetID() == KEYRING_CONTAINER then
				col = col + 5 - self.firstBag
			else
				col = col + bagFrame:GetID() - self.firstBag
			end
			bagButton:Show()
			bagButton:ClearAllPoints()
			bagButton:SetPoint("TOPLEFT", self.frameName, "TOPLEFT", self:GetXY(row, col))
		elseif self.GetOpt("Bag") == "before" then
			if self.curCol >= self.GetOpt("Columns") then
				self.curCol  = 0
				self.curRow = self.curRow + 1
			end
			bagButton:Show()
			bagButton:ClearAllPoints()
			bagButton:SetPoint("TOPLEFT", self.frameName, "TOPLEFT", self:GetXY(self.curRow,self.curCol))
			self.curCol = self.curCol + 1
		else
			bagButton:Hide()
		end
		if not self:IncludeBag(bagFrame:GetID()) or self.isBank then
			bagButton:SetChecked(nil)
		else
			bagButton:SetChecked(1)
		end
	end
--	local maxIndex = MYBAGS_MAXBAGSLOTS
--	if bagFrame.maxIndex then maxIndex = bagFrame.maxIndex end
	if bagFrame.size < 1 or not self:IncludeBag(bagFrame:GetID()) then
		bagFrame.size = 0
	else
		for slot = 1, bagFrame.size do
			local itemButton = getglobal(itemBase .. slot) or CreateFrame("Button", itemBase .. slot, bagFrame, "MyBagsItemButtonTemplate")
			itemButton:SetID(slot)
			if self.curCol >= self.GetOpt("Columns") then
				self.curCol = 0
				self.curRow = self.curRow + 1
			end
			itemButton:Show()
			itemButton:ClearAllPoints()
			itemButton:SetPoint("TOPLEFT", self.frame:GetName(), "TOPLEFT", self:GetXY(self.curRow, self.curCol))
			self.curCol = self.curCol + 1
			texture, count, id, locked, quality = self:GetInfo(bagFrame:GetID(), slot)
			if id and id ~= "" then itemButton.hasItem = 1
			else quality = nil end
			if self.isLive then
				local start,duration, enable = GetContainerItemCooldown(bagFrame:GetID(), slot)
				local cooldown = getglobal(itemButton:GetName() .. "Cooldown")
				CooldownFrame_SetTimer(cooldown,start,duration,enable)
				if duration>0 and enable==0 then
					SetItemButtonTextureVertexColor(itemButton, 0.4,0.4,0.4)
				end
			end
			SetItemButtonTexture(itemButton, (texture or ""))
			SetItemButtonCount(itemButton, count)
			SetItemButtonDesaturated(itemButton, locked, 0.5, 0.5, 0.5)
			if locked and locked ~= "" then
				itemButton:LockHighlight()
				self.watchLock =1
			else itemButton:UnlockHighlight() end
			if quality and self.GetOpt("Border") then
				SetItemButtonNormalTextureVertexColor(itemButton, ace.ColorConvertHexToDigit(quality))
			else
				SetItemButtonNormalTextureVertexColor(itemButton, unpack(slotColor))
				if (specialty == 1 or specialty == 2) then
					SetItemButtonNormalTextureVertexColor(itemButton, unpack(ammoColor))
				elseif specialty == 3 then
					SetItemButtonNormalTextureVertexColor(itemButton, unpack(shardColor))
				elseif specialty == 4 then
					SetItemButtonNormalTextureVertexColor(itemButton, unpack(enchantColor))
				elseif specialty == 5 then
					SetItemButtonNormalTextureVertexColor(itemButton, unpack(engColor))
				elseif specialty == 6 then
					SetItemButtonNormalTextureVertexColor(itemButton, unpack(herbColor))
				elseif bagFrame:GetID() == KEYRING_CONTAINER then
					SetItemButtonNormalTextureVertexColor(itemButton, unpack(keyringColor))
				end
			end
		end
	end
	if(bagFrame.size) then
		local slot = bagFrame.size + 1
		local itemButton = getglobal(itemBase .. slot) 
		while itemButton do
			itemButton:Hide()
			slot = slot + 1
			itemButton = getglobal(itemBase .. slot) 
		end
	end
end
function MyBagsCoreClass:LayoutFrame()
--	local time = GetTime()
--	if not self.frame or not self.frame:IsVisible() then return end
	if not self.frame:IsVisible() then return end
	self.isLive = self:IsLive()
	local bagBase = self.frameName .. "Bag"
	local bagIndex, bagFrame
	self.curRow, self.curCol = 0,0
	self:LayoutOptions()
	if self.isEquipment then
		self:LayoutEquipmentFrame(self)
	else
		if self.reverseOrder then
			if not self.isBank then
				bagFrame = getglobal(self.frameName .. "KeyRing")
				bagFrame:SetID(KEYRING_CONTAINER)
				self:LayoutBagFrame(bagFrame)
			end
			for bag = self.totalBags-1,0,-1  do
				bagFrame = getglobal(bagBase .. bag)
				if (bagFrame) then
					self:LayoutBagFrame(bagFrame)
				end
			end
			if self.isBank then
				bagFrame = getglobal(self.frameName .. "Bank")
				self:LayoutBagFrame(bagFrame)
			end
		else
			if self.isBank then
				bagFrame = getglobal(self.frameName .. "Bank")
				self:LayoutBagFrame(bagFrame)
			end
			for bag = 0, self.totalBags-1 do
				bagFrame = getglobal(bagBase .. bag)
				if (bagFrame) then
					self:LayoutBagFrame(bagFrame)
				end
			end
			if not self.isBank then
				bagFrame = getglobal(self.frameName .. "KeyRing")
				bagFrame:SetID(KEYRING_CONTAINER)
				self:LayoutBagFrame(bagFrame)
			end
		end
	end
	if self.curCol == 0 then self.curRow = self.curRow - 1 end
	self.frame:SetWidth(self._LEFTOFFSET + self._RIGHTOFFSET + self.GetOpt("Columns") * MYBAGS_COLWIDTH)
	self.frame:SetHeight(self._TOPOFFSET + self._BOTTOMOFFSET + (self.curRow + 1) * MYBAGS_ROWHEIGHT)
--	self:debug("LayoutFrame ".. GetTime()-time)
end
function MyBagsCoreClass:LayoutFrameOnEvent()
--	local time = GetTime()
	if event == "UNIT_INVENTORY_CHANGED" and arg1 ~= "player" then return end
	if event == "ITEM_LOCK_CHANGED" and not self.watchLock then return end
	if self.isLive then
		self:LayoutFrame()
	end
--	self:debug("LayoutFrameOnEvent "..event.." ".. GetTime()-time)
end
function MyBagsCoreClass:LockButton_OnClick()
	self.TogOpt("Lock")
	self:SetLockTexture()
end

function MyBagsCoreClass:SetLockTexture()
	local button = getglobal(self.frameName .. "ButtonsLockButtonNormalTexture")
	local texture = "Interface\\AddOns\\MyBags\\Skin\\LockButton-"
	if not self.GetOpt("Lock") then texture = texture .. "Un" end
	texture = texture .. "Locked-Up"
	button:SetTexture(texture)
	if self.GetOpt("Lock") and self.GetOpt("Graphics") == "none" then
--		self:debug("Mouse clicks pass through")
		self.frame:EnableMouse(nil)
	else
--		self:debug("Mouse clicks intercepted")
		self.frame:EnableMouse(1)
	end
end
function MyBagsCoreClass:SetFrozen()
	if self.GetOpt("Freeze") == "always" then
		self.Freeze = "always"
	elseif self.GetOpt("Freeze") == "sticky" then
		self.Freeze = "sticky"
	else
		self.Freeze = nil
	end
end
function MyBagsCoreClass:SetUISpecialFrames()
	if self.GetOpt("NoEsc") then
		for k,v in UISpecialFrames do
			if v == (self.frameName) then
				table.remove(UISpecialFrames, k)
			end
		end
	else
		table.insert(UISpecialFrames, self.frameName)
	end
end

--CHAT CMD OPTIONS {{{
function MyBagsCoreClass:SetColumns(cols)
	cols = ace.tonum(cols)

	if( (cols >= self.minColumns) and (cols <= self.maxColumns) ) then
		self.SetOpt("Columns", cols)
		self:LayoutFrame()
		--self.Result(ONEBAG_TEXT_COLS, cols)
	else
		--self.Result(ONEBAG_COLUMN_LIMIT_MSG, self.minColumns, self.maxColumns)
	end
end
function MyBagsCoreClass:SetReplace()
	self.TogMsg("Replace", "Replace default bags")
	self:LayoutFrame()
end
function MyBagsCoreClass:SetBagDisplay(opt)
	self.SetOpt("Bag", opt)
	self.Result("Bag Buttons", opt)
	self:LayoutFrame()
end
function MyBagsCoreClass:SetGraphicsDisplay(opt)
	local a, r, g, b
	opt, a, r, g, b = unpack(ace.ParseWords(opt))
--	self:debug("opt: |" .. opt .."| ")
	if opt ~= "default" and opt~="art" and opt~="none" then
		return
	end
	self.SetOpt("Graphics", opt)
	if a then
		self.SetOpt("BackColor", {ace.tonum(a), ace.tonum(r), ace.tonum(g), ace.tonum(b)})
	else
		self.SetOpt("BackColor")
	end
	self.Result("Background", opt)
	self:LayoutFrame()
end
function MyBagsCoreClass:SetHighlight(mode)
	if mode == "items" then
		self.TogMsg("HlItems", "Highlight")
	else
		self.TogMsg("HlBags", "Highlight")
	end
end
function MyBagsCoreClass:SetFreeze(opt)
	opt = strlower(opt)
	if opt == "freeze always" then opt = "always" end
	if opt == "freeze sticky" then opt = "sticky" end
	if opt == "freeze none" then opt = "none" end
	self.Result("Freeze", opt)
	self.SetOpt("Freeze", opt)
	self:SetFrozen()
end
function MyBagsCoreClass:SetNoEsc()
	self.TogMsg("NoEsc", "NoEsc")
	self:SetUISpecialFrames()
end
function MyBagsCoreClass:SetLock()
	self.TogMsg("Lock", "Lock")
	self:SetLockTexture()
end
function MyBagsCoreClass:SetTitle()
	self.TogMsg("Title", "Frame Title")
	self:LayoutFrame()
end
function MyBagsCoreClass:SetCash()
	self.TogMsg("Cash", "Money Display")
	self:LayoutFrame()
end
function MyBagsCoreClass:SetButtons()
	self.TogMsg("Buttons", "Frame Buttons")
	self:LayoutFrame()
end
function MyBagsCoreClass:SetAIOI()
	self.TogMsg("AIOI", "toggle partial row placement")
	self:LayoutFrame()
end
function MyBagsCoreClass:SetReverse()
	self.TogMsg("Reverse", "reverse bag ordering")
	self:LayoutFrame()
end
function MyBagsCoreClass:SetBorder()
	self.TogMsg("Border", "Quality Borders")
	self:LayoutFrame()
end
function MyBagsCoreClass:SetPlayerSel()
	if self:CanSaveItems() then
--		self:debug("CanSaveItems")
		self.TogMsg("Player", "Player selection")
	else
--		self:debug("Can'tSaveItems")
		self.SetOpt("Player")
	end
	self:LayoutFrame()
end
function MyBagsCoreClass:SetCount(mode)
	self.SetOpt("Count", mode)
	self.Result("Count", mode)
	self:LayoutFrame()
end
function MyBagsCoreClass:SetScale(scale)
	scale = ace.tonum(scale)
	if scale == 0 then
		self.SetOpt("Scale")
		self.frame:SetScale(self.frame:GetParent():GetScale())
		self.Result("Scale", ACEG_TEXT_DEFAULT)
	elseif (( scale < ace.tonum(MIN_SCALE_VAL)) or (scale > ace.tonum(MAX_SCALE_VAL))) then
		self.Error("Invalid Scale")
	else
		self.SetOpt("Scale", scale)
		self.frame:SetScale(scale)
		self.Result("Scale", scale)
	end
end
function MyBagsCoreClass:SetStrata(strata)
	strata = strupper(strata)
--	if strata =="BACKGROUND" or strata =="LOW" or strata =="MEDIUM" or strata =="HIGH" or strata =="DIALOG" or strata =="FULLSCREEN" or strata =="FULLSCREEN_DIALOG" or strata =="TOOLTIP" then
	if strata =="BACKGROUND" or strata =="LOW" or strata =="MEDIUM" or strata =="HIGH" or strata =="DIALOG" then
		self.SetOpt("Strata", strata)
		self.frame:SetFrameStrata(strata)
		self.Result("Strata", strata)
	else
		self.Error("Invalid strata")
	end
end
function MyBagsCoreClass:Report()
	self.cmd:report({
		{text="Columns", val=self.GetOpt("Columns")},
		{text="Graphics", val=self.GetOpt("Graphics")},
		{text="Lock", val=self.GetOpt("Lock"),map=ACEG_MAP_ONOFF},
		{text="NoEsc", val=self.GetOpt("NoEsc"),map=ACEG_MAP_ONOFF},
		{text="Title", val=self.GetOpt("Title"),map=ACEG_MAP_ONOFF},
		{text="Cash", val=self.GetOpt("Cash"),map=ACEG_MAP_ONOFF},
		{text="Buttons", val=self.GetOpt("Buttons"),map=ACEG_MAP_ONOFF},
		{text="Border", val=self.GetOpt("Border"),map=ACEG_MAP_ONOFF},
		{text="Player", val=self.GetOpt("Player"),map=ACEG_MAP_ONOFF},
		{text="AIOI", val=self.GetOpt("AIOI"),map=ACEG_MAP_ONOFF},
		{text="Scale", val=self.GetOpt("Scale")},
		{text="Strata", val=self.GetOpt("Strata")},
		{text="Anchor", val=self.GetOpt("Anchor")},
		{text="Default Slot Color", val=ace.concat(self.GetOpt("SlotColor") or MYBAGS_SLOTCOLOR," ")},
	})
	if not self.isEquipment then
		self.cmd:report({
			{text="Default Slot Color", val=ace.concat(self.GetOpt("SlotColor") or MYBAGS_SLOTCOLOR," ")},
			{text="Ammo Slot Color", val=ace.concat(self.GetOpt("AmmoColor") or MYBAGS_AMMOCOLOR," ")},
			{text="Soul Slot Color", val=ace.concat(self.GetOpt("SoulColor") or MYBAGS_SHARDCOLOR," ")},
			{text="Enchanting Slot Color", val=ace.concat(self.GetOpt("EnchantColor") or MYBAGS_ENCHANTCOLOR," ")},
			{text="Engineering Slot Color", val=ace.concat(self.GetOpt("EngColor") or MYBAGS_ENGINEERCOLOR," ")},
			{text="Herb Slot Color", val=ace.concat(self.GetOpt("HerbColor") or MYBAGS_HERBCOLOR," ")},
			{text="Replace", val=self.GetOpt("Replace"),map=ACEG_MAP_ONOFF},
			{text="Bag", val=self.GetOpt("Bag")},
			{text="HlItems", val=self.GetOpt("HlItems"),map=ACEG_MAP_ONOFF},
			{text="HlBags", val=self.GetOpt("HlBags"),map=ACEG_MAP_ONOFF},
			{text="Freeze", val=self.GetOpt("Freeze")},
			{text="Reverse", val=self.GetOpt("Reverse"),map=ACEG_MAP_ONOFF},
			{text="Count", val=self.GetOpt("Count")},
			{text="Anchor", val=self.GetOpt("Anchor")},
		})
		if not self.isBank then
			self.cmd:report({
				{text="Companion", val=self.GetOpt("Companion"),map=ACEG_MAP_ONOFF},
			})
		end
	end
end
function MyBagsCoreClass:ResetSettings()
	self.db:reset(self.profilePath, self.defaults)
	self.Error("Settings reset to default")
	self:ResetAnchor()
	self:SetLockTexture()
	self:SetUISpecialFrames()
	self:SetFrozen()
	self:LayoutFrame()
end
function MyBagsCoreClass:ResetAnchor()
	if not self:SetAnchor(self.defaults.Anchor) then return end
	anchorframe = self.frame:GetParent()
	anchorframe:ClearAllPoints()
	anchorframe:SetPoint(self.anchorPoint, self.anchorParent, self.anchorPoint, self.anchorOffsetX, self.anchorOffsetY)
	self.frame:ClearAllPoints()
	self.frame:SetPoint(self.anchorPoint, anchorframe, self.anchorPoint, 0, 0)
	self.Error("Anchor Reset")
end
function MyBagsCoreClass:SetAnchor(point)
	if     point == "topleft" then
	elseif point == "topright" then
	elseif point == "bottomleft" then
	elseif point == "bottomright" then
	else self.Error("Invalid Entry for Anchor") return end
	local anchorframe = self.frame:GetParent()
	local top = self.frame:GetTop()
	local left = self.frame:GetLeft()
	local top1 = anchorframe:GetTop()
	local left1 = anchorframe:GetLeft()
	if not top or not left or not left1 or not top1 then
		self.Error("Frame must be open to set anchor") return
	end
	self.frame:ClearAllPoints()
	anchorframe:ClearAllPoints()
	anchorframe:SetPoint(string.upper(point), self.frameName, string.upper(point), 0, 0)
	top = anchorframe:GetTop()
	left = anchorframe:GetLeft()
	if not top or not left then
		anchorframe:ClearAllPoints()
		anchorframe:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", left1, top1-10)
		point = string.upper(self.GetOpt("Anchor") or "bottomright")
		self.frame:SetPoint(point, anchorframe:GetName(), point, 0,0)
		self.Error("Frame must be open to set anchor") return
	end
	anchorframe:ClearAllPoints()
	anchorframe:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", left, top-10)
	self.frame:SetPoint(string.upper(point), anchorframe:GetName(), string.upper(point), 0, 0)
	self.SetOpt("Anchor", point)
	self.Result("Anchor", point)
	self.anchorPoint = string.upper(point)
	return TRUE
end
function MyBagsCoreClass:SetSpecialtyBagSlotColor(opt)
	local r, g, b
	opt, r, g, b = unpack(ace.ParseWords(opt))
--	self:debug("opt: |" .. opt .."| ")
	if opt == "default" then
		if r then
			self.SetOpt("SlotColor", { ace.tonum(r), ace.tonum(g), ace.tonum(b)})
		else
			self.SetOpt("SlotColor")
		end
	end
	if opt == "ammo" then
		if r then
			self.SetOpt("AmmoColor", { ace.tonum(r), ace.tonum(g), ace.tonum(b)})
		else
			self.SetOpt("AmmoColor")
		end
	end
	if opt == "soul" or opt == "shard" then
		if r then
			self.SetOpt("ShardColor", {ace.tonum(r), ace.tonum(g), ace.tonum(b)})
		else
			self.SetOpt("ShardColor")
		end
	end
	if opt == "enchant" then
		if r then
			self.SetOpt("EnchantColor", {ace.tonum(r), ace.tonum(g), ace.tonum(b)})
		else
			self.SetOpt("EnchantColor")
		end
	end
	if opt == "engineer" then
		if r then
			self.SetOpt("EngColor", {ace.tonum(r), ace.tonum(g), ace.tonum(b)})
		else
			self.SetOpt("EngColor")
		end
	end
	if opt == "herb" then
		if r then
			self.SetOpt("HerbColor", {ace.tonum(r), ace.tonum(g), ace.tonum(b)})
		else
			self.SetOpt("HerbColor")
		end
	end
	if opt == "keyring" then
		if r then
			self.SetOpt("KeyRingColor", {ace.tonum(r), ace.tonum(g), ace.tonum(b)})
		else
			self.SetOpt("KeyRingColor")
		end
	end
	self.Result("SlotColor", opt)
	self:LayoutFrame()
end
function MyBagsCoreClass:SetCompanion()
	if self.GetOpt("Companion") then
		self:UnregisterEvent("AUCTION_HOUSE_SHOW")
		self:UnregisterEvent("AUCTION_HOUSE_CLOSED")
		self:UnregisterEvent("BANKFRAME_OPENED")
		self:UnregisterEvent("BANKFRAME_CLOSED")
		self:UnregisterEvent("MAIL_CLOSED")
		self:UnregisterEvent("TRADE_CLOSED")
		self:UnregisterEvent("TRADE_SHOW")
	end
	self.TogMsg("Companion", "Companion")
	self:ChkCompanion()
end
function MyBagsCoreClass:ChkCompanion()
	if self.GetOpt("Companion") then
		self:RegisterEvent("AUCTION_HOUSE_SHOW","CompanionOpen")
		self:RegisterEvent("AUCTION_HOUSE_CLOSED","CompanionClose")
		self:RegisterEvent("BANKFRAME_OPENED","CompanionOpen")
		self:RegisterEvent("BANKFRAME_CLOSED","CompanionClose")
		self:RegisterEvent("MAIL_CLOSED","CompanionClose")
		self:RegisterEvent("TRADE_CLOSED","CompanionClose")
		self:RegisterEvent("TRADE_SHOW","CompanionOpen")
	end
end

