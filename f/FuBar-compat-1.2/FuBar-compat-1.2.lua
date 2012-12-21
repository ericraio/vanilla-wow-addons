Gratuity:GetInstance('1'):RegisterTooltip(FuBarScanningTooltip)

local function init()
	AceEvent2_0 = AceLibrary and AceLibrary:HasInstance("AceEvent-2.0") and AceLibrary("AceEvent-2.0")
	if AceEvent2_0 then
		init = nil
		AceEvent2_0:RegisterEvent("FuBar_ChangedPanels", function()
			if AceEvent then
				AceEvent:TriggerEvent("FUBAR_CHANGED_PANELS")
			end
		end)
	end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
local first = true
frame:SetScript("OnEvent", function()
	if first then
		first = false
		return
	end
	if init then
		init()
	else
		frame:SetScript("OnEvent", nil)
	end
end)

JostleLib = {
	GetInstance = function()
		return AceLibrary:HasInstance("Jostle-2.0") and AceLibrary("Jostle-2.0")
	end
}