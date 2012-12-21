KC_ITEMS_LOCALS.modules.tooltip = {}
local locals = KC_ITEMS_LOCALS.modules.tooltip

if( not ace:LoadTranslation("KC_Tooltip") ) then

locals.name			= "KC_Tooltip"
locals.description	= "Tooltip Hooking Functions"

locals.msg = {}
locals.msg.separated		= "Separated tooltip"
locals.msg.separator		= "Separator lines"
locals.msg.splitting		= "Splitting of lines"
locals.msg.moneyframe		= "Usage of Money Frames"

-- Chat handler locals
locals.chat = {
	option	= "tooltip",
	desc	= "Tooltip related commands.",
	args	= {
		{
			option = "mode",
			desc   = "Toggles tooltip mode between merged and separated.",
			method = "modeswitch"
		},
		{
			option = "separator",
			desc   = "Toggles wether to include seperator lines.",
			method = "separatortog"
		},
		{
			option = "splitline",
			desc   = "Toggles wether to use the split line display.",
			method = "splitline"
		},
		{
			option = "moneyframe",
			desc   = "Toggles wether to use the money frame in the tooltip.",
			method = "moneyframe"
		}
       },  
}

end
