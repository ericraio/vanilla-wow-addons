local L = AceLibrary("AceLocale-2.2"):new("FuBar_ToFu")

L:RegisterTranslations("enUS", function() return {
	["Current Flight"] = true,
	["Previous Flight"] = true,

	["From"] = true,
	["To"] = true,
	["Cost"] = true,
	["Time Taken"] = true,
	["Average Time"] = true,

	["Not in flight"] = true,
	["No previous flight"] = true,
	
	["Click to copy the time remaining in flight to the chatbox."] = true,
	
	["Takes"] = true,
	["Flown %s times"] = true,
	
	["Data"] = true,
	["Various options to do with saved flight data"] = true,
	
	['Default Data'] = true,
	["Load the default flight-time dataset."] = true,
	
	["Delete *ALL* saved flight path data for your faction."] = true,
	["Clear Data"] = true,
	
	["Hooks"] = true,
	["Other addons to hook into"] = true,
	
	["estimated"] = "(est)",
	["reversed"] = "(rev)",
	["So Far"] = true,
} end)
