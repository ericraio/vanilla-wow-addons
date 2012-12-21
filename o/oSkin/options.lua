
function oSkin:Defaults()
	self:RegisterDefaults("profile", {
		BackdropBorder	= {r = 0.5, g = 0.5, b = 0.5, a = 1},
		Backdrop		= {r = 0, g = 0, b = 0, a = 0.9},

		CharacterFrames = true,
		PetStableFrame	= true,
		SpellBookFrame  = true,
		TalentFrame		= true,

		Inspect			= true,
		FriendsFrame	= true,
		TradeFrame		= true,
		QuestLog		= true,

		Tooltips		= true,
		MirrorTimers	= true,
		CastingBar		= true,
		StaticPopups	= true,
		ChatTabs		= false,
		ChatFrames		= false,
		ChatEditBox		= true,
		LootFrame		= true,
		GroupLoot		= {shown=true, small=false},
		ContainerFrames	= true,
		StackSplit		= true,
		ItemText		= true,
		WorldMap		= true,

		MenuFrames		= true,
		BankFrame       = true,
		MailFrame		= true,
		AuctionFrame	= true,

		MerchantFrames	= true,
		GossipFrame		= true,
		ClassTrainer	= true,
		TradeSkill		= true,
		CraftFrame		= true,
		TaxiFrame		= true,
		QuestFrame		= true,
		Battlefields	= true,

		ViewPort		= {top = 64, bottom=64, YResolution=1050, scaling = 768/1050, shown=false},
		TopFrame		= {height = 64, width=1920, shown=false, fheight=50, xyOff = true},
		BottomFrame		= {height = 200, width=1920, shown=false, fheight=50, xyOff = true},
	})
	
end

function oSkin:SetBackdrop(a1, a2, a3, a4)
	if (type(a1) == "string") then
		local _, _, r, g, b, a = string.find(a1, "([%d%.]+) ([%d%.]+) ([%d%.]+) ([%d%.]+)")
		r = tonumber(r)
		g = tonumber(g)
		b = tonumber(b)
		a = tonumber(a)

		if (not a or not b or not r or not g) then return end
		if (a > 255 or b > 255 or r > 255 or g > 255) then return end

		if (g > 1) then g = (g or 0) / 255 end
		if (r > 1) then r = (r or 0) / 255 end
		if (b > 1) then b = (b or 0) / 255 end
		if (a > 1) then a = (a or 0) / 255 end

		self:SetBackdrop(r, g, b, a)
	elseif (type(a1) == "number") then
		if (not a2) then a2 = 0 end
		if (not a3) then a3 = 0 end
		if (not a4) then a4 = 0.9 end

		if (not self.db.profile.Backdrop) then self.db.profile.Backdrop = {} end
		self.db.profile.Backdrop.r = a1
		self.db.profile.Backdrop.g = a2
		self.db.profile.Backdrop.b = a3
		self.db.profile.Backdrop.a = a4
	end
end

function oSkin:GetBackdrop()
    return string.format("%0.2f %0.2f %0.2f %0.2f", self.db.profile.Backdrop.r, self.db.profile.Backdrop.g, self.db.profile.Backdrop.b, self.db.profile.Backdrop.a)
end

function oSkin:Options()
	oSkin.options = {
		type = "group",
		args = {
			backdrop = {
				type = "text",
				name = "Backdrop Colors",
				desc = "Set Backdrop Colors",
				usage = "r g b a",
				get = function() return self:GetBackdrop() end,
				set = function(v) self:SetBackdrop(v) end,
			},

			character = {
				name = "Character Frames",
				type = "toggle",
				desc = "Toggle the skin of the Character Frames",
				get = function()
					return self.db.profile.CharacterFrames
				end,
				set = function(v)
					self.db.profile.CharacterFrames = v
					self:characterFrames()
				end,
			},
			stable = {
				name = "Stable Frame",
				type = "toggle",
				desc = "Toggle the skin of the Stable Frame",
				get = function()
					return self.db.profile.PetStableFrame
				end,
				set = function(v)
					self.db.profile.PetStableFrame = v
					self:PetStableFrame()
				end,
			},
			spellbook = {
				name = "SpellBook Frame",
				type = "toggle",
				desc = "Toggle the skin of the SpellBook Frame",
				get = function()
					return self.db.profile.SpellBookFrame
				end,
				set = function(v)
					self.db.profile.SpellBookFrame = v
					self:SpellBookFrame()
				end,
			},
			talent = {
				name = "Talent Frame",
				type = "toggle",
				desc = "Toggle the skin of the Talent Frame",
				get = function()
					return self.db.profile.TalentFrame
				end,
				set = function(v)
					self.db.profile.TalentFrame = v
					self:TalentFrame()
				end,
			},

			inspect = {
				name = "Inspect Frame",
				type = "toggle",
				desc = "Toggle the skin of the Inspect Frame",
				get = function()
					return self.db.profile.Inspect
				end,
				set = function(v)
					self.db.profile.Inspect = v
					self:InspectFrame()
					if IsAddOnLoaded("SuperInspect_UI") then self:SuperInspectFrame() end
				end,
			},
			friends = {
				name = "Friends Frame",
				type = "toggle",
				desc = "Toggle the skin of the Friends Frame",
				get = function()
					return self.db.profile.FriendsFrame
				end,
				set = function(v)
					self.db.profile.FriendsFrame = v
					self:FriendsFrame()
				end,
			},
			trade = {
				name = "Trade Frame",
				type = "toggle",
				desc = "Toggle the skin of the Trade Frame",
				get = function()
					return self.db.profile.TradeFrame
				end,
				set = function(v)
					self.db.profile.TradeFrame = v
					self:TradeFrame()
				end,
			},
			questlog = {
				name = "Quest Log Frame",
				type = "toggle",
				desc = "Toggle the skin of the Quest Log Frame",
				get = function()
					return self.db.profile.QuestLog
				end,
				set = function(v)
					self.db.profile.QuestLog = v
					self:QuestLog()
				end,
			},

			tooltips = {
				name = "Tooltips",
				type = "toggle",
				desc = "Toggle the skin of the Tooltips",
				get = function()
					return self.db.profile.Tooltips
				end,
				set = function(v)
					self.db.profile.Tooltips = v
					self:Tooltips()
				end,
			},
			timers = {
				name = "Timer Frames",
				type = "toggle",
				desc = "Toggle the skin of the Timer Frames",
				get = function()
					return self.db.profile.MirrorTimers
				end,
				set = function(v)
					self.db.profile.MirrorTimers = v
					self:MirrorTimers()
				end,
			},
			castbar = {
				name = "Casting Bar Frame",
				type = "toggle",
				desc = "Toggle the skin of the Casting Bar Frame",
				get = function()
					return self.db.profile.CastingBar
				end,
				set = function(v)
					self.db.profile.CastingBar = v
					self:CastingBar()
				end,
			},
			popups = {
				name = "Static Popups",
				type = "toggle",
				desc = "Toggle the skin of Static Popups",
				get = function()
					return self.db.profile.StaticPopups
				end,
				set = function(v)
					self.db.profile.StaticPopups = v
					self:StaticPopups()
					if IsAddOnLoaded("Blizzard_RaidUI") then self:ReadyCheckFrame() end
				end,
			},
			chattabs = {
				name = "Chat Tabs",
				type = "toggle",
				desc = "Toggle the skin of the Chat Tabs",
				get = function()
					return self.db.profile.ChatTabs
				end,
				set = function(v)
					self.db.profile.ChatTabs = v
					self:ChatTabs()
				end,
			},
			chatframes = {
				name = "Chat Frames",
				type = "toggle",
				desc = "Toggle the skin of the Chat Frames",
				get = function()
					return self.db.profile.ChatFrames
				end,
				set = function(v)
					self.db.profile.ChatFrames = v
					self:ChatFrames()
				end,
			},
			editbox = {
				name = "Chat Edit Box",
				type = "toggle",
				desc = "Toggle the skin of the Chat Edit Box",
				get = function()
					return self.db.profile.ChatEditBox
				end,
				set = function(v)
					self.db.profile.ChatEditBox = v
					self:ChatEditBox()
				end,
			},
			loot = {
				name = "Loot Frame",
				type = "toggle",
				desc = "Toggle the skin of the Loot Frame",
				get = function()
					return self.db.profile.LootFrame
				end,
				set = function(v)
					self.db.profile.LootFrame = v
					self:LootFrame()
				end,
			},
			grouploot = {
				name = "Group Loot Frame",
				desc = "Edit the GroupLoot settings",
				type = "group",
				args = {
					show = {
						name = "GroupLoot Show",
						type = "toggle",
						desc = "Toggle the GroupLoot frame on/off",
						get = function()
							return self.db.profile.GroupLoot.shown
						end,
						set = function (v)
							self.db.profile.GroupLoot.shown = v
							self:GroupLoot()						
						end,
					},
					small = {
						name = "GroupLoot Size",
						type = "toggle",
						desc = "Toggle the GroupLoot size",
						get = function()
							return self.db.profile.GroupLoot.small
						end,
						set = function (v)
							self.db.profile.GroupLoot.small = v
							self:GroupLoot()
						end,
					},
				},
			},
			container = {
				name = "Container Frames",
				type = "toggle",
				desc = "Toggle the skin of the Container Frames",
				get = function()
					return self.db.profile.ContainerFrames
				end,
				set = function(v)
					self.db.profile.ContainerFrames = v
					self:containerFrames()
					if IsAddOnLoaded("OneBank") then self:Skin_OneBank() end
					if IsAddOnLoaded("OneBag") then self:Skin_OneBag() end
				end,
			},
			stack = {
				name = "Stack Split Frame",
				type = "toggle",
				desc = "Toggle the skin of the Stack Split Frame",
				get = function()
					return self.db.profile.StackSplit
				end,
				set = function(v)
					self.db.profile.StackSplit = v
					self:StackSplit()
					if IsAddOnLoaded("EnhancedStackSplit") then self:EnhancedStackSplit() end
				end,
			},
			itemtext = {
				name = "Item Text Frame",
				type = "toggle",
				desc = "Toggle the skin of the Item Text Frame",
				get = function()
					return self.db.profile.ItemText
				end,
				set = function(v)
					self.db.profile.ItemText = v
					self:ItemText()
				end,
			},
			map = {
				name = "World Map Frame",
				type = "toggle",
				desc = "Toggle the skin of the World Map Frame",
				get = function()
					return self.db.profile.WorldMap
				end,
				set = function(v)
					self.db.profile.WorldMap = v
					self:WorldMap()
					if IsAddOnLoaded("MetaMap") then self:MetaMap() end
				end,
			},

			menu = {
				name = "Menu Frames",
				type = "toggle",
				desc = "Toggle the skin of the Menu Frames",
				get = function()
					return self.db.profile.MenuFrames
				end,
				set = function(v)
					self.db.profile.MenuFrames = v
					self:menuFrames()
				end,
			},
			bank = {
				name = "Bank Frame",
				type = "toggle",
				desc = "Toggle the skin of the Bank Frame",
				get = function()
					return self.db.profile.BankFrame
				end,
				set = function(v)
					self.db.profile.BankFrame = v
					self:BankFrame()
				end,
			},
			mail = {
				name = "Mail Frame",
				type = "toggle",
				desc = "Toggle the skin of the Mail Frame",
				get = function()
					return self.db.profile.MailFrame
				end,
				set = function(v)
					self.db.profile.MailFrame = v
					self:MailFrame()
				end,
			},
			auction = {
				name = "Auction Frame",
				type = "toggle",
				desc = "Toggle the skin of the Auction Frame",
				get = function()
					return self.db.profile.AuctionFrame
				end,
				set = function(v)
					self.db.profile.AuctionFrame = v
					self:AuctionFrame()
				end,
			},

			merchant = {
				name = "Merchant Frames",
				type = "toggle",
				desc = "Toggle the skin of the Merchant Frames",
				get = function()
					return self.db.profile.MerchantFrames
				end,
				set = function(v)
					self.db.profile.MerchantFrames = v
					self:merchantFrames()
				end,
			},
			gossip = {
				name = "Gossip Frame",
				type = "toggle",
				desc = "Toggle the skin of the Gossip Frame",
				get = function()
					return self.db.profile.GossipFrame
				end,
				set = function(v)
					self.db.profile.GossipFrame = v
					self:GossipFrame()
				end,
			},
			trainer = {
				name = "Class Trainer Frame",
				type = "toggle",
				desc = "Toggle the skin of the Class Trainer Frame",
				get = function()
					return self.db.profile.ClassTrainer
				end,
				set = function(v)
					self.db.profile.ClassTrainer = v
					self:ClassTrainer()
				end,
			},
			tradeskill = {
				name = "Trade Skill Frame",
				type = "toggle",
				desc = "Toggle the skin of the Trade Skill Frame",
				get = function()
					return self.db.profile.TradeSkill
				end,
				set = function(v)
					self.db.profile.TradeSkill = v
					self:TradeSkill()
				end,
			},
			craft = {
				name = "Craft Frame",
				type = "toggle",
				desc = "Toggle the skin of the Craft Frame",
				get = function()
					return self.db.profile.CraftFrame
				end,
				set = function(v)
					self.db.profile.CraftFrame = v
					self:CraftFrame()
				end,
			},
			taxi = {
				name = "Taxi Frame",
				type = "toggle",
				desc = "Toggle the skin of the Taxi Frame",
				get = function()
					return self.db.profile.TaxiFrame
				end,
				set = function(v)
					self.db.profile.TaxiFrame = v
					self:TaxiFrame()
				end,
			},
			quest = {
				name = "Quest Frame",
				type = "toggle",
				desc = "Toggle the skin of the Quest Frame",
				get = function()
					return self.db.profile.QuestFrame
				end,
				set = function(v)
					self.db.profile.QuestFrame = v
					self:QuestFrame()
				end,
			},
			battles = {
				name = "Battlefields Frame",
				type = "toggle",
				desc = "Toggle the skin of the Battlefields Frame",
				get = function()
					return self.db.profile.Battlefields
				end,
				set = function(v)
					self.db.profile.Battlefields = v
					self:Battlefields()
				end,
			},

			viewport = {
				name = "View Port",
				desc = "Edit the ViewPort settings",
				type = "group",
				args = {
					top = {
						name = "VP Top",
						desc = "Change Height of the Top Band",
						type = "range",
						step = 1,
						min = 0,
						max = 256,
						get = function ()
							return self.db.profile.ViewPort.top
						end,
						set = function (v)
							self.db.profile.ViewPort.top = v
							self:ViewPort_top()
						end,
					},
					bottom = {
						name = "VP Bottom",
						desc = "Change Height of the Bottom Band",
						type = "range",
						step = 1,
						min = 0,
						max = 256,
						get = function ()
							return self.db.profile.ViewPort.bottom
						end,
						set = function (v)
							self.db.profile.ViewPort.bottom = v
							self:ViewPort_bottom()
						end,
					},
					yres = {
						name = "VP YResolution",
						desc = "Change Y Resolution",
						type = "range",
						step = 2,
						min = 0,
						max = 1600,
						get = function ()
							return self.db.profile.ViewPort.YResolution
						end,
						set = function (v)
							self.db.profile.ViewPort.YResolution = v
							self.db.profile.ViewPort.scaling = 768 / self.db.profile.ViewPort.YResolution
				            self.initialized.ViewPort = nil
				            self:ViewPort()
						end,
					},
					show = {
						name = "ViewPort Show",
						type = "toggle",
						desc = "Toggle the ViewPort on/off",
						get = function()
							return self.db.profile.ViewPort.shown
						end,
						set = function (v)
							self.db.profile.ViewPort.shown = v
							if self.initialized.ViewPort then
                                self:ViewPort_reset()
							else
								self:ViewPort()						
							end
						end,
					},
				},
			},
			topframe = {
				name = "Top Frame",
				desc = "Edit the TopFrame settings",
				type = "group",
				args = {
					xyOff = {
						name = "TF Move Origin offscreen",
						desc = "Hide Border on Left and Top",
						type = "toggle",
						get = function ()
							return self.db.profile.TopFrame.xyOff
						end,
						set = function (v)
							self.db.profile.TopFrame.xyOff = v
							if self.initialized.TopFrame then
								if self.db.profile.TopFrame.xyOff then 
									self.topframe:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -6, 6)
								else
									self.topframe:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -3, 3)
								end
							end
						end,
					},
					height = {
						name = "TF Height",
						desc = "Change Height of the TopFrame",
						type = "range",
						step = 1,
						min = 0,
						max = 500,
						get = function ()
							return self.db.profile.TopFrame.height
						end,
						set = function (v)
							self.db.profile.TopFrame.height = v
							if self.initialized.TopFrame then
								self.topframe:SetHeight(v)
							end
						end,
					},
					width = {
						name = "TF Width",
						desc = "Change Width of the TopFrame",
						type = "range",
						step = 1,
						min = 0,
						max = 3000,
						get = function ()
							return self.db.profile.TopFrame.width
						end,
						set = function (v)
							self.db.profile.TopFrame.width = v
							if self.initialized.TopFrame then
								self.topframe:SetWidth(v)
							end
						end,
					},
					fadeheight = {
						name = "TF Fade Height",
						desc = "Change the Height of the Fade Effect",
						type = "range",
						step = 1,
						min = 0,
						max = 500,
						get = function ()
							return self.db.profile.TopFrame.fheight
						end,
						set = function (v)
							self.db.profile.TopFrame.fheight = v
							if self.initialized.TopFrame then
								self.topframe.tfade:SetPoint("BOTTOMRIGHT", self.topframe, "TOPRIGHT", -4, -v)
							end
						end,
					},
					show = {
						name = "TopFrame Show",
						type = "toggle",
						desc = "Toggle the TopFrame on/off",
						get = function()
							return self.db.profile.TopFrame.shown
						end,
						set = function (v)
							self.db.profile.TopFrame.shown = v
							if self.initialized.TopFrame then
								if self.topframe:IsVisible() then 
									self.topframe:Hide()
								else
									self.topframe:Show()
								end
							else
								self:TopFrame()
							end
						end,
					},
				},
			},
			bottomframe = {
				name = "Bottom Frame",
				desc = "Edit the BottomFrame settings",
				type = "group",
				args = {
					xyOff = {
						name = "BF Move Origin offscreen",
						desc = "Hide Border on Left and Bottom",
						type = "toggle",
						get = function ()
							return self.db.profile.BottomFrame.xyOff
						end,
						set = function (v)
							self.db.profile.BottomFrame.xyOff = v
							if self.initialized.BottomFrame then
								if self.db.profile.BottomFrame.xyOff then 
									self.bottomframe:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", -6, -6)
								else
									self.bottomframe:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", -3, -3)
								end
							end
						end,
					},
					height = {
						name = "BF Height",
						desc = "Change Height of the BottomFrame",
						type = "range",
						step = 1,
						min = 0,
						max = 500,
						get = function ()
							return self.db.profile.BottomFrame.height
						end,
						set = function (v)
							self.db.profile.BottomFrame.height = v
							if self.initialized.BottomFrame then
								self.bottomframe:SetHeight(v)
							end
						end,
					},
					width = {
						name = "BF Width",
						desc = "Change Width of the BottomFrame",
						type = "range",
						step = 1,
						min = 0,
						max = 3000,
						get = function ()
							return self.db.profile.BottomFrame.width
						end,
						set = function (v)
							self.db.profile.BottomFrame.width = v
							if self.initialized.BottomFrame then
								self.bottomframe:SetWidth(v)
							end
						end,
					},
					fadeheight = {
						name = "BF Fade Height",
						desc = "Change the Height of the Fade Effect",
						type = "range",
						step = 1,
						min = 0,
						max = 500,
						get = function ()
							return self.db.profile.BottomFrame.fheight
						end,
						set = function (v)
							self.db.profile.BottomFrame.fheight = v
							if self.initialized.BottomFrame then
								self.bottomframe.tfade:SetPoint("BOTTOMRIGHT", self.bottomframe, "TOPRIGHT", -4, -v)
							end
						end,
					},
					show = {
						name = "BottomFrame Show",
						type = "toggle",
						desc = "Toggle the BottomFrame on/off",
						get = function()
							return self.db.profile.BottomFrame.shown
						end,
						set = function (v)
							self.db.profile.BottomFrame.shown = v
							if self.initialized.BottomFrame then
								if self.bottomframe:IsVisible() then 
									self.bottomframe:Hide()
								else
									self.bottomframe:Show()
								end
							else
								self:BottomFrame()
							end
						end,
					},
				},
			},
		}	
	}
end
