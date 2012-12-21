local L = AceLibrary("AceLocale-2.0"):new("FuXP")

L:RegisterTranslations("enUS", function() return {
	["AceConsole-commands"] = { "/FuXPFu" },

	["Current XP"] = true,
	["Sets the color of the XP Bar"] = true,

	["Rested XP"] = true,
	["Sets the color of the Rested Bar"] = true,

	["No XP"] = true,
	["Sets the empty color of the XP Bar"] = true,

	["Spark intensity"] = true,
	["Brightness level of Spark"] = true,

	["Thickness"] = true,
	["Sets thickness of XP Bar"] = true,

	["Shadow"] = true,
	["Toggles Shadow under XP Bar"] = true,

	["Remaining"] = true,
	["Show Remaining in Bar"] = true,

	["%s:%s %3.0f%% left (%s/%s)"] = true,
	["%s to go (%3.0f%%)"] = true,

	["Current XP"] = true,
	["To Level"] = true,
	["Rested XP"] = true,
	["Click to send your current xp to an open editbox."] = true,
	["Faction"] = true,
	["Rep to next standing"] = true,
	["Current rep"] = true,
	["Click to send your current rep to an open editbox."] = true,

	["%s/%s (%3.0f%%) %d to go"] = true,
	["%s:%s/%s (%3.2f%%) Currently %s with %d to go"] = true,
} end)