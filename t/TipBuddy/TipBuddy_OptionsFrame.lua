--[[

	TipBuddy: ---------
		copyright 2005 by Chester

]]

--------------------------------------------------------------------------------------------------------------------------------------
-- OPTIONS FRAME
--------------------------------------------------------------------------------------------------------------------------------------
function TipBuddy_ToggleOptionsFrame()
	if ( TipBuddy_OptionsFrame:IsVisible() ) then
		HideUIPanel(TipBuddy_OptionsFrame);
		PlaySound("gsTitleOptionExit");
		-- Check if the options frame was opened by myAddOns
--[[		if (MYADDONS_ACTIVE_OPTIONSFRAME == this) then
			ShowUIPanel(myAddOnsFrame);
		else
			ShowUIPanel(GameMenuFrame);
		end]]
	else
		TipBuddy_OptionsFrame_UpdateCheckboxes();
		TipBuddy_OptionsFrame_UpdateSliders();
		TipBuddy_OptionsFrame_UpdateColorButtons();
		TipBuddy_OptionsFrame_UpdateColorButtons_Text();
		TipBuddy_OptionsFrame_UpdateEditBoxes();

		TipBuddy_Background_ColorPick_OnLoad();

		HideUIPanel(GameMenuFrame);
		ShowUIPanel(TipBuddy_OptionsFrame);
		PlaySound("igMainMenuQuit");
	end
end

function TipBuddy_OptionsFrame_OnLoad()
	TipBuddy_OptionsFrameHeaderText:SetText("TipBuddy Options");
	TipBuddy_UpdateTabs_Initialize();
	PanelTemplates_SetNumTabs(TipBuddy_OptionsFrame_PlayersFrame, 3);
	PanelTemplates_SetNumTabs(TipBuddy_OptionsFrame_NPCsFrame, 3);
	PanelTemplates_SetNumTabs(TipBuddy_OptionsFrame_PetsFrame, 2);
	TipBuddy_HideOptionPanels();
	TipBuddy_OptionsFrame_PlayersFrame:Show();
end

function LoadTipBuddyButtonTextures(name)
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	this:RegisterEvent("UPDATE_BINDINGS");
	local prefix = "Interface\\AddOns\\TipBuddy\\gfx\\UI-MicroButton-";
	this:SetNormalTexture(prefix..name.."-Up");
	this:SetPushedTexture(prefix..name.."-Down");
	this:SetDisabledTexture(prefix..name.."-Disabled");
	this:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight");
end

function TipBuddy_HideOptionPanels()
	TipBuddy_OptionsFrame_PlayersFrame:Hide();
	TipBuddy_OptionsFrame_NPCsFrame:Hide();
	TipBuddy_OptionsFrame_PetsFrame:Hide();
	TipBuddy_OptionsFrame_CORPSEFrame:Hide();
	TipBuddy_OptionsFrame_General_Options:Hide();
	TipBuddy_OptionsFrame_Anchoring_Options:Hide();
	TipBuddy_OptionsFrame_Compact_Options:Hide();
end
---------------------------------------------------------------
-- UPDATING DUE TO CHECKBOXES
---------------------------------------------------------------
function TipBuddy_OptionsFrame_UpdateGreyed()
	--[[
	if ( TB_Op_Check1:GetChecked() ) then
		TipBuddy_ToggleCheckboxFrame( TB_Op_Check1 );
	end
	if ( TB_Op_Check9:GetChecked() ) then
		TipBuddy_ToggleCheckboxFrame( TB_Op_Check9 );
	end
	if ( TB_Op_Check17:GetChecked() ) then
		TipBuddy_ToggleCheckboxFrame( TB_Op_Check17 );
	end
	if ( TB_Op_Check25:GetChecked() ) then
		TipBuddy_ToggleCheckboxFrame( TB_Op_Check25 );
	end
	if ( TB_Op_Check33:GetChecked() ) then
		TipBuddy_ToggleCheckboxFrame( TB_Op_Check33 );
	end
	if ( TB_Op_Check41:GetChecked() ) then
		TipBuddy_ToggleCheckboxFrame( TB_Op_Check41 );
	end
	if ( TB_Op_Check49:GetChecked() ) then
		TipBuddy_ToggleCheckboxFrame( TB_Op_Check49 );
	end]]
	if ( TB_Op_Check57:GetChecked() ) then
		TB_Op_Check61:Disable();
		getglobal("TB_Op_Check61Text"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	else
		TB_Op_Check61:Enable();
		getglobal("TB_Op_Check61Text"):SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end
end

function TipBuddy_OptionsFrame_UpdateCheckboxes()
	for index, value in TB_Op_Checks do
		local button = getglobal( value.frame );
		local string = getglobal( value.frame.."Text");

		if (not button) then
			return;
		end

		local tipTable = TipBuddy_SavedVars[value.type];
		----TB_AddMessage(value.type);
		button:SetChecked( tipTable[value.var] );

		string:SetText( TEXT(value.text) );
		button.tooltipText = value.tooltipText;
		button.tooltipRequirement = value.tooltipRequirement;
		button.gxRestart = value.gxRestart;
		button.restartClient = value.restartClient;

		if ( button.disabled ) then
			button:Disable();
			string:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		else
			button:Enable();
			string:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		end
	end
end

function TipBuddy_OptionsFrame_UpdateSliders()
	for index, value in TipBuddy_OptionsFrame_Sliders do
		local slider = getglobal("TipBuddy_OptionsFrame_Slider"..index);
		local string = getglobal("TipBuddy_OptionsFrame_Slider"..index.."Text");
		local high = getglobal("TipBuddy_OptionsFrame_Slider"..index.."High");
		local low = getglobal("TipBuddy_OptionsFrame_Slider"..index.."Low");

		TipBuddy_OptionsFrame_SliderCalcEnabled( slider );

		if (index == 1) then
			low:SetText( "Small" );
			high:SetText( "Large" );			
		else
			low:SetText( value.minValue );
			high:SetText( value.maxValue );			
		end

		local tipTable = TipBuddy_SavedVars["general"];

		slider:SetMinMaxValues(value.minValue, value.maxValue);
		slider:SetValueStep(value.valueStep);

		slider:SetValue( tipTable[value.var] );

		string:SetText(TEXT(value.text));
		slider.tooltipText = value.tooltipText;
		slider.tooltipRequirement = value.tooltipRequirement;
		slider.gxRestart = value.gxRestart;
		slider.restartClient = value.restartClient;
	end
end

function TipBuddy_OptionsFrame_SliderCalcEnabled( slider )
	local thumb = getglobal(slider:GetName().."Thumb");
	local string = getglobal(slider:GetName().."Text");
	local updatetext = getglobal(slider:GetName().."TextUpdate");
	local high = getglobal(slider:GetName().."High");
	local low = getglobal(slider:GetName().."Low");
	if ( slider.disabled ) then
		slider:EnableMouse(0);
		thumb:Hide();
		string:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		updatetext:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		low:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		high:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	else
		slider:EnableMouse(1);
		thumb:Show();
		string:SetVertexColor(NORMAL_FONT_COLOR.r , NORMAL_FONT_COLOR.g , NORMAL_FONT_COLOR.b);
		updatetext:SetVertexColor(NORMAL_FONT_COLOR.r , NORMAL_FONT_COLOR.g , NORMAL_FONT_COLOR.b);
		low:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		high:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	end
end

function TipBuddy_OptionsFrame_UpdateEditBoxes()
	for index, value in TB_EditBoxes do
		local editbox = getglobal( value.frame );
		--local string = getglobal( value.frame.."Text");

		if (not editbox) then
			return;
		end

		local tipTable = TipBuddy_SavedVars[value.type];
		----TB_AddMessage(value.type);
		if (not tipTable[value.var]) then
			DEFAULT_CHAT_FRAME:AddMessage("|cff3366ffSETTING BLANK VAR with: "..TEXT(value.type));
			tipTable[value.var] = "";
		end
		editbox:SetText( tipTable[value.var] );
	end
end

function TipBuddy_OptionsFrame_UpdateDropDowns()
	OptionsFrame_EnableDropDown(UIOptionsFrameClickCameraDropDown);
end

---------------------------------------------------------------
-- TOGGLING ALL CHECKBOXES WHEN DISABLE ALL
---------------------------------------------------------------
function TipBuddy_ToggleCheckboxFrame( checkBox )
	local button = getglobal( checkBox:GetName() );
	local boxId = button:GetID();

--	--TB_AddMessage(button:GetID());

	if ( button:GetChecked() ) then
		for i=1, 7, 1 do
			local boxName = getglobal( "TB_Op_Check"..(boxId + i) );
			if (boxName == 0) then
				return;				
			end
			TipBuddy_DisableCheckBox(boxName);
		end
	else
		for i=1, 7, 1 do
			local boxName = getglobal( "TB_Op_Check"..(boxId + i) );
			if (boxName == 0) then
				return;				
			end
			TipBuddy_EnableCheckBox(boxName);
		end
	end
end

function TipBuddy_DisableCheckBox(checkBox)
--	checkBox:SetChecked(0);
	checkBox:Disable();
	getglobal(checkBox:GetName().."Text"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
end

function TipBuddy_EnableCheckBox(checkBox, checked)
--	if ( checkBox:GetChecked() ) then
--		return;
--	end
--	checkBox:SetChecked(checked);
	checkBox:Enable();
	getglobal(checkBox:GetName().."Text"):SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
end

function TipBuddy_UpdateTabs_Initialize()
--	local frame = getglobal( this:GetName() );
--	PanelTemplates_SetTab( TipBuddy_OptionsFrame_PlayersFrame, 1 );
	TipBuddy_OptionsFrame_PCFriend_Options:Show();
	TipBuddy_OptionsFrame_PCEnemy_Options:Hide();
	TipBuddy_OptionsFrame_PCParty_Options:Hide();

	TipBuddy_OptionsFrame_NPCFriend_Options:Show();
	TipBuddy_OptionsFrame_NPCNeutral_Options:Hide();
	TipBuddy_OptionsFrame_NPCEnemy_Options:Hide();

	TipBuddy_OptionsFrame_PETFriend_Options:Show();
	TipBuddy_OptionsFrame_PETEnemy_Options:Hide();

	TipBuddy_OptionsFrame_CORPSE_Options:Show();
end


function TipBuddy_PlayersFrameTab_OnClick(index)
	if ( not index ) then
		index = this:GetID();
	end
--	local frame = getglobal( this:GetName() );
	PanelTemplates_SetTab( TipBuddy_OptionsFrame_PlayersFrame, index );
	TipBuddy_OptionsFrame_PCFriend_Options:Hide();
	TipBuddy_OptionsFrame_PCEnemy_Options:Hide();
	TipBuddy_OptionsFrame_PCParty_Options:Hide();
	PlaySound("igCharacterInfoTab");
	if ( index == 1 ) then
		-- Friendly
		TipBuddy_OptionsFrame_PCFriend_Options:Show();
	elseif ( index == 2 ) then
		-- Enemy
		TipBuddy_OptionsFrame_PCParty_Options:Show();
	elseif ( index == 3 ) then
		-- InParty
		TipBuddy_OptionsFrame_PCEnemy_Options:Show();
	end
end

function TipBuddy_NPCsFrameTab_OnClick(index)
	if ( not index ) then
		index = this:GetID();
	end
--	local frame = getglobal( this:GetName() );
	PanelTemplates_SetTab( TipBuddy_OptionsFrame_NPCsFrame, index );
	TipBuddy_OptionsFrame_NPCFriend_Options:Hide();
	TipBuddy_OptionsFrame_NPCNeutral_Options:Hide();
	TipBuddy_OptionsFrame_NPCEnemy_Options:Hide();
	PlaySound("igCharacterInfoTab");
	if ( index == 1 ) then
		-- Friendly
		TipBuddy_OptionsFrame_NPCFriend_Options:Show();
	elseif ( index == 2 ) then
		-- Neutral
		TipBuddy_OptionsFrame_NPCNeutral_Options:Show();
	elseif ( index == 3 ) then
		-- Enemy
		TipBuddy_OptionsFrame_NPCEnemy_Options:Show();
	end
end

function TipBuddy_PetsFrameTab_OnClick(index)
	if ( not index ) then
		index = this:GetID();
	end
--	local frame = getglobal( this:GetName() );
	PanelTemplates_SetTab( TipBuddy_OptionsFrame_PetsFrame, index );
	TipBuddy_OptionsFrame_PETFriend_Options:Hide();
	TipBuddy_OptionsFrame_PETEnemy_Options:Hide();
	PlaySound("igCharacterInfoTab");
	if ( index == 1 ) then
		-- Friendly
		TipBuddy_OptionsFrame_PETFriend_Options:Show();
	elseif ( index == 2 ) then
		-- InParty
		TipBuddy_OptionsFrame_PETEnemy_Options:Show();
	end
end

function TipBuddy_OptionsFrameTab_OnClick(index)
	if ( not index ) then
		index = this:GetID();
	end
--	local frame = getglobal( this:GetName() );
	--PanelTemplates_SetTab( TipBuddy_OptionsFrame_PlayersFrame, index );
	TipBuddy_OptionsFrame_General_Options:Hide();
	TipBuddy_OptionsFrame_Compact_Options:Hide();
	PlaySound("igCharacterInfoTab");
	if ( index == 1 ) then
		TipBuddy_OptionsFrame_General_Options:Show();
		TipBuddy_OptionsFrame_GeneralOptionsTitleText:SetTextColor(1.0, 1.0, 1.0);
		TipBuddy_OptionsFrame_CompactOptionsTitleText:SetTextColor(0.3, 0.3, 0.1);
	elseif ( index == 2 ) then
		TipBuddy_OptionsFrame_Compact_Options:Show();
		TipBuddy_OptionsFrame_CompactOptionsTitleText:SetTextColor(1.0, 1.0, 1.0);
		TipBuddy_OptionsFrame_GeneralOptionsTitleText:SetTextColor(0.3, 0.3, 0.1);
	end
end

--------------------------------------------------------------------------------------------------------------------------------------
-- FRAME BACKGROUND COLOR PICKER
--------------------------------------------------------------------------------------------------------------------------------------
function TipBuddy_Background_ColorPick_OnLoad()
	cInfo = {};
end

function TipBuddy_Background_ColorPick( button )

	local name = getglobal( button:GetName() );
	local id = name:GetID();
	cInfo.type = TipBuddy_ColorPicker_Buttons[id].type;
	cInfo.var = TipBuddy_ColorPicker_Buttons[id].var;

	local targettype = TipBuddy_SavedVars[cInfo.type][cInfo.var];	
	if (not targettype) then
		TipBuddy_SavedVars[cInfo.type][cInfo.var] = { ["r"] = 0.8, ["g"] = 0.8, ["b"] = 0.9, ["a"] = 1, };
		targettype = TipBuddy_SavedVars[value.type][value.var];	
	end
--TB_AddMessage("frame: "..button:GetName());
--TB_AddMessage("type: "..TEXT(cInfo.type));
	TBColorPickerFrame.func = TipBuddy_Background_SetColor;
	TBColorPickerFrame.hasOpacity = 1;
	TBColorPickerFrame.opacityFunc = TipBuddy_Background_SetOpacity;
	TBColorPickerFrame.cancelFunc = TipBuddy_Background_Cancel;

	TBColorPickerFrame:SetColorRGB( targettype.r, targettype.g, targettype.b);
	TBColorPickerFrame.opacity = (1- targettype.a);
	TBColorPickerFrame.previousValues = {r=targettype.r, g=targettype.g, b=targettype.b, opacity=targettype.a};

	ShowUIPanel(TBColorPickerFrame);
	--TB_AddMessage("just passed ShowUIPanel");
end

function TipBuddy_Text_ColorPick( button )

	local name = getglobal( button:GetName() );
	local id = name:GetID();
	cInfo.type = TipBuddy_ColorPicker_Buttons_Text[id].type;
	cInfo.var = TipBuddy_ColorPicker_Buttons_Text[id].var;

	local targettype = TipBuddy_SavedVars[cInfo.type][cInfo.var];	

----TB_AddMessage("frame: "..cInfo.name);
----TB_AddMessage("type: "..type);
	TBColorPickerFrame_Text.func = TipBuddy_Background_SetColor_Text;
	--TBColorPickerFrame_Text.hasOpacity = 1;
	--TBColorPickerFrame_Text.opacityFunc = TipBuddy_Background_SetOpacity;
	TBColorPickerFrame_Text.cancelFunc = TipBuddy_Background_Cancel;

	TBColorPickerFrame_Text:SetColorRGB( targettype.r, targettype.g, targettype.b);
	--TBColorPickerFrame_Text.opacity = (1- targettype.bgcolor.a);
	TBColorPickerFrame_Text.previousValues = {r=targettype.r, g=targettype.g, b=targettype.b, opacity=targettype.a};

	ShowUIPanel(TBColorPickerFrame_Text);
	--TB_AddMessage("just passed ShowUIPanel");
end

function TipBuddy_OptionsFrame_UpdateColorButtons()
	for index, value in TipBuddy_ColorPicker_Buttons do
		--TB_AddMessage(getn(TipBuddy_ColorPicker_Buttons));
		--TB_AddMessage(index);
		local button = getglobal( value.frame );
		local swatch = getglobal( value.frame.."NormalTexture");
		local string = getglobal( value.frame.."Text");
--		local type = getglobal( value.type );
		--TB_AddMessage("Color: ["..value.type.."]["..value.var.."]");
		
		if (not button) then
			return;
		end
			
		local targettype = TipBuddy_SavedVars[value.type][value.var];

		if (not targettype) then
			TipBuddy_SavedVars[value.type][value.var] = { ["r"] = 0.8, ["g"] = 0.8, ["b"] = 0.9, ["a"] = 1, };
			targettype = TipBuddy_SavedVars[value.type][value.var];	
		end

		string:SetText(TEXT(value.text));
		if (value.text) then
			----TB_AddMessage("frame:"..TEXT(value.frame).."colorbutton text: "..value.text);	
		end
		button.tooltipText = value.tooltipText;
		button.tooltipRequirement = value.tooltipRequirement;
		swatch:SetVertexColor( targettype.r, targettype.g, targettype.b );
		if (index < 10 or index == 21) then
			if (button:IsVisible()) then
				button:GetParent():SetBackdropColor( targettype.r, targettype.g, targettype.b, TB_NoNegative(targettype.a-0.2) );				
			else
				button:GetParent():SetBackdropColor( 0.2, 0.2, 0.2, 1 );								
			end
		elseif (index > 10 and index < 20 or index == 22) then
			if (button:IsVisible()) then
				button:GetParent():SetBackdropBorderColor( targettype.r, targettype.g, targettype.b, TB_NoNegative(targettype.a-0.2) );
			else
				button:GetParent():SetBackdropBorderColor( 0.8, 0.8, 0.9, 1 );
			end
		end

	end
end

function TipBuddy_OptionsFrame_UpdateColorButtons_Text()
	for index, value in TipBuddy_ColorPicker_Buttons_Text do
		local button = getglobal( value.frame );
		local swatch = getglobal( value.frame.."NormalTexture");
		local string = getglobal( value.frame.."Text");
--		local type = getglobal( value.type );
		----TB_AddMessage("Color: ["..value.type.."]["..value.var.."]");
		
		if (not button) then
			return;
		end
			
		local targettype = TipBuddy_SavedVars[value.type][value.var];

		string:SetText(TEXT(value.text));
		button.tooltipText = value.tooltipText;
		button.tooltipRequirement = value.tooltipRequirement;
		swatch:SetVertexColor( targettype.r, targettype.g, targettype.b );
		string:SetTextColor(targettype.r, targettype.g, targettype.b);
	end
end


function TipBuddy_Background_SetColor()
	local targettype = TipBuddy_SavedVars[cInfo.type][cInfo.var];

	local r,g,b = TBColorPickerFrame:GetColorRGB();
--	TipBuddy_Main_Frame:SetBackdropColor(r, g, b);

	if (not targettype) then
		TipBuddy_SavedVars[cInfo.type][cInfo.var] = {};
		targettype = TipBuddy_SavedVars[cInfo.type][cInfo.var];
	end
	targettype.r = r;
	targettype.g = g;
	targettype.b = b;		
end

function TipBuddy_Background_SetColor_Text()
	local targettype = TipBuddy_SavedVars[cInfo.type][cInfo.var];

	local r,g,b = TBColorPickerFrame_Text:GetColorRGB();
--	TipBuddy_Main_Frame:SetBackdropColor(r, g, b);

	targettype.r = r;
	targettype.g = g;
	targettype.b = b;		
end

function TipBuddy_Background_SetOpacity()
	local targettype = TipBuddy_SavedVars[cInfo.type][cInfo.var];

	local alpha = 1.0 - TBOpacitySliderFrame:GetValue();
	if (not targettype) then
		targettype = {};
	end
	targettype.a = (1- TBOpacitySliderFrame:GetValue());
end

function TipBuddy_Background_Cancel(previousValues)
	local targettype = TipBuddy_SavedVars[cInfo.type][cInfo.var];

	if (not targettype) then
		targettype = {};
	end
	if (previousValues.r and previousValues.g and previousValues.b) then
		targettype.r = previousValues.r;
		targettype.g = previousValues.g;
		targettype.b = previousValues.b;
	end
	if (previousValues.opacity) then
		local alpha = 1.0 - previousValues.opacity;
		targettype.a = previousValues.opacity;
	end
end


TipBuddy_CursorPos = {
	[1] = "Top",
	[2] = "Right",
	[3] = "Left",
	[4] = "Bottom", 
};

function TipBuddy_CursorPosDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, TipBuddy_CursorPosDropDown_Initialize);
	UIDropDownMenu_SetSelectedValue(this, TipBuddy_SavedVars["general"].cursorpos);
	UIDropDownMenu_SetWidth(120, TipBuddy_CursorPosDropDown);
end

function TipBuddy_CursorPosDropDown_OnClick()
	UIDropDownMenu_SetSelectedValue(TipBuddy_CursorPosDropDown, this.value);
	TipBuddy.xpoint, TipBuddy.xpos, TipBuddy.ypos = TipBuddy_GetFrameCursorOffset();
	TipBuddy.anchor, TipBuddy.fanchor, TipBuddy.offset = TipBuddy_GetFrameAnchorPos();
	if (TipBuddy_SavedVars["general"].anchored == 1) then
		TipBuddy_Parent_Frame:SetPoint(TipBuddy.anchor, "TipBuddy_Header_Frame", TipBuddy.fanchor, 0, 0);
	end
	TipBuddy_SetFrame_Anchor( TipBuddy_Main_Frame );
	GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
end

function TipBuddy_CursorPosDropDown_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(TipBuddy_CursorPosDropDown);
	local info;

	info = {};
	info.text = TipBuddy_CursorPos[1];
	info.func = TipBuddy_CursorPosDropDown_OnClick;
	info.value = "Top";
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	info.tooltipTitle = "Postion the tooltip ABOVE your cursor";
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TipBuddy_CursorPos[2];
	info.func = TipBuddy_CursorPosDropDown_OnClick;
	info.value = "Right";
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	info.tooltipTitle = "Position the tooltip to the RIGHT of your cursor";
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TipBuddy_CursorPos[3];
	info.func = TipBuddy_CursorPosDropDown_OnClick;
	info.value = "Left";
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	info.tooltipTitle = "Position the tooltip to the LEFT of your cursor";
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TipBuddy_CursorPos[4];
	info.func = TipBuddy_CursorPosDropDown_OnClick;
	info.value = "Bottom";
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	info.tooltipTitle = "Position the tooltip BELOW your cursor";
	UIDropDownMenu_AddButton(info);
end

--non-unit tips
TipBuddy_NonUnitTipPos = {
	[1] = "Cursor",
	[2] = "TipBuddyAnchor",
	[3] = "Smart Anchor", 
};

function TipBuddy_NonUnitTipPosDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, TipBuddy_NonUnitTipPosDropDown_Initialize);
	UIDropDownMenu_SetSelectedValue(this, TipBuddy_SavedVars["general"].nonunit_anchor);
	UIDropDownMenu_SetWidth(120, TipBuddy_NonUnitTipPosDropDown);
end

function TipBuddy_NonUnitTipPosDropDown_OnClick()
	UIDropDownMenu_SetSelectedValue(TipBuddy_NonUnitTipPosDropDown, this.value);
	TipBuddy.xpoint, TipBuddy.xpos, TipBuddy.ypos = TipBuddy_GetFrameCursorOffset();
	TipBuddy.anchor, TipBuddy.fanchor, TipBuddy.offset = TipBuddy_GetFrameAnchorPos();
	GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
	--if (UIDropDownMenu_GetSelectedValue(TipBuddy_NonUnitTipPosDropDown)) then
		TipBuddy_SavedVars["general"].nonunit_anchor = this.value;	
	--end
	--/script DEFAULT_CHAT_FRAME:AddMessage(UIDropDownMenu_GetSelectedValue(TipBuddy_NonUnitTipPosDropDown));
	--/script DEFAULT_CHAT_FRAME:AddMessage(TipBuddy_SavedVars["general"].nonunit_anchor);
end

function TipBuddy_NonUnitTipPosDropDown_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(TipBuddy_NonUnitTipPosDropDown);
	local info;

	info = {};
	info.text = TipBuddy_NonUnitTipPos[1];
	info.func = TipBuddy_NonUnitTipPosDropDown_OnClick;
	info.value = 0;
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	info.tooltipTitle = "Non-Unit tooltips will\nfollow the cursor";
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TipBuddy_NonUnitTipPos[2];
	info.func = TipBuddy_NonUnitTipPosDropDown_OnClick;
	info.value = 1;
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	info.tooltipTitle = "Non-Unit tooltips will\nattach themselves to\nthe TipBuddyAnchor";
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TipBuddy_NonUnitTipPos[3];
	info.func = TipBuddy_NonUnitTipPosDropDown_OnClick;
	info.value = 2;
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	info.tooltipTitle = "Non-Unit tooltips will attempt to\nattach themselves to the button\nor object you have your mouse\nover in a smart position";
	UIDropDownMenu_AddButton(info);

end

--Tooltip Style (Compact, Default, Advanced)
TipBuddy_TipStyle = {
	[1] = "Default Mode",
	[2] = "Compact Mode",
	[3] = "Advanced Mode", 
};

function TipBuddy_TipStyleDropDown_OnLoad( type )
	this.type = type;
	if (not TipBuddy_SavedVars[this.type].off) then
		TipBuddy_SavedVars[this.type].off = 0;	
	end
	--TB_AddMessage( this.type.." : "..TipBuddy_SavedVars[this.type].off );
	----TB_AddMessage( this.type );
	UIDropDownMenu_Initialize(this, TipBuddy_TipStyleDropDown_Initialize, nil, this.type );
	UIDropDownMenu_SetSelectedValue(this, TipBuddy_SavedVars[this.type].off);
	UIDropDownMenu_SetWidth(120, TipBuddy_TipStyleDropDown);
	TipBuddy_TipStyleDropDown_SetFrameVisibility(this, TipBuddy_SavedVars[this.type].off);
	--/script DEFAULT_CHAT_FRAME:AddMessage(UIDropDownMenu_GetSelectedValue(TB_NPCNeutral_TipStyleDropDown));
end

function TipBuddy_TipStyleDropDown_OnClick()
	--TB_AddMessage( this.owner:GetName() );
	UIDropDownMenu_SetSelectedValue(this.owner, this.value);
	TipBuddy_SavedVars[this.owner.type].off = UIDropDownMenu_GetSelectedValue(this.owner);
	TipBuddy_TipStyleDropDown_SetFrameVisibility(this.owner, this.value)
end

function TB_TipStyle_OptionsToggleFrames( value, type, colornum )
	if (value == 0) then
			getglobal("TipBuddy_OptionsFrame_"..type.."_Options_Checks"):Show();
			getglobal("TipBuddy_OptionsFrame_"..type.."_Options_EB"):Hide();
			getglobal("TB_"..type.."_BDBColorDropDown"):Show();
			TipBuddy_BDBColorDropDown_SetFrameVisibility(getglobal("TB_"..type.."_BDBColorDropDown"), UIDropDownMenu_GetSelectedValue(getglobal("TB_"..type.."_BDBColorDropDown")));		
	elseif (value == 1) then
			getglobal("TipBuddy_OptionsFrame_"..type.."_Options_Checks"):Show();
			getglobal("TipBuddy_OptionsFrame_"..type.."_Options_EB"):Hide();
			getglobal("TB_"..type.."_BDBColorDropDown"):Hide();
			getglobal("TipBuddy_OptionsFrame_ColorPicker"..colornum):Hide();
			getglobal("TipBuddy_OptionsFrame_"..type.."_Options"):SetBackdropBorderColor(0, 0, 0, 1);
	else
			getglobal("TipBuddy_OptionsFrame_"..type.."_Options_Checks"):Hide();
			getglobal("TipBuddy_OptionsFrame_"..type.."_Options_EB"):Show();
			getglobal("TB_"..type.."_BDBColorDropDown"):Show();
			TipBuddy_BDBColorDropDown_SetFrameVisibility(getglobal("TB_"..type.."_BDBColorDropDown"), UIDropDownMenu_GetSelectedValue(getglobal("TB_"..type.."_BDBColorDropDown")));
	end
end


function TipBuddy_TipStyleDropDown_SetFrameVisibility(frame, value)
	if (frame.type == "pc_friend") then
		TB_TipStyle_OptionsToggleFrames( value, "PCFriend", 11 );
	elseif (frame.type == "pc_party") then
		TB_TipStyle_OptionsToggleFrames( value, "PCParty", 12 );
	elseif (frame.type == "pc_enemy") then
		TB_TipStyle_OptionsToggleFrames( value, "PCEnemy", 13 );
	elseif (frame.type == "npc_friend") then
		TB_TipStyle_OptionsToggleFrames( value, "NPCFriend", 14 );
	elseif (frame.type == "npc_neutral") then
		TB_TipStyle_OptionsToggleFrames( value, "NPCNeutral", 15 );
	elseif (frame.type == "npc_enemy") then
		TB_TipStyle_OptionsToggleFrames( value, "NPCEnemy", 16 );
	elseif (frame.type == "pet_friend") then
		TB_TipStyle_OptionsToggleFrames( value, "PETFriend", 17 );
	elseif (frame.type == "pet_enemy") then
		TB_TipStyle_OptionsToggleFrames( value, "PETEnemy", 18 );
	elseif (frame.type == "corpse") then
		TB_TipStyle_OptionsToggleFrames( value, "CORPSE", 20 );
	else	
	end		
end

function TipBuddy_TipStyleDropDown_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(this);
	local info;

	info = {};
	info.text = TipBuddy_TipStyle[1];
	info.func = TipBuddy_TipStyleDropDown_OnClick;
	info.value = 0;
	info.owner = this:GetParent();
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	info.tooltipTitle = "Default mode is similar\nto Blizzard's default tooltips,\nbut much more customizable";
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TipBuddy_TipStyle[2];
	info.func = TipBuddy_TipStyleDropDown_OnClick;
	info.value = 1;
	info.owner = this:GetParent();
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	info.tooltipTitle = "Compact Mode has a \ncleaner, smaller style.";
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TipBuddy_TipStyle[3];
	info.func = TipBuddy_TipStyleDropDown_OnClick;
	info.value = 2;
	info.owner = this:GetParent();
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	info.tooltipTitle = "For Advanced Users only.";
	UIDropDownMenu_AddButton(info);

end

--Tooltip Backdrop Colors
TipBuddy_BDColor = {
	[1] = "Custom",
	[2] = "Difficulty",
	[3] = "Reaction", 
};

function TipBuddy_BDColorDropDown_OnLoad( type )
	this.type = type;
	if (not TipBuddy_SavedVars[type].c_bdp) then
		TipBuddy_SavedVars[type].c_bdp = 0;	
	end
	--TB_AddMessage( this.type.." : "..TipBuddy_SavedVars[this.type].c_bdp );
	----TB_AddMessage( this.type );
	UIDropDownMenu_Initialize(this, TipBuddy_BDColorDropDown_Initialize, nil, this.type );
	UIDropDownMenu_SetSelectedValue(this, TipBuddy_SavedVars[this.type].c_bdp);
	UIDropDownMenu_SetWidth(110, TipBuddy_BDColorDropDown);
	TipBuddy_BDColorDropDown_SetFrameVisibility(this, TipBuddy_SavedVars[this.type].c_bdp)
end

function TipBuddy_BDColorDropDown_OnClick()
	--TB_AddMessage( this.owner:GetName().." : "..this.owner.type.." : "..this.value );
	UIDropDownMenu_SetSelectedValue(this.owner, this.value);
	TipBuddy_SavedVars[this.owner.type].c_bdp = this.value;
	TipBuddy_BDColorDropDown_SetFrameVisibility(this.owner, this.value)
end

function TipBuddy_BDColorDropDown_SetFrameVisibility(frame, value)
	local button;
	if (value == 0) then
		if (frame.type == "pc_friend") then
			button = TipBuddy_OptionsFrame_ColorPicker1;
		elseif (frame.type == "pc_party") then
			button = TipBuddy_OptionsFrame_ColorPicker2;
		elseif (frame.type == "pc_enemy") then
			button = TipBuddy_OptionsFrame_ColorPicker3;
		elseif (frame.type == "npc_friend") then
			button = TipBuddy_OptionsFrame_ColorPicker4;
		elseif (frame.type == "npc_neutral") then
			button = TipBuddy_OptionsFrame_ColorPicker5;
		elseif (frame.type == "npc_enemy") then
			button = TipBuddy_OptionsFrame_ColorPicker6;
		elseif (frame.type == "pet_friend") then
			button = TipBuddy_OptionsFrame_ColorPicker7;
		elseif (frame.type == "pet_enemy") then
			button = TipBuddy_OptionsFrame_ColorPicker8;
		elseif (frame.type == "corpse") then
			button = TipBuddy_OptionsFrame_ColorPicker10;
		else	
			return;
		end
		button:Show();
		local targettype = TipBuddy_SavedVars[frame.type]["bgcolor"];
		if (not targettype) then
			TipBuddy_SavedVars[value.type]["bgcolor"] = { ["r"] = 0.8, ["g"] = 0.8, ["b"] = 0.9, ["a"] = 1, };
			targettype = TipBuddy_SavedVars[frame.type]["bgcolor"];	
		end		
		button:GetParent():SetBackdropColor(targettype.r, targettype.g, targettype.b, TB_NoNegative(targettype.a-0.2));
		--button:GetParent():SetBackdropBorderColor(targettype.r, targettype.g, targettype.b, TB_NoNegative(targettype.a-0.2));
	else
		if (frame.type == "pc_friend") then
			button = TipBuddy_OptionsFrame_ColorPicker1;	
		elseif (frame.type == "pc_party") then
			button = TipBuddy_OptionsFrame_ColorPicker2;
		elseif (frame.type == "pc_enemy") then
			button = TipBuddy_OptionsFrame_ColorPicker3;
		elseif (frame.type == "npc_friend") then
			button = TipBuddy_OptionsFrame_ColorPicker4;
		elseif (frame.type == "npc_neutral") then
			button = TipBuddy_OptionsFrame_ColorPicker5;
		elseif (frame.type == "npc_enemy") then
			button = TipBuddy_OptionsFrame_ColorPicker6;
		elseif (frame.type == "pet_friend") then
			button = TipBuddy_OptionsFrame_ColorPicker7;
		elseif (frame.type == "pet_enemy") then
			button = TipBuddy_OptionsFrame_ColorPicker8;
		elseif (frame.type == "corpse") then
			button = TipBuddy_OptionsFrame_ColorPicker10;
		else	
			return;
		end	
		button:Hide();
		button:GetParent():SetBackdropColor(0.2, 0.2, 0.2, 1);
		--button:GetParent():SetBackdropBorderColor(0.8, 0.8, 0.9, 1);
	end
end

function TipBuddy_BDColorDropDown_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(this);
	local info;

	info = {};
	info.text = TipBuddy_BDColor[1];
	info.func = TipBuddy_BDColorDropDown_OnClick;
	info.value = 0;
	info.owner = this:GetParent();
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	info.tooltipTitle = "Choose your custom color by\nclicking the box to the right.";
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TipBuddy_BDColor[2];
	info.func = TipBuddy_BDColorDropDown_OnClick;
	info.value = 1;
	info.owner = this:GetParent();
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	info.tooltipTitle = "Color will be determined\nby the unit's difficulty\n(red, yellow, grey, etc).";
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TipBuddy_BDColor[3];
	info.func = TipBuddy_BDColorDropDown_OnClick;
	info.value = 2;
	info.owner = this:GetParent();
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	info.tooltipTitle = "Color is determined by th\n unit's reaction towards you.";
	UIDropDownMenu_AddButton(info);

end

--Tooltip Backdrop BORDER Colors
TipBuddy_BDBColor = {
	[1] = "Custom",
	[2] = "Difficulty",
	[3] = "Reaction", 
};

function TipBuddy_BDBColorDropDown_OnLoad( type )
	this.type = type;
	if (not TipBuddy_SavedVars[this.type].c_bdb) then
		TipBuddy_SavedVars[this.type].c_bdb = 0;	
	end
	--TB_AddMessage( this.type.." : "..TipBuddy_SavedVars[this.type].c_bdb );
	----TB_AddMessage( this.type );
	UIDropDownMenu_Initialize(this, TipBuddy_BDBColorDropDown_Initialize, nil, this.type );
	UIDropDownMenu_SetSelectedValue(this, TipBuddy_SavedVars[this.type].c_bdb);
	UIDropDownMenu_SetWidth(110, TipBuddy_BDBColorDropDown);
	TipBuddy_BDBColorDropDown_SetFrameVisibility(this, TipBuddy_SavedVars[this.type].c_bdb)
end

function TipBuddy_BDBColorDropDown_OnClick()
	--TB_AddMessage( this.owner:GetName() );
	UIDropDownMenu_SetSelectedValue(this.owner, this.value);
	TipBuddy_SavedVars[this.owner.type].c_bdb = this.value;
	TipBuddy_BDBColorDropDown_SetFrameVisibility(this.owner, this.value)
end

function TipBuddy_BDBColorDropDown_SetFrameVisibility(frame, value)
	local button;
	if (value == 0) then
		if (frame.type == "pc_friend") then
			button = TipBuddy_OptionsFrame_ColorPicker11;	
		elseif (frame.type == "pc_party") then
			button = TipBuddy_OptionsFrame_ColorPicker12;
		elseif (frame.type == "pc_enemy") then
			button = TipBuddy_OptionsFrame_ColorPicker13;
		elseif (frame.type == "npc_friend") then
			button = TipBuddy_OptionsFrame_ColorPicker14;
		elseif (frame.type == "npc_neutral") then
			button = TipBuddy_OptionsFrame_ColorPicker15;
		elseif (frame.type == "npc_enemy") then
			button = TipBuddy_OptionsFrame_ColorPicker16;
		elseif (frame.type == "pet_friend") then
			button = TipBuddy_OptionsFrame_ColorPicker17;
		elseif (frame.type == "pet_enemy") then
			button = TipBuddy_OptionsFrame_ColorPicker18;
		elseif (frame.type == "corpse") then
			button = TipBuddy_OptionsFrame_ColorPicker20;
		else	
		end		
		button:Show();
		local targettype = TipBuddy_SavedVars[frame.type]["bgbcolor"];
		if (not targettype) then
			TipBuddy_SavedVars[value.type]["bgbcolor"] = { ["r"] = 0.8, ["g"] = 0.8, ["b"] = 0.9, ["a"] = 1, };
			targettype = TipBuddy_SavedVars[frame.type]["bgbcolor"];	
		end		
		button:GetParent():SetBackdropBorderColor(targettype.r, targettype.g, targettype.b, TB_NoNegative(targettype.a-0.2));
	else
		if (frame.type == "pc_friend") then
			button = TipBuddy_OptionsFrame_ColorPicker11;	
		elseif (frame.type == "pc_party") then
			button = TipBuddy_OptionsFrame_ColorPicker12;
		elseif (frame.type == "pc_enemy") then
			button = TipBuddy_OptionsFrame_ColorPicker13;
		elseif (frame.type == "npc_friend") then
			button = TipBuddy_OptionsFrame_ColorPicker14;
		elseif (frame.type == "npc_neutral") then
			button = TipBuddy_OptionsFrame_ColorPicker15;
		elseif (frame.type == "npc_enemy") then
			button = TipBuddy_OptionsFrame_ColorPicker16;
		elseif (frame.type == "pet_friend") then
			button = TipBuddy_OptionsFrame_ColorPicker17;
		elseif (frame.type == "pet_enemy") then
			button = TipBuddy_OptionsFrame_ColorPicker18;
		elseif (frame.type == "corpse") then
			button = TipBuddy_OptionsFrame_ColorPicker20;
		else	
		end
		button:Hide();
		button:GetParent():SetBackdropBorderColor(0.8, 0.8, 0.9, 1);
	end
end

function TipBuddy_BDBColorDropDown_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(this);
	local info;

	info = {};
	info.text = TipBuddy_BDBColor[1];
	info.func = TipBuddy_BDBColorDropDown_OnClick;
	info.value = 0;
	info.owner = this:GetParent();
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	info.tooltipTitle = "Choose your custom color by\nclicking the box to the right.";
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TipBuddy_BDBColor[2];
	info.func = TipBuddy_BDBColorDropDown_OnClick;
	info.value = 1;
	info.owner = this:GetParent();
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	info.tooltipTitle = "Color will be determined\nby the unit's difficulty\n(red, yellow, grey, etc).";
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TipBuddy_BDBColor[3];
	info.func = TipBuddy_BDBColorDropDown_OnClick;
	info.value = 2;
	info.owner = this:GetParent();
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	info.tooltipTitle = "Color is determined by th\n unit's reaction towards you.";
	UIDropDownMenu_AddButton(info);

end

---------------------------------------------------------------
-- SAVING FRAME POSITION AFTER DRAGGED
---------------------------------------------------------------
-- this function is called when the frame should be dragged around
function TipBuddy_OnMouseDown(arg1)
	if (arg1 == "LeftButton") then
		TipBuddy_Header_Frame:StartMoving();
	end
end

-- this function is called when the frame is stopped being dragged around
function TipBuddy_OnMouseUp(arg1)
	if (arg1 == "LeftButton") then
		TipBuddy_Header_Frame:StopMovingOrSizing();

		ValidateFramePosition(this, -10);
		
		-- save the position 
		TipBuddy_SavedVars["general"].framepos_L = TipBuddy_Header_Frame:GetLeft();
		TipBuddy_SavedVars["general"].framepos_T = TipBuddy_Header_Frame:GetTop();


	end

	-- If Rightclick bring up the options menu
	if ( arg1 == "RightButton" ) then
		ToggleDropDownMenu(1, TipBuddy_SavedVars["general"].anchor_pos, TipBuddy_Header_FrameDropDown, this:GetName(), 0, 0);
		UIDropDownMenu_SetSelectedValue(this, TipBuddy_SavedVars["general"].anchor_pos);
		return;
	end
	-- Close all dropdowns
	CloseDropDownMenus();
end

function TipBuddy_ResetAnchorPos()
	TipBuddy_Header_Frame:Hide();
	TipBuddy_Header_Frame:Show();
	TipBuddy_Header_Frame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", 202, 400);

	TipBuddy_SavedVars["general"].framepos_L = TipBuddy_Header_Frame:GetLeft();
	TipBuddy_SavedVars["general"].framepos_T = TipBuddy_Header_Frame:GetTop();
end

TipBuddy_AnchorPos = {
	[1] = "Top Right",
	[2] = "Top Left",
	[3] = "Bottom Right",
	[4] = "Bottom Left", 
	[5] = "Top Center", 
	[6] = "Bottom Center", 
};

function TipBuddy_Anchor_OnClick(button)
	-- If Rightclick bring up the options menu
	if ( button == "RightButton" ) then
		ToggleDropDownMenu(0, TipBuddy_SavedVars["general"].anchor_pos, TipBuddy_Header_FrameDropDown, this:GetName(), 0, 0);
		return;
	end
	-- Close all dropdowns
	CloseDropDownMenus();
end


function TipBuddy_AnchorDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, TipBuddy_AnchorDropDown_Initialize, "MENU");
--	TipBuddy_SavedVars["general"]["anchor_pos"] = TipBuddy_AnchorPos[1];
--	UIDropDownMenu_SetSelectedValue(this, nil, TipBuddy_SavedVars["general"]["anchor_pos"]);
	UIDropDownMenu_SetButtonWidth(50);
	UIDropDownMenu_SetWidth(80);
end

--	/script --TB_AddMessage( TipBuddy_SavedVars["general"]["anchor_pos"] );

function TipBuddy_AnchorDropDown_OnClick()
	UIDropDownMenu_SetSelectedValue(TipBuddy_Header_FrameDropDown, this.value);
--	--TB_AddMessage( UIDropDownMenu_GetSelectedValue(TipBuddy_Header_FrameDropDown) );
	TipBuddy_SavedVars["general"].anchor_pos = UIDropDownMenu_GetSelectedValue(TipBuddy_Header_FrameDropDown);
	TipBuddy.xpoint, TipBuddy.xpos, TipBuddy.ypos = TipBuddy_GetFrameCursorOffset();
	TipBuddy.anchor, TipBuddy.fanchor, TipBuddy.offset = TipBuddy_GetFrameAnchorPos();
	TipBuddy_SetFrame_Anchor( TipBuddy_Main_Frame );
	GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
end

function TipBuddy_AnchorDropDown_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(TipBuddy_Header_FrameDropDown);
	local info;

	info = {};
	info.text = TipBuddy_AnchorPos[1];
	info.func = TipBuddy_AnchorDropDown_OnClick;
	info.value = TipBuddy_AnchorPos[1];
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	info.tooltipTitle = "Anchor tooltip to the TOP RIGHT\nof the TipBuddyAnchor";
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TipBuddy_AnchorPos[2];
	info.func = TipBuddy_AnchorDropDown_OnClick;
	info.value = TipBuddy_AnchorPos[2];
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	info.tooltipTitle = "Anchor tooltip to the TOP LEFT\nof the TipBuddyAnchor";
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TipBuddy_AnchorPos[3];
	info.func = TipBuddy_AnchorDropDown_OnClick;
	info.value = TipBuddy_AnchorPos[3];
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	info.tooltipTitle = "Anchor tooltip to the BOTTOM RIGHT\nof the TipBuddyAnchor";
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TipBuddy_AnchorPos[4];
	info.func = TipBuddy_AnchorDropDown_OnClick;
	info.value = TipBuddy_AnchorPos[4];
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	info.tooltipTitle = "Anchor tooltip to the BOTTOM LEFT\nof the TipBuddyAnchor";
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TipBuddy_AnchorPos[5];
	info.func = TipBuddy_AnchorDropDown_OnClick;
	info.value = TipBuddy_AnchorPos[5];
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	info.tooltipTitle = "Anchor tooltip to the BOTTOM CENTER\nof the TipBuddyAnchor";
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TipBuddy_AnchorPos[6];
	info.func = TipBuddy_AnchorDropDown_OnClick;
	info.value = TipBuddy_AnchorPos[6];
	if ( info.value == selectedValue ) then
		info.checked = 1;
	end
	info.tooltipTitle = "Anchor tooltip to the TOP CENTER\nof the TipBuddyAnchor";
	UIDropDownMenu_AddButton(info);
end

function TipBuddy_SetAnchorFrameVis()
	if (TipBuddy_SavedVars["general"].anchored == 1) then
		if (not TipBuddy_SavedVars["general"].anchor_vis_first or TipBuddy_SavedVars["general"].anchor_vis == 1) then
			TipBuddy_SavedVars["general"].anchor_vis_first = 1;
			TipBuddy_Header_Frame:Show();	
		else
			TipBuddy_Header_Frame:Show();
			TipBuddy_Header_Frame:Hide();
		end	
	else
		if (TipBuddy_Header_Frame:IsVisible()) then
			TipBuddy_Header_Frame:Show();
		else
			TipBuddy_Header_Frame:Show();
			TipBuddy_Header_Frame:Hide();			
		end
	end
end

---------------------------------------------------------------
-- SAVING DATA AFTER 'OK'
---------------------------------------------------------------
function TipBuddy_OptionsFrame_OnSave()
	-- Checkboxes
	for index, value in TB_Op_Checks do
		local button = getglobal( value.frame );
		local but = value.frame; --debug
		local tipTable = TipBuddy_SavedVars[value.type];
		--tipTable.vartype = getglobal( value.var );		

		if ( button:GetChecked() ) then
			----TB_AddMessage( "button: "..but.." is checked.");	
			tipTable[value.var] = 1;
			----TB_AddMessage( "Setting button: "..but.." checked ("..tipTable[value.var]..").");
		else
			tipTable[value.var] = 0;
		end
	end

	-- Sliders
	for index, value in TipBuddy_OptionsFrame_Sliders do
		local tipTable = TipBuddy_SavedVars["general"];

		local slider = getglobal("TipBuddy_OptionsFrame_Slider"..index);
		--if (index == 6) then
		--	tipTable[value.var] = (UIParent:GetScale() * slider:GetValue());
		--else
			tipTable[value.var] = slider:GetValue();
		--end
	end

	-- EditBoxes
	for index, value in TB_EditBoxes do
		local editbox = getglobal( value.frame );
		local tipTable = TipBuddy_SavedVars[value.type];
		--tipTable.vartype = getglobal( value.var );		

		tipTable[value.var] = editbox:GetText();
	end

	TipBuddy_SetAnchorFrameVis();

	if (UIDropDownMenu_GetSelectedValue(TipBuddy_CursorPosDropDown)) then
		TipBuddy_SavedVars["general"].cursorpos = UIDropDownMenu_GetSelectedValue(TipBuddy_CursorPosDropDown);	
	else
		--TB_AddMessage("|cff3366ffTipBuddy_CursorPosDropDown is nil");
	end
	if (UIDropDownMenu_GetSelectedValue(TipBuddy_NonUnitTipPosDropDown)) then
		TipBuddy_SavedVars["general"].nonunit_anchor = UIDropDownMenu_GetSelectedValue(TipBuddy_NonUnitTipPosDropDown);	
	else
		--TB_AddMessage("|cff3366ffTipBuddy_NonUnitTipPosDropDown is nil");
	end
	if (UIDropDownMenu_GetSelectedValue(TB_PCFriend_TipStyleDropDown)) then
		TipBuddy_SavedVars["pc_friend"].off = UIDropDownMenu_GetSelectedValue(TB_PCFriend_TipStyleDropDown);			
	end
	if (UIDropDownMenu_GetSelectedValue(TB_PCParty_TipStyleDropDown)) then
		TipBuddy_SavedVars["pc_party"].off = UIDropDownMenu_GetSelectedValue(TB_PCParty_TipStyleDropDown);			
	end
	if (UIDropDownMenu_GetSelectedValue(TB_PCEnemy_TipStyleDropDown)) then
		TipBuddy_SavedVars["pc_enemy"].off = UIDropDownMenu_GetSelectedValue(TB_PCEnemy_TipStyleDropDown);			
	end
	if (UIDropDownMenu_GetSelectedValue(TB_NPCFriend_TipStyleDropDown)) then
		TipBuddy_SavedVars["npc_friend"].off = UIDropDownMenu_GetSelectedValue(TB_NPCFriend_TipStyleDropDown);			
	end
	if (UIDropDownMenu_GetSelectedValue(TB_NPCNeutral_TipStyleDropDown)) then
		TipBuddy_SavedVars["npc_neutral"].off = UIDropDownMenu_GetSelectedValue(TB_NPCNeutral_TipStyleDropDown);			
	end
	if (UIDropDownMenu_GetSelectedValue(TB_NPCEnemy_TipStyleDropDown)) then
		TipBuddy_SavedVars["npc_enemy"].off = UIDropDownMenu_GetSelectedValue(TB_NPCEnemy_TipStyleDropDown);			
	end
	if (UIDropDownMenu_GetSelectedValue(TB_PETFriend_TipStyleDropDown)) then
		TipBuddy_SavedVars["pet_friend"].off = UIDropDownMenu_GetSelectedValue(TB_PETFriend_TipStyleDropDown);			
	end
	if (UIDropDownMenu_GetSelectedValue(TB_PETEnemy_TipStyleDropDown)) then
		TipBuddy_SavedVars["pet_enemy"].off = UIDropDownMenu_GetSelectedValue(TB_PETEnemy_TipStyleDropDown);			
	end
	if (UIDropDownMenu_GetSelectedValue(TB_CORPSE_TipStyleDropDown)) then
		TipBuddy_SavedVars["corpse"].off = UIDropDownMenu_GetSelectedValue(TB_CORPSE_TipStyleDropDown);			
	end

	TipBuddy_Variable_Initialize();
	TipBuddy.xpoint, TipBuddy.xpos, TipBuddy.ypos = TipBuddy_GetFrameCursorOffset();
	TipBuddy.anchor, TipBuddy.fanchor, TipBuddy.offset = TipBuddy_GetFrameAnchorPos();
	TipBuddy.uiScale = TipBuddy_GetUIScale();

	local x, y = TipBuddy_PositionFrameToCursor();
	x = (x / TipBuddy.uiScale);
	y = (y / TipBuddy.uiScale);

	if (TipBuddy_SavedVars["general"].anchored == 1) then
		TipBuddy_Parent_Frame:SetPoint(TipBuddy.anchor, "TipBuddy_Header_Frame", TipBuddy.fanchor, 0, 0);
	else
		TipBuddy_Parent_Frame:SetPoint(TipBuddy.xpoint, "UIParent", "BOTTOMLEFT", x, y);
	end
	--/script TipBuddy_BuffFrameB1:SetPoint("BOTTOMLEFT", "TipBuddy_Main_Frame", "TOPLEFT", 0, 0); TipBuddy_BuffFrameB1:Show();
	--TipBuddy_BuffFrame

	TipBuddy_SetFrame_Anchor( TipBuddy_Main_Frame );
	GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
end

-------------------------
---- SAVE FRAME POSITION
-------------------------
-- this function is called when the frame should be dragged around
function TB_Options_OnMouseDown(arg1)
	if (arg1 == "LeftButton") then
		TipBuddy_OptionsFrame:StartMoving();
	end
end

-- this function is called when the frame is stopped being dragged around
function TB_Options_OnMouseUp(arg1)

	if (arg1 == "LeftButton") then
		TipBuddy_OptionsFrame:StopMovingOrSizing();

		ValidateFramePosition(TipBuddy_OptionsFrame, 256);
		
		-- save the position 
		TipBuddy_SavedVars["general"].opPos_L = TipBuddy_OptionsFrame:GetLeft();
		TipBuddy_SavedVars["general"].opPos_T = TipBuddy_OptionsFrame:GetTop();
		--/script TipBuddy_OptionsFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
	end
end


function TipBuddy_ClickResetVarsButton() 
	StaticPopupDialogs["TIPBUDDY_RESETVARS"] = {
		text = TEXT(TB_RESETVARS_DIALOG),
		button1 = TEXT(ACCEPT),
		button2 = TEXT(DECLINE),
		OnAccept = function()
			TipBuddy_ResetAllVariables();
		end,
		OnCancel = function()
			this:Hide();
		end,
		timeout = 60,
		whileDead = 1
	};
	StaticPopup_Show("TIPBUDDY_RESETVARS");
end

function TipBuddy_ResetAllVariables()
	TipBuddy_SavedVars.version = 0;
	TipBuddy_SavedVars = { };
	TipBuddy_Variable_Initialize();
	TipBuddy_OptionsFrame_UpdateCheckboxes();
	TipBuddy_OptionsFrame_UpdateSliders();
	--TipBuddy_OptionsFrame_UpdateGreyed();
	TipBuddy_OptionsFrame_UpdateColorButtons();
	TipBuddy_OptionsFrame_UpdateColorButtons_Text();

	TipBuddy_Background_ColorPick_OnLoad();
end