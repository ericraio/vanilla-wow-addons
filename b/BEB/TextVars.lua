BEB.VARIABLE_FUNCTIONS = {
	["$plv"] = {
		func =	function() return UnitLevel("player") end,
		events =	{"PLAYER_LEVEL_UP", "PLAYER_XP_UPDATE"}  -- fix if/when fixed
	},

	["$cxp"] = {
		func =	function()
					if (UnitXP("player")) then
						return UnitXP("player")
					else
						return 0
					end
				end,
		events =	{"PLAYER_XP_UPDATE"}
	},

	["$mxp"] = {
		func =	function() return UnitXPMax("player") end,
		events =	{"PLAYER_LEVEL_UP", "PLAYER_XP_UPDATE"}  -- fix if/when fixed
	},

	["$rxp"] = {
		func =	function()
					if (GetXPExhaustion()) then
						return GetXPExhaustion()
					else
						return 0
					end
				end,
		events =	{"UPDATE_EXHAUSTION"}
	},

	["$Rxp"] = {
		func =	function()
					if (GetXPExhaustion()) then
						return (GetXPExhaustion()/2)
					else
						return 0
					end
				end,
		events =	{"UPDATE_EXHAUSTION"}
	},

	["$Cxp"] = {
		func =	function()
					local xpdone
					if (UnitXP("player")) then
						xpdone = UnitXP("player")
					else
						xpdone = 0
					end
					for i=1,(UnitLevel("player")-1) do
						xpdone = xpdone + BEB.XpPerLvl[i]
					end
					return xpdone
				end,
		events =	{"PLAYER_XP_UPDATE"}
	},

	["$Mxp"] = {
		func =	function()
					local xptodo
					if (UnitXP("player")) then
						xptodo = UnitXPMax("player") - UnitXP("player")
					else
						xptodo = UnitXPMax("player")
					end
					for i=(UnitLevel("player")+1),60 do
						xptodo = xptodo + BEB.XpPerLvl[i]
					end
					return xptodo
				end,
		events =	{"PLAYER_XP_UPDATE"}
	},

	["$txp"] = {
		func =	function()
					return UnitXPMax("player") - (UnitXP("player") or 0)
				end,
		events =	{"PLAYER_XP_UPDATE"}
	},

	["$Txp"] = { -- Xp left to do to reach lvl 60
		func =	function()
					local xptodo = UnitXPMax("player") - (UnitXP("player") or 0)
					for i=(UnitLevel("player")+1),59 do
						xptodo = xptodo + BEB.XpPerLvl[i]
					end
					return xptodo
				end,
		events =	{"PLAYER_XP_UPDATE"}
	},

	["$pdl"] = {
		func =	function()
					if (UnitXP("player")) then
						return BEB.round((UnitXP("player")/UnitXPMax("player"))*100)
					else
						return 0
					end
				end,
		events =	{"PLAYER_XP_UPDATE"}
	},

	["$Pdl"] = {
		func =	function()
					local xpdone = UnitXP("player") or 0
					for i=1,(UnitLevel("player")-1) do
						xpdone = xpdone + BEB.XpPerLvl[i]
					end
					return BEB.round((xpdone/4302200)*100)
				end,
		events =	{"PLAYER_XP_UPDATE"}
	},

	["$ptl"] = {
		func =	function()
					if (UnitXP("player")) then
						return BEB.round(((UnitXPMax("player") - UnitXP("player"))/UnitXPMax("player"))*100)
					else
						return 0
					end
				end,
		events =	{"PLAYER_XP_UPDATE"}
	},

	["$res"] = { -- Resting or not
		func =	function()
					if (IsResting() == 1) then
						return BEB.TEXTVARTEXT.resting
					else
						return ""
					end
				end,
		events =	{"PLAYER_UPDATE_RESTING"}
	},

	["$rst"] = { -- How rested
		func =	function()
					if (GetRestState() == 1) then
						if (GetXPExhaustion() == (UnitXPMax("player")*1.5)) then
							return BEB.TEXTVARTEXT.fullyrested
						else
							return BEB.TEXTVARTEXT.rested
						end
					else
						return BEB.TEXTVARTEXT.unrested
					end
				end,
		events =	{"UPDATE_EXHAUSTION", "PLAYER_LEVEL_UP"}
	},

	["$ptx"] = { -- Pet Current XP
		func =	function()
					if (GetPetExperience()) then
						local x = GetPetExperience();
						return x
					else
						return ""
					end
				end,
		events = {"UNIT_PET_EXPERIENCE"}
	},

	["$pty"] = { -- Pet XP Needed to Level
		func =	function(text, unit)
					if (GetPetExperience()) then
						local _,x = GetPetExperience();
						return x
					else
						return ""
					end
				end,
		events = {"UNIT_PET_EXPERIENCE"}
	},

	["$ppc"] = { -- Pet XP Percent Complete
		func =	function()
					if (GetPetExperience()) then
						local min,max = GetPetExperience();
						if (max and min and max > 0) then
							return BEB.round((min / max) * 100);
						else
							return ""
						end
					else
						return ""
					end
				end,
		events = {"UNIT_PET_EXPERIENCE"}
	},

	["$ppn"] = { -- Pet XP Percent Needed
		func =	function()
					if (GetPetExperience()) then
						local min,max = GetPetExperience();
						if (max and min and max > 0) then
							return BEB.round(((max-min)/max)*100);
						else
							return ""
						end
					else
						return ""
					end
				end,
		events = {"UNIT_PET_EXPERIENCE"}
	},

	["$pxg"] = { -- Pet XP To Go
		func =	function(text, unit)
					if (GetPetExperience()) then
						local min,max = GetPetExperience();
						if (max and min and max > 0) then
							return (max - min);
						else
							return ""
						end
					else
						return ""
					end
				end,
		events = {"UNIT_PET_EXPERIENCE"}
	},

	["$tts"] = { -- time this session
		func =	function()
					return BEB.SecondsToTime(BEB.TimeThisSession)
				end,
		events =	{"ON_UPDATE"}
	},

	["$rss"] = { -- rate this session per second
		func =	function()
					return BEB.sigfigs(BEB.RateThisSession,2)
				end,
		events =	{"ON_UPDATE"}
	},

	["$rsm"] = { -- rate this session per minute
		func =	function()
					return BEB.sigfigs(BEB.RateThisSession*60,2)
				end,
		events =	{"ON_UPDATE"}
	},

	["$rsh"] = { -- rate this session per hour
		func =	function()
					return BEB.sigfigs(BEB.RateThisSession*3600,2)
				end,
		events =	{"ON_UPDATE"}
	},

	["$tls"] = { -- time to level this session
		func =	function()
					if (BEB.RateThisSession > 0) then
						if ((UnitXPMax("player")-UnitXP("player"))/BEB.RateThisSession > 360000) then
							return "~~"
						end
						return BEB.SecondsToTime((UnitXPMax("player")-UnitXP("player"))/BEB.RateThisSession)
					else
						return "~~"
					end
				end,
		events =	{"ON_UPDATE"}
	},


	["$xts"] = { -- xp gained this session
		func =	function()
					return BEB.XpThisSession
				end,
		events =	{"PLAYER_XP_UPDATE", "PLAYER_LEVEL_UP"}
	},

	["$prt"] = { -- % of fully rested
		func =	function()
					if (GetXPExhaustion()) then
						return BEB.round((GetXPExhaustion()*100)/(UnitXPMax("player")*1.5))
					else
						return 0
					end
				end,
		events =	{"UPDATE_EXHAUSTION"}
	},

	["$pre"] = { -- percent of what's left that's rested
		func =	function()
					if (GetXPExhaustion() < UnitXPMax("player")-UnitXP("player")) then
						return BEB.round((GetXPExhaustion()*100)/(UnitXPMax("player")-UnitXP("player")))
					elseif (not GetXPExhaustion()) then
						return 0
					else
						return 100
					end
				end,
		events =	{"UPDATE_EXHAUSTION"}
	},

	["$nkx"] = { -- number of kills giving xp
		func =	function()
					return BEB.MobsTS
				end,
		events =	{"CHAT_MSG_COMBAT_XP_GAIN"}
	},

	["$xpk"] = { -- Average xp per kill
		func =	function()
					if (BEB.MobsTS ~= 0) then
						return BEB.round(BEB.XpMobsTS/BEB.MobsTS)
					else
						return "~~"
					end
				end,
		events =	{"CHAT_MSG_COMBAT_XP_GAIN"}
	},

	["$kls"] = { -- Kills to level up
		func =	function()
					if (BEB.MobsTS ~= 0) then
						return BEB.round(UnitXPMax("player")/(BEB.XpMobsTS/BEB.MobsTS))
					else
						return "~~"
					end
				end,
		events =	{"CHAT_MSG_COMBAT_XP_GAIN"}
	},
}