KC_ITEMS_LOCALS.modules.iteminfo = {}
local locals = KC_ITEMS_LOCALS.modules.iteminfo

if( not ace:LoadTranslation("KC_ItemInfo") ) then

locals.name			= "KC_ItemInfo"
locals.description	= "Displays info regarding an item."

locals.maxstack		= "|cff33aaffMax stack size of (|r%s|cff33aaff)"

-- Chat handler locals
locals.chat = {
	option	= "iteminfo",
	desc	= "Commands relating to the showing of info on an item. ",
	args	= {
        },  
}

end
