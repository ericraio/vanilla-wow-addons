local L = AceLibrary("AceLocale-2.2"):new("Buffalo")

Buffalo_OptionsTable={
	type='group',
--	name="Buffalo",
	args= {
		lock = {
			type='toggle',
			name=L["Lock"],
			desc=L["When activated, the buff frames are locked and the reference frames are hidden"],
			get= function() return Buffalo.db.profile.locked end,
			set = function(v) Buffalo.ToggleLock(Buffalo, v) end,
			order=1
		},

		buffs = {
			type='group',
			name=L["Buffs"],
			desc=L["Manipulate Buffs Display"],
			order=2,
			args={

				title={
					type='header',
					name=L["Buffs"],
--					icon="Interface\\Icons\\Ability_DualWield.blp",
					order=5
				},
				scale={
					type='range',
					name=L["Scale"],
					desc=L["Scale Buff Icons"],
					min=0,
					max=10,
					step=0.1,
					get = function() return Buffalo.db.profile.scale["buff"] end,
					set = function(v) Buffalo.SetScale(Buffalo, v, "buff") end,
					order=10
				},

				padding={
					type='group',
					name=L["Padding"],
					desc=L["Control the distance between rows/columns"],
					args={
						x={
							type='range',
							name=L["X-Padding"],
							desc=L["Distance between columns"],
							min=-10,
							max=100,
							step=1,
							get = function() return Buffalo.db.profile.padding["buff"].x end,
							set = function(v) Buffalo.SetPadding(Buffalo, v, "buff", "x") end
						},

						y={
							type='range',
							name=L["Y-Padding"],
							desc=L["Distance between rows"],
							min=-10,
							max=100,
							step=1,
							get = function() return Buffalo.db.profile.padding["buff"].y end,
							set = function(v) Buffalo.SetPadding(Buffalo, v, "buff", "y") end
						}
					},
					order=20
				},


				hGrowth={
					type='text',
					name=L["Horizontal Direction"],
					desc=L["In which horizontal direction should the display grow?"],
					get=function()
							if Buffalo.db.profile.growRight.buff then
								return "right"
							else
								return "left"
							end
						end,
					set=function(v) Buffalo.SetGrowthDirection(Buffalo, v, "buff") end,
					validate = {["left"] = L["To the left"], ["right"]=L["To the right"]},
					order=30
				},

				vGrowth={
					type='text',
					name=L["Vertical Direction"],
					desc=L["In which vertical direction should the display grow?"],
					get=function()
							if Buffalo.db.profile.growUpwards.buff then
								return "up"
							else
								return "down"
							end
						end,
					set=function(v) Buffalo.SetGrowthDirection(Buffalo, v, "buff") end,
					validate = {["up"] = L["Upwards"], ["down"]=L["Downwards"]},
					order=40
				},

				firstGrowth={
					type='text',
					name=L["Growth Precedence"],
					desc=L["In which direction should the display grow first (horizontally or vertically)?"],
					get=function() return Buffalo.db.profile.growHorizontalFirst.buff end,
					set=function(v) Buffalo.SetGrowHorizontalFirst(Buffalo, v, "buff")end,
					validate = {[true] = L["Horizontally"], [false]=L["Vertically"]},
					order=50
				},

				rows={
					type='range',
					name=L["Rows"],
					desc=L["Number of Rows. Only applies when Growth Precedence is Vertical"],
					min=1,
					max=16,
					step=1,
					get = function() return Buffalo.db.profile.rows["buff"] end,
					set = function(v) Buffalo.SetRows(Buffalo, v, "buff") end,
					order=60
				},

				cols={
					type='range',
					name=L["Columns"],
					desc=L["Number of Columns. Only applies when Growth Precedence is Horizontal"],
					min=1,
					max=16,
					step=1,
					get = function() return Buffalo.db.profile.cols["buff"] end,
					set = function(v) Buffalo.SetCols(Buffalo, v, "buff") end,
					order=70
				},
				hide = {
					type='toggle',
					name=L["Hide"],
					desc=L["Hides these buff frames"],
					get= function() return Buffalo.db.profile.hide["buff"] end,
					set = function(v) Buffalo.ToggleHide(Buffalo, v, "buff") end,
					order=90
				},
				flashing = {
					type='toggle',
					name=L["Flashing"],
					desc=L["Toggle flashing on fading buffs"],
					get= function() return Buffalo.db.profile.flashes["buff"] end,
					set = function(v) Buffalo.db.profile.flashes["buff"] = v end,
					order=95
				},
				timers = {
					type='group',
					name=L["Timers"],
					desc=L["Customize buff timers"],
					order=100,
					args = {
						verboseTimer = {
							type='toggle',
							name=L["Verbose Timers"],
							desc=L["Replaces the default time format for timers with HH:MM or MM:SS"],
							get= function() return Buffalo.db.profile.verboseTimers["buff"] end,
							set = function(v) Buffalo.db.profile.verboseTimers["buff"] = v end,
							order=100
						},
						whiteTimer = {
							type='toggle',
							name=L["White Timers"],
							desc=L["Use white timers instead of yellow ones"],
							get= function() return Buffalo.db.profile.whiteTimers["buff"] end,
							set = function(v) Buffalo.db.profile.whiteTimers["buff"] = v end,
							disabled = function() return not Buffalo.db.profile.verboseTimers["buff"] end,
							order=110
						},
					},
				},
			}
		},

		debuffs = {
			type='group',
			name=L["Debuffs"],
			desc=L["Manipulate Debuffs Display"],
			order=3,
			args={
				title={
					type='header',
					name=L["Debuffs"],
--					icon="Interface\\Icons\\Ability_DualWield.blp",
					order=10
				},
				scale={
					type='range',
					name=L["Scale"],
					desc=L["Scale Debuff Icons"],
					min=0,
					max=10,
					get = function() return Buffalo.db.profile.scale["debuff"] end,
					set = function(v) Buffalo.SetScale(Buffalo, v, "debuff") end,
					order=20
				},

				padding={
					type='group',
					name=L["Padding"],
					desc=L["Control the distance between rows/columns"],
					args={
						x={
							type='range',
							name=L["X-Padding"],
							desc=L["Distance between columns"],
							min=-10,
							max=100,
							step=1,
							get = function() return Buffalo.db.profile.padding["debuff"].x end,
							set = function(v) Buffalo.SetPadding(Buffalo, v, "debuff", "x") end
						},

						y={
							type='range',
							name=L["Y-Padding"],
							desc=L["Distance between rows"],
							min=-10,
							max=100,
							step=1,
							get = function() return Buffalo.db.profile.padding["debuff"].y end,
							set = function(v) Buffalo.SetPadding(Buffalo, v, "debuff", "y") end
						}
					},
					order=30
				},


				hGrowth={
					type='text',
					name=L["Horizontal Direction"],
					desc=L["In which horizontal direction should the display grow?"],
					get=function()
							if Buffalo.db.profile.growRight.debuff then
								return "right"
							else
								return "left"
							end
						end,
					set=function(v) Buffalo.SetGrowthDirection(Buffalo, v, "debuff") end,
					validate = {["left"] = L["To the left"], ["right"]=L["To the right"]},
					order=40
				},

				vGrowth={
					type='text',
					name=L["Vertical Direction"],
					desc=L["In which vertical direction should the display grow?"],
					get=function()
							if Buffalo.db.profile.growUpwards.debuff then
								return "up"
							else
								return "down"
							end
						end,
					set=function(v) Buffalo.SetGrowthDirection(Buffalo, v, "debuff") end,
					validate = {["up"] = L["Upwards"], ["down"]=L["Downwards"]},
					order=50
				},

				firstGrowth={
					type='text',
					name=L["Growth Precedence"],
					desc=L["In which direction should the display grow first (horizontally or vertically)?"],
					get=function() return Buffalo.db.profile.growHorizontalFirst.debuff end,
					set=function(v) Buffalo.SetGrowHorizontalFirst(Buffalo, v, "debuff") end,
					validate = {[true] = L["Horizontally"], [false]=L["Vertically"]},
					order=60
				},

				rows={
					type='range',
					name=L["Rows"],
					desc=L["Number of Rows. Only applies when Growth Precedence is Vertical"],
					min=1,
					max=16,
					step=1,
					get = function() return Buffalo.db.profile.rows["debuff"] end,
					set = function(v) Buffalo.SetRows(Buffalo, v, "debuff") end,
					order=70
				},

				cols={
					type='range',
					name=L["Columns"],
					desc=L["Number of Columns. Only applies when Growth Precedence is Horizontal"],
					min=1,
					max=16,
					step=1,
					get = function() return Buffalo.db.profile.cols["debuff"] end,
					set = function(v) Buffalo.SetCols(Buffalo, v, "debuff") end,
					order=80
				},
				hide = {
					type='toggle',
					name=L["Hide"],
					desc=L["Hides these buff frames"],
					get= function() return Buffalo.db.profile.hide["debuff"] end,
					set = function(v) Buffalo.ToggleHide(Buffalo, v, "debuff") end,
					order=90
				},
				flashing = {
					type='toggle',
					name=L["Flashing"],
					desc=L["Toggle flashing on fading buffs"],
					get= function() return Buffalo.db.profile.flashes["debuff"] end,
					set = function(v) Buffalo.db.profile.flashes["debuff"] = v end,
					order=95
				},
				timers = {
					type='group',
					name=L["Timers"],
					desc=L["Customize buff timers"],
					order=100,
					args = {
						verboseTimer = {
							type='toggle',
							name=L["Verbose Timers"],
							desc=L["Replaces the default time format for timers with HH:MM or MM:SS"],
							get= function() return Buffalo.db.profile.verboseTimers["debuff"] end,
							set = function(v) Buffalo.db.profile.verboseTimers["debuff"] = v end,
							order=100
						},
						whiteTimer = {
							type='toggle',
							name=L["White Timers"],
							desc=L["Use white timers instead of yellow ones"],
							get= function() return Buffalo.db.profile.whiteTimers["debuff"] end,
							set = function(v) Buffalo.db.profile.whiteTimers["debuff"] = v end,
							disabled = function() return not Buffalo.db.profile.verboseTimers["debuff"] end,
							order=110
						},
					},
				},
			}
		},

		weapon = {
			type='group',
			name=L["Weapon Buffs"],
			desc=L["Manipulate Weapon Buffs Display"],
			order=4,
			args={
				title={
					type='header',
					name=L["Weapon Buffs"],
					icon="Interface\\Icons\\Ability_DualWield.blp",
					order=1
				},
				scale={
					type='range',
					name=L["Scale"],
					desc=L["Scale Buff Icons"],
					min=0,
					max=10,
					get = function() return Buffalo.db.profile.scale["weapon"] end,
					set = function(v) Buffalo.SetScale(Buffalo, v, "weapon") end,
					order=2
				},

				padding={
					type='group',
					name=L["Padding"],
					desc=L["Control the distance between rows/columns"],
					args={
						x={
							type='range',
							name=L["X-Padding"],
							desc=L["Distance between columns"],
							min=-10,
							max=100,
							step=1,
							get = function() return Buffalo.db.profile.padding["weapon"].x end,
							set = function(v) Buffalo.SetPadding(Buffalo, v, "weapon", "x") end
						},

						y={
							type='range',
							name=L["Y-Padding"],
							desc=L["Distance between rows"],
							min=-10,
							max=100,
							step=1,
							get = function() return Buffalo.db.profile.padding["weapon"].y end,
							set = function(v) Buffalo.SetPadding(Buffalo, v, "weapon", "y") end
						}
					},
					order=3
				},


				hGrowth={
					type='text',
					name=L["Horizontal Direction"],
					desc=L["In which horizontal direction should the display grow?"],
					get=function() 
							if Buffalo.db.profile.growRight.weapon then
								return "right"
							else
								return "left"
							end
						end,
					set=function(v) Buffalo.SetGrowthDirection(Buffalo, v, "weapon") end,
					validate = {["left"] = L["To the left"], ["right"]=L["To the right"]},
					order=4
				}, 

				vGrowth={
					type='text',
					name=L["Vertical Direction"],
					desc=L["In which vertical direction should the display grow?"],
					get=function() 
							if Buffalo.db.profile.growUpwards.weapon then
								return "up"
							else
								return "down"
							end
						end,
					set=function(v) Buffalo.SetGrowthDirection(Buffalo, v, "weapon") end,
					validate = {["up"] = L["Upwards"], ["down"]=L["Downwards"]},
					order=5
				},

				firstGrowth={
					type='text',
					name=L["Growth Precedence"],
					desc=L["In which direction should the display grow first (horizontally or vertically)?"],
					get=function() return Buffalo.db.profile.growHorizontalFirst.weapon end,
					set=function(v) Buffalo.SetGrowHorizontalFirst(Buffalo, v, "weapon")end,
					validate = {[true] = L["Horizontally"], [false]=L["Vertically"]},
					order=6
				},

				rows={
					type='range',
					name=L["Rows"],
					desc=L["Number of Rows. Only applies when Growth Precedence is Vertical"],
					min=1,
					max=2,
					step=1,
					get = function() return Buffalo.db.profile.rows["weapon"] end,
					set = function(v) Buffalo.SetRows(Buffalo, v, "weapon") end,
					order=7
				},

				cols={
					type='range',
					name=L["Columns"],
					desc=L["Number of Columns. Only applies when Growth Precedence is Horizontal"],
					min=1,
					max=2,
					step=1,
					get = function() return Buffalo.db.profile.cols["weapon"] end,
					set = function(v) Buffalo.SetCols(Buffalo, v, "weapon") end,
					order=8
				},
				hide = {
					type='toggle',
					name=L["Hide"],
					desc=L["Hides these buff frames"],
					get= function() return Buffalo.db.profile.hide["weapon"] end,
					set = function(v) Buffalo.ToggleHide(Buffalo, v, "weapon") end,
					order=90
				},
				flashing = {
					type='toggle',
					name=L["Flashing"],
					desc=L["Toggle flashing on fading buffs"],
					get= function() return Buffalo.db.profile.flashes["weapon"] end,
					set = function(v) Buffalo.db.profile.flashes["weapon"] = v end,
					order=95
				},
				timers = {
					type='group',
					name=L["Timers"],
					desc=L["Customize buff timers"],
					order=100,
					args = {
						verboseTimer = {
							type='toggle',
							name=L["Verbose Timers"],
							desc=L["Replaces the default time format for timers with HH:MM or MM:SS"],
							get= function() return Buffalo.db.profile.verboseTimers["weapon"] end,
							set = function(v) Buffalo.db.profile.verboseTimers["weapon"] = v end,
							order=100
						},
						whiteTimer = {
							type='toggle',
							name=L["White Timers"],
							desc=L["Use white timers instead of yellow ones"],
							get= function() return Buffalo.db.profile.whiteTimers["weapon"] end,
							set = function(v) Buffalo.db.profile.whiteTimers["weapon"] = v end,
							disabled = function() return not Buffalo.db.profile.verboseTimers["weapon"] end,
							order=110
						},
					},
				},
			}
		},
		reset = {
			type='execute',
			name="Reset",
			desc=L["Reset"],
			func = function() Buffalo.Reset(Buffalo) end
		}
	}
}
