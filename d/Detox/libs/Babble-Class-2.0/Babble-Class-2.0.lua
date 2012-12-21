--[[
Name: Babble-Class-2.0
Revision: $Rev: 9146 $
Author(s): ckknight (ckknight@gmail.com)
Website: http://ckknight.wowinterface.com/
Documentation: http://wiki.wowace.com/index.php/Babble-Class-2.0
SVN: http://svn.wowace.com/root/trunk/BabbleLib/Babble-Class-2.0
Description: A library to provide localizations for classes.
Dependencies: AceLibrary, AceLocale-2.0
]]

local MAJOR_VERSION = "Babble-Class-2.0"
local MINOR_VERSION = tonumber(string.sub("$Revision: 9146 $", 12, -3))

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end

if not AceLibrary:HasInstance("AceLocale-2.0") then error(MAJOR_VERSION .. " requires AceLocale-2.0") end

local _, x = AceLibrary("AceLocale-2.0"):GetLibraryVersion()
MINOR_VERSION = MINOR_VERSION * 100000 + x

if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

local BabbleClass = AceLibrary("AceLocale-2.0"):new(MAJOR_VERSION)

-- uncomment below for debug information
-- BabbleClass:EnableDebugging()

BabbleClass:RegisterTranslations("enUS", function()
	return {
		["Warlock"] = "Warlock",
		["Warrior"] = "Warrior",
		["Hunter"] = "Hunter",
		["Mage"] = "Mage",
		["Priest"] = "Priest",
		["Druid"] = "Druid",
		["Paladin"] = "Paladin",
		["Shaman"] = "Shaman",
		["Rogue"] = "Rogue",
	}
end)

BabbleClass:RegisterTranslations("deDE", function()
	return {
		["Warlock"] = "Hexenmeister",
		["Warrior"] = "Krieger",
		["Hunter"] = "Jäger",
		["Mage"] = "Magier",
		["Priest"] = "Priester",
		["Druid"] = "Druide",
		["Paladin"] = "Paladin",
		["Shaman"] = "Schamane",
		["Rogue"] = "Schurke",
	}
end)

BabbleClass:RegisterTranslations("frFR", function()
	return {
		["Warlock"] = "Démoniste",
		["Warrior"] = "Guerrier",
		["Hunter"] = "Chasseur",
		["Mage"] = "Mage",
		["Priest"] = "Prêtre",
		["Druid"] = "Druide",
		["Paladin"] = "Paladin",
		["Shaman"] = "Chaman",
		["Rogue"] = "Voleur",
	}
end)

BabbleClass:RegisterTranslations("zhCN", function()
	return {
		["Warlock"] = "术士",
		["Warrior"] = "战士",
		["Hunter"] = "猎人",
		["Mage"] = "法师",
		["Priest"] = "牧师",
		["Druid"] = "德鲁伊",
		["Paladin"] = "圣骑士",
		["Shaman"] = "萨满祭祀",
		["Rogue"] = "盗贼",
	}
end)

BabbleClass:RegisterTranslations("koKR", function()
	return {
		["Warlock"] = "흑마법사",
		["Warrior"] = "전사",
		["Hunter"] = "사냥꾼",
		["Mage"] = "마법사",
		["Priest"] = "사제",
		["Druid"] = "드루이드",
		["Paladin"] = "성기사",
		["Shaman"] = "주술사",
		["Rogue"] = "도적",
	}
end)

BabbleClass:Debug()
BabbleClass:SetStrictness(true)

function BabbleClass:GetColor(class)
	self:argCheck(class, 2, "string")
	if string.find(class, "^[A-Z]*$") then
		class = string.upper(strsub(class, 1, 1)) .. string.lower(strsub(class, 2))
	elseif self:HasReverseTranslation(class) then
		class = self:GetReverseTranslation(class)
	end
	if class == "Warlock" then
		return RAID_CLASS_COLORS["WARLOCK"].r, RAID_CLASS_COLORS["WARLOCK"].g, RAID_CLASS_COLORS["WARLOCK"].b
	elseif class == "Warrior" then
		return RAID_CLASS_COLORS["WARRIOR"].r, RAID_CLASS_COLORS["WARRIOR"].g, RAID_CLASS_COLORS["WARRIOR"].b
	elseif class == "Hunter" then
		return RAID_CLASS_COLORS["HUNTER"].r, RAID_CLASS_COLORS["HUNTER"].g, RAID_CLASS_COLORS["HUNTER"].b
	elseif class == "Mage" then
		return RAID_CLASS_COLORS["MAGE"].r, RAID_CLASS_COLORS["MAGE"].g, RAID_CLASS_COLORS["MAGE"].b
	elseif class == "Priest" then
		return RAID_CLASS_COLORS["PRIEST"].r, RAID_CLASS_COLORS["PRIEST"].g, RAID_CLASS_COLORS["PRIEST"].b
	elseif class == "Druid" then
		return RAID_CLASS_COLORS["DRUID"].r, RAID_CLASS_COLORS["DRUID"].g, RAID_CLASS_COLORS["DRUID"].b
	elseif class == "Paladin" then
		return RAID_CLASS_COLORS["PALADIN"].r, RAID_CLASS_COLORS["PALADIN"].g, RAID_CLASS_COLORS["PALADIN"].b
	elseif class == "Shaman" then
		return RAID_CLASS_COLORS["SHAMAN"].r, RAID_CLASS_COLORS["SHAMAN"].g, RAID_CLASS_COLORS["SHAMAN"].b
	elseif class == "Rogue" then
		return RAID_CLASS_COLORS["ROGUE"].r, RAID_CLASS_COLORS["ROGUE"].g, RAID_CLASS_COLORS["ROGUE"].b
	end
		return 0.63, 0.63, 0.63
end

function BabbleClass:GetHexColor(class)
	self:argCheck(class, 2, "string")
	local r, g, b = self:GetColor(class)
	return string.format("%02x%02x%02x", r * 255, g * 255, b * 255)
end

AceLibrary:Register(BabbleClass, MAJOR_VERSION, MINOR_VERSION)
BabbleClass = nil
