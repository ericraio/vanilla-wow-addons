-----------------------
-- TeamSpeak monitor --
-----------------------

local meSpeaking = false
local meSpeakChannel
local endSpeaking
speakerIcons = {}
Speaking = {}
local functions = {}
local tsFrame
local updatingName

if (not XPerlColourTable) then
	local function MashXX(class)
		local c = RAID_CLASS_COLORS[class]
		XPerlColourTable[class] = string.format("|c00%02X%02X%02X", 255 * c.r, 255 * c.g, 255 * c.b)
	end
	XPerlColourTable = {}
	MashXX("HUNTER")
	MashXX("WARLOCK")
	MashXX("PRIEST")
	MashXX("PALADIN")
	MashXX("MAGE")
	MashXX("ROGUE")
	MashXX("DRUID")
	MashXX("SHAMAN")
	MashXX("WARRIOR")
end

XPerlTeamSpeak = {}

-- CheckOnUpdate
local function CheckOnUpdate()
	local any
	if (endSpeaking) then
		any = true
	else
		for k,v in pairs(Speaking) do
			any = true
			break
		end
	end

	if (any) then
		XPerl_TeamSpeak_Events:SetScript("OnUpdate", XPerl_TeamSpeak_OnUpdate)
	else
		XPerl_TeamSpeak_Events:SetScript("OnUpdate", nil)
		XPerl_TeamSpeakIcon:SetTexCoord(0.75, 1, 0, 1)
	end
end

-- StartSpeaking(name)
local function StartSpeaking(name)

	if (not Speaking[name]) then
		Speaking[name] = {start = GetTime(), icons = {}}

		updatingName = name
		if (name == UnitName("player")) then
			if (functions.player) then
				functions.player()
			end
		else
			if (functions.party) then
				functions.party(name)
			end
		end
		if (functions.raid) then
			functions.raid(name)
		end
		updatingName = nil

		if (XPerl_TeamSpeak_Frame:IsShown()) then
			XPerl_SetInfoText()
		end

		CheckOnUpdate()
	end
end

-- StopSpeaking
local function StopSpeaking(name)

	local stopSpeaking = Speaking[name]
	if (stopSpeaking) then
		for k,v in pairs(stopSpeaking.icons) do
			v.SpeakerIcon.SpeakingName = nil
			v.SpeakerIcon.SpeakStart = nil
			v.SpeakerIcon:Hide()
			speakerIcons[v] = nil
		end

		Speaking[name] = nil

		if (XPerl_TeamSpeak_Frame:IsShown()) then
			XPerl_SetInfoText()
		end

		CheckOnUpdate()
	end
end

-- SetInfoText
local depth = 0
function XPerl_SetInfoText()
	depth = depth + 1
	local sorter = {}
	for k,v in pairs(Speaking) do
		tinsert(sorter, {name = k, time = GetTime()})
	end
	sort(sorter, function(a,b) return a.time < b.time end)

	local text = ""
	local removeName
	for k,v in pairs(sorter) do
		if (text ~= "") then
			text = text.."|r, "
		end

		if (UnitName("player") == v.name) then
			local _, class = UnitClass("player")
			text = text..XPerlColourTable[class]
		elseif (UnitInRaid("player")) then
			local name, rank, subgroup, level, _, class, zone, online
			for i = 1,GetNumRaidMembers() do
				name, rank, subgroup, level, _, class, zone, online = GetRaidRosterInfo(i)
				if (online) then
					if (name == v.name) then
						text = text..XPerlColourTable[class]
						break
					end
				elseif (not removeName) then
					removeName = name
					break			-- Since we'll be redoing the list anyway.
				end
			end
		elseif (UnitInParty("player")) then
			for i = 1,GetNumPartyMembers() do
				if (UnitName("party"..i) == v.name) then
					local _, class = UnitClass("party"..i)
					text = text..XPerlColourTable[class]
					break
				end
			end
		end

		text = text..v.name
	end
	XPerl_TeamSpeakText:SetText(text)

	if (removeName and depth < 10) then
		StopSpeaking(removeName)
	end
	depth = depth - 1
end


-- XPerl_BarUpdate
local speakerTimer = 0
local speakerCycle = 0
function XPerl_TeamSpeak_OnUpdate()

	if (endSpeaking) then
		if (GetTime() >= endSpeaking) then
			endSpeaking = nil
			if (meSpeakChannel) then
				SendAddonMessage(XPERL_COMMS_PREFIX, "NOSPEAK", meSpeakChannel)
			end
			CheckOnUpdate()
		end
	end

	speakerTimer = speakerTimer + arg1
	if (speakerTimer >= 0.1) then
		speakerTimer = 0
		speakerCycle = speakerCycle + 1
		if (speakerCycle > 6) then
			speakerCycle = 0
		end

		local left
		if (speakerCycle > 3) then
			left = (6 - speakerCycle) / 4
		else
			left = speakerCycle / 4
		end
		local right = left + 0.25

		local any
		local now = GetTime()
		local remove
		for k,v in pairs(speakerIcons) do
			if (not remove and v.SpeakStart and v.SpeakStart < now - 60) then
				remove = k
			end

			v:SetTexCoord(left, right, 0, 1)
			any = true
		end

		if (any) then
			XPerl_TeamSpeakIcon:SetTexCoord(left, right, 0, 1)
		else
			XPerl_TeamSpeakIcon:SetTexCoord(0.75, 1, 0, 1)
		end

		if (remove) then
			StopSpeaking(speakerIcons[remove].SpeakingName)
		end
	end
end

-- It won't send repetative SPEAK, NOSPEAK messages if you spam the button.
-- Will instead join them together until speak button released for at least 1 second

-- XPerl_TeamSpeakToggle
function XPerl_TeamSpeakToggle(keystate)
	local myName = UnitName("player")

	if (keystate == "down") then
		meSpeaking = true
		if (not endSpeaking) then
			if (UnitInRaid("player")) then
				meSpeakChannel = "RAID"
			elseif (UnitInParty("player")) then
				meSpeakChannel = "PARTY"
			end
			if (meSpeakChannel) then
				SendAddonMessage(XPERL_COMMS_PREFIX, "SPEAK", meSpeakChannel)
			end
		else
			endSpeaking = nil
		end

		StartSpeaking(myName)
	else
		StopSpeaking(myName)

		if (meSpeaking) then
			meSpeaking = false
			-- We speak for at least 1 second. This way spamming the speak button won't send a lot of traffic out
			endSpeaking = GetTime() + 1
		end
	end
end

-- XPerl_TeamspeakMessage
local function XPerl_TeamspeakMessage(name, msg, channel)
	if (name ~= UnitName("player")) then
		if (msg == "SPEAK") then
			StartSpeaking(name)
		elseif (msg == "NOSPEAK") then
			StopSpeaking(name)
		end
	end
end

-- XPerl_ActivateSpeaker
function XPerl_ActivateSpeaker(frame, anchor)
	if (frame) then
		if (not frame.SpeakerIcon) then
			if (not anchor) then
				anchor = "LEFT"
			end

			frame.SpeakerIcon = frame:CreateTexture(nil, "OVERLAY")
			frame.SpeakerIcon:SetWidth(20)
			frame.SpeakerIcon:SetHeight(20)
			frame.SpeakerIcon:SetPoint(anchor, frame, anchor, 5, -1)
			frame.SpeakerIcon:SetTexture("Interface\\Addons\\XPerl_TeamSpeak\\XPerl_Speakers")
			frame.SpeakerIcon:SetTexCoord(0, 0.25, 0, 1)
		end

		tinsert(Speaking[updatingName].icons, frame)

		speakerIcons[frame] = frame.SpeakerIcon
		frame.SpeakerIcon.SpeakingName = updatingName
		frame.SpeakerIcon.SpeakStart = GetTime()
		frame.SpeakerIcon:Show()
	end
end

-- XPerl_TeamSpeak_Register
-- Parameters:
--     group = "player"		func = function(speaking)
--     group = "party"		func = function(name, speaking)
--     group = "raid"		func = function(name, speaking)
function XPerl_TeamSpeak_Register(group, func)
	functions[group] = func
end

-- SetupAnchor()
local function SetupAnchor()

	XPerl_TeamSpeakText:ClearAllPoints()

	local r, jH, jV
	if (XPerlTeamSpeak.Anchor == "TOPLEFT") then
		r = "BOTTOMLEFT"
		jH = "LEFT"
		jV = "TOP"
	elseif (XPerlTeamSpeak.Anchor == "TOPRIGHT") then
		r = "BOTTOMRIGHT"
		jH = "RIGHT"
		jV = "TOP"
	elseif (XPerlTeamSpeak.Anchor == "BOTTOMLEFT") then
		r = "TOPLEFT"
		jH = "LEFT"
		jV = "BOTTOM"
	else
		r = "TOPRIGHT"
		jH = "RIGHT"
		jV = "BOTTOM"
	end

	XPerl_TeamSpeakText:SetPoint(XPerlTeamSpeak.Anchor, XPerl_TeamSpeakIcon, r, 0, 0)
	XPerl_TeamSpeakText:SetJustifyH(jH)
	XPerl_TeamSpeakText:SetJustifyV(jV)
end

-- XPerlTeamspeakSlashCmd()
local function XPerlTeamspeakSlashCmd()
	XPerl_TeamSpeak_Frame:Show()
	SetupAnchor()
end

-- XPerl_GetRaidPosition
if (not XPerl_GetRaidPosition) then
	function XPerl_GetRaidPosition(findName)
		for i = 1,GetNumRaidMembers() do
			if (UnitName("raid"..i) == findName) then
				return i
			end
		end
	end
end

if (not XPerl_GetPartyPosition) then
	function XPerl_GetPartyPosition(findName)
		for i = 1,GetNumPartyMembers() do
			if (UnitName("party"..i) == findName) then
				return i
			end
		end
	end
end

-- SetDefaultHandlers()
local function SetDefaultHandlers()

	if (not functions.player) then
		if (XPerl_Player) then
			functions.player = function()
				XPerl_ActivateSpeaker(XPerl_Player_NameFrame)
			end
		elseif (Perl_Player_Frame) then
			functions.player = function()
				XPerl_ActivateSpeaker(Perl_Player_NameFrame)
			end
		elseif (Nurfed_player) then
			functions.player = function()
				XPerl_ActivateSpeaker(Nurfed_player)
			end
		elseif (NUFPlayerFrame) then
			functions.player = function()
				XPerl_ActivateSpeaker(NUI_Player_ClickNDragFrame, "CENTER")
			end
		elseif (PlayerFrame) then
			functions.player = function()
				XPerl_ActivateSpeaker(PlayerFrame, "TOP")
			end
		end

		if (XPerl_party1) then
			functions.party = function(name)
				local id = XPerl_GetPartyPosition(name)
				if (id) then
					local nameFrame = getglobal("XPerl_party"..id.."_NameFrame")
					XPerl_ActivateSpeaker(nameFrame)
				end
			end
		elseif (Perl_party1) then
			functions.party = function(name)
				local id = XPerl_GetPartyPosition(name)
				if (id) then
					local nameFrame = getglobal("Perl_party"..id.."_NameFrame")
					XPerl_ActivateSpeaker(nameFrame)
				end
			end
		elseif (Nurfed_party1) then
			functions.party = function(name)
				local id = XPerl_GetPartyPosition(name)
				if (id) then
					local frame = getglobal("Nurfed_party"..id)
					XPerl_ActivateSpeaker(frame)
				end
			end
		elseif (NUFPartyMemberFrame1) then
			functions.party = function(name)
				local id = XPerl_GetPartyPosition(name)
				if (id) then
					local frame = getglobal("NUIPartyClickNDragFrame"..id)
					XPerl_ActivateSpeaker(frame, "CENTER")
				end
			end
		elseif (PartyMemberFrame1) then
			functions.party = function(name)
				local id = XPerl_GetPartyPosition(name)
				if (id) then
					local frame = getglobal("PartyMemberFrame"..id.."Disconnect"):GetParent():GetParent()
					XPerl_ActivateSpeaker(frame, "LEFT")
				end
			end
		end

		if (XPerl_Raid_Frame) then
			functions.raid = function(name)
				local id = XPerl_GetRaidPosition(name)
				if (id) then
					local frame = getglobal("XPerl_raid"..id.."_NameFrame")
					if (frame) then
						XPerl_ActivateSpeaker(frame)
					end
				end
			end
			return
		elseif (Perl_Raid1) then
			functions.raid = function(name)
				local id = XPerl_GetRaidPosition(name)
				if (id) then
					local frame = getglobal("Perl_Raid"..id.."_NameFrame")
					if (frame) then
						XPerl_ActivateSpeaker(frame)
					end
				end
			end
		elseif (CT_RAMember1) then
			functions.raid = function(name)
				local id = XPerl_GetRaidPosition(name)
				if (id) then
					local frame = getglobal("CT_RAMember"..id)
					if (frame) then
						XPerl_ActivateSpeaker(frame, "TOP")
					end
				end
			end
		elseif (Nurfed_RaidUnit1) then
			functions.raid = function(name)
				local id = XPerl_GetRaidPosition(name)
				if (id) then
					for i = 1,400 do
						local button = getglobal("Nurfed_RaidUnit"..i)
						if (not button) then
							break
						end
						if (button.id == id) then
							XPerl_ActivateSpeaker(button, "CENTER")
						end
					end
				end
			end
		end
	end
end

-- XPerl_TeamSpeak_OnEvent
function XPerl_TeamSpeak_OnEvent(event)
	if (event == "CHAT_MSG_ADDON") then
		if (arg1 == "X-Perl") then
			XPerl_TeamspeakMessage(arg4, arg2, arg3)
		end
	elseif (event == "PLAYER_ENTERING_WORLD") then
		this:UnregisterEvent("PLAYER_ENTERING_WORLD")
		if (not XPerlTeamSpeak) then
			XPerlTeamSpeak = {}

			if (XPerl_Player == nil) then
				XPerlTeamSpeak.tsFrame = true
			end
		end

		if (not XPerlTeamSpeak.Anchor) then
			XPerlTeamSpeak.Anchor = "TOPLEFT"
		end

		SetDefaultHandlers()

		SlashCmdList["XPERL_TEAMSPEAK"] = XPerlTeamspeakSlashCmd
		SLASH_XPERL_TEAMSPEAK1 = "/ts"
		SLASH_XPERL_TEAMSPEAK2 = "/teamspeak"
		SLASH_XPERL_TEAMSPEAK3 = "/ventrilo"
		SLASH_XPERL_TEAMSPEAK4 = "/vent"

		if (XPerlTeamSpeak.tsFrame) then
			XPerl_TeamSpeak_Frame:Show()
			SetupAnchor()
		end
	end
end

-- XPerl_TeamSpeakMenu()
function XPerl_TeamSpeakMenu()
	ToggleDropDownMenu(1, nil, XPerl_TeamSpeak_DropDown, "XPerl_TeamSpeak_Frame", 0, 0)
end

-- XPerl_Teamspeak_Dropdown_OnLoad
function XPerl_Teamspeak_Dropdown_OnLoad()
	UIDropDownMenu_Initialize(this, XPerl_Teamspeak_Dropdown_Initialize, "MENU")
end

-- SetAnchor
local function SetAnchor(a)
	XPerlTeamSpeak.Anchor = a
	HideDropDownMenu(1)
	SetupAnchor()
end

function XPerl_Teamspeak_Dropdown_Initialize()

	local info = {}

	if (UIDROPDOWNMENU_MENU_LEVEL == 2) then
		if (UIDROPDOWNMENU_MENU_VALUE == XPERL_TSMENU_ANCHOR) then
			info = {}
			info.text = XPERL_TSMENU_ANCHOR_TL
			if (XPerlTeamSpeak.Anchor == "TOPLEFT") then
				info.checked = 1
			end
			info.func = function() SetAnchor("TOPLEFT") end
			UIDropDownMenu_AddButton(info, 2)

			info = {}
			info.text = XPERL_TSMENU_ANCHOR_TR
			if (XPerlTeamSpeak.Anchor == "TOPRIGHT") then
				info.checked = 1
			end
			info.func = function() SetAnchor("TOPRIGHT") end
			UIDropDownMenu_AddButton(info, 2)

			info = {}
			info.text = XPERL_TSMENU_ANCHOR_BL
			if (XPerlTeamSpeak.Anchor == "BOTTOMLEFT") then
				info.checked = 1
			end
			info.func = function() SetAnchor("BOTTOMLEFT") end
			UIDropDownMenu_AddButton(info, 2)

			info = {}
			info.text = XPERL_TSMENU_ANCHOR_BR
			if (XPerlTeamSpeak.Anchor == "BOTTOMRIGHT") then
				info.checked = 1
			end
			info.func = function() SetAnchor("BOTTOMRIGHT") end
			UIDropDownMenu_AddButton(info, 2)
		end
		return
	end

	info = {}
	info.text = XPERL_TSMENU_ANCHOR
	info.hasArrow = 1
	info.notCheckable = 1
	UIDropDownMenu_AddButton(info)

	info = {}
	info.text = RESET
	info.notCheckable = 1
	info.func = XPerl_TeamSpeakReset
	UIDropDownMenu_AddButton(info)

	info = {}
	info.text = CLOSE
	info.notCheckable = 1
	info.func = function() XPerl_TeamSpeak_Frame:Hide() end
	UIDropDownMenu_AddButton(info)
end

-- XPerl_TeamSpeakReset
function XPerl_TeamSpeakReset()
	for k,v in pairs(Speakers) do
		StopSpeaking(k)
	end
end
