local Default				= {
	CastingBar			= {
		width 			= 255,
		height			= 25,
		edgeFile		= "Default",
		texture			= "Default",
		timeSize		= 12,
		spellSize		= 10,
		delaySize		= 14,
	},
	MirrorBar			= {
		width 			= 255,
		height			= 25,
		edgeFile		= "Default",
		texture			= "Default",
		timeSize		= 12,
		spellSize		= 10,
		delaySize		= 14,
	},
	Colors				= {
		Complete		= {r=0, g=1, b=0},
		Casting			= {r=1, g=.7, b=0},
		Channel		= {r=.3, g=.3, b=1},
		Failed			= {r=1, g=0, b=0},
	},
	Mirror				= {
		EXHAUSTION 	= {r=1, g=.9, b=0},
		BREATH			= {r=0, g=.5, b=1},
		DEATH			= {r=0, g=.7, b=1},
		FEIGNDEATH	= {r=1, g=.7, b=1}
	},
	Pos = {}
}
local Textures		= {
	["Default"]	= "Interface\\AddOns\\oCB\\textures\\oCB",
	["Perl"]		= "Interface\\AddOns\\oCB\\textures\\perl",
	["Smooth"]	= "Interface\\AddOns\\oCB\\textures\\smooth",
	["Glaze"]	= "Interface\\AddOns\\oCB\\textures\\glaze",
	["Blizzard"]	= "Interface\\TargetingFrame\\UI-StatusBar",
	["Striped"] 	= "Interface\\AddOns\\oCB\\textures\\striped",
    ["BantoBar"] 	= "Interface\\AddOns\\oCB\\textures\\BantoBar",
}
local Borders 		= {
	["Default"] 		= "Interface\\Tooltips\\UI-Tooltip-Border",
	["None"] 		= ""
}

oCB = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDebug-2.0", "AceHook-2.0", "AceDB-2.0", "AceConsole-2.0")

function oCB:OnInitialize()
	self.Textures = Textures
	self.Borders = Borders

	local consoleOptions = {
		type = 'group',
		args = {
			lock = {
				name = "Lock", type = 'toggle', order = 1,
				desc = "Lock/Unlock the casting bar.",
				get = function() return self.db.profile.lock end,
				set = function() self.db.profile.lock = not self.db.profile.lock end
			},
			castingbar = {
				name = "Casting Bar", type = 'group', order = 2,
				desc = "Casting Bar", 
				args = {
					width = {
						name = "Width", type = 'range', min = 10, max = 500, step = 1,
						desc = "Set the width of the casting bar.",
						get = function() return self.db.profile.CastingBar.width end,
						set = function(v)
							self.db.profile.CastingBar.width = v
							self:Layout("CastingBar")
						end
					},
					height = {
						name = "Height", type = 'range', min = 5, max = 50, step = 1,
						desc = "Set the height of the casting bar.",
						get = function() return self.db.profile.CastingBar.height end,
						set = function(v)
							self.db.profile.CastingBar.height = v
							self:Layout("CastingBar")
						end
					},
					border = {
						name = "Border", type = 'text',
						desc = "Toggle the border.",
						get = function() return self.db.profile.CastingBar.edgeFile end,
						set = function(v)
							self.db.profile.CastingBar.edgeFile = v
							self:Layout("CastingBar")
						end,
						validate = {"Default","None"}
					},
					texture = {
						name = "Texture", type = 'text',
						desc = "Toggle the texture.",
						get = function() return self.db.profile.CastingBar.texture end,
						set = function(v)
							self.db.profile.CastingBar.texture = v
							self:Layout("CastingBar")
						end,
						validate = {"Default","Perl","Smooth","Glaze","Blizzard","Striped", "BantoBar"}
					},
					font = {
						name = "Font", type = 'group',
						desc = "Set the font size of different elements.",
						args = {
							spell = {
								name = "Spell", type = 'range', min = 6, max = 32, step = 1,
								desc = "Set the font size on the spellname, when casting.",
								get = function() return self.db.profile.CastingBar.spellSize end,
								set = function(v)
									self.db.profile.CastingBar.spellSize = v
									self:Layout("CastingBar")
								end
							},
							time = {
								name = "Time", type = 'range', min = 6, max = 32, step = 1,
								desc = "Set the font size on the spell time.",
								get = function() return self.db.profile.CastingBar.timeSize end,
								set = function(v)
									self.db.profile.CastingBar.timeSize = v
									self:Layout("CastingBar")
								end
							},
							delay = {
								name = "Delay", type = 'range', min = 6, max = 32, step = 1,
								desc = "Set the font size on the delay time.",
								get = function() return self.db.profile.CastingBar.delaySize end,
								set = function(v)
									self.db.profile.CastingBar.delaySize = v
									self:Layout("CastingBar")
								end
							}
						}
					}
				}
			},
			mirrorbar = {
				name = "Mirror Bar", type = 'group', order = 3,
				desc = "Mirror Bar",
				args = {
					width = {
						name = "Width", type = 'range', min = 10, max = 500, step = 1,
						desc = "Set the width of the mirror bar.",
						get = function() return self.db.profile.MirrorBar.width end,
						set = function(v)
							self.db.profile.MirrorBar.width = v
							self:Layout("BREATH", "MirrorBar")
							self:Layout("EXHAUSTION", "MirrorBar")
							self:Layout("FEIGNDEATH", "MirrorBar")
						end
					},
					height = {
						name = "Height", type = 'range', min = 5, max = 50, step = 1,
						desc = "Set the height of the mirror bar.",
						get = function() return self.db.profile.MirrorBar.height end,
						set = function(v)
							self.db.profile.MirrorBar.height = v
							self:Layout("BREATH", "MirrorBar")
							self:Layout("EXHAUSTION", "MirrorBar")
							self:Layout("FEIGNDEATH", "MirrorBar")
						end
					},
					border = {
						name = "Border", type = 'text',
						desc = "Toggle the border.",
						get = function() return self.db.profile.MirrorBar.edgeFile end,
						set = function(v)
							self.db.profile.MirrorBar.edgeFile = v
							self:Layout("BREATH", "MirrorBar")
							self:Layout("EXHAUSTION", "MirrorBar")
							self:Layout("FEIGNDEATH", "MirrorBar")
						end,
						validate = {"Default","None"}
					},
					texture = {
						name = "Texture", type = 'text',
						desc = "Toggle the texture.",
						get = function() return self.db.profile.MirrorBar.texture end,
						set = function(v)
							self.db.profile.MirrorBar.texture = v
							self:Layout("BREATH", "MirrorBar")
							self:Layout("EXHAUSTION", "MirrorBar")
							self:Layout("FEIGNDEATH", "MirrorBar")
						end,
						validate = {"Default","Perl","Smooth","Glaze","Blizzard","Striped", "BantoBar"}
					},
					font = {
						name = "Font", type = 'group',
						desc = "Set the font size of different elements.",
						args = {
							spell = {
								name = "Spell", type = 'range', min = 6, max = 32, step = 1,
								desc = "Set the font size on the spellname, when shown.",
								get = function() return self.db.profile.MirrorBar.spellSize end,
								set = function(v)
									self.db.profile.MirrorBar.spellSize = v
									self:Layout("MirrorBar")
								end
							},
							time = {
								name = "Time", type = 'range', min = 6, max = 32, step = 1,
								desc = "Set the font size on the spell time.",
								get = function() return self.db.profile.MirrorBar.timeSize end,
								set = function(v)
									self.db.profile.MirrorBar.timeSize = v
									self:Layout("BREATH", "MirrorBar")
									self:Layout("EXHAUSTION", "MirrorBar")
									self:Layout("FEIGNDEATH", "MirrorBar")
								end
							},
							delay = {
								name = "Delay", type = 'range', min = 6, max = 32, step = 1,
								desc = "Set the font size on the delay time.",
								get = function() return self.db.profile.MirrorBar.delaySize end,
								set = function(v)
									self.db.profile.MirrorBar.delaySize = v
									self:Layout("BREATH", "MirrorBar")
									self:Layout("EXHAUSTION", "MirrorBar")
									self:Layout("FEIGNDEATH", "MirrorBar")
								end
							}
						}
					}
				}
			},
			colors = {
				name = "Colors", type = 'group', order = 4,
				desc = "Set the bar colors.",
				args = {
					spell = {
						name = "Spell", type = 'color',
						desc = "Sets the color of the casting bars on spells.",
						get = function()
							local v = self.db.profile.Colors.Casting
							return v.r,v.g,v.b
						end,
						set = function(r,g,b) self.db.profile.Colors.Casting = {r=r,g=g,b=b} end
					},
					success = {
						name = "Success", type = 'color',
						desc = "Sets the color of the casting bars on succsessful casts.",
						get = function()
							local v = self.db.profile.Colors.Complete
							return v.r,v.g,v.b
						end,
						set = function(r,g,b) self.db.profile.Colors.Complete = {r=r,g=g,b=b} end
					},
					channel = {
						name = "Channel", type = 'color',
						desc = "Sets the color of the casting bars while channeling.",
						get = function()
							local v = self.db.profile.Colors.Channel
							return v.r,v.g,v.b
						end,
						set = function(r,g,b) self.db.profile.Colors.Channel = {r=r,g=g,b=b} end
					},
					failed = {
						name = "Failed", type = 'color',
						desc = "Sets the color of the casting bars on failed casts.",
						get = function()
							local v = self.db.profile.Colors.Failed
							return v.r,v.g,v.b
						end,
						set = function(r,g,b) self.db.profile.Colors.Failed = {r=r,g=g,b=b} end
					}
				}
			}
		}
	}
	
	self:RegisterDB("oCBDB")
	self:RegisterDefaults('profile', Default)
	
	self:RegisterChatCommand({ "/oCB"}, consoleOptions)
    
	self:SetDebugging(false)
end

function oCB:OnEnable()
	if not self.frames then self.frames = {} end
	
	self:Events()
	self:HideBlizzCB()
	
	self:CreateFramework("CastingBar", "oCBFrame")
	self:CreateFramework("BREATH", "oCBMirror1", "MirrorBar")
	self:CreateFramework("EXHAUSTION","oCBMirror2", "MirrorBar")
	self:CreateFramework("FEIGNDEATH","oCBMirror3", "MirrorBar")
end

function oCB:Events()
	self:RegisterEvent("SPELLCAST_START", "SpellStart")
	self:RegisterEvent("SPELLCAST_CHANNEL_START", "SpellChannelStart")
	self:RegisterEvent("SPELLCAST_CHANNEL_STOP", "SpellChannelStop")
	self:RegisterEvent("SPELLCAST_CHANNEL_UPDATE", "SpellChannelUpdate")
	
	self:RegisterEvent("MIRROR_TIMER_START")
	self:RegisterEvent("MIRROR_TIMER_PAUSE")
	self:RegisterEvent("MIRROR_TIMER_STOP")
	
	UIParent:UnregisterEvent("MIRROR_TIMER_START")
end

function oCB:updatePositions(n)
	if(self.db.profile.Pos[n]) then
		local z = self:Split(self.db.profile.Pos[n], " ")
		local s = self.frames[n]:GetEffectiveScale()
		
		self.frames[n]:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", z[1]/s, z[2]/s)
	elseif(self.frames[n]) then
		self.frames[n]:ClearAllPoints()
		self.frames[n]:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	end
end

function oCB:savePosition()
	local f = self.frames[this.name]
	local x,y = f:GetLeft(), f:GetTop()
	local s = f:GetEffectiveScale()
	
	x,y = x*s,y*s
	
	self.db.profile.Pos[this.name] = x.." "..y
end

function oCB:Split(msg, char)
	local arr = { };
	while (string.find(msg, char) ) do
		local iStart, iEnd = string.find(msg, char);
		tinsert(arr, strsub(msg, 1, iStart-1));
		msg = strsub(msg, iEnd+1, strlen(msg));
	end
	if ( strlen(msg) > 0 ) then
		tinsert(arr, msg);
	end
	return arr;
end
