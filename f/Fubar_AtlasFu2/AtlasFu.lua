AtlasFu = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0");
local L = AceLibrary("AceLocale-2.0"):new("AtlasFu");
local Tablet = AceLibrary("Tablet-2.0");

L:RegisterTranslations("enUS", function() return {
	["tabletHint"] = "Click to show Atlas.",
	["labelName"] = "Atlas",
} end);

AtlasFu:RegisterDB("AtlasFuDB");
AtlasFu.hasIcon = true;
AtlasFu.defaultPosition = "RIGHT";

local optionsTable = {
	handler = AtlasFu,
	type = "group",
	args = {};
};

AtlasFu:RegisterChatCommand({ "/atlasfu", "/atlas2fu" }, optionsTable);
AtlasFu.OnMenuRequest = optionsTable;

function AtlasFu:OnTextUpdate()
	if (self:IsTextShown()) then
		self:ShowText();
		self:SetText("|cffffffff"..L"labelName".."|r");
	else
		self:HideText();
	end
end

function AtlasFu:OnTooltipUpdate()
	Tablet:SetHint(L"tabletHint");
end

function AtlasFu:OnClick()
	Atlas_Toggle();
end