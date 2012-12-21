function DAB_OtherBar_Hide(bar)
	DAB_Settings[DAB_INDEX].OtherBar[bar].hide = 1;
	getglobal("DAB_OtherBar"..DAB_OTHER_BAR[bar][0].tag):Hide();
end

function DAB_OtherBar_Initialize(bar)
	if (not DAB_INITIALIZED) then return; end
	local settings = DAB_Settings[DAB_INDEX].OtherBar[bar];
	local barFrame = getglobal("DAB_OtherBar"..DAB_OTHER_BAR[bar][0].tag);
	local numButtons = DAB_OTHER_BAR[bar][0].numButtons;

	if (bar == 12) then
		numButtons = GetNumShapeshiftForms();
		if (numButtons == 0) then numButtons = 10; end
	end

	barFrame:SetFrameStrata(settings.frameStrata);
	barFrame:ClearAllPoints();
	barFrame:SetPoint(settings.Anchor.point, settings.Anchor.frame, settings.Anchor.to, settings.Anchor.x, settings.Anchor.y);
	if (settings.Background.hide) then
		barFrame:SetBackdropColor(0, 0, 0, 0);
		barFrame:SetBackdropBorderColor(0, 0, 0, 0);
	else
		barFrame:SetBackdrop({bgFile = settings.Background.texture, edgeFile = settings.Background.btexture, tile = settings.Background.tile, tileSize = settings.Background.tileSize, edgeSize = settings.Background.edgeSize, insets = { left = settings.Background.left, right = settings.Background.right, top = settings.Background.top, bottom = settings.Background.bottom }});
		barFrame:SetBackdropColor(settings.Background.color.r, settings.Background.color.g, settings.Background.color.b, settings.Background.alpha);
		barFrame:SetBackdropBorderColor(settings.Background.bcolor.r, settings.Background.bcolor.g, settings.Background.bcolor.b, settings.Background.balpha);
	end

	TalentMicroButton:Show();

	if (bar < 13) then
		for i=1,10 do
			local cctext;
			if (bar == 11) then
				cctext = getglobal("DAB_PetCooldown_"..i.."_Text");
			else
				cctext = getglobal("DAB_ShapeshiftCooldown_"..i.."_Text");
			end
			cctext:SetFont(settings.Cooldown.font, settings.Cooldown.size, "outline='NORMAL'");
			cctext:SetTextColor(settings.Cooldown.color.r, settings.Cooldown.color.g, settings.Cooldown.color.b);
			if (settings.cooldownCount) then
				cctext:Show();
			else
				cctext:Hide();
			end
		end
	end

	local scale = settings.scale;
	for i=1, numButtons do
		local button = getglobal(DAB_OTHER_BAR[bar][i]);
		button:SetParent(barFrame);
		button:SetScale(scale);
		button:SetAlpha(settings.alpha);
		button:Show();
		if (i == 1) then
			button:ClearAllPoints();
			button:SetPoint("TOPLEFT", barFrame, "TOPLEFT", settings.Background.leftpadding, -settings.Background.toppadding + DAB_OTHER_BAR[bar][0].offset);
		elseif (settings.layout < 3) then
			button:ClearAllPoints();
			button:SetPoint("LEFT", DAB_OTHER_BAR[bar][i - 1], "RIGHT", settings.hspacing, 0);
		else
			button:ClearAllPoints();
			button:SetPoint("TOP", DAB_OTHER_BAR[bar][i - 1], "BOTTOM", 0, -settings.vspacing + DAB_OTHER_BAR[bar][0].offset);
		end
		if (bar == 12) then
			local border = getglobal(DAB_OTHER_BAR[bar][i].."NormalTexture");
			border:Hide();
			border.Show = function() end;
		end
	end

	local buttonH = DAB_OTHER_BAR[bar][0].height;
	local buttonW = DAB_OTHER_BAR[bar][0].width;
	local row2button = getglobal(DAB_OTHER_BAR[bar][math.ceil(numButtons / 2) + 1]);
	local row1button = getglobal(DAB_OTHER_BAR[bar][1]);
	local buttonsWidth, buttonsHigh;
	if (settings.layout == 1) then
		buttonsWide = numButtons;
		buttonsHigh = 1;
	elseif (settings.layout == 2) then
		row2button:ClearAllPoints();
		row2button:SetPoint("TOP", row1button, "BOTTOM", 0, -settings.vspacing + DAB_OTHER_BAR[bar][0].offset);
		buttonsWide = math.ceil(numButtons / 2);
		buttonsHigh = 2;
	elseif (settings.layout == 3) then
		buttonsWide = 1;
		buttonsHigh = numButtons;
	elseif (settings.layout == 4) then
		row2button:ClearAllPoints();
		row2button:SetPoint("LEFT", row1button, "RIGHT", settings.hspacing, 0);
		buttonsWide = 2;
		buttonsHigh = math.ceil(numButtons / 2);
	end
	local width = (buttonsWide * buttonW + settings.hspacing * (buttonsWide - 1) + settings.Background.leftpadding + settings.Background.rightpadding) * settings.scale;
	local height = (buttonsHigh * buttonH  + settings.vspacing * (buttonsHigh - 1) + settings.Background.toppadding + settings.Background.bottompadding) * settings.scale;
	barFrame:SetWidth(width);
	barFrame:SetHeight(height);

	if (not settings.mouseover) then
		barFrame:EnableMouse(1);
		barFrame:SetAlpha(1);
	end

	if (bar == 11) then
		event = "UPDATE_BONUS_ACTIONBAR";
		BonusActionBar_OnEvent();
	end

	if (bar == 11 and (not UnitExists("pet")) and (not UnitName("pet"))) then
		barFrame:Hide();
		return;
	end
	if (bar == 12 and GetNumShapeshiftForms() == 0) then
		barFrame:Hide();
		return;
	end
	if (settings.hide) then
		barFrame:Hide();
	else
		barFrame:Show();
		barFrame.mouseover = true;
	end
end

function DAB_OtherBar_OnDragStart()
	if (not DAB_DRAGGING_UNLOCKED) and (not DAB_Check_ModifierKey(DAB_Settings[DAB_INDEX].DragLockOverride)) then return; end
	if (DAB_DRAGGING_UNLOCKED) then
		DL_Debug("Dragging is unlocked.  You will not be able to click these buttons until you lock dragging.");
	end
	id = this:GetID();
	if (not this.moving) then
		this.moving = true;
		this:StartMoving();
	end
end

function DAB_OtherBar_OnDragStop()
	id = this:GetID();
	if (not this.moving) then return; end
	this.moving = nil;
	this:StopMovingOrSizing();
	local settings = DAB_Settings[DAB_INDEX].OtherBar[id].Anchor;
	local x, y = DL_Get_Offsets(this, getglobal(settings.frame), settings.point, settings.to);
	settings.x = x;
	settings.y = y;
	this:ClearAllPoints();
	this:SetPoint(settings.point, settings.frame, settings.to, x, y);
	if (DAB_Options and DAB_OBJECT_SUBINDEX == id) then
		DL_Init_EditBox(DAB_OtherBarOptions_XOffset, x);
		DL_Init_EditBox(DAB_OtherBarOptions_YOffset, y);
	end
end

function DAB_OtherBar_OnUpdate(elapsed)
	if (not DAB_INITIALIZED) then return; end
	local id = this:GetID();
	if (not DAB_Settings[DAB_INDEX].OtherBar[id].mouseover) then return; end
	local mouseover = DL_IsMouseOver(this);
	if (mouseover == this.mouseover) then return; end
	this.mouseover = mouseover;
	if (mouseover) then
		this:EnableMouse(1);
		this:SetAlpha(1);
		for i=1, DAB_OTHER_BAR[id][0].numButtons do
			getglobal(DAB_OTHER_BAR[id][i]):Show();
		end
	else
		this:EnableMouse(false);
		this:SetAlpha(0);
		for i=1, DAB_OTHER_BAR[id][0].numButtons do
			getglobal(DAB_OTHER_BAR[id][i]):Hide();
		end
	end
end

function DAB_OtherBar_Show(bar)
	DAB_Settings[DAB_INDEX].OtherBar[bar].hide = nil;
	getglobal("DAB_OtherBar"..DAB_OTHER_BAR[bar][0].tag):Show();
end

function DAB_OtherBar_Toggle(bar)
	if (DAB_Settings[DAB_INDEX].OtherBar[bar].hide) then
		DAB_Settings[DAB_INDEX].OtherBar[bar].hide = nil;
		getglobal("DAB_OtherBar"..DAB_OTHER_BAR[bar][0].tag):Show();
	else
		DAB_Settings[DAB_INDEX].OtherBar[bar].hide = 1;
		getglobal("DAB_OtherBar"..DAB_OTHER_BAR[bar][0].tag):Hide();
	end
end