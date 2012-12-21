local locals = KC_ITEMS_LOCALS.modules.common

local frame = AceGUI:new()
local config = {
	name		= "KC_ItemsStatsFrame",
	type		= ACEGUI_BASIC_DIALOG,
	backdrop	= "none",
	width		= 175,
	height		= 65,
	OnShow		= "OnShow",
	elements	= {
		P	 = {
			type	 = ACEGUI_OPTIONSBOX,
			title	 = "",
			width	 = 175,
			height	 = 65,
			anchors	 = {
				topleft	= {xOffset = 0, yOffset = 0}
			},
			elements = {
				Line1 = {
					type	= ACEGUI_FONTSTRING, 
					value   = "",
					anchors	 = {
						clear = TRUE,
						topleft = {relTo = "KC_ItemsStatsFrameP", relPoint= "topleft", xOffset = 10, yOffset = -9},
					},
				},
				Line2 = {
					type	= ACEGUI_FONTSTRING, 
					value   = "",
					anchors	 = {
						clear = TRUE,
						topleft = {relTo = "KC_ItemsStatsFramePLine1", relPoint= "bottomleft", xOffset = 0, yOffset = -3},
					},
				},
				Line3 = {
					type	= ACEGUI_FONTSTRING, 
					value   = "",
					anchors	 = {
						clear = TRUE,
						topleft = {relTo = "KC_ItemsStatsFramePLine2", relPoint= "bottomleft", xOffset = 0, yOffset = -3},
					},
				},
			}
		}
	}		
}

function frame:OnShow()
	self:RefreshStats()
end

function frame:RefreshStats()
	if (not self.P:IsVisible()) then return end

	local sItemCount, sSubCount, sSellCount, sBuyCount, sSellPercent, sBuyPercent = self.app:Explode(self.app.app.db:get("stats"), ",")
	if (type(sSellPercent) == "string") then return end

	self.P.Line1:SetValue(format("Item Count: \t%s", sSubCount))
	self.P.Line2:SetValue(format("Sell Values: \t%s (%s%%)", floor(sSubCount * (sSellPercent/100)), sSellPercent))
	self.P.Line3:SetValue(format("Buy Values: \t%s (%s%%)", floor(sSubCount * (sBuyPercent/100)), sBuyPercent))

	local width = math.max(self.P.Line1:GetWidth(), self.P.Line3:GetWidth(), self.P.Line2:GetWidth())

	self:SetWidth(width + 20)
	self.P:SetWidth(width + 20)
end

frame:Initialize(KC_Common, config)
KC_Common.frame = frame