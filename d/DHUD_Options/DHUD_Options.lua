
function DHUD_FrameSlider_OnLoad(low, high, step)
	getglobal(this:GetName().."Low"):SetText(low);
	getglobal(this:GetName().."High"):SetText(high);
	this:SetMinMaxValues(low, high);
	this:SetValueStep(step);
	
    PanelTemplates_SetNumTabs(DHUDOptionsFrame, 3);
    DHUDOptionsFrame.selectedTab = 1;
    PanelTemplates_UpdateTabs(DHUDOptionsFrame);
end

function DHUD_FrameSlider_OnValueChanged(key,text,st)

     local m;
     local value;
     
     if st == 0 then
        m = 0;
     end
     
     if st == 1 then
        m = 10;
     end
     
     if st == 2 then
        m = 100;
     end
     
     if st == 3 then
        m = 1000;
     end
     
     if st ~= 0 then
         value =  math.floor( this:GetValue() * m ) / m; 
     else
         value =  math.floor( this:GetValue() ); 
     end
      
     -- hack ;)
     if key == "playermanatextx" or key == "targetmanatextx" or key == "petmanatextx" then
        value = 0 - value;
     end
      
	 DHUD_SetConfig(key, value);
	 getglobal(this:GetName().."Text"):SetText(text.." "..value.." ");
	 DHUD_init();
end

function DHUD_Options_OnShow(key,text)
    getglobal(this:GetName()):SetValue(DHUD_Config[key]);
    getglobal(this:GetName().."Text"):SetText(text.." "..DHUD_Config[key].." ");
end

function DHUD_TabButton_OnClick( )

	PanelTemplates_Tab_OnClick( DHUDOptionsFrame )
	
	local selected = DHUDOptionsFrame.selectedTab
	  
	if  selected == 1  then
		DHUD_Tab1:Show()
	else
		DHUD_Tab1:Hide()
	end

	if  selected == 2  then
		DHUD_Tab2:Show()
	else
		DHUD_Tab2:Hide()
	end

	if  selected == 3  then
		DHUD_Tab3:Show()
	else
		DHUD_Tab3:Hide()
	end
end


function DHUD_ColorPicker_ColorChanged()
	local r, g, b = ColorPickerFrame:GetColorRGB();

    --DHUD_Config[ColorPickerFrame.objindex] = DHUD_DecToHex(r,g,b);
    DHUD_SetColor(ColorPickerFrame.objindex,DHUD_DecToHex(r,g,b));
    getglobal(ColorPickerFrame.tohue):SetTexture(r,g,b);
    DHUD_init();
end

function DHUD_ColorPicker_OnClick()

    local Red, Green, Blue
    Red, Green, Blue = DHUD_hextodec(DHUD_Config[this.objindex]);
    ColorPickerFrame.previousValues = {Red, Green, Blue}
    ColorPickerFrame.cancelFunc = DHUD_ColorPicker_Cancelled
    --ColorPickerFrame.opacityFunc = xxx
    ColorPickerFrame.func = DHUD_ColorPicker_ColorChanged
    ColorPickerFrame.objindex = this.objindex
    ColorPickerFrame.tohue = this.tohue
    ColorPickerFrame.hasOpacity = false
    ColorPickerFrame:SetColorRGB(Red, Green, Blue)
    ColorPickerFrame:ClearAllPoints()
    local x = DHUDOptionsFrame:GetCenter()
    if (x < UIParent:GetWidth() / 2) then
        ColorPickerFrame:SetPoint("LEFT", "DHUDOptionsFrame", "RIGHT", 0, 0)
    else
        ColorPickerFrame:SetPoint("RIGHT", "DHUDOptionsFrame", "LEFT", 0, 0)
    end

    ColorPickerFrame:Show()
end

function DHUD_ColorPicker_Cancelled(color)

    local r,g,b = unpack(color);
    
    --DHUD_Config[ColorPickerFrame.objindex] = DHUD_DecToHex(r,g,b);
    DHUD_SetColor(ColorPickerFrame.objindex,DHUD_DecToHex(r,g,b));
    getglobal(ColorPickerFrame.tohue):SetTexture(r,g,b);
    DHUD_init();
    
end
