function DAB_Floater_Hide(id)
	DAB_Settings[DAB_INDEX].Floaters[id].hide = 1;
	getglobal("DAB_ActionButton_"..id):Hide();
end

function DAB_Floater_Initialize(id)
	local settings = DAB_Settings[DAB_INDEX].Floaters[id];
	local buttonName = "DAB_ActionButton_"..id;
	local button = getglobal(buttonName);

	local text = getglobal(buttonName.."_HotKey");
	text:SetFont(settings.Keybinding.font, settings.Keybinding.size, "outline='NORMAL'");
	text:SetTextColor(settings.Keybinding.color.r, settings.Keybinding.color.g, settings.Keybinding.color.b, 1);
	if (settings.Keybinding.hide) then text:Hide(); else text:Show(); end
	text = getglobal(buttonName.."_Count");
	text:SetFont(settings.Count.font, settings.Count.size, "outline='NORMAL'");
	text:SetTextColor(settings.Count.color.r, settings.Count.color.g, settings.Count.color.b, 1);
	if (settings.Count.hide) then text:Hide(); else text:Show(); end
	text = getglobal(buttonName.."_CooldownCount");
	text:SetFont(settings.Cooldown.font, settings.Cooldown.size, "outline='NORMAL'");
	text:SetTextColor(settings.Cooldown.color.r, settings.Cooldown.color.g, settings.Cooldown.color.b, 1);
	if (settings.Cooldown.hide) then text:Hide(); else text:Show(); end
	text = getglobal(buttonName.."_Timer");
	text:SetFont(settings.Cooldown.font, settings.Cooldown.size, "outline='NORMAL'");
	text:SetTextColor(settings.Cooldown.color.r, settings.Cooldown.color.g, settings.Cooldown.color.b, 1);
	text = getglobal(buttonName.."_Name");
	text:SetFont(settings.Macro.font, settings.Macro.size, "outline='NORMAL'");
	text:SetTextColor(settings.Macro.color.r, settings.Macro.color.g, settings.Macro.color.b, 1);
	if (settings.Macro.hide) then text:Hide(); else text:Show(); end

	local icon = getglobal(buttonName.."_Icon");
	if (settings.trimEdges) then
		icon:SetTexCoord(.078, .92, .079, .937);
	else
		icon:SetTexCoord(0, 1, 0, 1);
	end
	icon:SetVertexColor(1, 1, 1, settings.alpha);
	background = getglobal(buttonName.."_Background");
	background:SetTexture(settings.buttonbg);
	background:SetVertexColor(settings.buttonbgcolor.r, settings.buttonbgcolor.g, settings.buttonbgcolor.b, settings.alpha);
	local checked = getglobal(buttonName.."_Checked");
	checked:SetTexture(settings.checked);
	checked:SetVertexColor(settings.checkedcolor.r, settings.checkedcolor.g, settings.checkedcolor.b, settings.alpha);
	local highlight = getglobal(buttonName.."_Highlight");
	highlight:SetTexture(settings.highlight);
	highlight:SetVertexColor(settings.highlightcolor.r, settings.highlightcolor.g, settings.highlightcolor.b, settings.alpha);
	local equipped = getglobal(buttonName.."_EquippedBorder");
	equipped:SetTexture(settings.ButtonBorder.etexture);
	equipped:SetVertexColor(settings.ButtonBorder.ecolor.r, settings.ButtonBorder.ecolor.g, settings.ButtonBorder.ecolor.b, settings.alpha);
	local border = getglobal(buttonName.."_Border");
	border:ClearAllPoints();
	border:SetPoint("TOPLEFT", button, "TOPLEFT", -settings.ButtonBorder.leftpadding, settings.ButtonBorder.toppadding);
	border:SetHeight(36 + settings.ButtonBorder.toppadding + settings.ButtonBorder.bottompadding);
	border:SetWidth(36 + settings.ButtonBorder.leftpadding + settings.ButtonBorder.rightpadding);
	border:SetVertexColor(settings.ButtonBorder.color.r, settings.ButtonBorder.color.g, settings.ButtonBorder.color.b, settings.ButtonBorder.alpha);

	button:SetParent(UIParent);
	button:SetFrameStrata(settings.frameStrata);
	local scale = settings.size / 36 * UIParent:GetScale();
	local cooldown = getglobal(buttonName.."_Cooldown");
	cooldown:SetFrameStrata(settings.frameStrata);
	cooldown:SetFrameLevel(button:GetFrameLevel() + 1);
	button:SetScale(scale);
	local box = getglobal("DAB_FloaterBox_"..id);
	button:ClearAllPoints();
	box:ClearAllPoints();
	button:SetPoint("CENTER", box, "CENTER", 0, 0);
	box:SetPoint(settings.Anchor.point, settings.Anchor.frame, settings.Anchor.to, settings.Anchor.x, settings.Anchor.y);
	box:SetHeight(settings.size);
	box:SetWidth(settings.size);

	button.hidden = nil;
	button.OOR = nil;
	button.OOM = nil;
	button.AUN = nil;

	if (settings.hide) then
		button.hidden = nil;
		button:Hide();
	else
		button.hidden = true;
		button:Show();
	end

	button.activeConditions = {};
	button.fauxhidden = 1;
	DAB_ActionButton_FauxShow(id);
end

function DAB_Floater_Location(id, x, y, frame, point, to)
	if (not id) then return; end
	local button = getglobal("DAB_ActionButton_"..id);
	if (not button) then
		DL_Error("Invalid button number sent to DAB_Floater_Location: "..id);
		return;
	elseif (not DAB_Settings[DAB_INDEX].Floaters[id]) then
		DL_Error("Invalid floater number sent to DAB_Floater_Location: "..id);
		return;
	elseif (point and (not DL_VALID_ANCHOR[point])) then
		DL_Error("Invalid anchor point sent to DAB_Floater_Location: "..point);
		return;
	elseif (to and (not DL_VALID_ANCHOR[to])) then
		DL_Error("Invalid anchor to sent to DAB_Floater_Location: "..to);
		return;
	end
	if (not x) then x = DAB_Settings[DAB_INDEX].Floaters[id].Anchor.x; end
	if (not y) then y = DAB_Settings[DAB_INDEX].Floaters[id].Anchor.y; end
	if (not frame) then frame = DAB_Settings[DAB_INDEX].Floaters[id].Anchor.frame; end
	if (not point) then point = DAB_Settings[DAB_INDEX].Floaters[id].Anchor.point; end
	if (not to) then to = DAB_Settings[DAB_INDEX].Floaters[id].Anchor.to; end
	DAB_Settings[DAB_INDEX].Floaters[id].Anchor = {frame=frame, point=point, to=to, x=x, y=y};
	button = getglobal("DAB_FloaterBox_"..id);
	button:ClearAllPoints();
	button:SetPoint(point, frame, to, x, y);
end

function DAB_Floater_MoveDown(id, amt)
	if (not id) then return; end
	local button = getglobal("DAB_ActionButton_"..id);
	if (not button) then
		DL_Error("Invalid button number sent to DAB_Floater_MoveDown: "..id);
		return;
	elseif (not DAB_Settings[DAB_INDEX].Floaters[id]) then
		DL_Error("Invalid floater number sent to DAB_Floater_MoveDown: "..id);
		return;
	elseif (not amt) then
		DL_Error("No amount sent to DAB_Floater_MoveDown: "..id);
		return;
	end
	local y = DAB_Settings[DAB_INDEX].Floaters[id].Anchor.y - amt;
	DAB_Settings[DAB_INDEX].Floaters[id].Anchor.y = y;
	button = getglobal("DAB_FloaterBox_"..id);
	button:ClearAllPoints();
	button:SetPoint(DAB_Settings[DAB_INDEX].Floaters[id].Anchor.point, DAB_Settings[DAB_INDEX].Floaters[id].Anchor.frame, DAB_Settings[DAB_INDEX].Floaters[id].Anchor.to, DAB_Settings[DAB_INDEX].Floaters[id].Anchor.x, DAB_Settings[DAB_INDEX].Floaters[id].Anchor.y);
end

function DAB_Floater_MoveLeft(id, amt)
	if (not id) then return; end
	local button = getglobal("DAB_ActionButton_"..id);
	if (not button) then
		DL_Error("Invalid button number sent to DAB_Floater_MoveLeft: "..id);
		return;
	elseif (not DAB_Settings[DAB_INDEX].Floaters[id]) then
		DL_Error("Invalid floater number sent to DAB_Floater_MoveLeft: "..id);
		return;
	elseif (not amt) then
		DL_Error("No amount sent to DAB_Floater_MoveLeft: "..id);
		return;
	end
	local x = DAB_Settings[DAB_INDEX].Floaters[id].Anchor.x - amt;
	DAB_Settings[DAB_INDEX].Floaters[id].Anchor.x = x;
	button = getglobal("DAB_FloaterBox_"..id);
	button:ClearAllPoints();
	button:SetPoint(DAB_Settings[DAB_INDEX].Floaters[id].Anchor.point, DAB_Settings[DAB_INDEX].Floaters[id].Anchor.frame, DAB_Settings[DAB_INDEX].Floaters[id].Anchor.to, DAB_Settings[DAB_INDEX].Floaters[id].Anchor.x, DAB_Settings[DAB_INDEX].Floaters[id].Anchor.y);
end

function DAB_Floater_MoveRight(id, amt)
	if (not id) then return; end
	local button = getglobal("DAB_ActionButton_"..id);
	if (not button) then
		DL_Error("Invalid button number sent to DAB_Floater_MoveRight: "..id);
		return;
	elseif (not DAB_Settings[DAB_INDEX].Floaters[id]) then
		DL_Error("Invalid floater number sent to DAB_Floater_MoveRight: "..id);
		return;
	elseif (not amt) then
		DL_Error("No amount sent to DAB_Floater_MoveRight: "..id);
		return;
	end
	local x = DAB_Settings[DAB_INDEX].Floaters[id].Anchor.x + amt;
	DAB_Settings[DAB_INDEX].Floaters[id].Anchor.x = x;
	button = getglobal("DAB_FloaterBox_"..id);
	button:ClearAllPoints();
	button:SetPoint(DAB_Settings[DAB_INDEX].Floaters[id].Anchor.point, DAB_Settings[DAB_INDEX].Floaters[id].Anchor.frame, DAB_Settings[DAB_INDEX].Floaters[id].Anchor.to, DAB_Settings[DAB_INDEX].Floaters[id].Anchor.x, DAB_Settings[DAB_INDEX].Floaters[id].Anchor.y);
end

function DAB_Floater_MoveUp(id, amt)
	if (not id) then return; end
	local button = getglobal("DAB_ActionButton_"..id);
	if (not button) then
		DL_Error("Invalid button number sent to DAB_Floater_MoveUp: "..id);
		return;
	elseif (not DAB_Settings[DAB_INDEX].Floaters[id]) then
		DL_Error("Invalid floater number sent to DAB_Floater_MoveUp: "..id);
		return;
	elseif (not amt) then
		DL_Error("No amount sent to DAB_Floater_MoveUp: "..id);
		return;
	end
	local y = DAB_Settings[DAB_INDEX].Floaters[id].Anchor.y + amt;
	DAB_Settings[DAB_INDEX].Floaters[id].Anchor.y = y;
	button = getglobal("DAB_FloaterBox_"..id);
	button:ClearAllPoints();
	button:SetPoint(DAB_Settings[DAB_INDEX].Floaters[id].Anchor.point, DAB_Settings[DAB_INDEX].Floaters[id].Anchor.frame, DAB_Settings[DAB_INDEX].Floaters[id].Anchor.to, DAB_Settings[DAB_INDEX].Floaters[id].Anchor.x, DAB_Settings[DAB_INDEX].Floaters[id].Anchor.y);
end

function DAB_Floater_SetDefaults(id, action)
	if (not action) then
		action = id;
	end
	DAB_Settings[DAB_INDEX].Buttons[id] = { Bar="F", Conditions = {}, Scripts = {}, action=action };
	DAB_Settings[DAB_INDEX].Floaters[id] = {
		alpha = 1,
		buttonbg = "Interface\\AddOns\\DiscordLibrary\\EmptyButton",
		buttonbgcolor = {r=1, g=1, b=1},
		cbgroup = i,
		checked = "Interface\\Buttons\\CheckButtonHilight",
		checkedcolor = {r=1, g=1, b=1},
		cooldownCount = 1,
		frameStrata = "LOW",
		highlight = "Interface\\Buttons\\ButtonHilight-Square",
		highlightcolor = {r=1, g=1, b=1},
		middleClick = id,
		rightClick = id,
		size = 36,
		rangecolor = {r=1, g=.1, b=.1},
		manacolor = {r=.2, g=.2, b=1},
		unusablecolor = {r=.6, g=.6, b=.6},
		manarecolor = 1,
		rangerecolor = 1,
		unusablerecolor = 1,

		Keybinding = {
			font = "Fonts\\FRIZQT__.TTF",
			color = {r=1, g=1, b=1},
			size = 10
		},
		Count = {
			font = "Fonts\\FRIZQT__.TTF",
			color = {r=1, g=1, b=1},
			size = 10
		},
		Cooldown = {
			font = "Fonts\\FRIZQT__.TTF",
			color = {r=1, g=1, b=0},
			size = 16
		},
		Macro = {
			font = "Fonts\\FRIZQT__.TTF",
			color = {r=1, g=1, b=0},
			size = 10
		},

		Anchor = {
			frame = "UIParent",
			to = "CENTER",
			point = "CENTER",
			x = 0,
			y = 0
		},

		ButtonBorder = {
			alpha = 1,
			color = {r=1, g=1, b=0},
			ecolor = {r=0, g=1, b=0};
			texture = "Interface\\Buttons\\UI-Quickslot2",
			etexture = "Interface\\Buttons\\ButtonHilight-Square",
			toppadding = 12,
			bottompadding = 13,
			leftpadding = 12,
			rightpadding = 13
		},

		Scripts = {}
	};
end

function DAB_Floater_SetKeybinding(id, kbid)
	if (not id) then return; end
	local button = getglobal("DAB_ActionButton_"..id);
	kbid = tonumber(kbid);
	if (not button) then
		DL_Error("Invalid button number sent to DAB_Floater_SetKeybinding: "..id);
		return;
	elseif (not DAB_Settings[DAB_INDEX].Floaters[id]) then
		DL_Error("Invalid floater number sent to DAB_Floater_SetKeybinding: "..id);
		return;
	elseif (not kbid) then
		DL_Error("Invalid keybinding ID sent to DAB_Floater_SetKeybinding: "..id);
		return;
	elseif (kbid < 1 or kbid > 120) then
		DL_Error("Invalid keybinding ID sent to DAB_Floater_SetKeybinding: "..id);
		return;
	end
	DAB_Settings[DAB_INDEX].Keybindings[kbid].option=3;
	DAB_Settings[DAB_INDEX].Keybindings[kbid].suboption=id;
	DAB_Update_Keybindings();
end

function DAB_Floater_SetTarget(id, unit, force)
	if (not DAB_Settings[DAB_INDEX].Floaters[id]) then
		DL_Error("Invalid floater id passed to DAB_Floater_SetTarget: "..id);
	end
	DAB_Settings[DAB_INDEX].Floaters[id].target = unit;
	DAB_Settings[DAB_INDEX].Floaters[id].forceTarget = force;
end

function DAB_Floater_Show(id)
	DAB_Settings[DAB_INDEX].Floaters[id].hide = nil;
	getglobal("DAB_ActionButton_"..id):Show();
end

function DAB_Floater_Size(id, size)
	if (not id) then return; end
	local button = getglobal("DAB_ActionButton_"..id);
	if (not button) then
		DL_Error("Invalid button number sent to DAB_Floater_Size: "..id);
		return;
	elseif (not DAB_Settings[DAB_INDEX].Floaters[id]) then
		DL_Error("Invalid floater number sent to DAB_Floater_Size: "..id);
		return;
	end
	if (not size) then x = DAB_Settings[DAB_INDEX].Floaters[id].size; end
	button:SetScale(size / 36 * UIParent:GetScale());
	button = getglobal("DAB_FloaterBox_"..id);
	button:SetHeight(size);
	button:SetWidth(size);
end

function DAB_Floater_TimeToHide(button, sec)
	if (not DAB_Settings[DAB_INDEX].Floaters[button]) then
		DL_Error("Attempt to call DAB_Floater_TimeToHide on a floater that doesn't exist: "..button);
		return;
	end
	getglobal("DAB_ActionButton_"..button).timetohide = sec;
end

function DAB_Floater_Toggle(id)
	if (DAB_Settings[DAB_INDEX].Floaters[id].hide) then
		DAB_Floater_Show(id);
	else
		DAB_Floater_Hide(id);
	end
end