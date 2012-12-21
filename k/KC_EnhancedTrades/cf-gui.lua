--$Id: cf-gui.lua 2106 2006-05-24 03:47:06Z kaelten $
local locals = KC_ET_LOCALS
local tablet = TabletLib:GetInstance('1.0')

KC_EnhancedTrades.cf = {}
local cf = KC_EnhancedTrades.cf

cf.frame = AceGUI:new()

cf.config = {
	name = "CF_",
	elements = {
		ClearButton   = {
			type     = ACEGUI_BUTTON,
			title    = "Clear Cache",
			disabled = FALSE,
			OnClick	 = "ClearClick",
			width	 = 120,
			height	 = 22,
			anchors	 = {
				right = {
					relTo	 = "CF_OptionsButton",
					relPoint = "left",
					xOffset	 = 5,
					yOffset	 = 0,
				}
			},
		},
		OptionsButton   = {
			type     = ACEGUI_BUTTON,
			title    = "Craft Option",
			disabled = FALSE,
			OnClick	 = "OptionsClick",
			width	 = 135,
			height	 = 22,
			anchors	 = {
				bottomright = {
					relTo	 = "CraftCancelButton",
					relPoint = "topleft",
					xOffset	 = 0,
					yOffset	 = 1,
				}
			},
		},
	},
}

function cf.frame:SetParents()
	CF_ClearButton:RegisterForClicks("LeftButtonDown", "RightButtonDown")
	CF_ClearButton:SetParent("CraftFrame")
	CF_OptionsButton:SetParent("CraftFrame")

	tablet:Register(CF_ClearButton, 'children', function() tablet:SetTitle("Clear Cache") tablet:SetHint("Left-Click to clear cache for the item.\nRight-Click to clear entire cache.") end, 'data', {},  'point', function() return "TOPLEFT", "TOPRIGHT" end)
	tablet:Register(CF_OptionsButton, 'children', function() tablet:SetTitle("Options") tablet:SetHint("Opens the options frame.") end, 'data', {},  'point', function() return "TOPLEFT", "TOPRIGHT" end)
end

function cf.frame:ClearClick()
	if (arg1 == "LeftButton") then
		local skillName = GetCraftInfo(self.app.cfid)
		self.app.cache[skillName] = nil
		self.app:Msg(format("The Datacache for \"%s\" has been purged.", skillName))
	elseif (arg1 == "RightButton") then
		self.app.cache = nil
		self.app:Msg("The complete Datacache has been purged.")
	end

	self.app:Update(true)
end

function cf.frame:OptionsClick()
	self.app.opt.frame:Initialize(self.app, self.app.opt.config)
	self.app.opt.frame:Show()
end