--[[
Non-BEB templates and their file
GameFontNormal					Fonts.xml
GameFontNormalSmall				Fonts.xml
InputBoxTemplate				UIPanelTemplates.xml
UIPanelButtonTemplate			UIPanelTemplates.xml
UICheckButtonTemplate			UIPanelTemplates.xml

Elements for each selector
	BEBMain ( Dragable, Position, Attachment, Size, Level, Strata)
	BEBBackground ( Flash, Shown, Colors, Texture, Level, Strata)
	BEBXpBar ( Flash, Colors, Texture, Level, Strata)
	BEBRestedXpBar ( Flash, Shown, Colors (rested,maxrested), Texture, Level, Strata)
	BEBMarkers ( Flash, Shown, Colors, Texture, Level, Strata)
	BEBXpTick ( Flash, Shown, Colors, Texture, position, Size, Level, Strata)
	BEBRestedXpTick ( Flash, Shown, Colors (rested, maxrested), Position, Size, Level, Strata)
	BEBRestedXpTickGlow ( Flash, Colors (rested, maxrested), Texture, Level, Strata)
	BEBBarText ( Flash, Shown, Colors, Text, Mouseover, Size (y), clicktext, Position, Attachment (point, relpoint), Level, Strata)

			<OnEnter>
				if ( this.tooltipText ) then
					GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
					GameTooltip:SetText(this.tooltipText, nil, nil, nil, nil, 1)
				end
				if ( this.tooltipRequirement ) then
					GameTooltip:AddLine(this.tooltipRequirement, "", 1.0, 1.0, 1.0)
					GameTooltip:Show()
				end
			</OnEnter>
			<OnLeave>
				GameTooltip:Hide()
			</OnLeave>
]]
BEBOPTIONS.ARROWLEFT =				"<"
BEBOPTIONS.ARROWRIGHT =				">"

BEBOPTIONS.SIZELIMITS = {
	BEBMain={x={min=50,max=2000,step=1},y={min=2,max=32,step=1}},
	BEBXpTick={x={min=2,max=128,step=1},y={min=2,max=128,step=1}},
	BEBRestedXpTick={x={min=2,max=128,step=1},y={min=2,max=128,step=1}},
	BEBBarText={y={min=6,max=27,step=0.25}},
	level={min=1,max=25,step=1}
}
BEBOPTIONS.CURRENTFRAME = "BEBMain"
BEBOPTIONS.ELEMENTS = {"BEBColorsHeader","BEBAttachHeader",
	"BEBDragableCheckButton","BEBFlashingCheckButton","BEBShownCheckButton","BEBShowOnMouseoverCheckButton","BEBUnrestedTextureColorButton","BEBRestedTextureColorButton","BEBMaxrestedTextureColorButton",
	"BEBUnrestedTextColorButton","BEBRestedTextColorButton","BEBMaxrestedTextColorButton","BEB_MainAttachToFrame","BEB_BarTextFrame","BEB_TextureFrame","BEB_MainAttachPointButton","BEB_MainAttachToPointButton","BEBOptionsPositionControls",
	"BEBOptionsHeightSlider","BEBOptionsWidthSlider","BEBClickTextCheckButton","BEBProfileFrame","BEBOptionsLevelSlider","BEB_StrataDDMButton"}
BEBOPTIONS.FRAMEELEMENTS = {
	BEBMain = {BEBDragableCheckButton=1,BEBOptionsPositionControls=1,BEB_MainAttachToFrame=1,BEB_MainAttachPointButton=1,BEB_MainAttachToPointButton=1,BEBAttachHeader=1,BEBOptionsHeightSlider=1,BEBOptionsWidthSlider=1,BEBOptionsLevelSlider=1,BEB_StrataDDMButton=1},
	BEBBackground = {BEBFlashingCheckButton=1,BEBShownCheckButton=1,BEBColorsHeader=1,BEBUnrestedTextureColorButton=1,BEBRestedTextureColorButton=1,BEBMaxrestedTextureColorButton=1,BEB_TextureFrame=1,BEBOptionsLevelSlider=1,BEB_StrataDDMButton=1},
	BEBXpBar = {BEBFlashingCheckButton=1,BEBColorsHeader=1,BEBUnrestedTextureColorButton=1,BEBRestedTextureColorButton=1,BEBMaxrestedTextureColorButton=1,BEB_TextureFrame=1,BEBOptionsLevelSlider=1,BEB_StrataDDMButton=1},
	BEBRestedXpBar = {BEBFlashingCheckButton=1,BEBShownCheckButton=1,BEBColorsHeader=1,BEBRestedTextureColorButton=1,BEBMaxrestedTextureColorButton=1,BEB_TextureFrame=1,BEBOptionsLevelSlider=1,BEB_StrataDDMButton=1},
	BEBMarkers = {BEBFlashingCheckButton=1,BEBShownCheckButton=1,BEBColorsHeader=1,BEBUnrestedTextureColorButton=1,BEBRestedTextureColorButton=1,BEBMaxrestedTextureColorButton=1,BEB_TextureFrame=1,BEBOptionsLevelSlider=1,BEB_StrataDDMButton=1},
	BEBXpTick = {BEBFlashingCheckButton=1,BEBShownCheckButton=1,BEBColorsHeader=1,BEBUnrestedTextureColorButton=1,BEBRestedTextureColorButton=1,BEBMaxrestedTextureColorButton=1,BEB_TextureFrame=1,BEBOptionsPositionControls=1,BEBOptionsHeightSlider=1,BEBOptionsWidthSlider=1,BEBOptionsLevelSlider=1,BEB_StrataDDMButton=1},
	BEBRestedXpTick = {BEBFlashingCheckButton=1,BEBShownCheckButton=1,BEBColorsHeader=1,BEBRestedTextureColorButton=1,BEBMaxrestedTextureColorButton=1,BEB_TextureFrame=1,BEBOptionsPositionControls=1,BEBOptionsHeightSlider=1,BEBOptionsWidthSlider=1,BEBOptionsLevelSlider=1,BEB_StrataDDMButton=1},
	BEBRestedXpTickGlow = {BEBFlashingCheckButton=1,BEBColorsHeader=1,BEBRestedTextureColorButton=1,BEBMaxrestedTextureColorButton=1,BEB_TextureFrame=1,BEBOptionsLevelSlider=1,BEB_StrataDDMButton=1},
	BEBBarText = {BEBFlashingCheckButton=1,BEBShownCheckButton=1,BEBColorsHeader=1,BEBUnrestedTextColorButton=1,BEBRestedTextColorButton=1,BEBMaxrestedTextColorButton=1,BEB_BarTextFrame=1,BEBShowOnMouseoverCheckButton=1,BEBOptionsHeightSlider=1,BEBClickTextCheckButton=1,BEBOptionsPositionControls=1,BEB_MainAttachPointButton=1,BEB_MainAttachToPointButton=1,BEBAttachHeader=1,BEBOptionsLevelSlider=1,BEB_StrataDDMButton=1},
	BEBProfile = {BEBProfileFrame=1}
}

function BEBOPTIONS.OnLoad()
	tinsert(UISpecialFrames,"BEBConfigFrame")
	this:RegisterEvent("ADDON_LOADED")
end

function BEBOPTIONS.OnEvent(event)
	if (event == "ADDON_LOADED" and arg1 == "BEBOptions") then
		BEBOPTIONS.Initialize()
		this:UnregisterEvent("ADDON_LOADED")
	end
end

function BEBOPTIONS.Initialize()
		BEBOPTIONS.SetTexts()
end

function BEBOPTIONS.SetTexts()
		for element,text in BEBOPTIONS.TEXTELEMENTS do
			local Element = getglobal(element)
			Element:SetText(text)
		end
end

function BEBOPTIONS.OnShow(frame)
	if ( not BEBINITIALIZED ) then
		BEBConfigFrame:Hide()
		return
	end
	if (frame) then
		this = getglobal(frame.."Selector")
	else
		this = getglobal(BEBOPTIONS.CURRENTFRAME.."Selector")
	end
	BEBOPTIONS.SelectFrame()
end

function BEBOPTIONS.SelectFrame()
	ColorPickerFrame:Hide()
	BEBOPTIONS.CURRENTFRAME = this.index
	BEBOptionsHeightSlider.enabled = nil
	BEBOptionsWidthSlider.enabled = nil
	BEBOptionsLevelSlider.enabled = nil
	for _,v in BEBOPTIONS.ELEMENTS do
		if ( BEBOPTIONS.FRAMEELEMENTS[BEBOPTIONS.CURRENTFRAME][v] ) then
			BEBOPTIONS.SetElementValue(v)
			getglobal(v):Show()
		else
			getglobal(v):Hide()
		end
	end
	BEBOptionsHeightSlider.enabled = true
	BEBOptionsWidthSlider.enabled = true
	BEBOptionsLevelSlider.enabled = true
	for k,_ in BEBOPTIONS.FRAMEELEMENTS do
		getglobal(k.."Selector"):UnlockHighlight()
	end
	getglobal(BEBOPTIONS.CURRENTFRAME.."Selector"):LockHighlight()
	BEBCurrentSelector:SetText(BEBOPTIONS.TEXTELEMENTS[BEBOPTIONS.CURRENTFRAME.."Selector"])
end

function BEBOPTIONS.SetElementValue(element)
	if ((element == "BEBColorsHeader")or(element == "BEBAttachHeader")) then
	elseif ((element == "BEBUnrestedTextureColorButton")or(element == "BEBRestedTextureColorButton")or(element == "BEBMaxrestedTextureColorButton")) then
		getglobal(element.."Texture"):SetTexture(BEB.TexturePath(BEBCharSettings[BEBOPTIONS.CURRENTFRAME].texture))
		local button = getglobal(element)
		getglobal(element.."Texture"):SetVertexColor(unpack(BEBCharSettings[BEBOPTIONS.CURRENTFRAME][button.whenindex]))
		if ((BEBOPTIONS.CURRENTFRAME == "BEBBackground")or(BEBOPTIONS.CURRENTFRAME == "BEBXpBar")or(BEBOPTIONS.CURRENTFRAME == "BEBRestedXpBar")or(BEBOPTIONS.CURRENTFRAME == "BEBMarkers")) then
			getglobal(element.."Texture"):SetTexCoord(0.046875,0.0625,0,1)
		else
			getglobal(element.."Texture"):SetTexCoord(0.5,1,0,0.5)
		end
	elseif ((element == "BEBUnrestedTextColorButton")or(element == "BEBRestedTextColorButton")or(element == "BEBMaxrestedTextColorButton")) then
		local button = getglobal(element)
		getglobal(element.."Texture"):SetVertexColor(unpack(BEBCharSettings[BEBOPTIONS.CURRENTFRAME][button.whenindex]))
	elseif ((element == "BEBDragableCheckButton")or(element == "BEBFlashingCheckButton")or(element == "BEBShownCheckButton") or(element == "BEBClickTextCheckButton") or(element == "BEBShowOnMouseoverCheckButton")) then
		local button = getglobal(element)
		button:SetChecked(BEBCharSettings[BEBOPTIONS.CURRENTFRAME][button.index])
	elseif ((element == "BEB_MainAttachToFrame")or(element == "BEB_BarTextFrame")or(element == "BEB_TextureFrame")) then
		local button = getglobal(element.."Button")
		if (button.subindex) then
			getglobal(element.."EditBox"):SetText(BEBCharSettings[BEBOPTIONS.CURRENTFRAME][button.typeindex][button.subindex])
		else
			getglobal(element.."EditBox"):SetText(BEBCharSettings[BEBOPTIONS.CURRENTFRAME][button.typeindex])
		end
	elseif ((element == "BEB_MainAttachPointButton")or(element == "BEB_MainAttachToPointButton")) then
		local button = getglobal(element)
		local attachpoint = BEBCharSettings[BEBOPTIONS.CURRENTFRAME][button.typeindex][button.subindex]
		button:SetText(BEBOPTIONS.ATTACHPOINTS[attachpoint])
	elseif ((element == "BEBOptionsPositionControls")) then
		getglobal(element.."xEditBox"):SetText(BEBCharSettings[BEBOPTIONS.CURRENTFRAME].location.x)
		getglobal(element.."yEditBox"):SetText(BEBCharSettings[BEBOPTIONS.CURRENTFRAME].location.y)
	elseif ((element == "BEBOptionsHeightSlider")or(element == "BEBOptionsWidthSlider")) then
		local slider = getglobal(element)
		slider:SetMinMaxValues(BEBOPTIONS.SIZELIMITS[BEBOPTIONS.CURRENTFRAME][slider.axisindex].min,BEBOPTIONS.SIZELIMITS[BEBOPTIONS.CURRENTFRAME][slider.axisindex].max)
		getglobal(element.."Low"):SetText(BEBOPTIONS.SIZELIMITS[BEBOPTIONS.CURRENTFRAME][slider.axisindex].min)
		getglobal(element.."High"):SetText(BEBOPTIONS.SIZELIMITS[BEBOPTIONS.CURRENTFRAME][slider.axisindex].max)
		slider:SetValueStep(BEBOPTIONS.SIZELIMITS[BEBOPTIONS.CURRENTFRAME][slider.axisindex].step)
		slider:SetValue(BEBCharSettings[BEBOPTIONS.CURRENTFRAME][slider.whatindex][slider.axisindex])
	elseif (element == "BEBProfileFrame") then
		BEBOPTIONS.PROFILETABLE = {[BEBOPTIONS.TEXT.none] = BEBOPTIONS.TEXT.none}
		if (BEBGlobal.profiles and (table.getn(BEBGlobal.profiles)>0)) then
			for k,_ in BEBGlobal.profiles do
				BEBOPTIONS.PROFILETABLE[k] = k
			end
			if (BEBCharSettings.BEBProfile) then
				BEBProfileFrameUseButton:LockHighlight()
				BEBProfileFrameUseButtonCheckButton:SetChecked(1)
				BEBProfileFrameUseButtonDDMButton:SetText(BEBCharSettings.BEBProfile)
			else
				BEBProfileFrameUseButton:UnlockHighlight()
				BEBProfileFrameUseButtonCheckButton:SetChecked(0)
				BEBProfileFrameUseButtonDDMButton:SetText(BEBOPTIONS.TEXT.none)
			end
		else
			BEBProfileFrameUseButton:UnlockHighlight()
			BEBProfileFrameUseButtonCheckButton:SetChecked(0)
			BEBProfileFrameUseButtonDDMButton:SetText(BEBOPTIONS.TEXT.none)
		end
		BEBProfileFrameLoadButtonDDMButton:SetText(BEBOPTIONS.TEXT.none)
		BEBProfileFrameSaveButtonDDMButton:SetText(BEBOPTIONS.TEXT.none)
		BEBProfileFrameDeleteButtonDDMButton:SetText(BEBOPTIONS.TEXT.none)
	elseif (element == "BEBOptionsLevelSlider") then
		local slider = getglobal(element)
		slider:SetMinMaxValues(BEBOPTIONS.SIZELIMITS[slider.whatindex].min,BEBOPTIONS.SIZELIMITS[slider.whatindex].max)
		getglobal(element.."Low"):SetText(BEBOPTIONS.SIZELIMITS[slider.whatindex].min)
		getglobal(element.."High"):SetText(BEBOPTIONS.SIZELIMITS[slider.whatindex].max)
		slider:SetValueStep(BEBOPTIONS.SIZELIMITS[slider.whatindex].step)
		slider:SetValue(BEBCharSettings[BEBOPTIONS.CURRENTFRAME][slider.whatindex])
	elseif (element == "BEB_StrataDDMButton") then
		local button = getglobal(element)
		button:SetText(BEBCharSettings[BEBOPTIONS.CURRENTFRAME][button.typeindex])
	end
end

function BEBOPTIONS.OnMouseDown()
	BEBConfigFrame:StartMoving()
end

function BEBOPTIONS.OnMouseUp()
	BEBConfigFrame:StopMovingOrSizing()
end

function BEBOPTIONS.CheckButton_OnClick()
	BEBCharSettings[BEBOPTIONS.CURRENTFRAME][this.index] = not(not this:GetChecked())
	if (this.index == "flashing") then
		if (getglobal(BEBOPTIONS.CURRENTFRAME).textframe) then
			getglobal(BEBOPTIONS.CURRENTFRAME).textframe:SetAlpha(1)
		else
			getglobal(BEBOPTIONS.CURRENTFRAME).texture:SetAlpha(1)
		end
	elseif ((this.index == "shown") and (BEBOPTIONS.CURRENTFRAME == "BEBBarText")) then
		if (BEBCharSettings.BEBBarText.mouseover) then
			BEB.Feedback(BEBOPTIONS.TEXT.optionstextwasmouseover)
			BEBCharSettings.BEBBarText.mouseover = false
			BEBShowOnMouseoverCheckButton:SetChecked(false)
		end
	elseif ((this.index == "mouseover") and (BEBOPTIONS.CURRENTFRAME == "BEBBarText")) then
		if (not this:GetChecked()) then
			BEB.TextTimeToHide = nil
		end
		if (not BEBCharSettings.BEBBarText.shown) then
			BEB.Feedback(BEBOPTIONS.TEXT.optionstextwashidden)
			BEBCharSettings.BEBBarText.shown = true
			BEBShownCheckButton:SetChecked(true)
		end
	end
	BEB.SetupElement(BEBOPTIONS.CURRENTFRAME)
end

function BEBOPTIONS.ColorPicker_OnClick()
	if (ColorPickerFrame:IsShown()) then
		BEBOPTIONS.ColorPicker_Cancelled(ColorPickerFrame.previousValues)
		ColorPickerFrame:Hide()
	else
		local Red,Green,Blue,Alpha = unpack(BEBCharSettings[BEBOPTIONS.CURRENTFRAME][this.whenindex])
		ColorPickerFrame.previousValues = {Red, Green, Blue, Alpha}
		ColorPickerFrame.cancelFunc = BEBOPTIONS.ColorPicker_Cancelled
		ColorPickerFrame.opacityFunc = BEBOPTIONS.ColorPicker_OpacityChanged
		ColorPickerFrame.func = BEBOPTIONS.ColorPicker_ColorChanged
		ColorPickerFrame.index = this:GetName().."Texture"
		ColorPickerFrame.objindex = BEBOPTIONS.CURRENTFRAME
		ColorPickerFrame.whenindex = this.whenindex
		ColorPickerFrame.opacity = Alpha
		OpacitySliderFrame:SetValue(Alpha)
		ColorPickerFrame:SetColorRGB(Red, Green, Blue)
		ColorPickerFrame.hasOpacity = true
		ColorPickerFrame:ClearAllPoints()
		local x = (BEBConfigFrame:GetCenter() - (BEBDefaultsButton:GetWidth()/2))
		if (x < UIParent:GetWidth() / 2) then
			ColorPickerFrame:SetPoint("LEFT", "BEBConfigFrame", "RIGHT", 0, 0)
		else
			ColorPickerFrame:SetPoint("RIGHT", "BEBConfigFrame", "LEFT",- BEBDefaultsButton:GetWidth(), 0)
		end
		ColorPickerFrame:Show()
	end
end
function BEBOPTIONS.ColorPicker_Cancelled(color)
	BEBCharSettings[ColorPickerFrame.objindex][ColorPickerFrame.whenindex] = color
	BEBOPTIONS.OnShow(BEBOPTIONS.CURRENTFRAME)
	ColorPickerFrame.hasOpacity = false
end
function BEBOPTIONS.ColorPicker_ColorChanged()
	local r, g, b = ColorPickerFrame:GetColorRGB()
	local a = OpacitySliderFrame:GetValue()
	getglobal(ColorPickerFrame.index):SetVertexColor(r,g,b,a)
	if (not ColorPickerFrame:IsShown()) then
		BEBCharSettings[ColorPickerFrame.objindex][ColorPickerFrame.whenindex] = {r,g,b,a}
		BEB.SetColors("force")
		ColorPickerFrame.hasOpacity = false
	end
end
function BEBOPTIONS.ColorPicker_OpacityChanged()
	if (ColorPickerFrame:IsShown()) then
		local r, g, b = ColorPickerFrame:GetColorRGB()
		local a = OpacitySliderFrame:GetValue()
		getglobal(ColorPickerFrame.index):SetVertexColor(r, g, b, a)
	end
end

function BEBOPTIONS.Nudge(arg1,button)
	if (button) then
		this = getglobal(button)
	end
	local change
	if (arg1 == "RightButton") then
		change = 5
	else
		change = 1
	end
	if (this.index == "0") then
		BEBCharSettings[BEBOPTIONS.CURRENTFRAME].location.x = 0
		BEBCharSettings[BEBOPTIONS.CURRENTFRAME].location.y = 0
	elseif (this.index == "up") then
		BEBCharSettings[BEBOPTIONS.CURRENTFRAME].location.y = BEBCharSettings[BEBOPTIONS.CURRENTFRAME].location.y + change
	elseif (this.index == "down") then
		BEBCharSettings[BEBOPTIONS.CURRENTFRAME].location.y = BEBCharSettings[BEBOPTIONS.CURRENTFRAME].location.y - change
	elseif (this.index == "left") then
		BEBCharSettings[BEBOPTIONS.CURRENTFRAME].location.x = BEBCharSettings[BEBOPTIONS.CURRENTFRAME].location.x - change
	elseif (this.index == "right") then
		BEBCharSettings[BEBOPTIONS.CURRENTFRAME].location.x = BEBCharSettings[BEBOPTIONS.CURRENTFRAME].location.x + change
	end
	getglobal(this:GetParent():GetName().."xEditBox"):SetText(BEBCharSettings[BEBOPTIONS.CURRENTFRAME].location.x)
	getglobal(this:GetParent():GetName().."yEditBox"):SetText(BEBCharSettings[BEBOPTIONS.CURRENTFRAME].location.y)
end
function BEBOPTIONS.Placement_OnUpdate(elapsed)
	if (BEBNudging) then
		if (BEBNudgeTime <= 0) then
			BEBOPTIONS.Nudge("MiddleButton",BEBNudging)
			BEBNudgeTime = 0.015
		else
			BEBNudgeTime = BEBNudgeTime - elapsed
		end
	end
end
function BEBOPTIONS.PositionEditBox_OnValueChange()
	local axis = this.index
	BEBCharSettings[BEBOPTIONS.CURRENTFRAME].location[axis] = this:GetNumber()
	BEB.SetupElement(BEBOPTIONS.CURRENTFRAME)
end

function BEBOPTIONS.SliderOnChange()
	getglobal(this:GetName().."_EditBox"):SetText(this:GetValue())
	if (this.enabled) then
		BEBCharSettings[BEBOPTIONS.CURRENTFRAME][this.whatindex][this.axisindex] = this:GetValue()
	end
	BEB.SetupElement(BEBOPTIONS.CURRENTFRAME)
	if (BEBOPTIONS.CURRENTFRAME == "BEBMain") then
		BEB.SetupElement("BEBXpBar")
		BEB.SetupElement("BEBRestedXpBar")
		BEB.SetupElement("BEBRestedXpTick")
	end
	if ((this.label == "height") and (BEBOPTIONS.CURRENTFRAME == "BEBBarText") and(BEBCharSettings.BEBBarText.mouseover)) then
		BEBBarText:Show()
		BEB.TextTimeToHide = 2
	end
end
function BEBOPTIONS.SliderEditBox_OnValueChange()
	local value = this:GetNumber()
	local slidervalue = this:GetParent():GetValue(value)
	if (value ~= slidervalue) then
		this:GetParent():SetValue(value)
	end
end

function BEBOPTIONS.ShowMenu()
	if (BEB_DropDownMenu:IsVisible()) then
		BEB_DropDownMenu:Hide()
		return
	end
	BEB_DropDownMenu.whatindex = BEBOPTIONS.CURRENTFRAME
	if (this.typeindex) then
		BEB_DropDownMenu.typeindex = this.typeindex
	else
		BEB_DropDownMenu.typeindex = nil
	end
	if (this.subindex) then
		BEB_DropDownMenu.subindex = this.subindex
	else
		BEB_DropDownMenu.subindex = nil
	end
	if (not this.controlbox) then
		this.controlbox = this:GetName()
	end
	BEB_DropDownMenu.controlbox = this.controlbox
	if (this.func) then
		BEB_DropDownMenu.func = this.func
	else
		BEB_DropDownMenu.func = nil
	end
	BEB_DropDownMenu.controlboxtype = this.controlboxtype
	BEB_DropDownMenu.table = this.table
	local count = 0
	local widest = 0
	for value, text in BEBOPTIONS[this.table] do
		count = count + 1
		getglobal("BEB_DropDownMenu_Button"..count):SetText(text)
		getglobal("BEB_DropDownMenu_Button"..count).value = value
		getglobal("BEB_DropDownMenu_Button"..count):Show()
		local width = getglobal("BEB_DropDownMenu_Button"..count):GetTextWidth()
		widest = math.max(widest, width)
	end
	for i=1, BEB_DropDownMenu.count do
		if (i <= count) then
			getglobal("BEB_DropDownMenu_Button"..i):SetWidth(widest)
		else
			getglobal("BEB_DropDownMenu_Button"..i):Hide()			
		end
	end
	BEB_DropDownMenu:SetWidth(widest + 20)
	BEB_DropDownMenu:SetHeight(count * 15 + 20)
	BEB_DropDownMenu:ClearAllPoints()
	BEB_DropDownMenu:SetPoint("TOPLEFT", getglobal(this.controlbox), "BOTTOMLEFT", 0, 0)
	if (BEB_DropDownMenu:GetBottom() < UIParent:GetBottom()) then
		local yoffset = UIParent:GetBottom() - BEB_DropDownMenu:GetBottom()
		BEB_DropDownMenu:ClearAllPoints()
		BEB_DropDownMenu:SetPoint("TOPLEFT", getglobal(this.controlbox), "BOTTOMLEFT", 0, yoffset)
	end
	BEB_DropDownMenu:Show()
	BEB_DropDownMenu.timer = 2
end
function BEBOPTIONS.MenuOptionOnClick()
	BEBOPTIONS[this:GetParent().func]()
	BEB.SetupElement(BEBOPTIONS.CURRENTFRAME)
	BEB_DropDownMenu:Hide()
end


function BEBOPTIONS.DDM_OnUpdate(elapsed)
	if (this.timer) then
		if (this.timer <= 0) then
			this:Hide()
		else
			this.timer = this.timer - elapsed
		end
	end
end
function BEBOPTIONS.DDM_ReplaceText()
	local table = BEBOPTIONS[this:GetParent().table]
	getglobal(this:GetParent().controlbox):SetText(table[this.value])
	if (this:GetParent().subindex) then
		BEBCharSettings[this:GetParent().whatindex][this:GetParent().typeindex][this:GetParent().subindex] = this.value
	else
		BEBCharSettings[this:GetParent().whatindex][this:GetParent().typeindex] = this.value
	end
	BEBOPTIONS.OnShow(BEBOPTIONS.CURRENTFRAME)
end
function BEBOPTIONS.DDM_InsertText()
	getglobal(this:GetParent().controlbox):Insert(this.value)
	if (this:GetParent().subindex) then
		BEBCharSettings[this:GetParent().whatindex][this:GetParent().typeindex][this:GetParent().subindex] = getglobal(this:GetParent().controlbox):GetText()
	else
		BEBCharSettings[this:GetParent().whatindex][this:GetParent().typeindex] = getglobal(this:GetParent().controlbox):GetText()
	end
	if (this:GetParent().subindex and this:GetParent().subindex == "string") then
		BEBOPTIONS.ChangeText(this:GetParent().whatindex)
	end
end

function BEBOPTIONS.DDM_SetText()
	getglobal(this:GetParent().controlbox):SetText(this.value)
end

function BEBOPTIONS.MenuEditBoxChangeText()
	if (getglobal(this:GetParent():GetName().."Button").subindex and getglobal(this:GetParent():GetName().."Button").subindex == "relto") then
		BEBOPTIONS.ChangeAttachTo(BEBOPTIONS.CURRENTFRAME)
	elseif (getglobal(this:GetParent():GetName().."Button").subindex and getglobal(this:GetParent():GetName().."Button").subindex == "string") then
		BEBOPTIONS.ChangeText(BEBOPTIONS.CURRENTFRAME)
	elseif (getglobal(this:GetParent():GetName().."Button").typeindex == "texture") then
		BEBOPTIONS.ChangeTexture(BEBOPTIONS.CURRENTFRAME)
	end
end

function BEBOPTIONS.ChangeText(frame)
	if (frame == "BEBBarText") then
		BEB.CompileString(BEB_BarTextFrameEditBox:GetText(), getglobal(frame))
		BEB.StringEvent("WRITE_ALL", frame)
		BEBCharSettings.BEBBarText.text.string = BEB_BarTextFrameEditBox:GetText()
	end
end

function BEBOPTIONS.ChangeAttachTo(frame)
	if (BEB.IsFrame(this:GetText())) then
		BEBCharSettings[frame].location.relto = this:GetText()
		BEB.SetupElement(BEBOPTIONS.CURRENTFRAME)
	else
		BEB.Feedback(BEBOPTIONS.TEXT.frameisinvalid)
		this:SetText(this.prevvals)
	end
end

function BEBOPTIONS.ChangeTexture(frame)
	BEBCharSettings[frame].texture = this:GetText()
	BEB.SetupElement(BEBOPTIONS.CURRENTFRAME)
end

function BEBOPTIONS.CreateProfile()
	local bebprofile = getglobal(this:GetName().."EditBox"):GetText()
	if (bebprofile == BEBOPTIONS.TEXT.none) then
		return
	end
	if (BEBGlobal.profiles[bebprofile]) then
		BEB.Feedback(BEBOPTIONS.TEXT.profilealreadyexists)
	else
		BEBGlobal.profiles[bebprofile] = {}
		BEB.SaveProfile(bebprofile)
		table.setn(BEBGlobal.profiles,(table.getn(BEBGlobal.profiles)+1))
	end
	BEBOPTIONS.SetElementValue("BEBProfileFrame")
end
function BEBOPTIONS.UseProfile()
	if (BEBCharSettings.BEBProfile) then
		BEBCharSettings.BEBProfile = false
	else
		local bebprofile = getglobal(this:GetName().."DDMButton"):GetText()
		if (bebprofile == BEBOPTIONS.TEXT.none) then
			return
		end
		BEB.LoadProfile(bebprofile)
		BEBCharSettings.BEBProfile = bebprofile
		BEB.SetupBars()
	end
	BEBOPTIONS.SetElementValue("BEBProfileFrame")
end
function BEBOPTIONS.LoadProfile()
	local bebprofile = getglobal(this:GetName().."DDMButton"):GetText()
	if (bebprofile == BEBOPTIONS.TEXT.none) then
		return
	end
	BEB.LoadProfile(bebprofile)
	BEBCharSettings.BEBProfile = false
	BEB.SetupBars()
	BEBOPTIONS.SetElementValue("BEBProfileFrame")
end
function BEBOPTIONS.SaveProfile()
	local bebprofile = getglobal(this:GetName().."DDMButton"):GetText()
	if (bebprofile == BEBOPTIONS.TEXT.none) then
		return
	end
	BEB.SaveProfile(bebprofile)
	BEBOPTIONS.SetElementValue("BEBProfileFrame")
end
function BEBOPTIONS.DeleteProfile()
	local bebprofile = getglobal(this:GetName().."DDMButton"):GetText()
	if (bebprofile == BEBOPTIONS.TEXT.none) then
		return
	end
	if (bebprofile == BEBCharSettings.BEBProfile) then
		BEBCharSettings.BEBProfile = false
		BEBGlobal.profiles[bebprofile] = nil
		table.setn(BEBGlobal.profiles,(table.getn(BEBGlobal.profiles)-1))
	else
		BEBGlobal.profiles[bebprofile] = nil
		table.setn(BEBGlobal.profiles,(table.getn(BEBGlobal.profiles)-1))
	end
	BEBOPTIONS.SetElementValue("BEBProfileFrame")
end

function BEBOPTIONS.LevelSliderOnChange()
	getglobal(this:GetName().."_EditBox"):SetText(this:GetValue())
	if (this.enabled) then
		BEBCharSettings[BEBOPTIONS.CURRENTFRAME][this.whatindex] = this:GetValue()
	end
	BEB.SetupElement(BEBOPTIONS.CURRENTFRAME)
	if ((BEBOPTIONS.CURRENTFRAME == "BEBBarText") and(BEBCharSettings.BEBBarText.mouseover)) then
		BEBBarText:Show()
		BEB.TextTimeToHide = 2
	end
end
function BEBOPTIONS.LevelSliderEditBox_OnValueChange()
	local value = this:GetNumber()
	local slidervalue = this:GetParent():GetValue(value)
	if (value ~= slidervalue) then
		this:GetParent():SetValue(value)
	end
end