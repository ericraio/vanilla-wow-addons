function DAB_ControlBox_Delay(group, delay)
	for i=1,10 do
		if (DAB_Settings[DAB_INDEX].ControlBox[i].onmouseover and DAB_Settings[DAB_INDEX].ControlBox[i].group == group) then
			if (delay) then
				getglobal("DAB_ControlBox_"..i).toggletimer = DAB_Settings[DAB_INDEX].ControlBox[i].delay;
			else
				getglobal("DAB_ControlBox_"..i).toggletimer = nil;
			end
			break;
		end
	end
end

function DAB_ControlBox_Hide(box)
	DAB_Settings[DAB_INDEX].ControlBox[box].hide = 1;
	getglobal("DAB_ControlBox_"..box):Hide();
end

function DAB_ControlBox_Initialize(id)
	local settings = DAB_Settings[DAB_INDEX].ControlBox[id];
	local boxName = "DAB_ControlBox_"..id;
	local box = getglobal(boxName);

	box:SetFrameStrata(settings.frameStrata);
	box:ClearAllPoints();
	box:SetPoint(settings.Anchor.point, settings.Anchor.frame, settings.Anchor.to, settings.Anchor.x, settings.Anchor.y);
	box:SetHeight(settings.height);
	box:SetWidth(settings.width);
	
	local bg = getglobal(boxName.."_Background");
	bg:SetTexture(settings.bgtexture);
	bg:SetVertexColor(settings.bgcolor.r, settings.bgcolor.g, settings.bgcolor.b, settings.bgalpha);
	bg:SetHeight(settings.height);
	bg:SetWidth(settings.width);

	local bord;
	for i=1,4 do
		bord = getglobal(boxName.."_"..i);
		bord:SetTexture(settings["b"..i.."texture"]);
		bord:SetVertexColor(settings.bordcolor.r, settings.bordcolor.g, settings.bordcolor.b, settings.bordalpha);
		if (i < 3) then
			bord:SetHeight(settings["b"..i.."width"]);
			bord:SetWidth(settings.width);
		else
			bord:SetWidth(settings["b"..i.."width"]);
			bord:SetHeight(settings.height + settings.b1width + settings.b2width);
			bord:ClearAllPoints();
		end
		if (settings["b"..i.."hide"]) then
			bord:Hide();
		else
			bord:Show();
		end
	end
	getglobal(boxName.."_3"):SetPoint("TOPRIGHT", box, "TOPLEFT", 0, settings.b1width);
	getglobal(boxName.."_4"):SetPoint("TOPLEFT", box, "TOPRIGHT", 0, settings.b1width);

	local text = getglobal(boxName.."_Text");
	text:ClearAllPoints();
	text:SetPoint(settings.TextAnchor.point, box, settings.TextAnchor.to, settings.TextAnchor.x, settings.TextAnchor.y);
	text:SetFont(settings.font, settings.fontsize);
	text:SetTextColor(settings.color.r, settings.color.g, settings.color.b, settings.alpha);
	if (settings.displayPage) then
		text:SetText(DAB_Settings[DAB_INDEX].Bar[settings.changePageBar].page);
	else
		text:SetText(settings.text);
	end
	text:SetJustifyH(settings.justifyH);
	text:SetJustifyV(settings.justifyV);
	text:SetHeight(settings.height);
	text:SetWidth(settings.width);

	if (settings.hide) then
		box:Hide();
	else
		box:Show();
	end
end

function DAB_ControlBox_KeybindingDown(id)
	local group = DAB_Settings[DAB_INDEX].ControlBox[id].group;
	if (DAB_Settings[DAB_INDEX].ControlBox[id].mouseover) then
		DAB_Show_Group(group);
	end
	DAB_ControlBox_OnClick(button, id, DAB_Settings[DAB_INDEX].ControlBox[id].mouseover);
end

function DAB_ControlBox_KeybindingUp(id)
	local group = DAB_Settings[DAB_INDEX].ControlBox[id].group;
	if (DAB_Settings[DAB_INDEX].ControlBox[id].mouseover) then
		DAB_Hide_Group(group);
	end
	DAB_ControlBox_OnClick(button, id, DAB_Settings[DAB_INDEX].ControlBox[id].mouseover);
end

function DAB_ControlBox_OnClick(button, id, mouseover)
	if (not id) then
		id = this:GetID();
		if (this.moving) then
			DAB_ControlBox_OnDragStop();
		end
	end
	if (DAB_Settings[DAB_INDEX].ControlBox[id].onrightclick and button == "RightButton") then
		local group = DAB_Settings[DAB_INDEX].ControlBox[id].rcgroup;
		DAB_Toggle_Group(group);
	elseif (DAB_Settings[DAB_INDEX].ControlBox[id].onmiddleclick and button == "MiddleButton") then
		local group = DAB_Settings[DAB_INDEX].ControlBox[id].mcgroup;
		DAB_Toggle_Group(group);
	elseif (DAB_Settings[DAB_INDEX].ControlBox[id].onclick and (not mouseover)) then
		local group = DAB_Settings[DAB_INDEX].ControlBox[id].group;
		DAB_Toggle_Group(group);
	end
	if (DAB_Settings[DAB_INDEX].ControlBox[id].hidegroups and DAB_Settings[DAB_INDEX].ControlBox[id].hidegroups ~= "") then
		local num = "";
		local char;
		for i=1, string.len(DAB_Settings[DAB_INDEX].ControlBox[id].hidegroups) do
			char = string.sub(DAB_Settings[DAB_INDEX].ControlBox[id].hidegroups, i, i);
			if (char == ",") then
				DAB_Hide_Group(num);
				if (tonumber(num)) then
					DAB_Hide_Group(tonumber(num));
				end
				num = "";
			else
				num = num..char;
			end
		end
		DAB_Hide_Group(num);
		if (tonumber(num)) then
			DAB_Hide_Group(tonumber(num));
		end
	end
	if (DAB_Settings[DAB_INDEX].ControlBox[id].changePage) then
		if (DAB_Settings[DAB_INDEX].ControlBox[id].changePageType == 1) then
			DAB_Bar_PageUp(DAB_Settings[DAB_INDEX].ControlBox[id].changePageBar);
		elseif (DAB_Settings[DAB_INDEX].ControlBox[id].changePageType == 2) then
			DAB_Bar_PageDown(DAB_Settings[DAB_INDEX].ControlBox[id].changePageBar);
		else
			DAB_Bar_SetPage(DAB_Settings[DAB_INDEX].ControlBox[id].changePageBar, DAB_Settings[DAB_INDEX].ControlBox[id].changePagePage);
		end
	end
end

function DAB_ControlBox_OnDragStart()
	if (DAB_DRAGGING_UNLOCKED or DAB_Check_ModifierKey(DAB_Settings[DAB_INDEX].DragLockOverride)) then
		this:StartMoving();
		this.moving = true;
	end
end

function DAB_ControlBox_OnDragStop()
	if (not this.moving) then return; end
	this:StopMovingOrSizing();
	local settings = DAB_Settings[DAB_INDEX].ControlBox[this:GetID()].Anchor;
	local x, y = DL_Get_Offsets(this, getglobal(settings.frame), settings.point, settings.to);
	settings.x = x;
	settings.y = y;
	if (DAB_CBoxOptions and DAB_CBoxOptions:IsShown() and DAB_OBJECT_SUBINDEX == this:GetID()) then
		DL_Init_EditBox(DAB_CBoxOptions_Config_XOffset, x);
		DL_Init_EditBox(DAB_CBoxOptions_Config_YOffset, y);
	end
	this:ClearAllPoints();
	this:SetPoint(settings.point, settings.frame, settings.to, x, y);
end

function DAB_ControlBox_OnEnter()
	if (this.toggletimer) then
		this.toggletimer = nil;
		return;
	end
	if (this.mouseover) then return; end
	this.mouseover = true;
	local id = this:GetID();
	getglobal("DAB_ControlBox_"..id.."_Background"):SetVertexColor(DAB_Settings[DAB_INDEX].ControlBox[id].mbgcolor.r, DAB_Settings[DAB_INDEX].ControlBox[id].mbgcolor.g, DAB_Settings[DAB_INDEX].ControlBox[id].mbgcolor.b, DAB_Settings[DAB_INDEX].ControlBox[id].mbgalpha);
	for i=1,4 do
		getglobal("DAB_ControlBox_"..id.."_"..i):SetVertexColor(DAB_Settings[DAB_INDEX].ControlBox[id].mbordcolor.r, DAB_Settings[DAB_INDEX].ControlBox[id].mbordcolor.g, DAB_Settings[DAB_INDEX].ControlBox[id].mbordcolor.b, DAB_Settings[DAB_INDEX].ControlBox[id].mbordalpha);
	end
	getglobal("DAB_ControlBox_"..id.."_Text"):SetTextColor(DAB_Settings[DAB_INDEX].ControlBox[id].mcolor.r, DAB_Settings[DAB_INDEX].ControlBox[id].mcolor.g, DAB_Settings[DAB_INDEX].ControlBox[id].mcolor.b, DAB_Settings[DAB_INDEX].ControlBox[id].malpha);

	if (DAB_Settings[DAB_INDEX].ControlBox[this:GetID()].onmouseover) then
		local group = DAB_Settings[DAB_INDEX].ControlBox[this:GetID()].group;
		DAB_Toggle_Group(group);
	end
end

function DAB_ControlBox_OnLeave()
	this.mouseover = nil;
	local id = this:GetID();
	getglobal("DAB_ControlBox_"..id.."_Background"):SetVertexColor(DAB_Settings[DAB_INDEX].ControlBox[id].bgcolor.r, DAB_Settings[DAB_INDEX].ControlBox[id].bgcolor.g, DAB_Settings[DAB_INDEX].ControlBox[id].bgcolor.b, DAB_Settings[DAB_INDEX].ControlBox[id].bgalpha);
	for i=1,4 do
		getglobal("DAB_ControlBox_"..id.."_"..i):SetVertexColor(DAB_Settings[DAB_INDEX].ControlBox[id].bordcolor.r, DAB_Settings[DAB_INDEX].ControlBox[id].bordcolor.g, DAB_Settings[DAB_INDEX].ControlBox[id].bordcolor.b, DAB_Settings[DAB_INDEX].ControlBox[id].bordalpha);
	end
	getglobal("DAB_ControlBox_"..id.."_Text"):SetTextColor(DAB_Settings[DAB_INDEX].ControlBox[id].color.r, DAB_Settings[DAB_INDEX].ControlBox[id].color.g, DAB_Settings[DAB_INDEX].ControlBox[id].color.b, DAB_Settings[DAB_INDEX].ControlBox[id].alpha);

	if (DAB_Settings[DAB_INDEX].ControlBox[this:GetID()].onmouseover) then
		this.toggletimer = DAB_Settings[DAB_INDEX].ControlBox[this:GetID()].delay;
	end
end

function DAB_ControlBox_OnUpdate(elapsed)
	if (not DAB_INITIALIZED) then return; end
	if (not this.timer) then this.timer = DAB_UPDATE_SPEED; end
	this.timer = this.timer - elapsed;
	if (this.timer < 0) then
		this.timer = DAB_UPDATE_SPEED;

		if (not this.lasttime) then this.lasttime = GetTime(); end
		local timeelapsed = GetTime() - this.lasttime;
		this.lasttime = GetTime();
		DAB_Run_Script("OnUpdate", "ControlBox", this:GetID(), timeelapsed);
	end
	if (not this.toggletimer) then return; end
	this.toggletimer = this.toggletimer - elapsed;
	if (this.toggletimer < 0) then
		this.toggletimer = nil;
		local group = DAB_Settings[DAB_INDEX].ControlBox[this:GetID()].group;
		DAB_Toggle_Group(group);
	end
end

function DAB_ControlBox_Show(box)
	DAB_Settings[DAB_INDEX].ControlBox[box].hide = nil;
	getglobal("DAB_ControlBox_"..box):Show();
end

function DAB_ControlBox_Text(box, text)
	if (not box) then return; end
	if (not text) then return; end
	if (not tonumber(box)) then return; end
	if (box < 1 or box > 10) then return; end
	DAB_Settings[DAB_INDEX].ControlBox[box].text = text;
	getglobal("DAB_ControlBox_"..box.."_Text"):SetText(text);
end

function DAB_ControlBox_Toggle(id)
	if (DAB_Settings[DAB_INDEX].ControlBox[id].hide) then
		DAB_ControlBox_Show(id);
	else
		DAB_ControlBox_Hide(id);
	end
end