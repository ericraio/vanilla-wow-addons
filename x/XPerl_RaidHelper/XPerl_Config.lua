function XPerl_Message(msg)
	DEFAULT_CHAT_FRAME:AddMessage(XPERL_MSG_PREFIX.."- "..msg)
end

function XPerl_SetupFrames()

	local function ValidAlpha(alpha)
		alpha = tonumber(alpha)
		if (alpha < 0 or alpha > 1) then
			alpha = 1
		end
		return alpha
	end

	local function ValidScale(scale)
		scale = tonumber(scale)
		if (scale < 0.5) then
			scale = 0.5
		elseif (scale > (XPerlConfig.MaximumScale or 1.5)) then
			scale = (XPerlConfig.MaximumScale or 1.5)
		end
		return scale
	end

	XPerlConfigHelper.AssistsFrame_Transparency = ValidAlpha(XPerlConfigHelper.AssistsFrame_Transparency)
        XPerl_Assists_Frame:SetAlpha(XPerlConfigHelper.AssistsFrame_Transparency)

	XPerlConfigHelper.Targets_Transparency = ValidAlpha(XPerlConfigHelper.Targets_Transparency)
        XPerl_Frame:SetAlpha(XPerlConfigHelper.Targets_Transparency)

	XPerlConfigHelper.Scale_AssistsFrame = ValidScale(XPerlConfigHelper.Scale_AssistsFrame)
	XPerl_Assists_Frame:SetScale(XPerlConfigHelper.Scale_AssistsFrame)

	XPerlConfigHelper.Targets_Scale = ValidScale(XPerlConfigHelper.Targets_Scale)
	XPerl_Frame:SetScale(XPerlConfigHelper.Targets_Scale)

	-- Assist Counters

	XPerl_SetupFrameSimple(XPerl_Frame, XPerlConfigHelper.Background_Transparency)
	XPerl_SetupFrameSimple(XPerl_MTTargets)
	XPerl_SetupFrameSimple(XPerl_OtherTargets)
	XPerl_SetupFrameSimple(XPerl_Stats, XPerlConfigHelper.Background_Transparency)
	XPerl_SetupFrameSimple(XPerl_Stats_List, XPerlConfigHelper.Background_Transparency)
	XPerl_SetupFrameSimple(XPerl_Assists_Frame, XPerlConfigHelper.Assists_BackTransparency)
	XPerlScrollSeperator:SetAlpha(XPerlConfigHelper.Assists_BackTransparency)
	XPerl_SetupFrameSimple(XPerl_Threat)

	XPerl_Frame_ToggleMTTargets:SetButtonTex()
	XPerl_Frame_ToggleTargets:SetButtonTex()
	XPerl_Frame_ExpandLock:SetButtonTex()
	XPerl_Frame_ToggleLabels:SetButtonTex()
	XPerl_Frame_ToggleShowMT:SetButtonTex()
	XPerl_Frame_Pin:SetButtonTex()

	if (XPerl_Player_TargettingFrame) then	XPerl_Player_TargettingFrame:Show();	end
	if (XPerl_Target_AssistFrame) then	XPerl_Target_AssistFrame:Show();	end

	if (XPerl_RegisterHighlight) then
		XPerl_RegisterHighlight(XPerl_Player_TargettingFrame, 4)
		XPerl_RegisterHighlight(XPerl_Target_AssistFrame, 4)
		XPerl_RegisterPerlFrames(XPerl_Player_TargettingFrame)
		XPerl_RegisterPerlFrames(XPerl_Target_AssistFrame)
	end
end

-- XPerl_Slash
function XPerl_Slash(msg)

	local commands = {}
	for x in string.gfind(msg, "[^ ]+") do
		tinsert(commands, string.lower(x))
	end

	local function SubCommandMatch(cmd, match)
		return strsub(match, 1, strlen(cmd)) == cmd
	end

	local function setAlpha()
		if (commands[2] and commands[3]) then
			if (SubCommandMatch(commands[2], "raid")) then
				XPerlConfigHelper.Targets_Transparency = commands[3]
				return true
			elseif (SubCommandMatch(commands[2], "assists")) then
				XPerlConfigHelper.AssistsFrame_Transparency = commands[3]
				return true
			end
		end
	end

	local function setScale()
		if (commands[2] and commands[3]) then
			if (SubCommandMatch(commands[2], "raid")) then
				XPerlConfigHelper.Targets_Scale = commands[3]
				return true
			elseif (SubCommandMatch(commands[2], "assists")) then
				XPerlConfigHelper.Scale_AssistsFrame = commands[3]
				return true
			elseif (SubCommandMatch(commands[2], "other")) then
				XPerlConfigHelper.OtherTargets_Scale = commands[3]
				return true
			end
		end
	end

	local options = {
		{"ma",		XPerl_SetMainAssist},
		{"assists",	XPerl_AssistsView_Open,		"Open Assists View"},
		{"raid",	XPerl_RaidHelp_Show,		"Open Raid Helper"},
		{"alpha",	setAlpha,			"Set Alpha Level"},
		{"scale",	setScale,			"Set Frame Scale"},
		{"labels",      XPerl_Toggle_ToggleLabels,	"Toggle Tank Labels"},
		{"ctra",	XPerl_Toggle_UseCTRATargets,	"Toggle Use of CTRA MT Targets"},
		{"othertargets",XPerl_Toggle_OtherTargets,	"Toggle display of other mob's targets"},
		{"find",	XPerl_SetFind},
	}

	local foundFunc
	local foundDesc
	if (commands[1]) then
		local smallest = 100
		local len = strlen(commands[1])
		if (len) then
			for i,entry in options do
				if (strsub(entry[1], 1, len) == commands[1]) then
					if (foundFunc) then
						XPerl_Message("Ambiguous command, failed.")
						foundFunc = nil
						break
					end
					foundFunc = entry[2]
					foundDesc = entry[3]
				end
			end
		end
	end

	if (foundFunc) then
		if (foundFunc(msg, commands[2], commands[3], commands[4])) then
			XPerl_SetupFrames()
			if (foundDesc) then
				XPerl_Message(foundDesc.." - |c0000C020done!|r")
			end
			return
		end
	end

	XPerl_Message("Options: /xp [|c00FFFF00find|r] [|c00FFFF00assists|r] [|c00FFFF00raid|r] [|c00FFFF00labels|r] [|c00FFFF00alpha|r raid|assists] [|c00FFFF00scale|r raid|assists|other] [|c00FFFF00ctra|r] [|c00FFFF00othertargets|r]")
end

function XPerl_OnLoad()

	XPerl_Frame:RegisterEvent("VARIABLES_LOADED")
	XPerl_Frame:RegisterEvent("RAID_ROSTER_UPDATE")

        SlashCmdList["XPERLHELPER"] = XPerl_Slash
        SLASH_XPERLHELPER1 = "/xp"
end

local function DefaultVar(name, value)
	if (XPerlConfigHelper[name] == nil or (type(value) ~= type(XPerlConfigHelper[name]))) then
		XPerlConfigHelper[name] = value
	end
end

local function XPerl_Defaults()
	DefaultVar("RaidHelper",		1)
	DefaultVar("UnitWidth",			100)
	DefaultVar("UnitHeight",		26)
	DefaultVar("UseCTRATargets",		1)
	DefaultVar("ExpandLock",		0)
	DefaultVar("ShowMT",			1)
	DefaultVar("MTLabels",			0)
	DefaultVar("MTTargetTargets",		1)
	DefaultVar("CollectOtherTargets",	1)
	DefaultVar("OtherTargetTargets",	1)
	DefaultVar("Targets_Scale",		1)
	DefaultVar("OtherTargets_Scale",	1)
	DefaultVar("Targets_Transparency",	0.8)
	DefaultVar("Background_Transparency",	1)
	DefaultVar("ThreatBar",			1)
	DefaultVar("Tooltips",			0)
	DefaultVar("MaxMainTanks",		10)

	DefaultVar("TargetCounters",		1)
	DefaultVar("TargetCountersSelf",	1)
	DefaultVar("TargetCountersEnemy",	1)
	DefaultVar("AssistsFrame",		1)
	DefaultVar("TargettingFrame",		1)
	DefaultVar("Scale_AssistsFrame",	1)
	DefaultVar("AssistsFrame_Transparency",	0.8)
	DefaultVar("Assists_BackTransparency",	1)

	DefaultVar("BorderColour",		{r = 0.5, g = 0.5, b = 0.5, a = 1})
	DefaultVar("BackgroundColour",		{r = 0, g = 0, b = 0, a = 1})
end

local XPerl_Old_KLHTM_Redraw = nil
function XPerl_KLHTM_Redraw(forceRedraw)
	XPerl_Old_KLHTM_Redraw(forceRedraw)
	if (XPerlConfigHelper.ThreatBar == 1) then
		XPerl_UpdateThreat()
	end
end

-- XPerl_Startup
-- Called after VARIABLES_LOADED
function XPerl_Startup()

	if (not XPerlConfigHelper) then
		XPerlConfigHelper = {}
	end
	XPerl_Defaults()
	XPerl_StartAssists()

	if (KLHTM_Redraw and KLHTM_GetRaidData) then
		if (KLHTM_Redraw ~= XPerl_KLHTM_Redraw) then
			XPerl_Old_KLHTM_Redraw = KLHTM_Redraw
			KLHTM_Redraw = XPerl_KLHTM_Redraw
		end
	else
		XPerl_UpdateThreat = nil
	end

	XPerl_SetupFrames()

        XPerlAssistPin:SetButtonTex()
        XPerl_Frame_Pin:SetButtonTex()
end

if (not XPerl_SetSmoothBarColor) then
	XPerl_SetSmoothBarColor = function(bar, percentage)
		if (bar) then
			local r, g, b
			if (XPerlConfig.ClassicHealthBar == 1) then
				if (percentage < 0.5) then
					r = 1
					g = 2*percentage
					b = 0
				else
					g = 1
					r = 2*(1 - percentage)
					b = 0
				end
			else
				r = XPerlConfig.ColourHealthEmpty.r + ((XPerlConfig.ColourHealthFull.r - XPerlConfig.ColourHealthEmpty.r) * percentage)
				g = XPerlConfig.ColourHealthEmpty.g + ((XPerlConfig.ColourHealthFull.g - XPerlConfig.ColourHealthEmpty.g) * percentage)
				b = XPerlConfig.ColourHealthEmpty.b + ((XPerlConfig.ColourHealthFull.b - XPerlConfig.ColourHealthEmpty.b) * percentage)
			end

			if (r >= 0 and g >= 0 and b >= 0 and r <= 1 and g <= 1 and b <= 1) then
				bar:SetStatusBarColor(r, g, b)

				local backBar = getglobal(bar:GetName().."BG")
				if (backBar) then
					backBar:SetVertexColor(r, g, b, 0.25)
				end
			end
		end
	end
end

if (not XPerl_SetUnitNameColor) then
	XPerl_SetUnitNameColor = function(argUnit,argFrame)

		local r, g, b = 0.5, 0.5, 1

	        if (UnitPlayerControlled(argUnit) or not UnitIsVisible(argUnit)) then
			local _, class = UnitClass(argUnit)
			r, g, b = XPerl_GetClassColour(class)
		else
	                if (UnitIsTapped(argUnit) and not UnitIsTappedByPlayer(argUnit)) then
	                        r, g, b = 0.5, 0.5, 0.5
	                else
				local reaction = UnitReaction(argUnit, "player")

				if (reaction) then
					if (reaction >= 5) then
						r, g, b = 0, 1, 0
					elseif (reaction <= 2) then
						r, g, b = 1, 0, 0
					elseif (reaction == 3) then
						r, g, b = 1, 0.5, 0
					else
						r, g, b = 1, 1, 0
					end
				else
	                        	if (UnitFactionGroup("player") == UnitFactionGroup(argUnit)) then
						r, g, b = 0, 1, 0
	                        	elseif (UnitIsEnemy("player", argUnit)) then
						r, g, b = 1, 0, 0
	                        	else
						r, g, b = 1, 1, 0
	                        	end
				end
			end
		end

		argFrame:SetTextColor(r, g, b)
	end
end

-- Perl UnitFrame function copies:
if (not XPerl_ColourFriendlyUnit) then
	XPerl_ColourFriendlyUnit = function(frame, partyid)
		if (UnitCanAttack("player", partyid) and UnitIsEnemy("player", partyid)) then	-- For dueling
	                frame:SetTextColor(1, 0, 0)
		else
			if (not XPerlConfig or XPerlConfig.ClassColouredNames == 1) then
				local _, engClass = UnitClass(partyid)
				local color = XPerl_GetClassColour(engClass)
				frame:SetTextColor(color.r, color.g, color.b)
			else
				if (UnitIsPVP(partyid)) then
	                	        frame:SetTextColor(0, 1, 0)
				else
	                	        frame:SetTextColor(0.5, 0.5, 1)
				end
			end
		end
	end
end

if (not XPerl_GetClassColour) then
	XPerl_GetClassColour = function(class)
		if (class) then
			local color = RAID_CLASS_COLORS[class];		-- Now using the WoW class color table
			if (color) then
				return color
			end
		end
		return {r = 0.5, g = 0.5, b = 1}
	end
end
