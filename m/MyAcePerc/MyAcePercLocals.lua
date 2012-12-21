
-- The ace:LoadTranslation() method looks for a specific translation function for
-- the addon. If it finds one, that translation is loaded. See AceHelloLocals_xxXX.lua
-- for an example and description of function naming.
if( not ace:LoadTranslation("MyAcePerc") ) then

ace:RegisterGlobals({
	version	= 1.01
})


-- All text inside quotes is translatable, except for 'method' lines.
MYACEPERC.DESCRIPTION	= "Mypercentage - Addon to show %-of-mana cost in tooltip for spells"
MYACEPERC.STATUS		= "MyPercentage Display mode : "

-- Chat handler locals
MYACEPERC.COMMANDS		= {"/myperc"}
MYACEPERC.CMD_OPTIONS	= {
    {
		option = "total",
        desc   = "Displays % mana cost based on total mana",
        method = "TotalMana"
    },
    {
    	option = "current",
    	desc   = "Displays % mana cost based on current mana",
    	method = "CurrentMana"
    },
    {
    	option = "colour",
    	desc   = "Colour code tooltip info (Green=Current, Yellow=Total)",
    	method = "Colour"
    }    
}

MYACEPERC.TOTAL_MSG = "MyAcePercentage tracking your total mana:"
MYACEPERC.CURNT_MSG = "MyAcePercentage tracking your current mana:"
MYACEPERC.COLOR_MSG = "MyAcePercentage displaying colours:"

end	