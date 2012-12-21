--contains sampe configs all can use

-------------------------
--Get the Classic Config
function SCT:GetClassicConfig()
	local default = {
		["PLAYSOUND"] = false,
		[SCT.FRAMES_DATA_TABLE] = {
			[SCT.FRAME1] = {
				["FONT"] = 1,
				["FONTSHADOW"] = 1,
				["ALPHA"] = 100,
				["ANITYPE"] = 1,
				["ANISIDETYPE"] = 1,
				["XOFFSET"] = 0,
				["YOFFSET"] = 0,
				["DIRECTION"] = false,
				["TEXTSIZE"] = 24,
			},
			[SCT.MSG] = {
				["MSGFADE"] = 1.5,
				["MSGFONT"] = 1,
				["MSGFONTSHADOW"] = 1,
				["MSGSIZE"] = 24,
				["MSGYOFFSET"] = 210,
				["MSGXOFFSET"] = 0,
			}
		},
		[SCT.CRITS_TABLE] = {
			["SHOWEXECUTE"] = 1,
			["SHOWLOWHP"] = 1,
			["SHOWLOWMANA"] = 1,
		},
		[SCT.FRAMES_TABLE] = {
			["SHOWHEAL"] = SCT.FRAME1,
			["SHOWPOWER"] = SCT.FRAME1,
			["SHOWCOMBAT"] = SCT.FRAME1,
			["SHOWHONOR"] = SCT.FRAME1,
			["SHOWBUFF"] = SCT.FRAME1,
			["SHOWREP"] = SCT.FRAME1,
			["SHOWSELFHEAL"] = SCT.FRAME1,
			["SHOWSKILL"] = SCT.FRAME1
		}
	};
	return default;
end

-------------------------
--Get the Performance Config
function SCT:GetPerformanceConfig()
	local default = {
		["FPSMODE"] = 1,
		["CUSTOMEVENTS"] = false,
		["LIGHTMODE"] = 1,
	};
	return default;
end

-------------------------
--Get the Split Config
function SCT:GetSplitConfig()
	local default = {
		[SCT.FRAMES_DATA_TABLE] = {
			[SCT.FRAME1] = {
				["FONT"] = 1,
				["FONTSHADOW"] = 2,
				["ALPHA"] = 100,
				["ANITYPE"] = 1,
				["ANISIDETYPE"] = 1,
				["XOFFSET"] = 200,
				["YOFFSET"] = -100,
				["DIRECTION"] = false,
				["TEXTSIZE"] = 24,
			},
			[SCT.FRAME2] = {
				["FONT"] = 1,
				["FONTSHADOW"] = 2,
				["ALPHA"] = 100,
				["ANITYPE"] = 1,
				["ANISIDETYPE"] = 1,
				["XOFFSET"] = -200,
				["YOFFSET"] = -100,
				["DIRECTION"] = true,
				["TEXTSIZE"] = 24,
			},
		},
		[SCT.CRITS_TABLE] = {
			["SHOWEXECUTE"] = 1,
			["SHOWLOWHP"] = 1,
			["SHOWLOWMANA"] = 1,
		},
		[SCT.FRAMES_TABLE] = {
			["SHOWHEAL"] = SCT.FRAME2,
			["SHOWLOWMANA"] = SCT.FRAME2,
			["SHOWPOWER"] = SCT.FRAME2,
			["SHOWCOMBAT"] = SCT.FRAME2,
			["SHOWCOMBOPOINTS"] = SCT.FRAME2,
			["SHOWBUFF"] = SCT.FRAME2,
			["SHOWFADE"] = SCT.FRAME2,
			["SHOWSKILL"] = SCT.MSG
		}
	};
	return default;
end

-------------------------
--Get the Split SCTD Config
function SCT:GetSplitSCTDConfig()
	if (not SCT.FRAME3) then return SCT:GetSplitConfig() end;
	local default = {
		[SCT.FRAMES_DATA_TABLE] = {
			[SCT.FRAME1] = {
				["FONT"] = 1,
				["FONTSHADOW"] = 2,
				["ALPHA"] = 100,
				["ANITYPE"] = 1,
				["ANISIDETYPE"] = 1,
				["XOFFSET"] = 200,
				["YOFFSET"] = -100,
				["DIRECTION"] = false,
				["TEXTSIZE"] = 24,
			},
			[SCT.FRAME2] = {
				["FONT"] = 1,
				["FONTSHADOW"] = 2,
				["ALPHA"] = 100,
				["ANITYPE"] = 1,
				["ANISIDETYPE"] = 1,
				["XOFFSET"] = 0,
				["YOFFSET"] = 100,
				["DIRECTION"] = false,
				["TEXTSIZE"] = 24,
			},
			[SCT.FRAME3] = {
				["FONT"] = 1,
				["FONTSHADOW"] = 2,
				["ALPHA"] = 100,
				["ANITYPE"] = 1,
				["ANISIDETYPE"] = 1,
				["XOFFSET"] = -200,
				["YOFFSET"] = -100,
				["DIRECTION"] = false,
				["TEXTSIZE"] = 24,
			},
		},
		[SCT.FRAMES_TABLE] = {
			["SHOWHEAL"] = SCT.FRAME1,
			["SHOWPOWER"] = SCT.FRAME2,
			["SHOWCOMBAT"] = SCT.FRAME2,
			["SHOWCOMBOPOINTS"] = SCT.FRAME2,
			["SHOWHONOR"] = SCT.FRAME2,
			["SHOWBUFF"] = SCT.FRAME2,
			["SHOWFADE"] = SCT.FRAME2,
			["SHOWEXECUTE"] = SCT.FRAME1,
			["SHOWREP"] = SCT.FRAME2,
			["SHOWSELFHEAL"] = SCT.FRAME1,
			["SHOWSKILL"] = SCT.FRAME2
		}
	};
	return default;
end

-------------------------
--Get the Grayhoof Config
function SCT:GetGrayhoofConfig()
	local default = {
		["SHOWPOWER"] = false,
		["SHOWCOMBAT"] = 1,
		["SPELLTYPE"] = 1,
		["SPELLCOLOR"] = 1,
		["DMGFONT"] = 1,
		[SCT.FRAMES_DATA_TABLE] = {
			[SCT.FRAME1] = {
				["FONT"] = 2,
				["ANITYPE"] = 4,
				["ANISIDETYPE"] = 2,
			},
			[SCT.FRAME2] = {
				["FONT"] = 2,
			},
			[SCT.MSG] = {
				["MSGFONT"] = 2,
			},
		}
	};
	return default;
end