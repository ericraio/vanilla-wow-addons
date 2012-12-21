local L = AceLibrary("AceLocale-2.0"):new("XLoot")

function XLoot:DoOptions()
	local db = self.db.profile
	XLoot.opts = {
		type = "group",
		args = {
			lock = {
				type = "toggle",
				name = L["optLock"],
				desc = L["descLock"],
					get = function()
					return db.lock
					end,
				set = function(v)
					db.lock = v
					end,
					order = 1
			},
			options = {
				type = "execute",
				name = L["optOptions"],
				desc = L["descOptions"],
				func = function() self.dewdrop:Open(UIParent) end,
				order = 100
			},
			behavior = {
				type = "group",
				name = L["optBehavior"],
				desc = L["descBehavior"],
				order = 2,
				args = {
					cursor = {
						type = "toggle",
						name = L["optCursor"],
						desc = L["descCursor"],
							get = function()
							return db.cursor
							end,
						set = function(v)
							XLootFrame:SetUserPlaced(v)
							db.pos.x = nil
							db.pos.y = nil
							db.cursor = v
							end,
							order = 2
					},
					smartsnap = {
						type = "toggle",
						name = L["optSmartsnap"],
						desc = L["descSmartsnap"],
							get = function()
							return db.smartsnap
							end,
						set = function(v)
							db.smartsnap = v
							end,
							order = 3
					},
					snapoffset = {
						type = "range",
						name = L["optSnapoffset"],
						desc = L["descSnapoffset"],
							get = function()
							return db.snapoffset
							end,
						set = function(v)
							db.snapoffset = v
							end,
						min = -100,
						max = 100,
						step = 1,
						order = 3
					},
					collapse = {
						type = "toggle",
						name = L["optCollapse"],
						desc = L["descCollapse"],
						get = function()
							return db.collapse
							end,
						set = function(v)
							db.collapse = v
							end,
						order = 4
					},
					dragborder = {
						type = "toggle",
						name = L["optDragborder"],
						desc = L["descDragborder"],
						get = function()
							return db.dragborder
							end,
						set = function(v)
							self.frame:EnableMouse(v)
							db.dragborder = v
							end,
						order = 5
					},
					lootexpand = {
						type = "toggle",
						name = L["optLootexpand"],
						desc = L["descLootexpand"],
						get = function()
							return db.lootexpand
							end,
						set = function(v)
							db.lootexpand = v
							end,
						order = 6
					},
					altoptions = {
						type = "toggle",
						name = L["optAltoptions"],
						desc = L["descAltoptions"],
						get = function()
							return db.altoptions
							end,
						set = function(v)
							db.altoptions = v
							end,
						order = 7
					},
					swiftloot = {
						type = "toggle",
						name = L["optSwiftloot"],
						desc = L["descSwiftloot"],
						get = function()
							return db.swiftloot
							end,
						set = function(v)
							db.swiftloot = v
							self:SwiftMouseEvents(v)
							end,
						order = 8
					},
					qualitytext = {
						type = "toggle",
						name = L["optQualitytext"],
						desc = L["descQualitytext"],
						get = function()
							return db.qualitytext
							end,
						set = function(v)
							db.qualitytext = v
							end,
						order = 9
					},
					infotext = {
						type = "toggle",
						name = L["optInfotext"],
						desc = L["descInfotext"],
						get = function()
							return db.infotext
							end,
						set = function(v)
							db.infotext = v
							end,
						order = 10
					}
				}
			},
			appearance = {
				type = "group",
				name = L["optAppearance"],
				desc = L["descAppearance"],
				order = 7, 
				args = {
					oskin = {
						type = "toggle",
						name = L["optOskin"],
						desc = L["descOskin"],
						get = function()
							return db.oskin
							end,
						set = function(v)
							db.oskin = v
							end,
						order = 3
					},
					qualityborder = {
						type = "toggle",
						name = L["optQualityborder"],
						desc = L["descQualityborder"],
							get = function()
							return db.qualityborder
							end,
						set = function(v)
							db.qualityborder = v
							end,
						order = 6
					},
					qualityframe = {
						type = "toggle",
						name = L["optQualityframe"],
						desc = L["descQualityframe"],
							get = function()
							return db.qualityframe
							end,
						set = function(v)
							db.qualityframe = v
							end,
						order = 7
					},
					lootqualityborder = {
						type = "toggle",
						name = L["optLootqualityborder"],
						desc = L["descLootqualityborder"],
							get = function()
							return db.lootqualityborder
							end,
						set = function(v)
							db.lootqualityborder = v
							end,
						order = 8
					},
					bgcolor = {
						type = "color",
						name = L["optBgcolor"],
						desc = L["descBgcolor"],
						get = function()
							return unpack(db.bgcolor)
						end,
						set = function(r, g, b, a)
							db.bgcolor = { r, g, b, a }
							self.frame:SetBackdropColor(r, g, b, a)
						end,
						hasAlpha = true,
						order = 9
					},
					bordercolor = {
						type = "color",
						name = L["optBordercolor"],
						desc = L["descBordercolor"],
						get = function()
							return unpack(db.bordercolor)
						end,
						set = function(r, g, b, a)
							db.bordercolor = { r, g, b, a }
							self.frame:SetBackdropBorderColor(r, g, b, a)
						end, 
						hasAlpha = true,
						order = 10
					},
					lootbgcolor = {
						type = "color",
						name = L["optLootbgcolor"],
						desc = L["descLootbgcolor"],
						get = function()
							return unpack(db.lootbgcolor)
						end,
						set = function(r, g, b, a)
							db.lootbgcolor = { r, g, b, a }
							local i
							for i = 1, self.numButtons do
								self.frames[i]:SetBackdropColor(r, g, b, a)
							end
						end,
						hasAlpha = true,
						order = 12
					},
					lootbordercolor = {
						type = "color",
						name = L["optLootbordercolor"],
						desc = L["descLootbordercolor"],
						get = function()
							return unpack(db.lootbordercolor)
						end,
						set = function(r, g, b, a)
							db.lootbordercolor = { r, g, b, a }
							local i
							for i = 1, self.numButtons do
								self.frames[i]:SetBackdropBorderColor(r, g, b, a)
							end
						end, 
						hasAlpha = true,
						order = 13
					}
				},
				scale = {
					type = "range",
					name = L["optScale"],
					desc = L["descScale"],
					get = function()
						return db.scale
						end,
					set = function(v)
						db.scale = v
						self.frame:SetScale(v)
						end,
					min = 0.5,
					max = 1.5,
					step = 0.05,
					order = 14
				}
			},
			advanced = {
				type = "group",
				name = L["optAdvanced"],
				desc = L["descAdvanced"],
				order = 100,
				args = {
					debug = {
						type = "toggle",
						name = L["optDebug"],
						desc = L["descDebug"],
						get = function()
							return db.debug
							end,
						set = function(v)
							db.debug = v
							end,
						order = 1
					},
					defaults = {
						type = "execute",
						name = L["optDefaults"],
						desc = L["descDefaults"],
						func = function() self:Defaults() end
					}
				}
			}
		}
	}
	self:RegisterChatCommand({ "/xloot" }, self.opts)
end