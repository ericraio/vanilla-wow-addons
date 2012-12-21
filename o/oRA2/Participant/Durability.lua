
assert( oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRAPDurability")
local G = AceLibrary("Gratuity-2.0")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["durability"] = true,
	["Participant/Durability"] = true,
	["Options for durability checks."] = true,
	["durabilityparticipant"] = true,
	
} end )

L:RegisterTranslations("koKR", function() return {

	["Participant/Durability"] = "부분/내구도",
	["Options for durability checks."] = "내구도 설정",
	
} end )

L:RegisterTranslations("zhCN", function() return {
	["durability"] = "耐久度",
	["Participant/Durability"] = "Participant/Durability",
	["Options for durability checks."] = "耐久度检查选项",
	["durabilityparticipant"] = "durabilityparticipant",
	
} end )

L:RegisterTranslations("zhTW", function() return {
	["durability"] = "耐久度",
	["Participant/Durability"] = "隊員/耐久度",
	["Options for durability checks."] = "耐久度檢查選項",
	["durabilityparticipant"] = "durabilityparticipant",
	
} end )

L:RegisterTranslations("frFR", function() return {
	--["durability"] = true,
	["Participant/Durability"] = "Participant/Durabilit\195\169",
	["Options for durability checks."] = "Options concernant les v\195\169rifications des durabilit\195\169s.",
	--["durabilityparticipant"] = true,
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

oRAPDurability = oRA:NewModule(L["durabilityparticipant"])
oRAPDurability.defaults = {
}
oRAPDurability.participant = true
oRAPDurability.name = L["Participant/Durability"]
-- oRAPDurability.consoleCmd = L["durability"]
-- oRAPDurability.consoleOptions = {
--        type = "group",
--        desc = L["Options for durability checks."],
--        args = {
--        }
-- }

------------------------------
--      Initialization      --
------------------------------

function oRAPDurability:OnEnable()
	self:RegisterCheck("DURC", "oRA_DurabilityCheck")
end

function oRAPDurability:OnDisable()
	self:UnregisterAllEvents()
end

------------------------------
--      Event Handlers      --
------------------------------

function oRAPDurability:oRA_DurabilityCheck(msg, author)
	if not self:IsValidRequest(author) then return end
	local cur, max, broken = self:GetDurability()
	self:SendMessage(string.format("DUR %s %s %s %s", cur, max, broken, author))
end

------------------------------
--    Utility Functions     --
------------------------------

function oRAPDurability:GetDurability()
	local cur, max, broken = 0, 0, 0
	for i=1,18 do
		G:Erase()
		G:SetInventoryItem("player", i)
		local imin, imax = G:FindDeformat(DURABILITY_TEMPLATE)
		if imin and imax then
			imin, imax = tonumber(imin), tonumber(imax)
			if imin == 0 then broken = broken + 1 end
			cur = cur + imin
			max = max + imax
		end
		
	end
	return cur, max, broken
end
