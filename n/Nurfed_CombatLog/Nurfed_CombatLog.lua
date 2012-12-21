
NURFED_COMBATLOG_VERS = "06.22.2006";
NURFED_COMBATLOG_DEFAULT = {
	You = { (0/255), (192/255), (255/255) },
	Pet = { (0/255), (153/255), (102/255) },
	Party = { (255/255), (153/255), (0/255) },
	Raid = { (251/255), (210/255), (132/255) },
	Enemy = { (255/255), (116/255), (109/255) },
	Target = { (255/255), (116/255), (109/255) },
	Friendly = { (251/255), (210/255), (132/255) },
	[HEALTH] = { (255/255), (0/255), (0/255) },
	[MANA] = { (0/255), (255/255), (255/255) },
	[RAGE] = { 1, 0, 0 },
	[ENERGY] = { 1, 1, 0 },
	[HAPPINESS] = { 1, 0.5, 0.25 },
	[SPELL_SCHOOL0_CAP] = { (255/255), (255/255), (150/255) },
	[SPELL_SCHOOL1_CAP] = { (255/255), (255/255), (0/255) },
	[SPELL_SCHOOL2_CAP] = { (255/255), (0/255), (0/255) },
	[SPELL_SCHOOL3_CAP] = { (0/255), (102/255), (0/255) },
	[SPELL_SCHOOL4_CAP] = { (0/255), (102/255), (255/255) },
	[SPELL_SCHOOL5_CAP] = { (202/255), (76/255), (217/255) },
	[SPELL_SCHOOL6_CAP] = { (153/255), (204/255), (255/255) },
	Heal = { (96/255), (255/255), (99/255) },
	[MISS] = { (0/255), (255/255),  (255/255) },
	damage = { (255/255), (47/255), (47/255) },
	overlay = { (255/255), (255/255), (0/255) },
	buff = { (255/255), (255/255), (0/255) },
	debuff = { (255/255), (255/255), (0/255) },
	cast = { (255/255), (255/255), (0/255) },
	source = "[$n]",
	target = "[$n]",
	death = "--** $n",
	crit = "*$d*",
	spellalert = "Begins to cast $s",
	deathout = 2,
	destroyed = 1,
	watches = {
		[YOU] = { 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
	},
};

local utility = Nurfed_Utility:New();
local lib = Nurfed_CombatLog:New();
local framelib = Nurfed_Frames:New();

local eventframe = {
	type = "Frame",
	events = {
	},
	OnEvent = function() lib:ParseEvent(event, arg1) end,
};

local config = {
	type = "Frame",
	Anchor = { "TOP", "$parenttitlebg", "BOTTOM", 0, -1 },
	children = {
		page1 = {
			type = "Frame",
			Anchor = "all",
			children = {
				swatch1 = {
					template = "Nurfed_OptionColorSwatch",
					properties = {
						Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 0, 0 },
						vars = {
							text = YOU,
							option = "You",
						},
					},
				},
				swatch2 = {
					template = "Nurfed_OptionColorSwatch",
					properties = {
						Anchor = { "TOPLEFT", "$parentswatch1", "BOTTOMLEFT", 0, -3 },
						vars = {
							text = PET,
							option = "Pet",
						},
					},
				},
				swatch3 = {
					template = "Nurfed_OptionColorSwatch",
					properties = {
						Anchor = { "TOPLEFT", "$parentswatch2", "BOTTOMLEFT", 0, -3 },
						vars = {
							text = PARTY,
							option = "Party",
						},
					},
				},
					swatch4 = {
					template = "Nurfed_OptionColorSwatch",
					properties = {
						Anchor = { "TOPLEFT", "$parentswatch3", "BOTTOMLEFT", 0, -3 },
						vars = {
							text = RAID,
							option = "Raid",
						},
					},
				},
				swatch5 = {
					template = "Nurfed_OptionColorSwatch",
					properties = {
						Anchor = { "TOPLEFT", "$parentswatch4", "BOTTOMLEFT", 0, -3 },
						vars = {
							text = FACTION_OTHER,
							option = "Enemy",
						},
					},
				},
				swatch6 = {
					template = "Nurfed_OptionColorSwatch",
					properties = {
						Anchor = { "TOPLEFT", "$parentswatch5", "BOTTOMLEFT", 0, -3 },
						vars = {
							text = NRF_TARGET,
							option = "Target",
						},
					},
				},
				swatch7 = {
					template = "Nurfed_OptionColorSwatch",
					properties = {
						Anchor = { "TOPLEFT", "$parentswatch6", "BOTTOMLEFT", 0, -3 },
						vars = {
							text = HEALTH,
							option = HEALTH,
						},
					},
				},
				swatch8 = {
					template = "Nurfed_OptionColorSwatch",
					properties = {
						Anchor = { "TOPLEFT", "$parentswatch7", "BOTTOMLEFT", 0, -3 },
						vars = {
							text = MANA,
							option = MANA,
						},
					},
				},
				swatch9 = {
					template = "Nurfed_OptionColorSwatch",
					properties = {
						Anchor = { "TOPLEFT", "$parentswatch8", "BOTTOMLEFT", 0, -3 },
						vars = {
							text = RAGE,
							option = RAGE,
						},
					},
				},
				swatch10 = {
					template = "Nurfed_OptionColorSwatch",
					properties = {
						Anchor = { "TOPLEFT", "$parentswatch9", "BOTTOMLEFT", 0, -3 },
						vars = {
							text = ENERGY,
							option = ENERGY,
						},
					},
				},
				swatch11 = {
					template = "Nurfed_OptionColorSwatch",
					properties = {
						Anchor = { "TOPLEFT", "$parentswatch10", "BOTTOMLEFT", 0, -3 },
						vars = {
							text = HAPPINESS,
							option = HAPPINESS,
						},
					},
				},

				swatch12 = {
					template = "Nurfed_OptionColorSwatch",
					properties = {
						Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", 0, 0 },
						vars = {
							right = true,
							text = SPELL_SCHOOL0_CAP,
							option = SPELL_SCHOOL0_CAP,
						},
					},
				},
				swatch13 = {
					template = "Nurfed_OptionColorSwatch",
					properties = {
						Anchor = { "TOPRIGHT", "$parentswatch12", "BOTTOMRIGHT", 0, -3 },
						vars = {
							right = true,
							text = SPELL_SCHOOL1_CAP,
							option = SPELL_SCHOOL1_CAP,
						},
					},
				},
				swatch14 = {
					template = "Nurfed_OptionColorSwatch",
					properties = {
						Anchor = { "TOPRIGHT", "$parentswatch13", "BOTTOMRIGHT", 0, -3 },
						vars = {
							right = true,
							text = SPELL_SCHOOL2_CAP,
							option = SPELL_SCHOOL2_CAP,
						},
					},
				},
				swatch15 = {
					template = "Nurfed_OptionColorSwatch",
					properties = {
						Anchor = { "TOPRIGHT", "$parentswatch14", "BOTTOMRIGHT", 0, -3 },
						vars = {
							right = true,
							text = SPELL_SCHOOL3_CAP,
							option = SPELL_SCHOOL3_CAP,
						},
					},
				},
				swatch16 = {
					template = "Nurfed_OptionColorSwatch",
					properties = {
						Anchor = { "TOPRIGHT", "$parentswatch15", "BOTTOMRIGHT", 0, -3 },
						vars = {
							right = true,
							text = SPELL_SCHOOL4_CAP,
							option = SPELL_SCHOOL4_CAP,
						},
					},
				},
				swatch17 = {
					template = "Nurfed_OptionColorSwatch",
					properties = {
						Anchor = { "TOPRIGHT", "$parentswatch16", "BOTTOMRIGHT", 0, -3 },
						vars = {
							right = true,
							text = SPELL_SCHOOL5_CAP,
							option = SPELL_SCHOOL5_CAP,
						},
					},
				},
				swatch18 = {
					template = "Nurfed_OptionColorSwatch",
					properties = {
						Anchor = { "TOPRIGHT", "$parentswatch17", "BOTTOMRIGHT", 0, -3 },
						vars = {
							right = true,
							text = SPELL_SCHOOL6_CAP,
							option = SPELL_SCHOOL6_CAP,
						},
					},
				},
				swatch19 = {
					template = "Nurfed_OptionColorSwatch",
					properties = {
						Anchor = { "TOPRIGHT", "$parentswatch18", "BOTTOMRIGHT", 0, -3 },
						vars = {
							right = true,
							text = NRF_HEAL,
							option = "Heal",
						},
					},
				},
				swatch20 = {
					template = "Nurfed_OptionColorSwatch",
					properties = {
						Anchor = { "TOPRIGHT", "$parentswatch19", "BOTTOMRIGHT", 0, -3 },
						vars = {
							right = true,
							text = MISS,
							option = MISS,
						},
					},
				},
				swatch21 = {
					template = "Nurfed_OptionColorSwatch",
					properties = {
						Anchor = { "TOPRIGHT", "$parentswatch20", "BOTTOMRIGHT", 0, -3 },
						vars = {
							right = true,
							text = DAMAGE,
							option = "damage",
						},
					},
				},
				swatch22 = {
					template = "Nurfed_OptionColorSwatch",
					properties = {
						Anchor = { "TOPRIGHT", "$parentswatch21", "BOTTOMRIGHT", 0, -3 },
						vars = {
							right = true,
							text = NRF_CRITOVERLAY,
							option = "overlay",
						},
					},
				},
				swatch23 = {
					template = "Nurfed_OptionColorSwatch",
					properties = {
						Anchor = { "TOPRIGHT", "$parentswatch22", "BOTTOMRIGHT", 0, -3 },
						vars = {
							right = true,
							text = NRF_BUFFS,
							option = "buff",
						},
					},
				},
				swatch24 = {
					template = "Nurfed_OptionColorSwatch",
					properties = {
						Anchor = { "TOPRIGHT", "$parentswatch23", "BOTTOMRIGHT", 0, -3 },
						vars = {
							right = true,
							text = NRF_DEBUFFS,
							option = "debuff",
						},
					},
				},
				swatch25 = {
					template = "Nurfed_OptionColorSwatch",
					properties = {
						Anchor = { "TOPLEFT", "$parentswatch11", "BOTTOMLEFT", 0, -3 },
						vars = {
							text = SPELLS,
							option = "cast",
						},
					},
				},
			},
		},
		page2 = {
			type = "Frame",
			Anchor = "all",
			children = {
				input1 = {
					template = "Nurfed_OptionInput",
					properties = {
						Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 0, 0 },
						vars = {
							text = NRF_SOURCE,
							option = "source",
						},
					},
				},
				input2 = {
					template = "Nurfed_OptionInput",
					properties = {
						Anchor = { "TOPLEFT", "$parentinput1", "BOTTOMLEFT", 0, -5 },
						vars = {
							text = NRF_TARGET,
							option = "target",
						},
					},
				},
				input3 = {
					template = "Nurfed_OptionInput",
					properties = {
						Anchor = { "TOPLEFT", "$parentinput2", "BOTTOMLEFT", 0, -5 },
						vars = {
							text = TUTORIAL_TITLE25,
							option = "death",
						},
					},
				},
				input4 = {
					template = "Nurfed_OptionInput",
					properties = {
						Anchor = { "TOPLEFT", "$parentinput3", "BOTTOMLEFT", 0, -5 },
						vars = {
							text = NRF_CRIT,
							option = "crit",
						},
					},
				},
				input5 = {
					template = "Nurfed_OptionInput",
					properties = {
						Anchor = { "TOPLEFT", "$parentinput4", "BOTTOMLEFT", 0, -5 },
						vars = {
							text = SPELLS,
							option = "spellalert",
						},
					},
				},
				slider1 = {
					template = "Nurfed_OptionSlider",
					properties = {
						Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", -2, -12 },
						vars = {
							text = NRF_DEATHOUT,
							option = "deathout",
							max = 7,
							min = 0,
							step = 1,
							format = "%.0f",
						},
					},
				},
				check1 = {
					template = "Nurfed_OptionCheck",
					properties = {
						Anchor = { "TOPRIGHT", "$parentslider1", "BOTTOMRIGHT", 0, -15 },
						vars = {
							right = true,
							text = NRF_SHOWDESTROYED,
							option = "destroyed",
						},
					},
				},
			},
		},
		page3 = {
			type = "Frame",
			Anchor = "all",
			children = {
				input1 = {
					template = "Nurfed_OptionInputSelect",
					properties = {
						Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 0, 0 },
						children = {
							slider1 = {
								template = "Nurfed_OptionSlider",
								properties = {
									Anchor = { "TOPLEFT", "$parent", "TOPRIGHT", 100, -13 },
									vars = {
										text = NRF_OUTPUT,
										id = 1,
										max = 7,
										min = 1,
										step = 1,
										init = 2,
										format = "%.0f",
									},
								},
							},
							check1 = {
								template = "Nurfed_OptionCheck",
								properties = {
									Anchor = { "TOPLEFT", "$parent", "TOPRIGHT", 2, -2 },
									vars = {
										text = NRF_HEAL,
										id = 2,
										init = 1,
									},
								},
							},
							check2 = {
								template = "Nurfed_OptionCheck",
								properties = {
									Anchor = { "TOPLEFT", "$parentcheck1", "BOTTOMLEFT", 0, -3 },
									vars = {
										text = NRF_HIT,
										id = 3,
										init = 1,
									},
								},
							},
							check3 = {
								template = "Nurfed_OptionCheck",
								properties = {
									Anchor = { "TOPLEFT", "$parentcheck2", "BOTTOMLEFT", 0, -3 },
									vars = {
										text = SPELLS,
										id = 4,
										init = 1,
									},
								},
							},
							check4 = {
								template = "Nurfed_OptionCheck",
								properties = {
									Anchor = { "TOPLEFT", "$parentcheck3", "BOTTOMLEFT", 0, -3 },
									vars = {
										text = NRF_DOT,
										id = 5,
										init = 1,
									},
								},
							},
							check5 = {
								template = "Nurfed_OptionCheck",
								properties = {
									Anchor = { "TOPLEFT", "$parentcheck4", "BOTTOMLEFT", 0, -3 },
									vars = {
										text = NRF_SPELLMISS,
										id = 6,
										init = 1,
									},
								},
							},
							check6 = {
								template = "Nurfed_OptionCheck",
								properties = {
									Anchor = { "TOPLEFT", "$parentcheck5", "BOTTOMLEFT", 0, -3 },
									vars = {
										text = NRF_ENVIRONMENT,
										id = 7,
										init = 1,
									},
								},
							},
							check7 = {
								template = "Nurfed_OptionCheck",
								properties = {
									Anchor = { "TOPLEFT", "$parentcheck6", "BOTTOMLEFT", 0, -3 },
									vars = {
										text = NRF_POWERGAIN,
										id = 8,
										init = 1,
									},
								},
							},
							check8 = {
								template = "Nurfed_OptionCheck",
								properties = {
									Anchor = { "TOPLEFT", "$parentcheck7", "BOTTOMLEFT", 0, -3 },
									vars = {
										text = NRF_DEBUFFS,
										id = 9,
										init = 1,
									},
								},
							},

							check9 = {
								template = "Nurfed_OptionCheck",
								properties = {
									Anchor = { "TOPRIGHT", "$parentslider1", "BOTTOMRIGHT", 0, -8 },
									vars = {
										right = true,
										text = NRF_BUFFS,
										id = 10,
										init = 1,
									},
								},
							},
							check10 = {
								template = "Nurfed_OptionCheck",
								properties = {
									Anchor = { "TOPRIGHT", "$parentcheck9", "BOTTOMRIGHT", 0, -3 },
									vars = {
										right = true,
										text = NRF_AURAFADE,
										id = 11,
										init = 1,
									},
								},
							},
							check11 = {
								template = "Nurfed_OptionCheck",
								properties = {
									Anchor = { "TOPRIGHT", "$parentcheck10", "BOTTOMRIGHT", 0, -3 },
									vars = {
										right = true,
										text = NRF_MELEEMISS,
										id = 12,
										init = 1,
									},
								},
							},
							check12 = {
								template = "Nurfed_OptionCheck",
								properties = {
									Anchor = { "TOPRIGHT", "$parentcheck11", "BOTTOMRIGHT", 0, -3 },
									vars = {
										right = true,
										text = NRF_RESIST,
										id = 13,
										init = 1,
									},
								},
							},
							check13 = {
								template = "Nurfed_OptionCheck",
								properties = {
									Anchor = { "TOPRIGHT", "$parentcheck12", "BOTTOMRIGHT", 0, -3 },
									vars = {
										right = true,
										text = NRF_SPELLFAIL,
										id = 14,
										init = 1,
									},
								},
							},
							check14 = {
								template = "Nurfed_OptionCheck",
								properties = {
									Anchor = { "TOPRIGHT", "$parentcheck13", "BOTTOMRIGHT", 0, -3 },
									vars = {
										right = true,
										text = NRF_CAST,
										id = 15,
										init = 1,
									},
								},
							},
							check15 = {
								template = "Nurfed_OptionCheck",
								properties = {
									Anchor = { "TOPRIGHT", "$parentcheck14", "BOTTOMRIGHT", 0, -3 },
									vars = {
										right = true,
										text = NRF_PERFORM,
										id = 16,
										init = 1,
									},
								},
							},
						},
						vars = {
							text = VOICEMACRO_1_Or_0,
							option = "watches",
						},
					},
				},
			},
		},

		tab1 = {
			template = "Nurfed_OptionTab",
			properties = {
				Anchor = { "TOPLEFT", "$parent", "BOTTOMLEFT", 0, -1 },
				vars = {
					text = COLOR,
					page = 1,
				},
			},
		},
		tab2 = {
			template = "Nurfed_OptionTab",
			properties = {
				Anchor = { "LEFT", "$parenttab1", "RIGHT", 3, 0 },
				vars = {
					text = NRF_FORMATS,
					page = 2,
				},
			},
		},
		tab3 = {
			template = "Nurfed_OptionTab",
			properties = {
				Anchor = { "LEFT", "$parenttab2", "RIGHT", 3, 0 },
				vars = {
					text = VOICEMACRO_1_Or_0,
					page = 3,
				},
			},
		},
	},
	vars = { width = 350, height = 300, page = 1 },
};


function Nurfed_CombatLog_Init()
	if (eventframe) then
		for event in ChatTypeGroup do
			for e, l in lib.events do
				if (string.find(event, e, 1, true)) then
					table.insert(eventframe.events, "CHAT_MSG_"..event);
				end
			end
		end

		-- CombatMessageAmbigousfix by No-Nonsense
		if (GetLocale() == "deDE" and not IsAddOnLoaded("CombatMessagesAmbigousFix")) then
			local COMBAT_MESSAGES = {
				"SPELLLOGCRITOTHEROTHER",
				"SPELLLOGOTHEROTHER",
				"SPELLLOGCRITSCHOOLOTHERSELF",
				"SPELLLOGCRITSCHOOLOTHEROTHER",
				"SPELLLOGSCHOOLOTHERSELF",
				"SPELLLOGSCHOOLOTHEROTHER",
				"SPELLSPLITDAMAGEOTHEROTHER",
				"SPELLSPLITDAMAGEOTHERSELF",
				"SPELLRESISTOTHEROTHER",
				"PERIODICAURAHEALOTHEROTHER",
				"HEALEDCRITOTHEROTHER",
				"HEALEDCRITOTHERSELF",
				"HEALEDOTHEROTHER"
			};
			for _, cmsg in COMBAT_MESSAGES do
				local fixcode = cmsg .. '= string.gsub(string.gsub(' .. cmsg .. ', "(%%%d%$s)s", "%1\'s"), "%%ss", "%%s\'s")';
				RunScript(fixcode);
			end
			local COMBAT_MESSAGES = nil;
		end

		framelib:ObjectInit("Nurfed_CombatLogFrame", eventframe, UIParent);
		framelib:ObjectInit("Nurfed_CombatLog_Menu", config, Nurfed_OptionsFrame);
		config = nil;
		eventframe = nil;
		lib:Init();
	end
end

function nctest(num)
	if (not num or type(num) ~= "number") then
		utility:Print("Usage: nctest(number)");
		return;
	end
	local now = GetTime();
	for i=1, num do
		lib:ParseEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE", "Bob's Fireball crits You for 2000."..GLANCING_TRAILER)
	end
	utility:Print(num.." CombatLog Events Completed in "..format("%.3f", GetTime() - now));
end