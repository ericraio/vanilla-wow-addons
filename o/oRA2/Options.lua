
assert(oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRAOptions")
local Tablet = AceLibrary("Tablet-2.0")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	tablethint = "|cffeda55fCtrl-Alt-Click|r to disable oRA completely. |cffeda55fAlt-Drag|r to move MT,PT and the monitors.",
	tablethint_disabled = "oRA is currently disabled. |cffeda55fClick|r to enable.",
	["oRA Options"] = true,
	["Active boss modules"] = true,
	["Hidden"] = true,
	["Shown"] = true,
	["minimap"] = true,
	["Minimap"] = true,
	["Toggle the minimap button."] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	tablethint = "|cffeda55fCtrl Alt 클릭시|r oRA를 완전히 사용하지 않습니다. Alt키를 누른 상태에서 메인탱커창와 플레이어탱커창과 각종 모니터창을 드래그해서 이동할 수 있습니다.",
	tablethint_disabled = "oRA 는 현재 사용중지 중입니다. |cffeda55f클릭시|r 사용합니다.",
	["oRA Options"] = "oRA 설정",
	["Active boss modules"] = "보스 모듈 활성화",
	["Hidden"] = "숨김",
	["Shown"] = "표시",
	["Minimap"] = "미니맵",
	["Toggle the minimap button."] = "미니맵 버튼 토글",
} end)


L:RegisterTranslations("zhCN", function() return {
	tablethint = "|cffeda55fCtrl-Alt-点击|r 来关闭oRA．|cffeda55f按住Alt-拖动|r来移动MT，PT和监视器",
	tablethint_disabled = "oRA目前关闭。|cffeda55f点击|r来激活。",
	["Active boss modules"] = "激活boss模块",
	["Hidden"] = "隐藏",
	["Shown"] = "显示",
	["minimap"] = "小地图",
	["Minimap"] = "小地图",
	["Toggle the minimap button."] = "显示小地图图标",
} end)

L:RegisterTranslations("zhTW", function() return {
	tablethint = "|cffeda55fCtrl-Alt-點擊|r 可關閉 oRA。 |cffeda55fAlt-拖曳|r 可移動 MT、PT 及監視框架。",
	tablethint_disabled = "oRA 目前已關閉。|cffeda55f點擊|r可啟動 oRA。",
	["oRA Options"] = "oRA 選項",
	["Active boss modules"] = "啟動BOSS模組",
	["Hidden"] = "隱藏",
	["Shown"] = "顯示",
	["minimap"] = "小地圖",
	["Minimap"] = "小地圖",
	["Toggle the minimap button."] = "顯示小地圖按鈕。",
} end)

L:RegisterTranslations("frFR", function() return {
	tablethint = "|cffeda55fCtrl-Alt-Clic|r pour d\195\169sactiver compl\195\168tement oRA. Maintenez enfoncer la touche Alt pour saisir les cadres des MTs & PTs ainsi que les moniteurs.",
	tablethint_disabled = "oRA est actuellement d\195\169sactiv\195\169. |cffeda55fCliquez|r pour l'activer.",
	["oRA Options"] = "Options concernant oRA",
	["Active boss modules"] = "Modules boss actifs",
	["Hidden"] = "Cach\195\169",
	["Shown"] = "Affich\195\169",
	--["minimap"] = true,
	["Minimap"] = "Minicarte",
	["Toggle the minimap button."] = "Affiche ou non le bouton de la minicarte.",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local deuce = oRA:NewModule("Options Menu")
deuce.hasFuBar = IsAddOnLoaded("FuBar") and FuBar
deuce.consoleCmd = not deuce.hasFuBar and L["minimap"]
deuce.consoleOptions = not deuce.hasFuBar and {
	type = "toggle",
	name = L["Minimap"],
	desc = L["Toggle the minimap button."],
	get = function() return oRAOptions.minimapFrame and oRAOptions.minimapFrame:IsVisible() or false end,
	set = function(v) if v then oRAOptions:Show() else oRAOptions:Hide() end end,
	map = {[false] = L["Hidden"], [true] = L["Shown"]},
	hidden = function() return deuce.hasFuBar and true end,
}

----------------------------
--      FuBar Plugin      --
----------------------------

oRAOptions = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")
oRAOptions.name = "FuBar - oRA"
oRAOptions:RegisterDB("oRAFubarDB")

oRAOptions.hasNoColor = true
oRAOptions.hasIcon = "Interface\\AddOns\\oRA2\\Icons\\core_enabled"
oRAOptions.defaultMinimapPosition = 180
oRAOptions.hideWithoutStandby = true
oRAOptions.clickableTooltip = true

-- XXX total hack
oRAOptions.OnMenuRequest = deuce.core.consoleOptions
local args = AceLibrary("FuBarPlugin-2.0"):GetAceOptionsDataTable(oRAOptions)
for k,v in pairs(args) do
	if oRAOptions.OnMenuRequest.args[k] == nil then
		oRAOptions.OnMenuRequest.args[k] = v
	end
end
-- XXX end hack

-----------------------------
--      Icon Handling      --
-----------------------------

function oRAOptions:OnEnable()
	self:RegisterEvent("oRA_CoreEnabled", "CoreState")
	self:RegisterEvent("oRA_CoreDisabled", "CoreState")
	self:RegisterEvent("oRA_UpdateConfigGUI", "Update")

	self:CoreState()
end

function oRAOptions:CoreState()
	if oRA:IsActive() then
		self:SetIcon("Interface\\AddOns\\oRA2\\Icons\\core_enabled")
	else
		self:SetIcon("Interface\\AddOns\\oRA2\\Icons\\core_disabled")
	end

	self:UpdateTooltip()
end

-----------------------------
--      FuBar Methods      --
-----------------------------

function oRAOptions:OnTooltipUpdate()
--	local cat = Tablet:AddCategory("columns", 1)
--	cat:AddLine("text", L["oRA Options"], "justify", "CENTER")
	if oRA:IsActive() then
		Tablet:SetHint(L["tablethint"])
		for k,module in pairs(oRA.moduletooltips) do
			module:OnTooltipUpdate()
		end
	else
		Tablet:SetHint(L["tablethint_disabled"])
	end
end

function oRAOptions:OnClick()
	if oRA:IsActive() then
		if IsControlKeyDown() and IsAltKeyDown() then
			oRA:ToggleActive(false)
		end
	else
		oRA:ToggleActive(true)
	end

	self:UpdateTooltip()
end

