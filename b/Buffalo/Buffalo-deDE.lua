-- ü: \195\188
-- ä: \195\164
-- ö: \195\182
-- ß: \195\159

local L = AceLibrary("AceLocale-2.2"):new("Buffalo")

L:RegisterTranslations("deDE", function()
    return {
    	["Lock"] = "Lock",
    	["When activated, the buff frames are locked and the reference frames are hidden"] = "Die Buff Anzeigen sind beweglich, wenn deaktiviert. Zur Referenz werden die Positionen der einzelnen Buffs angezeigt.",
    	["Buffs"] = "Buffs",
    	["Scale"] = "Skalieren",
    	["Scale Buff Icons"] = "Skaliert die Buff Anzeigen",
    	["Rows"] = "Reihen",
    	["Number of Rows. Only applies when Growth Precedence is Vertical"] = "Anzahl der Reihen. Wirkt nur, wenn Erste Richtung  \"Vertikal\" ist",
    	["Columns"] = "Spalten",
    	["Number of Columns. Only applies when Growth Precedence is Horizontal"] = "Anzahl der Spalten. Wirkt nur, wenn Erste Richtung  \"Horizontatl\" ist",
    	["X-Padding"] = "X-Abstand",
    	["Distance between columns"] = "Abstand zwischen Spalten",
    	["Y-Padding"] = "Y-Abstand",
    	["Distance between rows"] = "Abstand zwischen Reihen",
    	["Horizontal Direction"] = "Horzontale Richtung",
    	["In which horizontal direction should the display grow?"] = "In welche Richtung sollen die Buffs horizontal wachsen?",
    	["To the left"] = "Nach Links",
    	["To the right"]="Nach Rechts",
    	["Vertical Direction"] = "Vertikale Richtung",
    	["In which vertical direction should the display grow?"] = "In welche Richtung sollen die Buffs vertikal wachsen?",
    	["Upwards"] = "Aufw\195\164rts",
		["Downwards"] = "Abw\195\164rts",
		["Growth Precedence"] = "Erste Richtung",
		["In which direction should the display grow first (horizontally or vertically)?"] = "In welche Richtung sollen die Buffs zuerst wachsen (horizontal/vertikal)?",
		["Horizontally"] = "Horizontal",
		["Vertically"] = "Vertikal",
-------------------------------------------------------------------------- 15:44
		["Manipulate Buffs Display"] = "Buff Anzeige ver\195\164ndern",
		["Control the distance between rows/columns"] = "Abst\195\164nde zwischen Reihen und Spalten ver\195\164ndern",
		["Padding"] = "Abst\195\164nde",
		["Debuffs"] = "Debuffs",
		["Manipulate Debuffs Display"] = "Debuff Anzeige ver\195\164ndern",
		["Scale Debuff Icons"] = "Skaliert die Debuff Anzeigen",
		["Weapon Buffs"] = "Waffenbuffs",
		["Manipulate Weapon Buffs Display"] ="Waffenbuff Anzeige ver\195\164ndern",
		["Reset"] = "Reset",
---------------------------------------------------------------------------
		["Hide"] = "Verstecken",
		["Hides these buff frames"] = "Versteckt diese Buff Anzeigen",
		["Verbose Timers"] = "Ausf\195\188hrliche Zeit",
		["Replaces the default time format for timers with HH:MM or MM:SS"] = "Ersetzt das normale Zeitfromat f\195\188r die Anzeige durch HH:MM bzw. MM:SS",
-------------------------------------------------------
		["Flashing"] = "Blinken",
		["Toggle flashing on fading buffs"] = "Blinken von auslaufenden Buffs an-/ausschalten",
		["Timers"] = "Zeitanzeige",
		["Customize buff timers"] = "Zeitanzeige einstellen",
		["White Timers"] = "Wei\195\159e Anzeige",
		["Use white timers instead of yellow ones"] = "Wei\195\159e Schrift statt der normalen gelben benutzen",
-----------------------------------------------------------

    }
end)
