KC_ITEMS_LOCALS.modules.linknet = {}
local locals = KC_ITEMS_LOCALS.modules.linknet

if( not ace:LoadTranslation("KC_Linknet") ) then

locals.name			= "KC_Linknet"
locals.description	= "Gathers item links"

-- Chat handler locals
locals.chat = {
	option	= "linknet",
	desc	= "Active link gathering related commands.",
	args	= {},  
}

end
