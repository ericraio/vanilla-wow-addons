Bartender.options = {
	type = "group",
	args = {
		lock = {
			order = 1,
			name = "Lock", type = "toggle",
			desc = "Toggle locking of the bars.",
			get = function() return not Bartender.unlock end,
			set = function(v)
				if Bartender.unlock then
					Bartender:Lock()
				else
					Bartender:Move()
				end
			end,
		},
		borders = {
			order = 2,
			name = "Borders", type = "toggle",
			desc = "Toggle borders of the bars.",
			get = function() return not Bartender.db.profile.Extra.HideBorder end,
			set = function(v)
				if Bartender.db.profile.Extra.HideBorder then
					Bartender:ShowBorder()
				else
					Bartender:HideBorder()
				end
			end,
		},
		resetall = {
			order = 3,
			name = "Reset ALL", 
			type = "execute",
			desc = "Reset ALL Bars to default.",
			func = function() 
				StaticPopup_Show("BARTENDER2CONFIRM")
			end,
		},
		spacer = { type = "header", order = 4 },
		bar1 = {
			order = 5,
			type = "group",
			name = "Bar1",
			desc = "Bar1 options.",
			args = {
				show = {
					order = 1,
					name = "Show", type = "toggle",
					desc = "Toggle bar shown.",
					get = function() return not Bartender.db.profile[Bar1:GetName()].Hide end,
					set = function(v)
						if Bartender.db.profile[Bar1:GetName()].Hide then
							Bartender:ShowBar(Bar1)
						else
							Bartender:HideBar(Bar1)
						end
					end,
				},
				rows = {
					order = 1,
					name = "Rows", type = "text",
					desc = "Change the rows of the Bar",
					validate = {["1"] = " 1", ["2"] = " 2", ["3"] = " 3", ["4"] = " 4", ["6"] = " 6", ["12"] = "12"},
					get = function() return tostring(Bartender.db.profile[Bar1:GetName()].Rows) end,
					set = function(v)
						Bartender:Rows(Bar1, tonumber(v))
					end,
				},
				scale = {
					order = 1,
					name = "Scale", type = "range",
					desc = "Scale of the bar.",
					min = .1, max = 5, step = 0.05,
					get = function() return Bartender.db.profile[Bar1:GetName()].Scale or 1 end,
					set = function(s)
						Bartender:Scale(Bar1, s)
					end,
				},
				alpha = {
					order = 1,
					name = "Alpha", type = "range",
					desc = "Alpha of the bar.",
					min = .1, max = 1,
					get = function() return Bartender.db.profile[Bar1:GetName()].Alpha or 1 end,
					set = function(a)
						Bartender:Alpha(Bar1, a)
					end,
				},
				padding = {
					order = 1,
					name = "Padding", type = "range",
					desc = "Padding of the bar.",
					min = -10, max = 30, step = 1,
					get = function() return Bartender.db.profile[Bar1:GetName()].Padding or -1 end,
					set = function(p)
						Bartender:Padding(Bar1, p)
					end,
				},
				hotkey = {
					order = 2,
					name = "Hotkey", type = "toggle",
					desc = "Toggle the bar HotKey on/off",
					get = function() return not Bartender.db.profile[Bar1:GetName()].HideHotKey end,
					set = function(v)
						if Bartender.db.profile[Bar1:GetName()].HideHotKey then
							Bartender:ShowHK(Bar1)
						else
							Bartender:HideHK(Bar1)
						end
					end,
				}
			}			
		},
		bar2 = {
			order = 6,
			type = "group",
			name = "Bar2",
			desc = "Bar2 options.",
			args = {
				show = {
					order = 1,
					name = "Show", type = "toggle",
					desc = "Toggle bar shown.",
					get = function() return not Bartender.db.profile[Bar2:GetName()].Hide end,
					set = function(v)
						if Bartender.db.profile[Bar2:GetName()].Hide then
							Bartender:ShowBar(Bar2)
						else
							Bartender:HideBar(Bar2)
						end
					end,
				},
				rows = {
					order = 1,
					name = "Rows", type = "text",
					desc = "Change the rows of the Bar",
					validate = {["1"] = " 1", ["2"] = " 2", ["3"] = " 3", ["4"] = " 4", ["6"] = " 6", ["12"] = "12"},
					get = function() return tostring(Bartender.db.profile[Bar2:GetName()].Rows) end,
					set = function(v)
						Bartender:Rows(Bar2,tonumber(v))
					end,
				},
				scale = {
					order = 1,
					name = "Scale", type = "range",
					desc = "Scale of the bar.",
					min = .1, max = 5, step = 0.05,
					get = function() return Bartender.db.profile[Bar2:GetName()].Scale or 1 end,
					set = function(s)
						Bartender:Scale(Bar2, s)
					end,
				},
				alpha = {
					order = 1,
					name = "Alpha", type = "range",
					desc = "Alpha of the bar.",
					min = .1, max = 1,
					get = function() return Bartender.db.profile[Bar2:GetName()].Alpha or 1 end,
					set = function(a)
						Bartender:Alpha(Bar2, a)
					end,
				},
				padding = {
					order = 1,
					name = "Padding", type = "range",
					desc = "Padding of the bar.",
					min = -10, max = 30, step = 1,
					get = function() return Bartender.db.profile[Bar2:GetName()].Padding or -1 end,
					set = function(p)
						Bartender:Padding(Bar2, p)
					end,
				},
				hotkey = {
					order = 2,
					name = "Hotkey", type = "toggle",
					desc = "Toggle the bar HotKey on/off",
					get = function() return not Bartender.db.profile[Bar2:GetName()].HideHotKey end,
					set = function(v)
						if Bartender.db.profile[Bar2:GetName()].HideHotKey then
							Bartender:ShowHK(Bar2)
						else
							Bartender:HideHK(Bar2)
						end
					end,
				}
			}			
		},		
		bar3 = {
			order = 7,
			type = "group",
			name = "Bar3",
			desc = "Bar3 options.",
			args = {
				show = {
					order = 1,
					name = "Show", type = "toggle",
					desc = "Toggle bar shown.",
					get = function() return not Bartender.db.profile[Bar3:GetName()].Hide end,
					set = function(v)
						if Bartender.db.profile[Bar3:GetName()].Hide then
							Bartender:ShowBar(Bar3)
						else
							Bartender:HideBar(Bar3)
						end
					end,
				},
				rows = {
					order = 1,
					name = "Rows", type = "text",
					desc = "Change the rows of the Bar",
					validate = {["1"] = " 1", ["2"] = " 2", ["3"] = " 3", ["4"] = " 4", ["6"] = " 6", ["12"] = "12"},
					get = function() return tostring(Bartender.db.profile[Bar3:GetName()].Rows) end,
					set = function(v)
						Bartender:Rows(Bar3,tonumber(v))
					end,
				},
				scale = {
					order = 1,
					name = "Scale", type = "range",
					desc = "Scale of the bar.",
					min = .1, max = 5, step = 0.05,
					get = function() return Bartender.db.profile[Bar3:GetName()].Scale or 1 end,
					set = function(s)
						Bartender:Scale(Bar3, s)
					end,
				},
				alpha = {
					order = 1,
					name = "Alpha", type = "range",
					desc = "Alpha of the bar.",
					min = .1, max = 1,
					get = function() return Bartender.db.profile[Bar3:GetName()].Alpha or 1 end,
					set = function(a)
						Bartender:Alpha(Bar3, a)
					end,
				},
				padding = {
					order = 1,
					name = "Padding", type = "range",
					desc = "Padding of the bar.",
					min = -10, max = 30, step = 1,
					get = function() return Bartender.db.profile[Bar3:GetName()].Padding or -1 end,
					set = function(p)
						Bartender:Padding(Bar3, p)
					end,
				},
				hotkey = {
					order = 2,
					name = "Hotkey", type = "toggle",
					desc = "Toggle the bar HotKey on/off",
					get = function() return not Bartender.db.profile[Bar3:GetName()].HideHotKey end,
					set = function(v)
						if Bartender.db.profile[Bar3:GetName()].HideHotKey then
							Bartender:ShowHK(Bar3)
						else
							Bartender:HideHK(Bar3)
						end
					end,
				}
			}			
		},		
		bar4 = {
			order = 8,
			type = "group",
			name = "Bar4",
			desc = "Bar4 options.",
			args = {
				show = {
					order = 1,
					name = "Show", type = "toggle",
					desc = "Toggle bar shown.",
					get = function() return not Bartender.db.profile[Bar4:GetName()].Hide end,
					set = function(v)
						if Bartender.db.profile[Bar4:GetName()].Hide then
							Bartender:ShowBar(Bar4)
						else
							Bartender:HideBar(Bar4)
						end
					end,
				},
				rows = {
					order = 1,
					name = "Rows", type = "text",
					desc = "Change the rows of the Bar",
					validate = {["1"] = " 1", ["2"] = " 2", ["3"] = " 3", ["4"] = " 4", ["6"] = " 6", ["12"] = "12"},
					get = function() return tostring(Bartender.db.profile[Bar4:GetName()].Rows) end,
					set = function(v)
						Bartender:Rows(Bar4,tonumber(v))
					end,
				},
				scale = {
					order = 1,
					name = "Scale", type = "range",
					desc = "Scale of the bar.",
					min = .1, max = 5, step = 0.05,
					get = function() return Bartender.db.profile[Bar4:GetName()].Scale or 1 end,
					set = function(s)
						Bartender:Scale(Bar4, s)
					end,
				},
				alpha = {
					order = 1,
					name = "Alpha", type = "range",
					desc = "Alpha of the bar.",
					min = .1, max = 1,
					get = function() return Bartender.db.profile[Bar4:GetName()].Alpha or 1 end,
					set = function(a)
						Bartender:Alpha(Bar4, a)
					end,
				},
				padding = {
					order = 1,
					name = "Padding", type = "range",
					desc = "Padding of the bar.",
					min = -10, max = 30, step = 1,
					get = function() return Bartender.db.profile[Bar4:GetName()].Padding or -1 end,
					set = function(p)
						Bartender:Padding(Bar4, p)
					end,
				},
				hotkey = {
					order = 2,
					name = "Hotkey", type = "toggle",
					desc = "Toggle the bar HotKey on/off",
					get = function() return not Bartender.db.profile[Bar4:GetName()].HideHotKey end,
					set = function(v)
						if Bartender.db.profile[Bar4:GetName()].HideHotKey then
							Bartender:ShowHK(Bar4)
						else
							Bartender:HideHK(Bar4)
						end
					end,
				}
			}			
		},		
		bar5 = {
			order = 9,
			type = "group",
			name = "Bar5",
			desc = "Bar5 options.",
			args = {
				show = {
					order = 1,
					name = "Show", type = "toggle",
					desc = "Toggle bar shown.",
					get = function() return not Bartender.db.profile[Bar5:GetName()].Hide end,
					set = function(v)
						if Bartender.db.profile[Bar5:GetName()].Hide then
							Bartender:ShowBar(Bar5)
						else
							Bartender:HideBar(Bar5)
						end
					end,
				},
				rows = {
					order = 1,
					name = "Rows", type = "text",
					desc = "Change the rows of the Bar",
					validate = {["1"] = " 1", ["2"] = " 2", ["3"] = " 3", ["4"] = " 4", ["6"] = " 6", ["12"] = "12"},
					get = function() return tostring(Bartender.db.profile[Bar5:GetName()].Rows) end,
					set = function(v)
						Bartender:Rows(Bar5,tonumber(v))
					end,
				},
				scale = {
					order = 1,
					name = "Scale", type = "range",
					desc = "Scale of the bar.",
					min = .1, max = 5, step = 0.05,
					get = function() return Bartender.db.profile[Bar5:GetName()].Scale or 1 end,
					set = function(s)
						Bartender:Scale(Bar5, s)
					end,
				},
				alpha = {
					order = 1,
					name = "Alpha", type = "range",
					desc = "Alpha of the bar.",
					min = .1, max = 1,
					get = function() return Bartender.db.profile[Bar5:GetName()].Alpha or 1 end,
					set = function(a)
						Bartender:Alpha(Bar5, a)
					end,
				},
				padding = {
					order = 1,
					name = "Padding", type = "range",
					desc = "Padding of the bar.",
					min = -10, max = 30, step = 1,
					get = function() return Bartender.db.profile[Bar5:GetName()].Padding or -1 end,
					set = function(p)
						Bartender:Padding(Bar5, p)
					end,
				},
				hotkey = {
					order = 2,
					name = "Hotkey", type = "toggle",
					desc = "Toggle the bar HotKey on/off",
					get = function() return not Bartender.db.profile[Bar5:GetName()].HideHotKey end,
					set = function(v)
						if Bartender.db.profile[Bar5:GetName()].HideHotKey then
							Bartender:ShowHK(Bar5)
						else
							Bartender:HideHK(Bar5)
						end
					end,
				}
			}			
		},		
		shapebar = {
			order = 10,
			type = "group",
			name = "Shapebar",
			desc = "Shapebar options.",
			args = {
				show = {
					name = "Show", type = "toggle",
					desc = "Toggle bar shown.",
					get = function() return not Bartender.db.profile[Bar6:GetName()].Hide end,
					set = function(v)
						if Bartender.db.profile[Bar6:GetName()].Hide then
							Bartender:ShowBar(Bar6)
						else
							Bartender:HideBar(Bar6)
						end
					end,
				},
				swap = {
					name = "Swap", type = "toggle",
					desc = "swap bar horizontally/vertically.",
					get = function() return Bartender.db.profile[Bar6:GetName()].Swap end,
					set = function(v)
						if not Bartender.db.profile[Bar6:GetName()].Swap then
							Bartender:SwapOn(Bar6)
						else
							Bartender:SwapOff(Bar6)
						end
					end,
				},
				scale = {
					name = "Scale", type = "range",
					desc = "Scale of the bar.",
					min = .1, max = 5, step = 0.05,
					get = function() return Bartender.db.profile[Bar6:GetName()].Scale or 1 end,
					set = function(s)
						Bartender:Scale(Bar6, s)
					end,
				},
				alpha = {
					name = "Alpha", type = "range",
					desc = "Alpha of the bar.",
					min = .1, max = 1,
					get = function() return Bartender.db.profile[Bar6:GetName()].Alpha or 1 end,
					set = function(a)
						Bartender:Alpha(Bar6, a)
					end,
				},
				padding = {
					name = "Padding", type = "range",
					desc = "Padding of the bar.",
					min = -10, max = 30, step = 1,
					get = function() return Bartender.db.profile[Bar6:GetName()].Padding or 0 end,
					set = function(p)
						Bartender:Padding(Bar6, p)
					end,
				}
			}			
		},		
		petbar = {
			order = 11,
			type = "group",
			name = "Petbar",
			desc = "Petbar options.",
			args = {
				show = {
					name = "Show", type = "toggle",
					desc = "Toggle bar shown.",
					get = function() return not Bartender.db.profile[Bar7:GetName()].Hide end,
					set = function(v)
						if Bartender.db.profile[Bar7:GetName()].Hide then
							Bartender:ShowBar(Bar7)
						else
							Bartender:HideBar(Bar7)
						end
					end,
				},
				swap = {
					name = "Swap", type = "toggle",
					desc = "swap bar horizontally/vertically.",
					get = function() return Bartender.db.profile[Bar7:GetName()].Swap end,
					set = function(v)
						if not Bartender.db.profile[Bar7:GetName()].Swap then
							Bartender:SwapOn(Bar7)
						else
							Bartender:SwapOff(Bar7)
						end
					end,
				},
				scale = {
					name = "Scale", type = "range",
					desc = "Scale of the bar.",
					min = .1, max = 5, step = 0.05,
					get = function() return Bartender.db.profile[Bar7:GetName()].Scale or 1 end,
					set = function(s)
						Bartender:Scale(Bar7, s)
					end,
				},
				alpha = {
					name = "Alpha", type = "range",
					desc = "Alpha of the bar.",
					min = .1, max = 1,
					get = function() return Bartender.db.profile[Bar7:GetName()].Alpha or 1 end,
					set = function(a)
						Bartender:Alpha(Bar7, a)
					end,
				},
				padding = {
					name = "Padding", type = "range",
					desc = "Padding of the bar.",
					min = -10, max = 30, step = 1,
					get = function() return Bartender.db.profile[Bar7:GetName()].Padding or 0 end,
					set = function(p)
						Bartender:Padding(Bar7, p)
					end,
				}
			}			
		},		
		bagbar = {
			order = 12,
			type = "group",
			name = "Bagbar",
			desc = "Bagbar options.",
			args = {
				show = {
					name = "Show", type = "toggle",
					desc = "Toggle bar shown.",
					get = function() return not Bartender.db.profile[Bar8:GetName()].Hide end,
					set = function(v)
						if Bartender.db.profile[Bar8:GetName()].Hide then
							Bartender:ShowBar(Bar8)
						else
							Bartender:HideBar(Bar8)
						end
					end,
				},
				swap = {
					name = "Swap", type = "toggle",
					desc = "swap bar horizontally/vertically.",
					get = function() return Bartender.db.profile[Bar8:GetName()].Swap end,
					set = function(v)
						if not Bartender.db.profile[Bar8:GetName()].Swap then
							Bartender:SwapOn(Bar8)
						else
							Bartender:SwapOff(Bar8)
						end
					end,
				},
				scale = {
					name = "Scale", type = "range",
					desc = "Scale of the bar.",
					min = .1, max = 5, step = 0.05,
					get = function() return Bartender.db.profile[Bar8:GetName()].Scale or 1 end,
					set = function(s)
						Bartender:Scale(Bar8, s)
					end,
				},
				alpha = {
					name = "Alpha", type = "range",
					desc = "Alpha of the bar.",
					min = .1, max = 1,
					get = function() return Bartender.db.profile[Bar8:GetName()].Alpha or 1 end,
					set = function(a)
						Bartender:Alpha(Bar8, a)
					end,
				},
				padding = {
					name = "Padding", type = "range",
					desc = "Padding of the bar.",
					min = -10, max = 30, step = 1,
					get = function() return Bartender.db.profile[Bar8:GetName()].Padding or 0 end,
					set = function(p)
						Bartender:Padding(Bar8, p)
					end,
				}
			}			
		},		
		microbar = {
			order = 13,
			type = "group",
			name = "Microbar",
			desc = "Microbar options.",
			args = {
				show = {
					name = "Show", type = "toggle",
					desc = "Toggle bar shown.",
					get = function() return not Bartender.db.profile[Bar9:GetName()].Hide end,
					set = function(v)
						if Bartender.db.profile[Bar9:GetName()].Hide then
							Bartender:ShowBar(Bar9)
						else
							Bartender:HideBar(Bar9)
						end
					end,
				},
				swap = {
					name = "Swap", type = "toggle",
					desc = "swap bar horizontally/vertically.",
					get = function() return Bartender.db.profile[Bar9:GetName()].Swap end,
					set = function(v)
						if not Bartender.db.profile[Bar9:GetName()].Swap then
							Bartender:SwapOn(Bar9)
						else
							Bartender:SwapOff(Bar9)
						end
					end,
				},
				scale = {
					name = "Scale", type = "range",
					desc = "Scale of the bar.",
					min = .1, max = 5, step = 0.05,
					get = function() return Bartender.db.profile[Bar9:GetName()].Scale or 1 end,
					set = function(s)
						Bartender:Scale(Bar9, s)
					end,
				},
				alpha = {
					name = "Alpha", type = "range",
					desc = "Alpha of the bar.",
					min = .1, max = 1,
					get = function() return Bartender.db.profile[Bar9:GetName()].Alpha or 1 end,
					set = function(a)
						Bartender:Alpha(Bar9, a)
					end,
				},
				padding = {
					name = "Padding", type = "range",
					desc = "Padding of the bar.",
					min = -10, max = 30, step = 1,
					get = function() return Bartender.db.profile[Bar9:GetName()].Padding or -4 end,
					set = function(p)
						Bartender:Padding(Bar9, p)
					end,
				}
			}			
		},		
		bonusbar = {
			order = 14,
			type = "group",
			name = "Bonusbar",
			desc = "Bonusbar options.",
			args = {
				show = {
					order = 1,
					name = "Show", type = "toggle",
					desc = "Toggle bar shown.",
					get = function() return not Bartender.db.profile[Bar10:GetName()].Hide end,
					set = function(v)
						if Bartender.db.profile[Bar10:GetName()].Hide then
							Bartender:ShowBar(Bar10)
						else
							Bartender:HideBar(Bar10)
						end
					end,
				},
				rows = {
					order = 1,
					name = "Rows", type = "text",
					desc = "Change the rows of the Bar",
					validate = {["1"] = " 1", ["2"] = " 2", ["3"] = " 3", ["4"] = " 4", ["6"] = " 6", ["12"] = "12"},
					get = function() return tostring(Bartender.db.profile[Bar10:GetName()].Rows) end,
					set = function(v)
						Bartender:Rows(Bar10,tonumber(v))
					end,
				},
				scale = {
					order = 1,
					name = "Scale", type = "range",
					desc = "Scale of the bar.",
					min = .1, max = 5, step = 0.05,
					get = function() return Bartender.db.profile[Bar10:GetName()].Scale or 1 end,
					set = function(s)
						Bartender:Scale(Bar10, s)
					end,
				},
				alpha = {
					order = 1,
					name = "Alpha", type = "range",
					desc = "Alpha of the bar.",
					min = .1, max = 1,
					get = function() return Bartender.db.profile[Bar10:GetName()].Alpha or 1 end,
					set = function(a)
						Bartender:Alpha(Bar10, a)
					end,
				},
				padding = {
					order = 1,
					name = "Padding", type = "range",
					desc = "Padding of the bar.",
					min = -10, max = 30, step = 1,
					get = function() return Bartender.db.profile[Bar10:GetName()].Padding or -1 end,
					set = function(p)
						Bartender:Padding(Bar10, p)
					end,
				},
				hotkey = {
					order = 2,
					name = "Hotkey", type = "toggle",
					desc = "Toggle the bar HotKey on/off",
					get = function() return not Bartender.db.profile[Bar10:GetName()].HideHotKey end,
					set = function(v)
						if Bartender.db.profile[Bar10:GetName()].HideHotKey then
							Bartender:ShowHK(Bar10)
						else
							Bartender:HideHK(Bar10)
						end
					end,
				},
				noswap = {
					order = 3,
					name = "Stanceswap", type = "toggle",
					desc = "Toggle the Bonusbar stanceswap on/off",
					get = function() return not Bartender.db.profile[Bar10:GetName()].NoSwap end,
					set = function(val)
						Bartender.db.profile[Bar10:GetName()].NoSwap = not val
						Bartender:UPDATE_BONUS_ACTIONBAR()
					end,
				}
			}
		},
		spacer = { type = "header", order = 15 },
	}
}

Bartender:RegisterChatCommand({ "/bar", "/bartender" }, Bartender.options )
