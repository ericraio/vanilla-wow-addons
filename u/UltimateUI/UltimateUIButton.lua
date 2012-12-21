UIPanelWindows["UltimateUIFeatureFrame"] = { area = "left",	pushable = 10 };

ULTIMATEUIFEATUREFRAME_PAGESIZE = 14;

UltimateUIFeatureFrame_Offset = 0;

function ToggleUltimateUIFeatureFrame()
	if (UltimateUIFeatureFrame:IsVisible()) then
		HideUIPanel(UltimateUIFeatureFrame);
	else
		ShowUIPanel(UltimateUIFeatureFrame);
	end
end

function UltimateUIButton_OnHide()
	UpdateMicroButtons();
	PlaySound("igSpellBookClose");
end

function UltimateUIButtons_UpdateColor()
	local value = nil;
	for id = 1, 14 do
		value = UltimateUIMaster_Buttons[id+UltimateUIFeatureFrame_Offset];
		if ( value ) then
			local test_function = value[CSM_TESTFUNCTION];
			if (test_function ~= nil) then
				local icon = getglobal("UltimateUIFeaturesButton"..id);
				local iconTexture = getglobal("UltimateUIFeaturesButton"..id.."IconTexture");
				
				if (test_function() == false) then
					icon:Disable();
					iconTexture:SetVertexColor(1.00, 0.00, 0.00);
				else
					icon:Enable();
					iconTexture:SetVertexColor(1.00, 1.00, 1.00);
				end
			end
		end
	end
end

function UltimateUIButton_OnShow()
	UpdateMicroButtons();
	UltimateUIFeaturesTitleText:SetText(TEXT(ULTIMATEUI_FEATURES_TITLE));
	PlaySound("igSpellBookOpen");
	UltimateUIButtons_UpdateColor();
end

function UltimateUIButton_OnEnter()	
	local value = UltimateUIMaster_Buttons[this:GetID()+UltimateUIFeatureFrame_Offset];
	if (value) then
		UltimateUITooltip:SetOwner(this, "ANCHOR_RIGHT");
		UltimateUITooltip:SetText(value[CSM_LONGDESCRIPTION], 1.0, 1.0, 1.0);
		return;
	end
end

function UltimateUIButton_OnClick()	
	local value = UltimateUIMaster_Buttons[this:GetID()+UltimateUIFeatureFrame_Offset];
	if (value) then
		local f = value[CSM_CALLBACK];
		this:SetChecked(0);
		f();
		return;
	end
end

function UltimateUIButton_UpdateButton()
	for i = 1, 14, 1 do
		local icon = getglobal("UltimateUIFeaturesButton"..i);
		local iconTexture = getglobal("UltimateUIFeaturesButton"..i.."IconTexture");
		local iconName = getglobal("UltimateUIFeaturesButton"..i.."Name");
		local iconDescription = getglobal("UltimateUIFeaturesButton"..i.."OtherName");
		
		icon:Hide();
		iconTexture:Hide();
		iconName:Hide();
		iconDescription:Hide();
	end
	local id = 0;
	local value = 0;
	for i = 1, 14 do
		id = i + UltimateUIFeatureFrame_Offset;
		
		value = UltimateUIMaster_Buttons[id];
		if ( not value ) then
			break;
		end
		
		local icon = getglobal("UltimateUIFeaturesButton"..i);
		local iconTexture = getglobal("UltimateUIFeaturesButton"..i.."IconTexture");
		local iconName = getglobal("UltimateUIFeaturesButton"..i.."Name");
		local iconDescription = getglobal("UltimateUIFeaturesButton"..i.."OtherName");
		
		icon:Show();
		icon:Enable();
		iconTexture:Show();
		iconTexture:SetTexture(value[CSM_ICON]);
		iconName:Show();
		iconName:SetText(value[CSM_NAME]);
		iconDescription:Show();
		iconDescription:SetText(value[CSM_DESCRIPTION]);

	end
	UltimateUIFeatureFrame_UpdatePageArrows();
end

function UltimateUIFeatureFrame_UpdatePageArrows()
	local numValues = 0;
	if ( UltimateUIMaster_Buttons ) then
		numValues = table.getn(UltimateUIMaster_Buttons);
	end
	if ( UltimateUIFeatureFrame_Offset <= 0 ) then
		UltimateUIFeatureFramePrevPageButton:Disable();
	else
		UltimateUIFeatureFramePrevPageButton:Enable();
	end
	if ( ( UltimateUIFeatureFrame_Offset + ULTIMATEUIFEATUREFRAME_PAGESIZE ) >= numValues ) then
		UltimateUIFeatureFrameNextPageButton:Disable();
	else
		UltimateUIFeatureFrameNextPageButton:Enable();
	end
end

function UltimateUIFeatureFrame_PrevPageButton_OnClick()
	if ( ( UltimateUIFeatureFrame_Offset - ULTIMATEUIFEATUREFRAME_PAGESIZE ) >= 0 ) then
		UltimateUIFeatureFrame_Offset = UltimateUIFeatureFrame_Offset - ULTIMATEUIFEATUREFRAME_PAGESIZE;
	end
	UltimateUIButton_UpdateButton();
end

function UltimateUIFeatureFrame_NextPageButton_OnClick()
	local numValues = table.getn(UltimateUIMaster_Buttons);
	if ( ( UltimateUIFeatureFrame_Offset + ULTIMATEUIFEATUREFRAME_PAGESIZE ) < numValues ) then
		UltimateUIFeatureFrame_Offset = UltimateUIFeatureFrame_Offset + ULTIMATEUIFEATUREFRAME_PAGESIZE;
	end
	UltimateUIButton_UpdateButton();
end
