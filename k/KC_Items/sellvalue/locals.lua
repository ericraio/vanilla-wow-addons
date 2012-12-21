KC_ITEMS_LOCALS.modules.sellvalue = {}
local locals = KC_ITEMS_LOCALS.modules.sellvalue

if( not ace:LoadTranslation("KC_SellValue") ) then

locals.name			= "KC_SellValue"
locals.description	= "Remembers vendor buy and sell prices."

locals.sep = "-"
locals.sepcolor = "|cffffff78"

locals.labels = {}
locals.labels.sell = {}
locals.labels.sell.short = "|cffffff78Sells (|r%s|cffffff78)|r"
locals.labels.sell.long  = "|cffffff78Vendor pays (|r%s|cffffff78)|r"
locals.labels.buy = {}
locals.labels.buy.short  = "|cffffff78Buys (|r%s|cffffff78)|r"
locals.labels.buy.long   = "|cffffff78Vendor charges (|r%s|cffffff78)|r"
locals.labels.each = "|cffff3333(each)|r"

locals.msg = {}
locals.msg.short = "Short display mode"

-- Chat handler locals
locals.chat = {
	option	= "sellvalue",
	desc	= "Functions relating to remembering buy and sell prices.",
	args	= {
		{
			option = "single",
			desc   = "Toggles display of the single price.",
			method = "single"
		},
		{
			option = "short",
			desc   = "Toggles use of the short display mode.",
			method = "short"
		},
    },  
}

end
