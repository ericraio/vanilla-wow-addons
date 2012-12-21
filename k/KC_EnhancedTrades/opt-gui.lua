--$Id: opt-gui.lua 2106 2006-05-24 03:47:06Z kaelten $
local locals = KC_ET_LOCALS
local tablet = TabletLib:GetInstance('1.0')


KC_EnhancedTrades.opt = {}
local opt = KC_EnhancedTrades.opt

opt.frame = AceGUI:new()

opt.config = {
	name	  = "KC_EnhancedTradesConfigFrame",
	type	  = ACEGUI_DIALOG,
	title	  = "EnhancedTrades Options",
	isSpecial = TRUE,
	width	  = 275,
	height	  = 290,
	OnShow	  = "OnShow",
	OnHide	  = "OnHide",
	anchors	 = {
		topright = {relPoint = "topright", xOffset = 0, yOffset = 0}
	},
	elements = {
		Toggle = {
			type     = ACEGUI_CHECKBOX,
			title    = "Enable KC_EnhancedTrades",
			disabled = FALSE,
			OnClick	 = "ToggleEnable",
			width	 = 26,
			height	 = 26,
			anchors	 = {
				topleft = {xOffset = 37, yOffset = -35}
			},
		},
		ShowLegend = {
			type     = ACEGUI_CHECKBOX,
			title    = "Show Legend",
			disabled = FALSE,
			OnClick	 = "ChangeOpt",
			width	 = 26,
			height	 = 26,
			anchors	 = {
				topleft = {relTo = "$parentToggle", relPoint = "bottomleft", xOffset = 0, yOffset = 0}
			},
		},
		Smart = {
			type     = ACEGUI_CHECKBOX,
			title    = "Use Smart Display",
			disabled = FALSE,
			OnClick	 = "ChangeOpt",
			width	 = 26,
			height	 = 26,
			anchors	 = {
				topleft = {relTo = "$parentShowLegend", relPoint = "bottomleft", xOffset = 0, yOffset = 0}
			},
		},
		ShowIv = {
			type     = ACEGUI_CHECKBOX,
			title    = "Show Inv + Vendor",
			disabled = FALSE,
			OnClick	 = "ChangeOpt",
			width	 = 26,
			height	 = 26,
			anchors	 = {
				topleft = {relTo = "$parentSmart", relPoint = "bottomleft", xOffset = 0, yOffset = -20}
			},
		},
		ShowIb = {
			type     = ACEGUI_CHECKBOX,
			title    = "Show Inv + Bank",
			disabled = FALSE,
			OnClick	 = "ChangeOpt",
			width	 = 26,
			height	 = 26,
			anchors	 = {
				topleft = {relTo = "$parentShowIv", relPoint = "bottomleft", xOffset = 0, yOffset = 0}
			},
		},
		ShowIvb = {
			type     = ACEGUI_CHECKBOX,
			title    = "Show Inv + Vendor + Bank ",
			disabled = FALSE,
			OnClick	 = "ChangeOpt",
			width	 = 26,
			height	 = 26,
			anchors	 = {
				topleft = {relTo = "$parentShowIb", relPoint = "bottomleft", xOffset = 0, yOffset = 0}
			},
		},
		ShowIvba = {
			type     = ACEGUI_CHECKBOX,
			title    = "Show Inv + Vendor + Bank + Alts",
			disabled = FALSE,
			OnClick	 = "ChangeOpt",
			width	 = 26,
			height	 = 26,
			anchors	 = {
				topleft = {relTo = "$parentShowIvb", relPoint = "bottomleft", xOffset = 0, yOffset = 0}
			},
		},
		
	}
}

function opt.frame:OnShow()
	self:UpdateAnchor()
	self:RegisterHints()
	self:FillSettings()
end

function opt.frame:FillSettings()
	self.Toggle:SetValue(not self.app.disabled)
	self.ShowLegend:SetValue(self.app:GetOpt({"trades", "options"}, 1))
	self.Smart:SetValue(self.app:GetOpt({"trades", "options"}, 2))
	self.ShowIv:SetValue(self.app:GetOpt({"trades", "options"}, 3))
	self.ShowIb:SetValue(self.app:GetOpt({"trades", "options"}, 4))
	self.ShowIvb:SetValue(self.app:GetOpt({"trades", "options"}, 5))
	self.ShowIvba:SetValue(self.app:GetOpt({"trades", "options"}, 6))

end

function opt.frame:RegisterHints()
	local frames = {
		[0] = KC_EnhancedTradesConfigFrameToggle,
		[1] = KC_EnhancedTradesConfigFrameShowLegend,
		[2] = KC_EnhancedTradesConfigFrameSmart,
		[3] = KC_EnhancedTradesConfigFrameShowIv,
		[4] = KC_EnhancedTradesConfigFrameShowIb,
		[5] = KC_EnhancedTradesConfigFrameShowIvb,
		[6] = KC_EnhancedTradesConfigFrameShowIvba,
	}

	for i = 0, 6 do
		local id = i
		tablet:Register(frames[id], 'children', function() tablet:SetTitle(locals.titles[id]) tablet:SetHint(locals.hints[id]) end, 'data', {},  'point', function() return "TOPRIGHT", "TOPLEFT" end)	
	end
end

function opt.frame:UpdateAnchor()
	local frame

	if (CraftFrame and CraftFrame:IsVisible()) then
		frame = CraftFrame
	elseif (TradeSkillFrame and TradeSkillFrame:IsVisible()) then
		frame = TradeSkillFrame
	else
		self:Hide()
		return
	end

	self.topUnit:ApplyAnchors({topleft = {relTo = frame:GetName(), relPoint = "topright", xOffset = 0, yOffset = -35}}, true)	
end

function opt.frame:ToggleEnable()
	self.app:Toggle()
end

function opt.frame:ChangeOpt()
	self.app:TogOpt({"trades", "options"}, this:GetID())
	this:SetValue(self.app:GetOpt({"trades", "options"}, this:GetID()))
	
	if (this:GetID() == 1) then
		if (self.app.Hooks["TradeSkillFrame_Update"]) then
			self.app:Update()
		end

		if (self.app.Hooks["CraftFrame_Update"]) then
			self.app:Update(true)
		end	
	end

	if (this:GetID() > 1) then
		self.app.cache = nil
		self.app:Msg("The complete Datacache has been purged due to options change.")		
		
		self.app:BuildLegend()

		if (self.app.Hooks["TradeSkillFrame_Update"]) then
			self.app:Update()
		end

		if (self.app.Hooks["CraftFrame_Update"]) then
			self.app:Update(true)
		end

		if (self.app.Hooks["TradeSkillFrame_SetSelection"]) then
			self.app:SetSelection(self.app.tsfid)
		end

		if (self.app.Hooks["CraftFrame_SetSelection"]) then
			self.app:SetSelection(self.app.cfid, true)
		end
	end
end