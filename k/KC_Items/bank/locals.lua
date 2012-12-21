KC_ITEMS_LOCALS.modules.bank = {}
local locals = KC_ITEMS_LOCALS.modules.bank

if( not ace:LoadTranslation("KC_Bank") ) then

locals.name			= "KC_Bank"
locals.description	= "Keeps Track of Bank Data"

locals.msgs = {}
locals.msgs.nodata = "There is no bank data for %s."

-- Chat handler locals
locals.chat = {
	option	= "bank",
	desc	= "Bank related commands.",
	args	= {
			{
				option = "save",
				desc   = "Force saves bank data.",
				method = "SaveBank"
			},
        },  
}

end
