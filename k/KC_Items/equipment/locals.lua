KC_ITEMS_LOCALS.modules.equipment = {}
local locals = KC_ITEMS_LOCALS.modules.equipment

if( not ace:LoadTranslation("KC_Equipment") ) then

locals.name			= "KC_Equipment"
locals.description	= "Keeps Track of Equipment Data"

-- Chat handler locals
locals.chat = {
	option	= "equipment",
	desc	= "Equipment related commands.",
	args	= {
        },  
}

end
