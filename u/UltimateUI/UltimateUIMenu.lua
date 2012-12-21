--[[ List of button attributes
-- ======================================================
info.text = [STRING]  --  The text of the button
info.func = [function()]  --  The function that is called when you click the button
info.checked = [nil, 1]  --  Check the button
info.isTitle = [nil, 1]  --  If it's a title the button is disabled and the font color is set to yellow
info.disabled = [nil, 1]  --  Disable the button and show an invisible button that still traps the mouseover event so menu doesn't time out
info.hasArrow = [nil, 1]  --  Show the expand arrow for multilevel menus
info.hasColorSwatch = [nil, 1]  --  Show color swatch or not, for color selection
info.r = [1 - 255]  --  Red color value of the color swatch
info.g = [1 - 255]  --  Green color value of the color swatch
info.b = [1 - 255]  --  Blue color value of the color swatch
info.swatchFunc = [function()]  --  Function called by the color picker on color change
info.hasOpacity = [nil, 1]  --  Show the opacity slider on the colorpicker frame
info.opacity = [0.0 - 1.0]  --  Percentatge of the opacity, 1.0 is fully shown, 0 is transparent
info.opacityFunc = [function()]  --  Function called by the opacity slider when you change its value
info.cancelFunc = [function(previousValues)] -- Function called by the colorpicker when you click the cancel button (it takes the previous values as its argument)
info.notClickable = [nil, 1]  --  Disable the button and color the font white
info.notCheckable = [nil, 1]  --  Shrink the size of the buttons and don't display a check box
info.owner = [Frame]  --  Dropdown frame that "owns" the current dropdownlist
info.keepShownOnClick = [nil, 1]  --  Don't hide the dropdownlist after a button is clicked
]]--
UltimateUIMaster_MenuInfoList = { };
UltimateUIMaster_MenuLastValue = 0;

function UltimateUIMaster_MenuBisOnLoad()
	UIDropDownMenu_Initialize(this, UltimateUIMaster_MenuInitialize, "MENU");
	UIDropDownMenu_SetButtonWidth(50);
	UIDropDownMenu_SetWidth(50);
end

function UltimateUIMaster_MenuOnLoad()
	UIDropDownMenu_Initialize(UltimateUIMenuBis, UltimateUIMaster_MenuInitialize);
	UIDropDownMenu_Initialize(this, UltimateUIMaster_MenuInitialize);
	UIDropDownMenu_SetButtonWidth(50);
	UIDropDownMenu_SetWidth(50);
end

UltimateUIMaster_MenuOpen = EarthMenu_MenuOpen;

function UltimateUIMaster_MenuInitialize()
	if ( UIDROPDOWNMENU_MENU_LEVEL == 1 ) then
		for index, value in UltimateUIMaster_MenuInfoList do
			if (value.text) then
				value.value = index;
				UIDropDownMenu_AddButton(value, 1);
			end
		end
	end
	if ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then
		UltimateUIMaster_MenuLastValue = UIDROPDOWNMENU_MENU_VALUE;
		for index, value in UltimateUIMaster_MenuInfoList[UIDROPDOWNMENU_MENU_VALUE] do
			if (type(value) == "table") then
				if (value.text) then
					value.value = index;
					UIDropDownMenu_AddButton(value, 2);
				end
			end
		end
	end
	if ( UIDROPDOWNMENU_MENU_LEVEL == 3 ) then
		for index, value in UltimateUIMaster_MenuInfoList[UltimateUIMaster_MenuLastValue][UIDROPDOWNMENU_MENU_VALUE] do
			if (type(value) == "table") then
				if (value.text) then
					UIDropDownMenu_AddButton(value, 3);
				end
			end
		end
	end
end

