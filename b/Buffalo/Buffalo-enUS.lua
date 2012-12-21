local L = AceLibrary("AceLocale-2.2"):new("Buffalo")

L:RegisterTranslations("enUS", function()
    return {
    	["Lock"] = true,
    	["When activated, the buff frames are locked and the reference frames are hidden"] = true,
    	["Buffs"] = true,
    	["Scale"] = true,
    	["Scale Buff Icons"] = true,
    	["Rows"] = true,
    	["Number of Rows. Only applies when Growth Precedence is Vertical"] = true,
    	["Columns"] = "Columns",
    	["Number of Columns. Only applies when Growth Precedence is Horizontal"] = true,
    	["X-Padding"] = true,
    	["Distance between columns"] = true,
    	["Y-Padding"] = true,
    	["Distance between rows"] = true,
    	["Horizontal Direction"] = true,
    	["In which horizontal direction should the display grow?"] = true,
    	["To the left"] = true,
    	["To the right"]=true,
    	["Vertical Direction"] = true,
    	["In which vertical direction should the display grow?"] = true,
    	["Upwards"] = true,
		["Downwards"] = true,
		["Growth Precedence"] = true,
		["In which direction should the display grow first (horizontally or vertically)?"] = true,
		["Horizontally"] = true,
		["Vertically"] = true,
------------------------------------------------------ 15:44
		["Manipulate Buffs Display"] = true,
		["Control the distance between rows/columns"] = true,
		["Padding"] = true,
		["Debuffs"] = true,
		["Manipulate Debuffs Display"] = true,
		["Scale Debuff Icons"] = true,
		["Weapon Buffs"] = true,
		["Manipulate Weapon Buffs Display"] = true,
		["Reset"] = true,
----------------------------------------------------
		["Hide"] = true,
		["Hides these buff frames"] = true,
		["Verbose Timers"] = true,
		["Replaces the default time format for timers with HH:MM or MM:SS"] = true,
-------------------------------------------------------
		["Flashing"] = true,
		["Toggle flashing on fading buffs"] = true,
		["Timers"] = true,
		["Customize buff timers"] = true,
		["White Timers"] = true,
		["Use white timers instead of yellow ones"] = true,
----------------------------------------------------
		["config"] = true,
		["Config"] = true,
-----------------------------------------------------------
    }
end)
