-- XPerl_OptionsFrame_SelectFrame
function XPerl_OptionsFrame_SelectFrame(frame)
	XPerl_Options:Show()

	if (frame == "player") then
		XPerl_Options_Player:Show()
		XPerl_Options_Party:Hide()
		XPerl_Options_Raid:Hide()

	elseif (frame == "party") then
		XPerl_Options_Player:Hide()
		XPerl_Options_Party:Show()
		XPerl_Options_Raid:Hide()

	elseif (frame == "raid") then
		XPerl_Options_Player:Hide()
		XPerl_Options_Party:Hide()
		XPerl_Options_Raid:Show()
	end
end

-- XPerl_OptionsSetMyText
function XPerl_OptionsSetMyText(f, str)

	if (f and str) then
		local textFrame = getglobal(f:GetName().."Text")

		if (textFrame) then
			textFrame:SetText(getglobal(str))
			f.tooltipText = getglobal(str.."_DESC")

		elseif (f:GetFrameType() == "Button") then
			f:SetText(getglobal(str))
			f.tooltipText = getglobal(str.."_DESC")
		end

		setglobal(str, nil)
		setglobal(str.."_DESC", nil)
	end
end

-- XPerl_GetCheck
function XPerl_GetCheck(f)
	if (f:GetChecked()) then
	        return 1
	else
	        return 0
	end
end

-- DisableSlider
local function DisableSlider(frame)
	OptionsFrame_DisableSlider(frame)
	getglobal(frame:GetName().."Current"):SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
end

-- EnableSlider
local function EnableSlider(frame)
	OptionsFrame_EnableSlider(frame)
        getglobal(frame:GetName().."Current"):SetVertexColor(0.4, 0.4, 0.80)
end

-- XPerl_Options_EnableSibling
function XPerl_Options_EnableSibling(sibling, check2nd, check3rd)

	local siblingName = this:GetParent():GetName().."_"..sibling
	local siblingFrame = getglobal(siblingName)
	local second = true
	local condition = "and"

	if (type(check2nd) == "string") then
		condition = check2nd
		check2nd = check3rd
	end
	if (check2nd and type(check2nd) == "table") then
		second = check2nd:GetChecked()
	end

	local result
	if (condition == "and") then
		result = (this:GetChecked() and second)
	elseif (condition == "or") then
		result = (this:GetChecked() or second)
	end

	if (siblingFrame) then
		if (siblingFrame:GetFrameType() == "Button") then
			if (result) then
				siblingFrame:Enable()
			else
				siblingFrame:Disable()
			end
		elseif (siblingFrame:GetFrameType() == "CheckButton") then
			local textFrame = getglobal(siblingFrame:GetName().."Text")
			if (result) then
				siblingFrame:Enable()
				textFrame:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
			else
				siblingFrame:Disable()
				textFrame:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
			end
		elseif (siblingFrame:GetFrameType() == "Slider") then
			if (result) then
				EnableSlider(siblingFrame)
			else
				DisableSlider(siblingFrame)
			end

		else
			DEFAULT_CHAT_FRAME:AddMessage("|c00FF0000X-Perl|r - No code to disable '"..siblingFrame:GetName().."' type: "..siblingFrame:GetFrameType())
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("|c00FF0000X-Perl|r - No sibling found called '"..siblingName.."'")
	end
end

-- XPerl_Options_IncrementSibling
function XPerl_Options_IncrementSibling(sibling)
	local siblingName = this:GetParent():GetName().."_"..sibling
	local siblingFrame = getglobal(siblingName)

	if (siblingFrame and siblingFrame:GetFrameType() == "EditBox") then
        	local n = tonumber(siblingFrame:GetText())
		n = n + 1
		siblingFrame:SetText(n)
		return n
	end
end

-- XPerl_Options_DecrementSibling
function XPerl_Options_DecrementSibling(sibling)
	local siblingName = this:GetParent():GetName().."_"..sibling
	local siblingFrame = getglobal(siblingName)

	if (siblingFrame and siblingFrame:GetFrameType() == "EditBox") then
        	local n = tonumber(siblingFrame:GetText())
		n = n - 1
		siblingFrame:SetText(n)
		return n
	end
end

-- XPerl_Options_CheckRadio
function XPerl_Options_CheckRadio(buttons)
	local prefix = this:GetParent():GetName().."_"

	for i,name in pairs(buttons) do
		if (prefix..name == this:GetName()) then
			getglobal(prefix..name):SetChecked(true)
		else
			getglobal(prefix..name):SetChecked(false)
		end
	end
end

-- XPerl_Options_GetSiblingChecked
function XPerl_Options_GetSiblingChecked(name)
	local prefix = this:GetParent():GetName().."_"
	return getglobal(prefix..name):GetChecked()
end

-- XPerl_Raid_OptionActions
function XPerl_Raid_OptionActions()
        XPerl_Raid_Position()
	XPerl_Raid_Set_Bits()
end

-- XPerl_Options_OnUpdate
function XPerl_Options_OnUpdate()

	if (this.Fading) then
	        local alpha = this:GetAlpha()
	        if (this.Fading == "in") then
	                alpha = alpha + (arg1 * 2)		-- elapsed * 2 == fade in/out in 1/2 second
	                if (alpha > 1) then
	                        alpha = 1
	                end
	        elseif (this.Fading == "out") then
	                alpha = alpha - (arg1 * 2)
	                if (alpha < 0) then
	                        alpha = 0
	                end
	        end
	        this:SetAlpha(alpha)
	        if (alpha == 0) then
	                this.Fading = nil
	                this:Hide()
	        elseif (alpha == 1) then
	                this.Fading = nil
	        end
	else
		local f = GetMouseFocus()
		if (f and f:GetName()) then
			if (f:GetName() == "XPerl_Player_CastClickOverlay" or strfind(f:GetName(), "Target_CastClickOverlay")) then
				XPerl_OptionsFrame_SelectFrame("player")
			elseif (strfind(f:GetName(), "XPerl_party%d_CastClickOverlay")) then
				XPerl_OptionsFrame_SelectFrame("party")
			elseif (strfind(f:GetName(), "XPerl_raid(%d+)_CastClickOverlay")) then
				XPerl_OptionsFrame_SelectFrame("raid")
			end
		end
	end
end

-- XPerl_Options_SetBarTextureHighlight
function XPerl_Options_SetBarTextureHighlight()

	local name = this:GetName()
	name = string.sub(name, 1, string.len(name) - 1)

	for i = 0,3 do
		local f = getglobal(name..i)

		if (f) then
			if (XPerlConfig.BarTextures == i) then
				f:LockHighlight()
			else
				f:UnlockHighlight()
			end
		else
			ChatFrame7:AddMessage("No frame called "..name..i)
		end
	end
end

-- XPerl_Options_MaxScaleSet
local Sliders = {}
function XPerl_Options_MaxScaleSet()

	for i,slider in pairs(Sliders) do
        	local old = slider:GetValue()
		local max = math.floor(XPerlConfig.MaximumScale * 100 + 0.5)

        	getglobal(slider:GetName().."High"):SetText(string.format("%d%%", max))
        	slider:SetMinMaxValues(50, max)

		if (old > max) then
			slider:SetValue(max)
		end
	end
end

-- XPerl_Options_RegisterScalingSlider
function XPerl_Options_RegisterScalingSlider(slider)

	Sliders[slider:GetName()] = slider

        getglobal(slider:GetName().."Low"):SetText("50%")
        getglobal(slider:GetName().."High"):SetText(string.format("%d%%", math.floor((XPerlConfig.MaximumScale or 1.5) * 100 + 0.5)))

        slider:SetMinMaxValues(50, math.floor(XPerlConfig.MaximumScale * 100 + 0.5))
        slider:SetValueStep(1)
end

-- XPerl_Popup
function XPerl_Popup(question, onAccept)
	StaticPopupDialogs["XPERL_QUESTION"] = {
	  text = question,
	  button1 = YES,
	  button2 = NO,
	  OnAccept = onAccept,
	  timeout = 0,
	  whileDead = 1,
	  hideOnEscape = 1,
	  showAlert = 1
	}
	StaticPopup_Show("XPERL_QUESTION")
end

-- Load settings menu
local MyIndex = 0
local function GetPlayerList()
	local ret = {}
	if (XPerlConfig_Global) then
		local me = GetRealmName().." / "..UnitName("player")
		for realmName, realmConfig in pairs(XPerlConfig_Global) do
			for playerName, settings in pairs(realmConfig) do
				local entry = realmName.." / "..playerName

				tinsert(ret, {name = entry, config = settings})

				if (entry == me) then
					MyIndex = getn(ret)
				end
			end
		end
	end
	return ret
end

-- XPerl_Options_LoadSettings_OnLoad
function XPerl_Options_LoadSettings_OnLoad()
	UIDropDownMenu_Initialize(this, XPerl_Options_LoadSettings_Initialize)
	UIDropDownMenu_SetSelectedID(this, MyIndex, 1)
	UIDropDownMenu_SetWidth(140, XPerl_Options_DropDown_LoadSettings)
end

-- XPerl_Options_LoadSettings_Initialize
function XPerl_Options_LoadSettings_Initialize()
	XPerl_Options_LoadSettings_LoadList(GetScreenResolutions())
end

-- XPerl_Options_LoadSettings_LoadList
function XPerl_Options_LoadSettings_LoadList(...)
	local info
	local list = GetPlayerList()

	for i,entry in pairs(list) do
		info = {}
		info.text = entry.name
		info.func = XPerl_Options_LoadSettings_OnClick
		UIDropDownMenu_AddButton(info)
	end
end

-- CopySelectedSettings
local CopyFrom
local function CopySelectedSettings()
	--ChatFrame7:AddMessage("Copying settings from "..CopyFrom)
	--UIDropDownMenu_SetSelectedID(XPerl_Options_DropDown_LoadSettings, this:GetID(), 1)

	XPerlConfig = {}
	XPerl_Defaults()

	for name,value in pairs(CopyFrom.config) do
		XPerlConfig[name] = value
	end

	XPerl_Options:Hide()
	XPerl_Options:Show()

	XPerl_OptionActions()
end

-- XPerl_Options_LoadSettings_OnClick
function XPerl_Options_LoadSettings_OnClick()

	local list = GetPlayerList()

	if (this:GetID() ~= MyIndex) then
		local entry = list[this:GetID()]

		if (entry) then
			CopyFrom = entry
			XPerl_Popup(string.format("Copy settings from %s?", entry.name), CopySelectedSettings)
		end
	end
end

-- XPerl_Options_SetTabColor
function XPerl_Options_SetTabColor(tab, color)
	for i,y in {"Enabled", "Disabled"} do
		for j,z in {"Left", "Right", "Middle"} do
			local f = getglobal(tab:GetName()..y..z)
			f:SetVertexColor(color.r, color.g, color.b, color.a)
		end
	end
end

-- XPerl_Options_EnableTab
function XPerl_Options_EnableTab(tab, enable)
	for i,y in pairs({"Enabled", "Disabled"}) do
		for j,z in pairs({"Left", "Right", "Middle"}) do
			local f = getglobal(tab:GetName()..y..z)

			if ((i == 1 and enable) or (i == 2 and not enable)) then
				f:Show()
			else
				f:Hide()
			end
		end
	end
end
