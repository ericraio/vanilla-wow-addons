local L = AceLibrary("AceLocale-2.0"):new("FuBar_DurabilityFu")

L:RegisterTranslations("enUS", function() return {
	["Total"] = true,
	["Percent"] = true,
	["Repair cost"] = true,
	["Repair"] = true,
	["Equipment"] = true,
	["Inventory"] = true,
	["Show repair popup at vendor"] = true,
	["Toggle whether to show the popup at the merchant window"] = true,
	["Show the armored man"] = true,
	["Toggle whether to show Blizzard's armored man"] = true,
	["Show average value"] = true,
	["Toggle whether to show your average or minimum durability"] = true,
	["Show healthy items"] = true,
	["Toggle whether to show items that are healthy (100% repaired)"] = true,
	["Auto repair"] = true,
	
	["AceConsole-Commands"] = {"/durfu", "/durabilityfu"}
} end)