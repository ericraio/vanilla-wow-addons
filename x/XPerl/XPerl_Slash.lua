-- MinMaxScale
local function MinMaxScale(arg)
	arg = tonumber(arg)
	if (arg < 0.5) then
		arg = 0.5
	elseif (arg > XPerlConfig.MaximumScale) then
		arg = XPerlConfig.MaximumScale
	end
	return arg
end

-- XPerl_SlashHandler
local function XPerl_SlashHandler(msg)
	local args = {}
	local BLU = "|c000000FF"
	local CYN = "|c0000A0A0"
	local RED = "|c00FF0000"
	local GRN = "|c0000FF00"
	local YELLOW = "|c00FFFF00"
	local CLR = "|r"

	for value in string.gfind(msg, "[^ ]+") do
		tinsert(args, string.lower(value))
	end
	if (args[1]=="") then
		XPerl_OptionsMenu_Frame:Show()
		return
	end

	local enable = 0
	if (args[2]) then
		if (args[2] == "on" or args[2] == "show" or args[2] == "true" or args[2] == "1") then
			enable = 1
		end
	end

	local SimpleOptions = {
		["playerportrait"] = "ShowPlayerPortrait",
		["portrait3d"] = "ShowPlayerPortrait3D",
		["counters"] = "TargetCounters",
		["combatflash"] = "CombatFlash",
		["fadeframes"] = "PerlFadeFrames",
		["highlight"] = "HighlightSelection",
		["counthealersonly"] = "TargetCountersSelf",
		["enemycounters"] = "TargetCountersEnemy",
		["playerlevel"] = "ShowPlayerLevel=enable;",
		["playerclass"] = "ShowPlayerClassIcon",
		["targetportrait"] = "ShowTargetPortrait",
		["targetmobtype"] = "ShowTargetMobType",
		["targetlevel"] = "ShowTargetLevel",
		["targetmana"] = "ShowTargetMana",
		["targetelite"] = "ShowTargetElite",
		["targetclass"] = "ShowTargetClassIcon",
		["hitindicator"] = "CombatHitIndicator",
		["partylevel"] = "ShowPartyLevel",
		["partyicon"] = "ShowPartyClassIcon",
		["partyvalues"] = "ShowPartyValues",
		["partypercent"] = "ShowPartyPercent",
		["partynames"] = "ShowPartyNames",
		["partytarget"] = "ShowPartyTarget",
		["partybuffs"] = "PartyBuffs",
		["partydebuffs"] = "PartyDebuffs",
		["classcolours"] = "ClassColouredNames",
		["classcolors"] = "ClassColouredNames",
		["petlevel"] = "ShowPetLevel",
		["pethappiness"] = "PetHappiness",
		["playerxp"] = "ShowPlayerXPBar",
		["playerrank"] = "ShowPlayerPVPRank",
		["targetrank"] = "ShowTargetPVPRank",
		["arcanebar"] = "ArcaneBar",
		["oldcastbar"] = "OldCastBar",
		["partyinraid"] = "ShowPartyRaid",
		["targettarget"] = "ShowTargetTarget",
		["targethistory"] = "TargetTargetHistory",
		["petxp"] = "ShowPetXP",
		["targettargetbuffs"] = "TargetTargetBuffs",
		["target30yard"] = "Show30YardSymbol",
		["casttime"] = "CastTime",
		["partynumber"] = "ShowPartyNumber",
		["raidpercent"] = "ShowRaidPercents",
		["group1"] = "ShowGroup1",
		["group2"] = "ShowGroup2",
		["group3"] = "ShowGroup3",
		["group4"] = "ShowGroup4",
		["group5"] = "ShowGroup5",
		["group6"] = "ShowGroup6",
		["group7"] = "ShowGroup7",
		["group8"] = "ShowGroup8",
		["group9"] = "ShowGroup9",
		["minimapbutton"] = "MinimapButtonShown"
	}

	local foundSimple = SimpleOptions[args[1]]

	if (foundSimple) then
		XPerlConfig[foundSimple] = enable
	else
		if (args[1] == nil or args[1] == "menu" or args[1] == "options") then
			XPerl_UnlockFrames()

		elseif (args[1]=="lock") then
			XPerlLocked = 1
			if (XPerl_RaidTitles) then
				XPerl_RaidTitles()
			end

		elseif (args[1]=="unlock") then
			XPerlLocked = 0
			if (XPerl_RaidTitles) then
				XPerl_RaidShowAllTitles()
			end

		elseif (args[1]=="usecptext") then
			XPerlConfig.UseCPMeter=0
		elseif (args[1]=="usecpmeter") then
			XPerlConfig.UseCPMeter=1
		elseif (args[1]=="nobartextures") then
			XPerlConfig.BarTextures=0
		elseif (args[1]=="bartextures") then
			XPerlConfig.BarTextures=1

		elseif (args[1]=="settexttrans") then
			XPerlConfig.TextTransparency = tonumber(args[2])
		elseif (args[1]=="settrans") then
			XPerlConfig.Transparency = tonumber(args[2])

		elseif (args[1]=="setplayerscale") then
			XPerlConfig.Scale_PlayerFrame = MinMaxScale(args[2])
		elseif (args[1]=="setpetscale") then
			XPerlConfig.Scale_PetFrame = MinMaxScale(args[2])
		elseif (args[1]=="setpartyscale") then
			XPerlConfig.Scale_PartyFrame = MinMaxScale(args[2])
		elseif (args[1]=="setpartypetscale") then
			XPerlConfig.Scale_PartyPets = MinMaxScale(args[2])
		elseif (args[1]=="settargetscale") then
			XPerlConfig.Scale_TargetFrame = MinMaxScale(args[2])
		elseif (args[1]=="settargettargetscale") then
			XPerlConfig.Scale_TargetTargetFrame = MinMaxScale(args[2])

		elseif (args[1]=="partydebuffs" and args[2]=="below") then
			XPerlConfig.PartyDebuffsBelow=1
		elseif (args[1]=="partydebuffs" and args[2]=="right") then
			XPerlConfig.PartyDebuffsBelow=0

		elseif (args[1]=="raidbyclass") then
			XPerlConfig.SortRaidByClass=1
		elseif (args[1]=="raidbygroup") then
			XPerlConfig.SortRaidByClass=0

		elseif (args[1]=="raid") then
			XPerlConfig.ShowRaid = enable
			for i = 1,10 do
				XPerlConfig["ShowRaid"..i] = enable
			end

		elseif (args[1]=="setraidscale") then
			XPerlConfig.Scale_Raid = MinMaxScale(args[2])

		elseif (args[1]=="backcolor" or args[1]=="bordercolor" or args[1]=="backcolour" or args[1]=="bordercolour") then
			local r = tonumber(args[2])
			local g = tonumber(args[3])
			local b = tonumber(args[4])

			if (r >= 0 and r <= 1) then
				if (g >= 0 and g <= 1) then
					if (b >= 0 and b <= 1) then
						if (args[1]=="backcolor" or args[1]=="backcolour") then
							XPerlConfig.BackColour.r = r
							XPerlConfig.BackColour.g = g
							XPerlConfig.BackColour.b = b
						else
							XPerlConfig.BorderColour.r = r
							XPerlConfig.BorderColour.g = g
							XPerlConfig.BorderColour.b = b
						end
					end
				end
			end

		elseif (args[1]=="simpleframes" or args[1]=="complexframes") then
			if (args[1]=="simpleframes") then
				enable = 0
			else
				enable = 1
			end

			XPerlConfig.ShowPlayerPortrait = enable
			XPerlConfig.ShowPlayerLevel = enable
			XPerlConfig.ShowPlayerClassIcon = enable
			XPerlConfig.ShowTargetClassIcon = enable
			XPerlConfig.ShowTargetPortrait = enable
			XPerlConfig.ShowTargetMobType = enable
			XPerlConfig.ShowTargetLevel = enable
			XPerlConfig.ShowTargetElite = enable
			XPerlConfig.ShowPartyLevel = enable
			XPerlConfig.ShowPartyClassIcon = enable
			XPerlConfig.ShowPartyPercent = enable
			XPerlConfig.ShowPetLevel = enable
			XPerlConfig.PetHappiness = enable

		elseif (args[1] == "basichelp" or args[1] == "help") then
			DEFAULT_CHAT_FRAME:AddMessage("/xperl "..CYN.."lock"..CLR.." /xperl "..CYN.."unlock"..CLR.." /xperl "..CYN.."menu")
			DEFAULT_CHAT_FRAME:AddMessage("/xperl "..CYN.."simpleframes"..CLR.." /xperl "..CYN.."complexframes")
			DEFAULT_CHAT_FRAME:AddMessage("/xperl "..CYN.."showhidehelp"..CLR.." /xperl "..CYN.."settexttrans "..YELLOW.."#")
			DEFAULT_CHAT_FRAME:AddMessage("/xperl "..CYN.."settrans "..YELLOW.."#"..CLR.." /xperl "..CYN.."settargetscale "..YELLOW.."#")
			DEFAULT_CHAT_FRAME:AddMessage("/xperl "..CYN.."setpartyscale "..YELLOW.."#"..CLR.." /xperl "..CYN.."setplayerscale "..YELLOW.."#")
			DEFAULT_CHAT_FRAME:AddMessage("/xperl "..CYN.."setpetscale "..YELLOW.."#"..CLR.." /xperl "..CYN.."settargettargetscale "..YELLOW.."#")
			DEFAULT_CHAT_FRAME:AddMessage("/xperl "..CYN.."usecptext"..CLR.." /xperl "..CYN.."bartextures"..CLR.." /xperl "..CYN.."usecpmeter")
			DEFAULT_CHAT_FRAME:AddMessage("/xperl "..CYN.."nobartextures"..CLR.." /xperl "..CYN.."castparty "..YELLOW.."on/off")
			DEFAULT_CHAT_FRAME:AddMessage("/xperl "..CYN.."targettarget "..YELLOW.."on"..CLR.." /xperl "..CYN.."targethistory "..YELLOW.."on/off")
			DEFAULT_CHAT_FRAME:AddMessage("/xperl "..CYN.."portrait3d "..YELLOW.."hide/show"..CLR.." /xperl "..CYN.."counters "..YELLOW.."on/off")
			DEFAULT_CHAT_FRAME:AddMessage("/xperl "..CYN.."enemycounters "..YELLOW.."on/off"..CLR.." /xperl "..CYN.."counthealersonly "..YELLOW.."on/off")
			DEFAULT_CHAT_FRAME:AddMessage("/xperl "..CYN.."combatflash "..YELLOW.."on/off")
			DEFAULT_CHAT_FRAME:AddMessage("/xperl "..CYN.."partynumber "..YELLOW.."on/off"..CLR.." /xperl "..CYN.."targettargetbuffs "..YELLOW.."on/off")
			DEFAULT_CHAT_FRAME:AddMessage("/xperl "..CYN.."backcolor "..RED.."r "..GRN.."g "..BLU.."b"..CLR.." /xperl "..CYN.."bordercolor "..RED.."r "..GRN.."g "..BLU.."b")
			DEFAULT_CHAT_FRAME:AddMessage("/xperl "..CYN.."hitindicator "..YELLOW.."on/off"..CLR.." /xperl "..CYN.."partybuffs "..YELLOW.."on/off")
			DEFAULT_CHAT_FRAME:AddMessage("/xperl "..CYN.."partydebuffs "..YELLOW.."on/off"..CLR.." /xperl "..CYN.."minimapbutton "..YELLOW.."on/off")
			DEFAULT_CHAT_FRAME:AddMessage("/xperl "..CYN.."highlight "..YELLOW.."on/off"..CLR.." /xperl "..CYN.."fadeframes "..YELLOW.."on/off")

		elseif (args[1]=="showhidehelp") then
			DEFAULT_CHAT_FRAME:AddMessage("Use /xperl target show/hide")
			DEFAULT_CHAT_FRAME:AddMessage("For example, to hide the player level, use")
			DEFAULT_CHAT_FRAME:AddMessage("/xperl playerlevel hide --make sure your only space is directly after 'perl'.")
			DEFAULT_CHAT_FRAME:AddMessage("Valid Targets:")
			DEFAULT_CHAT_FRAME:AddMessage("playerportrait  "..CYN.."targetportrait"..CLR.."    partyicon")
			DEFAULT_CHAT_FRAME:AddMessage(CYN.."playerlevel"..CLR.."     targetlevel        "..CYN.."partylevel"..CLR.."         petlevel")
			DEFAULT_CHAT_FRAME:AddMessage("playerclass    "..CYN.."targetmobtype"..CLR.."  partypercent    "..CYN.."partyvalues")
			DEFAULT_CHAT_FRAME:AddMessage(CYN.."playerxp"..CLR.."         targetmana       "..CYN.."partyinraid"..CLR.."       castparty")
			DEFAULT_CHAT_FRAME:AddMessage("playerrank      "..CYN.."targetrank"..CLR.."        partynames      "..CYN.."blizzardplayer")
			DEFAULT_CHAT_FRAME:AddMessage(CYN.."targetclass"..CLR.."     targetelite         "..CYN.."arcanebar"..CLR.."        oldcastbar")
			DEFAULT_CHAT_FRAME:AddMessage("partytarget      "..CYN.."petxp"..CLR.."                pethappiness")
			DEFAULT_CHAT_FRAME:AddMessage("Note that /xperl simpleframes or complexframes may override these settings.")
		else
			DEFAULT_CHAT_FRAME:AddMessage("Unknown command, type /xperl "..CYN.."help")
		end
	end

	XPerl_OptionActions()
end

-- XPerl_SlashOnLoad
function XPerl_SlashOnLoad()
        SlashCmdList["XPERL"] = XPerl_SlashHandler
        SLASH_XPERL1 = "/xperl"
	XPerl_SlashOnLoad = nil
end
