KC_ITEMS_LOCALS.modules.inventory = {}
local locals = KC_ITEMS_LOCALS.modules.inventory

if( not ace:LoadTranslation("KC_Inventory") ) then

locals.name			= "KC_Inventory"
locals.description	= "Keeps Track of Inventory Data"

-- Chat handler locals
locals.chat = {
	option	= "inventory",
	desc	= "Inventory related commands.",
	args	= {
			{
				option = "save",
				desc   = "Force saves inventory data.",
				method = "SaveInv"
			},
        },  
}

end
