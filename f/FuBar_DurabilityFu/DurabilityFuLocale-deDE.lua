local L = AceLibrary("AceLocale-2.0"):new("FuBar_DurabilityFu")

L:RegisterTranslations("deDE", function() return {
	["Total"] = "Gesamt",
	["Percent"] = "Prozent",
	["Repair cost"] = "Reparaturkosten",
	["Repair"] = "Reparatur",
	["Equipment"] = "Ausr\195\188stung",
	["Inventory"] = "Inventar",
	["Show repair popup at vendor"] = "Reparaturfenster beim H\195\164ndler anzeigen",
	["Toggle whether to show the popup at the merchant window"] = "Anzeige des Reparaturfensters beim Händler ein/ausschalten",
	["Show the armored man"] = "Ausr\195\188stungsfigur anzeigen",
	["Toggle whether to show Blizzard's armored man"] = "Anzeige der Ausr\195\188stungsfigur ein/ausschalten",
	["Show average value"] = "Mittelwert anzeigen",
	["Toggle whether to show your average or minimum durability"] = "Anzeige zwischen mittlerer oder minimaler Haltbarkeit umschalten",
	["Show healthy items"] = "Unbesch\195\164digte Gegenst\195\164nde anzeigen",
	["Toggle whether to show items that are healthy (100% repaired)"] = "Anzeige unbesch\195\164digter Gegenst\195\164nde ein/ausschalten",
	["Auto repair"] = "Automatisch reparieren",
	
	["AceConsole-Commands"] = {"/durfu", "/durabilityfu"}
} end)