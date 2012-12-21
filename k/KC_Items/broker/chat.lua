local locals = KC_ITEMS_LOCALS.modules.broker
local map = KC_ITEMS_LOCALS.maps.enabled

function KC_Broker:SetCut(amount)
	if (strfind(amount, "%%")) then
		local _, _, number = strfind(amount, "(%d+)%%")
		self:SetOpt(self.optPath, "cut", number / 100)
	elseif (tonumber(amount)) then
		local number = tonumber(amount)
		_ = number > 0 and self:SetOpt(self.optPath, "cut", number)
	else
		self:Msg(locals.errors.amount)
		return
	end

	self:Result(locals.msgs.amount, amount);
end

function KC_Broker:TogAutofill()
	local status = self:TogOpt(self.optPath, "autofill");
	
	if (AuctionFrame and status) then
		self:RegisterEvent("NEW_AUCTION_UPDATE", "AutoFill")
		self:Hook("StartAuction", "Remember")
	elseif (AuctionFrame) then
		self:UnregisterEvent("NEW_AUCTION_UPDATE")
		self:Unhook("StartAuction")
		AuctionsItemText:SetText(self.AuctionsItemText)
	end

	self:Result(locals.msgs.autofill, status, map);
end

function KC_Broker:RememberDuration()
	local status = self:TogOpt(self.optPath, "remduration")
	
	if (AuctionFrame and status) then
		self:Hook("AuctionsRadioButton_OnClick", "UpdateDuration")
		AuctionsRadioButton_OnClick(self:GetOpt(self.optPath, "duration"))
	elseif (AuctionFrame) then
		self:Unhook("AuctionsRadioButton_OnClick")
	end

	self:Result(locals.msgs.remduration, status, map)
end

function KC_Broker:SkipMem()
	local status = self:TogOpt(self.optPath, "skipmem")
	self:Result(locals.msgs.skipmem, status, map)
end

function KC_Broker:SetMode(mode)
	mode = self.common:StrMixed(mode)

	if (strfind(locals.modes.all, mode)) then
		self:SetOpt(self.optPath, "fillmode", ace.trim(mode))
		self:Result(locals.msgs.mode, mode);
	else
		self:Msg(locals.errors.mode)
	end
end

function KC_Broker:AHColor()
	local status = self:TogOpt(self.optPath, "ahcolor")
	
	if (AuctionFrame and status) then
		self:Hook("AuctionFrameBrowse_Update")
		self:UpdateGuide()
		BrowseTitle:SetPoint("TOP",35 , -18)
		BrowseTitle:SetText( format("%s  -  %s", self.BrowseTitle or BrowseTitle:GetText(), locals.labels.guide))	
	elseif (AuctionFrame) then
		self:Unhook("AuctionFrameBrowse_Update")
		BrowseTitle:SetText(self.BrowseTitle)
	end

	self:Result(locals.msgs.ahcolor, status, map)
end

function KC_Broker:SetAHColor(color, name)
	local r, g, b = self.common:Explode(color, " ")
	if (not r or not g or not b) then self:Msg(locals.errors.color) return; end

	r = self.common:Round(r / 255, 1)
	g = self.common:Round(g / 255, 1)
	b = self.common:Round(b / 255, 1)

	self:SetOpt(self.optPath, name, format("%s!%s!%s", r, g, b))
	self:UpdateGuide()	
	_ = BrowseTitle and BrowseTitle:SetText( format("%s  -  %s", self.BrowseTitle, locals.labels.guide))

	local c = {self.common:Explode(self:GetOpt(self.optPath, name), "!")}
	local hex = self.common:GetHexCode(c[1], c[2], c[3], true)
	
	self:Msg(format(locals.msgs.colorcode, name, hex))
end

function KC_Broker:SetKnownColor(color)
	self:SetAHColor(color, "knownColor")
end

function KC_Broker:SetVendorColor(color)
	self:SetAHColor(color, "sellColor")
end

function KC_Broker:SetBuyColor(color)
	self:SetAHColor(color, "buyColor")
end

function KC_Broker:SetMinColor(color)
	self:SetAHColor(color, "minColor")
end