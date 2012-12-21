--[[
	Non Event functions for FlexBar
	Last Modified
		01/09/2005	Initial version
		08/05/2005	Fixed concatenation errors - Ratbert_CP
		08/05/2005	Fixed arethmetic error - Ratbert_CP
		08/06/2005	Fixed spelling error in GetText to GetText() - Shirtan
		08/10/2005  Minor changes for floating buttons, fixed sort for script List	- Sherkhan
		08/12/2005  Reorganized LoadProfile, and many instances where we were applying things globally to all buttons	- Sherkhan
					instead of just to an individual button or group. Hopefully will truly fix Floating Button issue.
					Also made changes to reduce looping for efficiency.
		08/12/2005  Added Text3 Field	- Sherkhan
		08/21/2005	Added commands for showing button information on KeyBinding key pressed
--]]

local util = Utility_Class:New()

function FB_ApplySettings()
-- For each button, apply the saved settings. 
-- Originally every slash command came through here.
-- changed that so that any conditional slash commands
-- call the appropriate apply function only for the buttons
-- they are changing, and save only the setting they are
-- changing to the profile.  The reason being I don't want
-- all the potentially expensive code in scaling etc to execute
-- on conditionals if they don't have to.
	local index
	for index = 1,FBNumButtons do
		FB_Apply_SingleSetting(index)
	end
end

function FB_GetCoordsForGroup(groupnum)
	-- Just update the group coordinates, instead of all groups or all buttons
	local members = FB_GetGroupMembers(groupnum)
	if members.n < 1 then return end

	for index = 1, members.n do
		FB_GetCoords(members[index])
	end
	
end

function FB_Apply_SingleSetting(buttonnum)
	-- Removed all code for Saving anything to the Character Profile from this function as the Save
	-- now takes place on individual move or change actions on a per button basis - Never globally
	-- Apply settings to a single button
	local button, frame = FB_GetWidgets(buttonnum)
	-- Apply hide state
	FB_ApplyHidden(buttonnum)
	-- Apply alpha
	FB_ApplyAlpha(buttonnum)
	-- Apply scale
	FB_ApplyScale(buttonnum)
	-- Apply lock state
	FB_ApplyLocked(buttonnum)
	-- Apply remap
	FB_ApplyRemap(buttonnum)
	-- Apply show grid
	FB_ApplyGrid(buttonnum)
	-- Save button state to character profile
	FB_SaveState(buttonnum)

	FlexBarButton_UpdateUsable(button)

	-- Update hotkey text
	if FBButtonInfoShown == true then 
		FB_ShowSingleButtonInfo(buttonnum)
	else
		FB_TextSub(buttonnum)
		FlexBarButton_UpdateHotkeys(button)
		FB_ApplyTextPosition(buttonnum)
	end
end

function FB_ResyncSettings()
-- For each button, get coords and save to profile. 
-- Coords are only saved by wow for user placed items - the others
-- don't get saved.
	local index
	
	-- check to see if the scale has gotten munged by an alt tab, and reapply settings
	if FlexBar:GetScale() > .25 then
		FB_LoadProfile()
		return
	end
	-- Removed code that would get the button coordinates from here. 
	-- No reason to update the save profile coordinates on a timer.
end

function FB_ReformAllGroups()
	-- For each button, check group status, attach to appropriate frame. 
	-- This function is called as part of FB_LoadProfile Only - otherwise the individual groups or
	-- buttons are set.
	if(FB_DebugFlag == 1) then
		FB_ReportToUser("<< FB_ReformAllGroups: All Groups are Being Reformed >>"); 
	end

	local index
	for index = 1,FBNumButtons do
		-- Check to see that buttons have base coords in the current profile, if not then get some.
		-- This cas can occur when FlexBar is initially installed, or has not been configured for
		-- a character (resetall as well)
		if((not FBState[index]["xcoord"]) or (not FBState[index]["ycoord"])) then
			FB_UpdateButtonLoc(index)
		end
	
		local button, frame = FB_GetWidgets(index)
		if FBState[index]["group"] and (FBState[index]["group"] ~= index) then
			FB_LockButton(index)
			local anchor = FBState[index]["group"]
			
			-- Check to see that anchor button has base coords, if not then get some !
			if((not FBState[anchor]["xcoord"]) or (not FBState[anchor]["ycoord"])) then
				FB_UpdateButtonLoc(anchor)
			end
			
			local x = FBState[index]["xcoord"] - FBState[anchor]["xcoord"]
			local y = FBState[index]["ycoord"] - FBState[anchor]["ycoord"]
			frame:ClearAllPoints()
			frame:SetPoint("BOTTOMRIGHT", "FlexFrame" .. FBState[index]["group"], "BOTTOMRIGHT", x, y)
			FBState[index]["locked"] = true
		elseif FBState[index]["group"] and (FBState[index]["group"] == index) then
			local x = FBState[index]["xcoord"]
			local y = FBState[index]["ycoord"]
			frame:ClearAllPoints()
			frame:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMLEFT", x, y)
		else
			local x = FBState[index]["xcoord"]
			local y = FBState[index]["ycoord"]
			frame:ClearAllPoints()
			frame:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMLEFT", x, y)
		end
		-- Changed ApplySettings to this call (does a loop once, instead of 2 seperate loops, accomplishes same thing
		FB_Apply_SingleSetting(index)
	end

	-- Generate group data for use InGroupBounds()
	for index = 1, FBNumButtons do
		-- local button, frame = FB_GetWidgets(index) (needless call was being made, values never used here)
		if FBState[index]["group"] == index then
			FBGroupData[index] = FB_GetBoundingButtons(index)
		else
			FBGroupData[index] = nil;
		end
	end
end

function FB_DisbandGroup(group)
	-- For each group button in the group to be disbanded, attach to UIParent. 
	local index
	local members = FB_GetGroupMembers(group)
	
	if members.n < 1 then return end

	if(FB_DebugFlag == 1) then
		FB_ReportToUser("<< FB_DisbandGroup: Group #"..group.." being Disbanded >>"); 
	end

	for index = 1, members.n do
		local button, frame = FB_GetWidgets(members[index])
		local x = FBState[members[index]]["xcoord"]
		local y = FBState[members[index]]["ycoord"]
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMLEFT", x, y)
		FB_Apply_SingleSetting(members[index])
	end

	-- Clear group Bounding data
	FBGroupData[group] = nil;
end

function FB_ReformGroup(group)
	-- For each group button, attach to appropriate frame. 
	local index
	local members = FB_GetGroupMembers(group)
	
	if members.n < 1 then return end

	if(FB_DebugFlag == 1) then
		FB_ReportToUser("<< FB_ReformGroup: Group #"..group.." Being Reformed >>"); 
	end

	-- Check to see that buttons have base coords, if not then get some 
	-- The only time no base coordinates will exist is after a resetall or when
	-- FlexBar is initially being configured for a character.
	if ((not FBState[group]["xcoord"]) or (not FBState[group]["ycoord"])) then
		FB_GetCoordsForGroup(group)
	end
	
	for index = 1, members.n do
		local button, frame = FB_GetWidgets(members[index])
		if (FBState[members[index]]["group"] ~= members[index]) then
			-- Group button attach to Anchor with relative coordintates on frame
			FB_LockButton(members[index])
			local x = FBState[members[index]]["xcoord"] - FBState[group]["xcoord"]
			local y = FBState[members[index]]["ycoord"] - FBState[group]["ycoord"]
			frame:ClearAllPoints()
			frame:SetPoint("BOTTOMRIGHT", "FlexFrame" .. FBState[members[index]]["group"], "BOTTOMRIGHT", x, y)
			FBState[members[index]]["locked"] = true
		else
			-- Group Anchor Button
			local x = FBState[members[index]]["xcoord"]
			local y = FBState[members[index]]["ycoord"]
			frame:ClearAllPoints()
			frame:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMLEFT", x, y)
		end
		FB_Apply_SingleSetting(members[index])
	end

	-- Generate group data for use InGroupBounds()
	FBGroupData[group] = FB_GetBoundingButtons(group)
end

function FB_UpdateButtonLoc(buttonnum)
	-- The button frame has been moved (MoveABS, MoveREL), update co-ordinates
	if(FB_DebugFlag == 1) then
		FB_ReportToUser("<< FB_UpdateButtonLoc: Button #"..buttonnum.." Update >>"); 
	end
			
	-- Store button
	FB_GetCoords(buttonnum)
end

function FB_RaiseEvent(event, source)
-- raise no events until a profile is loaded.
	FBLastEvent = event
	FBLastSource = source

	if not FBProfileLoaded then return end

-- Respond to events raised throughout the code.
-- Source is the originator of the event
	if (FB_DebugFlag == 3) then
		util:Print(event)
		util:Print(source)
	end

	event = string.lower(event)
-- If event is being watched for, process the commands associated with it.
	if FBQuickEventDispatch[event] then 
		local qd = FBQuickEventDispatch[event]
		if type(source) == "string" then source = string.lower(source) end
		local index, cur_event
		for index, cur_event in ipairs(qd) do
			if 	not source or not cur_event["target"] or
				FB_InTable(source, cur_event["target"]) then
				FBEventArgs = cur_event["args"]
				local dispatch = FBcmd.CommandList[cur_event["command"]]
				dispatch("")
				FBEventArgs = nil
			end
		end
	end
-- Dispatch to extended handlers

	local handlers = FBExtHandlers[string.upper(event)]
	if handlers then
		local index, dispatch
		for index, dispatch in pairs(handlers) do
			dispatch(event, source)
		end
	end

end

-- Group utility functions
function FB_CheckGroups()
-- Check for mouse entering/leaving groups
	local group, value, list
	list = FBEventToggleInfo["boundcheck"][FBEventToggles["boundcheck"].."list"]
	if not list then return end	
	local x,y = GetCursorPosition()
	x = x / UIParent:GetScale()
	y = y / UIParent:GetScale()
	if abs(x-FBCursorLoc.x) < 1 and abs(y-FBCursorLoc.y) < 1 then return end
	for group, value in pairs(list) do
		if 	FB_InGroupBounds(group, x, y) and
			not FB_InGroupBounds(group, FBCursorLoc.x, FBCursorLoc.y) then
			FB_RaiseEvent("MouseEnterGroup", group)
		end
		if 	not FB_InGroupBounds(group, x, y) and
			FB_InGroupBounds(group, FBCursorLoc.x, FBCursorLoc.y) then
			FB_RaiseEvent("MouseLeaveGroup", group)
		end
	end
	FBCursorLoc.x = x
	FBCursorLoc.y = y
end

function FB_InGroupBounds(group, x, y)
-- Check to see if x,y is inside group
	local button, frame = FB_GetWidgets(group)
	local dim = 36 * button:GetScale()
	if 	x < FBState[FBGroupData[group]["left"]]["xcoord"] - 1 or
		x > FBState[FBGroupData[group]["right"]]["xcoord"] + dim or
		y < FBState[FBGroupData[group]["bottom"]]["ycoord"] - dim or
		y > FBState[FBGroupData[group]["top"]]["ycoord"] + 1 then
		return false
	else
		return true
	end
end

function FB_GetBoundingButtons(group)
-- Return a table with the bounding buttons of a group, to
-- speed up in bounds checks.
	local	members = FB_GetGroupMembers(group)
	local 	index
	local 	bounds = {}
	local 	button1=members[1]
	bounds["top"] = button1
	bounds["bottom"] = button1
	bounds["left"] = button1
	bounds["right"] = button1

	for index = 1, members.n do
		if FBState[members[index]]["xcoord"] > FBState[bounds["right"]]["xcoord"] then
			bounds["right"] = members[index]
		end
		if FBState[members[index]]["xcoord"] < FBState[bounds["left"]]["xcoord"] then
			bounds["left"] = members[index]
		end
		if FBState[members[index]]["ycoord"] > FBState[bounds["top"]]["ycoord"] then
			bounds["top"] = members[index]
		end
		if FBState[members[index]]["ycoord"] < FBState[bounds["bottom"]]["ycoord"] then
			bounds["bottom"] = members[index]
		end
	end
	return bounds
end

function FB_GetGroupMembers(group)
-- returns a table with all the members in <group>
	local 	members = {}
	members.n = 0
	local 	index
	for index = 1, FBNumButtons do
		if FBState[index]["group"] == group then
			members.n = members.n + 1
			members[members.n] = index
		end
	end
	return members
end

function FB_VerticalGroup(group, width, padding)
-- Arranges buttons in group vertically, width columns wide with
-- the specified padding between them.
	local members = FB_GetGroupMembers(group)
	if members.n < 1 then return end
	local dim = padding + (38 * (FBState[members[1]]["scale"] or 1))
	local index = 1
	while index <= members.n do
		local index2
		for index2 = 1, width do
			if index <= members.n then
				FB_MoveButtonABS(members[index], 300 + ((index2-1)*dim), 500-(floor((index-1)/width)*dim))
			end
			index = index+1
		end
	end
	FB_ReformGroup(group)
end
			
function FB_HorizontalGroup(group, height, padding)
-- Arranges buttons in group horizontally, height rows high with
-- the specified padding between them.
	local members = FB_GetGroupMembers(group)
	if members.n < 1 then return end
	local dim = padding + (38 * (FBState[members[1]]["scale"] or 1))
	local index = 1
	while index <= members.n do
		local index2
		for index2 = 1, height do
			if index <= members.n then
				FB_MoveButtonABS(members[index], 300+(floor((index-1)/height)*dim), 500-((index2-1)*dim))
			end
			index = index+1
		end
	end
	FB_ReformGroup(group)
end
			
function FB_CircularGroup(group, padding)
-- Arranges group buttons in a circle with the specified padding between them.
-- Starts at 10 O'clock and moves clockwise, with the 7th in the center.   
--       0
--     0   0
--       0 
--     0   0
--       0
-- Max buttons for this is 7
	local coords = {{-1,.5},{0,1},{1,.5},{1,-.5},{0,-1},{-1,-.5},{0,0}}
	local members = FB_GetGroupMembers(group)
	if members.n < 1 or members.n > 7 then return end
	local dim = padding + (38 * (FBState[members[1]]["scale"] or 1))
	for index = 1, members.n do
		FB_MoveButtonABS(members[index], 300+(coords[index][1]*dim), 300+(coords[index][2]*dim))
	end

	FB_ReformGroup(group)
end
			
	
-- Button utility functions
	
function FB_GetWidgets(buttonnum)
-- returns the button and frame (handle) associated with buttonnum
	local	button	= getglobal("FlexBarButton" .. buttonnum)
	local	frame	= getglobal("FlexFrame" .. buttonnum)
	return button, frame
end

function FB_GetButtonNum(frame)
-- takes either a button or handle (frame) and returns the button number
	local firsti, lasti, num = string.find(frame:GetName(), "(%d+)")
	return num+0
end

function FB_GetCoords(buttonnum)
	local button, frame = FB_GetWidgets(buttonnum)
-- Save the coordinates of the handle - On programmatically moved buttons,
-- WoW won't do it automatically for us across sessions.
	local x = frame:GetRight()
	local y = frame:GetBottom()
	local oldX = FBState[buttonnum]["xcoord"]
	local oldY = FBState[buttonnum]["ycoord"]
	FBState[buttonnum]["xcoord"] = x
	FBState[buttonnum]["ycoord"] = y
	FBSavedProfile[FBProfileName][buttonnum].State["xcoord"] = x
	FBSavedProfile[FBProfileName][buttonnum].State["ycoord"] = y

	FB_UpdateSmartPet(buttonnum)
	
	if(FB_DebugFlag == 2) then
		if ( oldX and oldY ) then
		    if (oldX ~= x) or (oldY ~= y) then
				FB_ReportToUser("<< FB_GetCoords: Moved Button #"..buttonnum.." from ("..oldX..", "..oldY..") to ("..x..","..y..") >>"); 
			else
				FB_ReportToUser("<< FB_GetCoords: ReSet Button #"..buttonnum.." to ("..x..","..y..") >>"); 
			end
		else
			FB_ReportToUser("<< FB_GetCoords: Set Button #"..buttonnum.." to ("..x..","..y..") >>"); 
		end
	end
	FBSavedProfile[FBProfileName][buttonnum].State["ycoord"] = frame:GetBottom()
end

function FB_SaveState(buttonnum)
	local button, frame = FB_GetWidgets(buttonnum)
-- Save the current button state to the current character's profile.
	if FBSavedProfile[FBProfileName] == nil then
		FBSavedProfile[FBProfileName] = {}
	end
	FBSavedProfile[FBProfileName][buttonnum].State = util:TableCopy(FBState[buttonnum])
end

function FB_LoadState(buttonnum)
	local button, frame = FB_GetWidgets(buttonnum)
	
	-- load the current button state from the current character's profile.
	if FBSavedProfile[FBProfileName] == nil then
		return
	end
	if not FBSavedProfile[FBProfileName][buttonnum] then
		FBSavedProfile[FBProfileName][buttonnum] = {}
		FBSavedProfile[FBProfileName][buttonnum].State = {}
		FBSavedProfile[FBProfileName][buttonnum].State["hidden"] = "true"
	end
	FBState[buttonnum] = util:TableCopy(FBSavedProfile[FBProfileName][buttonnum].State)
	FBState[buttonnum]["oldid"] = button:GetID()
	FBIDtoButtonNum[button:GetID()] = buttonnum
	
	-- Move button to its saved location
	if FBState[buttonnum]["xcoord"] and FBState[buttonnum]["ycoord"] then
		local x = FBState[buttonnum]["xcoord"]
		local y = FBState[buttonnum]["ycoord"]

		if(FB_DebugFlag == 1) then
			FB_ReportToUser("<< FB_LoadState: B-"..buttonnum.." to ("..x..","..y..") >>"); 
		end
		
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMLEFT", x, y)
	end
end

function FB_MoveButtonABS(button1, x, y)
-- Moves the button and handle so the top left of the button and bottom right of the
-- frame are x pixels to the right of the bottom right corner and y pixels above it.
-- will work with either a button or handle passed to it.
	local button, frame = FB_GetWidgets(button1)
	frame:ClearAllPoints()
	frame:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMLEFT", x, y)

	FB_UpdateButtonLoc(button1)
end

function FB_MoveButtonRel(button1, button2, dx, dy)
-- Moves button1's top left point (bottom right of handle) x pixels to the left of
-- and y pixels above button2's top left point (bottom right of it's handle)
-- Leaves button anchored on UIParent.
	local x = FBState[button2]["xcoord"] + dx
	local y = FBState[button2]["ycoord"] + dy
	local button, frame = FB_GetWidgets(button1)
	frame:ClearAllPoints()
	frame:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMLEFT", x, y)
	
	FB_UpdateButtonLoc(button1)
end

function FB_LockButton(buttonnum)
	local button, frame = FB_GetWidgets(buttonnum)
-- Lock the button by shrinking the handle underneath the
-- corner of the button.
	if frame:GetHeight() == 1 then return end -- is already locked
	-- If it's user placed, the relative points change.  Reset it so we know that
	-- it is set with it's bottom-right corner relative to the UIParent's bottom left.
	if frame:IsUserPlaced() then
		local x = frame:GetRight()
		local y = frame:GetBottom()
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMLEFT", x, y)
	end
	frame:SetHeight(1)
	frame:SetWidth(1)
end

function FB_UnlockButton(buttonnum)
	local button, frame = FB_GetWidgets(buttonnum)
-- unlock button by enlarging the handle to normal size.
	if frame:GetHeight() == 10 then return end -- is already unlocked
	-- If it's user placed, the relative points change.  Reset it so we know that
	-- it is set with it's bottom-right corner relative to the UIParent's bottom left.
	-- While I can't see how a button could be user placed if it's already locked,
	-- better safe than sorry.
	if frame:IsUserPlaced() then
		local x = frame:GetRight()
		local y = frame:GetBottom()
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMLEFT", x, y)
	end
	frame:SetHeight(10)
	frame:SetWidth(10)
end

-- Functions called by timers to check status of a variety of things and raise the appropriate events
function FB_ItemEnchantEvents()
-- check for item enchantments
	local 	hasMainHandEnchant, mainHandExpiration, mainHandCharges,
			hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo() 

	if hasMainHandEnchant and not FBItemEnchants["mainhand"] then
		FB_MoneyToggle();	
		FlexBarTooltip:SetInventoryItem("player",16)
		local i = 6
		local text = getglobal("FlexBarTooltipTextLeft"..i)
		while text and text:IsVisible() and text:GetText() ~= nil do
			if text and text:GetText() and strfind(text:GetText(),"Durability") then break end
			i = i+1
			text = getglobal("FlexBarTooltipTextLeft"..i)
		end
		local i = i - 1
		local text = getglobal("FlexBarTooltipTextLeft"..i)
		local name = text:GetText()
		name = string.gsub(name," %(%d+ %a+%)","")
		FBItemEnchants["mainhand"] = string.lower(name)
		FBItemEnchants["mainhandcharges"] = mainHandCharges
		FB_RaiseEvent("GainItemBuff",name)
		FBBuffs["itembuffs"]["'"..name.."'"] = true
		FB_MoneyToggle();	
	end
	if not hasMainHandEnchant and FBItemEnchants["mainhand"] then
		FB_RaiseEvent("LoseItemBuff",FBItemEnchants["mainhand"])
		FBItemEnchants["mainhand"] = nil
		FBItemEnchants["mainhandcharges"] = nil
		FBItemEnchants["mainhandtimeleft"] = nil
	end
	if hasoffHandEnchant and not FBItemEnchants["offhand"] then
		FB_MoneyToggle();
    FlexBarTooltip:SetOwner(UIParent, "ANCHOR_NONE");
		FlexBarTooltip:SetInventoryItem("player",17)
		local i = 6
		local text = getglobal("FlexBarTooltipTextLeft"..i)
		while text and text:IsVisible() and text:GetText() ~= nil do
			if text and text:GetText() and strfind(text:GetText(),"Durability") then break end
			i = i+1
			text = getglobal("FlexBarTooltipTextLeft"..i)
		end
		local i = i - 1
		local text = getglobal("FlexBarTooltipTextLeft"..i)
		local name = text:GetText()
		name = string.gsub(name," %(%d+ %a+%)","")
		FBItemEnchants["offhand"] = string.lower(name)
		FBItemEnchants["offhandcharges"] = offHandCharges
		FB_RaiseEvent("GainItemBuff",name)
		FBBuffs["itembuffs"]["'"..name.."'"] = true
		FB_MoneyToggle();	
	end
	if not hasoffHandEnchant and FBItemEnchants["offhand"] then
		FB_RaiseEvent("LoseItemBuff",FBItemEnchants["offhand"])
		FBItemEnchants["offhand"] = nil
		FBItemEnchants["offhandcharges"] = nil
		FBItemEnchants["offhandtimeleft"] = nil
	end
	if mainHandCharges ~= FBItemEnchants["mainhandcharges"] then
		FB_RaiseEvent("MainHandCharges",mainHandCharges)
	end
	if offHandCharges ~= FBItemEnchants["offhandcharges"] then
		FB_RaiseEvent("OffHandCharges",offHandCharges)
	end
	FBItemEnchants["mainhandcharges"] = mainHandCharges
	FBItemEnchants["offhandcharges"] = offHandCharges
	if mainHandExpiration then
		FBItemEnchants["mainhandtimeleft"] = mainHandExpiration - GetTime()
	else
		FBItemEnchants["mainhandtimeleft"] = 0
	end
	if offHandExpiration then
		FBItemEnchants["offhandtimeleft"] = offHandExpiration - GetTime()
	else
		FBItemEnchants["offhandtimeleft"] = 0
	end
end

function FB_DeathEvents()
-- check for unit being dead or a ghost
	local index, value, list
	list = FBEventToggleInfo["deathcheck"][FBEventToggles["deathcheck"] .."list"]
	if not list then return end
	for index, value in pairs(list) do
		if UnitExists(index) then
			if FBUnitStatus[index] ~= "dead" and UnitIsDeadOrGhost(index) then
				FB_RaiseEvent("UnitDied",index)
				FBUnitStatus[index] = "dead"
				if index == "player" then
					FBSavedProfile[FBProfileName].Buffs = {}
				end
			end
			if FBUnitStatus[index] == "dead" and not UnitIsDeadOrGhost(index) then
				FB_RaiseEvent("UnitRessed",index)
				FBUnitStatus[index] = "alive"
			end
		end
	end
end

function FB_CombatEvents()
-- check for unit "affecting combat"  New to 1300
	local index, value, list
	list = FBEventToggleInfo["affectcombat"][FBEventToggles["affectcombat"] .."list"]
	if not list then return end
	for index, value in pairs(list) do
		if UnitExists(index) then
			if FBUnitCombat[index] and not UnitAffectingCombat(index) then
				FB_RaiseEvent("EndCombat",index)
				FBUnitCombat[index] = nil
			end
			if not FBUnitCombat[index] and UnitAffectingCombat(index) then
				FB_RaiseEvent("StartCombat",index)
				FBUnitCombat[index] = true
			end
		end
	end
end

function FB_CheckPets(pet)
	if UnitExists(pet) then -- gained a pet
		if 	FBEventToggles["petcheck"] == "high" or FBEventToggleInfo["petcheck"]["lowlist"][pet] then
			FB_RaiseEvent("PetSummoned",pet)
		end
		if pet == "pet" then  -- legacy gainpet for player only - incudes type for warlocks
			FB_RaiseEvent("GainPet",UnitCreatureFamily("pet"))
			table.insert(FBPetTypes,UnitCreatureFamily("pet"))
		end
	else	
		if 	FBEventToggles["petcheck"] == "high" or FBEventToggleInfo["petcheck"]["lowlist"][pet] then
			FB_RaiseEvent("PetDismissed",pet)
		end
		if pet == "pet" then -- legacy losepet for player only
			FB_RaiseEvent("LosePet")
		end
	end
end

function FB_PetEvents()
-- Called every .5 seconds to check for a change in pet status
	local petname = UnitName("pet")
	if petname and not FBPetname then
		FB_RaiseEvent("GainPet","petname")
	end
	if not petname and FBPetname then
		FB_RaiseEvent("LosePet")
	end
	
	FBPetname = petname
end

local allpartyunits = {"player","pet"}
local index
for index = 1,4 do
	table.insert(allpartyunits,"party"..index)
	table.insert(allpartyunits,"partypet"..index)
end

local allraidunits = {}
for index = 1,40 do
	table.insert(allraidunits,"raid"..index)
	table.insert(allraidunits,"raidpet"..index)
end

function FB_TargetTargetEvents()
-- Called every .1 seconds to check for a target of your target and whether it's one of:
-- player, pet, party1-party4, partypet1-partypet4 or the name of the unit.
	-- Timer will only run while we have a target, but check for existence of targettarget
	if not UnitExists("targettarget") then
		if FBLastTargetTarget then
			FB_RaiseEvent("targetlosttarget")
			FBLastTargetTarget = nil
			FBLastTargetTargetName = nil
		end
		return 
	end
	
	local unit
	if UnitInParty("targettarget") then
		-- unit in party
		for i,v in ipairs(allpartyunits) do
			if UnitIsUnit("targettarget",v) then
				unit = v
				break
			end
		end
	end
	
	-- otherwise get unit type (hostile/neutral/friendly pc/npc)
	if not unit then
		local pctype
		if UnitIsPlayer("targettarget") then
			pctype = "pc"
		else
			pctype = "npc"
		end
		if UnitIsEnemy("targettarget","player") then
			unit = "hostile" .. pctype
		elseif UnitIsFriend("targettarget","player") then
			unit = "friendly" .. pctype
		else
			unit = "neutral" .. pctype
		end
	end
	
	-- if it's a friendly pc and the event toggle is set to high check for it being a raid member.
	if unit == "friendlypc" and FBEventToggles["targetcheck"] == "high" then
		for i,v in ipairs(allraidunits) do
			if UnitIsUnit("targettarget",v) then
				unit = v
				break
			end
		end
	end
	
	if FBLastTargetTarget ~= unit then
		if not FBLastTargetTarget then
			FB_RaiseEvent("targetgaintarget",unit)
		elseif FBLastTargetTarget ~= unit or FBLastTargetTargetName ~= UnitName("targettarget") then
			FB_RaiseEvent("targetchangedtarget",unit)
		end
	end
	
	FBLastTargetTarget = unit
	FBLastTargetTargetName = UnitName("targettarget")
end

function FB_UsableEvents()
-- usable events.
	local index, value, list
	list = FBEventToggleInfo["usablecheck"][FBEventToggles["usablecheck"].."list"]
	if not list then return end
	for index, value in pairs(list) do
		local button, frame = FB_GetWidgets(index)
		if HasAction(button:GetID()) then
			local isUsable, notEnoughMana = IsUsableAction(button:GetID());
			if FBState[index]["isUsable"] and not isUsable then
				FB_RaiseEvent("NotUsable", FB_GetButtonNum(button))
			end
			if not FBState[index]["isUsable"] and isUsable then
				FB_RaiseEvent("IsUsable", FB_GetButtonNum(button))
			end
			FBState[index]["isUsable"] = isUsable
		end
	end
end

function FB_ManaEvents()
-- mana events.
	local index, value, list
	list = FBEventToggleInfo["manacheck"][FBEventToggles["manacheck"].."list"]
	if not list then return end
	for index, value in pairs(list) do
		local button, frame = FB_GetWidgets(index)
		if HasAction(button:GetID()) then
			local isUsable, notEnoughMana = IsUsableAction(button:GetID());
			if FBState[index]["notEnoughMana"] and not notEnoughMana then
				FB_RaiseEvent("EnoughMana", FB_GetButtonNum(button))
			end
			if not FBState[index]["notEnoughMana"] and notEnoughMana then
				FB_RaiseEvent("NotEnoughMana", FB_GetButtonNum(button))
			end

			FBState[index]["notEnoughMana"]=notEnoughMana
		end
	end
end

function FB_RangeEvents()
-- Range events.
	local index, value, list
	list = FBEventToggleInfo["rangecheck"][FBEventToggles["rangecheck"].."list"]
	if not list then return end
	for index, value in pairs(list) do
		local button, frame = FB_GetWidgets(index)
		if HasAction(button:GetID()) then
			local inRange = IsActionInRange(button:GetID());
			if FBState[index]["inRange"] ~= 0 and inRange == 0 then
				FB_RaiseEvent("OutOfRange", index)
			end
			if FBState[index]["inRange"] == 0 and inRange ~= 0 then
				FB_RaiseEvent("NowInRange", index)
			end
			FBState[index]["inRange"] = inRange
		end
	end
end

function FB_CooldownEvents()
-- raise cooldown events	
	local index, value, list
	list = FBEventToggleInfo["cooldowncheck"][FBEventToggles["cooldowncheck"].."list"]
	if not list then return end
	for index, value in pairs(list) do
		local button, frame = FB_GetWidgets(index)
		if HasAction(button:GetID()) then
			local start, duration, enable = GetActionCooldown(button:GetID())
			if FBState[index]["start"] == nil then FBState["start"] = 0 end
			if start == 0 and FBState[index]["start"] ~= 0 then
				FB_RaiseEvent("CoolDownMet", index)
			end
			if start ~= 0 and FBState[index]["start"] == 0 then
				FB_RaiseEvent("CoolDownStart", index)
			end
			FBState[index]["start"] = start
		end
	end
end	

function FB_KeyEvents()
-- raise modifier key down/up events	
	if IsShiftKeyDown() and not FBKeyStates["shift"] then
		FB_RaiseEvent("ShiftKeyDown")
	end
	if not IsShiftKeyDown() and FBKeyStates["shift"] then
		FB_RaiseEvent("ShiftKeyUp")
	end
	FBKeyStates["shift"] = IsShiftKeyDown()
	if IsAltKeyDown() and not FBKeyStates["alt"] then
		FB_RaiseEvent("AltKeyDown")
	end
	if not IsAltKeyDown() and FBKeyStates["alt"] then
		FB_RaiseEvent("AltKeyUp")
	end
	FBKeyStates["alt"] = IsAltKeyDown()
	if IsControlKeyDown() and not FBKeyStates["control"] then
		FB_RaiseEvent("ControlKeyDown")
	end
	if not IsControlKeyDown() and FBKeyStates["control"] then
		FB_RaiseEvent("ControlKeyUp")
	end
	FBKeyStates["control"] = IsControlKeyDown()

end	

-- General Utility functions

function FB_RegisterEvent(event, name, callback, wowevent)
-- Register a handler for an event
-- all names will be upper case
-- WoW events and FB events are in the same table
	if wowevent then
		FlexBar:RegisterEvent(event)
	end
	if not FBExtHandlers[string.upper(event)] then
		FBExtHandlers[string.upper(event)] = {}
	end

	FBExtHandlers[string.upper(event)][string.lower(name)] = callback
end

function FB_UnregisterEvent(event, name)
-- Un load a handler
	if not FBExtHandlers[string.upper(event)] then return end
	FBExtHandlers[string.upper(event)][string.lower(name)] = nil
end

function FB_Report(msg)
-- little helper function to display feedback of actions to the user.
	if not FBToggles["verbose"] then return end
	util:Print("FB> " .. msg)
end

function FB_ReportToUser(msg)
-- little helper function to display feedback of actions to the user - reguardless of configuration.
	util:Print(msg)
end

function FB_LoadProfile()

	if(FB_DebugFlag == 1) then
		FB_ReportToUser("<< FB_LoadProfile Entry >>"); 
	end

	-- Load the current character's profile back into the buttons.
	if 	(UnitName("player") == nil) or
		(string.lower(UnitName("player")) == "unknown entity") or 
		UnitName("player") == UNKNOWNBEING or
		UnitName("player") == UNKNOWNOBJECT then
		FBTimers["loadprofile"] = Timer_Class:New(1, nil, 
			".... loading", nil, FB_LoadProfile)
		return
	end

	FBCharName = UnitName("player")
	FBProfileName = FBCharName .. " of " .. GetCVar("RealmName")

	local index
	if FBSavedProfile[FBProfileName] == nil then
		if FBSavedProfile[FBCharName] ~= nil then
			util:Print("Updating to per-server/character saved profiles")
			util:Print("Copying profile for " .. FBCharName .. " to " .. FBProfileName)
			FBSavedProfile[FBProfileName] = util:TableCopy(FBSavedProfile[FBCharName])
		else
			util:Print("No profile for " .. FBProfileName .." found, creating a new one")
			FBSavedProfile[FBProfileName] = {}
			for index = 1, FBNumButtons do
				FBSavedProfile[FBProfileName][index] = {}
				FBSavedProfile[FBProfileName][index].State = {}
				FBSavedProfile[FBProfileName][index].State["hidden"] = true
			end
			FBSavedProfile[FBProfileName].Events = {}
			FBSavedProfile[FBProfileName].Events.n = 0
		end
	end
	
	for index = 1, FBNumButtons do
		FB_LoadState(index)
	end
	
	if FBSavedProfile[FBProfileName].Buffs == nil then
		FBSavedProfile[FBProfileName].Buffs = {}
	end
	
	if FBSavedProfile[FBProfileName].EventToggles == nil then
		FBSavedProfile[FBProfileName].EventToggles = {}
		local index,value
		for index,value in pairs(FBEventToggleInfo) do
			FBSavedProfile[FBProfileName].EventToggles[index] = value["toggle"]
		end
	else
		local index,value
		for index,value in pairs(FBEventToggleInfo) do
			if FBSavedProfile[FBProfileName].EventToggles[index] == nil then
				FBSavedProfile[FBProfileName].EventToggles[index] = value["toggle"]
			end
		end
	end
	
	if FBSavedProfile[FBProfileName].FlexActions == nil then
		FBSavedProfile[FBProfileName].FlexActions = {}
	end
	
	
	FBEventToggles = FBSavedProfile[FBProfileName].EventToggles
	FBEventToggleInfo["boundcheck"]["highlist"] = FBGroupData
	FBProfileLoaded=true;
	FBEvents = util:TableCopy(FBSavedProfile[FBProfileName].Events)
	FB_CreateQuickDispatch()
	
	-- Add ReformAllGroups call to properly setup all groups and buttons.
	FB_ReformAllGroups()
	
	-- Using FlexBar's scale to see if the buttons need rescaling
	FlexBar:SetScale(.25)
	
	util:Echo("Flex Bar settings for " .. FBProfileName .. " loaded")
	
	-- Start Resync timer - just used to check for an overall UI scale change. If scale has gotten changed for some
	-- reason, it will reload the profile.
	FBTimers["resync"] = Timer_Class:New(5, true, nil, nil, FB_ResyncSettings)
	
	-- set a recurring timers to check for the variety of events that don't necessarily have real
	-- WoW events (some of these do, but was just easier to copy/paste the timer code.  A liittle
	-- sloppy, but the extra overhead for group checking is minimal, and for form checking not only
	-- minimal but well worth it to get fades that normally don't get reported in UNIT_LOSE_AURA)
	FBTimers["boundcheck"] = 	Timer_Class:New(.1,  true, nil, nil, FB_CheckGroups)
	FBTimers["cooldowncheck"] =	Timer_Class:New(1,   true, nil, nil, FB_CooldownEvents)
	FBTimers["manacheck"] = 	Timer_Class:New(1,   true, nil, nil, FB_ManaEvents)
	FBTimers["usablecheck"] = 	Timer_Class:New(.5,  true, nil, nil, FB_UsableEvents)
	FBTimers["rangecheck"] = 	Timer_Class:New(.25, true, nil, nil, FB_RangeEvents)
	FBTimers["targettarget"] = 	Timer_Class:New(.1,  true, nil, nil, FB_TargetTargetEvents)
	FBTimers["deathcheck"] = 	Timer_Class:New(.5,  true, nil, nil, FB_DeathEvents)
	FBTimers["keycheck"] = 		Timer_Class:New(.1,  true, nil, nil, FB_KeyEvents)
	FBTimers["affectcombat"] =	Timer_Class:New(.25, true, nil, nil, FB_CombatEvents)
	FBTimers["itembuffs"] 	=	Timer_Class:New(.33, true, nil, nil, FB_ItemEnchantEvents)
	-- FB_GetSpellInfo()
	FB_RestoreScripts()
	FB_CheckAutoItems()
	FB_Set_PerformanceOptions()
	FB_RaiseEvent("ProfileLoaded",FBProfileName)
	-- pre-load buffs
	FB_CheckAllBuffs("player")
	FB_GeneratePetIDList()
	FB_MimicPetButtons()
end

function FB_RestoreScripts()
-- function to rebuild scripts > 1024 characters long
	local name, script, index, value
	for name, script in pairs(FBTextChunks) do
		FBScripts[name] = ""
		for index,value in ipairs(script) do
			FBScripts[name] = FBScripts[name] .. value
		end
	end
end

function FB_GetButtonList(list)
-- regularize arguments to functions that take button lists
-- returns a list of buttons to be affected as a list, with the
-- number of buttons in list.n
	local 	return_value = {}
	return_value.n = 0
	if list == nil then
		return return_value		
	elseif type(list) == "number" then
		return_value[1]=list
		return_value.n = 1
		return return_value
	elseif type(list) == "table" then
		local index
		list.n = 0
		for index in ipairs(list) do
			list.n = list.n+1
		end
		return_value=list
		return return_value
	else
		util:Print("Nil passed to FB_GetButtonList - report this")
	end
end

function FB_DisplayScripts()
	local scripts = {}
	local ind, value
	for ind, value in pairs(FBScripts) do
		table.insert(scripts, ind)
	end
	table.sort(scripts, function(v1,v2) return string.lower(v1) < string.lower(v2) end)

	local count, index, val
	local scriptnames = {}
	count=0
	for index,val in pairs(scripts) do
		count=count+1
		scriptnames[count]=val
	end
	
	if FBScriptCount > count - 16 then FBScriptCount = count - 14 end
	if FBScriptCount < 1 then FBScriptCount = 1 end
	
	for index = 0,15 do
		local button=getglobal("FBScriptsMenu"..index)
		if scriptnames[index+FBScriptCount] then
			button:SetText(scriptnames[index+FBScriptCount])
		else
			button:SetText("")
		end
	end
end

function FB_CastSpellByName(spellname)
-- function to replace CastSpellByName
	CastSpellByName(spellname)
	return
	
	--[[
	if FBPlayerSpells[spellname] then
		CastSpell(FBPlayerSpells[spellname],1)
	elseif FBPlayerMaxRank[spellname] then
		CastSpell(FBPlayerMaxRank[spellname],1)
	elseif FBPetSpells[spellname] then
		CastSpell(FBPetSpells[spellname],BOOKTYPE_PET)
	elseif FBPetMaxRank[spellname] then
		CastSpell(FBPetMaxRank[spellname],BOOKTYPE_PET)
	else
		util:Echo("ERROR: Attempt to cast non-existent spell","red")
	end ]]
end

function FBCastcmd:Dispatch(msg)
-- implement my castspellbyname as a slash command for macros
	CastSpellByName(msg)
end

function FBDoIncmd:Dispatch(msg)
-- implement my in as a slash command
	local firsti, lasti, seconds = string.find(msg,"^(%d+)%s+")
	if not firsti then return end
	FBcmd:Dispatch("runmacro macro='"..string.sub(msg,lasti+1).."' in=".. seconds)
end

function FBUsecmd:Dispatch(msg)
-- implement my usebyname as a slash command for macros
	FB_UseByName(msg)
end

function FBEchocmd:Dispatch(msg)
-- implement echo as a slash command for macros
	local _,_,capture = string.find(msg,"#(%w+)")
	local color = "white"
	if capture and Utility_Class.ColorList[string.lower(capture)] then
		msg = string.gsub(msg,"#"..capture.."%s*","")
		color = string.lower(capture)
	end
	local variable
	for variable in string.gfind(msg,"(%%%w+)") do
		if FBTextSubstitutions[string.lower(variable)] then
			msg = string.gsub(msg, "%"..variable, FBTextSubstitutions[string.lower(variable)]())
		end
	end
	for variable in string.gfind(msg,"$([%w%p]+)$") do
		RunScript("FBMacroValue="..variable)
		variable = string.gsub(variable,"([%(%)%.%%%+%-%*%?%[%]%^%$])","%%%1")
		msg = string.gsub(msg,"$"..variable.."$",tostring(FBMacroValue))
	end
	util:Echo(msg,color)
end

function FBPrintcmd:Dispatch(msg)
-- implement echo as a slash command for macros
	local _,_,capture = string.find(msg,"#(%w+)")
	local color = "white"
	if capture and Utility_Class.ColorList[string.lower(capture)] then
		msg = string.gsub(msg,"#"..capture.."%s*","")
		color = string.lower(capture)
	end
	local variable
	for variable in string.gfind(msg,"(%%%w+)") do
		if FBTextSubstitutions[string.lower(variable)] then
			msg = string.gsub(msg, "%"..variable, FBTextSubstitutions[string.lower(variable)]())
		end
	end
	for variable in string.gfind(msg,"$([%w%p]+)$") do
		RunScript("FBMacroValue="..variable)
		variable = string.gsub(variable,"([%(%)%.%%%+%-%*%?%[%]%^%$])","%%%1")
		msg = string.gsub(msg,"$"..variable.."$",tostring(FBMacroValue))
	end
	util:Print(msg,color)
end

function FB_GetSpellInfo()
-- Load tables up with spell position by name for a CastSpellByName that works in scripts
	FBPlayerSpells = {}
	FBPlayerMaxRank = {}
	FBPetSpells = {}
	FBPetMaxRank = {}
	local index = 1

	while true do
		local spellname, spellrank = GetSpellName(index,1)
		if not spellname then break end
		if not spellrank then spellrank = "" end
		if not IsSpellPassive(index,1) then
			FBPlayerSpells[spellname.."("..spellrank..")"] = index
			FBPlayerMaxRank[spellname] = index
		end
		index = index+1
	end

	if not HasPetSpells() then return end
	
	local index = 1

	while true do
		local spellname, spellrank = GetSpellName(index,BOOKTYPE_PET)
		if not spellname then break end
		if not spellrank then spellrank = "" end
		FBPetSpells[spellname.."("..spellrank..")"] = index
		FBPetMaxRank[spellname] = index
		index = index+1
	end
end

function FB_InTable(value1, table1)
-- Simple utility function to check for the existence of
-- value1 in table1
	local index, value
	for index,value in pairs(table1) do
		if type(value) == "string" then value=string.lower(value) end
		if value == value1 then
			return true;
		end
	end
	return false
end

function FB_Execute_Command(command)
-- Simple function to execute a string as though it were typed in the chat box
	local variable
	for variable in string.gfind(command,"(%%%w+)") do
		if FBTextSubstitutions[string.lower(variable)] then
			command = string.gsub(command, "%"..variable, FBTextSubstitutions[string.lower(variable)]())
		end
	end
	for variable in string.gfind(command,"%$([%w%p]+)%$") do
		RunScript("FBMacroValue="..variable)
		variable = string.gsub(variable,"([%(%)%.%%%+%-%*%?%[%]%^%$])","%%%1")
		command = string.gsub(command,"%$"..variable.."%$",tostring(FBMacroValue))
	end
	FlexBar_Command_EditBox:SetText(command)
	local editbox = FlexBar_Command_EditBox
	ChatEdit_SendText(editbox)
end

function FB_Execute_ConfigString(config)
-- Execute config contained in a string
	local capture
	FBTestConfig = {}
	config = "\n" .. config .. "\n"
	for capture in string.gfind(config,"([^%\n]+)") do
		if capture ~= "" and not string.find(capture,"%s*%-%-") then 
			table.insert(FBTestConfig, capture) 
		end
	end
	FBcmd:Dispatch("loadconfig config='FBTestConfig'")
end

function FB_Execute_MultilineMacro(macro, macroname)
-- Execute multi-line macro contained in a string
-- Clear FBEventArgs:  When doing a RunMacro off an event, this was causing /FlexBar Commands to not execute
	FBEventArgs = nil
-- Macro is waiting, and someone tried to re-run it.
	if FBMacroWait[macroname] and FBMacroWait[macroname]["time"] > GetTime() then return end
	local skip = 0
	local count = 1
	local capture
	config = "\n" .. macro .. "\n"
	for capture in string.gfind(config,"([^%\n]+)") do
		if (FBMacroWait[macroname] and (count > FBMacroWait[macroname]["line"])) or (not FBMacroWait[macroname])then
			if string.sub(capture,1,3) == "/if" then
				if not FB_CheckConditional(string.sub(capture,4)) then
					skip = 1
				end
			elseif string.sub(capture,1,5) == "/else" then
				if skip == 1 then skip = 0 else skip = 1 end
			elseif string.sub(capture,1,4) == "/end" then
				skip = 0
			elseif string.sub(capture,1,6) == "/break" then
				FBMacroWait[macroname] = nil
				return
			elseif skip == 0 then
				if capture ~= "" then
					local _,_,delay = string.find(string.lower(capture),"/fbwait (%d+)")
					if delay then
						FBMacroWait[macroname] = {}
						FBMacroWait[macroname]["time"] = GetTime() + (delay/10)
						FBMacroWait[macroname]["line"] = count
						FBTimers[macroname .. "wait timer"] = 
							Timer_Class:New((delay/10)+.1,nil,nil,nil,function() FB_Execute_MultilineMacro(macro, macroname) end)
						return
					end
					FB_Execute_Command(capture) 
				end
			end
		end
		count=count+1
	end
	FBMacroWait[macroname] = nil
end

function FB_CheckTextSub()
-- Scan text subs on health, mana, combopoints, scan-inventory or simply 1 time per second for timers
	if (FBButtonInfoShown == true) then return end
	local index
	for index = 1, FBNumButtons do
		FB_TextSub(index)
	end
end

function FB_GetBagLocation(name)
-- find a location with the item named
	local bagnum, slotindex
	if FBBagContents[name] then
		return FBBagContents[name]["bag"],FBBagContents[name]["slot"]
	else
		return nil
	end
end

function FB_UseByName(name)
-- Function to use an item by name 
	local bag, slot = FB_GetBagLocation(name)
	if bag then
		if bag < 5 then
			UseContainerItem(bag,slot)
		else
			UseInventoryItem(slot)
		end
	else
		util:Echo(name .. " not found on your person", "yellow")
	end
end

function FB_PlaceItemOnActionBar(name, id)
-- Function to place an item on the bar by name
	local bag, slot = FB_GetBagLocation(name)
	if bag then
		if bag < 5 then
			PickupContainerItem(bag,slot)
			PlaceAction(id)
		else
			PickupInventoryItem(FB_GetInvLocation(name))
			PlaceAction(id)
		end
	else
		util:Echo(name .. " not found on your person", "yellow")
	end
end

function FB_ScanInventory()
-- creates a table indexed by item name with total count and a location
	local index, value
	for index, value in pairs(FBBagContents) do
		if type(value) == "table" then
			value["count"] = 0
			value["bag"] = nil
			value["slot"] = nil
		end
	end
	local bag, slot
	-- search bags left to right
	for bag = 0,4 do
		if bag == 0 then
			FBBagContents["allbagsnumslots"] = GetContainerNumSlots(bag)
			FBBagContents["backpacknumslots"] = GetContainerNumSlots(bag)
			FBBagContents["allbagsnumslotsleft"] = GetContainerNumSlots(bag)
			FBBagContents["backpacknumslotsleft"] = GetContainerNumSlots(bag)
			FBBagContents["allbagsnumslotsused"] = 0
			FBBagContents["backpacknumslotsused"] = 0
		else
			local name = "bag"..bag
			FBBagContents[name.."numslots"] = GetContainerNumSlots(bag)
			FBBagContents[name.."numslotsleft"] = GetContainerNumSlots(bag)
			FBBagContents[name.."numslotsused"] = 0
			FBBagContents["allbagsnumslots"] = FBBagContents["allbagsnumslots"] + GetContainerNumSlots(bag)
			FBBagContents["allbagsnumslotsleft"] = FBBagContents["allbagsnumslotsleft"] + GetContainerNumSlots(bag)
		end
		for slot = 1,GetContainerNumSlots(bag) do
			local link = GetContainerItemLink(bag, slot)
			local name
			if link then
				_,_,name = string.find(link,"%[([^%[%]]+)%]")
			end
			if name then
				FBBagContents["allbagsnumslotsused"] = FBBagContents["allbagsnumslotsused"] + 1	
				FBBagContents["allbagsnumslotsleft"] = FBBagContents["allbagsnumslotsleft"] - 1
				if bag == 0 then
					FBBagContents["backpacknumslotsused"] = FBBagContents["backpacknumslotsused"] + 1	
					FBBagContents["backpacknumslotsleft"] = FBBagContents["backpacknumslotsleft"] - 1
				else
					FBBagContents["bag"..bag.."numslotsused"] = FBBagContents["bag"..bag.."numslotsused"] + 1	
					FBBagContents["bag"..bag.."numslotsleft"] = FBBagContents["bag"..bag.."numslotsleft"] - 1
				end
				if not FBBagContents[name] then
					FBBagContents[name] = {}
					FBBagContents[name]["bag"] = bag
					FBBagContents[name]["slot"] = slot
					local text,count = GetContainerItemInfo(bag,slot)
					if not count then count = 0 end
					FBBagContents[name]["count"] = count
				else
					local text,count = GetContainerItemInfo(bag,slot)
					FBBagContents[name]["bag"] = bag
					FBBagContents[name]["slot"] = slot
					if not count then count = 0 end
					FBBagContents[name]["count"] = FBBagContents[name]["count"] + count
				end
			end
		end
	end
	bag = 5
	for slot = 1,23 do
		local link = GetInventoryItemLink("player",slot)
		local name
		if link then
			_,_,name = string.find(link,"%[([^%[%]]+)%]")
		end
		if name then
			if not FBBagContents[name] then
				FBBagContents[name] = {}
			end
			FBBagContents[name]["bag"] = bag
			FBBagContents[name]["slot"] = slot
			FBBagContents[name]["count"] = 1
		end
	end
end

function FB_CheckAutoItems()
-- Check to see if an auto item is empty
	if not FBProfileLoaded then return end
	FB_ScanInventory()
	local index,value
	for index,value in pairs(FBSavedProfile[FBProfileName].FlexActions) do
		if value["action"] == "autoitem" and GetActionCount(index) == 0 and value["count"] > 0 then
		-- used last one
			if FBEventToggles["autoitems"] ~= "off" then FB_RaiseEvent("AutoItemOut",value["name"]) end
			value["count"] = 0
		end
		
		if 	value["action"] == "autoitem" and value["count"] == 0 and 
			FBBagContents[value["name"]] and
			FBBagContents[value["name"]]["count"] and
			FBBagContents[value["name"]]["count"] > 0 then
		-- was out, now have some
			FB_PlaceItemOnActionBar(value["name"],index)
			if FBEventToggles["autoitems"] ~= "off" then FB_RaiseEvent("AutoItemRestored",value["name"]) end
			value["count"] = FBBagContents[value["name"]]["count"]
			PutItemInBackpack()  -- just in case it was occupied
		end
		
	end
end

function FB_FlexActionButtonBindingCode(buttonnum, keystate)
-- The code in the xml was out of control, moved to here
	local echonum = FBState[buttonnum]["echo"]
	if ( keystate == "down" ) then
		if not FBState[buttonnum]["disabled"] then
			FlexBarButtonDown(buttonnum);
		end
		if 	FBEventToggles["buttonevents"] ~= "off" then
			FB_RaiseEvent("LeftButtonDown",buttonnum)
			if echonum then
				FB_RaiseEvent("LeftButtonDown",echonum)
			end
		end
	else
		if 	FBEventToggles["buttonevents"] ~= "off" then
			FB_RaiseEvent("LeftButtonUp",buttonnum)
			if echonum then
				FB_RaiseEvent("LeftButtonUp",echonum)
			end
		end
		if not FBState[buttonnum]["disabled"] then
			FlexBarButtonUp(buttonnum);
		end
	end
end

function FB_BindingKeyEvents(source, keystate)
-- Code from FlexBar event bindings
	if 	FBEventToggles["bindingkeyevents"] ~= "off" then
		if ( keystate == "down" ) then
			FB_RaiseEvent("BindingKeyDown", source);
		else
			FB_RaiseEvent("BindingKeyUp", source);
		end
	end
end

function FB_SetCommandTimer(action, args)
-- Put a command on a timer
	if not args["in"] then return nil end
	if args["ttoggle"] and not args["tname"] then
		util:Print("Error: must specify a name for toggle to work")
		return true
	end
	local name = args["tname"] or action .. GetTime()
	local delay = args["in"]/10
	if args["ttoggle"] and FBTimers[name] and FBTimers[name]:GetRunning() then
		FBTimers[name] = nil
		return true
	end
	-- have to allocate more memory for this - no way out that I can see
	local timerargs = util:TableCopy(args)
	timerargs["tname"] = nil
	timerargs["in"] = nil
	timerargs["ttoggle"] = nil
	FBTimers[name] = Timer_Class:New(delay,nil,nil,nil,function() FB_CommandTimerDispatch(action,timerargs) end)
	return true
end

function FB_CommandTimerDispatch(action, args)
	FBEventArgs = args
	local dispatch = FBcmd.CommandList[action]
	dispatch("")
	FBEventArgs = nil
end

function FB_GetEventMsg(action, args)
-- Creates a new table with the parameters needed for RaiseEvent and populates FBEvents.
	local 	event = {}
-- if there is no "ON" directive then return nil
	if args["on"] == nil then  
		return nil 
	else
		event["on"] = args["on"]
	end
-- copy the target over to the event
	if args["target"] and type(args["target"]) == "table" then
		event["target"] = util:TableCopy(args["target"])
	else
		if args["target"] then
			event["target"] = {args["target"]}
		else
			event["target"] = nil
		end
	end
-- Set up the message string to go to Command_Class:Dispatch
	local	msg = action
	local	index, value
	for index, value in pairs(args) do
		if index~= "on" and index~="target" then
			if type(value) ~= "table" then
				if type(value) == "string" then value="'"..value.."'" end
				msg = msg .. " " .. index .. "=" .. value
			else
				msg = msg .. " " .. index .. "=" .. "["
				local index2, value2
				for index2, value2 in ipairs(value) do
					if type(value2) == "string" then value2="'"..value2.."'" end
					msg = msg .. " " .. value2
				end
				msg = msg .. " ]"
			end
		end
	end
-- Copy out the target text for the list events command.
	event["command"]=msg
	local targettext = "Target="
	if args["target"] == nil then
		targettext = targettext .. "No target"
	elseif type(args["target"]) == "string" then
		targettext = targettext .. "'" .. args["target"] .. "'"
	elseif type(args["target"]) == "table" then
		local index2, value2
		targettext=targettext .. "[ "
		for index2, value2 in ipairs(args["target"]) do
			targettext = targettext .. " " .. value2
		end
		targettext = targettext .. " ]"
	else
		targettext = targettext .. args["target"]
	end
	event["targettext"]=targettext

	if FBEvents.n == nil then FBEvents.n = 0 end
	FBEvents.n = FBEvents.n + 1
	FBEvents[FBEvents.n] = util:TableCopy(event)
	FB_Report("On " .. FBEvents[FBEvents.n]["on"] .. " " .. FBEvents[FBEvents.n]["targettext"] .. " : " .. FBEvents[FBEvents.n]["command"])
	FBSavedProfile[FBProfileName].Events = util:TableCopy(FBEvents)
	FB_CreateQuickDispatch()
	return true
end

function FB_CreateQuickDispatch()
-- Creates a quick dispatch table from the linear event table
		
	local index, event
	FBQuickEventDispatch = {}
	for index, event in pairs(FBEventToggleInfo) do
		event["lowlist"] = {}
		if FBToggles["autoperf"] then
			FBEventToggles[index] = "off"
		end
	end
	for index, event in ipairs(FBEvents) do
		local args = FBcmd:GetParameters(event["command"])
		local quickevent = {}
		local eventname = string.lower(event["on"])
		local command
		_,_,command = string.find(event["command"],"(%w+)")
		if FBQuickEventDispatch[eventname] == nil then
			FBQuickEventDispatch[eventname] = {}
		end
		if FBToggles["autoperf"] and string.lower(eventname) ~= "profileloaded" and FBEventGroups[eventname] then
			FBEventToggles[FBEventGroups[eventname]] = "low"
		end
		if event["target"] then 
			quickevent["target"] = util:TableCopy(event["target"])
			local index, target
			for index, target in ipairs(quickevent["target"]) do
				if FBEventGroups[eventname] then
					FBEventToggleInfo[FBEventGroups[eventname]]["lowlist"][target] = true
				end
			end
		end
		quickevent["command"] = command
		quickevent["args"] = util:TableCopy(args)
		table.insert(FBQuickEventDispatch[eventname], quickevent)
	end
end

function FB_MimicPetButtons()
-- Have button duplicate appearance of petbutton
	if not FBProfileLoaded then return end
	for i in pairs(FBPetActions) do
		local button = FB_GetWidgets(i)
		local id = button:GetID()
		
		if 	FBSavedProfile[FBProfileName].FlexActions[id] and
			FBSavedProfile[FBProfileName].FlexActions[id]["action"] == "pet" then
		
			local 	petbuttonID = FBSavedProfile[FBProfileName].FlexActions[id]["id"]
			local 	name, subtext, texture, isToken, 
					isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(petbuttonID)
			local 	buttonnum = FB_GetButtonNum(button)
			
			if not name or name == "" then name = "Empty Pet Button" end
			
			if isToken then
				FBSavedProfile[FBProfileName].FlexActions[id]["texture"] = getglobal( texture )
				FBSavedProfile[FBProfileName].FlexActions[id]["name"] = TEXT(getglobal( name ))
			else
				FBSavedProfile[FBProfileName].FlexActions[id]["texture"] = texture
				FBSavedProfile[FBProfileName].FlexActions[id]["name"] = name
			end
			
			if subtext then 
				FBSavedProfile[FBProfileName].FlexActions[id]["name"] = 
					FBSavedProfile[FBProfileName].FlexActions[id]["name"] .. "\n" .. subtext
			end
			if autoCastAllowed then 
				getglobal(button:GetName() .. "AutoCastable"):Show()
			else
				getglobal(button:GetName() .. "AutoCastable"):Hide()
			end
			
			if autoCastEnabled then 
				getglobal(button:GetName() .. "AutoCast"):Show()
			else
				 getglobal(button:GetName() .. "AutoCast"):Hide()
			end
			
			if isActive then
				button:SetChecked(1)
				FBState[i]["checked"] = true
			else
				button:SetChecked(0)
				FBState[i]["checked"] = nil
			end
			
			if GetPetActionsUsable() then
				SetDesaturation(getglobal(button:GetName() .. "Icon"),nil)
			else
				SetDesaturation(getglobal(button:GetName() .. "Icon"),1)
			end
		end
		FlexBarButton_Update(button)
		FlexBarButton_UpdateCooldown(button)
	end
end

function FB_GeneratePetIDList()
-- generate a table to speed pet button processing
	for i = 1, 120 do
		local button = FB_GetWidgets(i)
		local id = button:GetID()
		if FBSavedProfile[FBProfileName].FlexActions[id] and FBSavedProfile[FBProfileName].FlexActions[id]["action"] == "pet" then
			FBPetActions[i] = true
		else
			FBPetActions[i] = nil
		end
	end
end

function FB_ResetPetItems(button)
	if 	not	(FBSavedProfile[FBProfileName].FlexActions[id] and
			 FBSavedProfile[FBProfileName].FlexActions[id]["action"] == "pet") then
	
		local 	buttonnum = FB_GetButtonNum(button)

		getglobal(button:GetName() .. "AutoCastable"):Hide()
		getglobal(button:GetName() .. "AutoCast"):Hide()
		SetDesaturation(getglobal(button:GetName() .. "Icon"),nil)
		FBState[buttonnum]["checked"] = nil

		FlexBarButton_Update(button)
		FlexBarButton_UpdateCooldown(button)
		FlexBarButton_UpdateState(button)
		
		FBPetActions[buttonnum] = nil
	end
end

local workinglist = {}
workinglist.n = 0
function FB_GetBuffs(target)
-- return a list of the buffs currently on a target
	local index
	for index = 1, workinglist.n do
		table.remove(workinglist,1)
	end
	local count = 1
	FB_MoneyToggle();
  FlexBarTooltip:SetOwner(UIParent, "ANCHOR_NONE");
	while UnitBuff(target,count) do
		FlexBarTooltip:SetUnitBuff(target,count)
		local buffname = string.lower(FlexBarTooltipTextLeft1:GetText())
		table.insert(workinglist,buffname)
		count = count+1
	end
	FB_MoneyToggle();	
	workinglist.n = count
	return workinglist
end

local typelist = {}
function FB_GetDebuffs(target)
-- return a list of the DeBuffs currently on a target, and a list of the types and their count
	local index
	for index = 1, workinglist.n do
		table.remove(workinglist,1)
	end
	for index in pairs(typelist) do
		typelist[index] = nil
	end
	local count = 1
	FB_MoneyToggle();
  FlexBarTooltip:SetOwner(UIParent, "ANCHOR_NONE");
	while UnitDebuff(target,count) do
		FlexBarTooltip:SetUnitDebuff(target,count)
		local buffname = string.lower(FlexBarTooltipTextLeft1:GetText())
		local debufftype = FlexBarTooltipTextRight1:GetText()
		if debufftype then debufftype = string.lower(debufftype) end
		table.insert(workinglist,buffname)
		if debufftype and FlexBarTooltipTextRight1:IsVisible() then
			if typelist[debufftype] then
				typelist[debufftype] = typelist[debufftype] + 1
			else
				typelist[debufftype] = 1
			end
		end
		count = count+1
	end
	FB_MoneyToggle();	
	workinglist.n = count
	return workinglist,typelist
end

--	Keep track of the buffs/debuffs/debufftypes gained/lost for the player
--	Need to raise them after all the information has been updated so if= works correctly

local playerbuffschanged = {}
playerbuffschanged["gainbuff"] = {}
playerbuffschanged["losebuff"] = {}
playerbuffschanged["gaindebuff"] = {}
playerbuffschanged["losedebuff"] = {}
playerbuffschanged["gaindebufftype"] = {}
playerbuffschanged["losedebufftype"] = {}
local unitbuffschanged = {}
unitbuffschanged["gainbuff"] = {}
unitbuffschanged["losebuff"] = {}
unitbuffschanged["gaindebuff"] = {}
unitbuffschanged["losedebuff"] = {}
unitbuffschanged["gaindebufftype"] = {}
unitbuffschanged["losedebufftype"] = {}

function FB_CheckAllBuffs(unit)
-- Scan for new/dropped buffs, debuffs and debuff types on unit
	if not FBProfileLoaded then return end
	if (not UnitName(unit)) then return end

	if FBEventToggles["buffcheck"] == "off" then return end
	if FBEventToggles["buffcheck"] == "low" and not FBEventToggleInfo["buffcheck"]["lowlist"][unit] then return end
	
	if(FB_DebugFlag == 4) then
		FB_ReportToUser("<< FB_CheckAllBuffs: Checking Buffs for "..unit.." >>"); 
	end

	local newbuffs = FB_GetBuffs(unit)
	local buffschanged = false
	local index,value
	for index,value in pairs(playerbuffschanged) do
		while value[1] do
			table.remove(value,1)
		end
	end
	for index,value in pairs(unitbuffschanged) do
		while value[1] do
			table.remove(value,1)
		end
	end
	if not FBLastBuffs["buffs"][unit] then
		FBLastBuffs["buffs"][unit] = {}
	end
	if not FBLastBuffs["debuffs"][unit] then
		FBLastBuffs["debuffs"][unit] = {}
	end
	if not FBLastBuffs["debufftypes"][unit] then
		FBLastBuffs["debufftypes"][unit] = {}
	end
	local index, value
	for index, value in ipairs(newbuffs) do
		if not FBLastBuffs["buffs"][unit][string.lower(value)] then
			-- gained a buff
			FBLastBuffs["buffs"][unit][string.lower(value)] = true
			FBBuffs["buffs"]["'"..value.."'"] = true
			if unit == "player" then
				table.insert(playerbuffschanged["gainbuff"],value)
			else
				buffschanged = true
				table.insert(unitbuffschanged["gainbuff"],value)
			end
		end
	end
	for index,value in pairs(FBLastBuffs["buffs"][unit]) do
		if not FB_InTable(index,newbuffs) then
			-- lost a buff
			FBLastBuffs["buffs"][unit][string.lower(index)] = nil
			if unit == "player" then
				table.insert(playerbuffschanged["losebuff"],index)
			else
				buffschanged = true
				table.insert(unitbuffschanged["losebuff"],index)
			end
		end
	end

	local debuffschanged = false
	local newdebuffs, newafflictions = FB_GetDebuffs(unit)
	if not FBLastBuffs["debuffs"][unit] then
		FBLastBuffs["debuffs"][unit] = {}
	end
	local index, value
	for index, value in ipairs(newdebuffs) do
		if not FBLastBuffs["debuffs"][unit][value] then
			-- gained a debuff
			FBLastBuffs["debuffs"][unit][string.lower(value)] = true
			FBBuffs["debuffs"]["'"..value.."'"] = true
			if unit == "player" then
				table.insert(playerbuffschanged["gaindebuff"],value)
			else
				debuffschanged = true
				table.insert(unitbuffschanged["gaindebuff"],value)
			end
		end
	end
	for index,value in pairs(FBLastBuffs["debuffs"][unit]) do
		if not FB_InTable(index,newdebuffs) then
			-- lost a buff
			FBLastBuffs["debuffs"][unit][string.lower(index)] = nil
			if unit == "player" then
				table.insert(playerbuffschanged["losedebuff"],index)
			else
				debuffschanged = true
				table.insert(unitbuffschanged["losedebuff"],index)
			end
		end
	end

	local afflictionschanged = false
	for index, value in pairs(newafflictions) do
		if 	not FBLastBuffs["debufftypes"][unit][string.lower(index)] or
			value > FBLastBuffs["debufftypes"][unit][string.lower(index)] then
			-- gained a new type of debuff
			FBLastBuffs["debufftypes"][unit][string.lower(index)] = value
			FBBuffs["debufftypes"]["'"..index.."'"] = true
			if unit == "player" then
				table.insert(playerbuffschanged["gaindebufftype"],index)
			else
				afflictionschanged = true
				table.insert(unitbuffschanged["gaindebufftype"],index)
			end
		end
	end
	for index,value in pairs(FBLastBuffs["debufftypes"][unit]) do
		if 	not newafflictions[string.lower(index)] or 
			value > newafflictions[string.lower(index)] then
			-- lost an debuff type
			FBLastBuffs["debufftypes"][unit][string.lower(index)] = newafflictions[string.lower(index)]
			if unit == "player" then
				table.insert(playerbuffschanged["losedebufftype"],index)
			else
				afflictionschanged = true
				table.insert(unitbuffschanged["losedebufftype"],index)
			end
		end
	end

	for index,value in pairs(playerbuffschanged) do
		local i,v
		for i,v in ipairs(value) do
			FB_RaiseEvent(index,v)
		end
	end
	
	if buffschanged == true then
		FB_RaiseEvent("UnitBuff", unit)
	end
	if debuffschanged == true then 
		FB_RaiseEvent("UnitDebuff",unit)
	end
	if afflictionschanged == true then 
		FB_RaiseEvent("UnitDebuffType",unit)
	end
	
	for index,value in pairs(unitbuffschanged) do
		local i,v
		for i,v in ipairs(value) do
			FB_RaiseEvent(unit .. index,v)
		end
	end
end
-- Apply saved states (From FB.State) to the buttons. 
-- Removed group checks - if the user wants an entire
-- group to change, they need to explicitly say so.

function FB_ApplyHidden(buttonnum)
	local button, frame = FB_GetWidgets(buttonnum)
-- Apply hidden state
	if FBState[buttonnum]["hidden"] then
		frame:Hide()
	else
		frame:Show()
	end
end

function FB_ApplyAlpha(buttonnum)
	local button, frame = FB_GetWidgets(buttonnum)
-- Apply alpha
	if FBState[buttonnum]["alpha"] then
		button:SetAlpha(FBState[buttonnum]["alpha"])
	end
end

function FB_ApplyScale(buttonnum)
	local button, frame = FB_GetWidgets(buttonnum)
-- Apply scale
	if FBState[buttonnum]["scale"] then
		button:SetScale(FBState[buttonnum]["scale"])
	else
		button:SetScale(1)
	end
end

function FB_ApplyLocked(buttonnum)
	local button, frame = FB_GetWidgets(buttonnum)
-- Determine whether the button should be locked or not and apply
-- Only the anchor of a group may be locked/unlocked.
	if 	FBState[buttonnum]["group"] and 
		buttonnum ~= FBState[buttonnum]["group"] then 
		return 
	end;
	
	if FBState[buttonnum]["locked"] then
		FB_LockButton(buttonnum)
	else
		FB_UnlockButton(buttonnum)
	end
end

function FB_ApplyRemap(buttonnum)
	local button, frame = FB_GetWidgets(buttonnum)
-- Apply remap 
	if FBState[buttonnum]["remap"] then
		button:SetID(FBState[buttonnum]["remap"])
		FlexBarButton_Update(button)
		FlexBarButton_UpdateState(button)
	else
		button:SetID(FBState[buttonnum]["oldid"])
		FlexBarButton_Update(button)
		FlexBarButton_UpdateState(button)
	end
	
end

function FB_ApplyGrid(buttonnum)
	local button, frame = FB_GetWidgets(buttonnum)
-- Apply grid
	if FBState[buttonnum]["hidegrid"] then
		button.showgrid=0
		frame:DisableDrawLayer()
	else
		button.showgrid=1
		button:Show()
		frame:EnableDrawLayer()
	end
	FlexBarButton_Update(button)
	FlexBarButton_UpdateState(button)
end

function FB_ApplyTextPosition(buttonnum)
	local button, frame = FB_GetWidgets(buttonnum)
	local buttonname = button:GetName()
	local text = getglobal(buttonname.."HotKey")
	local text2 = getglobal(buttonname.."Text2")
	local text3 = getglobal(buttonname.."Text3")
	
	local textpos = FBState[buttonnum]["justifytext"]
	local text2pos = FBState[buttonnum]["justifytext2"]
	local text3pos = FBState[buttonnum]["justifytext3"]
	
	if textpos == nil then textpos = "TOPRIGHT" end
	text:SetJustifyH("CENTER")
	local pos = string.upper(textpos)
	if string.find(pos,"LEFT") then
		text:SetJustifyH("LEFT")
	end
	if string.find(pos,"RIGHT") then
		text:SetJustifyH("RIGHT")
	end
	text:ClearAllPoints()
	text:SetPoint(pos,buttonname,pos,0,0)

	if text2pos == nil then text2pos = "BOTTOMLEFT" end 
	text2:SetJustifyH("CENTER")
	local pos = string.upper(text2pos)
	if string.find(pos,"LEFT") then
		text2:SetJustifyH("LEFT")
	end
	if string.find(pos,"RIGHT") then
		text2:SetJustifyH("RIGHT")
	end
	text2:ClearAllPoints()
	text2:SetPoint(pos,buttonname,pos,0,0)
	
	if text3pos == nil then text3pos = "CENTER" end 
	text3:SetJustifyH("CENTER")
	local pos = string.upper(text3pos)
	if string.find(pos,"LEFT") then
		text3:SetJustifyH("LEFT")
	end
	if string.find(pos,"RIGHT") then
		text3:SetJustifyH("RIGHT")
	end
	text3:ClearAllPoints()
	text3:SetPoint(pos,buttonname,pos,0,0)
	FB_SaveState(buttonnum)
end

-- Toggle Preserve for GameTooltip_ClearMoney functionality
function FB_MoneyToggle()
	if( Save_Original_GameTooltip_ClearMoney ) then
		GameTooltip_ClearMoney = Save_Original_GameTooltip_ClearMoney;
		Save_Original_GameTooltip_ClearMoney = nil;
    FlexBarTooltip:SetOwner(UIParent, "ANCHOR_NONE");
	else
		Save_Original_GameTooltip_ClearMoney = GameTooltip_ClearMoney;
		GameTooltip_ClearMoney = FB_GameTooltip_ClearMoney;
    FlexBarTooltip:SetOwner(UIParent, "ANCHOR_NONE");
	end
end

function FB_GameTooltip_ClearMoney()
	-- Intentionally empty; don't clear money while we use hidden tooltips
end

function FB_StoreGroupOffsetForMove(group)
	-- Stores group button offset values for non-anchor buttons prior to a group anchor move taking
	-- place. This is required in order to ensure all group button locations are properly updated
	-- at the time the group anchor is moved. For programmatical moves it seems that the WoW Update
	-- time for button locations not attached to UIParent in memory varies.
	local index
	local members = FB_GetGroupMembers(group)
	
	if members.n < 1 then return end

	if(FB_DebugFlag == 2) then
		FB_ReportToUser("<< FB_StoreGroupOffsetForMove: Group #"..group.." Store Offsets >>"); 
	end

	local anchor = FBState[members[1]]["group"]
	local aX = FBState[anchor]["xcoord"]
	local aY = FBState[anchor]["ycoord"]
		
	for index = 1, members.n do
		if (members[index] ~= anchor) then
			local oX = FBState[members[index]]["xcoord"] - aX
			local oY = FBState[members[index]]["ycoord"] - aY

			FBGroupMoveOffset[members[index]]["xcoord"] = oX
			FBGroupMoveOffset[members[index]]["ycoord"] = oY

			if(FB_DebugFlag == 2) then
				FB_ReportToUser("<< StoreOffset B# "..members[index].." (oX="..oX..", oY="..oY.."), (aX="..aX..", aY="..aY..") >>");
				--FB_PrintButtonSnapshot(members[index])
			end
		end
	end
end

function FB_RestoreGroupOffsetAfterMove(group)
	-- Resets stored values for non-anchor buttons after a group move command has been executed.
	-- This way we do not have to wait some indeterminate amount of time to get coordinates for the group.
	local index
	local members = FB_GetGroupMembers(group)
	
	if members.n < 1 then return end

	if(FB_DebugFlag == 2) then
		FB_ReportToUser("<< FB_RestoreGroupOffsetAfterMove: Group #"..group.." Restore Offsets >>"); 
	end

	local anchor = FBState[members[1]]["group"]
	local aX = FBState[anchor]["xcoord"]
	local aY = FBState[anchor]["ycoord"]
		
	for index = 1, members.n do
		if (members[index] ~= anchor) then
			local oX = FBGroupMoveOffset[members[index]]["xcoord"]
			local oY = FBGroupMoveOffset[members[index]]["ycoord"]
			
			FBState[members[index]]["xcoord"] = aX + oX
			FBState[members[index]]["ycoord"] = aY + oY
			FBSavedProfile[FBProfileName][members[index]].State["xcoord"] = aX + oX
			FBSavedProfile[FBProfileName][members[index]].State["ycoord"] = aY + oY

			FB_UpdateSmartPet(members[index])
			
			if(FB_DebugFlag == 2) then
				FB_ReportToUser("<< RestOffset B# "..members[index].." (oX="..oX..", oY="..oY.."), (aX="..aX..", aY="..aY..") >>");
				--FB_PrintButtonSnapshot(members[index])
			end
		end
	end
end

function FB_SetDebugLevel(val)
	util:Print("<< FB_SetDebugLevel: Debug Level changed to: "..val.." >>", "red"); 
	FB_DebugFlag = val
end

function FB_ShowButtonInfo()
	if(FB_DebugFlag == 1) then
		FB_ReportToUser("<< FB_ShowButtonInfo: Entry >>"); 
	end

	local index
	
	for index = 1,FBNumButtons do
		FB_ShowSingleButtonInfo(index)
	end

	FBButtonInfoShown = true
end

function FB_ShowSingleButtonInfo(btn)
	if(FB_DebugFlag == 1) then
		FB_ReportToUser("<< FB_ShowButtonInfo: Entry >>"); 
	end

	local grp, map
	local text1, text2, text3
	
	FBButtonTextSave[btn]["text1"] = FBState[btn]["hotkeytext"]
	FBButtonTextSave[btn]["text2"] = FBState[btn]["text2"]
	FBButtonTextSave[btn]["text3"] = FBState[btn]["text3"]
		
	text1 = getglobal("FlexBarButton"..btn.."HotKey")
	text2 = getglobal("FlexBarButton"..btn.."Text2")
	text3 = getglobal("FlexBarButton"..btn.."Text3")
		
	text1:SetText("b"..btn)
		
	if(FBState[btn]["group"]) then
		grp = "g"..FBState[btn]["group"]
	else
		grp = "none"
	end
		
	text2:SetText(grp)

	if(FBState[btn]["remap"]) then
		map = "r"..FBState[btn]["remap"]
	else
		map = "none"
	end

	text3:SetText(map)

end
function FB_RestoreButtonText()
	if(FB_DebugFlag == 1) then
		FB_ReportToUser("<< FB_RestoreButtonText Entry >>"); 
	end

	local index, button
	local text1, text2, text3
	
	for index = 1,FBNumButtons do
		text1 = getglobal("FlexBarButton"..index.."HotKey")
		text2 = getglobal("FlexBarButton"..index.."Text2")
		text3 = getglobal("FlexBarButton"..index.."Text3")

		text1:SetText(FBButtonTextSave[index]["text1"])
		text2:SetText(FBButtonTextSave[index]["text2"])
		text3:SetText(FBButtonTextSave[index]["text3"])

		FB_TextSub(index)
		FB_ApplyTextPosition(index)
		button = FB_GetWidgets(index)
		FlexBarButton_UpdateHotkeys(button)
	end

	FBButtonInfoShown = false
end

function FB_UpdateSmartPet(btn)
	if IsAddOnLoaded("SmartPet") and 
		FBSavedProfile[FBProfileName].FlexActions[btn] and
		FBSavedProfile[FBProfileName].FlexActions[btn].action == "pet" then
		local petid = FBSavedProfile[FBProfileName].FlexActions[btn].id
		local smartie = getglobal("SmartPetActionButton"..petid)
		local flexie = getglobal("FlexBarButton"..btn)
		if not smartie then
			FB_ReportToUser("SmartPet action button "..petid.." not found")
		else
			if smartie:GetParent() ~= flexie then
				smartie:SetParent(flexie)
				smartie:ClearAllPoints()
				smartie:SetPoint("BOTTOM", flexie, "TOP", 0, 0)
			end
		end
	end
end