local locals = KC_ITEMS_LOCALS.modules.auction
KC_Auction.gui = {}
local gui = KC_Auction.gui

gui.frame = AceGUI:new()

gui.filtertemplate = {
	type     = ACEGUI_CHECKBOX,
	title    = "",
	disabled = FALSE,
	OnClick	 = "FilterClick",
	width	 = 20,
	height	 = 20,
	anchors	 = {
		right = {
			relPoint = "right",
			xOffset	 = -5,
			yOffset	 = 0,
		}
	}
}

gui.config = {
	name = "KC_Auction_",
	elements = {
		ScanButton   = {
			type     = ACEGUI_BUTTON,
			title    = locals.labels.scan,
			disabled = FALSE,
			OnClick	 = "ScanClick",
			width	 = 80,
			height	 = 22,
			anchors	 = {
				right = {
					relTo	 = "BrowseBidButton",
					relPoint = "left",
					xOffset	 = 0,
					yOffset	 = 0,
				}
			},
		},
		FilterChk0 = {
			type     = ACEGUI_CHECKBOX,
			title    = locals.labels.all,
			disabled = FALSE,
			OnClick	 = "FilterAllClick",
			width	 = 20,
			height	 = 20,
			anchors	 = {
				bottom = {
					relTo	 = "KC_Auction_FilterChk1",
					relPoint = "top",
					xOffset	 = -8,
					yOffset	 = 3,
				}
			}
		},
		FilterChk1   = gui.filtertemplate,
		FilterChk2   = gui.filtertemplate,
		FilterChk3   = gui.filtertemplate,
		FilterChk4   = gui.filtertemplate,
		FilterChk5   = gui.filtertemplate,
		FilterChk6   = gui.filtertemplate,
		FilterChk7   = gui.filtertemplate,
		FilterChk8   = gui.filtertemplate,
		FilterChk9   = gui.filtertemplate,
		FilterChk10   = gui.filtertemplate,
		FilterChk11   = gui.filtertemplate,
		FilterChk12   = gui.filtertemplate,
		FilterChk13   = gui.filtertemplate,
		FilterChk14   = gui.filtertemplate,
		FilterChk15   = gui.filtertemplate,
	}
}

function gui.frame:SetParents()
	KC_Auction_ScanButton:SetParent("AuctionFrameBrowse");
	KC_Auction_FilterChk0:SetParent("AuctionFilterButton1")
	KC_Auction_FilterChk1:SetParent("AuctionFilterButton1")
	KC_Auction_FilterChk2:SetParent("AuctionFilterButton2")
	KC_Auction_FilterChk3:SetParent("AuctionFilterButton3")
	KC_Auction_FilterChk4:SetParent("AuctionFilterButton4")
	KC_Auction_FilterChk5:SetParent("AuctionFilterButton5")
	KC_Auction_FilterChk6:SetParent("AuctionFilterButton6")
	KC_Auction_FilterChk7:SetParent("AuctionFilterButton7")
	KC_Auction_FilterChk8:SetParent("AuctionFilterButton8")
	KC_Auction_FilterChk9:SetParent("AuctionFilterButton9")
	KC_Auction_FilterChk10:SetParent("AuctionFilterButton10")
	KC_Auction_FilterChk11:SetParent("AuctionFilterButton11")
	KC_Auction_FilterChk12:SetParent("AuctionFilterButton12")
	KC_Auction_FilterChk13:SetParent("AuctionFilterButton13")
	KC_Auction_FilterChk14:SetParent("AuctionFilterButton14")
	KC_Auction_FilterChk15:SetParent("AuctionFilterButton15")
end

function gui.frame:OnLoad()
	self.filters = {self.app.common:Explode(self.app:GetOpt({"options"}, "filters"), ",")}
	self:UpdateChks()
	
	self:Hook("AuctionFrameFilter_OnClick", function () self.Hooks.AuctionFrameFilter_OnClick.orig(); self:UpdateChks()	end);
	self:Hook("AuctionFrameFilters_Update", function () self.Hooks.AuctionFrameFilters_Update.orig(); self:UpdateChks()	end);	
end

function gui.frame:FilterClick()
	self.filters[this:GetID()] = (self.filters[this:GetID()] == 1) and 0 or 1
	this:SetChecked(self.filters[this:GetID()])
	self:UpdateAllChk()
end

function gui.frame:FilterAllClick()
	for i = 1, 10 do
		self.filters[i] = (this:GetChecked() == 1) and 1 or 0
	end
	self:SaveFilters()
	self:UpdateChks()
end

function gui.frame:ScanClick()
	if (self.scanning) then
		self.ScanButton:SetValue(locals.labels.scan);
		self.scanning = false;
		self.app:ScanCanceled();
	else 
		self.ScanButton:SetValue(locals.labels.stopscan);
		self.scanning = true;
		self.app:Scan();
	end
end

function gui.frame:UpdateAllChk()
	self:SaveFilters()
	self.FilterChk0:SetChecked(not strfind(self.app:GetOpt({"options"}, "filters"), "0") and 1)	
end

function gui.frame:UpdateChks()
	for i = 1, 15 do
		local button = getglobal("AuctionFilterButton" .. i)
		local chk = self["FilterChk" .. i]
		if (not button:IsVisible() or button.type ~= "class") then
			chk:Hide()
		else
			chk:Show()
			chk:SetID(button.index)
			chk:SetChecked(self.filters[button.index])
		end
	end
	self:UpdateAllChk()
end

function gui.frame:SaveFilters()
	self.app:SetOpt({"options"}, "filters", format("%d,%d,%d,%d,%d,%d,%d,%d,%d,%d", unpack(self.filters)))
end