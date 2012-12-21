KC_ITEMS_LOCALS.modules.common = {}
local locals = KC_ITEMS_LOCALS.modules.common

if( not ace:LoadTranslation("KC_Common") ) then
	
	locals.hex = {0,1,2,3,4,5,6,7,8,9,"a","b","c","d","e","f"}

	locals.name			= "KC_Common"
	locals.description	= "Common code and utilities"
	
	locals.err = {}
	locals.err.badcode = "Invalid code passed to function"

	locals.money = {}

	locals.money.gold = {}
	locals.money.gold.color		=  "|cffffd700"
	locals.money.gold.letter	= "g"
	locals.money.gold.word		= "gold"
	
	locals.money.silver = {}
	locals.money.silver.color	=  "|cffc7c7cf"
	locals.money.silver.letter	= "s"
	locals.money.silver.word	= "silver"
	
	locals.money.copper= {}
	locals.money.copper.color	=  "|cffeda55f"
	locals.money.copper.letter	= "c"
	locals.money.copper.word	= "copper"

	locals.of = " of "
end
