--ColorPicker ID
local num;

local function outline2int(key)
	if (SAVars[key].outline == "THICKOUTLINE") then
		return 3;
	elseif (SAVars[key].outline == "OUTLINE") then
		return 2;
	else
		return 1;
	end
end

local function int2outline(int)
	if (int == 3) then
		return "THICKOUTLINE";
	elseif (int == 2) then
		return "OUTLINE";
	else
		return "";
	end
end

local function int2outlinetext(int)
	if (int == 3) then
		return "Thick";
	elseif (int == 2) then
		return "Normal";
	else
		return "None";
	end
end

local function checked2bool(int)
	if (int) then
		return true;
	else
		return false;
	end
end

function SAO_MainFrame_OnLoad()
	tinsert(UISpecialFrames,"SAO_MainFrame");

	PanelTemplates_SetNumTabs(SAO_MainFrame, 4);
	SAO_MainFrame.selectedTab=1;
	PanelTemplates_UpdateTabs(SAO_MainFrame);

	SAO_OptionFrame1:Show();
end

function SAO_CheckButton_OnLoad(str)
	local buttonText = getglobal(this:GetName().."Text");
	buttonText:SetText(str);
--	buttonText:SetWidth(buttonText:GetStringWidth() + 5);
end

function SAO_CheckButton_OnClick()
	if ( this:GetChecked() ) then
		PlaySound("igMainMenuOptionCheckBoxOn");
	else
		PlaySound("igMainMenuOptionCheckBoxOff");
	end
end

function SAO_MainFrame_OnShow()
	PlaySound("igMainMenuClose");
end

function SAO_MainFrame_OnHide()
	PlaySound("igMainMenuClose");
end

local function HideAllOptionFrames()
	SAO_OptionFrame1:Hide();
	SAO_OptionFrame2:Hide();
	SAO_OptionFrame3:Hide();
	SAO_OptionFrame4:Hide();
end

function SAO_MainFrameTab_OnClick()
	HideAllOptionFrames();
	getglobal("SAO_OptionFrame"..this:GetID()):Show();
	PlaySound("igCharacterInfoTab");
end

function SAO_OptionFrame_OnShow()
	local frame = this:GetName();
	if (frame == "SAO_OptionFrame1") then
		SAO_CheckButtonOn:SetChecked(SAVars.on);
		SAO_CheckButtonOffOnRest:SetChecked(SAVars.offonrest);
		for i = 0, 9 do
			getglobal("SAO_CheckButton"..i):SetChecked(SAVars[i].on);
			getglobal("SAO_CheckButton"..i.."TO"):SetChecked(SAVars[i].to);
			getglobal("SAO_CheckButton"..i.."Short"):SetChecked(SAVars[i].short);
			getglobal("SAO_CheckButton"..i.."Color"):SetID(i);
			getglobal("SAO_CheckButton"..i.."ColorTexture"):SetVertexColor(SAVars[i].r, SAVars[i].g, SAVars[i].b);
		end
	else
		local key = "alert"..this:GetID()-1;
		getglobal(frame.."EditBox1"):SetText(SAVars[key].size);
		getglobal(frame.."EditBox2"):SetText(SAVars[key].holdTime);
		getglobal(frame.."EditBox3"):SetText(SAVars[key].fadeTime);
		getglobal(frame.."EditBox4"):SetText(SAVars[key].lines);
		getglobal(frame.."EditBox5"):SetText(SAVars[key].space);

		getglobal(frame.."Slider1Text"):SetText(SAO_STR_ALPHA);
		getglobal(frame.."Slider1Low"):SetText("0");
		getglobal(frame.."Slider1High"):SetText("1");
		getglobal(frame.."Slider1"):SetMinMaxValues(0, 1);
		getglobal(frame.."Slider1"):SetValueStep(0.01);
		getglobal(frame.."Slider1"):SetValue(SAVars[key].alpha);

		getglobal(frame.."Slider2Text"):SetText(SAO_STR_OUTLINE);
		getglobal(frame.."Slider2Low"):SetText("1");
		getglobal(frame.."Slider2High"):SetText("3");
		getglobal(frame.."Slider2"):SetMinMaxValues(1, 3);
		getglobal(frame.."Slider2"):SetValueStep(1);
		getglobal(frame.."Slider2"):SetValue(outline2int(key));

		local num = this:GetID()-1;
		for i = 0, 9 do
			getglobal(frame.."CheckButton"..i):SetChecked(false);
			if (SAVars[i].alert == num) then
				getglobal(frame.."CheckButton"..i):SetChecked(true);
			end
		end
	end
end

function SAO_OptionFrame_OnHide()
	local frame = this:GetName();
	if (frame == "SAO_OptionFrame1") then
		SAVars.on = checked2bool(SAO_CheckButtonOn:GetChecked());
		SAVars.offonrest = checked2bool(SAO_CheckButtonOffOnRest:GetChecked());
		for i = 0, 9 do
			SAVars[i].on = checked2bool(getglobal("SAO_CheckButton"..i):GetChecked());
			SAVars[i].to = checked2bool(getglobal("SAO_CheckButton"..i.."TO"):GetChecked());
			SAVars[i].short = checked2bool(getglobal("SAO_CheckButton"..i.."Short"):GetChecked());
		end
	else
		local num = this:GetID()-1;
		for i = 0, 9 do
			if (getglobal(frame.."CheckButton"..i):GetChecked()) then
				SAVars[i].alert = num;
			end
			getglobal(frame.."CheckButton"..i):SetChecked(false);
		end
	end
end

function SAO_EditBox_OnEditFocusLost(key)
	this:HighlightText(0, 0);

	local num = (this:GetParent()):GetID()-1;
	local val = tonumber(this:GetText());

	if (not key) then
		return;
	elseif (type(val) ~= "number") then
		message(SAO_STR_NAN);
	elseif ((val < SALimits[key].min) or (val > SALimits[key].max)) then
		this:SetText(SAVars["alert"..num][key]);
		message(SAO_STR_MIN..SALimits[key].min..SAO_STR_MAX..SALimits[key].max);

	else
		SAVars["alert"..num][key] = val;
		SA_SMF_UpdateLook(num);
	end
end

function SAO_CheckButtonColor_OnClick()
	num = this:GetID();

	ColorPickerFrame.hasOpacity = false;
	ColorPickerFrame.previousValues = { SAVars[num].r, SAVars[num].g, SAVars[num].b };
	ColorPickerFrame.func = SAO_ColorPickerFrame_Func;
	ColorPickerFrame.cancelFunc = SAO_ColorPickerFrame_CancelFunc;

	ColorPickerFrame:SetColorRGB(SAVars[num].r, SAVars[num].g, SAVars[num].b);
	ColorPickerFrame:Show();
end

function SAO_ColorPickerFrame_Func()
	local red, green, blue = ColorPickerFrame:GetColorRGB();
	getglobal("SAO_CheckButton"..num.."ColorTexture"):SetVertexColor(red, green, blue);
	SAVars[num].r = red;
	SAVars[num].g = green;
	SAVars[num].b = blue;
end

function SAO_ColorPickerFrame_CancelFunc(prevvals)
	SAVars[num].r, SAVars[num].g, SAVars[num].b = unpack(prevvals);
	getglobal("SAO_CheckButton"..num.."ColorTexture"):SetVertexColor(SAVars[num].r, SAVars[num].g, SAVars[num].b);
end

function SAO_Button_OnClick(k)
	local saDrag = getglobal("SA_Drag"..k);
	if (saDrag:IsVisible()) then
		SAVars["alert"..k].top = saDrag:GetTop();
		SAVars["alert"..k].left = saDrag:GetLeft();
		saDrag:Hide();
	else
		saDrag:Show();
	end
end

function SAO_Slider1_OnValueChanged()
	local num = (this:GetParent()):GetID()-1;

	getglobal(this:GetName().."Value"):SetText(this:GetValue());
	SAVars["alert"..num].alpha = this:GetValue();
	getglobal("SA_SMF"..num):SetAlpha(this:GetValue());
end

function SAO_Slider2_OnValueChanged()
	local num = (this:GetParent()):GetID()-1;

	getglobal(this:GetName().."Value"):SetText(int2outlinetext(this:GetValue()));
	SAVars["alert"..num].outline = int2outline(this:GetValue());
	SA_SMF_UpdateLook(num);
end