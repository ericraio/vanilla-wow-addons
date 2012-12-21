SuperMacroOptionsFrameCheckButtons = { };
SuperMacroOptionsFrameCheckButtons["SM_HIDE_ACTION"] = { index = 1, var = "hideAction"};
SuperMacroOptionsFrameCheckButtons["SM_MACRO_TIP_1"] = { index = 2, var = "macroTip1"};
SuperMacroOptionsFrameCheckButtons["SM_MACRO_TIP_2"] = { index = 3, var = "macroTip2"};
SuperMacroOptionsFrameCheckButtons["SM_MINIMAP"] = { index = 4, var = "minimap"};
SuperMacroOptionsFrameCheckButtons["SM_REPLACE_ICON"] = { index = 5, var = "replaceIcon"};
SuperMacroOptionsFrameCheckButtons["SM_CHECK_COOLDOWN"] = { index = 6, var = "checkCooldown"};
SuperMacroOptionsFrameColorSwatches = { };
SuperMacroOptionsFrameColorSwatches["SM_PRINT_COLOR"] = { index = 1, var = "printColor", exampleText=SM_PRINT_COLOR_EXAMPLE_TEXT};

function SuperMacroOptionsFrame_OnShow()
  for k, v in SuperMacroOptionsFrameCheckButtons do
  		local button = getglobal("SuperMacroOptionsFrameCheckButton"..v.index);
  		local string = getglobal("SuperMacroOptionsFrameCheckButton"..v.index.."Text");
  		local checked;
  		checked = SM_VARS[v.var];
  		button:SetChecked(checked);
  		string:SetText(TEXT(getglobal(k)));
  	end
	
	for k, v in SuperMacroOptionsFrameColorSwatches do
		local button = getglobal("SuperMacroOptionsFrameColorSwatch"..v.index);
		button.var = v.var;
		local string = getglobal("SuperMacroOptionsFrameColorSwatch"..v.index.."Text");
		string:SetText(TEXT(getglobal(k)));
		button.r = SM_VARS[v.var].r;
		button.g = SM_VARS[v.var].g;
		button.b = SM_VARS[v.var].b;
		getglobal(button:GetName().."NormalTexture"):SetVertexColor( button.r, button.g, button.b );
		button.opacity = 1;
		local example = getglobal("SuperMacroOptionsFrameColorSwatch"..v.index.."ExampleText");
		if ( v.exampleText ) then
			example:SetText(v.exampleText);
			example:SetTextColor(button.r, button.g, button.b);
		end
	end
end

function SuperMacroOptionsFrameColorSwatch_OnLoad()
end

function SuperMacroOptions_OpenColorPicker(this)
	ColorPickerFrame.func = function() 
		SM_VARS[this.var].r, SM_VARS[this.var].g, SM_VARS[this.var].b = ColorPickerFrame:GetColorRGB();
		SuperMacroOptionsFrame_OnShow();
	end
	ColorPickerFrame.hasOpacity = this.hasOpacity;
	ColorPickerFrame.opacityFunc = this.opacityFunc;
	ColorPickerFrame.opacity = this.opacity;
	ColorPickerFrame:SetColorRGB(this.r, this.g, this.b);
	ColorPickerFrame.previousValues = {r = this.r, g = this.g, b = this.b, opacity = this.opacity};
	ColorPickerFrame.cancelFunc = function()
		SM_VARS[this.var].r, SM_VARS[this.var].g, SM_VARS[this.var].b = ColorPickerFrame.previousValues.r, ColorPickerFrame.previousValues.g, ColorPickerFrame.previousValues.b;
		SuperMacroOptionsFrame_OnShow();
	end
	ShowUIPanel(ColorPickerFrame);
end

function HideActionText()
	local func=ActionButton1Name.Show;
	if ( SM_VARS.hideAction == 1 ) then
		func = ActionButton1Name.Hide;
	elseif ( SM_VARS.hideAction == 0 ) then
		func = ActionButton1Name.Show;
	end
	for i = 1,12 do
		if ( getglobal("ActionButton"..i) ) then
			func(getglobal("ActionButton"..i.."Name"));
		else
			break;
		end
		if ( getglobal("BonusActionButton"..i.."Name")) then
			func(getglobal("BonusActionButton"..i.."Name"));
		end
		if ( getglobal("MultiBarBottomLeftButton"..i.."Name") ) then
			func(getglobal("MultiBarBottomLeftButton"..i.."Name"));
			func(getglobal("MultiBarBottomRightButton"..i.."Name"))
			func(getglobal("MultiBarLeftButton"..i.."Name"));
			func(getglobal("MultiBarRightButton"..i.."Name"));
		end
	end
	for i = 1,72 do
		if ( getglobal("FUActionButton"..i) ) then
			func(getglobal("FUActionButton"..i.."Name"));
		else
			break;
		end
	end
	for i = 1,120 do
		if ( getglobal("DiscordActionButton"..i.."Name")) then
			func(getglobal("DiscordActionButton"..i.."Name"));
		else
			break;
		end
	end
end