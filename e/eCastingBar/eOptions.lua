-- frame to show
local currentFrame = "General"


function eCastingBar_CloseConfig()
	eCastingBarConfigFrame:Hide()
	hideFrames()
end

function hideFrames()
  eCastingBarGeneralFrame:Hide()
  eCastingBarColorsFrame:Hide()
end

function eCastingBarConfig_OnShow()
  hideFrames()
  getglobal("eCastingBar"..currentFrame.."Frame"):Show()
end

function eCastingBar_Defaults()
  eCastingBar_ResetSettings()
  eCastingBar_LoadVariables()
end

function eCastingBar_ColorPicker_OnClick()
	if (ColorPickerFrame:IsShown()) then
		eCastingBar_ColorPicker_Cancelled(ColorPickerFrame.previousValues)
		ColorPickerFrame:Hide()
  else
    local Red, Green, Blue, Alpha

		Red, Green, Blue, Alpha = unpack(eCastingBar_Saved[eCastingBar_Player][this.objindex])
		ColorPickerFrame.previousValues = {Red, Green, Blue, Alpha}
		ColorPickerFrame.cancelFunc = eCastingBar_ColorPicker_Cancelled
		ColorPickerFrame.opacityFunc = eCastingBar_ColorPicker_OpacityChanged
		ColorPickerFrame.func = eCastingBar_ColorPicker_ColorChanged
		ColorPickerFrame.index = this:GetName().."Texture"
		ColorPickerFrame.objindex = this.objindex
		ColorPickerFrame.whenindex = this.whenindex
		ColorPickerFrame.hasOpacity = true
		ColorPickerFrame.opacity = Alpha
		ColorPickerFrame:SetColorRGB(Red, Green, Blue)
		ColorPickerFrame:ClearAllPoints()
		local x = eCastingBarConfigFrame:GetCenter()
		if (x < UIParent:GetWidth() / 2) then
			ColorPickerFrame:SetPoint("LEFT", "eCastingBarConfigFrame", "RIGHT", 0, 0)
		else
			ColorPickerFrame:SetPoint("RIGHT", "eCastingBarConfigFrame", "LEFT", 0, 0)
		end

    ColorPickerFrame:Show()
  end
end

function eCastingBar_ColorPicker_Cancelled(color)
	eCastingBar_Saved[eCastingBar_Player][ColorPickerFrame.objindex] = color
  
  getglobal(ColorPickerFrame.index):SetVertexColor(unpack(color))
  if (ColorPickerFrame.objindex == "FlashBorderColor" or ColorPickerFrame.objindex == "MirrorFlashBorderColor") then
    eCastingBar_checkFlashBorderColors()
  end
end

function eCastingBar_ColorPicker_OpacityChanged()
	local r, g, b = ColorPickerFrame:GetColorRGB()
	local a = OpacitySliderFrame:GetValue()
	getglobal(ColorPickerFrame.index):SetVertexColor(r, g, b, a)
end

function eCastingBar_ColorPicker_ColorChanged()
	local r, g, b = ColorPickerFrame:GetColorRGB()
	local a = OpacitySliderFrame:GetValue()
	getglobal(ColorPickerFrame.index):SetVertexColor(r,g,b,a)
	if (not ColorPickerFrame:IsShown()) then
		eCastingBar_Saved[eCastingBar_Player][ColorPickerFrame.objindex] = {r,g,b,a}

    if (ColorPickerFrame.objindex == "FlashBorderColor" or ColorPickerFrame.objindex == "MirrorFlashBorderColor") then
      eCastingBar_checkFlashBorderColors()
    elseif (ColorPickerFrame.objindex == "TimeColor" or ColorPickerFrame.objindex == "MirrorTimeColor") then
    	eCastingBar_checkTimeColors()
    elseif (ColorPickerFrame.objindex == "DelayColor") then
    	eCastingBar_setDelayColor()
    end
	end
end

function eCastingBar_SelectFrame()
	local frames = {"eCastingBarGeneralFrame", "eCastingBarMirrorFrame", "eCastingBarColorsFrame"}
	for _,v in frames do
		getglobal(v):Hide()
	end
	currentFrame = this.index
	getglobal("eCastingBar"..this.index.."Frame"):Show()
end

function eCastingBar_CheckButton_OnClick()
  eCastingBar_Saved[eCastingBar_Player][this.index] = convertBooleanToInt(this:GetChecked())

  if (string.find(this.index, "Locked")) then
    eCastingBar_checkLocked()
  elseif (string.find(this.index, "Enabled")) then
    if (string.find(this.index, "Mirror")) then
      if (convertBooleanToInt(this:GetChecked()) == 0) then
        showAllBlizzardMirrorFrames()
      else
        hideAllBlizzardMirrorFrames()
      end
    else
      if (convertBooleanToInt(this:GetChecked()) == 0) then
        if (eCastingBar.casting) then
          eCastingBar_SpellcastStop( "")
        elseif (eCastingBar.channeling) then
          eCastingBar_SpellcastChannelUpdate( "", 0)
          eCastingBar_SpellcastStop( "")
        end
      end
    end

    eCastingBar_checkEnabled()
  elseif (string.find(this.index, "UsePerlTexture")) then
    eCastingBar_checkTextures()
  elseif (string.find(this.index, "HideBorder")) then
    eCastingBar_checkBorders()
  end

  --setup()
end

function convertBooleanToInt(val)
	if (val) then
		return 1
  else
    return 0
	end
end

function eCastingBarSlider_OnValueChanged()
  eCastingBar_Saved[eCastingBar_Player][this.index] = this:GetValue()
  if (getglobal("eCastingBar"..this.index.."EditBox")) then
    getglobal("eCastingBar"..this.index.."EditBox"):SetNumber(this:GetValue())
  end

  -- set the tool tip text
	if (this:GetValue() == floor(this:GetValue())) then
		GameTooltip:SetText(format("%d", this:GetValue()))
	else
		GameTooltip:SetText(format("%.2f", this:GetValue()))
	end

  eCastingBar_SetSize()
end

function eCastingBarSlider_OnEnter()
	-- put the tool tip in the default position
	GameTooltip:SetOwner(this, "ANCHOR_CURSOR")
	
	-- set the tool tip text
	if (this:GetValue() == floor(this:GetValue())) then
		GameTooltip:SetText(format("%d", this:GetValue()))
	else
		GameTooltip:SetText(format("%.2f", this:GetValue()))
	end
	
	GameTooltip:Show()
end

function eCastingBarSlider_OnLeave()
	GameTooltip:Hide()
end

function eCastingBar_setAnchor(subframe, xoffset, yoffset)
	xoffset = getglobal(this:GetName().."_Label"):GetWidth() + xoffset + 5
	this:SetPoint("TOPLEFT", this:GetParent():GetName()..subframe, "BOTTOMLEFT", xoffset, yoffset)
end

function eCastingBar_Menu_TimeOut(elapsed)
	if (this.timer) then
		this.timer = this.timer - elapsed
		if (this.timer < 0) then
			this.timer = nil
			this:Hide()
		end
	end
end

function eCastingBar_Menu_Show(menu, index, controlbox)
	if (not menu) then return end
	if (eCastingBar_DropMenu:IsVisible()) then
		eCastingBar_DropMenu:Hide()
		return
	end

  if (menu == "SavedSettings") then
		menu = eCastingBar_MENU_SAVEDSETTINGS
	end

	eCastingBar_DropMenu.index = index
	eCastingBar_DropMenu.controlbox = controlbox

	local width = 0
	local count = 1
	local textwidth
  local frame

	for _,v in menu do
    frame = getglobal("eCastingBar_DropMenu_Option"..count)
    frame:SetFrameLevel(getglobal(controlbox):GetFrameLevel())
		frame:Show()
		getglobal("eCastingBar_DropMenu_Option"..count.."_Text"):SetText(v.text)
		frame.value =v.value
		textwidth = getglobal("eCastingBar_DropMenu_Option"..count.."_Text"):GetWidth()
		if (textwidth > width) then
			width = textwidth
		end
		count = count + 1
	end
	for i=1, 40 do
		if (i < count) then
			getglobal("eCastingBar_DropMenu_Option"..i):SetWidth(width)
		else
			getglobal("eCastingBar_DropMenu_Option"..i):Hide()			
		end
	end
	count = count - 1
	eCastingBar_DropMenu:SetWidth(width + 20)
	eCastingBar_DropMenu:SetHeight(count * 15 + 20)
	eCastingBar_DropMenu:ClearAllPoints()
	eCastingBar_DropMenu:SetPoint("TOPRIGHT", controlbox, "BOTTOMRIGHT", 0, 0)
	if (eCastingBar_DropMenu:GetBottom() < UIParent:GetBottom()) then
		local yoffset = UIParent:GetBottom() - eCastingBar_DropMenu:GetBottom()
		eCastingBar_DropMenu:ClearAllPoints()
		eCastingBar_DropMenu:SetPoint("TOPRIGHT", controlbox, "BOTTOMRIGHT", 0, yoffset)
	end

	eCastingBar_DropMenu:Show()
end

function eCastingBar_Menu_OnClick()
	this:GetParent():Hide()
	getglobal(eCastingBar_DropMenu.controlbox.."_Setting"):SetText(getglobal(this:GetName().."_Text"):GetText())
	if (eCastingBar_DropMenu.index == "SpellJustify") then
		eCastingBar_Saved[eCastingBar_Player].SpellJustify = this.value
    eCastingBarText:SetJustifyH(this.value)
		return
  elseif (eCastingBar_DropMenu.index == "MirrorSpellJustify") then
    eCastingBar_Saved[eCastingBar_Player].MirrorSpellJustify = this.value
    for index = 1, MIRRORTIMER_NUMTIMERS, 1 do
      getglobal("eCastingBarMirror"..index.."StatusBarText"):SetJustifyH(this.value)
    end
    return
	elseif (eCastingBar_DropMenu.index == "SavedSettings") then
		eCastingBar_SETTINGS_INDEX = this.value
    return
  end
end
