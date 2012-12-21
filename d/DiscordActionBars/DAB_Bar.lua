function DAB_Bar_Backdrop(bar, bgtexture, bordertexture, tileSize, edgeSize, left, right, top, bottom)
	if (not bar) then return; end
	local barFrame = getglobal("DAB_ActionBar_"..bar);
	if (not barFrame) then
		DL_Error("Invalid bar number ("..bar..") sent to DAB_Bar_Backdrop.");
		return;
	end
	local settings = DAB_Settings[DAB_INDEX].Bar[bar].Background;
	if (bgtexture) then settings.texture = bgtexture; else bgtexture = settings.texture; end
	if (bordertexture) then settings.btexture = bordertexture; else bordertexture = settings.btexture end
	if (tileSize) then settings.tileSize = tileSize; else tileSize = settings.tileSize end
	if (edgeSize) then settings.edgeSize = edgeSize; else edgeSize = settings.edgeSize end
	if (left) then settings.left = left; else left = settings.left end
	if (right) then settings.right = right; else right = settings.right end
	if (top) then settings.top = top; else top = settings.top end
	if (bottom) then settings.bottom = bottom; else bottom = settings.bottom end
	barFrame:SetBackdrop({bgFile = bgtexture, edgeFile = bordertexture, tile = settings.tile, tileSize = tileSize, edgeSize = edgeSize, insets = { left = left, right = right, top = top, bottom = bottom }});
	if (settings.hide) then
		barFrame:SetBackdropColor(0, 0, 0, 0);
		barFrame:SetBackdropBorderColor(0, 0, 0, 0);
	else
		barFrame:SetBackdropColor(settings.color.r, settings.color.g, settings.color.b, settings.alpha);
		barFrame:SetBackdropBorderColor(settings.bcolor.r, settings.bcolor.g, settings.bcolor.b, settings.balpha);
	end
end

function DAB_Bar_BackdropPadding(bar, left, right, top, bottom)
	if (not bar) then return; end
	local barFrame = getglobal("DAB_ActionBar_"..bar);
	if (not barFrame) then
		DL_Error("Invalid bar number ("..bar..") sent to DAB_Bar_BackdropPadding.");
		return;
	end
	if (not left) then left = DAB_Settings[DAB_INDEX].Bar[bar].Background.leftpadding; end
	if (not right) then right = DAB_Settings[DAB_INDEX].Bar[bar].Background.rightpadding; end
	if (not top) then top = DAB_Settings[DAB_INDEX].Bar[bar].Background.toppadding; end
	if (not bottom) then bottom = DAB_Settings[DAB_INDEX].Bar[bar].Background.bottompadding; end
	DAB_Settings[DAB_INDEX].Bar[bar].Background.leftpadding = left;
	DAB_Settings[DAB_INDEX].Bar[bar].Background.rightpadding = right;
	DAB_Settings[DAB_INDEX].Bar[bar].Background.toppadding = top;
	DAB_Settings[DAB_INDEX].Bar[bar].Background.bottompadding = bottom;
	local button, yoffset;
	for row = 1, DAB_Settings[DAB_INDEX].Bar[bar].rows do
		button = getglobal("DAB_ActionButton_"..barFrame.rows[row][1]);
		button:ClearAllPoints();
		if (row == 1) then
			button:SetPoint("TOPLEFT", barFrame, "TOPLEFT", left, -top);
		else
			yoffset = top + 36 * (row - 1) + DAB_Settings[DAB_INDEX].Bar[bar].vspacing * (row - 1);
			button:SetPoint("TOPLEFT", barFrame, "TOPLEFT", left, -yoffset);
			button.yoffset = yoffset;
		end
	end
	DAB_Bar_Size(bar);
end

function DAB_Bar_BGAlpha(bar, a)
	if (not bar) then return; end
	local barFrame = getglobal("DAB_ActionBar_"..bar);
	if (not barFrame) then
		DL_Error("Invalid bar number ("..bar..") sent to DAB_Bar_BGAlpha.");
		return;
	elseif (a and (a > 1 or a < 0)) then
		DL_Error("Invalid alpha value ("..a..") sent to DAB_Bar_BGAlpha.");
		return;
	end
	if (not a) then
		a = DAB_Settings[DAB_INDEX].Bar[bar].Background.alpha;
	else
		DAB_Settings[DAB_INDEX].Bar[bar].Background.alpha = a;
	end
	if (DAB_Settings[DAB_INDEX].Bar[bar].Background.hide) then return; end
	barFrame:SetBackdropColor(DAB_Settings[DAB_INDEX].Bar[bar].Background.color.r, DAB_Settings[DAB_INDEX].Bar[bar].Background.color.g, DAB_Settings[DAB_INDEX].Bar[bar].Background.color.b, a);
end

function DAB_Bar_BGColor(bar, r, g, b, a)
	if (not bar) then return; end
	local barFrame = getglobal("DAB_ActionBar_"..bar);
	if (not barFrame) then
		DL_Error("Invalid bar number sent to DAB_Bar_BGColor: "..bar);
		return;
	end
	if (not r) then r = DAB_Settings[DAB_INDEX].Bar[bar].Background.color.r; end
	if (not g) then g = DAB_Settings[DAB_INDEX].Bar[bar].Background.color.g; end
	if (not b) then b = DAB_Settings[DAB_INDEX].Bar[bar].Background.color.b; end
	if (not a) then
		a = DAB_Settings[DAB_INDEX].Bar[bar].Background.alpha;
	else
		DAB_Settings[DAB_INDEX].Bar[bar].Background.alpha = a;
	end
	DAB_Settings[DAB_INDEX].Bar[bar].Background.color = {r=r, g=g, b=b};
	if (DAB_Settings[DAB_INDEX].Bar[bar].Background.hide) then return; end
	barFrame:SetBackdropColor(r, g, b, a);
end

function DAB_Bar_BorderAlpha(bar, a)
	if (not bar) then return; end
	local barFrame = getglobal("DAB_ActionBar_"..bar);
	if (not barFrame) then
		DL_Error("Invalid bar number sent to DAB_Bar_BorderAlpha: "..bar);
		return;
	end
	if (not a) then
		a = DAB_Settings[DAB_INDEX].Bar[bar].Background.balpha;
	else
		DAB_Settings[DAB_INDEX].Bar[bar].Background.balpha = a;
	end
	if (DAB_Settings[DAB_INDEX].Bar[bar].Background.hide) then return; end
	barFrame:SetBackdropBorderColor(DAB_Settings[DAB_INDEX].Bar[bar].Background.bcolor.r, DAB_Settings[DAB_INDEX].Bar[bar].Background.bcolor.g, DAB_Settings[DAB_INDEX].Bar[bar].Background.bcolor.b, a);
end

function DAB_Bar_BorderColor(bar, r, g, b, a)
	if (not bar) then return; end
	local barFrame = getglobal("DAB_ActionBar_"..bar);
	if (not barFrame) then
		DL_Error("Invalid bar number sent to DAB_Bar_BorderColor: "..bar);
		return;
	end
	if (not r) then r = DAB_Settings[DAB_INDEX].Bar[bar].Background.bcolor.r; end
	if (not g) then g = DAB_Settings[DAB_INDEX].Bar[bar].Background.bcolor.g; end
	if (not b) then b = DAB_Settings[DAB_INDEX].Bar[bar].Background.bcolor.b; end
	if (not a) then
		a = DAB_Settings[DAB_INDEX].Bar[bar].Background.balpha;
	else
		DAB_Settings[DAB_INDEX].Bar[bar].Background.balpha = a;
	end
	DAB_Settings[DAB_INDEX].Bar[bar].Background.bcolor = {r=r, g=g, b=b};
	if (DAB_Settings[DAB_INDEX].Bar[bar].Background.hide) then return; end
	barFrame:SetBackdropBorderColor(r, g, b, a);
end

function DAB_Bar_ButtonAlpha(bar, a)
	if (not bar) then return; end
	local barFrame = getglobal("DAB_ActionBar_"..bar);
	if (not barFrame) then
		DL_Error("Invalid bar number sent to DAB_Bar_ButtonAlpha: "..bar);
		return;
	elseif (a and (a > 1 or a < 0)) then
		DL_Error("Invalid alpha sent to DAB_Bar_ButtonAlpha: "..a..". Must be between 0 and 1");
		return;
	end
	if (not a) then 
		a = DAB_Settings[DAB_INDEX].Bar[bar].alpha;
	else
		DAB_Settings[DAB_INDEX].Bar[bar].alpha = a;
	end
	for i=1, 120 do
		if (DAB_Settings[DAB_INDEX].Buttons[i].Bar == bar) then
			getglobal("DAB_ActionButton_"..i):SetAlpha(a);
		end
	end
end

function DAB_Bar_ButtonBorderColor(bar, r, g, b)
	if (not bar) then return; end
	local barFrame = getglobal("DAB_ActionBar_"..bar);
	if (not barFrame) then
		DL_Error("Invalid bar number sent to DAB_Bar_ButtonBorderColor: "..bar);
		return;
	elseif (r and (r > 1 or r < 0)) then
		DL_Error("Invalid red sent to DAB_Bar_ButtonBorderColor: "..r..". Must be between 0 and 1");
		return;
	elseif (g and (g > 1 or g < 0)) then
		DL_Error("Invalid alpha sent to DAB_Bar_ButtonBorderColor: "..g..". Must be between 0 and 1");
		return;
	elseif (b and (b > 1 or b < 0)) then
		DL_Error("Invalid alpha sent to DAB_Bar_ButtonBorderColor: "..b..". Must be between 0 and 1");
		return;
	end
	if (not r) then r = DAB_Settings[DAB_INDEX].Bar[bar].ButtonBorder.color.r; end
	if (not g) then g = DAB_Settings[DAB_INDEX].Bar[bar].ButtonBorder.color.g; end
	if (not b) then b = DAB_Settings[DAB_INDEX].Bar[bar].ButtonBorder.color.b; end
	for i=1, 120 do
		if (DAB_Settings[DAB_INDEX].Buttons[i].Bar == bar) then
			getglobal("DAB_ActionButton_"..i.."_Border"):SetVertexColor(r, g, b, DAB_Settings[DAB_INDEX].Bar[bar].alpha);
		end
	end
end

function DAB_Bar_ButtonSize(bar, size)
	if (not bar) then return; end
	local barFrame = getglobal("DAB_ActionBar_"..bar);
	if (not barFrame) then
		DL_Error("Invalid bar number sent to DAB_Bar_ButtonSize: "..bar);
		return;
	end
	if (not size) then 
		size = DAB_Settings[DAB_INDEX].Bar[bar].size;
	else
		DAB_Settings[DAB_INDEX].Bar[bar].size = size;
	end
	local scale = size / 36;
	for i=1, 120 do
		if (DAB_Settings[DAB_INDEX].Buttons[i].Bar == bar) then
			getglobal("DAB_ActionButton_"..i):SetScale(scale);
		end
	end
	DAB_Bar_Size(bar);
end

function DAB_Bar_ButtonText(bar)
	local settings = DAB_Settings[DAB_INDEX].Bar[bar];
	local text, cooldown;
	for i=1, 120 do
		if (DAB_Settings[DAB_INDEX].Buttons[i].Bar == bar) then
			button = "DAB_ActionButton_"..i;
			
			text = getglobal(button.."_HotKey");
			text:SetFont(settings.Keybinding.font, settings.Keybinding.size, "outline='NORMAL'");
			text:SetTextColor(settings.Keybinding.color.r, settings.Keybinding.color.g, settings.Keybinding.color.b, 1);
			if (settings.Keybinding.hide) then
				text:Hide();
			else
				text:Show();
			end

			text = getglobal(button.."_Count");
			text:SetFont(settings.Count.font, settings.Count.size, "outline='NORMAL'");
			text:SetTextColor(settings.Count.color.r, settings.Count.color.g, settings.Count.color.b, 1);
			if (settings.Count.hide) then
				text:Hide();
			else
				text:Show();
			end

			text = getglobal(button.."_CooldownCount");
			text:SetFont(settings.Cooldown.font, settings.Cooldown.size, "outline='NORMAL'");
			text:SetTextColor(settings.Cooldown.color.r, settings.Cooldown.color.g, settings.Cooldown.color.b, 1);
			if (settings.Cooldown.hide) then
				text:Hide();
			else
				text:Show();
			end

			text = getglobal(button.."_Timer");
			text:SetFont(settings.Cooldown.font, settings.Cooldown.size, "outline='NORMAL'");
			text:SetTextColor(settings.Cooldown.color.r, settings.Cooldown.color.g, settings.Cooldown.color.b, 1);

			text = getglobal(button.."_Name");
			text:SetFont(settings.Macro.font, settings.Macro.size, "outline='NORMAL'");
			text:SetTextColor(settings.Macro.color.r, settings.Macro.color.g, settings.Macro.color.b, 1);
			if (settings.Macro.hide) then
				text:Hide();
			else
				text:Show();
			end
		end
	end
end

function DAB_Bar_ButtonTextures(bar)
	local settings = DAB_Settings[DAB_INDEX].Bar[bar];
	local checked, highlight, border, background, equipped;
	for i=1, 120 do
		if (DAB_Settings[DAB_INDEX].Buttons[i].Bar == bar) then
			button = "DAB_ActionButton_"..i;
			icon = getglobal(button.."_Icon");
			if (settings.trimEdges) then
				icon:SetTexCoord(.078, .92, .079, .937);
			else
				icon:SetTexCoord(0, 1, 0, 1);
			end

			background = getglobal(button.."_Background");
			background:SetTexture(settings.buttonbg);
			background:SetVertexColor(settings.buttonbgcolor.r, settings.buttonbgcolor.g, settings.buttonbgcolor.b, settings.alpha);

			checked = getglobal(button.."_Checked");
			checked:SetTexture(settings.checked);
			checked:SetVertexColor(settings.checkedcolor.r, settings.checkedcolor.g, settings.checkedcolor.b, settings.alpha);

			highlight = getglobal(button.."_Highlight");
			highlight:SetTexture(settings.highlight);
			highlight:SetVertexColor(settings.highlightcolor.r, settings.highlightcolor.g, settings.highlightcolor.b, settings.alpha);

			equipped = getglobal(button.."_EquippedBorder");
			equipped:SetTexture(settings.ButtonBorder.etexture);
			equipped:SetVertexColor(settings.ButtonBorder.ecolor.r, settings.ButtonBorder.ecolor.g, settings.ButtonBorder.ecolor.b, settings.alpha);

			border = getglobal(button.."_Border");
			border:ClearAllPoints();
			border:SetPoint("TOPLEFT", button, "TOPLEFT", -settings.ButtonBorder.leftpadding, settings.ButtonBorder.toppadding);
			border:SetHeight(36 + settings.ButtonBorder.toppadding + settings.ButtonBorder.bottompadding);
			border:SetWidth(36 + settings.ButtonBorder.leftpadding + settings.ButtonBorder.rightpadding);
			border:SetTexture(settings.ButtonBorder.texture);
			border:SetVertexColor(settings.ButtonBorder.color.r, settings.ButtonBorder.color.g, settings.ButtonBorder.color.b, settings.ButtonBorder.alpha);
		end
	end
end

function DAB_Bar_FauxHide(bar)
	local barFrame = getglobal("DAB_ActionBar_"..bar);
	if (barFrame.fauxhidden) then return; end
	barFrame:SetAlpha(0);
	barFrame:EnableMouse(false);
	barFrame:EnableMouseWheel(false);
	local button;
	for i=1,120 do
		if (DAB_Settings[DAB_INDEX].Buttons[i].Bar == bar) then
			button = getglobal("DAB_ActionButton_"..i);
			DAB_ActionButton_FauxHide(i);
			button:Hide();
		end
	end
	barFrame.hidden = true;
	barFrame.fauxhidden = true;
end

function DAB_Bar_FauxShow(bar)
	local barFrame = getglobal("DAB_ActionBar_"..bar);
	barFrame:SetAlpha(1);
	if (not DAB_Settings[DAB_INDEX].Bar[bar].disableMouse) then
		barFrame:EnableMouse(1);
		barFrame:EnableMouseWheel(1);
	end
	barFrame.hidden = nil;
	barFrame.fauxhidden = nil;
	for i=1,120 do
		if (DAB_Settings[DAB_INDEX].Buttons[i].Bar == bar) then
			local button = getglobal("DAB_ActionButton_"..i);
			button.activeConditions = {};
			button.fauxhidden = true;
			DAB_ActionButton_Show(i);
			DAB_ActionButton_FauxShow(i);
		end
	end
	DAB_Bar_Size(bar);
end

function DAB_Bar_GetRealPage(bar, page)
	if (not DAB_INITIALIZED) then return; end
	local barFrame = getglobal("DAB_ActionBar_"..bar);
	if (not page) then
		page = DAB_Settings[DAB_INDEX].Bar[bar].page;
	end
	if (barFrame.pagemap[page]) then
		return barFrame.pagemap[page];
	else
		return page;
	end
end

function DAB_Bar_Hide(bar)
	DAB_Settings[DAB_INDEX].Bar[bar].hide = 1;
	getglobal("DAB_ActionBar_"..bar):Hide();
end

function DAB_Bar_Initialize(bar)
	local settings = DAB_Settings[DAB_INDEX].Bar[bar];
	local barFrame = getglobal("DAB_ActionBar_"..bar);
	local scale = settings.size / 36;
	local previous;
	local button, bar2, icon, cooldown;

	for page=1,settings.numBars do
		if (not settings.pages[page]) then settings.pages[page] = {}; end
		if (not settings.pageconditions[page]) then settings.pageconditions[page] = {}; end
		for button=1, settings.numButtons do
			if (not settings.pages[page][button]) then settings.pages[page][button] = 1; end
			if (not settings.pageconditions[page][button]) then settings.pageconditions[page][button] = {}; end
		end
	end

	barFrame:SetFrameStrata(settings.frameStrata);
	barFrame:SetAlpha(1);
	if (settings.disableMouse) then
		barFrame:EnableMouse(false);
		barFrame:EnableMouseWheel(false);
	else
		barFrame:EnableMouse(1);
		barFrame:EnableMouseWheel(1);
	end

	barFrame.bttnpos = {};
	local bc = 0;
	for i=1, 120 do
		if (DAB_Settings[DAB_INDEX].Buttons[i].Bar == bar) then
			bc = bc + 1;
			barFrame.bttnpos[i] = bc;
			button = getglobal("DAB_ActionButton_"..i);
			button:SetParent(barFrame);
			button:SetFrameStrata(settings.frameStrata);
			cooldown = getglobal("DAB_ActionButton_"..i.."_Cooldown");
			cooldown:SetFrameStrata(settings.frameStrata);
			cooldown:SetFrameLevel(button:GetFrameLevel() + 1);
			button:ClearAllPoints();
			local box = getglobal("DAB_FloaterBox_"..i);
			box:ClearAllPoints();
			if (previous) then
				button:SetPoint("LEFT", previous, "RIGHT", settings.hspacing, 0);
			else
				button:SetPoint("TOPLEFT", barFrame, "TOPLEFT", settings.Background.leftpadding, -settings.Background.toppadding);
			end
			box:SetPoint("CENTER", button, "CENTER", 0, 0);
			box:SetHeight(settings.size);
			box:SetWidth(settings.size);
			previous = button:GetName();

			button.hidden = nil;
			button.collapsed = nil;
			button.activeConditions = {};
			button.yoffset = nil;
			button.OOR = nil;
			button.OOM = nil;
			button.AUN = nil;
		end
	end

	barFrame.rows = {};
	barFrame.buttonLocation = {};
	barFrame.pagemap = {};
	local resetrow = math.mod(settings.numButtons, settings.rows) + 1;

	local buttonCount = 0;
	local rowCount = 1;
	local perrow = math.ceil(settings.numButtons / settings.rows);
	barFrame.rows = { {} };
	for button=1,120 do
		if (DAB_Settings[DAB_INDEX].Buttons[button].Bar == bar) then
			buttonCount = buttonCount + 1;
			barFrame.rows[rowCount][buttonCount] = button;
			barFrame.buttonLocation[button] = { row = rowCount, loc = buttonCount };
			if (buttonCount == 1 and rowCount > 1) then
				local actionbutton = getglobal("DAB_ActionButton_"..button);
				local yoffset = settings.Background.toppadding + 36 * (rowCount - 1) + settings.vspacing * (rowCount - 1);
				actionbutton:ClearAllPoints();
				actionbutton:SetPoint("TOPLEFT", barFrame, "TOPLEFT", settings.Background.leftpadding, -yoffset);
				actionbutton.yoffset = yoffset;
			end
			if (buttonCount == perrow) then
				buttonCount = 0;
				rowCount = rowCount + 1;
				barFrame.rows[rowCount] = {};
				if (rowCount == resetrow) then
					perrow = perrow - 1;
				end
			end
		end
	end

	DAB_Bar_Size(bar);
	DAB_Bar_SetPage(bar, settings.page, 1);
	DAB_Bar_Update(bar);

	if (settings.hide) then
		barFrame:Hide();
	else
		barFrame:Show();
	end
	barFrame.initialized = true;
	barFrame.activeConditions = {};
	if (barFrame.fauxhidden) then
		DAB_Bar_FauxShow(bar);
	end
end

function DAB_Bar_Label(bar)
	local label = "DAB_ActionBar_"..bar.."_Label";
	local frame = getglobal(label);
	local text = getglobal(label.."_Text");
	local bg = getglobal(label.."_Background");
	local settings = DAB_Settings[DAB_INDEX].Bar[bar].Label;

	frame:ClearAllPoints();
	frame:SetPoint(settings.attachpoint, "DAB_ActionBar_"..bar, settings.attachto, settings.x, settings.y);
	frame:SetHeight(settings.height);
	text:SetHeight(settings.height);
	frame:SetWidth(settings.width);
	text:SetWidth(settings.width);
	text:SetFont(settings.font, settings.fontsize);
	text:SetText(settings.text);
	text:SetTextColor(settings.color.r, settings.color.g, settings.color.b, settings.alpha);
	frame:SetBackdrop({bgFile = settings.texture, edgeFile = settings.btexture, tile = settings.tile, tileSize = settings.tileSize, edgeSize = settings.edgeSize, insets = { left = settings.left, right = settings.right, top = settings.top, bottom = settings.bottom }});
	frame:SetBackdropColor(settings.bgcolor.r, settings.bgcolor.g, settings.bgcolor.b, settings.bgalpha);
	frame:SetBackdropBorderColor(settings.bordcolor.r, settings.bordcolor.g, settings.bordcolor.b, settings.bordalpha);
	text:SetJustifyV(settings.justifyV);
	text:SetJustifyH(settings.justifyH);

	if (settings.hide) then
		frame:Hide();
	else
		frame:Show();
	end
end

function DAB_Bar_LabelText(bar, text)
	if (not bar) then return; end
	if (not tonumber(bar)) then return; end
	if (bar < 1 or bar > DAB_NUM_BARS) then return; end
	if (not text) then return; end
	DAB_Settings[DAB_INDEX].Bar[bar].Label.text = text;
	getglobal("DAB_ActionBar_"..bar.."_Label_Text"):SetText(text);
end

function DAB_Bar_Location(bar, x, y, frame, point, to)
	if (not bar) then return; end
	local barFrame = getglobal("DAB_ActionBar_"..bar);
	if (not barFrame) then
		DL_Error("Invalid bar number sent to DAB_Bar_Location: "..bar);
		return;
	elseif (point and (not DL_VALID_ANCHOR[point])) then
		DL_Error("Invalid anchor point sent to DAB_Bar_Location: "..point);
		return;
	elseif (to and (not DL_VALID_ANCHOR[to])) then
		DL_Error("Invalid anchor to sent to DAB_Bar_Location: "..to);
		return;
	end
	if (not x) then x = DAB_Settings[DAB_INDEX].Bar[bar].Anchor.x; end
	if (not y) then y = DAB_Settings[DAB_INDEX].Bar[bar].Anchor.y; end
	if (not frame) then frame = DAB_Settings[DAB_INDEX].Bar[bar].Anchor.frame; end
	if (not point) then point = DAB_Settings[DAB_INDEX].Bar[bar].Anchor.point; end
	if (not to) then to = DAB_Settings[DAB_INDEX].Bar[bar].Anchor.to; end
	DAB_Settings[DAB_INDEX].Bar[bar].Anchor = {frame=frame, point=point, to=to, x=x, y=y};
	barFrame:ClearAllPoints();
	barFrame:SetPoint(point, frame, to, x, y);
end

function DAB_Bar_OnDragStart(id, override)
	if (not override) then
		if (not DAB_DRAGGING_UNLOCKED) and (not DAB_Check_ModifierKey(DAB_Settings[DAB_INDEX].DragLockOverride)) then return; end
	end
	if (not id) then
		id = this:GetID();
	end
	local bar = getglobal("DAB_ActionBar_"..id);
	if (not bar.moving) then
		bar.moving = true;
		bar:StartMoving();
	end
end

function DAB_Bar_OnDragStop(id)
	if (not id) then
		id = this:GetID();
	end
	local bar = getglobal("DAB_ActionBar_"..id);
	if (not bar.moving) then return; end
	bar.moving = nil;
	bar:StopMovingOrSizing();
	local settings = DAB_Settings[DAB_INDEX].Bar[id].Anchor;
	local x, y = DL_Get_Offsets(bar, getglobal(settings.frame), settings.point, settings.to);
	settings.x = x;
	settings.y = y;
	DAB_Bar_Location(id);
	if (DAB_Options and DAB_OBJECT_SUBINDEX == id) then
		DL_Init_EditBox(DAB_BarOptions_BarAppearance_XOffset, x);
		DL_Init_EditBox(DAB_BarOptions_BarAppearance_YOffset, y);
	end
end

function DAB_Bar_OnEnter()
	local bar = this:GetID();
	DAB_ControlBox_Delay(DAB_Settings[DAB_INDEX].Bar[bar].cbgroup);
end

function DAB_Bar_OnHide()
	this.activeConditions = {};
end

function DAB_Bar_OnLeave()
	local bar = this:GetID();
	DAB_ControlBox_Delay(DAB_Settings[DAB_INDEX].Bar[bar].cbgroup, 1);
end

function DAB_Bar_OnMouseWheel(direction)
	local bar = this:GetID();
	if (DAB_Settings[DAB_INDEX].Bar[bar].disableMW) then return; end
	if (direction > 0) then
		DAB_Bar_PageDown(bar);
	else
		DAB_Bar_PageUp(bar);
	end
end

function DAB_Bar_OnUpdate(elapsed)
	if (not DAB_INITIALIZED) then return; end
	local bar = this:GetID();

	if (DAB_SHOWING_EMPTY) then return; end

	if (not this.timer) then this.timer = DAB_UPDATE_SPEED; end
	this.timer = this.timer - elapsed;
	if (this.timer < 0) then
		this.timer = DAB_UPDATE_SPEED;

		if (not this.lasttime) then this.lasttime = GetTime(); end
		local timeelapsed = GetTime() - this.lasttime;
		this.lasttime = GetTime();
		DAB_Run_Script("OnUpdate", "Bar", bar, timeelapsed);

		local condition, response;
		for i = 1, table.getn(DAB_Settings[DAB_INDEX].Bar[bar].Conditions) do
			condition = DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].condition;
			response = DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].response;
			this = getglobal("DAB_ActionBar_"..bar);
			local active;
			local condition = DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].condition;
			if (condition == 0) then
				active = true;
				this.activeConditions[i] = nil;
			elseif (condition == 9 or condition == 10) then
				active = DL_CheckCondition[condition](this);
			else
				active = DL_CheckCondition[condition](DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i]);
			end
			for _,override in DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].overrides do
				if (this.activeConditions[override]) then
					active = nil;
					break;
				end
			end

			if (active and (not this.activeConditions[i]) and response ~= 0) then
				if (response == 1) then
					DAB_Bar_SetPage(bar, DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].page);
				elseif (response == 2) then
					DAB_Bar_FauxHide(bar);
				elseif (response == 3) then
					DAB_Bar_FauxShow(bar);
				elseif (response == 4) then
					this:SetAlpha(DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].alpha);
				elseif (response == 5) then
					DAB_Bar_BGAlpha(bar, DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].alpha);
				elseif (response == 6) then
					DAB_Bar_BGColor(bar, DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].color.r, DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].color.g, DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].color.b);
				elseif (response == 7) then
					DAB_Bar_BorderAlpha(bar, DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].alpha);
				elseif (response == 8) then
					DAB_Bar_BorderColor(bar, DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].color.r, DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].color.g, DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].color.b);
				elseif (response == 9) then
					DAB_Bar_ButtonAlpha(bar, DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].alpha);
				elseif (response == 10) then
					DAB_Set_KeybindingGroup(DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].rnumber, bar);
				elseif (response == 11) then
					DAB_Bar_Location(bar, nil, DAB_Settings[DAB_INDEX].Bar[bar].Anchor.y + DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].amount);
				elseif (response == 12) then
					DAB_Bar_Location(bar, nil, DAB_Settings[DAB_INDEX].Bar[bar].Anchor.y - DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].amount);
				elseif (response == 13) then
					DAB_Bar_Location(bar, DAB_Settings[DAB_INDEX].Bar[bar].Anchor.x - DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].amount);
				elseif (response == 14) then
					DAB_Bar_Location(bar, DAB_Settings[DAB_INDEX].Bar[bar].Anchor.x + DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].amount);
				elseif (response == 15) then
					DAB_Bar_BackdropPadding(bar, nil, nil, DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].amount);
				elseif (response == 16) then
					DAB_Bar_BackdropPadding(bar, nil, nil, nil, DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].amount);
				elseif (response == 17) then
					DAB_Bar_BackdropPadding(bar, DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].amount);
				elseif (response == 18) then
					DAB_Bar_BackdropPadding(bar, nil, DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].amount);
				elseif (response == 19) then
					DAB_Bar_ButtonSize(bar, DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].amount);
				elseif (response == 20) then
					DAB_Bar_ButtonBorderColor(bar, DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].color.r, DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].color.g, DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].color.b);
				elseif (response == 21) then
					local x, y = GetCursorPosition();
					x = x / UIParent:GetScale();
					y = y / UIParent:GetScale();
					DAB_Bar_Location(bar, x, y, "UIParent", "CENTER", "BOTTOMLEFT");
				elseif (response == 22) then
					DAB_Bar_SetPage(bar, this.lastpage);
				elseif (response == 32) then
					this.pagemap[DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].page2] = DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].page;
					if (DAB_Settings[DAB_INDEX].Bar[bar].page == DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].page2) then
						DAB_Bar_SetPage(bar, DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].page2, 1);
					end
				elseif (response == 33) then
					DAB_Bar_SetTarget(bar, DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].runit);
				elseif (response == 34) then
					DAB_Bar_SetTarget(bar);
				elseif (response == 35) then
					DAB_Bar_Location(bar, DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].rx, DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i].ry);
				else
					DAB_Global_Response(response, DAB_Settings[DAB_INDEX].Bar[bar].Conditions[i]);
				end
			end

			getglobal("DAB_ActionBar_"..bar).activeConditions[i] = active;
		end
	end

	if (this.timetohide) then
		this.timetohide = this.timetohide - elapsed;
		if (this.timetohide < 0) then
			this.timetohide = nil;
			DAB_Bar_Hide(this:GetID());
		end
	end
end

function DAB_Bar_PageDown(bar)
	if (DAB_Settings[DAB_INDEX].Bar[bar].numBars == 1) then return; end
	local page = DAB_Settings[DAB_INDEX].Bar[bar].page;
	page = page - 1;
	if (page < 1) then
		page = DAB_Settings[DAB_INDEX].Bar[bar].numBars;
	end
	local skippages = DAB_Get_SkipPages(bar, skippages);
	if (skippages[page]) then
		local newpage;
		for i=page, 1, -1 do
			if (not skippages[i]) then
				newpage = i;
				break;
			end
		end
		if (not newpage) then
			for i=DAB_Settings[DAB_INDEX].Bar[bar].numBars, 1, -1 do
				if (not skippages[i]) then
					newpage = i;
					break;
				end
			end
		end
		if (not newpage) then
			newpage = 1;
		end
		page = newpage;
	end
	DAB_Bar_SetPage(bar, page);
end

function DAB_Bar_PageUp(bar)
	if (DAB_Settings[DAB_INDEX].Bar[bar].numBars == 1) then return; end
	local page = DAB_Settings[DAB_INDEX].Bar[bar].page;
	page = page + 1;
	if (page > DAB_Settings[DAB_INDEX].Bar[bar].numBars) then
		page = 1;
	end
	local skippages = DAB_Get_SkipPages(bar, skippages);
	if (skippages[page]) then
		local newpage;
		for i=page, DAB_Settings[DAB_INDEX].Bar[bar].numBars do
			if (not skippages[i]) then
				newpage = i;
				break;
			end
		end
		if (not newpage) then
			for i=1, DAB_Settings[DAB_INDEX].Bar[bar].numBars do
				if (not skippages[i]) then
					newpage = i;
					break;
				end
			end
		end
		if (not newpage) then
			newpage = 1;
		end
		page = newpage;
	end
	DAB_Bar_SetPage(bar, page);
end

function DAB_Bar_SetPage(bar, page, override)
	if (not DAB_INITIALIZED) then return; end
	if (not bar) then
		DL_Error("You called DAB_Bar_SetPage without providing a bar number.");
		return;
	end
	if (not page) then
		DL_Error("You called DAB_Bar_SetPage without providing a page number.");
		return;
	end
	if (bar < 1 or bar > DAB_NUM_BARS) then
		DL_Error("You called DAB_Bar_SetPage with an invalid bar number: "..bar);
		return;
	end
	if (page < 1 or page > DAB_Settings[DAB_INDEX].Bar[bar].numBars) then
		DL_Error("You called DAB_Bar_SetPage with an invalid page number: "..page.." bar: "..bar);
		return;
	end
	if (DAB_Settings[DAB_INDEX].Bar[bar].page == page and (not override)) then return; end
	local barFrame = getglobal("DAB_ActionBar_"..bar);
	barFrame.lastpage = DAB_Settings[DAB_INDEX].Bar[bar].page;
	DAB_Settings[DAB_INDEX].Bar[bar].page = page;
	if (barFrame.pagemap[page]) then
		page = barFrame.pagemap[page];
	end
	if (page > DAB_Settings[DAB_INDEX].Bar[bar].numBars or page < 1) then
		barFrame.pagemap[barFrame.lastpage] = nil;
		page = 1;
		DAB_Settings[DAB_INDEX].Bar[bar].page = 1;
	end
	local count = 0;
	for i=1,120 do
		if (DAB_Settings[DAB_INDEX].Buttons[i].Bar == bar) then
			count = count + 1;
			DAB_Settings[DAB_INDEX].Buttons[i].action = DAB_Settings[DAB_INDEX].Bar[bar].pages[page][count];
			local actionbutton = getglobal("DAB_ActionButton_"..i);
			actionbutton.fauxhidden = true;
			DAB_ActionButton_FauxShow(i);
			DAB_ActionButton_Show(i);
			actionbutton.activeConditions = {};
		end
	end
	if (bar == 1) then
		 MainMenuBarPageNumber:SetText(DAB_Settings[DAB_INDEX].Bar[bar].page); 
	end
	DAB_Bar_Update(bar);
	DAB_Bar_Size(bar);
	for i=1,10 do
		if (DAB_Settings[DAB_INDEX].ControlBox[i].displayPage and DAB_Settings[DAB_INDEX].ControlBox[i].changePageBar == bar) then
			getglobal("DAB_ControlBox_"..i.."_Text"):SetText(DAB_Settings[DAB_INDEX].Bar[bar].page);
		end
	end
end

function DAB_Bar_SetTarget(barID, unit)
	local bar = getglobal("DAB_ActionBar_"..barID);
	if (bar) then
		bar.targetOverride = unit;
	end
end

function DAB_Bar_Show(bar)
	DAB_Settings[DAB_INDEX].Bar[bar].hide = nil;
	getglobal("DAB_ActionBar_"..bar):Show();
end

function DAB_Bar_Size(bar)
	local barFrame = getglobal("DAB_ActionBar_"..bar);
	local settings = DAB_Settings[DAB_INDEX].Bar[bar];
	local scale = settings.size / 36;
	local visCount;
	local visButtons = 0;
	for row, buttons in barFrame.rows do
		visCount = 0;
		for _,button in buttons do
			if (DAB_Settings[DAB_INDEX].Bar[bar].collapse) then
				local ab = getglobal("DAB_ActionButton_"..button);
				if (ab:IsShown() and (not ab.fauxhidden)) then
					visCount = visCount + 1;
				end
			else
				visCount = visCount + 1;
			end
		end
		if (visCount > visButtons) then
			visButtons = visCount;
		end
	end
	local width = (visButtons * 36 + settings.hspacing * (visButtons - 1) + settings.Background.leftpadding + settings.Background.rightpadding) * scale;
	local height = (settings.rows * 36  + settings.vspacing * (settings.rows - 1) + settings.Background.toppadding + settings.Background.bottompadding) * scale;
	barFrame:SetWidth(width);
	barFrame:SetHeight(height);
end

function DAB_Bar_TimeToHide(bar, seconds)
	getglobal("DAB_ActionBar_"..bar).timetohide = seconds;
end

function DAB_Bar_Toggle(bar)
	if (DAB_Settings[DAB_INDEX].Bar[bar].hide) then
		DAB_Bar_Show(bar);
	else
		DAB_Bar_Hide(bar);
	end
end

function DAB_Bar_Update(bar)
	for i=1, 120 do
		if (DAB_Settings[DAB_INDEX].Buttons[i].Bar == bar) then
			this = getglobal("DAB_ActionButton_"..i);
			DAB_ActionButton_Update();
		end
	end
end

function DAB_Get_SkipPages(bar)
	local list = {};
	if (not DAB_Settings[DAB_INDEX].Bar[bar].skipPages) then
		return list;
	end
	local num = "";
	local char;
	for i=1, string.len(DAB_Settings[DAB_INDEX].Bar[bar].skipPages) do
		char = string.sub(DAB_Settings[DAB_INDEX].Bar[bar].skipPages, i, i);
		if (char == ",") then
			num = tonumber(num);
			if (num) then
				list[num] = 1;
			end
			num = "";
		else
			num = num..char;
		end
	end
	num = tonumber(num);
	if (num) then
		list[num] = 1;
	end
	return list;
end