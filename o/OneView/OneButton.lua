local Tablet = AceLibrary("Tablet-2.0")
local L = AceLibrary("AceLocale-2.0"):new("OneView")

OneViewFu = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "FuBarPlugin-2.0")
OneViewFu:RegisterDB("OneViewButtonDB")

function OneViewFu:OnInitialize()
    self.hasIcon = true
    self:SetIcon(true)
end

function OneViewFu:OnEnable()
end

function OneViewFu:OnTextUpdate()
    if self:IsTextShown() then
        self:SetText("OneView")
    end
    if not self:IsIconShown() then
        self:HideIcon()
    end
end

function OneViewFu:OnClick()
    if OneViewFrame:IsVisible() then
        OneViewFrame:Hide()
    else
        OneViewFrame:Show()
    end
end

function OneViewFu:OnTooltipUpdate()
	local cat = Tablet:AddCategory(
		'columns', 1,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 1
	)
	cat:AddLine(
		'text', L"Show the OneView Frame"
	)
end