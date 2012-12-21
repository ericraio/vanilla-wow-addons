--[[
	actionBarGlobal.lua
		Scripts for the Global Actionbar Options Panel
		This panel does things like enabling altcast, toggling range coloring, etc	
--]]

local frameName = "BOptionsPanelActionBar";


--[[ Global Pane ]]--
function BOptionsActionBarGlobal_OnLoad()
	getglobal(frameName .. "AltCastLabel"):SetText("Selfcast Key");
	UIDropDownMenu_Initialize(getglobal(frameName .. "AltCast"), BOptionsAltCast_Initialize);
end

function BOptionsActionBarGlobal_OnShow()
	this.onShow = 1;
	
	getglobal(frameName .. "Tooltips"):SetChecked(BActionSets_TooltipsShown());
	getglobal(frameName .. "Range"):SetChecked(BActionSets_ColorOutOfRange());
	getglobal(frameName .. "SelfCast"):SetChecked(GetCVar("autoSelfCast"));
	getglobal(frameName .. "MacroText"):SetChecked(not BActionSets_MacrosShown());
	getglobal(frameName .. "HotkeysText"):SetChecked(not BActionSets_HotkeysShown());
	local rangeColor = BActionSets_GetRangeColor();
	getglobal(frameName .. "RangeColorNormalTexture"):SetVertexColor(rangeColor.r, rangeColor.g, rangeColor.b);
	
	UIDropDownMenu_SetSelectedValue(getglobal(frameName .. "AltCast"), BActionSets_GetSelfCastMode());
	
	getglobal(frameName .. "NumActionBars"):SetValue(BActionBar:GetNumber())
	this.onShow = nil;
end

--[[ 
	Altcast Key Dropdown
--]]

function BOptionsAltCast_OnShow()
	UIDropDownMenu_Initialize(this, BOptionsAltCast_Initialize);
	
	UIDropDownMenu_SetWidth(72, this);
end

function BOptionsAltCast_OnClick()
	UIDropDownMenu_SetSelectedValue(getglobal(frameName .. "AltCast"), this.value);
	BActionSets_SetSelfCastMode(this.value);
end

local function AddAltCastButton(text, value, selectedValue)
	--no hotkey
	local info = {};
	info.text = text;
	info.func = BOptionsAltCast_OnClick;
	info.value = value;
	if value == selectedValue then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info);
end


--add all buttons to the dropdown menu
function BOptionsAltCast_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue( getglobal(frameName .. "AltCast") );

	AddAltCastButton("None", nil, selectedValue)
	AddAltCastButton("Alt", 1, selectedValue)
	AddAltCastButton("Control", 2, selectedValue)
	AddAltCastButton("Shift", 3, selectedValue)
end

--[[
	Out of Range Coloring Functions 
--]]
--set the background of the frame between opaque/transparent
function BOptionsRangeColor_OnClick()
	if ColorPickerFrame:IsShown() then
		ColorPickerFrame:Hide();
	else
		local settings = BActionSets_GetRangeColor()
		
		ColorPickerFrame.func = BOptionsRangeColor_ColorChange;	
		ColorPickerFrame.cancelFunc = BOptionsRangeColor_CancelChanges;
		
		getglobal(frameName .. "RangeColorNormalTexture"):SetVertexColor(settings.r, settings.g, settings.b);
		ColorPickerFrame:SetColorRGB(settings.r, settings.g, settings.b);
		ColorPickerFrame.previousValues = {r = settings.r, g = settings.g, b = settings.b};
		
		ShowUIPanel(ColorPickerFrame);
	end
end

function BOptionsRangeColor_ColorChange()
	local r, g, b = ColorPickerFrame:GetColorRGB();
	
	BActionSets_SetRangeColor(r, g, b)
	
	getglobal(frameName .. "RangeColorNormalTexture"):SetVertexColor(r, g, b);
end


function BOptionsRangeColor_CancelChanges() 
	local prevValues = ColorPickerFrame.previousValues;
	
	BActionSets_SetRangeColor(prevValues.r, prevValues.g, prevValues.b)
	
	getglobal(frameName .. "RangeColorNormalTexture"):SetVertexColor(prevValues.r, prevValues.g, prevValues.b);
end