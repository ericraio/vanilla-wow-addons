function DAB_ActionButton_Collapse(button, bar)
	if (button.collapsed) then return; end
	if ((not bar) or bar=="F") then return; end
	if (not DAB_Settings[DAB_INDEX].Bar[bar].collapse) then return; end
	if (not button:GetParent().initialized) then return; end
	button.collapsed = true;
	local loc = button:GetParent().buttonLocation[button:GetID()].loc;
	local row = button:GetParent().buttonLocation[button:GetID()].row;
	button:ClearAllPoints();
	if (loc == 1 and row == 1) then
		button:SetPoint("TOPRIGHT", button:GetParent(), "TOPLEFT", DAB_Settings[DAB_INDEX].Bar[bar].Background.leftpadding - DAB_Settings[DAB_INDEX].Bar[bar].hspacing, -DAB_Settings[DAB_INDEX].Bar[bar].Background.toppadding);
	elseif (button.yoffset) then
		button:SetPoint("TOPRIGHT", button:GetParent(), "TOPLEFT", DAB_Settings[DAB_INDEX].Bar[bar].Background.leftpadding - DAB_Settings[DAB_INDEX].Bar[bar].hspacing, -button.yoffset);
	elseif (loc > 1) then
		button:SetPoint("LEFT", "DAB_ActionButton_"..button:GetParent().rows[row][loc - 1], "LEFT", 0, 0);
	end
	DAB_Bar_Size(bar);
end

function DAB_ActionButton_FauxHide(id)
	local button = getglobal("DAB_ActionButton_"..id);
	--if (button.fauxhidden) then return; end
	local bar = DAB_Settings[DAB_INDEX].Buttons[id].Bar;
	button.hidden = true;
	button.fauxhidden = true;
	button:SetAlpha(0);
	button:EnableMouse(false);
	button:EnableMouseWheel(false);
	DAB_ActionButton_Collapse(button, bar);
end

function DAB_ActionButton_FauxShow(id)
	local button = getglobal("DAB_ActionButton_"..id);
	--if (not button.fauxhidden) then return; end
	local bar = DAB_Settings[DAB_INDEX].Buttons[id].Bar;
	button.hidden = nil;
	button.fauxhidden = nil;
	if (bar == "F" or (bar ~= "F" and (not getglobal("DAB_ActionBar_"..bar).fauxhidden))) then
		button:SetAlpha(1);
		button:EnableMouse(1);
		button:EnableMouseWheel(1);
		this = button;
		DAB_ActionButton_Update();
		DAB_ActionButton_UpdateState();
		DAB_ActionButton_UpdateCooldown(id);
		DAB_ActionButton_RestoreAlpha(id);
	end
	DAB_ActionButton_Uncollapse(button, bar);
end

function DAB_ActionButton_GetColor(id, num, r, g, b, manaRecolor, notEnoughMana, rangeRecolor, outOfRange, unusableRecolor, isUsable)
	if (this.colorOverride and this.colorOverride[num]) then
		return this.colorOverride[num].r, this.colorOverride[num].g, this.colorOverride[num].b;
	elseif (manaRecolor == num and notEnoughMana) then
		r, g, b = DAB_ActionButton_GetSetting(id, "manacolor", 1);
	elseif (rangeRecolor == num and outOfRange) then
		local target = DAB_ActionButton_GetSetting(id, "target");
		local force = DAB_ActionButton_GetSetting(id, "forceTarget")
		if (target and force and target ~= "target") then
			r = 1
			g = 1
			b = 1
		end
		r, g, b = DAB_ActionButton_GetSetting(id, "rangecolor", 1);
	elseif (unusableRecolor == num and (not isUsable)) then
		r, g, b = DAB_ActionButton_GetSetting(id, "unusablecolor", 1);
	end
	return r, g, b;
end

function DAB_ActionButton_GetSetting(id, index, colortoggle, subindex)
	local bar = DAB_Settings[DAB_INDEX].Buttons[id].Bar;
	if (bar == "F") then
		if (subindex) then
			if (colortoggle) then
				return DAB_Settings[DAB_INDEX].Floaters[id][index][subindex].r, DAB_Settings[DAB_INDEX].Floaters[id][index][subindex].g, DAB_Settings[DAB_INDEX].Floaters[id][index][subindex].b;
			else
				return DAB_Settings[DAB_INDEX].Floaters[id][index][subindex];
			end
		else
			if (colortoggle) then
				return DAB_Settings[DAB_INDEX].Floaters[id][index].r, DAB_Settings[DAB_INDEX].Floaters[id][index].g, DAB_Settings[DAB_INDEX].Floaters[id][index].b;
			else
				return DAB_Settings[DAB_INDEX].Floaters[id][index];
			end
		end
	else
		if (subindex) then
			if (colortoggle) then
				return DAB_Settings[DAB_INDEX].Bar[bar][index][subindex].r, DAB_Settings[DAB_INDEX].Bar[bar][index][subindex].g, DAB_Settings[DAB_INDEX].Bar[bar][index][subindex].b;
			else
				return DAB_Settings[DAB_INDEX].Bar[bar][index][subindex];
			end
		else
			if (colortoggle) then
				return DAB_Settings[DAB_INDEX].Bar[bar][index].r, DAB_Settings[DAB_INDEX].Bar[bar][index].g, DAB_Settings[DAB_INDEX].Bar[bar][index].b;
			else
				return DAB_Settings[DAB_INDEX].Bar[bar][index];
			end
		end
	end
end

function DAB_ActionButton_OnClick(id, mousebutton, kboverride, selfCast, actionoverride)
	local bar = DAB_Settings[DAB_INDEX].Buttons[id].Bar;
	local button = getglobal("DAB_ActionButton_"..id);
	if (button.disabled) then return; end
	local action = button:GetActionID();

	if (button.moving or button:GetParent().moving) then
		DAB_ActionButton_OnDragStop();
	end

	if (not kboverride) then
		if (bar == "F") then
			DAB_Run_Script("OnClickBefore", "Floaters", id, mousebutton);
		else
			DAB_Run_Script("OnClickBefore", "Bar", bar, mousebutton);
		end
	end

	local rightclick, middleclick, target, hideonclick, autoattack, forcetarget, petattack, hadTarget;

	if (bar == "F") then
		target = DAB_Settings[DAB_INDEX].Floaters[id].target;
		hideonclick = DAB_Settings[DAB_INDEX].Floaters[id].hideonclick;
		rightclick = DAB_Settings[DAB_INDEX].Floaters[id].rightClick;
		middleclick = DAB_Settings[DAB_INDEX].Floaters[id].middleClick;
		autoattack = DAB_Settings[DAB_INDEX].Floaters[id].autoAttack;
		petattack = DAB_Settings[DAB_INDEX].Floaters[id].petAutoAttack;
		forcetarget = DAB_Settings[DAB_INDEX].Floaters[id].forceTarget;
	else
		if (DAB_Settings[DAB_INDEX].Bar[bar].rightClick > 0) then
			rightclick = DAB_Get_MatchingButton(bar, id, DAB_Settings[DAB_INDEX].Bar[bar].rightClick);
			rightclick = DAB_Settings[DAB_INDEX].Buttons[rightclick].action;
		else
			rightclick = DAB_Settings[DAB_INDEX].Bar[bar].rightClick;
		end
		if (DAB_Settings[DAB_INDEX].Bar[bar].middleClick > 0) then
			middleclick = DAB_Get_MatchingButton(bar, id, DAB_Settings[DAB_INDEX].Bar[bar].middleClick);
			middleclick = DAB_Settings[DAB_INDEX].Buttons[middleclick].action;
		else
			middleclick = DAB_Settings[DAB_INDEX].Bar[bar].middleClick;
		end
		target = DAB_Settings[DAB_INDEX].Bar[bar].target;
		hideonclick = DAB_Settings[DAB_INDEX].Bar[bar].hideonclick;
		autoattack = DAB_Settings[DAB_INDEX].Bar[bar].autoAttack;
		petattack = DAB_Settings[DAB_INDEX].Bar[bar].petAutoAttack;
		forcetarget = DAB_Settings[DAB_INDEX].Bar[bar].forceTarget;
		if (getglobal("DAB_ActionBar_"..bar).targetOverride) then
			target = getglobal("DAB_ActionBar_"..bar).targetOverride;
			forcetarget = true;
		end
	end

	if ( DAB_Check_ModifierKey(DAB_Settings[DAB_INDEX].ButtonLockOverride) and (not kboverride) ) then
		PickupAction(action);
	else
		if (petattack) then
			DL_PetAttack();
		end
		if ( MacroFrame_SaveMacro ) then
			MacroFrame_SaveMacro();
		end
		if (mousebutton == "RightButton" and rightclick) then
			if (rightclick == -2) then
				selfCast = 1;
			else
				action = rightclick;
			end
		elseif (mousebutton == "MiddleButton" and middleclick) then
			if (middleclick == -2) then
				selfCast = 1;
			else
				action = middleclick;
			end
		end
		if (actionoverride) then
			action = actionoverride;
		end

		if (not IsAttackAction(action)) then
			if (autoattack) then
				DL_AttackTarget();
			end
		end

		if (((not kboverride) and DAB_Check_ModifierKey(DAB_Settings[DAB_INDEX].SelfCast)) or selfCast) then
			target = "player";
			forcetarget = true;
		end

		if (button.targetOverride) then
			target = button.targetOverride;
			forcetarget = true;
		end

		if ((not UnitCanAttack("player", "target")) and forcetarget) then
			hadTarget = true;
		end

		if (target and forcetarget and hadTarget) then
			TargetUnit(target);
		elseif (target and forcetarget and string.find(DAB_Get_ActionName(action), DAB_DISPELMAGIC)) then
			hadTarget = true;
			TargetUnit(target);
		end

		if (action > 0) then
			local checkCursor;
			if (not kboverride) then checkCursor = 1; end
			UseAction(action, checkCursor);
		end

		if (hadTarget and target and forcetarget) then
			TargetLastTarget();
		elseif (SpellIsTargeting() and target) then
			SpellTargetUnit(target);
		end

		if (hideonclick) then
			if (bar == "F") then
				DAB_ActionButton_FauxHide(id);
			else
				DAB_Bar_FauxHide(bar);
			end
		end
	end

	if (kboverride == 1) then
		button.keydown = 1;
	elseif (kboverride) then
		button.keydown = nil;
	end
	if (not actionoverride) then
		button:SetChecked(1);
		button.clicked = .2;
	end

	if (not kboverride) then
		if (bar == "F") then
			DAB_Run_Script("OnClickAfter", "Floaters", id, mousebutton);
		else
			DAB_Run_Script("OnClickAfter", "Bar", bar, mousebutton);
		end
	end
end

function DAB_ActionButton_OnDragStart()
	local bar = DAB_Settings[DAB_INDEX].Buttons[this:GetID()].Bar;
	if (DAB_DRAGGING_UNLOCKED or DAB_Check_ModifierKey(DAB_Settings[DAB_INDEX].DragLockOverride)) then
		if (bar == "F") then
			this.moving = true;
			getglobal("DAB_FloaterBox_"..this:GetID()):SetMovable(1);
			getglobal("DAB_FloaterBox_"..this:GetID()):StartMoving();
		elseif (bar) then
			DAB_Bar_OnDragStart(bar);
		end
	else
		if (bar == "F") then
			if (DAB_Settings[DAB_INDEX].Floaters[this:GetID()].buttonLocked) then return; end
		else
			if (DAB_Settings[DAB_INDEX].Bar[bar].buttonsLocked) then return; end
		end
		PickupAction(this:GetActionID());
	end
end

function DAB_ActionButton_OnDragStop()
	local id = this:GetID();
	local bar = DAB_Settings[DAB_INDEX].Buttons[id].Bar;
	if (bar == "F") then
		this.moving = nil;
		getglobal("DAB_FloaterBox_"..this:GetID()):StopMovingOrSizing();
		local settings = DAB_Settings[DAB_INDEX].Floaters[id].Anchor;
		local x, y = DL_Get_Offsets(getglobal("DAB_FloaterBox_"..this:GetID()), getglobal(settings.frame), settings.point, settings.to);
		settings.x = x;
		settings.y = y;
		DAB_Floater_Location(id);
		if (DAB_Options and DAB_OBJECT_SUBINDEX == id) then
			DL_Init_EditBox(DAB_FloaterOptions_Config_XOffset, x);
			DL_Init_EditBox(DAB_FloaterOptions_Config_YOffset, y);
		end
	elseif (bar) then
		DAB_Bar_OnDragStop(bar);
	end
end

function DAB_ActionButton_OnEnter()
	local button = this;
	if (not button) then return; end
	local id = button:GetID();
	local bar = DAB_Settings[DAB_INDEX].Buttons[id].Bar;
	local action = button:GetActionID();
	if (bar == "F") then
		DAB_ControlBox_Delay(DAB_Settings[DAB_INDEX].Floaters[id].cbgroup);
	elseif (bar) then
		DAB_ControlBox_Delay(DAB_Settings[DAB_INDEX].Bar[bar].cbgroup);
	end
	if (bar == "F") then
		DAB_Run_Script("OnEnter", "Floaters", id);
	else
		DAB_Run_Script("OnEnter", "Bar", bar);
	end
	if (bar ~= "F" and DAB_Settings[DAB_INDEX].Bar[bar].disableTooltips) then return; end
	if (bar == "F" and DAB_Settings[DAB_INDEX].Floaters[id].disableTooltip) then return; end
	if ( GetCVar("UberTooltips") == "1" ) then
		GameTooltip_SetDefaultAnchor(GameTooltip, button);
	else
		GameTooltip:SetOwner(button, "ANCHOR_RIGHT");
	end

	if ( GameTooltip:SetAction(action) ) then
		button.updateTooltip = TOOLTIP_UPDATE_TIME;
	else
		button.updateTooltip = nil;
	end

	if (DAB_Settings[DAB_INDEX].ModifyTooltip) then
		GameTooltip:AddLine(DAB_TEXT.ButtonID..id.."     "..DAB_TEXT.ActionID..action, .6, .6, .6, .6, .6, .6);
		GameTooltip:SetHeight(GameTooltip:GetHeight() + 15);
		if (GameTooltip:GetWidth() < 200) then
			GameTooltip:SetWidth(200);
		end
	end
end

function DAB_ActionButton_OnEvent(event)
	if (DAB_INITIALIZED and DAB_Settings[DAB_INDEX].Buttons[this:GetID()].Bar) then
		local bar = DAB_Settings[DAB_INDEX].Buttons[this:GetID()].Bar;
		if (bar == "F") then
			DAB_Run_Script("OnEvent", "Floaters", this:GetID(), event);
		elseif (not bar) then
			return;
		end
	else
		return;
	end

	if ( event == "ACTIONBAR_SLOT_CHANGED" ) then
		if ( arg1 == -1 or arg1 == this:GetActionID() ) then
			DAB_ActionButton_Update();
		end
	elseif ( event == "PLAYER_AURAS_CHANGED" ) then
		DAB_ActionButton_Update();
		DAB_ActionButton_UpdateState();
		return;
	elseif ( event == "UPDATE_BONUS_ACTIONBAR" ) then
		DAB_ActionButton_Update();
		DAB_ActionButton_UpdateState();
		return;
	end

	if ( this.hidden or this.fauxhidden) then return; end

	if ( event == "UNIT_INVENTORY_CHANGED" ) then
		if ( arg1 == "player" ) then
			DAB_ActionButton_Update();
		end
	elseif ( event == "ACTIONBAR_UPDATE_STATE" ) then
		DAB_ActionButton_UpdateState();
	elseif ( event == "ACTIONBAR_UPDATE_USABLE" or event == "UPDATE_INVENTORY_ALERTS" or event == "ACTIONBAR_UPDATE_COOLDOWN" ) then
		DAB_ActionButton_UpdateCooldown(this:GetID());
	elseif ( event == "CRAFT_SHOW" or event == "CRAFT_CLOSE" or event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_CLOSE" ) then
		DAB_ActionButton_UpdateState();
	elseif ( event == "PLAYER_ENTER_COMBAT" ) then
		IN_ATTACK_MODE = 1;
		if ( IsAttackAction(this:GetActionID()) ) then
			DAB_ActionButton_StartFlash();
		end
	elseif ( event == "PLAYER_LEAVE_COMBAT" ) then
		IN_ATTACK_MODE = nil;
		if ( IsAttackAction(this:GetActionID()) ) then
			DAB_ActionButton_StopFlash();
		end
	elseif ( event == "START_AUTOREPEAT_SPELL" ) then
		IN_AUTOREPEAT_MODE = 1;
		if ( IsAutoRepeatAction(this:GetActionID()) ) then
			DAB_ActionButton_StartFlash();
		end
	elseif ( event == "STOP_AUTOREPEAT_SPELL" ) then
		IN_AUTOREPEAT_MODE = nil;
		if ( this.flashing == 1 and (not IsAttackAction(this:GetActionID())) ) then
			DAB_ActionButton_StopFlash();
		end
	end
end

function DAB_ActionButton_Hide(id)
	if (not DAB_INITIALIZED) then return; end
	local button = getglobal("DAB_ActionButton_"..id);
	button.hidden = true;
	button:Hide();
	button.cooldowncount = nil;
	button.ccountlocked = nil;
	local bar = DAB_Settings[DAB_INDEX].Buttons[id].Bar;
	if (bar) then
		DAB_ActionButton_Collapse(button, bar);
	end
end

function DAB_ActionButton_OnLeave()
	this.updateTooltip = nil;
	GameTooltip:Hide();
	local bar = DAB_Settings[DAB_INDEX].Buttons[this:GetID()].Bar;
	if (bar == "F") then
		DAB_ControlBox_Delay(DAB_Settings[DAB_INDEX].Floaters[this:GetID()].cbgroup, 1);
		DAB_Run_Script("OnLeave", "Floaters", this:GetID());
	elseif (bar) then
		DAB_ControlBox_Delay(DAB_Settings[DAB_INDEX].Bar[bar].cbgroup, 1);
		DAB_Run_Script("OnLeave", "Bar", bar);
	end
end

function DAB_ActionButton_OnLoad()
	this.flashing = 0;
	this.flashtime = 0;
	this:RegisterForDrag("LeftButton", "RightButton");
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up");
	this:RegisterEvent("ACTIONBAR_SLOT_CHANGED");
	this:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
	this:RegisterEvent("ACTIONBAR_UPDATE_STATE");
	this:RegisterEvent("ACTIONBAR_UPDATE_USABLE");
	this:RegisterEvent("CRAFT_CLOSE");
	this:RegisterEvent("CRAFT_SHOW");
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
	this:RegisterEvent("PLAYER_ENTER_COMBAT");
	this:RegisterEvent("PLAYER_LEAVE_COMBAT");
	this:RegisterEvent("START_AUTOREPEAT_SPELL");
	this:RegisterEvent("STOP_AUTOREPEAT_SPELL");
	this:RegisterEvent("TRADE_SKILL_CLOSE");
	this:RegisterEvent("TRADE_SKILL_SHOW");
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	this:RegisterEvent("UPDATE_BINDINGS");
	this:RegisterEvent("UPDATE_BONUS_ACTIONBAR");
	this:RegisterEvent("UPDATE_INVENTORY_ALERTS");
	this.activeConditions = {};
	this.GetActionID = function(frame)
		return DAB_Settings[DAB_INDEX].Buttons[frame:GetID()].action;
	end
end

function DAB_ActionButton_OnMouseWheel(direction)
	local bar = DAB_Settings[DAB_INDEX].Buttons[this:GetID()].Bar;
	if (bar == "F") then
		DAB_Run_Script("OnMouseWheel", "Floaters", this:GetID(), direction);
	elseif (bar) then
		DAB_Run_Script("OnMouseWheel", "Bar", bar, direction);
	end
	if (bar == "F") then return; end
	if (DAB_Settings[DAB_INDEX].Bar[bar].disableMW) then return; end
	local page = DAB_Settings[DAB_INDEX].Bar[bar].page;
	if (direction > 0) then
		DAB_Bar_PageDown(bar);
	else
		DAB_Bar_PageUp(bar);
	end
end

function DAB_ActionButton_OnReceiveDrag()
	PlaceAction(this:GetActionID());
	this:SetChecked(0);
	DAB_ActionButton_UpdateState();
end

function DAB_ActionButton_SetTarget(buttonID, unit)
	local button = getglobal("DAB_ActionButton_"..buttonID);
	if (button) then
		button.targetOverride = unit;
	end
end

function DAB_ActionButton_SetText(buttonID, text)
	local button = getglobal("DAB_ActionButton_"..buttonID);
	if (button) then
		button.textOverride = text;
		if (text) then
			getglobal("DAB_ActionButton_"..buttonID.."_Name"):SetText(text);
		else
			getglobal("DAB_ActionButton_"..buttonID.."_Name"):SetText(GetActionText(button:GetActionID()));
		end
	end
end

function DAB_ActionButton_Show(id)
	if (not DAB_INITIALIZED) then return; end
	local button = getglobal("DAB_ActionButton_"..id);
	local bar = DAB_Settings[DAB_INDEX].Buttons[id].Bar;
	button.hidden = nil;
	button:Show();
	if (bar and bar ~="F") then
		DAB_ActionButton_Uncollapse(button, bar);
	end
end

function DAB_ActionButton_OnUpdate(elapsed)
	if (not DAB_INITIALIZED) then return; end

	local id = this:GetID();
	local action = this:GetActionID();
	if (this.clicked) then
		this.clicked = this.clicked - elapsed;
		if (this.clicked < 0) then
			this.clicked = nil;
			DAB_ActionButton_UpdateState();
		end
	elseif (this:GetChecked()) then
		DAB_ActionButton_UpdateState();
	end

	if (DAB_SHOWING_EMPTY) then return; end

	if (not HasAction(action)) then return; end
	if (not DAB_Settings[DAB_INDEX].Buttons[id].Bar) then return; end

	if ( this.flashing == 1 and (not this.fauxhidden)) then
		this.flashtime = this.flashtime - elapsed;
		if ( this.flashtime <= 0 ) then
			local overtime = -this.flashtime;
			if ( overtime >= ATTACK_BUTTON_FLASH_TIME ) then
				overtime = 0;
			end
			this.flashtime = ATTACK_BUTTON_FLASH_TIME - overtime;

			local flashTexture = getglobal(this:GetName().."_Flash");
			if ( flashTexture:IsShown() ) then
				flashTexture:Hide();
			else
				flashTexture:Show();
			end
		end
	end

	if (this.blinking and (not this.fauxhidden)) then
		this.blinktime = this.blinktime - elapsed;
		if (this.blinktime < 0) then
			this.blinktime = .5;
			if (this.direction) then
				this.direction = nil;
			else
				this.direction = true;
			end
		end
		if (this.direction) then
			this:SetAlpha(1 - this.blinktime);
		else
			this:SetAlpha(this.blinktime + .5);
		end
	end

	if (this.timetohide) then
		this.timetohide = this.timetohide - elapsed;
		if (this.timetohide < 0) then
			this.timetohide = nil;
			DAB_Floater_Hide(id);
		end
	end

	if ( this.rangeTimer and (not this.fauxhidden)) then
		if ( this.rangeTimer < 0 ) then
			local isUsable, notEnoughMana = IsUsableAction(action);
			local outOfRange;
			if (IsActionInRange(action) == 0) then
				outOfRange = true;
			end

			local manaRecolor = DAB_ActionButton_GetSetting(id, "manarecolor");
			local unusableRecolor = DAB_ActionButton_GetSetting(id, "unusablerecolor");
			local rangeRecolor = DAB_ActionButton_GetSetting(id, "rangerecolor");

			if (manaRecolor == 1 or unusableRecolor == 1 or rangeRecolor == 1) then
				local r, g, b = 1, 1, 1;
				r, g, b = DAB_ActionButton_GetColor(id, 1, r, g, b, manaRecolor, notEnoughMana, rangeRecolor, outOfRange, unusableRecolor, isUsable);
				getglobal(this:GetName().."_Icon"):SetVertexColor(r, g, b);
			end

			if (manaRecolor == 2 or unusableRecolor == 2 or rangeRecolor == 2) then
				local r, g, b = DAB_ActionButton_GetSetting(this:GetID(), "ButtonBorder", 1, "color");
				r, g, b = DAB_ActionButton_GetColor(id, 2, r, g, b, manaRecolor, notEnoughMana, rangeRecolor, outOfRange, unusableRecolor, isUsable);
				getglobal(this:GetName().."_Border"):SetVertexColor(r, g, b);
			end

			if (manaRecolor == 3 or unusableRecolor == 3 or rangeRecolor == 3) then
				local r, g, b = DAB_ActionButton_GetSetting(this:GetID(), "Keybinding", 1, "color");
				r, g, b = DAB_ActionButton_GetColor(id, 3, r, g, b, manaRecolor, notEnoughMana, rangeRecolor, outOfRange, unusableRecolor, isUsable);
				getglobal(this:GetName().."_HotKey"):SetTextColor(r, g, b);
			end

			this.rangeTimer = TOOLTIP_UPDATE_TIME;
			if (this.clicked and (not this.keydown)) then
				if ( (not IsCurrentAction(action)) and (not IsAutoRepeatAction(action)) ) then
					this:SetChecked(0);
					this.clicked = nil;
				end
			end
		else
			this.rangeTimer = this.rangeTimer - elapsed;
		end
	end

	if (this.cooldowncount) then
		this.cooldowncount = this.cooldowncount - elapsed;
		if (this.cooldowncount <= 0) then
			this.cooldowncount = nil;
			this.clicked = nil;
			getglobal(this:GetName().."_CooldownCount"):SetText("");
			getglobal(this:GetName().."_Timer"):SetText("");
			if (this.ccountlocked) then
				this.ccountlocked = nil;
				DAB_ActionButton_UpdateCooldown(id);
			end
		else
			local count = math.ceil(this.cooldowncount);
			local cctext;
			if (this.ccountlocked) then
				cctext = getglobal(this:GetName().."_Timer");
				getglobal(this:GetName().."_CooldownCount"):SetText("");
			else
				cctext = getglobal(this:GetName().."_CooldownCount");
				getglobal(this:GetName().."_Timer"):SetText("");
			end
			if (DAB_Settings[DAB_INDEX].CDFormat == 1) then
				if (count < 60) then
					cctext:SetText(count);
				else
					count = math.ceil(count / 60);
					cctext:SetText(count.."m");
				end
			elseif (DAB_Settings[DAB_INDEX].CDFormat == 2) then
				cctext:SetText(count);
			else
				local min = math.floor(count / 60);
				local sec = count - min * 60;
				if (min < 10) then
					min = "0"..min;
				end
				if (sec < 10) then
					sec = "0"..sec;
				end
				cctext:SetText(min..":"..sec);
			end
		end
	end

	if (not this.updatetimer) then this.updatetimer = DAB_UPDATE_SPEED; end
	this.updatetimer = this.updatetimer - elapsed;
	if (this.updatetimer < 0) then
		this.updatetimer = DAB_UPDATE_SPEED;

		if (DAB_Settings[DAB_INDEX].Buttons[id].Bar == "F") then
			if (not this.lasttime) then this.lasttime = GetTime(); end
			local timeelapsed = GetTime() - this.lasttime;
			this.lasttime = GetTime();
			DAB_Run_Script("OnUpdate", "Floaters", id, timeelapsed);
		end

		local condition, response;
		local conditions;
		local bar = DAB_Settings[DAB_INDEX].Buttons[id].Bar;
		if (bar == "F") then
			conditions = DAB_Settings[DAB_INDEX].Buttons[id].Conditions;
		else
			local page = DAB_Bar_GetRealPage(bar);
			conditions = DAB_Settings[DAB_INDEX].Bar[bar].pageconditions[page][this:GetParent().bttnpos[id]];
		end
		for i = 1, table.getn(conditions) do
			condition = conditions[i].condition;
			response = conditions[i].response;
			this = getglobal("DAB_ActionButton_"..id);
			local active;
			if (condition == 0) then
				active = true;
				this.activeConditions[i] = nil;
			elseif (condition == 9 or condition == 10) then
				active = DL_CheckCondition[condition](getglobal("DAB_FloaterBox_"..id));
			else
				active = DL_CheckCondition[condition](conditions[i]);
			end
			for _,override in conditions[i].overrides do
				if (this.activeConditions[override]) then
					active = nil;
					break;
				end
			end

			if (active and (not this.activeConditions[i]) and response ~= 0) then
				if (response == 2) then
					DAB_ActionButton_FauxHide(id);
				elseif (response == 3) then
					DAB_ActionButton_FauxShow(id);
				elseif (response == 4) then
					this:SetAlpha(conditions[i].alpha);
				elseif (response == 7) then
					getglobal(this:GetName().."_Border"):SetAlpha(conditions[i].alpha);
				elseif (response == 8) then
					if (not this.colorOverride) then
						this.colorOverride = {[2] = conditions[i].color};
					else
						this.colorOverride[2] = conditions[i].color;
					end
					getglobal(this:GetName().."_Border"):SetVertexColor( conditions[i].color.r, conditions[i].color.g, conditions[i].color.b );
				elseif (response == 11) then
					DAB_Floater_MoveUp(id, conditions[i].amount);
				elseif (response == 12) then
					DAB_Floater_MoveDown(id, conditions[i].amount);
				elseif (response == 13) then
					DAB_Floater_MoveLeft(id, conditions[i].amount);
				elseif (response == 14) then
					DAB_Floater_MoveRight(id, conditions[i].amount);
				elseif (response == 19) then
					DAB_Floater_Size(id, conditions[i].amount);
				elseif (response == 21) then
					local x, y = GetCursorPosition();
					x = x / UIParent:GetScale();
					y = y / UIParent:GetScale();
					DAB_Floater_Location(id, x, y, "UIParent", "CENTER", "BOTTOMLEFT");
				elseif (response == 22) then
					if (not this.colorOverride) then
						this.colorOverride = {[1] = conditions[i].color};
					else
						this.colorOverride[1] = conditions[i].color;
					end
					getglobal(this:GetName().."_Icon"):SetVertexColor( conditions[i].color.r, conditions[i].color.g, conditions[i].color.b );
				elseif (response == 23) then
					DAB_Floater_SetKeybinding(id, conditions[i].rnumber);
				elseif (response == 24) then
					this.blinking = true;
					this.blinkdirection = true;
					this.blinktime = .5;
				elseif (response == 25) then
					this.blinking = nil;
					this:SetAlpha(1);
				elseif (response == 26) then
					DAB_ActionButton_StartFlash();
					this.flashingoverride = 1;
				elseif (response == 27) then
					this.flashingoverride = nil;
					DAB_ActionButton_StopFlash();
				elseif (response == 28) then
					this.colorOverride = nil;
					getglobal(this:GetName().."_Icon"):SetVertexColor( 1, 1, 1 );
				elseif (response == 29) then
					DAB_ActionButton_SetAction(this:GetID(), conditions[i].raction);
				elseif (response == 30) then
					this.disabled = nil;
				elseif (response == 31) then
					this.disabled = true;
				elseif (response == 33) then
					DAB_ActionButton_SetTarget(this:GetID(), conditions[i].runit);
				elseif (response == 34) then
					DAB_ActionButton_SetTarget(this:GetID());
				elseif (response == 35) then
					DAB_Floater_Location(id, conditions[i].rx, conditions[i].ry);
				else
					DAB_Global_Response(response, conditions[i]);
				end
			end

			getglobal("DAB_ActionButton_"..id).activeConditions[i] = active;
		end
	end

	if ( not this.updateTooltip ) then return; end

	this.updateTooltip = this.updateTooltip - elapsed;
	if ( this.updateTooltip > 0 ) then return; end

	if ( GameTooltip:IsOwned(this) ) then
		DAB_ActionButton_OnEnter();
	else
		this.updateTooltip = nil;
	end
end

function DAB_ActionButton_RestoreAlpha(id)
	local texture = getglobal("DAB_ActionButton_"..id.."_Icon");
	local bar = DAB_Settings[DAB_INDEX].Buttons[id].Bar;
	local settings;
	if (bar == "F") then
		settings = DAB_Settings[DAB_INDEX].Floaters[id];
	else
		settings = DAB_Settings[DAB_INDEX].Bar[bar];
	end
	if (settings.ButtonBorder.alpha < 1) then
		getglobal("DAB_ActionButton_"..id.."_Border"):SetVertexColor(settings.ButtonBorder.color.r, settings.ButtonBorder.color.g, settings.ButtonBorder.color.b, settings.ButtonBorder.alpha);
	end
	if (settings.alpha == 1) then return; end
	getglobal("DAB_ActionButton_"..id.."_Icon"):SetVertexColor(1, 1, 1, settings.alpha);
	getglobal("DAB_ActionButton_"..id.."_Background"):SetVertexColor(settings.buttonbgcolor.r, settings.buttonbgcolor.g, settings.buttonbgcolor.b, settings.alpha);
	getglobal("DAB_ActionButton_"..id.."_Checked"):SetVertexColor(settings.checkedcolor.r, settings.checkedcolor.g, settings.checkedcolor.b, settings.alpha);
	getglobal("DAB_ActionButton_"..id.."_EquippedBorder"):SetVertexColor(settings.ButtonBorder.ecolor.r, settings.ButtonBorder.ecolor.g, settings.ButtonBorder.ecolor.b, settings.alpha);
end

function DAB_ActionButton_SetAction(id, action)
	if (DAB_Settings[DAB_INDEX].Buttons[id].action == action) then return; end
	local bar = DAB_Settings[DAB_INDEX].Buttons[id].Bar;
	DAB_Settings[DAB_INDEX].Buttons[id].action = action;
	if (bar ~= "F") then
		local page = DAB_Settings[DAB_INDEX].Bar[bar].page;
		local loc = getglobal("DAB_ActionBar_"..bar).bttnpos[id];
		DAB_Settings[DAB_INDEX].Bar[bar].pages[page][loc] = action;
	end
	DAB_ActionButton_Update(id);
end

function DAB_ActionButton_SetTimer(id, cdtime)
	local button = getglobal("DAB_ActionButton_"..id);
	getglobal("DAB_ActionButton_"..id.."_CooldownCount"):SetText("");
	button.cooldowncount = cdtime;
	button.ccountlocked = true;
end

function DAB_ActionButton_StartFlash()
	this.flashing = 1;
	this.flashtime = 0;
	DAB_ActionButton_UpdateState();
end

function DAB_ActionButton_StopFlash()
	if (this.flashingoverride) then return; end
	this.flashing = 0;
	getglobal(this:GetName().."_Flash"):Hide();
	DAB_ActionButton_UpdateState();
end

function DAB_ActionButton_Uncollapse(button, bar)
	if (bar == "F") then return; end
	if (not button.collapsed) then return; end
	if (not button:GetParent().initialized) then return; end
	button.collapsed = nil;
	local loc = button:GetParent().buttonLocation[button:GetID()].loc;
	local row = button:GetParent().buttonLocation[button:GetID()].row;
	button:ClearAllPoints();
	if (loc == 1 and row == 1) then
		button:SetPoint("TOPLEFT", button:GetParent(), "TOPLEFT", DAB_Settings[DAB_INDEX].Bar[bar].Background.leftpadding, -DAB_Settings[DAB_INDEX].Bar[bar].Background.toppadding);
	elseif (button.yoffset) then
		button:SetPoint("TOPLEFT", button:GetParent(), "TOPLEFT", DAB_Settings[DAB_INDEX].Bar[bar].Background.leftpadding, -button.yoffset);
	elseif (loc > 1) then
		button:SetPoint("LEFT", "DAB_ActionButton_"..button:GetParent().rows[row][loc - 1], "RIGHT", DAB_Settings[DAB_INDEX].Bar[bar].hspacing, 0);
	end
	button:SetWidth(36);
	DAB_Bar_Size(bar);
end

function DAB_ActionButton_Update(id)
	if (not DAB_INITIALIZED) then return; end
	local button, buttonName;
	if (id) then
		buttonName = "DAB_ActionButton_"..id;
		button = getglobal(buttonName);
	else
		id = this:GetID();
		button = this;
		buttonName = this:GetName();
	end

	local resetthis
	if (this:GetName() == "ChatFrameEditBox") then
		resetthis = 1
	end

	local action = button:GetActionID();
	local icon = getglobal(buttonName.."_Icon");
	local texture = GetActionTexture(action);

	this = button;
	DAB_ActionButton_UpdateCount();
	if ( HasAction(action) ) then
		if (texture == "" or (not texture)) then
			icon:SetTexture("");
			icon:Hide();
		else
			icon:SetTexture(texture);
			icon:Show();
		end
		button.rangeTimer = TOOLTIP_UPDATE_TIME;
		DAB_ActionButton_UpdateCooldown(id);
	else
		icon:SetTexture("");
		icon:Hide();
	end

	local eborder = getglobal(buttonName.."_EquippedBorder");
	if (IsEquippedAction(action)) then
		eborder:Show();
	else
		eborder:Hide();
	end

	if ( IsAttackAction(action) and IsCurrentAction(action) ) then
		IN_ATTACK_MODE = 1;
	else
		IN_ATTACK_MODE = nil;
	end
	IN_AUTOREPEAT_MODE = IsAutoRepeatAction(action);
	if ( IN_ATTACK_MODE or IN_AUTOREPEAT_MODE ) then
		DAB_ActionButton_StartFlash();
	else
		DAB_ActionButton_StopFlash();
	end

	if ( GameTooltip:IsOwned(button) ) then
		DAB_ActionButton_OnEnter();
	else
		button.updateTooltip = nil;
	end
	
	if (DAB_SHOWING_IDS) then
		if (DAB_SHOWING_ACTIONIDS) then
			getglobal(buttonName.."_Name"):SetText("A "..action);
		else
			getglobal(buttonName.."_Name"):SetText(id);
		end
	elseif (button.textOverride) then
		getglobal(buttonName.."_Name"):SetText(button.textOverride);
	else
		getglobal(buttonName.."_Name"):SetText(GetActionText(action));
	end

	if (not HasAction(action)) then
		local bar = DAB_Settings[DAB_INDEX].Buttons[id].Bar;
		if (bar and bar ~= "F") then
			if (DAB_Settings[DAB_INDEX].Bar[bar].hideEmpty) then
				if (not DAB_SHOWING_EMPTY) then
					DAB_ActionButton_Hide(id);
				else
					DAB_ActionButton_Show(id);
				end
			else
				DAB_ActionButton_Show(id);
			end
		end
	end

	this = button;
	if (resetthis) then
		this = ChatFrameEditBox
	end
end

function DAB_ActionButton_UpdateCooldown(id)
	if (not DAB_INITIALIZED) then return; end
	if (not id or id == 0) then return; end
	if (not DAB_Settings[DAB_INDEX].Buttons[id].Bar) then return; end
	local button = getglobal("DAB_ActionButton_"..id);
	local action = button:GetActionID();
	local cooldown = getglobal(button:GetName().."_Cooldown");
	local start, duration, enable = GetActionCooldown(action);
	CooldownFrame_SetTimer(cooldown, start, duration, enable);
	if (not DAB_SHOWING_IDS) then
		getglobal(button:GetName().."_CooldownCount"):SetText("");
	end
	if (button.ccountlocked) then return; end
	local cdcount, hideGlobal;
	if (DAB_Settings[DAB_INDEX].Buttons[id].Bar == "F") then
		cdcount = DAB_Settings[DAB_INDEX].Floaters[id].cooldownCount;
		hideGlobal = DAB_Settings[DAB_INDEX].Floaters[id].hideGlobalCD;
	else
		cdcount = DAB_Settings[DAB_INDEX].Bar[DAB_Settings[DAB_INDEX].Buttons[id].Bar].cooldownCount;
		hideGlobal = DAB_Settings[DAB_INDEX].Bar[DAB_Settings[DAB_INDEX].Buttons[id].Bar].hideGlobalCD;
	end
	if (cdcount) then
		if (start and start > 0) then
			local timeRemaining = duration - (GetTime() - start);
			if (((not button.cooldowncount) or button.cooldowncount == 0) and timeRemaining <= 2.5 and hideGlobal) then
				button.cooldowncount = 0;
			else
				button.cooldowncount = timeRemaining;
			end
		else
			button.cooldowncount = 0;
		end
	end
end

function DAB_ActionButton_UpdateCount()
	local text = getglobal(this:GetName().."_Count");
	local count = GetActionCount(this:GetActionID());
	if ( IsConsumableAction(this:GetActionID()) ) then
		text:SetText(count);
	else
		text:SetText("");
	end
end

function DAB_ActionButton_UpdateState()
	if (this.clicked) then return; end
	if ( IsCurrentAction(this:GetActionID()) or IsAutoRepeatAction(this:GetActionID()) ) then
		this:SetChecked(1);
	else
		this:SetChecked(0);
	end
end