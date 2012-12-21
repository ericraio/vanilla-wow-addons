MYACEPERC = {}
-- The ace:LoadTranslation() method looks for a specific translation function for
-- the addon. If it finds one, that translation is loaded. See AceHelloLocals_xxXX.lua
-- for an example and description of function naming.
function MyAcePerc_Locals_frFR()

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
        desc   = "Afficher en % de mana total",
        method = "TotalMana"
    },
    {
    	option = "current",
    	desc   = "Afficher en % de mana disponible ",
    	method = "CurrentMana"
    },
    {
    	option = "colour",
    	desc   = "Colour code tooltip info (Green=Current, Yellow=Total)",
    	method = "Colour"
    }
}

MYACEPERC.TOTAL_MSG = "MyPercentage calcule maintenant par rapport \195\160 votre mana TOTAL:"
MYACEPERC.CURNT_MSG = "MyPercentage calcule maintenant par rapport \195\160 votre mana DISPONIBLE:"
MYACEPERC.COLOR_MSG = "MyAcePercentage displaying colours:"

end

	