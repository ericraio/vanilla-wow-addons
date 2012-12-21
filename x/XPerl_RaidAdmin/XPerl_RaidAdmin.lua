local SavedRoster = nil
local XswapCount = 0
local XmoveCount = 0
local XPendingRosters = 0
local WaitingForRoster

-- AdminCommands
local function AdminCommands(msg)
	local args = {}
	for value in string.gfind(msg, "[^ ]+") do
		tinsert(args, string.lower(value))
	end

	if (not args[1]) then
        	XPerl_AdminFrame:Show()
	else
		if (not XPerl_AdminCommands[args[1]] or not XPerl_AdminCommands[args[1]](args[2], args[3], args[4])) then
			XPerl_AdminCommands.help()
		end
	end
end

-- DefaultVar
local function DefaultVar(name, value)
	if (XPerl_Admin[name] == nil or (type(value) ~= type(XPerl_Admin[name]))) then
		XPerl_Admin[name] = value
	end
end

-- Defaults
local function Defaults()

	if (not XPerl_Admin) then
		XPerl_Admin = {}
	end

	DefaultVar("AutoHideShow",	1)
	DefaultVar("SavedRosters",	{})

	DefaultVar("Transparency",	0.8)
	DefaultVar("Scale_ItemCheck",	1)
	DefaultVar("Scale_Admin",	1)
end

-- XPerl_AdminOnLoad
function XPerl_AdminOnLoad()

	XPerl_Admin = {}

	SlashCmdList["XPERLRAIDADMIN"] = AdminCommands
	SLASH_XPERLRAIDADMIN1 = "/rad"
	SLASH_XPERLRAIDADMIN2 = "/xpadmin"
	SLASH_XPERLRAIDADMIN3 = "/xpad"

	this:RegisterEvent("VARIABLES_LOADED")
	this:RegisterEvent("RAID_ROSTER_UPDATE")
end

-- XPerl_AdminStartup
local function XPerl_AdminStartup()

	Defaults()
        XPerl_AdminFrame_TitleBar_Pin:SetButtonTex()

	XPerl_Check_Setup()
	XPerl_AdminSetupFrames()

end

-- XPerl_SetupFrameSimple
function XPerl_SetupFrameSimple(argFrame, alpha)
	argFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, alpha or 1)
	argFrame:SetBackdropColor(0, 0, 0, alpha or 1)
end

-- XPerl_AdminSetupFrames()
function XPerl_AdminSetupFrames()
	XPerl_SetupFrameSimple(XPerl_Check)
	XPerl_SetupFrameSimple(XPerl_CheckListItems)
	XPerl_SetupFrameSimple(XPerl_CheckListPlayers)

	XPerl_SetupFrameSimple(XPerl_AdminFrame)

	XPerl_Check:SetAlpha(XPerl_Admin.Transparency)
	XPerl_AdminFrame:SetAlpha(XPerl_Admin.Transparency)

	XPerl_Check:SetScale(XPerl_Admin.Scale_ItemCheck)
	XPerl_AdminFrame:SetScale(XPerl_Admin.Scale_Admin)
end

-- XPerl_Help
local function XPerl_Help()
	XPerl_Message("/rad [save | load name] [auto]")
end

-- CheckMyRank
local function CheckMyRank()
	if (XPerl_Admin.AutoHideShow == 1) then
		if (GetNumRaidMembers() > 0) then
			local me = UnitName("player")
			for i = 1,GetNumRaidMembers() do
				local name, rank = GetRaidRosterInfo(i)
				if (name == me) then
					if (rank > 0) then
						XPerl_AdminFrame:Show()
					else
						XPerl_AdminFrame:Hide()
					end
					break
				end
			end
		else
			XPerl_AdminFrame:Hide()
		end
	end
end

-- XPerl_ToggleAuto
local function XPerl_ToggleAuto()
	if (XPerl_Admin.AutoHideShow == 1) then
		XPerl_Admin.AutoHideShow = 0
	else
		XPerl_Admin.AutoHideShow = 1
	end
	CheckMyRank()
end

-- XPerl_SaveRoster
function XPerl_SaveRoster(saveName)

	if (not saveName or saveName == "") then
		local hours, mins = GetGameTime()
		saveName = hours..":"..mins
	end

	local Roster = {}

	for i = 1,GetNumRaidMembers() do
		local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i)
		Roster[name] = {group = subgroup, class = fileName}
	end

	if (not XPerl_Admin.SavedRosters) then
		XPerl_Admin.SavedRosters = {}
	end
	XPerl_Admin.SavedRosters[saveName] = Roster

	XPerl_Message(string.format(XPERL_SAVED_ROSTER, saveName))

	return true
end

local function LoadRoster()

--ChatFrame7:AddMessage("Arranging...")
	local swapCount = 0
	local moveCount = 0
	local CurrentRoster = {}
	local CurrentGroups = {}
	local FreeFloating = {}

	-- Store the current raid roster, and a list of players in the raid, but not in the saved roster
	for i = 1,GetNumRaidMembers() do
		local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i)
		CurrentRoster[name] = {index = i, group = subgroup, class = fileName}

		if (not SavedRoster[name]) then
			-- Not in the saved roster, so doesn't matter where
			FreeFloating[name] = {group = subgroup, class = fileName}
		end
	end

	local function Swap(a, b)
--ChatFrame7:AddMessage("Swapping: "..a.." (Grp"..CurrentRoster[a].group..") with "..b.." (Grp"..CurrentRoster[b].group..")")
		SwapRaidSubgroup(CurrentRoster[a].index, CurrentRoster[b].index)
		local save = CurrentRoster[b].group
		CurrentRoster[b].group = CurrentRoster[a].group
		CurrentRoster[b].moved = true
		CurrentRoster[a].group = save
		CurrentRoster[a].moved = true

		if (FreeFloating[a]) then
			FreeFloating[a].group = CurrentRoster[a].group
		end
		if (FreeFloating[b]) then
			FreeFloating[b].group = CurrentRoster[b].group
		end

		swapCount = swapCount + 1
	end

	local function Move(name, target)
--ChatFrame7:AddMessage("Moving: "..name.." (Grp"..CurrentRoster[name].group..") to group "..target)
       		SetRaidSubgroup(CurrentRoster[name].index, target)
       		CurrentRoster[name].group = target
       		CurrentRoster[name].moved = true
       		if (FreeFloating[name]) then
       			FreeFloating[name].group = target
       		end

       		moveCount = moveCount + 1
       	end

	local function GroupCount(grp)
		local count = 0
		for name,entry in pairs(CurrentRoster) do
			if (entry.group == grp) then
				count = count + 1
			end
		end
		return count
	end

       	for nameSaved, saved in SavedRoster do
		local name = nameSaved
		local group = saved.group

       		if (not CurrentRoster[name]) then
			-- Saved player not in raid, so find someone of the same class in the free floater list
			for floaterName,floater in pairs(FreeFloating) do
				if (floater.class == saved.class) then
					name = floaterName
					FreeFloating[name] = nil
					break
				end
			end
		end

       		if (CurrentRoster[name] and not CurrentRoster[name].moved) then
       			if (CurrentRoster[name].group == group) then
       				CurrentRoster[name].moved = true;		-- They're in right group already
       			elseif (not FreeFloating[name]) then
				-- First see if we can directly swap any 2 players
       				local swapName
       				for name2, saved2 in SavedRoster do
       					if (name ~= name2) then
       						if (CurrentRoster[name] and CurrentRoster[name].group == saved2.group) then
       							if (CurrentRoster[name2] and CurrentRoster[name2].group == group) then
       								swapName = name2
       								break
       							end
       						end

       					end
       				end

       				if (swapName) then
       					Swap(name, swapName)
					--break
       				else
					local done
       					-- Nothing suitable found to swap, see if target group has space
       					if (GroupCount(group) < 5) then
       						Move(name, group)
						done = true
       						--break
       					end

       					-- No space in target group, put them anywhere
       					if (not done) then
       						for i = 1,8 do
       							if (CurrentRoster[name].group ~= i and GroupCount(i) < 5) then
       								Move(name, i)
								done = true
       								break
       							end
       						end
       					end

       					if (not done) then
						-- Nothing done yet, see if we can swap a free floater
						local free
						for name, group in pairs(FreeFloating) do
							if (group ~= CurrentRoster[name].group) then
								free = name
								break
							end
						end
       						if (free) then
       							Swap(CurrentRoster[name].index, CurrentRoster[free].index)
							--break
       						else
							-- Couldn't put them anywhere, add them to floater list
       							FreeFloating[name] = group
       						end
					--else
					--	break
       					end
       				end
       			end
       		end

       		--if (moveCount > 0) then		-- or swapCount > 0) then
		--	break
		--end
       	end

       	if (moveCount == 0 and swapCount == 0) then
--ChatFrame7:AddMessage("Finished!")
 		XPerl_StopLoad()
	else
		WaitingForRoster = GetTime()
		XswapCount = XswapCount + swapCount
		XmoveCount = XmoveCount + moveCount
		XPendingRosters = XPendingRosters + swapCount
		XPendingRosters = XPendingRosters + moveCount
	end
--ChatFrame7:AddMessage("Done arranging (swaps: "..swapCount..")  (moves: "..moveCount..")")
end

-- XPerl_AdminOnEvent
function XPerl_AdminOnEvent()
	CheckMyRank()

	if (event == "RAID_ROSTER_UPDATE") then
                XPerl_AdminFrame_Controls:Details()

		if (WaitingForRoster) then
			if (not XFinishedLoad) then
				XPendingRosters = XPendingRosters - 1
				if (XPendingRosters < 1) then
					LoadRoster()
				end
			end
		end

	elseif (event == "VARIABLES_LOADED") then
		this:UnregisterEvent(event)
		XPerl_AdminStartup()
	end
end

-- XPerl_Admin_OnUpdate
function XPerl_Admin_OnUpdate(elapsed)
	if (WaitingForRoster) then
		if (GetTime() > WaitingForRoster + 5000) then
			XPerl_StopLoad()
		end
	end
end

-- XPerl_LoadRoster
function XPerl_LoadRoster(loadName)

	if (not XPerl_Admin.SavedRosters) then
		return
	end

	SavedRoster = XPerl_Admin.SavedRosters[loadName]
	if (SavedRoster) then
		XPerl_AdminFrame_Controls_StopLoad:Show()
		XPerl_AdminFrame_Controls_LoadRoster:Hide()

		XFinishedLoad = false
		WaitingForRoster = nil
		XPendingRosters = 0
		LoadRoster()
	else
		if (not loadName) then
			XPerl_Message(XPERL_NO_ROSTER_NAME_GIVEN)
		else
			XPerl_Message(string.format(XPERL_NO_ROSTER_CALLED, loadName))
		end
	end

	return true
end

-- XPerl_StopLoad
function XPerl_StopLoad()
	XPerl_AdminFrame_Controls_StopLoad:Hide()
	XPerl_AdminFrame_Controls_LoadRoster:Show()

	XFinishedLoad = true
	WaitingForRoster = nil
	SavedRoster = nil
	XPendingRosters = 0

	XPerl_AdminFrame_Controls:Details()
end

function XPerl_Message(msg)
	DEFAULT_CHAT_FRAME:AddMessage(XPERL_MSG_PREFIX.."- "..msg)
end

XPerl_AdminCommands = {
	save = XPerl_SaveRoster,
	load = XPerl_LoadRoster,
	auto = XPerl_ToggleAuto,
	help = XPerl_Help
}

-- XPerl_Admin_CountDifferences
function XPerl_Admin_CountDifferences(rosterName)
	if (not XPerl_Admin.SavedRosters) then
		return
	end

	local count = 0

	SavedRoster = XPerl_Admin.SavedRosters[rosterName]
	if (SavedRoster) then
		for i = 1,GetNumRaidMembers() do
			local name, rank, subgroup = GetRaidRosterInfo(i)

			if (SavedRoster[name]) then
				if (SavedRoster[name].group ~= subgroup) then
					count = count + 1
				end
			else
				count = count + 1
			end
		end

		return count
	end
end

function XPerl_Admin_ControlsOnLoad()

	this.Details = function()
	        local name = XPerl_AdminFrame_Controls_Edit:GetText()
	        local diff
	        if (name) then
	                diff = XPerl_Admin_CountDifferences(name)
	        end

	        if (diff) then
	                XPerl_AdminFrame_Controls_DetailsText:SetText(string.format(XPERL_ADMIN_DIFFERENCES, diff))
	                XPerl_AdminFrame_Controls_Details:Show()
	        else
	                XPerl_AdminFrame_Controls_Details:Hide()
	        end
	end

	this.MakeList = function()
	        local index = 1;
	        local find = XPerl_AdminFrame_Controls_Edit:GetText()

	        local Offset = XPerl_AdminFrame_Controls_RosterScrollBarScrollBar:GetValue()
	        for name,roster in pairs(XPerl_Admin.SavedRosters) do
	                if (index - 1 >= Offset) then
	                        local f = getglobal("XPerl_AdminFrame_Controls_Roster"..index)
	                        if (f) then
	                                if (name == find) then
	                                        f:LockHighlight()
	                                else
	                                        f:UnlockHighlight()
	                                end
	                                f:SetText(name)
	                                f:Show()
	                        end
	                end
	                index = index + 1
	        end
	        for i = index,5 do
	                local f = getglobal("XPerl_AdminFrame_Controls_Roster"..i)
	                if (f) then
	                        f:SetText("")
	                        f:UnlockHighlight()
	                        f:Hide()
	                end
	        end

	        local offset = XPerl_AdminFrame_Controls_RosterScrollBarScrollBar:GetValue()
	        if (FauxScrollFrame_Update(XPerl_AdminFrame_Controls_RosterScrollBar, index - 1, 5, 1)) then
	                XPerl_AdminFrame_Controls_RosterScrollBar:Show()
	        else
	                XPerl_AdminFrame_Controls_RosterScrollBar:Hide()
	        end

	        XPerl_AdminFrame_Controls:Details()
	end

	this.Validate = function()
	        XPerl_AdminFrame.Valid = false
	        XPerl_AdminFrame_Controls_LoadRoster:Disable()
	        XPerl_AdminFrame_Controls_DeleteRoster:Disable()

	        local index = 1
	        local find = XPerl_AdminFrame_Controls_Edit:GetText()
	        local Offset = XPerl_AdminFrame_Controls_RosterScrollBarScrollBar:GetValue()
	        for name,roster in pairs(XPerl_Admin.SavedRosters) do
	                if (index - 1 >= Offset) then
	                	local f = getglobal("XPerl_AdminFrame_Controls_Roster"..index)
				if (not f) then
					break
				end
	                	if (name == find) then
	                	        f:LockHighlight()
	                	        XPerl_AdminFrame.Valid = true
	                	        if (IsRaidLeader()) then
	                	                XPerl_AdminFrame_Controls_LoadRoster:Enable()
	                	        end
	                	        XPerl_AdminFrame_Controls_DeleteRoster:Enable()
	                	else
	                	        f:UnlockHighlight()
	                	end
			end
	                index = index + 1
	        end
	end
end
