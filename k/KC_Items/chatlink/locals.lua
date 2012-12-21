KC_ITEMS_LOCALS.modules.chatlink = {}
local locals = KC_ITEMS_LOCALS.modules.chatlink

if( not ace:LoadTranslation("KC_ChatLink") ) then

locals.name			= "KC_ChatLink"
locals.description	= "Allows in line chatlinking."

locals.msg = {}
locals.msg.mode	= "KC_Chatlink is"

locals.map		= {[0]="|cffff5050Standard Mode|r",[1]="|cff00ff00Safe Mode|r"}

-- Chat handler locals
locals.chat = {
	option	= "chatlink",
	desc	= "Commands relating to the showing of info on an item. ",
	args	= {
		{
			option = "mode",
			desc   = "Toggles between standard and safe mode",
			method = "mode"
		},
	},  
}

end
