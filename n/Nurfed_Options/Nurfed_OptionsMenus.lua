
Nurfed_OptionsMenus = {
	["AddOns"] = {
		template = "nrf_options",
		children = {
			scroll = {
				type = "ScrollFrame",
				Anchor = "all",
				uitemp = "FauxScrollFrameTemplate",
				OnVerticalScroll = function() FauxScrollFrame_OnVerticalScroll(14, Nurfed_ScrollAddOns) end,
				OnShow = function() Nurfed_ScrollAddOns() end,
			},
		},
	},

	["Profiles"] = {
		template = "nrf_options",
	},

	["ActionBars"] = {
		template = "nrf_options",
		children = {
			scroll = {
				template = "nrf_scroll",
				vars = { pages = 2 },
			},
			check1 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 3, -3 },
				vars = { text = NRF_SHOWBAGS, option = "bagbar", func = function() Nurfed_ActionBars_UpdateBars("bagbar", 5) end, page = 1 },
			},
			check2 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parentcheck1", "BOTTOMLEFT", 0, -3 },
				vars = { text = NRF_VERTBAGS, option = "bagbarvert", func = function() Nurfed_ActionBars_UpdateBars("bagbar", 5) end, page = 1 },
			},
			check3 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parentcheck2", "BOTTOMLEFT", 0, -3 },
				vars = { text = NRF_SHOWPET, option = "petbar", func = function() Nurfed_ActionBars_UpdateBars("petbar", NUM_PET_ACTION_SLOTS) end, page = 1 },
			},
			check4 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parentcheck3", "BOTTOMLEFT", 0, -3 },
				vars = { text = NRF_VERTPET, option = "petbarvert", func = function() Nurfed_ActionBars_UpdateBars("petbar", NUM_PET_ACTION_SLOTS) end, page = 1 },
			},
			check5 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parentcheck4", "BOTTOMLEFT", 0, -3 },
				vars = { text = NRF_SHOWSTANCE, option = "stancebar", func = function() Nurfed_ActionBars_UpdateBars("stancebar", NUM_SHAPESHIFT_SLOTS) end, page = 1 },
			},
			check6 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parentcheck5", "BOTTOMLEFT", 0, -3 },
				vars = { text = NRF_VERSTANCE, option = "stancebarvert", func = function() Nurfed_ActionBars_UpdateBars("stancebar", NUM_SHAPESHIFT_SLOTS) end, page = 1 },
			},
			check7 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parentcheck6", "BOTTOMLEFT", 0, -3 },
				vars = { text = "Show Micro Menu", option = "showmicro", func = function() Nurfed_ActionBars_UpdateMicro() end, page = 1 },
			},
			check8 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parentcheck7", "BOTTOMLEFT", 0, -3 },
				vars = { text = NRF_SHOWHOTKEYS, option = "showhotkey", func = function() Nurfed_ActionBars_UpdateButtons() end, page = 1 },
			},
			check9 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parentcheck8", "BOTTOMLEFT", 0, -3 },
				vars = { text = NRF_SHOWUNUSED, option = "showunused", func = function() Nurfed_ActionBars_UpdateButtons() end, page = 1 },
			},
			check10 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parentcheck9", "BOTTOMLEFT", 0, -3 },
				vars = { text = "Show Border", option = "showborder", func = function() Nurfed_ActionBars_UpdateButtons() end, page = 1 },
			},
			swatch2 = {
				template = "nrf_color",
				Anchor = { "TOPLEFT", "$parentcheck10", "BOTTOMLEFT", 0, -3 },
				vars = { text = "Border Color", option = "bordercolor", func = function() Nurfed_ActionBars_UpdateButtons() end, page = 1 },
			},

			slider1 = {
				template = "nrf_slider",
				Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", -30, -15 },
				vars = {
					text = NRF_BAGSCALE,
					option = "bagbarscale",
					low = 0.25,
					high = 2.5,
					min = 0.25,
					max = 2.5,
					step = 0.01,
					format = "%.2f",
					func = function() Nurfed_ActionBars_UpdateBars("bagbar", 5) end,
					page = 1,
				},
			},
			slider2 = {
				template = "nrf_slider",
				Anchor = { "TOPRIGHT", "$parentslider1", "BOTTOMRIGHT", 0, -25 },
				vars = {
					text = NRF_PETBARSCALE,
					option = "petbarscale",
					low = 0.25,
					high = 2.5,
					min = 0.25,
					max = 2.5,
					step = 0.01,
					format = "%.2f",
					func = function() Nurfed_ActionBars_UpdateBars("petbar", NUM_PET_ACTION_SLOTS) end,
					page = 1,
				},
			},
			slider3 = {
				template = "nrf_slider",
				Anchor = { "TOPRIGHT", "$parentslider2", "BOTTOMRIGHT", 0, -25 },
				vars = {
					text = NRF_STANCESCALE,
					option = "stancebarscale",
					low = 0.25,
					high = 2.5,
					min = 0.25,
					max = 2.5,
					step = 0.01,
					format = "%.2f",
					func = function() Nurfed_ActionBars_UpdateBars("stancebar", NUM_SHAPESHIFT_SLOTS) end,
					page = 1,
				},
			},
			slider4 = {
				template = "nrf_slider",
				Anchor = { "TOPRIGHT", "$parentslider3", "BOTTOMRIGHT", 0, -25 },
				vars = {
					text = "MicroBar Scale",
					option = "microscale",
					low = 0.25,
					high = 2.5,
					min = 0.25,
					max = 2.5,
					step = 0.01,
					format = "%.2f",
					page = 1,
					func = function() Nurfed_ActionBars_UpdateMicro() end,
				},
			},
			slider5 = {
				template = "nrf_slider",
				Anchor = { "TOPRIGHT", "$parentslider4", "BOTTOMRIGHT", 0, -25 },
				vars = {
					text = NRF_COOLDOWNSCALE,
					option = "cooldownscale",
					low = 0.25,
					high = 2.5,
					min = 0.25,
					max = 2.5,
					step = 0.01,
					format = "%.2f",
					page = 1,
				},
			},
			reset = {
				template = "nrf_button",
				Anchor = { "BOTTOMRIGHT", "$parent", "BOTTOMRIGHT", -30, 10 },
				vars = { text = RESET.." Bars", page = 1 },
				OnClick = function() Nurfed_ActionBarsUpdateBars() end,
			},
			clear = {
				template = "nrf_button",
				Anchor = { "RIGHT", "$parentreset", "LEFT", -15, 0 },
				vars = { text = "Clear Bars", page = 1 },
				OnClick = function() Nurfed_ActionBarsClearBars() end,
			},

			pane1 = {
				template = "nrf_optionpane",
				size = { 100, 85 },
				Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 2, -13 },
				children = {
					scroll = "nrf_panescroll",
					row1 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 3, -1 },
					},
					row2 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow1", "BOTTOMLEFT", 0, 0 },
					},
					row3 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow2", "BOTTOMLEFT", 0, 0 },
					},
					row4 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow3", "BOTTOMLEFT", 0, 0 },
					},
					row5 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow4", "BOTTOMLEFT", 0, 0 },
					},
					row6 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow5", "BOTTOMLEFT", 0, 0 },
					},
					add = {
						template = "nrf_button",
						Anchor = { "TOPLEFT", "$parent", "BOTTOMLEFT", 0, 0 },
						vars = { text = "Add" },
						OnClick = function() Nurfed_Options_paneAddOption() end,
					},
					remove = {
						template = "nrf_button",
						Anchor = { "TOPRIGHT", "$parent", "BOTTOMRIGHT", 0, 0 },
						vars = { text = REMOVE },
						OnClick = function() Nurfed_Options_paneRemoveOption() end,
					},

					slider1 = {
						template = "nrf_slider",
						Anchor = { "TOPLEFT", "$parent", "TOPRIGHT", 150, -15 },
						vars = {
							text = NRF_ROWS,
							low = 1,
							high = 24,
							min = 1,
							max = 24,
							step = 1,
							format = "%.0f",
							default = 1,
							id = 1,
						},
					},
					slider2 = {
						template = "nrf_slider",
						Anchor = { "TOPRIGHT", "$parentslider1", "BOTTOMRIGHT", 0, -25 },
						vars = {
							text = NRF_COLUMNS,
							low = 1,
							high = 24,
							min = 1,
							max = 24,
							step = 1,
							format = "%.0f",
							default = 12,
							id = 2,
						},
					},
					slider3 = {
						template = "nrf_slider",
						Anchor = { "TOPRIGHT", "$parentslider2", "BOTTOMRIGHT", 0, -25 },
						vars = {
							text = NRF_PAGES,
							low = 1,
							high = 6,
							min = 1,
							max = 6,
							step = 1,
							format = "%.0f",
							default = 1,
							id = 3,
						},
					},
					slider4 = {
						template = "nrf_slider",
						Anchor = { "TOPRIGHT", "$parentslider3", "BOTTOMRIGHT", 0, -25 },
						vars = {
							text = NRF_SCALE,
							low = "25%",
							high = "300%",
							min = 0.25,
							max = 3,
							step = 0.01,
							format = "%.2f",
							default = 1,
							id = 4,
						},
					},
					slider5 = {
						template = "nrf_slider",
						Anchor = { "TOPRIGHT", "$parentslider4", "BOTTOMRIGHT", 0, -25 },
						vars = {
							text = NRF_XGAP,
							low = "-2",
							high = "25",
							min = -2,
							max = 25,
							step = 1,
							format = "%.0f",
							default = 2,
							id = 5,
						},
					},
					slider6 = {
						template = "nrf_slider",
						Anchor = { "TOPRIGHT", "$parentslider5", "BOTTOMRIGHT", 0, -25 },
						vars = {
							text = NRF_YGAP,
							low = "-2",
							high = "25",
							min = -2,
							max = 25,
							step = 1,
							format = "%.0f",
							default = 2,
							id = 6,
						},
					},

					check1 = {
						template = "nrf_check",
						Anchor = { "TOPLEFT", "$parentadd", "BOTTOMLEFT", 0, -25 },
						vars = { text = "Show In Combat", id = 8 },
					},
					slider7 = {
						template = "nrf_slider",
						Anchor = { "TOPLEFT", "$parentcheck1", "BOTTOMLEFT", 0, -25 },
						vars = {
							text = NRF_BARALPHA,
							low = "0%",
							high = "100%",
							min = 0,
							max = 1,
							step = 0.01,
							format = "%.2f",
							default = 1,
							id = 7,
						},
					},
				},
				vars = { text = "Action Bars", option = "bars", prefix = "Action Bar ", rows = 6, page = 2, func = function() Nurfed_ActionBars:InitBars() end},
			},
		},
	},

	["CombatLog"] = {
		template = "nrf_options",
		children = {
			scroll = {
				template = "nrf_scroll",
				vars = { pages = 4 },
			},
			swatch1 = {
				template = "nrf_color",
				Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 4, -4 },
				vars = { text = YOU, option = "You", page = 1 },
			},
			swatch2 = {
				template = "nrf_color",
				Anchor = { "TOPLEFT", "$parentswatch1", "BOTTOMLEFT", 0, -2 },
				vars = { text = PET, option = "Pet", page = 1 },
			},
			swatch3 = {
				template = "nrf_color",
				Anchor = { "TOPLEFT", "$parentswatch2", "BOTTOMLEFT", 0, -2 },
				vars = { text = PARTY, option = "Party", page = 1 },
			},
			swatch4 = {
				template = "nrf_color",
				Anchor = { "TOPLEFT", "$parentswatch3", "BOTTOMLEFT", 0, -2 },
				vars = { text = RAID, option = "Raid", page = 1 },
			},
			swatch5 = {
				template = "nrf_color",
				Anchor = { "TOPLEFT", "$parentswatch4", "BOTTOMLEFT", 0, -2 },
				vars = { text = FACTION_OTHER, option = "Enemy", page = 1 },
			},
			swatch6 = {
				template = "nrf_color",
				Anchor = { "TOPLEFT", "$parentswatch5", "BOTTOMLEFT", 0, -2 },
				vars = { text = NRF_TARGET, option = "Target", page = 1 },
			},
			swatch7 = {
				template = "nrf_color",
				Anchor = { "TOPLEFT", "$parentswatch6", "BOTTOMLEFT", 0, -2 },
				vars = { text = HEALTH, option = HEALTH, page = 1 },
			},
			swatch8 = {
				template = "nrf_color",
				Anchor = { "TOPLEFT", "$parentswatch7", "BOTTOMLEFT", 0, -2 },
				vars = { text = MANA, option = MANA, page = 1 },
			},
			swatch9 = {
				template = "nrf_color",
				Anchor = { "TOPLEFT", "$parentswatch8", "BOTTOMLEFT", 0, -2 },
				vars = { text = RAGE, option = RAGE, page = 1 },
			},
			swatch10 = {
				template = "nrf_color",
				Anchor = { "TOPLEFT", "$parentswatch9", "BOTTOMLEFT", 0, -2 },
				vars = { text = ENERGY, option = ENERGY, page = 1 },
			},
			swatch11 = {
				template = "nrf_color",
				Anchor = { "TOPLEFT", "$parentswatch10", "BOTTOMLEFT", 0, -2 },
				vars = { text = HAPPINESS, option = HAPPINESS, page = 1 },
			},

			swatch12 = {
				template = "nrf_color",
				Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", -30, -4 },
				vars = { text = SPELL_SCHOOL0_CAP, option = SPELL_SCHOOL0_CAP, right = true, page = 1 },
			},
			swatch13 = {
				template = "nrf_color",
				Anchor = { "TOPRIGHT", "$parentswatch12", "BOTTOMRIGHT", 0, -2 },
				vars = { text = SPELL_SCHOOL1_CAP, option = SPELL_SCHOOL1_CAP, right = true, page = 1 },
			},
			swatch14 = {
				template = "nrf_color",
				Anchor = { "TOPRIGHT", "$parentswatch13", "BOTTOMRIGHT", 0, -2 },
				vars = { text = SPELL_SCHOOL2_CAP, option = SPELL_SCHOOL2_CAP, right = true, page = 1 },
			},
			swatch15 = {
				template = "nrf_color",
				Anchor = { "TOPRIGHT", "$parentswatch14", "BOTTOMRIGHT", 0, -2 },
				vars = { text = SPELL_SCHOOL3_CAP, option = SPELL_SCHOOL3_CAP, right = true, page = 1 },
			},
			swatch16 = {
				template = "nrf_color",
				Anchor = { "TOPRIGHT", "$parentswatch15", "BOTTOMRIGHT", 0, -2 },
				vars = { text = SPELL_SCHOOL4_CAP, option = SPELL_SCHOOL4_CAP, right = true, page = 1 },
			},
			swatch17 = {
				template = "nrf_color",
				Anchor = { "TOPRIGHT", "$parentswatch16", "BOTTOMRIGHT", 0, -2 },
				vars = { text = SPELL_SCHOOL5_CAP, option = SPELL_SCHOOL5_CAP, right = true, page = 1 },
			},
			swatch18 = {
				template = "nrf_color",
				Anchor = { "TOPRIGHT", "$parentswatch17", "BOTTOMRIGHT", 0, -2 },
				vars = { text = SPELL_SCHOOL6_CAP, option = SPELL_SCHOOL6_CAP, right = true, page = 1 },
			},
			swatch19 = {
				template = "nrf_color",
				Anchor = { "TOPRIGHT", "$parentswatch18", "BOTTOMRIGHT", 0, -2 },
				vars = { text = NRF_HEAL, option = "Heal", right = true, page = 1 },
			},
			swatch20 = {
				template = "nrf_color",
				Anchor = { "TOPRIGHT", "$parentswatch19", "BOTTOMRIGHT", 0, -2 },
				vars = { text = MISS, option = MISS, right = true, page = 1 },
			},
			swatch21 = {
				template = "nrf_color",
				Anchor = { "TOPRIGHT", "$parentswatch20", "BOTTOMRIGHT", 0, -2 },
				vars = { text = DAMAGE, option = "damage", right = true, page = 1 },
			},
			swatch22 = {
				template = "nrf_color",
				Anchor = { "TOPRIGHT", "$parentswatch21", "BOTTOMRIGHT", 0, -2 },
				vars = { text = NRF_CRITOVERLAY, option = "overlay", right = true, page = 1 },
			},
			swatch23 = {
				template = "nrf_color",
				Anchor = { "TOPRIGHT", "$parentswatch22", "BOTTOMRIGHT", 0, -2 },
				vars = { text = NRF_BUFFS, option = "buff", right = true, page = 1 },
			},
			swatch24 = {
				template = "nrf_color",
				Anchor = { "TOPRIGHT", "$parentswatch23", "BOTTOMRIGHT", 0, -2 },
				vars = { text = NRF_DEBUFFS, option = "debuff", right = true, page = 1 },
			},
			swatch25 = {
				template = "nrf_color",
				Anchor = { "TOPLEFT", "$parentswatch11", "BOTTOMLEFT", 0, -2 },
				vars = { text = SPELLS, option = "cast", page = 1 },
			},
			
			input1 = {
				template = "nrf_input",
				Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 4, -4 },
				vars = { text = NRF_SOURCE, option = "source", page = 2 },
			},
			input2 = {
				template = "nrf_input",
				Anchor = { "TOPLEFT", "$parentinput1", "BOTTOMLEFT", 0, -5 },
				vars = { text = NRF_TARGET, option = "target", page = 2 },
			},
			input3 = {
				template = "nrf_input",
				Anchor = { "TOPLEFT", "$parentinput2", "BOTTOMLEFT", 0, -5 },
				vars = { text = TUTORIAL_TITLE25, option = "death", page = 2 },
			},
			input4 = {
				template = "nrf_input",
				Anchor = { "TOPLEFT", "$parentinput3", "BOTTOMLEFT", 0, -5 },
				vars = { text = NRF_CRIT, option = "crit", page = 2 },
			},
			input5 = {
				template = "nrf_input",
				Anchor = { "TOPLEFT", "$parentinput4", "BOTTOMLEFT", 0, -5 },
				vars = { text = SPELLS, option = "spellalert", page = 2 },
			},
			slider1 = {
				template = "nrf_slider",
				Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", -30, -15 },
				vars = {
					text = NRF_DEATHOUT,
					option = "deathout",
					low = 0,
					high = 7,
					min = 0,
					max = 7,
					step = 1,
					format = "%.0f",
					page = 2,
				},
			},
			check1 = {
				template = "nrf_check",
				Anchor = { "TOPRIGHT", "$parentslider1", "BOTTOMRIGHT", 0, -15 },
				vars = { text = NRF_SHOWDESTROYED, option = "destroyed", right = true, page = 2 },
			},

			pane1 = {
				template = "nrf_optionpane",
				size = { 100, 110 },
				Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 2, -13 },
				children = {
					scroll = "nrf_panescroll",
					input = {
						template = "nrf_paneeditbox",
						size = { 85, 15 },
						Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 1, -1 },
					},
					row1 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentinput", "BOTTOMLEFT", 2, 0 },
					},
					row2 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow1", "BOTTOMLEFT", 0, 0 },
					},
					row3 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow2", "BOTTOMLEFT", 0, 0 },
					},
					row4 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow3", "BOTTOMLEFT", 0, 0 },
					},
					row5 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow4", "BOTTOMLEFT", 0, 0 },
					},
					row6 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow5", "BOTTOMLEFT", 0, 0 },
					},
					row7 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow6", "BOTTOMLEFT", 0, 0 },
					},
					remove = {
						template = "nrf_button",
						Anchor = { "TOPRIGHT", "$parent", "BOTTOMRIGHT", 0, 0 },
						vars = { text = REMOVE },
						OnClick = function() Nurfed_Options_paneRemoveOption() end,
					},

					slider1 = {
						template = "nrf_slider",
						Anchor = { "TOPLEFT", "$parent", "TOPRIGHT", 150, -15 },
						vars = {
							text = NRF_OUTPUT,
							low = 0,
							high = 7,
							min = 0,
							max = 7,
							step = 1,
							format = "%.0f",
							default = 2,
							id = 1,
						},
					},
					check1 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parent", "TOPRIGHT", 2, -2 },
						vars = { text = NRF_HEAL, default = 1, id = 2 },
					},
					check2 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck1", "BOTTOMLEFT", 0, -3 },
						vars = { text = NRF_HIT, default = 1, id = 3 },
					},
					check3 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck2", "BOTTOMLEFT", 0, -3 },
						vars = { text = SPELLS, default = 1, id = 4 },
					},
					check4 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck3", "BOTTOMLEFT", 0, -3 },
						vars = { text = NRF_DOT, default = 1, id = 5 },
					},
					check5 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck4", "BOTTOMLEFT", 0, -3 },
						vars = { text = NRF_SPELLMISS, default = 1, id = 6 },
					},
					check6 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck5", "BOTTOMLEFT", 0, -3 },
						vars = { text = NRF_ENVIRONMENT, default = 1, id = 7 },
					},
					check7 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck6", "BOTTOMLEFT", 0, -3 },
						vars = { text = NRF_POWERGAIN, default = 1, id = 8 },
					},
					check8 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck7", "BOTTOMLEFT", 0, -3 },
						vars = { text = NRF_DEBUFFS, default = 1, id = 9 },
					},

					check9 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPRIGHT", "$parentslider1", "BOTTOMRIGHT", 0, -8 },
						vars = { text = NRF_BUFFS, right = true, default = 1, id = 10 },
					},
					check10 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPRIGHT", "$parentcheck9", "BOTTOMRIGHT", 0, -3 },
						vars = { text = NRF_AURAFADE, right = true, default = 1, id = 11 },
					},
					check11 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPRIGHT", "$parentcheck10", "BOTTOMRIGHT", 0, -3 },
						vars = { text = NRF_MELEEMISS, right = true, default = 1, id = 12 },
					},
					check12 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPRIGHT", "$parentcheck11", "BOTTOMRIGHT", 0, -3 },
						vars = { text = NRF_RESIST, right = true, default = 1, id = 13 },
					},
					check13 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPRIGHT", "$parentcheck12", "BOTTOMRIGHT", 0, -3 },
						vars = { text = NRF_SPELLFAIL, right = true, default = 1, id = 14 },
					},
					check14 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPRIGHT", "$parentcheck13", "BOTTOMRIGHT", 0, -3 },
						vars = { text = NRF_CAST, right = true, default = 1, id = 15 },
					},
					check15 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPRIGHT", "$parentcheck14", "BOTTOMRIGHT", 0, -3 },
						vars = { text = NRF_PERFORM, right = true, default = 1, id = 16 },
					},
				},
				vars = { text = "Source Watches", option = "sourcewatches", up = true, rows = 7, page = 3 },
			},

			pane2 = {
				template = "nrf_optionpane",
				size = { 100, 110 },
				Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 2, -13 },
				children = {
					scroll = "nrf_panescroll",
					input = {
						template = "nrf_paneeditbox",
						size = { 85, 15 },
						Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 1, -1 },
					},
					row1 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentinput", "BOTTOMLEFT", 2, 0 },
					},
					row2 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow1", "BOTTOMLEFT", 0, 0 },
					},
					row3 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow2", "BOTTOMLEFT", 0, 0 },
					},
					row4 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow3", "BOTTOMLEFT", 0, 0 },
					},
					row5 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow4", "BOTTOMLEFT", 0, 0 },
					},
					row6 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow5", "BOTTOMLEFT", 0, 0 },
					},
					row7 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow6", "BOTTOMLEFT", 0, 0 },
					},
					remove = {
						template = "nrf_button",
						Anchor = { "TOPRIGHT", "$parent", "BOTTOMRIGHT", 0, 0 },
						vars = { text = REMOVE },
						OnClick = function() Nurfed_Options_paneRemoveOption() end,
					},

					slider1 = {
						template = "nrf_slider",
						Anchor = { "TOPLEFT", "$parent", "TOPRIGHT", 150, -15 },
						vars = {
							text = NRF_OUTPUT,
							low = 0,
							high = 7,
							min = 0,
							max = 7,
							step = 1,
							format = "%.0f",
							default = 2,
							id = 1,
						},
					},
					check1 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parent", "TOPRIGHT", 2, -2 },
						vars = { text = NRF_HEAL, default = 1, id = 2 },
					},
					check2 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck1", "BOTTOMLEFT", 0, -3 },
						vars = { text = NRF_HIT, default = 1, id = 3 },
					},
					check3 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck2", "BOTTOMLEFT", 0, -3 },
						vars = { text = SPELLS, default = 1, id = 4 },
					},
					check4 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck3", "BOTTOMLEFT", 0, -3 },
						vars = { text = NRF_DOT, default = 1, id = 5 },
					},
					check5 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck4", "BOTTOMLEFT", 0, -3 },
						vars = { text = NRF_SPELLMISS, default = 1, id = 6 },
					},
					check6 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck5", "BOTTOMLEFT", 0, -3 },
						vars = { text = NRF_ENVIRONMENT, default = 1, id = 7 },
					},
					check7 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck6", "BOTTOMLEFT", 0, -3 },
						vars = { text = NRF_POWERGAIN, default = 1, id = 8 },
					},
					check8 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck7", "BOTTOMLEFT", 0, -3 },
						vars = { text = NRF_DEBUFFS, default = 1, id = 9 },
					},

					check9 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPRIGHT", "$parentslider1", "BOTTOMRIGHT", 0, -8 },
						vars = { text = NRF_BUFFS, right = true, default = 1, id = 10 },
					},
					check10 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPRIGHT", "$parentcheck9", "BOTTOMRIGHT", 0, -3 },
						vars = { text = NRF_AURAFADE, right = true, default = 1, id = 11 },
					},
					check11 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPRIGHT", "$parentcheck10", "BOTTOMRIGHT", 0, -3 },
						vars = { text = NRF_MELEEMISS, right = true, default = 1, id = 12 },
					},
					check12 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPRIGHT", "$parentcheck11", "BOTTOMRIGHT", 0, -3 },
						vars = { text = NRF_RESIST, right = true, default = 1, id = 13 },
					},
					check13 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPRIGHT", "$parentcheck12", "BOTTOMRIGHT", 0, -3 },
						vars = { text = NRF_SPELLFAIL, right = true, default = 1, id = 14 },
					},
					check14 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPRIGHT", "$parentcheck13", "BOTTOMRIGHT", 0, -3 },
						vars = { text = NRF_CAST, right = true, default = 1, id = 15 },
					},
					check15 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPRIGHT", "$parentcheck14", "BOTTOMRIGHT", 0, -3 },
						vars = { text = NRF_PERFORM, right = true, default = 1, id = 16 },
					},
				},
				vars = { text = "Target Watches", option = "targetwatches", up = true, rows = 7, page = 4 },
			},
		},
	},

	["Bosses"] = {
		template = "nrf_options",
		children = {
			check1 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 3, -3 },
				vars = { text = "Announce", option = "announce" },
			},
			check2 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parentcheck1", "BOTTOMLEFT", 0, -3 },
				vars = { text = "Show Frame", option = "showframe" },
			},
		},
	},

	["General"] = {
		template = "nrf_options",
		children = {
			check1 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 3, -3 },
				vars = { text = NRF_AUTOREPAIR, option = "repair" },
			},
			check2 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parentcheck1", "BOTTOMLEFT", 0, -3 },
				vars = { text = NRF_PINGWARNING, option = "ping" },
			},
			check3 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parentcheck2", "BOTTOMLEFT", 0, -3 },
				vars = { text = NRF_UNTRAINABLE, option = "traineravailable" },
			},
			check4 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parentcheck3", "BOTTOMLEFT", 0, -3 },
				vars = { text = NRF_CHATTIMESTAMPS, option = "timestamps" },
			},
			check5 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parentcheck4", "BOTTOMLEFT", 0, -3 },
				vars = { text = NRF_RAIDGROUP, option = "raidgroup" },
			},
			check6 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parentcheck5", "BOTTOMLEFT", 0, -3 },
				vars = { text = NRF_RAIDCLASS, option = "raidclass" },
			},
			check7 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parentcheck6", "BOTTOMLEFT", 0, -3 },
				vars = { text = NRF_CHATBUTTONS, option = "hidechat", func = function() nrf_togglechat() end },
			},
			check8 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parentcheck7", "BOTTOMLEFT", 0, -3 },
				vars = { text = NRF_CHATPREFIX, option = "chatprefix" },
			},
			check9 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parentcheck8", "BOTTOMLEFT", 0, -3 },
				vars = { text = NRF_AUTOINVITE, option = "autoinvite" },
			},
			check10 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parentcheck9", "BOTTOMLEFT", 0, -3 },
				vars = { text = NRF_CHATFADE, option = "chatfade", func = function() nrf_togglechat() end },
			},

			slider1 = {
				template = "nrf_slider",
				Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", -5, -15 },
				vars = {
					text = NRF_REPAIRLIMIT,
					option = "repairlimit",
					low = 0,
					high = 200,
					min = 0,
					max = 200,
					step = 1,
					format = "%.0f",
				},
			},
			slider2 = {
				template = "nrf_slider",
				Anchor = { "TOPRIGHT", "$parentslider1", "BOTTOMRIGHT", 0, -25 },
				vars = {
					text = NRF_CHATFADETIME,
					option = "chatfadetime",
					low = 0,
					high = 250,
					min = 0,
					max = 250,
					step = 1,
					format = "%.0f",
					func = function() nrf_togglechat() end,
				},
			},
			input1 = {
				template = "nrf_input",
				Anchor = { "TOPRIGHT", "$parentslider2", "BOTTOMRIGHT", 0, -20 },
				vars = {
					text = NRF_TIMESTAMP,
					option = "timestampsformat",
				},
			},
			input2 = {
				template = "nrf_input",
				Anchor = { "TOPRIGHT", "$parentinput1", "BOTTOMRIGHT", 0, -15 },
				vars = {
					text = NRF_KEYWORD,
					option = "keyword",
				},
			},
		},
	},

	["Hud"] = {
		template = "nrf_options",
		children = {
			check1 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 3, -3 },
				vars = { text = NRF_NOCOMBAT, option = "nocombat" },
			},

			slider1 = {
				template = "nrf_slider",
				Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", -5, -15 },
				vars = {
					text = NRF_NOCOMBATALPHA,
					option = "nocombatalpha",
					low = "0%",
					high = "100%",
					min = 0,
					max = 1,
					format = "%.2f",
					step = 0.01,
				},
			},
			slider2 = {
				template = "nrf_slider",
				Anchor = { "TOPRIGHT", "$parentslider1", "BOTTOMRIGHT", 0, -25 },
				vars = {
					text = NRF_COMBATALPHA,
					option = "combatalpha",
					low = "0%",
					high = "100%",
					min = 0,
					max = 1,
					format = "%.2f",
					step = 0.01,
				},
			},
		},
	},

	["UnitFrames"] = {
		template = "nrf_options",
		children = {
			check1 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 3, -3 },
				vars = { text = "Hide Party in Raid", option = "hideparty", func = function() Nurfed_UnitFrames_ToggleParty() end },
			},
			check2 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parentcheck1", "BOTTOMLEFT", 0, -3 },
				vars = { text = "Use Layout (|cffff0000ReloadUI|r)", option = "uselayout", func = function() StaticPopup_Show("NRF_RELOADUI") end },
			},
			check3 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parentcheck2", "BOTTOMLEFT", 0, -3 },
				vars = { text = SHOW_DISPELLABLE_DEBUFFS_TEXT, option = "dispellable", func = function() Nurfed_UnitFrames_UpdateAuras() end },
			},
			check4 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parentcheck3", "BOTTOMLEFT", 0, -3 },
				vars = { text = SHOW_CASTABLE_BUFFS_TEXT, option = "castable", func = function() Nurfed_UnitFrames_UpdateAuras() end },
			},
			check5 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parentcheck4", "BOTTOMLEFT", 0, -3 },
				vars = { text = "Ignore Target Debuff Filter", option = "targetdebuffs", func = function() Nurfed_UnitFrames_UpdateAuras() end },
			},
			check6 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parentcheck5", "BOTTOMLEFT", 0, -3 },
				vars = { text = "Ignore Target Buff Filter", option = "targetbuffs", func = function() Nurfed_UnitFrames_UpdateAuras() end },
			},
			check7 = {
				template = "nrf_check",
				Anchor = { "TOPLEFT", "$parentcheck6", "BOTTOMLEFT", 0, -3 },
				vars = { text = "Auto Cancel Buffs", option = "cancelbuffs", func = function() Nurfed_CancelBuffs() end },
			},

			pane1 = {
				template = "nrf_optionpane",
				size = { 100, 75 },
				Anchor = { "TOPLEFT", "$parentcheck7", "BOTTOMLEFT", 0, -13 },
				children = {
					scroll = "nrf_panescroll",
					input = {
						template = "nrf_paneeditbox",
						size = { 85, 15 },
						Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 1, -1 },
					},
					row1 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentinput", "BOTTOMLEFT", 2, 0 },
					},
					row2 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow1", "BOTTOMLEFT", 0, 0 },
					},
					row3 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow2", "BOTTOMLEFT", 0, 0 },
					},
					row4 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow3", "BOTTOMLEFT", 0, 0 },
					},
					remove = {
						template = "nrf_button",
						Anchor = { "TOPLEFT", "$parent", "BOTTOMLEFT", 0, 0 },
						vars = { text = REMOVE },
						OnClick = function() Nurfed_Options_paneRemoveOption() end,
					},
				},
				vars = { text = "Buff List", option = "bufflist", notbl = true, rows = 4 },
			},

			slider1 = {
				template = "nrf_slider",
				Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", -5, -15 },
				vars = {
					text = "Player Scale",
					option = "playerscale",
					low = "0.5",
					high = "3",
					min = 0.5,
					max = 3,
					format = "%.2f",
					step = 0.01,
					func = function() Nurfed_UnitFrames_UpdateScale("player") end
				},
			},
			slider2 = {
				template = "nrf_slider",
				Anchor = { "TOPRIGHT", "$parentslider1", "BOTTOMRIGHT", 0, -25 },
				vars = {
					text = "Target Scale",
					option = "targetscale",
					low = "0.5",
					high = "3",
					min = 0.5,
					max = 3,
					format = "%.2f",
					step = 0.01,
					func = function() Nurfed_UnitFrames_UpdateScale("target") end
				},
			},
			slider3 = {
				template = "nrf_slider",
				Anchor = { "TOPRIGHT", "$parentslider2", "BOTTOMRIGHT", 0, -25 },
				vars = {
					text = "Pet Scale",
					option = "petscale",
					low = "0.5",
					high = "3",
					min = 0.5,
					max = 3,
					format = "%.2f",
					step = 0.01,
					func = function() Nurfed_UnitFrames_UpdateScale("pet") end
				},
			},
			slider4 = {
				template = "nrf_slider",
				Anchor = { "TOPRIGHT", "$parentslider3", "BOTTOMRIGHT", 0, -25 },
				vars = {
					text = "Party Scale",
					option = "partyscale",
					low = "0.5",
					high = "3",
					min = 0.5,
					max = 3,
					format = "%.2f",
					step = 0.01,
					func = function() Nurfed_UnitFrames_UpdateScale("party") end
				},
			},
		},
	},

	["Raids"] = {
		template = "nrf_options",
		children = {
			scroll = {
				template = "nrf_scroll",
				vars = { pages = 2 },
			},

			pane1 = {
				template = "nrf_optionpane",
				size = { 100, 100 },
				Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 5, -13 },
				children = {
					scroll = "nrf_panescroll",
					input = {
						template = "nrf_paneeditbox",
						size = { 85, 15 },
						Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 1, -1 },
					},
					row1 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentinput", "BOTTOMLEFT", 2, 0 },
					},
					row2 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow1", "BOTTOMLEFT", 0, 0 },
					},
					row3 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow2", "BOTTOMLEFT", 0, 0 },
					},
					row4 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow3", "BOTTOMLEFT", 0, 0 },
					},
					row5 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow4", "BOTTOMLEFT", 0, 0 },
					},
					row6 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow5", "BOTTOMLEFT", 0, 0 },
					},
					remove = {
						template = "nrf_button",
						Anchor = { "TOPLEFT", "$parent", "BOTTOMLEFT", 0, 0 },
						vars = { text = REMOVE },
						OnClick = function() Nurfed_Options_paneRemoveOption() end,
					},

					slider1 = {
						template = "nrf_slider",
						Anchor = { "TOPLEFT", "$parent", "TOPRIGHT", 150, -5 },
						vars = {
							text = NRF_SCALE,
							low = "25%",
							high = "300%",
							min = 0.25,
							max = 3,
							step = 0.01,
							format = "%.2f",
							default = 1,
							id = 1,
						},
					},
					slider2 = {
						template = "nrf_slider",
						Anchor = { "TOPRIGHT", "$parentslider1", "BOTTOMRIGHT", 0, -20 },
						vars = {
							text = NRF_COLUMNS,
							low = "1",
							high = "5",
							min = 1,
							max = 5,
							step = 1,
							format = "%.0f",
							default = 1,
							id = 2,
						},
					},
					slider3 = {
						template = "nrf_slider",
						Anchor = { "TOPRIGHT", "$parentslider2", "BOTTOMRIGHT", 0, -20 },
						vars = {
							text = NRF_XGAP,
							low = "0",
							high = "25",
							min = 0,
							max = 25,
							step = 1,
							format = "%.0f",
							default = 0,
							id = 3,
						},
					},
					slider4 = {
						template = "nrf_slider",
						Anchor = { "TOPRIGHT", "$parentslider3", "BOTTOMRIGHT", 0, -20 },
						vars = {
							text = NRF_YGAP,
							low = "0",
							high = "25",
							min = 0,
							max = 25,
							step = 1,
							format = "%.0f",
							default = 0,
							id = 4,
						},
					},
					slider5 = {
						template = "nrf_slider",
						Anchor = { "TOPRIGHT", "$parentslider4", "BOTTOMRIGHT", 0, -20 },
						vars = {
							text = NRF_LIMIT,
							low = "1",
							high = "40",
							min = 1,
							max = 40,
							step = 1,
							format = "%.0f",
							default = 20,
							id = 24,
						},
					},

					check18 = {
						template = "nrf_check",
						Anchor = { "TOPLEFT", "$parentremove", "BOTTOMLEFT", 0, -5 },
						vars = { text = HIDE, default = 0, id = 26 },
					},

					pane1 = {
						template = "nrf_optionpane",
						size = { 135, 95 },
						Anchor = { "TOPLEFT", "$parentcheck18", "BOTTOMLEFT", 0, -15 },
						vars = { text = "Class Filter" }
					},
					check1 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentpane1", "TOPLEFT", 2, -2 },
						vars = { text = NRF_MAGE, id = 5, color = { 0.41, 0.8, 0.94 } },
					},
					check2 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck1", "BOTTOMLEFT", 0, -3 },
						vars = { text = NRF_ROGUE, id = 6, color = { 1.0, 0.96, 0.41 } },
					},
					check3 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck2", "BOTTOMLEFT", 0, -3 },
						vars = { text = NRF_DRUID, id = 7, color = { 1.0, 0.49, 0.04 } },
					},
					check4 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck3", "BOTTOMLEFT", 0, -3 },
						vars = { text = NRF_SHAMAN, id = 8, color = { 0.96, 0.55, 0.73 } },
					},
					check5 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck4", "BOTTOMLEFT", 0, -3 },
						vars = { text = NRF_HUNTER, id = 9, color = { 0.67, 0.83, 0.45 } },
					},
					check6 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPRIGHT", "$parentpane1", "TOPRIGHT", -2, -2 },
						vars = { text = NRF_PRIEST, id = 10, right = true, color = { 1, 1, 1 } },
					},
					check7 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck6", "BOTTOMLEFT", 0, -3 },
						vars = { text = NRF_PALADIN, id = 11, right = true, color = { 0.96, 0.55, 0.73 } },
					},
					check8 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck7", "BOTTOMLEFT", 0, -3 },
						vars = { text = NRF_WARRIOR, id = 12, right = true, color = { 0.78, 0.61, 0.43 } },
					},
					check9 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck8", "BOTTOMLEFT", 0, -3 },
						vars = { text = NRF_WARLOCK, id = 13, right = true, color = { 0.58, 0.51, 0.79 } },
					},

					pane2 = {
						template = "nrf_optionpane",
						size = { 135, 75 },
						Anchor = { "BOTTOMLEFT", "$parentpane1", "BOTTOMRIGHT", 15, 0 },
						vars = { text = "Group Filter" }
					},
					check10 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentpane2", "TOPLEFT", 2, -2 },
						vars = { text = GROUP.." 1", id = 14 },
					},
					check11 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck10", "BOTTOMLEFT", 0, -3 },
						vars = { text = GROUP.." 2", id = 15 },
					},
					check12 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck11", "BOTTOMLEFT", 0, -3 },
						vars = { text = GROUP.." 3", id = 16 },
					},
					check13 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck12", "BOTTOMLEFT", 0, -3 },
						vars = { text = GROUP.." 4", id = 17 },
					},
					check14 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPRIGHT", "$parentpane2", "TOPRIGHT", -2, -2 },
						vars = { text = GROUP.." 5", id = 18, right = true },
					},
					check15 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck14", "BOTTOMLEFT", 0, -3 },
						vars = { text = GROUP.." 6", id = 19, right = true },
					},
					check16 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck15", "BOTTOMLEFT", 0, -3 },
						vars = { text = GROUP.." 7", id = 20, right = true },
					},
					check17 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck16", "BOTTOMLEFT", 0, -3 },
						vars = { text = GROUP.." 8", id = 21, right = true },
					},

					pane3 = {
						template = "nrf_optionpane",
						size = { 105, 76 },
						Anchor = { "TOPLEFT", "$parent", "TOPRIGHT", 10, 0 },
						children = {
							check1 = {
								template = "nrf_radio",
								Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 2, -5 },
								vars = { text = "10 Yards", index = 1 },
							},
							check2 = {
								template = "nrf_radio",
								Anchor = { "TOPLEFT", "$parentcheck1", "BOTTOMLEFT", 0, -3 },
								vars = { text = "30 Yards", index = 2 },
							},
							check3 = {
								template = "nrf_radio",
								Anchor = { "TOPLEFT", "$parentcheck2", "BOTTOMLEFT", 0, -3 },
								vars = { text = "100 Yards", index = 3 },
							},
							check4 = {
								template = "nrf_radio",
								Anchor = { "TOPLEFT", "$parentcheck3", "BOTTOMLEFT", 0, -3 },
								vars = { text = ALWAYS, index = 4 },
							},
						},
						vars = { text = "Range Filter", id = 22, default = 2, isradio = true },
					},

					pane4 = {
						template = "nrf_optionpane",
						size = { 125, 59 },
						Anchor = { "TOPLEFT", "$parentpane3", "BOTTOMLEFT", 0, -15 },
						children = {
							check1 = {
								template = "nrf_radio",
								Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 2, -5 },
								vars = { text = HEALTH, index = 1 },
							},
							check2 = {
								template = "nrf_radio",
								Anchor = { "TOPLEFT", "$parentcheck1", "BOTTOMLEFT", 0, -3 },
								vars = { text = MANA, index = 2 },
							},
							check3 = {
								template = "nrf_radio",
								Anchor = { "TOPLEFT", "$parentcheck2", "BOTTOMLEFT", 0, -3 },
								vars = { text = NAME, index = 3 },
							},
							check4 = {
								template = "nrf_radio",
								Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", -2, -5 },
								vars = { text = CLASS, right = true, index = 4 },
							},
							check5 = {
								template = "nrf_radio",
								Anchor = { "TOPRIGHT", "$parentcheck4", "BOTTOMRIGHT", 0, -3 },
								vars = { text = GROUP, right = true, index = 5 },
							},
						},
						vars = { text = "Sort By", id = 23, default = 1, isradio = true },
					},

					pane5 = {
						template = "nrf_optionpane",
						size = { 85, 55 },
						Anchor = { "BOTTOMLEFT", "$parentpane2", "BOTTOMRIGHT", 15, 0 },
						children = {
							check1 = {
								template = "nrf_radio",
								Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 2, -5 },
								vars = { text = HEALTH, index = 1, color = { 0, 1, 0 } },
							},
							check2 = {
								template = "nrf_radio",
								Anchor = { "TOPLEFT", "$parentcheck1", "BOTTOMLEFT", 0, -3 },
								vars = { text = MANA, index = 2, color = { 0, 1, 1 } },
							},
							check3 = {
								template = "nrf_radio",
								Anchor = { "TOPLEFT", "$parentcheck2", "BOTTOMLEFT", 0, -3 },
								vars = { text = "Both", index = 3 },
							},
						},
						vars = { text = "Bar Filter", id = 25, default = 3, isradio = true },
					},
				},
				vars = { text = "Raid Frames", option = "frames", rows = 6, page = 1, func = function() Nurfed_Raids_UpdateFrames() end },
			},

			pane2 = {
				template = "nrf_optionpane",
				size = { 100, 101 },
				Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 5, -13 },
				children = {
					scroll = "nrf_panescroll",
					input = {
						template = "nrf_paneeditbox",
						size = { 85, 15 },
						Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 1, -1 },
					},
					row1 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentinput", "BOTTOMLEFT", 2, 0 },
					},
					row2 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow1", "BOTTOMLEFT", 0, 0 },
					},
					row3 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow2", "BOTTOMLEFT", 0, 0 },
					},
					row4 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow3", "BOTTOMLEFT", 0, 0 },
					},
					row5 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow4", "BOTTOMLEFT", 0, 0 },
					},
					row6 = {
						template = "nrf_pane_row",
						size = { 85, 13 },
						Anchor = { "TOPLEFT", "$parentrow5", "BOTTOMLEFT", 0, 0 },
					},
					remove = {
						template = "nrf_button",
						Anchor = { "TOPLEFT", "$parent", "BOTTOMLEFT", 0, 0 },
						vars = { text = REMOVE },
						OnClick = function() Nurfed_Options_paneRemoveOption() end,
					},

					pane1 = {
						template = "nrf_optionpane",
						size = { 120, 80 },
						Anchor = { "TOPLEFT", "$parent", "TOPRIGHT", 15, 0 },
						vars = { text = "Permissions" }
					},
					check1 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentpane1", "TOPLEFT", 2, -2 },
						vars = { text = PVP_RANK_LEADER, id = 1 },
					},
					check2 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck1", "BOTTOMLEFT", 0, -3 },
						vars = { text = "Assist", id = 2 },
					},
					check3 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck2", "BOTTOMLEFT", 0, -3 },
						vars = { text = RAID_CONTROL, id = 3 },
					},
					check4 = {
						template = "nrf_smallcheck",
						Anchor = { "TOPLEFT", "$parentcheck3", "BOTTOMLEFT", 0, -3 },
						vars = { text = READY_CHECK, id = 4 },
					},
				},
				vars = { text = "Raid Users", option = "permissions", up = true, rows = 6, page = 2 },
			},

			slider1 = {
				template = "nrf_slider",
				Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", -30, -15 },
				vars = {
					text = "Frame Update Rate",
					option = "updaterate",
					low = "0.25",
					high = "3",
					min = 0.25,
					max = 3,
					format = "%.2f",
					step = 0.01,
					page = 2,
					func = function() Nurfed_Raids_SetRate() end,
				},
			},
			check1 = {
				template = "nrf_check",
				Anchor = { "TOPRIGHT", "$parentslider1", "BOTTOMRIGHT", 0, -15 },
				vars = { text = "Show Rank", option = "showrank", right = true, page = 2, func = function() Nurfed_Raids_UpdateFrames() end },
			},
			check2 = {
				template = "nrf_smallcheck",
				Anchor = { "TOPLEFT", "$parentpane2", "BOTTOMLEFT", 0, -20 },
				vars = { text = "Show Aura Frame", option = "showauras", page = 2, func = function() Nurfed_Raids_UpdateAuras() end },
			},
			check3 = {
				template = "nrf_smallcheck",
				Anchor = { "TOPLEFT", "$parentcheck2", "BOTTOMLEFT", 0, -5 },
				vars = { text = "Filter Auras", option = "aurafilter", page = 2, func = function() Nurfed_Raids_UpdateAuras() end },
			},
			check4 = {
				template = "nrf_smallcheck",
				Anchor = { "TOPLEFT", "$parentcheck3", "BOTTOMLEFT", 0, -5 },
				vars = { text = "Only In Range", option = "aurarange", page = 2, func = function() Nurfed_Raids_UpdateAuras() end },
			},
			slider2 = {
				template = "nrf_slider",
				Anchor = { "TOPLEFT", "$parentcheck4", "BOTTOMLEFT", 0, -15 },
				vars = {
					text = "Aura Columns",
					option = "auracolumns",
					low = "1",
					high = "5",
					min = 1,
					max = 5,
					format = "%.0f",
					step = 1,
					page = 2,
					func = function() Nurfed_Raids_UpdateAuras() end,
				},
			},
			slider3 = {
				template = "nrf_slider",
				Anchor = { "TOPLEFT", "$parentslider2", "BOTTOMLEFT", 0, -15 },
				vars = {
					text = "Aura Limit",
					option = "auralimit",
					low = "1",
					high = "40",
					min = 1,
					max = 40,
					format = "%.0f",
					step = 1,
					page = 2,
					func = function() Nurfed_Raids_UpdateAuras() end,
				},
			},
		},
	},
};