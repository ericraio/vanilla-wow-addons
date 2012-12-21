--[[
	Functions to implement slash commands for FlexBar
	Last Modified
		12/26/2004	Initial version
		08/12/2005  Added FlexBarButton_UpdateLocation and FlexBarButton_DragStart 		- Sherkhan
		08/12/2005  Added Text3 Field	- Sherkhan
		08/24/2005  Adjusted FlexBarButton_OnClick() to "properly" handle pet autocast (ticket #13) - Ratbert_CP
--]]

FlexBarVersion = 1.5


-- Utility object
	local util = Utility_Class:New()

-- OnFoo functions

function FlexBar_OnLoad()
	-- Set up slash commands
	FB_Command_AddCommands(FBcmd)
	-- Register for events
	FlexBar:RegisterEvent("VARIABLES_LOADED");
	FlexBar:RegisterEvent("PLAYER_ENTERING_WORLD");
	FlexBar:RegisterEvent("PLAYER_ENTER_COMBAT");
	FlexBar:RegisterEvent("PLAYER_LEAVE_COMBAT");
	FlexBar:RegisterEvent("PLAYER_REGEN_ENABLED");
	FlexBar:RegisterEvent("PLAYER_REGEN_DISABLED");
	FlexBar:RegisterEvent("CHAT_MSG_COMBAT_SELF_MISSES");
	FlexBar:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE"); 
	FlexBar:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES");
	FlexBar:RegisterEvent("UNIT_HEALTH")
	FlexBar:RegisterEvent("UNIT_MANA")
	FlexBar:RegisterEvent("UNIT_RAGE")
	FlexBar:RegisterEvent("UNIT_ENERGY")
	FlexBar:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
	-- FlexBar:RegisterEvent("SPELLS_CHANGED")
	FlexBar:RegisterEvent("PLAYER_COMBO_POINTS")
	FlexBar:RegisterEvent("PLAYER_GAINED_CONTROL")
	FlexBar:RegisterEvent("PLAYER_LOST_CONTROL")
	FlexBar:RegisterEvent("BAG_UPDATE")
	FlexBar:RegisterEvent("UNIT_INVENTORY_CHANGED")
	FlexBar:RegisterEvent("ACTIONBAR_SLOT_CHANGED")
	FlexBar:RegisterEvent("UPDATE_INVENTORY_ALERTS")
	FlexBar:RegisterEvent("MERCHANT_UPDATE")
	FlexBar:RegisterEvent("MERCHANT_CLOSED")
	FlexBar:RegisterEvent("UNIT_AURA")
	FlexBar:RegisterEvent("UNIT_COMBAT")
	FlexBar:RegisterEvent("PLAYER_TARGET_CHANGED")
	FlexBar:RegisterEvent("UNIT_PET")
	FlexBar:RegisterEvent("UNIT_FLAGS");
	FlexBar:RegisterEvent("PET_BAR_UPDATE");
	FlexBar:RegisterEvent("PET_BAR_UPDATE_COOLDOWN");
	FlexBar:RegisterEvent("PARTY_MEMBERS_CHANGED");
	FlexBar:RegisterEvent("PLAYER_AURAS_CHANGED");
	
end

function FlexBar_OnEvent(event)
-- Dispatch to standard event handlers
	local dispatch = FBEventHandlers[event]
	if dispatch then
		dispatch(event)
	end
-- Dispatch to extended event handlers
	local handlers = FBExtHandlers[string.upper(event)]
	if handlers then
		local index, dispatch
		for index, dispatch in pairs(handlers) do
			dispatch(event)
		end
	end
end

function Flexbar_OnUpdate(elapsed)
-- Update any timers we have running.
	local name, timer
	for name, timer in pairs(FBTimers) do
		timer:Update(elapsed)
	end
	if not FBProfileLoaded then return end
	--local msg = ("Actual = %d,%d\nState = %d,%d\nSaved = %d,%d")
	--msg = format(msg,FlexFrame41:GetRight(),FlexFrame41:GetBottom(),FBState[41]["xcoord"],FBState[41]["ycoord"],FBSavedProfile[FBProfileName][41].State["xcoord"],FBSavedProfile[FBProfileName][41].State["ycoord"])
	FBLoadProfileDialogTitle:SetText("")
	FBLoadProfileDialogText:SetText("")
end

function FlexBarFrame_OnLoad(frame)
	-- Went nuts trying to figure out why I couldn't get clicks and drags
	-- in my handle frames - I didn't do this 
	frame:RegisterForDrag("LeftButton");
end

function FlexBarFrame_UpdateLocation(frame)
	-- The button frame has recieved a drag stop, or a moveABS/moveREL command has finished
	-- Get the current button co-ordinates and store them
	-- 1) Determine if this is a single button, or a group
	-- 2) If single, apply settings for the single button
	--    If group, apply settings for the button group - new coords for all buttons in the group
	local buttonnum=FB_GetButtonNum(frame)

	if (frame.moving) then
		frame.moving = nil;
		frame:StopMovingOrSizing();
		if (FBState[buttonnum]["group"]) and (FBState[buttonnum]["group"] == buttonnum) then
			-- We have a group anchor that moved, save coordinate data for anchor, and set new
			-- locations for non-anchor buttons in memory based upon the stored offset data
			if(FB_DebugFlag == 1) then
				FB_ReportToUser("<< Frame_UpdateLocation: Group #"..buttonnum.." Update >>"); 
			end
			
			FB_GetCoords(buttonnum)
			FB_RestoreGroupOffsetAfterMove(buttonnum)
		else
			-- Single button moved, save coordinate data for just the button
			if(FB_DebugFlag == 1) then
				FB_ReportToUser("<< Frame_UpdateLocation: Button #"..buttonnum.." Update >>"); 
			end
			
			FB_GetCoords(buttonnum)
		end
	end
	
end

function FlexBarFrame_DragStart(frame)
	local buttonnum=FB_GetButtonNum(frame)

	if (FBState[buttonnum]["group"]) and (FBState[buttonnum]["group"] == buttonnum) then
		-- Group move starting, store group button offsets prior to the move
		FB_StoreGroupOffsetForMove(buttonnum)
	end

	-- Set frame to Moving
	frame.moving = true;
	frame:StartMoving();
	
	if(FB_DebugFlag == 1) then
		FB_ReportToUser("<< Button_DragStart: Dragging button "..FB_GetButtonNum(frame).." >>"); 
	end
end

function FlexBarButtonDown(buttonnum)
-- Modified Blizzard code (removed bonus action check)
-- appears to simply change the look of the button to reflect that 
-- it is pushed.

-- originally coded to use the button ID - but why when this is only called from bindings?
	local button = getglobal("FlexBarButton".. buttonnum);
	if ( button:GetButtonState() == "NORMAL" ) then
		button:SetButtonState("PUSHED");
	end
end

function FlexBarButtonUp(buttonnum)
-- Modified Blizzard code (removed bonus action check)
-- besides the appearance change, not sure what they are doing here.
-- same as above
	local button = getglobal("FlexBarButton".. buttonnum);
	if ( button:GetButtonState() == "PUSHED" ) then
		button:SetButtonState("NORMAL");
		FBLastButtonDown = "LeftButton"
		FlexBarButton_OnClick(button, true, "LeftButton")
		if ( IsCurrentAction(FlexBarButton_GetID(button)) ) then
			button:SetChecked(1);
		else
			button:SetChecked(0);
		end
	end
end

function FlexBarButton_OnLoad(button)
-- Blizzard code:  Called as each button is loaded.
	button.showgrid = 1;
	button.flashing = 0;
	button.flashtime = 0;
	FlexBarButton_Update(button);
-- Went nuts trying to figure out why I couldn't get clicks and drags
-- in my handle frames - I didn't do this 
	button:RegisterForDrag("LeftButton", "RightButton");
	button:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	button:RegisterEvent("VARIABLES_LOADED");
	button:RegisterEvent("ACTIONBAR_SHOWGRID");
	button:RegisterEvent("ACTIONBAR_HIDEGRID");
	button:RegisterEvent("ACTIONBAR_PAGE_CHANGED");
	button:RegisterEvent("ACTIONBAR_SLOT_CHANGED");
	button:RegisterEvent("ACTIONBAR_UPDATE_STATE");
	button:RegisterEvent("ACTIONBAR_UPDATE_USABLE");
	button:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
	button:RegisterEvent("UPDATE_INVENTORY_ALERTS");
	button:RegisterEvent("PLAYER_AURAS_CHANGED");
	button:RegisterEvent("PLAYER_TARGET_CHANGED");
	button:RegisterEvent("UNIT_AURASTATE");
	button:RegisterEvent("UNIT_INVENTORY_CHANGED");
	button:RegisterEvent("CRAFT_SHOW");
	button:RegisterEvent("CRAFT_CLOSE");
	button:RegisterEvent("TRADE_SKILL_SHOW");
	button:RegisterEvent("TRADE_SKILL_CLOSE");
	button:RegisterEvent("UNIT_HEALTH");
	button:RegisterEvent("UNIT_MANA");
	button:RegisterEvent("UNIT_RAGE");
	button:RegisterEvent("UNIT_FOCUS");
	button:RegisterEvent("UNIT_ENERGY");
	button:RegisterEvent("PLAYER_ENTER_COMBAT");
	button:RegisterEvent("PLAYER_LEAVE_COMBAT");
	button:RegisterEvent("PLAYER_COMBO_POINTS");
	button:RegisterEvent("UPDATE_BINDINGS");
	button:RegisterEvent("START_AUTOREPEAT_SPELL");
	button:RegisterEvent("STOP_AUTOREPEAT_SPELL");
	button:RegisterEvent("PLAYER_ENTERING_WORLD");
	FlexBarButton_UpdateHotkeys(button);
end

function FlexBarButton_UpdateHotkeys(button)
-- This sets the hotkey text.  Originally borrowed from Telo's SideBar,
-- optionally puts binding or id in depending on user selection.

	local name = button:GetName();
	local hotkey = getglobal(name.."HotKey");
	local text2 = getglobal(name.."Text2");
	local text3 = getglobal(name.."Text3");
	local s, e, id = string.find(name, "^FlexBarButton(%d+)$");
	local action = "FLEXACTIONBUTTON"..id;
	local text = GetBindingKey(action)
	
	if text then
		text = string.upper(text)
		text = string.gsub(text, "CTRL--", "C-");
		text = string.gsub(text, "ALT--", "A-");
		text = string.gsub(text, "SHIFT--", "S-");
		text = string.gsub(text, "NUM PAD", "NP");
		text = string.gsub(text, "BACKSPACE", "Bksp");
		text = string.gsub(text, "SPACEBAR", "Space");
		text = string.gsub(text, "PAGE", "Pg");
		text = string.gsub(text, "DOWN", "Dn");
		text = string.gsub(text, "ARROW", "");
		text = string.gsub(text, "INSERT", "Ins");
		text = string.gsub(text, "DELETE", "Del");
	else
		text = ""
	end

	local buttonnum=FB_GetButtonNum(button)
	if FBState[buttonnum]["hotkeytext"] == nil then FBState[buttonnum]["hotkeytext"] = "" end
	-- going to add %s for slots free for bags here later
	if FBState[buttonnum]["hotkeytext"] == "%b" then
		hotkey:SetText(text);
	elseif FBState[buttonnum]["hotkeytext"] == "%c" then
		hotkey:SetText("**")
	elseif FBState[buttonnum]["hotkeytext"] == "%d" then
		hotkey:SetText(buttonnum)
	else
		FB_TextSub(buttonnum)
	end

	if FBState[buttonnum]["text2"] == nil then FBState[buttonnum]["text2"] = "" end
	-- going to add %s for slots free for bags here later
	if FBState[buttonnum]["text2"] == "%b" then
		text2:SetText(text);
	elseif FBState[buttonnum]["text2"] == "%c" then
		text2:SetText("**")
	elseif FBState[buttonnum]["text2"] == "%d" then
		text2:SetText(buttonnum)
	else
		FB_TextSub(buttonnum)
	end
	
	if FBState[buttonnum]["text3"] == nil then FBState[buttonnum]["text3"] = "" end
	-- going to add %s for slots free for bags here later
	if FBState[buttonnum]["text3"] == "%b" then
		text3:SetText(text);
	elseif FBState[buttonnum]["text3"] == "%c" then
		text3:SetText("**")
	elseif FBState[buttonnum]["text3"] == "%d" then
		text3:SetText(buttonnum)
	else
		FB_TextSub(buttonnum)
	end
end

function FlexBarButton_Update(button)
	local buttonnum=FB_GetButtonNum(button)
	local buttonID = FlexBarButton_GetID(button);

	-- Determine whether or not the button should be flashing or not since the button may have missed the enter combat event
	if ( IsAttackAction(buttonID) and IsCurrentAction(buttonID) ) then
		IN_ATTACK_MODE = 1;
	else
		IN_ATTACK_MODE = nil;
	end
	IN_AUTOREPEAT_MODE = IsAutoRepeatAction(buttonID);
	
	local icon = getglobal(button:GetName().."Icon");
	local buttonCooldown = getglobal(button:GetName().."Cooldown");
	local texture = GetActionTexture(FlexBarButton_GetID(button));
	if ( texture ) then
		icon:SetTexture(texture);
		icon:Show();
		button.rangeTimer = TOOLTIP_UPDATE_TIME;
		button:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2");
	else
		if	FBProfileLoaded and FBSavedProfile[FBProfileName].FlexActions[buttonID] and
			FBSavedProfile[FBProfileName].FlexActions[buttonID]["texture"] then
			local fbtext = string.lower(FBSavedProfile[FBProfileName].FlexActions[buttonID]["texture"])
			if 	fbtext == "%player" or fbtext == "%party1" or
				fbtext == "%party2" or fbtext == "%party3" or
				fbtext == "%party4" or fbtext == "%target" or fbtext == "%pet" then
				
				SetPortraitTexture(icon,string.sub(fbtext,2))
				icon:SetVertexColor(1,1,1)
				icon:SetAlpha(1)
			else
				icon:SetTexture(FBSavedProfile[FBProfileName].FlexActions[buttonID]["texture"])
			end
			button:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2");
			icon:Show()
		else
			icon:Hide();
			buttonCooldown:Hide();
			button.rangeTimer = nil;
			if not  (FBProfileLoaded and FBSavedProfile[FBProfileName].FlexActions[buttonID] and
					FBSavedProfile[FBProfileName].FlexActions[buttonID]["texture"]) then
				button:SetNormalTexture("Interface\\Buttons\\UI-Quickslot");
			end
			if not FBState[FB_GetButtonNum(button)]["hotkeycolor"] then getglobal(button:GetName().."HotKey"):SetVertexColor(0.6, 0.6, 0.6); end
		end
	end
	FlexBarButton_UpdateCount(button);
	if 	( HasAction(FlexBarButton_GetID(button)) ) or 
		( FBProfileLoaded and FBSavedProfile[FBProfileName].FlexActions[buttonID] ) then 
		button:Show();
		-- somewhere right before here, this gets reset to whatever 
		-- has focus -- so put it back.  I don't know if this causes problems
		-- but it is certainly the first place to look.  This only happens with
		-- remapping an empty button with showgrid=0 to a non-empty button.
		FlexBarButton_UpdateUsable(button);
		FlexBarButton_UpdateCooldown(button);
	elseif ( button.showgrid == 0 ) then
			button:Hide();
	else
		getglobal(button:GetName().."Cooldown"):Hide();
	end

	if ( IN_ATTACK_MODE or IN_AUTOREPEAT_MODE ) then
		FlexBarButton_StartFlash(button);
	else
		FlexBarButton_StopFlash(button);
	end

	if ( GameTooltip:IsOwned(button) ) then
		FlexBarButton_SetTooltip(button);
	else
		button.updateTooltip = nil;
	end

	-- Update Macro Text
	local macroName = getglobal(button:GetName().."Name");
	macroName:SetText(GetActionText(FlexBarButton_GetID(button)))
end

function FlexBarButton_ShowGrid(button)
-- Blizzard code;  Show button even if it doesn't have an action associated with it.
	button.showgrid = button.showgrid+1;
	getglobal(button:GetName().."NormalTexture"):SetVertexColor(1.0, 1.0, 1.0);
	button:Show();
	local _,frame = FB_GetWidgets(FB_GetButtonNum(button))
	frame:EnableDrawLayer()
end

function FlexBarButton_HideGrid(button)	
-- Blizzard code: Hide button if it doesn't have an action associated with it
	button.showgrid = button.showgrid-1;
	if 	( button.showgrid == 0 ) and not (HasAction(FlexBarButton_GetID(button)))  then
		button:Hide();
		local _,frame = FB_GetWidgets(FB_GetButtonNum(button))
		frame:DisableDrawLayer()
	end
end

function FlexBarButton_UpdateState(button)
-- Blizzard code: 
	if 	( IsCurrentAction(FlexBarButton_GetID(button)) or 
		IsAutoRepeatAction(FlexBarButton_GetID(button)) or
		FBState[FB_GetButtonNum(button)]["checked"] ) then
		button:SetChecked(1);
	else
		button:SetChecked(0);
	end
end

function FlexBarButton_UpdateUsable(button)
	local buttonnum=FB_GetButtonNum(button)

	-- If the button is currently hidden - we do not need to do anything for this button at this time
	if FBState[buttonnum]["hidden"] then return end;
	
-- Blizzard code:
	local icon = getglobal(button:GetName().."Icon");
	local normalTexture = getglobal(button:GetName().."NormalTexture");
-- Mana check available here - also has potential
	local isUsable, notEnoughMana = IsUsableAction(FlexBarButton_GetID(button));
-- Hotkey is the text displayed in the upper right corner.
	local count = getglobal(button:GetName().."HotKey");
	local text2 = getglobal(button:GetName().."Text2");
	local text3 = getglobal(button:GetName().."Text3");
	local text = count:GetText();
-- Here's the test for action in range - for further enhancements that let the player know button better
	local inRange = IsActionInRange(FlexBarButton_GetID(button));
	local buttonID = FlexBarButton_GetID(button)
	if not FBState[buttonnum]["hotkeycolor"] then
		if( inRange == 0 ) then
			count:SetVertexColor(1.0, 0.1, 0.1);
		else
			count:SetVertexColor(0.6, 0.6, 0.6);
		end
	end
	-- Default blizz code resets the vertex color every pass through, regardless of whether the state
	-- changed.  This may be a cause of FPS reduction when people have lots of buttons visible.  Added checks
	-- so coloring will only occur on an actual change of state.
	if ( isUsable ) then
-- Telo added this code - If the button has hotkey text it colors like normal on in/out of range
-- w/o hotkey text it colors the entire button.  
-- added toggle to force this behavior
		if ( (not text or text == "" or FBToggles["forceshading"]) and inRange == 0 ) then
			if FBState[buttonnum]["coloring"] ~= "usable_out_of_range" then
				icon:SetVertexColor(1.0, 0.1, 0.1);
				normalTexture:SetVertexColor(1.0, 0.1, 0.1);
				FBState[buttonnum]["coloring"] = "usable_out_of_range"
			end
		else
			if FBState[buttonnum]["coloring"] ~= "usable_in_range" then
				icon:SetVertexColor(1.0, 1.0, 1.0);
				normalTexture:SetVertexColor(1.0, 1.0, 1.0);
				FBState[buttonnum]["coloring"] = "usable_in_range"
			end
		end
	elseif ( notEnoughMana ) then
		if FBState[buttonnum]["coloring"] ~= "not_enough_mana" then
			icon:SetVertexColor(0.5, 0.5, 1.0);
			normalTexture:SetVertexColor(0.5, 0.5, 1.0);
			FBState[buttonnum]["coloring"] = "not_enough_mana"
		end
	else
		if FBState[buttonnum]["coloring"] ~= "not_usable" then
			icon:SetVertexColor(0.4, 0.4, 0.4);
			normalTexture:SetVertexColor(1.0, 1.0, 1.0);
			FBState[buttonnum]["coloring"] = "not_usable"
		end
	end
	if FBProfileLoaded and FBSavedProfile[FBProfileName].FlexActions[buttonID] and FBSavedProfile[FBProfileName].FlexActions[buttonID]["texture"] then
		icon:SetVertexColor(1.0, 1.0, 1.0);
		normalTexture:SetVertexColor(1.0, 1.0, 1.0);
	end

	if FBState[buttonnum]["icon"] then
		local bcolors = FBState[buttonnum]["icon"]
		icon:SetVertexColor(bcolors[1], bcolors[2], bcolors[3])
	end
	
-- Digital cooldown - set the hotkey text to '%c' to get a digital cooldown
	if FBState[buttonnum]["hotkeytext"] then
		if FBState[buttonnum]["hotkeytext"] == "%c" then
			local start, duration, enable = GetActionCooldown(button:GetID());
			if 	FBProfileLoaded and FBSavedProfile[FBProfileName].FlexActions[buttonID] and 
				FBSavedProfile[FBProfileName].FlexActions[buttonID]["action"] == "pet" then
				start, duration, enable = GetPetActionCooldown(FBSavedProfile[FBProfileName].FlexActions[buttonID]["id"])
			end
			if start > 0 then
				count:SetText(format("%d",duration-(GetTime()-start)))
				count:SetVertexColor(1.0, 1.0, .5)
			else
				count:SetText("**")
				count:SetVertexColor(.5, 1.0, .5)
			end
		end
	end
-- Digital cooldown - set the hotkey text to '%c' to get a digital cooldown
	if FBState[buttonnum]["text2"] then
		if FBState[buttonnum]["text2"] == "%c" then
			local start, duration, enable = GetActionCooldown(button:GetID());
			if 	FBProfileLoaded and FBSavedProfile[FBProfileName].FlexActions[buttonID] and 
				FBSavedProfile[FBProfileName].FlexActions[buttonID]["action"] == "pet" then
				start, duration, enable = GetPetActionCooldown(FBSavedProfile[FBProfileName].FlexActions[buttonID]["id"])
			end
			if start > 0 then
				text2:SetText(format("%d",duration-(GetTime()-start)))
				text2:SetVertexColor(1.0, 1.0, .5)
			else
				text2:SetText("**")
				text2:SetVertexColor(.5, 1.0, .5)
			end
		end
	end
-- Digital cooldown - set the hotkey text to '%c' to get a digital cooldown
	if FBState[buttonnum]["text3"] then
		if FBState[buttonnum]["text3"] == "%c" then
			local start, duration, enable = GetActionCooldown(button:GetID());
			if 	FBProfileLoaded and FBSavedProfile[FBProfileName].FlexActions[buttonID] and 
				FBSavedProfile[FBProfileName].FlexActions[buttonID]["action"] == "pet" then
				start, duration, enable = GetPetActionCooldown(FBSavedProfile[FBProfileName].FlexActions[buttonID]["id"])
			end
			if start > 0 then
				text3:SetText(format("%d",duration-(GetTime()-start)))
				text3:SetVertexColor(1.0, 1.0, .5)
			else
				text3:SetText("**")
				text3:SetVertexColor(.5, 1.0, .5)
			end
		end
	end
end

function FlexBarButton_UpdateCount(button)
-- Blizzard code - purpose unknown at this time
	local text = getglobal(button:GetName().."Count");
	local count = GetActionCount(FlexBarButton_GetID(button));
	if ( count > 1 ) then
		text:SetText(count);
	else
		text:SetText("");
	end
end

function FlexBarButton_UpdateCooldown(button)
	local buttonnum=FB_GetButtonNum(button)
	local buttonID = button:GetID()
	
	-- If the button is currently hidden - we do not need to do anything for this button
	if FBState[buttonnum]["hidden"] then return end;
	
	-- Blizzard code - looks like it updates the little cooldown spinner.
	local cooldown = getglobal(button:GetName().."Cooldown");
	local hotkey = getglobal(button:GetName().."HotKey");
	local start, duration, enable = GetActionCooldown(FlexBarButton_GetID(button));
	if 	FBProfileLoaded and FBSavedProfile[FBProfileName].FlexActions[buttonID] and 
		FBSavedProfile[FBProfileName].FlexActions[buttonID]["action"] == "pet" then
		start, duration, enable = GetPetActionCooldown(FBSavedProfile[FBProfileName].FlexActions[buttonID]["id"])
	end
	-- if digital cooldowns are enabled, disable spinner - it obscures the display.
	if FBState[buttonnum]["hotkeytext"] ~= "%c" and FBState[buttonnum]["text2"] ~= "%c"  and FBState[buttonnum]["text3"] ~= "%c" then
		CooldownFrame_SetTimer(cooldown, start, duration, enable)
	end
end

function FlexBarButton_OnEvent(event, button)
-- Event code for individual buttons 
	if( event == "VARIABLES_LOADED" ) then
	end

	if ( event == "ACTIONBAR_SLOT_CHANGED" ) then
		if ( arg1 == -1 or arg1 == FlexBarButton_GetID(button) ) then
			FlexBarButton_Update(button);
		end
		return;
	end

	if ( event == "PLAYER_AURAS_CHANGED") then
		FlexBarButton_Update(button);
		FlexBarButton_UpdateState(button);
		return;
	end
	if ( event == "ACTIONBAR_SHOWGRID" ) then
		FlexBarButton_ShowGrid(button);
		return;
	end
	if ( event == "ACTIONBAR_HIDEGRID" ) then
		FlexBarButton_HideGrid(button);
		return;
	end
	if ( event == "UPDATE_BINDINGS" ) then
		FlexBarButton_UpdateHotkeys(button);
	end

	-- All event handlers below this line MUST only be valid when the button is visible
	if ( not button:IsVisible() ) then
		return;
	end

	if ( event == "PLAYER_TARGET_CHANGED" ) then
		FlexBarButton_UpdateUsable(button);
		return;
	end
	if ( event == "UNIT_AURASTATE" ) then
		if ( arg1 == "player" or arg1 == "target" ) then
			FlexBarButton_UpdateUsable(button);
		end
		return;
	end
	if ( event == "UNIT_INVENTORY_CHANGED" ) then
		if ( arg1 == "player" ) then
			FlexBarButton_Update(button);
		end
		return;
	end
	if ( event == "ACTIONBAR_UPDATE_STATE" ) then
		FlexBarButton_UpdateState(button);
		return;
	end

	if ( event == "ACTIONBAR_UPDATE_COOLDOWN" ) then
		local buttonnum = FB_GetButtonNum(button)
		local start, duration, enable = GetActionCooldown(button:GetID())
		if not FBState[buttonnum]["lastcooldown"] then
			FlexBarButton_UpdateCooldown(button);
			FlexBarButton_UpdateUsable(button);
			FBState[buttonnum]["lastcooldown"] = {}
			FBState[buttonnum]["lastcooldown"]["start"] = start
			FBState[buttonnum]["lastcooldown"]["duration"] = duration
		elseif 	FBState[buttonnum]["lastcooldown"]["start"] ~= start or
				FBState[buttonnum]["lastcooldown"]["duration"] ~= duration then
			FlexBarButton_UpdateCooldown(button);
			FlexBarButton_UpdateUsable(button);
			FBState[buttonnum]["lastcooldown"] = {}
			FBState[buttonnum]["lastcooldown"]["start"] = start
			FBState[buttonnum]["lastcooldown"]["duration"] = duration
		end
		return;
	end

	if ( event == "ACTIONBAR_UPDATE_USABLE" ) then
		FlexBarButton_UpdateUsable(button);
		FlexBarButton_UpdateCooldown(button);
		return
	end

	if ( event == "UPDATE_INVENTORY_ALERTS" ) then
		FlexBarButton_UpdateCooldown(button);
		FlexBarButton_UpdateUsable(button);
		return;
	end

	if ( event == "CRAFT_SHOW" or event == "CRAFT_CLOSE" or event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_CLOSE" ) then
		FlexBarButton_UpdateState(button);
		return;
	end
	if ( arg1 == "player" and (event == "UNIT_HEALTH" or event == "UNIT_MANA" or event == "UNIT_RAGE" or event == "UNIT_FOCUS" or event == "UNIT_ENERGY") ) then
		FlexBarButton_UpdateUsable(button);
		return;
	end
	if ( event == "PLAYER_ENTER_COMBAT" ) then
		IN_ATTACK_MODE = 1;
		if ( IsAttackAction(FlexBarButton_GetID(button)) ) then
			FlexBarButton_StartFlash(button);
		end
		return;
	end
	if ( event == "PLAYER_LEAVE_COMBAT" ) then
		IN_ATTACK_MODE = 0;
		if ( IsAttackAction(FlexBarButton_GetID(button)) ) then
			FlexBarButton_StopFlash(button);
		end
		return;
	end
	if ( event == "PLAYER_COMBO_POINTS" ) then
		FlexBarButton_UpdateUsable(button);
		return;
	end
	if ( event == "START_AUTOREPEAT_SPELL" ) then
		IN_AUTOREPEAT_MODE = 1;
		if ( IsAutoRepeatAction(FlexBarButton_GetID(button)) ) then
			FlexBarButton_StartFlash(button);
		end
		return;
	end
	if ( event == "STOP_AUTOREPEAT_SPELL" ) then
		IN_AUTOREPEAT_MODE = nil;
		if ( FlexBarButton_IsFlashing(button) and not IsAttackAction(FlexBarButton_GetID(button)) ) then
			FlexBarButton_StopFlash(button);
		end
		return;
	end
end

function FlexBarButton_SetTooltip(button)
-- Blizzard code
-- appears to reset the manually set this from my routines.
	GameTooltip_SetDefaultAnchor(GameTooltip, button)	
--	GameTooltip:SetOwner(this);

	local FlexButtonID = FlexBarButton_GetID(button)
	local FlexButtonNum = FB_GetButtonNum(button)
	if ( GameTooltip:SetAction(FlexButtonID) ) then
		button.updateTooltip = TOOLTIP_UPDATE_TIME;
	elseif 	FBProfileLoaded and
			FBSavedProfile[FBProfileName].FlexActions[button:GetID()] and
			FBSavedProfile[FBProfileName].FlexActions[button:GetID()]["action"] ~= "autoitem" and
			FBSavedProfile[FBProfileName].FlexActions[button:GetID()]["name"] then
			
			GameTooltip:SetText(FBSavedProfile[FBProfileName].FlexActions[button:GetID()]["name"])
	else
		button.updateTooltip = nil;
	end
	if ( FBButtonInfoTooltipShown ) then
		local scale = 1.0
		local ttcolor = FBToggles["tooltipinfocolor"]
		local x = math.floor(FBState[FlexButtonNum].xcoord + .5)
		local y = math.floor(FBState[FlexButtonNum].ycoord + .5)
		if FBState[FlexButtonNum].scale ~= nil then
			scale = FBState[FlexButtonNum].scale
		end
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine("Flexbar Button "..FlexButtonNum, ttcolor.r, ttcolor.g, ttcolor.b)
		if (FBState[FlexButtonNum].remap ~= nil) then
			GameTooltip:AddLine("Remaped ID: "..FBState[FlexButtonNum].remap, ttcolor.r, ttcolor.g, ttcolor.b)
		end
		if (FBState[FlexButtonNum].group ~= nil) then
			GameTooltip:AddLine("Group: "..FBState[FlexButtonNum].group, ttcolor.r, ttcolor.g, ttcolor.b)
		end
		local PosInfo = "Position: <"..x..", "..y..">"
		if scale ~= 1 then PosInfo = PosInfo.." Scale:"..scale end
		GameTooltip:AddLine(PosInfo, ttcolor.r, ttcolor.g, ttcolor.b)
		GameTooltip:Show()
		button.updateTooltip = TOOLTIP_UPDATE_TIME;
	end
end


function FlexBarButton_OnUpdate(elapsed, button)
-- Blizzard code
	if ( FlexBarButton_IsFlashing(button) ) then
		button.flashtime = button.flashtime - elapsed;
		if ( button.flashtime <= 0 ) then
			local overtime = -button.flashtime;
			if ( overtime >= ATTACK_BUTTON_FLASH_TIME ) then
				overtime = 0;
			end
			button.flashtime = ATTACK_BUTTON_FLASH_TIME - overtime;

			local flashTexture = getglobal(button:GetName().."Flash");
			if ( flashTexture:IsVisible() ) then
				flashTexture:Hide();
			else
				flashTexture:Show();
			end
		end
	end
	-- Handle range indicator
	if ( button.rangeTimer ) then
		if ( button.rangeTimer < 0 ) then
			FlexBarButton_UpdateUsable(button);
			button.rangeTimer = TOOLTIP_UPDATE_TIME;
		else
			button.rangeTimer = button.rangeTimer - elapsed;
		end
	end

	if ( not button.updateTooltip ) then
		return;
	end

	button.updateTooltip = button.updateTooltip - elapsed;
	if ( button.updateTooltip > 0 ) then
		return;
	end

	if ( GameTooltip:IsOwned(button) ) then
		FlexBarButton_SetTooltip(button);
	else
		button.updateTooltip = nil;
	end
end

function FlexBarButton_GetID(button)
	return (button:GetID())
end

function FlexBarButton_StartFlash(button)
-- Blizzard code
	button.flashing = 1;
	button.flashtime = 0;
	FlexBarButton_UpdateState(button);
end

function FlexBarButton_StopFlash(button)
-- Blizzard code
	button.flashing = 0;
	getglobal(button:GetName().."Flash"):Hide();
	FlexBarButton_UpdateState(button);
end

function FlexBarButton_IsFlashing(button)
-- Blizzard code
	if ( button.flashing == 1 ) then
		return 1;
	else
		return nil;
	end
end

function FlexBarButton_OnClick(button, frombinding, mousebutton)
	if ( IsShiftKeyDown() ) and ( not frombinding ) then
		if not FBSavedProfile[FBProfileName].FlexActions[button:GetID()] then
			PickupAction(FlexBarButton_GetID(button));
		else
			local u = Utility_Class:New()
			if FBSavedProfile[FBProfileName].FlexActions[button:GetID()]["action"] == "autoitem" then
				u:Echo("Error:  Cannot drag an Auto Item off - disable auto item to remove")
			elseif FBSavedProfile[FBProfileName].FlexActions[button:GetID()]["action"] == "pet" then
				PickupPetAction(FBSavedProfile[FBProfileName].FlexActions[button:GetID()]["id"])
			end
		end
	else
		if not FBState[FB_GetButtonNum(button)]["disabled"] then
			if (FBState[FB_GetButtonNum(button)]["advanced"] and mousebutton == "LeftButton") or
				not FBState[FB_GetButtonNum(button)]["advanced"] then
				local id = FlexBarButton_GetID(button);
				if 	not FBSavedProfile[FBProfileName].FlexActions[button:GetID()] or 
					FBSavedProfile[FBProfileName].FlexActions[button:GetID()]["action"] == "autoitem" then
					if (MacroFrame_SaveMacro) then
						MacroFrame_SaveMacro();
					end
					UseAction(id, 1);
				else
					if FBSavedProfile[FBProfileName].FlexActions[button:GetID()]["action"] == "macro" then
						local name = FBSavedProfile[FBProfileName].FlexActions[button:GetID()]["name"]
						local macro = FBSavedProfile[FBProfileName].FlexActions[button:GetID()]["macro"]
						if type(macro) == "table" then
							local index,command, longmacro
							longmacro = "\n"
							for index,command in ipairs(macro) do
								longmacro=longmacro..command.."\n"
							end
							FB_Execute_MultilineMacro(longmacro,"InLineMacro"..GetTime())
						elseif FBScripts[macro] then
							FB_Execute_MultilineMacro(FBScripts[macro],name)
						else
							FB_Execute_Command(macro)
						end
					elseif FBSavedProfile[FBProfileName].FlexActions[button:GetID()]["action"] == "script" then
						if FBScripts[FBSavedProfile[FBProfileName].FlexActions[button:GetID()]["script"]] then
							RunScript(FBScripts[FBSavedProfile[FBProfileName].FlexActions[button:GetID()]["script"]])
						else
							RunScript(FBSavedProfile[FBProfileName].FlexActions[button:GetID()]["script"])
						end
					elseif FBSavedProfile[FBProfileName].FlexActions[button:GetID()]["action"] == "pet" then
						local id = FBSavedProfile[FBProfileName].FlexActions[button:GetID()]["id"]
						if arg1 == "RightButton" then
							TogglePetAutocast(id)
						else
							CastPetAction(id)
						end
					end
				end
			end
		end
		if FBEventToggles["buttonevents"] ~= "off" then
			local lastbutton = FBLastButtonDown
			if frombinding then lastbutton="LeftButton" end
			FB_RaiseEvent(lastbutton.."Click", FB_GetButtonNum(button))
			if FBState[FB_GetButtonNum(button)]["echo"] then
				FB_RaiseEvent(lastbutton.."Click",FBState[FB_GetButtonNum(button)]["echo"])
			end
		end
	end
	FlexBarButton_UpdateState(button);
end

function FlexBar_LoadDefaults()
	util:Echo("Flex Bar - first use")
end

------------------------- Bindings ---------------------------------------
BINDING_HEADER_FLEXBAR_SCRIPTS = "FlexBar GUI Panels";
BINDING_NAME_FLEXBAR_MAINMENU = "Open Flex Main Menu";
BINDING_NAME_FLEXBAR_AUTOITEM = "Open Auto Items";
BINDING_NAME_FLEXBAR_SCRIPTS = "Open Script Editor";
BINDING_NAME_FLEXBAR_PERFORMANCE = "Open Performance Panel";
BINDING_NAME_FLEXBAR_OPTIONS = "Open Options Panel";
BINDING_NAME_FLEXBAR_EVENTED = "Open Event Editor";
BINDING_NAME_FLEXBAR_BUTNINFO = "Button Information Toggle";
BINDING_NAME_FLEXBAR_BUTNTOOLTIP = "Button Info Tooltip Toggle";
BINDING_HEADER_FLEXBAR = "FlexBar Buttons";
BINDING_NAME_FLEXACTIONBUTTON1 = "FlexBar Button 1";
BINDING_NAME_FLEXACTIONBUTTON2 = "FlexBar Button 2";
BINDING_NAME_FLEXACTIONBUTTON3 = "FlexBar Button 3";
BINDING_NAME_FLEXACTIONBUTTON4 = "FlexBar Button 4";
BINDING_NAME_FLEXACTIONBUTTON5 = "FlexBar Button 5";
BINDING_NAME_FLEXACTIONBUTTON6 = "FlexBar Button 6";
BINDING_NAME_FLEXACTIONBUTTON7 = "FlexBar Button 7";
BINDING_NAME_FLEXACTIONBUTTON8 = "FlexBar Button 8";
BINDING_NAME_FLEXACTIONBUTTON9 = "FlexBar Button 9";
BINDING_NAME_FLEXACTIONBUTTON10 = "FlexBar Button 10";
BINDING_NAME_FLEXACTIONBUTTON11 = "FlexBar Button 11";
BINDING_NAME_FLEXACTIONBUTTON12 = "FlexBar Button 12";
BINDING_NAME_FLEXACTIONBUTTON13 = "FlexBar Button 13";
BINDING_NAME_FLEXACTIONBUTTON14 = "FlexBar Button 14";
BINDING_NAME_FLEXACTIONBUTTON15 = "FlexBar Button 15";
BINDING_NAME_FLEXACTIONBUTTON16 = "FlexBar Button 16";
BINDING_NAME_FLEXACTIONBUTTON17 = "FlexBar Button 17";
BINDING_NAME_FLEXACTIONBUTTON18 = "FlexBar Button 18";
BINDING_NAME_FLEXACTIONBUTTON19 = "FlexBar Button 19";
BINDING_NAME_FLEXACTIONBUTTON20 = "FlexBar Button 20";
BINDING_NAME_FLEXACTIONBUTTON21 = "FlexBar Button 21";
BINDING_NAME_FLEXACTIONBUTTON22 = "FlexBar Button 22";
BINDING_NAME_FLEXACTIONBUTTON23 = "FlexBar Button 23";
BINDING_NAME_FLEXACTIONBUTTON24 = "FlexBar Button 24";
BINDING_NAME_FLEXACTIONBUTTON25 = "FlexBar Button 25";
BINDING_NAME_FLEXACTIONBUTTON26 = "FlexBar Button 26";
BINDING_NAME_FLEXACTIONBUTTON27 = "FlexBar Button 27";
BINDING_NAME_FLEXACTIONBUTTON28 = "FlexBar Button 28";
BINDING_NAME_FLEXACTIONBUTTON29 = "FlexBar Button 29";
BINDING_NAME_FLEXACTIONBUTTON30 = "FlexBar Button 30";
BINDING_NAME_FLEXACTIONBUTTON31 = "FlexBar Button 31";
BINDING_NAME_FLEXACTIONBUTTON32 = "FlexBar Button 32";
BINDING_NAME_FLEXACTIONBUTTON33 = "FlexBar Button 33";
BINDING_NAME_FLEXACTIONBUTTON34 = "FlexBar Button 34";
BINDING_NAME_FLEXACTIONBUTTON35 = "FlexBar Button 35";
BINDING_NAME_FLEXACTIONBUTTON36 = "FlexBar Button 36";
BINDING_NAME_FLEXACTIONBUTTON37 = "FlexBar Button 37";
BINDING_NAME_FLEXACTIONBUTTON38 = "FlexBar Button 38";
BINDING_NAME_FLEXACTIONBUTTON39 = "FlexBar Button 39";
BINDING_NAME_FLEXACTIONBUTTON40 = "FlexBar Button 40";
BINDING_NAME_FLEXACTIONBUTTON41 = "FlexBar Button 41";
BINDING_NAME_FLEXACTIONBUTTON42 = "FlexBar Button 42";
BINDING_NAME_FLEXACTIONBUTTON43 = "FlexBar Button 43";
BINDING_NAME_FLEXACTIONBUTTON44 = "FlexBar Button 44";
BINDING_NAME_FLEXACTIONBUTTON45 = "FlexBar Button 45";
BINDING_NAME_FLEXACTIONBUTTON46 = "FlexBar Button 46";
BINDING_NAME_FLEXACTIONBUTTON47 = "FlexBar Button 47";
BINDING_NAME_FLEXACTIONBUTTON48 = "FlexBar Button 48";
BINDING_NAME_FLEXACTIONBUTTON49 = "FlexBar Button 49";
BINDING_NAME_FLEXACTIONBUTTON50 = "FlexBar Button 50";
BINDING_NAME_FLEXACTIONBUTTON51 = "FlexBar Button 51";
BINDING_NAME_FLEXACTIONBUTTON52 = "FlexBar Button 52";
BINDING_NAME_FLEXACTIONBUTTON53 = "FlexBar Button 53";
BINDING_NAME_FLEXACTIONBUTTON54 = "FlexBar Button 54";
BINDING_NAME_FLEXACTIONBUTTON55 = "FlexBar Button 55";
BINDING_NAME_FLEXACTIONBUTTON56 = "FlexBar Button 56";
BINDING_NAME_FLEXACTIONBUTTON57 = "FlexBar Button 57";
BINDING_NAME_FLEXACTIONBUTTON58 = "FlexBar Button 58";
BINDING_NAME_FLEXACTIONBUTTON59 = "FlexBar Button 59";
BINDING_NAME_FLEXACTIONBUTTON60 = "FlexBar Button 60";
BINDING_NAME_FLEXACTIONBUTTON61 = "FlexBar Button 61";
BINDING_NAME_FLEXACTIONBUTTON62 = "FlexBar Button 62";
BINDING_NAME_FLEXACTIONBUTTON63 = "FlexBar Button 63";
BINDING_NAME_FLEXACTIONBUTTON64 = "FlexBar Button 64";
BINDING_NAME_FLEXACTIONBUTTON65 = "FlexBar Button 65";
BINDING_NAME_FLEXACTIONBUTTON66 = "FlexBar Button 66";
BINDING_NAME_FLEXACTIONBUTTON67 = "FlexBar Button 67";
BINDING_NAME_FLEXACTIONBUTTON68 = "FlexBar Button 68";
BINDING_NAME_FLEXACTIONBUTTON69 = "FlexBar Button 69";
BINDING_NAME_FLEXACTIONBUTTON70 = "FlexBar Button 70";
BINDING_NAME_FLEXACTIONBUTTON71 = "FlexBar Button 71";
BINDING_NAME_FLEXACTIONBUTTON72 = "FlexBar Button 72";
BINDING_NAME_FLEXACTIONBUTTON73 = "FlexBar Button 73";
BINDING_NAME_FLEXACTIONBUTTON74 = "FlexBar Button 74";
BINDING_NAME_FLEXACTIONBUTTON75 = "FlexBar Button 75";
BINDING_NAME_FLEXACTIONBUTTON76 = "FlexBar Button 76";
BINDING_NAME_FLEXACTIONBUTTON77 = "FlexBar Button 77";
BINDING_NAME_FLEXACTIONBUTTON78 = "FlexBar Button 78";
BINDING_NAME_FLEXACTIONBUTTON79 = "FlexBar Button 79";
BINDING_NAME_FLEXACTIONBUTTON80 = "FlexBar Button 80";
BINDING_NAME_FLEXACTIONBUTTON81 = "FlexBar Button 81";
BINDING_NAME_FLEXACTIONBUTTON82 = "FlexBar Button 82";
BINDING_NAME_FLEXACTIONBUTTON83 = "FlexBar Button 83";
BINDING_NAME_FLEXACTIONBUTTON84 = "FlexBar Button 84";
BINDING_NAME_FLEXACTIONBUTTON85 = "FlexBar Button 85";
BINDING_NAME_FLEXACTIONBUTTON86 = "FlexBar Button 86";
BINDING_NAME_FLEXACTIONBUTTON87 = "FlexBar Button 87";
BINDING_NAME_FLEXACTIONBUTTON88 = "FlexBar Button 88";
BINDING_NAME_FLEXACTIONBUTTON89 = "FlexBar Button 89";
BINDING_NAME_FLEXACTIONBUTTON90 = "FlexBar Button 90";
BINDING_NAME_FLEXACTIONBUTTON91 = "FlexBar Button 91";
BINDING_NAME_FLEXACTIONBUTTON92 = "FlexBar Button 92";
BINDING_NAME_FLEXACTIONBUTTON93 = "FlexBar Button 93";
BINDING_NAME_FLEXACTIONBUTTON94 = "FlexBar Button 94";
BINDING_NAME_FLEXACTIONBUTTON95 = "FlexBar Button 95";
BINDING_NAME_FLEXACTIONBUTTON96 = "FlexBar Button 96";
BINDING_HEADER_FLEXBAR_EVENTS = "FlexBar Events";
BINDING_NAME_FLEXACTIONBUTTON97 = "FlexBar Button 97";
BINDING_NAME_FLEXACTIONBUTTON98 = "FlexBar Button 98";
BINDING_NAME_FLEXACTIONBUTTON99 = "FlexBar Button 99";
BINDING_NAME_FLEXACTIONBUTTON100 = "FlexBar Button 100";
BINDING_NAME_FLEXACTIONBUTTON101 = "FlexBar Button 101";
BINDING_NAME_FLEXACTIONBUTTON102 = "FlexBar Button 102";
BINDING_NAME_FLEXACTIONBUTTON103 = "FlexBar Button 103";
BINDING_NAME_FLEXACTIONBUTTON104 = "FlexBar Button 104";
BINDING_NAME_FLEXACTIONBUTTON105 = "FlexBar Button 105";
BINDING_NAME_FLEXACTIONBUTTON106 = "FlexBar Button 106";
BINDING_NAME_FLEXACTIONBUTTON107 = "FlexBar Button 107";
BINDING_NAME_FLEXACTIONBUTTON108 = "FlexBar Button 108";
BINDING_NAME_FLEXACTIONBUTTON109 = "FlexBar Button 109";
BINDING_NAME_FLEXACTIONBUTTON110 = "FlexBar Button 110";
BINDING_NAME_FLEXACTIONBUTTON111 = "FlexBar Button 111";
BINDING_NAME_FLEXACTIONBUTTON112 = "FlexBar Button 112";
BINDING_NAME_FLEXACTIONBUTTON113 = "FlexBar Button 113";
BINDING_NAME_FLEXACTIONBUTTON114 = "FlexBar Button 114";
BINDING_NAME_FLEXACTIONBUTTON115 = "FlexBar Button 115";
BINDING_NAME_FLEXACTIONBUTTON116 = "FlexBar Button 116";
BINDING_NAME_FLEXACTIONBUTTON117 = "FlexBar Button 117";
BINDING_NAME_FLEXACTIONBUTTON118 = "FlexBar Button 118";
BINDING_NAME_FLEXACTIONBUTTON119 = "FlexBar Button 119";
BINDING_NAME_FLEXACTIONBUTTON120 = "FlexBar Button 120";
BINDING_NAME_FLEXBAREVENT1 = "FlexBar Event 1";
BINDING_NAME_FLEXBAREVENT2 = "FlexBar Event 2";
BINDING_NAME_FLEXBAREVENT3 = "FlexBar Event 3";
BINDING_NAME_FLEXBAREVENT4 = "FlexBar Event 4";
BINDING_NAME_FLEXBAREVENT5 = "FlexBar Event 5";
BINDING_NAME_FLEXBAREVENT6 = "FlexBar Event 6";
BINDING_NAME_FLEXBAREVENT7 = "FlexBar Event 7";
BINDING_NAME_FLEXBAREVENT8 = "FlexBar Event 8";
BINDING_NAME_FLEXBAREVENT9 = "FlexBar Event 9";
BINDING_NAME_FLEXBAREVENT10 = "FlexBar Event 10";
BINDING_NAME_FLEXBAREVENT11 = "FlexBar Event 11";
BINDING_NAME_FLEXBAREVENT12 = "FlexBar Event 12";
BINDING_NAME_FLEXBAREVENT13 = "FlexBar Event 13";
BINDING_NAME_FLEXBAREVENT14 = "FlexBar Event 14";
BINDING_NAME_FLEXBAREVENT15 = "FlexBar Event 15";
BINDING_NAME_FLEXBAREVENT16 = "FlexBar Event 16";
BINDING_NAME_FLEXBAREVENT17 = "FlexBar Event 17";
BINDING_NAME_FLEXBAREVENT18 = "FlexBar Event 18";
BINDING_NAME_FLEXBAREVENT19 = "FlexBar Event 19";
BINDING_NAME_FLEXBAREVENT20 = "FlexBar Event 20";
BINDING_NAME_FLEXBAREVENT21 = "FlexBar Event 21";
BINDING_NAME_FLEXBAREVENT22 = "FlexBar Event 22";
BINDING_NAME_FLEXBAREVENT23 = "FlexBar Event 23";
BINDING_NAME_FLEXBAREVENT24 = "FlexBar Event 24";
BINDING_NAME_FLEXBAREVENT25 = "FlexBar Event 25";
BINDING_NAME_FLEXBAREVENT26 = "FlexBar Event 26";
BINDING_NAME_FLEXBAREVENT27 = "FlexBar Event 27";
BINDING_NAME_FLEXBAREVENT28 = "FlexBar Event 28";
BINDING_NAME_FLEXBAREVENT29 = "FlexBar Event 29";
BINDING_NAME_FLEXBAREVENT30 = "FlexBar Event 30";
