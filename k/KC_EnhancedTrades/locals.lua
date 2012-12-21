-- $Id: locals.lua 2106 2006-05-24 03:47:06Z kaelten $
KC_ET_LOCALS = {}

local locals = KC_ET_LOCALS

if( not ace:LoadTranslation("KC_EnhancedTrades") ) then

locals.name			= "KC_EnhancedTrades"
locals.description	= "Enhances the trade skill window."

locals.buyable		= "[Buyable]"

locals.hints = {
	[0] = "Toggles KC_EnhancedTrades",
	[1] = "Toggles the display of the legend in the title bar.",
	[2] = "Toggles the usage of smart display.",
	[3] = "Toggles the display of Inv + Vendor numbers.",
	[4] = "Toggles the display of Inv + Bank numbers.",
	[5] = "Toggles the display of Inv + Vendor + Bank numbers.",
	[6] = "Toggles the display of Inv + Vendor + Bank + Alts numbers.",
}

locals.titles = {
	[0] = "KC_EnhancedTrades",
	[1] = "Legend",
	[2] = "Smart Display",
	[3] = "Inv + Vendor",
	[4] = "Inv + Bank",
	[5] = "Inv + Vendor + Bank",
	[6] = "Inv Vendor Bank + Alts",
}

-- Chat handler locals
locals.chat = {
	option	= "trades",
	desc	= "Enhanced trades related commands.",
	args	= {
        },  
}

end