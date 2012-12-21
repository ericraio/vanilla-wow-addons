function KC_LW(frame,link)
	local self = KC_Tooltip

	self.fmerge = true
	self.curlink = link
	self.itemEntered = true
	self:DisplayInfo(frame, link, 1)
end

local locals = KC_ITEMS_LOCALS.modules.tooltip

local linkFuncs = {
	SetAuctionItem		= GetAuctionItemLink,
	SetBagItem			= GetContainerItemLink,
	SetCraftItem		= function(skill, id) return (id) and GetCraftReagentItemLink(skill, id) or GetCraftItemLink(skill) end,
	SetHyperlink		= function(link) return link end,
	SetInventoryItem	= function(type, slot) if (not this) then return end return (type) and GetInventoryItemLink(type, slot) or GetContainerItemLink(BANK_CONTAINER,this:GetID()) end,
	SetLootItem			= GetLootSlotLink,
	SetMerchantItem		= GetMerchantItemLink,
	SetQuestItem		= GetQuestItemLink,
	SetQuestLogItem		= GetQuestLogItemLink,
	SetTradePlayerItem	= GetTradePlayerItemLink,
	SetTradeSkillItem	= function(skill, id) return (id) and GetTradeSkillReagentItemLink(skill, id) or GetTradeSkillItemLink(skill) end,
	SetTradeTargetItem	= GetTradeTargetItemLink,
}

local qtyFuncs = {
	SetAuctionItem		= function(type, slot) local _,_,qty = GetAuctionItemInfo(type, slot); return qty; end,
	SetBagItem			= function(bag, slot) local _, qty = GetContainerItemInfo(bag, slot); return qty;  end,
	SetCraftItem		= function(skill, id) if (id) then local _, _, qty = GetCraftReagentInfo(skill, id); return qty else local info = KC_Items.common:GetItemInfo(KC_Items.common:GetCode(GetCraftItemLink(skill))); if (info) then return info["maxstack"] else return 1 end end end,
	SetHyperlink		= function() return 1 end,
	SetInventoryItem	= function(type, slot) if (not this) then return end if (type) then return GetInventoryItemCount(type, slot) else local _, qty = GetContainerItemInfo(BANK_CONTAINER,this:GetID()); return qty; end end,
	SetLootItem			= function(slot) local _,_, qty = GetLootSlotInfo(slot); return qty; end,
	SetMerchantItem		= function(id) local _,_,_, qty = GetMerchantItemInfo(id); return qty; end,
	SetQuestItem		= function(type, slot) local _,_, qty = GetQuestItemInfo(type, slot); return qty; end,
	SetQuestLogItem		= function(type, slot) return 1 end,
	SetTradePlayerItem	= function(id) local _,_, qty = GetTradeTargetItemInfo(id); return qty; end,
	SetTradeSkillItem	= function(skill, id) if (id) then local _, _, qty = GetTradeSkillReagentInfo(skill, id); return qty else local info = KC_Items.common:GetItemInfo(KC_Items.common:GetCode(GetTradeSkillItemLink(skill))); if (info) then return info["maxstack"] else return 1 end end end,
	SetTradeTargetItem	= function(id) local _,_, qty = GetTradeTargetItemInfo(id); return qty; end,
}


KC_Tooltip = KC_ItemsModule:new({
	type		 = "tooltip",
	name		 = locals.name,
	desc		 = locals.description,
	cmdOptions	 = locals.chat,
	dependencies = {"common"},
	optPath		 = {"tooltip", "options"},
})

KC_Items:Register(KC_Tooltip)

function KC_Tooltip:Enable()
	self:HookTooltips()
	
	if (IsAddOnLoaded('LinkWrangler')) then
		LINK_WRANGLER_CALLER['KC_Items'] = 'KC_LW'
	else
		self:Hook("SetItemRef")
	end

	self:Hook("GameTooltip_OnHide")
	self:Hook("GameTooltip_ClearMoney")
	self:HookScript(ItemRefTooltip, "OnHide", "ItemRefTooltip_OnHide")
end

function KC_Tooltip:GameTooltip_OnHide()
    self.Hooks["GameTooltip_OnHide"].orig()
	self:OnHide()
	KCTooltip:Hide()
	for i=1, 20 do
		getglobal("KCTooltipMoneyFrame" .. i):Hide()
		getglobal("GameTooltipMoneyFrame" .. i):Hide()
	end
end

function KC_Tooltip:ItemRefTooltip_OnHide()
    self.Hooks[ItemRefTooltip]["OnHide"].orig()
	self:OnHide()
	KCItemRef:Hide()
	for i=1, 20 do
		getglobal("KCItemRefMoneyFrame" .. i):Hide()
		getglobal("ItemRefTooltipMoneyFrame" .. i):Hide()
	end
end

function KC_Tooltip:OnHide()
    self.itemEntered = false
    self.priceAdded  = false
	self.sepneeded   = false
	self.showneeded  = false
end

function KC_Tooltip:GameTooltip_ClearMoney()
    self.Hooks["GameTooltip_ClearMoney"].orig()
    self.priceAdded = false
end

function KC_Tooltip:SetItemRef(link, text, button)
	self.Hooks["SetItemRef"].orig(link, text, button)
	if (not strfind(link, "item") or IsControlKeyDown() or IsShiftKeyDown()) then return; end

	if (self.curlink == link) then
		KCItemRef:Hide()
		self.curlink = nil
	else
		self.curlink = link
		self.itemEntered = true
		self:DisplayInfo(ItemRefTooltip, link, 1)
	end
end

function KC_Tooltip:HookTooltips()
	for key, value in linkFuncs do
     	local orig, linkFunc = key,value
		local qtyFunc = qtyFuncs[key]

		local func = function(tooltip,a,b,c)
			local r1,r2,r3 = self.Hooks[tooltip][orig].orig(tooltip,a,b,c)
			self.itemEntered = true
			self:DisplayInfo(tooltip,linkFunc(a,b,c),qtyFunc(a,b,c))
			return r1,r2,r3
		end
		self:Hook(GameTooltip,orig,func)
	end
end

function KC_Tooltip:DisplayInfo(tooltip, link, qty)
	if( (not self.itemEntered) or self.priceAdded or not tooltip or not link or not self._funcs) then return end

	local mode  = self:GetOpt(self.optPath, "separated")
	local sep   = self:GetOpt(self.optPath, "separator")
	local code  = self.common:GetCode(link)
	local lcode = self.common:GetCode(link, true)
	local info  = self.common:GetItemInfo(code)
	local moneyframe = self:GetOpt(self.optPath, "moneyframe")
	local targetTooltip
 
	if (mode and not self.fmerge) then
		targetTooltip = (tooltip == GameTooltip) and KCTooltip or KCItemRef
		targetTooltip:ClearLines()
		targetTooltip:SetScale(1)
		targetTooltip:SetOwner(tooltip, "ANCHOR_NONE")
		targetTooltip:SetPoint("TOPLEFT", tooltip, "BOTTOMLEFT")
		targetTooltip:AddLine(format("%s x %s", info["name"] or "", qty)) 
	else 
		targetTooltip = tooltip
		self.sepneeded = true
	end

	for i = 1, 20 do
		getglobal("KCTooltipMoneyFrame" .. i):Hide()
		getglobal("KCItemRefMoneyFrame" .. i):Hide()
		getglobal("GameTooltipMoneyFrame" .. i):Hide()
		getglobal("ItemRefTooltipMoneyFrame" .. i):Hide()
	end

	for index, func in self._funcs do
		if (sep and self.sepneeded) then targetTooltip:AddLine(" ", 0, 0, 0); self.sepneeded = false end
		self.sepneeded = false
		func(targetTooltip, code, lcode, qty, self)
		if (sep and self.sepneeded) then targetTooltip:AddLine(" ", 0, 0, 0); self.sepneeded = false end
	end

	if (self.showneeded) then targetTooltip:Show();	self.showneeded = false; end


	if (moneyframe and targetTooltip:GetWidth() < (self.mWidth or 0)) then
		targetTooltip:SetWidth(self.mWidth or 0)
		self.mWidth = nil
	end
	if (mode and targetTooltip:GetWidth() < tooltip:GetWidth()) then
		targetTooltip:SetWidth(tooltip:GetWidth())
	end
	
	self.fmerge = nil
end

function KC_Tooltip:RegisterFunc(addon, func)
	if (not self._funcs) then self._funcs = {}; end
	self._funcs[tostring(addon) .. "->" .. func] = ace:call(addon,func)
end

function KC_Tooltip:UnregisterFunc(addon, func)
	if (not self._funcs) then return end
	self._funcs[tostring(addon) .. "->" .. func] = nil
end

function KC_Tooltip:AddPriceLine(tooltip, amt, label, sep, sepcolor)
	local splitline  = self:GetOpt(self.optPath, "splitline")
	local moneyframe = self:GetOpt(self.optPath, "moneyframe")
	local pricetext  = self.common:CashTextLetters(amt)
	
	if (moneyframe and not self.fmerge) then
		tooltip:AddDoubleLine(label, " ", 1, 1, 1, 1, 1, 1)

		local numLines = tooltip:NumLines()
		local moneyFrame = getglobal(tooltip:GetName() .. "MoneyFrame" .. numLines)
		moneyFrame:SetPoint("RIGHT", tooltip:GetName(), "RIGHT", 0, 0)
		moneyFrame:SetPoint("TOP", tooltip:GetName() .. "TextLeft".. numLines, "TOP", 0, 0)
		moneyFrame:Show()
		MoneyFrame_Update(moneyFrame:GetName(), floor(amt))
		
		local width = moneyFrame:GetWidth() + getglobal(tooltip:GetName() .. "TextLeft".. numLines):GetWidth() + 25
		self.mWidth = width > (self.mWidth or 0) and width or self.mWidth
	elseif (splitline) then
		tooltip:AddDoubleLine(label, pricetext, 1, 1, 1, 1, 1, 1)
	else		
		sep = ace.trim(sep or ""); sep = format(" %s%s |r", sepcolor, sep)
		tooltip:AddLine(format("%s%s%s", label, sep, pricetext), 1, 1, 1)
	end

	self.sepneeded  = true
	self.showneeded = true
end

function KC_Tooltip:AddTextLine(tooltip, left, right, sep, sepcolor)
	local splitline = self:GetOpt(self.optPath, "splitline")

	if (splitline) then
		tooltip:AddDoubleLine(left, right, 1, 1, 1, 1, 1, 1)
	else
		sep = ace.trim(sep or ""); sep = format(" %s%s |r", sepcolor or "", sep or "")
		tooltip:AddLine(format("%s%s%s", left, sep, right or ""), 1, 1, 1);
	end
	
	local numLines = tooltip:NumLines()
	local width = getglobal(tooltip:GetName() .. "TextRight".. numLines):GetWidth() + getglobal(tooltip:GetName() .. "TextLeft".. numLines):GetWidth() + 25
	self.mWidth = width > (self.mWidth or 0) and width or self.mWidth

	self.sepneeded  = true
	self.showneeded = true
end
