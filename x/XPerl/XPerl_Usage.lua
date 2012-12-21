if (not XPerl_GetUsage) then

XPerl_Usage = {}
local lastSend = 0
local notifiedVersion = nil
local needToSend = {}
local responsePacket

-- CheckForNewerVersion
local function CheckForNewerVersion(ver)
	if (not strfind(strlower(ver), "beta")) then
		--local _, _, a,b,c = strfind(ver, "(%d+).(%d+).(%d+)")
		--local _, _, aa,bb,cc = strfind(XPerl_VersionNumber, "(%d+).(%d+).(%d+)")
		--local vThem = a * 10000 + b * 100 + c
		--local vMe = aa * 10000 + bb * 100 + cc
		--if (vThem > vMe) then
		if (ver > XPerl_VersionNumber) then
			if (not notifiedVersion or notifiedVersion < ver) then
				notifiedVersion = ver
				DEFAULT_CHAT_FRAME:AddMessage(XPerl_ProductName.." |c00FFFFFF"..ver.."|r is available for download")
			end
			return true
		end
	end
end

-- ProcessXPerlMessage
local function ProcessXPerlMessage(unitName, msg)
	local myUsage = XPerl_Usage[unitName]
	if (not myUsage) then
		myUsage = {}
		XPerl_Usage[unitName] = myUsage
	end

	local rcv
	if (msg == "R") then
		-- It's a response packet, so don't reply
		responsePacket = true
		if (XPerlTest) then myUsage.responses = (myUsage.responses or 0) + 1 end

	elseif (strsub(msg, 1, 4) == "VER ") then
		-- ChatFrame7:AddMessage(" Received info from "..unitName..", channel: "..arg3)
		if (XPerlTest) then myUsage.packets = (myUsage.packets or 0) + 1 end

		local ver = strsub(msg, 5)
		if (ver ~= XPerl_VersionNumber) then
			myUsage.version = ver
			CheckForNewerVersion(ver)
		end
		if (not responsePacket) then
			rcv = true
		end

	elseif (strsub(msg, 1, 4) == "MOD ") then
		myUsage.mods = strsub(msg, 5)

	elseif (strsub(msg, 1, 4) == "LOC ") then
		local loc = strsub(msg, 5)
		if (loc ~= GetLocale()) then
			myUsage.locale = loc
		end

	elseif (strsub(msg, 1, 3) == "GC ") then
		myUsage.gc = tonumber(strsub(msg, 4))
	end

	if (rcv) then
		if (unitName ~= UnitName("player")) then
			-- Will send out our own version when we receive one, if it's been at least 2 minutes since the last send
			XPerl_SendModules(arg3, true)
		end
	end
end

-- GuildMateTooltip
local function GuildMateTooltip()
	if (XPerlConfig.XPerlTooltipInfo == 0) then
		return
	end

	local name, rank, rankIndex, level, class, zone, note, officernote, online = GetGuildRosterInfo(this.guildIndex)
	if (name) then
		local xpUsage = XPerl_Usage[name]
		if (xpUsage) then
			local ver
			if (xpUsage.version) then
				ver = xpUsage.version
			else
				ver = XPerl_VersionNumber
			end

			GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT")
			GameTooltip:ClearLines()

			if (xpUsage.locale) then
				GameTooltip:AddDoubleLine(XPerl_ProductName.." "..ver, xpUsage.locale, 1, 1, 1, 0.5, 0.5, 0.5)
			else
				GameTooltip:SetText(XPerl_ProductName.." "..ver, 1, 1, 1)
			end

			if (xpUsage.version and CheckForNewerVersion(xpUsage.version)) then
				GameTooltip:AddLine("*Newer version", 0.5, 1, 0.5)
			end

			if (xpUsage.mods) then
				local modList = XPerl_DecodeModuleList(xpUsage.mods)
				if (modList) then
					GameTooltip:AddLine("Modules: "..modList, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
				end
			end

			if (xpUsage.gc and IsShiftKeyDown()) then
				GameTooltip:AddLine("UI Mem Max: "..xpUsage.gc, 0.8, 0.2, 0.2)
			end

			GameTooltip:Show()
			return
		end
	end

	GameTooltip:Hide()
end

-- XPerl_UsageStartup
function XPerl_Usage_OnEvent()

	if (event == "PLAYER_ENTERING_WORLD") then
		-- Hook the guild name list to show tooltip for X-Perl users
		for i = 1,13 do
			local f = getglobal("GuildFrameButton"..i)
			if (f) then
				f:SetScript("OnEnter", GuildMateTooltip)
				f:SetScript("OnLeave", XPerl_PlayerTipHide)
			end
			f = getglobal("GuildFrameGuildStatusButton"..i)
			if (f) then
				f:SetScript("OnEnter", GuildMateTooltip)
				f:SetScript("OnLeave", XPerl_PlayerTipHide)
			end
		end

		if (GetNumRaidMembers() > 0) then
			needToSend.RAID = true
		elseif (GetNumPartyMembers() > 0) then
			needToSend.PARTY = true
		end
		XPerl_SendModules("GUILD")
	else
		if (arg1 == XPERL_COMMS_PREFIX) then
			XPerl_ParseCTRA(arg4, arg2, ProcessXPerlMessage)
			responsePacket = nil
		elseif (arg1 == "CTRA") then
			XPerl_SendToChannel()		-- Check's to see if anything pending to send
		end
	end
end

-- XPerl_SplitCTRAMessage
function XPerl_SplitCTRAMessage(msg, char)
	local arr = { }
	while (strfind(msg, char) ) do
		local iStart, iEnd = strfind(msg, char)
		tinsert(arr, strsub(msg, 1, iStart-1))
		msg = strsub(msg, iEnd+1, strlen(msg))
	end
	if ( strlen(msg) > 0 ) then
		tinsert(arr, msg)
	end
	return arr
end

-- XPerl_ParseCTRA
function XPerl_ParseCTRA(nick, msg, func)
	if (strfind(msg, "#")) then
		local arr = XPerl_SplitCTRAMessage(msg, "#")
		for i,subMsg in pairs(arr) do
			func(nick, subMsg)
		end
	else
		func(nick, msg)
	end
end

-- !!!!! Don't change the order of this list - EVER!!!!!
local xpModList = {"XPerl", "XPerl_Player", "XPerl_PlayerPet", "XPerl_Target", "XPerl_TargetTarget", "XPerl_Party", "XPerl_PartyPet", "XPerl_RaidFrames", "XPerl_RaidHelper", "XPerl_RaidAdmin"}
--------------------------------------------------------

-- XPerl_SendModules
function XPerl_SendModules(chan, response)
	if (not chan) then
		chan = "RAID"
	end
	needToSend[chan] = true
	XPerl_SendToChannel(response)
end

-- MakePacket
local function MakePacket(response)

	local modules = ""
	for k,v in pairs(xpModList) do
		modules = modules..(tostring(IsAddOnLoaded(v) or 0))
	end
	local _, gc = gcinfo()

	local resp
	if (response) then resp = "R#" else resp = "" end

	return resp.."VER "..XPerl_VersionNumber.."#GC "..gc.."#LOC "..GetLocale().."#MOD "..modules
end

-- XPerl_SendToChannel
function XPerl_SendToChannel(response)
	if (GetTime() < lastSend + 2*60) then
		return
	end
	lastSend = GetTime()

	local packet
	for k,v in pairs({"GUILD", "RAID", "PARTY", "BATTLEGROUND"}) do
		if (needToSend[v]) then
			if (IsInGuild() or v ~= "GUILD") then
				if (not packet) then
					packet = MakePacket(response)
				end

				SendAddonMessage(XPERL_COMMS_PREFIX, packet, v)
				needToSend[v] = nil
			end
		end
	end
end

-- XPerl_DecodeModuleList
function XPerl_DecodeModuleList(modList)
	local nameList = {XPerl = "Core", XPerl_Player = "Player", XPerl_PlayerPet = "Player's Pet", XPerl_Target = "Target", XPerl_TargetTarget = "Target's Target", XPerl_Party = "Party", XPerl_PartyPet = "Party Pets", XPerl_RaidFrames = "Raid Frames", XPerl_RaidHelper = "Raid Helper", XPerl_RaidAdmin = "Raid Admin"}
	local ret, sep, any = "", ""
	for k,v in pairs(xpModList) do
		if (strsub(modList, k, k) == "1") then
			if (nameList[v]) then
				ret = ret..sep..nameList[v]
			else
				ret = ret..sep..v
			end
			sep = ", "
			any = true
		end
	end
	if (any) then
		return ret
	end
end

-- XPerl_GetUsage(unitName)
function XPerl_GetUsage(unitName)
	return XPerl_Usage[unitName]
end

if (not XPerl_UsageFrame) then
	local f = CreateFrame("Frame", "XPerl_UsageFrame")
	f:RegisterEvent("PLAYER_ENTERING_WORLD")
	f:RegisterEvent("CHAT_MSG_ADDON")
	f:SetScript("OnEvent", XPerl_Usage_OnEvent)
end

end
