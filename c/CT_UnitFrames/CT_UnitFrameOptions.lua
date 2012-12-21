tinsert(UISpecialFrames, "CT_UnitFramesOptionsFrame"); -- So we can close it with escape
CT_UnitFramesOptions = { 
	["styles"] = {
		[1] = { -- Box
			{ 1, 1, 1, 1, 1}, -- Selections
			{ 1, 1, 1, 1, 1},
			{ 1, 1, 1, 1, 1},
			{ 1, 1, 1, 1, 1},
		},
		[2] = { -- Box
			{ 1, 1, 1, 1, 1}, -- Selections
			{ 1, 1, 1, 1, 1},
			{ 1, 1, 1, 1, 1},
			{ 1, 1, 1, 1, 1},
		},
		[3] = { -- Box
			{ 1, 1, 1, 1, 1}, -- Selections
			{ 1, 1, 1, 1, 1},
		},
		[4] = { -- Box
			{ 1, 1, 1, 1, 1}, -- Selections
			{ 1, 1, 1, 1, 1},
		}
	},
};
CT_UnitFramesOptions_NumSelections = {
	4, 4, 2, 2
};

-- OnLoad handlers
function CT_UnitFramesOptions_Radio_OnLoad()
	getglobal(this:GetName() .. "Name"):SetText(CT_UFO_RADIO[this:GetID()]);
end

function CT_UnitFramesOptions_Selection_OnLoad()
	if ( CT_UnitFramesOptions_NumSelections[this:GetParent():GetID()] == 2 ) then
		getglobal(this:GetName() .. "Name"):SetText(CT_UFO_SELECTION[this:GetID()+(1-mod(this:GetID(), 2))]);
	else
		getglobal(this:GetName() .. "Name"):SetText(CT_UFO_SELECTION[this:GetID()]);
	end
end

function CT_UnitFramesOptions_Box_OnLoad()
	getglobal(this:GetName() .. "Name"):SetText(CT_UFO_BOX[this:GetID()]);
	if ( this:GetID() == 3 ) then
		getglobal(this:GetName() .. "ClassFrameCBName"):SetText(CT_UFO_TARGETCLASS);
	end
end

-- OnClick handlers
function CT_UnitFramesOptions_Radio_OnClick()
	local radioId, selectionId, boxId = this:GetID(), this:GetParent():GetID(), this:GetParent():GetParent():GetID();
	CT_UnitFramesOptions.styles[boxId][selectionId][1] = radioId;
	CT_UnitFramesOptions_Radio_Update();
end

-- Function to update the frame
function CT_UnitFramesOptions_Radio_Update()
	for box = 1, 4, 1 do
		for selection = 1, CT_UnitFramesOptions_NumSelections[box], 1 do
			for radio = 1, 4, 1 do
				getglobal("CT_UnitFramesOptionsFrameBox" .. box .. "Selection" .. selection .. "Radio" .. radio):Enable();
				getglobal("CT_UnitFramesOptionsFrameBox" .. box .. "Selection" .. selection .. "Radio" .. radio .. "Name"):SetTextColor(0.7, 0.7, 0.7, 1.0);
				getglobal("CT_UnitFramesOptionsFrameBox" .. box .. "Selection" .. selection .. "Radio" .. radio):SetChecked(false);
				local color = CT_UnitFramesOptions.styles[box][selection];
				getglobal("CT_UnitFramesOptionsFrameBox" .. box .. "Selection" .. selection .. "ColorSwatchNormalTexture"):SetVertexColor(color[2], color[3], color[4]);
			end
		end
	end
	
	for boxId, box in CT_UnitFramesOptions.styles do
		for selectionId, selection in box do
			if ( CT_UnitFramesOptions_NumSelections[boxId] > 2 ) then
				for radioId = 1, CT_UnitFramesOptions_NumSelections[boxId], 1 do
					if ( selection[1] > 1 ) then
						local minBound = 1;
						if ( selectionId > 2 ) then
							minBound = 3;
						end
						for i = minBound, (minBound+1), 1 do
							getglobal("CT_UnitFramesOptionsFrameBox" .. boxId .. "Selection" .. i .. "Radio" .. selection[1]):Disable();
							getglobal("CT_UnitFramesOptionsFrameBox" .. boxId .. "Selection" .. i .. "Radio" .. selection[1] .. "Name"):SetTextColor(0.3, 0.3, 0.3, 1.0);
						end
					end
				end
			end
			getglobal("CT_UnitFramesOptionsFrameBox" .. boxId .. "Selection" .. selectionId .. "Radio" .. selection[1]):SetChecked(true);
			getglobal("CT_UnitFramesOptionsFrameBox" .. boxId .. "Selection" .. selectionId .. "Radio" .. selection[1] .. "Name"):SetTextColor(1.0, 1.0, 1.0, 1.0);
		end
	end
	
	getglobal("CT_UnitFramesOptionsFrameBox3ClassFrameCB"):SetChecked(CT_UnitFramesOptions.displayTargetClass);
	getglobal("CT_UnitFramesOptionsFrameBox4DisplayCB"):SetChecked(CT_UnitFramesOptions.shallDisplayAssist);
	
	if ( CT_UnitFramesOptions.displayTargetClass ) then
		CT_TargetFrameClassFrame:Show();
	else
		CT_TargetFrameClassFrame:Hide();
	end
	
	-- Call the functions to update player/target/target of target/party
	CT_ShowPlayerHealth();
	CT_ShowPlayerMana();
	CT_ShowTargetHealth();
	CT_ShowTargetMana();
	CT_ShowAssistHealth();
	CT_ShowAssistMana();
	CT_PlayerFrame_UpdateSBT();
	for i = 1, 5, 1 do
		CT_PartyFrame_UpdateMember("party" .. i, 1);
		CT_PartyFrame_UpdateMember("party" .. i, nil);
	end
end

-- Color swatch functions
function CT_UnitFrameOptions_ColorSwatch_ShowColorPicker(frame)
	local selectionId, boxId = this:GetParent():GetID(), this:GetParent():GetParent():GetID();
	frame.r = CT_UnitFramesOptions.styles[boxId][selectionId][2];
	frame.g = CT_UnitFramesOptions.styles[boxId][selectionId][3];
	frame.b = CT_UnitFramesOptions.styles[boxId][selectionId][4];
	frame.opacity = CT_UnitFramesOptions.styles[boxId][selectionId][5];
	frame.boxId = boxId;
	frame.selectionId = selectionId;
	frame.opacityFunc = CT_UnitFrameOptions_ColorSwatch_SetOpacity;
	frame.swatchFunc = CT_UnitFrameOptions_ColorSwatch_SetColor;
	frame.cancelFunc = CT_UnitFrameOptions_ColorSwatch_CancelColor;
	frame.hasOpacity = 1;
	UIDropDownMenuButton_OpenColorPicker(frame);
end

function CT_UnitFrameOptions_ColorSwatch_SetColor()
	local r, g, b = ColorPickerFrame:GetColorRGB();
	local boxId, selectionId = CT_UnitFramesOptionsFrame.boxId, CT_UnitFramesOptionsFrame.selectionId;
	CT_UnitFramesOptions.styles[boxId][selectionId][2] = r;
	CT_UnitFramesOptions.styles[boxId][selectionId][3] = g;
	CT_UnitFramesOptions.styles[boxId][selectionId][4] = b;
	
	CT_UnitFramesOptions_Radio_Update();
end

function CT_UnitFrameOptions_ColorSwatch_CancelColor()
	local boxId, selectionId = CT_UnitFramesOptionsFrame.boxId, CT_UnitFramesOptionsFrame.selectionId;
	CT_UnitFramesOptions.styles[boxId][selectionId][2] = CT_UnitFramesOptionsFrame.r;
	CT_UnitFramesOptions.styles[boxId][selectionId][3] = CT_UnitFramesOptionsFrame.g;
	CT_UnitFramesOptions.styles[boxId][selectionId][4] = CT_UnitFramesOptionsFrame.b;
	CT_UnitFramesOptions.styles[boxId][selectionId][5] = CT_UnitFramesOptionsFrame.opacity;
	
	CT_UnitFramesOptions_Radio_Update();
end

function CT_UnitFrameOptions_ColorSwatch_SetOpacity()
	local a = OpacitySliderFrame:GetValue();
	local boxId, selectionId = CT_UnitFramesOptionsFrame.boxId, CT_UnitFramesOptionsFrame.selectionId;
	CT_UnitFramesOptions.styles[boxId][selectionId][5] = a;
	
	CT_UnitFramesOptions_Radio_Update();
end

-- Checkboxes
function CT_UnitFramesOptions_Box_CB_OnClick()
	if ( this:GetParent():GetID() == 3 ) then
		CT_UnitFramesOptions.displayTargetClass = this:GetChecked();
	else
		CT_UnitFramesOptions.shallDisplayAssist = this:GetChecked();
	end
	CT_UnitFramesOptions_Radio_Update();
end

-- Slash command
SlashCmdList["UNITFRAMESOPTIONS"] = function()
	if ( CT_UnitFramesOptionsFrame:IsVisible() ) then
		HideUIPanel(CT_UnitFramesOptionsFrame);
	else
		ShowUIPanel(CT_UnitFramesOptionsFrame);
	end
end
SLASH_UNITFRAMESOPTIONS1 = "/unitframes";
SLASH_UNITFRAMESOPTIONS2 = "/uf";

if ( CT_RegisterMod ) then
	CT_RegisterMod(CT_UFO_MODNAME, CT_UFO_SUBNAME, 4, "Interface\\Icons\\Spell_Ice_Lament", CT_UFO_TOOLTIP, "switch", "", function() if ( CT_UnitFramesOptionsFrame:IsVisible() ) then HideUIPanel(CT_UnitFramesOptionsFrame) else ShowUIPanel(CT_UnitFramesOptionsFrame) end end);
else
	DEFAULT_CHAT_FRAME:AddMessage("<CTMod> CT_UnitFrames loaded. Type |c00FFFFFF/uf|r to show the options dialog.", 1, 1, 0);
end